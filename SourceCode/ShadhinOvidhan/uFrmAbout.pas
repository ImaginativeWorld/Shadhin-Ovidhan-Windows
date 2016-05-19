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
    Label1: TLabel;
    btnChkUpdate: TButton;
    lblLicense: TLabel;
    memoLicense: TMemo;
    JvTransparentButton1: TJvTransparentButton;
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
  uUpdateCheck;

{ -=-=-=-=-=-=-=-=-=-[ N E W    P A R T ]-=-=-=-=-=-=-=-=-=- }

procedure TfrmAbout.tmrFadeTimer(Sender: TObject);
begin

  LabelFadeEffect(lblCredits, tmrFade, 13);

end;

{ -=-=-=-=-=-=-=-=-=-[ N E W    P A R T ]-=-=-=-=-=-=-=-=-=- }

procedure TfrmAbout.btnChkUpdateClick(Sender: TObject);
begin

 if Updater.IsConnected then
  begin

    Updater.Check;

  end
  else
  Begin
    Application.MessageBox('No internet conncetion available!', 'Oops!',
      MB_OK + MB_ICONINFORMATION + MB_SYSTEMMODAL);
  End;

end;

procedure TfrmAbout.btnExitClick(Sender: TObject);
begin
  self.Close;
end;

{ -=-=-=-=-=-=-=-=-=-[ N E W    P A R T ]-=-=-=-=-=-=-=-=-=- }

procedure TfrmAbout.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  DistroyLabelFadeEffect;

  Action := caFree;

  frmAbout := Nil;

end;

{ -=-=-=-=-=-=-=-=-=-[ N E W    P A R T ]-=-=-=-=-=-=-=-=-=- }

procedure TfrmAbout.FormCreate(Sender: TObject);

begin
  lblVersion.Caption := strVersion;

  memoLicense.Height := 277;
end;

{ -=-=-=-=-=-=-=-=-=-[ N E W    P A R T ]-=-=-=-=-=-=-=-=-=- }

procedure TfrmAbout.FormShow(Sender: TObject);
var
  CreditsText: String;

begin
  lblCredits.Caption := '';

  CreditsText := //
    'People behind this incredible product...|' //

      + //

      'Development, Documentation,' + #10 + //
      'Maintenance, Graphics' + #10 + //
      'and Programming' + #10 + //
      '______________________________' + #10 + //
      'Md. Mahmudul Hasan (Shohag)' + #10 + //
      'CEO of Imaginative World|'

      + //

      'Data Entry' + #10 + //
      '______________________________' + #10 + //
      'Md. Mahmudul Hasan (Shohag)|'

      + //

      'Hosting Support' + #10 + //
      '______________________________' + #10 + //
      'Dhrubok All Rounder' + #10 + //
      '(http://service.luckyfm.info)|'

      + //

      '3rd Party components|'

      + //

      'Complex Script Installer' + #10 + //
      '______________________________' + #10 + //
      'M.M. Rifat-Un-Nabi' + #10 + //
      '(http://www.vistaarc.com)|'

      + //

      'Siyam Rupali (Font)' + #10 + //
      '______________________________' + #10 + //
      'Md. Tanbin Islam Siyam|'

      + //

      'Nirmala UI (Font) and Segoe UI (Font)' + #10 + //
      '______________________________' + #10 + //
      '© Microsoft Corporation.|'

      + //

      'ICS' + #10 + //
      '(http://www.overbyte.be/)|'

      + //

      'Delphi Jedi (JVCL and JCL)' + #10 + //
      '(http://www.delphi-jedi.org/)|'

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
      'Shadhin Ovidhan.|'

      + //

      'Unicode is a trademark of' + #10 + //
      'Unicode, Inc' + #10 + //
      'http://www.unicode.org|'

      + //

      'Shadhin Ovidhan 2x' + #10 + //
      'Copyright © Imaginative World' + #10 + //
      'iwproducts.wordpress.com'; //

  ReadyFadeEffect(CreditsText);

  tmrFade.Interval := 50;
  tmrFade.Enabled := True;
end;

{ -=-=-=-=-=-=-=-=-=-[ N E W    P A R T ]-=-=-=-=-=-=-=-=-=- }

procedure TfrmAbout.imgFBClick(Sender: TObject);
begin

  Execute_Something('http://www.facebook.com/Imaginative.World.BD');

end;

{ -=-=-=-=-=-=-=-=-=-[ N E W    P A R T ]-=-=-=-=-=-=-=-=-=- }

procedure TfrmAbout.imgGPlusClick(Sender: TObject);
begin
  Execute_Something('http://gplus.to/ImaginativeWorld');
end;

{ -=-=-=-=-=-=-=-=-=-[ N E W    P A R T ]-=-=-=-=-=-=-=-=-=- }

procedure TfrmAbout.imgTwitterClick(Sender: TObject);
begin
  Execute_Something('http://www.twitter.com/IW_BD');
end;

{ -=-=-=-=-=-=-=-=-=-[ N E W    P A R T ]-=-=-=-=-=-=-=-=-=- }

procedure TfrmAbout.imgWSiteClick(Sender: TObject);
begin
  Execute_Something('http://iwwintricks.wordpress.com');
end;

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

{ -=-=-=-=-=-=-=-=-=-[ N E W    P A R T ]-=-=-=-=-=-=-=-=-=- }

end.
