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
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, SHDocVw, AppEvnts,
  Buttons, ActiveX, OleCtrls, pngimage, Graphics;

type
  TfrmMain = class(TForm)
    pnlTop: TPanel;
    pnlDown: TPanel;
    imgIWlogo: TImage;
    WB1: TWebBrowser;
    ApplicationEvents: TApplicationEvents;
    lblHeader: TLabel;
    lblTitle: TLabel;
    pnlBtnExit: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure HeaderMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnFinishClick(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure WB1StatusTextChange(ASender: TObject; const Text: WideString);
    procedure WB1BeforeNavigate2(ASender: TObject; const pDisp: IDispatch;
      var URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
      var Cancel: WordBool);
    procedure sBtnExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure WB1TitleChange(ASender: TObject; const Text: WideString);
    procedure pnlBtnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlBtnMouseEnter(Sender: TObject);
    procedure pnlBtnMouseLeave(Sender: TObject);
    procedure pnlBtnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlBtnExitClick(Sender: TObject);
    procedure imgIWlogoClick(Sender: TObject);

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
  uNewsCheck,
  uTextStrings;

procedure TfrmMain.FormCreate(Sender: TObject);
begin

  { Set Application Default Dir }
  AppDir := ExtractFilePath(Forms.Application.ExeName);

  { Shaped Form }
  // ShapeBG := CreateRoundRectRgn(0, 0, 750, 560, 3, 3); 
  // // ( Left, Top, Width, Height, Circle -, Circle | ) 
  // SetWindowRgn(Handle, ShapeBG, True); 
  // DeleteObject(ShapeBG); 

  { Start News Update }
  if NewsUpdater.IsConnected then
  begin

    NewsUpdater := TNewsCheck.Create;
    NewsUpdater.Check;

  end
  else
  begin

    Forms.Application.Terminate;

    // self.close; 

  end;

  { Browser }

  // WB_LoadHTML(WB1, '<body ><p align=center> I <b> Love </b> U </p></body>'); 

  // WB1.Navigate( // 
  // Pchar('file:///' + AppDir + 'Help_Data/index.html')); 

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.FormShow(Sender: TObject);
begin

  Forms.Application.BringToFront;

end;

{ ****************************** N E W    P A R T ****************************** }

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
  self.close;
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

  FreeAndNil(NewsUpdater);

  Action := caFree;

  frmMain := Nil;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.HeaderMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    TForm(frmMain).Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.imgIWlogoClick(Sender: TObject);
begin
  Open_URL(strLogoURL);
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.sBtnExitClick(Sender: TObject);
begin
  self.close;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.WB1BeforeNavigate2(ASender: TObject; const pDisp: IDispatch;
  var URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
  var Cancel: WordBool);
var
  msgResult: Integer;
begin
  if (copy(URL, 0, 11) = 'http://urln') or (copy(URL, 0, 11) = 'http://urls')
    then
  begin
    Cancel := True;

    msgResult := MessageDlg('Are you sure want to go: ' + #10 + // 
        copy(URL, 12, length(URL)), mtConfirmation, mbYesNo, 0);

    if msgResult = mrYes then
    begin

      {
        ***************************

        http://urls => https://

        http://urln => http://

        ***************************
        }

      if (copy(URL, 0, 11) = 'http://urls') then

        Open_URL('https://' + copy(URL, 12, length(URL)))

      else
        Open_URL('http://' + copy(URL, 12, length(URL)));

    end;

  end;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.WB1StatusTextChange(ASender: TObject;
  const Text: WideString);
begin
  // 
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.WB1TitleChange(ASender: TObject; const Text: WideString);
begin

  lblTitle.Caption := Text + ' (#' + NewsNbr + ')';

  lblTitle.left := width div 2 - lblTitle.width div 2;

  if Text <> 'about:blank' then
    lblTitle.Visible := True;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlBtnExitClick(Sender: TObject);
begin
  close;
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
