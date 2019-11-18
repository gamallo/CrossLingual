#/bin/bash

PROGSDIR=./progs
TMPDIR=./tmp
OUTPUTDIR=./freq
INPUTDIR=./parse

##Parametros:

 
PREFFIX=$1 ##base name of the corpus...
LING=$2 #en, es...
TAG=$3
#Frequencia minima das palavras:
TH=$4
###########################


#input:
INPUTFILE=${INPUTDIR}/parse_$PREFFIX"-"$LING.txt


#outputs:

OUTPUTFILE=$OUTPUTDIR"/freq_"${PREFFIX}"-"$LING".txt.gz"

zcat $INPUTFILE | $PROGSDIR/filtering_words_from_dp.perl $TH > tmp/words-$LING
zcat $INPUTFILE  | $PROGSDIR/contextos_fromDeps_filtering.perl tmp/words-$LING |
  		 awk -v T=$TAG '{print $1, $2"#"T, $3" "T}'> $TMPDIR/__tmp


cat $TMPDIR/__tmp |gzip -c > $OUTPUTFILE

rm $TMPDIR/__*


date

