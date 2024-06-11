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

--Tạo bảng Quản Lý Giao Dịch
CREATE TABLE QuanLyGiaoDich (
    TaiKhoan NVARCHAR(50) NOT NULL,
    LichSuNap DATETIME NOT NULL,
    SoTienNap MONEY NOT NULL,
    FOREIGN KEY (TaiKhoan) REFERENCES QuanLyTaiKhoan(TaiKhoan)
);

CREATE PROCEDURE NapTien
    @TaiKhoan NVARCHAR(50),
    @SoTien MONEY
AS
BEGIN
    -- Bắt đầu giao dịch
    BEGIN TRANSACTION;

    -- Kiểm tra xem tài khoản có tồn tại hay không
    IF EXISTS (SELECT 1 FROM QuanLyTaiKhoan WHERE TaiKhoan = @TaiKhoan)
    BEGIN
        -- Cập nhật SoDuChinh
        UPDATE QuanLyTaiKhoan
        SET SoDuChinh = SoDuChinh + @SoTien
        WHERE TaiKhoan = @TaiKhoan;

        -- Tính toán SoDuPhu
        DECLARE @SoDuPhu MONEY;
        SET @SoDuPhu = @SoTien * 0.10;

        -- Cập nhật SoDuPhu
        UPDATE QuanLyTaiKhoan
        SET SoDuPhu = SoDuPhu + @SoDuPhu
        WHERE TaiKhoan = @TaiKhoan;

        -- Chèn vào bảng giao dịch
        INSERT INTO QuanLyGiaoDich (TaiKhoan, LichSuNap, SoTienNap)
        VALUES (@TaiKhoan, GETDATE(), @SoTien);

        -- Hoàn tất giao dịch
        COMMIT TRANSACTION;
    END
    ELSE
    BEGIN
        -- Nếu tài khoản không tồn tại, rollback giao dịch
        ROLLBACK TRANSACTION;
        RAISERROR('Tai khoan khong ton tai', 16, 1);
    END
END;

--Sử dụng hàm để nạp tiền vào tài khoản 'user2'
EXEC NapTien @TaiKhoan = N'user2', @SoTien = 1000.00;
--Lấy thông tin giao dịch 
SELECT * FROM QuanLyGiaoDich
--Lấy thông tin giao dịch của tài khoản cụ thể
WHERE TaiKhoan = N'user2';






