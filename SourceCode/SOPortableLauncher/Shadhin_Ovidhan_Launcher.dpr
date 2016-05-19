{
 *******************************************************************
 This Source Code Form is subject to the terms of the Mozilla Public
 License, v. 2.0. If a copy of the MPL was not distributed with this
 file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *******************************************************************
}

program Shadhin_Ovidhan_Launcher;

uses
  Forms,
  ShellAPI,
  SysUtils,
  Windows,
  Messages,
  uTextStrings in '..\ShadhinOvidhan\Units\uTextStrings.pas';

{$R *.res}
{$R ../ShadhinOvidhan.REC}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  Application.Title := 'Shadhin Ovidhan Launcher';
  Application.Run;

  if FileExists(ExtractFilePath(Application.ExeName) +
      'SOData\ShadhinOvidhan.exe') then
  begin

    if Screen.Fonts.IndexOf('Nirmala UI') = -1 then
    begin

      AddFontResource(PChar(ExtractFilePath(Application.ExeName)
            + 'SOData\NirmalaUI.TTF'));
      AddFontResource(PChar(ExtractFilePath(Application.ExeName)
            + 'SOData\NirmalaUIB.TTF'));

      SendMessage(HWND_BROADCAST, WM_FONTCHANGE, 0, 0);
      ShellExecute(Application.Handle, 'open',
        PChar(ExtractFilePath(Application.ExeName)
            + 'SOData\ShadhinOvidhan.exe'), '-VFont',
        PChar(ExtractFilePath(Application.ExeName) + 'SOData\'),
        SW_SHOWNORMAL);

    end
    else
    begin

      ShellExecute(Application.Handle, 'open',
        PChar(ExtractFilePath(Application.ExeName)
            + 'SOData\ShadhinOvidhan.exe'), Nil,
        PChar(ExtractFilePath(Application.ExeName) + 'SOData\'),
        SW_SHOWNORMAL);

    end;

  end
  else
  begin
    Application.MessageBox(PChar('Error Description:' + #10 +
          'Shadhin Ovidhan executable file not found!' + #10 + #10 + #10 +
          'Please reinstall your portable version.' + #10 + #10 + #10 +
          strIfItBug + #10 + strIWEmail)
        , 'Shadhin Ovidhan Launcher | Info',
      MB_OK + MB_ICONHAND + MB_DEFBUTTON1 + MB_APPLMODAL);
  end;

end.
