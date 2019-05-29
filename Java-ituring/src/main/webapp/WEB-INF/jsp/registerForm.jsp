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
    <title>注册账号-图灵社区</title>
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="shortcut icon" href="/staticitr/img/favicon.png">
    
    <link href="/BotDetectCaptcha.ashx?get=layout-stylesheet" rel="stylesheet" type="text/css" />

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
                                        <li class="head-compose"><a href="/register?returnUrl=http%3A%2F%2Fwww.ituring.com.cn%2F" id="registerLink">新会员注册</a></li>
                                        <li class="head-compose"><a href="/log-in?returnUrl=http%3A%2F%2Fwww.ituring.com.cn%2F" id="loginLink">登录</a></li>
                                        -->
                                        <li class="head-compose"><a href="/register" id="registerLink">新会员注册</a></li>
                                        <li class="head-compose"><a href="/log-in" id="loginLink">登录</a></li>
                                        <div class="navbar-close"><a href="#nav-user" class="fa fa-angle-up"></a></div>
                                    </ul>
                                </div>
    </div>

    


<div class="container page-register">

    <div class="row">
        <div class="col-md-6 col-md-offset-2 register-form">
            <!--
<form action="/register/email?ReturnUrl=http%3A%2F%2Fwww.ituring.com.cn%2F" class="form-horizontal" id="register-form" method="post" role="form"><input name="__RequestVerificationToken" type="hidden" value="${token}" />
-->
            <form action="/register/email" class="form-horizontal" id="register-form" method="post" role="form"><input name="__RequestVerificationToken" type="hidden" value="${token}" />
    <div class="row">
                    <div class="col-md-9 col-md-offset-3">
                        <div class="login-title">
                            <h4>新会员注册</h4>
                        </div>
                    </div>
                </div>
<div class="validation-summary-valid text-danger col-md-offset-3" data-valmsg-summary="true">
    <ul><li style="display:none"></li></ul>
    ${repeatSubmit}<br>
    ${emailMessage}<br>
    ${userNameMessage}<br>
    ${captchaMessage}
</div>                <div class="form-group">
                    <label class="control-label col-md-3" for="Email">邮箱</label>
                    <div class="col-md-9">
                        <input class="form-control" data-val="true" data-val-email="请输入正确的邮箱地址" data-val-required="请输入邮箱" id="Email" name="Email" placeholder="邮箱" tabindex="1" type="text" value="" />
                        <span class="field-validation-valid text-danger" data-valmsg-for="Email" data-valmsg-replace="true"></span>
                        <div class="text-danger" id="email-result">${emailMessage}</div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3" for="NickName">昵称</label>
                    <div class="col-md-9">
                        <input class="form-control" data-val="true" data-val-length="用户名不超过30个字符" data-val-length-max="30" data-val-required="请输入用户名" id="NickName" name="NickName" placeholder="昵称" tabindex="2" type="text" value="" />
                        <span class="field-validation-valid text-danger" data-valmsg-for="NickName" data-valmsg-replace="true"></span>
                        <div class="text-danger" id="nickname-result">${userNameMessage}</div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3" for="Password">密码</label>
                    <div class="col-md-9">
                        <input class="form-control" data-val="true" data-val-length="密码至少需要6个字符" data-val-length-max="100" data-val-length-min="6" data-val-required="请输入密码" id="Password" name="Password" placeholder="密码" tabindex="3" type="password" />
                        <span class="field-validation-valid text-danger" data-valmsg-for="Password" data-valmsg-replace="true"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3" for="ConfirmPassword">确认密码</label>
                    <div class="col-md-9">
                        <input class="form-control" data-val="true" data-val-equalto="密码和确认密码不一致" data-val-equalto-other="*.Password" id="ConfirmPassword" name="ConfirmPassword" placeholder="确认密码" tabindex="4" type="password" />
                        <span class="field-validation-valid text-danger" data-valmsg-for="ConfirmPassword" data-valmsg-replace="true"></span>
                    </div>
                </div>
                    <div class="form-group">
                        <label class="control-label col-md-3 col-xs-12" for="Captcha">验证码</label>
                        <div class="col-md-9">
                            <input class="form-control captchaVal" data-val="true" data-val-required="请填写验证码" id="Captcha" name="Captcha" placeholder="验证码" type="text" value="" />
                            <span class="field-validation-valid text-danger" data-valmsg-for="Captcha" data-valmsg-replace="true"></span>
                            <div class="text-danger" id="captcha-result">${captchaMessage}</div>
                        </div>
                        <br />
                        <div class="col-md-offset-3 col-md-9">
                            


  <div class="BDC_CaptchaDiv " id="RegistrationCaptcha_CaptchaDiv" style="width: 285px !important; height: 50px !important; "><!--
 --><div class="BDC_CaptchaImageDiv" id="RegistrationCaptcha_CaptchaImageDiv" style="width: 255px !important; height: 50px !important;"><!--
   --><img class="BDC_CaptchaImage" id="RegistrationCaptcha_CaptchaImage" src="/captcha" alt="Retype the CAPTCHA code from the image" onclick="test()"/><!--
 --></div><!--
 -->
  </div>
                            <script type="text/javascript">
                                    function test() {
                                        document.getElementById("RegistrationCaptcha_CaptchaImage").src="/captcha?ss="+ Math.random();
                                    }
                            </script>


                        </div>
                    </div>
                <div class="form-group">
                    <div class="col-md-7 col-md-offset-3">
                        <div class="flat-checkbox">
                            <input checked="checked" data-val="true" data-val-required="Subscribe 字段是必需的。" id="Subscribe" name="Subscribe" type="checkbox" value="true" /><input name="Subscribe" type="hidden" value="false" />
                            <label for="Subscribe">  订阅图灵快讯</label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-7 col-md-offset-3">
                        <div class="flat-checkbox">
                            <input type="checkbox" id="Agree" name="Agree" onchange="if (this.checked) { window.enableCalmer() } else { window.disableCalmer() }" tabindex="6" />
                            <label for="Agree">  我同意 <a href="http://www.ituring.com.cn/article/13322">图灵社区会员注册协议</a></label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-offset-3 col-md-9">
                        <button id="register-teacher" class="btn btn-primary calmer" disabled="disabled">注 册</button>
                        <br><br>
                        <div class="login-prompts">
                            <p>已有账号，请点击这里 <a href="/log-in">登录</a></p>
                        </div>
                    </div>
                </div>
                <div style="height:40px;">
                </div>
</form>        </div>
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
            //$('#captchaImage').click(function () {
                //$(this).attr('src', $(this).attr('src') + '?' + Math.random());
                //});
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
    
    <script src="/sTM6z75i3uDpVeh__Zai1IpnDnqY9pO-TNy0Ztaw6Y81.js"></script>

    <script type="text/javascript">
        $(function () {
            $('input[name=NickName]').blur(function () {
                $.ajax({
                    url: "/account/checknickname",
                    data: {
                        nickname: $('input[name=NickName]').val(),
                        __RequestVerificationToken: $('input[name=__RequestVerificationToken]').val()
                    },
                    type: 'POST',
                    dataType: 'json',
                    success: function (result) {
                        if (result.Status == false) {
                            $('#nickname-result').text(result.Message);
                        } else {
                            $('#nickname-result').empty();
                        }
                    }
                })
            })
            $('input[name=Email]').blur(function () {
                $.ajax({
                    url: "/account/checkemail",
                    data: {
                        email: $('input[name=Email]').val(),
                        __RequestVerificationToken: $('input[name=__RequestVerificationToken]').val()
                    },
                    type: 'POST',
                    dataType: 'json',
                    success: function (result) {
                        if (result.Status == false) {
                            $('#email-result').text(result.Message);//给dom元素添加 innerHTMLText
                        } else {
                            $('#email-result').empty();
                        }
                    }
                })
            })
            $('input[name=Captcha]').blur(function () {
                $.ajax({
                    url: "/account/checkcaptcha",
                    data: {
                        captcha: $('input[name=Captcha]').val(),
                        __RequestVerificationToken: $('input[name=__RequestVerificationToken]').val()
                    },
                    type: 'POST',
                    dataType: 'json',
                    success: function (result) {
                        if (result.Status == false) {
                            $('#captcha-result').text(result.Message);//给dom元素添加 innerHTMLText
                        } else {
                            $('#captcha-result').empty();
                        }
                    }
                })
            })
        })
    </script>

    
</body>
</html>
