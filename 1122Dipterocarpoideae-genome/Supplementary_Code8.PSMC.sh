####this analysis was perfomed on each of 30 H. hainanensis samples and 32 H. reticulata samples.
####The bam file of each samples was obtained from mapping against the longest two monoploid genomes as the reference genome using BWA-MEM.  
####‘sample.rmdup.bam’ is the bam file after removing duplication by SAMTOOLS

samtools mpileup -q 1 -C 50 -S -D -m 2 -F 0.002 -uf ref_genome.fa sample.rmdup.bam | bcftools view -c - | vcfutils.pl  vcf2fq -d 10 -D 100 -Q 20 - > sample.psmc.fq
####step2 Convert fastq to fasta.
fq2psmcfa -q 20 -g 100 -s 10 sample.psmc.fq  > sample.psmc.fa
####step3 Calculate the PSMC of the sample.
psmc -N30 -t15 -r5 -p 4+25*2+4+6 -o sample.psmc sample.psmc.fa
####step4 plots: each sample was plotted with three generation times.
cat *psmc >> All.PSMC
perl psmc_plot.pl -g 15 -u 1.05707e-08 -x 10000 -X 100000000 -p -R -M sample1,sample2,sample3... -T "PSMC Plot" PSMC_15 All.PSMC
perl psmc_plot.pl -g 20 -u 1.40943E-08 -x 10000 -X 100000000 -p -R -M sample1,sample2,sample3... -T "PSMC Plot" PSMC_20 All.PSMC
perl psmc_plot.pl -g 30 -u 2.11414E-08 -x 10000 -X 100000000 -p -R -M sample1,sample2,sample3... -T "PSMC Plot" PSMC_30 All.PSMC
