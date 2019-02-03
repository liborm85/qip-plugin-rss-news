unit General;

interface

uses
  SysUtils, Classes, Dialogs, Graphics, Windows, Forms, ExtCtrls, Controls,
  fQIPPlugin, u_common, IniFiles, DownloadFile,
  Window, EditContact, AddFeed, ContactDetails, Options, About, uOptions,
  AccountSetting, Updater, ImportExport;

const downTimeout: DWORD = 3000;  //ms
      defDefaultCLFont: WideString = 'Name="Tahoma";Size="8";Color="NotInList";Style="";';

      TextNewMessages : WideString = 'Nové zprávy v: %FEEDNAME%';
      TextNewMessage  : WideString = 'Nová zpráva v: %FEEDNAME%\n%MSGDATETIME%\n%MSGTITLE%\n%MSGDESCRIPTION%';
      TextNewEmails   : WideString = 'Nové emaily v: %FEEDNAME%';
      TextNewEmail    : WideString = 'Nový email v: %FEEDNAME%\n%MSGDATETIME% - %MSGAUTHOR%\n%MSGTITLE%\n%MSGDESCRIPTION%';

  FEED_NORMAL             =   0;
  FEED_GMAIL              =   10;

  FEED_RPC_SEZNAM         =   1001;

  GMAIL_CHECKURL          =   'https://mail.google.com/mail/feed/atom';

type
  { Langs }
  TLangs = class
  public
    QIPID : DWORD;
    Name  : WideString;
    Trans : WideString;
  end;

  {MsgsCount}
  TMsgsCount = record
    MsgCount       : Int64;
    MsgNewCount    : Int64;
    MsgUnreadCount  : Int64;
  end;

  {XML Info}
  TXMLInfo = record
    Encoder       : WideString;
    EncoderVer    : WideString;
    CodePage      : WideString;
    Title         : WideString;
    Link          : WideString;
    Description   : WideString;
    Language      : WideString;
    copyright     : WideString;
    managingEditor: WideString;
    webMaster     : WideString;
    PubDate       : WideString;
    LastBuildDate : WideString;
    category      : WideString;
    generator     : WideString;
    docs          : WideString;
    ttl           : WideString;
    image         : WideString;
    rating        : WideString;
    textInput     : WideString;
    skipHours     : WideString;
    skipDays      : WideString;
  end;

  { Logo }
  TLogo = record
    ExistLogo         : Boolean;
    NormalImage       : TImage;
    SmallImage        : TImage;
    URL               : WideString;
  end;

  { Feed }
  TFeed = class
  public
    ID             : Integer;

    Style          : Integer;

    Name           : WideString;
    URL            : WideString;
    Topic          : WideString;

    LoginName      : WideString;
    LoginPassword  : WideString;

    Options        : TStringList;

    MsgsCount      : TMsgsCount;

    LastUpdate     : TDateTime;
    NextUpdate     : TDateTime;
    CheckingUpdate : Boolean;
    NewItems       : Boolean;
    NewItemsWasNotif: Boolean;
    Error          : Boolean;

    Encoder       : WideString;
    EncoderVer    : WideString;
    CodePage      : WideString;


    title          : WideString;
    description    : WideString;

    image          : WideString;
///    Icon
    Logo           : TLogo;
  end;




  { CL }
  TCL = class
  public
    ID             : Integer;
    SpecCntUniq    : TSpecCntUniq;
    Group          : WideString;
    Name           : WideString;
    Topic          : WideString;
    Options        : TStringList;
    Font           : TOwnFont;
    Feed           : TStringList;
    CheckingUpdate : Boolean;
    NewItems       : Boolean;
    NewItemsWasNotif: Boolean;
    Error          : Boolean;
    //NewItemsAnimate: Integer;

{    MsgCount       : Int64;
    MsgNewCount    : Int64;
    MsgUnreadCount : Int64;    }
  end;

  TImageIcon = record
    Image             : TImage;
    Icon              : TIcon;
  end;

  { PluginSkin }
  TPluginSkin = record
    PluginIconBig        : TImage;
    PluginIcon        : TImageIcon;
    RSS1              : TImageIcon;
    RSS2              : TImageIcon;
    RSS3              : TImageIcon;
    RSS4              : TImageIcon;
    RSS5              : TImageIcon;
    Msg               : TImageIcon;
    Check             : TImageIcon;
    Error             : TImageIcon;
    Refresh           : TImageIcon;
    Close             : TImageIcon;
    Details           : TImageIcon;
    Preview           : TImageIcon;
    Edit              : TImageIcon;
    AddContact        : TImageIcon;
    RenameContact     : TImageIcon;
    RemoveContact     : TImageIcon;
    Options           : TImageIcon;
    Color             : TImageIcon;
    Font              : TImageIcon;
    ItemAdd           : TImage;
    ItemRemove        : TImage;
    ItemUp            : TImage;
    ItemDown          : TImage;
    Email             : TImageIcon;
    Enclosure         : TImageIcon;
    Remove            : TImageIcon;
    RSSImportExport   : TImageIcon;
    RSSImport         : TImageIcon;
    RSSExport         : TImageIcon;

    Online            : TImageIcon;
    Offline           : TImageIcon;
    DND               : TImageIcon;

    FeedsDatabase     : TImageIcon;
    ImageFile         : TImageIcon;
    ImageFolder       : TImageIcon;
    Back              : TImageIcon;

    Filter            : TImageIcon;
    FilterEmpty       : TImageIcon;    

    Gmail             : TImageIcon;
    Gmail1            : TImageIcon;
    Gmail2            : TImageIcon;
    Gmail3            : TImageIcon;
    Gmail4            : TImageIcon;

    Seznam            : TImageIcon;
    Seznam1           : TImageIcon;
    Seznam2           : TImageIcon;
    Seznam3           : TImageIcon;

    Update             : TImageIcon;
  end;

  { Bookmark Window }
  TBookmarkWindow = class
  public
    CLPos          : Integer;
    RSSPos         : Integer;
    Data           : TStringList;
  end;

  procedure OpenAccountSetting;

  procedure OpenOptions;
  procedure OpenWindow;
  procedure OpenBookmark(CLPos: Integer; RSSPos: Integer; NoShowWindow: Boolean);
  procedure OpenEditContact(CLIndex: Integer; RSSIndex: Integer);
  procedure OpenEditContactNextGlobal;
  procedure OpenContactDetails(CLIndex: Integer; RSSIndex: Integer);
  procedure OpenAddFeed(CLIndex: Integer; Style : Integer; iType: Integer; sURL: WideString; sName: WideString);
  procedure OpenAbout;

  procedure CountMsgItems(idxCL: Integer; var MsgsCount : TMsgsCount);
  function CheckRSS: Integer;
  procedure GetLangs;

  procedure OpenImportExport(iType: Integer);


var
  QIPPlugin       : TfrmQIPPlugin;
  PluginDllPath   : WideString;
  PluginVersion   : WideString;
  PluginLanguage,
  QIPInfiumLanguage : WideString;

  ProfilePath : WideString;

  SharedAccount       : Boolean;
  Account_ProfileName : WideString;
  Account_DisplayName : WideString;
  Account_FileName    : WideString;

  RSSNewsStatus : Integer;

  PluginSkin : TPluginSkin;

  CL, BookmarkWindow, GlobalOptions  : TStringList;

  DefaultCLFont     : WideString;
  fontDefaultCLFont: TOwnFont;

  CloseBookmarks: Boolean;
  

  RSSNewsSpecCntUniq  : TSpecCntUniq;

  NewItemsAnimate : Integer;

  CheckRSS_CL, CheckRSS_Feed : Integer;
  EditContact_CLIndex, EditContact_RSSIndex: Integer;
  ContactDetails_CLIndex, ContactDetails_RSSIndex: Integer;
  AddFeed_CLIndex, AddFeed_Style, AddFeed_Type: Integer;
  AddFeed_URL, AddFeed_Name: WideString;

  ImportExport_Type : Integer;  

  FWindow : TfrmWindow;
  FEditContact : TfrmEditContact;
  FAddFeed : TfrmAddFeed;
  FContactDetails: TfrmContactDetails;
  FOptions: TfrmOptions;
  FAbout: TfrmAbout;
  FEditContactNextGlobal : TfrmEditContact;
  FAccountSetting : TfrmAccountSetting;
  FImport : TfrmImportExport;
  FExport : TfrmImportExport;


  WindowIsShow, EditContactIsShow, AddFeedIsShow, ContactDetailsIsShow,
  OptionsIsShow, AboutIsShow, EditContactNextGlobalIsShow, AccountSettingIsShow,
  ListFeedsIsShow, CreateFeedIsShow, ImportExportIsShow : Boolean;

  Info : TPositionInfo;

  EditContactNextGlobal_Global: Boolean;


  CreateFeed_Type : Integer;
  CreateFeed_Path : WideString;

  {má být pouze v AddFeed}
  NewFeetInfo: TXMLInfo;

  QIP_Colors : TQipColors;


  CheckUpdates: Boolean;
  NextCheckVersion : TDateTime;
  CheckUpdatesInterval: Integer;

  Langs: TStringList;




implementation

uses SQLiteFuncs, XMLProcess, Crypt, uSuperReplace, u_lang_ids,
 Convs, TextSearch,  uCheckRPC;



procedure OpenImportExport(iType: Integer);
begin
  if iType = 1 then       // Import
  begin
    if ImportExportIsShow = False then
    begin
      ImportExport_Type := iType;
      FImport := TfrmImportExport.Create(nil);
      FImport.Show;
    end;
  end
  else if iType = 2 then  // Export
  begin
    if ImportExportIsShow = False then
    begin
      ImportExport_Type := iType;
      FExport := TfrmImportExport.Create(nil);
      FExport.Show;
    end;
  end;
end;


procedure OpenAccountSetting;
begin

  if AccountSettingIsShow = False then
  begin
    FAccountSetting := TfrmAccountSetting.Create(nil);
    FAccountSetting.ShowModal;
  end;

end;

procedure OpenEditContactNextGlobal;
begin
  if EditContactNextGlobalIsShow = False then
  begin
    EditContactNextGlobal_Global := True;
    FEditContactNextGlobal := TfrmEditContact.Create(nil);
    FEditContactNextGlobal.ShowModal;

    EditContactNextGlobal_Global := False;
  end;
end;

procedure OpenAbout;
begin
  if AboutIsShow = False then
  begin
    FAbout := TfrmAbout.Create(nil);
    FAbout.Show;
  end;
end;

procedure OpenOptions;
begin
  if OptionsIsShow = False then
  begin
    FOptions := TfrmOptions.Create(nil);
    FOptions.Show;
  end;
end;

procedure OpenWindow;
begin
  if WindowIsShow = False then
  begin
    FWindow := TfrmWindow.Create(nil);
    FWindow.Show;
  end;
end;


procedure OpenBookmark(CLPos: Integer; RSSPos: Integer; NoShowWindow: Boolean);
var i, ii, hIndex: Int64;

Label NextRSS, NoAddRSS;
begin
  if RSSPos = -1 then
  begin
    if TCL(CL.Objects[CLPos]).Feed.Count = 0 then
      Exit;

    i:=0;
    while ( i<= TCL(CL.Objects[CLPos]).Feed.Count - 1 ) do
    begin

      ii:=0;
      while ( ii<= BookmarkWindow.Count - 1 ) do
      begin
        Application.ProcessMessages;
        if (TBookmarkWindow(BookmarkWindow.Objects[ii]).CLPos = CLPos) and (TBookmarkWindow(BookmarkWindow.Objects[ii]).RSSPos = i) then
        begin

          if i=0 then
          begin
            FWindow.tabWindow.TabIndex := ii;
            FWindow.ShowBookmark(ii);
            SetForegroundWindow(FWindow.Handle);
          end;

          Goto NextRSS;
        end;


          Inc(ii);
      end;

      Application.ProcessMessages;
      BookmarkWindow.Add('FEED');
      hIndex:= BookmarkWindow.Count - 1;
      BookmarkWindow.Objects[hIndex] := TBookmarkWindow.Create;
      TBookmarkWindow(BookmarkWindow.Objects[hIndex]).CLPos  := CLPos;
      TBookmarkWindow(BookmarkWindow.Objects[hIndex]).RSSPos := i;

      TBookmarkWindow(BookmarkWindow.Objects[hIndex]).Data := TStringList.Create;
      TBookmarkWindow(BookmarkWindow.Objects[hIndex]).Data.Clear;

      if WindowIsShow=True then
      begin
        FWindow.AddNewTab(hIndex);

        if i=0 then
        begin
          FWindow.tabWindow.TabIndex := hIndex;
          FWindow.ShowBookmark(hIndex);
        end;

        SetForegroundWindow(FWindow.Handle);
      end;


      NextRSS:

      Inc(i);
    end;

  end
  else
  begin

    ii:=0;
    while ( ii<= BookmarkWindow.Count - 1 ) do
    begin
      Application.ProcessMessages;
      if (TBookmarkWindow(BookmarkWindow.Objects[ii]).CLPos = CLPos) and (TBookmarkWindow(BookmarkWindow.Objects[ii]).RSSPos = RSSPos) then
      begin
        hIndex := ii;
        Goto NoAddRSS;
      end;

      Inc(ii);
    end;

    Application.ProcessMessages;
    BookmarkWindow.Add('ITEM');
    hIndex:= BookmarkWindow.Count - 1;
    BookmarkWindow.Objects[hIndex] := TBookmarkWindow.Create;
    TBookmarkWindow(BookmarkWindow.Objects[hIndex]).CLPos  := CLPos;
    TBookmarkWindow(BookmarkWindow.Objects[hIndex]).RSSPos := RSSPos;

    TBookmarkWindow(BookmarkWindow.Objects[hIndex]).Data := TStringList.Create;
    TBookmarkWindow(BookmarkWindow.Objects[hIndex]).Data.Clear;


    if WindowIsShow=True then
    begin
      FWindow.AddNewTab(hIndex);
      SetForegroundWindow(FWindow.Handle);
    end;

    NoAddRSS:

    if WindowIsShow=True then
    begin
      FWindow.tabWindow.TabIndex := hIndex;
      FWindow.ShowBookmark(hIndex);
      SetForegroundWindow(FWindow.Handle);
    end;

  end;


  if BookmarkWindow.Count > 0 then
    OpenWindow;

end;


procedure OpenEditContact(CLIndex: Integer; RSSIndex: Integer);
begin
  if EditContactIsShow = False then
  begin
    EditContact_CLIndex   := CLIndex;
    EditContact_RSSIndex  := RSSIndex;

    FEditContact := TfrmEditContact.Create(nil);
    FEditContact.Show;
  end;
end;

procedure OpenContactDetails(CLIndex: Integer; RSSIndex: Integer);
begin
  if ContactDetailsIsShow = False then
  begin
    ContactDetails_CLIndex  := CLIndex;
    ContactDetails_RSSIndex := RSSIndex;

    FContactDetails := TfrmContactDetails.Create(nil);
    FContactDetails.Show;
  end;
end;

procedure OpenAddFeed(CLIndex: Integer; Style : Integer; iType: Integer; sURL: WideString; sName: WideString);
begin
  if AddFeedIsShow = False then
  begin
    AddFeed_CLIndex := CLIndex;
    AddFeed_Style := Style;
    AddFeed_Type  := iType;
    AddFeed_URL   := sURL;
    AddFeed_Name  := sName;
    FAddFeed := TfrmAddFeed.Create(nil);
    FAddFeed.Show;
  end;
end;




function CheckRSS: Integer;
var i,ii: Integer;
    HTMLData: TResultData;
    sSQL      : WideString;
    sValue, sURL    : WideString;
    iInt      : Int64;
    errorPos : Integer;
    slSuperReplace: TStringList;
    hslIndex: Integer;

    bNoAutCl : Boolean;
    iClTime : Integer;
    sMsgText: WideString;

begin

  i := CheckRSS_CL;
  ii := CheckRSS_Feed;



  Result := 0;

  try

    TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).NextUpdate := -1;

    TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).Error := False;

    TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).CheckingUpdate := True;
    TCL(CL.Objects[i]).CheckingUpdate := True;


    QIPPlugin.RedrawSpecContact(TCL(CL.Objects[i]).SpecCntUniq.UniqID);

    if TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).Style = FEED_RPC_SEZNAM then
    begin
      CheckRPC(i,ii);

      TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).LastUpdate := Now;

      sSQL := 'UPDATE RSS SET LastUpdate='+''''+FormatDateTime('YYYY-MM-DD HH:MM:SS',TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).LastUpdate)+''''+' WHERE (ID='+IntToStr(TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).ID)+')';
      ExecSQLUTF8(sSQL);
    end
    else
    begin
      if TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).Style = FEED_GMAIL then
        sURL := GMAIL_CHECKURL
      else
        sURL := TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).URL;


      try
        HTMLData := GetHTML(sURL,EncryptText(TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).LoginName),EncryptText(TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).LoginPassword), downTimeout, NO_CACHE, Info);
      except
        TCL(CL.Objects[i]).Error := True;
        TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).Error := True;
      end;



      if HTMLData.OK = True then
      begin

        ProcessXML(i, ii, HTMLData.parString);

        TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).LastUpdate := Now;

        sSQL := 'UPDATE RSS SET LastUpdate='+''''+FormatDateTime('YYYY-MM-DD HH:MM:SS',TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).LastUpdate)+''''+' WHERE (ID='+IntToStr(TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).ID)+')';
        ExecSQLUTF8(sSQL);

      end
      else
      begin
        TCL(CL.Objects[i]).Error := True;
        TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).Error := True;
      end;
    end;

    sValue := LoadOptionOwn(i,ii,'Update', -1);

    val(GetOptionFromOptions(sValue,'Interval'), iInt, errorPos);

    if errorPos<>0 then
      iInt:=30;

    if iInt=0 then iInt := 1;

    TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).NextUpdate := Now + ( iInt * (1/(24*60) ) );


    if ((TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).NewItems=True) and
       (TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).NewItemsWasNotif=False)) then
    begin
      if RSSNewsStatus = 2 then
        ///
      else
      begin
        sValue := LoadOptionOwn(i,ii,'Notifications', -1);

        if StrPosE(sValue,'Tray;',1,False) <> 0 then
        begin
{          QIPPlugin.TrayIcon1.Hint := 'RSS News - nové zprávy';
          QIPPlugin.TrayIcon1.Visible := True;}
          QIPPlugin.TrayIconShow('RSS News - nové zprávy');
        end;

        if StrPosE(sValue,'Popup;',1,False) <> 0 then
        begin
          TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).NewItemsWasNotif := True;

          if StrPosE(sValue,'Popup-MsgText;',1,False) <> 0 then
            //oznámilo jednotlivé zprávy
          else
          begin
            slSuperReplace := TStringList.Create;
            slSuperReplace.Clear;

            slSuperReplace.Add('ITEM');
            hslIndex:= slSuperReplace.Count - 1;
            slSuperReplace.Objects[hslIndex] := TSuperReplace.Create;
            TSuperReplace(slSuperReplace.Objects[hslIndex]).Command    := '%FEEDNAME%';
            TSuperReplace(slSuperReplace.Objects[hslIndex]).Value      := TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).Name;

            {'Nové zprávy v: ' + TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).Name}

            bNoAutCl := False;
            iClTime  := 0;

            if StrPosE(sValue,'Popup-NoAutoClose;',1,False) <> 0 then
              bNoAutCl := True
            else
              iClTime := ConvStrToInt( GetOptionFromOptions(sValue,'Popup-CloseTime') );

            if (TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).Style = FEED_GMAIL) or
               (TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).Style = FEED_RPC_SEZNAM) then
            begin
              sMsgText := SuperReplace(TextNewEmails,slSuperReplace)
            end
            else
            begin
              sMsgText := SuperReplace(TextNewMessages,slSuperReplace)
            end;

            QIPPlugin.AddFadeMsg(0,
                               PluginSkin.PluginIcon.Icon.Handle,
                               'RSS News',
                               sMsgText,
                               True,
                               bNoAutCl,
                               iClTime,
                               0);

          end;

        end;
{
      if StrPosE(sValue,'',1,False) <> 0 then
      begin

      end;    }

      end;


    end;



    sSQL := 'UPDATE RSS SET NextUpdate='+''''+FormatDateTime('YYYY-MM-DD HH:MM:SS',TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).NextUpdate)+''''+' WHERE (ID='+IntToStr(TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).ID)+')';
    ExecSQLUTF8(sSQL);

    TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).CheckingUpdate := False;
    TCL(CL.Objects[i]).CheckingUpdate := False;


    QIPPlugin.RedrawSpecContact(TCL(CL.Objects[i]).SpecCntUniq.UniqID);


    if WindowIsShow = True then
    begin
      if TFeed(TCL(CL.Objects[i]).Feed.Objects[ii]).NewItems=True then
        if (TBookmarkWindow(BookmarkWindow.Objects[FWindow.tabWindow.TabIndex]).CLPos = i) and (TBookmarkWindow(BookmarkWindow.Objects[FWindow.tabWindow.TabIndex]).RSSPos = ii) then
          FWindow.ShowBookmark(FWindow.tabWindow.TabIndex);
    end;


  finally

  end;

  cthread_update := 0;
end;

procedure CountMsgItems(idxCL: Integer; var MsgsCount : TMsgsCount);
var i: Integer;
begin
  MsgsCount.MsgCount := 0;
  MsgsCount.MsgUnreadCount := 0;
  MsgsCount.MsgNewCount := 0;

  i:=0;
  while ( i<= TCL(CL.Objects[ idxCL ]).Feed.Count - 1 ) do
  begin
    MsgsCount.MsgCount        := MsgsCount.MsgCount       + TFeed(TCL(CL.Objects[ idxCL ]).Feed.Objects[i]).MsgsCount.MsgCount;
    MsgsCount.MsgUnreadCount  := MsgsCount.MsgUnreadCount + TFeed(TCL(CL.Objects[ idxCL ]).Feed.Objects[i]).MsgsCount.MsgUnreadCount;
    MsgsCount.MsgNewCount     := MsgsCount.MsgNewCount    + TFeed(TCL(CL.Objects[ idxCL ]).Feed.Objects[i]).MsgsCount.MsgNewCount;

    Inc(i);
  end;
end;






procedure AddLang(QIPID: DWord; Name: WideString);
var hIndex: Integer;
begin
  Langs.Add('');
  hIndex:= Langs.Count - 1;
  Langs.Objects[hIndex] := TLangs.Create;
  TLangs(Langs.Objects[hIndex]).QIPID  := QIPID;
  TLangs(Langs.Objects[hIndex]).Name   := Name;
  TLangs(Langs.Objects[hIndex]).Trans  := QIPPlugin.GetLang(QIPID);
end;

procedure GetLangs;
begin

  Langs := TStringList.Create;
  Langs.Clear;


  AddLang(LI_LANG_ARABIC      , 'ARABIC');
  AddLang(LI_LANG_BHOJPURI    , 'BHOJPURI');
  AddLang(LI_LANG_BULGARIAN   , 'BULGARIAN');
  AddLang(LI_LANG_BURMESE     , 'BURMESE');
  AddLang(LI_LANG_CANTONESE   , 'CANTONESE');
  AddLang(LI_LANG_CATALAN     , 'CATALAN');
  AddLang(LI_LANG_CHINESE     , 'CHINESE');
  AddLang(LI_LANG_CROATIAN    , 'CROATIAN');
  AddLang(LI_LANG_CZECH       , 'CZECH');
  AddLang(LI_LANG_DANISH      , 'DANISH');
  AddLang(LI_LANG_DUTCH       , 'DUTCH');
  AddLang(LI_LANG_ENGLISH     , 'ENGLISH');
  AddLang(LI_LANG_ESPERANTO   , 'ESPERANTO');
  AddLang(LI_LANG_ESTONIAN    , 'ESTONIAN');
  AddLang(LI_LANG_FARSI       , 'FARSI');
  AddLang(LI_LANG_FINNISH     , 'FINNISH');
  AddLang(LI_LANG_FRENCH      , 'FRENCH');
  AddLang(LI_LANG_GAELIC      , 'GAELIC');
  AddLang(LI_LANG_GERMAN      , 'GERMAN');
  AddLang(LI_LANG_GREEK       , 'GREEK');
  AddLang(LI_LANG_HEBREW      , 'HEBREW');
  AddLang(LI_LANG_HINDI       , 'HINDI');
  AddLang(LI_LANG_HUNGARIAN   , 'HUNGARIAN');
  AddLang(LI_LANG_ICELANDIC   , 'ICELANDIC');
  AddLang(LI_LANG_INDONESIAN  , 'INDONESIAN');
  AddLang(LI_LANG_ITALIAN     , 'ITALIAN');
  AddLang(LI_LANG_JAPANESE    , 'JAPANESE');
  AddLang(LI_LANG_KHMER       , 'KHMER');
  AddLang(LI_LANG_KOREAN      , 'KOREAN');
  AddLang(LI_LANG_LAO         , 'LAO');
  AddLang(LI_LANG_LATVIAN     , 'LATVIAN');
  AddLang(LI_LANG_LITHUANIAN  , 'LITHUANIAN');
  AddLang(LI_LANG_MALAY       , 'MALAY');
  AddLang(LI_LANG_NORWEGIAN   , 'NORWEGIAN');
  AddLang(LI_LANG_POLISH      , 'POLISH');
  AddLang(LI_LANG_PORTUGUESE  , 'PORTUGUESE');
  AddLang(LI_LANG_ROMANIAN    , 'ROMANIAN');
  AddLang(LI_LANG_RUSSIAN     , 'RUSSIAN');
  AddLang(LI_LANG_SERBIAN     , 'SERBIAN');
  AddLang(LI_LANG_SLOVAK      , 'SLOVAK');
  AddLang(LI_LANG_SLOVENIAN   , 'SLOVENIAN');
  AddLang(LI_LANG_SOMALI      , 'SOMALI');
  AddLang(LI_LANG_SPANISH     , 'SPANISH');
  AddLang(LI_LANG_SWAHILI     , 'SWAHILI');
  AddLang(LI_LANG_SWEDISH     , 'SWEDISH');
  AddLang(LI_LANG_TAGALOG     , 'TAGALOG');
  AddLang(LI_LANG_TATAR       , 'TATAR');
  AddLang(LI_LANG_THAI        , 'THAI');
  AddLang(LI_LANG_TURKISH     , 'TURKISH');
  AddLang(LI_LANG_UKRAINIAN   , 'UKRAINIAN');
  AddLang(LI_LANG_URDU        , 'URDU');
  AddLang(LI_LANG_VIETNAMESE  , 'VIETNAMESE');
  AddLang(LI_LANG_YIDDISH     , 'YIDDISH');
  AddLang(LI_LANG_YORUBA      , 'YORUBA');
  AddLang(LI_LANG_AFRIKAANS   , 'AFRIKAANS');
  AddLang(LI_LANG_BOSNIAN     , 'BOSNIAN');
  AddLang(LI_LANG_PERSIAN     , 'PERSIAN');
  AddLang(LI_LANG_ALBANIAN    , 'ALBANIAN');
  AddLang(LI_LANG_ARMENIAN    , 'ARMENIAN');
  AddLang(LI_LANG_PUNJABI     , 'PUNJABI');
  AddLang(LI_LANG_CHAMORRO    , 'CHAMORRO');
  AddLang(LI_LANG_MONGOLIAN   , 'MONGOLIAN');
  AddLang(LI_LANG_MANDARIN    , 'MANDARIN');
  AddLang(LI_LANG_TAIWANESE   , 'TAIWANESE');
  AddLang(LI_LANG_MACEDONIAN  , 'MACEDONIAN');
  AddLang(LI_LANG_SINDHI      , 'SINDHI');
  AddLang(LI_LANG_WELSH       , 'WELSH');
  AddLang(LI_LANG_AZERBAIJANI , 'AZERBAIJANI');
  AddLang(LI_LANG_KURDISH     , 'KURDISH');
  AddLang(LI_LANG_GUJARATI    , 'GUJARATI');
  AddLang(LI_LANG_TAMIL       , 'TAMIL');
  AddLang(LI_LANG_BELORUSSIAN , 'BELORUSSIAN');
  AddLang(LI_LANG_UNKNOWN     , 'UNKNOWN');

end;

end.
