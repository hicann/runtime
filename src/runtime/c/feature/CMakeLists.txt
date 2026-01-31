# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
#------------------------- runtime -------------------------
include(${RUNTIME_DIR}/pkg_inc/runtime/runtime/runtime_headers.cmake)
set(libruntime_feature_src_files
    src/api.c
    src/error_manage.c
    src/device.c
    src/stream.c
    src/model.c
    src/rt_ctrl_model.c
    src/context_common.c
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:src/subscribe_manager_linux.c>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},LiteOS>:src/subscribe_manager_liteos.c>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:src/context_linux.c>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},LiteOS>:src/context_liteos.c>
    src/host_func.c
)

set(RUNTIME_INC_DIR
    ${CMAKE_CURRENT_SOURCE_DIR}/inc
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../include/external/acl
)

add_library(runtime_static STATIC
    ${libruntime_feature_src_files}
)

target_include_directories(runtime_static PRIVATE
    ${RUNTIME_INC_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/../stub/inc
)

target_link_libraries(runtime_static
PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:c_base_headers>
    $<BUILD_INTERFACE:msprof_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:c_mmpa_headers>
    c_sec_headers
PUBLIC
    npu_runtime_headers
)

if(${TARGET_SYSTEM_NAME} STREQUAL "LiteOS")
    target_compile_definitions(runtime_static PRIVATE
        NANO_OS_TYPE=1
    )
elseif (${TARGET_SYSTEM_NAME} STREQUAL "Linux")
    target_compile_definitions(runtime_static PRIVATE
        NANO_OS_TYPE=0
    )
endif()

target_compile_options(runtime_static PRIVATE
    -O2
    -fno-common
    -fno-strict-aliasing
    -Wfloat-equal
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:-Wall>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:-Wextra>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:-Werror>
    ${CMAKE_EXTRA_COMPILE_OPTIONS}
)

set_target_properties(runtime_static PROPERTIES
    OUTPUT_NAME runtime
)

install(TARGETS  runtime_static
    ARCHIVE DESTINATION ${INSTALL_LIBRARY_DIR}/c OPTIONAL
)

############ install #############
set(PKG_NAME runtime_static)
install(TARGETS runtime_static
    EXPORT ${PKG_NAME}-targets
    ARCHIVE DESTINATION ${INSTALL_LIBRARY_DIR}/c/runtime OPTIONAL COMPONENT opensdk
)

if (PACKAGE STREQUAL "opensdk")
    install(EXPORT ${PKG_NAME}-targets DESTINATION ${INSTALL_CONFIG_DIR}
        FILE ${PKG_NAME}-targets.cmake COMPONENT opensdk EXCLUDE_FROM_ALL
    )
    configure_package_config_file(${RUNTIME_DIR}/cmake/config/pkg_config_template.cmake.in
        ${CMAKE_CURRENT_BINARY_DIR}/${PKG_NAME}-config.cmake
        INSTALL_DESTINATION ${INSTALL_CONFIG_DIR}
        PATH_VARS INSTALL_BASE_DIR INSTALL_INCLUDE_DIR INSTALL_LIBRARY_DIR INSTALL_RUNTIME_DIR INSTALL_CONFIG_DIR
        INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX}
    )
    install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${PKG_NAME}-config.cmake
        DESTINATION ${INSTALL_CONFIG_DIR} COMPONENT opensdk EXCLUDE_FROM_ALL
    )
endif()
unset(PKG_NAME)
