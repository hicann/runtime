/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef RUNTIME_C_FEATURE_DEVICE_H
#define RUNTIME_C_FEATURE_DEVICE_H
#include "common.h"
#if defined(__cplusplus)
extern "C" {
#endif
uint32_t GetDeviceId(const Device* device);
Context* GetDeviceDefaultContext(const Device* device);
Device* CreateDevice(const uint32_t devId);
void FreeDevice(Device* device);

#if defined(__cplusplus)
}
#endif

#endif // RUNTIME_C_FEATURE_BASE_H