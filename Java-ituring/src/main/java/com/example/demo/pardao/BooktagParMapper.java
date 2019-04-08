package com.example.demo.pardao;

import com.example.demo.model.Booktag;

import java.util.List;

public interface BooktagParMapper {

    List<Booktag> selectMainPageTags();
    List<Booktag> selectAllTags();
}
