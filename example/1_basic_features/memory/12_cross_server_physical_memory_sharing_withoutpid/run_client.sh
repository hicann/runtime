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

file_path_client=output_msg_client.txt

read -p "Please enter Server IP address: " server_ip
read -p "Please enter port number (default 8888): " input_port
port=${input_port:-8888}

echo "[INFO]: Running client connecting to $server_ip:$port..."
client_ret=0
./build/client "$server_ip" "$port" | tee "$file_path_client" || client_ret=$?

if [ "$client_ret" -ne 0 ]; then
    echo "[FAILURE] Client failed to complete"
    exit "$client_ret"
elif grep -q "released memory successfully" "$file_path_client"; then
    echo "[SUCCESS] Client completed successfully"
else
    echo "[FAILURE] Client failed to complete"
    exit 1
fi

exit 0
