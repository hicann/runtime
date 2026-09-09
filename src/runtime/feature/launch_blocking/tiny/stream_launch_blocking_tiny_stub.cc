/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "stream_launch_blocking.hpp"

namespace cce {
namespace runtime {

void StreamLaunchBlocking::ReleaseLaunchBlockingState(Stream* const stm) { UNUSED(stm); }

rtError_t StreamLaunchBlocking::SetLaunchBlockingMode(Stream* const stm, const uint32_t mode)
{
    UNUSED(stm);
    UNUSED(mode);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t StreamLaunchBlocking::GetLaunchBlockingMode(const Stream* const stm, uint32_t* const mode)
{
    UNUSED(stm);
    UNUSED(mode);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t StreamLaunchBlocking::NonBlockingLaunchBegin(Stream* const stream)
{
    UNUSED(stream);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t StreamLaunchBlocking::NonBlockingLaunchEnd(Stream* const stream)
{
    UNUSED(stream);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

bool StreamLaunchBlocking::IsNonBlockingLaunchActive(const Stream* const stm)
{
    UNUSED(stm);
    return false;
}

bool StreamLaunchBlocking::ShouldLaunchBlock(const Stream* const stm)
{
    UNUSED(stm);
    return false;
}

} // namespace runtime
} // namespace cce
