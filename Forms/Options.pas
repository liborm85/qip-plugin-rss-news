unit Options;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Buttons, Spin, inifiles;


type
  TfrmOptions = class(TForm)
    pgcOptions: TPageControl;
    tsGeneral: TTabSheet;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    btnApply: TBitBtn;
    lstMenu: TListBox;
    PanelCont: TPanel;
    pnlText: TPanel;
    tsAdditional: TTabSheet;
    FontDialog1: TFontDialog;
    ColorDialog1: TColorDialog;
    lblPluginVersion: TLabel;
    btnAbout: TBitBtn;
    gbLanguage: TGroupBox;
    lblLanguage: TLabel;
    lblInfoTransAuthor: TLabel;
    lblInfoTransEmail: TLabel;
    lblTransAuthor: TLabel;
    lblTransEmail: TLabel;
    lblInfoTransURL: TLabel;
    lblTransURL: TLabel;
    cmbLanguage: TComboBox;
    chkCloseBookmarks: TCheckBox;
    btnVACUUM: TButton;
    gbUpdater: TGroupBox;
    lblUpdaterInterval: TLabel;
    lblUpdaterIntervalUnit: TLabel;
    chkUpdaterCheckingUpdates: TCheckBox;
    edtUpdaterInterval: TEdit;
    udUpdaterInterval: TUpDown;
    btnUpdaterCheckUpdate: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure lstMenuClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure btnUpdateCheckClick(Sender: TObject);
    procedure cmbLanguageChange(Sender: TObject);
    procedure btnVACUUMClick(Sender: TObject);
    procedure btnUpdaterCheckUpdateClick(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }

    procedure ShowTransInfo;
  end;

var
  frmOptions: TfrmOptions;



implementation
uses General, u_lang_ids, uLNG, Convs, TextSearch, UpdaterUnit
, SQLiteFuncs;
{$R *.dfm}

procedure TfrmOptions.ShowTransInfo;
var sAuthor,sEmail,sURL, sTrans, sTransInfo: WideString;
    iFS: Integer;
    INI : TIniFile;
begin
  
  INI := TiniFile.Create(ExtractFilePath(PluginDllPath) +
                         'Langs\' + cmbLanguage.Text + '.lng');

  sTrans := UTF82WideString( INI.ReadString('Info', 'Translator', LNG('Texts','unknown', 'unknown')) );

  Ini.Free;

  iFS := StrPosE(sTrans,' [',1,False);
  sAuthor := Copy(sTrans, 1, iFS);

  sTransInfo := FoundStr(sTrans, ' [', ']', 1{, iFS});

  sEmail := FoundStr(sTransInfo, 'EMAIL="', '"', 1{, iFS});
  sURL := FoundStr(sTransInfo, 'URL="', '"', 1{, iFS});

  lblTransAuthor.Caption  :=  sAuthor;

  sEmail := Trim(sEmail);
  sURL := Trim(sURL);

  if sEmail<>'' then
  begin
    lblTransEmail.Enabled   := True;
    lblTransEmail.Caption   := sEmail;
  end
  else
  begin
    lblTransEmail.Enabled   := False;
    lblTransEmail.Caption   := LNG('Texts','unknown', 'unknown');
  end;

  if sURL<>'' then
  begin
    lblTransURL.Enabled   := True;
    lblTransURL.Caption   := sURL;
  end
  else
  begin
    lblTransURL.Enabled   := False;
    lblTransURL.Caption   := LNG('Texts','unknown', 'unknown');
  end;


end;

procedure TfrmOptions.btnAboutClick(Sender: TObject);
begin
  OpenAbout;
end;

procedure TfrmOptions.btnApplyClick(Sender: TObject);
var
    INI : TIniFile;
begin
  // Button Apply

  CheckUpdates := chkUpdaterCheckingUpdates.Checked;
  CheckUpdatesInterval := ConvStrToInt( edtUpdaterInterval.Text );



  PluginLanguage := cmbLanguage.Text;
  CloseBookmarks := chkCloseBookmarks.Checked;

  INI := TiniFile.Create(ExtractFilePath(PluginDllPath) + Account_FileName + '.ini');

  INI.WriteString('Conf', 'Language', WideString2UTF8(PluginLanguage));

  INI.WriteInteger('Conf', 'CheckUpdates', BoolToInt(CheckUpdates));
  INI.WriteInteger('Conf', 'CheckUpdatesInterval', CheckUpdatesInterval);

  INI.WriteInteger('Conf', 'CloseBookmarks', BoolToInt(CloseBookmarks));


  INI.Free;




end;

procedure TfrmOptions.btnOKClick(Sender: TObject);
begin
  // Button OK

  btnApplyClick(Sender);
  Close;

end;

procedure TfrmOptions.btnUpdateCheckClick(Sender: TObject);
begin
  CheckNewVersion(True);
end;

procedure TfrmOptions.btnUpdaterCheckUpdateClick(Sender: TObject);
begin
  CheckNewVersion(True);
end;

procedure TfrmOptions.btnVACUUMClick(Sender: TObject);
begin
  ExecSQLUTF8('VACUUM');
  ShowMessage('Complete.');
end;

procedure TfrmOptions.cmbLanguageChange(Sender: TObject);
begin
  ShowTransInfo;
end;

procedure TfrmOptions.btnCancelClick(Sender: TObject);
begin
  // Button Cancel
  Close;
end;

procedure TfrmOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  OptionsIsShow := False;
end;

procedure TfrmOptions.FormShow(Sender: TObject);
var i: Integer;
    rec: TSearchRec;
    LngPath: WideString;
begin
  OptionsIsShow := True;

  Icon := PluginSkin.PluginIcon.Icon;

  Caption := QIPPlugin.GetLang(LI_OPTIONS) + ': RSS News';

  btnOK.Caption := QIPPlugin.GetLang(LI_OK);
  btnCancel.Caption := QIPPlugin.GetLang(LI_CANCEL);
  btnApply.Caption := QIPPlugin.GetLang(LI_APPLY);


  pgcOptions.Pages[0].Caption := QIPPlugin.GetLang(LI_GENERAL);
  pgcOptions.Pages[1].Caption := QIPPlugin.GetLang(LI_ADDITIONAL);

  lblPluginVersion.Caption := QIPPlugin.GetLang(LI_VERSION) + ' ' + PluginVersion;

  btnAbout.Caption := LNG('MENU ContactMenu', 'AboutPlugin', 'About plugin...');



  lblInfoTransAuthor.Caption := QIPPlugin.GetLang(LI_AUTHOR) + ':';
  lblInfoTransEmail.Caption := QIPPlugin.GetLang(LI_EMAIL) + ':';
  lblInfoTransURL.Caption := QIPPlugin.GetLang(LI_WEB_SITE) + ':';

  gbLanguage.Caption := QIPPlugin.GetLang(LI_LANGUAGE);
  lblLanguage.Caption := QIPPlugin.GetLang(LI_LANGUAGE)+':';

  //--- nastavení Updater
  gbUpdater.Caption                 := LNG('FORM Options', 'General.Updates', 'Updater');
  chkUpdaterCheckingUpdates.Caption := LNG('FORM Options', 'General.CheckingUpdates', 'Checking updates');
  lblUpdaterInterval.Caption        := LNG('FORM Options', 'General.CheckingUpdates.Interval', 'Interval') + ':';
  lblUpdaterIntervalUnit.Caption    := QIPPlugin.GetLang(LI_HOURS);//LNG('FORM Options', 'General.CheckingUpdates.Interval.Unit', 'hours');
  btnUpdaterCheckUpdate.Caption     := QIPPlugin.GetLang(LI_CHECK);
  edtUpdaterInterval.Left     := lblUpdaterInterval.Left + lblUpdaterInterval.Width + 4;
  udUpdaterInterval.Left      := edtUpdaterInterval.Left + edtUpdaterInterval.Width;
  lblUpdaterIntervalUnit.Left := udUpdaterInterval.Left + udUpdaterInterval.Width + 4;
  btnUpdaterCheckUpdate.Left  := lblUpdaterIntervalUnit.Left + lblUpdaterIntervalUnit.Width + 4;
  //--

  // èasový interval aktualizací
  chkUpdaterCheckingUpdates.Checked := CheckUpdates;
  edtUpdaterInterval.Text := IntToStr( CheckUpdatesInterval );
  udUpdaterInterval.Position := CheckUpdatesInterval;


  LngPath := ExtractFilePath(PluginDllPath) + 'Langs\';

  if FindFirst(LngPath + '*.lng', faAnyFile, rec) = 0 then
  begin

    cmbLanguage.Items.Add( Copy( rec.name, 1 , Length(rec.name) -  Length(ExtractFileExt( rec.name)))) ;
    if cmbLanguage.Items[cmbLanguage.Items.Count - 1] = PluginLanguage then
      cmbLanguage.ItemIndex := cmbLanguage.Items.Count - 1;

    While FindNext(rec) = 0 do
    begin

      cmbLanguage.Items.Add( Copy( rec.name, 1 , Length(rec.name) -  Length(ExtractFileExt( rec.name)))) ;
      if cmbLanguage.Items[cmbLanguage.Items.Count - 1] = PluginLanguage then
        cmbLanguage.ItemIndex := cmbLanguage.Items.Count - 1;


    end;

  end;

  cmbLanguage.Text := PluginLanguage;

  ShowTransInfo;


  chkCloseBookmarks.Checked := CloseBookmarks;









  i:=0;
  while ( i<= pgcOptions.PageCount - 1 ) do
  begin
    pgcOptions.Pages[i].TabVisible := false;
    lstMenu.Items.Add ( pgcOptions.Pages[i].Caption );
    
    Inc(i);
  end;


  pgcOptions.ActivePageIndex:=0;
  lstMenu.ItemIndex := 0;
  pnlText.Caption := lstMenu.Items[lstMenu.ItemIndex];

end;

procedure TfrmOptions.lstMenuClick(Sender: TObject);
begin
  pgcOptions.ActivePageIndex := lstMenu.ItemIndex;

  pnlText.Caption := lstMenu.Items[lstMenu.ItemIndex];

end;

end.
