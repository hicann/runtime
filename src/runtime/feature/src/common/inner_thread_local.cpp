/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "inner_thread_local.hpp"

namespace cce {
namespace runtime {
__THREAD_LOCAL__ uint32_t InnerThreadLocalContainer::lastTaskId_ = 0xFFFFFFFFU; /* 0xFFFFFFFF is UINT32_MAX */
__THREAD_LOCAL__ uint32_t InnerThreadLocalContainer::lastStreamId_ = 0xFFFFU; /* 0xFFFF is UINT16_MAX */
__THREAD_LOCAL__ uint32_t InnerThreadLocalContainer::tsId_ = 0U;
__THREAD_LOCAL__ Context *InnerThreadLocalContainer::curCtx_ = nullptr;
__THREAD_LOCAL__ RefObject<Context *> *InnerThreadLocalContainer::curRef_ = nullptr;
__THREAD_LOCAL__ Device *InnerThreadLocalContainer::device_ = nullptr;
__THREAD_LOCAL__ rtStreamCaptureMode InnerThreadLocalContainer::threadCaptureMode_ = RT_STREAM_CAPTURE_MODE_MAX;
__THREAD_LOCAL__ rtStreamCaptureMode InnerThreadLocalContainer::exchangeCaptureMode_ = RT_STREAM_CAPTURE_MODE_GLOBAL;
__THREAD_LOCAL__ rtError_t InnerThreadLocalContainer::globalError_ = ACL_RT_SUCCESS;
__THREAD_LOCAL__ uint8_t InnerThreadLocalContainer::groupId_ = UNINIT_GROUP_ID;
__THREAD_LOCAL__ const Stream* InnerThreadLocalContainer::curResLimitStream_ = nullptr;
__THREAD_LOCAL__
std::array<uint32_t, RT_STREAM_CAPTURE_MODE_MAX> InnerThreadLocalContainer::threadCaptureModeRefNum_ = {0U};

uint32_t InnerThreadLocalContainer::GetLastTaskId(void)
{
    return lastTaskId_;
}
void InnerThreadLocalContainer::SetLastTaskId(const uint32_t inLastTaskId)
{
    lastTaskId_ = inLastTaskId;
}

uint32_t InnerThreadLocalContainer::GetLastStreamId(void)
{
    return lastStreamId_;
}
void InnerThreadLocalContainer::SetLastStreamId(const uint32_t inLastStreamId)
{
    lastStreamId_ = inLastStreamId;
}

uint32_t InnerThreadLocalContainer::GetTsId(void)
{
    return tsId_;
}
void InnerThreadLocalContainer::SetTsId(const uint32_t inTsId)
{
    tsId_ = inTsId;
}

Context* InnerThreadLocalContainer::GetCurCtx(void)
{
    return curCtx_;
}
void InnerThreadLocalContainer::SetCurCtx(Context * const inCurCtx)
{
    curCtx_ = inCurCtx;
    if (inCurCtx != nullptr)
    {
        device_ = inCurCtx->Device_();
    }
}

RefObject<Context *>* InnerThreadLocalContainer::GetCurRef(void)
{
    return curRef_;
}
void InnerThreadLocalContainer::SetCurRef(RefObject<Context *> * const inCurRef)
{
    curRef_ = inCurRef;
    if (inCurRef != nullptr)
    {
        device_ = inCurRef->GetVal()->Device_();
    }    
}

Device* InnerThreadLocalContainer::GetDevice(void)
{
    return device_; 
}

uint8_t InnerThreadLocalContainer::GetGroupId(void)
{
    return groupId_;
}

void InnerThreadLocalContainer::SetGroupId(const uint8_t groupId)
{
    groupId_ = groupId;
} 

void InnerThreadLocalContainer::ThreadCaptureModeRefNumInc(rtStreamCaptureMode mode)
{
    threadCaptureModeRefNum_[mode]++;
}

void InnerThreadLocalContainer::ThreadCaptureModeRefNumDec(rtStreamCaptureMode mode)
{
    if (threadCaptureModeRefNum_[mode] > 0U) {
        threadCaptureModeRefNum_[mode]--;
    }
}

uint32_t InnerThreadLocalContainer::GetThreadCaptureModeRefNum(rtStreamCaptureMode mode)
{
    return threadCaptureModeRefNum_[mode];
}

rtStreamCaptureMode InnerThreadLocalContainer::GetThreadCaptureMode(void)
{
    return threadCaptureMode_;
}

void InnerThreadLocalContainer::SetThreadCaptureMode(rtStreamCaptureMode mode)
{
    threadCaptureMode_ = mode;
}

void InnerThreadLocalContainer::ThreadCaptureModeEnter(rtStreamCaptureMode mode)
{
    ThreadCaptureModeRefNumInc(mode);

    /* mode, 0: global; 1: thread; 2: relax; 3: max */
    if (mode < GetThreadCaptureMode()) {
        SetThreadCaptureMode(mode);
    }
}

void InnerThreadLocalContainer::ThreadCaptureModeExit(rtStreamCaptureMode mode)
{
    ThreadCaptureModeRefNumDec(mode);

    if (GetThreadCaptureModeRefNum(RT_STREAM_CAPTURE_MODE_GLOBAL) != 0U) {
        return;
    }

    if (GetThreadCaptureModeRefNum(RT_STREAM_CAPTURE_MODE_THREAD_LOCAL) != 0U) {
        SetThreadCaptureMode(RT_STREAM_CAPTURE_MODE_THREAD_LOCAL);
        return;
    }

    if (GetThreadCaptureModeRefNum(RT_STREAM_CAPTURE_MODE_RELAXED) != 0U) {
        SetThreadCaptureMode(RT_STREAM_CAPTURE_MODE_RELAXED);
        return;
    }

    SetThreadCaptureMode(RT_STREAM_CAPTURE_MODE_MAX);
}

rtStreamCaptureMode InnerThreadLocalContainer::GetThreadExchangeCaptureMode(void)
{
    return exchangeCaptureMode_;
}

void InnerThreadLocalContainer::SetThreadExchangeCaptureMode(rtStreamCaptureMode mode)
{
    exchangeCaptureMode_ = mode;
}

rtError_t InnerThreadLocalContainer::GetGlobalErr()
{
    const rtError_t error = globalError_;
    globalError_ = ACL_RT_SUCCESS;
    return error;
}

rtError_t InnerThreadLocalContainer::PeekGlobalErr()
{
    return globalError_;
}

void InnerThreadLocalContainer::SetGlobalErr(const rtError_t errCode)
{
    globalError_ = errCode;
}

void InnerThreadLocalContainer::SetCurrentResLimitStream(const Stream *stm)
{
    curResLimitStream_ = stm;
}

const Stream *InnerThreadLocalContainer::GetCurrentResLimitStream()
{
    return curResLimitStream_;
}
}
}