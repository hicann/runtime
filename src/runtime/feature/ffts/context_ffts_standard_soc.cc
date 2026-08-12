/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "context.hpp"
#include "runtime.hpp"
#include "task.hpp"
#include "task_info.hpp"
#include "inner_thread_local.hpp"
#include "ffts_task.h"
#include "rdma_task.h"

namespace cce {
namespace runtime {
TIMESTAMP_EXTERN(FftsPlusTaskInit);
rtError_t Context::FftsPlusTaskLaunch(
    const rtFftsPlusTaskInfo_t* const fftsPlusTaskInfo, Stream* const stm, const uint32_t flag)
{
    const int32_t streamId = stm->Id_();
    const uint32_t sqeNum = ((flag & RT_KERNEL_FFTSPLUS_DYNAMIC_SHAPE_DUMPFLAG) != 0U) ? 3U : 1U;

    RT_LOG(RT_LOG_INFO, "Begin to Create Ffts Plus Task.");

    TaskInfo taskSubmit = {};
    rtError_t errorReason;
    TaskInfo* rtFftsPlusTask = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_FFTS_PLUS, errorReason, sqeNum);
    NULL_PTR_RETURN(rtFftsPlusTask, errorReason);

    TIMESTAMP_BEGIN(FftsPlusTaskInit);
    rtError_t error = FftsPlusTaskInit(rtFftsPlusTask, fftsPlusTaskInfo, flag);
    TIMESTAMP_END(FftsPlusTaskInit);
    ERROR_GOTO(
        error, ERROR_RECYCLE, "Ffts plus task init failed, stream_id=%d, task_id=%hu, retCode=%#x.", streamId,
        rtFftsPlusTask->id, error);
    // wait for copy finish
    if (rtFftsPlusTask->u.fftsPlusTask.argsHandleInfoPtr != nullptr) {
        for (auto iter : *(rtFftsPlusTask->u.fftsPlusTask.argsHandleInfoPtr)) {
            Handle* argHdl = static_cast<Handle*>(iter);
            if (!(argHdl->freeArgs)) {
                continue;
            }
            RT_LOG(
                RT_LOG_INFO,
                "device_id=%u, stream_id=%d, task_id=%u, hand=%p, kerArgs=%p, "
                "HandleInfoPtr=%p",
                device_->Id_(), streamId, rtFftsPlusTask->id, argHdl, argHdl->argsAlloc->GetDevAddr(argHdl->kerArgs),
                rtFftsPlusTask->u.fftsPlusTask.argsHandleInfoPtr);

            error = argHdl->argsAlloc->H2DMemCopyWaitFinish(argHdl->kerArgs);
            ERROR_GOTO(error, ERROR_RECYCLE, "H2DMemCopyWaitFinish for args cpy result failed, retCode=%#x.", error);
            stm->fftsMemFreeCnt++;
        }
    }

    error = device_->SubmitTask(rtFftsPlusTask);
    ERROR_GOTO(error, ERROR_RECYCLE, "Ffts plus task submit failed, retCode=%#x", error);

    GET_THREAD_TASKID_AND_STREAMID(rtFftsPlusTask, stm->AllocTaskStreamId());

    if (stm->IsCapturing() && stm->GetCaptureStream() != nullptr) {
        std::lock_guard<std::mutex> lock(captureLock_); // 防止跟endCapture接口并发调用，概率较低
        if (stm->IsCapturing() && stm->GetCaptureStream() != nullptr) {
            FftsPlusTaskInfo& fftsPlusTask = rtFftsPlusTask->u.fftsPlusTask;
            error = SubmitRdmaPiValueModifyTask(stm, fftsPlusTaskInfo, fftsPlusTask.descAlignBuf);
        }
    }

    return error;
ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtFftsPlusTask);
    return error;
}
} // namespace runtime
} // namespace cce
