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
##  Base on the GAP "example" package by Werner Nickel and Werner Nickel
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

SetPackageInfo( rec(

##  This is case sensitive, use your preferred spelling.
##
PackageName := "HAPprime",

##  This may be used by a default banner or on a Web page, should fit on
##  one line.
Subtitle := "a HAP extension for small prime power groups",

##  See '?Extending: Version Numbers' in GAP help for an explanation
##  of valid version numbers. For an automatic package distribution update
##  you must provide a new version number even after small changes.
Version := "0.6",
Date := "09/06/2011",

##  URL of the archive(s) of the current package release, but *without*
##  the format extension(s), like '.zoo', which are given next.
##  The archive file name *must be changed* with each version of the archive
##  (and probably somehow contain the package name and version).
##  The paths of the files in the archive must begin with the name of the
##  directory containing the package (in our "example" probably:
##  example/init.g, ...    or  example-1.3/init.g, ...  )
# 
ArchiveURL := "http://hamilton.nuigalway.ie/happrime-0.6",

##  All provided formats as list of file extensions, separated by white
##  space or commas.
##  Currently recognized formats are:
##      .zoo       the (GAP-traditional) zoo-format with "!TEXT!" comments 
##                 for text files
##      .tar.gz    the UNIX standard
##      .tar.bz2   compressed with 'bzip2', often smaller than with gzip
##      -win.zip   zip-format for DOS/Windows, text files must have DOS 
##                 style line breaks (CRLF)
##  
##  In the future we may also provide .deb or .rpm formats which allow
##  a convenient installation and upgrading on Linux systems.
##  
# ArchiveFormats := ".zoo", # the others are generated automatically
ArchiveFormats := ".tar.gz",

##  If not all of the archive formats mentioned above are provided, these 
##  can be produced at the GAP side. Therefore it is necessary to know which
##  files of the package distribution are text files which should be unpacked
##  with operating system specific line breaks. There are the following 
##  possibilities to specify the text files:
##  
##    - specify below a component 'TextFiles' which is a list of names of the 
##      text files, relative to the package root directory (e.g., "lib/bla.g")
##    - specify below a component 'BinaryFiles' as list of names, then all other
##      files are taken as text files.
##    - if no 'TextFiles' or 'BinaryFiles' are given and a .zoo archive is
##      provided, then the files in that archive with a "!TEXT!" comment are
##      taken as text files
##    - otherwise: exactly the files with names matching the regular expression
##      ".*\(\.txt\|\.gi\|\.gd\|\.g\|\.c\|\.h\|\.htm\|\.html\|\.xml\|\.tex\|\.six\|\.bib\|\.tst\|README.*\|INSTALL.*\|Makefile\)"
##      are taken as text files
##  
##  (Remark: Just providing a .tar.gz file will often result in useful
##  archives)
##  
##  These entries are *optional*.
#TextFiles := ["init.g", ......],
#BinaryFiles := ["doc/manual.dvi", ......],


##  Information about authors and maintainers is contained in the `Persons'
##  field which is a list of records, one record for each person; each 
##  person's record should be as per the following example: 
##  
##     rec(
##     # these are compulsory, characters are interpreted as latin-1, so
##     # German umlauts and other western European special characters are ok:
##     LastName := "Mller",
##     FirstNames := "Fritz Eduard",
##  
##     # At least one of the following two entries must be given and set 
##     # to 'true' (an entry can be left out if value is not 'true'):
##     IsAuthor := true;
##     IsMaintainer := true;
##  
##     # At least one of the following three entries must be given.
##     # - preferably email address and WWW homepage
##     # - postal address not needed if email or WWW address available
##     # - if no contact known, specify postal address as "no address known"
##     Email := "Mueller@no.org",
##     # complete URL, starting with protocol
##     WWWHome := "http://www.no.org/~Mueller",
##     # separate lines by '\n' (*optional*)
##     PostalAddress := "Dr. F. Mller\nNo Org Institute\nNo Place 13\n\
##     12345 Notown\nNocountry"
##     
##     # If you want, add one or both of the following entries (*optional*)
##     Place := "Notown",
##     Institution := "Institute for Nothing"
##     )
##  
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

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "deposited"     for packages for which the GAP developers agreed 
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages 
##    "other"         for all other packages
##
# Status := "accepted",
Status := "deposited",

##  You must provide the next two entries if and only if the status is 
##  "accepted" because is was successfully refereed:
# format: 'name (place)'
# CommunicatedBy := "Mike Atkinson (St. Andrews)",
#CommunicatedBy := "",
# format: mm/yyyy
# AcceptDate := "08/1999",
#AcceptDate := "",

##  For a central overview of all packages and a collection of all package
##  archives it is necessary to have two files accessible which should be
##  contained in each package:
##     - A README file, containing a short abstract about the package
##       content and installation instructions.
##     - The PackageInfo.g file you are currently reading or editing!
##  You must specify URLs for these two files, these allow to automate 
##  the updating of package information on the GAP Website, and inclusion
##  and updating of the package in the GAP distribution.
#
README_URL := 
  "http://http://www.cs.st-andrews.ac.uk/~pas/HAPprime/README.happrime",
PackageInfoURL := 
  "http://http://www.cs.st-andrews.ac.uk/~pas/HAPprime/PackageInfo.g",

##  Here you  must provide a short abstract explaining the package content 
##  in HTML format (used on the package overview Web page) and an URL 
##  for a Webpage with more detailed information about the package
##  (not more than a few lines, less is ok):
##  Please, use '<span class="pkgname">GAP</span>' and
##  '<span class="pkgname">MyPKG</span>' for specifing package names.
##  
# AbstractHTML := "This package provides  a collection of functions for \
# computing the Smith normal form of integer matrices and some related \
# utilities.",
AbstractHTML := 
  "The <span class=\"pkgname\">HAPPrime</span> package is an extension to the \
  <span class=\"pkgname\">HAP</span> package, and implements memory-efficient \
  algorithms for the calculation of resolutions of small prime-power groups.",

PackageWWWHome := "http://www.maths.nuigalway.ie/~pas/CHA/HAPprime/",

##  Here is the information on the help books of the package, used for
##  loading into GAP's online help and maybe for an online copy of the 
##  documentation on the GAP website.
##
##  For the online help the following is needed:
##       - the name of the book (.BookName)
##       - a long title, shown by ?books (.LongTitle, optional)
##       - the path to the manual.six file for this book (.SixFile)
##       - a decision if the book should be (auto)loaded, probably 'true'
##         (.Autoload)
##  
##  For an online version on a Web page further entries are needed, 
##  if possible, provide an HTML- and a PDF-version:
##      - if there is an HTML-version the path to the start file,
##        relative to the package home directory (.HTMLStart)
##      - if there is a PDF-version the path to the .pdf-file,
##        relative to the package home directory (.PDFFile)
##      - give the paths to the files inside your package directory
##        which are needed for the online manual (either as URL .Archive
##        if you pack them into a separate archive, or as list 
##        .ArchiveURLSubset of directory and file names which should be 
##        copied from your package archive, given in .ArchiveURL above
##  
##  For links to other GAP or package manuals you can assume a relative 
##  position of the files as in a standard GAP installation.
##  
# in case of several help books give a list of such records here:
PackageDoc := [
  rec(
    BookName  := "HAPprime",
    ArchiveURLSubset := ["doc"],
    HTMLStart := "doc/userguide/chap0.html",
    PDFFile   := "doc/userguide/manual.pdf",
    # the path to the .six file used by GAP's help system
    SixFile   := "doc/userguide/manual.six",
    # a longer title of the book, this together with the book name should
    # fit on a single text line (appears with the '?books' command in GAP)
    LongTitle := "A small prime-power group extension to HAP",
    # Should this help book be autoloaded when GAP starts up? This should
    # usually be 'true', otherwise say 'false'. 
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
    

##  Are there restrictions on the operating system for this package? Or does
##  the package need other packages to be available?
Dependencies := rec(
  # GAP version, use version strings for specifying exact versions,
  # prepend a '>=' for specifying a least version.
  GAP := ">=4.4",
  # list of pairs [package name, (least) version],  package name is case
  # insensitive, least version denoted with '>=' prepended to version string.
  # without these, the package will not load
  # NeededOtherPackages := [["GAPDoc", ">= 0.99"]],
  NeededOtherPackages := [["HAP", ">=1.9.3"], ["GAPDoc", "1.0"]],
  # without these the package will issue a warning while loading
  # SuggestedOtherPackages := [],
  SuggestedOtherPackages := [],  
  # needed external conditions (programs, operating system, ...)  provide 
  # just strings as text or
  # pairs [text, URL] where URL  provides further information
  # about that point.
  # (no automatic test will be done for this, do this in your 
  # 'AvailabilityTest' function below)
  # ExternalConditions := []
  ExternalConditions := []
),

##  Provide a test function for the availability of this package.
##  For packages which will not fully work, use 'Info(InfoWarning, 1,
##  ".....")' statements. For packages containing nothing but GAP code,
##  just say 'ReturnTrue' here.
##  With the new package loading mechanism (GAP >=4.4)  the availability
##  tests of other packages, as given under .Dependencies above, will be 
##  done automatically and need not be included in this function.
AvailabilityTest := ReturnTrue,
  #AvailabilityTest := function()
#  local path;
#    # test for existence of the compiled binary
#    path := DirectoriesPackagePrograms("HAPPrime");
#    if Filename(path, "hello") = fail then
#      Info(InfoWarning, 1,
#        "Package ``HAPPrime'': The program `hello' is not compiled");
#      Info(InfoWarning, 1,
#        "`HelloWorld()' is thus unavailable");
#    fi;
#    return true;
#  end,

##  *Optional*: path relative to package root to a file which 
##  shall be read immediately before the package is loaded.
#PreloadFile := "...",

##  The LoadPackage mechanism can produce a default banner from the info
##  in this file. If you are not happy with it, you can provide a string
##  here that is used as a banner. GAP decides when the banner is shown and
##  when it is not shown. *optional* (note the ~-syntax in this example)
#BannerString := Concatenation( 
#  "----------------------------------------------------------------\n",
#  "Loading  Example ", ~.Version, "\n",
#  "by ", ~.Persons[1].FirstNames, " ", ~.Persons[1].LastName,
#        " (", ~.Persons[1].WWWHome, ")\n",
#  "   ", ~.Persons[2].FirstNames, " ", ~.Persons[2].LastName,
#        " (", ~.Persons[2].WWWHome, ")\n",
#  "For help, type: ?Example package \n",
#  "----------------------------------------------------------------\n" ),

##  Suggest here if the package should be *automatically loaded* when GAP is 
##  started.  This should usually be 'false'. Say 'true' only if your package 
##  provides some improvements of the GAP library which are likely to enhance 
##  the overall system performance for many users.
Autoload := false,

##  *Optional*, but recommended: path relative to package root to a file which 
##  contains as many tests of the package functionality as sensible.
##  The file can either consist of 'ReadTest' calls or it is itself read via
##  'ReadTest'; it is assumed that the latter case occurs if and only if
##  the file contains the string 'gap> START_TEST('.
##  For submitted packages, these tests are run regularly, as a part of the
##  standard GAP test suite.
TestFile := "tst/testall.g",

##  *Optional*: Here you can list some keyword related to the topic 
##  of the package.
Keywords := ["homological algebra", "resolution", "modules"]

));


