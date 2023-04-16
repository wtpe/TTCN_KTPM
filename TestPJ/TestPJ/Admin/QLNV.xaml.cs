﻿using System;
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
                         Gender = i.Gender,
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

        private void ComboBoxItem_Selected(object sender, RoutedEventArgs e)
        {

        }

        private void txtDiaChi_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (System.Text.RegularExpressions.Regex.IsMatch(txtDiaChi.Text, "[^0-9]") || txtDiaChi.Text.Length > 10)
            {
                MessageBox.Show("Please enter only numbers.");
                txtDiaChi.Text = txtDiaChi.Text.Remove(txtDiaChi.Text.Length - 1);
            }
        }
    }
}
