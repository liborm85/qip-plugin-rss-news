object frmEditContact: TfrmEditContact
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Edit contact'
  ClientHeight = 454
  ClientWidth = 554
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
  object pnlContactName: TPanel
    Left = 0
    Top = 0
    Width = 554
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblContactName: TLabel
      Left = 8
      Top = 11
      Width = 71
      Height = 13
      Caption = 'Contact name:'
    end
    object edtContactName: TEdit
      Left = 100
      Top = 8
      Width = 445
      Height = 21
      TabOrder = 0
    end
  end
  object pnlContactOptions: TPanel
    Left = 0
    Top = 41
    Width = 554
    Height = 370
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object gbContactOptions: TGroupBox
      Left = 8
      Top = 0
      Width = 537
      Height = 370
      TabOrder = 0
      object tbContactOptions: TTabControl
        Left = 2
        Top = 15
        Width = 533
        Height = 353
        Align = alClient
        Style = tsFlatButtons
        TabOrder = 0
        Tabs.Strings = (
          'Feeds'
          'Global options for this contact'
          'Global options')
        TabIndex = 0
        OnChange = tbContactOptionsChange
        object pgContactOptions: TPageControl
          Left = 4
          Top = 68
          Width = 525
          Height = 281
          ActivePage = tsIconAndLogo
          Align = alClient
          TabOrder = 0
          OnChange = pgContactOptionsChange
          object tsGeneral: TTabSheet
            Caption = 'General'
            object lblFeedName: TLabel
              Left = 8
              Top = 11
              Width = 57
              Height = 13
              Caption = 'Feed name:'
            end
            object lblFeedTopic: TLabel
              Left = 8
              Top = 38
              Width = 29
              Height = 13
              Caption = 'Topic:'
            end
            object lblFeedURL: TLabel
              Left = 8
              Top = 65
              Width = 23
              Height = 13
              Caption = 'URL:'
            end
            object edtFeedName: TEdit
              Left = 100
              Top = 8
              Width = 405
              Height = 21
              TabOrder = 0
            end
            object edtFeedTopic: TEdit
              Left = 100
              Top = 35
              Width = 405
              Height = 21
              TabOrder = 1
            end
            object edtFeedURL: TEdit
              Left = 100
              Top = 62
              Width = 405
              Height = 21
              TabOrder = 2
            end
            object gbLogin: TGroupBox
              Left = 100
              Top = 89
              Width = 404
              Height = 80
              Caption = 'Login'
              TabOrder = 3
              object lblLoginName: TLabel
                Left = 8
                Top = 19
                Width = 31
                Height = 13
                Caption = 'Name:'
              end
              object lblLoginPassword: TLabel
                Left = 8
                Top = 46
                Width = 50
                Height = 13
                Caption = 'Password:'
              end
              object edtLoginName: TEdit
                Left = 97
                Top = 16
                Width = 296
                Height = 21
                TabOrder = 0
              end
              object edtLoginPassword: TEdit
                Left = 97
                Top = 43
                Width = 296
                Height = 21
                PasswordChar = '*'
                TabOrder = 1
              end
            end
            object gbUpdate: TGroupBox
              Left = 8
              Top = 175
              Width = 497
              Height = 70
              Caption = '       Update'
              TabOrder = 4
              object lblUpdateInterval: TLabel
                Left = 10
                Top = 33
                Width = 42
                Height = 13
                Caption = 'Interval:'
              end
              object lblUpdateIntervalUnit: TLabel
                Left = 133
                Top = 33
                Width = 37
                Height = 13
                Caption = 'minutes'
              end
              object chkOwnUpdate: TCheckBox
                Left = 10
                Top = 0
                Width = 17
                Height = 17
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                OnClick = chkOwnUpdateClick
              end
              object edtUpdateInterval: TEdit
                Left = 70
                Top = 29
                Width = 57
                Height = 21
                TabOrder = 1
              end
            end
          end
          object tsNotifications: TTabSheet
            Caption = 'Notifications'
            ImageIndex = 2
            object gbNotifications: TGroupBox
              Left = 8
              Top = 3
              Width = 497
              Height = 214
              Caption = '       Notifications'
              TabOrder = 0
              object lblNotificationPopupCloseTimeUnit: TLabel
                Left = 111
                Top = 104
                Width = 39
                Height = 13
                Caption = 'seconds'
              end
              object lblNotificationSoundFileName: TLabel
                Left = 26
                Top = 146
                Width = 51
                Height = 13
                Caption = 'Sound file:'
              end
              object lblNotificationOnlyLastMinutesUnit: TLabel
                Left = 332
                Top = 43
                Width = 37
                Height = 13
                Caption = 'minutes'
              end
              object chkOwnNotifications: TCheckBox
                Left = 10
                Top = 0
                Width = 17
                Height = 17
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                OnClick = chkOwnNotificationsClick
              end
              object chkNotificationTray: TCheckBox
                Left = 10
                Top = 23
                Width = 231
                Height = 17
                Caption = 'Tray icon'
                TabOrder = 1
              end
              object edtNotificationPopupCloseTime: TEdit
                Left = 48
                Top = 100
                Width = 57
                Height = 21
                TabOrder = 2
              end
              object chkNotificationPopup: TCheckBox
                Left = 10
                Top = 38
                Width = 231
                Height = 17
                Caption = 'Popup window'
                TabOrder = 3
                OnClick = chkNotificationPopupClick
              end
              object chkNotificationPopupShowTextOfMessage: TCheckBox
                Left = 26
                Top = 53
                Width = 231
                Height = 17
                Caption = 'Show text of message'
                TabOrder = 4
              end
              object chkNotificationPopupNoAutoClose: TCheckBox
                Left = 26
                Top = 68
                Width = 231
                Height = 17
                Caption = 'No auto close'
                TabOrder = 5
              end
              object chkNotificationSound: TCheckBox
                Left = 10
                Top = 123
                Width = 231
                Height = 17
                Caption = 'Sound signal'
                TabOrder = 6
                OnClick = chkNotificationSoundClick
              end
              object edtNotificationSoundFileName: TEdit
                Left = 120
                Top = 141
                Width = 286
                Height = 21
                TabOrder = 7
              end
              object chkNotificationPopupCloseTime: TCheckBox
                Left = 26
                Top = 83
                Width = 215
                Height = 17
                Caption = 'Zav'#345#237't po:'
                TabOrder = 8
                OnClick = chkNotificationPopupCloseTimeClick
              end
              object chkNotificationOnlyLastMinutes: TCheckBox
                Left = 247
                Top = 23
                Width = 215
                Height = 17
                Caption = 'Oznamovat pouze zpr'#225'vy za posledn'#237'ch:'
                TabOrder = 9
                OnClick = chkNotificationOnlyLastMinutesClick
              end
              object edtNotificationOnlyLastMinutes: TEdit
                Left = 269
                Top = 39
                Width = 57
                Height = 21
                TabOrder = 10
              end
            end
          end
          object tsIconAndLogo: TTabSheet
            Caption = 'Icon and Logo'
            ImageIndex = 3
            object gbIcon: TGroupBox
              Left = 8
              Top = 3
              Width = 245
              Height = 238
              Caption = '       Icon'
              TabOrder = 0
              object chkOwnIcon: TCheckBox
                Left = 10
                Top = 0
                Width = 17
                Height = 17
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                OnClick = chkOwnIconClick
              end
              object chkIconStandard: TCheckBox
                Left = 10
                Top = 23
                Width = 231
                Height = 17
                Caption = 'Show standard'
                TabOrder = 1
                OnClick = chkIconStandardClick
              end
              object chkOwnIconImage: TCheckBox
                Left = 10
                Top = 38
                Width = 231
                Height = 17
                Caption = 'Own image:'
                TabOrder = 2
              end
              object pnlIcon: TPanel
                Left = 70
                Top = 100
                Width = 96
                Height = 96
                BevelOuter = bvLowered
                TabOrder = 3
                object imgIcon: TImage
                  Left = 0
                  Top = 0
                  Width = 96
                  Height = 96
                  Center = True
                end
              end
              object btnIconRefresh: TBitBtn
                Left = 104
                Top = 202
                Width = 25
                Height = 25
                Hint = 'Refresh'
                DoubleBuffered = True
                ParentDoubleBuffered = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 4
              end
              object btnOwnIconImageBrowse: TBitBtn
                Left = 167
                Top = 55
                Width = 21
                Height = 21
                Caption = '...'
                DoubleBuffered = True
                ParentDoubleBuffered = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 5
                OnClick = btnOwnIconImageBrowseClick
              end
              object edtOwnIconImageFile: TEdit
                Left = 25
                Top = 55
                Width = 136
                Height = 21
                TabOrder = 6
              end
              object Panel1: TPanel
                Left = 9
                Top = 40
                Width = 185
                Height = 193
                BevelOuter = bvNone
                TabOrder = 7
              end
            end
            object gbLogo: TGroupBox
              Left = 259
              Top = 3
              Width = 245
              Height = 238
              Caption = '       Logo'
              TabOrder = 1
              object chkOwnLogo: TCheckBox
                Left = 10
                Top = 0
                Width = 17
                Height = 17
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                OnClick = chkOwnLogoClick
              end
              object pnlLogo: TPanel
                Left = 70
                Top = 100
                Width = 96
                Height = 96
                BevelOuter = bvLowered
                TabOrder = 1
                object imgLogo: TImage
                  Left = 0
                  Top = 0
                  Width = 96
                  Height = 96
                  Center = True
                end
              end
              object btnOwnLogoImageBrowse: TBitBtn
                Left = 167
                Top = 55
                Width = 21
                Height = 21
                Caption = '...'
                DoubleBuffered = True
                ParentDoubleBuffered = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 2
                OnClick = btnOwnLogoImageBrowseClick
              end
              object edtOwnLogoImageFile: TEdit
                Left = 25
                Top = 55
                Width = 136
                Height = 21
                TabOrder = 3
              end
              object chkOwnLogoImage: TCheckBox
                Left = 10
                Top = 38
                Width = 231
                Height = 17
                Caption = 'Own image:'
                TabOrder = 4
              end
              object btnLogoRefresh: TBitBtn
                Left = 104
                Top = 202
                Width = 25
                Height = 25
                Hint = 'Refresh'
                DoubleBuffered = True
                ParentDoubleBuffered = False
                ParentShowHint = False
                ShowHint = True
                TabOrder = 5
              end
              object Panel2: TPanel
                Left = 3
                Top = 21
                Width = 185
                Height = 214
                BevelOuter = bvNone
                TabOrder = 6
              end
            end
          end
          object tsContactList: TTabSheet
            Caption = 'Contact list'
            ImageIndex = 4
            object gbCLFont: TGroupBox
              Left = 8
              Top = 3
              Width = 497
              Height = 62
              Caption = '       Font'
              TabOrder = 0
              object btnCLFont: TSpeedButton
                Left = 274
                Top = 23
                Width = 22
                Height = 22
                Flat = True
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                OnClick = btnCLFontClick
              end
              object chkOwnCLFont: TCheckBox
                Left = 10
                Top = 0
                Width = 17
                Height = 17
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                OnClick = chkOwnCLFontClick
              end
              object edtCLFont: TEdit
                Left = 10
                Top = 23
                Width = 185
                Height = 21
                Color = clBtnFace
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                ReadOnly = True
                TabOrder = 1
              end
              object edtCLFontSize: TEdit
                Left = 202
                Top = 23
                Width = 33
                Height = 21
                Color = clBtnFace
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                ReadOnly = True
                TabOrder = 2
              end
              object pnlCLFontColor: TPanel
                Left = 245
                Top = 23
                Width = 22
                Height = 22
                BevelOuter = bvLowered
                ParentBackground = False
                TabOrder = 3
                OnDblClick = pnlCLFontColorDblClick
              end
            end
            object gbCLInformations: TGroupBox
              Left = 8
              Top = 71
              Width = 497
              Height = 122
              Caption = '       Informations'
              TabOrder = 1
              object chkOwnCLInformations: TCheckBox
                Left = 10
                Top = 0
                Width = 17
                Height = 17
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                OnClick = chkOwnCLInformationsClick
              end
              object chkSpecCntShowMsgCount: TCheckBox
                Left = 10
                Top = 23
                Width = 231
                Height = 17
                Caption = '_Zobrazovat celkov'#253' po'#269'et zpr'#225'v'
                TabOrder = 1
              end
              object chkSpecCntShowMsgUnreadCount: TCheckBox
                Left = 10
                Top = 38
                Width = 231
                Height = 17
                Caption = '_Zobrazovat po'#269'et nep'#345'e'#269'ten'#253'ch zpr'#225'v'
                TabOrder = 2
              end
              object chkSpecCntShowMsgNewCount: TCheckBox
                Left = 10
                Top = 53
                Width = 231
                Height = 17
                Caption = '_Zobrazovat po'#269'et nov'#253'ch zpr'#225'v'
                TabOrder = 3
              end
            end
          end
          object tsConnection: TTabSheet
            Caption = 'Connection'
            ImageIndex = 5
            object gbConLimit: TGroupBox
              Left = 8
              Top = 3
              Width = 497
              Height = 118
              Caption = '       Limit of connection'
              TabOrder = 0
              object lblTimeout: TLabel
                Left = 10
                Top = 33
                Width = 42
                Height = 13
                Caption = 'Timeout:'
              end
              object lblTimeoutUnit: TLabel
                Left = 183
                Top = 33
                Width = 13
                Height = 13
                Caption = 'ms'
              end
              object lblRetryDelay: TLabel
                Left = 10
                Top = 61
                Width = 99
                Height = 13
                Caption = 'Opakovac'#237' prodleva:'
              end
              object lblRetryDelayUnit: TLabel
                Left = 183
                Top = 61
                Width = 13
                Height = 13
                Caption = 'ms'
              end
              object lblRetryTimes: TLabel
                Left = 10
                Top = 89
                Width = 83
                Height = 13
                Caption = 'Po'#269'et opakov'#225'n'#237':'
              end
              object chkOwnConLimit: TCheckBox
                Left = 10
                Top = 0
                Width = 17
                Height = 17
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                OnClick = chkOwnConLimitClick
              end
              object edtTimeout: TEdit
                Left = 120
                Top = 29
                Width = 57
                Height = 21
                TabOrder = 1
              end
              object edtRetryDelay: TEdit
                Left = 120
                Top = 57
                Width = 57
                Height = 21
                TabOrder = 2
              end
              object edtRetryTimes: TEdit
                Left = 120
                Top = 85
                Width = 57
                Height = 21
                TabOrder = 3
              end
            end
          end
          object tsWindow: TTabSheet
            Caption = 'Window'
            ImageIndex = 6
            object gbSortMode: TGroupBox
              Left = 8
              Top = 3
              Width = 497
              Height = 62
              Caption = '       Sort mode'
              TabOrder = 0
              object chkOwnSortMode: TCheckBox
                Left = 10
                Top = 0
                Width = 17
                Height = 17
                TabOrder = 0
                OnClick = chkOwnSortModeClick
              end
              object cmbSortMode: TComboBox
                Left = 10
                Top = 23
                Width = 223
                Height = 21
                Style = csDropDownList
                ItemHeight = 13
                TabOrder = 1
              end
            end
          end
          object tsAdditional: TTabSheet
            Caption = 'Additional'
            ImageIndex = 5
            object gbGMT: TGroupBox
              Left = 8
              Top = 3
              Width = 497
              Height = 70
              Caption = '       _'#268'asov'#253' posun'
              TabOrder = 0
              object lblGMT: TLabel
                Left = 10
                Top = 33
                Width = 25
                Height = 13
                Caption = 'GMT:'
              end
              object lblGMTUnit: TLabel
                Left = 133
                Top = 33
                Width = 27
                Height = 13
                Caption = 'hours'
              end
              object chkOwnGMT: TCheckBox
                Left = 10
                Top = 0
                Width = 17
                Height = 17
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                OnClick = chkOwnGMTClick
              end
              object edtGMT: TEdit
                Left = 70
                Top = 29
                Width = 57
                Height = 21
                TabOrder = 1
              end
              object chkGMTSummerTime: TCheckBox
                Left = 200
                Top = 32
                Width = 97
                Height = 17
                Caption = 'Summer time'
                TabOrder = 2
                Visible = False
              end
            end
            object gbAdditional: TGroupBox
              Left = 8
              Top = 79
              Width = 497
              Height = 122
              Caption = '       Additional'
              TabOrder = 1
              object chkOwnAdditional: TCheckBox
                Left = 10
                Top = 0
                Width = 17
                Height = 17
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                OnClick = chkOwnAdditionalClick
              end
              object chkNewMessagesIdentifyByContents: TCheckBox
                Left = 10
                Top = 23
                Width = 471
                Height = 17
                Caption = '_Nov'#233' zpr'#225'vy identifikovat podle obsahu'
                TabOrder = 1
              end
            end
          end
        end
        object pnlFeeds: TPanel
          Left = 4
          Top = 27
          Width = 525
          Height = 41
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object cmbItems: TComboBox
            Left = 4
            Top = 10
            Width = 407
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 0
            OnChange = cmbItemsChange
          end
          object btnItemAdd: TBitBtn
            Left = 417
            Top = 8
            Width = 25
            Height = 25
            Hint = 'Add'
            DoubleBuffered = True
            ParentDoubleBuffered = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnClick = btnItemAddClick
          end
          object btnItemRemove: TBitBtn
            Left = 445
            Top = 8
            Width = 25
            Height = 25
            Hint = 'Remove'
            DoubleBuffered = True
            ParentDoubleBuffered = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            OnClick = btnItemRemoveClick
          end
          object btnItemUp: TBitBtn
            Left = 473
            Top = 8
            Width = 25
            Height = 25
            Hint = 'Up'
            DoubleBuffered = True
            ParentDoubleBuffered = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            Visible = False
          end
          object btnItemDown: TBitBtn
            Left = 501
            Top = 8
            Width = 25
            Height = 25
            Hint = 'Down'
            DoubleBuffered = True
            ParentDoubleBuffered = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            Visible = False
          end
        end
      end
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 411
    Width = 554
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object btnOK: TButton
      Left = 199
      Top = 6
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = btnOKClick
    end
    object btnCancel: TButton
      Left = 280
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object pmAddFeed: TPopupMenu
    Images = ilIcons
    Left = 440
    Top = 56
    object miAddFeed_AddFeed: TMenuItem
      Caption = 'Add feed'
      ImageIndex = 0
      OnClick = miAddFeed_AddFeedClick
    end
    object miAddFeed_AddEmail: TMenuItem
      Caption = 'Add e-mail'
      ImageIndex = 1
      object miAddFeed_AddEmail_Gmail: TMenuItem
        Caption = 'Gmail'
        ImageIndex = 2
        OnClick = miAddFeed_AddEmail_GmailClick
      end
      object miAddFeed_AddEmail_Seznamcz: TMenuItem
        Caption = 'Seznam.cz'
        ImageIndex = 3
        OnClick = miAddFeed_AddEmail_SeznamczClick
      end
    end
  end
  object ilIcons: TImageList
    Left = 480
    Top = 56
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 56
    Top = 416
  end
  object OpenDialog1: TOpenDialog
    Left = 96
    Top = 416
  end
end
