USE [master]
GO
/****** Object:  Database [QLCHXe]    Script Date: 4/16/2023 3:25:15 PM ******/
CREATE DATABASE [QLCHXe]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QLCHXe', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\QLCHXe.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QLCHXe_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\QLCHXe_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [QLCHXe] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLCHXe].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLCHXe] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLCHXe] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLCHXe] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLCHXe] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLCHXe] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLCHXe] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QLCHXe] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLCHXe] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLCHXe] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLCHXe] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLCHXe] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLCHXe] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLCHXe] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLCHXe] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLCHXe] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QLCHXe] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLCHXe] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLCHXe] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLCHXe] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLCHXe] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLCHXe] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLCHXe] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLCHXe] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QLCHXe] SET  MULTI_USER 
GO
ALTER DATABASE [QLCHXe] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLCHXe] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLCHXe] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLCHXe] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QLCHXe] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QLCHXe] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [QLCHXe] SET QUERY_STORE = ON
GO
ALTER DATABASE [QLCHXe] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [QLCHXe]
GO
/****** Object:  UserDefinedFunction [dbo].[tinhtien]    Script Date: 4/16/2023 3:25:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[tinhtien](@mahd nvarchar(10))
returns money 
as
begin
	declare @tongtien money
	set @tongtien =( select SUM(ThanhTien) from test where MaHD =@mahd )	
	return @tongtien
end
GO
/****** Object:  UserDefinedFunction [dbo].[tk_chitietxe]    Script Date: 4/16/2023 3:25:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[tk_chitietxe](@mahd nvarchar(10),@loaixe nvarchar(50))
returns @ds2 table 
(
	MAHD nvarchar(10),
	NGAYLAP date,
	TENXE nvarchar(100),
	TENNV nvarchar(50),
	TENKH nvarchar(50),
	SOLUONG money,
	GIA money,
	THANHTIEN money
)
as 
begin
	insert into @ds2 
	select HoaDon.MaHD,Ngaylap,TenXe,TenNV,TenKH,HoaDonChiTiet.Soluong,PhuongTien.Gia,HoaDonChiTiet.Soluong*PhuongTien.Gia as 'Thanh Tien' 
	from HoaDon inner join HoaDonChiTiet
	on HoaDon.MaHD = HoaDonChiTiet.MaHD inner join NhanVien 
	on NhanVien.MaNV = HoaDon.MaNV inner join ThongTinKhachHang 
	on ThongTinKhachHang.MaKH = HoaDon.MaKH inner join PhuongTien 
	on PhuongTien.IdPT = HoaDonChiTiet.IdPT inner join HangXe 
	on HangXe.IdHangXe = PhuongTien.IdHangXe
	where HoaDon.MaHD = @mahd and Loaixe = @loaixe
	return
end
GO
/****** Object:  UserDefinedFunction [dbo].[tk_xe]    Script Date: 4/16/2023 3:25:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[tk_xe](@tungay date,@denngay date,@loaixe nvarchar(50))
returns @ds table
(
	MAHD nvarchar(10),
	NGAYLAP date,
	TENNV nvarchar(50),
	TENKH nvarchar(50),
	SOLUONG int
)
as
begin 
	insert into @ds 
	select distinct HoaDon.MaHD,Ngaylap,TenNV,TenKH,SUM(HoaDonChiTiet.Soluong) as'So Luong' from HoaDon inner join HoaDonChiTiet
	on HoaDon.MaHD = HoaDonChiTiet.MaHD inner join NhanVien 
	on NhanVien.MaNV = HoaDon.MaNV inner join ThongTinKhachHang 
	on ThongTinKhachHang.MaKH = HoaDon.MaKH inner join PhuongTien 
	on PhuongTien.IdPT = HoaDonChiTiet.IdPT inner join HangXe 
	on HangXe.IdHangXe = PhuongTien.IdHangXe
	where (Ngaylap between @tungay and @denngay) and Loaixe = @loaixe
	group by HoaDon.MaHD,Ngaylap,TenNV,TenKH
	return
end
GO
/****** Object:  Table [dbo].[HangXe]    Script Date: 4/16/2023 3:25:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HangXe](
	[IdHangXe] [nvarchar](10) NOT NULL,
	[Tenhanngxe] [nvarchar](50) NULL,
	[Loaixe] [nvarchar](50) NULL,
 CONSTRAINT [PK_HangXe] PRIMARY KEY CLUSTERED 
(
	[IdHangXe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoaDon]    Script Date: 4/16/2023 3:25:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDon](
	[MaHD] [nvarchar](10) NOT NULL,
	[Ngaylap] [date] NULL,
	[MaNV] [nvarchar](10) NULL,
	[MaKH] [nvarchar](10) NULL,
 CONSTRAINT [PK_HoaDon] PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoaDonChiTiet]    Script Date: 4/16/2023 3:25:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDonChiTiet](
	[MaHD] [nvarchar](10) NOT NULL,
	[IdPT] [nvarchar](50) NOT NULL,
	[Soluong] [int] NULL,
 CONSTRAINT [PK_HoaDonChiTiet] PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC,
	[IdPT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 4/16/2023 3:25:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[MaNV] [nvarchar](10) NOT NULL,
	[TenNV] [nvarchar](50) NULL,
	[NgaySinh] [date] NULL,
	[DiaChiNV] [nvarchar](200) NULL,
	[Sodienthoai] [nvarchar](10) NULL,
	[Taikhoan] [nvarchar](50) NULL,
	[gender] [nvarchar](50) NULL,
 CONSTRAINT [PK_NhanVien] PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhuongTien]    Script Date: 4/16/2023 3:25:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhuongTien](
	[IdPT] [nvarchar](50) NOT NULL,
	[NamSX] [int] NULL,
	[Gia] [float] NULL,
	[Mamau] [nvarchar](10) NULL,
	[TenXe] [nvarchar](100) NULL,
	[Trangthai] [int] NULL,
	[Ngaynhap] [date] NULL,
	[Soluong] [int] NULL,
	[Mota] [nvarchar](200) NULL,
	[Donvi] [nvarchar](10) NULL,
	[IdHangXe] [nvarchar](10) NULL,
 CONSTRAINT [PK_PhuongTien_1] PRIMARY KEY CLUSTERED 
(
	[IdPT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThongTinKhachHang]    Script Date: 4/16/2023 3:25:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThongTinKhachHang](
	[MaKH] [nvarchar](10) NOT NULL,
	[TenKH] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](200) NULL,
	[Sodienthoai] [nvarchar](10) NULL,
 CONSTRAINT [PK_ThongTinKhachHang] PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[test]    Script Date: 4/16/2023 3:25:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[test] 
as 

	select HoaDon.MaHD,Ngaylap,TenXe,TenNV,TenKH,HoaDonChiTiet.Soluong,PhuongTien.Gia,HoaDonChiTiet.Soluong*PhuongTien.Gia as 'ThanhTien' 
from HoaDon inner join HoaDonChiTiet
	on HoaDon.MaHD = HoaDonChiTiet.MaHD inner join NhanVien 
	on NhanVien.MaNV = HoaDon.MaNV inner join ThongTinKhachHang 
	on ThongTinKhachHang.MaKH = HoaDon.MaKH inner join PhuongTien 
	on PhuongTien.IdPT = HoaDonChiTiet.IdPT inner join HangXe 
	on HangXe.IdHangXe = PhuongTien.IdHangXe
GO
/****** Object:  Table [dbo].[Account]    Script Date: 4/16/2023 3:25:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[TaiKhoan] [nvarchar](50) NOT NULL,
	[Matkhau] [nvarchar](50) NULL,
	[Quyen] [int] NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[TaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaThue]    Script Date: 4/16/2023 3:25:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaThue](
	[Id] [int] NOT NULL,
	[LoaiXe] [nvarchar](10) NULL,
	[GiaThue] [float] NULL,
 CONSTRAINT [PK_GiaThue] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HopDongThue]    Script Date: 4/16/2023 3:25:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HopDongThue](
	[MaHDThue] [nvarchar](10) NOT NULL,
	[MaKH] [nvarchar](10) NULL,
	[MaNV] [nvarchar](10) NULL,
	[Mathue] [nvarchar](10) NULL,
	[IdPT] [nvarchar](50) NULL,
 CONSTRAINT [PK_HopDongThue] PRIMARY KEY CLUSTERED 
(
	[MaHDThue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HopDongThueChiTiet]    Script Date: 4/16/2023 3:25:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HopDongThueChiTiet](
	[MaHDThue] [nvarchar](10) NOT NULL,
	[IdPT] [nvarchar](50) NOT NULL,
	[Soluongthue] [int] NULL,
 CONSTRAINT [PK_HopDongThueChiTiet] PRIMARY KEY CLUSTERED 
(
	[MaHDThue] ASC,
	[IdPT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mau]    Script Date: 4/16/2023 3:25:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mau](
	[Mamau] [nvarchar](10) NOT NULL,
	[Tenmau] [nvarchar](20) NULL,
 CONSTRAINT [PK_Mau] PRIMARY KEY CLUSTERED 
(
	[Mamau] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhaCungCap]    Script Date: 4/16/2023 3:25:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaCungCap](
	[MaNCC] [nvarchar](10) NOT NULL,
	[TenNCC] [nvarchar](50) NULL,
	[DiaChiNCC] [nvarchar](200) NULL,
	[SoDTNCC] [nvarchar](10) NULL,
	[MaSTNCC] [nvarchar](20) NULL,
 CONSTRAINT [PK_NhaCungCap] PRIMARY KEY CLUSTERED 
(
	[MaNCC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Oto]    Script Date: 4/16/2023 3:25:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Oto](
	[IdOto] [nvarchar](10) NOT NULL,
	[Sochongoi] [int] NULL,
	[Kieudongco] [nvarchar](20) NULL,
	[IdPT] [nvarchar](50) NULL,
 CONSTRAINT [PK_Oto] PRIMARY KEY CLUSTERED 
(
	[IdOto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Phieunhap]    Script Date: 4/16/2023 3:25:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phieunhap](
	[Maphieunhap] [nvarchar](10) NOT NULL,
	[Ngaynhap] [date] NULL,
	[MaNCC] [nvarchar](10) NULL,
	[MaNV] [nvarchar](10) NULL,
 CONSTRAINT [PK_Phieunhap] PRIMARY KEY CLUSTERED 
(
	[Maphieunhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhieuNhapChiTiet]    Script Date: 4/16/2023 3:25:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuNhapChiTiet](
	[Maphieunhap] [nvarchar](10) NOT NULL,
	[IdPT] [nvarchar](50) NOT NULL,
	[Soluongnhap] [int] NULL,
	[Dongianhap] [float] NULL,
	[GhiChu] [nvarchar](200) NULL,
 CONSTRAINT [PK_PhieuNhapChiTiet] PRIMARY KEY CLUSTERED 
(
	[Maphieunhap] ASC,
	[IdPT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThongTinCongTy]    Script Date: 4/16/2023 3:25:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThongTinCongTy](
	[TenCongTy] [nvarchar](10) NOT NULL,
	[Diachicongty] [nvarchar](200) NULL,
	[Sodtcongty] [nvarchar](10) NULL,
	[Masothue] [nvarchar](20) NULL,
 CONSTRAINT [PK_ThongTinCongTy] PRIMARY KEY CLUSTERED 
(
	[TenCongTy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TrangThaiThue]    Script Date: 4/16/2023 3:25:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrangThaiThue](
	[Mathue] [nvarchar](10) NOT NULL,
	[Ngaybatdau] [date] NULL,
	[Ngayketthuc] [date] NULL,
	[Trangthai] [int] NULL,
 CONSTRAINT [PK_TrangThaiThue] PRIMARY KEY CLUSTERED 
(
	[Mathue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[XeMay]    Script Date: 4/16/2023 3:25:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[XeMay](
	[IdXeMay] [nvarchar](10) NOT NULL,
	[CongSuat] [int] NULL,
	[IdPT] [nvarchar](50) NULL,
 CONSTRAINT [PK_XeMay] PRIMARY KEY CLUSTERED 
(
	[IdXeMay] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[XeTai]    Script Date: 4/16/2023 3:25:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[XeTai](
	[XeTai] [nvarchar](10) NOT NULL,
	[Trongtai] [float] NULL,
	[IdPT] [nvarchar](50) NULL,
 CONSTRAINT [PK_XeTai] PRIMARY KEY CLUSTERED 
(
	[XeTai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_HoaDon_NhanVien] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK_HoaDon_NhanVien]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_HoaDon_ThongTinKhachHang] FOREIGN KEY([MaKH])
REFERENCES [dbo].[ThongTinKhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK_HoaDon_ThongTinKhachHang]
GO
ALTER TABLE [dbo].[HoaDonChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_HoaDonChiTiet_HoaDon] FOREIGN KEY([MaHD])
REFERENCES [dbo].[HoaDon] ([MaHD])
GO
ALTER TABLE [dbo].[HoaDonChiTiet] CHECK CONSTRAINT [FK_HoaDonChiTiet_HoaDon]
GO
ALTER TABLE [dbo].[HoaDonChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_HoaDonChiTiet_PhuongTien] FOREIGN KEY([IdPT])
REFERENCES [dbo].[PhuongTien] ([IdPT])
GO
ALTER TABLE [dbo].[HoaDonChiTiet] CHECK CONSTRAINT [FK_HoaDonChiTiet_PhuongTien]
GO
ALTER TABLE [dbo].[HopDongThue]  WITH CHECK ADD  CONSTRAINT [FK_HopDongThue_NhanVien] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[HopDongThue] CHECK CONSTRAINT [FK_HopDongThue_NhanVien]
GO
ALTER TABLE [dbo].[HopDongThue]  WITH CHECK ADD  CONSTRAINT [FK_HopDongThue_PhuongTien] FOREIGN KEY([IdPT])
REFERENCES [dbo].[PhuongTien] ([IdPT])
GO
ALTER TABLE [dbo].[HopDongThue] CHECK CONSTRAINT [FK_HopDongThue_PhuongTien]
GO
ALTER TABLE [dbo].[HopDongThue]  WITH CHECK ADD  CONSTRAINT [FK_HopDongThue_ThongTinKhachHang] FOREIGN KEY([MaKH])
REFERENCES [dbo].[ThongTinKhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[HopDongThue] CHECK CONSTRAINT [FK_HopDongThue_ThongTinKhachHang]
GO
ALTER TABLE [dbo].[HopDongThue]  WITH CHECK ADD  CONSTRAINT [FK_HopDongThue_TrangThaiThue] FOREIGN KEY([Mathue])
REFERENCES [dbo].[TrangThaiThue] ([Mathue])
GO
ALTER TABLE [dbo].[HopDongThue] CHECK CONSTRAINT [FK_HopDongThue_TrangThaiThue]
GO
ALTER TABLE [dbo].[HopDongThueChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_HopDongThueChiTiet_HopDongThue] FOREIGN KEY([MaHDThue])
REFERENCES [dbo].[HopDongThue] ([MaHDThue])
GO
ALTER TABLE [dbo].[HopDongThueChiTiet] CHECK CONSTRAINT [FK_HopDongThueChiTiet_HopDongThue]
GO
ALTER TABLE [dbo].[HopDongThueChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_HopDongThueChiTiet_PhuongTien] FOREIGN KEY([IdPT])
REFERENCES [dbo].[PhuongTien] ([IdPT])
GO
ALTER TABLE [dbo].[HopDongThueChiTiet] CHECK CONSTRAINT [FK_HopDongThueChiTiet_PhuongTien]
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_Account] FOREIGN KEY([Taikhoan])
REFERENCES [dbo].[Account] ([TaiKhoan])
GO
ALTER TABLE [dbo].[NhanVien] CHECK CONSTRAINT [FK_NhanVien_Account]
GO
ALTER TABLE [dbo].[Oto]  WITH CHECK ADD  CONSTRAINT [FK_Oto_PhuongTien] FOREIGN KEY([IdPT])
REFERENCES [dbo].[PhuongTien] ([IdPT])
GO
ALTER TABLE [dbo].[Oto] CHECK CONSTRAINT [FK_Oto_PhuongTien]
GO
ALTER TABLE [dbo].[Phieunhap]  WITH CHECK ADD  CONSTRAINT [FK_Phieunhap_NhaCungCap] FOREIGN KEY([MaNCC])
REFERENCES [dbo].[NhaCungCap] ([MaNCC])
GO
ALTER TABLE [dbo].[Phieunhap] CHECK CONSTRAINT [FK_Phieunhap_NhaCungCap]
GO
ALTER TABLE [dbo].[Phieunhap]  WITH CHECK ADD  CONSTRAINT [FK_Phieunhap_NhanVien] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[Phieunhap] CHECK CONSTRAINT [FK_Phieunhap_NhanVien]
GO
ALTER TABLE [dbo].[PhieuNhapChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_PhieuNhapChiTiet_Phieunhap] FOREIGN KEY([Maphieunhap])
REFERENCES [dbo].[Phieunhap] ([Maphieunhap])
GO
ALTER TABLE [dbo].[PhieuNhapChiTiet] CHECK CONSTRAINT [FK_PhieuNhapChiTiet_Phieunhap]
GO
ALTER TABLE [dbo].[PhieuNhapChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_PhieuNhapChiTiet_PhuongTien] FOREIGN KEY([IdPT])
REFERENCES [dbo].[PhuongTien] ([IdPT])
GO
ALTER TABLE [dbo].[PhieuNhapChiTiet] CHECK CONSTRAINT [FK_PhieuNhapChiTiet_PhuongTien]
GO
ALTER TABLE [dbo].[PhuongTien]  WITH CHECK ADD  CONSTRAINT [FK_PhuongTien_HangXe] FOREIGN KEY([IdHangXe])
REFERENCES [dbo].[HangXe] ([IdHangXe])
GO
ALTER TABLE [dbo].[PhuongTien] CHECK CONSTRAINT [FK_PhuongTien_HangXe]
GO
ALTER TABLE [dbo].[PhuongTien]  WITH CHECK ADD  CONSTRAINT [FK_PhuongTien_Mau] FOREIGN KEY([Mamau])
REFERENCES [dbo].[Mau] ([Mamau])
GO
ALTER TABLE [dbo].[PhuongTien] CHECK CONSTRAINT [FK_PhuongTien_Mau]
GO
ALTER TABLE [dbo].[XeMay]  WITH CHECK ADD  CONSTRAINT [FK_XeMay_PhuongTien] FOREIGN KEY([IdPT])
REFERENCES [dbo].[PhuongTien] ([IdPT])
GO
ALTER TABLE [dbo].[XeMay] CHECK CONSTRAINT [FK_XeMay_PhuongTien]
GO
ALTER TABLE [dbo].[XeTai]  WITH CHECK ADD  CONSTRAINT [FK_XeTai_PhuongTien] FOREIGN KEY([IdPT])
REFERENCES [dbo].[PhuongTien] ([IdPT])
GO
ALTER TABLE [dbo].[XeTai] CHECK CONSTRAINT [FK_XeTai_PhuongTien]
GO
USE [master]
GO
ALTER DATABASE [QLCHXe] SET  READ_WRITE 
GO
