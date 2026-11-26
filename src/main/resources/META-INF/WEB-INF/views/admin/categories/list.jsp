<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html>
<head>
<title>Danh sách Category</title>
</head>
<body>
<h2>Danh sách Category</h2>

<a class="btn" href="/admin/categories/add">Add category</a>

<!-- Hiển thị thông báo -->
<c:if test="${message != null}">
  <div class="msg"><i><c:out value="${message}"/></i></div>
</c:if>
<!-- Hết thông báo -->

<form action="/admin/categories/searchpaginated" style="margin:12px 0">
  <input type="text" name="name" id="name" value="<c:out value='${name}'/>" placeholder="Nhập từ khóa để tìm" />
  <input type="hidden" name="size" value="${categoryPage.size}" />
  <button class="btn">Search</button>
</form>

<c:if test="${!categoryPage.hasContent()}">
  No Category
</c:if>

<c:if test="${categoryPage.hasContent()}">
  <table>
    <tr>
      <th>STT</th>
      <th>Images</th>
      <th>Category name</th>
      <th>Status</th>
      <th>Action</th>
    </tr>
    <c:forEach items="${categoryPage.content}" var="cate" varStatus="STT">
      <tr>
        <td>${categoryPage.number * categoryPage.size + STT.index + 1}</td>
        <td>
          <c:if test="${not empty cate.images}">
            <img src="<c:out value='${cate.images}'/>" alt="" height="40"
                 onerror="this.style.display='none'">
          </c:if>
          <c:out value="${cate.images}"/>
        </td>
        <td><c:out value="${cate.name}"/></td>
        <td>${cate.status ? 'Hoạt động' : 'Khóa'}</td>
        <td>
          <a href="/admin/categories/edit/${cate.id}">Sửa</a> |
          <a href="/admin/categories/delete/${cate.id}"
             onclick="return confirm('Bạn có chắc muốn xóa category này?')">Xóa</a>
        </td>
      </tr>
    </c:forEach>
  </table>
</c:if>

<form action="/admin/categories/searchpaginated">
  <input type="hidden" name="name" value="<c:out value='${name}'/>" />
  Page size:
  <select name="size" id="size" onchange="this.form.submit()">
    <option ${categoryPage.size == 3 ? 'selected':''} value="3">3</option>
    <option ${categoryPage.size == 5 ? 'selected':''} value="5">5</option>
    <option ${categoryPage.size == 10 ? 'selected':''} value="10">10</option>
    <option ${categoryPage.size == 15 ? 'selected':''} value="15">15</option>
    <option ${categoryPage.size == 20 ? 'selected':''} value="20">20</option>
  </select>
</form>

<c:if test="${categoryPage.totalPages > 0}">
  <ul class="pagination">
    <c:forEach items="${pageNumbers}" var="pageNumber">
      <c:if test="${categoryPage.totalPages > 1}">
        <li class="${pageNumber == categoryPage.number + 1 ? 'page-item active' : 'page-item'}">
          <a href="<c:url value='/admin/categories/searchpaginated'>
                     <c:param name='name' value='${name}'/>
                     <c:param name='size' value='${categoryPage.size}'/>
                     <c:param name='page' value='${pageNumber}'/>
                   </c:url>">${pageNumber}</a>
        </li>
      </c:if>
    </c:forEach>
  </ul>
</c:if>
</body>
</html>
