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

namespace {
constexpr int32_t kDeviceId = 0;

class ContextGuard {
public:
    explicit ContextGuard(aclrtContext context) : context_(context) {}

    ~ContextGuard()
    {
        if (context_ != nullptr) {
            CHECK_ERROR_WITHOUT_RETURN(aclrtDestroyContext(context_));
        }
    }

    ContextGuard(const ContextGuard&) = delete;
    ContextGuard& operator=(const ContextGuard&) = delete;

    aclError Destroy()
    {
        if (context_ == nullptr) {
            return ACL_SUCCESS;
        }

        aclError ret = aclrtDestroyContext(context_);
        if (ret == ACL_SUCCESS) {
            context_ = nullptr;
        }
        return ret;
    }

private:
    aclrtContext context_;
};

int32_t RunContextQuerySample()
{
    aclrtContext context = nullptr;
    aclrtStream defaultStream = nullptr;
    uint32_t cubeCoreLimit = 0;
    uint32_t vectorCoreLimit = 0;

    CHECK_ERROR(aclrtCreateContext(&context, kDeviceId));
    ContextGuard contextGuard(context);
    CHECK_ERROR(aclrtSetCurrentContext(context));

    aclrtContext currentContext = nullptr;
    CHECK_ERROR(aclrtGetCurrentContext(&currentContext));
    if (currentContext != context) {
        ERROR_LOG("Current context is different from the created context.");
        return -1;
    }
    INFO_LOG("Get current context successfully");

    CHECK_ERROR(aclrtCtxGetCurrentDefaultStream(&defaultStream));
    INFO_LOG("Get current default stream successfully, stream=%p", defaultStream);

    CHECK_ERROR(aclrtGetResInCurrentThread(ACL_RT_DEV_RES_CUBE_CORE, &cubeCoreLimit));
    INFO_LOG("Get current thread cube core limit: %u", cubeCoreLimit);

    CHECK_ERROR(aclrtGetResInCurrentThread(ACL_RT_DEV_RES_VECTOR_CORE, &vectorCoreLimit));
    INFO_LOG("Get current thread vector core limit: %u", vectorCoreLimit);

    CHECK_ERROR(contextGuard.Destroy());
    INFO_LOG("[SUCCESS] Context query sample completed successfully");
    return 0;
}
} // namespace

int32_t main()
{
    CHECK_ERROR(aclInit(nullptr));
    CHECK_ERROR(aclrtSetDevice(kDeviceId));

    int32_t ret = RunContextQuerySample();

    CHECK_ERROR(aclrtResetDeviceForce(kDeviceId));
    CHECK_ERROR(aclFinalize());
    return ret;
}
