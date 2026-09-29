/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_CAPTURE_FUNC_HPP
#define CCE_RUNTIME_CAPTURE_FUNC_HPP

#include "runtime/base.h"
#include "runtime/rt_inner_model.h"
#include "task_base.hpp"

namespace cce {
namespace runtime {

class CondHandle;
class Context;
class ContextExtension;
class Event;
class Model;
class Stream;
class StreamExtension;
struct tagTaskInfoStru;
typedef tagTaskInfoStru TaskInfo;

using PfnCreateContextExtension = ContextExtension* (*)(Context* ctx);
using PfnCreateStreamExtension = StreamExtension* (*)(Stream* stm);
using PfnCreateSubCaptureModels =
    rtError_t (*)(Context* ctx, CondHandle* condHandle, rtCondTaskParams params, Stream* stm);
using PfnDetachCaptureEvent = void (*)(Event* event);
using PfnSetTaskGroupErrCode = void (*)(const Stream* stm, rtError_t errorCode);
using PfnAllocCaptureTask = rtError_t (*)(Stream* stm, tsTaskType_t taskType, uint32_t sqeNum, TaskInfo** task);
using PfnGenerateCaptureSeqId = uint32_t (*)(Model* model);
using PfnGetModelIfCapture = Model* (*)(Model* model);
using PfnBackupCaptureArgHandle = void (*)(Model* model, uint16_t streamId, uint16_t taskId);
using PfnIsCaptureFinish = bool (*)(const Model* model);
using PfnCacheCaptureTaskId = void (*)(Stream* stm, uint16_t taskId);
using PfnGetCacheOpInfoSwitch = uint32_t (*)(const Stream* stm);
using PfnSetCacheOpInfoOriginSwitch = void (*)(const Stream* stm, uint32_t status);
using PfnIsOrigCaptureStream = bool (*)(const Stream* stm);
using PfnResetCaptureTaskGroup = void (*)(Stream* stm);
using PfnUpdateCaptureTask = rtError_t (*)(Stream* stm, TaskInfo** task);
using PfnPackCaptureTaskGroup = rtError_t (*)(Stream* stm, const TaskInfo* task, uint16_t streamId);

// Reduced builds only register stubs for callbacks reachable outside capture-specific state.
struct CaptureFunc {
    PfnCreateContextExtension createContextExtension;
    PfnCreateStreamExtension createStreamExtension;
    PfnCreateSubCaptureModels createSubCaptureModels;
    PfnDetachCaptureEvent detachCaptureEvent;
    PfnSetTaskGroupErrCode setTaskGroupErrCode;
    PfnAllocCaptureTask allocCaptureTask;
    PfnGenerateCaptureSeqId generateSeqId;
    PfnGetModelIfCapture getModelIfCapture;
    PfnBackupCaptureArgHandle backupArgHandle;
    PfnIsCaptureFinish isCaptureFinish;
    PfnCacheCaptureTaskId cacheCaptureTaskId;
    PfnGetCacheOpInfoSwitch getCacheOpInfoSwitch;
    PfnSetCacheOpInfoOriginSwitch setCacheOpInfoOriginSwitch;
    PfnIsOrigCaptureStream isOrigCaptureStream;
    PfnResetCaptureTaskGroup resetTaskGroup;
    PfnUpdateCaptureTask updateTask;
    PfnPackCaptureTaskGroup packingTaskGroup;
};

void RegCaptureFunc(const CaptureFunc& funcs);
const CaptureFunc& GetCaptureFunc();

} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_CAPTURE_FUNC_HPP
