/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpu_context.h"
#include <unistd.h>

namespace aicpu {
status_t SetOpname(const std::string &opname)
{
    return AICPU_ERROR_NONE;
}

status_t SetThreadLocalCtx(const std::string &key, const std::string &value)
{
    return AICPU_ERROR_NONE;
}

status_t GetThreadLocalCtx(const std::string &key, std::string &value)
{
    return AICPU_ERROR_NONE;
}

status_t aicpuGetContext(aicpuContext_t *ctx)
{
    if (ctx != nullptr) {
        ctx->deviceId = 0;
        ctx->tsId = 0;
        ctx->vfId = 0;
        ctx->hostPid = getpid();
    }
    return AICPU_ERROR_NONE;
}

status_t GetAicpuRunMode(uint32_t &runMode)
{
    runMode = aicpu::THREAD_MODE;
    return AICPU_ERROR_NONE;
}

uint32_t GetUniqueVfId()
{
    return 0U;
}

void SetUniqueVfId(const uint32_t uniqueVfId)
{
    (void)uniqueVfId;
}

void SetCustAicpuSdFlag(const bool isCustAicpuSdFlag)
{
    (void)isCustAicpuSdFlag;
}

bool IsCustAicpuSd()
{
    return false;
}
}  // namespace aicpu