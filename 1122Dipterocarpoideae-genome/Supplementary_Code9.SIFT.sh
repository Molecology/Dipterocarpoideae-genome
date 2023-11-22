####This analysis was conducted for H. hainanensis and H. reticulata separatedly. 
####The VCF files, including 30 H. hainanensis samples and 32 H. reticulata samples, were annotated with ANNOVAR.
####The targeted genes containing non-synonymous variants were filtered from the annotation results.
####The gene.pep.fa file included the protein sequences of these targeted genes. 
sift4g  -q gene.pep.fa   --subst ./  -d /database_uniref90/uniref90.fa --algorithm NW --matrix BLOSUM_62 --out ./
awk -F'\t' '$2 =="DELETERIOUS"  {print $1}' gene.SIFTprediction  > gene.DELETERIOUS.xls
