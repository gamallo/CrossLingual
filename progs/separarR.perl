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
 
  #print STDERR "$cntx -- $pal --- $f \n";



   ##AdV                                                                                                                                              
  if ( $cntx =~ /LmodA\_down/ || $cntx =~ /LmodV\_down/ || $cntx =~ /RmodV\_down/ ) {
      print  "$cntx $pal $f $ling\n";
  }

}

print STDERR "Done R.\n\n";
