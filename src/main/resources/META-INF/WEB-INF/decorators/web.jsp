<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bài tập 05 - <sitemesh:write property='title'/></title>
<style>
  body { font-family: Arial, sans-serif; margin: 0; background: #f5f6fa; color: #222; }
  header { background: #2c3e50; color: #fff; padding: 12px 24px; display: flex; justify-content: space-between; align-items: center; }
  header a { color: #fff; text-decoration: none; margin-left: 16px; }
  header a:hover { text-decoration: underline; }
  main { max-width: 900px; margin: 24px auto; background: #fff; padding: 24px; border-radius: 8px; box-shadow: 0 1px 4px rgba(0,0,0,.1); }
  footer { text-align: center; color: #777; padding: 16px; font-size: 13px; }
</style>
<sitemesh:write property='head'/>
</head>
<body>
<header>
  <div><strong>Bài tập 05</strong></div>
  <nav>
    <a href="/">Trang chủ</a>
    <c:choose>
      <c:when test="${not empty sessionScope.currentUser}">
        <span style="margin-left:16px">Xin chào, <c:out value="${sessionScope.currentUser.username}"/></span>
        <c:if test="${sessionScope.currentUser.admin}"><a href="/admin/home">Trang quản trị</a></c:if>
        <a href="/logout">Đăng xuất</a>
      </c:when>
      <c:otherwise>
        <a href="/login">Đăng nhập</a>
        <a href="/register">Đăng ký</a>
      </c:otherwise>
    </c:choose>
  </nav>
</header>
<main>
  <sitemesh:write property='body'/>
</main>
<footer>&copy; Bài tập 05 - Spring Boot 4 + JSP/JSTL</footer>
</body>
</html>
