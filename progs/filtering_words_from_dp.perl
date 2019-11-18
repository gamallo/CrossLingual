#!/usr/bin/perl

##entrada deppattern
##filtra palavras com threshold
#$file = shift(@ARGV);
#open (FILE, $file) or die "O ficheiro n�o pode ser aberto: $!\n";

$th=shift(@ARGV);

while ($line = <STDIN>) {
    chomp $line;
   ($rel, $head, $dep) = split('\;', $line) if ($line =~ /^\(/);

   ($word) = $head =~ /([^_]+\_[^_]+)/;
   #print  "word: #$word#\n";
    $Words{$word}++ if ($word && $word !~ /_$/ && $word !~ / /);
   ($word) = $dep =~ /([^_]+\_[^_]+)/;
   #print STDERR "word: #$word#\n";
    $Words{$word}++ if ($word && $word !~ /_$/ && $word !~ / /);

}

foreach $w (keys %Words) {
    print "$w\n" if ($Words{$w} >= $th);
}
