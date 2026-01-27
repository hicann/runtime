# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
############ adump utest ###########
set(SRC_CODE_ROOT_PATH ${TOP_DIR}/abl/adump)
set(LLT_CODE_ROOT_PATH ${TOP_DIR}/llt/abl/adump)

set(adumpBaseTinyUtestSrc
    ${SRC_CODE_ROOT_PATH}/adump/common/str_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/sys_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/path.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/file.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/lib_path.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/adump_dsmi.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/json_parser.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/adump_error_manager.cpp

    ${SRC_CODE_ROOT_PATH}/adump/exception/dump_file.cpp
    ${SRC_CODE_ROOT_PATH}/adump/exception/kernel_info_collector.cpp
    ${SRC_CODE_ROOT_PATH}/adump/exception/dump_operator.cpp
    ${SRC_CODE_ROOT_PATH}/adump/exception/dump_args.cpp
    ${SRC_CODE_ROOT_PATH}/adump/exception/thread_manager.cpp
    ${SRC_CODE_ROOT_PATH}/adump/exception/exception_info_common.cpp
    ${SRC_CODE_ROOT_PATH}/adump/adump_ascend031/exception/exception_dumper.cpp
    ${SRC_CODE_ROOT_PATH}/adump/adump_ascend031/exception/adx_exception_callback.cpp

    ${SRC_CODE_ROOT_PATH}/adump/adump_ascend031/manage/adump_api.cpp
    ${SRC_CODE_ROOT_PATH}/adump/adump_ascend031/manage/dump_manager.cpp

    ${SRC_CODE_ROOT_PATH}/adump/impl/dump_datatype.cpp
    ${SRC_CODE_ROOT_PATH}/adump/impl/dump_memory.cpp
    ${SRC_CODE_ROOT_PATH}/adump/impl/dump_setting.cpp
    ${SRC_CODE_ROOT_PATH}/adump/impl/dump_tensor.cpp
    ${SRC_CODE_ROOT_PATH}/adump/impl/dump_config_converter.cpp
    ${SRC_CODE_ROOT_PATH}/adump/operator/operator_dumper.cpp
    ${SRC_CODE_ROOT_PATH}/adump/printf/fp16_t.cpp
    ${SRC_CODE_ROOT_PATH}/adump/printf/hifloat.cpp
    ${SRC_CODE_ROOT_PATH}/adump/adump_ascend031/printf/dump_printf.cpp

    ${SRC_CODE_ROOT_PATH}/adump/proto_parse/dump_proto_to_json.cpp

    ${SRC_CODE_ROOT_PATH}/adcore/common/memory_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/file_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/memory_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/string_utils.cpp

    ${SRC_CODE_ROOT_PATH}/adump/common/adump_platform_api/adump_platform_api_device.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/thread.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/thread_mdc.cpp
        ${SRC_CODE_ROOT_PATH}/adump/operator/operator_preliminary/operator_preliminary_device.cpp
)

set(adumpBaseTinyUtestSrcList
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/dump_manager_stest.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/exception_dumper_stest.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adump_api_stest.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/dump_printf_stest.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adx_exception_callback_stest.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/adump_platform_api_device_stest.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/operator_preliminary_device_stest.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/thread_mdc_stest.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/main.cpp
)

set(adumpBaseTinyStubSrcList
    ${CMAKE_CURRENT_SOURCE_DIR}/../adump_base/tools/dump_file_checker.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/../adump_base/tools/case_workspace.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/../adump_base/tools/gert_tensor_builder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/../adump_base/stub/slog_stub.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/mmpa_stub.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/../adump_base/stub/runtime_stub.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/../adump_base/stub/ge_stub.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/../adump_base/stub/gert_stub.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/../adump_base/stub/platform_info_stub.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/../adump_base/stub/drv_stub.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/../adump_base/stub/error_manager_stub.cpp

)

set(adumpBaseTinyProtoList
    "${TOP_DIR}/metadef/proto/op_mapping.proto"
    "${TOP_DIR}/metadef/proto/ge_ir.proto"
    "${TOP_DIR}/metadef/proto/dump_task.proto"
    "${SRC_CODE_ROOT_PATH}/inc/adump/dump_data.proto"
)
protobuf_generate(adump_base_tiny_proto adumpBaseTinyProtoSrc adumBaseTinyProtoHeaders ${adumpBaseTinyProtoList} TARGET)

add_executable(adump_base_tiny_stest
    ${adumpBaseTinyUtestSrc}
    ${adumpBaseTinyProtoSrc}
    ${adumpBaseTinyStubSrcList}
    ${adumpBaseTinyUtestSrcList}
)

add_dependencies(adump_base_tiny_stest adump_base_tiny_proto)

target_include_directories(adump_base_tiny_stest PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/../adump_base/
    ${CMAKE_CURRENT_SOURCE_DIR}/../adump_base/tools/
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/
    ${CMAKE_BINARY_DIR}/proto/adump_base_tiny_proto
    ${SRC_CODE_ROOT_PATH}/adcore/
    ${SRC_CODE_ROOT_PATH}/adcore/common/
    ${SRC_CODE_ROOT_PATH}/adcore/protocol/
    ${SRC_CODE_ROOT_PATH}/adcore/log/
    ${SRC_CODE_ROOT_PATH}/adcore/common/
    ${SRC_CODE_ROOT_PATH}/adump/
    ${SRC_CODE_ROOT_PATH}/adump/common/
    ${SRC_CODE_ROOT_PATH}/adump/common/adump_platform_api/
    ${SRC_CODE_ROOT_PATH}/adump/impl/
    ${SRC_CODE_ROOT_PATH}/adump/operator/
    ${SRC_CODE_ROOT_PATH}/adump/operator/operator_preliminary/
    ${SRC_CODE_ROOT_PATH}/adump/exception/
    ${SRC_CODE_ROOT_PATH}/adump/exception/dump_core/
    ${SRC_CODE_ROOT_PATH}/adump/exception/register_config/
    ${SRC_CODE_ROOT_PATH}/adump/manage/
    ${SRC_CODE_ROOT_PATH}/adump/manage/dump_manager/
    ${SRC_CODE_ROOT_PATH}/adump/printf/
    ${SRC_CODE_ROOT_PATH}/adump/printf/dump_printf/
    ${SRC_CODE_ROOT_PATH}/adump/proto_parse/
    ${SRC_CODE_ROOT_PATH}/external/
    ${TOP_DIR}/abl/libc_sec/include
    ${TOP_DIR}/metadef/inc/
    ${TOP_DIR}/metadef/inc/external
    ${TOP_DIR}/metadef/inc/external/base
    ${TOP_DIR}/ace/npuruntime/runtime/platform/inc
    ${TOP_DIR}/inc/aicpu/
    ${TOP_DIR}/inc/driver/
    ${TOP_DIR}/inc/external/
    ${TOP_DIR}/graphengine/inc/external
    ${TOP_DIR}/ace/npuruntime/acl/inc/
    ${TOP_DIR}/ace/npuruntime/acl/inc/external/acl/
    ${TOP_DIR}/runtime/src/dfx/error_manager
)

target_compile_definitions(adump_base_tiny_stest PRIVATE
    -DADUMP_SOC_HOST=1
    __ADUMP_LLT
    google=ascend_private
    ADX_LIB_HOST
    ADUMP_BASE_DIR=\"${LLT_CODE_ROOT_PATH}/\"
)

target_link_libraries(adump_base_tiny_stest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:runtime_headers>
    $<BUILD_INTERFACE:msprof_headers>
    $<BUILD_INTERFACE:adump_headers>
    -Wl,--no-as-needed
    ascend_protobuf
    c_sec
    json
    -Wl,--as-needed
    -ldl
)

target_compile_options(adump_base_tiny_stest PRIVATE
    -std=c++11
    -Wall
    -Werror
    -Wextra
    -fno-access-control
)

target_link_options(adump_base_tiny_stest PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
)

run_llt_test(
    TARGET adump_base_tiny_stest
    TASK_NUM 1
)