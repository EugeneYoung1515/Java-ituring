package com.example.demo.model;

import java.util.Objects;

public class TranslatorAuthor {
    private Integer translatorAuthorId;

    private String authorName;

    private String translatorAuthorIntro;

    public Integer getTranslatorAuthorId() {
        return translatorAuthorId;
    }

    public void setTranslatorAuthorId(Integer translatorAuthorId) {
        this.translatorAuthorId = translatorAuthorId;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName == null ? null : authorName.trim();
    }

    public String getTranslatorAuthorIntro() {
        return translatorAuthorIntro;
    }

    public void setTranslatorAuthorIntro(String translatorAuthorIntro) {
        this.translatorAuthorIntro = translatorAuthorIntro == null ? null : translatorAuthorIntro.trim();
    }

    /*
    @Override
    public boolean equals(Object obj) {
        System.out.println("test");
        if(obj==this)return true;
        if(obj==null)return false;
        if(getClass()!=obj.getClass())return false;
        TranslatorAuthor translatorAuthor=(TranslatorAuthor)obj;
        return Objects.equals(translatorAuthorId,translatorAuthor.getTranslatorAuthorId())&&
                Objects.equals(authorName,translatorAuthor.getAuthorName())&&
                Objects.equals(translatorAuthorIntro,translatorAuthor.getTranslatorAuthorIntro());
    }

    @Override
    public int hashCode() {
        return Objects.hash(translatorAuthorId,authorName,translatorAuthorIntro);
    }
    */
}