program SOHelp;

uses
  Forms,
  Windows,
  uFrmMain in 'uFrmMain.pas' { frmMain } ,
  uFunctions in 'Units\uFunctions.pas',
  uTextStrings in '..\ShadhinOvidhan\Units\uTextStrings.pas';

Var
  Mutex: THandle;
{$R *.res}
{$R ../ShadhinOvidhan.REC}

begin

  { Disable FPU exceptions. No need to restore, setting is process specific. }
  Set8087CW($133F);

  // Mutex and instance check
  Mutex := CreateMutex(Nil, True, 'SOHelp');

  If (Mutex = 0) Or (GetLastError <> 0) Then
  Begin

    Application.MessageBox
      (PChar('Shadhin Ovidhan - Help' + strAlreadyRunning + #10 + strIWEmail),
      'SO - Help | Info',
      MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);

    Application.Terminate;
    exit;
  End;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Shadhin Ovidhan | Help';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

  If Mutex <> 0 Then
    CloseHandle(Mutex);

end.
