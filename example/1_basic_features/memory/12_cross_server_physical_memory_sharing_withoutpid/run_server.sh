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

set -euo pipefail

_ASCEND_CANN_PATH="${ASCEND_HOME_PATH:-}"
if [[ -z "${_ASCEND_CANN_PATH}" ]]; then
    echo "[ERROR]: ASCEND_HOME_PATH is not set."
    echo "[ERROR]: Please source CANN set_env.sh before running this sample."
    exit 1
fi

source "${_ASCEND_CANN_PATH}/bin/setenv.bash"
echo "[INFO]: Current compile soc version is ${SOC_VERSION:-unknown}"

rm -rf build
mkdir -p build
cmake -B build \
    -DASCEND_CANN_PACKAGE_PATH="${_ASCEND_CANN_PATH}"
cmake --build build -j

rm -rf file
mkdir -p file

file_path_server=output_msg_server.txt

port=8888
read -p "Please enter port number (default 8888): " input_port
if [ -n "$input_port" ]; then
    port=$input_port
fi

echo "[INFO]: Running server on port $port..."
server_ret=0
./build/server $port | tee "$file_path_server" || server_ret=$?

if [ "$server_ret" -eq 0 ]; then
    echo "[SUCCESS] Server completed successfully."
else
    echo "[FAILURE] Server failed to complete"
    exit "$server_ret"
fi

exit 0
