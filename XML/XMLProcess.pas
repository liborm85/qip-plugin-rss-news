unit XMLProcess;

interface

uses
  SysUtils, Classes, Dialogs, Graphics, Windows, Forms, ExtCtrls, General,
  LibXmlParser  ;
  
type
  { XML Attrs }
  TXMLAttrs = class
  public
    dataWideString : WideString;
  end;

  { RSS Data }
  TRSSData = class
  public
    ID             : Integer;
    State          : Integer;
    Title          : WideString;
    Link           : WideString;
    Description    : WideString;
    Language       : WideString;
    author         : WideString;
    category       : WideString;
    comments       : WideString;
    Enclosure      : WideString;
    guid           : WideString;
    PubDate        : WideString;
//    LastBuildDate  : WideString;
    source         : WideString;
    summary        : WideString;
  end;

  procedure ProcessXML(CLPos: Integer; RSSPos: Integer; sHTML: AnsiString);
  procedure ReadRSS(sHTML: AnsiString; var Data: TStringList; var XMLInfo: TXMLInfo);
  procedure LoadLogo( source: TFeed; var img: TLogo);

var
  XmlParser   : TXmlParser;

implementation

uses fQIPPlugin, DownloadFile, uSuperReplace, cDateTime,
  TextSearch, SQLiteTable3, cUnicodeCodecs, Convs,
  SQLiteFuncs, uOptions, GraphicEx;

(*
===============================================================================================
TElementNode
===============================================================================================
*)

TYPE
  TElementNode = CLASS
                   Content : STRING;
                   Attr    : TStringList;
                   CONSTRUCTOR Create (TheContent : STRING; TheAttr : TNvpList);
                   DESTRUCTOR Destroy; OVERRIDE;
                 END;

CONSTRUCTOR TElementNode.Create (TheContent : STRING; TheAttr : TNvpList);
VAR
  I : INTEGER;
BEGIN
  INHERITED Create;
  Content := TheContent;
  Attr    := TStringList.Create;
  IF TheAttr <> NIL THEN
    FOR I := 0 TO TheAttr.Count-1 DO
      Attr.Add (TNvpNode (TheAttr [I]).Name + '=' + TNvpNode (TheAttr [I]).Value);
END;


DESTRUCTOR TElementNode.Destroy;
BEGIN
  Attr.Free;
  INHERITED Destroy;
END;

////////////////////////////////////////////////////////////////////////////////
           (*
PROCEDURE ReplaceCharacterEntities (VAR Str : AnsiString);
          // Replaces all Character Entity References in the AnsiString
VAR
  Start  : INTEGER;
  PAmp   : PAnsiChar;
  PSemi  : PAnsiChar;
  PosAmp : INTEGER;
  Len    : INTEGER;    // Length of Entity Reference
BEGIN
  IF Str = '' THEN EXIT;
  Start := 1;
  REPEAT
    PAmp := StrPos (PAnsiChar (Str) + Start-1, '&#');
    IF PAmp = NIL THEN BREAK;
    PSemi := StrScan (PAmp+2, ';');
    IF PSemi = NIL THEN BREAK;
    PosAmp := PAmp - PAnsiChar (Str) + 1;
    Len    := PSemi-PAmp+1;
    IF CompareText (Str [PosAmp+2], 'x') = 0          // !!! Can't use "CHR" for Unicode characters > 255
      THEN Str [PosAmp] := AnsiChar (StrToIntDef ('$'+Copy (Str, PosAmp+3, Len-4), 0))
      ELSE Str [PosAmp] := AnsiChar (StrToIntDef (Copy (Str, PosAmp+2, Len-3), 32));
    Delete (Str, PosAmp+1, Len-1);
    Start := PosAmp + 1;
  UNTIL FALSE;
END;       *)

procedure ReplaceCharacterEntities (var Str : WideString);
VAR
  Start  : INTEGER;
  PAmp   : PWideChar;
  PSemi  : PWideChar;
  PosAmp : INTEGER;
  Len    : INTEGER;    // Length of Entity Reference
BEGIN
  IF Str = '' THEN EXIT;
  Start := 1;
  REPEAT
    PAmp := StrPos (PWideChar (Str) + Start-1, '&#');
    IF PAmp = NIL THEN BREAK;
    PSemi := StrScan (PAmp+2, ';');
    IF PSemi = NIL THEN BREAK;
    PosAmp := PAmp - PAnsiChar (Str) + 1;
    Len    := PSemi-PAmp+1;
    IF CompareText (Str [PosAmp+2], 'x') = 0          // !!! Can't use "CHR" for Unicode characters > 255
      THEN Str [PosAmp] := WideChar (StrToIntDef ('$'+Copy (Str, PosAmp+3, Len-4), 0))
      ELSE Str [PosAmp] := WideChar (StrToIntDef (Copy (Str, PosAmp+2, Len-3), 32));
    Delete (Str, PosAmp+1, Len-1);
    Start := PosAmp + 1;
  UNTIL FALSE;
END;

procedure ReadRSS(sHTML: AnsiString; var Data: TStringList; var XMLInfo: TXMLInfo);
var
  sn : RawByteString;

  EN : TElementNode;

  hIndex : Integer;

//  F: TextFile;

  sEnclosure: WideString;

  procedure CommandXML(sCommand: WideString; sValue: WideString; Attrs: TStringList; bAttrs: Boolean);
  var  idx: Integer;
      sV : WideString;
      ix : Integer;
      x : AnsiString;
    begin
//    showmessage(sCommand+#13+sValue);

//ReplaceCharacterEntities (svalue);

//x:=  wideString2UTF8( sValue);
// ReplaceCharacterEntities (x);
//sValue := UTF82WideString(x);
           {
      writeln(F,sCommand + ' >>> ' + sValue);


      for ix := 0 to Attrs.Count - 1 do
      begin

        writeln(F, '>' + Attrs.Strings[ix] + ' >>> ' + TXMLAttrs(Attrs.Objects[ix]).dataWideString );

      end;
             }
//        showmessage(sValue);
      if sCommand='CODEPAGE' then
        XMLInfo.CodePage := sValue;


      if AnsiUpperCase(XMLInfo.CodePage) = 'UTF-8' then
        sValue := HTMLToText( UTF82WideString(sValue) )
      else if AnsiUpperCase(XMLInfo.CodePage) = 'ISO-8859-2' then
        sValue := HTMLToText(  EncodingToUTF16('ISO-8859-2', sValue) )
      else if AnsiUpperCase(XMLInfo.CodePage) = 'WINDOWS-1251' then
        sValue := HTMLToText(  EncodingToUTF16('windows-1251', sValue) )
      else
        sValue := HTMLToText( sValue );

//        showmessage(UTF8encode(sValue));

      sValue := {TextToSQLText(}sValue{)};

      if sCommand = '/rss' then     //RSS
      begin
        idx := Attrs.IndexOf('version');
        if idx <> -1 then
          sV := TXMLAttrs(Attrs.Objects[idx]).dataWideString;    //version

        XMLInfo.Encoder    := 'RSS';
        XMLInfo.EncoderVer := sV;
      end
      else if sCommand = '/rdf:RDF' then       //  rdf:RDF  - RSS
      begin
        XMLInfo.Encoder    := 'RSS (rdf:RDF)';
        XMLInfo.EncoderVer := '';
      end
      else if sCommand = '/feed' then       //Atom
      begin

        idx := Attrs.IndexOf('version');          // version 0.3
        if idx <> -1 then
          sV := '0.3';

        idx := Attrs.IndexOf('xmlns');          // version 1.0
        if idx <> -1 then
          sV := '1.0';

        XMLInfo.Encoder    := 'Atom';
        XMLInfo.EncoderVer := sV;

      end;


      if XMLInfo.Encoder = 'RSS' then
      begin
        //--- Uvod kanalu ---
        if sCommand = '/rss/channel/title' then
        begin
           XMLInfo.Title := sValue;
        end
        else if sCommand = '/rss/channel/link' then
        begin
          XMLInfo.Link := sValue
        end
        else if sCommand = '/rss/channel/description' then
        begin
          XMLInfo.Description := sValue
        end
        else if sCommand = '/rss/channel/language' then
        begin
          XMLInfo.Language := sValue;
        end
        else if sCommand = '/rss/channel/pubDate' then
        begin
          XMLInfo.PubDate := RFCDTToDT(sValue)
        end
        else if sCommand = '/rss/channel/lastBuildDate' then
        begin
          XMLInfo.LastBuildDate := RFCDTToDT(sValue)
        end
        else if sCommand = '/rss/channel/image/url' then
        begin
          XMLInfo.image := sValue
        end
        else if sCommand = '/rss/channel/image/category' then
        begin
          XMLInfo.category := sValue
        end
        else if sCommand = '/rss/channel/image/generator' then
        begin
          XMLInfo.generator := sValue
        end
        else if sCommand = '/rss/channel/image/ttl' then
        begin
          XMLInfo.ttl := sValue
        end
        // --- Polozky ---
        else if (sCommand = 'BEGIN') and (sValue = '/rss/channel/item') then  //Zacina item
        begin

            if sEnclosure<>'' then
            begin
              if TRSSData(Data.Objects[hIndex]).Enclosure='' then
                TRSSData(Data.Objects[hIndex]).Enclosure := sEnclosure
              else
                TRSSData(Data.Objects[hIndex]).Enclosure := TRSSData(Data.Objects[hIndex]).Enclosure + ' <NEXT /> ' + sEnclosure;

              sEnclosure := '';
            end;

          Data.Add('ITEM');
          hIndex:= Data.Count - 1;
          Data.Objects[hIndex] := TRSSData.Create;
          TRSSData(Data.Objects[hIndex]).Title       := '';
          TRSSData(Data.Objects[hIndex]).Link        := '';
          TRSSData(Data.Objects[hIndex]).Description := '';
          TRSSData(Data.Objects[hIndex]).PubDate     := '';
        end
        else if sCommand = '/rss/channel/item/title' then
        begin
          TRSSData(Data.Objects[hIndex]).Title := sValue;
        end
        else if sCommand = '/rss/channel/item/link' then
        begin
          TRSSData(Data.Objects[hIndex]).Link := sValue;
        end
        else if sCommand = '/rss/channel/item/author' then
        begin
          TRSSData(Data.Objects[hIndex]).author := '[email]="'+sValue+'";';//sValue;
        end
        else if sCommand = '/rss/channel/item/description' then
        begin
          TRSSData(Data.Objects[hIndex]).Description := sValue;
        end
        else if sCommand = '/rss/channel/item/pubDate' then
        begin
          TRSSData(Data.Objects[hIndex]).PubDate := RFCDTToDT( sValue );
        end
        else if sCommand = '/rss/channel/item/category' then
        begin
          TRSSData(Data.Objects[hIndex]).category := sValue;
        end
        else if sCommand = '/rss/channel/item/comments' then
        begin
          TRSSData(Data.Objects[hIndex]).comments := sValue;
        end
        else if sCommand = '/rss/channel/item/guid' then      //jednoznacna identifikace
        begin
          TRSSData(Data.Objects[hIndex]).guid := sValue;
        end

       else if sCommand = '/rss/channel/item/enclosure' then
        begin
          if bAttrs=True then   // odkaz atd
          begin
            if sEnclosure<>'' then
            begin
              if TRSSData(Data.Objects[hIndex]).Enclosure='' then
                TRSSData(Data.Objects[hIndex]).Enclosure := sEnclosure
              else
                TRSSData(Data.Objects[hIndex]).Enclosure := TRSSData(Data.Objects[hIndex]).Enclosure + ' <NEXT /> ' + sEnclosure;

              sEnclosure := '';
            end;

            idx := Attrs.IndexOf('url');
            if idx <> -1 then
              sEnclosure := sEnclosure + '['+Attrs.Strings[idx]+']="'+TXMLAttrs(Attrs.Objects[idx]).dataWideString+'";';

            idx := Attrs.IndexOf('length');
            if idx <> -1 then
              sEnclosure := sEnclosure + '['+Attrs.Strings[idx]+']="'+TXMLAttrs(Attrs.Objects[idx]).dataWideString+'";';

            idx := Attrs.IndexOf('type');
            if idx <> -1 then
              sEnclosure := sEnclosure + '['+Attrs.Strings[idx]+']="'+TXMLAttrs(Attrs.Objects[idx]).dataWideString+'";';

          end
          else
          begin               // popis
            sEnclosure := sEnclosure + '[description]="'+sValue+'";';
          end;

        end

      end

      else if XMLInfo.Encoder = 'RSS (rdf:RDF)' then
      begin
        //--- Uvod kanalu ---
        if sCommand = '/rdf:RDF/channel/title' then
        begin
           XMLInfo.Title := sValue;
        end
        else if sCommand = '/rdf:RDF/channel/link' then
        begin
          XMLInfo.Link := sValue
        end
        else if sCommand = '/rdf:RDF/channel/description' then
        begin
          XMLInfo.Description := sValue
        end
        else if sCommand = '/rdf:RDF/channel/language' then
        begin
          XMLInfo.Language := sValue;
        end
        else if sCommand = '/rdf:RDF/channel/pubDate' then
        begin
          XMLInfo.PubDate := RFCDTToDT(sValue)
        end
        else if sCommand = '/rdf:RDF/channel/lastBuildDate' then
        begin
          XMLInfo.LastBuildDate := RFCDTToDT(sValue)
        end
        else if sCommand = '/rdf:RDF/channel/image/url' then
        begin
          XMLInfo.image := sValue
        end
        else if sCommand = '/rdf:RDF/channel/image/category' then
        begin
          XMLInfo.category := sValue
        end
        else if sCommand = '/rdf:RDF/channel/image/generator' then
        begin
          XMLInfo.generator := sValue
        end
        else if sCommand = '/rdf:RDF/channel/image/ttl' then
        begin
          XMLInfo.ttl := sValue
        end
        // --- Polozky ---
        else if (sCommand = 'BEGIN') and (sValue = '/rdf:RDF/item') then  //Zacina item
        begin

            if sEnclosure<>'' then
            begin
              if TRSSData(Data.Objects[hIndex]).Enclosure='' then
                TRSSData(Data.Objects[hIndex]).Enclosure := sEnclosure
              else
                TRSSData(Data.Objects[hIndex]).Enclosure := TRSSData(Data.Objects[hIndex]).Enclosure + ' <NEXT /> ' + sEnclosure;

              sEnclosure := '';
            end;

          Data.Add('ITEM');
          hIndex:= Data.Count - 1;
          Data.Objects[hIndex] := TRSSData.Create;
          TRSSData(Data.Objects[hIndex]).Title       := '';
          TRSSData(Data.Objects[hIndex]).Link        := '';
          TRSSData(Data.Objects[hIndex]).Description := '';
          TRSSData(Data.Objects[hIndex]).PubDate     := '';
        end
        else if sCommand = '/rdf:RDF/item/title' then
        begin
          TRSSData(Data.Objects[hIndex]).Title := sValue;
        end
        else if sCommand = '/rdf:RDF/item/link' then
        begin
          TRSSData(Data.Objects[hIndex]).Link := sValue;
        end
        else if sCommand = '/rdf:RDF/item/author' then
        begin
          TRSSData(Data.Objects[hIndex]).author := '[email]="'+sValue+'";';//sValue;
        end
        else if sCommand = '/rdf:RDF/item/description' then
        begin
          TRSSData(Data.Objects[hIndex]).Description := sValue;
        end
        else if sCommand = '/rdf:RDF/item/pubDate' then
        begin
          TRSSData(Data.Objects[hIndex]).PubDate := RFCDTToDT( sValue );
        end
        else if sCommand = '/rdf:RDF/item/category' then
        begin
          TRSSData(Data.Objects[hIndex]).category := sValue;
        end
        else if sCommand = '/rdf:RDF/item/comments' then
        begin
          TRSSData(Data.Objects[hIndex]).comments := sValue;
        end
        else if sCommand = '/rdf:RDF/item/guid' then      //jednoznacna identifikace
        begin
          TRSSData(Data.Objects[hIndex]).guid := sValue;
        end

       else if sCommand = '/rdf:RDF/item/enclosure' then
        begin
          if bAttrs=True then   // odkaz atd
          begin
            if sEnclosure<>'' then
            begin
              if TRSSData(Data.Objects[hIndex]).Enclosure='' then
                TRSSData(Data.Objects[hIndex]).Enclosure := sEnclosure
              else
                TRSSData(Data.Objects[hIndex]).Enclosure := TRSSData(Data.Objects[hIndex]).Enclosure + ' <NEXT /> ' + sEnclosure;

              sEnclosure := '';
            end;

            idx := Attrs.IndexOf('url');
            if idx <> -1 then
              sEnclosure := sEnclosure + '['+Attrs.Strings[idx]+']="'+TXMLAttrs(Attrs.Objects[idx]).dataWideString+'";';

            idx := Attrs.IndexOf('length');
            if idx <> -1 then
              sEnclosure := sEnclosure + '['+Attrs.Strings[idx]+']="'+TXMLAttrs(Attrs.Objects[idx]).dataWideString+'";';

            idx := Attrs.IndexOf('type');
            if idx <> -1 then
              sEnclosure := sEnclosure + '['+Attrs.Strings[idx]+']="'+TXMLAttrs(Attrs.Objects[idx]).dataWideString+'";';

          end
          else
          begin               // popis
            sEnclosure := sEnclosure + '[description]="'+sValue+'";';
          end;

        end

      end


      else if XMLInfo.Encoder = 'Atom' then
      begin
        //--- Uvod kanalu ---
        if sCommand = '/feed/title' then
        begin
          XMLInfo.Title := sValue
        end
        else if sCommand = '/feed/link' then
        begin

          idx := Attrs.IndexOf('href');
          if idx <> -1 then
            sV := TXMLAttrs(Attrs.Objects[idx]).dataWideString;

          XMLInfo.Link := sV;

{          XMLInfo.Link := sValue}
        end
 {       else if sCommand = '/rss/channel/description' then
        begin
          sFeetDescription := sValue
        end
        else if sCommand = '/rss/channel/language' then
        begin
          sFeetLanguage := sValue
        end          }
        else if sCommand = '/feed/updated' then
        begin
          XMLInfo.PubDate := ISO8601DTToDT(sValue)
        end
{        else if sCommand = '/rss/channel/lastBuildDate' then
        begin
          sFeetLastBuildDate := RFCDTToDT(sValue)
        end     }

        // --- Polozky ---
        else if (sCommand = 'BEGIN') and (sValue = '/feed/entry') then  //Zacina item
        begin
//          showmessage('uvod');
          Data.Add('ITEM');
          hIndex:= Data.Count - 1;
          Data.Objects[hIndex] := TRSSData.Create;
          TRSSData(Data.Objects[hIndex]).Title       := '';
          TRSSData(Data.Objects[hIndex]).Link        := '';
          TRSSData(Data.Objects[hIndex]).Description := '';
          TRSSData(Data.Objects[hIndex]).PubDate     := '';
          TRSSData(Data.Objects[hIndex]).author      := '';
          TRSSData(Data.Objects[hIndex]).summary     := '';
        end
        else if sCommand = '/feed/entry/title' then
        begin
          TRSSData(Data.Objects[hIndex]).Title := sValue;
//          showmessage(TRSSData(Data.Objects[hIndex]).Title);
        end
        else if sCommand = '/feed/entry/link' then
        begin
          idx := Attrs.IndexOf('href');
          if idx <> -1 then
          begin
            sV := TXMLAttrs(Attrs.Objects[idx]).dataWideString;

            idx := Attrs.IndexOf('rel');
            if idx <> -1 then
            begin
              if TXMLAttrs(Attrs.Objects[idx]).dataWideString = 'alternate' then
                TRSSData(Data.Objects[hIndex]).Link := sV;
            end;
{            alternate
            TSLAttrs(Attrs.Objects[idx]).dataWideString;}

          end;


{          if TSLRSSData(Data.Objects[hIndex]).Link='' then
            TSLRSSData(Data.Objects[hIndex]).Link := sValue;}
        end
        else if sCommand = '/feed/entry/content' then
        begin
          TRSSData(Data.Objects[hIndex]).Description := sValue;
        end
        else if sCommand = '/feed/entry/updated' then     //1.0
        begin
          TRSSData(Data.Objects[hIndex]).PubDate := ISO8601DTToDT( sValue );
        end
        else if sCommand = '/feed/entry/modified' then    //0.3
        begin
          TRSSData(Data.Objects[hIndex]).PubDate := ISO8601DTToDT( sValue );
        end
        else if sCommand = '/feed/entry/summary' then
        begin
          TRSSData(Data.Objects[hIndex]).summary := sValue;
        end
        else if sCommand = '/feed/entry/author/email' then
        begin
          TRSSData(Data.Objects[hIndex]).author := TRSSData(Data.Objects[hIndex]).author + '[email]="'+sValue+'";';
        end
        else if sCommand = '/feed/entry/author/name' then
        begin
          TRSSData(Data.Objects[hIndex]).author := TRSSData(Data.Objects[hIndex]).author + '[name]="'+sValue+'";';
        end
        else if sCommand = '/feed/entry/author/uri' then
        begin
          TRSSData(Data.Objects[hIndex]).author := TRSSData(Data.Objects[hIndex]).author + '[uri]="'+sValue+'";';
        end
        else if sCommand = '/feed/entry/id' then    //jednoznacna identifikace
        begin
          TRSSData(Data.Objects[hIndex]).guid := sValue;
        end

      end;

      Attrs.Clear;
    end;

  procedure ReadItemXML(s: AnsiString);
  var ii: Integer;
      sAttrs : TStringList;
      hIndex1: Integer;
  begin

    sAttrs := TStringList.Create;
    sAttrs.Clear;

    while XmlParser.Scan do
    begin
      case XmlParser.CurPartType of
        ptXmlProlog : begin
                        CommandXML( 'CODEPAGE' ,XmlParser.CurEncoding, sAttrs, False);
                      end;
        ptDtdc      : begin
                      end;
        ptStartTag,
        ptEmptyTag  : begin
                        if XmlParser.CurAttr.Count > 0 then
                        begin
                          sn:= s + '/' + XmlParser.CurName ;

                          EN := TElementNode.Create ('', XmlParser.CurAttr);

//                          sAttrs := TStringList.Create;
                          sAttrs.Clear;

                          for Ii := 0 TO EN.Attr.Count-1 do
                          begin

//                          showmessage(Trim( EN.Attr.Names [Ii] ));

                            sAttrs.Add( Trim( EN.Attr.Names [Ii] ) );
                            hIndex1:= sAttrs.Count - 1;
                            sAttrs.Objects[hIndex1] := TXMLAttrs.Create;
                            TXMLAttrs(sAttrs.Objects[hIndex1]).dataWideString := Trim( EN.Attr.Values [EN.Attr.Names [Ii]]);

//                            CommandXML( sn + '|' + Trim( EN.Attr.Names [Ii] ), Trim( EN.Attr.Values [EN.Attr.Names [Ii]]) , sAttrs);
                          end;

                          CommandXML( sn, '', sAttrs, True );

                          sAttrs.Clear;


                        end;

                        if XmlParser.CurPartType = ptStartTag then   // Recursion
                        begin
                          sn:= s + '/' + XmlParser.CurName ;

                          CommandXML('BEGIN' , sn, sAttrs, False );

                          ReadItemXML (sn);
                        end

                      end;
        ptEndTag    : begin
                        CommandXML('END' , s, sAttrs, False );
                        BREAK;
                      end;
        ptContent,
        ptCData     : begin
                        if Trim( XmlParser.CurContent)='' then

                        else
                        begin
                          CommandXML( s , Trim( XmlParser.CurContent ), sAttrs, False );
                        end;

                      end;
        ptComment   : begin
                      end;
        ptPI        : begin
                      end;

      end;

    end;

  end;

begin

  XmlParser := TXmlParser.Create;


  XmlParser.LoadFromBuffer(  PAnsiChar( sHTML )  );

  XmlParser.StartScan;
  XmlParser.Normalize := FALSE;

{  AssignFile(F, ExtractFilePath(PluginDllPath) + 'cmds.txt');
  Rewrite(F);}

  ReadItemXML('');


            if sEnclosure<>'' then
            begin
              if TRSSData(Data.Objects[hIndex]).Enclosure='' then
                TRSSData(Data.Objects[hIndex]).Enclosure := sEnclosure
              else
                TRSSData(Data.Objects[hIndex]).Enclosure := TRSSData(Data.Objects[hIndex]).Enclosure + ' <NEXT /> ' + sEnclosure;

              sEnclosure := '';
            end;


{  CloseFile(F);}

  XmlParser.Free;

end;

procedure ProcessXML(CLPos: Integer; RSSPos: Integer; sHTML: AnsiString);
var i: Integer;

    FeetInfo: TXMLInfo;

    RSSData : TStringList;

    SQLtb     : TSQLiteTable;

//    F: TextFile;

    sSQL      : WideString;
//    img: TImage;
//    bmpsrc, bmpdst: TBitmap;

    sValue : WideString;
//    xU: WideString;
//    fmFadeMsg  : TFadeMsg;
    sMsgText : WideString;

    slSuperReplace: TStringList;
    hslIndex: Integer;

    bNoAutCl : Boolean;
    iClTime  : Integer;
    IncGMT : Integer;
    iNotifLastMins : Integer;
    bNotif : Boolean;
begin
  RSSData := TStringList.Create;
  RSSData.Clear;

//  sHTML := xxxxxxxxxxxxx;

  if Copy(sHTML,1,3) = 'ï»¿' then
      sHTML := Copy(sHTML,4);

  sHTML := Trim(sHTML);
  
  if (Copy(sHTML,1,5) = '<?xml') or (Copy(sHTML,1,4) = '<rss') then  // platny XML
  else

  begin          // Neplatny XML soubor
    TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).Error := True;
    TCL(CL.Objects[CLPos]).Error := True;
    Exit;
  end;

{
  AssignFile(F, ExtractFilePath(PluginDllPath) + 'xml.txt');
  Rewrite(F);
  write(F,sHTML);
  CloseFile(F);
}

  ReadRSS(sHTML, RSSData, FeetInfo);


  sSQL := 'UPDATE RSS SET title='+''''+TextToSQLText(FeetInfo.Title)+''''+' WHERE (ID='+IntToStr(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).ID)+')';
  ExecSQLUTF8(sSQL);

  sSQL := 'UPDATE RSS SET link='+''''+TextToSQLText(FeetInfo.Link)+''''+' WHERE (ID='+IntToStr(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).ID)+')';
  ExecSQLUTF8(sSQL);

  sSQL := 'UPDATE RSS SET description='+''''+TextToSQLText(FeetInfo.Description)+''''+' WHERE (ID='+IntToStr(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).ID)+')';
  ExecSQLUTF8(sSQL);

  sSQL := 'UPDATE RSS SET language='+''''+TextToSQLText(FeetInfo.Language)+'''' + ' WHERE (ID='+IntToStr(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).ID)+')';
  ExecSQLUTF8(sSQL);

  sSQL := 'UPDATE RSS SET pubDate='+''''+TextToSQLText(FeetInfo.PubDate)+''''+' WHERE (ID='+IntToStr(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).ID)+')';
  ExecSQLUTF8(sSQL);

  sSQL := 'UPDATE RSS SET lastBuildDate='+''''+TextToSQLText(FeetInfo.LastBuildDate)+''''+' WHERE (ID='+IntToStr(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).ID)+')';
  ExecSQLUTF8(sSQL);

  sSQL := 'UPDATE RSS SET Encoder='+''''+TextToSQLText(FeetInfo.Encoder)+''''+' WHERE (ID='+IntToStr(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).ID)+')';
  ExecSQLUTF8(sSQL);

  sSQL := 'UPDATE RSS SET EncoderVer='+''''+TextToSQLText(FeetInfo.EncoderVer)+''''+' WHERE (ID='+IntToStr(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).ID)+')';
  ExecSQLUTF8(sSQL);

  sSQL := 'UPDATE RSS SET CodePage='+''''+TextToSQLText(FeetInfo.CodePage)+''''+' WHERE (ID='+IntToStr(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).ID)+')';
  ExecSQLUTF8(sSQL);

  sSQL := 'UPDATE RSS SET image='+''''+TextToSQLText(FeetInfo.image)+''''+' WHERE (ID='+IntToStr(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).ID)+')';
  ExecSQLUTF8(sSQL);


  sSQL := 'UPDATE RSS SET category='+''''+TextToSQLText(FeetInfo.category)+''''+' WHERE (ID='+IntToStr(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).ID)+')';
  ExecSQLUTF8(sSQL);

  sSQL := 'UPDATE RSS SET generator='+''''+TextToSQLText(FeetInfo.generator)+''''+' WHERE (ID='+IntToStr(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).ID)+')';
  ExecSQLUTF8(sSQL);

  sSQL := 'UPDATE RSS SET ttl='+''''+TextToSQLText(FeetInfo.ttl)+''''+' WHERE (ID='+IntToStr(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).ID)+')';
  ExecSQLUTF8(sSQL);


  TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).image := FeetInfo.image;

  TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).Logo.URL := FeetInfo.image;
  TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).Logo.NormalImage := TImage.Create(nil);
  TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).Logo.SmallImage  := TImage.Create(nil);

//  showmessage(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).URL+#13+'http://www.zive.cz/RSS/sc-47/default.aspx?rss=1');
{  if TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).URL='http://www.zive.cz/RSS/sc-47/default.aspx?rss=' then
  begin   }
//  showmessage('zive');

{
  sValue := LoadOptionOwn(CLPos,RSSPos,'Icon', -1);

  if StrPosE(sValue,'OwnImage;',1,False) <> 0 then
  begin
    sValue := GetOptionFromOptions(sValue,'OwnImageFile');
    if sValue <> '' then
      TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).Logo.URL := sValue
  end;
}
  LoadLogo(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]), TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).Logo );

  {

  if chkOwnIconImage.Checked = True then
    sValue := sValue + 'OwnImage;';

  sValue := sValue + 'OwnImageFile=<'+edtOwnIconImageFile.Text+'>;';
}

//    LoadLogo(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]), TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).Logo);

//  TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).imageTImage.Picture.SaveToFile(ExtractFilePath(PluginDllPath) + 'Logos\' + 'test.bmp');
  {end; }


//  img := TImage.Create(nil);

//  LoadLogo(TSLCLRSS(TSLCL(CL.Objects[CLPos]).RSS.Objects[RSSPos]), img);

//bmpsrc := TBitmap;
//  bmpdst
//  bmpsrc.Assign := img.Picture.Bitmap.;

//  bmpsrc.Assign(img);

{  TSLCLRSS(TSLCL(CL.Objects[CLPos]).RSS.Objects[RSSPos]).imageTImage.Picture.Bitmap.Width := 16;
  TSLCLRSS(TSLCL(CL.Objects[CLPos]).RSS.Objects[RSSPos]).imageTImage.Picture.Bitmap.Height := 16;
}
//  SmoothResize(img.Picture.Bitmap,TSLCLRSS(TSLCL(CL.Objects[CLPos]).RSS.Objects[RSSPos]).imageTImage.Picture.Bitmap);

//  SmoothResizeImage(img, TSLCLRSS(TSLCL(CL.Objects[CLPos]).RSS.Objects[RSSPos]).imageTImage);

  TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).Encoder := FeetInfo.Encoder;
  TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).EncoderVer := FeetInfo.EncoderVer;

  sValue := LoadOptionOwn(CLPos, RSSPos, 'GMT',-1);
  IncGMT := ConvStrToInt(GetOptionFromOptions(sValue,'GMT'));

  i:= RSSData.Count - 1;
  while ( i >= 0 ) do
    begin
      Application.ProcessMessages;

//      showmessage(TRSSData(RSSData.Objects[i]).Title);

//      MessageBoxW(0,PWideChar( TSLRSSData(RSSData.Objects[i]).Description ), 'TEST', MB_ICONQUESTION);

      sValue := LoadOptionOwn(CLpos,RSSpos,'Additional', -1);

      if (StrPosE(sValue,'MsgsIdentifyByContents;',1,False) <> 0) or (TRSSData(RSSData.Objects[i]).guid = '') then
      begin
        SQLtb := SQLdb.GetTable(WideString2UTF8( 'SELECT * FROM Data WHERE '+
                              'RSSID=' + IntToStr(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).ID) +
                            ' and title='+''''+ TextToSQLText(TRSSData(RSSData.Objects[i]).Title)+''''+
{                          ' and link='+''''+ TextToSQLText(TRSSData(RSSData.Objects[i]).Link)+''''+}
                          ' and description='+''''+ TextToSQLText(TRSSData(RSSData.Objects[i]).Description)+''''+
                          ' and summary='+''''+ TextToSQLText(TRSSData(RSSData.Objects[i]).summary)+''''+
                          ' and pubDate='+''''+ TextToSQLText(TRSSData(RSSData.Objects[i]).PubDate)+''''
                            )  );
      end
      else
      begin
        SQLtb := SQLdb.GetTable(WideString2UTF8( 'SELECT * FROM Data WHERE '+
                              'RSSID=' + IntToStr(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).ID) +
                          ' and guid='+''''+ TextToSQLText(TRSSData(RSSData.Objects[i]).guid)+''''
                            )  );
      end;


      {try   }

        if SQLtb.Count > 0 then    // FOUND
          begin
//MessageBoxW(0,PWideChar( SQLTEXTTOTEXT(SQLtb.FieldAsString(SQLtb.FieldIndex['description'])) ), 'TEST', MB_ICONQUESTION);

          end
        else          //NOT FOUND
          begin

            bNotif := True;

            sValue := LoadOptionOwn(CLpos,RSSpos,'Notifications', -1);
            iNotifLastMins := ConvStrToInt( GetOptionFromOptions(sValue,'OnlyLastMin') );

            if iNotifLastMins <> 0 then
            begin
              if iNotifLastMins < DiffMinutes(StrToDateTime( TRSSData(RSSData.Objects[i]).PubDate, DTFormatDATETIME  ) + ( IncGMT * (1/24) ), Now) then
              begin
                bNotif := False;
              end;
            end;




            if bNotif = True then
            begin
              TCL(CL.Objects[CLpos]).NewItems := True;
              TCL(CL.Objects[CLpos]).NewItemsWasNotif := False;
              TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).NewItems := True;
              TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).NewItemsWasNotif := False;
            end;

//            DiffMinutes


            sSQL := 'INSERT INTO Data(RSSID, Archive, State, title, link, description, pubDate, enclosure, summary, author, category, comments, guid) VALUES ' +
                     '(' + IntToStr(TFeed(TCL(CL.Objects[CLPos]).Feed.Objects[RSSPos]).ID) +', '+
                           IntToStr(0) + ', '+
                           IntToStr(1) + ', '+
                     ''''+TextToSQLText(TRSSData(RSSData.Objects[i]).Title)+''''+', '+
                     ''''+TextToSQLText(TRSSData(RSSData.Objects[i]).Link)+''''+', '+
                     ''''+TextToSQLText(TRSSData(RSSData.Objects[i]).Description)+''''+', '+
                     ''''+TextToSQLText(TRSSData(RSSData.Objects[i]).PubDate)+''''+', '+
                     ''''+TextToSQLText(TRSSData(RSSData.Objects[i]).Enclosure)+''''+', '+
                     ''''+TextToSQLText(TRSSData(RSSData.Objects[i]).summary)+''''+', '+
                     ''''+TextToSQLText(TRSSData(RSSData.Objects[i]).author)+''''+', '+
                     ''''+TextToSQLText(TRSSData(RSSData.Objects[i]).category)+''''+', '+
                     ''''+TextToSQLText(TRSSData(RSSData.Objects[i]).comments)+''''+', '+
                     ''''+TextToSQLText(TRSSData(RSSData.Objects[i]).guid)+''''+');';

  //          xU := 'EEE '+TSLRSSData(RSSData.Objects[i]).Description + IntToStr(0) + '   INSERT';
//MessageBoxW(0,PWideChar( xU ), 'TEST', MB_ICONQUESTION);
//MessageBoxW(0,PWideChar( TSLRSSData(RSSData.Objects[i]).Description ), 'TEST', MB_ICONQUESTION);
//MessageBoxW(0,PWideChar( sSQL+#13+#13+UTF8DECODE(sSQL) ), 'TEST', MB_ICONQUESTION);
            ExecSQLUTF8(sSQL);


            Inc(TFeed(TCL(CL.Objects[CLpos]).Feed.Objects[RSSpos]).MsgsCount.MsgNewCount);
            Inc(TFeed(TCL(CL.Objects[CLpos]).Feed.Objects[RSSpos]).MsgsCount.MsgUnreadCount);
            Inc(TFeed(TCL(CL.Objects[CLpos]).Feed.Objects[RSSpos]).MsgsCount.MsgCount);

            if (RSSNewsStatus = 2) or (bNotif = False) then
              /// Status nerusit  nebo  neoznamovat, neni splnena casova podminka
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
                  TSuperReplace(slSuperReplace.Objects[hslIndex]).Value      := TRSSData(RSSData.Objects[i]).Title;

                  slSuperReplace.Add('ITEM');
                  hslIndex:= slSuperReplace.Count - 1;
                  slSuperReplace.Objects[hslIndex] := TSuperReplace.Create;
                  TSuperReplace(slSuperReplace.Objects[hslIndex]).Command    := '%MSGDESCRIPTION%';

                  if TRSSData(RSSData.Objects[i]).Description='' then
                    TSuperReplace(slSuperReplace.Objects[hslIndex]).Value      := UTF82WideString(StripHTMLTags(WideString2UTF8(TRSSData(RSSData.Objects[i]).summary)))
                  else
                    TSuperReplace(slSuperReplace.Objects[hslIndex]).Value      := UTF82WideString(StripHTMLTags(WideString2UTF8(TRSSData(RSSData.Objects[i]).Description)));


                  slSuperReplace.Add('ITEM');
                  hslIndex:= slSuperReplace.Count - 1;
                  slSuperReplace.Objects[hslIndex] := TSuperReplace.Create;
                  TSuperReplace(slSuperReplace.Objects[hslIndex]).Command    := '%MSGDATETIME%';

                  if TRSSData(RSSData.Objects[i]).pubDate='' then
                    TSuperReplace(slSuperReplace.Objects[hslIndex]).Value      := ''
                  else
                    TSuperReplace(slSuperReplace.Objects[hslIndex]).Value      := FormatDateTime('dd.mm.yyyy hh:mm:ss', StrToDateTime( TRSSData(RSSData.Objects[i]).pubDate, DTFormatDATETIME  ) + ( IncGMT * (1/24) ) );


                  slSuperReplace.Add('ITEM');
                  hslIndex:= slSuperReplace.Count - 1;
                  slSuperReplace.Objects[hslIndex] := TSuperReplace.Create;
                  TSuperReplace(slSuperReplace.Objects[hslIndex]).Command    := '%MSGAUTHOR%';
                  TSuperReplace(slSuperReplace.Objects[hslIndex]).Value      := GetAuthor( TRSSData(RSSData.Objects[i]).author );


                  if TFeed(TCL(CL.Objects[CLpos]).Feed.Objects[RSSpos]).Style = FEED_GMAIL then
                  begin
                    sMsgText := SuperReplace(TextNewEmail,slSuperReplace);
                  end
                  else
                  begin
                    sMsgText := SuperReplace(TextNewMessage,slSuperReplace);
                  end;

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

        { finally     }
        SQLtb.Free;
      { end;   }




      i := i - 1;

    end;


  //end the transaction
//  SQLdb.Commit;


end;



procedure LoadLogo( source: TFeed; var img: TLogo);
var HTMLData: TResultData;
    Info: TPositionInfo;
    F: TextFile;
    sExt: AnsiString;
{
    Gif: TGifImage;
    PNG: TPNGObject;
}
    rec: TSearchRec;

    sLogoFN: WideString;


//  Start: DWORD;
  GraphicClass: TGraphicExGraphicClass;
  Graphic: TGraphic;
  FileName: WideString;


  NewBitmapHeight, NewBitmapWidth: Integer;
  TargetArea:  TRect;
  IWidth, IHalf, IHeight: Integer;

begin
  img.ExistLogo := False;
//       showmessage(source.image+#13+source.Name);
  sLogoFN := '';
  if FindFirst(ExtractFilePath(PluginDllPath) + 'Logos\' + IntToStr(source.ID) + '.*', faAnyFile, rec) = 0 then
  begin
    sLogoFN := rec.name;
    sExt    := ExtractFileExt( rec.name );
  end;

  if sLogoFN = '' then
    begin
      if source.image='' then
      begin
        img.NormalImage.Picture.Assign(nil);
        img.SmallImage.Picture.Assign(nil);
        Exit;
      end;

      HTMLData := GetHTML(source.image,'','', 5000, NO_CACHE, Info);



      sExt := ExtractFileExt( source.image);

      if HTMLData.OK = True then
      begin

        AssignFile(F, ExtractFilePath(PluginDllPath) + 'Logos\' + IntToStr(source.ID) + sExt);
        Rewrite(F);
        write(F,HTMLData.parString);
        CloseFile(F);

        sLogoFN := IntToStr(source.ID) + sExt;
      end;

    end;

  if StrPosE(HTMLData.parString, 'NOT FOUND',1,False) <> 0  then
    begin

      try
        DeleteFile( PChar( ExtractFilePath(PluginDllPath) + 'Logos\' + IntToStr(source.ID) + sExt ));
      finally

      end;

      img.NormalImage.Picture.Assign(nil);
      img.SmallImage.Picture.Assign(nil);
      Exit;

    end;


  FileName := ExtractFilePath(PluginDllPath) + 'Logos\' + sLogoFN;


  try
    GraphicClass := FileFormatList.GraphicFromContent(FileName);
    if GraphicClass = nil then
    begin
      img.NormalImage.Picture.Assign(nil);
      img.SmallImage.Picture.Assign(nil);
    end
    else
    begin
      Graphic := GraphicClass.Create;
      Graphic.LoadFromFile(FileName);
      img.NormalImage.Picture.Graphic := Graphic;
      img.SmallImage.Picture.Graphic := Graphic;

(*
      if   img.SmallImage.Picture.Width / img.SmallImage.Picture.Height  <  16 / 16 then
      begin                // obrazek je vyssi
        // Stretch Height to match.
        TargetArea.Top    := 0;
        TargetArea.Bottom := NewBitmapHeight;

        // Adjust and center Width.
        IWidth := MulDiv(NewBitmapHeight, img.SmallImage.Picture.Width, img.SmallImage.Picture.Height);
        IHalf := (NewBitmapWidth - IWidth) DIV 2;

        TargetArea.Left  := IHalf;
        TargetArea.Right := TargetArea.Left + IWidth;
      end
      else
      begin
        // Stretch Width to match.
        TargetArea.Left    := 0;
        TargetArea.Right   := NewBitmapWidth;

        // Adjust and center Height.
        IHeight := MulDiv(NewBitmapWidth, img.SmallImage.Picture.Height, img.SmallImage.Picture.Width);
        IHalf := (NewBitmapHeight - IHeight) DIV 2;

        TargetArea.Top    := IHalf;
        TargetArea.Bottom := TargetArea.Top + IHeight
      end;

{
      img.SmallImage.Picture.Width
      img.SmallImage.Picture.Height
}
      Stretch(TargetArea.Right - TargetArea.Left, TargetArea.Bottom - TargetArea.Top, TResamplingFilter(5), 0, img.SmallImage.Picture.Bitmap);
*)
      //img.SmallImage.Transparent := True;
      Stretch(16, 16, TResamplingFilter(5), 0, img.SmallImage.Picture.Bitmap);

      img.ExistLogo := True;
    end;

  except

  end;

end;

end.


