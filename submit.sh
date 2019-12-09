#!/bin/bash
rm -rf slurm_out; mkdir slurm_out

# The following code enforces this order of running jobs:
#
#                 	         get.sh
#           		   /        |        \
	#   timestamp.sh    helpful.sh    score.sh    text.sh    summary.sh
#						|		|
	#				    	     count.sh      count.sh
#
#             		   \        |        /
#             		      \     |     /
#              		         \  |  /
#               	       combine.sh

jobId1=$(sbatch --output="slurm_out/slurm-%A_%a.out" get.sh)
# Strip off "Submitted batch job " from $jobId1. It has the form
# "Submitted batch job 6768660" (where the number changes from job to job).
jobId1=$(echo $jobId1 | sed 's/Submitted batch job //')

jobId2=$(sbatch --output="slurm_out/slurm-%A_%a.out" --dependency=afterok:$jobId1 timestamp.sh)
jobId2=$(echo $jobId2 | sed 's/Submitted batch job //') # Strip off "Submitted batch job ".

jobId3=$(sbatch --output="slurm_out/slurm-%A_%a.out" --dependency=afterok:$jobId1 helpful.sh)
jobId3=$(echo $jobId2 | sed 's/Submitted batch job //') # Strip off "Submitted batch job ".

jobId4=$(sbatch --output="slurm_out/slurm-%A_%a.out" --dependency=afterok:$jobId1 score.sh)
jobId4=$(echo $jobId2 | sed 's/Submitted batch job //') # Strip off "Submitted batch job ".

jobId5=$(sbatch --output="slurm_out/slurm-%A_%a.out" --dependency=afterok:$jobId1 text.sh)
jobId5=$(echo $jobId2 | sed 's/Submitted batch job //') # Strip off "Submitted batch job ".

jobId6=$(sbatch --output="slurm_out/slurm-%A_%a.out" --dependency=afterok:$jobId1 summary.sh)
jobId6=$(echo $jobId2 | sed 's/Submitted batch job //') # Strip off "Submitted batch job ".

jobId6=$(sbatch --output="slurm_out/slurm-%A_%a.out" --dependency=afterok:$jobId5 count.sh 'text.txt')
jobId6=$(echo $jobId2 | sed 's/Submitted batch job //') # Strip off "Submitted batch job ".

jobId6=$(sbatch --output="slurm_out/slurm-%A_%a.out" --dependency=afterok:$jobId6 count.sh 'summary.txt')
jobId6=$(echo $jobId2 | sed 's/Submitted batch job //') # Strip off "Submitted batch job ".

jobId7=$(sbatch --output="slurm_out/slurm-%A_%a.out" --dependency=singleton combine.sh)

