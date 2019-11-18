#!/usr/bin/perl

#GERA UMA LISTA DE BIGRAMAS N+ADJ +FREQ 
#lê um ficheiro com N-gramas etiquetados, desambiguados e filtrados
## cat input-tagged.txt |filtro-tagged.perl |n-gramas-tagged.perl |extrairNA.perl > output


use progs::funcoes::categorias;

$th = shift(@ARGV) ;

$fr = shift(@ARGV);


$CountLines=0;
while ($line = <>) {
    $p1 = "";
    $p2 = "";
    $p3 = "";
    $p4 = "";
    $p5 = "";
    $p6 = "";
    $tag1 = "";
    $tag2 = "";
    $tag3 = "";
    $tag4 = "";
    $tag5 = "";
    $tag6 = "";






    chomp($line);
    ($p1, $p2, $p3, $p4, $p5, $p6) = split(" ", $line);

    if ( ($CountLines % 100) == 0) {;
       printf  STDERR "- - - processar linha:(%6d) - - -\r",$CountLines;
    }
    $CountLines++;

    if ($p1 =~ /\_/) {
         ($p1, $tag1) = split ('\_', $p1);
         if ( Prep($tag1) ) {
            $IsPrep{$p1}++;
           # print STDERR "$p1, $tag1\n";
	 }

         if  (Nome($tag1)) {
            $IsName{$p1}++;
            #print STDERR "name: $p1, $tag1\n";
	  }

         if  (Adj($tag1)) {
            $IsMod{$p1}++;
            #print STDERR "adj: $p1, $tag1\n";
	  }

         if  (Verbo ($tag1) ) {
            $IsVerb{$p1}++;
         }

     }


      if ($p2 =~ /\_/) {
         ($p2, $tag2) = split ('\_', $p2);
         if ( Prep($tag2) ) {
            $IsPrep{$p2}++;
           # print STDERR "$p2, $tag2\n";
	 }

         if  (Nome($tag2)) {
            $IsName{$p2}++;
            #print STDERR "name: $p2, $tag2\n";
	  }

         if  (Adj($tag2)) {
            $IsMod{$p2}++;
            #print STDERR "adj: $p2, $tag2\n";
	  }

         if  (Verbo ($tag2) ) {
            $IsVerb{$p2}++;
          }

     }

     if ($p3 =~ /\_/) {
         ($p3, $tag3) = split ('\_', $p3);
         if ( Prep($tag3) ) {
            $IsPrep{$p3}++;
            #print STDERR "$p3, $tag3\n";
	 }

         if  (Nome($tag3)) {
            $IsName{$p3}++;
            #print STDERR "name: $p3, $tag3\n";
	  }

         if  (Adj($tag3)) {
            $IsMod{$p3}++;
            #print STDERR "adj: $p3, $tag3\n";
	  }

          if  (Verbo ($tag3) ) {
            $IsVerb{$p3}++;
          }

     }

       if ($p4 =~ /\_/) {
         ($p4, $tag4) = split ('\_', $p4);
         if ( Prep($tag4) ) {
            $IsPrep{$p4}++;
           # print STDERR "$p4, $tag4\n";
	 }

         if  (Nome($tag4)) {
            $IsName{$p4}++;
            #print STDERR "name: $p4, $tag4\n";
	  }

         if  (Adj($tag4)) {
            $IsMod{$p4}++;
            #print STDERR "adj: $p4, $tag4\n";
	  }
        
         if  (Verbo ($tag4))  {
            $IsVerb{$p4}++;
          }
 

     }

      if ($p5 =~ /\_/) {
         ($p5, $tag5) = split ('\_', $p5);
         if ( Prep($tag5) ) {
            $IsPrep{$p5}++;
           # print STDERR "$p5, $tag5\n";
	 }

         if  (Nome($tag5)) {
            $IsName{$p5}++;
            #print STDERR "name: $p5, $tag5\n";
	  }

         if  (Adj($tag5)) {
            $IsMod{$p5}++;
            #print STDERR "adj: $p5, $tag5\n";
	  }

          if  (Verbo ($tag5) )  {
            $IsVerb{$p5}++;
          }


     }

      if ($p6 =~ /\_/) {
         ($p6, $tag6) = split ('\_', $p6);
         if ( Prep($tag6) ) {
            $IsPrep{$p6}++;
           # print STDERR "$p6, $tag6\n";
	 }

         if  (Nome($tag6)) {
            $IsName{$p6}++;
            #print STDERR "name: $p6, $tag6\n";
	  }

         if  (Adj($tag6)) {
            $IsMod{$p6}++;
            #print STDERR "adj: $p6, $tag6\n";
	  }

         if  (Verbo ($tag6) ) {
            $IsVerb{$p6}++;
          }

     }


####### counting single words:
     $Wfreq{$p1}++;



###PADRAO NOUN-ADJ
     if ( ((defined $IsName{$p1}) && defined $IsMod{$p2}) ){
            $NA{$p1,$p2}++;

     }

###PADRAO ADJ-NOUN
     if ( ((defined $IsName{$p2}) && defined $IsMod{$p1}) ){
            $AN{$p1,$p2}++;

     }

###PADRAO NOUN-NOUN
     if ( ((defined $IsName{$p1}) && defined $IsName{$p2}) ){
            $NN{$p1,$p2}++;

     }


###PADRAO NOUN-PREP-NOUN
     if ( ((defined $IsName{$p1}) && defined $IsPrep{$p2}) && (defined $IsName{$p3}) ){
            $NPN{$p1,$p2,$p3}++;

     }


###PADRAO NOUN-VERB que passa a verb-noun por ser participios
     if ( (defined $IsName{$p1}) && (defined $IsVPP{$p2}) ){
            $VN{$p2,$p1}++;

     }
     ###PADRAO VERB-NOUN
     if ( (defined $IsVerb{$p1}) && (defined $IsName{$p2}) ){
            $VN{$p1,$p2}++;

     }

      ###PADRAO VERB-PRP-NOUN
     if ( (defined $IsVerb{$p1}) && (defined $IsPrep{$p2}) && 
           (defined $IsName{$p3}) ){
            $VPN{$p1,$p2,$p3}++;

     }


    delete $IsPrep{$p1};
    delete $IsPrep{$p2};
    delete $IsPrep{$p3};
    delete $IsPrep{$p4};
    delete $IsPrep{$p5};
    delete $IsPrep{$p6};

    delete $IsName{$p1};
    delete $IsName{$p2};
    delete $IsName{$p3};
    delete $IsName{$p4};
    delete $IsName{$p5};
    delete $IsName{$p6};

    delete $IsMod{$p1};
    delete $IsMod{$p2};
    delete $IsMod{$p3};
    delete $IsMod{$p4};
    delete $IsMod{$p5};
    delete $IsMod{$p6};
  
    delete $IsVerb{$p1};
    delete $IsVerb{$p2};
    delete $IsVerb{$p3};
    delete $IsVerb{$p4};
    delete $IsVerb{$p5};
    delete $IsVerb{$p6};


}



print STDERR "fim leitura das ocurrencias em 6gramas\n";




##bigramas

foreach $key (sort keys %NA) {
     ($p1, $p2) = split (/$;/o, $key);
     if ($NA{$p1,$p2}>$fr) {
       $a = $NA{$p1,$p2};
       $scp = ( ($a * $a) / ($Wfreq{$p1} * $Wfreq{$p2}));

       if ($scp >= $th) {
         printf "%s %s\t%f\tN-A\n", $p1, $p2, $scp;
         print STDERR "NA: $p1-$p2\n";
     }
   }
}

foreach $key (sort keys %AN) {
     ($p1, $p2) = split (/$;/o, $key);
     if ($AN{$p1,$p2}>$fr) {
        $a = $AN{$p1,$p2};
        $scp = ( ($a * $a) / ($Wfreq{$p1} * $Wfreq{$p2}));

        if ($scp >= $th) {
          printf "%s %s\t%f\tA-N\n", $p1, $p2, $scp;
          print STDERR "AN: $p1-$p2\n";
        }
     }
}



foreach $key (sort keys %NN) {
     ($p1, $p2) = split (/$;/o, $key);
     if ($NN{$p1,$p2}>$fr) {
        $a = $NN{$p1,$p2};
        $scp = ( ($a * $a) / ($Wfreq{$p1} * $Wfreq{$p2}));

        if ($scp >= $th) {
          printf "%s %s\t%f\tN-N\n", $p1, $p2, $scp;
          print STDERR "NN: $p1-$p2\n";
        }
    }
}



## trigramas


foreach $key (sort keys %NPN) {
     ($p1, $p2, $p3) = split (/$;/o, $key);
     if ($NPN{$p1,$p2,$p3}>$fr) {
        $a = $NPN{$p1,$p2,$p3};
        $scp = ( ($a * $a) / ($Wfreq{$p1} * $Wfreq{$p3}));

        if ($scp >= $th) {
          printf "%s %s %s\t%f\tN-P-N\n", $p1, $p2, $p3, $scp;
          print STDERR "NPN: $p1-$p2-$p3\n";
        }
     }
}

###########VERBOS########

#foreach $key (sort keys %NV) {
#     ($p1, $p2) = split (/$;/o, $key);
#     if ($NV{$p1,$p2}>$fr) {
#       $a = $NV{$p1,$p2};
#       $scp = ( ($a * $a) / ($Wfreq{$p1} * $Wfreq{$p2}));

#       if ($scp >= $th) {
#         printf "%s %s\t%f\tN-V\n", $p1, $p2, $scp;
#         print STDERR "NV: $p1-$p2\n";
#     }
#   }
#}


foreach $key (sort keys %VN) {
     ($p1, $p2) = split (/$;/o, $key);
     if ($VN{$p1,$p2}>$fr) {
       $a = $VN{$p1,$p2};
       $scp = ( ($a * $a) / ($Wfreq{$p1} * $Wfreq{$p2}));

       if ($scp >= $th) {
         printf "%s %s\t%f\tV-N\n", $p1, $p2, $scp;
         print STDERR "VN: $p1-$p2\n";
     }
   }
}



foreach $key (sort keys %VPN) {
     ($p1, $p2, $p3) = split (/$;/o, $key);
     if ($VPN{$p1,$p2,$p3}>$fr) {
        $a = $VPN{$p1,$p2,$p3};
        $scp = ( ($a * $a) / ($Wfreq{$p1} * $Wfreq{$p3}));

        if ($scp >= $th) {
          printf "%s %s %s\t%f\tV-P-N\n", $p1, $p2, $p3, $scp;
          print STDERR "VPN: $p1-$p2-$p3\n";
        }
     }
}






