/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "common/api_enum_log.hpp"
#include "runtime/mem_base.h"
#include "task/task_base.hpp"
#include "stars_david.hpp"
#include "david_sqe_adapter.hpp"
#include "memory_task.h"
#include "event_task.h"
#include "stream.hpp"
#include "runtime.hpp"
#include "event_david.hpp"
#include "runtime_task_manager.h"
#include "stars.hpp"
#include "device.hpp"
#include "error_code.h"
#include "jetty_manager.h"

namespace cce {
namespace runtime {

static void ConstructDavidSqeForMemWriteValueTaskWithTimestamp(
    TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t* const davidSqe = static_cast<rtDavidSqe_t*>(sqe);
    ConstructDavidSqeForMemWriteValueTask(taskInfo, &(davidSqe[0]), sqeInfo);
    if (IsTimeLineSoftwareEventRecordTask(taskInfo)) {
        davidSqe[0].commonSqe.sqeHeader.wrCqe = 0U;
        rtDavidSqe_t* placeHolderSqe = davidSqe + 1U;
        if (sqeInfo.sqBaseAddr != 0ULL) {
            placeHolderSqe = GetSqPosAddr(sqeInfo.sqBaseAddr, static_cast<uint32_t>(taskInfo->id) + 1U);
        }
        ConstructDavidPlaceHolderSqe(taskInfo, placeHolderSqe, sqeInfo);
        placeHolderSqe->commonSqe.sqeHeader.wrCqe = 1U;
        if (Runtime::Instance()->GetConnectUbFlag()) {
            davidSqe[0].commonSqe.sqeHeader.headUpdate = 0U;
            placeHolderSqe->commonSqe.sqeHeader.headUpdate = 1U;
        }
    }
}

void SetStarsResultForDavidMemWriteValueTask(TaskInfo* const taskInfo, const rtCqReport_t& logicCq)
{
    SetStarsResultCommonForDavid(taskInfo, logicCq);
    if (((logicCq.errorType & RT_STARS_EXIST_ERROR) == 0U) && IsTimeLineSoftwareEventRecordTask(taskInfo)) {
        taskInfo->u.memWriteValueTask.timestamp = logicCq.u.timeStamp;
    }
}

static void ConstructDavidSqeForCaptureExternalRecordTask(
    TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t* const davidSqe = static_cast<rtDavidSqe_t*>(sqe);
    const WriteValueTaskInfo* const writeValueTask = &taskInfo->u.writeValTask;
    if (writeValueTask->sqeAddr == 0ULL) {
        // capture阶段还未分配device侧内存，放NopTask占位
        const uint32_t sendSqeNum = taskInfo->sqeNum;
        for (uint32_t i = 0U; i < sendSqeNum; ++i) {
            ConstructDavidPlaceHolderSqe(taskInfo, &(davidSqe[i]), sqeInfo);
        }
        UpdateDavidSqeHeadUpdate(taskInfo, sqe);
    } else {
        ConstructDavidSqeForWriteValueTask(taskInfo, &(davidSqe[0]), sqeInfo);
        davidSqe[0].commonSqe.sqeHeader.wrCqe = 0U;
        ConstructDavidPlaceHolderSqe(taskInfo, &(davidSqe[1]), sqeInfo);
        if (writeValueTask->cqeFlag == TASK_WR_CQE_DEFAULT) {
            davidSqe[1].commonSqe.sqeHeader.wrCqe = taskInfo->stream->GetStarsWrCqeFlag() ? 1U : 0U;
        } else {
            davidSqe[1].commonSqe.sqeHeader.wrCqe = (writeValueTask->cqeFlag == TASK_WR_CQE_NEVER) ? 0U : 1U;
        }
    }
}

static void ConstructDavidSqeForCaptureExternalWaitTask(
    TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    const MemWaitValueTaskInfo* const memWaitValueTask = &taskInfo->u.memWaitValueTask;
    if (memWaitValueTask->funcCallSvmMem2 == nullptr) {
        // capture阶段还未分配device侧内存，放NopTask占位
        rtDavidSqe_t* const davidSqe = static_cast<rtDavidSqe_t*>(sqe);
        for (uint32_t i = 0U; i < taskInfo->sqeNum; ++i) {
            ConstructDavidPlaceHolderSqe(taskInfo, &(davidSqe[i]), sqeInfo);
        }
        UpdateDavidSqeHeadUpdate(taskInfo, sqe);
        return;
    }
    ConstructDavidSqeForMemWaitValueTask(taskInfo, sqe, sqeInfo);
}

#if F_DESC("MemcpyAsyncTask")
static void ConstructDavidPcieDmaSqe(TaskInfo* const taskInfo, rtDavidSqe_t* const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    MemcpyAsyncTaskInfo* const memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream* const stream = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsPcieDmaSqe* const sqe = &(davidSqe->pcieDmaSqe);

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
    RT_LOG(
        RT_LOG_INFO,
        "PcieDma, deviceId=%u, streamId=%d, taskId=%hu, copyType=" RT_ENUM_LOG_FORMAT(
            "%u") ", sqAddrLow=%p sqTailPtr = %hu.",
        taskInfo->stream->Device_()->Id_(), stream->Id_(), taskInfo->id,
        RT_ENUM_LOG_VALUE(
            static_cast<uint32_t>(memcpyAsyncTaskInfo->copyType),
            (memcpyAsyncTaskInfo->copyType <= RT_MEMCPY_DIR_SDMA_AUTOMATIC_EQUAL ?
                 RtMemCopyAsyncDirectToString(static_cast<rtMemCopyAsyncDirect>(memcpyAsyncTaskInfo->copyType)) :
                 "UNKNOWN")),
        memcpyAsyncTaskInfo->dmaAddr.phyAddr.src, sqe->pcieDmaSqTailPtr);
}

static void ConstructDavidAsyncDmaSqe(TaskInfo* const taskInfo, rtDavidSqe_t* const command, uint64_t sqBaseAddr)
{
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream* const stream = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, command);
    RtDavidStarsAsyncDmaSqe* const sqe = &(command->davidAsyncDmaDirectSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_ASYNCDMA;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->sqeLength = 1U;
    sqe->wqeSize = 0U;
    sqe->mode = static_cast<uint16_t>(rtDavidUbDmaSqeMode::RT_DAVID_SQE_DIRECTWQE_MODE);
    sqe->jettyId = memcpyAsyncTaskInfo->ubDma.jettyId;
    sqe->funcId = memcpyAsyncTaskInfo->ubDma.functionId;
    sqe->dieId = memcpyAsyncTaskInfo->ubDma.dieId;
    rtDavidSqe_t* sqeAddr = command + 1U;
    if (sqBaseAddr != 0ULL) {
        const uint32_t pos = taskInfo->id + 1U;
        sqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }

    const errno_t ret = memcpy_s(
        sqeAddr, sizeof(rtDavidSqe_t), memcpyAsyncTaskInfo->ubDma.wqe.data(),
        static_cast<size_t>(memcpyAsyncTaskInfo->ubDma.wqeLen));

    COND_LOG_ERROR(ret != EOK, "Memcpy_s failed,retCode=%d,Size=%d(bytes).", ret, memcpyAsyncTaskInfo->ubDma.wqeLen);
    PrintDavidSqe(command, "AsyncDmaTaskPart1");
    PrintDavidSqe(sqeAddr, "AsyncDmaTaskPart2");

    RT_LOG(
        RT_LOG_INFO,
        "stream_id=%d, task_id=%hu, copyType=" RT_ENUM_LOG_FORMAT("%u") ", src=%#" PRIx64 ", dst=%#" PRIx64,
        stream->Id_(), taskInfo->id,
        RT_ENUM_LOG_VALUE(
            static_cast<uint32_t>(memcpyAsyncTaskInfo->copyType),
            (memcpyAsyncTaskInfo->copyType <= RT_MEMCPY_DIR_SDMA_AUTOMATIC_EQUAL ?
                 RtMemCopyAsyncDirectToString(static_cast<rtMemCopyAsyncDirect>(memcpyAsyncTaskInfo->copyType)) :
                 "UNKNOWN")),
        memcpyAsyncTaskInfo->src, memcpyAsyncTaskInfo->destPtr);
    return;
}

void ConstructDavidAsyncUbDbSqe(TaskInfo* const taskInfo, rtDavidSqe_t* const command)
{
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream* const stream = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, command);
    RtDavidStarsUbdmaDBmodeSqe* const sqe = &(command->davidUbdmaDbSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_UBDMA;
    sqe->header.wrCqe = 0U;
    sqe->mode = static_cast<uint16_t>(rtDavidUbDmaSqeMode::RT_DAVID_SQE_DOORBELL_MODE);
    sqe->doorbellNum = UB_DOORBELL_NUM_MIN;
    sqe->source = static_cast<uint16_t>(UbDmaSqeSource::RT_UBDMA_SOURCE_MODEL_ASYNC);
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->sqeLength = 0U;
    sqe->jettyId1 = memcpyAsyncTaskInfo->ubDma.jettyId;
    sqe->funcId1 = memcpyAsyncTaskInfo->ubDma.functionId;
    sqe->dieId1 = memcpyAsyncTaskInfo->ubDma.dieId;
    sqe->piValue1 = memcpyAsyncTaskInfo->ubDma.pi;

    PrintDavidSqe(command, "ModelByUb UbDbSend");

    RT_LOG(
        RT_LOG_INFO,
        "AsyncUbDb, stream_id=%d, task_id=%hu, copyType=" RT_ENUM_LOG_FORMAT("%u") ", src=%#" PRIx64 ", dst=%#" PRIx64,
        stream->Id_(), taskInfo->id,
        RT_ENUM_LOG_VALUE(
            static_cast<uint32_t>(memcpyAsyncTaskInfo->copyType),
            (memcpyAsyncTaskInfo->copyType <= RT_MEMCPY_DIR_SDMA_AUTOMATIC_EQUAL ?
                 RtMemCopyAsyncDirectToString(static_cast<rtMemCopyAsyncDirect>(memcpyAsyncTaskInfo->copyType)) :
                 "UNKNOWN")),
        memcpyAsyncTaskInfo->src, memcpyAsyncTaskInfo->destPtr);
    return;
}

static void ConstructDavidMemcpySqeForOpCode(
    TaskInfo* const taskInfo, rtDavidSqe_t* const davidSqe, Stream* const stream)
{
    MemcpyAsyncTaskInfo* const memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    const uint32_t copyType = memcpyAsyncTaskInfo->copyType;
    const uint32_t copyKind = memcpyAsyncTaskInfo->copyKind;
    if (unlikely((copyType == RT_MEMCPY_ADDR_D2D_SDMA) && (copyKind == RT_MEMCPY_RESERVED))) {
        return;
    }

    const bool isReduce =
        ((copyKind == RT_MEMCPY_SDMA_AUTOMATIC_ADD) || (copyKind == RT_MEMCPY_SDMA_AUTOMATIC_MAX) ||
         (copyKind == RT_MEMCPY_SDMA_AUTOMATIC_MIN) || (copyKind == RT_MEMCPY_SDMA_AUTOMATIC_EQUAL));

    RtDavidStarsMemcpySqe* const sqe = &(davidSqe->memcpyAsyncSqe);
    sqe->opcode = isReduce ? GetOpcodeForReduce(taskInfo) : 0U;
    RT_LOG(
        RT_LOG_INFO, "copyKind=" RT_ENUM_LOG_FORMAT("%u") " Opcode=0x%x.",
        RT_ENUM_LOG_VALUE(
            static_cast<uint32_t>(static_cast<uint32_t>(copyKind)),
            MemcpyOrReduceKindToString(static_cast<uint32_t>(copyKind))),
        static_cast<uint32_t>(sqe->opcode));

    PrintDavidSqe(davidSqe, "sdmaTask");
    RT_LOG(
        RT_LOG_INFO,
        "ConstructMemcpySqe, size=%u, qos=%u, partid=%u, copyType=" RT_ENUM_LOG_FORMAT(
            "%u") ", deviceId=%u, streamId=%d,taskId=%hu",
        static_cast<uint32_t>(memcpyAsyncTaskInfo->size), sqe->qos, sqe->mapamPartId,
        RT_ENUM_LOG_VALUE(
            static_cast<uint32_t>(memcpyAsyncTaskInfo->copyType),
            (memcpyAsyncTaskInfo->copyType <= RT_MEMCPY_DIR_SDMA_AUTOMATIC_EQUAL ?
                 RtMemCopyAsyncDirectToString(static_cast<rtMemCopyAsyncDirect>(memcpyAsyncTaskInfo->copyType)) :
                 "UNKNOWN")),
        taskInfo->stream->Device_()->Id_(), stream->Id_(), taskInfo->id);
    return;
}

void ConstructDavidSqeForMemcpyAsyncTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t* davidSqe = static_cast<rtDavidSqe_t*>(sqe);
    uint64_t sqBaseAddr = sqeInfo.sqBaseAddr;
    MemcpyAsyncTaskInfo* const memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream* const stream = taskInfo->stream;
    Driver* const driver = taskInfo->stream->Device_()->Driver_();

    if (driver->GetRunMode() == RT_RUN_MODE_ONLINE) {
        if (IsDavidUbDma(memcpyAsyncTaskInfo->copyType)) {
            taskInfo->isNoRingbuffer = 1U;
            if (stream->GetBindFlag()) {
                ConstructDavidAsyncUbDbSqe(taskInfo, davidSqe);
            } else {
                if (memcpyAsyncTaskInfo->copyMethod == static_cast<uint8_t>(rtAsyncCpyMethod::RT_ASYNC_CPY_2D) ||
                    memcpyAsyncTaskInfo->copyMethod == static_cast<uint8_t>(rtAsyncCpyMethod::RT_ASYNC_CPY_BATCH)) {
                    ConstructDavidAsyncUbDbSqe(taskInfo, davidSqe);
                } else {
                    ConstructDavidAsyncDmaSqe(taskInfo, davidSqe, sqBaseAddr);
                }
            }
        } else if (IsPcieDma(memcpyAsyncTaskInfo->copyType)) {
            taskInfo->isNoRingbuffer = 1U;
            ConstructDavidPcieDmaSqe(taskInfo, davidSqe, sqBaseAddr);
        } else {
            ConstructDavidMemcpySqe(taskInfo, davidSqe, sqBaseAddr);
            ConstructDavidMemcpySqeForOpCode(taskInfo, davidSqe, stream);
        }
    } else {
        ConstructDavidMemcpySqe(taskInfo, davidSqe, sqBaseAddr);
        ConstructDavidMemcpySqeForOpCode(taskInfo, davidSqe, stream);
    }

    RT_LOG(
        RT_LOG_INFO, "MemcpyAsyncTask, device_id=%u, stream_id=%d, task_id=%hu, copyType=" RT_ENUM_LOG_FORMAT("%u"),
        taskInfo->stream->Device_()->Id_(), static_cast<int32_t>(stream->Id_()), static_cast<uint32_t>(taskInfo->id),
        RT_ENUM_LOG_VALUE(
            static_cast<uint32_t>(memcpyAsyncTaskInfo->copyType),
            (memcpyAsyncTaskInfo->copyType <= RT_MEMCPY_DIR_SDMA_AUTOMATIC_EQUAL ?
                 RtMemCopyAsyncDirectToString(static_cast<rtMemCopyAsyncDirect>(memcpyAsyncTaskInfo->copyType)) :
                 "UNKNOWN")));
    UpdateDavidSqeHeadUpdate(taskInfo, sqe);
}

rtError_t GetD2dCrossType(
    const Stream* const stm, const void* const srcAddr, const void* const desAddr, bool* const isD2dCross8P)
{
    Driver* const driver = stm->Device_()->Driver_();
    int64_t locationType = 0;
    rtPtrAttributes_t srcAttributes = {}, dstAttributes = {};
    *isD2dCross8P = false;

    rtError_t error = driver->PtrGetAttributes(srcAddr, &srcAttributes);
    COND_RETURN_ERROR(
        (error != RT_ERROR_NONE), error, "Failed to get src memory attribute, retCode=%#x.",
        static_cast<uint32_t>(error));

    error = driver->PtrGetAttributes(desAddr, &dstAttributes);
    COND_RETURN_ERROR(
        (error != RT_ERROR_NONE), error, "Failed to get dst memory attribute, retCode=%#x.",
        static_cast<uint32_t>(error));

    const uint32_t srcDevId = srcAttributes.location.id;
    const uint32_t dstDevId = dstAttributes.location.id;

    error = driver->GetPairDevicesInfo(srcDevId, dstDevId, DEVS_INFO_TYPE_BOARD_LOCATION, &locationType, false);
    COND_RETURN_ERROR(
        (error != RT_ERROR_NONE), error,
        "Failed to get device board location type, src device_id=%u, dst device_id=%u, retCode=%#x.", srcDevId,
        dstDevId, static_cast<uint32_t>(error));
    if (locationType == LOCATION_CROSS_BOARD) {
        *isD2dCross8P = true;
        JettyManager* jettyMgr = stm->Device_()->GetJettyManager();
        jettyMgr->CreateCrossBoardJetty();
    }

    RT_LOG(
        RT_LOG_DEBUG,
        "Success to get device board location type: src device_id=%u, dst device_id=%u, cross board flag=%d.", srcDevId,
        dstDevId, *isD2dCross8P);
    return RT_ERROR_NONE;
}
#endif

static bool MemoryTaskRegister()
{
    TaskFuncSingle memcpyFuncs = {
        .toCommandFunc = &ToCommandBodyForMemcpyAsyncTask,
        .toSqeFunc = &ConstructDavidSqeForMemcpyAsyncTask,
        .doCompleteSuccFunc = &StarsV2DoCompleteSuccessForMemcpyAsyncTask,
        .taskUnInitFunc = &StarsV2MemcpyAsyncTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForMemcpyAsyncTask,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultForMemcpyAsyncTask,
    };
    TaskFuncSingle createL2AddrFuncs = {
        .toCommandFunc = &ToCommandBodyForCreateL2AddrTask,
        .toSqeFunc = &ConstructDavidSqeBase,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle updateAddressFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructDavidSqeBase,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle memWriteValueFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructDavidSqeForMemWriteValueTaskWithTimestamp,
        .doCompleteSuccFunc = &DoCompleteSuccessForMemWriteValueTask,
        .taskUnInitFunc = &MemWriteTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultForDavidMemWriteValueTask,
    };
    TaskFuncSingle memWaitValueFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructDavidSqeForMemWaitValueTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = &DavidMemWaitTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle captureRecordFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructDavidSqeForMemWriteValueTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle captureExternalRecordFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructDavidSqeForCaptureExternalRecordTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle captureWaitFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructDavidSqeForMemWaitValueTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle captureExternalWaitFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructDavidSqeForCaptureExternalWaitTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle ipcRecordFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructDavidSqeForMemWriteValueTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = &StarsV2IpcEventRecordTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle ipcWaitFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructDavidSqeForMemWaitValueTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = &StarsV2IpcEventWaitTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle memsetFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructDavidSqeForMemsetAsyncTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    const auto& chips = GetDavidChips();
    for (const auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_MEMCPY, memcpyFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_MEM_WRITE_VALUE, memWriteValueFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_MEM_WAIT_VALUE, memWaitValueFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_CAPTURE_RECORD, captureRecordFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_CAPTURE_WAIT, captureWaitFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL, captureExternalRecordFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_CAPTURE_WAIT_EXTERNAL, captureExternalWaitFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_IPC_RECORD, ipcRecordFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_IPC_WAIT, ipcWaitFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_CREATE_L2_ADDR, createL2AddrFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_UPDATE_ADDRESS, updateAddressFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_MEMSET, memsetFuncs);
    }

    return true;
}

static bool g_memoryTaskRegister = MemoryTaskRegister();

} // namespace runtime
} // namespace cce
