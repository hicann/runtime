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

set(liblog_type "device")

if(${PRODUCT_SIDE} STREQUAL "host")
    set(liblog_type "host")
endif ()

### INTERNAL START ###
# Define supported MDC products to identify device_mdc type
if (PRODUCT)
if ((${PRODUCT} STREQUAL "ascend610") OR 
    (${PRODUCT} STREQUAL "ascend610Lite") OR 
    (${PRODUCT} STREQUAL "ascend610Liteesl") OR 
    (${PRODUCT} STREQUAL "as31xm1") OR 
    (${PRODUCT} STREQUAL "mc32dm11a") OR 
    (${PRODUCT} STREQUAL "mc32dm11aesl") OR 
    (${PRODUCT} STREQUAL "mc62cm12a") OR 
    (${PRODUCT} STREQUAL "mc62cm12aesl") OR
    (${PRODUCT} STREQUAL "pegasus"))
    set(liblog_type "device_mdc")
endif ()
endif ()
### INTERNAL END ###

# Build configuration based on liblog_type
if(liblog_type STREQUAL "host")
    add_subdirectory(plog)
    add_subdirectory(plog_host)
elseif(liblog_type STREQUAL "device")
    add_subdirectory(plog_device)
endif ()

### INTERNAL START ###
# MDC device build configuration based on liblog_type
if(liblog_type STREQUAL "device_mdc")
    add_subdirectory(plog_device_mdc)
endif ()
### INTERNAL END ###

