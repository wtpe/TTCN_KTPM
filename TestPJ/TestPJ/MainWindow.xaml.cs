﻿using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Edge;
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
using System.Windows.Navigation;
using System.Windows.Shapes;
using TestPJ.Admin;
using TestPJ.Models;
using TestPJ.NhanVien;

namespace TestPJ
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private QLCHXeContext _context;
        public MainWindow()
        {
            InitializeComponent();
            _context = new QLCHXeContext();
        }



        private void btnDN_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string passWord = txtMK.Password;
                if (string.IsNullOrEmpty(passWord) || string.IsNullOrEmpty(txtTk.Text))
                {
                    MessageBox.Show("Tk or Password cant be empty or null", "Thong bao", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    var tk = _context.Accounts.SingleOrDefault(x => x.TaiKhoan == txtTk.Text);
                    if (tk != null)
                    {
                        if (tk.Quyen == 1 && tk.Matkhau.Equals(passWord))
                        {
                            TrangChuAdmin trangChuAdmin = new TrangChuAdmin();
                            trangChuAdmin.WindowStartupLocation = WindowStartupLocation.CenterScreen;
                            trangChuAdmin.Show();
                            this.Close();
                        }
                        else if (tk.Quyen == 0 && tk.Matkhau.Equals(passWord))
                        {
                            TrangChuNV trangChuNV = new TrangChuNV();
                            trangChuNV.WindowStartupLocation = WindowStartupLocation.CenterScreen;
                            trangChuNV.Show();
                            this.Close();
                        }
                        else
                        {
                            MessageBox.Show("Mat khat khong ton tai", "Thong bao", MessageBoxButton.OK, MessageBoxImage.Error);

                        }
                    }
                    else
                    {
                        MessageBox.Show("Tai khoan or Mat khat khong ton tai", "Thong bao", MessageBoxButton.OK, MessageBoxImage.Error);
                    }
                }

            }
            catch (Exception ex)
            {

                MessageBox.Show("Error: " + ex.ToString(), "Thong bao", MessageBoxButton.OK, MessageBoxImage.Error);
            }

        }

        private void lbFeedB_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            IWebDriver chromeDriver = new EdgeDriver();
            chromeDriver.Navigate().GoToUrl("https://www.facebook.com/truongxuanxx/");
        }
    }
}
