package com.example.demo.pardao;

public interface VoteBookUserParMapper {
    void delete(Integer bookId,Integer userId);
    Integer isVoteByPrimaryKey(Integer bookId, Integer userId);
    Integer selectCountByUserId(Integer userId);
}
