# Shadhin Ovidhan Desktop #
Shadhin Ovidhan Desktop - Unicode based Open-source Bengali-English-Bengali Dictionary.

Visit: [http://imaginativeworld.org/products/shadhin-ovidhan/](http://imaginativeworld.org/products/shadhin-ovidhan/ "Imaginative World") for latest version.


## How to compile: ##

This section describes briefly how to compile Shadhin Ovidhan Desktop from source. 

1. If you need further help regarding codes from Imaginative World, 
you can contact us at: [http://blog.imaginativeworld.org/feedback](http://blog.imaginativeworld.org/feedback "Imaginative World Feedback")

2. If you need assistance regarding codes from 3rd party
libraries used in Shadhin Ovidhan Desktop (see below for list), contact respective authors of that library.


## Required Delphi Version: ##

**Delphi 2010**


## Required 3rd party libraries:  ##


This source includes the following 3rd party libraries:

**Before compiling, you have to install the following 3rd party
libraries in you Delphi environment:**

1. **DISQLite3**.
Freeware (Not open source).
Site: http://www.yunqa.de/

2. **ICS**.
Freeware with Source Code.
Site: http://www.overbyte.be/

3. **Delphi Jedi (JVCL and JCL)**.
Open source.
Site: http://www.delphi-jedi.org/

If you are ready with the above mentions requirements,
the delphi project files (*.dpr) should be compiled without any problem.

## Building Standard and Portable editions ##
Open _ProjectDefines.inc_ file in the root folder of the source.

For building portable edition, add the following line in this file and compile:

    {$Define PortableOn} 

For building standard edition, remove the above line from the
file or make it a comment like the following and then compile:

    {.$Define PortableOn} 
or,

    //{$Define PortableOn} 

## Portable edition - extra note ##
Portable version of Shadhin Ovidhan need some extra files e.g. fonts, IComplex.exe etc. Those should be in same folder with portable version of Shadhin Ovidhan.

## Portable Wizard - extra note ##
Portable wizard need following required files in a sub-folder named "Tools":
 - IComplex.exe
 - Kalpurush.TTF
 - Nirmala.TTF
 - NirmalaB.TTF
 - NirmalaS.TTF
 - SiyamRupali.TTF
 - Shadhin_Ovidhan_Launcher.exe
 - ShadhinOvidhan.exe (Portable version)
 - SOBanglaAidKit.exe

## Folder Definitions ##
- **Help_Data:** It has the html, css and image files needed by "SOHelp.exe". The folder should be in same folder with "SOHelp.exe" file.
- **Other Files:** Here other files e.g. fonts etc. needed by Shadhin Ovidhan are given.
- **Databases:** All the database are found here. Database files should have **".dll"** extension to work with executable files.

**See full file list and how to arrange files, by installing latest version of Shadhin Ovidhan.**

## License ##

From version 2x, Shadhin Ovidhan Desktop goes open source from freeware, licensed under **MOZILLA PUBLIC LICENSE Version 2.0**. You should receive a copy of the license in MPL-2.0.txt file with both binaries and source. An online version of the license can be found at: [http://www.mozilla.org/MPL/](http://www.mozilla.org/MPL/ "http://www.mozilla.org/MPL/")

**Copyright © Imaginative World. All Rights Reserved.**