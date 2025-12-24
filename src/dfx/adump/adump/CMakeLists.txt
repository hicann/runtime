# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

####################### 预准备 ###########################
set(ADUMP_ADUMP_DIR ${CMAKE_CURRENT_LIST_DIR})
set(INSTALL_LIBRARY_DIR lib)

add_subdirectory(record_config)

####################### 预准备: 构建生成依赖的proto源码文件 ###########################
set(adumpHostProto
    "${ADUMP_DIR}/proto/dump_task.proto"
)

protobuf_generate(adumpHostProto adumpHostProtoSrcs adumpHostProtoHeaders ${adumpHostProto} TARGET)

set(adumpBaseProtoList
    "${ADUMP_DIR}/proto/op_mapping.proto"
)

protobuf_generate(ascend_dump_protos adumpBaseProtoSrcs adumpBaseProtoHeaders ${adumpBaseProtoList} TARGET)

############################ adump_headers ############################
add_library(adump_headers INTERFACE)

target_include_directories(adump_headers INTERFACE
    $<BUILD_INTERFACE:${ADUMP_DIR}/inc>
    $<BUILD_INTERFACE:${ADUMP_DIR}/inc/adump>
    $<BUILD_INTERFACE:${ADUMP_DIR}/inc/stackcore>
    $<BUILD_INTERFACE:${ADUMP_DIR}/external>
    $<BUILD_INTERFACE:${ADUMP_DIR}/inc/metadef>
    $<BUILD_INTERFACE:${ADUMP_DIR}/inc/metadef/external>
    $<BUILD_INTERFACE:${PROJECT_TOP_DIR}/include/external>
    $<BUILD_INTERFACE:${PROJECT_TOP_DIR}/pkg_inc/dump>
    ${RUNTIME_DIR}/src/dfx/error_manager
    $<INSTALL_INTERFACE:include>
    $<INSTALL_INTERFACE:include/adump>
    $<INSTALL_INTERFACE:include/adump/external>
)

########################### build artifacts ##########################
include(adump_decouple/adump_server.cmake)
include(adump_decouple/ascend_dump.cmake)
include(adump_decouple/adump.cmake)
