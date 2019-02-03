object frmContactDetails: TfrmContactDetails
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Contact details'
  ClientHeight = 294
  ClientWidth = 428
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
    Left = 16
    Top = 16
    Width = 38
    Height = 13
    Caption = 'lblTitle'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 16
    Top = 104
    Width = 99
    Height = 13
    Caption = 'Posledn'#237' aktualizace:'
  end
  object Label2: TLabel
    Left = 16
    Top = 120
    Width = 82
    Height = 13
    Caption = 'Dal'#353#237' aktualizace:'
  end
  object lblLastUpdate: TLabel
    Left = 160
    Top = 104
    Width = 12
    Height = 13
    Caption = '...'
  end
  object lblNextUpdate: TLabel
    Left = 160
    Top = 120
    Width = 12
    Height = 13
    Caption = '...'
  end
  object Label3: TLabel
    Left = 16
    Top = 51
    Width = 43
    Height = 13
    Caption = 'Encoder:'
  end
  object lblEncoderName: TLabel
    Left = 160
    Top = 51
    Width = 12
    Height = 13
    Caption = '...'
  end
  object lblEncoderVersion: TLabel
    Left = 256
    Top = 51
    Width = 12
    Height = 13
    Caption = '...'
  end
  object lblCodepage: TLabel
    Left = 160
    Top = 70
    Width = 12
    Height = 13
    Caption = '...'
  end
  object Label5: TLabel
    Left = 16
    Top = 70
    Width = 84
    Height = 13
    Caption = 'Znakov'#225' str'#225'nka:'
  end
  object Label4: TLabel
    Left = 16
    Top = 147
    Width = 61
    Height = 13
    Caption = 'Po'#269'et zpr'#225'v:'
  end
  object lblMsgCount: TLabel
    Left = 160
    Top = 147
    Width = 12
    Height = 13
    Caption = '...'
  end
  object Label6: TLabel
    Left = 17
    Top = 166
    Width = 130
    Height = 13
    Caption = 'Po'#269'et nep'#345'e'#269'ten'#253'ch zpr'#225'v:'
  end
  object lblMsgUnreadCount: TLabel
    Left = 161
    Top = 166
    Width = 12
    Height = 13
    Caption = '...'
  end
  object Label8: TLabel
    Left = 17
    Top = 185
    Width = 99
    Height = 13
    Caption = 'Po'#269'et nov'#253'ch zpr'#225'v:'
  end
  object lblMsgNewCount: TLabel
    Left = 161
    Top = 185
    Width = 12
    Height = 13
    Caption = '...'
  end
end
