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

namespace cce {
namespace runtime {
#if F_DESC("StarsCommonTask")
void ConstructDavidSqeForStarsCommonTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    StarsCommonTaskInfo * const starsCommTask = &(taskInfo->u.starsCommTask);
    Stream * const stm = taskInfo->stream;
    starsCommTask->commonStarsSqe.commonDavidSqe.sqeHeader.reserved = 0U;
    starsCommTask->commonStarsSqe.commonDavidSqe.sqeHeader.ie = 0U;
    starsCommTask->commonStarsSqe.commonDavidSqe.sqeHeader.preP = 0U;
    starsCommTask->commonStarsSqe.commonDavidSqe.sqeHeader.postP =
        ((starsCommTask->flag & RT_KERNEL_DUMPFLAG) != 0U) ? 1U : 0U;
    starsCommTask->commonStarsSqe.commonDavidSqe.sqeHeader.wrCqe = taskInfo->stream->GetStarsWrCqeFlag();
    starsCommTask->commonStarsSqe.commonDavidSqe.sqeHeader.headUpdate = 0U;

    const errno_t error = memcpy_s(davidSqe, sizeof(rtDavidSqe_t),
        &starsCommTask->commonStarsSqe.commonDavidSqe, sizeof(starsCommTask->commonStarsSqe.commonDavidSqe));
    if (error != EOK) {
        davidSqe->commonSqe.sqeHeader.type = RT_STARS_SQE_TYPE_INVALID;
        RT_LOG_INNER_MSG(RT_LOG_ERROR,
            "Failed to call memcpy_s to copy commonStarsSqe.commonDavidSqe, src=%p, dest=%p, dest_max=%lu, "
            "count=%lu, retCode=%#x.",
            &starsCommTask->commonStarsSqe.commonDavidSqe, davidSqe, static_cast<unsigned long>(sizeof(rtDavidSqe_t)),
            static_cast<unsigned long>(sizeof(starsCommTask->commonStarsSqe.commonDavidSqe)), static_cast<uint32_t>(error));
    }
    ConstructDavidSqeForWordOne(taskInfo, davidSqe);
    PrintDavidSqe(davidSqe, "StarsCommonTask");
    RT_LOG(RT_LOG_INFO, "StarsCommonTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u.",
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id, taskInfo->taskSn);
}
#endif
}  // namespace runtime
}  // namespace cce
