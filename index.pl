#!/usr/bin/perl
##!/usr/bin/env perl

#AUXCOMM MESSAGING FOR PAT WINLINK SERVER - see $ver below

 #use strict;
 #use warning;
 #use DateTime::TimeZone;
 #use DateTime;
 #use Date::Format;

# Set Variables
#######################

my $cgiurl = "auxmsg.pl"; # LOCAL
#my $cgiurl = "index.pl"; # FOR WEB VIA OPENSHIFT
#my $dt = DateTime->now;
#my $hms = $dt->hms;           # 14:02:29
#my $ymd = $dt->ymd;           # 2002-12-06

#my $temppl = "temp.pl"; # LOCAL

#my $date2 = localtime(time);

my $tmptxt = "tempinfo.txt"; 

my $ver = "1.0";

# PROCESS FORM DATA
########################
read(STDIN, my $buffer, $ENV{'CONTENT_LENGTH'});


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




#OUTPUT FOR FORM IC-213
#######################
if ($FORM{'tt'}) {
 if ($FORM{'msg'}) {

my $incident = $FORM{'incident'};
my $to = $FORM{'to'};
my $from = $FORM{'from'};
my $subject = $FORM{'subject'};
my $date = $FORM{'date'};
my $time = $FORM{'time'};
my $msg = $FORM{'msg'};
my $approved = $FORM{'approved'};
my $asig = $FORM{'asig'};
my $atitle = $FORM{'atitle'};
my $reply = $FORM{'reply'};
my $rname = $FORM{'rname'};
my $rtitle = $FORM{'rtitle'};
my $rsig = $FORM{'rsig'};
my $rdandt = $FORM{'rdandt'};

#File name generator
my @chars = ("A".."Z", "0".."9");
my $mid;
$mid .= $chars[rand @chars] for 1..12;

#Build body of email file

    $filename = $mid.'.b2f';
	
	if ($reply = "on") {
	   $rmsg = $msg;
	   $msg = "";
	}

my $body = "GENERAL MESSAGE (ICS 213)<br><br>
	   1. Incident Name (Optional): $incident<br><br>
	   2. To (Name and Position): $to<br><br>
	   3. From (Name and Position): $from<br><br>
	   4. Subject: $subject<br><br>
	   5. Date: $date<br><br>
	   6. Time: $time<br><br>
	   7. Message: $msg<br><br>
	   8. Approved by:  Name: $approved Signature: $asig<br>Position/Title: $atitle<br><br>
	   9. Reply: $rmsg<br><br>
	  10. Replied by:  Name: $rname Position/Title: $rtitle<br>Signature: $rsig<br><br>
	      $rdandt";
 

print "Content-type: text/html\n\n";
print "<html><head><title>FORM IC-213 QUEUED FOR DELIVERY</title></head>\n";
print "<body><FONT SIZE = 3>Thank you!<br>Your IC-213 message to<br>$to has been queued<br>for delivery via Amateur Radio<br>and the Winlink system.<br>\n";
print "Your email message name is <br>$filename<br>$reply</FONT><br><br>\n";

print "$body</FONT>";

print "</body></html>\n";
 }
  else {
        &begin;
       }

exit;
}

#OUTPUT FOR FORM RADIOGRAM
###########################
if ($FORM{'rgram'}) {

my $first = $FORM{'firstname'};
print "Content-type: text/html\n\n";
print "<html><head><title>$first</title></head>\n";
print "<body><FONT SIZE = 5>$first</FONT><br><br>\n";

print "<FONT SIZE = 10>OUTPUT OF FORM RADIOGRAM</FONT>\n";

print "</body></html>\n";

exit;
}

 
#MAIN PAGE MENU (FORMS)
#######################
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


#SUBROUTINES
#######################
#Main Page
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


#FORM IC-213
sub twothirteen {
print "Content-type: text/html\n\n";
print "<html><head><title>FORM IC-213</title>";
print "<!-- Style to set the size of checkbox --> <style> input.largerCheckbox { width: 30px; height: 30px; } </style>";
print "</head>\n";
print "<body><FONT SIZE = 5><b>FORM IC-213</b></FONT><br><br>\n";

#print "* </font><i> = Required fields</i><br><br>\n";
print "<form method=POST action=$cgiurl>\n";

print "<input id=tt name=tt type=hidden value=two13>\n";

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
print "<input id=date name=date size=10 type=date>\n";

# 6
print "<br><FONT SIZE = 2 color = Black>6. Time:</font><br>\n";
print "<input id=time name=time size=10 type=time><br><br>\n";

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
print "<FONT SIZE = 3 color = Black><b>9. CHECK HERE IF REPLY</font>\&nbsp\;</b>\n";
print "<input id=reply name=reply type=checkbox class=largerCheckbox><br>\n";
print "<FONT SIZE = 2 color = Red>(use 7. Message above for reply)</font><br><br>";
#print "<textarea name=reply cols=40 rows=10></textarea><br><br>";

# 10
print "<FONT SIZE = 2 color = Black>10. Replied by: Name:</font><br>\n";
print "<input id=rname name=rname size=40 type=text><br>\n";

print "<FONT SIZE = 2 color = Black>Position/Title:</font><br>\n";
print "<input id=rtitle name=rtitle size=40 type=text><br>\n";

print "<FONT SIZE = 2 color = Black>Signature:</font><br>\n";
print "<input id=rsig name=rsig size=40 type=text><br><br>\n";

print "<FONT SIZE = 2 color = Black>Date/Time:</font><br>\n";
print "<input id=rdandt name=rdandt size=20 type=datetime-local><br><br><br>\n";

print "<input type=submit> \* <input type=reset><br><br>\n";
print "</form>";


#INCLUDE LINK TO PDF INSTRUCTIONS


print "</body></html>\n";

exit;

}


#FORM RADIOGRAM
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

#FORM EMAIL
sub email {
print "Content-type: text/html\n\n";
print "<html><head><title>SIMPLE EMAIL</title></head>\n";
print "<body><FONT SIZE = 5><b>SIMPLE EMAIL</b></FONT><br><br>\n";
print "<FONT SIZE = 2 color = Black>SIMPLE EMAIL GOES HERE</font>\&nbsp\;\&nbsp\;\n";
print "</body></html>\n";
exit;
}


#FORM TEXT
sub text {
print "Content-type: text/html\n\n";
print "<html><head><title>TEXT MESSAGE</title></head>\n";
print "<body><FONT SIZE = 5><b>TEXT MESSAGE</b></FONT><br><br>\n";
print "<FONT SIZE = 2 color = Black>TEXT MESSAGE GOES HERE</font>\&nbsp\;\&nbsp\;\n";
print "</body></html>\n";
exit;
}
