/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef RUNTIME_INNER_THREAD_LOCAL_CONTAINER_HPP
#define RUNTIME_INNER_THREAD_LOCAL_CONTAINER_HPP

#include "base.hpp"
#include "osal.hpp"
#include "api.hpp"

namespace cce {
namespace runtime {
class InnerThreadLocalContainer {
public:
    static uint32_t GetTsId(void);
    static void SetTsId(const uint32_t inTsId);

    static Context* GetCurCtx(void);
    static void SetCurCtx(Context * const inCurCtx);

    static RefObject<Context *>* GetCurRef(void);
    static void SetCurRef(RefObject<Context *> * const inCurRef);

    static Device* GetDevice(void);

    static uint32_t GetLastTaskId(void);
    static void SetLastTaskId(const uint32_t inLastTaskId);

    static uint32_t GetLastStreamId(void);
    static void SetLastStreamId(const uint32_t inLastStreamId);

    static uint8_t GetGroupId(void);
    static void SetGroupId(const uint8_t groupId);
    static rtStreamCaptureMode GetThreadCaptureMode(void);
    static void SetThreadCaptureMode(rtStreamCaptureMode mode);
    static rtStreamCaptureMode GetThreadExchangeCaptureMode(void);
    static void SetThreadExchangeCaptureMode(rtStreamCaptureMode mode);
    static void ThreadCaptureModeRefNumInc(rtStreamCaptureMode mode);
    static void ThreadCaptureModeRefNumDec(rtStreamCaptureMode mode);
    static uint32_t GetThreadCaptureModeRefNum(rtStreamCaptureMode mode);
    static void ThreadCaptureModeEnter(rtStreamCaptureMode mode);
    static void ThreadCaptureModeExit(rtStreamCaptureMode mode);
    static rtError_t GetGlobalErr(void);
    static rtError_t PeekGlobalErr(void);
    static void SetGlobalErr(const rtError_t errCode);
    static void SetCurrentResLimitStream(const Stream* stm);
    static const Stream* GetCurrentResLimitStream();
private:
    static __THREAD_LOCAL__ uint32_t lastTaskId_;
    static __THREAD_LOCAL__ uint32_t lastStreamId_;
    static __THREAD_LOCAL__ uint32_t tsId_;
    static __THREAD_LOCAL__ Context *curCtx_;
    static __THREAD_LOCAL__ RefObject<Context *> *curRef_;
    static __THREAD_LOCAL__ Device *device_;

    static __THREAD_LOCAL__ uint32_t dieId_;
    static __THREAD_LOCAL__ rtStreamCaptureMode threadCaptureMode_;
    static __THREAD_LOCAL__ rtStreamCaptureMode exchangeCaptureMode_;
    static __THREAD_LOCAL__ std::array<uint32_t, RT_STREAM_CAPTURE_MODE_MAX> threadCaptureModeRefNum_;
    static __THREAD_LOCAL__ uint8_t groupId_;
    static __THREAD_LOCAL__ rtError_t globalError_;
    static __THREAD_LOCAL__ const Stream* curResLimitStream_; // when destroying this stream, it is essential to ensure that no other threads are using this stream.
};
}  // namespace runtime
}  // namespace cce

// get last task id and stream id for the thread
#define GET_THREAD_TASKID_AND_STREAMID(workTask, streamId)                                                     \
    do {                                                                                                       \
        InnerThreadLocalContainer::SetLastTaskId(                                                              \
            GetFlipTaskId(static_cast<uint32_t>((workTask)->id), static_cast<uint16_t>((workTask)->flipNum))); \
        InnerThreadLocalContainer::SetLastStreamId(static_cast<uint32_t>(streamId));                           \
    } while (false)
// set last taskId and streamId for current thread
#define SET_THREAD_TASKID_AND_STREAMID(streamId, taskId)                             \
    do {                                                                             \
        InnerThreadLocalContainer::SetLastStreamId(static_cast<uint32_t>(streamId)); \
        InnerThreadLocalContainer::SetLastTaskId(taskId);                            \
    } while (false)
#endif  // RUNTIME_INNER_THREAD_LOCAL_CONTAINER_HPP