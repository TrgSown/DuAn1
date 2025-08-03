CREATE DATABASE DuAn;
GO
USE DuAn;
GO

CREATE TABLE Size (
    SizeID INT IDENTITY(1,1) PRIMARY KEY,
    MaSize VARCHAR(50),
    TenSize NVARCHAR(100),
    TrangThai INT
);

CREATE TABLE ChatLieu (
    ChatLieuID INT IDENTITY(1,1) PRIMARY KEY,
    MaChatLieu VARCHAR(50),
    TenChatLieu NVARCHAR(100),
    TrangThai INT
);

CREATE TABLE SanPham (
    SanPhamID INT IDENTITY(1,1) PRIMARY KEY,
    MaSP VARCHAR(50),
    TenSP NVARCHAR(100),
    NgayTao DATE,
    NgaySua DATE
);

CREATE TABLE SanPhamChiTiet (
    SanPhamChiTietID INT IDENTITY(1,1) PRIMARY KEY,
    MaSPCT VARCHAR(50),
	TenSP NVARCHAR(50),
    SoLuong INT,
    GiaBan DECIMAL(18,2),
    TrangThai INT,
    MoTa NVARCHAR(MAX),
    NgayTao DATE,
    NgayChinhSua DATE,
    SanPhamID INT,
    ChatLieuID INT,
    KichThuocID INT,
    FOREIGN KEY (SanPhamID) REFERENCES SanPham(SanPhamID),
    FOREIGN KEY (ChatLieuID) REFERENCES ChatLieu(ChatLieuID),
    FOREIGN KEY (KichThuocID) REFERENCES Size(SizeID)
);

CREATE TABLE NhanVien (
    NhanVienID INT IDENTITY(1,1) PRIMARY KEY,
    MaNV VARCHAR(50),
    TenNV NVARCHAR(100),
    SoDienThoai VARCHAR(20),
    GioiTinh BIT,
    DiaChi NVARCHAR(255),
    NgaySinh DATE,
    Email VARCHAR(100),
	MatKhau NVARCHAR(50),
    TrangThai INT
);

CREATE TABLE KhachHang (
    KhachHangID INT IDENTITY(1,1) PRIMARY KEY,
    MaKH VARCHAR(50),
    TenKH NVARCHAR(100),
    SoDienThoai VARCHAR(20),
    DiaChi NVARCHAR(255),
    Email VARCHAR(100),
    TrangThai INT,
    GioiTinh BIT,
    NgaySinh DATE
);

CREATE TABLE Voucher (
    VoucherID INT IDENTITY(1,1) PRIMARY KEY,
    MaVoucher VARCHAR(50),
    TenVoucher NVARCHAR(100),
    DieuKienGiamGia NVARCHAR(255),
    NgayBatDau DATE,
    NgayKetThuc DATE,
    TrangThai INT,
    GiaTriGiam DECIMAL(10,2),
    HinhThucVoucher NVARCHAR(100),
    NgayTao DATE,
    NgayChinhSua DATE
);

CREATE TABLE HoaDon (
    HoaDonID INT IDENTITY(1,1) PRIMARY KEY,
    MaHD VARCHAR(50),
    NgayTao DATE,
    NguoiTao NVARCHAR(100),
    TongTien DECIMAL(18,2),
    TrangThai INT,
    SoDienThoai VARCHAR(20),
    DiaChi NVARCHAR(255),
    GhiChu NVARCHAR(MAX),
    PhuongThucThanhToan NVARCHAR(100),
    NhanVienID INT,
    KhachHangID INT,
    VoucherID INT,
    FOREIGN KEY (NhanVienID) REFERENCES NhanVien(NhanVienID),
    FOREIGN KEY (KhachHangID) REFERENCES KhachHang(KhachHangID),
    FOREIGN KEY (VoucherID) REFERENCES Voucher(VoucherID)
);

CREATE TABLE HoaDonChiTiet (
    HoaDonChiTietID INT IDENTITY(1,1) PRIMARY KEY,
    MaHDCT VARCHAR(50),
    SoLuong INT,
    GiaBan DECIMAL(18,2),
    NgayTao DATETIME,
    HoaDonID INT,
    SanPhamChiTietID INT,
    FOREIGN KEY (HoaDonID) REFERENCES HoaDon(HoaDonID),
    FOREIGN KEY (SanPhamChiTietID) REFERENCES SanPhamChiTiet(SanPhamChiTietID)
);

CREATE TABLE TaiKhoan (
    Mataikhoan INT PRIMARY KEY,
    TentaiKhoan VARCHAR(100),
    ChucVu NVARCHAR(50),
    Pass VARCHAR(255),
    NgayTao DATE,
    NgayChinhSua DATE,
    TrangThai INT
);

CREATE TABLE ThuocTinh (
    ThuocTinhID INT IDENTITY(1,1) PRIMARY KEY,
    TenThuocTinh NVARCHAR(100) NOT NULL,
    LoaiThuocTinh NVARCHAR(50) NOT NULL, -- "Kích thước", "Chất liệu", "Tên loại sản phẩm"
    TrangThai INT DEFAULT 1, -- 1: Hiển thị, 0: Ẩn
    NgayTao DATETIME DEFAULT GETDATE(),
    NgaySua DATETIME DEFAULT GETDATE()
);

-- Thêm dữ liệu mẫu
INSERT INTO ThuocTinh (TenThuocTinh, LoaiThuocTinh, TrangThai) VALUES 
('S', 'Kích thước', 1),
('M', 'Kích thước', 1),
('L', 'Kích thước', 1),
('Nhựa', 'Chất liệu', 1),
('Thủy tinh', 'Chất liệu', 1),
('Giấy', 'Chất liệu', 1),
('Trà sữa', 'Tên loại sản phẩm', 1),
('Kem', 'Tên loại sản phẩm', 1),
('Nước ép', 'Tên loại sản phẩm', 1);

INSERT INTO Size (MaSize, TenSize, TrangThai) VALUES
('S', N'Small', 1),
('M', N'Medium', 1),
('L', N'Large', 1);

INSERT INTO ChatLieu (MaChatLieu, TenChatLieu, TrangThai) VALUES
('CL01', N'Cotton', 1),
('CL02', N'Polyester', 1),
('CL03', N'L?a', 1);

INSERT INTO SanPham (MaSP, TenSP, NgayTao, NgaySua) VALUES
('SP01', N'Kem Chocolate Sundae Mixue', GETDATE(), GETDATE()),
('SP02', N'Sữa Kem Lắc Dâu Tây Mixue', GETDATE(), GETDATE());


INSERT INTO SanPhamChiTiet (
    MaSPCT, TenSP, SoLuong, GiaBan, TrangThai, MoTa,
    NgayTao, NgayChinhSua, SanPhamID, ChatLieuID, KichThuocID
) VALUES
('SPCT01', N'Kem Chocolate Sundae Mixue', 50, 199000, 1, 
N'Kem Sô cô la ngọt ngào, vị kem đậm đà mang chút hương vị cổ điển đánh bại tất cả, hãy đặt và thưởng thức ngay Kem Chocolate Sundae Mixue nhé!',
GETDATE(), GETDATE(), 1, 1, 2),

('SPCT02', N'Sữa Kem Lắc Dâu Tây Mixue', 30, 299000, 1,
N'Sữa Kem Lắc Dâu Tây Mixue, vị kem đậm đà mang chút hương vị sữa tươi nguyên chất, hãy đặt và thưởng thức ngay!',
GETDATE(), GETDATE(), 2, 2, 3);


INSERT INTO NhanVien (MaNV, TenNV, SoDienThoai, GioiTinh, DiaChi, NgaySinh, Email, MatKhau, TrangThai)
VALUES
('NV01', N'Nguyễn Văn A', '0909123456', 1, N'Hà Nội', '19900101', 'a@example.com', '1234', 1),
('NV02', N'Nguyễn Văn B', '0901234566', 1, N'Thái Bình', '20060101', 'b@example.com', '1234', 1);



-- Sửa đúng: 8 cột tương ứng với 8 giá trị
INSERT INTO KhachHang (MaKH, TenKH, SoDienThoai, DiaChi, Email, TrangThai, GioiTinh, NgaySinh)
VALUES
('KH01', N'Trần Thị B', '0912345678', N'Hồ Chí Minh', 'b@example.com', 1, 0, '1995-05-10');

INSERT INTO Voucher (MaVoucher, TenVoucher, DieuKienGiamGia, NgayBatDau, NgayKetThuc, TrangThai, GiaTriGiam, HinhThucVoucher, NgayTao, NgayChinhSua) VALUES
(1, 'VC01', N'Giảm 10%', N'Áp dụng cho hóa don > 500K', '2025-07-01', '2025-08-01', 1, 10.00, N'Phần trăm', GETDATE(), GETDATE());

INSERT INTO HoaDon (MaHD, NgayTao, NguoiTao, TongTien, TrangThai, SoDienThoai, DiaChi, GhiChu, PhuongThucThanhToan, NhanVienID, KhachHangID, VoucherID) VALUES
(1, 'HD01', GETDATE(), N'Nguyễn Van A', 398000, 1, '0912345678', N'Hồ Chí Minh', N'Cảm ơn quý khách', N'Tiền mặt', 1, 1, 1);

INSERT INTO HoaDonChiTiet (MaHDCT, SoLuong, GiaBan, NgayTao, HoaDonID, SanPhamChiTietID) VALUES
(1, 'HDCT01', 1, 199000, GETDATE(), 1, 1),
(2, 'HDCT02', 1, 199000, GETDATE(), 1, 2);

INSERT INTO TaiKhoan (Mataikhoan, TentaiKhoan, ChucVu, Pass, NgayTao, NgayChinhSua, TrangThai) VALUES
(1, 'admin', N'Quản trị viên', 'admin123', GETDATE(), GETDATE(), 1);

SELECT * FROM NhanVien
WHERE MaNV = 'NV02' AND MatKhau = 1234

select * from SanPhamChiTiet