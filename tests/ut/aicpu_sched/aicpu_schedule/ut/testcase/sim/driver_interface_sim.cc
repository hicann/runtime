/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <string.h>
#include <unistd.h>
#include <stdint.h>
#include <time.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <pthread.h>
#include <limits.h>
#include <dlfcn.h>
#include <sys/prctl.h>
#include <fcntl.h>
#include <unistd.h>
#include <pwd.h>
#include <stdio.h>
#include <sstream>

#include "ts_api.h"

#include "ascend_hal.h"
#include "tdt_server.h"
#include "status.h"
#include "ascend_hal.h"
#include "task_queue.h"
#include "profiling_adp.h"
#include "aicpu_sharder.h"
#include "aicpu_engine.h"
#include "aicpu_context.h"
#include <sstream>
#include <memory>

#define DEVDRV_DRV_INFO printf

extern "C" {
void InitProfiling(uint32_t deviceId, pid_t hostPid, const uint32_t channelId) { return; }

void InitProfilingDataInfo(uint32_t deviceId, pid_t hostPid, const uint32_t channelId) { return; }

void UpdateMode(bool mode) { return; }

int32_t SetMsprofReporterCallback(MsprofReporterCallback reportCallback) { return 0; }
void SetProfilingFlagForKFC(const uint32_t flag) { return; }
void LoadProfilingLib() {}
}

/*
 * driver_interface.cc 去除 aeCallInterface/aeBatchLoadKernelSo/aeCloseSo，
 * 这三个接口改由真实 aicpu_processer 提供。
 */

struct AICPUActiveStream {
    uint32_t streamId;
};

struct HiAicpuToTsMsg {
    unsigned short cmdType;
    union {
        AICPUActiveStream aicpuActiveStream;
    } u;
};

drvError_t drvGetDevIDByLocalDevID(uint32_t devIndex, uint32_t* hostDeviceId)
{
    *hostDeviceId = devIndex;
    return DRV_ERROR_NONE;
}

drvError_t drvGetLocalDevIDByHostDevID(uint32_t devIndex, uint32_t* hostDeviceId)
{
    *hostDeviceId = devIndex;
    return DRV_ERROR_NONE;
}

namespace DataPreprocess {
TaskQueueMgr& TaskQueueMgr::GetInstance()
{
    static TaskQueueMgr instance;
    return instance;
}
bool TaskQueueMgr::InitTaskQueueFd(int32_t& maxEventfd, fd_set& allEventfdSets) { return true; }
TaskQueueMgr::TaskQueueMgr() {}
TaskQueueMgr::~TaskQueueMgr() {}
void TaskQueueMgr::CloseTaskQueueFd() {}
// void TaskQueueMgr::OnPreprocessEvent(const fd_set& eventfdSets) {}
// void TaskQueueMgr::OnPreprocessEvent(uint32_t eventId) {}

void TaskQueueMgr::OnPreprocessEvent(uint32_t eventId) { return; }
} // namespace DataPreprocess

namespace aicpu {
void SendToProfiling(const std::string& sendData, const std::string& mark) {}
void ReleaseProfiling() {}

std::shared_ptr<ProfMessage> g_prof(nullptr);
std::atomic<bool> flag(true);
bool IsProfOpen() { return flag; }

int32_t SetProfHandle(std::shared_ptr<aicpu::ProfMessage> prof)
{
    prof = g_prof;
    return 0;
}

std::shared_ptr<aicpu::ProfMessage> GetProfHandle() { return g_prof; }

// 使用真实单调时钟（纳秒）作为 system tick，配合 GetSystemTickFreq() 返回 1e9。
// 说明：aicpu monitor 在 online 模式下按 taskTimeoutTick_ = taskTimeout(28s) * tickFreq 判定任务超时，
// 若返回快速自增的伪计数器且 freq=1，会使 nowTick-startTick 轻易超过 28，导致监控线程对在飞任务误判超时并调用
// SendKillMsgToTsd()->LastwordCallback()，与 worker 线程并发遍历/修改调度器内部状态而偶现段错误。
// 采用真实纳秒时钟后，28s 超时对应真实 28 秒，UT 中任务微秒级完成不会触发误判；且避免了非线程安全的静态自增计数器。
uint64_t GetSystemTick()
{
    struct timespec ts = {};
    (void)clock_gettime(CLOCK_MONOTONIC, &ts);
    return static_cast<uint64_t>(ts.tv_sec) * 1000000000ULL + static_cast<uint64_t>(ts.tv_nsec);
}

uint64_t NowMicros()
{
    struct timespec ts = {};
    (void)clock_gettime(CLOCK_MONOTONIC, &ts);
    return static_cast<uint64_t>(ts.tv_sec) * 1000000ULL + static_cast<uint64_t>(ts.tv_nsec) / 1000ULL;
}

uint64_t GetSystemTickFreq() { return 1000000000ULL; }

ProfMessage::ProfMessage(const char* tag) : tag_(tag) {}

ProfMessage::~ProfMessage() {}
} // namespace aicpu

namespace tdt {
int32_t TDTServerInit(const uint32_t deviceID, const std::list<uint32_t>& bindCoreList) { return 0; }

int32_t TDTServerStop() { return 0; }

StatusFactory* StatusFactory::GetInstance()
{
    static StatusFactory instance_;
    return &instance_;
}

StatusFactory::StatusFactory() {}

void StatusFactory::RegisterErrorNo(uint32_t err, const std::string& desc) {}
} // namespace tdt
