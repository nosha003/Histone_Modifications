#Nov_8_2016
#chipseq_align_pe.sh
#!/bin/bash
  
#Bowtie2_Alignment
#PBS -l walltime=10:00:00,nodes=1:ppn=6,mem=10gb	
#PBS -o /scratch.global/nosha003/wenli_data/e_o/bowtie_align_pe_o
#PBS -e /scratch.global/nosha003/wenli_data/e_o/bowtie_align_pe_e
#PBS -N bowtie_pe_align
#PBS -V
#PBS -r n

module load bowtie2/2.2.4
module load samtools/1.3

cd /scratch.global/nosha003/wenli_data
  
SAMPLE="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 1)"
PAIR="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 2)"

bowtie2 -p 6 --phred33 -x /home/springer/nosha003/B73_RefGen_v4/v4_analysis/index/B73v4_pseudomolecules -1 /scratch.global/nosha003/wenli_data/fastq/${SAMPLE}.fastq -2 /scratch.global/nosha003/wenli_data/fastq/${PAIR}.fastq -S /scratch.global/nosha003/wenli_data/align/${SAMPLE}.pe.B73v4

samtools view -S -b -o /scratch.global/nosha003/wenli_data/align/${SAMPLE}.pe.B73v4.bam  /scratch.global/nosha003/wenli_data/align/${SAMPLE}.pe.B73v4

# qsub -t 1-7 -v LIST=/home/springer/nosha003/wenli_data/scripts/histone_modifications_pe.txt /home/springer/nosha003/wenli_data/scripts/chipseq_align_pe.sh
