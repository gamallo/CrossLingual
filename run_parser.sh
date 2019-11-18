#/bin/bash

#./run_parse.sh corpus en EN

PROGSDIR=./progs
TMPDIR=./tmp
INPUTDIR=./corpus
OUTPUTDIR=./parse


#####PARAMETERS##########

PREFFIX=$1
LING=$2
TAG=$3

########################


#input:

INPUTFILE=${INPUTDIR}/${PREFFIX}"-"${LING}.txt.gz ;

#outputs:

OUTPUTFILE=$OUTPUTDIR"/parse_"${PREFFIX}"-"$LING".txt.gz"

## run Linguakit (instaled in folder ./Linguakit) 

linguakit="./Linguakit/linguakit dep $LING"

zcat $INPUTFILE  | $linguakit  |$PROGSDIR/subs.perl |$PROGSDIR/preps.perl  > $TMPDIR/__tmp
 
cat $TMPDIR/__tmp |gzip -c > $OUTPUTFILE

echo "Parse analysis has been built"


#rm $TMPDIR/__*
#rm $TMPDIR/*

