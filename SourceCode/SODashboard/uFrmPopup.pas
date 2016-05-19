{
 *******************************************************************
 This Source Code Form is subject to the terms of the Mozilla Public
 License, v. 2.0. If a copy of the MPL was not distributed with this
 file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *******************************************************************
}

unit uFrmPopup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, pngimage;

type
  TfrmPopup = class(TForm)
    fPnlTools: TFlowPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    lblGTranslate: TLabel;
    lblBnCalendar: TLabel;
    lblBAK: TLabel;
    lblSOWizard: TLabel;
    lblFeedback: TLabel;
    fPnlHelp: TFlowPanel;
    Panel6: TPanel;
    Image6: TImage;
    lblHelp: TLabel;
    Panel7: TPanel;
    Image7: TImage;
    lblAbout: TLabel;

    procedure SetComponents(const PopupNumber, Left, Top: integer);

    procedure lblMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure lblMouseEnter(Sender: TObject);
    procedure lblMouseLeave(Sender: TObject);
    procedure lblMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure lblBAKClick(Sender: TObject);
    procedure lblSOWizardClick(Sender: TObject);
    procedure lblBnCalendarClick(Sender: TObject);
    procedure lblGTranslateClick(Sender: TObject);
    procedure lblFeedbackClick(Sender: TObject);
    procedure lblHelpClick(Sender: TObject);
    procedure lblAboutClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

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
  uFrmMain,
  uFunctions;

//procedure TfrmPopup.WMNCACTIVATE(var M: TWMNCACTIVATE);
//begin
//  inherited;
//  if M.Active = False then
//    self.close;
//end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmPopup.SetComponents(const PopupNumber, Left, Top: integer);
begin

  case PopupNumber of
    1:
      begin
        fPnlTools.Top := 2;
        fPnlTools.Left := 2;
        fPnlHelp.Visible := False;
        fPnlTools.Visible := true;
        self.Height := fPnlTools.Height + 4;
        self.Width := fPnlTools.Width + 4;
        self.Top := Top - self.Height;
        self.Left := Left;
      end;
    2:
      begin
        fPnlHelp.Top := 2;
        fPnlHelp.Left := 2;
        fPnlTools.Visible := False;
        fPnlHelp.Visible := true;
        self.Height := fPnlHelp.Height + 4;
        self.Width := fPnlHelp.Width + 4;
        self.Top := Top - self.Height;
        self.Left := Left;
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
  Execute_Something(AppDir + 'SOCommon.exe', '-about');
  close;
end;

procedure TfrmPopup.lblBAKClick(Sender: TObject);
begin
  Execute_Something(AppDir + 'Tools\SOBanglaAidKit.exe');
  close;
end;

procedure TfrmPopup.lblBnCalendarClick(Sender: TObject);
begin
  Execute_Something(AppDir + 'SOBanglaCalendar.exe');
  close;
end;

procedure TfrmPopup.lblFeedbackClick(Sender: TObject);
begin
  Execute_Something(AppDir + 'SOFeedback.exe');
  close;
end;

procedure TfrmPopup.lblGTranslateClick(Sender: TObject);
begin
  Execute_Something(AppDir + 'SOGTranslate.exe');
  close;
end;

procedure TfrmPopup.lblHelpClick(Sender: TObject);
begin
  Execute_Something(AppDir + 'SOHelp.exe');
  close;
end;

procedure TfrmPopup.lblSOWizardClick(Sender: TObject);
begin
  Execute_Something(AppDir + 'SOPortableWizard.exe');
  close;
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
