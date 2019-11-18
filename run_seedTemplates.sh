#/bin/bash


PROGSDIR=./progs
TMPDIR=./tmp
OUTPUTDIR=./seeds
INPUTDIR=./corpus
FREQDIR=./freq


##Parameters
#for instance: run_seedTemplates test en gl E G
 
PREFFIX=$1 ##base name of the corpus...
LING1=$2 #en, es,...
LING2=$3
TAG1=$4 # E, S,...
TAG2=$5

###########################

###bilingual train dictionary

DICO="./dicos/train-"${LING1}"-"${LING2}".txt"


#input:

INPUTFILE1=${INPUTDIR}/${PREFFIX}"-"${LING1}.txt.gz 
INPUTFILE2=${INPUTDIR}/${PREFFIX}"-"${LING2}.txt.gz 

zcat $INPUTFILE1 |./Linguakit/linguakit tagger $LING1 > ${TMPDIR}"/__tmp1"
zcat $INPUTFILE2 |./Linguakit/linguakit tagger $LING2 > ${TMPDIR}"/__tmp2"

INPUTFILE1=${TMPDIR}"/__tmp1" ;
INPUTFILE2=${TMPDIR}"/__tmp2" ;


SEED_DICO=$OUTPUTDIR"/seedTemplates_"${PREFFIX}"-"${LING1}"-"${LING2}"_Dico.txt"
SEED_COGNATOS=$OUTPUTDIR"/seedTemplates_"${PREFFIX}"-"${LING1}"-"${LING2}"_Cognatos.txt"

zcat ${FREQDIR}"/freq_"${PREFFIX}"-"${LING1}".txt.gz" ${FREQDIR}"/freq_"${PREFFIX}"-"${LING2}".txt.gz" >   $TMPDIR/__freq
FREQFILES=$TMPDIR/__freq;


echo "criar os seed templates a partir de do dico bilingue"
cat $DICO |$PROGSDIR/generatingSimilarTemplates-${LING1}-${LING2}.perl  |
              sed "s/<b\\/>/\@/g" |
              $PROGSDIR/anotarSeedTemplates.x $TAG1 $TAG2 >  $SEED_DICO


echo "criar os seed templates a partir de cognatos"

cat  $INPUTFILE1 |$PROGSDIR/generatingSimilarTemplatesFromCognates-${LING1}-${LING2}.perl $INPUTFILE2 |
                  $PROGSDIR/anotarSeedTemplates.x $TAG1 $TAG2 >  $SEED_COGNATOS

echo "create final format seed file"
##tirar as maiusculas dos contextos
cat $FREQFILES |$PROGSDIR/TirarMaiusculasCntxs.perl > $TMPDIR/__tmp


SEEDFILES=${OUTPUTDIR}"/seedTemplates_"${PREFFIX}"-"${LING1}"-"${LING2}"_"*
SEEDFILE=${OUTPUTDIR}"/format_seedTemplates_"${LING1}"-"${LING2}".txt"

cat $SEEDFILES |sort |uniq -c >  $TMPDIR/__tmp3
cat $TMPDIR/__tmp |$PROGSDIR/filtrarTemplates.perl $TMPDIR/__tmp3 $TAG1 $TAG2 > $SEEDFILE


rm ${TMPDIR}"/__tmp1"
rm ${TMPDIR}"/__tmp2"
rm ${TMPDIR}"/__tmp3"
rm ${TMPDIR}"/__tmp"
rm ${TMPDIR}"/__freq"
