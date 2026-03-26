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

CURRENT_DIR=$(
    cd $(dirname ${BASH_SOURCE:-$0})
    pwd
)
cd $CURRENT_DIR

_ASCEND_INSTALL_PATH=$ASCEND_INSTALL_PATH
source $_ASCEND_INSTALL_PATH/bin/setenv.bash

BUILD_TYPE="Debug"
INSTALL_PREFIX="${CURRENT_DIR}/out"

export ASCEND_TOOLKIT_HOME=${_ASCEND_INSTALL_PATH}
export ASCEND_HOME_PATH=${_ASCEND_INSTALL_PATH}

SHORT=r:,
LONG=run-mode:,
OPTS=$(getopt -a --options $SHORT --longoptions $LONG -- "$@")
eval set -- "$OPTS"

while :; do
    case "$1" in
    -r | --run-mode)
        RUN_MODE="$2"
        shift 2
        ;;
    --)
        shift
        break
        ;;
    *)
        echo "[ERROR]: Unexpected option: $1"
        break
        ;;
    esac
done

# 编译前拦截，若 RUN_MODE 不为 simple、placeholder或者为空字符串，则报错终止
if [ "$RUN_MODE" != "simple" ] && [ "$RUN_MODE" != "placeholder" ] && [ "$RUN_MODE" != "" ]; then
    echo "[ERROR]: Invalid run mode: $RUN_MODE , mode must be simple or placeholder"
    exit 1
fi

set -e
rm -rf build out
mkdir -p build
cmake -B build \
    -DSOC_VERSION=${SOC_VERSION} \
    -DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
    -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} \
    -DASCEND_CANN_PACKAGE_PATH=${_ASCEND_INSTALL_PATH}
cmake --build build -j
cmake --install build

rm -f ascendc_kernels_bbit
cp ./out/bin/ascendc_kernels_bbit ./
rm -rf input output
mkdir -p input output

# check and install numpy
set +e
echo "checking for numpy dependency..."
python3 -c "import numpy" &> /dev/null
if [ $? -ne 0 ]; then
    echo "numpy not found. installing numpy..."
    python3 -m pip install numpy --user
    if [ $? -ne 0 ]; then
        echo "Error: numpy installation failed. please check your pip environment."
        exit 1
    fi
    echo "numpy installation completed."
else
    echo "numpy is already installed."
fi
set -e
python3 scripts/gen_data.py

export LD_LIBRARY_PATH=$(pwd)/out/lib:$(pwd)/out/lib64:${_ASCEND_INSTALL_PATH}/lib64:$LD_LIBRARY_PATH
./ascendc_kernels_bbit "$RUN_MODE"

md5sum output/*.bin
python3 scripts/verify_result.py output/output_z.bin output/golden.bin
