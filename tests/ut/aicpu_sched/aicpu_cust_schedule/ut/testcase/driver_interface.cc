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
#include <list>
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
#include <iostream>

#include "ts_api.h"

#include "ascend_hal.h"
#include "status.h"
#include "tsd.h"
#include "tsd_client.h"
#include "ascend_hal.h"
#include "profiling_adp.h"
#include "aicpu_sharder.h"
#include "aicpu_context.h"
#include "aicpu_engine.h"

#define DEVDRV_DRV_INFO printf

// 被drvCreateAicpuWorkTasks中调用，用于在ONLINE模式下，开启一个Server线程，进行算子SO从Host到Device的搬运

extern "C" {
int32_t aeCallInterface(const void * const addr)
{
    return AE_STATUS_SUCCESS;
}

aeStatus_t aeBatchLoadKernelSo(const uint32_t kernelType, const uint32_t loadSoNum,
                               const char * const * const soNames)
{
    return AE_STATUS_SUCCESS;
}

void InitProfiling(uint32_t deviceId, pid_t hostPid, const uint32_t channelId)
{
    return;
}

void InitProfilingDataInfo(uint32_t deviceId)
{
    return;
}

void UpdateMode(bool mode)
{
    return;
}
void SetProfilingFlagForKFC(const uint32_t flag)
{
    return;
}
void LoadProfilingLib()
{
}
}

int halGrpAttach(const char *name, int timeout)
{
    return 0;
}

int halBuffInit(BuffCfg *cfg)
{
    return 0;
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

drvError_t halGetVdevNum(uint32_t *devNum)
{
    return DRV_ERROR_NONE;
}

drvError_t halDrvEventThreadUninit(unsigned int devId)
{
    return DRV_ERROR_NONE;
}

drvError_t halDrvEventThreadInit(unsigned int devId)
{
    return DRV_ERROR_NONE;
}

namespace aicpu{
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
status_t aicpuSetProfContext(const aicpuProfContext_t &ctx)
{
    return 0;
}
ProfMessage::ProfMessage(const char* tag) : tag_(tag)
{
}
ProfMessage::~ProfMessage()
{
}
void SendToProfiling(const std::string &sendData, const std::string &mark) {}
void ReleaseProfiling() {}
uint64_t GetSystemTick()
{
    static uint64_t tick = 1;
    tick++;
    return tick;
}

uint64_t GetSystemTickFreq() {return 1;}

}

int32_t TsdWaitForShutdown(const uint32_t deviceId, const TsdWaitType waitType,
                           const uint32_t hostPid, const uint32_t vfId)
{
    return 0;
}

int32_t CreateOrFindCustPid(const uint32_t deviceId, const uint32_t loadLibNum, char *loadLibName[],
                            const uint32_t hostPid, const uint32_t vfId)
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

int32_t StartUpRspAndWaitProcess(const uint32_t deviceId, const TsdWaitType waitType,
                                 const uint32_t hostPid, const uint32_t vfId)
{
    return 0;
}
int32_t SetDstTsdEventPid(const uint32_t dstPid)
{
    return 0;
}

namespace aicpu {
status_t aicpuSetContext(aicpuContext_t *ctx)
{
    return AICPU_ERROR_NONE;
}

status_t aicpuGetContext(aicpuContext_t *ctx)
{
    return AICPU_ERROR_NONE;
}

status_t SetAicpuRunMode(uint32_t runMode)
{
    return AICPU_ERROR_NONE;
}

status_t GetAicpuRunMode(uint32_t &runMode)
{
    runMode = 0;
    return AICPU_ERROR_NONE;
}

uint32_t GetUniqueVfId()
{
    return 0;
}

void SetUniqueVfId(uint32_t uniqueVfId)
{
}

void SetCustAicpuSdFlag(bool isCustAicpuSdFlag)
{
}

bool IsCustAicpuSd()
{
    return false;
}
}

namespace aicpu {
SharderNonBlock::SharderNonBlock() : cpuCoreNum_(0U),
                                     randomKernelScheduler_(nullptr),
                                     splitKernelScheduler_(nullptr),
                                     splitKernelGetProcesser_(nullptr),
                                     parallelId_(0U)
{

}

void SharderNonBlock::Register(const uint32_t cpuCoreNum, const RandomKernelScheduler &randomKernelScheduler,
                               const SplitKernelScheduler &splitKernelScheduler,
                               const SplitKernelGetProcesser &splitKernelGetProcesser)
{
    cpuCoreNum_ = cpuCoreNum;
    randomKernelScheduler_ = randomKernelScheduler;
    splitKernelScheduler_ = splitKernelScheduler;
    splitKernelGetProcesser_ = splitKernelGetProcesser;
}

SharderNonBlock &SharderNonBlock::GetInstance()
{
    static SharderNonBlock sharderNonBlock;
    return sharderNonBlock;
}
}

int32_t RegEventMsgCallBackFunc(const struct SubProcEventCallBackInfo *regInfo)
{
    return 0;
}

void UnRegEventMsgCallBackFunc(const uint32_t eventType)
{
    return;
}