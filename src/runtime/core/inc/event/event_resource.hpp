/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_EVENT_RESOURCE_HPP
#define CCE_RUNTIME_EVENT_RESOURCE_HPP

#include <cstdint>
#include <mutex>

namespace cce {
namespace runtime {
class Event;
struct tagTaskInfoStru;

constexpr uint32_t IPC_NOTIFY_NAME_BUFFER_LEN = 65U;

struct CrossEventSharedInfo {
    std::mutex mutex;
    uint32_t shrId{UINT32_MAX}; // UINT32_MAX 表示共享关系尚未创建
    char name[IPC_NOTIFY_NAME_BUFFER_LEN]{};
};

// 同一 CountNotify Event 可由不同 Stream 下发 Record，已提交的 Wait 仍需按提交时的导入信息回收。因此，
// 每个 Wait 任务独立 Open/Map，保存本次 Open 使用的共享名、返回的 ID 和映射状态，以便任务完成或回滚时独立执行
// Unmap/Close。
struct CrossEventWaitInfo {
    void (*release)(tagTaskInfoStru*);
    uint32_t shrId; // halShrIdOpen 返回的共享资源 ID
    uint32_t tsId;
    uint32_t phyId;
    char name[IPC_NOTIFY_NAME_BUFFER_LEN];
    bool isCountNotify;
    bool mapped;
};

struct EventResource {
    Event* event{nullptr};
    uint64_t eventAddr{0ULL};
    int32_t eventId{-1};
    int32_t streamId{-1};
    uint32_t taskId{UINT32_MAX};
    uint64_t expectCqeNo{0ULL};
};
} // namespace runtime
} // namespace cce

#endif
