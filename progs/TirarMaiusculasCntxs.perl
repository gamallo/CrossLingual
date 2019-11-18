#!/usr/bin/perl -w

##Chama a funçao UpperLowerCase para tirar 
##as maiusculas as palavras dos contextos

##use progs::funcoes::funcoesBasicas


while ($line = <>) { 
   chomp $line;
  ($cntx, $pal, $f, $ling) = split(" ", $line);

  if ($ling ne "") {
 
    $tmp = lc ($cntx);

    $tmp =~ s/^robj\_/Robj\_/;
    $tmp =~ s/^lobj\_/Lobj\_/;
    $tmp =~ s/^rmod\_/Rmod\_/;
    $tmp =~ s/^lmod\_/Lmod\_/;
    $tmp =~ s/^modn\_/modN\_/;  
    $tmp =~ s/\_card /\_CARD /;  
    $cntx = $tmp;
  
    print "$cntx $pal $f $ling\n" ;
  }
}

print STDERR "Done.\n\n";

