<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>首页-图灵社区</title>
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="shortcut icon" href="/staticitr/img/favicon.png">

    
    <link href="W-IyudFsjvr8DmczNaEtVDAWVVWkoAYhOkQl_7kkbqc1.css" rel="stylesheet"/>

    <link href="sZ469sB_bTSptWvx3QdRX8e0asdOguk7ejwJWbvyndU1.css" rel="stylesheet"/>


    <script src="/20qhuba-JjWpkUZ6WyvMzCPWFrB_TrAdbOFot0ehZMw1.js"></script>

    <script src="/Ep7XxB9YaQz_sUggoppp1nXkei68VOq0u3sLcOISbsE1.js"></script>

    <!--[if lt IE 9]>
        <script src="/staticitr/lib/bootstrap/3.3.7/ie/html5shiv.min.js"></script>
        <script src="/staticitr/lib/bootstrap/3.3.7/ie/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<%@ include file="includeTop.jsp"%>
<!--
    <div class="layout-head">
                                <div class="container">
                                    <div id="navbar-toggles" class="navbar-toggles">
                                        <a href="#nav-main" class="toggle-main ryi-nav-sandwich"></a>
                                    </div>
                                    <a id="head-navbar-toggle" href="#" class="head-navbar-toggle"></a>
                                    <div class="head-logo"><a href="/">图灵社区</a></div>
                                    <ul id="head-nav-primary" class="head-nav">
                                        <li class="head-nav-home"><a href="/">首页</a></li>
                                        <li><a href="/book">图书</a></li>
                                        <li><a href="/article">文章</a></li>
                                        <li class="head-search">
                                            <form action="/search">
                                                <input type="search" name="q" placeholder="技术改变世界 阅读塑造人生" class="key">
                                                <button class="go btn btn-link"><span class="fa fa-search"></span></button>
                                            </form>
                                        </li>
                                    </ul>
                                    <ul id="head-nav-secondary" class="head-nav">
                                        <li class="head-compose"><a href="http://account.ituring.com.cn/register?returnUrl=http%3a%2f%2fwww.ituring.com.cn%2f">新会员注册</a></li>
                                        <li class="head-compose"><a href="http://account.ituring.com.cn/log-in?returnUrl=http%3a%2f%2fwww.ituring.com.cn%2f">登录</a></li>
                                        <div class="navbar-close"><a href="#nav-user" class="fa fa-angle-up"></a></div>
                                    </ul>
                                </div>
    </div>
    -->


    




<div id="home" class="customized-page">
            <div id="row-1" class="out-container">
                <div class="container">

                    <div class="row">
                            <div class="col-md-12 col-sm-12 column" id="column-1">
                                    <div data-number="" class="block block- block--" id="block-1">
                                        <div class="editable-area">
    <div class="block hot-tags hidden-xs hidden-xm">
    <span class="tags">
        <c:forEach var="booktag" items="${mainPageTags}">
            <a href="/tag/${booktag.booktagId}" tagid="${booktag.booktagId}" class="post-tag">${booktag.booktagName}</a>
        </c:forEach>
    </span>
</div>
</div>

                                    </div>
                            </div>
                    </div>
                </div>
            </div>
            <div id="row-2" class="out-container">
                <div class="container">

                    <div class="row">
                            <div class="col-md-9 col-sm-12 column" id="column-2">
                                    <div data-number="51" class="block block-books block-books-grid  block-books-marquee multiple-line" id="block-2">
                                                <div class="block-header">
            <h4><a href="/tag/36515">热门图书</a></h4>

                    <div class="header-more marquee-btns">
                        <a href data-toggle="marquee" data-act="left" data-target="block-2" disabled class="btn btn-default"><span class="fa fa-angle-left"></span></a>
                        <a href data-toggle="marquee" data-act="right" data-target="block-2" class="btn btn-default"><span class="fa fa-angle-right"></span></a>
                    </div>
        </div>
    <ul class="block-items">
            <c:forEach var="hBook" items="${hottestBooks}">
                <li class="block-item">
            <div class="book-img">
    <a href="/book/${hBook.bookId}" title="${hBook.bookTitle}">
        <img src="${hBook.imageLink}" alt="${hBook.bookTitle}">
    </a>
</div>
<div class="book-info">
    <h4 class="name"><a href="/book/${hBook.bookId}" title="${hBook.bookTitle}">${hBook.bookTitle}</a></h4>
    <div class="author">
            <span>
                <c:forEach var="originalAuthor" items="${hBook.originalAuthors}">
                    ${originalAuthor.authorName}
                </c:forEach>  
            </span>
                    <span>
                <c:forEach var="translatorAuthor" items="${hBook.translatorAuthors}">
                    ${translatorAuthor.authorName}
                </c:forEach>   
                译
            </span>
    </div>
    <p class="intro">${hBook.bookIntro}</p>

    
</div>
        </li>
            </c:forEach>


    </ul>

                                    </div>

                            </div>
                            <div class="col-md-3 col-sm-12 column" id="column-3">
                                    <div data-number="3" class="block block-books block-books-list  block-books-soon" id="block-5">
                                                <div class="block-header">
            <h4><a href="/tag/12">纸书预售中</a></h4><!--这里硬编码了-->

                    <div class="header-more">
                        <a href="/tag/12">更多 <span class="fa fa-angle-right"></span></a>
                    </div>
        </div>
    <ul class="block-items">
        <c:forEach var="pBook" items="${presell}">
        <li class="block-item">
            <div class="book-img">
    <a href="/book/${pBook.bookId}" title="${pBook.bookTitle}">
        <img src="${pBook.imageLink}" alt="${pBook.bookTitle}">
    </a>
</div>
<div class="book-info">
    <h4 class="name"><a href="/book/${pBook.bookId}" title="${pBook.bookTitle}">${pBook.bookTitle}</a></h4>
    <div class="author">
            <span>
                <c:forEach var="originalAuthor" items="${pBook.originalAuthors}">
                    ${originalAuthor.authorName}
                </c:forEach>  
            </span>
                    <span>
                                        <c:forEach var="translatorAuthor" items="${pBook.translatorAuthors}">
                                            ${translatorAuthor.authorName}
                                        </c:forEach>  
                译
            </span>
    </div>
    <p class="intro">${pBook.bookIntro}</p>

    
</div>

        </li>
        </c:forEach>

    </ul>

                                    </div>
                            </div>
                    </div>
                </div>
            </div>

</div>



    <div id="footer">
        
    </div>
    <div id="toTop">
        <a href="#" class="ryi-angle-up"></a>
    </div>

    <script type="text/javascript">
        $(function () {
            $.ajaxSetup({ cache: false });
            $('#footer').load('/editablearea/show?name=Footer');
            $('#banner-btn-search').click(function () {
                var q = $('input[name=q]').val();
                if (q) {
                    location.href = '/search?q=' + q;
                } else {
                    $('input[name=q]').attr('placeholder', '请输入您感兴趣的');
                }
            })
        })
        function confirmDelete() {
            return confirm('确认删除？');
        }

        function scollToId(id) {
            $('html, body').animate({
                scrollTop: $(id).offset().top - 70
            }, 200);
        }
        strHost = document.location.hostname;
        if ((strHost.indexOf('ituring.com.cn') + strHost.indexOf('turingbook.com')) > -2) {
            // google analytics begin
            var _gaq = _gaq || [];
            _gaq.push(['_setAccount', 'UA-25520517-1']);
            _gaq.push(['_setDomainName', 'none']);
            _gaq.push(['_setAllowLinker', true]);
            _gaq.push(['_trackPageview']);

            (function () {
                var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
                ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
            })();
            // google analytics end
        };
    </script>
    
    
</body>
</html>
