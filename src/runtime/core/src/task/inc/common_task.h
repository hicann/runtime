/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RUNTIME_STARS_COMMON_TASK_H
#define RUNTIME_STARS_COMMON_TASK_H

#include "driver.hpp"
#include "stars.hpp"
#include "task_info.hpp"

namespace cce {
namespace runtime {

template<typename T>
rtError_t StarsCommonTaskInit(TaskInfo* taskInfo, const T &sqe, const uint32_t flag)
{
    TaskCommonInfoInit(taskInfo);

    StarsCommonTaskInfo *starsCommTask = &taskInfo->u.starsCommTask;

    taskInfo->typeName = const_cast<char_t*>("STARS_COMMON");
    taskInfo->type = TS_TASK_TYPE_STARS_COMMON;
    starsCommTask->flag = RT_KERNEL_DEFAULT;
    starsCommTask->cmdList = nullptr;
    starsCommTask->errorTimes = 0U;
    starsCommTask->srcDevAddr = nullptr;

    const uint16_t sqeType = sqe.sqeHeader.type;
    if (!IsSupportType(sqeType)) {
        RT_LOG(RT_LOG_ERROR, "StarsCommonTask does not support type[%hu]", sqeType);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    starsCommTask->flag = flag;
    const errno_t error = memcpy_s(&starsCommTask->commonStarsSqe.commonSqe,
        sizeof(starsCommTask->commonStarsSqe.commonSqe), &sqe, sizeof(sqe));
    if (error != EOK) {
        RT_LOG(RT_LOG_ERROR, "copy to starsSqe failed,ret=%d,src size=%zu,dst size=%zu",
               error, sizeof(sqe), sizeof(starsCommTask->commonStarsSqe.commonSqe));
        return RT_ERROR_SEC_HANDLE;
    }

    if (!IsDvppTask(sqeType)) {
        return RT_ERROR_NONE;
    }

    const uint64_t cmdListAddrLow =
        starsCommTask->commonStarsSqe.commonSqe.commandCustom[STARS_DVPP_SQE_CMDLIST_ADDR_LOW_IDX];
    const uint64_t cmdListAddrHigh =
        starsCommTask->commonStarsSqe.commonSqe.commandCustom[STARS_DVPP_SQE_CMDLIST_ADDR_HIGH_IDX];
    // the dvpp has malloced the cmdlist memory.
    starsCommTask->cmdList = RtValueToPtr<void *>(((cmdListAddrHigh << UINT32_BIT_NUM) & 0xFFFFFFFF00000000ULL) |
        (cmdListAddrLow & 0x00000000FFFFFFFFULL));
    if (starsCommTask->cmdList == nullptr) {
        RT_LOG(RT_LOG_ERROR, "cmdList addr is null.");
        return RT_ERROR_INVALID_VALUE ;
    }
    if ((starsCommTask->flag & RT_KERNEL_CMDLIST_NOT_FREE) == 0U) {
        taskInfo->needPostProc = true;
    }

    RT_LOG(RT_LOG_INFO, "dvpp type=%hu,need to write value=%u, needPostProc=%u.", sqeType, sqe.sqeHeader.reserved, taskInfo->needPostProc);
    return RT_ERROR_NONE;
}

void PrintDsaErrorInfoForStarsCommonTask(TaskInfo* taskInfo);
void StarsCommonTaskUnInit(TaskInfo * const taskInfo);
void PrintErrorInfoForStarsCommonTask(TaskInfo* taskInfo, const uint32_t devId);

// dsa and dvpp are stars common task
rtError_t GetIsCmdListNotFreeValByDvppCfg(rtDvppCfg_t *cfg, bool &isCmdListNotFree);
rtError_t WriteValueTaskInit(TaskInfo *taskInfo, uint64_t addr, WriteValueSize size,
                             uint8_t *value, TaskWrCqeFlag cqeFlag);
rtError_t WriteValuePtrTaskInit(TaskInfo* taskInfo, const void* const pointedAddr, TaskWrCqeFlag cqeFlag);
rtError_t CaptureRecordExternalTaskInit(TaskInfo* taskInfo, const void* const recordSlotAddr, TaskWrCqeFlag cqeFlag);
void CommonCmdTaskInit(TaskInfo * const taskInfo, const PhCmdType cmdType, const CommonCmdTaskInfo *cmdInfo);
}  // namespace runtime
}  // namespace cce
#endif  // RUNTIME_STARS_COMMON_TASK_H
