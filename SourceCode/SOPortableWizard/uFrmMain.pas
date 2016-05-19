{
 *******************************************************************
 This Source Code Form is subject to the terms of the Mozilla Public
 License, v. 2.0. If a copy of the MPL was not distributed with this
 file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *******************************************************************
}

unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, pngimage, StdCtrls, ComCtrls, SHFolder;

type
  TfrmMain = class(TForm)
    Panel1:         TPanel;
    Panel2:         TPanel;
    Label1:         TLabel;
    cmbDriveList:   TComboBox;
    Label2:         TLabel;
    chkBoxWordmarks: TCheckBox;
    pBar:           TProgressBar;
    lblSpace:       TLabel;
    pBarDriveSpace: TProgressBar;
    chkBoxOnlyPmedia: TCheckBox;
    lblDis:         TLabel;
    Label3:         TLabel;
    imgPWizardIcon: TImage;
    pnlBtnCreate:   TPanel;
    pnlBtnExit:     TPanel;

    procedure refreshDriveList(const OnlyPortMedia: boolean = False);

    function MyCopyFile(const SourceFile, DestinationFile: string;
      Overwrite: boolean = False): boolean;

    // Folder Functions
    function GetCommonApplicationData(): string;
    function DirToPath(const Dir: string): string;
    function GetShadhinDataDir(): string;

    procedure btnExitClick(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
    procedure cmbDriveListChange(Sender: TObject);
    procedure chkBoxOnlyPmediaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkBoxWordmarksClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pnlBtnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure pnlBtnMouseEnter(Sender: TObject);
    procedure pnlBtnMouseLeave(Sender: TObject);
    procedure pnlBtnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  uTextStrings;

procedure TfrmMain.btnCreateClick(Sender: TObject);
var
  strSourceFileLoc: array [0 .. 12] of string;
  strDestinationFileLoc: array [0 .. 12] of string;

  intTotalFile: integer;
  I: integer;

  strUserName: PChar;
  unSize: DWord;
  wmPath, adPath: string;

  AllFileExists: boolean;
begin

  begin
    lblDis.Visible := True;
    chkBoxOnlyPmedia.Enabled := False;
    cmbDriveList.Enabled := False;
    chkBoxWordmarks.Enabled := False;
    pnlBtnExit.Enabled := False;
    pnlBtnCreate.Enabled := False;
    pnlBtnCreate.Color := $00F0F0F0;
    pnlBtnCreate.Font.Color := clGray;
  end;

  application.ProcessMessages;

  // User Name Collect
  unSize := 250;
  GetMem(strUserName, unSize);
  getusername(strUserName, unSize);
  wmPath := 'Wordmarks_' + strPas(strUserName) + '.iwdb';
  //adPath := 'AdditionalDict_' + strPas(strUserName) + '.iwdb';

  // ExtractFilename()
  strSourceFileLoc[0] := 'Tools\ShadhinOvidhan.exe';
  strDestinationFileLoc[0] := 'SOData\ShadhinOvidhan.exe';

  if fileExists(GetShadhinDataDir + 'IW.Lib.SO.dll') then
    strSourceFileLoc[1] := GetShadhinDataDir + 'IW.Lib.SO.dll'
  else
    strSourceFileLoc[1] := 'IW.Lib.SO.dll';
  strDestinationFileLoc[1] := 'SOData\IW.Lib.SO.dll';

  strSourceFileLoc[2] := 'Tools\IComplex.exe';
  strDestinationFileLoc[2] := 'SOData\IComplex.exe';

  strSourceFileLoc[3] := 'Tools\Shadhin_Ovidhan_Launcher.exe';
  strDestinationFileLoc[3] := 'Shadhin Ovidhan Launcher.exe';

  strSourceFileLoc[4] := 'Tools\SOBanglaAidKit.exe';
  strDestinationFileLoc[4] := 'SOData\SOBanglaAidKit.exe';

  strSourceFileLoc[5] := 'SOBanglaCalendar.exe';
  strDestinationFileLoc[5] := 'SOData\SOBanglaCalendar.exe';

  strSourceFileLoc[6] := 'SOCommon.exe';
  strDestinationFileLoc[6] := 'SOData\SOCommon.exe';

  strSourceFileLoc[7] := 'Tools\Nirmala.TTF';
  strDestinationFileLoc[7] := 'SOData\NirmalaUI.TTF';

  strSourceFileLoc[8] := 'Tools\NirmalaB.TTF';
  strDestinationFileLoc[8] := 'SOData\NirmalaUIB.TTF';

  strSourceFileLoc[9] := 'Tools\SiyamRupali.TTF';
  strDestinationFileLoc[9] := 'SOData\SiyamRupali.TTF';

  strSourceFileLoc[10] := 'Tools\Kalpurush.TTF';
  strDestinationFileLoc[10] := 'SOData\Kalpurush.TTF';

  strSourceFileLoc[11] := GetShadhinDataDir + wmPath;
  strDestinationFileLoc[11] := 'SOData\Wordmarks.iwdb';

  if chkBoxWordmarks.Checked then
    intTotalFile := 11
  else
    intTotalFile := 10;

  ForceDirectories(cmbDriveList.Items.Strings[cmbDriveList.ItemIndex] + 'SOData\');

  // filesetattr(cmbDriveList.Items.Strings[cmbDriveList.ItemIndex] + 'SOData\',
  // faHidden);

  { Check Is All File exist in Source folder }
  for I := 0 to intTotalFile do
  begin
    AllFileExists := fileExists(strSourceFileLoc[I]);

    if AllFileExists = False then
    begin
      ShowMessage('All necessary file not found!' + #10 +
        'Please reinstall Shadhin Ovidhan and try again.' + #10 +
        'Not Found File: ' + #10 + strSourceFileLoc[I] + #10 +
        #10 + strIfItBug + #10 + #10 + strIWEmail);

      begin
        lblDis.Visible := False;
        chkBoxOnlyPmedia.Enabled := True;
        cmbDriveList.Enabled := True;
        chkBoxWordmarks.Enabled := True;
        pnlBtnExit.Enabled := True;
        pnlBtnCreate.Enabled := True;
        pnlBtnCreate.Color := $00F0F0F0;
        pnlBtnCreate.Font.Color := clBlack;
      end;

      exit;
    end;

  end;

  { Copy all file to Destination Folder }
  for I := 0 to intTotalFile do
  begin

    application.ProcessMessages;

    if MyCopyFile(strSourceFileLoc[I],
      cmbDriveList.Items.Strings[cmbDriveList.ItemIndex] +
      strDestinationFileLoc[I], True) then
    begin

      pBar.Position := pBar.Position + 9; { 100 / 11 files }

    end
    else
    begin

      application.MessageBox(PChar(
        'All necessary file not successfully installed in your Removal Drive!'
        +
        #10 + #10 + '-> Make sure the disk is not write protected, or' +
        #10 + '-> "' + cmbDriveList.Items.Strings[cmbDriveList.ItemIndex] +
        strDestinationFileLoc[I] + '" file is not ''Read Only''.' +
        #10 + #10 +
        'If you think this is a Bug then please let us know about this problem.'),
        PChar(application.Title),
        MB_OK + MB_ICONHAND + MB_DEFBUTTON1 + MB_APPLMODAL);

      begin
        lblDis.Visible := False;
        chkBoxOnlyPmedia.Enabled := True;
        cmbDriveList.Enabled := True;
        chkBoxWordmarks.Enabled := True;
        pnlBtnExit.Enabled := True;
        pnlBtnCreate.Enabled := True;
        pnlBtnCreate.Color := $00F0F0F0;
        pnlBtnCreate.Font.Color := clBlack;
      end;

      exit;

    end;

  end;

  FreeMem(strUserName);

  pBar.Position := pBar.Max;

  lblDis.Font.Color := clGreen;
  lblDis.Caption := 'সফলভাবে সম্পন্ন!';

  pnlBtnCreate.Visible := False;
  //  pnlBtnCreate.Color := $00F0F0F0;
  //  pnlBtnCreate.Font.Color := clGray;

  pnlBtnExit.Caption := 'ঠিক আছে';
  pnlBtnExit.Enabled := True;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.chkBoxWordmarksClick(Sender: TObject);
var
  strUserName: PChar;
  unSize: DWord;
  wmPath: string;
begin

  if chkBoxWordmarks.Checked then
  begin

    unSize := 250;
    GetMem(strUserName, unSize);
    getusername(strUserName, unSize);
    wmPath := 'Wordmarks_' + strPas(strUserName) + '.iwdb';

    if fileExists(GetShadhinDataDir + 'Wordmarks_' + strPas(strUserName) +
      '.iwdb') = False then
    begin
      ShowMessage('You don''t have any word in your WORDMARKS yet!' +
        #10 + 'Plz add some word first!');
      chkBoxWordmarks.Checked := False;
    end;

    FreeMem(strUserName);

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.btnExitClick(Sender: TObject);
begin
  self.Close;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.chkBoxOnlyPmediaClick(Sender: TObject);
begin
  if chkBoxOnlyPmedia.Checked then
  begin
    refreshDriveList(True);
  end
  else
  begin
    refreshDriveList;
  end;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.cmbDriveListChange(Sender: TObject);
var
  intDiskSpace: int64;
  intDiskFullSize: int64;

  intTempSpace, intTempFullSize: string;
begin

  GetDiskFreeSpaceEx(PChar(cmbDriveList.Items.Strings[cmbDriveList.ItemIndex]),
    intDiskSpace, intDiskFullSize, nil);

  if (intDiskSpace div 1024 div 1024) > 1024 then
    intTempSpace := IntToStr(intDiskSpace div 1024 div 1024 div 1024) + ' গিবা'
  else
    intTempSpace := IntToStr(intDiskSpace div 1024 div 1024) + ' মেবা';

  if (intDiskFullSize div 1024 div 1024) > 1024 then
    intTempFullSize := IntToStr(intDiskFullSize div 1024 div 1024 div
      1024) + ' গিবা'
  else
    intTempFullSize := IntToStr(intDiskFullSize div 1024 div 1024) + ' মেবা';

  lblSpace.Caption := 'মোটঃ ' + intTempFullSize + ' | ফাঁকাঃ ' + intTempSpace;

  pBarDriveSpace.Max := (intDiskFullSize div 1024 div 1024);
  pBarDriveSpace.Position := ((intDiskFullSize - intDiskSpace) div 1024 div 1024);

  if (intDiskSpace >= (20 * 1024 * 1024)) then
    pnlBtnCreate.Enabled := True
  else
    pnlBtnCreate.Enabled := False;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  Action := caFree;

  frmMain := nil;

end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin

  refreshDriveList(True);

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.refreshDriveList(const OnlyPortMedia: boolean = False);
var
  intDiskSpace: int64;
  intDiskFullSize: int64;

  intTempSpace, intTempFullSize: string;

  ld: DWord;
  I:  integer;

  stringList: TStringList;
begin

  cmbDriveList.Items.Clear;

  stringList := TStringList.Create;

  ld := GetLogicalDrives;
  for I := 0 to 25 do
  begin
    if (ld and (1 shl I)) <> 0 then
      stringList.Add(char(Ord('A') + I) + ':\');
  end;

  for I := 0 to stringList.Count - 1 do
  begin
    if OnlyPortMedia then
    begin

      if GetDriveType(PChar(stringList.Strings[I])) = DRIVE_REMOVABLE then
      begin
        cmbDriveList.Items.Add(stringList.Strings[I]);
      end;

    end
    else
    begin

      cmbDriveList.Items.Add(stringList.Strings[I]);

    end;
  end;

  stringList.Destroy;

  cmbDriveList.ItemIndex := 0;

  GetDiskFreeSpaceEx(PChar(cmbDriveList.Items.Strings[cmbDriveList.ItemIndex]),
    intDiskSpace, intDiskFullSize, nil);

  if (intDiskSpace div 1024 div 1024) > 1024 then
    intTempSpace := IntToStr(intDiskSpace div 1024 div 1024 div 1024) + ' গিবা'
  else
    intTempSpace := IntToStr(intDiskSpace div 1024 div 1024) + ' মেবা';

  if (intDiskFullSize div 1024 div 1024) > 1024 then
    intTempFullSize := IntToStr(intDiskFullSize div 1024 div 1024 div
      1024) + ' গিবা'
  else
    intTempFullSize := IntToStr(intDiskFullSize div 1024 div 1024) + ' মেবা';

  lblSpace.Caption := 'মোটঃ ' + intTempFullSize + ' | ফাঁকাঃ ' + intTempSpace;

  pBarDriveSpace.Max := (intDiskFullSize div 1024 div 1024);
  pBarDriveSpace.Position := ((intDiskFullSize - intDiskSpace) div 1024 div 1024);

  if (intDiskSpace >= (20 * 1024 * 1024)) then
    pnlBtnCreate.Enabled := True
  else
    pnlBtnCreate.Enabled := False;

end;

{ ****************************** N E W    P A R T ****************************** }
{$REGION '         Needed Functions          '}

function TfrmMain.MyCopyFile(const SourceFile, DestinationFile: string;
  Overwrite: boolean = False): boolean;
begin
  try
    Overwrite := not Overwrite;
    Result := Windows.CopyFile(PChar(SourceFile), PChar(DestinationFile),
      Overwrite);
  except
    On E: Exception do
      Result := False;

  end;
end;

{ ****************************** N E W    P A R T ****************************** }

function TfrmMain.GetShadhinDataDir(): string;
begin

  Result := GetCommonApplicationData + 'Imaginative World\Shadhin Ovidhan\';

end;

{ ****************************** N E W    P A R T ****************************** }

function TfrmMain.GetCommonApplicationData(): string;
var
  path: array [0 .. MAX_PATH] of char;
begin
  if SUCCEEDED(SHGetFolderPath(0, CSIDL_COMMON_APPDATA, 0, SHGFP_TYPE_CURRENT,
    @path[0])) then
    Result := DirToPath(path)
  else
    Result := '';
end;

{ ****************************** N E W    P A R T ****************************** }

function TfrmMain.DirToPath(const Dir: string): string;
begin
  if (Dir <> '') and (Dir[Length(Dir)] <> '\') then
    Result := Dir + '\'
  else
    Result := Dir;
end;

{$ENDREGION}
{ ****************************** N E W    P A R T ****************************** }
{$REGION '          Panel Appreance         '}

procedure TfrmMain.pnlBtnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  (Sender as TPanel)
  .Color := clBlack;
  (Sender as TPanel)
  .Font.Color := clWhite;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlBtnMouseEnter(Sender: TObject);
begin
  (Sender as TPanel)
  .Color := clGray;
  (Sender as TPanel)
  .Font.Color := clWhite;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlBtnMouseLeave(Sender: TObject);
begin
  (Sender as TPanel)
  .Color := $00F0F0F0;
  (Sender as TPanel)
  .Font.Color := clBlack;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlBtnMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  (Sender as TPanel)
  .Color := clGray;
  (Sender as TPanel)
  .Font.Color := clWhite;
end;

{$ENDREGION}
{ ****************************** N E W    P A R T ****************************** }

end.

