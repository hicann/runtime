/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "capture_model_utils.hpp"

namespace cce {
namespace runtime {

bool IsEventCapturing(const Event * const evt, const Stream * const stm) { UNUSED(evt); UNUSED(stm); return false; }

void TerminateCapture(const Event * const evt, const Stream * const stm) { UNUSED(evt); UNUSED(stm); }

bool IsCrossCaptureModel(const Event * const evt, const Stream * const stm) { UNUSED(evt); UNUSED(stm); return false; }

bool IsCapturedTask(const Stream * const launchStm, const TaskInfo *submitTask) { UNUSED(launchStm); UNUSED(submitTask); return false; }

rtError_t GetCaptureStream(Context * const ctx, Stream * const stm, const Event * const evt, Stream ** const captureStm) {
    UNUSED(ctx); UNUSED(stm); UNUSED(evt); UNUSED(captureStm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t CheckCaptureStreamThreadIsMatch(const Stream * const stm) { UNUSED(stm); return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t CheckCaptureModelSupportSoftwareSq(Device* const dev) { UNUSED(dev); return RT_ERROR_FEATURE_NOT_SUPPORT; }

rtError_t CheckCaptureModelForUpdate(const Stream* stm) { UNUSED(stm); return RT_ERROR_FEATURE_NOT_SUPPORT; }

bool IsSoftwareSqCaptureModel(const Model * const mdl) { UNUSED(mdl); return false; }

bool CheckCaptureModeSupport(const Context* ctx, const char* funcName) { UNUSED(ctx); UNUSED(funcName); return true; }

bool NeedReBuildSqe(const TaskInfo *const task) { UNUSED(task); return false; }

bool IsUseHardwareEvent(Device * const dev) { UNUSED(dev); return false; }
rtError_t AllocNotifyIdForSubModel(Model * const mdl, Notify *notify) { UNUSED(mdl); UNUSED(notify); return RT_ERROR_FEATURE_NOT_SUPPORT; }
rtError_t ReleaseNotify(Model * const mdl, Notify *notify) { UNUSED(mdl); UNUSED(notify); return RT_ERROR_FEATURE_NOT_SUPPORT; }
uint32_t FindStreamIdInSubModels(CaptureModel * const parentModel, const uint16_t sqId) { UNUSED(parentModel); UNUSED(sqId); return UINT32_MAX; }
bool IsStreamBindWithSubModel(Stream * const stream) { UNUSED(stream); return false; }
bool IsTaskBelongToSubCaptureMdl(const TaskInfo * const task) { UNUSED(task); return false; }
void Construct2ndSqeForCaptureConditionTask(TaskInfo* taskInfo, rtStarsSqe_t *sqe) { UNUSED(taskInfo); UNUSED(sqe); }
void ConstructSqeForCaptureConditionTask(TaskInfo* taskInfo, rtStarsSqe_t *const command) { UNUSED(taskInfo); UNUSED(command); }
void CaptureConditionTaskUnInit(TaskInfo * const taskInfo) { UNUSED(taskInfo); }

}
}