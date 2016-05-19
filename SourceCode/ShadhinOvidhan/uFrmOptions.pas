{
 *******************************************************************
 This Source Code Form is subject to the terms of the Mozilla Public
 License, v. 2.0. If a copy of the MPL was not distributed with this
 file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *******************************************************************
}

{$INCLUDE ../ProjectDefines.inc}
unit uFrmOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, DISQLite3Database, DISQLite3Api,
  Grids;

type
  TfrmOptions = class(TForm)
    pnlDown: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    tBarSpRate: TTrackBar;
    ChkUpdate: TCheckBox;
    chkClipboard: TCheckBox;
    lblVersion: TLabel;
    pnlBtnOk: TPanel;
    pnlBtnCancel: TPanel;
    pnlBtnReset: TPanel;
    pnlCheckUpdate: TPanel;
    pnlBtnExport: TPanel;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    pnlBtnImport: TPanel;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    Label3: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlBtnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlBtnMouseEnter(Sender: TObject);
    procedure pnlBtnMouseLeave(Sender: TObject);
    procedure pnlBtnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlCheckUpdateClick(Sender: TObject);
    procedure pnlBtnExportClick(Sender: TObject);
    procedure pnlBtnImportClick(Sender: TObject);

  private
    { Private declarations }

    procedure SaveSettings;
    procedure SetComponents;

  public
    { Public declarations }
  end;

var
  frmOptions: TfrmOptions;

implementation

{$R *.dfm}

uses
  uFunctions,
  uFrmDic,
  uTextStrings,
  uFrmAddModify;

procedure TfrmOptions.btnCancelClick(Sender: TObject);
begin

  self.Close;

  frmDic.Enabled := True;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmOptions.btnOkClick(Sender: TObject);
begin

  try
    SaveSettings;
    SetSettings;
    GetSettings;
    frmDic.SetComponents;
  finally
    self.Close;
  end;

  frmDic.Enabled := True;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmOptions.SaveSettings;
begin

  if ChkUpdate.Checked then
    confUpdateCheck := True
  else
    confUpdateCheck := False;

  if chkClipboard.Checked then
    confChkClipboard := True
  else
    confChkClipboard := False;

  confVoiceRate := tBarSpRate.Position;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmOptions.btnResetClick(Sender: TObject);
var
  MsgResult: Integer;
begin

  MsgResult := MessageDlg('Are you sure want to RESET all settings?',
    mtInformation, mbYesNo, 0);

  if MsgResult = mrYes then
  begin
    try
      ResetSettings;

      GetSettings;

      SetComponents;

      frmDic.SetComponents;
    finally
      showmessage('Reset completed!');
    end;
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  Action := caFree;

  frmOptions := Nil;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmOptions.FormCreate(Sender: TObject);
begin
  lblVersion.Caption := strAppName + #10 + strVersion;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmOptions.FormShow(Sender: TObject);
begin

  SetComponents;

end;

{ ****************************** N E W    P A R T ****************************** }
{$REGION '          Panel Appearance         '}

procedure TfrmOptions.pnlBtnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin (Sender as TPanel)
  .Color := clBlack; (Sender as TPanel)
  .Font.Color := clWhite;
end;

procedure TfrmOptions.pnlBtnMouseEnter(Sender: TObject);
begin (Sender as TPanel)
  .Color := clGray; (Sender as TPanel)
  .Font.Color := clWhite;
end;

procedure TfrmOptions.pnlBtnMouseLeave(Sender: TObject);
begin (Sender as TPanel)
  .Color := clWhite; (Sender as TPanel)
  .Font.Color := clBlack;
end;

procedure TfrmOptions.pnlBtnMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin (Sender as TPanel)
  .Color := clGray; (Sender as TPanel)
  .Font.Color := clWhite;
end;
{$ENDREGION}
{ ****************************** N E W    P A R T ****************************** }

procedure TfrmOptions.SetComponents;
begin

  if confChkClipboard then
    chkClipboard.Checked := True
  else
    chkClipboard.Checked := False;

  if confUpdateCheck then
    ChkUpdate.Checked := True
  else
    ChkUpdate.Checked := False;

  tBarSpRate.Position := confVoiceRate;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmOptions.pnlCheckUpdateClick(Sender: TObject);
begin

  execute_something(appdir + 'SOCommon.exe', '-notsilent');

end;


{ ****************************** N E W    P A R T ****************************** }

procedure TfrmOptions.pnlBtnExportClick(Sender: TObject);
var
  //RowCount: Integer;
  Stmt: TDISQLite3Statement;
  tempStringList: TStrings;
  tempstring: string;
begin

tempStringList:= TStringlist.Create;

  { Prepare the select statement. }
  Stmt := frmdic.DISQLiteDBMain.Prepare16( //
    'SELECT * from ovidhan' + //
      ' WHERE (New = ''1'') OR (Modify = ''1'')'); // + //
  // ' ORDER BY Pron ASC');
  try
    while Stmt.Step = SQLITE_ROW do
    begin

        tempstring := Stmt.Column_Str16(1) + '|' +

        Stmt.Column_Str16(2) + '|' +

        Stmt.Column_Str16(3) + '|' +

        Stmt.Column_Str16(4) + '|' +

        Stmt.Column_Str16(5) + '|' +

        Stmt.Column_Str16(6);

        tempStringList.Add(tempstring);
    end;

  finally
    Stmt.Free;
  end;

  try

    if SaveDialog.Execute(self.Handle) then
    begin
       tempStringList.SaveToFile(SaveDialog.FileName, TEncoding.UTF8);
       showmessage('Extended database exported successfully!');
    end;

  finally
       tempStringList.Destroy;
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmOptions.pnlBtnImportClick(Sender: TObject);
var
  RowCount: Integer;

  tempStrings: TStrings;
  tempStringList: TStringList;

  MsgResult: Integer;

  yestoall: bool;

  totalword: integer;
begin

  yestoall := False;

  tempStrings:= TStringlist.Create;
  tempStringList:= TStringlist.Create;

  if OpenDialog.Execute(self.Handle) then
  begin

    tempStrings.LoadFromFile(OpenDialog.FileName, TEncoding.UTF8);

    RowCount:= 0;
    totalword:= 0;

      while RowCount <> tempStrings.Count do
      begin

        SplitStrings(tempStrings.Strings[rowcount],'|',tempStringList);

          if frmAddmodify.CheckWordInDB(tempStringList[0]) then
          begin

            if (yestoall = false) then
            begin

              MsgResult := MessageDlg(
              'The word/phrase ''' + tempStringList[0] + ''' already in Database!' +
              #10 +
              #10 + 'Do you want to replace it?',
              mtInformation, [mbYes, mbNo, mbYesToAll], 0);

              if (MsgResult = mrYesToAll) then
              begin
                 yestoall := true;



                 frmDic.DISQLiteDBMain.Execute(//
                 'UPDATE ovidhan ' + //
                 'SET pos =''' + tempStringList[1] + ''', ' + //
                 'meaning =''' + tempStringList[2] + ''', ' + //
                 'synonyms =''' + tempStringList[3] + ''', ' + //
                 'modify =''' + tempStringList[4] + ''', ' + //
                 'new =''' + tempStringList[5] + ''' ' + //
                 'WHERE _id =''' +  RemoveUnwantedChr(tempStringList[0]) + ''''
                 );

                 inc(totalword);

              end;

              if MsgResult = mrYes then
              begin

                 frmDic.DISQLiteDBMain.Execute(//
                 'UPDATE ovidhan ' + //
                 'SET pos =''' + tempStringList[1] + ''', ' + //
                 'meaning =''' + tempStringList[2] + ''', ' + //
                 'synonyms =''' + tempStringList[3] + ''', ' + //
                 'modify =''' + tempStringList[4] + ''', ' + //
                 'new =''' + tempStringList[5] + ''' ' + //
                 'WHERE _id =''' +  RemoveUnwantedChr(tempStringList[0]) + ''''
                 );

                 inc(totalword);

              end;

            end
            else
            begin

                 frmDic.DISQLiteDBMain.Execute(//
                 'UPDATE ovidhan ' + //
                 'SET pos =''' + tempStringList[1] + ''', ' + //
                 'meaning =''' + tempStringList[2] + ''', ' + //
                 'synonyms =''' + tempStringList[3] + ''', ' + //
                 'modify =''' + tempStringList[4] + ''', ' + //
                 'new =''' + tempStringList[5] + ''' ' + //
                 'WHERE _id =''' +  RemoveUnwantedChr(tempStringList[0]) + ''''
                 );

                 // WORD | POS | MEANING | SYNONYMS | MODIFY | NEW

                 inc(totalword);

            end;

          end
          else
          begin

          frmDic.DISQLiteDBMain.Execute(//
          'INSERT INTO ovidhan ' + //
          '(_id, pos, pron, meaning, synonyms, modify, new) ' + //
          'VALUES (''' + RemoveUnwantedChr(tempStringList[0]) +  ''', ' +//
          '''' + tempStringList[1] + ''', ' + //
          '''' + tempStringList[0] + ''', ' + //
          '''' + tempStringList[2] + ''', ' + //
          '''' + tempStringList[3] + ''', ' + //
          '''' + tempStringList[4] + ''', ' + //
          '''' + tempStringList[5] + ''')'
          );

          inc(totalword);

          end;

        inc(RowCount);

      end;

      showmessage('Total ' + inttostr(totalword) +
      ' word/phrase added/replaced in Database! :)');

    end;

  tempStrings.Destroy;
  tempStringList.Destroy;


end;

{ ****************************** N E W    P A R T ****************************** }

end.
