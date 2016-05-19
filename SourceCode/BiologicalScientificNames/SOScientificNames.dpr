program SOScientificNames;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Forms,
  Windows,
  uFrmMain in 'uFrmMain.pas' {frmMain},
  SQLite3 in 'Unit\SQLite3.pas',
  SQLiteTable3 in 'Unit\SQLiteTable3.pas',
  uTextStrings in '..\ShadhinOvidhan\Units\uTextStrings.pas';

Var
  Mutex: THandle;

{$R *.res}
{$R ../ShadhinOvidhan.REC}

begin

  // Mutex and instance check
  Mutex := CreateMutex(Nil, True, 'SOSciNames');

  If (Mutex = 0) Or (GetLastError <> 0) Then
  Begin

    Application.MessageBox(PChar('Shadhin Ovidhan - Biological Scientific Names' + strAlreadyRunning + #10 + strIWEmail),
      'SO - Biological Scientific Names | Info',
      MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);

    Application.Terminate;
    exit;
  End;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Shadhin Ovidhan | Biological Scientific Names';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

  If Mutex <> 0 Then
    CloseHandle(Mutex);

end.
