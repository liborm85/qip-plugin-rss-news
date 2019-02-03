{*************************************}
{                                     }
{       QIP INFIUM SDK                }
{       Copyright(c) Ilham Z.         }
{       ilham@qip.ru                  }
{       http://www.qip.im             }
{                                     }
{*************************************}

unit u_qip_plugin;

interface

uses Windows, SysUtils, {ExtCtrls,} u_plugin_info, u_plugin_msg, u_common;

const
  PLUGIN_VER_MAJOR    = 0;
  PLUGIN_VER_MINOR    = 3;
  PLUGIN_VER_RELEASE  = 6;
  PLUGIN_VER_BUILD    = 6;
  PLUGIN_VER_BETA     : WideString = ''; // defaultnì ''; jsem se píše Alfa, Beta, apod.
  PLUGIN_NAME      : WideString = 'RSS News';
  PLUGIN_AUTHOR    : WideString = 'Lms';

type
  TQipPlugin = class(TInterfacedObject, IQIPPlugin)
  private
    FPluginSvc      : IQIPPluginService;
    FPluginInfo     : TPluginInfo;
    FDllPath        : WideString;
    procedure LoadSuccess;
    procedure CreateQIPPlugin;
    procedure FreeQIPPlugin;

  public
    {+++ create/destroy +++++++++++++++++++++++}
    constructor Create(const PluginService: IQIPPluginService);
    destructor  Destroy; override;
    {+++ IQIPPlugin interface funcs. Qip Core will use it to get info and send messages +++}
    function  GetPluginInfo: pPluginInfo; stdcall;
    procedure OnQipMessage(var PlugMsg: TPluginMessage); stdcall;
  end;

implementation

uses Dialogs, {Graphics, Forms, Types, u_lang_ids, DateUtils,} General, fQIPPlugin;

{ TQipPlugin }
{***********************************************************}
constructor TQipPlugin.Create(const PluginService: IQIPPluginService);
begin
  FPluginSvc := PluginService;
end;

{***********************************************************}
destructor TQipPlugin.Destroy;
begin
  inherited;
end;

{***********************************************************}
function TQipPlugin.GetPluginInfo: pPluginInfo;
begin
  Result := @FPluginInfo;
end;

{***********************************************************}
procedure TQipPlugin.OnQipMessage(var PlugMsg: TPluginMessage);
begin

  case PlugMsg.Msg of
    PM_PLUGIN_LOAD_SUCCESS    : LoadSuccess;
    PM_PLUGIN_RUN             : begin
                                  CreateQIPPlugin;

                                  QIPPlugin.CreateControls;
                                  QIPPlugin.LoadPluginOptions;
                                end;
    PM_PLUGIN_QUIT            : begin
                                  QIPPlugin.SavePluginOptions;
                                  QIPPlugin.FreeControls;

                                  FreeQIPPlugin;
                                end;
    PM_PLUGIN_DISABLE         : begin
                                  QIPPlugin.FreeControls;

                                  FreeQIPPlugin;                                  
                                end;
    PM_PLUGIN_ENABLE          : begin
                                  CreateQIPPlugin;

                                  QIPPlugin.CreateControls;
                                  QIPPlugin.LoadPluginOptions;
                                end;
    PM_PLUGIN_OPTIONS         : QIPPlugin.ShowPluginOptions;
    PM_PLUGIN_WRONG_SDK_VER   : ShowMessage('Wrong SDK version.'+#13+'Please update QIP Infium.');

//    PM_PLUGIN_SPELL_CHECK     : QIPPlugin.SpellCheck(PlugMsg);
//    PM_PLUGIN_SPELL_POPUP     : QIPPlugin.SpellPopup(PlugMsg);
//    PM_PLUGIN_XSTATUS_CHANGED : QIPPlugin.XstatusChangedByUser(PlugMsg);
    PM_PLUGIN_SOUND_CHANGED   : QIPPlugin.QipSoundChanged(PlugMsg);
//    PM_PLUGIN_MSG_RCVD        : QIPPlugin.InstantMsgRcvd(PlugMsg);
//    PM_PLUGIN_MSG_SEND        : QIPPlugin.InstantMsgSend(PlugMsg);
//    PM_PLUGIN_MSG_RCVD_NEW    : QIPPlugin.NewMessageFlashing(PlugMsg);
//    PM_PLUGIN_MSG_RCVD_READ   : QIPPlugin.NewMessageStopFlashing(PlugMsg);
//    PM_PLUGIN_CAN_ADD_BTNS    : QIPPlugin.AddNeededBtns(PlugMsg);
//    PM_PLUGIN_MSG_BTN_CLICK   : QIPPlugin.MsgBtnClicked(PlugMsg);
//    PM_PLUGIN_SPEC_RCVD       : QIPPlugin.SpecMsgRcvd(PlugMsg);
    PM_PLUGIN_ANTIBOSS        : QIPPlugin.AntiBoss(Boolean(PlugMsg.WParam));
    PM_PLUGIN_CURRENT_LANG    : QIPPlugin.CurrentLanguage(PWideChar(PlugMsg.WParam));
//    PM_PLUGIN_STATUS_CHANGED  : QIPPlugin.StatusChanged(PlugMsg);
//    PM_PLUGIN_RCVD_IM         : QIPPlugin.ImRcvdSuccess(PlugMsg);
//    PM_PLUGIN_CONTACT_STATUS  : QIPPlugin.ContactStatusRcvd(PlugMsg);
//    PM_PLUGIN_CHAT_TAB        : QIPPlugin.ChatTabAction(PlugMsg);
//    PM_PLUGIN_CHAT_CAN_BTNS   : QIPPlugin.AddNeededChatBtns(PlugMsg);
//    PM_PLUGIN_CHAT_BTN_CLICK  : QIPPlugin.ChatBtnClicked(PlugMsg);
//    PM_PLUGIN_CHAT_MSG_RCVD   : QIPPlugin.ChatMsgRcvd(PlugMsg);
//    PM_PLUGIN_CHAT_SENDING    : QIPPlugin.ChatMsgSending(PlugMsg);
    PM_PLUGIN_SPEC_DRAW_CNT   : QIPPlugin.DrawSpecContact(PlugMsg);
    PM_PLUGIN_SPEC_DBL_CLICK  : QIPPlugin.SpecContactDblClick(PlugMsg);
    PM_PLUGIN_SPEC_RIGHT_CLK  : QIPPlugin.SpecContactRightClick(PlugMsg);
    PM_PLUGIN_FADE_CLICK      : QIPPlugin.LeftClickOnFadeMsg(PlugMsg);
    PM_PLUGIN_HINT_GET_WH     : QIPPlugin.GetSpecContactHintSize(PlugMsg);
    PM_PLUGIN_HINT_DRAW       : QIPPlugin.DrawSpecContactHint(PlugMsg);
  end;//case

end;

{***********************************************************}
procedure TQipPlugin.LoadSuccess;
var buf      : array[0..MAX_PATH] of WideChar;
begin
  {Getting and updating Plugin dll path and filling FProtoInfo record}
  GetModuleFileNameW(FPluginInfo.DllHandle, buf, SizeOf(buf));
  FDllPath := buf;
  FPluginInfo.DllPath          := PWideChar(FDllPath);

  FPluginInfo.QipSdkVerMajor   := QIP_SDK_VER_MAJOR;
  FPluginInfo.QipSdkVerMinor   := QIP_SDK_VER_MINOR;
  FPluginInfo.PlugVerMajor     := PLUGIN_VER_MAJOR;
  FPluginInfo.PlugVerMinor     := PLUGIN_VER_MINOR;
  FPluginInfo.PluginName       := PWideChar(PLUGIN_NAME);
  FPluginInfo.PluginAuthor     := PWideChar(PLUGIN_AUTHOR);

  PluginDllPath                := FDllPath;

  PluginVersion := IntToStr( PLUGIN_VER_MAJOR ) +  '.' + IntToStr( PLUGIN_VER_MINOR ) + '.' + IntToStr( PLUGIN_VER_RELEASE );
  if PLUGIN_VER_BUILD<>0 then PluginVersion := PluginVersion + '.' + IntToStr( PLUGIN_VER_BUILD )

end;

{***********************************************************}
procedure TQipPlugin.CreateQIPPlugin;
begin

  QIPPlugin := TfrmQIPPlugin.Create(nil);
  QIPPlugin.Height := 0;
  QIPPlugin.Width := 0;
  QIPPlugin.PluginSvc  := @FPluginSvc;
  QIPPlugin.DllHandle  := FPluginInfo.DllHandle;
  QIPPlugin.DllPath    := FDllPath;
  SetWindowPos(QIPPlugin.Handle,HWND_BOTTOM,0,0,0,0,SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);

end;

{***********************************************************}
procedure TQipPlugin.FreeQIPPlugin;
begin
  if Assigned(QIPPlugin) then FreeAndNil(QIPPlugin);
end;


end.


