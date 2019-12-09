#!/bin/bash
module load R/R-3.6.1

# rm -rf out; mkdir out # Write desired output (by redirecting stdout) here.
rm -rf slurm_out; mkdir slurm_out # Let Slurm write output (stdout, stderr) here.

# sbatch will run jobArray.sh 100000 times in parallel with the variable
# SLURM_ARRAY_TASK_ID set to 1, 2, ... in the respective jobs.
# %A is job ID and %a is array index.
rm -rf coef.out intercept.out
sbatch --mem-per-cpu=800M --array=1-1000 --output="slurm_out/slurm-%A_%a.out" ./bootstrap.sh
