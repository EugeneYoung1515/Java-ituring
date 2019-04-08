package com.example.demo.extmodel;

import com.example.demo.model.Category;

public class CategoryExt extends Category {

    private Category parentGrade;

    public Category getParentGrade() {
        return parentGrade;
    }

    public void setParentGrade(Category parentGrade) {
        this.parentGrade = parentGrade;
    }
}
