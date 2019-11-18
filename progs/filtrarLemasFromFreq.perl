#!/usr/bin/perl

# LE O FICHEIRO FREQ E FILTRA OS PARES QUE TENHAM OS LEMAS QUE APARECEM NO FICHEIRO DE LEMAS
#pensado para freqs criadas com windows: N_pal V_pal freq


#lê um ficheiro com todos os freqs (cntx pal freq) (pipe) e um ficheiro de termos (arg)


$file = shift(@ARGV);
open (FILE, $file) or die "O ficheiro n%Gï¿½%@ pode ser aberto: $!\n";

$tmp="";
while ($line = <FILE>) {
      chomp($line);
      ($lema, $tmp) = split (" ", $line) ;
      
      $Lemas{$lema}++
}

while ($line = <STDIN>) {
      chomp($line);
      ($cntx, $word, $freq) = split (" ", $line);
      
      ($tmp, $c) = split ("_", $cntx);
      ($w, $tmp) = split ("_", $word);
      
     # print STDERR "$c -- $w\n";
      if  ( (defined $Lemas{$w}) && (defined $Lemas{$c}) )  {
         print "$line\n";
       }
}


