package com.example.demo.serviceImpl;

import com.example.demo.dao.*;
import com.example.demo.extmodel.BookExt;
import com.example.demo.extmodel.CategoryExt;
import com.example.demo.model.*;
import com.example.demo.service.BookService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

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

    public Book getBook(Integer bookId){
        return bookMapper.selectByPrimaryKey(bookId);
    }

    public BookExt getBookExt2(Integer bookId){
        return bookMapper.selectBookWithSeriesByPrimaryKey(bookId);
    }
    public BookExt getBookExt(Integer bookId){
        Book book = bookMapper.selectByPrimaryKey(bookId);
        System.out.println(book.getBookTitle());
        //BookExt bookExt = bookMapper.selectBookWithCategoryByPrimaryKey(bookId);
        BookExt bookExt = bookMapper.selectBookWithSeriesByPrimaryKey(bookId);
        System.out.println(bookExt.getBookDate());
        bookExt.setCategory(bookMapper.selectBookWithCategoryByPrimaryKey(bookId).getCategory());
        bookExt.setAlsoLike(bookMapper.selectBookWithAlsoLikeByPrimaryKey(bookId).getAlsoLike());
        bookExt.setCatalogs(bookMapper.selectBookWithCatalogByPrimaryKey(bookId).getCatalogs());
        bookExt.setOriginalAuthors(bookMapper.selectBookWithOriginalAuthorByPrimaryKey(bookId).getOriginalAuthors());
        bookExt.setTranslatorAuthors(bookMapper.selectBookWithTranslatorAuthorByPrimaryKey(bookId).getTranslatorAuthors());
        bookExt.setBooktags(bookMapper.selectBookWithBooktagByPrimaryKey(bookId).getBooktags());
        PublishInfo publishInfo = publishInfoMapper.selectByBookId(bookId);
        bookExt.setPublishInfo(publishInfo);
        return bookExt;
    }

    public void updateEnterNum(BookExt bookExt){
        bookExt.setBookEnterNum(bookExt.getBookEnterNum()+1);
        Date date = bookExt.getModifiedDate();
        Date date1 = new Date();
        long from1 = date.getTime();
        long to1 = date1.getTime();
        int days = (int) ((to1 - from1) / (1000 * 60 * 60 * 24));
        if(days<90) {
            bookExt.setNinetyBookEnterNum(bookExt.getNinetyBookEnterNum() + 1);
        }else {
            bookExt.setNinetyBookEnterNum(1);
        }
        bookExt.setModifiedDate(date1);
        bookMapper.updateByPrimaryKeySelective(bookExt);
    }

    public List<BookExt> getSameSeriesBooks(Integer seriesId,Integer bookId){
        //return bookMapper.selectBookWithOriginalTranslatorBySeriesId(seriesId,bookId);
        PageHelper.startPage(1,5);
        return bookMapper.selectBookWithOriginalTranslatorBySeriesId2(seriesId,bookId);
    }

    public List<BookExt> getSameLikeBooks(Integer alsoLikeId,Integer bookId){
        return bookMapper.selectBookWithOriginalTranslatorByAlsoLikeId(alsoLikeId,bookId);
    }
    public CategoryExt getCategoryWithAllParent(Integer categoryId){
        return categoryMapper.selectCategoryWithAllParentByPrimaryKey(categoryId);
    }
    public List<Series> getAllSeries(){
        return seriesMapper.selectAllSeries();
    }

    public List<AlsoLike> getAllAlsoLike(){
        return alsoLikeMapper.selectAllAlsoLike();
    }

    public List<Booktag> getMainPageTags(){
        return booktagMapper.selectMainPageTags();
    }

    public List<BookExt> getSameTagBooks(Integer booktagId){
        return bookMapper.selectBookWithOriginalTranslatorByBooktagId(booktagId);
    }

    public List<BookExt> getHottestBooks(Integer limit){
        return bookMapper.selectBookWithOriginalTranslatorOrderByBookEnterNum(limit);
    }

    public Page<BookExt> getBooksByCondition(String tab, String sort, Integer grade, Integer category, Integer page,Integer userId){
        //一直错误的原因 方法参数位置放错了

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
            condition.setFavList(bookMapper.selectBookIdByUserId(userId));
            for(Integer i:bookMapper.selectBookIdByUserId(userId)){
                System.out.println(i);
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
        /*
        System.out.println(condition.getTabEbook());
        System.out.println(condition.getTabFree());
        System.out.println(condition.getTabTranslator());
        System.out.println(condition.getTabSoon());
        System.out.println(condition.getNinetyVote());
        System.out.println(condition.getGrade1());
        System.out.println(condition.getGrade2());
        System.out.println(condition.getGrade3());
        System.out.println(condition.getSortNew());
        System.out.println(condition.getSortHot());
        System.out.println(condition.getSortVote());
        System.out.println(condition.getNinetyVote());
        System.out.println("--------");
        */
        return bookMapper.selectBookWithOriginalTranslatorOrderByCondition2(condition);
        //使用注解方式形成动态sql也行
    }

    public List<Booktag> getAllTags(){
        return booktagMapper.selectAllTags();
    }

    public Page<BookExt> getSameTagBooks2(Integer booktagId,Integer page){//上面有一个1
        PageHelper.startPage(page,3);
        return bookMapper.selectBookWithOriginalTranslatorOrderByTag(booktagId);//调用的这个没有通过join拿到作者和译者的信息 是通过select拿到作者和译者信息的
    }

    public Booktag getBooktagById(Integer booktagId){
        return booktagMapper.selectByPrimaryKey(booktagId);
    }

    public Category getCategory(Integer categoryId){
        return categoryMapper.selectByPrimaryKey(categoryId);
    }
    public List<Category> getChildCategory(Integer categoryId){
        return categoryMapper.selectChildCategoryByPrimaryKey(categoryId);
    }

    public List<Category> getAllTopCategory(){
        return categoryMapper.selectAll();
    }

    public Category getParentCategory(Integer categoryId){
        return categoryMapper.selectParentByPrimaryKey(categoryId);
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
        }
        if(item.equals("togglevote")){
            int voteValue = bookMapper.isVoteByPrimaryKey(bookId,userId);
            Book book = getBook(bookId);
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
        return null;//给togglefav用
    }

    public List<BookExt> getAllFavBooksByUserId(Integer userId){
        return bookMapper.selectBookWithOriginalTranslatorByUserId(userId);
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
}
