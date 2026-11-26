<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html>
<head>
<title>Đăng nhập</title>
</head>
<body>
  <h2>Đăng nhập</h2>
  <c:if test="${not empty error}"><div class="err"><c:out value="${error}"/></div></c:if>
  <c:if test="${not empty message}"><div class="ok"><c:out value="${message}"/></div></c:if>
  <form action="/login" method="post">
    <label for="username">Tên đăng nhập</label>
    <input type="text" id="username" name="username" value="<c:out value='${username}'/>" required autofocus>
    <label for="password">Mật khẩu</label>
    <input type="password" id="password" name="password" required>
    <button type="submit">Đăng nhập</button>
  </form>
  <p>Chưa có tài khoản? <a href="/register">Đăng ký</a></p>
</body>
</html>
