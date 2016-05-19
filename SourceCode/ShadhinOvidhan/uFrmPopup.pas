{
 *******************************************************************
 This Source Code Form is subject to the terms of the Mozilla Public
 License, v. 2.0. If a copy of the MPL was not distributed with this
 file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *******************************************************************
}

{$INCLUDE ../ProjectDefines.inc}
unit uFrmPopup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls;

type
  TfrmPopup = class(TForm)
    fPnlTools: TFlowPanel;
    Panel1: TPanel;
    Image1: TImage;
    lblBnCalendar: TLabel;
    Panel2: TPanel;
    Image2: TImage;
    lblBAK: TLabel;
    Panel3: TPanel;
    Image3: TImage;
    lblOptions: TLabel;
    Panel5: TPanel;
    Image4: TImage;
    lblSOAndroid: TLabel;
    fPnlFont: TFlowPanel;
    pnlSiyamRupali: TPanel;
    Image5: TImage;
    lblSiyamRupali: TLabel;
    pnlKalpurush: TPanel;
    Image6: TImage;
    lblKalpurush: TLabel;
    Panel7: TPanel;
    Image7: TImage;
    lblNirmalaUI: TLabel;
    Panel8: TPanel;
    lblFontSmall: TLabel;
    lblFontBig: TLabel;
    Panel9: TPanel;
    lblFontName: TLabel;
    Label3: TLabel;
    Panel10: TPanel;
    lblFontSize: TLabel;
    Label2: TLabel;
    Panel11: TPanel;
    pnlMukti: TPanel;
    Image8: TImage;
    lblMukti: TLabel;
    pnlLohit: TPanel;
    Image9: TImage;
    lblLohit: TLabel;
    Panel4: TPanel;
    Image10: TImage;
    lblAbout: TLabel;

    procedure SetComponents(const PopupNumber, Left, Top: integer);

    procedure lblMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure lblMouseEnter(Sender: TObject);
    procedure lblMouseLeave(Sender: TObject);
    procedure lblMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDeactivate(Sender: TObject);
    procedure lblBnCalendarClick(Sender: TObject);
    procedure lblBAKClick(Sender: TObject);
    procedure lblOptionsClick(Sender: TObject);
    procedure lblAboutClick(Sender: TObject);
    procedure lblSiyamRupaliClick(Sender: TObject);
    procedure lblKalpurushClick(Sender: TObject);
    procedure lblNirmalaUIClick(Sender: TObject);
    procedure lblFontSmallClick(Sender: TObject);
    procedure lblFontBigClick(Sender: TObject);
    procedure lblMuktiClick(Sender: TObject);
    procedure lblLohitClick(Sender: TObject);
    procedure lblSOAndroidClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    //procedure WMNCACTIVATE(var M: TWMNCACTIVATE); message WM_NCACTIVATE;
  end;

var
  frmPopup: TfrmPopup;

implementation

{$R *.dfm}

uses
  ufrmDic,
  ufunctions,
  uFrmOptions,
  uTextStrings;

//procedure TfrmPopup.WMNCACTIVATE(var M: TWMNCACTIVATE);
//begin
//  inherited;
////  if M.Active = False then
////    self.close;
//end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmPopup.SetComponents(const PopupNumber, Left, Top: integer);
begin

  case PopupNumber of
    1: { Tool Menu }
      begin
        fPnlTools.Top := 2;
        fPnlTools.Left := 2;

        { Hide Other Menus }
        fPnlFont.Visible := False;

        fPnlTools.Visible := true;
        self.Height := fPnlTools.Height + 4;
        self.Width := fPnlTools.Width + 4;
        self.Top := Top - self.Height;
        self.Left := Left;
      end;

    2: { Font Menu }
      begin
        fPnlFont.Top := 2;
        fPnlFont.Left := 2;

        { Hide Other Menus }
        fPnlTools.Visible := False;

        fPnlFont.Visible := true;
        self.Height := fPnlFont.Height + 4;
        self.Width := fPnlFont.Width + 4;
        self.Top := Top - self.Height;
        self.Left := Left;

        { Set Components }
        lblFontSize.caption := inttostr(confOvidhanFontSize);
        lblFontName.caption := confOvidhanFont;

        { Check Font Status }
        {$IFDEF PortableOn}
        pnlKalpurush.Enabled := False;
        pnlKalpurush.Font.Color := clgray;

        pnlLohit.Enabled := False;
        pnlLohit.Font.Color := clgray;

        pnlMukti.Enabled := False;
        pnlMukti.Font.Color := clgray;

        pnlSiyamRupali.Enabled := False;
        pnlSiyamRupali.Font.Color := clgray;
        {$ENDIF}

      end;
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmPopup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;

  frmPopup := Nil;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmPopup.FormDeactivate(Sender: TObject);
begin
  close;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmPopup.lblAboutClick(Sender: TObject);
begin
  execute_something(appdir + 'SOCommon.exe', '-about');
  close;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmPopup.lblBAKClick(Sender: TObject);
begin

  {$IFDEF PortableOn}
    Execute_Something(appdir + 'SOBanglaAidKit.exe');
  {$ELSE}
    Execute_Something(appdir + 'Tools\SOBanglaAidKit.exe');
  {$ENDIF}

  close;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmPopup.lblBnCalendarClick(Sender: TObject);
begin
  execute_something(appdir + 'SOBanglaCalendar.exe');
  close;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmPopup.lblOptionsClick(Sender: TObject);
begin

  CheckCreateForm(TfrmOptions, frmOptions, 'frmOptions');

  close;

  frmOptions.Show;
  frmDic.Enabled := False;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmPopup.lblSiyamRupaliClick(Sender: TObject);
begin

  frmDic.ChangeFont('Siyam Rupali');

  close;

end;

procedure TfrmPopup.lblSOAndroidClick(Sender: TObject);
begin

  Open_URL(strSOAndroidURL);

  close;

end;

procedure TfrmPopup.lblKalpurushClick(Sender: TObject);
begin

  frmDic.ChangeFont('Kalpurush');

  close;

end;

procedure TfrmPopup.lblNirmalaUIClick(Sender: TObject);
begin

  frmDic.ChangeFont('Nirmala UI');

  close;

end;

procedure TfrmPopup.lblMuktiClick(Sender: TObject);
begin

  frmDic.ChangeFont('MuktiNarrow');

  close;

end;

procedure TfrmPopup.lblLohitClick(Sender: TObject);
begin

  frmDic.ChangeFont('Ekushey Lohit');

  close;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmPopup.lblFontSmallClick(Sender: TObject);
begin

  if confOvidhanFontSize > 8 then
  begin
    confOvidhanFontSize := confOvidhanFontSize - 1;
    frmDic.ChangeFont(confOvidhanFont);
    lblFontSize.caption := inttostr(confOvidhanFontSize);
  end;

end;

procedure TfrmPopup.lblFontBigClick(Sender: TObject);
begin

  if confOvidhanFontSize < 16 then
  begin
    confOvidhanFontSize := confOvidhanFontSize + 1;
    frmDic.ChangeFont(confOvidhanFont);
    lblFontSize.caption := inttostr(confOvidhanFontSize);
  end;

end;

{ ****************************** N E W    P A R T ****************************** }
{$REGION '          Panal and Label Appearance         '}

procedure TfrmPopup.lblMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin

  if Sender.ClassType = TLabel then
  begin

  ((Sender as TLabel).Parent as TPanel)
    .Font.Color := clWhite;

((Sender as TLabel).Parent as TPanel)
    .Color := clBlack;

  end
  else if Sender.ClassType = TImage then
  begin

  ((Sender as TImage).Parent as TPanel)
    .Font.Color := clWhite;

((Sender as TImage).Parent as TPanel)
    .Color := clBlack;

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmPopup.lblMouseEnter(Sender: TObject);
begin

  if Sender.ClassType = TLabel then
  begin

  ((Sender as TLabel).Parent as TPanel)
    .Font.Color := clBlack;

((Sender as TLabel).Parent as TPanel)
    .Color := $00DEDEDE;

  end
  else if Sender.ClassType = TImage then
  begin

  ((Sender as TImage).Parent as TPanel)
    .Font.Color := clBlack;

((Sender as TImage).Parent as TPanel)
    .Color := $00DEDEDE;

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmPopup.lblMouseLeave(Sender: TObject);
begin

  if Sender.ClassType = TLabel then
  begin

  ((Sender as TLabel).Parent as TPanel)
    .Font.Color := clBlack;

((Sender as TLabel).Parent as TPanel)
    .Color := clWhite;

  end
  else if Sender.ClassType = TImage then
  begin

  ((Sender as TImage).Parent as TPanel)
    .Font.Color := clBlack;

((Sender as TImage).Parent as TPanel)
    .Color := clWhite;

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmPopup.lblMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin

  if Sender.ClassType = TLabel then
  begin

  ((Sender as TLabel).Parent as TPanel)
    .Font.Color := clBlack;

((Sender as TLabel).Parent as TPanel)
    .Color := $00DEDEDE;

  end
  else if Sender.ClassType = TImage then
  begin

  ((Sender as TImage).Parent as TPanel)
    .Font.Color := clBlack;

((Sender as TImage).Parent as TPanel)
    .Color := $00DEDEDE;

  end;

end;
{$ENDREGION}
{ ****************************** N E W    P A R T ****************************** }

end.
