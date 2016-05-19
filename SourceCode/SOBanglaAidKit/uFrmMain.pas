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
  Dialogs, pngimage, ExtCtrls, Buttons, ComCtrls, StdCtrls, AppEvnts, ShlObj,
  StrUtils;

type
  TfrmMain = class(TForm)
    imgHeader:       TImage;
    pnlDown:         TPanel;
    imgIWlogo:       TImage;
    pnlBtnIconFix:   TPanel;
    ScrollBox:       TScrollBox;
    pnlMain:         TPanel;
    lblTitleIconFont: TLabel;
    cmbBoxIconFont:  TComboBox;
    pnlBtnIEFix:     TPanel;
    Shape1:          TShape;
    Image3:          TImage;
    Image4:          TImage;
    Label3:          TLabel;
    Shape2:          TShape;
    lblIconEx:       TLabel;
    Label5:          TLabel;
    lblTitleFontSmooth: TLabel;
    pnlBtnSmooth:    TPanel;
    pnlBtnNoSmooth:  TPanel;
    Shape3:          TShape;
    Label2:          TLabel;
    lblSmooth:       TLabel;
    Label8:          TLabel;
    Label9:          TLabel;
    pnlBtnIComplex:  TPanel;
    Shape4:          TShape;
    Shape5:          TShape;
    pnlBtnExit:      TPanel;
    lblTitleFF:      TLabel;
    Shape6:          TShape;
    Shape7:          TShape;
    Image1:          TImage;
    Image2:          TImage;
    Image5:          TImage;
    Label14:         TLabel;
    Label15:         TLabel;
    Label16:         TLabel;
    Label17:         TLabel;
    Label18:         TLabel;
    Label19:         TLabel;
    Label20:         TLabel;
    Label21:         TLabel;
    Label22:         TLabel;
    Label23:         TLabel;
    Label24:         TLabel;
    Label25:         TLabel;
    Label26:         TLabel;
    Label27:         TLabel;
    Image6:          TImage;
    Label44:         TLabel;
    Label45:         TLabel;
    Label46:         TLabel;
    Label47:         TLabel;
    Label48:         TLabel;
    Label49:         TLabel;
    Label50:         TLabel;
    Label51:         TLabel;
    Label52:         TLabel;
    Shape8:          TShape;
    lblTitleCrm:     TLabel;
    Shape9:          TShape;
    Shape10:         TShape;
    Label28:         TLabel;
    cmbBoxIEFont:    TComboBox;
    Label29:         TLabel;
    lblIEex:         TLabel;
    Shape11:         TShape;
    lblTitleIE:      TLabel;
    Image7:          TImage;
    Shape12:         TShape;
    lblTitleAbout:   TLabel;
    Label41:         TLabel;
    lblVersion:      TLabel;
    Label42:         TLabel;
    imgFB:           TImage;
    imgGPlus:        TImage;
    imgTwitter:      TImage;
    imgWSite:        TImage;
    Label43:         TLabel;
    lblIconFont:     TLabel;
    lblEIfont:       TLabel;
    Label55:         TLabel;
    Label54:         TLabel;
    Label56:         TLabel;
    ApplicationEvents: TApplicationEvents;
    pnlRestartInfo:  TPanel;
    Label57:         TLabel;
    lblBtnCloseInfo: TLabel;
    Shape15:         TShape;
    pnlBtnInstallFonts: TPanel;
    Label1:          TLabel;
    Label4:          TLabel;
    Image8:          TImage;
    Image9:          TImage;
    grpBoxAboutUs:   TGroupBox;
    Shape13:         TShape;
    Shape14:         TShape;
    Label10:         TLabel;
    Label12:         TLabel;
    Label7:          TLabel;
    Label32:         TLabel;
    Label33:         TLabel;
    Label34:         TLabel;
    Label35:         TLabel;
    Label37:         TLabel;
    Label38:         TLabel;
    Label40:         TLabel;
    Label30:         TLabel;
    Label39:         TLabel;
    Label36:         TLabel;
    Label11:         TLabel;
    Label6:          TLabel;

    procedure LoadAll;
    procedure ComplexLanguageNotify;

    function AllFontExist: boolean;

    procedure sBtnExitClick(Sender: TObject);
    procedure imgHeaderMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure FormCreate(Sender: TObject);
    procedure pnlBtnMouseEnter(Sender: TObject);
    procedure pnlBtnMouseLeave(Sender: TObject);
    procedure pnlBtnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure pnlBtnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure pnlBtnExitClick(Sender: TObject);
    procedure cmbBoxIconFontChange(Sender: TObject);
    procedure cmbBoxIEFontChange(Sender: TObject);
    procedure imgTwitterClick(Sender: TObject);
    procedure pnlBtnIComplexClick(Sender: TObject);
    procedure pnlBtnIconFixClick(Sender: TObject);
    procedure pnlBtnIEFixClick(Sender: TObject);
    procedure pnlBtnSmoothClick(Sender: TObject);
    procedure pnlBtnNoSmoothClick(Sender: TObject);
    procedure imgFBClick(Sender: TObject);
    procedure imgGPlusClick(Sender: TObject);
    procedure imgWSiteClick(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: boolean);
    procedure lblBtnCloseInfoClick(Sender: TObject);
    procedure lblTitleClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pnlBtnInstallFontsClick(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);

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
  uRegistry,
  uFunctions,
  uTextStrings;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.CreateParams(var Params: TCreateParams);
const
  CS_DROPSHADOW = $00020000;
begin
  inherited;
  Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.imgHeaderMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    TForm(frmMain).Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.imgFBClick(Sender: TObject);
begin

  Open_URL('http://www.facebook.com/Imaginative.World.BD');

end;

procedure TfrmMain.imgGPlusClick(Sender: TObject);
begin

  Open_URL('http://gplus.to/ImaginativeWorld');

end;

procedure TfrmMain.imgTwitterClick(Sender: TObject);
begin

  Open_URL('http://www.twitter.com/IW_BD');

end;

procedure TfrmMain.imgWSiteClick(Sender: TObject);
begin

  Open_URL('http://imaginativeworld.org');

end;

procedure TfrmMain.Label6Click(Sender: TObject);
begin
  Open_URL('http://shohag.imaginativeworld.org');
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.lblBtnCloseInfoClick(Sender: TObject);
begin
  pnlRestartInfo.Visible := False;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.lblTitleClick(Sender: TObject);
begin

  ScrollBox.VertScrollBar.Position := (Sender as TLabel).Top - 5;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlBtnExitClick(Sender: TObject);
begin
  Close;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlBtnIComplexClick(Sender: TObject);
begin

  Execute_Something(appdir + 'IComplex.exe');

  pnlRestartInfo.Visible := True;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlBtnIconFixClick(Sender: TObject);
var
  Reg: TMyRegistry;
begin

  if cmbBoxIconFont.ItemIndex <> -1 then
  begin

    Reg := TMyRegistry.Create;
    Reg.RootKey := HKEY_LOCAL_MACHINE;

    if Reg.OpenKey('SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontSubstitutes',
      True) = True then
    begin

      Reg.WriteString('Vrinda',
        cmbBoxIconFont.Items.Strings[cmbBoxIconFont.ItemIndex]);

      lblIconFont.Caption := cmbBoxIconFont.Items.Strings
        [cmbBoxIconFont.ItemIndex];

      infoMsg('Default font set to ''' + cmbBoxIconFont.Items.Strings
        [cmbBoxIconFont.ItemIndex] + '''');

      pnlRestartInfo.Visible := True;

      if FileExists(GetWindowsFolder() + 'fonts/vrinda.ttf') then
      begin

      if MyMoveFile(GetWindowsFolder() + 'fonts/vrinda.ttf',
        GetHomeFolder() + 'vrinda.ttf',true) and MyMoveFile(GetWindowsFolder() +
        'fonts/vrindab.ttf', GetHomeFolder() + 'vrindab.ttf', true) then
      begin
        infoMsg('Vrinda font has been uninstalled from your computer.' +
          #10 + 'A backup copy has been created. ' + #10 +
          'You can reinstall Vrinda font later from:' + #10 + GetHomeFolder() +
          'vrinda.ttf' + #10 + GetHomeFolder() + 'vrindab.ttf');
      end
      else
      begin

      	infoMsg('Vrinda font can''t uninstall from your computer!');

      end;

      end;

    end;

    Reg.Free;

  end
  else
  begin
    infoMsg('Select a Font first.');
  end;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlBtnIEFixClick(Sender: TObject);
var
  Reg: TMyRegistry;
begin
  if cmbBoxIEFont.ItemIndex <> -1 then
  begin

    Reg := TMyRegistry.Create;
    Reg.RootKey := HKEY_CURRENT_USER;

    if Reg.OpenKey('Software\Microsoft\Internet Explorer\International\Scripts\11',
      True) = True then
    begin

      Reg.WriteString('IEFixedFontName',
        cmbBoxIEFont.Items.Strings[cmbBoxIEFont.ItemIndex]);
      Reg.WriteString('IEPropFontName',
        cmbBoxIEFont.Items.Strings[cmbBoxIEFont.ItemIndex]);

      lblEIfont.Caption := cmbBoxIEFont.Items.Strings[cmbBoxIEFont.ItemIndex];

      infoMsg('Default font set to ''' + cmbBoxIEFont.Items.Strings
        [cmbBoxIEFont.ItemIndex] + '''');
    end;

    Reg.Free;

  end
  else
  begin
    infoMsg('Select a Font first.');
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlBtnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  (Sender as TPanel)
  .Color := clBlack;
  (Sender as TPanel)
  .Font.Color := clWhite;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlBtnMouseEnter(Sender: TObject);
begin
  (Sender as TPanel)
  .Color := clGray;
  (Sender as TPanel)
  .Font.Color := clWhite;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlBtnMouseLeave(Sender: TObject);
begin
  (Sender as TPanel)
  .Color := $00F0F0F0;
  (Sender as TPanel)
  .Font.Color := clBlack;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlBtnMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  (Sender as TPanel)
  .Color := clGray;
  (Sender as TPanel)
  .Font.Color := clWhite;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlBtnNoSmoothClick(Sender: TObject);
var
  Reg: TMyRegistry;
begin

  Reg := TMyRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;

  if Reg.OpenKey('Control Panel\Desktop', True) = True then
  begin

    Reg.WriteString('FontSmoothing', '0');

    // SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);

    lblSmooth.Caption := 'অমসৃণ';

    infoMsg('Font smoothing OFF.');

    pnlRestartInfo.Visible := True;

  end;

  Reg.Free;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlBtnSmoothClick(Sender: TObject);
var
  Reg: TMyRegistry;
begin

  Reg := TMyRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;

  if Reg.OpenKey('Control Panel\Desktop', True) = True then
  begin

    Reg.WriteString('FontSmoothing', '2');
    Reg.WriteString('FontSmoothingType', '2');

    // SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);

    lblSmooth.Caption := 'মসৃণ';

    infoMsg('Font smoothing ON.');

    pnlRestartInfo.Visible := True;

  end;

  Reg.Free;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  Action := caFree;

  frmMain := nil;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.FormCreate(Sender: TObject);
var
  { Shaped Form }
  ShapeBG: HRGN;
begin

  { Set Application Default Dir }
  appdir := ExtractFilePath(Application.ExeName);

  { Shaped Form }
  ShapeBG := CreateRoundRectRgn(0, 0, 750, 550, 11, 11);
  // ( Left, Top, Width, Height, Circle -, Circle | )
  SetWindowRgn(Handle, ShapeBG, True);
  DeleteObject(ShapeBG);

  { Vertical Scrolbar }
  ScrollBox.VertScrollBar.Position := 0;

  LoadAll;

  { Change Version }
  lblVersion.Caption := 'সংস্করণঃ ' + AppVersionInfo;

end;

procedure TfrmMain.Image9Click(Sender: TObject);
begin

  Open_URL(strLogoURL);

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.LoadAll;
begin
  { Bangla Font Seeing Problem }
  ComplexLanguageNotify;

  GetIEpref;
  GetSmoothPref;
  GetIconPref;

  { Icon Font }
  //  if IsWin8OrLater then
  //  begin
  //    lblIconFont.Caption := 'Nirmala UI';
  //    pnlBtnIconFix.Enabled := False;
  //    pnlBtnIconFix.Font.Color := clGray;
  //    cmbBoxIconFont.Enabled := False;
  //  end
  //  else
  lblIconFont.Caption := confIconDefaultFont;

  lblIconEx.Font.Name := lblIconFont.Caption;

  { Font Smooth }
  if confIsFontSmooth then
    lblSmooth.Caption := 'মসৃণ'
  else
    lblSmooth.Caption := 'অমসৃণ';

  { IE Font }
  lblEIfont.Caption := confIEdefaultFont;

  lblIEex.Font.Name := lblEIfont.Caption;

  { Check Font Existence }
  if AllFontExist = False then
  begin
    Shape15.Visible := True;
    Label1.Visible  := True;
    Label4.Visible  := True;
    pnlBtnInstallFonts.Visible := True;
  end;
end;

{ ****************************** N E W    P A R T ****************************** }

function TfrmMain.AllFontExist: boolean;
begin
  Result := False;

  if Screen.Fonts.IndexOf('Nirmala UI') = -1 then
    exit;
  if Screen.Fonts.IndexOf('Siyam Rupali') = -1 then
    exit;
  if Screen.Fonts.IndexOf('Kalpurush') = -1 then
    exit;

  Result := True;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlBtnInstallFontsClick(Sender: TObject);
var
  Reg: TMyRegistry;
  b: bool;
begin
  begin
    if Screen.Fonts.IndexOf('Nirmala UI') = -1 then
    begin

      CopyFile(PChar(appdir + 'NirmalaUI.TTF'),
        PChar(GetWindowsFolder + 'Fonts\NirmalaUI.TTF'), b);

      CopyFile(PChar(appdir + 'NirmalaUIB.TTF'),
        PChar(GetWindowsFolder + 'Fonts\NirmalaUIB.TTF'), b);

      Reg := TMyRegistry.Create;
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      Reg.LazyWrite := False;
      Reg.OpenKey('Software\Microsoft\Windows NT\CurrentVersion\Fonts', False);
      Reg.WriteString('Nirmala UI (TrueType)', 'NirmalaUI.TTF');
      Reg.WriteString('Nirmala UI Bold (TrueType)', 'NirmalaUIB.TTF');
      Reg.CloseKey;
      Reg.Free;

      { Add the font resource }
      AddFontResource(PChar(GetWindowsFolder + 'Fonts\NirmalaUI.TTF'));
      AddFontResource(PChar(GetWindowsFolder + 'Fonts\NirmalaUIB.TTF'));
      SendMessage(HWND_BROADCAST, WM_FONTCHANGE, 0, 0);

      { Remove the resource lock }
      RemoveFontResource(PChar(GetWindowsFolder + 'Fonts\NirmalaUI.TTF'));
      RemoveFontResource(PChar(GetWindowsFolder + 'Fonts\NirmalaUIB.TTF'));
      SendMessage(HWND_BROADCAST, WM_FONTCHANGE, 0, 0);

    end;
    { --------------------------------------------------------------------- }
    if Screen.Fonts.IndexOf('Siyam Rupali') = -1 then
    begin

      CopyFile(PChar(appdir + 'SiyamRupali.TTF'),
        PChar(GetWindowsFolder + 'Fonts\SiyamRupali.TTF'), b);

      Reg := TMyRegistry.Create;
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      Reg.LazyWrite := False;
      Reg.OpenKey('Software\Microsoft\Windows NT\CurrentVersion\Fonts', False);
      Reg.WriteString('Siyam Rupali (TrueType)', 'SiyamRupali.TTF');
      Reg.CloseKey;
      Reg.Free;

      { Add the font resource }
      AddFontResource(PChar(GetWindowsFolder + 'Fonts\SiyamRupali.TTF'));
      SendMessage(HWND_BROADCAST, WM_FONTCHANGE, 0, 0);

      { Remove the resource lock }
      RemoveFontResource(PChar(GetWindowsFolder + 'Fonts\SiyamRupali.TTF'));
      SendMessage(HWND_BROADCAST, WM_FONTCHANGE, 0, 0);

    end;
    { --------------------------------------------------------------------- }
    if Screen.Fonts.IndexOf('Kalpurush') = -1 then
    begin

      CopyFile(PChar(appdir + 'Kalpurush.TTF'),
        PChar(GetWindowsFolder + 'Fonts\Kalpurush.TTF'), b);

      Reg := TMyRegistry.Create;
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      Reg.LazyWrite := False;
      Reg.OpenKey('Software\Microsoft\Windows NT\CurrentVersion\Fonts', False);
      Reg.WriteString('Kalpurush (TrueType)', 'Kalpurush.TTF');
      Reg.CloseKey;
      Reg.Free;

      { Add the font resource }
      AddFontResource(PChar(GetWindowsFolder + 'Fonts\Kalpurush.TTF'));
      SendMessage(HWND_BROADCAST, WM_FONTCHANGE, 0, 0);

      { Remove the resource lock }
      RemoveFontResource(PChar(GetWindowsFolder + 'Fonts\Kalpurush.TTF'));
      SendMessage(HWND_BROADCAST, WM_FONTCHANGE, 0, 0);

    end;
  end;

  infoMsg('All fonts installed successfully!');

  begin
    Shape15.Visible := False;
    Label1.Visible  := False;
    Label4.Visible  := False;
    pnlBtnInstallFonts.Visible := False;
  end;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.ApplicationEventsMessage(var Msg: tagMSG; var Handled: boolean);
var
  mousePos: TPoint;
  wc: TWinControl;
begin
  // mouse wheel scrolling for the control under the mouse
  if Msg.message = WM_MOUSEWHEEL then
  begin
    mousePos.X := word(Msg.lParam);
    mousePos.Y := HiWord(Msg.lParam);
    wc := FindVCLWindow(mousePos);
    if wc = nil then
      Handled := True
    else if wc.Handle <> Msg.hwnd then
    begin
      SendMessage(wc.Handle, WM_MOUSEWHEEL, Msg.wParam, Msg.lParam);
      Handled := True;
    end;
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.cmbBoxIconFontChange(Sender: TObject);
begin

  lblIconEx.Font.Name := cmbBoxIconFont.Items.Strings[cmbBoxIconFont.ItemIndex];

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.cmbBoxIEFontChange(Sender: TObject);
begin
  lblIEex.Font.Name := cmbBoxIEFont.Items.Strings[cmbBoxIEFont.ItemIndex];
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.ComplexLanguageNotify;

  function CheckIfComplexLabguageInstalled: boolean;
  var
    Reg: TMyRegistry;
    str: string;
  begin
    Reg := TMyRegistry.Create;
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    Reg.OpenKeyReadOnly('SYSTEM\CurrentControlSet\Control\Nls\Language Groups');
    str := Reg.ReadString('f');
    FreeAndNil(Reg);

    if str = '1' then
      Result := True
    else
      Result := False;
  end;

begin

  pnlBtnIComplex.Font.Color := clGray;

  if IsWinVistaOrLater then
    exit;
  if CheckIfComplexLabguageInstalled then
    exit;

  pnlBtnIComplex.Font.Color := clBlack;
  pnlBtnIComplex.Enabled := True;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.sBtnExitClick(Sender: TObject);
begin
  Close;
end;

end.

