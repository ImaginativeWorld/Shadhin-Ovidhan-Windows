program SOGreekLetter;

uses
  Forms,
  Windows,
  uFrmMain in 'uFrmMain.pas' {frmMain},
  SQLite3 in 'Unit\SQLite3.pas',
  SQLiteTable3 in 'Unit\SQLiteTable3.pas',
  uRegistry in 'Unit\uRegistry.pas',
  uTextStrings in '..\ShadhinOvidhan\Units\uTextStrings.pas';

Var
  Mutex: THandle;

{$R *.res}
{$R ../ShadhinOvidhan.REC}

begin

  { Disable FPU exceptions. No need to restore, setting is process specific. }
   Set8087CW($133F);

  // Mutex and instance check
  Mutex := CreateMutex(Nil, True, 'SOGLetter');

  If (Mutex = 0) Or (GetLastError <> 0) Then
  Begin

    Application.MessageBox(PChar('Shadhin Ovidhan - Greek Letter' + strAlreadyRunning + #10 + strIWEmail),
      'SO - Greek Letter | Info',
      MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);

    Application.Terminate;
    exit;
  End;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Shadhin Ovidhan | Greek Letter';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

  If Mutex <> 0 Then
    CloseHandle(Mutex);

end.
