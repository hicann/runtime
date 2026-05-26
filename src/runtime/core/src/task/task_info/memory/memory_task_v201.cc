/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stars_david.hpp"
#include "memory_task.h"
#include "stream.hpp"
#include "runtime.hpp"
#include "event_david.hpp"
#include "task_manager.h"
#include "stars.hpp"
#include "device.hpp"
#include "error_code.h"

namespace cce {
namespace runtime {
#if F_DESC("MemcpyAsyncTask")
void ConstructDavidSqeForMemcpyAsyncTask(TaskInfo *const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr)
{
    MemcpyAsyncTaskInfo * const memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;
    ConstructDavidMemcpySqe(taskInfo, davidSqe, sqBaseAddr);

    const uint32_t copyType = memcpyAsyncTaskInfo->copyType;
    const uint32_t copyKind = memcpyAsyncTaskInfo->copyKind;
    if (unlikely((copyType == RT_MEMCPY_ADDR_D2D_SDMA) && (copyKind == RT_MEMCPY_RESERVED))) {
        return;
    }

    const bool isReduce = ((copyKind == RT_MEMCPY_SDMA_AUTOMATIC_ADD) || (copyKind == RT_MEMCPY_SDMA_AUTOMATIC_MAX) ||
                           (copyKind == RT_MEMCPY_SDMA_AUTOMATIC_MIN) || (copyKind == RT_MEMCPY_SDMA_AUTOMATIC_EQUAL));

    RtDavidStarsMemcpySqe *const sqe = &(davidSqe->memcpyAsyncSqe);
    sqe->opcode = isReduce ? GetOpcodeForReduce(taskInfo) : 0U;
    if (isReduce && (memcpyAsyncTaskInfo->copyDataType == RT_DATA_TYPE_UINT32)) {
        sqe->opcode = 0U;
        sqe->opcode |= static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_DATA_TYPE_UINT32);
        sqe->opcode |= ReduceOpcodeLow(taskInfo);
    }

    RT_LOG(RT_LOG_INFO, "copyKind=%u, Opcode=0x%x.", static_cast<uint32_t>(copyKind),
        static_cast<uint32_t>(sqe->opcode));

    PrintDavidSqe(davidSqe, "sdmaTask");
    RT_LOG(RT_LOG_INFO, "ConstructMemcpySqe, size=%u, qos=%u, partid=%u, copyType=%u, deviceId=%u, streamId=%d,"
        "taskId=%hu", static_cast<uint32_t>(memcpyAsyncTaskInfo->size), sqe->qos, sqe->mapamPartId, memcpyAsyncTaskInfo->copyType,
        taskInfo->stream->Device_()->Id_(), stream->Id_(), taskInfo->id);

    RT_LOG(RT_LOG_INFO, "MemcpyAsyncTask, deviceId=%u, streamId=%d, taskId=%u, copyType=%u",
        taskInfo->stream->Device_()->Id_(), static_cast<int32_t>(stream->Id_()), static_cast<uint32_t>(taskInfo->id),
        memcpyAsyncTaskInfo->copyType);
}
#endif

static bool MemoryTaskRegister()
{
    TaskFuncSingle memcpyFuncs = {
        .toCommandFunc = &ToCommandBodyForMemcpyAsyncTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &StarsV2DoCompleteSuccessForMemcpyAsyncTask,
        .taskUnInitFunc = &StarsV2MemcpyAsyncTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForMemcpyAsyncTask,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultForMemcpyAsyncTask,
    };
    TaskFuncSingle createL2AddrFuncs = {
        .toCommandFunc = &ToCommandBodyForCreateL2AddrTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle updateAddressFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle memWriteValueFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle memWaitValueFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = &MemWaitTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle captureRecordFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle captureWaitFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle ipcRecordFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = &StarsV2IpcEventRecordTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle ipcWaitFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = &StarsV2IpcEventWaitTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };

    const auto& chips = GetV201Chips();
    for (auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_MEMCPY, memcpyFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_MEM_WRITE_VALUE, memWriteValueFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_MEM_WAIT_VALUE, memWaitValueFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_CAPTURE_RECORD, captureRecordFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_CAPTURE_WAIT, captureWaitFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_IPC_RECORD, ipcRecordFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_IPC_WAIT, ipcWaitFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_CREATE_L2_ADDR, createL2AddrFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_UPDATE_ADDRESS, updateAddressFuncs);
    }

    RegDavidSqeFunc(TS_TASK_TYPE_MEMCPY, &ConstructDavidSqeForMemcpyAsyncTask);
    RegDavidSqeFunc(TS_TASK_TYPE_MEM_WRITE_VALUE, &ConstructDavidSqeForMemWriteValueTask);
    RegDavidSqeFunc(TS_TASK_TYPE_MEM_WAIT_VALUE, &ConstructDavidSqeForMemWaitValueTask);
    RegDavidSqeFunc(TS_TASK_TYPE_CAPTURE_RECORD, &ConstructDavidSqeForMemWriteValueTask);
    RegDavidSqeFunc(TS_TASK_TYPE_CAPTURE_WAIT, &ConstructDavidSqeForMemWaitValueTask);
    RegDavidSqeFunc(TS_TASK_TYPE_IPC_RECORD, &ConstructDavidSqeForMemWriteValueTask);
    RegDavidSqeFunc(TS_TASK_TYPE_IPC_WAIT, &ConstructDavidSqeForMemWaitValueTask);
    RegDavidSqeFunc(TS_TASK_TYPE_CREATE_L2_ADDR, &ConstructDavidSqeBase);
    RegDavidSqeFunc(TS_TASK_TYPE_UPDATE_ADDRESS, &ConstructDavidSqeBase);
    return true;
}

static bool g_memoryTaskRegister = MemoryTaskRegister();
}  // namespace runtime
}  // namespace cce
