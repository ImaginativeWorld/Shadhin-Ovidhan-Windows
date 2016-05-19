{
 *******************************************************************
 This Source Code Form is subject to the terms of the Mozilla Public
 License, v. 2.0. If a copy of the MPL was not distributed with this
 file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *******************************************************************
}

{$INCLUDE ../ProjectDefines.inc}
unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, JvComponentBase, pngimage,
  ImgList, StdCtrls,
  ComCtrls,
  DateUtils;

type
  TfrmMain = class(TForm)
    imgMainBG: TImage;
    TrayIcon: TTrayIcon;
    PMenuTray: TPopupMenu;
    imgListBtn: TImageList;
    spOvidhan: TShape;
    spAbbr: TShape;
    sp99Names: TShape;
    spSciNames: TShape;
    spGrkLtr: TShape;
    spQSrc: TShape;
    pnlObjects: TPanel;
    imgExit1: TImage;
    imgExit2: TImage;
    imgExit3: TImage;
    imgOptions1: TImage;
    imgOptions2: TImage;
    imgOptions3: TImage;
    imgHelp1: TImage;
    imgHelp2: TImage;
    imgHelp3: TImage;
    imgTools1: TImage;
    imgTools2: TImage;
    imgTools3: TImage;
    imgExit: TImage;
    imgOptions: TImage;
    imgHelp: TImage;
    imgTools: TImage;
    tmrBtnTools: TTimer;
    tmrBtnHelp: TTimer;
    tmrBtnOptions: TTimer;
    tmrBtnExit: TTimer;
    tmrStartEffect: TTimer;
    imgBtnExit: TImage;
    imgBtnMin: TImage;
    imgBtnOnTop: TImage;
    imgBtnExit1: TImage;
    imgBtnMin1: TImage;
    imgBtnMin2: TImage;
    imgBtnExit2: TImage;
    imgBtnExit3: TImage;
    imgBtnMin3: TImage;
    imgBtnOntop1: TImage;
    imgBtnOntop2: TImage;
    lblVersion: TLabel;
    tmrUpdateCheck: TTimer;
    tmrNews: TTimer;
    tmrDT: TTimer;
    lblBnDate: TLabel;
    miDashboard: TMenuItem;
    N4: TMenuItem;
    miDictionary: TMenuItem;
    miAbbreviation: TMenuItem;
    miGreekLetters: TMenuItem;
    N5: TMenuItem;
    miQuickSearchMode: TMenuItem;
    mi99NamesOfAllah: TMenuItem;
    miBiologicalScientificNames: TMenuItem;
    miGoogleTranslate: TMenuItem;
    N6: TMenuItem;
    miOptions: TMenuItem;
    N7: TMenuItem;
    miAboutShadhinOvidhan: TMenuItem;
    miFeedback: TMenuItem;
    miHelp: TMenuItem;
    miCheckUpdate: TMenuItem;
    N8: TMenuItem;
    miExit: TMenuItem;
    miShadhinOvidhanPortableWizard: TMenuItem;
    miBanglarAidKit: TMenuItem;
    N9: TMenuItem;
    miBanglaCalendar2: TMenuItem;
    imgIWlogo: TImage;
    pMenuMinimize: TPopupMenu;
    miMinimizetoTray: TMenuItem;
    miMinimizetoTaskbar: TMenuItem;
    Minimizeto1: TMenuItem;

    { Button Glow Effect }
    Procedure ExitIcon_DrawState;
    Procedure ExitIcon_DrawDown;
    Procedure ExitIcon_DrawUpOver;

    Procedure OptionsIcon_DrawState;
    Procedure OptionsIcon_DrawDown;
    Procedure OptionsIcon_DrawUpOver;

    Procedure HelpIcon_DrawState;
    Procedure HelpIcon_DrawDown;
    Procedure HelpIcon_DrawUpOver;

    Procedure ToolsIcon_DrawState;
    Procedure ToolsIcon_DrawDown;
    Procedure ToolsIcon_DrawUpOver;

    procedure SetComponents;

    { Image Buttons Procedures }
    procedure imgBtnReset(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure btnNotReadyClick(Sender: TObject);
    procedure spMatroMouseEnter(Sender: TObject);
    procedure spMatroMouseLeave(Sender: TObject);
    procedure spMatroMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    { Glow Effect Timers Procedures }
    procedure tmrBtnExitTimer(Sender: TObject);
    procedure tmrBtnOptionsTimer(Sender: TObject);
    procedure tmrBtnHelpTimer(Sender: TObject);
    procedure tmrBtnToolsTimer(Sender: TObject);

    { Button with Glow effect, Procedures }
    procedure imgExitMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgExitMouseEnter(Sender: TObject);
    procedure imgExitMouseLeave(Sender: TObject);
    procedure imgExitMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure imgOptionsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgOptionsMouseEnter(Sender: TObject);
    procedure imgOptionsMouseLeave(Sender: TObject);
    procedure imgOptionsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure imgHelpMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgHelpMouseEnter(Sender: TObject);
    procedure imgHelpMouseLeave(Sender: TObject);
    procedure imgHelpMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure imgToolsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgToolsMouseEnter(Sender: TObject);
    procedure imgToolsMouseLeave(Sender: TObject);
    procedure imgToolsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    { Other Procedures }
    procedure imgMainBGMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgHelpClick(Sender: TObject);
    procedure imgToolsClick(Sender: TObject);
    procedure imgOptionsClick(Sender: TObject);
    procedure tmrStartEffectTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgBtnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgBtnMouseEnter(Sender: TObject);
    procedure imgBtnMouseLeave(Sender: TObject);
    procedure imgBtnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgBtnOnTopClick(Sender: TObject);
    procedure imgExitClick(Sender: TObject);
    procedure imgBtnMinClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmrUpdateCheckTimer(Sender: TObject);
    procedure tmrDTTimer(Sender: TObject);
    procedure tmrNewsTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TrayIconClick(Sender: TObject);
    procedure miDictionaryClick(Sender: TObject);
    procedure miAbbreviationClick(Sender: TObject);
    procedure miGreekLettersClick(Sender: TObject);
    procedure miQuickSearchModeClick(Sender: TObject);
    procedure mi99NamesOfAllahClick(Sender: TObject);
    procedure miBiologicalScientificNamesClick(Sender: TObject);
    procedure miGoogleTranslateClick(Sender: TObject);
    procedure miFeedbackClick(Sender: TObject);
    procedure miHelpClick(Sender: TObject);
    procedure miCheckUpdateClick(Sender: TObject);
    procedure miAboutShadhinOvidhanClick(Sender: TObject);
    procedure miBanglarAidKitClick(Sender: TObject);
    procedure miShadhinOvidhanPortableWizardClick(Sender: TObject);
    procedure miBanglaCalendarClick(Sender: TObject);
    procedure GoogleTranslate1AdvancedDrawItem(Sender: TObject;
      ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState);
    procedure GoogleTranslate1MeasureItem(Sender: TObject; ACanvas: TCanvas;
      var Width, Height: Integer);
    procedure imgIWlogoClick(Sender: TObject);
    procedure miMinimizetoTrayClick(Sender: TObject);
    procedure miMinimizetoTaskbarClick(Sender: TObject);
    procedure imgMainBGMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);

  private
    { Private declarations }
    procedure WMHotKey(var Msg: TWMHotKey); message WM_HOTKEY;
  public
    { Public declarations }
  end;

Const
  m_GlowEffect: Boolean = True;
  m_BlendingStep: Integer = 51; { 255/51=5 step }
  m_TimerInterval: Integer = 30; { 5 step in 30*5=150 milisecond }

var
  frmMain: TfrmMain;

  // Alpha Blend
  ExitIcon_MouseIn: Boolean;
  ExitIcon_MouseDown: Boolean;
  ExitIcon_TranparentValue: Integer;

  OptionsIcon_MouseIn: Boolean;
  OptionsIcon_MouseDown: Boolean;
  OptionsIcon_TranparentValue: Integer;

  HelpIcon_MouseIn: Boolean;
  HelpIcon_MouseDown: Boolean;
  HelpIcon_TranparentValue: Integer;

  ToolsIcon_MouseIn: Boolean;
  ToolsIcon_MouseDown: Boolean;
  ToolsIcon_TranparentValue: Integer;

  { Bangla Calendar }
  MCalendar: TMonthCalendar;

implementation

{$R *.dfm}

Uses
  uFunctions,
  ufrmOptions,
  uBanglaCalendar,
  uFrmPopup,
  uTextStrings;

procedure TfrmMain.imgExitClick(Sender: TObject);
begin
  close;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.imgBtnMinClick(Sender: TObject);
begin

  // Hide;
  //
  // ShowTrayInfo;
  //
  // TrimAppMemorySize;

  with (Sender as TImage) do
  begin
    pMenuMinimize.Popup(self.Left + Left, self.Top + Top + Height);
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.btnNotReadyClick(Sender: TObject);
begin
  application.MessageBox('The feature not ready yet!' + #10 + #10 +
      'Wait for next release.', 'Shadhin Ovidhan :: Info',
    MB_OK + MB_ICONINFORMATION + MB_DEFBUTTON1 + MB_SYSTEMMODAL);
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  Action := caFree;

  frmMain := Nil;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

  SetSettings;

  UnRegHotKey;

  TrayIcon.Visible := False;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  { Set Version }
  strVersion := 'সংস্করণ : ' + AppVersionInfo //
{$IFDEF BetaVersion} + strVersionAddiText {$ENDIF};

  lblVersion.caption := strVersion;
  lblVersion.Left := Width div 2 - lblVersion.Width div 2;

  { Get and Set Settings }
  GetSettings;

  SetComponents;

  { Register HotKey }
  SelectAndRegHotkey;

  { Bangla Calendar }
  MCalendar := TMonthCalendar.Create(self);
  MCalendar.Date := DateOf(Now);
  BanglaDate(MCalendar);
  lblBnDate.caption := BnFullDate;
  FreeAndNil(MCalendar);

  lblBnDate.Height := 50;
  lblBnDate.Width := 175;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.SetComponents;
begin

  { Form Background }
  frmMain.Brush.Bitmap := imgMainBG.Picture.Bitmap;

  if confDashboardTop then
  begin
    FormStyle := fsStayOnTop;
    imgBtnOnTop.Picture := imgBtnOntop2.Picture;
  end
  else
  begin
    FormStyle := fsNormal;
    imgBtnOnTop.Picture := imgBtnOntop1.Picture;
  end;

  { Sys Btns }
  imgBtnMin.Picture := imgBtnMin1.Picture;
  imgBtnExit.Picture := imgBtnExit1.Picture;

  { Others }
  pnlObjects.Top := 2000;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.FormShow(Sender: TObject);
begin
  tmrStartEffect.Enabled := True;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.GoogleTranslate1AdvancedDrawItem(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState);
var
  Bitmap: TBitmap;
begin

  ACanvas.FillRect(ARect);

  if (odSelected in State) then
  begin

    ACanvas.Brush.Color := clGray;

  end;

  // draw text
  ACanvas.Font.Name := 'Segoe UI';
  // ACanvas.Brush.Color := clsilver;
  ACanvas.TextRect(ARect, 35 + ARect.Left, 10 + ARect.Top,
    (Sender as TMenuItem).caption);

  // draw graphics from the imagelist
  Bitmap := TBitmap.Create;
  try
    imgListBtn.GetBitmap((Sender as TMenuItem).ImageIndex, Bitmap);
    // InflateRect(ARect, 25, 0);
    // ACanvas.StretchDraw(ARect, Bitmap);
    ACanvas.Draw(5, ARect.Top + 5, Bitmap);
  finally
    Bitmap.Free;
  end;

end;

procedure TfrmMain.GoogleTranslate1MeasureItem(Sender: TObject;
  ACanvas: TCanvas; var Width, Height: Integer);
begin
  // set to desired height
  Height := 36;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.spMatroMouseEnter(Sender: TObject);
begin (Sender as TShape)
  .Pen.Style := psSolid;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.spMatroMouseLeave(Sender: TObject);
begin (Sender as TShape)
  .Pen.Style := psClear;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.spMatroMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

  with (Sender as TShape) do
  begin

    if Name = 'spOvidhan' then
    begin

      Execute_Something(AppDir + 'ShadhinOvidhan.exe');

    end
    else if Name = 'spAbbr' then
    begin

      Execute_Something(AppDir + 'SOAbbreviation.exe');

    end
    else if Name = 'sp99Names' then
    begin

      Execute_Something(AppDir + 'SO99NamesOfAllah.exe');

    end
    else if Name = 'spSciNames' then
    begin

      Execute_Something(AppDir + 'SOScientificNames.exe');

    end
    else if Name = 'spGrkLtr' then
    begin

      Execute_Something(AppDir + 'SOGreekLetter.exe');

    end
    else if Name = 'spQSrc' then
    begin

      Execute_Something(AppDir + 'ShadhinOvidhan.exe', '-qsearch');

    end;

    if confDashboardAutoHide then
    begin

      self.Hide;

      ShowTrayInfo;

      TrimAppMemorySize;

    end;

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.imgBtnOnTopClick(Sender: TObject);
begin
  if frmMain.FormStyle = fsNormal then
  begin
    frmMain.FormStyle := fsStayOnTop;
    imgBtnOnTop.Picture := imgBtnOntop2.Picture;
    confDashboardTop := True;
  end
  else
  begin
    frmMain.FormStyle := fsNormal;
    imgBtnOnTop.Picture := imgBtnOntop1.Picture;
    confDashboardTop := False;
  end;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.imgIWlogoClick(Sender: TObject);
begin
  Open_URL(strLogoURL);
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.tmrUpdateCheckTimer(Sender: TObject);
begin

  if IsConnected then
  begin

    tmrUpdateCheck.Enabled := False;

    Execute_Something(AppDir + 'SOCommon.exe');

  end
  else
  begin

    tmrUpdateCheck.Interval := (5 * 60 * 1000)

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.tmrDTTimer(Sender: TObject);
begin

  { Bangla Calendar }
  MCalendar := TMonthCalendar.Create(self);
  MCalendar.Date := DateOf(Now);
  BanglaDate(MCalendar);
  lblBnDate.caption := BnFullDate;
  FreeAndNil(MCalendar);

  lblBnDate.Height := 50;
  lblBnDate.Width := 175;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.tmrNewsTimer(Sender: TObject);
var
  MsgResult: Integer;
begin

  if IsConnected then
  begin
    { Like us function }
    if IsLikeUsShowToday = False then
    begin
      if confLikeUsShow < 1 then
      begin
        inc(confLikeUsShow);

        IsLikeUsShowToday := True;

        MsgResult := MessageDlg(strLikeUsMsg, mtInformation, mbYesNo, 0);

        if MsgResult = mrYes then
        begin
          Execute_Something('https://www.facebook.com/Imaginative.World.BD');
        end;

      end;
    end;

    { News Function }
    case confNewsInterval of
      0:
        begin
          if FileExists(ExtractFilepath(application.exename) + 'SONews.exe')
            then
          begin

            Execute_Something(AppDir + 'SONews.exe');

          end
          else
          begin
            tmrNews.Enabled := False;
            application.MessageBox(Pchar('Error Description:' + #10 +
                  'Some executable file of Shadhin Ovidhan not found!' + #10 +
                  #10 + #10 +
                  'Please reinstall Shadhin Ovidhan and try again.' +
                //
                  #10 + #10 + #10 + strIfItBug), //
              'Shadhin Ovidhan | Info', //
              MB_OK + MB_ICONHAND + MB_DEFBUTTON1 + MB_APPLMODAL);
          end;
        end;
      1:
        begin
          if confLastNewsCheck <> DayOfTheYear(Now) then
          begin
            if FileExists(ExtractFilepath(application.exename) + 'SONews.exe')
              then
            begin

              Execute_Something(AppDir + 'SONews.exe');

            end
            else
            begin
              tmrNews.Enabled := False;
              application.MessageBox(Pchar('Error Description:' + #10 +
                    'Some executable file of Shadhin Ovidhan not found!' +
                    #10 + #10 + #10 +
                    'Please reinstall Shadhin Ovidhan and try again.' + #10 +
                    #10 + #10 + strIfItBug), 'Shadhin Ovidhan | Info',
                MB_OK + MB_ICONHAND + MB_DEFBUTTON1 + MB_APPLMODAL);
            end;

            confLastNewsCheck := DayOfTheYear(Now);

          end;

        end;
      2:
        begin
          if confLastNewsCheck <= (DayOfTheYear(Now) - 7) then
          begin
            if FileExists(ExtractFilepath(application.exename) + 'SONews.exe')
              then
            begin

              Execute_Something(AppDir + 'SONews.exe');

            end
            else
            begin
              tmrNews.Enabled := False;
              application.MessageBox(Pchar('Error Description:' + #10 +
                    'Some executable file of Shadhin Ovidhan not found!' +
                    #10 + #10 + #10 +
                    'Please reinstall Shadhin Ovidhan and try again.' + #10 +
                    #10 + #10 + strIfItBug), 'Shadhin Ovidhan | Info',
                MB_OK + MB_ICONHAND + MB_DEFBUTTON1 + MB_APPLMODAL);
            end;

            confLastNewsCheck := DayOfTheYear(Now);

          end;
        end;
    end;

    tmrNews.Enabled := False;

  end
  else
  begin

    tmrNews.Interval := (5 * 60 * 1000)

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.tmrStartEffectTimer(Sender: TObject);
begin
  if frmMain.AlphaBlendValue < 250 then
  begin
    frmMain.AlphaBlendValue := frmMain.AlphaBlendValue + 25;
  end
  else
  begin
    frmMain.AlphaBlendValue := 255;
    tmrStartEffect.Enabled := False;
  end;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.WMHotKey(var Msg: TWMHotKey);
begin

  if Msg.HotKey = HKid then
    Execute_Something(AppDir + 'ShadhinOvidhan.exe', '-qsearch');

end;

{ ****************************** N E W    P A R T ****************************** }
{$REGION '          Image Up-Down Events          '}

procedure TfrmMain.imgBtnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

  if Sender.ClassType = TImage then
  begin
    with Sender as TImage do
    begin
      if Name = 'imgBtnMin' then
      begin
        imgBtnMin.Picture := imgBtnMin3.Picture;
      end
      else if Name = 'imgBtnExit' then
      begin
        imgBtnExit.Picture := imgBtnExit3.Picture;
      end;
    end;
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.imgBtnMouseEnter(Sender: TObject);
begin

  imgBtnReset(Sender);

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.imgBtnMouseLeave(Sender: TObject);
begin

  if Sender.ClassType = TImage then
  begin
    with Sender as TImage do
    begin
      if Name = 'imgBtnMin' then
      begin
        imgBtnMin.Picture := imgBtnMin1.Picture;
      end
      else if Name = 'imgBtnExit' then
      begin
        imgBtnExit.Picture := imgBtnExit1.Picture;
      end;
    end;
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.imgBtnMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

  imgBtnReset(Sender);

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.imgBtnReset(Sender: TObject);
begin

  if Sender.ClassType = TImage then
  begin
    with Sender as TImage do
    begin
      if Name = 'imgBtnMin' then
      begin
        imgBtnMin.Picture := imgBtnMin2.Picture;
      end
      else if Name = 'imgBtnExit' then
      begin
        imgBtnExit.Picture := imgBtnExit2.Picture;
      end;
    end;
  end;

end;
{$ENDREGION}
{ ****************************** N E W    P A R T ****************************** }
{$REGION '          Tray Menu         }

procedure TfrmMain.mi99NamesOfAllahClick(Sender: TObject);
begin

  Execute_Something(AppDir + 'SO99NamesOfAllah.exe');

end;

procedure TfrmMain.miAbbreviationClick(Sender: TObject);
begin

  Execute_Something(AppDir + 'SOAbbreviation.exe');

end;

procedure TfrmMain.miAboutShadhinOvidhanClick(Sender: TObject);
begin

  Execute_Something(AppDir + 'SOCommon.exe', '-about');

end;

procedure TfrmMain.miBanglaCalendarClick(Sender: TObject);
begin

  Execute_Something(AppDir + 'SOBanglaCalendar.exe');

end;

procedure TfrmMain.miBanglarAidKitClick(Sender: TObject);
begin

  Execute_Something(AppDir + 'Tools\SOBanglaAidKit.exe');

end;

procedure TfrmMain.miBiologicalScientificNamesClick(Sender: TObject);
begin

  Execute_Something(AppDir + 'SOScientificNames.exe');

end;

procedure TfrmMain.miCheckUpdateClick(Sender: TObject);
begin

  Execute_Something(AppDir + 'SOCommon.exe', '-notsilent');

end;

procedure TfrmMain.miDictionaryClick(Sender: TObject);
begin

  Execute_Something(AppDir + 'ShadhinOvidhan.exe');

end;

procedure TfrmMain.miFeedbackClick(Sender: TObject);
begin

  Execute_Something(AppDir + 'SOFeedback.exe');

end;

procedure TfrmMain.miGoogleTranslateClick(Sender: TObject);
begin

  Execute_Something(AppDir + 'SOGTranslate.exe');

end;

procedure TfrmMain.miGreekLettersClick(Sender: TObject);
begin

  Execute_Something(AppDir + 'SOGreekLetter.exe');

end;

procedure TfrmMain.miHelpClick(Sender: TObject);
begin

  Execute_Something(AppDir + 'SOHelp.exe');

end;

procedure TfrmMain.miQuickSearchModeClick(Sender: TObject);
begin

  Execute_Something(AppDir + 'ShadhinOvidhan.exe', '-qsearch');

end;

procedure TfrmMain.miShadhinOvidhanPortableWizardClick(Sender: TObject);
begin

  Execute_Something(AppDir + 'SOPortableWizard.exe');

end;

{ Minimize Popup }
procedure TfrmMain.miMinimizetoTaskbarClick(Sender: TObject);
begin

  application.Minimize;

  imgBtnMin.Picture := imgBtnMin1.Picture;

end;

procedure TfrmMain.miMinimizetoTrayClick(Sender: TObject);
begin

  self.Hide;

  ShowTrayInfo;

  imgBtnMin.Picture := imgBtnMin1.Picture;

  TrimAppMemorySize;

end;
{$ENDREGION}
{ ****************************** N E W    P A R T ****************************** }
{$REGION '          Image Button Events         '}

procedure TfrmMain.tmrBtnExitTimer(Sender: TObject);
Var
  bf: TBLENDFUNCTION;
begin

  If ExitIcon_MouseIn = True Then
  Begin
    // blend to over state
    ExitIcon_TranparentValue := ExitIcon_TranparentValue + m_BlendingStep;
    If ExitIcon_TranparentValue >= 255 Then
    Begin (Sender as TTimer)
      .Enabled := False;
      ExitIcon_TranparentValue := 0;
      ExitIcon_DrawState;
      // Icon_MouseIn := False; //
      exit;
    End;

    bf.BlendOp := 0;
    bf.BlendFlags := 0;
    bf.SourceConstantAlpha := ExitIcon_TranparentValue;
    bf.AlphaFormat := 0;

    Windows.AlphaBlend(imgExit.Canvas.Handle, 0, 0, imgExit.Width,
      imgExit.Height, imgExit2.Picture.Bitmap.Canvas.Handle, 0, 0,
      imgExit.Width, imgExit.Height, bf);

  End
  Else
  Begin
    // blend to up state
    ExitIcon_TranparentValue := ExitIcon_TranparentValue + m_BlendingStep;
    If ExitIcon_TranparentValue >= 255 Then
    Begin (Sender as TTimer)
      .Enabled := False;
      ExitIcon_TranparentValue := 0;
      ExitIcon_DrawState;
      // Icon_MouseIn := true; //
      exit;
    End;

    bf.BlendOp := 0;
    bf.BlendFlags := 0;
    bf.SourceConstantAlpha := ExitIcon_TranparentValue;
    bf.AlphaFormat := 0;

    Windows.AlphaBlend(imgExit.Canvas.Handle, 0, 0, imgExit.Width,
      imgExit.Height, imgExit1.Picture.Bitmap.Canvas.Handle, 0, 0,
      imgExit.Width, imgExit.Height, bf);

  End;

  imgExit.Refresh;
end;

/// /////////////////////////////////////////////////////////////////////////

Procedure TfrmMain.ExitIcon_DrawDown;
Begin
  tmrBtnExit.Enabled := False;
  imgExit.Picture.Bitmap.Assign(imgExit3.Picture.Bitmap);

End;

/// /////////////////////////////////////////////////////////////////////////

Procedure TfrmMain.ExitIcon_DrawState;
Begin
  If ExitIcon_MouseDown = False Then
  Begin

    ExitIcon_DrawUpOver;

  End
  Else
  Begin

    ExitIcon_DrawDown;

  End;

  imgExit.Refresh;
End;

/// /////////////////////////////////////////////////////////////////////////

Procedure TfrmMain.ExitIcon_DrawUpOver;
Begin
  tmrBtnExit.Enabled := False;
  If ExitIcon_MouseIn Then
  Begin
    // draw over state
    imgExit.Picture.Bitmap.Assign(imgExit2.Picture.Bitmap);

  End
  Else
  Begin
    // draw up state
    imgExit.Picture.Bitmap.Assign(imgExit1.Picture.Bitmap);
  End;
End;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmMain.imgExitMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ExitIcon_MouseDown := True;
  ExitIcon_DrawState;
end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmMain.imgExitMouseEnter(Sender: TObject);
begin
  ExitIcon_MouseIn := True;
  ExitIcon_TranparentValue := 0;
  If m_GlowEffect = True Then
  Begin
    tmrBtnExit.Enabled := True;
  End
  Else
  Begin
    ExitIcon_DrawState;
  End;
end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmMain.imgExitMouseLeave(Sender: TObject);
begin
  ExitIcon_MouseIn := False;
  ExitIcon_MouseDown := False;
  ExitIcon_TranparentValue := 0;
  If m_GlowEffect Then
  Begin
    tmrBtnExit.Enabled := True;
  End
  Else
  Begin
    ExitIcon_DrawState;
  End;
end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmMain.imgExitMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ExitIcon_MouseDown := False;
  ExitIcon_DrawState;
end;

{ ****************************** N E W    P A R T ****************************** }

// Options

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.tmrBtnOptionsTimer(Sender: TObject);
Var
  bf: TBLENDFUNCTION;
begin

  If OptionsIcon_MouseIn = True Then
  Begin
    // blend to over state
    OptionsIcon_TranparentValue := OptionsIcon_TranparentValue + m_BlendingStep;
    If OptionsIcon_TranparentValue >= 255 Then
    Begin (Sender as TTimer)
      .Enabled := False;
      OptionsIcon_TranparentValue := 0;
      OptionsIcon_DrawState;
      // Icon_MouseIn := False; //
      exit;
    End;

    bf.BlendOp := 0;
    bf.BlendFlags := 0;
    bf.SourceConstantAlpha := OptionsIcon_TranparentValue;
    bf.AlphaFormat := 0;

    Windows.AlphaBlend(imgOptions.Canvas.Handle, 0, 0, imgOptions.Width,
      imgOptions.Height, imgOptions2.Picture.Bitmap.Canvas.Handle, 0, 0,
      imgOptions.Width, imgOptions.Height, bf);

  End
  Else
  Begin
    // blend to up state
    OptionsIcon_TranparentValue := OptionsIcon_TranparentValue + m_BlendingStep;
    If OptionsIcon_TranparentValue >= 255 Then
    Begin (Sender as TTimer)
      .Enabled := False;
      OptionsIcon_TranparentValue := 0;
      OptionsIcon_DrawState;
      // Icon_MouseIn := true; //
      exit;
    End;

    bf.BlendOp := 0;
    bf.BlendFlags := 0;
    bf.SourceConstantAlpha := OptionsIcon_TranparentValue;
    bf.AlphaFormat := 0;

    Windows.AlphaBlend(imgOptions.Canvas.Handle, 0, 0, imgOptions.Width,
      imgOptions.Height, imgOptions1.Picture.Bitmap.Canvas.Handle, 0, 0,
      imgOptions.Width, imgOptions.Height, bf);

  End;

  imgOptions.Refresh;
end;

/// /////////////////////////////////////////////////////////////////////////

Procedure TfrmMain.OptionsIcon_DrawDown;
Begin
  tmrBtnOptions.Enabled := False;
  imgOptions.Picture.Bitmap.Assign(imgOptions3.Picture.Bitmap);

End;

/// /////////////////////////////////////////////////////////////////////////

Procedure TfrmMain.OptionsIcon_DrawState;
Begin
  If OptionsIcon_MouseDown = False Then
  Begin

    OptionsIcon_DrawUpOver;

  End
  Else
  Begin

    OptionsIcon_DrawDown;

  End;

  imgOptions.Refresh;
End;

/// /////////////////////////////////////////////////////////////////////////

Procedure TfrmMain.OptionsIcon_DrawUpOver;
Begin
  tmrBtnOptions.Enabled := False;
  If OptionsIcon_MouseIn Then
  Begin
    // draw over state
    imgOptions.Picture.Bitmap.Assign(imgOptions2.Picture.Bitmap);

  End
  Else
  Begin
    // draw up state
    imgOptions.Picture.Bitmap.Assign(imgOptions1.Picture.Bitmap);
  End;
End;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmMain.imgOptionsClick(Sender: TObject);
begin

  CheckCreateForm(TfrmOptions, frmOptions, 'frmOptions');
  frmOptions.ShowModal;

end;

procedure TfrmMain.imgOptionsMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  OptionsIcon_MouseDown := True;
  OptionsIcon_DrawState;
end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmMain.imgOptionsMouseEnter(Sender: TObject);
begin
  OptionsIcon_MouseIn := True;
  OptionsIcon_TranparentValue := 0;
  If m_GlowEffect = True Then
  Begin
    tmrBtnOptions.Enabled := True;
  End
  Else
  Begin
    OptionsIcon_DrawState;
  End;
end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmMain.imgOptionsMouseLeave(Sender: TObject);
begin
  OptionsIcon_MouseIn := False;
  OptionsIcon_MouseDown := False;
  OptionsIcon_TranparentValue := 0;
  If m_GlowEffect Then
  Begin
    tmrBtnOptions.Enabled := True;
  End
  Else
  Begin
    OptionsIcon_DrawState;
  End;
end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmMain.imgOptionsMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  OptionsIcon_MouseDown := False;
  OptionsIcon_DrawState;
end;

{ ****************************** N E W    P A R T ****************************** }

// Help

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.tmrBtnHelpTimer(Sender: TObject);
Var
  bf: TBLENDFUNCTION;
begin

  If HelpIcon_MouseIn = True Then
  Begin
    // blend to over state
    HelpIcon_TranparentValue := HelpIcon_TranparentValue + m_BlendingStep;
    If HelpIcon_TranparentValue >= 255 Then
    Begin (Sender as TTimer)
      .Enabled := False;
      HelpIcon_TranparentValue := 0;
      HelpIcon_DrawState;
      // Icon_MouseIn := False; //
      exit;
    End;

    bf.BlendOp := 0;
    bf.BlendFlags := 0;
    bf.SourceConstantAlpha := HelpIcon_TranparentValue;
    bf.AlphaFormat := 0;

    Windows.AlphaBlend(imgHelp.Canvas.Handle, 0, 0, imgHelp.Width,
      imgHelp.Height, imgHelp2.Picture.Bitmap.Canvas.Handle, 0, 0,
      imgHelp.Width, imgHelp.Height, bf);

  End
  Else
  Begin
    // blend to up state
    HelpIcon_TranparentValue := HelpIcon_TranparentValue + m_BlendingStep;
    If HelpIcon_TranparentValue >= 255 Then
    Begin (Sender as TTimer)
      .Enabled := False;
      HelpIcon_TranparentValue := 0;
      HelpIcon_DrawState;
      // Icon_MouseIn := true; //
      exit;
    End;

    bf.BlendOp := 0;
    bf.BlendFlags := 0;
    bf.SourceConstantAlpha := HelpIcon_TranparentValue;
    bf.AlphaFormat := 0;

    Windows.AlphaBlend(imgHelp.Canvas.Handle, 0, 0, imgHelp.Width,
      imgHelp.Height, imgHelp1.Picture.Bitmap.Canvas.Handle, 0, 0,
      imgHelp.Width, imgHelp.Height, bf);

  End;

  imgHelp.Refresh;
end;

/// /////////////////////////////////////////////////////////////////////////

Procedure TfrmMain.HelpIcon_DrawDown;
Begin
  tmrBtnHelp.Enabled := False;
  imgHelp.Picture.Bitmap.Assign(imgHelp3.Picture.Bitmap);

End;

/// /////////////////////////////////////////////////////////////////////////

Procedure TfrmMain.HelpIcon_DrawState;
Begin
  If HelpIcon_MouseDown = False Then
  Begin

    HelpIcon_DrawUpOver;

  End
  Else
  Begin

    HelpIcon_DrawDown;

  End;

  imgHelp.Refresh;
End;

/// /////////////////////////////////////////////////////////////////////////

Procedure TfrmMain.HelpIcon_DrawUpOver;
Begin
  tmrBtnHelp.Enabled := False;
  If HelpIcon_MouseIn Then
  Begin
    // draw over state
    imgHelp.Picture.Bitmap.Assign(imgHelp2.Picture.Bitmap);

  End
  Else
  Begin
    // draw up state
    imgHelp.Picture.Bitmap.Assign(imgHelp1.Picture.Bitmap);
  End;
End;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmMain.imgHelpClick(Sender: TObject);
begin

  // pMenuHelp.Popup(left + imgHelp.left + 15, top + imgHelp.top + 15);

  // pMenuHelp.Popup(left + imgHelp.left, Top + imgHelp.Top + imgHelp.Height);

  CheckCreateForm(TfrmPopup, frmPopup, 'frmPopup');

  frmPopup.SetComponents(2, Left + imgHelp.Left, Top + imgHelp.Top);

  frmPopup.show;

end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmMain.imgHelpMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  HelpIcon_MouseDown := True;
  HelpIcon_DrawState;
end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmMain.imgHelpMouseEnter(Sender: TObject);
begin
  HelpIcon_MouseIn := True;
  HelpIcon_TranparentValue := 0;
  If m_GlowEffect = True Then
  Begin
    tmrBtnHelp.Enabled := True;
  End
  Else
  Begin
    HelpIcon_DrawState;
  End;
end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmMain.imgHelpMouseLeave(Sender: TObject);
begin
  HelpIcon_MouseIn := False;
  HelpIcon_MouseDown := False;
  HelpIcon_TranparentValue := 0;
  If m_GlowEffect Then
  Begin
    tmrBtnHelp.Enabled := True;
  End
  Else
  Begin
    HelpIcon_DrawState;
  End;
end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmMain.imgHelpMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  HelpIcon_MouseDown := False;
  HelpIcon_DrawState;
end;

procedure TfrmMain.imgMainBGMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    TForm(frmMain).Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;

procedure TfrmMain.imgMainBGMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin

  { Minimize Bug Fixed }
  imgBtnMin.Picture := imgBtnMin1.Picture;

end;

{ ****************************** N E W    P A R T ****************************** }

// Tools

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.tmrBtnToolsTimer(Sender: TObject);
Var
  bf: TBLENDFUNCTION;
begin

  If ToolsIcon_MouseIn = True Then
  Begin
    // blend to over state
    ToolsIcon_TranparentValue := ToolsIcon_TranparentValue + m_BlendingStep;
    If ToolsIcon_TranparentValue >= 255 Then
    Begin (Sender as TTimer)
      .Enabled := False;
      ToolsIcon_TranparentValue := 0;
      ToolsIcon_DrawState;
      // Icon_MouseIn := False; //
      exit;
    End;

    bf.BlendOp := 0;
    bf.BlendFlags := 0;
    bf.SourceConstantAlpha := ToolsIcon_TranparentValue;
    bf.AlphaFormat := 0;

    Windows.AlphaBlend(imgTools.Canvas.Handle, 0, 0, imgTools.Width,
      imgTools.Height, imgTools2.Picture.Bitmap.Canvas.Handle, 0, 0,
      imgTools.Width, imgTools.Height, bf);

  End
  Else
  Begin
    // blend to up state
    ToolsIcon_TranparentValue := ToolsIcon_TranparentValue + m_BlendingStep;
    If ToolsIcon_TranparentValue >= 255 Then
    Begin (Sender as TTimer)
      .Enabled := False;
      ToolsIcon_TranparentValue := 0;
      ToolsIcon_DrawState;
      // Icon_MouseIn := true; //
      exit;
    End;

    bf.BlendOp := 0;
    bf.BlendFlags := 0;
    bf.SourceConstantAlpha := ToolsIcon_TranparentValue;
    bf.AlphaFormat := 0;

    Windows.AlphaBlend(imgTools.Canvas.Handle, 0, 0, imgTools.Width,
      imgTools.Height, imgTools1.Picture.Bitmap.Canvas.Handle, 0, 0,
      imgTools.Width, imgTools.Height, bf);

  End;

  imgTools.Refresh;
end;

/// /////////////////////////////////////////////////////////////////////////

Procedure TfrmMain.ToolsIcon_DrawDown;
Begin
  tmrBtnTools.Enabled := False;
  imgTools.Picture.Bitmap.Assign(imgTools3.Picture.Bitmap);

End;

/// /////////////////////////////////////////////////////////////////////////

Procedure TfrmMain.ToolsIcon_DrawState;
Begin
  If ToolsIcon_MouseDown = False Then
  Begin

    ToolsIcon_DrawUpOver;

  End
  Else
  Begin

    ToolsIcon_DrawDown;

  End;

  imgTools.Refresh;
End;

/// /////////////////////////////////////////////////////////////////////////

Procedure TfrmMain.ToolsIcon_DrawUpOver;
Begin
  tmrBtnTools.Enabled := False;
  If ToolsIcon_MouseIn Then
  Begin
    // draw over state
    imgTools.Picture.Bitmap.Assign(imgTools2.Picture.Bitmap);

  End
  Else
  Begin
    // draw up state
    imgTools.Picture.Bitmap.Assign(imgTools1.Picture.Bitmap);
  End;
End;

procedure TfrmMain.TrayIconClick(Sender: TObject);
begin

  show;

  application.BringToFront;

end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmMain.imgToolsClick(Sender: TObject);
begin

  // pMenuTools.Popup(left + imgTools.left + 15, top + imgTools.top + 15);

  // pMenuTools.Popup(left + imgTools.left, Top + imgTools.Top + imgTools.Height);

  CheckCreateForm(TfrmPopup, frmPopup, 'frmPopup');

  frmPopup.SetComponents(1, Left + imgTools.Left, Top + imgTools.Top);

  frmPopup.show;

end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmMain.imgToolsMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ToolsIcon_MouseDown := True;
  ToolsIcon_DrawState;
end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmMain.imgToolsMouseEnter(Sender: TObject);
begin
  ToolsIcon_MouseIn := True;
  ToolsIcon_TranparentValue := 0;
  If m_GlowEffect = True Then
  Begin
    tmrBtnTools.Enabled := True;
  End
  Else
  Begin
    ToolsIcon_DrawState;
  End;
end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmMain.imgToolsMouseLeave(Sender: TObject);
begin
  ToolsIcon_MouseIn := False;
  ToolsIcon_MouseDown := False;
  ToolsIcon_TranparentValue := 0;
  If m_GlowEffect Then
  Begin
    tmrBtnTools.Enabled := True;
  End
  Else
  Begin
    ToolsIcon_DrawState;
  End;
end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmMain.imgToolsMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ToolsIcon_MouseDown := False;
  ToolsIcon_DrawState;
end;
{$ENDREGION}
{ ****************************** N E W    P A R T ****************************** }

end.
