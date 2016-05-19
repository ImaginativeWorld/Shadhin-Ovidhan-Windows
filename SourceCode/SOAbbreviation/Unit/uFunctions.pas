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
   SysUtils, Forms, ShellAPI, Windows;

procedure WrapText(Text: string);


var
    { Table }
  strLine: array [0 .. 100] of string;

  Procedure Execute_Something(Const xFile: String; const xParam: String = '');
  Procedure Open_URL(Const xURL: String);


implementation

uses
  uFrmMain,
  uTextStrings;

procedure WrapText(Text: string);
  var
    S: string;
    CurrWidth: Integer;

    LineNumber: Integer;
  begin

    CurrWidth := 490;
    Text := Text + ' ';

    LineNumber := 0;

    repeat
      S := copy(Text, 1, pos(' ', Text) - 1);
      Delete(Text, 1, pos(' ', Text));

      if (frmMain.Canvas.TextWidth(S + ' ' + strLine[LineNumber]) < CurrWidth) then
      begin

      if length(strLine[LineNumber]) = 0 then
      strLine[LineNumber] := S
      else
        strLine[LineNumber] := strLine[LineNumber] + ' ' + S;

      end
      else
      begin

        LineNumber := LineNumber + 1; { * }
        strLine[LineNumber] := S;

      end;
    until length(TrimRight(Text)) = 0;

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

end.
