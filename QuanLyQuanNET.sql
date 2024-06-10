--Tạo database quản lý quán net
CREATE DATABASE QuanLyQuanNET
GO
--Dùng database vừa tạo và tạo table quản lý tài khoản
USE QuanLyQuanNET
GO
CREATE TABLE QuanLyTaiKhoan (
    TaiKhoan NVARCHAR(50) NOT NULL, 
    MatKhau NVARCHAR(50) NOT NULL,
    SoDuChinh MONEY,
    SoDuPhu MONEY,
    PRIMARY KEY (TaiKhoan)
);
--Đặt giá trị mặc định cho số dư là 0
ALTER TABLE QuanLyTaiKhoan
ADD CONSTRAINT DF_SoDuChinh DEFAULT 0 FOR SoDuChinh;
ALTER TABLE QuanLyTaiKhoan
ADD CONSTRAINT DF_SoDuPhu DEFAULT 0 FOR SoDuPhu;
-- Thêm tài khoản mới
INSERT INTO QuanLyTaiKhoan (TaiKhoan, MatKhau)
VALUES	(N'user1', N'password1'),
		(N'user2', N'password2'),
		(N'user3', N'password3');


--Cập nhật số dư chính của tài khoản
UPDATE QuanLyTaiKhoan
SET SoDuChinh = 1500.00
WHERE TaiKhoan = N'user1';

--Xóa một tài khoản (Không chạy lệnh này để tránh mất dữ liệu sau này)
DELETE FROM QuanLyTaiKhoan
WHERE TaiKhoan = N'user1';
--Lấy thông tin tất cả tài khoản
SELECT * FROM QuanLyTaiKhoan;
--Đổi mật khẩu tài khoản
UPDATE QuanLyTaiKhoan
SET MatKhau = N'newpassword'
WHERE TaiKhoan = N'user1';




