{
 *******************************************************************
 This Source Code Form is subject to the terms of the Mozilla Public
 License, v. 2.0. If a copy of the MPL was not distributed with this
 file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *******************************************************************
}

unit uNewsCheck;

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
  Controls,
  Registry;

Type
  TNewsCheck = Class
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
  NewsUpdater: TNewsCheck;

  NewsNbr: string;

Const

  UpdateInfo = 'http://imaginativeworld.org/update/so/news.iwconf';
  //UpdateInfo = 'http://localhost/update/so/news.iwconf';

implementation

Uses
  uFunctions, uFrmMain;

{ ****************************** N E W    P A R T ****************************** }

Procedure TNewsCheck.Check;
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

Constructor TNewsCheck.Create;
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

Destructor TNewsCheck.Destroy;
Begin
  FreeAndNil(Downloader);
  Inherited;
End;

{ ****************************** N E W    P A R T ****************************** }
{$HINTS Off}

Procedure TNewsCheck.FinishDownload(Sender: TObject; RqType: THttpRequest;
  Error: Word);
var
  // GetData, GetVersion: TStringList;
  GetData: TStringList;
  // Major, Minor, Release, Build: Integer;
  // VersionData, DownloadURL, ReleaseDate: String;

  frmHeight, frmWidth: integer;
  IsShow: Boolean;
  NewsURL: string;

  MsgResult: integer;

  { Registry }
  Reg: TMyRegistry;
  confNewsNumber: integer;

Begin

  StillDownloading := False;

  If (Downloader.StatusCode = 200) And (Error = 0) Then
  Begin

    Try
      Try

        GetData := TStringList.Create;

        SplitStrings(String(MemoryStreamToString(MemS)), '|', GetData);

        // ShowOrNot(0 or 1)|News Number|Height|Width|News URL (with http)

        // NOTE: use full url (with "http://")

        IsShow := strtobool(GetData[0]);
        NewsNbr := GetData[1];
        frmHeight := strtoint(GetData[2]);
        frmWidth := strtoint(GetData[3]);
        NewsURL := GetData[4];

        GetData.Destroy; // Leak Protection

      Except
        On e: exception Do
        Begin

          frmMain.close;

          // exit;
        End;
      End;
    Finally
      FreeAndNil(MemS);
    End;

    if IsShow then
    begin

      begin
        Reg := TMyRegistry.Create;
        Reg.RootKey := HKEY_CURRENT_USER;

        If Reg.OpenKey('Software\Imaginative World\Shadhin Ovidhan', True)
          = True Then
        Begin

          confNewsNumber := strtoint(Reg.ReadStringDef('NewsNumber', '0'));

        End;
        Reg.Free;
      end;

      if strtoint(NewsNbr) <> confNewsNumber then
      begin

        begin
          Reg := TMyRegistry.Create;
          Reg.RootKey := HKEY_CURRENT_USER;
          If Reg.OpenKey('Software\Imaginative World\Shadhin Ovidhan', True)
            = True Then
          Begin

            Reg.WriteString('NewsNumber', NewsNbr);

          End;

          Reg.Free;
        end;

        with frmMain do
        begin

          Height := frmHeight;
          width := frmWidth;

          // lbltitle.caption := frmTitle + ' (খবর নং : ' + NewsNbr + ')';

          // lbltitle.left := width div 2 - lbltitle.width div 2;
          lblHeader.left := width div 2 - lblHeader.width div 2;

          // WB_LoadHTML(WB1, HTMLcode);

          WB_LoadHTML(WB1, '<!doctype html><body><br><br><br><br><br>' + //
              '<p align=center> কয়েক সেকেন্ড অপেক্ষা করুন... </p></body>');

          WB1.Navigate(Pchar(NewsURL));

          show;

        end;

      end
      else
      begin

        FreeAndNil(MemS);

        frmMain.close;

      end;

    end
    else
    begin

      FreeAndNil(MemS);

      frmMain.close;

    end;

  End
  Else
  Begin

    FreeAndNil(MemS);

    frmMain.close;

  End;

End;

{ ****************************** N E W    P A R T ****************************** }

Function TNewsCheck.IsConnected: Boolean;
Var
  dwConnectionTypes: DWORD;
Begin
  Result := False;
  dwConnectionTypes := INTERNET_CONNECTION_MODEM + INTERNET_CONNECTION_LAN +
    INTERNET_CONNECTION_PROXY;

  Result := InternetGetConnectedState(@dwConnectionTypes, 0);
End;

{ ****************************** N E W    P A R T ****************************** }

end.
