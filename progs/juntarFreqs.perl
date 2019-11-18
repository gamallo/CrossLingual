#!/usr/bin/perl

# LE 2 OU MAIS FICHEIROS DE FREQS (templates) E JUNTA-OS EM 1
#lê ficheiros de freqs (cntx pal freq) (pipe)


$CountLines=0;
while ($line = <STDIN>) {
      if ( ($CountLines % 100) == 0) {;
         printf  STDERR "- - - processar linha:(%6d) - - -\r",$CountLines;
      }
      $CountLines++;
      chop($line);
      ($cntx, $pal, $freq) = split (" ", $line);

      $Dico{$cntx}{$pal} += $freq ;

}

print STDERR "os ficheiros forom carregados num hash\n";

foreach $c (keys %Dico) {
  foreach $p (keys %{$Dico{$c}}) {
  
     print "$c $p $Dico{$c}{$p}\n";
     
  }
}

print STDERR "foi gerado o ficheiro unico de freqs\n";
