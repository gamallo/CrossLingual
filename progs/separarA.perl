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


  ##Adj
  if ( $cntx =~ /Lmod\_down/ || $cntx =~ /Aprep\&[^_]*\_up/ || $cntx =~ /Rmod\_down/ ||
       $cntx =~ /AprepV\&[^_]*\_up/ || $cntx =~ /Vmod\_down/) {
      print  "$cntx $pal $f $ling\n";
  }

   ##AdV                                                                                                                                              
#  if ( $cntx =~ /LmodA\_up/ || $cntx =~ /LmodV\_up/ || $cntx =~ /RmodV\_up/ ) {
#      print  "$cntx $pal $f $ling\n";
#  }

}

print STDERR "Done A.\n\n";
