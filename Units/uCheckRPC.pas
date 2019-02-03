unit uCheckRPC;

interface

uses
  SysUtils, Classes, Dialogs, Graphics, Windows, Forms, ExtCtrls,
  xmlrpctypes, xmlrpcclient;

  procedure CheckRPC(CLPos: Integer; RSSPos: Integer);

implementation

uses General, Crypt, Convs, TextSearch, MD5, SQLiteFuncs, uOptions, uSuperReplace,
 SQLiteTable3;

procedure CheckRPC(CLPos: Integer; RSSPos: Integer);
var
  RpcCaller: TRpcCaller;
  RpcFunction: IRpcFunction;
  RpcResult: IRpcResult;
  i, ii: Integer;
  sEmailName,sEmailServer: WideString;
  sSQL : WideString;

  SQLtb     : TSQLiteTable;

    sMsgText : WideString;

    slSuperReplace: TStringList;
    hslIndex: Integer;

    bNoAutCl : Boolean;
    iClTime  : Integer;
    sValue: WideString;
begin

  ExtractEmail(EncryptText(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).LoginName), sEmailName, sEmailServer);

  if (sEmailName = '') or (sEmailServer='') then
  begin
    TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).Error := True;
    TCL(CL.Objects[CLPos]).Error := True;
    Exit;
  end;


  RpcCaller := TRpcCaller.Create;
  try

//       ExtractEmail

//    TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).Error

  //  RpcCaller.ProxyName := 'fli4l.int.europa.de';
  //  RpcCaller.ProxyPort := 3128;



    RpcCaller.EndPoint := '';
    RpcCaller.HostName := 'notify.seznam.cz';
    RpcCaller.HostPort := 80;

    RpcFunction := TRpcFunction.Create;
    RpcFunction.Clear;
    RpcFunction.ObjectMethod := 'authUser';
    RpcFunction.AddItem(sEmailName);
    RpcFunction.AddItem(sEmailServer);
    RpcFunction.AddItem(StrMD5(EncryptText(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).LoginPassword)));  // HESLO MD5

    RpcResult := RpcCaller.Execute(RpcFunction);
{showmessage(
booltostr(
RpcResult.IsError
)
);   }
//showmessage(inttostr(RpcResult.AsStruct.Count));
    if RpcResult.AsStruct.Count = 0 then
    begin
      TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).Error := True;
      TCL(CL.Objects[CLPos]).Error := True;
      Exit;
    end
    else if RpcResult.AsStruct.Items[0].IsInteger = True then
    begin
      TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).Error := True;
      TCL(CL.Objects[CLPos]).Error := True;
      Exit;
    end;
                {
    if RpcResult.AsStruct.Count = 0 then
    begin
      TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).Error := True;
      TCL(CL.Objects[CLPos]).Error := True;
      RpcCaller.Free;
      Exit;
    end
    else
    begin
      if RpcResult.AsStruct.Items[0].IsInteger = True then
      begin
        TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).Error := True;
        TCL(CL.Objects[CLPos]).Error := True;
        RpcCaller.Free;
        Exit;
      end;
    end;
            }

                      {

    for i := 0 to RpcResult.AsStruct.Count - 1 do
    begin
     if RpcResult.AsStruct.Items[i].IsString = true then
        showmessage(    RpcResult.AsStruct.Items[i].AsString  )
      else if RpcResult.AsStruct.Items[i].IsInteger = true then
        showmessage(  inttostr(  RpcResult.AsStruct.Items[i].AsInteger) )
      else
        showmessage('unknown')
    end;
                                                           }
//                  showmessage('DRUHE   2');

    RpcFunction := TRpcFunction.Create;
    RpcFunction.Clear;
    RpcFunction.ObjectMethod := 'biff';
    RpcFunction.AddItem(sEmailName);
    RpcFunction.AddItem(sEmailServer);
    RpcFunction.AddItem(StrMD5(EncryptText(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).LoginPassword)));  // HESLO MD5
    RpcFunction.AddItem(0);


    RpcResult := RpcCaller.Execute(RpcFunction);


    if RpcResult.AsStruct.Count = 0 then
    begin
      TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).Error := True;
      TCL(CL.Objects[CLPos]).Error := True;
      Exit;
    end
    else if RpcResult.AsStruct.Items[0].IsInteger = True then
    begin
      TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).Error := True;
      TCL(CL.Objects[CLPos]).Error := True;
      Exit;
    end;

        
     {
     0 - text
     1 - odesilatel
     2 - cisla, indexy?
     3 - 1  ???
     4 - 200 ???
     5 - OK
     6 - predmet
     7 - 1218493254
     8 - 587
     9 - 428 - pocet novych zprav
     }



     for i:= 0 to RpcResult.AsStruct.Items[0].AsArray.Count - 1 do
     begin

        SQLtb := SQLdb.GetTable(WideString2UTF8( 'SELECT * FROM Data WHERE '+
                              'RSSID=' + IntToStr(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).ID) +
                            ' and title='+''''+ TextToSQLText(UTF82WideString( RpcResult.AsStruct.Items[6].AsArray.Items[i].AsString))+''''+
                          ' and description='+''''+ TextToSQLText(UTF82WideString( RpcResult.AsStruct.Items[0].AsArray.Items[i].AsString) )+''''+
                          ' and author='+''''+ TextToSQLText('[name]="'+UTF82WideString( RpcResult.AsStruct.Items[1].AsArray.Items[i].AsString)+'";' )+''''+
                          ' and pubDate='+''''+ TextToSQLText('')+''''+
                          ' and guid='+''''+ TextToSQLText(IntToStr(RpcResult.AsStruct.Items[2].AsArray.Items[i].AsInteger))+''''
                            )  );

        if SQLtb.Count > 0 then    // FOUND
        begin

        end
        else          //NOT FOUND
        begin

          TCL(CL.Objects[CLpos]).NewItems := True;
          TCL(CL.Objects[CLpos]).NewItemsWasNotif := False;
          TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).NewItems := True;
          TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).NewItemsWasNotif := False;



          sSQL := 'INSERT INTO Data(RSSID, Archive, State, title, link, description, pubDate, enclosure, summary, author, category, comments, guid) VALUES ' +
                     '(' + IntToStr(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).ID) +', '+
                           IntToStr(0) + ', '+
                           IntToStr(1) + ', '+
                     ''''+TextToSQLText(UTF82WideString( RpcResult.AsStruct.Items[6].AsArray.Items[i].AsString) )+''''+', '+
                     ''''+TextToSQLText('')+''''+', '+
                     ''''+TextToSQLText(UTF82WideString( RpcResult.AsStruct.Items[0].AsArray.Items[i].AsString) )+''''+', '+
                     ''''+TextToSQLText('')+''''+', '+
                     ''''+TextToSQLText('')+''''+', '+
                     ''''+TextToSQLText('')+''''+', '+
                     ''''+TextToSQLText('[name]="'+UTF82WideString( RpcResult.AsStruct.Items[1].AsArray.Items[i].AsString)+'";' )+''''+', '+
                     ''''+TextToSQLText('')+''''+', '+
                     ''''+TextToSQLText('')+''''+', '+
                     ''''+TextToSQLText(IntToStr(RpcResult.AsStruct.Items[2].AsArray.Items[i].AsInteger))+''''+');';

          ExecSQLUTF8(sSQL);


          Inc(TFeed(TCL(CL.Objects[CLpos]).Feed.Objects[RSSpos]).MsgsCount.MsgNewCount);
          Inc(TFeed(TCL(CL.Objects[CLpos]).Feed.Objects[RSSpos]).MsgsCount.MsgUnreadCount);
          Inc(TFeed(TCL(CL.Objects[CLpos]).Feed.Objects[RSSpos]).MsgsCount.MsgCount);



            if RSSNewsStatus = 2 then
              ///
            else
            begin
              sValue := LoadOptionOwn(CLpos,RSSpos,'Notifications', -1);


              if StrPosE(sValue,'Popup;',1,False) <> 0 then
              begin
                if StrPosE(sValue,'Popup-MsgText;',1,False) <> 0 then
                begin

                  slSuperReplace := TStringList.Create;
                  slSuperReplace.Clear;

                  slSuperReplace.Add('ITEM');
                  hslIndex:= slSuperReplace.Count - 1;
                  slSuperReplace.Objects[hslIndex] := TSuperReplace.Create;
                  TSuperReplace(slSuperReplace.Objects[hslIndex]).Command    := '%FEEDNAME%';
                  TSuperReplace(slSuperReplace.Objects[hslIndex]).Value      := TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).Name;

                  slSuperReplace.Add('ITEM');
                  hslIndex:= slSuperReplace.Count - 1;
                  slSuperReplace.Objects[hslIndex] := TSuperReplace.Create;
                  TSuperReplace(slSuperReplace.Objects[hslIndex]).Command    := '%MSGTITLE%';
                  TSuperReplace(slSuperReplace.Objects[hslIndex]).Value      := UTF82WideString( RpcResult.AsStruct.Items[6].AsArray.Items[i].AsString);

                  slSuperReplace.Add('ITEM');
                  hslIndex:= slSuperReplace.Count - 1;
                  slSuperReplace.Objects[hslIndex] := TSuperReplace.Create;
                  TSuperReplace(slSuperReplace.Objects[hslIndex]).Command    := '%MSGDESCRIPTION%';


                  TSuperReplace(slSuperReplace.Objects[hslIndex]).Value      := UTF82WideString( RpcResult.AsStruct.Items[0].AsArray.Items[i].AsString);


                  slSuperReplace.Add('ITEM');
                  hslIndex:= slSuperReplace.Count - 1;
                  slSuperReplace.Objects[hslIndex] := TSuperReplace.Create;
                  TSuperReplace(slSuperReplace.Objects[hslIndex]).Command    := '%MSGDATETIME%';

                  TSuperReplace(slSuperReplace.Objects[hslIndex]).Value      := '';


                  slSuperReplace.Add('ITEM');
                  hslIndex:= slSuperReplace.Count - 1;
                  slSuperReplace.Objects[hslIndex] := TSuperReplace.Create;
                  TSuperReplace(slSuperReplace.Objects[hslIndex]).Command    := '%MSGAUTHOR%';

                  TSuperReplace(slSuperReplace.Objects[hslIndex]).Value      := UTF82WideString( RpcResult.AsStruct.Items[1].AsArray.Items[i].AsString);


                  sMsgText := SuperReplace(TextNewEmail,slSuperReplace);

{                 if TRSSData(RSSData.Objects[i]).Description='' then
                    sMsgText := 'Nové zprávy v: ' + TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).Name + #13 +
                            TRSSData(RSSData.Objects[i]).Title + #13 + TRSSData(RSSData.Objects[i]).summary
                  else
                    sMsgText := 'Nové zprávy v: ' + TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).Name + #13 +
                            TRSSData(RSSData.Objects[i]).Title + #13 + TRSSData(RSSData.Objects[i]).Description;
}

                  bNoAutCl := False;
                  iClTime  := 0;

                  if StrPosE(sValue,'Popup-NoAutoClose;',1,False) <> 0 then
                    bNoAutCl := True
                  else
                    iClTime := ConvStrToInt( GetOptionFromOptions(sValue,'Popup-CloseTime') );

                  QIPPlugin.AddFadeMsg(0,
                                     PluginSkin.PluginIcon.Icon.Handle,
                                     'RSS News',
                                     sMsgText,
                                     False,
                                     bNoAutCl,
                                     iClTime,
                                     0);


                end;

              end;

            end;

        end;

        SQLtb.Free;

     end;










                        {


    for i := 0 to RpcResult.AsStruct.Count - 1 do
    begin
      if RpcResult.AsStruct.Items[i].IsString = true then
        showmessage( IntToStr(i) +#13 +    RpcResult.AsStruct.Items[i].AsString  )
      else if RpcResult.AsStruct.Items[i].IsInteger = true then
        showmessage( IntToStr(i) +#13 + inttostr(  RpcResult.AsStruct.Items[i].AsInteger) )
      else if RpcResult.AsStruct.Items[i].IsArray = true then
      begin
          ShowMessage(IntToStr(i) +#13 +'NEW ARRAY');
        for ii:= 0 to RpcResult.AsStruct.Items[i].AsArray.Count - 1 do
        begin

          if RpcResult.AsStruct.Items[i].AsArray.Items[ii].IsString = true then
            showmessage('ARRAY:  ' + RpcResult.AsStruct.Items[i].AsArray.Items[ii].AsString )
          else if RpcResult.AsStruct.Items[i].AsArray.Items[ii].IsInteger = true then
            showmessage('ARRAY:  ' +      inttostr(  RpcResult.AsStruct.Items[i].AsArray.Items[ii].AsInteger) )
          else if RpcResult.AsStruct.Items[i].AsArray.Items[ii].IsArray = true then
            showmessage('ARRAY: ARRAY')
          else
            showmessage('ARRAY: unknown')
        end;
      end
      else
        showmessage(IntToStr(i) +#13 +'unknown')
    end;
                          }

  finally
    RpcCaller.Free;
  end;







end;

end.
