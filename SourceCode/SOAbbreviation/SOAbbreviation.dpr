program SOAbbreviation;

uses
  Forms,
  Windows,
  uFrmMain in 'uFrmMain.pas' {frmMain},
  SQLite3 in 'Unit\SQLite3.pas',
  SQLiteTable3 in 'Unit\SQLiteTable3.pas',
  uRegistry in 'Unit\uRegistry.pas',
  uFunctions in 'Unit\uFunctions.pas',
  uTextStrings in '..\ShadhinOvidhan\Units\uTextStrings.pas';

Var
  Mutex: THandle;

{$R *.res}
{$R ../ShadhinOvidhan.REC}

begin

  // Mutex and instance check
  Mutex := CreateMutex(Nil, True, 'SOAbbriviation');

  If (Mutex = 0) Or (GetLastError <> 0) Then
  Begin

    Application.MessageBox(PChar('Shadhin Ovidhan - Abbreviation' + strAlreadyRunning + #10 + strIWEmail),
      'SO - Abbreviation | Info',
      MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);

    Application.Terminate;
    exit;
  End;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Shadhin Ovidhan | Abbreviation';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

  If Mutex <> 0 Then
    CloseHandle(Mutex);

end.
