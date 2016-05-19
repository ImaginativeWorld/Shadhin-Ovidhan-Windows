{
 *******************************************************************
 This Source Code Form is subject to the terms of the Mozilla Public
 License, v. 2.0. If a copy of the MPL was not distributed with this
 file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *******************************************************************
}

{$INCLUDE ../ProjectDefines.inc}
unit uFunctions;

interface

uses
  Classes,
  Forms,
  SysUtils,
  Windows,
{$IFDEF PortableOn}
  inifiles,
{$ELSE}
  uRegistry,
  Registry,
{$ENDIF}
  ShellAPI, StdCtrls, // (Ex. TEdit)
  ClipBrd, // Clipboard
  StrUtils, // (Ex. AnsiContainsText)
  SHFolder,
  Wininet,
  Dialogs,
  Graphics, // color
  ExtCtrls; // Ex. Panel

// Version
procedure GetBuildInfo(var V1, V2, V3, V4: Word);
procedure SetVersionInfo;
function AppVersionInfo: string;

// Form Functions
function IsFormLoaded(const xFormName: string): Boolean;
procedure CheckCreateForm(InstanceClass: TComponentClass; var xForm;
  const xFormName: string);
function IsFormVisible(const xFormName: string): Boolean;

// OnTop Functions
procedure TOPMOST(const xFormHwnd: HWND);
procedure NoTOPMOST(const xFormHwnd: HWND);
function IsWindowTopMost(hWindow: HWND): Boolean;

// Settings
procedure GetSettings;
procedure SetSettings;
procedure ResetSettings;

// Executing and Opening
procedure Execute_Something(const xFile: string; const xParam: string = '');
//Procedure Execute_App_Admin(Const xApp: String);
procedure Open_URL(const xURL: string);

procedure TrimAppMemorySize;

// Split
procedure Split(Delimiter: Char; Str: string; ListOfStrings: TStrings);
function SplitStrings(const Str: string; const separator: string = ',';
  Strings: TStrings = nil): TStrings;
function AnsiSplitStrings(const Str: string; const separator: string = ',';
  Strings: TStrings = nil): TStrings;

// Clipboard
procedure ReEditAndViewClipboard(TEditName: TEdit);
function RemoveUnwantedChr(const str: string): string;

// For Update Check Unit
function IsConnected: Boolean;

// Folder Functions
function GetCommonApplicationData(): string;
function DirToPath(const Dir: string): string;
function GetShadhinDataDir(): string;

function MyCopyFile(const SourceFile, DestinationFile: string;
  Overwrite: Boolean = False): Boolean;

// Error Message
procedure ErrMsg(const e: Exception; const ErrCode: string = '');

// Info Message
procedure InfoMsg(const strMsg: string;
  const strCaption: string = 'Shadhin Ovidhan | Info');

// function FontInstalled(Const FontName: String): Boolean;

// Style
procedure EnablePanelButton(const PanelName: TPanel);
procedure DisablePanelButton(const PanelName: TPanel);

var
  // Versions
  AppVerMajor, // Major Version
  AppVerMinor, // Minor Version
  AppVerRelease, // Release
  AppVerBuild: Word; // Build Number

  strAppName: string;
  strVersion: string;

  { Global Settings }
  confIntEnSrcType: Integer;
  confIntBnSrcType: Integer;
  confVoiceRate: Integer;
  confChkClipboard: Boolean;
  confUpdateCheck: Boolean;
  confOvidhanTop: Boolean;
  confQSrcTop: Boolean;
  confOvidhanFont: string;
  confOvidhanFontSize: Integer;
  confDBvar: integer;

  AppDir, DBdir: string;

  // Dic Strings
  strWord: string;
  strSynonyms: string;

  // Fonts
  IsFontInstalled: Boolean = False;

implementation

uses
  uTextStrings;

{ ****************************** N E W    P A R T ****************************** }

function IsFormLoaded(const xFormName: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := Screen.FormCount - 1 downto 0 do
    if (LowerCase(Screen.Forms[i].Name) = LowerCase(xFormName)) then
    begin
      Result := True;
      Break;
    end;
end;

procedure CheckCreateForm(InstanceClass: TComponentClass; var xForm;
  const xFormName: string);
begin
  if not IsFormLoaded(xFormName) then
  begin
    Application.CreateForm(InstanceClass, xForm);

    // In order to keep Application hidden
    // in taskbar
    ShowWindow(Application.handle, SW_HIDE);
  end;
end;

function IsFormVisible(const xFormName: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := Screen.FormCount - 1 downto 0 do
    if (LowerCase(Screen.Forms[i].Name) = LowerCase(xFormName)) then
    begin
      if Screen.Forms[i].Visible = True then
        Result := True;
      Break;
    end;
end;
{ ****************************** N E W    P A R T ****************************** }

procedure TOPMOST(const xFormHwnd: HWND);
begin
  SetWindowPos(xFormHwnd, HWND_TOPMOST, 0, 0, 0, 0,
    SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
end;

procedure NoTOPMOST(const xFormHwnd: HWND);
begin
  SetWindowPos(xFormHwnd, HWND_NOTOPMOST, 0, 0, 0, 0,
    SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
end;

function IsWindowTopMost(hWindow: HWND): Boolean;
begin
  Result := False;
  Result := (GetWindowLong(hWindow, GWL_EXSTYLE) and WS_EX_TOPMOST) <> 0
end;
{ ****************************** N E W    P A R T ****************************** }

procedure GetBuildInfo(var V1, V2, V3, V4: Word);
var
  VerInfoSize, VerValueSize, Dummy: DWORD;
  VerInfo: pointer;
  VerValue: PVSFixedFileInfo;
begin
  VerInfoSize := GetFileVersionInfoSize(Pchar(ParamStr(0)), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(Pchar(ParamStr(0)), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', pointer(VerValue), VerValueSize);
  with VerValue^ do
  begin
    V1 := dwFileVersionMS shr 16;
    V2 := dwFileVersionMS and $FFFF;
    V3 := dwFileVersionLS shr 16;
    V4 := dwFileVersionLS and $FFFF;
  end;
  FreeMem(VerInfo, VerInfoSize);
end;

procedure SetVersionInfo;
begin
  GetBuildInfo(AppVerMajor, AppVerMinor, AppVerRelease, AppVerBuild);
end;

function AppVersionInfo: string;
var
  V1, // Major Version
  V2, // Minor Version
  V3, // Release
  V4: Word; // Build Number
begin
  GetBuildInfo(V1, V2, V3, V4);
  Result := IntToStr(V1) + '.' + IntToStr(V2) + '.' + IntToStr(V3)
    + '.' + IntToStr(V4);
end;

{ ****************************** N E W    P A R T ****************************** }
{$REGION '          Save / Load / Reset Settings          '}
{$IFDEF PortableOn}

procedure GetSettings;
var
  appINI: TIniFile;

begin
  appINI := TIniFile.Create(AppDir + 'SOSettings.iwconf');

  try

    confIntEnSrcType := appINI.ReadInteger //
    ('Shadhin_Ovidhan', 'EnSearchType', 1);
    confIntBnSrcType := appINI.ReadInteger //
    ('Shadhin_Ovidhan', 'BnSearchType', 2);
    confVoiceRate := appINI.ReadInteger('Shadhin_Ovidhan', 'SpeechRate', 0);
    confChkClipboard := appINI.readBool //
    ('Shadhin_Ovidhan', 'chkClipBoard', True);
    confUpdateCheck := appINI.readBool('Shadhin_Ovidhan', 'OUChk', True);

    confOvidhanTop := appINI.readBool('Shadhin_Ovidhan', 'OvidhanTop', False);
    confQSrcTop := appINI.readBool('Shadhin_Ovidhan', 'QSrcTop', True);

    confOvidhanFont := appINI.readString //
    ('Shadhin_Ovidhan', 'OvidhanFont', 'Nirmala UI');
    confOvidhanFontSize := appINI.ReadInteger //
    ('Shadhin_Ovidhan', 'OvidhanFontSize', 10);

  finally
    appINI.Free;
  end;

end;

procedure SetSettings;
var
  appINI: TIniFile;
begin
  appINI := TIniFile.Create(AppDir + 'SOSettings.iwconf');

  try
    appINI.WriteInteger('Shadhin_Ovidhan', 'EnSearchType', confIntEnSrcType);
    appINI.WriteInteger('Shadhin_Ovidhan', 'BnSearchType', confIntBnSrcType);
    appINI.WriteInteger('Shadhin_Ovidhan', 'SpeechRate', confVoiceRate);
    appINI.WriteBool('Shadhin_Ovidhan', 'chkClipBoard', confChkClipboard);
    appINI.WriteBool('Shadhin_Ovidhan', 'OUChk', confUpdateCheck);

    appINI.WriteBool('Shadhin_Ovidhan', 'OvidhanTop', confOvidhanTop);
    appINI.WriteBool('Shadhin_Ovidhan', 'QSrcTop', confQSrcTop);

    appINI.WriteString('Shadhin_Ovidhan', 'OvidhanFont', confOvidhanFont);
    appINI.WriteInteger('Shadhin_Ovidhan', 'OvidhanFontSize',
      confOvidhanFontSize);
  finally
    appINI.Free;
  end;

end;

procedure ResetSettings;
var
  appINI: TIniFile;
begin
  appINI := TIniFile.Create(AppDir + 'SOSettings.iwconf');

  try
    appINI.WriteInteger('Shadhin_Ovidhan', 'EnSearchType', 1);
    appINI.WriteInteger('Shadhin_Ovidhan', 'BnSearchType', 2);
    appINI.WriteInteger('Shadhin_Ovidhan', 'SpeechRate', 0);
    appINI.WriteBool('Shadhin_Ovidhan', 'chkClipBoard', True);
    appINI.WriteBool('Shadhin_Ovidhan', 'OUChk', True);

    appINI.WriteBool('Shadhin_Ovidhan', 'OvidhanTop', False);
    appINI.WriteBool('Shadhin_Ovidhan', 'QSrcTop', True);

    appINI.WriteString('Shadhin_Ovidhan', 'OvidhanFont', 'Nirmala UI');
    appINI.WriteInteger('Shadhin_Ovidhan', 'OvidhanFontSize', 10);

  finally
    appINI.Free;
  end;

  begin
    confIntEnSrcType := 1;
    confIntBnSrcType := 2;
    confVoiceRate := 0;
    confChkClipboard := True;
    confUpdateCheck := True;

    confOvidhanTop := False;
    confQSrcTop := True;

    confOvidhanFont := 'Nirmala UI';
    confOvidhanFontSize := 10;
  end;
end;
{$ELSE}

procedure GetSettings;
var
  Reg: TMyRegistry;
begin
  Reg := TMyRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;

  if Reg.OpenKey('Software\Imaginative World\Shadhin Ovidhan', True) = True then
  begin
    confIntEnSrcType := strtoint(Reg.ReadStringDef('EnSearchType', '1'));
    confIntBnSrcType := strtoint(Reg.ReadStringDef('BnSearchType', '2'));
    confVoiceRate := strtoint(Reg.ReadStringDef('SpeechRate', '0'));
    confChkClipboard := strtobool(Reg.ReadStringDef('chkClipBoard', 'True'));
    confUpdateCheck := strtobool(Reg.ReadStringDef('OUChk', 'True'));

    confOvidhanTop := strtobool(Reg.ReadStringDef('OvidhanTop', 'False'));
    confQSrcTop := strtobool(Reg.ReadStringDef('QSrcTop', 'True'));

    confOvidhanFont := Reg.ReadStringDef('OvidhanFont', 'Nirmala UI');
    confOvidhanFontSize := strtoint(Reg.ReadStringDef('OvidhanFontSize', '10'));

    confDBvar := strtoint(Reg.ReadStringDef('DBvar', '0'));


  end;

  Reg.Free;
end;

procedure SetSettings;
var
  Reg: TMyRegistry;
begin
  Reg := TMyRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.OpenKey('Software\Imaginative World\Shadhin Ovidhan', True) = True then
  begin
    Reg.WriteString('EnSearchType', IntToStr(confIntEnSrcType));
    Reg.WriteString('BnSearchType', IntToStr(confIntBnSrcType));
    Reg.WriteString('SpeechRate', IntToStr(confVoiceRate));
    Reg.WriteString('chkClipBoard', boolToStr(confChkClipboard));
    Reg.WriteString('OUChk', boolToStr(confUpdateCheck));

    Reg.WriteString('OvidhanTop', boolToStr(confOvidhanTop));
    Reg.WriteString('QSrcTop', boolToStr(confQSrcTop));

    Reg.WriteString('OvidhanFont', confOvidhanFont);
    Reg.WriteString('OvidhanFontSize', IntToStr(confOvidhanFontSize));

    Reg.WriteString('DBvar', IntToStr(intDbVersion));

  end;

  Reg.Free;
end;

procedure ResetSettings;
var
  Reg: TMyRegistry;
begin
  Reg := TMyRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.OpenKey('Software\Imaginative World\Shadhin Ovidhan', True) = True then
  begin
    Reg.WriteString('EnSearchType', '1');
    Reg.WriteString('BnSearchType', '2');
    Reg.WriteString('SpeechRate', '0');
    Reg.WriteString('chkClipBoard', boolToStr(True));
    Reg.WriteString('OUChk', boolToStr(True));

    Reg.WriteString('OvidhanTop', boolToStr(False));
    Reg.WriteString('QSrcTop', boolToStr(True));

    Reg.WriteString('OvidhanFont', 'Nirmala UI');
    Reg.WriteString('OvidhanFontSize', '10');
  end;

  Reg.Free;

  begin
    confIntEnSrcType := 1;
    confIntBnSrcType := 2;
    confVoiceRate := 0;
    confChkClipboard := True;
    confUpdateCheck := True;

    confOvidhanTop := False;
    confQSrcTop := True;

    confOvidhanFont := 'Nirmala UI';
    confOvidhanFontSize := 10;
  end;
end;
{$ENDIF}
{$ENDREGION}
{ ****************************** N E W    P A R T ****************************** }

procedure Execute_Something(const xFile: string; const xParam: string = '');
begin
  // ShellExecute(Application.handle, 'open', Pchar(xFile), Nil, Nil,
  // SW_SHOWNORMAL);

  if FileExists(xFile) then
    //ShellExecute(0, 'open', Pchar(xFile), Pchar(xParam), Nil, SW_SHOWNORMAL)
    ShellExecute(Application.Handle, 'open', Pchar(xFile), Pchar(xParam), nil,
      SW_SHOWNORMAL)
  else
    Application.MessageBox //
    (Pchar(strExeNotFound + #10 + #10 + strIfItBug + #10 + strIWEmail), //
      Pchar(Forms.Application.Title),
      MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);

end;

// For Vista and up
//Procedure Execute_App_Admin(Const xApp: String);
//Var
//		 exInfo: TShellExecuteInfo;
//Begin
//		 FillChar(exInfo, sizeof(exInfo), 0);
//		 With exInfo Do Begin
//					cbSize := sizeof(exInfo);
//					Wnd := GetActiveWindow();
//					lpVerb := 'runas';
//					lpParameters := '';
//					lpFile := Pchar(xApp);
//					nShow := SW_SHOWNORMAL;
//		 End;
//		 ShellExecuteEx(@exInfo);
//End;

{ ****************************** N E W    P A R T ****************************** }

procedure Open_URL(const xURL: string);
begin

  ShellExecute(0, 'open', Pchar(xURL), nil, nil, SW_SHOWNORMAL)

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TrimAppMemorySize;
var
  MainHandle: THandle;
begin
  try
    MainHandle := OpenProcess(PROCESS_ALL_ACCESS, False, GetCurrentProcessID);
    SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF);
    CloseHandle(MainHandle);
  except
  end;
  Application.ProcessMessages;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure Split(Delimiter: Char; Str: string; ListOfStrings: TStrings);
begin
  {
    NOTE:

    [Space] treat as separetor!
    }

  ListOfStrings.Clear;
  ListOfStrings.Delimiter := Delimiter;
  ListOfStrings.DelimitedText := Str;
end;

{ ****************************** N E W    P A R T ****************************** }

function SplitStrings(const Str: string; const separator: string;
  Strings: TStrings): TStrings;
// Fills a string list with the parts of "str" separated by
// "separator". If Nil is passed instead of a string list,
// the function creates a TStringList object which has to
// be freed by the caller
var
  n: Integer;
  p, q, s: Pchar;
  item: string;
begin
  if Strings = nil then
    Result := TStringList.Create
  else
    Result := Strings;
  try
    p := Pchar(Str);
    s := Pchar(separator);
    n := Length(separator);
    repeat
      q := StrPos(p, s);
      if q = nil then
        q := StrScan(p, #0);
      SetString(item, p, q - p);
      Result.Add(item);
      p := q + n;
    until q^ = #0;
  except
    item := '';
    if Strings = nil then
      Result.Free;
    raise;
  end;
end;

function AnsiSplitStrings(const Str: string; const separator: string;
  Strings: TStrings): TStrings;
// Fills a string list with the parts of "str" separated by
// "separator". If Nil is passed instead of a string list,
// the function creates a TStringList object which has to
// be freed by the caller
// ANSI version
var
  n: Integer;
  p, q, s: Pchar;
  item: string;
begin
  if Strings = nil then
    Result := TStringList.Create
  else
    Result := Strings;
  try
    p := Pchar(Str);
    s := Pchar(separator);
    n := Length(separator);
    repeat
      q := AnsiStrPos(p, s);
      if q = nil then
        q := AnsiStrScan(p, #0);
      SetString(item, p, q - p);
      Result.Add(item);
      p := q + n;
    until q^ = #0;
  except
    item := '';
    if Strings = nil then
      Result.Free;
    raise;
  end;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure ReEditAndViewClipboard(TEditName: TEdit);
begin

  if not AnsiContainsText(Clipboard.AsText, '!') and not AnsiContainsText
    (Clipboard.AsText, '@') and not AnsiContainsText(Clipboard.AsText, '#')
    and not AnsiContainsText(Clipboard.AsText, '$') and not AnsiContainsText
    (Clipboard.AsText, '%') and not AnsiContainsText(Clipboard.AsText, '^')
    and not AnsiContainsText(Clipboard.AsText, '&') and not AnsiContainsText
    (Clipboard.AsText, '*') and not AnsiContainsText(Clipboard.AsText, '(')
    and not AnsiContainsText(Clipboard.AsText, ')') // 10
  and not AnsiContainsText(Clipboard.AsText, '_') and not AnsiContainsText
    (Clipboard.AsText, '-') and not AnsiContainsText(Clipboard.AsText, '=')
    and not AnsiContainsText(Clipboard.AsText, '+') and not AnsiContainsText
    (Clipboard.AsText, '[') and not AnsiContainsText(Clipboard.AsText, ']')
    and not AnsiContainsText(Clipboard.AsText, '{') and not AnsiContainsText
    (Clipboard.AsText, '}') and not AnsiContainsText(Clipboard.AsText, ';')
    and not AnsiContainsText(Clipboard.AsText, ':') // 20
  and not AnsiContainsText(Clipboard.AsText, '''') and not AnsiContainsText
    (Clipboard.AsText, '|') and not AnsiContainsText(Clipboard.AsText, '\')
    and not AnsiContainsText(Clipboard.AsText, ',') and not AnsiContainsText
    (Clipboard.AsText, '<') and not AnsiContainsText(Clipboard.AsText, '.')
    and not AnsiContainsText(Clipboard.AsText, '>') and not AnsiContainsText
    (Clipboard.AsText, '/') and not AnsiContainsText(Clipboard.AsText, '?')
    and not AnsiContainsText(Clipboard.AsText, '`') // 30
  and not AnsiContainsText(Clipboard.AsText, '~') and not AnsiContainsText
    (Clipboard.AsText, '©') and not AnsiContainsText(Clipboard.AsText, '®')
    and not AnsiContainsText(Clipboard.AsText, '"') then
  begin

    TEditName.Text := Clipboard.AsText;

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

function RemoveUnwantedChr(const str: string): string;
begin
  Result :=
    stringreplace(stringreplace(stringreplace(stringreplace //
    (stringreplace(stringreplace(stringreplace(stringreplace(//
    str, //
    ' ', '', [rfReplaceAll, rfIgnoreCase]),
    '-', '', [rfReplaceAll, rfIgnoreCase]),
    '.', '', [rfReplaceAll, rfIgnoreCase]),
    '''', '', [rfReplaceAll, rfIgnoreCase]),
    '[', '', [rfReplaceAll, rfIgnoreCase]),
    ']', '', [rfReplaceAll, rfIgnoreCase]),
    ';', '', [rfReplaceAll, rfIgnoreCase]),
    ',', '', [rfReplaceAll, rfIgnoreCase]);
end;

{ ****************************** N E W    P A R T ****************************** }

function DirToPath(const Dir: string): string;
begin
  if (Dir <> '') and (Dir[Length(Dir)] <> '\') then
    Result := Dir + '\'
  else
    Result := Dir;
end;

{ ****************************** N E W    P A R T ****************************** }

function GetCommonApplicationData(): string;
var
  path: array[0..MAX_PATH] of Char;
begin
  if SUCCEEDED(SHGetFolderPath(0, CSIDL_COMMON_APPDATA, 0, SHGFP_TYPE_CURRENT,
    @path[0])) then
    Result := DirToPath(path)
  else
    Result := '';
end;

{ ****************************** N E W    P A R T ****************************** }

function GetShadhinDataDir(): string;
begin
{$IFDEF PortableOn}
  Result := ExtractFilePath(Application.ExeName);
{$ELSE}
  Result := GetCommonApplicationData + 'Imaginative World\Shadhin Ovidhan\';
{$ENDIF}
end;

{ ****************************** N E W    P A R T ****************************** }

procedure ErrMsg(const e: Exception; const ErrCode: string = '');
begin
  if ErrCode = '' then
  begin
    Application.MessageBox
      (Pchar('Error Description:' + #10 + e.ToString + #10 + #10 + #10 +
      strErrSryMsg), 'Shadhin Ovidhan | Info',
      MB_OK + MB_ICONHAND + MB_DEFBUTTON1 + MB_APPLMODAL);
  end
  else
  begin
    Application.MessageBox(Pchar('Error Code: ' + ErrCode + #10 + #10 + //
      'Error Description:' + #10 + e.ToString + #10 + #10 + #10 +
      strErrSryMsg), 'Shadhin Ovidhan | Info',
      MB_OK + MB_ICONHAND + MB_DEFBUTTON1 + MB_APPLMODAL);
  end;
end;

procedure InfoMsg(const strMsg: string;
  const strCaption: string = 'Shadhin Ovidhan | Info');
begin
  Application.MessageBox(Pchar(strMsg), Pchar(strCaption),
    MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);
end;
{ ****************************** N E W    P A R T ****************************** }

function MyCopyFile(const SourceFile, DestinationFile: string;
  Overwrite: Boolean = False): Boolean;
begin
  try
    Overwrite := not Overwrite;
    Result := Windows.CopyFile(Pchar(SourceFile), Pchar(DestinationFile),
      Overwrite);
  except
    on e: Exception do
    begin

      showmessage('Something Worong!' + #10 + #10 + //
        'Error Message:' + #10 + e.ToString + //
        #10 + #10 + strIfItBug + #10 + #10 + strIWEmail);

      Result := False;
    end;
  end;
end;

{ ****************************** N E W    P A R T ****************************** }
{$REGION '          Update Check | Needed functions         '}

function IsConnected: Boolean;
var
  dwConnectionTypes: DWORD;
begin
  Result := False;
  dwConnectionTypes := INTERNET_CONNECTION_MODEM + INTERNET_CONNECTION_LAN +
    INTERNET_CONNECTION_PROXY;

  Result := InternetGetConnectedState(@dwConnectionTypes, 0);
end;
{$ENDREGION}
{ ****************************** N E W    P A R T ****************************** }

procedure EnablePanelButton(const PanelName: TPanel);
begin

  PanelName.Enabled := true;
  PanelName.Font.Color := clblack;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure DisablePanelButton(const PanelName: TPanel);
begin

  PanelName.Enabled := False;
  PanelName.Font.Color := clGray;

end;

{ ****************************** N E W    P A R T ****************************** }

end.

