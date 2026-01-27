/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <dlfcn.h>
#include <iostream>
#include <memory>
#include <map>
#include <thread>
#include <sys/types.h>
#include <sys/file.h>
#include <sys/ioctl.h>
#include <sstream>
#include <dlfcn.h>
#include "aicpusd_feature_ctrl.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#include "aicpu_async_event.h"
#include "aicpusd_threads_process.h"
#include "aicpusd_resource_limit.h"
#include "task_queue.h"
#include "ascend_hal.h"
#include "aicpusd_worker.h"
#undef private
using namespace AicpuSchedule;

class AICPUScheduleStubLhisiTEST : public testing::Test {
protected:
    static void SetUpTestCase() {
        std::cout << "AICPUScheduleStubLhisiTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase() {
        std::cout << "AICPUScheduleStubLhisiTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "AICPUScheduleStubLhisiTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "AICPUScheduleStubLhisiTEST TearDown" << std::endl;
    }
};

namespace aicpu {
  extern void DoSetThreadLocalCtx(const std::string &key, const std::string &value);
}
namespace aicpu {
namespace {
struct AsyncEventInfo {
    uint32_t eventId;
    uint32_t subEventId;

    bool operator == (const AsyncEventInfo &info) const
    {
        return (eventId == info.eventId) && (subEventId == info.subEventId);
    }
    friend bool operator < (const AsyncEventInfo &info1, const AsyncEventInfo &info2);
};

inline bool operator < (const AsyncEventInfo &info1, const AsyncEventInfo &info2)
{
    return (info1.eventId < info2.eventId) ||
           ((info1.eventId == info2.eventId) && (info1.subEventId < info2.subEventId));
}

struct AsyncTaskInfo {
    uint64_t startTick;
    std::string opName;
    uint8_t waitType;
    uint32_t waitId;
    uint64_t taskId;
    uint32_t streamId;
    EventProcessCallBack taskCb;
};
}
}

TEST_F(AICPUScheduleStubLhisiTEST, AsyncEventManagerRegister)
{
  aicpu::NotifyFunc notifyFunc = [](void *param, const uint32_t paramLen){
    return;
  };
  aicpu::AsyncEventManager::GetInstance().Register(notifyFunc);
  EXPECT_EQ(aicpu::AsyncEventManager::GetInstance().notifyFunc_, nullptr);
}

TEST_F(AICPUScheduleStubLhisiTEST, AsyncEventManagerNotifyWait)
{
  aicpu::AsyncNotifyInfo notifyInfo = {};
  aicpu::AsyncEventManager::GetInstance().NotifyWait(reinterpret_cast<void *>(&notifyInfo), sizeof(aicpu::AsyncEventInfo));
  EXPECT_EQ(notifyInfo.retCode, 0);
}

TEST_F(AICPUScheduleStubLhisiTEST, AsyncEventManagerRegEventCb)
{
  auto ret = aicpu::AsyncEventManager::GetInstance().RegEventCb(1,1,[](void *param){
    return;
  });
  EXPECT_TRUE(ret);
}

TEST_F(AICPUScheduleStubLhisiTEST, AsyncEventManagerProcessEvent)
{
  aicpu::AsyncEventManager::GetInstance().ProcessEvent(1,1,nullptr);
  EXPECT_EQ(aicpu::AsyncEventManager::GetInstance().notifyFunc_, nullptr);
}

TEST_F(AICPUScheduleStubLhisiTEST, AsyncEventManagerRegOpEventCb)
{
  auto ret = aicpu::AsyncEventManager::GetInstance().RegOpEventCb(1,1,[](void *param){
    return;
  });
  EXPECT_TRUE(ret);
  aicpu::AsyncEventManager::GetInstance().ProcessOpEvent(1,1,nullptr);
  aicpu::AsyncEventManager::GetInstance().UnregOpEventCb(1,1);
}

TEST_F(AICPUScheduleStubLhisiTEST, ComputeProcessTest)
{
  std::vector<uint32_t> deviceVec;
  std::string pidSign;
  ProfilingMode profilingMode;
  aicpu::AicpuRunMode runMode;
  const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
  auto ret = AicpuSchedule::ComputeProcess::GetInstance().Start(deviceVec, 0, pidSign, profilingMode, 0, runMode, schedMode);
  const AICPUSharderTaskInfo taskInfo = {};
  const aicpu::Closure task = [](){};
  std::queue<aicpu::Closure> taskQueue;
  taskQueue.push(task);
  AicpuSchedule::ComputeProcess::GetInstance().DoSplitKernelTask(taskInfo);
  AicpuSchedule::ComputeProcess::GetInstance().DoRandomKernelTask();
  AicpuSchedule::ComputeProcess::GetInstance().SubmitRandomKernelTask(task);
  AicpuSchedule::ComputeProcess::GetInstance().SubmitSplitKernelTask(taskInfo, taskQueue);
  AicpuSchedule::ComputeProcess::GetInstance().SubmitBatchSplitKernelEventOneByOne(taskInfo);
  AicpuSchedule::ComputeProcess::GetInstance().SubmitBatchSplitKernelEventDc(taskInfo);
  AicpuSchedule::ComputeProcess::GetInstance().SubmitOneSplitKernelEvent(taskInfo);
  AicpuSchedule::ComputeProcess::GetInstance().GetAndDoSplitKernelTask();
  EXPECT_EQ(ret, 0);
}

TEST_F(AICPUScheduleStubLhisiTEST, SetAndGetProfContext)
{
  aicpu::aicpuProfContext_t ctx;
  aicpu::aicpuSetProfContext(ctx);
  aicpu::aicpuGetProfContext();
  const int32_t ret = aicpu::SetTaskAndStreamId(0, 0);
  EXPECT_EQ(ret, 0);
}

TEST_F(AICPUScheduleStubLhisiTEST, stubTest)
{
    Mbuf *mbuf = nullptr;
    uint64_t len = 0;
    halMbufGetDataLen(mbuf, &len);
    QueueSetCmdType cmd;
    QueueSetInputPara inPut;
    halQueueSet(0, cmd, &inPut);
    const int32_t ret = halMbufGetDataLen(mbuf, &len);
    EXPECT_EQ(ret, 0);
}

TEST_F(AICPUScheduleStubLhisiTEST, lhisiAddCgroup_01)
{
  MOCKER(access).stubs().will(returnValue(0));
  MOCKER(waitpid).stubs().will(returnValue(-1));
  const bool ret = AicpuSchedule::AddToCgroup(0,0);
  EXPECT_EQ(ret, true);
}

TEST_F(AICPUScheduleStubLhisiTEST, lhisiAddCgroup_02)
{
  MOCKER(access).stubs().will(returnValue(-1));
  MOCKER(waitpid).stubs().will(returnValue(-1));
  const bool ret = AicpuSchedule::AddToCgroup(0,0);
  EXPECT_EQ(ret, true);
}

TEST_F(AICPUScheduleStubLhisiTEST, ProfilingMode)
{
  std::vector<uint32_t> deviceVec;
  std::string pidSign;
  ProfilingMode profilingMode;
  aicpu::AicpuRunMode runMode;
  AicpuSchedule::ComputeProcess::GetInstance().UpdateProfilingMode(profilingMode);
  AicpuSchedule::ComputeProcess::GetInstance().UpdateProfilingModelMode(true);
  AicpuSchedule::ComputeProcess::GetInstance().Stop();
  const AicpuSchedMode schedMode = SCHED_MODE_INTERRUPT;
  auto ret = AicpuSchedule::ComputeProcess::GetInstance().Start(deviceVec, 0, pidSign, profilingMode, 0, runMode, schedMode);
  EXPECT_EQ(ret, 0);
}

TEST_F(AICPUScheduleStubLhisiTEST, CreateOrFindCustPid)
{
  auto ret = CreateOrFindCustPid(0, 0, nullptr, 0, 0, nullptr, 0, nullptr, nullptr);
  EXPECT_EQ(ret, 0);
}

TEST_F(AICPUScheduleStubLhisiTEST, halQueueSubscribe)
{
  uint32_t devid = 1;
  uint32_t qid = 2;
  uint32_t groupId = 1;
  int type = 1;
  auto ret = halQueueSubscribe(devid, qid, groupId, type);
  EXPECT_EQ(ret, DRV_ERROR_NONE);
}

TEST_F(AICPUScheduleStubLhisiTEST, halQueueUnsubscribe)
{
  uint32_t devid = 1;
  uint32_t qid = 2;
  auto ret = halQueueUnsubscribe(devid, qid);
  EXPECT_EQ(ret, DRV_ERROR_NONE);
}

extern int SetQueueWorkMode(unsigned int devid, unsigned int qid, int mode);
TEST_F(AICPUScheduleStubLhisiTEST, SetQueueWorkMode)
{
  uint32_t devid = 1;
  uint32_t qid = 2;
  int mode = 1;
  auto ret = SetQueueWorkMode(devid, qid, mode);
  EXPECT_EQ(ret, DRV_ERROR_NONE);
}

TEST_F(AICPUScheduleStubLhisiTEST, halQueueSubF2NFEvent)
{
  uint32_t devid = 1;
  uint32_t qid = 2;
  uint32_t groupId = 1;
  auto ret = halQueueSubF2NFEvent(devid, qid, groupId);
  EXPECT_EQ(ret, DRV_ERROR_NONE);
}

TEST_F(AICPUScheduleStubLhisiTEST, halQueueUnsubF2NFEvent)
{
  uint32_t devid = 1;
  uint32_t qid = 2;
  auto ret = halQueueUnsubF2NFEvent(devid, qid);
  EXPECT_EQ(ret, DRV_ERROR_NONE);
}

TEST_F(AICPUScheduleStubLhisiTEST, halQueueDeQueue)
{
  void *tmp = nullptr;
  void **mbuf = &tmp;
  uint32_t devid = 1;
  uint32_t qid = 2;
  auto ret = halQueueDeQueue(devid, qid, mbuf);
  EXPECT_EQ(ret, DRV_ERROR_NONE);
}

TEST_F(AICPUScheduleStubLhisiTEST, halQueueEnQueue)
{
  Mbuf *mbuf = nullptr;
  uint32_t devid = 1;
  uint32_t qid = 2;
  auto ret = halQueueEnQueue(devid, qid, mbuf);
  EXPECT_EQ(ret, DRV_ERROR_NONE);
}

TEST_F(AICPUScheduleStubLhisiTEST, halMbufGetBuffAddr)
{
  Mbuf *mbuf = nullptr;
  void *tmp = nullptr;
  void **buf = &tmp;
  auto ret = halMbufGetBuffAddr(mbuf, buf);
  EXPECT_EQ(ret, DRV_ERROR_NONE);
}

TEST_F(AICPUScheduleStubLhisiTEST, halMbufFree)
{
  Mbuf *mbuf = nullptr;
  auto ret = halMbufFree(mbuf);
  EXPECT_EQ(ret, DRV_ERROR_NONE);
}

TEST_F(AICPUScheduleStubLhisiTEST, halMbufGetPrivInfo)
{
  Mbuf *mbuf = nullptr;
  void *tmp = nullptr;
  void **priv = &tmp;
  uint32_t *size = nullptr;
  auto ret = halMbufGetPrivInfo(mbuf, priv, size);
  EXPECT_EQ(ret, DRV_ERROR_NONE);
}

extern int buff_get_phy_addr (void *buf, unsigned long long *phyAddr);
TEST_F(AICPUScheduleStubLhisiTEST, buff_get_phy_addr)
{
  void *buf = nullptr;
  unsigned long long *phyAddr = nullptr;
  auto ret = buff_get_phy_addr(buf, phyAddr);
  EXPECT_EQ(ret, DRV_ERROR_NONE);
}

TEST_F(AICPUScheduleStubLhisiTEST, drvHdcGetCapacity)
{
  struct drvHdcCapacity *capacity;
  auto ret = drvHdcGetCapacity(capacity);
  EXPECT_EQ(ret, DRV_ERROR_NONE);
}

TEST_F(AICPUScheduleStubLhisiTEST, OnPreprocessEvent)
{
  uint32_t eventId = 2;
  DataPreprocess::TaskQueueMgr::GetInstance().OnPreprocessEvent(eventId);
  const int32_t ret = aicpu::SetTaskAndStreamId(0, 0);
  EXPECT_EQ(ret, 0);
}

TEST_F(AICPUScheduleStubLhisiTEST, aicpuSetAndGetContext)
{
  aicpu::aicpuContext_t ctx;
  auto ret = aicpu::aicpuSetContext(&ctx);
  EXPECT_EQ(ret, 0);
  ret = aicpu::aicpuGetContext(&ctx);
  EXPECT_EQ(ret, DRV_ERROR_NONE);
}

TEST_F(AICPUScheduleStubLhisiTEST, SetAndGetThreadLocalCtx)
{
  std::string key = "";
  std::string value = "";
  auto ret = aicpu::SetThreadLocalCtx(key, value);
  EXPECT_EQ(ret, aicpu::AICPU_ERROR_FAILED);
  ret = aicpu::GetThreadLocalCtx(key, value);
  EXPECT_EQ(ret, aicpu::AICPU_ERROR_FAILED);
  key.append("abc");
  ret = aicpu::SetThreadLocalCtx(key, value);
  EXPECT_EQ(ret, DRV_ERROR_NONE);
  ret = aicpu::GetThreadLocalCtx(key, value);
  EXPECT_EQ(ret, DRV_ERROR_NONE);

  key.append("d");
  EXPECT_EQ(aicpu::GetThreadLocalCtx(key, value), aicpu::AICPU_ERROR_FAILED);
  // SetThreadLocalCtx throw exception
  MOCKER(aicpu::DoSetThreadLocalCtx).stubs().will(throws(std::bad_alloc()));
  aicpu::SetThreadLocalCtx(key, value);
  EXPECT_EQ(aicpu::SetThreadLocalCtx(key, value), aicpu::AICPU_ERROR_FAILED);
  EXPECT_EQ(aicpu::GetThreadLocalCtx(key, value), aicpu::AICPU_ERROR_FAILED);
}

TEST_F(AICPUScheduleStubLhisiTEST, SetOpname)
{
  std::string opName = "Select";
  auto ret = aicpu::SetOpname(opName);
  EXPECT_EQ(ret, DRV_ERROR_NONE);
}

TEST_F(AICPUScheduleStubLhisiTEST, SetAicpuRunMode)
{
  uint32_t runMode = 2;
  auto ret = aicpu::SetAicpuRunMode(runMode);
  EXPECT_EQ(ret, DRV_ERROR_NONE);
}

TEST_F(AICPUScheduleStubLhisiTEST, SetCustAicpuSdFlag)
{
  bool isCustAicpuSdFlag = false;
  aicpu::SetCustAicpuSdFlag(isCustAicpuSdFlag);
  auto ret = aicpu::IsCustAicpuSd();
  EXPECT_EQ(ret, false);
}

TEST_F(AICPUScheduleStubLhisiTEST, GetAicpuRunMode)
{
  uint32_t runMode = 1;
  auto ret = aicpu::GetAicpuRunMode(runMode);
  EXPECT_EQ(ret, DRV_ERROR_NONE);
}

TEST_F(AICPUScheduleStubLhisiTEST, SetAndGetUniqueVfId)
{
  uint32_t uniqueVfId = 0;
  aicpu::SetUniqueVfId(uniqueVfId);
  auto ret = aicpu::GetUniqueVfId();
  EXPECT_EQ(ret, 0);
}

TEST_F(AICPUScheduleStubLhisiTEST, drvBindHostPid)
{
  struct drvBindHostpidInfo info;
  auto ret = drvBindHostPid(info);
  EXPECT_EQ(ret, DRV_ERROR_NONE);
}

extern int halTsDevRecord(unsigned int devId, unsigned int tsId, unsigned int record_type, unsigned int record_Id);
TEST_F(AICPUScheduleStubLhisiTEST, halTsDevRecord)
{
  int ret = halTsDevRecord(0, 1, 2, 3);
  EXPECT_EQ(ret, 0);
}

TEST_F(AICPUScheduleStubLhisiTEST, threadPool)
{
  ThreadPool aicpuScheduleThreadPool;
  ThreadPool& threadPool = AicpuSchedule::ThreadPool::Instance();
  threadPool.WaitForStop();
  EXPECT_EQ(threadPool.semInitedNum_, 0);
}

extern int halGetDeviceVfMax(unsigned int devId, unsigned int *vf_max_num);
TEST_F(AICPUScheduleStubLhisiTEST, halGetDeviceVfMax)
{
  unsigned int vf_max_num = 2;
  int ret = halGetDeviceVfMax(1, &vf_max_num);
  EXPECT_EQ(ret, DRV_ERROR_NONE);
}

extern int halGetDeviceVfList(unsigned int devId, unsigned int *vf_list, unsigned int list_len, unsigned int *vf_num);
TEST_F(AICPUScheduleStubLhisiTEST, halGetDeviceVfList)
{
  unsigned int devId = 0;
  unsigned int vf_list = 2;
  unsigned int list_len = 3;
  unsigned int vf_num = 2;
  int ret = halGetDeviceVfList(devId, &vf_list, list_len, &vf_num);
  EXPECT_EQ(ret, DRV_ERROR_NONE);
}

extern int32_t SetSubProcScheduleMode(const uint32_t deviceId, const uint32_t waitType,
                                      const uint32_t hostPid, const uint32_t vfId,
                                      const struct SubProcScheduleModeInfo *scheInfo);
TEST_F(AICPUScheduleStubLhisiTEST, SetSubProcScheduleMode)
{
  int ret = SetSubProcScheduleMode(0U, 0U, 0U, 0U, nullptr);
  EXPECT_EQ(ret, 0);
}

TEST_F(AICPUScheduleStubLhisiTEST, SendUpdateProfilingRspToTsd)
{
  EXPECT_EQ(SendUpdateProfilingRspToTsd(0U, 0U, 0U, 0U), 0);
}