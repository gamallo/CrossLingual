#/bin/bash

PROGSDIR=./progs
TMPDIR=./tmp
OUTPUTDIR=./freq
INPUTDIR=./corpus

##Parametros:

 
PREFFIX=$1 ##base name of the corpus...
LING=$2 #en, es...
TAG=$3
#Frequencia minima das palavras:
TH=$4
###########################


#input:
INPUTFILE=${INPUTDIR}/$PREFFIX"-"$LING.txt


#outputs:

OUTPUTFILE=$OUTPUTDIR"/freq_"${PREFFIX}"-"$LING".txt.gz"


date

## run Linguakit (instaled in folder ./Linguakit) 


linguakit="./Linguakit/linguakit dep $LING"

zcat $INPUTFILE  | $linguakit  | $PROGSDIR/subs.perl |$PROGSDIR/preps.perl |$PROGSDIR/subsDeps.sh |
     	         $PROGSDIR/contextos_fromDeps.perl |
  		 awk -v T=$TAG '{print $1, $2"#"T, $3" "T}'> $TMPDIR/__tmp


cat $TMPDIR/__tmp |gzip -c > $OUTPUTFILE

rm $TMPDIR/__*


date

