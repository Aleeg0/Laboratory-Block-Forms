object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1045#1075#1086#1088#1086#1074' 351005 Lab 1_1'
  ClientHeight = 367
  ClientWidth = 446
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  PopupMenu = PopupMenu1
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnHelp = FormHelp
  TextHeight = 15
  object Task: TLabel
    Left = 8
    Top = 16
    Width = 425
    Height = 81
    AutoSize = False
    Caption = 
      #1055#1088#1086#1075#1088#1072#1084#1084#1072' '#1089#1095#1080#1090#1099#1074#1072#1077#1090' '#1076#1074#1072' '#1095#1080#1089#1083#1072' '#1080' '#1085#1072#1093#1086#1076#1080#1090' '#1089#1088#1077#1076#1085#1077#1077' '#1072#1088#1080#1092#1084#1077#1090#1080#1095#1077#1089#1082#1086#1077' '#1080 +
      ' '#1089#1088#1077#1076#1085#1077#1077' '#1075#1077#1086#1084#1077#1090#1088#1080#1095#1077#1089#1082#1086#1077'. '#1040' '#1079#1072#1090#1077#1084' '#1087#1086#1082#1072#1079#1099#1074#1072#1077#1090', '#1095#1090#1086' '#1089#1088#1077#1076#1085#1077#1077' '#1072#1088#1080#1092#1084#1077#1090 +
      #1080#1095#1077#1089#1082#1086#1077' '#1073#1086#1083#1100#1096#1077' '#1080#1083#1080' '#1088#1072#1074#1085#1086' '#1089#1088#1077#1076#1085#1077#1084#1091' '#1075#1077#1086#1084#1077#1090#1088#1080#1095#1077#1089#1082#1086#1084#1091'.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Sitka Small'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object InfoNum1: TLabel
    Left = 8
    Top = 112
    Width = 124
    Height = 17
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1095#1080#1089#1083#1086' N > 0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object InfoNum2: TLabel
    Left = 8
    Top = 162
    Width = 126
    Height = 17
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1095#1080#1089#1083#1086' M > 0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Answer: TLabel
    Left = 8
    Top = 296
    Width = 425
    Height = 67
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object AnswerInfo: TLabel
    Left = 8
    Top = 275
    Width = 65
    Height = 15
    AutoSize = False
    Caption = #1054#1090#1074#1077#1090' :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Num1Edit: TEdit
    Left = 8
    Top = 135
    Width = 121
    Height = 23
    DragCursor = crArrow
    ParentShowHint = False
    PopupMenu = PopupMenu1
    ShowHint = True
    TabOrder = 0
    TextHint = 'N'
    OnChange = NumEditChange
    OnKeyDown = Num1EditKeyDown
    OnKeyPress = NumEditKeyPress
  end
  object Num2Edit: TEdit
    Left = 8
    Top = 183
    Width = 121
    Height = 23
    ParentShowHint = False
    PopupMenu = PopupMenu1
    ShowHint = True
    TabOrder = 1
    TextHint = 'M'
    OnChange = NumEditChange
    OnKeyDown = Num2EditKeyDown
    OnKeyPress = NumEditKeyPress
  end
  object Button1: TButton
    Left = 8
    Top = 224
    Width = 121
    Height = 33
    Caption = #1056#1072#1089#1095#1080#1090#1072#1090#1100
    Enabled = False
    TabOrder = 2
    OnClick = Button1Click
  end
  object MainMenu1: TMainMenu
    Left = 400
    Top = 112
    object FileButton: TMenuItem
      Caption = #1060#1072#1081#1083
      object Open: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100
        ShortCut = 16463
        OnClick = OpenClick
      end
      object Save: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        Enabled = False
        ShortCut = 16467
        OnClick = SaveClick
      end
    end
    object InstructionButton: TMenuItem
      Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
      OnClick = InstructionButtonClick
    end
    object AboutTheDeveloperButton: TMenuItem
      Caption = #1054' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1077
      OnClick = AboutTheDeveloperButtonClick
    end
  end
  object OpenDialog1: TOpenDialog
    FileName = 'D:\'#1059#1088#1086#1082#1080'\'#1059#1085#1080#1082'\'#1054#1040#1080#1055'\'#1051#1072#1073#1099'\'#1041#1083#1086#1082' '#1092#1086#1088#1084'\Input.txt'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090' (.txt)|*txt'
    Left = 336
    Top = 224
  end
  object SaveDialog1: TSaveDialog
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090' (*.txt)|*txt'
    Left = 248
    Top = 232
  end
  object PopupMenu1: TPopupMenu
    Left = 232
    Top = 144
  end
end
