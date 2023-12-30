object OutputArrayB: TOutputArrayB
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1045#1075#1086#1088#1086#1074' 351005 Lab1_4'
  ClientHeight = 96
  ClientWidth = 291
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnCreate = FormCreate
  TextHeight = 15
  object ElementsOfNewArray: TStringGrid
    Left = 8
    Top = 8
    Width = 273
    Height = 73
    ColCount = 2
    RowCount = 2
    PopupMenu = MainForm.PopupMenu1
    TabOrder = 0
  end
end
