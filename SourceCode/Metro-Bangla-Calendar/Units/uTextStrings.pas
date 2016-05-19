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

unit uTextStrings;

interface

uses
  Forms, uFunctions;

const

  //  { Version Text }
  //  strVersionAddiText: string = 'BETA';
  //  //Not needed to change it. Coz programatically it assigned when needed.
  //  //Only add BETA number (when needed).
  //
    { Error }
  strExeNotFound: string =
    'Some executable file of Shadhin Ovidhan not found!' +
    #10 + 'Please reinstall Shadhin Ovidhan to solve this problem.';

  { Requests }
  strIfItBug: string =
    'If you think this is a Bug then please let us know about this problem.';

  strIWEmail: string = 'E-mail: info@imaginativeworld.org';

  strLogoURL: string = 'http://imaginativeworld.org';

  strAlreadyRunning: string = ' is already running on this system and' + //
  ' running more than one instance is not allowed.' + //
  #10 + #10 + 'If you have any objection with that please let us know.';

  { Bangla Calendar }
  strBnCalFontNotFound: string = 'Your selected font not found on your computer!'
    + #10 +
    'Install the font first and try again.';

  strAboutText: string = 'Metro Bangla Calendar (for Shadhin Ovidhan)'
  + #10 + 'Version: ' + '1.1'
  + #10
  + #10 + 'An Opensource project lisense under MPL 2.0.'
  + #10 + 'Copyright © Imaginative World. All rights researved.'
  + #10 + 'http://imaginativeworld.org' ;

implementation

end.

