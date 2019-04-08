package com.example.demo.dao;

import com.example.demo.model.BookOriginalAuthor;

public interface BookOriginalAuthorMapper {
    int insert(BookOriginalAuthor record);

    int insertSelective(BookOriginalAuthor record);
}