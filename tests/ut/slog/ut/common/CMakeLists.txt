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
set(ADX_SOURCE_PATH ${TOP_DIR}/abl/adump)

###################################################################
set(libCommonSrc
    ${LOG_SOURCE_PATH}/utils/log_system_api.c
    test/log-sys-package-ut.cc
)

set(libCommonInc
    ${LOG_SOURCE_PATH}/utils
    ${LOG_SOURCE_PATH}/shared
    ${TOP_DIR}/abl/libc_sec/include
)

add_executable(log_common_utest
    ${libCommonSrc}
)

target_include_directories(log_common_utest PRIVATE
    ${libCommonInc}
)

target_compile_definitions(log_common_utest PRIVATE
    _LOG_UT_
)

target_link_libraries(log_common_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    c_sec
)

target_compile_options(log_common_utest PRIVATE
    -Werror
)

set_target_properties(log_common_utest
    PROPERTIES
    OUTPUT_NAME toolchain_log_common_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

run_llt_test(
    TARGET log_common_utest
    TASK_NUM 1
)

###################################################################
set(INSTALL_BASE_DIR "")
set(INSTALL_INCLUDE_DIR include)
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_RUNTIME_DIR bin)
set(INSTALL_CONFIG_DIR  lib/cmake)

include(CMakePackageConfigHelpers)

install(TARGETS log_common_utest OPTIONAL
    LIBRARY OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
    ARCHIVE OPTIONAL DESTINATION ${INSTALL_LIBRARY_DIR}
)
