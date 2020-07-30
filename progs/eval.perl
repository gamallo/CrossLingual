#!/usr/bin/perl 

$arq = shift(@ARGV);
open(PFILE, $arq) || die "Can't open search-patterns: $!\n";

while (<PFILE>) {
  chomp $_;
  ($pal1, $pal2, $cat) = split ("\t", $_) ; 

  $pal1 =~ s/^[ ]*//;
  $pal2 =~ s/^[ ]*//;
  $pares{$pal1}{$pal2} = $cat;

  #if (!$found{$pal1}) {
  #    $total2++;
   #   $found{$pal1}++;
  #}
}

while (<>) {
  chomp $_;
  ($pal1, $pal2, $sim) = split (' ', $_) ; 

  $pal1 =~ s/^[ ]*//;
  $pal2 =~ s/^[ ]*//;
  $sim =~ s/^[ ]*//;
  $pal1 =~ s/\#[ES]$//,
  $pal2 =~ s/\#[ES]$//,
  
  $dico{$pal1}{$pal2} = $sim if ($sim>0);
  
}



$N=10;
$miss=0;
foreach $p1 (sort keys %pares) {
     $total++;
     $Count{$p1} = 1;
     $i=1;
     $Found=();
     if (!$dico{$p1}) {
	 $miss++;
#	 print STDERR "Miss word: #$p1#\n";
     }
     else {
       foreach $p2 (sort {$dico{$p1}{$b} <=>
                      $dico{$p1}{$a} }
                  keys %{ $dico{$p1} }) {
   
	 if ($Count{$p1} <= $N){	 
	     $Found[$i] = $p2 ;
	     $Count{$p1}++;
	     $i++;
	 }
       }
       for ($i=1;$i<=$#Found;$i++) {

         $p2 = $Found[$i]; 
         if ($pares{$p1}{$p2}) {
   
     #        print STDERR "$i-> $p1 $p2 $dico{$p1}{$p2}\n";
	     if ($i == 1) {
                 $fp1++;
		 last
	     }
	     if ($i <= 5) {
                 $fp5++;
		 last
	     }
	      if ($i <= $N) {
                 $fp10++;
		 last
	     }
	     
	 }
       }
     }
     delete $dico{$p1};
     delete $Count{$p1};
     undef @Found;
}

$cov = ( ($total-$miss) / $total)*100;
print "Coverage: $cov\%\n";
$total_sys = $total - $miss;
$prec1 = $fp1 / ($total_sys);
#print STDERR "tp1:#$fp1# - total_sistema:#$total_sys# total:#$total# - miss #$miss#\n";
print "Prec1 = $prec1\n";

$prec5 = ($fp1+$fp5) / ($total_sys);
#print STDERR "tp5:#$fp5# - total:#$total#\n";
print "Prec5 = $prec5\n";

$prec10 = ($fp1+$fp5+$fp10) / ($total_sys);
#print STDERR "tp10:#$fp10# - total:#$total#\n";
print "Prec10 = $prec10\n";


