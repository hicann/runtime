/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "cmo_task.h"
#include "model.hpp"

namespace cce {
namespace runtime {

#if F_DESC("CmoTask")
rtError_t CmoTaskInit(TaskInfo *taskInfo, const rtCmoTaskInfo_t *const cmoTaskInfo, const Stream * const stm,
                      const uint32_t flag)
{
    (void)flag;
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "CMO";
    taskInfo->type = TS_TASK_TYPE_CMO;
    taskInfo->u.cmoTask.cmoid = 0U;
    Model *cmoModel = stm->Model_();

    if (stm->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_CMO)) {
        if (cmoModel == nullptr) {
            // 1971 CmoTask for prefetch
            CmoTaskInfo *cmoTsk = &taskInfo->u.cmoTask;
            // sqe info copy
            const errno_t error = memcpy_s(
                &cmoTsk->cmoSqeInfo, sizeof(rtCmoTaskInfo_t), cmoTaskInfo, sizeof(rtCmoTaskInfo_t));
            if (error != EOK) {
                RT_LOG(RT_LOG_ERROR, "copy to CMO Sqe info failed, ret=%d, src size=%zu(bytes), "
                    "dst size=%zu(bytes)", error, sizeof(rtCmoTaskInfo_t), sizeof(rtCmoTaskInfo_t));
                return RT_ERROR_SEC_HANDLE;
            }

            RT_LOG(RT_LOG_DEBUG, "CmoTask Init, opCode=%u, length=%u", cmoTsk->cmoSqeInfo.opCode,
                cmoTsk->cmoSqeInfo.lengthInner);
            return RT_ERROR_NONE;
        } else {
            RT_LOG(RT_LOG_WARNING, "CMO task stream does not support in model.");
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
    } else if (cmoModel == nullptr) {
        RT_LOG(RT_LOG_ERROR, "CMO task stream is not in model.");
        return RT_ERROR_MODEL_NULL;
    } else {
        // no operation
    }

    CmoTaskInfo *cmoTsk = &taskInfo->u.cmoTask;
    // sqe info copy
    const errno_t error = memcpy_s(&cmoTsk->cmoSqeInfo, sizeof(rtCmoTaskInfo_t), cmoTaskInfo, sizeof(rtCmoTaskInfo_t));
    if (error != EOK) {
        RT_LOG(RT_LOG_ERROR, "copy to CMO Sqe info failed, ret=%d, src size=%zu(bytes), dst size=%zu(bytes)",
            error, sizeof(rtCmoTaskInfo_t), sizeof(rtCmoTaskInfo_t));
        return RT_ERROR_SEC_HANDLE;
    }

    const rtError_t ret = cmoModel->CmoIdAlloc(cmoTsk->cmoSqeInfo.logicId, cmoTsk->cmoid);
    ERROR_RETURN(ret, "Failed to alloc cmo id.");

    RT_LOG(RT_LOG_DEBUG, "CmoTaskInfo: cmoType=%u, logicId=%u, cmoId=%u",
        cmoTsk->cmoSqeInfo.cmoType, cmoTsk->cmoSqeInfo.logicId, cmoTsk->cmoid);
    return RT_ERROR_NONE;
}

rtError_t CmoAddrTaskInit(TaskInfo *taskInfo, void *cmoAddrInfo, const rtCmoOpCode_t cmoOpCode)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "CMO";
    taskInfo->type = TS_TASK_TYPE_CMO;
    taskInfo->u.cmoTask.cmoid = 0U;
    Stream * const stream = taskInfo->stream;
    Model *cmoModel = stream->Model_();

    if (cmoModel == nullptr) {
        RT_LOG(RT_LOG_ERROR, "CMO Addr task stream is not in model. device_id=%d, stream_id=%d, task_id=%hu.",
            static_cast<int32_t>(stream->Device_()->Id_()), stream->Id_(), taskInfo->id);
        return RT_ERROR_MODEL_NULL;
    }

    CmoAddrTaskInfo *cmoAddrTask = &(taskInfo->u.cmoAddrTaskInfo);
    cmoAddrTask->cmoAddrInfo = cmoAddrInfo;
    cmoAddrTask->cmoOpCode = cmoOpCode;

    RT_LOG(RT_LOG_DEBUG, "CmoAddrTask Init, device_id=%d, stream_id=%d, task_id=%hu.",
        static_cast<int32_t>(stream->Device_()->Id_()), stream->Id_(), taskInfo->id);
    return RT_ERROR_NONE;
}
#endif

}  // namespace runtime
}  // namespace cce
