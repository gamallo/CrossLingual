#!/usr/bin/perl

#GERA OS CONTEXTOS, AS PALAVRAS E AS FREQUENCIAS 
#lê o resultado do parsing: dependencias. 

#use progs::funcoes::categorias

#$separador = "SENT::" ;
$separador = "---" ;

$/ = $separador;



$CountDep=0;

while ($sentence = <STDIN>) {


 $rel="";
 $head="";
 $dep="";
 $cat_h="";
 $cat_d="";
 $cat_r="";
 $pos_h="";
 $pos_d="";
 $pos_r="";

 $sentence =~ s/\n---// ;
 $sentence =~ s/\n\n// ;
 
# $sentence =~ s/SENT::// ;

 (@tmp) =  split ('\n', $sentence);


 for ($i=0; $i<=$#tmp; $i++) {

  if ($tmp[$i] =~ /^\(/) {
   $triplet = $tmp[$i];


   #tiramos as parenteses da dependencia
   $triplet =~ s/^\(//;
   $triplet =~ s/\)$//;
    # print STDERR "$line\n";

   ($rel, $head, $dep) = split('\;', $triplet);

   ($head,$cat_h,$pos_h) = split ("_", $head);

   ($dep,$cat_d,$pos_d) = split ("_", $dep);
   $Dep{$pos_d} = $dep;
   $Cat{$pos_d} = $cat_d;
   if ($rel =~ /_/) {
        ($rel, $cat_r, $pos_r) = split ("_", $rel);
   }


   if ($rel =~ /^TermR/) {
	$Term{$pos_h}{$pos_d}++;
       # print    STDERR "--okkk  === #$triplet#\n\n";
   }

   elsif (defined $Term{$pos_d} && $rel =~ /^Prep/) {
       $Triplet{$triplet}++;
      # print STDERR "okkk :: #$triplet#\n";
   }
  }
 }##for 
 print "$sentence\n";


 foreach $triplet (keys %Triplet) {
     #print STDERR "&&&&&&&&&&& #$triplet#\n";
   ($rel, $head, $dep) = split('\;', $triplet);
   $rel = "Cprep/$dep";
   #($head,$cat_h,$pos_h) = split ("_", $head);


   ($dep,$cat_d,$pos_d) = split ("_", $dep);

   foreach $pos (keys %{$Term{$pos_d}}) {
      $dep = $Dep{$pos} ;
      $cat = $Cat{$pos} ;
      $dependent = $dep . "_" . "$cat" . "_" . "$pos" ;
      #print STDERR "POS #$pos# --- DEP:#$dependent#\n"; 
      print "($rel;$head;$dependent\)\n";
      delete $Term{$pos_h}{$pos}
   }
   delete $Triplet{$triplet}
 }
 foreach $x (keys %Lemma) {
   delete $Lemma{$x};
   delete $Cat{$x};
 }

}
