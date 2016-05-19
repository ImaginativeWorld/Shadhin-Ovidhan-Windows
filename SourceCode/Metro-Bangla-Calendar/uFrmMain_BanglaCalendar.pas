/// <aboutDev>
///
/// Project:
///     Metro Bangla Calendar (for Shadhin Ovidhan)
///
/// Documentation:
///     Md. Mahmudul Hasan Shohag
///     Founder, CEO of Imaginative World
///     http://shohag.imaginativeworld.org
///
/// Lisence:
///     Opensource project lisense under MPL 2.0.
///     Copyright © Imaginative World. All rights researved.
///     http://imaginativeworld.org
///
/// **************************************************
///     This Source Code Form is subject to the
///     terms of the Mozilla Public License, v.
///     2.0. If a copy of the MPL was not
///     distributed with this file, You can obtain
///     one at http://mozilla.org/MPL/2.0/.
/// **************************************************
///
/// </aboutDev>

unit uFrmMain_BanglaCalendar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Menus, ComCtrls, DateUtils, StrUtils, uRegistry;

type
  TfrmMain = class(TForm)
    lblDay: TLabel;
    lblMonth: TLabel;
    lblYear: TLabel;
    pMenuMain: TPopupMenu;
    miTheme: TMenuItem;
    N1: TMenuItem;
    miAbout: TMenuItem;
    miExit: TMenuItem;
    Gray: TMenuItem;
    Black1: TMenuItem;
    miGreen: TMenuItem;
    miBlue: TMenuItem;
    miSilver: TMenuItem;
    miYellow: TMenuItem;
    miSkyBlue: TMenuItem;
    miLightGreen: TMenuItem;
    miPurple: TMenuItem;
    miLightPurple: TMenuItem;
    miTeal: TMenuItem;
    miLightTeal: TMenuItem;
    miLightSkyBlue: TMenuItem;
    miRed: TMenuItem;
    Maroon1: TMenuItem;
    Love1: TMenuItem;
    miRed2: TMenuItem;
    miRed3: TMenuItem;
    miRed4: TMenuItem;
    N2: TMenuItem;
    miLockGadget: TMenuItem;
    miAutoStart: TMenuItem;
    tmrUpdate: TTimer;
    tmrDate: TTimer;
    tmrStartEffect: TTimer;
    miAlphaBlind: TMenuItem;
    mi100: TMenuItem;
    mi90: TMenuItem;
    mi80: TMenuItem;
    mi70: TMenuItem;
    mi60: TMenuItem;
    mi50: TMenuItem;
    mi40: TMenuItem;
    mi30: TMenuItem;
    mi20: TMenuItem;
    mi10: TMenuItem;
    spBG: TShape;
    miDefault: TMenuItem;
    miRandom: TMenuItem;
    N3: TMenuItem;
    miUserDefine: TMenuItem;
    ColorDialog: TColorDialog;
    miWhite: TMenuItem;
    miFont: TMenuItem;
    miKalpurush: TMenuItem;
    miNirmalaUI: TMenuItem;
    miSiyamRupali: TMenuItem;
    mnuIW: TMenuItem;
    hisProductcomeswith1: TMenuItem;
    ShadhinOvidhan1: TMenuItem;
    N4: TMenuItem;
    Calendarmaintainruleof1: TMenuItem;
    Bangladesh1: TMenuItem;
    Info1: TMenuItem;
    tmrColor: TTimer;
    miRongdhonu: TMenuItem;
    N5: TMenuItem;
    miRongdhonuSpeed: TMenuItem;
    miSlow: TMenuItem;
    miNormal: TMenuItem;
    miFast: TMenuItem;

    procedure ChangeTheme(const ThemeName: string);
    procedure ChangeFont(const FontName: string);
    procedure ChangeColor;
    procedure ChangeRainbowSpeed(const Speed: string);

    procedure SetComponents;
    function GetThemeName(const ThemeNumber: integer): string;

    procedure miExitClick(Sender: TObject);
    procedure miAboutClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure FormShow(Sender: TObject);
    procedure ThemeMiClick(Sender: TObject);
    procedure miLockGadgetClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure miAutoStartClick(Sender: TObject);
    procedure tmrDateTimer(Sender: TObject);
    procedure tmrUpdateTimer(Sender: TObject);
    procedure tmrStartEffectTimer(Sender: TObject);
    procedure miTransparent(Sender: TObject);
    procedure miUserDefineClick(Sender: TObject);
    procedure ColorDialogShow(Sender: TObject);
    procedure miDefaultFonts(Sender: TObject);
    procedure miRongdhonuClick(Sender: TObject);
    procedure tmrColorTimer(Sender: TObject);
    procedure miSpeedsClick(Sender: TObject);
    procedure mnuIWClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }

  end;

const
  TotalColor: integer = 21;

var
  frmMain: TfrmMain;

  MCalendar: TMonthCalendar;

  ColorDlgCaption: string;

  intR, intG, intB: integer;
  eventNumber: integer;

implementation

{$R *.dfm}

uses
  uBanglaCalendar,
  uFunctions,
  uTextStrings;

procedure TfrmMain.FormCreate(Sender: TObject);
begin

  { Application Dir }
  AppDir := ExtractFilePath(Application.ExeName);

  { Settings }
  GetSettings;
  SetComponents;

  { Calendar }
  MCalendar := TMonthCalendar.Create(self);
  MCalendar.Date := DateOf(Now);
  BanglaDate(MCalendar);
  lblDay.caption := BnDay;
  lblMonth.caption := BnMonth;
  lblYear.caption := BnYear;
  FreeAndNil(MCalendar);

  { Set Color }
  intR := 0;
  intG := 0;
  intB := 0;
  eventNumber := 0;

end;

procedure TfrmMain.SetComponents;
var
  TempThemeName: string;
begin

  { Theme }
  if confThemeName = 'Random' then
  begin
    Randomize;
    TempThemeName := GetThemeName(Random(TotalColor));

  end
  else
    TempThemeName := confThemeName;

  ChangeTheme(TempThemeName);

  ChangeFont(confGadgetFont);

  { Location }
  if confGadgetY > screen.WorkAreaHeight - 5 then
  begin
    self.Top := 0;
    confGadgetY := self.Top;
  end
  else
  begin
    self.Top := confGadgetY;
  end;

  if confGadgetX > screen.WorkAreaWidth - 5 then
  begin
    self.Left := 0;
    confGadgetY := self.Top;
  end
  else
  begin
    self.Left := confGadgetX;
  end;

  { Menu Items }
  miLockGadget.Checked := confGadgetLock;
  miAutoStart.Checked := confAutoStart;

  miTheme.Find(confThemeName).Checked := True;
  miFont.Find(confGadgetFont).Checked := True;
  miRongdhonuSpeed.Find(confGadgetRnbSpeed).Checked := True;

  miAlphaBlind.Find(inttostr(confTransparent) + '%').Checked := True;
  miAlphaBlind.caption := 'Transparent [ ' + inttostr(confTransparent) + '% ]';

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  Action := caFree;

  frmMain := nil;

end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

  SetSettings;

  Application.Terminate;

  CanClose := True;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if confGadgetLock = false then
  begin

    if Button = mbLeft then
    begin
      ReleaseCapture;
      TForm(frmMain).Perform(WM_SYSCOMMAND, $F012, 0);
    end;

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.FormShow(Sender: TObject);
var
  Owner: HWnd;
begin
  { Hide from Taskbar }
  Owner := GetWindow(Handle, GW_OWNER);
  ShowWindow(Owner, SW_HIDE);

  { Startup Effect }
  tmrStartEffect.Enabled := True;

end;

{ ****************************** N E W    P A R T ****************************** }

// Procedure TfrmMain.CreateParams(Var Params: TCreateParams);
// Begin
// Inherited CreateParams(Params);
// // Params.ExStyle := Params.ExStyle Or WS_EX_TOPMOST;
// // Params.ExStyle := Params.ExStyle Or WS_EX_APPWINDOW;
// Params.ExStyle := Params.ExStyle Or WS_EX_TOOLWINDOW And Not WS_EX_APPWINDOW;
// Params.WndParent := GetDesktopwindow;
// End;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.miTransparent(Sender: TObject);
begin
  //
  with (Sender as TMenuItem) do
  begin
    if name = 'mi10' then
    begin

      self.AlphaBlendValue := 255 * 10 div 100;
      confTransparent := 10;

    end
    else if name = 'mi20' then
    begin

      self.AlphaBlendValue := 255 * 20 div 100;
      confTransparent := 20;

    end
    else if name = 'mi30' then
    begin

      self.AlphaBlendValue := 255 * 30 div 100;
      confTransparent := 30;

    end
    else if name = 'mi40' then
    begin

      self.AlphaBlendValue := 255 * 40 div 100;
      confTransparent := 40;

    end
    else if name = 'mi50' then
    begin

      self.AlphaBlendValue := 255 * 50 div 100;
      confTransparent := 50;

    end
    else if name = 'mi60' then
    begin

      self.AlphaBlendValue := 255 * 60 div 100;
      confTransparent := 60;

    end
    else if name = 'mi70' then
    begin

      self.AlphaBlendValue := 255 * 70 div 100;
      confTransparent := 70;

    end
    else if name = 'mi80' then
    begin

      self.AlphaBlendValue := 255 * 80 div 100;
      confTransparent := 80;

    end
    else if name = 'mi90' then
    begin

      self.AlphaBlendValue := 255 * 90 div 100;
      confTransparent := 90;

    end
    else if name = 'mi100' then
    begin

      self.AlphaBlendValue := 255 * 100 div 100;
      confTransparent := 100;

    end;
  end;

  miAlphaBlind.Find(inttostr(confTransparent) + '%').Checked := True;
  miAlphaBlind.caption := 'Transparent [ ' + inttostr(confTransparent) + '% ]';

  TrimAppMemorySize;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.miAboutClick(Sender: TObject);
begin

  if FileExists(AppDir + 'SOCommon.exe') then
  begin
    Execute_Something(AppDir + 'SOCommon.exe', '-about');
  end
  else
  begin
      Application.MessageBox //
    (Pchar(strAboutText), //
      Pchar(Forms.Application.Title),
      MB_OK + MB_ICONINFORMATION + MB_DEFBUTTON1 + MB_APPLMODAL);
  end;

  TrimAppMemorySize;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.miAutoStartClick(Sender: TObject);
var
  Reg: TMyRegistry;
begin
  Reg := TMyRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;

  if miAutoStart.Checked then
    miAutoStart.Checked := false
  else
    miAutoStart.Checked := True;

  confAutoStart := miAutoStart.Checked;

  if Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', True)
    = True then
  begin

    if confAutoStart then
    begin
      if Reg.ValueExists('Matro Bangla Calendar') = False then
        Reg.WriteString('Matro Bangla Calendar',
          AppDir + 'SOBanglaCalendar.exe');
    end
    else
    begin
      if Reg.ValueExists('Matro Bangla Calendar') then
        Reg.DeleteValue('Matro Bangla Calendar');
    end;

  end;

  Reg.Free;

  TrimAppMemorySize;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.miExitClick(Sender: TObject);
begin
  close;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.miSpeedsClick(Sender: TObject);
var
  TmpName: string;
begin

  with (Sender as TMenuItem) do
  begin

    TmpName := ReplaceText(caption, '&', '');

    confGadgetRnbSpeed := 'Normal';

    ChangeRainbowSpeed(TmpName);

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.ChangeRainbowSpeed(const Speed: string);
begin

  if Speed = 'Slow' then
  begin
    tmrColor.Interval := (60 * (60 * 3) * 1000) div 2040; // 3 Hour
  end
  else if Speed = 'Normal' then
  begin
    tmrColor.Interval := (60 * 60 * 1000) div 2040; // 1765milisec = 1 Hour
  end
  else if Speed = 'Fast' then
  begin
    tmrColor.Interval := 1;
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.tmrDateTimer(Sender: TObject);
var
  liInfo: TLastInputInfo;
  SecondsIdle: DWord;
begin

  { Calendar }
  MCalendar := TMonthCalendar.Create(self);
  MCalendar.Date := DateOf(Now);
  BanglaDate(MCalendar);
  lblDay.caption := BnDay;
  lblMonth.caption := BnMonth;
  lblYear.caption := BnYear;
  FreeAndNil(MCalendar);

  { Trim Memory }
  liInfo.cbSize := SizeOf(TLastInputInfo);
  GetLastInputInfo(liInfo);
  SecondsIdle := (GetTickCount - liInfo.dwTime) div 1000;
  if SecondsIdle > 60 then
    TrimAppMemorySize;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.tmrStartEffectTimer(Sender: TObject);
begin
  if frmMain.AlphaBlendValue<((255 * confTransparent div 100) - 5) then
  begin
    frmMain.AlphaBlendValue := frmMain.AlphaBlendValue + 5;
  end
  else
  begin
    frmMain.AlphaBlendValue := (255 * confTransparent div 100);
    tmrStartEffect.Enabled := false;

    tmrDate.Enabled := True;

    TrimAppMemorySize;

  end;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.tmrUpdateTimer(Sender: TObject);
begin

  if IsConnected then
  begin

    tmrUpdate.Enabled := false;

    Execute_Something(AppDir + 'SOCommon.exe');

    TrimAppMemorySize;

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.miDefaultFonts(Sender: TObject);
var
  tmpCaption: string;
begin

  with (Sender as TMenuItem) do
  begin
    tmpCaption := ReplaceText(caption, '&', '');

    if screen.Fonts.IndexOf(tmpCaption) <> -1 then
    begin

      confGadgetFont := tmpCaption;
      ChangeFont(confGadgetFont);
      Checked := True;

    end
    else
    begin

      Forms.Application.MessageBox
        (PChar(strBnCalFontNotFound + #10 + #10 + strIfItBug + #10 +
        strIWEmail), 'SO - Matro Bangla Calendar | Info',
        MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);

    end;

  end;

  TrimAppMemorySize;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.ChangeFont(const FontName: string);
begin

  lblDay.Font.Name := FontName;
  lblMonth.Font.Name := FontName;
  lblYear.Font.Name := FontName;

  miFont.caption := 'Font [ ' + FontName + ' ]';

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.ThemeMiClick(Sender: TObject);
var
  TempThemeName: string;
  tmpCaption: string;
begin
  { Stop Timer }
  tmrColor.Enabled := false;

  with (Sender as TMenuItem) do
  begin
    tmpCaption := ReplaceText(caption, '&', '');
    if tmpCaption = 'Random' then
    begin
      Randomize;
      TempThemeName := GetThemeName(Random(TotalColor));
      confThemeName := 'Random';
      Checked := True;
    end
    else
    begin
      TempThemeName := tmpCaption;
      confThemeName := TempThemeName;
    end;
  end;

  ChangeTheme(TempThemeName);

  TrimAppMemorySize;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.miUserDefineClick(Sender: TObject);
begin

  ColorDialog.color := confGadgetColor;

  ColorDlgCaption := 'Matro Bangla Calendar: Choose Background Color';

  if ColorDialog.Execute() then
  begin

    confGadgetColor := ColorDialog.color;

    ColorDialog.color := confGadgetFontColor;

    ColorDlgCaption := 'Matro Bangla Calendar: Choose Text Color';

    if ColorDialog.Execute() then
    begin

      { Stop Timer }
      tmrColor.Enabled := false;

      confGadgetFontColor := ColorDialog.color;

      confThemeName := 'User Defined';

      ChangeTheme(confThemeName);

      (Sender as TMenuItem)
        .Checked := True;

    end;

  end;

end;

procedure TfrmMain.mnuIWClick(Sender: TObject);
begin

  Open_URL(strLogoURL);

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.ColorDialogShow(Sender: TObject);
begin

  with Sender as TColorDialog do
    SendMessage(Handle, WM_SETTEXT, 0, Longint(PChar(ColorDlgCaption)));

end;

{ ****************************** N E W    P A R T ****************************** }

function TfrmMain.GetThemeName(const ThemeNumber: integer): string;
begin
  result := 'Default';

  case ThemeNumber of
    0:
      begin
        result := 'Default';
      end;
    1:
      begin
        result := 'User Defined';
      end;
    2:
      begin
        result := 'Silver';
      end;
    3:
      begin
        result := 'Gray';
      end;
    4:
      begin
        result := 'Black';
      end;
    5:
      begin
        result := 'Green';
      end;
    6:
      begin
        result := 'Light Green';
      end;
    7:
      begin
        result := 'Blue';
      end;
    8:
      begin
        result := 'Sky Blue';
      end;
    9:
      begin
        result := 'Light Sky Blue';
      end;
    10:
      begin
        result := 'Yellow';
      end;
    11:
      begin
        result := 'Purple';
      end;
    12:
      begin
        result := 'Light Purple';
      end;
    13:
      begin
        result := 'Teal';
      end;
    14:
      begin
        result := 'Light Teal';
      end;
    15:
      begin
        result := 'Red';
      end;
    16:
      begin
        result := 'Red 2';
      end;
    17:
      begin
        result := 'Red 3';
      end;
    18:
      begin
        result := 'Red 4';
      end;
    19:
      begin
        result := 'Maroon';
      end;
    20:
      begin
        result := 'Love';
      end;
    21:
      begin
        result := 'White';
      end;

  end;

  {
    ATTENTION!:
    Change Random Constent
    }

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.ChangeTheme(const ThemeName: string);
var
  RealThemeName: string;
begin

  RealThemeName := ReplaceText(ThemeName, '&', '');

  if RealThemeName = 'Default' then
  begin
    lblMonth.color := clWhite;
    spBG.Brush.color := lblMonth.color;
    lblDay.color := $00DEDEDE;
    lblYear.color := lblDay.color;
    lblDay.Font.color := clBlack;
    lblYear.Font.color := lblDay.Font.color;
    // lblMonth.Font.color := clBlack;
  end
  else if RealThemeName = 'User Defined' then
  begin
    lblMonth.color := clWhite;
    spBG.Brush.color := lblMonth.color;
    lblDay.color := confGadgetColor;
    lblYear.color := lblDay.color;
    lblDay.Font.color := confGadgetFontColor;
    lblYear.Font.color := lblDay.Font.color;
    // lblMonth.Font.Color := clBlack;
  end
  else if RealThemeName = 'Rongdhonu' then
  begin

    lblDay.color := clBlack;
    lblYear.color := lblDay.color;
    lblDay.Font.color := clWhite;
    lblYear.Font.color := lblDay.Font.color;

    ChangeRainbowSpeed(confGadgetRnbSpeed);

    tmrColor.Enabled := True;
    // lblMonth.Font.Color := clBlack;
  end
  else if RealThemeName = 'White' then
  begin
    lblMonth.color := clWhite;
    spBG.Brush.color := lblMonth.color;
    lblDay.color := clWhite;
    lblYear.color := lblDay.color;
    lblDay.Font.color := clBlack;
    lblYear.Font.color := lblDay.Font.color;
    // lblMonth.Font.Color := clBlack;
  end
  else if RealThemeName = 'Silver' then
  begin
    lblMonth.color := clWhite; // $00F4F4F4; [Not Full White]
    spBG.Brush.color := lblMonth.color;
    lblDay.color := clSilver;
    lblYear.color := lblDay.color;
    lblDay.Font.color := clBlack;
    lblYear.Font.color := lblDay.Font.color;
    // lblMonth.Font.Color := clBlack;
  end
  else if RealThemeName = 'Gray' then
  begin
    lblMonth.color := clWhite;
    spBG.Brush.color := lblMonth.color;
    lblDay.color := clGray;
    lblYear.color := lblDay.color;
    lblDay.Font.color := clWhite;
    lblYear.Font.color := lblDay.Font.color;
    // lblMonth.Font.Color := clBlack;
  end
  else if RealThemeName = 'Black' then
  begin
    lblMonth.color := clWhite; // clGray;
    spBG.Brush.color := lblMonth.color;
    lblDay.color := clBlack;
    lblYear.color := lblDay.color;
    lblDay.Font.color := clWhite;
    lblYear.Font.color := lblDay.Font.color;
    // lblMonth.Font.Color := clBlack; // clWhite;
  end
  else if RealThemeName = 'Green' then
  begin
    lblMonth.color := clWhite;
    spBG.Brush.color := lblMonth.color;
    lblDay.color := $0000B676; // Green
    lblYear.color := lblDay.color;
    lblDay.Font.color := clWhite;
    lblYear.Font.color := lblDay.Font.color;
    // lblMonth.Font.Color := clBlack;
  end
  else if RealThemeName = 'Light Green' then
  begin
    lblMonth.color := clWhite;
    spBG.Brush.color := lblMonth.color;
    lblDay.color := $0000D191; // Light Green
    lblYear.color := lblDay.color;
    lblDay.Font.color := clWhite;
    lblYear.Font.color := lblDay.Font.color;
    // lblMonth.Font.Color := clBlack;
  end
  else if RealThemeName = 'Blue' then
  begin
    lblMonth.color := clWhite;
    spBG.Brush.color := lblMonth.color;
    lblDay.color := $00EC7326; // Blue
    lblYear.color := lblDay.color;
    lblDay.Font.color := clWhite;
    lblYear.Font.color := lblDay.Font.color;
    // lblMonth.Font.Color := clBlack;
  end
  else if RealThemeName = 'Sky Blue' then
  begin
    lblMonth.color := clWhite;
    spBG.Brush.color := lblMonth.color;
    lblDay.color := $00FFAE1F; // Sky Blue
    lblYear.color := lblDay.color;
    lblDay.Font.color := clWhite;
    lblYear.Font.color := lblDay.Font.color;
    // lblMonth.Font.Color := clBlack;
  end
  else if RealThemeName = 'Light Sky Blue' then
  begin
    lblMonth.color := clWhite;
    spBG.Brush.color := lblMonth.color;
    lblDay.color := $00FFC556; // Light Sky Blue
    lblYear.color := lblDay.color;
    lblDay.Font.color := clWhite;
    lblYear.Font.color := lblDay.Font.color;
    // lblMonth.Font.Color := clBlack;
  end
  else if RealThemeName = 'Yellow' then
  begin
    lblMonth.color := clWhite;
    spBG.Brush.color := lblMonth.color;
    lblDay.color := $0000B3F4; // Yellow
    lblYear.color := lblDay.color;
    lblDay.Font.color := clWhite;
    lblYear.Font.color := lblDay.Font.color;
    // lblMonth.Font.Color := clBlack;
  end
  else if RealThemeName = 'Purple' then
  begin
    lblMonth.color := clWhite;
    spBG.Brush.color := lblMonth.color;
    lblDay.color := $00AC0072; // Purple
    lblYear.color := lblDay.color;
    lblDay.Font.color := clWhite;
    lblYear.Font.color := lblDay.Font.color;
    // lblMonth.Font.Color := clBlack;
  end
  else if RealThemeName = 'Light Purple' then
  begin
    lblMonth.color := clWhite;
    ;
    spBG.Brush.color := lblMonth.color;
    lblDay.color := $00FF40AA; // Light Purple
    lblYear.color := lblDay.color;
    lblDay.Font.color := clWhite;
    lblYear.Font.color := lblDay.Font.color;
    // lblMonth.Font.Color := clBlack;
  end
  else if RealThemeName = 'Teal' then
  begin
    lblMonth.color := clWhite;
    spBG.Brush.color := lblMonth.color;
    lblDay.color := $00878200; // Teal
    lblYear.color := lblDay.color;
    lblDay.Font.color := clWhite;
    lblYear.Font.color := lblDay.Font.color;
    // lblMonth.Font.Color := clBlack;
  end
  else if RealThemeName = 'Light Teal' then
  begin
    lblMonth.color := clWhite;
    spBG.Brush.color := lblMonth.color;
    lblDay.color := $00A4A400; // Light Teal
    lblYear.color := lblDay.color;
    lblDay.Font.color := clWhite;
    lblYear.Font.color := lblDay.Font.color;
    // lblMonth.Font.Color := clBlack;
  end
  else if RealThemeName = 'Red' then
  begin
    lblMonth.color := clWhite;
    spBG.Brush.color := lblMonth.color;
    lblDay.color := $00122EFF; // Red
    lblYear.color := lblDay.color;
    lblDay.Font.color := clWhite;
    lblYear.Font.color := lblDay.Font.color;
    // lblMonth.Font.Color := clBlack;
  end
  else if RealThemeName = 'Red 2' then
  begin
    lblMonth.color := clWhite;
    spBG.Brush.color := lblMonth.color;
    lblDay.color := $003D11AE; // Red 2
    lblYear.color := lblDay.color;
    lblDay.Font.color := clWhite;
    lblYear.Font.color := lblDay.Font.color;
    // lblMonth.Font.Color := clBlack;
  end
  else if RealThemeName = 'Red 3' then
  begin
    lblMonth.color := clWhite;
    spBG.Brush.color := lblMonth.color;
    lblDay.color := $004F00C1; // Red 3
    lblYear.color := lblDay.color;
    lblDay.Font.color := clWhite;
    lblYear.Font.color := lblDay.Font.color;
    // lblMonth.Font.Color := clBlack;
  end
  else if RealThemeName = 'Red 4' then
  begin
    lblMonth.color := clWhite;
    spBG.Brush.color := lblMonth.color;
    lblDay.color := $00771DFF; // Red 4
    lblYear.color := lblDay.color;
    lblDay.Font.color := clWhite;
    lblYear.Font.color := lblDay.Font.color;
    // lblMonth.Font.Color := clBlack;
  end
  else if RealThemeName = 'Maroon' then
  begin
    lblMonth.color := clWhite;
    spBG.Brush.color := lblMonth.color;
    lblDay.color := $00001EB0; // Maroon
    lblYear.color := lblDay.color;
    lblDay.Font.color := clWhite;
    lblYear.Font.color := lblDay.Font.color;
    // lblMonth.Font.Color := clBlack;
  end
  else if RealThemeName = 'Love' then
  begin
    lblMonth.color := clWhite;
    spBG.Brush.color := lblMonth.color;
    lblDay.color := $00BC76FF; // Love
    lblYear.color := lblDay.color;
    lblDay.Font.color := clWhite;
    lblYear.Font.color := lblDay.Font.color;
    // lblMonth.Font.Color := clBlack;
  end;

  if confThemeName = 'Random' then
    miTheme.caption := 'Theme [ Random: ' + RealThemeName + ' ]'
  else
    miTheme.caption := 'Theme [ ' + RealThemeName + ' ]';

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.miLockGadgetClick(Sender: TObject);
begin
  if miLockGadget.Checked then
  begin

    miLockGadget.Checked := false;

  end
  else
  begin

    miLockGadget.Checked := True;

  end;

  confGadgetLock := miLockGadget.Checked;

  TrimAppMemorySize;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.miRongdhonuClick(Sender: TObject);
begin

  lblDay.color := clBlack;
  lblYear.color := lblDay.color;
  lblDay.Font.color := clWhite;
  lblYear.Font.color := lblDay.Font.color;

  tmrColor.Enabled := True;

  confThemeName := 'Rongdhonu';

  miTheme.caption := 'Theme [ ' + confThemeName + ' ]';
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.tmrColorTimer(Sender: TObject);
begin
  ChangeColor;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.ChangeColor;
begin
  {
    0. R : 0 - 255
    1. G : 0 - 255
    2. R : 255 - 0
    3. B : 0 - 255
    4. G : 255 - 0
    5. R : 0 - 255
    6. B : 255 - 0
    }

  { Set Color }
  case eventNumber of
    0: { 0. R : 0 - 255 [Red] }
      begin

        if intR < 255 then
        begin
          intR := intR + 1;
        end
        else
        begin
          eventNumber := 1;
        end;

      end;
    1: { 1. G : 0 - 255 [Yellow] }
      begin

        if intG < 255 then
        begin
          intG := intG + 1;
          if intG > 150 then
          begin
            // pnlColor.Font.color := clBlack;
            lblDay.Font.color := clBlack;
            lblYear.Font.color := lblDay.Font.color;
          end;
        end
        else
        begin
          eventNumber := 2;
        end;

      end;
    2: { 2. R : 255 - 0 [Green] }
      begin

        if intR > 0 then
        begin
          intR := intR - 1;
        end
        else
        begin
          eventNumber := 3;
        end;

      end;

    3: { 3. B : 0 - 255 }
      begin

        if intB < 255 then
        begin
          intB := intB + 1;
        end
        else
        begin
          eventNumber := 4;
        end;

      end;
    4: { 4. G : 255 - 0 }
      begin

        if intG > 0 then
        begin
          intG := intG - 1;
          if intG < 200 then
          begin
            // pnlColor.Font.color := clWhite;
            lblDay.Font.color := clWhite;
            lblYear.Font.color := lblDay.Font.color;
          end;
        end
        else
        begin
          eventNumber := 5;
        end;

      end;
    5: { 5. R : 0 - 255 }
      begin

        if intR < 255 then
        begin
          intR := intR + 1;
        end
        else
        begin
          eventNumber := 6;
        end;

      end;
    6: { 6. B : 255 - 0 }
      begin

        if intB > 0 then
        begin
          intB := intB - 1;
        end
        else
        begin
          eventNumber := 7;
        end;

      end;
    7: { 7. B & G : 0 - 255 [White] }
      begin

        if intB < 255 then
        begin
          intG := intG + 1;
          intB := intB + 1;

          if intB > 150 then
          begin
            // pnlColor.Font.color := clBlack;
            lblDay.Font.color := clBlack;
            lblYear.Font.color := lblDay.Font.color;
          end;
        end
        else
        begin
          eventNumber := 8;
        end;

      end;
    8: { 8. R & G & B : 255 - 0 [Black] }
      begin

        if intR > 0 then
        begin
          intR := intR - 1;
          intG := intG - 1;
          intB := intB - 1;
          if intR < 150 then
          begin
            // pnlColor.Font.color := clWhite;
            lblDay.Font.color := clWhite;
            lblYear.Font.color := lblDay.Font.color;
          end;
        end
        else
        begin
          eventNumber := 0;
        end;

      end;
  end;

  // pnlColor.color := RGB(intR, intG, intB);

  // lblMonth.color := clWhite;
  // spBG.Brush.color := lblMonth.color;
  lblDay.color := RGB(intR, intG, intB);
  lblYear.color := lblDay.color;

end;

{ ****************************** N E W    P A R T ****************************** }

end.

