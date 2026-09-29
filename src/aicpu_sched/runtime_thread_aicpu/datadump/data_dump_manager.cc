/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "data_dump_manager.hpp"

#include <new>

#include "aicpu_sched/aicpu_schedule/common/aicpusd_status.h"

namespace cce {
namespace runtime_thread_aicpu {
namespace datadump {
namespace {

void EraseModelTasks(const ModelDumpInfo& model, std::unordered_map<TaskKey, OpDumpInfoPtr, TaskKeyHash>& taskMap)
{
    for (const auto& item : model.ops) {
        const auto taskIt = taskMap.find(item.first);
        if ((taskIt != taskMap.end()) && (taskIt->second == item.second)) {
            taskMap.erase(taskIt);
        }
    }
}

} // namespace

RuntimeThreadAicpuStatus DataDumpManager::Load(const ModelDumpInfoPtr& model)
{
    if ((model == nullptr) || (model->config == nullptr)) {
        return RuntimeThreadAicpuStatus::INVALID_PARAM;
    }
    try {
        std::lock_guard<std::mutex> lock(mutex_);
        auto newModelMap = modelMap_;
        auto newTaskMap = taskMap_;
        const uint32_t modelId = model->config->modelId;
        const auto oldModel = newModelMap.find(modelId);
        if (oldModel != newModelMap.end()) {
            EraseModelTasks(*oldModel->second, newTaskMap);
        }
        newModelMap[modelId] = model;
        for (const auto& item : model->ops) {
            const auto oldTask = newTaskMap.find(item.first);
            if ((oldTask != newTaskMap.end()) && (oldTask->second != item.second)) {
                aicpusd_warn(
                    "DataDump task key is rebound to the later model, model_id=%u, stream_id=%u, task_id=%u.", modelId,
                    static_cast<uint32_t>(item.first.streamId), static_cast<uint32_t>(item.first.taskId));
            }
            newTaskMap[item.first] = item.second;
        }
        modelMap_.swap(newModelMap);
        taskMap_.swap(newTaskMap);
        aicpusd_info("Load DataDump model success, model_id=%u, op_count=%zu.", modelId, model->ops.size());
    } catch (const std::bad_alloc&) {
        aicpusd_err("Load DataDump model failed because memory allocation failed.");
        return RuntimeThreadAicpuStatus::NO_MEMORY;
    } catch (...) {
        aicpusd_err("Load DataDump model failed because updating indexes threw an exception.");
        return RuntimeThreadAicpuStatus::INTERNAL_ERROR;
    }
    return RuntimeThreadAicpuStatus::OK;
}

RuntimeThreadAicpuStatus DataDumpManager::Unload(const uint32_t modelId)
{
    std::lock_guard<std::mutex> lock(mutex_);
    const auto modelIt = modelMap_.find(modelId);
    if (modelIt == modelMap_.end()) {
        aicpusd_warn("Unload DataDump model ignored because it is not loaded, model_id=%u.", modelId);
        return RuntimeThreadAicpuStatus::OK;
    }
    EraseModelTasks(*modelIt->second, taskMap_);
    modelMap_.erase(modelIt);
    aicpusd_info("Unload DataDump model success, model_id=%u.", modelId);
    return RuntimeThreadAicpuStatus::OK;
}

ConstOpDumpInfoPtr DataDumpManager::SearchOp(const TaskKey& key) const
{
    std::lock_guard<std::mutex> lock(mutex_);
    const auto taskIt = taskMap_.find(key);
    return (taskIt == taskMap_.end()) ? ConstOpDumpInfoPtr() : taskIt->second;
}

} // namespace datadump
} // namespace runtime_thread_aicpu
} // namespace cce
