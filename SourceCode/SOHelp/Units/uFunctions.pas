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
  ActiveX, Classes, SHDocVw, Forms, MSHTML, ShellAPI, Windows, SysUtils;

Procedure Execute_Something(Const xFile: String; const xParam: String = '');
Procedure Open_URL(Const xURL: String);

{ Browser }
procedure WB_LoadHTML(WebBrowser: TWebBrowser; HTMLCode: string);

var
  AppDir: string;

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
        sl.SaveToStream(ms);
        ms.Seek(0, 0); (WebBrowser.Document as IPersistStreamInit)
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

end.
