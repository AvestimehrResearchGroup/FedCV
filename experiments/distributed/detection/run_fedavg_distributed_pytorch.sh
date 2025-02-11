#!/usr/bin/env bash

CLIENT_NUM=$1
WORKER_NUM=$2
SERVER_NUM=$3
GPU_NUM_PER_SERVER=$4
DATA=$5
DISTRIBUTION=$6
ROUND=$7
EPOCH=$8
BATCH_SIZE=$9
LR=${10}
DATASET=${11}
DATA_DIR=${12}
WEIGHTS=${13}
CI=${14}
DEVICE=${15}

PROCESS_NUM=`expr $WORKER_NUM + 1`
#echo $PROCESS_NUM
echo $DATA
echo $DATASET
echo $DATA_DIR
export PYTHONWARNINGS='ignore:semaphore_tracker:UserWarning'

hostname > mpi_host_file

mpirun -np $PROCESS_NUM -hostfile ./mpi_host_file python ./main_fedavg_yolo.py \
  --gpu_server_num $SERVER_NUM \
  --gpu_num_per_server $GPU_NUM_PER_SERVER \
  --data $DATA \
  --cfg $DATASET \
  --device $DATA_DIR \
  --partition_method $DISTRIBUTION  \
  --client_num_in_total $CLIENT_NUM \
  --client_num_per_round $WORKER_NUM \
  --comm_round $ROUND \
  --epochs $EPOCH \
  --weights $WEIGHTS \
  --batch_size $BATCH_SIZE \
  --lr $LR \
  --ci $CI \
#  --notest \
  --device $DEVICE
