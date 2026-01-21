# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
cmake_minimum_required(VERSION 3.14)
if (ENABLE_OPEN_SRC)
    find_package(c_base MODULE REQUIRED)
    find_package(c_mmpa MODULE REQUIRED)
endif()

set(INSTALL_LIBRARY_DIR lib)
set(SRC_LIST
    common/acl_rt.c
    common/model_config_rt.c
    runtime/callback.c
    runtime/context.c
    runtime/stream.c
    runtime/device.c
    runtime/memory.c
    runtime/host_func.c
)

if (${TARGET_SYSTEM_NAME} STREQUAL "Linux")
    # Linux start
    set(ASCENDCL_C_COMPILE_TARGET ascendcl_c)
    add_library(${ASCENDCL_C_COMPILE_TARGET} SHARED ${SRC_LIST})
    target_include_directories(${ASCENDCL_C_COMPILE_TARGET} PRIVATE
    if(NOT ENABLE_OPEN_SRC)
        ${TOP_DIR}/inc
        ${TOP_DIR}/inc/external
    else()
        # $<$<BOOL:${ENABLE_OPEN_SRC}>:${ASCEND_INSTALL_PATH}/include>
        $<$<BOOL:${ENABLE_OPEN_SRC}>:${ASCEND_INSTALL_PATH}/include/experiment>
        $<$<BOOL:${ENABLE_OPEN_SRC}>:${CANN_GE_DIR}/inc>
        $<$<BOOL:${ENABLE_OPEN_SRC}>:${ASCEND_OPENSDK_DIR}/include/runtime>
        $<$<BOOL:${ENABLE_OPEN_SRC}>:${ASCEND_OPENSDK_DIR}/include/runtime/runtime>
        $<$<BOOL:${ENABLE_OPEN_SRC}>:${ASCEND_INSTALL_PATH}/include/experiment/msprof>
        $<$<BOOL:${ENABLE_OPEN_SRC}>:${ASCEND_INSTALL_PATH}/include/experiment/slog>
    endif()
        ${BASE_DIR}/src/acl/aclrt_c
        ${BASE_DIR}/src/acl/aclrt_c/common
        ${BASE_DIR}/include/external
        ${BASE_DIR}/include/external/acl
        ${BASE_DIR}/include
        ${BASE_DIR}/pkg_inc/base # dlog_pub.h
    )

    target_compile_options(${ASCENDCL_C_COMPILE_TARGET} PRIVATE
        $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:-fvisibility=hidden -O2 -fno-common>
        $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:/utf-8 /Od>
        $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Debug>>:/MTd>
        $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Release>>:/MT>
    )

    target_compile_definitions(${ASCENDCL_C_COMPILE_TARGET} PRIVATE
        FUNC_VISIBILITY
        $<IF:$<STREQUAL:${TARGET_SYSTEM_NAME},LiteOS>,NANO_OS_TYPE=1,NANO_OS_TYPE=0>
    )

    target_link_libraries(${ASCENDCL_C_COMPILE_TARGET} PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        $<$<NOT:$<BOOL:${ENABLE_OPEN_SRC}>>:$<BUILD_INTERFACE:msprof_headers>>
        c_sec_headers
        -Wl,--no-as-needed
        ge_executor_c_static
        -Wl,--as-needed
        slog_headers
        -s
        c_base_headers
        c_mmpa_headers
    )

    target_link_options(${ASCENDCL_C_COMPILE_TARGET} PRIVATE
        -Wl,-Bsymbolic
    )

    set_target_properties(${ASCENDCL_C_COMPILE_TARGET} PROPERTIES
        OUTPUT_NAME ascendcl
    )

    install(TARGETS ${ASCENDCL_C_COMPILE_TARGET} OPTIONAL
        LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}/c
    )
    # Linux end
elseif (${TARGET_SYSTEM_NAME} STREQUAL "LiteOS")
    # LiteOS start
    set(ASCENDCL_C_COMPILE_TARGET ascendcl_c_static_liteos)
    add_library(${ASCENDCL_C_COMPILE_TARGET} STATIC ${SRC_LIST})
    target_include_directories(${ASCENDCL_C_COMPILE_TARGET} PRIVATE
    if(NOT ENABLE_OPEN_SRC)
        ${TOP_DIR}/inc
        ${TOP_DIR}/inc/external
    else()
        $<$<BOOL:${ENABLE_OPEN_SRC}>:${ASCEND_INSTALL_PATH}/include>
        $<$<BOOL:${ENABLE_OPEN_SRC}>:${ASCEND_INSTALL_PATH}/include/experiment>
        $<$<BOOL:${ENABLE_OPEN_SRC}>:${CANN_GE_DIR}/inc>
        $<$<BOOL:${ENABLE_OPEN_SRC}>:${ASCEND_OPENSDK_DIR}/include/runtime>
        $<$<BOOL:${ENABLE_OPEN_SRC}>:${ASCEND_OPENSDK_DIR}/include/runtime/runtime>
        $<$<BOOL:${ENABLE_OPEN_SRC}>:${ASCEND_INSTALL_PATH}/include/experiment/msprof>
        $<$<BOOL:${ENABLE_OPEN_SRC}>:${ASCEND_INSTALL_PATH}/include/experiment/slog>
    endif()
        ${BASE_DIR}/src/acl/aclrt_c
        ${BASE_DIR}/src/acl/aclrt_c/common
        ${BASE_DIR}/include/external
        ${BASE_DIR}/include/external/acl
        ${BASE_DIR}/include
        ${BASE_DIR}/pkg_inc/base # dlog_pub.h
    )

    target_compile_options(${ASCENDCL_C_COMPILE_TARGET} PRIVATE
        $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:-fvisibility=hidden -O2 -fno-common>
        $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:/utf-8 /Od>
        $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Debug>>:/MTd>
        $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Release>>:/MT>
        ${CMAKE_EXTRA_COMPILE_OPTIONS}
    )

    target_compile_definitions(${ASCENDCL_C_COMPILE_TARGET} PRIVATE
        FUNC_VISIBILITY
        $<IF:$<STREQUAL:${TARGET_SYSTEM_NAME},LiteOS>,NANO_OS_TYPE=1,NANO_OS_TYPE=0>
    )

    target_link_libraries(${ASCENDCL_C_COMPILE_TARGET} PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        $<$<NOT:$<BOOL:${ENABLE_OPEN_SRC}>>:$<BUILD_INTERFACE:msprof_headers>>
        c_sec_headers
        -Wl,--no-as-needed
        ge_executor_c_static
        -Wl,--as-needed
        slog_headers
        -s
        c_base_headers
        c_mmpa_headers
    )

    target_link_options(${ASCENDCL_C_COMPILE_TARGET} PRIVATE
        -Wl,-Bsymbolic
    )

    set_target_properties(${ASCENDCL_C_COMPILE_TARGET} PROPERTIES
        OUTPUT_NAME ascendcl_liteos
    )

    install(TARGETS ${ASCENDCL_C_COMPILE_TARGET} OPTIONAL
        ARCHIVE DESTINATION ${INSTALL_LIBRARY_DIR}/c
    )

    # LiteOS打包
    set(ASCENDCL_C_STATIC_LIB_NAME "libascendcl.a")
    set(ASCENDCL_C_STATIC_LIB_MRI "${CMAKE_CURRENT_BINARY_DIR}/ascendcl_c_static.mri")
    if(NOT ENABLE_OPEN_SRC)
        add_custom_command(
            OUTPUT ${ASCENDCL_C_STATIC_LIB_MRI}
            COMMAND ${CMAKE_COMMAND} -E touch ${ASCENDCL_C_STATIC_LIB_MRI}
            COMMAND ${CMAKE_COMMAND} -E echo "create ${CMAKE_CURRENT_BINARY_DIR}/${ASCENDCL_C_STATIC_LIB_NAME}" >> ${ASCENDCL_C_STATIC_LIB_MRI}
            COMMAND ${CMAKE_COMMAND} -E echo "addlib $<TARGET_FILE:ascendcl_c_static_liteos>" >> ${ASCENDCL_C_STATIC_LIB_MRI}
            COMMAND ${CMAKE_COMMAND} -E echo "addlib $<TARGET_FILE:ge_executor_c_static>" >> ${ASCENDCL_C_STATIC_LIB_MRI}
            COMMAND ${CMAKE_COMMAND} -E echo "addlib $<TARGET_FILE:c_base_static>" >> ${ASCENDCL_C_STATIC_LIB_MRI}
            COMMAND ${CMAKE_COMMAND} -E echo "addlib $<TARGET_FILE:runtime_static>" >> ${ASCENDCL_C_STATIC_LIB_MRI}
            COMMAND ${CMAKE_COMMAND} -E echo "save" >> ${ASCENDCL_C_STATIC_LIB_MRI}
            COMMAND ${CMAKE_COMMAND} -E echo "end" >> ${ASCENDCL_C_STATIC_LIB_MRI}
            DEPENDS ascendcl_c_static_liteos ge_executor_c_static c_base_static runtime_static
        )
    else()
        file(WRITE ${ASCENDCL_C_STATIC_LIB_MRI}
        "create ${CMAKE_CURRENT_BINARY_DIR}/${ASCENDCL_C_STATIC_LIB_NAME}
            addlib ${CMAKE_CURRENT_BINARY_DIR}/libascendcl_liteos.a
            addlib ${ASCEND_INSTALL_PATH}/lib64/c/ge_exec/libge_executor.a
            addlib ${ASCEND_INSTALL_PATH}/lib64/c/runtime/libruntime.a
            addlib ${ASCEND_INSTALL_PATH}/lib64/libc_base.a
            save
            end")
    endif()

    add_custom_target(
        generate_mri_file ALL
        DEPENDS ${ASCENDCL_C_STATIC_LIB_MRI})

    add_custom_command(
        OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${ASCENDCL_C_STATIC_LIB_NAME}
        COMMAND ar -M <${ASCENDCL_C_STATIC_LIB_MRI}
        DEPENDS generate_mri_file
    )

    add_custom_target(
        ascendcl_c_static
        DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${ASCENDCL_C_STATIC_LIB_NAME})

    install(
        FILES ${CMAKE_CURRENT_BINARY_DIR}/${ASCENDCL_C_STATIC_LIB_NAME}
        DESTINATION ${INSTALL_LIBRARY_DIR}/c OPTIONAL
    )
    # LiteOS end
endif()
