package com.example.demo.dao;

import com.example.demo.model.VoteBookUser;
import com.example.demo.pardao.VoteBookUserParMapper;

public interface VoteBookUserMapper extends VoteBookUserParMapper{
    int insert(VoteBookUser record);

    int insertSelective(VoteBookUser record);
}