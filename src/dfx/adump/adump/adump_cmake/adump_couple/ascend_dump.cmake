# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

include(${ADUMP_CMAKE_DIR}/adump_base/ascend_dump_base.cmake)

####################### libascend_dump.so begin ###########################
set(ascendDumpSrcList
    ${adumpServerSrcList}
    ${adumpBaseProtoSrcs}
    ${adumpHostProtoSrcs}
    ${ascendDumpCoupleBaseSrcList}
)

set(ascendDumpHeaderList
    ${adumpServerHeaderList}
    ${ascendDumpBaseHeaderList}
)

add_library(ascend_dump SHARED
    ${ascendDumpSrcList}
)

add_dependencies(ascend_dump ascend_dump_protos)
add_dependencies(ascend_dump adumpHostProto)

target_compile_definitions(ascend_dump PRIVATE
    $<IF:$<STREQUAL:${PRODUCT_SIDE},host>,ADX_LIB_HOST,ADX_LIB>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:WIN32>
    google=ascend_private
    FUNC_VISIBILITY
    ADUMP_SOC_HOST=0
    ${ascendDumpBaseCompileDefinitions}
)

set_target_properties(ascend_dump
    PROPERTIES
    OUTPUT_NAME ascend_dump
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

target_compile_options(ascend_dump PRIVATE
    ${ascendDumpBaseCompileOptions}
)

target_link_options(ascend_dump PRIVATE
    ${ascendDumpBaseLinkOptions}
)

target_include_directories(ascend_dump PRIVATE
    ${ascendDumpHeaderList}
)

target_link_libraries(ascend_dump PRIVATE
    ${ascendDumpBaseLinkLibraries}
)

install(TARGETS ascend_dump OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
)
####################### libascend_dump.so end ###########################

####################### libascend_dump.a begin ###########################
add_library(ascend_dump_static STATIC
    ${ascendDumpSrcList}
)

target_include_directories(ascend_dump_static PRIVATE
    ${ascendDumpHeaderList}
)

add_dependencies(ascend_dump_static ascend_dump_protos)
add_dependencies(ascend_dump_static adumpHostProto)

target_compile_definitions(ascend_dump_static PRIVATE
    $<IF:$<STREQUAL:${PRODUCT_SIDE},host>,ADX_LIB_HOST,ADX_LIB>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:WIN32>
    google=ascend_private
    FUNC_VISIBILITY
    ADUMP_SOC_HOST=0

    # pkg_inc/runtime/runtime 下废弃接口调用错误抑制
    ${ascendDumpBaseCompileDefinitions}
)

target_compile_options(ascend_dump_static PRIVATE
    ${ascendDumpStaticCompileOptions}
)

target_link_options(ascend_dump_static PRIVATE
    ${ascendDumpBaseLinkOptions}
)

target_link_libraries(ascend_dump_static PRIVATE
    ${ascendDumpBaseLinkLibraries}
)

set_target_properties(ascend_dump_static
    PROPERTIES
    OUTPUT_NAME ascend_dump
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

install(TARGETS ascend_dump_static OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
)
####################### libascend_dump.a end ###########################