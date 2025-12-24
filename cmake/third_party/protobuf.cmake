# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

if (BUILD_WITH_INSTALLED_DEPENDENCY_CANN_PKG)
  if(POLICY CMP0135)
      cmake_policy(SET CMP0135 NEW)
  endif()

  include(ExternalProject)
  include(GNUInstallDirs)

  set(PROTOBUF_SRC_DIR ${CMAKE_BINARY_DIR}/protobuf-src)
  set(PROTOBUF_DL_DIR ${CMAKE_BINARY_DIR}/downloads)
  set(PROTOBUF_STATIC_PKG_DIR ${CMAKE_BINARY_DIR}/protobuf_static)
  set(PROTOBUF_SHARED_PKG_DIR ${CMAKE_BINARY_DIR}/protobuf_shared)
  set(PROTOBUF_HOST_STATIC_PKG_DIR ${CMAKE_BINARY_DIR}/protobuf_host_static)

  set(SECURITY_COMPILE_OPT "-Wl,-z,relro,-z,now,-z,noexecstack -s -Wl,-Bsymbolic")
  set(DEV_PROTOBUF_SHARED_CXXFLAGS "${SECURITY_COMPILE_OPT} -Wno-maybe-uninitialized -Wno-unused-parameter -fPIC -fstack-protector-all -D_FORTIFY_SOURCE=2 -D_GLIBCXX_USE_CXX11_ABI=1 -O2 -Dgoogle=ascend_private")
  set(HOST_PROTOBUF_SHARED_CXXFLAGS "${SECURITY_COMPILE_OPT} -Wno-maybe-uninitialized -Wno-unused-parameter -fPIC -fstack-protector-all -D_FORTIFY_SOURCE=2 -D_GLIBCXX_USE_CXX11_ABI=0 -O2 -Dgoogle=ascend_private")
  set(DEV_PROTOBUF_STATIC_CXXFLAGS "-fvisibility=hidden -fvisibility-inlines-hidden -Wno-maybe-uninitialized -Wno-unused-parameter -fPIC -fstack-protector-all -D_FORTIFY_SOURCE=2 -D_GLIBCXX_USE_CXX11_ABI=1 -O2 -Dgoogle=ascend_private")
  set(HOST_PROTOBUF_STATIC_CXXFLAGS "-fvisibility=hidden -fvisibility-inlines-hidden -Wno-maybe-uninitialized -Wno-unused-parameter -fPIC -fstack-protector-all -D_FORTIFY_SOURCE=2 -D_GLIBCXX_USE_CXX11_ABI=0 -O2 -Dgoogle=ascend_private")

  if (PRODUCT_SIDE STREQUAL "device")
    message(STATUS "Building for device side")
    set(HOST_PROTOBUF_SHARED_CXXFLAGS ${DEV_PROTOBUF_SHARED_CXXFLAGS})
    set(HOST_PROTOBUF_STATIC_CXXFLAGS ${DEV_PROTOBUF_STATIC_CXXFLAGS})
  endif()

  include(${CMAKE_CURRENT_LIST_DIR}/protobuf_sym_rename.cmake)
  set(HOST_PROTOBUF_SHARED_CXXFLAGS "${HOST_PROTOBUF_SHARED_CXXFLAGS} ${PROTOBUF_SYM_RENAME}")
  set(HOST_PROTOBUF_STATIC_CXXFLAGS "${HOST_PROTOBUF_STATIC_CXXFLAGS} ${PROTOBUF_SYM_RENAME}")
  message(STATUS "HOST_PROTOBUF_SHARED_CXXFLAGS is ${HOST_PROTOBUF_SHARED_CXXFLAGS}")
  message(STATUS "HOST_PROTOBUF_STATIC_CXXFLAGS is ${HOST_PROTOBUF_STATIC_CXXFLAGS}")

  # 使用设备端工具链生成 ascend_protobuf_static
  set(CMAKE_CXX_COMPILER_ ${TOOLCHAIN_DIR}/bin/aarch64-target-linux-gnu-g++)
  set(CMAKE_C_COMPILER_ ${TOOLCHAIN_DIR}/bin/aarch64-target-linux-gnu-gcc)
  set(SOURCE_DIR ${PROTOBUF_SRC_DIR})

  if (EXISTS ${OPEN_SOURCE_DIR}/protobuf/protobuf-all-25.1.tar.gz)
    set(PROTOBUF_PATH ${OPEN_SOURCE_DIR}/protobuf/protobuf-all-25.1.tar.gz)
  else ()
    set(PROTOBUF_PATH ${OPEN_SOURCE_DIR}/protobuf/protobuf-25.1.tar.gz)
  endif ()

  set(ABSEIL_PATH ${OPEN_SOURCE_DIR}/abseil-cpp/abseil-cpp-20230802.1.tar.gz)
  if (NOT EXISTS "${ABSEIL_PATH}")
    message(STATUS "protobuf-all-25.1.tar.gz not exists or abseil-cpp-20230802.1.tar.gz not exists")
    set(REQ_URL "https://gitcode.com/cann-src-third-party/protobuf/releases/download/v25.1/protobuf-25.1.tar.gz")
    set(ABS_REQ_URL "https://gitcode.com/cann-src-third-party/abseil-cpp/releases/download/20230802.1/abseil-cpp-20230802.1.tar.gz")
    message("protobuf not use cache.")
    ExternalProject_Add(protobuf_src_dl
      URL               ${REQ_URL}
      DOWNLOAD_DIR      ${PROTOBUF_DL_DIR}/
      TLS_VERIFY OFF
      DOWNLOAD_NO_EXTRACT 1
      CONFIGURE_COMMAND ""
      BUILD_COMMAND ""
      INSTALL_COMMAND ""
    )

    ExternalProject_Add(abseil_src_dl
      URL               ${ABS_REQ_URL}
      DOWNLOAD_DIR      ${PROTOBUF_DL_DIR}/abseil-cpp/
      TLS_VERIFY OFF
      DOWNLOAD_NO_EXTRACT 1
      CONFIGURE_COMMAND ""
      BUILD_COMMAND ""
      INSTALL_COMMAND ""
    )

  message(STATUS "TOP_DIR = ${RUNTIME_DIR}")
    # 下载/解压 protobuf 源码
    ExternalProject_Add(protobuf_src
      DOWNLOAD_COMMAND ""
      COMMAND tar -zxf ${PROTOBUF_DL_DIR}/protobuf-25.1.tar.gz --strip-components 1 -C ${SOURCE_DIR}
      COMMAND tar -zxf ${PROTOBUF_DL_DIR}/abseil-cpp/abseil-cpp-20230802.1.tar.gz --strip-components 1 -C ${SOURCE_DIR}/third_party/abseil-cpp
      PATCH_COMMAND cd ${SOURCE_DIR} && patch -p1 < ${RUNTIME_DIR}/cmake/third_party/protobuf_25.1_change_version.patch && cd ${SOURCE_DIR}/third_party/abseil-cpp && patch -p1 < ${RUNTIME_DIR}/cmake/third_party/protobuf-hide_absl_symbols.patch
      CONFIGURE_COMMAND ""
      BUILD_COMMAND ""
      INSTALL_COMMAND ""
    )
    

    add_dependencies(protobuf_src protobuf_src_dl abseil_src_dl)
  else()
    message("protobuf use cache, cache path: ${PROTOBUF_PATH}.")
    ExternalProject_Add(protobuf_src
        DOWNLOAD_COMMAND ""
        COMMAND tar -zxf ${PROTOBUF_PATH} --strip-components 1 -C ${SOURCE_DIR}
        COMMAND tar -zxf ${ABSEIL_PATH} --strip-components 1 -C ${SOURCE_DIR}/third_party/abseil-cpp
        PATCH_COMMAND cd ${SOURCE_DIR} && patch -p1 < ${RUNTIME_DIR}/cmake/third_party/protobuf_25.1_change_version.patch && cd ${SOURCE_DIR}/third_party/abseil-cpp && patch -p1 < ${RUNTIME_DIR}/cmake/third_party/protobuf-hide_absl_symbols.patch
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND ""
    )
  endif()

  ExternalProject_Add(protobuf_static_build
    DEPENDS protobuf_src
    SOURCE_DIR ${PROTOBUF_SRC_DIR}
    DOWNLOAD_COMMAND ""
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${CMAKE_COMMAND}
        -G ${CMAKE_GENERATOR}
        -DCMAKE_C_COMPILER_LAUNCHER=${CMAKE_C_COMPILER_LAUNCHER}
        -DCMAKE_CXX_COMPILER_LAUNCHER=${CMAKE_CXX_COMPILER_LAUNCHER}
        -DTOOLCHAIN_DIR=${TOOLCHAIN_DIR}
        -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
        -DCMAKE_INSTALL_LIBDIR=lib
        -DBUILD_SHARED_LIBS=OFF
        -Dprotobuf_WITH_ZLIB=OFF
        -DLIB_PREFIX=ascend_
        -DCMAKE_SKIP_RPATH=TRUE
        -Dprotobuf_BUILD_TESTS=OFF
        -DCMAKE_CXX_FLAGS=${HOST_PROTOBUF_STATIC_CXXFLAGS}
        -DCMAKE_INSTALL_PREFIX=${PROTOBUF_STATIC_PKG_DIR}
        -Dprotobuf_BUILD_PROTOC_BINARIES=OFF
        -DABSL_COMPILE_OBJ=TRUE
        <SOURCE_DIR>
    BUILD_COMMAND $(MAKE)
    INSTALL_COMMAND $(MAKE) install
    EXCLUDE_FROM_ALL TRUE
  )

  ExternalProject_Add(protobuf_shared_build
    DEPENDS protobuf_src
    SOURCE_DIR ${PROTOBUF_SRC_DIR}
    DOWNLOAD_COMMAND ""
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${CMAKE_COMMAND}
        -G ${CMAKE_GENERATOR}
        -DTOOLCHAIN_DIR=${TOOLCHAIN_DIR}
        -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
        -DCMAKE_C_COMPILER_LAUNCHER=${CMAKE_C_COMPILER_LAUNCHER}
        -DCMAKE_CXX_COMPILER_LAUNCHER=${CMAKE_CXX_COMPILER_LAUNCHER}
        -DCMAKE_INSTALL_LIBDIR=lib
        -DBUILD_SHARED_LIBS=ON
        -Dprotobuf_WITH_ZLIB=OFF
        -DLIB_PREFIX=ascend_
        -DCMAKE_SKIP_RPATH=TRUE
        -Dprotobuf_BUILD_TESTS=OFF
        -DCMAKE_CXX_FLAGS=${HOST_PROTOBUF_SHARED_CXXFLAGS}
        -DCMAKE_INSTALL_PREFIX=${PROTOBUF_SHARED_PKG_DIR}
        -Dprotobuf_BUILD_PROTOC_BINARIES=OFF
        <SOURCE_DIR>
    BUILD_COMMAND $(MAKE)
    INSTALL_COMMAND $(MAKE) install
    EXCLUDE_FROM_ALL TRUE
  )

  ExternalProject_Add(protobuf_host_static_build
    DEPENDS protobuf_src
    SOURCE_DIR ${PROTOBUF_SRC_DIR}
    DOWNLOAD_COMMAND ""
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${CMAKE_COMMAND}
        -G ${CMAKE_GENERATOR}
        -DCMAKE_C_COMPILER_LAUNCHER=${CMAKE_C_COMPILER_LAUNCHER}
        -DCMAKE_CXX_COMPILER_LAUNCHER=${CMAKE_CXX_COMPILER_LAUNCHER}
        -DCMAKE_INSTALL_LIBDIR=lib
        -DBUILD_SHARED_LIBS=OFF
        -Dprotobuf_WITH_ZLIB=OFF
        -DLIB_PREFIX=host_ascend_
        -DCMAKE_SKIP_RPATH=TRUE
        -Dprotobuf_BUILD_TESTS=OFF
        -DCMAKE_CXX_FLAGS=${HOST_PROTOBUF_STATIC_CXXFLAGS}
        -DCMAKE_INSTALL_PREFIX=${PROTOBUF_HOST_STATIC_PKG_DIR}
        -Dprotobuf_BUILD_PROTOC_BINARIES=OFF
        -DABSL_COMPILE_OBJ=TRUE
        <SOURCE_DIR>
    BUILD_COMMAND $(MAKE)
    INSTALL_COMMAND $(MAKE) install
    EXCLUDE_FROM_ALL TRUE
  )

  set(PROTOBUF_HOST_DIR ${CMAKE_BINARY_DIR}/protobuf_host)
  ExternalProject_Add(protobuf_host_build
      DEPENDS protobuf_src
      SOURCE_DIR ${PROTOBUF_SRC_DIR}
      DOWNLOAD_COMMAND ""
      UPDATE_COMMAND ""
      CONFIGURE_COMMAND ${CMAKE_COMMAND}
          -DCMAKE_C_COMPILER_LAUNCHER=${CMAKE_C_COMPILER_LAUNCHER}
          -DCMAKE_CXX_COMPILER_LAUNCHER=${CMAKE_CXX_COMPILER_LAUNCHER}
          -DCMAKE_INSTALL_PREFIX=${PROTOBUF_HOST_DIR}
          -Dprotobuf_BUILD_TESTS=OFF
          -Dprotobuf_WITH_ZLIB=OFF
          <SOURCE_DIR>
      BUILD_COMMAND $(MAKE)
      INSTALL_COMMAND $(MAKE) install
      EXCLUDE_FROM_ALL TRUE
  )

  add_executable(host_protoc IMPORTED)
  set_target_properties(host_protoc PROPERTIES
      IMPORTED_LOCATION ${PROTOBUF_HOST_DIR}/bin/protoc
  )
  add_dependencies(host_protoc protobuf_host_build)

  # if (BUILD_WITH_INSTALLED_DEPENDENCY_CANN_PKG_COMMUNITY)
  #   ExternalProject_Add(protobuf_static_build
  #     DEPENDS protobuf_src
  #     SOURCE_DIR ${PROTOBUF_SRC_DIR}
  #     DOWNLOAD_COMMAND ""
  #     UPDATE_COMMAND ""
  #     CONFIGURE_COMMAND ${CMAKE_COMMAND}
  #         -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER_}
  #         -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER_}
  #         -DCMAKE_INSTALL_PREFIX=${PROTOBUF_STATIC_PKG_DIR}
  #         -DCMAKE_INSTALL_LIBDIR=lib
  #         -DCMAKE_INSTALL_CMAKEDIR=cmake/protobuf
  #         -Dprotobuf_BUILD_TESTS=OFF
  #         -Dprotobuf_WITH_ZLIB=OFF
  #         -DLIB_PREFIX=ascend_
  #         -DCMAKE_CXX_FLAGS=${PROTOBUF_CXXFLAGS}
  #         -DCMAKE_EXE_LINKER_FLAGS=${PROTOBUF_LDFLAGS}
  #         -DCMAKE_SHARED_LINKER_FLAGS=${PROTOBUF_LDFLAGS}
  #         <SOURCE_DIR>/cmake
  #     BUILD_COMMAND $(MAKE)
  #     INSTALL_COMMAND $(MAKE) install
  #     EXCLUDE_FROM_ALL TRUE
  #   )

  #   ExternalProject_Add(protobuf_host_static_build
  #     DEPENDS protobuf_src
  #     SOURCE_DIR ${PROTOBUF_SRC_DIR}
  #     DOWNLOAD_COMMAND ""
  #     UPDATE_COMMAND ""
  #     CONFIGURE_COMMAND ${CMAKE_COMMAND}
  #         -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
  #         -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
  #         -DCMAKE_INSTALL_PREFIX=${PROTOBUF_HOST_STATIC_PKG_DIR}
  #         -DCMAKE_INSTALL_LIBDIR=lib
  #         -DCMAKE_INSTALL_CMAKEDIR=cmake/protobuf
  #         -Dprotobuf_BUILD_TESTS=OFF
  #         -Dprotobuf_WITH_ZLIB=OFF
  #         -DLIB_PREFIX=host_ascend_
  #         -DCMAKE_CXX_FLAGS=${HOST_PROTOBUF_CXXFLAGS}
  #         -DCMAKE_EXE_LINKER_FLAGS=${PROTOBUF_LDFLAGS}
  #         -DCMAKE_SHARED_LINKER_FLAGS=${PROTOBUF_LDFLAGS}
  #         <SOURCE_DIR>/cmake
  #     BUILD_COMMAND $(MAKE)
  #     INSTALL_COMMAND $(MAKE) install
  #     EXCLUDE_FROM_ALL TRUE
  #   )
  # endif()

  add_library(ascend_protobuf_static_lib STATIC IMPORTED)
  set_target_properties(ascend_protobuf_static_lib PROPERTIES
      IMPORTED_LOCATION ${PROTOBUF_STATIC_PKG_DIR}/lib/libascend_protobuf.a
  )

  add_library(ascend_protobuf_static INTERFACE)
  target_include_directories(ascend_protobuf_static INTERFACE ${PROTOBUF_STATIC_PKG_DIR}/include)
  target_link_libraries(ascend_protobuf_static INTERFACE ascend_protobuf_static_lib)
  add_dependencies(ascend_protobuf_static protobuf_static_build)

  add_library(ascend_protobuf_shared_lib SHARED IMPORTED)
  set_target_properties(ascend_protobuf_shared_lib PROPERTIES
      IMPORTED_LOCATION ${PROTOBUF_SHARED_PKG_DIR}/lib/libascend_protobuf.so
  )

  add_library(ascend_protobuf INTERFACE)
  target_include_directories(ascend_protobuf INTERFACE ${PROTOBUF_SHARED_PKG_DIR}/include)
  target_link_libraries(ascend_protobuf INTERFACE ascend_protobuf_shared_lib)
  add_dependencies(ascend_protobuf protobuf_shared_build)

  add_library(host_protobuf_static_lib STATIC IMPORTED)
  set_target_properties(host_protobuf_static_lib PROPERTIES
      IMPORTED_LOCATION ${PROTOBUF_HOST_STATIC_PKG_DIR}/lib/libhost_ascend_protobuf.a
  )

  add_library(protobuf_static INTERFACE)
  target_include_directories(protobuf_static INTERFACE ${PROTOBUF_HOST_STATIC_PKG_DIR}/include)
  target_link_libraries(protobuf_static INTERFACE host_protobuf_static_lib)
  add_dependencies(protobuf_static protobuf_host_static_build)
endif()
