/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "task_info_v100.h"
#include "memory_task.h"
#include "common_task.h"
#include "stream.hpp"
#include "task_manager.h"
#include "stars_cond_isa_helper.hpp"

namespace cce {
namespace runtime {
namespace {
constexpr uint8_t MEM_WAIT_SQE_INDEX_0 = 0U;
constexpr uint8_t MEM_WAIT_SQE_INDEX_1 = 1U;
constexpr uint8_t MEM_WAIT_SQE_INDEX_2 = 2U;
constexpr uint8_t MEM_WAIT_SQE_INDEX_3 = 3U;

void ConstructLastSqeForExternalWaitTask(TaskInfo* taskInfo, rtStarsSqe_t *const command,
                                         const RtStarsMemWaitValueInstrFcPara &fcPara)
{
    MemWaitValueTaskInfo *memWaitValueTask = &taskInfo->u.memWaitValueTask;
    RtStarsFunctionCallSqe &sqe = command->fuctionCallSqe;

    (void)memset_s(&sqe, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));

    RtStarsExternalWaitFuncCall fc = {};
    constexpr uint64_t funcCallSize = static_cast<uint64_t>(sizeof(RtStarsExternalWaitFuncCall));
    RtStarsExternalWaitFuncCallPara externalPara = {};
    externalPara.waitRefreshAddr = fcPara.devAddr;
    externalPara.maxLoop = fcPara.maxLoop;
    externalPara.sqIdMemAddr = fcPara.sqIdMemAddr;
    externalPara.sqRegAddrArray = fcPara.sqRegAddrArray;
    externalPara.sqTailOffset = fcPara.sqTailOffset;
    externalPara.profSwitchAddr = fcPara.profSwitchAddr;
    externalPara.sqId = fcPara.sqId;
    externalPara.sqHeadPre = fcPara.sqHeadPre;
    externalPara.sqHeadNext = fcPara.sqHeadNext;
    externalPara.lastSqePos = fcPara.lastSqePos;
    externalPara.bindFlag = fcPara.bindFlag;
    ConstructExternalWaitFuncCall(fc, externalPara);
    const rtError_t ret = taskInfo->stream->Device_()->Driver_()->MemCopySync(memWaitValueTask->funcCallSvmMem2,
        memWaitValueTask->funCallMemSize2, &fc, funcCallSize, RT_MEMCPY_HOST_TO_DEVICE);
    if (ret != RT_ERROR_NONE) {
        sqe.sqeHeader.type = RT_STARS_SQE_TYPE_INVALID;
        return;
    }

    FillMemWaitFunctionCallSqe(taskInfo, sqe, funcCallSize);
    PrintSqe(command, "CaptureWaitExternalTask last sqe");
}

void ConstructSqeForCaptureWaitExternalTask(TaskInfo* taskInfo, rtStarsSqe_t* const command)
{
    RtStarsMemWaitValueInstrFcPara fcPara = {};
    InitFuncCallParaForMemWaitTask(taskInfo, fcPara);

    ConstructSqeForNopTask(taskInfo, &(command[MEM_WAIT_SQE_INDEX_0]));
    ConstructSecondSqeForMemWaitValueTask(taskInfo, &(command[MEM_WAIT_SQE_INDEX_1]));
    ConstructLastSqeForExternalWaitTask(taskInfo, &(command[MEM_WAIT_SQE_INDEX_2]), fcPara);
    ConstructPhSqeForMemWaitValueTask(taskInfo, &(command[MEM_WAIT_SQE_INDEX_3]));
}
} // namespace

void RegisterCaptureExternalTaskFuncForV100(rtChipType_t chip)
{
    TaskFuncSingle captureRecordExternalFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForWriteValueTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle captureWaitExternalFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForCaptureWaitExternalTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = &MemWaitTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };

    RegTaskFunc(chip, TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL, captureRecordExternalFuncs);
    RegTaskFunc(chip, TS_TASK_TYPE_CAPTURE_WAIT_EXTERNAL, captureWaitExternalFuncs);
}
} // namespace runtime
} // namespace cce
