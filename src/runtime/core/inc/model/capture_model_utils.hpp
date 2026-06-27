/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CAPTURE_MODEL_UTILS_HPP
#define CAPTURE_MODEL_UTILS_HPP

#include "model.hpp"
#include "event.hpp"
#include "stream.hpp"
#include "notify.hpp"

namespace cce {
namespace runtime {
bool IsEventCapturing(const Event * const evt, const Stream * const stm);
void TerminateCapture(const Event * const evt, const Stream * const stm);
bool IsCrossCaptureModel(const Event * const evt, const Stream * const stm);
bool IsCapturedTask(const Stream * const launchStm, const TaskInfo *submitTask);
rtError_t GetCaptureStream(Context * const ctx, Stream * const stm, const Event * const evt, Stream ** const captureStm);
rtError_t CheckCaptureStreamThreadIsMatch(const Stream * const stm);
rtError_t CheckCaptureModelSupportSoftwareSq(Device* const dev);
rtError_t CheckCaptureModelSupportCondOp(Device * const dev);
rtError_t CheckCaptureModelForUpdate(const Stream* stm);
bool IsSoftwareSqCaptureModel(const Model * const mdl);
bool CheckCaptureModeSupport(const Context* ctx, const char* funcName);
bool NeedReBuildSqe(const TaskInfo *const task);
bool IsUseHardwareEvent(Device * const dev);
rtError_t AllocNotifyIdForSubModel(Model * const mdl, Notify *notify);
rtError_t ReleaseNotify(Model * const mdl, Notify *notify);
uint32_t FindStreamIdInSubModels(CaptureModel * const parentModel, const uint16_t sqId);
bool IsStreamBindWithSubModel(Stream * const stream);
bool IsTaskBelongToSubCaptureMdl(const TaskInfo * const task);
bool IsUbDmaWithSubModel(Stream *const stm, const uint32_t kind, const void *const srcAddr, void *const desAddr);

}
}

#endif