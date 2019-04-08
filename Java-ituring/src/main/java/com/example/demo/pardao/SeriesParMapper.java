package com.example.demo.pardao;

import com.example.demo.model.Series;

import java.util.List;

public interface SeriesParMapper {
    List<Series> selectAllSeries();
    Series selectByName(String seriesName);
}
