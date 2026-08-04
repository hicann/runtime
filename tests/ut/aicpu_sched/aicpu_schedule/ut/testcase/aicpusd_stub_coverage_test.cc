/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <list>
#include <memory>
#include <string>
#include <vector>
#include "aicpu_async_event.h"
#include "adump_device_pub.h"
#include "aicpu_context.h"
#include "aicpu_pulse.h"
#include "aicpusd_hccl_api.h"
#include "aicpusd_interface.h"
#include "aicpusd_profiler.h"
#include "gtest/gtest.h"
#include "hiperf_marker.h"
#include "profiling_adp.h"
#include "stub/aicpusd_meminfo_process.h"
#include "task_queue.h"
#include "tdt/status.h"
#include "tdt/tdt_device.h"
#include "tdt/train_mode.h"
#include "tdt_server.h"
#include "tsd.h"

using namespace AicpuSchedule;

extern "C" {
void AicpusdFakeHcclSetWaitAgain(bool returnAgain);
void AicpusdSetHiperfAccessResult(int result);
void InitProfilingDataInfo(const uint32_t deviceId, const pid_t hostPid, const uint32_t channelId);
void SetProfilingFlagForKFC(const uint32_t flag);
void LoadProfilingLib();
}

namespace {
constexpr uint32_t kDeviceId = 0U;
constexpr uint32_t kHostPid = 1U;
constexpr TsdWaitType kWaitType = TSD_HCCP;
} // namespace

TEST(AicpusdStubCoverageTest, ScheduleStubFilesAreLinkedAndCallable)
{
    BuffCfg buffCfg = {};
    EXPECT_EQ(AicpuMemInfoProcess::GetMemZoneInfo(buffCfg), AICPU_SCHEDULE_OK);

    EXPECT_EQ(AicpuLoadModelWithQ(nullptr), 0);
    EXPECT_EQ(AicpuLoadModel(nullptr), 0);
    EXPECT_EQ(AICPUModelLoad(nullptr), 0);
    EXPECT_EQ(AICPUModelDestroy(0U), 0);
    EXPECT_EQ(AICPUModelExecute(0U), 0);
    EXPECT_EQ(AICPUExecuteTask(nullptr, nullptr), 0);
    EXPECT_EQ(AICPUPreOpenKernels(nullptr), 0);
    EXPECT_EQ(InitAICPUScheduler(kDeviceId, kHostPid, PROFILING_CLOSE), 0);
    EXPECT_EQ(InitCpuScheduler(nullptr), 0);
    EXPECT_EQ(UpdateProfilingMode(kDeviceId, kHostPid, 0U), 0);
    EXPECT_EQ(StopAICPUScheduler(kDeviceId, kHostPid), 0);
    EXPECT_FALSE(AicpuIsStoped());
    EXPECT_EQ(LoadOpMappingInfo(nullptr, 0U), 0);
    EXPECT_EQ(AicpuSetMsprofReporterCallback(nullptr), 0);
    aicpu::AsyncNotifyInfo notifyInfo = {};
    AicpuReportNotifyInfo(notifyInfo);
    EXPECT_EQ(AicpuGetTaskDefaultTimeout(), 0U);
    std::function<void()> cancelReg;
    RegLastwordCallback(
        "stub", []() {}, cancelReg);

    DataPreprocess::TaskQueueMgr::GetInstance().OnPreprocessEvent(0U);
    EXPECT_EQ(halGetVdevNum(nullptr), DRV_ERROR_NONE);

    std::list<uint32_t> bindCoreList = {0U};
    EXPECT_EQ(tdt::TDTServerInit(kDeviceId, bindCoreList), 0);
    EXPECT_EQ(tdt::TDTServerStop(), 0);
    tdt::StatusFactory::GetInstance()->RegisterErrorNo(0U, "stub");
    EXPECT_TRUE(tdt::StatusFactory::GetInstance()->GetErrDesc(0U).empty());
    EXPECT_TRUE(tdt::StatusFactory::GetInstance()->GetErrCodeDesc(0U).empty());
    std::vector<tdt::DataItem> items;
    EXPECT_NE(tdt::TdtDevicePushData("channel", items), 0);
    SetTrainMode(DPFLAG);
}

TEST(AicpusdStubCoverageTest, CommonStubsAreLinkedAndCallable)
{
    EXPECT_EQ(IdeDumpStart(nullptr), 0);
    EXPECT_EQ(IdeDumpData(0, nullptr), IDE_DAEMON_NONE_ERROR);
    EXPECT_EQ(IdeDumpEnd(0), IDE_DAEMON_NONE_ERROR);

    EXPECT_EQ(SendUpdateProfilingRspToTsd(kDeviceId, 0U, kHostPid, 0U), 0);
    EXPECT_EQ(CreateOrFindCustPid(kDeviceId, 0U, nullptr, kHostPid, 0U, nullptr, 0U, nullptr, nullptr), 0);
    EXPECT_EQ(SetSubProcScheduleMode(kDeviceId, 0U, kHostPid, 0U, nullptr), 0);
    EXPECT_EQ(ReportMsgToTsd(kDeviceId, kWaitType, kHostPid, 0U, nullptr), 0);
    EXPECT_EQ(RegEventMsgCallBackFunc(nullptr), 0);
    UnRegEventMsgCallBackFunc(0U);
    EXPECT_EQ(TsdReportStartOrStopErrCode(kDeviceId, kWaitType, kHostPid, 0U, nullptr, 0U), 0);
    EXPECT_EQ(StartupResponse(kDeviceId, kWaitType, kHostPid, 0U), 0);
    EXPECT_EQ(WaitForShutDown(kDeviceId), 0);
    EXPECT_EQ(TsdDestroy(kDeviceId, kWaitType, kHostPid, 0U), 0);
    EXPECT_EQ(StopWaitForCustAicpu(), 0);
    EXPECT_EQ(SubModuleProcessResponse(kDeviceId, kWaitType, kHostPid, 0U, 0U), 0);
    EXPECT_EQ(StartUpRspAndWaitProcess(kDeviceId, kWaitType, kHostPid, 0U), 0);
    EXPECT_EQ(SetDstTsdEventPid(0U), 0);
    EXPECT_EQ(TsdWaitForShutdown(kDeviceId, kWaitType, kHostPid, 0U), 0);
}

TEST(AicpusdStubCoverageTest, ShardStubsAreLinkedAndCallable)
{
    aicpu::aicpuContext_t ctx = {};
    EXPECT_EQ(aicpu::aicpuSetContext(&ctx), aicpu::AICPU_ERROR_NONE);
    EXPECT_EQ(aicpu::aicpuGetContext(&ctx), aicpu::AICPU_ERROR_NONE);
    EXPECT_EQ(ctx.deviceId, 0U);

    aicpu::aicpuProfContext_t profCtx = {};
    EXPECT_EQ(aicpu::aicpuSetProfContext(profCtx), aicpu::AICPU_ERROR_NONE);
    EXPECT_EQ(aicpu::aicpuGetProfContext().kernelType, 0U);

    std::string value;
    EXPECT_EQ(aicpu::SetThreadLocalCtx("", "value"), aicpu::AICPU_ERROR_FAILED);
    EXPECT_EQ(aicpu::SetThreadLocalCtx("key", "value"), aicpu::AICPU_ERROR_NONE);
    EXPECT_EQ(aicpu::GetThreadLocalCtx("key", value), aicpu::AICPU_ERROR_NONE);
    EXPECT_EQ(value, "value");
    EXPECT_EQ(aicpu::GetThreadLocalCtx("", value), aicpu::AICPU_ERROR_FAILED);
    EXPECT_EQ(aicpu::GetThreadLocalCtx("missing", value), aicpu::AICPU_ERROR_FAILED);

    EXPECT_EQ(aicpu::SetOpname("op"), aicpu::AICPU_ERROR_NONE);
    EXPECT_EQ(aicpu::SetTaskAndStreamId(1UL, 2U), aicpu::AICPU_ERROR_NONE);
    EXPECT_EQ(aicpu::SetAicpuRunMode(aicpu::THREAD_MODE), aicpu::AICPU_ERROR_NONE);
    aicpu::SetCustAicpuSdFlag(true);
    EXPECT_FALSE(aicpu::IsCustAicpuSd());

    uint32_t runMode = aicpu::INVALID_MODE;
    EXPECT_EQ(aicpu::GetAicpuRunMode(runMode), aicpu::AICPU_ERROR_NONE);
    EXPECT_EQ(runMode, aicpu::THREAD_MODE);

    auto& manager = aicpu::AsyncEventManager::GetInstance();
    manager.Register(nullptr);
    manager.NotifyWait(nullptr, 0U);
    EXPECT_TRUE(manager.RegEventCb(1U, 2U, nullptr));
    manager.ProcessEvent(1U, 2U, nullptr);
    EXPECT_TRUE(manager.RegOpEventCb(1U, 2U, nullptr));
    manager.UnregOpEventCb(1U, 2U);
    manager.ProcessOpEvent(1U, 2U, nullptr);

    aicpu::SetUniqueVfId(3U);
    EXPECT_EQ(aicpu::GetUniqueVfId(), 0U);
    EXPECT_EQ(RegisterPulseNotifyFunc("pulse", nullptr), 0);
}

TEST(AicpusdStubCoverageTest, MdcAndAndroidProfilerStubsAreLinkedAndCallable)
{
    EXPECT_FALSE(aicpu::IsModelProfOpen());
    EXPECT_FALSE(aicpu::IsProfOpen());
    aicpu::UpdateModelMode(true);
    aicpu::UpdateMode(true);
    EXPECT_EQ(aicpu::GetSystemTick(), 0UL);
    aicpu::SendToProfiling("data", "mark");
    EXPECT_EQ(aicpu::GetSystemTickFreq(), 1UL);
    EXPECT_EQ(aicpu::SetProfHandle(nullptr), 0);
    EXPECT_EQ(aicpu::NowMicros(), 1UL);
    aicpu::ReleaseProfiling();
    InitProfilingDataInfo(kDeviceId, static_cast<pid_t>(kHostPid), 0U);
    aicpu::InitProfiling(kDeviceId, static_cast<pid_t>(kHostPid), 0U);
    SetProfilingFlagForKFC(0U);
    LoadProfilingLib();
    EXPECT_FALSE(aicpu::IsSupportedProfData());
    EXPECT_EQ(
        aicpu::SetMsprofReporterCallback(nullptr), static_cast<int32_t>(aicpu::ProfStatusCode::PROFILINE_SUCCESS));

    aicpu::ProfMessage msg("tag");
}

TEST(AicpusdStubCoverageTest, HcclFallbackPathsReturnReservedWhenSoMissing)
{
    HcclSoManager::GetInstance()->UnloadSo();
    EXPECT_EQ(HcclSoManager::GetInstance()->GetFunc("missing"), nullptr);

    HcclComm comm = nullptr;
    HcclRequest request = nullptr;
    ServiceHandle handle = nullptr;
    ReqStatus reqStatus = {};
    UpdateReqStatus updateReqStatus = {};
    LookupReqStatus lookupReqStatus = {};
    HcclStatus hcclStatus = {};
    HcomStatus hcomStatus = {};
    HcomRequest hcomRequest = nullptr;
    uint32_t rankIds[] = {0U};

    EXPECT_EQ(StubHcclInitCsComm(nullptr, 0, nullptr, nullptr, &comm), HCCL_E_RESERVED);
    EXPECT_EQ(StubHcclFinalizeComm(comm), HCCL_E_RESERVED);
    EXPECT_EQ(StubHcclGetLookupRequest(nullptr, 0, HCCL_DATA_TYPE_INT8, 0, &handle, comm, &reqStatus), HCCL_E_RESERVED);
    EXPECT_EQ(StubHcclIsetLookupResponse(nullptr, 0, HCCL_DATA_TYPE_INT8, handle, comm, &request), HCCL_E_RESERVED);
    EXPECT_EQ(StubHcclWaitSome(0, &request, nullptr, nullptr, &hcclStatus), HCCL_E_RESERVED);
    EXPECT_EQ(StubHcclAbortSelf(comm, 0), HCCL_E_RESERVED);
    EXPECT_EQ(StubHddsServiceCancel(handle), HCCL_E_RESERVED);
    EXPECT_EQ(SingleHcclWait(request), RET_FAILED);
    EXPECT_EQ(
        StubHddsCollRecvUpdateRequest(
            nullptr, 0, HCCL_DATA_TYPE_INT8, nullptr, 0, HCCL_DATA_TYPE_INT8, 0, &handle, comm, &updateReqStatus),
        HCCL_E_RESERVED);
    EXPECT_EQ(StubHddsIsendUpdateResponse(handle, comm, &request), HCCL_E_RESERVED);
    EXPECT_EQ(
        StubHddsCollRecvLookupRequest(nullptr, 0, HCCL_DATA_TYPE_INT8, 0, &handle, comm, &lookupReqStatus),
        HCCL_E_RESERVED);
    EXPECT_EQ(StubHddsIsendLookupResponse(nullptr, 0, HCCL_DATA_TYPE_INT8, handle, comm, &request), HCCL_E_RESERVED);
    EXPECT_EQ(StubHcomPrepareStart(nullptr, &hcomRequest), HCCL_E_RESERVED);
    EXPECT_EQ(StubHcomPrepareQuery(hcomRequest, &hcomStatus), HCCL_E_RESERVED);
    EXPECT_EQ(StubHcomSendByOS(nullptr, 0, HCCL_DATA_TYPE_INT8, 0, 0, nullptr, 0), HCCL_E_RESERVED);
    EXPECT_EQ(StubHcomReceiveByOS(nullptr, 0, HCCL_DATA_TYPE_INT8, 0, 0, nullptr, 0), HCCL_E_RESERVED);
    EXPECT_EQ(StubHcomInitByRankTable(nullptr, 0), HCCL_E_RESERVED);
    EXPECT_EQ(StubHcomDestroy(), HCCL_E_RESERVED);
    EXPECT_EQ(StubHcomCreateGroup(nullptr, 1U, rankIds), HCCL_E_RESERVED);
    EXPECT_EQ(StubHcomDestroyGroup(nullptr), HCCL_E_RESERVED);
    EXPECT_EQ(StubHcomBroadcastByOS(nullptr, 0, HCCL_DATA_TYPE_INT8, 0, nullptr, 0), HCCL_E_RESERVED);
    EXPECT_EQ(
        StubHcomGatherByOS(nullptr, 0, HCCL_DATA_TYPE_INT8, nullptr, 0, HCCL_DATA_TYPE_INT8, 0, nullptr, 0),
        HCCL_E_RESERVED);
    EXPECT_EQ(StubHcclDestroyResouce(comm, 0), HCCL_E_RESERVED);
    EXPECT_EQ(StubHcclRegisterGlobalMemory(nullptr, 0), HCCL_E_RESERVED);
    EXPECT_EQ(StubHcclUnregisterGlobalMemory(nullptr), HCCL_E_RESERVED);
    EXPECT_EQ(StubHcclPsAssociateWorkers(comm, 0, rankIds, 1U), HCCL_E_RESERVED);
    EXPECT_EQ(StubHcclCpuCommInit(nullptr, 0, nullptr), HCCL_E_RESERVED);

    MBufferPool pool;
    EXPECT_EQ(pool.Allocate(nullptr), RET_FAILED);
    EXPECT_EQ(pool.FreeAll(), RET_SUCCESS);
    pool.UnInit();
    HcclSoManager::GetInstance()->UnloadSo();
}

TEST(AicpusdStubCoverageTest, HcclFakeSoSuccessPathsAreCallable)
{
    HcclSoManager::GetInstance()->UnloadSo();
    HcclSoManager::GetInstance()->LoadSo();

    HcclComm comm = nullptr;
    HcclRequest request = nullptr;
    ServiceHandle handle = nullptr;
    ReqStatus reqStatus = {};
    UpdateReqStatus updateReqStatus = {};
    LookupReqStatus lookupReqStatus = {};
    HcclStatus hcclStatus = {};
    HcomStatus hcomStatus = {};
    HcomRequest hcomRequest = nullptr;
    int32_t compCount = 0;
    int32_t compIndices[] = {-1};
    uint32_t rankIds[] = {0U};

    EXPECT_EQ(StubHcclInitCsComm(nullptr, 0, nullptr, nullptr, &comm), HCCL_SUCCESS);
    EXPECT_EQ(StubHcclFinalizeComm(comm), HCCL_SUCCESS);
    EXPECT_EQ(StubHcclGetLookupRequest(nullptr, 0, HCCL_DATA_TYPE_INT8, 0, &handle, comm, &reqStatus), HCCL_SUCCESS);
    EXPECT_EQ(StubHcclIsetLookupResponse(nullptr, 0, HCCL_DATA_TYPE_INT8, handle, comm, &request), HCCL_SUCCESS);
    EXPECT_EQ(StubHcclWaitSome(1, &request, &compCount, compIndices, &hcclStatus), HCCL_SUCCESS);
    EXPECT_EQ(StubHcclAbortSelf(comm, 0), HCCL_SUCCESS);
    EXPECT_EQ(StubHddsServiceCancel(handle), HCCL_SUCCESS);
    EXPECT_EQ(SingleHcclWait(request), RET_SUCCESS);
    AicpusdFakeHcclSetWaitAgain(true);
    EXPECT_EQ(SingleHcclWait(request), RET_SUCCESS);
    AicpusdFakeHcclSetWaitAgain(false);

    EXPECT_EQ(
        StubHddsCollRecvUpdateRequest(
            nullptr, 0, HCCL_DATA_TYPE_INT8, nullptr, 0, HCCL_DATA_TYPE_INT8, 0, &handle, comm, &updateReqStatus),
        HCCL_SUCCESS);
    EXPECT_EQ(StubHddsIsendUpdateResponse(handle, comm, &request), HCCL_SUCCESS);
    EXPECT_EQ(
        StubHddsCollRecvLookupRequest(nullptr, 0, HCCL_DATA_TYPE_INT8, 0, &handle, comm, &lookupReqStatus),
        HCCL_SUCCESS);
    EXPECT_EQ(StubHddsIsendLookupResponse(nullptr, 0, HCCL_DATA_TYPE_INT8, handle, comm, &request), HCCL_SUCCESS);
    EXPECT_EQ(StubHcomPrepareStart(nullptr, &hcomRequest), HCCL_SUCCESS);
    EXPECT_EQ(StubHcomPrepareQuery(hcomRequest, &hcomStatus), HCCL_SUCCESS);
    EXPECT_EQ(StubHcomSendByOS(nullptr, 0, HCCL_DATA_TYPE_INT8, 0, 0, nullptr, 0), HCCL_SUCCESS);
    EXPECT_EQ(StubHcomReceiveByOS(nullptr, 0, HCCL_DATA_TYPE_INT8, 0, 0, nullptr, 0), HCCL_SUCCESS);
    EXPECT_EQ(StubHcomInitByRankTable(nullptr, 0), HCCL_SUCCESS);
    EXPECT_EQ(StubHcomDestroy(), HCCL_SUCCESS);
    EXPECT_EQ(StubHcomCreateGroup(nullptr, 1U, rankIds), HCCL_SUCCESS);
    EXPECT_EQ(StubHcomDestroyGroup(nullptr), HCCL_SUCCESS);
    EXPECT_EQ(StubHcomBroadcastByOS(nullptr, 0, HCCL_DATA_TYPE_INT8, 0, nullptr, 0), HCCL_SUCCESS);
    EXPECT_EQ(
        StubHcomGatherByOS(nullptr, 0, HCCL_DATA_TYPE_INT8, nullptr, 0, HCCL_DATA_TYPE_INT8, 0, nullptr, 0),
        HCCL_SUCCESS);
    EXPECT_EQ(StubHcclDestroyResouce(comm, 0), HCCL_SUCCESS);
    EXPECT_EQ(StubHcclRegisterGlobalMemory(nullptr, 0), HCCL_SUCCESS);
    EXPECT_EQ(StubHcclUnregisterGlobalMemory(nullptr), HCCL_SUCCESS);
    EXPECT_EQ(StubHcclPsAssociateWorkers(comm, 0, rankIds, 1U), HCCL_SUCCESS);
    EXPECT_EQ(StubHcclCpuCommInit(nullptr, 0, nullptr), HCCL_SUCCESS);

    MBufferPool pool;
    EXPECT_EQ(pool.Init(1U, 64U, false), RET_SUCCESS);
    EXPECT_EQ(pool.Init(1U, 64U, true), RET_SUCCESS);
    HcclSoManager::GetInstance()->UnloadSo();
}

TEST(AicpusdStubCoverageTest, CoreProfilerPathsAreCallable)
{
    AicpusdSetHiperfAccessResult(-1);
    AicpuProfiler profiler;
    profiler.InitProfiler(1, 2);
    profiler.ProfilerAgentInit();
    profiler.Profiler();
    EXPECT_EQ(profiler.SchedGetCurCpuTick(), 0UL);
    EXPECT_EQ(profiler.GetAicpuSysFreq(), 1UL);
    profiler.Uninit();

    AicpusdSetHiperfAccessResult(0);
    Hiva::SetMarkerMode(1U);
    AicpuProfiler activeStreamProfiler;
    activeStreamProfiler.InitProfiler(1, 2);
    activeStreamProfiler.Profiler();
    activeStreamProfiler.Uninit();

    Hiva::SetMarkerMode(2U);
    AicpuProfiler endGraphProfiler;
    endGraphProfiler.InitProfiler(1, 2);
    endGraphProfiler.Profiler();
    endGraphProfiler.Uninit();

    Hiva::SetMarkerMode(0U);
    AicpusdSetHiperfAccessResult(-1);
}
