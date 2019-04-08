package com.example.demo.service;

import com.example.demo.extmodel.UserExt;
import com.example.demo.model.FollowedUserFollowingUser;
import com.example.demo.model.User;

import java.util.List;

public interface UserService {

    Integer getCountByUserName(String userName);
    Integer getCountBYUserEmail(String email);
    void register(User user);
    User getUserById(Integer userId);
    User getUserByEmail(String email);
    UserExt getUserWithVoteAndFavById(Integer userId);
    void updateUserSelective(User user);
    void updateUser(User user);
    List<User> usersFollowingMe(Integer userId);
    List<User> usersFollowedByMe(Integer userId);
    FollowedUserFollowingUser attendtionOrNot(Integer edUserId, Integer userId);
    Integer attendtionOrNot2(Integer edUserId, Integer userId);
}
