{
 *******************************************************************
 This Source Code Form is subject to the terms of the Mozilla Public
 License, v. 2.0. If a copy of the MPL was not distributed with this
 file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *******************************************************************
}

unit uFrmMain;

interface

uses
  Windows,
  SQLiteTable3,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  StdCtrls,
  Grids,
  ImgList, pngimage,
  ShellAPI;

type
  TfrmMain = class(TForm)
    imgBG: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    pnlInfo: TPanel;
    pnlList: TPanel;
    lstBoxNames: TListBox;
    pnlBnMeaning: TPanel;
    pnlEnMeaning: TPanel;
    PanelBG: TPanel;
    PnlBnMinBG: TPanel;
    PnlEnMinBG: TPanel;
    lblEnMeaning: TLabel;
    lblBnMeaning: TLabel;
    lblArName: TLabel;
    lblEnName: TLabel;
    lblInfo: TLabel;
    imgListBtn: TImageList;
    imgExit: TImage;
    imgAbout: TImage;
    lblBnName: TLabel;
    imgHeader: TImage;
    imgIWlogo: TImage;

    procedure updateFields;
    Procedure Execute_Something(Const xFile: String; const xParam: String = '');
    Procedure Open_URL(Const xURL: String);

    procedure pnlTopMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure lstBoxNamesClick(Sender: TObject);
    procedure imgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure imgMouseLeave(Sender: TObject);
    procedure imgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgExitClick(Sender: TObject);
    procedure imgAboutClick(Sender: TObject);
    procedure imgIWlogoClick(Sender: TObject);
  private
    { Private declarations }

    sltb: TSQLIteTable;

  public
    { Public declarations }

  protected
    procedure CreateParams(var Params: TCreateParams); override;

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  uTextStrings;

procedure TfrmMain.CreateParams(var Params: TCreateParams);
const
  CS_DROPSHADOW = $00020000;
begin
  inherited;
  Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.FormCreate(Sender: TObject);
var
  slDBpath: string;
  sldb: TSQLiteDatabase;

  intIndex: Integer;

  { Shaped Form }
  ShapeBG: HRGN;
begin

  { Shaped Form }
  ShapeBG := CreateRoundRectRgn(0, 0, 650, 450, 7, 7);
  // ( Left, Top, Width, Height, Circle -, Circle | )

  SetWindowRgn(Handle, ShapeBG, true);

  DeleteObject(ShapeBG);

  { Loading Database }
  slDBpath := ExtractFilepath(application.exename) + 'IW.DB.99Names.dll';

  sldb := TSQLiteDatabase.Create(slDBpath);

  intIndex := 0;

  try
    { query the data }
    sltb := sldb.GetTable('SELECT * FROM tblNames');

    if sltb.Count > 0 then
    begin

      { display first row }
      updateFields;

      while (intIndex <> 100) do
      begin

        lstBoxNames.Items.add(sltb.FieldAsString(sltb.FieldIndex['BnName']));

        sltb.Next;

        inc(intIndex);

      end;

    end;

  finally
    sldb.Free;

  end;

  imgListBtn.GetBitmap(0, imgExit.Picture.Bitmap);
  imgListBtn.GetBitmap(3, imgAbout.Picture.Bitmap);

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.imgAboutClick(Sender: TObject);
begin
  if FileExists(ExtractFilepath(application.exename) + 'SOCommon.exe') then
  begin

    ShellExecute(application.Handle, 'open',
      Pchar(ExtractFilepath(application.exename) + 'SOCommon.exe'), '-about',
      Pchar(ExtractFilepath(application.exename)), SW_SHOWNORMAL);
  end
  else
  begin
    application.MessageBox(Pchar('Error Description:' + #10 +
          'Some executable file of Shadhin Ovidhan not found!' + #10 + #10 +
          #10 + 'Please reinstall Shadhin Ovidhan.' + #10 + #10 + #10 +
          'If you think this is a Bug then please let us know about this problem.')
        , 'Shadhin Ovidhan | Info',
      MB_OK + MB_ICONHAND + MB_DEFBUTTON1 + MB_APPLMODAL);
  end;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.imgExitClick(Sender: TObject);
begin
  self.Close;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.imgIWlogoClick(Sender: TObject);
begin
  Open_URL(strLogoURL);
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.imgMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

  if Sender.ClassType = TImage then
  begin
    with Sender as TImage do
    begin
      if Name = 'imgExit' then
      begin
        imgExit.Picture := Nil;
        imgListBtn.GetBitmap(2, imgExit.Picture.Bitmap);
      end
      else if Name = 'imgAbout' then
      begin
        imgAbout.Picture := Nil;
        imgListBtn.GetBitmap(5, imgAbout.Picture.Bitmap);
      end;
    end;
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.imgMouseLeave(Sender: TObject);
begin

  if Sender.ClassType = TImage then
  begin
    with Sender as TImage do
    begin
      if Name = 'imgExit' then
      begin
        imgExit.Picture := Nil;
        imgListBtn.GetBitmap(0, imgExit.Picture.Bitmap);
      end
      else if Name = 'imgAbout' then
      begin
        imgAbout.Picture := Nil;
        imgListBtn.GetBitmap(3, imgAbout.Picture.Bitmap);
      end;
    end;
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.imgMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin

  if Sender.ClassType = TImage then
  begin
    with Sender as TImage do
    begin
      if Name = 'imgExit' then
      begin
        imgExit.Picture := Nil;
        imgListBtn.GetBitmap(1, imgExit.Picture.Bitmap);
      end
      else if Name = 'imgAbout' then
      begin
        imgAbout.Picture := Nil;
        imgListBtn.GetBitmap(4, imgAbout.Picture.Bitmap);
      end;
    end;
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.lstBoxNamesClick(Sender: TObject);
begin

  sltb.Moveto(lstBoxNames.ItemIndex);

  updateFields;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.updateFields;
begin

  lblBnName.Caption := sltb.FieldAsString(sltb.FieldIndex['BnName']);
  lblArName.Caption := sltb.FieldAsString(sltb.FieldIndex['ArName']);
  lblEnName.Caption := sltb.FieldAsString(sltb.FieldIndex['EnName']);

  lblBnMeaning.Caption := sltb.FieldAsString(sltb.FieldIndex['BnMeaning']);

  lblEnMeaning.Caption := sltb.FieldAsString(sltb.FieldIndex['EnMeaning']);

  lblInfo.Caption := 'কুরআনে এই নামের ব্যবহারঃ' //
    + ' [সুরার ক্রম নাম্বার : আয়াত নাম্বার]' //
    + #10 + sltb.FieldAsString(sltb.FieldIndex['Info']);

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlTopMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    TForm(frmMain).Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;

{ ****************************** N E W    P A R T ****************************** }
{$REGION '          Needed Functions          '}

Procedure TfrmMain.Execute_Something(Const xFile: String;
  const xParam: String = '');
Begin
  // ShellExecute(Application.handle, 'open', Pchar(xFile), Nil, Nil,
  // SW_SHOWNORMAL);

  if FileExists(xFile) then
    ShellExecute(0, 'open', Pchar(xFile), Pchar(xParam), Nil, SW_SHOWNORMAL)
  else
    application.MessageBox //
      (Pchar(strExeNotFound + #10 + #10 + strIfItBug + #10 + strIWEmail), //
      Pchar(Forms.application.Title),
      MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);

End;

{ ****************************** N E W    P A R T ****************************** }

Procedure TfrmMain.Open_URL(Const xURL: String);
Begin

  ShellExecute(0, 'open', Pchar(xURL), Nil, Nil, SW_SHOWNORMAL)

End;
{$ENDREGION}
{ ****************************** N E W    P A R T ****************************** }

end.
