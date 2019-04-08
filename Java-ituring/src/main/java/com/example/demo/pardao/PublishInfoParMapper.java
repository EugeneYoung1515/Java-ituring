package com.example.demo.pardao;

import com.example.demo.model.PublishInfo;

public interface PublishInfoParMapper {

    PublishInfo selectByBookId(Integer bookId);
}
