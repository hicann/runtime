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

# Verify product-to-slog.conf mapping in the MDC device build configuration.

set -euo pipefail

script_dir=$(cd "$(dirname "$0")" && pwd)
cmake_file="$script_dir/../../../src/dfx/log/syslog/slog/log_server/log_device_mdc/CMakeLists.txt"

test -f "$cmake_file"

mdc_products=$(awk '
    /if \(\(\$\{PRODUCT\} STREQUAL "ascend610"\)/ { in_mdc=1 }
    in_mdc { print }
    /elseif \(\(\$\{PRODUCT\} STREQUAL "ascend610Lite"\)/ { exit }
' "$cmake_file")
lite_products=$(awk '
    /elseif \(\(\$\{PRODUCT\} STREQUAL "ascend610Lite"\)/ { in_lite=1 }
    in_lite { print }
    /elseif \(\$\{PRODUCT\} STREQUAL "as31xm1"\)/ { exit }
' "$cmake_file")

printf '%s\n' "$mdc_products" | grep -q 'STREQUAL "mc32dm11a"'
printf '%s\n' "$mdc_products" | grep -q 'STREQUAL "mc32dm11aesl"'

if printf '%s\n' "$lite_products" | grep -q 'mc32dm11a'; then
    echo "mc32dm11a products must not use mdc_610lite/slog.conf" >&2
    exit 1
fi

printf '%s\n' "$lite_products" | grep -q 'STREQUAL "ascend610Lite"'
printf '%s\n' "$lite_products" | grep -q 'STREQUAL "ascend610Liteesl"'

echo "PASS: check_slog_device_config.sh verified mc32dm11a and mc32dm11aesl use mdc/slog.conf;"
echo "      ascend610Lite and ascend610Liteesl use mdc_610lite/slog.conf"
