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
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 120
    Top = 8
    Width = 210
    Height = 33
    Caption = #1052#1077#1090#1088#1080#1082#1072' '#1044#1078#1080#1083#1073#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 192
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 145
    Top = 65
    Width = 185
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object OpenDialog1: TOpenDialog
    Left = 24
    Top = 32
  end
end
