<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html>
<head>
<title>${isEdit ? 'Sửa User' : 'Thêm User'}</title>
</head>
<body>
<h2>${isEdit ? 'Sửa User' : 'Thêm User'}</h2>

<c:if test="${not empty error}">
  <div class="err"><c:out value="${error}"/></div>
</c:if>

<form action="/admin/users/saveOrUpdate" method="post">
  <c:if test="${isEdit}">
    <input type="hidden" name="id" value="${user.id}" />
  </c:if>

  <div class="form-row">
    <label for="username">Tên đăng nhập *</label>
    <input type="text" id="username" name="username" value="<c:out value='${user.username}'/>" required />
  </div>

  <div class="form-row">
    <label for="password">Mật khẩu ${isEdit ? '(để trống nếu không đổi)' : '*'}</label>
    <input type="password" id="password" name="password" ${isEdit ? '' : 'required'} />
  </div>

  <div class="form-row">
    <label for="fullname">Họ và tên</label>
    <input type="text" id="fullname" name="fullname" value="<c:out value='${user.fullname}'/>" />
  </div>

  <div class="form-row">
    <label for="email">Email</label>
    <input type="email" id="email" name="email" value="<c:out value='${user.email}'/>" />
  </div>

  <div class="form-row">
    <label>
      <input type="hidden" name="_admin" value="on" />
      <input type="checkbox" name="admin" ${user.admin ? 'checked' : ''} /> Quyền admin
    </label>
  </div>

  <div class="form-row">
    <label>
      <input type="hidden" name="_active" value="on" />
      <input type="checkbox" name="active" ${user.active ? 'checked' : ''} /> Hoạt động
    </label>
  </div>

  <button type="submit" class="btn">${isEdit ? 'Cập nhật' : 'Thêm mới'}</button>
  <a class="btn" href="/admin/users/searchpaginated" style="background:#7f8c8d">Quay lại</a>
</form>
</body>
</html>
