# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
cmake_minimum_required(VERSION 3.14)
project(adump)

# set adump root path
get_filename_component(ADUMP_DIR "${CMAKE_CURRENT_SOURCE_DIR}" ABSOLUTE)
set(ADUMP_DEPENDENCE_INC "${ADUMP_DIR}/inc")
# set top path of runtime
get_filename_component(PROJECT_TOP_DIR "${ADUMP_DIR}/../../../" ABSOLUTE)

add_subdirectory(adcore)
add_subdirectory(adump)
install_package(
    PACKAGE adump
    TARGETS adcore adump_server adump_headers ascend_dump
    FILES   ${PROJECT_TOP_DIR}/pkg_inc/dump/adx_datadump_server.h
            ${PROJECT_TOP_DIR}/pkg_inc/dump/adump_api.h
            ${PROJECT_TOP_DIR}/pkg_inc/dump/adump_pub.h
            ${PROJECT_TOP_DIR}/pkg_inc/dump/adump_device_pub.h
    DESTINATION ${INSTALL_INCLUDE_DIR}/adump/external
)
