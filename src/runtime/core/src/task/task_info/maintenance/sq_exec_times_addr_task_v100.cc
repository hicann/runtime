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
#include "task.hpp"
#include "runtime_task_manager.h"
#include "task_info_v100.h"

namespace cce {
namespace runtime {
#if F_DESC("SqExecTimesAddrTask")
static rtError_t ProcSqExecTimesAddrTask(Device* const dev, const uint64_t sqExecTimesAddr, const bool freeFlag)
{
    Stream* const stm = dev->GetCtrlStream(dev->PrimaryStream_());
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);

    TaskInfo taskSubmit = {};
    rtError_t error = RT_ERROR_TASK_NEW;
    TaskInfo* const tsk = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_SQ_EXEC_TIMES_ADDR, error);
    NULL_PTR_RETURN(tsk, error);

    error = SqExecTimesAddrTaskInit(tsk, sqExecTimesAddr, freeFlag);
    ERROR_GOTO(error, ERROR_TASK, "Failed to init sq exec times addr task.");

    error = dev->SubmitTask(tsk);
    ERROR_GOTO(error, ERROR_TASK, "Failed to submit sq exec times addr task.");

    error = stm->Synchronize();
    ERROR_GOTO(error, ERROR_TASK, "Failed to synchronize stream.");

    return RT_ERROR_NONE;
ERROR_TASK:
    (void)dev->GetTaskFactory()->Recycle(tsk);
    return error;
}

rtError_t SendTaskToSetSqExecTimesAddr(Device* const dev)
{
    NULL_PTR_RETURN(dev, RT_ERROR_DEVICE_NULL);
    void* const sqExecTimesAddr = dev->GetSqExecTimesSvmBaseAddr_();
    NULL_PTR_RETURN(sqExecTimesAddr, RT_ERROR_DRV_MEMORY);

    uint64_t addrOffset = 0x0U;
    const rtError_t error = dev->Driver_()->MemAddressTranslate(
        static_cast<int32_t>(dev->Id_()), RtPtrToValue(sqExecTimesAddr), &addrOffset);
    COND_RETURN_WARN(
        error != RT_ERROR_NONE, RT_ERROR_DRV_MEMORY,
        "Failed to translate memory addr for sq exec times addr in device, devid=%u.", dev->Id_());
    return ProcSqExecTimesAddrTask(dev, addrOffset, false);
}

rtError_t SendTaskToUnsetSqExecTimesAddr(Device* const dev)
{
    NULL_PTR_RETURN(dev, RT_ERROR_DEVICE_NULL);
    return ProcSqExecTimesAddrTask(dev, 0x0U, true);
}

static void ConstructSqeForSqExecTimesAddrTask(TaskInfo* taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo)
{
    UNUSED(sqeInfo);
    rtStarsSqe_t* const command = static_cast<rtStarsSqe_t*>(sqeBuffer);
    RtStarsPhSqe* const phSqe = &(command->phSqe);
    SqExecTimesAddrTaskInfo* const sqExecTimesAddrTask = &(taskInfo->u.sqExecTimesAddrTask);
    Stream* const stream = taskInfo->stream;

    phSqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    phSqe->wr_cqe = stream->GetStarsWrCqeFlag();
    phSqe->rt_streamID = static_cast<uint16_t>(stream->Id_());
    phSqe->task_id = taskInfo->id;
    phSqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    phSqe->task_type = TS_TASK_TYPE_SQ_EXEC_TIMES_ADDR;
    phSqe->pre_p = RT_STARS_SQE_INT_DIR_TO_TSCPU;

    phSqe->u.sqExecTimesAddrInfo.freeFlag = sqExecTimesAddrTask->freeFlag;
    phSqe->u.sqExecTimesAddrInfo.addr = sqExecTimesAddrTask->execTimesAddr;

    PrintSqe(command, "SqExecTimesAddrTask");
    RT_LOG(
        RT_LOG_INFO, "SqExecTimesAddrTask stream_id:%d, task_id:%d, free_flag=%d, offset=%#" PRIx64, stream->Id_(),
        static_cast<uint32_t>(taskInfo->id), sqExecTimesAddrTask->freeFlag, sqExecTimesAddrTask->execTimesAddr);
}
#endif

static bool SqExecTimesAddrTaskRegister()
{
    TaskFuncSingle funcs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForSqExecTimesAddrTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };

    const auto& chips = GetV100Chips();
    for (const auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_SQ_EXEC_TIMES_ADDR, funcs);
    }

    return true;
}

static bool g_sqExecTimesAddrTaskRegister = SqExecTimesAddrTaskRegister();

} // namespace runtime
} // namespace cce