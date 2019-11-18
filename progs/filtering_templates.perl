#!/usr/bin/perl


$th=50;

$stopwords = "be|have|take|get|must|should";
$stopwords = "ser|estar|poder|tener|haber|deber";


while ($line = <STDIN>) {
      chomp($line);
      ($template, $word, $freq, $ling) = split (" ", $line);
      if ($template =~ /\_($stopwords)\_/) {next}

      $Templates{$template}++ if ($template);
      #print STDERR "t: #$template#\n";

}

foreach $t (keys %Templates) {
    print "$t\n" if ($Templates{$t} >= $th);
}
