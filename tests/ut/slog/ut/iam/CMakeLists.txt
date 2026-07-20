# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(LOG_SOURCE_PATH ${TOP_DIR}/src/dfx/log)
set(UT_SOURCE_PATH ${TOP_DIR}/tests/ut/slog/ut)

add_executable(iam_slog_utest
    ${LOG_SOURCE_PATH}/liblog/slog/alog_to_slog.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_async_process.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_core_iam.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_iam.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_level_iam.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_level_mgr.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_message.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_attr.c
    ${LOG_SOURCE_PATH}/liblog/slog/dlog_time.c
    ${LOG_SOURCE_PATH}/utils/high_mem.c
    ${LOG_SOURCE_PATH}/utils/log_buffer/log_ring_buffer.c
    ${LOG_SOURCE_PATH}/utils/log_system_api.c
    ${LOG_SOURCE_PATH}/utils/log_common.c
    ${LOG_SOURCE_PATH}/utils/log_time.c
    ${LOG_SOURCE_PATH}/utils/library_load.c
    ${UT_SOURCE_PATH}/slog/testcase/main.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/iam_slog_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/iam_slog_coverage_utest.cc
)

target_include_directories(iam_slog_utest PRIVATE
    ${TOP_DIR}/include/driver
    ${LOG_SOURCE_PATH}/liblog/slog
    ${LOG_SOURCE_PATH}/shared
    ${LOG_SOURCE_PATH}/utils
    ${LOG_SOURCE_PATH}/utils/log_buffer
    ${LOG_SOURCE_PATH}/inc/toolchain
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${UT_SOURCE_PATH}/alog/stub
    ${UT_SOURCE_PATH}/slog/stub
)

target_compile_definitions(iam_slog_utest PRIVATE
    _LOG_UT_
    IAM
    WRITE_TO_SYSLOG
    OS_TYPE_DEF=0
    LOGOUT_IAM_SERVICE_PATH="/tmp/iam_slog_utest/iam"
    HM_DRV_CHAR_DEV_USER_PATH="/tmp/iam_slog_utest/himem"
)

target_link_libraries(iam_slog_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:mmpa_headers>
    mmpa
    c_sec
    dl
)

target_compile_options(iam_slog_utest PRIVATE
    -Werror
)

set_target_properties(iam_slog_utest PROPERTIES
    OUTPUT_NAME toolchain_iam_slog_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

add_executable(iam_slogd_utest
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/log_communication/slogd_communication_iam.c
    ${LOG_SOURCE_PATH}/utils/log_buffer/log_ring_buffer.c
    ${LOG_SOURCE_PATH}/utils/log_system_api.c
    ${LOG_SOURCE_PATH}/utils/log_common.c
    ${UT_SOURCE_PATH}/slog/testcase/main.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/iam_slogd_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/iam_slogd_coverage_utest.cc
)

target_include_directories(iam_slogd_utest PRIVATE
    ${TOP_DIR}/include/driver
    ${LOG_SOURCE_PATH}/shared
    ${LOG_SOURCE_PATH}/syslog/common
    ${LOG_SOURCE_PATH}/syslog/common/config
    ${LOG_SOURCE_PATH}/syslog/slog
    ${LOG_SOURCE_PATH}/syslog/slog/log_server
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_classify/app_log
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/buffer_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/file_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_mgr/level_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_post_process/session_mgr
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/cmd_process
    ${LOG_SOURCE_PATH}/syslog/slog/log_server/log_pre_process/log_communication
    ${LOG_SOURCE_PATH}/utils
    ${LOG_SOURCE_PATH}/utils/log_buffer
    ${UT_SOURCE_PATH}/slog/stub
)

target_compile_definitions(iam_slogd_utest PRIVATE
    _LOG_UT_
    IAM
    WRITE_TO_SYSLOG
    LOGOUT_IAM_SERVICE_PATH="/tmp/iam_slogd_utest/iam"
)

target_link_libraries(iam_slogd_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    c_sec
)

target_compile_options(iam_slogd_utest PRIVATE
    -Werror
    -include ${UT_SOURCE_PATH}/slog/stub/iam.h
)

set_target_properties(iam_slogd_utest PROPERTIES
    OUTPUT_NAME toolchain_iam_slogd_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

add_executable(mergeslog_coverage_utest
    ${LOG_SOURCE_PATH}/liblog/mergeslog/mergeslog.c
    ${LOG_SOURCE_PATH}/utils/log_system_api.c
    ${LOG_SOURCE_PATH}/utils/log_common.c
    ${UT_SOURCE_PATH}/slog/testcase/main.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/mergeslog_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/mergeslog_coverage_utest.cc
)
target_include_directories(mergeslog_coverage_utest PRIVATE
    ${TOP_DIR}/include/driver
    ${LOG_SOURCE_PATH}/liblog/mergeslog
    ${LOG_SOURCE_PATH}/shared
    ${LOG_SOURCE_PATH}/utils
    ${UT_SOURCE_PATH}/slog/stub
)
target_compile_definitions(mergeslog_coverage_utest PRIVATE
    _LOG_UT_
    WRITE_TO_SYSLOG
    GROUP_LOG
    LOGOUT_IAM_SERVICE_PATH="/tmp/mergeslog_coverage_utest/iam"
)
target_link_libraries(mergeslog_coverage_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    c_sec
)
target_compile_options(mergeslog_coverage_utest PRIVATE -Werror)

add_executable(log_proxy_coverage_utest
    ${LOG_SOURCE_PATH}/syslog/log_proxy/log_proxy.c
    ${LOG_SOURCE_PATH}/utils/log_common.c
    ${UT_SOURCE_PATH}/slog/testcase/main.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/log_proxy_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_proxy_coverage_utest.cc
)
target_include_directories(log_proxy_coverage_utest PRIVATE
    ${TOP_DIR}/include/driver
    ${LOG_SOURCE_PATH}/shared
    ${LOG_SOURCE_PATH}/syslog/log_proxy
    ${LOG_SOURCE_PATH}/utils
    ${LOG_SOURCE_PATH}/utils/log_buffer
    ${UT_SOURCE_PATH}/slog/stub
)
target_compile_definitions(log_proxy_coverage_utest PRIVATE
    _LOG_UT_
    WRITE_TO_SYSLOG
    LOGOUT_IAM_SERVICE_PATH="/tmp/log_proxy_coverage_utest/iam"
)
target_link_libraries(log_proxy_coverage_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    c_sec
)
target_compile_options(log_proxy_coverage_utest PRIVATE
    -Werror
    -include ${UT_SOURCE_PATH}/slog/stub/iam.h
)

add_executable(hardware_zip_coverage_utest
    ${LOG_SOURCE_PATH}/utils/log_compress/log_hardware_zip.c
    ${LOG_SOURCE_PATH}/utils/log_system_api.c
    ${LOG_SOURCE_PATH}/utils/log_common.c
    ${UT_SOURCE_PATH}/slog/testcase/main.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/hardware_zip_stub.c
    ${CMAKE_CURRENT_SOURCE_DIR}/hardware_zip_coverage_utest.cc
)
target_include_directories(hardware_zip_coverage_utest PRIVATE
    ${TOP_DIR}/include/driver
    ${LOG_SOURCE_PATH}/shared
    ${LOG_SOURCE_PATH}/utils
    ${LOG_SOURCE_PATH}/utils/log_compress
    ${CMAKE_CURRENT_SOURCE_DIR}
)
target_compile_definitions(hardware_zip_coverage_utest PRIVATE
    _LOG_UT_
    HARDWARE_ZIP
    WRITE_TO_SYSLOG
)
target_link_libraries(hardware_zip_coverage_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    c_sec
)
target_compile_options(hardware_zip_coverage_utest PRIVATE -Werror)
