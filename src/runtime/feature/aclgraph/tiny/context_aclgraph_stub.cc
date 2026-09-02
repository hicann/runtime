/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "context.hpp"
namespace cce {
namespace runtime {

rtError_t Context::TryRecycleCaptureModelResource(
    const uint32_t allocSqNum, const uint32_t ntfCnt, const CaptureModel* const excludeMdl)
{
    UNUSED(allocSqNum);
    UNUSED(ntfCnt);
    UNUSED(excludeMdl);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t Context::TryRecycleCaptureModelJettyResource(const CaptureModel* const excludeMdl, JettyType type)
{
    UNUSED(excludeMdl);
    UNUSED(type);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

} // namespace runtime
} // namespace cce
