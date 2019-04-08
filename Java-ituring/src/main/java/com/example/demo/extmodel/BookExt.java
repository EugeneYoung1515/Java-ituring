package com.example.demo.extmodel;

import com.example.demo.model.*;

import java.util.List;
import java.util.Set;

public class BookExt extends Book {

    private Series series;

    private Category category;

    private AlsoLike alsoLike;

    private List<Catalog> catalogs;

    private List<OriginalAuthor> originalAuthors;

    private List<TranslatorAuthor> translatorAuthors;

    private List<Booktag> booktags;

    private PublishInfo publishInfo;

    public void setSeries(Series series){
        this.series=series;
    }

    public Series getSeries() {
        return series;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public AlsoLike getAlsoLike() {
        return alsoLike;
    }

    public void setAlsoLike(AlsoLike alsoLike) {
        this.alsoLike = alsoLike;
    }

    public List<Catalog> getCatalogs() {
        return catalogs;
    }

    public void setCatalogs(List<Catalog> catalogs) {
        this.catalogs = catalogs;
    }

    public List<OriginalAuthor> getOriginalAuthors() {
        return originalAuthors;
    }

    public void setOriginalAuthors(List<OriginalAuthor> originalAuthors) {
        this.originalAuthors = originalAuthors;
    }

    public List<Booktag> getBooktags() {
        return booktags;
    }

    public void setBooktags(List<Booktag> booktags) {
        this.booktags = booktags;
    }

    public PublishInfo getPublishInfo() {
        return publishInfo;
    }

    public void setPublishInfo(PublishInfo publishInfo) {
        this.publishInfo = publishInfo;
    }

    public List<TranslatorAuthor> getTranslatorAuthors() {
        return translatorAuthors;
    }

    public void setTranslatorAuthors(List<TranslatorAuthor> translatorAuthors) {
        this.translatorAuthors = translatorAuthors;
    }
}
