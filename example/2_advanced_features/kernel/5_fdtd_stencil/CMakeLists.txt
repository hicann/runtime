# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

cmake_minimum_required(VERSION 3.16)

set(ASCENDC_CMAKE_DIR $ENV{ASCENDC_CMAKE_DIR})
set(SOC_VERSION $ENV{SOC_VERSION})
string(TOLOWER "${SOC_VERSION}" SOC_VERSION_LOWER)
if(SOC_VERSION_LOWER MATCHES "^ascend(950|350)")
    set(CMAKE_ASC_ARCHITECTURES dav-3510)
elseif(SOC_VERSION_LOWER MATCHES "^ascend910(b|_93)")
    set(CMAKE_ASC_ARCHITECTURES dav-2201)
else()
    message(FATAL_ERROR "Unsupported SOC_VERSION: ${SOC_VERSION}")
endif()
list(APPEND CMAKE_MODULE_PATH "${ASCENDC_CMAKE_DIR}/asc_modules")
find_package(ASC REQUIRED)
project(Runtime_Sample LANGUAGES ASC CXX)

set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "build type: Debug" FORCE)
set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_LIST_DIR}/out" CACHE STRING "install path" FORCE)

set_source_files_properties(main.cpp PROPERTIES LANGUAGE ASC)
add_executable(main main.cpp fdtd_stencil.cpp)
set_target_properties(main PROPERTIES LINKER_LANGUAGE ASC)

target_include_directories(main PRIVATE
    ${ASCEND_CANN_PACKAGE_PATH}/include
    ${CMAKE_CURRENT_SOURCE_DIR}/../../..
)

target_compile_options(main PRIVATE
    $<$<COMPILE_LANGUAGE:ASC>:-O2>
    $<$<COMPILE_LANGUAGE:CXX>:-O2;-std=c++17;-D_GLIBCXX_USE_CXX11_ABI=0;-Wall;-Werror>
)

target_link_libraries(main PRIVATE
    ${ASCEND_CANN_PACKAGE_PATH}/lib64/libacl_rt.so
)

install(TARGETS main RUNTIME DESTINATION bin)
