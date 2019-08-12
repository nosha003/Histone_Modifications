#Nov_22_2016
#samtools_sort
	
#!/bin/bash
#PBS -l walltime=08:00:00,nodes=1:ppn=1,mem=5gb
#PBS -o /scratch.global/nosha003/wenli_data/e_o/sort_o
#PBS -e /scratch.global/nosha003/wenli_data/e_o/sort_e
#PBS -N sort
#PBS -V
#PBS -r n

SAMPLE="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 1)"

cd /scratch.global/nosha003/wenli_data/align

# sort Bowtie2 output alignment files

module load samtools 

samtools sort ${SAMPLE}.pe.B73v4.bam -o ${SAMPLE}_sort.sam -O sam -T temp
samtools index ${SAMPLE}_sort.sam
samtools sort ${SAMPLE}.pe.B73v4.bam -o ${SAMPLE}_sort.bam -O bam -T temp
samtools index ${SAMPLE}_sort.bam

#qsub -t 1-7 -v LIST=/home/springer/nosha003/wenli_data/scripts/histone_modifications_pe.txt /home/springer/nosha003/wenli_data/scripts/samtools_sort.sh
