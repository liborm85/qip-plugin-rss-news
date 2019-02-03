object frmAddFeed: TfrmAddFeed
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Add Feed'
  ClientHeight = 264
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
  object pnlURL: TPanel
    Left = 0
    Top = 0
    Width = 428
    Height = 43
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblURL: TLabel
      Left = 11
      Top = 19
      Width = 23
      Height = 13
      Caption = 'URL:'
    end
    object edtURL: TEdit
      Left = 64
      Top = 16
      Width = 337
      Height = 21
      TabOrder = 0
    end
    object btnURLCheck: TBitBtn
      Left = 395
      Top = 14
      Width = 25
      Height = 25
      Caption = 'zkontr.'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Visible = False
    end
  end
  object pnlLogin: TPanel
    Left = 0
    Top = 74
    Width = 428
    Height = 93
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object gbLogin: TGroupBox
      Left = 11
      Top = 6
      Width = 409
      Height = 80
      Caption = 'Login'
      TabOrder = 0
      object lblLoginName: TLabel
        Left = 13
        Top = 21
        Width = 31
        Height = 13
        Caption = 'Name:'
      end
      object lblLoginPassword: TLabel
        Left = 13
        Top = 48
        Width = 50
        Height = 13
        Caption = 'Password:'
      end
      object edtLoginPassword: TEdit
        Left = 99
        Top = 43
        Width = 300
        Height = 21
        PasswordChar = '*'
        TabOrder = 1
      end
      object edtLoginName: TEdit
        Left = 99
        Top = 16
        Width = 300
        Height = 21
        TabOrder = 0
      end
    end
  end
  object pnlAddTo: TPanel
    Left = 0
    Top = 167
    Width = 428
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object cmbAddTo: TComboBox
      Left = 112
      Top = 4
      Width = 289
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
    end
    object chkAddTo: TCheckBox
      Left = 11
      Top = 6
      Width = 95
      Height = 17
      Caption = 'Add to:'
      TabOrder = 0
      OnClick = chkAddToClick
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 202
    Width = 428
    Height = 56
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object lblInfo: TLabel
      Left = 19
      Top = 6
      Width = 390
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnOK: TButton
      Left = 136
      Top = 25
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = btnOKClick
    end
    object btnCancel: TButton
      Left = 225
      Top = 25
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object pnlName: TPanel
    Left = 0
    Top = 43
    Width = 428
    Height = 31
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object lblName: TLabel
      Left = 11
      Top = 7
      Width = 31
      Height = 13
      Caption = 'Name:'
    end
    object edtName: TEdit
      Left = 64
      Top = 4
      Width = 337
      Height = 21
      TabOrder = 0
    end
  end
end
