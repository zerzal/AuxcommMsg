#!/afs/isis/pkg/perl/bin/perl

#AUXCOMM MESSAGING FOR PAT WINLINK SERVER - see $ver below

 use strict;
 use warning;
 use DateTime::TimeZone;
 use DateTime;

# Set Variables
#######################

my $cgiurl = "index.pl";  

my $tmptxt = "tempinfo.txt"; 

&213;


sub 213 {
print "Content-type: text/html\n\n";
print "<!DOCTYPE  html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">
<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\" lang=\"en\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/><title>ICS Form 213, General Message</title><meta name=\"author\" content=\"FEMA\"/><style type=\"text/css\"> * {margin:0; padding:0; text-indent:0; }
 h1 { color: black; font-family:Arial, sans-serif; font-style: normal; font-weight: bold; text-decoration: none; font-size: 14pt; }
 .s1 { color: black; font-family:Arial, sans-serif; font-style: normal; font-weight: bold; text-decoration: none; font-size: 10pt; }
 .s2 { color: black; font-family:Arial, sans-serif; font-style: normal; font-weight: normal; text-decoration: none; font-size: 10pt; }
 h2 { color: black; font-family:Arial, sans-serif; font-style: normal; font-weight: bold; text-decoration: none; font-size: 12pt; }
 h3 { color: black; font-family:Arial, sans-serif; font-style: normal; font-weight: bold; text-decoration: none; font-size: 10pt; }
 .p, p { color: black; font-family:Arial, sans-serif; font-style: normal; font-weight: normal; text-decoration: none; font-size: 10pt; margin:0pt; }
 .s4 { color: #FFF; font-family:Arial, sans-serif; font-style: normal; font-weight: bold; text-decoration: none; font-size: 10pt; }
 li {display: block; }
 #l1 {padding-left: 0pt; }
 #l1> li:before {content: \" \"; color: black; font-family:Symbol, serif; font-style: normal; font-weight: normal; text-decoration: none; font-size: 10pt; }
 li {display: block; }
 #l2 {padding-left: 0pt; }
 #l2> li:before {content: \" \"; color: black; font-family:Symbol, serif; font-style: normal; font-weight: normal; text-decoration: none; font-size: 10pt; }
 li {display: block; }
 #l3 {padding-left: 0pt; }
 #l3> li:before {content: \" \"; color: black; font-family:Symbol, serif; font-style: normal; font-weight: normal; text-decoration: none; font-size: 10pt; }
 table, tbody {vertical-align: top; overflow: visible; }
</style></head><body><h1 style=\"padding-top: 1pt;padding-left: 171pt;text-indent: 0pt;text-align: left;\">GENERAL MESSAGE (ICS 213)</h1><p style=\"text-indent: 0pt;text-align: left;\"><br/></p><table style=\"border-collapse:collapse;margin-left:4.23pt\" cellspacing=\"0\"><tr style=\"height:18pt\"><td style=\"width:540pt;border-top-style:solid;border-top-width:2pt;border-left-style:solid;border-left-width:2pt;border-bottom-style:solid;border-bottom-width:2pt;border-right-style:solid;border-right-width:2pt\" colspan=\"3\"><p class=\"s1\" style=\"padding-top: 1pt;padding-left: 4pt;text-indent: 0pt;text-align: left;\">1. Incident Name <span class=\"s2\">(Optional)</span>:</p></td></tr><tr style=\"height:31pt\"><td style=\"width:540pt;border-top-style:solid;border-top-width:2pt;border-left-style:solid;border-left-width:2pt;border-bottom-style:solid;border-bottom-width:2pt;border-right-style:solid;border-right-width:2pt\" colspan=\"3\"><p class=\"s1\" style=\"padding-left: 4pt;text-indent: 0pt;text-align: left;\">2. To <span class=\"s2\">(Name and Position)</span>:</p></td></tr><tr style=\"height:31pt\"><td style=\"width:540pt;border-top-style:solid;border-top-width:2pt;border-left-style:solid;border-left-width:2pt;border-bottom-style:solid;border-bottom-width:2pt;border-right-style:solid;border-right-width:2pt\" colspan=\"3\"><p class=\"s1\" style=\"padding-left: 4pt;text-indent: 0pt;text-align: left;\">3. From <span class=\"s2\">(Name and Position)</span>:</p></td></tr><tr style=\"height:31pt\"><td style=\"width:396pt;border-top-style:solid;border-top-width:2pt;border-left-style:solid;border-left-width:2pt;border-bottom-style:solid;border-bottom-width:2pt;border-right-style:solid;border-right-width:2pt\"><p class=\"s1\" style=\"padding-left: 4pt;text-indent: 0pt;text-align: left;\">4. Subject:</p></td><td style=\"width:72pt;border-top-style:solid;border-top-width:2pt;border-left-style:solid;border-left-width:2pt;border-bottom-style:solid;border-bottom-width:2pt;border-right-style:solid;border-right-width:2pt\"><p class=\"s1\" style=\"padding-left: 4pt;text-indent: 0pt;text-align: left;\">5. Date:</p></td><td style=\"width:72pt;border-top-style:solid;border-top-width:2pt;border-left-style:solid;border-left-width:2pt;border-bottom-style:solid;border-bottom-width:2pt;border-right-style:solid;border-right-width:2pt\"><p class=\"s1\" style=\"padding-left: 4pt;text-indent: 0pt;text-align: left;\">6. Time</p></td></tr><tr style=\"height:263pt\"><td style=\"width:540pt;border-top-style:solid;border-top-width:2pt;border-left-style:solid;border-left-width:2pt;border-bottom-style:solid;border-bottom-width:2pt;border-right-style:solid;border-right-width:2pt\" colspan=\"3\"><p class=\"s1\" style=\"padding-top: 1pt;padding-left: 4pt;text-indent: 0pt;text-align: left;\">7. Message:</p></td></tr><tr style=\"height:20pt\"><td style=\"width:540pt;border-top-style:solid;border-top-width:2pt;border-left-style:solid;border-left-width:2pt;border-bottom-style:solid;border-bottom-width:2pt;border-right-style:solid;border-right-width:2pt\" colspan=\"3\"><p class=\"s2\" style=\"padding-top: 2pt;padding-left: 4pt;text-indent: 0pt;text-align: left;\"><b>8. Approved by: </b>Name:                                     Signature:                                       Position/Title:  <u>                                 </u></p></td></tr><tr style=\"height:257pt\"><td style=\"width:540pt;border-top-style:solid;border-top-width:2pt;border-left-style:solid;border-left-width:2pt;border-bottom-style:solid;border-bottom-width:2pt;border-right-style:solid;border-right-width:2pt\" colspan=\"3\"><p class=\"s1\" style=\"padding-top: 1pt;padding-left: 4pt;text-indent: 0pt;text-align: left;\">9. Reply:</p></td></tr><tr style=\"height:20pt\"><td style=\"width:540pt;border-top-style:solid;border-top-width:2pt;border-left-style:solid;border-left-width:2pt;border-right-style:solid;border-right-width:2pt\" colspan=\"3\"><p class=\"s2\" style=\"padding-top: 2pt;padding-left: 4pt;text-indent: 0pt;text-align: left;\"><b>10. Replied by:  </b>Name:                                      Position/Title:                                      Signature:  <u>                                   </u></p></td></tr><tr style=\"height:16pt\"><td style=\"width:216pt;border-top-style:solid;border-top-width:2pt;border-left-style:solid;border-left-width:2pt;border-bottom-style:solid;border-bottom-width:2pt;border-right-style:solid;border-right-width:2pt\"><p class=\"s1\" style=\"padding-top: 1pt;padding-left: 4pt;text-indent: 0pt;text-align: left;\">ICS 213</p></td><td style=\"width:324pt;border-left-style:solid;border-left-width:2pt;border-bottom-style:solid;border-bottom-width:2pt;border-right-style:solid;border-right-width:2pt\" colspan=\"2\"><p class=\"s2\" style=\"padding-top: 2pt;padding-left: 4pt;text-indent: 0pt;text-align: left;\">Date/Time:  <u>                                                                                             </u></p></td></tr></table><h2 style=\"padding-top: 2pt;padding-left: 5pt;text-indent: 0pt;text-align: left;\">ICS 213</h2><h2 style=\"padding-left: 5pt;text-indent: 0pt;text-align: left;\">General Message</h2><p style=\"text-indent: 0pt;text-align: left;\"><br/></p><h3 style=\"padding-left: 5pt;text-indent: 0pt;text-align: left;\">Purpose. <span class=\"p\">The General Message (ICS 213) is used by the incident dispatchers to record incoming messages that cannot be orally transmitted to the intended recipients. The ICS 213 is also used by the Incident Command Post and other incident personnel to transmit messages (e.g., resource order, incident name change, other ICS coordination issues, etc.) to the Incident Communications Center for transmission via radio or telephone to the addressee. This form is used to send any message or notification to incident personnel that requires hard-copy delivery.</span></h3><p style=\"text-indent: 0pt;text-align: left;\"><br/></p><h3 style=\"padding-left: 5pt;text-indent: 0pt;text-align: left;\">Preparation. <span class=\"p\">The ICS 213 may be initiated by incident dispatchers and any other personnel on an incident.</span></h3><p style=\"text-indent: 0pt;text-align: left;\"><br/></p><h3 style=\"padding-left: 5pt;text-indent: 0pt;text-align: left;\">Distribution. <span class=\"p\">Upon completion, the ICS 213 may be delivered to the addressee and/or delivered to the Incident Communication Center for transmission.</span></h3><p style=\"text-indent: 0pt;text-align: left;\"><br/></p><h3 style=\"padding-left: 5pt;text-indent: 0pt;text-align: left;\">Notes:</h3><ul id=\"l1\"><li style=\"padding-top: 3pt;padding-left: 19pt;text-indent: -14pt;line-height: 11pt;text-align: left;\"><p style=\"display: inline;\">The ICS 213 is a three-part form, typically using carbon paper. The sender will complete Part 1 of the form and send Parts 2 and 3 to the recipient. The recipient will complete Part 2 and return Part 3 to the sender.</p></li><li style=\"padding-top: 3pt;padding-left: 19pt;text-indent: -14pt;text-align: left;\"><p style=\"display: inline;\">A copy of the ICS 213 should be sent to and maintained within the Documentation Unit.</p></li><li style=\"padding-top: 3pt;padding-left: 19pt;text-indent: -14pt;text-align: left;\"><p style=\"display: inline;\">Contact information for the sender and receiver can be added for communications purposes to confirm resource orders. Refer to 213RR example (Appendix B)</p></li></ul><p style=\"text-indent: 0pt;text-align: left;\"><br/></p><table style=\"border-collapse:collapse;margin-left:4.23pt\" cellspacing=\"0\"><tr style=\"height:29pt\"><td style=\"width:57pt;border-top-style:solid;border-top-width:2pt;border-left-style:solid;border-left-width:2pt;border-bottom-style:solid;border-bottom-width:2pt;border-right-style:solid;border-right-width:2pt\" bgcolor=\"#666666\"><p class=\"s4\" style=\"padding-top: 1pt;padding-left: 8pt;padding-right: 8pt;text-indent: 5pt;text-align: left;\">Block Number</p></td><td style=\"width:152pt;border-top-style:solid;border-top-width:2pt;border-left-style:solid;border-left-width:2pt;border-bottom-style:solid;border-bottom-width:2pt;border-right-style:solid;border-right-width:2pt\" bgcolor=\"#666666\"><p class=\"s4\" style=\"padding-top: 7pt;padding-left: 4pt;text-indent: 0pt;text-align: left;\">Block Title</p></td><td style=\"width:331pt;border-top-style:solid;border-top-width:2pt;border-left-style:solid;border-left-width:2pt;border-bottom-style:solid;border-bottom-width:2pt;border-right-style:solid;border-right-width:2pt\" bgcolor=\"#666666\"><p class=\"s4\" style=\"padding-top: 7pt;padding-left: 4pt;text-indent: 0pt;text-align: left;\">Instructions</p></td></tr><tr style=\"height:17pt\"><td style=\"width:57pt;border-top-style:solid;border-top-width:2pt;border-left-style:solid;border-left-width:2pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt\"><p class=\"s1\" style=\"padding-top: 1pt;text-indent: 0pt;text-align: center;\">1</p></td><td style=\"width:152pt;border-top-style:solid;border-top-width:2pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt\"><p class=\"s1\" style=\"padding-top: 1pt;padding-left: 5pt;text-indent: 0pt;text-align: left;\">Incident Name <span class=\"s2\">(Optional)</span></p></td><td style=\"width:331pt;border-top-style:solid;border-top-width:2pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:2pt\"><p class=\"s2\" style=\"padding-top: 1pt;padding-left: 5pt;text-indent: 0pt;text-align: left;\">Enter the name assigned to the incident. This block is optional.</p></td></tr><tr style=\"height:39pt\"><td style=\"width:57pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:2pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt\"><p class=\"s1\" style=\"padding-top: 1pt;text-indent: 0pt;text-align: center;\">2</p></td><td style=\"width:152pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt\"><p class=\"s1\" style=\"padding-top: 1pt;padding-left: 5pt;text-indent: 0pt;text-align: left;\">To <span class=\"s2\">(Name and Position)</span></p></td><td style=\"width:331pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:2pt\"><p class=\"s2\" style=\"padding-top: 1pt;padding-left: 5pt;padding-right: 12pt;text-indent: 0pt;text-align: left;\">Enter the name and position the General Message is intended for. For all individuals, use at least the first initial and last name. For Unified Command, include agency names.</p></td></tr><tr style=\"height:40pt\"><td style=\"width:57pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:2pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt\"><p class=\"s1\" style=\"padding-top: 1pt;text-indent: 0pt;text-align: center;\">3</p></td><td style=\"width:152pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt\"><p class=\"s1\" style=\"padding-top: 1pt;padding-left: 5pt;text-indent: 0pt;text-align: left;\">From <span class=\"s2\">(Name and Position)</span></p></td><td style=\"width:331pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:2pt\"><p class=\"s2\" style=\"padding-top: 1pt;padding-left: 5pt;padding-right: 12pt;text-indent: 0pt;text-align: left;\">Enter the name and position of the individual sending the General Message. For all individuals, use at least the first initial and last name. For Unified Command, include agency names.</p></td></tr><tr style=\"height:16pt\"><td style=\"width:57pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:2pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt\"><p class=\"s1\" style=\"padding-top: 1pt;text-indent: 0pt;text-align: center;\">4</p></td><td style=\"width:152pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt\"><p class=\"s1\" style=\"padding-top: 1pt;padding-left: 5pt;text-indent: 0pt;text-align: left;\">Subject</p></td><td style=\"width:331pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:2pt\"><p class=\"s2\" style=\"padding-top: 1pt;padding-left: 5pt;text-indent: 0pt;text-align: left;\">Enter the subject of the message.</p></td></tr><tr style=\"height:17pt\"><td style=\"width:57pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:2pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt\"><p class=\"s1\" style=\"padding-top: 1pt;text-indent: 0pt;text-align: center;\">5</p></td><td style=\"width:152pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt\"><p class=\"s1\" style=\"padding-top: 1pt;padding-left: 5pt;text-indent: 0pt;text-align: left;\">Date</p></td><td style=\"width:331pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:2pt\"><p class=\"s2\" style=\"padding-top: 1pt;padding-left: 5pt;text-indent: 0pt;text-align: left;\">Enter the date (month/day/year) of the message.</p></td></tr><tr style=\"height:16pt\"><td style=\"width:57pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:2pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt\"><p class=\"s1\" style=\"padding-top: 1pt;text-indent: 0pt;text-align: center;\">6</p></td><td style=\"width:152pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt\"><p class=\"s1\" style=\"padding-top: 1pt;padding-left: 5pt;text-indent: 0pt;text-align: left;\">Time</p></td><td style=\"width:331pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:2pt\"><p class=\"s2\" style=\"padding-top: 1pt;padding-left: 5pt;text-indent: 0pt;text-align: left;\">Enter the time (using the 24-hour clock) of the message.</p></td></tr><tr style=\"height:16pt\"><td style=\"width:57pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:2pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt\"><p class=\"s1\" style=\"padding-top: 1pt;text-indent: 0pt;text-align: center;\">7</p></td><td style=\"width:152pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt\"><p class=\"s1\" style=\"padding-top: 1pt;padding-left: 5pt;text-indent: 0pt;text-align: left;\">Message</p></td><td style=\"width:331pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:2pt\"><p class=\"s2\" style=\"padding-top: 1pt;padding-left: 5pt;text-indent: 0pt;text-align: left;\">Enter the content of the message. Try to be as concise as possible.</p></td></tr><tr style=\"height:58pt\"><td style=\"width:57pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:2pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt\"><p class=\"s1\" style=\"padding-top: 1pt;text-indent: 0pt;text-align: center;\">8</p></td><td style=\"width:152pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt\"><p class=\"s1\" style=\"padding-top: 1pt;padding-left: 5pt;text-indent: 0pt;text-align: left;\">Approved by</p><ul id=\"l2\"><li style=\"padding-top: 2pt;padding-left: 19pt;text-indent: -14pt;text-align: left;\"><p class=\"s2\" style=\"display: inline;\">Name</p></li><li style=\"padding-top: 1pt;padding-left: 19pt;text-indent: -14pt;text-align: left;\"><p class=\"s2\" style=\"display: inline;\">Signature</p></li><li style=\"padding-top: 1pt;padding-left: 19pt;text-indent: -14pt;text-align: left;\"><p class=\"s2\" style=\"display: inline;\">Position/Title</p></li></ul></td><td style=\"width:331pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:2pt\"><p class=\"s2\" style=\"padding-top: 1pt;padding-left: 5pt;padding-right: 50pt;text-indent: 0pt;text-align: left;\">Enter the name, signature, and ICS position/title of the person approving the message.</p></td></tr><tr style=\"height:28pt\"><td style=\"width:57pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:2pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt\"><p class=\"s1\" style=\"padding-top: 1pt;text-indent: 0pt;text-align: center;\">9</p></td><td style=\"width:152pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:1pt\"><p class=\"s1\" style=\"padding-top: 1pt;padding-left: 5pt;text-indent: 0pt;text-align: left;\">Reply</p></td><td style=\"width:331pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:1pt;border-right-style:solid;border-right-width:2pt\"><p class=\"s2\" style=\"padding-top: 1pt;padding-left: 5pt;padding-right: 12pt;text-indent: 0pt;text-align: left;\">The intended recipient will enter a reply to the message and return it to the originator.</p></td></tr><tr style=\"height:74pt\"><td style=\"width:57pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:2pt;border-bottom-style:solid;border-bottom-width:2pt;border-right-style:solid;border-right-width:1pt\"><p class=\"s1\" style=\"padding-top: 1pt;text-indent: 0pt;text-align: center;\">10</p></td><td style=\"width:152pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:2pt;border-right-style:solid;border-right-width:1pt\"><p class=\"s1\" style=\"padding-top: 1pt;padding-left: 5pt;text-indent: 0pt;text-align: left;\">Replied by</p><ul id=\"l3\"><li style=\"padding-top: 2pt;padding-left: 19pt;text-indent: -14pt;text-align: left;\"><p class=\"s2\" style=\"display: inline;\">Name</p></li><li style=\"padding-top: 2pt;padding-left: 19pt;text-indent: -14pt;text-align: left;\"><p class=\"s2\" style=\"display: inline;\">Position/Title</p></li><li style=\"padding-top: 1pt;padding-left: 19pt;text-indent: -14pt;text-align: left;\"><p class=\"s2\" style=\"display: inline;\">Signature</p></li><li style=\"padding-top: 1pt;padding-left: 19pt;text-indent: -14pt;text-align: left;\"><p class=\"s2\" style=\"display: inline;\">Date/Time</p></li></ul></td><td style=\"width:331pt;border-top-style:solid;border-top-width:1pt;border-left-style:solid;border-left-width:1pt;border-bottom-style:solid;border-bottom-width:2pt;border-right-style:solid;border-right-width:2pt\"><p class=\"s2\" style=\"padding-top: 1pt;padding-left: 5pt;padding-right: 13pt;text-indent: 0pt;text-align: left;\">Enter the name, ICS position/title, and signature of the person replying to the message. Enter date (month/day/year) and time prepared (24- hour clock).</p></td></tr></table></body></html>\n";

}
exit;
