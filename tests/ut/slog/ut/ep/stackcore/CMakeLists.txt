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

set(stackcoreSrc
    ${LOG_SOURCE_PATH}/syslog/log_daemon/stackcore/stackcore.c
    ${LOG_SOURCE_PATH}/syslog/log_daemon/stackcore/stackcore_common.c
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/stackcore_excp_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/stackcore_func_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/stackcore_stub.c
)

set(stackcoreInc
    ${TOP_DIR}/abl/libc_sec/include
    ${LOG_SOURCE_PATH}/inc/stackcore
    ${LOG_SOURCE_PATH}/syslog/log_daemon/stackcore
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/
)

add_executable(ep_stackcore_utest
    ${stackcoreSrc}
)

target_include_directories(ep_stackcore_utest PRIVATE
    ${stackcoreInc}
)

target_compile_definitions(ep_stackcore_utest PRIVATE
    __IDE_UT
    LOG_COREDUMP
    PATH_ROOT="/tmp/ep_stackcore_utest_M72litr07LG71uy/"
    CORE_DEFAULT_PATH="/tmp/ep_stackcore_utest_M72litr07LG71uy/"
    LLT_TEST
    _GNU_SOURCE
)

target_link_libraries(ep_stackcore_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    c_sec
)

target_compile_options(ep_stackcore_utest PRIVATE
    -Werror
)

set_target_properties(ep_stackcore_utest
    PROPERTIES
    OUTPUT_NAME toolchain_ep_stackcore_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

run_llt_test(
    TARGET ep_stackcore_utest
    TASK_NUM 1
)

###################################################################
set(INSTALL_BASE_DIR "")
set(INSTALL_INCLUDE_DIR include)
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_RUNTIME_DIR bin)
set(INSTALL_CONFIG_DIR  lib/cmake)

include(CMakePackageConfigHelpers)

install(TARGETS ep_stackcore_utest OPTIONAL
    LIBRARY OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
    ARCHIVE OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
)