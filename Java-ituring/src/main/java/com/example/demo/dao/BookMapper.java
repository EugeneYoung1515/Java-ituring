package com.example.demo.dao;

import com.example.demo.extmodel.BookExt;
import com.example.demo.model.Book;
import com.example.demo.model.Condition;
import com.example.demo.pardao.BookParMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectProvider;

import java.util.List;

public interface BookMapper extends BookParMapper{
    int deleteByPrimaryKey(Integer bookId);

    int insert(Book record);

    int insertSelective(Book record);

    Book selectByPrimaryKey(Integer bookId);

    int updateByPrimaryKeySelective(Book record);

    int updateByPrimaryKey(Book record);

    //@Select("SELECT * FROM t_book WHERE book_id = #{bookId}")
    //@ResultMap("com.example.demo.dao.BookMapper.BaseResultMap")
    //Book findByName(@Param("bookId") Integer bookId);
    //这个注解方式能跑跑得通 说明注解方式和xml能混用

    @SelectProvider(type = com.example.demo.dao.BooksByConditionProvider.class,method = "getResult")
    @ResultMap("com.example.demo.dao.BookMapper.BookWithOriginalAuthorTranslatorAuthorResultMapSelect")
    List<BookExt> selectBookWithOriginalTranslatorOrderByCondition(Condition condition);
}