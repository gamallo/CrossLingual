#!/usr/bin/perl

# Identifica os cognatos de dous ficheiros taggeados em duas linguas e gera um ficheiro com os similar templates

#lê dous textos taggeados com FreeLing (pipe:ingles) (arg:galego). 
## hai que passar previamente o filtrar-tagger.perl (ou tree-tagger mais formateo em freeling)

#escreve uma lista de similar templates para ingles-galego

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

        printf "modN_down_%s de_down_%s\n", $lema, $lema; 
      printf "modN_up_%s de_up_%s\n", $lema, $lema; 

      printf "of_down_%s de_down_%s\n", $lema, $lema;
      printf "of_up_%s de_up_%s\n", $lema, $lema;

      printf "from_down_%s de_down_%s\n", $lema, $lema;
      printf "from_up_%s de_up_%s\n", $lema, $lema;

      printf "from_down_%s desde_down_%s\n", $lema, $lema;
      printf "from_up_%s desde_up_%s\n", $lema, $lema;

      printf "since_down_%s desde_down_%s\n", $lema, $lema;
      printf "since_up_%s desde_up_%s\n", $lema, $lema;

      printf "about_down_%s de_down_%s\n", $lema, $lema;
      printf "about_up_%s de_up_%s\n", $lema, $lema;

      printf "with_down_%s con_down_%s\n", $lema, $lema;
      printf "with_up_%s con_up_%s\n", $lema, $lema;

      printf "in_down_%s en_down_%s\n", $lema, $lema;
      printf "in_up_%s en_up_%s\n", $lema, $lema;

      printf "into_down_%s en_down_%s\n", $lema, $lema;
      printf "into_up_%s en_up_%s\n", $lema, $lema;

      printf "at_down_%s en_down_%s\n", $lema, $lema;
      printf "at_up_%s en_up_%s\n", $lema, $lema;

      printf "for_down_%s para_down_%s\n", $lema, $lema;
      printf "for_up_%s para_up_%s\n", $lema, $lema;

      printf "for_down_%s durante_down_%s\n", $lema, $lema;
      printf "for_up_%s durante_up_%s\n", $lema, $lema;

      printf "to_down_%s a_down_%s\n", $lema, $lema;
      printf "to_up_%s a_up_%s\n", $lema, $lema;

      printf "to_down_%s ata_down_%s\n", $lema, $lema;
      printf "to_up_%s ata_up_%s\n", $lema, $lema;

      printf "by_down_%s por_down_%s\n", $lema, $lema;
      printf "by_up_%s por_up_%s\n", $lema, $lema;

      printf "through_down_%s por_down_%s\n", $lema, $lema;
      printf "through_up_%s por_up_%s\n", $lema, $lema;

      printf "between_down_%s entre_down_%s\n", $lema, $lema;
      printf "between_up_%s entre_up_%s\n", $lema, $lema;

      printf "on_down_%s sobre_down_%s\n", $lema, $lema;
      printf "on_up_%s sobre_up_%s\n", $lema, $lema;

      




      ##contextos adjectivais:
      printf "Lmod_down_%s Lmod_down_%s\n", $lema, $lema;
      printf "Lmod_down_%s Rmod_down_%s\n", $lema, $lema;

     ##contextos verbais:
      #printf "Lobj_down_%s Lobj_down_%s\n", $pal, $pal;
      printf "Lobj_up_%s Lobj_up_%s\n", $lema, $lema;

      #printf "Robj_down_%s Robj_down_%s\n", $pal, $pal;
      printf "Robj_up_%s Robj_up_%s\n", $lema, $lema;


      printf "iobj&of_up_%s iobj&de_up_%s\n", $lema, $lema;

      printf "iobj&from_up_%s iobj&de_up_%s\n", $lema, $lema;

      printf "iobj&from_up_%s iobj&desde_up_%s\n", $lema, $lema;

      printf "iobj&since_up_%s iobj&desde_up_%s\n", $lema, $lema;

      printf "iobj&about_up_%s iobj&de_up_%s\n", $lema, $lema;

      printf "iobj&in_up_%s iobj&en_up_%s\n", $lema, $lema;

      printf "iobj&at_up_%s iobj&en_up_%s\n", $lema, $lema;

      printf "iobj&into_down_%s iobj&en_down_%s\n", $lema, $lema;

      printf "iobj&by_up_%s iobj&por_up_%s\n", $lema, $lema;

      printf "iobj&through_up_%s iobj&por_up_%s\n", $lema, $lema;

      printf "iobj&to_up_%s iobj&a_up_%s\n", $lema, $lema;

      printf "iobj&to_up_%s iobj&ata_up_%s\n", $lema, $lema;
       
      printf "iobj&between_up_%s iobj&entre_up_%s\n", $lema, $lema;
 
      printf "iobj&for_up_%s iobj&para_up_%s\n", $lema, $lema;

      printf "iobj&for_up_%s iobj&durante_up_%s\n", $lema, $lema;

      printf "iobj&with_up_%s iobj&con_up_%s\n", $lema, $lema;

      printf "iobj&on_up_%s iobj&sobre_up_%s\n", $lema, $lema;

      printf "iobj&upon_up_%s iobj&sobre_up_%s\n", $lema, $lema;
    

    }



      ##regras para ADJS em espanhol-galego
      elsif ($tag =~ /^ADJ/)  {


      ##contextos adjectivais:

      printf "Lmod_up_%s Lmod_up_%s\n", $lema, $lema;
      printf "Lmod_up_%s Rmod_up_%s\n", $lema, $lema;
    }

      ##contextos verbais:
      elsif ($tag =~ /^V/) {
      printf "Lobj_down_%s Lobj_down_%s\n", $lema, $lema;

      printf "Robj_down_%s Robj_down_%s\n", $lema, $lema;

     
      printf "iobj&of_down_%s iobj&de_down_%s\n", $lema, $lema;

      printf "iobj&from_down_%s iobj&de_down_%s\n", $lema, $lema;

      printf "iobj&from_down_%s iobj&desde_down_%s\n", $lema, $lema;

      printf "iobj&since_down_%s iobj&desde_down_%s\n", $lema, $lema;

      printf "iobj&about_down_%s iobj&de_down_%s\n", $lema, $lema;

      printf "iobj&in_down_%s iobj&en_down_%s\n", $lema, $lema;

      printf "iobj&at_down_%s iobj&en_down_%s\n", $lema, $lema;

      printf "iobj&into_down_%s iobj&en_down_%s\n", $lema, $lema;

      printf "iobj&by_down_%s iobj&por_down_%s\n", $lema, $lema;

      printf "iobj&through_down_%s iobj&por_down_%s\n", $lema, $lema;

      printf "iobj&to_down_%s iobj&a_down_%s\n", $lema, $lema;

      printf "iobj&to_down_%s iobj&ata_down_%s\n", $lema, $lema;
       
      printf "iobj&between_down_%s iobj&entre_down_%s\n", $lema, $lema;
 
      printf "iobj&for_down_%s iobj&para_down_%s\n", $lema, $lema;
      
      printf "iobj&for_down_%s iobj&durante_down_%s\n", $lema, $lema;      

      printf "iobj&with_down_%s iobj&con_down_%s\n", $lema, $lema;

      printf "iobj&on_down_%s iobj&sobre_down_%s\n", $lema, $lema;

      printf "iobj&upon_down_%s iobj&sobre_down_%s\n", $lema, $lema;


      }
   }
}



