{ ***************************************************************************

  Coded by-
  Md. Mahmudul Hasan Shohag
  CEO of Imaginative World
  E-mail: shohag_iw@yahoo.com

  Besed On-
  JvStringGrid

  *************************************************************************** }
{$INCLUDE ../ProjectDefines.inc}
program ShadhinOvidhan;

uses
  Forms,
  Windows,
  SysUtils,
  ufrmDic in 'ufrmDic.pas' { frmDic },
  uFunctions in 'Units\uFunctions.pas',
  uFrmQSearch in 'uFrmQSearch.pas' { frmQSearch },
  uRegistry in 'Units\uRegistry.pas',
  uFrmOptions in 'uFrmOptions.pas' { frmOptions },
  uFrmWordmarks in 'uFrmWordmarks.pas' { frmWordmarks },
  uTextStrings in 'Units\uTextStrings.pas',
  uFrmPopup in 'uFrmPopup.pas' { frmPopup },
  uFrmAddModify in 'uFrmAddModify.pas' {frmAddModify},
  uOvidhanConst in 'Units\uOvidhanConst.pas';

var
    Mutex: THandle;
{$R *.res}
{$R ../ShadhinOvidhan.REC}

begin

    { Disable FPU exceptions. No need to restore, setting is process specific. }
    Set8087CW($133F);

    // Mutex and instance check
{$IFDEF PortableOn}
    Mutex := CreateMutex(nil, True, 'ShadhinOvidhanPortable');
{$ELSE}
    Mutex := CreateMutex(nil, True, 'ShadhinOvidhan');
{$ENDIF}

    if (Mutex = 0) or (GetLastError <> 0) then
    begin

        Application.MessageBox(Pchar('Shadhin Ovidhan' + strAlreadyRunning + #10
            +
            strIWEmail),
            'Shadhin Ovidhan | Info',
            MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);

        Application.Terminate;
        exit;
    end;

    if FileExists(ExtractFilePath(Application.ExeName) + 'IW.Lib.SO.dll')
        = False then
    begin
        Application.MessageBox(Pchar('Error Description:' + #10 +
            'Necessary files of Shadhin Ovidhan not found!' + #10 + #10 + #10 +
            'Please reinstall your Shadhin Ovidhan.' + #10 + #10 + #10 +
            strIfItBug)
            , 'Shadhin Ovidhan | Info',
            MB_OK + MB_ICONHAND + MB_DEFBUTTON1 + MB_APPLMODAL);

        Application.Terminate;
        exit;
    end;

    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.Title := 'Shadhin Ovidhan';
    Application.CreateForm(TfrmDic, frmDic);
  if ParamStr(1) = '-qsearch' then
    begin

        Application.ShowMainForm := False; // Hide Form on Startup

        CheckCreateForm(TfrmQSearch, frmQSearch, 'frmQSearch');
        frmQSearch.Show;
{$IFDEF PortableOn}
    end
    else
    begin

        isfontinstalled := True;
{$ENDIF}
    end;

    Application.Run;

    if Mutex <> 0 then
        CloseHandle(Mutex);

end.

