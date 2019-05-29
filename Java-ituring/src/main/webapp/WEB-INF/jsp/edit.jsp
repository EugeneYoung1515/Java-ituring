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
    <title>个人设置-图灵社区</title>
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="shortcut icon" href="/staticitr/img/favicon.png">

    
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


    


<div class="container page-box">

    <div class="g-block title-pillar">
        <div class="block-header">
            <h3>个人设置</h3>
        </div>
        <div class="bd edit-profile">
            <div class="row">
                <div class="col-md-2" id="set-avatar">
                    <div style="text-align:center">
    <img id="avatar" src="/LargeAvatar/${user.largeAvatar}" />
</div>
<div style="width:120px;margin: 10px auto">
    <input id="upload-avatar" name="upload-avatar" type="file" />
</div>

<script>
    $(document).ready(function () {
        $("#upload-avatar").kendoUpload({
            multiple: false,
            showFileList: false,
            async: {
                saveUrl: "/upload",
                autoUpload: true
            },
            success: function (e) {
                $.post("/user/setavatar", { key: e.response.key }, function (data) {
                    $("#set-avatar").html(data);
                });
            },
            upload: function (e) {
                var files = e.files;

                // Check the extension of each file and abort the upload if it is not .jpg
                $.each(files, function () {
                    if (this.extension.toLowerCase() != ".jpg" &&
                        this.extension.toLowerCase() != ".jpeg" &&
                        this.extension.toLowerCase() != ".gif" &&
                        this.extension.toLowerCase() != ".png") {
                        alert("只能上传图片文件")
                        e.preventDefault();
                    }
                });
            }

        });
    });
</script>
                </div>
                <div class="col-md-9">
                    
<form action="/user/edit" method="post"><input name="__RequestVerificationToken" type="hidden" value="${profileToken}" />
    <div class="form-horizontal">
        
        <input data-val="true" data-val-number="The field Id must be a number." data-val-required="Id 字段是必需的。" id="Id" name="Id" type="hidden" value="${user.userId}" />
        <div class="form-group">
            <label class="col-sm-2 control-label">邮箱</label>
            <div class="col-sm-4">
                    <p class="form-control-static">
                        ${user.email}
                    </p>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-md-2" for="NickName">昵称</label>
            <div class="col-md-4">
                <input class="form-control text-box single-line" data-val="true" data-val-length="昵称不能超过30个字符" data-val-length-max="30" data-val-required="请输入昵称" id="NickName" name="NickName" type="text" value="${user.userName}" />
                <span class="field-validation-valid text-danger" data-valmsg-for="NickName" data-valmsg-replace="true"></span>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-2" for="KindleEmail">推送邮箱</label>
            <div class="col-md-9">
                <input class="form-control text-box single-line" data-val="true" data-val-email="推送邮箱 字段不是有效的电子邮件地址。" id="KindleEmail" name="KindleEmail" type="email" value="ywcjxf1515@gmail.com" />
                <span class="field-validation-valid text-danger" data-valmsg-for="KindleEmail" data-valmsg-replace="true"></span>
                <p class="help-block"><a href="http://www.ituring.com.cn/article/50435" target="_blank">用于接收电子书</a></p>
            </div>
        </div>
       
        
        <div class="form-group">
            <label class="control-label col-md-2" for="PublicProvince">所在省份</label>
            <div class="col-md-3">
                <input class="form-control text-box single-line" data-val="true" data-val-length="所在省市不要超过32个字符" data-val-length-max="32" id="PublicProvince" name="PublicProvince" type="text" value="" />
                <span class="field-validation-valid text-danger" data-valmsg-for="PublicProvince" data-valmsg-replace="true"></span>
            </div>
            <label class="control-label col-md-2" for="PublicCity">所在城市</label>
            <div class="col-md-4">
                <input class="form-control text-box single-line" data-val="true" data-val-length="所在市区不要超过32个字符" data-val-length-max="32" id="PublicCity" name="PublicCity" type="text" value="" />
                <span class="field-validation-valid text-danger" data-valmsg-for="PublicCity" data-valmsg-replace="true"></span>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-2" for="Website">个人网站</label>
            <div class="col-md-9">
                <textarea name="Website" class="form-control">${user.personalWebsite}</textarea>
                <span class="field-validation-valid text-danger" data-valmsg-for="Website" data-valmsg-replace="true"></span>
                <p class="help-block">可填多个网址，请用回车分隔</p>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-2" for="Website">个人简介</label>
            <div class="col-md-9">
                <div id="wmd-editor" class="wmd-panel">
                    <div id="wmd-button-bar"></div>
                    <textarea class="wmd-input" cols="20" data-val="true" data-val-length="个人简介不要超过512个字符" data-val-length-max="512" id="wmd-input" name="Memo" rows="2">
                        ${user.userIntro}
                    </textarea>
                </div>
                <div id="wmd-preview" class="wmd-panel wmd-preview post-text typo markdown-body" style="margin-left:10px;"></div>
                <div><span class="field-validation-valid" data-valmsg-for="Memo" data-valmsg-replace="true"></span></div>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-2"></label>
            <div class="col-md-10">
                <input type="submit" id="submit-form" value="保 存" class="btn btn-primary">
                <a href="/user" class="btn btn-default">取消</a>
            </div>
        </div>
    </div>
</form>


<div id="upload-image">
    <div>
        1：从您的计算机上传图像文件：

        <center style="margin-bottom: 30px">
            <input id="attachments" name="attachments" type="file" /><script>
	jQuery(function(){jQuery("#attachments").kendoUpload({"success":onSuccess,"upload":onUpload,"multiple":false,"async":{"saveUrl":"http://file.ituring.com.cn/upload","autoUpload":true}});});
</script>
        </center>
        2：或直接输入图像的地址：
        <center style="margin-bottom: 30px">
            <input type="text" id="imageurl" value="http://" style="width:280px" />

            <input type="button" id="inputurl" value="确 定" />
        </center>
        <hr />
        <div style="text-align: right">
            <input type="button" id="cancel" value="取消插入图像" />
        </div>
    </div>
</div>

<script type="text/javascript">

    var pass;

    $(function () {

        $("#cancel").click(function () {
            pass(null);
            $("#upload-image").hide();
        });

        $("#inputurl").click(function () {
            pass($("#imageurl").val());
            $("#upload-image").hide();
        });

        var converter1 = Markdown.getSanitizingConverter();
        converter1.autoNewLine = false;
        var editor1 = new Markdown.Editor(converter1);
        editor1.run();


        editor1.hooks.set("insertImageDialog", function (callback) {
            pass = callback;

            var pop = $("#upload-image");

            pop.find("ul").remove();
            pop.find(":text").val("http://");
            pop.css("top", (($(window).height() - pop.outerHeight()) / 2) + $(window).scrollTop() + "px");
            pop.css("left", (($(window).width() - pop.outerWidth()) / 2) + $(window).scrollLeft() + "px");

            pop.show();

            return true;
        });

    });

    function onSuccess(e) {
        pass("http://file.ituring.com.cn/Original/" + e.response.key);
        $("#upload-image").hide();
    }

    function onUpload(e) {

        var files = e.files;

        $.each(files, function () {
            var ext = this.extension.toLowerCase();
            if (ext != ".jpg" && ext != ".jpeg"  && ext != ".gif" && ext != ".png") {
                alert("只能上传 .jpg .png 或 .gif 格式的图像文件")
                e.preventDefault();
                return false;
            }
        });
    }


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
