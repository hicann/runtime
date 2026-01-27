/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "profiling_adp.h"
#include "aicpu_engine.h"
#include "ascend_hal.h"
#include "task_queue.h"
#include "dump_task.h"
#include "aicpusd_status.h"
#include "aicpu_async_event.h"
#include "aicpusd_mpi_mgr.h"
#include "aicpusd_task_queue.h"
#include "aicpusd_queue_event_process.h"
#include "tdt/status.h"
#include "tsd.h"
#include "common/type_def.h"
#include "aicpusd_common.h"
#include "tdt_server.h"
#include "gtest/gtest.h"
#include "ts_api.h"

#define private public
#include "aicpusd_mc2_maintenance_thread.h"
#include "aicpusd_cust_dump_process.h"
#include "aicpusd_message_queue.h"
#include "aicpusd_send_platform_Info_to_custom.h"
#undef private
using namespace AicpuSchedule;
using namespace aicpu;
namespace {
static struct event_info g_event = {
    .comm = {
        .event_id = EVENT_TEST,
        .subevent_id = 2,
        .pid = 3,
        .host_pid = 4,
        .grp_id = 5,
        .submit_timestamp = 6,
        .sched_timestamp = 7
    },
    .priv = {
        .msg_len = EVENT_MAX_MSG_LEN,
        .msg = {0}
    }
};
}
class HostCpuSchedulerStubUt : public ::testing::Test {
public:
    virtual void SetUp()
    {}

    virtual void TearDown()
    {}
};

TEST_F(HostCpuSchedulerStubUt, HostCpuSchedulerStubUtSuccess)
{
    aicpu::IsProfOpen();
    aicpu::IsModelProfOpen();
    aicpu::UpdateMode(true);
    aicpu::UpdateModelMode(true);
    aicpu::GetSystemTick();
    aicpu::GetSystemTickFreq();
    aicpu::SendToProfiling("test", "test");
    aicpu::SetProfHandle(nullptr);
    aicpu::NowMicros();
    aicpu::ReleaseProfiling();
    aicpu::InitProfiling(0, 0, 0);
    CreateOrFindCustPid(0, 0, nullptr, 0, 0, nullptr, 0, nullptr, nullptr);
    aicpu::ProfMessage profMessage("test");
    aicpu::ProfModelMessage prof_model_message("AICPU_MODEL");
    auto ret = prof_model_message.ReportProfModelMessage();
    EXPECT_EQ(ret, 0);
    MsprofReporterCallback msprofReporterCallback;
    aicpu::SetMsprofReporterCallback(msprofReporterCallback);
    aeCallInterface(nullptr);
    aeBatchLoadKernelSo(0, 0, nullptr);
    aeCloseSo(0, nullptr);
    drvHdcCapacity capacity;
    drvHdcGetCapacity(&capacity);
    TsdWaitType type;
    TsdDestroy(0, type, 0, 0);
    StartupResponse(0, type, 0, 0);
    WaitForShutDown(0);
    AicpuSchedule::OpDumpTaskManager::GetInstance().ClearResource();
    AicpuSchedule::OpDumpTaskManager::GetInstance().DumpOpInfo(0, 0, 0, 0);
    AicpuSchedule::OpDumpTaskManager::GetInstance().DumpOpInfoForUnknowShape(0, 0);
    AicpuSchedule::OpDumpTaskManager::GetInstance().LoadOpMappingInfo(nullptr, 0);
    event_info info;
    AicpuSchedule::AicpuQueueEventProcess::GetInstance().ProcessQsMsg(info);
    AicpuSchedule::AicpuQueueEventProcess::GetInstance().ProcessDrvMsg(info);
    AicpuSchedule::mpi::MpiDvppStatisticManager::Instance().PrintStatisticInfo();
    AicpuSchedule::mpi::MpiDvppStatisticManager::Instance().Record();
    AicpuSchedule::mpi::MpiDvppStatisticManager::Instance().InitMpiDvpp();
    AicpuSchedule::mpi::MpiDvppPulseListener::MpiDvppTimePoint point;
    AicpuSchedule::mpi::MpiDvppStatisticManager::Instance().OnPulse(point);
    aicpu::NotifyFunc func;
    aicpu::AsyncEventManager::GetInstance().Register(func);
    aicpu::AsyncEventManager::GetInstance().NotifyWait(nullptr, 0);
    aicpu::EventProcessCallBack eventProcessCallBack;
    aicpu::AsyncEventManager::GetInstance().RegEventCb(0, 0, eventProcessCallBack, 0);
    aicpu::AsyncEventManager::GetInstance().ProcessEvent(0, 0, nullptr);
    EXPECT_TRUE(aicpu::AsyncEventManager::GetInstance().RegOpEventCb(1,1,[](void *param){return;}));
    aicpu::AsyncEventManager::GetInstance().ProcessOpEvent(1,1,nullptr);
    aicpu::AsyncEventManager::GetInstance().UnregOpEventCb(1,1);

    DataPreprocess::TaskQueueMgr::GetInstance().OnPreprocessEvent(0);
    std::list<uint32_t> bindCoreList;
    tdt::TDTServerInit(0, bindCoreList);
    tdt::TDTServerStop();
    tdt::StatusFactory::GetInstance()->RegisterErrorNo(0, "test");
    tdt::StatusFactory::GetInstance()->GetErrDesc(0);
    tdt::StatusFactory::GetInstance()->GetErrCodeDesc(0);
    AicpuSchedule::TaskQueue taskQueue;
    aicpu::Closure closure;
    taskQueue.Enqueue(closure);
    taskQueue.Dequeue(closure);
    taskQueue.Clear();
    taskQueue.DebugString();
    AICPUSharderTaskInfo taskInfo = {};
    AicpuSchedule::TaskMap taskMap;
    std::queue<aicpu::Closure> taskQ;
    taskQ.push(closure);
    taskMap.BatchAddTask(taskInfo, taskQ);
    taskMap.PopTask(taskInfo, closure);
    taskMap.Clear();
    taskMap.DebugString();
    halTsDevRecord(0, 0, 0, 0);
    tsDevSendMsgAsync(0, 0, nullptr, 0, 0);
    ret = StopWaitForCustAicpu();
    EXPECT_EQ(ret, 0);
    AicpuSchedule::DeployContext deployContext;
    ret = AicpuSchedule::GetAicpuDeployContext(deployContext);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ret = AicpuSchedule::OpDumpTaskManager::GetInstance().DumpOpInfo(0, 0, 0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    TaskInfoExt dumpTaskInfo;
    ret = AicpuSchedule::OpDumpTaskManager::GetInstance().DumpOpInfo(dumpTaskInfo, 0, 0, 0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    DumpFileName dumpFileName(0, 0);
    ret = AicpuSchedule::OpDumpTaskManager::GetInstance().DumpOpInfo(const_cast<TaskInfoExt &>(dumpTaskInfo), dumpFileName);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    char *infoAddr = nullptr;
    ret = AicpuSchedule::OpDumpTaskManager::GetInstance().LoadOpMappingInfo(infoAddr, 3);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    event_info event;
    ret = AicpuSchedule::AicpuQueueEventProcess::GetInstance().ProcessProxyMsg(event);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}
TEST_F(HostCpuSchedulerStubUt, HostCpuSchedulerAicpuSdCustDumpProcessStubUtSuccess)
{
    uint32_t deviceId;
    aicpu::AicpuRunMode runMode;
    int32_t timeout;
    event_info drvEventInfo;
    TsdSubEventInfo msg;
    CreateDatadumpThread(&msg);
    char_t str[1];
    const uint32_t len = 1;
    struct event_proc_result rsp = {};
    AicpuSchedule::AicpuSdCustDumpProcess::GetInstance().DoUdfDatadumpSubmitEventSync(str, len, rsp);
    AicpuSchedule::AicpuSdCustDumpProcess::GetInstance().DoUdfDatadumpTask(drvEventInfo);
    AicpuSchedule::AicpuSdCustDumpProcess::GetInstance().DatadumpTaskProcess(drvEventInfo);
    AicpuSchedule::AicpuSdCustDumpProcess::GetInstance().InitCustDumpProcess(deviceId, runMode);
    AicpuSchedule::AicpuSdCustDumpProcess::GetInstance().SetDataDumpThreadAffinity();
    AicpuSchedule::AicpuSdCustDumpProcess::GetInstance().StartProcessEvent();
    AicpuSchedule::AicpuSdCustDumpProcess::GetInstance().LoopProcessEvent();
    AicpuSchedule::AicpuSdCustDumpProcess::GetInstance().IsValidUdf(0);
    AicpuSchedule::AicpuSdCustDumpProcess::GetInstance().IsValidCustAicpu(0);
    AicpuSchedule::AicpuSdCustDumpProcess::GetInstance().ProcessMessage(timeout);
    AicpuSchedule::AicpuSdCustDumpProcess::GetInstance().UnitCustDataDumpProcess();
    AicpuSchedule::AicpuSdLoadPlatformInfoProcess::GetInstance().SendLoadPlatformInfoMessageToCustSync(nullptr, 0);
    AicpuSchedule::AicpuSdLoadPlatformInfoProcess::GetInstance().LoadPlatformInfoSemPost();
    AicpuSchedule::AicpuSdLoadPlatformInfoProcess::GetInstance().SendMsgToMain(nullptr, 0);
    auto ret = AicpuSchedule::AicpuSdCustDumpProcess::GetInstance().DoCustDatadumpTask(drvEventInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(HostCpuSchedulerStubUt, HostCpuSchedulerAicpusdMc2MaintenceThreadStubUtSuccess)
{
    uint32_t deviceId;
    aicpu::AicpuRunMode runMode;
    int32_t timeout;
    event_info drvEventInfo;
    auto ret = AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).InitMc2MaintenanceProcess(nullptr, nullptr, nullptr, nullptr);
    AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).SetMc2MantenanceThreadAffinity();
    AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).StartProcessEvent();
    AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).ProcessEventFunc();
    AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).StopProcessEventFunc();
    AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).UnitMc2MantenanceProcess();
    AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).RegisterProcessEventFunc(nullptr, nullptr);
    AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).RegisterStopProcessEventFunc(nullptr, nullptr);
    AicpuSchedule::AicpuMc2MaintenanceThread::GetInstance(0).SendMc2CreateThreadMsgToMain();
    StartMC2MaintenanceThread(nullptr, nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}