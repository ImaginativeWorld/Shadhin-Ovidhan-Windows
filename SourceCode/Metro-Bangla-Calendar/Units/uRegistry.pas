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

unit uRegistry;

interface

uses
  Registry,
  SysUtils;

// Custom Registry class
Type
  TMyRegistry = Class(TRegistry)
  Public
    Function ReadStringDef(Const Name: String; DefaultVal: String = ''): String;
    // Function ReadDateDef(Const Name: String; DefaultVal: TDateTime): TDateTime;
  End;

implementation

// Function TMyRegistry.ReadDateDef(Const Name: String; DefaultVal: TDateTime): TDateTime;
// Begin
// Try
// If ValueExists(Name) = True Then Begin
// Result := ReadDateTime(Name);
// End
// Else Begin
// Result := DefaultVal;
// End;
// Except
// On E: Exception Do
// Result := DefaultVal;
// End;
// End;

{ ------------------------------------------------------ }

Function TMyRegistry.ReadStringDef(Const Name: String;
  DefaultVal: String = ''): String;
Begin
  Try
    If ValueExists(Name) = True Then
    Begin
      Result := ReadString(Name);
    End
    Else
    Begin
      Result := DefaultVal;
    End;
  Except
    On E: Exception Do
      If Trim(Result) = '' Then
        Result := DefaultVal;
  End;
End;

end.
