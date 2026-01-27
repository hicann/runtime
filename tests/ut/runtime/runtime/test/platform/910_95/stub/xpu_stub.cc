/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "xpu_stub.h"

using namespace cce::runtime;

drvError_t drvGetPlatformInfo_online(uint32_t *info)
{
    *info = RT_RUN_MODE_ONLINE;
    return DRV_ERROR_NONE;
}

rtError_t ParseXpuConfigInfo_mock(XpuDevice *This)
{
    This->configInfo_.version = 1.0;
    This->configInfo_.maxStreamNum = 64;
    This->configInfo_.maxStreamDepth = 1024;
    This->configInfo_.timeoutMonitorGranularity = 1000;
    This->configInfo_.defaultTaskExeTimeout = 30000;
    return RT_ERROR_NONE;
}

drvError_t drvGetPlatformInfo_offline(uint32_t *info)
{
    *info = RT_RUN_MODE_OFFLINE;
    return DRV_ERROR_NONE;
}