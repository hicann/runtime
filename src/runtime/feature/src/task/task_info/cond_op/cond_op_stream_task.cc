/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
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
#include "stars_cond_isa_helper.hpp"
#include "task_manager.h"
#include "cond_op_task.h"
#include "stub_task.hpp"

namespace cce {
namespace runtime {

#if F_DESC("StreamSwitchTask")
#if (!defined(CFG_VECTOR_CAST))
rtError_t InitFuncCallParaForStreamSwitchTaskV1(TaskInfo* taskInfo, rtStarsStreamSwitchFcPara_t &fcPara,
    const rtChipType_t chipType)
{
    Stream *stm = taskInfo->stream;
    StreamSwitchTaskInfo* streamSwitchTask = &(taskInfo->u.streamswitchTask);
    Stream* trueStream = streamSwitchTask->trueStream;
    uint16_t * const execTimesSvm = trueStream->GetExecutedTimesSvm();
    fcPara.streamExecTimesAddr = RtPtrToValue(execTimesSvm);
    fcPara.currentSqId = static_cast<uint32_t>(stm->GetSqId());
    fcPara.trueSqId = static_cast<uint32_t>(trueStream->GetSqId());
    fcPara.varPtr = streamSwitchTask->ptr;
    fcPara.condition = streamSwitchTask->condition;
    const uint64_t sqVirtualAddr = trueStream->GetSqRegVirtualAddr();
    DevProperties props;
    // 此处应该使用device中的函数，但由于UT中动态切换芯片类型，为保证UT通过使用宏
    auto error = GET_DEV_PROPERTIES(chipType, props);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE,
        "Failed to get properties");

    if (props.isSupportInitFuncCallPara) {
        fcPara.rtSqFsmStateAddr = props.rtsqVirtualAddr.rtSqFsmStateAddr;
        fcPara.rtSqEnableAddr = props.rtsqVirtualAddr.rtSqEnableAddr + sqVirtualAddr;
        fcPara.rtSqTailAddr = props.rtsqVirtualAddr.rtSqTailAddr + sqVirtualAddr;
        fcPara.rtSqHeadAddr = props.rtsqVirtualAddr.rtSqHeadAddr + sqVirtualAddr;

        if (props.rtsqFsmStateAddrCalMethod == RtsqFsmStateAddrCalMethod::FSM_ADDR_CALCULATE_BY_DEVICE_INFO) {
            const uint64_t chipAddr = taskInfo->stream->Device_()->GetChipAddr();
            const uint64_t chipOffset = taskInfo->stream->Device_()->GetChipOffset();
            const uint64_t dieOffset = taskInfo->stream->Device_()->GetDieOffset();
            fcPara.rtSqFsmStateAddr = props.rtsqVirtualAddr.rtSqFsmStateAddr + chipAddr +
                                      (chipOffset * static_cast<uint64_t>(trueStream->Device_()->GetPhyChipId())) +
                                      (dieOffset * static_cast<uint64_t>(stm->Device_()->GetPhyDieId()));
        }

        if (props.starsBaseAddrMethod == StarsBaseAddrMethod::STARS_BASE_CALCULATE_BY_DRIVER) {
            const uint64_t baseAddr = stm->Device_()->GetStarsRegBaseAddr();
            if (baseAddr == 0ULL) {
                RT_LOG(RT_LOG_ERROR, "invalid device_id=%u, physic chip_id=%u, die_id=%u, stream_id=%d.",
                    stm->Device_()->Id_(), stm->Device_()->GetPhyChipId(), stm->Device_()->GetPhyDieId(), stm->Id_());
                return RT_ERROR_DEVICE_INVALID;
            }
            fcPara.rtSqFsmStateAddr = props.rtsqVirtualAddr.rtSqFsmStateAddr + baseAddr;
        }

        if (props.rtSqEnableAddrCalMethod == RtSqEnableAddrCalMethod::RT_SQ_ENABLE_ADDR_CAL_BY_TRUE_SQID) {
            fcPara.rtSqEnableAddr = props.rtsqVirtualAddr.rtSqEnableAddr +
                                    RT_SIMPLE_SQ_OFFSET_1000 * static_cast<uint64_t>(fcPara.trueSqId);
            fcPara.rtSqTailAddr = props.rtsqVirtualAddr.rtSqTailAddr +
                                  RT_SIMPLE_SQ_OFFSET_1000 * static_cast<uint64_t>(fcPara.trueSqId);
            fcPara.rtSqHeadAddr = props.rtsqVirtualAddr.rtSqHeadAddr +
                                  RT_SIMPLE_SQ_OFFSET_1000 * static_cast<uint64_t>(fcPara.trueSqId);
        }
    } else {
        RT_LOG(RT_LOG_DEBUG, "current chipType[%d] not support init func call para", chipType);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    return RT_ERROR_NONE;
}

rtError_t InitFuncCallParaForStreamSwitchTaskV2(TaskInfo* taskInfo, rtStarsStreamSwitchExFcPara_t &fcPara,
    const rtChipType_t chipType)
{
    Stream *stm = taskInfo->stream;
    StreamSwitchTaskInfo* streamSwitchTask = &(taskInfo->u.streamswitchTask);
    Stream* trueStream = streamSwitchTask->trueStream;
    uint16_t * const execTimesSvm = trueStream->GetExecutedTimesSvm();
    fcPara.streamExecTimesAddr = RtPtrToValue(execTimesSvm);
    fcPara.currentSqId = static_cast<uint32_t>(stm->GetSqId());
    fcPara.trueSqId = static_cast<uint32_t>(trueStream->GetSqId());
    fcPara.varPtr = streamSwitchTask->ptr;
    fcPara.condition = streamSwitchTask->condition;
    const uint64_t sqVirtualAddr = trueStream->GetSqRegVirtualAddr();
    DevProperties props;
    // 此处应该使用device中的函数，但由于UT中动态切换芯片类型，为保证UT通过使用宏
    auto error = GET_DEV_PROPERTIES(chipType, props);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE,
        "Failed to get properties");

    if (props.isSupportInitFuncCallPara) {
        fcPara.rtSqFsmStateAddr = props.rtsqVirtualAddr.rtSqFsmStateAddr;
        fcPara.rtSqEnableAddr = props.rtsqVirtualAddr.rtSqEnableAddr + sqVirtualAddr;
        fcPara.rtSqTailAddr = props.rtsqVirtualAddr.rtSqTailAddr + sqVirtualAddr;
        fcPara.rtSqHeadAddr = props.rtsqVirtualAddr.rtSqHeadAddr + sqVirtualAddr;

        if (props.rtsqFsmStateAddrCalMethod == RtsqFsmStateAddrCalMethod::FSM_ADDR_CALCULATE_BY_DEVICE_INFO) {
            const uint64_t chipAddr = taskInfo->stream->Device_()->GetChipAddr();
            const uint64_t chipOffset = taskInfo->stream->Device_()->GetChipOffset();
            const uint64_t dieOffset = taskInfo->stream->Device_()->GetDieOffset();
            fcPara.rtSqFsmStateAddr = props.rtsqVirtualAddr.rtSqFsmStateAddr + chipAddr +
                                      (chipOffset * static_cast<uint64_t>(trueStream->Device_()->GetPhyChipId())) +
                                      (dieOffset * static_cast<uint64_t>(stm->Device_()->GetPhyDieId()));
        }

        if (props.starsBaseAddrMethod == StarsBaseAddrMethod::STARS_BASE_CALCULATE_BY_DRIVER) {
            const uint64_t baseAddr = stm->Device_()->GetStarsRegBaseAddr();
            if (baseAddr == 0ULL) {
                RT_LOG(RT_LOG_ERROR, "invalid device_id=%u, physic chip_id=%u, die_id=%u, stream_id=%d.",
                    stm->Device_()->Id_(), stm->Device_()->GetPhyChipId(), stm->Device_()->GetPhyDieId(), stm->Id_());
                return RT_ERROR_DEVICE_INVALID;
            }
            fcPara.rtSqFsmStateAddr = props.rtsqVirtualAddr.rtSqFsmStateAddr + baseAddr;
        }

        if (props.rtSqEnableAddrCalMethod == RtSqEnableAddrCalMethod::RT_SQ_ENABLE_ADDR_CAL_BY_TRUE_SQID) {
            fcPara.rtSqEnableAddr = props.rtsqVirtualAddr.rtSqEnableAddr +
                                    RT_SIMPLE_SQ_OFFSET_1000 * static_cast<uint64_t>(fcPara.trueSqId);
            fcPara.rtSqTailAddr = props.rtsqVirtualAddr.rtSqTailAddr +
                                  RT_SIMPLE_SQ_OFFSET_1000 * static_cast<uint64_t>(fcPara.trueSqId);
            fcPara.rtSqHeadAddr = props.rtsqVirtualAddr.rtSqHeadAddr +
                                  RT_SIMPLE_SQ_OFFSET_1000 * static_cast<uint64_t>(fcPara.trueSqId);
        }
    } else {
        RT_LOG(RT_LOG_DEBUG, "current chipType[%d] not support init func call para", chipType);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    return RT_ERROR_NONE;
}
#endif

rtError_t AllocFuncCallMemForStreamSwitchTask(TaskInfo* taskInfo)
{
    void *devMem = nullptr;
    StreamSwitchTaskInfo* streamSwitchTask = &(taskInfo->u.streamswitchTask);
    const auto dev = taskInfo->stream->Device_();
    const uint64_t allocSize = streamSwitchTask->funCallMemSize + TS_STARS_COND_DFX_SIZE + FUNC_CALL_INSTR_ALIGN_SIZE;
    const rtError_t ret = dev->Driver_()->DevMemAlloc(&devMem, allocSize, RT_MEMORY_DDR, dev->Id_());
    COND_RETURN_ERROR((ret != RT_ERROR_NONE) || (devMem == nullptr), ret,
                      "alloc func call memory failed,retCode=%#x,size=%" PRIu64 "(bytes),dev_id=%u",
                      ret, streamSwitchTask->funCallMemSize, dev->Id_());

    streamSwitchTask->baseFuncCallSvmMem = devMem;
    // instr addr should align to 256b
    if ((RtPtrToValue(devMem) & 0xFFULL) != 0ULL) {
        // 2 ^ 8 is 256 align
        const uint64_t devMemAlign = (((RtPtrToValue(devMem)) >> 8U) + 1UL) << 8U;
        devMem = RtValueToPtr<void *>(devMemAlign);
    }
    streamSwitchTask->funcCallSvmMem = devMem;
    streamSwitchTask->dfxPtr = RtValueToPtr<void *>(RtPtrToValue(streamSwitchTask->funcCallSvmMem) +
        streamSwitchTask->funCallMemSize);
    return RT_ERROR_NONE;
}

rtError_t FreeFuncCallMemForStreamSwitchTask(TaskInfo * const taskInfo)
{
    StreamSwitchTaskInfo* streamSwitchTask = &(taskInfo->u.streamswitchTask);
    if (streamSwitchTask->baseFuncCallSvmMem != nullptr) {
        const auto dev = taskInfo->stream->Device_();
        const rtError_t ret = dev->Driver_()->DevMemFree(streamSwitchTask->baseFuncCallSvmMem, dev->Id_());
        COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret,
            "Free func call svm mem free failed,retCode=%#x,dev_id=%u.", ret, dev->Id_());
        streamSwitchTask->baseFuncCallSvmMem = nullptr;
        streamSwitchTask->dfxPtr = nullptr;
        streamSwitchTask->funcCallSvmMem = nullptr;
    }

    streamSwitchTask->funCallMemSize = 0UL;
    return RT_ERROR_NONE;
}

rtError_t PrepareSqeInfoForStreamSwitchTask(TaskInfo* taskInfo)
{
    rtError_t ret;
    const rtChipType_t chipType = taskInfo->stream->Device_()->GetChipType();
    const rtMemcpyKind_t kind = (
        taskInfo->stream->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_MEM_COPY_DOT_D2D_ONLY)) ? 
        RT_MEMCPY_DEVICE_TO_DEVICE : RT_MEMCPY_HOST_TO_DEVICE;

    StreamSwitchTaskInfo* streamSwitchTask = &(taskInfo->u.streamswitchTask);
    if (streamSwitchTask->isCondEx) {
        rtStarsStreamSwitchExFc_t exFc = {};
        rtStarsStreamSwitchExFcPara_t exFcPara = {};
#if (!defined(CFG_VECTOR_CAST))
        (void)InitFuncCallParaForStreamSwitchTaskV2(taskInfo, exFcPara, chipType);
#endif
        ret = AllocFuncCallMemForStreamSwitchTask(taskInfo);
        ERROR_RETURN(ret, "Alloc func call svm failed,retCode=%#x.", ret);
        exFcPara.dataType = streamSwitchTask->dataType;
        exFcPara.valPtr = streamSwitchTask->valuePtr;
        exFcPara.dfxAddr = RtPtrToValue(streamSwitchTask->dfxPtr);
        ERROR_RETURN(ret, "Init func call para failed,retCode=%#x.", ret);
        ConstructStreamSwitchExFc(exFc, exFcPara);
        ret = taskInfo->stream->Device_()->Driver_()->MemCopySync(
            streamSwitchTask->funcCallSvmMem, streamSwitchTask->funCallMemSize,
            &exFc, streamSwitchTask->funCallMemSize, kind);
    } else {
        rtStarsStreamSwitchFc_t fc = {};
        rtStarsStreamSwitchFcPara_t fcPara = {};
#if (!defined(CFG_VECTOR_CAST))
        (void)InitFuncCallParaForStreamSwitchTaskV1(taskInfo, fcPara, chipType);
#endif
        ret = AllocFuncCallMemForStreamSwitchTask(taskInfo);
        ERROR_RETURN(ret, "Alloc func call svm failed,retCode=%#x.", ret);
        fcPara.val = static_cast<uint64_t>(streamSwitchTask->value);
        fcPara.dfxAddr = RtPtrToValue(streamSwitchTask->dfxPtr);
        ERROR_RETURN(ret, "Init func call para failed,retCode=%#x.", ret);
        ConstructStreamSwitchFc(fc, fcPara);
        ret = taskInfo->stream->Device_()->Driver_()->MemCopySync(
            streamSwitchTask->funcCallSvmMem, streamSwitchTask->funCallMemSize, &fc,
            streamSwitchTask->funCallMemSize, kind);
    }

    if (ret != RT_ERROR_NONE) {
        (void)FreeFuncCallMemForStreamSwitchTask(taskInfo);
        RT_LOG(RT_LOG_ERROR, "MemCopySync for stream active func call failed,retCode=%#x.", ret);
    }

    return ret;
}

rtError_t StreamSwitchTaskInitV1(TaskInfo *taskInfo, const void *const ptrAddr,
    const rtCondition_t condi, const int64_t valueNum, const Stream * const trueStream)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_STREAM_SWITCH;
    taskInfo->typeName = "STREAM_SWITCH";

    Stream * const stm = taskInfo->stream;
    StreamSwitchTaskInfo* streamSwitchTask = &(taskInfo->u.streamswitchTask);
    streamSwitchTask->valuePtr = 0UL;
    streamSwitchTask->phyValuePtr = 0UL;
    streamSwitchTask->dataType = RT_SWITCH_INT32;
    streamSwitchTask->funcCallSvmMem = nullptr;
    streamSwitchTask->baseFuncCallSvmMem = nullptr;
    streamSwitchTask->dfxPtr = nullptr;
    streamSwitchTask->ptr = RtPtrToValue(ptrAddr);
    streamSwitchTask->condition = condi;
    streamSwitchTask->value = valueNum;
    streamSwitchTask->trueStreamId = static_cast<uint32_t>(trueStream->Id_());
    streamSwitchTask->isCondEx = false;
    streamSwitchTask->trueStream = const_cast<Stream*>(trueStream);
    streamSwitchTask->funCallMemSize = sizeof(rtStarsStreamSwitchFc_t);

    // now esl b606 cond is only support physic address, virtual address is support on b607.
    uint64_t physicPtr = 0UL;
    rtError_t error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(
        static_cast<int32_t>(stm->Device_()->Id_()), streamSwitchTask->ptr, &physicPtr);
    ERROR_RETURN_MSG_INNER(error, "Convert memory address[%#" PRIx64 "] from virtual to dma physic failed, retCode=%#x",
                           streamSwitchTask->ptr, error);
    streamSwitchTask->phyPtr = physicPtr;

    if (stm->Device_()->IsStarsPlatform()) {
        error = PrepareSqeInfoForStreamSwitchTask(taskInfo);
        ERROR_RETURN_MSG_INNER(error, "init for stars failed,retCode=%#x.", error);
    }
    return RT_ERROR_NONE;
}

rtError_t StreamSwitchTaskInitV2(TaskInfo *taskInfo, const void *const ptrAddr,
    const rtCondition_t condi, const Stream * const trueStream,
    const void *const valPtr, const rtSwitchDataType_t taskDataType)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_STREAM_SWITCH;
    taskInfo->typeName = "STREAM_SWITCH";

    Stream * const stm = taskInfo->stream;
    StreamSwitchTaskInfo* streamSwitchTask = &(taskInfo->u.streamswitchTask);
    streamSwitchTask->value = 0L;
    streamSwitchTask->funcCallSvmMem = nullptr ;
    streamSwitchTask->baseFuncCallSvmMem = nullptr;
    streamSwitchTask->dfxPtr = nullptr;

    const int32_t devId = static_cast<int32_t>(stm->Device_()->Id_());
    streamSwitchTask->ptr = RtPtrToValue(ptrAddr);
    streamSwitchTask->valuePtr = RtPtrToValue(valPtr);
    streamSwitchTask->condition = condi;
    streamSwitchTask->trueStreamId = static_cast<uint32_t>(trueStream->Id_());
    streamSwitchTask->dataType = taskDataType;
    streamSwitchTask->isCondEx = true;
    streamSwitchTask->trueStream = const_cast<Stream*>(trueStream);
    streamSwitchTask->funCallMemSize = sizeof(rtStarsStreamSwitchExFc_t);
    rtError_t error;
    // now esl b606 cond is only support physic address, virtual address is support on b607.
    if (!stm->Device_()->IsDavidPlatform()) {
        uint64_t physicPtr = 0UL;
        error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(devId, streamSwitchTask->ptr, &physicPtr);
        ERROR_RETURN_MSG_INNER(error, "Convert memory address to dma physic failed,retCode=%#x,ptr=%#" PRIx64 ".",
            error, streamSwitchTask->ptr);

        uint64_t physicValuePtr = 0UL;
        error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(devId, RtPtrToValue(valPtr), &physicValuePtr);
        ERROR_RETURN_MSG_INNER(error,
            "Convert memory address to dma physic failed,retCode=%#x,valuePtr=%#" PRIx64 ".",
            error, streamSwitchTask->valuePtr);

        streamSwitchTask->phyPtr = physicPtr;
        streamSwitchTask->phyValuePtr = physicValuePtr;
    }

    if (stm->Device_()->IsStarsPlatform()) {
        error = PrepareSqeInfoForStreamSwitchTask(taskInfo);
        ERROR_RETURN_MSG_INNER(error, "init for stars failed,retCode=%#x.", error);
    }
    return RT_ERROR_NONE;
}

void StreamSwitchTaskUnInit(TaskInfo * const taskInfo)
{
    (void)FreeFuncCallMemForStreamSwitchTask(taskInfo);
}

void ToCommandBodyForStreamSwitchTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    StreamSwitchTaskInfo* streamSwitchTask = &(taskInfo->u.streamswitchTask);
    uint8_t isCondEx = static_cast<uint8_t>(streamSwitchTask->isCondEx ? 1U : 0U);
    command->u.streamswitchTask.pptr = streamSwitchTask->phyPtr;
    command->u.streamswitchTask.condition = static_cast<uint32_t>(streamSwitchTask->condition);
    command->u.streamswitchTask.value = streamSwitchTask->value;
    command->u.streamswitchTask.trueStreamId = static_cast<uint16_t>(streamSwitchTask->trueStreamId);
    command->u.streamswitchTask.pValuePtr = streamSwitchTask->phyValuePtr;
    command->u.streamswitchTask.dataType = static_cast<uint8_t>(streamSwitchTask->dataType);
    command->u.streamswitchTask.isCondEx = isCondEx;
    command->u.streamswitchTask.pptrVirAddr = MAX_UINT32_NUM;
    command->u.streamswitchTask.pValuePtrVirAddr = MAX_UINT32_NUM;
}

void ConstructSqeForStreamSwitchTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    Stream * const stm = taskInfo->stream;
    StreamSwitchTaskInfo* streamSwitchTask = &(taskInfo->u.streamswitchTask);
    RtStarsFunctionCallSqe &sqe = command->fuctionCallSqe;
    sqe.kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe.csc = 1U;
    sqe.sqeHeader.l1_lock = 0U;
    sqe.sqeHeader.l1_unlock = 0U;
    sqe.sqeHeader.type = RT_STARS_SQE_TYPE_COND;
    sqe.sqeHeader.wr_cqe = stm->GetStarsWrCqeFlag();
    sqe.sqeHeader.block_dim = 0U;
    sqe.sqeHeader.rt_stream_id = static_cast<uint16_t>(stm->Id_());
    sqe.sqeHeader.task_id = taskInfo->id;
    if (streamSwitchTask->isCondEx) {
        sqe.conds_sub_type = CONDS_SUB_TYPE_STREAM_SWITCH_EX;
    } else {
        sqe.conds_sub_type = CONDS_SUB_TYPE_STREAM_SWITCH;
    }

    const uint64_t funcAddr = RtPtrToValue(streamSwitchTask->funcCallSvmMem);

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (streamSwitchTask->funCallMemSize / 4UL), sqe);

    PrintSqe(command, "StreamSwitchTask");
    RT_LOG(RT_LOG_INFO, "StreamSwitchTask current stream_id=%d task_id=%hu true_stream_id_=%u.",
        stm->Id_(), taskInfo->id, streamSwitchTask->trueStreamId);

    return;
}

void PrintErrorInfoForStreamSwitchTask(TaskInfo* taskInfo, const uint32_t devId)
{
    Stream * const stm = taskInfo->stream;
    StreamSwitchTaskInfo* streamSwitchTask = &(taskInfo->u.streamswitchTask);

    const uint32_t taskId = taskInfo->id;
    const int32_t streamId = stm->Id_();
    Stream *const reportStream = GetReportStream(stm);
    if (stm->Device_()->IsStarsPlatform()) {
        uint64_t dfx[8U];
        (void)taskInfo->stream->Device_()->Driver_()->MemCopySync(dfx, sizeof(dfx), streamSwitchTask->dfxPtr,
            sizeof(dfx), RT_MEMCPY_DEVICE_TO_HOST);
        RT_LOG(RT_LOG_ERROR, "stream_id=%u,task_id=%u,true_sq_iq=%u,active_sq_id=%" PRIu64
            ",fsm_state=%" PRIu64 ",enable=%" PRIu64",head=%" PRIu64 ",tail=%" PRIu64,
            streamId, taskId, streamSwitchTask->trueStream->GetSqId(), dfx[0U] & 0xFFFU, dfx[0U] >> 32U, dfx[1U],
            dfx[2U] >> 48U, dfx[3U] >> 48U);
    }
    STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_GE,
        "StreamSwitchTask execute failed,device_id=%u,stream_id=%d,%s=%u",
        devId, streamId, TaskIdDesc(), taskId);
}

#endif

#if F_DESC("StreamSwitchNTask")
rtError_t StreamSwitchNTaskInit(TaskInfo *taskInfo, const void *const ptrAddr, const uint32_t ptrSize,
                                const void *const valPtr, const void *const trueStream,
                                const uint32_t eleSize, const rtSwitchDataType_t taskDataType)
{
    StreamSwitchNTaskInfo* streamSwitchNTask = &(taskInfo->u.streamSwitchNTask);
    Stream * const stream = taskInfo->stream;
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_STREAM_SWITCH_N;
    taskInfo->typeName = "STREAM_SWITCH_N";
    streamSwitchNTask->ptr = RtPtrToValue(ptrAddr);
    streamSwitchNTask->trueStreamPtr = RtPtrToValue(trueStream);
    streamSwitchNTask->valuePtr = RtPtrToValue(valPtr);
    streamSwitchNTask->size = ptrSize;
    streamSwitchNTask->elementSize = eleSize;
    streamSwitchNTask->dataType = taskDataType;

    if ((taskInfo->stream->Device_())->GetType_() == Device::STUB_DEVICE) {
        streamSwitchNTask->phyPtr = streamSwitchNTask->ptr;
        streamSwitchNTask->phyValuePtr = streamSwitchNTask->valuePtr;
        streamSwitchNTask->phyTrueStreamPtr = streamSwitchNTask->trueStreamPtr;
        streamSwitchNTask->isTransAddr = false;
        return RT_ERROR_NONE;
    }

    uint64_t pptr = 0UL;
    const int32_t devId = static_cast<int32_t>(stream->Device_()->Id_());
    Driver * const driver = taskInfo->stream->Device_()->Driver_();
    rtError_t error = driver->MemAddressTranslate(devId, streamSwitchNTask->ptr, &pptr);
    ERROR_RETURN_MSG_INNER(error,
                           "Convert memory address from virtual to dma physical failed,retCode=%#x,ptr=%#" PRIx64 ".",
                           error, streamSwitchNTask->ptr);

    uint64_t physicValuePtr = 0UL;
    error = driver->MemAddressTranslate(devId, streamSwitchNTask->valuePtr, &physicValuePtr);
    ERROR_RETURN_MSG_INNER(error, "Convert memory address from virtual to dma physical failed, retCode=%#x,"
                                  " valuePtr=%#" PRIx64 ".", error, streamSwitchNTask->valuePtr);

    uint64_t physicTrueStreamPtr = 0UL;
    error = driver->MemAddressTranslate(devId, streamSwitchNTask->trueStreamPtr,
        &physicTrueStreamPtr);
    ERROR_RETURN_MSG_INNER(error, "Convert memory address from virtual to dma physical failed,"
                                  " retCode=%#x,trueStreamPtr=%#" PRIx64 ".", error,
                                  streamSwitchNTask->trueStreamPtr);
    streamSwitchNTask->phyPtr = pptr;
    streamSwitchNTask->phyValuePtr = physicValuePtr;
    streamSwitchNTask->phyTrueStreamPtr = physicTrueStreamPtr;
    streamSwitchNTask->isTransAddr = true;

    return RT_ERROR_NONE;
}

void ToCommandBodyForStreamSwitchNTask(TaskInfo *taskInfo, rtCommand_t *const command)
{
    StreamSwitchNTaskInfo* streamSwitchNTask = &(taskInfo->u.streamSwitchNTask);
    command->u.streamSwitchNTask.dataType = static_cast<uint8_t>(streamSwitchNTask->dataType);
    command->u.streamSwitchNTask.elementSize = streamSwitchNTask->elementSize;
    command->u.streamSwitchNTask.pptr = streamSwitchNTask->phyPtr;
    command->u.streamSwitchNTask.pTrueStreamIdPtr = streamSwitchNTask->phyTrueStreamPtr;
    command->u.streamSwitchNTask.pValuePtr = streamSwitchNTask->phyValuePtr;
    command->u.streamSwitchNTask.size = streamSwitchNTask->size;
    command->u.streamSwitchNTask.isTransAddr =
        static_cast<uint8_t>(streamSwitchNTask->isTransAddr ? 1U : 0U);
    command->u.streamSwitchNTask.pptrVirAddr = MAX_UINT32_NUM;
    command->u.streamSwitchNTask.pValuePtrVirAddr = MAX_UINT32_NUM;
    command->u.streamSwitchNTask.pTrueVirAddr = MAX_UINT32_NUM;

    const uint64_t pptr = command->u.streamSwitchNTask.pptr;
    const uint32_t ptrSize = command->u.streamSwitchNTask.size;
    const uint64_t physicValuePtr = command->u.streamSwitchNTask.pValuePtr;
    const uint64_t pTrueStreamIdPtr = command->u.streamSwitchNTask.pTrueStreamIdPtr;
    const uint32_t elemSize = command->u.streamSwitchNTask.elementSize;
    const uint32_t tensorDataType = command->u.streamSwitchNTask.dataType;
    const uint16_t streamId = command->streamID;

    RT_LOG(RT_LOG_DEBUG,
        "StreamSwitchNTask::ToCommandBody:pptr=%#" PRIx64 ",size=%u,p_value_ptr=%#" PRIx64
        "p_true_stream_id_ptr=%#" PRIx64 ",element_size=%u,data_type=%u,stream_id=%u.",
        pptr, ptrSize, physicValuePtr, pTrueStreamIdPtr,
        elemSize, tensorDataType, static_cast<uint32_t>(streamId));
}

#endif

#if F_DESC("StreamLabelSwitchByIndexTask")

rtError_t AllocFuncCallMemForStmLblSwiByIdxTask(TaskInfo* taskInfo)
{
    /* if mem alloc fail, the allocated mem will be freed by destructor */
    StmLabelSwitchByIdxTaskInfo *stmLblSwiByIdx = &taskInfo->u.stmLabelSwitchIdxTask;

    stmLblSwiByIdx->funCallMemSize = static_cast<uint32_t>(sizeof(rtStarsLabelSwitchByIndexFc_t));
    void *devMem = nullptr;
    const auto dev = taskInfo->stream->Device_();
    const uint64_t allocSize = stmLblSwiByIdx->funCallMemSize + TS_STARS_COND_DFX_SIZE + FUNC_CALL_INSTR_ALIGN_SIZE;
    const rtError_t ret = dev->Driver_()->DevMemAlloc(&devMem, allocSize, RT_MEMORY_DDR, dev->Id_());
    COND_RETURN_ERROR((ret != RT_ERROR_NONE) || (devMem == nullptr), ret,
                      "Alloc func call svm memory failed,retCode=%#x,size=%" PRIu64 "(bytes),dev_id=%u.",
                      ret, stmLblSwiByIdx->funCallMemSize, dev->Id_());
    stmLblSwiByIdx->baseFuncCallSvmMem = devMem;
    // instr addr should align to 256b
    if ((RtPtrToValue(devMem) & 0xFFULL) != 0ULL) {
        // 2 ^ 8 is 256 align
        const uint64_t devMemAlign = (((RtPtrToValue(devMem)) >> 8U) + 1UL) << 8U;
        devMem = RtValueToPtr<void *>(devMemAlign);
    }
    stmLblSwiByIdx->funcCallSvmMem = devMem;
    stmLblSwiByIdx->dfxPtr = RtValueToPtr<void *>(RtPtrToValue(stmLblSwiByIdx->funcCallSvmMem) +
        stmLblSwiByIdx->funCallMemSize);

    return RT_ERROR_NONE;
}

rtError_t FreeFuncCallMemForStmLblSwiByIdxTask(TaskInfo * const taskInfo)
{
    const auto dev = taskInfo->stream->Device_();
    StmLabelSwitchByIdxTaskInfo *stmLblSwiByIdx = &taskInfo->u.stmLabelSwitchIdxTask;

    if (stmLblSwiByIdx->baseFuncCallSvmMem != nullptr) {
        (void)dev->Driver_()->DevMemFree(stmLblSwiByIdx->baseFuncCallSvmMem, dev->Id_());
        stmLblSwiByIdx->baseFuncCallSvmMem = nullptr;
        stmLblSwiByIdx->funcCallSvmMem = nullptr;
        stmLblSwiByIdx->funCallMemSize = 0U;
        stmLblSwiByIdx->dfxPtr = nullptr;
    }

    return RT_ERROR_NONE;
}

rtError_t InitFuncCallParaForStmLblSwiByIdxTask(TaskInfo* taskInfo, rtStarsLabelSwitchByIndexFcPara_t &fcPara)
{
    StmLabelSwitchByIdxTaskInfo *stmLblSwiByIdx = &taskInfo->u.stmLabelSwitchIdxTask;
    Stream *stm = taskInfo->stream;
    if (stm->Model_() == nullptr) {
        RT_LOG(RT_LOG_ERROR, "model is null");
        return RT_ERROR_MODEL_NULL;
    }

    fcPara.labelCountPtr = stm->Model_()->GetLabelCountdevPtr();
    fcPara.maxVal = stmLblSwiByIdx->max;
    fcPara.indexPtr = RtPtrToValue(stmLblSwiByIdx->indexPtr);
    fcPara.labelInfoPtr = RtPtrToValue(stmLblSwiByIdx->labelInfoPtr);
    fcPara.dfxAddr = RtPtrToValue(stmLblSwiByIdx->dfxPtr);

    fcPara.sqHeadOffset = STARS_SIMPLE_SQ_HEAD_OFFSET;
    fcPara.sqTailOffset = stm->Device_()->GetDevProperties().sqTailOffset;
    fcPara.sqVirtualAddr = RtPtrToValue(stm->Device_()->GetSqVirtualArrBaseAddr_());

    return RT_ERROR_NONE;
}

rtError_t PrepareSqeInfoForStmLblSwiByIdxTask(TaskInfo* taskInfo)
{
    rtStarsLabelSwitchByIndexFc_t fc;
    rtStarsLabelSwitchByIndexFcPara_t fcPara;
    Stream *stm = taskInfo->stream;

    rtError_t ret = AllocFuncCallMemForStmLblSwiByIdxTask(taskInfo);
    ERROR_RETURN(ret, "Alloc func call svm failed,retCode=%#x.", ret);

    ret = InitFuncCallParaForStmLblSwiByIdxTask(taskInfo, fcPara);
    ERROR_RETURN(ret, "Init func call para failed,retCode=%#x.", ret);

    ConstructLabelSwitchByIndexFc(fc, fcPara, static_cast<uint16_t>(stm->GetSqId()));

    const rtMemcpyKind_t kind = (
        taskInfo->stream->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_MEM_COPY_DOT_D2D_ONLY)) ? 
        RT_MEMCPY_DEVICE_TO_DEVICE : RT_MEMCPY_HOST_TO_DEVICE;
    StmLabelSwitchByIdxTaskInfo *stmLblSwiByIdx = &taskInfo->u.stmLabelSwitchIdxTask;
    ret = taskInfo->stream->Device_()->Driver_()->MemCopySync(stmLblSwiByIdx->funcCallSvmMem,
        stmLblSwiByIdx->funCallMemSize, &fc, sizeof(rtStarsLabelSwitchByIndexFc_t), kind);
    ERROR_RETURN(ret, "MemCopySync failed,retCode=%#x.", ret);

    return ret;
}

// convert device address(virtual address) to physic addr
rtError_t MemAddrTransForStreamLabelSwitchByIndexTask(TaskInfo* taskInfo)
{
    uint64_t physicIndexPtr;
    uint64_t physicLabelInfoPtr;
    StmLabelSwitchByIdxTaskInfo *stmLblSwiByIdx = &taskInfo->u.stmLabelSwitchIdxTask;

    const int32_t devId = static_cast<int32_t>(taskInfo->stream->Device_()->Id_());
    rtError_t error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(devId,
        RtPtrToValue(stmLblSwiByIdx->indexPtr), &physicIndexPtr);
    ERROR_RETURN_MSG_INNER(error, "convert memory address from virtual to physic failed!");
    stmLblSwiByIdx->phyIndexPtr = physicIndexPtr;

    error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(devId,
        RtPtrToValue(stmLblSwiByIdx->labelInfoPtr), &physicLabelInfoPtr);
    ERROR_RETURN_MSG_INNER(error, "convert memory address from virtual to physic failed!");
    stmLblSwiByIdx->phyLabelInfoPtr = physicLabelInfoPtr;

    RT_LOG(RT_LOG_DEBUG, "Mem Addr Translate, phyIndexPtr:%#" PRIx64
           ", phyLabelInfoPtr:%#" PRIx64, stmLblSwiByIdx->phyIndexPtr, stmLblSwiByIdx->phyLabelInfoPtr);

    return RT_ERROR_NONE;
}

rtError_t StreamLabelSwitchByIndexTaskInit(TaskInfo* taskInfo, void * const idPtr, const uint32_t maxIndex,
                                           void * const labelPtr)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "STREAM_LABEL_SWITCH_BY_INDEX";
    taskInfo->type = TS_TASK_TYPE_STREAM_LABEL_SWITCH_BY_INDEX;
    taskInfo->u.stmLabelSwitchIdxTask.indexPtr = idPtr;
    taskInfo->u.stmLabelSwitchIdxTask.labelInfoPtr = labelPtr;
    taskInfo->u.stmLabelSwitchIdxTask.phyIndexPtr = 0ULL;
    taskInfo->u.stmLabelSwitchIdxTask.phyLabelInfoPtr = 0ULL;
    taskInfo->u.stmLabelSwitchIdxTask.max = maxIndex;
    taskInfo->u.stmLabelSwitchIdxTask.funCallMemSize = 0UL;
    taskInfo->u.stmLabelSwitchIdxTask.funcCallSvmMem = nullptr;
    taskInfo->u.stmLabelSwitchIdxTask.dfxPtr = nullptr;
    taskInfo->u.stmLabelSwitchIdxTask.baseFuncCallSvmMem = nullptr;

    RT_LOG(RT_LOG_DEBUG, "Stream label switch task, max=%u.", taskInfo->u.stmLabelSwitchIdxTask.max);
    if (taskInfo->stream->Device_()->IsStarsPlatform()) {
        return PrepareSqeInfoForStmLblSwiByIdxTask(taskInfo);
    }
    return RT_ERROR_NONE;
}

void ToCmdBodyForStreamLabelSwitchByIndexTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    (void)MemAddrTransForStreamLabelSwitchByIndexTask(taskInfo);
    StmLabelSwitchByIdxTaskInfo *stmLblSwiByIdx = &taskInfo->u.stmLabelSwitchIdxTask;

    command->u.streamLabelSwitchIndexTask.indexPtr = stmLblSwiByIdx->phyIndexPtr;
    command->u.streamLabelSwitchIndexTask.labelInfoPtr = stmLblSwiByIdx->phyLabelInfoPtr;
    command->u.streamLabelSwitchIndexTask.max = stmLblSwiByIdx->max;
    command->u.streamLabelSwitchIndexTask.indexPtrVirAddr = MAX_UINT32_NUM;
    command->u.streamLabelSwitchIndexTask.labelInfoPtrVirAddr = MAX_UINT32_NUM;
}

void ConstructSqeForStreamLabelSwitchByIndexTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    RtStarsFunctionCallSqe &sqe = command->fuctionCallSqe;
    StmLabelSwitchByIdxTaskInfo *stmLblSwiByIdx = &taskInfo->u.stmLabelSwitchIdxTask;

    sqe.kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe.csc = 1U;
    sqe.sqeHeader.l1_lock = 0U;
    sqe.sqeHeader.l1_unlock = 0U;
    sqe.sqeHeader.type = RT_STARS_SQE_TYPE_COND;
    sqe.sqeHeader.wr_cqe = taskInfo->stream->GetStarsWrCqeFlag();
    sqe.sqeHeader.block_dim = 0U;
    sqe.sqeHeader.rt_stream_id = static_cast<uint16_t>(taskInfo->stream->Id_());
    sqe.sqeHeader.task_id = taskInfo->id;
    sqe.sqeHeader.pre_p = 1U;
    sqe.conds_sub_type = CONDS_SUB_TYPE_LABEL_SWITCH_BY_INDEX;

    const uint64_t funcAddr = RtPtrToValue(stmLblSwiByIdx->funcCallSvmMem);
    constexpr uint64_t funcCallSize = static_cast<uint64_t>(sizeof(rtStarsLabelSwitchByIndexFc_t));

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintSqe(command, "StreamLabelSwitchByIndexTask");
}

void PrintErrorInfoForStreamLabelSwitchByIndexTask(TaskInfo* taskInfo, const uint32_t devId)
{
    const uint32_t taskId = taskInfo->id;
    const int32_t streamId = taskInfo->stream->Id_();
    StmLabelSwitchByIdxTaskInfo *stmLblSwiByIdx = &taskInfo->u.stmLabelSwitchIdxTask;

    Stream *const reportStream = GetReportStream(taskInfo->stream);
    if (taskInfo->stream->Device_()->IsStarsPlatform()) {
        uint64_t dfx[8U];
        (void)taskInfo->stream->Device_()->Driver_()->MemCopySync(dfx, sizeof(dfx), stmLblSwiByIdx->dfxPtr,
                                            sizeof(dfx), RT_MEMCPY_DEVICE_TO_HOST);
        RT_LOG(RT_LOG_ERROR, "stream_id=%u,task_id=%u,sq_id=%" PRIu64 ",enable=%" PRIu64 ",tail=%" PRIu64
            ",head=%" PRIu64 "", streamId, taskId, dfx[0U], dfx[1U], dfx[2U] >> 48U, dfx[3U] >> 48U);
    }

    STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_GE,
        "LabelSwitchByIndex execute failed,device_id=%u, stream_id=%d, %s=%u",
        devId, streamId, TaskIdDesc(), taskId);
}

void StreamLabelSwitchByIndexTaskUnInit(TaskInfo * const taskInfo)
{
    (void)FreeFuncCallMemForStmLblSwiByIdxTask(taskInfo);
}

#endif

#if F_DESC("StreamLabelGotoTask")

rtError_t StreamLabelGotoTaskInit(TaskInfo* taskInfo, const uint16_t lblId)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "STREAM_LABEL_GOTO";
    taskInfo->type = TS_TASK_TYPE_STREAM_LABEL_GOTO;
    taskInfo->u.streamLabelGotoTask.labelId = lblId;
    RT_LOG(RT_LOG_DEBUG, "stream label goto task, labelId=%u.",
        static_cast<uint32_t>(taskInfo->u.streamLabelGotoTask.labelId));
    return RT_ERROR_NONE;
}

void ToCmdBodyForStreamLabelGotoTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    const Model *const modelPtr = taskInfo->stream->Model_();
    if (modelPtr == nullptr) {
        RT_LOG(RT_LOG_ERROR, "model is null");
        return;
    }
    const uint32_t modelId = modelPtr->Id_();

    command->u.streamLabelGotoTask.labelId = taskInfo->u.streamLabelGotoTask.labelId;
    command->u.streamLabelGotoTask.modelId = static_cast<uint16_t>(modelId);
}

#endif

}  // namespace runtime
}  // namespace cce