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
    <title>我的关注-图灵社区</title>
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="shortcut icon" href="/staticitr/img/favicon.png">
    <meta itemprop="name" content="我的关注" />
    <meta itemprop="image" />

    
    <link href="/W-IyudFsjvr8DmczNaEtVDAWVVWkoAYhOkQl_7kkbqc1.css" rel="stylesheet"/>

    <link href="/sZ469sB_bTSptWvx3QdRX8e0asdOguk7ejwJWbvyndU1.css" rel="stylesheet"/>


    <script src="/20qhuba-JjWpkUZ6WyvMzCPWFrB_TrAdbOFot0ehZMw1.js"></script>

    <script src="/Ep7XxB9YaQz_sUggoppp1nXkei68VOq0u3sLcOISbsE1.js"></script>

    <!--[if lt IE 9]>
        <script src="/staticitr/lib/bootstrap/3.3.7/ie/html5shiv.min.js"></script>
        <script src="/staticitr/lib/bootstrap/3.3.7/ie/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<div class="layout-head">
    <!--
    <form action="/log-out?returnUrl=http%3a%2f%2fwww.ituring.com.cn%2fuser%2fnotification" method="post" id="logoutForm">
    -->
    <form action="/log-out" method="post" id="logoutForm">
        <input name="__RequestVerificationToken" type="hidden" value="P2ArIIADO8oHUTooJDrcnyqSV4lcXT2fRFTGUGEBWnRWbnkGCqL1ZJoeQhbgn1PMnCizG-zXMIABuIgj8B0o_znXhDB4RjZ5XX-myN3xg1UIdbMcHQRAvQagsFTCUbv_nQSoqJFoMdz22UUCSntsuA2" />
    </form>
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
            <li class="dropdown">
                <a href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" class="dropdown-toggle">提醒 <span id="new-total-count" class="label label-danger hide">0</span></a>
                <ul class="dropdown-menu">
                    <li><a id="new-notification-count" href="/user/notification">新提醒 <span class="label label-danger hide">0</span></a></li>
                    <li><a id="new-message-count" href="/message">短消息 <span class="label label-danger hide">0</span></a></li>
                </ul>
            </li>
            <li><a href="/user/cart">购书袋</a></li>
            <li class="dropdown head-user">
                <a href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" class="dropdown-toggle">
                    <img src="/SmallAvatar/${userSession.largeAvatar}" class="avatar head-avatar">${userSession.userName}
                </a>
                <ul class="dropdown-menu">
                    <li><a href="/user/index">我的空间</a></li>
                    <li><a href="/space/${userSession.userId}">我的文章</a></li>
                    <li><a href="/user/shelf">拥有的书</a></li>
                    <li><a href="/user/edit">个人设置</a></li>
                    <li><a href="/article/497743">帮助</a></li>
                    <li class="divider"></li>
                    <li><a href="javascript:document.getElementById('logoutForm').submit()">退出</a></li>
                </ul>
            </li>
            <li class="head-compose"><a href="/article/write">写作</a></li>
            <div class="navbar-close"><a href="#nav-user" class="fa fa-angle-up"></a></div>
        </ul>
    </div>
</div>






<div class="profile-head">
    <div class="container">
        <div class="row g-50">
            <div class="col-md-9">
                <div class="profile-panel">
                    <div class="profile-avatar">
                        <div class="avatar">
                            <a href="javascript:void(0);">
                                <img src="/LargeAvatar/${user.largeAvatar}" alt="${user.userName}" class="lazy">
                            </a>
                        </div>
                    </div>
                    <div class="profile-info">
                        <h4 class="name">${user.userName}</h4>
                        <ul class="profile-btns">
                            <li class="act-item"><a href="/change-password" class="btn btn-default"> 修改密码</a></li>

                            <li class="act-item"><a href="/user/edit" class="btn btn-default"><span class="fa fa-cog"></span> 个人设置</a></li>
                            <li class="act-item"><a href="/space/${user.userId}" class="btn btn-default"><span class="fa fa-home"></span> 我的主页</a></li>
                        </ul>
                        <div class="meta-row">
                            <div class="meta-col">
                                <dl>
                                    <dt>文章</dt>
                                    <dd class="num">0</dd>
                                </dl>
                            </div>
                            <div class="meta-col">
                                <dl>
                                    <dt>评论</dt>
                                    <dd class="num">0</dd>
                                </dl>
                            </div>
                            <div class="meta-col">
                                <dl>
                                    <dt>推荐</dt>
                                    <dd class="num">${user.voteNum}</dd>
                                </dl>
                            </div>
                            <div class="meta-col">
                                <dl>
                                    <dt>收藏</dt>
                                    <dd class="num">${user.favNum}</dd>
                                </dl>
                            </div>
                        </div>
                        <div class="meta-row">
                            <div class="meta-col">
                                <dl>
                                    <dt>社区会龄</dt>
                                    <dd>${formatAge}</dd>
                                </dl>

                                <dl>
                                    <dt>个人网站</dt>
                                    <dd>
                                        <c:if test="${user.personalWebsite == null}">
                                            <span> -- </span>
                                        </c:if>
                                        <c:if test="${user.personalWebsite != null}">
                                            <span> <a href="${user.personalWebsite}" target="_blank">${user.personalWebsite}</a> </span>
                                        </c:if>
                                    </dd>
                                </dl>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="profile-intro">
                    <div class="profile-intro-inner">
                        <dl>
                            <dt>个人简介</dt>
                            <dd>
                                <div class="typo typo-selection">
                                    <div class="markdown-body">
                                        <c:if test="${user.userIntro == null}">
                                            还没有输入个人简介……
                                        </c:if>
                                        <c:if test="${user.userIntro != null}">
                                            ${user.userIntro}
                                        </c:if>
                                    </div>
                                </div>
                            </dd>
                        </dl>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container page-box my-profile">
    <div class="row g-50">
        <div class="col-md-9 main">
            


<div class="nav-tab-primary">
    <h4>我的关注</h4>
    <ul class="nav nav-tabs text-right">
        <c:if test="${following != null}">
        <li   class="active"      >
            <a href="/user/following/${user.userId}?type=follow">我关注的人</a>
        </li>
        </c:if>
        <c:if test="${following == null}">
            <li >
                <a href="/user/following/${user.userId}?type=follow">我关注的人</a>
            </li>
        </c:if>
        <c:if test="${followme == null}">
        <li >
            <a href="/user/following/${user.userId}?type=followme">关注我的人</a>
        </li>
        </c:if>
        <c:if test="${followme != null}">
            <li   class="active"      >
                <a href="/user/following/${user.userId}?type=followme">关注我的人</a>
            </li>
        </c:if>
    </ul>
</div>
<div class="block-users block-users-list">
    <ul class="block-items">
        <c:if test="${!empty following}">
        <c:forEach var="iUser" items="${following}">
            <li class="block-item">
                



<div class="avatar">
    <a href="/space/${iUser.userId}">
        <img src="/LargeAvatar/${iUser.largeAvatar}" alt="${iUser.userName}">
    </a>
</div>
<div class="info">
    <h4 class="name">
        <a href="/space/${iUser.userId}">${iUser.userName}</a>
    </h4>
    <span class="articles">文章 6</span>
    <span class="books">著作 3</span>
    
</div>

            </li>
        </c:forEach>
        </c:if>
        <c:if test="${!empty followme}">
            <c:forEach var="mUser" items="${followme}">
                <li class="block-item">




                    <div class="avatar">
                        <a href="/space/${mUser.userId}">
                            <img src="/LargeAvatar/${mUser.largeAvatar}" alt="${mUser.userName}">
                        </a>
                    </div>
                    <div class="info">
                        <h4 class="name">
                            <a href="/space/${mUser.userId}">${mUser.userName}</a>
                        </h4>
                        <span class="articles">文章 6</span>
                        <span class="books">著作 3</span>

                    </div>

                </li>
            </c:forEach>
        </c:if>
    </ul>
</div>

<div class="clearfix">
    
</div>


        </div>
        <div class="col-md-3 side">
            <ul class="sidenav-list profile-sidenav">
                <li class="sidenav-major"><a href="javascript:void(0);">我的空间</a></li>
                <li class="sidenav-minor"><a href="/user/notification">新提醒</a></li>
                <li class="sidenav-minor"><a href="/message">短消息</a></li>

                <li class="sidenav-minor"><a href="/user/shelf">拥有的书</a></li>
                <li class="sidenav-minor"><a href="/user/orders">我的订单</a></li>
                <li class="sidenav-minor"><a href="/point">我的银子<span class="badge badge-gold">0</span></a></li>
                <li class="sidenav-minor"><a href="/user/guaguacode">刮刮卡</a></li>

                <li class="sidenav-minor"><a href="/user/following">我的关注</a></li>
                <li class="sidenav-minor"><a href="/user/fav">收藏夹</a></li>

                <li class="sidenav-minor"><a href="/errata/my">勘误记录</a></li>
                <li class="sidenav-minor"><a href="/user/giftorder">兑换记录</a></li>
                <li class="sidenav-minor"><a href="/address">地址管理</a></li>

                <li class="sidenav-major"><a href="javascript:void(0);">作者中心</a></li>
                <li class="sidenav-minor"><a href="/user/books">作品管理</a></li>
                <li class="sidenav-minor"><a href="/user/salessummary">销售概况</a></li>
                
            </ul>
        </div>
    </div>
</div>


<script type="text/javascript">
    $(function () {
        if ('following' === 'index' && 'user' !== 'user') {
            $("li.sidenav-minor")
                .filter(function (index) {
                    return $(this).find('a').attr('href').indexOf('user') > 0;
                })
                .addClass("active");
        } else {
            $("li.sidenav-minor")
                .filter(function (index) {
                    return $(this).find('a').attr('href').indexOf('following') > 0;
                })
                .addClass("active");
        }
        $('.sidenav-oneline span').click(function () {
            $this = $(this);
            $class = $(this).attr('data');
            $('.sidenav-oneline span').removeClass('active');
            $(this).addClass('active');
            $("li.sidenav-minor")
                .filter(function (index) {
                    return $(this).hasClass($class);
                })
                .toggle();
            $("li.sidenav-minor")
                .filter(function (index) {
                    return !$(this).hasClass($class);
                })
                .hide();
        })
    })
</script>

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

            /*
            setInterval(getNewNotificationCount, 120000);
            setInterval(getNewMessageCount, 120000);
            getNewNotificationCount();
            getNewMessageCount();
            */
            
        })


        /*
        function getNewNotificationCount() {
            $.get("/user/checknewnotificationcount", function (n) {
                if (n > 0) {
                    $("#new-notification-count span").text(n).removeClass("hide");
                } else {
                    $("#new-notification-count span").text(0).addClass("hide");
                }
                setReminder();
            });
        }

        function getNewMessageCount() {
            $.get("/user/checknewmessagecount", function (n) {
                if (n > 0) {
                    $("#new-message-count span").text(n).removeClass("hide");
                } else {
                    $("#new-message-count span").text(0).addClass("hide");
                }
                setReminder();
            });
        }

        function setReminder() {
            var total = Number($("#new-message-count span").text()) + Number($("#new-notification-count span").text());
            if (total > 0) {
                total = total >= 100 ? "99+" : total;
                $("#new-total-count").text(total).removeClass("hide");
            } else {
                $("#new-total-count").text(0).addClass("hide");
            }
        }
        */
        
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
