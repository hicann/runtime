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

rtError_t Context::RDMASend(const uint32_t sqIndex, const uint32_t wqeIndex, Stream* const stm)
{
    UNUSED(sqIndex);
    UNUSED(wqeIndex);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t Context::RdmaDbSendToDev(
    const uint32_t dbIndex, const uint64_t dbInfo, Stream* const stm, const uint32_t taskSqe) const
{
    UNUSED(dbIndex);
    UNUSED(dbInfo);
    UNUSED(stm);
    UNUSED(taskSqe);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t Context::RdmaDbSend(const uint32_t dbIndex, const uint64_t dbInfo, Stream* const stm)
{
    UNUSED(dbIndex);
    UNUSED(dbInfo);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t Context::AllocCascadeCaptureStream(
    const Stream* const stm, Model* const captureModel, Stream** newCaptureStream)
{
    UNUSED(stm);
    UNUSED(captureModel);
    UNUSED(newCaptureStream);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t Context::ModelGetNodes(const Model* const mdl, uint32_t* const num)
{
    UNUSED(mdl);
    UNUSED(num);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t Context::ModelDebugDotPrint(const Model* const mdl)
{
    UNUSED(mdl);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t Context::ModelDebugJsonPrint(const Model* const mdl, const char* path, const uint32_t flags)
{
    UNUSED(mdl);
    UNUSED(path);
    UNUSED(flags);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t Context::StreamBeginTaskGrp(Stream* const stm)
{
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t Context::StreamEndTaskGrp(Stream* const stm, TaskGroup** const handle) const
{
    UNUSED(stm);
    UNUSED(handle);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t Context::StreamBeginTaskUpdate(Stream* const stm, TaskGroup* handle) const
{
    UNUSED(stm);
    UNUSED(handle);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t Context::StreamEndTaskUpdate(Stream* const stm) const
{
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

void Context::FreeCascadeCaptureStream(Stream* const cascadeCaptureStm) { UNUSED(cascadeCaptureStm); }

rtError_t Context::CreateNotify(Notify** notify, uint32_t flag)
{
    UNUSED(notify);
    UNUSED(flag);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t Context::GetNotifyAddress(Notify* const notify, uint64_t& addr, Stream* const stm)
{
    UNUSED(notify);
    UNUSED(addr);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

} // namespace runtime
} // namespace cce
