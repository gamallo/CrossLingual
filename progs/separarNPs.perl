#!/usr/bin/perl 

#separar os nomes que sao nomes proprios (majusculas)


$UpperCase = "[A-Z\301\311\315\323\332\307\303\325\302\312\324\300\310Ñ]" ;




while ($line = <STDIN>) { #le cada linha do arquivo
   chomp $line;
  ($cntx, $pal, $f, $ling) = split(" ", $line);
 
  #print STDERR "$cntx -- $pal --- $f \n";
  if ( ($cntx =~ /Robj_up/) || ($cntx =~ /iobj\&[^ ]*_up/) || ($cntx =~ /Lobj\_up/) ) {  
    
   #  printf STDERR "verbo: %s ; contexto %s\n", $pal, $cntx;
    #  print VERB_OUTPUT "$cntx $pal $f\n";
  } 
  else {
     if ( ($cntx =~ /Rmod_down/) || ($cntx =~ /Lmod_down/) ) { 
    #  printf STDERR "adj: %s ; contexto %s\n", $pal, $cntx; 
    #  print ADJ_OUTPUT "$cntx $pal $f\n";
     }
     elsif ($pal =~ /^$UpperCase/) {
    #   printf STDERR "nome: %s ; contexto %s\n", $pal, $cntx;
        print  "$cntx $pal $f $ling\n";
     }
  }
}

print STDERR "Done N.\n\n";
