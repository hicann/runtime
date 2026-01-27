/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "task_manager.h"
#include "collection_entry.h"
#include "errno/error_code.h"
#include "message/codec.h"
#include "msprof_dlog.h"
#include "task_relationship_mgr.h"

namespace analysis {
namespace dvvp {
namespace device {
using namespace analysis::dvvp::common::error;

TaskManager::TaskManager()
    : isInited_(false)
{
}

TaskManager::~TaskManager()
{
}

/**
 * @brief Task management initialization
 * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
 */
int32_t TaskManager::Init()
{
    int32_t ret = PROFILING_SUCCESS;

    isInited_ = true;
    return ret;
}

/**
 * @brief Task management destruction, emptying residual tasks
 * @return : success return PROFILING_SUCCESS, failed return PROFIING_FAILED
 */
int32_t TaskManager::Uninit()
{
    int32_t ret = PROFILING_SUCCESS;
    if (isInited_) {
        ClearTask();
        isInited_ = false;
    }
    return ret;
}

/**
 * @brief Empty residual tasks
 * @return : No return value
 */
void TaskManager::ClearTask()
{
    std::lock_guard<std::mutex> lk(mtx_);
    auto iter = taskMap_.begin();
    while (iter != taskMap_.end()) {
        (void)iter->second->OnConnectionReset();
        iter++;
    }
    taskMap_.clear();
}

void TaskManager::ConnectionReset(SHARED_PTR_ALIA<analysis::dvvp::transport::ITransport> transport)
{
    if (transport == nullptr) {
        MSPROF_LOGE("ConnectionReset failed, transport is null");
        return;
    }
    std::lock_guard<std::mutex> lk(mtx_);
    auto iter = taskMap_.begin();
    while (iter != taskMap_.end()) {
        if (iter->second->GetTransport().get() == transport.get()) {
            (void)iter->second->OnConnectionReset();
            iter = taskMap_.erase(iter);
            continue;
        }
        iter++;
    }
}

/**
 * @brief Create new device side task, if Task exist return nullptr
 * @param [in] hostId: Device number on the host side
 * @param [in] jobId:  Task number, unique identifier
 * @return :
            success return Shared pointer for tasks
            failed return nullptr
 */
SHARED_PTR_ALIA<ProfJobHandler> TaskManager::CreateTask(int32_t hostId, const std::string &jobId,
    SHARED_PTR_ALIA<analysis::dvvp::transport::ITransport> transport)
{
    if (transport == nullptr) {
        MSPROF_LOGE("CreateTask failed, transport is nullptr");
        return nullptr;
    }

    if (!isInited_) {
        MSPROF_LOGE("TaskManager is not inited yet");
        return nullptr;
    }

    MSPROF_LOGI("CreateTask, hostId(%d), JobId(%s)", hostId, jobId.c_str());

    int32_t ret = PROFILING_SUCCESS;
    auto task = GetTask(jobId);
    if (task == nullptr) {
        std::lock_guard<std::mutex> lk(mtx_);
        MSVP_MAKE_SHARED0(task, ProfJobHandler, return nullptr);
        int32_t devIndexId = Analysis::Dvvp::TaskHandle::TaskRelationshipMgr::instance()->GetDevIdByHostId(hostId);
        ret = task->Init(devIndexId, jobId, transport);
        if (ret != PROFILING_SUCCESS) {
            task.reset();
            return nullptr;
        }
        task->SetDevIdOnHost(hostId);
        taskMap_[jobId] = task;
        return task;
    }

    MSPROF_LOGI("JobId(%s) task exist, don't create again", jobId.c_str());
    return nullptr;
}

/**
 * @brief Get the task based on the task number
 * @param [in] jobId: Task number, unique identifier
 * @return :
            success return Shared pointer for tasks
            if task not eixst, return nullptr
 */
SHARED_PTR_ALIA<ProfJobHandler> TaskManager::GetTask(const std::string &jobId)
{
    if (!isInited_) {
        MSPROF_LOGE("TaskManager is not inited yet");
        return nullptr;
    }

    MSPROF_LOGI("GetTask, JobId(%s)", jobId.c_str());
    std::lock_guard<std::mutex> lk(mtx_);
    auto iter = taskMap_.find(jobId);
    if (iter != taskMap_.end()) {
        return iter->second;
    }
    return nullptr;
}

/**
 * @brief Delete the task according to the task number
 * @param [in] jobId: Task number, unique identifier
 * @return :
            if delete success, return true
            if task not eixst, return false
 */
bool TaskManager::DeleteTask(const std::string &jobId)
{
    if (!isInited_) {
        MSPROF_LOGE("TaskManager is not inited yet");
        return false;
    }

    MSPROF_LOGI("DeleteTask, JobId(%s)", jobId.c_str());
    std::lock_guard<std::mutex> lk(mtx_);
    auto iter = taskMap_.find(jobId);
    if (iter != taskMap_.end()) {
        taskMap_.erase(iter);
        return true;
    }

    return false;
}
} // analysis
} // dvvp
} // device
