/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "host_task_queue.h"

#include <chrono>
#include <cinttypes>
#include <mutex>
#include <unordered_map>

#include "common/cc_utils.h"
#include "device.hpp"
#include "driver.hpp"
#include "error_message_manage.hpp"
#include "runtime.hpp"
#include "securec.h"

namespace cce {
namespace runtime {
namespace {
// Host 簿记独立存放，不能改变设备侧控制头布局。
struct BarTaskQueueMeta {
    void* devAddr;
    uint32_t deviceId;
    uint64_t totalSize;
};

std::mutex g_barTaskQueueMetaMutex;
std::unordered_map<BarTaskQueue*, BarTaskQueueMeta> g_barTaskQueueMetas;
} // namespace

rtError_t CreateBarTaskQueue(BarTaskQueue** queue, Device* device, uint32_t depth, uint32_t taskDescSize)
{
    COND_RETURN_ERROR(queue == nullptr, RT_ERROR_INVALID_VALUE, "Bar task queue out ptr is null.");
    *queue = nullptr;
    COND_RETURN_ERROR(device == nullptr, RT_ERROR_DEVICE_NULL, "Bar task queue device is null.");
    COND_RETURN_ERROR(device->Driver_() == nullptr, RT_ERROR_DRV_NULL, "Bar task queue driver is null.");
    COND_RETURN_ERROR(
        (depth < BAR_TASK_QUEUE_MIN_DEPTH) || (taskDescSize == 0U) || ((taskDescSize % BAR_TASK_DESC_ALIGN) != 0U),
        RT_ERROR_INVALID_VALUE, "Invalid bar task queue param, depth=%u, taskDescSize=%u.", depth, taskDescSize);

    const uint64_t descBytes = static_cast<uint64_t>(depth) * static_cast<uint64_t>(taskDescSize);
    COND_RETURN_ERROR(
        descBytes > (UINT64_MAX - static_cast<uint64_t>(sizeof(BarTaskQueue))), RT_ERROR_INVALID_VALUE,
        "Bar task queue size overflow, depth=%u, taskDescSize=%u.", depth, taskDescSize);
    const uint64_t totalSize = static_cast<uint64_t>(sizeof(BarTaskQueue)) + descBytes;

    const uint32_t deviceId = device->Id_();
    void* devAddr = nullptr;
    rtError_t ret = device->Driver_()->DevMemAllocWithBackupFlag(
        &devAddr, totalSize, RT_MEMORY_P2P_HBM, deviceId, DevMemBackupType::SNAPSHOT_NO_BACKUP);
    COND_RETURN_ERROR_MSG_INNER(
        ret != RT_ERROR_NONE, ret, "Bar task queue alloc dev mem failed, size=%" PRIu64 ", deviceId=%u.", totalSize,
        deviceId);

    void* mappedAddr = nullptr;
    ret = device->Driver_()->PcieHostRegister(devAddr, totalSize, deviceId, mappedAddr);
    if (ret != RT_ERROR_NONE) {
        (void)device->Driver_()->DevMemFree(devAddr, deviceId);
        RT_LOG(
            RT_LOG_ERROR, "Bar task queue PcieHostRegister failed, size=%" PRIu64 ", deviceId=%u.", totalSize,
            deviceId);
        return ret;
    }
    void* const hostAddr = (mappedAddr == nullptr) ? devAddr : mappedAddr;

    (void)memset_s(hostAddr, static_cast<size_t>(totalSize), 0, static_cast<size_t>(totalSize));
    BarTaskQueue* const barQueue = static_cast<BarTaskQueue*>(hostAddr);
    // 清零及控制头写入必须先于设备开始读取。
    __sync_synchronize();
    barQueue->hostStatus = TASK_QUEUE_STATUS_WAITING;
    barQueue->deviceStatus = TASK_QUEUE_STATUS_WAITING;
    barQueue->complete = 0U;
    barQueue->head = 0U;
    barQueue->tail = 0U;
    barQueue->depth = depth;
    barQueue->taskDescSize = taskDescSize;
    __sync_synchronize();

    {
        std::lock_guard<std::mutex> lock(g_barTaskQueueMetaMutex);
        g_barTaskQueueMetas[barQueue] = BarTaskQueueMeta{devAddr, deviceId, totalSize};
    }

    *queue = barQueue;
    RT_LOG(
        RT_LOG_INFO,
        "Create bar task queue success, queue=%p, deviceId=%u, depth=%u, taskDescSize=%u, size=%" PRIu64 ".",
        static_cast<void*>(barQueue), deviceId, depth, taskDescSize, totalSize);
    return RT_ERROR_NONE;
}

rtError_t ResetBarTaskQueue(BarTaskQueue* queue)
{
    COND_RETURN_ERROR(queue == nullptr, RT_ERROR_INVALID_VALUE, "Bar task queue is null.");
    const uint64_t descBytes = static_cast<uint64_t>(queue->depth) * static_cast<uint64_t>(queue->taskDescSize);
    if (descBytes > 0U) {
        (void)memset_s(queue->taskDescList, static_cast<size_t>(descBytes), 0, static_cast<size_t>(descBytes));
    }
    __sync_synchronize();
    queue->complete = 0U;
    queue->head = 0U;
    queue->tail = 0U;

    queue->hostStatus = TASK_QUEUE_STATUS_WAITING;
    queue->deviceStatus = TASK_QUEUE_STATUS_WAITING;
    queue->deviceErrCode = 0U;
    __sync_synchronize();
    return RT_ERROR_NONE;
}

bool IsBarTaskQueueTerminated(const BarTaskQueue* queue)
{
    return (queue == nullptr) || (queue->hostStatus == TASK_QUEUE_STATUS_TERMINATED) ||
           (queue->deviceStatus == TASK_QUEUE_STATUS_TERMINATED);
}

rtError_t BeginBarTaskRound(BarTaskQueue* queue, bool* proceed)
{
    COND_RETURN_ERROR(queue == nullptr, RT_ERROR_INVALID_VALUE, "Bar task queue is null.");
    COND_RETURN_ERROR(proceed == nullptr, RT_ERROR_INVALID_VALUE, "Bar task queue proceed flag out ptr is null.");
    *proceed = false;

    // Host 的外部终止信号不能被 Reset 掩盖。
    if (queue->hostStatus == TASK_QUEUE_STATUS_TERMINATED) {
        RT_LOG(
            RT_LOG_WARNING, "Bar task queue host side terminated, round not started, complete=%u.",
            static_cast<uint32_t>(queue->complete));
        return RT_ERROR_NONE;
    }

    const rtError_t ret = ResetBarTaskQueue(queue);
    *proceed = (ret == RT_ERROR_NONE);
    return ret;
}

rtError_t FreeBarTaskQueue(BarTaskQueue* queue)
{
    COND_RETURN_ERROR(queue == nullptr, RT_ERROR_INVALID_VALUE, "Bar task queue is null.");
    BarTaskQueueMeta meta{};
    {
        std::lock_guard<std::mutex> lock(g_barTaskQueueMetaMutex);
        const auto iter = g_barTaskQueueMetas.find(queue);
        COND_RETURN_ERROR(iter == g_barTaskQueueMetas.end(), RT_ERROR_INVALID_VALUE, "Bar task queue is not created.");
        meta = iter->second;
        (void)g_barTaskQueueMetas.erase(iter);
    }

    // Reset 流程内不能等待 REF_UPDATING，否则会自等待。
    Device* const dev = Runtime::Instance()->GetDevice(meta.deviceId, 0U, false);
    COND_RETURN_ERROR(
        (dev == nullptr) || (dev->Driver_() == nullptr), RT_ERROR_DEVICE_NULL,
        "Bar task queue device is null, deviceId=%u.", meta.deviceId);

    rtError_t ret = dev->Driver_()->PcieHostUnRegister(meta.devAddr, meta.deviceId);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Bar task queue PcieHostUnRegister failed, deviceId=%u, ret=%#x.", meta.deviceId, ret);
    }
    const rtError_t freeRet = dev->Driver_()->DevMemFree(meta.devAddr, meta.deviceId);
    if (freeRet != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Bar task queue DevMemFree failed, deviceId=%u, ret=%#x.", meta.deviceId, freeRet);
    }
    if ((ret == RT_ERROR_NONE) && (freeRet == RT_ERROR_NONE)) {
        RT_LOG(
            RT_LOG_INFO, "Free bar task queue success, queue=%p, deviceId=%u, size=%" PRIu64 ".",
            static_cast<void*>(queue), meta.deviceId, meta.totalSize);
    }
    return (ret != RT_ERROR_NONE) ? ret : freeRet;
}

rtError_t IsBarTaskQueueFull(BarTaskQueue* queue, bool* isFull)
{
    COND_RETURN_ERROR(queue == nullptr, RT_ERROR_INVALID_VALUE, "Bar task queue is null.");
    COND_RETURN_ERROR(isFull == nullptr, RT_ERROR_INVALID_VALUE, "Bar task queue full flag out ptr is null.");
    COND_RETURN_ERROR(
        queue->depth < BAR_TASK_QUEUE_MIN_DEPTH, RT_ERROR_INVALID_VALUE, "Bar task queue depth is invalid, depth=%u.",
        queue->depth);

    *isFull = (((queue->head + 1U) % queue->depth) == queue->tail);
    return RT_ERROR_NONE;
}

rtError_t IsBarTaskQueueEmpty(BarTaskQueue* queue, bool* isEmpty)
{
    COND_RETURN_ERROR(queue == nullptr, RT_ERROR_INVALID_VALUE, "Bar task queue is null.");
    COND_RETURN_ERROR(isEmpty == nullptr, RT_ERROR_INVALID_VALUE, "Bar task queue empty flag out ptr is null.");

    *isEmpty = (queue->head == queue->tail);
    return RT_ERROR_NONE;
}

rtError_t PushBarTask(BarTaskQueue* queue, const void* taskDesc, size_t taskDescSize, int32_t timeoutMs)
{
    COND_RETURN_ERROR(queue == nullptr, RT_ERROR_INVALID_VALUE, "Bar task queue is null.");
    COND_RETURN_ERROR(taskDesc == nullptr, RT_ERROR_INVALID_VALUE, "Bar task desc is null.");
    COND_RETURN_ERROR(
        queue->depth < BAR_TASK_QUEUE_MIN_DEPTH, RT_ERROR_INVALID_VALUE, "Bar task queue depth is invalid, depth=%u.",
        queue->depth);
    COND_RETURN_ERROR(
        (taskDescSize == 0U) || (taskDescSize != queue->taskDescSize), RT_ERROR_INVALID_VALUE,
        "Bar task desc size mismatch, expect=%u, actual=%" PRIu64 ".", queue->taskDescSize,
        static_cast<uint64_t>(taskDescSize));
    COND_RETURN_ERROR(
        IsBarTaskQueueTerminated(queue), RT_ERROR_DEVICE_TASK_ABORT,
        "Bar task queue is terminated, task push is not allowed.");

    const std::chrono::steady_clock::time_point start = std::chrono::steady_clock::now();
    for (;;) {
        COND_RETURN_ERROR(
            IsBarTaskQueueTerminated(queue), RT_ERROR_DEVICE_TASK_ABORT,
            "Bar task queue is terminated while waiting for free slot, task push is not allowed.");
        bool isFull = false;
        (void)IsBarTaskQueueFull(queue, &isFull);
        if (!isFull) {
            break;
        }
        if ((timeoutMs >= 0) && ((std::chrono::steady_clock::now() - start) >= std::chrono::milliseconds(timeoutMs))) {
            RT_LOG(
                RT_LOG_ERROR, "Bar task queue wait free slot timeout, timeout=%dms, depth=%u, head=%u, tail=%u.",
                timeoutMs, queue->depth, queue->head, queue->tail);
            return RT_ERROR_CC_WORKER_TIMEOUT;
        }
        CCSpinWait(start);
    }

    const uint32_t head = queue->head;
    uint8_t* const desc = queue->taskDescList + static_cast<size_t>(head) * static_cast<size_t>(queue->taskDescSize);
    (void)memcpy_s(desc, static_cast<size_t>(queue->taskDescSize), taskDesc, taskDescSize);
    // 描述符写入必须先于 head 发布。
    __sync_synchronize();
    queue->head = (head + 1U) % queue->depth;
    __sync_synchronize();
    return RT_ERROR_NONE;
}

rtError_t GetCompletedBarTaskNum(BarTaskQueue* queue, uint32_t* completedNum)
{
    COND_RETURN_ERROR(queue == nullptr, RT_ERROR_INVALID_VALUE, "Bar task queue is null.");
    COND_RETURN_ERROR(completedNum == nullptr, RT_ERROR_INVALID_VALUE, "Bar completed num out ptr is null.");

    const uint32_t completed = queue->complete;
    // complete 前进后才能读取设备写入的分片结果。
    __sync_synchronize();
    *completedNum = completed;
    return RT_ERROR_NONE;
}

rtError_t GetBarTaskQueueDevAddr(BarTaskQueue* queue, uint64_t* devAddr)
{
    COND_RETURN_ERROR(queue == nullptr, RT_ERROR_INVALID_VALUE, "Bar task queue is null.");
    COND_RETURN_ERROR(devAddr == nullptr, RT_ERROR_INVALID_VALUE, "Bar task queue dev addr out ptr is null.");

    std::lock_guard<std::mutex> lock(g_barTaskQueueMetaMutex);
    const auto iter = g_barTaskQueueMetas.find(queue);
    COND_RETURN_ERROR(iter == g_barTaskQueueMetas.end(), RT_ERROR_INVALID_VALUE, "Bar task queue is not created.");
    *devAddr = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(iter->second.devAddr));
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
