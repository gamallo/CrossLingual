#!/usr/bin/perl -w

##Toma como entrada a saída do FreeLing e devolve um texto etiquetado com algumas modificaçoes: verbos compostos, elimina determinantes e pronomes, etc.

$Border="Fp";

$AUX="have|avoir|ter|haber|haver";
$COP="be|être|paraître|ser|estar|parecer|semellar|resultar";
#$MOD="must|can|devoir|pouvoir|aller|voloir|deber|poder|querer|ir";
$PASIVA="be|être|ser";

     $lema = "";
     $pal = "";
     $tag = "";
     $lema2 = "";
     $pal2 = "";
     $tag2 = "";
     $lema3 = "";
     $pal3 = "";
     $tag3 = "";
     $lema4 = "";
     $pal4 = "";
     $tag4 = "";

$i=0;
$found=0;
while (<>) {
   chop($_);

   if ($_ eq "") {
      next
   }
  
  else {
     #troca o simbolo de composicao:
     s/\_/\&/g ;
     ($pal, $lema, $tag) = split(" ", $_);
     
   if ($tag ne $Border) {
     $Pal[$i] = $pal;
     $Lema[$i] = $lema;
     $Tag[$i] = $tag;
     $i++;
     #print STDERR "$i\r";
   }
   
   elsif ($tag eq $Border) {
 
    for ($i=0;$i<=$#Lema;$i++) {
     $j= $i+1;
     $k= $j+1;
     $m= $k+1;
      if (defined $Lema[$i]) {$lema = $Lema[$i]} else { $lema=""};
      if (defined $Pal[$i]) {$pal = $Pal[$i]} else {$pal=""};
     if (defined $Tag[$i]) {$tag =  $Tag[$i]} else {$tag=""};
     if (defined $Lema[$j]) {  $lema2 = $Lema[$j]} else {$lema2=""};
     if (defined $Pal[$j]) { $pal2 = $Pal[$j]} else {$pal2=""};
     if (defined $Tag[$j]) { $tag2 = $Tag[$j]} else {$tag2=""};
    if (defined $Lema[$k]) {  $lema3 = $Lema[$k]} else {$lema3=""};
     if (defined $Pal[$k]) { $pal3 = $Pal[$k]} else {$pal3=""};
     if (defined $Tag[$k]){$tag3 = $Tag[$k]} else {$tag3=""};
     if (defined $Lema[$m]) {  $lema4 = $Lema[$m]} else {$lema4=""};
     if (defined $Pal[$m]) { $pal4 = $Pal[$m]} else {$pal4=""};
     if (defined $Tag[$m]){$tag4 = $Tag[$m]} else {$tag4=""};
 
    
    ##correcçoes de varias etiquetas
   
    
     ##identificar tempos compostos:
    # if ( (defined $tag) &&  (defined $tag2) &&  (defined $tag3) && (defined $tag4) ) {  
      if ( ($tag =~ /^V/) && ( ($tag2 =~ /^V/) || ($tag2 =~ /^SP/) )  && 
           ($tag3 =~ /^V/) && ($tag4 =~ /^V/) ) {
          if ( ($lema3 =~ /^${PASIVA}$/) && ($tag4 =~ /^VMP/) ) {
            $pal4 = $pal . "&" . $pal2 . "&" . $pal3 . "&" . $pal4 ;
          }
          else { 
             $pal4 = $pal . "&" . $pal2 . "&" . $pal3 . "&" . $pal4 ;
             $tag4 = $tag;
          }
        Escrever ($pal4, $lema4, $tag4);
        $i +=3;
        $found=1;
       }
      elsif ( ($tag =~ /^V/) && ( ($tag2 =~ /^V/) || ($tag2 =~ /^SP/) ) && ($tag3 =~ /^V/) ) {
          if ( ($lema2 =~ /^${PASIVA}$/) && ($tag3 =~ /^VMP/) ) {
            $pal3 = $pal . "&" . $pal2 . "&" . $pal3 ;
          }
          else {
             $pal3 = $pal . "&" . $pal2 . "&" . $pal3 ;
             $tag3 = $tag;  
          }          
        Escrever ($pal3, $lema3, $tag3);
        $i +=2;
        $found=1;
      }

      
      elsif ( ($lema =~ /^${AUX}$/) && ($tag2 =~ /^VMP/) ) {
          $pal2 = $pal . "&" . $pal2 ;
          $tag2 = $tag;
          
          Escrever ($pal2, $lema2, $tag2);
          $i++;
          $found=1;
       }
        
       elsif ( ($lema =~ /^${PASIVA}$/) && ($tag2 =~ /^VMP/) ) {
          $pal2 = $pal . "&" . $pal2 ;
         # $tag2 = $tag;
          
          Escrever ($pal2, $lema2, $tag2);
          $i++;
          $found=1;
	}
        elsif ( ($lema =~ /^${COP}$/) && ($tag2 =~ /^A/) ) {
          $pal2 = $pal . "&" . $pal2 ;
         # $lema2 = $lema . "&" . $lema2 ;
          #$tag2 = $tag;
                   
          Escrever ($pal2, $lema2, $tag2);
          $i++; 
          $found=1;
         }

         elsif ( ($lema =~ /^${COP}$/) && ($tag2 =~ /^R/) &&  ($tag3 =~ /^A/) ) {
          $pal3 = $pal . "&" . $pal3 ;
          #$lema3 = $lema . "&" . $lema3 ;
          #$tag2 = $tag;
                   
          Escrever ($pal3, $lema3, $tag3);
          $i++; 
          $found=1;
         }
        
         elsif ( ($lema =~ /^V/) && ($tag2 =~ /^V/) ) {
          $pal2 = $pal . "&" . $pal2 ;
          $tag2 = $tag;
          
          Escrever ($pal2, $lema2, $tag2);
          $i++;
          $found=1;
	}
         ##correcçoes de etiquetagem: numerais diante de nomes = determinantes
     #if (defined $tag2) { 
        elsif ( ($tag =~ /^Z/) && ($tag2 =~ /^N/) ) {
          
          Escrever ($pal2, $lema2, $tag2);
          $i++;
          $found=1;
        }
    
        

        
     elsif (!$found) {    
    

     ##correcçoes ad hoc de problemas de etiquetaçao:
       
         if ( ($lema =~ /^pol[oa](s?)$/) && ($tag =~ /^SP/) ) {
           $lema = "por"
         }



       ##fora artigos e encliticos e aspas
     	 if   ( ($tag =~ /^D/) || ( $tag =~ /^PP/) || ( $tag =~ /^P0/) ||  ($tag eq "Fe") ) {
            $tag="OUT";
         }
     
       #mudar tags de numero, adj, adv, prep e nom
        if ($tag =~  /^Z/) {
            $tag = "CARD";
            $lema = "\@card\@";
        }
       
       #se e NP (nome proprio), colocar a forma no lema
       
       if ($tag =~ /^NP/) {
         $lema = $pal;
       }


       if ($tag =~ /^A/) {
         $tag = "ADJ";
       }
       

       if ($tag =~ /^R/) {
         $tag = "ADV";
       }
       
    
      if ($tag =~ /^SP/) {
        $tag = "PRP";
      }
     
    
      if ($tag =~ /^N/) {
        $tag = "NOM";
      }
      
   
      ##participios:
    #  if ( ($tag =~ /^VMP/) && ($lema !~ /:vpp/) ){
    #    $lema = $lema . ":vpp";
    #  }
    #  if ( ($tag1 =~ /^VMP/) && ($lema1 !~ /:vpp/) ) {
    #    $lema1 = $lema1 . ":vpp";
    #  }

  
  



     Escrever ($pal, $lema, $tag);
     # print STDERR "$i\n";
   }

   $found=0;
  } 
 # for ($i=0;$i<=$#Lema;$i++) {
#          $Pal[$i]= "";
#          $Tag[$i] = "";
#          $Lema[$i] = "";
#  }
  for ($i=0;$i<=$#Lema;$i++) {
         delete  $Pal[$i];
         delete  $Tag[$i];
         delete  $Lema[$i];
  }
  
  #print STDERR "$i\n";
  $i=0;
  print "\. \. $Border\n";
  }
  
 }
}
	

#close FILE;

sub Escrever {
    local ($p) = $_[0];
    local ($l) = $_[1];
    local ($t) = $_[2];
    
    if ( $t eq "OUT") {
    }
    else { print "$p $l $t\n";
    } 

    return 1;
}

sub Escrever2 {
    local ($p1) = $_[0];
    local ($l1) = $_[1];
    local ($t1) = $_[2];
    local ($p) = $_[3];
    local ($l) = $_[4];
    local ($t) = $_[5];
    
    
    if ( ($t eq "OUT") && ($t1 eq "OUT") ) {
      print STDERR "1. $p1 - $p\n";
    }
    elsif ($t1 eq "OUT")  {
       print STDERR "2. $p1 - $p\n";
       print "$p $l $t\n";
    }
    elsif ($t eq "OUT") {
       print STDERR "3. $p1 - $p\n";
       print "$p1 $l1 $t1\n";
    }
   # elsif ( ($lema =~ /^${AUX}$/) || ($lema =~ /^${COP}$/)  || 
#            ($lema =~ /^${MOD}$/) || ($lema =~ /^${PASIVA}$/) ||
#            ($lema =~ /\@card\@/)  ){
#      print STDERR "4. $p1 - $p\n";
#      print "$p1 $l1 $t1\n";
#    }
   
    else {
     print STDERR "5. $p1 - $p\n";
     print "$p1 $l1 $t1\n";
     print "$p $l $t\n";
    }
    return 1;
}
