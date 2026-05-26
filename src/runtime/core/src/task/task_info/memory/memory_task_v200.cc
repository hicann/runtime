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
static void ConstructDavidPcieDmaSqe(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    MemcpyAsyncTaskInfo * const memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsPcieDmaSqe * const sqe = &(davidSqe->pcieDmaSqe);

    sqe->header.type = RT_DAVID_SQE_TYPE_ASYNCDMA;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->sqeLength = 0U;
    sqe->isConverted = 1U;
    sqe->dieId = 0U; // The default value of dieId in pcie sqe is 0.
    const uint64_t sqAddr = RtPtrToValue(memcpyAsyncTaskInfo->dmaAddr.phyAddr.src);
    sqe->pcieDmaSqAddrLow = static_cast<uint32_t>(sqAddr & MASK_32_BIT);
    sqe->pcieDmaSqAddrHigh = static_cast<uint32_t>(sqAddr >> UINT32_BIT_NUM);
    sqe->pcieDmaSqTailPtr = static_cast<uint16_t>(memcpyAsyncTaskInfo->dmaAddr.phyAddr.len);
    PrintDavidSqe(davidSqe, "david pcieDmaTask");
    RT_LOG(RT_LOG_INFO, "PcieDma, deviceId=%u, streamId=%d, taskId=%hu, copyType=%u, sqAddrLow=%p sqTailPtr = %hu.",
        taskInfo->stream->Device_()->Id_(), stream->Id_(), taskInfo->id, memcpyAsyncTaskInfo->copyType,
        memcpyAsyncTaskInfo->dmaAddr.phyAddr.src, sqe->pcieDmaSqTailPtr);
}

static void ConstructDavidAsyncDmaSqe(TaskInfo * const taskInfo, rtDavidSqe_t *const command, uint64_t sqBaseAddr)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, command);
    RtDavidStarsAsyncDmaSqe * const sqe = &(command->davidAsyncDmaDirectSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_ASYNCDMA;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->sqeLength = 1U;
    sqe->wqeSize = 0U;
    sqe->mode = RT_DAVID_SQE_DIRECTWQE_MODE;
    sqe->jettyId = memcpyAsyncTaskInfo->ubDma.jettyId;
    sqe->funcId = memcpyAsyncTaskInfo->ubDma.functionId;
    sqe->dieId = memcpyAsyncTaskInfo->ubDma.dieId;
    rtDavidSqe_t *sqeAddr = command + 1U;
    if (sqBaseAddr != 0ULL) {
        const uint32_t pos = taskInfo->id + 1U;
        sqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }

    const errno_t ret = memcpy_s(sqeAddr, sizeof(rtDavidSqe_t), memcpyAsyncTaskInfo->ubDma.wqe.data(),
        static_cast<size_t>(memcpyAsyncTaskInfo->ubDma.wqeLen));

    COND_LOG_ERROR(ret != EOK, "Memcpy_s failed,retCode=%d,Size=%d(bytes).", ret, memcpyAsyncTaskInfo->ubDma.wqeLen);
    PrintDavidSqe(command, "AsyncDmaTaskPart1");
    PrintDavidSqe(sqeAddr, "AsyncDmaTaskPart2");

    RT_LOG(RT_LOG_INFO, "stream_id=%d, task_id=%hu, copyType=%u, src=%#" PRIx64 ", dst=%#" PRIx64,
            stream->Id_(), taskInfo->id, memcpyAsyncTaskInfo->copyType, memcpyAsyncTaskInfo->src,
            memcpyAsyncTaskInfo->destPtr);
    return;
}

static void ConstructDavidAsyncUbDbSqe(TaskInfo * const taskInfo, rtDavidSqe_t *const command)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, command);
    RtDavidStarsUbdmaDBmodeSqe * const sqe = &(command->davidUbdmaDbSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_UBDMA;
    sqe->header.wrCqe = 0U;
    sqe->mode = RT_DAVID_SQE_DOORBELL_MODE;
    sqe->doorbellNum = UB_DOORBELL_NUM_MIN;
    sqe->source = RT_UBDMA_SOURCE_MODEL_ASYNC;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->sqeLength = 0U;
    sqe->jettyId1 = memcpyAsyncTaskInfo->ubDma.jettyId;
    sqe->funcId1 = memcpyAsyncTaskInfo->ubDma.functionId;
    sqe->dieId1 = memcpyAsyncTaskInfo->ubDma.dieId;
    sqe->piValue1 = memcpyAsyncTaskInfo->ubDma.pi;

    PrintDavidSqe(command, "ModelByUb UbDbSend");

    RT_LOG(RT_LOG_INFO,
        "AsyncUbDb, stream_id=%d, task_id=%hu, copyType=%u, src=%#" PRIx64 ", dst=%#" PRIx64,
        stream->Id_(),
        taskInfo->id,
        memcpyAsyncTaskInfo->copyType,
        memcpyAsyncTaskInfo->src,
        memcpyAsyncTaskInfo->destPtr);
    return;
}

static void ConstructDavidMemcpySqeForOpCode(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe,
    Stream * const stream)
{
    MemcpyAsyncTaskInfo * const memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    const uint32_t copyType = memcpyAsyncTaskInfo->copyType;
    const uint32_t copyKind = memcpyAsyncTaskInfo->copyKind;
    if (unlikely((copyType == RT_MEMCPY_ADDR_D2D_SDMA) && (copyKind == RT_MEMCPY_RESERVED))) {
        return;
    }

    const bool isReduce = ((copyKind == RT_MEMCPY_SDMA_AUTOMATIC_ADD) || (copyKind == RT_MEMCPY_SDMA_AUTOMATIC_MAX) ||
                           (copyKind == RT_MEMCPY_SDMA_AUTOMATIC_MIN) || (copyKind == RT_MEMCPY_SDMA_AUTOMATIC_EQUAL));

    RtDavidStarsMemcpySqe *const sqe = &(davidSqe->memcpyAsyncSqe);
    sqe->opcode = isReduce ? GetOpcodeForReduce(taskInfo) : 0U;
    RT_LOG(RT_LOG_INFO, "copyKind=%u Opcode=0x%x.", static_cast<uint32_t>(copyKind),
        static_cast<uint32_t>(sqe->opcode));

    PrintDavidSqe(davidSqe, "sdmaTask");
    RT_LOG(RT_LOG_INFO, "ConstructMemcpySqe, size=%u, qos=%u, partid=%u, copyType=%u, deviceId=%u, streamId=%d,"
        "taskId=%hu", static_cast<uint32_t>(memcpyAsyncTaskInfo->size), sqe->qos, sqe->mapamPartId, memcpyAsyncTaskInfo->copyType,
        taskInfo->stream->Device_()->Id_(), stream->Id_(), taskInfo->id);
    return;
}

void ConstructDavidSqeForMemcpyAsyncTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe,
    uint64_t sqBaseAddr)
{
    MemcpyAsyncTaskInfo * const memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;
    Driver * const driver = taskInfo->stream->Device_()->Driver_();

    if (driver->GetRunMode() == RT_RUN_MODE_ONLINE) {
        if (IsDavidUbDma(memcpyAsyncTaskInfo->copyType)) {
            if (stream->GetBindFlag()) {
                ConstructDavidAsyncUbDbSqe(taskInfo, davidSqe);
            } else {
                if (memcpyAsyncTaskInfo->copyMethod == RT_ASYNC_CPY_2D ||
                    memcpyAsyncTaskInfo->copyMethod == RT_ASYNC_CPY_BATCH) {
                    ConstructDavidAsyncUbDbSqe(taskInfo, davidSqe);
                } else {
                    ConstructDavidAsyncDmaSqe(taskInfo, davidSqe, sqBaseAddr);
                }
            }
        } else if (IsPcieDma(memcpyAsyncTaskInfo->copyType)) {
            ConstructDavidPcieDmaSqe(taskInfo, davidSqe, sqBaseAddr);
        } else {
            ConstructDavidMemcpySqe(taskInfo, davidSqe, sqBaseAddr);
            ConstructDavidMemcpySqeForOpCode(taskInfo, davidSqe, stream);
        }
    } else {
        ConstructDavidMemcpySqe(taskInfo, davidSqe, sqBaseAddr);
        ConstructDavidMemcpySqeForOpCode(taskInfo, davidSqe, stream);
    }

    RT_LOG(RT_LOG_INFO, "MemcpyAsyncTask, device_id=%u, stream_id=%d, task_id=%hu, copyType=%u",
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

    const auto& chips = GetV200Chips();
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
