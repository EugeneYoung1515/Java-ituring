package com.example.demo.dao;

import com.example.demo.model.Condition;
import org.apache.ibatis.jdbc.SQL;

public class BooksByConditionProvider {
    public String getResult(Condition condition){
        return new SQL(){{
            SELECT("b.book_id as book_id, modified_date, ninety_book_enter_num, book_title, series_id, book_intro, feature, book_date, category_id, also_like_id,image_link, big_image_link, label, book_vote, book_enter_num, is_ebook, ebook_price, paper_original_price,paper_sale_price, amazon_link, dangdang_link, jd_link, enable_gift, sample_download,with_book_download, first_grade_id, second_grade_id, third_grade_id, b.book_id as book_id_for_original, b.book_id as book_id_for_translator from t_book as b");
            System.out.println(condition.getTabEbook());
            System.out.println(condition.getTabFree());
            System.out.println(condition.getTabTranslator());
            System.out.println(condition.getTabSoon());
            System.out.println(condition.getNinetyVote());
            System.out.println(condition.getGrade1());
            System.out.println(condition.getGrade2());
            System.out.println(condition.getGrade3());
            System.out.println(condition.getSortNew());
            System.out.println(condition.getSortHot());
            System.out.println(condition.getSortVote());
            System.out.println(condition.getNinetyVote());

            if(condition.getTabEbook()!=null){
                WHERE("b.is_ebook= 1");
            }
            if(condition.getTabFree()!=null){
                WHERE("b.is_ebook= 1 and b.ebook_price=00.00");
            }
            if(condition.getTabTranslator()!=null){
                WHERE("b.label = '诚征译者'");
            }
            if(condition.getTabSoon()!=null){
                WHERE("b.label in ('正在编辑','正在排版')");
            }
            if(condition.getNinetyVote()!=null){
                WHERE("b.modified_date > #{date}");
            }
            if(condition.getGrade1()!=null){
                WHERE("b.first_grade_id = #{grade1}");
            }
            if(condition.getGrade2()!=null){
                WHERE("b.second_grade_id = #{grade2}");
            }
            if(condition.getGrade3()!=null){
                WHERE("b.third_grade_id = #{grade3}");
            }
            if(condition.getSortNew()!=null){
                ORDER_BY("b.book_date desc,b.book_id desc");
            }
            if(condition.getSortHot()!=null){
                ORDER_BY("b.book_enter_num desc,b.book_id desc");
            }
            if(condition.getSortVote()!=null){
                ORDER_BY("b.book_vote desc,b.book_id desc");
            }
            if(condition.getNinetyVote()!=null){
                ORDER_BY("b.ninety_book_enter_num desc,b.book_id desc");
            }
        }}.toString();
    }
}
