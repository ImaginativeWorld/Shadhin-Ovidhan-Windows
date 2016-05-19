{
 *******************************************************************
 This Source Code Form is subject to the terms of the Mozilla Public
 License, v. 2.0. If a copy of the MPL was not distributed with this
 file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *******************************************************************
}

unit uUrlCheck;

interface

uses
  SysUtils,
  Classes,
  Windows,
  DateUtils,
  Forms,
  OverbyteIcsWndControl,
  OverbyteIcsHttpProt,
  Wininet,
  Dialogs,
  Controls;

Type
  TUrlCheck = Class
  Private
    Downloader: THttpCli;
    MemS: TMemoryStream;
    StillDownloading: Boolean;
    // Verbose: Boolean;

    // Function IsUpdate(Const Major, Minor, Release, Build: Integer): Boolean;
    Procedure FinishDownload(Sender: TObject; RqType: THttpRequest;
      Error: Word);
  Public

    Function IsConnected: Boolean;
    Procedure Check;
    // Procedure CheckSilent;
    Constructor Create;
    Destructor Destroy; Override;
  End;

Var
  UrlUpdater: TUrlCheck;

  NewsNbr: string;

Const

  UpdateInfo = 'http://imaginativeworld.org/update/so/feedback.iwconf';
  //UpdateInfo = 'http://localhost/so/feedback.iwconf';

implementation

Uses
  uFunctions, uFrmMain;

{ ****************************** N E W    P A R T ****************************** }

Procedure TUrlCheck.Check;
Begin
  If StillDownloading Then
    exit
  Else
  Begin
    MemS := TMemoryStream.Create;

    // Verbose := True;
    Downloader.URL := UpdateInfo;
    Downloader.RcvdStream := MemS;
    Downloader.GetASync;
    StillDownloading := True;
  End;
End;

{ ****************************** N E W    P A R T ****************************** }

Constructor TUrlCheck.Create;
Begin
  // Execute the parent (TObject) constructor first
  Inherited; // Call the parent Create method
  Downloader := THttpCli.Create(Nil);
  Downloader.RequestVer := '1.0';
  Downloader.Agent := 'User-Agent: Shadhin Ovidhan';
  Downloader.NoCache := True;
  Downloader.OnRequestDone := FinishDownload;

  StillDownloading := False;
End;

{ ****************************** N E W    P A R T ****************************** }

Destructor TUrlCheck.Destroy;
Begin
  FreeAndNil(Downloader);
  Inherited;
End;

{ ****************************** N E W    P A R T ****************************** }
{$HINTS Off}

Procedure TUrlCheck.FinishDownload(Sender: TObject; RqType: THttpRequest;
  Error: Word);
var
  // GetData, GetVersion: TStringList;
  GetData: TStringList;
  // Major, Minor, Release, Build: Integer;
  // VersionData, DownloadURL, ReleaseDate: String;

  frmHeight, frmWidth: integer;
  // IsShow: Boolean;
  FeedbackURL: string;

  MsgResult: integer;

  strErrHtml: string;

Begin

  StillDownloading := False;

  If (Downloader.StatusCode = 200) And (Error = 0) Then
  Begin

    Try
      Try

        GetData := TStringList.Create;
        // Split('|', String(MemoryStreamToString(MemS)), GetData);

        SplitStrings(String(MemoryStreamToString(MemS)), '|', GetData);

        // Height|Width|URL (with Http)

        frmHeight := strtoint(GetData[0]);
        frmWidth := strtoint(GetData[1]);
        FeedbackURL := GetData[2];

        GetData.Destroy; // Leak Protection

        with frmMain do
        begin
          Height := frmHeight;
          Width := frmWidth;

          lblHeader.left := Width div 2 - lblHeader.Width div 2;

          strMainURL := FeedbackURL;

          WB1.Navigate(Pchar(strMainURL));
        end;

      Except
        On e: exception Do
        Begin

          strErrHtml := //
            strHTMLStartThings + //
            '<br><br><br><br>' + //
            strProgramDes + //
            '<br><br><br><br>' + //
            '<span style="font-size:250%;">' + //
            '<p style="text-align: center;">' + 'ত্রুটি!!</p></span>' + //
            '<br>' + //
            '<p>ত্রুটি কোডঃ 20003</p>' + //
            '<br>' + //
            '<p>বার্তাঃ</p>' + //
            '<br>' + //
            '<p>' + e.ToString + '</p>' + //
            strHTMLEndThings;

          WB_LoadHTML(frmMain.WB1, strErrHtml);

          // exit;
        End;
      End;
    Finally
      FreeAndNil(MemS);
    End;

  End
  Else
  Begin

    FreeAndNil(MemS);

    strErrHtml := //
      strHTMLStartThings + //
      '<br><br><br><br>' + //
      strProgramDes + //
      '<br><br><br><br>' + //
      '<span style="font-size:250%;">' + //
      '<p style="text-align: center;">' + 'ত্রুটি!!</p></span>' + //
      '<br>' + //
      '<p>ত্রুটি কোডঃ 20002</p>' + //
      strHTMLEndThings;

    WB_LoadHTML(frmMain.WB1, strErrHtml);

  End;

End;

{ ****************************** N E W    P A R T ****************************** }

Function TUrlCheck.IsConnected: Boolean;
Var
  dwConnectionTypes: DWORD;
Begin
  Result := False;
  dwConnectionTypes := INTERNET_CONNECTION_MODEM + INTERNET_CONNECTION_LAN +
    INTERNET_CONNECTION_PROXY;

  Result := InternetGetConnectedState(@dwConnectionTypes, 0);
End;

end.
