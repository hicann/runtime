# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(reportSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/msnpureport.c
    ${CMAKE_CURRENT_SOURCE_DIR}/utils/msnpureport_print.c
    ${CMAKE_CURRENT_SOURCE_DIR}/utils/msnpureport_utils.c
    ${CMAKE_CURRENT_SOURCE_DIR}/config/msnpureport_level.c
    ${CMAKE_CURRENT_SOURCE_DIR}/config/msn_operate_log_level.c
    ${CMAKE_CURRENT_SOURCE_DIR}/config/msnpureport_config.c
    ${CMAKE_CURRENT_SOURCE_DIR}/report/msnpureport_report.c
    ${CMAKE_CURRENT_SOURCE_DIR}/report/msnpureport_file_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/options/msnpureport_options.c
    ${CMAKE_CURRENT_SOURCE_DIR}/options/msnpureport_options_old.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../utils/log_system_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../utils/log_common.c
)

set(reportHeaderDir
    ${RUNTIME_DIR}/abl/libc_sec/include
    ${RUNTIME_DIR}/inc/driver
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/utils
    ${CMAKE_CURRENT_SOURCE_DIR}/config
    ${CMAKE_CURRENT_SOURCE_DIR}/options
    ${CMAKE_CURRENT_SOURCE_DIR}/report
    ${TOOLAHCIN_LOG_DIR}/shared
    ${TOOLAHCIN_LOG_DIR}/utils
    ${TOOLAHCIN_LOG_DIR}/../../include/log/msnpureport
)

set(msnpureport_auto_export
    ${TOOLAHCIN_LOG_DIR}/syslog/scripts/msnpureport_auto_export.sh
)

add_executable(msnpureport
    ${reportSrcFiles})

target_include_directories(msnpureport PRIVATE
    ${reportHeaderDir})

target_compile_definitions(msnpureport PRIVATE
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:OS_TYPE_DEF=0>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:OS_TYPE_DEF=1>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:SECUREC_USING_STD_SECURE_LIB=0>
)

target_compile_options(msnpureport PRIVATE
    $<$<CONFIG:Debug>:-g -O0>
    $<$<CONFIG:Release>:-Os -D_FORTIFY_SOURCE=2>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Werror>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wfloat-equal -Wextra>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wunused>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wshadow>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wundef>
    -std=gnu11
    -fPIE
    -fstack-protector-strong
    -fvisibility=hidden
    -fdata-sections
    -ffunction-sections
    -Werror
    -Wall
)

target_link_options(msnpureport PRIVATE
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wl,-z,relro,-z,now,-z,noexecstack>
    -Wl,--gc-sections
)

target_link_libraries(msnpureport PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adcore_headers>
    ascend_hal
    c_sec_static
    static_mmpa
    adcore
    bbox_dump
    $<$<AND:$<STREQUAL:${PRODUCT},ascend910_55>,$<STREQUAL:${CMAKE_HOST_SYSTEM_PROCESSOR},aarch64>>:urma>
    $<$<AND:$<STREQUAL:${PRODUCT},ascend910_55>,$<STREQUAL:${CMAKE_HOST_SYSTEM_PROCESSOR},aarch64>>:urma_common>
    $<$<AND:$<STREQUAL:${PRODUCT},ascend910_55esl>,$<STREQUAL:${CMAKE_HOST_SYSTEM_PROCESSOR},aarch64>>:urma>
    $<$<AND:$<STREQUAL:${PRODUCT},ascend910_55esl>,$<STREQUAL:${CMAKE_HOST_SYSTEM_PROCESSOR},aarch64>>:urma_common>
    $<$<AND:$<STREQUAL:${PRODUCT},ascend910_95>,$<STREQUAL:${CMAKE_HOST_SYSTEM_PROCESSOR},aarch64>>:urma>
    $<$<AND:$<STREQUAL:${PRODUCT},ascend910_95>,$<STREQUAL:${CMAKE_HOST_SYSTEM_PROCESSOR},aarch64>>:urma_common>
    $<$<AND:$<STREQUAL:${PRODUCT},ascend910_95esl>,$<STREQUAL:${CMAKE_HOST_SYSTEM_PROCESSOR},aarch64>>:urma>
    $<$<AND:$<STREQUAL:${PRODUCT},ascend910_95esl>,$<STREQUAL:${CMAKE_HOST_SYSTEM_PROCESSOR},aarch64>>:urma_common>
    $<$<AND:$<STREQUAL:${PRODUCT},ascend910_96>,$<STREQUAL:${CMAKE_HOST_SYSTEM_PROCESSOR},aarch64>>:urma>
    $<$<AND:$<STREQUAL:${PRODUCT},ascend910_96>,$<STREQUAL:${CMAKE_HOST_SYSTEM_PROCESSOR},aarch64>>:urma_common>
    $<$<AND:$<STREQUAL:${PRODUCT},ascend910_96esl>,$<STREQUAL:${CMAKE_HOST_SYSTEM_PROCESSOR},aarch64>>:urma>
    $<$<AND:$<STREQUAL:${PRODUCT},ascend910_96esl>,$<STREQUAL:${CMAKE_HOST_SYSTEM_PROCESSOR},aarch64>>:urma_common>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:dl>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:rt>
)

target_link_directories(msnpureport PRIVATE
    $<$<AND:$<STREQUAL:${PRODUCT},ascend910_55>,$<STREQUAL:${PRODUCT_SIDE},host>>:${RUNTIME_DIR}/build/bin/ccec_for_milan/lib/urma>
    $<$<AND:$<STREQUAL:${PRODUCT},ascend910_55esl>,$<STREQUAL:${PRODUCT_SIDE},host>>:${RUNTIME_DIR}/build/bin/ccec_for_milan/lib/urma>
    $<$<AND:$<STREQUAL:${PRODUCT},ascend910_95>,$<STREQUAL:${PRODUCT_SIDE},host>>:${RUNTIME_DIR}/build/bin/ccec_for_milan/lib/urma>
    $<$<AND:$<STREQUAL:${PRODUCT},ascend910_95esl>,$<STREQUAL:${PRODUCT_SIDE},host>>:${RUNTIME_DIR}/build/bin/ccec_for_milan/lib/urma>
    $<$<AND:$<STREQUAL:${PRODUCT},ascend910_96>,$<STREQUAL:${PRODUCT_SIDE},host>>:${RUNTIME_DIR}/build/bin/ccec_for_milan/lib/urma>
    $<$<AND:$<STREQUAL:${PRODUCT},ascend910_96esl>,$<STREQUAL:${PRODUCT_SIDE},host>>:${RUNTIME_DIR}/build/bin/ccec_for_milan/lib/urma>
)

set_target_properties(msnpureport
    PROPERTIES
    OUTPUT_NAME msnpureport
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

###################################################################
set(INSTALL_BASE_DIR "")
set(INSTALL_INCLUDE_DIR include)
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_RUNTIME_DIR bin)
set(INSTALL_CONFIG_DIR lib/cmake)

include(CMakePackageConfigHelpers)

install(TARGETS msnpureport
    RUNTIME DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)

install(PROGRAMS ${msnpureport_auto_export}
    DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)

