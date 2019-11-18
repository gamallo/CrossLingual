#!/usr/bin/perl


#lê é um ficheiro saida do tree-tagger


#foreach $line (<>) {
while ($line=<STDIN>) {
      chop $line;
      ($token, $lema, $tag) = split (" ", $line);
      $token = UpperToLower($token);
      $lema = UpperToLower($lema);
      printf "%s %s %s\n", $token, $lema, $tag;
}


print STDERR "fim do processo\n\n";




sub UpperToLower {
    local ($l) = @_;
     $l =~tr/A-Z/a-z/;
     $l =~tr/\301\311\315\323\332\307\303\325\302\312\324\300\310/\341\351\355\363\372\347\343\365\342\352\364\340\350/;
     return $l;
}

