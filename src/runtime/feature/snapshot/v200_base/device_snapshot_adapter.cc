/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "device_snapshot.hpp"
#include "stream.hpp"
#include "stream_david.hpp"
#include "device.hpp"
#include "kernel.hpp"
#include "runtime.hpp"
#include "task_res_da.hpp"
#include "task_recycle.hpp"
#include "context.hpp"
#include "inner_thread_local.hpp"
#include "error_message_manage.hpp"


namespace cce {
namespace runtime {

// TaskHandlers namespace contains handler functions for different task types
// Used by RecordFuncCallAddrAndSize() to record virtual addresses for snapshot
// Each handler extracts task-specific addresses and adds them to the snapshot
namespace TaskHandlers {
void HandleModelTaskUpdate(TaskInfo * const task, DeviceSnapshot *snapshot) {
    MdlUpdateTaskInfo* info = &(task->u.mdlUpdateTask);
    const size_t size = info->tilingTabLen * sizeof(TilingTablForDavid);
    snapshot->AddOpVirtualAddr(info->tilingTabAddr, size);
    snapshot->AddOpVirtualAddr(RtPtrToPtr<void*>(info->tilingKeyOffset), sizeof(uint64_t));
    snapshot->AddOpVirtualAddr(RtPtrToPtr<void*>(info->blockDimOffset), sizeof(uint64_t));
}
}

void DeviceSnapshot::RecordOpAddrAndSize(const Stream * const stm)
{
    uint16_t head = 0U;
    uint16_t tail = 0U;
    static_cast<const DavidStream *>(stm)->GetTaskQueueHeadTail(head, tail);

    RT_LOG(RT_LOG_INFO, "stream_id=%d, head=%hu, tail=%hu.", stm->Id_(), head, tail);
    TaskInfo *nextTask = nullptr;
    for (uint32_t i = head; i < tail;) {
        nextTask = GetTaskInfo(stm->Device_(), stm->Id_(), i);
        if (unlikely(nextTask == nullptr)) {
            i++;
            continue;
        }
        RT_LOG(RT_LOG_DEBUG, "stream_id=%d, task_id=%u, type=%d.", stm->Id_(), nextTask->id, nextTask->type);
        RecordArgsAddrAndSize(nextTask);
        RecordFuncCallAddrAndSize(nextTask);
        i = stm->IsSoftwareSqEnable() || stm->IsAutoSplitSq() ? (static_cast<uint32_t>(nextTask->id) + 1U) :
            (static_cast<uint32_t>(nextTask->id) + nextTask->sqeNum);
    }
}

void DeviceSnapshot::RecordArgsAddrAndSize(TaskInfo * const task)
{
    if (task->type == TS_TASK_TYPE_KERNEL_AICORE || task->type == TS_TASK_TYPE_KERNEL_AIVEC) {
        void *args = task->u.aicTaskInfo.comm.args;
        const size_t size = task->u.aicTaskInfo.comm.argsSize;
        AddOpVirtualAddr(args, static_cast<size_t>(size));
    } else if (task->type == TS_TASK_TYPE_KERNEL_AICPU) {
        void *args = task->u.aicpuTaskInfo.comm.args;
        const size_t size = task->u.aicpuTaskInfo.comm.argsSize;
        AddOpVirtualAddr(args, static_cast<size_t>(size));
    } else if (task->type == TS_TASK_TYPE_FUSION_KERNEL) {
        void *args = task->u.fusionKernelTask.args;
        const size_t size = task->u.fusionKernelTask.argsSize;
        AddOpVirtualAddr(args, static_cast<size_t>(size));
    }
}

const DeviceSnapshot::TaskHandlerFuncMap& DeviceSnapshot::GetHandlerMap() const
{
    static const TaskHandlerFuncMap handlerMap = {
        {TS_TASK_TYPE_STREAM_SWITCH, &TaskHandlers::HandleStreamSwitch},
        {TS_TASK_TYPE_STREAM_LABEL_SWITCH_BY_INDEX, &TaskHandlers::HandleStreamLabelSwitchByIndex},
        {TS_TASK_TYPE_MEM_WAIT_VALUE, &TaskHandlers::HandleMemWaitValue},
        {TS_TASK_TYPE_CAPTURE_WAIT, &TaskHandlers::HandleMemWaitValue},
        {TS_TASK_TYPE_STREAM_ACTIVE, &TaskHandlers::HandleStreamActive},
        {TS_TASK_TYPE_MODEL_TASK_UPDATE, &TaskHandlers::HandleModelTaskUpdate}
    };
    return handlerMap;
}

} // namespace runtime
} // namespace cce
