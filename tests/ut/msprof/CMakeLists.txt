# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(MSPROF_SOURCE_DIR ${TOP_DIR}/src/dfx/msprof/collector)

include_directories(${OPEN_SOURCE_DIR}/boost)
include_directories(${OPEN_SOURCE_DIR}/mockcpp_src/include)

############# intf_llt_pub ####################
add_library(msprof_intf_llt_pub INTERFACE)

target_include_directories(msprof_intf_llt_pub INTERFACE
)

target_compile_definitions(msprof_intf_llt_pub INTERFACE
    CFG_BUILD_DEBUG
    _GLIBCXX_USE_CXX11_ABI=0
)
target_compile_options(msprof_intf_llt_pub INTERFACE
    -g
    -w
    $<$<BOOL:${ENABLE_GCOV}>:-fprofile-arcs -ftest-coverage>
    $<$<BOOL:${ENABLE_ASAN}>:-fsanitize=address -fno-omit-frame-pointer -static-libasan -fsanitize=undefined -static-libubsan -fsanitize=leak -static-libtsan>
    -fPIC
    -pipe
)

target_link_options(msprof_intf_llt_pub INTERFACE
    $<$<BOOL:${ENABLE_GCOV}>:-fprofile-arcs -ftest-coverage>
    $<$<BOOL:${ENABLE_ASAN}>:-fsanitize=address -static-libasan -fsanitize=undefined  -static-libubsan -fsanitize=leak -static-libtsan>
)

target_link_directories(msprof_intf_llt_pub INTERFACE
)

link_directories(${TOP_DIR}/output/third_party)

target_link_libraries(msprof_intf_llt_pub INTERFACE
    GTest::gtest
    ${OPEN_SOURCE_DIR}/mockcpp/lib/libmockcpp.a
    dl
    -lpthread
    $<$<BOOL:${ENABLE_GCOV}>:-lgcov>
    c_sec
    ascend_protobuf_static
)

############ msprof onetrack pub target for utest ############
add_library(msprof_utestonetrack_pub INTERFACE)

target_link_libraries(msprof_utestonetrack_pub INTERFACE
    $<BUILD_INTERFACE:msprof_intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:msprof_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:msprof_headers>
    $<BUILD_INTERFACE:npu_runtime_headers>
    -Wl,--as-needed
    -lpthread
)

protobuf_generate(profiler
    CppPath
    HeaderPath
    ${MSPROF_SOURCE_DIR}/dvvp/proto/profiler.proto
)

add_subdirectory(acp)
add_subdirectory(app)
add_subdirectory(avp)
add_subdirectory(common)
add_subdirectory(device)
add_subdirectory(driver)
add_subdirectory(job_wrapper)
add_subdirectory(message)
add_subdirectory(msprof)
add_subdirectory(msprofbin)
add_subdirectory(profapi)
add_subdirectory(profhal)
add_subdirectory(streamio)
add_subdirectory(stub_utest)
add_subdirectory(transport)
# add_subdirectory(st/cli)
# add_subdirectory(st/geoption)
# add_subdirectory(st/acljson)
# add_subdirectory(st/api)

###################################################################################################

set(MSPROF_TARGET
    acp_utest
    application_utest
    osal_linux_utest
    osal_liteos_utest
    device_utest
    driver_utest
    job_wrapper
    message_utest
    msprofiler_utest
    msprof_bin_utest
    prof_api_utest
    prof_hal_utest
    client_utest
    streamio_common_utest
    stub_file_utest
    transport
    # cli_stest
    # geoption_stest
    # acljson_stest
    # proftransport_st_static
    # profapi_lite_st
    # api_dc_stest
    # api_david_stest
    # api_mini_v3_stest
    # api_mdc_mini_v3_stest
    # api_cloud_stest
    # api_mdc_stest
    # acl_api_stest
    # api_tiny_stest
    # profapi_share_st
)
add_custom_target(msprof_ut DEPENDS ${MSPROF_TARGET})
