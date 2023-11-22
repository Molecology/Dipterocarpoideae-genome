#!/usr/bin/perl -w
use strict;
use warnings;


my $loc_file = shift;
my $gene_type = shift;
my $outfile = shift;
my %loc_hash;

##Chr7    67496

open IN, "$loc_file" or die $!;
while(<IN>) {
	chomp;
	my @lines = split /\t/, $_;
	my $line = "$lines[0]\t$lines[1]";
	$loc_hash{$line} = 1;	
}  
close IN;

#open IN, "$gene_type" or die $!;
open IN,"gzip -dc $gene_type|";
open OUT, ">$outfile" or die $!;
while(<IN>) {
	chomp;
	my @lines = split /\t/, $_;
	my $pos = "$lines[0]\t$lines[1]";
	next unless (exists $loc_hash{$pos});
	my @gt = split /:/, $lines[9];
	my $out = "$pos\t$gt[0]";
	print OUT "$out\n"; 
}
close IN;
close OUT;
