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
    imgBG:          TImage;
    pnlBnList:      TPanel;
    lstBoxBnNames:  TListBox;
    imgListBtn:     TImageList;
    imgExit:        TImage;
    imgAbout:       TImage;
    imgHeader:      TImage;
    eBangla:        TEdit;
    pnlSciList:     TPanel;
    lstBoxSciNames: TListBox;
    eScientific:    TEdit;
    lblBnName:      TLabel;
    lblSciName:     TLabel;
    Panel1:         TPanel;
    Panel2:         TPanel;
    imgIWlogo:      TImage;
    Label1:         TLabel;
    Panel3:         TPanel;
    rBtnBn:         TRadioButton;
    rBtnEn:         TRadioButton;
    Label2:         TLabel;
    Panel4:         TPanel;
    rBtnB: TRadioButton;
    rBtnZ: TRadioButton;
    rBtnBZ:         TRadioButton;

    procedure updateFields(const WhatList: string);
    procedure Execute_Something(const xFile: string; const xParam: string = '');
    procedure Open_URL(const xURL: string);
    procedure UpdateList(const xSQL: string);

    procedure pnlTopMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure FormCreate(Sender: TObject);
    procedure lstBoxBnNamesClick(Sender: TObject);
    procedure imgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure imgMouseLeave(Sender: TObject);
    procedure imgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure imgExitClick(Sender: TObject);
    procedure imgAboutClick(Sender: TObject);
    procedure eScientificEnter(Sender: TObject);
    procedure eBanglaEnter(Sender: TObject);
    procedure imgIWlogoClick(Sender: TObject);
    procedure rBtnSortClick(Sender: TObject);
    procedure rBtnListClick(Sender: TObject);
    procedure eBanglaKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure eScientificKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);

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

  { DB path }
  slDBpath: string;

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

procedure TfrmMain.eBanglaEnter(Sender: TObject);
begin
  eScientific.Text := '';
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.eBanglaKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
var
  tmpPChar: PChar;
begin
  begin
    GetMem(tmpPChar, Length(eBangla.Text) + 1);
    StrPCopy(tmpPChar, eBangla.Text);
    lstBoxBnNames.Perform(LB_SELECTSTRING, 0, longint(tmpPChar));
    FreeMem(tmpPChar, Length(eBangla.Text) + 1);
  end;

  updateFields('Bn');

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.eScientificEnter(Sender: TObject);
begin
  eBangla.Text := '';
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.eScientificKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
var
  tmpPChar: PChar;
begin
  begin

    GetMem(tmpPChar, Length(eScientific.Text) + 1);
    StrPCopy(tmpPChar, eScientific.Text);
    lstBoxSciNames.Perform(LB_SELECTSTRING, 0, longint(tmpPChar));
    FreeMem(tmpPChar, Length(eScientific.Text) + 1);

  end;

  updateFields('Sci');

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.FormCreate(Sender: TObject);
var
  sldb: TSQLiteDatabase;

  intIndex: integer;

  { Shaped Form }
  ShapeBG: HRGN;
begin

  { Shaped Form }
  ShapeBG := CreateRoundRectRgn(0, 0, 600, 450, 7, 7);
  // ( Left, Top, Width, Height, Circle -, Circle | )

  SetWindowRgn(Handle, ShapeBG, True);

  DeleteObject(ShapeBG);

  { Loading Database }
  slDBpath := ExtractFilepath(application.exename) + 'IW.DB.ScientificNames.dll';

  sldb := TSQLiteDatabase.Create(slDBpath);

  intIndex := 0;

  try
    { query the data }
    sltb := sldb.GetTable('SELECT * FROM TblSciName ORDER BY English ASC');

    if sltb.Count > 0 then
    begin

      { display first row }
      // updateFields;

      while (intIndex <> sltb.Count) do
      begin

        begin
          lstBoxBnNames.Items.add(sltb.FieldAsString(sltb.FieldIndex['Bangla'])
            );
          lstBoxSciNames.Items.add
          (sltb.FieldAsString(sltb.FieldIndex['English']));
        end;

        sltb.Next;

        Inc(intIndex);

      end;

    end;

  finally
    sldb.Free;

  end;

  imgListBtn.GetBitmap(0, imgExit.Picture.Bitmap);
  imgListBtn.GetBitmap(3, imgAbout.Picture.Bitmap);

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.lstBoxBnNamesClick(Sender: TObject);
begin

  if Sender.ClassType = TListBox then
  begin
    with Sender as TListBox do
    begin

      if Name = 'lstBoxBnNames' then
      begin
        sltb.Moveto(lstBoxBnNames.ItemIndex);
        updateFields('Bn');
      end
      else if Name = 'lstBoxSciNames' then
      begin
        sltb.Moveto(lstBoxSciNames.ItemIndex);
        updateFields('Sci');
      end;

    end;
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.updateFields(const WhatList: string);
var
  intIndex: integer;
begin
  if WhatList = 'Bn' then
  begin

    lstBoxSciNames.ItemIndex := lstBoxBnNames.ItemIndex;

    intIndex := lstBoxBnNames.ItemIndex;

  end
  else if WhatList = 'Sci' then
  begin

    lstBoxBnNames.ItemIndex := lstBoxSciNames.ItemIndex;

    intIndex := lstBoxSciNames.ItemIndex;

  end;

  begin

    if intIndex <> -1 then
    begin

      lblBnName.Caption := lstBoxBnNames.Items.Strings[intIndex];
      lblBnName.Hint := lstBoxBnNames.Items.Strings[intIndex];

      lblSciName.Caption := lstBoxSciNames.Items.Strings[intIndex];
      lblSciName.Hint := lstBoxSciNames.Items.Strings[intIndex];
    end;
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.imgAboutClick(Sender: TObject);
begin
  if FileExists(ExtractFilepath(application.exename) + 'SOCommon.exe') then
  begin

    ShellExecute(application.Handle, 'open',
      PChar(ExtractFilepath(application.exename) + 'SOCommon.exe'), '-about',
      PChar(ExtractFilepath(application.exename)), SW_SHOWNORMAL);
  end
  else
  begin
    application.MessageBox(PChar('Error Description:' + #10 +
      'Some executable file of Shadhin Ovidhan not found!' + #10 +
      #10 + #10 + 'Please reinstall Shadhin Ovidhan.' + #10 + #10 +
      #10 + 'If you think this is a problem then please let us know about this problem.')
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
  Shift: TShiftState; X, Y: integer);
begin

  if Sender.ClassType = TImage then
  begin
    with Sender as TImage do
    begin
      if Name = 'imgExit' then
      begin
        imgExit.Picture := nil;
        imgListBtn.GetBitmap(2, imgExit.Picture.Bitmap);
      end
      else if Name = 'imgAbout' then
      begin
        imgAbout.Picture := nil;
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
        imgExit.Picture := nil;
        imgListBtn.GetBitmap(0, imgExit.Picture.Bitmap);
      end
      else if Name = 'imgAbout' then
      begin
        imgAbout.Picture := nil;
        imgListBtn.GetBitmap(3, imgAbout.Picture.Bitmap);
      end;
    end;
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.imgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin

  if Sender.ClassType = TImage then
  begin
    with Sender as TImage do
    begin
      if Name = 'imgExit' then
      begin
        imgExit.Picture := nil;
        imgListBtn.GetBitmap(1, imgExit.Picture.Bitmap);
      end
      else if Name = 'imgAbout' then
      begin
        imgAbout.Picture := nil;
        imgListBtn.GetBitmap(4, imgAbout.Picture.Bitmap);
      end;
    end;
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.pnlTopMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    TForm(frmMain).Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.rBtnListClick(Sender: TObject);
var
  SortOrder: string;
begin

  if (rBtnBn.Checked) then
  begin

    SortOrder := 'Bangla';

  end
  else
  begin

    SortOrder := 'English';

  end;

  if ((Sender as TRadioButton).Name = 'rBtnZ') then
  begin

    UpdateList('SELECT * FROM TblSciName WHERE Section = "Z" ORDER BY ' +
      SortOrder + ' ASC');

  end
  else if ((Sender as TRadioButton).Name = 'rBtnB') then
  begin

    UpdateList('SELECT * FROM TblSciName WHERE Section = "B" ORDER BY ' +
      SortOrder + ' ASC');
  end
  else if ((Sender as TRadioButton).Name = 'rBtnBZ') then
  begin

    UpdateList('SELECT * FROM TblSciName ORDER BY ' + SortOrder + ' ASC');

  end;
end;

procedure TfrmMain.rBtnSortClick(Sender: TObject);
begin

  if ((Sender as TRadioButton).Name = 'rBtnBn') then
  begin

    UpdateList('SELECT * FROM TblSciName ORDER BY Bangla ASC');

  end
  else if ((Sender as TRadioButton).Name = 'rBtnEn') then
  begin

    UpdateList('SELECT * FROM TblSciName ORDER BY English ASC');

  end;
end;

procedure TfrmMain.UpdateList(const xSQL: string);
var
  sldb: TSQLiteDatabase;
  intIndex: integer;
begin
  {Clearing list boxes}
  lstBoxBnNames.Clear;
  lstBoxSciNames.Clear;

  sldb := TSQLiteDatabase.Create(slDBpath);

  intIndex := 0;

  try
    { query the data }
    sltb := sldb.GetTable(xSQL);

    if sltb.Count > 0 then
    begin

      while (intIndex <> sltb.Count) do
      begin

        begin
          lstBoxBnNames.Items.add(sltb.FieldAsString(sltb.FieldIndex['Bangla'])
            );
          lstBoxSciNames.Items.add
          (sltb.FieldAsString(sltb.FieldIndex['English']));
        end;

        sltb.Next;

        Inc(intIndex);

      end;

    end;

  finally
    sldb.Free;

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

{$REGION '          Needed Functions          '}

procedure TfrmMain.Execute_Something(const xFile: string; const xParam: string = '');
begin
  // ShellExecute(Application.handle, 'open', Pchar(xFile), Nil, Nil,
  // SW_SHOWNORMAL);

  if FileExists(xFile) then
    ShellExecute(0, 'open', PChar(xFile), PChar(xParam), nil, SW_SHOWNORMAL)
  else
    application.MessageBox
    (PChar(strExeNotFound + #10 + #10 + strIfItBug + #10 + strIWEmail),
      PChar(Forms.application.Title),
      MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMain.Open_URL(const xURL: string);
begin

  ShellExecute(0, 'open', PChar(xURL), nil, nil, SW_SHOWNORMAL);

end;

{$ENDREGION}

{ ****************************** N E W    P A R T ****************************** }

end.

