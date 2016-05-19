{
 *******************************************************************
 This Source Code Form is subject to the terms of the Mozilla Public
 License, v. 2.0. If a copy of the MPL was not distributed with this
 file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *******************************************************************
}

{$INCLUDE ../ProjectDefines.inc}
unit uFrmOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Tabs, Buttons;

type
  TfrmOptions = class(TForm)
    pnlDown: TPanel;
    lblVersion: TLabel;
    Panel1: TPanel;
    ScrollBox: TScrollBox;
    chkBoxUpdate: TCheckBox;
    Label1: TLabel;
    cmbBoxIWnews: TComboBox;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    tBarSpRate: TTrackBar;
    GroupBox2: TGroupBox;
    chkBoxCtrl: TCheckBox;
    chkBoxShift: TCheckBox;
    chkBoxAlt: TCheckBox;
    cmbBoxHotKey: TComboBox;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    pnlBtnOk: TPanel;
    pnlBtnCancel: TPanel;
    pnlBtnUpdate: TPanel;
    pnlBG: TPanel;
    chkBoxAutoHide: TCheckBox;
    pnlBtnReset: TPanel;
    chkBoxHotKey: TCheckBox;

    procedure SetComponents;
    procedure SaveSettings;

    procedure btnOkClick(Sender: TObject);
    procedure pnlBtnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlBtnMouseEnter(Sender: TObject);
    procedure pnlBtnMouseLeave(Sender: TObject);
    procedure pnlBtnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure pnlBtnCancelClick(Sender: TObject);
    procedure pnlBtnResetClick(Sender: TObject);
    procedure pnlBtnUpdateClick(Sender: TObject);
    procedure chkBoxHotKeyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOptions: TfrmOptions;

implementation

{$R *.dfm}

Uses
  uFunctions,
  uFrmMain;

procedure TfrmOptions.btnOkClick(Sender: TObject);
begin

  try
    SaveSettings;
    SetSettings;
    GetSettings;
    frmMain.SetComponents;

    SelectAndRegHotkey(true);

  finally
    self.Close;
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmOptions.chkBoxHotKeyClick(Sender: TObject);
begin

  if chkBoxHotKey.Checked then
  begin

    chkBoxCtrl.Enabled := true;
    chkBoxShift.Enabled := true;
    chkBoxAlt.Enabled := true;
    cmbBoxHotKey.Enabled := true;

  end
  else
  begin

    chkBoxCtrl.Enabled := False;
    chkBoxShift.Enabled := False;
    chkBoxAlt.Enabled := False;
    cmbBoxHotKey.Enabled := False;

  end;

end;

procedure TfrmOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  Action := caFree;

  frmOptions := Nil;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmOptions.FormCreate(Sender: TObject);
begin
  lblVersion.caption := 'স্বাধীন অভিধান' + #10 + strVersion;

  SetComponents;

  ScrollBox.VertScrollBar.Position := 0;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmOptions.SetComponents;
begin

  if confUpdateCheck then
    chkBoxUpdate.Checked := true
  else
    chkBoxUpdate.Checked := False;

  if confDashboardAutoHide then
    chkBoxAutoHide.Checked := true
  else
    chkBoxAutoHide.Checked := False;

  cmbBoxIWnews.ItemIndex := confNewsInterval;

  if confCtrlEnable then
    chkBoxCtrl.Checked := true
  else
    chkBoxCtrl.Checked := False;

  if confShiftEnable then
    chkBoxShift.Checked := true
  else
    chkBoxShift.Checked := False;

  if confAltEnable then
    chkBoxAlt.Checked := true
  else
    chkBoxAlt.Checked := False;

  if confHotKeyEnable then
  begin
    chkBoxHotKey.Checked := true;

    chkBoxCtrl.Enabled := true;
    chkBoxShift.Enabled := true;
    chkBoxAlt.Enabled := true;
    cmbBoxHotKey.Enabled := true;

  end
  else
  begin
    chkBoxHotKey.Checked := False;

    chkBoxCtrl.Enabled := False;
    chkBoxShift.Enabled := False;
    chkBoxAlt.Enabled := False;
    cmbBoxHotKey.Enabled := False;

  end;
  case confHotKey of
    VK_F1:
      begin
        cmbBoxHotKey.ItemIndex := 0;
      end;
    VK_F2:
      begin
        cmbBoxHotKey.ItemIndex := 1;
      end;
    VK_F3:
      begin
        cmbBoxHotKey.ItemIndex := 2;
      end;
    VK_F4:
      begin
        cmbBoxHotKey.ItemIndex := 3;
      end;
    VK_F5:
      begin
        cmbBoxHotKey.ItemIndex := 4;
      end;
    VK_F6:
      begin
        cmbBoxHotKey.ItemIndex := 5;
      end;
    VK_F7:
      begin
        cmbBoxHotKey.ItemIndex := 6;
      end;
    VK_F8:
      begin
        cmbBoxHotKey.ItemIndex := 7;
      end;
    VK_F9:
      begin
        cmbBoxHotKey.ItemIndex := 8;
      end;
    VK_F10:
      begin
        cmbBoxHotKey.ItemIndex := 9;
      end;
    VK_F11:
      begin
        cmbBoxHotKey.ItemIndex := 10;
      end;
    VK_F12:
      begin
        cmbBoxHotKey.ItemIndex := 11;
      end;

  end;

  tBarSpRate.Position := confVoiceRate;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmOptions.SaveSettings;
begin

  if chkBoxUpdate.Checked then
    confUpdateCheck := true
  else
    confUpdateCheck := False;

  if chkBoxAutoHide.Checked then
    confDashboardAutoHide := true
  else
    confDashboardAutoHide := False;

  confNewsInterval := cmbBoxIWnews.ItemIndex;

  if chkBoxCtrl.Checked then
    confCtrlEnable := true
  else
    confCtrlEnable := False;

  if chkBoxShift.Checked then
    confShiftEnable := true
  else
    confShiftEnable := False;

  if chkBoxAlt.Checked then
    confAltEnable := true
  else
    confAltEnable := False;

  if chkBoxHotKey.Checked then
    confHotKeyEnable := true
  else
    confHotKeyEnable := False;

  case cmbBoxHotKey.ItemIndex of
    0:
      begin
        confHotKey := VK_F1;
      end;
    1:
      begin
        confHotKey := VK_F2;
      end;
    2:
      begin
        confHotKey := VK_F3;
      end;
    3:
      begin
        confHotKey := VK_F4;
      end;
    4:
      begin
        confHotKey := VK_F5;
      end;
    5:
      begin
        confHotKey := VK_F6;
      end;
    6:
      begin
        confHotKey := VK_F7;
      end;
    7:
      begin
        confHotKey := VK_F8;
      end;
    8:
      begin
        confHotKey := VK_F9;
      end;
    9:
      begin
        confHotKey := VK_F10;
      end;
    10:
      begin
        confHotKey := VK_F11;
      end;
    11:
      begin
        confHotKey := VK_F12;
      end;

  end;

  confVoiceRate := tBarSpRate.Position;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmOptions.pnlBtnCancelClick(Sender: TObject);
begin
  Close;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmOptions.pnlBtnResetClick(Sender: TObject);
var
  MsgResult: Integer;
begin

  MsgResult := MessageDlg('Are you sure want to RESET all settings?',
    mtInformation, mbYesNo, 0);

  if MsgResult = mrYes then
  begin
    try
      ResetSettings;

      GetSettings;

      SetComponents;

      frmMain.SetComponents;
    finally
      showmessage('Reset completed!');
    end;
  end;
end;

procedure TfrmOptions.pnlBtnUpdateClick(Sender: TObject);
begin
  if FileExists(ExtractFilepath(application.exename) + 'SOCommon.exe') then
  begin

    Execute_Something(AppDir + 'SOCommon.exe', '-notsilent');

  end
  else
  begin
    application.MessageBox(Pchar('Error Description:' + #10 +
          'Some executable file of Shadhin Ovidhan not found!' + #10 + #10 +
          #10 + 'Please reinstall Shadhin Ovidhan and try again.' + #10 +
          #10 + #10 +
          'If you think this is a Bug then please let us know about this problem.')
        , 'Shadhin Ovidhan | Info',
      MB_OK + MB_ICONHAND + MB_DEFBUTTON1 + MB_APPLMODAL);
  end;
end;

{ ****************************** N E W    P A R T ****************************** }
{$REGION '          Panel Appearance         '}

procedure TfrmOptions.pnlBtnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin (Sender as TPanel)
  .Color := clBlack; (Sender as TPanel)
  .Font.Color := clWhite;
end;

procedure TfrmOptions.pnlBtnMouseEnter(Sender: TObject);
begin (Sender as TPanel)
  .Color := clGray; (Sender as TPanel)
  .Font.Color := clWhite;
end;

procedure TfrmOptions.pnlBtnMouseLeave(Sender: TObject);
begin (Sender as TPanel)
  .Color := clWhite; (Sender as TPanel)
  .Font.Color := clBlack;
end;

procedure TfrmOptions.pnlBtnMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin (Sender as TPanel)
  .Color := clGray; (Sender as TPanel)
  .Font.Color := clWhite;
end;
{$ENDREGION}
{ ****************************** N E W    P A R T ****************************** }

end.
