package com.example.demo.dao;

import com.example.demo.model.FollowedUserFollowingUser;
import com.example.demo.pardao.FollowedUserFollowingUserParMapper;

public interface FollowedUserFollowingUserMapper extends FollowedUserFollowingUserParMapper{
    int insert(FollowedUserFollowingUser record);

    int insertSelective(FollowedUserFollowingUser record);
}