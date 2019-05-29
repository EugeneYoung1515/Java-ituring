package com.example.demo.web;


import com.example.demo.extmodel.BookExt;
import com.example.demo.extmodel.CategoryExt;
import com.example.demo.model.Book;
import com.example.demo.model.Category;
import com.example.demo.model.Series;
import com.example.demo.model.User;
import com.example.demo.service.BookService;
import com.github.pagehelper.PageInfo;
//import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

@Controller
public class BookManageController {

    /*
    Category 相关的设计

    t_book表有字段category_id记录书所属的最近一级分类id

    还有3个字段 first_grade_id second_grade_id third_grade_id
    后面这三个字段用来多条件查询时 从分类拿到书

    t_category表有grade字段用于表示所处的级别

    t_category_child_category表示父子之间的关系


    图书详情页是用到了t_category和t_category_child_category

    多条件查询那里 获得分类列表
    是用到了t_category表有grade字段 以及获得父分类的方法 和 获得所有子分类的方法


   也就是新加入一本书 要 1.t_book表有字段category_id记录书所属的最近一级分类id 2.还有3个字段 first_grade_id second_grade_id third_grade_id

     */


    private BookService bookService;

    @RequestMapping("/")
    public ModelAndView webRoot(){
        return index();
    }//用这种方式设置访问应用根目录跳转主页

    /*
    @RequestMapping(value = "/test")
    public ModelAndView test(Integer bookId){
        ModelAndView modelAndView = new ModelAndView("/bookInfoPage");//或者使用2464
        BookExt bookExt = bookService.getBookExt(1);
        modelAndView.addObject("book",bookExt);
        bookService.updateEnterNum(bookExt);
        String formatUpdateEnterNum = formatUpdateEnterNum(bookExt.getBookEnterNum());
        modelAndView.addObject("formatUpdateEnterNum",formatUpdateEnterNum);
        List<BookExt> sameSeriesBooks = bookService.getSameSeriesBooks(bookExt.getSeries().getSeriesId(),bookId);
        modelAndView.addObject("sameSeriesBooks",sameSeriesBooks);
        List<BookExt> sameLikeBooks =bookService.getSameLikeBooks(bookExt.getAlsoLike().getAlsoLikeId(),bookId);
        modelAndView.addObject("sameLikeBooks",sameLikeBooks);
        CategoryExt categoryExt = bookService.getCategoryWithAllParent(bookExt.getCategory().getCategoryId());
        modelAndView.addObject("allGrade",categoryExt);
        return modelAndView;

    }
    @RequestMapping(value = "/test2")
    public ModelAndView test2(Integer bookId){return test(1);}
    */

    @RequestMapping(value = "/book/{bookId}",method = RequestMethod.GET)
    public ModelAndView BookInfoPage(@PathVariable Integer bookId, HttpServletRequest httpServletRequest){
        //return test(bookId);
        BookExt bookExt = bookService.getBookExt(bookId);
        bookService.updateEnterNum(bookExt);
        String formatUpdateEnterNum = formatUpdateEnterNum(bookExt.getBookEnterNum());
        //ModelAndView modelAndView =new ModelAndView("/2464");
        ModelAndView modelAndView = new ModelAndView("/bookInfoPage","book",bookExt);
        modelAndView.addObject("formatUpdateEnterNum",formatUpdateEnterNum);
        User user = (User)httpServletRequest.getSession().getAttribute("userSession");
        //System.out.println(user.getUserId());
        if(user!=null){
            modelAndView.addObject("fav",bookService.bookIsFavByBookIdAndUserId(bookId,user.getUserId()));
            //System.out.println(bookService.bookIsFavByBookIdAndUserId(bookId,user.getUserId()));
        }
        if(user!=null){
            modelAndView.addObject("vote",bookService.bookIsVoteByBookIdAndUserId(bookId,user.getUserId()));
            //System.out.println(bookService.bookIsVoteByBookIdAndUserId(bookId,user.getUserId()));
        }

        List<BookExt> sameSeriesBooks = bookService.getSameSeriesBooks(bookExt.getSeries().getSeriesId(),bookId);
        modelAndView.addObject("sameSeriesBooks",sameSeriesBooks);
        List<BookExt> sameLikeBooks =bookService.getSameLikeBooks(bookExt.getAlsoLike().getAlsoLikeId(),bookId);
        modelAndView.addObject("sameLikeBooks",sameLikeBooks);
        CategoryExt categoryExt = bookService.getCategoryWithAllParent(bookExt.getCategory().getCategoryId());
        modelAndView.addObject("allGrade",categoryExt);
        System.out.println(categoryExt.getCategoryName());
        return modelAndView;
    }

    @RequestMapping(value = "/book/{item:^toggle(?:fav|vote)$}/{bookId}",method = RequestMethod.POST)
    public void toggleFav(@PathVariable String item,@PathVariable Integer bookId,HttpServletRequest httpServletRequest,HttpServletResponse httpServletResponse){
        User user = (User)httpServletRequest.getSession().getAttribute("userSession");
        System.out.println("[[[[["+user.getUserId());
        try {
            if (user != null) {
                //return "redirect:/book/favvote"+bookId;
                httpServletRequest.getSession().setAttribute("item",item);//到现在位置会话里就设置 token user userSession 还有这个
                httpServletResponse.sendRedirect("/book/favvote/" + bookId);
            }else {
                System.out.println("redirect");
                httpServletResponse.sendError(500);
            }
        }catch (IOException ex){
            ex.printStackTrace();
        }
    }


    //推荐和收藏都用的是这个方法
    @RequestMapping(value = "/book/favvote/{bookId}",method = RequestMethod.GET)
    public ModelAndView favVote(@PathVariable Integer bookId,HttpServletRequest httpServletRequest){
        ModelAndView modelAndView = new ModelAndView("/favOrVote");
        String item = (String) httpServletRequest.getSession().getAttribute("item");
        User user = (User)httpServletRequest.getSession().getAttribute("userSession");
        if(item!=null && user!=null){
            Book book = bookService.favOrVote(bookId,user.getUserId(),item);

            //BookExt bookExt = bookService.getBookExt2(bookId);
            //bookService.updateEnterNum(bookExt);
            String formatUpdateEnterNum = formatUpdateEnterNum(book.getBookEnterNum());
            modelAndView.addObject("book",book);
            modelAndView.addObject("formatUpdateEnterNum",formatUpdateEnterNum);

            modelAndView.addObject("fav",bookService.bookIsFavByBookIdAndUserId(bookId,user.getUserId()));
            modelAndView.addObject("vote",bookService.bookIsVoteByBookIdAndUserId(bookId,user.getUserId()));

            httpServletRequest.getSession().removeAttribute("item");
        }
        return modelAndView;
    }


    public String formatUpdateEnterNum(int num){
        if(num > 1000){
            int high = num/1000;
            int low = (num %1000)/100;
            String result = high+"."+low+"K";
            return result;
        }else{
           return num+"";
        }
    }

    @RequestMapping(value = "/index",method = RequestMethod.GET)
    public ModelAndView index(){
        ModelAndView modelAndView = new ModelAndView("mainPage");
        modelAndView.addObject("mainPageTags",bookService.getMainPageTags());
        modelAndView.addObject("presell",bookService.getSameTagBooks(12));//这里硬编码了
        modelAndView.addObject("hottestBooks",bookService.getHottestBooks(6));
        return modelAndView;
    }

    @RequestMapping(value = "/tag/{tag}",method = RequestMethod.GET)
    public ModelAndView bookTag(@PathVariable Integer tag,@RequestParam(name="page",defaultValue = "1") Integer page){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("allTags",bookService.getAllTags());
        modelAndView.addObject("allSameTagBook",new PageInfo<BookExt>(bookService.getSameTagBooks2(tag,page)));
        modelAndView.addObject("booktag",bookService.getBooktagById(tag));
        modelAndView.setViewName("/sameTagBooks");
        return modelAndView;
    }
    @RequestMapping(value = "/tag/books/{tag}",method = RequestMethod.GET)
    public ModelAndView bookTag2(@PathVariable Integer tag,@RequestParam(name="page",defaultValue = "1") Integer page){
        return bookTag(tag,page);
    }

    @RequestMapping(value = "/book",method = RequestMethod.GET)//这里好像是在web层写业务逻辑 写了一到多 和 多到一的逻辑
    public ModelAndView showBooks(@RequestParam(name="tab",defaultValue = "book") String tab,@RequestParam(name="sort",defaultValue = "hot") String sort,@RequestParam(name="category",required = false) Integer category,
                                  @RequestParam(name="page",defaultValue = "1") Integer page,HttpServletRequest httpServletRequest){
        //User userSessionTest = (User)httpServletRequest.getSession().getAttribute("userSession");
        //System.out.println("--"+userSessionTest.getPersonalWebsite());

        User user = (User)httpServletRequest.getSession().getAttribute("userSession");
        System.out.println(user+"sss");
        System.out.println(tab+ " "+sort+" "+category);
        ModelAndView modelAndView = new ModelAndView();
        int grade=-1;
        if(category != null){
            Category category1 = bookService.getCategory(category);
            grade = category1.getGrade();
            if(grade==1){
                System.out.println(grade);
                modelAndView.addObject("allTopCategory",bookService.getAllTopCategory());//1 集合
                modelAndView.addObject("category",category1);//展开成下面
                modelAndView.addObject("childCategory",bookService.getChildCategory(category));//2 集合
            }if(grade==2){
                System.out.println(grade);
                Category parentCategory = bookService.getParentCategory(category);
                modelAndView.addObject("parentCategory",parentCategory);//1 单个
                modelAndView.addObject("brotherCategory",bookService.getChildCategory(parentCategory.getCategoryId()));//2 集合
                modelAndView.addObject("category",category1);//展开成下面
                modelAndView.addObject("childCategory",bookService.getChildCategory(category));//3 集合
                /*
                for(Category category2:bookService.getChildCategory(category)){

                    System.out.println("Before");
                    System.out.println(category2);
                    System.out.println(bookService.getChildCategory(category));
                    System.out.println("After");
                    //System.out.println(category2.getCategoryId()+" "+category2.getCategoryName());
                }
                 */
            }if(grade==3){
                System.out.println(grade);
                Category parentCategory = bookService.getParentCategory(category);
                Category parentParentCategory = bookService.getParentCategory(parentCategory.getCategoryId());
                modelAndView.addObject("parentParentCategory",parentParentCategory);//1 单个
                modelAndView.addObject("parentCategory",parentCategory);// 2 单个
                modelAndView.addObject("brotherCategory",bookService.getChildCategory(parentCategory.getCategoryId()));//3 集合
                modelAndView.addObject("category",category1);
            }
        }else {
            System.out.println(grade);
            modelAndView.addObject("allTopCategory",bookService.getAllTopCategory());
        }
        Integer grade1 = grade;
        modelAndView.addObject("mainPageTags",bookService.getMainPageTags());
        if(user!=null){
            modelAndView.addObject("BooksByCondition",new PageInfo<BookExt>(bookService.getBooksByCondition(tab,sort,grade1,category,page,user.getUserId())));
        }else{
            modelAndView.addObject("BooksByCondition",new PageInfo<BookExt>(bookService.getBooksByCondition(tab,sort,grade1,category,page,null)));
        }
        modelAndView.addObject("tab",tab);
        modelAndView.addObject("sort",sort);
        //modelAndView.addObject("category",category);
        modelAndView.setViewName("/BooksByCondition");
        return modelAndView;
    }

    @RequestMapping(value = "/search",method = RequestMethod.GET)
    public ModelAndView search(@RequestParam(name="q") String q,@RequestParam(name="page",defaultValue = "1") Integer page){
        if(q!=null && !q.equals("")) {
            ModelAndView modelAndView = new ModelAndView("/searchResult");
            modelAndView.addObject("query", q);
            modelAndView.addObject("qBooks", new PageInfo<>(bookService.getBooksByQuery(q, page)));
            return modelAndView;
        }else {
            System.out.println(q);
            System.out.println("NoQuery");
            return new ModelAndView("searchNoQuery");
        }
    }

    @RequestMapping(value = "/menu/books",method = RequestMethod.GET)
    public ModelAndView search2(@RequestParam(name="q") String q,@RequestParam(name="page",defaultValue = "1") Integer page){
        ModelAndView modelAndView = search(q,page);
        modelAndView.setViewName("/searchResultPageFragment");
        return modelAndView;
    }


    @Autowired
    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }
}
