package com.example.demo.dao;

import com.example.demo.model.CategoryChildCategory;

public interface CategoryChildCategoryMapper {
    int insert(CategoryChildCategory record);

    int insertSelective(CategoryChildCategory record);
}