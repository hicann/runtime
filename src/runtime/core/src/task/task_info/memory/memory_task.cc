/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "memory_task.h"
#include "stream.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "task_info.hpp"
#include "runtime_task_manager.h"
#include "error_code.h"
#include "task_execute_time.h"
#include "inner_thread_local.hpp"
#include "model_update_task.h"
#include "event.hpp"
#include "kernel_utils.hpp"
#include "stream_jetty_handler.h"
#include "capture_model_utils.hpp"
#include "rt_inner_event.h"

namespace cce {
namespace runtime {

TIMESTAMP_EXTERN(rtMemcpyAsync_drvDeviceGetTransWay);
TIMESTAMP_EXTERN(rtMemcpyAsync_drvMemConvertAddr);

#if F_DESC("MemcpyAsyncTask")

static rtError_t ConvertAsyncDma2DForSoftWareSq(
    TaskInfo* const taskInfo2D, void* const dst, const void* const src, const uint64_t dstPitch,
    const uint64_t srcPitch, const uint64_t width, const uint64_t height, const uint64_t fixedSize)
{
    Stream* const stream = taskInfo2D->stream;
    const uint32_t devId = stream->Device_()->Id_();
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo2D->u.memcpyAsyncTaskInfo);

    rtError_t error = RT_ERROR_NONE;
    const JettyType jettyType = StreamJettyHandler::GetJettyTypeFromTask(taskInfo2D);
    AsyncWqeInputPara input = {};
    AsyncWqeOutputPara output = {};
    input.wqeType = static_cast<uint32_t>(DRV_ASYNC_DMA_TYPE_2D);
    input.matrix2d.src = RtPtrToPtr<uint64_t*>(RtPtrToPtr<uintptr_t>(src));
    input.matrix2d.dst = RtPtrToPtr<uint64_t*>(RtPtrToPtr<uintptr_t>(dst));

    input.matrix2d.dpitch = dstPitch;
    input.matrix2d.spitch = srcPitch;
    input.matrix2d.width = width;
    input.matrix2d.height = height;
    input.matrix2d.fixedSize = fixedSize;
    error = StreamJettyHandler::HandleUbDmaTask(taskInfo2D, jettyType, &input, &output);
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "HandleUbDmaTask failed, device_id=%u, stream_id=%d, retCode=%#x.", devId, stream->Id_(),
            error);
        return error;
    }
    uint64_t size = (output.fixedCnt == 1U) ? width * height : output.fixedSize;
    memcpyAsyncTaskInfo->ubDma.fixedSize = size;
    memcpyAsyncTaskInfo->size = size;
    return RT_ERROR_NONE;
}

rtError_t ConvertAsyncDma2D(
    TaskInfo* const taskInfo2D, void* const dst, const uint64_t dstPitch, const void* const src,
    const uint64_t srcPitch, const uint64_t width, const uint64_t height, const uint64_t fixedSize)
{
    const bool isUbMode = Runtime::Instance()->GetConnectUbFlag() ? true : false;
    if (!isUbMode) {
        RT_LOG(RT_LOG_ERROR, "pcie does not support");
        return RT_ERROR_INVALID_VALUE;
    }
    Stream* const stream = taskInfo2D->stream;
    const uint32_t devId = stream->Device_()->Id_();
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo2D->u.memcpyAsyncTaskInfo);

    if (stream->IsSoftwareSqEnable()) {
        return ConvertAsyncDma2DForSoftWareSq(taskInfo2D, dst, src, dstPitch, srcPitch, width, height, fixedSize);
    }

    Driver* const driver = stream->Device_()->Driver_();
    AsyncDmaWqeInputInfo2D input;
    (void)memset_s(&input, sizeof(AsyncDmaWqeInputInfo2D), 0, sizeof(AsyncDmaWqeInputInfo2D));

    input.tsId = stream->Device_()->DevGetTsId();
    input.sqId = stream->GetSqId();
    input.dst = dst;
    input.dpitch = dstPitch;
    input.src = const_cast<void*>(src);
    input.spitch = srcPitch;
    input.width = width;
    input.height = height;
    input.fixedSize = fixedSize;
    AsyncDmaWqeOutputInfo output;
    (void)memset_s(&output, sizeof(AsyncDmaWqeOutputInfo), 0, sizeof(AsyncDmaWqeOutputInfo));
    const rtError_t error = driver->CreateAsyncDmaWqe2D(devId, input, &output);
    ERROR_RETURN_MSG_INNER(error, "drv create asyncDmaWqe2D failed, retCode=%#x.", static_cast<uint32_t>(error));

    memcpyAsyncTaskInfo->ubDma.jettyId = output.jettyId;
    memcpyAsyncTaskInfo->ubDma.functionId = output.functionId;
    memcpyAsyncTaskInfo->ubDma.dieId = output.dieId;
    memcpyAsyncTaskInfo->ubDma.pi = output.pi;
    memcpyAsyncTaskInfo->ubDma.fixedSize = output.fixedSize;
    memcpyAsyncTaskInfo->size = output.fixedSize;

    return RT_ERROR_NONE;
}

uint8_t ReduceOpcodeHigh(TaskInfo* const taskInfo)
{
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    uint8_t opcode;
    const int32_t switchFlag = static_cast<int32_t>(memcpyAsyncTaskInfo->copyDataType);
    switch (switchFlag) {
        case RT_DATA_TYPE_INT8: {
            opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_DATA_TYPE_INT8);
            break;
        }
        case RT_DATA_TYPE_INT16: {
            opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_DATA_TYPE_INT16);
            break;
        }
        case RT_DATA_TYPE_INT32: {
            opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_DATA_TYPE_INT32);
            break;
        }
        case RT_DATA_TYPE_FP16: {
            opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_DATA_TYPE_FP16);
            break;
        }
        case RT_DATA_TYPE_FP32: {
            opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_DATA_TYPE_FP32);
            break;
        }
        case RT_DATA_TYPE_BFP16: {
            if (Runtime::Instance()->ChipIsHaveStars()) {
                opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_DATA_TYPE_BFP16);
            } else {
                RT_LOG(
                    RT_LOG_WARNING, "DataType=%u is out of range or is not supported.",
                    static_cast<uint32_t>(memcpyAsyncTaskInfo->copyDataType));
                opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_OP_RESERVED);
            }
            break;
        }
        case RT_DATA_TYPE_UINT32: {
            opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_DATA_TYPE_UINT32);
            break;
        }
        default: {
            // Should not run here.
            // if not support, it will return RT_ERROR_FEATURE_NOT_SUPPORT at context.cc's reduce ability check.
            // Only for code style, 0x80 is reserved value of STRAS opcode.
            RT_LOG(
                RT_LOG_WARNING, "DataType=%u is out of range or is not supported.",
                static_cast<uint32_t>(memcpyAsyncTaskInfo->copyDataType));
            opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_OP_RESERVED);
            break;
        }
    }
    return opcode;
}

uint8_t ReduceOpcodeLow(TaskInfo* const taskInfo)
{
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    uint8_t opcode;
    switch (memcpyAsyncTaskInfo->copyKind) {
        case RT_MEMCPY_SDMA_AUTOMATIC_ADD: {
            opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_OP_KIND_ADD);
            break;
        }
        case RT_MEMCPY_SDMA_AUTOMATIC_MAX: {
            opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_OP_KIND_MAX);
            break;
        }
        case RT_MEMCPY_SDMA_AUTOMATIC_MIN: {
            opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_OP_KIND_MIN);
            break;
        }
        case RT_MEMCPY_SDMA_AUTOMATIC_EQUAL: {
            opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_OP_KIND_EQUAL);
            break;
        }
        default: {
            RT_LOG(RT_LOG_WARNING, "Type out of range: copyKind=%u", memcpyAsyncTaskInfo->copyKind);
            opcode = static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_OP_RESERVED);
            break;
        }
    }
    return opcode;
}

uint8_t GetOpcodeForReduce(TaskInfo* const taskInfo)
{
    const uint8_t opcodeHigh = ReduceOpcodeHigh(taskInfo);
    const uint8_t opcodeLow = ReduceOpcodeLow(taskInfo);
    if ((static_cast<int32_t>(opcodeHigh) == RT_STARS_MEMCPY_ASYNC_OP_RESERVED) ||
        (static_cast<int32_t>(opcodeLow) == RT_STARS_MEMCPY_ASYNC_OP_RESERVED)) {
        // Should not run here. 0x80 is reserved value of STARS opcode
        return static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_OP_RESERVED);
    } else {
        return opcodeHigh | opcodeLow;
    }
}

#endif

#if F_DESC("SqeUpdateH2DTask")
rtError_t SqeUpdateH2DTaskInit(
    TaskInfo* const taskInfo, void* srcAddr, void* dstAddr, const uint64_t cpySize, void* releaseArgHandle,
    void* const updateArgHandle)
{
    NULL_PTR_RETURN(srcAddr, RT_ERROR_MEMORY_ALLOCATION);
    NULL_PTR_RETURN(dstAddr, RT_ERROR_MEMORY_ALLOCATION);
    const rtError_t error = MemcpyAsyncTaskCommonInit(taskInfo);
    ERROR_RETURN_MSG_INNER(error, "SqeUpdateH2DTaskInit failed, retCode=%#x.", static_cast<uint32_t>(error));

    MemcpyAsyncTaskInfo* memcpyAsyncTask = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream* const stream = taskInfo->stream;
    taskInfo->typeName = "MEMCPY_ASYNC_SQE_UPDATE_H2D";

    const int32_t devId = static_cast<int32_t>(stream->Device_()->Id_());
    memcpyAsyncTask->dmaAddr.offsetAddr.devid = static_cast<uint32_t>(devId);
    memcpyAsyncTask->copyKind = static_cast<uint32_t>(RT_MEMCPY_HOST_TO_DEVICE);
    memcpyAsyncTask->copyType = static_cast<uint32_t>(RT_MEMCPY_DIR_H2D);
    memcpyAsyncTask->size = cpySize;
    memcpyAsyncTask->src = srcAddr;
    memcpyAsyncTask->destPtr = dstAddr;
    memcpyAsyncTask->isSqeUpdateH2D = true;
    memcpyAsyncTask->dmaKernelConvertFlag = true;
    memcpyAsyncTask->releaseArgHandle = releaseArgHandle;
    memcpyAsyncTask->updateArgHandle = updateArgHandle;

    RT_LOG(RT_LOG_INFO, "device_id=%d, stream_id=%u", devId, stream->Id_());

    return RT_ERROR_NONE;
}
#endif

/* D2H copy, src = sqeBaseAddr + sqeOffset, dst info = sqId + pos + sqeOffset, convert dst addr by ts-agent */
rtError_t UpdateD2HTaskInit(
    TaskInfo* const taskInfo, const void* sqeBaseAddr, const uint64_t cpySize, const uint32_t sqId, const uint32_t pos,
    const uint8_t sqeOffset)
{
    NULL_PTR_RETURN(sqeBaseAddr, RT_ERROR_MEMORY_ALLOCATION);
    const rtError_t error = MemcpyAsyncTaskCommonInit(taskInfo);
    ERROR_RETURN_MSG_INNER(error, "UpdateD2HTaskInit failed, retCode=%#x.", static_cast<uint32_t>(error));

    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream* const stream = taskInfo->stream;
    taskInfo->typeName = "MEMCPY_ASYNC_SQE_UPDATE";

    const int32_t devId = static_cast<int32_t>(stream->Device_()->Id_());
    memcpyAsyncTaskInfo->dmaAddr.offsetAddr.devid = static_cast<uint32_t>(devId);
    memcpyAsyncTaskInfo->copyKind = static_cast<uint32_t>(RT_MEMCPY_DEVICE_TO_HOST);
    memcpyAsyncTaskInfo->copyType = static_cast<uint32_t>(RT_MEMCPY_DIR_D2H);
    memcpyAsyncTaskInfo->size = cpySize;
    memcpyAsyncTaskInfo->qos = 0U;
    memcpyAsyncTaskInfo->partId = 0U;
    memcpyAsyncTaskInfo->src = RtValueToPtr<void*>(RtPtrToValue(sqeBaseAddr) + sqeOffset);
    memcpyAsyncTaskInfo->sqId = sqId;
    memcpyAsyncTaskInfo->taskPos = pos;
    memcpyAsyncTaskInfo->sqeOffset = sqeOffset;
    memcpyAsyncTaskInfo->isSqeUpdateD2H = true;

    RT_LOG(
        RT_LOG_INFO, "device_id=%d, stream_id=%d, sqId=%u, pos=%u, sqeOffset=%u", devId, stream->Id_(),
        memcpyAsyncTaskInfo->sqId, memcpyAsyncTaskInfo->taskPos, sqeOffset);

    return RT_ERROR_NONE;
}

#if F_DESC("MemWriteValueTask")
rtError_t MemWriteValueTaskInit(TaskInfo* taskInfo, const void* const devAddr, const uint64_t value)
{
    TaskCommonInfoInit(taskInfo);
    MemWriteValueTaskInfo* memWriteValueTask = &taskInfo->u.memWriteValueTask;
    memWriteValueTask->devAddr = RtPtrToValue(devAddr);
    memWriteValueTask->value = value;

    return RT_ERROR_NONE;
}

#endif

#if F_DESC("MemWaitValueTask")
void MemWaitTaskUnInit(TaskInfo* taskInfo)
{
    MemWaitValueTaskInfo* memWaitValueTask = &taskInfo->u.memWaitValueTask;
    if (memWaitValueTask->baseFuncCallSvmMem != nullptr) {
        const auto dev = taskInfo->stream->Device_();
        if ((taskInfo->type != TS_TASK_TYPE_CAPTURE_WAIT) && (taskInfo->type != TS_TASK_TYPE_CAPTURE_WAIT_EXTERNAL)) {
            (void)dev->Driver_()->DevMemFree(memWaitValueTask->baseFuncCallSvmMem, dev->Id_());
        }
        memWaitValueTask->baseFuncCallSvmMem = nullptr;
        memWaitValueTask->funcCallSvmMem2 = nullptr;
        memWaitValueTask->writeValueAddr = nullptr;
    }

    memWaitValueTask->profDisableStatusAddr = 0UL;

    if (memWaitValueTask->retainedEventId != INVALID_EVENT_ID) {
        COND_PROC(
            memWaitValueTask->event != nullptr,
            memWaitValueTask->event->EventIdCountSub(memWaitValueTask->retainedEventId));
        memWaitValueTask->retainedEventId = INVALID_EVENT_ID;
    }

    memWaitValueTask->funCallMemSize2 = 0UL;
}

static rtError_t AllocFuncCallMemForMemWaitTask(TaskInfo* taskInfo)
{
    MemWaitValueTaskInfo* memWaitValueTask = &taskInfo->u.memWaitValueTask;
    if (taskInfo->type == TS_TASK_TYPE_CAPTURE_WAIT_EXTERNAL) {
        memWaitValueTask->funCallMemSize2 = static_cast<uint64_t>(sizeof(RtStarsExternalWaitFuncCall));
    } else if (taskInfo->stream->IsSoftwareSqEnable()) {
        if (taskInfo->stream->Device_()->GetDevProperties().sqSwapShift == 0U) {
            memWaitValueTask->funCallMemSize2 = static_cast<uint64_t>(sizeof(RtStarsMemWaitValueLastInstrFcEx));
        } else {
            memWaitValueTask->funCallMemSize2 =
                static_cast<uint64_t>(sizeof(RtStarsMemWaitValueLastInstrFcExWithDynamicProf));
        }
    } else {
        if (taskInfo->stream->Device_()->GetDevProperties().sqSwapShift == 0U) {
            memWaitValueTask->funCallMemSize2 = static_cast<uint64_t>(sizeof(RtStarsMemWaitValueLastInstrFc));
        } else {
            memWaitValueTask->funCallMemSize2 =
                static_cast<uint64_t>(sizeof(RtStarsMemWaitValueLastInstrFcWithDynamicProf));
        }
    }

    void* devMem = nullptr;
    const auto dev = taskInfo->stream->Device_();
    const uint64_t allocSize = memWaitValueTask->funCallMemSize2 + MEM_WAIT_WRITE_VALUE_ADDRESS_LEN +
                               FUNC_CALL_INSTR_ALIGN_SIZE + sizeof(uint64_t);
    rtError_t ret = RT_ERROR_NONE;
    if ((taskInfo->type == TS_TASK_TYPE_CAPTURE_WAIT) || (taskInfo->type == TS_TASK_TYPE_CAPTURE_WAIT_EXTERNAL)) {
        if (taskInfo->stream->Model_() == nullptr || allocSize > MEM_WAIT_SPLIT_SIZE) {
            RT_LOG(
                RT_LOG_ERROR, "Model is null or capture wait alloc size=%llu max than %u.", allocSize,
                MEM_WAIT_SPLIT_SIZE);
            return RT_ERROR_MODEL_NULL;
        }
        ret = taskInfo->stream->Model_()->MemWaitDevAlloc(&devMem, taskInfo->stream->Device_());
    } else {
        ret = dev->Driver_()->DevMemAlloc(&devMem, allocSize, RT_MEMORY_DDR, dev->Id_());
    }
    COND_RETURN_ERROR(
        (ret != RT_ERROR_NONE) || (devMem == nullptr), ret,
        "alloc func call memory failed, retCode=%#x, size=%" PRIu64 "(bytes), dev_id=%u", ret, allocSize, dev->Id_());

    memWaitValueTask->baseFuncCallSvmMem = devMem;
    // instr addr should align to 256b
    if ((RtPtrToValue(devMem) & 0xFFULL) != 0ULL) {
        // 2 ^ 8 is 256 align
        const uint64_t devMemAlign2 = (((RtPtrToValue(devMem)) >> 8U) + 1UL) << 8U;
        memWaitValueTask->funcCallSvmMem2 = RtValueToPtr<void*>(devMemAlign2);
    } else {
        memWaitValueTask->funcCallSvmMem2 = devMem;
    }

    void* devMem3 =
        RtValueToPtr<void*>(RtPtrToValue(memWaitValueTask->funcCallSvmMem2) + memWaitValueTask->funCallMemSize2);
    if ((RtPtrToValue(devMem3) & 0x1FULL) != 0ULL) {
        // 2 ^ 5 is 32 align
        const uint64_t devMemAlign3 = (((RtPtrToValue(devMem3)) >> 5U) + 1UL) << 5U;
        memWaitValueTask->writeValueAddr = RtValueToPtr<void*>(devMemAlign3);
    } else {
        memWaitValueTask->writeValueAddr = devMem3;
    }

    void* addr = RtValueToPtr<void*>(RtPtrToValue(memWaitValueTask->writeValueAddr) + MEM_WAIT_WRITE_VALUE_ADDRESS_LEN);
    uint64_t initValue = 0UL;
    (void)taskInfo->stream->Device_()->Driver_()->MemCopySync(
        addr, sizeof(uint64_t), static_cast<const void*>(&initValue), sizeof(uint64_t), RT_MEMCPY_HOST_TO_DEVICE);
    memWaitValueTask->profDisableStatusAddr = RtPtrToValue(addr);

    return RT_ERROR_NONE;
}

rtError_t MemWaitValueTaskInit(TaskInfo* taskInfo, const void* const devAddr, const uint64_t value, const uint32_t flag)
{
    TaskCommonInfoInit(taskInfo);

    MemWaitValueTaskInfo* memWaitValueTask = &taskInfo->u.memWaitValueTask;

    memWaitValueTask->devAddr = RtPtrToValue(devAddr);
    memWaitValueTask->value = value;
    memWaitValueTask->flag = flag;
    memWaitValueTask->baseFuncCallSvmMem = nullptr;
    memWaitValueTask->funcCallSvmMem2 = nullptr;
    memWaitValueTask->writeValueAddr = nullptr;
    memWaitValueTask->funCallMemSize2 = 0ULL;
    memWaitValueTask->retainedEventId = INVALID_EVENT_ID;
    memWaitValueTask->awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_64BIT;
    rtError_t ret = AllocFuncCallMemForMemWaitTask(taskInfo);
    ERROR_RETURN(ret, "Alloc func call svm failed, retCode=%#x.", ret);

    return RT_ERROR_NONE;
}

rtError_t CaptureWaitExternalTaskInit(TaskInfo* taskInfo, const void* const waitRefreshAddr)
{
    const rtError_t ret = MemWaitValueTaskInit(taskInfo, waitRefreshAddr, 1U, 0U);
    if (ret != RT_ERROR_NONE) {
        return ret;
    }
    taskInfo->typeName = "CAPTURE_WAIT_EXTERNAL";
    taskInfo->type = TS_TASK_TYPE_CAPTURE_WAIT_EXTERNAL;
    taskInfo->u.memWaitValueTask.awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT;
    taskInfo->sqeNum = static_cast<uint8_t>(GetSendSqeNum(taskInfo));
    return RT_ERROR_NONE;
}

rtError_t MemcpyAsyncTaskPrepare(TaskInfo* const updateTask, void** const hostAddr)
{
    Stream* const stream = updateTask->stream;
    const uint32_t devId = static_cast<uint32_t>(stream->Device_()->Id_());
    Driver* const driver = updateTask->stream->Device_()->Driver_();
    constexpr uint64_t allocSize = sizeof(rtStarsSqe_t);
    rtStarsSqe_t sqe = {};

    rtError_t error = driver->HostMemAlloc(hostAddr, allocSize, devId);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "Failed to alloc host memory, retCode=%#x.", error);

    /* construct new sqe */
    RT_LOG(RT_LOG_INFO, "update task, device_id=%u, stream_id=%d, task_id=%hu", devId, stream->Id_(), updateTask->id);

    ToConstructSqe(updateTask, &sqe);
    error =
        driver->MemCopySync(*hostAddr, allocSize, static_cast<const void*>(&sqe), allocSize, RT_MEMCPY_HOST_TO_HOST);
    COND_PROC_RETURN_ERROR(
        error != RT_ERROR_NONE, error, (void)driver->HostMemFree(*hostAddr), "MemCopySync failed, retCode=%#x.",
        static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t UpdateLabelSwitchTask(TaskInfo* const updateTask)
{
    uint64_t physicPtr = 0UL;
    StreamSwitchTaskInfo* streamSwitchTask = &(updateTask->u.streamswitchTask);
    const int32_t devId = static_cast<int32_t>(updateTask->stream->Device_()->Id_());
    rtError_t error =
        updateTask->stream->Device_()->Driver_()->MemAddressTranslate(devId, streamSwitchTask->ptr, &physicPtr);
    COND_RETURN_ERROR(
        (error != RT_ERROR_NONE), error, "Convert memory address to dma physic failed,retCode=%#x,ptr=%#" PRIx64 ".",
        error, streamSwitchTask->ptr);

    uint64_t physicValuePtr = 0UL;
    error = updateTask->stream->Device_()->Driver_()->MemAddressTranslate(
        devId, streamSwitchTask->valuePtr, &physicValuePtr);
    COND_RETURN_ERROR(
        (error != RT_ERROR_NONE), error,
        "Convert memory address to dma physic failed,retCode=%#x,valuePtr=%#" PRIx64 ".", error,
        streamSwitchTask->valuePtr);

    streamSwitchTask->phyPtr = physicPtr;
    streamSwitchTask->phyValuePtr = physicValuePtr;
    return error;
}

rtError_t UpdateTaskD2HSubmit(const TaskInfo* const updateTask, void* sqeAddr, Stream* const stm)
{
    TaskInfo submitTask = {};
    rtError_t errorReason;
    const size_t allocSize = sizeof(rtStarsSqe_t);
    const uint32_t sqId = updateTask->stream->GetSqId();
    const uint32_t pos = updateTask->pos;

    TaskInfo* rtMemcpyAsyncTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_MEMCPY, errorReason);
    NULL_PTR_RETURN_MSG(rtMemcpyAsyncTask, errorReason);

    std::function<void()> const rtMemcpyAsyncTaskRecycle = [&stm, &rtMemcpyAsyncTask]() {
        (void)stm->Device_()->GetTaskFactory()->Recycle(rtMemcpyAsyncTask);
    };
    ScopeGuard taskGuard(rtMemcpyAsyncTaskRecycle);

    rtError_t error = UpdateD2HTaskInit(rtMemcpyAsyncTask, sqeAddr, allocSize, sqId, pos, 0U);
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "device_id=%u, stream_id=%d, allocSize=%u, retCode=%#x.", stm->Device_()->Id_(), stm->Id_(),
            allocSize, error);
        return error;
    }

    error = stm->Device_()->SubmitTask(rtMemcpyAsyncTask);
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "device_id=%u, stream_id=%d, allocSize=%u, retCode=%#x.",
            updateTask->stream->Device_()->Id_(), stm->Id_(), allocSize, error);
        return error;
    }

    GET_THREAD_TASKID_AND_STREAMID(rtMemcpyAsyncTask, stm->AllocTaskStreamId());
    RT_LOG(
        RT_LOG_DEBUG, "device_id=%u, stream_id=%d, task_id=%hu, retCode=%#x.", stm->Device_()->Id_(), stm->Id_(),
        updateTask->id, error);

    taskGuard.ReleaseGuard();
    return RT_ERROR_NONE;
}

static rtError_t UpdateModelUpdateTask(TaskInfo* const taskInfo)
{
    MdlUpdateTaskInfo* mdlUpdateTaskInfo = &(taskInfo->u.mdlUpdateTask);
    uint64_t tilingTaboffset = 0ULL;
    uint64_t tilingKeyOffset = 0ULL;
    uint64_t blockDimOffset = 0ULL;
    uint64_t descBufOffset = MAX_UINT64_NUM;
    void* devCopyMem = mdlUpdateTaskInfo->tilingTabAddr;

    rtError_t error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(
        static_cast<int32_t>(taskInfo->stream->Device_()->Id_()),
        RtPtrToPtr<uintptr_t>(mdlUpdateTaskInfo->tilingKeyAddr), &tilingKeyOffset);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "tilingKeyAddr MemAddressTranslate retCode=%#x.", error);

    error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(
        static_cast<int32_t>(taskInfo->stream->Device_()->Id_()),
        RtPtrToPtr<uintptr_t>(mdlUpdateTaskInfo->blockDimAddr), &blockDimOffset);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "blockDimAddr MemAddressTranslate retCode=%#x", error);

    error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(
        static_cast<int32_t>(taskInfo->stream->Device_()->Id_()), RtPtrToPtr<uintptr_t>(devCopyMem), &tilingTaboffset);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "devCopyMem MemAddressTranslate retCode=%#x.", error);

    if (mdlUpdateTaskInfo->fftsPlusTaskDescBuf != nullptr) {
        error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(
            static_cast<int32_t>(taskInfo->stream->Device_()->Id_()),
            RtPtrToPtr<uintptr_t>(mdlUpdateTaskInfo->fftsPlusTaskDescBuf), &descBufOffset);
    } else {
        error =
            SetMixDescBufOffset(taskInfo, mdlUpdateTaskInfo->desStreamId, mdlUpdateTaskInfo->destaskId, &descBufOffset);
    }
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "descBuf MemAddressTranslate retCode=%#x.", error);

    mdlUpdateTaskInfo->descBufOffset = descBufOffset;
    mdlUpdateTaskInfo->tilingKeyOffset = tilingKeyOffset;
    mdlUpdateTaskInfo->blockDimOffset = blockDimOffset;
    mdlUpdateTaskInfo->tilingTabOffset = tilingTaboffset;
    RT_LOG(
        RT_LOG_DEBUG, "descBufOffset=%lu, tilingKeyOffset=%lu, blockDimOffset=%u, tilingTabOffset=%u, prgHandle=%p.",
        descBufOffset, tilingKeyOffset, blockDimOffset, tilingTaboffset, mdlUpdateTaskInfo->prgHandle);
    return RT_ERROR_NONE;
}

rtError_t UpdateTaskH2DSubmit(TaskInfo* const updateTask, Stream* const stm, void* sqeDeviceAddr)
{
    TaskInfo submitTask = {};
    rtError_t errorReason;
    rtError_t error = RT_ERROR_NONE;
    constexpr uint64_t copySize = sizeof(rtStarsSqe_t);
    Driver* const curDrv = stm->Device_()->Driver_();

    if (updateTask->type == TS_TASK_TYPE_MODEL_TASK_UPDATE) {
        error = UpdateModelUpdateTask(updateTask);
    } else if (updateTask->type == TS_TASK_TYPE_STREAM_SWITCH) {
        error = UpdateLabelSwitchTask(updateTask);
    } else {
        // do nothing
    }
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "update dma or offset failed, retCode=%#x", error);
    TaskInfo* rtMemcpyAsyncTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_MEMCPY, errorReason);
    NULL_PTR_RETURN_MSG(rtMemcpyAsyncTask, errorReason);
    std::function<void()> const rtMemcpyAsyncTaskRecycle = [&stm, &rtMemcpyAsyncTask]() {
        (void)stm->Device_()->GetTaskFactory()->Recycle(rtMemcpyAsyncTask);
    };
    ScopeGuard taskGuard(rtMemcpyAsyncTaskRecycle);

    /* hostAddr is new sqe info */
    void* hostAddr = nullptr;
    error = MemcpyAsyncTaskPrepare(updateTask, &hostAddr);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, stream_id=%d, retCode=%#x.", stm->Device_()->Id_(), stm->Id_(), error);
        return error;
    }

    error = SqeUpdateH2DTaskInit(rtMemcpyAsyncTask, hostAddr, sqeDeviceAddr, copySize, nullptr, nullptr);
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "device_id=%u, stream_id=%d, allocSize=%llu, retCode=%#x.", stm->Device_()->Id_(), stm->Id_(),
            copySize, error);
        (void)curDrv->HostMemFree(hostAddr);
        return error;
    }

    error = stm->Device_()->SubmitTask(rtMemcpyAsyncTask);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, stream_id=%d, retCode=%#x.", stm->Device_()->Id_(), stm->Id_(), error);
        return error;
    }
    GET_THREAD_TASKID_AND_STREAMID(rtMemcpyAsyncTask, stm->AllocTaskStreamId());
    RT_LOG(
        RT_LOG_DEBUG, "device_id=%u, stream_id=%d, task_id=%hu, retCode=%#x.", stm->Device_()->Id_(), stm->Id_(),
        rtMemcpyAsyncTask->id, error);
    taskGuard.ReleaseGuard();
    return RT_ERROR_NONE;
}

void IpcEventDestroy(IpcEvent** eventPtr, int32_t freeId, bool isNeedDestroy)
{
    COND_RETURN_VOID(*eventPtr == nullptr, "event is nullptr");
    bool canEventbeDelete = (*eventPtr)->TryFreeEventIdAndCheckCanBeDelete(freeId, isNeedDestroy);
    if (canEventbeDelete) {
        (void)(*eventPtr)->ReleaseDrvResource();
        delete *eventPtr;
        (*eventPtr) = nullptr;
    }
}

static void SetCommonTaskParams(rtTaskParams* const params)
{
    params->taskGrp = nullptr;
    params->opInfoPtr = nullptr;
    params->opInfoSize = 0U;
}

rtError_t GetCaptureRecordTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params)
{
    params->type = RT_TASK_EVENT_RECORD;
    SetCommonTaskParams(params);

    Event* event = taskInfo->u.memWriteValueTask.event;
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        event, RT_ERROR_INVALID_VALUE, "Obtaining the Event Record task parameters in capture mode");
    params->eventRecordTaskParams.event = event;
    params->eventRecordTaskParams.eventFlag = static_cast<uint32_t>(event->GetEventFlag());
    params->eventRecordTaskParams.recordFlag =
        (taskInfo->type == TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL) ? RT_EVENT_RECORD_EXTERNAL : RT_EVENT_RECORD_DEFAULT;

    return RT_ERROR_NONE;
}

rtError_t GetCaptureWaitTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params)
{
    params->type = RT_TASK_EVENT_WAIT;
    SetCommonTaskParams(params);

    Event* event = taskInfo->u.memWaitValueTask.event;
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        event, RT_ERROR_INVALID_VALUE, "Obtaining the Event Wait task parameters in capture mode");
    params->eventWaitTaskParams.event = event;
    params->eventWaitTaskParams.eventFlag = static_cast<uint32_t>(event->GetEventFlag());
    params->eventWaitTaskParams.waitFlag =
        (taskInfo->type == TS_TASK_TYPE_CAPTURE_WAIT_EXTERNAL) ? RT_EVENT_WAIT_EXTERNAL : RT_EVENT_WAIT_DEFAULT;

    return RT_ERROR_NONE;
}

rtError_t GetCaptureResetTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params)
{
    params->type = RT_TASK_EVENT_RESET;
    SetCommonTaskParams(params);

    Event* event = taskInfo->u.memWriteValueTask.event;
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        event, RT_ERROR_INVALID_VALUE, "Obtaining the Event Reset task parameters in capture mode");
    params->eventResetTaskParams.event = event;
    params->eventResetTaskParams.eventFlag = static_cast<uint32_t>(event->GetEventFlag());
    params->eventResetTaskParams.resetFlag = RT_EVENT_WAIT_DEFAULT;

    return RT_ERROR_NONE;
}

rtError_t GetWriteValueTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params)
{
    params->type = RT_TASK_VALUE_WRITE;
    SetCommonTaskParams(params);

    params->valueWriteTaskParams.devAddr = RtValueToPtr<void*>(taskInfo->u.memWriteValueTask.devAddr);
    params->valueWriteTaskParams.value = taskInfo->u.memWriteValueTask.value;

    return RT_ERROR_NONE;
}

rtError_t GetWaitValueTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params)
{
    params->type = RT_TASK_VALUE_WAIT;
    SetCommonTaskParams(params);

    params->valueWaitTaskParams.devAddr = RtValueToPtr<void*>(taskInfo->u.memWaitValueTask.devAddr);
    params->valueWaitTaskParams.value = taskInfo->u.memWaitValueTask.value;
    params->valueWaitTaskParams.flag = taskInfo->u.memWaitValueTask.flag;

    return RT_ERROR_NONE;
}

static rtError_t CheckUpdatingTaskParams(TaskInfo* const taskInfo, rtTaskParams* const params)
{
    rtTaskType taskType;
    rtError_t error = ConvertTaskType(taskInfo, &taskType);
    ERROR_RETURN(error, "get task type failed, retCode=%#x.", error);
    // RT_TASK_DEFAULT表示外部不识别的类型，报错并打印RTS内部具体的Task类型
    COND_RETURN_ERROR(
        taskType == RT_TASK_DEFAULT, RT_ERROR_INVALID_VALUE, "current taskType(%d) is invalid", taskInfo->type);

    COND_RETURN_ERROR(params->taskGrp != nullptr, RT_ERROR_INVALID_VALUE, "taskGrp must be nullptr");
    COND_RETURN_ERROR(params->opInfoPtr != nullptr, RT_ERROR_INVALID_VALUE, "opInfoPtr must be nullptr");
    COND_RETURN_ERROR(params->opInfoSize != 0U, RT_ERROR_INVALID_VALUE, "opInfoSize must be 0");

    COND_RETURN_WARN(
        IsTaskBelongToSubCaptureMdl(taskInfo), RT_ERROR_FEATURE_NOT_SUPPORT,
        "task belongs to sub ACL Graph, does not support updating task parameters");

    return RT_ERROR_NONE;
}

rtError_t UpdateWriteValueTaskParams(TaskInfo* const taskInfo, rtTaskParams* const params)
{
    ERROR_RETURN(CheckUpdatingTaskParams(taskInfo, params), "task type or input params is invalid");

    TaskUnInitProc(taskInfo);
    (void)MemWriteValueTaskInit(taskInfo, params->valueWriteTaskParams.devAddr, params->valueWriteTaskParams.value);
    taskInfo->u.memWriteValueTask.awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_64BIT;
    taskInfo->type = TS_TASK_TYPE_MEM_WRITE_VALUE;
    taskInfo->typeName = "MEM_WRITE_VALUE";
    taskInfo->sqeNum = 1U;

    Stream* stm = taskInfo->stream;
    Device* dev = stm->Device_();
    RT_LOG(
        RT_LOG_INFO,
        "update or convert to ValueWriteTask succ: device_id=%u, stream_id=%d, task_id=%hu, "
        "typeName=%s, taskType=%d, devAddr=%#llx, value=%llu",
        dev->Id_(), stm->Id_(), taskInfo->id, taskInfo->typeName, taskInfo->type, taskInfo->u.memWriteValueTask.devAddr,
        taskInfo->u.memWriteValueTask.value);
    return RT_ERROR_NONE;
}

rtError_t UpdateWaitValueTaskParams(TaskInfo* const taskInfo, rtTaskParams* const params)
{
    ERROR_RETURN(CheckUpdatingTaskParams(taskInfo, params), "task type or input params is invalid");

    TaskUnInitProc(taskInfo);
    // 需要先赋值类型，此类型会影响Init中的内存申请方式
    taskInfo->type = TS_TASK_TYPE_MEM_WAIT_VALUE;
    taskInfo->typeName = "MEM_WAIT_VALUE";
    const rtError_t error = MemWaitValueTaskInit(
        taskInfo, params->valueWaitTaskParams.devAddr, params->valueWaitTaskParams.value,
        params->valueWaitTaskParams.flag);
    ERROR_RETURN_MSG_INNER(error, "mem wait value init failed, retCode=%#x.", error);
    taskInfo->u.memWaitValueTask.awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_64BIT;
    taskInfo->sqeNum = GetSendSqeNum(taskInfo);

    Stream* stm = taskInfo->stream;
    Device* dev = stm->Device_();
    RT_LOG(
        RT_LOG_INFO,
        "update or convert to ValueWaitTask succ: device_id=%u, stream_id=%d, task_id=%hu, "
        "typeName=%s, taskType=%d, devAddr=%#llx, value=%llu, flag=%u",
        dev->Id_(), stm->Id_(), taskInfo->id, taskInfo->typeName, taskInfo->type, taskInfo->u.memWaitValueTask.devAddr,
        taskInfo->u.memWaitValueTask.value, taskInfo->u.memWaitValueTask.flag);
    return RT_ERROR_NONE;
}
#endif

#if F_DESC("CreateL2AddrTask")
rtError_t CreateL2AddrTaskInit(TaskInfo* const taskInfo, const uint64_t ptePtrAddr)
{
    CreateL2AddrTaskInfo* createL2AddrTaskInfo = &(taskInfo->u.createL2AddrTaskInfo);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_CREATE_L2_ADDR;
    taskInfo->typeName = "CREATE_L2_ADDR";
    createL2AddrTaskInfo->ptePA = ptePtrAddr;
    return RT_ERROR_NONE;
}

void ToCommandBodyForCreateL2AddrTask(TaskInfo* const taskInfo, rtCommand_t* const command)
{
    CreateL2AddrTaskInfo* createL2AddrTaskInfo = &(taskInfo->u.createL2AddrTaskInfo);
    Stream* const stream = taskInfo->stream;

    command->u.createL2Addr.l2BaseVaddrForsdma = RtPtrToValue<void*>(stream->Device_()->GetL2Buffer_());
    RT_LOG(RT_LOG_DEBUG, "l2BaseVaddrForsdma=%#" PRIx64, command->u.createL2Addr.l2BaseVaddrForsdma);
    command->u.createL2Addr.ptePA = createL2AddrTaskInfo->ptePA;
    RT_LOG(RT_LOG_DEBUG, "ptePA=%#" PRIx64, command->u.createL2Addr.ptePA);
    command->u.createL2Addr.pid = PidTidFetcher::GetCurrentPid();
    command->u.createL2Addr.virAddr = MAX_UINT32_NUM;
}
#endif

#if F_DESC("UpdateAddressTask")
rtError_t UpdateAddressTaskInit(TaskInfo* taskInfo, uint64_t devAddr, uint64_t len)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "Update_Address";
    taskInfo->type = TS_TASK_TYPE_UPDATE_ADDRESS;
    taskInfo->u.updateAddrTask.devAddr = devAddr;
    taskInfo->u.updateAddrTask.len = len;
    return RT_ERROR_NONE;
}
#endif

} // namespace runtime
} // namespace cce
