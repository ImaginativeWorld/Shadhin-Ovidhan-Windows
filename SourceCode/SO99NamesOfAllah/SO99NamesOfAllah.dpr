program SO99NamesOfAllah;

uses
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
  Mutex := CreateMutex(Nil, True, 'SO99Names');

  If (Mutex = 0) Or (GetLastError <> 0) Then
  Begin

    Application.MessageBox(PChar('Shadhin Ovidhan - 99 Names of Allah' + strAlreadyRunning + #10 + strIWEmail),
      'SO - 99 Names of Allah | Info',
      MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);

    Application.Terminate;
    exit;
  End;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Shadhin Ovidhan | 99 Names of Allah';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

  If Mutex <> 0 Then
    CloseHandle(Mutex);

end.
