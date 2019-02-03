unit AddFeed;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TfrmAddFeed = class(TForm)
    lblURL: TLabel;
    lblInfo: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    edtURL: TEdit;
    btnURLCheck: TBitBtn;
    cmbAddTo: TComboBox;
    chkAddTo: TCheckBox;
    pnlURL: TPanel;
    pnlLogin: TPanel;
    pnlAddTo: TPanel;
    pnlButtons: TPanel;
    gbLogin: TGroupBox;
    lblLoginName: TLabel;
    lblLoginPassword: TLabel;
    edtLoginPassword: TEdit;
    edtLoginName: TEdit;
    pnlName: TPanel;
    edtName: TEdit;
    lblName: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure chkAddToClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    function LoadFeedInfo(): Boolean;
  end;

var
  frmAddFeed: TfrmAddFeed;
  NewRSSData : TStringList;

implementation

uses General, u_lang_ids, XMLProcess, uLNG, Crypt,
     SQLiteTable3, Convs, DownloadFile, SQLiteFuncs;

{$R *.dfm}

function TfrmAddFeed.LoadFeedInfo(): Boolean;
var HTMLData: TResultData;
    sURL : WideString;
begin

  NewRSSData := TStringList.Create;
  NewRSSData.Clear;

  if AddFeed_Style = FEED_NORMAL then 
    sURL := edtURL.Text
  else if AddFeed_Style = FEED_GMAIL then
    sURL := GMAIL_CHECKURL;


  lblInfo.Caption := LNG('FORM AddFeed', 'Downloading', 'Downloading...');
  lblinfo.Update;

  try
    HTMLData := GetHTML(sURL, edtLoginName.Text, edtLoginPassword.Text, downTimeout, NO_CACHE, Info);
  except
    lblInfo.Caption := 'Chyba pøi stahování.';
    result := False;
    Exit;
  end;

  if HTMLData.OK = True then
  begin
    lblInfo.Caption := LNG('FORM AddFeed', 'Processing', 'Processing...');
    lblinfo.Update;

    if Copy(HTMLData.parString,1,3) = 'ï»¿' then
      HTMLData.parString := Copy(HTMLData.parString,4);

    HTMLData.parString := Trim(HTMLData.parString);

    if (Copy(HTMLData.parString,1,5) = '<?xml') or (Copy(HTMLData.parString,1,4) = '<rss') then  // platny XML
    else

    begin          // Neplatny XML soubor
      lblInfo.Caption := 'Není platný XML soubor.';
      result := False;
      Exit;
    end;

    ReadRSS(HTMLData.parString, NewRSSData, NewFeetInfo);

    lblInfo.Caption := '';
    lblinfo.Update;

    Result := True;

  end
  else
  begin
    lblInfo.Caption := 'URL nenalezena.';
    result := False;
    Exit;
  end;


end;

procedure TfrmAddFeed.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAddFeed.btnOKClick(Sender: TObject);
var bchkAdd,bcmbAdd: Boolean;
    SQLtb     : TSQLiteTable;
    iID       : Int64;
    iCLIndex  : Integer;

    hIndex : Integer;

    sSQL      : WideString;
    sFeedName, sFeedTopic : WideString;

Label ExitFunc;
begin
  bchkAdd := chkAddTo.Enabled;
  bcmbAdd := cmbAddTo.Enabled;

  edtURL.Enabled       := False;
  chkAddTo.Enabled     := False;
  cmbAddTo.Enabled     := False;
  btnOK.Enabled        := False;
  btnCancel.Enabled    := False;
  btnURLCheck.Enabled  := False;

  gbLogin.Enabled := False;
  lblLoginName.Enabled := False;
  edtLoginName.Enabled := False;
  lblLoginPassword.Enabled := False;
  edtLoginPassword.Enabled := False;

  if AddFeed_Style = FEED_RPC_SEZNAM then
  begin
    sFeedName := edtLoginName.Text;
    sFeedTopic := '';
  end
  else
  begin
    if LoadFeedInfo=False then
      Goto ExitFunc
    else
    begin
      sFeedName := NewFeetInfo.Title;
      sFeedTopic := NewFeetInfo.Description;
    end;
  end;
  



  if chkAddTo.Checked = True then
  begin
    iCLIndex := cmbAddTo.ItemIndex;
  end
  else
  begin
    sSQL := 'INSERT INTO CL (Pos, Name) VALUES (' + IntToStr( 0 ) + ', '+ '''' + TextToSQLText( sFeedName ) + '''' + ');';
    ExecSQLUTF8(sSQL);

    SQLtb := SQLdb.GetTable('SELECT * FROM CL'); // ORDER BY Pos

    if SQLtb.Count > 0 then
    begin
      SQLtb.MoveLast;
      iID    := SQLtb.FieldAsInteger(SQLtb.FieldIndex['ID']);
    end;
    SQLtb.Free;


    sSQL := 'UPDATE CL SET Pos='+IntToStr(iID)+' WHERE (ID='+IntToStr(iID)+')';
    ExecSQLUTF8(sSQL);


    CL.Add('ITEM');
    hIndex:= CL.Count - 1;
    CL.Objects[hIndex] := TCL.Create;
    TCL(CL.Objects[hIndex]).ID    := iID;
    TCL(CL.Objects[hIndex]).Name  := sFeedName;

    TCL(CL.Objects[hIndex]).Font.Font := TFont.Create;

    TCL(CL.Objects[hIndex]).Options   := TStringList.Create;
    TCL(CL.Objects[hIndex]).Options.Clear;

    TCL(CL.Objects[hIndex]).Feed := TStringList.Create;
    TCL(CL.Objects[hIndex]).Feed.Clear;



    iCLIndex := hIndex
  end;

  sSQL := 'INSERT INTO RSS(CLID, Style, Pos, Name, Topic, URL, LoginName, LoginPassword) VALUES (' +
            IntToStr(TCL(CL.Objects[iCLIndex]).ID)+', ' +
            IntToStr( AddFeed_Style ) + ', '+
            IntToStr( 0 ) + ', '+
            '''' + TextToSQLText(sFeedName) + '''' + ', '+
            '''' + TextToSQLText(sFeedTopic)+''''+ ', ' +
            '''' + TextToSQLText(edtURL.Text)+''''+ ', ' +
            '''' + TextToSQLText(CryptText(edtLoginName.Text))+''''+ ', ' +
            '''' + TextToSQLText(CryptText(edtLoginPassword.Text)) + ''''+');';

  ExecSQLUTF8(sSQL);

  Application.ProcessMessages;

  SQLtb := SQLdb.GetTable('SELECT * FROM RSS');    // ORDER BY ID   ORDER BY Pos

  if SQLtb.Count > 0 then
  begin
    SQLtb.MoveLast;
    iID    := SQLtb.FieldAsInteger(SQLtb.FieldIndex['ID']);
  end;
  SQLtb.Free;

 sSQL := 'UPDATE RSS SET Pos='+IntToStr(iID)+' WHERE (ID='+IntToStr(iID)+')';
 ExecSQLUTF8(sSQL);



  TCL(CL.Objects[iCLIndex]).Feed.Add('RSS');
  hIndex:= TCL(CL.Objects[iCLIndex]).Feed.Count - 1;
  TCL(CL.Objects[iCLIndex]).Feed.Objects[hIndex] := TFeed.Create;
  TFeed(TCL(CL.Objects[iCLIndex]).Feed.Objects[hIndex]).ID    := iID;
  TFeed(TCL(CL.Objects[iCLIndex]).Feed.Objects[hIndex]).Style := AddFeed_Style;
  TFeed(TCL(CL.Objects[iCLIndex]).Feed.Objects[hIndex]).Name  := sFeedName;
  TFeed(TCL(CL.Objects[iCLIndex]).Feed.Objects[hIndex]).Topic := sFeedTopic;

  TFeed(TCL(CL.Objects[iCLIndex]).Feed.Objects[hIndex]).LoginName  := CryptText(edtLoginName.Text);
  TFeed(TCL(CL.Objects[iCLIndex]).Feed.Objects[hIndex]).LoginPassword  := CryptText(edtLoginPassword.Text);
{
showmessage(  TSLCLRSS(TSLCL(CL.Objects[iCLIndex]).RSS.Objects[hIndex]).Name  +#13+
  TSLCLRSS(TSLCL(CL.Objects[iCLIndex]).RSS.Objects[hIndex]).Topic );      }

  TFeed(TCL(CL.Objects[iCLIndex]).Feed.Objects[hIndex]).URL   := edtURL.Text;
  TFeed(TCL(CL.Objects[iCLIndex]).Feed.Objects[hIndex]).NextUpdate := 0;
  TFeed(TCL(CL.Objects[iCLIndex]).Feed.Objects[hIndex]).LastUpdate := 0;

  TFeed(TCL(CL.Objects[iCLIndex]).Feed.Objects[hIndex]).Options   := TStringList.Create;
  TFeed(TCL(CL.Objects[iCLIndex]).Feed.Objects[hIndex]).Options.Clear;

  OpenEditContact(iCLIndex,hIndex);

  if chkAddTo.Checked = False then
  begin
    QIPPlugin.AddSpecContact(1, iCLIndex, TCL(CL.Objects[iCLIndex]).SpecCntUniq);
  end;


  Close;

  ExitFunc:
  chkAddTo.Enabled     := bchkAdd;
  cmbAddTo.Enabled     := bcmbAdd;
  edtURL.Enabled       := True;
  btnOK.Enabled        := True;
  btnCancel.Enabled    := True;
  btnURLCheck.Enabled  := True;

  gbLogin.Enabled := True;
  lblLoginName.Enabled := True;
  edtLoginName.Enabled := True;
  lblLoginPassword.Enabled := True;
  edtLoginPassword.Enabled := True;

end;

procedure TfrmAddFeed.chkAddToClick(Sender: TObject);
begin

  if chkAddTo.Checked = True then
    cmbAddTo.Enabled := True
  else
    cmbAddTo.Enabled := False;

end;

procedure TfrmAddFeed.FormClose(Sender: TObject; var Action: TCloseAction);
begin


  AddFeedIsShow := False;
end;

procedure TfrmAddFeed.FormShow(Sender: TObject);
var i: Integer;
begin
  AddFeedIsShow := True;

  Icon := PluginSkin.PluginIcon.Icon;

  Caption := LNG('MENU ContactMenu', 'AddFeed', 'Add feed');
  lblURL.Caption := LNG('FORM EditContact', 'URL', 'URL:');
  lblName.Caption := QIPPlugin.GetLang(LI_NAME)+':';

  chkAddTo.Caption := LNG('FORM AddFeed', 'AddTo', 'Add to:');

  gbLogin.Caption := QIPPlugin.GetLang(LI_LOGIN_SERVICES);
  lblLoginName.Caption := QIPPlugin.GetLang(LI_USER_NAME)+':';
  lblLoginPassword.Caption := QIPPlugin.GetLang(LI_USER_PASS)+':';

  btnOK.Caption := QIPPlugin.GetLang(LI_OK);
  btnCancel.Caption := QIPPlugin.GetLang(LI_CANCEL);


  if CL.Count = 0 then
  begin
    chkAddTo.Enabled := False;
    cmbAddTo.Enabled := False;
  end
  else
  begin
    i:=0;
    while ( i<= CL.Count - 1 ) do
    begin
      Application.ProcessMessages;

      cmbAddTo.Items.Add( TCL(CL.Objects[i]).Name );

      Inc(i);
    end;

    cmbAddTo.ItemIndex := 0;

    chkAddTo.Enabled := True;
    cmbAddTo.Enabled := False;
  end;

  if AddFeed_CLIndex <> -1 then
  begin
    chkAddTo.Checked := True;
    chkAddTo.Enabled := False;
    cmbAddTo.Enabled := False;

    cmbAddTo.ItemIndex := AddFeed_CLIndex;

    if EditContactIsShow = True then    
      FEditContact.Visible := False;
  end;



  if AddFeed_Style = FEED_GMAIL then
  begin
    Caption := LNG('MENU ContactMenu', 'AddEmail', 'Add e-mail') + ' > ' + 'Gmail';
    lblLoginName.Caption := QIPPlugin.GetLang(LI_EMAIL) + ':';
    pnlURL.Visible := False;
    Height := Height - pnlURL.Height;
  end
  else if AddFeed_Style = FEED_RPC_SEZNAM then
  begin
    Caption := LNG('MENU ContactMenu', 'AddEmail', 'Add e-mail') + ' > ' + 'Seznam.cz';
    lblLoginName.Caption := QIPPlugin.GetLang(LI_EMAIL) + ':';
    pnlURL.Visible := False;
    Height := Height - pnlURL.Height;
  end;

  if AddFeed_Type = 0 then
  begin
    pnlName.Visible := False;
    Height := Height - pnlName.Height;
  end
  else
  begin
    edtURL.Text := AddFeed_URL;
    edtName.Text := AddFeed_Name;
        
  end;

end;

end.
