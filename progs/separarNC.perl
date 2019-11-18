#!/usr/bin/perl 

#
#  Separa o ficheiro de atributos em 3 conjuntos,
#  onde cada conjunto uma categoria: Adjs Nomes e Verbos
#
#  Modifs:
#     - 19fev2003 - modif a relaÁ„o adj (down<-->up)
#






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
     else {
    #   printf STDERR "nome: %s ; contexto %s\n", $pal, $cntx;
        if ($pal !~ /^[A-Z¡…Õ”⁄¬ Œ‘€¿»Ã“Ÿ«—]/) {
          print  "$cntx $pal $f $ling\n";
        }
     }
  }
}

print STDERR "Done N.\n\n";
