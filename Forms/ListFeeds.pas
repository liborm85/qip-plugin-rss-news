unit ListFeeds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ToolWin, ExtCtrls, ImgList;

type

  { Node Data }
  TFeedData = class
    Folder        : Boolean;
    Name          : WideString;
    Description   : WideString;
    URL           : WideString;
    Icon          : WideString;
    Verified      : Boolean;
  end;

  TfrmListFeeds = class(TForm)
    lvData: TListView;
    ToolBar1: TToolBar;
    edtPath: TEdit;
    tmrRefresh: TTimer;
    sbStatusBar: TStatusBar;
    ilListView: TImageList;
    ilToolbar: TImageList;
    ToolButton5: TToolButton;
    tbtnRefresh: TToolButton;
    tbtnBack: TToolButton;
    tbtnHome: TToolButton;
    ToolButton6: TToolButton;
    tbtnCreateFolder: TToolButton;
    tbtnCreateFeed: TToolButton;
    gbInfo: TGroupBox;
    Label3: TLabel;
    edtFeedName: TEdit;
    edtFeedDescription: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    edtFeedURL: TEdit;
    edtFeedIcon: TEdit;
    Label6: TLabel;
    btnAddFeed: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lvDataKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tmrRefreshTimer(Sender: TObject);
    procedure tbtnCreateFolderClick(Sender: TObject);
    procedure tbtnCreateFeedClick(Sender: TObject);
    procedure tbtnHomeClick(Sender: TObject);
    procedure tbtnBackClick(Sender: TObject);
    procedure lvDataDblClick(Sender: TObject);
    procedure lvDataSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure tbtnRefreshClick(Sender: TObject);
    procedure btnAddFeedClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OpenPath;
  end;

var
  frmListFeeds: TfrmListFeeds;
  Feeds       : TStringList;
  URLPath     : WideString;

implementation

uses General, u_lang_ids, DownloadFile, TextSearch, uLNG, Convs;

{$R *.dfm}

procedure TfrmListFeeds.OpenPath;
var HTMLData: TResultData;
    sURL, sList, sItem, sName: WideString;
    iFS, iItemPos, i: Integer;
    sPath: WideString;
    hIndex: Integer;
Label 1;
begin
  sPath := URLPath;
  edtPath.Text := sPath;

  sbStatusBar.Panels[0].Text := 'Downloading...';
  sbStatusBar.Update;

  lvData.Items.Clear;
  Feeds.Clear;

  sURL := 'http://lmscze7.ic.cz/feeds.php?path='+TextToHTMLText(sPath);

  try
    HTMLData := GetHTML(sURL,'','', downTimeout, Info);
  except

  end;

  if HTMLData.OK = True then
  begin
    sbStatusBar.Panels[0].Text := 'Processing...';
    sbStatusBar.Update;

    sList := FoundStr(HTMLData.parString,'<List>','</List>', 1, iFS);

    if sList<>'' then
    begin
      iItemPos := 1;

      1:
      Application.ProcessMessages;
      sItem := FoundStr(sList,'<Item>','</Item>', iItemPos, iItemPos);
      iItemPos := iItemPos + 1;
      if sItem<>'' then
      begin

        sName := UTF8Decode(FoundStr(sItem,'<Name>','</Name>', 1, iFS));

        if sName[Length(sName)]='/' then
        begin
          sName := Copy(sName,1, Length(sName) - 1);

          Feeds.Add('');
          hIndex:= Feeds.Count - 1;
          Feeds.Objects[hIndex] := TFeedData.Create;
          TFeedData(Feeds.Objects[hIndex]).Folder  := True;
          TFeedData(Feeds.Objects[hIndex]).Name    := sName;
        end
        else
        begin
          Feeds.Add('');
          hIndex:= Feeds.Count - 1;
          Feeds.Objects[hIndex] := TFeedData.Create;
          TFeedData(Feeds.Objects[hIndex]).Folder  := False;
          TFeedData(Feeds.Objects[hIndex]).Name    := sName;
          TFeedData(Feeds.Objects[hIndex]).Description    := UTF8Decode(FoundStr(sItem,'<Description>','</Description>', 1, iFS));
          TFeedData(Feeds.Objects[hIndex]).URL    := UTF8Decode(FoundStr(sItem,'<URL>','</URL>', 1, iFS));
          TFeedData(Feeds.Objects[hIndex]).Icon    := UTF8Decode(FoundStr(sItem,'<Icon>','</Icon>', 1, iFS));

        end;

        if StrPosE(sItem, '<Verified />',  1, False) <> 0 then
          TFeedData(Feeds.Objects[hIndex]).Verified := True;

        Goto 1;
      end;

    end;
  end;


  i:=0;
  while ( i<= Feeds.Count - 1 ) do
  begin
    lvData.Items.Add;
    lvData.Items.item[lvData.Items.Count - 1].Caption := TFeedData(Feeds.Objects[i]).Name;

    if TFeedData(Feeds.Objects[i]).Folder = True then
      lvData.Items.item[lvData.Items.Count - 1].ImageIndex := 1
    else
      lvData.Items.item[lvData.Items.Count - 1].ImageIndex := 2;

//    if TFeedData(Feeds.Objects[i]).Verified = True then
     

    Inc(i);
  end;


  sbStatusBar.Panels[0].Text := '';
  sbStatusBar.Update;
end;

procedure TfrmListFeeds.btnAddFeedClick(Sender: TObject);
begin
  OpenAddFeed(-1, FEED_NORMAL, 1, edtFeedURL.Text, edtFeedName.Text );
end;

procedure TfrmListFeeds.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  ListFeedsIsShow := False;
end;

procedure TfrmListFeeds.FormShow(Sender: TObject);

begin
  ListFeedsIsShow := True;

  Icon := PluginSkin.RSSNews.Icon;

  Feeds := TStringList.Create;
  Feeds.Clear;

  Caption := LNG('MENU ContactMenu', 'OnlineFeedsDatabase', 'Online feeds database');

  URLPath := '/';
  edtPath.Text := URLPath;

  ilToolbar.AddIcon(PluginSkin.Refresh.Icon);
  ilToolbar.AddIcon(PluginSkin.ImageFolder.Icon);
  ilToolbar.AddIcon(PluginSkin.RSS1.Icon);
  ilToolbar.AddIcon(PluginSkin.Back.Icon);

  ilListView.AddIcon(PluginSkin.ImageFile.Icon);
  ilListView.AddIcon(PluginSkin.ImageFolder.Icon);
  ilListView.AddIcon(PluginSkin.RSS1.Icon);


  ShowMessage('Databáze zdrojù zatím bìží v testovacím provozu, takže mùže být nestabilní nebo nedostupná.');

  gbInfo.Visible := False;

  tmrRefresh.Enabled := True;

end;

procedure TfrmListFeeds.lvDataDblClick(Sender: TObject);
begin
  if lvData.ItemIndex <> - 1 then
  begin
    if lvData.Items.item[lvData.ItemIndex].ImageIndex = 1 then  // Folder
    begin
      URLPath := URLPath + lvData.Items.item[lvData.ItemIndex].Caption + '/';
      OpenPath;
    end;
  end;
  
end;

procedure TfrmListFeeds.lvDataKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = 13 then
  begin
    if lvData.Items.item[lvData.ItemIndex].ImageIndex = 1 then  // Folder
    begin
      URLPath := URLPath + lvData.Items.item[lvData.ItemIndex].Caption + '/';
      OpenPath;
    end;
  end;

end;

procedure TfrmListFeeds.lvDataSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin

  if lvData.ItemIndex <> -1 then
  begin
    gbInfo.Visible := not TFeedData(Feeds.Objects[lvData.ItemIndex]).Folder;

    edtFeedName.Text  := TFeedData(Feeds.Objects[lvData.ItemIndex]).Name;
    edtFeedDescription.Text  := TFeedData(Feeds.Objects[lvData.ItemIndex]).Description;
    edtFeedURL.Text := TFeedData(Feeds.Objects[lvData.ItemIndex]).URL;
    edtFeedIcon.Text := TFeedData(Feeds.Objects[lvData.ItemIndex]).Icon;


  end;

end;

procedure TfrmListFeeds.tmrRefreshTimer(Sender: TObject);
begin
  tmrRefresh.Enabled := False;

  OpenPath;
end;

procedure TfrmListFeeds.tbtnBackClick(Sender: TObject);
begin

  URLPath := Copy(URLPath, 1, Length(URLPath) - 1);

  URLPath := ExtractFilePath(URLPath) + '/';

  OpenPath;
end;

procedure TfrmListFeeds.tbtnCreateFeedClick(Sender: TObject);
begin
  OpenCreateFeed(2, URLPath);
end;

procedure TfrmListFeeds.tbtnCreateFolderClick(Sender: TObject);
begin
  OpenCreateFeed(1, URLPath);
end;

procedure TfrmListFeeds.tbtnHomeClick(Sender: TObject);
begin
  URLPath := '/';

  OpenPath;
end;

procedure TfrmListFeeds.tbtnRefreshClick(Sender: TObject);
begin
  OpenPath;
end;

end.
