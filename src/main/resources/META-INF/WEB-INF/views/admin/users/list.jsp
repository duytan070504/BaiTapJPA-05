<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html>
<head>
<title>Danh sách User</title>
</head>
<body>
<h2>Danh sách User</h2>

<a class="btn" href="/admin/users/add">Add user</a>

<c:if test="${message != null}">
  <div class="msg"><i><c:out value="${message}"/></i></div>
</c:if>

<form action="/admin/users/searchpaginated" style="margin:12px 0">
  <input type="text" name="name" id="name" value="<c:out value='${name}'/>" placeholder="Nhập username để tìm" />
  <input type="hidden" name="size" value="${userPage.size}" />
  <button class="btn">Search</button>
</form>

<c:if test="${!userPage.hasContent()}">
  No User
</c:if>

<c:if test="${userPage.hasContent()}">
  <table>
    <tr>
      <th>STT</th>
      <th>Username</th>
      <th>Họ tên</th>
      <th>Email</th>
      <th>Role</th>
      <th>Trạng thái</th>
      <th>Action</th>
    </tr>
    <c:forEach items="${userPage.content}" var="u" varStatus="STT">
      <tr>
        <td>${userPage.number * userPage.size + STT.index + 1}</td>
        <td><c:out value="${u.username}"/></td>
        <td><c:out value="${u.fullname}"/></td>
        <td><c:out value="${u.email}"/></td>
        <td>${u.admin ? 'Admin' : 'User'}</td>
        <td>${u.active ? 'Hoạt động' : 'Khóa'}</td>
        <td>
          <a href="/admin/users/edit/${u.id}">Sửa</a> |
          <a href="/admin/users/delete/${u.id}"
             onclick="return confirm('Bạn có chắc muốn xóa user này?')">Xóa</a>
        </td>
      </tr>
    </c:forEach>
  </table>
</c:if>

<form action="/admin/users/searchpaginated">
  <input type="hidden" name="name" value="<c:out value='${name}'/>" />
  Page size:
  <select name="size" id="size" onchange="this.form.submit()">
    <option ${userPage.size == 3 ? 'selected':''} value="3">3</option>
    <option ${userPage.size == 5 ? 'selected':''} value="5">5</option>
    <option ${userPage.size == 10 ? 'selected':''} value="10">10</option>
    <option ${userPage.size == 15 ? 'selected':''} value="15">15</option>
    <option ${userPage.size == 20 ? 'selected':''} value="20">20</option>
  </select>
</form>

<c:if test="${userPage.totalPages > 0}">
  <ul class="pagination">
    <c:forEach items="${pageNumbers}" var="pageNumber">
      <c:if test="${userPage.totalPages > 1}">
        <li class="${pageNumber == userPage.number + 1 ? 'page-item active' : 'page-item'}">
          <a href="<c:url value='/admin/users/searchpaginated'>
                     <c:param name='name' value='${name}'/>
                     <c:param name='size' value='${userPage.size}'/>
                     <c:param name='page' value='${pageNumber}'/>
                   </c:url>">${pageNumber}</a>
        </li>
      </c:if>
    </c:forEach>
  </ul>
</c:if>
</body>
</html>
