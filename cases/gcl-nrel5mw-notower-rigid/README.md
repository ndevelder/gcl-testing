# Exawind benchmark troubleshooting case


Run precursor: 
srun --exclusive -N 1 -n 1 openfastcpp inp.yaml

Run Main Case:
srun -N $nodes -n $ranks exawind --nwind $nalu_ranks --awind $amr_ranks nrel5mw.yaml &> log

