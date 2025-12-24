# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

add_library(slog_headers INTERFACE)
target_include_directories(slog_headers INTERFACE
    $<BUILD_INTERFACE:${TOOLAHCIN_LOG_DIR}/inc>
    $<BUILD_INTERFACE:${TOOLAHCIN_LOG_DIR}/inc/toolchain>
    $<BUILD_INTERFACE:${TOOLAHCIN_LOG_DIR}/../../../pkg_inc>
    $<BUILD_INTERFACE:${TOOLAHCIN_LOG_DIR}/../../../pkg_inc/base>
    $<INSTALL_INTERFACE:include>
    $<INSTALL_INTERFACE:include/slog>
    $<INSTALL_INTERFACE:include/slog/toolchain>
)

############################# [device] ########################################
if (${PRODUCT_SIDE} STREQUAL "device")

set(liblog_type "default")
if(PRODUCT)
if((${PRODUCT} STREQUAL "ascend610") OR (${PRODUCT} STREQUAL "ascend610Lite") OR (${PRODUCT} STREQUAL "ascend610Liteesl") OR (${PRODUCT} STREQUAL "as31xm1"))
    set(liblog_type "mdc")
endif()
endif()

if (${liblog_type} STREQUAL "mdc")
############################# [ascend610/ascend610Lite/ascend610Lite] #########
add_subdirectory(plog_device_mdc)
else ()
############################# ![ascend610/ascend610Lite/ascend610Lite] ########
add_subdirectory(plog_device)
endif ()

############################# [ host ] ########################################
elseif (${PRODUCT_SIDE} STREQUAL "host")
############################# [Windows] #######################################
if (${TARGET_SYSTEM_NAME} STREQUAL "Windows")
add_subdirectory(plog)
add_subdirectory(plog_host_win)
else ()
############################# [ linux ] #######################################
add_subdirectory(plog)
add_subdirectory(plog_host)
endif ()
endif ()
