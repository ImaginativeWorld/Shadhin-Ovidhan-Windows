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
  Classes, SysUtils, SHDocVw, Forms, MSHTML, ShellAPI, Windows, Wininet,
  ActiveX;

{ Url Checker Neede }
function MemoryStreamToString(M: TMemoryStream): AnsiString;
function SplitStrings(const Str: string; const separator: string;
  Strings: TStrings): TStrings;

{ Browser }
procedure WB_LoadHTML(WebBrowser: TWebBrowser; HTMLCode: string);

Procedure Execute_Something(Const xFile: String; const xParam: String = '');
Procedure Open_URL(Const xURL: String);

//var
//  AppDir: string;

implementation

uses
  uTextStrings;

{ ****************************** N E W    P A R T ****************************** }

procedure WB_LoadHTML(WebBrowser: TWebBrowser; HTMLCode: string);
var
  sl: TStringList;
  ms: TMemoryStream;
begin
  WebBrowser.Navigate('about:blank');
  while (WebBrowser.ReadyState) = READYSTATE_LOADING do
    Application.ProcessMessages;

  if Assigned(WebBrowser.Document) then
  begin
    sl := TStringList.Create;
    try
      ms := TMemoryStream.Create;
      try
        sl.Text := HTMLCode;
        sl.SaveToStream(ms, TEncoding.Unicode);
        ms.Seek(0, 0); //

        (WebBrowser.Document as IPersistStreamInit)
        .Load(TStreamAdapter.Create(ms));
      finally
        ms.Free;
      end;
    finally
      sl.Free;
    end;
  end;
end;

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
      PChar(Forms.Application.Title),
      MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);

End;

{ ****************************** N E W    P A R T ****************************** }

Procedure Open_URL(Const xURL: String);
Begin

    ShellExecute(0, 'open', Pchar(xURL), Nil, Nil, SW_SHOWNORMAL)

End;

{ ****************************** N E W    P A R T ****************************** }
{$REGION '          URL Check | Needed functions         '}

function MemoryStreamToString(M: TMemoryStream): AnsiString;
begin
  SetString(Result, PAnsiChar(M.Memory), M.Size);
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
    raise ;
  end;
end;
{$ENDREGION}
{ ****************************** N E W    P A R T ****************************** }

end.
