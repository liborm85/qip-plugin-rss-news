unit EditContact;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons, Spin, ImgList, Menus, AppEvnts,
  CommCtrl;

type
  TfrmEditContact = class(TForm)
    pnlContactName: TPanel;
    pnlContactOptions: TPanel;
    pnlButtons: TPanel;
    edtContactName: TEdit;
    lblContactName: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    tbContactOptions: TTabControl;
    gbContactOptions: TGroupBox;
    pgContactOptions: TPageControl;
    tsGeneral: TTabSheet;
    tsNotifications: TTabSheet;
    tsIconAndLogo: TTabSheet;
    tsContactList: TTabSheet;
    tsAdditional: TTabSheet;
    pnlFeeds: TPanel;
    cmbItems: TComboBox;
    btnItemAdd: TBitBtn;
    btnItemRemove: TBitBtn;
    btnItemUp: TBitBtn;
    btnItemDown: TBitBtn;
    lblFeedName: TLabel;
    edtFeedName: TEdit;
    lblFeedTopic: TLabel;
    edtFeedTopic: TEdit;
    lblFeedURL: TLabel;
    edtFeedURL: TEdit;
    gbLogin: TGroupBox;
    lblLoginName: TLabel;
    edtLoginName: TEdit;
    lblLoginPassword: TLabel;
    edtLoginPassword: TEdit;
    gbCLFont: TGroupBox;
    chkOwnCLFont: TCheckBox;
    edtCLFont: TEdit;
    edtCLFontSize: TEdit;
    pnlCLFontColor: TPanel;
    btnCLFont: TSpeedButton;
    gbCLInformations: TGroupBox;
    chkOwnCLInformations: TCheckBox;
    chkSpecCntShowMsgCount: TCheckBox;
    chkSpecCntShowMsgUnreadCount: TCheckBox;
    chkSpecCntShowMsgNewCount: TCheckBox;
    gbUpdate: TGroupBox;
    chkOwnUpdate: TCheckBox;
    lblUpdateInterval: TLabel;
    edtUpdateInterval: TEdit;
    lblUpdateIntervalUnit: TLabel;
    tsConnection: TTabSheet;
    gbNotifications: TGroupBox;
    chkOwnNotifications: TCheckBox;
    chkNotificationTray: TCheckBox;
    edtNotificationPopupCloseTime: TEdit;
    lblNotificationPopupCloseTimeUnit: TLabel;
    chkNotificationPopup: TCheckBox;
    chkNotificationPopupShowTextOfMessage: TCheckBox;
    chkNotificationPopupNoAutoClose: TCheckBox;
    chkNotificationSound: TCheckBox;
    edtNotificationSoundFileName: TEdit;
    lblNotificationSoundFileName: TLabel;
    chkNotificationPopupCloseTime: TCheckBox;
    gbIcon: TGroupBox;
    chkOwnIcon: TCheckBox;
    chkIconStandard: TCheckBox;
    chkOwnIconImage: TCheckBox;
    gbLogo: TGroupBox;
    chkOwnLogo: TCheckBox;
    pnlIcon: TPanel;
    imgIcon: TImage;
    btnIconRefresh: TBitBtn;
    btnOwnIconImageBrowse: TBitBtn;
    edtOwnIconImageFile: TEdit;
    pnlLogo: TPanel;
    imgLogo: TImage;
    btnOwnLogoImageBrowse: TBitBtn;
    edtOwnLogoImageFile: TEdit;
    chkOwnLogoImage: TCheckBox;
    btnLogoRefresh: TBitBtn;
    gbConLimit: TGroupBox;
    lblTimeout: TLabel;
    lblTimeoutUnit: TLabel;
    chkOwnConLimit: TCheckBox;
    edtTimeout: TEdit;
    lblRetryDelay: TLabel;
    edtRetryDelay: TEdit;
    lblRetryDelayUnit: TLabel;
    lblRetryTimes: TLabel;
    edtRetryTimes: TEdit;
    tsWindow: TTabSheet;
    gbSortMode: TGroupBox;
    chkOwnSortMode: TCheckBox;
    cmbSortMode: TComboBox;
    gbGMT: TGroupBox;
    lblGMT: TLabel;
    lblGMTUnit: TLabel;
    chkOwnGMT: TCheckBox;
    edtGMT: TEdit;
    chkGMTSummerTime: TCheckBox;
    gbAdditional: TGroupBox;
    chkOwnAdditional: TCheckBox;
    chkNewMessagesIdentifyByContents: TCheckBox;
    pmAddFeed: TPopupMenu;
    miAddFeed_AddFeed: TMenuItem;
    miAddFeed_AddEmail: TMenuItem;
    ilIcons: TImageList;
    miAddFeed_AddEmail_Gmail: TMenuItem;
    miAddFeed_AddEmail_Seznamcz: TMenuItem;
    chkNotificationOnlyLastMinutes: TCheckBox;
    edtNotificationOnlyLastMinutes: TEdit;
    lblNotificationOnlyLastMinutesUnit: TLabel;
    FontDialog1: TFontDialog;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmbItemsChange(Sender: TObject);
    procedure tbContactOptionsChange(Sender: TObject);
    procedure btnItemAddClick(Sender: TObject);
    procedure btnItemRemoveClick(Sender: TObject);
    procedure miAddFeed_AddEmail_GmailClick(Sender: TObject);
    procedure miAddFeed_AddEmail_SeznamczClick(Sender: TObject);
    procedure chkOwnUpdateClick(Sender: TObject);
    procedure chkOwnNotificationsClick(Sender: TObject);
    procedure chkNotificationPopupClick(Sender: TObject);
    procedure chkOwnIconClick(Sender: TObject);
    procedure chkIconStandardClick(Sender: TObject);
    procedure chkOwnLogoClick(Sender: TObject);
    procedure chkOwnSortModeClick(Sender: TObject);
    procedure chkOwnConLimitClick(Sender: TObject);
    procedure chkOwnCLInformationsClick(Sender: TObject);
    procedure chkOwnGMTClick(Sender: TObject);
    procedure chkOwnAdditionalClick(Sender: TObject);
    procedure chkOwnCLFontClick(Sender: TObject);
    procedure chkNotificationSoundClick(Sender: TObject);
    procedure pgContactOptionsChange(Sender: TObject);
    procedure chkNotificationOnlyLastMinutesClick(Sender: TObject);
    procedure chkNotificationPopupCloseTimeClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure miAddFeed_AddFeedClick(Sender: TObject);
    procedure btnCLFontClick(Sender: TObject);
    procedure pnlCLFontColorDblClick(Sender: TObject);
    procedure btnOwnIconImageBrowseClick(Sender: TObject);
    procedure btnOwnLogoImageBrowseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    procedure AddFeeds;
    procedure ShowItem(iType: Integer; iFeed: Integer);
    procedure SaveItem(CLPos: Integer; iType: Integer; iFeed: Integer);
  end;

var
  frmEditContact: TfrmEditContact;

  OldPositionType : Integer;
  OldPositionFeed : Integer;

  CLFont_Color: WideString;


implementation

uses General, uLNG, uOptions, Convs, uImage, uIcon, Crypt, TextSearch, SQLiteFuncs,
     inifiles, u_lang_ids, uColors;

{$R *.dfm}

function Repl1(sText: WideString; sStation: WideString): WideString;
begin
  Result := StringReplace(sText, '%FEED%', sStation, [rfReplaceAll]);
end;

procedure TfrmEditContact.AddFeeds;
var i: Integer;
//    INI: TIniFile;
begin
  cmbItems.Items.Clear;


  i:=0;
  while ( i <= TCL(CL.Objects[EditContact_CLIndex]).Feed.Count - 1 ) do
  begin
    Application.ProcessMessages;
    if TFeed(TCL(CL.Objects[EditContact_CLIndex]).Feed.Objects[i]).Style = FEED_GMAIL then
      cmbItems.Items.Add( TFeed(TCL(CL.Objects[EditContact_CLIndex]).Feed.Objects[i]).Name + '  -  ' + ' Gmail: ' + EncryptText(TFeed(TCL(CL.Objects[EditContact_CLIndex]).Feed.Objects[i]).LoginName))
    else if TFeed(TCL(CL.Objects[EditContact_CLIndex]).Feed.Objects[i]).Style = FEED_RPC_SEZNAM then
      cmbItems.Items.Add( TFeed(TCL(CL.Objects[EditContact_CLIndex]).Feed.Objects[i]).Name + '  -  ' + ' Seznam.cz: ' + EncryptText(TFeed(TCL(CL.Objects[EditContact_CLIndex]).Feed.Objects[i]).LoginName))
    else
      cmbItems.Items.Add( TFeed(TCL(CL.Objects[EditContact_CLIndex]).Feed.Objects[i]).Name + '  -  ' + TFeed(TCL(CL.Objects[EditContact_CLIndex]).Feed.Objects[i]).URL);

    Inc(i);
  end;

end;

procedure TfrmEditContact.SaveItem(CLPos: Integer; iType: Integer; iFeed: Integer);
var sSQL, sID, sID2, sValue, sNotifications, sUpdate, sConLimit, sGMT, sSort,
     sSpecCnt, sLogo, sIcon, sAdditional : WideString;
    IdxOf       : Integer;
    INI: TInifile;
begin

  //Update
  sValue := '';
  if chkOwnUpdate.Checked = True then
    sValue := sValue + 'Own;';

  sValue := sValue + 'Interval=<'+edtUpdateInterval.Text+'>;';

  sUpdate := sValue;


  //Notifications
  sValue := '';
  if chkOwnNotifications.Checked = True then
    sValue := sValue + 'Own;';

  if chkNotificationSound.Checked = True then
    sValue := sValue + 'Sound;';
  if chkNotificationTray.Checked  = True then
    sValue := sValue + 'Tray;';
  if chkNotificationPopup.Checked = True then
    sValue := sValue + 'Popup;';

  if chkNotificationPopupShowTextOfMessage.Checked = True then
    sValue := sValue + 'Popup-MsgText;';


  if chkNotificationPopupNoAutoClose.Checked = True then
    sValue := sValue + 'Popup-NoAutoClose;';

  if chkNotificationPopupCloseTime.Checked = True then
    sValue := sValue + 'Popup-CloseTime=<'+edtNotificationPopupCloseTime.Text+'>;'
  else
    sValue := sValue + 'Popup-CloseTime=<0>;';

  if chkNotificationOnlyLastMinutes.Checked = True then
    sValue := sValue + 'OnlyLastMin=<'+edtNotificationOnlyLastMinutes.Text+'>;'
  else
    sValue := sValue + 'OnlyLastMin=<0>;';


  if edtNotificationSoundFileName.Text <> '' then
    sValue := sValue + 'Sound-FileName=<'+edtNotificationSoundFileName.Text+'>;';

  sNotifications := sValue;


  //ConLimit
  sValue := '';
  if chkOwnConLimit.Checked = True then
    sValue := sValue + 'Own;';

  sValue := sValue + 'RetryTimes=<'+edtRetryTimes.Text+'>;';
  sValue := sValue + 'Timeout=<'+edtTimeout.Text+'>;';
  sValue := sValue + 'RetryDelay=<'+edtRetryDelay.Text+'>;';

  sConLimit := sValue;


  //GMT
  sValue := '';
  if chkOwnGMT.Checked = True then
    sValue := sValue + 'Own;';

  if chkGMTSummerTime.Checked = True then
    sValue := sValue + 'ST;';

  sValue := sValue + 'GMT=<'+edtGMT.Text+'>;';

  sGMT := sValue;


  //Sort
  sValue := '';
  if chkOwnSortMode.Checked = True then
    sValue := sValue + 'Own;';

  if cmbSortMode.ItemIndex = 0 then
    sValue := sValue + 'ASC;'
  else if cmbSortMode.ItemIndex = 1 then
    sValue := sValue + 'DESC;';

  sSort := sValue;

  //SpecCnt
  sValue := '';
  if chkOwnCLInformations.Checked = True then
    sValue := sValue + 'Own;';

  if chkSpecCntShowMsgCount.Checked = True then
    sValue := sValue + 'Show-MsgCount;';
  if chkSpecCntShowMsgUnreadCount.Checked  = True then
    sValue := sValue + 'Show-MsgUnreadCount;';
  if chkSpecCntShowMsgNewCount.Checked = True then
    sValue := sValue + 'Show-MsgNewCount;';

  sSpecCnt := sValue;


  //Icon
  sValue := '';
  if chkOwnIcon.Checked = True then
    sValue := sValue + 'Own;';

  if chkIconStandard.Checked = True then
    sValue := sValue + 'Standard;';

  if chkOwnIconImage.Checked = True then
    sValue := sValue + 'OwnImage;';

  sValue := sValue + 'OwnImageFile=<'+edtOwnIconImageFile.Text+'>;';

  sIcon := sValue;


  //Logo
  sValue := '';
  if chkOwnLogo.Checked = True then
    sValue := sValue + 'Own;';

  if chkOwnLogoImage.Checked = True then
    sValue := sValue + 'OwnImage;';

  sValue := sValue + 'OwnImageFile=<'+edtOwnIconImageFile.Text+'>;';

  sLogo := sValue;


  //Additional
  sValue := '';
  if chkOwnAdditional.Checked = True then
    sValue := sValue + 'Own;';

  if chkNewMessagesIdentifyByContents.Checked = True then
    sValue := sValue + 'MsgsIdentifyByContents;';

  sAdditional := sValue;



  if iType = 2 then           // Global
  begin
    //Notifications
    IdxOf := GlobalOptions.IndexOf('Notifications');
    if IdxOf = -1 then
    begin
      GlobalOptions.Add( 'Notifications' );
      IdxOf:= GlobalOptions.Count - 1;
      GlobalOptions.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(GlobalOptions.Objects[IdxOf]).dataWideString := sNotifications;

    //Update
    IdxOf := GlobalOptions.IndexOf('Update');
    if IdxOf = -1 then
    begin
      GlobalOptions.Add( 'Update' );
      IdxOf:= GlobalOptions.Count - 1;
      GlobalOptions.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(GlobalOptions.Objects[IdxOf]).dataWideString := sUpdate;

    //ConLimit
    IdxOf := GlobalOptions.IndexOf('ConLimit');
    if IdxOf = -1 then
    begin
      GlobalOptions.Add( 'ConLimit' );
      IdxOf:= GlobalOptions.Count - 1;
      GlobalOptions.Objects[IdxOf] := TSLOptions.Create;
    end;

    TSLOptions(GlobalOptions.Objects[IdxOf]).dataWideString := sConLimit;

    //GMT
    IdxOf := GlobalOptions.IndexOf('GMT');
    if IdxOf = -1 then
    begin
      GlobalOptions.Add( 'GMT' );
      IdxOf:= GlobalOptions.Count - 1;
      GlobalOptions.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(GlobalOptions.Objects[IdxOf]).dataWideString := sGMT;

    //Sort
    IdxOf := GlobalOptions.IndexOf('Sort');
    if IdxOf = -1 then
    begin
      GlobalOptions.Add( 'Sort' );
      IdxOf:= GlobalOptions.Count - 1;
      GlobalOptions.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(GlobalOptions.Objects[IdxOf]).dataWideString := sSort;

    //SpecCnt
    IdxOf := GlobalOptions.IndexOf('SpecCnt');
    if IdxOf = -1 then
    begin
      GlobalOptions.Add( 'SpecCnt' );
      IdxOf:= GlobalOptions.Count - 1;
      GlobalOptions.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(GlobalOptions.Objects[IdxOf]).dataWideString := sSpecCnt;

    //Icon
    IdxOf := GlobalOptions.IndexOf('Icon');
    if IdxOf = -1 then
    begin
      GlobalOptions.Add( 'Icon' );
      IdxOf:= GlobalOptions.Count - 1;
      GlobalOptions.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(GlobalOptions.Objects[IdxOf]).dataWideString := sIcon;

    //Logo
    IdxOf := GlobalOptions.IndexOf('Logo');
    if IdxOf = -1 then
    begin
      GlobalOptions.Add( 'Logo' );
      IdxOf:= GlobalOptions.Count - 1;
      GlobalOptions.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(GlobalOptions.Objects[IdxOf]).dataWideString := sLogo;


    //Additional
    IdxOf := GlobalOptions.IndexOf('Additional');
    if IdxOf = -1 then
    begin
      GlobalOptions.Add( 'Additional' );
      IdxOf:= GlobalOptions.Count - 1;
      GlobalOptions.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(GlobalOptions.Objects[IdxOf]).dataWideString := sAdditional;


    INI := TiniFile.Create(ExtractFilePath(PluginDllPath) + Account_FileName + '.ini');
    INI.WriteString('Conf','GlobalOptions',  SaveOptions( GlobalOptions ) );
    INI.Free;


    fontDefaultCLFont.Font.Name  := edtCLFont.Font.Name;
    fontDefaultCLFont.Font.Size  := edtCLFont.Font.Size;
    fontDefaultCLFont.FontColor  := CLFont_Color;
    fontDefaultCLFont.Font.Style := edtCLFont.Font.Style;

    DefaultCLFont := SaveFont(fontDefaultCLFont);

    INI := TiniFile.Create(ExtractFilePath(PluginDllPath) + Account_FileName + '.ini');
    INI.WriteString('Conf', 'DefaultCLFont', DefaultCLFont );
    INI.Free;
  end
  else if iType = 1 then      // Global - contact
  begin

    //Notifications
    IdxOf := TCL(CL.Objects[CLPos]).Options.IndexOf('Notifications');
    if IdxOf = -1 then
    begin
      TCL(CL.Objects[CLPos]).Options.Add( 'Notifications' );
      IdxOf:= TCL(CL.Objects[CLPos]).Options.Count - 1;
      TCL(CL.Objects[CLPos]).Options.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(TCL(CL.Objects[CLPos]).Options.Objects[IdxOf]).dataWideString := sNotifications;

    //Update
    IdxOf := TCL(CL.Objects[CLPos]).Options.IndexOf('Update');
    if IdxOf = -1 then
    begin
      TCL(CL.Objects[CLPos]).Options.Add( 'Update' );
      IdxOf:= TCL(CL.Objects[CLPos]).Options.Count - 1;
      TCL(CL.Objects[CLPos]).Options.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(TCL(CL.Objects[CLPos]).Options.Objects[IdxOf]).dataWideString := sUpdate;

    //ConLimit
    IdxOf := TCL(CL.Objects[CLPos]).Options.IndexOf('ConLimit');
    if IdxOf = -1 then
    begin
      TCL(CL.Objects[CLPos]).Options.Add( 'ConLimit' );
      IdxOf:= TCL(CL.Objects[CLPos]).Options.Count - 1;
      TCL(CL.Objects[CLPos]).Options.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(TCL(CL.Objects[CLPos]).Options.Objects[IdxOf]).dataWideString := sConLimit;

    //GMT
    IdxOf := TCL(CL.Objects[CLPos]).Options.IndexOf('GMT');
    if IdxOf = -1 then
    begin
      TCL(CL.Objects[CLPos]).Options.Add( 'GMT' );
      IdxOf:= TCL(CL.Objects[CLPos]).Options.Count - 1;
      TCL(CL.Objects[CLPos]).Options.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(TCL(CL.Objects[CLPos]).Options.Objects[IdxOf]).dataWideString := sGMT;

    //Sort
    IdxOf := TCL(CL.Objects[CLPos]).Options.IndexOf('Sort');
    if IdxOf = -1 then
    begin
      TCL(CL.Objects[CLPos]).Options.Add( 'Sort' );
      IdxOf:= TCL(CL.Objects[CLPos]).Options.Count - 1;
      TCL(CL.Objects[CLPos]).Options.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(TCL(CL.Objects[CLPos]).Options.Objects[IdxOf]).dataWideString := sSort;

    //SpecCnt
    IdxOf := TCL(CL.Objects[CLPos]).Options.IndexOf('SpecCnt');
    if IdxOf = -1 then
    begin
      TCL(CL.Objects[CLPos]).Options.Add( 'SpecCnt' );
      IdxOf:= TCL(CL.Objects[CLPos]).Options.Count - 1;
      TCL(CL.Objects[CLPos]).Options.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(TCL(CL.Objects[CLPos]).Options.Objects[IdxOf]).dataWideString := sSpecCnt;

    //Icon
    IdxOf := TCL(CL.Objects[CLPos]).Options.IndexOf('Icon');
    if IdxOf = -1 then
    begin
      TCL(CL.Objects[CLPos]).Options.Add( 'Icon' );
      IdxOf:= TCL(CL.Objects[CLPos]).Options.Count - 1;
      TCL(CL.Objects[CLPos]).Options.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(TCL(CL.Objects[CLPos]).Options.Objects[IdxOf]).dataWideString := sIcon;

    //Logo
    IdxOf := TCL(CL.Objects[CLPos]).Options.IndexOf('Logo');
    if IdxOf = -1 then
    begin
      TCL(CL.Objects[CLPos]).Options.Add( 'Logo' );
      IdxOf:= TCL(CL.Objects[CLPos]).Options.Count - 1;
      TCL(CL.Objects[CLPos]).Options.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(TCL(CL.Objects[CLPos]).Options.Objects[IdxOf]).dataWideString := sLogo;


    //Additional
    IdxOf := TCL(CL.Objects[CLPos]).Options.IndexOf('Additional');
    if IdxOf = -1 then
    begin
      TCL(CL.Objects[CLPos]).Options.Add( 'Additional' );
      IdxOf:= TCL(CL.Objects[CLPos]).Options.Count - 1;
      TCL(CL.Objects[CLPos]).Options.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(TCL(CL.Objects[CLPos]).Options.Objects[IdxOf]).dataWideString := sAdditional;



    TCL(CL.Objects[EditContact_CLIndex]).Font.Font.Name  := edtCLFont.Font.Name;
    TCL(CL.Objects[EditContact_CLIndex]).Font.Font.Size  := edtCLFont.Font.Size;
    TCL(CL.Objects[EditContact_CLIndex]).Font.FontColor  := CLFont_Color;
    TCL(CL.Objects[EditContact_CLIndex]).Font.Font.Style := edtCLFont.Font.Style;

    IdxOf := TCL(CL.Objects[EditContact_CLIndex]).Options.IndexOf('OwnFont');
    if IdxOf = -1 then
    begin
      TCL(CL.Objects[EditContact_CLIndex]).Options.Add( 'OwnFont' );
      IdxOf:= TCL(CL.Objects[EditContact_CLIndex]).Options.Count - 1;
      TCL(CL.Objects[EditContact_CLIndex]).Options.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(TCL(CL.Objects[EditContact_CLIndex]).Options.Objects[IdxOf]).dataWideString := IntToStr(BoolToInt(chkOwnCLFont.Checked));



    sID := IntToStr(TCL(CL.Objects[CLPos]).ID);

    sSQL := 'UPDATE CL SET Options='+''''+ SaveOptions( TCL(CL.Objects[CLPos]).Options)+'''' + ' WHERE (ID='+sID+')';
    ExecSQLUTF8(sSQL);


    sSQL := 'UPDATE CL SET Font='+''''+ SaveFont(TCL(CL.Objects[EditContact_CLIndex]).Font)+''''+' WHERE (ID='+sID+')';
    ExecSQLUTF8(sSQL);


  end
  else                            // feed
  begin
    TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Name  := edtFeedName.Text;
    TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Topic := edtFeedTopic.Text;
    TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).URL   := edtFeedURL.Text;
    TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).LoginName      := CryptText(edtLoginName.Text);
    TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).LoginPassword  := CryptText(edtLoginPassword.Text);

    //Notifications
    IdxOf := TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.IndexOf('Notifications');
    if IdxOf = -1 then
    begin
      TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Add( 'Notifications' );
      IdxOf:= TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Count - 1;
      TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Objects[IdxOf]).dataWideString := sNotifications;

    //Update
    IdxOf := TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.IndexOf('Update');
    if IdxOf = -1 then
    begin
      TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Add( 'Update' );
      IdxOf:= TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Count - 1;
      TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Objects[IdxOf]).dataWideString := sUpdate;

    //ConLimit
    IdxOf := TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.IndexOf('ConLimit');
    if IdxOf = -1 then
    begin
      TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Add( 'ConLimit' );
      IdxOf:= TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Count - 1;
      TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Objects[IdxOf]).dataWideString := sConLimit;

    //GMT
    IdxOf := TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.IndexOf('GMT');
    if IdxOf = -1 then
    begin
      TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Add( 'GMT' );
      IdxOf:= TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Count - 1;
      TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Objects[IdxOf]).dataWideString := sGMT;

    //Sort
    IdxOf := TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.IndexOf('Sort');
    if IdxOf = -1 then
    begin
      TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Add( 'Sort' );
      IdxOf:= TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Count - 1;
      TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Objects[IdxOf]).dataWideString := sSort;

    //SpecCnt
    IdxOf := TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.IndexOf('SpecCnt');
    if IdxOf = -1 then
    begin
      TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Add( 'SpecCnt' );
      IdxOf:= TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Count - 1;
      TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Objects[IdxOf]).dataWideString := sSpecCnt;

    //Icon
    IdxOf := TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.IndexOf('Icon');
    if IdxOf = -1 then
    begin
      TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Add( 'Icon' );
      IdxOf:= TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Count - 1;
      TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Objects[IdxOf]).dataWideString := sIcon;


    //Logo
    IdxOf := TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.IndexOf('Logo');
    if IdxOf = -1 then
    begin
      TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Add( 'Logo' );
      IdxOf:= TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Count - 1;
      TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Objects[IdxOf]).dataWideString := sLogo;


    //Additional
    IdxOf := TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.IndexOf('Additional');
    if IdxOf = -1 then
    begin
      TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Add( 'Additional' );
      IdxOf:= TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Count - 1;
      TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Objects[IdxOf] := TSLOptions.Create;
    end;
    TSLOptions(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options.Objects[IdxOf]).dataWideString := sAdditional;



    sID := IntToStr(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).ID);

    sSQL := 'UPDATE RSS SET Name='+''''+TextToSQLText(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Name)+''''+' WHERE (ID='+sID+')';
    ExecSQLUTF8(sSQL);

    sSQL := 'UPDATE RSS SET Topic='+''''+TextToSQLText(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Topic)+''''+' WHERE (ID='+sID+')';
    ExecSQLUTF8(sSQL);

    sSQL := 'UPDATE RSS SET URL='+''''+TextToSQLText(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).URL)+''''+' WHERE (ID='+sID+')';
    ExecSQLUTF8(sSQL);

    sSQL := 'UPDATE RSS SET LoginName='+''''+TextToSQLText(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).LoginName)+''''+' WHERE (ID='+sID+')';
    ExecSQLUTF8(sSQL);

    sSQL := 'UPDATE RSS SET LoginPassword='+''''+TextToSQLText(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).LoginPassword)+''''+' WHERE (ID='+sID+')';
    ExecSQLUTF8(sSQL);

    sSQL := 'UPDATE RSS SET Options='+''''+ SaveOptions( TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[iFeed]).Options)+'''' + ' WHERE (ID='+sID+')';
    ExecSQLUTF8(sSQL);


    if TCL(CL.Objects[CLPos]).Feed.Count = 1 then
    begin
      TCL(CL.Objects[CLPos]).Name  := edtFeedName.Text;

      sID2 := IntToStr(TCL(CL.Objects[CLPos]).ID);

      sSQL := 'UPDATE CL SET Name='+''''+TextToSQLText(TCL(CL.Objects[CLPos]).Name)+''''+' WHERE (ID='+sID2+')';
      ExecSQLUTF8(sSQL);
    end;

    if TFeed(TCL(CL.Objects[EditContact_CLIndex]).Feed.Objects[iFeed]).Style = FEED_GMAIL then
      cmbItems.Items[iFeed] := TFeed(TCL(CL.Objects[EditContact_CLIndex]).Feed.Objects[iFeed]).Name + '  -  ' + ' Gmail: ' + EncryptText(TFeed(TCL(CL.Objects[EditContact_CLIndex]).Feed.Objects[iFeed]).LoginName)
    else if TFeed(TCL(CL.Objects[EditContact_CLIndex]).Feed.Objects[iFeed]).Style = FEED_RPC_SEZNAM then
      cmbItems.Items[iFeed] := TFeed(TCL(CL.Objects[EditContact_CLIndex]).Feed.Objects[iFeed]).Name + '  -  ' + ' Seznam.cz: ' + EncryptText(TFeed(TCL(CL.Objects[EditContact_CLIndex]).Feed.Objects[iFeed]).LoginName)
    else
      cmbItems.Items[iFeed] := TFeed(TCL(CL.Objects[EditContact_CLIndex]).Feed.Objects[iFeed]).Name + '  -  ' + TFeed(TCL(CL.Objects[EditContact_CLIndex]).Feed.Objects[iFeed]).URL;

  end;

end;

procedure TfrmEditContact.ShowItem(iType: Integer; iFeed: Integer);
var sValue,sValue2, sNotifications, sUpdate, sConLimit, sGMT, sSort, sSpecCnt,
    sLogo, sIcon, sAdditional: WideString;
    IdxOf: Integer;
begin


      tsConnection.TabVisible := False;


  if OldPositionFeed <> -1 then
  begin
    SaveItem(EditContact_CLIndex, OldPositionType, OldPositionFeed);
  end;


  if cmbItems.ItemIndex = -1 then
    cmbItems.ItemIndex := 0;
  


  OldPositionType := iType;
  OldPositionFeed := cmbItems.ItemIndex;

  EditContact_RSSIndex := OldPositionFeed;


  chkNotificationSound.Checked := False;
  chkNotificationTray.Checked := False;
  chkNotificationPopup.Checked := False;
  chkNotificationPopupShowTextOfMessage.Checked := False;
  chkNotificationPopupNoAutoClose.Checked := False;
  chkOwnUpdate.Checked := False;
  chkGMTSummerTime.Checked := False;
  chkSpecCntShowMsgCount.Checked := False;
  chkSpecCntShowMsgUnreadCount.Checked := False;
  chkSpecCntShowMsgNewCount.Checked := False;
  chkIconStandard.Checked := False;
  chkOwnIconImage.Checked := False;
  chkOwnLogoImage.Checked := False;
  chkNewMessagesIdentifyByContents.Checked := False;

  chkNotificationOnlyLastMinutes.Checked := False;


  if OldPositionType = 2 then     //Global options
  begin
    //pnlFeeds.Visible := False;

    cmbItems.Visible := False;
    btnItemAdd.Visible := False;
    btnItemRemove.Visible := False;
    //btnItemUp.Visible := False;
    //btnItemDown.Visible := False;

    lblFeedName.Enabled := False;
    lblFeedTopic.Enabled := False;
    lblFeedURL.Enabled := False;

    edtFeedName.Enabled := False;
    edtFeedTopic.Enabled := False;
    edtFeedURL.Enabled := False;

    edtFeedName.Text := '';
    edtFeedTopic.Text := '';
    edtFeedURL.Text := '';

    gbLogin.Visible := False;

    tsContactList.TabVisible := True;


    btnIconRefresh.Visible := False;
//    btnOwnIconImageBrowse.Visible := False;
    pnlIcon.Visible := False;
{
    btnLogoRefresh.Visible := False;
    btnOwnLogoImageBrowse.Visible := False;
    pnlLogo.Visible := False;
}



    chkOwnUpdate.Visible := False;
    chkOwnNotifications.Visible := False;
    chkOwnIcon.Visible := False;
    chkOwnLogo.Visible := False;
    chkOwnCLFont.Visible := False;
    chkOwnCLInformations.Visible := False;
    chkOwnConLimit.Visible := False;
    chkOwnSortMode.Visible :=False;
    chkOwnGMT.Visible := False;
    chkOwnAdditional.Visible := False;

    chkOwnUpdate.Checked := True;
    chkOwnNotifications.Checked := True;
    chkOwnIcon.Checked := True;
    chkOwnLogo.Checked := True;
    chkOwnCLFont.Checked := True;
    chkOwnCLInformations.Checked := True;
    chkOwnConLimit.Checked := True;
    chkOwnSortMode.Checked := True;
    chkOwnGMT.Checked := True;
    chkOwnAdditional.Checked := True;

    chkOwnUpdate.Enabled := False;
    chkOwnNotifications.Enabled := False;
    chkOwnIcon.Enabled := False;
    chkOwnLogo.Enabled := False;
    chkOwnCLFont.Enabled := False;
    chkOwnCLInformations.Enabled := False;
    chkOwnConLimit.Enabled := False;
    chkOwnSortMode.Enabled := False;
    chkOwnGMT.Enabled := False;
    chkOwnAdditional.Enabled := False;


    edtCLFont.Font.Name     := fontDefaultCLFont.Font.Name;
    edtCLFont.Font.Size     := fontDefaultCLFont.Font.Size;
    edtCLFont.Font.Style    := fontDefaultCLFont.Font.Style;
    CLFont_Color            := fontDefaultCLFont.FontColor;
    edtCLFont.Font.Color    := TextToColor(CLFont_Color, QIP_Colors);

    edtCLFont.Text          := edtCLFont.Font.Name;
    edtCLFontSize.Text      := IntToStr(edtCLFont.Font.Size);
    pnlCLFontColor.Color      := edtCLFont.Font.Color;


    sNotifications := LoadOptionOwn(-1,-1,'Notifications', 0);
    sUpdate := LoadOptionOwn(-1,-1,'Update', 0);
    sConLimit := LoadOptionOwn(-1,-1,'ConLimit', 0);
    sGMT := LoadOptionOwn(-1,-1,'GMT', 0);
    sSort := LoadOptionOwn(-1,-1,'Sort', 0);
    sSpecCnt := LoadOptionOwn(-1,-1,'SpecCnt', 0);
    sIcon := LoadOptionOwn(-1,-1,'Icon', 0);
    sLogo := LoadOptionOwn(-1,-1,'Logo', 0);
    sAdditional := LoadOptionOwn(-1,-1,'Additional', 0);

  end
  else if OldPositionType = 1 then     //Global options for this contact
  begin
    //pnlFeeds.Visible := False;

    cmbItems.Visible := False;
    btnItemAdd.Visible := False;
    btnItemRemove.Visible := False;
    //btnItemUp.Visible := False;
    //btnItemDown.Visible := False;

    lblFeedName.Enabled := False;
    lblFeedTopic.Enabled := False;
    lblFeedURL.Enabled := False;

    edtFeedName.Enabled := False;
    edtFeedTopic.Enabled := False;
    edtFeedURL.Enabled := False;

    edtFeedName.Text := '';
    edtFeedTopic.Text := '';
    edtFeedURL.Text := '';

    gbLogin.Visible := False;

    tsContactList.TabVisible := True;


    btnIconRefresh.Visible := False;
//    btnOwnIconImageBrowse.Visible := False;
    pnlIcon.Visible := False;
{
    btnLogoRefresh.Visible := False;
    btnOwnLogoImageBrowse.Visible := False;
    pnlLogo.Visible := False;
}



    chkOwnUpdate.Visible := True;
    chkOwnNotifications.Visible := True;
    chkOwnIcon.Visible := True;
    chkOwnLogo.Visible := True;
    chkOwnCLFont.Visible := True;
    chkOwnCLInformations.Visible := True;
    chkOwnConLimit.Visible := True;
    chkOwnSortMode.Visible := True;
    chkOwnGMT.Visible := True;
    chkOwnAdditional.Visible := True;

    chkOwnUpdate.Checked := False;
    chkOwnNotifications.Checked := False;
    chkOwnIcon.Checked := False;
    chkOwnLogo.Checked := False;
    chkOwnCLFont.Checked := False;
    chkOwnCLInformations.Checked := False;
    chkOwnConLimit.Checked := False;
    chkOwnSortMode.Checked := False;
    chkOwnGMT.Checked := False;
    chkOwnAdditional.Checked := False;

    chkOwnUpdate.Enabled := True;
    chkOwnNotifications.Enabled := True;
    chkOwnIcon.Enabled := True;
    chkOwnLogo.Enabled := True;
    chkOwnCLFont.Enabled := True;
    chkOwnCLInformations.Enabled := True;
    chkOwnConLimit.Enabled := True;
    chkOwnSortMode.Enabled := True;
    chkOwnGMT.Enabled := True;
    chkOwnAdditional.Enabled := True;

//    edtContactName.Text   := TCL(CL.Objects[EditContact_CLIndex]).Name;

    edtCLFont.Font.Name     := TCL(CL.Objects[EditContact_CLIndex]).Font.Font.Name;
    edtCLFont.Font.Size     := TCL(CL.Objects[EditContact_CLIndex]).Font.Font.Size;
    edtCLFont.Font.Style    := TCL(CL.Objects[EditContact_CLIndex]).Font.Font.Style;
    CLFont_Color         := TCL(CL.Objects[EditContact_CLIndex]).Font.FontColor;
    edtCLFont.Font.Color    := TextToColor(CLFont_Color, QIP_Colors);


    edtCLFont.Text          := edtCLFont.Font.Name;
    edtCLFontSize.Text      := IntToStr(edtCLFont.Font.Size);
    pnlCLFontColor.Color    := edtCLFont.Font.Color;

    chkOwnCLFont.Checked := False;
    IdxOf := TCL(CL.Objects[EditContact_CLIndex]).Options.IndexOf('OwnFont');
    if IdxOf <> -1 then
      if TSLOptions(TCL(CL.Objects[EditContact_CLIndex]).Options.Objects[IdxOf]).dataWideString = '1' then
        chkOwnCLFont.Checked := True;



    sNotifications := LoadOptionOwn(EditContact_CLIndex,-1,'Notifications', 1);
    sUpdate := LoadOptionOwn(EditContact_CLIndex,-1,'Update', 1);
    sConLimit := LoadOptionOwn(EditContact_CLIndex,-1,'ConLimit', 1);
    sGMT := LoadOptionOwn(EditContact_CLIndex,-1,'GMT', 1);
    sSort := LoadOptionOwn(EditContact_CLIndex,-1,'Sort', 1);
    sSpecCnt := LoadOptionOwn(EditContact_CLIndex,-1,'SpecCnt', 1);
    sIcon := LoadOptionOwn(EditContact_CLIndex,-1,'Icon', 1);
    sLogo := LoadOptionOwn(EditContact_CLIndex,-1,'Logo', 1);
    sAdditional := LoadOptionOwn(EditContact_CLIndex,-1,'Additional', 1);


  end
  else if OldPositionType = 0 then     //Feed
  begin
    //pnlFeeds.Visible := True;

    cmbItems.Visible := True;
    btnItemAdd.Visible := True;
    btnItemRemove.Visible := True;
    //btnItemUp.Visible := True;
    //btnItemDown.Visible := True;

    lblFeedName.Enabled := True;
    lblFeedTopic.Enabled := True;
    lblFeedURL.Enabled := True;

    edtFeedName.Enabled := True;
    edtFeedTopic.Enabled := True;
    edtFeedURL.Enabled := True;

    gbLogin.Visible := True;

    tsContactList.TabVisible := False;


    btnIconRefresh.Visible := True;
    btnOwnIconImageBrowse.Visible := True;
    pnlIcon.Visible := True;
{
    btnLogoRefresh.Visible := True;
    btnOwnLogoImageBrowse.Visible := True;
    pnlLogo.Visible := True;
}




    chkOwnUpdate.Visible := True;
    chkOwnNotifications.Visible := True;
    chkOwnIcon.Visible := True;
    chkOwnLogo.Visible := True;
    chkOwnCLFont.Visible := True;
    chkOwnCLInformations.Visible := True;
    chkOwnConLimit.Visible := True;
    chkOwnSortMode.Visible := True;
    chkOwnGMT.Visible := True;
    chkOwnAdditional.Visible := True;

    chkOwnUpdate.Checked := False;
    chkOwnNotifications.Checked := False;
    chkOwnIcon.Checked := False;
    chkOwnLogo.Checked := False;
    chkOwnCLFont.Checked := False;
    chkOwnCLInformations.Checked := False;
    chkOwnConLimit.Checked := False;
    chkOwnSortMode.Checked := False;
    chkOwnGMT.Checked := False;
    chkOwnAdditional.Checked := False;

    chkOwnUpdate.Enabled := True;
    chkOwnNotifications.Enabled := True;
    chkOwnIcon.Enabled := True;
    chkOwnLogo.Enabled := True;
    chkOwnCLFont.Enabled := True;
    chkOwnCLInformations.Enabled := True;
    chkOwnConLimit.Enabled := True;
    chkOwnSortMode.Enabled := True;
    chkOwnGMT.Enabled := True;
    chkOwnAdditional.Enabled := True;


    btnItemRemove.Enabled := True;
    btnItemUp.Enabled := not (cmbItems.ItemIndex = 0);
    btnItemDown.Enabled := not (cmbItems.ItemIndex = cmbItems.Items.Count - 1);


    edtFeedName.Text       := TFeed(TCL(CL.Objects[EditContact_CLIndex]).Feed.Objects[EditContact_RSSIndex]).Name;
    edtFeedTopic.Text     := TFeed(TCL(CL.Objects[EditContact_CLIndex]).Feed.Objects[EditContact_RSSIndex]).Topic;
    edtFeedURL.Text        := TFeed(TCL(CL.Objects[EditContact_CLIndex]).Feed.Objects[EditContact_RSSIndex]).URL;

    edtLoginName.Text      := EncryptText(TFeed(TCL(CL.Objects[EditContact_CLIndex]).Feed.Objects[EditContact_RSSIndex]).LoginName);
    edtLoginPassword.Text  := EncryptText(TFeed(TCL(CL.Objects[EditContact_CLIndex]).Feed.Objects[EditContact_RSSIndex]).LoginPassword);

    if TFeed(TCL(CL.Objects[EditContact_CLIndex]).Feed.Objects[EditContact_RSSIndex]).Style = FEED_GMAIL then
    begin
      edtFeedURL.Text    := '';
      lblFeedURL.Visible := False;
      edtFeedURL.Visible := False;
      
      lblLoginName.Caption := QIPPlugin.GetLang(LI_EMAIL)+':';
    end
    else if TFeed(TCL(CL.Objects[EditContact_CLIndex]).Feed.Objects[EditContact_RSSIndex]).Style = FEED_RPC_SEZNAM then
    begin
      edtFeedURL.Text    := '';
      lblFeedURL.Visible := False;
      edtFeedURL.Visible := False;

      lblLoginName.Caption := QIPPlugin.GetLang(LI_EMAIL)+':';
    end
    else
    begin
      lblLoginName.Caption := QIPPlugin.GetLang(LI_USER_NAME)+':';
    end;


    sNotifications := LoadOptionOwn(EditContact_CLIndex,EditContact_RSSIndex,'Notifications', 2);
    sUpdate := LoadOptionOwn(EditContact_CLIndex,EditContact_RSSIndex,'Update', 2);
    sConLimit := LoadOptionOwn(EditContact_CLIndex,EditContact_RSSIndex,'ConLimit', 2);
    sGMT := LoadOptionOwn(EditContact_CLIndex,EditContact_RSSIndex,'GMT', 2);
    sSort := LoadOptionOwn(EditContact_CLIndex,EditContact_RSSIndex,'Sort', 2);
    sSpecCnt := LoadOptionOwn(EditContact_CLIndex,EditContact_RSSIndex,'SpecCnt', 2);
    sIcon := LoadOptionOwn(EditContact_CLIndex,EditContact_RSSIndex,'Icon', 2);
    sLogo := LoadOptionOwn(EditContact_CLIndex,EditContact_RSSIndex,'Logo', 2);
    sAdditional := LoadOptionOwn(EditContact_CLIndex,EditContact_RSSIndex,'Additional', 2);

  end;



  //Notifications
  sValue := sNotifications;

  if 0 <> StrPosE(sValue,'Own;',1,false) then
    chkOwnNotifications.Checked := True;

  if 0 <> StrPosE(sValue,'Sound;',1,false) then
    chkNotificationSound.Checked := True;

  if 0 <> StrPosE(sValue,'Tray;',1,false) then
    chkNotificationTray.Checked := True;

  if 0 <> StrPosE(sValue,'Popup;',1,false) then
    chkNotificationPopup.Checked := True;

  if 0 <> StrPosE(sValue,'Popup-MsgText;',1,false) then
    chkNotificationPopupShowTextOfMessage.Checked := True;

  if 0 <> StrPosE(sValue,'Popup-NoAutoClose;',1,false) then
    chkNotificationPopupNoAutoClose.Checked := True;

  edtNotificationPopupCloseTime.Text := IntToStr( ConvStrToInt(GetOptionFromOptions(sValue,'Popup-CloseTime')) );
  if edtNotificationPopupCloseTime.Text <> '0' then
    chkNotificationPopupCloseTime.Checked := True;

  edtNotificationOnlyLastMinutes.Text := IntToStr( ConvStrToInt(GetOptionFromOptions(sValue,'OnlyLastMin')) );
  if edtNotificationOnlyLastMinutes.Text <> '0' then
    chkNotificationOnlyLastMinutes.Checked := True;

  edtNotificationSoundFileName.Text := GetOptionFromOptions(sValue,'Sound-FileName');


  //Update
  sValue := sUpdate;

  if 0 <> StrPosE(sValue,'Own;',1,false) then
    chkOwnUpdate.Checked := True;

  sValue2 := GetOptionFromOptions(sValue,'Interval');
  if sValue2 <> '' then
    edtUpdateInterval.Text := sValue2;


  //ConLimit
  sValue := sConLimit;

  if 0 <> StrPosE(sValue,'Own;',1,false) then
    chkOwnConLimit.Checked := True;

  edtRetryTimes.Text := GetOptionFromOptions(sValue,'RetryTimes');
  edtTimeout.Text    := GetOptionFromOptions(sValue,'Timeout');
  edtRetryDelay.Text := GetOptionFromOptions(sValue,'RetryDelay');


  //GMT
  sValue := sGMT;

  if 0 <> StrPosE(sValue,'Own;',1,false) then
    chkOwnGMT.Checked := True;

  if 0 <> StrPosE(sValue,'ST;',1,false) then
    chkGMTSummerTime.Checked := True;

  edtGMT.Text := GetOptionFromOptions(sValue,'GMT');

  //Sort
{  descending  sestupný
  ascending vzestupný  }
  sValue := sSort;

  if 0 <> StrPosE(sValue,'Own;',1,false) then
    chkOwnSortMode.Checked := True;

  if 0 <> StrPosE(sValue,'ASC;',1,false) then
    cmbSortMode.ItemIndex := 0;

  if 0 <> StrPosE(sValue,'DESC;',1,false) then
    cmbSortMode.ItemIndex := 1;

  if cmbSortMode.ItemIndex = -1 then cmbSortMode.ItemIndex := 0;


  //SpecCnt
  sValue := sSpecCnt;

  if 0 <> StrPosE(sValue,'Own;',1,false) then
    chkOwnCLInformations.Checked := True;

  if 0 <> StrPosE(sValue,'Show-MsgCount;',1,false) then
    chkSpecCntShowMsgCount.Checked := True;

  if 0 <> StrPosE(sValue,'Show-MsgUnreadCount;',1,false) then
    chkSpecCntShowMsgUnreadCount.Checked := True;

  if 0 <> StrPosE(sValue,'Show-MsgNewCount;',1,false) then
    chkSpecCntShowMsgNewCount.Checked := True;

  //Icon
  sValue := sIcon;

  if 0 <> StrPosE(sValue,'Own;',1,false) then
    chkOwnIcon.Checked := True;

  if 0 <> StrPosE(sValue,'Standard;',1,false) then
    chkIconStandard.Checked := True;

  if 0 <> StrPosE(sValue,'OwnImage;',1,false) then
    chkOwnIconImage.Checked := True;

  edtOwnIconImageFile.Text := GetOptionFromOptions(sValue,'OwnImageFile');


  //Logo
  sValue := sLogo;

  if 0 <> StrPosE(sValue,'Own;',1,false) then
    chkOwnLogo.Checked := True;

  if 0 <> StrPosE(sValue,'SetOwnImage;',1,false) then
    chkOwnLogoImage.Checked := True;

  edtOwnLogoImageFile.Text := GetOptionFromOptions(sValue,'OwnImageFile');


  //Additional
  sValue := sAdditional;

  if 0 <> StrPosE(sValue,'Own;',1,false) then
    chkOwnAdditional.Checked := True;

  if 0 <> StrPosE(sValue,'MsgsIdentifyByContents;',1,false) then
    chkNewMessagesIdentifyByContents.Checked := True;




  chkOwnUpdateClick(Self);

  chkOwnNotificationsClick(Self);
  chkNotificationSoundClick(Self);
  chkNotificationPopupClick(Self);

  chkOwnIconClick(Self);
  chkIconStandardClick(Self);
  chkOwnLogoClick(Self);

  chkOwnCLFontClick(Self);
  chkOwnCLInformationsClick(Self);

  chkOwnConLimitClick(Self);

  chkOwnSortModeClick(Self);

  chkOwnGMTClick(Self);
  chkOwnAdditionalClick(Self);

  chkNotificationPopupCloseTimeClick(Self);
  chkNotificationOnlyLastMinutesClick(Self)

end;

procedure TfrmEditContact.tbContactOptionsChange(Sender: TObject);
begin
  ShowItem(tbContactOptions.TabIndex, -1);
end;

procedure TfrmEditContact.btnCancelClick(Sender: TObject);
begin

  Close;
end;

procedure TfrmEditContact.btnCLFontClick(Sender: TObject);
begin
  FontDialog1.Font.Name := edtCLFont.Font.Name;
  FontDialog1.Font.Size := edtCLFont.Font.Size;
  FontDialog1.Font.Style := edtCLFont.Font.Style;

  if FontDialog1.Execute() then
  begin
    edtCLFont.Text := FontDialog1.Font.Name;
    edtCLFontSize.Text := IntToStr(FontDialog1.Font.Size);

    edtCLFont.Font.Name := FontDialog1.Font.Name;
    edtCLFont.Font.Size := FontDialog1.Font.Size;
    edtCLFont.Font.Style:= FontDialog1.Font.Style;
  end;
end;

procedure TfrmEditContact.btnItemAddClick(Sender: TObject);
var where: TPoint;
begin

  where := Mouse.CursorPos;
  pmAddFeed.Popup(where.X,where.Y);

end;

procedure TfrmEditContact.btnItemRemoveClick(Sender: TObject);
var sSQL: WideString;
    idx: Integer;
begin
  idx := cmbItems.ItemIndex;

  if OldPositionFeed <> -1 then
  begin
    SaveItem(EditContact_CLIndex, OldPositionType, OldPositionFeed);

    OldPositionFeed := -1;
  end;


  if MessageBoxW(0, PWideChar( Repl1 ( LNG('MESSAGE BOX','FeedRemove', 'Do you really want to remove feed "%FEED%" from list?' ) , TFeed(TCL(CL.Objects[EditContact_CLIndex]).Feed.Objects[idx]).Name ) ) , 'RSS News', MB_YESNO + MB_ICONQUESTION) = IDYES then
  begin
    sSQL := 'DELETE FROM RSS WHERE ID='+IntToStr(TFeed(TCL(CL.Objects[EditContact_CLIndex]).Feed.Objects[idx]).ID)+';';
    ExecSQLUTF8(sSQL);

    sSQL := 'DELETE FROM Data WHERE RSSID='+IntToStr(TFeed(TCL(CL.Objects[EditContact_CLIndex]).Feed.Objects[idx]).ID)+';';
    ExecSQLUTF8(sSQL);


    TCL(CL.Objects[EditContact_CLIndex]).Feed.Delete(idx);
    cmbItems.Items.Delete(idx{ + 2});

    if 0 < cmbItems.Items.Count - 1 then
      cmbItems.ItemIndex := 0;
      
    cmbItemsChange(Sender);

    {
    if idx + 2 <= cmbItems.Items.Count - 1 then
      cmbItems.ItemIndex := idx + 2
    else
      cmbItems.ItemIndex := 1;

    cmbItemsChange(Sender);     }
  end;


end;

procedure TfrmEditContact.btnOKClick(Sender: TObject);
var sID, sSQL: WideString;
begin
  if OldPositionFeed <> -1 then
  begin
    SaveItem(EditContact_CLIndex, OldPositionType, OldPositionFeed);
  end;

  TCL(CL.Objects[EditContact_CLIndex]).Name  := edtContactName.Text;



  sID := IntToStr(TCL(CL.Objects[EditContact_CLIndex]).ID);

  sSQL := 'UPDATE CL SET Name='+''''+TextToSQLText(TCL(CL.Objects[EditContact_CLIndex]).Name)+''''+' WHERE (ID='+sID+')';
  ExecSQLUTF8(sSQL);
{
  sSQL := 'UPDATE CL SET Topic='+''''+TextToSQLText(TCL(CL.Objects[EditContact_CLIndex]).Topic)+''''+' WHERE (ID='+sID+')';
  ExecSQLUTF8(sSQL);

  sSQL := 'UPDATE CL SET Font='+''''+ SaveFont(TCL(CL.Objects[EditContact_CLIndex]).Font)+''''+' WHERE (ID='+sID+')';
  ExecSQLUTF8(sSQL);

  sSQL := 'UPDATE CL SET Options='+''''+ SaveOptions( TCL(CL.Objects[EditContact_CLIndex]).Options )+''''+' WHERE (ID='+sID+')';
  ExecSQLUTF8(sSQL);
}
  Close;
end;

procedure TfrmEditContact.btnOwnIconImageBrowseClick(Sender: TObject);
begin
  OpenDialog1.Title := Caption;
  OpenDialog1.FileName := ExtractFilePath(PluginDllPath);
  OpenDialog1.InitialDir := ExtractFilePath(PluginDllPath);
//  OpenDialog1.InitialDir := {GetCurrentDir}ExtractFilePath(PluginDllPath);
  OpenDialog1.Options := [ofFileMustExist];
  OpenDialog1.Filter := '*.*|*.*';
  //  openDialog.FilterIndex := 2;

  if OpenDialog1.Execute then
  begin
    edtOwnIconImageFile.Text := OpenDialog1.FileName;
  end;
end;

procedure TfrmEditContact.btnOwnLogoImageBrowseClick(Sender: TObject);
begin
  OpenDialog1.Title := Caption;
  OpenDialog1.FileName := ExtractFilePath(PluginDllPath);
  OpenDialog1.InitialDir := ExtractFilePath(PluginDllPath);
//  OpenDialog1.InitialDir := GetCurrentDir;
  OpenDialog1.Options := [ofFileMustExist];
  OpenDialog1.Filter := '*.*|*.*';
  //  openDialog.FilterIndex := 2;

  if OpenDialog1.Execute then
  begin
    edtOwnLogoImageFile.Text := OpenDialog1.FileName;
  end;
end;

procedure TfrmEditContact.chkIconStandardClick(Sender: TObject);
begin
  if chkOwnIcon.Checked = False then
  begin
    chkOwnIconImage.Enabled := False;
    edtOwnIconImageFile.Enabled := False;
    btnOwnIconImageBrowse.Enabled :=   False;
  end
  else
  begin
    chkOwnIconImage.Enabled := not chkIconStandard.Checked;
    edtOwnIconImageFile.Enabled := not chkIconStandard.Checked;
    btnOwnIconImageBrowse.Enabled :=   not chkIconStandard.Checked;
  end;
end;

procedure TfrmEditContact.chkNotificationPopupClick(Sender: TObject);
begin
  if chkNotificationPopup.Enabled = False then
  begin
    chkNotificationPopupShowTextOfMessage.Enabled := False;
    edtNotificationPopupCloseTime.Enabled := False;
    chkNotificationPopupCloseTime.Enabled := False;
    lblNotificationPopupCloseTimeUnit.Enabled := False;
    chkNotificationPopupNoAutoClose.Enabled := False;
//    chkNotificationPopupOnlyLastMinutes.Enabled := False;
    chkNotificationPopupCloseTimeClick(Sender);
//    chkNotificationPopupOnlyLastMinutesClick(Sender);
  end
  else
  begin
    chkNotificationPopupShowTextOfMessage.Enabled := chkNotificationPopup.Checked;
    edtNotificationPopupCloseTime.Enabled := chkNotificationPopup.Checked;
    chkNotificationPopupCloseTime.Enabled := chkNotificationPopup.Checked;
    lblNotificationPopupCloseTimeUnit.Enabled := chkNotificationPopup.Checked;
    chkNotificationPopupNoAutoClose.Enabled := chkNotificationPopup.Checked;
//    chkNotificationPopupOnlyLastMinutes.Enabled := chkNotificationPopup.Checked;
    chkNotificationPopupCloseTimeClick(Sender);
//    chkNotificationPopupOnlyLastMinutesClick(Sender);
  end;
end;

procedure TfrmEditContact.chkNotificationPopupCloseTimeClick(
  Sender: TObject);
begin
  if chkNotificationPopupCloseTime.Enabled = False then
  begin
    edtNotificationPopupCloseTime.Enabled := False;
    lblNotificationPopupCloseTimeUnit.Enabled := False;
  end
  else
  begin
    edtNotificationPopupCloseTime.Enabled := chkNotificationPopupCloseTime.Checked;
    lblNotificationPopupCloseTimeUnit.Enabled := chkNotificationPopupCloseTime.Checked;
  end;
end;

procedure TfrmEditContact.chkNotificationOnlyLastMinutesClick(
  Sender: TObject);
begin
  if chkNotificationOnlyLastMinutes.Enabled = False then
  begin
    edtNotificationOnlyLastMinutes.Enabled := False;
    lblNotificationOnlyLastMinutesUnit.Enabled := False;
  end
  else
  begin
    edtNotificationOnlyLastMinutes.Enabled := chkNotificationOnlyLastMinutes.Checked;
    lblNotificationOnlyLastMinutesUnit.Enabled := chkNotificationOnlyLastMinutes.Checked;
  end;
end;

procedure TfrmEditContact.chkNotificationSoundClick(Sender: TObject);
begin
  if chkNotificationSound.Enabled = False then
  begin
    lblNotificationSoundFileName.Enabled := False;
    edtNotificationSoundFileName.Enabled := False;
  end
  else
  begin
    lblNotificationSoundFileName.Enabled := chkNotificationSound.Checked;
    edtNotificationSoundFileName.Enabled := chkNotificationSound.Checked;
  end;
end;

procedure TfrmEditContact.chkOwnAdditionalClick(Sender: TObject);
begin
  chkNewMessagesIdentifyByContents.Enabled := chkOwnAdditional.Checked;
end;

procedure TfrmEditContact.chkOwnCLFontClick(Sender: TObject);
begin
  edtCLFont.Enabled := chkOwnCLFont.Checked;
  edtCLFontSize.Enabled := chkOwnCLFont.Checked;
  pnlCLFontColor.Enabled := chkOwnCLFont.Checked;
  btnCLFont.Enabled := chkOwnCLFont.Checked;
end;

procedure TfrmEditContact.chkOwnCLInformationsClick(Sender: TObject);
begin
  chkSpecCntShowMsgCount.Enabled := chkOwnCLInformations.Checked;
  chkSpecCntShowMsgUnreadCount.Enabled := chkOwnCLInformations.Checked;
  chkSpecCntShowMsgNewCount.Enabled := chkOwnCLInformations.Checked;
end;

procedure TfrmEditContact.chkOwnConLimitClick(Sender: TObject);
begin
  lblRetryTimes.Enabled := chkOwnConLimit.Checked;
  edtRetryTimes.Enabled := chkOwnConLimit.Checked;

  lblTimeout.Enabled := chkOwnConLimit.Checked;
  edtTimeout.Enabled := chkOwnConLimit.Checked;
  lblTimeoutUnit.Enabled := chkOwnConLimit.Checked;

  lblRetryDelay.Enabled := chkOwnConLimit.Checked;
  edtRetryDelay.Enabled := chkOwnConLimit.Checked;
  lblRetryDelayUnit.Enabled := chkOwnConLimit.Checked;
end;

procedure TfrmEditContact.chkOwnGMTClick(Sender: TObject);
begin
  lblGMT.Enabled := chkOwnGMT.Checked;
  edtGMT.Enabled := chkOwnGMT.Checked;
  lblGMTUnit.Enabled := chkOwnGMT.Checked;
  chkGMTSummerTime.Enabled := chkOwnGMT.Checked;
end;

procedure TfrmEditContact.chkOwnIconClick(Sender: TObject);
begin
  chkIconStandard.Enabled := chkOwnIcon.Checked;
  chkOwnIconImage.Enabled := chkOwnIcon.Checked;
  edtOwnIconImageFile.Enabled := chkOwnIcon.Checked;
  btnOwnIconImageBrowse.Enabled   := chkOwnIcon.Checked;

  chkIconStandardClick(Sender);

end;

procedure TfrmEditContact.chkOwnLogoClick(Sender: TObject);
begin
  chkOwnLogoImage.Enabled := chkOwnLogo.Checked;
  edtOwnLogoImageFile.Enabled := chkOwnLogo.Checked;
  btnOwnLogoImageBrowse.Enabled   := chkOwnLogo.Checked;
end;

procedure TfrmEditContact.chkOwnNotificationsClick(Sender: TObject);
begin
  chkNotificationSound.Enabled := chkOwnNotifications.Checked;
  chkNotificationTray.Enabled  := chkOwnNotifications.Checked;

  lblNotificationSoundFileName.Enabled := chkOwnNotifications.Checked;
  edtNotificationSoundFileName.Enabled := chkOwnNotifications.Checked;

  chkNotificationPopup.Enabled := chkOwnNotifications.Checked;

  chkNotificationOnlyLastMinutes.Enabled := chkOwnNotifications.Checked;


  chkNotificationPopupClick(Sender);

  chkNotificationOnlyLastMinutesClick(Sender);
  

{  if ((chkNotificationPopup.Checked = True) and (chkOwnNotifications.Checked = True)) then
  begin
    chkNotificationPopupShowTextOfMessage.Enabled := True;

    edtNotificationPopupCloseTime.Enabled := True;
    chkNotificationPopupCloseTime.Enabled := True;
    lblNotificationPopupCloseTimeUnit.Enabled := True;
    chkNotificationPopupNoAutoClose.Enabled := True;

    chkNotificationPopupOnlyLastMinutes.Enabled := True;
    edtNotificationPopupOnlyLastMinutes.Enabled := True;
    lblNotificationPopupOnlyLastMinutesUnit.Enabled := True;
  end
  else
  begin
    chkNotificationPopupShowTextOfMessage.Enabled := False;

    edtNotificationPopupCloseTime.Enabled := False;
    chkNotificationPopupCloseTime.Enabled := False;
    lblNotificationPopupCloseTimeUnit.Enabled := False;
    chkNotificationPopupNoAutoClose.Enabled := False;

    chkNotificationPopupOnlyLastMinutes.Enabled := False;
    edtNotificationPopupOnlyLastMinutes.Enabled := False;
    lblNotificationPopupOnlyLastMinutesUnit.Enabled := False;
  end;     }
end;

procedure TfrmEditContact.chkOwnSortModeClick(Sender: TObject);
begin
  cmbSortMode.Enabled := chkOwnSortMode.Checked;
end;

procedure TfrmEditContact.chkOwnUpdateClick(Sender: TObject);
begin
  lblUpdateInterval.Enabled := chkOwnUpdate.Checked;
  edtUpdateInterval.Enabled := chkOwnUpdate.Checked;
  lblUpdateIntervalUnit.Enabled := chkOwnUpdate.Checked;
end;

procedure TfrmEditContact.cmbItemsChange(Sender: TObject);
begin
  ShowItem(tbContactOptions.TabIndex, -1);
end;


procedure TfrmEditContact.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  EditContactIsShow := False;
end;

procedure TfrmEditContact.FormShow(Sender: TObject);
var sOwnSpace : WideString;
begin
  EditContactIsShow := True;

  sOwnSpace := '       ';


  Icon := PluginSkin.PluginIcon.Icon;

  //32 bit support - transparent atd....
  ilIcons.Handle := ImageList_Create(ilIcons.Width, ilIcons.Height, ILC_COLOR32 or ILC_MASK, ilIcons.AllocBy, ilIcons.AllocBy);

  btnItemAdd.Glyph        := ImageToBitmap(PluginSkin.ItemAdd);
  btnItemRemove.Glyph     := ImageToBitmap(PluginSkin.ItemRemove);
  btnItemUp.Glyph         := ImageToBitmap(PluginSkin.ItemUp);
  btnItemDown.Glyph       := ImageToBitmap(PluginSkin.ItemDown);

  btnCLFont.Glyph         := ImageToBitmap(PluginSkin.Font.Image);

  btnIconRefresh.Glyph    := ImageToBitmap(PluginSkin.Refresh.Image);
  btnLogoRefresh.Glyph    := ImageToBitmap(PluginSkin.Refresh.Image);


  Caption := LNG('FORM EditContact', 'Caption', 'Edit contact');

  btnOK.Caption := QIPPlugin.GetLang(LI_OK);
  btnCancel.Caption := QIPPlugin.GetLang(LI_CANCEL);  

  miAddFeed_AddFeed.Caption := LNG('MENU ContactMenu', 'AddFeed', 'Add feed');
  miAddFeed_AddEmail.Caption := LNG('MENU ContactMenu', 'AddEmail', 'Add e-mail');

  chkOwnUpdate.Hint := LNG('FORM EditContact', 'Own', 'Own');
  chkOwnConLimit.Hint := chkOwnUpdate.Hint;
  chkOwnNotifications.Hint := chkOwnUpdate.Hint;
  chkOwnGMT.Hint := chkOwnUpdate.Hint;
  chkOwnSortMode.Hint := chkOwnUpdate.Hint;
  chkOwnCLInformations.Hint := chkOwnUpdate.Hint;
  chkOwnIcon.Hint := chkOwnUpdate.Hint;
  chkOwnLogo.Hint := chkOwnUpdate.Hint;
  chkOwnAdditional.Hint := chkOwnUpdate.Hint;

  tbContactOptions.Tabs.Strings[0] := LNG('FORM EditContact', 'Feeds', 'Feeds');
  tbContactOptions.Tabs.Strings[1] := LNG('FORM EditContact', 'GlobalOptionsForThisContact', 'Global options for this contact');
  tbContactOptions.Tabs.Strings[2] := LNG('FORM EditContact', 'GlobalOptions', 'Global options');


  btnIconRefresh.Hint := QIPPlugin.GetLang(LI_REFRESH);
  btnOwnIconImageBrowse.Hint := QIPPlugin.GetLang(LI_BROWSE);

  btnLogoRefresh.Hint := QIPPlugin.GetLang(LI_REFRESH);
  btnOwnLogoImageBrowse.Hint := QIPPlugin.GetLang(LI_BROWSE);

  btnItemAdd.Hint := QIPPlugin.GetLang(LI_ADD);
  btnItemRemove.Hint := QIPPlugin.GetLang(LI_REMOVE);

  btnItemUp.Hint := QIPPlugin.GetLang(LI_HST_UP);
  btnItemDown.Hint := QIPPlugin.GetLang(LI_HST_DOWN);

  tsGeneral.Caption := QIPPlugin.GetLang(LI_GENERAL);
  tsNotifications.Caption := LNG('FORM EditContact', 'Notifications', 'Notifications');
  tsIconAndLogo.Caption := LNG('FORM EditContact', 'IconAndLogo', 'Icon and logo');
  tsContactList.Caption := QIPPlugin.GetLang(LI_CONTACT_LIST);
  tsConnection.Caption := QIPPlugin.GetLang(LI_CONNECTION);
  tsWindow.Caption := QIPPlugin.GetLang(LI_CL_WINDOW);
  tsAdditional.Caption := QIPPlugin.GetLang(LI_ADDITIONAL);

  lblContactName.Caption := LNG('FORM EditContact', 'ContactName', 'Contact name:');
  lblFeedName.Caption  := LNG('FORM EditContact', 'FeedName', 'Feed name:');
  lblFeedTopic.Caption := QIPPlugin.GetLang(LI_TOPIC) + ':';
  lblFeedURL.Caption := LNG('FORM EditContact', 'URL', 'URL:');

  gbLogin.Caption := QIPPlugin.GetLang(LI_LOGIN_SERVICES);
  lblLoginName.Caption := QIPPlugin.GetLang(LI_USER_NAME)+':';
  lblLoginPassword.Caption := QIPPlugin.GetLang(LI_USER_PASS)+':';

  gbUpdate.Caption := sOwnSpace + LNG('FORM EditContact', 'Update', 'Update');

  lblUpdateInterval.Caption := LNG('FORM EditContact', 'Interval', 'Interval:');
  lblUpdateIntervalUnit.Caption := QIPPlugin.GetLang(LI_MINUTES);


  
  gbNotifications.Caption := sOwnSpace + tsNotifications.Caption;
  chkNotificationTray.Caption := QIPPlugin.GetLang(LI_SND_EV_TRAY_NOTIFY);
  chkNotificationPopup.Caption := QIPPlugin.GetLang(LI_TRAY_POP_MSGS_WND);
  chkNotificationPopupShowTextOfMessage.Caption := LNG('FORM EditContact', 'ShowTextOfMessage', 'Show text of message');
  chkNotificationPopupNoAutoClose.Caption := LNG('FORM EditContact', 'NoAutoClose', 'No autoclose');
  //Zavirat po
  //lblNotificationPopupCloseTimeUnit.Caption := QIPPlugin.GetLang(LI_SECONDS);

  chkNotificationSound.Caption := QIPPlugin.GetLang(LI_PLAY_SPEC_MSG_SND);
  lblNotificationSoundFileName.Caption := QIPPlugin.GetLang(LI_SND_FILE);  







  gbIcon.Caption := sOwnSpace + LNG('FORM EditContact', 'Icon', 'Icon');
  gbLogo.Caption := sOwnSpace + LNG('FORM EditContact', 'Logo', 'Logo');

  chkIconStandard.Caption := LNG('FORM EditContact', 'ShowStandard', 'Show standard');

  chkOwnIconImage.Caption := LNG('FORM EditContact', 'OwnImage', 'Own image:');
  chkOwnLogoImage.Caption := LNG('FORM EditContact', 'OwnImage', 'Own image:');

  
  //CL
  gbCLFont.Caption := sOwnSpace + QIPPlugin.GetLang(LI_FONT);
  gbCLInformations.Caption := sOwnSpace + QIPPlugin.GetLang(LI_INFORMATION);
  chkSpecCntShowMsgCount.Caption := LNG('FORM EditContact', 'ShowMsgCount', '_Zobrazovat celkový poèet zpráv');
  chkSpecCntShowMsgUnreadCount.Caption := LNG('FORM EditContact', 'ShowMsgUnreadCount', '_Zobrazovat poèet nepøeètených zpráv');
  chkSpecCntShowMsgNewCount.Caption := LNG('FORM EditContact', 'ShowMsgNewCount', '_Zobrazovat poèet nových zpráv');


  gbConLimit.Caption := sOwnSpace + LNG('FORM EditContact', 'LimitOfConnection', 'Limit of connection');
  lblTimeout.Caption := LNG('FORM EditContact', 'TimeOut', 'Timeout');
  lblTimeoutUnit.Caption := LNG('FORM EditContact', 'ms', 'ms');
//  lblRetryDelay.Caption := LNG('FORM EditContact', 'RetryDelay', 'rd');
//  lblRetryDelay.Caption := LNG('FORM EditContact', 'RetryTimer', 'rt');


  gbSortMode.Caption := sOwnSpace + QIPPlugin.GetLang(LI_CL_SORT_MODE);
{  descending  sestupný
  ascending vzestupný  }
  cmbSortMode.Items.Add(LNG('FORM EditContact', 'SortByDateASC', 'Sort by date ascending'));
  cmbSortMode.Items.Add(LNG('FORM EditContact', 'SortByDateDESC', 'Sort by date descending'));



  //GMT
  lblGMTUnit.Caption := QIPPlugin.GetLang(LI_HOURS);

  gbAdditional.Caption := sOwnSpace + tsAdditional.Caption;
  chkNewMessagesIdentifyByContents.Caption := LNG('FORM EditContact', 'NewMessagesIdentifyByContents', '_Nové zprávy identifikovat podle obsahu');


  ilIcons.AddIcon(PluginSkin.AddContact.Icon);
  ilIcons.AddIcon(PluginSkin.Email.Icon);
  ilIcons.AddIcon(PluginSkin.Gmail.Icon);
  ilIcons.AddIcon(PluginSkin.Seznam.Icon);

  pgContactOptions.TabIndex := 0;  

  OldPositionType := -1;
  OldPositionFeed := -1;


  edtContactName.Text   := TCL(CL.Objects[EditContact_CLIndex]).Name;

  AddFeeds;


  if cmbItems.Items.Count > 0 then
  begin
    cmbItems.ItemIndex := 0;
    cmbItemsChange(Sender);
  end;



end;



procedure TfrmEditContact.miAddFeed_AddEmail_GmailClick(Sender: TObject);
begin
{
  OpenAddFeed(-1, FEED_GMAIL, 0, '', '');
}

  OpenAddFeed(EditContact_CLIndex, FEED_GMAIL, 0, '', '');
  Close;
end;

procedure TfrmEditContact.miAddFeed_AddEmail_SeznamczClick(Sender: TObject);
begin
{
  OpenAddFeed(-1, FEED_RPC_SEZNAM, 0, '', '');
}
  OpenAddFeed(EditContact_CLIndex, FEED_RPC_SEZNAM, 0, '', '');
  Close;
end;

procedure TfrmEditContact.miAddFeed_AddFeedClick(Sender: TObject);
begin
  OpenAddFeed(EditContact_CLIndex, FEED_NORMAL, 0, '', '');
  Close;
end;

procedure TfrmEditContact.pgContactOptionsChange(Sender: TObject);
begin
//showmessage(';;;');
//  ShowItem(tbContactOptions.TabIndex, -1);
end;

procedure TfrmEditContact.pnlCLFontColorDblClick(Sender: TObject);
begin
  ShowColors(CLFont_Color);

  edtCLFont.Font.Color    := TextToColor(CLFont_Color, QIP_Colors);
  pnlCLFontColor.Color    := edtCLFont.Font.Color;
end;

end.
