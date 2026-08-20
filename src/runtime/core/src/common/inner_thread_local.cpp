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
#include "context.hpp"

namespace cce {
namespace runtime {
__THREAD_LOCAL__ uint32_t InnerThreadLocalContainer::lastTaskId_ = 0xFFFFFFFFU; /* 0xFFFFFFFF is UINT32_MAX */
__THREAD_LOCAL__ uint32_t InnerThreadLocalContainer::lastStreamId_ = 0xFFFFU;   /* 0xFFFF is UINT16_MAX */
__THREAD_LOCAL__ uint32_t InnerThreadLocalContainer::tsId_ = 0U;
__THREAD_LOCAL__ Context* InnerThreadLocalContainer::curCtx_ = nullptr;
__THREAD_LOCAL__ RefObject<Context*>* InnerThreadLocalContainer::curRef_ = nullptr;
__THREAD_LOCAL__ Device* InnerThreadLocalContainer::device_ = nullptr;
__THREAD_LOCAL__ rtStreamCaptureMode InnerThreadLocalContainer::threadCaptureMode_ = RT_STREAM_CAPTURE_MODE_MAX;
__THREAD_LOCAL__ rtStreamCaptureMode InnerThreadLocalContainer::exchangeCaptureMode_ = RT_STREAM_CAPTURE_MODE_GLOBAL;
__THREAD_LOCAL__ rtError_t InnerThreadLocalContainer::globalError_ = ACL_RT_SUCCESS;
__THREAD_LOCAL__ uint8_t InnerThreadLocalContainer::groupId_ = UNINIT_GROUP_ID;
__THREAD_LOCAL__ const Stream* InnerThreadLocalContainer::curResLimitStream_ = nullptr;
__THREAD_LOCAL__ bool InnerThreadLocalContainer::curCtxInternalAccess_ = false;
__THREAD_LOCAL__ bool InnerThreadLocalContainer::curRefInternalAccess_ = false;
__THREAD_LOCAL__
std::array<uint32_t, RT_STREAM_CAPTURE_MODE_MAX> InnerThreadLocalContainer::threadCaptureModeRefNum_ = {0U};

namespace {
Context* GetBoundContext(Context* curCtx, RefObject<Context*>* curRef)
{
    if (curCtx != nullptr) {
        return curCtx;
    }
    if (curRef != nullptr) {
        return curRef->GetVal(false);
    }
    return nullptr;
}

bool GetEffectiveContextInternalAccess(
    Context* curCtx, bool curCtxInternalAccess, RefObject<Context*>* curRef, bool curRefInternalAccess)
{
    if (curCtx != nullptr) {
        return curCtxInternalAccess;
    }
    if (curRef != nullptr) {
        return curRefInternalAccess;
    }
    return false;
}

bool UpdateThreadBinding(Context* oldCtx, bool oldNeedThreadRef, Context* newCtx, bool newNeedThreadRef)
{
    const bool needUnbindOldCtx = oldNeedThreadRef && ((oldCtx != newCtx) || !newNeedThreadRef) && (oldCtx != nullptr);
    const bool needBindNewCtx = newNeedThreadRef && ((oldCtx != newCtx) || !oldNeedThreadRef) && (newCtx != nullptr);
    const bool oldCtxIsNewCtx = (oldCtx == newCtx);
    bool oldCtxDeleted = false;
    if (needUnbindOldCtx) {
        (void)oldCtx->ContextThreadUnbind();
        // oldCtx may be deleted here; callers must not use it.
        oldCtxDeleted = oldCtx->TryDeleteIfNeeded();
    }

    if (needBindNewCtx && ((!oldCtxDeleted) || !oldCtxIsNewCtx)) {
        newCtx->ContextThreadBind();
    }
    return oldCtxDeleted;
}

bool NeedThreadRef(const Context* const ctx, const bool internalAccess)
{
    return (ctx != nullptr) && !internalAccess && !ctx->IsPrimary();
}
} // namespace

uint32_t InnerThreadLocalContainer::GetLastTaskId(void) { return lastTaskId_; }
void InnerThreadLocalContainer::SetLastTaskId(const uint32_t inLastTaskId) { lastTaskId_ = inLastTaskId; }

uint32_t InnerThreadLocalContainer::GetLastStreamId(void) { return lastStreamId_; }
void InnerThreadLocalContainer::SetLastStreamId(const uint32_t inLastStreamId) { lastStreamId_ = inLastStreamId; }

uint32_t InnerThreadLocalContainer::GetTsId(void) { return tsId_; }

void InnerThreadLocalContainer::SetTsId(const uint32_t inTsId) { tsId_ = inTsId; }

Context* InnerThreadLocalContainer::GetCurCtx(void) { return curCtx_; }

void InnerThreadLocalContainer::ClearDeletedContextBinding(Context* const deletedCtx)
{
    if (deletedCtx == nullptr) {
        return;
    }
    if (curCtx_ == deletedCtx) {
        curCtx_ = nullptr;
        curCtxInternalAccess_ = false;
    }
    if ((curRef_ != nullptr) && (curRef_->GetVal(false) == deletedCtx)) {
        curRef_ = nullptr;
        curRefInternalAccess_ = false;
    }
}

void InnerThreadLocalContainer::RefreshDevice()
{
    Context* const boundCtx = GetBoundContext(curCtx_, curRef_);
    device_ = (boundCtx != nullptr) ? boundCtx->Device_() : nullptr;
}

void InnerThreadLocalContainer::SetCurCtx(Context* const inCurCtx, bool internalAccess)
{
    Context* const oldCtx = GetBoundContext(curCtx_, curRef_);
    const bool oldInternalAccess =
        GetEffectiveContextInternalAccess(curCtx_, curCtxInternalAccess_, curRef_, curRefInternalAccess_);
    Context* const newCtx = GetBoundContext(inCurCtx, curRef_);
    const bool newCurCtxInternalAccess = (inCurCtx != nullptr) && internalAccess;
    const bool newInternalAccess =
        GetEffectiveContextInternalAccess(inCurCtx, newCurCtxInternalAccess, curRef_, curRefInternalAccess_);
    const bool oldNeedThreadRef = NeedThreadRef(oldCtx, oldInternalAccess);
    const bool newNeedThreadRef = NeedThreadRef(newCtx, newInternalAccess);
    const bool oldCtxDeleted = UpdateThreadBinding(oldCtx, oldNeedThreadRef, newCtx, newNeedThreadRef);
    curCtx_ = inCurCtx;
    curCtxInternalAccess_ = ((curCtx_ != nullptr) ? internalAccess : false);
    if (oldCtxDeleted) {
        ClearDeletedContextBinding(oldCtx);
    }
    RefreshDevice();
}

RefObject<Context*>* InnerThreadLocalContainer::GetCurRef(void) { return curRef_; }
void InnerThreadLocalContainer::SetCurRef(RefObject<Context*>* const inCurRef, const bool internalAccess)
{
    Context* const oldCtx = GetBoundContext(curCtx_, curRef_);
    const bool oldInternalAccess =
        GetEffectiveContextInternalAccess(curCtx_, curCtxInternalAccess_, curRef_, curRefInternalAccess_);
    Context* const newCtx = GetBoundContext(curCtx_, inCurRef);
    const bool newCurRefInternalAccess = (inCurRef != nullptr) && internalAccess;
    const bool newInternalAccess =
        GetEffectiveContextInternalAccess(curCtx_, curCtxInternalAccess_, inCurRef, newCurRefInternalAccess);
    const bool oldNeedThreadRef = NeedThreadRef(oldCtx, oldInternalAccess);
    const bool newNeedThreadRef = NeedThreadRef(newCtx, newInternalAccess);
    const bool oldCtxDeleted = UpdateThreadBinding(oldCtx, oldNeedThreadRef, newCtx, newNeedThreadRef);
    curRef_ = inCurRef;
    curRefInternalAccess_ = ((curRef_ != nullptr) ? internalAccess : false);
    if (oldCtxDeleted) {
        ClearDeletedContextBinding(oldCtx);
    }
    RefreshDevice();
}

bool InnerThreadLocalContainer::IsInternalContextAccess(void)
{
    return GetEffectiveContextInternalAccess(curCtx_, curCtxInternalAccess_, curRef_, curRefInternalAccess_);
}

Device* InnerThreadLocalContainer::GetDevice(void) { return device_; }

uint8_t InnerThreadLocalContainer::GetGroupId(void) { return groupId_; }

void InnerThreadLocalContainer::SetGroupId(const uint8_t groupId) { groupId_ = groupId; }

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

rtStreamCaptureMode InnerThreadLocalContainer::GetThreadCaptureMode(void) { return threadCaptureMode_; }

void InnerThreadLocalContainer::SetThreadCaptureMode(rtStreamCaptureMode mode) { threadCaptureMode_ = mode; }

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

rtStreamCaptureMode InnerThreadLocalContainer::GetThreadExchangeCaptureMode(void) { return exchangeCaptureMode_; }

void InnerThreadLocalContainer::SetThreadExchangeCaptureMode(rtStreamCaptureMode mode) { exchangeCaptureMode_ = mode; }

rtError_t InnerThreadLocalContainer::GetGlobalErr()
{
    const rtError_t error = globalError_;
    globalError_ = ACL_RT_SUCCESS;
    return error;
}

rtError_t InnerThreadLocalContainer::PeekGlobalErr() { return globalError_; }

void InnerThreadLocalContainer::SetGlobalErr(const rtError_t errCode) { globalError_ = errCode; }

void InnerThreadLocalContainer::SetCurrentResLimitStream(const Stream* stm) { curResLimitStream_ = stm; }

const Stream* InnerThreadLocalContainer::GetCurrentResLimitStream() { return curResLimitStream_; }
} // namespace runtime
} // namespace cce
