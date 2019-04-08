package com.example.demo.dao;

import com.example.demo.model.BookTranslatorAuthor;

public interface BookTranslatorAuthorMapper {
    int insert(BookTranslatorAuthor record);

    int insertSelective(BookTranslatorAuthor record);
}