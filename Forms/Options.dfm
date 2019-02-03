object frmOptions: TfrmOptions
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Options: xxx'
  ClientHeight = 416
  ClientWidth = 594
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
  object lblPluginVersion: TLabel
    Left = 8
    Top = 395
    Width = 70
    Height = 13
    Caption = 'Version ?.?.?.?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object btnOK: TBitBtn
    Left = 282
    Top = 383
    Width = 97
    Height = 25
    Caption = 'OK'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TBitBtn
    Left = 385
    Top = 384
    Width = 97
    Height = 25
    Caption = 'Cancel'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object btnApply: TBitBtn
    Left = 488
    Top = 384
    Width = 97
    Height = 25
    Caption = 'Apply'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 3
    OnClick = btnApplyClick
  end
  object lstMenu: TListBox
    Left = 8
    Top = 8
    Width = 137
    Height = 369
    Style = lbOwnerDrawFixed
    ItemHeight = 26
    TabOrder = 0
    OnClick = lstMenuClick
  end
  object PanelCont: TPanel
    Left = 152
    Top = 8
    Width = 433
    Height = 369
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 5
    Visible = False
  end
  object pgcOptions: TPageControl
    Left = 151
    Top = 39
    Width = 434
    Height = 338
    ActivePage = tsAdditional
    TabOrder = 4
    object tsGeneral: TTabSheet
      Caption = 'General'
      object gbLanguage: TGroupBox
        Left = 3
        Top = 197
        Width = 420
        Height = 110
        Caption = 'Language'
        TabOrder = 0
        object lblLanguage: TLabel
          Left = 11
          Top = 18
          Width = 51
          Height = 13
          Caption = 'Language:'
        end
        object lblInfoTransAuthor: TLabel
          Left = 44
          Top = 42
          Width = 37
          Height = 13
          Caption = 'Author:'
        end
        object lblInfoTransEmail: TLabel
          Left = 44
          Top = 61
          Width = 32
          Height = 13
          Caption = 'E-mail:'
        end
        object lblTransAuthor: TLabel
          Left = 144
          Top = 42
          Width = 12
          Height = 13
          Caption = '...'
        end
        object lblTransEmail: TLabel
          Left = 144
          Top = 61
          Width = 12
          Height = 13
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsUnderline]
          ParentFont = False
        end
        object lblInfoTransURL: TLabel
          Left = 44
          Top = 80
          Width = 26
          Height = 13
          Caption = 'Web:'
        end
        object lblTransURL: TLabel
          Left = 144
          Top = 80
          Width = 12
          Height = 13
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsUnderline]
          ParentFont = False
        end
        object cmbLanguage: TComboBox
          Left = 144
          Top = 15
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = cmbLanguageChange
        end
      end
      object gbUpdater: TGroupBox
        Left = 3
        Top = 3
        Width = 451
        Height = 105
        Caption = 'Updater'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object lblUpdaterInterval: TLabel
          Left = 40
          Top = 51
          Width = 42
          Height = 13
          Caption = 'Interval:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblUpdaterIntervalUnit: TLabel
          Left = 162
          Top = 51
          Width = 27
          Height = 13
          Caption = 'hours'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object chkUpdaterCheckingUpdates: TCheckBox
          Left = 15
          Top = 25
          Width = 255
          Height = 17
          Caption = 'Checking updates'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object edtUpdaterInterval: TEdit
          Left = 88
          Top = 48
          Width = 33
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          Text = '0'
        end
        object udUpdaterInterval: TUpDown
          Left = 139
          Top = 48
          Width = 17
          Height = 21
          Min = 1
          Max = 999
          Position = 1
          TabOrder = 2
        end
        object btnUpdaterCheckUpdate: TBitBtn
          Left = 195
          Top = 48
          Width = 75
          Height = 25
          Caption = 'Check'
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentDoubleBuffered = False
          ParentFont = False
          TabOrder = 3
          OnClick = btnUpdaterCheckUpdateClick
        end
      end
    end
    object tsAdditional: TTabSheet
      Caption = 'Additional'
      ImageIndex = 1
      object chkCloseBookmarks: TCheckBox
        Left = 14
        Top = 25
        Width = 393
        Height = 17
        Caption = 'P'#345'i zav'#345'en'#237' okna zav'#345#237't i v'#353'echny z'#225'lo'#382'ky'
        TabOrder = 0
      end
      object btnVACUUM: TButton
        Left = 160
        Top = 160
        Width = 75
        Height = 25
        Caption = 'VACUUM'
        TabOrder = 1
        Visible = False
        OnClick = btnVACUUMClick
      end
    end
  end
  object pnlText: TPanel
    Left = 151
    Top = 8
    Width = 435
    Height = 25
    Caption = 'Unknown'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
  object btnAbout: TBitBtn
    Left = 152
    Top = 383
    Width = 97
    Height = 25
    Caption = 'About plugin...'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 7
    OnClick = btnAboutClick
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 48
    Top = 24
  end
  object ColorDialog1: TColorDialog
    Left = 80
    Top = 24
  end
end
