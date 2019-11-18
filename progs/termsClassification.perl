#!/usr/bin/perl 

##Lê o ficheiro de classes FIM CLASSE (arg1) e uma lista de termos (arg2)
## lê também o ficheiro de frequências (pipe)

## devolve a classe e a lista rankeada de palavras classificadas



$file1 = shift(@ARGV);
open (FILE1, $file1) or die "O ficheiro não pode ser aberto: $!\n" ;

$file2 = shift(@ARGV);
open (FILE2, $file2) or die "O ficheiro não pode ser aberto: $!\n" ;

$th= 0.8;


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


##ler thesaurus...
while ($line = <FILE2>) {
  chop $line;
  ($termo, $tmp) =  split ("\t", $line) ;
  $termo =~ s/ /&/g;
  $DicoTermos{$termo}++
  
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
       @wset = split ('\|', $wset) ;
      # foreach $p (@wset) {
       #  $wset{$node}{$p}++;
       #  $ListaSimil{$node}{$p}++;
       #  foreach $p2 (keys %{$Simil{$p}}) {
       #       $ListaSimil{$node}{$p2}++;
       #  }
       #}          

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

      # if ($Candidates{$node}{$p} >= $th) {
      #   $rankedList .= "|" .  $p . "=" . $Candidates{$node}{$p} ;
     #  }
       if ($Candidates{$node}{$p} >= $th)  {
         $rankedList .= "|" .  $p . "=" . $Candidates{$node}{$p} ;
       }
      }
      if ( $rankedList ne "") {
          print "$node $wset $cset --->> $rankedList\n";
      }
    }
  }
  
}


       
       

