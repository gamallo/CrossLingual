#!/usr/bin/perl 

#
#  Separa o ficheiro de atributos em 3 conjuntos,
#  onde cada conjunto uma categoria: Adjs Nomes e Verbos
#
#  Modifs:
#     - 19fev2003 - modif a relação adj (down<-->up)
#

$PART=shift(@ARGV);

$pref="./tmp/__separadoN_";

###$letter="a"
#open $output[$letter], ">$pref$letter" or die "nao consegui abrir para escrita $letter!";

for $letter ("a".."z") {
  open $output{$letter}, ">$pref$letter" or die "nao consegui abrir para escrita $letter!";
}

for $letter ("A".."Z") {
    open $output{$letter}, ">$pref$letter" or die "nao consegui abrir para escrita $letter!";
}
$letter="á";
open $output{$letter}, ">$pref$letter" or die "nao consegui abrir para escrita $letter!";

while ($line = <STDIN>) { #le cada linha do arquivo
   chomp $line;
  ($cntx, $pal, $f) = split(" ", $line);
     
  #print STDERR "$cntx -- $pal --- $f \n";
 ##Noun
  if ( $cntx =~ /Dobj\_down/ || $cntx =~ /Iobj\&[^_]*\_down/ || $cntx =~ /Subj\_down/ ||
       $cntx =~ /Aprep\&[^_]*\_down/ || $cntx =~ /[LR]mod\_up/ || $cntx =~ /Cprep\&[^_]*\_(up|down)/ ||
       $cntx =~ /modN\_(up|down)/ ) {  
      ($letter) = $pal =~ /^([\w])/;

     if ($letter =~ /[a-zA-Z]/) {
#	 print STDERR "#$letter#\n";        
       print { $output{$letter} }   "$cntx $pal $f\n";
     }
     else {
	 $letter="á";
	 
         print { $output{$letter} }   "$cntx $pal $f\n";
     }
  }
   print STDERR "$k\r";  
   $k++;
##V
#  elsif (
#        $cntx =~ /Dobj\_down/ || $cntx =~ /Iobj\&[^ ]*\_down/ || $cntx =~ /Subj\_down/ ||
#        $cntx =~ /DobjV\_(up|down)/ || $cntx =~ /IobjV\&[^ ]*\_(up|down)/ || $cntx =~ /SubjV\_(up|down)/ ||
#        $cntx =~ /Vmod\_down/ || $cntx =~ /RmodV\_down/ || $cntx =~ /LmodV\_down/ || $cntx =~ /VmodV\_(up|down)/ ) {

#          print  "$cntx $pal $f $ling\n";
#  }

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

print STDERR "Done N.\n\n";
