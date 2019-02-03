unit uOptions;

interface

uses
  SysUtils, Classes, Dialogs, Graphics, Windows, Forms, ExtCtrls;

type
  {OwnFont}
  TOwnFont = record
    OwnFont        : Boolean;
    Font           : TFont;
    FontColor      : WideString;
  end;

  { Enclosure }
  TSLEnclosure = class
  public
    EncsDescription   : WideString;
    EncsUrl           : WideString;
    EncsLength        : WideString;
    EncsType          : WideString;
  end;

  { Options }
  TSLOptions = class
  public
    dataWideString : WideString;
  end;

  procedure LoadFont(sFont: WideString; var fFont: TOwnFont);
  function SaveFont(var fFont: TOwnFont): WideString;
  procedure LoadOptions(sOptions: WideString; var slOptions: TStringList);
  procedure LoadEnclosure(sEnclosure: WideString; var slEnclosure: TStringList);
  function SaveOptions(slOptions: TStringList): WideString;
  function LoadOptionOwn(CLIndex, RSSIndex : Integer; sVariable: WideString; EditContactMode: Integer): WideString;
  function GetOptionFromOptions(sText: WideString; sVariable: WideString): WideString;

  procedure SetMissingOptions(sl: TStringList);

implementation

uses General,   TextSearch;


procedure LoadFont(sFont: WideString; var fFont: TOwnFont);
var //iFS    : Integer;
    sValue : WideString;
    r      : Integer;

begin

  //  Name="Tahoma";Size="8";Color="0";Style="Bold;Italic;Underline;StrikeOut;";

  fFont.Font := TFont.Create;
{
  if sFont='' then
  begin
    fFont := fontDefaultCLFont;
  end;
}
  sValue := FoundStr(sFont,'Name="','";',1{,iFS});
  if sValue<>'' then fFont.Font.Name := sValue;

  sValue := FoundStr(sFont,'Size="','";',1{,iFS});
  if sValue<>'' then fFont.Font.Size := StrToInt( sValue );

  sValue := FoundStr(sFont,'Color="','";',1{,iFS});
  if sValue<>'' then fFont.FontColor := sValue;

  sValue := FoundStr(sFont,'Style="','";',1{,iFS});
  if sValue<>'' then
  begin
    r := StrPosE( sValue, 'Bold;', 1, False);
    if r <> 0 then fFont.Font.Style := fFont.Font.Style + [fsBold];

    r := StrPosE( sValue, 'Italic;', 1, False);
    if r <> 0 then fFont.Font.Style := fFont.Font.Style + [fsItalic];

    r := StrPosE( sValue, 'Underline;', 1, False);
    if r <> 0 then fFont.Font.Style := fFont.Font.Style + [fsUnderline];

    r := StrPosE( sValue, 'StrikeOut;', 1, False);
    if r <> 0 then fFont.Font.Style := fFont.Font.Style + [fsStrikeOut];
  end;

end;


function SaveFont(var fFont: TOwnFont): WideString;
var sResult : WideString;

begin

  //  Name="Tahoma";Size="8";Color="0";Style="Bold;Italic;Underline;StrikeOut;";
  sResult := '';

  sResult := sResult + 'Name="' + fFont.Font.Name + '";';

  sResult := sResult + 'Size="' + IntToStr(fFont.Font.Size) + '";';

  sResult := sResult + 'Color="' + fFont.FontColor + '";';

  sResult := sResult + 'Style="';


  if (fsBold IN fFont.Font.Style) then   sResult := sResult + 'Bold;';
  if (fsItalic IN fFont.Font.Style) then   sResult := sResult + 'Italic;';
  if (fsUnderline IN fFont.Font.Style) then   sResult := sResult + 'Underline;';
  if (fsStrikeOut IN fFont.Font.Style) then   sResult := sResult + 'StrikeOut;';

  sResult := sResult + '";';

  Result := sResult;

end;


procedure LoadOptions(sOptions: WideString; var slOptions: TStringList);
var Pos, Pos2, Pos3, LastPos: Integer;
    hIndex : Integer;
Label Retry;
begin
  slOptions := TStringList.Create;
  slOptions.Clear;

  LastPos:= 1;

  Retry:
  Pos := StrPosE(sOptions,'[',LastPos,False);
  if Pos<>0 then
  begin
    Pos2 := StrPosE(sOptions,']="',Pos,False);
    if Pos2<>0 then
    begin
      Pos3 := StrPosE(sOptions,'";',Pos2+3,False);
      if Pos3<>0 then
      begin
        slOptions.Add(Copy(sOptions,Pos + 1, Pos2 - Pos - 1));
        hIndex:= slOptions.Count - 1;
        slOptions.Objects[hIndex] := TSLOptions.Create;
        TSLOptions(slOptions.Objects[hIndex]).dataWideString := Copy(sOptions,Pos2 + 3, Pos3 - Pos2 - 3);

        LastPos := Pos3 + 2;
        Goto Retry;
      end;

    end;

  end;

end;

procedure LoadEnclosure(sEnclosure: WideString; var slEnclosure: TStringList);
var Pos, LastPos: Integer;
    hIndex, idx : Integer;
    slItms : TStringList;
Label Retry;
begin

  slEnclosure := TStringList.Create;
  slEnclosure.Clear;

  LastPos:= 1;

  Retry:
  Pos := StrPosE(sEnclosure,'<NEXT>',LastPos,False);
  if Pos<>0 then
  begin


    LoadOptions(Copy(sEnclosure,LastPos,Pos - LastPos), slItms);

    slEnclosure.Add( 'enclosure' );
    hIndex:= slEnclosure.Count - 1;
    slEnclosure.Objects[hIndex] := TSLEnclosure.Create;

    idx := slItms.IndexOf('description');
    if idx <> -1 then
      TSLEnclosure(slEnclosure.Objects[hIndex]).EncsDescription := TSLOptions(slItms.Objects[idx]).dataWideString;

    idx := slItms.IndexOf('url');
    if idx <> -1 then
      TSLEnclosure(slEnclosure.Objects[hIndex]).EncsURL         := TSLOptions(slItms.Objects[idx]).dataWideString;

    idx := slItms.IndexOf('length');
    if idx <> -1 then
      TSLEnclosure(slEnclosure.Objects[hIndex]).EncsLength      := TSLOptions(slItms.Objects[idx]).dataWideString;

    idx := slItms.IndexOf('type');
    if idx <> -1 then
      TSLEnclosure(slEnclosure.Objects[hIndex]).EncsType        := TSLOptions(slItms.Objects[idx]).dataWideString;


    LastPos := Pos + 1;
    Goto Retry;
  end else
  begin

    LoadOptions(Copy(sEnclosure,LastPos), slItms);

    slEnclosure.Add( 'enclosure' );
    hIndex:= slEnclosure.Count - 1;
    slEnclosure.Objects[hIndex] := TSLEnclosure.Create;

    idx := slItms.IndexOf('description');
    if idx <> -1 then
      TSLEnclosure(slEnclosure.Objects[hIndex]).EncsDescription := TSLOptions(slItms.Objects[idx]).dataWideString;

    idx := slItms.IndexOf('url');
    if idx <> -1 then
      TSLEnclosure(slEnclosure.Objects[hIndex]).EncsURL         := TSLOptions(slItms.Objects[idx]).dataWideString;

    idx := slItms.IndexOf('length');
    if idx <> -1 then
      TSLEnclosure(slEnclosure.Objects[hIndex]).EncsLength      := TSLOptions(slItms.Objects[idx]).dataWideString;

    idx := slItms.IndexOf('type');
    if idx <> -1 then
      TSLEnclosure(slEnclosure.Objects[hIndex]).EncsType        := TSLOptions(slItms.Objects[idx]).dataWideString;

  end;


end;

function SaveOptions(slOptions: TStringList): WideString;
var i: Integer;
    sResult: WideString;

begin

  sResult := '';

  i:=0;
  while ( i<= slOptions.Count - 1 ) do
  begin

    sResult := sResult +
               '[' + slOptions.Strings[i] + ']="' +
                  TSLOptions(slOptions.Objects[i]).dataWideString +
                  '";';

    Inc(i);
  end;

  Result := sResult

end;


function LoadOptionOwn(CLIndex, RSSIndex : Integer; sVariable: WideString; EditContactMode: Integer): WideString;
var IdxOf: Integer;
begin
  if RSSIndex <> -1 then
  begin
    IdxOf := TFeed(TCL(CL.Objects[CLIndex]).Feed.Objects[RSSIndex]).Options.IndexOf(sVariable);
    if IdxOf <> -1 then // RSS
    begin
      if StrPosE(TSLOptions(TFeed(TCL(CL.Objects[CLIndex]).Feed.Objects[RSSIndex]).Options.Objects[IdxOf]).dataWideString, 'Own;', 1, False) <> 0 then
      begin
        Result := TSLOptions(TFeed(TCL(CL.Objects[CLIndex]).Feed.Objects[RSSIndex]).Options.Objects[IdxOf]).dataWideString;
        Exit;
      end;
    end;
  end;

  if CLIndex <> -1 then
  begin
    IdxOf := TCL(CL.Objects[CLIndex]).Options.IndexOf(sVariable);
    if IdxOf <> -1 then // CL
    begin
      if StrPosE(TSLOptions(TCL(CL.Objects[CLIndex]).Options.Objects[IdxOf]).dataWideString, 'Own;', 1, False) <> 0 then
      begin
        Result := TSLOptions(TCL(CL.Objects[CLIndex]).Options.Objects[IdxOf]).dataWideString;
        if EditContactMode = 2 then
          if Copy(Result,1,4)='Own;' then
            Result := Copy(Result,5);
        Exit;
      end;
    end;
  end;

  IdxOf := GlobalOptions.IndexOf(sVariable);
  if IdxOf <> -1 then // Global
  begin
    Result := TSLOptions(GlobalOptions.Objects[IdxOf]).dataWideString;
    if (EditContactMode = 1) or (EditContactMode = 2) then
      if Copy(Result,1,4)='Own;' then
        Result := Copy(Result,5);
  end;

end;

function GetOptionFromOptions(sText: WideString; sVariable: WideString): WideString;
//var iFS: Integer;
begin

  Result := '';

  if 0 <> StrPosE(sText,sVariable+'=<',1,false) then
    Result := FoundStr(sText,sVariable+'=<','>;',1{,iFS})

end;

procedure SetMissingOptions(sl: TStringList);
var IdxOf: Integer;
begin

  //Notifications
  IdxOf := sl.IndexOf('Notifications');
  if (IdxOf = -1) or (TSLOptions(sl.Objects[IdxOf]).dataWideString='') then
  begin
    sl.Add( 'Notifications' );
    IdxOf:= sl.Count - 1;
    sl.Objects[IdxOf] := TSLOptions.Create;

    TSLOptions(sl.Objects[IdxOf]).dataWideString := 'Own;Tray;Popup;';
  end;

  //Update
  IdxOf := sl.IndexOf('Update');
  if (IdxOf = -1) or (TSLOptions(sl.Objects[IdxOf]).dataWideString='') then
  begin
    sl.Add( 'Update' );
    IdxOf:= sl.Count - 1;
    sl.Objects[IdxOf] := TSLOptions.Create;

    TSLOptions(sl.Objects[IdxOf]).dataWideString := 'Own;Interval=<30>;';
  end;

  //ConLimit
  IdxOf := sl.IndexOf('ConLimit');
  if (IdxOf = -1) or (TSLOptions(sl.Objects[IdxOf]).dataWideString='') then
  begin
    sl.Add( 'ConLimit' );
    IdxOf:= sl.Count - 1;
    sl.Objects[IdxOf] := TSLOptions.Create;

    TSLOptions(sl.Objects[IdxOf]).dataWideString := 'Own;RetryTimes=<2>;Timeout=<3000>;RetryDelay=<4000>;';
  end;

  //GMT
  IdxOf := sl.IndexOf('GMT');
  if (IdxOf = -1) or (TSLOptions(sl.Objects[IdxOf]).dataWideString='') then
  begin
    sl.Add( 'GMT' );
    IdxOf:= sl.Count - 1;
    sl.Objects[IdxOf] := TSLOptions.Create;

    TSLOptions(sl.Objects[IdxOf]).dataWideString := 'Own;GMT=<0>;';
  end;


  //Sort
  IdxOf := sl.IndexOf('Sort');
  if (IdxOf = -1) or (TSLOptions(sl.Objects[IdxOf]).dataWideString='') then
  begin
    sl.Add( 'Sort' );
    IdxOf:= sl.Count - 1;
    sl.Objects[IdxOf] := TSLOptions.Create;

    TSLOptions(sl.Objects[IdxOf]).dataWideString := 'Own;ASC;';
  end;

  //SpecCnt
  IdxOf := sl.IndexOf('SpecCnt');
  if (IdxOf = -1) or (TSLOptions(sl.Objects[IdxOf]).dataWideString='') then
  begin
    sl.Add( 'SpecCnt' );
    IdxOf:= sl.Count - 1;
    sl.Objects[IdxOf] := TSLOptions.Create;

    TSLOptions(sl.Objects[IdxOf]).dataWideString := 'Own;Show-MsgCount;Show-MsgUnreadCount;Show-MsgNewCount;';
  end;

  //Icon
  IdxOf := sl.IndexOf('Icon');
  if (IdxOf = -1) or (TSLOptions(sl.Objects[IdxOf]).dataWideString='') then
  begin
    sl.Add( 'Icon' );
    IdxOf:= sl.Count - 1;
    sl.Objects[IdxOf] := TSLOptions.Create;

    TSLOptions(sl.Objects[IdxOf]).dataWideString := 'Own;';
  end;

  //Logo
  IdxOf := sl.IndexOf('Logo');
  if (IdxOf = -1) or (TSLOptions(sl.Objects[IdxOf]).dataWideString='') then
  begin
    sl.Add( 'Logo' );
    IdxOf:= sl.Count - 1;
    sl.Objects[IdxOf] := TSLOptions.Create;

    TSLOptions(sl.Objects[IdxOf]).dataWideString := 'Own;';
  end;

  //Additional
  IdxOf := sl.IndexOf('Additional');
  if (IdxOf = -1) or (TSLOptions(sl.Objects[IdxOf]).dataWideString='') then
  begin
    sl.Add( 'Additional' );
    IdxOf:= sl.Count - 1;
    sl.Objects[IdxOf] := TSLOptions.Create;

    TSLOptions(sl.Objects[IdxOf]).dataWideString := 'Own;';
  end;
end;
{
procedure xx(slOptions: TStringList; sSearchOption: WideString; var str: WideString);
var IdxOf: Integer;
begin

  IdxOf := slOptions.IndexOf(sSearchOption);
  if IdxOf <> -1 then
    str := TSLOptions(slOptions.Objects[IdxOf]).dataWideString;

end;
}
end.
