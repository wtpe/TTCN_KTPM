using OpenQA.Selenium;
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

namespace TestPJ
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

       

        private void btnDN_Click(object sender, RoutedEventArgs e)
        {
           if(txtTk.Text == "admin" && txtMK.Text == "12345678")
            {
                MessageBox.Show("Hello");
            }
            else
            {
                MessageBox.Show("error");
            }
        }

        private void lbFeedB_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            IWebDriver chromeDriver = new EdgeDriver();
            chromeDriver.Navigate().GoToUrl("https://www.facebook.com/truongxuanxx/");
        }
    }
}
