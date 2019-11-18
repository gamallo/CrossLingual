#!/bin/bash

## scripts to be run

#### BEGIN PARAMETERS ############ 

CORPUS="wiki"
LING1="en"
LING2="es"
TAG1="E"
TAG2="S"


#### END PARAMETERS #######3

##Dowload cross-lingual models trained from Wikipedia
cd freq
wget -nc http://fegalaz.usc.es/~gamallo/resources/cross-lingual/freq_templates_wiki-en-es_Filtrado_N.txt.gz
wget -nc http://fegalaz.usc.es/~gamallo/resources/cross-lingual/freq_templates_wiki-en-es_Filtrado_A.txt.gz
wget -nc http://fegalaz.usc.es/~gamallo/resources/cross-lingual/freq_templates_wiki-en-es_Filtrado_V.txt.gz

cd ..
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


