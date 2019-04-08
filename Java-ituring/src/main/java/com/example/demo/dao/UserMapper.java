package com.example.demo.dao;

import com.example.demo.model.User;
import com.example.demo.pardao.UserParMapper;

public interface UserMapper extends UserParMapper{
    int deleteByPrimaryKey(Integer userId);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer userId);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
}