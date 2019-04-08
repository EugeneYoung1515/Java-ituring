package com.example.demo.pardao;

import com.example.demo.model.OriginalAuthor;

import java.util.List;

public interface OriginalAuthorParMapper {
    List<OriginalAuthor> selectByBookId(Integer bookId);
}
