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

file_path=output_msg.txt
./build/main | tee $file_path

source_value=$(grep "Source data:" $file_path | awk -F':' '{gsub(/^ +| +$/, "", $2); print $2}' | head -n 1)
destination_value=$(grep "Destination data:" $file_path | awk -F':' '{gsub(/^ +| +$/, "", $2); print $2}' | head -n 1)

if [ "$source_value" = "$destination_value" ]; then
    echo "[SUCCESS] Memory copy successfully. Values at source and destination are equal: $source_value"
else
    echo "[FAILURE] Memory copy failed. Value at source is $source_value, but value at destination is $destination_value"
fi

exit 0