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
    <title>登录-图灵社区</title>
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="shortcut icon" href="/staticitr/img/favicon.png">
    
    <link href="/ODWvzS-8_ua5jaK2X0hitrWLDDn3uxA0etB3tegZFL01.css" rel="stylesheet"/>

    <script src="/8E0XeGkDTK66FXYcVtLaPm4QovE8jKghJFgV3nMjuSU1.js"></script>

    <!--[if lt IE 9]>
        <script src="/staticitr/lib/bootstrap/3.3.7/ie/html5shiv.min.js"></script>
        <script src="/staticitr/lib/bootstrap/3.3.7/ie/respond.min.js"></script>
    <![endif]-->
</head>
<body>
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
                                        <!--
                                        <li class="head-compose"><a href="/register?returnUrl=http%3A%2F%2Faccount.ituring.com.cn%2Faccount%2Fconfirmemail%3Fcode%3DJXpsIdaCWGGaS%252BKG9ciGZLpI5FifMxwgGSeAAZf%252BM0Qekm1Nmceo4vo3G0%252Bn6HenLeHHBtGjAkALzdD2tyV5zHnhhHDE6EGw57K2%252FOFnb9suaZWGM3DtPJGMAllWPahBEIjsZSWgy0LcJFdOnkOIUZtIe1qo%252BxYDTYyYXcxRXYE%253D%26userId%3D339567" id="registerLink">新会员注册</a></li>
                                        <li class="head-compose"><a href="/log-in?returnUrl=http%3A%2F%2Faccount.ituring.com.cn%2Faccount%2Fconfirmemail%3Fcode%3DJXpsIdaCWGGaS%252BKG9ciGZLpI5FifMxwgGSeAAZf%252BM0Qekm1Nmceo4vo3G0%252Bn6HenLeHHBtGjAkALzdD2tyV5zHnhhHDE6EGw57K2%252FOFnb9suaZWGM3DtPJGMAllWPahBEIjsZSWgy0LcJFdOnkOIUZtIe1qo%252BxYDTYyYXcxRXYE%253D%26userId%3D339567" id="loginLink">登录</a></li>
                                        -->
                                        <li class="head-compose"><a href="/register" id="registerLink">新会员注册</a></li>
                                        <li class="head-compose"><a href="/log-in" id="loginLink">登录</a></li>
                                        <div class="navbar-close"><a href="#nav-user" class="fa fa-angle-up"></a></div>
                                    </ul>
                                </div>
    </div>

    

<div class="container page-login">
    <div class="row">
        <div class="col-md-7 col-md-offset-2">
            <section id="loginForm">
                <!--
<form action="/log-in?ReturnUrl=http%3A%2F%2Faccount.ituring.com.cn%2Faccount%2Fconfirmemail%3Fcode%3DJXpsIdaCWGGaS%252BKG9ciGZLpI5FifMxwgGSeAAZf%252BM0Qekm1Nmceo4vo3G0%252Bn6HenLeHHBtGjAkALzdD2tyV5zHnhhHDE6EGw57K2%252FOFnb9suaZWGM3DtPJGMAllWPahBEIjsZSWgy0LcJFdOnkOIUZtIe1qo%252BxYDTYyYXcxRXYE%253D%26userId%3D339567" class="form-horizontal" method="post" role="form"><input name="__RequestVerificationToken" type="hidden" value="${loginToken}" />
-->
                <form action="/log-in" class="form-horizontal" method="post" role="form"><input name="__RequestVerificationToken" type="hidden" value="${loginToken}" />
    <div class="row">
                        <div class="col-md-7 col-md-offset-3">
                            <div class="login-title">
                                <h4>会员登录</h4>
                            </div>
                        </div>
                    </div>
    <div class="validation-summary-errors col-md-offset-3 text-danger">
        <ul><li>${shiroLoginFailure}</li></ul>
    </div>
    <div class="form-group">
                        <label for="Email" class="control-label col-md-3">邮箱</label>
                        <div class="col-md-7">
                            <input class="form-control" data-val="true" data-val-required="请输入Email/手机" id="Email" name="Email" placeholder="邮箱" type="text" value="" />
                            <span class="field-validation-valid text-danger" data-valmsg-for="Email" data-valmsg-replace="true"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3" for="Password">密码</label>
                        <div class="col-md-7">
                            <input class="form-control" data-val="true" data-val-required="请输入密码" id="Password" name="Password" placeholder="密码" type="password" />
                            <span class="field-validation-valid text-danger" data-valmsg-for="Password" data-valmsg-replace="true"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-7 col-md-offset-3">
                            <div class="flat-checkbox">
                                <input id="RememberMe" type="checkbox" name="RememberMe" value="true" checked>
                                <label for="RememberMe">  下次自动登录</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-3 col-md-7">
                            <input type="submit" value="登 录" class="btn btn-primary" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-8 col-md-offset-3">
                            <div class="login-prompts">
                                <p>
                                    <!--
                                    您还没有账号？请点击这里<b><a href="/register?ReturnUrl=http%3A%2F%2Faccount.ituring.com.cn%2Faccount%2Fconfirmemail%3Fcode%3DJXpsIdaCWGGaS%252BKG9ciGZLpI5FifMxwgGSeAAZf%252BM0Qekm1Nmceo4vo3G0%252Bn6HenLeHHBtGjAkALzdD2tyV5zHnhhHDE6EGw57K2%252FOFnb9suaZWGM3DtPJGMAllWPahBEIjsZSWgy0LcJFdOnkOIUZtIe1qo%252BxYDTYyYXcxRXYE%253D%26userId%3D339567">注册新账号</a></b>
                                    -->
                                    您还没有账号？请点击这里<b><a href="/register">注册新账号</a></b>
                                </p>
                                <!--
                                <p>
                                    您忘记密码了？请点击这里<b><a href="/forgot-passwprd">找回密码</a></b>
                                </p>
                                <p>
                                    您忘记邮箱了？请点击这里<b><a href="/account/forget">查找账号</a></b>
                                </p>
                                -->
                            </div>
                        </div>
                    </div>
</form>            </section>
        </div>
        <div class="col-md-6">
        </div>
    </div>
</div>



    



    
    <div id="toTop">
        <a href="#" class="ryi-angle-up"></a>
    </div>

    <script type="text/javascript">
        $(function () {
            $.ajaxSetup({ cache: false });
            $('#banner-btn-search').click(function () {
                var q = $('input[name=q]').val();
                if (q) {
                    location.href = '/search?q=' + q;
                } else {
                    $('input[name=q]').attr('placeholder', '请输入您感兴趣的');
                }
            })

            /*
            $('#captchaImage').click(function () {
                $(this).attr('src', $(this).attr('src') + '?' + Math.random());
            });
            */
        })
        function confirmDelete() {
            return confirm('确认删除？');
        }
        function scollToId(id) {
            $('html, body').animate({
                scrollTop: $(id).offset().top - 70
            }, 200);
        }
        window.disableCalmer = function () {
            $('input.calmer, button.calmer').attr('disabled', 'disabled');
        }
        window.enableCalmer = function () {
            $('input.calmer, button.calmer').removeAttr('disabled');
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
    
    <script src="/bundles/jqueryval?v=sTM6z75i3uDpVeh__Zai1IpnDnqY9pO-TNy0Ztaw6Y81"></script>


    
</body>
</html>
