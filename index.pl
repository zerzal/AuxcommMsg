#!/usr/bin/perl
#AUXCOMM MESSAGING FOR PAT WINLINK SERVER - see $ver below

 #use strict;
 #use warning;
  
# SET VARIABLES
#######################

#Set up time variables
my ($gsec,$gmin,$ghour,$gmday,$gmon,$gyear,$gwday,$gyday,$gisdst) = gmtime(time);

my ($lsec,$lmin,$lhour,$lmday,$lmon,$lyear,$lwday,$lyday,$lisdst) = localtime(time);

$gyear += 1900;
$gmon += 1;
$lyear += 1900;
$lmon += 1;

if ($lmin < "10") {
  $lmin = "0" .$lmin;
 }
 
if ($lhour < "10") {
  $lhour = "0" .$lhour;
 }
 
if ($lmon < "10") {
  $lmon = "0" .$lmon;
 }

if ($lmday < "10") {
  $lmday = "0" .$lmday;
 }


if ($gmin < "10") {
  $gmin = "0" .$gmin;
 }
 
if ($ghour < "10") {
  $ghour = "0" .$ghour;
 }

if ($gmon < "10") {
  $gmon = "0" .$gmon;
 }

if ($gmday < "10") {
  $gmday = "0" .$gmday;
 }

#my $ftime = "$lhour:$lmin\n";

my $cgiurl = "index.pl"; # FOR WEB VIA OPENSHIFT

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

   $FORM{$name} = $value;
  
}

#OUTPUT FOR FORM IC-213
#######################
if ($FORM{'tt'}) {
 if ($FORM{'msg'}) {
   
my $incident = $FORM{'incident'};
my $to = $FORM{'to'};
my $tpos = $FORM{'tpos'};
my $email = $FORM{'email'};

	if ($email !~ "@") {
	    $email = $email ."\@winlink.org";
	}

my $from = $FORM{'from'};
my $pt = $FORM{'title'};
my $sig = $FORM{'sig'};
my $subject = $FORM{'subject'};
my $date = $FORM{'date'};
my $time = $FORM{'time'};
my $msg = $FORM{'msg'};
my $approved = $FORM{'approved'};
my $asig = $FORM{'asig'};
my $atitle = $FORM{'atitle'};
my $reply = $FORM{'reply'};
my $rmsg = "*** THIS IS A REPLY ***";

#File name generator
my @chars = ("A".."Z", "0".."9");
my $mid;
$mid .= $chars[rand @chars] for 1..12;

#Build body of email file

    $filename = $mid.'.b2f';
	
my $bodyr = " ";

 if ($reply) {
     $bodyr = "$rmsg\n\n";
    }
my $body0 = "GENERAL MESSAGE (ICS 213 - modified)\n\n";
my $body1 = "1. Incident Name (Optional): $incident\n\n";
my $body2 = "2. To (Name): $to\n";
my $body2a = "\tPosition/Title: $tpos\n";
my $body2b = "\tEmail: $email\n\n";
my $body3 = "3. From (Name): $from\n";
my $body3a = "\tPosition/Title: $pt\n";
my $body3b = "\tSignature: $sig\n\n";
my $body4 = "4. Subject: $subject\n\n";
my $body5 = "5. Date: $date\n";
my $body6 = "6. Time: $time\n\n";
my $body7 = "7. Message:\n $msg\n\n";
my $body8 = "8. Approved by: $approved\n";
my $body8a = "\tSignature: $asig\n";
my $body8b = "\tPosition/Title: $atitle\n\n";
my ($fbody) = ($bodyr . $body0 . $body1 . $body2 . $body2a . $body2b . $body3 . $body3a . $body3b . $body4 . $body5 . $body6 . $body7 . $body8 . $body8a . $body8b);
my $fbody_len = length($fbody);

#PRINT SENT MESSAGE TO WEB PAGE
print "Content-type: text/html\n\n";
print "<html><head><title>FORM IC-213 QUEUED FOR DELIVERY</title></head>\n";
print "<body><FONT SIZE = 3>Thank you!<br>Your IC-213 message below has been queued<br>for delivery via Amateur Radio and the Winlink system.<br><br>";

print "<br>$body0<br><br>$bodyr<br><br>$body1<br><br>$body2<br><br>$body2a<br><br>$body2b<br><br>$body3<br><br>$body3a<br><br>$body3b<br><br>$body4<br><br>$body5<br><br>$body6<br><br>$body7<br><br>$body8<br><br>$body8a<br><br>$body8b</FONT><br><br>";

#Add button to pring web page
print "<button onclick=\"myFunction()\">Print this page</button>";

print "<script>";
print "function myFunction() {";
print "  window.print()\;";
print "}";
print "</script>";

print "<br><br><br><br>";

print "$filename\n"; ##FOR TESTING VIA OPENSHIFT

print "</body></html>\n";


#CREATE FILE FOR SENDING VIA WINLINK

#open TMP, '>', "/home/dwayne/.wl2k/mailbox/N4MIO/out/$filename";  ##FOR PRODUCTION

open TMP, '>', "$filename"; ##FOR TESTING VIA OPENSHIFT

print TMP "Mid: $mid\n";
print TMP "Body: $fbody_len\n";
print TMP "Content-Transfer-Encoding: 8bit\n";
print TMP "Content-Type: text/plain; charset=ISO-8859-1\n";
print TMP "Date: $gyear\/$gmon\/$gmday $ghour\:$gmin\n";      #2019/07/19 12:37
print TMP "From: N4MIO\n";
print TMP "Mbo: N4MIO\n";
print TMP "Subject: $subject\n";
print TMP "To: SMTP: $email\n";
print TMP "Type: Private\n\n";
print TMP $body0;
print TMP $bodyr;
print TMP $body1;
print TMP $body2;
print TMP $body2a;
print TMP $body2b;
print TMP $body3;
print TMP $body3a;
print TMP $body3b;
print TMP $body4;
print TMP $body5;
print TMP $body6;
print TMP $body7;
print TMP $body8;
print TMP $body8a;
print TMP $body8b;

close TMP;

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
print "<html><head><title>GENERAL MESSAGE (ICS 213 - modified)</title>";
print "<!-- Style to set the size of checkbox --> <style> input.largerCheckbox { width: 30px; height: 30px; } </style>";
print "</head>\n";
print "<body><FONT SIZE = 5><b>GENERAL MESSAGE<br>(ICS 213 - modified)</b></FONT><br><br><br>\n";

print "<form method=POST action=$cgiurl>\n";

print "<input id=tt name=tt type=hidden value=two13>\n";

# Reply checkbox
print "<FONT SIZE = 3 color = Black><b>CHECK HERE IF REPLY</font>\&nbsp\;</b>\n";
print "<input id=reply name=reply type=checkbox value=1 class=largerCheckbox><br><br>\n";

# 1
print "<FONT SIZE = 2 color = Black>1. Incident Name (Optional):</font><br>\n";
#print "<FONT SIZE = 2 color = Black>1. Incident Name (Optional):</font><br>\n";
print "<input id=incident name=incident size=40 type=text><br><br>\n";

# 2
print "<FONT SIZE = 2 color = Black>2. To (Name):</font><br>\n";
print "<input id=to name=to size=40 type=text><br>\n";

print "<FONT SIZE = 2 color = Black>Position/Title:</font><br>\n";
print "<input id=tpos name=tpos size=40 type=text><br>\n";

print "<FONT SIZE = 2 color = Black>Email Address: </font><FONT SIZE = 2 color = Red>(Can be Winlink user alias)</font><br>\n";
print "<input id=email name=email size=40 type=text><br><br>\n";

# 3
print "<FONT SIZE = 2 color = Black>3. From (Name):</font><br>\n";
print "<input id=from name=from size=40 type=text><br>\n";

print "<FONT SIZE = 2 color = Black>Position/Title:</font><br>\n";
print "<input id=title name=title size=40 type=text><br>\n";

print "<FONT SIZE = 2 color = Black>Signature:</font><br>\n";
print "<input id=sig name=sig size=40 type=text><br><br>\n";

# 4
print "<FONT SIZE = 2 color = Black>4. Subject:</font><br>\n";
print "<input id=subject name=subject size=40 type=text>\n";

# 5
print "<br><br><FONT SIZE = 2 color = Black>5. Date:</font><br>\n";
print "<input id=date name=date size=14 type=text value=$lmon\/$lmday\/$lyear>\n";

# 6
print "<br><FONT SIZE = 2 color = Black>6. Time:</font><br>\n";
print "<input id=time name=time size=7 type=text value=$ftime><br><br>\n";

# 7
print "<FONT SIZE = 2 color = Black>7. Message:</font><br>\n";
print "<textarea name=msg cols=40 rows=10></textarea><br><br>";

# 8
print "<FONT SIZE = 2 color = Black>8. Approved by (Name):</font><br>\n";
print "<input id=approved name=approved size=40 type=text><br>\n";

print "<FONT SIZE = 2 color = Black>Position/Title:</font><br>\n";
print "<input id=atitle name=atitle size=40 type=text><br>\n";

print "<FONT SIZE = 2 color = Black>Signature:</font><br>\n";
print "<input id=asig name=asig size=40 type=text><br><br>\n";

print "<input type=submit> \* <input type=reset><br><br><br><br><br><br>\n";
print "</form>";

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
