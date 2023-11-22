#!/bin/bash
X_QUERY_SPECIES=Hret
Y_SUBJECT_SPECIES=Vvi

qa_plot.py --qbed=${X_QUERY_SPECIES}.nolocaldups.bed --sbed=${Y_SUBJECT_SPECIES}.nolocaldups.bed Hret_vs_Vvi.raw.merged   --outfmt=pdf
