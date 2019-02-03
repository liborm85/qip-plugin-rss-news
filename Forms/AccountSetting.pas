unit AccountSetting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfrmAccountSetting = class(TForm)
    lblSharedAccount: TLabel;
    lblPersonalAccount: TLabel;
    lblLanguage: TLabel;
    rbSharedAccount: TRadioButton;
    rbPersonalAccount: TRadioButton;
    btnStart: TBitBtn;
    cmbLanguage: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnStartClick(Sender: TObject);
    procedure cmbLanguageChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    procedure FormTranslate;
  end;

var
  frmAccountSetting: TfrmAccountSetting;

implementation

uses General, uLNG;

{$R *.dfm}

procedure TfrmAccountSetting.FormTranslate;
begin
  lblLanguage.Caption       := LNG('FORM SettingsAccount', 'Language', 'Language:');

  rbSharedAccount.Caption   := LNG('FORM SettingsAccount', 'SharedAccount', 'Start with shared account');
  lblSharedAccount.Caption  := LNG('FORM SettingsAccount', 'SharedAccount.Info', 'Using shared settings and data storage.');

  rbPersonalAccount.Caption := LNG('FORM SettingsAccount', 'PersonalAccount', 'Start width personal account');
  lblPersonalAccount.Caption:= LNG('FORM SettingsAccount', 'PersonalAccount.Info', 'Using separate settings for each users.');

  btnStart.Caption          := LNG('FORM SettingsAccount', 'Start', 'Start');
end;

procedure TfrmAccountSetting.btnStartClick(Sender: TObject);
begin
  if rbSharedAccount.Checked = True then
    SharedAccount := True
  else
    SharedAccount := False;


  PluginLanguage := cmbLanguage.Text;

  Close;
end;

procedure TfrmAccountSetting.cmbLanguageChange(Sender: TObject);
begin
  PluginLanguage := cmbLanguage.Text;

  FormTranslate;
end;

procedure TfrmAccountSetting.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  AccountSettingIsShow := False;
end;

procedure TfrmAccountSetting.FormShow(Sender: TObject);
var rec: TSearchRec;
    LngPath: WideString;
begin
  AccountSettingIsShow := True;

  Caption := 'RSS News ' + PluginVersion;

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

  FormTranslate;

end;

end.
