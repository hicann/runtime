# ----------------------------------------------------------------------------
# This program is free software, you can redistribute it and/or modify it.
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This file is a part of the CANN Open Software.
# Licensed under CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING
# BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE. See LICENSE in the root of
# the software repository for the full text of the License.
# ----------------------------------------------------------------------------
include_guard(GLOBAL)

unset(GTEST_FOUND CACHE)
unset(GTEST_INCLUDE CACHE)
unset(GTEST_LIBRARY CACHE)
unset(GTEST_MAIN_LIBRARY CACHE)
unset(GMOCK_LIBRARY CACHE)
unset(GMOCK_MAIN_LIBRARY CACHE)
set(GTEST_INSTALL_PATH ${OPEN_SOURCE_DIR}/gtest_shared)
message("GTEST_INSTALL_PATH=${GTEST_INSTALL_PATH}")
find_path(GTEST_INCLUDE
        NAMES gtest/gtest.h
        NO_CMAKE_SYSTEM_PATH
        NO_CMAKE_FIND_ROOT_PATH
        PATHS ${GTEST_INSTALL_PATH}/include)
find_library(GTEST_LIBRARY
        NAMES libgtest.so
        PATH_SUFFIXES lib lib64
        NO_CMAKE_SYSTEM_PATH
        NO_CMAKE_FIND_ROOT_PATH
        PATHS ${GTEST_INSTALL_PATH})
find_library(GTEST_MAIN_LIBRARY
        NAMES libgtest_main.so
        PATH_SUFFIXES lib lib64
        NO_CMAKE_SYSTEM_PATH
        NO_CMAKE_FIND_ROOT_PATH
        PATHS ${GTEST_INSTALL_PATH})
find_library(GMOCK_LIBRARY
        NAMES libgmock.so
        PATH_SUFFIXES lib lib64
        NO_CMAKE_SYSTEM_PATH
        NO_CMAKE_FIND_ROOT_PATH
        PATHS ${GTEST_INSTALL_PATH})
find_library(GMOCK_MAIN_LIBRARY
        NAMES libgmock_main.so
        PATH_SUFFIXES lib lib64
        NO_CMAKE_SYSTEM_PATH
        NO_CMAKE_FIND_ROOT_PATH
        PATHS ${GTEST_INSTALL_PATH})

find_program(CCACHE_PROGRAM ccache)
if(CCACHE_PROGRAM)
    set(CMAKE_C_COMPILER_LAUNCHER ${CCACHE_PROGRAM})
    set(CMAKE_CXX_COMPILER_LAUNCHER ${CCACHE_PROGRAM})
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(gtest
        FOUND_VAR
        GTEST_FOUND
        REQUIRED_VARS
        GTEST_INCLUDE
        GTEST_LIBRARY
        GTEST_MAIN_LIBRARY
        GMOCK_LIBRARY
        GMOCK_MAIN_LIBRARY
        )
message("gtest shared FOUND found:${gtest_FOUND}")

if(GTEST_FOUND AND NOT FORCE_REBUILD_CANN_3RD)
    message("gtest shared found in ${GTEST_INSTALL_PATH}, and not force rebuild cann third_party")
else()
    message("gtest not use cache, download the source code")
    set(REQ_URL "https://gitcode.com/cann-src-third-party/googletest/releases/download/v1.14.0/googletest-1.14.0.tar.gz")
    set (gtest_CXXFLAGS "-D_GLIBCXX_USE_CXX11_ABI=0 -O2 -D_FORTIFY_SOURCE=2 -fPIC -fstack-protector-all -Wl,-z,relro,-z,now,-z,noexecstack")
    set (gtest_CFLAGS   "-D_GLIBCXX_USE_CXX11_ABI=0 -O2 -D_FORTIFY_SOURCE=2 -fPIC -fstack-protector-all -Wl,-z,relro,-z,now,-z,noexecstack")

    message("REQ_URL:${REQ_URL}")
    include(ExternalProject)
    ExternalProject_Add(gtest_shared_build
            URL ${REQ_URL}
            TLS_VERIFY OFF
            DOWNLOAD_DIR ${gtest_DOWNLOAD_PATH}
            SOURCE_DIR ${GTEST_INSTALL_PATH}
            #DOWNLOAD_EXTRACT_TIMESTAMP true
            CONFIGURE_COMMAND ${CMAKE_COMMAND}
            -DCMAKE_CXX_FLAGS=${gtest_CXXFLAGS}
            -DCMAKE_C_FLAGS=${gtest_CFLAGS}
            -DCMAKE_INSTALL_PREFIX=${GTEST_INSTALL_PATH}
            -DCMAKE_INSTALL_LIBDIR=lib64
            -DBUILD_SHARED_LIBS=ON
            -DCMAKE_C_COMPILER_LAUNCHER=${CCACHE_PROGRAM}
            -DCMAKE_CXX_COMPILER_LAUNCHER=${CCACHE_PROGRAM}
            <SOURCE_DIR>
            BUILD_COMMAND $(MAKE)
            INSTALL_COMMAND $(MAKE) install
            EXCLUDE_FROM_ALL TRUE
            )
endif()

add_library(GTest::gtest SHARED IMPORTED)
add_dependencies(GTest::gtest gtest_shared_build)

add_library(GTest::gmock SHARED IMPORTED)
add_dependencies(GTest::gmock gtest_shared_build)

add_library(GTest::gtest_main SHARED IMPORTED)
add_dependencies(GTest::gtest_main gtest_shared_build)

add_library(GTest::gmock_main SHARED IMPORTED)
add_dependencies(GTest::gmock_main gtest_shared_build)

message("GTEST_INSTALL_PATH = ${GTEST_INSTALL_PATH}")

if (NOT EXISTS ${GTEST_INSTALL_PATH}/include)
  file(MAKE_DIRECTORY "${GTEST_INSTALL_PATH}/include")
endif ()

set_target_properties(GTest::gtest PROPERTIES
        IMPORTED_LOCATION ${GTEST_INSTALL_PATH}/lib64/libgtest.so.1.14.0
        INTERFACE_INCLUDE_DIRECTORIES ${GTEST_INSTALL_PATH}/include)

set_target_properties(GTest::gmock PROPERTIES
        IMPORTED_LOCATION ${GTEST_INSTALL_PATH}/lib64/libgmock.so.1.14.0
        INTERFACE_INCLUDE_DIRECTORIES ${GTEST_INSTALL_PATH}/include)

set_target_properties(GTest::gtest_main PROPERTIES
        IMPORTED_LOCATION ${GTEST_INSTALL_PATH}/lib64/libgtest_main.so.1.14.0
        INTERFACE_INCLUDE_DIRECTORIES ${GTEST_INSTALL_PATH}/include)

set_target_properties(GTest::gmock_main PROPERTIES
        IMPORTED_LOCATION ${GTEST_INSTALL_PATH}/lib64/libgmock_main.so.1.14.0
        INTERFACE_INCLUDE_DIRECTORIES ${GTEST_INSTALL_PATH}/include)