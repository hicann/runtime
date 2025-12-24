# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

cmake_minimum_required(VERSION 3.14.1)

set(MMPA_DIR ${CMAKE_CURRENT_LIST_DIR})

if (NOT TARGET_SYSTEM_NAME)
    set(TARGET_SYSTEM_NAME Linux)
endif()

add_library(mmpa_headers INTERFACE)
target_include_directories(mmpa_headers INTERFACE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/inc>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/inc/mmpa>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/inc/mmpa/sub_inc>
    $<INSTALL_INTERFACE:include>
    $<INSTALL_INTERFACE:include/mmpa>
    $<INSTALL_INTERFACE:include/mmpa/sub_inc>
)

add_library(mmpa SHARED
    $<$<OR:$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>,$<STREQUAL:${TARGET_SYSTEM_NAME},Android>>:src/mmpa_linux.c>
    $<$<OR:$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>,$<STREQUAL:${TARGET_SYSTEM_NAME},Android>>:src/mmpa_linux_thread.c>
    $<$<OR:$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>,$<STREQUAL:${TARGET_SYSTEM_NAME},Android>>:src/mmpa_linux_file.c>
    $<$<OR:$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>,$<STREQUAL:${TARGET_SYSTEM_NAME},Android>>:src/mmpa_linux_time.c>
    $<$<OR:$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>,$<STREQUAL:${TARGET_SYSTEM_NAME},Android>>:src/mmpa_linux_atom.c>
    $<$<OR:$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>,$<STREQUAL:${TARGET_SYSTEM_NAME},Android>>:src/mmpa_linux_dlfcn.c>
    $<$<OR:$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>,$<STREQUAL:${TARGET_SYSTEM_NAME},Android>>:src/mmpa_linux_memory.c>
    $<$<OR:$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>,$<STREQUAL:${TARGET_SYSTEM_NAME},Android>>:src/mmpa_linux_message.c>
    $<$<OR:$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>,$<STREQUAL:${TARGET_SYSTEM_NAME},Android>>:src/mmpa_linux_option.c>
    $<$<OR:$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>,$<STREQUAL:${TARGET_SYSTEM_NAME},Android>>:src/mmpa_linux_env.c>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:src/mmpa_win.cpp>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:src/mmpa_win_thread.cpp>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:src/mmpa_win_file.cpp>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:src/mmpa_win_time.cpp>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:src/mmpa_win_atom.cpp>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:src/mmpa_win_dlfcn.cpp>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:src/mmpa_win_memory.cpp>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:src/mmpa_win_message.cpp>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:src/mmpa_win_option.cpp>
)
target_include_directories(mmpa PRIVATE
    ${LIBC_SEC_HEADER}
)
target_link_libraries(mmpa
    PRIVATE
        intf_pub
        c_sec
        "$<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:dl;rt>"
    PUBLIC
        mmpa_headers
)
target_compile_options(mmpa PRIVATE
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:-fvisibility=hidden>
)
target_compile_definitions(mmpa PRIVATE
    $<IF:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,OS_TYPE=WIN,OS_TYPE=0>
    FUNC_VISIBILITY
    $<$<STREQUAL:${PRODUCT},ascend035>:STRERROR_R_RETURN_INT>
    $<$<STREQUAL:${PRODUCT},ascend031>:STRERROR_R_RETURN_INT>
)
if (WIN32)
    set_target_properties(mmpa PROPERTIES
        WINDOWS_EXPORT_ALL_SYMBOLS TRUE
        OUTPUT_NAME libmmpa
    )
endif()


add_library(static_mmpa  STATIC
    $<$<OR:$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>,$<STREQUAL:${TARGET_SYSTEM_NAME},Android>>:src/mmpa_linux.c>
    $<$<OR:$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>,$<STREQUAL:${TARGET_SYSTEM_NAME},Android>>:src/mmpa_linux_thread.c>
    $<$<OR:$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>,$<STREQUAL:${TARGET_SYSTEM_NAME},Android>>:src/mmpa_linux_file.c>
    $<$<OR:$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>,$<STREQUAL:${TARGET_SYSTEM_NAME},Android>>:src/mmpa_linux_time.c>
    $<$<OR:$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>,$<STREQUAL:${TARGET_SYSTEM_NAME},Android>>:src/mmpa_linux_atom.c>
    $<$<OR:$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>,$<STREQUAL:${TARGET_SYSTEM_NAME},Android>>:src/mmpa_linux_dlfcn.c>
    $<$<OR:$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>,$<STREQUAL:${TARGET_SYSTEM_NAME},Android>>:src/mmpa_linux_memory.c>
    $<$<OR:$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>,$<STREQUAL:${TARGET_SYSTEM_NAME},Android>>:src/mmpa_linux_message.c>
    $<$<OR:$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>,$<STREQUAL:${TARGET_SYSTEM_NAME},Android>>:src/mmpa_linux_option.c>
    $<$<OR:$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>,$<STREQUAL:${TARGET_SYSTEM_NAME},Android>>:src/mmpa_linux_env.c>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:src/mmpa_win.cpp>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:src/mmpa_win_thread.cpp>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:src/mmpa_win_file.cpp>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:src/mmpa_win_time.cpp>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:src/mmpa_win_atom.cpp>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:src/mmpa_win_dlfcn.cpp>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:src/mmpa_win_memory.cpp>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:src/mmpa_win_message.cpp>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:src/mmpa_win_option.cpp>
)
target_include_directories(static_mmpa PRIVATE
${LIBC_SEC_HEADER}
)
target_compile_definitions(static_mmpa PRIVATE
    $<IF:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,OS_TYPE=WIN,OS_TYPE=0>
    $<$<STREQUAL:${PRODUCT},ascend035>:STRERROR_R_RETURN_INT>
    $<$<STREQUAL:${PRODUCT},ascend031>:STRERROR_R_RETURN_INT>
)
target_compile_options(static_mmpa PRIVATE
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:-fvisibility=hidden>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<CONFIG:Debug>>:/MTd>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<CONFIG:Release>>:/MT>
)
target_link_libraries(static_mmpa
    PRIVATE
        $<BUILD_INTERFACE:intf_pub>
    PUBLIC
        mmpa_headers
)
set_target_properties(static_mmpa PROPERTIES
    ARCHIVE_OUTPUT_NAME $<IF:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,libstatic_mmpa,mmpa>
)

install_package(
    PACKAGE mmpa
    TARGETS mmpa static_mmpa mmpa_headers
    FILES   ${MMPA_DIR}/inc/mmpa/mmpa_api.h
    DESTINATION ${INSTALL_INCLUDE_DIR}/mmpa
    FILES   ${MMPA_DIR}/inc/mmpa/sub_inc/mmpa_linux.h
            ${MMPA_DIR}/inc/mmpa/sub_inc/mmpa_typedef_linux.h
            ${MMPA_DIR}/inc/mmpa/sub_inc/mmpa_env_define.h
    DESTINATION ${INSTALL_INCLUDE_DIR}/mmpa/sub_inc
)

if (WIN32)
    install(FILES $<TARGET_PDB_FILE:mmpa> DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL)
endif()
