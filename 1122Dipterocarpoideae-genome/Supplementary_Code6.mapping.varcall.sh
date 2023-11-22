####The alignment was performed with 30 H. hainanensis samples and 32 H. reticulata samples separately. For each species, the samples were aligned twice, against the monoploid genome and against the two monoploid genomes.
bwa mem -t 8 -k 32 -M  -R "\@RG\tID:sample\tLB:sample\tPL:Illumina\tPU:sample\tSM:sample"  genome.fa  sample_1_clean.fq.gz sample_2_clean.fq.gz > sample.sam
samtools view -bS   sample.sam  -o sample.bam
samtools sort -m 5000000000 -T sample sample.bam  -o sample.sort.bam
samtools rmdup  sample.sort.bam sample.rmdup.bam
####sample1 and sample2 give gvcf examples of different samples. 
gatk --java-options "-Xmx50G" HaplotypeCaller -R genome.fa -ERC GVCF  -I  sample.rmdup.bam  -O sample.gvcf.gz
gatk --java-options "-Xmx50G" CombineGVCFs    -R genome.fa -V sample1.gvcf.gz -V sample2.gvcf.gz -O All_sample.gvcf.gz
gatk --java-options "-Xmx50G" GenotypeGVCFs   -R genome.fa -V All_sample.gvcf.gz  -O All_sample.vcf.gz  -G StandardAnnotation 
gatk --java-options "-Xmx50G" SelectVariants -select-type SNP -V All_sample.vcf.gz -O All_sample_SNP.vcf.gz
gatk --java-options "-Xmx4g"  VariantFiltration  -R  genome.fa  -V All_sample_SNP.vcf.gz  -O All_sample_SNP.filter.vcf.gz  -filter "QD < 2.0" --filter-name "QD2" -filter "QUAL < 30.0" --filter-name "QUAL30" -filter "SOR > 3.0" --filter-name "SOR3" -filter "FS > 60.0" --filter-name "FS60" -filter "MQ < 40.0" --filter-name "MQ40" -filter "MQRankSum < -12.5" --filter-name "MQRankSum-12.5" -filter "ReadPosRankSum < -8.0" --filter-name "ReadPosRankSum-8"
####VCF filtering method.
vcftools --minDP 13  --stdout --gzvcf All_sample_SNP.filter.vcf.gz --recode --recode-INFO-all  --max-missing 0.9 --maf 0.05 |bgzip --threads 3 > All_sample_SNP.DP13.miss0.1.maf0.05.vcf.gz
