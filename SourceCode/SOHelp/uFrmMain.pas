{
 *******************************************************************
 This Source Code Form is subject to the terms of the Mozilla Public
 License, v. 2.0. If a copy of the MPL was not distributed with this
 file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *******************************************************************
}

unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ImgList, pngimage, SHDocVw, AppEvnts,
  Buttons, ActiveX, OleCtrls;

type
  TfrmMain = class(TForm)
    pnlTop: TPanel;
    pnlDown: TPanel;
    imgIWlogo: TImage;
    pnlBG: TPanel;
    pnlBody: TPanel;
    imgHeader: TImage;
    WB1: TWebBrowser;
    ApplicationEvents: TApplicationEvents;
    pnlBtnExit: TPanel;
    pnlBtnHome: TPanel;
    pnlBtnGoBrowser: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure pnlTopMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnFinishClick(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure WB1StatusTextChange(ASender: TObject; const Text: WideString);
    procedure WB1BeforeNavigate2(ASender: TObject; const pDisp: IDispatch;
      var URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
      var Cancel: WordBool);
    procedure sBtnExitClick(Sender: TObject);
    procedure imgIWlogoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pnlBtnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlBtnMouseEnter(Sender: TObject);
    procedure pnlBtnMouseLeave(Sender: TObject);
    procedure pnlBtnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlBtnExitClick(Sender: TObject);
    procedure pnlBtnHomeClick(Sender: TObject);
    procedure pnlBtnGoBrowserClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }

  protected
    procedure CreateParams(var Params: TCreateParams); override;

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  uFunctions,
  uTextStrings;

procedure TfrmMain.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  { Browser: Disable Popup menu }
  if (Msg.Message = WM_RBUTTONDOWN) or (Msg.Message = WM_RBUTTONDBLCLK) then
  begin
    if IsChild(WB1.Handle, Msg.hwnd) then
    begin
      // Show your own Popupor or whatever you want here
      Handled := True;
    end;
  end;
  { Browser: Disable Ctrl-N }
  if (GetKeyState(VK_CONTROL) <> 0) and (Msg.Message = WM_KEYDOWN) and
    (Msg.wParam = Ord('N')) then
  begin
    Handled := True;
  end;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.btnFinishClick(Sender: TObject);
begin
  self.Close;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.CreateParams(var Params: TCreateParams);
const
  CS_DROPSHADOW = $00020000;
begin
  inherited;
  Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  Action := caFree;

  frmMain := Nil;

end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  { Shaped Form }
  ShapeBG: HRGN;
begin

  { Set Application Default Dir }
  AppDir := ExtractFilePath(Forms.Application.ExeName);

  { Shaped Form }
  ShapeBG := CreateRoundRectRgn(0, 0, 750, 560, 11, 11);
  // ( Left, Top, Width, Height, Circle -, Circle | )
  SetWindowRgn(Handle, ShapeBG, True);
  DeleteObject(ShapeBG);

  { Browser }

  // WB_LoadHTML(WB1, '<body ><p align=center> I <b> Love </b> U </p></body>');

  WB1.Navigate( //
    Pchar('file:///' + AppDir + 'Help_Data/index.html'));

  end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.imgIWlogoClick(Sender: TObject);
begin
  Open_URL(strLogoURL);
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlTopMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    TForm(frmMain).Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.sBtnExitClick(Sender: TObject);
begin
  self.Close;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.WB1BeforeNavigate2(ASender: TObject; const pDisp: IDispatch;
  var URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
  var Cancel: WordBool);
var
  msgResult: Integer;
begin
  if (copy(URL, 0, 4) = 'http') or (copy(URL, 0, 4) = 'mail') then
  begin
    Cancel := True;

    msgResult := MessageDlg('Are you sure want to go: ' + #10 + URL,
      mtConfirmation, mbYesNo, 0);

    if msgResult = mrYes then
    begin
      // showmessage('HTTP link!' + #10 + #10 + url);

      Open_URL(URL);

    end;
  end;
end;

procedure TfrmMain.WB1StatusTextChange(ASender: TObject;
  const Text: WideString);
begin
  //
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlBtnExitClick(Sender: TObject);
begin
  Close;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlBtnGoBrowserClick(Sender: TObject);
begin
  Execute_Something(AppDir + 'Help_Data/index.html');
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlBtnHomeClick(Sender: TObject);
begin
  WB1.Navigate( //
    Pchar('file:///' + AppDir + 'Help_Data/index.html'));
end;

{ ****************************** N E W    P A R T ****************************** }
{$REGION '          Panel Appreance         '}

procedure TfrmMain.pnlBtnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin (Sender as TPanel)
  .Color := clBlack; (Sender as TPanel)
  .Font.Color := clWhite;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlBtnMouseEnter(Sender: TObject);
begin (Sender as TPanel)
  .Color := clGray; (Sender as TPanel)
  .Font.Color := clWhite;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlBtnMouseLeave(Sender: TObject);
begin (Sender as TPanel)
  .Color := clWhite; (Sender as TPanel)
  .Font.Color := clBlack;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlBtnMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin (Sender as TPanel)
  .Color := clGray; (Sender as TPanel)
  .Font.Color := clWhite;
end;
{$ENDREGION}
{ ****************************** N E W    P A R T ****************************** }

end.
