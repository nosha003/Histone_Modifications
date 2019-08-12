#Nov_9_2016
#chipseq_samstat
#determine metrics of alignments
#!/bin/bash

#PBS -l walltime=08:00:00,nodes=1:ppn=6,mem=10gb
#PBS -o /scratch.global/nosha003/wenli_data/e_o/chipseq_metrics_o
#PBS -e /scratch.global/nosha003/wenli_data/e_o/chipseq_metrics_e
#PBS -N chipseq_samstat
#PBS -V
#PBS -r n

#install samstat on msi:
#cd /scratch.global/nosha003/wenli_data/scripts
#wget -r http://sourceforge.net/projects/samstat/files/samstat-1.5.1.tar.gz 
#cd sourceforge.net/projects/samstat/files/
#tar -zxf samstat-1.5.1.tar.gz  
#cd samstat-1.5.1
#./configure
#make

SAMPLE="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 1)"

cd /scratch.global/nosha003/wenli_data/

#samstat
module load samtools/0.1.18

/scratch.global/nosha003/chipseq_wenli/scripts/sourceforge.net/projects/samstat/files/samstat-1.5.1/src/samstat /scratch.global/nosha003/wenli_data/align/${SAMPLE}.pe.B73v4.bam

#qsub -t 1-7 -v LIST=/home/springer/nosha003/wenli_data/scripts/histone_modifications_pe.txt /home/springer/nosha003/wenli_data/scripts/chipseq_samstat.sh
