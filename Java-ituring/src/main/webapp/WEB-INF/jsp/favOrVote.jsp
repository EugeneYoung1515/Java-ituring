<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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