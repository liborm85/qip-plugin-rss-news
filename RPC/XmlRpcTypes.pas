
{*******************************************************}
{                                                       }
{ XML-RPC Library for Delphi, Kylix and DWPL (DXmlRpc)  }
{ XmlRpcTypes.pas                                       }
{                                                       }
{ for Delphi 6, 7                                       }
{ Release 2.0.0                                         }
{ Copyright (c) 2001-2003 by Team-DelphiXml-Rpc         }
{ e-mail: team-dxmlrpc@dwp42.org                        }
{ www: http://sourceforge.net/projects/delphixml-rpc/   }
{                                                       }
{ The initial developer of the code is                  }
{   Clifford E. Baeseman, codepunk@codepunk.com         }
{                                                       }
{ This file may be distributed and/or modified under    }
{ the terms of the GNU Lesser General Public License    }
{ (LGPL) version 2.1 as published by the Free Software  }
{ Foundation and appearing in the included file         }
{ license.txt.                                          }
{                                                       }
{*******************************************************}
{
  $Header: /cvsroot/delphixml-rpc/dxmlrpc/source/XmlRpcTypes.pas,v 1.1.1.1 2003/12/03 22:37:46 iwache Exp $
  ----------------------------------------------------------------------------

  $Log: XmlRpcTypes.pas,v $
  Revision 1.1.1.1  2003/12/03 22:37:46  iwache
  Initial import of release 2.0.0

  ----------------------------------------------------------------------------
}
unit XmlRpcTypes;

interface

uses
  SysUtils, Classes, Contnrs, DIMime, XmlRpcCommon;

type
  IRpcArray = interface;
  IRpcStruct = interface;

  TDataType = (dtFloat, dtInteger, dtString, dtBoolean, dtDateTime, dtBase64,
      dtStruct, dtArray, dtError, dtNone, dtName, dtValue);

  IRpcCustomItem = interface(IInterface)
  ['{3441C47B-364D-4BE6-834E-E05C4FCAE9A6}']
    function GetAsRawString: AnsiString;
    procedure SetAsRawString(const Value: AnsiString);
    function GetAsString: AnsiString;
    procedure SetAsString(const Value: AnsiString);
    function GetAsInteger: Integer;
    procedure SetAsInteger(Value: Integer);
    function GetAsFloat: Double;
    procedure SetAsFloat(Value: Double);
    function GetAsBoolean: Boolean;
    procedure SetAsBoolean(Value: Boolean);
    function GetAsDateTime: TDateTime;
    procedure SetAsDateTime(Value: TDateTime);
    function GetAsBase64Str: AnsiString;
    procedure SetAsBase64Str(const Value: AnsiString);
    function GetAsArray: IRpcArray;
    procedure SetAsArray(Value: IRpcArray);
    function GetAsStruct: IRpcStruct;
    procedure SetAsStruct(Value: IRpcStruct);
    function GetAsBase64Raw: AnsiString;
    procedure SetAsBase64Raw(const Value: AnsiString);
    function GetDataType: TDataType;

    procedure Clear;
    function IsArray: Boolean;
    function IsBase64: Boolean;
    function IsBoolean: Boolean;
    function IsDate: Boolean;
    function IsFloat: Boolean;
    function IsError: Boolean;
    function IsInteger: Boolean;
    function IsString: Boolean;
    function IsStruct: Boolean;
    procedure Base64StrLoadFromStream(Stream: TStream);
    procedure Base64StrSaveToStream(Stream: TStream);
    procedure Base64StrLoadFromFile(const FileName: AnsiString);
    procedure Base64StrSaveToFile(const FileName: AnsiString);
    property AsRawString: AnsiString read GetAsRawString write SetAsRawString;
    property AsString: AnsiString read GetAsString write SetAsString;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property AsFloat: Double read GetAsFloat write SetAsFloat;
    property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property AsBase64Str: AnsiString read GetAsBase64Str write SetAsBase64Str;
    property AsBase64Raw: AnsiString read GetAsBase64Raw write SetAsBase64Raw;
    property AsArray: IRpcArray read GetAsArray write SetAsArray;
    property AsStruct: IRpcStruct read GetAsStruct write SetAsStruct;
    property DataType: TDataType read GetDataType;
  end;

  TRpcCustomItem = class(TInterfacedObject)
  private
    FDataType: TDataType;
    FString: AnsiString;
    FInteger: Integer;
    FFloat: Double;
    FBoolean: Boolean;
    FDateTime: TDateTime;
    FBase64: AnsiString;
    FStruct: IRpcStruct;
    FArray: IRpcArray;
    function GetAsRawString: AnsiString;
    procedure SetAsRawString(const Value: AnsiString);
    function GetAsString: AnsiString;
    procedure SetAsString(const Value: AnsiString);
    function GetAsInteger: Integer;
    procedure SetAsInteger(Value: Integer);
    function GetAsFloat: Double;
    procedure SetAsFloat(Value: Double);
    function GetAsBoolean: Boolean;
    procedure SetAsBoolean(Value: Boolean);
    function GetAsDateTime: TDateTime;
    procedure SetAsDateTime(Value: TDateTime);
    function GetAsBase64Str: AnsiString;
    procedure SetAsBase64Str(const Value: AnsiString);
    function GetAsArray: IRpcArray;
    procedure SetAsArray(Value: IRpcArray);
    function GetAsStruct: IRpcStruct;
    function GetAsBase64Raw: AnsiString;
    procedure SetAsBase64Raw(const Value: AnsiString);
    function GetDataType: TDataType;
  protected
    procedure SetAsStruct(Value: IRpcStruct); virtual;
  public
    procedure Clear;
    function IsArray: Boolean;
    function IsBase64: Boolean;
    function IsBoolean: Boolean;
    function IsDate: Boolean;
    function IsFloat: Boolean;
    function IsError: Boolean;
    function IsInteger: Boolean;
    function IsString: Boolean;
    function IsStruct: Boolean;
    procedure Base64StrLoadFromStream(Stream: TStream); virtual;
    procedure Base64StrSaveToStream(Stream: TStream); virtual;
    procedure Base64StrLoadFromFile(const FileName: AnsiString); virtual;
    procedure Base64StrSaveToFile(const FileName: AnsiString); virtual;
    property AsRawString: AnsiString read GetAsRawString write SetAsRawString;
    property AsString: AnsiString read GetAsString write SetAsString;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property AsFloat: Double read GetAsFloat write SetAsFloat;
    property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property AsBase64Str: AnsiString read GetAsBase64Str write SetAsBase64Str;
    property AsBase64Raw: AnsiString read GetAsBase64Raw write SetAsBase64Raw;
    property AsArray: IRpcArray read GetAsArray write SetAsArray;
    property AsStruct: IRpcStruct read GetAsStruct write SetAsStruct;
    property DataType: TDataType read GetDataType;
  end;

  TRpcArrayItem = class(TRpcCustomItem)
  end;

  TRpcFunctionItem = class(TRpcCustomItem)
  end;

  TRpcStructItem = class(TRpcCustomItem)
  private
    FName: AnsiString;
  public
    property Name: AnsiString read FName write FName;
  end;

  IRpcResult = interface(IRpcCustomItem)
  ['{ACD2CA2C-65D1-4656-8FF1-F265237E090F}']
    function GetErrorCode: Integer;
    function GetErrorMsg: AnsiString;

    procedure SetError(Code: Integer; const Msg: AnsiString);
    function IsError: Boolean;
    property ErrorCode: Integer read GetErrorCode;
    property ErrorMsg: AnsiString read GetErrorMsg;
  end;

  TRpcResult = class(TRpcCustomItem, IRpcResult)
  private
    FErrorCode: Integer;
    FErrorMsg: AnsiString;
    function GetErrorCode: Integer;
    function GetErrorMsg: AnsiString;
  protected
    procedure SetAsStruct(Value: IRpcStruct); override;
  public
    procedure SetError(Code: Integer; const Msg: AnsiString);
    function IsError: Boolean;
    property ErrorCode: Integer read GetErrorCode;
    property ErrorMsg: AnsiString read GetErrorMsg;
  end;

  IRpcCustomArray = interface(IInterface)
  ['{8177A796-7C3B-4C01-901C-88A13DA61F85}']
    function GetItems(Index: Integer): TRpcArrayItem;
    procedure SetItems(Index: Integer; AItem: TRpcArrayItem);

    procedure AddItem(const Value: AnsiString); overload;
    procedure AddItem(Value: Integer); overload;
    procedure AddItem(Value: Boolean); overload;
    procedure AddItem(Value: Double); overload;
    procedure AddItem(Value: IRpcStruct); overload;
    procedure AddItem(Value: IRpcArray); overload;
    procedure AddItemBase64Raw(const Value: AnsiString);
    procedure AddItemBase64Str(const Value: AnsiString);
    procedure AddItemBase64StrFromFile(const FileName: AnsiString);
    procedure AddItemBase64StrFromStream(Stream: TStream);
    procedure AddItemDateTime(Value: TDateTime);
    procedure Clear;
    function Count: Integer;
    procedure Delete(Index: Integer);
    property Items[Index: Integer]: TRpcArrayItem read GetItems write SetItems;
        default;
  end;

  TRpcCustomArray = class(TInterfacedObject)
  private
    FList: TObjectList;
    function InternalAddItem: TRpcArrayItem;
  protected
    function GetItems(Index: Integer): TRpcArrayItem;
    procedure SetItems(Index: Integer; AItem: TRpcArrayItem);
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddItem(const Value: AnsiString); overload;
    procedure AddItem(Value: Integer); overload;
    procedure AddItem(Value: Boolean); overload;
    procedure AddItem(Value: Double); overload;
    procedure AddItem(Value: IRpcStruct); overload;
    procedure AddItem(Value: IRpcArray); overload;
    procedure AddItemBase64Raw(const Value: AnsiString);
    procedure AddItemBase64Str(const Value: AnsiString);
    procedure AddItemBase64StrFromFile(const FileName: AnsiString);
    procedure AddItemBase64StrFromStream(Stream: TStream);
    procedure AddItemDateTime(Value: TDateTime);
    procedure Clear; virtual;
    function Count: Integer;
    procedure Delete(Index: Integer);
    property Items[Index: Integer]: TRpcArrayItem read GetItems write SetItems;
        default;
  end;

  IRpcArray = interface(IRpcCustomArray)
  ['{595D98EE-1718-44ED-94E2-0F8F7A85C247}']
    function GetAsXML: AnsiString;
    procedure LoadRawData(DataType: TDataType; Value: AnsiString);
  end;

  TRpcArray = class(TRpcCustomArray, IRpcArray)
  public
    function GetAsXML: AnsiString;
    procedure LoadRawData(DataType: TDataType; Value: AnsiString);
  end;

  IRpcStruct = interface(IInterface)
  ['{7527E27A-6B61-41D6-9546-93DC816D8285}']
    function InternalAddItem(const Key: AnsiString): TRpcStructItem;
    function GetKeyList: TStringList;

    function GetItems(Index: Integer): TRpcStructItem;
    procedure SetItems(Index: Integer; AItem: TRpcStructItem);
    function GetKeys(Key: AnsiString): TRpcStructItem;
    procedure SetKeys(Key: AnsiString; const AItem: TRpcStructItem);

    procedure AddItem(const Key: AnsiString; Value: Integer); overload;
    procedure AddItem(const Key: AnsiString; const Value: AnsiString); overload;
    procedure AddItem(const Key: AnsiString; Value: Double); overload;
    procedure AddItem(const Key: AnsiString; Value: Boolean); overload;
    procedure AddItem(const Key: AnsiString; Value: IRpcArray); overload;
    procedure AddItem(const Key: AnsiString; Value: IRpcStruct); overload;
    procedure AddItemDateTime(const Key: AnsiString; Value: TDateTime);
    procedure AddItemBase64Str(const Key: AnsiString; const Value: AnsiString);
    procedure AddItemBase64Raw(const Key: AnsiString; const Value: AnsiString);
    procedure AddItemBase64StrFromFile(const Key: AnsiString; const FileName: AnsiString);
    procedure AddItemBase64StrFromStream(const Key: AnsiString; Stream: TStream);
    function KeyExists(const Key: AnsiString): Boolean;
    procedure Delete(Index: Integer); overload;
    procedure Delete(const Key: AnsiString); overload;
    procedure Clear;
    function Count: Integer;
    function IndexOf(const Key: AnsiString): Integer;
    function GetAsXML: AnsiString;
    procedure LoadRawData(DataType: TDataType; const Key, Value: AnsiString);
    property KeyList: TStringList read GetKeyList;
    property Items[Index: Integer]: TRpcStructItem read GetItems write SetItems;
    property Keys[Key: AnsiString]: TRpcStructItem read GetKeys write SetKeys; default;
  end;

  TRpcStruct = class(TInterfacedObject, IRpcStruct)
  private
    FKeyList: TStringList;
    function InternalAddItem(const Key: AnsiString): TRpcStructItem;
    function GetKeyList: TStringList;
  protected
    function GetItems(Index: Integer): TRpcStructItem;
    procedure SetItems(Index: Integer; AItem: TRpcStructItem);
    function GetKeys(Key: AnsiString): TRpcStructItem;
    procedure SetKeys(Key: AnsiString; const AItem: TRpcStructItem);
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddItem(const Key: AnsiString; Value: Integer); overload;
    procedure AddItem(const Key: AnsiString; const Value: AnsiString); overload;
    procedure AddItem(const Key: AnsiString; Value: Double); overload;
    procedure AddItem(const Key: AnsiString; Value: Boolean); overload;
    procedure AddItem(const Key: AnsiString; Value: IRpcArray); overload;
    procedure AddItem(const Key: AnsiString; Value: IRpcStruct); overload;
    procedure AddItemDateTime(const Key: AnsiString; Value: TDateTime);
    procedure AddItemBase64Str(const Key: AnsiString; const Value: AnsiString);
    procedure AddItemBase64Raw(const Key: AnsiString; const Value: AnsiString);
    procedure AddItemBase64StrFromFile(const Key: AnsiString; const FileName: AnsiString);
    procedure AddItemBase64StrFromStream(const Key: AnsiString; Stream: TStream);
    function KeyExists(const Key: AnsiString): Boolean;
    procedure Delete(Index: Integer); overload;
    procedure Delete(const Key: AnsiString); overload;
    procedure Clear;
    function Count: Integer;
    function IndexOf(const Key: AnsiString): Integer;
    function GetAsXML: AnsiString;
    procedure LoadRawData(DataType: TDataType; const Key, Value: AnsiString);
    property KeyList: TStringList read GetKeyList;
    property Items[Index: Integer]: TRpcStructItem read GetItems write SetItems;
    property Keys[Key: AnsiString]: TRpcStructItem read GetKeys write SetKeys; default;
  end;

  IRpcFunction = interface(IRpcCustomArray)
  ['{8177A796-7C3B-4C01-901C-88A13DA61F85}']
    function GetRequestXML: AnsiString;
    function GetResponseXML: AnsiString;
    function GetErrorXML: AnsiString;
    function GetObjectMethod: AnsiString;
    procedure SetObjectMethod(const Value: AnsiString);

    procedure Clear;
    procedure SetError(Code: Integer; const Msg: AnsiString);
    property ObjectMethod: AnsiString read GetObjectMethod write SetObjectMethod;
    property RequestXML: AnsiString read GetRequestXML;
    property ResponseXML: AnsiString read GetResponseXML;
    property ErrorXML: AnsiString read GetErrorXML;
  end;

  TRpcFunction = class(TRpcCustomArray, IRpcFunction)
  private
    FObjectMethod: AnsiString;
    FErrorCode: Integer;
    FErrorMsg: AnsiString;
    function GetRequestXML: AnsiString;
    function GetResponseXML: AnsiString;
    function GetErrorXML: AnsiString;
    procedure GetBodyXML(Strings: TStrings);
    function GetObjectMethod: AnsiString;
    procedure SetObjectMethod(const Value: AnsiString);
  public
    procedure Clear; override;
    procedure SetError(Code: Integer; const Msg: AnsiString);
    property ObjectMethod: AnsiString read GetObjectMethod write SetObjectMethod;
    property RequestXML: AnsiString read GetRequestXML;
    property ResponseXML: AnsiString read GetResponseXML;
    property ErrorXML: AnsiString read GetErrorXML;
  end;

  EXmlRpcError = class(Exception)
  end;

  TRpcParameter = TRpcResult;
  TRpcReturn = TRpcFunction;

implementation

{
******************************** TCustomItem ***********************************
}

procedure TRpcCustomItem.Clear;
begin
  FDataType := dtNone;
  FString := '';
  FBase64 := '';
  FStruct := nil;
  FArray := nil;
end;

function TRpcCustomItem.GetAsRawString: AnsiString;
begin
  if (FDataType = dtString) then
    Result := FString
  else
    raise EXmlRpcError.Create('Item is not a string type')
end;

procedure TRpcCustomItem.SetAsRawString(const Value: AnsiString);
begin
  Clear;
  FDataType := dtString;
  FString := Value;
end;

function TRpcCustomItem.GetAsString: AnsiString;
begin
  Result := DecodeEntities(AsRawString);
end;

procedure TRpcCustomItem.SetAsString(const Value: AnsiString);
begin
  AsRawString := EncodeEntities(Value);
end;

function TRpcCustomItem.GetAsInteger: Integer;
begin
  if (FDataType = dtInteger) then
    Result := FInteger
  else
    raise EXmlRpcError.Create('Item is not a integer type')
end;

procedure TRpcCustomItem.SetAsInteger(Value: Integer);
begin
  Clear;
  FDataType := dtInteger;
  FInteger := Value;
end;

function TRpcCustomItem.GetAsFloat: Double;
begin
  if (FDataType = dtFloat) then
    Result := FFloat
  else
    raise EXmlRpcError.Create('Item is not a double type')
end;

procedure TRpcCustomItem.SetAsFloat(Value: Double);
begin
  Clear;
  FDataType := dtFloat;
  FFloat := Value;
end;

function TRpcCustomItem.GetAsBoolean: Boolean;
begin
  if (FDataType = dtBoolean) then
    Result := FBoolean
  else
    raise EXmlRpcError.Create('Item is not a boolean type')
end;

procedure TRpcCustomItem.SetAsBoolean(Value: Boolean);
begin
  Clear;
  FDataType := dtBoolean;
  FBoolean := Value;
end;

function TRpcCustomItem.GetAsDateTime: TDateTime;
begin
  if (FDataType = dtDateTime) then
    Result := FDateTime
  else
    raise EXmlRpcError.Create('Item is not a date type')
end;

procedure TRpcCustomItem.SetAsDateTime(Value: TDateTime);
begin
  Clear;
  FDataType := dtDateTime;
  FDateTime := Value;
end;

function TRpcCustomItem.GetAsBase64Str: AnsiString;
begin
  if (FDataType = dtBase64) then
    Result := MimeDecodeString(FBase64)
  else
    raise
      EXmlRpcError.Create('Item is not a base64 type')
end;

procedure TRpcCustomItem.SetAsBase64Str(const Value: AnsiString);
begin
  Clear;
  FDataType := dtBase64;
  FBase64 := MimeEncodeString{NoCRLF}(Value);
end;

function TRpcCustomItem.GetAsArray: IRpcArray;
begin
  if (FDataType = dtArray) then
    Result := FArray
  else
    raise EXmlRpcError.Create('Item is not a array type')
end;

procedure TRpcCustomItem.SetAsArray(Value: IRpcArray);
begin
  Clear;
  FDataType := dtArray;
  FArray := Value;
end;

function TRpcCustomItem.GetAsStruct: IRpcStruct;
begin
  if (FDataType = dtStruct) then
    Result := FStruct
  else
    raise EXmlRpcError.Create('Item is not a struct type')
end;

procedure TRpcCustomItem.SetAsStruct(Value: IRpcStruct);
begin
  Clear;
  FDataType := dtStruct;
  FStruct := Value;
end;

function TRpcCustomItem.GetAsBase64Raw: AnsiString;
begin
  if (FDataType = dtBase64) then
    Result := FBase64
  else
    raise EXmlRpcError.Create('Item is not a base64 type')
end;

procedure TRpcCustomItem.SetAsBase64Raw(const Value: AnsiString);
begin
  Clear;
  FDataType := dtBase64;
  FBase64 := Value;
end;

function TRpcCustomItem.IsArray: Boolean;
begin
  Result := (FDataType = dtArray);
end;

function TRpcCustomItem.IsBase64: Boolean;
begin
  Result := (FDataType = dtBase64);
end;

function TRpcCustomItem.IsBoolean: Boolean;
begin
  Result := (FDataType = dtBoolean);
end;

function TRpcCustomItem.IsDate: Boolean;
begin
  Result := (FDataType = dtDateTime);
end;

function TRpcCustomItem.IsFloat: Boolean;
begin
  Result := (FDataType = dtFloat);
end;

function TRpcCustomItem.IsError: Boolean;
begin
  Result := (FDataType = dtError);
end;

function TRpcCustomItem.IsInteger: Boolean;
begin
  Result := (FDataType = dtInteger);
end;

function TRpcCustomItem.IsString: Boolean;
begin
  Result := (FDataType = dtString);
end;

function TRpcCustomItem.IsStruct: Boolean;
begin
  Result := (FDataType = dtStruct);
end;

procedure TRpcCustomItem.Base64StrSaveToStream(Stream: TStream);
begin
  StringToStream(AsBase64Str, Stream);
end;

procedure TRpcCustomItem.Base64StrSaveToFile(const FileName: AnsiString);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    Base64StrSaveToStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TRpcCustomItem.Base64StrLoadFromStream(Stream: TStream);
begin
  AsBase64Str := StreamToString(Stream);
end;

procedure TRpcCustomItem.Base64StrLoadFromFile(const FileName: AnsiString);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    Base64StrLoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

function TRpcCustomItem.GetDataType: TDataType;
begin
  Result := FDataType;
end;


{
******************************** TResult ***************************************
}

function TRpcResult.GetErrorCode: Integer;
begin
  if (FDataType = dtError) then
    Result := FErrorCode
  else
    raise EXmlRpcError.Create('Item is not an error type')
end;

function TRpcResult.GetErrorMsg: AnsiString;
begin
  if (FDataType = dtError) then
    Result := FErrorMsg
  else
    raise EXmlRpcError.Create('Item is not an error type');
end;

procedure TRpcResult.SetError(Code: Integer; const Msg: AnsiString);
begin
  Clear;
  FDataType := dtError;
  FErrorCode := Code;
  FErrorMsg := Msg;
end;

function TRpcResult.IsError: Boolean;
begin
  Result := (FDataType = dtError);
end;

procedure TRpcResult.SetAsStruct(Value: IRpcStruct);
begin
  if Value.KeyExists('faultCode') then
    SetError(Value['faultCode'].AsInteger, Value['faultString'].AsString)
  else
    inherited SetAsStruct(Value);
end;

{
******************************** TCustomArray **********************************
}

constructor TRpcCustomArray.Create;
begin
  FList := TObjectList.Create(True);
end;

destructor TRpcCustomArray.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

function TRpcCustomArray.InternalAddItem: TRpcArrayItem;
var
  ArrayItem: TRpcArrayItem;
begin
  ArrayItem := TRpcArrayItem.Create;
  try
    FList.Add(ArrayItem);
    Result := ArrayItem;
    ArrayItem := nil;
  finally
    ArrayItem.Free;
  end;
end;

procedure TRpcCustomArray.AddItem(const Value: AnsiString);
begin
  InternalAddItem.AsString := Value;
end;

procedure TRpcCustomArray.AddItem(Value: Integer);
begin
  InternalAddItem.AsInteger := Value;
end;

procedure TRpcCustomArray.AddItem(Value: Boolean);
begin
  InternalAddItem.AsBoolean := Value;
end;

procedure TRpcCustomArray.AddItem(Value: Double);
begin
  InternalAddItem.AsFloat := Value;
end;

procedure TRpcCustomArray.AddItem(Value: IRpcStruct);
begin
  InternalAddItem.AsStruct := Value;
end;

procedure TRpcCustomArray.AddItem(Value: IRpcArray);
begin
  InternalAddItem.AsArray := Value;
end;

procedure TRpcCustomArray.AddItemBase64Raw(const Value: AnsiString);
begin
  InternalAddItem.AsBase64Raw := Value;
end;

procedure TRpcCustomArray.AddItemBase64Str(const Value: AnsiString);
begin
  InternalAddItem.AsBase64Str := MimeEncodeStringNoCRLF(Value);
end;

procedure TRpcCustomArray.AddItemBase64StrFromFile(const FileName: AnsiString);
begin
  InternalAddItem.Base64StrLoadFromFile(FileName);
end;

procedure TRpcCustomArray.AddItemBase64StrFromStream(Stream: TStream);
begin
  InternalAddItem.Base64StrLoadFromStream(Stream);
end;

procedure TRpcCustomArray.AddItemDateTime(Value: TDateTime);
begin
  InternalAddItem.AsDateTime := Value;
end;

procedure TRpcCustomArray.Clear;
begin
  FList.Clear;
  FList.Pack;
end;

function TRpcCustomArray.Count: Integer;
begin
  Result := FList.Count;
end;

procedure TRpcCustomArray.Delete(Index: Integer);
begin
  FList.Delete(Index);
end;

function TRpcCustomArray.GetItems(Index: Integer): TRpcArrayItem;
begin
  Result := TRpcArrayItem(FList[Index]);
end;

procedure TRpcCustomArray.SetItems(Index: Integer; AItem: TRpcArrayItem);
begin
  FList[Index] := AItem;
end;


{
******************************** TArray ****************************************
}

function TRpcArray.GetAsXML: AnsiString;
var
  Index: Integer;
  Strings: TStrings;
begin
  Strings := TStringList.Create;
  try
    Strings.Add('<value>');
    Strings.Add('  <array>');
    Strings.Add('    <data>');
    for Index := 0 to Count - 1 do
    begin
      case Items[Index].DataType of
        dtString: Strings.Add('      <value><string>' +
            Items[Index].AsString +
            '</string></value>');
        dtInteger: Strings.Add('      <value><int>' +
            IntToStr(Items[Index].AsInteger) +
            '</int></value>');
        dtFloat: Strings.Add('      <value><double>' +
            FloatToStr(Items[Index].AsFloat) +
            '</double></value>');
        dtBase64: Strings.Add('      <value><base64>' +
            Items[Index].AsBase64Raw +
            '      </base64></value>');
        dtDateTime: Strings.Add('      <value><dateTime.iso8601>' +
            DateTimeToISO(Items[Index].AsDateTime) +
            '</dateTime.iso8601></value>');
        dtBoolean:
          if Items[Index].AsBoolean then
            Strings.Add('      <value><boolean>1</boolean></value>')
          else
            Strings.Add('      <value><boolean>0</boolean></value>');
        dtStruct: Strings.Add(Items[Index].AsStruct.GetAsXML);
        dtArray: Strings.Add(Items[Index].AsArray.GetAsXML);
      end;
    end;
    Strings.Add('  </data>');
    Strings.Add('</array>');
    Strings.Add('</value>');
    Result := Strings.Text;
  finally
    Strings.Free;
  end;
end;

procedure TRpcArray.LoadRawData(DataType: TDataType; Value: AnsiString);
begin
  case DataType of
    dtString:
      AddItem(Value);
    dtInteger:
      AddItem(StrToInt(Value));
    dtFloat:
      AddItem(StrToFloat(Value));
    dtBoolean:
      AddItem(StrToBool(Value));
    dtDateTime:
      AddItemDateTime(IsoToDateTime(Value));
    dtBase64:
      AddItemBase64Raw(Value);
  end;
end;


{
******************************** TStruct ***************************************
}

constructor TRpcStruct.Create;
begin
  FKeyList := TStringList.Create;
end;

destructor TRpcStruct.Destroy;
begin
  FKeyList.Free;
  inherited Destroy;
end;

function TRpcStruct.GetKeyList: TStringList;
begin
  Result := FKeyList;
end;

function TRpcStruct.GetItems(Index: Integer): TRpcStructItem;
begin
  Result := TRpcStructItem(FKeyList.Objects[Index]);
end;

procedure TRpcStruct.SetItems(Index: Integer; AItem: TRpcStructItem);
begin
  FKeyList.Objects[Index] := AItem;
end;

function TRpcStruct.IndexOf(const Key: AnsiString): Integer;
begin
  Result := FKeyList.IndexOf(Key);
  if Result < 0 then
    raise EXmlRpcError.CreateFmt('Key [%s] not found', [Key]);
end;

function TRpcStruct.GetKeys(Key: AnsiString): TRpcStructItem;
begin
  Result := TRpcStructItem(FKeyList.Objects[IndexOf(Key)]);
end;

procedure TRpcStruct.SetKeys(Key: AnsiString; const AItem: TRpcStructItem);
begin
  FKeyList.Objects[IndexOf(Key)] := AItem;
end;

function TRpcStruct.Count: Integer;
begin
  Result := FKeyList.Count;
end;

function TRpcStruct.KeyExists(const Key: AnsiString): Boolean;
begin
  Result := (FKeyList.IndexOf(Key) >= 0);
end;

procedure TRpcStruct.Delete(Index: Integer);
begin
  Items[Index].Free;
  FKeyList.Delete(Index);
end;

procedure TRpcStruct.Delete(const Key: AnsiString);
begin
  Delete(IndexOf(Key));
end;

procedure TRpcStruct.Clear;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].Free;
  FKeyList.Clear;
end;

function TRpcStruct.InternalAddItem(const Key: AnsiString): TRpcStructItem;
var
  StructItem: TRpcStructItem;
begin
  StructItem := TRpcStructItem.Create;
  try
    FKeyList.AddObject(Key, StructItem);
    Result := StructItem;
    StructItem := nil;
  finally
    StructItem.Free;
  end;
end;

procedure TRpcStruct.AddItem(const Key, Value: AnsiString);
begin
  InternalAddItem(Key).AsString := Value;
end;

procedure TRpcStruct.AddItem(const Key: AnsiString; Value: Double);
begin
  InternalAddItem(Key).AsFloat := Value;
end;

procedure TRpcStruct.AddItem(const Key: AnsiString; Value: Integer);
begin
  InternalAddItem(Key).AsInteger := Value;
end;

procedure TRpcStruct.AddItem(const Key: AnsiString; Value: IRpcArray);
begin
  InternalAddItem(Key).AsArray := Value;
end;

procedure TRpcStruct.AddItem(const Key: AnsiString; Value: Boolean);
begin
  InternalAddItem(Key).AsBoolean := Value;
end;

procedure TRpcStruct.AddItemDateTime(const Key: AnsiString; Value: TDateTime);
begin
  InternalAddItem(Key).AsDateTime := Value;
end;

procedure TRpcStruct.AddItem(const Key: AnsiString; Value: IRpcStruct);
begin
  InternalAddItem(Key).AsStruct := Value;
end;

procedure TRpcStruct.AddItemBase64Str(const Key, Value: AnsiString);
begin
  InternalAddItem(Key).AsBase64Str := Value;
end;

procedure TRpcStruct.AddItemBase64Raw(const Key, Value: AnsiString);
begin
  InternalAddItem(Key).AsBase64Raw := Value;
end;

procedure TRpcStruct.AddItemBase64StrFromFile(const Key: AnsiString; const FileName:
    AnsiString);
begin
  InternalAddItem(Key).Base64StrLoadFromFile(FileName);
end;

procedure TRpcStruct.AddItemBase64StrFromStream(const Key: AnsiString; Stream:
    TStream);
begin
  InternalAddItem(Key).Base64StrLoadFromStream(Stream);
end;

function TRpcStruct.GetAsXML: AnsiString;
var
  I: Integer;
  Strings: TStrings;
begin
  Strings := TStringList.Create;
  try
    Strings.Add('<value>');
    Strings.Add('  <struct>');
    for I := 0 to Count - 1 do
    begin
      Strings.Add('    <member>');
      case Items[I].DataType of
        dtString:
          begin
            Strings.Add('      <name>' + KeyList[I] + '</name>');
            Strings.Add('      <value><string>' +  Items[I].AsRawString
                + '</string></value>');
          end;
        dtInteger:
          begin
            Strings.Add('      <name>' + KeyList[I] + '</name>');
            Strings.Add('      <value><int>' + IntToStr(Items[I].AsInteger) +
                '</int></value>');
          end;
        dtFloat:
          begin
            Strings.Add('      <name>' + KeyList[I] + '</name>');
            Strings.Add('      <value><double>' + FloatToStr(Items[I].AsFloat) +
                '</double></value>');
          end;
        dtBase64:
          begin
            Strings.Add('      <name>' + KeyList[I] + '</name>');
            Strings.Add('      <value><base64>' + Items[I].AsBase64Raw +
                '</base64></value>');
          end;
        dtDateTime:
          begin
            Strings.Add('      <name>' + KeyList[I] + '</name>');
            Strings.Add('      <value><dateTime.iso8601>' +
              DateTimeToISO(Items[I].AsDateTime) +
              '</dateTime.iso8601></value>');
          end;
        dtBoolean:
          begin
            Strings.Add('      <name>' +
              KeyList[I] +
              '</name>');
            if Items[I].AsBoolean then
              Strings.Add('      <value><boolean>1</boolean></value>')
            else
              Strings.Add('      <value><boolean>0</boolean></value>');
          end;
        dtStruct:
          begin
            Strings.Add('      <name>' + KeyList[I] + '</name>');
            Strings.Add(Items[I].AsStruct.GetAsXML);
          end;
        dtArray:
          begin
            Strings.Add('      <name>' + KeyList[I] + '</name>');
            Strings.Add(Items[I].AsArray.GetAsXML);
          end;
      end;
      Strings.Add('    </member>');
    end;
    Strings.Add('  </struct>');
    Strings.Add('</value>');
    Result := Strings.Text;
  finally
    Strings.Free;
  end;
end;

procedure TRpcStruct.LoadRawData(DataType: TDataType; const Key, Value: AnsiString);
begin
  case DataType of
    dtString:
      AddItem(Key, Value);
    dtInteger:
      AddItem(Key, StrToInt(Value));
    dtBoolean:
      AddItem(Key, StrToBool(Value));
    dtFloat:
      AddItem(Key, StrToFloat(Value));
    dtDateTime:
      AddItemDateTime(Key, IsoToDateTime(Value));
    dtBase64:
      AddItemBase64Raw(Key, Value);
  end;
end;

{
******************************** TFunction *************************************
}

function TRpcFunction.GetObjectMethod: AnsiString;
begin
  Result := FObjectMethod;
end;

procedure TRpcFunction.SetObjectMethod(const Value: AnsiString);
begin
  FObjectMethod := Value;
end;

procedure TRpcFunction.Clear;
begin
  FErrorCode := 0;
  FObjectMethod := '';
  inherited Clear;
end;

procedure TRpcFunction.SetError(Code: Integer; const Msg: AnsiString);
begin
  Clear;
  FErrorCode := Code;
  FErrorMsg := Msg;
end;

function TRpcFunction.GetRequestXML: AnsiString;
var
  Strings: TStrings;
begin
  Strings := TStringList.Create;
  try
    Strings.Add('<?xml version="1.0"?>' + #13#10);
    Strings.Add('<methodCall>' + #13#10);
    Strings.Add('   <methodName>' + FObjectMethod + '</methodName>' + #13#10);
    GetBodyXML(Strings);
    Strings.Add('</methodCall>' + #13#10);
    Result := Strings.Text;
  finally
    Strings.Free;
  end;
end;

function TRpcFunction.GetResponseXML: AnsiString;
var
  Strings: TStrings;
begin
  {if we have a error condition return the error instead}
  if FErrorCode > 0 then
  begin
    Result := GetErrorXML;
    Exit;
  end;

  Strings := TStringList.Create;
  try
    Strings.Add('<?xml version="1.0"?>' + #13#10);
    Strings.Add('<methodResponse>' + #13#10);
    GetBodyXML(Strings);
    Strings.Add('</methodResponse>' + #13#10);
    Result := Strings.Text;
  finally
    Strings.Free;
  end;
end;

function TRpcFunction.GetErrorXML: AnsiString;
var
  Strings: TStrings;
begin
  Strings := TStringList.Create;
  try
    Strings.Add('<?xml version="1.0"?>' + #13#10);
    Strings.Add('<methodResponse>' + #13#10);
    Strings.Add('   <fault>' + #13#10);
    Strings.Add('      <value>' + #13#10);
    Strings.Add('        <struct>' + #13#10);
    Strings.Add('            <member>' + #13#10);
    Strings.Add('               <name>faultCode</name>' + #13#10);
    Strings.Add('               <value><int>' + IntToStr(FErrorCode)
        + '</int></value>' + #13#10);
    Strings.Add('               </member>' + #13#10);
    Strings.Add('            <member>' + #13#10);
    Strings.Add('               <name>faultString</name>' + #13#10);
    Strings.Add('               <value><string>' + FErrorMsg
        + '</string></value>' + #13#10);
    Strings.Add('               </member>' + #13#10);
    Strings.Add('            </struct>' + #13#10);
    Strings.Add('         </value>' + #13#10);
    Strings.Add('      </fault>' + #13#10);
    Strings.Add('   </methodResponse>' + #13#10);
    Result := Strings.Text;
  finally
    Strings.Free;
  end;
end;

procedure TRpcFunction.GetBodyXML(Strings: TStrings);
var
  I: Integer;
begin
  Strings.Add('   <params>' + #13#10);
  for I := 0 to Count - 1 do
  begin
    Strings.Add('   <param>' + #13#10);
    case Items[I].DataType of
      dtInteger:
        Strings.Add('<value><int>' +
          IntToStr(Items[I].AsInteger) +
          '</int></value>' + #13#10);
      dtString:
        Strings.Add('<value><string>' +
          Items[I].AsRawString +
          '</string></value>' + #13#10);
      dtFloat:
        Strings.Add('<value><double>' +
          FloatToStr(Items[I].AsFloat) +
          '</double></value>' + #13#10);
      dtBoolean:
        if Items[I].AsBoolean then
          Strings.Add('<value><boolean>1</boolean></value>' + #13#10)
        else
          Strings.Add('<value><boolean>0</boolean></value>' + #13#10);
      dtDateTime:
        Strings.Add('<value><dateTime.iso8601>' +
          DateTimeToISO(Items[I].AsDateTime) +
          '</dateTime.iso8601></value>' + #13#10);
      dtArray:
        Strings.Add(Items[I].AsArray.GetAsXML + #13#10);
      dtStruct:
        Strings.Add(Items[I].AsStruct.GetAsXML + #13#10);
      dtBase64:
        Strings.Add('<value><base64>' + Items[I].AsBase64Raw
            + '</base64></value>' + #13#10);
    end;
    Strings.Add('   </param>' + #13#10);
  end;
  Strings.Add('   </params>' + #13#10);
end;

end.

