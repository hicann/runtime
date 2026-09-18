# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
add_subdirectory(utrace)
add_subdirectory(awatchdog)
add_subdirectory(trace_server)
add_subdirectory(cpu_detect)

set(ATRACE_UT_TARGETS
    utrace_utest
    utrace_arm_utest
    atrace_stub_utest
    awatchdog_utest
    awatchdog_stub_utest
    trace_server_utest
    cpu_detect_utest
)

add_custom_target(atrace_ut DEPENDS ${ATRACE_UT_TARGETS})
