#!/usr/bin/perl -w


##Conta os lemas que tenhem freq superior a um th (passar antes o filtrar-tagged.perl, limparFreq.x)


use lib "/home/gamallo/EntitiesClustering/progs/funcoes" ;
use categorias ;

# $file = shift(@ARGV);

#open (FILE, $file) or die "O ficheiro não pode ser aberto: $!\n";


$th = shift(@ARGV);



$tag="";
$forma="";
while (<>) {
     chop $_;
    ($forma, $lema, $tag) = split(" ", $_);
     
##selec um POS Tagger 
     if  (Verbo ($tag) || Nome($tag) || Adj($tag) || 
             Adv($tag) )  {

       $Freq{$lema}++;
       

     }
    
} 	

print STDERR "acabou de carregar no hash"; 

foreach $l (sort {$Freq{$b} <=>
                      $Freq{$a} }
                      keys %Freq ) {

  if ($Freq{$l} >= $th) {
    print "$l $Freq{$l}\n";
  }

}
	
