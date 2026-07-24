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
#include "runtime.hpp"
#include "context.hpp"
#include "stars.hpp"
#include "maintenance_task.h"
#include "runtime_task_manager.h"

namespace cce {
namespace runtime {

#if F_DESC("MaintenanceTask")
static void ConstructSqeForMaintenanceTask(TaskInfo* const taskInfo, rtStarsSqe_t* const command)
{
    Stream* const stm = taskInfo->stream;
    (void)memset_s(command, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    RtStarsPhSqe* sqe = &(command->phSqe);
    sqe->header.type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->header.wrCqe = 1U; // need write cqe
    sqe->header.preP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    sqe->header.u.sqeSubType = RT_SQE_SUBTYPE_RESERVED;
    sqe->header.rtStreamId = static_cast<uint16_t>(stm->Id_());
    sqe->header.taskId = taskInfo->id;

    PrintSqe(command, "MaintenanceTask");
    RT_LOG(
        RT_LOG_INFO, "MaintenanceTask, sqeType=%u, wrCqe=%u, preP=%u, rtStreamId=%u, taskId=%u, sqeSubType=%u.",
        sqe->header.type, sqe->header.wrCqe, sqe->header.preP, sqe->header.rtStreamId, sqe->header.taskId,
        sqe->header.u.sqeSubType);
}
#endif

static bool MaintenanceTaskRegister()
{
    TaskFuncSingle maintenanceFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForMaintenanceTask,
        .doCompleteSuccFunc = nullptr,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };

    RegTaskFunc(CHIP_5162A, TS_TASK_TYPE_MAINTENANCE, maintenanceFuncs);
    return true;
}

static bool g_maintenanceTaskRegister = MaintenanceTaskRegister();

} // namespace runtime
} // namespace cce
