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

# MODEXT_LOG_BUILD 由 modext CMakeLists 设置，标识当前为模块扩展构建上下文。
if (MODEXT_LOG_BUILD)
    set(logserver_type "device_ext")
endif ()

# Build configuration based on logserver_type
if(logserver_type STREQUAL "host")
    add_subdirectory(log_host)
elseif(logserver_type STREQUAL "device")
    add_subdirectory(log_device)
endif ()
