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
#include "stream_c.hpp"
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
#include "model.hpp"
#include "context.hpp"

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
    const Stream* stream, JettyType jettyType, StreamJettyContext*& jettyCtx)
{
    if (stream == nullptr || stream->Device_() == nullptr || stream->Device_()->GetJettyManager() == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }

    jettyCtx = stream->Device_()->GetJettyManager()->GetOrCreateStreamJettyContext(stream, jettyType);
    if (jettyCtx == nullptr) {
        RT_LOG(RT_LOG_ERROR, "GetOrCreateStreamJettyContext failed, stream_id=%d.", stream->Id_());
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    return RT_ERROR_NONE;
}

// for normal/2d/batch copy
rtError_t StreamJettyHandler::CreateAndAppendWqe(
    const TaskInfo* task, StreamJettyContext* jettyCtx, AsyncWqeInputPara* input, AsyncWqeOutputPara *output)
{
    if (task == nullptr || task->stream == nullptr || jettyCtx == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }
    const Stream* stream = task->stream;
    Driver* driver = nullptr;
    uint32_t deviceId = 0;
    rtError_t error = GetDriverAndDeviceId(stream, driver, deviceId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    if (jettyCtx->filledWqeCount >= jettyCtx->capacity) {
        error = jettyCtx->ExpandCapacity(driver);
        COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "ExpandCapacity failed, capacity=%u, max_depth=%u, stream_id=%d, device_id=%u, retCode=%#x.",
            jettyCtx->capacity, StreamJettyContext::JETTY_DEPTH_MAX, stream->Id_(), stream->Device_()->Id_(), error);
        jettyCtx->isLargeDepth = (jettyCtx->capacity > JETTY_DEPTH_STANDARD);
        RT_LOG(RT_LOG_DEBUG, "ExpandCapacity success, capacity=%u, wqe count=%u.", jettyCtx->capacity, jettyCtx->filledWqeCount);
    }

    const MemcpyAsyncTaskInfo* memcpyInfo = &(task->u.memcpyAsyncTaskInfo);
    // wqe buffer addr
    input->wqeBuffer = jettyCtx->GetNextWqeBuffer();
    // wqe buffer 可用大小
    input->size = (StreamJettyContext::WQE_BUFFER_DEPTH - (jettyCtx->filledWqeCount % StreamJettyContext::WQE_BUFFER_DEPTH)) * StreamJettyContext::WQE_SIZE;
    error = driver->AsyncDmaWqeConvert(deviceId, input, output);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error,
        "AsyncDmaWqeConvert failed, device_id=%u, size=%lu, retCode=%#x.", deviceId, memcpyInfo->size, error);
    jettyCtx->filledWqeCount += output->wqeCnt;
    // 记录 task 和 totalWqeCount 用于后续刷新 dieId/funcId/jettyId/pi
 	jettyCtx->taskWqeCounts.push_back(std::pair<TaskInfo*, uint32_t>(const_cast<TaskInfo*>(task), output->wqeCnt));
    RT_LOG(RT_LOG_DEBUG, "Create and append wqe success, stream_id=%d, task_id=%u, size=%lu, wqeCount=%u.", stream->Id_(),
        task->id, memcpyInfo->size, output->wqeCnt);
    return RT_ERROR_NONE;
}

rtError_t StreamJettyHandler::HandleUbDmaTask(
    const TaskInfo* task, JettyType jettyType, AsyncWqeInputPara* input, AsyncWqeOutputPara *output)
{
    if (task == nullptr || task->stream == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }
    const Stream* stream = task->stream;

    if (!IsUbDmaCopyType(task->u.memcpyAsyncTaskInfo.copyType)) {
        return RT_ERROR_INVALID_VALUE;
    }
    RT_LOG(RT_LOG_DEBUG, "Handle UbDma task start, stream_id=%d, jettyType=%d.", stream->Id_(), static_cast<int32_t>(jettyType));

    StreamJettyContext* jettyCtx = nullptr;
    // when jettyContext create, reserve jetty
    rtError_t error = GetOrCreateStreamJettyContext(stream, jettyType, jettyCtx);
    ERROR_RETURN_MSG_INNER(error, "Create jetty context failed, stream_id=%d, retCode=%#x.", stream->Id_(), error);
    error = CreateAndAppendWqe(task, jettyCtx, input, output);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "Append wqe failed, stream_id=%d, retCode=%#x.", stream->Id_(), error);
    RT_LOG(RT_LOG_DEBUG, "Handle UbDma task success, stream_id=%d, jettyType=%d, filledWqeCount=%u, capacity=%u.",
        stream->Id_(), static_cast<int32_t>(jettyType), jettyCtx->filledWqeCount, jettyCtx->capacity);
    return RT_ERROR_NONE;
}

// NOP WQE创建接口, 批量添加NOP
rtError_t StreamJettyHandler::FillNopWqeForPartialBuffer(const Stream* stream, const StreamJettyContext* jettyCtx)
{
    if (stream == nullptr || jettyCtx == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }

    if (jettyCtx->filledWqeCount == 0) {
        return RT_ERROR_NONE;
    }

    Driver* driver = nullptr;
    uint32_t deviceId = 0;
    rtError_t error = GetDriverAndDeviceId(stream, driver, deviceId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    if (jettyCtx->wqeBuffers.empty()) {
        RT_LOG(RT_LOG_INFO, "No wqeBuffers to fill NOP, stream_id=%d.", stream->Id_());
        return RT_ERROR_NONE;
    }

    if (jettyCtx->filledWqeCount >= jettyCtx->capacity) {
        return RT_ERROR_NONE;
    }
    const uint32_t fillCount = jettyCtx->capacity - jettyCtx->filledWqeCount;
    const uint32_t bufferSize = fillCount * StreamJettyContext::WQE_SIZE;

    AsyncWqeInputPara input = {};
    input.wqeBuffer = jettyCtx->GetNextWqeBuffer();
    input.wqeType = static_cast<uint32_t>(DRV_ASYNC_DMA_TYPE_NOP);
    input.size = bufferSize;
    input.nop.nopCnt = fillCount;

    AsyncWqeOutputPara output = {};
    error = driver->AsyncDmaWqeConvert(deviceId, &input, &output);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error,
        "AsyncDmaWqeConvert failed, device_id=%u, bufferSize=%u, retCode=%#x.", deviceId, bufferSize, error);
    // 这里不可能触发wqe buffer扩容 不需要判断
    RT_LOG(RT_LOG_INFO, "Fill nop wqe success, stream_id=%d, count=%u, wqe_count=%u.",
        stream->Id_(), fillCount, jettyCtx->filledWqeCount);

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

    const int32_t streamId = static_cast<int32_t>(stream->Id_());
    StreamJettyContext* jettyCtx =
        stream->Device_()->GetJettyManager()->GetStreamJettyContext(streamId, jettyType);
    if (jettyCtx == nullptr) {
        return RT_ERROR_NONE;
    }

    if (jettyCtx->filledWqeCount == 0) {
        RT_LOG(RT_LOG_INFO, "No WQE to fill NOP, stream_id=%d.", streamId);
        return RT_ERROR_NONE;
    }

    Driver* driver = nullptr;
    uint32_t deviceId = 0;
    rtError_t error = GetDriverAndDeviceId(stream, driver, deviceId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    error = FillNopWqeForPartialBuffer(stream, jettyCtx);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "FillNopWqeForPartialBuffer failed, stream_id=%d, retCode=%#x.", stream->Id_(), error);

    error = jettyCtx->RoundUpCapacity(driver, deviceId);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "RoundUpCapacity failed, capacity=%u, max_depth=%u, stream_id=%d, device_id=%u, retCode=%#x.",
        jettyCtx->capacity, StreamJettyContext::JETTY_DEPTH_MAX, stream->Id_(), stream->Device_()->Id_(), error);

    RT_LOG(RT_LOG_INFO, "FillNopWqeOnCaptureEnd success, stream_id=%d, totalValidWqeCount=%u.", streamId, jettyCtx->filledWqeCount);
    return RT_ERROR_NONE;
}

rtError_t StreamJettyHandler::FillWqeToDevice(
    const Stream* stream, const StreamJettyContext* jettyCtx, const JettyInfo& jettyInfo)
{
    if (stream == nullptr || jettyCtx == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }
    if (jettyCtx->wqeBuffers.empty() || jettyCtx->filledWqeCount == 0) {
        RT_LOG(RT_LOG_INFO, "No WQE buffer to sync, stream_id=%d.", stream->Id_());
        return RT_ERROR_NONE;
    }

    Driver* driver = nullptr;
    uint32_t deviceId = 0;
    rtError_t error = GetDriverAndDeviceId(stream, driver, deviceId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    AsyncWqeFillInfo fillInfo = {};
    fillInfo.jettyHandle.handle = jettyInfo.handle;
    uint32_t offset = 0U;
    for (size_t i = 0; i < jettyCtx->wqeBuffers.size(); ++i) {
        if (jettyCtx->wqeBuffers[i] == nullptr) {
            continue;
        }
        const uint64_t size = StreamJettyContext::WQE_BUFFER_DEPTH * StreamJettyContext::WQE_SIZE;
        fillInfo.offset = offset;
        fillInfo.srcWqe = jettyCtx->wqeBuffers[i].get();
        fillInfo.size = size;

        error = driver->AsyncDmaWqeFill(deviceId, &fillInfo);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "AsyncDmaWqeFill failed, stream_id=%d, buf_idx=%zu, retCode=%#x.", stream->Id_(), i, error);
            return error;
        }
        offset += size;
    }

    RT_LOG(RT_LOG_DEBUG, "Sync wqe buffer to device success, stream_id=%d.", stream->Id_());
    return RT_ERROR_NONE;
}

rtError_t StreamJettyHandler::UpdateUbdmaSqeWithJettyInfo(
    const Stream* stream, const StreamJettyContext* jettyCtx, const JettyInfo& jettyInfo)
{
    if (stream == nullptr || jettyCtx == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }

    if (jettyCtx->taskWqeCounts.empty()) {
        RT_LOG(RT_LOG_INFO, "No SQE positions to update, stream_id=%d.", stream->Id_());
        return RT_ERROR_NONE;
    }

    Driver* driver = nullptr;
    uint32_t deviceId = 0;
    rtError_t error = GetDriverAndDeviceId(stream, driver, deviceId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    NULL_PTR_RETURN(stream->Device_()->GetTaskFactory(), RT_ERROR_INVALID_VALUE);
    for (const auto& pos : jettyCtx->taskWqeCounts) {
        uint32_t wqeCount = pos.second;
        TaskInfo* taskInfo = pos.first;
        if (taskInfo == nullptr) {
            continue;
        }
        uint32_t taskId = taskInfo->id;
        MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
        memcpyAsyncTaskInfo->ubDma.jettyId = jettyInfo.jettyId;
        memcpyAsyncTaskInfo->ubDma.dieId = jettyInfo.dieId;
        memcpyAsyncTaskInfo->ubDma.functionId = jettyInfo.functionId;
        memcpyAsyncTaskInfo->ubDma.pi = wqeCount;
        uint8_t sqeBuffer[SQE_SIZE_MAX] = {};
        rtDavidSqe_t *davidSqe = RtPtrToPtr<rtDavidSqe_t *>(sqeBuffer);
        taskInfo->bindFlag = taskInfo->stream->GetBindFlag();
 	    taskInfo->isNoRingbuffer = 1U;
        ConstructDavidAsyncUbDbSqe(taskInfo, davidSqe);
        davidSqe->phSqe.header.headUpdate = GetHeadUpdateFlag(taskId);
        const errno_t rc = memcpy_s(RtPtrToPtr<void *>(RtPtrToValue(stream->GetSqeBuffer()) + SQE_SIZE_UNIT * taskInfo->pos),
            SQE_SIZE_UNIT, RtPtrToPtr<void*>(davidSqe), SQE_SIZE_UNIT);
        COND_RETURN_ERROR(rc != EOK, RT_ERROR_SEC_HANDLE, "memcpy_s failed for SQE update, stream_id=%d, task_id=%u, rc=%d.",
            stream->Id_(), taskId, static_cast<int32_t>(rc));

        // sqe已经拷贝到device场景下,需要做同步拷贝
        if (stream->Model_() != nullptr && stream->Model_()->IsSendSqe()) {
            error = driver->MemCopySync(RtValueToPtr<void*>(stream->GetSqBaseAddr() + (taskInfo->pos * SQE_SIZE_UNIT)),
                SQE_SIZE_UNIT, RtPtrToPtr<void*>(davidSqe), SQE_SIZE_UNIT, RT_MEMCPY_HOST_TO_DEVICE);
            COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "Copy sqe to device failed, stream_id=%d, retCode=%#x.", stream->Id_(), error);
        }
        RT_LOG(RT_LOG_DEBUG, "Update Ubdma sqe, stream_id=%d, task_id=%u, wqeCount=%u, jetty_id=%u, die_id=%u, func_id=%u.",
            stream->Id_(), taskId, wqeCount, jettyInfo.jettyId, jettyInfo.dieId, jettyInfo.functionId);
    }
    RT_LOG(RT_LOG_DEBUG, "Update Ubdma sqe success, stream_id=%d, posCount=%zu.", stream->Id_(), jettyCtx->taskWqeCounts.size());
    return RT_ERROR_NONE;
}

rtError_t StreamJettyHandler::BindJetty(
    Stream *stream, JettyType type,
    const CaptureModel *excludeMdl)
{
    NULL_PTR_RETURN(stream, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN(stream->Device_(), RT_ERROR_INVALID_VALUE);
    JettyManager *jettyMgr = stream->Device_()->GetJettyManager();
    NULL_PTR_RETURN(jettyMgr, RT_ERROR_INVALID_VALUE);
    const int32_t streamId = stream->Id_();
    StreamJettyContext *jettyCtx = jettyMgr->GetStreamJettyContext(streamId, type);
    if (jettyCtx == nullptr || jettyCtx->filledWqeCount == 0) {
        RT_LOG(RT_LOG_DEBUG, "No ub dma task, stream_id=%d, jetty_type=%d.",
            streamId, static_cast<int32_t>(type));
        return RT_ERROR_NONE;
    }
    // 反复执行时large jetty不释放
    if (jettyCtx->jettyHandle != 0) {
        RT_LOG(RT_LOG_DEBUG, "Jetty already bound, skip sync, stream_id=%d, jetty_type=%d.",
            streamId, static_cast<int32_t>(type));
        return RT_ERROR_NONE;
    }
    rtError_t error = jettyMgr->BindJettyForStream(streamId, excludeMdl, type);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "BindJettyForStream failed, stream_id=%d, retCode=%#x.", streamId, error);

    JettyInfo jettyInfo = {};
    error = jettyMgr->GetJettyInfoForStream(streamId, type, jettyInfo);
    ERROR_RETURN_MSG_INNER(error, "GetJettyInfoForStream failed, stream_id=%d, retCode=%#x.", streamId, error);

    error = FillWqeToDevice(stream, jettyCtx, jettyInfo);
    ERROR_RETURN_MSG_INNER(error, "FillWqeToDevice failed, stream_id=%d, retCode=%#x.", streamId, error);

    error = UpdateUbdmaSqeWithJettyInfo(stream, jettyCtx, jettyInfo);
    ERROR_RETURN_MSG_INNER(error, "UpdateUbdmaSqeWithJettyInfo failed, stream_id=%d, retCode=%#x.", streamId, error);
    return error;
}

rtError_t StreamJettyHandler::ResetJettyCi(
    JettyManager *jettyMgr, Stream *stream, JettyType type,
    const StreamJettyContext *ctx)
{
    if (jettyMgr == nullptr || ctx == nullptr || stream == nullptr) {
        return RT_ERROR_INVALID_VALUE;
    }
    const int32_t streamId = stream->Id_();
    JettyInfo jettyInfo = {};
    rtError_t error = jettyMgr->GetJettyInfoForStream(streamId, type, jettyInfo);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
        "GetJettyInfoForStream failed, stream_id=%d, retCode=%#x.", streamId, error);

    rtUbDbInfo_t dbInfo = {};
    dbInfo.wrCqe = 0U;
    dbInfo.dbNum = static_cast<uint8_t>(UB_DOORBELL_NUM_MIN);
    dbInfo.info[0].dieId = static_cast<uint16_t>((jettyInfo.dieId > UINT16_MAX) ? UINT16_MAX : jettyInfo.dieId);
    dbInfo.info[0].jettyId = static_cast<uint16_t>((jettyInfo.jettyId > UINT16_MAX) ? UINT16_MAX : jettyInfo.jettyId);
    dbInfo.info[0].functionId = static_cast<uint16_t>((jettyInfo.functionId > UINT16_MAX) ? UINT16_MAX : jettyInfo.functionId);
    const uint32_t piVal = ctx->capacity - ctx->filledWqeCount;
    dbInfo.info[0].piValue = static_cast<uint16_t>((piVal > UINT16_MAX) ? UINT16_MAX : piVal);
    NULL_PTR_RETURN(stream->Context_(), RT_ERROR_INVALID_VALUE);
    Stream *ctrlStream = stream->Context_()->GetCtrlSQStream();
    NULL_PTR_RETURN(ctrlStream, RT_ERROR_INVALID_VALUE);
    error = StreamUbDbSend(&dbInfo, ctrlStream, static_cast<uint16_t>(UbDmaSqeSource::RT_UBDMA_SOURCE_MODEL_EXE));
    RT_LOG(RT_LOG_INFO, "ResetJettyCi: stream_id=%d, dieId=%u, functionId=%u, jettyId=%u, piValue=%u.",
        streamId, jettyInfo.dieId, jettyInfo.functionId, jettyInfo.jettyId, dbInfo.info[0].piValue);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
        "send ub doorbell failed, stream_id=%d, retCode=%#x.", streamId, error);

    error = ctrlStream->Synchronize();
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
        "ub doorbell sync failed, stream_id=%d, retCode=%#x.", streamId, error);

    return RT_ERROR_NONE;
}

rtError_t StreamJettyHandler::RecycleJetty(Stream *stream, JettyType type, uint32_t &count)
{
    NULL_PTR_RETURN(stream, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN(stream->Device_(), RT_ERROR_INVALID_VALUE);
    JettyManager *jettyMgr = stream->Device_()->GetJettyManager();
    NULL_PTR_RETURN(jettyMgr, RT_ERROR_INVALID_VALUE);
    const int32_t streamId = stream->Id_();
    StreamJettyContext *jettyCtx = jettyMgr->GetStreamJettyContext(streamId, type);
    if (jettyCtx == nullptr || jettyCtx->jettyHandle == 0) {
        return RT_ERROR_NONE;
    }
    rtError_t error = ResetJettyCi(jettyMgr, stream, type, jettyCtx);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
        "ResetJettyCi failed, stream_id=%d, type=%d, retCode=%#x.",
        streamId, static_cast<int32_t>(type), error);

    if (!jettyCtx->isLargeDepth) {
        error = jettyMgr->UnbindJettyForStream(streamId, type);
        COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "UnbindJettyForStream failed, stream_id=%d, type=%d, retCode=%#x.",
            streamId, static_cast<int32_t>(type), error);
        count++;
    }
    return RT_ERROR_NONE;
}

rtError_t StreamJettyHandler::ReleaseJetty(Stream *stream, JettyType type)
{
    NULL_PTR_RETURN(stream, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN(stream->Device_(), RT_ERROR_INVALID_VALUE);
    JettyManager *jettyMgr = stream->Device_()->GetJettyManager();
    NULL_PTR_RETURN(jettyMgr, RT_ERROR_INVALID_VALUE);
    const int32_t streamId = stream->Id_();
    StreamJettyContext* jettyCtx = jettyMgr->GetStreamJettyContext(streamId, type);
    if (jettyCtx == nullptr) {
        return RT_ERROR_NONE;
    }

    const uint64_t savedHandle = jettyCtx->jettyHandle;
    rtError_t error = RT_ERROR_NONE;

    if (jettyCtx->isLargeDepth) {
        error = jettyMgr->UnbindJettyForStream(streamId, type);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "UnbindJettyForStream failed, stream_id=%d, retCode=%#x.", streamId, error);
        }
    } else if (savedHandle != 0) {
        error = jettyMgr->FreeJettyByHandle(savedHandle, type);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "FreeJettyByHandle failed, stream_id=%d, handle=%lu, retCode=%#x.",
                streamId, savedHandle, error);
        }
    } else {
        // do nothing
    }
    Driver *driver = stream->Device_()->Driver_();
    if (!jettyCtx->wqeBuffers.empty() && driver != nullptr) {
        jettyCtx->ReleaseBuffers(driver);
    }
    jettyMgr->DeleteStreamJettyContext(streamId, type);
    return error;
}

} // namespace runtime
} // namespace cce