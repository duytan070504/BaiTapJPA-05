<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Admin - <sitemesh:write property='title'/></title>
<style>
  * { box-sizing: border-box; }
  body { font-family: Arial, sans-serif; margin: 0; background: #f0f2f5; color: #222; }
  .layout { display: flex; min-height: 100vh; }
  aside { width: 220px; background: #1f2d3d; color: #fff; padding: 20px 0; }
  aside h3 { margin: 0 20px 16px; }
  aside a { display: block; color: #cfd8e3; padding: 10px 20px; text-decoration: none; }
  aside a:hover { background: #2c3e50; color: #fff; }
  .content { flex: 1; }
  .topbar { background: #fff; padding: 12px 24px; display: flex; justify-content: space-between; box-shadow: 0 1px 3px rgba(0,0,0,.1); }
  .topbar a { color: #c0392b; text-decoration: none; margin-left: 12px; }
  .page { padding: 24px; }
  .card { background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 1px 4px rgba(0,0,0,.08); }
  table { border-collapse: collapse; width: 100%; margin: 12px 0; }
  th, td { border: 1px solid #ddd; padding: 8px 10px; text-align: left; }
  th { background: #f7f7f7; }
  .msg { background: #e8f6ee; border: 1px solid #b7e0c7; padding: 8px 12px; border-radius: 4px; margin: 12px 0; }
  .err { background: #fdecea; border: 1px solid #f5c2bd; padding: 8px 12px; border-radius: 4px; margin: 12px 0; color: #a93226; }
  .pagination { list-style: none; display: flex; gap: 6px; padding: 0; margin: 12px 0; }
  .pagination a { display: block; padding: 6px 12px; border: 1px solid #ccc; border-radius: 4px; text-decoration: none; color: #2c3e50; }
  .pagination .active a { background: #2c3e50; color: #fff; border-color: #2c3e50; }
  .btn { display: inline-block; padding: 6px 14px; background: #2c3e50; color: #fff; border: 0; border-radius: 4px; cursor: pointer; text-decoration: none; }
  .btn:hover { background: #3d566e; }
  .form-row { margin-bottom: 12px; }
  .form-row label { display: block; margin-bottom: 4px; font-weight: bold; }
  .form-row input[type=text], .form-row input[type=password], .form-row input[type=email] { width: 100%; max-width: 420px; padding: 8px; }
</style>
<sitemesh:write property='head'/>
</head>
<body>
<div class="layout">
  <aside>
    <h3>Quản trị</h3>
    <a href="/admin/home">Tổng quan</a>
    <a href="/admin/categories/searchpaginated">Quản lý Category</a>
    <a href="/admin/users/searchpaginated">Quản lý User</a>
    <a href="/">Về trang web</a>
  </aside>
  <div class="content">
    <div class="topbar">
      <div><sitemesh:write property='title'/></div>
      <div>
        <c:out value="${sessionScope.currentUser.username}"/>
        <a href="/logout">Đăng xuất</a>
      </div>
    </div>
    <div class="page">
      <div class="card">
        <sitemesh:write property='body'/>
      </div>
    </div>
  </div>
</div>
</body>
</html>
