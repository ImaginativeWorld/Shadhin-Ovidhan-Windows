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
    pnlDown: TPanel;
    imgIWlogo: TImage;
    WB1: TWebBrowser;
    ApplicationEvents: TApplicationEvents;
    lblAddress: TLabel;
    pnlBtnExit: TPanel;
    pnlBtnHome: TPanel;
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
    procedure pnlBtnHomeClick(Sender: TObject);
    procedure WB1DocumentComplete(ASender: TObject; const pDisp: IDispatch;
      var URL: OleVariant);
    procedure WB1NavigateComplete2(ASender: TObject; const pDisp: IDispatch;
      var URL: OleVariant);
    procedure imgIWlogoClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }

  end;

const
  strHTMLStartThings: string = //
    '<html><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />'
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
  strGTurl, strGTurl2, strGTurl3: string;

implementation

{$R *.dfm}

uses
  uFunctions,
  uTextStrings;

procedure TfrmMain.FormCreate(Sender: TObject);
begin

  { Set Application Default Dir }
  AppDir := ExtractFilePath(Forms.Application.ExeName);

  strErrHTML := //
    strHTMLStartThings + //
    '<br><br><br><br>' + //
    strProgramDes + //
    '<br><br><br><br>' + //
    '<span style="font-size:250%;">' + //
    '<p style="text-align: center;">' +
    'কোন ইন্টারনেট সংযোগ উপলভ্য নয়!</p></span>' + //
    strHTMLEndThings;

  strGTurl := 'https://translate.google.com';
  strGTurl2 := strGTurl + '/#en/bn/';
  strGTurl3 := 'javascript:';

  // WB1.Navigate(Pchar('https://translate.google.com/#en/bn/'));

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlBtnHomeClick(Sender: TObject);
begin

  if IsConnected then
    WB1.Navigate(Pchar(strGTurl2))
  else
  begin
    WB_LoadHTML(WB1, strErrHTML);
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.FormShow(Sender: TObject);
begin

  { Browser }
  if IsConnected then
  begin

    WB_LoadHTML(WB1, //
      strHTMLStartThings + //
        '<br><br><br><br>' + //
        strProgramDes + //
        '<br><br><br><br><br>' + //
        '<span style="font-size:250%;">' + //
        '<p style="text-align: center;">' +
        'গুগল ট্রান্সলেট লোড হচ্ছে...<br>অপেক্ষা করুন...</p></span>' +
        strHTMLEndThings);

    WB1.Navigate(Pchar(strGTurl2));

  end
  else
  begin

    WB_LoadHTML(WB1, strErrHTML);

  end;

  Forms.Application.BringToFront;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin

//  { Browser: Disable Popup menu }
//  if (Msg.Message = WM_RBUTTONDOWN) or (Msg.Message = WM_RBUTTONDBLCLK) then
//  begin
//    if IsChild(WB1.Handle, Msg.hwnd) then
//    begin
//      // Show your own Popupor or whatever you want here
//      Handled := True;
//    end;
//  end;

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

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin

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
begin

  if (copy(URL, 0, length(strGTurl)) <> strGTurl) and //
    (copy(URL, 0, length(strBlankUrl)) <> strBlankUrl) and //
    (copy(URL, 0, length(strGTurl3)) <> strGTurl3) then
  begin
    Cancel := True;

    if IsConnected then
      WB1.Navigate(Pchar(strGTurl2))
    else
    begin
      WB_LoadHTML(WB1, strErrHTML);
    end;

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.WB1StatusTextChange(ASender: TObject;
  const Text: WideString);
begin

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.WB1TitleChange(ASender: TObject; const Text: WideString);
begin

//  if Text = 'about:blank' then
//    self.Caption := 'Shadhin Ovidhan | Google Translate'
//  else
//    self.Caption := 'Shadhin Ovidhan | Google Translate | ' + Text;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.WB1DocumentComplete(ASender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
// var
// strUrl: string;
begin

  // strurl := 'https://translate.google.com';
  //
  // if copy(URL, 0, length(strUrl)) <> strUrl then
  // begin
  //
  // WB1.Navigate(Pchar('https://translate.google.com/#en/bn/'));
  // showmessage('hi');
  //
  // end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.WB1NavigateComplete2(ASender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin

  if URL = strBlankUrl then
  begin
    if IsConnected then
      lblAddress.Caption := 'Loading...'
    else
      lblAddress.Caption := 'No Internet Connection Available!';
  end
  else
  begin
    if Canvas.TextWidth(URL) > 490 then
      lblAddress.Caption := 'URL: ' + copy(URL, 0, 40) + '...'
    else
      lblAddress.Caption := 'URL: ' + URL;
  end;

end;

{ ****************************** N E W    P A R T ****************************** }
{$REGION '          Panel Appreance         '}

procedure TfrmMain.pnlBtnMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin (Sender as TPanel)
  .Color := clGray; //
(Sender as TPanel)
  .Font.Color := clWhite;
end;

procedure TfrmMain.pnlBtnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin (Sender as TPanel)
  .Color := clBlack; //
(Sender as TPanel)
  .Font.Color := clWhite;
end;

procedure TfrmMain.pnlBtnMouseEnter(Sender: TObject);
begin (Sender as TPanel)
  .Color := clGray; //
(Sender as TPanel)
  .Font.Color := clWhite;
end;

procedure TfrmMain.pnlBtnMouseLeave(Sender: TObject);
begin (Sender as TPanel)
  .Color := clWhite; // $00F0F0F0; //
(Sender as TPanel)
  .Font.Color := clBlack;
end;
{$ENDREGION}
{ ****************************** N E W    P A R T ****************************** }

end.
