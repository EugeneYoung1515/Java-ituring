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
    <title>修改密码-图灵社区</title>
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
    <form action="/log-out?returnUrl=http%3a%2f%2fwww.ituring.com.cn%2fuser%2fnotification" method="post" id="logoutForm">
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

    

<div class="row">
    <div class="col-md-offset-3 col-md-8">
<form action="/change-password" class="form-horizontal" method="post" role="form"><input name="__RequestVerificationToken" type="hidden" value="${passwordToken}" />
    <div class="form-group">
                <div class="col-md-offset-2 col-md-6">
                    <div class="h4">修改密码</div>
                </div>
            </div>
<div class="validation-summary-valid col-md-offset-2 text-danger" data-valmsg-summary="true">
    <ul><li style="display:none"></li></ul>
</div>
${Incorrect}
    <div class="form-group">
                <label class="control-label col-md-2" for="OldPassword">当前密码</label>
                <div class="col-md-6">
                    <input class="form-control" data-val="true" data-val-required="请输入当前密码" id="OldPassword" name="OldPassword" placeholder="当前密码" type="password" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-2" for="NewPassword">新密码</label>
                <div class="col-md-6">
                    <input class="form-control" data-val="true" data-val-length="密码需要至少6个字符" data-val-length-max="100" data-val-length-min="6" data-val-required="请输入新密码" id="NewPassword" name="NewPassword" placeholder="新密码" type="password" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-2" for="ConfirmPassword">确认密码</label>
                <div class="col-md-6">
                    <input class="form-control" data-val="true" data-val-equalto="新密码和确认密码不一致" data-val-equalto-other="*.NewPassword" id="ConfirmPassword" name="ConfirmPassword" placeholder="确认密码" type="password" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-offset-2 col-md-6">
                    <input type="submit" value="修改密码" class="btn btn-primary" />
                </div>
            </div>
</form>
    </div>
</div>
<div style="height:50px;">
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
                
            setInterval(getNewNotificationCount, 120000);
            setInterval(getNewMessageCount, 120000);
            
        })
            
        function getNewNotificationCount() {
            $.get("/home/checknewnotificationcount", function (n) {
                if (n > 0) {
                    $("#new-notification-count span").text(n).removeClass("hide");
                } else {
                    $("#new-notification-count span").text(0).addClass("hide");
                }
                setReminder();
            });
        }

        function getNewMessageCount() {
            $.get("/home/checknewmessagecount", function (n) {
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
    
    <script src="/bundles/jqueryval?v=sTM6z75i3uDpVeh__Zai1IpnDnqY9pO-TNy0Ztaw6Y81"></script>


    
</body>
</html>
