# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
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
    ${MSPROF_SOURCE_DIR}/dvvp/driver/devmgmt/msprof_drv_api.cpp
    test/main.cpp
    test/hdc_api_utest.cpp
    test/msprof_err_mgr_utest.cpp
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
    ${LIBC_SEC_HEADER}
    ${TOP_DIR}/output/third_party/gtest_shared/include
    ${TOP_DIR}/third_party/libc_sec/include
    ${TOP_DIR}/include/driver
    ${TOP_DIR}/include/external
    ${TOP_DIR}/include/external/acl
    ${TOP_DIR}/src/dfx/error_manager
    ${TOP_DIR}/src/inc
    ${TOP_DIR}/src/dfx/adump/inc
    ${TOP_DIR}/src/dfx/adump/inc/adump
    ${TOP_DIR}/src/dfx/adump/inc/metadef
    ${TOP_DIR}/pkg_inc/aicpu_sched
    ${TOP_DIR}/src/dfx/adump/inc/metadef/external
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/msproftx/mstx/inc
    ${MSPROF_SOURCE_DIR}/dvvp/profimpl/platform
    ${MSPROF_SOURCE_DIR}/dvvp/common/config
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
    ${MSPROF_SOURCE_DIR}/dvvp/driver/inc
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
    __PROF_LLT
    google=ascend_private
)

target_link_libraries(stub_file_utest PRIVATE
    $<BUILD_INTERFACE:msprof_utestonetrack_pub>
    c_sec
)

set_target_properties(stub_file_utest
    PROPERTIES
    OUTPUT_NAME stub_file_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

####################### c_base_msprof_err_mgr_utest ###########################
add_executable(c_base_msprof_err_mgr_utest
    ${MSPROF_SOURCE_DIR}/dvvp/depend/c_base/msprof_error_manager.cpp
    test/main.cpp
    test/c_base_msprof_err_mgr_utest.cpp
    stub/report_err_msg_stub.c
)

target_include_directories(c_base_msprof_err_mgr_utest PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/stub
    ${MSPROF_SOURCE_DIR}/dvvp/depend/c_base
    ${MSPROF_SOURCE_DIR}/dvvp/common/singleton
    ${MSPROF_SOURCE_DIR}/dvvp/common
    ${MSPROF_SOURCE_DIR}/dvvp
    ${TOP_DIR}/src/dfx/msprof/inc/external
    ${LIBC_SEC_HEADER}
    ${TOP_DIR}/output/third_party/gtest_shared/include
)

target_compile_options(c_base_msprof_err_mgr_utest PRIVATE
    -g
    -pipe
    -fno-access-control
)

target_compile_definitions(c_base_msprof_err_mgr_utest PRIVATE
    __PROF_LLT
    google=ascend_private
)

target_link_libraries(c_base_msprof_err_mgr_utest PRIVATE
    $<BUILD_INTERFACE:msprof_intf_llt_pub>
    c_sec
)

set_target_properties(c_base_msprof_err_mgr_utest
    PROPERTIES
    OUTPUT_NAME c_base_msprof_err_mgr_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

