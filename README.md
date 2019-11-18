# Extraction of Cross-Lingual Models from Monolingual Corpora 

## Requirements:
* Perl and Bash interperters

## Description
This system takes as entry two plain text files in two languages (non-parallel corpora) and a bilingual dictionary, and gives a cross-lingual model based on syntactic dependencies. The dependency-based model is transparent, is stored in the folder `freq`, and is evaluated using a test dictionary. Notice that the syntactic parser can take more than 24 hours in large documents (1G or more). Syntactic parsing is carried out with [Linguakit](https://github.com/citiususc/linguakit). A simple version of Linguakit, just including PoS tagging and parsing for English and Spanish, is also included in the repository. If you wish install the full tool, go to its [github repository] (https://github.com/citiususc/linguakit).

## How to use
### Build a new model
You can build (and evaluate) an English-Spanish model from raw texts using the script:

```
sh Build_model.sh
```

You just need two files with raw text in the `corpus` folder. The file names can be: `corpus-en.txt.gz` and `corpus-es.txt.gz`.

If you want to use other train dictionaries and other languages, copy the new dictionary into the `dico` folder with the appropriate format and uncomment the line `sh run_seedTemplates.sh` in order to create new seed bilingual templates.

### Download and evaluate a pre-trained model 
To evalute a pre-trained model from English and Spanish Wikipedias, you can use the following script:

```
sh Eval.sh
```

This uses a test dictionary to evaluate a pre-trained model from Wikipedia. The evaluation scrip only considers the words including in the test dictionary, so it is not a real evaluation.

## How to cite
This system participated at the Cross-Lingual task of SemEval 2017 achieving the best results among the systems that only used Wikipedia corpus as train resource:

```
Gamallo, Pablo (2017). Citius at SemEval-2017 Task 2: Cross-Lingual Similarity from Comparable Corpora and Dependency-Based Contexts, Proceedings of the 11th International Workshop on Semantic Evaluation (SemEval-2017), at ACL 2017, pp. 226-229, Vancouver, Canada. ISBN 978-1-945626-00-5. 
```
[Download the paper](https://www.aclweb.org/anthology/S17-2034/)
	
