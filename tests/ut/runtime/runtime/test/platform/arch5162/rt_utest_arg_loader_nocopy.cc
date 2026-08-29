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
#include <string>
#include <vector>

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "api.hpp"
#include "npu_driver.hpp"
#include "raw_device.hpp"
#include "runtime.hpp"
#include "stars_arg_manager.hpp"
#include "stream.hpp"
#include "thread_local_container.hpp"
#include "uma_arg_loader.hpp"

using namespace cce::runtime;
using namespace testing;

namespace {
struct AllocResult {
    rtError_t error;
    void* addr;
};

std::array<uint8_t, 128U * 1024U> g_deviceMemory{};
std::array<uint8_t, 1024U> g_valueMemory{};
std::array<uint8_t, 1024U> g_streamIdMemory{};
std::deque<AllocResult> g_allocResults;
std::deque<rtError_t> g_copyResults;
uint32_t g_freeCount = 0U;
uint32_t g_pcieBarCapability = RT_CAPABILITY_NOT_SUPPORT;

rtError_t DevMemAllocForArgLoader(
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

    if (!g_allocResults.empty()) {
        const AllocResult result = g_allocResults.front();
        g_allocResults.pop_front();
        if (result.error == RT_ERROR_NONE) {
            *dptr = result.addr;
        }
        return result.error;
    }
    *dptr = g_deviceMemory.data();
    return RT_ERROR_NONE;
}

rtError_t DevMemFreeForArgLoader(Driver* drv, void* dptr, uint32_t deviceId)
{
    UNUSED(drv);
    UNUSED(dptr);
    UNUSED(deviceId);
    ++g_freeCount;
    return RT_ERROR_NONE;
}

rtError_t MemCopySyncForArgLoader(
    Driver* drv, void* dst, uint64_t destMax, const void* src, uint64_t size, rtMemcpyKind_t kind, bool errShow,
    uint32_t devId)
{
    UNUSED(drv);
    UNUSED(kind);
    UNUSED(errShow);
    UNUSED(devId);
    if (!g_copyResults.empty()) {
        const rtError_t error = g_copyResults.front();
        g_copyResults.pop_front();
        if (error != RT_ERROR_NONE) {
            return error;
        }
    }
    if ((dst == nullptr) || (src == nullptr) || (size > destMax)) {
        return RT_ERROR_INVALID_VALUE;
    }
    (void)std::memcpy(dst, src, static_cast<size_t>(size));
    return RT_ERROR_NONE;
}

rtError_t CheckSupportPcieBarCopyForArgLoader(
    Driver* drv, const uint32_t deviceId, uint32_t& val, const bool need4KAsync)
{
    UNUSED(drv);
    UNUSED(deviceId);
    UNUSED(need4KAsync);
    val = g_pcieBarCapability;
    return RT_ERROR_NONE;
}
} // namespace

class Arch5162ArgLoaderTest : public Test {
protected:
    void SetUp() override
    {
        g_allocResults.clear();
        g_copyResults.clear();
        g_freeCount = 0U;
        g_pcieBarCapability = RT_CAPABILITY_NOT_SUPPORT;

        device_.driver_ = &driver_;
        DevProperties properties = {};
        properties.argsItemSize = 64U;
        properties.argInitCountSize = 2U;
        properties.argsAllocatorSize = 2U;
        properties.superArgAllocatorSize = 2U;
        properties.maxArgAllocatorSize = 2U;
        properties.handleAllocatorSize = 4U;
        properties.kernelInfoAllocatorSize = 4U;
        properties.maxSupportTaskNum = 8U;
        properties.rtsqDepth = 1024U;
        device_.RefreshDevProperties(properties);

        oldGlobalChipType_ = GlobalContainer::GetRtChipType();
        GlobalContainer::SetRtChipType(CHIP_5162A);
        runtime_ = Runtime::Instance();
        ASSERT_NE(runtime_, nullptr);
        oldChipType_ = runtime_->GetChipType();
        runtime_->SetChipType(CHIP_5162A);
        oldConnectUbFlag_ = runtime_->GetConnectUbFlag();
        oldAicpuCnt_ = runtime_->GetAicpuCnt();
        runtime_->SetConnectUbFlag(false);
        runtime_->SetAicpuCnt(0);

        Driver* const driver = &driver_;
        MOCKER_CPP_VIRTUAL(driver, &Driver::DevMemAlloc).stubs().will(invoke(DevMemAllocForArgLoader));
        MOCKER_CPP_VIRTUAL(driver, &Driver::DevMemFree).stubs().will(invoke(DevMemFreeForArgLoader));
        MOCKER_CPP_VIRTUAL(driver, &Driver::MemCopySync).stubs().will(invoke(MemCopySyncForArgLoader));
        MOCKER_CPP_VIRTUAL(driver, &Driver::CheckSupportPcieBarCopy)
            .stubs()
            .will(invoke(CheckSupportPcieBarCopyForArgLoader));
    }

    void TearDown() override
    {
        device_.argLoader_ = nullptr;
        device_.driver_ = nullptr;
        runtime_->SetConnectUbFlag(oldConnectUbFlag_);
        runtime_->SetAicpuCnt(oldAicpuCnt_);
        runtime_->SetChipType(oldChipType_);
        GlobalContainer::SetRtChipType(oldGlobalChipType_);
        GlobalMockObject::verify();
    }

    void DetachStream(Stream& stream)
    {
        stream.switchNArg_.clear();
        stream.device_ = nullptr;
    }

    NpuDriver driver_;
    RawDevice device_{0U};
    Runtime* runtime_{nullptr};
    rtChipType_t oldGlobalChipType_{CHIP_BEGIN};
    rtChipType_t oldChipType_{CHIP_BEGIN};
    bool oldConnectUbFlag_{false};
    int64_t oldAicpuCnt_{0};
};

TEST_F(Arch5162ArgLoaderTest, StubInterfacesReturnFeatureNotSupport)
{
    UmaArgLoader loader(&device_);
    rtArgsEx_t argsInfo = {};
    rtAicpuArgsEx_t aicpuArgsInfo = {};
    ArgLoaderResult result = {};
    bool mixOpt = false;

    EXPECT_EQ(loader.AllocCopyPtrWithGenericPolicy(64U, &result), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(loader.LoadForMix(&argsInfo, nullptr, &result, mixOpt), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(loader.Load(&argsInfo, nullptr, &result), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(loader.PureLoad(64U, &result, &result), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(loader.LoadCpuKernelArgs(&argsInfo, nullptr, &result), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(loader.LoadCpuKernelArgsEx(&aicpuArgsInfo, nullptr, &result), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(loader.AllocCopyPtrWithSpecificPolicy(64U, LoadPolicy::LP_NO_MIX, &result), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(loader.GetKernelInfoDevAddr(nullptr, SO_NAME, nullptr), RT_ERROR_KERNEL_NAME);
    EXPECT_EQ(loader.GetKernelInfoDevAddr("invalid", MAX_NAME, nullptr), RT_ERROR_KERNEL_TYPE);
    loader.RestoreAiCpuKernelInfo();
    EXPECT_FALSE(loader.CheckPcieBar());
}

TEST_F(Arch5162ArgLoaderTest, InitAndNoCopyHandleLifecycle)
{
    const uint32_t featureIndex = static_cast<uint32_t>(RtOptionalFeatureType::RT_FEATURE_KERNEL_UMA_SUPER_ARGS_ALLOC);
    device_.featureSet_[featureIndex] = true;
    UmaArgLoader loader(&device_);

    ASSERT_EQ(loader.Init(), RT_ERROR_NONE);
    EXPECT_NE(loader.GetArgsAllocator(), nullptr);
    EXPECT_NE(loader.GetSuperArgsAllocator(), nullptr);
    EXPECT_NE(loader.GetMaxArgsAllocator(), nullptr);
    EXPECT_NE(loader.GetRandomAllocator(), nullptr);
    EXPECT_FALSE(loader.CheckPcieBar());

    void* const buffer = loader.MallocBuffer(64U, &device_);
    EXPECT_NE(buffer, nullptr);
    loader.FreeBuffer(buffer, &device_);

    uint32_t hostArgs = 0x1234U;
    ArgLoaderResult result = {};
    ASSERT_EQ(loader.AllocNoCopyPtr(&hostArgs, &result), RT_ERROR_NONE);
    EXPECT_EQ(result.kerArgs, &hostArgs);
    EXPECT_NE(result.handle, nullptr);
    EXPECT_EQ(result.allocatedEntrySize, 0U);
    Handle* const handle = static_cast<Handle*>(result.handle);
    EXPECT_EQ(handle->kerArgs, &hostArgs);
    EXPECT_FALSE(handle->freeArgs);
    EXPECT_EQ(loader.Release(result.handle), RT_ERROR_NONE);
    EXPECT_EQ(loader.Release(nullptr), RT_ERROR_NONE);

    Handle* const copyHandle = static_cast<Handle*>(loader.handleAllocator_->AllocItem());
    ASSERT_NE(copyHandle, nullptr);
    copyHandle->kerArgs = g_valueMemory.data();
    copyHandle->freeArgs = true;
    copyHandle->argsAlloc = loader.randomAllocator_;
    EXPECT_EQ(loader.Release(copyHandle), RT_ERROR_NONE);

    loader.argPcieBarAllocator_ = new H2DCopyMgr(&device_, COPY_POLICY_SYNC);
    EXPECT_TRUE(loader.CheckPcieBar());
    loader.TearDown();
    EXPECT_EQ(loader.handleAllocator_, nullptr);
    EXPECT_EQ(loader.kernelInfoAllocator_, nullptr);
}

TEST_F(Arch5162ArgLoaderTest, KernelInfoAddressMapping)
{
    UmaArgLoader loader(&device_);
    ASSERT_EQ(loader.Init(), RT_ERROR_NONE);

    void* soAddr = nullptr;
    ASSERT_EQ(loader.GetKernelInfoDevAddr("test_so", SO_NAME, &soAddr), RT_ERROR_NONE);
    ASSERT_NE(soAddr, nullptr);
    void* cachedAddr = nullptr;
    EXPECT_EQ(loader.GetKernelInfoDevAddr("test_so", SO_NAME, &cachedAddr), RT_ERROR_NONE);
    EXPECT_EQ(cachedAddr, soAddr);

    void* kernelAddr = nullptr;
    ASSERT_EQ(loader.GetKernelInfoDevAddr("test_kernel", KERNEL_NAME, &kernelAddr), RT_ERROR_NONE);
    std::string name;
    loader.GetKernelInfoFromAddr(name, SO_NAME, soAddr);
    EXPECT_EQ(name, "test_so");
    name.clear();
    loader.GetKernelInfoFromAddr(name, KERNEL_NAME, kernelAddr);
    EXPECT_EQ(name, "test_kernel");
    loader.GetKernelInfoFromAddr(name, MAX_NAME, kernelAddr);

    std::string longName(KERNEL_INFO_ENTRY_SIZE, 'x');
    void* longNameAddr = nullptr;
    EXPECT_EQ(loader.GetKernelInfoDevAddr(longName.c_str(), KERNEL_NAME, &longNameAddr), RT_ERROR_NONE);
    EXPECT_NE(longNameAddr, nullptr);

    g_copyResults.push_back(RT_ERROR_DRV_ERR);
    void* failedAddr = nullptr;
    EXPECT_EQ(loader.GetKernelInfoDevAddr("copy_failure", SO_NAME, &failedAddr), RT_ERROR_DRV_ERR);
}

TEST_F(Arch5162ArgLoaderTest, LoadStreamSwitchNArgsSuccess)
{
    UmaArgLoader loader(&device_);
    Stream stream(&device_, 0U);
    Stream trueStream0(&device_, 0U);
    Stream trueStream1(&device_, 0U);
    stream.streamId_ = 1;
    trueStream0.streamId_ = 2;
    trueStream1.streamId_ = 3;
    Stream* trueStreams[] = {&trueStream0, &trueStream1};
    int32_t values[] = {10, 20};
    StreamSwitchNLoadResult result = {};

    g_allocResults.push_back({RT_ERROR_NONE, g_valueMemory.data()});
    g_allocResults.push_back({RT_ERROR_NONE, g_streamIdMemory.data()});
    ASSERT_EQ(
        loader.LoadStreamSwitchNArgs(&stream, values, 2U, trueStreams, 2U, RT_SWITCH_INT32, &result), RT_ERROR_NONE);
    EXPECT_EQ(result.valuePtr, g_valueMemory.data());
    EXPECT_EQ(result.trueStreamPtr, g_streamIdMemory.data());

    int64_t value64 = 30;
    g_allocResults.push_back({RT_ERROR_NONE, g_valueMemory.data()});
    g_allocResults.push_back({RT_ERROR_NONE, g_streamIdMemory.data()});
    EXPECT_EQ(
        loader.LoadStreamSwitchNArgs(&stream, &value64, 1U, trueStreams, 1U, RT_SWITCH_INT64, &result), RT_ERROR_NONE);

    DetachStream(trueStream1);
    DetachStream(trueStream0);
    DetachStream(stream);
}

TEST_F(Arch5162ArgLoaderTest, LoadStreamSwitchNArgsFailurePaths)
{
    UmaArgLoader loader(&device_);
    Stream stream(&device_, 0U);
    Stream trueStream(&device_, 0U);
    trueStream.streamId_ = 2;
    Stream* trueStreams[] = {&trueStream};
    int32_t value = 10;
    StreamSwitchNLoadResult result = {};

    g_allocResults.push_back({RT_ERROR_DRV_ERR, nullptr});
    EXPECT_EQ(
        loader.LoadStreamSwitchNArgs(&stream, &value, 1U, trueStreams, 1U, RT_SWITCH_INT32, &result), RT_ERROR_DRV_ERR);

    g_allocResults.push_back({RT_ERROR_NONE, g_valueMemory.data()});
    g_copyResults.push_back(RT_ERROR_DRV_ERR);
    EXPECT_EQ(
        loader.LoadStreamSwitchNArgs(&stream, &value, 1U, trueStreams, 1U, RT_SWITCH_INT32, &result), RT_ERROR_DRV_ERR);

    g_allocResults.push_back({RT_ERROR_NONE, g_valueMemory.data()});
    g_allocResults.push_back({RT_ERROR_DRV_ERR, nullptr});
    g_copyResults.push_back(RT_ERROR_NONE);
    EXPECT_EQ(
        loader.LoadStreamSwitchNArgs(&stream, &value, 1U, trueStreams, 1U, RT_SWITCH_INT32, &result), RT_ERROR_DRV_ERR);

    g_allocResults.push_back({RT_ERROR_NONE, g_valueMemory.data()});
    g_allocResults.push_back({RT_ERROR_NONE, g_streamIdMemory.data()});
    g_copyResults.push_back(RT_ERROR_NONE);
    g_copyResults.push_back(RT_ERROR_DRV_ERR);
    EXPECT_EQ(
        loader.LoadStreamSwitchNArgs(&stream, &value, 1U, trueStreams, 1U, RT_SWITCH_INT32, &result), RT_ERROR_DRV_ERR);
    EXPECT_GT(g_freeCount, 0U);

    DetachStream(trueStream);
    DetachStream(stream);
}

TEST_F(Arch5162ArgLoaderTest, ArgManagerNoCopyAndStubPaths)
{
    UmaArgLoader loader(&device_);
    loader.handleAllocator_ = new BufferAllocator(sizeof(Handle), 2U, 4U);
    device_.argLoader_ = &loader;
    Stream stream(&device_, 0U);
    stream.streamId_ = 7;
    PcieArgManage manager(&stream);

    EXPECT_EQ(manager.GetDevId(), 0U);
    EXPECT_EQ(manager.GetStmId(), 7);
    EXPECT_FALSE(manager.CreateArgRes());
    manager.ReleaseArgRes();
    EXPECT_FALSE(manager.RecycleStmArgPos(1U, 2U));
    uint32_t startPos = 0U;
    uint32_t endPos = 0U;
    EXPECT_FALSE(manager.AllocStmArgPos(64U, startPos, endPos));
    EXPECT_EQ(manager.GetStmArgPos(), UINT32_MAX);

    void* devAddr = nullptr;
    void* hostAddr = nullptr;
    StarsArgLoaderResult result = {};
    EXPECT_EQ(manager.MallocArgMem(devAddr, hostAddr), RT_ERROR_FEATURE_NOT_SUPPORT);
    manager.FreeArgMem();
    EXPECT_FALSE(manager.AllocStmPool(64U, &result));
    EXPECT_EQ(manager.AllocCopyPtr(64U, false, LoadPolicy::LP_GENERIC, &result), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(manager.H2DArgCopy(&result, nullptr, 64U), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(manager.LoadArgsFromArray(false, nullptr, nullptr, &result), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(manager.LoadSimtArgsFromArray(false, nullptr, nullptr, &result), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(manager.LoadSimtHostArgs(false, nullptr, &result), RT_ERROR_FEATURE_NOT_SUPPORT);

    rtArgsEx_t argsInfo = {};
    rtAicpuArgsEx_t aicpuArgsInfo = {};
    EXPECT_EQ(manager.LoadInputOutputArgs(&result, &argsInfo), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(manager.LoadInputOutputArgs(&result, &aicpuArgsInfo), RT_ERROR_FEATURE_NOT_SUPPORT);

    uint32_t hostArgs = 0x5678U;
    result.kerArgs = &hostArgs;
    ASSERT_EQ(manager.AllocNoCopyPtr(&result), RT_ERROR_NONE);
    EXPECT_EQ(result.kerArgs, &hostArgs);
    EXPECT_NE(result.handle, nullptr);
    manager.RecycleDevLoader(result.handle);

    result = {};
    result.kerArgs = &hostArgs;
    ASSERT_EQ(manager.AllocNoCopyPtr(&result), RT_ERROR_NONE);
    result.hostAddr = &hostArgs;
    manager.FreeFail(&result);
    EXPECT_EQ(result.kerArgs, nullptr);
    EXPECT_EQ(result.hostAddr, nullptr);
    EXPECT_EQ(result.handle, nullptr);
    EXPECT_EQ(result.stmArgPos, UINT32_MAX);

    argsInfo.args = &hostArgs;
    argsInfo.argsSize = sizeof(hostArgs);
    argsInfo.isNoNeedH2DCopy = 0U;
    result = {};
    EXPECT_EQ(manager.LoadArgs(&argsInfo, false, &result), RT_ERROR_FEATURE_NOT_SUPPORT);
    argsInfo.isNoNeedH2DCopy = 1U;
    result = {};
    EXPECT_EQ(manager.LoadArgs(&argsInfo, false, &result), RT_ERROR_NONE);

    DetachStream(stream);
}
