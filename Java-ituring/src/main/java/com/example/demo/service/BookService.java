package com.example.demo.service;

import com.example.demo.extmodel.BookExt;
import com.example.demo.extmodel.CategoryExt;
import com.example.demo.model.*;
import com.github.pagehelper.Page;

import java.util.List;

public interface BookService {
    Book getBook(Integer bookId);
    BookExt getBookExt2(Integer bookId);
    BookExt getBookExt(Integer bookId);
    void updateEnterNum(BookExt bookExt);
    List<BookExt> getSameSeriesBooks(Integer seriesId,Integer bookId);
    List<BookExt> getSameLikeBooks(Integer alsoLikeId,Integer bookId);
    CategoryExt getCategoryWithAllParent(Integer categoryId);
    List<Series> getAllSeries();
    List<AlsoLike> getAllAlsoLike();
    List<Booktag> getMainPageTags();
    List<BookExt> getSameTagBooks(Integer booktagId);
    List<BookExt> getHottestBooks(Integer limit);
    Category getCategory(Integer categoryId);
    List<Category> getChildCategory(Integer categoryId);
    List<Category> getAllTopCategory();
    Category getParentCategory(Integer categoryId);
    List<BookExt> getBooksByCondition(String sort,String tab,Integer grade,Integer category,Integer page,Integer userId);
    List<Booktag> getAllTags();
    Page<BookExt> getSameTagBooks2(Integer booktagId,Integer page);
    Booktag getBooktagById(Integer booktagId);
    Series getSeriesByName(String seriesName);
    Page<BookExt> getBooksByQuery(String query, Integer page);
    Integer bookIsFavByBookIdAndUserId(Integer bookId, Integer userId);
    Integer bookIsVoteByBookIdAndUserId(Integer bookId, Integer userId);
    Book favOrVote(Integer bookId,Integer userId,String item);
    List<BookExt> getAllFavBooksByUserId(Integer userId);
}
