#!/bin/bash

## scripts to be run

#### BEGIN PARAMETERS ############ 

CORPUS="corpus"
LING1="en"
LING2="es"
TAG1="E"
TAG2="S"

TH=10 #threshold for frequency of words: >= 10 (change to 100 if the corpus is as large as Wikipedia)

#### END PARAMETERS #######3


## BEGIN MODULES ###

sh run_parser.sh $CORPUS $LING1
sh run_parser.sh $CORPUS $LING2

## building the files with frequencies for the two languages
sh run_freqs.sh $CORPUS $LING1 $TAG1 $TH
sh run_freqs.sh $CORPUS $LING2 $TAG2 $TH

## creating seed files (only required if you change the train dictionary)
##sh run_seedTemplates.sh $CORPUS $LING1 $LING2 $TAG1 $TAG2

## creating bilingual templates (separated by categories: N, V, A)
sh run_freqs_templates.sh $CORPUS $LING1 $LING2 $TAG1 $TAG2 

## inducing the bilingual dictionaries (just for the words in the test dictionary)
sh run_simil.sh $CORPUS  $LING1 $LING2 $TAG1 $TAG2 "N"
sh run_simil.sh $CORPUS  $LING1 $LING2 $TAG1 $TAG2 "A"
sh run_simil.sh $CORPUS  $LING1 $LING2 $TAG1 $TAG2 "V"

## evaluating with the test dictionary (This is a not real evaluation as only words of the test dictionary are considered)
echo "Evaluation of nouns"
sh run_eval.sh $CORPUS $LING1 $LING2 "N"
echo "Evaluation of adjectives"
sh run_eval.sh $CORPUS $LING1 $LING2 "A"
echo "Evaluation of verbs"
sh run_eval.sh $CORPUS $LING1 $LING2 "V"


