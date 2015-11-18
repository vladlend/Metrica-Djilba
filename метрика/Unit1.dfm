object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 201
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 88
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 88
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 224
    Top = 24
    Width = 185
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
  end
  object OpenDialog1: TOpenDialog
    Left = 16
    Top = 32
  end
end
