# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(adprofBinHeader
    ../../
    ../../common
    ../../common/utils
    ../../common/cmd_log
    ../../common/errno
    ../../common/logger
    ../../common/singleton
    ../../depend/include/stub
    ${PROF_BASIC_DIR}/osal
    ${RUNTIME_DIR}/src/dfx/error_manager
    ${LIBC_SEC_HEADER}
    ${RUNTIME_DIR}/include/driver
)
 
set(adprofbinCpp
    ../src/adprof_bin.cpp
    ../../common/utils/utils.cpp
    ../../common/cmd_log/cmd_log.cpp
    ../../depend/stub/error_manager/msprof_error_manager_stub.cpp
    ${PROF_BASIC_DIR}/osal/osal.c
)
 
add_executable(adprof
    ${adprofbinCpp}
)
target_include_directories(adprof PRIVATE
    ${adprofBinHeader}
    ${CMAKE_CURRENT_SOURCE_DIR}
)
 
 
target_compile_options(adprof PRIVATE
    -fPIE
    -fno-strict-aliasing
    -fno-common
    -Wall
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wfloat-equal>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wextra>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wno-unused-parameter>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wno-missing-field-initializers>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Werror>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Debug>>:/MTd>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Release>>:/MT>
)
 
target_compile_definitions(adprof PRIVATE
    google=ascend_private
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:NOMINMAX>
)
 
target_link_options(adprof PRIVATE
    -Wl,-Bsymbolic
    -Wl,--exclude-libs=ALL
    -Wl,--start-group
    -ldl
)
 
target_link_libraries(adprof PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adprofbinOnetrack_pub>
    stackcore
)
 
set_target_properties(adprof
    PROPERTIES
    OUTPUT_NAME adprof
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)
 
install(TARGETS adprof OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
)
 
### onetrack target interface
 
add_library(adprofbinOnetrack_pub INTERFACE)
 
target_link_libraries(adprofbinOnetrack_pub INTERFACE
    $<BUILD_INTERFACE:intf_pub>
    c_sec
    unified_dlog
    mmpa
    ascend_hal_stub
    -lpthread
)