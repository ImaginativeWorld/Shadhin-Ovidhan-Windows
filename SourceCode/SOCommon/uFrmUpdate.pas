{
 *******************************************************************
 This Source Code Form is subject to the terms of the Mozilla Public
 License, v. 2.0. If a copy of the MPL was not distributed with this
 file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *******************************************************************
}

{$INCLUDE ../ProjectDefines.inc}
unit uFrmUpdate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmUpdate = class(TForm)
    Panel1: TPanel;
    lblTitle: TLabel;
    lblDis: TLabel;
    btnDownload: TButton;
    btnLater: TButton;

    procedure UpdateWinRefresh(const strTitle: string; const strDis: string;
      const strColor: string; const strDlLink: string = 'no');

    procedure btnLaterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDownloadClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUpdate: TfrmUpdate;

  strDlUrl: string;

implementation

{$R *.dfm}

uses
  uFunctions,
  uUpdateCheck,
  ufrmAbout,
  uTextStrings;

procedure TfrmUpdate.btnDownloadClick(Sender: TObject);
begin

  Open_URL('http://' + strDlUrl);

  self.Close;

end;

procedure TfrmUpdate.btnLaterClick(Sender: TObject);
begin

  self.Close;

end;

procedure TfrmUpdate.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  FreeAndNil(Updater);

  Action := caFree;

  frmUpdate := Nil;

end;

procedure TfrmUpdate.FormCreate(Sender: TObject);
begin

  // Set Application Default Dir
  AppDir := ExtractFilePath(Application.ExeName);

  if ParamStr(1) <> '-about' then
  begin

    // Updater
    Updater := TUpdateCheck.Create;

    if ParamStr(1) = '-notsilent' then
    begin

      UpdateSilent := False;

    end;

    if Updater.IsConnected then
    begin

      if UpdateSilent then
        Updater.CheckSilent
      else
        Updater.Check;

    end
    else
    begin

      if UpdateSilent = False then
      begin

        UpdateWinRefresh('ত্রুটি!', //
          'কোন ইন্টারনেট সংযোগ নেই!', 'R');

        // UpdateWinRefresh  //
        // ('স্বাধীন অভিধানের নতুন আপডেট পাওয়া গেছে!',
        // 'আপনি চালাচ্ছেন সংস্করণ : ' + AppVersionInfo + //
        // #10 + 'প্রাপ্ত নতুন সংস্করণ : ' + //
        // '2.0.0.0' + //
        // #10 + 'উন্মুক্তকরণের তারিখ : ' + //
        // '16/12/13' + //
        // #10 + #10 + //
        // 'ডাউনলোড করতে ডাউনলোড বাটনে ক্লিক করুন।', 'G');

        self.show;

      end;

    end;

  end
  else
  begin

    strVersion := AppVersionInfo //
{$IFDEF BetaVersion} + strVersionAddiText {$ENDIF}{$IFDEF PortableOn} + ' (Portable)'
{$ENDIF};

  end;

end;

procedure TfrmUpdate.FormShow(Sender: TObject);
begin
  Application.BringToFront;
end;

procedure TfrmUpdate.UpdateWinRefresh(const strTitle: string;
  const strDis: string; const strColor: string;
  const strDlLink: string = 'no');
begin

  begin
    lblTitle.Caption := strTitle;
    lblDis.Caption := strDis;

    if strColor = 'G' then
      lblTitle.Color := $002FFFAD
    else if strColor = 'O' then
      lblTitle.Color := $0001B1F2
    else if strColor = 'R' then
      lblTitle.Color := clRed;

    if strDlLink <> 'no' then
    begin

      btnLater.Caption := 'পরে';

      btnDownload.Visible := True;

      strDlUrl := strDlLink;

    end;
  end;

  self.show;

end;

end.
