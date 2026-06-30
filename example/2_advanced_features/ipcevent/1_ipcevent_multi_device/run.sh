#!/bin/bash
# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set -e

_ASCEND_INSTALL_PATH=$ASCEND_INSTALL_PATH

if [ -z "${_ASCEND_INSTALL_PATH}" ]; then
    echo "[ERROR] ASCEND_INSTALL_PATH environment variable not set."
    echo "Please source set_env.sh from your CANN installation first."
    exit 1
fi

source $_ASCEND_INSTALL_PATH/bin/setenv.bash
echo "[INFO]: Current compile soc version is ${SOC_VERSION}"

# 清理并编译
rm -rf build out *.bin *.done *.log
mkdir -p build out

cmake -B build -DASCEND_CANN_PACKAGE_PATH=${_ASCEND_INSTALL_PATH}
cmake --build build -j
cp build/proc_a build/proc_b build/precheck out/

# 设置消费者数量（根据实际可用设备数量调整，生产者使用 device 0）
# 例如：如果有3个设备（0,1,2），消费者数量为2
CONSUMER_NUM=1

if [ $CONSUMER_NUM -lt 1 ]; then
    echo "[ERROR] CONSUMER_NUM must be at least 1"
    exit 1
fi

REQUIRED_DEVICE_COUNT=$((CONSUMER_NUM + 1))
set +e
./out/precheck "${REQUIRED_DEVICE_COUNT}"
PRECHECK_RET=$?
set -e
if [ "${PRECHECK_RET}" -eq 2 ]; then
    exit 0
fi
if [ "${PRECHECK_RET}" -ne 0 ]; then
    echo "[ERROR] Device count precheck failed."
    exit "${PRECHECK_RET}"
fi

echo "[INFO] Starting producer on device 0, waiting for $CONSUMER_NUM consumer(s)..."

# 启动生产者（后台）
./out/proc_a $CONSUMER_NUM 2>&1 | tee producer.log &
PROC_A_PID=$!

# 启动消费者（每个消费者运行在不同的设备上）
declare -a CONSUMER_PIDS
for ((i=1; i<=$CONSUMER_NUM; i++)); do
    DEVICE_ID=$i
    echo "[INFO] Starting consumer $i on device $DEVICE_ID"
    ./out/proc_b $DEVICE_ID $i 2>&1 | tee consumer_${i}.log &
    CONSUMER_PIDS[$i]=$!
done

# 等待所有进程结束
wait $PROC_A_PID
for ((i=1; i<=$CONSUMER_NUM; i++)); do
    wait ${CONSUMER_PIDS[$i]}
done

# 检查生产者日志是否成功
if grep -q "finished successfully" producer.log; then
    echo "[SUCCESS] IPC event multi-device synchronization works correctly."
    exit 0
else
    echo "[FAILURE] IPC event multi-device synchronization test failed."
    exit 1
fi
