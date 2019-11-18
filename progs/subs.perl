#!/usr/bin/perl

#ESTENDE E CORRIGE ALGUMAS DEPENDENCIAS
#lê o resultado do parsing -a dependencias e devolve as dependencias estendidas

#use progs::funcoes::categorias

## trata a coordenaçao e as relativas (troca a ordem nos SubjL<Relatives>)


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


   ##relativas:
   if ($rel =~ /<Relative>/) {
      $triplet = "$rel;$dep;$head";
      $Relatives{$triplet}++;
   }


   ($head,$cat_h,$pos_h) = split ("_", $head);
   $Lemma{$pos_h} = $head;
   $Cat{$pos_h} = $cat_h;

   ($dep,$cat_d,$pos_d) = split ("_", $dep);
   $Lemma{$pos_d} = $dep;
   $Cat{$pos_d} = $cat_d;

   if ($rel =~ /_/) {
        ($rel, $cat_r, $pos_r) = split ("_", $rel);
   }


   ##coordinaçao
   if ($rel =~ /^Coord/) {
	$Coord{$pos_h}{$pos_d}++;
       # print    STDERR "--okkk  === #$triplet#\n\n";  
   }

   if (defined $Coord{$pos_d} && $rel !~ /^Coord/) {
       $TripletDep{$triplet}++;
    #  print STDERR "DEP :: #$triplet#\n";
   }

   if (defined $Coord{$pos_h} && $rel !~ /^Coord/) {
       $TripletHead{$triplet}++;
     # print STDERR "HEAD :: #$triplet#\n";
   }
  }
 }##for

 print "$sentence\n";


 foreach $triplet (keys %TripletDep) {
     #print STDERR "&&&&&&&&&&& #$triplet#\n";
   ($rel, $head, $dep) = split('\;', $triplet);

   ($head_short,$cat_h,$pos_h) = split ("_", $head);

   ($dep,$cat_d,$pos_d) = split ("_", $dep);

   foreach $pos (keys %{$Coord{$pos_d}}) {
      $dep = $Lemma{$pos} ;
      $cat = $Cat{$pos} ;
      $dependent = $dep . "_" . $cat . "_" . $pos ;
      #print STDERR "POS #$pos# --- DEP:#$dependent#\n"; 
      print "\($rel;$head;$dependent\)\n";
      if ($cat_h eq "CONJ") {
          foreach $p (keys %{$Coord{$pos_h}}) {
            $h = $Lemma{$p} ;
            $c = $Cat{$p} ;
            $node = $h . "_" . "$c" . "_" . "$p" ;
            #print STDERR "POS #$p# --- NODE:#$node#\n";
            print "\($rel;$node;$dependent\)\n";
            #delete $Coord{$pos_h}{$p} 
          } 
         # delete $Coord{$pos_h}{$p}
      }
      #delete $Coord{$pos_d}{$pos}
   }
   delete $TripletDep{$triplet}
 }

 foreach $triplet (keys %TripletHead) {
    # print STDERR "&&&&&&&&&&& #$triplet#\n";
   ($rel, $head, $dep) = split('\;', $triplet);

   ($head,$cat_h,$pos_h) = split ("_", $head);

   ($dep,$cat_d,$pos_d) = split ("_", $dep);

   foreach $pos (keys %{$Coord{$pos_h}}) {
      $head = $Lemma{$pos} ;
      $cat = $Cat{$pos} ;
      $nucleo = $head . "_" . $cat . "_" . $pos ;
      #print STDERR "POS #$pos# --- HEAD:#$nucleo#\n"; 
      print "\($rel;$nucleo;$dep\)\n";
      #delete $Coord{$pos_h}{$pos}
   }
   delete $TripletHead{$triplet}
 }
 
 foreach $triplet (keys %Relatives) {
   print "\($triplet\)\n";
   delete $Relatives{$triplet}
 }
 print "---\n" ;
 foreach $x (keys %Lemma) {
   delete $Lemma{$x};
   delete $Cat{$x};
 }

 foreach $x (keys %Coord) {
   delete $Coord{$x};
 }

}
