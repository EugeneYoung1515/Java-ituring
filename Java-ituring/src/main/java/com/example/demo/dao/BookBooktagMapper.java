package com.example.demo.dao;

import com.example.demo.model.BookBooktag;

public interface BookBooktagMapper {
    int insert(BookBooktag record);

    int insertSelective(BookBooktag record);
}