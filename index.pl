#!/usr/bin/env perl

#AUXCOMM MESSAGING FOR PAT WINLINK SERVER - see $ver below

 #use strict;
 #use warning;
 #use DateTime::TimeZone;
 #use DateTime;

# Set Variables
#######################

#my $cgiurl = "auxmsg.pl"; # LOCAL
my $cgiurl = "index.pl"; # FOR WEB VIA OPENSHIFT


#my $temppl = "temp.pl"; # LOCAL


my $tmptxt = "tempinfo.txt"; 

my $ver = "1.0";

# Get the input
########################
read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});


#if no form data go to system start
   if (!$buffer) { 
         &begin;
   }

# Split the name-value pairs
@pairs = split(/&/, $buffer);

foreach $pair (@pairs) {
   ($name, $value) = split(/=/, $pair);

# Un-Webify plus signs and %-encoding
   $value =~ tr/+/ /;
   $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
   $value =~ s/<!--(.|\n)*-->//g;

  # if ($allow_html != 1) {
     # $value =~ s/<([^>]|\n)*>//g;
   #}

   $FORM{$name} = $value;
  
}


if ($FORM{'rgram'} = "radiogram") {

my $first = $FORM{'firstname'};
print "Content-type: text/html\n\n";
print "<html><head><title>$first</title></head>\n";
print "<body><FONT SIZE = 5>$first</FONT>\n";
print "</body></html>\n";

exit;
}

 
 
if ($FORM{'213'}) {
&twothirteen;
}

if ($FORM{'rg'}) {
&radiogram;
}

if ($FORM{'email'}) {
&email;
}

if ($FORM{'text'}) {
&text;
}

sub begin {
print "Content-type: text/html\n\n";
print "<html><head><title>AUXCOMM MESSAGING SERVER $ver</title></head>\n";

print "<body><FONT SIZE = 5><b>AUXCOMM<br>MESSAGING<br>SERVER</b></FONT><FONT SIZE = 2 color = red>\&nbsp\;\&nbsp\;<b>$ver</b><br><br>\n";

print "<FORM ACTION=$cgiurl METHOD=POST TARGET=_BLANK>";
print "<INPUT TYPE=submit NAME=213 VALUE=IC-213>";
print "</form>\n";

print "<FORM ACTION=$cgiurl METHOD=POST TARGET=_BLANK>";
print "<INPUT TYPE=submit NAME=rg VALUE=RADIOGRAM>";
print "</form>\n";
print "</body></html>\n";

print "<FORM ACTION=$cgiurl METHOD=POST TARGET=_BLANK>";
print "<INPUT TYPE=submit NAME=email VALUE=EMAIL>";
print "</form>\n";

print "<FORM ACTION=$cgiurl METHOD=POST TARGET=_BLANK>";
print "<INPUT TYPE=submit NAME=text VALUE=TEXT>";
print "</form>\n";

exit;
}

sub twothirteen {
print "Content-type: text/html\n\n";
print "<html><head><title>FORM IC-213</title></head>\n";
print "<body><FONT SIZE = 5><b>FORM IC-213</b></FONT><br><br>\n";

#print "* </font><i> = Required fields</i><br><br>\n";
print "<form method=POST action=$cgiurl>\n";

print "<input type=hidden id=ic213 name=ic213>\n";

# 1
print "<FONT SIZE = 2 color = Black>1. Incident Name (Optional):</font><br>\n";
print "<input id=incident name=incident size=40 type=text><br><br>\n";

# 2
print "<FONT SIZE = 2 color = Black>2. To (Name and Position):</font><br>\n";
print "<input id=to name=to size=40 type=text><br><br>\n";

# 3
print "<FONT SIZE = 2 color = Black>3. From (Name and Position):</font><br>\n";
print "<input id=from name=from size=40 type=text><br><br>\n";

# 4
print "<FONT SIZE = 2 color = Black>4. Subject:</font><br>\n";
print "<input id=subject name=subject size=40 type=text>\n";

# 5
print "<br><FONT SIZE = 2 color = Black>5. Date:</font><br>\n";
print "<input id=date name=date size=10 type=text>\n";

# 6
print "<br><FONT SIZE = 2 color = Black>6. Time:</font><br>\n";
print "<input id=time name=time size=10 type=text><br><br>\n";

# 7
print "<FONT SIZE = 2 color = Black>7. Message:</font><br>\n";
print "<textarea name=msg cols=40 rows=10></textarea><br><br>";

# 8
print "<FONT SIZE = 2 color = Black>8. Approved by: Name:</font><br>\n";
print "<input id=approved name=approved size=40 type=text><br>\n";

print "<FONT SIZE = 2 color = Black>Signature:</font><br>\n";
print "<input id=asig name=asig size=40 type=text><br>\n";

print "<FONT SIZE = 2 color = Black>Position/Title:</font><br>\n";
print "<input id=atitle name=atitle size=40 type=text><br><br>\n";

# 9
print "<FONT SIZE = 2 color = Black>9. Reply:</font><br>\n";
print "<textarea name=reply cols=40 rows=10></textarea><br><br>";

# 10
print "<FONT SIZE = 2 color = Black>10. Replied by: Name:</font><br>\n";
print "<input id=rname name=rname size=40 type=text><br>\n";

print "<FONT SIZE = 2 color = Black>Position/Title:</font><br>\n";
print "<input id=rtitle name=rtitle size=40 type=text><br>\n";

print "<FONT SIZE = 2 color = Black>Signature:</font><br>\n";
print "<input id=rsig name=rsig size=40 type=text><br><br>\n";

print "<FONT SIZE = 2 color = Black>Date/Time:</font><br>\n";
print "<input id=rdandt name=rdandt size=20 type=text><br><br><br>\n";

 

print "<input type=submit> \* <input type=reset><br><br>\n";
print "</form><br><br><br><br>\n";


#INCLUDE LINK TO PDF INSTRUCTIONS


print "</body></html>\n";

exit;

}

sub radiogram {
print "Content-type: text/html\n\n";
print "<html><head><title>FORM ARRL RADIOGRAM</title></head>\n";
print "<body><FONT SIZE = 5><b>FORM ARRL RADIOGRAM</b></FONT><br><br>\n";
print "<FONT SIZE = 2 color = Black>ARRL RADIOGRAM GOES HERE</font>\&nbsp\;\&nbsp\;\n";

print "<form method=POST action=$cgiurl>\n";

print "<input id=rgram name=rgram type=hidden value=radiogram>\n";
print "First name:<br><input type=text name=firstname><br>";


print "<input type=submit> \* <input type=reset><br><br>\n";
print "</form><br><br><br><br>\n";



print "</body></html>\n";
exit;
}

sub email {
print "Content-type: text/html\n\n";
print "<html><head><title>SIMPLE EMAIL</title></head>\n";
print "<body><FONT SIZE = 5><b>SIMPLE EMAIL</b></FONT><br><br>\n";
print "<FONT SIZE = 2 color = Black>SIMPLE EMAIL GOES HERE</font>\&nbsp\;\&nbsp\;\n";
print "</body></html>\n";
exit;
}

sub text {
print "Content-type: text/html\n\n";
print "<html><head><title>TEXT MESSAGE</title></head>\n";
print "<body><FONT SIZE = 5><b>TEXT MESSAGE</b></FONT><br><br>\n";
print "<FONT SIZE = 2 color = Black>TEXT MESSAGE GOES HERE</font>\&nbsp\;\&nbsp\;\n";
print "</body></html>\n";
exit;
}
