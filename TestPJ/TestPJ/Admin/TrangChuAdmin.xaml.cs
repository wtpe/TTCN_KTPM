﻿using Microsoft.Win32;
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

namespace TestPJ.Admin
{
    /// <summary>
    /// Interaction logic for TrangChuAdmin.xaml
    /// </summary>
    public partial class TrangChuAdmin : Window
    {
        public void ImageTT()
        {
            BitmapImage bitmap = new BitmapImage();
            bitmap.BeginInit();
            bitmap.UriSource = new Uri(@"D:\TTCNKTPM\TestPJ\TestPJ\wwwroot\Image_TT.jpg");
            bitmap.EndInit();
            Img_TT.Source = bitmap;
        }
        public TrangChuAdmin()
        {
            InitializeComponent();
            ImageTT();
        }

        private void Btn_QuanLyNV_Click(object sender, RoutedEventArgs e)
        {
            
        }

        private void Btn_QuanLyXeMay_Click(object sender, RoutedEventArgs e)
        {

        }

        private void Btn_QuanLyOto_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}
