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
#include "error_message_manage.hpp"

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
                std::stringstream ss;
                ss << std::hex << "dest=0x" << RtPtrToValue(&cmoTsk->cmoSqeInfo) << ", src=0x" << RtPtrToValue(cmoTaskInfo)
                   << std::dec << ", destMax=" << sizeof(rtCmoTaskInfo_t) << ", count=" << sizeof(rtCmoTaskInfo_t) << ".";
                RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1020, __func__,
                    "memcpy_s", std::to_string(error).c_str(), strerror(error), ss.str().c_str());
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
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "The stream that delivers the CMO task is not in the model,"
            " device_id=%u, stream_id=%d.", taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_());
        return RT_ERROR_MODEL_NULL;
    } else {
        // no operation
    }

    CmoTaskInfo *cmoTsk = &taskInfo->u.cmoTask;
    // sqe info copy
    const errno_t error = memcpy_s(&cmoTsk->cmoSqeInfo, sizeof(rtCmoTaskInfo_t), cmoTaskInfo, sizeof(rtCmoTaskInfo_t));
    if (error != EOK) {
        std::stringstream ss;
        ss << std::hex << "dest=0x" << RtPtrToValue(&cmoTsk->cmoSqeInfo) << ", src=0x" << RtPtrToValue(cmoTaskInfo)
           << std::dec << ", destMax=" << sizeof(rtCmoTaskInfo_t) << ", count=" << sizeof(rtCmoTaskInfo_t) << ".";
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1020, __func__,
            "memcpy_s", std::to_string(error).c_str(), strerror(error), ss.str().c_str());
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

    COND_RETURN_ERROR_MSG_INNER((cmoModel == nullptr), RT_ERROR_MODEL_NULL,
        "The stream that delivers the CmoAddr task is not in the model, deviceId=%u, streamId=%d, taskId=%u.",
        taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), taskInfo->id);

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
