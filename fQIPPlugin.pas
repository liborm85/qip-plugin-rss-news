unit fQIPPlugin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus,
  u_plugin_info, u_plugin_msg, u_common,
  ImgList, inifiles, StdCtrls, HotKeyManager;

type

  { TSpecCntUniq }
  TSpecCntUniq = record
    UniqID            : DWord;
    ItemType          : DWord;
    Index             : DWord;
  end;
  pSpecCntUniq = ^TSpecCntUniq;

  { FadeMsg }
  TFadeMsg = class
  public
    FadeType     : Byte;        //0 - message style, 1 - information style, 2 - warning style
    FadeIcon     : HICON;       //icon in the top left corner of the window
    FadeTitle    : WideString;
    FadeText     : WideString;
    TextCentered : Boolean;     //if true then text will be centered inside window
    NoAutoClose  : Boolean;     //if NoAutoClose is True then wnd will be always shown until user close it. Not recommended to set this param to True.
    CloseTime    : Integer;
    pData        : Integer;
  end;

  { FadeMsgClosing }
  TFadeMsgClosing = class
  public
    FadeID       : DWord;        //0 - message style, 1 - information style, 2 - warning style
    Time         : Integer;     // 1 jednotka 500 ms.
  end;



  TfrmQIPPlugin = class(TForm)
    tmrStep: TTimer;
    tmrStart: TTimer;
    tmrUpdate: TTimer;
    pmContactMenu: TPopupMenu;
    miContactMenu_Open: TMenuItem;
    miContactMenu_OpenOnly: TMenuItem;
    tmrUpdaterTimeout: TTimer;
    TrayIcon1: TTrayIcon;
    N1: TMenuItem;
    miContactMenu_Refresh: TMenuItem;
    miContactMenu_ContactDetails: TMenuItem;
    miContactMenu_Edit: TMenuItem;
    N2: TMenuItem;
    miContactMenu_AddFeed: TMenuItem;
    miContactMenu_Rename: TMenuItem;
    miContactMenu_Remove: TMenuItem;
    miContactMenu_MoveTo: TMenuItem;
    N3: TMenuItem;
    miContactMenu_Options: TMenuItem;
    ilToolbar: TImageList;
    miContactMenu_MoveToGroup: TMenuItem;
    miContactMenu_AddEmail: TMenuItem;
    miContactMenu_Status: TMenuItem;
    miContactMenu_Status_Online: TMenuItem;
    miContactMenu_Status_Offline: TMenuItem;
    miContactMenu_ImportExport: TMenuItem;
    miContactMenu_ImportExport_Import: TMenuItem;
    miContactMenu_ImportExport_Export: TMenuItem;
    miContactMenu_Status_DND: TMenuItem;
    N4: TMenuItem;
    miContactMenu_FeedsDatabase: TMenuItem;
    miContactMenu_AddEmail_Gmail: TMenuItem;
    miContactMenu_AddEmail_Seznam: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure tmrStartTimer(Sender: TObject);
    procedure tmrStepTimer(Sender: TObject);
    procedure miContactMenu_OpenClick(Sender: TObject);
    procedure tmrUpdateTimer(Sender: TObject);
    procedure tmrUpdaterTimeoutTimer(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure TrayIcon1Animate(Sender: TObject);
    procedure miContactMenu_OptionsClick(Sender: TObject);
    procedure miContactMenu_AddFeedClick(Sender: TObject);
    procedure miContactMenu_EditClick(Sender: TObject);
    procedure miContactMenu_ContactDetailsClick(Sender: TObject);
    procedure miContactMenu_OpenOnlyClick(Sender: TObject);
    procedure miContactMenu_MoveToClick(Sender: TObject);
    procedure miContactMenu_RefreshClick(Sender: TObject);
    procedure miContactMenu_RemoveClick(Sender: TObject);
    procedure miContactMenu_Status_OnlineClick(Sender: TObject);
    procedure miContactMenu_Status_OfflineClick(Sender: TObject);
    procedure miContactMenu_ImportExport_ImportClick(Sender: TObject);
    procedure miContactMenu_ImportExport_ExportClick(Sender: TObject);
    procedure miContactMenu_Status_DNDClick(Sender: TObject);
    procedure miContactMenu_AddEmail_GmailClick(Sender: TObject);
    procedure miContactMenu_AddEmail_SeznamClick(Sender: TObject);
  private
    FPluginSvc : pIQIPPluginService;
    FDllHandle : Cardinal;
    FDllPath   : WideString;


    procedure WMHotKey(var msg:TWMHotKey);message WM_HOTKEY;

  public
    property PluginSvc : pIQIPPluginService read FPluginSvc write FPluginSvc;
    property DllHandle : Cardinal           read FDllHandle write FDllHandle;
    property DllPath   : WideString         read FDllPath   write FDllPath;


    procedure CreateControls;
    procedure FreeControls;

    procedure LoadPluginOptions;
    procedure SavePluginOptions;

    procedure ShowPluginOptions;

//    procedure SpellCheck(var PlugMsg: TPluginMessage);
//    procedure SpellPopup(var PlugMsg: TPluginMessage);
//    procedure XstatusChangedByUser(PlugMsg: TPluginMessage);
    procedure QipSoundChanged(PlugMsg: TPluginMessage);
//    procedure InstantMsgRcvd(var PlugMsg: TPluginMessage);
//    procedure InstantMsgSend(var PlugMsg: TPluginMessage);
//    procedure NewMessageFlashing(PlugMsg: TPluginMessage);
//    procedure NewMessageStopFlashing(PlugMsg: TPluginMessage);
//    procedure AddNeededBtns(PlugMsg: TPluginMessage);
//    procedure MsgBtnClicked(PlugMsg: TPluginMessage);
//    procedure SpecMsgRcvd(PlugMsg: TPluginMessage);
    procedure AntiBoss(HideForms: Boolean);
    procedure CurrentLanguage(LangName: WideString);
//    procedure StatusChanged(PlugMsg: TPluginMessage);
//    procedure ImRcvdSuccess(PlugMsg: TPluginMessage);
//    procedure ContactStatusRcvd(PlugMsg: TPluginMessage);
//    procedure ChatTabAction(PlugMsg: TPluginMessage);
//    procedure AddNeededChatBtns(PlugMsg: TPluginMessage);
//    procedure ChatBtnClicked(PlugMsg: TPluginMessage);
//    procedure ChatMsgRcvd(PlugMsg: TPluginMessage);
//    procedure ChatMsgSending(var PlugMsg: TPluginMessage);
    procedure DrawSpecContact(PlugMsg: TPluginMessage);
    procedure SpecContactDblClick(PlugMsg: TPluginMessage);
    procedure SpecContactRightClick(PlugMsg: TPluginMessage);
    procedure LeftClickOnFadeMsg(PlugMsg: TPluginMessage);
    procedure GetSpecContactHintSize(var PlugMsg: TPluginMessage);
    procedure DrawSpecContactHint(PlugMsg: TPluginMessage);

    function FadeMsg(FType: Byte; FIcon: HICON; FTitle: WideString; FText: WideString; FTextCenter: Boolean; FNoAutoClose: Boolean; pData: Integer) : DWORD;

    procedure AddFadeMsg( FadeType : Byte;
                          FadeIcon : HICON;
                          FadeTitle : WideString;
                          FadeText     : WideString;
                          TextCentered : Boolean;
                          NoAutoClose  : Boolean;
                          CloseTime    : Integer;
                          pData        : Integer
                        );

    procedure AddSpecContact(CntType: DWord; CntIndex: DWord; var UniqID: TSpecCntUniq; HeightCnt: Integer = 19);
    procedure RedrawSpecContact(UniqID: DWord);
    procedure RemoveSpecContact(var UniqID: DWord);

    function GetLang(ID: Word) : WideString;

    procedure ShowContactMenu(pX: Integer; pY: Integer; Uniq: TSpecCntUniq );

    procedure TrayIconShow(sText: WideString);
    procedure TrayIconClose;


    procedure InfiumClose(itype: Word);

  protected
    procedure CreateParams (var Params: TCreateParams); override;
  end;

var
  frmQIPPlugin: TfrmQIPPlugin;
  FadeMsgs        : TStringList;
  FadeMsgsClosing : TStringList;
  ContactMenuUniq : TSpecCntUniq;

  cthread_update: DWORD = 0;

implementation

uses General, BBCode, u_lang_ids, UpdaterUnit, uLNG, uColors, TextSearch,
     uFileFolder,  SQLiteFuncs, SQLiteTable3, Convs,  uImage, uOptions, u_qip_plugin,
     CommCtrl;

{$R *.dfm}

procedure TfrmQIPPlugin.CreateParams (var Params: TCreateParams);
begin
  inherited;
    with Params do begin
      ExStyle := (ExStyle or WS_EX_TOOLWINDOW or WS_EX_NOACTIVATE);
    end;
end;

procedure TfrmQIPPlugin.WMHotKey(var msg:TWMHotKey);
begin

  if msg.HotKey = 8701 then
    begin

      //////

    end;

(*
  if HotKeyWeatherEnabled = True then
    begin
      SeparateHotKey( HotKeyWeather, iMod, iKey );

      RegisterHotKey( FfrmHotKey.Handle, 8701, iMod, iKey );
    end;

    UnregisterHotKey(FfrmHotKey.Handle, 8701);

   //////////////////////////////////////////////////////////////////////////////////

var
    iMod, iKey: Word;
begin

  SeparateHotKey( HotKeyWeather, iMod, iKey );

  RegisterHotKey( FfrmHotKey.Handle, 8701, iMod, iKey );

  UnregisterHotKey(FfrmHotKey.Handle, 8701);

*)

//  showmessage( inttostr( msg.HotKey ));
{
  case msg.HotKey of
    600 : DelejNeco;
    701 : DelejNecoJineho;
  end;
}

(*        Form1.Visible := not Form1.Visible;
        Application.BringToFront;
        {Hide or Show This Form}
*)
end;

procedure TfrmQIPPlugin.FormCreate(Sender: TObject);
begin

  FadeMsgs := TStringList.Create;
  FadeMsgs.Clear;

  FadeMsgsClosing := TStringList.Create;
  FadeMsgsClosing.Clear;

  CL := TStringList.Create;
  CL.Clear;

  BookmarkWindow := TStringList.Create;
  BookmarkWindow.Clear;

  GlobalOptions := TStringList.Create;
  GlobalOptions.Clear;

  fontDefaultCLFont.Font := TFont.Create;

  UpdaterWebIndex := -1;

  UpdaterWeb  := TStringList.Create;
  UpdaterWeb.Clear;

  UpdaterWeb.Add('http://lmscze7.ic.cz/');
  UpdaterWeb.Add('http://lmscze7.wz.cz/');


  DTFormatDATETIME.DateSeparator   := '-';
  DTFormatDATETIME.TimeSeparator   := ':';
  DTFormatDATETIME.ShortDateFormat := 'YYYY-MM-DD';
  DTFormatDATETIME.ShortTimeFormat := 'HH:MM:SS';
  DTFormatDATETIME.LongDateFormat := 'YYYY-MM-DD''  ''HH:MM:SS';

end;


procedure TfrmQIPPlugin.CreateControls;
begin
  //

end;


procedure TfrmQIPPlugin.FreeControls;
begin

  try
    if Assigned(SQLdb) then
      SQLdb.Free;
  finally

  end;

  if WindowIsShow = True then
    FWindow.Close;
{
  try
    tmrStep.Enabled := False;
  finally

  end;

  try
    tmrUpdate.Enabled := False;
  finally

  end;
}
           ////// Free dodelat i pro FControls
  try
    if Assigned(FWindow) then FreeAndNil(FWindow);
  except

  end;

  try
    if Assigned(FAbout) then FreeAndNil(FAbout);
  except

  end;

  try
    if Assigned(FAddFeed) then FreeAndNil(FAddFeed);
  except

  end;

  try
    if Assigned(FContactDetails) then FreeAndNil(FContactDetails);
  except

  end;

  try
    if Assigned(FEditContact) then FreeAndNil(FEditContact);
  except

  end;

  try
    if Assigned(FEditContactNextGlobal) then FreeAndNil(FEditContactNextGlobal);
  except

  end;

  try
    if Assigned(FOptions) then FreeAndNil(FOptions);
  except

  end;

  try
    if Assigned(FImport) then FreeAndNil(FImport);
  except

  end;

  try
    if Assigned(FExport) then FreeAndNil(FExport);
  except

  end;


  try
    if Assigned(FUpdater) then FreeAndNil(FUpdater);
  except

  end;




end;


procedure TfrmQIPPlugin.LoadPluginOptions;
var INI: Tinifile;
    iAcc : Integer;

    PlugMsg1: TPluginMessage;
begin

  PluginLanguage := 'English';
  SharedAccount  := True;


  INI := TiniFile.Create(ExtractFilePath(PluginDllPath) + 'RSSNews.ini');

  iAcc := INI.ReadInteger('Account', 'SharedAccount', 5 );

  if iAcc = 1 then
    SharedAccount := True
  else if iAcc = 0 then
    SharedAccount := False
  else
  begin
    OpenAccountSetting;

    INI.WriteInteger('Account', 'SharedAccount', BoolToInt(SharedAccount) );
  end;

  INI.Free;


  PlugMsg1.Msg       := PM_PLUGIN_GET_NAMES;
  PlugMsg1.DllHandle := DllHandle;

  FPluginSvc.OnPluginMessage(PlugMsg1);

  if Boolean(PlugMsg1.Result) then
  begin
    Account_DisplayName := PWideChar(PlugMsg1.WParam);
    Account_ProfileName := PWideChar(PlugMsg1.LParam);
  end;

  if SharedAccount = True then
  begin
    Account_FileName    := 'RSSNews'
  end
  else
  begin
    Account_FileName    := Account_ProfileName;
  end;


  // Profile path
  PlugMsg1.Msg       := PM_PLUGIN_GET_PROFILE_DIR;
  PlugMsg1.DllHandle := DllHandle;

  FPluginSvc.OnPluginMessage(PlugMsg1);

  if Boolean(PlugMsg1.Result) then
  begin
    ProfilePath := PWideChar(PlugMsg1.WParam) + PLUGIN_NAME + '\';
  end;

  if iAcc = 5 then   // first start
  begin
    INI := TiniFile.Create(ExtractFilePath(PluginDllPath) + Account_FileName + '.ini');
    INI.WriteString('Conf','Language', PluginLanguage );
    INI.Free;
  end;



  INI := TiniFile.Create(ExtractFilePath(PluginDllPath) + Account_FileName + '.ini');

  PluginLanguage := INI.ReadString('Conf', 'Language', 'English') ;

  CheckUpdates := IntToBool( INI.ReadInteger('Conf', 'CheckUpdates', 1) );
  CheckUpdatesInterval := INI.ReadInteger('Conf', 'CheckUpdatesInterval', 6);  

  fontDefaultCLFont.Font := TFont.Create;

  DefaultCLFont := INI.ReadString('Conf', 'DefaultCLFont', defDefaultCLFont);

  if DefaultCLFont = '' then
    DefaultCLFont := defDefaultCLFont;

  LoadFont(DefaultCLFont, fontDefaultCLFont);


  LoadOptions( INI.ReadString('Conf', 'GlobalOptions', ''), GlobalOptions);
  SetMissingOptions(GlobalOptions);
  INI.WriteString('Conf','GlobalOptions',  SaveOptions( GlobalOptions ) );


  CloseBookmarks := IntToBool( INI.ReadInteger('Conf', 'CloseBookmarks', 0 ) );

  RSSNewsStatus := INI.ReadInteger('Conf', 'Status', 1 );

  INI.Free;


  NextCheckVersion := Now + ( 5 * (1/(24*60*60) ) );


  tmrStart.Enabled := True;  
end;

procedure TfrmQIPPlugin.miContactMenu_OpenClick(Sender: TObject);
begin
  OpenBookmark( ContactMenuUniq.Index, -1, False);
end;

procedure TfrmQIPPlugin.miContactMenu_OpenOnlyClick(Sender: TObject);
var idx: Integer;
begin

  if Sender <> miContactMenu_OpenOnly then
  begin
    idx := (Sender as TMenuItem).Tag;

    OpenBookmark( ContactMenuUniq.Index, idx, False);
  end;


end;

procedure TfrmQIPPlugin.miContactMenu_AddFeedClick(Sender: TObject);
begin
  OpenAddFeed(-1, FEED_NORMAL, 0, '', '');
end;

procedure TfrmQIPPlugin.miContactMenu_ContactDetailsClick(Sender: TObject);
begin
  OpenContactDetails(ContactMenuUniq.Index, -1);
end;

procedure TfrmQIPPlugin.miContactMenu_EditClick(Sender: TObject);
begin
  OpenEditContact(ContactMenuUniq.Index, -1);
end;

procedure TfrmQIPPlugin.miContactMenu_ImportExport_ExportClick(Sender: TObject);
begin
  OpenImportExport(2);
end;

procedure TfrmQIPPlugin.miContactMenu_ImportExport_ImportClick(Sender: TObject);
begin
  OpenImportExport(1);
end;

procedure TfrmQIPPlugin.miContactMenu_MoveToClick(Sender: TObject);
var idx: Integer;
begin
  if Sender <> miContactMenu_MoveTo then
  begin
    idx := (Sender as TMenuItem).Tag;

    showmessage('nelze ' + inttostr(idx) );
  end;

end;

procedure TfrmQIPPlugin.miContactMenu_OptionsClick(Sender: TObject);
begin
  OpenOptions;
end;

procedure TfrmQIPPlugin.miContactMenu_RefreshClick(Sender: TObject);
var i: Integer;
begin

  i:=0;
  while ( i<= TCL(CL.Objects[ContactMenuUniq.Index]).Feed.Count - 1 ) do
  begin
    TFeed(TCL(CL.Objects[ContactMenuUniq.Index]).Feed.Objects[i]).NextUpdate := Now;

    Inc(i);
  end;

end;

function Repl1(sText: WideString; sStation: WideString): WideString;
begin
  Result := StringReplace(sText, '%FEED%', sStation, [rfReplaceAll]);
end;

procedure TfrmQIPPlugin.miContactMenu_RemoveClick(Sender: TObject);
var sSQL: WideString;
    i: Integer;
begin

  if MessageBoxW(0, PWideChar( Repl1 ( LNG('MESSAGE BOX','FeedRemove', 'Do you really want to remove feed "%FEED%" from list?' ) , TCL(CL.Objects[ContactMenuUniq.Index]).Name ) ) , 'RSS News', MB_YESNO + MB_ICONQUESTION) = IDYES then
  begin
    if WindowIsShow = True then
      FWindow.Close;

    BookmarkWindow.Clear;

    sSQL := 'DELETE FROM RSS WHERE CLID='+IntToStr(TCL(CL.Objects[ContactMenuUniq.Index]).ID)+';';
    ExecSQLUTF8(sSQL);

    i:=0;
    while ( i<= TCL(CL.Objects[ContactMenuUniq.Index]).Feed.Count - 1 ) do
    begin
      Application.ProcessMessages;

      sSQL := 'DELETE FROM Data WHERE RSSID='+IntToStr(TFeed(TCL(CL.Objects[ContactMenuUniq.Index]).Feed.Objects[i]).ID)+';';
      ExecSQLUTF8(sSQL);

      Inc(i);
    end;

    sSQL := 'DELETE FROM CL WHERE ID='+IntToStr(TCL(CL.Objects[ContactMenuUniq.Index]).ID)+';';
    ExecSQLUTF8(sSQL);

    QIPPlugin.RemoveSpecContact(TCL(CL.Objects[ContactMenuUniq.Index]).SpecCntUniq.UniqID);
    CL.Delete(ContactMenuUniq.Index);

  end;

end;

procedure TfrmQIPPlugin.miContactMenu_Status_DNDClick(Sender: TObject);
var i: Integer;
    INI: TIniFile;
begin
  RSSNewsStatus := 2;

  INI := TiniFile.Create(ExtractFilePath(PluginDllPath) + Account_FileName + '.ini');
  INI.WriteInteger('Conf', 'Status', RSSNewsStatus );
  INI.Free;

  i:=0;
  while ( i<= CL.Count - 1 ) do
  begin
    Application.ProcessMessages;

    RedrawSpecContact(TCL(CL.Objects[i]).SpecCntUniq.UniqID);

    Inc(i);
  end;

end;

procedure TfrmQIPPlugin.miContactMenu_Status_OfflineClick(Sender: TObject);
var i: Integer;
    INI: TIniFile;
begin
  RSSNewsStatus := 0;

  INI := TiniFile.Create(ExtractFilePath(PluginDllPath) + Account_FileName + '.ini');
  INI.WriteInteger('Conf', 'Status', RSSNewsStatus );
  INI.Free;

  i:=0;
  while ( i<= CL.Count - 1 ) do
  begin
    Application.ProcessMessages;

    RedrawSpecContact(TCL(CL.Objects[i]).SpecCntUniq.UniqID);

    Inc(i);
  end;
end;

procedure TfrmQIPPlugin.miContactMenu_Status_OnlineClick(Sender: TObject);
var i: Integer;
    INI: TIniFile;
begin
  RSSNewsStatus := 1;

  INI := TiniFile.Create(ExtractFilePath(PluginDllPath) + Account_FileName + '.ini');
  INI.WriteInteger('Conf', 'Status', RSSNewsStatus );
  INI.Free;

  i:=0;
  while ( i<= CL.Count - 1 ) do
  begin
    Application.ProcessMessages;

    RedrawSpecContact(TCL(CL.Objects[i]).SpecCntUniq.UniqID);

    Inc(i);
  end;

end;

procedure TfrmQIPPlugin.SavePluginOptions;
begin
  //
end;

procedure TfrmQIPPlugin.ShowPluginOptions;
begin
  OpenOptions;
end;

procedure TfrmQIPPlugin.tmrStartTimer(Sender: TObject);
var TableColumns : TStringList;
    hLibraryPics    : THandle;
    SQLtb     : TSQLiteTable;
    hIndex    : Integer;
    i,ii         : Int64;
//    sSQL : WideString;
//    DBFound : Boolean;

    PlugMsg1 : TPluginMessage;
    QipColors : pQipColors;

begin
  tmrStart.Enabled := False;

  TableColumns := TStringList.Create;
  TableColumns.Clear;



  SQLdbPath := ExtractFilePath(PluginDllPath) + Account_FileName + '.db';

//  DBfound := FileExists(SQLdbPath);

  try
    SQLdb := TSQLiteDatabase.Create(SQLdbPath, ExtractFilePath(PluginDllPath) );
  except
    ShowMessage('Chyba v otevøení databáze!');
  end;


//NOT NULL default ''

  TableColumns := TStringList.Create;
  TableColumns.Clear;
  AddColumnSL('ID',             'INTEGER PRIMARY KEY AUTOINCREMENT',TableColumns);
  AddColumnSL('CLID',           'INTEGER',TableColumns);
  AddColumnSL('State',          'INTEGER',TableColumns);
  AddColumnSL('Pos',            'INTEGER',TableColumns);
  AddColumnSL('Style',          'INTEGER',TableColumns);
  AddColumnSL('Name',           'TEXT',TableColumns);
  AddColumnSL('Topic',          'TEXT',TableColumns);
  AddColumnSL('URL',            'TEXT',TableColumns);
  AddColumnSL('LoginName',      'TEXT',TableColumns);
  AddColumnSL('LoginPassword',  'TEXT',TableColumns);
  AddColumnSL('Options',        'TEXT',TableColumns);
  AddColumnSL('LastUpdate',     'DATETIME',TableColumns);
  AddColumnSL('NextUpdate',     'DATETIME',TableColumns);
  AddColumnSL('Encoder',        'TEXT',TableColumns);
  AddColumnSL('EncoderVer',     'TEXT',TableColumns);
  AddColumnSL('CodePage',       'TEXT',TableColumns);
  AddColumnSL('title',          'TEXT',TableColumns);
  AddColumnSL('link',           'TEXT',TableColumns);
  AddColumnSL('description',    'TEXT',TableColumns);
  AddColumnSL('icon',           'TEXT',TableColumns);
  AddColumnSL('image',          'TEXT',TableColumns);
  AddColumnSL('language',       'TEXT',TableColumns);
  AddColumnSL('copyright',      'TEXT',TableColumns);
  AddColumnSL('managingEditor', 'TEXT',TableColumns);
  AddColumnSL('webMaster',      'TEXT',TableColumns);
  AddColumnSL('pubDate',        'DATETIME',TableColumns);
  AddColumnSL('lastBuildDate',  'DATETIME',TableColumns);
  AddColumnSL('category',       'TEXT',TableColumns);
  AddColumnSL('generator',      'TEXT',TableColumns);
  AddColumnSL('docs',           'TEXT',TableColumns);
  AddColumnSL('ttl',            'TEXT',TableColumns);
  AddColumnSL('rating',         'TEXT',TableColumns);
  AddColumnSL('textInput',      'TEXT',TableColumns);
  AddColumnSL('skipHours',      'TEXT',TableColumns);
  AddColumnSL('skipDays',       'TEXT',TableColumns);
  CheckTable('RSS',TableColumns);

  TableColumns.Clear;
  AddColumnSL('ID',             'INTEGER PRIMARY KEY AUTOINCREMENT',TableColumns);
  AddColumnSL('State',          'INTEGER',TableColumns);
  AddColumnSL('Pos',            'INTEGER',TableColumns);
  AddColumnSL('Group',          'TEXT',TableColumns);
  AddColumnSL('Name',           'TEXT',TableColumns);
  AddColumnSL('Topic',          'TEXT',TableColumns);
  AddColumnSL('Font',           'TEXT',TableColumns);
  AddColumnSL('Options',        'TEXT',TableColumns);
  CheckTable('CL',TableColumns);

  TableColumns.Clear;
  AddColumnSL('ID',             'INTEGER PRIMARY KEY AUTOINCREMENT',TableColumns);
  AddColumnSL('RSSID',          'INTEGER',TableColumns);
  AddColumnSL('Archive',        'INTEGER',TableColumns);
  AddColumnSL('State',          'INTEGER',TableColumns);
  AddColumnSL('title',          'TEXT',TableColumns);
  AddColumnSL('link',           'TEXT',TableColumns);
  AddColumnSL('description',    'TEXT',TableColumns);
  AddColumnSL('author',         'TEXT',TableColumns);
  AddColumnSL('category',       'TEXT',TableColumns);
  AddColumnSL('comments',       'TEXT',TableColumns);
  AddColumnSL('enclosure',      'TEXT',TableColumns);
  AddColumnSL('guid',           'TEXT',TableColumns);
  AddColumnSL('pubDate',        'DATETIME',TableColumns);
  AddColumnSL('source',         'TEXT',TableColumns);
  AddColumnSL('summary',        'TEXT',TableColumns);
  CheckTable('Data',TableColumns);

  TableColumns.Free;


 // memo1.Lines.LoadFromFile('C:\QI\QIP Infium - RSS News 0.3\Plugins\RSSNews\x.txt');

//  xxxxxxxxxxxxx := memo1.Text;

{
  if DBfound=false then
  begin
    SQLdb.BeginTransaction;

    sSQL := 'INSERT INTO CL (Pos, Name) VALUES (3,"qipim.cz");';
    ExecSQLUTF8(sSQL);

    sSQL := 'INSERT INTO CL (Pos, Name) VALUES (2,"Živì");';
    ExecSQLUTF8(sSQL);

    sSQL := 'INSERT INTO CL (Pos, Name) VALUES (1,"iDNES");';
    ExecSQLUTF8(sSQL);

    sSQL := 'INSERT INTO CL (Pos, Name) VALUES (4,"F1sports");';
    ExecSQLUTF8(sSQL);

    sSQL := 'INSERT INTO CL (Pos, Name) VALUES (5,"Ferrari");';
    ExecSQLUTF8(sSQL);

    sSQL := 'INSERT INTO CL (Pos, Name) VALUES (6,"Evropa 2 - Podcast");';
    ExecSQLUTF8(sSQL);

    sSQL := 'INSERT INTO CL (Pos, Name) VALUES (7,"super.cz");';
    ExecSQLUTF8(sSQL);

    sSQL := 'INSERT INTO CL (Pos, Name) VALUES (8,"aktualne.cz");';
    ExecSQLUTF8(sSQL);

    sSQL := 'INSERT INTO RSS(CLID, Pos, Name, URL) VALUES (1, 2, "qipim.cz - topics", "http://qipim.cz/generate_feed.php?content=topics&global=1");';
    ExecSQLUTF8(sSQL);

    sSQL := 'INSERT INTO RSS(CLID, Pos, Name, URL) VALUES (1, 1, "qipim.cz - posts", "http://qipim.cz/generate_feed.php?content=posts&global=1");';
    ExecSQLUTF8(sSQL);

    sSQL := 'INSERT INTO RSS(CLID, Pos, Name, URL) VALUES (2, 1, "Živì", "http://www.zive.cz/rss/sc-47/default.aspx?rss=1");';
    ExecSQLUTF8(sSQL);

    sSQL := 'INSERT INTO RSS(CLID, Pos, Name, URL) VALUES (3, 1, "Zprávy iDNES", "http://servis.idnes.cz/rss.asp?c=zpravodaj");';
    ExecSQLUTF8(sSQL);

    sSQL := 'INSERT INTO RSS(CLID, Pos, Name, URL) VALUES (3, 2, "Ekonomika iDNES.cz", "http://servis.idnes.cz/rss.asp?c=ekonomikah");';
    ExecSQLUTF8(sSQL);

    sSQL := 'INSERT INTO RSS(CLID, Pos, Name, URL) VALUES (4, 1, "F1sports - pøehled èlánkù", "http://f1sports.cz/rss.php");';
    ExecSQLUTF8(sSQL);

    sSQL := 'INSERT INTO RSS(CLID, Pos, Name, URL) VALUES (4, 2, "F1sports", "http://f1sports.cz/rss.php?kat=1");';
    ExecSQLUTF8(sSQL);

    sSQL := 'INSERT INTO RSS(CLID, Pos, Name, URL) VALUES (4, 3, "MotoGP", "http://f1sports.cz/rss.php?kat=3");';
    ExecSQLUTF8(sSQL);

    sSQL := 'INSERT INTO RSS(CLID, Pos, Name, URL) VALUES (5, 1, "Ferrari", "http://www.ferrariworld.com/rss/racing_en.xml");';
    ExecSQLUTF8(sSQL);

    sSQL := 'INSERT INTO RSS(CLID, Pos, Name, URL) VALUES (6, 1, "Evropa 2 - Podcast", "http://www.evropa2.cz/cs/extra/podcasting/rss_11.xml");';
    ExecSQLUTF8(sSQL);


    sSQL := 'INSERT INTO RSS(CLID, Pos, Name, URL) VALUES (7, 1, "super.cz", "http://www.super.cz/rss.xml");';
    ExecSQLUTF8(sSQL);

    sSQL := 'INSERT INTO RSS(CLID, Pos, Name, URL) VALUES (8, 1, "aktuane.cz - prehled", "http://aktualne.centrum.cz/export/rss-hp.phtml");';
    ExecSQLUTF8(sSQL);

    sSQL := 'INSERT INTO RSS(CLID, Pos, Name, URL) VALUES (8, 2, "aktuane.cz - czechnews", "http://aktualne.centrum.cz/export/rss-czechnews.phtml");';
    ExecSQLUTF8(sSQL);

    sSQL := 'INSERT INTO RSS(CLID, Pos, Name, URL) VALUES (8, 3, "aktuane.cz - domaci", "http://aktualne.centrum.cz/export/rss-domaci.phtml");';
    ExecSQLUTF8(sSQL);

    SQLdb.Commit;
  end;
}

  hLibraryPics := LoadLibrary(PChar(ExtractFilePath(PluginDllPath) + 'pics.dll'));

  if hLibraryPics=0 then
  begin
    ShowMessage( 'Nelze naèíst knihovnu pics.dll.' );
    Exit;
  end;

  PluginSkin.PluginIconBig       := LoadImageFromResource(10, hLibraryPics);

  PluginSkin.PluginIcon.Image    := LoadImageFromResource(11, hLibraryPics);
  PluginSkin.PluginIcon.Icon     := LoadImageAsIconFromResource(11, hLibraryPics);

  PluginSkin.RSS1.Image       := LoadImageFromResource(12, hLibraryPics);
  PluginSkin.RSS1.Icon        := LoadImageAsIconFromResource(12, hLibraryPics);

  PluginSkin.RSS2.Image       := LoadImageFromResource(13, hLibraryPics);
  PluginSkin.RSS2.Icon        := LoadImageAsIconFromResource(13, hLibraryPics);

  PluginSkin.RSS3.Image       := LoadImageFromResource(14, hLibraryPics);
  PluginSkin.RSS3.Icon        := LoadImageAsIconFromResource(14, hLibraryPics);

  PluginSkin.RSS4.Image       := LoadImageFromResource(15, hLibraryPics);
  PluginSkin.RSS4.Icon        := LoadImageAsIconFromResource(15, hLibraryPics);

  PluginSkin.RSS5.Image       := LoadImageFromResource(16, hLibraryPics);
  PluginSkin.RSS5.Icon        := LoadImageAsIconFromResource(16, hLibraryPics);

  PluginSkin.Msg.Image        := LoadImageFromResource(17, hLibraryPics);
  PluginSkin.Msg.Icon         := LoadImageAsIconFromResource(17, hLibraryPics);

  PluginSkin.Check.Image      := LoadImageFromResource(18, hLibraryPics);
  PluginSkin.Check.Icon       := LoadImageAsIconFromResource(18, hLibraryPics);

  PluginSkin.Error.Image      := LoadImageFromResource(19, hLibraryPics);
  PluginSkin.Error.Icon       := LoadImageAsIconFromResource(19, hLibraryPics);

  PluginSkin.Refresh.Image    := LoadImageFromResource(20, hLibraryPics);
  PluginSkin.Refresh.Icon     := LoadImageAsIconFromResource(20, hLibraryPics);

  PluginSkin.Close.Image      := LoadImageFromResource(21, hLibraryPics);
  PluginSkin.Close.Icon       := LoadImageAsIconFromResource(21, hLibraryPics);

  PluginSkin.Details.Image    := LoadImageFromResource(22, hLibraryPics);
  PluginSkin.Details.Icon     := LoadImageAsIconFromResource(22, hLibraryPics);


  PluginSkin.Preview.Image    := LoadImageFromResource(23, hLibraryPics);
  PluginSkin.Preview.Icon     := LoadImageAsIconFromResource(23, hLibraryPics);

  PluginSkin.Edit.Image       := LoadImageFromResource(24, hLibraryPics);
  PluginSkin.Edit.Icon        := LoadImageAsIconFromResource(24, hLibraryPics);

  PluginSkin.AddContact.Image  := LoadImageFromResource(25, hLibraryPics);
  PluginSkin.AddContact.Icon   := LoadImageAsIconFromResource(25, hLibraryPics);

  PluginSkin.RenameContact.Image  := LoadImageFromResource(26, hLibraryPics);
  PluginSkin.RenameContact.Icon   := LoadImageAsIconFromResource(26, hLibraryPics);

  PluginSkin.RemoveContact.Image  := LoadImageFromResource(27, hLibraryPics);
  PluginSkin.RemoveContact.Icon   := LoadImageAsIconFromResource(27, hLibraryPics);

  PluginSkin.Options.Image  := LoadImageFromResource(28, hLibraryPics);
  PluginSkin.Options.Icon   := LoadImageAsIconFromResource(28, hLibraryPics);

  PluginSkin.Color.Image := LoadImageFromResource(29, hLibraryPics);
  PluginSkin.Color.Icon := LoadImageAsIconFromResource(29, hLibraryPics);

  PluginSkin.Font.Image  := LoadImageFromResource(30, hLibraryPics);
  PluginSkin.Font.Icon  := LoadImageAsIconFromResource(30, hLibraryPics);

  PluginSkin.ItemAdd  := LoadImageFromResource(31, hLibraryPics);
  PluginSkin.ItemRemove  := LoadImageFromResource(32, hLibraryPics);
  PluginSkin.ItemUp  := LoadImageFromResource(33, hLibraryPics);
  PluginSkin.ItemDown  := LoadImageFromResource(34, hLibraryPics);

  PluginSkin.Email.Image      := LoadImageFromResource(35, hLibraryPics);
  PluginSkin.Email.Icon       := LoadImageAsIconFromResource(35, hLibraryPics);

  PluginSkin.Enclosure.Image      := LoadImageFromResource(36, hLibraryPics);
  PluginSkin.Enclosure.Icon      := LoadImageAsIconFromResource(36, hLibraryPics);

  PluginSkin.Remove.Image      := LoadImageFromResource(37, hLibraryPics);
  PluginSkin.Remove.Icon      := LoadImageAsIconFromResource(37, hLibraryPics);

  PluginSkin.RSSImportExport.Image      := LoadImageFromResource(38, hLibraryPics);
  PluginSkin.RSSImportExport.Icon      := LoadImageAsIconFromResource(38, hLibraryPics);

  PluginSkin.RSSImport.Image      := LoadImageFromResource(39, hLibraryPics);
  PluginSkin.RSSImport.Icon      := LoadImageAsIconFromResource(39, hLibraryPics);

  PluginSkin.RSSExport.Image      := LoadImageFromResource(40, hLibraryPics);
  PluginSkin.RSSExport.Icon      := LoadImageAsIconFromResource(40, hLibraryPics);


  PluginSkin.Online.Image      := LoadImageFromResource(41, hLibraryPics);
  PluginSkin.Online.Icon      := LoadImageAsIconFromResource(41, hLibraryPics);

  PluginSkin.Offline.Image      := LoadImageFromResource(42, hLibraryPics);
  PluginSkin.Offline.Icon      := LoadImageAsIconFromResource(42, hLibraryPics);

  PluginSkin.DND.Image      := LoadImageFromResource(43, hLibraryPics);
  PluginSkin.DND.Icon      := LoadImageAsIconFromResource(43, hLibraryPics);

  PluginSkin.FeedsDatabase.Image      := LoadImageFromResource(44, hLibraryPics);
  PluginSkin.FeedsDatabase.Icon      := LoadImageAsIconFromResource(44, hLibraryPics);

  PluginSkin.ImageFile.Image      := LoadImageFromResource(45, hLibraryPics);
  PluginSkin.ImageFile.Icon      := LoadImageAsIconFromResource(45, hLibraryPics);

  PluginSkin.ImageFolder.Image      := LoadImageFromResource(46, hLibraryPics);
  PluginSkin.ImageFolder.Icon      := LoadImageAsIconFromResource(46, hLibraryPics);

  PluginSkin.Back.Image      := LoadImageFromResource(47, hLibraryPics);
  PluginSkin.Back.Icon      := LoadImageAsIconFromResource(47, hLibraryPics);


  PluginSkin.Filter.Image      := LoadImageFromResource(48, hLibraryPics);
  PluginSkin.Filter.Icon      := LoadImageAsIconFromResource(48, hLibraryPics);

  PluginSkin.FilterEmpty.Image      := LoadImageFromResource(49, hLibraryPics);
  PluginSkin.FilterEmpty.Icon      := LoadImageAsIconFromResource(49, hLibraryPics);


  PluginSkin.Update.Image      := LoadImageFromResource(61, hLibraryPics);
  PluginSkin.Update.Icon      := LoadImageAsIconFromResource(61, hLibraryPics);


  PluginSkin.Gmail.Image  := LoadImageFromResource(101, hLibraryPics);
  PluginSkin.Gmail.Icon  := LoadImageAsIconFromResource(101, hLibraryPics);

  PluginSkin.Gmail1.Image  := LoadImageFromResource(102, hLibraryPics);
  PluginSkin.Gmail1.Icon  := LoadImageAsIconFromResource(102, hLibraryPics);

  PluginSkin.Gmail2.Image  := LoadImageFromResource(103, hLibraryPics);
  PluginSkin.Gmail2.Icon  := LoadImageAsIconFromResource(103, hLibraryPics);

  PluginSkin.Gmail3.Image  := LoadImageFromResource(104, hLibraryPics);
  PluginSkin.Gmail3.Icon  := LoadImageAsIconFromResource(104, hLibraryPics);

  PluginSkin.Gmail4.Image  := LoadImageFromResource(105, hLibraryPics);
  PluginSkin.Gmail4.Icon  := LoadImageAsIconFromResource(105, hLibraryPics);


  PluginSkin.Seznam.Image  := LoadImageFromResource(111, hLibraryPics);
  PluginSkin.Seznam.Icon  := LoadImageAsIconFromResource(111, hLibraryPics);

  PluginSkin.Seznam1.Image  := LoadImageFromResource(112, hLibraryPics);
  PluginSkin.Seznam1.Icon  := LoadImageAsIconFromResource(112, hLibraryPics);

  PluginSkin.Seznam2.Image  := LoadImageFromResource(113, hLibraryPics);
  PluginSkin.Seznam2.Icon  := LoadImageAsIconFromResource(113, hLibraryPics);

  PluginSkin.Seznam3.Image  := LoadImageFromResource(114, hLibraryPics);
  PluginSkin.Seznam3.Icon  := LoadImageAsIconFromResource(114, hLibraryPics);


  
  FreeLibrary(hLibraryPics);

  TrayIcon1.Icon := PluginSkin.PluginIcon.Icon;

  //32 bit support - transparent atd....
  ilToolbar.Handle := ImageList_Create(ilToolbar.Width, ilToolbar.Height, ILC_COLOR32 or ILC_MASK, ilToolbar.AllocBy, ilToolbar.AllocBy);

  ilToolbar.AddIcon(PluginSkin.Refresh.Icon);
  ilToolbar.AddIcon(PluginSkin.Close.Icon);
  ilToolbar.AddIcon(PluginSkin.Details.Icon);
  ilToolbar.AddIcon(PluginSkin.Preview.Icon);
  ilToolbar.AddIcon(PluginSkin.Edit.Icon);
  ilToolbar.AddIcon(PluginSkin.AddContact.Icon);
  ilToolbar.AddIcon(PluginSkin.RenameContact.Icon);
  ilToolbar.AddIcon(PluginSkin.RemoveContact.Icon);
  ilToolbar.AddIcon(PluginSkin.Options.Icon);
  ilToolbar.AddIcon(PluginSkin.Gmail.Icon);
  ilToolbar.AddIcon(PluginSkin.Online.Icon);
  ilToolbar.AddIcon(PluginSkin.Offline.Icon);
  ilToolbar.AddIcon(PluginSkin.RSSImportExport.Icon);
  ilToolbar.AddIcon(PluginSkin.RSSImport.Icon);
  ilToolbar.AddIcon(PluginSkin.RSSExport.Icon);
  ilToolbar.AddIcon(PluginSkin.DND.Icon);
  ilToolbar.AddIcon(PluginSkin.FeedsDatabase.Icon);
  ilToolbar.AddIcon(PluginSkin.Email.Icon);
  ilToolbar.AddIcon(PluginSkin.Seznam.Icon);

  CheckFolder( ExtractFilePath(PluginDllPath) + 'Logos', false );

  GetLangs;








  PlugMsg1.Msg       := PM_PLUGIN_GET_COLORS_FONT;
  PlugMsg1.DllHandle := DllHandle;

  FPluginSvc.OnPluginMessage(PlugMsg1);

  //get results
{  wFontName := PWideChar(PlugMsg1.WParam);
  iFontSize := PlugMsg1.LParam;}
  QipColors := pQipColors(PlugMsg1.NParam);

  QIP_Colors := QipColors^;


  // --- Load CL Items ---
  SQLtb := SQLdb.GetTable('SELECT * FROM CL ORDER BY Pos');
  if SQLtb.Count > 0 then
  begin
    while not SQLtb.EOF do
    begin
      Application.ProcessMessages;

      CL.Add('ITEM');
      hIndex:= CL.Count - 1;
      CL.Objects[hIndex] := TCL.Create;
      TCL(CL.Objects[hIndex]).ID    := SQLtb.FieldAsInteger(SQLtb.FieldIndex['ID']);
      TCL(CL.Objects[hIndex]).Group := SQLTextToText(SQLtb.FieldAsString(SQLtb.FieldIndex['Group']));
      TCL(CL.Objects[hIndex]).Name  := SQLTextToText(SQLtb.FieldAsString(SQLtb.FieldIndex['Name']));
      TCL(CL.Objects[hIndex]).Topic := SQLTextToText(SQLtb.FieldAsString(SQLtb.FieldIndex['Topic']));


      TCL(CL.Objects[hIndex]).Font.Font := TFont.Create;
      LoadFont( SQLTextToText(SQLtb.FieldAsString(SQLtb.FieldIndex['Font'])), TCL(CL.Objects[hIndex]).Font );

      TCL(CL.Objects[hIndex]).Options   := TStringList.Create;
      TCL(CL.Objects[hIndex]).Options.Clear;

      LoadOptions( SQLTextToText(SQLtb.FieldAsString(SQLtb.FieldIndex['Options'])), TCL(CL.Objects[hIndex]).Options);

      TCL(CL.Objects[hIndex]).Feed   := TStringList.Create;
      TCL(CL.Objects[hIndex]).Feed.Clear;
{------------------------------------------------------------------------------}
{      TCL(CL.Objects[hIndex]).CheckingUpdate := True;
      TCL(CL.Objects[hIndex]).Error := True;
      TCL(CL.Objects[hIndex]).NewItems := True;        }
{------------------------------------------------------------------------------}
      SQLtb.Next;
    end;
  end;
  SQLtb.Free;



  // --- Load RSS Items ---
  i:=0;
  while ( i<= CL.Count - 1 ) do
  begin
    SQLtb := SQLdb.GetTable('SELECT * FROM RSS WHERE CLID="' + IntToStr(TCL(CL.Objects[i]).ID) + '" ORDER BY Pos');
    if SQLtb.Count > 0 then
    begin
      while not SQLtb.EOF do
      begin
        Application.ProcessMessages;

        TCL(CL.Objects[i]).Feed.Add('FEED');
        hIndex:= TCL(CL.Objects[i]).Feed.Count - 1;
        TCL(CL.Objects[i]).Feed.Objects[hIndex] := TFeed.Create;
        TFeed(TCL(CL.Objects[i]).Feed.Objects[hIndex]).ID    := SQLtb.FieldAsInteger(SQLtb.FieldIndex['ID']);
        TFeed(TCL(CL.Objects[i]).Feed.Objects[hIndex]).Style := SQLtb.FieldAsInteger(SQLtb.FieldIndex['Style']);
        TFeed(TCL(CL.Objects[i]).Feed.Objects[hIndex]).Name  := SQLTextToText(SQLtb.FieldAsString(SQLtb.FieldIndex['Name']));
        TFeed(TCL(CL.Objects[i]).Feed.Objects[hIndex]).Topic := SQLTextToText(SQLtb.FieldAsString(SQLtb.FieldIndex['Topic']));
        TFeed(TCL(CL.Objects[i]).Feed.Objects[hIndex]).URL   := SQLTextToText(SQLtb.FieldAsString(SQLtb.FieldIndex['URL']));
        TFeed(TCL(CL.Objects[i]).Feed.Objects[hIndex]).LoginName := SQLTextToText(SQLtb.FieldAsString(SQLtb.FieldIndex['LoginName']));
        TFeed(TCL(CL.Objects[i]).Feed.Objects[hIndex]).LoginPassword := SQLTextToText(SQLtb.FieldAsString(SQLtb.FieldIndex['LoginPassword']));
        TFeed(TCL(CL.Objects[i]).Feed.Objects[hIndex]).NextUpdate := SQLDLToDT( SQLtb.FieldAsString(SQLtb.FieldIndex['NextUpdate']) );
        TFeed(TCL(CL.Objects[i]).Feed.Objects[hIndex]).LastUpdate := SQLDLToDT( SQLtb.FieldAsString(SQLtb.FieldIndex['LastUpdate']) );

        TFeed(TCL(CL.Objects[i]).Feed.Objects[hIndex]).Encoder    := SQLTextToText(SQLtb.FieldAsString(SQLtb.FieldIndex['Encoder']));
        TFeed(TCL(CL.Objects[i]).Feed.Objects[hIndex]).EncoderVer := SQLTextToText(SQLtb.FieldAsString(SQLtb.FieldIndex['EncoderVer']));
        TFeed(TCL(CL.Objects[i]).Feed.Objects[hIndex]).CodePage   := SQLTextToText(SQLtb.FieldAsString(SQLtb.FieldIndex['CodePage']));
        TFeed(TCL(CL.Objects[i]).Feed.Objects[hIndex]).image      := SQLTextToText(SQLtb.FieldAsString(SQLtb.FieldIndex['image']));

        TFeed(TCL(CL.Objects[i]).Feed.Objects[hIndex]).Logo.NormalImage := TImage.Create(nil);
        TFeed(TCL(CL.Objects[i]).Feed.Objects[hIndex]).Logo.SmallImage := TImage.Create(nil);
        TFeed(TCL(CL.Objects[i]).Feed.Objects[hIndex]).Logo.URL := TFeed(TCL(CL.Objects[i]).Feed.Objects[hIndex]).image;

        TFeed(TCL(CL.Objects[i]).Feed.Objects[hIndex]).Options   := TStringList.Create;
        TFeed(TCL(CL.Objects[i]).Feed.Objects[hIndex]).Options.Clear;

        LoadOptions(SQLTextToText(SQLtb.FieldAsString(SQLtb.FieldIndex['Options'])), TFeed(TCL(CL.Objects[i]).Feed.Objects[hIndex]).Options );

        SQLtb.Next;
      end;

    end;

    SQLtb.Free;

    Inc(i);
  end;



  i:=0;
  while ( i<= CL.Count - 1 ) do
  begin

    ii:=0;
    while ( ii<= TCL(CL.Objects[i]).Feed.Count - 1 ) do
    begin

      SQLtb := SQLdb.GetTable('SELECT * FROM Data WHERE RSSID=' + IntToStr( TFeed(TCL(CL.Objects[ i ]).Feed.Objects[ ii ]).ID )+' AND Archive=0');
      TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).MsgsCount.MsgCount := SQLtb.Count;
      SQLtb.Free;

      SQLtb := SQLdb.GetTable('SELECT * FROM Data WHERE RSSID=' + IntToStr( TFeed(TCL(CL.Objects[ i ]).Feed.Objects[ ii ]).ID )+' AND Archive=0 AND State=1');
      TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).MsgsCount.MsgUnreadCount := SQLtb.Count;
      SQLtb.Free;

      TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).MsgsCount.MsgNewCount := 0;

      Inc(ii);
    end;

    Inc(i);
  end;





  // --- Add spec contacts ---
  if CL.Count=0 then
  begin
   AddSpecContact(0,0, RSSNewsSpecCntUniq);
  end
  else
  begin
    i:=0;
    while ( i<= CL.Count - 1 ) do
    begin
      Application.ProcessMessages;

      AddSpecContact(1, i, TCL(CL.Objects[i]).SpecCntUniq);

      Inc(i);
    end;
  end;


  tmrUpdate.Enabled := True;
  tmrStep.Enabled := True;
end;

procedure TfrmQIPPlugin.tmrStepTimer(Sender: TObject);
var
  fmFadeMsg  : TFadeMsg;
  fmcFadeMsgClosing: TFadeMsgClosing;
  i : Integer;
  fid: DWord;
  PlugMsg1  : TPluginMessage;

begin

  Inc(NewItemsAnimate);
  if NewItemsAnimate = 3 then
    NewItemsAnimate := 0;

  i:=0;
  while ( i<= CL.Count - 1 ) do
  begin
    Application.ProcessMessages;

    if TCL(CL.Objects[i]).NewItems = True then
      RedrawSpecContact(TCL(CL.Objects[i]).SpecCntUniq.UniqID);

    Inc(i);
  end;


  if CL.Count=0 then
    if RSSNewsSpecCntUniq.UniqID = 0 then
      AddSpecContact(0,0, RSSNewsSpecCntUniq);
  if CL.Count>0 then
    if RSSNewsSpecCntUniq.UniqID <> 0 then
      RemoveSpecContact(RSSNewsSpecCntUniq.UniqID);

  if FadeMsgsClosing.Count > 0 then
  begin
    i:=0;
    while ( i<= FadeMsgsClosing.Count - 1 ) do
    begin
      Application.ProcessMessages;

      Dec(TFadeMsgClosing(FadeMsgsClosing.Objects[i]).Time);

      if TFadeMsgClosing(FadeMsgsClosing.Objects[i]).Time <= 0  then
      begin
        PlugMsg1.Msg    := PM_PLUGIN_FADE_CLOSE;
        PlugMsg1.WParam := TFadeMsgClosing(FadeMsgsClosing.Objects[i]).FadeID;

        PlugMsg1.DllHandle := DllHandle;
        FPluginSvc.OnPluginMessage(PlugMsg1);

        FadeMsgsClosing.Delete(i);
        Dec(i);
      end;

      Inc(i);
    end;





  end;

  if FadeMsgs.Count > 0 then
  begin
    fmFadeMsg := TFadeMsg(FadeMsgs.Objects[0]);
    FadeMsgs.Delete(0);

    if fmFadeMsg.CloseTime <> 0 then
      fmFadeMsg.NoAutoClose := True;

    fid := FadeMsg(fmFadeMsg.FadeType,
            fmFadeMsg.FadeIcon,
            fmFadeMsg.FadeTitle,
            fmFadeMsg.FadeText,
            fmFadeMsg.TextCentered,
            fmFadeMsg.NoAutoClose,
            fmFadeMsg.pData
            );

    if fmFadeMsg.CloseTime <> 0 then
    begin

      fmcFadeMsgClosing := TFadeMsgClosing.Create;
      fmcFadeMsgClosing.FadeID      := fid;
      fmcFadeMsgClosing.Time        := fmFadeMsg.CloseTime * 2;

      FadeMsgsClosing.Add('FADEMSG');
      FadeMsgsClosing.Objects[FadeMsgsClosing.Count - 1] := fmcFadeMsgClosing.Create;

    end;

    if fmFadeMsg.pData=255 then
      Updater_NewVersionFadeID := fid;
      
  end;

  // ---- Check new version ----
  CheckNewVersion(False);

end;



////////////////////////////////////////////////////////////////////////////////

procedure TfrmQIPPlugin.QipSoundChanged(PlugMsg: TPluginMessage);

begin
  if Boolean(PlugMsg.WParam) then
    // ON
  else
    // OFF
end;

{***********************************************************}
procedure TfrmQIPPlugin.AntiBoss(HideForms: Boolean);
begin
  if HideForms then
    /// AntiBoss: activated
  else
    /// AntiBoss: deactivated
end;

{***********************************************************}
procedure TfrmQIPPlugin.CurrentLanguage(LangName: WideString);
{var PlugMsg1: TPluginMessage;
    aFadeWnd: TFadeWndInfo;
    wStr    : WideString;  }
begin
  //  Current Language
  //  Showmessage(LangName);

end;


{***********************************************************}
procedure TfrmQIPPlugin.DrawSpecContact(PlugMsg: TPluginMessage);
var ContactID : DWord;
    Cnv       : TCanvas;
    R         : PRect;
    R1        : TRect;
    PlugMsg1 : TPluginMessage;
    QipColors : pQipColors;
    wFontName, wStr : WideString;
    iFontSize : Integer;
    spec : pSpecCntUniq;
    sMsg,sMsgCount,sMsgUnreadCount,sMsgNewCount : WideString;
    msgs : TMsgsCount;
    IdxOf: Integer;
    sValue: WideString;
begin

  //get unique contact id from msg
  ContactID   := PlugMsg.WParam;
  //ContactData := PlugMsg.LParam;
  spec := pSpecCntUniq(PlugMsg.LParam);

  //create temporary canvas to draw the contact
  Cnv       := TCanvas.Create;
  try

    //get canvas handle from msg
    Cnv.Handle := PlugMsg.NParam;

    //get drawing rectangle pointer from msg
    R := PRect(PlugMsg.Result);

    //this needed to draw text over contact list backgroud
    SetBkMode(Cnv.Handle, TRANSPARENT);


    PlugMsg1.Msg       := PM_PLUGIN_GET_COLORS_FONT;
    PlugMsg1.DllHandle := DllHandle;

    FPluginSvc.OnPluginMessage(PlugMsg1);

    //get results
    wFontName := PWideChar(PlugMsg1.WParam);
    iFontSize := PlugMsg1.LParam;
    QipColors := pQipColors(PlugMsg1.NParam);

    QIP_Colors := QipColors^;
{
    Cnv.Font.Name  := wFontName;
    Cnv.Font.Color := QipColors^.NotInList;
    Cnv.Font.Size  := iFontSize;
    Cnv.Font.Style := [];
}
    Cnv.Font.Name  := fontDefaultCLFont.Font.Name;
    Cnv.Font.Color := TextToColor( fontDefaultCLFont.FontColor, QIP_Colors );
    Cnv.Font.Size  := fontDefaultCLFont.Font.Size;
    Cnv.Font.Style := fontDefaultCLFont.Font.Style;


    if spec^.ItemType=0 then   // RSS News
    begin
      if RSSNewsStatus = 0 then
        Cnv.Draw(6, 1, PluginSkin.RSS3.Image.Picture.Graphic)
      else
        Cnv.Draw(6, 1, PluginSkin.RSS1.Image.Picture.Graphic);

      wStr := 'RSS News';
      R1 := Rect(R^.Left + 24, R^.Top + 1 , R^.Right, R^.Bottom);
      {DrawTextW(Cnv.Handle, PWideChar(wStr), Length(wStr), R1, DT_LEFT);}
      BBCodeDrawText(Cnv, wStr, R1, False, QipColors^)
    end
    else if spec^.ItemType=1 then   // CL
    begin


      IdxOf := TCL(CL.Objects[spec^.Index]).Options.IndexOf('OwnFont');
      if IdxOf <> -1 then
      begin
        if TSLOptions(TCL(CL.Objects[spec^.Index]).Options.Objects[IdxOf]).dataWideString = '1' then
        begin
          Cnv.Font.Name  := TCL(CL.Objects[spec^.Index]).Font.Font.Name;
          Cnv.Font.Color := TextToColor( TCL(CL.Objects[spec^.Index]).Font.FontColor, QIP_Colors);
          Cnv.Font.Size  := TCL(CL.Objects[spec^.Index]).Font.Font.Size;
          Cnv.Font.Style := TCL(CL.Objects[spec^.Index]).Font.Font.Style;
        end;
      end;

      CountMsgItems(spec^.Index, msgs);


      sValue := LoadOptionOwn(spec^.Index, -1, 'SpecCnt',-1);

      if StrPosE(sValue,'Show-MsgCount;',1,False) <> 0 then
      begin
        sMsgCount := inttostr(msgs.MsgCount);
      end;
      if StrPosE(sValue,'Show-MsgUnreadCount;',1,False) <> 0 then
      begin
        if msgs.MsgUnreadCount <> 0 then
        begin
          sMsgUnreadCount := '[b]'+inttostr(msgs.MsgUnreadCount) +'[/b]';
        end;
      end;
      if StrPosE(sValue,'Show-MsgNewCount;',1,False) <> 0 then
      begin
        if msgs.MsgNewCount <> 0 then
        begin
          sMsgNewCount := inttostr(msgs.MsgNewCount);
        end;
      end;


      if sMsgUnreadCount = '' then
      begin
        if sMsgCount<>'' then        
          sMsg := sMsg + '('+sMsgCount+')'
      end
      else
      begin
        if sMsgCount='' then
          sMsg := sMsg + '('+sMsgUnreadCount+')'
        else
          sMsg := sMsg + '('+sMsgUnreadCount+'/[color=offline]'+sMsgCount+'[/color])';
      end;

      if sMsgNewCount <> '' then
        sMsg := sMsg + ' [b]('+sMsgNewCount+')[/b]';

      wStr := TCL(CL.Objects[spec^.Index]).Name + ' ' + sMsg;



      if TCL(CL.Objects[spec^.Index]).Feed.Count > 0 then
      begin
        if RSSNewsStatus = 0 then
          Cnv.Draw(6, 1, PluginSkin.RSS3.Image.Picture.Graphic)
        else
        begin
          sValue := LoadOptionOwn(spec^.Index,0,'Icon',-1);

          if StrPosE(sValue,'Standard;',1,False) <> 0 then
          begin
            if msgs.MsgUnreadCount = 0 then
            begin
              if TFeed(TCL(CL.Objects[spec^.Index]).Feed.Objects[0]).Style = FEED_GMAIL then
                Cnv.Draw(6, 1, PluginSkin.Gmail2.Image.Picture.Graphic)
              else if TFeed(TCL(CL.Objects[spec^.Index]).Feed.Objects[0]).Style = FEED_RPC_SEZNAM then
                Cnv.Draw(6, 1, PluginSkin.Seznam2.Image.Picture.Graphic)
              else
                Cnv.Draw(6, 1, PluginSkin.RSS2.Image.Picture.Graphic)
            end
            else
            begin
              if TFeed(TCL(CL.Objects[spec^.Index]).Feed.Objects[0]).Style = FEED_GMAIL then
                Cnv.Draw(6, 1, PluginSkin.Gmail1.Image.Picture.Graphic)
              else if TFeed(TCL(CL.Objects[spec^.Index]).Feed.Objects[0]).Style = FEED_RPC_SEZNAM then
                Cnv.Draw(6, 1, PluginSkin.Seznam1.Image.Picture.Graphic)
              else
                Cnv.Draw(6, 1, PluginSkin.RSS1.Image.Picture.Graphic);
            end;
          end
          else
          begin
            if TFeed(TCL(CL.Objects[spec^.Index]).Feed.Objects[0]).Logo.ExistLogo = True then
              Cnv.Draw(6, 1, TFeed(TCL(CL.Objects[spec^.Index]).Feed.Objects[0]).Logo.SmallImage.Picture.Graphic)
            else
            begin
              if msgs.MsgUnreadCount = 0 then
              begin
                if TFeed(TCL(CL.Objects[spec^.Index]).Feed.Objects[0]).Style = FEED_GMAIL then
                  Cnv.Draw(6, 1, PluginSkin.Gmail2.Image.Picture.Graphic)
                else if TFeed(TCL(CL.Objects[spec^.Index]).Feed.Objects[0]).Style = FEED_RPC_SEZNAM then
                  Cnv.Draw(6, 1, PluginSkin.Seznam2.Image.Picture.Graphic)
                else
                  Cnv.Draw(6, 1, PluginSkin.RSS2.Image.Picture.Graphic)
              end
              else
              begin
                if TFeed(TCL(CL.Objects[spec^.Index]).Feed.Objects[0]).Style = FEED_GMAIL then
                  Cnv.Draw(6, 1, PluginSkin.Gmail1.Image.Picture.Graphic)
                else if TFeed(TCL(CL.Objects[spec^.Index]).Feed.Objects[0]).Style = FEED_RPC_SEZNAM then
                  Cnv.Draw(6, 1, PluginSkin.Seznam1.Image.Picture.Graphic)
                else
                  Cnv.Draw(6, 1, PluginSkin.RSS1.Image.Picture.Graphic);
              end;
            end;
          end;
        end;
      end
      else
      begin
        Cnv.Draw(6, 1, PluginSkin.RSS3.Image.Picture.Graphic);
      end;


      R1 := Rect(R^.Left + 24, R^.Top + 1 , R^.Right, R^.Bottom);
      {DrawTextW(Cnv.Handle, PWideChar(wStr), Length(wStr), R1, DT_LEFT);}
      BBCodeDrawText(Cnv, wStr, R1, False, QipColors^);

      if TCL(CL.Objects[spec^.Index]).CheckingUpdate = True then
        Cnv.Draw(R^.Right - R^.Left - 16, 1, PluginSkin.Check.Image.Picture.Graphic);

      if TCL(CL.Objects[spec^.Index]).Error = True then
        if TCL(CL.Objects[spec^.Index]).CheckingUpdate = True then
          Cnv.Draw(R^.Right - R^.Left - 16 - 16, 1, PluginSkin.Error.Image.Picture.Graphic)
        else
          Cnv.Draw(R^.Right - R^.Left - 16, 1, PluginSkin.Error.Image.Picture.Graphic);

      if TCL(CL.Objects[spec^.Index]).NewItems = True then
        if (NewItemsAnimate=0) or
           (NewItemsAnimate=1) then
          Cnv.Draw(6, 1, PluginSkin.Msg.Image.Picture.Graphic);

    end;


  finally
    //free canvas
    Cnv.Free;
  end;

end;

{***********************************************************}
procedure TfrmQIPPlugin.SpecContactDblClick(PlugMsg: TPluginMessage);
var ContactId : DWord;
    //Data      : Pointer;

    spec : pSpecCntUniq;
begin
  //get double clicked contact id from msg
  ContactId := PlugMsg.WParam;

  spec := pSpecCntUniq(PlugMsg.LParam);

  if spec^.ItemType = 1 then
  begin
    OpenBookmark(spec^.Index, -1, False);
  end;

  //get data pointer if added
  //Data      := Pointer(PlugMsg.LParam);

  //On this event you can do anything you want
  //..........

//  LogAdd('User double clicked or pressed <enter> on ContactId: ' + IntToStr(ContactId));

end;

{***********************************************************}
procedure TfrmQIPPlugin.SpecContactRightClick(PlugMsg: TPluginMessage);
var ContactId : DWord;
    //Data      : Pointer;
    Pt        : PPoint;

    spec : pSpecCntUniq;
begin
  //get right clicked contact id from msg
  ContactId := PlugMsg.WParam;

  spec := pSpecCntUniq(PlugMsg.LParam);


  //get data pointer if added
  //Data      := Pointer(PlugMsg.LParam);

  //get popup screen coordinates
  Pt        := PPoint(PlugMsg.NParam);





  ShowContactMenu(Pt.X, Pt.Y, spec^);


end;



{***********************************************************}
procedure TfrmQIPPlugin.LeftClickOnFadeMsg(PlugMsg: TPluginMessage);
var PlugMsg1 : TPluginMessage;
    FadeMsgID: integer;
    //spec : Integer;
begin

  FadeMsgID := PlugMsg.WParam;

  if Updater_NewVersionFadeID = FadeMsgID then
  begin
    PlugMsg1.Msg    := PM_PLUGIN_FADE_CLOSE;

    PlugMsg1.WParam := FadeMsgID;

    PlugMsg1.DllHandle := DllHandle;
    FPluginSvc.OnPluginMessage(PlugMsg1);

    OpenUpdater;
  end;

  //spec := PlugMsg.LParam;


//  LogAdd('User left clicked on your plugin FadeMsg ID = ' + IntToStr(FadeMsgID));



end;

{***********************************************************}
procedure TfrmQIPPlugin.GetSpecContactHintSize(var PlugMsg: TPluginMessage);
var ContactId : DWord;
    spec : pSpecCntUniq;

begin

  //get spec contact id from msg
  ContactId := PlugMsg.WParam;

  spec := pSpecCntUniq(PlugMsg.Result);

//showmessage(  IntToStr(spec^.Index)  + ' / ' + IntToStr(spec^.ItemType) );

  //get your Data pointer which you added when sent PM_PLUGIN_SPEC_ADD_CNT.
  //IMPORTANT!!! Do NOT make here any heavy loading actions, like cycles FOR, WHILE etc.
  //That's why you have to add Data pointer to PM_PLUGIN_SPEC_ADD_CNT, to get quick access to your data.
  //Data not used here in this example because plugin added only one contact
  //Data      := Pointer(PlugMsg.Result);

//  LogAdd('Core asking for hint size of your spec contact, id = ' + IntToStr(ContactId));

  if spec^.ItemType = 1 then
  begin


    //set contact hint Width
    PlugMsg.LParam := 200;

    //set contact hint Height
    PlugMsg.NParam := 35 * (TCL(CL.Objects[spec^.Index]).Feed.Count + 1);
  end;


end;

procedure TfrmQIPPlugin.miContactMenu_AddEmail_GmailClick(Sender: TObject);
begin
  OpenAddFeed(-1, FEED_GMAIL, 0, '', '');
end;

procedure TfrmQIPPlugin.miContactMenu_AddEmail_SeznamClick(Sender: TObject);
begin
  OpenAddFeed(-1, FEED_RPC_SEZNAM, 0, '', '');
end;

{***********************************************************}
procedure TfrmQIPPlugin.DrawSpecContactHint(PlugMsg: TPluginMessage);
var ContactId : DWord;
    spec : pSpecCntUniq;

    Cnv       : TCanvas;
    R         : PRect;
    wStr      : WideString;
    R1        : TRect;
    QipColors : pQipColors;
    wFontName : WideString;
    PlugMsg1  : TPluginMessage;
    iFontSize : Integer;

    i: Integer;
    msgs : TMsgsCount;
    sMsg,sMsgCount,sMsgUnreadCount,sMsgNewCount, sValue : WideString;
begin
  //get spec contact id from msg
  ContactId := PlugMsg.WParam;

  spec := pSpecCntUniq(PlugMsg.Result);

  //Notice: Core already drew hint background gradient and hint frame!


  Cnv       := TCanvas.Create;
  try

    Cnv.Handle := PlugMsg.LParam;
    R := PRect(PlugMsg.NParam);

    SetBkMode(Cnv.Handle, TRANSPARENT);


    PlugMsg1.Msg       := PM_PLUGIN_GET_COLORS_FONT;
    PlugMsg1.DllHandle := DllHandle;

    FPluginSvc.OnPluginMessage(PlugMsg1);


    wFontName := PWideChar(PlugMsg1.WParam);
    iFontSize := PlugMsg1.LParam;
    QipColors := pQipColors(PlugMsg1.NParam);

    Cnv.Font.Name  := wFontName;
    Cnv.Font.Color := QipColors^.FadeText;
    Cnv.Font.Size  := iFontSize;
    Cnv.Font.Style := [];

    if spec^.ItemType = 1 then
    begin

      CountMsgItems(spec^.Index, msgs);
{

  if chkSpecCntShowMsgCount.Checked = True then
    sValue := sValue + 'Show-MsgCount;';
  if chkSpecCntShowMsgUnreadCount.Checked  = True then
    sValue := sValue + 'Show-MsgUnreadCount;';
  if chkSpecCntShowMsgNewCount.Checked = True then
    sValue := sValue + 'Show-MsgNewCount;';
           }


{

  if chkSpecCntShowMsgCount.Checked = True then
    sValue := sValue + 'Show-MsgCount;';
  if chkSpecCntShowMsgUnreadCount.Checked  = True then
    sValue := sValue + 'Show-MsgUnreadCount;';
  if chkSpecCntShowMsgNewCount.Checked = True then
    sValue := sValue + 'Show-MsgNewCount;';
           }



    sMsgCount := inttostr(msgs.MsgCount);


    if msgs.MsgUnreadCount <> 0 then
    begin
      sMsgUnreadCount := '[b]'+inttostr(msgs.MsgUnreadCount) +'[/b]';
    end;


    if msgs.MsgNewCount <> 0 then
    begin
      sMsgNewCount := inttostr(msgs.MsgNewCount);
    end;





      sMsg := '';

      if sMsgUnreadCount = '' then
        sMsg := sMsg + '('+sMsgCount+')'
      else
        sMsg := sMsg + '('+sMsgUnreadCount+'/[color=offline]'+sMsgCount+'[/color])';

      if sMsgNewCount <> '' then
        sMsg := sMsg + ' [b]('+sMsgNewCount+')[/b]';


      wStr := '[size=10][b]'+TCL(CL.Objects[spec^.Index]).Name+'[/b]'+ ' ' + sMsg + '[/size]';

      R1 := Rect(R^.Left + 2, R^.Top + 2, R^.Right, R^.Bottom);

      BBCodeDrawText(Cnv,wStr,R1,True,QipColors^);

      i:=0;
      while ( i<= TCL(CL.Objects[ spec^.Index ]).Feed.Count - 1 ) do
      begin
        Cnv.Font.Name  := wFontName;
        Cnv.Font.Color := QipColors^.FadeText;
        Cnv.Font.Size  := iFontSize;
        Cnv.Font.Style := [];



        R1 := Rect(R^.Left + 2, (i+1)*35 + (R^.Top) + 2, R^.Right, R^.Bottom);

        msgs.MsgCount        := TFeed(TCL(CL.Objects[ spec^.Index ]).Feed.Objects[i]).MsgsCount.MsgCount;
        msgs.MsgUnreadCount  := TFeed(TCL(CL.Objects[ spec^.Index ]).Feed.Objects[i]).MsgsCount.MsgUnreadCount;
        msgs.MsgNewCount     := TFeed(TCL(CL.Objects[ spec^.Index ]).Feed.Objects[i]).MsgsCount.MsgNewCount;

        if msgs.MsgNewCount <> 0 then
        begin
          sMsgNewCount := inttostr(msgs.MsgNewCount);
        end;

        if msgs.MsgUnreadCount <> 0 then
        begin
          sMsgUnreadCount := '[b]'+inttostr(msgs.MsgUnreadCount) +'[/b]';
        end;

        sMsgCount := inttostr(msgs.MsgCount);

        sMsg := '';

        if sMsgUnreadCount = '' then
          sMsg := sMsg + '('+sMsgCount+')'
        else
          sMsg := sMsg + '('+sMsgUnreadCount+'/[color=offline]'+sMsgCount+'[/color])';

        if sMsgNewCount <> '' then
          sMsg := sMsg + ' [b]('+sMsgNewCount+')[/b]';

        wStr := '[b]'+TFeed(TCL(CL.Objects[ spec^.Index ]).Feed.Objects[i]).Name+'[/b]' + ' ' + sMsg +
{                '[br][i]'+TFeed(TCL(CL.Objects[ spec^.Index ]).Feed.Objects[i]).description+'[/i]'+}
                '[size=7][br]Poslední aktualizace: ' + FormatDateTime('dd.mm.yyyy hh:mm:ss',TFeed(TCL(CL.Objects[spec^.Index]).Feed.Objects[i]).LastUpdate)+
                '[br]Další aktualizace: '+FormatDateTime('dd.mm.yyyy hh:mm:ss',TFeed(TCL(CL.Objects[spec^.Index]).Feed.Objects[i]).NextUpdate)+'[/size]';


        BBCodeDrawText(Cnv,wStr,R1,True,QipColors^);

        Cnv.MoveTo(0, (i+1)*35 + (R^.Top) + 2);
        Cnv.LineTo(300,(i+1)*35 + (R^.Top) + 2);

        Inc(i);
      end;
    end;




  //text of your hint
//  wStr := 'Hint of my special contact';

 {
  i:=0;
  while ( i<= TCL(CL.Objects[ idxCL ]).Feed.Count - 1 ) do
  begin
    MsgsCount.MsgCount        := MsgsCount.MsgCount       + TFeed(TCL(CL.Objects[ idxCL ]).Feed.Objects[i]).MsgsCount.MsgCount;
    MsgsCount.MsgUnreadCount  := MsgsCount.MsgUnreadCount + TFeed(TCL(CL.Objects[ idxCL ]).Feed.Objects[i]).MsgsCount.MsgUnreadCount;
    MsgsCount.MsgNewCount     := MsgsCount.MsgNewCount    + TFeed(TCL(CL.Objects[ idxCL ]).Feed.Objects[i]).MsgsCount.MsgNewCount;

    Inc(i);
  end;           }

  //You can use Tahoma to draw your text, because its unicode font, or use what uses core


//  R1 := Rect(R^.Left+ 2, R^.Top + 2, R^.Right, R^.Bottom);

  //text drawing
  //IMPORTANT! If your text may have non ascii symbols, then use unicode drawing.
//  DrawTextW(Cnv.Handle, PWideChar(wStr), Length(wStr), R1, DT_SINGLELINE or DT_VCENTER or DT_CENTER);

  finally
  //free canvas
  Cnv.Free;
  end;

end;

////////////////////////////////////////////////////////////////////////////////

function TfrmQIPPlugin.FadeMsg(FType: Byte; FIcon: HICON; FTitle: WideString; FText: WideString; FTextCenter: Boolean; FNoAutoClose: Boolean; pData: Integer) : DWORD;
var PlugMsg1 : TPluginMessage;
    aFadeWnd: TFadeWndInfo;
begin

  //0 - message style, 1 - information style, 2 - warning style
  aFadeWnd.FadeType  := FType;//1;
  //its better to use ImageList of icons if you gonna show more than one icon everytime,
  //else you have to care about destroying your HICON after showing fade window, cauz core makes self copy of HICON
//  aFadeWnd.FadeIcon  := LoadImage(0, IDI_INFORMATION, IMAGE_ICON, 16, 16, LR_DEFAULTCOLOR or LR_SHARED);


  aFadeWnd.FadeIcon  := FIcon;

  aFadeWnd.FadeTitle := FTitle;
  aFadeWnd.FadeText  := FText;

  //if your text is too long, then you have to set this param to False
  aFadeWnd.TextCentered := FTextCenter;

  //it's recommended to set this parameter = False if your fade window is not very important
  aFadeWnd.NoAutoClose := FNoAutoClose;

  //send msg to qip core
  PlugMsg1.Msg       := PM_PLUGIN_FADE_MSG;
  PlugMsg1.WParam    := LongInt(@aFadeWnd);


  PlugMsg1.LParam    := 0; //vlastni Pointer

  PlugMsg1.DllHandle := DllHandle;
  FPluginSvc.OnPluginMessage(PlugMsg1);


  //if your window was successfuly shown then core returns Result = True (Result is unique id of fade msg),
  //else you should try later to show it again
  if Boolean(PlugMsg1.Result) then
    //LogAdd('Fading popup window successefuly shown: FadeMsg ID is '+ IntToStr(PlugMsg1.Result))
    Result := PlugMsg1.Result
  else
    //LogAdd('Fading popup window was NOT shown');
    Result := 0;


end;


procedure TfrmQIPPlugin.AddFadeMsg(
                                    FadeType     : Byte;        //0 - message style, 1 - information style, 2 - warning style
                                    FadeIcon     : HICON;       //icon in the top left corner of the window
                                    FadeTitle    : WideString;
                                    FadeText     : WideString;
                                    TextCentered : Boolean;     //if true then text will be centered inside window
                                    NoAutoClose  : Boolean;     //if NoAutoClose is True then wnd will be always shown until user close it. Not recommended to set this param to True.
                                    CloseTime    : Integer;
                                    pData        : Integer
                                  );
var fmFadeMsg  : TFadeMsg;
begin
  fmFadeMsg := TFadeMsg.Create;
  fmFadeMsg.FadeType      := FadeType ;
  fmFadeMsg.FadeIcon      := FadeIcon;
  fmFadeMsg.FadeTitle     := FadeTitle;
  fmFadeMsg.FadeText      := FadeText;
  fmFadeMsg.TextCentered  := TextCentered;
  fmFadeMsg.NoAutoClose   := NoAutoClose;
  fmFadeMsg.CloseTime     := CloseTime;
  fmFadeMsg.pData         := pData;

  FadeMsgs.Add('FADEMSG');
  FadeMsgs.Objects[FadeMsgs.Count - 1] := fmFadeMsg.Create;

end;

////////////////////////////////////////////////////////////////////////////////

procedure TfrmQIPPlugin.AddSpecContact(CntType: DWord; CntIndex: DWord; var UniqID: TSpecCntUniq; HeightCnt: Integer = 19);
var PlugMsg1 : TPluginMessage;
{    spec : TSpecCntUniq;
    specp: pSpecCntUniq;}
begin
  PlugMsg1.Msg    := PM_PLUGIN_SPEC_ADD_CNT;

  //set height of your contact here, min 8, max 100.
  PlugMsg1.WParam := HeightCnt;

  UniqID.ItemType := CntType;
  UniqID.Index    := CntIndex;

  //Pointer
  PlugMsg1.LParam := LongInt(@UniqID);

//  specp := pSpecCntInfo(PlugMsg1.LParam);
//  showmessage('');
//showmessage(  IntToStr(specp.ItemType) + ' / ' + IntToStr(specp.Index));

  PlugMsg1.DllHandle := DllHandle;
  FPluginSvc.OnPluginMessage(PlugMsg1);

  UniqID.UniqID := PlugMsg1.Result;

end;


procedure TfrmQIPPlugin.RedrawSpecContact(UniqID: DWord);
var PlugMsg1 : TPluginMessage;
begin
  if UniqID = 0 then Exit;

  PlugMsg1.Msg    := PM_PLUGIN_SPEC_REDRAW;

  //set contact id to redraw
  PlugMsg1.WParam := UniqID;

  //send msg to core
  PlugMsg1.DllHandle := DllHandle;
  FPluginSvc.OnPluginMessage(PlugMsg1);

end;

procedure TfrmQIPPlugin.RemoveSpecContact(var UniqID: DWord);
var PlugMsg1 : TPluginMessage;
begin

  if UniqID = 0 then Exit;

  PlugMsg1.Msg    := PM_PLUGIN_SPEC_DEL_CNT;

  PlugMsg1.WParam := UniqID;


  PlugMsg1.DllHandle := DllHandle;
  FPluginSvc.OnPluginMessage(PlugMsg1);

  if Boolean(PlugMsg1.Result) then
    UniqID := 0;

end;

function TfrmQIPPlugin.GetLang(ID: Word) : WideString;
var PlugMsg1 : TPluginMessage;

begin

    PlugMsg1.Msg       := PM_PLUGIN_GET_LANG_STR;
    PlugMsg1.WParam    := ID;
    PlugMsg1.DllHandle := DllHandle;
    {send string request}
    FPluginSvc.OnPluginMessage(PlugMsg1);
    {get string reply}
    Result := PWideChar(PlugMsg1.Result);

end;



procedure TfrmQIPPlugin.ShowContactMenu(pX: Integer; pY: Integer; Uniq: TSpecCntUniq );
var i: Integer;
    NewItem: TMenuItem;
begin

  ContactMenuUniq := Uniq;

  for i:=1 to miContactMenu_OpenOnly.Count do miContactMenu_OpenOnly.Delete(0);

  for i:=1 to miContactMenu_MoveTo.Count do miContactMenu_MoveTo.Delete(0);

  miContactMenu_Open.Caption := QIPPlugin.GetLang(LI_OPEN);
  miContactMenu_OpenOnly.Caption := QIPPlugin.GetLang(LI_OPEN)+'...';
  miContactMenu_Refresh.Caption := QIPPlugin.GetLang(LI_REFRESH);
  miContactMenu_ContactDetails.Caption := QIPPlugin.GetLang(LI_USER_DETAILS);
  miContactMenu_Edit.Caption    := LNG('MENU ContactMenu', 'Edit', 'Edit');
  miContactMenu_AddFeed.Caption := LNG('MENU ContactMenu', 'AddFeed', 'Add feed');
  miContactMenu_AddEmail.Caption := LNG('MENU ContactMenu', 'AddEmail', 'Add e-mail');
  miContactMenu_Rename.Caption := QIPPlugin.GetLang(LI_RENAME_CONTACT);
  miContactMenu_Remove.Caption := QIPPlugin.GetLang(LI_DELETE_CONTACT);
  miContactMenu_MoveTo.Caption := LNG('MENU ContactMenu', 'MoveTo', 'Move to');
  miContactMenu_MoveToGroup.Caption := QIPPlugin.GetLang(LI_MOVE_TO_GROUP);

  miContactMenu_Status.Caption := QIPPlugin.GetLang(LI_STATUS);
  miContactMenu_Status_Online.Caption := QIPPlugin.GetLang(LI_ST_ONLINE);
  miContactMenu_Status_DND.Caption := QIPPlugin.GetLang(LI_ST_DND);
  miContactMenu_Status_Offline.Caption := QIPPlugin.GetLang(LI_ST_OFFLINE);

  miContactMenu_ImportExport.Caption := LNG('MENU ContactMenu', 'ImportExport', 'Import/Export');
  miContactMenu_ImportExport_Import.Caption := LNG('MENU ContactMenu', 'Import', 'Import');
  miContactMenu_ImportExport_Export.Caption := LNG('MENU ContactMenu', 'Export', 'Export');

  miContactMenu_FeedsDatabase.Caption := LNG('MENU ContactMenu', 'OnlineFeedsDatabase', 'Online feeds database');

  miContactMenu_Options.Caption  := QIPPlugin.GetLang(LI_OPTIONS);


  if RSSNewsStatus = 0 then
  begin
    miContactMenu_Status.Caption := miContactMenu_Status.Caption + '  [' + miContactMenu_Status_Offline.Caption + ']';
    miContactMenu_Status.ImageIndex := 11
  end
  else if RSSNewsStatus = 1 then
  begin
    miContactMenu_Status.Caption := miContactMenu_Status.Caption + '  [' + miContactMenu_Status_Online.Caption + ']';
    miContactMenu_Status.ImageIndex := 10
  end
  else if RSSNewsStatus = 2 then
  begin
    miContactMenu_Status.Caption := miContactMenu_Status.Caption + '  [' + miContactMenu_Status_DND.Caption + ']';
    miContactMenu_Status.ImageIndex := 15;
  end;


  if ContactMenuUniq.ItemType = 0 then
  begin
    miContactMenu_Open.Visible := False;
    miContactMenu_OpenOnly.Visible := False;
    miContactMenu_Refresh.Visible := False;
    miContactMenu_ContactDetails.Visible := False;
    miContactMenu_Edit.Visible := False;
    miContactMenu_AddFeed.Visible := True;
    miContactMenu_Rename.Visible := False;
    miContactMenu_Remove.Visible := False;
    miContactMenu_MoveTo.Visible := False;
    miContactMenu_MoveToGroup.Visible := False;
    miContactMenu_Options.Visible := True;
  end
  else if ContactMenuUniq.ItemType = 1 then
  begin

    miContactMenu_Open.Visible := True;
    miContactMenu_OpenOnly.Visible := True;
    miContactMenu_Refresh.Visible := True;
    miContactMenu_ContactDetails.Visible := True;
    miContactMenu_Edit.Visible := True;
    miContactMenu_AddFeed.Visible := True;
    miContactMenu_Rename.Visible := False;//True;
    miContactMenu_Remove.Visible := True;
    miContactMenu_MoveTo.Visible := False;
    miContactMenu_MoveToGroup.Visible := False;
    miContactMenu_Options.Visible := True;


    //Open only
    if TCL(CL.Objects[ContactMenuUniq.Index]).Feed.Count = 1 then
    begin
      miContactMenu_OpenOnly.Visible := False;
    end else
    begin
      miContactMenu_OpenOnly.Visible := True;
      for i := 0 to TCL(CL.Objects[ContactMenuUniq.Index]).Feed.Count - 1 do
      begin
        NewItem := TMenuItem.Create(Self);
        NewItem.Caption := TFeed(TCL(CL.Objects[ContactMenuUniq.Index]).Feed.Objects[i]).Name;
        NewItem.Tag     := i;
        NewItem.OnClick := miContactMenu_OpenonlyClick;

        miContactMenu_OpenOnly.Add(NewItem);
      end;
    end;
{
    //Move to
    if CL.Count = 1 then
    begin
      miContactMenu_MoveTo.Visible := False;
    end else
    begin
      miContactMenu_MoveTo.Visible := True;
      for i := 0 to CL.Count - 1 do
      begin
        if i <> ContactMenuUniq.Index then
        begin
          NewItem := TMenuItem.Create(Self);
          NewItem.Caption := TCL(CL.Objects[i]).Name;
          NewItem.Tag     := i;
          NewItem.OnClick := miContactMenu_MoveToClick;

          miContactMenu_MoveTo.Add(NewItem);
        end;
      end;
    end;
}
  end;

  pmContactMenu.Popup(pX,pY);

end;




procedure TfrmQIPPlugin.tmrUpdaterTimeoutTimer(Sender: TObject);
begin
  cthread_update := 0;
end;

procedure TfrmQIPPlugin.tmrUpdateTimer(Sender: TObject);
var i,ii: Integer;
    ThreadId: Cardinal;
begin
  tmrUpdate.Enabled := False;

  if RSSNewsStatus = 0 then
    ///
  else
  begin
    i:=0;
    while ( i<= CL.Count - 1 ) do
    begin
      Application.ProcessMessages;

      {      RedrawSpecContact_Integer := i;
      RedrawSpecContact_Boolean := True;}
      //RedrawSpecContact(i);

      TCL(CL.Objects[i]).Error := False;

      ii:=0;
      while ( ii <= TCL(CL.Objects[i]).Feed.Count - 1 ) do
      begin
        Application.ProcessMessages;

        if TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).NextUpdate = -1 then
            //WORKING
        else if (TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).NextUpdate <= Now)
           or
           (TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).NextUpdate = 0) then
        begin

          if cthread_update = 0 then
          begin
            tmrUpdaterTimeout.Enabled := False;
            tmrUpdaterTimeout.Enabled := True;
            CheckRSS_CL   := i;
            CheckRSS_Feed := ii;
            cthread_update := BeginThread(nil, 0, @CheckRSS, nil, 0, ThreadId);
          end;

        end;

        Inc(ii);
      end;

      Inc(i);
    end;
  end;

  tmrUpdate.Enabled := True;
end;

procedure TfrmQIPPlugin.TrayIcon1Animate(Sender: TObject);
begin
  if TrayIcon1.Tag = 0 then
  begin
    TrayIcon1.Icon := PluginSkin.PluginIcon.Icon;
    TrayIcon1.Tag := 1;
  end
  else if TrayIcon1.Tag = 1 then
  begin
    TrayIcon1.Icon := PluginSkin.Msg.Icon;
    TrayIcon1.Tag := 0;
  end;
end;

procedure TfrmQIPPlugin.TrayIcon1Click(Sender: TObject);
var i, ii: Integer;
begin

  i:=0;
  while ( i<= CL.Count - 1 ) do
  begin
    Application.ProcessMessages;

    ii:=0;
    while ( ii <= TCL(CL.Objects[i]).Feed.Count - 1 ) do
    begin
      Application.ProcessMessages;

      if TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).NewItems = True then
        OpenBookmark(i, ii, True);

      Inc(ii);
    end;

    Inc(i);
  end;

  OpenWindow;

end;


procedure TfrmQIPPlugin.TrayIconShow(sText: WideString);
begin
  try
    QIPPlugin.TrayIcon1.Hint := sText;
    QIPPlugin.TrayIcon1.Visible := True;
  finally

  end;

end;

procedure TfrmQIPPlugin.TrayIconClose;
begin
  try
    QIPPlugin.TrayIcon1.Visible := False;
  finally

  end;
end;

(*

   {====== EXAMPLE of sending special plugin message =======}

   {wSpecMsgText := '<plugin_id=73825427835>Special plugin data goes here';
     OR
    wSpecMsgText := '(plugin_name=BestPlugin)Special plugin data goes here';
     OR
    wSpecMsgText := '(73825427835)Special plugin data goes here';
     OR }
    //Hint: if your special msg data contains binary data then its better to send Base64Encoded msg and decode it on receive.
    wSpecMsgText := '(221233)Special plugin data goes here';

    PlugMsg1.Msg       := PM_PLUGIN_SPEC_SEND;
    PlugMsg1.WParam    := iProtoDllHandle; //handle of protocol which maybe will send your special message, currently protocol handle can be get only from plugin buttons below avatar
    PlugMsg1.LParam    := LongInt(PWideChar(wAccName));
    PlugMsg1.NParam    := LongInt(PWideChar(wSpecMsgText));
    PlugMsg1.DllHandle := FPluginInfo.DllHandle;

    FPluginSvc.OnPluginMessage(PlugMsg1);

    if Boolean(PlugMsg1.Result) then
      LogAdd('Spec msg sent: ' + wSpecMsgText)
    else
      LogAdd('Spec msg NOT sent');
      {special msg can not be sent if:
      1. Protocol do not support special msgs yet
      2. Protocol is offline
      3. Contact is not in the user contact list
      4. Any other errors}
   {=========================================================}






    {===================================================}
    {example of how to get contact details}
    PlugMsg1.Msg    := PM_PLUGIN_DETAILS_GET;
    PlugMsg1.WParam := iProtoDllHandle;
    PlugMsg1.LParam := LongInt(PWideChar(wAccName));

    PlugMsg1.DllHandle := FPluginInfo.DllHandle;
    FPluginSvc.OnPluginMessage(PlugMsg1);

    //if details found then get details pointer and show them
    if Boolean(PlugMsg1.Result) then
    begin
      aContDetails := pContactDetails(PlugMsg1.NParam);

      LogAdd('Contact details: ' + #13#10 +
             'Acc name: ' + aContDetails^.AccountName + #13#10 +
             'Contact name: ' + aContDetails^.ContactName + #13#10 +
             'Nickname: ' + aContDetails^.NickName + #13#10 +
             'First name: ' + aContDetails^.FirstName + #13#10 +
             'Last name: ' + aContDetails^.LastName + #13#10 +
             'Home country: ' + aContDetails^.HomeCountry + #13#10 +
             'Last seen online: ' + DateTimeToStr(UnixToDateTime(aContDetails^.LastSeen)));
             {... etc ...}
    end;

*)

(*

  {============================================}
  {example of how to get language string from core}
  PlugMsg1.Msg       := PM_PLUGIN_GET_LANG_STR;

  {we need of "Author" string, actually needed string IDs you
   can see directly in file Langs/English.dll or Langs/Russian.dll.
   If you can't find needed string then you MUST NOT add strings to
   original qip language files, you have to use own language strings}
  PlugMsg1.WParam    := LI_AUTHOR;
  PlugMsg1.DllHandle := FPluginInfo.DllHandle;

  {send string request}
  FPluginSvc.OnPluginMessage(PlugMsg1);

  {get string reply}
  wStr := PWideChar(PlugMsg1.Result);

*)

(*

  {============================================}
  {example of how to get display and profile names}
  PlugMsg1.Msg       := PM_PLUGIN_GET_NAMES;
  PlugMsg1.DllHandle := FPluginInfo.DllHandle;

  FPluginSvc.OnPluginMessage(PlugMsg1);

  if Boolean(PlugMsg1.Result) then
  begin
    wStr := PWideChar(PlugMsg1.WParam);
    LogAdd('Display name: ' + wStr);

    wStr := PWideChar(PlugMsg1.LParam);
    LogAdd('Profile name: ' + wStr);
  end;

  {============================================}
  {example of how to get profile folder path to write any plugin files}
  PlugMsg1.Msg       := PM_PLUGIN_GET_PROFILE_DIR;
  PlugMsg1.DllHandle := FPluginInfo.DllHandle;

  FPluginSvc.OnPluginMessage(PlugMsg1);

  if Boolean(PlugMsg1.Result) then
  begin
    wStr := PWideChar(PlugMsg1.WParam);
    LogAdd('Profile folder path for plugin needs: ' + wStr);
  end;

*)

(*

  {===================================================}
  {example of how to ñlose your Fade Msg}
  PlugMsg1.Msg    := PM_PLUGIN_FADE_CLOSE;

  //set fade msg id to close
  PlugMsg1.WParam := FadeMsgID;

  //send msg to core
  PlugMsg1.DllHandle := FPluginInfo.DllHandle;
  FPluginSvc.OnPluginMessage(PlugMsg1);

  if Boolean(PlugMsg1.Result) then
    LogAdd('Fade msg was closed successfuly.')
  else
    LogAdd('Fade msg was not found and not closed.');
  {===================================================}

*)

procedure TfrmQIPPlugin.InfiumClose(itype: Word);
var PlugMsg1 : TPluginMessage;
begin
  // 0 - close; 1 - restart

  PlugMsg1.Msg    := PM_PLUGIN_INFIUM_CLOSE;
  PlugMsg1.WParam := itype;
  PlugMsg1.DllHandle := DllHandle;
  FPluginSvc.OnPluginMessage(PlugMsg1);
end;
end.
