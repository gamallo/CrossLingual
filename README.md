# Extraction of Cross-Lingual Models from Monolingual Corpora 

## Requirements:
* Perl and Bash interperters

## Description
This system takes as entry two plain text files in two languages (non-parallel corpora) and a bilingual dictionary, and gives a cross-lingual model based on syntactic dependencies. The dependency-based model is transparent, is stored in the folder `freq`, and is evaluated using a test dictionary. Notice that the syntactic parser can take more than 24 hours in large documents (1G or more). Syntactic parsing is carried out with the tool Linguakit, which is also included in the repository (just for English and Spanish). 

## How to use
### Build a new model
You can build (and evaluate) an English-Spanish model from raw texts using the script:

```
sh Build_model.sh
```

You just need two files in the corpus folder: `corpus-en.txt.gz´ and `corpus-es.txt.gz`.

If you want to use othe train dictionaries and othe languages, copy the new dictionary into the `dico` directory with the appropriate format and uncomment the line  `sh run_seedTemplates.sh`.

### Download and evaluate a pre-trained model 
To evalute a pre-trained model from English and Spanish Wikipedias, you can use the following script:

```
sh Eval.sh
```

This uses a test dictionary to evaluate a pre-trained model from Wikipedia. The evaluation scrip only considers the words including in the test dictionary, so it is not a real evaluation.   


	
