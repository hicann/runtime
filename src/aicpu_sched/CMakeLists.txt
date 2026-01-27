# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

set(RUNTIME ${CMAKE_CURRENT_SOURCE_DIR}/../..)

include(${RUNTIME}/cmake/third_party/seccomp.cmake)

function(strip_binary target)
if(NOT SPH_INSTALL_MODE)
    add_custom_command(
        TARGET ${target} POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} --only-keep-debug $<TARGET_FILE:${target}> $<TARGET_FILE:${target}>.debuginfo
        COMMAND ${CMAKE_STRIP} -s $<TARGET_FILE:${target}>
        VERBATIM
    )
    set_target_properties(${target} PROPERTIES STRIP_BINARY True)
endif()
endfunction()

add_library(stackcore_stub SHARED ${CMAKE_CURRENT_SOURCE_DIR}/stub/stackcore_stub.cpp)
target_include_directories(stackcore_stub PRIVATE
    ${RUNTIME}/include/driver
)

add_library(adump_stub SHARED ${CMAKE_CURRENT_SOURCE_DIR}/stub/adump_stub.cpp)
target_include_directories(adump_stub PRIVATE
    ${RUNTIME}/pkg_inc/dump
)

add_library(tsd_eventclient_stub SHARED ${CMAKE_CURRENT_SOURCE_DIR}/stub/stub_tsd_event_client.cpp)
target_include_directories(tsd_eventclient_stub PRIVATE
    ${RUNTIME}/pkg_inc/tsd
)

add_library(seccomp_stub SHARED ${CMAKE_CURRENT_SOURCE_DIR}/stub/seccomp_stub.cpp)
target_link_libraries(seccomp_stub PRIVATE
    seccomp_headers
)

set_target_properties(seccomp_stub
    PROPERTIES
    OUTPUT_NAME seccomp
    SOVERSION 2
)

set_target_properties(tsd_eventclient_stub
    PROPERTIES
    OUTPUT_NAME tsd_eventclient
)

set_target_properties(stackcore_stub
    PROPERTIES
    OUTPUT_NAME stackcore
)

set_target_properties(adump_stub
    PROPERTIES
    OUTPUT_NAME adump
)

if(${PRODUCT_SIDE} STREQUAL device)
    add_subdirectory(aicpu_cust_schedule)
    add_subdirectory(aicpu_processer)
    add_subdirectory(aicpu_prof)
    add_subdirectory(aicpu_sharder)
    add_subdirectory(aicpu_schedule)
else()
    add_subdirectory(aicpu_schedule)
endif()
