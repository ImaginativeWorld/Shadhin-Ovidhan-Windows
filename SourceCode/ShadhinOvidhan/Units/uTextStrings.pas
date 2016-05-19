{
 *******************************************************************
 This Source Code Form is subject to the terms of the Mozilla Public
 License, v. 2.0. If a copy of the MPL was not distributed with this
 file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *******************************************************************
}

unit uTextStrings;

interface

const

  { Version Text }
  strVersionAddiText: string = 'BETA';
  //Not needed to change it. Coz programatically it assigned when needed.
  //Only add BETA number (when needed).

  { Error }
  strExeNotFound: string =
    'Some executable file of Shadhin Ovidhan not found!' +
    #10 + 'Please reinstall Shadhin Ovidhan to solve this problem.';

  { Main Ovidhan }
  strOvidhanSrcEditHint: string = 'Press <Enter> to Speak it!' + #10 + //
    'Press <Esc> to clear search box.';

  { Quick Search }
  strSrcEditHint: string = 'Press <Enter> to Speak it!' + #10 + //
    'Press <Esc> to exit Quick Search.';
  strStrGridHint: string = 'Double click to Speak it!';

  { Requests }
  strIfItBug: string =
    'If you think this is a Bug then please let us know about this problem.';
  strErrSryMsg: string = 'We are extremely sorry for this problem.' + #10 +
    'Please let us know about this problem.';

  strIWEmail: string = 'E-mail: info@imaginativeworld.org';
  strIWfbPage: string = 'https://www.facebook.com/Imaginative.World.BD';

  strLogoURL: string = 'http://imaginativeworld.org';
  strSOAndroidURL: string = 'http://imaginativeworld.org/products/shadhin-ovidhan-android/';

  strAlreadyRunning: string = ' is already running on this system and' + //
    ' running more than one instance is not allowed.' + //
    #10 + #10 + 'If you have any objection with that please let us know.';

  { Like Us }
  strLikeUsMsg: string = 'Thank you for using Shadhin Ovidhan.' + //
    #10 + #10 + //
    'Feel free to Feedback us: info@imaginativeworld.org' + //
    #10 + #10 + //
    'Please Donate your 30 sec and Like us on Facebook.' + //
    #10 + //
    'Do you want to go our Facebook Page now?' + //
    #10 + '(www.facebook.com/Imaginative.World.BD)';


  { Meaning List }
  strErrSelectAEntry: string = 'Select a entry first!';

  { Bangla Calendar }
  strBnCalFontNotFound: string = 'Your selected font not found on your computer!' + #10 +
  'Install the font first and try again.';

  intDbVersion: integer = 5; // Details log in Android Source file

implementation

{
  ERROR CODES:

  20001: uAdditionalDict => LoadDict => CopyFile
  20002: Feedback => Download finish procedure
  20003: Feedback => Download finish procedure [with ToString]
  20004: ufrmDic => Database copy in programData
  20005: ufrmDic => Connection Error

}

end.
