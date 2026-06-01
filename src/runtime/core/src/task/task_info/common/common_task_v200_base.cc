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
#include "common_task.h"
#include "stars_david.hpp"
#include "task_manager.h"

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

#if F_DESC("WriteValueTask")
void InitWriteValueSqe(RtDavidStarsWriteValueSqe * const writeValueSqe,
    const rtWriteValueInfo_t * const writeValueInfo)
{
    const WriteValueSize awsize = WriteValueSize(static_cast<uint8_t>(writeValueInfo->size) - 1U);
    writeValueSqe->header.type = RT_DAVID_SQE_TYPE_WRITE_VALUE;
    writeValueSqe->awsize = awsize;
    writeValueSqe->snoop = 0U;
    writeValueSqe->awcache = 2U;  // 2U: 0010 Normal Non-cacheable Non-bufferable
    writeValueSqe->awprot = 0U;
    writeValueSqe->va = 1U;

    writeValueSqe->writeAddrLow = static_cast<uint32_t>(writeValueInfo->addr & MASK_32_BIT);
    writeValueSqe->writeAddrHigh = static_cast<uint32_t>((writeValueInfo->addr >> UINT32_BIT_NUM) & MASK_17_BIT);

    const uint32_t writeLen = static_cast<uint32_t>(1U << static_cast<uint32_t>(awsize));
    uint8_t value[WRITE_VALUE_SIZE_MAX_LEN] = {0U};   // max writen size is 4B*8=32B
    for (uint32_t i = 0U; i < writeLen; i++) {
        value[i] = writeValueInfo->value[i];
    }
    uint32_t *temp = RtPtrToPtr<uint32_t *>(value);
    for (uint32_t idx = 0U; idx < (WRITE_VALUE_SIZE_MAX_LEN/4U); idx++) { // 4U: sizeof(uint32_t)
        writeValueSqe->writeValuePart[idx] = temp[idx];
        RT_LOG(RT_LOG_INFO, "writeValuePart[%u]: %u", idx, writeValueSqe->writeValuePart[idx]);
    }

    PrintDavidSqe(RtPtrToPtr<rtDavidSqe_t *>(writeValueSqe), "WriteValueTask");

    return;
}

rtError_t WriteValuePtrTaskInit(TaskInfo *taskInfo, const void * const pointedAddr,
    TaskWrCqeFlag cqeFlag)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "WriteValuePtrTask";
    taskInfo->type = TS_TASK_TYPE_WRITE_VALUE;

    WriteValueTaskInfo *writeValTsk = &taskInfo->u.writeValTask;
    writeValTsk->sqeAddr = RtPtrToValue(pointedAddr);
    writeValTsk->cqeFlag = cqeFlag;
    writeValTsk->ptrFlag = 1U;

    return RT_ERROR_NONE;
}

static void ConstructWriteValueSqePtr(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    WriteValueTaskInfo *const writeValTsk = &(taskInfo->u.writeValTask);
    RtDavidStarsWriteValuePtrSqe * const evSqe = &(davidSqe->writeValuePtrSqe);

    evSqe->header.type = RT_DAVID_SQE_TYPE_WRITE_VALUE;
    switch (writeValTsk->cqeFlag) {
        case TASK_WR_CQE_DEFAULT:
            evSqe->header.wrCqe = taskInfo->stream->GetStarsWrCqeFlag();
            break;
        case TASK_WR_CQE_NEVER:
            evSqe->header.wrCqe = 0U;
            break;
        default:
            evSqe->header.wrCqe = 1U;
            break;
    }

    evSqe->header.ptrMode = 1U;
    evSqe->va = 1U;  // va only

    evSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;

    evSqe->writeValueNewSqeAddrLow = static_cast<uint32_t>(writeValTsk->sqeAddr & MASK_32_BIT);
    evSqe->writeValueNewSqeAddrHigh = static_cast<uint32_t>((writeValTsk->sqeAddr >> UINT32_BIT_NUM) & MASK_17_BIT);

    PrintDavidSqe(davidSqe, "WriteValueTaskPtr");
    RT_LOG(RT_LOG_DEBUG, "WriteValueTaskPtr, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, addr=%#." PRIx64,
        taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), taskInfo->id, taskInfo->taskSn,
        writeValTsk->sqeAddr);
}

void ConstructDavidSqeForWriteValueTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    WriteValueTaskInfo *const writeValTsk = &(taskInfo->u.writeValTask);
    if (writeValTsk->ptrFlag == 1U) {
        ConstructWriteValueSqePtr(taskInfo, davidSqe, sqBaseAddr);
        return;
    }

    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsWriteValueSqe * const evSqe = &(davidSqe->writeValueSqe);
    evSqe->header.type = RT_DAVID_SQE_TYPE_WRITE_VALUE;
    switch (writeValTsk->cqeFlag) {
        case TASK_WR_CQE_DEFAULT:
            evSqe->header.wrCqe = taskInfo->stream->GetStarsWrCqeFlag();
            break;
        case TASK_WR_CQE_NEVER:
            evSqe->header.wrCqe = 0U;
            break;
        default:
            evSqe->header.wrCqe = 1U;
            break;
    }
    evSqe->va = 1U;  // va only

    evSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    evSqe->awsize = writeValTsk->awSize;
    evSqe->snoop = 0U;
    evSqe->awcache = 2U;  // 2U: 0010 Normal Non-cacheable Non-bufferable
    evSqe->awprot = 0U;

    evSqe->writeAddrLow = static_cast<uint32_t>(writeValTsk->addr & MASK_32_BIT);
    evSqe->writeAddrHigh = static_cast<uint32_t>((writeValTsk->addr >> UINT32_BIT_NUM) & MASK_17_BIT);

    uint32_t *temp = RtPtrToPtr<uint32_t *>(writeValTsk->value);
    for (uint32_t idx = 0U; idx < (WRITE_VALUE_SIZE_MAX_LEN/4U); idx++) { // 4U: sizeof(uint32_t)
        evSqe->writeValuePart[idx] = temp[idx];
    }

    PrintDavidSqe(davidSqe, "WriteValueTask");
    RT_LOG(RT_LOG_DEBUG, "WriteValueTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, "
        "addr=%#." PRIx64, taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(),
        taskInfo->id, taskInfo->taskSn, writeValTsk->addr);
}
#endif

static bool CommonTaskRegister()
{
    TaskFuncSingle starsCommonFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = &StarsCommonTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForStarsCommonTask,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle writeValueFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle commonCmdFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };

    const auto& chips = GetDavidChips();
    for (auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_STARS_COMMON, starsCommonFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_WRITE_VALUE, writeValueFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_COMMON_CMD, commonCmdFuncs);
    }

    RegDavidSqeFunc(TS_TASK_TYPE_STARS_COMMON, &ConstructDavidSqeForStarsCommonTask);
    RegDavidSqeFunc(TS_TASK_TYPE_WRITE_VALUE, &ConstructDavidSqeForWriteValueTask);
    return true;
}

static bool g_commonTaskRegister = CommonTaskRegister();

}  // namespace runtime
}  // namespace cce
