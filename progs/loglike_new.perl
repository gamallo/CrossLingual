#!/usr/bin/perl


#
#
#  Esta versao contem erro... (ver abaixo)
#
#



#
# input:   ficheiro com atributo palavra freq 
# output:  lista informação_mutua(contexto, palavra)
#

$file = shift(@ARGV);
open (FILE, $file) or die "O ficheiro nom pode ser aberto: $!\n";


$debug=1;

while (<STDIN>) {
  chop $_;
  $line = trim($_);

  ($cntx, $word, $freq) = split(/ /, $line);

 #  $cntxWord{$cntx}{$word}=$freq;
   $cntxFreq{$cntx} += $freq;
   $wordFreq{$word} += $freq;

   $Diff{$cntx}++;

   $totalFreq += $freq;

   printf STDERR "<%7d>\r",$cont if ($cont++ % 2500 == 0);

}

$N = $totalFreq;

while ($line = <FILE>) {
    chomp $line;
    $line = trim($line);

    ($cntx, $word, $freq) = split(/ /, $line);


     #$a = $cntxWord{$cntx}{$word};
     $a = $freq;
     $b = $cntxFreq{$cntx} - $a;
     $c = $wordFreq{$word} - $a;
     $d = $N - $a - $b -$c;

     printf STDERR "<%7d>\r",$cont if ($cont-- % 2500 == 0);

    $baux = ($b==0)?0:($b*log($b));
    $caux = ($c==0)?0:($c*log($c));

     $llike = $a*log($a)             +
              $baux                  +
              $caux                  +
              $d*log($d)             +
              $N*log($N)             -
              ($a+$c)*log($a+$c)     -
              ($a+$b)*log($a+$b)     -
              ($b+$d)*log($b+$d)     -
              ($c+$d)*log($c+$d);


     $llike = $llike / $Diff{$cntx};
#     printf STDERR  "%s %s n=%d a=%d b=%d c=%d d=%d llike=%f\n",$cntx, $word, $N, $a, $b, $c, $d, $llike if ($debug);
     printf "%s %s %f\n",$cntx, $word, $llike;


}


sub trim {    #remove all leading and trailing spaces
  local ($str) = @_[0];

  $str =~ s/^\s*(.*\S)\s*$/$1/;
  return $str;
}


