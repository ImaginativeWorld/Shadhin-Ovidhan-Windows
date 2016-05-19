{
 *******************************************************************
 This Source Code Form is subject to the terms of the Mozilla Public
 License, v. 2.0. If a copy of the MPL was not distributed with this
 file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *******************************************************************
}

// {$INCLUDE ../ProjectDefines.inc}
unit uFunctions;

interface

uses
  Classes,
  Forms,
  SysUtils,
  Windows,
  // {$IFDEF PortableOn}
  inifiles,
  // {$ELSE}
  uRegistry,
  Registry,
            // {$ENDIF}
  ShellAPI, StdCtrls, // (Ex. TEdit)
  ClipBrd,  // Clipboard
  StrUtils, // (Ex. AnsiContainsText)
  SHFolder,
  Dialogs;
// , inifiles;

// Version
procedure GetBuildInfo(var V1, V2, V3, V4: word);
procedure SetVersionInfo;
function AppVersionInfo: string;

// Form Functions
function IsFormLoaded(const xFormName: string): boolean;
procedure CheckCreateForm(InstanceClass: TComponentClass; var xForm;
  const xFormName: string);
function IsFormVisible(const xFormName: string): boolean;

//File folder handling
function MyMoveFile(const SourceFile, DestinationFile: string;
  Overwrite: boolean = False): boolean;

// OnTop Functions
procedure TOPMOST(const xFormHwnd: HWND);
procedure NoTOPMOST(const xFormHwnd: HWND);
function IsWindowTopMost(hWindow: HWND): boolean;

 // Settings
 // procedure GetSettings;
procedure GetIEpref;
procedure GetSmoothPref;
procedure GetIconPref;

 // procedure SetSettings;
 // procedure ResetSettings;

procedure Execute_Something(const xFile: string; const xParam: string = '');
procedure Open_URL(const xURL: string);

procedure TrimAppMemorySize;

// Folder Functions
function DirToPath(const Dir: string): string;
function GetWindowsFolder(): string;
function GetHomeFolder(): string;

// Error Message
procedure ErrMsg(const e: Exception; const ErrCode: string = '');

// Info Message
procedure InfoMsg(const strMsg: string;
  const strCaption: string = 'Shadhin Ovidhan | Bangla Aid Kit | Info');

{ Windows Version Check Functions }
function IsWinVistaOrLater: boolean;
//function IsWin8OrLater: boolean;

// function FontInstalled(Const FontName: String): Boolean;

var
  // Versions
  AppVerMajor, // Major Version
  AppVerMinor, // Minor Version
  AppVerRelease, // Release
  AppVerBuild: word; // Build Number

  // strAppName: string;
  // strVersion: string;

  // Overal Settings
  // confIntEnSrcType: Integer;
  // confIntBnSrcType: Integer;
  // confVoiceRate: Integer;
  // confChkClipboard: Boolean;
  // confUpdateCheck: Boolean;

  confIconDefaultFont: string;
  confIEdefaultFont:   string;
  confIsFontSmooth:    boolean;

  AppDir: string;

 // Dic Strings
 // strWord: String;

 // Fonts
 // IsFontInstalled: Boolean = False;

implementation

uses
  uTextStrings;

{ ****************************** N E W    P A R T ****************************** }

function IsFormLoaded(const xFormName: string): boolean;
var
  i: integer;
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

function IsFormVisible(const xFormName: string): boolean;
var
  i: integer;
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

function IsWindowTopMost(hWindow: HWND): boolean;
begin
  Result := False;
  Result := (GetWindowLong(hWindow, GWL_EXSTYLE) and WS_EX_TOPMOST) <> 0;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure GetBuildInfo(var V1, V2, V3, V4: word);
var
  VerInfoSize, VerValueSize, Dummy: DWORD;
  VerInfo:  pointer;
  VerValue: PVSFixedFileInfo;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo);
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
  V4: word; // Build Number
begin
  GetBuildInfo(V1, V2, V3, V4);
  Result := IntToStr(V1) + '.' + IntToStr(V2) + '.' + IntToStr(V3) +
    '.' + IntToStr(V4);
end;

{ ****************************** N E W    P A R T ****************************** }
{$REGION '          Save / Load / Reset Settings          '}

procedure GetIEpref;
var
  Reg: TMyRegistry;
  Str: string;
begin
  begin
    Reg := TMyRegistry.Create;
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.OpenKeyReadOnly(
      'Software\Microsoft\Internet Explorer\International\Scripts\11');
    Str := Reg.ReadString('IEFixedFontName');
    FreeAndNil(Reg);
  end;

  confIEdefaultFont := Str;

end;

procedure GetSmoothPref;
var
  Reg: TMyRegistry;
  Str: string;
begin

  begin
    Reg := TMyRegistry.Create;
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.OpenKeyReadOnly('Control Panel\Desktop');
    Str := Reg.ReadString('FontSmoothing');
    FreeAndNil(Reg);
  end;

  if Str = '2' then
    confIsFontSmooth := True
  else
    confIsFontSmooth := False;

end;

procedure GetIconPref;
var
  Reg: TMyRegistry;
  Str: string;
begin
  begin
    Reg := TMyRegistry.Create;
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    Reg.OpenKeyReadOnly(
      'SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontSubstitutes');
    if Reg.ValueExists('Vrinda') then
    begin
      Str := Reg.ReadString('Vrinda');
    end
    else
    begin
      if FileExists(GetWindowsFolder() + 'fonts/vrinda.ttf') then
        Str := 'Vrinda';
    end;

    FreeAndNil(Reg);
  end;

  confIconDefaultFont := Str;

end;

{$ENDREGION}
{ ****************************** N E W    P A R T ****************************** }

procedure Execute_Something(const xFile: string; const xParam: string = '');
begin
  // ShellExecute(Application.handle, 'open', Pchar(xFile), Nil, Nil,
  // SW_SHOWNORMAL);

  if FileExists(xFile) then
    ShellExecute(0, 'open', PChar(xFile), PChar(xParam), nil, SW_SHOWNORMAL)
  else
    Application.MessageBox
    (PChar(strExeNotFound + #10 + #10 + strIfItBug + #10 + strIWEmail),
      PChar(Forms.Application.Title),
      MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);

end;

{ ****************************** N E W    P A R T ****************************** }

procedure Open_URL(const xURL: string);
begin

  ShellExecute(0, 'open', PChar(xURL), nil, nil, SW_SHOWNORMAL);

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

function DirToPath(const Dir: string): string;
begin
  if (Dir <> '') and (Dir[Length(Dir)] <> '\') then
    Result := Dir + '\'
  else
    Result := Dir;
end;

{ ****************************** N E W    P A R T ****************************** }

function GetWindowsFolder(): string;
var
  path: array [0 .. MAX_PATH] of char;
begin
  if SUCCEEDED(SHGetFolderPath(0, CSIDL_WINDOWS, 0, SHGFP_TYPE_CURRENT,
    @path[0])) then
    Result := DirToPath(path)
  else
    Result := '';
end;

function GetHomeFolder(): string;
begin
    Result := AnsiLeftStr(GetWindowsFolder(), 1) + ':\';
end;

{ ****************************** N E W    P A R T ****************************** }

procedure ErrMsg(const e: Exception; const ErrCode: string = '');
begin
  if ErrCode = '' then
  begin
    Application.MessageBox
    (PChar('Error Description:' + #10 + e.ToString + #10 + #10 +
      #10 + 'We are extremely sorry for this problem.' + #10 +
      'Please let us know about this problem.'), 'Shadhin Ovidhan | Info',
      MB_OK + MB_ICONHAND + MB_DEFBUTTON1 + MB_APPLMODAL);
  end
  else
  begin
    Application.MessageBox(PChar('Error Code: ' + ErrCode + #10 +
      #10 + 'Error Description:' + #10 + e.ToString + #10 + #10 +
      #10 + 'We are extremely sorry for this problem.' + #10 +
      'Please let us know about this problem.'), 'Shadhin Ovidhan | Info',
      MB_OK + MB_ICONHAND + MB_DEFBUTTON1 + MB_APPLMODAL);
  end;
end;

procedure InfoMsg(const strMsg: string;
  const strCaption: string = 'Shadhin Ovidhan | Bangla Aid Kit | Info');
begin
  Application.MessageBox(PChar(strMsg), PChar(strCaption),
    MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);
end;

{ ****************************** N E W    P A R T ****************************** }
function MyMoveFile(const SourceFile, DestinationFile: string;
  Overwrite: boolean = False): boolean;
begin
  Result := False;

  try
    if FileExists(DestinationFile) then
    begin
      if Overwrite then
      begin
        if SysUtils.DeleteFile(DestinationFile) then
          Result := Windows.MoveFile(PChar(SourceFile), PChar(DestinationFile));
      end;
    end
    else
    begin
      Result := Windows.MoveFile(PChar(SourceFile), PChar(DestinationFile));
    end;

  except
    On E: Exception do
      Result := False;
  end;
end;

{ ****************************** N E W    P A R T ****************************** }

{$REGION '          Windows Version functions         '}

function IsWinVistaOrLater: boolean;
var
  osv: TOSVERSIONINFO;
begin
  Result := False;
  osv.dwOSVersionInfoSize := SizeOf(TOSVERSIONINFO);
  if GetVersionEx(osv) then
  begin
    Result := (osv.dwPlatformID = VER_PLATFORM_WIN32_NT) and
      (osv.dwMajorVersion >= 6);
  end
  else
    Result := False;

end;

//function IsWin8OrLater: boolean;
//var
//  osv: TOSVERSIONINFO;
//begin
//  Result := False;
//  osv.dwOSVersionInfoSize := SizeOf(TOSVERSIONINFO);
//  if GetVersionEx(osv) then
//  begin
//    Result := (osv.dwPlatformID = VER_PLATFORM_WIN32_NT) and
//      ((osv.dwMajorVersion >= 6) and (osv.dwMinorVersion >= 2));
//  end
//  else
//    Result := False;
//
//end;

{$ENDREGION}

end.

