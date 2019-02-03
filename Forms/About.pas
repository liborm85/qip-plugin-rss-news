unit About;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmAbout = class(TForm)
    lblTitle: TLabel;
    lblVersion: TLabel;
    lblAuthor: TLabel;
    Label2: TLabel;
    lblEmail: TLabel;
    lblAuthorEmail: TLabel;
    Label6: TLabel;
    Label1: TLabel;
    lblWeb: TLabel;
    lblPluginWeb: TLabel;
    btnClose: TBitBtn;
    imgIcon: TImage;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure lblAuthorEmailClick(Sender: TObject);
    procedure lblPluginWebClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

uses General, u_lang_ids, uURL;

{$R *.dfm}

procedure TfrmAbout.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAbout.FormClose(Sender: TObject; var Action: TCloseAction);
begin


  AboutIsShow := False;
end;

procedure TfrmAbout.FormShow(Sender: TObject);
begin
  AboutIsShow := True;

  Icon := PluginSkin.PluginIcon.Icon;

  imgIcon.Picture := PluginSkin.PluginIconBig.Picture;

  btnClose.Caption := QIPPlugin.GetLang(LI_Close);

  lblVersion.Caption := QIPPlugin.GetLang(LI_VERSION) + ' ' + PluginVersion;

  lblAuthor.Caption := QIPPlugin.GetLang(LI_AUTHOR) + ':';

  lblEmail.Caption := QIPPlugin.GetLang(LI_EMAIL) + ':';

  lblWeb.Caption := QIPPlugin.GetLang(LI_WEB_SITE) + ':';


end;

procedure TfrmAbout.lblAuthorEmailClick(Sender: TObject);
begin
    LinkUrl( 'mailto:lms.cze7@gmail.com');
end;

procedure TfrmAbout.lblPluginWebClick(Sender: TObject);
begin
  LinkUrl(  lblPluginWeb.Caption );
end;

end.
