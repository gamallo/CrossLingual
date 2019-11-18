#!/usr/bin/perl 

#separar os nomes que sao nomes proprios (majusculas)


$arq_termos  = shift(@ARGV); #obtem parametro passado por linha de comando
open(TERMOS, $arq_termos) || die "Can't open search-patterns: $!\n";

$UpperCase = "[A-Z\301\311\315\323\332\307\303\325\302\312\324\300\310Ñ]" ;

##ler termos...
while ($line = <TERMOS>) {
  chop $line;
  ($termo, $tmp) =  split ("\t", $line) ;
  $termo =~ s/ /&/g;
  $DicoTermos{$termo}++ ;
 # print STDERR "TERMO:#$termo#\n";
  
}


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
     elsif ( ($pal =~ /^$UpperCase/) && (defined $DicoTermos{$pal}) ) {
    #   printf STDERR "nome: %s ; contexto %s\n", $pal, $cntx;
        print  "$cntx $pal $f $ling\n";
     }
  }
}

print STDERR "Done N.\n\n";
