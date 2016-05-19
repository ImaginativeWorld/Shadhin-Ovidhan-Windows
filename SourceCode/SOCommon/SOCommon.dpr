{ ***************************************************************************

  Coded by-
  Md. Mahmudul Hasan Shohag
  CEO of Imaginative World
  E-mail: shohag_iw@yahoo.com

  *************************************************************************** }


{

  -about
  -notsilent

}

program SOCommon;

uses
  Forms,
  Windows,
  uFunctions in 'Units\uFunctions.pas',
  uFrmAbout in 'uFrmAbout.pas' { frmAbout },
  uLabelFadeEffect in 'Units\uLabelFadeEffect.pas',
  uUpdateCheck in 'Units\uUpdateCheck.pas',
  uFrmUpdate in 'uFrmUpdate.pas' { frmUpdate },
  uTextStrings in '..\ShadhinOvidhan\Units\uTextStrings.pas';

Var
  Mutex: THandle;

{$R *.res}
{$R ../ShadhinOvidhan.REC}

begin

  { Disable FPU exceptions. No need to restore, setting is process specific. }
  Set8087CW($133F);

  // Mutex and instance check
  if ParamStr(1) = '-about' then
  begin
    Mutex := CreateMutex(Nil, True, 'SOAbout');
//    Application.MessageBox('About','Info');
  end
  else
  begin
    Mutex := CreateMutex(Nil, True, 'SOUpdate');
//    Application.MessageBox('Update', 'Info');
  end;

   If (Mutex = 0) Or (GetLastError <> 0) Then
   Begin

   Application.Terminate;
   exit;

   End;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Shadhin Ovidhan';
  Application.CreateForm(TfrmUpdate, frmUpdate);
  Application.ShowMainForm := False; // Hide Form on Startup

  if ParamStr(1) = '-about' then
  begin

    CheckCreateForm(TfrmAbout, frmAbout, 'frmAbout');
    frmAbout.Show;

  end;

  Application.Run; // UpdateSilent

  If Mutex <> 0 Then
    CloseHandle(Mutex);

end.
