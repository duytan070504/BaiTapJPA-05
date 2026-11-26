<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html>
<head>
<title>Đăng ký tài khoản</title>
</head>
<body>
  <h2>Đăng ký tài khoản</h2>
  <c:if test="${not empty error}"><div class="err"><c:out value="${error}"/></div></c:if>
  <form action="/register" method="post">
    <label for="username">Tên đăng nhập *</label>
    <input type="text" id="username" name="username" value="<c:out value='${username}'/>" required autofocus>
    <label for="fullname">Họ và tên</label>
    <input type="text" id="fullname" name="fullname" value="<c:out value='${fullname}'/>">
    <label for="email">Email</label>
    <input type="email" id="email" name="email" value="<c:out value='${email}'/>">
    <label for="password">Mật khẩu *</label>
    <input type="password" id="password" name="password" required>
    <label for="confirmPassword">Nhập lại mật khẩu *</label>
    <input type="password" id="confirmPassword" name="confirmPassword" required>
    <button type="submit">Đăng ký</button>
  </form>
  <p>Đã có tài khoản? <a href="/login">Đăng nhập</a></p>
</body>
</html>
