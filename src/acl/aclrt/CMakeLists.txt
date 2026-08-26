# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

include(acl_rt_headers.cmake)

############ libacl_rt.so ############
add_library(acl_rt SHARED
    acl_rt.cpp
)

target_include_directories(acl_rt PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}
    ${CMAKE_CURRENT_LIST_DIR}/..
    ${CMAKE_CURRENT_LIST_DIR}/../aclrt_impl
    ${CMAKE_CURRENT_LIST_DIR}/../../../pkg_inc/dump
)

target_compile_options(acl_rt PRIVATE
    -fvisibility=hidden -O2 -Werror -fno-common
    -ftrapv
)

target_compile_definitions(acl_rt PRIVATE
    OS_TYPE=0
    FUNC_VISIBILITY
)

# Enable aclrt api hook on all platforms except embedded (ascend031/ascend035/ascend5162a)
# When disabled, aclrtApiInjectionSetFunc/GetFunc are compiled as error-returning
# stubs and aclrt apis fall back to direct forwarding with zero hook overhead.
if(NOT "${PRODUCT}" STREQUAL "ascend031" AND NOT "${PRODUCT}" STREQUAL "ascend035"
   AND NOT "${PRODUCT}" STREQUAL "ascend5162a")
    target_compile_definitions(acl_rt PRIVATE ACL_RT_API_HOOK_ENABLE=1)
endif()

target_link_options(acl_rt PRIVATE
    -rdynamic
    -Wl,-Bsymbolic
    -Wl,--exclude-libs,ALL
    $<$<NOT:$<BOOL:${ENABLE_TSAN}>>:-Wl,--no-undefined>
)

target_link_libraries(acl_rt
    PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        -Wl,--no-as-needed
        runtime
        ascend_dump
        -lstdc++
        -Wl,--as-needed
        -ldl
        -lpthread
    PUBLIC
        $<BUILD_INTERFACE:acl_rt_headers>
)
