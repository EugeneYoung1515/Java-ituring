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
    <title>${book.bookTitle}-图书-图灵社区</title>
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="shortcut icon" href="/staticitr/img/favicon.png">


    <link href="/W-IyudFsjvr8DmczNaEtVDAWVVWkoAYhOkQl_7kkbqc1.css" rel="stylesheet">
    <link href="/sZ469sB_bTSptWvx3QdRX8e0asdOguk7ejwJWbvyndU1.css" rel="stylesheet">


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
                    <input type="text" name ="qqw" value="默认值">
                </form>
            </li>
        </ul>
        <ul id="head-nav-secondary" class="head-nav">
            <li class="head-compose"><a href="http://account.ituring.com.cn/register?returnUrl=http%3a%2f%2fwww.ituring.com.cn%2fbook%2f2464">新会员注册</a></li>
            <li class="head-compose"><a href="http://account.ituring.com.cn/log-in?returnUrl=http%3a%2f%2fwww.ituring.com.cn%2fbook%2f2464">登录</a></li>
            <div class="navbar-close"><a href="#nav-user" class="fa fa-angle-up"></a></div>
        </ul>
    </div>
</div>
-->




<div class="container">
    <div class="row g-50">
        <div class="col-md-9 main">
            <div class="page-book-head">
                <div class="row g-20">
                    <div class="col-md-4">
                        <div class="book-img">
                            <a href="${book.bigImageLink}">
                                <img src="${book.bigImageLink}" alt="${book.bookTitle}" class="lazy">
                            </a>
                            <div id="book-fav-vote" class="book-actions">
                                <c:if test="${vote == 0}">
                                <a id="toggle-vote" href="javascript:void(0);" class="article-vote">
                                    <span class="number">${book.bookVote}</span><span class="text ">推荐</span>
                                </a>
                                </c:if>
                                <c:if test="${vote == 1}">
                                    <a id="toggle-vote" href="javascript:void(0);" class="article-vote">
                                        <span class="number">${book.bookVote}</span><span class="text text-muted">已推荐</span>
                                    </a>
                                </c:if>
                                <c:if test="${fav == 0}">
                                    <a id="toggle-fav" href="javascript:void(0);" class="article-vote ">
                                        <span class="number fa fa-star-o"></span><span class="text text-muted">收藏</span>
                                    </a>
                                </c:if>
                                <c:if test="${fav == 1}">
                                    <a id="toggle-fav" href="javascript:void(0);" class="article-vote favored">
                                        <span class="number fa fa-star"></span><span class="text text-muted">已收藏</span>
                                    </a>
                                </c:if>
                                <div class="item article-vote"><span class="number">${formatUpdateEnterNum}</span><span class="text">阅读</span></div>
                                <script type="text/javascript">
                                    $(function () {

                                        $("#toggle-vote").click(function () {
                                            $.post("/book/togglevote/${book.bookId}")
                                                .done(function (data) {
                                                    $("#book-fav-vote").html(data);
                                                }).fail(function (data) {
                                                alert('请先登录！');
                                            });
                                            return false;
                                        });

                                        $("#toggle-fav").click(function () {
                                            $.post("/book/togglefav/${book.bookId}")
                                                .done(function (data) {
                                                    $("#book-fav-vote").html(data);
                                                }).fail(function (data) {
                                                alert('请先登录！');
                                            });
                                            return false;
                                        });
                                    });
                                </script>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="book-head-upper">
                            <div class="book-series">${book.series.seriesName}</div>
                            <div class="book-title">
                                <h2>
                                    ${book.bookTitle}
                                </h2>
                                <div></div>
                                <div><a></a></div>
                            </div>
                            <div class="book-author">
                                <span>
                                    <c:forEach var="originalAuthor" items="${book.originalAuthors}" varStatus="stat">
${originalAuthor.authorName}
                                        <c:if test="${!stat.last}">,</c:if>
                                    </c:forEach>
                                        (作者)
                                </span>
                                <span>
<c:forEach var="translatorAuthor" items="${book.translatorAuthors}" varStatus="stat">
    ${translatorAuthor.authorName}
    <c:if test="${!stat.last}">,</c:if>
</c:forEach>
                                        (译者)
                                </span>
                            </div>

                            <div class="book-status">
                                <span class="label label-info">${book.label}</span>
                                <span class="tags">
                                    <c:forEach var="booktag" items="${book.booktags}">
                                        <a href="/tag/${booktag.booktagId}" class="post-tag">${booktag.booktagName}</a>
                                    </c:forEach>
                                    </span>
                            </div>
                            <div class="book-intro readmore">
                        ${book.bookIntro}
                            </div>
                            <div class="baidu-share">
                                <div class="bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a href="#" class="bds_douban" data-cmd="douban" title="分享到豆瓣网"></a><a href="#" class="bds_evernotecn" data-cmd="evernotecn" title="分享到印象笔记"></a></div>
                                <script>window._bd_share_config = { "common": { "bdSnsKey": {}, "bdText": "", "bdMini": "2", "bdMiniList": false, "bdPic": "", "bdStyle": "0", "bdSize": "24" }, "share": {} }; with (document) 0[(getElementsByTagName('head')[0] || body).appendChild(createElement('script')).src = 'http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion=' + ~(-new Date() / 36e5)];</script>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3 pull-right side">

            <div class="editable-area">
                <div class="alert alert-success">
                    <p><b>收藏本书能做什么？</b></p>
                    <p>有情况的时候会收到通知，比如电子书发布等。</p>
                </div>
            </div>


            <div class="book-approaches">
                <dl>
                    <dt>电子书</dt>
                    <dd>
                        <span class="price">￥${book.ebookPrice}</span>
                    </dd>
                </dl>
                <dl class="ebook-formats">
                    <dt>格式</dt>
                    <dd>
                        <a href="/article/50435" title="推送说明">mobi</a><span class="fa fa-check"></span>
                          pdf<span class="fa fa-check"></span>

                    </dd>
                </dl>

                <div class="buy-btns">
                    <a href="/book/addtocart/${book.bookId}?Edition=Ebook" class="btn btn-block btn-warning">购买电子书</a>

                </div>
                <hr>
                <dl>
                    <dt>纸质书</dt>
                    <dd>
                            <span class="price">
                                ￥${book.paperSalePrice}
                            </span>
                        <s>￥${book.paperOriginalPrice}</s>
                    </dd>
                </dl>
                <div class="buy-btns">
                    <a href="/book/addtocart/${book.bookId}?Edition=Paper" class="btn btn-block btn-warning">购买纸书</a>
                    <a href="#" class="btn btn-block btn-default disabled">暂无样书</a>
                </div>


                <div class="where-to-buy">
                    <h4>其他购买方式？</h4>
                    <ul>
                        <li><a href="${book.amazonLink}" target="_blank">到亚马逊购买</a></li>

                        <li><a href="${book.dangdangLink}" target="_blank">到当当购买</a></li>

                        <li><a href="${book.jdLink}" target="_blank">到京东购买</a></li>


                    </ul>
                </div>
            </div>
            <ul class="sidenav-list category-sidenav">
                <li class="sidenav-major"><a href="/user/guaguacode"> 注册刮刮卡</a></li>
                <li class="sidenav-major">
                    <a data-ajax="true" data-ajax-mode="replace" data-ajax-update="#book-errata" href="/errata/bookerrata/2464?sort=accepted">提交/查看勘误</a>
                </li>
                <li class="sidenav-major">
                    <a id="sample-file" href="/file/samplefile/065153112022004100251140157221084204231021055025" target="_blank">样章下载</a>
                </li>
            </ul>


            <div class="block">
                <div class="block-header">
                    <h3>出版信息</h3>
                </div>
                <div class="block-body">
                    <ul class="publish-info">
                        <li><strong>书　　名</strong>${book.publishInfo.bookTitle}</li>
                        <li><strong>系列书名</strong>${book.publishInfo.seriesName}</li>
                        <li><strong>执行编辑</strong>关于本书的内容有任何问题，请联系 <a href="/message/chat/160851?Name=%E6%88%91%E7%9A%84%E7%AC%AC%E4%B8%80%E6%9C%AC%E7%AE%97%E6%B3%95%E4%B9%A6">${book.publishInfo.questionContact}</a></li>
                        <li><strong>出版日期</strong>
                            <fmt:formatDate pattern="yyyy-MM-dd"
                                            value="${book.publishInfo.bookDate}" />
                        </li>
                        <li><strong>书　　号</strong>${book.publishInfo.bookNumber}</li>
                        <li><strong>定　　价</strong>${book.publishInfo.price} 元</li>
                        <li><strong>页　　数</strong>${book.publishInfo.pageNum}</li>
                        <li><strong>印刷方式</strong>${book.publishInfo.print}</li>
                        <li><strong>开　　本</strong>${book.publishInfo.bookSize}</li>

                        <li><strong>出版状态</strong>${book.publishInfo.bookStatus}</li>

                        <li>
                            <strong>原书名</strong><a href="${book.publishInfo.amazonLink}" target="_blank">${book.publishInfo.originalTitle}</a>
                        </li>
                        <li>
                            <strong>原书号</strong><a href="${book.publishInfo.amazonLink}" target="_blank">${book.publishInfo.originalBookNumber}</a>
                        </li>
                    </ul>
                </div>
            </div>


            <div class="block">
                <div class="block-header">
                    <h3>所属分类</h3>
                </div>
                <div class="block-body">
                    <ul>

                        <li>
                            <c:if test="${allGrade.parentGrade != null && allGrade.parentGrade.parentGrade != null}">
                                <a href="/book?category=${allGrade.parentGrade.parentGrade.categoryId}">${allGrade.parentGrade.parentGrade.categoryName}</a>
                                >                 <a href="/book?category=${allGrade.parentGrade.categoryId}">${allGrade.parentGrade.categoryName}</a>
                                >
                            </c:if>
                            <c:if test="${allGrade.parentGrade != null && allGrade.parentGrade.parentGrade == null}">
                                <a href="/book?category=${allGrade.parentGrade.categoryId}">${allGrade.parentGrade.categoryName}</a>
                                >
                            </c:if>
                                <a href="/book?category=${allGrade.categoryId}">${allGrade.categoryName}</a>
                        </li>

                    </ul>


                </div>
            </div>



            <div class="block block-books block-books-list">

                <div class="block-header">
                    <h4>同系列书</h4>
                </div>
                <ul class="block-items">
<c:forEach var="sBook" items="${sameSeriesBooks}">
                    <li class="block-item">
                        <div class="book-img">
                            <a href="/book/${sBook.bookId}" title="${sBook.bookTitle}">
                                <img src="${sBook.imageLink}" alt="${sBook.bookTitle}">
                            </a>
                        </div>
                        <div class="book-info">
                            <h4 class="name"><a href="/book/${sBook.bookId}" title="${sBook.bookTitle}">${sBook.bookTitle}</a></h4>
                            <div class="author">
            <span>
<c:forEach var="originalAuthor" items="${sBook.originalAuthors}">
    ${originalAuthor.authorName}
</c:forEach>
            </span>
                                <span>
    <c:forEach var="translatorAuthor" items="${sBook.translatorAuthors}">
        ${translatorAuthor.authorName}
    </c:forEach>
                                    译
            </span>
                            </div>
                            <p class="intro">${sBook.bookIntro}</p>


                        </div>

                    </li>
                    </c:forEach>
                </ul>

            </div>
        </div>

        <div class="col-md-9 main tag-at-top">
            <div id="book-errata"></div>


            <div class="block">
                <div class="block-header">
                    <h3>本书特色</h3>
                </div>
                <div class="block-body">
                    <div class="intro">
${book.feature}
                    </div>
                </div>
            </div>

            <div id="book-photo-collection">


            </div>

            <div class="block">
                <div class="block-header">
                    <h3>目录</h3>
                </div>
                <div class="block-body">
                    <div class="catalogue">
                        <div class="catalogue-main">
                            <div class="bookmenu">
                                <table class="table table-striped">
<c:forEach var="catalog" items="${book.catalogs}">
                                    <tr>
                                        <td>
                                            <c:if test="${catalog.chapterLink == null}">
                                                        ${catalog.chapterIntro}
                                            </c:if>
                                            <c:if test="${catalog.chapterLink != null}">
                                                <a href="${catalog.chapterLink}">
                                                        ${catalog.chapterIntro}
                                                </a>
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:if test="${catalog.chapterLink != null}">
                                            <a href="${catalog.chapterLink}"><span class="code">阅读</span></a>
                                            </c:if>
                                        </td>
                                    </tr>
</c:forEach>
                                </table>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="block">
                <div class="block-header">
                    <h3>作者介绍</h3>
                </div>
                <div class="block-body">
                    <div class="intro">
<c:forEach var="originalAuthor" items="${book.originalAuthors}">
    ${originalAuthor.authorName}(作者)</br>
    ${originalAuthor.originalAuthorIntro}</br></br>
</c:forEach>
                    <c:forEach var="translatorAuthor" items="${book.translatorAuthors}">
                        ${translatorAuthor.authorName}(译者)</br>
                        ${translatorAuthor.translatorAuthorIntro}
                    </c:forEach>

                </div>
                </div>
            </div>



            <div class="block block-books block-books-grid">

                <div class="block-header">
                    <h4>大家也喜欢</h4>
                </div>
                <ul class="block-items">
<c:forEach var="lBook" items="${sameLikeBooks}">
                    <li class="block-item">
                        <div class="book-img">
                            <a href="/book/${lBook.bookId}" title="${lBook.bookTitle}">
                                <img src="${lBook.imageLink}" alt="${lBook.bookTitle}">
                            </a>
                        </div>
                        <div class="book-info">
                            <h4 class="name"><a href="/book/${lBook.bookId}" title="${lBook.bookTitle}">${lBook.bookTitle}</a></h4>
                            <div class="author">
            <span>
    <c:forEach var="originalAuthor" items="${lBook.originalAuthors}">
        ${originalAuthor.authorName}
    </c:forEach>            </span>
                                <span>
                                    <c:if test="${!empty lBook.translatorAuthors}">
                                        <c:forEach var="translatorAuthor" items="${lBook.translatorAuthors}">
                                            ${translatorAuthor.authorName}
                                        </c:forEach>
                                        译
                                    </c:if>
            </span>
                            </div>
                            <p class="intro">${lBook.bookIntro}</p>


                        </div>

                    </li>
</c:forEach>
                </ul>

            </div>




            <div class="block">
                <div id="comment-block">


                    <div id="comment-form"></div>

                    <div class="nav-tab-primary">
                        <ul class="nav nav-tabs text-right">
                            <li class="">
                                <a data-ajax="true" data-ajax-mode="replace" data-ajax-update="#comment-block" href="/bookcomment/commentblock/2464?sort=new">按时间</a>
                            </li>
                            <li class="active">
                                <a data-ajax="true" data-ajax-mode="replace" data-ajax-update="#comment-block" href="/bookcomment/commentblock/2464?sort=vote">按推荐</a>
                            </li>
                        </ul>
                        <div class="comment-block">
                            <div class="comment-empty"></div>
                        </div>

                    <script type="text/javascript">
                        function ShowLoginForm() {
                            $("#comment-form").html('<iframe id="the_iframe" style="padding-left:30px;" name="the_iframe" src="http://account.ituring.com.cn/iframe-log-in?returnUrl=http://www.ituring.com.cn/book/2464&hash=gotocomment" width="400" height="280" scrolling="no" frameborder="0" allowtransparency="true">');
                        }

                        function showCommentForm() {
                            $('#comment-list form').remove();
                            $.ajax({
                                url: '/BookComment/add',
                                type: 'Get',
                                data: {
                                    Id: '2464',
                                },
                                success: function (data) {
                                    $('#comment-form').html(data);
                                },
                                error: function (xhr) {
                                    $('#reply-comment-error').text(xhr.responseText);
                                }
                            })
                        }

                        $(function () {

                            ShowLoginForm();


                            //发表评论
                            $('#comment-commit').click(showCommentForm);

                            //回复评论
                            $('#comment-list').delegate('li[id^=comment-item] a[id^=reply-comment]', 'click', function () {
                                $('#comment-list form').remove();
                                var comment = $(this).closest('div[id^=comment-content]');
                                var commentId = comment.attr('id');
                                commentId = commentId.substr(commentId.lastIndexOf('-') + 1);
                                $.ajax({
                                    url: '/reply/add',
                                    type: 'Get',
                                    data: {
                                        id: commentId
                                    },
                                    success: function (data) {
                                        comment.find('div.action-bar').first().after(data);
                                    },
                                    error: function (xhr) {
                                        $('#reply-comment-error').text(xhr.responseText);
                                    }
                                })
                            })

                            //取消回复评论
                            $('#comment-list').delegate('#reply-cancel', 'click', function () {
                                $('#comment-list form').remove();
                                return false;
                            })

                            //编辑评论
                            $('#comment-list').delegate('li[id^=comment-item] a[id^=edit-comment]', 'click', function () {
                                $('#comment-list form').remove();
                                var comment = $(this).parent('div.action-bar');
                                var commentId = $(this).attr('id');
                                commentId = commentId.substr(commentId.lastIndexOf('-') + 1);

                                $.ajax({
                                    url: '/BookComment/edit',
                                    type: 'Get',
                                    data: {
                                        id: commentId
                                    },
                                    success: function (data) {
                                        comment.after(data);
                                    },
                                    error: function (xhr) {
                                        $('#reply-comment-error').text(xhr.responseText);
                                    }
                                })
                            })
                            //删除评论
                            $('#comment-list').delegate('li[id^=comment-item] a[id^=delete-comment]', 'click', function () {
                                $('#comment-list form').remove();
                                var commentId = $(this).attr('id');
                                commentId = commentId.substr(commentId.lastIndexOf('-') + 1);
                                var comment = $(this).parents('li[id^=comment-item]');
                                $.ajax({
                                    url: '/BookComment/delete',
                                    type: 'Post',
                                    data: {
                                        id: commentId
                                    },
                                    success: function (data) {
                                        comment.remove();
                                    },
                                    error: function (xhr) {
                                        $('#reply-comment-error').text(xhr.responseText);
                                    }
                                })
                            })

                            //取消编辑评论
                            $('#comment-list').delegate('#edit-comment-cancel', 'click', function () {
                                $('#comment-list form').remove();
                                return false;
                            })


                            //编辑回复
                            $('#comment-list div[id^=comment-reply]').delegate('li[id^=reply-item] a[id^=edit-reply]', 'click', function () {
                                $('#comment-list form').remove();
                                var replyId = $(this).attr('id');
                                replyId = replyId.substr(replyId.lastIndexOf('-') + 1);
                                var reply = $('#reply-content-' + replyId);
                                $.ajax({
                                    url: '/Reply/GetEdit',
                                    type: 'Get',
                                    data: {
                                        id: replyId
                                    },
                                    success: function (data) {
                                        reply.append(data);
                                    },
                                    error: function (xhr) {
                                        $('#edit-reply-error').text(xhr.responseText);
                                    }
                                })
                            })

                            //删除回复
                            $('#comment-list div[id^=comment-reply]').delegate('li[id^=reply-item] a[id^=delete-reply]', 'click', function () {
                                $('#comment-list form').remove();
                                var replyId = $(this).attr('id');
                                replyId = replyId.substr(replyId.lastIndexOf('-') + 1);
                                var reply = $(this).parents('li[id^=reply-item]');
                                $.ajax({
                                    url: '/Reply/Delete',
                                    type: 'Post',
                                    data: {
                                        id: replyId
                                    },
                                    success: function (data) {
                                        reply.remove();
                                    },
                                    error: function (xhr) {
                                        $('#edit-reply-error').text(xhr.responseText);
                                    }
                                })
                            })

                            //取消回复编辑
                            $('#comment-list').delegate('#edit-reply-cancel', 'click', function () {
                                $('#comment-list form').remove();
                                return false;
                            })

                            //回复回复
                            $('#comment-list div[id^=comment-reply]').delegate('li[id^=reply] a[id^=reply-reply]', 'click', function () {
                                $('#comment-list form').remove();
                                var reply = $(this).parents('div.action-bar');
                                var username = reply.parents('div[id^=reply-content]').first().find('a.username').first().text();
                                var comment = $(this).closest('div[id^=comment-reply]');
                                var commentId = comment.attr('id');
                                commentId = commentId.substr(commentId.lastIndexOf('-') + 1);
                                $.ajax({
                                    url: '/Reply/Add',
                                    type: 'Get',
                                    data: {
                                        id: commentId
                                    },
                                    success: function (data) {
                                        reply.after(data);
                                        comment.find('textarea[name=Content]').first().text("@" + username + " ");
                                    },
                                    error: function (xhr) {
                                        $('#reply-comment-error').text(xhr.responseText);
                                    }
                                })
                            })

                        })
                    </script>

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
