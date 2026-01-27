# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

################### libadump_server.a begin ############################
set(adumpServerHeaderList
    ${ADUMP_DIR}/external
)

set(adumpServerSrcList
    ${ADUMP_ADUMP_DIR}/host/adx_datadump_server_stub.cpp
)

add_library(adump_server STATIC
    ${adumpServerSrcList}
)

target_include_directories(adump_server PRIVATE
    ${adumpServerHeaderList}
)

add_dependencies(adump_server adumpHostProto)

target_compile_options(adump_server PRIVATE
    -O2
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Werror>
    -std=c++11
    -fstack-protector-strong
    -fno-common
    -fno-strict-aliasing
    -Wextra
    -Wfloat-equal
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Debug>>:/MTd>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Release>>:/MT>
    $<$<CONFIG:Debug>:-D_FORTIFY_SOURCE=2 -Os -ftrapv>
    $<$<CONFIG:Release>:-D_FORTIFY_SOURCE=2 -Os>
)

target_compile_definitions(adump_server PRIVATE
    $<IF:$<STREQUAL:${PRODUCT_SIDE},host>,ADX_LIB_HOST,ADX_LIB>
    LOG_CPP
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:OS_TYPE=0>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:OS_TYPE=1>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:SECUREC_USING_STD_SECURE_LIB=0>
    google=ascend_private
    ADUMP_SOC_HOST=0
)

target_link_libraries(adump_server
    PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        $<BUILD_INTERFACE:mmpa_headers>
        $<BUILD_INTERFACE:slog_headers>
        $<BUILD_INTERFACE:adcore_headers>
        $<BUILD_INTERFACE:npu_runtime_headers>
        -Wl,--no-as-needed
        $<BUILD_INTERFACE:adcore>
        runtime
        ascend_protobuf
    PUBLIC
        adump_headers
)

################### libadump_server.a end ############################

################ libadump_server_stub.a begin ########################
set(adumpServerStubSrcList
    ${ADUMP_ADUMP_DIR}/host/adx_datadump_server_stub.cpp
)

set(adumpServerStubHeaderList
    ${ADUMP_DIR}/external
)

add_library(adump_server_stub STATIC
    ${adumpServerStubSrcList}
)

target_include_directories(adump_server_stub PRIVATE
	${adumpServerStubHeaderList}
)

target_compile_options(adump_server_stub PRIVATE
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Werror>
    -std=c++11
    -fstack-protector-strong
    -fno-common
    -fno-strict-aliasing
)

target_compile_definitions(adump_server_stub PRIVATE
    OS_TYPE=0
    ADUMP_SOC_HOST=0
)

target_link_libraries(adump_server_stub PRIVATE
    $<BUILD_INTERFACE:intf_pub>
)
################### libadump_server_stub.a end ######################
