program SOPortableWizard;

uses
  Forms,
  Windows,
  uFrmMain in 'uFrmMain.pas' {frmMain},
  uTextStrings in '..\ShadhinOvidhan\Units\uTextStrings.pas';

Var
  Mutex: THandle;

{$R *.res}
{$R ../ShadhinOvidhan.REC}

begin

  // Mutex and instance check
  Mutex := CreateMutex(Nil, True, 'SOPortableWizard');

  If (Mutex = 0) Or (GetLastError <> 0) Then
  Begin

    Application.MessageBox(PChar('Shadhin Ovidhan - Portable Wizard' + strAlreadyRunning + #10 + strIWEmail),
      'SO - Portable Wizard | Info',
      MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);

    Application.Terminate;
    exit;
  End;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Shadhin Ovidhan | Portable Wizard';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

  If Mutex <> 0 Then
    CloseHandle(Mutex);

end.
