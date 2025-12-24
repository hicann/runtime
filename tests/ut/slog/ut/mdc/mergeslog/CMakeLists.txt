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
set(mergeslogSrc
    ${LOG_SOURCE_PATH}/liblog/mergeslog/mergeslog.c
    ${LOG_SOURCE_PATH}/utils/log_system_api.c
    ${LOG_SOURCE_PATH}/utils/log_common.c
    ${CMAKE_CURRENT_SOURCE_DIR}/test/mergeslog_func_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/mergeslog_excp_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/mergeslog_stub.c
    ${UT_SOURCE_PATH}/stub/self_log_stub.c
)

set(mergeslogInc
    ${LOG_SOURCE_PATH}/liblog/mergeslog/
    ${LOG_SOURCE_PATH}/utils
    ${TOP_DIR}/abl/libc_sec/include
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub
    ${UT_SOURCE_PATH}/stub/
)

add_executable(mergeslog_utest
    ${mergeslogSrc}
)

target_include_directories(mergeslog_utest PRIVATE
    ${mergeslogInc}
)

target_compile_definitions(mergeslog_utest PRIVATE
    _LOG_UT_
    WRITE_TO_SYSLOG
    GROUP_LOG
    PATH_ROOT="/tmp/mergeslog_utest_U32duEIW93D"
    TESTCASE_PATH="/tmp/mergeslog_utest_U32duEIW93D/testcase"
    LOGOUT_IAM_SERVICE_PATH="/tmp/mergeslog_utest_U32duEIW93D/iamTmp"
    SLOG_CONF_FILE_PATH="/tmp/mergeslog_utest_U32duEIW93D/slog.conf"
    CONF_PATH="${UT_SOURCE_PATH}/mdc/mergeslog/stub/slog_U32duEIW93D.conf"
)

target_link_libraries(mergeslog_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    c_sec
)

target_compile_options(mergeslog_utest PRIVATE
    -Werror
)

set_target_properties(mergeslog_utest
    PROPERTIES
    OUTPUT_NAME mergeslog_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

run_llt_test(
    TARGET mergeslog_utest
    TASK_NUM 1
)

###################################################################
set(INSTALL_BASE_DIR "")
set(INSTALL_INCLUDE_DIR include)
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_RUNTIME_DIR bin)
set(INSTALL_CONFIG_DIR  lib/cmake)

include(CMakePackageConfigHelpers)

install(TARGETS mergeslog_utest OPTIONAL
    LIBRARY OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
    ARCHIVE OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
)
