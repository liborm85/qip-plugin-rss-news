object frmListFeeds: TfrmListFeeds
  Left = 0
  Top = 0
  Caption = 'List Feeds'
  ClientHeight = 448
  ClientWidth = 561
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
  object lvData: TListView
    Left = 0
    Top = 29
    Width = 561
    Height = 275
    Align = alClient
    Columns = <
      item
        Width = 300
      end
      item
        Width = 100
      end>
    ReadOnly = True
    RowSelect = True
    SmallImages = ilListView
    TabOrder = 0
    ViewStyle = vsReport
    OnDblClick = lvDataDblClick
    OnKeyUp = lvDataKeyUp
    OnSelectItem = lvDataSelectItem
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 561
    Height = 29
    Caption = 'ToolBar1'
    Images = ilToolbar
    TabOrder = 1
    object tbtnRefresh: TToolButton
      Left = 0
      Top = 0
      Hint = 'Refresh'
      ImageIndex = 0
      ParentShowHint = False
      ShowHint = True
      OnClick = tbtnRefreshClick
    end
    object tbtnBack: TToolButton
      Left = 23
      Top = 0
      Hint = 'Back'
      ImageIndex = 3
      ParentShowHint = False
      ShowHint = True
      OnClick = tbtnBackClick
    end
    object tbtnHome: TToolButton
      Left = 46
      Top = 0
      Hint = 'Home'
      ImageIndex = 3
      ParentShowHint = False
      ShowHint = True
      OnClick = tbtnHomeClick
    end
    object ToolButton6: TToolButton
      Left = 69
      Top = 0
      Width = 8
      ImageIndex = 4
      Style = tbsSeparator
    end
    object tbtnCreateFolder: TToolButton
      Left = 77
      Top = 0
      Hint = 'Create folder'
      ImageIndex = 1
      ParentShowHint = False
      ShowHint = True
      OnClick = tbtnCreateFolderClick
    end
    object tbtnCreateFeed: TToolButton
      Left = 100
      Top = 0
      Hint = 'Create feed'
      ImageIndex = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = tbtnCreateFeedClick
    end
    object ToolButton5: TToolButton
      Left = 123
      Top = 0
      Width = 8
      ImageIndex = 4
      Style = tbsSeparator
    end
    object edtPath: TEdit
      Left = 131
      Top = 0
      Width = 346
      Height = 22
      ReadOnly = True
      TabOrder = 0
    end
  end
  object sbStatusBar: TStatusBar
    Left = 0
    Top = 429
    Width = 561
    Height = 19
    Panels = <
      item
        Width = 2048
      end>
  end
  object gbInfo: TGroupBox
    Left = 0
    Top = 304
    Width = 561
    Height = 125
    Align = alBottom
    Caption = 'Info'
    TabOrder = 3
    object Label3: TLabel
      Left = 12
      Top = 21
      Width = 31
      Height = 13
      Caption = 'Name:'
    end
    object Label4: TLabel
      Left = 12
      Top = 48
      Width = 57
      Height = 13
      Caption = 'Description:'
    end
    object Label5: TLabel
      Left = 12
      Top = 75
      Width = 23
      Height = 13
      Caption = 'URL:'
    end
    object Label6: TLabel
      Left = 12
      Top = 102
      Width = 25
      Height = 13
      Caption = 'Icon:'
    end
    object edtFeedName: TEdit
      Left = 100
      Top = 18
      Width = 309
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object edtFeedDescription: TEdit
      Left = 100
      Top = 45
      Width = 309
      Height = 21
      ReadOnly = True
      TabOrder = 1
    end
    object edtFeedURL: TEdit
      Left = 100
      Top = 72
      Width = 309
      Height = 21
      ReadOnly = True
      TabOrder = 2
    end
    object edtFeedIcon: TEdit
      Left = 100
      Top = 99
      Width = 309
      Height = 21
      ReadOnly = True
      TabOrder = 3
    end
    object btnAddFeed: TButton
      Left = 472
      Top = 94
      Width = 75
      Height = 25
      Caption = 'Add feed to CL'
      TabOrder = 4
      OnClick = btnAddFeedClick
    end
  end
  object tmrRefresh: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tmrRefreshTimer
    Left = 360
    Top = 56
  end
  object ilListView: TImageList
    Left = 360
    Top = 104
  end
  object ilToolbar: TImageList
    Left = 240
    Top = 120
  end
end
