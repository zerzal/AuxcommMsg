#!/usr/bin/perl
#AUXCOMM MESSAGING FOR PAT WINLINK SERVER - see $ver below

 use strict;
 use warnings;
  
# SET VARIABLES
#######################

#Set up time variables
my ($gsec,$gmin,$ghour,$gmday,$gmon,$gyear,$gwday,$gyday,$gisdst) = gmtime(time);

my ($lsec,$lmin,$lhour,$lmday,$lmon,$lyear,$lwday,$lyday,$lisdst) = localtime(time);

$gyear += 1900;
$gmon += 1;
$lyear += 1900;
$lmon += 1;

my (@pairs, $name, $value, %FORM, $filename, $pair, $htmfile);

##############################################################################

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

my $ftime = "$lhour:$lmin\n";

my $cgiurl = "index.pl";

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
  if ($FORM{'email'}) {
 
my $incident = $FORM{'incident'};
my $to = $FORM{'to'};
my $tpos = $FORM{'tpos'};
my $email = $FORM{'email'};

	if ($email !~ "@") {
	    $email = $email ."\@winlink.org";
	}

my $cc = $FORM{'cc'};

   if ($cc) {     
  
      if ($cc !~ "@") {
	  $cc = $cc ."\@winlink.org";
	 }
   }

my $from = $FORM{'from'};
my $pt = $FORM{'title'};
#my $sig = $FORM{'sig'};
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
my $body0 = "GENERAL MESSAGE (ICS 213)\n\n";
my $body1 = "1. Incident Name (Optional): $incident\n\n";
my $body2 = "2. To (Name): $to\n";
my $body2a = "\tPosition/Title: $tpos\n";
my $body2b = "\tEmail: $email\n\n";
my $body2c = "\tCC: $cc\n\n";
my $body3 = "3. From (Name): $from\n";
my $body3a = "\tPosition/Title: $pt\n";
#my $body3b = "\tSignature: $sig\n\n";
my $body4 = "4. Subject: $subject\n\n";
my $body5 = "5. Date: $date\n";
my $body6 = "6. Time: $time\n\n";
my $body7 = "7. Message:\n $msg\n\n";
my $body8 = "8. Approved by: $approved\n";
my $body8a = "\tSignature: $asig\n";
my $body8b = "\tPosition/Title: $atitle\n\n";
my ($fbody) = ($bodyr . $body0 . $body1 . $body2 . $body2a . $body2b . $body2c . $body3 . $body3a . $body4 . $body5 . $body6 . $body7 . $body8 . $body8a . $body8b);
my $fbody_len = length($fbody);

#PRINT SENT MESSAGE TO WEB PAGE
print "Content-type: text/html\n\n";
print "<html><head><title>FORM IC-213 QUEUED FOR DELIVERY</title>";
print "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">";
print "<style>table, th, td {border: 2px solid black;border-collapse: collapse;padding: 10px;}</style></head>\n";

print "<script>
		function printDiv(divName){
			var printContents = document.getElementById(divName).innerHTML;
			var originalContents = document.body.innerHTML;

			document.body.innerHTML = printContents;

			window.print();

			document.body.innerHTML = originalContents;

		}
	</script>";


print "<body style=\"background-color:powderblue;\"><FONT SIZE = 3 COLOR = BLUE><b><i>Thank you!<br>Your IC-213 message below has been queued<br>for delivery via Amateur Radio and the Winlink system.</i></b></font><br><br>";
print "<center>";
print "<div id='printMe'>";
print "<br><FONT SIZE = 5><b>$body0</b></FONT>";
print "<br><FONT SIZE = 3 COLOR = RED>$bodyr</FONT><br>";
print "<table style=width:100\%>";
print "<table class=\"center\">";

# 1
print "<tr><th style=text-align:left>\n";
print $body1;
print "</th></tr>\n";

# 2
print "<tr><th style=text-align:left>\n";
print "$body2\&nbsp\;\&nbsp\;$body2a<br><br>\&nbsp\;\&nbsp\;\&nbsp\;$body2b";
	my $body2c_len = length($body2c);
	if ($body2c_len > 7) {
		print "\&nbsp\;\&nbsp\;$body2c";
	}
print "</th></tr>\n";

# 3
print "<tr><th style=text-align:left>\n";
print "$body3\&nbsp\;\&nbsp\;$body3a";
print "</th></tr>\n";

# 4
print "<tr><th style=text-align:left>\n";
print "$body4\&nbsp\;\&nbsp\;$body5\&nbsp\;\&nbsp\;$body6";
print "</th></tr>\n";

# 7
print "<tr><th style=text-align:left>\n";
my @body7_split = split / /, $body7;
print "@body7_split[0..1]\<br><br>";
print "@body7_split[2..12]<br>";
print "@body7_split[13..22]<br>";
print "@body7_split[23..32]<br>";
print "@body7_split[33..42]<br>";
print "@body7_split[43..52]<br>";
print "@body7_split[53..62]<br>";
print "@body7_split[63..72]<br>";
print "</th></tr>\n";

# 8
print "<tr><th style=text-align:left>\n";
print "$body8\&nbsp\;\&nbsp\;$body8a\&nbsp\;\&nbsp\;$body8b";
print "</th></tr>\n";

print "</table><br>";
#print "</center>";
print "</div>";

#Add button to print web page
#print "<center>";
print "<b><input type=button name=print style=background-color:#C42F47 value=\"Print Form\" onClick=printDiv('printMe')>";

#print "<button onclick=\"myFunction()\">Print this page</button>";

#print "<script>";
#print "function myFunction() {";
#print "  window.print()\;";
#print "}";
#print "</script>";

print "\&nbsp\;\&nbsp\;<input type=button style=background-color:#FFCC33 onClick=\"location.href=\'index.pl\'\" value=\'Main Menu\'></b>";

print "<br><br><br><br>";

#print "$filename\n";                                             ##FOR TESTING VIA OPENSHIFT

print "</center></body></html>\n";

#BUILD HTM FILE TO ATTACH TO EMAIL

$htmfile = $mid.'.htm';

open HTM, '>', "$htmfile";  

print HTM "<html><head><title>FORM IC-213 ATTACHED</title>";
print HTM "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">";
print HTM "<style>table, th, td {border: 2px solid black;border-collapse: collapse;padding: 10px;}</style></head>\n";

print HTM "<script>
		function printDiv(divName){
			var printContents = document.getElementById(divName).innerHTML;
			var originalContents = document.body.innerHTML;

			document.body.innerHTML = printContents;

			window.print();

			document.body.innerHTML = originalContents;

		}
	</script>";


print HTM "<body style=\"background-color:white;\"><br><br>";
print HTM "<center>";
print HTM "<div id='printMe'>";
print HTM "<br><FONT SIZE = 5><b>$body0</b></FONT>";
print HTM "<br><FONT SIZE = 3 COLOR = RED>$bodyr</FONT><br>";
print HTM "<table style=width:100\%>";
print HTM "<table class=\"center\">";

# 1
print HTM "<tr><th style=text-align:left>\n";
print HTM $body1;
print HTM "</th></tr>\n";

# 2
print HTM "<tr><th style=text-align:left>\n";
print HTM "$body2\&nbsp\;\&nbsp\;$body2a<br><br>\&nbsp\;\&nbsp\;\&nbsp\;$body2b";
	my $body2c_len = length($body2c);
	if ($body2c_len > 7) {
		print HTM "\&nbsp\;\&nbsp\;$body2c";
	}
print HTM "</th></tr>\n";

# 3
print HTM "<tr><th style=text-align:left>\n";
print HTM "$body3\&nbsp\;\&nbsp\;$body3a";
print HTM "</th></tr>\n";

# 4
print HTM "<tr><th style=text-align:left>\n";
print HTM "$body4\&nbsp\;\&nbsp\;$body5\&nbsp\;\&nbsp\;$body6";
print HTM "</th></tr>\n";

# 7
print HTM "<tr><th style=text-align:left>\n";
#my @body7_split = split / /, $body7;
print HTM "@body7_split[0..1]\<br><br>";
print HTM "@body7_split[2..12]<br>";
print HTM "@body7_split[13..22]<br>";
print HTM "@body7_split[23..32]<br>";
print HTM "@body7_split[33..42]<br>";
print HTM "@body7_split[43..52]<br>";
print HTM "@body7_split[53..62]<br>";
print HTM "@body7_split[63..72]<br>";
print HTM "</th></tr>\n";

# 8
print HTM "<tr><th style=text-align:left>\n";
print HTM "$body8\&nbsp\;\&nbsp\;$body8a\&nbsp\;\&nbsp\;$body8b";
print HTM "</th></tr>\n";

print HTM "</table><br>";
print HTM "</div>";

#Add button to print HTM web page

print HTM "<b><input type=button name=print style=background-color:#C42F47 value=\"Print Form\" onClick=printDiv('printMe')>";

print HTM "<br><br><br><br>";

print HTM "</center></body></html>\n";

close HTM;

#CREATE B2F FILE FOR SENDING VIA WINLINK

#open TMP, '>', "/home/dwayne/.wl2k/mailbox/N4MIO/out/$filename";  ##FOR PRODUCTION

open TMP, '>', "$filename";                                      ##FOR TESTING VIA OPENSHIFT

print TMP "Mid: $mid\n";
print TMP "Body: $fbody_len\n";
print TMP "Content-Transfer-Encoding: 8bit\n";
print TMP "Content-Type: text/plain; charset=ISO-8859-1\n";
print TMP "Date: $gyear\/$gmon\/$gmday $ghour\:$gmin\n";      #2019/07/19 12:37
print TMP "From: N4MIO\n";
print TMP "Mbo: N4MIO\n";
print TMP "Subject: $subject\n";
print TMP "To: SMTP: $email\n";

if ($cc) {     
   print TMP "To: SMTP: $cc\n";
	 }

print TMP "Type: Private\n\n";
print TMP $body0;
print TMP $bodyr;
print TMP $body1;
print TMP $body2;
print TMP $body2a;
print TMP $body2b;
print TMP $body2c;
print TMP $body3;
print TMP $body3a;
#print TMP $body3b;
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
#Main Menu
sub begin {
print "Content-type: text/html\n\n";
print "<html><head><title>AUXCOMM MESSAGING SERVER $ver</title></head>\n";
print "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">";
print "<body style=\"background-color:FF3333;\"><FONT SIZE = 5><b>AUXCOMM<br>MESSAGING<br>SERVER</b></FONT><FONT SIZE = 2 color = purple>\&nbsp\;\&nbsp\;<b>$ver</b><br>\n";
print "<br><FONT SIZE = 4 COLOR = BLUE><I>FORMS</I></FONT><BR><BR>";
print "<FORM ACTION=$cgiurl METHOD=POST>";
print "<INPUT TYPE=submit NAME=213 VALUE=IC-213>\&nbsp\;\&nbsp\;";
print "<INPUT TYPE=submit NAME=email VALUE=EMAIL>";
print "</form>\n";

print "<FORM ACTION=$cgiurl METHOD=POST>";
print "<INPUT TYPE=submit NAME=rg VALUE=RADIOGRAM>";
print "</form>\n";

print "</body></html>\n";
exit;
}

#FORM IC-213
sub twothirteen {
print "Content-type: text/html\n\n";
print "<html><head><title>GENERAL MESSAGE (ICS 213)</title>";
print "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">";
print "<!-- Style to set the size of checkbox --> <style> input.largerCheckbox { width: 20px; height: 20px; } </style>";
print "<style>table, th, td {border: 2px solid black;border-collapse: collapse;padding: 10px;}</style>";
print "</head>\n";
print "<body style=\"background-color:FFCC33;\"><center><FONT SIZE = 5><b>GENERAL MESSAGE(ICS 213 - modified)</b></FONT><br><br>\n";

print "<form method=POST action=$cgiurl>\n";

print "<input id=tt name=tt type=hidden value=two13>\n";

# Reply checkbox
print "<FONT SIZE = 3 color = Black><b>CHECK HERE IF REPLY</font>\&nbsp\;</b>\n";
print "<input id=reply name=reply type=checkbox value=1 class=largerCheckbox><br><br>\n";

#Fields of 213 form
# 1
#print "<div data-role=\"main\" class=\"ui-content\">";
#print "<fieldset data-role=\"collapsible\">";

print "<table style=width:100\%>";
print "<table class=\"center\">";
print "<tr><th style=text-align:left>\n";
print "<FONT SIZE = 3 color = Black>1. Incident Name (Optional):</font>\&nbsp\;\&nbsp\;";
print "<input id=incident name=incident size=60 type=text><br>\n";
print "</th></tr>\n";

# 2
print "<tr><th style=text-align:left>\n";
print "<FONT SIZE = 3 color = Black>2. To (Name):\&nbsp\;\&nbsp\;</font>\n";
print "<input id=to name=to size=30 type=text>\&nbsp\;\&nbsp\;\n";

print "<FONT SIZE = 3 color = Black>Position/Title:\&nbsp\;\&nbsp\;</font>\n";
print "<input id=tpos name=tpos size=30 type=text><br><br>\n";

print "<FONT SIZE = 3 color = Black>Email Address\&nbsp\;<b>(Required):</b></font>\n";
print "<input id=email name=email size=30 type=text>\&nbsp\;\&nbsp\;\n";

print "<FONT SIZE = 3 color = Black>CC:\&nbsp\;\&nbsp\;</font>\n";
print "<input id=cc name=cc size=30 type=text><br>\n";
print "<FONT SIZE = 2 color = red>[Can be Winlink user alias]</font><br>\n";
print "</th></tr>\n";

# 3
print "<tr><th style=text-align:left>\n";
print "<FONT SIZE = 3 color = Black>3. From (Name):</font>\&nbsp\;\&nbsp\;\n";
print "<input id=from name=from size=30 type=text>\&nbsp\;\&nbsp\;\n";

print "<FONT SIZE = 3 color = Black>Position/Title:</font>\&nbsp\;\&nbsp\;\n";
print "<input id=title name=title size=30 type=text>\&nbsp\;\&nbsp\;\n";

#print "<FONT SIZE = 3 color = Black>Signature:</font>\&nbsp\;\&nbsp\;\n";
#print "<input id=sig name=sig size=40 type=text><br>\n";
print "</th></tr>\n";

# 4
print "<tr><th style=text-align:left>\n";
print "<FONT SIZE = 3 color = Black>4. Subject:</font>\&nbsp\;\&nbsp\;\n";
print "<input id=subject name=subject size=30 type=text>\&nbsp\;\&nbsp\;\n";

# 5
print "<FONT SIZE = 3 color = Black>5. Date:</font>\&nbsp\;\&nbsp\;\n";
print "<input id=date name=date size=14 type=text value=$lmon\/$lmday\/$lyear>\&nbsp\;\&nbsp\;\n";

# 6
print "<FONT SIZE = 3 color = Black>6. Time:</font>\&nbsp\;\&nbsp\;\n";
print "<input id=time name=time size=7 type=text value=$ftime><br>\n";
print "</th></tr>\n";

# 7
print "<tr><th style=text-align:left>\n";
print "<FONT SIZE = 3 color = Black>7. Message: <b>(Required)</b></font><br>\n";
print "<textarea name=msg cols=100 rows=10></textarea><br>";
print "</th></tr>\n";

# 8
print "<tr><th style=text-align:left>\n";
print "<FONT SIZE = 3 color = Black>8. Approved by (Name):</font>\&nbsp\;\&nbsp\;\n";
print "<input id=approved name=approved size=15 type=text>\&nbsp\;\&nbsp\;\n";

print "<FONT SIZE = 2 color = Black>Position/Title:</font>\&nbsp\;\&nbsp\;\n";
print "<input id=atitle name=atitle size=15 type=text>\&nbsp\;\&nbsp\;\n";

print "<FONT SIZE = 2 color = Black>Signature:</font>\&nbsp\;\&nbsp\;\n";
print "<input id=asig name=asig size=15 type=text><br>\n";
print "</th></tr>\n";
print "</table>";

print "<br><input type=submit> \* <input type=reset><br><br><br><br><br><br>\n";
print "</form></center>";

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
