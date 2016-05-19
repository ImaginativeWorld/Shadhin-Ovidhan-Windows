{
 *******************************************************************
 This Source Code Form is subject to the terms of the Mozilla Public
 License, v. 2.0. If a copy of the MPL was not distributed with this
 file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *******************************************************************
}

{$INCLUDE ../ProjectDefines.inc}
unit uFrmWordmarks;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, JvExStdCtrls, JvListBox;

type
  TfrmWordmarks = class(TForm)
    pnlHeader: TPanel;
    Panel2: TPanel;
    btnClose: TButton;
    JvLstBoxWM: TJvListBox;
    sBtnAdd: TSpeedButton;
    sBtnRemove: TSpeedButton;
    btnSaveToFile: TButton;
    SaveDlgWM: TSaveDialog;
    procedure pnlHeaderMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sBtnRemoveClick(Sender: TObject);
    procedure sBtnAddClick(Sender: TObject);
    procedure btnSaveToFileClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWordmarks: TfrmWordmarks;

implementation

{$R *.dfm}

uses
  uFrmDic,
  uFunctions;

procedure TfrmWordmarks.btnCloseClick(Sender: TObject);
begin

  frmDic.SaveWordmarks(JvLstBoxWM);

  //  frmDic.LoadWordmarks;

  close;

end;

procedure TfrmWordmarks.btnSaveToFileClick(Sender: TObject);
begin
  SaveDlgWM.FileName := '*.txt';
  if SaveDlgWM.Execute(self.Handle) then
  begin
    JvLstBoxWM.Items.SaveToFile(SaveDlgWM.FileName, TEncoding.UTF8);
    showmessage('WORDMARKS exported successfully!');
  end;

end;

procedure TfrmWordmarks.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  Action := caFree;

  frmWordmarks := nil;

end;

procedure TfrmWordmarks.FormCreate(Sender: TObject);
//var
//  { WORDMARKS }
//{$IFDEF PortableOn}
//  wmPath: String;
//{$ELSE}
//  strUserName: PChar;
//  unSize: DWord;
//  wmPath: String;
//{$ENDIF}
begin

  // Load WORDMARKS
//{$IFDEF PortableOn}
//  wmPath := 'Wordmarks.iwdb';
//{$ELSE}
//  unSize := 250;
//  GetMem(strUserName, unSize);
//  getusername(strUserName, unSize);
//
//  wmPath := 'Wordmarks_' + strPas(strUserName) + '.iwdb';
//
//  FreeMem(strUserName);
//{$ENDIF}
  if frmDic.lstBoxAnto.Count <> 0 then
  begin

    JvLstBoxWM.Items := frmDic.lstBoxAnto.Items;

  end;

end;

procedure TfrmWordmarks.pnlHeaderMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    TForm(frmWordmarks).Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;

procedure TfrmWordmarks.sBtnAddClick(Sender: TObject);
var
  strWord: string;
begin
  if inputquery('WORDMARKS | New',
    'Pleasy type your Word or Phrase or cancel to close:', strWord) then
  begin
    if strWord <> '' then
    begin
      if JvLstBoxWM.Items.IndexOf(strWord) = -1 then
      begin
        JvLstBoxWM.Items.Add(strWord);
        frmDic.lstBoxAnto.Items.Add(strWord);
      end
      else
        ShowMessage('''' + strWord + ''' already in Wordmark!');
    end;
  end;

end;

procedure TfrmWordmarks.sBtnRemoveClick(Sender: TObject);
var
  intTemp: Integer;
begin
  if JvLstBoxWM.ItemIndex <> -1 then
  begin
    intTemp := JvLstBoxWM.ItemIndex;
    JvLstBoxWM.Items.Delete(intTemp);
    frmDic.lstBoxAnto.Items.Delete(intTemp);
  end
  else
    ShowMessage('Select a Word first!');
end;

end.

