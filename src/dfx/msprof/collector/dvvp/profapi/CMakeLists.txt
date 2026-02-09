# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(msProfHeader
    ${RUNTIME_DIR}/src/dfx/error_manager
    ${RUNTIME_DIR}/include/external
    ${RUNTIME_DIR}/include/external/acl
    ${RUNTIME_DIR}/src/inc
    ${RUNTIME_DIR}/src/inc/external
    ${RUNTIME_DIR}/pkg_inc/runtime
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime
    ${LIBC_SEC_HEADER}
    ../common
    ../common/logger
    ${PROF_BASIC_DIR}/osal
    ../profimpl/inc
    ../msprof/msproftx/mstx/inc/
    ./inc/
    ../transport
    ../depend/include/wrapper
    ../
)
set(profApiHeader
    ${MSPROF_DIR}/inc
    ${MSPROF_DIR}/inc/toolchain
    ${msProfHeader}
)

set(profApiCpp
    src/prof_inner_api.cpp
    src/prof_acl_inner_api.cpp
    src/prof_impl_inner_api.cpp
    src/prof_plugin_manager.cpp
    src/prof_cann_plugin.cpp
    src/prof_atls_plugin.cpp
    src/prof_plugin.cpp
    src/prof_tx_plugin.cpp
    src/prof_acl_plugin.cpp
    src/prof_runtime_plugin.cpp
    src/prof_mstx_plugin.cpp
    ../common/cmd_log/cmd_log.cpp
    ../common/utils/utils.cpp
    ${PROF_BASIC_DIR}/osal/osal.c
)

####################### libprofapi static lib for windows  begin ###########################
if(${TARGET_SYSTEM_NAME} STREQUAL "Windows")
add_library(profapi_stub STATIC
    stub/profapi_stub.cpp
)

target_include_directories(profapi_stub PRIVATE
    ${profApiHeader}
)

target_compile_definitions(profapi_stub PRIVATE
    google=ascend_private
    FUNC_VISIBILITY
    $<$<STREQUAL:${CMAKE_BUILD_TYPE},Debug>:MSPROF_DEBUG>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:NOMINMAX>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:WIN32>
)

set_target_properties(profapi_stub
    PROPERTIES
    OUTPUT_NAME profapi_stub
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

target_compile_options(profapi_stub PRIVATE
    -fvisibility=hidden
    -fvisibility-inlines-hidden
    -fPIC
    -Wall
    -std=c++11
    -fstack-protector-all
    -fno-strict-aliasing
    -fno-common
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Debug>>:/MTd>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Release>>:/MT>
)

target_link_options(profapi_stub PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,-Bsymbolic
    -Wl,--exclude-libs=ALL
)

target_link_libraries(profapi_stub PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    -Wl,--no-as-needed
    mmpa
    alog
    c_sec
    -Wl,--as-needed
)

install(TARGETS profapi_stub OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
)
####################### libprofapi static lib for windows  end ###########################
else()
####################### libprofapi.so ###########################
add_library(profapi_share SHARED
    ${profApiCpp}
)

target_compile_definitions(profapi_share PRIVATE
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:WIN32>
)

set_target_properties(profapi_share
    PROPERTIES
    OUTPUT_NAME profapi
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

target_compile_options(profapi_share PRIVATE
    -fstack-protector-all
    -fvisibility=hidden
    -fvisibility-inlines-hidden
    -fno-common
    -Wall
    $<$<COMPILE_LANGUAGE:CXX>:-std=c++11>
    $<$<COMPILE_LANGUAGE:C>:-std=c11>
    -Wextra
    -Wfloat-equal
    $<$<CONFIG:Release>:-D_FORTIFY_SOURCE=2 -Os>
    $<$<CONFIG:Debug>:-D_FORTIFY_SOURCE=2 -Os>
)

target_link_options(profapi_share PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,-Bsymbolic
    -Wl,--exclude-libs=ALL
)

target_include_directories( profapi_share PRIVATE
    ${profApiHeader}
)

target_link_libraries(profapi_share
    PRIVATE
        intf_pub
        mmpa_headers
        slog_headers
        -Wl,--no-as-needed
        mmpa
        alog
        c_sec
        -Wl,--as-needed
    PUBLIC
        msprof_headers
)
####################### libprofapi.so ###########################

####################### libprofapi_lite.so ###########################
add_library(profapi_lite_share SHARED
    src/prof_avp_inner_api.cpp
    src/prof_avp_plugin.cpp
    src/prof_plugin.cpp
)

target_include_directories(profapi_lite_share PRIVATE
    ${profApiHeader}
)

target_compile_definitions(profapi_lite_share PRIVATE
    OSAL
)

set_target_properties(profapi_lite_share
    PROPERTIES
    OUTPUT_NAME profapi
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/proflib
)

target_compile_options(profapi_lite_share PRIVATE
    -fstack-protector-all
    -fvisibility=hidden
    -fvisibility-inlines-hidden
    -Wall
    -std=c++11
    -Wextra
    -Wfloat-equal
    -fno-common
)

target_link_options(profapi_lite_share PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,-Bsymbolic
    -Wl,--exclude-libs=ALL
)

target_include_directories(profapi_lite_share PRIVATE
    ${msProfHeader}
)

target_link_libraries(profapi_lite_share
    PRIVATE
        intf_pub
        slog_headers
        -Wl,--no-as-needed
        alog
        c_sec
        -Wl,--as-needed
    PUBLIC
        msprof_headers
)

install(TARGETS profapi_lite_share OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}/lib
)

####################### libprofapi_lite.so ###########################
####################### libprofapi.so device side ###########################
# add_library(profapi_share_device SHARED
#     src/prof_device_api.cpp
# )

# set_target_properties(profapi_share_device
#     PROPERTIES
#     OUTPUT_NAME profapi
#     LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
# )

# target_compile_options(profapi_share_device PRIVATE
#     -fstack-protector-all
#     -fvisibility=hidden
#     -fvisibility-inlines-hidden
#     -fno-common
#     -Wall
#     -std=c++11
#     -Wextra
#     -Wfloat-equal
#     $<$<CONFIG:Release>:-D_FORTIFY_SOURCE=2 -Os>
#     $<$<CONFIG:Debug>:-D_FORTIFY_SOURCE=2 -Os>
# )

# target_link_options(profapi_share_device PRIVATE
#     -Wl,-z,relro,-z,now,-z,noexecstack
#     -Wl,-Bsymbolic
#     -Wl,--exclude-libs=ALL
# )

# target_include_directories(profapi_share_device PRIVATE
#     inc
#     ../common
#     ../common/logger
#     ../common/errno
#     ${RUNTIME_DIR}/abl/msprof/inc/toolchain
# )

# target_link_libraries(profapi_share_device
#     $<BUILD_INTERFACE:intf_pub>
#     $<BUILD_INTERFACE:slog_headers>
#     $<BUILD_INTERFACE:msprof_headers>
#     c_sec
#     unified_dlog
# )
####################### libprofapi.so device side  ###########################
endif()
