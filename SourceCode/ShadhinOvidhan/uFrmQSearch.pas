{
 *******************************************************************
 This Source Code Form is subject to the terms of the Mozilla Public
 License, v. 2.0. If a copy of the MPL was not distributed with this
 file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *******************************************************************
}

unit uFrmQSearch;

interface

uses
  ClipBrd, // Clipboard
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, JvComponentBase, JvFormTransparent,
  StdCtrls, Grids, DBGrids, JvExDBGrids, ComObj,
  ImgList, JvTransparentButton, JvExControls, JvButton, DISQLite3Database,
  DISQLite3Api, JvExGrids, JvStringGrid, Menus, JvExStdCtrls, JvMemo;

type
  TfrmQSearch = class(TForm)
    imgBG: TImage;
    txtSrc: TEdit;
    JvTForm: TJvTransparentForm;
    btnClose: TJvTransparentButton;
    imgListBtn: TImageList;
    btnGoBack: TJvTransparentButton;
    strGSuggestion: TJvStringGrid;
    imgSrcReset: TImage;
    pMenuQSrc: TPopupMenu;
    mnuItmAddtoWORDMARKS: TMenuItem;
    mnuItmShowmyWORDMARDS: TMenuItem;
    N1: TMenuItem;
    imgOntop: TImage;
    mMeaning: TJvMemo;
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txtSrcChange(Sender: TObject);

    procedure ShowMeaning;
    procedure DBGSuggationCellClick(Column: TColumn);
    procedure PMexitClick(Sender: TObject);
    procedure txtSrcKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGoBackClick(Sender: TObject);

    procedure SetGridRow(const ARowIdx: Integer; const AID: Integer = -1;
      const AWord: UnicodeString = ''; const APOS: UnicodeString = '';
      const APron: UnicodeString = ''; const AMeaning: UnicodeString = '');
    procedure strGSuggestionSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);

    // Clipboard Viewer
    procedure WMDRAWCLIPBOARD(var Message: TMessage); message WM_DRAWCLIPBOARD;
    procedure WMCHANGECBCHAIN(var Message: TMessage); message WM_CHANGECBCHAIN;

    procedure FormDestroy(Sender: TObject);
    procedure imgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgMouseEnter(Sender: TObject);
    procedure imgMouseLeave(Sender: TObject);
    procedure imgMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgSrcResetClick(Sender: TObject);
    procedure mnuItmAddtoWORDMARKSClick(Sender: TObject);
    procedure mnuItmShowmyWORDMARDSClick(Sender: TObject);
    procedure imgOntopClick(Sender: TObject);
    procedure pMenuQSrcPopup(Sender: TObject);
    procedure strGSuggestionDblClick(Sender: TObject);
    procedure txtSrcKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }

    procedure SearchNow;
    procedure imgBtnReset(Sender: TObject);

  public
    { Public declarations }

  protected
    procedure CreateParams(var Params: TCreateParams); override;
    // Always On Top

  end;

var
  frmQSearch: TfrmQSearch;
  voice: OLEVariant;

  // Clipboard Viewer
  NextHandle: THandle;

  // Dic Strings
  // strWord: String;
  strPOS: string;
  strMeaning: string;

implementation

{$R *.dfm}

uses
  uFrmDic,
  uFunctions,
  uFrmWordmarks,
  uTextStrings;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmQSearch.CreateParams(var Params: TCreateParams); // Always On Top
begin
  inherited CreateParams(Params);
  Params.ExStyle := Params.ExStyle or WS_EX_TOPMOST;
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
  Params.WndParent := GetDesktopwindow;
end; // Params.ExStyle Or WS_EX_TOOLWINDOW And Not WS_EX_APPWINDOW;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmQSearch.btnCloseClick(Sender: TObject);
begin
  self.Close;

  frmDic.Close;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmQSearch.btnGoBackClick(Sender: TObject);
begin
  self.Close;

  TrimAppMemorySize;

  CheckCreateForm(TfrmDic, frmDic, 'frmDic');
  frmDic.show;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmQSearch.DBGSuggationCellClick(Column: TColumn);
begin
  ShowMeaning;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmQSearch.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;

  frmQSearch := nil;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmQSearch.FormCreate(Sender: TObject);
begin
  top := Screen.Height - Height - 50;
  left := Screen.Width - Width - 25;

  // Voice
  voice := CreateOLEObject('SAPI.SpVoice');

  { Set up the string grid. }
  strGSuggestion.ColCount := 3;

  // strGSuggestion.Options := strGSuggestion.Options + [goColSizing,
  // goThumbTracking];

  strGSuggestion.HideCol(1);
  strGSuggestion.HideCol(2);
  strGSuggestion.ColWidths[0] := 185;

  // Clipboard Viewer
  if confChkClipboard then
    NextHandle := SetClipboardViewer(handle);

  { Set Images }
  if confQSrcTop then
  begin

    TOPMOST(self.handle);

    imgListBtn.GetBitmap(7, imgOntop.Picture.Bitmap);

    confQSrcTop := True;

  end
  else
  begin

    NoTOPMOST(self.handle);

    imgListBtn.GetBitmap(6, imgOntop.Picture.Bitmap);

    confQSrcTop := False;

  end;

  { Set Hints }
  txtSrc.Hint := strSrcEditHint;
  strGSuggestion.Hint := strStrGridHint;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmQSearch.FormDestroy(Sender: TObject);
begin

  // Clipboard Viewer
  ChangeClipboardChain(handle, // our handle to remove
    NextHandle); // handle of next window in the chain
end;

{ ****************************** N E W    P A R T ****************************** }

// Clipboard Viewer

procedure TfrmQSearch.WMDRAWCLIPBOARD(var Message: TMessage);
begin

  if Clipboard.HasFormat(CF_TEXT) then
  begin
    ReEditAndViewClipboard(txtSrc);
  end;

  sendmessage(NextHandle, WM_DRAWCLIPBOARD, 0, 0); //[Old]
  //sendmessage(NextHandle, WM_DRAWCLIPBOARD, Message.WParam, Message.LParam);
end;

{ ****************************** N E W    P A R T ****************************** }

// Clipboard Viewer

procedure TfrmQSearch.WMCHANGECBCHAIN(var Message: TMessage);
begin
  if Message.WParam = NextHandle then
  begin
    NextHandle := Message.LParam;
  end
  else
  begin
    sendmessage(NextHandle, WM_CHANGECBCHAIN, //
      Message.WParam, // handle of window to remove
      Message.LParam); // handle of next window
  end;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmQSearch.FormShow(Sender: TObject);
begin
  // Clear Elements
  txtSrc.Text := '';
  mMeaning.Text := '';

  // Ready Images
  imgSrcReset.Picture := frmDic.imgSrcReset1.Picture;
end;

{ ****************************** N E W    P A R T ****************************** }
{$REGION '          Image Button Events         '}

procedure TfrmQSearch.imgMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

  if Sender.ClassType = TImage then
  begin
    with Sender as TImage do
    begin
      if Name = 'imgSrcReset' then
      begin
        imgSrcReset.Picture := frmDic.imgSrcReset3.Picture;
      end;
    end;
  end;

end;

procedure TfrmQSearch.imgMouseEnter(Sender: TObject);
begin

  imgBtnReset(Sender);

end;

procedure TfrmQSearch.imgMouseLeave(Sender: TObject);
begin

  if Sender.ClassType = TImage then
  begin
    with Sender as TImage do
    begin
      if Name = 'imgSrcReset' then
      begin
        imgSrcReset.Picture := frmDic.imgSrcReset1.Picture;
      end;
    end;
  end;

end;

procedure TfrmQSearch.imgMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

  imgBtnReset(Sender);

end;

procedure TfrmQSearch.imgBtnReset;
begin

  if Sender.ClassType = TImage then
  begin
    with Sender as TImage do
    begin
      if Name = 'imgSrcReset' then
      begin
        imgSrcReset.Picture := frmDic.imgSrcReset2.Picture;
      end;
    end;
  end;

end;
{$ENDREGION}
{ ****************************** N E W    P A R T ****************************** }

procedure TfrmQSearch.imgOntopClick(Sender: TObject);
begin

  imgOntop.Picture.Bitmap := nil;

  if IsWindowTopMost(self.handle) then
  begin
    NoTOPMOST(self.handle);

    imgListBtn.GetBitmap(6, imgOntop.Picture.Bitmap);

    confQSrcTop := False;

  end
  else
  begin

    TOPMOST(self.handle);

    imgListBtn.GetBitmap(7, imgOntop.Picture.Bitmap);

    confQSrcTop := True;

  end;

end;

procedure TfrmQSearch.imgSrcResetClick(Sender: TObject);
begin

  txtSrc.Text := '';
  imgSrcReset.Visible := False;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmQSearch.mnuItmAddtoWORDMARKSClick(Sender: TObject);
begin

  if strWord <> '' then
  begin
    if frmDic.lstBoxAnto.Items.IndexOf(strWord) = -1 then
      frmDic.lstBoxAnto.Items.Add(strWord);
  end;

end;

procedure TfrmQSearch.mnuItmShowmyWORDMARDSClick(Sender: TObject);
begin

  CheckCreateForm(TfrmWordmarks, frmWordmarks, 'frmWordmarks');
  frmWordmarks.show;

end;

procedure TfrmQSearch.pMenuQSrcPopup(Sender: TObject);
begin

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmQSearch.PMexitClick(Sender: TObject);
begin

  self.Close;

  frmDic.Close;

  Application.Terminate;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmQSearch.txtSrcChange(Sender: TObject);
begin

  if strGSuggestion.Visible = False then
    strGSuggestion.Visible := True;
  if strWord <> '' then
    mnuItmAddtoWORDMARKS.Enabled := True;

  if (txtSrc.Text <> '') then
  begin

    SearchNow;

    imgSrcReset.Visible := True;

  end
  else
  begin

    imgSrcReset.Visible := False;

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmQSearch.SearchNow;
var
  SrcSQL: string;
  strTxt: string;

  ID, RowCount: Integer;
  Stmt: TDISQLite3Statement;

  del: integer;
begin

  if (txtSrc.Text <> '') then

    // SrcSQL := 'WHERE Word like "' +

    strTxt :=
      StringReplace(StringReplace(StringReplace(StringReplace(txtSrc.Text, ' ',
      '', [rfReplaceAll, rfIgnoreCase]), //
      '-', '', [rfReplaceAll, rfIgnoreCase]), //
      '.', '', [rfReplaceAll, rfIgnoreCase]), //
      '''', '', [rfReplaceAll, rfIgnoreCase]); // + '%"';

  del := 0;

  repeat

    strTxt := copy(strTxt, 0, length(strTxt) - del);

    SrcSQL := 'WHERE _id like "' + strTxt + '%"';

    { Prepare the select statement. }
    Stmt := frmDic.DISQLiteDBMain.Prepare16
      ('SELECT * from ovidhan' + ' ' + SrcSQL); // + ' ORDER BY Pron ASC');

    del := 1;

  until Stmt.StepAndReset <> 101;

  if Stmt.StepAndReset <> 101 then
  begin

    try
      RowCount := 0;
      while Stmt.Step = SQLITE_ROW do
      begin
        ID := Stmt.Column_Int(0);
        SetGridRow(RowCount, ID,
          { Column "Name" is stored as TEXT, so we can retrieve it as a string. }
          Stmt.Column_Str16(1),

          Stmt.Column_Str16(2),

          Stmt.Column_Str16(3));
        Inc(RowCount);
      end;
      strGSuggestion.RowCount := RowCount;
    finally
      Stmt.Free;
    end;

    ShowMeaning;

    strGSuggestion.SortGrid(0);

  end
  else
  begin

    Stmt.Free;

  end;
end;

{ ****************************** N E W    P A R T ****************************** }

{ Helper routine to set one row in the StringGrid. }

procedure TfrmQSearch.SetGridRow(const ARowIdx: Integer;
  const AID: Integer = -1; const AWord: UnicodeString = '';
  const APOS: UnicodeString = ''; const APron: UnicodeString = '';
  const AMeaning: UnicodeString = '');
var
  Row: TStrings;
begin
  Row := strGSuggestion.Rows[ARowIdx];
  Row[0] := AWord;
  Row.Objects[0] := TObject(AID);
  Row[1] := APOS;
  Row.Objects[1] := TObject(AID);
  Row[2] := APron;
  Row.Objects[2] := TObject(AID);
  Row[3] := AMeaning;
  Row.Objects[3] := TObject(AID);

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmQSearch.txtSrcKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  //  if Key = VK_CONTROL then
  //  begin
  //    if strWord <> '' then
  //    begin
  //      voice.speak(strWord, 1);
  //    end;
  //  end;

end;

procedure TfrmQSearch.txtSrcKeyPress(Sender: TObject; var Key: Char);
begin

  if Key = #27 then { Esc => 27 }
  begin
    Key := #0;
    Close;
    frmDic.Close;
  end;

  if Key = #13 then { VK_RETURN => 13 }
  begin
    Key := #0;

    if strWord <> '' then
    begin
      voice.speak(strWord, 1);
    end;

  end;

  if not ((Key >= #0) and (Key <= #127)) then
  begin
    Key := #0;
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmQSearch.ShowMeaning;
begin

  if (strPOS = '') or (strPOS = '-') then
    mMeaning.Text := strWord // Word
    + ' - ' + strMeaning // Meaning
  else
    mMeaning.Text := strWord // Word
    + ' - ' + strPOS // POS
    + ' - ' + strMeaning; // Meaning;

  mnuItmAddtoWORDMARKS.Caption := 'Add "' + strWord + '" to WORDMARKS';

end;

procedure TfrmQSearch.strGSuggestionDblClick(Sender: TObject);
begin

  if strWord <> '' then
  begin
    voice.speak(strWord, 1);
  end;

end;

procedure TfrmQSearch.strGSuggestionSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  strWord := strGSuggestion.Cols[0].Strings[ARow];
  strPOS := strGSuggestion.Cols[1].Strings[ARow];
  strMeaning := strGSuggestion.Cols[2].Strings[ARow];

  ShowMeaning;
end;

{ ****************************** N E W    P A R T ****************************** }

end.

