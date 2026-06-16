/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "stream_jetty_handler.h"
#include "stream.hpp"
#include "driver.hpp"
#include "npu_driver.hpp"
#include "task_info.hpp"
#include "task_base.hpp"
#include "error_code.h"
#include "securec.h"
#include "runtime.hpp"
#include "error_message_manage.hpp"
#include "stars_david.hpp"
#include "task.hpp"

namespace cce {
namespace runtime {
bool StreamJettyHandler::IsUbDmaCopyType(uint32_t copyType)
{
    if ((Runtime::Instance()->GetConnectUbFlag()) &&
        ((copyType == RT_MEMCPY_DIR_H2D) || (copyType == RT_MEMCPY_DIR_D2H) || (copyType == RT_MEMCPY_DIR_D2D_UB))) {
        return true;
    }
    return false;
}

bool StreamJettyHandler::IsUbDmaTaskType(tsTaskType_t taskType)
{
    if (!Runtime::Instance()->GetConnectUbFlag()) {
        return false;
    }
    return (taskType == TS_TASK_TYPE_MEMCPY);
}

JettyType StreamJettyHandler::GetJettyTypeFromTask(const TaskInfo* task)
{
    if (task == nullptr) {
        return JettyType::JETTY_TYPE_MAX;
    }

    return ConvertCopyTypeToJettyType(task->u.memcpyAsyncTaskInfo.copyType);
}

JettyType StreamJettyHandler::ConvertCopyTypeToJettyType(uint32_t copyType)
{
    if (copyType == RT_MEMCPY_DIR_H2D || copyType == RT_MEMCPY_DIR_D2H) {
        return JettyType::JETTY_TYPE_H2D;
    }
    return JettyType::JETTY_TYPE_D2D;
}

rtError_t StreamJettyHandler::GetDriverAndDeviceId(const Stream* stream, Driver*& driver, uint32_t& deviceId)
{
    if (stream == nullptr || stream->Device_() == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Stream or device is null.");
        return RT_ERROR_INVALID_VALUE;
    }

    driver = stream->Device_()->Driver_();
    deviceId = stream->Device_()->Id_();

    if (driver == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Driver is null, device_id=%u.", deviceId);
        return RT_ERROR_INVALID_VALUE;
    }

    return RT_ERROR_NONE;
}

rtError_t StreamJettyHandler::GetOrCreateStreamJettyContext(
    const Stream* stream, JettyType jettyType, StreamJettyContext*& context)
{
    if (stream == nullptr || stream->Device_() == nullptr || stream->Device_()->GetJettyManager() == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }

    context = stream->Device_()->GetJettyManager()->GetOrCreateStreamJettyContext(stream, jettyType);
    if (context == nullptr) {
        RT_LOG(RT_LOG_ERROR, "GetOrCreateStreamJettyContext failed, stream_id=%d.", stream->Id_());
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    return RT_ERROR_NONE;
}

// for normal/2d/batch copy
rtError_t StreamJettyHandler::CreateAndAppendWqe(
    const Stream* stream, const TaskInfo* task, StreamJettyContext* context, AsyncWqeInputPara* input, AsyncWqeOutputPara *output)
{
    if (stream == nullptr || task == nullptr || context == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }
    Driver* driver = nullptr;
    uint32_t deviceId = 0;
    rtError_t error = GetDriverAndDeviceId(stream, driver, deviceId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    if (context->filledWqeCount >= context->capacity) {
        error = context->GrowBuffer(driver);
        ERROR_RETURN_MSG_INNER(error, "GrowBuffer failed, stream_id=%d, ret=%d.", stream->Id_(), error);
        context->isLargeDepth = (context->capacity > JETTY_DEPTH_STANDARD);
        RT_LOG(RT_LOG_DEBUG, "GrowBuffer success, capacity=%u, wqe count=%u.", context->capacity, context->filledWqeCount);
    }

    const MemcpyAsyncTaskInfo* memcpyInfo = &(task->u.memcpyAsyncTaskInfo);
    // wqe buffer addr
    input->wqeBuffer = context->GetNextWqeBuffer();
    // wqe buffer 可用大小
    input->size = (StreamJettyContext::WQE_BUFFER_DEPTH - (context->filledWqeCount % StreamJettyContext::WQE_BUFFER_DEPTH)) * StreamJettyContext::WQE_SIZE;
    error = driver->AsyncDmaWqeConvert(deviceId, input, output);
    ERROR_RETURN_MSG_INNER(
        error, "AsyncDmaWqeConvert failed, device_id=%u, size=%lu, ret=%d.", deviceId, memcpyInfo->size, error);
    context->filledWqeCount += output->wqeCnt;
    // 记录 taskId 和 totalWqeCount，用于后续刷新 dieId/funcId/jettyId/pi
    context->taskWqeCounts.push_back(std::pair<uint32_t, uint32_t>(task->id, output->wqeCnt));
    RT_LOG(RT_LOG_DEBUG, "CreateAndAppendWqe success, stream_id=%d, task_id=%u, size=%lu, wqeCount=%u.", stream->Id_(),
        task->id, memcpyInfo->size, output->wqeCnt);
    return RT_ERROR_NONE;
}

rtError_t StreamJettyHandler::HandleUbDmaTask(
    const Stream* stream, const TaskInfo* task, JettyType jettyType, AsyncWqeInputPara* input, AsyncWqeOutputPara *output)
{
    if (stream == nullptr || task == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }

    if (!IsUbDmaCopyType(task->u.memcpyAsyncTaskInfo.copyType)) {
        return RT_ERROR_NONE;
    }

    StreamJettyContext* context = nullptr;
    // when jettyContext create, reserve jetty
    rtError_t error = GetOrCreateStreamJettyContext(stream, jettyType, context);
    ERROR_RETURN_MSG_INNER(error, "GetOrCreateStreamJettyContext failed, stream_id=%d, ret=%d.", stream->Id_(), error);
    error = CreateAndAppendWqe(stream, task, context, input, output);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "CreateAndAppendWqe failed, stream_id=%d, ret=%d.", stream->Id_(), error);
        return error;
    }
    RT_LOG(RT_LOG_DEBUG, "HandleUbDmaTask success, stream_id=%d, jettyType=%d, filledWqeCount=%u, capacity=%u.",
        stream->Id_(), static_cast<int32_t>(jettyType), context->filledWqeCount, context->capacity);
    return RT_ERROR_NONE;
}

// NOP WQE创建接口, 批量添加NOP
rtError_t StreamJettyHandler::FillNopWqeForPartialBuffer(const Stream* stream, const StreamJettyContext* context)
{
    if (stream == nullptr || context == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }

    if (context->filledWqeCount == 0) {
        return RT_ERROR_NONE;
    }

    Driver* driver = nullptr;
    uint32_t deviceId = 0;
    rtError_t error = GetDriverAndDeviceId(stream, driver, deviceId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    if (context->wqeBuffers.empty()) {
        RT_LOG(RT_LOG_INFO, "No wqeBuffers to fill NOP, stream_id=%d.", stream->Id_());
        return RT_ERROR_NONE;
    }

    if (context->filledWqeCount >= context->capacity) {
        return RT_ERROR_NONE;
    }
    uint32_t fillCount = context->capacity - context->filledWqeCount;
    uint32_t bufferSize = fillCount * StreamJettyContext::WQE_SIZE;

    AsyncWqeInputPara input = {};
    input.wqeBuffer = context->GetNextWqeBuffer();
    input.wqeType = static_cast<uint32_t>(DRV_ASYNC_DMA_TYPE_NOP);
    input.size = bufferSize;
    input.nop.nopCnt = fillCount;

    AsyncWqeOutputPara output = {};
    error = driver->AsyncDmaWqeConvert(deviceId, &input, &output);
    ERROR_RETURN_MSG_INNER(
        error, "AsyncDmaWqeConvert failed, device_id=%u, bufferSize=%u, ret=%d.", deviceId, bufferSize, error);
    // 这里不可能触发wqe buffer扩容 不需要判断
    RT_LOG(RT_LOG_INFO, "FillNopWqeForPartialBuffer success, stream_id=%d, fillCount=%u, finalValidWqeCount=%u.",
        stream->Id_(), fillCount, context->filledWqeCount);

    return RT_ERROR_NONE;
}

rtError_t StreamJettyHandler::FillNopWqeOnCaptureEnd(const Stream* stream, JettyType jettyType)
{
    if (stream == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }

    if (stream->Device_() == nullptr || stream->Device_()->GetJettyManager() == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }

    int32_t streamId = static_cast<int32_t>(stream->Id_());
    StreamJettyContext* context =
        stream->Device_()->GetJettyManager()->GetStreamJettyContext(streamId, jettyType);
    if (context == nullptr) {
        return RT_ERROR_NONE;
    }

    if (context->filledWqeCount == 0) {
        RT_LOG(RT_LOG_INFO, "No WQE to fill NOP, stream_id=%d.", streamId);
        return RT_ERROR_NONE;
    }

    Driver* driver = nullptr;
    uint32_t deviceId = 0;
    rtError_t error = GetDriverAndDeviceId(stream, driver, deviceId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    error = FillNopWqeForPartialBuffer(stream, context);
    ERROR_RETURN_MSG_INNER(error, "FillNopWqeForPartialBuffer failed, stream_id=%d, ret=%d.", stream->Id_(), error);

    error = context->RoundUpCapacity(driver, deviceId);
    ERROR_RETURN_MSG_INNER(error, "RoundUpCapacity failed, stream_id=%d, ret=%d.", stream->Id_(), error);

    RT_LOG(RT_LOG_INFO, "FillNopWqeOnCaptureEnd success, stream_id=%d, totalValidWqeCount=%u.", streamId,
        context->filledWqeCount);

    return RT_ERROR_NONE;
}

rtError_t StreamJettyHandler::SyncWqeBufferToDevice(
    const Stream* stream, const StreamJettyContext* context, const JettyInfo& jettyInfo)
{
    if (stream == nullptr || context == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }
    if (context->wqeBuffers.empty() || context->filledWqeCount == 0) {
        RT_LOG(RT_LOG_INFO, "No WQE buffer to sync, stream_id=%d.", stream->Id_());
        return RT_ERROR_NONE;
    }

    Driver* driver = nullptr;
    uint32_t deviceId = 0;
    rtError_t error = GetDriverAndDeviceId(stream, driver, deviceId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    AsyncWqeFillInfo fillInfo = {};
    fillInfo.jettyHandle.handle = jettyInfo.handle;
    uint64_t offset = 0U;
    for (size_t i = 0; i < context->wqeBuffers.size(); ++i) {
        if (context->wqeBuffers[i] == nullptr) {
            continue;
        }
        uint64_t size = StreamJettyContext::WQE_BUFFER_DEPTH * StreamJettyContext::WQE_SIZE;
        fillInfo.offset = offset;
        fillInfo.srcWqe = context->wqeBuffers[i].get();
        fillInfo.size = size;

        error = driver->AsyncDmaWqeFill(deviceId, &fillInfo);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "AsyncDmaWqeFill failed, stream_id=%d, buf_idx=%zu, ret=%d.", stream->Id_(), i, error);
            return error;
        }
        offset += size;
    }

    RT_LOG(RT_LOG_DEBUG, "SyncWqeBufferToDevice success, stream_id=%d.", stream->Id_());
    return RT_ERROR_NONE;
}

rtError_t StreamJettyHandler::UpdateUbdmaSqeWithJettyInfo(
    const Stream* stream, const StreamJettyContext* context, const JettyInfo& jettyInfo)
{
    if (stream == nullptr || context == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }

    if (context->taskWqeCounts.empty()) {
        RT_LOG(RT_LOG_INFO, "No SQE positions to update, stream_id=%d.", stream->Id_());
        return RT_ERROR_NONE;
    }

    Driver* driver = nullptr;
    uint32_t deviceId = 0;
    rtError_t error = GetDriverAndDeviceId(stream, driver, deviceId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    if (stream->Device_()->GetTaskFactory() == nullptr) {
        RT_LOG(RT_LOG_ERROR, "GetTaskFactory returned null, stream_id=%d.", stream->Id_());
        return RT_ERROR_INVALID_VALUE;
    }
    for (const auto& pos : context->taskWqeCounts) {
        uint32_t taskId = pos.first;
        uint32_t wqeCount = pos.second;
        TaskInfo* taskInfo = stream->Device_()->GetTaskFactory()->GetTask(stream->Id_(), taskId);
        if (taskInfo == nullptr) {
            continue;
        }
        MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
        memcpyAsyncTaskInfo->ubDma.jettyId = jettyInfo.jettyId;
        memcpyAsyncTaskInfo->ubDma.dieId = jettyInfo.dieId;
        memcpyAsyncTaskInfo->ubDma.functionId = jettyInfo.functionId;
        memcpyAsyncTaskInfo->ubDma.pi = wqeCount;
        rtDavidSqe_t davidSqe[SQE_NUM_PER_DAVID_TASK_MAX] = {};
        rtDavidSqe_t *sqe = davidSqe;
        ToConstructDavidSqe(taskInfo, sqe, stream->GetSqBaseAddr());
        errno_t rc = memcpy_s(RtPtrToPtr<void *>(RtPtrToValue(stream->GetSqeBuffer()) + sizeof(rtStarsSqe_t) * taskInfo->pos),
            sizeof(rtStarsSqe_t), sqe, sizeof(rtStarsSqe_t));
        if (rc != EOK) {
            RT_LOG(RT_LOG_ERROR, "memcpy_s failed for SQE update, stream_id=%d, task_id=%u, rc=%d.",
                stream->Id_(), taskId, static_cast<int32_t>(rc));
            return RT_ERROR_SEC_HANDLE;
        }
        RT_LOG(RT_LOG_DEBUG,
            "UpdateUbdmaSqeWithJettyInfo, stream_id=%d, task_id=%u, wqeCount=%u, "
            "jetty_id=%u, die_id=%u, func_id=%u.",
            stream->Id_(), taskId, wqeCount, jettyInfo.jettyId, jettyInfo.dieId, jettyInfo.functionId);
    }

    RT_LOG(RT_LOG_DEBUG, "UpdateUbdmaSqeWithJettyInfo success, stream_id=%d, posCount=%zu.", stream->Id_(),
        context->taskWqeCounts.size());

    return RT_ERROR_NONE;
}
} // namespace runtime
} // namespace cce