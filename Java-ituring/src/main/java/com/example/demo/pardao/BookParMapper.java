package com.example.demo.pardao;

import com.example.demo.extmodel.BookExt;
import com.example.demo.model.Book;
import com.example.demo.model.Condition;
import com.github.pagehelper.Page;

import java.util.Date;
import java.util.List;

public interface BookParMapper {

     BookExt selectBookWithSeriesByPrimaryKey(Integer bookId);
     BookExt selectBookWithCategoryByPrimaryKey(Integer bookId);
     BookExt selectBookWithAlsoLikeByPrimaryKey(Integer bookId);
     BookExt selectBookWithCatalogByPrimaryKey(Integer bookId);
     BookExt selectBookWithOriginalAuthorByPrimaryKey(Integer bookId);
     BookExt selectBookWithTranslatorAuthorByPrimaryKey(Integer bookId);
     BookExt selectBookWithBooktagByPrimaryKey(Integer bookId);
     List<BookExt> selectBookWithOriginalTranslatorBySeriesId(Integer seriesId,Integer bookId);
     List<BookExt> selectBookWithOriginalTranslatorByAlsoLikeId(Integer alsoLikeId,Integer bookId);
     List<BookExt> selectBookWithOriginalTranslatorByBooktagId(Integer booktagId);
     List<BookExt> selectBookWithOriginalTranslatorOrderByBookEnterNum(Integer limit);
     Page<BookExt> selectBookWithOriginalTranslatorOrderByCondition2(Condition condition);
     Page<BookExt> selectBookWithOriginalTranslatorOrderByTag(Integer booktagId);
     Page<BookExt> selectBookWithOriginalTranslatorOrderByQuery(String query);
     List<BookExt> selectBookWithOriginalTranslatorBySeriesId2(Integer seriesId,Integer bookId);
     Integer isFavByPrimaryKey(Integer bookId, Integer userId);
     Integer isVoteByPrimaryKey(Integer bookId, Integer userId);
     List<BookExt> selectBookWithOriginalTranslatorByUserId(Integer userId);
     List<Integer> selectBookIdByUserId(Integer userId);
     Integer selectBookVoteByBookId(Integer bookId);
     }
