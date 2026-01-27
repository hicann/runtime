/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
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
#include "tsd.h"
#include "ascend_hal.h"
#include "task_queue.h"
#include "profiling_adp.h"
#include "aicpu_sharder.h"
#include "aicpu_engine.h"
#include "aicpu_context.h"
#include <sstream>
#include <memory>

#define DEVDRV_DRV_INFO printf

// 被drvCreateAicpuWorkTasks中调用，用于在ONLINE模式下，开启一个Server线程，进行算子SO从Host到Device的搬运

// driver获取CPU信息接口

extern "C" {
void InitProfiling(uint32_t deviceId, pid_t hostPid, const uint32_t channelId)
{
    return;
}

void InitProfilingDataInfo(uint32_t deviceId, pid_t hostPid, const uint32_t channelId)
{
    return;
}

void UpdateMode(bool mode)
{
    return;
}

int32_t SetMsprofReporterCallback(MsprofReporterCallback reportCallback)
{
    return 0;
}
void SetProfilingFlagForKFC(const uint32_t flag)
{
    return;
}
void LoadProfilingLib()
{
}
}


int32_t aeCallInterface(const void * const addr)
{
    return AE_STATUS_SUCCESS;
}

aeStatus_t aeBatchLoadKernelSo(const uint32_t kernelType, const uint32_t loadSoNum,
                               const char * const * const soNames)
{
    return AE_STATUS_SUCCESS;
}

aeStatus_t aeCloseSo(const uint32_t kernelType, const char * const soName)
{
    return AE_STATUS_SUCCESS;
}

struct AICPUActiveStream {
    uint32_t streamId;
};

struct HiAicpuToTsMsg {
    unsigned short cmdType;
    union{
        AICPUActiveStream aicpuActiveStream;
    }u;
};

drvError_t drvGetDevIDByLocalDevID(uint32_t devIndex, uint32_t *hostDeviceId)
{
    *hostDeviceId = devIndex;
    return DRV_ERROR_NONE;
}

drvError_t drvGetLocalDevIDByHostDevID(uint32_t devIndex, uint32_t *hostDeviceId)
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
bool TaskQueueMgr::InitTaskQueueFd(int32_t& maxEventfd, fd_set& allEventfdSets)
{
    return true;
}
TaskQueueMgr::TaskQueueMgr()
{
}
TaskQueueMgr::~TaskQueueMgr()
{
}
void TaskQueueMgr::CloseTaskQueueFd() {}
// void TaskQueueMgr::OnPreprocessEvent(const fd_set& eventfdSets) {}
// void TaskQueueMgr::OnPreprocessEvent(uint32_t eventId) {}

void TaskQueueMgr::OnPreprocessEvent(uint32_t eventId)
{
    return;
}
}

namespace aicpu{
void SendToProfiling(const std::string &sendData, const std::string &mark) {}
void ReleaseProfiling() {}

std::shared_ptr<ProfMessage> g_prof(nullptr);
std::atomic<bool> flag(true);
bool IsProfOpen()
{
    return flag;
}

int32_t SetProfHandle(std::shared_ptr<aicpu::ProfMessage> prof)
{
    prof = g_prof;
    return 0;
}

std::shared_ptr<aicpu::ProfMessage> GetProfHandle()
{
    return g_prof;
}

uint64_t GetSystemTick()
{
    static uint64_t tick = 1;
    tick++;
    return tick;
}

static uint64_t g_time=0;
uint64_t NowMicros()
{
    g_time++;
    return g_time;
}

uint64_t GetSystemTickFreq() {return 1;}

ProfMessage::ProfMessage(const char* tag) : tag_(tag)
{
}

ProfMessage::~ProfMessage()
{
}
}

namespace tdt{
int32_t TDTServerInit(const uint32_t deviceID, const std::list<uint32_t>& bindCoreList)
{
    return 0;
}

int32_t TDTServerStop()
{
    return 0;
}

StatusFactory* StatusFactory::GetInstance()
{
    static StatusFactory instance_;
    return &instance_;
}

StatusFactory::StatusFactory()
{
}

void StatusFactory::RegisterErrorNo(uint32_t err, const std::string& desc)
{
}
}

int32_t TsdWaitForShutdown(const uint32_t deviceId, const TsdWaitType waitType,
                           const uint32_t hostPid, const uint32_t vfId)
{
    return 0;
}

int32_t CreateOrFindCustPid(const uint32_t deviceId, const uint32_t loadLibNum, const char * const loadLibName[],
                            const uint32_t hostPid, const uint32_t vfId, const char *groupNameList,
                            const uint32_t groupNameNum, int32_t *custProcPid, bool *firstStart)
{
    return 0;
}

int32_t SendUpdateProfilingRspToTsd(const uint32_t deviceId, const uint32_t waitType,
                                    const uint32_t hostPid, const uint32_t vfId)
{
    return 0;
}

int32_t StartupResponse(const uint32_t deviceId, const TsdWaitType waitType,
                           const uint32_t hostPid, const uint32_t vfId)
{
    return 0;
}

int32_t WaitForShutDown(const uint32_t deviceId)
{
    return 0;
}

int32_t SubModuleProcessResponse(const uint32_t deviceId, const TsdWaitType waitType,
                                 const uint32_t hostPid, const uint32_t vfId,
                                 const uint32_t eventType)
{
    return 0;
}

int32_t TsdReportStartOrStopErrCode(const uint32_t deviceId, const TsdWaitType waitType,
                                    const uint32_t hostPid, const uint32_t vfId,
                                    const char *errCode, const uint32_t errLen)
{
    return 0;
}

int32_t ReportMsgToTsd(const uint32_t deviceId, const TsdWaitType waitType,
                       const uint32_t hostPid, const uint32_t vfId,
                       const char * const msgInfo)
{
    return 0;
}

int32_t RegEventMsgCallBackFunc(const struct SubProcEventCallBackInfo *regInfo)
{
    return 0;
}

void UnRegEventMsgCallBackFunc(const uint32_t eventType)
{
    return;
}

int32_t StopWaitForCustAicpu()
{
    return 0;
}

int32_t SetSubProcScheduleMode(const uint32_t deviceId, const uint32_t waitType,
                               const uint32_t hostPid, const uint32_t vfId,
                               const struct SubProcScheduleModeInfo *scheInfo)
{
    return 0;
}
