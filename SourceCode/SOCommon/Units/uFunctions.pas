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
  Registry,
  ShellAPI,
  StdCtrls, // (Ex. TEdit)
  ClipBrd, // Clipboard
  StrUtils; // (Ex. AnsiContainsText)

// Version
procedure GetBuildInfo(var V1, V2, V3, V4: Word);
procedure SetVersionInfo;
function AppVersionInfo: String;

// Show a Form
Function IsFormLoaded(Const xFormName: String): Boolean;
Procedure CheckCreateForm(InstanceClass: TComponentClass; Var xForm;
  Const xFormName: String);

// Settings
// procedure GetSettings;
// procedure SetSettings;
// procedure ResetSettings;

Procedure Execute_Something(Const xFile: String; const xParam: String = '');
Procedure Open_URL(Const xURL: String);

// procedure TrimAppMemorySize;

// Split
procedure Split(Delimiter: Char; Str: string; ListOfStrings: TStrings);
function SplitStrings(const Str: string; const separator: string = ',';
  Strings: TStrings = nil): TStrings;
// function AnsiSplitStrings(const Str: string; const separator: string = ',';
// Strings: TStrings = nil): TStrings;

// Clipboard
// procedure ReEditAndViewClipboard(TEditName: TEdit);

// For Update Check Unit
function MemoryStreamToString(M: TMemoryStream): AnsiString;

var
  // Versions
  AppVerMajor, // Major Version
  AppVerMinor, // Minor Version
  AppVerRelease, // Release
  AppVerBuild: Word; // Build Number

  strAppName: string;
  strVersion: string;

  // Overal Settings
  confIntEnSrcType: Integer;
  confIntBnSrcType: Integer;
  confVoiceRate: Integer;
  confChkClipboard: Boolean;
  confUpdateCheck: Boolean;

  AppDir: string;

  UpdateSilent: Boolean = True;

implementation

uses
  uLabelFadeEffect,
  uTextStrings;

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

{ ****************************** N E W    P A R T ****************************** }

procedure SetVersionInfo;
begin
  GetBuildInfo(AppVerMajor, AppVerMinor, AppVerRelease, AppVerBuild);
end;

{ ****************************** N E W    P A R T ****************************** }

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

// procedure GetSettings;
// Var
// Reg: TMyRegistry;
// begin
// Reg := TMyRegistry.create;
// Reg.RootKey := HKEY_CURRENT_USER;
//
// If Reg.OpenKey('Software\Imaginative World\Shadhin Ovidhan', True) = True Then
// Begin
// confIntEnSrcType := strtoint(Reg.ReadStringDef('EnSearchType', '1'));
// confIntBnSrcType := strtoint(Reg.ReadStringDef('BnSearchType', '2'));
// confVoiceRate := strtoint(Reg.ReadStringDef('SpeechRate', '0'));
// confChkClipboard := strtobool(Reg.ReadStringDef('chkClipBoard', 'True'));
// confUpdateCheck := strtobool(Reg.ReadStringDef('OUChk', 'True'));
// End;
//
// Reg.Free;
// end;
//
// procedure SetSettings;
// Var
// Reg: TMyRegistry;
// begin
// Reg := TMyRegistry.create;
// Reg.RootKey := HKEY_CURRENT_USER;
// If Reg.OpenKey('Software\Imaginative World\Shadhin Ovidhan', True) = True Then
// Begin
// Reg.WriteString('EnSearchType', IntToStr(confIntEnSrcType));
// Reg.WriteString('BnSearchType', IntToStr(confIntBnSrcType));
// Reg.WriteString('SpeechRate', IntToStr(confVoiceRate));
// Reg.WriteString('chkClipBoard', boolToStr(confChkClipboard));
// Reg.WriteString('OUChk', boolToStr(confUpdateCheck));
// End;
//
// Reg.Free;
// end;
//
// procedure ResetSettings;
// Var
// Reg: TMyRegistry;
// begin
// Reg := TMyRegistry.create;
// Reg.RootKey := HKEY_CURRENT_USER;
// If Reg.OpenKey('Software\Imaginative World\Shadhin Ovidhan', True) = True Then
// Begin
// Reg.WriteString('EnSearchType', '1');
// Reg.WriteString('BnSearchType', '2');
// Reg.WriteString('SpeechRate', '0');
// Reg.WriteString('chkClipBoard', booltostr(True));
// Reg.WriteString('OUChk', booltostr(True));
// End;
//
// Reg.Free;
//
// Begin
// confIntEnSrcType := 1;
// confIntBnSrcType := 2;
// confVoiceRate := 0;
// confChkClipboard := True;
// confUpdateCheck := True;
// End;
// end;

{ ****************************** N E W    P A R T ****************************** }

Procedure Execute_Something(Const xFile: String; const xParam: String = '');
Begin
  // ShellExecute(Application.handle, 'open', Pchar(xFile), Nil, Nil,
  // SW_SHOWNORMAL);

  if FileExists(xFile) then
    ShellExecute(0, 'open', Pchar(xFile), Pchar(xParam), Nil, SW_SHOWNORMAL)
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

// procedure TrimAppMemorySize;
// Var
// MainHandle: THandle;
// begin
// Try
// MainHandle := OpenProcess(PROCESS_ALL_ACCESS, False, GetCurrentProcessID);
// SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF);
// CloseHandle(MainHandle);
// Except
// End;
// Application.ProcessMessages;
// end;

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
    Result := TStringList.create
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
    raise ;
  end;
end;

// function AnsiSplitStrings(const Str: string; const separator: string;
// Strings: TStrings): TStrings;
/// / Fills a string list with the parts of "str" separated by
/// / "separator". If Nil is passed instead of a string list,
/// / the function creates a TStringList object which has to
/// / be freed by the caller
/// / ANSI version
// var
// n: Integer;
// p, q, s: Pchar;
// item: string;
// begin
// if Strings = nil then
// Result := TStringList.create
// else
// Result := Strings;
// try
// p := Pchar(Str);
// s := Pchar(separator);
// n := Length(separator);
// repeat
// q := AnsiStrPos(p, s);
// if q = nil then
// q := AnsiStrScan(p, #0);
// SetString(item, p, q - p);
// Result.Add(item);
// p := q + n;
// until q^ = #0;
// except
// item := '';
// if Strings = nil then
// Result.Free;
// raise ;
// end;
// end;

{ ****************************** N E W    P A R T ****************************** }

// procedure ReEditAndViewClipboard(TEditName: TEdit);
// begin
//
// if not AnsiContainsText(Clipboard.AsText, '!') and not AnsiContainsText
// (Clipboard.AsText, '@') and not AnsiContainsText(Clipboard.AsText, '#')
// and not AnsiContainsText(Clipboard.AsText, '$') and not AnsiContainsText
// (Clipboard.AsText, '%') and not AnsiContainsText(Clipboard.AsText, '^')
// and not AnsiContainsText(Clipboard.AsText, '&') and not AnsiContainsText
// (Clipboard.AsText, '*') and not AnsiContainsText(Clipboard.AsText, '(')
// and not AnsiContainsText(Clipboard.AsText, ')') // 10
// and not AnsiContainsText(Clipboard.AsText, '_') and not AnsiContainsText
// (Clipboard.AsText, '-') and not AnsiContainsText(Clipboard.AsText, '=')
// and not AnsiContainsText(Clipboard.AsText, '+') and not AnsiContainsText
// (Clipboard.AsText, '[') and not AnsiContainsText(Clipboard.AsText, ']')
// and not AnsiContainsText(Clipboard.AsText, '{') and not AnsiContainsText
// (Clipboard.AsText, '}') and not AnsiContainsText(Clipboard.AsText, ';')
// and not AnsiContainsText(Clipboard.AsText, ':') // 20
// and not AnsiContainsText(Clipboard.AsText, '''') and not AnsiContainsText
// (Clipboard.AsText, '|') and not AnsiContainsText(Clipboard.AsText, '\')
// and not AnsiContainsText(Clipboard.AsText, ',') and not AnsiContainsText
// (Clipboard.AsText, '<') and not AnsiContainsText(Clipboard.AsText, '.')
// and not AnsiContainsText(Clipboard.AsText, '>') and not AnsiContainsText
// (Clipboard.AsText, '/') and not AnsiContainsText(Clipboard.AsText, '?')
// and not AnsiContainsText(Clipboard.AsText, '`') // 30
// and not AnsiContainsText(Clipboard.AsText, '~') and not AnsiContainsText
// (Clipboard.AsText, '©') and not AnsiContainsText(Clipboard.AsText, '®')
// and not AnsiContainsText(Clipboard.AsText, '"') then
// begin
//
// TEditName.Text := Clipboard.AsText;
//
// end;

// end;

{ ****************************** N E W    P A R T ****************************** }
{$REGION '          Update Check | Needed functions         '}

function MemoryStreamToString(M: TMemoryStream): AnsiString;
begin
  SetString(Result, PAnsiChar(M.Memory), M.Size);
end;
{$ENDREGION}

end.
