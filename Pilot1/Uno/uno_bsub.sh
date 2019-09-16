#!/bin/bash
#BSUB -W 1:00
#BSUB -nnodes 3 
#BSUB -P med106
module load gcc/4.8.5
module load spectrum-mpi/10.3.0.1-20190611
module load cuda/10.1.168
export PATH="/ccs/proj/med106/gounley1/summit/miniconda37/bin:$PATH"

jsrun -n 1 -a 1 -c 42 -g 1 python uno_mixedprecision_tfkeras.py --mixed_precision True --config_file uno_mixed_precision.txt --cache /ccs/home/brettin/project_work/brettin/milestone13/cache/top21_auc --gpus 0 -e 3 --use_exported_data /gpfs/alpine/med106/scratch/brettin/milestone13/top_21_auc_1fold.uno.h5 > uno.mixed.log &

sleep 2

jsrun -n 1 -a 1 -c 42 -g 1 python uno_mixedprecision_tfkeras.py --config_file uno_mixed_precision.txt --cache /ccs/home/brettin/project_work/brettin/milestone13/cache/top21_auc --gpus 0 -e 3 --use_exported_data /gpfs/alpine/med106/scratch/brettin/milestone13/top_21_auc_1fold.uno.h5 > uno.regular.log &

sleep 2

jsrun -n 1 -a 1 -c 42 -g 1 python uno_mixedprecision_tfkeras.py --mixed_precision True --config_file uno_mixed_precision.txt --cache /ccs/home/brettin/project_work/brettin/milestone13/cache/top21_auc --gpus 0 -e 3 --use_exported_data /gpfs/alpine/med106/scratch/brettin/milestone13/top_21_auc_1fold.uno.h5 > uno.mixed.sized.log