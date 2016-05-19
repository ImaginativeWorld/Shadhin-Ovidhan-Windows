program SOBanglaAidKit;

uses
  Forms,
  Windows,
  uFrmMain in 'uFrmMain.pas' {frmMain},
  uFunctions in 'Units\uFunctions.pas',
  uRegistry in 'Units\uRegistry.pas',
  uTextStrings in '..\ShadhinOvidhan\Units\uTextStrings.pas';

Var
  Mutex: THandle;

{$R *.res}
{$R ../BAKmf.REC}

begin

  { Disable FPU exceptions. No need to restore, setting is process specific. }
  Set8087CW($133F);

  // Mutex and instance check
  Mutex := CreateMutex(Nil, True, 'SOBanglaAidKit');

  If (Mutex = 0) Or (GetLastError <> 0) Then
  Begin

    Application.MessageBox(PChar('Shadhin Ovidhan - Bangla Aid Kit' + strAlreadyRunning + #10 + strIWEmail),
      'SO - Bangla Aid Kit | Info',
      MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);

    Application.Terminate;
    exit;
  End;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Shadhin Ovidhan | Bangla Aid Kit';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

  If Mutex <> 0 Then
    CloseHandle(Mutex);

end.
