#/bin/bash


PROGSDIR=./progs
TMPDIR=./tmp
INPUTDIR=./freq
SEEDDIR=./seeds
OUTPUTDIR=./freq


##Parameters####
#for instance: run_freqs_templates.x test en gl E G 20

PREFFIX=$1 ##base name of the corpus...
LING1=$2 #en, gl,...
LING2=$3
TAG1=$4 # E, G,...
TAG2=$5

##min freq
TH=$6

########################


#input:

INPUTFILE=${INPUTDIR}"/freq_"${PREFFIX}"-"* ;

SEEDFILE=${SEEDDIR}"/format_seedTemplates_"${LING1}"-"${LING2}".txt"

echo "tirar as maiusculas dos contextos"
zcat $INPUTFILE |$PROGSDIR/TirarMaiusculasCntxs.perl > $TMPDIR/__tmp



#output:
OUTPUTFILE=$OUTPUTDIR"/freq_templates_"${PREFFIX}"-"${LING1}"-"${LING2}".txt.gz"

#OUTPUTFILEFILTRADO=$OUTPUTDIR"/freq_"$LEX"_templates_"${SUFFIX}"-"${LING1}"-"${LING2}"_Filtrado.txt.gz"
OUTPUTFILEFILTRADO_N=$OUTPUTDIR"/freq_templates_"${PREFFIX}"-"${LING1}"-"${LING2}"_Filtrado_N.txt.gz"
OUTPUTFILEFILTRADO_A=$OUTPUTDIR"/freq_templates_"${PREFFIX}"-"${LING1}"-"${LING2}"_Filtrado_A.txt.gz"
OUTPUTFILEFILTRADO_V=$OUTPUTDIR"/freq_templates_"${PREFFIX}"-"${LING1}"-"${LING2}"_Filtrado_V.txt.gz"


echo "criar ficheiro de templates"
cat $TMPDIR/__tmp |$PROGSDIR/selectTemplates.perl $SEEDFILE $TAG1 $TAG2  | gzip -c > $OUTPUTFILE



##filtrar e separar ficheiros de contextos por categorias:
echo "filtrar..."
zcat $OUTPUTFILE  | $PROGSDIR/identificarTemplatesBilingues.perl 2 1000 $TH $TAG1 $TAG2  > $TMPDIR/__filtrado

cat $TMPDIR/__filtrado |$PROGSDIR/separarNC.perl | gzip -c > $OUTPUTFILEFILTRADO_N
cat $TMPDIR/__filtrado |$PROGSDIR/separarA.perl | gzip -c > $OUTPUTFILEFILTRADO_A
cat $TMPDIR/__filtrado |$PROGSDIR/separarV.perl | gzip -c > $OUTPUTFILEFILTRADO_V

#rm $TMPDIR/__filtrado
#rm $TMPDIR/__tmp
