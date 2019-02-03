object frmWindow: TfrmWindow
  Left = 0
  Top = 0
  Caption = 'RSS News'
  ClientHeight = 464
  ClientWidth = 484
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  OnMouseUp = tabWindowMouseUp
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object tabWindow: TTabControl
    Left = 0
    Top = 0
    Width = 484
    Height = 445
    Align = alClient
    MultiLine = True
    OwnerDraw = True
    TabOrder = 0
    Tabs.Strings = (
      'A'
      'B'
      'C')
    TabIndex = 0
    TabStop = False
    OnChange = tabWindowChange
    OnDrawTab = tabWindowDrawTab
    OnMouseUp = tabWindowMouseUp
    object lblTopicTest: TLabel
      Left = 425
      Top = 5
      Width = 56
      Height = 13
      Caption = 'lblTopicTest'
      Visible = False
    end
    object pnlTab: TPanel
      Left = 4
      Top = 24
      Width = 476
      Height = 417
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      OnMouseUp = tabWindowMouseUp
      object Splitter1: TSplitter
        Left = 0
        Top = 242
        Width = 476
        Height = 3
        Cursor = crVSplit
        Align = alBottom
        AutoSnap = False
        ExplicitTop = 22
        ExplicitWidth = 223
      end
      object pnlTop: TPanel
        Left = 0
        Top = 0
        Width = 476
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        OnMouseUp = tabWindowMouseUp
        object tbTopButtons: TToolBar
          Left = 451
          Top = 0
          Width = 25
          Height = 22
          Align = alRight
          Images = ilToolbar
          TabOrder = 0
          OnMouseUp = tabWindowMouseUp
          object tbtnRefresh: TToolButton
            Left = 0
            Top = 0
            Caption = 'tbtnRefresh'
            ImageIndex = 0
            ParentShowHint = False
            ShowHint = True
            OnClick = tbtnRefreshClick
            OnMouseUp = tabWindowMouseUp
          end
        end
        object pnlTopic: TPanel
          Left = 0
          Top = 0
          Width = 451
          Height = 22
          Align = alClient
          BevelOuter = bvLowered
          Caption = 'pnlTopic'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnMouseUp = tabWindowMouseUp
        end
      end
      object pnlBottom: TPanel
        Left = 0
        Top = 395
        Width = 476
        Height = 22
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        OnMouseUp = tabWindowMouseUp
        object tbBottomRight: TToolBar
          Left = 451
          Top = 0
          Width = 25
          Height = 22
          Align = alRight
          Caption = 'tbBottomRight'
          Images = ilToolbar
          TabOrder = 0
          OnMouseUp = tabWindowMouseUp
          object tbtnClose: TToolButton
            Left = 0
            Top = 0
            Caption = 'tbtnClose'
            ImageIndex = 1
            ParentShowHint = False
            ShowHint = True
            OnClick = tbtnCloseClick
            OnMouseUp = tabWindowMouseUp
          end
        end
        object tbBottom: TToolBar
          Left = 0
          Top = 0
          Width = 451
          Height = 22
          Align = alClient
          Images = ilToolbar
          TabOrder = 1
          OnMouseUp = tabWindowMouseUp
          object tbtnPreview: TToolButton
            Left = 0
            Top = 0
            Caption = 'tbtnPreview'
            ImageIndex = 3
            ParentShowHint = False
            ShowHint = True
            Style = tbsCheck
            OnClick = tbtnPreviewClick
            OnMouseUp = tabWindowMouseUp
          end
          object tbtnDetails: TToolButton
            Left = 23
            Top = 0
            Caption = 'tbtnDetails'
            ImageIndex = 2
            ParentShowHint = False
            ShowHint = True
            OnClick = tbtnDetailsClick
            OnMouseUp = tabWindowMouseUp
          end
          object tbtnEdit: TToolButton
            Left = 46
            Top = 0
            Caption = 'tbtnEdit'
            ImageIndex = 4
            ParentShowHint = False
            ShowHint = True
            OnClick = tbtnEditClick
            OnMouseUp = tabWindowMouseUp
          end
          object ToolButton1: TToolButton
            Left = 69
            Top = 0
            Width = 8
            Caption = 'ToolButton1'
            ImageIndex = 5
            Style = tbsSeparator
            OnMouseUp = tabWindowMouseUp
          end
          object tbtnFilter: TToolButton
            Left = 77
            Top = 0
            Caption = 'tbtnFilter'
            ImageIndex = 16
            ParentShowHint = False
            ShowHint = True
            Style = tbsCheck
            OnClick = tbtnFilterClick
          end
          object ToolButton2: TToolButton
            Left = 100
            Top = 0
            Width = 8
            Caption = 'ToolButton2'
            ImageIndex = 9
            Style = tbsSeparator
          end
          object tbtnAddFeed: TToolButton
            Left = 108
            Top = 0
            Caption = 'tbtnAddFeed'
            ImageIndex = 5
            ParentShowHint = False
            ShowHint = True
            OnClick = tbtnAddFeedClick
            OnMouseUp = tabWindowMouseUp
          end
          object tbtnOptions: TToolButton
            Left = 131
            Top = 0
            Caption = 'tbtnOptions'
            ImageIndex = 8
            ParentShowHint = False
            ShowHint = True
            OnClick = tbtnOptionsClick
            OnMouseUp = tabWindowMouseUp
          end
        end
      end
      object pnlPreview: TPanel
        Left = 0
        Top = 245
        Width = 476
        Height = 150
        Align = alBottom
        TabOrder = 2
        OnMouseUp = tabWindowMouseUp
        object pnlPreviewHead: TPanel
          Left = 1
          Top = 1
          Width = 474
          Height = 41
          Align = alTop
          TabOrder = 0
          OnMouseUp = tabWindowMouseUp
          object lblPreviewTitle: TLabel
            Left = 11
            Top = 5
            Width = 83
            Height = 13
            Cursor = crHandPoint
            Caption = 'lblPreviewTitle'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold, fsUnderline]
            ParentFont = False
            OnClick = lblPreviewTitleClick
            OnMouseUp = tabWindowMouseUp
          end
          object lblPreviewDateTime: TLabel
            Left = 11
            Top = 24
            Width = 93
            Height = 13
            Caption = 'lblPreviewDateTime'
            OnMouseUp = tabWindowMouseUp
          end
          object imgEnclosure: TImage
            Left = 432
            Top = 5
            Width = 32
            Height = 32
            Center = True
            Visible = False
            OnMouseUp = tabWindowMouseUp
          end
          object lblPreviewComments: TLabel
            Left = 355
            Top = 24
            Width = 50
            Height = 13
            Cursor = crHandPoint
            Caption = 'Comments'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clHotLight
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsUnderline]
            ParentFont = False
            OnClick = lblPreviewCommentsClick
          end
          object lblPreviewCategory: TLabel
            Left = 147
            Top = 24
            Width = 93
            Height = 13
            Caption = 'lblPreviewCategory'
          end
        end
        object wbPreview: TWebBrowser
          Left = 1
          Top = 42
          Width = 474
          Height = 107
          Align = alClient
          TabOrder = 1
          ExplicitLeft = 112
          ExplicitTop = 48
          ExplicitWidth = 300
          ExplicitHeight = 150
          ControlData = {
            4C000000FD3000000F0B00000000000000000000000000000000000000000000
            000000004C000000000000000000000001000000E0D057007335CF11AE690800
            2B2E126208000000000000004C0000000114020000000000C000000000000046
            8000000000000000000000000000000000000000000000000000000000000000
            00000000000000000100000000000000000000000000000000000000}
        end
      end
      object lvData: TListView
        Left = 0
        Top = 57
        Width = 476
        Height = 185
        Align = alClient
        Columns = <
          item
            Caption = 'Title'
            Width = 300
          end
          item
            Caption = 'Date'
            Width = 150
          end>
        MultiSelect = True
        ReadOnly = True
        RowSelect = True
        SmallImages = ilListView
        TabOrder = 3
        ViewStyle = vsReport
        OnAdvancedCustomDrawItem = lvDataAdvancedCustomDrawItem
        OnDblClick = lvDataDblClick
        OnKeyPress = lvDataKeyPress
        OnKeyUp = FormKeyUp
        OnMouseDown = lvDataMouseDown
        OnSelectItem = lvDataSelectItem
      end
      object pnlFilter: TPanel
        Left = 0
        Top = 22
        Width = 476
        Height = 35
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 4
        DesignSize = (
          476
          35)
        object lblFilter: TLabel
          Left = 1
          Top = 12
          Width = 28
          Height = 13
          Caption = 'Filter:'
        end
        object edtFilter: TEdit
          Left = 46
          Top = 8
          Width = 375
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          OnChange = edtFilterChange
        end
        object tbFilter: TToolBar
          Left = 427
          Top = 7
          Width = 48
          Height = 22
          Align = alNone
          Anchors = [akTop, akRight]
          Images = ilToolbar
          TabOrder = 1
          Visible = False
          OnMouseUp = tabWindowMouseUp
          object tbtnFilterStart: TToolButton
            Left = 0
            Top = 0
            Caption = 'tbtnRefresh'
            ImageIndex = 16
            ParentShowHint = False
            ShowHint = True
            Style = tbsCheck
            OnMouseUp = tabWindowMouseUp
          end
          object tbtnFilterErase: TToolButton
            Left = 23
            Top = 0
            Caption = 'tbtnFilterErase'
            ImageIndex = 17
            OnClick = tbtnFilterEraseClick
            OnMouseUp = tabWindowMouseUp
          end
        end
      end
    end
  end
  object sbStatusBar: TStatusBar
    Left = 0
    Top = 445
    Width = 484
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 50
      end>
    OnMouseUp = tabWindowMouseUp
    OnDrawPanel = sbStatusBarDrawPanel
  end
  object pbStatusBar: TProgressBar
    Left = 27
    Top = 451
    Width = 54
    Height = 17
    Position = 50
    TabOrder = 2
  end
  object tmrShowBookmark: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tmrShowBookmarkTimer
    Left = 192
    Top = 104
  end
  object tmrShowPreview: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmrShowPreviewTimer
    Left = 232
    Top = 104
  end
  object ilToolbar: TImageList
    Left = 328
    Top = 136
  end
  object tmrNotification: TTimer
    Enabled = False
    Interval = 500
    OnTimer = tmrNotificationTimer
    Left = 288
    Top = 104
  end
  object pmContextMenu: TPopupMenu
    Images = ilToolbar
    Left = 200
    Top = 152
    object miContextMenu_OpenURL: TMenuItem
      Caption = 'Open'
      OnClick = miContextMenu_OpenURLClick
    end
    object miContextMenu_OpenMsg: TMenuItem
      Caption = 'Open message'
      Visible = False
    end
    object miContextMenu_RemoveMsg: TMenuItem
      Caption = 'Remove message'
      ImageIndex = 15
      OnClick = miContextMenu_RemoveMsgClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object miContextMenu_MarkAsRead: TMenuItem
      Caption = 'Mark as read'
      ImageIndex = 12
      OnClick = miContextMenu_MarkAsReadClick
    end
    object miContextMenu_MarkAsUnread: TMenuItem
      Caption = 'Mark as unread'
      ImageIndex = 11
      OnClick = miContextMenu_MarkAsUnreadClick
    end
    object miContextMenu_MarkFeedAsRead: TMenuItem
      Caption = 'Mark feed as read'
      ImageIndex = 12
      OnClick = miContextMenu_MarkFeedAsReadClick
    end
    object miContextMenu_MarkFeedAsUnread: TMenuItem
      Caption = 'Mark feed as unread'
      ImageIndex = 11
      OnClick = miContextMenu_MarkFeedAsUnreadClick
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object miContextMenu_Close: TMenuItem
      Caption = 'Close'
      ImageIndex = 1
      OnClick = miContextMenu_CloseClick
    end
    object miContextMenu_Refresh: TMenuItem
      Caption = 'Refresh'
      ImageIndex = 0
      OnClick = miContextMenu_RefreshClick
    end
    object miContextMenu_ContactDetails: TMenuItem
      Caption = 'Contact details'
      ImageIndex = 2
      OnClick = miContextMenu_ContactDetailsClick
    end
    object miContextMenu_Edit: TMenuItem
      Caption = 'Edit'
      ImageIndex = 4
      OnClick = miContextMenu_EditClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object miContextMenu_AddFeed: TMenuItem
      Caption = 'Add feed'
      ImageIndex = 5
      OnClick = miContextMenu_AddFeedClick
    end
    object miContextMenu_AddGmail: TMenuItem
      Caption = 'Add Gmail'
      ImageIndex = 9
      OnClick = miContextMenu_AddGmailClick
    end
    object miContextMenu_RenameFeed: TMenuItem
      Caption = 'Rename feed'
      ImageIndex = 6
    end
    object miContextMenu_RemoveFeed: TMenuItem
      Caption = 'Remove feed'
      ImageIndex = 7
      OnClick = miContextMenu_RemoveFeedClick
    end
    object miContextMenu_MoveTo: TMenuItem
      Caption = 'Move to'
    end
    object miContextMenu_CleanDatabase: TMenuItem
      Caption = 'Clean database'
      OnClick = miContextMenu_CleanDatabaseClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object miContextMenu_Options: TMenuItem
      Caption = 'Options'
      ImageIndex = 8
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object miContextMenu_Enclosures: TMenuItem
      Caption = 'Enclosures'
      ImageIndex = 10
      OnClick = miContextMenu_EnclosuresClick
    end
  end
  object ilListView: TImageList
    Left = 328
    Top = 192
  end
end
