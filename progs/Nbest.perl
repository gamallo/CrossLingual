#!/usr/bin/perl 

$N=shift(@ARGV);

$count = 0;

while (<>) {
  chomp $_;
  ($pal1, $pal2, $sim) = split (" ", $_) ; 

  $pal1 =~ s/^[ ]*//;
  $pal2 =~ s/^[ ]*//;
  $sim =~ s/^[ ]*//;

  $dico{$pal1}{$pal2} = $sim;
   
  
}




foreach $p1 (keys %dico) {
    
     $Count{$p1} = 0;
     foreach $p2 (sort {$dico{$p1}{$b} <=>
                      $dico{$p1}{$a} }
                  keys %{ $dico{$p1} }) {

         

          
           if ($Count{$p1} <= $N){
                  print "$p1 $p2 $dico{$p1}{$p2}\n";
                   $Count{$p1}++;
	   }
     }
     delete $dico{$p1};
     delete $Count{$p1};
}
