#!/usr/bin/env bash

set -x

PARTITION=$1
JOB_NAME=$2
CFG=$3
GPUS=$4
PY_ARGS=${@:5}
GPUS_PER_NODE=${GPUS_PER_NODE:-2}
CPUS_PER_TASK=${CPUS_PER_TASK:-2}
SRUN_ARGS=${SRUN_ARGS:-""}

srun -p ${PARTITION} \
    --job-name=${JOB_NAME} \
    --gres=gpu:${GPUS_PER_NODE} \
    --ntasks=${GPUS} \
    --ntasks-per-node=${GPUS_PER_NODE} \
    --cpus-per-task=${CPUS_PER_TASK} \
    --kill-on-bad-exit=1 \
    ${SRUN_ARGS} \
    python -u main_mfm.py \
        --cfg ${CFG} --launcher="slurm" ${PY_ARGS}
