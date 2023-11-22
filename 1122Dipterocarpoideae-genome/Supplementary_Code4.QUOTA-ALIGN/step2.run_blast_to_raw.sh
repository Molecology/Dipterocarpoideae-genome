#!/bin/bash

# independent settings for each step
X_QUERY_SPECIES=Hret
Y_SUBJECT_SPECIES=Vvi

# filter blast results and generate .raw file
blast_to_raw.py ${X_QUERY_SPECIES}_vs_${Y_SUBJECT_SPECIES}.blastp --qbed=${X_QUERY_SPECIES}.bed --sbed=${Y_SUBJECT_SPECIES}.bed --tandem_Nmax=10 --cscore=.5 --no_strip_names
