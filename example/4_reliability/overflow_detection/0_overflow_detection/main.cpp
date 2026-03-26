/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstdint>
#include "acl/acl.h"
#include "utils.h"

int main()
{
    const int32_t deviceId = 0; aclrtContext context = nullptr; aclrtStream stream = nullptr; uint32_t *statusDevice = nullptr; uint32_t statusHost = 0; uint32_t queriedSwitch = 0;
    CHECK_ERROR(aclInit(nullptr)); CHECK_ERROR(aclrtSetDevice(deviceId)); CHECK_ERROR(aclrtCreateContext(&context, deviceId)); CHECK_ERROR(aclrtCreateStream(&stream));
    CHECK_ERROR(aclrtSetStreamOverflowSwitch(stream, 1)); CHECK_ERROR(aclrtGetStreamOverflowSwitch(stream, &queriedSwitch)); INFO_LOG("Overflow switch=%u", queriedSwitch);
    CHECK_ERROR(aclrtMalloc(reinterpret_cast<void **>(&statusDevice), sizeof(statusHost), ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtGetOverflowStatus(statusDevice, sizeof(statusHost), stream)); CHECK_ERROR(aclrtSynchronizeStream(stream)); CHECK_ERROR(aclrtMemcpy(&statusHost, sizeof(statusHost), statusDevice, sizeof(statusHost), ACL_MEMCPY_DEVICE_TO_HOST)); INFO_LOG("Overflow status before reset=%u", statusHost);
    CHECK_ERROR(aclrtResetOverflowStatus(stream)); CHECK_ERROR(aclrtSynchronizeStream(stream)); CHECK_ERROR(aclrtGetOverflowStatus(statusDevice, sizeof(statusHost), stream)); CHECK_ERROR(aclrtSynchronizeStream(stream)); CHECK_ERROR(aclrtMemcpy(&statusHost, sizeof(statusHost), statusDevice, sizeof(statusHost), ACL_MEMCPY_DEVICE_TO_HOST)); INFO_LOG("Overflow status after reset=%u", statusHost);
    CHECK_ERROR(aclrtFree(statusDevice)); CHECK_ERROR(aclrtDestroyStream(stream)); CHECK_ERROR(aclrtDestroyContext(context)); CHECK_ERROR(aclrtResetDeviceForce(deviceId)); CHECK_ERROR(aclFinalize()); return 0;
}