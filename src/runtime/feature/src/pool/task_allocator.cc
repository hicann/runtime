/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "task_allocator.hpp"

#include "runtime.hpp"
#include "task.hpp"
#include "stream.hpp"
#include "error_message_manage.hpp"
#include "task_submit.hpp"

namespace cce {
namespace runtime {
TaskAllocator::TaskAllocator(const uint32_t itemSize, const uint32_t initCount, const uint32_t maxCount,
    const BufferAllocator::Strategy stg)
    : NoCopy(), allocator_(itemSize, initCount, maxCount, stg),
      usedCntSink_(0U), usedCntUnSink_(0U)
{
}

TaskAllocator::~TaskAllocator()
{
    std::unique_lock<std::mutex> vecIdLock(vecIdManagerLock_);
    auto iter = vecIdManager_.begin();
    while (iter != vecIdManager_.end()) {
        if (*iter != nullptr) {
            delete *iter;
        }
        iter++;
    }
}

void TaskAllocator::GetAllocId(int32_t &retId, TaskIdManager * const idManager)
{
    std::lock_guard<std::mutex> taskIdManagerLock(idManager->taskIdManagerLock);
    int32_t &lastId = idManager->lastId;
    for (uint32_t i = 0U; i < MAX_UINT16_NUM; i++) {
        lastId++;
        if (lastId >= static_cast<int32_t>(MAX_UINT16_NUM)) {
            lastId = 0;
        }

        // find available lastId_ 0~65534. 65535 is reserved for special use
        if (idManager->mapTaskIds[lastId] == RT_INVALID_ID) {
            const int32_t bufferId = allocator_.AllocId();
            if (bufferId < 0) {
                RT_LOG(RT_LOG_ERROR, "alloc bufferId failed, lastId=%d, bufferId=%d", lastId, bufferId);
                return;
            }
            idManager->mapTaskIds[lastId] = bufferId;
            retId = lastId;
            return;
        }
    }
}

void TaskAllocator::FreeById(const Stream * const stm, const int32_t taskId, bool isSinkFlag)
{
    COND_RETURN_VOID(((taskId >= static_cast<int32_t>(MAX_UINT16_NUM)) || (taskId < 0)),
        "Invalid task_id, current taskId is %d valid task range is [%u, %u)", taskId, 0, MAX_UINT16_NUM);
    COND_RETURN_VOID(stm == nullptr, "input parameter is invalid, stream is null");

    const int32_t streamId = stm->Id_();
    TaskIdManager *idManager = nullptr;

    COND_RETURN_VOID(static_cast<uint32_t>(streamId) >= RT_MAX_STREAM_ID,
        "Get item by id failed, stream id is invalid, stream_id=%d", streamId);

    std::unique_lock<std::mutex> vecIdLock(vecIdManagerLock_);
    const auto iter = vecIdManager_[static_cast<uint32_t>(streamId)];
    if (iter != nullptr) {
        idManager = iter;
    } else {
        vecIdLock.unlock();
        RT_LOG(RT_LOG_WARNING, "Get taskId Manager failed, stream_id=%d", streamId);
        return;
    }
    vecIdLock.unlock();

    std::unique_lock<std::mutex> idLock(idManager->taskIdManagerLock);
    const int32_t bufferId = idManager->mapTaskIds[taskId];
    if (bufferId < 0) {
        idLock.unlock();
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Invalid para,stream_id=%d and task_id=%d does not exist", streamId, taskId);
        return;
    }

    idManager->mapTaskIds[taskId] = RT_INVALID_ID;
    idLock.unlock();

    uint32_t * const usedCnt = (isSinkFlag ? &usedCntSink_ : &usedCntUnSink_);
    std::unique_lock<std::mutex> taskLock(taskAllocLock_);
    if (*usedCnt > 0U) {
        *usedCnt = *usedCnt - 1U;
    }
    taskLock.unlock();
    allocator_.FreeById(bufferId);

    return;
}

int32_t TaskAllocator::AllocId(const Stream * const stm, rtError_t &errCode)
{
    int32_t retId = RT_INVALID_ID;
    // Allocating taskId in the same stream cannot be operated in mutiple threads at the same time.
    const int32_t streamId = stm->Id_();
    TaskIdManager *idManager = nullptr;

    COND_PROC_RETURN_ERROR_MSG_INNER(static_cast<uint32_t>(streamId) >= RT_MAX_STREAM_ID,
        RT_INVALID_ID, errCode = RT_ERROR_STREAM_INVALID,
        "Alloc id failed, stream id is invalid, stream_id=%d", streamId);
    std::unique_lock<std::mutex> vecIdLock(vecIdManagerLock_);
    const auto vecIdIterator = vecIdManager_[static_cast<uint32_t>(streamId)];
    if (vecIdIterator != nullptr) {
        idManager = vecIdIterator;
    } else {
        idManager = TaskIdManagerAlloc(streamId);
        if (idManager == nullptr) {
            vecIdLock.unlock();
            RT_LOG_INNER_MSG(RT_LOG_ERROR, "Alloc taskId Manager failed");
            return retId;
        }
    }
    vecIdLock.unlock();

    uint32_t *usedCnt = nullptr;
    uint32_t maxCnt;
    if (stm->IsTaskSink()) {
        usedCnt = &usedCntSink_;
        maxCnt = Runtime::macroValue_.maxSinkTaskNum;
    } else {
        usedCnt = &usedCntUnSink_;
        maxCnt = Runtime::macroValue_.maxSupportTaskNum;
    }

    std::unique_lock<std::mutex> taskLock(taskAllocLock_);
    if (*usedCnt >= maxCnt) {
        taskLock.unlock();
        RT_LOG(RT_LOG_WARNING,
            "Alloc failed invalid usedCnt=%u, valid cnt range is [%u, %u),usedCntSink_=%u, usedCntUnSink_=%u",
            *usedCnt, 0, maxCnt, usedCntSink_, usedCntUnSink_);
        errCode = RT_ERROR_TASK_OUT_OF_RANGE;
        return retId;
    }
    *usedCnt = *usedCnt + 1U;
    taskLock.unlock();

    GetAllocId(retId, idManager);
    if (retId < 0) {
        taskLock.lock();
        *usedCnt = *usedCnt - 1U;
        RT_LOG(RT_LOG_WARNING, "alloc task fail, retId=%d, maxCnt=%u, usedCnt=%u, streamId=%d",
            retId, maxCnt, *usedCnt, streamId);
        errCode = RT_ERROR_TASK_ID_ALLOCATION;
        taskLock.unlock();
    }

    return retId;
}

void *TaskAllocator::GetItemById(const int32_t streamId, const int32_t taskId, rtError_t &errCode)
{
    COND_PROC_RETURN_ERROR_MSG_INNER(
        ((taskId >= static_cast<int32_t>(MAX_UINT16_NUM)) || (taskId < 0)),
        nullptr, errCode = RT_ERROR_TASK_ID_INVALID ,
        "Get item by id failed, invalid task_id, current taskId is %d"
        "valid task range is [%u, %u)", taskId, 0U, MAX_UINT16_NUM);
    COND_PROC_RETURN_ERROR_MSG_INNER(
        (static_cast<uint32_t>(streamId) >= RT_MAX_STREAM_ID),
        nullptr, errCode = RT_ERROR_STREAM_INVALID,
        "Get item by id failed, stream id is invalid, stream_id=%d", streamId);

    std::unique_lock<std::mutex> vecIdLock(vecIdManagerLock_);
    const auto iter = vecIdManager_[static_cast<uint32_t>(streamId)];
    if (iter != nullptr) {
        const int32_t bufferId = iter->mapTaskIds[taskId];
        COND_PROC_RETURN_WARN(bufferId < 0, nullptr, errCode = RT_ERROR_TASK_ID_ALLOCATION,
            "stream_id=%d, task_id=%d, buffer_id=%d", streamId, taskId, bufferId);
        return allocator_.GetItemById(bufferId);
    } else {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Get task failed, the stream_id %d is invalid,"
                                       "current stream_id is not in tasklist", streamId);
        errCode = RT_ERROR_STREAM_INVALID;
        return nullptr;
    }
}

TaskIdManager *TaskAllocator::TaskIdManagerAlloc(const int32_t streamId)
{
    TaskIdManager * const idManager = new (std::nothrow) TaskIdManager;
    if (idManager == nullptr) {
        return nullptr;
    }
    vecIdManager_[static_cast<uint32_t>(streamId)] = idManager;
    idManager->lastId = RT_INVALID_ID;
    for (uint32_t i = 0U; i < MAX_UINT16_NUM; i++) {
        idManager->mapTaskIds[i] = RT_INVALID_ID;
    }
    return idManager;
}

void TaskAllocator::FreeStreamRes(const int32_t streamId)
{
    if (Runtime::Instance()->GetDisableThread()) {
        std::lock_guard<std::mutex> serialLock(serialManagerLock_);
        (void)serialManager_.erase(streamId);
    }
    // ctrl stream_id == -1, not delete id manager.
    if (streamId == -1) {
        return;
    }
    COND_RETURN_VOID(static_cast<uint32_t>(streamId) >= RT_MAX_STREAM_ID,
        "stream id is invalid, stream_id=%d", streamId);
    std::unique_lock<std::mutex> vecIdLock(vecIdManagerLock_);
    DELETE_O(vecIdManager_[static_cast<uint32_t>(streamId)]); 
}

void TaskAllocator::ClearSerialId(const int32_t streamId)
{
    std::unique_lock<std::mutex> serialLock(serialManagerLock_);
    SerialTaskId &serialTask = serialManager_[streamId];
    serialTask.lastId = 0U;
    (void)serialTask.serialIds.clear();
}

void TaskAllocator::SetSerialId(const int32_t streamId, TaskInfo * const taskPtr)
{
    COND_RETURN_VOID(taskPtr == nullptr, "null task");

    std::lock_guard<std::mutex> serialLock(serialManagerLock_);
    SerialTaskId &serialTask = serialManager_[streamId];
    uint16_t serialId = serialTask.lastId++;    // auto overflow.
    if (taskPtr->stream != nullptr) {
        if ((taskPtr->stream->Device_() != nullptr)
            && (serialId >= MAX_UINT16_NUM)) {
            serialId = serialTask.lastId++;
        }
    }
    serialTask.serialIds[serialId] = taskPtr->id;

    taskPtr->id = serialId;
    taskPtr->serial = true;
    UpdateFlipNum(taskPtr, true);
    RT_LOG(RT_LOG_DEBUG, "stream_id=%d, change task_id=%hu(old) to serial_id=%hu(new)",
        streamId, serialTask.serialIds[serialId], serialId);
}

void TaskAllocator::DelSerialId(const int32_t streamId, const uint16_t serial)
{
    std::lock_guard<std::mutex> serialLock(serialManagerLock_);
    const auto it1 = serialManager_.find(streamId);
    if (it1 == serialManager_.end()) {
        return;
    }

    SerialTaskId &idManager = it1->second;
    (void)idManager.serialIds.erase(serial);
}

int32_t TaskAllocator::GetTaskId(const int32_t streamId, const uint16_t serial)
{
    int32_t retId = RT_INVALID_ID;

    std::lock_guard<std::mutex> serialLock(serialManagerLock_);
    const auto it1 = serialManager_.find(streamId);
    if (it1 == serialManager_.end()) {
        return retId;
    }

    SerialTaskId &idManager = it1->second;
    const auto it2 = idManager.serialIds.find(serial);
    if (it2 != idManager.serialIds.end()) {
        retId = static_cast<int32_t>(it2->second);
    }

    RT_LOG(RT_LOG_DEBUG, "stream_id=%d, retId=%d, serial_id=%u", streamId, retId, serial);
    return retId;
}

void *TaskAllocator::GetItemBySerial(const int32_t streamId, const int32_t serial)
{
    std::unique_lock<std::mutex> serialLock(serialManagerLock_);
    const auto it1 = serialManager_.find(streamId);
    if (it1 == serialManager_.end()) {
        serialLock.unlock();
        RT_LOG(RT_LOG_WARNING, "can not get task, stream_id=%d is invalid", streamId);
        return nullptr;
    }

    SerialTaskId &idManager = it1->second;
    const auto it2 = idManager.serialIds.find(static_cast<uint16_t>(serial));
    if (it2 == idManager.serialIds.end()) {
        serialLock.unlock();
        RT_LOG(RT_LOG_WARNING, "can not get task, serial_id=%d is invalid", serial);
        return nullptr;
    }
    serialLock.unlock();

    RT_LOG(RT_LOG_DEBUG, "stream_id=%d, task_id=%hu, serial_id=%d", streamId, it2->second, serial);
    rtError_t errCode = RT_ERROR_NONE;
    return GetItemById(streamId, static_cast<int32_t>(it2->second), errCode);
}

}  // namespace runtime
}  // namespace cce