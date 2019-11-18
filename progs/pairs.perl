#!/usr/bin/perl 

#$N    = shift(@ARGV);
#$pref = shift(@ARGV);

#$file = shift(@ARGV);
#open(FILE, $file) || die "Can't open search-patterns: $!\n";

$TAG1 = shift(@ARGV);
$TAG2 = shift(@ARGV);
$CAT =  shift(@ARGV);

while ($line = <STDIN>) {
    chomp($line);
    ($l1, $l2, $cat) = split (" ", $line);
    $Dico1{$cat}{$l1}++ if ($cat =~ /^$CAT/);
    $Dico2{$cat}{$l2}++ if ($cat =~ /^$CAT/);
}

foreach $c (sort keys %Dico1) {
    foreach $l1 (sort keys %{$Dico1{$c}}) {
	$l1 = $l1 . "#$TAG1";
	foreach $l2 (keys %{$Dico2{$c}} ) {
	    $l2 = $l2 . "#$TAG2";
	    print "$l1 $l2\n";
	}
    }
}        






while ($term = <FILE>) {
    chomp($term);
  # ($term) = split (" ", $term);                                                                                                             
    $Terms{$term}++;

   #print STDERR "#$term#  \n";                                                                                                                
}


while ($term = <L2>) {
   chomp($term);
  # ($term) = split (" ", $term);
   $Terms{$term}++;

   #print STDERR "#$term#  \n";
}


while ($w1 = <L1>) { #le cada linha do arquivo
  chomp $w1;
  $w1 =~ s/$/\#$TAG1/;
  foreach $w2 (keys %Terms) {
         $w2 =~ s/$/\#$TAG2/;
         printf "%s %s\n", $w1, $w2 if ($Simil{$w1}{$w2})   
     
  }
}


