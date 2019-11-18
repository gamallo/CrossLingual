#/bin/bash

PROGSDIR=./progs
INPUTDIR=./results
EVALDIR=./eval

#./run_eval.sh wiki en es N
#####PARAMETERS##########

PREFIX=$1
LING1=$2
LING2=$3
CAT=$4

########################

INPUTFILE=$INPUTDIR"/"$PREFIX"-"${LING1}"-"${LING2}"_"$CAT".txt"

cat $INPUTFILE |$PROGSDIR/eval.perl $EVALDIR/$CAT.txt 
