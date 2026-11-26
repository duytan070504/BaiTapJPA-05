	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html>
<head>
<title>Tổng quan</title>
</head>
<body>
  <h2>Trang quản trị</h2>
  <p>Xin chào <b><c:out value="${sessionScope.currentUser.fullname}"/></b>!</p>
  <p>Tổng số Category: <b>${totalCategories}</b></p>
  <p>
    <a class="btn" href="/admin/categories/searchpaginated">Quản lý Category</a>
    <a class="btn" href="/admin/users/searchpaginated">Quản lý User</a>
  </p>
</body>
</html>
