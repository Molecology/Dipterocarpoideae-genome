####Using PLINK to estimate the runs of homozygosity (ROH) for each sample. 
####The analysis is applied to two species, H. hainanensis and H. reticulata separately. The input file is the VCF file containing 30 H. hainanensis samples or that containing 32 H. reticulata samples.
vcf=VCF.file
out=sample
vcftools --gzvcf $vcf --plink-tped --out $out
plink --noweb --tped $out.tped --tfam $out.tfam --allow-no-sex --homozyg-window-snp 20 --homozyg-density 10 --homozyg-window-het 1 --homozyg-window-snp 20 --homozyg-kb 5  --homozyg-snp 10 --chr-set 14  --homozyg group
