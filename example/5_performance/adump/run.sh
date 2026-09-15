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

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../../common/resolve_cann_env.sh"
resolve_cann_env

samples=("0_adump_args" "1_adump_callback" "2_model_dump_config" "3_save_exception_info")
failed=0
for sample in "${samples[@]}"; do
    sample_dir="${SCRIPT_DIR}/${sample}"
    echo "[INFO] Running adump sample: ${sample}"
    if (cd "${sample_dir}" && bash run.sh); then
        echo "[SUCCESS] adump sample ${sample} completed successfully."
    else
        echo "[FAILURE] adump sample ${sample} failed."
        failed=1
    fi
done

if [[ "${failed}" -ne 0 ]]; then
    echo "[FAILURE] One or more adump samples failed."
    exit 1
fi
echo "[SUCCESS] All adump samples completed successfully."
