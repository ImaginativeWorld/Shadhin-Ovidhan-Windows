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
    imgBG: TImage;
    pnlList: TPanel;
    imgListBtn: TImageList;
    imgExit: TImage;
    imgAbout: TImage;
    imgHeader: TImage;
    strGridMain: TJvStringGrid;
    imgSpeak: TImage;
    eAbbrSrc: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    lblDis: TLabel;
    imgIWlogo: TImage;

    procedure SearchNow;

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
    procedure eAbbrSrcChange(Sender: TObject);
    procedure ControlMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure imgMouseEnter(Sender: TObject);
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

  strAbbr: String;

  { Voice }
  voice: OLEVariant;

implementation

{$R *.dfm}

uses
  uRegistry,
  ufunctions,
  uTextStrings;

procedure TfrmMain.CreateParams(var Params: TCreateParams);
const
  CS_DROPSHADOW = $00020000;
begin
  inherited;
  Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.eAbbrSrcChange(Sender: TObject);
begin

  if (eAbbrSrc.Text <> '') then
  begin

    SearchNow;

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.SearchNow;
var
  SrcSQL: string;
  strTxt: string;

  slDBpath: string;
  sldb: TSQLiteDatabase;
  intIndex: Integer;

begin

  strGridMain.Clear;

  strTxt := stringreplace
    (stringreplace(stringreplace(stringreplace(eAbbrSrc.Text, //
          ' ', '', [rfReplaceAll, rfIgnoreCase]), //
        '-', '', [rfReplaceAll, rfIgnoreCase]), //
      '.', '', [rfReplaceAll, rfIgnoreCase]), //
    '''', '', [rfReplaceAll, rfIgnoreCase]);

  SrcSQL := 'WHERE Letters LIKE ''' + strTxt + '%''';

  try
    { Loading Database }
    slDBpath := ExtractFilepath(application.exename) + 'IW.DB.SO.Abbr.dll';

    sldb := TSQLiteDatabase.Create(slDBpath);

    intIndex := 0;

    { query the data }
    sltb := sldb.GetTable('SELECT * FROM tblAbbr ' + SrcSQL);

    strGridMain.RowCount := sltb.Count + 1;

    strGridMain.Cols[0].Text := 'Letters';
    strGridMain.Cols[1].Text := 'Section';
    strGridMain.Cols[2].Text := 'Abbreviation';

    if sltb.Count > 0 then
    begin

      while (intIndex <> sltb.Count) do
      begin

        strGridMain.Cols[0].add(sltb.FieldAsString(sltb.FieldIndex['Letters']));
        strGridMain.Cols[1].add(sltb.FieldAsString(sltb.FieldIndex['Section']));
        strGridMain.Cols[2].add(sltb.FieldAsString
            (sltb.FieldIndex['Abbreviation']));

        sltb.Next;

        inc(intIndex);

      end;

    end;

  finally
    sldb.Free;

  end;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.FormCreate(Sender: TObject);
var
  slDBpath: string;
  sldb: TSQLiteDatabase;

  intIndex: Integer;

  { Shaped Form }
  ShapeBG: HRGN;

  { Registry }
  Reg: TMyRegistry;
  intVoiceRate: Integer;
begin

  { Shaped Form }
  ShapeBG := CreateRoundRectRgn(0, 0, 700, 500, 7, 7);
  // ( Left, Top, Width, Height, Circle -, Circle | )

  SetWindowRgn(Handle, ShapeBG, true);

  DeleteObject(ShapeBG);

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
  slDBpath := ExtractFilepath(application.exename) + 'IW.DB.SO.Abbr.dll';

  sldb := TSQLiteDatabase.Create(slDBpath);

  intIndex := 0;

  try
    { query the data }
    sltb := sldb.GetTable('SELECT * FROM tblAbbr');

    strGridMain.RowCount := sltb.Count + 1;

    // Load DB
    // **********************************************************************
    strGridMain.Cols[0].Text := 'Letters';
    strGridMain.Cols[1].Text := 'Section';
    strGridMain.Cols[2].Text := 'Abbreviation';

    strGridMain.RowHeights[0] := 26;
    strGridMain.ColWidths[0] := 100;
    strGridMain.ColWidths[1] := 80;
    strGridMain.ColWidths[2] := 490;

    if sltb.Count > 0 then
    begin

      while (intIndex <> sltb.Count) do
      begin

        // lstBoxNames.Items.add(sltb.FieldAsString(sltb.FieldIndex['BnName']));

        strGridMain.Cols[0].add(sltb.FieldAsString(sltb.FieldIndex['Letters']));
        strGridMain.Cols[1].add(sltb.FieldAsString(sltb.FieldIndex['Section']));
        strGridMain.Cols[2].add(sltb.FieldAsString
            (sltb.FieldIndex['Abbreviation']));

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
          'If you think this is a problem then please let us know about this problem.')
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
      end
      else if Name = 'imgSpeak' then
      begin
        imgSpeak.Picture := Nil;
        imgListBtn.GetBitmap(8, imgSpeak.Picture.Bitmap);
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
      end
      else if Name = 'imgSpeak' then
      begin
        imgSpeak.Picture := Nil;
        imgListBtn.GetBitmap(6, imgSpeak.Picture.Bitmap);
      end;
    end;
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.imgSpeakClick(Sender: TObject);
var
  str: string;
begin

  if strAbbr <> '' then
    voice.speak(strAbbr, 1);

end;

{ ****************************** N E W    P A R T ****************************** }

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

procedure TfrmMain.strGridMainDblClick(Sender: TObject);
begin
  if strAbbr <> '' then

    voice.speak(strAbbr, 1);
end;

{ ****************************** N E W    P A R T ****************************** }

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

  if ACol = 2 then
  begin

    // if length(strText) > 30 then
    if frmMain.Canvas.TextWidth(strText) > 490 then
    begin

      WrapText(strText);

      strGridMain.Canvas.FillRect(Rect);
      strGridMain.Canvas.TextOut(Rect.left + 5, Rect.top + 2, strLine[0]);
      strGridMain.Canvas.TextOut(Rect.left + 5, //
        Rect.top - strGridMain.Canvas.Font.Height + 7, strLine[1]);

      strLine[0] := '';
      strLine[1] := '';

    end
    else
    begin

      strGridMain.Canvas.FillRect(Rect);
      strGridMain.Canvas.TextOut(Rect.left + 5, Rect.top + 2, strText);

    end;

  end
  else
  begin
    strGridMain.Canvas.FillRect(Rect);
    strGridMain.Canvas.TextOut(Rect.left + 5, Rect.top + 2, strText);
  end;

  // strGridMain.Canvas.FillRect(Rect);
  // strGridMain.Canvas.TextOut(Rect.left + 2, Rect.top + 2, strText);

end;

procedure TfrmMain.ControlMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if Sender.ClassType = TJvStringGrid then
  begin
    lblDis.Caption := //
      'উচ্চারণ শুনতে লাইনের উপর ডাবল ক্লিক করুন';
  end
  else if Sender.ClassType = TImage then
  begin
    with (Sender as TImage) do
      if name = 'imgAbout' then
      begin
        lblDis.Caption := 'আমাদের সম্পর্কে';
      end
      else if Name = 'imgSpeak' then
      begin
        lblDis.Caption := 'উচ্চারণ শুনুন';
      end
      else if Name = 'imgExit' then
      begin
        lblDis.Caption := 'বন্ধ করুন';
      end
      else if Name = 'imgBG' then
      begin
        lblDis.Caption := 'প্রস্তুত';
      end
      else if Name = 'imgHeader' then
      begin
        lblDis.Caption := 'প্রস্তুত';
      end;

  end
  else if (Sender.ClassType = TEdit) then
  begin
    lblDis.Caption := //
      'অনুসন্ধানের জন্য এখানে বর্ণসমূহ লিখুন';
  end
  else if (Sender.ClassType = TPanel) or (Sender.ClassType = TLabel) then
  begin
    lblDis.Caption := 'প্রস্তুত';
  end;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.strGridMainSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  strAbbr := strGridMain.Cols[2].Strings[ARow];
end;

{ ****************************** N E W    P A R T ****************************** }

end.
