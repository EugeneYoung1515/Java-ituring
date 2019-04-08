<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:if test="${ffUser != null}">
<a id="user-toggle-attend-${userId}" class="btn btn-follow edit-btn btn-follow-on" href="javascript:void(0);">已关注</a>

<script type="text/javascript">
    $(function () {

        $("#user-toggle-attend-${userId}").click(function () {
            $.post("/user/toggleattendtion/${userId}")
                .done(function (data) {
                    $("#toggle-attention").html(data);
                }).fail(function (data) {
                alert('请先登录！');
            });
            return false;
        });

    });
</script>
</c:if>

<c:if test="${ffUser == null}">
<a id="user-toggle-attend-${userId}" href="javascript:void(0);" class="btn btn-follow edit-btn"><span class="fa fa-plus"></span> 关注</a>

<script type="text/javascript">
    $(function () {

        $("#user-toggle-attend-${userId}").click(function () {
            $.post("/user/toggleattendtion/${userId}")
                .done(function (data) {
                    $("#toggle-attention").html(data);
                }).fail(function (data) {
                alert('请先登录！');
            });
            return false;
        });

    });
</script>
</c:if>