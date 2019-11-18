#!/usr/bin/perl 

#
#  Separa o ficheiro de atributos em 3 conjuntos,
#  onde cada conjunto uma categoria: Adjs Nomes e Verbos
#
#  Modifs:
#     - 19fev2003 - modif a relação adj (down<-->up)
#






while ($line = <STDIN>) { #le cada linha do arquivo
   chomp $line;
  ($cntx, $pal, $f, $ling) = split(" ", $line);
 
#  print STDERR "$cntx -- $pal --- $f \n";
  if ( ($cntx =~ /^Robj\_down/) || ($cntx =~ /^iobj&CprepR\/[^ ]*\_down/) || ($cntx =~ /^Lobj\_down/) ) {  
    
   #  printf STDERR "verbo: %s ; contexto %s\n", $pal, $cntx;
     print  "$cntx $pal $f\n";
  } 
  else {
     if ( ($cntx =~ /^Rmod\_up/) || ($cntx =~ /^Lmod\_up/) ) { 
    #  printf STDERR "adj: %s ; contexto %s\n", $pal, $cntx; 
      print  "$cntx $pal $f\n";
     }
     elsif ($cntx =~ /^CprepR/) {
    #   printf STDERR "nome: %s ; contexto %s\n", $pal, $cntx;
        print  "$cntx $pal $f $ling\n";
     }
     elsif ($cntx =~ /^modN/) {
    #   printf STDERR "nome: %s ; contexto %s\n", $pal, $cntx;
        print  "$cntx $pal $f $ling\n";
     }

  }
}

print STDERR "Done N.\n\n";
