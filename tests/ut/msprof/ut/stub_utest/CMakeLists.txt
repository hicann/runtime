# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
add_executable(stub_file_utest
    ${MSPROF_SOURCE_DIR}/dvvp/profhal/adx/wrapper/hdc_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profhal/adx/wrapper/adx_prof_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profhal/adx/wrapper/memory_utils.cpp
    ${MSPROF_SOURCE_DIR}/basic/osal/osal.c
    ${MSPROF_SOURCE_DIR}/dvvp/depend/wrapper/error_manager/msprof_error_manager.cpp
    test/main.cpp
    test/hdc_api_utest.cpp
    #test/msprof_err_mgr_utest.cpp
    test/adx_prof_api_utest.cpp
    ../stub/mmpa_stub.cpp
    ../stub/profile_drv_user_stub.cpp
    ../stub/hdc-log-stub.cpp
    ../stub/devdrv_runtime_api_stub.cpp
    ../stub/ide_hdc_stub.cc
    ../stub/error_manager_stub.cpp
    stub/mmpa_stub.cpp

)

set(libmsprofHeaderDir
    ${TOP_DIR}/output/third_party/gtest_shared/include
    ${TOP_DIR}/include/driver
    ${TOP_DIR}/include/external
    ${TOP_DIR}/include/external/acl
    ${TOP_DIR}/src/dfx/error_manager
    ${TOP_DIR}/src/inc
    ${TOP_DIR}/pkg_inc/dump
    ${TOP_DIR}/pkg_inc/aicpu
    ${TOP_DIR}/src/dfx/adump/inc/metadef/external
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/msproftx/mstx/inc
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform/open
    ${MSPROF_SOURCE_DIR}/dvvp/common/config/open
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/inc
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/devprof/include
)

target_include_directories(stub_file_utest PRIVATE
    ${libmsprofHeaderDir}
    ${TOP_DIR}/abl/libc_sec/include
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/ace/npuruntime/inc
    ${TOP_DIR}/abl/msprof/inc
    ${TOP_DIR}/metadef/inc
    ${TOP_DIR}/metadef/inc/external
    ${MSPROF_SOURCE_DIR}/dvvp/common/logger
    ${MSPROF_SOURCE_DIR}/dvvp/common/
    ${MSPROF_SOURCE_DIR}/basic/osal
    ${MSPROF_SOURCE_DIR}/dvvp/profhal/adx/inc
    ${MSPROF_SOURCE_DIR}/dvvp/depend/include/wrapper
    ${MSPROF_SOURCE_DIR}/dvvp
)


target_compile_options(stub_file_utest PRIVATE
    -g
    -pipe
    -Wall
    -fno-access-control
    -Wfloat-equal
    -Wextra
)

target_compile_definitions(stub_file_utest PRIVATE
    C_SEC
    __PROF_LLT
    google=ascend_private
)

target_link_libraries(stub_file_utest PRIVATE
    $<BUILD_INTERFACE:msprof_utestonetrack_pub>
)

set_target_properties(stub_file_utest
    PROPERTIES
    OUTPUT_NAME stub_file_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

