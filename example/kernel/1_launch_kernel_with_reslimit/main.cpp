/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

/*
 * This sample demonstrates how users can run kernels under resource limits.
 */

#include <cstdio>
#include "acl/acl.h"
#include "utils.h"


extern void PrintDo(uint32_t blockDim, void *stream);

int32_t GetReslimit(int32_t deviceId, void *stream) {
    aclrtDevResLimitType type = ACL_RT_DEV_RES_CUBE_CORE;
    uint32_t coreDim = 0;

    // Retrieve the device resource limits 
    CHECK_ERROR(aclrtGetDeviceResLimit(deviceId, type, &coreDim));
    PrintDo(coreDim, stream);
}

int32_t main(int32_t argc, char *argv[])
{
    CHECK_ERROR(aclInit(nullptr));
    int32_t deviceId = 0;
    CHECK_ERROR(aclrtSetDevice(deviceId));
    aclrtStream stream = nullptr;
    CHECK_ERROR(aclrtCreateStream(&stream));

    aclrtDevResLimitType type = ACL_RT_DEV_RES_CUBE_CORE;
    uint32_t blockDim = 8;
    CHECK_ERROR(aclrtSetDeviceResLimit(deviceId, type, blockDim));

    // Set the device resource limits for the current process
    GetReslimit(deviceId, stream);

    // Release runtime resources
    CHECK_ERROR(aclrtDestroyStreamForce(stream));
    CHECK_ERROR(aclrtResetDeviceForce(deviceId));
    CHECK_ERROR(aclFinalize());
    return 0;
}
