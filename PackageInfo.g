#############################################################################
##
##  HAPPRIME - PackageInfo.g
##  Initialisation file
##  Paul Smith
##
##  Copyright (C)  2007-2008
##  National University of Ireland Galway
##  Copyright (C)  2011
##  University of St Andrews
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

SetPackageInfo( rec(

PackageName := "HAPprime",
Subtitle := "a HAP extension for small prime power groups",
Version := "0.6dev",
Date := "09/06/2011",

Persons := [
  rec( 
    LastName      := "Smith",
    FirstNames    := "Paul",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "paul.smith@st-andrews.ac.uk",
    WWWHome       := "http://www.cs.st-andrews.ac.uk/~pas",
    PostalAddress := Concatenation( [
                         "Paul Smith\n",
                         "School of Computer Science\n",
                         "University of St Andrews\n",
                         "St Andrews\n",
                         "UK" ] ),
    Place         := "St Andrews",
    Institution   := "University of St Andrews"
  ),
# provide such a record for each author and/or maintainer ...
  rec( 
    LastName      := "The CHA Group",
    FirstNames    := "",
    IsAuthor      := false,
    IsMaintainer  := true,
    Email         := "graham.ellis@nuigalway.ie",
    WWWHome       := "http://hamilton.nuigalway.ie/CHA/",
    PostalAddress := Concatenation( [
      "The CHA group\n",
      "Mathematics Department\n",
      "NUI Galway\n",
      "Galway\n",
      "Ireland" ] ),
    Place         := "Galway",
    Institution   := "National University of Ireland Galway"
  ),
],

Status := "deposited",

PackageWWWHome  := "https://gap-packages.github.io/happrime/",
README_URL      := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/gap-packages/happrime",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/happrime-", ~.Version ),
ArchiveFormats := ".tar.gz",

AbstractHTML := 
  "The <span class=\"pkgname\">HAPPrime</span> package is an extension to the \
  <span class=\"pkgname\">HAP</span> package, and implements memory-efficient \
  algorithms for the calculation of resolutions of small prime-power groups.",

PackageDoc := [
  rec(
    BookName  := "HAPprime",
    ArchiveURLSubset := ["doc"],
    HTMLStart := "doc/userguide/chap0.html",
    PDFFile   := "doc/userguide/manual.pdf",
    SixFile   := "doc/userguide/manual.six",
    LongTitle := "A small prime-power group extension to HAP",
    Autoload  := true
  ),
  rec(
    BookName  := "HAPprime Datatypes",
    ArchiveURLSubset := ["doc"],
    HTMLStart := "doc/datatypes/chap0.html",
    PDFFile   := "doc/datatypes/manual.pdf",
    SixFile   := "doc/datatypes/manual.six",
    LongTitle := "Datatype reference for HAPprime",
    Autoload  := true
  )
],
    

Dependencies := rec(
  GAP := ">=4.7",
  NeededOtherPackages := [["HAP", ">=1.9.3"], ["GAPDoc", "1.0"]],
  SuggestedOtherPackages := [],  
  ExternalConditions := []
),

AvailabilityTest := ReturnTrue,
TestFile := "tst/testall.g",
Keywords := ["homological algebra", "resolution", "modules"],

));
