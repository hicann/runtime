/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "xpu_context.hpp"
#include "binary_loader.hpp"
#include "stream_xpu.hpp"
#include "stream.hpp"
#include "xpu_aicpu_c.hpp"
#include "inner_thread_local.hpp"

namespace cce {
namespace runtime {
XpuContext::XpuContext(Device *const ctxDevice, const bool primaryCtx)
    : Context(ctxDevice, primaryCtx)
{
}

XpuContext::~XpuContext()
{
    RT_LOG(RT_LOG_EVENT, "~xpu context.");
    Runtime::Instance()->XpuDeviceRelease(Device_());
    device_ = nullptr;
}

rtError_t XpuContext::TearDown()
{
    std::unique_lock<std::mutex> taskLock(streamLock_);
    for (Stream * const tdStream : StreamList_()) {
        RT_LOG(RT_LOG_INFO, "Tear down stream abandon, stream_id=%d.", tdStream->Id_());
        (void)TearDownStream(tdStream);
    }
    taskLock.unlock();
    if (InnerThreadLocalContainer::GetCurCtx() == this) {
        InnerThreadLocalContainer::SetCurCtx(nullptr);
    }
    return RT_ERROR_NONE;
}

rtError_t XpuContext::TearDownStream(Stream *stm, bool flag) const
{
    const rtError_t error = stm->TearDown(false, flag);
    if (unlikely(error != RT_ERROR_NONE)) {
        RT_LOG(RT_LOG_ERROR, "Xpu stream teardown failed, retCode=%#x.", error);
    }
    DeleteStream(stm);
    return error;
}

rtError_t XpuContext::Setup()
{
    SetCtxMode(STOP_ON_FAILURE);
    return RT_ERROR_NONE;
}

rtError_t XpuContext::StreamCreate(
    const uint32_t prio, const uint32_t flag, Stream **const result, DvppGrp *grp, const bool isSoftWareSqEnable)
{
    UNUSED(grp);
    UNUSED(isSoftWareSqEnable);

    rtError_t error = RT_ERROR_NONE;
    if (prio != RT_STREAM_PRIORITY_DEFAULT) {
        error = RT_ERROR_INVALID_VALUE;
        RT_LOG(RT_LOG_ERROR, "Stream create failed, priority is not support, priority=%u.", prio);
        return error;
    }

    if (!(flag == RT_STREAM_DEFAULT) && !((flag & RT_STREAM_FAST_LAUNCH) != 0U)) {
        error = RT_ERROR_INVALID_VALUE;
        RT_LOG(RT_LOG_ERROR, "Stream create failed, stream flag is not support, flag=%u.", flag);
        return error;
    }

    Stream *newStream = new (std::nothrow) XpuStream(Device_(), flag);
    if (newStream == nullptr) {
        error = RT_ERROR_STREAM_NEW;
        RT_LOG(RT_LOG_ERROR, "Stream create failed, stream is nullptr.");
        return error;
    }

    error = newStream->Setup();
    if (error != RT_ERROR_NONE) {
        DeleteStream(newStream);
        RT_LOG(RT_LOG_ERROR, "Setup stream failed, retCode=%#x.", error);
        return error;
    }

    newStream->SetContext(this);
    InsertStreamList(newStream);
    *result = newStream;
    return RT_ERROR_NONE;
}

rtError_t XpuContext::CheckStatus(const Stream *const stm, const bool isBlockDefault)
{
    (void)isBlockDefault;
    (void)stm;
    rtError_t status = GetFailureError();
    return status;
}
}  // namespace runtime
}  // namespace cce
