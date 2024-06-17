-- 1.Tạo database
CREATE DATABASE QuanLyKhoCafe
GO	
USE QuanLyKhoCafe
GO	
-- 2.Tạo bảng kho cafe
CREATE TABLE KhoCafe (
    LoaiCafe NVARCHAR(100) PRIMARY KEY,
    SoLuongTrongKho DECIMAL(18, 3),
    DonVi NVARCHAR(50),
    NgayKiemKhoCuoi DATETIME
);
-- 3. Thêm dữ liệu vào bảng
INSERT INTO KhoCafe (LoaiCafe, SoLuongTrongKho, DonVi, NgayKiemKhoCuoi)
VALUES 
('A+', 100.50, 'kg', '2024-06-17 08:00:00'),
('Rica', 200.75, 'kg', '2024-06-16 09:00:00'),
('Filter', 150.25, 'kg', '2024-06-15 10:00:00'),
('Super', 300.00, 'kg', '2024-06-14 11:00:00'),
('Class', 250.80, 'kg', '2024-06-13 12:00:00');

--tạo trigger tự động tính đơn vị theo số lượng
CREATE TRIGGER Trigger_TinhDonVi
ON KhoCafe
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @LoaiCafe NVARCHAR(100);
    DECLARE @SoLuong DECIMAL(18, 3);
    DECLARE @DonVi NVARCHAR(50);
    
    SELECT @LoaiCafe = LoaiCafe, @SoLuong = SoLuongTrongKho, @DonVi = DonVi
    FROM inserted;
    
    IF @SoLuong > 1000
    BEGIN
		UPDATE dbo.KhoCafe
		SET	SoLuongTrongKho = @SoLuong / 1000.0, DonVi = 'tấn'
		WHERE LoaiCafe = @LoaiCafe;
	END
	ELSE IF @SoLuong >=100
	BEGIN
		UPDATE dbo.KhoCafe
		SET	SoLuongTrongKho = @SoLuong / 100.0, DonVi = 'tạ'
		WHERE LoaiCafe = @LoaiCafe;
	END
	ELSE 
	BEGIN
		UPDATE dbo.KhoCafe
		SET	SoLuongTrongKho = @SoLuong, DonVi = 'kg'
		WHERE LoaiCafe = @LoaiCafe;
	END;
END;

-- Cập nhật số lượng của loại cafe 'A+'
UPDATE KhoCafe
SET SoLuongTrongKho = 1200
WHERE LoaiCafe = 'A+';

-- Kiểm tra kết quả cập nhật
SELECT * FROM KhoCafe WHERE LoaiCafe = 'A+';

UPDATE KhoCafe
SET SoLuongTrongKho = 575
WHERE LoaiCafe = 'Super';

