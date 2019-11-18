#!/usr/bin/perl

# Identifica os cognatos de dous ficheiros taggeados em duas linguas e gera um ficheiro com os similar templates

#lê dous textos taggeados com FreeLing (pipe:ingles) (arg:galego). 
## hai que passar previamente o filtrar-tagger.perl (ou tree-tagger mais formateo em freeling)

#escreve uma lista de similar templates para ingles-galego

$th=500;

$file = shift(@ARGV);
open (FILE, $file) or die "O ficheiro não pode ser aberto: $!\n";

$countL1=0;
%L1;
while ($line = <STDIN>) {
       chop($line);
       print STDERR "$countL1\r";
       $countL1++;

       ($token, $lema, $tag) = split (" ", $line);

       ##NP = maiusculas:
       if ($tag =~  /^NNP/ || $tag =~  /^NP/ ){
	   $lema = $token;
           $tag ="N";
           $L1{$lema}{$tag}++;
      #     print STDERR "#$lema# - #$tag# -- #$L1{$lema}{$tag}#\n" if ($lema eq "Roma");
 
      }

}

print STDERR "leu o ficheiro da primeira lingua\n";


while ($line = <FILE>) {
       chop($line);
       print STDERR "$countL2\r";
       $countL2++;

       ($token, $lema, $tag) = split (" ", $line);

  ##NP = maiusculas:                                                                                                                                    
       if ($tag =~  /^NNP/ || $tag =~  /^NP/ ){
           $lema= $token;
           $tag ="N";
       #    print STDERR "#$lema# - #$tag# -- #$L1{$lema}{$tag}#\n" if ($lema eq "Roma");	  

          if ( ($L1{$lema}{$tag} >= $th) && (!$Found{$lema}{$tag}) ) {
            $Found{$lema}{$tag}++;
        #    print STDERR "#$lema# - #$tag#\n";	  

      ##regras de geraçao:

        ##regras para NOUNS em espanhol-galego
     

         if ($tag =~  /^N/ ){
 
      ##contextos nominais:

      printf "modN_down_%s Cprep\&de_down_%s\n", $lema, $lema; 
      printf "modN_up_%s Cprep\&de_up_%s\n", $lema, $lema; 

#      printf "Cprep\&of_down_%s Cprep\&de_down_%s\n", $lema, $lema;
#      printf "Cprep\&of_up_%s Cprep\&de_up_%s\n", $lema, $lema;

      printf "modN_down_%s Cprep\&de_down_%s\n", $lema, $lema;
      printf "modN_up_%s Cprep\&de_up_%s\n", $lema, $lema;

      preps ("Cprep", "down", $lema, $lema);
      preps ("Cprep", "up", $lema, $lema);

     
      ##contextos adjectivais:
      printf "Lmod_down_%s Lmod_down_%s\n", $lema, $lema;
      printf "Lmod_down_%s Rmod_down_%s\n", $lema, $lema;
      preps ("Aprep", "up", $lema, $lema);

     ##contextos verbais:
      printf "Subj_up_%s Subj_up_%s\n", $lema, $lema;

      printf "Dobj_up_%s Dobj_up_%s\n", $lema, $lema;

      preps ("Iobj", "up", $lema, $lema);
     
    }

      ##regras para ADJS em espanhol-galego
      elsif ($tag =~ /^ADJ/)  {


      ##contextos adjectivais:

      printf "Lmod_up_%s Lmod_up_%s\n", $lema, $lema;
      printf "Lmod_up_%s Rmod_up_%s\n", $lema, $lema;

      printf "LmodA_down_%s LmodA_down_%s\n", $lema, $lema;
      printf "Vmod_up_%s Vmod_up_%s\n", $lema, $lema;
      
      preps ("Aprep", "down", $lema, $lema);
      preps ("AprepV", "down", $lema, $lema);
    
    }

    

      ##contextos verbais:
    elsif ($tag =~ /^V/) {
      printf "Subj_down_%s Subj_down_%s\n", $lema, $lema;
      printf "Dobj_down_%s Dobj_down_%s\n", $lema, $lema;
      printf "SubjV_down_%s SubjV_down_%s\n", $lema, $lema;
      printf "SubjV_up_%s SubjV_up_%s\n", $lema, $lema;
      printf "DobjV_down_%s DobjV_down_%s\n", $lema, $lema;
      printf "DobjV_up_%s DobjV_up_%s\n", $lema, $lema;
      printf "Vmod_down_%s Vmod_down_%s\n", $lema, $lema;
      printf "RmodV_down_%s RmodV_down_%s\n", $lema, $lema;
      printf "LmodV_down_%s RmodV_down_%s\n", $lema, $lema; #immediatly came - vino inmediatamente
      printf "VmodV_down_%s VmodV_down_%s\n", $lema, $lema;
      printf "VmodV_up_%s VmodV_up_%s\n", $lema, $lema;

      preps ("Iobj", "down", $lema, $lema);
      preps ("IobjV", "down", $lema, $lema);
      preps ("IobjV", "up", $lema, $lema);
      
    }

     ##contextos adverbais:
    elsif ($tag =~ /^ADV/) {
      printf "LmodA_up_%s LmodA_up_%s\n", $lema, $lema;     
      printf "RmodV_up_%s RmodV_up_%s\n", $lema, $lema;
      printf "LmodV_up_%s RmodV_up_%s\n", $lema, $lema; #immediatly came - vino inmediatamente
    }  

  }

 }
}



sub preps {
    my ($r) = $_[0];
    my ($d) = $_[1];
    my ($p1) = $_[2];
    my ($p2) = $_[3];

      printf "$r\&from_$d\_%s $r\&de_$d\_%s\n", $p1, $p2;
      printf "$r\&from_$d\_%s $r\&desde_$d\_%s\n", $p1, $p2;
      printf "$r\&since_$d\_%s $r\&desde_$d\_%s\n", $p1, $p2;
      printf "$r\&about_$d\_%s $r\&de_$d\_%s\n", $p1, $p2;
      printf "$r\&with_$d\_%s $r\&con_$d\_%s\n", $p1, $p2;
      printf "$r\&in_$d\_%s $r\&en_$d\_%s\n", $p1, $p2;
      printf "$r\&into_$d\_%s $r\&en_$d\_%s\n", $p1, $p2;
      printf "$r\&at_$d\_%s $r\&en_$d\_%s\n", $p1, $p2;
      printf "$r\&for_$d\_%s $r\&para_$d\_%s\n", $p1, $p2;
      printf "$r\&for_$d\_%s $r\&durante_$d\_%s\n", $p1, $p2;
      printf "$r\&to_$d\_%s $r\&a_$d\_%s\n", $p1, $p2;
      printf "$r\&to_$d\_%s $r\&hasta_$d\_%s\n", $p1, $p2;
      printf "$r\&by_$d\_%s $r\&por_$d\_%s\n", $p1, $p2;
      printf "$r\&through_$d\_%s $r\&por_$d\_%s\n", $p1, $p2;
      printf "$r\&between_$d\_%s $r\&entre_$d\_%s\n", $p1, $p2;
      printf "$r\&on_$d\_%s $r\&sobre_$d\_%s\n", $p1, $p2;
      printf "$r\&upon_$d\_%s $r\&sobre_$d\_%s\n", $p1, $p2;
   return 1
}




