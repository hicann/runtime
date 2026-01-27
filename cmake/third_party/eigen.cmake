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

if (IS_DIRECTORY "${OPEN_SOURCE_DIR}/eigen")
  message("eigen use cache.")
  set(REQ_URL "${OPEN_SOURCE_DIR}/eigen")
else()
  message("eigen not use cache.")
  set(REQ_URL "https://gitcode.com/cann-src-third-party/eigen/releases/download/3.4.0/eigen-3.4.0.tar.gz")
endif()

include(ExternalProject)
ExternalProject_Add(external_eigen
  URL               ${REQ_URL}
  DOWNLOAD_DIR      download/eigen
  PREFIX            third_party
  INSTALL_COMMAND   ""
  BUILD_COMMAND     ""
  INSTALL_COMMAND   ""
)

ExternalProject_Get_Property(external_eigen SOURCE_DIR)

add_library(Eigen INTERFACE)
target_compile_options(Eigen INTERFACE -w)

set_target_properties(Eigen PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES "${SOURCE_DIR}"
)
add_dependencies(Eigen external_eigen)

add_library(Eigen3::Eigen ALIAS Eigen)