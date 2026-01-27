# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

####################### libascend_dump.so begin ###########################
set(ascendDumpSrcList
    ${adumpServerSrcList}
    ${ADUMP_ADUMP_DIR}/adump_ascend031/exception/adx_exception_callback.cpp
    ${ADUMP_ADUMP_DIR}/adump_ascend031/exception/exception_dumper_platform.cpp
    ${ADUMP_ADUMP_DIR}/adump_ascend031/manage/adump_api_platform.cpp
    ${ADUMP_ADUMP_DIR}/adump_ascend031/manage/dump_manager.cpp
    ${ADUMP_ADUMP_DIR}/adump_ascend031/printf/dump_printf.cpp
    ${ADUMP_ADUMP_DIR}/common/adump_dsmi.cpp
    ${ADUMP_ADUMP_DIR}/common/adump_error_manager.cpp
    ${ADUMP_ADUMP_DIR}/common/file.cpp
    ${ADUMP_ADUMP_DIR}/common/json_parser.cpp
    ${ADUMP_ADUMP_DIR}/common/lib_path.cpp
    ${ADUMP_ADUMP_DIR}/common/path.cpp
    ${ADUMP_ADUMP_DIR}/common/str_utils.cpp
    ${ADUMP_ADUMP_DIR}/common/sys_utils.cpp
    ${ADUMP_ADUMP_DIR}/exception/dump_args.cpp
    ${ADUMP_ADUMP_DIR}/exception/kernel_info_collector.cpp
    ${ADUMP_ADUMP_DIR}/exception/dump_operator.cpp
    ${ADUMP_ADUMP_DIR}/exception/dump_file.cpp
    ${ADUMP_ADUMP_DIR}/exception/exception_info_common.cpp
    ${ADUMP_ADUMP_DIR}/exception/thread_manager.cpp
    ${ADUMP_ADUMP_DIR}/exception/exception_dumper.cpp
    ${ADUMP_ADUMP_DIR}/impl/dump_datatype.cpp
    ${ADUMP_ADUMP_DIR}/impl/dump_memory.cpp
    ${ADUMP_ADUMP_DIR}/impl/dump_setting.cpp
    ${ADUMP_ADUMP_DIR}/impl/dump_tensor.cpp
    ${ADUMP_ADUMP_DIR}/impl/dump_config_converter.cpp
    ${ADUMP_ADUMP_DIR}/manage/adump_api.cpp
)

set(ascendDumpHeaderList
    ${adumpServerHeaders}
    ${CMAKE_BINARY_DIR}/proto/ascend_dump_protos
    ${CMAKE_BINARY_DIR}/proto/adumpHostProto
    ${ADUMP_ADUMP_DIR}/adump_ascend031/exception/
    ${ADUMP_ADUMP_DIR}/adump_ascend031/manage/
    ${ADUMP_DIR}/adcore/
    ${ADUMP_ADUMP_DIR}/
    ${ADUMP_ADUMP_DIR}/common/
    ${ADUMP_ADUMP_DIR}/exception/
    ${ADUMP_ADUMP_DIR}/manage/
    ${ADUMP_ADUMP_DIR}/impl/
    ${ADUMP_ADUMP_DIR}/operator/
    ${ADUMP_ADUMP_DIR}/printf/
    ${ADUMP_ADUMP_DIR}/printf/dump_printf/
    ${LIBC_SEC_HEADER}
    ${PROJECT_TOP_DIR}/pkg_inc
    ${PROJECT_TOP_DIR}/include/external/acl
    ${PROJECT_TOP_DIR}/include/external
    ${ADUMP_DEPENDENCE_INC}/aicpu/
)

add_library(ascend_dump SHARED
    ${ascendDumpSrcList}
)

target_include_directories(ascend_dump PRIVATE
    ${ascendDumpHeaderList}
)

add_dependencies(ascend_dump ascend_dump_protos)
add_dependencies(ascend_dump adumpHostProto)

target_compile_definitions(ascend_dump PRIVATE
    $<IF:$<STREQUAL:${PRODUCT_SIDE},host>,ADX_LIB_HOST,ADX_LIB>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:WIN32>
    google=ascend_private
    FUNC_VISIBILITY
    ADUMP_SOC_HOST=0
)

set_target_properties(ascend_dump
    PROPERTIES
    OUTPUT_NAME ascend_dump
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

target_compile_options(ascend_dump PRIVATE
    -fno-common
    -fstack-protector-all
    -Wall
    -Werror
    -Wextra
    -Wfloat-equal
    -Wformat
    -fvisibility=hidden
    -fvisibility-inlines-hidden
    $<$<CONFIG:Debug>:-ftrapv>
    $<$<CONFIG:Debug>:-D_FORTIFY_SOURCE=2 -Os>
    $<$<CONFIG:Release>:-D_FORTIFY_SOURCE=2 -Os>
)

target_link_options(ascend_dump PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,-Bsymbolic
    -Wl,--exclude-libs,ALL
)

target_link_libraries(ascend_dump PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:npu_runtime_headers>
    $<BUILD_INTERFACE:msprof_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:adcore_headers>
    $<BUILD_INTERFACE:adcore>
    json
    -Wl,--no-as-needed
    ascend_protobuf
    unified_dlog
    runtime
    -Wl,--as-needed
    -ldl
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
)

target_compile_options(ascend_dump_static PRIVATE
    -fno-common
    -fstack-protector-all
    -Wall
    -Werror
    -Wextra
    -Wfloat-equal
    -fvisibility=hidden
    -fvisibility-inlines-hidden
    $<$<CONFIG:Debug>:-ftrapv>
    $<$<CONFIG:Debug>:-D_FORTIFY_SOURCE=2 -O2>
    $<$<CONFIG:Release>:-D_FORTIFY_SOURCE=2 -O2>
)

target_link_options(ascend_dump_static PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,-Bsymbolic
    -Wl,--exclude-libs,ALL
)

target_link_libraries(ascend_dump_static PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:npu_runtime_headers>
    $<BUILD_INTERFACE:msprof_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:adcore_headers>
    $<BUILD_INTERFACE:adcore>
    json
    -Wl,--no-as-needed
    ascend_protobuf
    unified_dlog
    runtime
    -Wl,--as-needed
    -ldl
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
