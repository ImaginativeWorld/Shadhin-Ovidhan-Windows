program SOFeedback;

uses
  Forms,
  Windows,
  uFrmMain in 'uFrmMain.pas' {frmMain},
  uTextStrings in '..\ShadhinOvidhan\Units\uTextStrings.pas',
  uUrlCheck in 'Units\uUrlCheck.pas',
  uFunctions in 'Units\uFunctions.pas';

Var
  Mutex: THandle;

{$R *.res}
{$R ../ShadhinOvidhan.REC}

begin

  { Disable FPU exceptions. No need to restore, setting is process specific. }
   Set8087CW($133F);

  // Mutex and instance check
  Mutex := CreateMutex(Nil, True, 'SOFeedback');

  If (Mutex = 0) Or (GetLastError <> 0) Then
  Begin

    Application.MessageBox(PChar('Shadhin Ovidhan - Feedback' + strAlreadyRunning + #10 + strIWEmail),
      'SO - Feedback | Info',
      MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);

    Application.Terminate;
    exit;
  End;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Shadhin Ovidhan | Feedback';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

  If Mutex <> 0 Then
    CloseHandle(Mutex);

end.
