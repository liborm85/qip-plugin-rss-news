object frmAccountSetting: TfrmAccountSetting
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'RSS News'
  ClientHeight = 239
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
  object lblSharedAccount: TLabel
    Left = 64
    Top = 95
    Width = 193
    Height = 13
    Caption = 'Using shared settings and data storage.'
  end
  object lblPersonalAccount: TLabel
    Left = 64
    Top = 151
    Width = 189
    Height = 13
    Caption = 'Using separate settings for each users.'
  end
  object lblLanguage: TLabel
    Left = 43
    Top = 32
    Width = 51
    Height = 13
    Caption = 'Language:'
  end
  object rbSharedAccount: TRadioButton
    Left = 40
    Top = 72
    Width = 347
    Height = 17
    Caption = 'Start with shared account'
    Checked = True
    TabOrder = 0
    TabStop = True
  end
  object rbPersonalAccount: TRadioButton
    Left = 40
    Top = 128
    Width = 347
    Height = 17
    Caption = 'Start width personal account'
    TabOrder = 1
  end
  object btnStart: TBitBtn
    Left = 312
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 2
    OnClick = btnStartClick
  end
  object cmbLanguage: TComboBox
    Left = 176
    Top = 29
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 3
    OnChange = cmbLanguageChange
  end
end
