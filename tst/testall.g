#############################################################################
##
##  HAPPRIME - testall.g
##  Test the package with some examples
##  Paul Smith
##
##  Copyright (C)  2008
##  National University of Ireland Galway
##  Copyright (C)  2011
##  University of St Andrews
##
##  This file is part of HAPprime. 
## 
##  HAPprime is free software; you can redistribute it and/or modify
##  it under the terms of the GNU General Public License as published by
##  the Free Software Foundation; either version 2 of the License, or
##  (at your option) any later version.
## 
##  HAPprime is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU General Public License for more details.
## 
##  You should have received a copy of the GNU General Public License
##  along with this program.  If not, see <http://www.gnu.org/licenses/>.
## 
#############################################################################

LoadPackage("HAPprime");
dir := DirectoriesPackageLibrary( "HAPprime", "tst" );
testresult := true;

file := Filename(dir, "happrime.tst");
if file <> fail and IsReadableFile(file) then
  testresult := testresult and Test(file);
else
  Print("happrime/tst/happrime.tst does not exist.\n");
  Print("Please check your installation of HAPprime.\n");
fi;

if not HAPPRIME_SingularIsAvailable() = true then
  Print("The 'Singular' executable does not appear to be available: skipping remaining tests\n");
else
  file := Filename(dir, "userguideexamples.tst");
  if file <> fail and IsReadableFile(file) then
    testresult := testresult and Test(file);
  else
    Print("happrime/tst/userguideexamples.tst does not exist.\n");
    Print("Please build the HAPprime manual using MakeHAPprimeDoc()\n");
  fi;

  file := Filename(dir, "datatypesexamples.tst");
  if file <> fail and IsReadableFile(file) then
    testresult := testresult and Test(file);
  else
    Print("happrime/tst/datatypesexamples.tst does not exist.\n");
    Print("Please build the HAPprime manual using MakeHAPprimeDoc()\n");
  fi;
fi;

if testresult then
  Print("#I  No errors detected while testing\n");
  QUIT_GAP(0);
else
  Print("#I  Errors detected while testing\n");
  QUIT_GAP(1);
fi;

FORCE_QUIT_GAP(1); # if we ever get here, there was an error
