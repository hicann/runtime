/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "driver/ascend_hal.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "acl_base_rt.h"
#define private public
#define protected public
#include "runtime.hpp"
#include "api_impl.hpp"
#include "context.hpp"
#include "task/task_info.hpp"
#include "runtime_task_manager.h"
#include "stream_c.hpp"
#include "task_recycle.hpp"
#include "npu_driver.hpp"
#include "davinci_kernel_task.h"
#include "stars_david.hpp"
#include "para_convertor.hpp"
#include "prof_ctrl_callback_manager.hpp"
#include "enum_desc.hpp"
#include "rt_unwrap.h"
#include "../../rt_utest_config_define.hpp"
#include "../../task_test_helper.h"
#include "arch9201/aic_aiv_sqe.h"
#include "arch9201/arch9201_sqe_utils.hpp"
#include "fusion_c.hpp"
#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;

static rtCqReport_t g_taskProfilingCqReport;
static rtError_t StubLogicCqReportV2(
    NpuDriver* drv, const LogicCqWaitInfo& waitInfo, uint8_t* report, uint32_t reportCnt, uint32_t& realCnt)
{
    (void)drv;
    (void)waitInfo;
    (void)reportCnt;
    realCnt = 1U;
    rtCqReport_t* reportPtr = reinterpret_cast<rtCqReport_t*>(report);
    g_taskProfilingCqReport.taskId = 1U;
    *reportPtr = g_taskProfilingCqReport;
    return RT_ERROR_NONE;
}

class Arch9201ProfileApiStub : public ApiImpl {
public:
    rtError_t ProfilerStart(
        const uint64_t profConfig, const int32_t numsDev, uint32_t* const deviceList, const uint32_t cacheFlag,
        const uint64_t profSwitchHi) override
    {
        (void)profConfig;
        (void)numsDev;
        (void)deviceList;
        (void)cacheFlag;
        (void)profSwitchHi;
        return RT_ERROR_NONE;
    }

    rtError_t ProfilerStop(
        const uint64_t profConfig, const int32_t numsDev, uint32_t* const deviceList,
        const uint64_t profSwitchHi) override
    {
        (void)profConfig;
        (void)numsDev;
        (void)deviceList;
        (void)profSwitchHi;
        return RT_ERROR_NONE;
    }
};

class Arch9201TaskProfilingTest : public testing::Test {
protected:
    static void SetUpTestCase() {}

    virtual void SetUp()
    {
        Runtime* const rtInstance = Runtime::Instance();
        savedTaskLevelProfFlag_ = rtInstance->GetTaskLevelProfFlag();
        rtInstance->SetTaskLevelProfFlag(false);

        ASSERT_EQ(rtSetDevice(0), RT_ERROR_NONE);
        dev_ = rtInstance->DeviceRetain(0, 0);
        ASSERT_NE(dev_, nullptr);

        Driver* const driver = rtInstance->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(static_cast<NpuDriver*>(driver), &NpuDriver::LogicCqReportV2)
            .stubs()
            .will(invoke(StubLogicCqReportV2));
        ASSERT_EQ(rtStreamCreate(&streamHandle_, 0), RT_ERROR_NONE);
        stream_ = rt_ut::UnwrapOrNull<Stream>(streamHandle_);
        ASSERT_NE(stream_, nullptr);
        stream_->SetSqMemAttr(false);
        stream_->Context_()->DefaultStream_()->SetSqMemAttr(false);
        MOCKER(StreamNopTask).stubs().will(returnValue(RT_ERROR_NONE));
        RefreshDavidSqeRunningFunc(CHIP_CLOUD_V5);
    }

    virtual void TearDown()
    {
        Runtime* const rtInstance = Runtime::Instance();
        rtInstance->SetTaskLevelProfFlag(savedTaskLevelProfFlag_);
        if (streamHandle_ != nullptr) {
            (void)rtStreamDestroy(streamHandle_);
        }
        stream_ = nullptr;
        if (dev_ != nullptr) {
            rtInstance->DeviceRelease(dev_);
        }
        RefreshDavidSqeRunningFunc(CHIP_BEGIN);
        (void)rtDeviceReset(0);
        GlobalMockObject::verify();
    }

    Stream* stream_ = nullptr;
    Device* dev_ = nullptr;
    rtStream_t streamHandle_ = nullptr;
    bool savedTaskLevelProfFlag_ = false;
};

static void ExpectArch9201AixSqeReservedByProfiling(
    Stream* const stream, const rtKernelAttrType kernelAttrType, const uint8_t mixType)
{
    TaskInfo task = {};
    RtArch9201StarsAicAivKernelSqe sqe = {};
    TaskSqeInfo sqeInfo = {0ULL, 0ULL};
    InitByStream(&task, stream);

    Kernel* const kernel = CreateTestKernelWithMixType(kernelAttrType, mixType);
    ASSERT_NE(kernel, nullptr);
    AicTaskInit(&task, kernel, kernel->GetKernelAttrType(), 1U, nullptr);
    task.u.aicTaskInfo.kernel = kernel;

    Runtime::Instance()->SetTaskLevelProfFlag(true);
    task.enableProfiling = 0U;
    ToConstructDavidSqe(&task, static_cast<void*>(&sqe), sqeInfo);
    EXPECT_EQ(sqe.header.reserved, 0U);

    task.enableProfiling = 1U;
    ToConstructDavidSqe(&task, static_cast<void*>(&sqe), sqeInfo);
    EXPECT_EQ(sqe.header.reserved, 1U);

    Runtime::Instance()->SetTaskLevelProfFlag(false);
    task.enableProfiling = 0U;
    ToConstructDavidSqe(&task, static_cast<void*>(&sqe), sqeInfo);
    EXPECT_EQ(sqe.header.reserved, 1U);

    TaskUnInitProc(&task);
    delete kernel;
}

static void ExpectArch9201AixSqeReservedWithTaskCfg(
    Stream* const stream, const TaskCfg& taskCfg, const uint8_t expectedEnableProfiling,
    const uint32_t expectedReserved)
{
    TaskInfo task = {};
    RtArch9201StarsAicAivKernelSqe sqe = {};
    TaskSqeInfo sqeInfo = {0ULL, 0ULL};
    InitByStream(&task, stream);

    Kernel* const kernel = CreateTestKernelWithMixType(RT_KERNEL_ATTR_TYPE_AICORE, NO_MIX);
    ASSERT_NE(kernel, nullptr);
    AicTaskInit(&task, kernel, kernel->GetKernelAttrType(), 1U, &taskCfg);
    task.u.aicTaskInfo.kernel = kernel;
    EXPECT_EQ(task.enableProfiling, expectedEnableProfiling);

    Runtime::Instance()->SetTaskLevelProfFlag(true);
    ToConstructDavidSqe(&task, static_cast<void*>(&sqe), sqeInfo);
    EXPECT_EQ(sqe.header.reserved, expectedReserved);

    TaskUnInitProc(&task);
    delete kernel;
}

TEST_F(Arch9201TaskProfilingTest, ConstructDavidHeadCommonSetsArch9201CommonTaskProfiling)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    task.type = TS_TASK_TYPE_CMO;
    rtDavidSqe_t sqe = {};

    Runtime::Instance()->SetTaskLevelProfFlag(false);
    ConstructDavidSqeForHeadCommon(&task, &sqe);
    EXPECT_EQ(sqe.commonSqe.sqeHeader.reserved, 1U);

    Runtime::Instance()->SetTaskLevelProfFlag(true);
    ConstructDavidSqeForHeadCommon(&task, &sqe);
    EXPECT_EQ(sqe.commonSqe.sqeHeader.reserved, 0U);

    RefreshDavidSqeRunningFunc(CHIP_DAVID);
    ConstructDavidSqeForHeadCommon(&task, &sqe);
    EXPECT_EQ(sqe.commonSqe.sqeHeader.reserved, 0U);
    RefreshDavidSqeRunningFunc(CHIP_CLOUD_V5);
}

TEST_F(Arch9201TaskProfilingTest, ConfigArch9201SqeHeaderTaskProfilingFollowsRuntimeSwitch)
{
    rtDavidStarsSqeHeader_t header = {};

    Runtime::Instance()->SetTaskLevelProfFlag(true);
    header.reserved = 1U;
    ConfigArch9201SqeHeaderTaskProfiling(&header);
    EXPECT_EQ(header.reserved, 0U);

    Runtime::Instance()->SetTaskLevelProfFlag(false);
    header.reserved = 0U;
    ConfigArch9201SqeHeaderTaskProfiling(&header);
    EXPECT_EQ(header.reserved, 1U);
}

TEST_F(Arch9201TaskProfilingTest, PostProcessDavidSqeHeaderKeepsHeaderWhenNoChipHookRegistered)
{
    rtDavidStarsSqeHeader_t header = {};
    header.reserved = 1U;

    Runtime::Instance()->SetTaskLevelProfFlag(true);
    RefreshDavidSqeRunningFunc(CHIP_DAVID);
    PostProcessDavidSqeHeader(&header);
    EXPECT_EQ(header.reserved, 1U);
    RefreshDavidSqeRunningFunc(CHIP_CLOUD_V5);
}

TEST_F(Arch9201TaskProfilingTest, RegDavidSqeHeaderPostProcRejectsInvalidChipAndKeepsRunningHook)
{
    Runtime::Instance()->SetTaskLevelProfFlag(true);
    RefreshDavidSqeRunningFunc(CHIP_CLOUD_V5);

    RegDavidSqeHeaderPostProcFunc(static_cast<rtChipType_t>(-1), nullptr);
    RegDavidSqeHeaderPostProcFunc(CHIP_END, nullptr);

    rtDavidStarsSqeHeader_t header = {};
    header.reserved = 1U;
    PostProcessDavidSqeHeader(&header);
    EXPECT_EQ(header.reserved, 0U);
}

TEST_F(Arch9201TaskProfilingTest, ConstructArch9201AixSqeTaskProfilingFollowsTaskConfig)
{
    ExpectArch9201AixSqeReservedByProfiling(stream_, RT_KERNEL_ATTR_TYPE_AICORE, NO_MIX);
    ExpectArch9201AixSqeReservedByProfiling(stream_, RT_KERNEL_ATTR_TYPE_VECTOR, NO_MIX);
    ExpectArch9201AixSqeReservedByProfiling(stream_, RT_KERNEL_ATTR_TYPE_MIX, MIX_AIC);
    ExpectArch9201AixSqeReservedByProfiling(stream_, RT_KERNEL_ATTR_TYPE_MIX, MIX_AIV);
    ExpectArch9201AixSqeReservedByProfiling(stream_, RT_KERNEL_ATTR_TYPE_MIX, MIX_AIC_AIV_MAIN_AIC);
    ExpectArch9201AixSqeReservedByProfiling(stream_, RT_KERNEL_ATTR_TYPE_MIX, MIX_AIC_AIV_MAIN_AIV);
}

TEST_F(Arch9201TaskProfilingTest, LaunchCfgEnableProfilingAttrFeedsArch9201AixSqe)
{
    TaskCfg defaultTaskCfg = {};
    ASSERT_EQ(ConvertLaunchCfgToTaskCfg(defaultTaskCfg, nullptr), RT_ERROR_NONE);
    EXPECT_EQ(defaultTaskCfg.isBaseValid, 1U);
    EXPECT_EQ(defaultTaskCfg.base.enableProfiling, 0U);
    ExpectArch9201AixSqeReservedWithTaskCfg(stream_, defaultTaskCfg, 0U, 0U);

    rtLaunchKernelAttr_t attr = {};
    attr.id = RT_LAUNCH_KERNEL_ATTR_ENABLE_PROFILING;
    attr.value.enableProfiling = 1U;
    rtKernelLaunchCfg_t cfg = {&attr, 1U};
    TaskCfg enabledTaskCfg = {};
    ASSERT_EQ(ConvertLaunchCfgToTaskCfg(enabledTaskCfg, &cfg), RT_ERROR_NONE);
    EXPECT_EQ(enabledTaskCfg.base.enableProfiling, 1U);
    ExpectArch9201AixSqeReservedWithTaskCfg(stream_, enabledTaskCfg, 1U, 1U);

    attr.value.enableProfiling = 0U;
    TaskCfg disabledTaskCfg = {};
    ASSERT_EQ(ConvertLaunchCfgToTaskCfg(disabledTaskCfg, &cfg), RT_ERROR_NONE);
    EXPECT_EQ(disabledTaskCfg.base.enableProfiling, 0U);
    ExpectArch9201AixSqeReservedWithTaskCfg(stream_, disabledTaskCfg, 0U, 0U);
}

TEST_F(Arch9201TaskProfilingTest, LaunchKernelRejectsInvalidEnableProfilingAttr)
{
    Kernel* const kernel = CreateTestKernelWithMixType(RT_KERNEL_ATTR_TYPE_AICORE, NO_MIX);
    ASSERT_NE(kernel, nullptr);
    kernel->SetHasParamSummary(true);
    kernel->SetParamCount(0U);

    rtLaunchKernelAttr_t attr = {};
    attr.id = RT_LAUNCH_KERNEL_ATTR_ENABLE_PROFILING;
    attr.value.enableProfiling = 2U;
    rtKernelLaunchCfg_t cfg = {&attr, 1U};
    rtFuncHandle funcHandle = rt_ut::InitAndExportHandle<rtFuncHandle>(kernel);

    EXPECT_EQ(rtLaunchKernelWithArgsArray(funcHandle, 1U, streamHandle_, &cfg, nullptr), ACL_ERROR_RT_PARAM_INVALID);

    delete kernel;
}

TEST_F(Arch9201TaskProfilingTest, RtProfSetProSwitchTogglesTaskLevelProfilingByOpMask)
{
    Arch9201ProfileApiStub apiStub;
    Api* const savedApi = Runtime::runtime_->api_;
    Runtime::runtime_->api_ = &apiStub;

    rtProfCommandHandle_t profilerConfig = {};
    profilerConfig.devNums = 1U;
    profilerConfig.devIdList[0] = 0U;
    profilerConfig.profSwitch = PROF_OP_MASK;

    Runtime::Instance()->SetTaskLevelProfFlag(false);
    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_START;
    EXPECT_EQ(rtProfSetProSwitch(&profilerConfig, sizeof(profilerConfig)), RT_ERROR_NONE);
    EXPECT_TRUE(Runtime::Instance()->GetTaskLevelProfFlag());

    profilerConfig.type = PROF_COMMANDHANDLE_TYPE_STOP;
    EXPECT_EQ(rtProfSetProSwitch(&profilerConfig, sizeof(profilerConfig)), RT_ERROR_NONE);
    EXPECT_FALSE(Runtime::Instance()->GetTaskLevelProfFlag());

    Runtime::runtime_->api_ = savedApi;
    ProfCtrlCallbackManager::Instance().DelAllData();
}

TEST_F(Arch9201TaskProfilingTest, Arch9201SetStarsResultCoversNoErrorVectorAndAicore)
{
    RefreshTaskFuncPointer(CHIP_DAVID);
    RefreshTaskFuncPointer(CHIP_CLOUD_V5);

    TaskInfo task = {};
    InitByStream(&task, stream_);
    rtCqReport_t logicCq = {};

    task.type = TS_TASK_TYPE_KERNEL_AIVEC;
    task.errorCode = TS_ERROR_AICORE_OVERFLOW;
    logicCq.errorType = 0U;
    SetStarsResult(&task, logicCq);
    EXPECT_EQ(task.errorCode, TS_ERROR_AICORE_OVERFLOW);

    logicCq.errorType = RT_STARS_CQE_ERR_TYPE_TASK_TIMEOUT;
    SetStarsResult(&task, logicCq);
    EXPECT_EQ(task.errorCode, TS_ERROR_VECTOR_CORE_TIMEOUT);

    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    logicCq.errorType = RT_STARS_CQE_ERR_TYPE_TASK_TIMEOUT;
    SetStarsResult(&task, logicCq);
    EXPECT_EQ(task.errorCode, TS_ERROR_AICORE_TIMEOUT);
}

TEST_F(Arch9201TaskProfilingTest, V200BaseSetStarsResultCoversAllKernelTaskTypes)
{
    RefreshTaskFuncPointer(CHIP_DAVID);

    TaskInfo task = {};
    InitByStream(&task, stream_);
    rtCqReport_t logicCq = {};
    logicCq.errorType = RT_STARS_CQE_ERR_TYPE_SQE_ERROR;

    task.type = TS_TASK_TYPE_KERNEL_AIVEC;
    SetStarsResult(&task, logicCq);
    EXPECT_EQ(task.errorCode, TS_ERROR_TASK_SQE_ERROR);

    task.type = TS_TASK_TYPE_KERNEL_AICPU;
    task.errorCode = 0U;
    logicCq.errorCode = 0U;
    SetStarsResult(&task, logicCq);
    EXPECT_EQ(task.errorCode, TS_ERROR_TASK_SQE_ERROR);

    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    task.errorCode = 0U;
    SetStarsResult(&task, logicCq);
    EXPECT_EQ(task.errorCode, TS_ERROR_TASK_SQE_ERROR);

    RefreshTaskFuncPointer(CHIP_CLOUD_V5);
}

TEST_F(Arch9201TaskProfilingTest, StarsV2ErrorCodeMapCoversAllTaskTypesAndDriverCode)
{
    rtCqReport_t logicCq = {};
    logicCq.errorCode = TS_ERROR_AICORE_OVERFLOW;

    logicCq.errorType = 1U << 0U;
    EXPECT_EQ(GetStarsV2VectorErrorCode(logicCq), TS_ERROR_VECTOR_CORE_EXCEPTION);
    EXPECT_EQ(GetStarsV2AicpuErrorCode(logicCq), TS_ERROR_AICPU_EXCEPTION);
    EXPECT_EQ(GetStarsV2AicoreErrorCode(logicCq), TS_ERROR_AICORE_EXCEPTION);

    logicCq.errorType = 1U << 1U;
    EXPECT_EQ(GetStarsV2VectorErrorCode(logicCq), TS_ERROR_TASK_BUS_ERROR);
    EXPECT_EQ(GetStarsV2AicpuErrorCode(logicCq), TS_ERROR_TASK_BUS_ERROR);
    EXPECT_EQ(GetStarsV2AicoreErrorCode(logicCq), TS_ERROR_TASK_BUS_ERROR);

    logicCq.errorType = 1U << 2U;
    EXPECT_EQ(GetStarsV2VectorErrorCode(logicCq), TS_ERROR_VECTOR_CORE_TIMEOUT);
    EXPECT_EQ(GetStarsV2AicpuErrorCode(logicCq), TS_ERROR_AICPU_TIMEOUT);
    EXPECT_EQ(GetStarsV2AicoreErrorCode(logicCq), TS_ERROR_AICORE_TIMEOUT);

    logicCq.errorType = 1U << 3U;
    EXPECT_EQ(GetStarsV2VectorErrorCode(logicCq), TS_ERROR_TASK_SQE_ERROR);
    EXPECT_EQ(GetStarsV2AicpuErrorCode(logicCq), TS_ERROR_TASK_SQE_ERROR);
    EXPECT_EQ(GetStarsV2AicoreErrorCode(logicCq), TS_ERROR_TASK_SQE_ERROR);

    logicCq.errorType = 1U << 4U;
    EXPECT_EQ(GetStarsV2VectorErrorCode(logicCq), TS_ERROR_VECTOR_CORE_EXCEPTION);
    EXPECT_EQ(GetStarsV2AicpuErrorCode(logicCq), TS_ERROR_AICPU_EXCEPTION);
    EXPECT_EQ(GetStarsV2AicoreErrorCode(logicCq), TS_ERROR_AICORE_EXCEPTION);

    logicCq.errorType = 1U << 5U;
    EXPECT_EQ(GetStarsV2VectorErrorCode(logicCq), TS_ERROR_AICORE_OVERFLOW);
    EXPECT_EQ(GetStarsV2AicpuErrorCode(logicCq), TS_ERROR_AICORE_OVERFLOW);
    EXPECT_EQ(GetStarsV2AicoreErrorCode(logicCq), TS_ERROR_AICORE_OVERFLOW);
}

TEST_F(Arch9201TaskProfilingTest, SysParamOptToStringCoversEarlyStartBoundaryOptions)
{
    EXPECT_EQ(SysParamOptToString(SYS_OPT_ENABLE_KERNEL_EARLY_START), "SYS_OPT_ENABLE_KERNEL_EARLY_START(3)");
    EXPECT_EQ(SysParamOptToString(SYS_OPT_RESERVED), "SYS_OPT_RESERVED(4)");
}

TEST_F(Arch9201TaskProfilingTest, ConstructArch9201FusionSqeTaskProfilingFollowsProfilerSwitch)
{
    uint64_t arg = 0x123456789ULL;
    rtFusionArgsEx_t argsInfo = {};
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);
    argsInfo.aicpuNum = 1U;
    argsInfo.aicpuArgs[0].kfcArgsFmtOffset = 0xFFFFU;

    rtLaunchAttribute_t attrs[1] = {};
    attrs[0].id = RT_LAUNCH_ATTRIBUTE_BLOCKDIM;
    attrs[0].value.blockDim = 1U;

    rtLaunchConfig_t launchConfig = {};
    launchConfig.numAttrs = 1U;
    launchConfig.attrs = attrs;

    rtFunsionTaskInfo_t fusionInfo = {};
    fusionInfo.subTaskNum = 2U;
    fusionInfo.subTask[0].type = RT_FUSION_AICPU;
    fusionInfo.subTask[0].task.aicpuInfo.blockDim = 2U;
    fusionInfo.subTask[1].type = RT_FUSION_AICORE;
    fusionInfo.subTask[1].task.aicoreInfo.config = &launchConfig;

    TaskInfo task = {};
    InitByStream(&task, stream_);
    FusionKernelTaskInit(&task);
    task.u.fusionKernelTask.fusionKernelInfo = static_cast<void*>(&fusionInfo);
    task.u.fusionKernelTask.argsInfo = &argsInfo;
    task.u.fusionKernelTask.argsSize = argsInfo.argsSize;
    task.u.fusionKernelTask.args = argsInfo.args;
    task.u.fusionKernelTask.sqeLen = 6U;

    rtAicAivFusionInfo_t aicAivInfo = {};
    LaunchTaskCfgInfo_t taskCfgInfo = {};
    Kernel* const kernel = CreateTestKernelWithMixType(RT_KERNEL_ATTR_TYPE_AICORE, NO_MIX);
    ASSERT_NE(kernel, nullptr);
    kernel->SetEarlyStartEnable(true);
    aicAivInfo.kernelAttrType = RT_KERNEL_ATTR_TYPE_AICORE;
    aicAivInfo.mixType = NO_MIX;
    aicAivInfo.kernel = kernel;
    aicAivInfo.launchTaskCfg = &taskCfgInfo;
    AixKernelTaskInitForFusion(&task, &aicAivInfo, &taskCfgInfo);
    task.u.fusionKernelTask.aicAivType = 0U;

    rtDavidSqe_t sqe[6] = {};
    TaskSqeInfo sqeInfo = {0ULL, 0ULL};

    Runtime::Instance()->SetTaskLevelProfFlag(false);
    ToConstructDavidSqe(&task, static_cast<void*>(sqe), sqeInfo);
    EXPECT_EQ(sqe[0].aicpuSqe.header.type, RT_DAVID_SQE_TYPE_FUSION);
    EXPECT_EQ(sqe[0].aicpuSqe.header.reserved, 1U);
    EXPECT_EQ(sqe[1].aicAivSqe.header.reserved, 1U);
    EXPECT_EQ(static_cast<RtArch9201StarsAicAivKernelSqe*>(static_cast<void*>(&sqe[0]))->ost, 1U);
    EXPECT_EQ(static_cast<RtArch9201StarsAicAivKernelSqe*>(static_cast<void*>(&sqe[1]))->ost, 1U);

    Runtime::Instance()->SetTaskLevelProfFlag(true);
    ToConstructDavidSqe(&task, static_cast<void*>(sqe), sqeInfo);
    EXPECT_EQ(sqe[0].aicpuSqe.header.reserved, 0U);
    EXPECT_EQ(sqe[1].aicAivSqe.header.reserved, 0U);
    EXPECT_EQ(static_cast<RtArch9201StarsAicAivKernelSqe*>(static_cast<void*>(&sqe[0]))->ost, 1U);
    EXPECT_EQ(static_cast<RtArch9201StarsAicAivKernelSqe*>(static_cast<void*>(&sqe[1]))->ost, 1U);

    TaskUnInitProc(&task);
    delete kernel;
}
