/// <aboutDev>
///
/// Project:
///     Metro Bangla Calendar (for Shadhin Ovidhan)
///
/// Documentation:
///     Md. Mahmudul Hasan Shohag
///     Founder, CEO of Imaginative World
///     http://shohag.imaginativeworld.org
///
/// Lisence:
///     Opensource project lisense under MPL 2.0.
///     Copyright © Imaginative World. All rights researved.
///     http://imaginativeworld.org
///
/// **************************************************
///     This Source Code Form is subject to the
///     terms of the Mozilla Public License, v.
///     2.0. If a copy of the MPL was not
///     distributed with this file, You can obtain
///     one at http://mozilla.org/MPL/2.0/.
/// **************************************************
///
/// </aboutDev>

{ *******************************************************

  Bangla Calender Unit

  Copyright (c) Md. Mahmudul Hasan Shohag

  Give me feedback and bug report:
  shohag_iw@yahoo.com


  Version: 1.0
  Last Update: 26 November 2013

  ******************************************************* }

{ ******************************************************************

  How to use:

  Uses
  ComCtrls, SysUtils, DateUtils;

  ... ... ...
  ... ... ...

  Var
  MCalendar: TMonthCalendar;

  ... ... ...
  ... ... ...

  uses
  uBanglaCalendar;

  ... ... ...
  ... ... ...

  procedure TMain.FormCreate(Sender: TObject);
  Begin

  MCalendar := TMonthCalendar.Create(self);
  MCalendar.Date := DateOf(Now);
  BanglaDate(MCalendar);
  lblBnDate.caption := BnFullDate;
  FreeAndNil(MCalendar);

  End;

  ****************************************************************** }

unit uBanglaCalendar;

interface

uses
  DateUtils,
  SysUtils,
  comCtrls,
  Dialogs,
  StrUtils;

// type

procedure BanglaDate(calendar: TMonthCalendar);
function NumberAsciiToUnicode(const Text: integer): string;

var
  // StrMonth, StrWeek, StrEnMonth: string;
  StrMonth, StrWeek: string;

  // BnFullDate, TempBnFullDate: string;
  BnDay, BnMonth, BnYear: string;
  // EnFullDate: String;

  StrDay, StrYear: Integer;
  // intBnDay, intBnMonth, intMonth: Integer;
  intMonth: Integer;

implementation

// uses

// --------------------------------------------------------------------------//
procedure BanglaDate(calendar: TMonthCalendar);
var
  LeapYear: Integer;

begin
  // For Freezing Error

  // Get Is Leap Year --------------------------------------------------------//
  if isLeapYear(yearof(calendar.Date)) then
  begin
    LeapYear := 0;
  end
  else
  begin
    LeapYear := 1;
  end;

  // Get Bangla Name ------------------------------------------------//
  if ((DayOfTheYear(calendar.Date)) >= (105 - LeapYear)) and
    ((DayOfTheYear(calendar.Date)) <= (135 - LeapYear)) then
  begin
    StrMonth := 'বৈশাখ'; // '     "বৈশাখ"
    intMonth := 1;
  End

  else if ((DayOfTheYear(calendar.Date)) >= (136 - LeapYear)) and
    ((DayOfTheYear(calendar.Date)) <= (166 - LeapYear)) then
  begin
    StrMonth := 'জ্যৈষ্ঠ'; // '      "জ্যৈষ্ঠ"
    intMonth := 2;
  End

  else if ((DayOfTheYear(calendar.Date)) >= (167 - LeapYear)) and
    ((DayOfTheYear(calendar.Date)) <= (197 - LeapYear)) then
  begin
    StrMonth := 'আষাঢ়'; // '     "আষাঢ়"
    intMonth := 3;
  End

  else if ((DayOfTheYear(calendar.Date)) >= (198 - LeapYear)) and
    ((DayOfTheYear(calendar.Date)) <= (228 - LeapYear)) then
  begin
    StrMonth := 'শ্রাবণ'; // '     "শ্রাবণ"
    intMonth := 4;
  End
  else if ((DayOfTheYear(calendar.Date)) >= (229 - LeapYear)) and
    ((DayOfTheYear(calendar.Date)) <= (259 - LeapYear)) then
  begin
    StrMonth := 'ভাদ্র'; // '      "ভাদ্র"
    intMonth := 5;
  End
  else if ((DayOfTheYear(calendar.Date)) >= (260 - LeapYear)) and
    ((DayOfTheYear(calendar.Date)) <= (289 - LeapYear)) then
  begin
    StrMonth := 'আশ্বিন'; // '     "আশ্বিন"
    intMonth := 6;
  End
  else if ((DayOfTheYear(calendar.Date)) >= (290 - LeapYear)) and
    ((DayOfTheYear(calendar.Date)) <= (319 - LeapYear)) then
  begin
    StrMonth := 'কার্তিক'; // '     "কার্তিক"
    intMonth := 7;
  End
  else if ((DayOfTheYear(calendar.Date)) >= (320 - LeapYear)) and
    ((DayOfTheYear(calendar.Date)) <= (349 - LeapYear)) then
  begin
    StrMonth := 'অগ্রহায়ণ'; // '     "অগ্রহায়ণ"
    intMonth := 8;
  End
  else if ((DayOfTheYear(calendar.Date)) >= (350 - LeapYear)) and
    ((DayOfTheYear(calendar.Date)) <= (366 - LeapYear)) then
  begin
    StrMonth := 'পৌষ'; // '     "পৌষ" '-'
    intMonth := 9;
  End
  else if ((DayOfTheYear(calendar.Date)) >= 1) and
    ((DayOfTheYear(calendar.Date)) <= 13) then
  begin
    StrMonth := 'পৌষ'; // '     "পৌষ" '-'
    intMonth := 9;
  End
  else if ((DayOfTheYear(calendar.Date)) >= 14) and
    ((DayOfTheYear(calendar.Date)) <= 43) then
  begin
    StrMonth := 'মাঘ'; // '     "মাঘ"
    intMonth := 10;
  End
  else if ((DayOfTheYear(calendar.Date)) >= 44) and
    ((DayOfTheYear(calendar.Date)) <= (74 - LeapYear)) then
  begin
    StrMonth := 'ফাল্গুন'; // '     "ফাল্গুন"
    intMonth := 11;
  End
  else if ((DayOfTheYear(calendar.Date)) >= (75 - LeapYear)) and
    ((DayOfTheYear(calendar.Date)) <= (104 - LeapYear)) then
  begin
    StrMonth := 'চৈত্র'; // '     "চৈত্র"
    intMonth := 12;
  End;

  // Get Bangla Date --------------------------------------------------------//
  // 'January
  if (DayOfTheYear(calendar.Date) >= 1) and (DayOfTheYear(calendar.Date) <= 13)
    then
  begin
    StrDay := DayOfTheYear(calendar.Date) + 17;
  End
  else if (DayOfTheYear(calendar.Date) >= 14) and
    (DayOfTheYear(calendar.Date) <= 31) then
  begin
    StrDay := DayOfTheYear(calendar.Date) - 13;
  End
  // 'February
  else if (DayOfTheYear(calendar.Date) >= 32) and
    (DayOfTheYear(calendar.Date) <= 43) then
  begin
    StrDay := DayOfTheYear(calendar.Date) - 13;
  End
  else if (DayOfTheYear(calendar.Date) >= 44) and
    (DayOfTheYear(calendar.Date) <= (60 - LeapYear)) then
  begin
    StrDay := DayOfTheYear(calendar.Date) - 43;
  End

  // 'March
  else if (DayOfTheYear(calendar.Date) >= (61 - LeapYear)) and
    (DayOfTheYear(calendar.Date) <= (74 - LeapYear)) then
  begin
    StrDay := DayOfTheYear(calendar.Date) - 43;
  End
  else if (DayOfTheYear(calendar.Date) >= (75 - LeapYear)) and
    (DayOfTheYear(calendar.Date) <= (91 - LeapYear)) then
  begin
    StrDay := DayOfTheYear(calendar.Date) - (74 - LeapYear);
  End

  // 'April
  else if (DayOfTheYear(calendar.Date) >= (92 - LeapYear)) and
    (DayOfTheYear(calendar.Date) <= (104 - LeapYear)) then
  begin
    StrDay := DayOfTheYear(calendar.Date) - (74 - LeapYear);
  End
  else if (DayOfTheYear(calendar.Date) >= (105 - LeapYear)) and
    (DayOfTheYear(calendar.Date) <= (121 - LeapYear)) then
  begin
    StrDay := DayOfTheYear(calendar.Date) - (104 - LeapYear);
  End

  // 'May
  else if (DayOfTheYear(calendar.Date) >= (122 - LeapYear)) and
    (DayOfTheYear(calendar.Date) <= (135 - LeapYear)) then
  begin
    StrDay := DayOfTheYear(calendar.Date) - (104 - LeapYear);
  End
  else if (DayOfTheYear(calendar.Date) >= (136 - LeapYear)) and
    (DayOfTheYear(calendar.Date) <= (152 - LeapYear)) then
  begin
    StrDay := DayOfTheYear(calendar.Date) - (135 - LeapYear);
  End

  // 'June
  else if (DayOfTheYear(calendar.Date) >= (153 - LeapYear)) and
    (DayOfTheYear(calendar.Date) <= (166 - LeapYear)) then
  begin
    StrDay := DayOfTheYear(calendar.Date) - (135 - LeapYear);
  End
  else if (DayOfTheYear(calendar.Date) >= (167 - LeapYear)) and
    (DayOfTheYear(calendar.Date) <= (182 - LeapYear)) then
  begin
    StrDay := DayOfTheYear(calendar.Date) - (166 - LeapYear);
  End

  // 'july
  else if (DayOfTheYear(calendar.Date) >= (183 - LeapYear)) and
    (DayOfTheYear(calendar.Date) <= (197 - LeapYear)) then
  begin
    StrDay := DayOfTheYear(calendar.Date) - (166 - LeapYear);
  End
  else if (DayOfTheYear(calendar.Date) >= (198 - LeapYear)) and
    (DayOfTheYear(calendar.Date) <= (213 - LeapYear)) then
  begin
    StrDay := DayOfTheYear(calendar.Date) - (197 - LeapYear);
  End

  // 'August
  else if (DayOfTheYear(calendar.Date) >= (214 - LeapYear)) and
    (DayOfTheYear(calendar.Date) <= (228 - LeapYear)) then
  begin
    StrDay := DayOfTheYear(calendar.Date) - (197 - LeapYear);
  End
  else if (DayOfTheYear(calendar.Date) >= (229 - LeapYear)) and
    (DayOfTheYear(calendar.Date) <= (244 - LeapYear)) then
  begin
    StrDay := DayOfTheYear(calendar.Date) - (228 - LeapYear);
  End

  // 'September
  else if (DayOfTheYear(calendar.Date) >= (245 - LeapYear)) and
    (DayOfTheYear(calendar.Date) <= (259 - LeapYear)) then
  begin
    StrDay := DayOfTheYear(calendar.Date) - (228 - LeapYear);
  End
  else if (DayOfTheYear(calendar.Date) >= (260 - LeapYear)) and
    (DayOfTheYear(calendar.Date) <= (274 - LeapYear)) then
  begin
    StrDay := DayOfTheYear(calendar.Date) - (259 - LeapYear);
  End

  // 'October
  else if (DayOfTheYear(calendar.Date) >= (275 - LeapYear)) and
    (DayOfTheYear(calendar.Date) <= (289 - LeapYear)) then
  begin
    StrDay := DayOfTheYear(calendar.Date) - (259 - LeapYear);
  End
  else if (DayOfTheYear(calendar.Date) >= (290 - LeapYear)) and
    (DayOfTheYear(calendar.Date) <= (305 - LeapYear)) then
  begin
    StrDay := DayOfTheYear(calendar.Date) - (289 - LeapYear);
  End

  // 'November
  else if (DayOfTheYear(calendar.Date) >= (306 - LeapYear)) and
    (DayOfTheYear(calendar.Date) <= (319 - LeapYear)) then
  begin
    StrDay := DayOfTheYear(calendar.Date) - (289 - LeapYear);
  End
  else if (DayOfTheYear(calendar.Date) >= (320 - LeapYear)) and
    (DayOfTheYear(calendar.Date) <= (335 - LeapYear)) then
  begin
    StrDay := DayOfTheYear(calendar.Date) - (319 - LeapYear);
  End

  // 'December
  else if (DayOfTheYear(calendar.Date) >= (336 - LeapYear)) and
    (DayOfTheYear(calendar.Date) <= (349 - LeapYear)) then
  begin
    StrDay := DayOfTheYear(calendar.Date) - (319 - LeapYear);
  End
  else if (DayOfTheYear(calendar.Date) >= (350 - LeapYear)) and
    (DayOfTheYear(calendar.Date) <= (366 - LeapYear)) then
  begin
    StrDay := DayOfTheYear(calendar.Date) - (349 - LeapYear);
  End;

  // Get Bangla Year -------------------------------------------------------//
  if LeapYear = 1 then
  begin

    case DayOfTheYear(calendar.Date) of
      1 .. 103:
        Begin
          StrYear := yearof(calendar.Date) - 594;
        End;
      104 .. 365:
        Begin
          StrYear := yearof(calendar.Date) - 593;
        End;
    end;

  end
  else
  begin

    Case DayOfTheYear(calendar.Date) of
      1 .. 104:
        begin
          StrYear := yearof(calendar.Date) - 594;
        end;
      105 .. 366:
        Begin
          StrYear := yearof(calendar.Date) - 593;
        End;
    end;

  end;

  // Week Bangla Name
  case DayOfTheWeek(calendar.Date) of
    1:
      begin
        StrWeek := 'সোমবার' // সোমবার"
      end;
    2:
      begin
        StrWeek := 'মঙ্গলবার' // মঙ্গলবার"
      end;
    3:
      begin
        StrWeek := 'বুধবার' // বুধবার"
      end;
    4:
      begin
        StrWeek := 'বৃহস্পতিবার' // বৃহস্পতিবার"
      end;
    5:
      begin
        StrWeek := 'শুক্রবার' // শুক্রবার"
      end;
    6:
      begin
        StrWeek := 'শনিবার' // শনিবার"
      end;
    7:
      begin
        StrWeek := 'রবিবার' // রবিবার"
      end;
  end;

  // Month Bangla Name
  // case MonthOf(calendar.Date) of
  // 1:
  // begin
  // StrEnMonth := 'Rvbyqvwi'; // January
  // end;
  // 2:
  // begin
  // StrEnMonth := '†deª“qvwi'; // February
  // end;
  // 3:
  // begin
  // StrEnMonth := 'gvP©'; // March
  // end;
  // 4:
  // begin
  // StrEnMonth := 'GwcÖj'; // April
  // end;
  // 5:
  // begin
  // StrEnMonth := '†g'; // May
  // end;
  // 6:
  // begin
  // StrEnMonth := 'Ryb'; // June
  // end;
  // 7:
  // begin
  // StrEnMonth := 'RyjvB'; // July
  // end;
  // 8:
  // begin
  // StrEnMonth := 'AvM÷'; // August
  // end;
  // 9:
  // begin
  // StrEnMonth := '†m‡Þ¤^i'; // September
  // end;
  // 10:
  // begin
  // StrEnMonth := 'A‡±vei'; // October
  // end;
  // 11:
  // begin
  // StrEnMonth := 'b‡f¤^i'; // November
  // end;
  // 12:
  // begin
  // StrEnMonth := 'wW‡m¤^i'; // December
  // end;
  // end;

  // Set Strings and integers
//  intBnDay := StrDay;
//  intBnMonth := intMonth;


  BnDay:=NumberAsciiToUnicode(StrDay);
  BnMonth:=StrMonth;
  BnYear:=NumberAsciiToUnicode(StrYear);

end;

function NumberAsciiToUnicode(const Text: integer): string;
begin
  result := //
    ReplaceText //
    (ReplaceText //
      (ReplaceText //
        (ReplaceText //
          (ReplaceText //
            (ReplaceText //
              (ReplaceText //
                (ReplaceText //
                  (ReplaceText //
                    (ReplaceText //
                      (inttostr(Text), //
                      '1', '১'), //
                    '2', '২'), //
                  '3', '৩'), //
                '4', '৪'), //
              '5', '৫'), //
            '6', '৬'), //
          '7', '৭'), //
        '8', '৮'), //
      '9', '৯'), //
    '0', '০');
end;

end.
