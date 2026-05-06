/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "runtime.hpp"
#include "context.hpp"
#include "task_manager.h"
#include "task_info_v100.h"
#include "stub_task.hpp"

namespace cce {
namespace runtime {
#if F_DESC("StarsCommonTask")
void ConstructSqeForStarsCommonTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    StarsCommonTaskInfo *starsCommTask = &taskInfo->u.starsCommTask;

    starsCommTask->commonStarsSqe.commonSqe.sqeHeader.task_id = taskInfo->id;
    starsCommTask->commonStarsSqe.commonSqe.sqeHeader.reserved = 0U; // must restore default value
    starsCommTask->commonStarsSqe.commonSqe.sqeHeader.rt_stream_id = static_cast<uint16_t>(taskInfo->stream->Id_());
    starsCommTask->commonStarsSqe.commonSqe.sqeHeader.ie = RT_STARS_SQE_INT_DIR_NO;
    starsCommTask->commonStarsSqe.commonSqe.sqeHeader.pre_p = RT_STARS_SQE_INT_DIR_NO;
    starsCommTask->commonStarsSqe.commonSqe.sqeHeader.post_p =
        ((starsCommTask->flag & RT_KERNEL_DUMPFLAG) != 0U) ? RT_STARS_SQE_INT_DIR_TO_TSCPU : RT_STARS_SQE_INT_DIR_NO;
    starsCommTask->commonStarsSqe.commonSqe.sqeHeader.wr_cqe = taskInfo->stream->GetStarsWrCqeFlag();

    const errno_t error = memcpy_s(command, sizeof(rtStarsSqe_t), &starsCommTask->commonStarsSqe.commonSqe,
        sizeof(starsCommTask->commonStarsSqe.commonSqe));
    if (error != EOK) {
        command->commonSqe.sqeHeader.type = RT_STARS_SQE_TYPE_INVALID;
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Failed to call memcpy_s to copy starsCommTask->commonStarsSqe.commonSqe,"
            " src=%p, dest=%p, dest_max=%zu, count=%zu, retCode=%#x.", &starsCommTask->commonStarsSqe.commonSqe, command,
            sizeof(rtStarsSqe_t), sizeof(starsCommTask->commonStarsSqe.commonSqe), error);
    }
    PrintSqe(command, "StarsCommonTask");
    RT_LOG(RT_LOG_INFO, "StarsCommonTask stream_id:%d,task_id:%hu", taskInfo->stream->Id_(), taskInfo->id);
}
#endif
}  // namespace runtime
}  // namespace cce
