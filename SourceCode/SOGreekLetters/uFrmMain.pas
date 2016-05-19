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
  ShellAPI, JvExGrids, JvStringGrid,
  Comobj;

type
  TfrmMain = class(TForm)
    imgListBtn: TImageList;
    imgExit: TImage;
    imgAbout: TImage;
    strGridMain: TJvStringGrid;
    imgSpeak: TImage;
    pnlDown: TPanel;
    spGreenLine: TShape;

    Procedure Execute_Something(Const xFile: String; const xParam: String = '');

    procedure pnlTopMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure imgMouseLeave(Sender: TObject);
    procedure imgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgExitClick(Sender: TObject);
    procedure imgAboutClick(Sender: TObject);
    procedure strGridMainDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure imgSpeakClick(Sender: TObject);
    procedure strGridMainDblClick(Sender: TObject);
    procedure strGridMainSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ControlMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure imgMouseEnter(Sender: TObject);
  private
    { Private declarations }

    sltb: TSQLIteTable;

  public
    { Public declarations }

    // protected
    // procedure CreateParams(var Params: TCreateParams); override;

  end;

var
  frmMain: TfrmMain;

  strAbbr: String;

  { Voice }
  voice: OLEVariant;

implementation

{$R *.dfm}

uses
  uRegistry,
  uTextStrings;

// procedure TfrmMain.CreateParams(var Params: TCreateParams);
// const
// CS_DROPSHADOW = $00020000;
// begin
// inherited;
// Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
// end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  slDBpath: string;
  sldb: TSQLiteDatabase;

  intIndex: Integer;

  { Shaped Form }
  // ShapeBG: HRGN;

  { Registry }
  Reg: TMyRegistry;
  intVoiceRate: Integer;
begin

  { Shaped Form }
  // ShapeBG := CreateRoundRectRgn(0, 0, 700, 500, 7, 7);
  // // ( Left, Top, Width, Height, Circle -, Circle | )
  //
  // SetWindowRgn(Handle, ShapeBG, true);
  //
  // DeleteObject(ShapeBG);

  { Voice }
  voice := CreateOLEObject('SAPI.SpVoice');

  { Speech Rate }
  begin
    Reg := TMyRegistry.Create;
    Reg.RootKey := HKEY_CURRENT_USER;

    If Reg.OpenKey('Software\Imaginative World\Shadhin Ovidhan', true)
      = true Then
    Begin
      intVoiceRate := strtoint(Reg.ReadStringDef('SpeechRate', '0'));
    End;

    Reg.Free;
  end;

  voice.rate := intVoiceRate;

  { Loading Database }
  slDBpath := ExtractFilepath(application.exename) + 'IW.DB.GreekLetters.dll';

  sldb := TSQLiteDatabase.Create(slDBpath);

  intIndex := 0;

  try
    { query the data }
    sltb := sldb.GetTable('SELECT * FROM tblGrkLetter');

    strGridMain.RowCount := sltb.Count + 1;

    // Load DB
    // **********************************************************************
    strGridMain.Cols[0].Text := 'Capital';
    strGridMain.Cols[1].Text := 'Small';
    strGridMain.Cols[2].Text := 'Pronounce';

    strGridMain.RowHeights[0] := 25;
    strGridMain.ColWidths[0] := 110;
    strGridMain.ColWidths[1] := 110;
    strGridMain.ColWidths[2] := 130;

    if sltb.Count > 0 then
    begin

      while (intIndex <> sltb.Count) do
      begin

        // lstBoxNames.Items.add(sltb.FieldAsString(sltb.FieldIndex['BnName']));

        strGridMain.Cols[0].add(sltb.FieldAsString(sltb.FieldIndex['CLetter']));
        strGridMain.Cols[1].add(sltb.FieldAsString(sltb.FieldIndex['SLetter']));
        strGridMain.Cols[2].add(sltb.FieldAsString(sltb.FieldIndex['Pronounce'])
          );

        sltb.Next;

        inc(intIndex);

      end;

    end;

  finally
    sldb.Free;

  end;

  imgListBtn.GetBitmap(0, imgExit.Picture.Bitmap);
  imgListBtn.GetBitmap(3, imgAbout.Picture.Bitmap);
  imgListBtn.GetBitmap(6, imgSpeak.Picture.Bitmap);

end;

// ****************************** N E W    P A R T ******************************

procedure TfrmMain.imgAboutClick(Sender: TObject);
begin

  Execute_Something(ExtractFilepath(application.exename) + 'SOCommon.exe',
    '-about');

end;

procedure TfrmMain.imgExitClick(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmMain.imgMouseEnter(Sender: TObject);
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
      end
      else if Name = 'imgSpeak' then
      begin
        imgSpeak.Picture := Nil;
        imgListBtn.GetBitmap(7, imgSpeak.Picture.Bitmap);
      end;
    end;
  end;

end;

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
      end
      else if Name = 'imgSpeak' then
      begin
        imgSpeak.Picture := Nil;
        imgListBtn.GetBitmap(8, imgSpeak.Picture.Bitmap);
      end;
    end;
  end;

end;

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
      end
      else if Name = 'imgSpeak' then
      begin
        imgSpeak.Picture := Nil;
        imgListBtn.GetBitmap(6, imgSpeak.Picture.Bitmap);
      end;
    end;
  end;

end;

procedure TfrmMain.imgSpeakClick(Sender: TObject);
begin
  if strAbbr <> '' then

    voice.speak(strAbbr, 1);
end;

// ****************************** N E W    P A R T ******************************

procedure TfrmMain.pnlTopMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    TForm(frmMain).Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;

procedure TfrmMain.strGridMainDblClick(Sender: TObject);
begin
  if strAbbr <> '' then

    voice.speak(strAbbr, 1);
end;

procedure TfrmMain.strGridMainDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  strText: String;
begin

  strText := strGridMain.Cells[ACol, ARow];

  // Select Row Coloring
  if (gdSelected in State) then
  begin

    strGridMain.Canvas.Brush.Color := $00EEEEEE;

  end
  else
  begin

    strGridMain.Canvas.Brush.Color := clWhite;

  end;

  strGridMain.Canvas.FillRect(Rect);
  strGridMain.Canvas.TextOut(Rect.left + 2, Rect.top + 2, strText);

end;

procedure TfrmMain.ControlMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if Sender.ClassType = TJvStringGrid then
  begin
    pnlDown.Caption := //
      'উচ্চারণ শুনতে ডাবল ক্লিক করুন';
  end
  else if Sender.ClassType = TImage then
  begin
    with (Sender as TImage) do
      if name = 'imgAbout' then
      begin
        pnlDown.Caption := 'আমাদের সম্পর্কে';
      end
      else if Name = 'imgSpeak' then
      begin
        pnlDown.Caption := 'উচ্চারণ শুনুন';
      end
      else if Name = 'imgExit' then
      begin
        pnlDown.Caption := 'বন্ধ করুন';
      end;
  end
  else if (Sender.ClassType = TPanel) or (Sender.ClassType = TfrmMain) then
  begin
    pnlDown.Caption := 'প্রস্তুত';
  end;

end;

procedure TfrmMain.strGridMainSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  strAbbr := strGridMain.Cols[2].Strings[ARow];
end;

{ ****************************** N E W    P A R T ****************************** }
{$REGION '          Needed Functions          '}

Procedure TfrmMain.Execute_Something(Const xFile: String;
  const xParam: String = '');
Begin
  // ShellExecute(Application.handle, 'open', Pchar(xFile), Nil, Nil,
  // SW_SHOWNORMAL);

  if FileExists(xFile) then
    ShellExecute(0, 'open', PChar(xFile), PChar(xParam), Nil, SW_SHOWNORMAL)
  else
    application.MessageBox //
      (PChar(strExeNotFound + #10 + #10 + strIfItBug + #10 + strIWEmail), //
      PChar(Forms.application.Title),
      MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);

End;
{$ENDREGION}
{ ****************************** N E W    P A R T ****************************** }

end.
