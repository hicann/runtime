/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ide_dsmi_stub.h"

static const uint32_t LOCAL_DEV_NUM = 8;

rtError_t rtGetRunModeHost(rtRunMode *info) {
	*info = (rtRunMode)1;
    return RT_ERROR_NONE;
}

rtError_t rtGetRunModeDevice(rtRunMode *info) {
	*info = (rtRunMode)0;
    return RT_ERROR_NONE;
}

rtError_t rtGetDeviceCount(int32_t *cnt)
{
    *cnt = LOCAL_DEV_NUM;
    return RT_ERROR_NONE;
}

rtError_t rtGetDeviceIDs(uint32_t *devices, uint32_t len)
{
    for (size_t i = 0; i < len; ++i) {
        devices[i] = i;
    }

    return RT_ERROR_NONE;
}

rtError_t rtGetDeviceStatus(const int32_t devId, rtDevStatus_t * const status)
{
    return RT_ERROR_NONE;
}

rtError_t rtGetDeviceInfo(uint32_t deviceId, int32_t moduleType, int32_t infoType, int64_t *val)
{
    return RT_ERROR_NONE;
}

rtError_t rtGetRunMode(rtRunMode *runMode)
{
	*runMode = RT_RUN_MODE_OFFLINE;
    return RT_ERROR_NONE;
}