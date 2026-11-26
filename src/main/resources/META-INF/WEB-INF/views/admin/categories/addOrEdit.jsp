<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html>
<head>
<title>${isEdit ? 'Sửa Category' : 'Thêm Category'}</title>
</head>
<body>
<h2>${isEdit ? 'Sửa Category' : 'Thêm Category'}</h2>

<c:if test="${not empty error}">
  <div class="err"><c:out value="${error}"/></div>
</c:if>

<form action="/admin/categories/saveOrUpdate" method="post">
  <c:if test="${isEdit}">
    <input type="hidden" name="id" value="${category.id}" />
    <div class="form-row">
      <label>ID</label>
      <input type="text" value="${category.id}" readonly />
    </div>
  </c:if>

  <div class="form-row">
    <label for="name">Tên category *</label>
    <input type="text" id="name" name="name" value="<c:out value='${category.name}'/>" required />
  </div>

  <div class="form-row">
    <label for="images">Hình ảnh (đường dẫn/URL)</label>
    <input type="text" id="images" name="images" value="<c:out value='${category.images}'/>" />
  </div>

  <div class="form-row">
    <label>
      <input type="hidden" name="_status" value="on" />
      <input type="checkbox" name="status" ${category.status ? 'checked' : ''} /> Hoạt động
    </label>
  </div>

  <button type="submit" class="btn">${isEdit ? 'Cập nhật' : 'Thêm mới'}</button>
  <a class="btn" href="/admin/categories/searchpaginated" style="background:#7f8c8d">Quay lại</a>
</form>
</body>
</html>
