{
 *******************************************************************
 This Source Code Form is subject to the terms of the Mozilla Public
 License, v. 2.0. If a copy of the MPL was not distributed with this
 file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *******************************************************************
}

unit uFrmAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, StdCtrls, JvExExtCtrls, JvSecretPanel, ImgList,
  JvExControls, JvButton, JvTransparentButton;

type
  TfrmAbout = class(TForm)
    imgBG: TImage;
    lblVersion: TLabel;
    imgFB: TImage;
    imgGPlus: TImage;
    imgTwitter: TImage;
    imgWSite: TImage;
    lblCredits: TLabel;
    tmrFade: TTimer;
    btnChkUpdate: TButton;
    lblLicense: TLabel;
    memoLicense: TMemo;
    JvTBtnOK: TJvTransparentButton;
    imgListBtn: TImageList;

    // procedure CreditsFade;
    // procedure DoFade;

    procedure FormCreate(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgFBClick(Sender: TObject);
    procedure imgGPlusClick(Sender: TObject);
    procedure imgTwitterClick(Sender: TObject);
    procedure imgWSiteClick(Sender: TObject);
    procedure tmrFadeTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnChkUpdateClick(Sender: TObject);
    procedure lblLicenseClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;
  intColor: integer;
  intText: integer;
  strTextList: TStringList;

implementation

{$R *.dfm}

uses
  uFunctions,
  uLabelFadeEffect,
  uUpdateCheck,
  uFrmUpdate,
  uTextStrings;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmAbout.btnChkUpdateClick(Sender: TObject);
begin

  Execute_Something(AppDir + 'SOCommon.exe', '-notsilent');
  btnChkUpdate.Enabled := false;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmAbout.btnExitClick(Sender: TObject);
begin

  frmUpdate.Close;

  // self.Close;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmAbout.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  DistroyLabelFadeEffect;

  Action := caFree;

  frmAbout := Nil;

  frmUpdate.Close;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmAbout.FormCreate(Sender: TObject);

begin

  lblVersion.Caption := 'Version: ' + strVersion;

  memoLicense.Height := 290;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmAbout.FormShow(Sender: TObject);
var
  CreditsText: String;

begin
  lblCredits.Caption := '';

  CreditsText := //
    'People behind this incredible product...' + //
    '|'

    + //

    'Development, Documentation,' + #10 + //
    'Maintenance, Graphics' + #10 + //
    'and Programming' + #10 + //
    '______________________________' + #10 + //
    'Md. Mahmudul Hasan Shohag' + //
    '|'

    + //

    'Data Entry' + #10 + //
    '______________________________' + #10 + //
    'Md. Mahmudul Hasan Shohag' + //
    '|'

    + //

    'Hosting Support' + #10 + //
    '______________________________' + #10 + //
    'Dhrubok All Rounder' + #10 + //
    '(http://dhrubokallrounder.com)' + //
    '|'

    + //

    '3rd Party components' + //
    '|'

    + //

    'Avro Keyboard - Open Source Project' + #10 + //
    '______________________________' + #10 + //
    'Copyright © OmicoronLab.' + #10 + //
    '(http://www.omicronlab.com)' + //
    '|'

    + //

    'Complex Script Installer' + #10 + //
    '______________________________' + #10 + //
    'M.M. Rifat-Un-Nabi' + #10 + //
    '(http://www.vistaarc.com)' + //
    '|'

    + //

    'Siyam Rupali (Font) and Kalpurush (Font)' + #10 + //
    '______________________________' + #10 + //
    'Md. Tanbin Islam Siyam' + //
    '|'

    + //

    'Nirmala UI (Font) and Segoe UI (Font)' + #10 + //
    '______________________________' + #10 + //
    '© Microsoft Corporation' + //
    '|'

    + //

    'DISQLite3' + #10 + //
    '(http://www.yunqa.de/)' + //
    '|'

    + //

    'ICS' + #10 + //
    '(http://www.overbyte.be/)' + //
    '|'

    + //

    'Delphi Jedi (JVCL and JCL)' + #10 + //
    '(http://www.delphi-jedi.org/)' + //
    '|'

    + //

    'Thanks' + #10 + //
    '______________________________' + #10 + //
    'Our heartiest thanks' + #10 + //
    'to all of them' + #10 + //
    'who are relentlessly helping us' + #10 + //
    'by providing us with' + #10 + //
    'valuable comments,' + #10 + //
    'feedback and suggestions' + #10 + //
    'with a view to improving' + #10 + //
    'Shadhin Ovidhan.' + //
    '|'

    + //

    'Special Credits' + #10 + //
    '______________________________' + #10 + //
    'Mesba Uddin (LuckyFM)' + //
    '|'

    + //

    'Contributors (by asc. order)' + #10 + //
    '______________________________' + #10 + //
    'Md. Shameem Reza' + #10 + //
    'Zakir Hossain Irfan' + //
    '|'

    + //

    'Unicode is a trademark of' + #10 + //
    'Unicode, Inc' + #10 + //
    'http://www.unicode.org' + //
    '|'

    + //

    'Shadhin Ovidhan™ 2x' + #10 + //
    'Copyright © Imaginative World™' + #10 + //
    'http://imaginativeworld.org'; //

  ReadyFadeEffect(CreditsText);

  tmrFade.Interval := 50;
  tmrFade.Enabled := True;

  Application.BringToFront;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmAbout.tmrFadeTimer(Sender: TObject);
begin

  LabelFadeEffect(lblCredits, tmrFade, 17);

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmAbout.imgFBClick(Sender: TObject);
begin

  Open_URL('http://www.facebook.com/Imaginative.World.BD');

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmAbout.imgGPlusClick(Sender: TObject);
begin
  Open_URL('http://gplus.to/ImaginativeWorld');
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmAbout.imgTwitterClick(Sender: TObject);
begin
  Open_URL('http://www.twitter.com/IW_BD');
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmAbout.imgWSiteClick(Sender: TObject);
begin
  Open_URL(strLogoURL);
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmAbout.lblLicenseClick(Sender: TObject);
begin
  if lblLicense.Caption = 'License Information' then
  begin
    lblLicense.Caption := 'View Credit';
    memoLicense.Visible := True;
    tmrFade.Enabled := False;
  end
  else
  begin
    lblLicense.Caption := 'License Information';
    memoLicense.Visible := False;
    tmrFade.Enabled := True;
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

end.
