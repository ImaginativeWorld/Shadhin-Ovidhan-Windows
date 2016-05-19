{
 *******************************************************************
 This Source Code Form is subject to the terms of the Mozilla Public
 License, v. 2.0. If a copy of the MPL was not distributed with this
 file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *******************************************************************
}

{$INCLUDE ../ProjectDefines.inc}
unit ufrmDic;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  pngimage,
  ExtCtrls,
  StdCtrls,
  Buttons,
  Grids,
  DBCtrls,
  JvDBGrid,
  Comobj,
  DBGrids,
  DISQLite3Database,
  JvStringGrid,
  JvMemo,
  JvListBox,
  Menus,
  JvExStdCtrls,
  JvExGrids, JvComponentBase, JvBalloonHint, ImgList, StrUtils;

type
  TfrmDic = class(TForm)
    lblVersion: TLabel;
    lblHints: TLabel;
    DISQLiteDBMain: TDISQLite3Database;
    pMenuTxt: TPopupMenu;
    miCut: TMenuItem;
    miCopy: TMenuItem;
    miPaste: TMenuItem;
    txtEnSrc: TEdit;
    txtBnSrc: TEdit;
    pnlBnOpt: TPanel;
    Label2: TLabel;
    rBtnBnS3: TRadioButton;
    rBtnBnS2: TRadioButton;
    rBtnBnS1: TRadioButton;
    pnlEnOpt: TPanel;
    Label1: TLabel;
    rBtnEnS1: TRadioButton;
    rBtnEnS2: TRadioButton;
    rBtnEnS3: TRadioButton;
    strGMainDic: TJvStringGrid;
    lstBoxSyno: TJvListBox;
    lstBoxAnto: TJvListBox;
    memoMeaning: TJvMemo;
    imgBnSrcOpt: TImage;
    imgEnSrcOpt: TImage;
    imgBtnExit: TImage;
    imgBtnMin: TImage;
    imgBtnMin1: TImage;
    imgBtnMin2: TImage;
    imgBtnMin3: TImage;
    imgBtnExit1: TImage;
    imgBtnExit2: TImage;
    imgBtnExit3: TImage;
    pnlImgs: TPanel;
    imgHelp3: TImage;
    imgHelp2: TImage;
    imgHelp1: TImage;
    imgQSrc3: TImage;
    imgQSrc2: TImage;
    imgQSrc1: TImage;
    imgSpeak3: TImage;
    imgSpeak2: TImage;
    imgSpeak1: TImage;
    imgExit3: TImage;
    imgExit2: TImage;
    imgExit1: TImage;
    imgHelp: TImage;
    imgQSrc: TImage;
    imgSpeak: TImage;
    imgExit: TImage;
    imgBG: TImage;
    imgSrcOpt1: TImage;
    imgSrcOpt2: TImage;
    imgSrcOpt3: TImage;
    imgBtnEnOpt: TImage;
    imgBtnBnOpt: TImage;
    imgDrag: TImage;
    imgSrcReset1: TImage;
    imgSrcReset2: TImage;
    imgSrcReset3: TImage;
    imgEnSrcReset: TImage;
    imgBnSrcReset: TImage;
    imgIWlogo: TImage;
    imgBtnOnTop: TImage;
    imgBtnOntop1: TImage;
    imgBtnOntop2: TImage;
    tmrUpdateCheck: TTimer;
    imgAddWord: TImage;
    imgRemoveWord: TImage;
    imgShowWM: TImage;
    N1: TMenuItem;
    miAddToWM: TMenuItem;
    tmrBtnExit: TTimer;
    tmrBtnSpeak: TTimer;
    tmrBtnQSrc: TTimer;
    tmrBtnHelp: TTimer;
    MenuImageList: TImageList;
    imgEnSrcHistory1: TImage;
    imgEnSrcHistory2: TImage;
    imgEnSrcHistory3: TImage;
    imgEnSrcHistory: TImage;
    lstboxHistory: TJvListBox;
    pnlHistory: TPanel;
    imgAddMeaning: TImage;
    imgChangeFont: TImage;
    imgLike: TImage;
    imgLike1: TImage;
    imgLike2: TImage;
    imgShowModify: TImage;
    imgShowNew: TImage;

    { Start up }
    procedure SetComponents;
    procedure LoadDataBase;

    { Font }
    // procedure InstallAppFont;
    procedure ChangeFont(const FontName: string);

    procedure RemoveAppFont;

    procedure imgBtnReset(Sender: TObject);

    procedure SearchNow;

    { eXtras }
    procedure addtoHistory;

    { WORDMARKS }
    procedure SaveWordmarks(Sender: TObject);
    procedure LoadWordmarks;

    { Set Meaning }
    procedure SetFullMeaning;

    { Button Glow Effect }
    procedure ExitIcon_DrawState;
    procedure ExitIcon_DrawDown;
    procedure ExitIcon_DrawUpOver;

    procedure SpeakIcon_DrawState;
    procedure SpeakIcon_DrawDown;
    procedure SpeakIcon_DrawUpOver;

    procedure QSrcIcon_DrawState;
    procedure QSrcIcon_DrawDown;
    procedure QSrcIcon_DrawUpOver;

    procedure HelpIcon_DrawState;
    procedure HelpIcon_DrawDown;
    procedure HelpIcon_DrawUpOver;

    procedure SetGridRow(const ARowIdx: integer; const AID: integer = -1;
      const AWord: UnicodeString = ''; const APOS: UnicodeString = '';
      const APron: UnicodeString = ''; const AMeaning: UnicodeString = '';
      const ASynonyms: UnicodeString = ''; const AAntonyms: UnicodeString = '');

    procedure pnlTitleMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure btnExitClick(Sender: TObject);
    procedure FromCreate(Sender: TObject);

    procedure DicDBGridDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure btnMinClick(Sender: TObject);
    procedure btnQSrcClick(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure DicDBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: integer; Column: TColumn; State: TGridDrawState);
    procedure btnEnOptClick(Sender: TObject);
    procedure btnBnOptClick(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure rBtnEnSIntClick(Sender: TObject);
    procedure rBtnBnSIntClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure txtEnSrcEnter(Sender: TObject);
    procedure txtBnSrcEnter(Sender: TObject);
    procedure strGMainDicDrawCell(Sender: TObject; ACol, ARow: integer;
      Rect: TRect; State: TGridDrawState);
    procedure strGMainDicSelectCell(Sender: TObject; ACol, ARow: integer;
      var CanSelect: boolean);
    procedure strGMainDicDblClick(Sender: TObject);

    procedure lstBoxSynoClick(Sender: TObject);
    procedure lstBoxAntoClick(Sender: TObject);

    procedure txtBnSrcKeyDown(Sender: TObject; var Key: word; Shift:
      TShiftState);
    procedure miCutClick(Sender: TObject);
    procedure miCopyClick(Sender: TObject);
    procedure miPasteClick(Sender: TObject);
    procedure imgBtnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure imgBtnMouseEnter(Sender: TObject);
    procedure imgBtnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure imgBtnMouseLeave(Sender: TObject);
    procedure imgEnSrcResetClick(Sender: TObject);
    procedure imgBnSrcResetClick(Sender: TObject);

    procedure txtEnSrcChange(Sender: TObject);
    procedure txtBnSrcChange(Sender: TObject);

    procedure imgIWlogoClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure imgBtnOnTopClick(Sender: TObject);
    procedure tmrUpdateCheckTimer(Sender: TObject);
    procedure imgAddWordClick(Sender: TObject);
    procedure imgRemoveWordClick(Sender: TObject);
    procedure imgShowWMClick(Sender: TObject);
    procedure pMenuTxtPopup(Sender: TObject);
    procedure miAddToWMClick(Sender: TObject);

    procedure tmrBtnExitTimer(Sender: TObject);
    procedure imgExitMouseEnter(Sender: TObject);
    procedure imgExitMouseLeave(Sender: TObject);
    procedure imgExitMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure imgExitMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure tmrBtnSpeakTimer(Sender: TObject);
    procedure tmrBtnQSrcTimer(Sender: TObject);
    procedure tmrBtnHelpTimer(Sender: TObject);

    procedure imgSpeakMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure imgSpeakMouseEnter(Sender: TObject);
    procedure imgSpeakMouseLeave(Sender: TObject);
    procedure imgSpeakMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);

    procedure imgQSrcMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure imgQSrcMouseEnter(Sender: TObject);
    procedure imgQSrcMouseLeave(Sender: TObject);
    procedure imgQSrcMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);

    procedure imgHelpMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure imgHelpMouseEnter(Sender: TObject);
    procedure imgHelpMouseLeave(Sender: TObject);
    procedure imgHelpMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure imgEnSrcHistoryClick(Sender: TObject);
    procedure lstboxHistoryClick(Sender: TObject);
    procedure strGMainDicClick(Sender: TObject);
    procedure strGMainDicMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);

    procedure imgAddMeaningClick(Sender: TObject);
    procedure txtSrcKeyPress(Sender: TObject; var Key: char);
    procedure imgChangeFontClick(Sender: TObject);
    procedure imgLikeClick(Sender: TObject);
    procedure imgShowNewClick(Sender: TObject);
    procedure imgShowModifyClick(Sender: TObject);
    procedure txtEnSrcKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }

  public
    { Public declarations }

  var
    strMeaning, strOvidhanMeaning, strPOS: string;

    protected
  procedure CreateParams(var Params: TCreateParams); override;

  end;

type
  TCustomDBGridCracker = class(TJvDBGrid);

const
  m_GlowEffect: boolean = True;
  m_BlendingStep: integer = 51; { 255/51=5 step }
  m_TimerInterval: integer = 30; { 5 step in 30*5=150 milisecond }

var
  frmDic: TfrmDic;
  voice: olevariant;

  boolBnSearch: boolean;

  // Alpha Blend
  ExitIcon_MouseIn: boolean;
  ExitIcon_MouseDown: boolean;
  ExitIcon_TranparentValue: integer;

  SpeakIcon_MouseIn: boolean;
  SpeakIcon_MouseDown: boolean;
  SpeakIcon_TranparentValue: integer;

  QSrcIcon_MouseIn: boolean;
  QSrcIcon_MouseDown: boolean;
  QSrcIcon_TranparentValue: integer;

  HelpIcon_MouseIn: boolean;
  HelpIcon_MouseDown: boolean;
  HelpIcon_TranparentValue: integer;

implementation

{$R *.dfm}

uses
  uFunctions,
  uFrmQSearch,
  uFrmOptions,
  DISQLite3Api,
  RichEdit,
  ufrmWordmarks,
  uTextStrings,
  uFrmPopup,
  ufrmAddModify,
  uOvidhanConst;

const
  ColumnNames: array[0..3] of UnicodeString = ('Word', 'Pron', 'POS',
    'Meaning');

procedure TfrmDic.CreateParams(var Params: TCreateParams);
const
  CS_DROPSHADOW = $00020000;
begin
  inherited;
  Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
end;

{ ****************************** N E W    P A R T ****************************** }
{$REGION '          Image Button Procedures         '}

procedure TfrmDic.tmrBtnExitTimer(Sender: TObject);
var
  bf: TBLENDFUNCTION;
begin

  if ExitIcon_MouseIn = True then
  begin
    // blend to over state
    ExitIcon_TranparentValue := ExitIcon_TranparentValue + m_BlendingStep;
    if ExitIcon_TranparentValue >= 255 then
    begin
      (Sender as TTimer)
        .Enabled := False;
      ExitIcon_TranparentValue := 0;
      ExitIcon_DrawState;
      // Icon_MouseIn := False; //
      exit;
    end;

    bf.BlendOp := 0;
    bf.BlendFlags := 0;
    bf.SourceConstantAlpha := ExitIcon_TranparentValue;
    bf.AlphaFormat := 0;

    Windows.AlphaBlend(imgExit.Canvas.Handle, 0, 0, imgExit.Width,
      imgExit.Height, imgExit2.Picture.Bitmap.Canvas.Handle, 0, 0,
      imgExit.Width, imgExit.Height, bf);

  end
  else
  begin
    // blend to up state
    ExitIcon_TranparentValue := ExitIcon_TranparentValue + m_BlendingStep;
    if ExitIcon_TranparentValue >= 255 then
    begin
      (Sender as TTimer)
        .Enabled := False;
      ExitIcon_TranparentValue := 0;
      ExitIcon_DrawState;
      // Icon_MouseIn := true; //
      exit;
    end;

    bf.BlendOp := 0;
    bf.BlendFlags := 0;
    bf.SourceConstantAlpha := ExitIcon_TranparentValue;
    bf.AlphaFormat := 0;

    Windows.AlphaBlend(imgExit.Canvas.Handle, 0, 0, imgExit.Width,
      imgExit.Height, imgExit1.Picture.Bitmap.Canvas.Handle, 0, 0,
      imgExit.Width, imgExit.Height, bf);

  end;

  imgExit.Refresh;
end;

procedure TfrmDic.ExitIcon_DrawDown;
begin
  tmrBtnExit.Enabled := False;
  imgExit.Picture.Bitmap.Assign(imgExit3.Picture.Bitmap);

end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmDic.ExitIcon_DrawState;
begin
  if ExitIcon_MouseDown = False then
  begin

    ExitIcon_DrawUpOver;

  end
  else
  begin

    ExitIcon_DrawDown;

  end;

  imgExit.Refresh;
end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmDic.ExitIcon_DrawUpOver;
begin
  tmrBtnExit.Enabled := False;
  if ExitIcon_MouseIn then
  begin
    // draw over state
    imgExit.Picture.Bitmap.Assign(imgExit2.Picture.Bitmap);

  end
  else
  begin
    // draw up state
    imgExit.Picture.Bitmap.Assign(imgExit1.Picture.Bitmap);
  end;
end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmDic.imgExitMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  ExitIcon_MouseDown := True;
  ExitIcon_DrawState;
end;

procedure TfrmDic.imgExitMouseEnter(Sender: TObject);
begin
  ExitIcon_MouseIn := True;
  ExitIcon_TranparentValue := 0;
  if m_GlowEffect = True then
  begin
    tmrBtnExit.Enabled := True;
  end
  else
  begin
    ExitIcon_DrawState;
  end;
end;

procedure TfrmDic.imgExitMouseLeave(Sender: TObject);
begin
  ExitIcon_MouseIn := False;
  ExitIcon_MouseDown := False;
  ExitIcon_TranparentValue := 0;
  if m_GlowEffect then
  begin
    tmrBtnExit.Enabled := True;
  end
  else
  begin
    ExitIcon_DrawState;
  end;
end;

procedure TfrmDic.imgExitMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  ExitIcon_MouseDown := False;
  ExitIcon_DrawState;
end;

{ ****************************** N E W    P A R T ****************************** }

// Speak

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.tmrBtnSpeakTimer(Sender: TObject);
var
  bf: TBLENDFUNCTION;
begin

  if SpeakIcon_MouseIn = True then
  begin
    // blend to over state
    SpeakIcon_TranparentValue := SpeakIcon_TranparentValue + m_BlendingStep;
    if SpeakIcon_TranparentValue >= 255 then
    begin
      (Sender as TTimer)
        .Enabled := False;
      SpeakIcon_TranparentValue := 0;
      SpeakIcon_DrawState;
      // Icon_MouseIn := False; //
      exit;
    end;

    bf.BlendOp := 0;
    bf.BlendFlags := 0;
    bf.SourceConstantAlpha := SpeakIcon_TranparentValue;
    bf.AlphaFormat := 0;

    Windows.AlphaBlend(imgSpeak.Canvas.Handle, 0, 0, imgSpeak.Width,
      imgSpeak.Height, imgSpeak2.Picture.Bitmap.Canvas.Handle, 0, 0,
      imgSpeak.Width, imgSpeak.Height, bf);

  end
  else
  begin
    // blend to up state
    SpeakIcon_TranparentValue := SpeakIcon_TranparentValue + m_BlendingStep;
    if SpeakIcon_TranparentValue >= 255 then
    begin
      (Sender as TTimer)
        .Enabled := False;
      SpeakIcon_TranparentValue := 0;
      SpeakIcon_DrawState;
      // Icon_MouseIn := true; //
      exit;
    end;

    bf.BlendOp := 0;
    bf.BlendFlags := 0;
    bf.SourceConstantAlpha := SpeakIcon_TranparentValue;
    bf.AlphaFormat := 0;

    Windows.AlphaBlend(imgSpeak.Canvas.Handle, 0, 0, imgSpeak.Width,
      imgSpeak.Height, imgSpeak1.Picture.Bitmap.Canvas.Handle, 0, 0,
      imgSpeak.Width, imgSpeak.Height, bf);

  end;

  imgSpeak.Refresh;
end;

procedure TfrmDic.SpeakIcon_DrawDown;
begin
  tmrBtnSpeak.Enabled := False;
  imgSpeak.Picture.Bitmap.Assign(imgSpeak3.Picture.Bitmap);

end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmDic.SpeakIcon_DrawState;
begin
  if SpeakIcon_MouseDown = False then
  begin

    SpeakIcon_DrawUpOver;

  end
  else
  begin

    SpeakIcon_DrawDown;

  end;

  imgSpeak.Refresh;
end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmDic.SpeakIcon_DrawUpOver;
begin
  tmrBtnSpeak.Enabled := False;
  if SpeakIcon_MouseIn then
  begin
    // draw over state
    imgSpeak.Picture.Bitmap.Assign(imgSpeak2.Picture.Bitmap);

  end
  else
  begin
    // draw up state
    imgSpeak.Picture.Bitmap.Assign(imgSpeak1.Picture.Bitmap);
  end;
end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmDic.imgSpeakMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  SpeakIcon_MouseDown := True;
  SpeakIcon_DrawState;
end;

procedure TfrmDic.imgSpeakMouseEnter(Sender: TObject);
begin
  SpeakIcon_MouseIn := True;
  SpeakIcon_TranparentValue := 0;
  if m_GlowEffect = True then
  begin
    tmrBtnSpeak.Enabled := True;
  end
  else
  begin
    SpeakIcon_DrawState;
  end;
end;

procedure TfrmDic.imgSpeakMouseLeave(Sender: TObject);
begin
  SpeakIcon_MouseIn := False;
  SpeakIcon_MouseDown := False;
  SpeakIcon_TranparentValue := 0;
  if m_GlowEffect then
  begin
    tmrBtnSpeak.Enabled := True;
  end
  else
  begin
    SpeakIcon_DrawState;
  end;
end;

procedure TfrmDic.imgSpeakMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  SpeakIcon_MouseDown := False;
  SpeakIcon_DrawState;
end;

{ ****************************** N E W    P A R T ****************************** }

// QSrc

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.tmrBtnQSrcTimer(Sender: TObject);
var
  bf: TBLENDFUNCTION;
begin

  if QSrcIcon_MouseIn = True then
  begin
    // blend to over state
    QSrcIcon_TranparentValue := QSrcIcon_TranparentValue + m_BlendingStep;
    if QSrcIcon_TranparentValue >= 255 then
    begin
      (Sender as TTimer)
        .Enabled := False;
      QSrcIcon_TranparentValue := 0;
      QSrcIcon_DrawState;
      // Icon_MouseIn := False; //
      exit;
    end;

    bf.BlendOp := 0;
    bf.BlendFlags := 0;
    bf.SourceConstantAlpha := QSrcIcon_TranparentValue;
    bf.AlphaFormat := 0;

    Windows.AlphaBlend(imgQSrc.Canvas.Handle, 0, 0, imgQSrc.Width,
      imgQSrc.Height, imgQSrc2.Picture.Bitmap.Canvas.Handle, 0, 0,
      imgQSrc.Width, imgQSrc.Height, bf);

  end
  else
  begin
    // blend to up state
    QSrcIcon_TranparentValue := QSrcIcon_TranparentValue + m_BlendingStep;
    if QSrcIcon_TranparentValue >= 255 then
    begin
      (Sender as TTimer)
        .Enabled := False;
      QSrcIcon_TranparentValue := 0;
      QSrcIcon_DrawState;
      // Icon_MouseIn := true; //
      exit;
    end;

    bf.BlendOp := 0;
    bf.BlendFlags := 0;
    bf.SourceConstantAlpha := QSrcIcon_TranparentValue;
    bf.AlphaFormat := 0;

    Windows.AlphaBlend(imgQSrc.Canvas.Handle, 0, 0, imgQSrc.Width,
      imgQSrc.Height, imgQSrc1.Picture.Bitmap.Canvas.Handle, 0, 0,
      imgQSrc.Width, imgQSrc.Height, bf);

  end;

  imgQSrc.Refresh;
end;

procedure TfrmDic.QSrcIcon_DrawDown;
begin
  tmrBtnQSrc.Enabled := False;
  imgQSrc.Picture.Bitmap.Assign(imgQSrc3.Picture.Bitmap);

end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmDic.QSrcIcon_DrawState;
begin
  if QSrcIcon_MouseDown = False then
  begin

    QSrcIcon_DrawUpOver;

  end
  else
  begin

    QSrcIcon_DrawDown;

  end;

  imgQSrc.Refresh;
end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmDic.QSrcIcon_DrawUpOver;
begin
  tmrBtnQSrc.Enabled := False;
  if QSrcIcon_MouseIn then
  begin
    // draw over state
    imgQSrc.Picture.Bitmap.Assign(imgQSrc2.Picture.Bitmap);

  end
  else
  begin
    // draw up state
    imgQSrc.Picture.Bitmap.Assign(imgQSrc1.Picture.Bitmap);
  end;
end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmDic.imgQSrcMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  QSrcIcon_MouseDown := True;
  QSrcIcon_DrawState;
end;

procedure TfrmDic.imgQSrcMouseEnter(Sender: TObject);
begin
  QSrcIcon_MouseIn := True;
  QSrcIcon_TranparentValue := 0;
  if m_GlowEffect = True then
  begin
    tmrBtnQSrc.Enabled := True;
  end
  else
  begin
    QSrcIcon_DrawState;
  end;
end;

procedure TfrmDic.imgQSrcMouseLeave(Sender: TObject);
begin
  QSrcIcon_MouseIn := False;
  QSrcIcon_MouseDown := False;
  QSrcIcon_TranparentValue := 0;
  if m_GlowEffect then
  begin
    tmrBtnQSrc.Enabled := True;
  end
  else
  begin
    QSrcIcon_DrawState;
  end;
end;

procedure TfrmDic.imgQSrcMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  QSrcIcon_MouseDown := False;
  QSrcIcon_DrawState;
end;

{ ****************************** N E W    P A R T ****************************** }

// Help

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.tmrBtnHelpTimer(Sender: TObject);
var
  bf: TBLENDFUNCTION;
begin

  if HelpIcon_MouseIn = True then
  begin
    // blend to over state
    HelpIcon_TranparentValue := HelpIcon_TranparentValue + m_BlendingStep;
    if HelpIcon_TranparentValue >= 255 then
    begin
      (Sender as TTimer)
        .Enabled := False;
      HelpIcon_TranparentValue := 0;
      HelpIcon_DrawState;
      // Icon_MouseIn := False; //
      exit;
    end;

    bf.BlendOp := 0;
    bf.BlendFlags := 0;
    bf.SourceConstantAlpha := HelpIcon_TranparentValue;
    bf.AlphaFormat := 0;

    Windows.AlphaBlend(imgHelp.Canvas.Handle, 0, 0, imgHelp.Width,
      imgHelp.Height, imgHelp2.Picture.Bitmap.Canvas.Handle, 0, 0,
      imgHelp.Width, imgHelp.Height, bf);

  end
  else
  begin
    // blend to up state
    HelpIcon_TranparentValue := HelpIcon_TranparentValue + m_BlendingStep;
    if HelpIcon_TranparentValue >= 255 then
    begin
      (Sender as TTimer)
        .Enabled := False;
      HelpIcon_TranparentValue := 0;
      HelpIcon_DrawState;
      // Icon_MouseIn := true; //
      exit;
    end;

    bf.BlendOp := 0;
    bf.BlendFlags := 0;
    bf.SourceConstantAlpha := HelpIcon_TranparentValue;
    bf.AlphaFormat := 0;

    Windows.AlphaBlend(imgHelp.Canvas.Handle, 0, 0, imgHelp.Width,
      imgHelp.Height, imgHelp1.Picture.Bitmap.Canvas.Handle, 0, 0,
      imgHelp.Width, imgHelp.Height, bf);

  end;

  imgHelp.Refresh;
end;

procedure TfrmDic.HelpIcon_DrawDown;
begin
  tmrBtnHelp.Enabled := False;
  imgHelp.Picture.Bitmap.Assign(imgHelp3.Picture.Bitmap);

end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmDic.HelpIcon_DrawState;
begin
  if HelpIcon_MouseDown = False then
  begin

    HelpIcon_DrawUpOver;

  end
  else
  begin

    HelpIcon_DrawDown;

  end;

  imgHelp.Refresh;
end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmDic.HelpIcon_DrawUpOver;
begin
  tmrBtnHelp.Enabled := False;
  if HelpIcon_MouseIn then
  begin
    // draw over state
    imgHelp.Picture.Bitmap.Assign(imgHelp2.Picture.Bitmap);

  end
  else
  begin
    // draw up state
    imgHelp.Picture.Bitmap.Assign(imgHelp1.Picture.Bitmap);
  end;
end;

/// /////////////////////////////////////////////////////////////////////////

procedure TfrmDic.imgHelpMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  HelpIcon_MouseDown := True;
  HelpIcon_DrawState;
end;

procedure TfrmDic.imgHelpMouseEnter(Sender: TObject);
begin
  HelpIcon_MouseIn := True;
  HelpIcon_TranparentValue := 0;
  if m_GlowEffect = True then
  begin
    tmrBtnHelp.Enabled := True;
  end
  else
  begin
    HelpIcon_DrawState;
  end;
end;

procedure TfrmDic.imgHelpMouseLeave(Sender: TObject);
begin
  HelpIcon_MouseIn := False;
  HelpIcon_MouseDown := False;
  HelpIcon_TranparentValue := 0;
  if m_GlowEffect then
  begin
    tmrBtnHelp.Enabled := True;
  end
  else
  begin
    HelpIcon_DrawState;
  end;
end;

procedure TfrmDic.imgHelpMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  HelpIcon_MouseDown := False;
  HelpIcon_DrawState;
end;

{$ENDREGION}
{ ****************************** N E W    P A R T ****************************** }

 /// /////////////////////////////////////////////////////////////////////////
 /// /////////////////////////////////////////////////////////////////////////
 /// /////////////////////////////////////////////////////////////////////////
 /// /////////////////////////////////////////////////////////////////////////
 /// /////////////////////////////////////////////////////////////////////////
 /// /////////////////////////////////////////////////////////////////////////
 /// /////////////////////////////////////////////////////////////////////////
 /// /////////////////////////////////////////////////////////////////////////
 /// /////////////////////////////////////////////////////////////////////////
 /// /////////////////////////////////////////////////////////////////////////

procedure TfrmDic.tmrUpdateCheckTimer(Sender: TObject);
begin

  if IsConnected then
  begin

    tmrUpdateCheck.Enabled := False;

    Execute_Something(AppDir + 'SOCommon.exe');

  end
  else
  begin

    tmrUpdateCheck.Interval := (5 * 60 * 1000);

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.btnAboutClick(Sender: TObject);
begin

  // pMenuHelp.Popup(left + imgHelp.left + 15, top + imgHelp.top + 15);

  CheckCreateForm(TfrmPopup, frmPopup, 'frmpopup');

  frmPopup.SetComponents(1, left + imgHelp.left, top + imgHelp.top);

  frmPopup.Show;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.btnBnOptClick(Sender: TObject);
begin
  if pnlBnOpt.Visible then
    pnlBnOpt.Visible := False
  else
    pnlBnOpt.Visible := True;
end;

procedure TfrmDic.btnEnOptClick(Sender: TObject);
begin

  pnlHistory.Visible := False;

  if pnlEnOpt.Visible then
    pnlEnOpt.Visible := False
  else
    pnlEnOpt.Visible := True;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.btnExitClick(Sender: TObject);
begin

  self.Close;

end;

procedure TfrmDic.SaveWordmarks(Sender: TObject);
var
{$IFDEF PortableOn}
  wmPath: string;
{$ELSE}
  strUserName: PChar;
  unSize: DWord;
  wmPath: string;
{$ENDIF}
begin

  try
{$IFDEF PortableOn}
    wmPath := 'Wordmarks.iwdb';
{$ELSE}
    unSize := 250;
    GetMem(strUserName, unSize);
    getusername(strUserName, unSize);
    wmPath := 'Wordmarks_' + strPas(strUserName) + '.iwdb';
    FreeMem(strUserName);
{$ENDIF}
    if ForceDirectories(GetShadhinDataDir) then
    begin

      (Sender as TJvListBox)
        .Items.SaveToFile(GetShadhinDataDir + wmPath, TEncoding.Unicode);

    end
    else
    begin

      ShowMessage('You does not have sufficient file access rights!');

    end;

  except
    on E: Exception do
    begin
      ErrMsg(E, '54V3#W02DM42K5');
    end;
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.btnMinClick(Sender: TObject);
begin

  frmDic.WindowState := wsMinimized;

  // imgBtnMin.Repaint;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  Action := caFree;

  frmDic := nil;

end;

procedure TfrmDic.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  begin

    SetSettings;
    SaveWordmarks(lstBoxAnto);
{$IFDEF PortableOn}
    RemoveAppFont;
{$ENDIF}
    Application.Terminate;

  end;

  CanClose := True;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.FormDestroy(Sender: TObject);
begin
  DISQLiteDBMain.Free;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.LoadDataBase;
var
  ID, RowCount: integer;
  Stmt: TDISQLite3Statement;
begin

  { Prepare the select statement. }
  Stmt := DISQLiteDBMain.Prepare16('SELECT * from ovidhan' +
    ' WHERE _id like ''a%''');
  // + //
  // ' ORDER BY Pron ASC');
  // OLD: 0(nothing) 2(POS) 1(Word) 3(Pron) 4(Meaning) 5(Synonyms)
  try
    RowCount := 1;
    while Stmt.Step = SQLITE_ROW do
    begin
      ID := Stmt.Column_Int(0);
      SetGridRow(RowCount, ID,
        { Column "Name" is stored as TEXT, so we can retrieve it as a string. }
        Stmt.Column_Str16(1),

        Stmt.Column_Str16(2),

        Stmt.Column_Str16(3),

        Stmt.Column_Str16(4),

        Stmt.Column_Str16(5));
      Inc(RowCount);
    end;
    strGMainDic.RowCount := RowCount;
  finally
    Stmt.Free;
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.FromCreate(Sender: TObject);
var
  { Shaped Form }
  ShapeBG: HRGN;

  loop: integer;

begin

  { Shaped Form }
  ShapeBG := CreateRoundRectRgn(0, 0, 700, 550, 11, 11);
  // ( Left, Top, Width, Height, Circle -, Circle | )
  SetWindowRgn(Handle, ShapeBG, True);
  DeleteObject(ShapeBG);

  //get from Avro Source, don't no what it does!
  Application.ProcessMessages;

  { Set Application Default Dir }
  AppDir := ExtractFilePath(Application.ExeName);
{$IFDEF PortableOn}

  DBdir := ExtractFilePath(Application.ExeName);

{$ELSE}

  if ForceDirectories(GetShadhinDataDir) then
    DBdir := GetShadhinDataDir;

  GetSettings;

  if (FileExists(DBdir + 'IW.Lib.SO.dll') = False)
    or (confDBvar <> intDbVersion) then
  begin
    if MyCopyFile(AppDir + 'IW.Lib.SO.dll',
      DBdir + 'IW.Lib.SO.dll', True) = False then
    begin
      InfoMsg('Database failed to load! ErrCode: SO20004');
    end;

  end;

{$ENDIF}

  strAppName := 'Shadhin Ovidhan';
  strVersion := AppVersionInfo
{$IFDEF BetaVersion} + strVersionAddiText{$ENDIF}
{$IFDEF PortableOn} + ' (Portable)'
{$ENDIF}
  ;

  lblVersion.Caption := strVersion;

  { Voice }
  voice := CreateOLEObject('SAPI.SpVoice');

  { Get & Set Setting & Components }
  //GetSettings;
  SetComponents;

  { Set up the string grid. }
  strGMainDic.ColCount := 5;
  { ORGINAL:
    strGMainDic.Options := strGMainDic.Options + [goColSizing, goThumbTracking]; }
  strGMainDic.Options := strGMainDic.Options + [goThumbTracking];
  strGMainDic.FixedCols := 0;
  SetGridRow(0, -1, ColumnNames[0], ColumnNames[1], ColumnNames[2],
    ColumnNames[3]);
  SetGridRow(0);

  // Load Data Base
  DISQLiteDBMain.DatabaseName := DBdir + 'IW.Lib.SO.dll';

  DISQLiteDBMain.Open;

  // Load DB
  // **********************************************************************
  strGMainDic.Cols[0].Text := 'Word';
  strGMainDic.Cols[1].Text := 'POS';
  strGMainDic.Cols[2].Text := 'Meaning';

  // LoadDataBase;

    try

      LoadDataBase;

    except
      on E: ESQLite3 do
      begin

          InfoMsg('Error Code: 20005' + #10 + #10 + strErrSryMsg);
          self.Close;

      end;
    end;
//
//  until False;

  strGMainDic.RowHeights[0] := 24;
  strGMainDic.ColWidths[0] := 160;
  strGMainDic.ColWidths[1] := 85;
  strGMainDic.ColWidths[2] := 415;

  strGMainDic.SortGrid(0);

  strGMainDic.HideCol(3);
  strGMainDic.HideCol(4);
  // *********************************************************************

  { Relocate Text Bn Hints }
  lblHints.left := (Width div 2) - (lblHints.Width div 2) - 20;

  { Load Wordmarks }
  LoadWordmarks;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.SetComponents;
begin

  { Form Background }
  frmDic.Brush.Bitmap := imgBG.Picture.Bitmap;
  // imgBG.Picture.Bitmap.FreeImage;

  { Search Style }
  case confIntEnSrcType of
    1:
      begin
        rBtnEnS1.Checked := True;
      end;
    2:
      begin
        rBtnEnS2.Checked := True;
      end;
    3:
      begin
        rBtnEnS3.Checked := True;
      end;
  end;

  case confIntBnSrcType of
    1:
      begin
        rBtnBnS1.Checked := True;
      end;
    2:
      begin
        rBtnBnS2.Checked := True;
      end;
    3:
      begin
        rBtnBnS3.Checked := True;
      end;
  end;

  { Speech Rate }
  voice.rate := confVoiceRate;

  { Update check }
  if confUpdateCheck then
    tmrUpdateCheck.Enabled := True;

  { OnTop Button }
  if confOvidhanTop then
  begin
    frmDic.FormStyle := fsStayOnTop;
    imgBtnOnTop.Picture := imgBtnOntop2.Picture;
  end
  else
  begin
    frmDic.FormStyle := fsNormal;
    imgBtnOnTop.Picture := imgBtnOntop1.Picture;
  end;

  { Images Get Ready }
  imgEnSrcOpt.Picture := imgBnSrcOpt.Picture;

  imgBtnMin.Picture := imgBtnMin1.Picture;
  imgBtnExit.Picture := imgBtnExit1.Picture;

  imgHelp.Picture := imgHelp1.Picture;
  imgQSrc.Picture := imgQSrc1.Picture;
  imgSpeak.Picture := imgSpeak1.Picture;
  imgExit.Picture := imgExit1.Picture;

  imgBtnEnOpt.Picture := imgSrcOpt1.Picture;
  imgBtnBnOpt.Picture := imgSrcOpt1.Picture;

  imgEnSrcReset.Picture := imgSrcReset1.Picture;
  imgBnSrcReset.Picture := imgSrcReset1.Picture;

  imgLike.Picture := imgLike2.Picture;

  imgEnSrcHistory.Picture := imgEnSrcHistory1.Picture;

  if confOvidhanTop then
    imgBtnOnTop.Picture := imgBtnOntop2.Picture
  else
    imgBtnOnTop.Picture := imgBtnOntop1.Picture;

  { Set Hints }
  txtEnSrc.Hint := strOvidhanSrcEditHint;
  txtBnSrc.Hint := strOvidhanSrcEditHint;

  { Others }
  pnlImgs.top := 2000;

  ChangeFont(confOvidhanFont);

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.ChangeFont(const FontName: string);
begin

  if FontName <> confOvidhanFont then
  begin

    if Screen.Fonts.IndexOf(FontName) = -1 then
    begin

      exit;

    end;

    confOvidhanFont := FontName;

  end;

  memoMeaning.Font.Name := confOvidhanFont;

  memoMeaning.Font.Size := confOvidhanFontSize;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.RemoveAppFont;
begin

  if IsFontInstalled then
  begin
    RemoveFontResource(PChar(AppDir + 'NirmalaUI.TTF'));
    RemoveFontResource(PChar(AppDir + 'NirmalaUIB.TTF'));
    SendMessage(HWND_BROADCAST, WM_FONTCHANGE, 0, 0);
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.LoadWordmarks;
var
  { WORDMARKS }
{$IFDEF PortableOn}
  wmPath: string;
{$ELSE}
  strUserName: PChar;
  unSize: DWord;
  wmPath: string;
{$ENDIF}
begin

  // Load WORDMARKS
{$IFDEF PortableOn}
  wmPath := 'Wordmarks.iwdb';
{$ELSE}
  unSize := 250;
  GetMem(strUserName, unSize);
  getusername(strUserName, unSize);

  wmPath := 'Wordmarks_' + strPas(strUserName) + '.iwdb';

  FreeMem(strUserName);
{$ENDIF}
  if FileExists(GetShadhinDataDir + wmPath) then
  begin

    lstBoxAnto.Items.Clear;

    lstBoxAnto.Items.LoadFromFile(GetShadhinDataDir + wmPath,
      TEncoding.Unicode);

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

{ Helper routine to set one row in the StringGrid. }

procedure TfrmDic.SetGridRow(const ARowIdx: integer; const AID: integer = -1;
  const AWord: UnicodeString = ''; const APOS: UnicodeString = '';
  const APron: UnicodeString = ''; const AMeaning: UnicodeString = '';
  const ASynonyms: UnicodeString = ''; const AAntonyms: UnicodeString = '');
var
  Row: TStrings;
begin

  Row := strGMainDic.Rows[ARowIdx];
  Row[0] := AWord;
  Row.Objects[0] := TObject(AID);
  Row[1] := APOS;
  Row.Objects[1] := TObject(AID);
  Row[2] := APron;
  Row.Objects[2] := TObject(AID);
  Row[3] := AMeaning;
  Row.Objects[3] := TObject(AID);
  Row[4] := ASynonyms;
  Row.Objects[4] := TObject(AID);
  Row[5] := AAntonyms;
  Row.Objects[5] := TObject(AID);

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.SearchNow;
var
  SrcSQL: string;
  strTxt: string;

  ID, RowCount: integer;
  Stmt: TDISQLite3Statement;

  del: integer;
begin

  if (boolBnSearch = False) then
  begin

    if (txtEnSrc.Text <> '') then
    begin

      strTxt := stringreplace(
        stringreplace(stringreplace(stringreplace(txtEnSrc.Text, ' ',
        '', [rfReplaceAll, rfIgnoreCase]), '-', '', [rfReplaceAll,
        rfIgnoreCase]),
          '.', '', [rfReplaceAll, rfIgnoreCase]), '''', '',
        [rfReplaceAll, rfIgnoreCase]);

      del := 0;

      repeat

        strTxt := copy(strTxt, 0, length(strTxt) - del);

        case confIntEnSrcType of
          1:
            begin
              SrcSQL := 'WHERE _id like ''' + strTxt + '%''';
            end;
          2:
            begin
              SrcSQL := 'WHERE _id like ''%' + strTxt + '%''';
            end;
          3:
            begin
              SrcSQL := 'WHERE _id like ''%' + strTxt + '''';
            end;
        end;

        { Prepare the select statement. }
        Stmt := DISQLiteDBMain.Prepare16('SELECT * from ovidhan ' + SrcSQL);
        // + ' ORDER BY Pron ASC');

        del := 1;

      until Stmt.StepAndReset <> 101;

      if Stmt.StepAndReset <> 101 then
      begin

        try
          RowCount := 1;
          while Stmt.Step = SQLITE_ROW do
          begin
            ID := Stmt.Column_Int(0);
            SetGridRow(RowCount, ID,
              { Column "Name" is stored as TEXT, so we can retrieve it as a string. }
              Stmt.Column_Str16(1),

              Stmt.Column_Str16(2),

              Stmt.Column_Str16(3),

              Stmt.Column_Str16(4),

              Stmt.Column_Str16(5));
            Inc(RowCount);
          end;
          strGMainDic.RowCount := RowCount;
        finally
          Stmt.Free;
        end;

      end
      else
      begin

        Stmt.Free;

      end;

      strGMainDic.SortGrid(0);
      strGMainDic.ActivateCell(1, 1);

    end;

  end
  else if (boolBnSearch = True) then // ******************************
  begin

    if (txtBnSrc.Text <> '') then
    begin

      case confIntBnSrcType of
        1:
          begin
            SrcSQL := 'WHERE Meaning like ''' + txtBnSrc.Text + '%''';
          end;
        2:
          begin
            SrcSQL := 'WHERE Meaning like ''%' + txtBnSrc.Text + '%''';
          end;
        3:
          begin
            SrcSQL := 'WHERE Meaning like ''%' + txtBnSrc.Text + '''';
          end;
      end;

      { Prepare the select statement. }
      Stmt := DISQLiteDBMain.Prepare16('SELECT * from ovidhan ' + SrcSQL);
      // + ' ORDER BY Pron ASC');

      if Stmt.StepAndReset <> 101 then
      begin

        try
          RowCount := 1;
          while Stmt.Step = SQLITE_ROW do
          begin
            ID := Stmt.Column_Int(0);
            SetGridRow(RowCount, ID,
              { Column "Name" is stored as TEXT, so we can retrieve it as a string. }
              Stmt.Column_Str16(1),

              Stmt.Column_Str16(2),

              Stmt.Column_Str16(3),

              Stmt.Column_Str16(4),

              Stmt.Column_Str16(5));
            Inc(RowCount);
          end;
          strGMainDic.RowCount := RowCount;
        finally
          Stmt.Free;
        end;

      end
      else
      begin

        Stmt.Free;

      end;

      strGMainDic.SortGrid(0);
      strGMainDic.ActivateCell(1, 1);

    end;

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.txtBnSrcChange(Sender: TObject);
begin

  if (txtBnSrc.Text <> '') then
  begin

    boolBnSearch := True;

    SearchNow;

    imgBnSrcReset.Visible := True;

  end
  else
  begin

    imgBnSrcReset.Visible := False;

  end;

end;

procedure TfrmDic.txtBnSrcEnter(Sender: TObject);
begin
  txtEnSrc.Text := '';
end;

procedure TfrmDic.txtBnSrcKeyDown(Sender: TObject; var Key: word; Shift:
  TShiftState);
var
  Msg: TMsg;
begin
  case Key of
    65..90:
      begin
        PeekMessage(Msg, 0, WM_CHAR, WM_CHAR, PM_REMOVE);
      end;
  end;

  { **********************************************************************

    A = 65   Z = 90
    a = 97

    ********************************************************************** }

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.txtEnSrcChange(Sender: TObject);
begin

  if (txtEnSrc.Text <> '') then
  begin

    boolBnSearch := False;

    SearchNow;

    imgEnSrcReset.Visible := True;

  end
  else
  begin

    imgEnSrcReset.Visible := False;

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.txtEnSrcEnter(Sender: TObject);
begin
  txtBnSrc.Text := '';
end;

procedure TfrmDic.txtEnSrcKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then { Esc => 27 }
  begin
    Key := #0;

    (Sender as TEdit).Text := '';

  end;

  if Key = #13 then { VK_RETURN => 13 }
  begin
    Key := #0;

    if txtEnSrc.Text <> '' then
    begin
      voice.speak(txtEnSrc.Text, 1);
    end;

  end;

  if not ((Key >= #0) and (Key <= #127)) then
  begin
    Key := #0;
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.txtSrcKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #27 then { Esc => 27 }
  begin
    Key := #0;

    (Sender as TEdit).Text := '';

  end;

  if Key = #13 then { VK_RETURN => 13 }
  begin
    Key := #0;

    if txtEnSrc.Text <> '' then
    begin
      voice.speak(txtEnSrc.Text, 1);
    end;

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.imgBtnOnTopClick(Sender: TObject);
begin
  if frmDic.FormStyle = fsNormal then
  begin
    frmDic.FormStyle := fsStayOnTop;
    imgBtnOnTop.Picture := imgBtnOntop2.Picture;
    confOvidhanTop := True;
  end
  else
  begin
    frmDic.FormStyle := fsNormal;
    imgBtnOnTop.Picture := imgBtnOntop1.Picture;
    confOvidhanTop := False;
  end;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.imgEnSrcHistoryClick(Sender: TObject);
begin

  pnlEnOpt.Visible := False;

  if pnlHistory.Visible then
    pnlHistory.Visible := False
  else
    pnlHistory.Visible := True;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.imgEnSrcResetClick(Sender: TObject);
begin
  txtEnSrc.Text := '';
  imgEnSrcReset.Visible := False;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.imgIWlogoClick(Sender: TObject);
begin
  Open_URL(strLogoURL);
end;

procedure TfrmDic.imgLikeClick(Sender: TObject);
begin

  Open_URL(strIWfbPage);

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.imgRemoveWordClick(Sender: TObject);
var
  intTemp: integer;
begin

  if lstBoxAnto.ItemIndex <> -1 then
  begin
    intTemp := lstBoxAnto.ItemIndex;
    lstBoxAnto.Items.Delete(intTemp);
    if Isformvisible('frmWordmarks') then
      frmWordmarks.JvLstBoxWM.Items.Delete(intTemp);
  end
  else
    ShowMessage('Select a Word first!');

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.imgShowModifyClick(Sender: TObject);
var
  ID, RowCount: integer;
  Stmt: TDISQLite3Statement;
begin

  txtEnSrc.Text := '';
  txtBnSrc.Text := '';

  { Prepare the select statement. }
  Stmt := DISQLiteDBMain.Prepare16('SELECT * from ovidhan' +
    ' WHERE Modify = ''1'''); // + //
  // ' ORDER BY Pron ASC');

  if Stmt.StepAndReset <> 101 then
  begin

    try
      RowCount := 1;
      while Stmt.Step = SQLITE_ROW do
      begin
        ID := Stmt.Column_Int(0);
        SetGridRow(RowCount, ID,
          { Column "Name" is stored as TEXT, so we can retrieve it as a string. }
          Stmt.Column_Str16(1),

          Stmt.Column_Str16(2),

          Stmt.Column_Str16(3),

          Stmt.Column_Str16(4),

          Stmt.Column_Str16(5));
        Inc(RowCount);
      end;
      strGMainDic.RowCount := RowCount;
    finally
      Stmt.Free;
    end;

  end
  else
  begin

    Stmt.Free;
    ShowMessage('No MODIFIED entry found!');

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.imgShowNewClick(Sender: TObject);
var
  ID, RowCount: integer;
  Stmt: TDISQLite3Statement;
begin

  txtEnSrc.Text := '';
  txtBnSrc.Text := '';

  { Prepare the select statement. }
  Stmt := DISQLiteDBMain.Prepare16('SELECT * from ovidhan' +
    ' WHERE (New = ''1'')');
  // + //
  // ' ORDER BY Pron ASC');

  if Stmt.StepAndReset <> 101 then
  begin
    try
      RowCount := 1;
      while Stmt.Step = SQLITE_ROW do
      begin
        ID := Stmt.Column_Int(0);
        SetGridRow(RowCount, ID,
          { Column "Name" is stored as TEXT, so we can retrieve it as a string. }
          Stmt.Column_Str16(1),

          Stmt.Column_Str16(2),

          Stmt.Column_Str16(3),

          Stmt.Column_Str16(4),

          Stmt.Column_Str16(5));
        Inc(RowCount);
      end;
      strGMainDic.RowCount := RowCount;
    finally
      Stmt.Free;
    end;

  end
  else
  begin

    Stmt.Free;
    ShowMessage('No NEW entry found!');

  end;

end;

procedure TfrmDic.imgShowWMClick(Sender: TObject);
begin

  CheckCreateForm(TfrmWordmarks, frmWordmarks, 'frmWordmarks');
  frmWordmarks.Show;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.imgAddMeaningClick(Sender: TObject);
begin

  CheckCreateForm(TfrmAddModify, frmAddModify, 'frmAddModify');
  frmAddModify.Show;

  self.Enabled := False;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.imgChangeFontClick(Sender: TObject);
begin

  CheckCreateForm(TfrmPopup, frmPopup, 'frmpopup');

  frmPopup.SetComponents(2, left + imgChangeFont.left, top + imgChangeFont.top);

  frmPopup.Show;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.imgAddWordClick(Sender: TObject);
begin

  if lstBoxAnto.Items.IndexOf(strWord) = -1 then
  begin
    lstBoxAnto.Items.Add(strWord);
    if Isformvisible('frmWordmarks') then
      frmWordmarks.JvLstBoxWM.Items.Add(strWord);
  end
  else
    ShowMessage('''' + strWord + ''' already in Wordmark!');

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.imgBnSrcResetClick(Sender: TObject);
begin
  txtBnSrc.Text := '';
  imgBnSrcReset.Visible := False;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.lstBoxAntoClick(Sender: TObject);
begin
  if lstBoxAnto.ItemIndex <> -1 then
  begin

    if lstBoxAnto.Items.Strings[0] <> '' then
    begin
      if (copy(lstBoxAnto.Items.Strings[lstBoxAnto.ItemIndex], 0, 1) < #127)
        then
      begin
        txtBnSrc.Text := '';
        txtEnSrc.Text := lstBoxAnto.Items.Strings[lstBoxAnto.ItemIndex];
        addtoHistory;
      end
      else
      begin
        txtEnSrc.Text := '';
        txtBnSrc.Text := lstBoxAnto.Items.Strings[lstBoxAnto.ItemIndex];
      end;
    end;

  end;
end;

procedure TfrmDic.lstboxHistoryClick(Sender: TObject);
begin
  if lstboxHistory.Items.Count <> 0 then
    txtEnSrc.Text := lstboxHistory.Items.Strings[lstboxHistory.ItemIndex];
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.lstBoxSynoClick(Sender: TObject);
begin
  if lstBoxSyno.Items.Strings[0] <> ':(' then
  begin
    txtEnSrc.Text := lstBoxSyno.Items.Strings[lstBoxSyno.ItemIndex];
    addtoHistory;
  end;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.pnlTitleMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    TForm(frmDic).Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.strGMainDicClick(Sender: TObject);
begin

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.strGMainDicDblClick(Sender: TObject);
begin
  if strWord <> '' then

    voice.speak(strWord, 1);
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.strGMainDicDrawCell(Sender: TObject; ACol, ARow: integer;
  Rect: TRect; State: TGridDrawState);
var
  strText, strNewText: string;
begin

  strText := strGMainDic.Cells[ACol, ARow];

  // Select Row Coloring
  if (gdSelected in State) then
  begin

    strGMainDic.Canvas.Brush.Color := $00EEEEEE;

  end
  else
  begin

    strGMainDic.Canvas.Brush.Color := clWhite;

  end;

  // Row draws
  if ACol = 2 then
  begin

    if Length(strText) > 60 then
    begin

      strNewText := Copy(strText, 0, 60) + '...';
      strGMainDic.Canvas.FillRect(Rect);
      strGMainDic.Canvas.TextOut(Rect.left + 2, Rect.top + 2, strNewText);

    end
    else
    begin

      strGMainDic.Canvas.FillRect(Rect);
      strGMainDic.Canvas.TextOut(Rect.left + 2, Rect.top + 2, strText);

    end;

  end
  else
  begin
    strGMainDic.Canvas.FillRect(Rect);
    strGMainDic.Canvas.TextOut(Rect.left + 2, Rect.top + 2, strText);
  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.strGMainDicMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin

  addtoHistory;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.addtoHistory;
begin

  if strWord <> '' then
  begin

    if imgEnSrcHistory.Visible = False then
      imgEnSrcHistory.Visible := True;

    if lstboxHistory.Items.IndexOf(strWord) = -1 then
      lstboxHistory.Items.Add(strWord);

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.strGMainDicSelectCell(Sender: TObject; ACol, ARow: integer;
  var CanSelect: boolean);
var
  txtstr: string;
  i: integer;
begin

  strWord := strGMainDic.Cols[0].Strings[ARow];

  strOvidhanMeaning := strGMainDic.Cols[2].Strings[ARow];

  strPOS := strGMainDic.Cols[1].Strings[ARow];

  SetFullMeaning;

  /// ///////////////////////////////////////////////////////////////////

  // rEditSyno.Clear;    //(X)

  lstBoxSyno.Clear;

  strSynonyms := strGMainDic.Cols[3].Strings[ARow];

  if strGMainDic.Cols[3].Strings[ARow] = '' then
  begin
    lstBoxSyno.Items.Add(':(');
  end
  else
  begin

    SplitStrings(strGMainDic.Cols[3].Strings[ARow], ';', lstBoxSyno.Items);

    i := 0;

    while (i < lstBoxSyno.Items.Count) do
    begin
      txtstr := lstBoxSyno.Items.Strings[i];
      if (AnsiLeftStr(txtstr, 1) = ' ') then
      begin
        lstBoxSyno.Items[i] := TrimLeft(txtstr);
      end;

      Inc(i);

    end;

  end;

  /// ///////////////////////////////////////////////////////////////////

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.SetFullMeaning;
begin

  strMeaning := strOvidhanMeaning;

  if (strPOS = '') or (strPOS = '-') then
    memoMeaning.Text := strMeaning
  else
    memoMeaning.Text := strPOS + ' - ' + strMeaning;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.btnQSrcClick(Sender: TObject);
begin
  self.Hide;

  TrimAppMemorySize;

  CheckCreateForm(TfrmQSearch, frmQSearch, 'frmQSearch');
  frmQSearch.Show;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.DicDBGridDblClick(Sender: TObject);
begin

  voice.speak(strWord, 1);

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.DicDBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: integer; Column: TColumn; State: TGridDrawState);

begin

  with TCustomDBGridCracker(Sender) do
    if DataLink.ActiveRecord = Row - 1 then
    begin
      Canvas.Font.Color := clBlack;
      Canvas.Brush.Color := $00F5F4F4;
      DefaultDrawColumnCell(Rect, DataCol, Column, State);

    end
    else
    begin
      Canvas.Brush.Color := clWhite;
      DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;

end;

{ ****************************** N E W    P A R T ****************************** }
{$REGION '          Image Up-Down Events          '}

procedure TfrmDic.imgBtnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin

  if Sender.ClassType = TImage then
  begin
    with Sender as TImage do
    begin
      if Name = 'imgBtnMin' then
      begin
        imgBtnMin.Picture := imgBtnMin3.Picture;
      end
      else if Name = 'imgBtnExit' then
      begin
        imgBtnExit.Picture := imgBtnExit3.Picture;
      end
      else if Name = 'imgBtnEnOpt' then
      begin
        imgBtnEnOpt.Picture := imgSrcOpt3.Picture;
      end
      else if Name = 'imgBtnBnOpt' then
      begin
        imgBtnBnOpt.Picture := imgSrcOpt3.Picture;
      end
      else if Name = 'imgEnSrcReset' then
      begin
        imgEnSrcReset.Picture := imgSrcReset3.Picture;
      end
      else if Name = 'imgBnSrcReset' then
      begin
        imgBnSrcReset.Picture := imgSrcReset3.Picture;
      end
      else if Name = 'imgEnSrcHistory' then
      begin
        imgEnSrcHistory.Picture := imgEnSrcHistory3.Picture;
      end
      else if Name = 'imgLike' then
      begin
        imgLike.Picture := imgLike2.Picture;
      end;
    end;
  end;

end;

procedure TfrmDic.imgBtnMouseEnter(Sender: TObject);
begin

  imgBtnReset(Sender);

end;

procedure TfrmDic.imgBtnMouseLeave(Sender: TObject);
begin

  if Sender.ClassType = TImage then
  begin
    with Sender as TImage do
    begin
      if Name = 'imgBtnMin' then
      begin
        imgBtnMin.Picture := imgBtnMin1.Picture;
      end
      else if Name = 'imgBtnExit' then
      begin
        imgBtnExit.Picture := imgBtnExit1.Picture;
      end
      else if Name = 'imgBtnEnOpt' then
      begin
        imgBtnEnOpt.Picture := imgSrcOpt1.Picture;
      end
      else if Name = 'imgBtnBnOpt' then
      begin
        imgBtnBnOpt.Picture := imgSrcOpt1.Picture;
      end
      else if Name = 'imgEnSrcReset' then
      begin
        imgEnSrcReset.Picture := imgSrcReset1.Picture;
      end
      else if Name = 'imgBnSrcReset' then
      begin
        imgBnSrcReset.Picture := imgSrcReset1.Picture;
      end
      else if Name = 'imgEnSrcHistory' then
      begin
        imgEnSrcHistory.Picture := imgEnSrcHistory1.Picture;
      end
      else if Name = 'imgLike' then
      begin
        imgLike.Picture := imgLike2.Picture;
      end;
    end;
  end;

end;

procedure TfrmDic.imgBtnMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin

  imgBtnReset(Sender);

end;

procedure TfrmDic.imgBtnReset(Sender: TObject);
begin

  if Sender.ClassType = TImage then
  begin
    with Sender as TImage do
    begin
      if Name = 'imgBtnMin' then
      begin
        imgBtnMin.Picture := imgBtnMin2.Picture;
      end
      else if Name = 'imgBtnExit' then
      begin
        imgBtnExit.Picture := imgBtnExit2.Picture;
      end
      else if Name = 'imgBtnEnOpt' then
      begin
        imgBtnEnOpt.Picture := imgSrcOpt2.Picture;
      end
      else if Name = 'imgBtnBnOpt' then
      begin
        imgBtnBnOpt.Picture := imgSrcOpt2.Picture;
      end
      else if Name = 'imgEnSrcReset' then
      begin
        imgEnSrcReset.Picture := imgSrcReset2.Picture;
      end
      else if Name = 'imgBnSrcReset' then
      begin
        imgBnSrcReset.Picture := imgSrcReset2.Picture;
      end
      else if Name = 'imgEnSrcHistory' then
      begin
        imgEnSrcHistory.Picture := imgEnSrcHistory2.Picture;
      end
      else if Name = 'imgLike' then
      begin
        imgLike.Picture := imgLike1.Picture;
      end;
    end;
  end;

end;

{$ENDREGION}
{ ****************************** N E W    P A R T ****************************** }
{$REGION '          Cut, Copy & Paste Menu          '}

procedure TfrmDic.pMenuTxtPopup(Sender: TObject);
begin

  if pMenuTxt.PopupComponent.ClassType = TEdit then
  begin
    miCut.Enabled := True;
    miPaste.Enabled := True;
    with pMenuTxt.PopupComponent do
    begin
      if Name = 'txtEnSrc' then
      begin

        if txtEnSrc.Text <> '' then
          miAddToWM.Caption := 'Add "' + txtEnSrc.Text + '" to WORDMARKS'
        else
          miAddToWM.Caption := 'Add "' + strWord + '" to WORDMARKS';

      end
      else if Name = 'txtBnSrc' then
      begin

        if txtBnSrc.Text <> '' then
          miAddToWM.Caption := 'Add "' + txtBnSrc.Text + '" to WORDMARKS'
        else
          miAddToWM.Caption := 'Add "' + strWord + '" to WORDMARKS';

      end
      else if Name = 'txtSrc' then
      begin
        if frmQSearch.txtSrc.Text <> '' then
          miAddToWM.Caption :=
            'Add "' + frmQSearch.txtSrc.Text + '" to WORDMARKS'
        else
          miAddToWM.Caption := 'Add "' + strWord + '" to WORDMARKS';
      end;
    end;

  end
  else if pMenuTxt.PopupComponent.ClassType = TJvMemo then
  begin
    miCut.Enabled := False;
    miPaste.Enabled := False;

    miAddToWM.Caption := 'Add "' + strWord + '" to WORDMARKS';

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.miAddToWMClick(Sender: TObject);
var
  strWordTemp: string;
begin

  strWordTemp := strWord;

  if pMenuTxt.PopupComponent.ClassType = TEdit then
  begin
    with pMenuTxt.PopupComponent do
    begin
      if Name = 'txtEnSrc' then
      begin

        if txtEnSrc.Text <> '' then
          strWordTemp := txtEnSrc.Text;

      end
      else if Name = 'txtBnSrc' then
      begin

        if txtBnSrc.Text <> '' then
          strWordTemp := txtBnSrc.Text;

      end
      else if Name = 'txtSrc' then
      begin

        if frmQSearch.txtSrc.Text <> '' then
          strWordTemp := frmQSearch.txtSrc.Text;

      end;
    end;
  end;

  if lstBoxAnto.Items.IndexOf(strWordTemp) = -1 then
  begin
    lstBoxAnto.Items.Add(strWordTemp);
    if Isformvisible('frmWordmarks') then
      frmWordmarks.JvLstBoxWM.Items.Add(strWordTemp);
  end
  else
    ShowMessage('''' + strWordTemp + ''' already in Wordmark!');

end;

procedure TfrmDic.miCopyClick(Sender: TObject);
begin

  if pMenuTxt.PopupComponent.ClassType = TEdit then
  begin

    (pMenuTxt.PopupComponent as TEdit)
      .CopyToClipboard;

  end
  else if pMenuTxt.PopupComponent.ClassType = TJvMemo then
  begin

    (pMenuTxt.PopupComponent as TJvMemo)
      .CopyToClipboard;

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.miCutClick(Sender: TObject);
begin

  if pMenuTxt.PopupComponent.ClassType = TEdit then
  begin

    (pMenuTxt.PopupComponent as TEdit)
      .CutToClipboard;

  end;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure TfrmDic.miPasteClick(Sender: TObject);
begin

  if pMenuTxt.PopupComponent.ClassType = TEdit then
  begin

    (pMenuTxt.PopupComponent as TEdit)
      .PasteFromClipboard;

  end;

end;

{$ENDREGION}
{ ****************************** N E W    P A R T ****************************** }
{$REGION '          Search Modes          '}

procedure TfrmDic.rBtnBnSIntClick(Sender: TObject);
begin
  if rBtnBnS1.Checked then
  begin
    confIntBnSrcType := 1;
  end
  else if rBtnBnS2.Checked then
  begin
    confIntBnSrcType := 2;
  end
  else if rBtnBnS3.Checked then
  begin
    confIntBnSrcType := 3;
  end;
end;

procedure TfrmDic.rBtnEnSIntClick(Sender: TObject);
begin
  if rBtnEnS1.Checked then
  begin
    confIntEnSrcType := 1;
  end
  else if rBtnEnS2.Checked then
  begin
    confIntEnSrcType := 2;
  end
  else if rBtnEnS3.Checked then
  begin
    confIntEnSrcType := 3;
  end;
end;

{$ENDREGION}
{ ****************************** N E W    P A R T ****************************** }
{$REGION '          Down Short Descriptions         '}

procedure TfrmDic.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y:
  integer);
begin
  if Sender.ClassType = TJvStringGrid then
  begin
    lblHints.Caption := strDblClkToSpeak;
  end
  else if Sender.ClassType = TfrmDic then
  begin
    lblHints.Caption := strReady;
  end
  else if Sender.ClassType = TEdit then
  begin
    with Sender as TEdit do
    begin
      if Name = 'txtEnSrc' then
      begin
        lblHints.Caption := strEnSearchBox;
      end
      else
      begin
        lblHints.Caption := strBnSearchBox;
      end;
    end;
  end
  else if Sender.ClassType = TImage then
  begin
    with Sender as TImage do
    begin
      if Name = 'imgBtnMin' then
      begin
        lblHints.Caption := strMinimize;
      end
      else if Name = 'imgBtnExit' then
      begin
        lblHints.Caption := strClose;
      end
      else if Name = 'imgAbout' then
      begin
        lblHints.Caption := strAbout;
      end
      else if Name = 'imgQSrc' then
      begin
        lblHints.Caption := strQuickSrc;
      end
      else if Name = 'imgSpeak' then
      begin
        lblHints.Caption := strSpeak;
      end
      else if Name = 'imgExit' then
      begin
        lblHints.Caption := strClose;
      end
      else if (Name = 'imgBtnEnOpt') or (Name = 'imgEnSrcOpt') or
        (Name = 'imgBtnBnOpt') or (Name = 'imgBnSrcOpt') then
      begin
        lblHints.Caption := strSelectSrcMode;
      end
      else if (Name = 'imgEnSrcReset') or (Name = 'imgBnSrcReset') then
      begin
        lblHints.Caption := strClearSrcBox;
      end
      else if Name = 'imgBtnOnTop' then
      begin
        lblHints.Caption := strAlwaysOnTop;
      end
      else if (Name = 'imgDrag') or (Name = 'imgBG') then
      begin
        lblHints.Caption := strReady;
      end
      else if Name = 'imgOptions' then
      begin
        lblHints.Caption := strSettings;
      end
      else if Name = 'imgShowWM' then
      begin
        lblHints.Caption := strOpenWMs;
      end
      else if Name = 'imgAddWord' then
      begin
        lblHints.Caption := strWMsAddWord;
      end
      else if Name = 'imgRemoveWord' then
      begin
        lblHints.Caption := strWMsDelWord;
      end
      else if Name = 'imgEnSrcHistory' then
      begin
        lblHints.Caption := strSrcHistory;
      end
      else if Name = 'imgAddMeaning' then
      begin
        lblHints.Caption := strAddEditEntry;
      end
      else if Name = 'imgHelp' then
      begin
        lblHints.Caption := strHelp;
      end
      else if Name = 'imgLike' then
      begin
        lblHints.Caption := strLikeUsFb;
      end
      else if Name = 'imgChangeFont' then
      begin
        lblHints.Caption := strBnFontCng;
      end
      else if Name = 'imgShowNew' then
      begin
        lblHints.Caption := strShowNewEntry;
      end
      else if Name = 'imgShowModify' then
      begin
        lblHints.Caption := strShowEditedEntry;
      end;
    end;
  end
  else if Sender.ClassType = TPanel then
  begin
    with Sender as TPanel do
    begin
      if (Name = 'pnlTitle') or (Name = 'pnlDown') then
      begin
        lblHints.Caption := strReady;
      end;
    end;
  end
  else if Sender.ClassType = TJvListBox then
  begin
    with Sender as TJvListBox do
    begin
      if Name = 'lstBoxSyno' then
      begin
        lblHints.Caption := strSynoBox;
      end
      else if Name = 'lstBoxAnto' then
      begin
        lblHints.Caption := strWMsBox;
      end
      else if Name = 'lstBoxHistory' then
      begin
        lblHints.Caption := strSrcHistory;
      end;
    end;
  end
  else if Sender.ClassType = TJvMemo then
  begin
    with Sender as TJvMemo do
    begin
      if Name = 'memoMeaning' then
      begin
        lblHints.Caption := strFullMeaning;
      end;
    end;
  end;

  lblHints.left := (Width div 2) - (lblHints.Width div 2) - 20;

end;

{$ENDREGION}
{ ****************************** N E W    P A R T ****************************** }

initialization

  { Initialize the DISQLite3 library prior to using any other DISQLite3
    functionality. See also sqlite3_shutdown() below. }
  sqlite3_initialize;

finalization

  { Deallocate any resources that were allocated by
    sqlite3_initialize() above. }
  sqlite3_shutdown;

end.

