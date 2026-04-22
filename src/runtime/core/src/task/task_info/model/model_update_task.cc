/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "base.hpp"
#include "task_info.hpp"
#include "model_update_task.h"

namespace cce {
namespace runtime {

#if F_DESC("ModelTaskUpdate")
void ToCommandBodyForModelUpdateTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    MdlUpdateTaskInfo *mdlUpdateTaskInfo = &(taskInfo->u.mdlUpdateTask);
    command->u.modelUpdateTask.destaskId = static_cast<uint16_t>(mdlUpdateTaskInfo->destaskId);
    command->u.modelUpdateTask.desStreamId = mdlUpdateTaskInfo->desStreamId;
    command->u.modelUpdateTask.tilingKeyOffset = mdlUpdateTaskInfo->tilingKeyOffset;
    command->u.modelUpdateTask.tilingTabOffset = mdlUpdateTaskInfo->tilingTabOffset;
    command->u.modelUpdateTask.blockDimOffset = mdlUpdateTaskInfo->blockDimOffset;
    command->u.modelUpdateTask.tilingTabLen = mdlUpdateTaskInfo->tilingTabLen;

    Stream *const stm = taskInfo->stream;
    RT_LOG(RT_LOG_DEBUG,
        "task_id=%u, stream_id=%u, taskId=%u, streamId=%u, [offset]tilingKey=%llu, blockDim=%llu, tilingTab=%llu.",
        taskInfo->id, static_cast<uint16_t>(stm->Id_()), mdlUpdateTaskInfo->destaskId, mdlUpdateTaskInfo->desStreamId,
        mdlUpdateTaskInfo->tilingKeyOffset, mdlUpdateTaskInfo->blockDimOffset, mdlUpdateTaskInfo->tilingTabOffset);

    return;
}

rtError_t SetMixDescBufOffset(const TaskInfo * const taskInfo, const uint16_t desStreamId,
    const uint16_t destaskId, uint64_t * const descBufOffset)
{
    Device *const dev = taskInfo->stream->Device_();
    TaskInfo *const destTask = dev->GetTaskFactory()->GetTask(static_cast<int32_t>(desStreamId), destaskId);
    if ((!dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_FFTS_PLUS)) || (destTask == nullptr)) {
        RT_LOG(RT_LOG_INFO,
            "chipType is not cloudV2 or dest task is nullptr, process according to non-mix, desStreamId=%u, destaskId=%u.",
            desStreamId, destaskId);
        return RT_ERROR_NONE;
    }

    rtError_t error = RT_ERROR_NONE;
    // only mix need translate descAlignBuf
    if (destTask->type == TS_TASK_TYPE_FFTS_PLUS) {
        RT_LOG(RT_LOG_INFO, "ffts plus senario, desStreamId=%u, destaskId=%u", desStreamId, destaskId);
        error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(static_cast<int32_t>(dev->Id_()),
            reinterpret_cast<uintptr_t>(destTask->u.fftsPlusTask.descAlignBuf), descBufOffset);
    } else if ((destTask->type == TS_TASK_TYPE_KERNEL_AICORE) && (destTask->u.aicTaskInfo.kernel != nullptr) &&
        (destTask->u.aicTaskInfo.kernel->GetMixType() != NO_MIX)) {
        RT_LOG(RT_LOG_INFO, "aicore mix senario, desStreamId=%u, destaskId=%u", desStreamId, destaskId);
        error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(static_cast<int32_t>(dev->Id_()),
            reinterpret_cast<uintptr_t>(destTask->u.aicTaskInfo.descAlignBuf), descBufOffset);
    } else {
        RT_LOG(RT_LOG_INFO, "no mix senario. taskType=%u, desStreamId=%u, destaskId=%u",
            destTask->type, desStreamId, destaskId);
    }

    return error;
}

rtError_t ModelTaskUpdateInit(TaskInfo *taskInfo, uint16_t desStreamId, uint32_t destaskId, uint16_t exeStreamId,
                              void *devCopyMem, uint32_t tilingTabLen, rtMdlTaskUpdateInfo_t *para)
{
    uint64_t descBufOffset = MAX_UINT64_NUM;
    Stream * const stm = taskInfo->stream;
    MdlUpdateTaskInfo *mdlUpdateTaskInfo = &(taskInfo->u.mdlUpdateTask);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_MODEL_TASK_UPDATE;
    taskInfo->typeName = "MODEL_TASK_UPDATE";
    taskInfo->isNeedStreamSync = false;
    mdlUpdateTaskInfo->desStreamId = desStreamId;
    mdlUpdateTaskInfo->destaskId = destaskId;
    mdlUpdateTaskInfo->exeStreamId = exeStreamId;
    mdlUpdateTaskInfo->tilingTabLen = tilingTabLen;
    mdlUpdateTaskInfo->tilingTabAddr = devCopyMem;
    mdlUpdateTaskInfo->prgHandle = para->hdl;
    mdlUpdateTaskInfo->fftsPlusTaskDescBuf = nullptr;
    mdlUpdateTaskInfo->blockDimAddr = nullptr;
    mdlUpdateTaskInfo->tilingKeyAddr = nullptr;

    RT_LOG(RT_LOG_INFO, "desStreamId=%u, destaskId=%u exeStreamId=%u,tilingTabLen=%u",
        desStreamId, destaskId, exeStreamId, tilingTabLen);
    if (!stm->Device_()->IsDavidPlatform()) {
        uint64_t tilingTaboffset = 0ULL;
        uint64_t tilingKeyOffset = 0ULL;
        uint64_t blockDimOffset = 0ULL;
        rtError_t error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(
            static_cast<int32_t>(taskInfo->stream->Device_()->Id_()),
            reinterpret_cast<uintptr_t>(para->tilingKeyAddr), &tilingKeyOffset);
        ERROR_RETURN_MSG_INNER(error, "MemAddressTranslate error=%d", error);

        error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(
            static_cast<int32_t>(taskInfo->stream->Device_()->Id_()),
            reinterpret_cast<uintptr_t>(para->blockDimAddr), &blockDimOffset);
        ERROR_RETURN_MSG_INNER(error, "MemAddressTranslate error=%d", error);

        error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(
            static_cast<int32_t>(taskInfo->stream->Device_()->Id_()),
            reinterpret_cast<uintptr_t>(devCopyMem), &tilingTaboffset);
        ERROR_RETURN_MSG_INNER(error, "MemAddressTranslate error=%d", error);

        if ((para->fftsPlusTaskInfo != nullptr) && (para->fftsPlusTaskInfo->descBuf != nullptr)) {
            error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(
                static_cast<int32_t>(taskInfo->stream->Device_()->Id_()),
                reinterpret_cast<uintptr_t>(para->fftsPlusTaskInfo->descBuf), &descBufOffset);
            mdlUpdateTaskInfo->fftsPlusTaskDescBuf = RtPtrToUnConstPtr<void *>(para->fftsPlusTaskInfo->descBuf);
        } else {
            error = SetMixDescBufOffset(taskInfo, desStreamId, destaskId, &descBufOffset);
        }
        ERROR_RETURN_MSG_INNER(error, "descBuf MemAddressTranslate error=%d", error);

        mdlUpdateTaskInfo->descBufOffset = descBufOffset;
        mdlUpdateTaskInfo->tilingKeyOffset = tilingKeyOffset;
        mdlUpdateTaskInfo->blockDimOffset = blockDimOffset;
        mdlUpdateTaskInfo->tilingTabOffset = tilingTaboffset;
        mdlUpdateTaskInfo->blockDimAddr = para->blockDimAddr;
        mdlUpdateTaskInfo->tilingKeyAddr = para->tilingKeyAddr;
        return RT_ERROR_NONE;
    }
    // david process
    mdlUpdateTaskInfo->tilingKeyOffset = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(para->tilingKeyAddr));
    mdlUpdateTaskInfo->blockDimOffset = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(para->blockDimAddr));
    mdlUpdateTaskInfo->tilingTabOffset = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(devCopyMem));
    return RT_ERROR_NONE;
}
#endif

}  // namespace runtime
}  // namespace cce