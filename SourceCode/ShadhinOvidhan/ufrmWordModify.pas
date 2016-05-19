unit uFrmWordModify;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TfrmWordModify = class(TForm)
    Shape1: TShape;
    pnlBtnSave: TPanel;
    pnlBtnCancel: TPanel;
    eWord: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    memoMeaning: TMemo;
    memoAdMeaning: TMemo;
    Label4: TLabel;
    procedure pnlBtnCancelClick(Sender: TObject);
    procedure pnlBtnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlBtnMouseEnter(Sender: TObject);
    procedure pnlBtnMouseLeave(Sender: TObject);
    procedure pnlBtnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlBtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure memoAdMeaningKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure memoAdMeaningKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWordModify: TfrmWordModify;

  tempMeaning: string;

implementation

{$R *.dfm}

uses
  uFrmDic,
  uFunctions;

procedure TfrmWordModify.FormCreate(Sender: TObject);
begin

  //

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmWordModify.FormShow(Sender: TObject);
begin

  { Set Components }
  eWord.Text := strWord;

  memoMeaning.Text := frmDic.strOvidhanMeaning;

  if dict.ContainsKey(strWord) then
  begin
    memoAdMeaning.Text := dict.Items[strWord];
  end
  else
  begin
    memoAdMeaning.Text := '';
  end;

  tempMeaning := memoAdMeaning.Text;

end;

procedure TfrmWordModify.memoAdMeaningKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmWordModify.memoAdMeaningKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if memoAdMeaning.Text = tempMeaning then
  begin
    pnlBtnSave.Enabled := False;
    pnlBtnSave.Font.Color := clGray;
  end
  else
  begin
    pnlBtnSave.Enabled := True;
    pnlBtnSave.Font.Color := clBlack;
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmWordModify.pnlBtnCancelClick(Sender: TObject);
begin

  frmDic.Enabled := True;

  close;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmWordModify.pnlBtnSaveClick(Sender: TObject);
begin

  if memoAdMeaning.Text <> '' then
    dict.AddOrSetValue(strWord, memoAdMeaning.Text);

  SaveDict;

  close;

  frmDic.Enabled := True;

  frmDic.SetFullMeaning;

end;

{ ****************************** N E W    P A R T ****************************** }
{$REGION '          Panel Appearance         '}

procedure TfrmWordModify.pnlBtnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin (Sender as TPanel)
  .Color := clBlack; (Sender as TPanel)
  .Font.Color := clWhite;
end;

procedure TfrmWordModify.pnlBtnMouseEnter(Sender: TObject);
begin (Sender as TPanel)
  .Color := clGray; (Sender as TPanel)
  .Font.Color := clWhite;
end;

procedure TfrmWordModify.pnlBtnMouseLeave(Sender: TObject);
begin (Sender as TPanel)
  .Color := clWhite; (Sender as TPanel)
  .Font.Color := clBlack;
end;

procedure TfrmWordModify.pnlBtnMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin (Sender as TPanel)
  .Color := clGray; (Sender as TPanel)
  .Font.Color := clWhite;
end;
{$ENDREGION}
{ ****************************** N E W    P A R T ****************************** }

end.
