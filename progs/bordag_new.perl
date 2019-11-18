#!/usr/bin/perl

# LE O FICHEIRO FREQ_TEMPLATES E DEIXA PARA CADA PALAVRA:
## OS N=200 TEMPLATES COM MAIOR VALOR





#lê um ficheiro com todos os freqs (cntx pal freq) (pipe)
# os argumentos sao dous thresholds e duas linguas: S G 

#$file = shift(@ARGV);
#open (INPUT, $file) or die "O ficheiro não pode ser aberto: $!\n";



##threshold  (num. maximo de contextos por palavra: 200)
$th = shift(@ARGV);

$th2= 100;
#$L1 = shift(@ARGV); #lingua fonte: S
#$L2 = shift(@ARGV); #lingua alvo: G



$countLines=0;
while ($line = <STDIN>) {
      chomp($line);
      ($template, $word, $freq) = split (" ", $line);

      ##only for nouns:
      if ($template  =~ /Dobj_down/) {
	  $Dobj{$word}{$template} = $freq;
      }
      elsif ($template  =~/Subj_down/) {
          $Subj{$word}{$template} = $freq;
      }

      elsif ($template  =~/Iobj\&[^_]+_down/) {
          $Iobj{$word}{$template} = $freq;
      }
      
      else {

        $Dico{$word}{$template} = $freq;
      }

      if ( ($CountLines % 100) == 0) {;
       printf  STDERR "- - - processar linha:(%6d) - - -\r",$CountLines;
      }
      $CountLines++;
    
}



foreach $w (keys %Dico) {

   $countTH=0;
   $countS=0;
   $countD=0;
   $countI=0;
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

      foreach  $t (sort {$Subj{$w}{$b} <=>
			      $Subj{$w}{$a}}
		    keys %{$Subj{$w}} )  {
	   $countS++;
	   if ($countS <= $th2) {
	       print "$t $w $Subj{$w}{$t} \n";

	       if (!defined $found{$t}) {
		   $count++;
	       }
	       $found{$t}++;
	   }
      }
       foreach  $t (sort {$Dobj{$w}{$b} <=>
			  $Dobj{$w}{$a}}
			keys %{$Dobj{$w}} )  {
	       $countD++;
	       if ($countD <= $th2) {
		   print "$t $w $Dobj{$w}{$t} \n";

		   if (!defined $found{$t}) {
		       $count++;
		   }
		   $found{$t}++;
	       }
     }  
    foreach  $t (sort {$Iobj{$w}{$b} <=>
			     $Iobj{$w}{$a}}
			    keys %{$Iobj{$w}} )  {
		   $countI++;
		   if ($countI <= $th2) {
		       print "$t $w $Iobj{$w}{$t} \n";

		       if (!defined $found{$t}) {
			   $count++;
		       }
		       $found{$t}++;
		   }

     }
 }

     
 



print STDERR "numero de templates: ##$count##\n";
print STDERR "foi gerado o ficheiro dos templates\n";
