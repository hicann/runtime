# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
protobuf_generate(profhal_proto
    CppPath
    HeaderPath
    ${CMAKE_CURRENT_SOURCE_DIR}/../proto/profiler.proto
    TARGET
)

####################### libascendprofhal.so ###########################

add_library(ascendprof_fwk_share SHARED
    ../common/memory/chunk_pool.cpp
    ../common/statistics/perf_count.cpp
    ../common/thread/thread.cpp
    ../common/thread/thread_pool.cpp
    ../common/utils/utils.cpp
    ../common/cmd_log/cmd_log.cpp
    ../common/json/json.cpp
    ${PROF_BASIC_DIR}/osal/osal.c
    ../depend/stub/error_manager/msprof_error_manager_stub.cpp
    ../message/codec.cpp
    ../streamio/client/src/sender.cpp
    ../transport/hdc/hdc_transport.cpp
    ../transport/hdc/helper_transport.cpp
    ../transport/hdc/hdc_sender.cpp
    halimpl/prof_hal_api.cpp
    halimpl/prof_hdc_server.cpp
    halimpl/prof_helper_server.cpp
    halimpl/prof_server_manager.cpp
    adx/stub/adx_prof_api.cpp
    adx/wrapper/hdc_api.cpp
    adx/wrapper/memory_utils.cpp
    ${CppPath}
)

target_include_directories(ascendprof_fwk_share PRIVATE
    ${RUNTIME_DIR}/src/inc/
    ${RUNTIME_DIR}/src/dfx/msprof/inc/toolchain
    ${RUNTIME_DIR}/src/dfx/msprof/inc
    ${LIBC_SEC_HEADER}
    ${RUNTIME_DIR}/include/driver
    ${RUNTIME_DIR}/include/external
    ${RUNTIME_DIR}/src/dfx/error_manager
    ../
    ../msprof/
    ../msprof/common/include
    ../msprof/platform/include
    ../msprof/engine/include
    ../common
    ../common/validation
    ../common/errno
    ../common/logger
    ../common/queue
    ../common/singleton
    ../common/utils
    ../common/cmd_log
    ../common/json
    ${PROF_BASIC_DIR}/osal
    ../depend/include/stub
    ../message
    ../transport
    ../streamio/client/include
    ../streamio/common/include
    ../driver/inc
    ../profimpl/report
    ../profhal/halinc
    adx/inc
    halimpl
    halinc
    ${CMAKE_BINARY_DIR}/proto/profhal_proto
    ${CMAKE_CURRENT_SOURCE_DIR}
)

set_target_properties(ascendprof_fwk_share
    PROPERTIES
    OUTPUT_NAME ascendprofhal
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

target_compile_definitions(ascendprof_fwk_share PRIVATE
    google=ascend_private
    $<$<STREQUAL:${CMAKE_BUILD_TYPE},Debug>:MSPROF_DEBUG>
)

target_compile_options(ascendprof_fwk_share PRIVATE
    -fPIC
    -shared
    -fstack-protector-all
    -fno-strict-aliasing
    -fno-common
    -Wall
    -Wextra
    -Wfloat-equal
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Debug>>:/MTd>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Release>>:/MT>
)

target_link_options(ascendprof_fwk_share PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,-Bsymbolic
    -Wl,--exclude-libs=ALL
)

if (PRODUCT)
    target_link_libraries(ascendprof_fwk_share PRIVATE
        ascend_hal_stub
    )
endif()

target_link_libraries(ascendprof_fwk_share PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:slog_headers>
    -Wl,--no-as-needed
    c_sec
    alog
    mmpa
    ascend_hal_stub
    ascend_protobuf_static
    error_manager
    -Wl,--as-needed
)

install(TARGETS ascendprof_fwk_share OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
)

add_dependencies(ascendprof_fwk_share profhal_proto)
####################### libascendprofhal.so ###########################
