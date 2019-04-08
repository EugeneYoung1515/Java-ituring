package com.example.demo.pardao;

public interface FavBookUserParMapper {
    void delete(Integer bookId,Integer userId);
    Integer isFavByPrimaryKey(Integer bookId, Integer userId);
    Integer selectCountByUserId(Integer userId);
}
