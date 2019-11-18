#!/bin/bash



#filtrar linhas chungas: urls, ...
grep -v "[0-9]*\. http:" |
grep -v "\.gif" |
grep -v "^References" |
grep -v "\[lhorizontal\.gif\]" |
grep -v "Anterior: [0-9]*" |

#problemas de etiquetado com freeling:
sed "s/\([uU]\)-l/\1 /g" |
sed "s/[eE]soutros/aqueloutros/g" |


##tirarAspas:
sed "s/»//g" |
sed "s/«//g" |

sed "s/\"//g" |


#problemas com caracteres estranhos:
sed 's/_/ /g' |

##2 traços a 1:
sed "s/--/-/g" |


#sed "s/\[[0-9]*\]\([a-zA-Z]*\)/\1/g";

#ponher pontos em linhas em branco
awk '{if ($0 == "") {print "\."} else {print $0} }'
#sed "s/$/\./"
