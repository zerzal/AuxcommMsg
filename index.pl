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

my (@pairs, $name, $value, %FORM, $filename, $pair, $htmfile, $htmchars, $err, $first, $bodyr, $htmfilepath);
my $attached = " ATTACHED";

## FOLDER TO USE ACCORDING TO MACHINE IN USE

my $folder = "C:/Users/dcayers/.wl2k/mailbox/N4MIO/out/"; #using work pc

#my $folder = "C:/Users/n4mio/.wl2k/mailbox/N4MIO/out/";   #using home pc

#my $folder = "/home/dwayne/.wl2k/mailbox/N4MIO/out/";	  #using Linux

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

my $ver = "1.1";

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

#OUTPUT FOR FORM ICS 213
########################
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

#Build body of message file

$filename = "$mid.b2f";  
	
	
#my $bodyr = " ";

 if ($reply) {
     $bodyr = "$rmsg\n\n";
    }
my $body0 = "GENERAL MESSAGE (ICS 213)";
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


#PRINT ICS 213 FORM TO WEB PAGE
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
print "$body7_split[0..1]\<br>";
print "$body7_split[2..12]<br>";
print "$body7_split[13..22]<br>";
print "$body7_split[23..32]<br>";
print "$body7_split[33..42]<br>";
print "$body7_split[43..52]<br>";
print "$body7_split[53..62]<br>";
print "$body7_split[63..72]<br>";
print "</th></tr>\n";

# 8
print "<tr><th style=text-align:left>\n";
print "$body8\&nbsp\;\&nbsp\;$body8a\&nbsp\;\&nbsp\;$body8b";
print "</th></tr>\n";
print "</table><br>";
print "</div>";

#Add button to print web page

print "<b><input type=button name=print style=background-color:#C42F47 value=\"PRINT MESSAGE\" onClick=printDiv('printMe')>";

print "\&nbsp\;\&nbsp\;<input type=button style=background-color:#FFCC33 onClick=\"location.href=\'index.pl\'\" value=\'Main Menu\'></b>";

print "<br><br><br><br>";

print "</center></body></html>\n";

#BUILD HTM FILE TO ATTACH TO EMAIL

$htmfile = $mid.'.htm';

open HTM, '>', $folder.$htmfile;

print HTM "<html><head><title>ICS 213</title>";
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
print HTM "<br><FONT SIZE = 5><b>GENERAL MESSAGE (ICS 213)</b></FONT>";
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
		$body2c_len = length($body2c);
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
print HTM "$body7_split[0..1]\<br>";
print HTM "$body7_split[2..12]<br>";
print HTM "$body7_split[13..22]<br>";
print HTM "$body7_split[23..32]<br>";
print HTM "$body7_split[33..42]<br>";
print HTM "$body7_split[43..52]<br>";
print HTM "$body7_split[53..62]<br>";
print HTM "$body7_split[63..72]<br>";

#print HTM $body7;
print HTM "</th></tr>\n";

# 8
print HTM "<tr><th style=text-align:left>\n";
print HTM "$body8\&nbsp\;\&nbsp\;$body8a\&nbsp\;\&nbsp\;$body8b";
print HTM "</th></tr>\n";

print HTM "</table><br>";
print HTM "</div>";

#Add button to print HTM web page

print HTM "<b><input type=button name=print style=background-color:#C42F47 value=\"PRINT MESSAGE\" onClick=printDiv('printMe')>";

print HTM "<br><br><br><br>";

print HTM "</center></body></html>\n";

close HTM;

$htmfilepath = $folder.$htmfile;
$htmchars = -s $htmfilepath;

#Body charater count
#my $fbody_len = length($body0) + length($attached) + length($bodyr) + 2;

my $fbody_len = length($body0) + length($attached) + 2;


#CREATE B2F ICS 213 FILE FOR SENDING VIA WINLINK

open TMP, '>', $folder.$filename or die "Could not open file: $!";  

#Header information
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
   print TMP "Cc: SMTP: $cc\n";
	 }

print TMP "File: $htmchars $htmfile\n";

print TMP "Type: Private\n\n";

#Message Body
print TMP $body0.$attached;
print TMP "\n\n";

open HTM, '<', $folder.$htmfile or die "Could not open file: $!";
	while (<HTM>) {
		print TMP $_;
	}
close HTM;

close TMP;

}

else {
        $err = "DID YOU FORGET AN EMAIL/WINLINK ADDRESS?";
		&error;
       }

}

  else {
        $err = "DID YOU FORGET YOUR MESSAGE BODY?";
		&error;
       }

exit;
}

#OUTPUT FOR SIMPLE MESSAGE FORM
if ($FORM{'sim'}) {
 if ($FORM{'msg'}) {
  if ($FORM{'email'}) {
 
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
my $subject = $FORM{'subject'};
my $date = $FORM{'date'};
my $time = $FORM{'time'};
my $msg = $FORM{'msg'};
my $reply = $FORM{'reply'};
my $rmsg = "*** THIS IS A REPLY ***";

#File name generator
my @chars = ("A".."Z", "0".."9");
my $mid;
$mid .= $chars[rand @chars] for 1..12;

#Build body of message file

$filename = "$mid.b2f";  
	
	
#my $bodyr = " ";

 if ($reply) {
     $bodyr = "$rmsg\n\n";
    }
my $body0 = "SIMPLE MESSAGE";
my $body1 = "From (Name): $from\n";
my $body2a = "\tTo: $email\n\n";
my $body2b = "\tCc: $cc\n\n";
my $body3 = "Subject: $subject\n\n";
my $body4 = "Date: $date\n";
my $body5 = "Time: $time\n\n";
my $body6 = "Message:\n $msg\n\n";

#PRINT SIMPLE MESSAGE FORM TO WEB PAGE
print "Content-type: text/html\n\n";
print "<html><head><title>SIMPLE MESSAGE QUEUED FOR DELIVERY</title>";
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


print "<body style=\"background-color:powderblue;\"><FONT SIZE = 3 COLOR = BLUE><b><i>Thank you!<br>Your Simple Message below has been queued<br>for delivery via Amateur Radio and the Winlink system.</i></b></font><br><br>";
print "<center>";
print "<div id='printMe'>";
print "<br><FONT SIZE = 5><b>$body0</b></FONT>";
print "<br><FONT SIZE = 3 COLOR = RED>$bodyr</FONT><br>";
print "<table style=width:100\%>";
print "<table class=\"center\">";

# From
print "<tr><th style=text-align:left>\n";
print $body1;
print "</th></tr>\n";

# Email address and CC email address
print "<tr><th style=text-align:left>\n";
print "$body2a";
	my $body2b_len = length($body2b);
	if ($body2b_len > 7) {
		print "\&nbsp\;\&nbsp\;$body2b";
	}
print "</th></tr>\n";


# Subject, date and time
print "<tr><th style=text-align:left>\n";
print "$body3\&nbsp\;\&nbsp\;$body4\&nbsp\;\&nbsp\;$body5";
print "</th></tr>\n";

# Message
print "<tr><th style=text-align:left>\n";
my @body6_split = split / /, $body6;
print "$body6_split[0]\<br>";
print "$body6_split[1..12]<br>";
print "$body6_split[13..22]<br>";
print "$body6_split[23..32]<br>";
print "$body6_split[33..42]<br>";
print "$body6_split[43..52]<br>";
print "$body6_split[53..62]<br>";
print "$body6_split[63..72]<br>";
print "</th></tr>\n";

print "</table><br>";
print "</div>";

#Add button to print web page

print "<b><input type=button name=print style=background-color:#C42F47 value=\"PRINT MESSAGE\" onClick=printDiv('printMe')>";

print "\&nbsp\;\&nbsp\;<input type=button style=background-color:#FFCC33 onClick=\"location.href=\'index.pl\'\" value=\'Main Menu\'></b>";

print "<br><br><br><br>";

print "</center></body></html>\n";

#BUILD HTM FILE TO ATTACH TO EMAIL

$htmfile = $mid.'.htm';

open HTM, '>', $folder.$htmfile;  

print HTM "<html><head><title>SIMPLE MESSAGE</title>";
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
print HTM "<br><FONT SIZE = 5><b>SIMPLE MESSAGE</b></FONT>";
print HTM "<br><FONT SIZE = 3 COLOR = RED>$bodyr</FONT><br>";
print HTM "<table style=width:100\%>";
print HTM "<table class=\"center\">";

# From
print HTM "<tr><th style=text-align:left>\n";
print HTM $body1;
print HTM "</th></tr>\n";

# To email and CC
print HTM "<tr><th style=text-align:left>\n";
print HTM "$body2a";
		$body2b_len = length($body2b);
	if ($body2b_len > 7) {
		print HTM "\&nbsp\;\&nbsp\;$body2b";
	}
print HTM "</th></tr>\n";

# Subject, Date and Time
print HTM "<tr><th style=text-align:left>\n";
print HTM "$body3\&nbsp\;\&nbsp\;$body4\&nbsp\;\&nbsp\;$body5";
print HTM "</th></tr>\n";

# Message
print HTM "<tr><th style=text-align:left>\n";
print HTM "$body6_split[0]\<br>";
print HTM "$body6_split[1..12]<br>";
print HTM "$body6_split[13..22]<br>";
print HTM "$body6_split[23..32]<br>";
print HTM "$body6_split[33..42]<br>";
print HTM "$body6_split[43..52]<br>";
print HTM "$body6_split[53..62]<br>";
print HTM "$body6_split[63..72]<br>";
print HTM "</th></tr>\n";

print HTM "</table><br>";
print HTM "</div>";

#Add button to print HTM web page

print HTM "<b><input type=button name=print style=background-color:#C42F47 value=\"PRINT MESSAGE\" onClick=printDiv('printMe')>";

print HTM "<br><br><br><br>";

print HTM "</center></body></html>\n";

close HTM;

$htmfilepath = $folder.$htmfile;
$htmchars = -s $htmfilepath;

#Body charater count
my $fbody_len = length($body0) + length($attached) + 2;

#CREATE B2F SIMPLE MESSAGE FILE FOR SENDING VIA WINLINK

open TMP, '>', $folder.$filename or die "Could not open file: $!";  

#Header information
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
   print TMP "Cc: SMTP: $cc\n";
	 }

print TMP "File: $htmchars $htmfile\n";

print TMP "Type: Private\n\n";

#Message Body
print TMP $body0.$attached;
print TMP "\n\n";

open HTM, '<', $folder.$htmfile or die "Could not open file: $!";
	while (<HTM>) {
		print TMP $_;
	}
close HTM;

close TMP;

}

else {
        $err = "DID YOU FORGET AN EMAIL/WINLINK ADDRESS?";
		&error;
       }

}

  else {
        $err = "DID YOU FORGET YOUR MESSAGE BODY?";
		&error;
       }

exit;
}

#OUTPUT FOR FORM RADIOGRAM
###########################
if ($FORM{'rgram'}) {

 $first = $FORM{'firstname'};
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

if ($FORM{'simple'}) {
&simple;
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
print "<body style=\"background-color:db3033;\"><center><FONT SIZE = 6><b>AUXCOMM MESSAGING SERVER</b></FONT><FONT SIZE = 2 color = purple>\&nbsp\;\&nbsp\;<b>$ver</b></font><br>\n";
print "<br><FONT SIZE = 5 COLOR = 1f1a1a><I>CREATE YOUR MESSAGE</I></FONT><BR><BR><BR>";
print "<FORM ACTION=$cgiurl METHOD=POST>";
print "<INPUT TYPE=submit  style=\"font-size:20px; background-color:black; color:FFCC33; border: 3pt ridge grey\" NAME=213 VALUE=\"GENERAL MESSAGE (ICS 213)\"><br><br><br>";
print "<INPUT TYPE=submit style=\"font-size:20px; background-color:black; color:53b1e0; border: 3pt ridge grey\" NAME=simple VALUE=\"SIMPLE MESSAGE\"><br><br><br>";
print "<INPUT TYPE=submit NAME=rg VALUE=\"RADIOGRAM\" style=\"font-size:20px; background-color:f2f268; color:395935; border: 3pt ridge grey\">";
print "</form>\n";
print "<font size=4><b>Radiogram Under Construction</font></b>";
print "</center>";
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
print "<body style=\"background-color:FFCC33;\"><center><FONT SIZE = 5><b><br><br>GENERAL MESSAGE (ICS 213)</b></FONT><br><br>\n";

print "<form method=POST action=$cgiurl>\n";

print "<input id=tt name=tt type=hidden value=two13>\n";

# Reply checkbox
print "<FONT SIZE = 3 color = Black><b>CHECK HERE IF REPLY</font>\&nbsp\;</b>\n";
print "<input id=reply name=reply type=checkbox value=1 class=largerCheckbox><br><br>\n";

#Fields of 213 form
# 1

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

print "<br><input type=submit> \* <input type=reset><br><br>\n";
print "<input type=button style=background-color:#FFCC33 onClick=\"location.href=\'index.pl\'\" value=\'Main Menu\'></b>";
print "</form></center>";

print "<br><br><br><br></body></html>\n";

exit;

}

#FORM SIMPLE MESSAGE
sub simple {
print "Content-type: text/html\n\n";
print "<html><head><title>SIMPLE MESSAGE</title>";
print "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">";
print "<!-- Style to set the size of checkbox --> <style> input.largerCheckbox { width: 20px; height: 20px; } </style>";
print "<style>table, th, td {border: 2px solid black;border-collapse: collapse;padding: 10px;}</style>";
print "</head>\n";
print "<body style=\"background-color:53b1e0;\"><center><FONT SIZE = 5><b><br><br>SIMPLE MESSAGE</b></FONT><br><br>\n";

print "<form method=POST action=$cgiurl>\n";

print "<input id=sim name=sim type=hidden value=simple>\n";

# Reply checkbox
print "<FONT SIZE = 3 color = Black><b>CHECK HERE IF REPLY</font>\&nbsp\;</b>\n";
print "<input id=reply name=reply type=checkbox value=1 class=largerCheckbox><br><br>\n";

#Fields of Simple Message form
# table setup
print "<table style=width:100\%>";
print "<table class=\"center\">";

# From
print "<tr><th style=text-align:left>\n";
print "<FONT SIZE = 3 color = Black>From (Name):</font>\&nbsp\;\&nbsp\;\n";
print "<input id=from name=from size=30 type=text>\&nbsp\;\&nbsp\;\n";
print "</th></tr>\n";

# To
print "<tr><th style=text-align:left>\n";
print "<FONT SIZE = 3 color = Black>To Email Address\&nbsp\;<b>(Required):</b></font>\n";
print "<input id=email name=email size=30 type=text>\&nbsp\;\&nbsp\;\n";

# CC
print "<FONT SIZE = 3 color = Black>CC:\&nbsp\;\&nbsp\;</font>\n";
print "<input id=cc name=cc size=30 type=text><br>\n";
print "<FONT SIZE = 2 color = purple>[Can be Winlink user alias]</font><br>\n";
print "</th></tr>\n";

# Subject
print "<tr><th style=text-align:left>\n";
print "<FONT SIZE = 3 color = Black>Subject:</font>\&nbsp\;\&nbsp\;\n";
print "<input id=subject name=subject size=30 type=text>\&nbsp\;\&nbsp\;\n";

# Date
print "<FONT SIZE = 3 color = Black>Date:</font>\&nbsp\;\&nbsp\;\n";
print "<input id=date name=date size=14 type=text value=$lmon\/$lmday\/$lyear>\&nbsp\;\&nbsp\;\n";

# Time
print "<FONT SIZE = 3 color = Black>Time:</font>\&nbsp\;\&nbsp\;\n";
print "<input id=time name=time size=7 type=text value=$ftime><br>\n";
print "</th></tr>\n";

# Message
print "<tr><th style=text-align:left>\n";
print "<FONT SIZE = 3 color = Black>Message: <b>(Required)</b></font><br>\n";
print "<textarea name=msg cols=100 rows=10></textarea><br>";
print "</th></tr>\n";


print "</table>";

print "<br><input type=submit> \* <input type=reset><br><br>\n";
print "<input type=button style=background-color:#FFCC33 onClick=\"location.href=\'index.pl\'\" value=\'Main Menu\'></b>";
print "</form></center>";

print "<br><br><br><br></body></html>\n";

exit;

}

#FORM RADIOGRAM
sub radiogram {
print "Content-type: text/html\n\n";
print "<html><head><title>RADIOGRAM FOR PAT WINLINK</title>";
print "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">";
print "<!-- Style to set the size of checkbox --> <style> input.largerCheckbox { width: 20px; height: 20px; } </style>";
print "<style>table, th, td {border: 2px solid black;border-collapse: collapse;padding: 10px;}</style>";
print " <style type=text/css>
            dummydeclaration { padding-left: 1em; } /* Firefox ignores first declaration for some reason */
			tab0 { padding-left: 1em; }
            tab1 { padding-left: 2em; }
            tab2 { padding-left: 3em; }
            tab3 { padding-left: 4em; }
            tab4 { padding-left: 16em; }
            tab5 { padding-left: 20em; }
            tab6 { padding-left: 24em; }
            tab7 { padding-left: 28em; }
            tab8 { padding-left: 32em; }
            tab9 { padding-left: 36em; }
            tab10 { padding-left: 40em; }
            tab11 { padding-left: 44em; }
            tab12 { padding-left: 48em; }
            tab13 { padding-left: 52em; }
            tab14 { padding-left: 56em; }
            tab15 { padding-left: 60em; }
            tab16 { padding-left: 64em; }

        </style>";
print "</head>\n";
print "<body style=\"background-color:6db070;\"><center><FONT SIZE = 5><b><br><br>RADIOGRAM</b></FONT><br><br>\n";

print "<form method=POST action=$cgiurl>\n";

print "<input id=rgram name=rgram type=hidden value=radiogram>\n";

# Reply checkbox
print "<FONT SIZE = 3 color = Black><b>CHECK HERE IF REPLY</font>\&nbsp\;</b>\n";
print "<input id=reply name=reply type=checkbox value=1 class=largerCheckbox><br><br>\n";

#Table setup
print "<table style=width:100\%>";
print "<table class=\"center\">";

#Fields of Radiogram form
# Row 1
# Header Line
print "<tr><th style=text-align:left>\n";
print "<FONT SIZE = 3 color = Black>Number</font>";
print "<tab3><FONT SIZE = 3 color = Black>Precedence</tab3></font>";
print "<tab1><FONT SIZE = 3 color = Black>HX</tab1></font>";
print "<tab1><FONT SIZE = 3 color = Black>Station of Origin</tab1></font>";
print "<tab0><FONT SIZE = 3 color = Black>Check</tab0></font>";
print "<tab1><FONT SIZE = 3 color = Black>Place of Origin</tab1></font>";
print "<tab0><FONT SIZE = 3 color = Black>Time Filed</tab0></font>";
print "<tab0><FONT SIZE = 3 color = Black>Date</tab0></font>";

# Input fields
print "<br>";
print "<input id=rnum name=rnum size=10 type=text>\n";
print "<input id=rpres name=rpres size=10 type=text>\n";
print "<input id=rhx name=rhx size=3 type=text>\n";
print "<input id=rsoo name=rsoo size=13 type=text>\n";
print "<input id=rck name=rck size=3 type=text>\n";
print "<input id=rpoo name=poo size=13 type=text>\n";
print "<input id=rtm name=rtim size=6 type=text value=$ftime>\n";
print "<input id=rdt name=rdt size=6 type=text value=$lmon\/$lmday\/$lyear>\n";
print "</tr></th>\n";

# Row 2
print "<tr><th style=text-align:left>\n";
print "<FONT SIZE = 3 color = Black>To</font><br>\n";
print "<textarea name=rto cols=40 rows=6></textarea><br>";;

print "<FONT SIZE = 3 color = Black>Telephone Number</font>\n";
print "<input id=rtel name=rtel size=19 type=text><br>\n";

print "<FONT SIZE = 3 color = Black>Email Address</b></font>\n";
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

print "<br><input type=submit> \* <input type=reset><br><br>\n";
print "<input type=button style=background-color:#FFCC33 onClick=\"location.href=\'index.pl\'\" value=\'Main Menu\'></b>";
print "</form></center>";

print "<br><br><br><br></body></html>\n";

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

sub error {               #Process error messages
print "Content-type: text/html\n\n";
print "<html><head><title>LS PURCHASING ERROR PAGE</title><script>\n";
print "function goBack() { window.history.back()}\n";
print "</script>\n";
print "</head><body>\n";
print "<FONT SIZE = 4 color = black>Error - <b>$err</b></FONT>\n";
print  "<br><br>";
print "<button onclick=goBack()>Go Back</button>\n";
print  "<br><br>";
print "</body></html>\n";
exit;
}