#!/bin/bash 

#SBATCH -A FY260117
#SBATCH -t 01:00:00
#SBATCH --qos=normal
#SBATCH -o nrel5mw_log_%j.out
#SBATCH -J nrel5mw
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ndeveld@sandia.gov
#SBATCH -N 1
#SBATCH --reservation=flight-cldera

source /projects/kynema/development/dev_gcl_25.sh

srun --exclusive -N 1 -n 1 openfastcpp inp.yaml

# isolate run artifacts to make it easier to automate restarts in the future
# if necessary
mkdir run_$SLURM_JOBID
mv *.log run_$SLURM_JOBID
mv *_log_* run_$SLURM_JOBID
mv timings.dat run_$SLURM_JOBID
mv forces*dat run_$SLURM_JOBID

chown $USER:wg-sierra-users .
chmod g+s .

