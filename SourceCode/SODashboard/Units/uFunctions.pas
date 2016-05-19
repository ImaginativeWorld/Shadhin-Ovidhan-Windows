{
 *******************************************************************
 This Source Code Form is subject to the terms of the Mozilla Public
 License, v. 2.0. If a copy of the MPL was not distributed with this
 file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *******************************************************************
}

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
function AppVersionInfo: String;

// Show a Form
Function IsFormLoaded(Const xFormName: String): Boolean;
Procedure CheckCreateForm(InstanceClass: TComponentClass; Var xForm;
  Const xFormName: String);

// Settings
procedure GetSettings;
procedure SetSettings;
procedure ResetSettings;

Procedure Execute_Something(Const xFile: String; const xParam: String = '');
Procedure Open_URL(Const xURL: String);

procedure TrimAppMemorySize;

{ Internet }
Function IsConnected: Boolean;

{ Hotkey }
Procedure SelectAndRegHotkey(const reReg: Boolean = False);
procedure UnRegHotKey;

{ Notification }
procedure ShowTrayInfo;

var
  // Versions
  AppVerMajor, // Major Version
  AppVerMinor, // Minor Version
  AppVerRelease, // Release
  AppVerBuild: Word; // Build Number

  strVersion: string;

  { Global Settings }
  confVoiceRate: Integer;
  confChkClipboard: Boolean;
  confUpdateCheck: Boolean;
  confDashboardTop: Boolean;
  confDashboardAutoHide: Boolean;

  confNewsInterval: Integer;
  confLastNewsCheck: Integer;

  confAltEnable: Boolean;
  confCtrlEnable: Boolean;
  confShiftEnable: Boolean;
  confHotKey: Integer;
  confHotKeyEnable: Boolean;

  { Like us message }
  confLikeUsShow: Integer;
  IsLikeUsShowToday: Boolean = False;

  confInfoNotifyShow: Integer;

  AppDir: string;

  { HotKey }
  HKid: Integer;
  HKMods: Integer;
  strModHotKey, strHotKey: string;

implementation

uses
  uFrmMain, uTextStrings;

{ ****************************** N E W    P A R T ****************************** }

Function IsFormLoaded(Const xFormName: String): Boolean;
Var
  i: Integer;
Begin
  Result := False;
  For i := Screen.FormCount - 1 Downto 0 Do
    If (LowerCase(Screen.Forms[i].Name) = LowerCase(xFormName)) Then
    Begin
      Result := True;
      Break;
    End;
End;

Procedure CheckCreateForm(InstanceClass: TComponentClass; Var xForm;
  Const xFormName: String);
begin
  If Not IsFormLoaded(xFormName) Then
  Begin
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
  With VerValue^ do
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

function AppVersionInfo: String;
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
Var
  Reg: TMyRegistry;
begin
  Reg := TMyRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;

  If Reg.OpenKey('Software\Imaginative World\Shadhin Ovidhan', True) = True Then
  Begin

    confVoiceRate := strtoint(Reg.ReadStringDef('SpeechRate', '0'));
    confChkClipboard := strtobool(Reg.ReadStringDef('chkClipBoard', 'True'));
    confUpdateCheck := strtobool(Reg.ReadStringDef('AUChk', 'True'));

    confDashboardTop := strtobool(Reg.ReadStringDef('DashboardTop', 'False'));
    confDashboardAutoHide := strtobool(Reg.ReadStringDef('DashboardAutoHide',
        'True'));

    confNewsInterval := strtoint(Reg.ReadStringDef('NewsInterval', '1'));
    confLastNewsCheck := strtoint(Reg.ReadStringDef('LastNewsCheck', '0'));

    confAltEnable := strtobool(Reg.ReadStringDef('AltEnable', 'False'));
    confCtrlEnable := strtobool(Reg.ReadStringDef('CtrlEnable', 'True'));
    confShiftEnable := strtobool(Reg.ReadStringDef('ShiftEnable', 'False'));
    confHotKey := strtoint(Reg.ReadStringDef('HotKey', '123')); // 123 => F12
    confHotKeyEnable := strtobool(Reg.ReadStringDef('HotKeyEnable', 'True'));

    confLikeUsShow := strtoint(Reg.ReadStringDef('LikeUsShow', '0'));
    confInfoNotifyShow := strtoint(Reg.ReadStringDef('InfoNotifyShow', '0'));
  End;

  Reg.Free;
end;

procedure SetSettings;
Var
  Reg: TMyRegistry;
begin
  Reg := TMyRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  If Reg.OpenKey('Software\Imaginative World\Shadhin Ovidhan', True) = True Then
  Begin

    Reg.WriteString('SpeechRate', IntToStr(confVoiceRate));
    Reg.WriteString('chkClipBoard', boolToStr(confChkClipboard));
    Reg.WriteString('AUChk', boolToStr(confUpdateCheck));

    Reg.WriteString('DashboardTop', boolToStr(confDashboardTop));
    Reg.WriteString('DashboardAutoHide', boolToStr(confDashboardAutoHide));

    Reg.WriteString('NewsInterval', IntToStr(confNewsInterval));
    Reg.WriteString('LastNewsCheck', IntToStr(confLastNewsCheck));

    Reg.WriteString('AltEnable', boolToStr(confAltEnable));
    Reg.WriteString('CtrlEnable', boolToStr(confCtrlEnable));
    Reg.WriteString('ShiftEnable', boolToStr(confShiftEnable));
    Reg.WriteString('HotKey', IntToStr(confHotKey));
    Reg.WriteString('HotKeyEnable', boolToStr(confHotKeyEnable));

    Reg.WriteString('LikeUsShow', IntToStr(confLikeUsShow));
    Reg.WriteString('InfoNotifyShow', IntToStr(confInfoNotifyShow));

  End;

  Reg.Free;
end;

procedure ResetSettings;
Var
  Reg: TMyRegistry;
begin
  Reg := TMyRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  If Reg.OpenKey('Software\Imaginative World\Shadhin Ovidhan', True) = True Then
  Begin
    Reg.WriteString('SpeechRate', '0');
    Reg.WriteString('chkClipBoard', boolToStr(True));
    Reg.WriteString('AUChk', boolToStr(True));

    Reg.WriteString('DashboardTop', boolToStr(False));
    Reg.WriteString('DashboardAutoHide', boolToStr(True));

    Reg.WriteString('NewsInterval', IntToStr(1));
    Reg.WriteString('LastNewsCheck', IntToStr(0));

    Reg.WriteString('AltEnable', boolToStr(False));
    Reg.WriteString('CtrlEnable', boolToStr(True));
    Reg.WriteString('ShiftEnable', boolToStr(False));
    Reg.WriteString('HotKey', IntToStr(123));
    Reg.WriteString('HotKeyEnable', boolToStr(True));

    Reg.WriteString('LikeUsShow', IntToStr(0));
    Reg.WriteString('InfoNotifyShow', IntToStr(0));
  End;

  Reg.Free;

  Begin
    confVoiceRate := 0;
    confChkClipboard := True;
    confUpdateCheck := True;

    confDashboardTop := False;
    confDashboardAutoHide := True;

    confNewsInterval := 1;
    confLastNewsCheck := 0;

    confAltEnable := False;
    confCtrlEnable := True;
    confShiftEnable := False;
    confHotKey := 123; // 123 = F12
    confHotKeyEnable := True;

    confLikeUsShow := 0;
    confInfoNotifyShow := 0;
  End;
end;

{ ****************************** N E W    P A R T ****************************** }

Procedure Execute_Something(Const xFile: String; const xParam: String = '');
Begin
  // ShellExecute(Application.handle, 'open', Pchar(xFile), Nil, Nil,
  // SW_SHOWNORMAL);

  if FileExists(xFile) then
    //ShellExecute(0, 'open', Pchar(xFile), Pchar(xParam), Nil, SW_SHOWNORMAL)
    ShellExecute(Application.Handle, 'open', Pchar(xFile), Pchar(xParam), Nil, SW_SHOWNORMAL)
  else
    Application.MessageBox //
      (Pchar(strExeNotFound + #10 + #10 + strIfItBug + #10 + strIWEmail), //
      Pchar(Forms.Application.Title),
      MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);

End;

{ ****************************** N E W    P A R T ****************************** }

Procedure Open_URL(Const xURL: String);
Begin

  ShellExecute(0, 'open', Pchar(xURL), Nil, Nil, SW_SHOWNORMAL)

End;

{ ****************************** N E W    P A R T ****************************** }

procedure TrimAppMemorySize;
Var
  MainHandle: THandle;
begin
  Try
    MainHandle := OpenProcess(PROCESS_ALL_ACCESS, False, GetCurrentProcessID);
    SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF);
    CloseHandle(MainHandle);
  Except
  End;
  Application.ProcessMessages;
end;

{ ****************************** N E W    P A R T ****************************** }

Function IsConnected: Boolean;
Var
  dwConnectionTypes: DWORD;
Begin
  Result := False;
  dwConnectionTypes := INTERNET_CONNECTION_MODEM + INTERNET_CONNECTION_LAN +
    INTERNET_CONNECTION_PROXY;

  Result := InternetGetConnectedState(@dwConnectionTypes, 0);
End;

{ ****************************** N E W    P A R T ****************************** }

Procedure SelectAndRegHotkey(const reReg: Boolean = False);
var
  Result: Boolean;
begin

  if confHotKeyEnable then
  begin

    { ReRegister }
    if reReg then
    begin
      UnRegHotKey;
    end;

    { Set Modifire HotKey and Strings }   // HKMods    strHotKey
    If confCtrlEnable Then
    begin
      HKMods := MOD_CONTROL;
      strModHotKey := 'Ctrl';
    End;
    If confShiftEnable Then
    begin
      HKMods := MOD_SHIFT;
      strModHotKey := 'Shift';
    End;
    If confAltEnable Then
    begin
      HKMods := MOD_ALT;
      strModHotKey := 'Alt';
    End;
    If confCtrlEnable And confShiftEnable Then
    begin
      HKMods := MOD_CONTROL + MOD_SHIFT;
      strModHotKey := 'Ctrl + Shift';
    End;
    If confCtrlEnable And confAltEnable Then
    begin
      HKMods := MOD_CONTROL + MOD_ALT;
      strModHotKey := 'Ctrl + Alt';
    End;
    If confShiftEnable And confAltEnable Then
    begin
      HKMods := MOD_SHIFT + MOD_ALT;
      strModHotKey := 'Shift + Alt';
    End;
    If confCtrlEnable And confShiftEnable And confAltEnable Then
    begin
      HKMods := MOD_CONTROL + MOD_SHIFT + MOD_ALT;
      strModHotKey := 'Ctrl + Shift + Alt';
    End;

    { Register HotKey }
    HKid := GlobalAddAtom('SOHotkey');

    Result := RegisterHotKey(frmMain.handle, HKid, HKMods, confHotKey);

    if Result = False then
    begin

      confHotKeyEnable := False;

      SetSettings;

      GlobalDeleteAtom(HKid);

      frmMain.TrayIcon.Hint := //
        'Shadhin Ovidhan' + #10 + 'Click here to show Shadhin Dashboard.' +
        #10 + //
        'Quick Search hotkey Turned Off.';

      showmessage('Your desire Hotkey already used by another Program.' + //
          #10 + 'So Hotkey Feature Turned Off.' + //
          #10 + 'Please try another Hotkey and then Turn it On again.' + //
          #10 + #10 + //
          strIfItBug);

      exit;

    end;

    { Set HotKey string }
    case confHotKey of
      VK_F1:
        begin
          strHotKey := 'F1';
        end;
      VK_F2:
        begin
          strHotKey := 'F2';
        end;
      VK_F3:
        begin
          strHotKey := 'F3';
        end;
      VK_F4:
        begin
          strHotKey := 'F4';
        end;
      VK_F5:
        begin
          strHotKey := 'F5';
        end;
      VK_F6:
        begin
          strHotKey := 'F6';
        end;
      VK_F7:
        begin
          strHotKey := 'F7';
        end;
      VK_F8:
        begin
          strHotKey := 'F8';
        end;
      VK_F9:
        begin
          strHotKey := 'F9';
        end;
      VK_F10:
        begin
          strHotKey := 'F10';
        end;
      VK_F11:
        begin
          strHotKey := 'F11';
        end;
      VK_F12:
        begin
          strHotKey := 'F12';
        end;
    end;

    frmMain.TrayIcon.Hint := //
      'Shadhin Ovidhan' + #10 + 'Click here to show Shadhin Dashboard.' + #10 +
    //
      'Press ' + strModHotKey + ' + ' + strHotKey + ' for Quick Search';

  end
  else
  begin

    UnRegHotKey;

    frmMain.TrayIcon.Hint := //
      'Shadhin Ovidhan' + #10 + 'Click here to show Shadhin Dashboard.' + #10 +
    //
      'Quick Search hotkey Turned Off.';

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure UnRegHotKey;
begin
  if HKid <> 0 then
  begin
    UnRegisterHotKey(frmMain.handle, HKid);
    GlobalDeleteAtom(HKid);
  end;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure ShowTrayInfo;
begin

  if confInfoNotifyShow < 2 then
  begin

    frmMain.TrayIcon.BalloonHint := 'Shadhin Dashboard minimized here.' + #10 +
      'Click here to show Dashboard again.' + #10 +
      'Right click here to show Tray Menu.';

    frmMain.TrayIcon.ShowBalloonHint;

    confInfoNotifyShow := confInfoNotifyShow + 1;

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

end.
