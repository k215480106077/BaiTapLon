Sinh viên thực hiện Bài Tập Lớn môn Hệ Quản Trị Dữ Liệu
Họ tên: Lê Thành Phú
MSSV: K215480106077
Lớp: K57KMT.01
Đề tài: Quản lý tài khoản quán NET


# BaiTapLon
Quản lý tài khoản trong một quán net có thể được thực hiện qua một hệ thống cơ sở dữ liệu quản lý các tài khoản người dùng, máy tính, dịch vụ sử dụng và thanh toán. Dưới đây là mô hình sau khi trải nghiệm ở các quán net( thực tế có thể sẽ khác so với mô hình):
# Tài khoản
1; Tài khoản, mật khẩu
2;Nạp tiền vào tài khoản/Số dư hiện tại
3;Số dư thưởng nạp
# Máy tính
1; Mã máy/ ID máy
2; Trạng thái máy: On(máy bật nhưng chưa có hoạt động,sẽ tự tắt sau một khoảng thời gian), In use(đang dùng) ,Off(tắt)
3;Tài khoản đang sử dụng ID máy
4; Số dư hiện tại/Số dư thưởng nạp của tài khoản đang sử dụng máy


# Yêu cầu thực hiện:
-Tạo bảng Quản Lý Tài Khoản(TaiKhoan,MatKhau,SoDuChinh,SoDuPhu)
+Tạo các truy vấn liên quan, tạo hàm nếu có.

-Tạo bảng Quản Lý Giao Dịch(TaiKhoan,LichSuNap,SoTienNap)
+Tạo các truy vấn liên quan, tạo hàm nếu có.

-Tạo bảng Quản Lý Máy Tính(TaiKhoanDangDung,IDmaytinh,SoDuChinh,SoDuPhu,TrangThaiMayTinh)
+Tạo các truy vấn liên quan, tạo hàm nếu có.

