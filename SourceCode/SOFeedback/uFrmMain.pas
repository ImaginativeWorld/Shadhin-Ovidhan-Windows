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
  Dialogs, ExtCtrls, pngimage, StdCtrls, OleCtrls, SHDocVw, AppEvnts;

type
  TfrmMain = class(TForm)
    pnlDown: TPanel;
    pnlBtnExit: TPanel;
    imgIWlogo: TImage;
    pnlTop: TPanel;
    lblHeader: TLabel;
    WB1: TWebBrowser;
    ApplicationEvents: TApplicationEvents;
    pnlBtnHome: TPanel;
    procedure pnlBtnExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pnlBtnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlBtnMouseEnter(Sender: TObject);
    procedure pnlBtnMouseLeave(Sender: TObject);
    procedure pnlBtnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlTopMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure WB1BeforeNavigate2(ASender: TObject; const pDisp: IDispatch;
      var URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
      var Cancel: WordBool);
    procedure imgIWlogoClick(Sender: TObject);
    procedure pnlBtnHomeClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }

  protected
    procedure CreateParams(var Params: TCreateParams); override;

  end;

const
  strHTMLStartThings: string = //
    '<!DOCTYPE html><html><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />'
    + '</head><body>';

  strHTMLEndThings: string = //
    '</body></html>';

  strProgramDes: string = //
    '<span style="font-size:200%;">' + //
    '<p style="text-align: center;">স্বাধীন অভিধান</p></span>' +
    '<br><span style="font-size:100%;">' + //
    '<p style="text-align: center;">সংস্করণ ' + '2x' + '</p></span>';

  strBlankUrl: string = 'about:blank';

var
  frmMain: TfrmMain;

  { Variable But Const }
  strErrHTML: string;
  strMainURL: string;

implementation

{$R *.dfm}

uses
  uUrlCheck,
  uFunctions,
  uTextStrings;

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

  FreeAndNil(UrlUpdater);

  Action := caFree;

  frmMain := Nil;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.FormCreate(Sender: TObject);
// var
// { Shaped Form }
// ShapeBG: HRGN;
begin
  { Set Application Default Dir }
  // appdir := ExtractFilePath(Application.ExeName);

  { Shaped Form }
  // ShapeBG := CreateRoundRectRgn(0, 0, 600, 515, 11, 11);
  // // ( Left, Top, Width, Height, Circle -, Circle | )
  // SetWindowRgn(Handle, ShapeBG, True);
  // DeleteObject(ShapeBG);

  strErrHTML := //
    strHTMLStartThings + //
    '<br><br><br><br>' + //
    strProgramDes + //
    '<br><br><br><br>' + //
    '<span style="font-size:250%;">' + //
    '<p style="text-align: center;">' +
    'কোন ইন্টারনেট সংযোগ উপলভ্য নয়!</p></span>' + //
    strHTMLEndThings;

  { Start Url Update }
  if UrlUpdater.IsConnected then
  begin

    UrlUpdater := TUrlCheck.Create;
    UrlUpdater.Check;

    WB_LoadHTML(WB1, //
      strHTMLStartThings + //
        '<br><br><br><br>' + //
        strProgramDes + //
        '<br><br><br><br>' + //
        '<span style="font-size:200%;">' + //
        '<p style="text-align: center;">' +
        'স্বাধীন অভিধান ফিডব্যাক লোড হচ্ছে...<br>অপেক্ষা করুন...</p></span>' +
        strHTMLEndThings);

  end
  else
  begin

    WB_LoadHTML(WB1, strErrHTML);

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.FormShow(Sender: TObject);
begin

  Forms.Application.BringToFront;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.imgIWlogoClick(Sender: TObject);
begin
  Open_URL(strLogoURL);
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlBtnExitClick(Sender: TObject);
begin

  close;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlBtnHomeClick(Sender: TObject);
begin

  // WB1.Navigate(Pchar(strMainURL));

  if UrlUpdater.IsConnected then
    WB1.Navigate(Pchar(strMainURL))
  else
  begin
    WB_LoadHTML(WB1, strErrHTML);
  end;

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

procedure TfrmMain.WB1BeforeNavigate2(ASender: TObject; const pDisp: IDispatch;
  var URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
  var Cancel: WordBool);
begin

  if (copy(URL, (pos('/', URL) + 2), length(strMainURL)) <> strMainURL) and //
    (copy(URL, (pos('/', URL) + 2), length(strBlankUrl)) <> strBlankUrl) then
  begin

    Cancel := True;

    if UrlUpdater.IsConnected then
      WB1.Navigate(Pchar(strMainURL))
    else
    begin
      WB_LoadHTML(WB1, strErrHTML);
    end;

  end;
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
