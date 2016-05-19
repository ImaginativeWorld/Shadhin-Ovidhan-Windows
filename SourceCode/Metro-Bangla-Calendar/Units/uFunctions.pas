/// <aboutDev>
///
/// Project:
///     Metro Bangla Calendar (for Shadhin Ovidhan)
///
/// Documentation:
///     Md. Mahmudul Hasan Shohag
///     Founder, CEO of Imaginative World
///     http://shohag.imaginativeworld.org
///
/// Lisence:
///     Opensource project lisense under MPL 2.0.
///     Copyright © Imaginative World. All rights researved.
///     http://imaginativeworld.org
///
/// **************************************************
///     This Source Code Form is subject to the
///     terms of the Mozilla Public License, v.
///     2.0. If a copy of the MPL was not
///     distributed with this file, You can obtain
///     one at http://mozilla.org/MPL/2.0/.
/// **************************************************
///
/// </aboutDev>

unit uFunctions;

interface

uses
  Classes,
  Forms,
  SysUtils,
  Windows,
  uRegistry,
  Registry,
  ShellAPI,
  Dialogs,
  Wininet;

// Version
procedure GetBuildInfo(var V1, V2, V3, V4: Word);
procedure SetVersionInfo;
function AppVersionInfo: string;

// Show a Form
function IsFormLoaded(const xFormName: string): Boolean;
procedure CheckCreateForm(InstanceClass: TComponentClass; var xForm;
  const xFormName: string);

// Settings
procedure GetSettings;
procedure SetSettings;
// procedure ResetSettings;

procedure Execute_Something(const xFile: string; const xParam: string = '');
procedure Open_URL(const xURL: string);

procedure TrimAppMemorySize;

{ Internet }
function IsConnected: Boolean;

var
  // Versions
  AppVerMajor, // Major Version
  AppVerMinor, // Minor Version
  AppVerRelease, // Release
  AppVerBuild: Word; // Build Number

  strVersion: string;

  { Global Settings }
  confThemeName: string;
  confGadgetX: integer;
  confGadgetY: integer;
  confGadgetLock: Boolean;

  confGadgetColor: integer;
  confGadgetFontColor: integer;
  confGadgetFont: string;

  confAutoStart: Boolean;
  confTransparent: integer;

  confGadgetRnbSpeed: string;

  // confNewsInterval: Integer;
  // confLastNewsCheck: Integer;

  { Like us message }
  // confLikeUsShow: Integer;
  // IsLikeUsShowToday: Boolean = False;

  // confInfoNotifyShow: Integer;

  AppDir: string;

  { HotKey }
  HKid: integer;
  HKMods: integer;
  strModHotKey, strHotKey: string;

implementation

uses
  uFrmMain_BanglaCalendar,
  uTextStrings;

{ ****************************** N E W    P A R T ****************************** }

function IsFormLoaded(const xFormName: string): Boolean;
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

procedure GetSettings;
var
  Reg: TMyRegistry;
begin
  Reg := TMyRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;

  if Reg.OpenKey('Software\Imaginative World\Shadhin Ovidhan', True) = True then
  begin

    confThemeName := Reg.ReadStringDef('ThemeName', 'Random');

    confGadgetX := strtoint(Reg.ReadStringDef('GadgetX', '0'));
    confGadgetY := strtoint(Reg.ReadStringDef('GadgetY', '0'));

    confGadgetLock := strtobool(Reg.ReadStringDef('GadgetLock', 'False'));

    confGadgetColor := strtoint(Reg.ReadStringDef('GadgetColor', '43623'));
    confGadgetFontColor := strtoint(Reg.ReadStringDef('GadgetFontColor', '0'));
    confGadgetFont := Reg.ReadStringDef('GadgetFont', 'Siyam Rupali');

    confTransparent := strtoint(Reg.ReadStringDef('GadgetTransparent', '90'));

    confGadgetRnbSpeed := Reg.ReadStringDef('GadgetRnbSpeed', 'Normal');

  end;
  Reg.CloseKey;

  if Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', True)
    = True then
  begin
    confAutoStart := Reg.ValueExists('Matro Bangla Calendar');
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

    Reg.WriteString('ThemeName', confThemeName);

    Reg.WriteString('GadgetX', IntToStr(frmMain.left));
    Reg.WriteString('GadgetY', IntToStr(frmMain.Top));

    Reg.WriteString('GadgetLock', boolToStr(confGadgetLock));

    Reg.WriteString('GadgetColor', IntToStr(confGadgetColor));
    Reg.WriteString('GadgetFontColor', IntToStr(confGadgetFontColor));
    Reg.WriteString('GadgetFont', confGadgetFont);

    Reg.WriteString('GadgetTransparent', IntToStr(confTransparent));

    Reg.WriteString('GadgetRnbSpeed', confGadgetRnbSpeed);

  end;
  Reg.CloseKey;

  if Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', True)
    = True then
  begin

    if confAutoStart then
    begin
      if Reg.ValueExists('Matro Bangla Calendar') = False then
        Reg.WriteString('Matro Bangla Calendar',
          AppDir + 'SOBanglaCalendar.exe');
    end
    else
    begin
      if Reg.ValueExists('Matro Bangla Calendar') then
        Reg.DeleteValue('Matro Bangla Calendar');
    end;

  end;

  Reg.Free;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure Execute_Something(const xFile: string; const xParam: string = '');
begin
  // ShellExecute(Application.handle, 'open', Pchar(xFile), Nil, Nil,
  // SW_SHOWNORMAL);

  if FileExists(xFile) then
    ShellExecute(0, 'open', Pchar(xFile), Pchar(xParam), nil, SW_SHOWNORMAL)
  else
    Application.MessageBox //
    (Pchar(strExeNotFound + #10 + #10 + strIfItBug + #10 + strIWEmail), //
      Pchar(Forms.Application.Title),
      MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);

end;

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

function IsConnected: Boolean;
var
  dwConnectionTypes: DWORD;
begin
  Result := False;
  dwConnectionTypes := INTERNET_CONNECTION_MODEM + INTERNET_CONNECTION_LAN +
    INTERNET_CONNECTION_PROXY;

  Result := InternetGetConnectedState(@dwConnectionTypes, 0);
end;

{ ****************************** N E W    P A R T ****************************** }

end.

