   M S B A M L   `   `   `  ����A  =TestPJ, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullclr-namespace:TestPJTestPJ  5   	       TestPJ.MainWindow   5   	   W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   &localclr-namespace:TestPJ     5   	     � Title$  
MainWindow��5   	   $	��300��5	   	   $	��450��6    � WindowStartupLocation$ CenterScreen=�5
   	   .��5      � $��10q�6    � RowDefinitions 5   
   �� 5      $
��Auto �6   �� 5      $��* �6    � ColumnDefinitions 5   
   �� 5      $
��auto �6   �� 5      $��* �6   .+�5   
   �� $��0��6   $��0��6   $��	Dang nhap��6.   $��30(�6B   $��Jokerman)�6P   �� 5   
   $��1��6   .+�5      �� $��_Tai khoan:��6   $��Right=�6O   $��0,10,0,0q�6k    �� Target 6*   ��  �� ElementName$ txtTk��6k   �� 5      $��
_Mat khau:��6   $��Right=�6N   $��0,10,0,0q�6j    6)   �� $ txtMK��6j   5      �� 5   
   $��1��6   $��1��6"   .+�5      �� -   5         ��Name$ txtTk��5      $��0,10,0,0q�6%   $��0,5,0,5q�67   G� 5      -   5         G�Name$ txtMK��5      $��0,10,0,0q�6)   $��0,5,0,5q�6;   �� 5      -   5         ��Name$ btnDN��5      	 � Cursor$
	 Hand��6$   $	��100��62   $��25��6>   $��0,20,0,0q�6J   $��	Dang nhap��6\   6p   �� 5      -   5        
 ��Name$
 lbFeedB��5      $
	 Hand��6&   ���	#FF0E3DD5$��Italic$�6K   $��0q�6^   $��14(�6j   $��Right=�6x   $��0,50,0,0q�6�   .��5      ��    
labelStyle#���   6   $��Times New Roman)�6A   FeedBack to Admin6t   5       5!       � 	Resources 5"   
    �� Property �� Value��%T   &	        �� 5#      .�5$      ��  � ��$ 	Underline{�6>   6R   5&      5'      5(      5)      