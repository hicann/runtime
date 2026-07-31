/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "driver/ascend_hal.h"
#include "securec.h"
#include "runtime/rt.h"
#include "runtime/event.h"
#include "runtime/mem.h"
#include "runtime/rts/rts_mem.h"
#include "runtime/rt_inner_mem.h"
#define private public
#define protected public
#include "runtime.hpp"
#include "api.hpp"
#include "api_impl.hpp"
#include "api_impl_david.hpp"
#include "context.hpp"
#include "raw_device.hpp"
#include "npu_driver.hpp"
#include "device_state_callback_manager.hpp"
#undef protected
#undef private

#include "api_error.hpp"
#include "event.hpp"
#include "stream.hpp"
#include "notify.hpp"
#include "count_notify.hpp"
#include "thread_local_container.hpp"
#include "../../rt_utest_config_define.hpp"
#include "stub/hal_stub.h"
#include "rt_utest_david_fixture_helper.h"

using namespace testing;
using namespace cce::runtime;

class IpcMemDavidTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        MOCKER(halGetDeviceInfo).stubs().will(invoke(stubDavidGetDeviceInfo));
        char* socVer = "Ascend950PR_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend950PR_9599")), mockcpp::any())
            .will(returnValue(DRV_ERROR_NONE));
        std::cout << "IpcMemDavidTest SetUP" << std::endl;
        Runtime* rtInstance = (Runtime*)Runtime::Instance();
        rtInstance->SetDisableThread(true);
        originType_ = rtInstance->GetChipType();
        rtInstance->SetConnectUbFlag(true);
        std::cout << "IpcMemDavidTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        Runtime* rtInstance = (Runtime*)Runtime::Instance();
        rtInstance->SetChipType(originType_);
        GlobalContainer::SetRtChipType(originType_);
        rtInstance->SetDisableThread(false);
        rtInstance->SetConnectUbFlag(false);
        std::cout << "IpcMemDavidTest end" << std::endl;
    }

    virtual void SetUp()
    {
        GlobalMockObject::reset();
        Driver* driver = MockDavidDriverSetup();

        MOCKER_CPP_VIRTUAL(driver, &Driver::GetRunMode).stubs().will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

        bool enable = false;
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqEnable)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(enable))
            .will(returnValue(RT_ERROR_NONE));

        MOCKER_CPP_VIRTUAL(driver, &Driver::EnableSq).stubs().will(returnValue(RT_ERROR_NONE));
        SetupDavidDeviceAndEngine(device_, engine_);

        rtError_t res = rtSetDevice(0);
        EXPECT_EQ(res, RT_ERROR_NONE);
    }

    virtual void TearDown()
    {
        rtError_t res = rtDeviceReset(0);
        EXPECT_EQ(res, RT_ERROR_NONE);

        // Clean up IPC memory name map for test isolation
        std::unordered_map<std::string, ipcMemInfo_t>& ipcMemNameMap = Runtime::Instance()->GetIpcMemNameMap();
        std::mutex& ipcMemNameLock = Runtime::Instance()->GetIpcMemNameLock();
        ipcMemNameLock.lock();
        ipcMemNameMap.clear();
        ipcMemNameLock.unlock();

        GlobalMockObject::verify();
    }

    static rtChipType_t originType_;
    static Device* device_;
    static Engine* engine_;
};

rtChipType_t IpcMemDavidTest::originType_ = CHIP_DAVID;
Device* IpcMemDavidTest::device_ = nullptr;
Engine* IpcMemDavidTest::engine_ = nullptr;

TEST_F(IpcMemDavidTest, IpcMemNameMap_set_attr_once_import_multiple_times)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // Mock CheckIpcMapRoute for IPC V2
    Driver* driver = device_->Driver_();
    MOCKER_CPP_VIRTUAL(driver, &Driver::CheckIpcMapRoute).stubs().will(returnValue(RT_ERROR_NONE));

    std::unordered_map<std::string, ipcMemInfo_t>& ipcMemNameMap = Runtime::Instance()->GetIpcMemNameMap();
    std::mutex& ipcMemNameLock = Runtime::Instance()->GetIpcMemNameLock();

    const char* ipcName = "test_ipc_set_once_import_multi";
    uint64_t expectedAttr = 1;
    void* devPtr = nullptr;

    error = rtIpcSetMemoryAttr(ipcName, 0, expectedAttr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ipcMemNameLock.lock();
    auto it = ipcMemNameMap.find(std::string(ipcName));
    EXPECT_NE(it, ipcMemNameMap.end());
    EXPECT_EQ(it->second.latestAttr, expectedAttr);
    EXPECT_EQ(it->second.vaList.size(), 0);
    ipcMemNameLock.unlock();

    for (int round = 0; round < 5; round++) {
        error = rtsIpcMemImportByKey(&devPtr, ipcName, 0);
        EXPECT_EQ(error, RT_ERROR_NONE);

        ipcMemNameLock.lock();
        it = ipcMemNameMap.find(std::string(ipcName));
        EXPECT_NE(it, ipcMemNameMap.end());
        EXPECT_EQ(it->second.latestAttr, expectedAttr);
        EXPECT_EQ(it->second.vaList.size(), round + 1);
        ipcMemNameLock.unlock();
    }

    ipcMemNameLock.lock();
    auto finalIt = ipcMemNameMap.find(std::string(ipcName));
    EXPECT_NE(finalIt, ipcMemNameMap.end());
    EXPECT_EQ(finalIt->second.latestAttr, expectedAttr);
    EXPECT_EQ(finalIt->second.vaList.size(), 5);
    ipcMemNameLock.unlock();

    error = rtsIpcMemClose(ipcName);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ipcMemNameLock.lock();
    EXPECT_NE(ipcMemNameMap.find(std::string(ipcName)), ipcMemNameMap.end());
    ipcMemNameMap.clear();
    ipcMemNameLock.unlock();

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(IpcMemDavidTest, IpcMemNameVaMap_import_without_set_attr_default_zero)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    std::unordered_map<std::string, ipcMemInfo_t>& ipcMemNameMap = Runtime::Instance()->GetIpcMemNameMap();
    std::mutex& ipcMemNameLock = Runtime::Instance()->GetIpcMemNameLock();

    const char* ipcName = "test_ipc_import_without_set";
    uint64_t expectedDefaultAttr = 0;
    void* devPtr = nullptr;

    ipcMemNameLock.lock();
    auto preCheck = ipcMemNameMap.find(std::string(ipcName));
    EXPECT_EQ(preCheck, ipcMemNameMap.end());
    ipcMemNameLock.unlock();

    for (int round = 0; round < 5; round++) {
        error = rtsIpcMemImportByKey(&devPtr, ipcName, 0);
        EXPECT_EQ(error, RT_ERROR_NONE);

        ipcMemNameLock.lock();
        auto it = ipcMemNameMap.find(std::string(ipcName));
        EXPECT_NE(it, ipcMemNameMap.end());
        EXPECT_EQ(it->second.latestAttr, expectedDefaultAttr);
        EXPECT_EQ(it->second.vaList.size(), round + 1);
        ipcMemNameLock.unlock();
    }

    ipcMemNameLock.lock();
    auto finalIt = ipcMemNameMap.find(std::string(ipcName));
    EXPECT_NE(finalIt, ipcMemNameMap.end());
    EXPECT_EQ(finalIt->second.latestAttr, expectedDefaultAttr);
    EXPECT_EQ(finalIt->second.vaList.size(), 5);
    ipcMemNameLock.unlock();

    error = rtsIpcMemClose(ipcName);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ipcMemNameLock.lock();
    auto closeIt = ipcMemNameMap.find(std::string(ipcName));
    EXPECT_NE(closeIt, ipcMemNameMap.end());
    EXPECT_EQ(closeIt->second.vaList.size(), 4); // After closing one, there should be 4 remaining
    ipcMemNameMap.clear();                       // Clear the map to ensure test isolation
    ipcMemNameLock.unlock();

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(IpcMemDavidTest, IpcMemNameMap_close_ipc_entries_sequentially)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Driver* driver = device_->Driver_();
    MOCKER_CPP_VIRTUAL(driver, &Driver::CheckIpcMapRoute).stubs().will(returnValue(RT_ERROR_NONE));

    std::unordered_map<std::string, ipcMemInfo_t>& ipcMemNameMap = Runtime::Instance()->GetIpcMemNameMap();
    std::mutex& ipcMemNameLock = Runtime::Instance()->GetIpcMemNameLock();

    void* devPtr1 = nullptr;
    void* devPtr2 = nullptr;
    void* devPtr3 = nullptr;

    error = rtsIpcMemImportByKey(&devPtr1, "ipc_close_test_1", 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsIpcMemImportByKey(&devPtr2, "ipc_close_test_2", 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtIpcSetMemoryAttr("ipc_close_test_3", 0, 1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsIpcMemImportByKey(&devPtr3, "ipc_close_test_3", 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    ipcMemNameLock.lock();
    EXPECT_EQ(ipcMemNameMap.size(), 3);
    ipcMemNameLock.unlock();

    error = rtsIpcMemClose("ipc_close_test_1");
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsIpcMemClose("ipc_close_test_2");
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsIpcMemClose("ipc_close_test_3");
    EXPECT_EQ(error, RT_ERROR_NONE);

    ipcMemNameLock.lock();
    EXPECT_EQ(ipcMemNameMap.find("ipc_close_test_3"), ipcMemNameMap.end());
    EXPECT_EQ(ipcMemNameMap.size(), 0);
    ipcMemNameLock.unlock();

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(IpcMemDavidTest, CheckIpcMapRoute_fail)
{
    rtError_t error;
    NpuDriver* rawDrv = new NpuDriver();

    MOCKER(halShmemMapRouteCheck).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rawDrv->CheckIpcMapRoute("test", 1, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_INPUT);

    delete rawDrv;
}

TEST_F(IpcMemDavidTest, CheckIpcMapRoute_not_exist)
{
    rtError_t error;
    NpuDriver* rawDrv = new NpuDriver();

    MOCKER(halShmemMapRouteCheck).stubs().will(returnValue(DRV_ERROR_NOT_EXIST));
    error = rawDrv->CheckIpcMapRoute("test", 1, 0);
    EXPECT_EQ(error, RT_ERROR_DRV_LINK_TYPE_NOT_SUPPORTED);

    delete rawDrv;
}

TEST_F(IpcMemDavidTest, CheckIpcMapRoute_success)
{
    rtError_t error;
    NpuDriver* rawDrv = new NpuDriver();

    error = rawDrv->CheckIpcMapRoute("test", 1, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete rawDrv;
}

TEST_F(IpcMemDavidTest, IpcMemNameVaMap_close_memory)
{
    const char* ipcName = "aaa";
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    std::unordered_map<std::string, ipcMemInfo_t>& ipcMemNameMap = Runtime::Instance()->GetIpcMemNameMap();
    std::mutex& ipcMemNameLock = Runtime::Instance()->GetIpcMemNameLock();

    uint64_t va = 1;
    uint64_t attr = 2;
    ipcMemNameLock.lock();
    ipcMemNameMap.emplace(ipcName, ipcMemInfo_t{attr, {va}});
    ipcMemNameLock.unlock();

    error = rtIpcCloseMemory(RtValueToPtr<void*>(va));
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(IpcMemDavidTest, close_memory_with_no_va)
{
    const char* ipcName = "aaa";
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint64_t va = 1;
    error = rtIpcCloseMemory(RtValueToPtr<void*>(va));
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtDeviceReset(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
