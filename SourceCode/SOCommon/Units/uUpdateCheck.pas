{
 *******************************************************************
 This Source Code Form is subject to the terms of the Mozilla Public
 License, v. 2.0. If a copy of the MPL was not distributed with this
 file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *******************************************************************
}

{$INCLUDE ../ProjectDefines.inc}
unit uUpdateCheck;

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
  TUpdateCheck = Class
  Private
    Downloader: THttpCli;
    MemS: TMemoryStream;
    StillDownloading: Boolean;
    Verbose: Boolean;

    Function IsUpdate(Const Major, Minor, Release, Build: Integer): Boolean;
    Procedure FinishDownload(Sender: TObject; RqType: THttpRequest;
      Error: Word);
  Public

    Function IsConnected: Boolean;
    Procedure Check;
    Procedure CheckSilent;
    Constructor Create;
    Destructor Destroy; Override;
  End;

Var
  Updater: TUpdateCheck;

Const
{$IFDEF BetaVersion}
  UpdateInfo = 'http://imaginativeworld.org/update/so/latestbetaver.iwconf';
  //UpdateInfo = 'http://localhost/update/so/latestbetaver.iwconf';
{$ELSE}
  UpdateInfo = 'http://imaginativeworld.org/update/so/latestver.iwconf';
  //UpdateInfo = 'http://localhost/update/so/latestver.iwconf';
{$ENDIF}

implementation

Uses
  uFunctions, uFrmUpdate;

{ ------------------------------------------------------ }

Procedure TUpdateCheck.Check;
Begin
  If StillDownloading Then
    exit
  Else
  Begin
    MemS := TMemoryStream.Create;

    Verbose := True;
    Downloader.URL := UpdateInfo;
    Downloader.RcvdStream := MemS;
    Downloader.GetASync;
    StillDownloading := True;
  End;
End;

{ ------------------------------------------------------ }

Procedure TUpdateCheck.CheckSilent;
Begin
  If StillDownloading Then
    exit
  Else
  Begin
    MemS := TMemoryStream.Create;

    Verbose := False;
    Downloader.URL := UpdateInfo;
    Downloader.RcvdStream := MemS;
    Downloader.GetASync;
    StillDownloading := True;
  End;
End;

{ ------------------------------------------------------ }

Constructor TUpdateCheck.Create;
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

{ ------------------------------------------------------ }

Destructor TUpdateCheck.Destroy;
Begin
  FreeAndNil(Downloader);
  Inherited;
End;

{ ------------------------------------------------------ }
{$HINTS Off}

Procedure TUpdateCheck.FinishDownload(Sender: TObject; RqType: THttpRequest;
  Error: Word);
var
  GetData, GetVersion: TStringList;
  Major, Minor, Release, Build: Integer;
  VersionData, DownloadURL, ReleaseDate: String;
  MsgResult: Integer;

Begin

  StillDownloading := False;

  If (Downloader.StatusCode = 200) And (Error = 0) Then
  Begin

    Try
      Try
        GetData := TStringList.Create;
        Split('|', String(MemoryStreamToString(MemS)), GetData);

        // 0.0.0.0|www.example.com|01-January-2014

        VersionData := GetData[0];
        DownloadURL := GetData[1];
        ReleaseDate := GetData[2];

        GetData.Destroy; // Leak Protection

        GetVersion := TStringList.Create;

        Split('.', VersionData, GetVersion);

        Major := strtoint(GetVersion[0]);
        Minor := strtoint(GetVersion[1]);
        Release := strtoint(GetVersion[2]);
        Build := strtoint(GetVersion[3]);

        GetVersion.Destroy; // Leak Protection

      Except
        On e: exception Do
        Begin
          If Verbose Then

            frmUpdate.UpdateWinRefresh('ত্রুটি!',
              'হালনাগাদ করণে একটি সমস্যা হয়েছে।' + #10 +
                'পরে আবার চেষ্টা করুন।' + #10 + #10 + //
                'ত্রুটি সংকেত : B3F023DL', 'R')
          else
            frmUpdate.Close;

          // Application.MessageBox(
          // 'There was an error checking update for Shadhin Ovidhan.' + #10 +
          // 'Please try again later.' + #10 + #10 + //
          // 'Error Code: B3F023DL', 'Ooops!',
          // MB_OK + MB_ICONHAND + MB_DEFBUTTON1 + MB_SYSTEMMODAL);
          exit;
        End;
      End;
    Finally
      FreeAndNil(MemS);
    End;

    If IsUpdate(Major, Minor, Release, Build) = True Then
    Begin

      // frmDic.tmrUpdateCheck.Enabled := False;

      frmUpdate.UpdateWinRefresh //
        ('স্বাধীন অভিধানের নতুন আপডেট পাওয়া গেছে!',
        'আপনি চালাচ্ছেন সংস্করণ : ' +
          AppVersionInfo + //
          #10 + 'প্রাপ্ত নতুন সংস্করণ : ' + //
          IntToStr(Major) + '.' + IntToStr(Minor) + '.' + IntToStr(Release)
          + '.' + IntToStr(Build) + //
          #10 + 'উন্মুক্তকরণের তারিখ : ' + //
          StringReplace(ReleaseDate, '-', ' ', [rfReplaceAll, rfIgnoreCase]) +
        //
          #10 + #10 + //
          'ডাউনলোড করতে ডাউনলোড বাটনে ক্লিক করুন।', 'G', DownloadURL);


      // MsgResult := MessageDlg
      // ('New update of Shadhin Ovidhan are available!' + SLineBreak +
      // SLineBreak + 'You are running version: ' + AppVersionInfo +
      // SLineBreak + 'Available updated version: ' + IntToStr
      // (Major) + '.' + IntToStr(Minor) + '.' + IntToStr(Release)
      // + '.' + IntToStr(Build) + SLineBreak + 'Release date: ' +
      // StringReplace(ReleaseDate, '-', ' ', [rfReplaceAll, rfIgnoreCase])
      // + SLineBreak + SLineBreak +
      // 'Would you like to download new version now?', mtInformation,
      // mbYesNo, 0);
      //
      // if MsgResult = mrYes then
      // begin
      // Execute_Something('http://' + DownloadURL);
      // end;

    End
    Else
    Begin
      If Verbose Then

        frmUpdate.UpdateWinRefresh('আপনি সর্বশেষ সংস্করণ ব্যবহার করছেন!',
          'কোন নতুন আপডেট নেই!', 'G')
      else
        frmUpdate.Close;

      // Application.MessageBox(
      // 'You are using the latest version of Shadhin Ovidhan.' + #10 +
      // 'No update is available at this moment', 'Shadhin Ovidhan',
      // MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_SYSTEMMODAL);

      // frmDic.tmrUpdateCheck.Enabled := False;
    End;
  End
  Else
  Begin
    If Verbose Then

      frmUpdate.UpdateWinRefresh('ত্রুটি!',
        'হালনাগাদ করণে একটি সমস্যা হয়েছে।' + #10 + 'পরে আবার চেষ্টা করুন।' +
          #10 + #10 + //
          'ত্রুটি সংকেত : 4FT32DL', 'R')

    else
      frmUpdate.Close;


    // Application.MessageBox(
    // 'There was an error checking update for Shadhin Ovidhan.' + #10 +
    // 'Please try again later.' + #10 + #10 + //
    // 'Error Code: 4FT32DL', 'Shadhin Ovidhan :: Ooops!',
    // MB_OK + MB_ICONHAND + MB_DEFBUTTON1 + MB_SYSTEMMODAL);

    FreeAndNil(MemS);
  End;

End;

{ ------------------------------------------------------ }

Function TUpdateCheck.IsConnected: Boolean;
Var
  dwConnectionTypes: DWORD;
Begin
  Result := False;
  dwConnectionTypes := INTERNET_CONNECTION_MODEM + INTERNET_CONNECTION_LAN +
    INTERNET_CONNECTION_PROXY;

  Result := InternetGetConnectedState(@dwConnectionTypes, 0);
End;

{ ------------------------------------------------------ }

Function TUpdateCheck.IsUpdate(Const Major, Minor, Release, Build: Integer)
  : Boolean;
Begin

  SetVersionInfo;

  Result := False;

  Begin
    If Major > AppVerMajor Then
    Begin
      Result := True;
    End
    Else If Major = AppVerMajor Then
    Begin
      If Minor > AppVerMinor Then
      Begin
        Result := True;
      End
      Else If Minor = AppVerMinor Then
      Begin
        If Release > AppVerRelease Then
        Begin
          Result := True;
        End
        Else If Release = AppVerRelease Then
        Begin
          If Build > AppVerBuild Then
          Begin
            Result := True;
          End;
        End;
      End;
    End;
  End;

End;

end.
