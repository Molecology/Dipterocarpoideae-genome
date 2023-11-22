#!/bin/bash
# independent settings for each step
X_QUERY_SPECIES=Hret
Y_SUBJECT_SPECIES=Vvi
# run quota_based screening
quota_align.py  --format=raw --merge --Dm=20 --min_size=5 --quota=2:1 Hret_vs_Vvi.raw
