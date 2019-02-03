unit ContactDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmContactDetails = class(TForm)
    lblTitle: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    lblLastUpdate: TLabel;
    lblNextUpdate: TLabel;
    Label3: TLabel;
    lblEncoderName: TLabel;
    lblEncoderVersion: TLabel;
    lblCodepage: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    lblMsgCount: TLabel;
    Label6: TLabel;
    lblMsgUnreadCount: TLabel;
    Label8: TLabel;
    lblMsgNewCount: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmContactDetails: TfrmContactDetails;

implementation

uses General, u_lang_ids;

{$R *.dfm}

procedure TfrmContactDetails.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin


  ContactDetailsIsShow := False;
end;

procedure TfrmContactDetails.FormShow(Sender: TObject);
begin
  ContactDetailsIsShow := True;

  Icon := PluginSkin.PluginIcon.Icon;

  Caption := QIPPlugin.GetLang(LI_USER_DETAILS);

  if ContactDetails_RSSIndex = -1 then
  begin
    lblTitle.Caption  := TCL(CL.Objects[ContactDetails_CLIndex]).Name;

    lblLastUpdate.Caption  := '?';
    lblNextUpdate.Caption  := '?';

    lblEncoderName.Caption     := '?';
    lblEncoderVersion.Caption  := '?';

    lblCodepage.Caption    := '?';

    lblMsgCount.Caption := '?';
    lblMsgUnreadCount.Caption := '?';
    lblMsgNewCount.Caption := '?';
  end
  else
  begin
    lblTitle.Caption  := TFeed(TCL(CL.Objects[ContactDetails_CLIndex]).Feed.Objects[ContactDetails_RSSIndex]).Name;

    lblLastUpdate.Caption  := FormatDateTime('dd.mm.yyyy hh:mm:ss',TFeed(TCL(CL.Objects[ContactDetails_CLIndex]).Feed.Objects[ContactDetails_RSSIndex]).LastUpdate);
    lblNextUpdate.Caption  := FormatDateTime('dd.mm.yyyy hh:mm:ss',TFeed(TCL(CL.Objects[ContactDetails_CLIndex]).Feed.Objects[ContactDetails_RSSIndex]).NextUpdate);

    lblEncoderName.Caption     := TFeed(TCL(CL.Objects[ContactDetails_CLIndex]).Feed.Objects[ContactDetails_RSSIndex]).Encoder;
    lblEncoderVersion.Caption  := TFeed(TCL(CL.Objects[ContactDetails_CLIndex]).Feed.Objects[ContactDetails_RSSIndex]).EncoderVer;

    lblCodepage.Caption    := TFeed(TCL(CL.Objects[ContactDetails_CLIndex]).Feed.Objects[ContactDetails_RSSIndex]).Codepage;

    lblMsgCount.Caption := IntToStr( TFeed(TCL(CL.Objects[ContactDetails_CLIndex]).Feed.Objects[ContactDetails_RSSIndex]).MsgsCount.MsgCount );
    lblMsgUnreadCount.Caption := IntToStr( TFeed(TCL(CL.Objects[ContactDetails_CLIndex]).Feed.Objects[ContactDetails_RSSIndex]).MsgsCount.MsgUnreadCount );
    lblMsgNewCount.Caption := IntToStr( TFeed(TCL(CL.Objects[ContactDetails_CLIndex]).Feed.Objects[ContactDetails_RSSIndex]).MsgsCount.MsgNewCount );
  end;

end;

end.
