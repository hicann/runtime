/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <thread>
#include <map>
#include "aicpu_engine.h"
#include "ascend_hal.h"
#include "aicpusd_threads_process.h"
#include "aicpusd_info.h"
#include "aicpusd_worker.h"
#include "aicpusd_cust_so_manager.h"

using namespace AicpuSchedule;

namespace {
    // just for auto init instance of AicpuCustSoManager, variable is unused
    auto g_custSoMgrInitRet __attribute__((unused)) =
        AicpuSchedule::AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                                SCHED_MODE_INTERRUPT);
}

ComputeProcess::ComputeProcess() {}

void ComputeProcess::UpdateProfilingMode(ProfilingMode mode) const {}

void ComputeProcess::UpdateProfilingModelMode(const bool mode) const {}

ComputeProcess& ComputeProcess::GetInstance()
{
    static ComputeProcess instance;
    return instance;
}

int32_t ComputeProcess::Start(const std::vector<uint32_t> &deviceVec,
                              const pid_t hostPid,
                              const std::string &pidSign,
                              const uint32_t profilingMode,
                              const uint32_t vfId,
                              const aicpu::AicpuRunMode runMode,
                              const AicpuSchedMode schedMode)
{
    return 0;
}

void ComputeProcess::Stop()
{
    return;
}

bool ComputeProcess::DoSplitKernelTask(const AICPUSharderTaskInfo &taskInfo)
{
    (void)taskInfo;
    return true;
}

bool ComputeProcess::DoRandomKernelTask() {return true;}

uint32_t ComputeProcess::SubmitRandomKernelTask(const aicpu::Closure &task)
{
    (void)task;
    return 0U;
}
uint32_t ComputeProcess::SubmitSplitKernelTask(const AICPUSharderTaskInfo &taskInfo,
                                               const std::queue<aicpu::Closure> &taskQueue)
{
    (void)taskInfo;
    (void)taskQueue;
    return 0U;
}
uint32_t ComputeProcess::SubmitBatchSplitKernelEventOneByOne(const AICPUSharderTaskInfo &taskInfo) const
{
    (void)taskInfo;
    return 0U;
}
uint32_t ComputeProcess::SubmitBatchSplitKernelEventDc(const AICPUSharderTaskInfo &taskInfo)
{
    (void)taskInfo;
    return 0U;
}
uint32_t ComputeProcess::SubmitOneSplitKernelEvent(const AICPUSharderTaskInfo &taskInfo) const
{
    (void)taskInfo;
    return 0U;
}
bool ComputeProcess::GetAndDoSplitKernelTask() {return true;}

drvError_t halQueueSubscribe(unsigned int devid, unsigned int qid, unsigned int groupId, int type)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueUnsubscribe(unsigned int devid, unsigned int qid)
{
    return DRV_ERROR_NONE;
}

int SetQueueWorkMode(unsigned int devid, unsigned int qid, int mode)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueSubF2NFEvent(unsigned int devid, unsigned int qid, unsigned int groupid)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueSet(unsigned int devId, QueueSetCmdType cmd, QueueSetInputPara *input)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueUnsubF2NFEvent(unsigned int devid, unsigned int qid)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueDeQueue(unsigned int devId, unsigned int qid, void **mbug)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueEnQueue(unsigned int devId, unsigned int qid, void *mbuf)
{
    return DRV_ERROR_NONE;
}

int halMbufGetBuffAddr(Mbuf *mbuf, void **buf)
{
    return DRV_ERROR_NONE;
}

int halMbufSetDataLen (Mbuf *mbuf, uint64_t len)
{
    return DRV_ERROR_NONE;
}

int halMbufGetDataLen(Mbuf *mbuf, uint64_t *len)
{
    return DRV_ERROR_NONE;
}

int halMbufAllocEx(uint64_t size, unsigned int align, unsigned long flag, int grp_id, Mbuf **mbuf)
{
    return DRV_ERROR_NONE;
}

int halMbufFree(Mbuf *mbuf)
{
    return DRV_ERROR_NONE;
}

int halMbufGetPrivInfo (Mbuf *mbuf,  void **priv, unsigned int *size)
{
    return DRV_ERROR_NONE;
}

drvError_t halQueueInit(unsigned int devid)
{
    return DRV_ERROR_NONE;
}

int buff_get_phy_addr (void *buf, unsigned long long *phyAddr)
{
    return 0;
}

drvError_t drvHdcGetCapacity(struct drvHdcCapacity *capacity)
{
    return DRV_ERROR_NONE;
}

int halMbufChainGetMbuf(Mbuf *mbufChainHead, unsigned int index, Mbuf **mbuf)
{
    return DRV_ERROR_NONE;
}

int halMbufChainGetMbufNum(Mbuf *mbufChainHead, unsigned int *num)
{
    return DRV_ERROR_NONE;
}

int halMbufChainAppend(Mbuf *mbufChainHead, Mbuf *mbuf)
{
    return DRV_ERROR_NONE;
}


int halTsDevRecord(unsigned int devId, unsigned int tsId, unsigned int record_type, unsigned int record_Id)
{
    return 0;
}

drvError_t drvBindHostPid(struct drvBindHostpidInfo info)
{
    return DRV_ERROR_NONE;
}

namespace AicpuSchedule {
ThreadPool &ThreadPool::Instance()
{
    static ThreadPool threadPool;
    return threadPool;
}

void ThreadPool::WaitForStop()
{
    return;
}

ThreadPool::ThreadPool() : semInitedNum_(0) {}

ThreadPool::~ThreadPool() {}
}

int halGetDeviceVfMax(unsigned int devId, unsigned int *vf_max_num)
{
    (void)devId;
    (void)vf_max_num;
    return DRV_ERROR_NONE;
}

int halGetDeviceVfList(unsigned int devId, unsigned int *vf_list, unsigned int list_len, unsigned int *vf_num)
{
    (void)devId;
    (void)vf_list;
    (void)list_len;
    (void)vf_num;
    return DRV_ERROR_NONE;
}