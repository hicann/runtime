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
#include "sq_exec_times_addr_task.h"
#include "stars_david.hpp"
#include "david_sqe_adapter.hpp"
#include "runtime_task_manager.h"
#include "task_david.hpp"
#include "task_recycle.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {
#if F_DESC("SqExecTimesAddrTask")
static rtError_t ProcSqExecTimesAddrTask(Device* const dev, const uint64_t sqExecTimesAddr, const bool freeFlag)
{
    Stream* const stm = dev->GetCtrlSQStream(dev->PrimaryStream_());
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);

    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to check stream, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));

    TaskInfo* task = nullptr;
    uint32_t pos = 0xFFFFU;
    Stream* dstStm = stm;
    std::function<void()> const errRecycle = [&task, &dstStm, &pos, &stm]() {
        TaskUnInitProc(task);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();
    };
    stm->StreamLock();
    task = stm->AllocTask(nullptr, TS_TASK_TYPE_SQ_EXEC_TIMES_ADDR, error);
    COND_PROC_RETURN_ERROR_MSG_INNER(
        task == nullptr, error, stm->StreamUnLock(), "Failed to alloc task, stream_id=%d, retCode=%#x.", stm->Id_(),
        static_cast<uint32_t>(error));
    pos = task->id;
    dstStm = task->stream;

    error = SqExecTimesAddrTaskInit(task, sqExecTimesAddr, freeFlag);
    ScopeGuard taskGuard(errRecycle);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to init sq exec times addr task, stream_id=%d, retCode=%#x.", stm->Id_(),
        static_cast<uint32_t>(error));

    error = DavidSendTask(task, dstStm);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to submit sq exec times addr task, stream_id=%d, retCode=%#x.", stm->Id_(),
        static_cast<uint32_t>(error));

    taskGuard.ReleaseGuard();
    stm->StreamUnLock();
    return stm->Synchronize();
}

rtError_t SendTaskToSetSqExecTimesAddr(Device* const dev)
{
    NULL_PTR_RETURN(dev, RT_ERROR_DEVICE_NULL);
    void* const sqExecTimesAddr = dev->GetSqExecTimesSvmBaseAddr_();
    NULL_PTR_RETURN(sqExecTimesAddr, RT_ERROR_DRV_MEMORY);
    return ProcSqExecTimesAddrTask(dev, RtPtrToValue(sqExecTimesAddr), false);
}

rtError_t SendTaskToUnsetSqExecTimesAddr(Device* const dev)
{
    NULL_PTR_RETURN(dev, RT_ERROR_DEVICE_NULL);
    return ProcSqExecTimesAddrTask(dev, 0x0U, true);
}

static void ConstructDavidSqeForSqExecTimesAddrTask(
    TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    UNUSED(sqeInfo);
    rtDavidSqe_t* davidSqe = static_cast<rtDavidSqe_t*>(sqe);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe* const phSqe = &(davidSqe->phSqe);
    SqExecTimesAddrTaskInfo* const sqExecTimesAddrTask = &(taskInfo->u.sqExecTimesAddrTask);
    Stream* const stream = taskInfo->stream;

    phSqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    phSqe->header.preP = 1U;
    phSqe->taskType = TS_TASK_TYPE_SQ_EXEC_TIMES_ADDR;
    phSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;

    phSqe->u.sqExecTimesAddrInfo.freeFlag = sqExecTimesAddrTask->freeFlag;
    phSqe->u.sqExecTimesAddrInfo.addr = sqExecTimesAddrTask->execTimesAddr;

    PrintDavidSqe(davidSqe, "SendSQExecuteTimesAddr");
    RT_LOG(
        RT_LOG_INFO, "SqExecTimesAddrTask stream_id:%d, task_id:%d, free_flag=%d", stream->Id_(),
        static_cast<uint32_t>(taskInfo->id), sqExecTimesAddrTask->freeFlag);
}
#endif

static bool SqExecTimesAddrTaskRegister()
{
    TaskFuncSingle funcs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructDavidSqeForSqExecTimesAddrTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };

    const auto& chips = GetV200Chips();
    for (const auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_SQ_EXEC_TIMES_ADDR, funcs);
    }

    return true;
}

static bool g_sqExecTimesAddrTaskRegister = SqExecTimesAddrTaskRegister();

} // namespace runtime
} // namespace cce