#!/user/bin/env perl
use strict;
use warnings;


my $vcf_sample1 = $ARGV[0];
my $vcf_sample2 = $ARGV[1];
my $out_vcf = $ARGV[2];
my $step = $ARGV[3];

$step |= 1000;
my $end=$step;

my $line;
my @items;
my @lines;
my %infoCache;
my %sampleLines;
my $sampleName_vs1=(split/\//, $vcf_sample1)[-1];
my $sampleName_vs2=(split/\//, $vcf_sample2)[-1];
my %commonLines;
my ($s1Gene, $s2Gene);

my ($vs1, $vs2);
open($vs1, "gzip -dc $vcf_sample1|") or die $!;
open($vs2, "gzip -dc $vcf_sample2|") or die $!;

my $fileReadOver_vs1 = 0;
my $fileReadOver_vs2 = 0;
my $outVcfHandle;
open($outVcfHandle, "|gzip > $out_vcf") or die $!;
while (1){
    $fileReadOver_vs1 = &getLinesAndFilted($vs1, $sampleName_vs1) if(!$fileReadOver_vs1);
    $fileReadOver_vs2 = &getLinesAndFilted($vs2, $sampleName_vs2) if(!$fileReadOver_vs2);
    
    &writeLines($sampleName_vs1, $sampleName_vs2);
    last if($fileReadOver_vs1 || $fileReadOver_vs2);
    $end += $step;
}

close $vs1;
close $vs2;
close $outVcfHandle;


sub getLinesAndFilted(){
    my $fileHandle = shift;
    my $fileName = shift;
    $sampleLines{$fileName}=();

    if($infoCache{$fileName}[1]) {
        if ($infoCache{$fileName}[1] > $end) {
            return 0;
        }else{
            push @{$sampleLines{$fileName}}, [@items] if($items[-1]!~/0\/1/);
        }

    }
    while ($line=<$fileHandle>){
        chomp $line;
        @items=split /\t/, $line;
        if ($items[1] > $end) {
            $infoCache{$fileName} = [@items];
            return 0;
        }
        next if($items[-1]=~/0\/1/);
        push @{$sampleLines{$fileName}}, [@items];
    }
    return 1;
}


sub writeLinesDebug(){
    my $sample1 = shift;
    my $sample2 = shift;

    %commonLines=();
    foreach(@{$sampleLines{$sample1}}){
        $commonLines{$_->[1]} = $_;
    }
    foreach(@{$sampleLines{$sample2}}){
        if(exists $commonLines{$_->[1]}){
            $s1Gene = (split /:/, $commonLines{$_->[1]}[-1])[0];
            $s2Gene = (split /:/, $_->[-1])[0];
            if ($s1Gene eq $s2Gene) {
                $line = join("\t", @{$commonLines{$_->[1]}}, @{$_});
                print $outVcfHandle $line, "\n";
            }
        }
    }
}

sub writeLines(){
    my $sample1 = shift;
    my $sample2 = shift;

    %commonLines=();
    foreach(@{$sampleLines{$sample1}}){
        $commonLines{$_->[1]} = $_;
    }
    foreach(@{$sampleLines{$sample2}}){
        if(exists $commonLines{$_->[1]}){
            $s1Gene = (split /:/, $commonLines{$_->[1]}[-1])[0];
            $s2Gene = (split /:/, $_->[-1])[0];
            if ($s1Gene eq $s2Gene) {
                $line = join("\t", @{$commonLines{$_->[1]}}, $_->[-1]);
                print $outVcfHandle $line, "\n";
            }  
        }
    }
}
