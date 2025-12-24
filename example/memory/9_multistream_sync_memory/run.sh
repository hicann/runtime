#!/bin/bash
# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

_ASCEND_INSTALL_PATH=$ASCEND_INSTALL_PATH

source $_ASCEND_INSTALL_PATH/bin/setenv.bash
echo "[INFO]: Current compile soc version is ${SOC_VERSION}"

rm -rf build
mkdir -p build
cmake -B build \
    -DASCEND_CANN_PACKAGE_PATH=${_ASCEND_INSTALL_PATH}
cmake --build build -j
cmake --install build

rm -rf file
mkdir -p file

file_path=output_msg.txt

./build/main | tee $file_path

wait_value=$(grep "Flag value read by the waiting thread:" $file_path | awk -F':' '{gsub(/^ +| +$/, "", $2); print $2}' | head -n 1)
write_value_after=$(grep "Flag value after the writing thread starts:" $file_path | awk -F':' '{gsub(/^ +| +$/, "", $2); print $2}' | head -n 1)

if [ "$wait_value" = "$write_value_after" ]; then
    echo "[SUCCESS] Memory semantics synchronization across multiple streams is successful"
else
    echo "[FAILURE] Memory semantics synchronization across multiple streams failed"
fi

exit 0