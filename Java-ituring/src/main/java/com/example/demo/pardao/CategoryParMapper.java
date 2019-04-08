package com.example.demo.pardao;

import com.example.demo.extmodel.CategoryExt;
import com.example.demo.model.Category;

import java.util.List;

public interface CategoryParMapper {

    CategoryExt selectCategoryWithAllParentByPrimaryKey(Integer categoryId);
    List<Category> selectChildCategoryByPrimaryKey(Integer categoryId);
    List<Category> selectAll();//所有大分类
    Category selectParentByPrimaryKey(Integer categoryId);
}
