# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(logserver_type "device")

if(${PRODUCT_SIDE} STREQUAL "host")
    set(logserver_type "host")
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
    (${PRODUCT} STREQUAL "mc62cm12aesl"))
    set(logserver_type "device_mdc")
endif ()
endif ()
### INTERNAL END ###

# Build configuration based on logserver_type
if(logserver_type STREQUAL "host")
    add_subdirectory(log_host)
elseif(logserver_type STREQUAL "device")
    add_subdirectory(log_device)
endif ()

### INTERNAL START ###
# Build MDC configuration based on logserver_type
if(logserver_type STREQUAL "device_mdc")
    add_subdirectory(log_device_mdc)
endif ()
### INTERNAL END ###
