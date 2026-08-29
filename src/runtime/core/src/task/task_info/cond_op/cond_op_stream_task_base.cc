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
#include "stars_cond_isa_helper.hpp"
#include "cond_op_stream_task.h"
#include "stub_task.hpp"

namespace cce {
namespace runtime {

#if F_DESC("StreamSwitchNTask")
rtError_t StreamSwitchNTaskInit(
    TaskInfo* taskInfo, const void* const ptrAddr, const uint32_t ptrSize, const void* const valPtr,
    const void* const trueStream, const uint32_t eleSize, const rtSwitchDataType_t taskDataType)
{
    StreamSwitchNTaskInfo* streamSwitchNTask = &(taskInfo->u.streamSwitchNTask);
    Stream* const stream = taskInfo->stream;
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_STREAM_SWITCH_N;
    taskInfo->typeName = "STREAM_SWITCH_N";
    streamSwitchNTask->ptr = RtPtrToValue(ptrAddr);
    streamSwitchNTask->trueStreamPtr = RtPtrToValue(trueStream);
    streamSwitchNTask->valuePtr = RtPtrToValue(valPtr);
    streamSwitchNTask->size = ptrSize;
    streamSwitchNTask->elementSize = eleSize;
    streamSwitchNTask->dataType = taskDataType;

    uint64_t pptr = 0UL;
    const int32_t devId = static_cast<int32_t>(stream->Device_()->Id_());
    Driver* const driver = taskInfo->stream->Device_()->Driver_();
    rtError_t error = driver->MemAddressTranslate(devId, streamSwitchNTask->ptr, &pptr);
    COND_RETURN_ERROR(
        (error != RT_ERROR_NONE), error,
        "Convert memory address from virtual to dma physical failed, retCode=%#x, ptr=%#" PRIx64 ".", error,
        streamSwitchNTask->ptr);

    uint64_t physicValuePtr = 0UL;
    error = driver->MemAddressTranslate(devId, streamSwitchNTask->valuePtr, &physicValuePtr);
    COND_RETURN_ERROR(
        (error != RT_ERROR_NONE), error,
        "Convert memory address from virtual to dma physical failed, retCode=%#x,"
        " valuePtr=%#" PRIx64 ".",
        error, streamSwitchNTask->valuePtr);

    uint64_t physicTrueStreamPtr = 0UL;
    error = driver->MemAddressTranslate(devId, streamSwitchNTask->trueStreamPtr, &physicTrueStreamPtr);
    COND_RETURN_ERROR(
        (error != RT_ERROR_NONE), error,
        "Convert memory address from virtual to dma physical failed,"
        " retCode=%#x, trueStreamPtr=%#" PRIx64 ".",
        error, streamSwitchNTask->trueStreamPtr);
    streamSwitchNTask->phyPtr = pptr;
    streamSwitchNTask->phyValuePtr = physicValuePtr;
    streamSwitchNTask->phyTrueStreamPtr = physicTrueStreamPtr;
    streamSwitchNTask->isTransAddr = true;

    return RT_ERROR_NONE;
}

void ToCommandBodyForStreamSwitchNTask(TaskInfo* taskInfo, rtCommand_t* const command)
{
    StreamSwitchNTaskInfo* streamSwitchNTask = &(taskInfo->u.streamSwitchNTask);
    command->u.streamSwitchNTask.dataType = static_cast<uint8_t>(streamSwitchNTask->dataType);
    command->u.streamSwitchNTask.elementSize = streamSwitchNTask->elementSize;
    command->u.streamSwitchNTask.pptr = streamSwitchNTask->phyPtr;
    command->u.streamSwitchNTask.pTrueStreamIdPtr = streamSwitchNTask->phyTrueStreamPtr;
    command->u.streamSwitchNTask.pValuePtr = streamSwitchNTask->phyValuePtr;
    command->u.streamSwitchNTask.size = streamSwitchNTask->size;
    command->u.streamSwitchNTask.isTransAddr = static_cast<uint8_t>(streamSwitchNTask->isTransAddr ? 1U : 0U);
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

    RT_LOG(
        RT_LOG_DEBUG,
        "StreamSwitchNTask::ToCommandBody:pptr=%#" PRIx64 ",size=%u,p_value_ptr=%#" PRIx64
        ",p_true_stream_id_ptr=%#" PRIx64 ",element_size=%u,data_type=%u,stream_id=%u.",
        pptr, ptrSize, physicValuePtr, pTrueStreamIdPtr, elemSize, tensorDataType, static_cast<uint32_t>(streamId));
}

#endif

#if F_DESC("StreamLabelGotoTask")

rtError_t StreamLabelGotoTaskInit(TaskInfo* taskInfo, const uint16_t lblId)
{
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "STREAM_LABEL_GOTO";
    taskInfo->type = TS_TASK_TYPE_STREAM_LABEL_GOTO;
    taskInfo->u.streamLabelGotoTask.labelId = lblId;
    RT_LOG(
        RT_LOG_DEBUG, "stream label goto task, labelId=%u.",
        static_cast<uint32_t>(taskInfo->u.streamLabelGotoTask.labelId));
    return RT_ERROR_NONE;
}

void ToCmdBodyForStreamLabelGotoTask(TaskInfo* taskInfo, rtCommand_t* const command)
{
    const Model* const modelPtr = taskInfo->stream->Model_();
    if (modelPtr == nullptr) {
        RT_LOG(RT_LOG_ERROR, "model is null");
        return;
    }
    const uint32_t modelId = modelPtr->Id_();

    command->u.streamLabelGotoTask.labelId = taskInfo->u.streamLabelGotoTask.labelId;
    command->u.streamLabelGotoTask.modelId = static_cast<uint16_t>(modelId);
}

#endif

} // namespace runtime
} // namespace cce