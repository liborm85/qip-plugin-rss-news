unit Window;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, StdCtrls, OleCtrls, SHDocVw, Menus,
  ImgList, CommCtrl;

const
  TabSpaces = '     ';

type
  TfrmWindow = class(TForm)
    tabWindow: TTabControl;
    sbStatusBar: TStatusBar;
    pnlTab: TPanel;
    pnlTop: TPanel;
    tbTopButtons: TToolBar;
    tbtnRefresh: TToolButton;
    pnlTopic: TPanel;
    pnlBottom: TPanel;
    tbBottomRight: TToolBar;
    tbtnClose: TToolButton;
    tbBottom: TToolBar;
    tbtnPreview: TToolButton;
    tbtnDetails: TToolButton;
    tbtnEdit: TToolButton;
    pnlPreview: TPanel;
    Splitter1: TSplitter;
    lvData: TListView;
    pnlPreviewHead: TPanel;
    lblPreviewTitle: TLabel;
    lblPreviewDateTime: TLabel;
    wbPreview: TWebBrowser;
    tmrShowBookmark: TTimer;
    lblTopicTest: TLabel;
    tmrShowPreview: TTimer;
    imgEnclosure: TImage;
    ilToolbar: TImageList;
    ToolButton1: TToolButton;
    tbtnOptions: TToolButton;
    tmrNotification: TTimer;
    pmContextMenu: TPopupMenu;
    miContextMenu_OpenURL: TMenuItem;
    miContextMenu_OpenMsg: TMenuItem;
    miContextMenu_RemoveMsg: TMenuItem;
    N1: TMenuItem;
    tbtnAddFeed: TToolButton;
    miContextMenu_Close: TMenuItem;
    miContextMenu_Refresh: TMenuItem;
    miContextMenu_Edit: TMenuItem;
    N2: TMenuItem;
    miContextMenu_AddFeed: TMenuItem;
    miContextMenu_RenameFeed: TMenuItem;
    miContextMenu_RemoveFeed: TMenuItem;
    miContextMenu_MoveTo: TMenuItem;
    N3: TMenuItem;
    miContextMenu_Options: TMenuItem;
    miContextMenu_ContactDetails: TMenuItem;
    ilListView: TImageList;
    miContextMenu_CleanDatabase: TMenuItem;
    miContextMenu_AddGmail: TMenuItem;
    N4: TMenuItem;
    miContextMenu_Enclosures: TMenuItem;
    N5: TMenuItem;
    miContextMenu_MarkAsRead: TMenuItem;
    miContextMenu_MarkAsUnread: TMenuItem;
    miContextMenu_MarkFeedAsRead: TMenuItem;
    miContextMenu_MarkFeedAsUnread: TMenuItem;
    pbStatusBar: TProgressBar;
    lblPreviewComments: TLabel;
    lblPreviewCategory: TLabel;
    pnlFilter: TPanel;
    edtFilter: TEdit;
    lblFilter: TLabel;
    ToolButton2: TToolButton;
    tbtnFilter: TToolButton;
    tbFilter: TToolBar;
    tbtnFilterStart: TToolButton;
    tbtnFilterErase: TToolButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tabWindowDrawTab(Control: TCustomTabControl; TabIndex: Integer;
      const Rect: TRect; Active: Boolean);
    procedure FormResize(Sender: TObject);
    procedure tmrShowBookmarkTimer(Sender: TObject);
    procedure tabWindowChange(Sender: TObject);
    procedure lvDataSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure tmrShowPreviewTimer(Sender: TObject);
    procedure lvDataAdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure tbtnCloseClick(Sender: TObject);
    procedure tbtnRefreshClick(Sender: TObject);
    procedure tbtnPreviewClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tmrNotificationTimer(Sender: TObject);
    procedure miContextMenu_OpenURLClick(Sender: TObject);
    procedure lblPreviewTitleClick(Sender: TObject);
    procedure lvDataDblClick(Sender: TObject);
    procedure lvDataMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tbtnDetailsClick(Sender: TObject);
    procedure tbtnAddFeedClick(Sender: TObject);
    procedure tbtnOptionsClick(Sender: TObject);
    procedure tabWindowMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure miContextMenu_CloseClick(Sender: TObject);
    procedure miContextMenu_RefreshClick(Sender: TObject);
    procedure miContextMenu_ContactDetailsClick(Sender: TObject);
    procedure miContextMenu_EditClick(Sender: TObject);
    procedure miContextMenu_AddFeedClick(Sender: TObject);
    procedure miContextMenu_RemoveFeedClick(Sender: TObject);
    procedure miContextMenu_RemoveMsgClick(Sender: TObject);
    procedure miContextMenu_CleanDatabaseClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure miContextMenu_AddGmailClick(Sender: TObject);
    procedure miContextMenu_EnclosuresClick(Sender: TObject);
    procedure miContextMenu_MarkAsReadClick(Sender: TObject);
    procedure miContextMenu_MarkAsUnreadClick(Sender: TObject);
    procedure miContextMenu_MarkFeedAsReadClick(Sender: TObject);
    procedure miContextMenu_MarkFeedAsUnreadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbStatusBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure lblPreviewCommentsClick(Sender: TObject);
    procedure lvDataKeyPress(Sender: TObject; var Key: Char);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnFilterEraseClick(Sender: TObject);
    procedure edtFilterChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    procedure AddNewTab(Index: Integer);
    procedure RemoveTab(Index: Integer);
    procedure ShowBookmark(Index: Integer);
    procedure ShowPreview;

    procedure ShowContextMenu(idx: Integer);

    procedure SQLRemoveItem(idxTab: Integer; idxItem: Integer);
    procedure SQLRemoveRSS(idxTab: Integer);
    procedure SQLSetReadUnRead(idxTab: Integer; idxItem: Integer; Cmd: Integer);

    procedure SetMsgReadUnRead(idxTab: Integer; idxItem: Integer; Cmd: Integer);
  end;

var
  frmWindow: TfrmWindow;
  ShowBookmark_Index: Int64;

  NotificationNewItems : Integer;

  slMenuEnclosures: TStringList;

implementation

uses General, XMLProcess, u_lang_ids, uLNG, BBCode, Crypt,
  SQLiteTable3, SQLiteFuncs, Convs, uOptions, inifiles, TextSearch,
  uURL, GradientColor;

{$R *.dfm}

procedure TfrmWindow.AddNewTab(Index: Integer);

begin

  tabWindow.Tabs.Add( TabSpaces + TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).RSSPos ]).Name  + TabSpaces);

  FormResize(Self);
end;


procedure TfrmWindow.RemoveTab(Index: Integer);

begin
  if tbtnClose.Enabled = False then Exit;

  tbtnClose.Enabled := False;

  BookmarkWindow.Delete(Index);

  tabWindow.Tabs.Delete(Index);

  if tabWindow.Tabs.Count = 0 then
  begin
   Close;
   Exit;
  end;

  tabWindow.TabIndex := 0;

  FormResize(Self);

  ShowBookmark(tabWindow.TabIndex);

  tbtnClose.Enabled := True;

end;

procedure TfrmWindow.sbStatusBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin

  if Panel = StatusBar.Panels[0] then
    with pbStatusBar do begin
      Top := Rect.Top;
      Left := Rect.Left;
      Width := Rect.Right - Rect.Left { - 15};
      Height := Rect.Bottom - Rect.Top;
    end;

end;

procedure TfrmWindow.ShowBookmark(Index: Integer);
begin
  ShowBookmark_Index := Index;
  tmrShowBookmark.Enabled := True;
end;

procedure TfrmWindow.ShowPreview;
begin
  tmrShowPreview.Enabled := True;

end;

procedure TfrmWindow.tmrNotificationTimer(Sender: TObject);
var i: Integer;
    changed: Boolean;
begin
//   caption := Inttostr( tabWindow.ControlCount);
//   caption := Inttostr( NotificationNewItems );

//  Application.ProcessMessages;

  if NotificationNewItems=0 then
    NotificationNewItems:= 1
  else if NotificationNewItems=1 then
    NotificationNewItems:= 0;


  i:=0;
  while ( i<= BookmarkWindow.Count - 1 ) do
  begin
    Application.ProcessMessages;

    if TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[i]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[i]).RSSPos ]).NewItems = True then
      changed := True;

    Inc(i);
  end;

  if changed = True then
    tabWindow.Refresh;


end;

procedure TfrmWindow.tmrShowBookmarkTimer(Sender: TObject);
var Index, i: Integer;
    SQLtb     : TSQLiteTable;
    sOrderBy  : WideString;
    hIndex : Int64;
    sValue: WideString;
    bnewitem: Boolean;
    IncGMT : Integer;

    sName, sEmail, sURI : WideString;
    IdxOf: Integer;
    slAuthor: TStringList;

     INI : TIniFile;

    sFilter: WideString;
begin
  if tmrShowBookmark.Tag = 1 then Exit;

  tmrShowBookmark.Enabled := False;
  tmrShowBookmark.Tag := 1;

  Index := ShowBookmark_Index;

  if tbtnFilter.Down = True then
  begin
    sFilter := edtFilter.Text;
  end
  else
  begin
    sFilter := '';
  end;
  

  sValue := LoadOptionOwn(TBookmarkWindow(BookmarkWindow.Objects[Index]).CLPos, TBookmarkWindow(BookmarkWindow.Objects[Index]).RSSPos, 'GMT',-1);
  IncGMT := ConvStrToInt(GetOptionFromOptions(sValue,'GMT'));


  lvData.Items.BeginUpdate;
  lvData.Items.Clear;

  pnlTopic.Caption := '';
  pnlTopic.Hint    := '';
  pnlTopic.Alignment := taCenter;

  TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Clear;

  if TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).RSSPos ]).NewItems = True then
  begin
    TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).RSSPos ]).NewItems := False;
    TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).RSSPos ]).MsgsCount.MsgNewCount := 0;

    QIPPlugin.RedrawSpecContact(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).CLPos ]).SpecCntUniq.UniqID);
  end;

     ///DOLADIT PREPISOVANI KONTAKTU !!! aby pouze jednou

  bnewitem := False;
  i:=0;
  while ( i<= TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).CLPos ]).Feed.Count - 1 ) do
  begin
    Application.ProcessMessages;

    if TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).CLPos ]).Feed.Objects[i]).NewItems = True then
    begin
      bnewitem := True;
      break;
    end;

    Inc(i);
  end;
  if bnewitem=False then
  begin
    TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).CLPos ]).NewItems := False;
    QIPPlugin.RedrawSpecContact(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).CLPos ]).SpecCntUniq.UniqID);
  end;


  tabWindow.Refresh;

  bnewitem := False;
  i:=0;
  while ( i<= CL.Count - 1 ) do
  begin
    Application.ProcessMessages;

    if TCL(CL.Objects[i]).NewItems = True then
    begin
      bnewitem := True;
      break;
    end;

    Inc(i);
  end;

  if bnewitem=False then
  begin
    QIPPlugin.TrayIconClose;
  end;

  if lvData.Tag = -1 then
  begin

  end
  else if (lvData.Tag = FEED_GMAIL) or (lvData.Tag = FEED_RPC_SEZNAM) then
  begin
    INI := TiniFile.Create(ExtractFilePath(PluginDllPath) + Account_FileName + '.ini');
    INI.WriteInteger('Window','Email.ListView.Topic', lvData.Columns[0].Width);
    INI.WriteInteger('Window','Email.ListView.Sender', lvData.Columns[1].Width);
    INI.WriteInteger('Window','Email.ListView.Date', lvData.Columns[2].Width);
    INI.Free;
  end
  else
  begin
    INI := TiniFile.Create(ExtractFilePath(PluginDllPath) + Account_FileName + '.ini');
    INI.WriteInteger('Window','Feed.ListView.Topic', lvData.Columns[0].Width);
    INI.WriteInteger('Window','Feed.ListView.Date', lvData.Columns[1].Width);
    INI.Free;
  end;


  lvData.Columns.Clear;

  if (TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).RSSPos ]).Style = FEED_GMAIL) or
     (TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).RSSPos ]).Style = FEED_RPC_SEZNAM) then
  begin
    lvData.Tag := {FEED_GMAIL} TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).RSSPos ]).Style;

    lvData.Columns.Add.Caption := 'Title';
    lvData.Columns.Add.Caption := 'Sender';
    lvData.Columns.Add.Caption := 'Date';

    lvData.Column[0].Caption     := QIPPlugin.GetLang(LI_TOPIC);
    lvData.Column[1].Caption     := LNG('FORM Window', 'Sender', 'Sender');
    lvData.Column[2].Caption     := LNG('FORM Window', 'Date', 'Date');

    INI := TiniFile.Create(ExtractFilePath(PluginDllPath) + Account_FileName + '.ini');
    lvData.Columns[0].Width := INI.ReadInteger('Window', 'Email.ListView.Topic', 220 );
    lvData.Columns[1].Width := INI.ReadInteger('Window', 'Email.ListView.Sender', 100 );
    lvData.Columns[2].Width := INI.ReadInteger('Window', 'Email.ListView.Date', 130 );
    INI.Free;
  end
  else
  begin
    lvData.Tag := FEED_NORMAL;

    lvData.Columns.Add.Caption := 'Title';
    lvData.Columns.Add.Caption := 'Date';

    lvData.Column[0].Caption     := QIPPlugin.GetLang(LI_TOPIC);
    lvData.Column[1].Caption     := LNG('FORM Window', 'Date', 'Date');



    INI := TiniFile.Create(ExtractFilePath(PluginDllPath) + Account_FileName + '.ini');
    lvData.Columns[0].Width := INI.ReadInteger('Window', 'Feed.ListView.Topic', 320 );
    lvData.Columns[1].Width := INI.ReadInteger('Window', 'Feed.ListView.Date', 130 );
    INI.Free;
  end;




  SQLtb := SQLdb.GetTable('SELECT * FROM RSS WHERE ID='+
                           IntToStr( TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).RSSPos ]).ID ) );


  if SQLtb.Count > 0 then
  begin
    pnlTopic.Caption := SQLTextToText( SQLtb.FieldAsString(SQLtb.FieldIndex['Topic']) );

    lblTopicTest.Caption := pnlTopic.Caption;

    if lblTopicTest.Width > pnlTopic.Width then
    begin
      pnlTopic.Alignment := taLeftJustify;
      pnlTopic.Hint       := pnlTopic.Caption;
    end;
  end;

  SQLtb.Free;


  sValue := LoadOptionOwn(TBookmarkWindow(BookmarkWindow.Objects[Index]).CLPos,TBookmarkWindow(BookmarkWindow.Objects[Index]).RSSPos,'Sort',-1);
//showmessage(sValue);
  if StrPosE(sValue,'DESC;',1,False) <> 0 then  //descending sestupný
    sOrderBy := 'order by pubDate DESC'     //nahore
  else                                          // ascending vzestupný
    sOrderBy := 'order by pubDate ASC';    //dole


//edit1.text := 'SELECT * FROM Data WHERE RSSID=' + IntToStr( TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).RSSPos ]).ID )+' AND Archive=0 AND (title LIKE ''%'+WideString2UTF8(sFilter)+'%'' OR description LIKE ''%'+WideString2UTF8(sFilter)+'%'')'+sOrderBy;
  SQLtb := SQLdb.GetTable('SELECT * FROM Data WHERE RSSID=' + IntToStr( TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).RSSPos ]).ID )+' AND Archive=0 AND (title LIKE ''%'+WideString2UTF8(sFilter)+'%'' OR description LIKE ''%'+WideString2UTF8(sFilter)+'%'')'+sOrderBy);
  if SQLtb.Count > 0 then
  begin
    while not SQLtb.EOF do
    begin
      TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Add('DATA');
      hIndex:= TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Count - 1;
      TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[hIndex] := TRSSData.Create;
      TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[hIndex]).ID           := SQLtb.FieldAsInteger(SQLtb.FieldIndex['ID']);
      TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[hIndex]).State        := SQLtb.FieldAsInteger(SQLtb.FieldIndex['State']);
      TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[hIndex]).Title        := SQLTextToText( SQLtb.FieldAsString(SQLtb.FieldIndex['title']) );
      TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[hIndex]).Link         := SQLTextToText( SQLtb.FieldAsString(SQLtb.FieldIndex['link']) );

      TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[hIndex]).author  := SQLTextToText( SQLtb.FieldAsString(SQLtb.FieldIndex['author']) );

      TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[hIndex]).Description  := SQLTextToText( SQLtb.FieldAsString(SQLtb.FieldIndex['description']) );
      TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[hIndex]).summary      := SQLTextToText( SQLtb.FieldAsString(SQLtb.FieldIndex['summary']) );
      TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[hIndex]).Enclosure    := SQLTextToText( SQLtb.FieldAsString(SQLtb.FieldIndex['enclosure']) );

      TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[hIndex]).category     := SQLTextToText( SQLtb.FieldAsString(SQLtb.FieldIndex['category']) );
      TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[hIndex]).comments     := SQLTextToText( SQLtb.FieldAsString(SQLtb.FieldIndex['comments']) );
      TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[hIndex]).guid         := SQLTextToText( SQLtb.FieldAsString(SQLtb.FieldIndex['guid']) );


      if SQLtb.FieldAsString(SQLtb.FieldIndex['pubDate'])='' then
        TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[hIndex]).pubDate      := ''//FormatDateTime('dd.mm.yyyy hh:mm:ss', 0 )
      else
        TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[hIndex]).pubDate      := FormatDateTime('dd.mm.yyyy hh:mm:ss', StrToDateTime( SQLtb.FieldAsString(SQLtb.FieldIndex['pubDate']), DTFormatDATETIME  ) + ( IncGMT * (1/24) ) );



      lvData.Items.Add;
      lvData.Items.item[lvData.Items.Count - 1].Caption := TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[hIndex]).Title;

      if (TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).RSSPos ]).Style = FEED_GMAIL) or
         (TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[Index]).RSSPos ]).Style = FEED_RPC_SEZNAM) then
      begin
        if TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[hIndex]).author <> '' then
        begin
          sName  := '';
          sEmail := '';
          sURI   := '';

          LoadOptions(TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[hIndex]).author, slAuthor);
          IdxOf := slAuthor.IndexOf('name');
          if IdxOf <> -1 then
            sName := TSLOptions(slAuthor.Objects[IdxOf]).dataWideString;

          IdxOf := slAuthor.IndexOf('email');
          if IdxOf <> -1 then
            sEmail := TSLOptions(slAuthor.Objects[IdxOf]).dataWideString;

          IdxOf := slAuthor.IndexOf('uri');
          if IdxOf <> -1 then
            sURI := TSLOptions(slAuthor.Objects[IdxOf]).dataWideString;

          lvData.Items.item[lvData.Items.Count - 1].SubItems.Add( sName + ' <' + sEmail + '>' );

        end
        else
          lvData.Items.item[lvData.Items.Count - 1].SubItems.Add( '' );
      end;

      lvData.Items.item[lvData.Items.Count - 1].SubItems.Add( TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[hIndex]).pubDate );

      if TFeed(TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[Index]).CLPos]).Feed.Objects[TBookmarkWindow(BookmarkWindow.Objects[Index]).RSSPos]).Style = FEED_GMAIL then
      begin
        if TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[hIndex]).State=1 then
          lvData.Items.item[lvData.Items.Count - 1].ImageIndex := 2
        else if TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[hIndex]).State=0 then
          lvData.Items.item[lvData.Items.Count - 1].ImageIndex := 3;
      end
      else if TFeed(TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[Index]).CLPos]).Feed.Objects[TBookmarkWindow(BookmarkWindow.Objects[Index]).RSSPos]).Style = FEED_RPC_SEZNAM then
      begin
        if TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[hIndex]).State=1 then
          lvData.Items.item[lvData.Items.Count - 1].ImageIndex := 4
        else if TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[hIndex]).State=0 then
          lvData.Items.item[lvData.Items.Count - 1].ImageIndex := 5;
      end
      else
      begin
        if TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[hIndex]).State=1 then
          lvData.Items.item[lvData.Items.Count - 1].ImageIndex := 0
        else if TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[hIndex]).State=0 then
          lvData.Items.item[lvData.Items.Count - 1].ImageIndex := 1;
      end;

          {  if SQLtb.FieldAsInteger(SQLtb.FieldIndex['value']) = 1 then
              lvData.Items.item[lvData.Items.Count - 1].SubItems.Add( 'new' )
            else
              lvData.Items.item[lvData.Items.Count - 1].SubItems.Add( '' );
             }
      SQLtb.Next;
    end;

  end;

  SQLtb.Free;


  lvData.Items.EndUpdate;

  if lvData.Items.Count<>0 then
  begin
    if sOrderBy = 'order by pubDate DESC' then
      lvData.Scroll(0,0)
    else
      lvData.Scroll(0,(lvData.Items.Count - 1)*30);
  end;

  tmrShowBookmark.Tag := 0;

end;

procedure TfrmWindow.tmrShowPreviewTimer(Sender: TObject);
var F: TextFile;
    slEnclosure: TStringList;
    i,IdxOf{, iFS}: Integer;
    sSQL, sTempFile, sName,sEmail,sURI : WideString;
    Index : Integer;
    slAuthor : TStringList;
begin
  if tmrShowPreview.Tag = 1 then Exit;

  tmrShowPreview.Enabled := False;
  tmrShowPreview.Tag := 1;

  slEnclosure := TStringList.Create;
  slEnclosure.Clear;

  Index := tabWindow.TabIndex;

  slAuthor := TStringList.Create;
  slAuthor.Clear;


  lblPreviewTitle.Caption := TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[lvData.ItemIndex]).Title;

  lblPreviewDateTime.Caption := TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[lvData.ItemIndex]).PubDate;

  if TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[lvData.ItemIndex]).Enclosure='' then
    imgEnclosure.Visible := False
  else
  begin
    LoadEnclosure( TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[lvData.ItemIndex]).Enclosure,slEnclosure);
    imgEnclosure.Visible := True;
  end;

  if TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[lvData.ItemIndex]).comments = '' then
    lblPreviewComments.Visible := False
  else
    lblPreviewComments.Visible := True;

  if TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[lvData.ItemIndex]).category = '' then
    lblPreviewCategory.Caption := ''
  else
    lblPreviewCategory.Caption := TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[lvData.ItemIndex]).category;

  {Randomize;}
  sTempFile := ExtractFilePath(PluginDllPath) + 'temp'{+IntToStr(Random(10))}+'.html';


  AssignFile(F, sTempFile );
  Rewrite(F);
  writeln(F,'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">');
  writeln(F,'<html>');
  writeln(F,'  <head>');
  writeln(F,'  <meta http-equiv="content-type" content="text/html; charset=utf-8">');
  writeln(F,'  <meta name="generator" content="RSS News for QIP Infium">');
  writeln(F,'  <title></title>');
  writeln(F,'  </head>');
  writeln(F,'  <body>');

//  writeln(F,TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[lvData.ItemIndex]).Link+'<br /><br />');

  if TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[lvData.ItemIndex]).author<>'' then
  begin
    sName  := '';
    sEmail := '';
    sURI   := '';

    LoadOptions(TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[lvData.ItemIndex]).author, slAuthor);
    IdxOf := slAuthor.IndexOf('name');
    if IdxOf <> -1 then
      sName := TSLOptions(slAuthor.Objects[IdxOf]).dataWideString;

    IdxOf := slAuthor.IndexOf('email');
    if IdxOf <> -1 then
      sEmail := TSLOptions(slAuthor.Objects[IdxOf]).dataWideString;

    IdxOf := slAuthor.IndexOf('uri');
    if IdxOf <> -1 then
      sURI := TSLOptions(slAuthor.Objects[IdxOf]).dataWideString;

    

    writeln(F,'<FONT face=Arial size=1>');
    writeln(F,WideString2UTF8('<b>'+QIPPlugin.GetLang(LI_AUTHOR) + ':' + '</b> ' + sName + ' [' + sEmail + '] '));
    if sURI<>'' then
      writeln(F,WideString2UTF8(' web: ' + sURI));
    writeln(F,'</FONT>');
    writeln(F,'<BR>');
  end;

  writeln(F,'<FONT face=Arial size=2>');
  if TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[lvData.ItemIndex]).Description='' then
    writeln(F,WideString2UTF8(TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[lvData.ItemIndex]).summary ))
  else
    writeln(F,WideString2UTF8(TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[lvData.ItemIndex]).Description ));


  if slEnclosure.Count<>0 then
    writeln(F, '<BR><BR><b>'+WideString2UTF8(LNG('MENU ContactMenu', 'Enclosures', 'Enclosures'))+':</b> <BR>');

  i:=0;
  while ( i<= slEnclosure.Count - 1 ) do
  begin
    Application.ProcessMessages;

    writeln(F, '<A HREF='+WideString2UTF8(TSLEnclosure(slEnclosure.Objects[i]).EncsUrl)+ '>'+
                     WideString2UTF8(TSLEnclosure(slEnclosure.Objects[i]).EncsUrl)+'</a>'+'<i> ('+WideString2UTF8(ConvB(ConvStrToInt(TSLEnclosure(slEnclosure.Objects[i]).EncsLength)))+')</i>'+
                   '<BR />');


    Inc(i);
  end;

  writeln(F,'</FONT>');

  writeln(F,'  </body>');
  writeln(F,'</html>');
  CloseFile(F);


  wbPreview.Navigate(sTempFile);

  if TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[lvData.ItemIndex]).State = 1 then
  begin

    Dec(TFeed(TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[Index]).CLPos]).Feed.Objects[TBookmarkWindow(BookmarkWindow.Objects[Index]).RSSPos]).MsgsCount.MsgUnreadCount);


    QIPPlugin.RedrawSpecContact(TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[Index]).CLPos]).SpecCntUniq.UniqID);

    TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[lvData.ItemIndex]).State := 0;

    if TFeed(TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[Index]).CLPos]).Feed.Objects[TBookmarkWindow(BookmarkWindow.Objects[Index]).RSSPos]).Style = FEED_GMAIL then
      lvData.Items.item[lvData.ItemIndex].ImageIndex := 3
    else if TFeed(TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[Index]).CLPos]).Feed.Objects[TBookmarkWindow(BookmarkWindow.Objects[Index]).RSSPos]).Style = FEED_RPC_SEZNAM then
      lvData.Items.item[lvData.ItemIndex].ImageIndex := 5
    else
      lvData.Items.item[lvData.ItemIndex].ImageIndex := 1;

    sSQL := 'UPDATE Data SET State='+''''+IntToStr( 0 )+''''+' WHERE (ID='+IntToStr( TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[lvData.ItemIndex]).ID )+')';
    ExecSQLUTF8(sSQL);

    lvData.UpdateItems(lvData.ItemIndex, lvData.ItemIndex);
  end;

//      DeleteFile(sTempFile);


  tmrShowPreview.Tag := 0;

end;

procedure TfrmWindow.SetMsgReadUnRead(idxTab: Integer; idxItem: Integer; Cmd: Integer);
var sSQL: WideString;
   { i,} iState: Integer;
    bChange: Boolean;
begin
{   Cmd
  1 - readed
  2 - not readed
  3 - invert   }
  bChange := False;



  iState := TRSSData(TBookmarkWindow(BookmarkWindow.Objects[idxTab]).Data.Objects[idxItem]).State;


//  showmessage(inttostr(Cmd)+#13+IntTostr(iState));

  if Cmd = 1 then
  begin
    if iState = 1 then
    begin
      iState := 0;
      Dec(TFeed(TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).CLPos]).Feed.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).RSSPos]).MsgsCount.MsgUnreadCount);

      bChange := True;
    end;
  end
  else if Cmd = 2 then
  begin
    if iState = 0 then
    begin
      iState := 1;
      Inc(TFeed(TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).CLPos]).Feed.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).RSSPos]).MsgsCount.MsgUnreadCount);

      bChange := True;
    end;
  end
  else if Cmd = 3 then
  begin
    if iState = 0 then
    begin
      iState := 1;
      Inc(TFeed(TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).CLPos]).Feed.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).RSSPos]).MsgsCount.MsgUnreadCount);

      bChange := True;
    end
    else if iState = 1 then
    begin
      iState := 0;
      Dec(TFeed(TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).CLPos]).Feed.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).RSSPos]).MsgsCount.MsgUnreadCount);

      bChange := True;
    end;
  end;


  if bChange = True then
  begin
    TRSSData(TBookmarkWindow(BookmarkWindow.Objects[idxTab]).Data.Objects[idxItem]).State := iState;
    QIPPlugin.RedrawSpecContact(TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).CLPos]).SpecCntUniq.UniqID);

    if TFeed(TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).CLPos]).Feed.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).RSSPos]).Style = FEED_GMAIL then
    begin
      if iState = 0 then
        lvData.Items.item[idxItem].ImageIndex := 3
      else if iState = 1 then
        lvData.Items.item[idxItem].ImageIndex := 2
    end
    else if TFeed(TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).CLPos]).Feed.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).RSSPos]).Style = FEED_RPC_SEZNAM then
    begin
      if iState = 0 then
        lvData.Items.item[idxItem].ImageIndex := 5
      else if iState = 1 then
        lvData.Items.item[idxItem].ImageIndex := 4
    end
    else
    begin
      if iState = 0 then
        lvData.Items.item[idxItem].ImageIndex := 1
      else if iState = 1 then
        lvData.Items.item[idxItem].ImageIndex := 0;
    end;


    sSQL := 'UPDATE Data SET State='+''''+IntToStr( iState )+''''+' WHERE (ID='+IntToStr( TRSSData(TBookmarkWindow(BookmarkWindow.Objects[idxTab]).Data.Objects[idxItem]).ID )+')';
    ExecSQLUTF8(sSQL);

//    lvData.UpdateItems(idxItem, idxItem);
  end;


end;


procedure TfrmWindow.SQLSetReadUnRead(idxTab: Integer; idxItem: Integer; Cmd: Integer);
var sSQL: WideString;
    i: Integer;
begin
  if idxItem <> -1  then
  begin
    lvData.Items.BeginUpdate;

    if idxItem = -2 then
    begin

      i := lvData.Items.Count - 1;
      while ( i >= 0 ) do
      begin
        Application.ProcessMessages;

        if lvData.Items[i].Selected = True then
        begin
          SetMsgReadUnRead(idxTab, i, Cmd);
        end;

        i := i - 1;
      end;

      QIPPlugin.RedrawSpecContact(TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).CLPos]).SpecCntUniq.UniqID);

    end
    else
    begin
      SetMsgReadUnRead(idxTab, idxItem, Cmd);
    end;

    lvData.Items.EndUpdate;
  end;

end;

procedure TfrmWindow.SQLRemoveItem(idxTab: Integer; idxItem: Integer);
var sSQL: WideString;
    i: Integer;
    sIDs: WideString;
begin
  if idxItem <> -1  then
  begin
    tmrShowPreview.Tag := 1;
    tmrShowPreview.Enabled := False;

    lvData.Items.BeginUpdate;

    if idxItem = -2 then
    begin
      pbStatusBar.Max := lvData.Items.Count;
      pbStatusBar.Position := 0;
      pbStatusBar.Visible := True;

      sbStatusBar.Panels[1].Text := LNG('FORM Window', 'PleaseWait', 'Please wait...');

      sIDs := '';

      i:=lvData.Items.Count - 1;
      while ( i >= 0 ) do
      begin
        Application.ProcessMessages;

        if lvData.Items[i].Selected = True then
        begin
          if sIDs = '' then
            sIDs := '(ID='+IntToStr(TRSSData(TBookmarkWindow(BookmarkWindow.Objects[idxTab]).Data.Objects[i]).ID)+')'
          else
            sIDs := sIDs + ' OR (ID='+IntToStr(TRSSData(TBookmarkWindow(BookmarkWindow.Objects[idxTab]).Data.Objects[i]).ID)+')';

          Dec( TFeed(TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).CLPos]).Feed.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).RSSPos]).MsgsCount.MsgCount );

          if TRSSData(TBookmarkWindow(BookmarkWindow.Objects[idxTab]).Data.Objects[i]).State = 1 then
            Dec( TFeed(TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).CLPos]).Feed.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).RSSPos]).MsgsCount.MsgUnreadCount );

          lvData.Items.Delete(i);
          TBookmarkWindow(BookmarkWindow.Objects[idxTab]).Data.Delete(i);

        end;

        Dec(i);
      end;


      sSQL := 'UPDATE Data SET Archive=1 WHERE ' + sIDs;
      ExecSQLUTF8(sSQL);

      sbStatusBar.Panels[1].Text := '';
{


      OpenProgress(LNG('FORM Window', 'PleaseWait', 'Please wait...'), 0);

      sbStatusBar.Panels[1].Text := LNG('FORM Window', 'PleaseWait', 'Please wait...');

      i:=lvData.Items.Count - 1;

      while ( i >= 0 ) do
      begin
        ChangeProgress(LNG('FORM Window', 'PleaseWait', 'Please wait...'), Round( (100 / lvData.Items.Count) * ( lvData.Items.Count - i ) ) );

        pbStatusBar.Position := lvData.Items.Count - i;
        pbStatusBar.Update;

        Application.ProcessMessages;

        if lvData.Items[i].Selected = True then
        begin
          sSQL := 'UPDATE Data SET Archive=1 WHERE (ID='+IntToStr(TRSSData(TBookmarkWindow(BookmarkWindow.Objects[idxTab]).Data.Objects[i]).ID)+')';
          ExecSQLUTF8(sSQL);

          Dec( TFeed(TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).CLPos]).Feed.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).RSSPos]).MsgsCount.MsgCount );

          if TRSSData(TBookmarkWindow(BookmarkWindow.Objects[idxTab]).Data.Objects[i]).State = 1 then
            Dec( TFeed(TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).CLPos]).Feed.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).RSSPos]).MsgsCount.MsgUnreadCount );

          lvData.Items.Delete(i);
          TBookmarkWindow(BookmarkWindow.Objects[idxTab]).Data.Delete(i);

        end;

        i := i - 1;
      end;

      pbStatusBar.Max := 100;
      pbStatusBar.Position := 0;
      pbStatusBar.Visible := False;
      sbStatusBar.Panels[1].Text := '';

      CloseProgress;

}
      QIPPlugin.RedrawSpecContact(TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).CLPos]).SpecCntUniq.UniqID);

    end
    else
    begin
      sSQL := 'UPDATE Data SET Archive=1 WHERE (ID='+IntToStr(TRSSData(TBookmarkWindow(BookmarkWindow.Objects[idxTab]).Data.Objects[idxItem]).ID)+')';
      ExecSQLUTF8(sSQL);

      Dec( TFeed(TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).CLPos]).Feed.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).RSSPos]).MsgsCount.MsgCount );

      if TRSSData(TBookmarkWindow(BookmarkWindow.Objects[idxTab]).Data.Objects[idxItem]).State = 1 then
        Dec( TFeed(TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).CLPos]).Feed.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).RSSPos]).MsgsCount.MsgUnreadCount );

      lvData.Items.Delete(idxItem);
      TBookmarkWindow(BookmarkWindow.Objects[idxTab]).Data.Delete(idxItem);

      QIPPlugin.RedrawSpecContact(TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).CLPos]).SpecCntUniq.UniqID);
    end;

    lvData.Items.EndUpdate;

    tmrShowPreview.Enabled := False;
    tmrShowPreview.Tag := 0;

  end;

end;

function Repl1(sText: WideString; sStation: WideString): WideString;
begin
  Result := StringReplace(sText, '%FEED%', sStation, [rfReplaceAll]);
end;

procedure TfrmWindow.SQLRemoveRSS(idxTab: Integer);
var sSQL: WideString;
begin

  if MessageBoxW(0, PWideChar( Repl1 ( LNG('MESSAGE BOX','FeedRemove', 'Do you really want to remove feed "%FEED%" from list?' ) , TFeed(TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).CLPos]).Feed.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).RSSPos]).Name ) ) , 'RSS News', MB_YESNO + MB_ICONQUESTION) = IDYES then
  begin
    sSQL := 'DELETE FROM RSS WHERE ID='+IntToStr(TFeed(TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).CLPos]).Feed.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).RSSPos]).ID)+';';
    ExecSQLUTF8(sSQL);

    sSQL := 'DELETE FROM Data WHERE RSSID='+IntToStr(TFeed(TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).CLPos]).Feed.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).RSSPos]).ID)+';';
    ExecSQLUTF8(sSQL);

    RemoveTab(idxTab);

    TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[idxTab]).CLPos]).Feed.Delete(idxTab);
  end;

end;

procedure TfrmWindow.ShowContextMenu(idx: Integer);
var
  where: TPoint;
  Index,i: Integer;

  NewItem: TMenuItem;
  bRead, bUnread: Boolean;
begin

  Index := tabWindow.TabIndex;

  slMenuEnclosures := TStringList.Create;
  slMenuEnclosures.Clear;

  for i:=1 to miContextMenu_Enclosures.Count do miContextMenu_Enclosures.Delete(0);

//  if lvData.ItemIndex = -1 then Exit;
  

{
  miContextMenu_OpenURL.Caption := LNG('FORM Window', 'ContextMenu.Open', 'Open');
  miContextMenu_Remove.Caption  := LNG('FORM Window', 'ContextMenu.Remove', 'Remove');

  miContextMenu_Close.Caption   := LNG('FORM Window', 'ContextMenu.Close', 'Close');
  miContextMenu_Refresh.Caption := LNG('FORM Window', 'ContextMenu.Refresh', 'Refresh');
  miContextMenu_Details.Caption := LNG('FORM Window', 'ContextMenu.Details', 'Details');
  miContextMenu_Edit.Caption    := LNG('FORM Window', 'ContextMenu.Edit', 'Edit');
  miContextMenu_CleanDatabase.Caption    := LNG('FORM Window', 'ContextMenu.CleanDatabase', 'Clean database');

  miContextMenu_RenameFeed.Caption  := LNG('FORM Window', 'ContextMenu.RenameFeed', 'Rename');
  miContextMenu_RemoveFeed.Caption  := LNG('FORM Window', 'ContextMenu.RemoveFeed', 'Remove');
  miContextMenu_MoveTo.Caption  := LNG('FORM Window', 'ContextMenu.MoveTo', 'Move to');
  miContextMenu_AddFeed.Caption  := LNG('FORM Window', 'ContextMenu.AddFeed', 'Add Feed');
  miContextMenu_Options.Caption  := LNG('FORM Window', 'ContextMenu.Options', 'Options');
}

  if idx = -1 then
  begin
    miContextMenu_Enclosures.Visible := False;

    miContextMenu_OpenURL.Visible := False;
    miContextMenu_OpenMsg.Visible := False;
    miContextMenu_RemoveMsg.Visible  := False;

    miContextMenu_MarkAsRead.Visible  := False;
    miContextMenu_MarkAsUnread.Visible  := False;

    miContextMenu_MarkFeedAsRead.Visible  := True;
    miContextMenu_MarkFeedAsUnread.Visible  := True;

    miContextMenu_Close.Visible   := True;
    miContextMenu_Refresh.Visible := True;
    miContextMenu_ContactDetails.Visible    := True;
    miContextMenu_Edit.Visible    := True;

    miContextMenu_AddFeed.Visible := True;
    miContextMenu_AddGmail.Visible := True;
    miContextMenu_RenameFeed.Visible  := False;//True;
    miContextMenu_RemoveFeed.Visible  := True;
    miContextMenu_MoveTo.Visible  := False;//True;

    miContextMenu_Options.Visible := True;
  end
  else
  begin

    miContextMenu_Enclosures.Visible := False;

    if lvData.ItemIndex <> -1 then
    begin

      if TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[lvData.ItemIndex]).Enclosure='' then
        miContextMenu_Enclosures.Visible := False
      else
      begin
        LoadEnclosure( TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[lvData.ItemIndex]).Enclosure, slMenuEnclosures);
        miContextMenu_Enclosures.Visible := False;

        if slMenuEnclosures.Count<>0 then
          miContextMenu_Enclosures.Visible := True;

        i:=0;
        while ( i<= slMenuEnclosures.Count - 1 ) do
        begin
          Application.ProcessMessages;

          NewItem := TMenuItem.Create(Self);
          NewItem.Caption := {ExtractFileName(} TSLEnclosure(slMenuEnclosures.Objects[i]).EncsUrl {)} + ' ('+ConvB(ConvStrToInt(TSLEnclosure(slMenuEnclosures.Objects[i]).EncsLength))+')';
          NewItem.Tag     := i;
          NewItem.OnClick := miContextMenu_EnclosuresClick;

          miContextMenu_Enclosures.Add(NewItem);

          Inc(i);
        end;

      end;

    end;

    miContextMenu_MarkAsRead.Visible  := False;
    miContextMenu_MarkAsUnread.Visible  := False;

    miContextMenu_MarkFeedAsRead.Visible  := False;
    miContextMenu_MarkFeedAsUnread.Visible  := False;

    bUnread := False;
    bRead := False;

    i := lvData.Items.Count - 1;
    while ( i >= 0 ) do
    begin
      Application.ProcessMessages;

      if lvData.Items[i].Selected = True then
      begin
        if TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[i]).State = 1 then
          bUnread := True
        else
          bRead := True;
      end;

      Dec(i);
    end;

    if bUnread = True then
      miContextMenu_MarkAsRead.Visible  := True;

    if bRead = True then
      miContextMenu_MarkAsUnread.Visible  := True;



    miContextMenu_OpenURL.Visible := True;
    miContextMenu_OpenMsg.Visible := False;
    miContextMenu_RemoveMsg.Visible  := True;

    if lvData.ItemIndex <> -1 then
      miContextMenu_RemoveMsg.Enabled  := True
    else
      miContextMenu_RemoveMsg.Enabled  := False;

    miContextMenu_Close.Visible   := False;
    miContextMenu_Refresh.Visible := False;
    miContextMenu_ContactDetails.Visible    := False;
    miContextMenu_Edit.Visible    := False;

    miContextMenu_AddFeed.Visible := False;
    miContextMenu_AddGmail.Visible := False;
    miContextMenu_RenameFeed.Visible  := False;
    miContextMenu_RemoveFeed.Visible  := False;
    miContextMenu_MoveTo.Visible  := False;

    miContextMenu_Options.Visible := False;

    if lvData.ItemIndex<>-1 then
    begin
      if TRSSData(TBookmarkWindow(BookmarkWindow.Objects[Index]).Data.Objects[lvData.ItemIndex]).Link='' then
        miContextMenu_OpenURL.Enabled := False
      else
        miContextMenu_OpenURL.Enabled := True;
    end
    else
    begin
      miContextMenu_OpenURL.Enabled := False;
    end;

  end;


  where := Mouse.CursorPos;
  pmContextMenu.Popup(where.X,where.Y);

end;

procedure TfrmWindow.edtFilterChange(Sender: TObject);
begin
  ShowBookmark(tabWindow.TabIndex);
end;

procedure TfrmWindow.FormClose(Sender: TObject; var Action: TCloseAction);
var INI : TIniFile;
begin

  INI := TiniFile.Create(ExtractFilePath(PluginDllPath) + Account_FileName + '.ini');

  INI.WriteInteger('Window', 'X', Left );
  INI.WriteInteger('Window', 'Y', Top );

  INI.WriteInteger('Window', 'Width', Width );
  INI.WriteInteger('Window', 'Height', Height );

  INI.WriteInteger('Window', 'Preview.Enabled', BoolToInt( tbtnPreview.Down ) );
  INI.WriteInteger('Window', 'Preview.Height', pnlPreview.Height );

  INI.WriteInteger('Window', 'Filter.Enabled', BoolToInt( tbtnFilter.Down ) );

  if (lvData.Tag = FEED_GMAIL) or (lvData.Tag = FEED_RPC_SEZNAM) then
  begin
    INI.WriteInteger('Window','Email.ListView.Topic', lvData.Columns[0].Width);
    INI.WriteInteger('Window','Email.ListView.Sender', lvData.Columns[1].Width);
    INI.WriteInteger('Window','Email.ListView.Date', lvData.Columns[2].Width);
  end
  else
  begin
    INI.WriteInteger('Window','Feed.ListView.Topic', lvData.Columns[0].Width);
    INI.WriteInteger('Window','Feed.ListView.Date', lvData.Columns[1].Width);
  end;
{
  INI.WriteInteger('Window', 'ListView.Columns[0].Width', lvData.Columns[0].Width );
  INI.WriteInteger('Window', 'ListView.Columns[1].Width', lvData.Columns[1].Width );
}
  INI.Free;

  if CloseBookmarks = True then
    BookmarkWindow.Clear;

  if FileExists(ExtractFilePath(PluginDllPath) + 'temp.html')=True then
    DeleteFile(ExtractFilePath(PluginDllPath) + 'temp.html');


  WindowIsShow := False;
end;

procedure TfrmWindow.FormCreate(Sender: TObject);
var
  ProgressBarStyle: integer;
begin  {
  pbStatusBar.Left := sbStatusBar.Left + 5;
  pbStatusBar.Top := sbStatusBar.Top + 2;
  pbStatusBar.Height := sbStatusBar.Height - 4;
  pbStatusBar.Width := sbStatusBar.Panels[0].Width - 10;


  pbStatusBar.Visible := False;
  pbStatusBar.Position := 0;
        }

  //enable status bar 2nd Panel custom drawing
  sbStatusBar.Panels[0].Style := psOwnerDraw;

  //place the progress bar into the status bar
  pbStatusBar.Parent := sbStatusBar;

  //remove progress bar border
  ProgressBarStyle := GetWindowLong(pbStatusBar.Handle,
                                    GWL_EXSTYLE);
  ProgressBarStyle := ProgressBarStyle
                      - WS_EX_STATICEDGE;
  SetWindowLong(pbStatusBar.Handle,
                GWL_EXSTYLE,
                ProgressBarStyle);

  pbStatusBar.Visible := False;
  pbStatusBar.Position := 0;

end;

procedure TfrmWindow.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if (ssCtrl in Shift) then
  begin
    if  (ssShift in Shift) and (ssCtrl in Shift) then
    begin
      if Key=9 then   // Ctrl + Shift + Tab
      begin
        if tabWindow.TabIndex = 0 then
          tabWindow.TabIndex := tabWindow.Tabs.Count - 1
        else
          tabWindow.TabIndex := tabWindow.TabIndex - 1;

        ShowBookmark(tabWindow.TabIndex);
      end;
    end else
    begin
      if Key=9 then   // Ctrl + Tab
      begin
        if tabWindow.TabIndex = tabWindow.Tabs.Count - 1 then
          tabWindow.TabIndex := 0
        else
          tabWindow.TabIndex := tabWindow.TabIndex + 1;

        ShowBookmark(tabWindow.TabIndex);
      end
      else if Key = 87 then  // Ctrl + W
      begin
        RemoveTab(tabWindow.TabIndex);
      end
      else if Key = 65 then
      begin
        lvData.SelectAll;
      end;
    end;
  end else
  begin
    if Key=27 then
      Close
    else if Key=46 then
      SQLRemoveItem(tabWindow.TabIndex, {lvData.ItemIndex}-2)
    else if Key=32 then
      SQLSetReadUnRead(tabWindow.TabIndex, {lvData.ItemIndex}-2, 3)
   end;

end;

procedure TfrmWindow.FormResize(Sender: TObject);
begin
//
end;

procedure TfrmWindow.FormShow(Sender: TObject);
var i: Int64;
    INI : TIniFile;

begin
  WindowIsShow := True;

  Icon := PluginSkin.PluginIcon.Icon;

  lblPreviewTitle.Caption := '';
  lblPreviewDateTime.Caption := '';
  lblPreviewCategory.Caption := '';
  lblPreviewComments.Visible := False;

  //32 bit support - transparent atd....
  ilToolbar.Handle := ImageList_Create(ilToolbar.Width, ilToolbar.Height, ILC_COLOR32 or ILC_MASK, ilToolbar.AllocBy, ilToolbar.AllocBy);

  //32 bit support - transparent atd....
  ilListView.Handle := ImageList_Create(ilListView.Width, ilListView.Height, ILC_COLOR32 or ILC_MASK, ilListView.AllocBy, ilListView.AllocBy);

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
  ilToolbar.AddIcon(PluginSkin.Enclosure.Icon);
  ilToolbar.AddIcon(PluginSkin.RSS1.Icon);
  ilToolbar.AddIcon(PluginSkin.RSS2.Icon);
  ilToolbar.AddIcon(PluginSkin.Gmail1.Icon);
  ilToolbar.AddIcon(PluginSkin.Gmail2.Icon);
  ilToolbar.AddIcon(PluginSkin.Remove.Icon);
  ilToolbar.AddIcon(PluginSkin.Filter.Icon);
  ilToolbar.AddIcon(PluginSkin.FilterEmpty.Icon);

  ilListView.AddIcon(PluginSkin.RSS1.Icon);
  ilListView.AddIcon(PluginSkin.RSS2.Icon);
  ilListView.AddIcon(PluginSkin.Gmail1.Icon);
  ilListView.AddIcon(PluginSkin.Gmail2.Icon);
  ilListView.AddIcon(PluginSkin.Seznam1.Icon);
  ilListView.AddIcon(PluginSkin.Seznam2.Icon);


  imgEnclosure.Picture := PluginSkin.Enclosure.Image.Picture;


  miContextMenu_OpenURL.Caption := QIPPlugin.GetLang(LI_OPEN);
  //miContextMenu_OpenMsg.Caption  := LNG('FORM Window', 'ContextMenu.Remove', 'Remove');
  miContextMenu_RemoveMsg.Caption    := LNG('MENU ContactMenu', 'RemoveMsg', 'Remove message');

  miContextMenu_MarkAsRead.Caption    := LNG('MENU ContactMenu', 'MarkAsRead', 'Mark as read');
  miContextMenu_MarkAsUnread.Caption    := LNG('MENU ContactMenu', 'MarkAsUnread', 'Mark as unread');
  miContextMenu_MarkFeedAsRead.Caption    := LNG('MENU ContactMenu', 'MarkFeedAsRead', 'Mark feed as read');
  miContextMenu_MarkFeedAsUnread.Caption    := LNG('MENU ContactMenu', 'MarkFeedAsUnread', 'Mark feed as unread');

  miContextMenu_Close.Caption   := QIPPlugin.GetLang(LI_CLOSE_MSG_TAB_WINDOW);
  miContextMenu_Refresh.Caption := QIPPlugin.GetLang(LI_REFRESH);
  miContextMenu_ContactDetails.Caption := QIPPlugin.GetLang(LI_USER_DETAILS);
  miContextMenu_Edit.Caption    := LNG('MENU ContactMenu', 'Edit', 'Edit');
  miContextMenu_CleanDatabase.Caption    := LNG('MENU ContactMenu', 'CleanDatabase', 'Clean database');

  miContextMenu_AddFeed.Caption  := LNG('MENU ContactMenu', 'AddFeed', 'Add feed');
  miContextMenu_AddGmail.Caption := LNG('MENU ContactMenu', 'AddGmail', 'Add Gmail');
  miContextMenu_RenameFeed.Caption  := LNG('MENU ContactMenu', 'RenameFeed', 'Rename feed');
  miContextMenu_RemoveFeed.Caption  := LNG('MENU ContactMenu', 'RemoveFeed', 'Remove feed');
  miContextMenu_MoveTo.Caption := LNG('MENU ContactMenu', 'MoveTo', 'Move to');

  miContextMenu_Options.Caption  := QIPPlugin.GetLang(LI_OPTIONS);


  tbtnRefresh.Hint := QIPPlugin.GetLang(LI_REFRESH);

  tbtnClose.Hint := QIPPlugin.GetLang(LI_CLOSE_MSG_TAB_WINDOW);

  tbtnPreview.Hint := LNG('FORM Window', 'Preview', 'Preview');

  tbtnPreview.Hint := LNG('FORM Window', 'Filter', 'Filter');
  lblFilter.Caption := LNG('FORM Window', 'Filter', 'Filter')+':';

  tbtnDetails.Hint := QIPPlugin.GetLang(LI_USER_DETAILS);
  tbtnEdit.Hint := LNG('MENU ContactMenu', 'Edit', 'Edit');

  tbtnAddFeed.Hint  := LNG('MENU ContactMenu', 'AddFeed', 'Add feed');
{  tbtnRenameFeed.Hint  := LNG('MENU ContactMenu', 'RenameFeed', 'Rename feed');
  tbtnRemove.Hint  := LNG('MENU ContactMenu', 'RemoveFeed', 'Remove feed');}

  miContextMenu_Enclosures.Caption := LNG('MENU ContactMenu', 'Enclosures', 'Enclosures');

  tbtnOptions.Hint := QIPPlugin.GetLang(LI_OPTIONS);

  lvData.Column[0].Caption     := QIPPlugin.GetLang(LI_TOPIC);
  lvData.Column[1].Caption     := LNG('FORM Window', 'Date', 'Date');

  lblPreviewComments.Caption := LNG('FORM Window', 'Comments', 'Comments');


  lvData.Tag := -1;

  INI := TiniFile.Create(ExtractFilePath(PluginDllPath) + Account_FileName + '.ini');
  Left := INI.ReadInteger('Window', 'X', 50);
  Top := INI.ReadInteger('Window', 'Y', 50);

  Width := INI.ReadInteger('Window', 'Width', Width);
  Height := INI.ReadInteger('Window', 'Height', Height);
{
  lvData.Columns[0].Width := INI.ReadInteger('Window', 'ListView.Columns[0].Width', lvData.Columns[0].Width );
  lvData.Columns[1].Width := INI.ReadInteger('Window', 'ListView.Columns[1].Width', lvData.Columns[1].Width );
}
  pnlPreview.Height := INI.ReadInteger('Window', 'Preview.Height', pnlPreview.Height);

  if INI.ReadInteger('Window', 'Filter.Enabled', 0) = 1 then
  begin
    pnlFilter.Visible := True;
    tbtnFilter.Down := True;
  end
  else
  begin
    tbtnFilter.Down := False;
    pnlFilter.Visible := False;
  end;


  if INI.ReadInteger('Window', 'Preview.Enabled', 1) = 1 then
  begin
    pnlPreview.Visible := True;
    tbtnPreview.Down := True;
  end
  else
  begin
    tbtnPreview.Down := False;
    pnlPreview.Visible := False;
  end;

  pnlBottom.Top := 2000;

  INI.Free;

  

  tabWindow.Tabs.Clear;

  tabWindow.TabHeight := 20;

  i:=0;
  while ( i<= BookmarkWindow.Count - 1 ) do
  begin
    Application.ProcessMessages;

    tabWindow.Tabs.Add( TabSpaces + TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[i]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[i]).RSSPos ]).Name  + TabSpaces);

    Inc(i);

  end;

  tmrNotification.Enabled := True;

  tabWindow.TabIndex := 0;
  ShowBookmark(tabWindow.TabIndex);


end;

procedure TfrmWindow.lblPreviewCommentsClick(Sender: TObject);
var sURL: WideString;
begin

  if Copy(TRSSData(TBookmarkWindow(BookmarkWindow.Objects[tabWindow.TabIndex]).Data.Objects[lvData.Items[lvData.ItemIndex].Index]).comments,1,7) = 'http://' then
    sURL := TRSSData(TBookmarkWindow(BookmarkWindow.Objects[tabWindow.TabIndex]).Data.Objects[lvData.Items[lvData.ItemIndex].Index]).comments
  else
    sURL := 'http://' + TRSSData(TBookmarkWindow(BookmarkWindow.Objects[tabWindow.TabIndex]).Data.Objects[lvData.Items[lvData.ItemIndex].Index]).comments;

  LinkUrl( sURL );

end;

procedure TfrmWindow.lblPreviewTitleClick(Sender: TObject);
begin
  miContextMenu_OpenURLClick(Sender);
end;

procedure TfrmWindow.lvDataAdvancedCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
  var DefaultDraw: Boolean);
begin
  try
    if TRSSData(TBookmarkWindow(BookmarkWindow.Objects[tabWindow.TabIndex]).Data.Objects[Item.Index]).State = 1 then
    begin
      Sender.Canvas.Font.Style := Sender.Canvas.Font.Style + [fsBold];
    end;
  finally

  end;
end;

procedure TfrmWindow.lvDataDblClick(Sender: TObject);
begin
  miContextMenu_OpenURLClick(Sender);
end;

procedure TfrmWindow.lvDataKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    miContextMenu_OpenURLClick(Sender);
  end;

end;

procedure TfrmWindow.lvDataMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

  if Button = mbRight then
  begin
    ShowContextMenu( 0 );
  end;

end;

procedure TfrmWindow.lvDataSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if lvData.ItemIndex <> -1 then
    begin
      ShowPreview;
    end;
end;

procedure TfrmWindow.miContextMenu_AddFeedClick(Sender: TObject);
begin
  tbtnAddFeedClick(Sender);
end;

procedure TfrmWindow.miContextMenu_AddGmailClick(Sender: TObject);
begin
  OpenAddFeed(-1, FEED_GMAIL, 0, '', '');
end;

procedure TfrmWindow.miContextMenu_CleanDatabaseClick(Sender: TObject);
var sSQL: WideString;
begin
  sSQL := 'DELETE FROM Data WHERE RSSID='+IntToStr(TFeed(TCL(CL.Objects[TBookmarkWindow(BookmarkWindow.Objects[tabWindow.TabIndex]).CLPos]).Feed.Objects[TBookmarkWindow(BookmarkWindow.Objects[tabWindow.TabIndex]).RSSPos]).ID)+' AND Archive=1'+';';
  ExecSQLUTF8(sSQL);
end;

procedure TfrmWindow.miContextMenu_CloseClick(Sender: TObject);
begin
  tbtnCloseClick(Sender);
end;

procedure TfrmWindow.miContextMenu_ContactDetailsClick(Sender: TObject);
begin
  tbtnDetailsClick(Sender);
end;

procedure TfrmWindow.miContextMenu_EditClick(Sender: TObject);
begin
  tbtnEditClick(Sender);
end;

procedure TfrmWindow.miContextMenu_EnclosuresClick(Sender: TObject);
var idx: Integer;
begin
  if Sender <> miContextMenu_Enclosures then
  begin
    idx := (Sender as TMenuItem).Tag;

    LinkUrl( TSLEnclosure(slMenuEnclosures.Objects[idx]).EncsUrl );

  end;
end;

procedure TfrmWindow.miContextMenu_MarkAsReadClick(Sender: TObject);
begin
  SQLSetReadUnRead(tabWindow.TabIndex, -2, 1);
end;

procedure TfrmWindow.miContextMenu_MarkAsUnreadClick(Sender: TObject);
begin
  SQLSetReadUnRead(tabWindow.TabIndex, -2, 2);
end;

procedure TfrmWindow.miContextMenu_MarkFeedAsReadClick(Sender: TObject);
var i, idxTab: Integer;
begin
  idxTab := tabWindow.TabIndex;

  lvData.Items.BeginUpdate;

  i := lvData.Items.Count - 1;
  while ( i >= 0 ) do
  begin
    Application.ProcessMessages;

    SetMsgReadUnRead(idxTab, i, 1);

    Dec(i);
  end;

  lvData.Items.EndUpdate;

end;

procedure TfrmWindow.miContextMenu_MarkFeedAsUnreadClick(Sender: TObject);
var i, idxTab: Integer;
begin
  idxTab := tabWindow.TabIndex;

  lvData.Items.BeginUpdate;

  i := lvData.Items.Count - 1;
  while ( i >= 0 ) do
  begin
    Application.ProcessMessages;

    SetMsgReadUnRead(idxTab, i, 2);

    Dec(i);
  end;

  lvData.Items.EndUpdate;

end;

procedure TfrmWindow.miContextMenu_OpenURLClick(Sender: TObject);
var sURL, sLoginName: WideString;

begin

  if lvData.ItemIndex <> -1 then
  begin
    if TRSSData(TBookmarkWindow(BookmarkWindow.Objects[tabWindow.TabIndex]).Data.Objects[lvData.Items[lvData.ItemIndex].Index]).Link = '' then
      //
    else
    begin
      if Copy(TRSSData(TBookmarkWindow(BookmarkWindow.Objects[tabWindow.TabIndex]).Data.Objects[lvData.Items[lvData.ItemIndex].Index]).Link,1,7) = 'http://' then
        sURL := TRSSData(TBookmarkWindow(BookmarkWindow.Objects[tabWindow.TabIndex]).Data.Objects[lvData.Items[lvData.ItemIndex].Index]).Link
      else
        sURL := 'http://' + TRSSData(TBookmarkWindow(BookmarkWindow.Objects[tabWindow.TabIndex]).Data.Objects[lvData.Items[lvData.ItemIndex].Index]).Link;

      if TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[tabWindow.TabIndex]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[tabWindow.TabIndex]).RSSPos ]).Style = FEED_GMAIL then
      begin
        sLoginName := EncryptText( TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[tabWindow.TabIndex]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[tabWindow.TabIndex]).RSSPos ]).LoginName );
        if Copy( sLoginName,Length(sLoginName)-11,12) = '@gamepark.cz' then
        begin
          if Copy(sURL,1,23)='http://mail.google.com/' then
          begin
            sURL := 'http://mail.gamepark.cz/' + Copy(sURL,24);
          end;
        end;

      end;

      LinkUrl( sURL );
    end;
  end;

end;

procedure TfrmWindow.miContextMenu_RefreshClick(Sender: TObject);
begin
  tbtnRefreshClick(Sender);
end;

procedure TfrmWindow.miContextMenu_RemoveFeedClick(Sender: TObject);
begin
  SQLRemoveRSS(tabWindow.TabIndex)
end;

procedure TfrmWindow.miContextMenu_RemoveMsgClick(Sender: TObject);
begin
  SQLRemoveItem(tabWindow.TabIndex, lvData.ItemIndex);
end;

procedure TfrmWindow.tabWindowChange(Sender: TObject);
begin
  ShowBookmark(tabWindow.TabIndex);
end;

procedure TfrmWindow.tabWindowDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
  sText, sValue, sMsgCount, sMsgUnreadCount, sMsgNewCount, sMsg : WideString;
  R, R1, R2 : TRect;
begin
(*
//TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).RSSPos ]).Style
 //  sValue := LoadOptionOwn(TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).CLPos, -1, 'SpecCnt',-1);



 // if StrPosE(sValue,'Show-MsgCount;',1,False) <> 0 then
    sMsgCount := inttostr(TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).RSSPos ]).MsgsCount.MsgCount);

 // if StrPosE(sValue,'Show-MsgUnreadCount;',1,False) <> 0 then
    if TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).RSSPos ]).MsgsCount.MsgUnreadCount <> 0 then
      sMsgUnreadCount := '[b]'+inttostr(TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).RSSPos ]).MsgsCount.MsgUnreadCount) +'[/b]';

//  if StrPosE(sValue,'Show-MsgNewCount;',1,False) <> 0 then
    if TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).RSSPos ]).MsgsCount.MsgNewCount <> 0 then
      sMsgNewCount := inttostr(TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).RSSPos ]).MsgsCount.MsgNewCount);

  if sMsgUnreadCount = '' then
    if sMsgCount<>'' then
      sMsg := sMsg + '('+sMsgCount+')'
  else
    if sMsgCount='' then
      sMsg := sMsg + '('+sMsgUnreadCount+')'
    else
      sMsg := sMsg + '('+sMsgUnreadCount+'/[color=offline]'+sMsgCount+'[/color])';

  if sMsgNewCount <> '' then
    sMsg := sMsg + ' [b]('+sMsgNewCount+')[/b]';
//showmessage(sMSG);

                       *)
  sText := Trim(tabWindow.Tabs[TabIndex]) + ' ' + sMsg;
  R.Left := Rect.Left;
  R.Top  := Rect.Top;
  R.Right:= Rect.Right;
  R.Bottom := Rect.Bottom;

  R1.Left := Rect.Left;
  R1.Top  := Rect.Top;
  R1.Right:= Rect.Right;
  R1.Bottom := Rect.Bottom;

  R2.Left := Rect.Left;
  R2.Top  := Rect.Top;
  R2.Right:= Rect.Right;
  R2.Bottom := Rect.Bottom;

  if Active = True then
  begin
(*    Control.Canvas.Brush.Color := clred;  //QIP_Colors.TabActLiTop;

    Control.Canvas.MoveTo({0,0}Rect.Left,Rect.Top);
//    Control.Canvas.LineTo(Rect.Right - Rect.Left,Rect.Top);

    Control.Canvas.LineTo({Rect.Right - Rect.Left,Rect.Bottom-Rect.Top}Rect.Left+100,Rect.top+20);

//    Control.Canvas.Brush.Color := QIP_Colors.TabActLight;

    Control.Canvas.MoveTo(Rect.Left,Rect.Top + 1);
    Control.Canvas.LineTo(Rect.Right - Rect.Left,Rect.Top + 1);   *)

    SetBkMode(Control.Canvas.Handle, TRANSPARENT);

    GradVertical(Control.Canvas, R2, QIP_Colors.TabActive, QIP_Colors.TabActGrad );

    R1.Left := R1.Left + 26+4-4;

    Control.Canvas.Font.Color := QIP_Colors.TabFontAct;

    R1.Top := R1.Top + 5;
    BBCodeDrawText(Control.Canvas,sText,R1,False,QIP_Colors);

//    DrawTextW(Control.Canvas.Handle, PWideChar(sText), Length(sText), R1, DT_NOPREFIX + DT_LEFT + DT_VCENTER + DT_SINGLELINE  );

    if TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).RSSPos ]).Logo.ExistLogo = True then
      Control.Canvas.Draw(Rect.Left + 4+2, Rect.Top + Round((Rect.Bottom - Rect.Top) / 2 ) - 8, TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).RSSPos ]).Logo.SmallImage.Picture.Graphic)
    else
    begin
      if TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).RSSPos ]).MsgsCount.MsgUnreadCount = 0 then
        if TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).RSSPos ]).Style = FEED_GMAIL then
          Control.Canvas.Draw(Rect.Left + 4+2,Rect.Top + Round((Rect.Bottom - Rect.Top) / 2 ) - 8 - 1, PluginSkin.Gmail2.Image.Picture.Graphic)
        else if TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).RSSPos ]).Style = FEED_RPC_SEZNAM then
          Control.Canvas.Draw(Rect.Left + 4+2,Rect.Top + Round((Rect.Bottom - Rect.Top) / 2 ) - 8 - 1, PluginSkin.Seznam2.Image.Picture.Graphic)
        else
          Control.Canvas.Draw(Rect.Left + 4+2,Rect.Top + Round((Rect.Bottom - Rect.Top) / 2 ) - 8 - 1, PluginSkin.RSS2.Image.Picture.Graphic)
      else
        if TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).RSSPos ]).Style = FEED_GMAIL then
          Control.Canvas.Draw(Rect.Left + 4+2,Rect.Top + Round((Rect.Bottom - Rect.Top) / 2 ) - 8 - 1, PluginSkin.Gmail1.Image.Picture.Graphic)
        else if TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).RSSPos ]).Style = FEED_RPC_SEZNAM then
          Control.Canvas.Draw(Rect.Left + 4+2,Rect.Top + Round((Rect.Bottom - Rect.Top) / 2 ) - 8 - 1, PluginSkin.Seznam1.Image.Picture.Graphic)
        else
          Control.Canvas.Draw(Rect.Left + 4+2,Rect.Top + Round((Rect.Bottom - Rect.Top) / 2 ) - 8 - 1, PluginSkin.RSS1.Image.Picture.Graphic);
    end;

  end
  else
  begin
    SetBkMode(Control.Canvas.Handle, TRANSPARENT);

    R2.Bottom := R2.Bottom + 3;
    GradVertical(Control.Canvas, R2, QIP_Colors.TabInactive, QIP_Colors.TabInactGrad );

    R1.Top := R1.Top + 1;
    R1.Left := R1.Left + 26-4;

    Control.Canvas.Font.Color := QIP_Colors.TabFontInact;    

//    R1.Top := R1.Top + 2;
    DrawTextW(Control.Canvas.Handle, PWideChar(sText), Length(sText), R1, DT_NOPREFIX + DT_LEFT + DT_VCENTER + DT_SINGLELINE );

    if TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).RSSPos ]).Logo.ExistLogo = True then
      Control.Canvas.Draw(Rect.Left +2,Rect.Top + Round((Rect.Bottom - Rect.Top) / 2 ) - 8, TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).RSSPos ]).Logo.SmallImage.Picture.Graphic)
    else
    begin
      if TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).RSSPos ]).MsgsCount.MsgUnreadCount = 0 then
        if TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).RSSPos ]).Style = FEED_GMAIL then
          Control.Canvas.Draw(Rect.Left +2,Rect.Top + Round((Rect.Bottom - Rect.Top) / 2 ) - 8, PluginSkin.Gmail2.Image.Picture.Graphic)
        else if TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).RSSPos ]).Style = FEED_RPC_SEZNAM then
          Control.Canvas.Draw(Rect.Left +2,Rect.Top + Round((Rect.Bottom - Rect.Top) / 2 ) - 8, PluginSkin.Seznam2.Image.Picture.Graphic)
        else
          Control.Canvas.Draw(Rect.Left +2,Rect.Top + Round((Rect.Bottom - Rect.Top) / 2 ) - 8, PluginSkin.RSS2.Image.Picture.Graphic)
      else
        if TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).RSSPos ]).Style = FEED_GMAIL then
          Control.Canvas.Draw(Rect.Left +2,Rect.Top + Round((Rect.Bottom - Rect.Top) / 2 ) - 8, PluginSkin.Gmail1.Image.Picture.Graphic)
        else if TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).RSSPos ]).Style = FEED_RPC_SEZNAM then
          Control.Canvas.Draw(Rect.Left +2,Rect.Top + Round((Rect.Bottom - Rect.Top) / 2 ) - 8, PluginSkin.Seznam1.Image.Picture.Graphic)
        else
          Control.Canvas.Draw(Rect.Left +2,Rect.Top + Round((Rect.Bottom - Rect.Top) / 2 ) - 8, PluginSkin.RSS1.Image.Picture.Graphic);
    end;

  end;

  if TFeed(TCL(CL.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).CLPos ]).Feed.Objects[ TBookmarkWindow(BookmarkWindow.Objects[TabIndex]).RSSPos ]).NewItems = True then
    if NotificationNewItems=1 then
      Control.Canvas.Draw(Rect.Left + 2,Rect.Top + Round((Rect.Bottom - Rect.Top) / 2 ) - 8, PluginSkin.Msg.Image.Picture.Graphic);


end;



procedure TfrmWindow.tabWindowMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

  if Button = mbRight then
  begin
    ShowContextMenu( -1 );
  end;

end;

procedure TfrmWindow.tbtnOptionsClick(Sender: TObject);
begin
  OpenOptions;
end;

procedure TfrmWindow.tbtnDetailsClick(Sender: TObject);
begin
  OpenContactDetails(TBookmarkWindow(BookmarkWindow.Objects[tabWindow.TabIndex]).CLPos, TBookmarkWindow(BookmarkWindow.Objects[tabWindow.TabIndex]).RSSPos);
end;

procedure TfrmWindow.tbtnAddFeedClick(Sender: TObject);
begin
  OpenAddFeed(-1, FEED_NORMAL, 0, '', '');
end;

procedure TfrmWindow.tbtnCloseClick(Sender: TObject);
begin
  RemoveTab(tabWindow.TabIndex);
end;

procedure TfrmWindow.tbtnEditClick(Sender: TObject);
begin
  OpenEditContact(TBookmarkWindow(BookmarkWindow.Objects[tabWindow.TabIndex]).CLPos, TBookmarkWindow(BookmarkWindow.Objects[tabWindow.TabIndex]).RSSPos);
end;

procedure TfrmWindow.tbtnFilterClick(Sender: TObject);
begin
  pnlFilter.Visible := tbtnFilter.Down;
end;

procedure TfrmWindow.tbtnFilterEraseClick(Sender: TObject);
begin
//  ShowBookmark(tabWindow.TabIndex);
end;

procedure TfrmWindow.tbtnPreviewClick(Sender: TObject);
begin
  pnlPreview.Visible := tbtnPreview.Down;
end;

procedure TfrmWindow.tbtnRefreshClick(Sender: TObject);
begin
  TFeed(TCL(CL.Objects[
    TBookmarkWindow(BookmarkWindow.Objects[tabWindow.TabIndex]).CLPos
   ]).Feed.Objects[
    TBookmarkWindow(BookmarkWindow.Objects[tabWindow.TabIndex]).RSSPos
   ]).NextUpdate := Now;
end;

end.
