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

program SOBanglaCalendar;

uses
  Forms,
  Windows,
  uFrmMain_BanglaCalendar in 'uFrmMain_BanglaCalendar.pas' {frmMain},
  uBanglaCalendar in 'Units\uBanglaCalendar.pas',
  uFunctions in 'Units\uFunctions.pas',
  uRegistry in 'Units\uRegistry.pas',
  uTextStrings in 'Units\uTextStrings.pas';

Var
  Mutex: THandle;

{$R *.res}
{$R ../ShadhinOvidhan.REC}

begin

  { Disable FPU exceptions. No need to restore, setting is process specific. }
  Set8087CW($133F);

  // Mutex and instance check
  Mutex := CreateMutex(Nil, True, 'SOBnCalendar');

  If (Mutex = 0) Or (GetLastError <> 0) Then
  Begin

    Application.MessageBox(PChar('Shadhin Ovidhan - Metro Bangla Calendar' + strAlreadyRunning + #10 + strIWEmail),
      'SO - Metro Bangla Calendar | Info',
      MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);

    Application.Terminate;
    exit;
  End;

  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  Application.Title := 'Shadhin Ovidhan | Metro Bangla Calendar';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

  If Mutex <> 0 Then
    CloseHandle(Mutex);

end.
