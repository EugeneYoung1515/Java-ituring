package com.example.demo.extmodel;

import com.example.demo.model.User;

public class UserExt extends User{

    private Integer voteNum;
    private Integer favNum;

    public Integer getVoteNum() {
        return voteNum;
    }

    public void setVoteNum(Integer voteNum) {
        this.voteNum = voteNum;
    }

    public Integer getFavNum() {
        return favNum;
    }

    public void setFavNum(Integer favNum) {
        this.favNum = favNum;
    }
}
