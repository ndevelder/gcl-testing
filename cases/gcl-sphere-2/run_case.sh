#!/bin/bash 

#SBATCH -A FY260117
#SBATCH -t 48:00:00
#SBATCH --qos=normal


#SBATCH -o sphere_log_%j.out
#SBATCH -J sphere
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ndeveld@sandia.gov
#SBATCH -N 16

#SBATCH --reservation=flight-cldera

source /projects/kynema/development/dev_gcl_25.sh

nodes=$SLURM_JOB_NUM_NODES
rpn=112
ranks=$(( $rpn*$nodes ))

nalu_ranks=224
amr_ranks=$(( $ranks-$nalu_ranks ))

srun -N $nodes -n $ranks kynema_driver --ugf $nalu_ranks --sgf $amr_ranks sphere.yaml &> log


# Isolate run artifacts to make it easier to automate restarts in the future
# if necessary
mkdir run_$SLURM_JOBID
mv *.log run_$SLURM_JOBID
mv *_log_* run_$SLURM_JOBID
mv timings.dat run_$SLURM_JOBID
mv forces*dat run_$SLURM_JOBID

chown $USER:wg-sierra-users .
chmod g+s .

