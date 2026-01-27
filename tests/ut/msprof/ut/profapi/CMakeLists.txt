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
    ${MSPROF_SOURCE_DIR}/dvvp/common/platform/platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/config/closed/config_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/validation/param_validation.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/validation/param_validation_closed.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/utils/utils.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/cmd_log/cmd_log.cpp
    ${MSPROF_SOURCE_DIR}/basic/osal/osal.c
    ${MSPROF_SOURCE_DIR}/dvvp/driver/devmgmt/ai_drv_dev_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_acl_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_inner_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_acl_inner_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_impl_inner_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_cann_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_runtime_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_atls_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_tx_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_plugin_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/stub/profapi_stub.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_mstx_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/depend/stub/error_manager/msprof_error_manager_stub.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/platform_interface.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/nano_platform.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/base_analyzer.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_mstx_plugin.cpp
)

add_executable(prof_api_utest
    test/main.cpp
    test/prof_api_utest.cpp
    test/prof_api_plugin_utest.cpp
    test/prof_tx_plugin_utest.cpp
    stub/mmpa_stub.cpp
    ../stub/mmpa_stub.cpp
    ../stub/sec_stub.cpp
    ../stub/hdc-log-stub.cpp
    ../../stub/error_manager_stub.cpp
    ../stub/devdrv_runtime_api_stub.cpp
    ${src_file}
)

set(libmsprofHeaderDir
    ${TOP_DIR}/output/third_party/gtest_shared/include
    ${TOP_DIR}/third_party/libc_sec/include
    ${TOP_DIR}/include/driver
    ${TOP_DIR}/include/external
    ${TOP_DIR}/include/external/acl
    ${TOP_DIR}/src/dfx/error_manager
    ${TOP_DIR}/src/inc
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/msproftx/mstx/inc
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/closed
    ${MSPROF_SOURCE_DIR}/dvvp/common/config/closed
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/inc
)

target_include_directories(prof_api_utest PRIVATE
    ${libmsprofHeaderDir}
    ${MSPROF_SOURCE_DIR}/dvvp
    ${MSPROF_SOURCE_DIR}/dvvp/common/logger
    ${MSPROF_SOURCE_DIR}/dvvp/common
    ${MSPROF_SOURCE_DIR}/dvvp/common/platform
    ${MSPROF_SOURCE_DIR}/dvvp/common/utils
    ${MSPROF_SOURCE_DIR}/dvvp/common/config
    ${MSPROF_SOURCE_DIR}/dvvp/common/validation
    ${MSPROF_SOURCE_DIR}/dvvp/common/cmd_log
    ${MSPROF_SOURCE_DIR}/basic/osal
    ${MSPROF_SOURCE_DIR}/dvvp/driver/inc
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/inc
    ${MSPROF_SOURCE_DIR}/dvvp/depend/include/stub
    ${MSPROF_SOURCE_DIR}/dvvp/transport
    ${MSPROF_SOURCE_DIR}/dvvp/depend/include/wrapper
)

target_compile_options(prof_api_utest PRIVATE
    -g
    -pipe
    -Wall
    -fno-access-control
)

target_compile_definitions(prof_api_utest PRIVATE
    C_SEC
    __PROF_LLT
    google=ascend_private
    PROF_API_STUB
)

target_link_libraries(prof_api_utest PRIVATE
    $<BUILD_INTERFACE:msprof_utestonetrack_pub>
)

set_target_properties(prof_api_utest
    PROPERTIES
    OUTPUT_NAME profapi_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)


####################### prof_api_c_utest ###########################
set(src_file
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_avp_inner_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_avp_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_plugin.cpp
)

add_executable(prof_api_c_utest
    test/main.cpp
    test/prof_api_c_utest.cpp
    stub/mmpa_stub.cpp
    ../stub/sec_stub.cpp
    ../stub/hdc-log-stub.cpp
    ${src_file}
)

target_include_directories(prof_api_c_utest PRIVATE
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


target_compile_options(prof_api_c_utest PRIVATE
    -g
    -pipe
    -Wall
    -fno-access-control
)

target_compile_definitions(prof_api_c_utest PRIVATE
    C_SEC
    __PROF_LLT
    MSPROF_C
    google=ascend_private
)

target_link_libraries(prof_api_c_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:msprof_headers>
    c_sec
    ascend_protobuf
)

set_target_properties(prof_api_c_utest
    PROPERTIES
    OUTPUT_NAME prof_api_c_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

