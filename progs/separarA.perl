#!/usr/bin/perl 

#
#  Separa o ficheiro de atributos em contextos adjectivais
# 
#
#  Modifs:
#     - 30/12/2006 
#






while ($line = <STDIN>) { #le cada linha do arquivo
   chomp $line;
  ($cntx, $pal, $f, $ling) = split(" ", $line);
 
  
     if ( ($cntx =~ /Rmod_down/) || ($cntx =~ /Lmod_down/) ) { 
    #  printf STDERR "adj: %s ; contexto %s\n", $pal, $cntx; 
      print  "$cntx $pal $f $ling\n";
     }
  
  
}

print STDERR "Done.\n\n";
