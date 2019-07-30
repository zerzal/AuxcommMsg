#!/usr/bin/perl
##!/usr/bin/env perl

#AUXCOMM MESSAGING FOR PAT WINLINK SERVER - see $ver below

 #use strict;
 #use warning;
 
 
 
# SET VARIABLES
#######################

#Set up time variables
my ($gsec,$gmin,$ghour,$gmday,$gmon,$gyear,$gwday,$gyday,$gisdst) = gmtime(time);
#my $gmthour = $hour + 2;
my ($lsec,$lmin,$lhour,$lmday,$lmon,$lyear,$lwday,$lyday,$lisdst) = localtime(time);
#my @abbr = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
$gyear += 1900;
$gmon += 1;
$lyear += 1900;
$lmon += 1;
#$mday += 1;
#my $gdate = gmdate('Y/m/d h:i',time());

#my $ftime = "$ghour\:$gmin";


if ($lmin < "10") {
  $lmin = "0" .$lmin;
 }
 
if ($lhour < "10") {
  $lhour = "0" .$lhour;
 }
 
if ($lmon < "10") {
  $lmon = "0" .$lmon;
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


my $ftime = "$lhour:$lmin\n";


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
   if ($FORM{'reply'}) {
       my $rmsg = "THIS IS A REPLY\n";
   }

my $incident = $FORM{'incident'};
my $to = $FORM{'to'};
my $tpos = $FORM{'tpos'};
my $email = $FORM{'email'};
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
#my $reply = $FORM{'reply'};
#my $rname = $FORM{'rname'};
#my $rtitle = $FORM{'rtitle'};
#my $rsig = $FORM{'rsig'};
#my $rdandt = $FORM{'rdandt'};

#File name generator
my @chars = ("A".."Z", "0".."9");
my $mid;
$mid .= $chars[rand @chars] for 1..12;

#Build body of email file

    $filename = $mid.'.b2f';
	
	

my $bodyr = "$rmsg\n\n";
my $body0 = "GENERAL MESSAGE (ICS 213 - modified)\n\n";
my $body1 = "1. Incident Name (Optional): $incident\n\n";
my $body2 = "2. To (Name): $to\n";
my $body2a = "\tPosition/Title: $tpos\n";
my $body2b = "\tEmail: $email\n\n";
my $body3 = "3. From (Name): $from\n";
my $body3a = "\tPosition/Title: $pt\n";
my $body3b = "\tSignature: $sig\n\n";
my $body4 = "4. Subject: $subject\n\n";
my $body5 = "5. Date: $date";
my $body6 = "6. Time: $time\n\n";
my $body7 = "7. Message:\n $msg\n\n";
my $body8 = "8. Approved by: $approved\n";
my $body8a = "\tSignature: $asig\n";
my $body8b = "\tPosition/Title: $atitle\n\n";
#my $body9 = "9. Reply: $rmsg\n\n"; 
#my $body10 = "10. Replied by:  Name: $rname\n  \tPosition/Title: $rtitle\n";
#my $body10a = "\tSignature: $rsig\n";
#my $body11 = "\tDate\/Time: $rdandt";

my ($fbody) = ($bodyr . $body0 . $body1 . $body2 . $body2a . $body2b . $body3 . $body3a . $body3b . $body4 . $body5 . $body6 . $body7 . $body8 . $body8a . $body8b);

my $fbody_len = length($fbody);

print "Content-type: text/html\n\n";
print "<html><head><title>FORM IC-213 QUEUED FOR DELIVERY</title></head>\n";
print "<body><FONT SIZE = 3>Thank you!<br>Your IC-213 message below has been queued<br>for delivery via Amateur Radio<br>and the Winlink system.<br>\n";
print "<br>$bodyr<br><br>$body0<br><br>$body1<br><br>$body2<br><br>$body2a<br><br>$body2b<br><br>$body3<br><br>$body3a<br><br>$body3b<br><br>$body4<br><br>$body5<br><br>$body6<br><br>$body7<br><br>$body8<br><br>$body8a<br><br>$body8b</FONT><br><br>\n";
#print "<br><br>$FORM{'reply'}\n";
print "</body></html>\n";

open TMP, '>', "/home/dwayne/.wl2k/mailbox/N4MIO/out/$filename";

print TMP "Mid: $mid\n";
print TMP "Body: $fbody_len\n";
print TMP "Content-Transfer-Encoding: 8bit\n";
print TMP "Content-Type: text/plain; charset=ISO-8859-1\n";
#print TMP "Date: $gdate\n";
print TMP "Date: $gyear\/$gmon\/$gmday $ghour\:$gmin\n";      #2019/07/19 12:37
#print TMP "$abbr[$mon] $mday\n";
print TMP "From: N4MIO\n";
print TMP "Mbo: N4MIO\n";
print TMP "Subject: $subject\n";
print TMP "To: SMTP: $email\n";
print TMP "Type: Private\n\n";
#print TMP " Begin Message\n"; 
#print TMP "=================================\n";
	
print TMP $bodyr;
print TMP $body0;
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
#print TMP $body9;
#print TMP $body10;
#print TMP $body10a;
#print TMP $body11;


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
print "<html><head><title>GENERAL MESSAGE (ICS 213 - modified)</title>";
print "<!-- Style to set the size of checkbox --> <style> input.largerCheckbox { width: 30px; height: 30px; } </style>";
print "</head>\n";
print "<body><FONT SIZE = 5><b>GENERAL MESSAGE<br>(ICS 213 - modified)</b></FONT><br><br>\n";

#print "* </font><i> = Required fields</i><br><br>\n";
print "<form method=POST action=$cgiurl>\n";

print "<input id=tt name=tt type=hidden value=two13>\n";

# 1
print "<FONT SIZE = 2 color = Black>1. Incident Name (Optional):</font><br>\n";
#print "<FONT SIZE = 2 color = Black>1. Incident Name (Optional):</font><br>\n";
print "<input id=incident name=incident size=40 type=text><br><br>\n";

# 2
print "<FONT SIZE = 2 color = Black>2. To (Name):</font><br>\n";
print "<input id=to name=to size=40 type=text><br><br>\n";

print "<FONT SIZE = 2 color = Black>Position:</font><br>\n";
print "<input id=tpos name=tpos size=40 type=text><br><br>\n";

print "<FONT SIZE = 2 color = Black>Email Address: </font><FONT SIZE = 2 color = Red>(Can be Winlink User alias)</font><br>\n";
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
#print "<FONT SIZE = 2 color = Black>10. Replied by: Name:</font><br>\n";
#print "<input id=rname name=rname size=40 type=text><br>\n";

#print "<FONT SIZE = 2 color = Black>Position/Title:</font><br>\n";
#print "<input id=rtitle name=rtitle size=40 type=text><br>\n";

#print "<FONT SIZE = 2 color = Black>Signature:</font><br>\n";
#print "<input id=rsig name=rsig size=40 type=text><br><br>\n";

#print "<FONT SIZE = 2 color = Black>Date/Time:</font><br>\n";
#print "<input id=rdandt name=rdandt size=30 type=text value=$lmon\/$lmday\/$lyear-$lhour:$lmin><br><br><br>\n";
 
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
