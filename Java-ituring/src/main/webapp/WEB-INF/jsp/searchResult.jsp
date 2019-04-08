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
    <title>${query}搜索结果-图灵社区</title>
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="shortcut icon" href="/staticitr/img/favicon.png">

    
    <link href="/W-IyudFsjvr8DmczNaEtVDAWVVWkoAYhOkQl_7kkbqc1.css" rel="stylesheet"/>

    <link href="/sZ469sB_bTSptWvx3QdRX8e0asdOguk7ejwJWbvyndU1.css" rel="stylesheet"/>
    <!--这两个css 有一个Kendo UI带的-->
    <!--原来链接似乎带有版本号-->


    <script src="/20qhuba-JjWpkUZ6WyvMzCPWFrB_TrAdbOFot0ehZMw1.js"></script>

    <script src="/Ep7XxB9YaQz_sUggoppp1nXkei68VOq0u3sLcOISbsE1.js"></script>
    <!--这两个js 有一个Kendo UI带的-->
    <!--原来链接似乎带有版本号-->

    <!--[if lt IE 9]>
        <script src="/staticitr/lib/bootstrap/3.3.7/ie/html5shiv.min.js"></script>
        <script src="/staticitr/lib/bootstrap/3.3.7/ie/respond.min.js"></script>
    <![endif]-->
</head>
<body>
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
                                        <li class="head-compose"><a href="http://account.ituring.com.cn/register?returnUrl=http%3a%2f%2fwww.ituring.com.cn%2fsearch%3fq%3djava">新会员注册</a></li>
                                        <li class="head-compose"><a href="http://account.ituring.com.cn/log-in?returnUrl=http%3a%2f%2fwww.ituring.com.cn%2fsearch%3fq%3djava">登录</a></li>
                                        <div class="navbar-close"><a href="#nav-user" class="fa fa-angle-up"></a></div>
                                    </ul>
                                </div>
    </div>
    -->


    



<div class="container page-box book-page">
    <div class="row">
        <div class="col-md-9" style="min-height:500px;">
                <div class="nav-tab-primary">
                    <h4>包含 ${query} 的内容</h4>
                    <ul class="nav nav-tabs text-right">
                        <li class="active">
                            <a href="/search?q=${query}">综合</a>
                        </li>
                        <li class="">
                            <a href="/search?q=${query}&type=book">图书</a>
                        </li>
                        <li class="">
                            <a href="/search?q=${query}&type=user">用户</a>
                        </li>
                    </ul>
                </div>
                <div class="g-main">
                        <div id="search-result-books">
                            <div class="block block-books block-books-grid">
                                <ul class="block-items">
                                    <c:forEach var="qBook" items="${qBooks.list}">
                                        <li class="block-item">
                                            <div class="book-img">
    <a href="/book/${qBook.bookId}" title="${qBook.bookTitle}">
        <img src="${qBook.imageLink}" alt="${qBook.bookTitle}">
    </a>
</div>
<div class="book-info">
    <h4 class="name"><a href="/book/${qBook.bookId}" title="${qBook.bookTitle}">${qBook.bookTitle}</a></h4>
    <div class="author">
            <span>
                <c:forEach var="originalAuthor" items="${qBook.originalAuthors}">
                    ${originalAuthor.authorName}
                </c:forEach>  
            </span>
        <span>
                <c:forEach var="translatorAuthor" items="${qBook.translatorAuthors}">
                    ${translatorAuthor.authorName}
                </c:forEach>   
                译
            </span>
    </div>
    <p class="intro">${qBook.bookIntro}</p>

    
</div>

                                        </li>
                                    </c:forEach>
                                </ul>

                                <div class="clearfix">
                                    <div class="PagedList-pager">
                                        <ul>
                                            <!--
                                            <li class="PagedList-disabled PagedList-currentPage PagedList-skipToPage"><a>1</a></li>
                                            <li class="PagedList-skipToPage"><a data-ajax="true" data-ajax-mode="replace" data-ajax-success="lazyLoadImages('search-result-books')" data-ajax-update="#search-result-books" href="/menu/books?q=${query}&page=1">2</a></li>
                                            <li class="PagedList-skipToPage"><a data-ajax="true" data-ajax-mode="replace" data-ajax-success="lazyLoadImages('search-result-books')" data-ajax-update="#search-result-books" href="/menu/books?q=${query}&page=2">3</a></li>
                                            <li class="PagedList-skipToPage"><a data-ajax="true" data-ajax-mode="replace" data-ajax-success="lazyLoadImages('search-result-books')" data-ajax-update="#search-result-books" href="/menu/books?q=${query}&page=3">4</a></li>
                                            <li class="PagedList-skipToPage"><a data-ajax="true" data-ajax-mode="replace" data-ajax-success="lazyLoadImages('search-result-books')" data-ajax-update="#search-result-books" href="/menu/books?q=${query}&page=4">5</a></li>
                                            <li class="PagedList-skipToPage"><a data-ajax="true" data-ajax-mode="replace" data-ajax-success="lazyLoadImages('search-result-books')" data-ajax-update="#search-result-books" href="/menu/books?q=${query}&page=5">6</a></li>
                                            <li class="PagedList-ellipses"><span>...</span></li>
                                            <li class="PagedList-skipToLast"><a data-ajax="true" data-ajax-mode="replace" data-ajax-success="lazyLoadImages('search-result-books')" data-ajax-update="#search-result-books" href="/menu/books?q=${query}&page=7">8</a></li>
                                            -->
                                            <c:if test="${qBooks.pageNum > 2}">
                                                <li class="PagedList-skipToPage"><a data-ajax="true" data-ajax-mode="replace" data-ajax-success="lazyLoadImages('search-result-books')" data-ajax-update="#search-result-books" href="/menu/books?q=${query}&page=1">1</a></li>
                                            </c:if>
                                            <c:if test="${qBooks.pageNum > 3}">
                                                <li class="PagedList-ellipses"><span>...</span></li>
                                            </c:if>
                                            <c:if test="${qBooks.pageNum > 1}">
                                                <li class="PagedList-skipToPage"><a data-ajax="true" data-ajax-mode="replace" data-ajax-success="lazyLoadImages('search-result-books')" data-ajax-update="#search-result-books" href="/menu/books?q=${query}&page=${qBooks.pageNum-1}">${qBooks.pageNum-1}</a></li>
                                            </c:if>
                                            <li class="PagedList-disabled PagedList-currentPage PagedList-skipToPage"><a>${qBooks.pageNum}</a></li>

                                            <c:if test="${qBooks.pageNum < qBooks.pages}">
                                                <li class="PagedList-skipToPage"><a data-ajax="true" data-ajax-mode="replace" data-ajax-success="lazyLoadImages('search-result-books')" data-ajax-update="#search-result-books" href="/menu/books?q=${query}&page=${qBooks.pageNum+1}">${qBooks.pageNum+1}</a></li>
                                            </c:if>

                                            <c:if test="${qBooks.pageNum +2 < qBooks.pages}">
                                                <li class="PagedList-ellipses"><span>...</span></li>
                                            </c:if>
                                            <c:if test="${qBooks.pageNum +1 < qBooks.pages}">
                                                <li class="PagedList-skipToPage"><a data-ajax="true" data-ajax-mode="replace" data-ajax-success="lazyLoadImages('search-result-books')" data-ajax-update="#search-result-books" href="/menu/books?q=${query}&page=${qBooks.pages}">${qBooks.pages}</a></li>
                                            </c:if>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <!--
                            <hr />

                            <hr />
                            -->

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
