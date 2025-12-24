# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

if (adump_FOUND)
    message(STATUS "Package adump has been found.")
    return()
endif()

set(_cmake_targets_defined "")
set(_cmake_targets_not_defined "")
set(_cmake_expected_targets "")
foreach(_cmake_expected_target IN ITEMS adump_server adump_headers adcore ascend_dump)
    list(APPEND _cmake_expected_targets "${_cmake_expected_target}")
    if(TARGET "${_cmake_expected_target}")
        list(APPEND _cmake_targets_defined "${_cmake_expected_target}")
    else()
        list(APPEND _cmake_targets_not_defined "${_cmake_expected_target}")
    endif()
endforeach()
unset(_cmake_expected_target)

if(_cmake_targets_defined STREQUAL _cmake_expected_targets)
    unset(_cmake_targets_defined)
    unset(_cmake_targets_not_defined)
    unset(_cmake_expected_targets)
    unset(CMAKE_IMPORT_FILE_VERSION)
    cmake_policy(POP)
    return()
endif()

if(NOT _cmake_targets_defined STREQUAL "")
    string(REPLACE ";" ", " _cmake_targets_defined_text "${_cmake_targets_defined}")
    string(REPLACE ";" ", " _cmake_targets_not_defined_text "${_cmake_targets_not_defined}")
    message(FATAL_ERROR "Some (but not all) targets in this export set were already defined.\nTargets Defined: ${_cmake_targets_defined_text}\nTargets not yet defined: ${_cmake_targets_not_defined_text}\n")
endif()
unset(_cmake_targets_defined)
unset(_cmake_targets_not_defined)
unset(_cmake_expected_targets)

find_path(_INCLUDE_DIR
    NAMES experiment/adump/external/adump_api.h
    NO_CMAKE_SYSTEM_PATH
    NO_CMAKE_FIND_ROOT_PATH)

find_library(adump_server_STATIC_LIBRARY
    NAMES libadump_server.a
    PATH_SUFFIXES lib64
    NO_CMAKE_SYSTEM_PATH
    NO_CMAKE_FIND_ROOT_PATH)

find_library(adcore_STATIC_LIBRARY
    NAMES libadcore.a
    PATH_SUFFIXES lib64
    NO_CMAKE_SYSTEM_PATH
    NO_CMAKE_FIND_ROOT_PATH)

find_library(ascend_dump_SHARED_LIBRARY
    NAMES libascend_dump.so
    PATH_SUFFIXES lib64
    NO_CMAKE_SYSTEM_PATH
    NO_CMAKE_FIND_ROOT_PATH)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(adump
    FOUND_VAR
        adump_FOUND
    REQUIRED_VARS
        _INCLUDE_DIR
        adump_server_STATIC_LIBRARY
        adcore_STATIC_LIBRARY
        ascend_dump_SHARED_LIBRARY
)

if(adump_FOUND)
    set(adump_INCLUDE_DIR "${_INCLUDE_DIR}/experiment")
    include(CMakePrintHelpers)
    message(STATUS "Variables in adump module:")
    cmake_print_variables(adump_INCLUDE_DIR)
    cmake_print_variables(adump_server_STATIC_LIBRARY)
    cmake_print_variables(adcore_STATIC_LIBRARY)
    cmake_print_variables(ascend_dump_SHARED_LIBRARY)

    add_library(adump_server STATIC IMPORTED)
    set_target_properties(adump_server PROPERTIES
        INTERFACE_LINK_LIBRARIES "adump_headers"
        IMPORTED_LOCATION "${adump_server_STATIC_LIBRARY}"
    )

    add_library(adump_headers INTERFACE IMPORTED)
    set_target_properties(adump_headers PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${adump_INCLUDE_DIR};${adump_INCLUDE_DIR}/adump;${adump_INCLUDE_DIR}/adump/external"
    )

    add_library(adcore STATIC IMPORTED)
    set_target_properties(adcore PROPERTIES
        INTERFACE_LINK_LIBRARIES "-Wl,--no-as-needed;\$<LINK_ONLY:c_sec>;\$<LINK_ONLY:mmpa>;-Wl,--as-needed;\$<LINK_ONLY:\$<\$<STREQUAL:host,host>:ascend_hal_stub>>;\$<LINK_ONLY:\$<\$<STREQUAL:host,device>:ascend_hal>>"
        IMPORTED_LOCATION "${adcore_STATIC_LIBRARY}"
    )

    add_library(ascend_dump SHARED IMPORTED)
    set_target_properties(ascend_dump PROPERTIES
        INTERFACE_LINK_LIBRARIES "adump_headers"
        IMPORTED_LINK_DEPENDENT_LIBRARIES "ascend_protobuf;slog;runtime"
        IMPORTED_LOCATION "${ascend_dump_SHARED_LIBRARY}"
    )

    include(CMakePrintHelpers)
    cmake_print_properties(TARGETS adump_server
        PROPERTIES INTERFACE_LINK_LIBRARIES IMPORTED_LOCATION
    )
    cmake_print_properties(TARGETS adump_headers
        PROPERTIES INTERFACE_INCLUDE_DIRECTORIES
    )
    cmake_print_properties(TARGETS adcore
        PROPERTIES INTERFACE_LINK_LIBRARIES IMPORTED_LOCATION
    )
    cmake_print_properties(TARGETS ascend_dump
        PROPERTIES INTERFACE_LINK_LIBRARIES IMPORTED_LINK_DEPENDENT_LIBRARIES IMPORTED_LOCATION
    )
endif()

# Cleanup temporary variables.
set(_INCLUDE_DIR)
