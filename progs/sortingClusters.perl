#!/usr/bin/perl 

##Toma o ficheiro de clusters extendido e o de centroides os ordena por hierarquias.



$file = shift(@ARGV);
open (FILE, $file) or die "O ficheiro não pode ser aberto: $!\n";


while ($line = <FILE>) {
  chop $line;
  ($idf, $wset, $cset) =  ($line =~ /([^ ]+) <[0-9]*=([^ ]+)> ([^ ]+)/)  ;
  $Centroide{$idf} = $line;
  #print STDERR "$idf :: $wset :: $cset\n";

}

$j=0;
while ($line = <STDIN>) {
  chop $line;
  ($node, $wset, $cset, $idfFilhos) =  ($line =~ /([^ ]+) ([^ ]+) ([^ ]+) ([^ ]+)/)  ;
  
   $Cluster{$node} = $line;
   $ListaCluster[$j] = $node;  
   #$Wset{$node} = $wset;
   #$Cset{$node} = $cset;
   $j++;  

 # print $ListaCluster[$i] ;
   ($filho1, $filho2) = split ('\|', $idfFilhos) ;
  
  if  ($filho1 =~ /Nbc/)  {
      $Expand{$filho1} =  $filho1 . "|" ;
  }
  if  ($filho2 =~ /Nbc/)  {
      $Expand{$filho2} = $filho2 ;
  }
  if  ($filho1 =~ /NODE/)  {
      $Expand{$filho1} =  $filho1 . "|" . $Expand{$filho1};

      $Expandido{$filho1}++;
  }
  if  ($filho2 =~ /NODE/)  {
      $Expand{$filho2} =  $filho2 . "|" . $Expand{$filho2};

      $Expandido{$filho2}++;
  }
 
   $Expand{$node} =  $Expand{$filho1} . "|" .  $Expand{$filho2};

   #print STDERR "$Expand{$node}\n";

   
}

  

$NumClusters = $j;


#for ($i=0;$i<=$NumClusters;$i++) {
for ($i=$NumClusters;$i>=0;$i--) {
    $node = $ListaCluster[$i];

    if (!defined $Expandido{$node}) {

      print "$Cluster{$node}\n";
     
      $Expand{$node} =~ s/\|\|/\|/g; 
      $Expand{$node} = $Expand{$node} . "\|" ; 
      #print "$Expand{$node}\n" ;
    
      @filhosTodos = split ('\|', $Expand{$node}) ;
      for ($j=0;$j<=$#filhosTodos;$j++) { 
         $filho = $filhosTodos[$j];
         #print "#@filhosTodos#\n";
         #print "$filho\n";
    
         if ($filho =~ /NODE/) {
            print "$Cluster{$filho}\n";
            #delete $Cluster{$filho} ;
         }
         elsif ($filho =~ /Nbc/) {
            print "$Centroide{$filho}\n";
            #delete $Centroide{$filho} ;
         }

#        print STDERR "$ListaCluster[$i]\n";
     }
      print "FIM CLASSE\n\n";
  }

}  
  

