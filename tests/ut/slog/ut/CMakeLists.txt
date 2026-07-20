# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
add_subdirectory(slog)
add_subdirectory(common)
add_subdirectory(alog)
add_subdirectory(ep)
add_subdirectory(iam)
add_subdirectory(rc)

set(SLOG_UT_TARGETS
    log_slogd_utest
    log_common_utest
    log_libalog_utest
    ep_alog_host_utest
    ep_log_daemon_utest
    ep_slogd_utest
    ep_slogd_milan_utest
    ep_stackcore_utest
    iam_slog_utest
    iam_slogd_utest
    mergeslog_coverage_utest
    log_proxy_coverage_utest
    hardware_zip_coverage_utest
    rc_alog_utest
)

add_custom_target(slog_ut DEPENDS ${SLOG_UT_TARGETS})
