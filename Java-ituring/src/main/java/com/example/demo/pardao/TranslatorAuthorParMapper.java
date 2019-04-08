package com.example.demo.pardao;

import com.example.demo.model.TranslatorAuthor;

import java.util.List;

public interface TranslatorAuthorParMapper {
    List<TranslatorAuthor> selectByBookId(Integer bookId);
}
