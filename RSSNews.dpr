{*************************************}
{                                     }
{       QIP INFIUM SDK                }
{       Copyright(c) Ilham Z.         }
{       ilham@qip.ru                  }
{       http://www.qip.im             }
{                                     }
{*************************************}

library RSSNews;

uses
  u_qip_plugin in 'u_qip_plugin.pas',
  fQIPPlugin in 'fQIPPlugin.pas' {frmQIPPlugin},
  General in 'General.pas',
  BBCode in 'BBCode\BBCode.pas',
  Colors in 'BBCode\Colors.pas' {frmColors},
  uColors in 'BBCode\uColors.pas',
  Convs in 'General\Convs.pas',
  Crypt in 'General\Crypt.pas',
  DownloadFile in 'General\DownloadFile.pas',
  GradientColor in 'General\GradientColor.pas',
  HotKeyManager in 'General\HotKeyManager.pas',
  TextSearch in 'General\TextSearch.pas',
  uFileFolder in 'General\uFileFolder.pas',
  uIcon in 'General\uIcon.pas',
  uImage in 'General\uImage.pas',
  uLinks in 'General\uLinks.pas',
  uLNG in 'General\uLNG.pas',
  uSuperReplace in 'General\uSuperReplace.pas',
  uURL in 'General\uURL.pas',
  u_common in 'QIP Infium SDK\u_common.pas',
  u_lang_ids in 'QIP Infium SDK\u_lang_ids.pas',
  u_plugin_info in 'QIP Infium SDK\u_plugin_info.pas',
  u_plugin_msg in 'QIP Infium SDK\u_plugin_msg.pas',
  DIMime in 'RPC\DIMime.pas',
  XmlRpcClient in 'RPC\XmlRpcClient.pas',
  XmlRpcCommon in 'RPC\XmlRpcCommon.pas',
  XmlRpcTypes in 'RPC\XmlRpcTypes.pas',
  SQLite3 in 'SQLite\SQLite3.pas',
  SQLiteFuncs in 'SQLite\SQLiteFuncs.pas',
  SQLiteTable3 in 'SQLite\SQLiteTable3.pas',
  SQLLibProcs in 'SQLite\SQLLibProcs.pas',
  uCheckRPC in 'Units\uCheckRPC.pas',
  uOptions in 'Units\uOptions.pas',
  LibXmlParser in 'XML\LibXmlParser.pas',
  XMLProcess in 'XML\XMLProcess.pas',
  About in 'Forms\About.pas' {frmAbout},
  AccountSetting in 'Forms\AccountSetting.pas' {frmAccountSetting},
  AddFeed in 'Forms\AddFeed.pas' {frmAddFeed},
  ImportExport in 'Forms\ImportExport.pas' {frmImportExport},
  Options in 'Forms\Options.pas' {frmOptions},
  Window in 'Forms\Window.pas' {frmWindow},
  Hash in 'Updater\Hash.pas',
  KAZip in 'Updater\KAZip.pas',
  MD5 in 'Updater\MD5.pas',
  Updater in 'Updater\Updater.pas' {frmUpdater},
  UpdaterUnit in 'Updater\UpdaterUnit.pas',
  BZIP2 in 'Updater\bzip2\BZIP2.PAS',
  ContactDetails in 'Forms\ContactDetails.pas' {frmContactDetails},
  EditContact in 'Forms\EditContact.pas' {frmEditContact},
  cDateTime in 'Units\cDateTime.pas',
  cUnicodeCodecs in 'Units\cUnicodeCodecs.pas',
  cUtils in 'Units\cUtils.pas',
  cStrings in 'Units\cStrings.pas',
  GraphicColor in 'GraphicEx\GraphicColor.pas',
  GraphicCompression in 'GraphicEx\GraphicCompression.pas',
  GraphicEx in 'GraphicEx\GraphicEx.pas',
  GraphicStrings in 'GraphicEx\GraphicStrings.pas',
  JPG in 'GraphicEx\JPG.pas',
  MZLib in 'GraphicEx\MZLib.pas',
  uINI in 'General\uINI.pas';

{***********************************************************}
function CreateInfiumPLUGIN(PluginService: IQIPPluginService): IQIPPlugin; stdcall;
begin
  Result := TQipPlugin.Create(PluginService);
end;

exports
  CreateInfiumPLUGIN name 'CreateInfiumPLUGIN';

end.
