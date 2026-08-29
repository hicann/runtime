/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <mutex>

#include "dump_stats_param.h"
#include "dump_stats_process.h"
#include "dump_stats_interface.h"

using namespace kfc_dump_stats;

namespace {
std::mutex g_kfcDumpStateMutex;
}

extern "C" {
__attribute__((visibility("default"))) uint32_t AdumpStatsOpSrvInit(void* args)
{
    if (args == nullptr) {
        IDE_LOGE("Initialization parameter for kfc dump server is null");
        return static_cast<uint32_t>(KFC_DUMP_E_PARA);
    }
    const std::lock_guard<std::mutex> lk(g_kfcDumpStateMutex);
    IDE_LOGI("Start to initialize the kfc dump server");
    auto dumpParam = reinterpret_cast<KfcDumpOpInitParam*>(args);
    return static_cast<uint32_t>(KfcDumpProcess::InitKfcDumpInfo(dumpParam));
}

__attribute__((visibility("default"))) uint32_t AdumpStatsOpSrvLaunch(void* args)
{
    const std::lock_guard<std::mutex> lk(g_kfcDumpStateMutex);
    uint64_t kfcSrvStartTime = GetCurCpuTimestamp();
    if (args == nullptr) {
        IDE_LOGE("Launch parameter for dump statistics task is null");
        return static_cast<uint32_t>(KFC_DUMP_E_PARA);
    }
    auto* task = reinterpret_cast<KfcDumpTask*>(args);
    KfcDumpInfo* dumpInfo = nullptr;
    IDE_LOGI(
        "Receive kfc dump statistics task, streamId[%u] taskId[%u] index[%u]", task->streamId_, task->taskId_,
        task->index_);
    if (AicpuGetOpTaskInfo == nullptr) {
        IDE_LOGE("AicpuGetOpTaskInfo is unresolved, aicpu scheduler does not support dump statistics");
        return static_cast<uint32_t>(KFC_DUMP_E_NOT_SUPPORT);
    }
    uint32_t ret = AicpuGetOpTaskInfo(*task, &dumpInfo);
    if (ret != 0) {
        IDE_LOGE("Failed to get operator tensor information from aicpu scheduler, ret[%u]", ret);
        return ret;
    }

    if (dumpInfo == nullptr) {
        IDE_LOGE("Aicpu scheduler returned null operator tensor information");
        return static_cast<uint32_t>(KFC_DUMP_E_INTERNAL);
    }
    ret = static_cast<uint32_t>(KfcDumpProcess::KfcDumpRunStatServer(task, dumpInfo));
    IDE_LOGI(
        "Kfc dump statistics task is finished, time cost[%lu us]",
        (GetCurCpuTimestamp() - kfcSrvStartTime) / NSEC_PER_USEC);
    return ret;
}

__attribute__((visibility("default"))) bool AdumpStatsOpInitStatus() { return KfcDumpProcess::GetStatsOpInitStatus(); }
}
