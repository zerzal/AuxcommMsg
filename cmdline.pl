#!/usr/bin/perl
#AUXCOMM MESSAGING FOR PAT WINLINK SERVER - see $ver below

use strict;
use warnings;

my $cmd = "pat compose";
#my $cmd = "cd c:/Pat";

#my $cmd0 = "";
#print {$cmd} "command2\n";

system($cmd);
#system 1, $cmd;
#system 2, @cmd;
#system 1, $cmd0;
