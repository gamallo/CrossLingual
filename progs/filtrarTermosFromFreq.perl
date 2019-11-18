#!/usr/bin/perl

# LE O FICHEIRO FREQ E FILTRA OS PARES QUE TENHAM OS TERMOS QUE APARECEM NO FICHEIRO DE TERMOS



#lê um ficheiro com todos os freqs (cntx pal freq) (pipe) e um ficheiro de termos (arg)


$file = shift(@ARGV);
open (FILE, $file) or die "O ficheiro n%Gï¿½%@ pode ser aberto: $!\n";

$tmp="";
while ($line = <FILE>) {
      chomp($line);
      ($term, $tmp) = split ("\t", $line);
      $term =~ s/ /&/g;
      $Terms{$term}++
}

while ($line = <STDIN>) {
      chomp($line);
      ($cntx, $word, $freq) = split (" ", $line);
      
      if  (defined $Terms{$word}) {
         print "$line\n";
       }
}


