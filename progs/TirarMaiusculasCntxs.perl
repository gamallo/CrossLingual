#!/usr/bin/perl -w

##Chama a funçao UpperLowerCase para tirar 
##as maiusculas as palavras dos contextos

##use progs::funcoes::funcoesBasicas


while ($line = <>) { 
   chomp $line;
  ($cntx, $pal, $f, $ling) = split(" ", $line);

  if ($ling ne "") {
 
    $tmp = lc ($cntx);
    
    $tmp =~ s/\_card /\_CARD /;  
    $tmp = ucfirst $tmp;
    $tmp =~ s/^Modn\_/modN\_/;  

    $cntx = $tmp;
  
    print "$cntx $pal $f $ling\n" ;
  }
}

print STDERR "Done.\n\n";

