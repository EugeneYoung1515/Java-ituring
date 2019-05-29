package com.example.demo.serviceImpl;

import com.example.demo.dao.*;
import com.example.demo.extmodel.BookExt;
import com.example.demo.extmodel.CategoryExt;
import com.example.demo.model.*;
import com.example.demo.service.BookService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.ZParams;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.TimeUnit;

@Service
public class BookServiceImpl implements BookService{

    private BookMapper bookMapper;
    private PublishInfoMapper publishInfoMapper;
    private CategoryMapper categoryMapper;
    private SeriesMapper seriesMapper;
    private AlsoLikeMapper alsoLikeMapper;
    private BooktagMapper booktagMapper;
    private FavBookUserMapper favBookUserMapper;
    private VoteBookUserMapper voteBookUserMapper;

    private RedisTemplate<String,BookExt> redisTemplateBookExt;

    private RedisTemplate<String,Book> redisTemplateBook;//1

    private RedisTemplate<String,String> redisTemplateStat;//2 //1和2最常用

    private RedisTemplate<String,Page<BookExt>> redisTemplatePage;

    private RedisTemplate<String,CategoryExt> redisTemplateCategoryExt;

    private RedisTemplate<String,Category> redisTemplateCategory;

    //自己命名比较乱的地方
    //redis命名 jsp命名

    //应该可以用注解和AOP复用代码
    //考虑 redis缓存 的 redisTemplate选择 数据结构选择 命名 过期时间

    @Scheduled(fixedRate = 90000,initialDelay = 1000)
    //@Scheduled(cron = "0 0 0 */7 * *")//7天似乎要和redisTemplateBookExt.opsForValue().set("bookExt:"+bookId,bookExt,7,TimeUnit.DAYS);中的7天一致
    public void rescaleViewed(){
        redisTemplateStat.opsForZSet().removeRange("view:",0,-500);
        //少了一个分数减半的过程

        //这一个成功了
        redisTemplateStat.execute(new RedisCallback<Long>() {
            @Override
            public Long doInRedis(RedisConnection redisConnection) throws DataAccessException {
                Jedis jedis = (Jedis)redisConnection.getNativeConnection();
                ZParams zParams= new ZParams();
                zParams.weightsByDouble(0.5).aggregate(ZParams.Aggregate.MIN);
                return jedis.zinterstore("view:".getBytes(),zParams,"view:".getBytes());
            }
        },true);
        System.out.println("Scheduled");
    }

    public Book getBook(Integer bookId){
        /*
        HashOperations<String, String, BookExt> hashOperations =  redisTemplateBookExt.opsForHash();
        BookExt obj = (BookExt)hashOperations.get("bookExt",bookId+"");
        if(obj!=null){
            return obj;
        }
        HashOperations<String, String, Book> hashOperations2 =  redisTemplateBook.opsForHash();
        Book obj2 = (Book)hashOperations2.get("book",bookId+"");
        if(obj2!=null){
            return obj2;
        }
        */
        Book book = bookMapper.selectByPrimaryKey(bookId);
        //hashOperations2.put("book",bookId+"",book);
        return book;
    }

    public BookExt getBookExt2(Integer bookId){
        return bookMapper.selectBookWithSeriesByPrimaryKey(bookId);
    }

    public BookExt getBookExt(Integer bookId){
        redisTemplateStat.opsForZSet().incrementScore("view:",bookId+"",-1);
        int rank =redisTemplateStat.opsForZSet().rank("view:",bookId+"").intValue();
        if(rank<250) {

            //HashOperations<String, String, BookExt> hashOperations =  redisTemplateBookExt.opsForHash();
            //BookExt obj = (BookExt)hashOperations.get("bookExt",bookId+"");
            BookExt obj = redisTemplateBookExt.opsForValue().get("bookExt:" + bookId);
            if (obj != null) {
                obj.setBookVote(bookMapper.selectBookVoteByBookId(bookId));
                return obj;
            }
        }

        BookExt bookExt = bookMapper.selectBookWithSeriesByPrimaryKey(bookId);
        //System.out.println(bookExt.getBookDate());
        bookExt.setCategory(bookMapper.selectBookWithCategoryByPrimaryKey(bookId).getCategory());
        bookExt.setAlsoLike(bookMapper.selectBookWithAlsoLikeByPrimaryKey(bookId).getAlsoLike());
        bookExt.setCatalogs(bookMapper.selectBookWithCatalogByPrimaryKey(bookId).getCatalogs());
        bookExt.setOriginalAuthors(bookMapper.selectBookWithOriginalAuthorByPrimaryKey(bookId).getOriginalAuthors());
        bookExt.setTranslatorAuthors(bookMapper.selectBookWithTranslatorAuthorByPrimaryKey(bookId).getTranslatorAuthors());
        bookExt.setBooktags(bookMapper.selectBookWithBooktagByPrimaryKey(bookId).getBooktags());
        PublishInfo publishInfo = publishInfoMapper.selectByBookId(bookId);
        bookExt.setPublishInfo(publishInfo);

        //hashOperations.put("bookExt",bookId+"",bookExt);//这里不好过期
        redisTemplateBookExt.opsForValue().set("bookExt:"+bookId,bookExt,7,TimeUnit.DAYS);
        return bookExt;
    }

    //缓存策略
    //进入数 日期更新 90天进入数 每10次从缓存更新到数据库
    public void updateEnterNum(BookExt bookExt){
        HashOperations<String,String,String> hashOperations = redisTemplateStat.opsForHash();
        String count = hashOperations.get("stat:"+bookExt.getBookId(),"count");
        if(count!=null){
            int enterNum = hashOperations.increment("stat:"+bookExt.getBookId(),"enterNum",1).intValue();
            bookExt.setBookEnterNum(enterNum);
            Date date = null;
            try {
                date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss SSS").parse(hashOperations.get("stat:" + bookExt.getBookId(), "modifiedDate"));
            }catch (ParseException ex){
                ex.printStackTrace();
            }
            compareDate(bookExt,date,new Date(),hashOperations);

            hashOperations.put("stat:"+bookExt.getBookId(),"modifiedDate",new SimpleDateFormat("yyyy-MM-dd HH:mm:ss SSS").format(bookExt.getModifiedDate()));
        }else{
            bookExt.setBookEnterNum(bookExt.getBookEnterNum()+1);

            Date date = bookExt.getModifiedDate();
            Date date1 = new Date();

            compareDate(bookExt,date,date1,hashOperations);

            hashOperations.put("stat:"+bookExt.getBookId(), "enterNum",bookExt.getBookEnterNum()+"");
            hashOperations.put("stat:"+bookExt.getBookId(),"ninetyBookEnterNum",bookExt.getNinetyBookEnterNum()+"");
            hashOperations.put("stat:"+bookExt.getBookId(),"modifiedDate",new SimpleDateFormat("yyyy-MM-dd HH:mm:ss SSS").format(bookExt.getModifiedDate()));

            //这里不好过期
        }

        int updateCount = hashOperations.increment("stat:"+bookExt.getBookId(),"count",1).intValue();
        if(updateCount%10==0){
            bookMapper.updateByPrimaryKeySelective(bookExt);
            //System.out.println("mmmm"+bookExt.getNinetyBookEnterNum()+"mmmm");
        }
    }

    private void compareDate(BookExt bookExt,Date date,Date date1,HashOperations<String,String,String> hashOperations){
        long from1 = date.getTime();
        long to1 = date1.getTime();
        int days = (int) ((to1 - from1) / (1000 * 60 * 60 * 24));
        if(days<90) {
            bookExt.setNinetyBookEnterNum(hashOperations.increment("stat:"+bookExt.getBookId(),"ninetyBookEnterNum",1).intValue());
        }else {
            hashOperations.put("stat:"+bookExt.getBookId(),"ninetyBookEnterNum","1");
            bookExt.setNinetyBookEnterNum(1);
        }
        bookExt.setModifiedDate(date1);
    }

    public List<BookExt> getSameSeriesBooks(Integer seriesId,Integer bookId){
        //return bookMapper.selectBookWithOriginalTranslatorBySeriesId(seriesId,bookId);

        List<BookExt> bookExtList = redisTemplateBookExt.opsForList().range("seriesId:bookExt:"+seriesId,0,-1);
        if(bookExtList!=null&&bookExtList.size()>0){
            Iterator<BookExt> iterator = bookExtList.iterator();
            while (iterator.hasNext()){
                BookExt bookExt = iterator.next();
                if(bookExt.equals(bookId)){
                    iterator.remove();
                }

            }
            return bookExtList;
        }
        PageHelper.startPage(1,5);
        bookExtList = bookMapper.selectBookWithOriginalTranslatorBySeriesId2(seriesId,bookId);
        redisTemplateBookExt.opsForList().leftPushAll("seriesId:bookExt:"+seriesId,bookExtList);
        /*
        com.fasterxml.jackson.databind.JsonMappingException: No serializer found for class org.apache.ibatis.reflection.factory.DefaultObjectFactory and no properties discovered to create BeanSerializer (to avoid exception, disable SerializationFeature.FAIL_ON_EMPTY_BEANS) (through reference chain: com.example.demo.extmodel.BookExt_$$_jvstd5c_0["handler"]->org.apache.ibatis.executor.loader.javassist.JavassistProxyFactory$EnhancedResultObjectProxyImpl["objectFactory"])
mybatis的懒加载生效了
         */
        //把BookMapper哪里的懒加载取消了
        redisTemplateBookExt.opsForList().leftPush("seriesId:bookExt:"+seriesId,getBookExt(bookId));
        redisTemplateBookExt.expire("seriesId:bookExt:"+seriesId,3, TimeUnit.DAYS);
        return bookExtList;
    }

    public List<BookExt> getSameLikeBooks(Integer alsoLikeId,Integer bookId){

        List<BookExt> bookExtList = redisTemplateBookExt.opsForList().range("alsoLikeId:bookExt:"+alsoLikeId,0,-1);

        if(bookExtList!=null&&bookExtList.size()>0){
            Iterator<BookExt> iterator = bookExtList.iterator();
            while (iterator.hasNext()){
                BookExt bookExt = iterator.next();
                if(bookExt.equals(bookId)){
                    iterator.remove();
                }

            }
            return bookExtList;
        }

        bookExtList = bookMapper.selectBookWithOriginalTranslatorByAlsoLikeId(alsoLikeId,bookId);
        redisTemplateBookExt.opsForList().leftPushAll("alsoLikeId:bookExt:"+alsoLikeId,bookExtList);
        redisTemplateBookExt.opsForList().leftPush("alsoLikeId:bookExt:"+alsoLikeId,getBookExt(bookId));
        redisTemplateBookExt.expire("alsoLikeId:bookExt:"+alsoLikeId,3, TimeUnit.DAYS);
        return bookExtList;
    }

    public CategoryExt getCategoryWithAllParent(Integer categoryId){
        CategoryExt categoryExt = redisTemplateCategoryExt.opsForValue().get("categoryExt:"+categoryId);
        if(categoryExt!=null){
            return categoryExt;
        }
        categoryExt = categoryMapper.selectCategoryWithAllParentByPrimaryKey(categoryId);
        redisTemplateCategoryExt.opsForValue().set("categoryExt:"+categoryId,categoryExt,7,TimeUnit.DAYS);
        return categoryExt;
    }

    public List<Series> getAllSeries(){
        return seriesMapper.selectAllSeries();
    }

    public List<AlsoLike> getAllAlsoLike(){
        return alsoLikeMapper.selectAllAlsoLike();
    }

    //这个要不要缓存
    //
    public List<Booktag> getMainPageTags(){
        return booktagMapper.selectMainPageTags();
    }

    //这一个是给预售用的
    public List<BookExt> getSameTagBooks(Integer booktagId){
        List<BookExt> bookExtList = redisTemplateBookExt.opsForList().range("presell:booktagId:bookExt:"+booktagId,0,-1);
        //System.out.println("booktagId:BookExt:"+booktagId+" success");
        if(bookExtList!=null&& !bookExtList.isEmpty()){
            return bookExtList;
        }

        bookExtList = bookMapper.selectBookWithOriginalTranslatorByBooktagId(booktagId);//核心是这句 其他都是缓存相关的
        redisTemplateBookExt.opsForList().leftPushAll("presell:booktagId:bookExt:"+booktagId,bookExtList);
        redisTemplateBookExt.expire("presell:booktagId:bookExt:"+booktagId,3, TimeUnit.DAYS);
        return bookExtList;
    }

    public List<BookExt> getHottestBooks(Integer limit){
        List<BookExt> bookExtList = redisTemplateBookExt.opsForList().range("hottestBooks",0,-1);
        if(bookExtList!=null&& !bookExtList.isEmpty()){
            return bookExtList;
        }
        bookExtList = bookMapper.selectBookWithOriginalTranslatorOrderByBookEnterNum(limit);
        redisTemplateBookExt.opsForList().leftPushAll("hottestBooks",bookExtList);
        redisTemplateBookExt.expire("hottestBooks",3, TimeUnit.DAYS);
        return bookExtList;
    }

    public Page<BookExt> getBooksByCondition(String tab, String sort, Integer grade, Integer category, Integer page,Integer userId){
        //一直错误的原因 方法参数位置放错了

        if(tab.equals("fav")){
            Page<BookExt> bookExtList = (Page<BookExt>)redisTemplatePage.opsForValue().get(tab+":"+sort+":"+category+":"+page+":"+userId);
            if(bookExtList!=null && !bookExtList.isEmpty()){
                String[] stat = redisTemplateStat.opsForValue().get(tab+":"+sort+":"+category+":"+page+":"+userId+":stat").split(":");
                bookExtList.setPageNum(Integer.parseInt(stat[0])).setPageSize(Integer.parseInt(stat[1])).setTotal(Long.parseLong(stat[2]));
                return bookExtList;
            }
        }else{
            Page<BookExt> bookExtList = (Page<BookExt>) redisTemplatePage.opsForValue().get(tab + ":" + sort + ":" + category + ":" + page);
            if (bookExtList != null && !bookExtList.isEmpty()) {
                String[] stat = redisTemplateStat.opsForValue().get(tab + ":" + sort + ":" + category + ":" + page + ":" + "stat").split(":");
                bookExtList.setPageNum(Integer.parseInt(stat[0])).setPageSize(Integer.parseInt(stat[1])).setTotal(Long.parseLong(stat[2]));
                return bookExtList;
            }
        }

        PageHelper.startPage(page,3);

        //System.out.println(bookMapper.findByName(1).getBookIntro());
        Condition condition = new Condition();
        //System.out.println(sort+" "+tab+" "+category);
        if(sort.equals("new")){
            condition.setSortNew(11);
        }
        if(sort.equals("hot")){
            System.out.println(sort);
            condition.setSortHot(11);
        }
        if(sort.equals("vote")){
            condition.setSortVote(11);
        }
        if(tab.equals("book")){
            condition.setTabBook(11);
        }
        if(tab.equals("ebook")){
            condition.setTabEbook(11);
        }
        if(tab.equals("free")){
            condition.setTabFree(11);
        }
        if(tab.equals("translator")){
            condition.setTabTranslator(11);
        }
        if(tab.equals("soon")){
            condition.setTabSoon(11);
        }
        if(tab.equals("90vote")){
            condition.setNinetyVote(11);
            Date date = new Date();
            long now = date.getTime();
            Date newDate = new Date(now-90*1000 * 60 * 60 * 24);
            condition.setDate(newDate);
        }
        if(tab.equals("fav")){
            condition.setTabFav(11);
            if(userId!=null) {
                List<Integer> favList = bookMapper.selectBookIdByUserId(userId);
                favList.add(-1);
                condition.setFavList(favList);
            }else{
                List<Integer> favList  = new ArrayList<Integer>();
                favList.add(-1);
                condition.setFavList(favList);
            }
        }
        if(grade!=null){
            int grade1=grade;
            if(grade1==1){
                condition.setGrade1(category);
            }
            if(grade1==2){
                condition.setGrade2(category);
            }
            if(grade1==3){
                condition.setGrade3(category);
            }
        }

        Page<BookExt> bookExtPage = bookMapper.selectBookWithOriginalTranslatorOrderByCondition2(condition);
        String keyName = tab+":"+sort+":"+category+":"+page;
        if(tab.equals("fav")){
            redisTemplatePage.opsForValue().set(keyName+":"+userId,bookExtPage);
            redisTemplateBookExt.expire(keyName+":"+userId,3, TimeUnit.DAYS);

            redisTemplateStat.opsForList().leftPush("fav:"+userId,keyName+":"+userId);//这里不好过期

            redisTemplateStat.opsForValue().set(keyName+":"+userId+":stat",bookExtPage.getPageNum()+":"+bookExtPage.getPageSize()+":"+bookExtPage.getTotal());
            redisTemplateBookExt.expire(keyName+":"+userId+":stat",3, TimeUnit.DAYS);
        }else {
            redisTemplatePage.opsForValue().set(keyName, bookExtPage);
            redisTemplateBookExt.expire(keyName,3, TimeUnit.DAYS);

            redisTemplateStat.opsForValue().set(keyName+":stat",bookExtPage.getPageNum()+":"+bookExtPage.getPageSize()+":"+bookExtPage.getTotal());
            redisTemplateBookExt.expire(keyName+":stat",3, TimeUnit.DAYS);
        }
        return bookExtPage;
        //使用注解方式形成动态sql也行
    }

    //这个要不要缓存
    //
    public List<Booktag> getAllTags(){
        return booktagMapper.selectAllTags();
    }

    //这一个是给任意标签用的
    //上面的getSameTagBooks是给预售用的
    public Page<BookExt> getSameTagBooks2(Integer booktagId,Integer page){//上面有一个1
        Page<BookExt> bookExtList= redisTemplatePage.opsForValue().get("booktagId:bookExt:"+booktagId+":"+page);
        if(bookExtList!=null && !bookExtList.isEmpty()){
            String[] stat = redisTemplateStat.opsForValue().get("booktagId:bookExt:"+booktagId+":"+page+":stat").split(":");
            bookExtList.setPageNum(Integer.parseInt(stat[0])).setPageSize(Integer.parseInt(stat[1])).setTotal(Long.parseLong(stat[2]));
            return bookExtList;
        }

        PageHelper.startPage(page,3);
        Page<BookExt> bookExtPage = bookMapper.selectBookWithOriginalTranslatorOrderByTag(booktagId);//调用的这个没有通过join拿到作者和译者的信息 是通过select拿到作者和译者信息的

        redisTemplatePage.opsForValue().set("booktagId:bookExt:"+booktagId+":"+page,bookExtPage);
        redisTemplateBookExt.expire("booktagId:bookExt:"+booktagId+":"+page,3, TimeUnit.DAYS);

        redisTemplateStat.opsForValue().set("booktagId:bookExt:"+booktagId+":"+page+":stat",bookExtPage.getPageNum()+":"+bookExtPage.getPageSize()+":"+bookExtPage.getTotal());
        redisTemplateBookExt.expire("booktagId:bookExt:"+booktagId+":"+page+":stat",3, TimeUnit.DAYS);
        return bookExtPage;
    }

    //这个要不要缓存
    //
    public Booktag getBooktagById(Integer booktagId){
        return booktagMapper.selectByPrimaryKey(booktagId);
    }

    public Category getCategory(Integer categoryId){
        Category category = redisTemplateCategory.opsForValue().get("category:"+categoryId);
        if(category!=null){
            return category;
        }
        category = categoryMapper.selectByPrimaryKey(categoryId);
        redisTemplateCategory.opsForValue().set("category:"+categoryId,category,7,TimeUnit.DAYS);
        return category;
    }
    public List<Category> getChildCategory(Integer categoryId){
        List<Category> categoryList = redisTemplateCategory.opsForList().range("category:childCategory:"+categoryId,0,-1);
        if(categoryList!=null && !categoryList.isEmpty()){
            return categoryList;
        }
        categoryList = categoryMapper.selectChildCategoryByPrimaryKey(categoryId);
        if(categoryList!=null){
            System.out.println(categoryList);
            //会出现[null] 因为mapper那里用了左联结


            Iterator<Category> iterator = categoryList.iterator();
            while (iterator.hasNext()){
                Category category = iterator.next();
                if(category == null){
                    //System.out.println("get");
                    iterator.remove();
                }
            }
            if(!categoryList.isEmpty()) {
                redisTemplateCategory.opsForList().leftPushAll("category:childCategory:" + categoryId, categoryList);
            }
        }
        redisTemplateCategory.expire("category:childCategory:"+categoryId,7,TimeUnit.DAYS);
        return categoryList;
    }

    public List<Category> getAllTopCategory(){
        List<Category> categoryList = redisTemplateCategory.opsForList().range("category:allTop",0,-1);
        if(categoryList!=null && !categoryList.isEmpty()){
            return categoryList;
        }
        categoryList = categoryMapper.selectAll();
        if(categoryList!=null && !categoryList.isEmpty()){
            redisTemplateCategory.opsForList().leftPushAll("category:allTop",categoryList);
        }
        redisTemplateCategory.expire("category:allTop",7,TimeUnit.DAYS);
        return categoryList;
    }

    public Category getParentCategory(Integer categoryId){
        Category category = redisTemplateCategory.opsForValue().get("category:parent:"+categoryId);
        if(category!=null){
            return category;
        }
        category = categoryMapper.selectParentByPrimaryKey(categoryId);
        redisTemplateCategory.opsForValue().set("category:parent:"+categoryId,category,7,TimeUnit.DAYS);
        return category;
    }

    public Series getSeriesByName(String seriesName){
        return seriesMapper.selectByName(seriesName);
    }

    public Page<BookExt> getBooksByQuery(String query,Integer page){
        PageHelper.startPage(page,3);
        return bookMapper.selectBookWithOriginalTranslatorOrderByQuery("%"+query+"%");
    }

     public Integer bookIsFavByBookIdAndUserId(Integer bookId, Integer userId){
        //return bookMapper.isFavByPrimaryKey(bookId,userId);
        return favBookUserMapper.isFavByPrimaryKey(bookId,userId);
    }

     public Integer bookIsVoteByBookIdAndUserId(Integer bookId, Integer userId){
        //return bookMapper.isVoteByPrimaryKey(bookId,userId);
        return voteBookUserMapper.isVoteByPrimaryKey(bookId,userId);
    }

    //这个方法连同上面两个方法的缓存策略
    //不缓存
    //是否收藏 是否推荐 推荐数
    public Book favOrVote(Integer bookId,Integer userId,String item){
        if(item.equals("togglefav")){
            int favValue = bookMapper.isFavByPrimaryKey(bookId,userId);
            if(favValue==1){
                favBookUserMapper.delete(bookId,userId);
            }
            if(favValue==0){
                FavBookUser favBookUser = new FavBookUser();
                favBookUser.setBookId(bookId);
                favBookUser.setUserId(userId);
                favBookUserMapper.insert(favBookUser);
            }

            redisTemplateBookExt.delete("fav:bookExt:"+userId);
            List<String> keys = redisTemplateStat.opsForList().range("fav:"+userId,0,-1);
            redisTemplatePage.delete(keys);
            return getBook(bookId);
        }
        if(item.equals("togglevote")){
            int voteValue = bookMapper.isVoteByPrimaryKey(bookId,userId);
            Book book = getBook(bookId);
            /*
            Book book = new Book();
            book.setBookId(bookId);
            book.setBookVote(bookMapper.selectBookVoteByBookId(bookId));
            */
            if(voteValue==1){
                voteBookUserMapper.delete(bookId,userId);
                book.setBookVote(book.getBookVote()-1);
            }
            if(voteValue==0){
                VoteBookUser voteBookUser = new VoteBookUser();
                voteBookUser.setBookId(bookId);
                voteBookUser.setUserId(userId);
                voteBookUserMapper.insert(voteBookUser);
                book.setBookVote(book.getBookVote()+1);
            }
            bookMapper.updateByPrimaryKeySelective(book);
            return book;
        }
        return null;
    }

    public List<BookExt> getAllFavBooksByUserId(Integer userId){
        List<BookExt> bookExtList = redisTemplateBookExt.opsForList().range("fav:bookExt:"+userId,0,-1);
        if(bookExtList!=null && !bookExtList.isEmpty()){
            return bookExtList;
        }

        bookExtList = bookMapper.selectBookWithOriginalTranslatorByUserId(userId);
        if(bookExtList!=null && !bookExtList.isEmpty()) {
            redisTemplateBookExt.opsForList().leftPushAll("fav:bookExt:" + userId, bookExtList);
            redisTemplateBookExt.expire("fav:bookExt:" + userId,3,TimeUnit.DAYS);
        }
        return bookExtList;
    }

    @Autowired
    public void setBookMapper(BookMapper bookMapper) {
        this.bookMapper = bookMapper;
    }

    @Autowired
    public void setCategoryMapper(CategoryMapper categoryMapper) {
        this.categoryMapper = categoryMapper;
    }

    @Autowired
    public void setPublishInfoMapper(PublishInfoMapper publishInfoMapper) {
        this.publishInfoMapper = publishInfoMapper;
    }

    @Autowired
    public void setSeriesMapper(SeriesMapper seriesMapper) {
        this.seriesMapper = seriesMapper;
    }

    @Autowired
    public void setAlsoLikeMapper(AlsoLikeMapper alsoLikeMapper) {
        this.alsoLikeMapper = alsoLikeMapper;
    }

    @Autowired
    public void setBooktagMapper(BooktagMapper booktagMapper) {
        this.booktagMapper = booktagMapper;
    }

    @Autowired
    public void setFavBookUserMapper(FavBookUserMapper favBookUserMapper) {
        this.favBookUserMapper = favBookUserMapper;
    }

    @Autowired
    public void setVoteBookUserMapper(VoteBookUserMapper voteBookUserMapper) {
        this.voteBookUserMapper = voteBookUserMapper;
    }

    @Autowired
    public void setRedisTemplateBookExt(RedisTemplate<String, BookExt> redisTemplateBookExt) {
        this.redisTemplateBookExt = redisTemplateBookExt;
    }

    @Autowired
    public void setRedisTemplateBook(RedisTemplate<String, Book> redisTemplateBook) {
        this.redisTemplateBook = redisTemplateBook;
    }

    @Autowired
    public void setRedisTemplateStat(RedisTemplate<String, String> redisTemplateStat) {
        this.redisTemplateStat = redisTemplateStat;
    }

    @Autowired
    public void setRedisTemplatePage(RedisTemplate<String, Page<BookExt>> redisTemplatePage) {
        this.redisTemplatePage = redisTemplatePage;
    }

    @Autowired
    public void setRedisTemplateCategoryExt(RedisTemplate<String, CategoryExt> redisTemplateCategoryExt) {
        this.redisTemplateCategoryExt = redisTemplateCategoryExt;
    }

    @Autowired
    public void setRedisTemplateCategory(RedisTemplate<String, Category> redisTemplateCategory) {
        this.redisTemplateCategory = redisTemplateCategory;
    }
}
