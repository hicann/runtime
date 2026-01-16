# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
########################### adump base utest ################################
include_directories(${OPEN_SOURCE_DIR}/boost)
include_directories(${OPEN_SOURCE_DIR}/mockcpp_src/include)

set(ADUMP_BASE_UT_ROOT_PATH ${TOP_DIR}/tests/ut/adump/adump_base)

########################### adump proto for test #######################
set(adumpBaseProtoList
    "${TOP_DIR}/src/dfx/adump/proto/op_mapping.proto"
    "${TOP_DIR}/src/dfx/adump/proto/dump_task.proto"
)

protobuf_generate(adump_base_proto adumpBaseProtoSrc adumBaseProtoHeaders ${adumpBaseProtoList} TARGET)
add_dependencies(adump_base_proto protobuf_host_build ascend_protobuf_static)
########################################################################

set(adumpBaseSrcList
    ${SRC_CODE_ROOT_PATH}/adcore/common/memory_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/file_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/memory_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/string_utils.cpp

    ${SRC_CODE_ROOT_PATH}/adump/common/str_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/sys_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/path.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/file.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/lib_path.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/adump_dsmi.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/adump_platform_api/adump_platform_api.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/json_parser.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/adump_error_manager.cpp

    ${SRC_CODE_ROOT_PATH}/adump/manage/adump_api.cpp
    ${SRC_CODE_ROOT_PATH}/adump/manage/adump_api_platform.cpp
    ${SRC_CODE_ROOT_PATH}/adump/manage/dump_manager/dump_manager.cpp
    ${SRC_CODE_ROOT_PATH}/adump/manage/dump_manager/dump_manager_platform.cpp
    ${SRC_CODE_ROOT_PATH}/adump/impl/dump_datatype.cpp
    ${SRC_CODE_ROOT_PATH}/adump/impl/dump_memory.cpp
    ${SRC_CODE_ROOT_PATH}/adump/impl/dump_setting.cpp
    ${SRC_CODE_ROOT_PATH}/adump/impl/dump_tensor.cpp
    ${SRC_CODE_ROOT_PATH}/adump/impl/dump_config_converter.cpp
    ${SRC_CODE_ROOT_PATH}/adump/operator/operator_dumper.cpp
    ${SRC_CODE_ROOT_PATH}/adump/operator/operator_preliminary/operator_preliminary.cpp
    ${SRC_CODE_ROOT_PATH}/adump/operator/operator_preliminary/operator_preliminary_platform.cpp
    ${SRC_CODE_ROOT_PATH}/adump/exception/dump_file.cpp
    ${SRC_CODE_ROOT_PATH}/adump/exception/kernel_info_collector.cpp
    ${SRC_CODE_ROOT_PATH}/adump/exception/dump_operator.cpp
    ${SRC_CODE_ROOT_PATH}/adump/exception/dump_args.cpp
    ${SRC_CODE_ROOT_PATH}/adump/exception/thread_manager.cpp
    ${SRC_CODE_ROOT_PATH}/adump/exception/exception_dumper.cpp
    ${SRC_CODE_ROOT_PATH}/adump/exception/dump_ELF.cpp
    ${SRC_CODE_ROOT_PATH}/adump/exception/dump_core/dump_core.cpp
    ${SRC_CODE_ROOT_PATH}/adump/exception/dump_core/dump_core_register.cpp
    ${SRC_CODE_ROOT_PATH}/adump/exception/dump_core/dump_core_platform.cpp
    ${SRC_CODE_ROOT_PATH}/adump/exception/register_config/register_config.cpp
    ${SRC_CODE_ROOT_PATH}/adump/exception/register_config/register_config_platform.cpp
    ${SRC_CODE_ROOT_PATH}/adump/exception/exception_info_common.cpp
    ${SRC_CODE_ROOT_PATH}/adump/exception/dump_tensor_plugin.cpp
    ${SRC_CODE_ROOT_PATH}/adump/exception/adx_exception_callback.cpp
    ${SRC_CODE_ROOT_PATH}/adump/printf/dump_printf/dump_printf.cpp
    ${SRC_CODE_ROOT_PATH}/adump/printf/dump_printf/dump_printf_platform.cpp
    ${SRC_CODE_ROOT_PATH}/adump/printf/fp16_t.cpp
    ${SRC_CODE_ROOT_PATH}/adump/printf/hifloat.cpp
    ${SRC_CODE_ROOT_PATH}/adump/adx_dump_record.cpp
    ${SRC_CODE_ROOT_PATH}/adump/adx_dump_process.cpp

    ${adumpBaseProtoSrc}
)

set(adumpBaseUtestSrcList
    ${ADUMP_BASE_UT_ROOT_PATH}/testcase/common/common_path_utest.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/testcase/common/common_file_utest.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/testcase/common/common_sys_utils_utest.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/testcase/dump_manager/dump_manager_utest.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/testcase/impl/adump_api_utest.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/testcase/impl/dump_datatype_utest.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/testcase/impl/dump_memory_utest.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/testcase/impl/dump_tensor_utest.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/testcase/impl/dump_setting_utest.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/testcase/impl/dump_config_converter_utest.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/testcase/operator/operator_preliminary_utest.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/testcase/operator/operator_preliminary_platform_utest.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/testcase/exception/dump_args_utest.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/testcase/exception/dump_ELF_utest.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/testcase/exception/dump_core_utest.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/testcase/exception/register_config_platform_utest.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/testcase/printf/dump_printf_utest.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/testcase/printf/dump_printf_platform_utest.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/testcase/main.cpp
)

set(adumpBaseStubSrcList
    ${ADUMP_BASE_UT_ROOT_PATH}/tools/dump_file_checker.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/tools/case_workspace.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/tools/utils.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/stub/slog_stub.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/stub/mmpa_stub.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/stub/runtime_stub.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/stub/platform_info_stub.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/stub/drv_stub.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/stub/error_manager_stub.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/stub/dump_exception_stub.cpp
)

set(adumpBaseHeaders
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
    ${SRC_CODE_ROOT_PATH}/inc/metadef/
    ${SRC_CODE_ROOT_PATH}/inc/metadef/external
    ${TOP_DIR}/include/driver
    ${TOP_DIR}/include/external
    ${TOP_DIR}/include/external/acl
    ${TOP_DIR}/pkg_inc/
    ${TOP_DIR}/pkg_inc/dump/
    ${TOP_DIR}/pkg_inc/aicpu_sched/

    ${ADUMP_BASE_UT_ROOT_PATH}/
    ${ADUMP_BASE_UT_ROOT_PATH}/tools/
    ${ADUMP_BASE_UT_ROOT_PATH}/stub/

    ${ASCEND_PROTOBUF_SHARED_INCLUDE_DIR}
    ${CMAKE_BINARY_DIR}/proto/adump_base_proto
)

add_executable(adump_base_utest
    ${adumpBaseSrcList}
    ${adumpBaseStubSrcList}
    ${adumpBaseUtestSrcList}
)

add_dependencies(adump_base_utest adump_base_proto)

target_include_directories(adump_base_utest PRIVATE
    ${LIBC_SEC_HEADER}
    ${adumpBaseHeaders}
)

target_compile_definitions(adump_base_utest PRIVATE
    -DADUMP_SOC_HOST=1
    __ADUMP_LLT
    google=ascend_private
    ADX_LIB_HOST
    ADUMP_BASE_DIR=\"${ADUMP_BASE_UT_ROOT_PATH}/\"
)

target_link_libraries(adump_base_utest PRIVATE
    $<BUILD_INTERFACE:adx_utestonetrack_pub>
    -Wl,--no-as-needed
    json
    -Wl,--as-needed
    -ldl
)

target_compile_options(adump_base_utest PRIVATE
    -Wall
    -Werror
    -Wextra
    -fno-access-control
)

target_link_options(adump_base_utest PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
)