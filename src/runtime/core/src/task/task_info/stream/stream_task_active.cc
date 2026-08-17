/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "stars_cond_isa_helper.hpp"
#include "stream_sqcq_manage.hpp"
#include "stream_task.h"
#include "stub_task.hpp"
#include "capture_model.hpp"
#include "runtime_task_manager.h"

namespace cce {
namespace runtime {

#if F_DESC("StreamActiveTask")

rtError_t AllocFuncCallMemForStreamActiveTask(TaskInfo* taskInfo)
{
    StreamActiveTaskInfo* streamActiveTask = &(taskInfo->u.streamactiveTask);
    streamActiveTask->funCallMemSize = static_cast<uint64_t>(sizeof(RtStarsStreamActiveFc));

    void* devMem = nullptr;
    const auto dev = taskInfo->stream->Device_();
    const uint64_t allocSize = streamActiveTask->funCallMemSize + TS_STARS_COND_DFX_SIZE + FUNC_CALL_INSTR_ALIGN_SIZE;
    const rtError_t ret = dev->Driver_()->DevMemAlloc(&devMem, allocSize, RT_MEMORY_DDR, dev->Id_());
    COND_RETURN_ERROR(
        (ret != RT_ERROR_NONE) || (devMem == nullptr), ret,
        "alloc func call memory failed,retCode=%#x,size=%" PRIu64 "(bytes),dev_id=%u", ret,
        streamActiveTask->funCallMemSize, dev->Id_());
    streamActiveTask->baseFuncCallSvmMem = devMem;
    // instr addr should align to 256b
    if ((RtPtrToValue<void*>(devMem) & 0xFFULL) != 0ULL) {
        // 2 ^ 8 is 256 align
        const uintptr_t devMemAlign = (((RtPtrToValue<void*>(devMem)) >> 8U) + 1UL) << 8U;
        devMem = RtPtrToPtr<void*, uintptr_t>(devMemAlign);
    }
    streamActiveTask->funcCallSvmMem = devMem;
    streamActiveTask->dfxPtr = RtPtrToPtr<void*, uint64_t>(
        RtPtrToPtr<uint64_t, void*>(streamActiveTask->funcCallSvmMem) + streamActiveTask->funCallMemSize);

    return RT_ERROR_NONE;
}

rtError_t FreeFuncCallMemForStreamActiveTask(TaskInfo* const taskInfo)
{
    StreamActiveTaskInfo* streamActiveTask = &(taskInfo->u.streamactiveTask);
    if (streamActiveTask->baseFuncCallSvmMem != nullptr) {
        const auto dev = taskInfo->stream->Device_();
        const rtError_t ret = dev->Driver_()->DevMemFree(streamActiveTask->baseFuncCallSvmMem, dev->Id_());
        COND_RETURN_ERROR(
            ret != RT_ERROR_NONE, ret, "Free func call svm mem free failed,retCode=%#x,dev_id=%u.", ret, dev->Id_());
        streamActiveTask->baseFuncCallSvmMem = nullptr;
        streamActiveTask->funcCallSvmMem = nullptr;
        streamActiveTask->dfxPtr = nullptr;
    }

    streamActiveTask->funCallMemSize = 0UL;
    return RT_ERROR_NONE;
}

rtError_t PrepareSqeInfoForStreamActiveTask(TaskInfo* taskInfo)
{
    RtStarsStreamActiveFc fc = {};
    rtStarsStreamActiveFcPara_t fcPara = {};
    StreamActiveTaskInfo* streamActiveTask = &(taskInfo->u.streamactiveTask);

    const rtChipType_t chipType = taskInfo->stream->Device_()->GetChipType();
    rtError_t ret = AllocFuncCallMemForStreamActiveTask(taskInfo);
    ERROR_RETURN(ret, "Alloc func call svm failed,retCode=%#x.", ret);

    if ((streamActiveTask->activeStreamSqId == UINT32_MAX) && streamActiveTask->activeStream->IsSoftwareSqEnable()) {
        CaptureModel* captureMdl = dynamic_cast<CaptureModel*>(streamActiveTask->activeStream->Model_());
        if (captureMdl != nullptr) {
            (void)captureMdl->MarkStreamActiveTask(taskInfo);
        } else {
            RT_LOG(
                RT_LOG_ERROR, "CaptureModel is null, active stream_id=%u, stream_id=%d, task_id=%u.",
                streamActiveTask->activeStreamId, taskInfo->stream->Id_(), taskInfo->id);
            return RT_ERROR_MODEL_NULL;
        }
        return RT_ERROR_NONE;
    }

    ret = InitFuncCallParaForStreamActiveTask(taskInfo, fcPara, chipType);
    ERROR_RETURN(ret, "Init func call para failed,retCode=%#x.", ret);

    ConstructStreamActiveFc(fc, fcPara, 0U);

    const rtMemcpyKind_t kind = (taskInfo->stream->Device_()->IsSupportFeature(
                                    RtOptionalFeatureType::RT_FEATURE_DEVICE_MEM_COPY_DOT_D2D_ONLY)) ?
                                    RT_MEMCPY_DEVICE_TO_DEVICE :
                                    RT_MEMCPY_HOST_TO_DEVICE;
    ret = taskInfo->stream->Device_()->Driver_()->MemCopySync(
        taskInfo->u.streamactiveTask.funcCallSvmMem, taskInfo->u.streamactiveTask.funCallMemSize, &fc,
        sizeof(RtStarsStreamActiveFc), kind);
    return ret;
}

rtError_t StreamActiveTaskInit(TaskInfo* taskInfo, const Stream* const stm)
{
    StreamActiveTaskInfo* streamActiveTask = &(taskInfo->u.streamactiveTask);
    Stream* const stream = taskInfo->stream;
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_STREAM_ACTIVE;
    taskInfo->typeName = "STREAM_ACTIVE";
    streamActiveTask->activeStreamId = static_cast<uint32_t>(stm->Id_());
    streamActiveTask->activeStream = const_cast<Stream*>(stm);
    streamActiveTask->activeStreamSqId = 0U;
    streamActiveTask->funcCallSvmMem = nullptr;
    streamActiveTask->baseFuncCallSvmMem = nullptr;
    streamActiveTask->dfxPtr = nullptr;
    streamActiveTask->funCallMemSize = 0UL;

    const bool starsFlag = stream->Device_()->IsStarsPlatform();
    if (starsFlag) {
        streamActiveTask->activeStreamSqId = stm->GetSqId();
        return PrepareSqeInfoForStreamActiveTask(taskInfo);
    }

    return RT_ERROR_NONE;
}

void StreamActiveTaskUnInit(TaskInfo* const taskInfo) { (void)FreeFuncCallMemForStreamActiveTask(taskInfo); }

void ToCommandBodyForStreamActiveTask(TaskInfo* taskInfo, rtCommand_t* const command)
{
    command->u.streamactiveTask.activeStreamId = static_cast<uint16_t>(taskInfo->u.streamactiveTask.activeStreamId);
}

void PrintErrorInfoForStreamActiveTask(TaskInfo* taskInfo, const uint32_t devId)
{
    const uint32_t taskId = taskInfo->id;
    const int32_t streamId = taskInfo->stream->Id_();
    Stream* const reportStream = GetReportStream(taskInfo->stream);
    if (taskInfo->stream->Device_()->IsStarsPlatform()) {
        uint64_t dfx[8U];
        (void)taskInfo->stream->Device_()->Driver_()->MemCopySync(
            dfx, sizeof(dfx), taskInfo->u.streamactiveTask.dfxPtr, sizeof(dfx), RT_MEMCPY_DEVICE_TO_HOST);
        RT_LOG(
            RT_LOG_ERROR,
            "stream_id=%u,task_id=%u,active_sq_id=%u,sqid=%" PRIu64 ",fsm_state=%" PRIu64 ",enable=%" PRIu64
            ",head=%" PRIu64 ",tail=%" PRIu64,
            streamId, taskId, taskInfo->u.streamactiveTask.activeStreamSqId, dfx[0U] & 0xFFFU, dfx[0U] >> 32U, dfx[1U],
            dfx[2U] >> 48U, dfx[3U] >> 48U);
    }

    STREAM_REPORT_ERR_MSG(
        reportStream, ERR_MODULE_GE, "StreamActiveTask execution failed, device_id=%u, stream_id=%d, %s=%u.", devId,
        streamId, TaskIdDesc(), taskId);
}

#endif
} // namespace runtime
} // namespace cce