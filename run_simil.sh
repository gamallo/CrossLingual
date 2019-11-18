#/bin/bash

PROGSDIR=./progs
TMPDIR=./tmp
FREQDIR=./freq
OUTPUTDIR=./results
DICODIR=./dicos

#./run_simil_pairs.sh templates_wiki en es NVA
#####PARAMETERS##########

PREFIX=$1
LING1=$2
LING2=$3
TAG1=$4
TAG2=$5
CAT=$6

#TH=1 #theshold de palavras: 2
TOP=10
########################

DICO="./dicos/test-"${LING1}"-"${LING2}".txt"

cat $DICO |$PROGSDIR/pairs.perl $TAG1 $TAG2 $CAT > $TMPDIR/_pares_$CAT

zcat $FREQDIR/freq_templates_$PREFIX"-"$LING1"-"$LING2"_Filtrado_"$CAT".txt.gz" > $TMPDIR/__freq
   
cat  $TMPDIR/_pares_$CAT | $PROGSDIR/measures_cos.perl $TMPDIR/__freq |
    gawk '{print $1, $2, $3}'| $PROGSDIR/Nbest.perl $TOP > $OUTPUTDIR"/"${PREFIX}"-"$LING1"-"$LING2"_"$CAT".txt" 


