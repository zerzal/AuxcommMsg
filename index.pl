#!/afs/isis/pkg/perl/bin/perl

#AUXCOMM MESSAGING FOR PAT WINLINK SERVER - see $ver below

 #use strict;
 #use warning;
 #use DateTime::TimeZone;
 #use DateTime;

# Set Variables
#######################

my $cgiurl = "index.pl";  

#my $tmptxt = "tempinfo.txt"; 

my $ver = "1.0";

#&213;

#sub 213 {
print "Content-type: text/html\n\n";
print "<html><head><title>AUXCOMM MESSAGING SERVER $ver</title></head>\n";

print "<body><FONT SIZE = 5><b>AUXCOMM MESSAGING SERVER</b></FONT><FONT SIZE = 2 color = red>\&nbsp\;\&nbsp\;<b>$ver</b><br><br>\n";
print "* </font><i> = Required fields</i><br><br>\n";
print "<form method=POST action= $cgiurl>\n";

print "<FONT SIZE = 2 color = Black>1. Incident Name (Optional):</font>\&nbsp\;\&nbsp\;\n";
print "<input id=incident name=incident size=40 type=text><br><br>";

print "<FONT SIZE = 2 color = Black>2. To (Name and Position):</font>\&nbsp\;\&nbsp\;\n";
print "<input id=incident name=incident size=40 type=text><br><br>";

print "<FONT SIZE = 2 color = Black>3. From (Name and Position):</font>\&nbsp\;\&nbsp\;\n";
print "<input id=incident name=incident size=40 type=text><br><br>";

print "<FONT SIZE = 2 color = Black>4. Subject:</font>\&nbsp\;\&nbsp\;\n";
print "<input id=incident name=incident size=40 type=text><br><br>";

print "<FONT SIZE = 2 color = Black>5. Date:</font>\&nbsp\;\&nbsp\;\n";
print "<input id=incident name=incident size=40 type=text><br><br>";

print "<FONT SIZE = 2 color = Black>6. Time:</font>\&nbsp\;\&nbsp\;\n";
print "<input id=incident name=incident size=40 type=text><br><br>"

print "<FONT SIZE = 2 color = Black>7. Message:</font>\&nbsp\;\&nbsp\;\n";
print "<input id=incident name=incident size=40 type=text><br><br>"

print "<FONT SIZE = 2 color = Black>8. Approved by: Name:</font>\&nbsp\;\&nbsp\;\n";
print "<input id=incident name=incident size=40 type=text><br><br>"

print "<FONT SIZE = 2 color = Black>Signature:</font>\&nbsp\;\&nbsp\;\n";
print "<input id=incident name=incident size=40 type=text><br><br>"

print "<FONT SIZE = 2 color = Black>Position/Title:</font>\&nbsp\;\&nbsp\;\n";
print "<input id=incident name=incident size=40 type=text><br><br>"

print "<FONT SIZE = 2 color = Black>10. Replied by: Name:</font>\&nbsp\;\&nbsp\;\n";
print "<input id=incident name=incident size=40 type=text><br><br>"

print "<FONT SIZE = 2 color = Black>Position/Title:</font>\&nbsp\;\&nbsp\;\n";
print "<input id=incident name=incident size=40 type=text><br><br>"

print "<FONT SIZE = 2 color = Black>Signature:</font>\&nbsp\;\&nbsp\;\n";
print "<input id=incident name=incident size=40 type=text><br><br>"

print "<FONT SIZE = 2 color = Black>ICS 213</font>\&nbsp\;\&nbsp\;\n";

print "<FONT SIZE = 2 color = Black>Date/Time:</font>\&nbsp\;\&nbsp\;\n";
print "<input id=incident name=incident size=40 type=text><br><br>"


print "<input type=submit> * <input type=reset><br><br>\n";
print "</form>";


#INCLUDE LINK TO PDF INSTRUCTIONS


print "</body></html>\n";




exit;


#exit;
#}

