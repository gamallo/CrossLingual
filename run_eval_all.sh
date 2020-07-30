#/bin/bash

PROGSDIR=./progs
INPUTDIR=./results
EVALDIR=./eval

#./run_eval_all.sh wiki en es
#####PARAMETERS##########

PREFIX=$1
LING1=$2
LING2=$3

########################

INPUTFILE=$INPUTDIR"/"$PREFIX"-"${LING1}"-"${LING2}"_"?".txt"


cat $EVALDIR/?.txt >  $EVALDIR/ALL.txt
cat $INPUTDIR"/"$PREFIX"-"${LING1}"-"${LING2}"_"?".txt" |$PROGSDIR/eval.perl $EVALDIR/ALL.txt

rm $EVALDIR/ALL.txt
