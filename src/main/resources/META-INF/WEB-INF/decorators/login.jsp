<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><sitemesh:write property='title'/></title>
<style>
  body { font-family: Arial, sans-serif; background: #eef1f6; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; }
  .box { background: #fff; padding: 28px 32px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,.12); width: 360px; }
  h2 { margin-top: 0; text-align: center; }
  label { display: block; margin: 12px 0 4px; font-weight: bold; }
  input { width: 100%; padding: 9px; box-sizing: border-box; }
  button { width: 100%; margin-top: 18px; padding: 10px; background: #2c3e50; color: #fff; border: 0; border-radius: 4px; cursor: pointer; }
  .err { background: #fdecea; color: #a93226; padding: 8px; border-radius: 4px; margin-bottom: 8px; }
  .ok { background: #e8f6ee; color: #1e8449; padding: 8px; border-radius: 4px; margin-bottom: 8px; }
  p { text-align: center; }
</style>
<sitemesh:write property='head'/>
</head>
<body>
<div class="box">
  <sitemesh:write property='body'/>
</div>
</body>
</html>
