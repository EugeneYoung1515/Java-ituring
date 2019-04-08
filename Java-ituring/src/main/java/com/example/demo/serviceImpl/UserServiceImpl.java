package com.example.demo.serviceImpl;

import com.example.demo.dao.FollowedUserFollowingUserMapper;
import com.example.demo.dao.UserMapper;
import com.example.demo.extmodel.UserExt;
import com.example.demo.model.FollowedUserFollowingUser;
import com.example.demo.model.User;
import com.example.demo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserServiceImpl implements UserService{

    private UserMapper userMapper;

    private FollowedUserFollowingUserMapper followedUserFollowingUserMapper;

    public Integer getCountByUserName(String userName){
        return userMapper.selectCountByUserName(userName);
    }

    public Integer getCountBYUserEmail(String email){
        return userMapper.selectCountByEmail(email);
    }

    public UserExt getUserWithVoteAndFavById(Integer userId){
        return userMapper.selectUserWithVoteAndFavByPrimaryKey(userId);
    }

    @Transactional
    public void register(User user){
        userMapper.insertSelectiveReturnId(user);
    }

    public User getUserById(Integer userId){
        return userMapper.selectByPrimaryKey(userId);
    }

    public User getUserByEmail(String userName){
        return userMapper.selectByEmail(userName);
    }

    public void updateUserSelective(User user){
        userMapper.updateByPrimaryKeySelective(user);
    }
    public void updateUser(User user){
        userMapper.updateByPrimaryKey(user);
    }

    public List<User> usersFollowingMe(Integer userId){
        return userMapper.selectUserByFollowedUserId(userId);
    }
    public List<User> usersFollowedByMe(Integer userId){
        return userMapper.selectUserByFollowingUserId(userId);
    }

    public FollowedUserFollowingUser attendtionOrNot(Integer edUserId, Integer userId){
        int oneIsTrue = followedUserFollowingUserMapper.isAttendtionByFollowingUserId(userId);
        if(oneIsTrue==1){
            followedUserFollowingUserMapper.deleteByIngUserId(userId);
            return null;
        }else{
            FollowedUserFollowingUser followedUserFollowingUser = new FollowedUserFollowingUser();
            followedUserFollowingUser.setEdUserId(edUserId);
            followedUserFollowingUser.setIngUserId(userId);
            followedUserFollowingUserMapper.insert(followedUserFollowingUser);
            return followedUserFollowingUser;
        }
    }

    public Integer attendtionOrNot2(Integer edUserId, Integer userId){
        return followedUserFollowingUserMapper.isAttendtionByFollowingUserId(userId);
    }

    @Autowired
    public void setUserMapper(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    @Autowired
    public void setFollowedUserFollowingUserMapper(FollowedUserFollowingUserMapper followedUserFollowingUserMapper) {
        this.followedUserFollowingUserMapper = followedUserFollowingUserMapper;
    }
}
