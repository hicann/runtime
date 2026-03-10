/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dump_stream_info.h"
#include "dump_manager.h"
#include "adx_dump_record.h"
#include "common_utils.h"
#include "adump/adx_datadump_callback.h"
#include "adx_msg_proto.h"
#include "memory_utils.h"
#include "sys_utils.h"

namespace Adx {

static std::atomic<uint64_t> g_dumpNumber(0);

uint64_t GetNextDumpNumber()
{
    return g_dumpNumber.fetch_add(1);
}

void DumpResourceSafeMap::CleanupThreadLoop()
{
    IDE_LOGI("Cleanup thread started");
    while (cleanupThreadActive_.load()) {
        std::string key;
        {
            std::unique_lock<std::mutex> lock(cleanupMtx_);
            cleanupCv_.wait(lock, [this]() { return !cleanupQueue_.empty() || !cleanupThreadActive_.load(); });

            if (cleanupQueue_.empty() && !cleanupThreadActive_.load()) {
                IDE_LOGI("Cleanup thread exiting");
                return;
            }

            if (!cleanupQueue_.empty()) {
                key = cleanupQueue_.front();
                cleanupQueue_.pop();
            }
        }

        if (!key.empty()) {
            IDE_LOGI("Cleanup thread removing key: %s", key.c_str());
            remove(key);
        }
    }
}

void DumpResourceSafeMap::StartCleanupThread()
{
    if (cleanupThreadActive_.load()) {
        return;
    }

    std::lock_guard<std::mutex> lock(cleanupMtx_);
    if (cleanupThreadActive_.load()) {
        return;
    }
    cleanupThreadActive_.store(true);
    cleanupThread_ = std::thread(&DumpResourceSafeMap::CleanupThreadLoop, this);
    IDE_LOGI("Cleanup thread started");
}

void DumpResourceSafeMap::StopCleanupThread()
{
    {
        std::lock_guard<std::mutex> lock(cleanupMtx_);
        if (!cleanupThreadActive_.load()) {
            return;
        }
        cleanupThreadActive_.store(false);
    }
    cleanupCv_.notify_one();

    if (cleanupThread_.joinable()) {
        cleanupThread_.join();
    }
    IDE_LOGI("Cleanup thread stopped");
}

void DumpResourceSafeMap::EnqueueCleanup(const std::string key)
{
    StartCleanupThread();
    {
        std::lock_guard<std::mutex> lock(cleanupMtx_);
        cleanupQueue_.push(key);
    }
    cleanupCv_.notify_one();
    IDE_LOGI("Enqueued key for cleanup: %s", key.c_str());
}

bool DumpResourceSafeMap::IsCleanupThreadActive()
{
    return cleanupThreadActive_.load();
}

int32_t DumpStreamCreate(DumpStreamInfo** ptr)
{
    if (ptr == nullptr) {
        IDE_LOGE("Dump stream create failed, ptr is null");
        return ADUMP_FAILED;
    }

    DumpStreamInfo* dumpPtr = new (std::nothrow) DumpStreamInfo();
    if (dumpPtr == nullptr) {
        IDE_LOGE("Dump stream malloc failed");
        *ptr = nullptr;
        return ADUMP_FAILED;
    }

    rtError_t ret = rtEventCreateExWithFlag(&(dumpPtr->mainStmEvt), RT_EVENT_DEFAULT);
    if (ret != RT_ERROR_NONE) {
        IDE_LOGE("create main stream event failed");
        delete dumpPtr;
        return ret;
    }

    ret = rtEventCreateExWithFlag(&(dumpPtr->dumpStmEvt), RT_EVENT_DEFAULT);
    if (ret != RT_ERROR_NONE) {
        IDE_LOGE("create dump stream event failed");
        rtEventDestroy(dumpPtr->mainStmEvt);
        delete dumpPtr;
        return ret;
    }

    ret = rtStreamCreate(&(dumpPtr->stm), 0);
    if (ret != RT_ERROR_NONE) {
        IDE_LOGE("create dump stream failed");
        rtEventDestroy(dumpPtr->mainStmEvt);
        rtEventDestroy(dumpPtr->dumpStmEvt);
        delete dumpPtr;
        return ret;
    }

    *ptr = dumpPtr;
    return ADUMP_SUCCESS;
}

void DumpStreamFree(DumpStreamInfo* ptr)
{
    if (!ptr) {
        return;
    }
    if (ptr->mainStmEvt) {
        rtEventDestroy(ptr->mainStmEvt);
    }
    if (ptr->dumpStmEvt) {
        rtEventDestroy(ptr->dumpStmEvt);
    }
    if (ptr->stm) {
        rtStreamDestroy(ptr->stm);
    }
    ptr->inputTensors.clear();
    ptr->outputTensors.clear();
    delete ptr;
}

std::string GenerateDumpFileName(const DumpStreamInfo* dumpInfoPtr)
{
    const std::string& dumpPath = dumpInfoPtr->dumpPath;
    const std::string& opType = dumpInfoPtr->opType;
    const std::string& opName = dumpInfoPtr->opName;
    uint32_t taskId = dumpInfoPtr->taskId;
    uint32_t streamId = dumpInfoPtr->streamId;
    uint32_t contextId = dumpInfoPtr->contextId;
    uint32_t threadId = dumpInfoPtr->threadId;
    uint32_t deviceId = dumpInfoPtr->deviceId;
    uint64_t timestamp = dumpInfoPtr->timestamp;
    uint64_t dumpNumber = dumpInfoPtr->dumpNumber;

    std::ostringstream fileNameoss;
    if (!dumpPath.empty() && dumpPath.back() == '/') {
        fileNameoss << dumpPath << deviceId << "/" << opType << "." << opName << "." << dumpNumber << "." << taskId
                    << "." << streamId << "." << timestamp;
    } else {
        fileNameoss << dumpPath << "/" << deviceId << "/" << opType << "." << opName << "." << dumpNumber << "."
                    << taskId << "." << streamId << "." << timestamp;
    }
    if (contextId != 0 && threadId != 0) {
        fileNameoss << ".FFTSPLUS." << contextId << "." << threadId << "." << deviceId;
    }
    return fileNameoss.str();
}

void FillTensorProtoInfo(const std::vector<DumpTensor>& tensors, toolkit::dump::DumpData& data, bool isInput)
{
    for (size_t i = 0; i < tensors.size(); i++) {
        const DumpTensor& item = tensors[i];
        int32_t format = item.GetFormat();

        if (isInput) {
            auto* opInput = data.add_input();
            opInput->set_data_type(static_cast<toolkit::dump::OutputDataType>(item.GetDataType()));
            opInput->set_format(static_cast<toolkit::dump::OutputFormat>(GetPrimaryFormat(format)));
            opInput->set_sub_format(GetSubFormat(format));
            opInput->set_offset(item.GetArgsOffSet());
            opInput->set_size(item.GetSize());

            auto* shape = opInput->mutable_shape();
            for (auto dim : item.GetShape()) {
                shape->add_dim(dim);
            }
            auto* originShape = opInput->mutable_original_shape();
            for (auto dim : item.GetOriginShape()) {
                originShape->add_dim(dim);
            }
        } else {
            auto* opOutput = data.add_output();
            opOutput->set_data_type(static_cast<toolkit::dump::OutputDataType>(item.GetDataType()));
            opOutput->set_format(static_cast<toolkit::dump::OutputFormat>(GetPrimaryFormat(format)));
            opOutput->set_sub_format(GetSubFormat(format));
            opOutput->set_size(item.GetSize());

            auto* shape = opOutput->mutable_shape();
            for (auto dim : item.GetShape()) {
                shape->add_dim(dim);
            }
            auto* originShape = opOutput->mutable_original_shape();
            for (auto dim : item.GetOriginShape()) {
                originShape->add_dim(dim);
            }
        }
    }
}

toolkit::dump::DumpData BuildDumpDataProto(const DumpStreamInfo* dumpInfoPtr)
{
    toolkit::dump::DumpData dumpData;
    dumpData.set_version("2.0");
    dumpData.set_dump_time(dumpInfoPtr->timestamp);
    dumpData.set_op_name(dumpInfoPtr->opName);

    FillTensorProtoInfo(dumpInfoPtr->inputTensors, dumpData, true);
    FillTensorProtoInfo(dumpInfoPtr->outputTensors, dumpData, false);

    return dumpData;
}

size_t CalculateTensorDataSize(const std::vector<DumpTensor>& tensors)
{
    size_t totalSize = 0;
    for (const auto& tensor : tensors) {
        totalSize += tensor.GetSize();
    }
    return totalSize;
}

int32_t DumpTensorPushToDumpQueue(
    void* dataBuf, uint32_t bufLen, const char* fileName, uint64_t offset, uint32_t isLastChunk)
{
    int err;
    uint32_t dataLen = 0;
    IDE_RETURN_IF_CHECK_ASSIGN_32U_ADD(sizeof(DumpChunk), bufLen, dataLen, return IDE_DAEMON_INTERGER_REVERSED_ERROR);
    MsgProto* msg = AdxMsgProto::CreateMsgPacket(IDE_DUMP_REQ, 0, nullptr, dataLen);
    IDE_CTRL_VALUE_FAILED(msg != nullptr, return IDE_DAEMON_MALLOC_ERROR, "create message failed");
    SharedPtr<MsgProto> sendDataMsgPtr(msg, IdeXfree);
    msg = nullptr;
    DumpChunk* data = reinterpret_cast<DumpChunk*>(sendDataMsgPtr->data);
    err = strcpy_s(data->fileName, IDE_MAX_FILE_PATH, fileName);
    IDE_CTRL_VALUE_FAILED(err == EOK, return IDE_DAEMON_INVALID_PATH_ERROR, "copy file name failed");
    data->bufLen = bufLen;
    data->flag = 0;
    data->isLastChunk = isLastChunk;
    data->offset = static_cast<int64_t>(offset);
    IDE_LOGI(
        "dataLen: %u, bufLen: %u, flag: %d, isLastChunk: %u, offset: %ld, fileName: %s", dataLen, data->bufLen,
        data->flag, data->isLastChunk, data->offset, data->fileName);
    err = memcpy_s(data->dataBuf, data->bufLen, dataBuf, bufLen);
    IDE_CTRL_VALUE_FAILED(err == EOK, return IDE_DAEMON_UNKNOW_ERROR, "memcpy_s data buffer failed");
    HostDumpDataInfo dataInfo = {sendDataMsgPtr, dataLen};
    if (!AdxDumpRecord::Instance().RecordDumpDataToQueue(dataInfo)) {
        IDE_LOGW("dump data queue full");
        return ADUMP_FAILED;
    }
    IDE_LOGD("dump data process normal");
    return ADUMP_SUCCESS;
}

int32_t FlushCurrentChunk(ChunkContext& ctx, uint32_t isLastChunk)
{
    if (ctx.offset == 0) {
        return ADUMP_SUCCESS;
    }
    (void)DumpTensorPushToDumpQueue(
        ctx.buffer.data(), static_cast<uint32_t>(ctx.offset), ctx.fileName.c_str(), 0, isLastChunk);
    ctx.offset = 0;
    (void)memset_s(ctx.buffer.data(), DUMP_SLICE_SIZE, 0, DUMP_SLICE_SIZE);
    return ADUMP_SUCCESS;
}

int32_t CopyTensorDataWithFlush(const DumpTensor& tensor, ChunkContext& ctx, bool isLastTensorForChunk)
{
    if (tensor.GetAddress() == nullptr) {
        IDE_LOGE("tensor address is null");
        return ADUMP_FAILED;
    }

    size_t remainSize = tensor.GetSize();
    size_t srcOffset = 0;

    while (remainSize > 0) {
        size_t space = DUMP_SLICE_SIZE - ctx.offset;
        if (space == 0) {
            (void)FlushCurrentChunk(ctx, 0);
            space = DUMP_SLICE_SIZE;
        }

        size_t copySize = std::min(space, remainSize);
        void* hostData =
            DumpMemory::CopyDeviceToHost(static_cast<const char*>(tensor.GetAddress()) + srcOffset, copySize);
        if (hostData == nullptr) {
            IDE_LOGE("CopyDeviceToHost failed, size: %zu", copySize);
            return ADUMP_FAILED;
        }

        errno_t ret = memcpy_s(ctx.buffer.data() + ctx.offset, space, hostData, copySize);
        HOST_RT_MEMORY_GUARD(hostData);
        if (ret != EOK) {
            IDE_LOGE("memcpy_s failed, ret: %d", ret);
            return ADUMP_FAILED;
        }

        ctx.offset += copySize;
        srcOffset += copySize;
        remainSize -= copySize;

        bool isLastChunk = (remainSize == 0) && isLastTensorForChunk;
        if (ctx.offset >= DUMP_SLICE_SIZE) {
            (void)FlushCurrentChunk(ctx, isLastChunk ? 1 : 0);
        }
    }
    return ADUMP_SUCCESS;
}

int32_t CopyTensorsWithChunking(const std::vector<DumpTensor>& tensors, ChunkContext& ctx, bool isLastTensorList)
{
    size_t tensorCount = tensors.size();
    for (size_t i = 0; i < tensorCount; ++i) {
        bool isLastTensorForChunk = isLastTensorList && (i == tensorCount - 1);
        int ret = CopyTensorDataWithFlush(tensors[i], ctx, isLastTensorForChunk);
        if (ret != ADUMP_SUCCESS) {
            IDE_LOGE("CopyTensorDataWithFlush failed, ret: %d", ret);
            return ret;
        }
    }
    return ADUMP_SUCCESS;
}

void DumpTensorToQueue(DumpStreamInfo* dumpInfoPtr)
{
    if (dumpInfoPtr == nullptr) {
        IDE_LOGE("dumpInfoPtr is nullptr");
        return;
    }

    std::string fileName = GenerateDumpFileName(dumpInfoPtr);
    toolkit::dump::DumpData dumpData = BuildDumpDataProto(dumpInfoPtr);

    uint64_t protoSize = dumpData.ByteSizeLong();
    if (protoSize == 0 || protoSize > DUMP_SLICE_SIZE) {
        IDE_LOGW("%s protobuf size invalid: %lu", fileName.c_str(), protoSize);
        return;
    }

    std::vector<char> chunkBuffer(DUMP_SLICE_SIZE);
    size_t currentOffset = 0;

    *(reinterpret_cast<uint64_t*>(chunkBuffer.data() + currentOffset)) = protoSize;
    currentOffset += sizeof(uint64_t);

    if (!dumpData.SerializeToArray(chunkBuffer.data() + currentOffset, static_cast<int32_t>(protoSize))) {
        IDE_LOGE("SerializeToArray failed");
        return;
    }
    currentOffset += protoSize;

    ChunkContext ctx{chunkBuffer, currentOffset, fileName};

    size_t outputTensorSize = 0;
    for (size_t i = 0; i < dumpInfoPtr->outputTensors.size(); i++) {
        outputTensorSize += dumpInfoPtr->outputTensors[i].GetSize();
    }

    if (CopyTensorsWithChunking(dumpInfoPtr->inputTensors, ctx, (outputTensorSize == 0)) != ADUMP_SUCCESS) {
        IDE_LOGE("%s copy input tensors failed", fileName.c_str());
        return;
    }

    if (CopyTensorsWithChunking(dumpInfoPtr->outputTensors, ctx, true) != ADUMP_SUCCESS) {
        IDE_LOGE("%s copy output tensors failed", fileName.c_str());
        return;
    }

    if (ctx.offset > 0) {
        (void)FlushCurrentChunk(ctx, 1);
    }

    IDE_LOGI("%s dump success, total offset: %zu", fileName.c_str(), currentOffset);
}

int32_t CollectStreamContextInfo(
    aclrtStream mainStream, const std::string& opName, const std::string& opType, uint32_t& streamId, uint32_t& taskId,
    uint32_t& deviceId, std::string& dumpPath)
{
    rtError_t ret = rtsStreamGetId(mainStream, reinterpret_cast<int32_t*>(&streamId));
    IDE_CTRL_VALUE_FAILED(
        (ret == RT_ERROR_NONE), return ADUMP_FAILED, "%s(%s) dump data : get main stream id failed, ret: %d",
        opName.c_str(), opType.c_str(), ret);

    ret = rtsGetThreadLastTaskId(&taskId);
    IDE_CTRL_VALUE_FAILED(
        (ret == RT_ERROR_NONE), return ADUMP_FAILED, "%s(%s) dump data : get task id failed, ret: %d", opName.c_str(),
        opType.c_str(), ret);

    int32_t deviceIdTmp = 0;
    ret = rtGetDevice(&deviceIdTmp);
    IDE_CTRL_VALUE_FAILED(
        (ret == RT_ERROR_NONE), return ADUMP_FAILED, "%s(%s) dump data : get device id failed, ret: %d", opName.c_str(),
        opType.c_str(), ret);
    deviceId = static_cast<uint32_t>(deviceIdTmp);

    dumpPath = DumpManager::Instance().GetDumpSetting().GetDumpPath();
    if (dumpPath.empty()) {
        IDE_LOGE("%s(%s) dump data : get dump path failed", opName.c_str(), opType.c_str());
        return ADUMP_FAILED;
    }
    return ADUMP_SUCCESS;
}

void DumpDataRecordInCaptureStream(void* fnArgs)
{
    if (fnArgs == nullptr) {
        IDE_LOGE("create dump stream failed");
        return;
    }

    DumpStreamInfo* args = static_cast<DumpStreamInfo*>(fnArgs);
    if (args == nullptr) {
        IDE_LOGE("args is nullptr");
        return;
    }

    IDE_LOGI("%s input tensor dump, size : %d", args->opName.c_str(), args->inputTensors.size());
    IDE_LOGI("%s output tensor dump, size : %d", args->opName.c_str(), args->outputTensors.size());
    DumpTensorToQueue(args);

    DumpResourceSafeMap::Instance().EnqueueCleanup(args->mainStreamKey);
}

int32_t SetupAsyncDump(
    std::shared_ptr<DumpStreamInfo> dumpInfoPtr, const std::string& opName, const std::string& opType,
    aclrtStream mainStream)
{
    rtError_t ret = rtEventRecord(dumpInfoPtr->mainStmEvt, mainStream);
    IDE_CTRL_VALUE_FAILED(
        ret == RT_ERROR_NONE, return ADUMP_FAILED, "%s(%s) main stream record event failed, ret: %d", opName.c_str(),
        opType.c_str(), ret);

    ret = rtStreamWaitEvent(dumpInfoPtr->stm, dumpInfoPtr->mainStmEvt);
    IDE_CTRL_VALUE_FAILED(
        ret == RT_ERROR_NONE, return ADUMP_FAILED, "%s(%s) dump stream wait event failed, ret: %d", opName.c_str(),
        opType.c_str(), ret);

    ret = rtsLaunchHostFunc(
        dumpInfoPtr->stm, reinterpret_cast<rtCallback_t>(DumpDataRecordInCaptureStream), (void*)dumpInfoPtr.get());
    IDE_CTRL_VALUE_FAILED(
        ret == RT_ERROR_NONE, return ADUMP_FAILED, "%s(%s) launch host function failed, ret: %d", opName.c_str(),
        opType.c_str(), ret);

    ret = rtEventRecord(dumpInfoPtr->dumpStmEvt, dumpInfoPtr->stm);
    IDE_CTRL_VALUE_FAILED(
        ret == RT_ERROR_NONE, return ADUMP_FAILED, "%s(%s) dump stream record event failed, ret: %d", opName.c_str(),
        opType.c_str(), ret);

    ret = rtStreamWaitEvent(mainStream, dumpInfoPtr->dumpStmEvt);
    IDE_CTRL_VALUE_FAILED(
        ret == RT_ERROR_NONE, return ADUMP_FAILED, "%s(%s) main stream wait event failed, ret: %d", opName.c_str(),
        opType.c_str(), ret);
    return ADUMP_SUCCESS;
}

int32_t GetDumpInfoFromMap(DumpInfoParams& params)
{
    auto it = DumpResourceSafeMap::Instance().get(params.mainStreamKey);
    if (it != nullptr) {
        return ADUMP_SUCCESS;
    }

    DumpStreamInfo* dumpPtr = nullptr;
    int32_t ret = DumpStreamCreate(&dumpPtr);
    std::shared_ptr<DumpStreamInfo> dumpInfo(dumpPtr, DumpStreamFree);
    if (ret != ADUMP_SUCCESS) {
        IDE_LOGE("ceate dump info error, ret : %d", ret);
        return ADUMP_FAILED;
    }
    dumpPtr->mainStreamKey = params.mainStreamKey;
    dumpPtr->opType = params.opType;
    dumpPtr->opName = params.opName;
    dumpPtr->streamId = params.streamId;
    dumpPtr->taskId = params.taskId;
    dumpPtr->deviceId = params.deviceId;
    dumpPtr->contextId = params.contextId;
    dumpPtr->threadId = params.threadId;
    dumpPtr->timestamp = SysUtils::GetTimestamp();
    dumpPtr->dumpNumber = GetNextDumpNumber();
    dumpPtr->dumpPath = params.dumpPath;
    uint32_t dumpMode = DumpManager::Instance().GetDumpSetting().GetDumpMode();
    if ((dumpMode & DUMP_MODE_INPUT) != 0) {
        for (const auto& tensorInfo : params.inputTensors) {
            dumpPtr->inputTensors.emplace_back(tensorInfo);
        }
    }

    if ((dumpMode & DUMP_MODE_OUTPUT) != 0) {
        for (const auto& tensorInfo : params.outputTensors) {
            dumpPtr->outputTensors.emplace_back(tensorInfo);
        }
    }
    DumpResourceSafeMap::Instance().insert(params.mainStreamKey, dumpInfo);
    return ADUMP_SUCCESS;
}

} // namespace Adx