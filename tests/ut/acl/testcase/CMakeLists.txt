# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

project(ascendcl_cpp_utest)

#include directories
include_directories(${BASE_DIR})
include_directories(${BASE_DIR}/include)
include_directories(${BASE_DIR}/include/external)
include_directories(${BASE_DIR}/include/external/acl)

include_directories(${BASE_DIR}/src/acl/common)
include_directories(${TOP_DIR}/pkg_inc/runtime)
include_directories(${TOP_DIR}/pkg_inc/runtime/runtime)
include_directories(${CMAKE_BINARY_DIR})
include_directories(${CMAKE_BINARY_DIR}/include_acl)
include_directories(${CMAKE_BINARY_DIR}/include_acl/tdt)
include_directories(${BASE_DIR}/pkg_inc)
include_directories(${BASE_DIR}/pkg_inc/base)
include_directories(${BASE_DIR}/pkg_inc/profiling)
include_directories(${BASE_DIR}/pkg_inc/dump)
include_directories(${BASE_DIR}/pkg_inc/watchdog)
include_directories(${TOP_DIR}/src/dfx/log/inc)
include_directories(${BASE_DIR}/src/acl)
include_directories(${BASE_DIR}/src/acl/aclrt)
include_directories(${BASE_DIR}/src/acl/aclrt_impl)
include_directories(${BASE_DIR}/tests/depends/)
include_directories(${BASE_DIR}/include/dfx)
include_directories(${BASE_DIR}/src/runtime/feature/inc/kernel)

set(UT_FILES
    "test.cpp"
    "compatibility/enum_check.cpp"
    "compatibility/const_check.cpp"
    "compatibility/struct_check.cpp"
    "compatibility/cast_to_other_check.cpp"
    "acl_common_unittest.cpp"
    "acl_capability_unittest.cpp"
    "acl_toolchain_unittest.cpp"
    "acl_fp16_unittest.cpp"
    "acl_runtime_unittest.cpp"
    "acl_tensorDataTransfer_unittest.cpp"
    "acl_queue_unittest.cpp"
    "acl_mdlri_unittest.cpp"
)

set(SRC_FILES
######### aclrt_impl #########
    ${BASE_DIR}/src/acl/common/log_inner.cpp
    ${BASE_DIR}/src/acl/common/prof_reporter.cpp
    ${BASE_DIR}/src/acl/common/resource_statistics.cpp
    ${BASE_DIR}/src/acl/aclrt_impl/device.cpp
    ${BASE_DIR}/src/acl/aclrt_impl/dfx.cpp
    ${BASE_DIR}/src/acl/aclrt_impl/event.cpp
    ${BASE_DIR}/src/acl/aclrt_impl/stream.cpp
    ${BASE_DIR}/src/acl/aclrt_impl/memory.cpp
    ${BASE_DIR}/src/acl/aclrt_impl/context.cpp
    ${BASE_DIR}/src/acl/aclrt_impl/callback.cpp
    ${BASE_DIR}/src/acl/aclrt_impl/group.cpp
    ${BASE_DIR}/src/acl/aclrt_impl/kernel.cpp
    ${BASE_DIR}/src/acl/aclrt_impl/notify.cpp
    ${BASE_DIR}/src/acl/aclrt_impl/label.cpp
    ${BASE_DIR}/src/acl/aclrt_impl/acl_rt_impl_base.cpp
    ${BASE_DIR}/src/acl/aclrt_impl/model_ri.cpp
    ${BASE_DIR}/src/acl/aclrt_impl/callback_api.cpp
    ${BASE_DIR}/src/acl/aclrt_impl/init_callback_manager.cpp
    ${BASE_DIR}/src/acl/aclrt_impl/snapshot.cpp
    ${BASE_DIR}/src/acl/aclrt_impl/data_buffer.cpp
    ${BASE_DIR}/src/acl/aclrt_impl/allocator.cpp
    ${BASE_DIR}/src/acl/aclrt_impl/log.cpp
    ${BASE_DIR}/src/acl/aclrt_impl/toolchain/dump.cpp
    ${BASE_DIR}/src/acl/aclrt_impl/toolchain/profiling.cpp
    ${BASE_DIR}/src/acl/aclrt_impl/toolchain/profiling_manager.cpp
    ${BASE_DIR}/src/acl/common/json_parser.cpp
    ${BASE_DIR}/src/acl/utils/string_utils.cpp
    ${BASE_DIR}/src/acl/utils/cann_info_utils.cpp
    ${BASE_DIR}/src/acl/utils/hash_utils.cpp
    ${BASE_DIR}/src/acl/utils/file_utils.cpp
    ${BASE_DIR}/src/acl/aclrt_impl/acl.cpp
    ${BASE_DIR}/src/acl/aclrt_impl/types/fp16.cpp
    ${BASE_DIR}/src/acl/aclrt_impl/types/fp16_impl.cpp

######### aclrt #########
    ${BASE_DIR}/src/acl/aclrt/acl_rt.cpp

######### tdt #########
    ${BASE_DIR}/src/acl/acl_tdt_channel/tensor_data_transfer.cpp
    ${BASE_DIR}/src/acl/acl_tdt_queue/queue.cpp
    ${BASE_DIR}/src/acl/acl_tdt_queue/queue_manager.cpp
    ${BASE_DIR}/src/acl/acl_tdt_queue/queue_process.cpp
    ${BASE_DIR}/src/acl/acl_tdt_queue/queue_process_host.cpp
    ${BASE_DIR}/src/acl/acl_tdt_queue/queue_process_sp.cpp
    ${BASE_DIR}/src/acl/acl_tdt_queue/queue_process_ccpu.cpp
    ${BASE_DIR}/src/acl/acl_tdt_queue/toolchain/prof_api_reg.cpp
)

############ libut_ascendcl_src.a ############
add_library(ut_ascendcl_src STATIC
    ${SRC_FILES}
)

add_dependencies(ut_ascendcl_src copy_acl_headers_and_libs)

target_include_directories(ut_ascendcl_src PRIVATE
    ${CMAKE_BINARY_DIR}/include_acl
    ${CMAKE_BINARY_DIR}/include_acl/tdt
)

target_compile_definitions(ut_ascendcl_src PRIVATE
    google=ascend_private
    ENABLE_DVPP_INTERFACE
    RUN_TEST
    $<$<BOOL:${ENABLE_OPEN_SRC}>:ONLY_COMPILE_OPEN_SRC>
    $<$<BOOL:${ENABLE_UT}>:ONLY_ENABLE_ACL_UT>
)

target_compile_options(ut_ascendcl_src PRIVATE
    -fsanitize=address -fsanitize=leak -fsanitize-recover=address
    -g --coverage -fprofile-arcs -ftest-coverage -fno-access-control
    -Wall -Wextra -Wfloat-equal -Werror
)

target_link_libraries(ut_ascendcl_src PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    -fsanitize=address -fsanitize=leak -fsanitize-recover=address
    c_sec
    json
)

############ ascendcl_cpp_utest ############
add_executable(ascendcl_cpp_utest ${UT_FILES})

add_dependencies(ascendcl_cpp_utest copy_acl_headers_and_libs)

target_include_directories(ascendcl_cpp_utest PRIVATE
    ${CMAKE_BINARY_DIR}/include_acl
    ${CMAKE_BINARY_DIR}/include_acl/tdt
)

target_compile_options(ascendcl_cpp_utest PRIVATE
    -fsanitize=address -fsanitize=leak -fsanitize-recover=address
    -O0
    -g
    -Wno-deprecated-declarations
    -Wall -Wfloat-equal -Werror -Wextra
    -fno-access-control
)

target_compile_definitions(ascendcl_cpp_utest PRIVATE
    google=ascend_private
    ENABLE_DVPP_INTERFACE
    ACL_BASE_DIR=\"${BASE_DIR}\"
)

target_link_libraries(ascendcl_cpp_utest PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    -fsanitize=address -fsanitize=leak -fsanitize-recover=address
    ut_ascendcl_src
    json
    GTest::gtest
    GTest::gtest_main
    GTest::gmock
    GTest::gmock_main
    slog_stub
    c_sec
    mmpa_stub
    ge_stub
    tdt_stub
    toolchain_stub
    runtime_stub
    profiling_stub
    -lrt
    -ldl
    -lpthread
    -lgcov
)