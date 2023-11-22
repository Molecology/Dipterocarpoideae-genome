####The analysis is conducted for all the species in the article.
####Here, we take the analysis for species H. reticulata (Hret) as an example. 
####The input files include the protein file 'Hret.pep', the CDS file 'Hret.cds', the genome file 'Hret.genome.fa', and the annotation file 'Hret.gff'. 
pep=Hret.pep   ###protein sequence
cds=Hret.cds   ###CDS sequence
genome=Hret.genome.fa  ### genome sequence
gff=Hret.gff    ###gff file
prefix=Hret
export PATH=$PATH:/software/bin/phobius  # to specify the path of phobius.pl script and binary.
export PATH=$PATH:/software/bin/hmmer/bin   # binary path
export PATH=$PATH:/software/bin/blast/bin    # binary path of blast+ package
export PATH=$PATH:/rgaugury  # this package scripts path
export PATH=$PATH:/rgaugury/coils  #the path to scoils-ht, which is a modified version of coils to adapt to RGAugury pipeline.
export PATH=$PATH:/interproscan-5.50-84.0    #download latest one as your wish. Do not add the path of "bin" under interproscan directory.
export PATH=$PATH:/PfamScan    #to specify the path for script of pfam_scan.pl
export PATH=$PATH:/cvit.1.2.1        #to specify the path of cvit.pl in CViT package, make sure cvit.pl can be found by 'which' command.
export COILSDIR=/rgaugury/coils # or create a plain file with putting this command only but a directory all user can access and drop it to /etc/profile.d/, file permission changes to 755, otherwise export it to user's profile and point to another user authorized directory
export PERL5LIB=/RGAugury/lib/site_perl/5.26.2:/RGAugury/lib/site_perl/5.26.2/x86_64-linux-thread-multi:/PfamScan:$PERL5LIB  #perl module for pfam_scan.pl
export PFAMDB=/Pfam33.1           #to specifiy the hmm pfam-A/B DB path

perl /rgaugury/RGAugury.pl -p $pep -n $cds -g $genome -gff $gff -pfx $prefix
