/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ADX_COMMON_UTILS_BOUND_QUEUE_MEMORY_H
#define ADX_COMMON_UTILS_BOUND_QUEUE_MEMORY_H
#include <condition_variable>
#include <fstream>
#include <queue>
#include <mutex>
#include <sys/sysinfo.h>
#include "hdc_log.h"

namespace Adx {
constexpr float ADX_QUEUE_FULL_SIZE = 0.85f;
constexpr const char* MEM_USAGE_V1 = "/sys/fs/cgroup/memory/memory.usage_in_bytes";
constexpr const char* MEM_USAGE_V2 = "/sys/fs/cgroup/memory.current";
constexpr const char* MEM_LIMIT_V1 = "/sys/fs/cgroup/memory/memory.limit_in_bytes";
constexpr const char* MEM_LIMIT_V2 = "/sys/fs/cgroup/memory.max";

template<typename T>
class BoundQueueMemory {
public:
    explicit BoundQueueMemory () : quit_(false), memLimit_(InitMemLimit()) {
        memUsageV1_.open(MEM_USAGE_V1);
        memUsageV2_.open(MEM_USAGE_V2);
    }
    virtual ~BoundQueueMemory() {
        memUsageV1_.close();
        memUsageV2_.close();
    }
    bool Push(T &value)
    {
        std::unique_lock<std::mutex> lk(mtx_);
        cvPop_.wait(lk, [this] { return !this->IsFull() || this->quit_;});
        dataQueue_.push(value);
        cvPush_.notify_all();
        return true;
    }

    bool Pop(T &value)
    {
        std::unique_lock<std::mutex> lk(mtx_);
        cvPush_.wait(lk, [this] { return !this->IsEmpty() || this->quit_; });
        if (!this->IsEmpty()) {
            value = this->dataQueue_.front();
            this->dataQueue_.pop();
            cvPop_.notify_all();
            return true;
        }

        return false;
    }

    bool IsEmpty() const
    {
        return dataQueue_.empty();
    }

    bool IsFull() const
    {
        struct sysinfo info;
        const size_t queueSize = 60;
        int32_t ret = sysinfo(&info);
        if (ret != EN_OK) {
            IDE_LOGW("Can not get memory, sysinfo return: %d", ret);
            return dataQueue_.size() >= queueSize;
        }
        // if in memory-limited container, make sure that memory usage in container is less than 85%
        if (memLimit_ > 0 && memLimit_ < info.totalram) {
            uint64_t memUsage = ReadMemory(memUsageV1_, memUsageV2_);
            if (memUsage == 0) {
                IDE_LOGW("Can not read memory usage from cgroup.");
                return dataQueue_.size() >= queueSize;
            }
            return (memUsage > ADX_QUEUE_FULL_SIZE * memLimit_) && dataQueue_.size() > queueSize;
        }
        return (info.freeram < (info.totalram * (1 - ADX_QUEUE_FULL_SIZE))) && dataQueue_.size() > queueSize;
    }

    void Init()
    {
        std::lock_guard<std::mutex> lk(mtx_);
        quit_ = false;
    }

    void Quit()
    {
        std::lock_guard<std::mutex> lk(mtx_);
        if (!quit_) {
            quit_ = true;
            cvPush_.notify_all();
            cvPop_.notify_all();
        }
    }

    uint32_t Size() const
    {
        return dataQueue_.size();
    }

    void SetPath(std::string path)
    {
        path_ = path;
    }

private:
    uint64_t InitMemLimit() const {
        std::ifstream memLimitV1(MEM_LIMIT_V1);
        std::ifstream memLimitV2(MEM_LIMIT_V2);
        uint64_t ret = ReadMemory(memLimitV1, memLimitV2);
        memLimitV1.close();
        memLimitV2.close();
        return ret;
    }
    uint64_t ReadLongLong(std::ifstream &f) const {
        if (!f.is_open()) {
            return 0;
        }
        uint64_t v;
        if (f >> v) {
            f.clear();
            f.seekg(0);
            return v;
        }
        return 0;
    }

    uint64_t ReadMemory(std::ifstream &f1, std::ifstream &f2) const {
        uint64_t value = ReadLongLong(f2);
        if (value == 0) {
            value = ReadLongLong(f1);
        }
        return value;
    }
    mutable bool quit_;
    mutable std::mutex mtx_;
    std::queue<T> dataQueue_;
    std::condition_variable cvPop_;
    std::condition_variable cvPush_;
    std::string path_;
    mutable std::ifstream memUsageV1_;
    mutable std::ifstream memUsageV2_;
    uint64_t memLimit_;
};
}
#endif
