#!/usr/bin/perl 

##Cria o ficheiro de saída formateado do sistema de clustering hierarquico. 
## A entrada para pipe é o ficheiro .gtr (os clusters). 
## Também toma como argumento o ficheiro .cdt
## cat file.gtr |formatClusters.perl file.cdt > file.formateado


$file = shift(@ARGV);
open (FILE, $file) or die "O ficheiro não pode ser aberto: $!\n";

$th = shift(@ARGV);


$i=0;
while ($line = <STDIN>) {
  chop $line;
  ($node, $obj1, $obj2, $sim) = split ("\t", $line); 
  $Nodes[$i] = "$node|$obj1|$obj2";
  $Simil{$node} = $sim;
  $i++;
  #print STDERR  "$node -- $obj1 --$obj2 \n"; 


  
  if  ($obj1 =~ /GENE/)  {
      $Expand{$obj1} =  $obj1 . "|" ;
  }
  if  ($obj2 =~ /GENE/)  {
      $Expand{$obj2} = $obj2 ;
  }

    $Expand{$node} = $Expand{$obj1} . "|" . $Expand{$obj2};
    $Pai{$node} = $obj1 ."|" . $obj2 ;
}

print STDERR "o número de clusters é: #$i#\n";

 foreach $node (keys %Expand) {

     if ( ($node =~ /NODE/) && ($Simil{$node} >=  $th) )  {
        
        ##arranjar os palitroques:
         $Expand{$node} =~ s/\|\|/\|/g; 
 #        {$node} =~ s/^\|//;
 #        $ExpandedNode{$node} =~ s/\|$//;
       print STDERR "$node -- #$Expand{$node}#\n";

    }	      
}     

while ($line = <FILE>) {
  chop $line;
  ($gene, $nome) = split ("\t", $line); 
   #print STDERR  "$gene -- $nome \n"; 
  $Name{$gene} = $nome;     
}

foreach $string (@Nodes) {
    ($node, $obj1, $obj2) = split ('\|', $string);

    if ($Simil{$node} >= $th)  {

       ($filho1, $filho2) = split ('\|', $Pai{$node});
       if ($filho1 =~ /NODE/) {
	   $f1 = $filho1;
       }
       else {
           $f1 = $Name{$filho1};
       }
       if ($filho2 =~ /NODE/) {
	   $f2 = $filho2;
       }
       else {
           $f2 = $Name{$filho2};
       }
       $filhos = $f1 . "|" . $f2 ;
       print "$node\t$filhos\t";

       $StringGenes = $Expand{$node};
       @ListaGenes = split ('\|', $StringGenes) ;
       for ($i=0;$i<=$#ListaGenes;$i++) {
          print $Name{$ListaGenes[$i]} . "|";
       }
       print "\n";
   }
}


 
sub Expandir {
    local ($o) = $_[0];

  
    ($o1, $o2) = split ('\|', $Expand{$o});

    if (!defined $Expand{$o1}) {
	return $Expand{$o1}
    }
    else {
     $Expand{$o1} .=  Expandir($o1) . "|" ;      

    }
   



    
     
}
