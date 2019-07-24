#!/usr/bin/perl
##!/usr/bin/env perl

#AUXCOMM MESSAGING FOR PAT WINLINK SERVER - see $ver below

 #use strict;
 #use warning;
 
# SET VARIABLES
#######################

#Set up time variables
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = gmtime(time);
my ($lsec,$lmin,$lhour,$lmday,$lmon,$lyear,$lwday,$lyday,$lisdst) = localtime(time);
#my @abbr = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
$year += 1900;
$mon += 1;
#$mday += 1;
#my $gdate = gmdate('Y/m/d h:i',time());

if ($lisdst = 1) {
  $hour = $hour - 4;
 }
else {
  $hour = $hour - 5;
 } 

if ($min < "10") {
  $min = "0" .$min;
 }

if ($hour < "10") {
  $hour = "0" .$hour;
 }

if ($mon < "10") {
  $mon = "0" .$mon;
 }

#my $cgiurl = "auxmsg.pl"; # LOCAL
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
	
	if ($reply) {
	   $rmsg = $msg;
	   $msg = "THIS IS A REPLY";
	   
	}

my $body0 = "GENERAL MESSAGE (ICS 213)\n\n";
my $body1 = "1. Incident Name (Optional): $incident\n\n";
my $body2 = "2. To (Name and Position): $to\n\n";
my $body3 = "3. From (Name and Position): $from\n\n";
my $body4 = "4. Subject: $subject\n\n";
my $body5 = "5. Date: $date";
my $body6 = "  6. Time: $time\n\n";
my $body7 = "7. Message: $msg\n\n";
my $body8 = "8. Approved by:  Name: $approved\n  Signature: $asig\n";
my $body8a = "  Position/Title: $atitle\n\n";
my $body9 = "9. Reply: $rmsg\n\n"; 
my $body10 = "10. Replied by:  Name: $rname\n  Position/Title: $rtitle\n";
my $body10a = "  Signature: $rsig\n";
my $body11 = "  Date\/Time: $rdandt";

my ($fbody) = ($body0 . $body1 . $body2 . $body3 . $body4 . $body5 . $body6 . $body7 . $body8 . $body8a . $body9 . $body10 . $body10a . $body11);

my $fbody_len = length($fbody);

print "Content-type: text/html\n\n";
print "<html><head><title>FORM IC-213 QUEUED FOR DELIVERY</title></head>\n";
print "<body><FONT SIZE = 3>Thank you!<br>Your IC-213 message below<br>has been queued<br>for delivery via Amateur Radio<br>and the Winlink system.<br>\n";
print "Your email message:<br><br>$body0<br><br>$body1<br><br>$body2<br><br>$body3<br><br>$body4<br><br>$body5<br><br>$body6<br><br>$body7<br><br>$body8<br><br>$body8a<br><br>$body9<br><br>$body10<br><br>$body10a<br><br>$body11</FONT><br><br>\n";
print "</body></html>\n";

open TMP, '>', "/home/dwayne/.wl2k/mailbox/N4MIO/out/$filename";

print TMP "Mid: $mid\n";
print TMP "Body: $fbody_len\n";
print TMP "Content-Transfer-Encoding: 8bit\n";
print TMP "Content-Type: text/plain; charset=ISO-8859-1\n";
#print TMP "Date: $gdate\n";
print TMP "Date: $year\/$mon\/$mday $hour\:$min\n";      #2019/07/19 12:37
#print TMP "$abbr[$mon] $mday\n";
print TMP "From: N4MIO\n";
print TMP "Mbo: N4MIO\n";
print TMP "Subject: $subject\n";
print TMP "To: SMTP:dwayne\@n4mio.com\n";
print TMP "Type: Private\n\n";
#print TMP " Begin Message\n"; 
#print TMP "=================================\n";
	
print TMP $body0;
print TMP $body1;
print TMP $body2;
print TMP $body3;
print TMP $body4;
print TMP $body5;
print TMP $body6;
print TMP $body7;
print TMP $body8;
print TMP $body8a;
print TMP $body9;
print TMP $body10;
print TMP $body10a;
print TMP $body11;


#print TMP "=================================\n";
#print TMP " End Message\n\n";

#print TMP "Notice: This email was sent using amateur radio.Do not add attachments to replies. The system will not deliver replies with attachments. Also, this is not a private system. While we try to keep the replies private, it is possible that it could be viewed publicaly.\n";

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
print "<html><head><title>FORM IC-213</title>";
print "<!-- Style to set the size of checkbox --> <style> input.largerCheckbox { width: 30px; height: 30px; } </style>";
print "</head>\n";
print "<body><FONT SIZE = 5><b>FORM IC-213</b></FONT><br><br>\n";

#print "* </font><i> = Required fields</i><br><br>\n";
print "<form method=POST action=$cgiurl>\n";

print "<input id=tt name=tt type=hidden value=two13>\n";

# 1
print "<FONT SIZE = 2 color = Black>1. Incident Name (Optional):</font><br>\n";
#print "<FONT SIZE = 2 color = Black>1. Incident Name (Optional):</font><br>\n";
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
print "<input id=date name=date size=10 type=text value=$mon\/$mday\/$year>\n";

# 6
print "<br><FONT SIZE = 2 color = Black>6. Time:</font><br>\n";
print "<input id=time name=time size=5 type=text value=$hour\:$min><br><br>\n";

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
