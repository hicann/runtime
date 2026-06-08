# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
############ adump_tiny utest ################################

set(ADUMP_TINY_UT_ROOT_PATH ${TOP_DIR}/tests/ut/adump/adump_tiny)
set(ADUMP_BASE_UT_ROOT_PATH ${TOP_DIR}/tests/ut/adump/adump_base)

########################### adump proto for test #######################
set(adumpTinyProtoList
    "${TOP_DIR}/src/dfx/adump/proto/op_mapping.proto"
    "${TOP_DIR}/src/dfx/adump/proto/op_mapping_v2.proto"
    "${TOP_DIR}/src/dfx/adump/proto/dump_task.proto"
)

protobuf_generate(adump_tiny_proto adumpTinyProtoSrc adumpTinyProtoHeaders ${adumpTinyProtoList} TARGET)
add_dependencies(adump_tiny_proto ascend_protobuf_static)
########################################################################

set(adumpTinySrcList
    ${SRC_CODE_ROOT_PATH}/adcore/common/memory_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/file_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adcore/common/string_utils.cpp

    ${SRC_CODE_ROOT_PATH}/adump/common/str_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/sys_utils.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/path.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/file.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/lib_path.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/adump_dsmi.cpp
    ${SRC_CODE_ROOT_PATH}/adump/common/json_parser.cpp

    ${SRC_CODE_ROOT_PATH}/adump/adump_ascend031/manage/dump_manager.cpp

    ${SRC_CODE_ROOT_PATH}/adump/impl/dump_datatype.cpp
    ${SRC_CODE_ROOT_PATH}/adump/impl/dump_memory.cpp
    ${SRC_CODE_ROOT_PATH}/adump/impl/dump_setting.cpp
    ${SRC_CODE_ROOT_PATH}/adump/impl/dump_tensor.cpp
    ${SRC_CODE_ROOT_PATH}/adump/impl/dump_config_converter.cpp

    ${SRC_CODE_ROOT_PATH}/adump/printf/fp16_t.cpp
    ${SRC_CODE_ROOT_PATH}/adump/printf/hifloat.cpp

    ${adumpTinyProtoSrc}
)

set(adumpTinyUtestSrcList
    ${ADUMP_TINY_UT_ROOT_PATH}/testcase/dump_manager_utest.cpp
    ${ADUMP_TINY_UT_ROOT_PATH}/testcase/main.cpp
)

set(adumpTinyStubSrcList
    ${ADUMP_BASE_UT_ROOT_PATH}/stub/slog_stub.cpp
    ${ADUMP_TINY_UT_ROOT_PATH}/stub/mmpa_stub.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/stub/runtime_stub.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/stub/platform_info_stub.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/stub/drv_stub.cpp
    ${ADUMP_BASE_UT_ROOT_PATH}/stub/error_manager_stub.cpp
)

set(adumpTinyHeaders
    ${SRC_CODE_ROOT_PATH}/inc/adump
    ${SRC_CODE_ROOT_PATH}/adcore
    ${SRC_CODE_ROOT_PATH}/adcore/common
    ${SRC_CODE_ROOT_PATH}/adcore/log

    ${SRC_CODE_ROOT_PATH}/adump/adump_ascend031/
    ${SRC_CODE_ROOT_PATH}/adump/adump_ascend031/manage/
    ${SRC_CODE_ROOT_PATH}/adump/adump_ascend031/exception/
    ${SRC_CODE_ROOT_PATH}/adump/adump_ascend031/printf/

    ${SRC_CODE_ROOT_PATH}/adump/
    ${SRC_CODE_ROOT_PATH}/adump/common/
    ${SRC_CODE_ROOT_PATH}/adump/impl/
    ${SRC_CODE_ROOT_PATH}/adump/exception/
    ${SRC_CODE_ROOT_PATH}/adump/manage/
    ${SRC_CODE_ROOT_PATH}/adump/printf/
    ${SRC_CODE_ROOT_PATH}/adump/proto/
    ${SRC_CODE_ROOT_PATH}/external/
    ${TOP_DIR}/include/driver
    ${TOP_DIR}/include/external
    ${TOP_DIR}/include/external/acl
    ${TOP_DIR}/pkg_inc/
    ${TOP_DIR}/pkg_inc/dump/

    ${ADUMP_TINY_UT_ROOT_PATH}/
    ${ADUMP_BASE_UT_ROOT_PATH}/
    ${ADUMP_BASE_UT_ROOT_PATH}/stub/

    ${ASCEND_PROTOBUF_SHARED_INCLUDE_DIR}
    ${CMAKE_BINARY_DIR}/proto/adump_tiny_proto
)

add_executable(adump_tiny_utest
    ${adumpTinySrcList}
    ${adumpTinyStubSrcList}
    ${adumpTinyUtestSrcList}
)

add_dependencies(adump_tiny_utest adump_tiny_proto)

target_include_directories(adump_tiny_utest PRIVATE
    ${LIBC_SEC_HEADER}
    ${adumpTinyHeaders}
)

target_compile_definitions(adump_tiny_utest PRIVATE
    -DADUMP_SOC_HOST=1
    __ADUMP_LLT
    google=ascend_private
    ADX_LIB_HOST
    ADUMP_BASE_DIR=\"${ADUMP_BASE_UT_ROOT_PATH}/\"
)

target_link_libraries(adump_tiny_utest PRIVATE
    $<BUILD_INTERFACE:adx_utestonetrack_pub>
    -Wl,--no-as-needed
    json
    -Wl,--as-needed
    -ldl
)

target_compile_options(adump_tiny_utest PRIVATE
    -Wall
    -Werror
    -Wextra
    -fno-access-control
)

target_link_options(adump_tiny_utest PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
)