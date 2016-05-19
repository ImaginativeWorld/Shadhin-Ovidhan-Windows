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
