   M S B A M L   `   `   `  ���� A  =TestPJ, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null+clr-namespace:TestPJ.AdminTestPJ.Admin      TestPJ.Admin.QLNV   W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     ,localclr-namespace:TestPJ.Admin       � Title$  Quan ly nhan vien��$
��1000��$	��800��.���  � RowDefinitions �� $	��200 ��� $��* � � ColumnDefinitions �� $	��250 ��� $��* ��� $��* �.+��� $��0��$��	20,20,0,0q� �� Orientation$ Vertical=�.+��� $ 
Horizontal=�$��10q�.+��� $��Ten NV:��$��12(�$��Center=��� -    ��Name$ txtTenNV��$��Center=�$	��150��$��10,0,0,0q��� $ 
Horizontal=�$��10q�.+��� $��
Gioi tinh:��$��12(�$��Center=�$��0,0,10,0q��� -    ��Name$ 	cbxGender��.@���  �� 
IsSelected$
 True��$	��Nam���� $��Nu���� $ 
Horizontal=�$��10q�.+��� $��
Tai Khoan:��$��12(�$��Center=��� -   $ txtTenTk��$��Center=�$	��100��$��10,0,0,0q��� $��1��$��	20,20,0,0q�$ Vertical=�.+��� $ 
Horizontal=�$��10q�.+��� $��Dia chi:��$��12(��� -   $ 	txtDiaChi��$	��150��$��45,0,0,0q�$��Center=��� $ 
Horizontal=�$��10q�.+��� $��So dien thoai:��$��12(��� -   $ txtSodt��$	��150��$	��Top=�$��10,0,0,0q��� $ 
Horizontal=�$��10q�.+��� $��
Ngay Sinh:��$��12(�(  "System.Windows.Controls.DatePicker  -     Name$ txtNgaySinh��$	��150��$��25,0,0,0q�$	��Top=��� $ 
Horizontal=�$��10q�.+��� $��	Mat khau:��$��12(�$��Center=��� -   $ 
txtMatKhau��$��Center=�$	��150��$��26,0,0,0q��� $ Vertical=�$��2��.+��� $ 
Horizontal=�$��20q�.+��� -    ��Name$ btnThem��$
��Left=�$	��100��$��Center=�$��10q�$��10q�.��Them�� -	   $ btnSua��$	��100��$��Center=�$��10q�$��10q�.��Sua�� $ 
Horizontal=�$��20q�.+��� -
   $ btnXoa��$	��100��$��Center=�$��10q�$��10q�.��Xoa�� -   $ BtnClear��$	��100��$��Center=�$��10q�$��10q�.��Clear�� $ 
Horizontal=�$��1��$��50,0,0,0q�$��2��$	��Top=�.+��� $ 
Horizontal=�$��10q�.+��� $��Tim nhan vien:��$��Center=��� -   $ txtTim��$	��150��$��Center=�$��20,0,0,0q��� -   $ btnTim��$��20,10,20,10q�$��30,0,0,0q�$��Center=�.��Xem�� $��1��$��3��.+�&   System.Windows.Controls.DataGrid  -   	  Name$	 dtgNV��$��50,50,50,50q�
   
IsReadOnly$

 True��   AutoGenerateColumns$ False��
���  ��   Columns 0  *System.Windows.Controls.DataGridTextColumn  ,  &System.Windows.Controls.DataGridColumn   Header$ Ma NV��1  +System.Windows.Controls.DataGridBoundColumn   Binding �� *MaNv+  $ Ten NV�� �� *TenNv+  $ 	Gioi tinh�� �� *Gender+  $ 	Ngay Sinh�� �� *
NgaySinh+  $ Dia chi�� �� *
DiaChiNv+  $ 	Tai Khoan�� �� *
Taikhoan+  $	 SDT�� �� *Sodienthoai+  $ Chuc vu��   Width5  /System.Windows.Controls.DataGridLengthConverter$ *  �� *Quyen+   RowDetailsTemplate �� .R��� $��0q�
������� �� Padding$ 5q�._��� $ Vertical=�.+��� $ 
Horizontal=�.+��� $��12(�$��
Tai Khoan:��$��Center=��� $��12(�
���p�$��Center=����� *
Taikhoan+�� $ 
Horizontal=�.+��� $��12(�$��	Mat khau:��$��Center=��� $��12(�
���p�$��Center=����� *	Matkhau+�� $ 
Horizontal=�.+��� $��12(�$��Quyen:��$��Center=��� $��12(�
���p�$��Center=����� *Quyen+