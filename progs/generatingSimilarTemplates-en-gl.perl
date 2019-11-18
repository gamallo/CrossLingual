#!/usr/bin/perl

# LE UM FICHEIRO: O DXI DO OPENTRAD. DEVOLVE UMA LISTA DE TEMPLATES POTENCIAIS USANDO REGRAS ESPECIFICAS PARA OS NOMES DE DUAS LINGUAS: ESPANHOL-INGLES. 


#lê o ficheiro dxi em xml: <i> <l><r> ... (pipe)

#open (INPUT, $file) or die "O ficheiro não pode ser aberto: $!\n";
#use strict;
use locale;
use POSIX;
#use lib "/home/gamallo/BilingualExtraction/progs/funcoes" ;
#use funcoesBasicas
 
setlocale(LC_CTYPE,"es_ES");


$count=0;
while ($line = <STDIN>) {
      chop($line);
      ($tmp1, $tmp2, $tag) = split (" ", $line);
      $pal1 = UpperToLower ($tmp1);
      $pal2 = UpperToLower ($tmp2);
         
      print STDERR  "##$pal1##, ##$pal2##, ##$tag##\n";
      $count++;  
    
    ##regras para NOUNS em espanhol-galego
    if ( ($pal1 ne "") && ($pal2 ne "") ) {
      
      if ($tag =~  /^N/ ){

      ##contextos nominais:

      printf "modN_down_%s de_down_%s\n", $pal1, $pal2; 
      printf "modN_up_%s de_up_%s\n", $pal1, $pal2; 

      printf "of_down_%s de_down_%s\n", $pal1, $pal2;
      printf "of_up_%s de_up_%s\n", $pal1, $pal2;

      printf "from_down_%s de_down_%s\n", $pal1, $pal2;
      printf "from_up_%s de_up_%s\n", $pal1, $pal2;

      printf "from_down_%s desde_down_%s\n", $pal1, $pal2;
      printf "from_up_%s desde_up_%s\n", $pal1, $pal2;

      printf "since_down_%s desde_down_%s\n", $pal1, $pal2;
      printf "since_up_%s desde_up_%s\n", $pal1, $pal2;

      printf "about_down_%s de_down_%s\n", $pal1, $pal2;
      printf "about_up_%s de_up_%s\n", $pal1, $pal2;

      printf "with_down_%s con_down_%s\n", $pal1, $pal2;
      printf "with_up_%s con_up_%s\n", $pal1, $pal2;

      printf "in_down_%s en_down_%s\n", $pal1, $pal2;
      printf "in_up_%s en_up_%s\n", $pal1, $pal2;

      printf "into_down_%s en_down_%s\n", $pal1, $pal2;
      printf "into_up_%s en_up_%s\n", $pal1, $pal2;

      printf "at_down_%s en_down_%s\n", $pal1, $pal2;
      printf "at_up_%s en_up_%s\n", $pal1, $pal2;

      printf "for_down_%s para_down_%s\n", $pal1, $pal2;
      printf "for_up_%s para_up_%s\n", $pal1, $pal2;

      printf "for_down_%s durante_down_%s\n", $pal1, $pal2;
      printf "for_up_%s durante_up_%s\n", $pal1, $pal2;

      printf "to_down_%s a_down_%s\n", $pal1, $pal2;
      printf "to_up_%s a_up_%s\n", $pal1, $pal2;

      printf "to_down_%s ata_down_%s\n", $pal1, $pal2;
      printf "to_up_%s ata_up_%s\n", $pal1, $pal2;

      printf "by_down_%s por_down_%s\n", $pal1, $pal2;
      printf "by_up_%s por_up_%s\n", $pal1, $pal2;

      printf "through_down_%s por_down_%s\n", $pal1, $pal2;
      printf "through_up_%s por_up_%s\n", $pal1, $pal2;

      printf "between_down_%s entre_down_%s\n", $pal1, $pal2;
      printf "between_up_%s entre_up_%s\n", $pal1, $pal2;

      printf "on_down_%s sobre_down_%s\n", $pal1, $pal2;
      printf "on_up_%s sobre_up_%s\n", $pal1, $pal2;

      




      ##contextos adjectivais:
      printf "Lmod_down_%s Lmod_down_%s\n", $pal1, $pal2;
      printf "Lmod_down_%s Rmod_down_%s\n", $pal1, $pal2;

     ##contextos verbais:
      #printf "Lobj_down_%s Lobj_down_%s\n", $pal, $pal;
      printf "Lobj_up_%s Lobj_up_%s\n", $pal1, $pal2;

      #printf "Robj_down_%s Robj_down_%s\n", $pal, $pal;
      printf "Robj_up_%s Robj_up_%s\n", $pal1, $pal2;


      printf "iobj&of_up_%s iobj&de_up_%s\n", $pal1, $pal2;

      printf "iobj&from_up_%s iobj&de_up_%s\n", $pal1, $pal2;

      printf "iobj&from_up_%s iobj&desde_up_%s\n", $pal1, $pal2;

      printf "iobj&since_up_%s iobj&desde_up_%s\n", $pal1, $pal2;

      printf "iobj&about_up_%s iobj&de_up_%s\n", $pal1, $pal2;

      printf "iobj&in_up_%s iobj&en_up_%s\n", $pal1, $pal2;

      printf "iobj&at_up_%s iobj&en_up_%s\n", $pal1, $pal2;

      printf "iobj&into_down_%s iobj&en_down_%s\n", $pal1, $pal2;

      printf "iobj&by_up_%s iobj&por_up_%s\n", $pal1, $pal2;

      printf "iobj&through_up_%s iobj&por_up_%s\n", $pal1, $pal2;

      printf "iobj&to_up_%s iobj&a_up_%s\n", $pal1, $pal2;

      printf "iobj&to_up_%s iobj&ata_up_%s\n", $pal1, $pal2;
       
      printf "iobj&between_up_%s iobj&entre_up_%s\n", $pal1, $pal2;
 
      printf "iobj&for_up_%s iobj&para_up_%s\n", $pal1, $pal2;

      printf "iobj&for_up_%s iobj&durante_up_%s\n", $pal1, $pal2;

      printf "iobj&with_up_%s iobj&con_up_%s\n", $pal1, $pal2;

      printf "iobj&on_up_%s iobj&sobre_up_%s\n", $pal1, $pal2;

      printf "iobj&upon_up_%s iobj&sobre_up_%s\n", $pal1, $pal2;
    

    }



      ##regras para ADJS em espanhol-galego
      elsif ($tag =~ /^ADJ/)  {


      ##contextos adjectivais:

      printf "Lmod_up_%s Lmod_up_%s\n", $pal1, $pal2;
      printf "Lmod_up_%s Rmod_up_%s\n", $pal1, $pal2;
    }

      ##contextos verbais:
      elsif ($tag =~ /^V/) {
      printf "Lobj_down_%s Lobj_down_%s\n", $pal1, $pal2;

      printf "Robj_down_%s Robj_down_%s\n", $pal1, $pal2;

     
      printf "iobj&of_down_%s iobj&de_down_%s\n", $pal1, $pal2;

      printf "iobj&from_down_%s iobj&de_down_%s\n", $pal1, $pal2;

      printf "iobj&from_down_%s iobj&desde_down_%s\n", $pal1, $pal2;

      printf "iobj&since_down_%s iobj&desde_down_%s\n", $pal1, $pal2;

      printf "iobj&about_down_%s iobj&de_down_%s\n", $pal1, $pal2;

      printf "iobj&in_down_%s iobj&en_down_%s\n", $pal1, $pal2;

      printf "iobj&at_down_%s iobj&en_down_%s\n", $pal1, $pal2;

      printf "iobj&into_down_%s iobj&en_down_%s\n", $pal1, $pal2;

      printf "iobj&by_down_%s iobj&por_down_%s\n", $pal1, $pal2;

      printf "iobj&through_down_%s iobj&por_down_%s\n", $pal1, $pal2;

      printf "iobj&to_down_%s iobj&a_down_%s\n", $pal1, $pal2;

      printf "iobj&to_down_%s iobj&ata_down_%s\n", $pal1, $pal2;
       
      printf "iobj&between_down_%s iobj&entre_down_%s\n", $pal1, $pal2;
 
      printf "iobj&for_down_%s iobj&para_down_%s\n", $pal1, $pal2;
      
      printf "iobj&for_down_%s iobj&durante_down_%s\n", $pal1, $pal2;      

      printf "iobj&with_down_%s iobj&con_down_%s\n", $pal1, $pal2;

      printf "iobj&on_down_%s iobj&sobre_down_%s\n", $pal1, $pal2;

      printf "iobj&upon_down_%s iobj&sobre_down_%s\n", $pal1, $pal2;

     

    }
   }
  
}

print STDERR "num. palavras do dico: $count\n";


print STDERR "ficheiro gerado\n";




sub UpperToLower {
    local ($l) = @_;
     $l =~tr/A-Z/a-z/;
     $l =~tr/Ñ/ñ/;
     $l =~tr/\301\311\315\323\332\307\303\325\302\312\324\300\310/\341\351\355\363\372\347\343\365\342\352\364\340\350/;
     return $l;
}


