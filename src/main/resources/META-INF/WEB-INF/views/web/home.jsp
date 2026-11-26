<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html>
<head>
<title>Trang chủ</title>
</head>
<body>
  <h2>Trang chủ</h2>
  <c:choose>
    <c:when test="${not empty sessionScope.currentUser}">
      <p>Xin chào <b><c:out value="${sessionScope.currentUser.fullname}"/></b> (<c:out value="${sessionScope.currentUser.username}"/>).</p>
    </c:when>
    <c:otherwise>
      <p>Bạn chưa đăng nhập. Hãy <a href="/login">đăng nhập</a> hoặc <a href="/register">đăng ký</a>.</p>
    </c:otherwise>
  </c:choose>
</body>
</html>
