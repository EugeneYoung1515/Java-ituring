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
    <title>图书-图灵社区</title>
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
                                        <li class="head-compose"><a href="http://account.ituring.com.cn/register?returnUrl=http%3a%2f%2fwww.ituring.com.cn%2fbook">新会员注册</a></li>
                                        <li class="head-compose"><a href="http://account.ituring.com.cn/log-in?returnUrl=http%3a%2f%2fwww.ituring.com.cn%2fbook">登录</a></li>
                                        <div class="navbar-close"><a href="#nav-user" class="fa fa-angle-up"></a></div>
                                    </ul>
                                </div>
    </div>
    -->


    


<div class="container">

    
    <div class="editable-area">
        <div class="block hot-tags hidden-xs hidden-xm">
    <span class="tags">
        <c:forEach var="booktag" items="${mainPageTags}">
            <a href="/tag/${booktag.booktagId}" tagid="${booktag.booktagId}" class="post-tag">${booktag.booktagName}</a>
        </c:forEach>
    </span>
        </div>
    </div>



	<div class="row g-50" id="tab-book">

		<div class="col-md-9 col-sm-9 main">
			<div class="nav-tab-primary">
				<ul class="nav nav-tabs">
                    <c:if test="${sort != 'new'}">
                        <li >
                            <a href="/book?tab=${tab}&sort=new<c:if test='${category != null}'>&category=${category.categoryId}</c:if>">最新</a>
                        </li>
                    </c:if>
                    <c:if test="${sort == 'new'}">
                        <li   class="active"    >
                            <a href="/book?tab=${tab}&sort=new<c:if test='${category != null}'>&category=${category.categoryId}</c:if>">最新</a>
                        </li>
                    </c:if>
                    <c:if test="${sort != 'hot'}">
                        <li >
                            <a href="/book?tab=${tab}&sort=hot<c:if test='${category != null}'>&category=${category.categoryId}</c:if>">热门</a>
                        </li>
                    </c:if>
                    <c:if test="${sort == 'hot'}">
                        <li   class="active"    >
                            <a href="/book?tab=${tab}&sort=hot<c:if test='${category != null}'>&category=${category.categoryId}</c:if>">热门</a>
                        </li>
                    </c:if>
                    <c:if test="${sort != 'vote'}">
                        <li >
                            <a href="/book?tab=${tab}&sort=vote<c:if test='${category != null}'>&category=${category.categoryId}</c:if>">推荐</a>
                        </li>
                    </c:if>
                    <c:if test="${sort == 'vote'}">
                        <li   class="active"    >
                            <a href="/book?tab=${tab}&sort=vote<c:if test='${category != null}'>&category=${category.categoryId}</c:if>">推荐</a>
                        </li>
                    </c:if>
                    <!--
				    <li class="pull-right"><a href="/search/advanced">图书高级搜索</a></li>
				    -->
				</ul>
			</div>

			<div class="g-main">
				<div class="block-books block-books-grid">
					<ul>
<c:forEach var="cBook" items="${BooksByCondition.list}">
							<li>
								<div class="book-img">
    <a href="/book/${cBook.bookId}" title="${cBook.bookTitle}">
        <img src="${cBook.imageLink}" alt="${cBook.bookTitle}">
    </a>
</div>
<div class="book-info">
    <h4 class="name"><a href="/book/${cBook.bookId}" title="${cBook.bookTitle}">${cBook.bookTitle}</a></h4>
    <div class="author">
    <span>
    <c:forEach var="originalAuthor" items="${cBook.originalAuthors}">
        ${originalAuthor.authorName}
    </c:forEach>  
    </span>
    <span>
    <c:forEach var="translatorAuthor" items="${cBook.translatorAuthors}">
        ${translatorAuthor.authorName}
    </c:forEach>   
    译
    </span>
    </div>
    <p class="intro">${cBook.bookIntro}</p>

    
</div>

							</li>
</c:forEach>
					</ul>
				</div>
			</div>

            <div class="nav-tab-secondary">
                <div class="PagedList-pager">
                    <ul>
                        <c:if test="${!BooksByCondition.isFirstPage}">
                            <li class="PagedList-skipToPrevious"><a href="/book?tab=${tab}&sort=${sort}<c:if test='${category != null}'>&category=${category.categoryId}</c:if>&page=${BooksByCondition.pageNum-1}">上一页</a></li>
                        </c:if>
                        <c:if test="${BooksByCondition.pageNum > 2}">
                            <li class="PagedList-skipToFirst"><a href="/book?tab=${tab}&sort=${sort}<c:if test='${category != null}'>&category=${category.categoryId}</c:if>&page=1">1</a></li>
                        </c:if>
                        <c:if test="${BooksByCondition.pageNum > 3}">
                            <li class="PagedList-ellipses"><span>...</span></li>
                        </c:if>
                        <c:if test="${BooksByCondition.pageNum > 1}">
                            <li class="PagedList-skipToNext"><a href="/book?tab=${tab}&sort=${sort}<c:if test='${category != null}'>&category=${category.categoryId}</c:if>&page=${BooksByCondition.pageNum-1}">${BooksByCondition.pageNum-1}</a></li>
                        </c:if>
                        <li class="PagedList-disabled PagedList-currentPage PagedList-skipToPage"><a>${BooksByCondition.pageNum}</a></li>

                        <c:if test="${BooksByCondition.pageNum < BooksByCondition.pages}">
                            <li class="PagedList-skipToNext"><a href="/book?tab=${tab}&sort=${sort}<c:if test='${category != null}'>&category=${category.categoryId}</c:if>&page=${BooksByCondition.pageNum+1}">${BooksByCondition.pageNum+1}</a></li>
                        </c:if>

                        <c:if test="${BooksByCondition.pageNum +2 < BooksByCondition.pages}">
                            <li class="PagedList-ellipses"><span>...</span></li>
                        </c:if>

                        <c:if test="${BooksByCondition.pageNum +1 < BooksByCondition.pages}">
                            <li class="PagedList-skipToLast"><a href="/book?tab=${tab}&sort=${sort}<c:if test='${category != null}'>&category=${category.categoryId}</c:if>&page=${BooksByCondition.pages}">${BooksByCondition.pages}</a></li>
                        </c:if>

                        <c:if test="${!BooksByCondition.isLastPage}">
                            <li class="PagedList-skipToNext"><a href="/book?tab=${tab}&sort=${sort}<c:if test='${category != null}'>&category=${category.categoryId}</c:if>&page=${BooksByCondition.pageNum+1}">下一页</a></li>
                        </c:if>
                    </ul>
                </div>
            </div>


		</div>

		<div class="col-md-3 col-sm-3 side">

            <ul class="sidenav-list">
                    <li class="sidenav-major active">
                        <a href="/book?tab=book<c:if test='${category != null}'>&category=${category.categoryId}</c:if>">所有图书</a>
                    </li>
                    <li class="sidenav-major ">
                        <a href="/book?tab=ebook<c:if test='${category != null}'>&category=${category.categoryId}</c:if>">电子书</a>
                    </li>
                    <li class="sidenav-major ">
                        <a href="/book?tab=free&<c:if test='${category != null}'>&category=${category.categoryId}</c:if>">免费</a>
                    </li>
                    <li class="sidenav-major ">
                        <a href="/book?tab=translator<c:if test='${category != null}'>&category=${category.categoryId}</c:if>">诚征译者</a>
                    </li>
                    <li class="sidenav-major ">
                        <a href="/book?tab=soon<c:if test='${category != null}'>&category=${category.categoryId}</c:if>">即将上市</a>
                    </li>
                    <li class="sidenav-major ">
                        <a href="/book?tab=90vote<c:if test='${category != null}'>&category=${category.categoryId}</c:if>">90天内推荐</a>
                    </li>
                    <li class="sidenav-major ">
                        <a href="/book?tab=fav<c:if test='${category != null}'>&category=${category.categoryId}</c:if>">收藏夹</a>
                    </li>
                    <li class="sidenav-major ">
                        <a href="/book?tab=gift<c:if test='${category != null}'>&category=${category.categoryId}</c:if>">可兑换图书</a>
                    </li>
            </ul>

			

<ul class="sidenav-list">

<c:if test="${ category == null}">
    <li class="sidenav-header active">
        <a href="/book?tab=${tab}&sort=${sort}">
            <h3>所有分类</h3>
        </a>
    </li>
        <c:forEach var="category1" items="${allTopCategory}">
            <li class="sidenav-major  ">
        <a href="/book?tab=${tab}&sort=${sort}<c:if test='${category1 != null}'>&category=${category1.categoryId}</c:if>">
            <span></span> ${category1.categoryName}
        </a>
            </li>
        </c:forEach>
    </c:if>
    <c:if test="${category != null and category.grade == 1}">
        <li class="sidenav-header ">
            <a href="/book?tab=${tab}&sort=${sort}">
                <h3>所有分类</h3>
            </a>
        </li>
        <c:forEach var="category1" items="${allTopCategory}">
            <c:if test="${category.categoryId == category1.categoryId}">
            <li class="sidenav-major active open">
                <a href="/book?tab=${tab}&sort=${sort}<c:if test='${category1 != null}'>&category=${category1.categoryId}</c:if>">
                    <span></span> ${category1.categoryName}
                </a>
            </li>
                <c:forEach var="category2" items="${childCategory}">
                    <li class="sidenav-minor  ">
                        <a href="/book?tab=${tab}&sort=${sort}<c:if test='${category2 != null}'>&category=${category2.categoryId}</c:if>">
                            <span></span>     ${category2.categoryName}
                        </a>
                    </li>
                </c:forEach>
            </c:if>
            <c:if test="${category.categoryId != category1.categoryId}">
            <li class="sidenav-major  ">
                    <a href="/book?tab=${tab}&sort=${sort}<c:if test='${category1 != null}'>&category=${category1.categoryId}</c:if>">
                        <span></span> ${category1.categoryName}
                    </a>
                </li>
            </c:if>
        </c:forEach>
    </c:if>
    <c:if test="${category != null and category.grade == 2}">
        <li class="sidenav-header ">
            <a href="/book?tab=${tab}&sort=${sort}">
                <h3>所有分类</h3>
            </a>
        </li>
        <li class="sidenav-major  open">
            <a href="/book?tab=${tab}&sort=${sort}<c:if test='${parentCategory != null}'>&category=${parentCategory.categoryId}</c:if>">
                <span></span> ${parentCategory.categoryName}
            </a>
        </li>
        <c:forEach var="category1" items="${brotherCategory}">
            <c:if test="${category1.categoryId == category.categoryId}">
                <li class="sidenav-minor active open">
                    <a href="/book?tab=${tab}&sort=${sort}<c:if test='${category1 != null}'>&category=${category1.categoryId}</c:if>">
                        <span></span>     ${category1.categoryName}
                    </a>
                </li>
                <c:forEach var="category2" items="${childCategory}" >
                    <c:if test="${category2 != null}">
                    <li class="sidenav-mini ">
                        <a href="/book?tab=${tab}&sort=${sort}<c:if test='${category2 != null}'>&category=${category2.categoryId}</c:if>">
                            <span></span>     ${category2.categoryName}
                        </a>
                    </li>
                    </c:if>
                </c:forEach>
            </c:if>
            <c:if test="${category1.categoryId != category.categoryId}">
                <li class="sidenav-minor  ">
                    <a href="/book?tab=${tab}&sort=${sort}<c:if test='${category1 != null}'>&category=${category1.categoryId}</c:if>">
                        <span></span> ${category1.categoryName}
                    </a>
                </li>
            </c:if>
        </c:forEach>
    </c:if>
    <c:if test="${category != null and category.grade == 3}">
        <li class="sidenav-header ">
            <a href="/book?tab=${tab}&sort=${sort}">
                <h3>所有分类</h3>
            </a>
        </li>
        <li class="sidenav-major  open">
            <a href="/book?tab=${tab}&sort=${sort}<c:if test='${parentParentCategory != null}'>&category=${parentParentCategory.categoryId}</c:if>">
                <span></span> ${parentParentCategory.categoryName}
            </a>
        </li>
        <li class="sidenav-minor  open">
            <a href="/book?tab=${tab}&sort=${sort}<c:if test='${parentCategory != null}'>&category=${parentCategory.categoryId}</c:if>">
                <span></span>     ${parentCategory.categoryName}
            </a>
        </li>
        <c:forEach var="category1" items="${brotherCategory}">
            <c:if test="${category1.categoryId == category.categoryId}">
                <li class="sidenav-mini active">
                    <a href="/book?tab=${tab}&sort=${sort}<c:if test='${category1 != null}'>&category=${category1.categoryId}</c:if>">
                        <span></span>     ${category1.categoryName}
                    </a>
                </li>
            </c:if>
            <c:if test="${category1.categoryId != category.categoryId}">
                <li class="sidenav-mini ">
                    <a href="/book?tab=${tab}&sort=${sort}<c:if test='${category1 != null}'>&category=${category1.categoryId}</c:if>">
                        <span></span> ${category1.categoryName}
                    </a>
                </li>
            </c:if>
        </c:forEach>
    </c:if>
</ul>


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

        /*
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
        */
    </script>
    
    
</body>
</html>
