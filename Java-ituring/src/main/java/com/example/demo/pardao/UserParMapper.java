package com.example.demo.pardao;

import com.example.demo.extmodel.UserExt;
import com.example.demo.model.User;

import java.util.List;

public interface UserParMapper {

    Integer selectCountByUserName(String userName);
    Integer selectCountByEmail(String email);
    void insertSelectiveReturnId(User user);
    User selectByEmail(String email);
    UserExt selectUserWithVoteAndFavByPrimaryKey(Integer userId);
    List<User> selectUserByFollowingUserId(Integer userId);//我关注的人
    List<User> selectUserByFollowedUserId(Integer userId);//关注我的人
}
