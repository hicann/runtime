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
#include "device.hpp"
#include "kernel.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "error_message_manage.hpp"
#include "memcpy_c.hpp"

namespace cce {
namespace runtime {

namespace TaskHandlers {
void HandleModelTaskUpdate(TaskInfo * const task, DeviceSnapshot *snapshot) {
    MdlUpdateTaskInfo* info = &(task->u.mdlUpdateTask);
    const size_t size = info->tilingTabLen * sizeof(TilingTabl);
    snapshot->AddOpVirtualAddr(info->tilingTabAddr, size);
    snapshot->AddOpVirtualAddr(info->tilingKeyAddr, sizeof(uint64_t));
    snapshot->AddOpVirtualAddr(info->blockDimAddr, sizeof(uint64_t));
}
}

void DeviceSnapshot::RecordArgsAddrAndSize(TaskInfo * const task)
{
    if (task->type == TS_TASK_TYPE_KERNEL_AICORE || task->type == TS_TASK_TYPE_KERNEL_AIVEC) {
        // mix scene
        if ((task->u.aicTaskInfo.kernel != nullptr) &&
            (task->u.aicTaskInfo.kernel->GetMixType() != NO_MIX)) {
                void *contextAddr = task->u.aicTaskInfo.descAlignBuf;
                AddOpVirtualAddr(contextAddr, static_cast<size_t>(sizeof(rtFftsPlusMixAicAivCtx_t)));
        } 
        // no mix scene
        void *args = task->u.aicTaskInfo.comm.args;
        const size_t size = task->u.aicTaskInfo.comm.argsSize;
        AddOpVirtualAddr(args, static_cast<size_t>(size));
    } else if (task->type == TS_TASK_TYPE_KERNEL_AICPU) {
        void *args = task->u.aicpuTaskInfo.comm.args;
        const size_t size = task->u.aicpuTaskInfo.comm.argsSize;
        AddOpVirtualAddr(args, static_cast<size_t>(size));
    } else if (task->type == TS_TASK_TYPE_FFTS_PLUS) {
        FftsPlusTaskInfo *fftsPlusTask = &task->u.fftsPlusTask;
        void* contextAddr = fftsPlusTask->descAlignBuf;
        const size_t size = fftsPlusTask->descBufLen;
        AddOpVirtualAddr(contextAddr, static_cast<size_t>(size));
    } else {
        // do nothing
    }
    return;
}

void DeviceSnapshot::RecordOpAddrAndSize(const Stream * const stm)
{
    const std::vector<uint16_t>& taskIds = stm->GetDelayRecycleTaskId();
    const size_t size = taskIds.size();
    Device *dev = stm->Device_();
    for (uint16_t i = 0U; i < size; i++) {
        const uint16_t taskId = taskIds[i];
        TaskInfo *task = dev->GetTaskFactory()->GetTask(stm->Id_(), taskId);
        if (task == nullptr) {
            RT_LOG(RT_LOG_WARNING, "get task is nullptr, stream_id=%d, task_id=%u.", stm->Id_(), taskId);
            continue;
        }
        RT_LOG(RT_LOG_DEBUG, "stream_id==%d, task_id=%u, type=%d.", stm->Id_(), taskId, task->type);
        RecordArgsAddrAndSize(task);
        RecordFuncCallAddrAndSize(task);
    }
    return;
}

const DeviceSnapshot::TaskHandlerFuncMap& DeviceSnapshot::GetHandlerMap() const
{
    static const TaskHandlerFuncMap handlerMap = {
        {TS_TASK_TYPE_STREAM_SWITCH, &TaskHandlers::HandleStreamSwitch},
        {TS_TASK_TYPE_STREAM_LABEL_SWITCH_BY_INDEX, &TaskHandlers::HandleStreamLabelSwitchByIndex},
        {TS_TASK_TYPE_MEM_WAIT_VALUE, &TaskHandlers::HandleMemWaitValue},
        {TS_TASK_TYPE_CAPTURE_WAIT, &TaskHandlers::HandleMemWaitValue},
        {TS_TASK_TYPE_RDMA_PI_VALUE_MODIFY, &TaskHandlers::HandleRdmaPiValueModify},
        {TS_TASK_TYPE_STREAM_ACTIVE, &TaskHandlers::HandleStreamActive},
        {TS_TASK_TYPE_MODEL_TASK_UPDATE, &TaskHandlers::HandleModelTaskUpdate}};
    return handlerMap;
}

} // namespace runtime
} // namespace cce
