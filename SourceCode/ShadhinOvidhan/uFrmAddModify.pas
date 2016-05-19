{
 *******************************************************************
 This Source Code Form is subject to the terms of the Mozilla Public
 License, v. 2.0. If a copy of the MPL was not distributed with this
 file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *******************************************************************
}

unit uFrmAddModify;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DISQLite3Database;

type
  TfrmAddModify = class(TForm)
    Shape1: TShape;
    pnlBtnSave: TPanel;
    pnlBtnCancel: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    eWord: TEdit;
    mMeaning: TMemo;
    Label3: TLabel;
    ePOS: TEdit;
    pnlBtnNew: TPanel;
    pnlBtnDel: TPanel;
    pnlInfo: TPanel;
    PanelBG: TPanel;
    lblInfo: TLabel;
    Label4: TLabel;
    mSynonyms: TMemo;
    pnlCaution: TPanel;
    Panel2: TPanel;
    Label5: TLabel;

    procedure SetComponents;
    procedure SetTextBoxes;
    procedure SaveDB;
    procedure AddInDB;

    function CheckWordInDB(str: string): boolean;

    procedure pnlBtnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlBtnSaveClick(Sender: TObject);
    procedure pnlBtnDelClick(Sender: TObject);
    procedure pnlBtnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlBtnMouseEnter(Sender: TObject);
    procedure pnlBtnMouseLeave(Sender: TObject);
    procedure pnlBtnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlBtnNewClick(Sender: TObject);
    procedure mMeaningChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAddModify: TfrmAddModify;

implementation

{$R *.dfm}

uses
   ufrmDic,
   uFunctions;

procedure TfrmAddModify.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  frmDic.Enabled := True;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmAddModify.FormShow(Sender: TObject);
begin

  SetTextBoxes;
  SetComponents;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmAddModify.mMeaningChange(Sender: TObject);
begin

end;

{ ****************************** N E W    P A R T ****************************** }
procedure TfrmAddModify.SetTextBoxes;
begin

         eWord.Text := strWord;
         ePOS.Text := frmDic.strPOS;
         mMeaning.text := frmDic.strOvidhanMeaning;
         mSynonyms.text := strSynonyms;

end;

procedure TfrmAddModify.SetComponents;
begin

         eWord.Enabled := false;
         ePOS.Enabled := False;
         mMeaning.Enabled := False;
         mSynonyms.Enabled := False;

         EnablePanelButton(pnlBtnDel);
         EnablePanelButton(pnlBtnNew);
         EnablePanelButton(pnlBtnSave);

         pnlBtnSave.Caption := 'সম্পাদন';
         pnlBtnCancel.Caption := 'ফিরে যান';
         pnlBtnNew.Caption := '+ নতুন';
         pnlBtnDel.Caption := '- মুছুন';

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmAddModify.pnlBtnCancelClick(Sender: TObject);
begin

if mMeaning.Enabled = true then
begin

  SetTextBoxes;
  SetComponents;

end
else
begin

  frmDic.Enabled := True;

  close;

end;


end;

{ ****************************** N E W    P A R T ****************************** }
{$REGION '          Panel Appearance         '}

procedure TfrmAddModify.pnlBtnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin (Sender as TPanel)
  .Color := clBlack; (Sender as TPanel)
  .Font.Color := clWhite;
end;

procedure TfrmAddModify.pnlBtnMouseEnter(Sender: TObject);
begin (Sender as TPanel)
  .Color := clGray; (Sender as TPanel)
  .Font.Color := clWhite;
end;

procedure TfrmAddModify.pnlBtnMouseLeave(Sender: TObject);
begin (Sender as TPanel)
  .Color := clWhite; (Sender as TPanel)
  .Font.Color := clBlack;
end;

procedure TfrmAddModify.pnlBtnMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin (Sender as TPanel)
  .Color := clGray; (Sender as TPanel)
  .Font.Color := clWhite;
end;

{$ENDREGION}
{ ****************************** N E W    P A R T ****************************** }

procedure TfrmAddModify.pnlBtnSaveClick(Sender: TObject);
begin
  if mMeaning.Enabled = false then
  begin

         ePOS.Enabled := True;
         mMeaning.Enabled := True;
         mSynonyms.Enabled := true;
         pnlBtnSave.Caption := 'সংরক্ষণ';
         pnlBtnCancel.Caption := 'বাতিল';
         DisablePanelButton(pnlBtnDel);
         DisablePanelButton(pnlBtnNew);
 end
 else
 begin

         SaveDB;

         SetComponents;

  end;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmAddModify.SaveDB;
begin

   frmDic.DISQLiteDBMain.Execute(//
   'UPDATE ovidhan ' + //
   'SET pos =''' + epos.Text + ''', ' + //
   'meaning =''' + mMeaning.Text + ''', ' + //
   'synonyms =''' + mSynonyms.Text + ''', ' + //
   'modify =''1'' ' + //
   'WHERE _id =''' +  RemoveUnwantedChr(eWord.Text) + ''''
   );

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmAddModify.pnlBtnDelClick(Sender: TObject);
var
  MsgResult: Integer;
begin

MsgResult := //
 MessageDlg('Do you really want to DELETE the word/phrase "' + eWord.Text + '"?',
  mtWarning, mbYesNo, 0);

if MsgResult = mrYes then
  begin
    frmDic.DISQLiteDBMain.Execute(//
    'DELETE FROM ovidhan ' + //
'WHERE _id =''' + RemoveUnwantedChr(eWord.Text) +  ''''
    );
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmAddModify.pnlBtnNewClick(Sender: TObject);
begin

if eWord.Enabled = false then
begin
   eWord.Enabled := true;
   ePOS.Enabled := True;
   mMeaning.Enabled := True;
   mSynonyms.Enabled := true;

   eWord.Text := '';
   ePOS.Text := '';
   mMeaning.Text := '';
   mSynonyms.Text := '';

  pnlBtnCancel.Caption := 'বাতিল';
  pnlBtnNew.Caption := 'যুক্ত করুন';
  DisablePanelButton(pnlBtnDel);
  DisablePanelButton(pnlBtnSave);

end
else
begin

  if (eWord.Text <> '') and (epos.text <> '') and (mmeaning.Text <> '') then
  begin

    AddInDB;

  end
  else
  begin

    showmessage('Type all field!');

  end;

end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmAddModify.AddInDB;
begin

if CheckWordInDB(eWord.Text) then
begin

  showmessage('The word/phrese ''' + eWord.Text + ''' already in Database! :(');

end
else
begin

   frmDic.DISQLiteDBMain.Execute(//
   'INSERT INTO ovidhan ' + //
   '(_id, pos, pron, meaning, synonyms, new) ' + //
   'VALUES (''' + RemoveUnwantedChr(eWord.Text) +  ''', ' +//
   '''' + epos.Text + ''', ' + //
   '''' + eWord.Text + ''', ' + //
   '''' + mMeaning.Text + ''', ' + //
   '''' + mSynonyms.Text + ''', ' + //
   '''1'')'
   );


    showmessage('New word/phrase ''' + eWord.Text + ''' added in Database! :)');

    SetComponents;

end;

end;

{ ****************************** N E W    P A R T ****************************** }

function TfrmAddModify.CheckWordInDB(str: string): boolean;
var
  SrcSQL: string;
  strTxt: string;

  Stmt: TDISQLite3Statement;
begin

result:= false;

strTxt := stringreplace
        (stringreplace(stringreplace(stringreplace(str, //
              ' ', '', [rfReplaceAll, rfIgnoreCase]), //
            '-', '', [rfReplaceAll, rfIgnoreCase]), //
          '.', '', [rfReplaceAll, rfIgnoreCase]), //
        '''', '', [rfReplaceAll, rfIgnoreCase]);

SrcSQL := 'WHERE _id like ''' + strTxt + '''';

{ Prepare the select statement. }
Stmt := frmDic.DISQLiteDBMain.Prepare16('SELECT * from ovidhan ' + SrcSQL);
// + ' ORDER BY Pron ASC');

if Stmt.StepAndReset <> 101 then
begin
  result:= true;
end;

Stmt.Free;

end;

{ ****************************** N E W    P A R T ****************************** }


end.
