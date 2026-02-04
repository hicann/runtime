# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

add_library(ascend_hal_headers INTERFACE)
target_include_directories(ascend_hal_headers INTERFACE
    $<BUILD_INTERFACE:${RUNTIME_DIR}/include/driver>
    $<INSTALL_INTERFACE:include>
    $<INSTALL_INTERFACE:include/ascend_hal>
    $<INSTALL_INTERFACE:include/ascend_hal/driver>
)

get_filename_component(LOCAL_STUB_PATH "${CMAKE_CURRENT_LIST_DIR}" ABSOLUTE)
set(LOCAL_H2C_PY_PATH ${LOCAL_STUB_PATH}/h2c.py)

add_library(ascend_hal_stub SHARED)

set(LOCAL_ASCEND_H_FILE_PATH ${RUNTIME_DIR}/include/driver/ascend_hal.h)
set(LOCAL_ASCEND_H_FILE_PATH1 ${RUNTIME_DIR}/include/driver/ascend_hal_external.h)
set(LOCAL_ASCEND_H_FILE_PATH2 ${RUNTIME_DIR}/include/driver/ascend_hal_base.h)
set(LOCAL_ASCEND_C_FILE_PATH ${CMAKE_CURRENT_BINARY_DIR}/ascend_hal.c)

add_custom_command(
    OUTPUT ${LOCAL_ASCEND_C_FILE_PATH}
    COMMAND ${RUNTIME_PYTHON} ${LOCAL_H2C_PY_PATH} -i ${LOCAL_ASCEND_H_FILE_PATH} ${LOCAL_ASCEND_H_FILE_PATH1} ${LOCAL_ASCEND_H_FILE_PATH2} -o ${LOCAL_ASCEND_C_FILE_PATH}
)

target_sources(ascend_hal_stub PRIVATE
    ${LOCAL_ASCEND_C_FILE_PATH}
)

target_include_directories(ascend_hal_stub PRIVATE
    ${RUNTIME_DIR}/src/runtime/dfx/msprof/include
)

target_compile_options(ascend_hal_stub PRIVATE
    -fstack-protector-strong
)

target_link_libraries(ascend_hal_stub
    PRIVATE
        intf_pub
        #allow function redefine
        -Wl,-z,muldefs
    PUBLIC
        ascend_hal_headers
)

set_target_properties(ascend_hal_stub
    PROPERTIES
    OUTPUT_NAME ascend_hal
)

set(PKG_NAME ascend_hal)
install(TARGETS ascend_hal_stub ascend_hal_headers
    EXPORT ${PKG_NAME}-targets
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}/stub OPTIONAL COMPONENT opensdk
)
install(TARGETS ascend_hal_stub ascend_hal_headers
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}/${CMAKE_SYSTEM_PROCESSOR}/stub OPTIONAL COMPONENT opensdk
)
install(FILES   ${RUNTIME_DIR}/include/driver/ascend_hal_define.h
                ${RUNTIME_DIR}/include/driver/ascend_hal_error.h
                ${RUNTIME_DIR}/include/driver/ascend_hal.h
                ${RUNTIME_DIR}/include/driver/ascend_hal_external.h
                ${RUNTIME_DIR}/include/driver/ascend_hal_base.h
    DESTINATION ${INSTALL_INCLUDE_DIR}/ascend_hal/driver COMPONENT opensdk EXCLUDE_FROM_ALL
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

set(LOCAL_DSMI_H_FILE_PATH ${RUNTIME_DIR}/include/driver/dsmi_common_interface.h)
set(LOCAL_DSMI_C_FILE_PATH ${CMAKE_CURRENT_BINARY_DIR}/dsmi_common_interface.c)

add_custom_command(
    OUTPUT ${LOCAL_DSMI_C_FILE_PATH}
    COMMAND ${RUNTIME_PYTHON} ${LOCAL_H2C_PY_PATH} -i ${LOCAL_DSMI_H_FILE_PATH} -o ${LOCAL_DSMI_C_FILE_PATH}
)

add_library(drvdsmi_host_stub SHARED)

target_sources(drvdsmi_host_stub PRIVATE
    ${LOCAL_DSMI_C_FILE_PATH}
)

target_include_directories(drvdsmi_host_stub PRIVATE
    ${RUNTIME_DIR}/include/driver
)

target_link_libraries(drvdsmi_host_stub PRIVATE
    $<BUILD_INTERFACE:intf_pub>
)

set_target_properties(drvdsmi_host_stub
    PROPERTIES
    OUTPUT_NAME drvdsmi_host
)

install(TARGETS drvdsmi_host_stub OPTIONAL
    LIBRARY DESTINATION lib/stub
)
