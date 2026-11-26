# Bài tập 05 – Spring Boot 4.2.0 + JSP/JSTL

Chức năng:
- Đăng ký tài khoản, đăng nhập, đăng xuất (session, mật khẩu mã hóa BCrypt)
- Khu vực admin (`/admin/**`) chỉ cho tài khoản có quyền admin
- CRUD **Category** và **User** có tìm kiếm + phân trang (`/admin/categories/searchpaginated`, `/admin/users/searchpaginated`)

## Chạy project
1. Cài JDK 25 (hoặc sửa `java.version` trong `pom.xml` cho khớp JDK đang dùng) và SQL Server.
2. Tạo database `bai05` trong SQL Server (`CREATE DATABASE bai05;`), rồi sửa username/password trong `src/main/resources/application.properties`.
3. Chạy `mvn spring-boot:run` (hoặc Run class `Bai05Application` trong Eclipse/IDE).
4. Mở http://localhost:8090

## Tài khoản mẫu
- Admin: `admin` / `admin123` (tự tạo khi khởi động lần đầu)
- Người dùng thường: tự đăng ký tại `/register`

## Cấu trúc
- `src/main/java/com/example/bai05/...` : config, entity, repository, service, controller, interceptor
- `src/main/resources/META-INF/WEB-INF/decorators` : layout SiteMesh (`web.jsp`, `admin.jsp`)
- `src/main/resources/META-INF/WEB-INF/views` : các trang JSP
