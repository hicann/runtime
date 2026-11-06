/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef MSTX_MANAGER_H
#define MSTX_MANAGER_H

#include <atomic>
#include <chrono>
#include <cstring>
#include <mutex>
#include <string>
#include <unordered_map>
#include <vector>
#include <sys/syscall.h>
#include <unistd.h>
#include "msprof_error_manager.h"
#include "singleton/singleton.h"
#include "thread/thread.h"
#include "queue/ring_buffer.h"
#include "msprof_tx_manager.h"
#include "mstx_resource_name_util.h"

namespace Collector {
namespace Dvvp {
namespace Mstx {
using namespace Msprof::MsprofTx;

constexpr size_t RING_BUFFER_DEFAULT_CAPACITY = 512;
// 资源命名缓冲上限：与 mark/range 的 RingBuffer 保持同一量级，避免高频调用无界增长
constexpr size_t RESOURCE_NAME_BUF_CAPACITY = RING_BUFFER_DEFAULT_CAPACITY;

enum class MstxDataType { DATA_MARK = 0, DATA_RANGE_START, DATA_RANGE_END, DATA_RESOURCE_NAME, DATA_INVALID };

// 资源命名记录：一条 = 一次命名调用（命名无 endNs，与 mark/range 语义不同）
struct MstxResourceNameInfo {
    uint32_t threadId;
    uint32_t resourceType;   // MstxResourceType
    uint32_t identifierKind; // 0=id 换算成功 1=句柄值回退
    uint64_t identifier;     // 统一 64 位资源标识
    uint64_t domainNameHash;
    uint32_t category;
    uint64_t timestamp;
    std::string name;
};

struct MstxInfo {
    uint32_t threadId;
    uint32_t eventType;
    uint64_t startTime;
    uint64_t endTime;
    uint64_t markId;
    uint64_t domain;
    std::string message;
};

class MstxDataHandler : public analysis::dvvp::common::singleton::Singleton<MstxDataHandler>,
                        public analysis::dvvp::common::thread::Thread {
public:
    MstxDataHandler();
    ~MstxDataHandler();

    int Start(const std::string& mstxDomainInclude, const std::string& mstxDomainExclude);
    int Stop();
    void Run(const error_message::ErrorManagerContext& errorContext) override;
    bool IsStart();
    int SaveMstxData(const char* msg, uint64_t mstxEventId, MstxDataType type, uint64_t domainNameHash = 0);
    // 记录一条资源命名；未启动采集时直接丢弃（与 mark 行为一致）
    int SaveMstxResourceName(
        uint32_t resourceType, uint64_t identifier, uint32_t identifierKind, const char* name, uint32_t category,
        uint64_t domainNameHash)
    {
        if (!start_.load()) {
            return -1;
        }
        if (name == nullptr || name[0] == '\0') {
            return -1;
        }
        MstxResourceNameInfo info{};
        info.threadId = static_cast<uint32_t>(syscall(SYS_gettid));
        info.resourceType = resourceType;
        info.identifierKind = identifierKind;
        info.identifier = identifier;
        info.domainNameHash = domainNameHash;
        info.category = category;
        info.timestamp = static_cast<uint64_t>(
            std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch())
                .count());
        info.name = MstxTruncateResourceName(name);
        std::lock_guard<std::mutex> lock(resourceNameMutex_);
        if (resourceNameBuf_.size() >= RESOURCE_NAME_BUF_CAPACITY) {
            return -1; // 缓冲已满：丢弃本条，由调用方记录日志
        }
        resourceNameBuf_.push_back(std::move(info));
        return 0;
    }

private:
    void Init();
    void Uninit();
    int SaveMarkData(const char* msg, uint64_t mstxEventId, uint64_t domainNameHash);
    int SaveRangeData(const char* msg, uint64_t mstxEventId, MstxDataType type, uint64_t domainNameHash);

    void Flush();
    void ReportData();
    void ReportResourceNames();
    std::vector<MsprofTxInfo> SplitMstxInfo(const MstxInfo& info);

private:
    uint32_t processId_{0};
    std::atomic<bool> init_{false};
    std::atomic<bool> start_{false};
    analysis::dvvp::common::queue::RingBuffer<MstxInfo> mstxDataBuf_{MstxInfo{}};
    std::mutex tmpRangeDataMutex_;
    std::mutex resourceNameMutex_;
    std::vector<MstxResourceNameInfo> resourceNameBuf_;
    std::unordered_map<uint64_t, MstxInfo> tmpMstxRangeData_;
};
} // namespace Mstx
} // namespace Dvvp
} // namespace Collector
#endif
