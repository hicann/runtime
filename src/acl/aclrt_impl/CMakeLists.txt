# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

############ libacl_rt_impl.so ############
# This library provides runtime forwarding to libruntime.so using auto-generated stubs.
set(ACL_RT_IMPL_STUB_SCRIPT ${CMAKE_CURRENT_LIST_DIR}/../../../scripts/package/runtime/scripts/gen_dynamic_stub.py)
set(ACL_RT_IMPL_HEADER ${CMAKE_CURRENT_LIST_DIR}/acl_rt_impl.h)
set(ACL_RT_WRAPPER_HEADER ${CMAKE_CURRENT_LIST_DIR}/acl_rt_wrapper.h)
set(ACL_RT_IMPL_STUB_CPP ${CMAKE_CURRENT_BINARY_DIR}/acl_rt_impl_stub.cpp)

add_custom_command(
    OUTPUT ${ACL_RT_IMPL_STUB_CPP}
    COMMAND ${CMAKE_COMMAND} -E echo "Generating stub files:acl_rt_impl_stub.cpp."
    COMMAND python3 ${ACL_RT_IMPL_STUB_SCRIPT}
            ${CMAKE_CURRENT_LIST_DIR}/../../../air/inc/external/acl
            ${CMAKE_CURRENT_LIST_DIR}
            ${ACL_RT_IMPL_STUB_CPP}
    COMMAND ${CMAKE_COMMAND} -E echo "Generating stub files end."
    DEPENDS
            ${ACL_RT_IMPL_STUB_SCRIPT}
            ${ACL_RT_IMPL_HEADER}
            ${ACL_RT_WRAPPER_HEADER}
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    VERBATIM
)

add_library(acl_rt_impl SHARED
    ${ACL_RT_IMPL_STUB_CPP}
)

set(ACL_INC_EXTERNAL_DIR ${CMAKE_CURRENT_LIST_DIR}/../../../include/external)

target_include_directories(acl_rt_impl PRIVATE
    ${ACL_INC_EXTERNAL_DIR}
    ${CMAKE_CURRENT_LIST_DIR}
)

target_compile_options(acl_rt_impl PRIVATE
    -fvisibility=hidden -O2 -Werror -fno-common
    -ftrapv
)

target_compile_definitions(acl_rt_impl PRIVATE
    OS_TYPE=0
    FUNC_VISIBILITY
    # pkg_inc/runtime/runtime 下废弃接口调用错误抑制
    RT_RUNTIME_DISABLE_DEPRECATED_WARNINGS
)

# Link options for the generated forwarding stub library.
target_link_options(acl_rt_impl PRIVATE
    -Wl,-Bsymbolic
    -Wl,--exclude-libs,ALL
    $<$<NOT:$<BOOL:${ENABLE_TSAN}>>:-Wl,--no-undefined>
)

target_link_libraries(acl_rt_impl PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    -Wl,--as-needed
    -ldl
    -lpthread
)
