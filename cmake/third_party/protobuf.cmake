# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

if (NOT ENABLE_OPEN_SRC)
    return()
endif()

if(POLICY CMP0135)
    cmake_policy(SET CMP0135 NEW)
endif()

include(ExternalProject)
include(GNUInstallDirs)

# ==========================================================================================================
# 1. Paths & Directories Setup
# ==========================================================================================================
set(PROTOBUF_LIB_CACHE_DIR ${OPEN_SOURCE_DIR}/lib_cache/protobuf-25.1/)
set(PROTOBUF_SRC_DIR ${CMAKE_BINARY_DIR}/protobuf-src)
set(PROTOBUF_DL_DIR ${CMAKE_BINARY_DIR}/downloads)
set(PROTOBUF_STATIC_PKG_DIR ${CMAKE_BINARY_DIR}/protobuf_static)
set(PROTOBUF_SHARED_PKG_DIR ${CMAKE_BINARY_DIR}/protobuf_shared)
set(PROTOBUF_HOST_STATIC_PKG_DIR ${CMAKE_BINARY_DIR}/protobuf_host_static)

set(SOURCE_DIR ${PROTOBUF_SRC_DIR})
set(PROTOBUF_INCLUDE_DIRS ${PROTOBUF_LIB_CACHE_DIR}/include)
set(PROTOBUF_HOST_DIR ${PROTOBUF_LIB_CACHE_DIR})

set(LIB_SUB_DIR "lib64")
set(PROTOBUF_STATIC_FILE_NAME "libhost_ascend_protobuf.a")
if(PRODUCT_SIDE STREQUAL "device")
    set(PROTOBUF_STATIC_FILE_NAME "libascend_protobuf.a")
    set(LIB_SUB_DIR "lib64/device/lib64")
endif()

if(DEFINED ENV{ASCEND_HOME_PATH})
    set(LD_LIB_PATHS "$ENV{ASCEND_HOME_PATH}/${LIB_SUB_DIR}")
    set(LD_BIN_PATHS "$ENV{ASCEND_HOME_PATH}/bin")
endif()

# 使用设备端工具链生成 ascend_protobuf_static
set(CMAKE_CXX_COMPILER_ ${TOOLCHAIN_DIR}/bin/aarch64-target-linux-gnu-g++)
set(CMAKE_C_COMPILER_ ${TOOLCHAIN_DIR}/bin/aarch64-target-linux-gnu-gcc)

# ==========================================================================================================
# 2. Compile Flags & Optimization
# ==========================================================================================================
set(SECURITY_COMPILE_OPT "-Wl,-z,relro,-z,now,-z,noexecstack -s -Wl,-Bsymbolic")
set(DEV_PROTOBUF_SHARED_CXXFLAGS "${SECURITY_COMPILE_OPT} -Wno-maybe-uninitialized -Wno-unused-parameter -fPIC -fstack-protector-all -D_FORTIFY_SOURCE=2 -D_GLIBCXX_USE_CXX11_ABI=1 -O2 -Dgoogle=ascend_private")
set(HOST_PROTOBUF_SHARED_CXXFLAGS "${SECURITY_COMPILE_OPT} -Wno-maybe-uninitialized -Wno-unused-parameter -fPIC -fstack-protector-all -D_FORTIFY_SOURCE=2 -D_GLIBCXX_USE_CXX11_ABI=0 -O2 -Dgoogle=ascend_private")
set(DEV_PROTOBUF_STATIC_CXXFLAGS "-fvisibility=hidden -fvisibility-inlines-hidden -Wno-maybe-uninitialized -Wno-unused-parameter -fPIC -fstack-protector-all -D_FORTIFY_SOURCE=2 -D_GLIBCXX_USE_CXX11_ABI=1 -O2 -Dgoogle=ascend_private")
set(HOST_PROTOBUF_STATIC_CXXFLAGS "-fvisibility=hidden -fvisibility-inlines-hidden -Wno-maybe-uninitialized -Wno-unused-parameter -fPIC -fstack-protector-all -D_FORTIFY_SOURCE=2 -D_GLIBCXX_USE_CXX11_ABI=0 -O2 -Dgoogle=ascend_private")

if (PRODUCT_SIDE STREQUAL "device")
    set(HOST_PROTOBUF_SHARED_CXXFLAGS ${DEV_PROTOBUF_SHARED_CXXFLAGS})
    set(HOST_PROTOBUF_STATIC_CXXFLAGS ${DEV_PROTOBUF_STATIC_CXXFLAGS})
endif()

include(${CMAKE_CURRENT_LIST_DIR}/protobuf_sym_rename.cmake)
set(HOST_PROTOBUF_SHARED_CXXFLAGS "${HOST_PROTOBUF_SHARED_CXXFLAGS} ${PROTOBUF_SYM_RENAME}")
set(HOST_PROTOBUF_STATIC_CXXFLAGS "${HOST_PROTOBUF_STATIC_CXXFLAGS} ${PROTOBUF_SYM_RENAME}")

# ==========================================================================================================
# 3. Find Existing Libraries & Protoc
# ==========================================================================================================
# 优先搜索 LD_LIBRARY_PATH 里的 bin，然后搜索 PROTOBUF_LIB_CACHE_DIR 的 bin
find_program(PROTOC_PATH protoc PATHS ${PROTOBUF_LIB_CACHE_DIR}/bin ${LD_BIN_PATHS} NO_DEFAULT_PATH)

# 优先搜索 LD_LIBRARY_PATH 里的 lib，然后搜索 PROTOBUF_LIB_CACHE_DIR
find_library(ASCEND_PROTOBUF_STATIC_LIB NAMES ${PROTOBUF_STATIC_FILE_NAME} PATHS ${PROTOBUF_LIB_CACHE_DIR}/lib ${LD_LIB_PATHS} NO_DEFAULT_PATH)
find_library(HOST_PROTOBUF_STATIC_LIB NAMES ${PROTOBUF_STATIC_FILE_NAME} PATHS ${PROTOBUF_LIB_CACHE_DIR}/lib ${LD_LIB_PATHS} NO_DEFAULT_PATH)

if (NOT PRODUCT_SIDE STREQUAL "device") 
    find_library(ASCEND_PROTOBUF_SHARED_LIB NAMES libascend_protobuf.so.3.13.0.0 PATHS ${PROTOBUF_LIB_CACHE_DIR}/lib ${LD_LIB_PATHS} NO_DEFAULT_PATH)
endif()

# 判断是否需要构建
if (NOT PROTOC_PATH OR NOT ASCEND_PROTOBUF_STATIC_LIB OR NOT ASCEND_PROTOBUF_SHARED_LIB OR NOT HOST_PROTOBUF_STATIC_LIB OR NOT EXISTS "${PROTOBUF_INCLUDE_DIRS}")
    set(NEED_BUILD_PROTOBUF ON)
else()
    set(NEED_BUILD_PROTOBUF OFF)
endif()


# ==========================================================================================================
# 4. Source Preparation (Download & Extract)
# ==========================================================================================================
if (NEED_BUILD_PROTOBUF)
    # 解析 protobuf 源码包路径
    if (EXISTS ${OPEN_SOURCE_DIR}/protobuf-all-25.1.tar.gz)
        set(PROTOBUF_PATH ${OPEN_SOURCE_DIR}/protobuf-all-25.1.tar.gz)
    elseif (EXISTS ${OPEN_SOURCE_DIR}/protobuf-25.1.tar.gz)
        set(PROTOBUF_PATH ${OPEN_SOURCE_DIR}/protobuf-25.1.tar.gz)
    elseif (EXISTS ${OPEN_SOURCE_DIR}/protobuf/protobuf-all-25.1.tar.gz)
        set(PROTOBUF_PATH ${OPEN_SOURCE_DIR}/protobuf/protobuf-all-25.1.tar.gz)
    else ()
        set(PROTOBUF_PATH ${OPEN_SOURCE_DIR}/protobuf/protobuf-25.1.tar.gz)
    endif ()

    # 解析 abseil 源码包路径
    if (EXISTS ${OPEN_SOURCE_DIR}/abseil-cpp-20230802.1.tar.gz)
        set(ABSEIL_PATH ${OPEN_SOURCE_DIR}/abseil-cpp-20230802.1.tar.gz)
    else()
        set(ABSEIL_PATH ${OPEN_SOURCE_DIR}/abseil-cpp/abseil-cpp-20230802.1.tar.gz)
    endif()

    if (NOT EXISTS "${ABSEIL_PATH}" OR NOT EXISTS "${PROTOBUF_PATH}")
        set(REQ_URL "https://gitcode.com/cann-src-third-party/protobuf/releases/download/v25.1/protobuf-25.1.tar.gz")
        set(ABS_REQ_URL "https://gitcode.com/cann-src-third-party/abseil-cpp/releases/download/20230802.1/abseil-cpp-20230802.1.tar.gz")
        ExternalProject_Add(protobuf_src_dl URL ${REQ_URL} DOWNLOAD_DIR ${PROTOBUF_DL_DIR}/ TLS_VERIFY OFF DOWNLOAD_NO_EXTRACT 1 CONFIGURE_COMMAND "" BUILD_COMMAND "" INSTALL_COMMAND "")
        ExternalProject_Add(abseil_src_dl URL ${ABS_REQ_URL} DOWNLOAD_DIR ${PROTOBUF_DL_DIR}/abseil-cpp/ TLS_VERIFY OFF DOWNLOAD_NO_EXTRACT 1 CONFIGURE_COMMAND "" BUILD_COMMAND "" INSTALL_COMMAND "")
        ExternalProject_Add(protobuf_src
            DOWNLOAD_COMMAND ""
            COMMAND tar -zxf ${PROTOBUF_DL_DIR}/protobuf-25.1.tar.gz --strip-components 1 -C ${SOURCE_DIR}
            COMMAND tar -zxf ${PROTOBUF_DL_DIR}/abseil-cpp/abseil-cpp-20230802.1.tar.gz --strip-components 1 -C ${SOURCE_DIR}/third_party/abseil-cpp
            PATCH_COMMAND cd ${SOURCE_DIR} && patch -p1 < ${RUNTIME_DIR}/cmake/third_party/protobuf_25.1_change_version.patch && cd ${SOURCE_DIR}/third_party/abseil-cpp && patch -p1 < ${RUNTIME_DIR}/cmake/third_party/protobuf-hide_absl_symbols.patch
            CONFIGURE_COMMAND "" BUILD_COMMAND "" INSTALL_COMMAND ""
        )
        add_dependencies(protobuf_src protobuf_src_dl abseil_src_dl)
    else()
        ExternalProject_Add(protobuf_src
            DOWNLOAD_COMMAND ""
            COMMAND tar -zxf ${PROTOBUF_PATH} --strip-components 1 -C ${SOURCE_DIR}
            COMMAND tar -zxf ${ABSEIL_PATH} --strip-components 1 -C ${SOURCE_DIR}/third_party/abseil-cpp
            PATCH_COMMAND cd ${SOURCE_DIR} && patch -p1 < ${RUNTIME_DIR}/cmake/third_party/protobuf_25.1_change_version.patch && cd ${SOURCE_DIR}/third_party/abseil-cpp && patch -p1 < ${RUNTIME_DIR}/cmake/third_party/protobuf-hide_absl_symbols.patch
            CONFIGURE_COMMAND "" BUILD_COMMAND "" INSTALL_COMMAND ""
        )
    endif()

    # 如果只要头文件而无需全部编译，单独提取包含头文件的安装
    if (ASCEND_PROTOBUF_STATIC_LIB AND NOT EXISTS "${PROTOBUF_INCLUDE_DIRS}")
        ExternalProject_Add(protobuf_headers_only_build
            DEPENDS protobuf_src SOURCE_DIR ${PROTOBUF_SRC_DIR} DOWNLOAD_COMMAND "" UPDATE_COMMAND "" CONFIGURE_COMMAND "" BUILD_COMMAND ""
            INSTALL_COMMAND ${CMAKE_COMMAND} -E make_directory ${PROTOBUF_HOST_DIR}/include
                    COMMAND bash -c "cd ${PROTOBUF_SRC_DIR}/src && find google -name '*.h' -o -name '*.inc' | xargs -i cp --parents {} ${PROTOBUF_HOST_DIR}/include/"
                    COMMAND bash -c "cd ${PROTOBUF_SRC_DIR}/third_party/abseil-cpp && find absl -name '*.h' -o -name '*.inc' | xargs -i cp --parents {} ${PROTOBUF_HOST_DIR}/include/"
                    COMMAND bash -c "sed -i 's/#define ABSL_OPTION_USE_STD_STRING_VIEW 2/#define ABSL_OPTION_USE_STD_STRING_VIEW 0/g' ${PROTOBUF_HOST_DIR}/include/absl/base/options.h"
            EXCLUDE_FROM_ALL TRUE
        )
        add_custom_target(protobuf_headers_target DEPENDS protobuf_headers_only_build)
    endif()
endif()


# ==========================================================================================================
# 5. Targets Definition & Linking
# ==========================================================================================================

# ---------------------------------------------------------
# Target: host_protoc
# ---------------------------------------------------------
add_executable(host_protoc IMPORTED)
if (PROTOC_PATH)
    set_target_properties(host_protoc PROPERTIES IMPORTED_LOCATION ${PROTOC_PATH})
else()
    ExternalProject_Add(protobuf_host_build
        DEPENDS protobuf_src SOURCE_DIR ${PROTOBUF_SRC_DIR} DOWNLOAD_COMMAND "" UPDATE_COMMAND ""
        CONFIGURE_COMMAND ${CMAKE_COMMAND} -DCMAKE_CXX_STANDARD=14 -DCMAKE_C_COMPILER_LAUNCHER=${CMAKE_C_COMPILER_LAUNCHER} -DCMAKE_CXX_COMPILER_LAUNCHER=${CMAKE_CXX_COMPILER_LAUNCHER} -DCMAKE_INSTALL_PREFIX=${PROTOBUF_HOST_DIR} -Dprotobuf_BUILD_TESTS=OFF -Dprotobuf_WITH_ZLIB=OFF <SOURCE_DIR>
        BUILD_COMMAND $(MAKE) protoc
        INSTALL_COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_BINARY_DIR}/bin COMMAND cp ${CMAKE_CURRENT_BINARY_DIR}/protobuf_host_build-prefix/src/protobuf_host_build-build/protoc ${CMAKE_BINARY_DIR}/bin/protoc
        EXCLUDE_FROM_ALL TRUE
    )
    set_target_properties(host_protoc PROPERTIES IMPORTED_LOCATION ${CMAKE_BINARY_DIR}/bin/protoc)
    add_dependencies(host_protoc protobuf_host_build)
endif()

# ---------------------------------------------------------
# Target: ascend_protobuf_static
# ---------------------------------------------------------
add_library(ascend_protobuf_static_lib STATIC IMPORTED)
add_library(ascend_protobuf_static INTERFACE)

if (ASCEND_PROTOBUF_STATIC_LIB AND EXISTS "${PROTOBUF_INCLUDE_DIRS}")
    set_target_properties(ascend_protobuf_static_lib PROPERTIES IMPORTED_LOCATION ${ASCEND_PROTOBUF_STATIC_LIB})
    target_include_directories(ascend_protobuf_static INTERFACE ${PROTOBUF_INCLUDE_DIRS})
    target_link_libraries(ascend_protobuf_static INTERFACE ascend_protobuf_static_lib)
    set(PROTOBUF_STATIC_FINAL_PATH ${ASCEND_PROTOBUF_STATIC_LIB})
elseif(TARGET protobuf_headers_target AND ASCEND_PROTOBUF_STATIC_LIB)
    set_target_properties(ascend_protobuf_static_lib PROPERTIES IMPORTED_LOCATION ${ASCEND_PROTOBUF_STATIC_LIB})
    target_include_directories(ascend_protobuf_static INTERFACE ${PROTOBUF_INCLUDE_DIRS})
    target_link_libraries(ascend_protobuf_static INTERFACE ascend_protobuf_static_lib)
    add_dependencies(ascend_protobuf_static protobuf_headers_target)
    set(PROTOBUF_STATIC_FINAL_PATH ${ASCEND_PROTOBUF_STATIC_LIB})
else()
    ExternalProject_Add(protobuf_static_build
        DEPENDS protobuf_src SOURCE_DIR ${PROTOBUF_SRC_DIR} DOWNLOAD_COMMAND "" UPDATE_COMMAND ""
        CONFIGURE_COMMAND ${CMAKE_COMMAND} -G ${CMAKE_GENERATOR} -DCMAKE_C_COMPILER_LAUNCHER=${CMAKE_C_COMPILER_LAUNCHER} -DCMAKE_CXX_COMPILER_LAUNCHER=${CMAKE_CXX_COMPILER_LAUNCHER} -DTOOLCHAIN_DIR=${TOOLCHAIN_DIR} -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE} -DCMAKE_INSTALL_LIBDIR=lib -DBUILD_SHARED_LIBS=OFF -DCMAKE_CXX_STANDARD=14 -Dprotobuf_WITH_ZLIB=OFF -DLIB_PREFIX=ascend_ -DCMAKE_SKIP_RPATH=TRUE -Dprotobuf_BUILD_TESTS=OFF -DCMAKE_CXX_FLAGS=${HOST_PROTOBUF_STATIC_CXXFLAGS} -DCMAKE_INSTALL_PREFIX=${PROTOBUF_STATIC_PKG_DIR} -Dprotobuf_BUILD_PROTOC_BINARIES=OFF -DABSL_COMPILE_OBJ=TRUE <SOURCE_DIR>
        BUILD_COMMAND $(MAKE) INSTALL_COMMAND $(MAKE) install EXCLUDE_FROM_ALL TRUE
    )
    set_target_properties(ascend_protobuf_static_lib PROPERTIES IMPORTED_LOCATION ${PROTOBUF_STATIC_PKG_DIR}/lib/libascend_protobuf.a)
    target_include_directories(ascend_protobuf_static INTERFACE ${PROTOBUF_STATIC_PKG_DIR}/include)
    target_link_libraries(ascend_protobuf_static INTERFACE ascend_protobuf_static_lib)
    add_dependencies(ascend_protobuf_static protobuf_static_build)
    set(PROTOBUF_STATIC_FINAL_PATH ${PROTOBUF_STATIC_PKG_DIR}/lib/libascend_protobuf.a)
endif()

# ---------------------------------------------------------
# Target: ascend_protobuf (Shared)
# ---------------------------------------------------------
add_library(ascend_protobuf_shared_lib UNKNOWN IMPORTED)
add_library(ascend_protobuf INTERFACE)

if (NOT PRODUCT_SIDE STREQUAL "device" AND ASCEND_PROTOBUF_SHARED_LIB AND EXISTS "${PROTOBUF_INCLUDE_DIRS}")
    set_target_properties(ascend_protobuf_shared_lib PROPERTIES IMPORTED_LOCATION ${ASCEND_PROTOBUF_SHARED_LIB})
    set_target_properties(ascend_protobuf_shared_lib PROPERTIES IMPORTED_NO_SONAME TRUE)
    target_include_directories(ascend_protobuf INTERFACE ${PROTOBUF_INCLUDE_DIRS})
    target_link_libraries(ascend_protobuf INTERFACE ascend_protobuf_shared_lib)
    get_filename_component(PROTOBUF_SHARED_LIB_DIR "${ASCEND_PROTOBUF_SHARED_LIB}" DIRECTORY)
    get_filename_component(PROTOBUF_SHARED_PKG_DIR "${PROTOBUF_SHARED_LIB_DIR}" DIRECTORY)
elseif(NOT PRODUCT_SIDE STREQUAL "device" AND TARGET protobuf_headers_target AND ASCEND_PROTOBUF_SHARED_LIB)
    set_target_properties(ascend_protobuf_shared_lib PROPERTIES IMPORTED_LOCATION ${ASCEND_PROTOBUF_SHARED_LIB})
    set_target_properties(ascend_protobuf_shared_lib PROPERTIES IMPORTED_NO_SONAME TRUE)
    target_include_directories(ascend_protobuf INTERFACE ${PROTOBUF_INCLUDE_DIRS})
    target_link_libraries(ascend_protobuf INTERFACE ascend_protobuf_shared_lib)
    get_filename_component(PROTOBUF_SHARED_LIB_DIR "${ASCEND_PROTOBUF_SHARED_LIB}" DIRECTORY)
    get_filename_component(PROTOBUF_SHARED_PKG_DIR "${PROTOBUF_SHARED_LIB_DIR}" DIRECTORY)
    add_dependencies(ascend_protobuf protobuf_headers_target)
else()
    ExternalProject_Add(protobuf_shared_build
        DEPENDS protobuf_src SOURCE_DIR ${PROTOBUF_SRC_DIR} DOWNLOAD_COMMAND "" UPDATE_COMMAND ""
        CONFIGURE_COMMAND ${CMAKE_COMMAND} -G ${CMAKE_GENERATOR} -DTOOLCHAIN_DIR=${TOOLCHAIN_DIR} -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE} -DCMAKE_C_COMPILER_LAUNCHER=${CMAKE_C_COMPILER_LAUNCHER} -DCMAKE_CXX_COMPILER_LAUNCHER=${CMAKE_CXX_COMPILER_LAUNCHER} -DCMAKE_INSTALL_LIBDIR=lib -DBUILD_SHARED_LIBS=ON -DCMAKE_CXX_STANDARD=14 -Dprotobuf_WITH_ZLIB=OFF -DLIB_PREFIX=ascend_ -DCMAKE_SKIP_RPATH=TRUE -Dprotobuf_BUILD_TESTS=OFF -DCMAKE_CXX_FLAGS=${HOST_PROTOBUF_SHARED_CXXFLAGS} -DCMAKE_INSTALL_PREFIX=${PROTOBUF_SHARED_PKG_DIR} -Dprotobuf_BUILD_PROTOC_BINARIES=OFF <SOURCE_DIR>
        BUILD_COMMAND $(MAKE) INSTALL_COMMAND $(MAKE) install EXCLUDE_FROM_ALL TRUE
    )
    set_target_properties(ascend_protobuf_shared_lib PROPERTIES IMPORTED_LOCATION ${PROTOBUF_SHARED_PKG_DIR}/lib/libascend_protobuf.so)
    target_include_directories(ascend_protobuf INTERFACE ${PROTOBUF_SHARED_PKG_DIR}/include)
    target_link_libraries(ascend_protobuf INTERFACE ascend_protobuf_shared_lib)
    add_dependencies(ascend_protobuf protobuf_shared_build)
    set(PROTOBUF_SHARED_LIB_DIR "${PROTOBUF_SHARED_PKG_DIR}/lib")
endif()

# ---------------------------------------------------------
# Target: protobuf_static (Host Static)
# ---------------------------------------------------------
add_library(host_protobuf_static_lib STATIC IMPORTED)
add_library(protobuf_static INTERFACE)

if (HOST_PROTOBUF_STATIC_LIB AND EXISTS "${PROTOBUF_INCLUDE_DIRS}")
    set_target_properties(host_protobuf_static_lib PROPERTIES IMPORTED_LOCATION ${HOST_PROTOBUF_STATIC_LIB})
    target_include_directories(protobuf_static INTERFACE ${PROTOBUF_INCLUDE_DIRS})
    target_link_libraries(protobuf_static INTERFACE host_protobuf_static_lib)
    set(PROTOBUF_HOST_STATIC_FINAL_PATH ${HOST_PROTOBUF_STATIC_LIB})
elseif(TARGET protobuf_headers_target AND HOST_PROTOBUF_STATIC_LIB)
    set_target_properties(host_protobuf_static_lib PROPERTIES IMPORTED_LOCATION ${HOST_PROTOBUF_STATIC_LIB})
    target_include_directories(protobuf_static INTERFACE ${PROTOBUF_INCLUDE_DIRS})
    target_link_libraries(protobuf_static INTERFACE host_protobuf_static_lib) 
    add_dependencies(protobuf_static protobuf_headers_target)
    set(PROTOBUF_HOST_STATIC_FINAL_PATH ${HOST_PROTOBUF_STATIC_LIB})
else()
    ExternalProject_Add(protobuf_host_static_build
        DEPENDS protobuf_src SOURCE_DIR ${PROTOBUF_SRC_DIR} DOWNLOAD_COMMAND "" UPDATE_COMMAND ""
        CONFIGURE_COMMAND ${CMAKE_COMMAND} -G ${CMAKE_GENERATOR} -DCMAKE_C_COMPILER_LAUNCHER=${CMAKE_C_COMPILER_LAUNCHER} -DCMAKE_CXX_COMPILER_LAUNCHER=${CMAKE_CXX_COMPILER_LAUNCHER} -DCMAKE_INSTALL_LIBDIR=lib -DBUILD_SHARED_LIBS=OFF -DCMAKE_CXX_STANDARD=14 -Dprotobuf_WITH_ZLIB=OFF -DLIB_PREFIX=host_ascend_ -DCMAKE_SKIP_RPATH=TRUE -Dprotobuf_BUILD_TESTS=OFF -DCMAKE_CXX_FLAGS=${HOST_PROTOBUF_STATIC_CXXFLAGS} -DCMAKE_INSTALL_PREFIX=${PROTOBUF_HOST_STATIC_PKG_DIR} -Dprotobuf_BUILD_PROTOC_BINARIES=OFF -DABSL_COMPILE_OBJ=TRUE <SOURCE_DIR>
        BUILD_COMMAND $(MAKE) INSTALL_COMMAND $(MAKE) install EXCLUDE_FROM_ALL TRUE
    )
    set_target_properties(host_protobuf_static_lib PROPERTIES IMPORTED_LOCATION ${PROTOBUF_HOST_STATIC_PKG_DIR}/lib/libhost_ascend_protobuf.a)
    target_include_directories(protobuf_static INTERFACE ${PROTOBUF_HOST_STATIC_PKG_DIR}/include)
    target_link_libraries(protobuf_static INTERFACE host_protobuf_static_lib)
    add_dependencies(protobuf_static protobuf_host_static_build)
    set(PROTOBUF_HOST_STATIC_FINAL_PATH ${PROTOBUF_HOST_STATIC_PKG_DIR}/lib/libhost_ascend_protobuf.a)
endif()

if(PRODUCT_SIDE STREQUAL "device")
get_filename_component(PROTOBUF_ABS_PATH "${PROTOBUF_STATIC_FINAL_PATH}" REALPATH)
install(FILES
    ${PROTOBUF_ABS_PATH}
    DESTINATION ${DEVICE_LIBRARY_PATH} COMPONENT npu-runtime
)
endif()
