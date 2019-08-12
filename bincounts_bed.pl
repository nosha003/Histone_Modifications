#! /usr/bin/perl -w
# use file with counts for every 100bp bin and create bed file from initial bam to gff bedtools output file (cut to only include bin information)
# 10_Jan_2017
# Jaclyn_Noshay

use warnings;
use strict;
use Getopt::Std;

#set soft coded files
my $usage = "\n0 -i in -I in2 -o out\n";
our ($opt_i, $opt_I, $opt_o, $opt_h);
getopts("i:I:o:h") || die "$usage";

#check that all files are defined
if ( (!(defined $opt_i)) || (!(defined $opt_I))|| (!(defined $opt_o)) || (defined $opt_h) ) {
  print "$usage";
  #exit;
}

#read in gff 100bp bin count file and bedtools intersect file
open (my $in_fh, '<', $opt_i) || die;
open (my $in2_fh, '<', $opt_I) || die;
open (my $out_fh, '>', $opt_o) || die;

print $out_fh "chr\tbinstart\tbinstop\tdot\tdot\tdot\tbinid\tcount\n";

my %bins;
while (my $line2 = <$in2_fh>) {
  chomp $line2;
  
  # 1	B73v4	bin	1	100	.	.	.	ID=bin1-1
  
  my ($chr, undef, undef, $binstart, $binstop, undef, undef, undef, $bin) = split ("\t", $line2);

  my $binid = $chr . "_" . $binstart . "_" . $binstop;

  $bins{$binid} = $bin;
}

while (my $line = <$in_fh>) {
  chomp $line;

  my ($bin, $count) = split ("\t", $line);

  my ($chr, $binstart, $binstop) = split ("_", $bin);

  if (exists ($bins{$bin})) {
    print $out_fh "$chr\t$binstart\t$binstop\t.\t.\t.\t$bins{$bin}\t$count\n";
  }
}

close $in_fh;
close $in2_fh;
close $out_fh;
exit;
