#!/afs/isis/pkg/perl/bin/perl

# LIFE SAFETY SYSTEMS LEAVE CALENDAR - see $ver below

 use DateTime::TimeZone;
 use DateTime;

# Set Variables
#######################

$cgiurl = "index.pl";  #un-rem line for production
#$cgiurl = "http://www.unc.edu/usr-bin/dcayers/LS/CAL/TEST/leaveXX.pl"; #rem line for production
$tmptxt = "tempinfo.txt"; #un-rem line for production
#$tmptxt = "tempinfoX.txt";  #rem line for production
$ata = "leave.ics"; # ics file to attach for calendar entry  #un-rem line for production
#$ata = "leaveX.ics"; # ics file to attach for calendar entry  #rem line for production
$sendmurl = "sendm.pl"; #un-rem line for production
#$sendmurl = "http://www.unc.edu/usr-bin/dcayers/LS/CAL/TEST/sendmX.pl";  #rem line for production
$T = "T";
$Z = "Z";     
$date = localtime; # Get the Date for Entry
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = gmtime(); 
$year = $year + 1900;
$mon = $mon + 1;
$mdaylen = length $mday;
	if ($mdaylen < 2){
	$mday = "0".$mday
	}
	$seclen = length $sec;
	if ($seclen < 2){
	$sec = "0".$sec
	}
	$minlen = length $min;
	if ($minlen < 2){
	$min = "0".$min
	}
$curzulu = $year.$mon.$mday.$T.$hour.$min.$sec.$Z;

$ver = "1.7";  # SCRIPT VERSION NUMBER
    
    # Set Your Options:
$mail = 1;              # 1 = Yes; 0 = No
$remote_mail = 1;       # 1 = Yes; 0 = No
$allow_html = 0;        # 1 = Yes; 0 = No

    # If you answered 1 to $mail or $remote_mail you will need to fill out 
    # these variables below:
#$mailprog = 'sendmail';

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

   if ($allow_html != 1) {
      $value =~ s/<([^>]|\n)*>//g;
   }

   $FORM{$name} = $value;
  
}
  my $tz = DateTime::TimeZone->new( name => 'America/New_York' );
  my $dt = DateTime->now();  
  $dt->set_time_zone('America/New_York');
  $dt->strftime('%Y-%m-%d-%H:%M:%S %Z');
  my $now = $dt;

# if required information left out
if (!$FORM{'pid'}) {
$err = "PID";
&error;
}
if (!$FORM{'person'}) {
$err = "your name";
&error;
}
if (!$FORM{'super'}) {
$err = "Supervisor";
&error;
}
if (!$FORM{'byear'}) {
$err = "beginning year";
&error;
}
if (!$FORM{'bmonth'}) {
$err = "beginning month";
&error;
}
if (!$FORM{'bday'}) {
$err = "beginning day";
&error;
}
if (!$FORM{'bhour'}) {
$err = "beginning hour";
&error;
}
if (!$FORM{'bmin'}) {
$err = "beginning minutes";
&error;
}
if (!$FORM{'bampm'}) {
$err = "beginning AM or PM";
&error;
}
if (!$FORM{'eyear'}) {
$err = "endng year";
&error;
}
if (!$FORM{'emonth'}) {
$err = "endng month";
&error;
}
if (!$FORM{'eday'}) {
$err = "endng day";
&error;
}
if (!$FORM{'ehour'}) {
$err = "endng hour";
&error;
}
if (!$FORM{'emin'}) {
$err = "endng minutes";
&error;
}
if (!$FORM{'eampm'}) {
$err = "ending AM or PM";
&error;
}
if (!$FORM{'type'}) {
$err = "type of leave";
&error;
}
&output;



#######################
# Subroutines

#Required field not filled in
sub error {
print "Content-type: text/html\n\n";
print "<html><head><title>REQUIRED FIELD MISSING</title></head>\n";
print "<body><FONT SIZE = 5><b>Click go back button<BR>below and fill in $err\!</b></FONT><br><br>\n";
print "<button onclick='goBack()'>Go Back</button><script>function goBack() {\n";
print "window.history.back();\n";
print "}\n";
print "</script>\n";
print "<br><br>";
print "</ul></body></html>\n";
exit;
}
# Main Form Page
sub begin {
print "Content-type: text/html\n\n";
print "<html><head><title>LIFE SAFETY SYSTEMS LEAVE REQUEST $ver</title></head>\n";

print "<body><FONT SIZE = 5><b>LIFE SAFETY SYSTEMS<br>LEAVE REQUEST</b></FONT><FONT SIZE = 2 color = red>\&nbsp\;\&nbsp\;<b>$ver</b><br><br>\n";
print "* </font><i> = Required fields</i><br><br>\n";
print "<form method=POST action= $cgiurl>\n";
print "<FONT SIZE = 2 color = red>* </font>Enter Your <b>PID</b>:\&nbsp\;\&nbsp\;\n";
print "<input id=pid name=pid type=text><br><br>";
#Employee pick
print "<FONT SIZE = 2 color = red>* </font>Choose your <b>NAME</b>\:\&nbsp\;\&nbsp\;\n";
print  "<select name=person>\n";
print  "<option></option>\n";
print  "<option value='Ayers, Dwayne'>Ayers, Dwayne</option>\n";
print  "<option value='Bradley, Barry'>Bradley, Barry</option>\n";
print  "<option value='Bass, James'>Bass, James</option>\n";
print  "<option value='Bigelow, Kenesha'>Bigelow, Kenesha</option>\n";
print  "<option value='Brown, Jason'>Brown, Jason</option>\n";
print  "<option value='Brown, Wes'>Brown, Wes</option>\n";
print  "<option value='Burns, Gene'>Burns, Gene</option>\n";
print  "<option value='Chick, John'>Chick, John</option>\n";
print  "<option value='Collins, Dustin'>Collins, Dustin</option>\n";
print  "<option value='Coombs, Steven'>Coombs, Steven</option>\n";
print  "<option value='Garvey, Craig'>Garvey, Craig</option>\n";
print  "<option value='Going, Jamie Lynn'>Going, Jamie Lynne</option>\n";
print  "<option value='Gusler, Nathan'>Gusler, Nathan</option>\n";
print  "<option value='Guzi, Mike'>Guzi, Mike</option>\n";
print  "<option value='Heidinger, Jason'>Heidinger, Jason</option>\n";
print  "<option value='Hill, James'>Hill, James</option>\n";
print  "<option value='Hinshaw, Allison'>Hinshaw, Allison</option>\n";
print  "<option value='Kaim, Fevzi'>Kaim, Fevzi</option>\n";
print  "<option value='Lipscomb, Steven M'>Lipscomb, Steven M</option>\n";
print  "<option value='McLamb, Sherwood'>McLamb, Sherwood</option>\n";
print  "<option value='Messier, Curtis'>Messier, Curtis</option>\n";
print  "<option value='Miskow, Michael'>Miskow, Michael</option>\n";
print  "<option value='Morlock, Hal'>Morlock, Hal</option>\n";
print  "<option value='O\'Toole, James P'>O'Toole, James P</option>\n";
print  "<option value='Oakley, Michael'>Oakley, Michael</option>\n";
print  "<option value='Osterberg, Glenn'>Osterberg, Glenn</option>\n";
print  "<option value='Peoples, Lawrence'>Peoples, Lawrence</option>\n";
print  "<option value='Phillips, Michael'>Phillips, Michael</option>\n";
print  "<option value='Quigley, Eric'>Quigley, Eric</option>\n";
print  "<option value='Rainey, Robert'>Rainey, Robert</option>\n";
print  "<option value='Ranard, Paul'>Ranard, Paul</option>\n";
print  "<option value='Ray, Tim'>Ray, Tim</option>\n";
print  "<option value='Russell, Glenn'>Russell, Glenn</option>\n";
print  "<option value='Sharpe, David'>Sharpe, David</option>\n";
print  "<option value='Straughn, Kerry'>Straughn, Kerry</option>\n";
print  "<option value='Strickler, William'>Strickler, William</option>\n";
print  "<option value='Thacker, Daniel'>Thacker, Daniel</option>\n";
print  "<option value='Torain, Maynard'>Torain, Maynard</option>\n";
print  "<option value='Wagoner, Wadene'>Wagoner, Wadene</option>\n";
print  "<option value='Walker, Andrew'>Walker, Andrew</option>\n";
print  "<option value='White, Daylan'>White, Daylan</option>\n";
print  "</select>\n";
print  "<br><br>";
#Supervisor pick
print "<FONT SIZE = 2 color = red>* </font>Who is your <b>SUPERVISOR</b>\?\:\&nbsp\;\&nbsp\;\n";
print  "<select name=super>\n";
print  "<option></option>\n";
print  "<option value='David.Sharpe\@facilities.unc.edu'>Sharpe, David</option>\n";
#print  "<option value='dayers\@fac.unc.edu'>Ayers, Dwayne</option>\n"; # rem out line for production
print  "<option value='Todd.Going\@facilities.unc.edu'>Going, Todd</option>\n";
print  "<option value='Sherwood.McLamb\@facilities.unc.edu'>McLamb, Sherwood</option>\n";
print  "<option value='michael.d.oakley\@facilities.unc.edu'>Oakley, Michael</option>\n";
print  "<option value='john.albrechtsen\@fac.unc.edu'>Albrechtsen, John </option>\n";
print  "</select>\n";
print  "<br><br>";
print "Enter <b>YOUR EMAIL</b> for a copy <br>and quick calendar entry file:\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;";
print "<input id=email name=email type=text><br><br>";

# code for choosing beginning day and time
print "<FONT SIZE = 2 color = red>* </font>Choose <b>BEGINNING</b> Day and Hour";
print "<br><br>";

print "<label for=\"byear\">Year</label>\&nbsp\;\&nbsp\;<select name=byear>\n";
$byear = 2018;
print  "<option></option>\n";
while($byear < 2025){
$byear += 1;
print  "<option value=$byear>$byear</option>\n";
}
print "</select>\&nbsp\;\&nbsp\;";

print "<label for=\"bmonth\">Month</label>\&nbsp\;\&nbsp\;<select name=bmonth>\n";
$bmonth = 0;
print  "<option></option>\n";
while($bmonth < 12){
$bmonth += 1;
  if (length($bmonth) < 2) {
  $bmonth = "0".$bmonth;
  }
print  "<option value=$bmonth>$bmonth</option>\n";
}
print "</select>\&nbsp\;\&nbsp\;";

print "<label for=\"bday\">Day</label>\&nbsp\;\&nbsp\;<select name=bday>\n";
$bday = 0;
print  "<option></option>\n";
while($bday < 31){
$bday += 1;
  if (length($bday) < 2) {
  $bday = "0".$bday;
  }
print  "<option value=$bday>$bday</option>\n";
}
print "</select>\&nbsp\;\&nbsp\;";

print "<br><br>";

print "<label for=\"bhour\">Hour</label>\&nbsp\;\&nbsp\;<select name=bhour>\n";
$bhour = 0;
print  "<option></option>\n";
while($bhour < 12){
$bhour += 1;
  if (length($bhour) < 2) {
  $bhour = "0".$bhour;
  }
print  "<option value=$bhour>$bhour</option>\n";
}
print "</select>\&nbsp\;\&nbsp\;";

print "<label for=\"bmin\">Minutes</label>\&nbsp\;\&nbsp\;<select name=bmin>\n";
$bmin = 0;
print  "<option>00</option>\n";
while($bmin < 59){
$bmin += 1;
  if (length($bmin) < 2) {
  $bmin = "0".$bmin;
  }
print  "<option value=$bmin>$bmin</option>\n";
}
print "</select>\&nbsp\;\&nbsp\;";

print  "<label for=\"bampm\">AM/PM</label>\&nbsp\;\&nbsp\;<select name=bampm>\n";
print  "<option></option>\n";
print  "<option value='AM'>AM</option>\n";
print  "<option value='PM'>PM</option>\n";
print "</select>";
print "<br><br><br>";
# code for choosing ending day and time
print "<FONT SIZE = 2 color = red>* </font>Choose <b>ENDING</b> Day and Hour";
print "<br><br>";

print "<label for=\"eyear\">Year</label>\&nbsp\;\&nbsp\;<select name=eyear>\n";
$eyear = 2018;
print  "<option></option>\n";
while($eyear < 2025){
$eyear += 1;
print  "<option value=$eyear>$eyear</option>\n";
}
print "</select>\&nbsp\;\&nbsp\;";

print "<label for=\"emonth\">Month</label>\&nbsp\;\&nbsp\;<select name=emonth>\n";
$emonth = 0;
print  "<option></option>\n";
while($emonth < 12){
$emonth += 1;
  if (length($emonth) < 2) {
  $emonth = "0".$emonth;
  }
print  "<option value=$emonth>$emonth</option>\n";
}
print "</select>\&nbsp\;\&nbsp\;";

print "<label for=\"eday\">Day</label>\&nbsp\;\&nbsp\;<select name=eday>\n";
$eday = 0;
print  "<option></option>\n";
while($eday < 31){
$eday += 1;
  if (length($eday) < 2) {
  $eday = "0".$eday;
  }
print  "<option value=$eday>$eday</option>\n";
}
print "</select>\&nbsp\;\&nbsp\;";

print "<br><br>";

print "<label for=\"ehour\">Hour</label>\&nbsp\;\&nbsp\;<select name=ehour>\n";
$ehour = 0;
print  "<option></option>\n";
while($ehour < 12){
$ehour += 1;
  if (length($ehour) < 2) {
  $ehour = "0".$ehour;
  }
print  "<option value=$ehour>$ehour</option>\n";
}
print "</select>\&nbsp\;\&nbsp\;";

print "<label for=\"emin\">Minutes</label>\&nbsp\;\&nbsp\;<select name=emin>\n";
$emin = 0;
print  "<option>00</option>\n";
while($emin < 59){
$emin += 1;
  if (length($emin) < 2) {
  $emin = "0".$emin;
  }
print  "<option value=$emin>$emin</option>\n";
}
print "</select>\&nbsp\;\&nbsp\;";
print  "<label for=\"eampm\">AM/PM</label>\&nbsp\;\&nbsp\;<select name=eampm>\n";
print  "<option></option>\n";
print  "<option value='AM'>AM</option>\n";
print  "<option value='PM'>PM</option>\n";
print "</select>";
print "<br><br><br>";
print "<FONT SIZE = 2 color = red>* </font>Choose <b>TYPE OF LEAVE</b>:<br>";
print  "<select name=type>\n";
print  "<option></option>\n";
print  "<option value='Vacation'>Vacation</option>\n";
print  "<option value='Sick'>Sick</option>\n";
print  "<option value='Bonus 2017'>Bonus 2017</option>\n";
print  "<option value='Bonus 2018'>Bonus 2018</option>\n";
print  "<option value='Bonus'>Bonus</option>\n";
print  "<option value='Civil'>Civil</option>\n";
print  "<option value='Military'>Military</option>\n";
print  "<option value='Dock in Pay(Absent without leave)'>Dock in Pay(Absent without leave)</option>\n";
print  "<option value='Community Service'>Community Service</option>\n";
print  "<option value='Recognition Time'>Recognition Time</option>\n";
print  "<option value='Adverse weather ETO'>Adverse weather ETO</option>\n";
print  "<option value='Holiday ETO'>Holiday ETO</option>\n";
print  "<option value='Awarded PTO'>Awarded PTO</option>\n";
print  "<option value='Comp Time'>Comp Time</option>\n";
print  "<option value='Travel Time off'>Travel Time off</option>\n";
print  "<option value='On-Call Time Off'>On-Call Time Off</option>\n";
print  "<option value='CD Advanced'>CD Advanced</option>\n";
print  "</select>\n";
print "<br><br>";
print "Enter <b>COMMENTS</b>:<br>";
print "<textarea name=coms cols=30 rows=5></textarea><br><br>";
print "<input type=submit> * <input type=reset><br><br>\n";
print "</form>";
print "<table style=width:35%>";
print "<tr>";
print "<td><b><i>Minutes Converted to Tenths/Hr.</i></td>";
print "</tr>";
print "<table style=width:25%>";
print "<tr>";
print "<td>\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;4-9\&nbsp\;\&nbsp\; = </td>";
print "<td>.1\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;</td>";
print "<td>34-39\&nbsp\;\&nbsp\; = </td>";
print "<td>.6\&nbsp\;\&nbsp\;</td>";
print "</tr>";
print "<tr>";
print "<td>10-15\&nbsp\;\&nbsp\; = </td>";
print "<td>.2\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;</td>";
print "<td>40-45\&nbsp\;\&nbsp\; = </td>";
print "<td>.7\&nbsp\;\&nbsp\;</td>";
print "</tr>";
print "<tr>";
print "<td>16-21\&nbsp\;\&nbsp\; = </td>";
print "<td>.3\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;</td>";
print "<td>46-51\&nbsp\;\&nbsp\; = </td>";
print "<td>.8\&nbsp\;\&nbsp\;</td>";
print "</tr>";
print "<tr>";
print "<td>22-27\&nbsp\;\&nbsp\; = </td>";
print "<td>.4\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;</td>";
print "<td>52-57\&nbsp\;\&nbsp\; = </td>";
print "<td>.9\&nbsp\;\&nbsp\;</td>";
print "</tr>";
print "<tr>";
print "<td>28-33\&nbsp\;\&nbsp\; = </td>";
print "<td>.5\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;</td>";
print "<td>58-60\&nbsp\;\&nbsp\; = </td>";
print "<td>1.0\&nbsp\;\&nbsp\;</td>";
print "</tr>";
print "</table>";
print "<br><br>";
print "</ul></body></html>\n";
exit;
}

sub output {
$sbtime = $FORM{'byear'}."-".$FORM{'bmonth'}."-".$FORM{'bday'}."T".$FORM{'bhour'}.$FORM{'bmin'}.$FORM{'bampm'};
$setime = $FORM{'eyear'}."-".$FORM{'emonth'}."-".$FORM{'eday'}."T".$FORM{'ehour'}.$FORM{'emin'}.$FORM{'eampm'};
$emailbtime = $sbtime;
$emailetime = $setime;
$emailbtime =~ s/T/ /;
$emailetime =~ s/T/ /;
print "Content-type: text/html\n\n";
print "<html><head><title>LIFE SAFETY SYSTEMS LEAVE REQUEST OUTPUT</title></head>\n";
print "<body><FONT SIZE = 5><b>LIFE SAFETY SYSTEMS<br>LEAVE REQUEST OUTPUT</b></FONT><FONT SIZE = 2 color = red>\&nbsp\;\&nbsp\;<b>$ver</b></font><br><br>\n";
print "$now<br><br>";
print "<b>PID:</b> $FORM{'pid'}<br><br>";
print "<b>NAME:</b> $FORM{'person'}<br><br>";
print "<b>SUPERVISOR'S EMAIL:</b> $FORM{'super'}<br><br>";
print "<b>EMAIL:</b> $FORM{'email'}<br><br>";
print "<b>BEGIN:</b> $emailbtime<br><br>";
print "<b>END:</b> $emailetime<br><br>";
print "<b>TYPE:</b> $FORM{'type'}<br><br>";
print "<b>COMMENTS:</b> $FORM{'coms'}<br><br>";
if ($sbtime =~ /-/){
$sbtime =~ s/-//g;
$setime =~ s/-//g;
}
   if ($sbtime =~ /P/){
   $sbtime =~ s/PM//;
   $et = $sbtime =~ /T/;   
   $et = $';
	  if ($et < 1200) {
	  $et = $et + 1200;
	  } 
 $sbtime =~ s/T.*//;	
 $sbtime = $sbtime."T".$et;
	}
   if ($setime =~ /P/){
       $setime =~ s/PM//;
       $et = $setime =~ /T/;   
       $et = $';
	      if ($et < 1200) {
		      $et = $et + 1200;
		  } 
       $setime =~ s/T.*//;	
       $setime = $setime."T".$et;	   
   }
   if ($sbtime =~ /A/){
       $sbtime =~ s/AM//;
       $et = $sbtime =~ /T/;   
       $et = $';
	      if ($et >= 1200) {
		      $et = $et - 1200;
			  $et = "00".$et;
		  } 
       $sbtime =~ s/T.*//;	
       $sbtime = $sbtime."T".$et;
	   }

   if ($setime =~ /A/){
       $setime =~ s/AM//;
	   $et = $setime =~ /T/;   
       $et = $';
	      if ($et >= 1200) {
		      $et = $et - 1200;
			  $et = "00".$et;
		  } 
       $setime =~ s/T.*//;	
       $setime = $setime."T".$et;
	   }

 # figure the hours taken
#$btime = $sbtime =~ /T/;   
#$btime = $';
#$etime = $setime =~ /T/;   
#$etime = $';
#$toff = $etime - $btime;
#if ($toff gt 400) {
#$toff = ($toff - 30);
#}
#if ($toff lt 1000) {
#$hrs = substr $toff, 0, 1;
#$toff =~ s/$hrs/$hrs./;
#}
#if ($toff lt 10000) {
#$hrs = substr $toff, 0, 2;
#$toff =~ s/$hrs/$hrs./;
#}

open TMP, ">$tmptxt";
print TMP "$now\n";
print TMP "$FORM{'pid'}\n";
print TMP "$FORM{'person'}\n";
print TMP "$FORM{'super'}\n";
print TMP "$FORM{'email'}\n";
print TMP "$emailbtime\n";
print TMP "$emailetime\n";
print TMP "$FORM{'type'}\n";
print TMP "$FORM{'coms'}\n";

# print TMP "$setime\n"; # for testing

close TMP;
$sbtime = $sbtime."00";
$setime = $setime."00";
open ATA, ">$ata";
print ATA "BEGIN:VCALENDAR\n";
print ATA "BEGIN:VEVENT\n";
print ATA "UID:$FORM{'pid'}"."$curzulu\n";
print ATA "DTSTAMP:$curzulu\n";
print ATA "DTSTART;TZID=/US/Eastern:$sbtime\n";
print ATA "DTEND;TZID=/US/Eastern:$setime\n";
print ATA "X-MICROSOFT-CDO-BUSYSTATUS:OOF\n";
print ATA "SUMMARY:$FORM{'person'} - $FORM{'type'}\n";
#print ATA "DESCRIPTION:$FORM{'coms'}\n";
print ATA "END:VEVENT\n";
print ATA "END:VCALENDAR\n";
close ATA;
#print "<b>HOURS:</b> $toff<br><br>";
print "------------------------------------------------------<br><br>";
print "<li><a href=$cgiurl>Not Correct Start Over</a><br><br>\n";
print "<li><a href=$sendmurl>Send to Supervisor</a>";
print "</body></html>\n";
exit;
}
