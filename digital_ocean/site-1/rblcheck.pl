#!/usr/bin/perl

# Multi-process rsp. multi-threaded version of rblcheck

$Version='perl rblcheck 0.1.4a for -t';
$Copyright='Copyright (C) 2003 Hatto von Hatzfeld';

# Need help? Just start this script with Option -h

# Don't forget to check the CONFIGURATION sector below.

# Compared with rblcheck written by Edward S. Marshall
# you'll find advantages and disadvantages of this perl
# version of rblcheck. Like rblcheck this script returns
# 1 if at there was any match, otherwise 0 (255 in case
# of syntax errors).

# Advantages:
# - needs much less time to check a high number of RBLs
# - you may indicate a time out (option -o) after which
#   all checks are stopped (no effect when run under
#   Windows with just one IP)
# - is able to filter mail header: "| rblcheck.pl -mq -"
#   (e.g. for procmail)

# Disadvantages:
# - NOT TESTED UNDER WINDOWS
# - it needs a perl interpreter (maybe you have to change the 
#   first line to fit to your system)
# - output is not sorted the same way

# The script will return 1 if any IP matched with any of
# the RBLs.

# The script has been tested on Linux SuSE 6.2. and works well.

# An older version has been tested under Windows 98 with ActivePerl 5.6.1.633
# (Perl Version 5.006001), and it works, but not well...
# (available from http://www.ActiveState.com/ActivePerl).

# The script comes "as it is" without any warranty

# You may send improvements and questions to hatto@salesianer.de

# CHANGES
# 2003-06-27  0.1.4a Bug relating to RfC 1918 fixed
# 2003-02-13  0.1.4 Getting and showing TXT records
# 2002-08-02  0.1.3 Added ability to filter whole mail headers
#                   Don't check private address space (RfC 1918)
# 2002-07-30  0.1.2 First published version

# TODO
# - successfully test it under Windows


# CONFIGURATION

$TimeOutDefault=10; # Default time out (seconds)

$sleepseconds=0; # Set this to 1 if you experience crashes under Windows
                 # especially when checking a high number of RBLs

# RBL Services
# uncomment or comment out services according to your needs!
# Note: In some environments you will get problems if you 
# activate too many services (especially under Windows)

@rbls=(
# "3y.spam.mrs.kithrup.com",
# "bl.redhatgate.com",
"bl.spamcop.net",
# "blackhole.compu.net",
"blackhole.securitysage.com",
# "blackholes.2mbit.com",
"blackholes.five-ten-sg.com",
# "blackholes.intersil.net",
# "blackholes.mail-abuse.org",
# "blackholes.wirehub.net",
# "blacklist.spambag.org",
"block.blars.org",
# "cbl.abuseat.org", # incorporated by xbl.spamhaus.org
# "dev.null.dk",
# "dews.qmail.org",
# "dialup.blacklist.jippg.org",
# "dialups.mail-abuse.org",
"dnsbl.ahbl.org",
"dnsbl.njabl.org",
"dnsbl.sorbs.net",
# "dssl.imrss.org",
# "dul.dnsbl.sorbs.net",
# "dul.maps.vix.com",
# "dul.orca.bc.ca",
# "dynablock.wirehub.net",
# "flowgoaway.com",
# "http.opm.blitzed.org",
# "inputs.orbz.org",
"ipwhois.rfc-ignorant.org",
"korea.services.net",
# "KR.rbl.cluecentral.net",
"list.dsbl.org",
# "manual.orbz.gst-group.co.uk",
# "mr-out.imrss.org",
"multihop.dsbl.org",
"opm.blitzed.org",
# "or.orbl.org",
"orbs.dorkslayers.com",
# "orbz.gst-group.co.uk",
# "outputs.orbz.org",
# "pm0-no-more.compu.net",
"psbl.surriel.com",
# "rbl-plus.mail-abuse.org",
# "rbl.maps.vix.com",
# "rbl.spam.org.tr",
# "relayips.rbl.shub-inter.net",
"relays.bl.kundenserver.de", # public use restricted, see http://relaytest.kundenserver.de/faq/admin/6.html
"relays.dorkslayers.com",
# "relays.mail-abuse.org",
"relays.ordb.org",
# "relays.radparker.com",
"relays.visi.com",
"sbl.spamhaus.org",
# "sbl-xbl.spamhaus.org", # combination of sbl.spamhaus.org and xbl.spamhaus.org
# "socks.opm.blitzed.org",
# "spamguard.leadmon.net",
# "spamips.rbl.shub-inter.net",
# "spammers.v6net.org",
# "spamsources.fabel.dk",
# "l2.spews.dnsbl.sorbs.net",
"l1.spews.dnsbl.sorbs.net",
"t1.bl.reynolds.net.au",
"unconfirmed.dsbl.org",
# "wingate.opm.blitzed.org",
"xbl.selwerd.cx",
"xbl.spamhaus.org", # incorporates cbl.abuseat.org
# "ztl.dorkslayers.com",
);



# END OF CONFIGURATION



use Socket;
use POSIX ":sys_wait_h";
use Net::DNS;
$res=new Net::DNS::Resolver;

$myname=($0=~/([^\/ ]+)$/) ? $1 : 'rblcheck';

$TimeOut=$TimeOutDefault;

sub ShowSyntax {
  print STDERR "$myname\n$Version\n$Copyright\n";
  print STDERR "Usage: $myname [-qtmlcvh?] [-o <NN>] [-s <services>] <IP> [<IP> ...]\n\n";
  print STDERR "    -q            Quiet mode; no output\n";
  print STDERR "    -i            Print Pseudo-IP reported by rbl\n";
  print STDERR "    -t            Print TXT record\n";
  print STDERR "    -m            Stop checking after first address match in any list\n";
  print STDERR "    -l            List default RBL services to check\n";
  print STDERR "    -c            Clear the current list of RBL services\n";
  print STDERR "    -o <NN>       Change time out to NN seconds (default: $TimeOutDefault)\n";
  print STDERR "    -s <service>  Add a new service to the RBL services list\n";
  print STDERR "    -h, -?        Display this help message\n";
  print STDERR "    -v            Display version information\n";
  print STDERR "    <IP>          An IP address to look up; specify '-' to read multiple\n";
  print STDERR "                  addresses (or a whole mail header) from standard input\n";
if($< == 0) { print STDERR "Attention: -m and -o will not be very efficient under Windows!\n"; }
}

# Check parameters
$showtxt=0; $showip=0;
$quit1stpos=0;
$quiet=0;
if($#ARGV<0) { &ShowSyntax; exit 255; }
while($#ARGV>=0) {
  if($ARGV[0]=~/^\-([a-z\?])([a-z\?]*)$/i) {
    if($1 eq "c") { @rbls=(); }
    elsif($1 eq "s") { 
      if($#ARGV<1) { die ("$myname: No parameter (rbl) after -s.\n"); }
      shift @ARGV; push (@rbls, $ARGV[0]); 
    }
    elsif($1 eq "o") { 
      if($#ARGV<1) { die ("$myname: No parameter (time in seconds) after -o.\n"); }
      shift @ARGV; $TimeOut=$ARGV[0]; 
    }
    elsif($1 eq 'm') { $quit1stpos=-1; }
    elsif($1 eq 'q') { $quiet=-1; }
    elsif($1 eq 'h' || $1 eq '?') { &ShowSyntax; exit; }
    elsif($1 eq 'i') { $showip=-1; }
    elsif($1 eq 't') { $showtxt=-1; }
    elsif($1 eq 'v') { print STDERR "$Version\n$Copyright\n"; exit; }
    elsif($1 eq 'l') {
      for($i=0;$i<=$#rbls;$i++) { print $rbls[$i]."\n"; }
      exit 0;
    }
    else { die("$myname: Unknown parameter -$1.\n"); }
    # place next parameter in first position
    if($2 ne '') { $ARGV[0]="-$2"; }
    else { shift @ARGV; }
  }
  elsif($ARGV[0] eq '-') { # Read IPs from STDIN
    while(defined($inputline=<STDIN>)) {
      chomp $inputline; 
      @inputwords=split(/ /,$inputline);
      foreach $inputword(@inputwords) {
        if(!defined(@IPs)) { $IPs[0]=$inputword; } else { push (@IPs,$inputword); }
      }
    }
    shift @ARGV;
  }
  else {
    # Must be an IP
    if(!defined(@IPs)) { $IPs[0]=shift @ARGV; } else { push(@IPs, shift @ARGV); }
  }
}
if($#rbls<0) { die("$myname: no rbl listing(s) specified (need `-s <IP>'?)\n"); }
$imax=0;
for($i=0;$i<=$#IPs;$i++) {
  if($IPs[$i]=~/(\d+)\.(\d+)\.(\d+)\.(\d+)/) {
    $IPs[$imax]=1*$1.".".1*$2.".".1*$3.".".1*$4;
    $RevIPs[$imax]=1*$4.".".1*$3.".".1*$2.".".1*$1.".";
    # skip Private Address Space (cp. RfC 1918)
    if(!($1==10 || $1==172 && $2>15 && $2<33 || 
         $1==192 && $2==168 || $IPs[$imax] eq '127.0.0.1')) { $imax++; }
  }
}
if($imax<1) {
  print STDERR "$myname: no public IP address(es) specified\n";
  &ShowSyntax;
  exit 1;
}
$ParentP="y"; $NumChildren=0; $Windows="n";
while($ParentP eq "y" && $#rbls>=0) { # LOOP TO GENERATE CHILDREN
  if ($Windows eq "y") { sleep $sleepseconds; } # a helpless workaround :-/
  $rbl=$rbls[0]; # next rbl to be checked
  $rnr=fork(); # generate a child
  if($rnr == 0 ) {  # a child should not generate children
    $ParentP="n"; 
    last;
  }
  elsif($rnr<0) { $Windows="y"; } # supposed
  # Parent; associate PID of new child with rbl to check;
  $NumChildren++; $RBL2CHK{$rnr}=$rbl;
  shift @rbls;
}
if($ParentP eq "n") { # Each child has to check all IPs against one rbl
  $listed=0;
  for($i=0;$i<$imax;$i++) {
    $zwi=$RevIPs[$i].$rbl;
    $Result=gethostbyname($zwi);
    if(!defined($Result)) { $Result=$IPs[$i]." not RBL filtered by ".$rbl."\n"; }
    else {
      $listed=1;
      if($showtxt) {
        $query=$res->search($zwi,"TXT");
        undef $TXT;
        if($query) {
          foreach $rr ($query->answer) {
            next unless $rr->type eq "TXT";
            $TXT=(defined($TXT) ? $TXT." / " : "").($rr->txtdata);
          }
          if(!defined($TXT)) { $TXT=" - "; }
        }
        else { $TXT=" *TXT QUERY FAILED* "; }
      }      
      $Result=$IPs[$i]." RBL filtered by ".$rbl.
             ($showtxt ? ": ".$TXT : "").
             ($showip ? " (".inet_ntoa($Result).")" : "").
             "\n";
    }
    if(!$quiet) { print STDOUT $Result; }
    if($quit1stpos && $listed) { exit 1; }
  }
  exit $listed;
}
else { # Parent has to wait for the deaths of all children or to kill them in case of time out
  $Ende=$TimeOut+time; $Killed="n"; $listed=0;
  for($i=0;$i<$NumChildren;$i++) {
    do { 
      if(time>$Ende && $Killed eq "n" && $Windows ne "y") { # Time out - kill it
        foreach $Pid (keys %RBL2CHK) {
          if($RBL2CHK{$Pid} ne "-") { 
            if(!($quit1stpos && $listed==1) && !$quiet) {
              print STDERR "Check for filtering by ".$RBL2CHK{$Pid}.
                  " timed out (".$TimeOut." s).\n";
            }
            kill 9,$Pid;
          }
        }
        $Killed="y";
      }
      $rv=waitpid(-1, &WNOHANG); $rvc=$?;
    } until $rv != 0;
    if($rv>=0 || $Windows eq "y") { # It was a child
      if($rvc!=0 && !($rvc==9 && $Killed eq "y")) {
        if($rvc==256) { $listed=1; if($quit1stpos) { $Ende=time; } }
        else {
          print STDERR "Check for ".$RBL2CHK{$rv}." finished with code $rvc.\n";
        }
      }
      $RBL2CHK{$rv}="-"; # bury it
    }
    else { # This should never happen :-)
      print STDERR "$myname: Internal error - parent process $$ says: No child to wait for!\n";
    }
  }
  exit $listed;
}
