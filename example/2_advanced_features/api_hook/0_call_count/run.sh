#!/bin/bash
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.

set -euo pipefail

if [[ -z "${ASCEND_INSTALL_PATH:-}" ]]; then
    echo "[ERROR] Set ASCEND_INSTALL_PATH to the CANN installation directory."
    exit 1
fi
CANN_PATH="$(cd "${ASCEND_INSTALL_PATH}" && pwd)"
for required_file in set_env.sh include/acl/acl.h include/acl/acl_rt.h lib64/libacl_rt.so; do
    if [[ ! -f "${CANN_PATH}/${required_file}" ]]; then
        echo "[ERROR] Missing ${CANN_PATH}/${required_file}"
        exit 1
    fi
done
source "${CANN_PATH}/set_env.sh"
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "${SCRIPT_DIR}/build"
cd "${SCRIPT_DIR}/build"
cmake .. -DASCEND_CANN_PACKAGE_PATH="${CANN_PATH}"
make -j"$(nproc)"
./main
