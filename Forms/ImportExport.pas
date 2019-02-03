unit ImportExport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ImgList, ExtCtrls, StdCtrls, Buttons, inifiles;

type

  { Tree Feed }
  TTreeFeed = class
  public
    TreeNode       : TTreeNode;
    ID             : Integer;

    Style          : Integer;

    Name           : WideString;
    URL            : WideString;
    Topic          : WideString;

    LoginName      : WideString;
    LoginPassword  : WideString;

    Options        : WideString;
  end;


  { Tree CL }
  TTreeCL = class
  public
    TreeNode       : TTreeNode;
    ID             : Integer;

    Group          : WideString;

    Name           : WideString;
    Topic          : WideString;
    Options        : WideString;
    Font           : WideString;

    Feed           : TStringList;
  end;

  TfrmImportExport = class(TForm)
    tvData: TTreeView;
    ImageList1: TImageList;
    pnlTree: TPanel;
    pnlImport: TPanel;
    pnlExport: TPanel;
    pnlButtons: TPanel;
    btnCancel: TButton;
    btnImportExport: TButton;
    lblImport: TLabel;
    edtImport: TEdit;
    btnImportBrowse: TBitBtn;
    lblExport: TLabel;
    edtExport: TEdit;
    btnExportBrowse: TBitBtn;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    btnOpen: TButton;
    chkExportOptions: TCheckBox;
    chkExportFont: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tvDataClick(Sender: TObject);
    procedure tvDataKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnImportBrowseClick(Sender: TObject);
    procedure btnExportBrowseClick(Sender: TObject);
    procedure btnImportExportClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    procedure LoadTree;
  end;

const
//ImageList.StateIndex=0 has some bugs, so we add one dummy image to position 0
cFlatUnCheck = 1;
cFlatChecked = 2;
cFlatRadioUnCheck = 3;
cFlatRadioChecked = 4;  

var
  frmImportExport: TfrmImportExport;
  RSSData : TStringList;

implementation

uses General, uLNG, u_lang_ids, TextSearch, Convs, DownloadFile,
  uOptions,
  SQLiteTable3, SQLiteFuncs;


{$R *.dfm}

procedure ToggleTreeViewCheckBoxes(
   Node             :TTreeNode; 
   cUnChecked,
   cChecked, 
   cRadioUnchecked, 
   cRadioChecked    :integer);
var
  tmp:TTreeNode;
begin
  if Assigned(Node) then
  begin
    if Node.StateIndex = cUnChecked then
      Node.StateIndex := cChecked
    else if Node.StateIndex = cChecked then
      Node.StateIndex := cUnChecked
    else if Node.StateIndex = cRadioUnChecked then
    begin
      tmp := Node.Parent;
      if not Assigned(tmp) then
        tmp := TTreeView(Node.TreeView).Items.getFirstNode
      else
        tmp := tmp.getFirstChild;
      while Assigned(tmp) do
      begin
        if (tmp.StateIndex in 
                   [cRadioUnChecked,cRadioChecked]) then
          tmp.StateIndex := cRadioUnChecked;
        tmp := tmp.getNextSibling;
      end;
      Node.StateIndex := cRadioChecked;
    end; // if StateIndex = cRadioUnChecked
  end; // if Assigned(Node)
end; (*ToggleTreeViewCheckBoxes*)


procedure TfrmImportExport.LoadTree;
var idxCL, idxFeed: Int64;
begin

  tvData.Items.Clear;

  idxCL:=0;
  while ( idxCL<= RSSData.Count - 1 ) do
  begin

    TTreeCL(RSSData.Objects[idxCL]).TreeNode := tvData.Items.Add( nil, TTreeCL(RSSData.Objects[idxCL]).Name );
    TTreeCL(RSSData.Objects[idxCL]).TreeNode.StateIndex := cFlatChecked;


    idxFeed:=0;
    while ( idxFeed<= TTreeCL(RSSData.Objects[idxCL]).Feed.Count - 1 ) do
    begin
      Application.ProcessMessages;

      TTreeFeed(TTreeCL(RSSData.Objects[idxCL]).Feed.Objects[idxFeed]).TreeNode := tvData.Items.AddChild( TTreeCL(RSSData.Objects[idxCL]).TreeNode, TTreeFeed(TTreeCL(RSSData.Objects[idxCL]).Feed.Objects[idxFeed]).Name );
      TTreeFeed(TTreeCL(RSSData.Objects[idxCL]).Feed.Objects[idxFeed]).TreeNode.StateIndex := {cFlatChecked} -1;

      Inc(idxFeed);
    end;

    //tnCLLast.Expand(True);

    Inc(idxCL);
  end;

  tvData.FullExpand;

  if RSSData.Count > 0 then
    TTreeCL(RSSData.Objects[0]).TreeNode.MakeVisible;

end;


procedure TfrmImportExport.btnExportBrowseClick(Sender: TObject);
var INI: TIniFile;
begin
  INI := TiniFile.Create(ExtractFilePath(PluginDllPath) + Account_FileName + '.ini');
  SaveDialog1.FileName := UTF82WideString( INI.ReadString('Import Export', 'ExportFileName', '') );
  INI.Free;

  SaveDialog1.Title := Caption;
//  SaveDialog1.InitialDir := GetCurrentDir;
  SaveDialog1.Options := [ofFileMustExist];
  SaveDialog1.Filter :='*.rnx|*.rnx';
  SaveDialog1.DefaultExt := 'rnx';
  //  SaveDialog.FilterIndex := 2;

  if SaveDialog1.Execute then
  begin
    edtExport.Text := SaveDialog1.FileName;

    INI := TiniFile.Create(ExtractFilePath(PluginDllPath) + Account_FileName + '.ini');
    INI.WriteString('Import Export', 'ExportFileName', WideString2UTF8(SaveDialog1.FileName) );
    INI.Free;
  end;

end;

procedure TfrmImportExport.btnImportBrowseClick(Sender: TObject);
var INI: TIniFile;
begin

  INI := TiniFile.Create(ExtractFilePath(PluginDllPath) + Account_FileName + '.ini');
  OpenDialog1.FileName := UTF82WideString( INI.ReadString('Import Export', 'ImportFileName', '') );
  INI.Free;

  
  OpenDialog1.Title := Caption;
//  OpenDialog1.InitialDir := GetCurrentDir;
  OpenDialog1.Options := [ofFileMustExist];
  OpenDialog1.Filter := '*.rnx|*.rnx';
       //  openDialog.FilterIndex := 2;

  if OpenDialog1.Execute then
  begin
    edtImport.Text := OpenDialog1.FileName;

    INI := TiniFile.Create(ExtractFilePath(PluginDllPath) + Account_FileName + '.ini');
    INI.WriteString('Import Export', 'ImportFileName', WideString2UTF8(OpenDialog1.FileName) );
    INI.Free;
  end;



end;

procedure TfrmImportExport.btnImportExportClick(Sender: TObject);
var idxCL, idxFeed: Int64;
    F: TextFile;
    utf8Line: UTF8String;
    SQLtb     : TSQLiteTable;
    sSQL : WideString;
    iID, iIDFeed       : Int64;
    idxAddCL, idxAddFeed : Integer;
begin

  if ImportExport_Type = 1 then   //Import
  begin
    btnImportExport.Enabled := False;


    idxCL:=0;
    while ( idxCL<= RSSData.Count - 1 ) do
    begin

      if TTreeCL(RSSData.Objects[idxCL]).TreeNode.StateIndex = cFlatChecked then
      begin
//        showmessage(inttostr(idxcl));

        sSQL := 'INSERT INTO CL (Pos, Name, Topic, Font, Options) VALUES (' +
                  IntToStr( 0 ) + ', '+
                  '''' + TextToSQLText( TTreeCL(RSSData.Objects[idxCL]).Name ) + '''' + ', '+
                  '''' + TextToSQLText( TTreeCL(RSSData.Objects[idxCL]).Topic ) + '''' + ', '+
                  '''' + TextToSQLText( TTreeCL(RSSData.Objects[idxCL]).Font ) + '''' + ', '+
                  '''' + TextToSQLText( TTreeCL(RSSData.Objects[idxCL]).Options ) + '''' +
                  ');';

               {
        sSQL := 'INSERT INTO CL (Pos, Group, Name, Topic, Font, Options) VALUES (' +
                  IntToStr( 0 ) + ', '+
                  '''' + TextToSQLText( TTreeCL(RSSData.Objects[idxCL]).Group ) + '''' + ', '+
                  '''' + TextToSQLText( TTreeCL(RSSData.Objects[idxCL]).Name ) + '''' + ', '+
                  '''' + TextToSQLText( TTreeCL(RSSData.Objects[idxCL]).Topic ) + '''' + ', '+
                  '''' + TextToSQLText( TTreeCL(RSSData.Objects[idxCL]).Font ) + '''' + ', '+
                  '''' + TextToSQLText( TTreeCL(RSSData.Objects[idxCL]).Options ) + '''' +
                  ');';
                         }
{        edtimport.Text := sSQL;
        Exit;   }
        ExecSQLUTF8(sSQL);

        SQLtb := SQLdb.GetTable('SELECT * FROM CL');

        if SQLtb.Count > 0 then
        begin
          SQLtb.MoveLast;
          iID    := SQLtb.FieldAsInteger(SQLtb.FieldIndex['ID']);
        end;
        SQLtb.Free;

        sSQL := 'UPDATE CL SET Pos='+IntToStr(iID)+' WHERE (ID='+IntToStr(iID)+')';
        ExecSQLUTF8(sSQL);


        CL.Add('ITEM');
        idxAddCL:= CL.Count - 1;
        CL.Objects[idxAddCL] := TCL.Create;
        TCL(CL.Objects[idxAddCL]).ID    := iID;
        TCL(CL.Objects[idxAddCL]).Name  := TTreeCL(RSSData.Objects[idxCL]).Name;
        TCL(CL.Objects[idxAddCL]).Group := TTreeCL(RSSData.Objects[idxCL]).Group;

        TCL(CL.Objects[idxAddCL]).Font.Font := TFont.Create;
        LoadFont(TTreeCL(RSSData.Objects[idxCL]).Options, TCL(CL.Objects[idxAddCL]).Font);

        TCL(CL.Objects[idxAddCL]).Options   := TStringList.Create;
        TCL(CL.Objects[idxAddCL]).Options.Clear;
        LoadOptions(TTreeCL(RSSData.Objects[idxCL]).Options, TCL(CL.Objects[idxAddCL]).Options);

        TCL(CL.Objects[idxAddCL]).Feed := TStringList.Create;
        TCL(CL.Objects[idxAddCL]).Feed.Clear;

        idxFeed:=0;
        while ( idxFeed<= TTreeCL(RSSData.Objects[idxCL]).Feed.Count - 1 ) do
        begin
          Application.ProcessMessages;


          sSQL := 'INSERT INTO RSS(CLID, Style, Pos, Name, Topic, URL, Options) VALUES (' +
            IntToStr(TCL(CL.Objects[idxAddCL]).ID)+', ' +
            IntToStr( TTreeFeed(TTreeCL(RSSData.Objects[idxCL]).Feed.Objects[idxFeed]).Style ) + ', '+
            IntToStr( 0 ) + ', '+
            '''' + TextToSQLText(TTreeFeed(TTreeCL(RSSData.Objects[idxCL]).Feed.Objects[idxFeed]).Name) + '''' + ', '+
            '''' + TextToSQLText(TTreeFeed(TTreeCL(RSSData.Objects[idxCL]).Feed.Objects[idxFeed]).Topic)+''''+ ', ' +
            '''' + TextToSQLText(TTreeFeed(TTreeCL(RSSData.Objects[idxCL]).Feed.Objects[idxFeed]).URL)+''''+ ', ' +
            '''' + TextToSQLText(TTreeFeed(TTreeCL(RSSData.Objects[idxCL]).Feed.Objects[idxFeed]).Options)+''''+ ');';

          ExecSQLUTF8(sSQL);

          Application.ProcessMessages;

          SQLtb := SQLdb.GetTable('SELECT * FROM RSS');

          if SQLtb.Count > 0 then
          begin
            SQLtb.MoveLast;
            iIDFeed    := SQLtb.FieldAsInteger(SQLtb.FieldIndex['ID']);
          end;
          SQLtb.Free;

          sSQL := 'UPDATE RSS SET Pos='+IntToStr(iID)+' WHERE (ID='+IntToStr(iID)+')';
          ExecSQLUTF8(sSQL);



          TCL(CL.Objects[idxAddCL]).Feed.Add('RSS');
          idxAddFeed:= TCL(CL.Objects[idxAddCL]).Feed.Count - 1;
          TCL(CL.Objects[idxAddCL]).Feed.Objects[idxAddFeed] := TFeed.Create;
          TFeed(TCL(CL.Objects[idxAddCL]).Feed.Objects[idxAddFeed]).ID    := iIDFeed;
          TFeed(TCL(CL.Objects[idxAddCL]).Feed.Objects[idxAddFeed]).Style := TTreeFeed(TTreeCL(RSSData.Objects[idxCL]).Feed.Objects[idxFeed]).Style;
          TFeed(TCL(CL.Objects[idxAddCL]).Feed.Objects[idxAddFeed]).Name  := TTreeFeed(TTreeCL(RSSData.Objects[idxCL]).Feed.Objects[idxFeed]).Name;
          TFeed(TCL(CL.Objects[idxAddCL]).Feed.Objects[idxAddFeed]).Topic := TTreeFeed(TTreeCL(RSSData.Objects[idxCL]).Feed.Objects[idxFeed]).Topic;

          TFeed(TCL(CL.Objects[idxAddCL]).Feed.Objects[idxAddFeed]).LoginName  := '';
          TFeed(TCL(CL.Objects[idxAddCL]).Feed.Objects[idxAddFeed]).LoginPassword  := '';

          TFeed(TCL(CL.Objects[idxAddCL]).Feed.Objects[idxAddFeed]).URL   := TTreeFeed(TTreeCL(RSSData.Objects[idxCL]).Feed.Objects[idxFeed]).URL;
          TFeed(TCL(CL.Objects[idxAddCL]).Feed.Objects[idxAddFeed]).NextUpdate := 0;
          TFeed(TCL(CL.Objects[idxAddCL]).Feed.Objects[idxAddFeed]).LastUpdate := 0;

          TFeed(TCL(CL.Objects[idxAddCL]).Feed.Objects[idxAddFeed]).Options   := TStringList.Create;
          TFeed(TCL(CL.Objects[idxAddCL]).Feed.Objects[idxAddFeed]).Options.Clear;

          LoadOptions( TTreeFeed(TTreeCL(RSSData.Objects[idxCL]).Feed.Objects[idxFeed]).Options, TFeed(TCL(CL.Objects[idxAddCL]).Feed.Objects[idxAddFeed]).Options );

          Inc(idxFeed);
        end;

        QIPPlugin.AddSpecContact(1, idxAddCL, TCL(CL.Objects[idxAddCL]).SpecCntUniq);

      end;



      Inc(idxCL);
    end;


    showmessage('Complete.');

    Close;


  end
  else if ImportExport_Type = 2 then  //Export
  begin
    btnImportExport.Enabled := False;

    if edtExport.Text = '' then
    begin
      ShowMessage('Musíte zadat nìjaký soubor.');
      btnOpen.Enabled := True;
      Exit;
    end;

    AssignFile(F,  edtExport.Text );
    Rewrite(F);

    utf8Line := WideString2UTF8( '<?xml version="1.0" encoding="UTF-8"?>' );
    WriteLn(f, utf8Line );

    utf8Line := WideString2UTF8( '<RSSNews>' );
    WriteLn(f, utf8Line );

    idxCL:=0;
    while ( idxCL<= RSSData.Count - 1 ) do
    begin

      if TTreeCL(RSSData.Objects[idxCL]).TreeNode.StateIndex = cFlatChecked then
      begin
        utf8Line := WideString2UTF8( ' <Contact>' );
        WriteLn(f, utf8Line );

        utf8Line := WideString2UTF8( '  <Name>'+TTreeCL(RSSData.Objects[idxCL]).Name+'</Name>' );
        WriteLn(f, utf8Line );
        utf8Line := WideString2UTF8( '  <Group>'+TTreeCL(RSSData.Objects[idxCL]).Group+'</Group>' );
        WriteLn(f, utf8Line );

        if chkExportFont.Checked = True then
        begin
          utf8Line := WideString2UTF8( '  <Font>'+TTreeCL(RSSData.Objects[idxCL]).Font+'</Font>' );
          WriteLn(f, utf8Line );
        end;

        if chkExportOptions.Checked = True then
        begin
          utf8Line := WideString2UTF8( '  <Options>'+TTreeCL(RSSData.Objects[idxCL]).Options+'</Options>' );
          WriteLn(f, utf8Line );
        end;

        idxFeed:=0;
        while ( idxFeed<= TTreeCL(RSSData.Objects[idxCL]).Feed.Count - 1 ) do
        begin
          Application.ProcessMessages;

          utf8Line := WideString2UTF8( '  <Feed>' );
          WriteLn(f, utf8Line );

          utf8Line := WideString2UTF8( '   <Style>'+IntToStr(TTreeFeed(TTreeCL(RSSData.Objects[idxCL]).Feed.Objects[idxFeed]).Style)+'</Style>' );
          WriteLn(f, utf8Line );
          utf8Line := WideString2UTF8( '   <Name>'+TTreeFeed(TTreeCL(RSSData.Objects[idxCL]).Feed.Objects[idxFeed]).Name+'</Name>' );
          WriteLn(f, utf8Line );
          utf8Line := WideString2UTF8( '   <Topic>'+TTreeFeed(TTreeCL(RSSData.Objects[idxCL]).Feed.Objects[idxFeed]).Topic+'</Topic>' );
          WriteLn(f, utf8Line );
          utf8Line := WideString2UTF8( '   <URL>'+TTreeFeed(TTreeCL(RSSData.Objects[idxCL]).Feed.Objects[idxFeed]).URL+'</URL>' );
          WriteLn(f, utf8Line );

          if chkExportOptions.Checked = True then
          begin
            utf8Line := WideString2UTF8( '   <Options>'+TTreeFeed(TTreeCL(RSSData.Objects[idxCL]).Feed.Objects[idxFeed]).Options+'</Options>' );
            WriteLn(f, utf8Line );
          end;

          utf8Line := WideString2UTF8( '  </Feed>' );
          WriteLn(f, utf8Line );

          Inc(idxFeed);
        end;


        utf8Line := WideString2UTF8( ' </Contact>' );
        WriteLn(f, utf8Line );
      end;




      Inc(idxCL);
    end;

    utf8Line := WideString2UTF8( '</RSSNews>' );
    WriteLn(f, utf8Line );

    CloseFile(F);

    Close;
  end;

end;

procedure TfrmImportExport.btnOpenClick(Sender: TObject);
var F: TextFile;
    sImportData, sLine : WideString;
    iContactPos, iFeedPos, {iFS,} clIndex, hIndex, iFS2, iFS3: Integer;
    sDList, sDContact, sDFeed : WideString;
    HTMLData: TResultData;
Label 1,2;
begin
  if edtImport.Text = '' then
  begin
    ShowMessage('Musíte zadat nìjaký soubor.');
    btnOpen.Enabled := True;
    Exit;
  end;

  if AnsiUpperCase(Copy(edtImport.Text,1,7)) = 'HTTP://' then
  begin
     btnOpen.Enabled := False;
    try
      HTMLData := GetHTML(edtImport.Text,'','', downTimeout, NO_CACHE, Info);
    except

    end;
     btnOpen.Enabled := True;
    if HTMLData.OK <> True then
    begin
      ShowMessage('Soubor nelze stáhnout.');
      btnOpen.Enabled := True;
      Exit;
    end;

    sImportData := HTMLData.parString
  end
  else
  begin
    if FileExists( edtImport.Text ) = False then
    begin
      ShowMessage('Soubor neexistuje.');
      btnOpen.Enabled := True;
      Exit;
    end;

    sImportData := '';
    AssignFile(F, edtImport.Text );
    Reset(F);
    while not eof(F) do
    begin
      Readln(F, {utf8}sLine );

      sImportData := sImportData + #13 + #10 + sLine;

    end; {while not eof}

    CloseFile(F);

  end;


  RSSData.Clear;

  btnOpen.Enabled := False;

    sDList := FoundStr(sImportData,'<RSSNews>','</RSSNews>', 1{, iFS});
    if sDList<>'' then
    begin
      iContactPos := 1;

      1:
      Application.ProcessMessages;
      sDContact := FoundStr(sDList,'<Contact>','</Contact>', iContactPos, iContactPos, iFS2, iFS3);
      iContactPos := iContactPos + 1;
      if sDContact <> '' then
      begin

        RSSData.Add('ITEM');
        hIndex:= RSSData.Count - 1;
        RSSData.Objects[hIndex] := TTreeCL.Create;
        TTreeCL(RSSData.Objects[hIndex]).Name    := UTF82WideString( FoundStr(sDContact,'<Name>','</Name>', 1{, iFS}) );
        TTreeCL(RSSData.Objects[hIndex]).Group   := UTF82WideString( FoundStr(sDContact,'<Group>','</Group>', 1{, iFS}) );
        TTreeCL(RSSData.Objects[hIndex]).Topic   := UTF82WideString( FoundStr(sDContact,'<Topic>','</Topic>', 1{, iFS}) );

        TTreeCL(RSSData.Objects[hIndex]).Options := UTF82WideString( FoundStr(sDContact,'<Options>','</Options>', 1{, iFS}) );

        TTreeCL(RSSData.Objects[hIndex]).Font := UTF82WideString( FoundStr(sDContact,'<Font>','</Font>', 1{, iFS}) );

        TTreeCL(RSSData.Objects[hIndex]).Feed   := TStringList.Create;
        TTreeCL(RSSData.Objects[hIndex]).Feed.Clear;

        clIndex := hIndex;

        iFeedPos := 1;

        2:
        Application.ProcessMessages;
        sDFeed := FoundStr(sDContact,'<Feed>','</Feed>', iFeedPos, iFeedPos, iFS2, iFS3);
        iFeedPos := iFeedPos + 1;
        if sDFeed<>'' then
        begin

          TTreeCL(RSSData.Objects[clIndex]).Feed.Add('FEED');
          hIndex:= TTreeCL(RSSData.Objects[clIndex]).Feed.Count - 1;
          TTreeCL(RSSData.Objects[clIndex]).Feed.Objects[hIndex] := TTreeFeed.Create;

          TTreeFeed(TTreeCL(RSSData.Objects[clIndex]).Feed.Objects[hIndex]).Name :=  UTF82WideString( FoundStr(sDFeed,'<Name>','</Name>', 1{, iFS}) );
          TTreeFeed(TTreeCL(RSSData.Objects[clIndex]).Feed.Objects[hIndex]).Style :=  ConvStrToInt( FoundStr(sDFeed,'<Style>','</Style>', 1{, iFS}) );
          TTreeFeed(TTreeCL(RSSData.Objects[clIndex]).Feed.Objects[hIndex]).Topic :=  UTF82WideString( FoundStr(sDFeed,'<Topic>','</Topic>', 1{, iFS}) );
          TTreeFeed(TTreeCL(RSSData.Objects[clIndex]).Feed.Objects[hIndex]).URL :=  UTF82WideString( FoundStr(sDFeed,'<URL>','</URL>', 1{, iFS}) );

          TTreeFeed(TTreeCL(RSSData.Objects[clIndex]).Feed.Objects[hIndex]).Options := UTF82WideString( FoundStr(sDFeed,'<Options>','</Options>', 1{, iFS}) );

          Goto 2;
        end;


        Goto 1;
      end;

    end;

  LoadTree;


  btnOpen.Enabled := True;


end;

procedure TfrmImportExport.FormClose(Sender: TObject; var Action: TCloseAction);
begin


  ImportExportIsShow := False;
end;

procedure TfrmImportExport.FormShow(Sender: TObject);
var idxCL, idxFeed: Int64;
    hIndex, clIndex:Integer;
begin
  ImportExportIsShow := True;

  Icon := PluginSkin.PluginIcon.Icon;


  RSSData := TStringList.Create;
  RSSData.Clear;

  btnImportBrowse.Hint := QIPPlugin.GetLang(LI_BROWSE);
  btnExportBrowse.Hint := QIPPlugin.GetLang(LI_BROWSE);

  btnCancel.Caption := QIPPlugin.GetLang(LI_CANCEL);

  lblImport.Caption := LNG('FORM ImportExport', 'ImportFrom', 'Import from:');
  lblExport.Caption := LNG('FORM ImportExport', 'ExportTo', 'Export to:');

  btnOpen.Caption  := QIPPlugin.GetLang(LI_OPEN);


  edtImport.Text := 'http://';

  if ImportExport_Type = 1 then   //Import
  begin
    pnlExport.Visible := False;
    Height := Height - pnlExport.Height;
    btnImportExport.Caption := LNG('MENU ContactMenu', 'Import', 'Import');
    Caption := btnImportExport.Caption;

    edtImport.SelectAll;
    edtImport.SetFocus;

    
  end
  else if ImportExport_Type = 2 then  //Export
  begin
    pnlImport.Visible := False;
    Height := Height - pnlImport.Height;
    btnImportExport.Caption := LNG('MENU ContactMenu', 'Export', 'Export');
    Caption := btnImportExport.Caption;

    edtExport.SelectAll;
    edtExport.SetFocus;


    idxCL:=0;
    while ( idxCL<= CL.Count - 1 ) do
    begin

      RSSData.Add('ITEM');
      hIndex:= RSSData.Count - 1;
      RSSData.Objects[hIndex] := TTreeCL.Create;
      TTreeCL(RSSData.Objects[hIndex]).Name    := TCL(CL.Objects[idxCL]).Name;
      TTreeCL(RSSData.Objects[hIndex]).Group   := TCL(CL.Objects[idxCL]).Group;
      TTreeCL(RSSData.Objects[hIndex]).Topic   := TCL(CL.Objects[idxCL]).Topic;

      TTreeCL(RSSData.Objects[hIndex]).Options := SaveOptions(TCL(CL.Objects[idxCL]).Options);

      TTreeCL(RSSData.Objects[hIndex]).Font := SaveFont(TCL(CL.Objects[idxCL]).Font);

      TTreeCL(RSSData.Objects[hIndex]).Feed   := TStringList.Create;
      TTreeCL(RSSData.Objects[hIndex]).Feed.Clear;

      clIndex := hIndex;

      idxFeed:=0;
      while ( idxFeed<= TCL(CL.Objects[idxCL]).Feed.Count - 1 ) do
      begin
        Application.ProcessMessages;

        TTreeCL(RSSData.Objects[clIndex]).Feed.Add('FEED');
        hIndex:= TTreeCL(RSSData.Objects[clIndex]).Feed.Count - 1;
        TTreeCL(RSSData.Objects[clIndex]).Feed.Objects[hIndex] := TTreeFeed.Create;

        TTreeFeed(TTreeCL(RSSData.Objects[clIndex]).Feed.Objects[hIndex]).Name :=  TFeed(TCL(CL.Objects[idxCL]).Feed.Objects[idxFeed]).Name;
        TTreeFeed(TTreeCL(RSSData.Objects[clIndex]).Feed.Objects[hIndex]).Style :=  TFeed(TCL(CL.Objects[idxCL]).Feed.Objects[idxFeed]).Style;
        TTreeFeed(TTreeCL(RSSData.Objects[clIndex]).Feed.Objects[hIndex]).Topic :=  TFeed(TCL(CL.Objects[idxCL]).Feed.Objects[idxFeed]).Topic;
        TTreeFeed(TTreeCL(RSSData.Objects[clIndex]).Feed.Objects[hIndex]).URL :=  TFeed(TCL(CL.Objects[idxCL]).Feed.Objects[idxFeed]).URL;

        TTreeFeed(TTreeCL(RSSData.Objects[clIndex]).Feed.Objects[hIndex]).Options := SaveOptions(TFeed(TCL(CL.Objects[idxCL]).Feed.Objects[idxFeed]).Options);

        Inc(idxFeed);
      end;


      Inc(idxCL);
    end;


    LoadTree;

  end;



end;

procedure TfrmImportExport.tvDataClick(Sender: TObject);
var
  P:TPoint;
begin
  GetCursorPos(P);
  P := tvData.ScreenToClient(P);
  if (htOnStateIcon in 
             tvData.GetHitTestInfoAt(P.X,P.Y)) then
    ToggleTreeViewCheckBoxes(
       tvData.Selected,
       cFlatUnCheck,
       cFlatChecked,
       cFlatRadioUnCheck,
       cFlatRadioChecked);

end;

procedure TfrmImportExport.tvDataKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_SPACE) and Assigned(tvData.Selected) then
    ToggleTreeViewCheckBoxes(tvData.Selected,cFlatUnCheck,cFlatChecked,cFlatRadioUnCheck,cFlatRadioChecked);
end;


{
var
  BoolResult:boolean;
  tn : TTreeNode;
begin
  if Assigned(TreeView1.Selected) then
  begin
    tn := TreeView1.Selected;
    BoolResult := tn.StateIndex in [cFlatChecked,cFlatRadioChecked];
    Memo1.Text := tn.Text + #13#10 + 'Selected: ' + BoolToStr(BoolResult, True);
  end;
}

{

      CL.Add('ITEM');
      hIndex:= CL.Count - 1;
      CL.Objects[hIndex] := TCL.Create;
      TCL(CL.Objects[hIndex]).ID    := SQLtb.FieldAsInteger(SQLtb.FieldIndex['ID']);
      TCL(CL.Objects[hIndex]).Group := SQLTextToText(SQLtb.FieldAsString(SQLtb.FieldIndex['Group']));      
      TCL(CL.Objects[hIndex]).Name  := SQLTextToText(SQLtb.FieldAsString(SQLtb.FieldIndex['Name']));
      TCL(CL.Objects[hIndex]).Topic := SQLTextToText(SQLtb.FieldAsString(SQLtb.FieldIndex['Topic']));


        TCL(CL.Objects[i]).Feed.Add('FEED');
        hIndex:= TCL(CL.Objects[i]).Feed.Count - 1;
        TCL(CL.Objects[i]).Feed.Objects[hIndex] := TFeed.Create;
        TFeed(TCL(CL.Objects[i]).Feed.Objects[hIndex]).ID    := SQLtb.FieldAsInteger(SQLtb.FieldIndex['ID']);
        TFeed(TCL(CL.Objects[i]).Feed.Objects[hIndex]).Style := SQLtb.FieldAsInteger(SQLtb.FieldIndex['Style']);
}
end.
