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
    <title>邮箱已确认-图灵社区</title>
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
                                    <div class="head-logo"><a href="http://www.ituring.com.cn/">图灵社区</a></div>
                                    <ul id="head-nav-primary" class="head-nav">
                                        <li class="head-nav-home"><a href="http://www.ituring.com.cn/">首页</a></li>
                                        <li><a href="http://www.ituring.com.cn/book">图书</a></li>
                                        <li><a href="http://www.ituring.com.cn/article">文章</a></li>
                                        <li class="head-search">
                                            <form action="http://www.ituring.com.cn/search">
                                                <input type="search" name="q" placeholder="技术改变世界 阅读塑造人生" class="key">
                                                <button class="go btn btn-link"><span class="fa fa-search"></span></button>
                                            </form>
                                        </li>
                                    </ul>
                                    <ul id="head-nav-secondary" class="head-nav">
                                        <li class="head-compose"><a href="/register?returnUrl=http%3A%2F%2Faccount.ituring.com.cn%2Faccount%2Fconfirmemailconfirmation" id="registerLink">新会员注册</a></li>
                                        <li class="head-compose"><a href="/log-in?returnUrl=http%3A%2F%2Faccount.ituring.com.cn%2Faccount%2Fconfirmemailconfirmation" id="loginLink">登录</a></li>
                                        <div class="navbar-close"><a href="#nav-user" class="fa fa-angle-up"></a></div>
                                    </ul>
                                </div>
    </div>

    

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="h2">邮箱已确认</div>
            <div>
                <p class="text-info">
                    感谢您确认了您的Email地址，请 <a href="/log-in" id="loginLink" style="color:green;">点击这里登录</a> 。
                </p>
            </div>
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
            $('#captchaImage').click(function () {
                $(this).attr('src', $(this).attr('src') + '?' + Math.random());
            });
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
