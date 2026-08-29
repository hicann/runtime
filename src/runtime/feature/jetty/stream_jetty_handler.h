/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_STREAM_JETTY_HANDLER_H__
#define __CCE_RUNTIME_STREAM_JETTY_HANDLER_H__

#include <cstdint>
#include "jetty_pool.h"
#include "jetty_manager.h"
#include "stream_jetty_context.h"

namespace cce {
namespace runtime {

class Model;

class StreamJettyHandler {
public:
    static rtError_t HandleUbDmaTask(
        const TaskInfo* task, JettyType jettyType, AsyncWqeInputPara* input, AsyncWqeOutputPara* output);

    static rtError_t FillNopWqeOnCaptureEnd(const Stream* stream, JettyType jettyType);

    static rtError_t GetOrCreateStreamJettyContext(
        const Stream* stream, JettyType jettyType, StreamJettyContext*& jettyCtx);

    static bool IsUbDmaCopyType(uint32_t copyType);

    static bool IsUbDmaTaskType(tsTaskType_t taskType);

    static JettyType GetJettyTypeFromTask(const TaskInfo* task);

    static rtError_t FillWqeToDevice(
        const Stream* stream, const StreamJettyContext* jettyCtx, const JettyInfo& jettyInfo);

    static rtError_t UpdateUbdmaSqeWithJettyInfo(
        const Stream* stream, const StreamJettyContext* jettyCtx, const JettyInfo& jettyInfo);

    static rtError_t BindJetty(Stream* stream, JettyType type, const CaptureModel* excludeMdl);

    static rtError_t RecycleJetty(Stream* stream, JettyType type, uint32_t& count);

    static rtError_t ReleaseJetty(Stream* const stream, JettyType type, bool deleteContext = true);

    static rtError_t RefreshModelJettyInfoList(Model* const mdl);

private:
    static rtError_t ResetJettyCi(
        JettyManager* jettyMgr, Stream* stream, JettyType type, const StreamJettyContext* ctx);
    static rtError_t CreateAndAppendWqe(
        const TaskInfo* task, StreamJettyContext* jettyCtx, AsyncWqeInputPara* input, AsyncWqeOutputPara* output);

    static rtError_t FillNopWqeForPartialBuffer(const Stream* stream, const StreamJettyContext* jettyCtx);

    static rtError_t GetDriverAndDeviceId(const Stream* stream, Driver*& driver, uint32_t& deviceId);

    static JettyType ConvertCopyTypeToJettyType(const uint32_t copyType, const bool isD2dCross8P);
};

} // namespace runtime
} // namespace cce

#endif
