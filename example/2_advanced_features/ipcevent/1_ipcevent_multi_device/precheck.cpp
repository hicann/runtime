/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstdlib>
#include "acl/acl.h"
#include "utils.h"

int main(int argc, char* argv[])
{
    if (argc != 2) {
        ERROR_LOG("Usage: %s <required_device_count>", argv[0]);
        return 1;
    }

    int requiredDeviceCount = atoi(argv[1]);
    if (requiredDeviceCount <= 0) {
        ERROR_LOG("Invalid required device count: %d", requiredDeviceCount);
        return 1;
    }

    CHECK_ERROR(aclInit(nullptr));
    uint32_t deviceCount = 0;
    aclError ret = aclrtGetDeviceCount(&deviceCount);
    aclFinalize();
    if (ret != ACL_SUCCESS) {
        ERROR_LOG("Operation failed: aclrtGetDeviceCount returned error code %d", static_cast<int32_t>(ret));
        return 1;
    }

    INFO_LOG("Available device count: %u, required device count: %d", deviceCount, requiredDeviceCount);
    if (deviceCount < static_cast<uint32_t>(requiredDeviceCount)) {
        INFO_LOG("[SKIP] Need at least %d devices, but only %u device(s) are available.", requiredDeviceCount,
                 deviceCount);
        return 2;
    }
    return 0;
}
