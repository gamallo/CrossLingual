#!/usr/bin/perl -w


$arq = shift(@ARGV);
open(PFILE, $arq) || die "Can't open search-patterns: $!\n";

#$CARD = shift(@ARGV); # recomendado: 1

$mycount=0;

while ($line = <PFILE>) {
  chop $line;
  ($atributo, $objecto, $freq) = split (" ", $line);

  $objecto = lcfirst $objecto;

  $dic{$objecto}{$atributo} = $freq;
 # $freqObj{$objecto} += $freq;
  $Obj{$objecto}++;
 # $freqAtr{$atributo} += $freq;
  $nrels++;


  $mycount++;
  if ($mycount % 1000 == 0) {
     printf STDERR "leu freqs: %10d\r",$mycount;
   }
}

$mycount = 0;
printf STDERR "\nCarregou frequencias, calcula peso global...\n";



printf STDERR "\nInfos calculadas ... nrels = %d\n",$nrels;

$mycount=0;

while (<>) {
  chop $_;
  ($obj1_orig, $obj2_orig) = split (" ", $_);
 
  $obj1 = lcfirst $obj1_orig;
  $obj2 = lcfirst $obj2_orig;
  $mycount++;
  if ($mycount % 1000 == 0) {
     printf STDERR "count: %10d\r",$mycount;
  }
#  $obj1 = lc $obj1;
#  $obj2 = lc $obj2;

 # $diceBin = 0;
 # $diceMin = 0;
  $cosineBin=0;

 # $rels = "";
 # $min = 0;
 # $max = 0;
 # $sum_intersection = 0;
 # $intersection = 0;
  $baseline = 0; 


  foreach $atr (keys %{ $dic{$obj1} }) {
 
#    $assoc1 = 0;
#    $assoc2 = 0;
    ##buscar atributos comuns
    if (defined $dic{$obj2}{$atr}) {
          $baseline++ ;

  #       $rels = $rels . "|" . $atr ;
#         $assoc1 = $dic{$obj1}{$atr} ;
#         $assoc2 = $dic{$obj2}{$atr} ;



 #        $min += Min ($assoc1, $assoc2) ;
#         $max += Max ($assoc1, $assoc2) ;



#         $intersection += $assoc1 *  $assoc2 ;
 #        $sum_intersection += $assoc1 + $assoc2 ;
     }

  #  elsif (defined $dic{$obj1}{$atr}) {
#	$max += $dic{$obj1}{$atr} ;

 #   }

  }

 # foreach $atr2 (keys %{ $dic{$obj2} }) {
 #    if (!defined $dic{$obj1}{$atr2} ) {
 #        $max += $dic{$obj2}{$atr2} ;

  #   }
  #}


   ##computar formulas finais:

  ##diceBin diceMin:



 
  ##diceBin, cosineBin, $jaccard
  if ( (defined $Obj{$obj1}) && (defined $Obj{$obj2}) )  {
 #   $diceBin = (2*$baseline) / ($Obj{$obj1} + $Obj{$obj2}) ;
     $cosineBin = $baseline / sqrt ($Obj{$obj1} * $Obj{$obj2} )   

  }

  ##diceMin, cosine, lin:
#  if ( (defined $freqObj{$obj1}) && (defined $freqObj{$obj2}) )  {
#    $diceMin = (2*$min) / ($freqObj{$obj1} + $freqObj{$obj2}) ;
#  }

  printf "%s %s %f\n", $obj1_orig, $obj2_orig, $cosineBin
  

}

printf STDERR "Total: %10d\n\n",$mycount;



 sub Min {
    local ($x) = $_[0];
    local ($y) = $_[1];

    if ($x <= $y) {
      $result = $x
    }
    else {
      $result = $y
    }

    return $result
}



sub Max {
    local ($x) = $_[0];
    local ($y) = $_[1];

    if ($x >= $y) {
      $result = $x
    }
    else {
      $result = $y
    }

    return $result
}








