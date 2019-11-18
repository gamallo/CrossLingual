#!/usr/bin/perl -w

use progs::funcoes::funcoesBasicas


$Upper = "[A-ZÑ\301\311\315\323\332\307\303\325\302\312\324\300\310]" ;
#$Lower = "[a-zñ\341\351\355\363\372\347\343\365\342\352\364\340\350]";

while ($line = <STDIN>) {
   
  if ($line =~ /${Upper}${Upper}/) {
       $lineMod =  UpperToLower ($line);
       print $lineMod ;
   }
  else {
      print $line;
    }
}
