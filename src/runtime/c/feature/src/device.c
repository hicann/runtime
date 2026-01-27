/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "securec.h"
#include "common.h"
#include "context.h"
#include "mmpa_api.h"
#include "device.h"
#if defined(__cplusplus)
extern "C" {
#endif

typedef struct TagDevice {
    uint32_t deviceId;
} Device;

// device
uint32_t GetDeviceId(const Device* device)
{
    return device->deviceId;
}

Device* CreateDevice(const uint32_t devId)
{
    Device* dev = (Device*)mmMalloc(sizeof(Device));
    if (dev == NULL) {
        return NULL;
    }
    dev->deviceId = devId;
    return dev;
}

void FreeDevice(Device* device)
{
    mmFree(device);
    return;
}

#if defined(__cplusplus)
}
#endif
