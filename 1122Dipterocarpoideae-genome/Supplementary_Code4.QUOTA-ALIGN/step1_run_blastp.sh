####step1 run blastp. Input the protein files of two species.
#!/bin/bash

# independent settings for each step.
X_QUERY_SPECIES= Hret
Y_SUBJECT_SPECIES=Vvi

# makeblastdb & blastp
makeblastdb -in ${Y_SUBJECT_SPECIES}.pep -dbtype prot -parse_seqids -out ${Y_SUBJECT_SPECIES}.pep.db
blastp -db ${Y_SUBJECT_SPECIES}.pep.db -query ${X_QUERY_SPECIES}.pep -out ${X_QUERY_SPECIES}_vs_${Y_SUBJECT_SPECIES}.blastp -evalue 1e-5 -num_threads 24 -outfmt 6


