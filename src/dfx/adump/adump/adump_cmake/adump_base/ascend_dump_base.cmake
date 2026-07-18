# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

set(ascendDumpBaseSrcList
    ${ADUMP_ADUMP_DIR}/adx_dump_process.cpp
    ${ADUMP_ADUMP_DIR}/adx_dump_record.cpp
    ${ADUMP_ADUMP_DIR}/common/adump_dsmi.cpp
    ${ADUMP_ADUMP_DIR}/common/platform/cloud_v2_platform.cpp
    ${ADUMP_ADUMP_DIR}/common/platform/cloud_v4_platform.cpp
    ${ADUMP_ADUMP_DIR}/common/platform/dc_platform.cpp
    ${ADUMP_ADUMP_DIR}/common/file.cpp
    ${ADUMP_ADUMP_DIR}/common/json_parser.cpp
    ${ADUMP_ADUMP_DIR}/common/lib_path.cpp
    ${ADUMP_ADUMP_DIR}/common/path.cpp
    ${ADUMP_ADUMP_DIR}/common/str_utils.cpp
    ${ADUMP_ADUMP_DIR}/common/sys_utils.cpp
    ${ADUMP_ADUMP_DIR}/exception/adx_exception_callback.cpp
    ${ADUMP_ADUMP_DIR}/exception/dump_args.cpp
    ${ADUMP_ADUMP_DIR}/exception/dfx_args_parser.cpp
    ${ADUMP_ADUMP_DIR}/exception/dump_args_callback.cpp
    ${ADUMP_ADUMP_DIR}/exception/dump_core/dump_core.cpp
    ${ADUMP_ADUMP_DIR}/exception/dump_core/dump_core_register.cpp
    ${ADUMP_ADUMP_DIR}/exception/dump_ELF.cpp
    ${ADUMP_ADUMP_DIR}/exception/dump_file.cpp
    ${ADUMP_ADUMP_DIR}/exception/dump_operator.cpp
    ${ADUMP_ADUMP_DIR}/exception/dump_tensor_plugin.cpp
    ${ADUMP_ADUMP_DIR}/exception/exception_dumper.cpp
    ${ADUMP_ADUMP_DIR}/exception/exception_dumper_platform.cpp
    ${ADUMP_ADUMP_DIR}/exception/exception_info_common.cpp
    ${ADUMP_ADUMP_DIR}/exception/kernel_info_collector.cpp
    ${ADUMP_ADUMP_DIR}/exception/kernel_symbol_locator.cpp
    ${ADUMP_ADUMP_DIR}/exception/kernel_pc_fixer.cpp
    ${ADUMP_ADUMP_DIR}/exception/register_config/register_config.cpp
    ${ADUMP_ADUMP_DIR}/exception/thread_manager.cpp
    ${ADUMP_ADUMP_DIR}/impl/dump_datatype.cpp
    ${ADUMP_ADUMP_DIR}/impl/dump_memory.cpp
    ${ADUMP_ADUMP_DIR}/impl/dump_setting.cpp
    ${ADUMP_ADUMP_DIR}/impl/dump_tensor.cpp
    ${ADUMP_ADUMP_DIR}/impl/dump_config_converter.cpp
    ${ADUMP_ADUMP_DIR}/manage/adump_api.cpp
    ${ADUMP_ADUMP_DIR}/manage/adump_api_platform.cpp
    ${ADUMP_ADUMP_DIR}/manage/dump_manager/dump_manager.cpp
    ${ADUMP_ADUMP_DIR}/manage/dump_manager/dump_stream_info.cpp
    ${ADUMP_ADUMP_DIR}/manage/dump_manager/dump_manager_platform.cpp
    ${ADUMP_ADUMP_DIR}/operator/operator_dumper.cpp
    ${ADUMP_ADUMP_DIR}/operator/kernel_dfx_dumper.cpp
    ${ADUMP_ADUMP_DIR}/printf/dump_printf/dump_printf.cpp
    ${ADUMP_ADUMP_DIR}/printf/dump_printf/dump_printf_platform.cpp
    ${ADUMP_ADUMP_DIR}/printf/fp16_t.cpp
    ${ADUMP_ADUMP_DIR}/printf/hifloat.cpp
)

set(ascendDumpCoupleBaseSrcList
    ${ascendDumpBaseSrcList}
    ${ADUMP_ADUMP_DIR}/common/adump_platform_api/adump_platform_api_device.cpp
    ${ADUMP_ADUMP_DIR}/operator/operator_preliminary/operator_preliminary_device.cpp
)

set(ascendDumpDeCoupleBaseSrcList
    ${ascendDumpBaseSrcList}
    ${ADUMP_ADUMP_DIR}/common/adump_platform_api/adump_platform_api.cpp
    ${ADUMP_ADUMP_DIR}/operator/operator_preliminary/operator_preliminary.cpp
    ${ADUMP_ADUMP_DIR}/operator/operator_preliminary/operator_preliminary_platform.cpp
)

set(ascendDumpBaseHeaderList
    ${RUNTIME_DIR}/src/dfx/error_manager
    ${CMAKE_BINARY_DIR}/proto/ascend_dump_protos
    ${CMAKE_BINARY_DIR}/proto/adumpHostProto
    ${ADUMP_DIR}/adcore/
    ${ADUMP_ADUMP_DIR}/
    ${ADUMP_ADUMP_DIR}/common/
    ${ADUMP_ADUMP_DIR}/common/adump_platform_api/
    ${ADUMP_ADUMP_DIR}/exception/
    ${ADUMP_ADUMP_DIR}/exception/dump_core/
    ${ADUMP_ADUMP_DIR}/exception/register_config/
    ${ADUMP_ADUMP_DIR}/impl/
    ${ADUMP_ADUMP_DIR}/manage/
    ${ADUMP_ADUMP_DIR}/manage/dump_manager/
    ${ADUMP_ADUMP_DIR}/operator/
    ${ADUMP_ADUMP_DIR}/operator/operator_preliminary/
    ${ADUMP_ADUMP_DIR}/printf/
    ${ADUMP_ADUMP_DIR}/printf/dump_printf/
    ${LIBC_SEC_HEADER}
    ${PROJECT_TOP_DIR}/pkg_inc
    ${ADUMP_DEPENDENCE_INC}/aicpu/
)


# pkg_inc/runtime/runtime 下废弃接口调用错误抑制
set(ascendDumpBaseCompileDefinitions
    RT_RUNTIME_DISABLE_DEPRECATED_WARNINGS
)

set(ascendDumpBaseCompileOptions
    -fno-common
    -fstack-protector-all
    -Wall
    -Werror
    -Wextra
    -Wfloat-equal
    -Wformat
    -fvisibility=default
    -fvisibility-inlines-hidden
    $<$<CONFIG:Debug>:-ftrapv>
    $<$<CONFIG:Debug>:-D_FORTIFY_SOURCE=2 -Os>
    $<$<CONFIG:Release>:-D_FORTIFY_SOURCE=2 -Os>
)

set(ascendDumpBaseLinkOptions
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,-Bsymbolic
    -Wl,--exclude-libs,ALL
)

set(ascendDumpBaseLinkLibraries
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:npu_runtime_headers>
    $<BUILD_INTERFACE:npu_runtime_inner_headers>
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

set(ascendDumpStaticCompileOptions
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
