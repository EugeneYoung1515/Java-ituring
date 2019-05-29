<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <c:if test="${userSession == null}">
                <ul id="head-nav-secondary" class="head-nav">
                    <!--
                    <li class="head-compose"><a href="/register?returnUrl=http%3a%2f%2fwww.ituring.com.cn%2f">新会员注册</a></li>
                    <li class="head-compose"><a href="/log-in?returnUrl=http%3a%2f%2fwww.ituring.com.cn%2f">登录</a></li>
                    -->
                    <li class="head-compose"><a href="/register">新会员注册</a></li>
                    <li class="head-compose"><a href="/log-in">登录</a></li>
                    <div class="navbar-close"><a href="#nav-user" class="fa fa-angle-up"></a></div>
                </ul>
        </c:if>
            <c:if test="${userSession != null}">
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
            </c:if>
    </div>
</div>
