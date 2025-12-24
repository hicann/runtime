/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "logger.hpp"
#include "osal.hpp"
#include "program.hpp"
#include "stream.hpp"
#include "event.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {

void EngineLogObserver::TaskSubmited(Device * const dev, TaskInfo * const tsk)
{
    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) == 0) {
        return;
    }

    const uint32_t deviceId = dev->Id_();
    const tsTaskType_t taskType = tsk->type;
    const uint16_t taskId = tsk->id;

    RT_LOG(RT_LOG_DEBUG, "device_id=%u, ts_id=%u, stream_id=%d, task_id=%hu, task_type=%u (%s).",
           deviceId, dev->DevGetTsId(), tsk->stream->Id_(), taskId, static_cast<uint32_t>(taskType),
           tsk->typeName);
}

void EngineLogObserver::KernelTaskEventLogProc(const uint32_t devId, const TaskInfo * const logProcTask,
    const char_t * const kernelType) const
{
    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) == 0) {
        return;
    }

    RT_LOG(RT_LOG_DEBUG, "device_id=%u, stream_id=%d, task_id=%hu, task_type=%s, task_launched_num=%" PRIu64,
           devId, logProcTask->stream->Id_(), logProcTask->id, kernelType, task_launched_num_);
}

void EngineLogObserver::TaskLaunched(const uint32_t devId, TaskInfo * const tsk, rtTsCommand_t * const command)
{
    task_launched_num_++;
    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) == 0) {
        return;
    }

    switch (tsk->type) {
        case TS_TASK_TYPE_KERNEL_AICORE: {
            KernelTaskEventLogProc(devId, tsk, "AiCoreKernel");
            break;
        }

        case TS_TASK_TYPE_KERNEL_AIVEC: {
            KernelTaskEventLogProc(devId, tsk, "AiVecKernel");
            break;
        }

        case TS_TASK_TYPE_KERNEL_AICPU: {
            KernelTaskEventLogProc(devId, tsk, "AiCpuKernel");
            break;
        }

        default: {
            TaskLaunchedEx(devId, tsk, command);
            break;
        }
    }
}

void EngineLogObserver::TaskLaunchedEx(const uint32_t devId, TaskInfo * const tsk, rtTsCommand_t * const command) const
{
    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) == 0) {
        return;
    }

    uint16_t tsCmdEventId = 0U;
    uint16_t notifyId = 0U;
    const bool isStarsCqe = (command->cmdType == RT_TASK_COMMAND_TYPE_STARS_SQE) ? true : false;

    switch (tsk->type) {
        case TS_TASK_TYPE_EVENT_RECORD: {
            tsCmdEventId = isStarsCqe ? command->cmdBuf.u.starsSqe[0].eventSqe.eventId :
                command->cmdBuf.cmd.u.eventRecordTask.eventID;
            RT_LOG(RT_LOG_DEBUG, "device_id=%u, stream_id=%d, task_id=%hu, event_id=%hu,"
                "task_type=EventRecord, task_launched_num=%" PRIu64,
                devId, tsk->stream->Id_(), tsk->id, tsCmdEventId, task_launched_num_);
            break;
        }

        case TS_TASK_TYPE_STREAM_WAIT_EVENT: {
            tsCmdEventId = isStarsCqe ? command->cmdBuf.u.starsSqe[0].eventSqe.eventId :
                command->cmdBuf.cmd.u.streamWaitEventTask.eventID;
            RT_LOG(RT_LOG_DEBUG, "device_id=%u, stream_id=%d, task_id=%hu, event_id=%hu,"
                "task_type=StreamWaitEvent, task_launched_num=%" PRIu64,
                devId, tsk->stream->Id_(), tsk->id, tsCmdEventId, task_launched_num_);
            break;
        }

        case TS_TASK_TYPE_NOTIFY_RECORD: {
            uint16_t deviceId = 0U;
            notifyId = isStarsCqe ? command->cmdBuf.u.starsSqe[0].notifySqe.notify_id :
                command->cmdBuf.cmd.u.notifyrecordTask.notifyId;
            deviceId = isStarsCqe ? 0U : command->cmdBuf.cmd.u.notifyrecordTask.deviceId;
            RT_LOG(RT_LOG_DEBUG, "device_id=%u, stream_id=%d, task_id=%hu, notify_id=%hu,"
                "notify_dev_id=%hu, task_type=NotifyRecord, task_launched_num=%" PRIu64,
                devId, tsk->stream->Id_(), tsk->id, notifyId, deviceId, task_launched_num_);
            break;
        }

        case TS_TASK_TYPE_NOTIFY_WAIT: {
            notifyId = isStarsCqe ? command->cmdBuf.u.starsSqe[0].notifySqe.notify_id :
                command->cmdBuf.cmd.u.notifywaitTask.notifyid;
            RT_LOG(RT_LOG_DEBUG, "device_id=%u, stream_id=%d, task_id=%hu, notify_id=%hu,"
                "task_type=NotifyWait, task_launched_num=%" PRIu64,
                devId, tsk->stream->Id_(), tsk->id, notifyId, task_launched_num_);
            break;
        }

        case TS_TASK_TYPE_MEMCPY: {
            RT_LOG(RT_LOG_DEBUG, "device_id=%u, stream_id=%d, task_id=%hu, task_type=Memcpy,"
                "task_launched_num=%" PRIu64,
                devId, tsk->stream->Id_(), tsk->id, task_launched_num_);
            break;
        }
        case TS_TASK_TYPE_REDUCE_ASYNC_V2: {
            RT_LOG(RT_LOG_DEBUG, "device_id=%u, stream_id=%d, task_id=%hu, task_type=ReduceAsyncV2,"
                "task_launched_num=%" PRIu64, devId, tsk->stream->Id_(), tsk->id, task_launched_num_);
            break;
        }

        default: {
            RT_LOG(RT_LOG_DEBUG,
                "device_id=%u, stream_id=%d, task_id=%hu, task_type=%d (%s), task_launched_num=%" PRIu64,
                devId, tsk->stream->Id_(), tsk->id, static_cast<int32_t>(tsk->type), tsk->typeName,
                task_launched_num_);
            break;
        }
    }
}

void EngineLogObserver::TaskFinished(const uint32_t devId, const TaskInfo * const tsk)
{
    task_finished_num_++;
    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_INFO) == 0) {
        return;
    }

    RT_LOG(RT_LOG_DEBUG, "device_id=%u, stream_id=%d, task_id=%hu, task_type=%d (%s), task_finish_num=%" PRIu64,
        devId, tsk->stream->Id_(), tsk->id, static_cast<int32_t>(tsk->type), tsk->typeName,
        task_finished_num_);
}
}
}
