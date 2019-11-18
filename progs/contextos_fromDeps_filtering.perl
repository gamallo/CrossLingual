#!/usr/bin/perl

#GERA OS CONTEXTOS, AS PALAVRAS E AS FREQUENCIAS USANDO UM FICHEIRO DE PALAVRAS FILTRADAS 
#lê o resultado do parsing: dependencias. 

#use progs::funcoes::categorias

$file = shift(@ARGV);
open (FILE, $file) or die "O ficheiro n�o pode ser aberto: $!\n";

while ($words = <FILE>) {
    chomp $words;
    $Words{$words}++;

}

$CountDep=0;

while ($line = <STDIN>) {

   if ($line !~ /^SENT::/) {

     if ( ($CountLines % 100) == 0) {;
       printf  STDERR "- - - processar linha:(%6d) - - -\r",$CountLines;
     }
     $CountLines++;


     $rel="";
     $head="";
     $dep="";
     $cat_h="";
     $cat_d="";
     $cat_r="";

     chop($line);

     #tiramos as parenteses da dependencia
     $line =~ s/^\(//;
     $line =~ s/\)$//;
    # print STDERR "$line\n";

     $line =~ s/^(Circ|[iI]obj|Creg)/iobj/;

    ($rel, $head, $dep) = split('\;', $line);

    ($head,$cat_h) = split ("_", $head);
    ($dep,$cat_d) = split ("_", $dep);

     ##Filtering
     $w1 = $head . "_" . $cat_h;
     $w2 = $dep . "_" . $cat_d;
#     print STDERR "w1 : #$w1# -- w2: #$w2#\n";
#     if (!$Words{$w1} || !$Words{$w2}) 
     if (!$Words{$w1} && !$Words{$w2}) { 
#	 print STDERR "w1 : #$w1# -- w2: #$w2#\n";
	 next;
     }

    if ($rel =~ /_/) {
        ($rel, $cat_r) = split ("_", $rel);
        ($relname, $rel) = split ('\/', $rel);
         #print STDERR "REL::: $rel -- $cat_r\n";
    }





##REGRA  NOUN-PREP-NOUN 

     if ( ($cat_r =~ /^PRP|POS/) && ($cat_h =~ /^N/) && ($cat_d =~ /^N/) ){
          $NPN{$head,$rel,$dep}++;
     }

##REGRA  NOUN-PREP-VERB                                                                                                                                         
     if ( ($cat_r =~ /^PRP|POS/) && ($cat_h =~ /^N/) && ($cat_d =~ /^V/) ){
	 $NPV{$head,$rel,$dep}++;
     }


##REGRA  VERB-PREP-NOUN 

     elsif ( ($cat_r  =~ /^PRP/) && ($cat_h =~ /^V/) && ($cat_d =~ /^N/) ){
          $VPN{$head,$rel,$dep}++;
         #  print STDERR "VERB-PRP-NOUN::: $head -- $rel -- dep\n";
     }

##REGRA  VERB-PREP-VERB 
     elsif ( ($cat_r  =~ /^PRP/) && ($cat_h =~ /^V/) && ($cat_d =~ /^V/) ){
	 $VPV{$head,$rel,$dep}++;
         #  print STDERR "VERB-PRP-NOUN::: $head -- $rel -- dep\n";                                                                                                               
     }


##REGRA  ADJ-PREP-NOUN                                                                                                                                                           
     elsif ( ($cat_r  =~ /^PRP/) && ($cat_h =~ /^ADJ/) && ($cat_d =~ /^N/) ){
	 $APN{$head,$rel,$dep}++;
         #  print STDERR "VERB-PRP-NOUN::: $head -- $rel -- dep\n";                                                                                                               
     }
    ##REGRA  ADJ-PREP-VERB                                                                                                                                                           
    elsif ( ($cat_r  =~ /^PRP/) && ($cat_h =~ /^ADJ/) && ($cat_d =~ /^V/) ){
	 $APV{$head,$rel,$dep}++;
         #  print STDERR "VERB-PRP-NOUN::: $head -- $rel -- dep\n";                                                                                                                                                                                                                                       
     }



##REGRA  NOUN-NOUN (linguas romances) 

     elsif ( ($rel eq "AdjnR") && ($cat_h =~ /^N/) && ($cat_d =~ /^N/) ){
          $NN{$head,$dep}++;
     }

##REGRA  NOUN-NOUN (ingles) 

     elsif ( ($rel eq "AdjnL") && ($cat_h =~ /^N/) && ($cat_d =~ /^N/) ){
          $NN{$head,$dep}++;
     }



##REGRAS NOUN-ADJ, ADJ-NOUN

     elsif ( ($rel eq "AdjnR") && ($cat_h =~ /^N/) && ($cat_d =~ /^ADJ/) ){
          $NA{$head,$dep}++;
     }

     elsif ( ($rel eq "AdjnL") && ($cat_h =~ /^N/) && ($cat_d =~ /^ADJ/) ){
          $AN{$head,$dep}++;
     }
     ##se o dependente e um cardinal, colocar a etiqueta para reduzir o numero de contextos diferentes
     elsif ( ($rel eq "AdjnL") && ($cat_h =~ /^N/) && ($cat_d =~ /^CARD/) ){
          $AN{$head,$cat_d}++;
     }


##REGRA  ADV-ADJ (Adjn)                                                                                                                              
            elsif ( ($rel =~ /^AdjnL/) && ($cat_h =~ /^ADJ/) && ($cat_d =~ /^ADV/) ){
                $RA{$head,$dep}++;
            }

#REGRA  ADV-VERB (AdjnL)                                                                                                                              
            elsif ( ($rel =~ /^AdjnL/) && ($cat_h =~ /^VERB/) && ($cat_d =~ /^ADV/) ){
                $RV{$head,$dep}++;
            }
#REGRA  VERB-ADV (AdjnR)                                                                                                                              
            elsif ( ($rel =~ /^AdjnR/) && ($cat_h =~ /^VERB/) && ($cat_d =~ /^ADV/) ){
                $VR{$head,$dep}++;
            }

##REGRA  VERB-ADJ (Atr)                                                                                                                              
	    elsif ( ($rel =~ /^Atr/) && ($cat_h =~ /^V/) && ($cat_d =~ /^ADJ/) ){
		$VAmod{$head,$dep}++;
	    }

##REGRA  VERB-VERB (Adjn)                                                                                                                              
            elsif ( ($rel =~ /^Adjn/) && ($cat_h =~ /^V/) && ($cat_d =~ /^V/) ){
                $VVmod{$head,$dep}++;
            }



##REGRA  VERB-NOUN

     elsif ( ($rel =~ /^(Dobj|Atr)/) && ($cat_h =~ /^V/) && ($cat_d =~ /^N/) ){
          $VN{$head,$dep}++;
     }

     ##participios com left object sao associados aos right objects...
#     elsif ( ($rel =~ /^Subj/) && ($cat_h =~ /^VERBP/) && ($cat_d =~ /^N/) ){
#          $VN{$head,$dep}++;
#     }


##REGRA  NOUN-VERB

     elsif ( ($rel  =~ /^Subj/) && ($cat_h =~ /^V/) && ($cat_d =~ /^N/) ){
          $NV{$head,$dep}++;
     }

   ##REGRA  VERB-VERB (Dobj)                                                                                                                                   
     elsif ( ($rel =~ /^(Dobj|Atr)/) && ($cat_h =~ /^V/) && ($cat_d =~ /^V/) ){
		$DVV{$head,$dep}++;
     }
 ##REGRA  VERB-VERB (Subj)                                                                                                                                   
     elsif ( ($rel =~ /^Subj/) && ($cat_h =~ /^V/) && ($cat_d =~ /^V/) ){
		$SVV{$head,$dep}++;
     }

   }

}





print STDERR "fim leitura do ficheiro de entrada -- hashes carregados em memoria\n";


foreach $key (sort keys %NPN) {
  ($p1, $p2, $p3) = split (/$;/o, $key);
     if ($NPN{$p1,$p2,$p3}>0) {
       printf "Cprep&%s_down_%s %s %d\n", $p2, $p1, $p3 , $NPN{$p1,$p2,$p3};
       #print STDERR "trigram: $p1-$p2-$p3\n";
        printf "Cprep&%s_up_%s %s %d\n", $p2, $p3, $p1, $NPN{$p1,$p2,$p3};
     }

}

 foreach $key (sort keys %NPV) {
	 ($p1, $p2, $p3) = split (/$;/o, $key);
	 if ($NPV{$p1,$p2,$p3}>0) {
	     printf "CprepV&%s_down_%s %s %d\n", $p2, $p1, $p3 , $NPV{$p1,$p2,$p3};
       #print STDERR "trigram: $p1-$p2-$p3\n";                                                                                                        
	     printf "CprepV&%s_up_%s %s %d\n", $p2, $p3, $p1, $NPV{$p1,$p2,$p3};
	 }

     }

     foreach $key (sort keys %VPN) {
         ($p1, $p2, $p3) = split (/$;/o, $key);
         if ($VPN{$p1,$p2,$p3}>0) {
             printf "Iobj&%s_down_%s %s %d\n", $p2, $p1, $p3 , $VPN{$p1,$p2,$p3};
       #print STDERR "trigram: $p1-$p2-$p3\n";                                                                                                       
             printf "Iobj&%s_up_%s %s %d\n", $p2, $p3, $p1, $VPN{$p1,$p2,$p3};
         }

     }

     foreach $key (sort keys %VPV) {
         ($p1, $p2, $p3) = split (/$;/o, $key);
         if ($VPV{$p1,$p2,$p3}>0) {
             printf "IobjV&%s_down_%s %s %d\n", $p2, $p1, $p3 , $VPV{$p1,$p2,$p3};
       #print STDERR "trigram: $p1-$p2-$p3\n";                                                                                                       
             printf "IobjV&%s_up_%s %s %d\n", $p2, $p3, $p1, $VPV{$p1,$p2,$p3};
         }

     }


     foreach $key (sort keys %APN) {
         ($p1, $p2, $p3) = split (/$;/o, $key);
         if ($APN{$p1,$p2,$p3}>0) {
             printf "Aprep&%s_down_%s %s %d\n", $p2, $p1, $p3 , $APN{$p1,$p2,$p3};
       #print STDERR "trigram: $p1-$p2-$p3\n";                                                                                                                                                                                                                                   
             printf "Aprep&%s_up_%s %s %d\n", $p2, $p3, $p1, $APN{$p1,$p2,$p3};
         }

     }

foreach $key (sort keys %APV) {
         ($p1, $p2, $p3) = split (/$;/o, $key);
         if ($APV{$p1,$p2,$p3}>0) {
             printf "AprepV&%s_down_%s %s %d\n", $p2, $p1, $p3 , $APV{$p1,$p2,$p3};
       #print STDERR "trigram: $p1-$p2-$p3\n";                                                                                                                                                                                                                                   
             printf "AprepV&%s_up_%s %s %d\n", $p2, $p3, $p1, $APV{$p1,$p2,$p3};
         }

 }

foreach $key (sort keys %NN) {
  ($p1, $p2) = split (/$;/o, $key);
     if ($NN{$p1,$p2}>0) {
       printf "modN_down_%s %s %d\n", $p1, $p2, $NN{$p1,$p2} ;
      # print STDERR "bigram: $p1-modN-$p2\n";
        printf "modN_up_%s %s %d\n", $p2, $p1, $NN{$p1,$p2} ;
     }
}


foreach $key (sort keys %NA) {
  ($p1, $p2) = split (/$;/o, $key);
     if ($NA{$p1,$p2}>0) {
       printf "Rmod_down_%s %s %d\n", $p1, $p2, $NA{$p1,$p2} ;
       #print STDERR "bigram: $p1-$p2\n";
        printf "Rmod_up_%s %s %d\n", $p2, $p1, $NA{$p1,$p2} ;
     }

}


foreach $key (sort keys %AN) {
  ($p1, $p2) = split (/$;/o, $key);
     if ($AN{$p1,$p2}>0) {
       printf "Lmod_down_%s %s %d\n", $p1, $p2, $AN{$p1,$p2} ;
       #print STDERR "bigram: $p1-$p2\n";
       printf "Lmod_up_%s %s %d\n", $p2, $p1, $AN{$p1,$p2} ;
     }

}

 foreach $key (sort keys %RA) {
	 ($p1, $p2) = split (/$;/o, $key);
	 if ($RA{$p1,$p2}>0) {
	     printf "LmodA_down_%s %s %d\n", $p1, $p2, $RA{$p1,$p2} ;
       #print STDERR "bigram: $p1-$p2\n";                                                                                                             
	     printf "LmodA_up_%s %s %d\n", $p2, $p1, $RA{$p1,$p2} ;
	 }

     }


     foreach $key (sort keys %VR) {
         ($p1, $p2) = split (/$;/o, $key);
         if ($VR{$p1,$p2}>0) {
             printf "RmodV_down_%s %s %d\n", $p1, $p2, $VR{$p1,$p2} ;

             printf "RmodV_up_%s %s %d\n", $p2, $p1, $VR{$p1,$p2} ;
         }

     }
    foreach $key (sort keys %RV) {
         ($p1, $p2) = split (/$;/o, $key);
         if ($RV{$p1,$p2}>0) {
             printf "LmodV_down_%s %s %d\n", $p1, $p2, $RV{$p1,$p2} ;

             printf "LmodV_up_%s %s %d\n", $p2, $p1, $RV{$p1,$p2} ;
         }

     }

     foreach $key (sort keys %VAmod) {
         ($p1, $p2) = split (/$;/o, $key);
         if ($VAmod{$p1,$p2}>0) {
             printf "Vmod_down_%s %s %d\n", $p1, $p2, $VAmod{$p1,$p2} ;

             printf "Vmod_up_%s %s %d\n", $p2, $p1, $VAmod{$p1,$p2} ;
         }

     }

     foreach $key (sort keys %VVmod) {
         ($p1, $p2) = split (/$;/o, $key);
         if ($VVmod{$p1,$p2}>0) {
             printf "VmodV_down_%s %s %d\n", $p1, $p2, $VVmod{$p1,$p2} ;

             printf "VmodV_up_%s %s %d\n", $p2, $p1, $VVmod{$p1,$p2} ;
         }

     }



foreach $key (sort keys %VN) {
  ($p1, $p2) = split (/$;/o, $key);
     if ($VN{$p1,$p2}>0) {
       printf "Dobj_down_%s %s %d\n", $p1, $p2,  $VN{$p1,$p2} ;
       #print STDERR "bigram: $p1-$p2\n";
        printf "Dobj_up_%s %s %d\n", $p2, $p1, $VN{$p1,$p2} ;
     }

}

foreach $key (sort keys %NV) {
  ($p1, $p2) = split (/$;/o, $key);
     if ($NV{$p1,$p2}>0) {
       printf "Subj_down_%s %s %d\n", $p1, $p2, $NV{$p1,$p2} ;
      # print STDERR "bigram: $p1-$p2\n";
        printf "Subj_up_%s %s %d\n", $p2, $p1, $NV{$p1,$p2};
     }

}

foreach $key (sort keys %DVV) {
  ($p1, $p2) = split (/$;/o, $key);
     if ($DVV{$p1,$p2}>0) {
       printf "DobjV_down_%s %s %d\n", $p1, $p2,  $DVV{$p1,$p2} ;
       #print STDERR "bigram: $p1-$p2\n";
        printf "DobjV_up_%s %s %d\n", $p2, $p1, $DVV{$p1,$p2} ;
     }

}

foreach $key (sort keys %SVV) {
  ($p1, $p2) = split (/$;/o, $key);
     if ($SVV{$p1,$p2}>0) {
       printf "SubjV_down_%s %s %d\n", $p1, $p2,  $SVV{$p1,$p2} ;
       #print STDERR "bigram: $p1-$p2\n";
        printf "SubjV_up_%s %s %d\n", $p2, $p1, $SVV{$p1,$p2} ;
     }

}


print  STDERR "o ficheiro de contextos - palavra - freq  foi gerado\n";
