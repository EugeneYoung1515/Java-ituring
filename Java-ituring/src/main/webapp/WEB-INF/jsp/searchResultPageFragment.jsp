<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="block block-books block-books-grid">
    <ul class="block-items">
        <c:forEach var="qBook" items="${qBooks.list}">
            <li class="block-item">
                <div class="book-img">
                    <a href="/book/${qBook.bookId}" title="${qBook.bookTitle}">
                        <img src="${qBook.imageLink}" alt="${qBook.bookTitle}">
                    </a>
                </div>
                <div class="book-info">
                    <h4 class="name"><a href="/book/${qBook.bookId}" title="${qBook.bookTitle}">${qBook.bookTitle}</a></h4>
                    <div class="author">
            <span>
                <c:forEach var="originalAuthor" items="${qBook.originalAuthors}">
                    ${originalAuthor.authorName}
                </c:forEach>  
            </span>
                        <span>
                <c:forEach var="translatorAuthor" items="${qBook.translatorAuthors}">
                    ${translatorAuthor.authorName}
                </c:forEach>   
                译
            </span>
                    </div>
                    <p class="intro">${qBook.bookIntro}</p>


                </div>

            </li>
        </c:forEach>
    </ul>

    <div class="clearfix">
        <div class="PagedList-pager">
            <ul>
                <!--
                                            <li class="PagedList-disabled PagedList-currentPage PagedList-skipToPage"><a>1</a></li>
                                            <li class="PagedList-skipToPage"><a data-ajax="true" data-ajax-mode="replace" data-ajax-success="lazyLoadImages('search-result-books')" data-ajax-update="#search-result-books" href="/menu/books?q=${query}&page=1">2</a></li>
                                            <li class="PagedList-skipToPage"><a data-ajax="true" data-ajax-mode="replace" data-ajax-success="lazyLoadImages('search-result-books')" data-ajax-update="#search-result-books" href="/menu/books?q=${query}&page=2">3</a></li>
                                            <li class="PagedList-skipToPage"><a data-ajax="true" data-ajax-mode="replace" data-ajax-success="lazyLoadImages('search-result-books')" data-ajax-update="#search-result-books" href="/menu/books?q=${query}&page=3">4</a></li>
                                            <li class="PagedList-skipToPage"><a data-ajax="true" data-ajax-mode="replace" data-ajax-success="lazyLoadImages('search-result-books')" data-ajax-update="#search-result-books" href="/menu/books?q=${query}&page=4">5</a></li>
                                            <li class="PagedList-skipToPage"><a data-ajax="true" data-ajax-mode="replace" data-ajax-success="lazyLoadImages('search-result-books')" data-ajax-update="#search-result-books" href="/menu/books?q=${query}&page=5">6</a></li>
                                            <li class="PagedList-ellipses"><span>...</span></li>
                                            <li class="PagedList-skipToLast"><a data-ajax="true" data-ajax-mode="replace" data-ajax-success="lazyLoadImages('search-result-books')" data-ajax-update="#search-result-books" href="/menu/books?q=${query}&page=7">8</a></li>
                                            -->
                <c:if test="${qBooks.pageNum > 2}">
                    <li class="PagedList-skipToPage"><a data-ajax="true" data-ajax-mode="replace" data-ajax-success="lazyLoadImages('search-result-books')" data-ajax-update="#search-result-books" href="/menu/books?q=${query}&page=1">1</a></li>
                </c:if>
                <c:if test="${qBooks.pageNum > 3}">
                    <li class="PagedList-ellipses"><span>...</span></li>
                </c:if>
                <c:if test="${qBooks.pageNum > 1}">
                    <li class="PagedList-skipToPage"><a data-ajax="true" data-ajax-mode="replace" data-ajax-success="lazyLoadImages('search-result-books')" data-ajax-update="#search-result-books" href="/menu/books?q=${query}&page=${qBooks.pageNum-1}">${qBooks.pageNum-1}</a></li>
                </c:if>
                <li class="PagedList-disabled PagedList-currentPage PagedList-skipToPage"><a>${qBooks.pageNum}</a></li>

                <c:if test="${qBooks.pageNum < qBooks.pages}">
                    <li class="PagedList-skipToPage"><a data-ajax="true" data-ajax-mode="replace" data-ajax-success="lazyLoadImages('search-result-books')" data-ajax-update="#search-result-books" href="/menu/books?q=${query}&page=${qBooks.pageNum+1}">${qBooks.pageNum+1}</a></li>
                </c:if>

                <c:if test="${qBooks.pageNum +2 < qBooks.pages}">
                    <li class="PagedList-ellipses"><span>...</span></li>
                </c:if>
                <c:if test="${qBooks.pageNum +1 < qBooks.pages}">
                    <li class="PagedList-skipToPage"><a data-ajax="true" data-ajax-mode="replace" data-ajax-success="lazyLoadImages('search-result-books')" data-ajax-update="#search-result-books" href="/menu/books?q=${query}&page=${qBooks.pages}">${qBooks.pages}</a></li>
                </c:if>
            </ul>
        </div>
    </div>
</div>