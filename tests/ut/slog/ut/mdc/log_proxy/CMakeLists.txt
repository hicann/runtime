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

###################################################################
set(logProxySrc
    ${LOG_SOURCE_PATH}/syslog/log_proxy/log_proxy.c
    # ${LOG_SOURCE_PATH}/utils/log_print_syslog.c
    ${LOG_SOURCE_PATH}/utils/high_mem.c
    ${LOG_SOURCE_PATH}/utils/log_buffer/log_ring_buffer.c
    ${LOG_SOURCE_PATH}/utils/log_common.c
    ${CMAKE_CURRENT_SOURCE_DIR}/test/main.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/log_proxy_func_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/log_proxy_excp_utest.cc
    ${UT_SOURCE_PATH}/mdc/stub/slogd_stub.c
    ${UT_SOURCE_PATH}/stub/self_log_stub.c
)

set(logProxyInc
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/abl/libc_sec/include
    ${LOG_SOURCE_PATH}/syslog/log_proxy/
    ${LOG_SOURCE_PATH}/utils/log_buffer
    ${TOP_DIR}/abl/slog/shared
    ${TOP_DIR}/abl/slog/utils
    ${UT_SOURCE_PATH}/mdc/stub
    ${UT_SOURCE_PATH}/stub
)

add_executable(log_proxy_utest
    ${logProxySrc}
)

target_include_directories(log_proxy_utest PRIVATE
    ${logProxyInc}
)

target_compile_definitions(log_proxy_utest PRIVATE
    _LOG_UT_
    PATH_ROOT="/tmp/log_proxy_utest_SdusENF3o8d"
    TESTCASE_PATH="/tmp/log_proxy_utest_SdusENF3o8d/testcase"
    LOG_FILE="/tmp/log_proxy_utest_SdusENF3o8d/testcase/logTmp"
    HM_DRV_CHAR_DEV_USER_PATH="/tmp/log_proxy_utest_SdusENF3o8d/testcase/himemTmp"
    LOGOUT_IAM_SERVICE_PATH="/tmp/log_proxy_utest_SdusENF3o8d/testcase/iamTmp"
)

target_link_libraries(log_proxy_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    c_sec
    -Wl,-rpath,${TOP_DIR}/output/llt/c_sec/lib
)

target_compile_options(log_proxy_utest PRIVATE
    -Werror
)

set_target_properties(log_proxy_utest
    PROPERTIES
    OUTPUT_NAME log_proxy_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

run_llt_test(
    TARGET log_proxy_utest
    TASK_NUM 1
)

###################################################################
set(INSTALL_BASE_DIR "")
set(INSTALL_INCLUDE_DIR include)
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_RUNTIME_DIR bin)
set(INSTALL_CONFIG_DIR  lib/cmake)

include(CMakePackageConfigHelpers)

install(TARGETS log_proxy_utest OPTIONAL
    LIBRARY OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
    ARCHIVE OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
)
