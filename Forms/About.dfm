object frmAbout: TfrmAbout
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'RSS News'
  ClientHeight = 294
  ClientWidth = 317
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblTitle: TLabel
    Left = 8
    Top = 71
    Width = 300
    Height = 25
    Alignment = taCenter
    AutoSize = False
    Caption = 'RSS News'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblVersion: TLabel
    Left = 8
    Top = 102
    Width = 300
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Version ?.?.?'
  end
  object lblAuthor: TLabel
    Left = 16
    Top = 128
    Width = 37
    Height = 13
    Caption = 'Author:'
  end
  object Label2: TLabel
    Left = 91
    Top = 128
    Width = 18
    Height = 13
    Caption = 'Lms'
  end
  object lblEmail: TLabel
    Left = 16
    Top = 147
    Width = 28
    Height = 13
    Caption = 'Email:'
  end
  object lblAuthorEmail: TLabel
    Left = 91
    Top = 147
    Width = 98
    Height = 13
    Cursor = crHandPoint
    Caption = 'lms.cze7@gmail.com'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotLight
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = lblAuthorEmailClick
  end
  object Label6: TLabel
    Left = 91
    Top = 166
    Width = 169
    Height = 13
    Caption = 'Write only czech, slovak or english.'
  end
  object Label1: TLabel
    Left = 91
    Top = 185
    Width = 211
    Height = 13
    Caption = 'Pi'#353'te pouze '#269'esky, slovensky nebo anglicky.'
  end
  object lblWeb: TLabel
    Left = 16
    Top = 208
    Width = 26
    Height = 13
    Caption = 'Web:'
  end
  object lblPluginWeb: TLabel
    Left = 91
    Top = 208
    Width = 182
    Height = 13
    Cursor = crHandPoint
    Caption = 'http://qipim.cz/viewtopic.php?t=1998'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotLight
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = lblPluginWebClick
  end
  object imgIcon: TImage
    Left = 129
    Top = 1
    Width = 64
    Height = 64
    Center = True
  end
  object btnClose: TBitBtn
    Left = 113
    Top = 253
    Width = 97
    Height = 25
    Caption = 'Close'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 0
    OnClick = btnCloseClick
  end
end
