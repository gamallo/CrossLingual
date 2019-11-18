#!/usr/bin/perl

# LE O FICHEIRO FREQ_TEMPLATES E DEIXA PARA CADA PALAVRA:
## OS N=200 TEMPLATES COM MAIOR VALOR





#lê um ficheiro com todos os freqs (cntx pal freq) (pipe)
# os argumentos sao dous thresholds e duas linguas: S G 

#$file = shift(@ARGV);
#open (INPUT, $file) or die "O ficheiro não pode ser aberto: $!\n";



##threshold  (num. maximo de contextos por palavra: 200)
$th = shift(@ARGV);

#$L1 = shift(@ARGV); #lingua fonte: S
#$L2 = shift(@ARGV); #lingua alvo: G



$countLines=0;
while ($line = <STDIN>) {
      chomp($line);
      ($template, $word, $freq) = split (" ", $line);
      
      $Dico{$word}{$template} = $freq;

      if ( ($CountLines % 100) == 0) {;
       printf  STDERR "- - - processar linha:(%6d) - - -\r",$CountLines;
      }
      $CountLines++;
    
}



foreach $w (keys %Dico) {

   $countTH=0;
   foreach  $t (sort {$Dico{$w}{$b} <=>
                      $Dico{$w}{$a}}
                      keys %{$Dico{$w}} )  {
       $countTH++;
       if ($countTH <= $th) {
          print "$t $w $Dico{$w}{$t} \n";

          if (!defined $found{$t}) {
           $count++;
          }
      $found{$t}++;
      }
   }
 }
     
     
 



print STDERR "numero de templates: ##$count##\n";
print STDERR "foi gerado o ficheiro dos templates\n";
