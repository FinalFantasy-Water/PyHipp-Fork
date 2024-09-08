#!/bin/bash

# Submit this script with: sbatch <this-filename>

#SBATCH --time=24:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --cpus-per-task=5   # number of CPUs for this task
#SBATCH -J "rplspl"   # job name

## /SBATCH -p general # partition (queue)
#SBATCH -o rplspl-slurm.%N.%j.out # STDOUT
#SBATCH -e rplspl-slurm.%N.%j.err # STDERR

#SBATCH -J "rs2"   # job name
#SBATCH -o rs2-slurm.%N.%j.out # STDOUT
#SBATCH -e rs2-slurm.%N.%j.err # STDERR

python -u -c "import PyHipp as pyh; \
import DataProcessingTools as DPT; \
import time; \
import os; \
t0 = time.time(); \
print(time.localtime()); \
DPT.objects.processDirs(dirs=None, objtype=pyh.RPLSplit, channel=[*range(33,65)], SkipHPC=False, HPCScriptsDir = '/data/src/PyHipp-Fork/', SkipLFP=False, SkipHighPass=False, SkipSort=False); \
print(time.localtime()); \
print(time.time()-t0);"

aws sns publish --topic-arn arn:aws:sns:ap-southeast-1:396913730565:awsnotify --message "RS2JobDone"
