/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <array>
#include <cstring>
#include <deque>

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#define private public
#define protected public
#include "aicpu_timeout_control.h"
#include "aicpu_timeout_manager.h"
#include "npu_driver.hpp"
#include "raw_device.hpp"
#include "rt_external_kernel.h"
#include "runtime.hpp"
#include "runtime/kernel.h"
#include "stream.hpp"
#undef protected
#undef private

#include "aicpu_c.hpp"
#include "aicpu_schedule/aicpusd_info.h"
#include "thread_local_container.hpp"

using namespace cce::runtime;
using namespace mockcpp;

namespace {
constexpr uint32_t TEST_DEVICE_ID = 3U;
constexpr uint32_t TEST_TS_ID = 1U;
constexpr uint32_t SPARSE_DEVICE_ID = 0xFFFFFFFEU;

struct AllocResult {
    rtError_t ret;
    void* addr;
};

std::deque<AllocResult> g_allocResults;
std::deque<rtError_t> g_memCopyResults;
uint32_t g_freeCount = 0U;
rtError_t g_launchResult = RT_ERROR_NONE;
uint32_t g_checkResult = 0U;
bool g_writeCloseResult = true;
uint8_t g_closeResult = 0U;
rtError_t g_checkKernelRet = RT_ERROR_NONE;
bool g_kernelSupported = false;
rtError_t g_closeMonitorRet = RT_ERROR_NONE;
bool g_monitorClosed = false;
bool g_stopCalled = false;
Stream* g_launchStream = nullptr;
bool g_syncNeedWaitSyncCq = true;
int32_t g_syncTimeout = -1;
rtError_t g_syncResult = RT_ERROR_NONE;

rtError_t DevMemAllocStub(
    Driver* drv, void** dptr, uint64_t size, rtMemType_t type, uint32_t deviceId, uint16_t moduleId, bool isLogError,
    bool readOnlyFlag, bool starsTillingFlag, bool isNewApi, bool cpOnlyFlag)
{
    UNUSED(drv);
    UNUSED(size);
    UNUSED(type);
    UNUSED(deviceId);
    UNUSED(moduleId);
    UNUSED(isLogError);
    UNUSED(readOnlyFlag);
    UNUSED(starsTillingFlag);
    UNUSED(isNewApi);
    UNUSED(cpOnlyFlag);
    if (g_allocResults.empty()) {
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    const AllocResult result = g_allocResults.front();
    g_allocResults.pop_front();
    if (result.ret == RT_ERROR_NONE) {
        *dptr = result.addr;
    }
    return result.ret;
}

rtError_t DevMemFreeStub(Driver* drv, void* dptr, uint32_t deviceId)
{
    UNUSED(drv);
    UNUSED(dptr);
    UNUSED(deviceId);
    ++g_freeCount;
    return RT_ERROR_NONE;
}

rtError_t MemCopySyncStub(
    Driver* drv, void* dst, uint64_t destMax, const void* src, uint64_t size, rtMemcpyKind_t kind, bool errShow,
    uint32_t devId)
{
    UNUSED(drv);
    UNUSED(kind);
    UNUSED(errShow);
    UNUSED(devId);
    if (!g_memCopyResults.empty()) {
        const rtError_t result = g_memCopyResults.front();
        g_memCopyResults.pop_front();
        if (result != RT_ERROR_NONE) {
            return result;
        }
    }
    if ((dst == nullptr) || (src == nullptr) || (size > destMax)) {
        return RT_ERROR_INVALID_VALUE;
    }
    (void)std::memcpy(dst, src, static_cast<size_t>(size));
    return RT_ERROR_NONE;
}

rtError_t LaunchCpuKernelStub(
    const rtKernelLaunchNames_t* launchNames, uint32_t coreDim, const rtArgsEx_t* argsInfo, Stream* stm, uint32_t flag,
    uint64_t timeout)
{
    UNUSED(coreDim);
    UNUSED(flag);
    UNUSED(timeout);
    g_launchStream = stm;
    if (g_launchResult != RT_ERROR_NONE) {
        return g_launchResult;
    }
    EXPECT_NE(launchNames, nullptr);
    EXPECT_NE(argsInfo, nullptr);
    EXPECT_EQ(argsInfo->isNoNeedH2DCopy, 1U);
    if ((launchNames == nullptr) || (argsInfo == nullptr)) {
        return RT_ERROR_INVALID_VALUE;
    }
    if (std::strcmp(launchNames->kernelName, "CheckKernelSupported") == 0) {
        const auto* cfg = static_cast<const CheckKernelSupportedConfig*>(argsInfo->args);
        *reinterpret_cast<uint32_t*>(cfg->checkResultAddr) = g_checkResult;
    } else if (g_writeCloseResult) {
        auto* bytes = static_cast<uint8_t*>(argsInfo->args);
        bytes[1] = g_closeResult;
    }
    return RT_ERROR_NONE;
}

rtError_t StreamSynchronizeStub(Stream* stm, const bool isNeedWaitSyncCq, int32_t timeout)
{
    UNUSED(stm);
    g_syncNeedWaitSyncCq = isNeedWaitSyncCq;
    g_syncTimeout = timeout;
    return g_syncResult;
}

rtError_t CheckKernelSupportedStub(const Device* dev, const std::string& kernelName, bool& isSupported)
{
    UNUSED(dev);
    EXPECT_EQ(kernelName, "tsKernel:CloseAicpuMonitor");
    isSupported = g_kernelSupported;
    return g_checkKernelRet;
}

rtError_t CloseAicpuMonitorStub(const Device* dev, bool& closed)
{
    UNUSED(dev);
    closed = g_monitorClosed;
    return g_closeMonitorRet;
}

void StopAicpuProcessStub(const Device* dev)
{
    UNUSED(dev);
    g_stopCalled = true;
}
} // namespace

class AicpuTimeoutTestEngine : public Engine {
public:
    explicit AicpuTimeoutTestEngine(Device* device) : Engine(device) {}
    rtError_t Init() override { return RT_ERROR_NONE; }
    rtError_t Start() override { return RT_ERROR_NONE; }
    rtError_t Stop() override { return RT_ERROR_NONE; }
    void Run(const void* param) override { UNUSED(param); }
};

class AicpuTimeoutTest : public testing::Test {
protected:
    void ResetManagerState()
    {
        AicpuTimeoutManager::ClearAicpuTimeoutState(&device_);
        AicpuTimeoutManager::ClearAicpuTimeoutState(&sparseDevice_);
    }

    void SetUp() override
    {
        ResetManagerState();
        g_allocResults.clear();
        g_memCopyResults.clear();
        g_freeCount = 0U;
        g_launchResult = RT_ERROR_NONE;
        g_checkResult = 0U;
        g_writeCloseResult = true;
        g_closeResult = 0U;
        g_checkKernelRet = RT_ERROR_NONE;
        g_kernelSupported = false;
        g_closeMonitorRet = RT_ERROR_NONE;
        g_monitorClosed = false;
        g_stopCalled = false;
        g_launchStream = nullptr;
        g_syncNeedWaitSyncCq = true;
        g_syncTimeout = -1;
        g_syncResult = RT_ERROR_NONE;

        driver_ = NpuDriver::Instance_();
        device_.driver_ = driver_;
        device_.engine_ = new AicpuTimeoutTestEngine(&device_);
        device_.engine_->runningState_ = DEV_RUNNING_DOWN;
        device_.primaryStream_ = &stream_;
        device_.SetRunMode(RT_RUN_MODE_ONLINE);
    }

    void TearDown() override
    {
        if (device_.ctrlSQ_.get() != nullptr) {
            device_.ctrlSQ_->stream_ = nullptr;
            device_.ctrlSQ_.reset();
        }
        device_.primaryStream_ = nullptr;
        device_.driver_ = nullptr;
        ResetManagerState();
        GlobalMockObject::verify();
    }

    void MockBuiltinKernelDependencies(rtError_t syncResult = RT_ERROR_NONE)
    {
        g_syncResult = syncResult;
        MOCKER_CPP_VIRTUAL(driver_, &Driver::DevMemAlloc).stubs().will(invoke(DevMemAllocStub));
        MOCKER_CPP_VIRTUAL(driver_, &Driver::DevMemFree).stubs().will(invoke(DevMemFreeStub));
        MOCKER_CPP_VIRTUAL(driver_, &Driver::MemCopySync).stubs().will(invoke(MemCopySyncStub));
        MOCKER(StreamLaunchCpuKernel).stubs().will(invoke(LaunchCpuKernelStub));
        MOCKER_CPP_VIRTUAL(&stream_, &Stream::Synchronize).stubs().will(invoke(StreamSynchronizeStub));
    }

    void SetAicpuMonitorClosed(bool closed) { device_.SetAicpuMonitorClosedStatus(closed); }

    void SetAicpuTimeoutForAllTypesSupported(bool supported)
    {
        const uint32_t index = static_cast<uint32_t>(RtOptionalFeatureType::RT_FEATURE_STARS_MONITOR_AICPU_TIMEOUT);
        device_.featureSet_[index] = supported;
    }

    void SetDeviceCtrlSqSupported(bool supported)
    {
        const uint32_t index = static_cast<uint32_t>(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ);
        device_.featureSet_[index] = supported;
    }

    std::array<uint8_t, 128U> nameBuffer_ = {};
    std::array<uint8_t, 32U> resultBuffer_ = {};
    std::array<uint8_t, 128U> configBuffer_ = {};
    RawDevice device_{TEST_DEVICE_ID};
    RawDevice sparseDevice_{SPARSE_DEVICE_ID};
    Stream stream_{&device_, 0U};
    Stream ctrlSqStream_{&device_, 0U};
    Driver* driver_ = nullptr;
};

TEST_F(AicpuTimeoutTest, TimeoutSupportByKernelTypeFollowsDeviceFeature)
{
    SetAicpuTimeoutForAllTypesSupported(true);
    EXPECT_TRUE(AicpuTimeoutManager::IsTimeoutSupportedByKernelType(&device_, 0U));

    SetAicpuTimeoutForAllTypesSupported(false);
    EXPECT_FALSE(AicpuTimeoutManager::IsTimeoutSupportedByKernelType(&device_, 0U));
    EXPECT_TRUE(
        AicpuTimeoutManager::IsTimeoutSupportedByKernelType(&device_, static_cast<uint32_t>(KERNEL_TYPE_AICPU_KFC)));
}

TEST_F(AicpuTimeoutTest, TimeoutSupportByLaunchFlagFollowsDeviceFeature)
{
    SetAicpuTimeoutForAllTypesSupported(true);
    EXPECT_TRUE(AicpuTimeoutManager::IsTimeoutSupportedByLaunchFlag(&device_, RT_KERNEL_DEFAULT));

    SetAicpuTimeoutForAllTypesSupported(false);
    EXPECT_FALSE(AicpuTimeoutManager::IsTimeoutSupportedByLaunchFlag(&device_, RT_KERNEL_DEFAULT));
    EXPECT_TRUE(AicpuTimeoutManager::IsTimeoutSupportedByLaunchFlag(&device_, RT_KERNEL_USE_SPECIAL_TIMEOUT));
}

TEST_F(AicpuTimeoutTest, DefaultCreditUsesDeviceFeature)
{
    SetAicpuTimeoutForAllTypesSupported(true);
    EXPECT_TRUE(AicpuTimeoutManager::IsStarsMonitorAicpuTimeoutSupported(&device_));
    EXPECT_EQ(
        AicpuTimeoutManager::GetAicpuDefaultKernelCredit(&device_),
        Runtime::Instance()->GetStarsFftsDefaultKernelCredit());

    SetAicpuTimeoutForAllTypesSupported(false);
    EXPECT_FALSE(AicpuTimeoutManager::IsStarsMonitorAicpuTimeoutSupported(&device_));
    EXPECT_EQ(AicpuTimeoutManager::GetAicpuDefaultKernelCredit(&device_), RT_STARS_DEFAULT_AICPU_KERNEL_CREDIT);
}

TEST_F(AicpuTimeoutTest, StarsMonitorAicpuTimeoutUnsupportedInOfflineMode)
{
    SetAicpuTimeoutForAllTypesSupported(true);
    device_.SetRunMode(RT_RUN_MODE_OFFLINE);

    EXPECT_FALSE(AicpuTimeoutManager::IsStarsMonitorAicpuTimeoutSupported(&device_));
    EXPECT_EQ(AicpuTimeoutManager::GetAicpuDefaultKernelCredit(&device_), RT_STARS_DEFAULT_AICPU_KERNEL_CREDIT);
    EXPECT_FALSE(AicpuTimeoutManager::IsTimeoutSupportedByKernelType(&device_, 0U));
    EXPECT_FALSE(AicpuTimeoutManager::IsTimeoutSupportedByLaunchFlag(&device_, RT_KERNEL_DEFAULT));
}

TEST_F(AicpuTimeoutTest, CqeMarksStopOnlyForManagedAicpuTimeout)
{
    rtLogicCqReport_t logicCq = {};
    logicCq.errorType = static_cast<uint8_t>(RT_STARS_CQE_ERR_TYPE_TASK_TIMEOUT);
    TaskInfo task = {};
    task.type = TS_TASK_TYPE_KERNEL_AICPU;

    AicpuTimeoutManager::UpdateAicpuTimeoutStateOnCqeReport(&device_, logicCq, &task, nullptr);
    EXPECT_FALSE(device_.GetAicpuProcessStopPendingStatus());

    SetAicpuMonitorClosed(true);
    AicpuTimeoutManager::UpdateAicpuTimeoutStateOnCqeReport(&device_, logicCq, &task, nullptr);
    EXPECT_TRUE(device_.GetAicpuProcessStopPendingStatus());

    device_.SetAicpuProcessStopPendingStatus(false);
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    AicpuTimeoutManager::UpdateAicpuTimeoutStateOnCqeReport(&device_, logicCq, &task, nullptr);
    EXPECT_FALSE(device_.GetAicpuProcessStopPendingStatus());
}

TEST_F(AicpuTimeoutTest, FaultTaskRawErrorMarksStop)
{
    SetAicpuMonitorClosed(true);
    TaskInfo faultTask = {};
    faultTask.type = TS_TASK_TYPE_KERNEL_AICPU;
    faultTask.errorCode = AICPU_TIMEOUT_RAW_ERRCODE;

    AicpuTimeoutManager::UpdateAicpuTimeoutStateOnCqeReport(&device_, rtLogicCqReport_t{}, nullptr, &faultTask);

    EXPECT_TRUE(device_.GetAicpuProcessStopPendingStatus());
}

TEST_F(AicpuTimeoutTest, PendingStopIsConsumedOnce)
{
    SetAicpuMonitorClosed(true);
    device_.SetAicpuProcessStopPendingStatus(true);
    MOCKER(AicpuTimeoutManager::StopAicpuProcess)
        .expects(once())
        .with(mockcpp::any())
        .will(invoke(StopAicpuProcessStub));

    AicpuTimeoutManager::CheckAndStopAicpuProcess(&device_);
    AicpuTimeoutManager::CheckAndStopAicpuProcess(&device_);

    EXPECT_FALSE(device_.GetAicpuProcessStopPendingStatus());
    EXPECT_TRUE(g_stopCalled);
}

TEST_F(AicpuTimeoutTest, StopProcessUsesDeviceTsId)
{
    device_.tsId_ = TEST_TS_ID;
    MOCKER_CPP(&Runtime::StopAicpuExecutor)
        .expects(once())
        .with(TEST_DEVICE_ID, TEST_TS_ID, true)
        .will(returnValue(RT_ERROR_NONE));

    AicpuTimeoutManager::StopAicpuProcess(&device_);
}

TEST_F(AicpuTimeoutTest, SparseDeviceIdsUseIndependentStates)
{
    device_.SetAicpuProcessStopPendingStatus(true);
    SetAicpuMonitorClosed(true);

    EXPECT_TRUE(device_.GetAicpuProcessStopPendingStatus());
    EXPECT_TRUE(device_.GetAicpuMonitorClosedStatus());
    EXPECT_FALSE(sparseDevice_.GetAicpuProcessStopPendingStatus());
    EXPECT_FALSE(sparseDevice_.GetAicpuMonitorClosedStatus());
}

TEST_F(AicpuTimeoutTest, ClearAicpuTimeoutStateClearsTakeoverAndPendingStop)
{
    SetAicpuMonitorClosed(true);
    device_.SetAicpuProcessStopPendingStatus(true);

    AicpuTimeoutManager::ClearAicpuTimeoutState(&device_);

    EXPECT_FALSE(device_.GetAicpuMonitorClosedStatus());
    EXPECT_FALSE(device_.GetAicpuProcessStopPendingStatus());
}

TEST_F(AicpuTimeoutTest, TryCloseMonitorKeepsSelfMonitorWhenUnsupported)
{
    MOCKER(AicpuTimeoutControl::CheckKernelSupported).expects(never());
    MOCKER(AicpuTimeoutControl::CloseAicpuMonitor).expects(never());

    EXPECT_EQ(AicpuTimeoutManager::TryCloseAicpuMonitor(&device_), RT_ERROR_NONE);

    EXPECT_FALSE(device_.GetAicpuMonitorClosedStatus());
}

TEST_F(AicpuTimeoutTest, TryCloseMonitorKeepsSelfMonitorWhenBuiltinKernelUnsupported)
{
    SetAicpuTimeoutForAllTypesSupported(true);
    MOCKER(AicpuTimeoutControl::CheckKernelSupported).expects(once()).will(invoke(CheckKernelSupportedStub));
    MOCKER(AicpuTimeoutControl::CloseAicpuMonitor).expects(never());

    EXPECT_EQ(AicpuTimeoutManager::TryCloseAicpuMonitor(&device_), RT_ERROR_NONE);

    EXPECT_FALSE(device_.GetAicpuMonitorClosedStatus());
}

TEST_F(AicpuTimeoutTest, TryCloseMonitorRecordsSuccessAndSkipsDuplicateProbe)
{
    SetAicpuTimeoutForAllTypesSupported(true);
    g_kernelSupported = true;
    g_monitorClosed = true;
    MOCKER(AicpuTimeoutControl::CheckKernelSupported).expects(once()).will(invoke(CheckKernelSupportedStub));
    MOCKER(AicpuTimeoutControl::CloseAicpuMonitor).expects(once()).will(invoke(CloseAicpuMonitorStub));

    EXPECT_EQ(AicpuTimeoutManager::TryCloseAicpuMonitor(&device_), RT_ERROR_NONE);
    EXPECT_EQ(AicpuTimeoutManager::TryCloseAicpuMonitor(&device_), RT_ERROR_NONE);

    EXPECT_TRUE(device_.GetAicpuMonitorClosedStatus());
}

TEST_F(AicpuTimeoutTest, TryCloseMonitorKeepsSelfMonitorWhenCloseLaunchFails)
{
    SetAicpuTimeoutForAllTypesSupported(true);
    g_kernelSupported = true;
    g_closeMonitorRet = RT_ERROR_DRV_ERR;
    MOCKER(AicpuTimeoutControl::CheckKernelSupported).expects(once()).will(invoke(CheckKernelSupportedStub));
    MOCKER(AicpuTimeoutControl::CloseAicpuMonitor).expects(once()).will(invoke(CloseAicpuMonitorStub));

    EXPECT_EQ(AicpuTimeoutManager::TryCloseAicpuMonitor(&device_), RT_ERROR_DRV_ERR);

    EXPECT_FALSE(device_.GetAicpuMonitorClosedStatus());
}

TEST_F(AicpuTimeoutTest, ClearAicpuTimeoutStateAllowsMonitorRetry)
{
    SetAicpuMonitorClosed(true);
    SetAicpuTimeoutForAllTypesSupported(true);
    g_checkKernelRet = RT_ERROR_DRV_ERR;
    MOCKER(AicpuTimeoutControl::CheckKernelSupported).expects(once()).will(invoke(CheckKernelSupportedStub));

    AicpuTimeoutManager::ClearAicpuTimeoutState(&device_);
    EXPECT_EQ(AicpuTimeoutManager::TryCloseAicpuMonitor(&device_), RT_ERROR_DRV_ERR);

    EXPECT_FALSE(device_.GetAicpuMonitorClosedStatus());
}

TEST_F(AicpuTimeoutTest, UpdateTimeoutConfigSkipsDeviceTaskAfterMonitorClose)
{
    Runtime* const runtime = Runtime::Instance();
    const bool oldWaitTimeoutConfigured = runtime->timeoutConfig_.isCfgOpWaitTaskTimeout;
    const bool oldExecuteTimeoutConfigured = runtime->timeoutConfig_.isCfgOpExcTaskTimeout;
    runtime->timeoutConfig_.isCfgOpWaitTaskTimeout = false;
    runtime->timeoutConfig_.isCfgOpExcTaskTimeout = true;
    device_.primaryStream_ = nullptr;
    SetAicpuMonitorClosed(true);

    EXPECT_EQ(device_.UpdateTimeoutConfig(), RT_ERROR_NONE);

    runtime->timeoutConfig_.isCfgOpWaitTaskTimeout = oldWaitTimeoutConfigured;
    runtime->timeoutConfig_.isCfgOpExcTaskTimeout = oldExecuteTimeoutConfigured;
}

TEST_F(AicpuTimeoutTest, UpdateTimeoutConfigContinuesWhenMonitorOpen)
{
    Runtime* const runtime = Runtime::Instance();
    const bool oldWaitTimeoutConfigured = runtime->timeoutConfig_.isCfgOpWaitTaskTimeout;
    const bool oldExecuteTimeoutConfigured = runtime->timeoutConfig_.isCfgOpExcTaskTimeout;
    runtime->timeoutConfig_.isCfgOpWaitTaskTimeout = false;
    runtime->timeoutConfig_.isCfgOpExcTaskTimeout = false;
    SetAicpuMonitorClosed(false);

    EXPECT_EQ(device_.UpdateTimeoutConfig(), RT_ERROR_NONE);

    runtime->timeoutConfig_.isCfgOpWaitTaskTimeout = oldWaitTimeoutConfigured;
    runtime->timeoutConfig_.isCfgOpExcTaskTimeout = oldExecuteTimeoutConfigured;
}

TEST_F(AicpuTimeoutTest, CheckKernelSupportedReturnsDeviceResultAndFreesAllBuffers)
{
    MockBuiltinKernelDependencies();
    g_allocResults = {
        {RT_ERROR_NONE, nameBuffer_.data()},
        {RT_ERROR_NONE, resultBuffer_.data()},
        {RT_ERROR_NONE, configBuffer_.data()}};
    bool supported = false;

    EXPECT_EQ(
        AicpuTimeoutControl::CheckKernelSupported(&device_, "tsKernel:CloseAicpuMonitor", supported), RT_ERROR_NONE);
    EXPECT_TRUE(supported);
    EXPECT_EQ(g_freeCount, 3U);
    EXPECT_FALSE(g_syncNeedWaitSyncCq);
    EXPECT_EQ(g_syncTimeout, 10000);
}

TEST_F(AicpuTimeoutTest, BuiltinKernelRejectsNullStream)
{
    EXPECT_EQ(
        AicpuTimeoutControl::LaunchAicpuBuiltinKernel(nullptr, "kernel", configBuffer_.data(), 4U),
        RT_ERROR_INVALID_VALUE);
}

TEST_F(AicpuTimeoutTest, BuiltinKernelRejectsMissingDriver)
{
    device_.driver_ = nullptr;
    bool supported = true;
    bool closed = true;

    EXPECT_EQ(AicpuTimeoutControl::CheckKernelSupported(&device_, "kernel", supported), RT_ERROR_INVALID_VALUE);
    EXPECT_FALSE(supported);
    EXPECT_EQ(AicpuTimeoutControl::CloseAicpuMonitor(&device_, closed), RT_ERROR_INVALID_VALUE);
    EXPECT_FALSE(closed);
}

TEST_F(AicpuTimeoutTest, CheckKernelSupportedRejectsEmptyName)
{
    bool supported = true;

    EXPECT_EQ(AicpuTimeoutControl::CheckKernelSupported(&device_, "", supported), RT_ERROR_INVALID_VALUE);
    EXPECT_FALSE(supported);
}

TEST_F(AicpuTimeoutTest, CheckKernelSupportedPreservesUnsupportedResult)
{
    MockBuiltinKernelDependencies();
    g_checkResult = MAX_UINT32_NUM;
    g_allocResults = {
        {RT_ERROR_NONE, nameBuffer_.data()},
        {RT_ERROR_NONE, resultBuffer_.data()},
        {RT_ERROR_NONE, configBuffer_.data()}};
    bool supported = true;

    EXPECT_EQ(AicpuTimeoutControl::CheckKernelSupported(&device_, "unknown", supported), RT_ERROR_NONE);
    EXPECT_FALSE(supported);
    EXPECT_EQ(g_freeCount, 3U);
}

TEST_F(AicpuTimeoutTest, CheckKernelSupportedFreesAllocatedMemoryOnPartialAllocFailure)
{
    MOCKER_CPP_VIRTUAL(driver_, &Driver::DevMemAlloc).stubs().will(invoke(DevMemAllocStub));
    MOCKER_CPP_VIRTUAL(driver_, &Driver::DevMemFree).stubs().will(invoke(DevMemFreeStub));
    g_allocResults = {{RT_ERROR_NONE, nameBuffer_.data()}, {RT_ERROR_MEMORY_ALLOCATION, nullptr}};
    bool supported = true;

    EXPECT_EQ(AicpuTimeoutControl::CheckKernelSupported(&device_, "kernel", supported), RT_ERROR_MEMORY_ALLOCATION);
    EXPECT_FALSE(supported);
    EXPECT_EQ(g_freeCount, 1U);
}

TEST_F(AicpuTimeoutTest, CheckKernelSupportedReturnsFirstAllocFailure)
{
    MOCKER_CPP_VIRTUAL(driver_, &Driver::DevMemAlloc).stubs().will(invoke(DevMemAllocStub));
    g_allocResults = {{RT_ERROR_MEMORY_ALLOCATION, nullptr}};
    bool supported = true;

    EXPECT_EQ(AicpuTimeoutControl::CheckKernelSupported(&device_, "kernel", supported), RT_ERROR_MEMORY_ALLOCATION);
    EXPECT_FALSE(supported);
    EXPECT_EQ(g_freeCount, 0U);
}

TEST_F(AicpuTimeoutTest, CheckKernelSupportedFreesBuffersOnConfigAllocFailure)
{
    MOCKER_CPP_VIRTUAL(driver_, &Driver::DevMemAlloc).stubs().will(invoke(DevMemAllocStub));
    MOCKER_CPP_VIRTUAL(driver_, &Driver::DevMemFree).stubs().will(invoke(DevMemFreeStub));
    g_allocResults = {
        {RT_ERROR_NONE, nameBuffer_.data()},
        {RT_ERROR_NONE, resultBuffer_.data()},
        {RT_ERROR_MEMORY_ALLOCATION, nullptr}};
    bool supported = true;

    EXPECT_EQ(AicpuTimeoutControl::CheckKernelSupported(&device_, "kernel", supported), RT_ERROR_MEMORY_ALLOCATION);
    EXPECT_FALSE(supported);
    EXPECT_EQ(g_freeCount, 2U);
}

TEST_F(AicpuTimeoutTest, CheckKernelSupportedReturnsNameCopyFailure)
{
    MockBuiltinKernelDependencies();
    g_allocResults = {
        {RT_ERROR_NONE, nameBuffer_.data()},
        {RT_ERROR_NONE, resultBuffer_.data()},
        {RT_ERROR_NONE, configBuffer_.data()}};
    g_memCopyResults = {RT_ERROR_DRV_ERR};
    bool supported = true;

    EXPECT_EQ(AicpuTimeoutControl::CheckKernelSupported(&device_, "kernel", supported), RT_ERROR_DRV_ERR);
    EXPECT_FALSE(supported);
    EXPECT_EQ(g_freeCount, 3U);
}

TEST_F(AicpuTimeoutTest, CheckKernelSupportedReturnsResultCopyFailure)
{
    MockBuiltinKernelDependencies();
    g_allocResults = {
        {RT_ERROR_NONE, nameBuffer_.data()},
        {RT_ERROR_NONE, resultBuffer_.data()},
        {RT_ERROR_NONE, configBuffer_.data()}};
    g_memCopyResults = {RT_ERROR_NONE, RT_ERROR_NONE, RT_ERROR_NONE, RT_ERROR_DRV_ERR};
    bool supported = true;

    EXPECT_EQ(AicpuTimeoutControl::CheckKernelSupported(&device_, "kernel", supported), RT_ERROR_DRV_ERR);
    EXPECT_FALSE(supported);
    EXPECT_EQ(g_freeCount, 3U);
}

TEST_F(AicpuTimeoutTest, CheckKernelSupportedReturnsLaunchFailure)
{
    MockBuiltinKernelDependencies();
    g_launchResult = RT_ERROR_DEVICE_INVALID;
    g_allocResults = {
        {RT_ERROR_NONE, nameBuffer_.data()},
        {RT_ERROR_NONE, resultBuffer_.data()},
        {RT_ERROR_NONE, configBuffer_.data()}};
    bool supported = true;

    EXPECT_EQ(AicpuTimeoutControl::CheckKernelSupported(&device_, "kernel", supported), RT_ERROR_DEVICE_INVALID);
    EXPECT_FALSE(supported);
    EXPECT_EQ(g_freeCount, 3U);
}

TEST_F(AicpuTimeoutTest, CloseMonitorRequiresDeviceToWriteSuccess)
{
    MockBuiltinKernelDependencies();
    g_writeCloseResult = false;
    g_allocResults = {{RT_ERROR_NONE, configBuffer_.data()}};
    bool closed = true;

    EXPECT_EQ(AicpuTimeoutControl::CloseAicpuMonitor(&device_, closed), RT_ERROR_INVALID_VALUE);
    EXPECT_FALSE(closed);
    EXPECT_EQ(g_freeCount, 1U);
}

TEST_F(AicpuTimeoutTest, CloseMonitorReturnsDeviceSuccess)
{
    MockBuiltinKernelDependencies();
    g_allocResults = {{RT_ERROR_NONE, configBuffer_.data()}};
    bool closed = false;

    EXPECT_EQ(AicpuTimeoutControl::CloseAicpuMonitor(&device_, closed), RT_ERROR_NONE);
    EXPECT_TRUE(closed);
    EXPECT_EQ(g_freeCount, 1U);
}

TEST_F(AicpuTimeoutTest, CloseMonitorReturnsAllocFailure)
{
    MOCKER_CPP_VIRTUAL(driver_, &Driver::DevMemAlloc).stubs().will(invoke(DevMemAllocStub));
    g_allocResults = {{RT_ERROR_MEMORY_ALLOCATION, nullptr}};
    bool closed = true;

    EXPECT_EQ(AicpuTimeoutControl::CloseAicpuMonitor(&device_, closed), RT_ERROR_MEMORY_ALLOCATION);
    EXPECT_FALSE(closed);
    EXPECT_EQ(g_freeCount, 0U);
}

TEST_F(AicpuTimeoutTest, CloseMonitorReturnsHostToDeviceCopyFailure)
{
    MockBuiltinKernelDependencies();
    g_allocResults = {{RT_ERROR_NONE, configBuffer_.data()}};
    g_memCopyResults = {RT_ERROR_DRV_ERR};
    bool closed = true;

    EXPECT_EQ(AicpuTimeoutControl::CloseAicpuMonitor(&device_, closed), RT_ERROR_DRV_ERR);
    EXPECT_FALSE(closed);
    EXPECT_EQ(g_freeCount, 1U);
}

TEST_F(AicpuTimeoutTest, CloseMonitorReturnsLaunchFailure)
{
    MockBuiltinKernelDependencies();
    g_allocResults = {{RT_ERROR_NONE, configBuffer_.data()}};
    g_launchResult = RT_ERROR_DEVICE_INVALID;
    bool closed = true;

    EXPECT_EQ(AicpuTimeoutControl::CloseAicpuMonitor(&device_, closed), RT_ERROR_DEVICE_INVALID);
    EXPECT_FALSE(closed);
    EXPECT_EQ(g_freeCount, 1U);
}

TEST_F(AicpuTimeoutTest, CloseMonitorReturnsDeviceToHostCopyFailure)
{
    MockBuiltinKernelDependencies();
    g_allocResults = {{RT_ERROR_NONE, configBuffer_.data()}};
    g_memCopyResults = {RT_ERROR_NONE, RT_ERROR_DRV_ERR};
    bool closed = true;

    EXPECT_EQ(AicpuTimeoutControl::CloseAicpuMonitor(&device_, closed), RT_ERROR_DRV_ERR);
    EXPECT_FALSE(closed);
    EXPECT_EQ(g_freeCount, 1U);
}

TEST_F(AicpuTimeoutTest, LaunchAicpuBuiltinKernelOnlyLaunchesTask)
{
    MOCKER(StreamLaunchCpuKernel).stubs().will(invoke(LaunchCpuKernelStub));
    EXPECT_EQ(
        AicpuTimeoutControl::LaunchAicpuBuiltinKernel(&stream_, "kernel", configBuffer_.data(), 4U), RT_ERROR_NONE);
    EXPECT_EQ(g_launchStream, &stream_);
}

TEST_F(AicpuTimeoutTest, LaunchBuiltinKernelUsesCtrlSqStreamWhenAvailable)
{
    SetDeviceCtrlSqSupported(true);
    device_.ctrlSQ_ = std::make_unique<CtrlSQ>(&device_);
    device_.ctrlSQ_->stream_ = &ctrlSqStream_;
    MockBuiltinKernelDependencies();
    MOCKER_CPP_VIRTUAL(&ctrlSqStream_, &Stream::Synchronize).stubs().will(invoke(StreamSynchronizeStub));
    g_allocResults = {
        {RT_ERROR_NONE, nameBuffer_.data()},
        {RT_ERROR_NONE, resultBuffer_.data()},
        {RT_ERROR_NONE, configBuffer_.data()}};
    bool supported = false;

    EXPECT_EQ(AicpuTimeoutControl::CheckKernelSupported(&device_, "kernel", supported), RT_ERROR_NONE);
    EXPECT_EQ(g_launchStream, &ctrlSqStream_);
    EXPECT_TRUE(supported);
}
