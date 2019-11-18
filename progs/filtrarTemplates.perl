#!/usr/bin/perl

# LE O FICHEIRO COM TODOS OS CONTEXTOS E O FICHEIRO COM TODOS OS TEMPLATES E FILTRA OS TEMPLATES QUE NAO APARECEM NOS CONTEXTOS
#lê um ficheiro com todos os contextos (cntx pal freq) (pipe)
# o argumento é um ficheiro com os templates que vao ser seleccionados (arg)


$file = shift(@ARGV);

$L1= shift(@ARGV);
$L2= shift(@ARGV);

open (INPUT, $file) or die "O ficheiro não pode ser aberto: $!\n";




while ($line = <STDIN>) {
      chop($line);
      ($cntx, $pal, $freq, $ling) = split (" ", $line);
      $c1= $cntx . "\#" . $L1;
      $c2= $cntx . "\#" . $L2;
      #print STDERR "$c1 - $c2\n";

      $Cntx{$c1}++ ;
      $Cntx{$c2}++ ;
}

print STDERR "cargou ficheiros de frequencias\n";

$tmp="";
$prob="";
while ($line = <INPUT>) {
      chop($line);
      ($tmp, $cntx1, $cntx2, $prob) = split (" ", $line);
      

      if (defined $Cntx{$cntx1} && defined $Cntx{$cntx2}) {
        print "$line\n";
      }
}



print STDERR "foi gerado o ficheiro dos templates filtrado\n";
