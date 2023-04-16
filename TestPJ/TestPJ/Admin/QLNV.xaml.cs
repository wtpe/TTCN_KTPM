using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using TestPJ.Models;

namespace TestPJ.Admin
{
    /// <summary>
    /// Interaction logic for QLNV.xaml
    /// </summary>
    public partial class QLNV : Window
    {
        private QLCHXeContext db;
        public void LoadDataGrid()
        {
            var nv = from i in db.NhanViens
                     join j in db.Accounts on i.Taikhoan equals j.TaiKhoan
                     where j.Quyen == 0
                     select new
                     {
                         MaNv = i.MaNv,
                         TenNv = i.TenNv,
                         NgaySinh = i.NgaySinh.ToString(),
                         DiaChiNv = i.DiaChiNv,
                         Sodienthoai = i.Sodienthoai,
                         Taikhoan = i.Taikhoan,
                         Matkhau = j.Matkhau,
                         Quyen = "Nhan vien"
                     };
            dtgNV.ItemsSource = nv.ToList();
            
        }
        public QLNV()
        {
            
            InitializeComponent();
            db = new QLCHXeContext();
            LoadDataGrid();
        }
    }
}
