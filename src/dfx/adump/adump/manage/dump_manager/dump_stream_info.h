/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DUMP_STREAM_INFO_H
#define DUMP_STREAM_INFO_H

#include <map>
#include <mutex>
#include <string>
#include <iostream>
#include <memory>
#include <condition_variable>
#include <chrono>
#include <thread>
#include <queue>
#include <atomic>
#include <sstream>
#include <cstdint>
#include <algorithm>
#include <cstring>
#include <vector>
#include "acl/acl_base.h"
#include "acl/acl_rt.h"
#include "log/adx_log.h"
#include "adump_pub.h"
#include "dump_tensor.h"
#include "proto/dump_task.pb.h"
#include "dump_memory.h"
#include "runtime/runtime/event.h"
#include "runtime/runtime/stream.h"
#include "runtime/rts/rts_stream.h"
#include "runtime/rts/rts_kernel.h"

namespace Adx {
constexpr uint32_t DUMP_SLICE_SIZE = 128 * 1024 * 1024; // 128MB

struct ChunkContext {
    std::vector<char>& buffer;
    size_t& offset;
    const std::string& fileName;
};
typedef struct DumpStreamInfo {
    rtStream_t stm;
    rtEvent_t mainStmEvt;
    rtEvent_t dumpStmEvt;
    std::vector<DumpTensor> inputTensors;
    std::vector<DumpTensor> outputTensors;
    std::string mainStreamKey;
    std::string opType;
    std::string opName;
    uint32_t taskId;
    uint32_t streamId;
    uint32_t deviceId;
    uint32_t contextId;
    uint32_t threadId;
    uint64_t timestamp;
    uint64_t dumpNumber;
    std::string dumpPath;
} DumpStreamInfo;

typedef struct DumpInfoParams {
    std::string mainStreamKey;
    std::vector<DumpTensor> inputTensors;
    std::vector<DumpTensor> outputTensors;
    std::string opType;
    std::string opName;
    uint32_t streamId;
    uint32_t taskId;
    uint32_t deviceId;
    uint32_t contextId;
    uint32_t threadId;
    std::string dumpPath;
} DumpInfoParams;

int32_t DumpStreamCreate(DumpStreamInfo** ptr);
void DumpStreamFree(DumpStreamInfo* ptr);
uint64_t GetNextDumpNumber();

std::string GenerateDumpFileName(const DumpStreamInfo* dumpInfoPtr);
void FillTensorProtoInfo(const std::vector<DumpTensor>& tensors, toolkit::dump::DumpData& data, bool isInput);
toolkit::dump::DumpData BuildDumpDataProto(const DumpStreamInfo* dumpInfoPtr);
size_t CalculateTensorDataSize(const std::vector<DumpTensor>& tensors);

int32_t DumpTensorPushToDumpQueue(
    void* dataBuf, uint32_t bufLen, const char* fileName, uint64_t offset, uint32_t isLastChunk);
int32_t FlushCurrentChunk(ChunkContext& ctx, uint32_t isLastChunk);
int32_t CopyTensorDataWithFlush(const DumpTensor& tensor, ChunkContext& ctx, bool isLastTensorForChunk);
int32_t CopyTensorsWithChunking(const std::vector<DumpTensor>& tensors, ChunkContext& ctx, bool isLastTensorList);
void DumpTensorToQueue(DumpStreamInfo* dumpInfoPtr);

int32_t CollectStreamContextInfo(
    aclrtStream mainStream, const std::string& opName, const std::string& opType, uint32_t& streamId, uint32_t& taskId,
    uint32_t& deviceId, std::string& dumpPath);
void DumpDataRecordInCaptureStream(void* fnArgs);
int32_t SetupAsyncDump(
    std::shared_ptr<DumpStreamInfo> dumpInfoPtr, const std::string& opName, const std::string& opType,
    aclrtStream mainStream);
int32_t GetDumpInfoFromMap(DumpInfoParams& params);

inline int32_t GetPrimaryFormat(int32_t format)
{
    return static_cast<int32_t>(static_cast<uint32_t>(format) & 0xffU);
}

inline int32_t GetSubFormat(int32_t format)
{
    return static_cast<int32_t>((static_cast<uint32_t>(format) & 0xffff00U) >> 8);
}

class DumpResourceSafeMap {
public:
    static DumpResourceSafeMap& Instance()
    {
        static DumpResourceSafeMap instance;
        return instance;
    }

    void insert(const std::string key, std::shared_ptr<DumpStreamInfo> ptr)
    {
        std::lock_guard<std::mutex> lock(mtx_);
        resourceMap_[key] = std::move(ptr);
    }

    void remove(const std::string key)
    {
        std::lock_guard<std::mutex> lock(mtx_);
        resourceMap_.erase(key);
    }

    std::shared_ptr<DumpStreamInfo> get(const std::string key)
    {
        std::lock_guard<std::mutex> lock(mtx_);
        auto it = resourceMap_.find(key);
        if (it != resourceMap_.end()) {
            return it->second;
        }
        return nullptr;
    }

    int32_t size()
    {
        std::lock_guard<std::mutex> lock(mtx_);
        return resourceMap_.size();
    }

    void clear()
    {
        std::lock_guard<std::mutex> lock(mtx_);
        resourceMap_.clear();
    }

    void waitAndClear()
    {
        StopCleanupThread();
        clear();
        IDE_LOGI("All dump operations completed and resources cleared");
    }

    void EnqueueCleanup(const std::string key);
    bool IsCleanupThreadActive();

private:
    void StartCleanupThread();
    void StopCleanupThread();
    void CleanupThreadLoop();

    DumpResourceSafeMap() : cleanupThreadActive_(false)
    {}
    ~DumpResourceSafeMap()
    {
        StopCleanupThread();
        std::lock_guard<std::mutex> lock(mtx_);
        resourceMap_.clear();
    }
    DumpResourceSafeMap(const DumpResourceSafeMap&) = delete;
    DumpResourceSafeMap& operator=(const DumpResourceSafeMap&) = delete;

    std::map<const std::string, std::shared_ptr<DumpStreamInfo>> resourceMap_;
    std::mutex mtx_;

    std::thread cleanupThread_;
    std::queue<std::string> cleanupQueue_;
    std::mutex cleanupMtx_;
    std::condition_variable cleanupCv_;
    std::atomic<bool> cleanupThreadActive_;
};
} // namespace Adx
#endif