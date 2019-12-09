#!/bin/bash

n=$SLURM_ARRAY_TASK_ID

#echo "Hello, stderr from job $n." 1>&2 # sample line writing to stderr
#echo "Hello, stdout from job $n." # sample line writing to stdout
#echo $n >> out/$n.out # sample line writing to stdout, then redirecting to file

Rscript score_help.R $n
