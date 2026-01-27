# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

if(POLICY CMP0135)
    cmake_policy(SET CMP0135 NEW)
endif()

set(seccomp_download_dependent FALSE)
if (IS_DIRECTORY "${OPEN_SOURCE_DIR}/../tools/minios/arm64/include/libseccomp")
  message("seccomp use tools cache.")
  set(LIB_SECCOMP_INCLUDE_PATH "${OPEN_SOURCE_DIR}/../tools/minios/arm64/include/libseccomp")
elseif (EXISTS "${OPEN_SOURCE_DIR}/lib_cache/libseccomp-2.5.4/include/seccomp.h")
  message("seccomp use opensource cache.")
  set(LIB_SECCOMP_INCLUDE_PATH "${OPEN_SOURCE_DIR}/lib_cache/libseccomp-2.5.4/include")
else()
  if (NOT EXISTS "${OPEN_SOURCE_DIR}/libseccomp-2.5.4/")
    message("seccomp not use cache in ${OPEN_SOURCE_DIR}, download seccomp.")
    set(REQ_URL "https://gitcode.com/cann-src-third-party/libseccomp/releases/download/v2.5.4/libseccomp-2.5.4.tar.gz")
  else ()
    message("seccomp use cache.")
    set(REQ_URL "${OPEN_SOURCE_DIR}/libseccomp-2.5.4/")
  endif ()
  include(ExternalProject)
  ExternalProject_Add(external_seccomp
    URL               ${REQ_URL}
    DOWNLOAD_DIR      download/seccomp
    PREFIX            third_party
    TLS_VERIFY OFF
    CONFIGURE_COMMAND cd <SOURCE_DIR> && ./autogen.sh && ./configure --prefix=<INSTALL_DIR>
    INSTALL_COMMAND   ""
    BUILD_COMMAND     ""
  )

  ExternalProject_Get_Property(external_seccomp SOURCE_DIR)
  set(LIB_SECCOMP_INCLUDE_PATH ${SOURCE_DIR}/include)
  set(seccomp_download_dependent TRUE)
endif()

add_library(seccomp_headers INTERFACE)
set_target_properties(seccomp_headers PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES "${LIB_SECCOMP_INCLUDE_PATH}"
)
if (seccomp_download_dependent)
  add_dependencies(seccomp_headers external_seccomp)
endif()