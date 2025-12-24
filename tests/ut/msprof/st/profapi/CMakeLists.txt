# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(src_file
    ${MSPROF_SOURCE_DIR}/dvvp/common/config/config_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/validation/param_validation.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/utils/utils.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/cmd_log/cmd_log.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/platform/platform.cpp
    ${MSPROF_SOURCE_DIR}/basic/osal/osal.c
    ${MSPROF_SOURCE_DIR}/dvvp/driver/devmgmt/ai_drv_dev_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_acl_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_tx_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_atls_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_cann_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_runtime_plugin.cpp 
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_inner_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_acl_inner_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_impl_inner_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_plugin_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/stub/profapi_stub.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/platform_interface.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/base_analyzer.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/nano_platform.cpp
)

add_executable(prof_api_stest
    test/main.cpp
    test/prof_api_stest.cpp
    test/prof_api_plugin_stest.cpp
    test/prof_inner_api_stest.cpp
    stub/mmpa_stub.cpp
    ../stub/mmpa_stub.cpp
    ../stub/hdc-log-stub.cpp
    ../stub/devdrv_runtime_api_stub.cpp
    ../stub/error_manager_stub.cpp
    ${src_file}
)

target_include_directories(prof_api_stest PRIVATE
    ${TOP_DIR}/ace/npuruntime/inc
    ${TOP_DIR}/ace/npuruntime/inc/external
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/inc/external
    ${TOP_DIR}/metadef/inc
    ${TOP_DIR}/metadef/inc/external
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/inc/
    ${MSPROF_SOURCE_DIR}/dvvp/
    ${MSPROF_SOURCE_DIR}/dvvp/common
    ${MSPROF_SOURCE_DIR}/dvvp/common/utils
    ${MSPROF_SOURCE_DIR}/dvvp/common/cmd_log
    ${MSPROF_SOURCE_DIR}/dvvp/common/logger
    ${MSPROF_SOURCE_DIR}/dvvp/common/config
    ${MSPROF_SOURCE_DIR}/dvvp/common/validation
    ${MSPROF_SOURCE_DIR}/dvvp/common/platform
    ${MSPROF_SOURCE_DIR}/basic/osal
    ${MSPROF_SOURCE_DIR}/dvvp/driver/inc
    ${MSPROF_SOURCE_DIR}/dvvp/depend/include/stub
    ${MSPROF_SOURCE_DIR}/../inc/toolchain
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/inc
    ${MSPROF_SOURCE_DIR}/dvvp/transport
    ${MSPROF_SOURCE_DIR}/dvvp/depend/include/wrapper
    ${TOP_DIR}/ace/npuruntime/acl/third_party/inc/driver
    stub/
)


target_compile_options(prof_api_stest PRIVATE
    -g
    -pipe
    -Wall
    -std=c++11
    -fno-access-control
    -Werror
)

target_compile_definitions(prof_api_stest PRIVATE
    C_SEC
    __PROF_LLT
    google=ascend_private
    PROF_API_STUB
)

target_link_libraries(prof_api_stest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:msprof_headers>
    c_sec
    ascend_protobuf
)

set_target_properties(prof_api_stest
    PROPERTIES
    OUTPUT_NAME profapi_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

run_llt_test(
    TARGET prof_api_stest
    TASK_NUM 1
)



####################### prof_api_c_stest ###########################
set(src_file
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_avp_inner_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_avp_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_plugin.cpp
)

add_executable(prof_api_c_stest
    test/main.cpp
    test/prof_api_c_stest.cpp
    stub/mmpa_stub.cpp
    ../stub/hdc-log-stub.cpp
    ${src_file}
)

target_include_directories(prof_api_c_stest PRIVATE
    ${TOP_DIR}/ace/npuruntime/inc
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/inc/external
    ${TOP_DIR}/metadef/inc
    ${TOP_DIR}/ace/npuruntime/inc
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/inc/
    ${MSPROF_SOURCE_DIR}/dvvp/common
    ${MSPROF_SOURCE_DIR}/dvvp/common/logger
    ${MSPROF_SOURCE_DIR}/basic/osal
    ${MSPROF_SOURCE_DIR}/../inc/toolchain
    stub/
)


target_compile_options(prof_api_c_stest PRIVATE
    -g
    -pipe
    -Wall
    -std=c++11
    -fno-access-control
    -Werror
)

target_compile_definitions(prof_api_c_stest PRIVATE
    C_SEC
    __PROF_LLT
    MSPROF_C
    google=ascend_private
)

target_link_libraries(prof_api_c_stest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:msprof_headers>
    c_sec
    ascend_protobuf
)

set_target_properties(prof_api_c_stest
    PROPERTIES
    OUTPUT_NAME prof_api_c_stest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

run_llt_test(
    TARGET prof_api_c_stest
    TASK_NUM 1
)
