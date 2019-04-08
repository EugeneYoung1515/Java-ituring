package com.example.demo.dao;

import com.example.demo.model.FavBookUser;
import com.example.demo.pardao.FavBookUserParMapper;

public interface FavBookUserMapper extends FavBookUserParMapper{
    int insert(FavBookUser record);

    int insertSelective(FavBookUser record);
}