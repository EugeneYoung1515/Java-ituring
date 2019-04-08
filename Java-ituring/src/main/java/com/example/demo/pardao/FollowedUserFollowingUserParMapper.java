package com.example.demo.pardao;

public interface FollowedUserFollowingUserParMapper {

    void deleteByIngUserId(Integer ingUserId);
    Integer isAttendtionByFollowingUserId(Integer ingUserId);
}
