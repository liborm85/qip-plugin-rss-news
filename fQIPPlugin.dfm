object frmQIPPlugin: TfrmQIPPlugin
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 320
  ClientWidth = 434
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object tmrStep: TTimer
    Enabled = False
    Interval = 500
    OnTimer = tmrStepTimer
    Left = 16
    Top = 48
  end
  object tmrStart: TTimer
    Enabled = False
    OnTimer = tmrStartTimer
    Left = 16
    Top = 8
  end
  object tmrUpdate: TTimer
    Enabled = False
    OnTimer = tmrUpdateTimer
    Left = 96
    Top = 16
  end
  object pmContactMenu: TPopupMenu
    Images = ilToolbar
    Left = 200
    Top = 16
    object miContactMenu_Open: TMenuItem
      Caption = 'Open'
      OnClick = miContactMenu_OpenClick
    end
    object miContactMenu_OpenOnly: TMenuItem
      Caption = 'Open...'
      OnClick = miContactMenu_OpenOnlyClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object miContactMenu_Refresh: TMenuItem
      Caption = 'Refresh'
      ImageIndex = 0
      OnClick = miContactMenu_RefreshClick
    end
    object miContactMenu_ContactDetails: TMenuItem
      Caption = 'Contact details'
      ImageIndex = 2
      OnClick = miContactMenu_ContactDetailsClick
    end
    object miContactMenu_Edit: TMenuItem
      Caption = 'Edit'
      ImageIndex = 4
      OnClick = miContactMenu_EditClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object miContactMenu_AddFeed: TMenuItem
      Caption = 'Add feed'
      ImageIndex = 5
      OnClick = miContactMenu_AddFeedClick
    end
    object miContactMenu_AddEmail: TMenuItem
      Caption = 'Add email'
      ImageIndex = 17
      object miContactMenu_AddEmail_Gmail: TMenuItem
        Caption = 'Gmail'
        ImageIndex = 9
        OnClick = miContactMenu_AddEmail_GmailClick
      end
      object miContactMenu_AddEmail_Seznam: TMenuItem
        Caption = 'Seznam.cz'
        ImageIndex = 18
        OnClick = miContactMenu_AddEmail_SeznamClick
      end
    end
    object miContactMenu_Rename: TMenuItem
      Caption = 'Rename'
      ImageIndex = 6
    end
    object miContactMenu_Remove: TMenuItem
      Caption = 'Remove'
      ImageIndex = 7
      OnClick = miContactMenu_RemoveClick
    end
    object miContactMenu_MoveTo: TMenuItem
      Caption = 'Move to'
      OnClick = miContactMenu_MoveToClick
    end
    object miContactMenu_MoveToGroup: TMenuItem
      Caption = 'Move to group'
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object miContactMenu_FeedsDatabase: TMenuItem
      Caption = 'Feeds database'
      ImageIndex = 16
      Visible = False
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object miContactMenu_Status: TMenuItem
      Caption = 'Status'
      object miContactMenu_Status_Online: TMenuItem
        Caption = 'Online'
        ImageIndex = 10
        OnClick = miContactMenu_Status_OnlineClick
      end
      object miContactMenu_Status_DND: TMenuItem
        Caption = 'Do not disturb'
        ImageIndex = 15
        OnClick = miContactMenu_Status_DNDClick
      end
      object miContactMenu_Status_Offline: TMenuItem
        Caption = 'Offline'
        ImageIndex = 11
        OnClick = miContactMenu_Status_OfflineClick
      end
    end
    object miContactMenu_ImportExport: TMenuItem
      Caption = 'Import/Export'
      ImageIndex = 12
      object miContactMenu_ImportExport_Import: TMenuItem
        Caption = 'Import...'
        ImageIndex = 13
        OnClick = miContactMenu_ImportExport_ImportClick
      end
      object miContactMenu_ImportExport_Export: TMenuItem
        Caption = 'Export...'
        ImageIndex = 14
        OnClick = miContactMenu_ImportExport_ExportClick
      end
    end
    object miContactMenu_Options: TMenuItem
      Caption = 'Options'
      ImageIndex = 8
      OnClick = miContactMenu_OptionsClick
    end
  end
  object tmrUpdaterTimeout: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = tmrUpdaterTimeoutTimer
    Left = 128
    Top = 16
  end
  object TrayIcon1: TTrayIcon
    Animate = True
    AnimateInterval = 500
    OnClick = TrayIcon1Click
    OnAnimate = TrayIcon1Animate
    Left = 312
    Top = 80
  end
  object ilToolbar: TImageList
    Left = 232
    Top = 16
  end
end
