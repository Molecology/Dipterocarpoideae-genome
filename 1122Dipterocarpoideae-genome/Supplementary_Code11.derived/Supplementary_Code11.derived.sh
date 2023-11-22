###step1:Combine the gvcf files from two other species. These are GATK call variant files (Hret.Chr1.gvcf.gz and Hhai.Chr1.gvcf.gz.), and all the variant files are merged according to the chromosome. Below is the calculation of the ancestral loci for Hchi.
perl step1_combine_gvcf_file.pl Hret.Chr1.gvcf.gz Hhai.Chr1.gvcf.gz Hchi.ancester_SNP.Chr1.gz
perl step1_combine_gvcf_file.pl Hret.Chr2.gvcf.gz Hhai.Chr2.gvcf.gz Hchi.ancester_SNP.Chr2.gz
perl step1_combine_gvcf_file.pl Hret.Chr3.gvcf.gz Hhai.Chr3.gvcf.gz Hchi.ancester_SNP.Chr3.gz
perl step1_combine_gvcf_file.pl Hret.Chr4.gvcf.gz Hhai.Chr4.gvcf.gz Hchi.ancester_SNP.Chr4.gz
perl step1_combine_gvcf_file.pl Hret.Chr5.gvcf.gz Hhai.Chr5.gvcf.gz Hchi.ancester_SNP.Chr5.gz
perl step1_combine_gvcf_file.pl Hret.Chr6.gvcf.gz Hhai.Chr6.gvcf.gz Hchi.ancester_SNP.Chr6.gz
perl step1_combine_gvcf_file.pl Hret.Chr7.gvcf.gz Hhai.Chr7.gvcf.gz Hchi.ancester_SNP.Chr7.gz
###step2:Obtain ancestral SNP. Use ANNOVAR to utilize up-to-date information to functionally annotate genetic variants detected from genomes. The SNP location is obtained from the annotation file.
perl step2_get_ancester_SNP.pl SNP_loc.list  Hchi.ancester_SNP.Chr1.gz  ancester_SNP_Chr1.list
perl step2_get_ancester_SNP.pl SNP_loc.list  Hchi.ancester_SNP.Chr2.gz  ancester_SNP_Chr2.list
perl step2_get_ancester_SNP.pl SNP_loc.list  Hchi.ancester_SNP.Chr3.gz  ancester_SNP_Chr3.list
perl step2_get_ancester_SNP.pl SNP_loc.list  Hchi.ancester_SNP.Chr4.gz  ancester_SNP_Chr4.list
perl step2_get_ancester_SNP.pl SNP_loc.list  Hchi.ancester_SNP.Chr5.gz  ancester_SNP_Chr5.list
perl step2_get_ancester_SNP.pl SNP_loc.list  Hchi.ancester_SNP.Chr6.gz  ancester_SNP_Chr6.list
perl step2_get_ancester_SNP.pl SNP_loc.list  Hchi.ancester_SNP.Chr7.gz  ancester_SNP_Chr7.list
###step3:Get deleterious vcf.
python step3_Get_deleterious_vcf.py deleterious.snp.var nonsynonymous.snp.list Hchi.All.snp.vcf.gz Hchi.deleterious.sites.vcf
###deleterious.snp.var: evm.model.000000F.123  A278S
###nonsynonymous.snp.list from ANNOVAR:line541  nonsynonymous SNV       evm.TU.000229F.54:evm.model.000229F.54:exon6:c.A1400T:p.E467V,  Chr7    67296   67296   T       A       het     999     3880    43
###Hchi.All.snp.vcf.gz:all samples calling
###step4:Het and Hom Statistics: Retrieve all ancestral SNPs from the chromosomes and combine them into one file (ancester_SNP.list).
cat ancester_SNP_Chr*.list  > ancester_SNP.list
python step4_Het_Hom_stat.py ancester_SNP.list Hchi.deleterious.sites.vcf Hchi.deleterious.het_hom.stat.xls
###step5:Get deleterious genes.
python step5_deleterious_genes.py ancester_SNP Hchi.deleterious.sites.vcf nonsynonymous.snp.list Hchi.deleterious.gene.xls
