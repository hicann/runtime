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
#include "stars_david.hpp"
#include "maintenance_task.h"

namespace cce {
namespace runtime {

#if F_DESC("MaintenanceTask")
void ConstructDavidSqeForMaintenanceTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    MaintenanceTaskInfo * const maintenanceTaskInfo = &(taskInfo->u.maintenanceTaskInfo);
    Stream * const stream = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const sqe = &(davidSqe->phSqe);

    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    if (maintenanceTaskInfo->flag && (maintenanceTaskInfo->mtType == MT_STREAM_RECYCLE_TASK)) {
        sqe->u.maintainceInfo.subType = FORCE_RECYCLE_TASK_FLAG;
        sqe->u.maintainceInfo.targetId = static_cast<uint16_t>(maintenanceTaskInfo->mtId);
        sqe->header.preP = 1U; // for force recycle
    } else {
        sqe->header.preP = 0U;
    }
    sqe->header.wrCqe = 1U;       // need write cqe for recycle task
    sqe->taskType = TS_TASK_TYPE_MAINTENANCE;

    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;

    PrintDavidSqe(davidSqe, "MaintenanceTask");
    RT_LOG(RT_LOG_INFO, "MaintenanceTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u.",
        taskInfo->stream->Device_()->Id_(), stream->Id_(), taskInfo->id, taskInfo->taskSn);
}

#endif

}  // namespace runtime
}  // namespace cce
