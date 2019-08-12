#Nov_9_2016
#chipseq_bedtools
#count reads for 100 bp tiles with bedtools intersect
	
#!/bin/bash
#PBS -l walltime=08:00:00,nodes=1:ppn=1,mem=5gb
#PBS -o /scratch.global/nosha003/wenli_data/e_o/chipseq_bedtools_o
#PBS -e /scratch.global/nosha003/wenli_data/e_o/chipseq_bedtools_e
#PBS -N chipseq_bedtools
#PBS -V
#PBS -r n

SAMPLE="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 1)"

#load modules
module load bedtools
	
cd /scratch.global/nosha003/wenli_data

#count number of reads aligning to each 100 bp window
bedtools intersect -a align/${SAMPLE}_sort.bam -b /home/springer/nosha003/database/B73v4_100bp_bins.gff -bed -wa -wb > bedtools/${SAMPLE}.100bpcounts2.txt
  
#qsub -t 1-7 -v LIST=/home/springer/nosha003/wenli_data/scripts/histone_modifications_pe.txt /home/springer/nosha003/wenli_data/scripts/100bp_counts.sh
