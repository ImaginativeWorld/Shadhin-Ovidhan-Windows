unit uFrmMeaningList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls;

type
  TfrmMeaningList = class(TForm)
    List: TListView;
    mMeaning: TMemo;
    lblTotalEntries: TLabel;
    pnlDown: TPanel;
    pnlBtnOk: TPanel;
    pnlBtnSave: TPanel;
    pnlDelete: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure pnlBtnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlBtnMouseEnter(Sender: TObject);
    procedure pnlBtnMouseLeave(Sender: TObject);
    procedure pnlBtnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure pnlBtnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pnlBtnSaveClick(Sender: TObject);
    procedure mMeaningChange(Sender: TObject);
    procedure mMeaningKeyPress(Sender: TObject; var Key: Char);
    procedure pnlDeleteClick(Sender: TObject);
  private
    { Private declarations }

    procedure ChangeSaveBtn;

  public
    { Public declarations }
  end;

var
  frmMeaningList: TfrmMeaningList;

  TempMeaning: string;

implementation

{$R *.dfm}

uses
  uFunctions,
  uTextStrings;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMeaningList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;

  frmMeaningList := Nil;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMeaningList.FormCreate(Sender: TObject);
Var
  S: String;
  thisItem: TListItem;
begin

  List.Items.BeginUpdate;
  For S in dict.Keys Do
  Begin
    thisItem := List.Items.Add;
    thisItem.Caption := S;
    // thisItem.SubItems.Add(dict.Items[S]); 
  End;
  List.SortType := stText;
  List.Items.EndUpdate;

  lblTotalEntries.Caption := 'মোট অন্তর্ভুক্তিঃ  ' // 
    + IntToStr(List.Items.Count);

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMeaningList.ListSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin

  if List.ItemIndex <> -1 then
  begin
    mMeaning.Text := dict.Items[Item.Caption];
    TempMeaning := mMeaning.Text;
    ChangeSaveBtn;
  end
  else
  begin
    mMeaning.Text := '';
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMeaningList.mMeaningChange(Sender: TObject);
begin
  ChangeSaveBtn;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMeaningList.mMeaningKeyPress(Sender: TObject; var Key: Char);
begin

  if Key = '|' then
  begin
    Key := #0;
  end;

  if Key = #13 then { VK_RETURN => 13 }
  begin
    Key := #0;
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMeaningList.ChangeSaveBtn;
begin

  if (mMeaning.Text <> TempMeaning) and (mMeaning.Text <> '') then
  begin
    pnlBtnSave.font.Color := clBlack;
    pnlBtnSave.Enabled := True;
  end
  else
  begin
    pnlBtnSave.font.Color := clGray;
    pnlBtnSave.Enabled := False;
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMeaningList.pnlBtnOkClick(Sender: TObject);
begin
  self.close;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMeaningList.pnlBtnSaveClick(Sender: TObject);
begin

  if mMeaning.Text <> '' then
    dict.AddOrSetValue(List.Items.Item[List.ItemIndex].Caption, mMeaning.Text);

  if SaveDict then
  begin
    TempMeaning := mMeaning.Text;
    pnlBtnSave.Enabled := False;
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmMeaningList.pnlDeleteClick(Sender: TObject);
begin
  if List.ItemIndex <> -1 then
  begin
  
    dict.Remove(List.Items.Item[List.ItemIndex].Caption);
    
    if SaveDict then
      List.Items.Delete(List.ItemIndex);

  end
  else
  begin
    showmessage(strErrSelectAEntry);
  end;
end;

{ ****************************** N E W    P A R T ****************************** }
{$REGION '          Panel Appearance         '}

procedure TfrmMeaningList.pnlBtnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin (Sender as TPanel)
  .Color := clBlack; (Sender as TPanel)
  .font.Color := clWhite;
end;

procedure TfrmMeaningList.pnlBtnMouseEnter(Sender: TObject);
begin (Sender as TPanel)
  .Color := clGray; (Sender as TPanel)
  .font.Color := clWhite;
end;

procedure TfrmMeaningList.pnlBtnMouseLeave(Sender: TObject);
begin

  with (Sender as TPanel) do
  begin
    Color := clWhite;

    if Enabled then
      font.Color := clBlack
    else
      font.Color := clGray;

  end;
end;

procedure TfrmMeaningList.pnlBtnMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin (Sender as TPanel)
  .Color := clGray; (Sender as TPanel)
  .font.Color := clWhite;
end;
{$ENDREGION}
{ ****************************** N E W    P A R T ****************************** }

end.
