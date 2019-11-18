#!/usr/bin/perl

# LE O FICHEIRO COM TODOS OS CONTEXTOS E SELECCIONA OS TEMPLATES QUE SERVIRAO PARA FAZER A EXTRACÇAO TESAURICA
#lê um ficheiro com todos os contextos (cntx pal freq) (pipe)
# o argumento é um ficheiro com os templates que vao ser seleccionados (arg)


$file = shift(@ARGV);

$L1= shift(@ARGV);
$L2= shift(@ARGV);

open (INPUT, $file) or die "O ficheiro de seeds não pode ser aberto: $!\n";
#open (OUTPUT, ">bigramas.txt");

$tmp="";
while ($line = <INPUT>) {
      chop($line);
      ($tmp, $cntx1, $cntx2, $prob) = split (" ", $line);
      $Template1{$cntx1}{$cntx2}++;
      $Template2{$cntx2}{$cntx1}++;
      #print STDERR "$Template{$cntx2}\n";
}

while ($line = <STDIN>) {
      chop($line);
      ($cntx, $pal, $freq, $ling) = split (" ", $line);
      $c1= $cntx . "\#" . $L1;
      $c2= $cntx . "\#" . $L2;
      #print STDERR "$c1 - $c2\n";
      if ( (defined $Template1{$c1}) && ($ling eq $L1) ) {
        # print STDERR "$c1 -- $pal == $count\n";
         $count++;
         foreach $translation  (keys %{ $Template1{$c1} }) {
            printf "%s\;%s %s %d\n", $c1, $translation, $pal, $freq;
	 }
      }
      elsif ( (defined $Template2{$c2}) && ($ling eq $L2) ) {
          #print STDERR "yessss\n";
         foreach $translation  (keys %{ $Template2{$c2} }) {
            printf "%s\;%s %s %d\n",  $translation, $c2,  $pal, $freq;
         }
      }

}


print STDERR "foi gerado o ficheiro dos templates\n";
