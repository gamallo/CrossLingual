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

  #Verb
 if (
        #$cntx =~ /Dobj\_up/ || $cntx =~ /Iobj\&[^ ]*\_up/ || $cntx =~ /Subj\_up/ ||
      $cntx =~ /Dobj\_up/ || $cntx =~ /Iobj\&[^_]*\_up/ |  $cntx =~ /Subj\_up/ ||
        $cntx =~ /DobjV\_(up|down)/ || $cntx =~ /IobjV\&[^_]*\_(up|down)/ || $cntx =~ /SubjV\_(up|down)/ ||
        $cntx =~ /Vmod\_up/ || $cntx =~ /RmodV\_up/ || $cntx =~ /LmodV\_up/ || $cntx =~ /VmodV\_(up|down)/ ) {

          print  "$cntx $pal $f $ling\n";
  }

  ##Adj
#  if ( $cntx =~ /Lmod\_up/ || $cntx =~ /Aprep\&[^ ]*\_down/ || $cntx =~ /Rmod\_up/ ||
#       $cntx =~ /Lmod\_up/ || $cntx =~ /AprepV\&[^ ]*\_down/ || $cntx =~ /Vmod\_up/) {
#      print  "$cntx $pal $f $ling\n";
#  }

   ##AdV                                                                                                                                              
#  if ( $cntx =~ /LmodA\_up/ || $cntx =~ /LmodV\_up/ || $cntx =~ /RmodV\_up/ ) {
#      print  "$cntx $pal $f $ling\n";
#  }

}

print STDERR "Done V.\n\n";
