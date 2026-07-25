/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream.hpp"
#include "debug_task.h"
#include "task_info_v100.h"
#include "runtime_task_manager.h"

namespace cce {
namespace runtime {

#if F_DESC("ProfilingEnableTask")
void ConstructSqeForProfilingEnableTask(TaskInfo* const taskInfo, rtStarsSqe_t* const command)
{
    ProfilingEnableTaskInfo* const profilingEnableTaskInfo = &(taskInfo->u.profilingEnableTaskInfo);
    Stream* const stm = taskInfo->stream;
    (void)memset_s(command, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    RtStarsPhSqe* sqe = &(command->phSqe);
    sqe->header.type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->header.wrCqe = stm->GetStarsWrCqeFlag();
    sqe->header.preP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    sqe->header.u.sqeSubType = RT_SQE_SUBTYPE_PROFILER_DYNAMIC_ENABLE;
    sqe->header.rtStreamId = static_cast<uint16_t>(stm->Id_());
    sqe->header.taskId = taskInfo->id;
    PrintSqe(command, "ProfilingEnableTask");
    RT_LOG(
        RT_LOG_INFO,
        "Launch ProfilingEnableTask succ, "
        "sqeType=%u, wrCqe=%d, preP=%u, rtStreamId=%u, taskId=%u, sqeSubType=%u, pid=%u.",
        sqe->header.type, sqe->header.wrCqe, sqe->header.preP, sqe->header.rtStreamId, sqe->header.taskId,
        sqe->header.u.sqeSubType, profilingEnableTaskInfo->pid);
}
#endif

#if F_DESC("ProfilingDisableTask")
void ConstructSqeForProfilingDisableTask(TaskInfo* const taskInfo, rtStarsSqe_t* const command)
{
    ProfilingDisableTaskInfo* const profilingDisableTaskInfo = &(taskInfo->u.profilingDisableTaskInfo);
    Stream* const stm = taskInfo->stream;
    (void)memset_s(command, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    RtStarsPhSqe* sqe = &(command->phSqe);
    sqe->header.type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->header.wrCqe = stm->GetStarsWrCqeFlag();
    sqe->header.preP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    sqe->header.u.sqeSubType = RT_SQE_SUBTYPE_PROFILER_DYNAMIC_DISABLE;
    sqe->header.rtStreamId = static_cast<uint16_t>(stm->Id_());
    sqe->header.taskId = taskInfo->id;
    PrintSqe(command, "ProfilingDisableTask");
    RT_LOG(
        RT_LOG_INFO,
        "Launch ProfilingDisableTask succ, "
        "sqeType=%u, wrCqe=%d, preP=%u, rtStreamId=%u, taskId=%u, sqeSubType=%u, pid=%u.",
        sqe->header.type, sqe->header.wrCqe, sqe->header.preP, sqe->header.rtStreamId, sqe->header.taskId,
        sqe->header.u.sqeSubType, profilingDisableTaskInfo->pid);
}
#endif

#if F_DESC("ProfilingTaskRegister")
static bool ProfilingTaskRegister()
{
    TaskFuncSingle profilingEnableFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForProfilingEnableTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };

    TaskFuncSingle profilingDisableFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForProfilingDisableTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };

    RegTaskFunc(CHIP_5162A, TS_TASK_TYPE_PROFILING_ENABLE, profilingEnableFuncs);
    RegTaskFunc(CHIP_5162A, TS_TASK_TYPE_PROFILING_DISABLE, profilingDisableFuncs);

    return true;
}

static bool g_profilingTaskRegister = ProfilingTaskRegister();
#endif

} // namespace runtime
} // namespace cce
