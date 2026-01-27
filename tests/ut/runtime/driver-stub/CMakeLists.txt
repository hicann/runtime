# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(BASE_DIR ${CMAKE_CURRENT_SOURCE_DIR})

###################################################################################################
add_executable(driver_stub_utest 
    ${TOP_DIR}/ace/npuruntime/runtime/cmodel_driver/driver_api.c
    ${TOP_DIR}/ace/npuruntime/runtime/cmodel_driver/driver_impl.c
    ${TOP_DIR}/ace/npuruntime/runtime/cmodel_driver/driver_mem.c
    ${TOP_DIR}/ace/npuruntime/runtime/cmodel_driver/driver_queue.c
    test/main.cc
    test/drv_utest_device.cc
    test/drv_utest_event.cc
    test/drv_utest_stream.cc
    test/drv_utest_model.cc
    test/drv_utest_mem.cc
    test/drv_utest_dispatch.cc
    stub/drv_utest_stub.cc
    )

target_include_directories(driver_stub_utest PRIVATE 
    ${TOP_DIR}/inc
    ${TOP_DIR}/inc/external
    ${TOP_DIR}/abl/libc_sec/include
    ${TOP_DIR}/ace/npuruntime/runtime/cmodel_driver
)

target_compile_definitions(driver_stub_utest PRIVATE
        DRIVER_NEW_API 
        FEATURE_NOTIFY
        FEATURE_PCTRACE
        FEATURE_DEBUG
)

# if("${PRODUCT}" STREQUAL "ascend310" OR "${PRODUCT}" STREQUAL "ascend310rc")
#     target_compile_definitions(driver_stub_utest PRIVATE
#         DRIVER_NEW_API 
#     )
# else()
#     target_compile_definitions(driver_stub_utest PRIVATE
#         DRIVER_NEW_API 
#         FEATURE_NOTIFY
#         FEATURE_PCTRACE
#         FEATURE_DEBUG
#     )
# endif()

target_link_libraries(driver_stub_utest PRIVATE 
    c_sec_static
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:msprof_headers>
    $<BUILD_INTERFACE:model_headers>
    $<BUILD_INTERFACE:tsch_headers>
    $<BUILD_INTERFACE:runtime_headers>
)

include(CMakePackageConfigHelpers)

add_dependencies(c_sec_static c_sec_build)