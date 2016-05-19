program SOIntegrator;

uses
  Forms,
  Windows,
  uFrmMain in 'uFrmMain.pas' { frmMain },
  uBanglaCalendar in 'Units\uBanglaCalendar.pas',
  uFunctions in 'Units\uFunctions.pas',
  uRegistry in 'Units\uRegistry.pas',
  uFrmOptions in 'uFrmOptions.pas' {frmOptions},
  uFrmPopup in 'uFrmPopup.pas' {frmPopup},
  uTextStrings in '..\ShadhinOvidhan\Units\uTextStrings.pas';

Var
  Mutex: THandle;

{$R *.res}
{$R ../ShadhinOvidhan.REC}

begin

  { Disable FPU exceptions. No need to restore, setting is process specific. }
  Set8087CW($133F);

  // Mutex and instance check
  Mutex := CreateMutex(Nil, True, 'SODashboard');

  If (Mutex = 0) Or (GetLastError <> 0) Then
  Begin

    Application.MessageBox(PChar('Shadhin Ovidhan Dashboard' + strAlreadyRunning + #10 + strIWEmail),
      'Shadhin Ovidhan Dashboard | Info',
      MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);

    Application.Terminate;
    exit;
  End;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Shadhin Ovidhan | Dashboard';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

  If Mutex <> 0 Then
    CloseHandle(Mutex);

end.
