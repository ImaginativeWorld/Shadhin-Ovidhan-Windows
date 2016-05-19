program SOGTranslate;

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
  Mutex := CreateMutex(Nil, True, 'SOGTranslate');

  If (Mutex = 0) Or (GetLastError <> 0) Then
  Begin

    Application.MessageBox(PChar('Shadhin Ovidhan - Google Translate' +
          strAlreadyRunning + #10 + strIWEmail),
      'SO - Google Translate | Info',
      MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);

    Application.Terminate;
    exit;
  End;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Shadhin Ovidhan | Google Translate';
  Application.CreateForm(TfrmMain, frmMain);
  // Application.ShowMainForm := False; // Hide Form on Startup
  Application.Run;

  If Mutex <> 0 Then
    CloseHandle(Mutex);

end.
