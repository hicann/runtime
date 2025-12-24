/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cinttypes>
#include <queue>
#include "context.hpp"
#include "securec.h"
#include "runtime.hpp"
#include "coprocessor_stream.hpp"
#include "event.hpp"
#include "notify.hpp"
#include "count_notify.hpp"
#include "device.hpp"
#include "program.hpp"
#include "module.hpp"
#include "uma_arg_loader.hpp"
#include "npu_driver.hpp"
#include "onlineprof.hpp"
#include "task.hpp"
#include "osal.hpp"
#include "error_message_manage.hpp"
#include "profiler.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "dvpp_grp.hpp"
#include "task_info.hpp"
#include "ffts_task.h"
#include "rdma_task.h"
#include "task_submit.hpp"
#include "task_to_sqe.hpp"
#include "stream_state_callback_manager.hpp"
#if (!defined(CFG_VECTOR_CAST))
#include <algorithm>
#endif
#include "heterogenous.h"
#include "stars_common_task.h"
#include "stream_factory.hpp"

namespace cce {
namespace runtime {
void Context::GetStreamlist(rtStreamlistType_t type, rtStreamlist_t *stmList)
{
    std::unique_lock<std::mutex> taskLock(streamLock_);
    if (type == RT_NOTSINKED_STREAM) {
        for (Stream *stream : streams_) {
            if (!stream->GetBindFlag() && stmList->stmNum < RT_MAX_STREAM_NUM) {
                stmList->stms[(stmList->stmNum)++] = static_cast<rtStream_t>(stream);
            }
        }
    }
    if (stmList->stmNum >= RT_MAX_STREAM_NUM) {
        return;
    }
    Stream *defaultStream = DefaultStream_();
    if (stmList->stmNum < RT_MAX_STREAM_NUM) {
        stmList->stms[(stmList->stmNum)++] = static_cast<rtStream_t>(defaultStream);
    }
}

void Context::GetModelList(rtModelList_t *mdlList)
{
    modelLock_.Lock();
    for (Model *model : models_) {
        if (mdlList->mdlNum < RT_MAX_MODEL_NUM) {
            mdlList->mdls[(mdlList->mdlNum)++] = static_cast<rtModel_t>(model);
        }
    }
    modelLock_.Unlock();
}

rtError_t Context::TryRecycleCaptureModelResource(const uint32_t allocSqNum, const uint32_t ntfCnt,
    const CaptureModel * const excludeMdl)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t releaseSqNum = 0U;
    uint32_t totalReleaseSqNum = 0U;
    uint32_t totalReleaseNtfNum = 0U;

    modelLock_.Lock();
    for (Model *model : models_) {
        if ((model != nullptr) && (model->GetModelType() == RT_MODEL_CAPTURE_MODEL)) {
            CaptureModel *captureMdl = dynamic_cast<CaptureModel *>(model);

            if (allocSqNum <= totalReleaseSqNum && ntfCnt <= totalReleaseNtfNum) break;

            if (!captureMdl->IsSoftwareSqEnable() || (captureMdl == excludeMdl)) {
                continue;
            }

            if (allocSqNum > totalReleaseSqNum) {
                releaseSqNum = 0U;
                error = captureMdl->ReleaseSqCq(releaseSqNum);
                COND_PROC(error != RT_ERROR_NONE, break);
                totalReleaseSqNum += releaseSqNum;
            }

            if (ntfCnt > totalReleaseNtfNum) {
                error = captureMdl->ReleaseNotifyId();
                COND_PROC(error != RT_ERROR_NONE, continue);
                totalReleaseNtfNum++;
            }
        }
    }
    modelLock_.Unlock();

    return error;
}

TIMESTAMP_EXTERN(FftsPlusTaskInit);
rtError_t Context::FftsPlusTaskLaunch(const rtFftsPlusTaskInfo_t * const fftsPlusTaskInfo, Stream * const stm,
                                      const uint32_t flag)
{
    const int32_t streamId = stm->Id_();
    const uint32_t sqeNum = ((flag & RT_KERNEL_FFTSPLUS_DYNAMIC_SHAPE_DUMPFLAG) != 0U) ? 3U : 1U;

    RT_LOG(RT_LOG_INFO, "Begin to Create Ffts Plus Task.");

    TaskInfo taskSubmit = {};
    rtError_t errorReason;
    TaskInfo *rtFftsPlusTask = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_FFTS_PLUS, errorReason, sqeNum);
    NULL_PTR_RETURN(rtFftsPlusTask, errorReason);

    TIMESTAMP_BEGIN(FftsPlusTaskInit);
    rtError_t error = FftsPlusTaskInit(rtFftsPlusTask, fftsPlusTaskInfo, flag);
    TIMESTAMP_END(FftsPlusTaskInit);
    ERROR_GOTO(error, ERROR_RECYCLE,
               "Ffts plus task init failed, stream_id=%d, task_id=%hu, retCode=%#x.",
               streamId, rtFftsPlusTask->id, error);
    // wait for copy finish
    if (rtFftsPlusTask->u.fftsPlusTask.argsHandleInfoPtr != nullptr) {
        for (auto iter : *(rtFftsPlusTask->u.fftsPlusTask.argsHandleInfoPtr)) {
            Handle *argHdl = static_cast<Handle *>(iter);
            if (!(argHdl->freeArgs)) {
                continue;
            }
            RT_LOG(RT_LOG_INFO, "device_id=%u, stream_id=%d, task_id=%u, hand=%p, kerArgs=%p, "
                "HandleInfoPtr=%p", device_->Id_(), streamId, rtFftsPlusTask->id, argHdl,
                argHdl->argsAlloc->GetDevAddr(argHdl->kerArgs), rtFftsPlusTask->u.fftsPlusTask.argsHandleInfoPtr);

            error = argHdl->argsAlloc->H2DMemCopyWaitFinish(argHdl->kerArgs);
            ERROR_GOTO(error, ERROR_RECYCLE,
                "H2DMemCopyWaitFinish for args cpy result failed, retCode=%#x.", error);
            stm->fftsMemFreeCnt++;
        }
    }

    error = device_->SubmitTask(rtFftsPlusTask, taskGenCallback_);
    ERROR_GOTO(error, ERROR_RECYCLE, "Ffts plus task submit failed, retCode=%#x", error);

    GET_THREAD_TASKID_AND_STREAMID(rtFftsPlusTask, stm->AllocTaskStreamId());

    if (stm->IsCapturing() && stm->GetCaptureStream() != nullptr) {
        std::lock_guard<std::mutex> lock(captureLock_); // 防止跟endCapture接口并发调用，概率较低
        if (stm->IsCapturing() && stm->GetCaptureStream() != nullptr) {
            FftsPlusTaskInfo &fftsPlusTask = rtFftsPlusTask->u.fftsPlusTask;
            error = SubmitRdmaPiValueModifyTask(stm, fftsPlusTaskInfo, fftsPlusTask.descAlignBuf);
        }
    }

    return error;
ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtFftsPlusTask);
    return error;
}

rtError_t Context::RDMASend(const uint32_t sqIndex, const uint32_t wqeIndex, Stream * const stm)
{
    rtError_t error;
    const int32_t streamId = stm->Id_();
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *rtRdmaSendTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_RDMA_SEND, errorReason);
    NULL_PTR_RETURN_MSG(rtRdmaSendTask, errorReason);

    error = RdmaSendTaskInit(rtRdmaSendTask, sqIndex, wqeIndex);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
        "Rdma send task init failed, stream_id=%d, task_id=%hu, retCode=%#x.",
        streamId, rtRdmaSendTask->id, static_cast<uint32_t>(error));

    error = device_->SubmitTask(rtRdmaSendTask, taskGenCallback_);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Rdma send task submit failed, retCode=%#x.", static_cast<uint32_t>(error));

    GET_THREAD_TASKID_AND_STREAMID(rtRdmaSendTask, stm->AllocTaskStreamId());

    return error;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtRdmaSendTask);
    return error;
}

rtError_t Context::RdmaDbSendToDev(const uint32_t dbIndex, const uint64_t dbInfo, Stream * const stm,
    const uint32_t taskSqe) const
{
    rtError_t error;
    const int32_t streamId = stm->Id_();
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *rtRdmaDbSendTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_RDMA_DB_SEND, errorReason);
    NULL_PTR_RETURN_MSG(rtRdmaDbSendTask, errorReason);

    error = RdmaDbSendTaskInit(rtRdmaDbSendTask, dbIndex, dbInfo, taskSqe);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
        "Rdma db send task init failed, stream_id=%d, task_id=%hu, retCode=%#x.",
        streamId, rtRdmaDbSendTask->id, static_cast<uint32_t>(error));

    error = device_->SubmitTask(rtRdmaDbSendTask, taskGenCallback_);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Rdma db send task submit failed, retCode=%#x.", static_cast<uint32_t>(error));

    GET_THREAD_TASKID_AND_STREAMID(rtRdmaDbSendTask, streamId);

    return error;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtRdmaDbSendTask);
    return error;
}

rtError_t Context::RdmaDbSend(const uint32_t dbIndex, const uint64_t dbInfo, Stream * const stm)
{
    rtError_t error;
    if ((Runtime::Instance()->ChipIsHaveStars()) && (stm->IsCapturing())) {
        // lock the capture status of the stream.
        std::lock_guard<std::mutex> lock(captureLock_);
        if (stm->IsCapturing()) {
            for (uint32_t taskSeq = 0U; taskSeq < RT_STARS_MODEL_RDMADB_TASK_NUM; taskSeq++) {
                error = RdmaDbSendToDev(dbIndex, dbInfo, stm, (taskSeq + 1U));
                ERROR_RETURN_MSG_INNER(error, "send seq=%u rdmadb capture model task failed, retCode=%#x",
                    taskSeq, static_cast<uint32_t>(error));
            }
            return RT_ERROR_NONE;
        }
    }
    if ((Runtime::Instance()->ChipIsHaveStars()) && (stm->GetBindFlag())) {
        for (uint32_t taskSeq = 0U; taskSeq < RT_STARS_MODEL_RDMADB_TASK_NUM; taskSeq++) {
            error = RdmaDbSendToDev(dbIndex, dbInfo, stm, (taskSeq + 1U));
            ERROR_RETURN_MSG_INNER(error, "send seq=%u rdmadb model task failed, retCode=%#x", taskSeq,
            static_cast<uint32_t>(error));
        }
    } else {
        error = RdmaDbSendToDev(dbIndex, dbInfo, stm);
        ERROR_RETURN_MSG_INNER(error, "send db send task failed, retCode=%#x", static_cast<uint32_t>(error));
    }

    return error;
}
}
}