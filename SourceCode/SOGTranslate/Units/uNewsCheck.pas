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
  Controls;

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

  UpdateInfo = 'http://localhost/shohag/SONewsV2.iwconf';

  // http://luckyfm.info/shohag/SO/SONewsV2.iwconf
  // http://localhost/shohag/SONewsV2.iwconf

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

Begin

  StillDownloading := False;

  If (Downloader.StatusCode = 200) And (Error = 0) Then
  Begin

    Try
      Try

        GetData := TStringList.Create;
        // Split('|', String(MemoryStreamToString(MemS)), GetData);

        SplitStrings(String(MemoryStreamToString(MemS)), '|', GetData);

        // ShowOrNot(0 or 1)|News Number|Height|Width|Title|HTML
        // ShowOrNot(0 or 1)|News Number|Height|Width|News URL

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

      with frmMain do
      begin
        Height := frmHeight;
        width := frmWidth;

        // lbltitle.caption := frmTitle + ' (খবর নং : ' + NewsNbr + ')';

        // lbltitle.left := width div 2 - lbltitle.width div 2;
        lblHeader.left := width div 2 - lblHeader.width div 2;

        // WB_LoadHTML(WB1, HTMLcode);

        WB1.Navigate(Pchar('http://' + NewsURL));

        show;

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

end.
