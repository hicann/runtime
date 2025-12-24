# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(LOG_SOURCE_PATH ${TOP_DIR}/abl/slog)
set(UT_SOURCE_PATH ${TOP_DIR}/llt/abl/slog/ut)

set(mdcSlogSrc
    ${LOG_SOURCE_PATH}/liblog/slog/alog_to_slog.c
    ${LOG_SOURCE_PATH}/liblog/slog/slog_api.cpp
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_core_iam.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_async_process.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_unified_timer_api.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_iam.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_level_iam.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_level_env.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_level_mgr.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_time.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_attr.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_message.c
    # ${LOG_SOURCE_PATH}/utils/log_print_syslog.c
    ${LOG_SOURCE_PATH}/utils/high_mem.c
    ${LOG_SOURCE_PATH}/utils/log_buffer/log_ring_buffer.c
    ${LOG_SOURCE_PATH}/utils/log_system_api.c
    ${LOG_SOURCE_PATH}/utils/log_common.c
    ${LOG_SOURCE_PATH}/utils/log_time.c
    ${LOG_SOURCE_PATH}/utils/library_load.c
    ${UT_SOURCE_PATH}/mdc/slog/testcase/slog_mdc_func_utest.cc
    ${UT_SOURCE_PATH}/mdc/slog/testcase/slog_mdc_excp_utest.cc
    ${UT_SOURCE_PATH}/mdc/slog/stub/mdc_slog_stub.c
    ${UT_SOURCE_PATH}/stub/self_log_stub.c
)

set(mdcSlogInc
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/abl/libc_sec/include
    ${LOG_SOURCE_PATH}/liblog/slog
    ${LOG_SOURCE_PATH}/utils
    ${LOG_SOURCE_PATH}/shared
    ${LOG_SOURCE_PATH}/utils/log_buffer
    ${MDC_LINUX_SDK_DIR}/include
    ${UT_SOURCE_PATH}/stub
    ${UT_SOURCE_PATH}/mdc/stub
    ${UT_SOURCE_PATH}/mdc/slog/stub
)


add_executable(mdc_slog_utest
    ${mdcSlogSrc}
)

target_include_directories(mdc_slog_utest PRIVATE
    ${mdcSlogInc}
)

target_compile_definitions(mdc_slog_utest PRIVATE
    _LOG_UT_
    __IDE_UT
    OS_TYPE_DEF=0
    IAM
    LINUX_ETC_CONF
    GETCLOCK_VIRTUAL
    WRITE_TO_SYSLOG
    PATH_ROOT="/tmp/mdc_slog_utest_UYU380ydy80w"
    BOOTARGS_FILE_PATH="/tmp/mdc_slog_utest_UYU380ydy80w/cmdline"
    LOGOUT_IAM_SERVICE_PATH="/tmp/mdc_slog_utest_UYU380ydy80w/iamTmp"
    HM_DRV_CHAR_DEV_USER_PATH="/tmp/mdc_slog_utest_UYU380ydy80w/himem"
    LLT_DEBUG
)

target_link_libraries(mdc_slog_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:mmpa_headers>
    mmpa
    c_sec
)

target_compile_options(mdc_slog_utest PRIVATE
    -Werror
)

set_target_properties(mdc_slog_utest
    PROPERTIES
    OUTPUT_NAME toolchain_mdc_slog_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

run_llt_test(
    TARGET mdc_slog_utest
    TASK_NUM 1
)

###################################################################
set(INSTALL_BASE_DIR "")
set(INSTALL_INCLUDE_DIR include)
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_RUNTIME_DIR bin)
set(INSTALL_CONFIG_DIR  lib/cmake)

include(CMakePackageConfigHelpers)

install(TARGETS mdc_slog_utest OPTIONAL
    LIBRARY OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
    ARCHIVE OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
)