{
 *******************************************************************
 This Source Code Form is subject to the terms of the Mozilla Public
 License, v. 2.0. If a copy of the MPL was not distributed with this
 file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *******************************************************************
}

{
***************************************************************************

Coded by-
  Md. Mahmudul Hasan Shohag
  Founder, CEO of Imaginative World
  E-mail: imaginativeshohag@yahoo.com

Lisense-
  USE as YOU WANT! :)

Version: 1.0

***************************************************************************

How to Use:

DOs:

  * Creat a TLabel (Ex. Label1) and a TTimer (Ex. Timer1).

  * Change TForm's properties like this:
    DoubleBuffered  : True  //Its reduce fade effect flicker

  * Change TLabel's properties like this:
    Alignment   : taCenter
    Caption     : Blank
    AutoSize    : False
    Color       : clWhite
    Height      : 150
    Layout      : tlCenter
    transparent : False
    Width       : 250

CODEs:

  * On FromShow event:

procedure TForm1.FormShow(Sender: TObject);
var
  CreditsText: String;
begin
  lblCredits.Caption := '';

  CreditsText :=
    'Part 1: Line 1' +
    '|' +  // Use "|" as a Part Separetor
        ...    ...
    'Part 2: Line 1' + #10 +
    'Part 2: Line 2' +
    '|' + // Use "|" as a Part Separetor
        ...    ...
    'Part 3: Line 1' + #10 +
    'Part 3: Line 2' + #10 +
    'Part 3: Line 3';

  ReadyFadeEffect(CreditsText);

  Timer1.Interval := 50;
  Timer1.Enabled := True;

End;

//--------------------------------------------------------------------------

  * On Timer event:

procedure TForm1.Timer1Timer(Sender: TObject);
begin

  LabelFadeEffect(Label1, Timer1, total_part_number);
  //total_part_number = total number of segment in the text.
  //e.g. upper example text has 3 part

end;

//--------------------------------------------------------------------------

  * On Form Close event:

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin

DistroyLabelFadeEffect

end;

***************************************************************************
Yeap! you are ready to run! :)
***************************************************************************
}

unit uLabelFadeEffect;

interface

uses
  StdCtrls, { All components u get here. Ex. TLabel }
  ExtCtrls, { All Extra Components u get here. Ex. TTimer }
  Graphics, { Gfx thing. Ex. Color }
  Classes, { Clesses. Ex. TStringList }
  SysUtils, { System Utility. Ex. StringReplace }
  Dialogs; { Message Box's }

procedure LabelFadeEffect(const LabelName: TLabel; TimerName: TTimer;
  intTextPart: integer);
procedure CreditsFade(const LabelName: TLabel; strText: String);
procedure DoFade(const LabelName: TLabel; TimerName: TTimer);
Procedure ReadyFadeEffect(Const strText: String);
procedure DistroyLabelFadeEffect;

var
  intColor: integer;
  intText: integer;
  strTextList: TStringList;

implementation

uses
  uFunctions;

Procedure ReadyFadeEffect(Const strText: String);
begin
  intColor := 0;
  intText := -1;

  strTextList := TStringList.Create;

  SplitStrings(strText,'|',strTextList); // External Function

  strTextList.Add('');

end;

{ ****************************** N E W    P A R T ****************************** }

procedure LabelFadeEffect(const LabelName: TLabel; TimerName: TTimer;
  intTextPart: integer);
begin
  if intColor < 11 then
  begin
    intColor := intColor + 1;
    DoFade(LabelName, TimerName);
  end
  else
  begin
    intColor := 1;
    if intText < (intTextPart) then
    begin
      intText := intText + 1;
    end
    else
    begin
      intText := 0
    end;

    CreditsFade(LabelName, strTextList[intText]);
    DoFade(LabelName, TimerName);
  end;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure CreditsFade(const LabelName: TLabel; strText: String);
begin

  LabelName.Caption := strText;

end;

{ ****************************** N E W    P A R T ****************************** }

procedure DoFade(const LabelName: TLabel; TimerName: TTimer);
begin

  case intColor of
    1:
      begin
        LabelName.Font.Color := clWhite;
      end;
    2:
      begin
        LabelName.Font.Color := $00CCCCCC;
      end;
    3:
      begin
        LabelName.Font.Color := $00999999;
      end;
    4:
      begin
        LabelName.Font.Color := $00666666;
      end;
    5:
      begin
        LabelName.Font.Color := $00333333;
      end;
    6:
      begin
        LabelName.Font.Color := clBlack; // Center

        TimerName.Interval := 5000;

      end;
    7:
      begin
        LabelName.Font.Color := $00333333;

        TimerName.Interval := 50;
      end;
    8:
      begin
        LabelName.Font.Color := $00666666;
      end;
    9:
      begin
        LabelName.Font.Color := $00999999;
      end;
    10:
      begin
        LabelName.Font.Color := $00CCCCCC;
      end;
    11:
      begin
        LabelName.Font.Color := clWhite;
      end;
  end;
end;

{ ****************************** N E W    P A R T ****************************** }

procedure DistroyLabelFadeEffect;
begin

strTextList.Destroy;

end;

end.
