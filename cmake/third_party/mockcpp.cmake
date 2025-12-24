# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

# function(create_opensource target_name suffix_name product_side install_prefix toolchain_file)

set(open_source_target_name mockcpp)

if (CMAKE_HOST_SYSTEM_PROCESSOR  STREQUAL "aarch64")
    set(mockcpp_CXXFLAGS "-fPIC")
else()
    set(mockcpp_CXXFLAGS "-fPIC -std=c++11")
endif()
set(mockcpp_FLAGS "-fPIC")
set(mockcpp_LINKER_FLAGS "")

if ((NOT DEFINED ABI_ZERO) OR (ABI_ZERO STREQUAL ""))
    set(ABI_ZERO "true")
endif()


if (ABI_ZERO STREQUAL true)
    set(mockcpp_CXXFLAGS "${mockcpp_CXXFLAGS} -D_GLIBCXX_USE_CXX11_ABI=0")
    set(mockcpp_FLAGS "${mockcpp_FLAGS} -D_GLIBCXX_USE_CXX11_ABI=0")
endif()

set(BUILD_WRAPPER ${ASCENDC_TOOLS_ROOT_DIR}/test/cmake/tools/build_ext.sh) # TODO 这个tool在这里是否合适
set(BUILD_TYPE "DEBUG")

if (CMAKE_GENERATOR MATCHES "Unix Makefiles")
    set(IS_MAKE True)
    set(MAKE_CMD "$(MAKE)")
else()
    set(IS_MAKE False)
endif()

#依赖蓝区二进制仓mockcpp
set(mockcpp_SRC_DIR ${OPEN_SOURCE_DIR}/mockcpp_src)
set(DOWNLOAD_FILE_DIR ${OPEN_SOURCE_DIR}/mockcpp-2.7)
set(URL_FILE ${DOWNLOAD_FILE_DIR}/mockcpp-2.7.tar.gz)
#set(PATCH_FILE ${DOWNLOAD_FILE_DIR}/mockcpp-2.7_py3.patch)
set(BOOST_INCLUDE_DIRS ${OPEN_SOURCE_DIR}/boost-1.87.0)

message(STATUS "mock cmake install prefix ${CMAKE_INSTALL_PREFIX}")
if (NOT EXISTS "${OPEN_SOURCE_DIR}/mockcpp/lib/libmockcpp.a" OR TRUE)
    set(PATCH_FILE ${OPEN_SOURCE_DIR}/mockcpp-2.7/mockcpp-2.7_py3test.patch)
    if (TRUE)
        message(STATUS, "mockcpp patch not use cache.")
        file(DOWNLOAD
            "https://gitcode.com/cann-src-third-party/mockcpp/releases/download/v2.7-h2/mockcpp-2.7_py3.patch"
            ${PATCH_FILE}
            TIMEOUT 60
        )
    endif()
    include(ExternalProject)
    message(STATUS, "CMAKE_COMMAND is ${CMAKE_COMMAND}")
    if (NOT EXISTS "${URL_FILE}")
        set(URL_FILE "https://gitcode.com/cann-src-third-party/mockcpp/releases/download/v2.7-h2/mockcpp-2.7.tar.gz")
        message("mockcpp not use cache, new url file: ${URL_FILE}")
    endif()
    ExternalProject_Add(mockcpp
        URL ${URL_FILE}
        DOWNLOAD_DIR ${DOWNLOAD_FILE_DIR}
        SOURCE_DIR ${mockcpp_SRC_DIR}
        TLS_VERIFY OFF
        PATCH_COMMAND git init && git apply ${PATCH_FILE}

        CONFIGURE_COMMAND ${CMAKE_COMMAND} -G ${CMAKE_GENERATOR}
            -DCMAKE_CXX_FLAGS=${mockcpp_CXXFLAGS}
            -DCMAKE_C_FLAGS=${mockcpp_FLAGS}
            -DBOOST_INCLUDE_DIRS=${BOOST_INCLUDE_DIRS}
            -DCMAKE_SHARED_LINKER_FLAGS=${mockcpp_LINKER_FLAGS}
            -DCMAKE_EXE_LINKER_FLAGS=${mockcpp_LINKER_FLAGS}
            -DBUILD_32_BIT_TARGET_BY_64_BIT_COMPILER=OFF
            -DCMAKE_INSTALL_PREFIX=${OPEN_SOURCE_DIR}/mockcpp
            <SOURCE_DIR>
        BUILD_COMMAND ${${BUILD_TYPE}} $<$<BOOL:${IS_MAKE}>:$(MAKE)>
    )
    message(STATUS, "get mockcpp")
endif()