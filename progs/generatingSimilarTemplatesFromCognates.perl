#!/usr/bin/perl

# Identifica os cognatos de dous ficheiros taggeados em duas linguas e gera um ficheiro com os similar templates

#lê dous textos taggeados com FreeLing (pipe:espanhol) (arg:galego). 
## hai que passar previamente o filtrar-tagger.perl

#escreve uma lista de similar templates para espanhol-galego

$th=1;


$file = shift(@ARGV);
open (FILE, $file) or die "O ficheiro não pode ser aberto: $!\n";

$countL1=0;
while ($line = <STDIN>) {
       chop($line);
       print STDERR "$countL1\r";
       $countL1++;

       ($token, $lema, $tag) = split (" ", $line);

       if  ($tag =~  /^N/ ){
           $tag = "N";
       }
       elsif ( ($tag =~ /^ADJ/) || ($tag =~ /^JJ/) || ($tag =~ /^AQ/) )  {
           
          $tag = "ADJ";
       }
       elsif ($tag =~  /^V/ ){
           $tag = "V";
       }

       $L1{$lema}{$tag}++;
}

print STDERR "leu o ficheiro da primeira lingua\n";


while ($line = <FILE>) {
       chop($line);
       print STDERR "$countL2\r";
       $countL2++;

       ($token, $lema, $tag) = split (" ", $line);
       if  ($tag =~  /^N/ ){
           $tag = "N";
       }
       elsif ( ($tag =~ /^ADJ/) || ($tag =~ /^JJ/) || ($tag =~ /^AQ/) )  {
           
          $tag = "ADJ";
       }
       elsif ($tag =~  /^V/ ){
           $tag = "V";
       }

       if ( ($L1{$lema}{$tag} > $th) && (!$Found{$lema}{$tag}) ) {
        $Found{$lema}{$tag}++;
      

      ##regras de geraçao:

        ##regras para NOUNS em espanhol-galego
     

      if ($tag =~  /^N/ ){

      ##contextos nominais:

      printf "modN_down_%s modN_down_%s\n", $lema, $lema; 
      printf "modN_up_%s modN_up_%s\n", $lema, $lema; 

      printf "de_down_%s de_down_%s\n", $lema, $lema;
      printf "de_up_%s de_up_%s\n", $lema, $lema;

      printf "con_down_%s con_down_%s\n", $lema, $lema;
      printf "con_up_%s con_up_%s\n", $lema, $lema;

      printf "en_down_%s en_down_%s\n", $lema, $lema;
      printf "en_up_%s en_up_%s\n", $lema, $lema;

      printf "para_down_%s para_down_%s\n", $lema, $lema;
      printf "para_up_%s para_up_%s\n", $lema, $lema;

      printf "a_down_%s a_down_%s\n", $lema, $lema;
      printf "a_up_%s a_up_%s\n", $lema, $lema;

      printf "por_down_%s por_down_%s\n", $lema, $lema;
      printf "por_up_%s por_up_%s\n", $lema, $lema;

      printf "entre_down_%s entre_down_%s\n", $lema, $lema;
      printf "entre_up_%s entre_up_%s\n", $lema, $lema;

      printf "sobre_down_%s sobre_down_%s\n", $lema, $lema;
      printf "sobre_up_%s sobre_up_%s\n", $lema, $lema;

      

      ##contextos adjectivais:
      printf "Lmod_down_%s Lmod_down_%s\n", $lema, $lema;
      printf "Rmod_down_%s Rmod_down_%s\n", $lema, $lema;

     ##contextos verbais:
      
      printf "Lobj_up_%s Lobj_up_%s\n", $lema, $lema;
      printf "Robj_up_%s Robj_up_%s\n", $lema, $lema;


      printf "iobj&de_up_%s iobj&de_up_%s\n", $lema, $lema;

      printf "iobj&en_up_%s iobj&en_up_%s\n", $lema, $lema;

      printf "iobj&por_up_%s iobj&por_up_%s\n", $lema, $lema;

      printf "iobj&a_up_%s iobj&a_up_%s\n", $lema, $lema;
       
      printf "iobj&sobre_up_%s iobj&sobre_up_%s\n", $lema, $lema;
 
      printf "iobj&para_up_%s iobj&para_up_%s\n", $lema, $lema;

      printf "iobj&con_up_%s iobj&con_up_%s\n", $lema, $lema;
    }



      ##regras para ADJS em espanhol-galego
      elsif ( ($tag =~ /^ADJ/) || ($tag =~ /^JJ/) )  {


      ##contextos adjectivais:

         printf "Lmod_up_%s Lmod_up_%s\n", $lema, $lema;
         printf "Rmod_up_%s Rmod_up_%s\n", $lema, $lema;
      }

      ##regras para verbos:
      elsif ($tag =~ /^V/) {
        printf "Lobj_down_%s Lobj_down_%s\n", $lema, $lema;

        printf "Robj_down_%s Robj_down_%s\n", $lema, $lema;


        printf "iobj&de_down_%s iobj&de_down_%s\n", $lema, $lema;

        printf "iobj&en_down_%s iobj&en_down_%s\n", $lema, $lema;

        printf "iobj&por_down_%s iobj&por_down_%s\n", $lema, $lema;

        printf "iobj&a_down_%s iobj&a_down_%s\n", $lema, $lema;
       
        printf "iobj&sobre_down_%s iobj&sobre_down_%s\n", $lema, $lema;
 
        printf "iobj&para_down_%s iobj&para_down_%s\n", $lema, $lema;

        printf "iobj&con_down_%s iobj&con_down_%s\n", $lema, $lema;
      }
   }
}



