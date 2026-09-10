/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_CAPTURE_SESSION_HPP
#define CCE_RUNTIME_CAPTURE_SESSION_HPP

#include "context_extension.hpp"
#include "runtime/base.h"

namespace cce {
namespace runtime {

class Context;
class CaptureModel;
class Model;
class Notify;
class Stream;
struct tagTaskInfoStru;
typedef tagTaskInfoStru TaskInfo;

class CaptureSession final : public ContextExtension {
public:
    explicit CaptureSession(Context* ctx) : ctx_(ctx) {}
    ~CaptureSession() override = default;

    rtStreamCaptureMode GetContextCaptureMode() const { return captureMode_; }
    bool IsCaptureModeSupport() const;
    void CaptureModeEnter(Stream* const stm, rtStreamCaptureMode mode);
    void CaptureModeExit(Stream* const stm);
    rtError_t ThreadExchangeCaptureMode(rtStreamCaptureMode* const mode) const;

    rtError_t StreamBeginCapture(Stream* const stm, const rtStreamCaptureMode mode, Model* const mdl = nullptr);
    rtError_t StreamEndCapture(Stream* const stm, Model** const captureMdl);
    rtError_t StreamAddToCaptureModelProc(Stream* const stm, Model* const captureMdl, const bool isOriginal = false);
    rtError_t StreamAddToModel(Stream* const stm, Model* const captureMdl);
    rtError_t UpdateEndGraphTask(Stream* const origCaptureStream, Stream* const exeStream, Notify* ntf) const;
    rtError_t UpdateSuModelExeStreamNotifyWaitSqe(TaskInfo* taskInfo, Stream* const exeStream) const;

private:
    rtError_t CheckCaptureModelIsCaptured(Model* const mdl) const;
    rtError_t CheckCaptureModelValidity(Model* const captureMdl) const;
    rtError_t AddNotifyToAddedCaptureStream(Stream* const oriSingleStm, CaptureModel* const captureMdl);
    rtError_t SetNotifyForExeModel(CaptureModel* const captureMdl);
    bool CheckSubModelsIsEndCapture(const Stream* const captureStream) const;
    void ClearCaptureModel(Stream* const stm, Model* mdl = nullptr);

    Context* const ctx_;
    rtStreamCaptureMode captureMode_{RT_STREAM_CAPTURE_MODE_MAX};
    uint32_t captureModeRefNum_[RT_STREAM_CAPTURE_MODE_MAX] = {0U};
};

bool IsCaptureSessionExist(const Context* ctx);
CaptureSession* GetCaptureSession(const Context* ctx);

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_CAPTURE_SESSION_HPP
