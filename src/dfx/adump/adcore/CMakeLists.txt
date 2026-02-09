# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
#########libadcore
set(adcoreHeaders
    ${CMAKE_CURRENT_LIST_DIR}/../external
    ${CMAKE_CURRENT_LIST_DIR}/../inc/adump
    ${CMAKE_CURRENT_LIST_DIR}/
    ${CMAKE_CURRENT_LIST_DIR}/epoll
    ${CMAKE_CURRENT_LIST_DIR}/commopts
    ${CMAKE_CURRENT_LIST_DIR}/common
    ${CMAKE_CURRENT_LIST_DIR}/protocol
    ${CMAKE_CURRENT_LIST_DIR}/component
    ${CMAKE_CURRENT_LIST_DIR}/device
    ${CMAKE_CURRENT_LIST_DIR}/log
    ${CMAKE_CURRENT_LIST_DIR}/hdc

    ${LIBC_SEC_HEADER}
    ${PROJECT_TOP_DIR}/include/driver
)

set(adcoreSrcList
    ${CMAKE_CURRENT_LIST_DIR}/adcore_api.cpp
    ${CMAKE_CURRENT_LIST_DIR}/device/adx_dsmi.cpp
    ${CMAKE_CURRENT_LIST_DIR}/device/adx_device.cpp
    ${CMAKE_CURRENT_LIST_DIR}/device/adx_hdc_device.cpp
    ${CMAKE_CURRENT_LIST_DIR}/component/adx_server_manager.cpp
    ${CMAKE_CURRENT_LIST_DIR}/component/adx_common_component.cpp
    ${CMAKE_CURRENT_LIST_DIR}/component/adx_component_api_c.cpp
    ${CMAKE_CURRENT_LIST_DIR}/epoll/adx_hdc_epoll.cpp
    ${CMAKE_CURRENT_LIST_DIR}/commopts/adx_comm_opt_manager.cpp
    ${CMAKE_CURRENT_LIST_DIR}/commopts/hdc_comm_opt.cpp
    ${CMAKE_CURRENT_LIST_DIR}/common/thread.cpp
    ${CMAKE_CURRENT_LIST_DIR}/common/thread_comm.cpp
    ${CMAKE_CURRENT_LIST_DIR}/common/memory_utils.cpp
    ${CMAKE_CURRENT_LIST_DIR}/protocol/adx_msg_proto.cpp
    ${CMAKE_CURRENT_LIST_DIR}/common/file_utils.cpp
    ${CMAKE_CURRENT_LIST_DIR}/common/string_utils.cpp
    ${CMAKE_CURRENT_LIST_DIR}/adx_api.cpp
    ${CMAKE_CURRENT_LIST_DIR}/common/create_func.cpp
    ${CMAKE_CURRENT_LIST_DIR}/component/server_register.cpp
)

if(PRODUCT STREQUAL "ascend031")
    list(APPEND adcoreSrcList
        ${CMAKE_CURRENT_LIST_DIR}/hdc/hdc_api_stub.cpp
    )
else()
    list(APPEND adcoreSrcList
        ${CMAKE_CURRENT_LIST_DIR}/hdc/hdc_api.cpp
    )
endif()

add_library(adcore STATIC
    ${adcoreSrcList}
)

add_library(adcore_headers INTERFACE)
target_include_directories(adcore_headers INTERFACE ${adcoreHeaders})

target_compile_options(adcore PRIVATE
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Werror>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wextra>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wfloat-equal>
    -std=c++11
    -fstack-protector-strong
    -fno-common
    -fno-strict-aliasing
    -fvisibility=hidden
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Debug>>:/MTd>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Release>>:/MT>
    $<$<CONFIG:Debug>:-D_FORTIFY_SOURCE=2 -Os -ftrapv>
    $<$<CONFIG:Release>:-D_FORTIFY_SOURCE=2 -Os>
)

target_link_options(adcore PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,-Bsymbolic
    -Wl,--exclude-libs,ALL
)

target_compile_definitions(adcore PRIVATE
    $<IF:$<STREQUAL:${PRODUCT_SIDE},host>,ADX_LIB_HOST_DRV,ADX_LIB>
    $<$<STREQUAL:${PRODUCT_SIDE},device>:ADX_LIB_DEVICE_DRV>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:OS_TYPE=0>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:OS_TYPE=1>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:SECUREC_USING_STD_SECURE_LIB=0>
)

if(${TARGET_SYSTEM_NAME} STREQUAL "Windows")
target_link_libraries(adcore PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adcore_headers>
    -Wl,--no-as-needed
    c_sec
    mmpa
    -Wl,--as-needed
    ascend_hal
)
else()
target_link_libraries(adcore PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adcore_headers>
    -Wl,--no-as-needed
    c_sec
    mmpa
    -Wl,--as-needed
    $<$<STREQUAL:${PRODUCT_SIDE},host>:ascend_hal_stub>
    $<$<STREQUAL:${PRODUCT_SIDE},device>:ascend_hal>
    $<$<STREQUAL:${PRODUCT_SIDE},device>:unified_dlog>
    $<$<AND:$<NOT:$<BOOL:${PRODUCT}>>,$<STREQUAL:${PRODUCT_SIDE},host>>:unified_dlog>
)
endif()