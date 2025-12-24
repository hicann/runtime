/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_TASK_ALLOCATOR_HPP
#define CCE_RUNTIME_TASK_ALLOCATOR_HPP

#include <mutex>
#include <map>
#include <vector>
#include "base.hpp"
#include "osal.hpp"
#include "task_info.hpp"
#include "buffer_allocator.hpp"

namespace cce {
namespace runtime {
class Stream;

// used for allocating taskId in stream
typedef struct tag_TaskIdManager {
    int32_t mapTaskIds[MAX_UINT16_NUM];
    int32_t lastId;
    std::mutex taskIdManagerLock;
} TaskIdManager;

struct SerialTaskId {
    std::map<uint16_t, uint16_t> serialIds;
    uint16_t lastId;
};

class TaskAllocator : public NoCopy {
public:
    explicit TaskAllocator(const uint32_t itemSize, const uint32_t initCount = 256,
                           const uint32_t maxCount = MAX_UINT16_NUM,
                           const BufferAllocator::Strategy stg = BufferAllocator::EXPONENTIAL);
    ~TaskAllocator(void) override;

    void GetAllocId(int32_t &retId, TaskIdManager * const idManager);
    int32_t AllocId(const Stream * const stm, rtError_t &errCode);

    void *GetItemById(const int32_t streamId, const int32_t taskId, rtError_t &errCode);

    void FreeById(const Stream * const stm, const int32_t taskId, bool isSinkFlag);

    TaskIdManager *TaskIdManagerAlloc(const int32_t streamId);

    void FreeStreamRes(const int32_t streamId);
    void SetSerialId(const int32_t streamId, TaskInfo * const taskPtr);
    void ClearSerialId(const int32_t streamId);
    void DelSerialId(const int32_t streamId, const uint16_t serial);
    int32_t GetTaskId(const int32_t streamId, const uint16_t serial);
    void *GetItemBySerial(const int32_t streamId, const int32_t serial);

private:
    BufferAllocator allocator_;
    uint32_t usedCntSink_;
    uint32_t usedCntUnSink_;
    std::mutex taskAllocLock_;
    std::mutex vecIdManagerLock_;
    std::mutex serialManagerLock_;
    std::vector<TaskIdManager *> vecIdManager_{std::vector<TaskIdManager *>(RT_MAX_STREAM_ID, nullptr)};
    std::map<int32_t, SerialTaskId> serialManager_;
};
}
}

#endif  // CCE_RUNTIME_TASK_ALLOCATOR_HPP
