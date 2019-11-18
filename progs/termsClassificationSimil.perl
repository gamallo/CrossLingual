#!/usr/bin/perl 

##Lê o ficheiro de classes FIM CLASSE (arg1),  uma lista de termos (arg2) e o thesaurus-simil (arg3)
## lê também o ficheiro de frequências (pipe)

## devolve a classe e a lista rankeada de palavras classificadas

##Classificacao:

##cat ../intermedio/cluster2/lattice_aclI-X_terms-en_N.txt |escolherTermosParaClassif.perl ../thesaurus/results/Nouns_aclA-X.txt >  PalsParaClassificar1.txt

##zcat ../freq/freq-aclI-X-en_Filtrado_N.txt.gz |termsClassificationSimil.perl ../intermedio/cluster2/lattice_aclI-X_terms-en_N.txt PalsParaClassificar1.txt ../thesaurus/results/Nouns_aclA-X.txt > classificacao1.txt

##zcat ../freq/freq-aclA-H-en_Filtrado_N.txt.gz ../freq/freq_aclI-X-en_Filtrado_N.txt.gz ../freq/freq_termos_acl* |termsClassificationSimil.perl ../intermedio/cluster2/lattice_aclA-H-en_N3.txt x ../thesaurus/results/Nomes-aclA-H-en.txt > xxx50

$file1 = shift(@ARGV);
open (FILE1, $file1) or die "O ficheiro não pode ser aberto: $!\n" ;

$file2 = shift(@ARGV);
open (FILE2, $file2) or die "O ficheiro não pode ser aberto: $!\n" ;


$file3 = shift(@ARGV);
open (FILE3, $file3) or die "O ficheiro não pode ser aberto: $!\n" ;


$th= 0.5;


$CountLines=0;

while ($line = <STDIN>) {
  chop $line;
  ($cntx, $pal, $freq) =  split (" ", $line) ;
  $Freqs{$cntx}{$pal} = $freq;
  #$CDiff{$pal}++ ;
  #$WDiff{$cntx}++ ;
  #$Pal{$pal} += $freq;
  #$Cntx{$cntx} += $freq;
  #print STDERR "$cntx :: $pal :: $freq\n";

  print STDERR "Linhas: $CountLines\r";
  $CountLines++;
}

print STDERR "leu ficheiro de frequências\n";


##ler termos...
while ($line = <FILE2>) {
  chop $line;
  ($termo, $tmp) =  split ("\t", $line) ;
  $termo =~ s/ /&/g;
  $DicoTermos{$termo}++;
  
   if ($termo =~  /semantic&net/) {
      print STDERR "T:: #$termo#\n";
   }
}



##ler thesaurus...
while ($line = <FILE3>) {
  chop $line;
  ($pal1, $setSimil) =  split (" ", $line) ;
  @WordsSimil = split ('\|', $setSimil) ;
  foreach $tmp (@WordsSimil) {
     ($pal2, $sim) = split ("=", $tmp) ;
     if ($pal2 ne "") {
        $Simil{$pal1}{$pal2} = $sim;
       # print STDERR "$pal1 :: $pal2 = $Simil{$pal1}{$pal2}\n";
    }
  }

}




$found=0;

while ($line = <FILE1>) {
  chop $line;
  if ($line =~ /FIM CLASSE/) {
     $found=1;
  }
  if ($found) {
    ($node, $wset, $cset, $idfFilhos) =  split (" ", $line)  ;
     if ($cset ne "") {
       $cset =~ s/\|\|/\|/g;
       $found=0;
       $rankedList="";
      # print STDERR "$node :: $wset :: $cset\n";
       @cset = split ('\|', $cset) ;
       $cardCset = $#cset+1;
        $CardSet{$node} = $cardCset;
       @wset = split ('\|', $wset) ;
       foreach $p (@wset) {
         $wset{$node}{$p}++;
         $ListaSimil{$node}{$p}++;
         foreach $p2 (keys %{$Simil{$p}}) {
              $ListaSimil{$node}{$p2}++;
         }
       }          

       foreach $c (@cset) {
         foreach $p (keys %{$Freqs{$c}}) {
           #$Candidates{$node}{$p} += $Freqs{$c}{$p} ;
           if (defined $DicoTermos{$p}) {
              $Tmp{$node}{$p}++ ;
           }
	 }
       }  

      foreach $p (keys %{$Tmp{$node}}) {
           $score = $Tmp{$node}{$p} / $cardCset ;
           #$Candidates{$node}{$p} = round ($score);
            $Candidates{$node}{$p} = $score;
            
          
      }
      
      foreach $p (sort {$Candidates{$node}{$b} <=>
                        $Candidates{$node}{$a} }
                      keys %{$Candidates{$node}} ) {

      
        if  ( (defined  $ListaSimil{$node}{$p}) && 
              ($Candidates{$node}{$p} >= $th) )  {
         $rankedList .= "|" .  $p . "=" . $Candidates{$node}{$p} ;

        }

        if ( ($p =~  /datum&structure/) && (defined  $ListaSimil{$node}{$p}) ) {
           print STDERR "$p -- ($wset :: $cset :: $Candidates{$node}{$p} #$CardSet{$node}# #$ListaSimil{$node}{$p}#\n"; 
        }
      }
      if ( $rankedList ne "") {
          print "$node $wset $cset #$CardSet{$node}# --->> $rankedList\n";
      }
    }
  }
  
}


       
       

