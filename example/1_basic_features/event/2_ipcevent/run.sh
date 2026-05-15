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
_ASCEND_INSTALL_PATH=$ASCEND_INSTALL_PATH
set -e


source $_ASCEND_INSTALL_PATH/bin/setenv.bash
echo "[INFO]: Current compile soc version is ${SOC_VERSION}"

rm -rf build
mkdir -p build
cmake -B build \
    -DASCEND_CANN_PACKAGE_PATH=${_ASCEND_INSTALL_PATH}
cmake --build build -j
cmake --install build

# 运行两个进程，输出重定向到日志文件
./build/proc_a 2>&1 | tee proc_a.log &
pid_a=$!
./build/proc_b 2>&1 | tee proc_b.log &
pid_b=$!

wait $pid_a $pid_b

# 检查生产者日志中是否成功完成
if grep -q "cleanup completed" proc_a.log; then
    echo "[SUCCESS] IPC event synchronization works correctly."
    exit 0
else
    echo "[FAILURE] IPC event synchronization test failed."
    exit 1
fi