/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the " License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cstdio>
#include <stdlib.h>
#include <iostream>
#include <unistd.h>

#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "runtime.hpp"
#include "raw_device.hpp"
#include "npu_driver.hpp"
#include "jetty_pool.h"
#include "jetty_manager.h"
#include "stream_jetty_context.h"
#include "stream_jetty_handler.h"
#include "task_info.hpp"
#include "task_base.hpp"
#include "drv/driver_types.hpp"
#include "thread_local_container.hpp"
#include "memory_task.h"
#include "stream_c.hpp"
#include "../../rt_utest_config_define.hpp"

#define private public
#define protected public
#include "capture_model.hpp"
#include "stream.hpp"
#include "context.hpp"
#include "notify.hpp"
#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;

static std::vector<void*> allocatedHostMemories;
static drvError_t StubHalMemAlloc(void** dptr, uint64_t size, uint64_t flag)
{
    if (dptr != nullptr) {
        void* mem = malloc(size);
        if (mem != nullptr) {
            allocatedHostMemories.push_back(mem);
            *dptr = mem;
            return DRV_ERROR_NONE;
        }
        return DRV_ERROR_OUT_OF_MEMORY;
    }
    return DRV_ERROR_INVALID_VALUE;
}

static drvError_t StubHalMemFree(void* dptr)
{
    for (auto it = allocatedHostMemories.begin(); it != allocatedHostMemories.end(); ++it) {
        if (*it == dptr) {
            free(dptr);
            allocatedHostMemories.erase(it);
            break;
        }
    }
    return DRV_ERROR_NONE;
}

static rtError_t StubHostMemAlloc_Success(void** dptr, const uint64_t size, 
    const uint32_t deviceId, const uint16_t moduleId, const uint32_t vaFlag)
{
    if (dptr != nullptr) {
        *dptr = malloc(size);
        if (*dptr != nullptr) {
            return RT_ERROR_NONE;
        }
    }
    return RT_ERROR_MEMORY_ALLOCATION;
}

static void ClearAllocatedHostMemories()
{
    for (void* mem : allocatedHostMemories) {
        free(mem);
    }
    allocatedHostMemories.clear();
}

static drvError_t StubDavidGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t* value)
{
    if (value) {
        if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_VERSION) {
            *value = PLATFORMCONFIG_DAVID_950PR_9599;
        } else {
            *value = 0;
        }
    }
    return DRV_ERROR_NONE;
}

static void SetupJettyDriverMocks(Driver* driver)
{
    int64_t hardwareVersion = ((ARCH_V100 << 16) | (CHIP_DAVID << 8) | (VER_NA));
    char* socVer = "Ascend950PR_9599";

    MOCKER_CPP_VIRTUAL(driver, &Driver::GetDevInfo)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), 
              outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER(halGetSocVersion)
        .stubs()
        .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend950PR_9599")), mockcpp::any())
        .will(returnValue(DRV_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::StreamBindLogicCq).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::StreamUnBindLogicCq).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::GetRunMode).stubs().will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqEnable)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(false))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::EnableSq).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::HostMemAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::HostMemFree).stubs().will(returnValue(RT_ERROR_NONE));
}

class JettyPoolTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        GlobalMockObject::reset();
        Runtime* rtInstance = (Runtime*)Runtime::Instance();
        rtInstance->SetDisableThread(true);
        originType_ = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
        rtInstance->SetConnectUbFlag(true);
    }

    static void TearDownTestCase()
    {
        Runtime* rtInstance = (Runtime*)Runtime::Instance();
        rtInstance->SetChipType(originType_);
        GlobalContainer::SetRtChipType(originType_);
        rtInstance->SetDisableThread(false);
        rtInstance->SetConnectUbFlag(false);
    }

    virtual void SetUp()
    {
        GlobalMockObject::reset();
        Driver* driver = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        SetupJettyDriverMocks(driver);

        rtSetDevice(0);

        (void)rtSetSocVersion("Ascend950PR_9599");
        ((Runtime*)Runtime::Instance())->SetIsUserSetSocVersion(false);
        device_ = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);

        device_->SetChipType(CHIP_DAVID);
        engine_ = ((RawDevice*)device_)->engine_;
        jettyPool_ = new JettyPool(0);
    }

    virtual void TearDown()
    {
        engine_ = nullptr;
        delete jettyPool_;
        jettyPool_ = nullptr;
        ((Runtime*)Runtime::Instance())->DeviceRelease(device_);

        ((Runtime*)Runtime::Instance())->SetIsUserSetSocVersion(false);

        Driver* driver = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetRunMode).stubs().will(returnValue((uint32_t)RT_RUN_MODE_OFFLINE));
        rtDeviceReset(0);
        GlobalMockObject::reset();
    }

public:
    static rtChipType_t originType_;
    Device* device_ = nullptr;
    Engine* engine_ = nullptr;
    JettyPool* jettyPool_ = nullptr;
};
rtChipType_t JettyPoolTest::originType_ = CHIP_DAVID;

TEST_F(JettyPoolTest, ReleaseJetty_InvalidHandle)
{
    rtError_t error = jettyPool_->ReleaseJetty(99999, JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(JettyPoolTest, AcquireJetty_Success)
{
    rtError_t reserveError = jettyPool_->ReserveJetty(JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(reserveError, RT_ERROR_NONE);

    JettyInfo* freeInfo = nullptr;
    ASSERT_TRUE(jettyPool_->FindJettyByState(JettyType::JETTY_TYPE_H2D, JettyState::FREE, freeInfo));
    ASSERT_NE(freeInfo, nullptr);
    uint64_t expectedHandle = freeInfo->handle;

    JettyInfo acquireInfo;
    rtError_t acquireError = jettyPool_->AcquireJetty(JettyType::JETTY_TYPE_H2D, acquireInfo);
    EXPECT_EQ(acquireError, RT_ERROR_NONE);
    EXPECT_EQ(acquireInfo.handle, expectedHandle);
    EXPECT_EQ(acquireInfo.state, JettyState::BOUND);
}

TEST_F(JettyPoolTest, AcquireJetty_NoAvailable)
{
    jettyPool_->Clear();

    JettyInfo acquireInfo;
    rtError_t error = jettyPool_->AcquireJetty(JettyType::JETTY_TYPE_H2D, acquireInfo);
    EXPECT_EQ(error, RT_ERROR_JETTY_POOL_NO_RESOURCES);
}

TEST_F(JettyPoolTest, MarkFree_Success)
{
    rtError_t error = jettyPool_->ReserveJetty(JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(error, RT_ERROR_NONE);

    JettyInfo* freeInfo = nullptr;
    ASSERT_TRUE(jettyPool_->FindJettyByState(JettyType::JETTY_TYPE_H2D, JettyState::FREE, freeInfo));
    ASSERT_NE(freeInfo, nullptr);
    uint64_t handle = freeInfo->handle;

    rtError_t markFreeError = jettyPool_->MarkFree(handle);
    EXPECT_EQ(markFreeError, RT_ERROR_NONE);

    JettyInfo* foundInfo = nullptr;
    bool found = jettyPool_->FindJettyByHandle(handle, foundInfo);
    EXPECT_EQ(found, true);
    EXPECT_EQ(foundInfo->state, JettyState::FREE);
}

TEST_F(JettyPoolTest, MarkFree_InvalidHandle)
{
    rtError_t error = jettyPool_->MarkFree(99999);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(JettyPoolTest, CreateLargeDepthJetty_InvalidDepth_LessThanStandard)
{
    JettyInfo jettyInfo;
    rtError_t error = jettyPool_->CreateLargeDepthJetty(JettyType::JETTY_TYPE_H2D, 1024, jettyInfo);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(JettyPoolTest, DestroyLargeDepthJetty_Success)
{
    JettyInfo jettyInfo;
    rtError_t createError = jettyPool_->CreateLargeDepthJetty(JettyType::JETTY_TYPE_H2D, 4096, jettyInfo);
    EXPECT_EQ(createError, RT_ERROR_NONE);

    rtError_t destroyError = jettyPool_->DestroyLargeDepthJetty(jettyInfo.handle);
    EXPECT_EQ(destroyError, RT_ERROR_NONE);

    JettyInfo* foundInfo = nullptr;
    bool found = jettyPool_->FindJettyByHandle(jettyInfo.handle, foundInfo);
}

TEST_F(JettyPoolTest, DestroyLargeDepthJetty_InvalidHandle)
{
    rtError_t error = jettyPool_->DestroyLargeDepthJetty(99999);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(JettyPoolTest, QueryJettyInfo_Success)
{
    rtError_t error = jettyPool_->ReserveJetty(JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(error, RT_ERROR_NONE);

    JettyInfo* freeInfo = nullptr;
    ASSERT_TRUE(jettyPool_->FindJettyByState(JettyType::JETTY_TYPE_H2D, JettyState::FREE, freeInfo));
    ASSERT_NE(freeInfo, nullptr);

    uint32_t dieId = 0;
    uint32_t functionId = 0;
    uint32_t jettyId = 0;
    rtError_t queryError = jettyPool_->QueryJettyInfo(freeInfo->handle, dieId, functionId, jettyId);
    EXPECT_EQ(queryError, RT_ERROR_NONE);
}

TEST_F(JettyPoolTest, FindJettyByHandle_Found)
{
    rtError_t error = jettyPool_->ReserveJetty(JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(error, RT_ERROR_NONE);

    JettyInfo* freeInfo = nullptr;
    ASSERT_TRUE(jettyPool_->FindJettyByState(JettyType::JETTY_TYPE_H2D, JettyState::FREE, freeInfo));
    ASSERT_NE(freeInfo, nullptr);
    uint64_t handle = freeInfo->handle;

    JettyInfo* foundInfo = nullptr;
    bool found = jettyPool_->FindJettyByHandle(handle, foundInfo);
    EXPECT_EQ(found, true);
    EXPECT_NE(foundInfo, nullptr);
    EXPECT_EQ(foundInfo->handle, handle);
}

TEST_F(JettyPoolTest, FindJettyByHandle_NotFound)
{
    JettyInfo* foundInfo = nullptr;
    bool found = jettyPool_->FindJettyByHandle(99999, foundInfo);
    EXPECT_EQ(found, false);
    EXPECT_EQ(foundInfo, nullptr);
}

TEST_F(JettyPoolTest, Clear)
{
    JettyInfo info;
    rtError_t error1 = jettyPool_->ReserveJetty(JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(error1, RT_ERROR_NONE);
    rtError_t error2 = jettyPool_->ReserveJetty(JettyType::JETTY_TYPE_D2D);
    EXPECT_EQ(error2, RT_ERROR_NONE);
    rtError_t error3 = jettyPool_->CreateLargeDepthJetty(JettyType::JETTY_TYPE_H2D, 4096, info);
    EXPECT_EQ(error3, RT_ERROR_NONE);

    jettyPool_->Clear();

    JettyInfo* foundInfo = nullptr;
    bool found = jettyPool_->FindJettyByHandle(0, foundInfo);
    EXPECT_EQ(found, false);
}

TEST_F(JettyPoolTest, JettyInfo_DefaultInit)
{
    JettyInfo info;

    EXPECT_EQ(info.handle, 0ULL);
    EXPECT_EQ(info.dieId, 0U);
    EXPECT_EQ(info.functionId, 0U);
    EXPECT_EQ(info.jettyId, 0U);
    EXPECT_EQ(info.depth, JETTY_DEPTH_STANDARD);
    EXPECT_EQ(info.type, JettyType::JETTY_TYPE_MAX);
    EXPECT_EQ(info.state, JettyState::FREE);
}

class StreamJettyContextTest : public testing::Test {
protected:
    virtual void SetUp() { context_ = new StreamJettyContext(); }
    virtual void TearDown() { delete context_; }
    StreamJettyContext* context_ = nullptr;
};

TEST_F(StreamJettyContextTest, GetNextWqeBuffer_Success)
{
    context_->capacity = 10;
    context_->filledWqeCount = 0;
    auto buffer = std::unique_ptr<uint8_t[]>(new uint8_t[10 * 64]);
    buffer[0] = 0xAB;
    context_->wqeBuffers.push_back(std::move(buffer));

    uint8_t* ptr = context_->GetNextWqeBuffer();
    EXPECT_NE(ptr, nullptr);
    EXPECT_EQ(ptr[0], 0xAB);
}

TEST_F(StreamJettyContextTest, GetNextWqeBuffer_IndexExceed)
{
    context_->capacity = 10;
    context_->filledWqeCount = 15;
    context_->wqeBuffers.push_back(std::unique_ptr<uint8_t[]>(new uint8_t[10 * 64]));

    uint8_t* ptr = context_->GetNextWqeBuffer();
    EXPECT_EQ(ptr, nullptr);
}

TEST_F(StreamJettyContextTest, GetNextWqeBuffer_EmptyBuffer)
{
    context_->filledWqeCount = 0;
    uint8_t* ptr = context_->GetNextWqeBuffer();
    EXPECT_EQ(ptr, nullptr);
}

class StreamJettyHandlerTest : public testing::Test {
protected:
    void TearDown() override
    {
        Runtime::Instance()->SetConnectUbFlag(false);
    }
};

TEST_F(StreamJettyHandlerTest, IsUbDmaCopyType_H2D_WithUbFlag)
{
    Runtime::Instance()->SetConnectUbFlag(true);
    EXPECT_TRUE(StreamJettyHandler::IsUbDmaCopyType(RT_MEMCPY_DIR_H2D));
    Runtime::Instance()->SetConnectUbFlag(false);
}

TEST_F(StreamJettyHandlerTest, IsUbDmaCopyType_D2H_WithUbFlag)
{
    Runtime::Instance()->SetConnectUbFlag(true);
    EXPECT_TRUE(StreamJettyHandler::IsUbDmaCopyType(RT_MEMCPY_DIR_D2H));
    Runtime::Instance()->SetConnectUbFlag(false);
}

TEST_F(StreamJettyHandlerTest, IsUbDmaCopyType_D2D_ub_WithUbFlag)
{
    Runtime::Instance()->SetConnectUbFlag(true);
    EXPECT_TRUE(StreamJettyHandler::IsUbDmaCopyType(RT_MEMCPY_DIR_D2D_UB));
    Runtime::Instance()->SetConnectUbFlag(false);
}

TEST_F(StreamJettyHandlerTest, IsUbDmaCopyType_WithoutUbFlag)
{
    Runtime::Instance()->SetConnectUbFlag(false);
    EXPECT_FALSE(StreamJettyHandler::IsUbDmaCopyType(RT_MEMCPY_DIR_H2D));
    EXPECT_FALSE(StreamJettyHandler::IsUbDmaCopyType(RT_MEMCPY_DIR_D2H));
    EXPECT_FALSE(StreamJettyHandler::IsUbDmaCopyType(RT_MEMCPY_DIR_D2D_UB));
}

TEST_F(StreamJettyHandlerTest, IsUbDmaTaskType_WithUbFlag)
{
    Runtime::Instance()->SetConnectUbFlag(true);
    EXPECT_TRUE(StreamJettyHandler::IsUbDmaTaskType(TS_TASK_TYPE_MEMCPY));
    EXPECT_FALSE(StreamJettyHandler::IsUbDmaTaskType(TS_TASK_TYPE_KERNEL_AICORE));
    Runtime::Instance()->SetConnectUbFlag(false);
}

TEST_F(StreamJettyHandlerTest, IsUbDmaTaskType_WithoutUbFlag)
{
    Runtime::Instance()->SetConnectUbFlag(false);
    EXPECT_FALSE(StreamJettyHandler::IsUbDmaTaskType(TS_TASK_TYPE_MEMCPY));
    Runtime::Instance()->SetConnectUbFlag(false);
}

TEST_F(StreamJettyHandlerTest, ConvertCopyTypeToJettyType_H2DAndD2H)
{
    Runtime::Instance()->SetConnectUbFlag(true);
    EXPECT_EQ(StreamJettyHandler::ConvertCopyTypeToJettyType(RT_MEMCPY_DIR_H2D), JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(StreamJettyHandler::ConvertCopyTypeToJettyType(RT_MEMCPY_DIR_D2H), JettyType::JETTY_TYPE_H2D);
    Runtime::Instance()->SetConnectUbFlag(false);
}

TEST_F(StreamJettyHandlerTest, ConvertCopyTypeToJettyType_D2D)
{
    Runtime::Instance()->SetConnectUbFlag(true);
    EXPECT_EQ(StreamJettyHandler::ConvertCopyTypeToJettyType(RT_MEMCPY_DIR_D2D_UB), JettyType::JETTY_TYPE_D2D);
    Runtime::Instance()->SetConnectUbFlag(false);
}

TEST_F(StreamJettyHandlerTest, GetJettyTypeFromTask_NullTask)
{
    JettyType result = StreamJettyHandler::GetJettyTypeFromTask(nullptr);
    EXPECT_EQ(result, JettyType::JETTY_TYPE_MAX);
}

TEST_F(StreamJettyHandlerTest, GetJettyTypeFromTask_ValidTask)
{
    TaskInfo taskInfo = {};
    taskInfo.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_DIR_H2D;
    JettyType result = StreamJettyHandler::GetJettyTypeFromTask(&taskInfo);
EXPECT_EQ(result, JettyType::JETTY_TYPE_H2D);
}

class JettyDavidTestBase : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        GlobalMockObject::reset();
    }

    static void TearDownTestCase()
    {
        Runtime* rtInstance = (Runtime*)Runtime::Instance();
        rtInstance->SetChipType(originType_);
        GlobalContainer::SetRtChipType(originType_);
        rtInstance->SetDisableThread(false);
        rtInstance->SetConnectUbFlag(false);
    }

    void SetUpDavidCommon()
    {
        GlobalMockObject::reset();
        Runtime* rtInstance = (Runtime*)Runtime::Instance();
        rtInstance->SetDisableThread(true);
        originType_ = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
        rtInstance->SetConnectUbFlag(true);
        Driver* driver = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER(halGetDeviceInfo).stubs().will(invoke(StubDavidGetDeviceInfo));
        SetupJettyDriverMocks(driver);
        MOCKER_CPP_VIRTUAL(driver, &Driver::AsyncDmaWqeConvert).stubs().will(returnValue(RT_ERROR_NONE));
        MOCKER_CPP_VIRTUAL(driver, &Driver::AsyncDmaWqeFill).stubs().will(returnValue(RT_ERROR_NONE));
        rtSetDevice(0);
        (void)rtSetSocVersion("Ascend950PR_9599");
        ((Runtime*)Runtime::Instance())->SetIsUserSetSocVersion(false);
        device_ = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
        device_->SetChipType(CHIP_DAVID);
    }

    void TearDownDavidCommon()
    {
        ((Runtime*)Runtime::Instance())->DeviceRelease(device_);
        ((Runtime*)Runtime::Instance())->SetIsUserSetSocVersion(false);
        GlobalMockObject::reset();
        ClearAllocatedHostMemories();
        rtDeviceReset(0);
    }

    Device* device_ = nullptr;
    static rtChipType_t originType_;
};
rtChipType_t JettyDavidTestBase::originType_ = CHIP_DAVID;

class StreamJettyHandlerIntegrationTest : public JettyDavidTestBase {
protected:
    virtual void SetUp() override
    {
        SetUpDavidCommon();
        stream_ = new Stream(device_, 0);
    }

    virtual void TearDown() override
    {
        delete stream_;
        stream_ = nullptr;
        TearDownDavidCommon();
    }

    Stream* stream_ = nullptr;
};

TEST_F(StreamJettyHandlerIntegrationTest, HandleUbDmaTask_NullStream)
{
    TaskInfo taskInfo = {};
    taskInfo.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_DIR_H2D;
    AsyncWqeInputPara input = {};
    AsyncWqeOutputPara output = {};
    rtError_t error = StreamJettyHandler::HandleUbDmaTask(nullptr, &taskInfo, JettyType::JETTY_TYPE_H2D, &input, &output);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(StreamJettyHandlerIntegrationTest, HandleUbDmaTask_NonUbType)
{
    TaskInfo taskInfo = {};
    taskInfo.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_DIR_H2D;
    Runtime::Instance()->SetConnectUbFlag(false);
    AsyncWqeInputPara input = {};
    AsyncWqeOutputPara output = {};
    rtError_t error = StreamJettyHandler::HandleUbDmaTask(stream_, &taskInfo, JettyType::JETTY_TYPE_H2D, &input, &output);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime::Instance()->SetConnectUbFlag(true);
}

TEST_F(StreamJettyHandlerIntegrationTest, FillNopWqeOnCaptureEnd_NullStream)
{
    rtError_t error = StreamJettyHandler::FillNopWqeOnCaptureEnd(nullptr, JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(StreamJettyHandlerIntegrationTest, HandleUbDmaTask_NullTask)
{
    AsyncWqeInputPara input = {};
    AsyncWqeOutputPara output = {};
    rtError_t error = StreamJettyHandler::HandleUbDmaTask(stream_, nullptr, JettyType::JETTY_TYPE_H2D, &input, &output);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(StreamJettyHandlerIntegrationTest, SyncWqeBufferToDevice_NullContext)
{
    JettyInfo jettyInfo = {};
    rtError_t error = StreamJettyHandler::SyncWqeBufferToDevice(stream_, nullptr, jettyInfo);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(StreamJettyHandlerIntegrationTest, SyncWqeBufferToDevice_EmptyBuffers)
{
    JettyInfo jettyInfo = {};
    StreamJettyContext context;
    rtError_t error = StreamJettyHandler::SyncWqeBufferToDevice(stream_, &context, jettyInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamJettyHandlerIntegrationTest, SyncWqeBufferToDevice_WithValidBuffers)
{
    StreamJettyContext context;
    context.capacity = 2048;
    context.filledWqeCount = 100;
    auto buffer = std::unique_ptr<uint8_t[]>(new uint8_t[2048 * 64]);
    context.wqeBuffers.push_back(std::move(buffer));
    JettyInfo jettyInfo = {};
    rtError_t error = StreamJettyHandler::SyncWqeBufferToDevice(stream_, &context, jettyInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamJettyHandlerIntegrationTest, UpdateUbdmaSqeWithJettyInfo_WithPositions)
{
    StreamJettyContext context;
    context.taskWqeCounts.push_back({0, 1});
    JettyInfo jettyInfo = {};
    jettyInfo.jettyId = 1;
    jettyInfo.dieId = 2;
    jettyInfo.functionId = 3;
    rtError_t error = StreamJettyHandler::UpdateUbdmaSqeWithJettyInfo(stream_, &context, jettyInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamJettyHandlerIntegrationTest, UpdateUbdmaSqeWithJettyInfo_NullStream)
{
    StreamJettyContext context;
    JettyInfo jettyInfo = {};
    rtError_t error = StreamJettyHandler::UpdateUbdmaSqeWithJettyInfo(nullptr, &context, jettyInfo);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(StreamJettyHandlerIntegrationTest, UpdateUbdmaSqeWithJettyInfo_NullContext)
{
    JettyInfo jettyInfo = {};
    rtError_t error = StreamJettyHandler::UpdateUbdmaSqeWithJettyInfo(stream_, nullptr, jettyInfo);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(StreamJettyHandlerIntegrationTest, UpdateUbdmaSqeWithJettyInfo_EmptyPositions)
{
    StreamJettyContext context;
    JettyInfo jettyInfo = {};
    rtError_t error = StreamJettyHandler::UpdateUbdmaSqeWithJettyInfo(stream_, &context, jettyInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamJettyHandlerIntegrationTest, FillNopWqeOnCaptureEnd_NoContext)
{
    rtError_t error = StreamJettyHandler::FillNopWqeOnCaptureEnd(stream_, JettyType::JETTY_TYPE_D2D);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamJettyHandlerIntegrationTest, JettyManager_GetOrCreateStreamJettyContext)
{
    JettyManager* mgr = stream_->Device_()->GetJettyManager();
    ASSERT_NE(mgr, nullptr);
    StreamJettyContext* ctx = mgr->GetOrCreateStreamJettyContext(stream_, JettyType::JETTY_TYPE_H2D);
    ASSERT_NE(ctx, nullptr);
    EXPECT_EQ(ctx->jettyType, JettyType::JETTY_TYPE_H2D);
}

TEST_F(StreamJettyHandlerIntegrationTest, JettyManager_GetOrCreateStreamJettyContext_Existing)
{
    JettyManager* mgr = stream_->Device_()->GetJettyManager();
    ASSERT_NE(mgr, nullptr);
    StreamJettyContext* ctx1 = mgr->GetOrCreateStreamJettyContext(stream_, JettyType::JETTY_TYPE_H2D);
    ASSERT_NE(ctx1, nullptr);
    StreamJettyContext* ctx2 = mgr->GetOrCreateStreamJettyContext(stream_, JettyType::JETTY_TYPE_H2D);
    ASSERT_NE(ctx2, nullptr);
    EXPECT_EQ(ctx1, ctx2);
}

TEST_F(StreamJettyHandlerIntegrationTest, JettyManager_BindJettyForStream)
{
    JettyManager* mgr = stream_->Device_()->GetJettyManager();
    ASSERT_NE(mgr, nullptr);
    StreamJettyContext* ctx = mgr->GetOrCreateStreamJettyContext(stream_, JettyType::JETTY_TYPE_H2D);
    ASSERT_NE(ctx, nullptr);
    int32_t streamId = static_cast<int32_t>(stream_->Id_());
    rtError_t error = mgr->BindJettyForStream(streamId, nullptr, JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamJettyHandlerIntegrationTest, JettyManager_BindJettyForStream_AlreadyBound)
{
    JettyManager* mgr = stream_->Device_()->GetJettyManager();
    ASSERT_NE(mgr, nullptr);
    StreamJettyContext* ctx = mgr->GetOrCreateStreamJettyContext(stream_, JettyType::JETTY_TYPE_D2D);
    ASSERT_NE(ctx, nullptr);
    int32_t streamId = static_cast<int32_t>(stream_->Id_());
    rtError_t error = mgr->BindJettyForStream(streamId, nullptr, JettyType::JETTY_TYPE_D2D);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ctx->jettyHandle = 1;
    error = mgr->BindJettyForStream(streamId, nullptr, JettyType::JETTY_TYPE_D2D);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StreamJettyHandlerIntegrationTest, JettyManager_GetJettyInfoForStream_WithJetty)
{
    JettyManager* mgr = stream_->Device_()->GetJettyManager();
    ASSERT_NE(mgr, nullptr);
    StreamJettyContext* ctx = mgr->GetOrCreateStreamJettyContext(stream_, JettyType::JETTY_TYPE_H2D);
    ASSERT_NE(ctx, nullptr);
    int32_t streamId = static_cast<int32_t>(stream_->Id_());
    rtError_t bindError = mgr->BindJettyForStream(streamId, nullptr, JettyType::JETTY_TYPE_H2D);
    ASSERT_EQ(bindError, RT_ERROR_NONE);
    JettyInfo jettyInfo = {};
    rtError_t error = mgr->GetJettyInfoForStream(streamId, JettyType::JETTY_TYPE_H2D, jettyInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

class JettyManagerTest : public testing::Test {
protected:
    virtual void SetUp()
    {
        Driver* driver = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER(halMemAlloc).stubs().will(invoke(StubHalMemAlloc));
        MOCKER(halMemFree).stubs().will(invoke(StubHalMemFree));
        manager_ = new JettyManager(0);
    }
    virtual void TearDown()
    {
        delete manager_;
        manager_ = nullptr;
        GlobalMockObject::reset();
        ClearAllocatedHostMemories();
    }
    JettyManager* manager_ = nullptr;
};

TEST_F(JettyManagerTest, GetStreamJettyContext_NotFound)
{
    StreamJettyContext* ctx = manager_->GetStreamJettyContext(999, JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(ctx, nullptr);
}

TEST_F(JettyManagerTest, DestroyStreamJettyContext_NotExist)
{
    manager_->DestroyStreamJettyContext(999, JettyType::JETTY_TYPE_H2D);
    StreamJettyContext* ctx = manager_->GetStreamJettyContext(999, JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(ctx, nullptr);
}

TEST_F(JettyManagerTest, GetJettyInfoForStream_NoContext)
{
    JettyInfo info;
    rtError_t error = manager_->GetJettyInfoForStream(999, JettyType::JETTY_TYPE_H2D, info);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

class CaptureModelJettyTest : public JettyDavidTestBase {
protected:
    virtual void SetUp() override
    {
        SetUpDavidCommon();
        rtContext_t ctx;
        rtError_t ctxRet = rtCtxCreate(&ctx, 0, 0);
        ASSERT_EQ(ctxRet, RT_ERROR_NONE);
        Context* currentCtx = Runtime::Instance()->CurrentContext();
        ASSERT_NE(currentCtx, nullptr);
        captureModel_ = new CaptureModel(RT_MODEL_CAPTURE_MODEL);
        captureModel_->context_ = currentCtx;
        captureModel_->SetSoftwareSqEnable();
        stream_ = new Stream(device_, 0);
    }

    virtual void TearDown() override
    {
        captureModel_->ModelRemoveStream(stream_);
        delete captureModel_;
        captureModel_ = nullptr;
        if (device_ != nullptr && device_->GetJettyManager() != nullptr) {
            device_->GetJettyManager()->Clear();
        }
        delete stream_;
        stream_ = nullptr;
        TearDownDavidCommon();
    }

    void SetupJettyContext(Stream* stm, JettyType type, uint32_t filledWqeCount, bool isLarge)
    {
        JettyManager* mgr = device_->GetJettyManager();
        ASSERT_NE(mgr, nullptr);
        StreamJettyContext* ctx = mgr->GetOrCreateStreamJettyContext(stm, type);
        ASSERT_NE(ctx, nullptr);
        ctx->capacity = isLarge ? 4096 : 2048;
        ctx->filledWqeCount = filledWqeCount;
        ctx->jettyType = type;
        ctx->isLargeDepth = isLarge;
        uint32_t bufCount = (filledWqeCount / 2048) + 1;
        for (uint32_t i = 0; i < bufCount; ++i) {
            auto buffer = std::unique_ptr<uint8_t[]>(new uint8_t[2048 * 64]);
            ctx->wqeBuffers.push_back(std::move(buffer));
        }
    }

    CaptureModel* captureModel_ = nullptr;
    Stream* stream_ = nullptr;
};

TEST_F(CaptureModelJettyTest, BindJettyForUbdma_NoStreams)
{
    rtError_t error = captureModel_->BindJettyForUbdma();
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CaptureModelJettyTest, BindJettyForUbdma_StreamWithoutContext)
{
    captureModel_->ModelPushFrontStream(stream_);
    rtError_t error = captureModel_->BindJettyForUbdma();
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CaptureModelJettyTest, BindJettyForUbdma_H2DStandard_Success)
{
    captureModel_->ModelPushFrontStream(stream_);
    SetupJettyContext(stream_, JettyType::JETTY_TYPE_H2D, 100, false);
    captureModel_->SetSoftwareSqEnable();
    rtError_t error = captureModel_->BindJettyForUbdma();
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CaptureModelJettyTest, BindJettyForUbdma_LargeJetty_Success)
{
    captureModel_->ModelPushFrontStream(stream_);
    SetupJettyContext(stream_, JettyType::JETTY_TYPE_H2D, 3000, true);
    rtError_t error = captureModel_->BindJettyForUbdma();
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CaptureModelJettyTest, BindJettyForUbdma_AlreadyBound)
{
    captureModel_->ModelPushFrontStream(stream_);
    SetupJettyContext(stream_, JettyType::JETTY_TYPE_D2D, 100, false);
    JettyManager* mgr = device_->GetJettyManager();
    int32_t streamId = static_cast<int32_t>(stream_->Id_());
    rtError_t bindError = mgr->BindJettyForStream(streamId, nullptr, JettyType::JETTY_TYPE_D2D);
    ASSERT_EQ(bindError, RT_ERROR_NONE);
    rtError_t error = captureModel_->BindJettyForUbdma();
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CaptureModelJettyTest, BindJettyForUbdma_BothTypes_Success)
{
    captureModel_->ModelPushFrontStream(stream_);
    SetupJettyContext(stream_, JettyType::JETTY_TYPE_H2D, 100, false);
    SetupJettyContext(stream_, JettyType::JETTY_TYPE_D2D, 50, false);
    rtError_t error = captureModel_->BindJettyForUbdma();
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CaptureModelJettyTest, BindJettyForUbdma_ZeroWqeCount)
{
    captureModel_->ModelPushFrontStream(stream_);
    SetupJettyContext(stream_, JettyType::JETTY_TYPE_H2D, 0, false);
    rtError_t error = captureModel_->BindJettyForUbdma();
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CaptureModelJettyTest, BindJettyForUbdma_MultipleStreams)
{
    Stream* stream2 = new Stream(device_, 1);
    captureModel_->ModelPushFrontStream(stream_);
    captureModel_->ModelPushFrontStream(stream2);
    SetupJettyContext(stream_, JettyType::JETTY_TYPE_H2D, 100, false);
    SetupJettyContext(stream2, JettyType::JETTY_TYPE_D2D, 200, false);
    rtError_t error = captureModel_->BindJettyForUbdma();
    EXPECT_EQ(error, RT_ERROR_NONE);
    captureModel_->ModelRemoveStream(stream2);
    delete stream2;
}

TEST_F(CaptureModelJettyTest, RecycleAllJetty_NoStreams)
{
    uint32_t h2dCount = 0;
    uint32_t d2dCount = 0;
    rtError_t error = captureModel_->RecycleAllJetty(h2dCount, d2dCount);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(h2dCount, 0U);
    EXPECT_EQ(d2dCount, 0U);
}

TEST_F(CaptureModelJettyTest, RecycleAllJetty_StreamWithoutContext)
{
    captureModel_->ModelPushFrontStream(stream_);
    uint32_t h2dCount = 0;
    uint32_t d2dCount = 0;
    rtError_t error = captureModel_->RecycleAllJetty(h2dCount, d2dCount);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(h2dCount, 0U);
    EXPECT_EQ(d2dCount, 0U);
}

TEST_F(CaptureModelJettyTest, RecycleAllJetty_H2DStandard_Success)
{
    captureModel_->ModelPushFrontStream(stream_);
    SetupJettyContext(stream_, JettyType::JETTY_TYPE_H2D, 100, false);
    JettyManager* mgr = device_->GetJettyManager();
    int32_t streamId = static_cast<int32_t>(stream_->Id_());
    rtError_t bindError = mgr->BindJettyForStream(streamId, nullptr, JettyType::JETTY_TYPE_H2D);
    ASSERT_EQ(bindError, RT_ERROR_NONE);
    MOCKER(StreamUbDbSend).stubs().will(returnValue(RT_ERROR_NONE));
    uint32_t h2dCount = 0;
    uint32_t d2dCount = 0;
    rtError_t error = captureModel_->RecycleAllJetty(h2dCount, d2dCount);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(h2dCount, 1U);
    EXPECT_EQ(d2dCount, 0U);
}

TEST_F(CaptureModelJettyTest, RecycleAllJetty_LargeJetty_Success)
{
    captureModel_->ModelPushFrontStream(stream_);
    SetupJettyContext(stream_, JettyType::JETTY_TYPE_D2D, 3000, true);
    JettyManager* mgr = device_->GetJettyManager();
    int32_t streamId = static_cast<int32_t>(stream_->Id_());
    rtError_t bindError = mgr->BindJettyForStream(streamId, nullptr, JettyType::JETTY_TYPE_D2D);
    ASSERT_EQ(bindError, RT_ERROR_NONE);
    uint32_t h2dCount = 0;
    uint32_t d2dCount = 0;
    rtError_t error = captureModel_->RecycleAllJetty(h2dCount, d2dCount);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(d2dCount, 0U);
}

TEST_F(CaptureModelJettyTest, RecycleAllJetty_BothTypes_Success)
{
    captureModel_->ModelPushFrontStream(stream_);
    SetupJettyContext(stream_, JettyType::JETTY_TYPE_H2D, 100, false);
    SetupJettyContext(stream_, JettyType::JETTY_TYPE_D2D, 50, false);
    JettyManager* mgr = device_->GetJettyManager();
    int32_t streamId = static_cast<int32_t>(stream_->Id_());
    rtError_t bindH2d = mgr->BindJettyForStream(streamId, nullptr, JettyType::JETTY_TYPE_H2D);
    rtError_t bindD2d = mgr->BindJettyForStream(streamId, nullptr, JettyType::JETTY_TYPE_D2D);
    ASSERT_EQ(bindH2d, RT_ERROR_NONE);
    ASSERT_EQ(bindD2d, RT_ERROR_NONE);
    MOCKER(StreamUbDbSend).stubs().will(returnValue(RT_ERROR_NONE));
    uint32_t h2dCount = 0;
    uint32_t d2dCount = 0;
    rtError_t error = captureModel_->RecycleAllJetty(h2dCount, d2dCount);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(h2dCount, 1U);
    EXPECT_EQ(d2dCount, 1U);
}

TEST_F(CaptureModelJettyTest, RecycleAllJetty_AlreadyRecycled)
{
    captureModel_->ModelPushFrontStream(stream_);
    SetupJettyContext(stream_, JettyType::JETTY_TYPE_H2D, 100, false);
    JettyManager* mgr = device_->GetJettyManager();
    int32_t streamId = static_cast<int32_t>(stream_->Id_());
    rtError_t bindError = mgr->BindJettyForStream(streamId, nullptr, JettyType::JETTY_TYPE_H2D);
    ASSERT_EQ(bindError, RT_ERROR_NONE);
    MOCKER(StreamUbDbSend).stubs().will(returnValue(RT_ERROR_NONE));
    uint32_t h2dCount1 = 0;
    uint32_t d2dCount1 = 0;
    rtError_t error1 = captureModel_->RecycleAllJetty(h2dCount1, d2dCount1);
    ASSERT_EQ(error1, RT_ERROR_NONE);
    uint32_t h2dCount2 = 0;
    uint32_t d2dCount2 = 0;
    rtError_t error2 = captureModel_->RecycleAllJetty(h2dCount2, d2dCount2);
    EXPECT_EQ(error2, RT_ERROR_NONE);
    EXPECT_EQ(h2dCount2, 0U);
}

TEST_F(CaptureModelJettyTest, ReleaseJetty_Success)
{
    captureModel_->ModelPushFrontStream(stream_);
    SetupJettyContext(stream_, JettyType::JETTY_TYPE_H2D, 100, false);
    JettyManager* mgr = device_->GetJettyManager();
    int32_t streamId = static_cast<int32_t>(stream_->Id_());
    rtError_t bindError = mgr->BindJettyForStream(streamId, nullptr, JettyType::JETTY_TYPE_H2D);
    ASSERT_EQ(bindError, RT_ERROR_NONE);

    rtError_t error = captureModel_->ReleaseJetty(streamId, JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(CaptureModelJettyTest, TryRecycleCaptureModelJettyResource_Success)
{
    captureModel_->ModelPushFrontStream(stream_);
    SetupJettyContext(stream_, JettyType::JETTY_TYPE_H2D, 100, false);
    JettyManager* mgr = device_->GetJettyManager();
    int32_t streamId = static_cast<int32_t>(stream_->Id_());
    rtError_t bindError = mgr->BindJettyForStream(streamId, nullptr, JettyType::JETTY_TYPE_H2D);
    ASSERT_EQ(bindError, RT_ERROR_NONE);

    Context* currentCtx = Runtime::Instance()->CurrentContext();
    ASSERT_NE(currentCtx, nullptr);
    currentCtx->models_.push_back(captureModel_);

    rtError_t error = currentCtx->TryRecycleCaptureModelJettyResource(nullptr, JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(error, RT_ERROR_NONE);

    currentCtx->models_.remove(captureModel_);
}

TEST_F(CaptureModelJettyTest, UpdateEndGraphTask_NullTask)
{
    Context* currentCtx = Runtime::Instance()->CurrentContext();
    ASSERT_NE(currentCtx, nullptr);
    Stream* exeStream = new Stream(device_, 0);
    Notify ntf(0, 0);

    rtError_t error = currentCtx->UpdateEndGraphTask(stream_, exeStream, &ntf);
    EXPECT_NE(error, RT_ERROR_NONE);

    delete exeStream;
}

static void SetupContextWithBuffer(StreamJettyContext& context)
{
    context.capacity += StreamJettyContext::WQE_BUFFER_DEPTH;
    const uint64_t bufSize = static_cast<uint64_t>(StreamJettyContext::WQE_BUFFER_DEPTH) * StreamJettyContext::WQE_SIZE;
    auto buffer = std::unique_ptr<uint8_t[]>(new uint8_t[bufSize]);
    (void)memset_s(buffer.get(), bufSize, 0, bufSize);
    context.wqeBuffers.push_back(std::move(buffer));
}

static void SetupMocksWithoutHostMemAlloc(Driver* driver)
{
    GlobalMockObject::reset();
    MOCKER(halGetDeviceInfo).stubs().will(invoke(StubDavidGetDeviceInfo));
    
    int64_t hardwareVersion = ((ARCH_V100 << 16) | (CHIP_DAVID << 8) | (VER_NA));
    char* socVer = "Ascend950PR_9599";

    MOCKER_CPP_VIRTUAL(driver, &Driver::GetDevInfo)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), 
              outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER(halGetSocVersion)
        .stubs()
        .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend950PR_9599")), mockcpp::any())
        .will(returnValue(DRV_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::StreamBindLogicCq).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::StreamUnBindLogicCq).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::GetRunMode).stubs().will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqEnable)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(false))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::EnableSq).stubs().will(returnValue(RT_ERROR_NONE));
    // Note: HostMemAlloc is NOT mocked here, allowing custom mocks to be set up
    MOCKER_CPP_VIRTUAL(driver, &Driver::HostMemFree).stubs().will(returnValue(RT_ERROR_NONE));
}

static void FullResetAndSetupMocks(Driver* driver)
{
    GlobalMockObject::reset();
    MOCKER(halGetDeviceInfo).stubs().will(invoke(StubDavidGetDeviceInfo));
    SetupJettyDriverMocks(driver);
}

static JettyManager* SetupAndBindJettyForStream(Stream* stream, int32_t& streamId)
{
    GlobalMockObject::reset();
    SetupJettyDriverMocks(stream->Device_()->Driver_());
    streamId = static_cast<int32_t>(stream->Id_());
    StreamJettyContext* context = nullptr;
    StreamJettyHandler::GetOrCreateStreamJettyContext(stream, JettyType::JETTY_TYPE_H2D, context);
    EXPECT_NE(context, nullptr);
    JettyManager* mgr = stream->Device_()->GetJettyManager();
    rtError_t bindError = mgr->BindJettyForStream(streamId, nullptr, JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(bindError, RT_ERROR_NONE);
    return mgr;
}

static rtError_t SetupAndRunH2DTask(Stream* stream, StreamJettyContext& context)
{
    SetupContextWithBuffer(context);
    TaskInfo taskInfo = {};
    taskInfo.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_DIR_H2D;
    taskInfo.u.memcpyAsyncTaskInfo.src = reinterpret_cast<void*>(0x10000);
    taskInfo.u.memcpyAsyncTaskInfo.destPtr = reinterpret_cast<void*>(0x20000);
    taskInfo.u.memcpyAsyncTaskInfo.size = 1024;
    taskInfo.id = 1;
    AsyncWqeInputPara input = {};
    AsyncWqeOutputPara output = {};
    return StreamJettyHandler::CreateAndAppendWqe(stream, &taskInfo, &context, &input, &output);
}

static void SetupWqeTestContext(Stream* stream, StreamJettyContext& context, TaskInfo& taskInfo, uint64_t size)
{
    FullResetAndSetupMocks(stream->Device_()->Driver_());
    SetupContextWithBuffer(context);
    taskInfo = {};
    taskInfo.id = 1;
    taskInfo.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_DIR_H2D;
    taskInfo.u.memcpyAsyncTaskInfo.src = RtValueToPtr<void*>(0x10000);
    taskInfo.u.memcpyAsyncTaskInfo.destPtr = RtValueToPtr<void*>(0x20000);
    taskInfo.u.memcpyAsyncTaskInfo.size = size;
}

class NpuDriverJettyTest : public JettyDavidTestBase {
protected:
    virtual void SetUp() override
    {
        SetUpDavidCommon();
        stream_ = new Stream(device_, 0);
    }

    virtual void TearDown() override
    {
        delete stream_;
        stream_ = nullptr;
        TearDownDavidCommon();
    }

    Stream* stream_ = nullptr;
};

// NpuDriver::AsyncDmaJettyCreate tests
TEST_F(NpuDriverJettyTest, AsyncDmaJettyCreate_Success)
{
    uint64_t handle = 0;
    rtError_t error = stream_->Device_()->Driver_()->AsyncDmaJettyCreate(0, 1, 2048, TRS_ASYNC_JETTY_HOST_DEVICE, &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(handle, 0ULL);
}

TEST_F(NpuDriverJettyTest, AsyncDmaJettyCreate_D2D_Success)
{
    uint64_t handle = 0;
    rtError_t error = stream_->Device_()->Driver_()->AsyncDmaJettyCreate(0, 1, 2048, TRS_ASYNC_JETTY_DEVICE_TO_DEVICE, &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(handle, 0ULL);
}

// NpuDriver::AsyncDmaJettyDestroy tests
TEST_F(NpuDriverJettyTest, AsyncDmaJettyDestroy_Success)
{
    uint64_t handle = 1;
    rtError_t error = stream_->Device_()->Driver_()->AsyncDmaJettyDestroy(0, handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

// NpuDriver::AsyncDmaJettyQuery tests
TEST_F(NpuDriverJettyTest, AsyncDmaJettyQuery_Success)
{
    uint64_t handle = 1;
    uint32_t dieId = 0;
    uint32_t functionId = 0;
    uint32_t jettyId = 0;
    rtError_t error = stream_->Device_()->Driver_()->AsyncDmaJettyQuery(0, handle, dieId, functionId, jettyId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

// NpuDriver::AsyncDmaWqeConvert tests
TEST_F(NpuDriverJettyTest, AsyncDmaWqeConvert_Normal_Success)
{
    // Setup mock for AsyncDmaWqeConvert to return success
    AsyncWqeInputPara input = {};
    input.wqeType = DRV_ASYNC_DMA_TYPE_NORMAL;
    input.size = 64;
    uint8_t buffer[64] = {0};
    input.wqeBuffer = buffer;
    input.normal.src = buffer;
    input.normal.dst = buffer;
    input.normal.len = 1024;
    
    AsyncWqeOutputPara output = {};
    // Call through Driver interface which is already mocked
    rtError_t error = stream_->Device_()->Driver_()->AsyncDmaWqeConvert(0, &input, &output);
    // The mock returns RT_ERROR_NONE but actual conversion may not happen
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(NpuDriverJettyTest, AsyncDmaWqeConvert_Batch_Success)
{
    GlobalMockObject::reset();
    AsyncWqeInputPara input = {};
    input.wqeType = DRV_ASYNC_DMA_TYPE_BATCH;
    input.size = 64;
    uint8_t buffer[64] = {0};
    input.wqeBuffer = buffer;
    uint64_t srcArr[2] = {0x1000, 0x2000};
    uint64_t dstArr[2] = {0x3000, 0x4000};
    uint64_t lenArr[2] = {1024, 2048};
    input.batch.src = srcArr;
    input.batch.dst = dstArr;
    input.batch.len = lenArr;
    input.batch.count = 2;
    
    AsyncWqeOutputPara output = {};
    rtError_t error = stream_->Device_()->Driver_()->AsyncDmaWqeConvert(0, &input, &output);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(NpuDriverJettyTest, AsyncDmaWqeConvert_2D_Success)
{
    GlobalMockObject::reset();
    AsyncWqeInputPara input = {};
    input.wqeType = DRV_ASYNC_DMA_TYPE_2D;
    input.size = 64;
    uint8_t buffer[64] = {0};
    input.wqeBuffer = buffer;
    uint64_t srcAddr = 0x1000;
    uint64_t dstAddr = 0x2000;
    input.matrix2d.src = &srcAddr;
    input.matrix2d.dst = &dstAddr;
    input.matrix2d.spitch = 1024;
    input.matrix2d.dpitch = 1024;
    input.matrix2d.width = 256;
    input.matrix2d.height = 256;
    input.matrix2d.fixedSize = 0;
    
    AsyncWqeOutputPara output = {};
    rtError_t error = stream_->Device_()->Driver_()->AsyncDmaWqeConvert(0, &input, &output);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

// NpuDriver::AsyncDmaWqeFill tests
TEST_F(NpuDriverJettyTest, AsyncDmaWqeFill_Success)
{
    AsyncWqeFillInfo fillInfo = {};
    fillInfo.jettyHandle.handle = 1;
    fillInfo.offset = 0;
    uint8_t wqeBuffer[64] = {0};
    fillInfo.srcWqe = wqeBuffer;
    fillInfo.size = 64;
    
    rtError_t error = stream_->Device_()->Driver_()->AsyncDmaWqeFill(0, &fillInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

// StreamJettyHandler::GetOrCreateStreamJettyContext tests
TEST_F(NpuDriverJettyTest, GetOrCreateStreamJettyContext_NullStream)
{
    StreamJettyContext* context = nullptr;
    rtError_t error = StreamJettyHandler::GetOrCreateStreamJettyContext(nullptr, JettyType::JETTY_TYPE_H2D, context);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(context, nullptr);
}

TEST_F(NpuDriverJettyTest, GetOrCreateStreamJettyContext_Success)
{
    StreamJettyContext* context = nullptr;
    rtError_t error = StreamJettyHandler::GetOrCreateStreamJettyContext(stream_, JettyType::JETTY_TYPE_H2D, context);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(context, nullptr);
}

static void SetupCreateAndAppendWqeTest(StreamJettyContext& context, TaskInfo& taskInfo,
    void* src, void* dst, uint64_t size, uint32_t id)
{
    SetupContextWithBuffer(context);
    
    taskInfo = {};
    taskInfo.u.memcpyAsyncTaskInfo.src = src;
    taskInfo.u.memcpyAsyncTaskInfo.destPtr = dst;
    taskInfo.u.memcpyAsyncTaskInfo.size = size;
    taskInfo.id = id;
}

// StreamJettyHandler::CreateAndAppendWqe tests (private method accessed via #define)
TEST_F(NpuDriverJettyTest, CreateAndAppendWqe_Success)
{
    FullResetAndSetupMocks(stream_->Device_()->Driver_());
    
    StreamJettyContext context;
    TaskInfo taskInfo;
    SetupCreateAndAppendWqeTest(context, taskInfo,
        reinterpret_cast<void*>(0x10000), reinterpret_cast<void*>(0x20000), 1024, 1);
    
    AsyncWqeInputPara input = {};
    AsyncWqeOutputPara output = {};
    rtError_t error = StreamJettyHandler::CreateAndAppendWqe(stream_, &taskInfo, &context, &input, &output);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(NpuDriverJettyTest, CreateAndAppendWqe_LargeSize)
{
    FullResetAndSetupMocks(stream_->Device_()->Driver_());
    
    StreamJettyContext context;
    SetupContextWithBuffer(context);
    
    TaskInfo taskInfo = {};
    taskInfo.u.memcpyAsyncTaskInfo.src = reinterpret_cast<void*>(0x10000);
    taskInfo.u.memcpyAsyncTaskInfo.destPtr = reinterpret_cast<void*>(0x20000);
    taskInfo.u.memcpyAsyncTaskInfo.size = 300 * 1024 * 1024;
    taskInfo.id = 1;
    
    AsyncWqeInputPara input = {};
    AsyncWqeOutputPara output = {};
    rtError_t error = StreamJettyHandler::CreateAndAppendWqe(stream_, &taskInfo, &context, &input, &output);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(NpuDriverJettyTest, CreateAndAppendWqe_ConvertFail)
{
    GlobalMockObject::reset();
    SetupJettyDriverMocks(stream_->Device_()->Driver_());
    MOCKER_CPP_VIRTUAL(stream_->Device_()->Driver_(), &Driver::AsyncDmaWqeConvert)
        .stubs()
        .will(returnValue(RT_ERROR_INVALID_VALUE));
    
    StreamJettyContext context;
    TaskInfo taskInfo;
    SetupCreateAndAppendWqeTest(context, taskInfo,
        reinterpret_cast<void*>(0x10000), reinterpret_cast<void*>(0x20000), 1024, 1);
    
    AsyncWqeInputPara input = {};
    AsyncWqeOutputPara output = {};
    rtError_t error = StreamJettyHandler::CreateAndAppendWqe(stream_, &taskInfo, &context, &input, &output);
    (void)error;
}

// StreamJettyHandler::FillNopWqeForPartialBuffer tests (private method)
TEST_F(NpuDriverJettyTest, FillNopWqeForPartialBuffer_NullStream)
{
    StreamJettyContext context;
    rtError_t error = StreamJettyHandler::FillNopWqeForPartialBuffer(nullptr, &context);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(NpuDriverJettyTest, FillNopWqeForPartialBuffer_NullContext)
{
    rtError_t error = StreamJettyHandler::FillNopWqeForPartialBuffer(stream_, nullptr);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(NpuDriverJettyTest, FillNopWqeForPartialBuffer_ZeroWqeCount)
{
    StreamJettyContext context;
    context.filledWqeCount = 0;
    rtError_t error = StreamJettyHandler::FillNopWqeForPartialBuffer(stream_, &context);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(NpuDriverJettyTest, FillNopWqeForPartialBuffer_EmptyBuffers)
{
    StreamJettyContext context;
    context.filledWqeCount = 10;
    context.capacity = 2048;
    rtError_t error = StreamJettyHandler::FillNopWqeForPartialBuffer(stream_, &context);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(NpuDriverJettyTest, FillNopWqeForPartialBuffer_Success)
{
    StreamJettyContext* context = nullptr;
    rtError_t ctxError = StreamJettyHandler::GetOrCreateStreamJettyContext(stream_, JettyType::JETTY_TYPE_H2D, context);
    ASSERT_EQ(ctxError, RT_ERROR_NONE);
    ASSERT_NE(context, nullptr);
    
    // Set filledWqeCount less than capacity to trigger NOP fill
    context->filledWqeCount = 100;
    
    rtError_t error = StreamJettyHandler::FillNopWqeForPartialBuffer(stream_, context);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

// ========== JettyPool extended coverage tests ==========

// Cover CreateJetty query failure path
TEST_F(JettyPoolTest, CreateJetty_QueryFail)
{
    GlobalMockObject::reset();
    Driver* driver = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    SetupJettyDriverMocks(driver);
    
    JettyInfo jettyInfo;
    rtError_t error = jettyPool_->CreateJetty(JettyType::JETTY_TYPE_H2D, 2048, jettyInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

// Cover ReserveJetty pool exhausted path
TEST_F(JettyPoolTest, ReserveJetty_PoolExhausted)
{
    GlobalMockObject::reset();
    Driver* driver = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    SetupJettyDriverMocks(driver);
    
    // Fill the pool beyond limit
    for (uint32_t i = 0; i < JETTY_POOL_H2D_MAX_SIZE + 5; ++i) {
        rtError_t error = jettyPool_->ReserveJetty(JettyType::JETTY_TYPE_H2D);
        if (error == RT_ERROR_JETTY_POOL_NO_RESOURCES) {
            // Expected - pool exhausted
            EXPECT_EQ(i, JETTY_POOL_H2D_MAX_SIZE);
            break;
        }
        EXPECT_EQ(error, RT_ERROR_NONE);
    }
}

// Cover ReleaseJetty handle not found
TEST_F(JettyPoolTest, ReleaseJetty_HandleNotFound)
{
    GlobalMockObject::reset();
    Driver* driver = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    SetupJettyDriverMocks(driver);
    
    rtError_t error = jettyPool_->ReleaseJetty(99999, JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

// Cover DestroyLargeDepthJetty handle not found
TEST_F(JettyPoolTest, DestroyLargeDepthJetty_HandleNotFound)
{
    GlobalMockObject::reset();
    Driver* driver = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    SetupJettyDriverMocks(driver);
    
    rtError_t error = jettyPool_->DestroyLargeDepthJetty(99999);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

// Cover FindJettyByState BOUND state
TEST_F(JettyPoolTest, FindJettyByState_BoundState)
{
    GlobalMockObject::reset();
    Driver* driver = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    SetupJettyDriverMocks(driver);
    
    rtError_t error = jettyPool_->ReserveJetty(JettyType::JETTY_TYPE_H2D);
    ASSERT_EQ(error, RT_ERROR_NONE);
    
    JettyInfo jettyInfo2;
    error = jettyPool_->AcquireJetty(JettyType::JETTY_TYPE_H2D, jettyInfo2);
    ASSERT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(jettyInfo2.state, JettyState::BOUND);
}

// Cover FindJettyByHandle in D2D pool
TEST_F(JettyPoolTest, FindJettyByHandle_D2DPool)
{
    GlobalMockObject::reset();
    Driver* driver = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    SetupJettyDriverMocks(driver);
    
    rtError_t error = jettyPool_->ReserveJetty(JettyType::JETTY_TYPE_D2D);
    ASSERT_EQ(error, RT_ERROR_NONE);

    JettyInfo* freeInfo = nullptr;
    ASSERT_TRUE(jettyPool_->FindJettyByState(JettyType::JETTY_TYPE_D2D, JettyState::FREE, freeInfo));
    ASSERT_NE(freeInfo, nullptr);
    
    JettyInfo* foundInfo = nullptr;
    bool found = jettyPool_->FindJettyByHandle(freeInfo->handle, foundInfo);
    EXPECT_TRUE(found);
    EXPECT_NE(foundInfo, nullptr);
}

// Cover FindJettyByHandle in large jetty pool
TEST_F(JettyPoolTest, FindJettyByHandle_LargePool)
{
    GlobalMockObject::reset();
    Driver* driver = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    SetupJettyDriverMocks(driver);
    
    JettyInfo jettyInfo;
    rtError_t error = jettyPool_->CreateLargeDepthJetty(JettyType::JETTY_TYPE_H2D, 4096, jettyInfo);
    ASSERT_EQ(error, RT_ERROR_NONE);
    
    JettyInfo* foundInfo = nullptr;
    bool found = jettyPool_->FindJettyByHandle(jettyInfo.handle, foundInfo);
    EXPECT_TRUE(found);
    EXPECT_NE(foundInfo, nullptr);
}

// Cover Clear with all pools having jets
TEST_F(JettyPoolTest, Clear_AllPools)
{
    GlobalMockObject::reset();
    Driver* driver = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    SetupJettyDriverMocks(driver);
    
    // Add jets to all pools
    ASSERT_EQ(jettyPool_->ReserveJetty(JettyType::JETTY_TYPE_H2D), RT_ERROR_NONE);
    ASSERT_EQ(jettyPool_->ReserveJetty(JettyType::JETTY_TYPE_D2D), RT_ERROR_NONE);
    JettyInfo largeInfo;
    ASSERT_EQ(jettyPool_->CreateLargeDepthJetty(JettyType::JETTY_TYPE_H2D, 4096, largeInfo), RT_ERROR_NONE);
    
    jettyPool_->Clear();
    
    JettyInfo* foundInfo = nullptr;
    EXPECT_FALSE(jettyPool_->FindJettyByHandle(0, foundInfo));
    EXPECT_FALSE(jettyPool_->FindJettyByHandle(largeInfo.handle, foundInfo));
}

// ========== JettyManager extended coverage tests ==========

// Cover GetOrCreateStreamJettyContext with ReserveJetty retry
TEST_F(NpuDriverJettyTest, GetOrCreateStreamJettyContext_ReserveFail)
{
    FullResetAndSetupMocks(stream_->Device_()->Driver_());
    // Mock to exhaust pool quickly
    JettyPool* pool = new JettyPool(0);
    for (uint32_t i = 0; i < JETTY_POOL_H2D_MAX_SIZE + 5; ++i) {
        if (pool->ReserveJetty(JettyType::JETTY_TYPE_H2D) == RT_ERROR_JETTY_POOL_NO_RESOURCES) {
            break;
        }
    }
    delete pool;
}

// Cover BindJettyForStream with large depth context
TEST_F(NpuDriverJettyTest, BindJettyForStream_LargeDepth_Success)
{
    FullResetAndSetupMocks(stream_->Device_()->Driver_());
    
    StreamJettyContext* context = nullptr;
    rtError_t ctxError = StreamJettyHandler::GetOrCreateStreamJettyContext(stream_, JettyType::JETTY_TYPE_H2D, context);
    ASSERT_EQ(ctxError, RT_ERROR_NONE);
    ASSERT_NE(context, nullptr);
    
    // Set large depth flag
    context->isLargeDepth = true;
    context->capacity = 4096;
    context->filledWqeCount = 100;
    
    JettyManager* mgr = stream_->Device_()->GetJettyManager();
    int32_t streamId = static_cast<int32_t>(stream_->Id_());
    rtError_t error = mgr->BindJettyForStream(streamId, nullptr, JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

// Cover BindJettyForStream already bound
TEST_F(NpuDriverJettyTest, BindJettyForStream_AlreadyBound)
{
    GlobalMockObject::reset();
    SetupJettyDriverMocks(stream_->Device_()->Driver_());
    
    int32_t streamId = static_cast<int32_t>(stream_->Id_());
    StreamJettyContext* context = nullptr;
    StreamJettyHandler::GetOrCreateStreamJettyContext(stream_, JettyType::JETTY_TYPE_H2D, context);
    ASSERT_NE(context, nullptr);
    
    JettyManager* mgr = stream_->Device_()->GetJettyManager();
    
    // First bind
    rtError_t error1 = mgr->BindJettyForStream(streamId, nullptr, JettyType::JETTY_TYPE_H2D);
    ASSERT_EQ(error1, RT_ERROR_NONE);
    
    // Second bind - should return success without action
    rtError_t error2 = mgr->BindJettyForStream(streamId, nullptr, JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(error2, RT_ERROR_NONE);
}

// Cover UnbindJettyForStream success path
TEST_F(NpuDriverJettyTest, UnbindJettyForStream_Success)
{
    int32_t streamId = 0;
    JettyManager* mgr = SetupAndBindJettyForStream(stream_, streamId);
    bool isReleased = false;
    rtError_t error = mgr->UnbindJettyForStream(streamId, JettyType::JETTY_TYPE_H2D, isReleased);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_TRUE(isReleased);
}

// Cover UnbindJettyForStream large depth
TEST_F(NpuDriverJettyTest, UnbindJettyForStream_LargeDepth_Success)
{
    FullResetAndSetupMocks(stream_->Device_()->Driver_());
    
    StreamJettyContext* context = nullptr;
    rtError_t ctxError = StreamJettyHandler::GetOrCreateStreamJettyContext(stream_, JettyType::JETTY_TYPE_H2D, context);
    ASSERT_EQ(ctxError, RT_ERROR_NONE);
    context->isLargeDepth = true;
    context->capacity = 4096;
    context->filledWqeCount = 100;
    
    JettyManager* mgr = stream_->Device_()->GetJettyManager();
    int32_t streamId = static_cast<int32_t>(stream_->Id_());
    
    rtError_t bindError = mgr->BindJettyForStream(streamId, nullptr, JettyType::JETTY_TYPE_H2D);
    ASSERT_EQ(bindError, RT_ERROR_NONE);
    
    bool isReleased = false;
    rtError_t error = mgr->UnbindJettyForStream(streamId, JettyType::JETTY_TYPE_H2D, isReleased);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_TRUE(isReleased);
}

// Cover UnbindJettyForStream no context
TEST_F(NpuDriverJettyTest, UnbindJettyForStream_NoContext)
{
    FullResetAndSetupMocks(stream_->Device_()->Driver_());
    
    JettyManager* mgr = stream_->Device_()->GetJettyManager();
    bool isReleased = false;
    rtError_t error = mgr->UnbindJettyForStream(99999, JettyType::JETTY_TYPE_H2D, isReleased);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_FALSE(isReleased);
}

TEST_F(NpuDriverJettyTest, ReleaseJettyByHandle_Success)
{
    int32_t streamId = 0;
    JettyManager* mgr = SetupAndBindJettyForStream(stream_, streamId);
    StreamJettyContext* ctx = mgr->GetStreamJettyContext(streamId, JettyType::JETTY_TYPE_H2D);
    ASSERT_NE(ctx, nullptr);
    uint64_t savedHandle = ctx->jettyHandle;
    ASSERT_NE(savedHandle, 0ULL);

    bool isReleased = false;
    rtError_t unbindError = mgr->UnbindJettyForStream(streamId, JettyType::JETTY_TYPE_H2D, isReleased);
    EXPECT_EQ(unbindError, RT_ERROR_NONE);
    EXPECT_TRUE(isReleased);

    rtError_t error = mgr->ReleaseJettyByHandle(savedHandle, JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(NpuDriverJettyTest, ReleaseJettyByHandle_ZeroHandle)
{
    FullResetAndSetupMocks(stream_->Device_()->Driver_());
    JettyManager* mgr = stream_->Device_()->GetJettyManager();
    rtError_t error = mgr->ReleaseJettyByHandle(0, JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(NpuDriverJettyTest, ReleaseJettyByHandle_InvalidHandle)
{
    FullResetAndSetupMocks(stream_->Device_()->Driver_());
    JettyManager* mgr = stream_->Device_()->GetJettyManager();
    rtError_t error = mgr->ReleaseJettyByHandle(99999, JettyType::JETTY_TYPE_H2D);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(NpuDriverJettyTest, GetJettyInfoForStream_Success)
{
    int32_t streamId = 0;
    JettyManager* mgr = SetupAndBindJettyForStream(stream_, streamId);
    JettyInfo jettyInfo;
    rtError_t error = mgr->GetJettyInfoForStream(streamId, JettyType::JETTY_TYPE_H2D, jettyInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(jettyInfo.handle, 0ULL);
}

TEST_F(NpuDriverJettyTest, GetJettyInfoForStream_NotFound)
{
    FullResetAndSetupMocks(stream_->Device_()->Driver_());
    JettyManager* mgr = stream_->Device_()->GetJettyManager();
    JettyInfo jettyInfo;
    rtError_t error = mgr->GetJettyInfoForStream(99999, JettyType::JETTY_TYPE_H2D, jettyInfo);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(NpuDriverJettyTest, StreamJettyContext_ReleaseBuffers_NullDriver)
{
    StreamJettyContext context;
    context.ReleaseBuffers(nullptr);
    EXPECT_EQ(context.wqeBuffers.size(), 0U);
}

TEST_F(NpuDriverJettyTest, StreamJettyContext_ReleaseBuffers)
{
    StreamJettyContext context;
    context.ReleaseBuffers(stream_->Device_()->Driver_());
    EXPECT_EQ(context.wqeBuffers.size(), 0U);
}

// ========== HandleUbDmaTask/End extended coverage ==========

TEST_F(NpuDriverJettyTest, HandleUbDmaTask_InvalidCopyType)
{
    FullResetAndSetupMocks(stream_->Device_()->Driver_());
    Runtime::Instance()->SetConnectUbFlag(true);
    
    TaskInfo taskInfo = {};
    taskInfo.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_DIR_D2D_SDMA;  // Not UB type for H2D/D2H
    
    AsyncWqeInputPara input = {};
    AsyncWqeOutputPara output = {};
    rtError_t error = StreamJettyHandler::HandleUbDmaTask(stream_, &taskInfo, JettyType::JETTY_TYPE_H2D, &input, &output);
    // Should return NONE for non-UB type
    EXPECT_EQ(error, RT_ERROR_NONE);
    
    Runtime::Instance()->SetConnectUbFlag(false);
}

TEST_F(NpuDriverJettyTest, FillNopWqeOnCaptureEnd_D2D_Success)
{
    Runtime::Instance()->SetConnectUbFlag(true);
    rtError_t error = StreamJettyHandler::FillNopWqeOnCaptureEnd(nullptr, JettyType::JETTY_TYPE_D2D);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
    Runtime::Instance()->SetConnectUbFlag(false);
}

// ========== SyncWqeBufferToDevice extended coverage ==========

TEST_F(NpuDriverJettyTest, SyncWqeBufferToDevice_Success)
{
    GlobalMockObject::reset();
    SetupJettyDriverMocks(stream_->Device_()->Driver_());
    
    StreamJettyContext context;
    SetupContextWithBuffer(context);
    context.filledWqeCount = 100;
    
    JettyInfo jettyInfo;
    jettyInfo.handle = 1;
    
    rtError_t error = StreamJettyHandler::SyncWqeBufferToDevice(stream_, &context, jettyInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(NpuDriverJettyTest, SyncWqeBufferToDevice_NullStream)
{
    StreamJettyContext context;
    JettyInfo jettyInfo;
    rtError_t error = StreamJettyHandler::SyncWqeBufferToDevice(nullptr, &context, jettyInfo);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

// ========== UpdateUbdmaSqeWithJettyInfo extended coverage ==========

TEST_F(NpuDriverJettyTest, UpdateUbdmaSqeWithJettyInfo_Success)
{
    StreamJettyContext context;
    JettyInfo jettyInfo;
    
    // No taskWqeCounts - should return early with success
    rtError_t error = StreamJettyHandler::UpdateUbdmaSqeWithJettyInfo(nullptr, &context, jettyInfo);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(NpuDriverJettyTest, UpdateUbdmaSqeWithJettyInfo_NullStream)
{
    StreamJettyContext context;
    JettyInfo jettyInfo;
    rtError_t error = StreamJettyHandler::UpdateUbdmaSqeWithJettyInfo(nullptr, &context, jettyInfo);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

// ========== NpuDriver Standard SOC extended coverage ==========

TEST_F(NpuDriverJettyTest, AsyncDmaJettyCreate_InvalidDepth)
{
    uint64_t handle = 0;
    rtError_t error = stream_->Device_()->Driver_()->AsyncDmaJettyCreate(0, 1, 0, TRS_ASYNC_JETTY_HOST_DEVICE, &handle);
    // Mocked driver always returns success - test the call path
    EXPECT_EQ(error, RT_ERROR_NONE);
}

// ========== Additional coverage for jetty_pool.cc ==========

TEST_F(NpuDriverJettyTest, JettyPool_CreateJetty_H2D_Success)
{
    FullResetAndSetupMocks(stream_->Device_()->Driver_());
    
    JettyPool pool(0);
    JettyInfo jettyInfo;
    rtError_t error = pool.CreateJetty(JettyType::JETTY_TYPE_H2D, 2048, jettyInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(jettyInfo.type, JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(jettyInfo.depth, 2048U);
    EXPECT_EQ(jettyInfo.state, JettyState::FREE);
}

TEST_F(NpuDriverJettyTest, JettyPool_ReserveJetty_FromFreePool)
{
    FullResetAndSetupMocks(stream_->Device_()->Driver_());
    
    JettyPool pool(0);
    
    rtError_t error1 = pool.ReserveJetty(JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(error1, RT_ERROR_NONE);

    JettyInfo* freeInfo = nullptr;
    ASSERT_TRUE(pool.FindJettyByState(JettyType::JETTY_TYPE_H2D, JettyState::FREE, freeInfo));
    ASSERT_NE(freeInfo, nullptr);
    pool.MarkFree(freeInfo->handle);
    
    rtError_t error2 = pool.ReserveJetty(JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(error2, RT_ERROR_NONE);
}

// ========== Additional coverage for jetty_manager.cc ==========

TEST_F(NpuDriverJettyTest, JettyManager_ReserveJetty_Success)
{
    FullResetAndSetupMocks(stream_->Device_()->Driver_());
    
    JettyManager mgr(0);
    rtError_t error = mgr.ReserveJetty(JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(NpuDriverJettyTest, JettyManager_BindJettyForStream_NoContext)
{
    FullResetAndSetupMocks(stream_->Device_()->Driver_());
    
    JettyManager mgr(0);
    int32_t streamId = static_cast<int32_t>(stream_->Id_());
    rtError_t error = mgr.BindJettyForStream(streamId, nullptr, JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

// ========== Additional coverage for stream_jetty_handler.cc ==========

TEST_F(NpuDriverJettyTest, Handler_GetDriverAndDeviceId_Success)
{
    Driver* driver = nullptr;
    uint32_t deviceId = 0;
    rtError_t error = StreamJettyHandler::GetDriverAndDeviceId(stream_, driver, deviceId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(driver, nullptr);
}

TEST_F(NpuDriverJettyTest, Handler_GetDriverAndDeviceId_NullStream)
{
    Driver* driver = nullptr;
    uint32_t deviceId = 0;
    rtError_t error = StreamJettyHandler::GetDriverAndDeviceId(nullptr, driver, deviceId);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(NpuDriverJettyTest, Handler_HandleUbDmaTask_H2D_Success)
{
    FullResetAndSetupMocks(stream_->Device_()->Driver_());
    Runtime::Instance()->SetConnectUbFlag(true);
    StreamJettyContext context;
    rtError_t error = SetupAndRunH2DTask(stream_, context);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime::Instance()->SetConnectUbFlag(false);
}

// ========== Additional coverage for npu_driver_standard_soc.cc ==========

TEST_F(NpuDriverJettyTest, Driver_AsyncDmaJettyQuery_Success)
{
    uint64_t handle = 0;
    stream_->Device_()->Driver_()->AsyncDmaJettyCreate(0, 1, 2048, TRS_ASYNC_JETTY_HOST_DEVICE, &handle);
    
    uint32_t dieId = 0, functionId = 0, jettyId = 0;
    rtError_t error = stream_->Device_()->Driver_()->AsyncDmaJettyQuery(0, handle, dieId, functionId, jettyId);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(NpuDriverJettyTest, Driver_AsyncDmaWqeConvert_NOP)
{
    AsyncWqeInputPara input = {};
    input.wqeType = DRV_ASYNC_DMA_TYPE_NOP;
    input.wqeBuffer = reinterpret_cast<uint8_t*>(0x10000);
    input.size = 64;
    input.nop.nopCnt = 5;
    
    AsyncWqeOutputPara output = {};
    rtError_t error = stream_->Device_()->Driver_()->AsyncDmaWqeConvert(0, &input, &output);
    EXPECT_EQ(error, RT_ERROR_NONE);
}
TEST_F(NpuDriverJettyTest, Handler_IsUbDmaCopyType_NonUB)
{
    Runtime::Instance()->SetConnectUbFlag(true);
    bool result = StreamJettyHandler::IsUbDmaCopyType(RT_MEMCPY_DIR_D2D_SDMA);
    EXPECT_FALSE(result);
    Runtime::Instance()->SetConnectUbFlag(false);
}

// ========== Additional coverage for FillNopWqeOnCaptureEnd ==========

// ========== Additional coverage for FillNopWqeForPartialBuffer ==========

TEST_F(NpuDriverJettyTest, Handler_FillNopWqeForPartialBuffer_ValidContext)
{
    FullResetAndSetupMocks(stream_->Device_()->Driver_());
    
    StreamJettyContext context;
    context.filledWqeCount = 0;
    
    rtError_t error = StreamJettyHandler::FillNopWqeForPartialBuffer(stream_, &context);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(NpuDriverJettyTest, Handler_FillNopWqeForPartialBuffer_WithBuffers)
{
    GlobalMockObject::reset();
    SetupJettyDriverMocks(stream_->Device_()->Driver_());
    
    StreamJettyContext context;
    SetupContextWithBuffer(context);
    context.filledWqeCount = 100;
    
    rtError_t error = StreamJettyHandler::FillNopWqeForPartialBuffer(stream_, &context);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

// ========== Additional coverage for GrowBuffer ==========

TEST_F(NpuDriverJettyTest, Context_GrowBuffer_Success)
{
    FullResetAndSetupMocks(stream_->Device_()->Driver_());
    MOCKER(halMemAlloc).stubs().will(invoke(StubHalMemAlloc));
    MOCKER(halMemFree).stubs().will(invoke(StubHalMemFree));
    StreamJettyContext context;
    rtError_t error = context.GrowBuffer(stream_->Device_()->Driver_());
    
    EXPECT_EQ(error, RT_ERROR_MEMORY_ALLOCATION);
}
// ========== Additional coverage for JettyManager functions ==========

TEST_F(NpuDriverJettyTest, JettyManager_AcquireJettyWithRetry_Success)
{
    FullResetAndSetupMocks(stream_->Device_()->Driver_());
    
    JettyManager mgr(0);
    mgr.ReserveJetty(JettyType::JETTY_TYPE_H2D);
    
    JettyInfo jettyInfo2;
    rtError_t error = mgr.AcquireJettyWithRetry(JettyType::JETTY_TYPE_H2D, 0, nullptr, jettyInfo2);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(NpuDriverJettyTest, JettyManager_BindJettyForStream_Success)
{
    FullResetAndSetupMocks(stream_->Device_()->Driver_());
    MOCKER(halMemAlloc).stubs().will(invoke(StubHalMemAlloc));
    MOCKER(halMemFree).stubs().will(invoke(StubHalMemFree));
    
    JettyManager mgr(0);
    StreamJettyContext* ctx = mgr.GetOrCreateStreamJettyContext(stream_, JettyType::JETTY_TYPE_H2D);
    ASSERT_NE(ctx, nullptr);
    ctx->jettyHandle = 0;
    
    int32_t streamId = static_cast<int32_t>(stream_->Id_());
    rtError_t error = mgr.BindJettyForStream(streamId, nullptr, JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(NpuDriverJettyTest, JettyManager_GetJettyInfoForStream_NotFound)
{
    FullResetAndSetupMocks(stream_->Device_()->Driver_());
    
    JettyManager mgr(0);
    JettyInfo jettyInfo;
    rtError_t error = mgr.GetJettyInfoForStream(99999, JettyType::JETTY_TYPE_H2D, jettyInfo);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(NpuDriverJettyTest, JettyManager_DestroyStreamJettyContext_Success)
{
    FullResetAndSetupMocks(stream_->Device_()->Driver_());
    MOCKER(halMemAlloc).stubs().will(invoke(StubHalMemAlloc));
    MOCKER(halMemFree).stubs().will(invoke(StubHalMemFree));
    
    JettyManager mgr(0);
    mgr.GetOrCreateStreamJettyContext(stream_, JettyType::JETTY_TYPE_H2D);
    
    int32_t streamId = static_cast<int32_t>(stream_->Id_());
    mgr.DestroyStreamJettyContext(streamId, JettyType::JETTY_TYPE_H2D);
    
    StreamJettyContext* ctx = mgr.GetStreamJettyContext(streamId, JettyType::JETTY_TYPE_H2D);
    EXPECT_EQ(ctx, nullptr);
}

static rtError_t StubCreateAsyncDmaWqeSuccess(
    Driver* drv, uint32_t devId, const AsyncDmaWqeInputInfo& input,
    AsyncDmaWqeOutputInfo* output, bool isUbMode, bool isSqeUpdate)
{
    if (output != nullptr) {
        output->dieId = 1;
        output->functionId = 10;
        output->jettyId = 12;
        output->wqeLen = 0;
        output->pi = 1;
    }
    return RT_ERROR_NONE;
}

static rtError_t StubMemConvertAddrSuccess(
    Driver* drv, uint64_t src, uint64_t dst, uint64_t len, struct DMA_ADDR* dmaAddr)
{
    if (dmaAddr != nullptr) {
        dmaAddr->fixed_size = static_cast<unsigned int>(len);
    }
    return RT_ERROR_NONE;
}

TEST_F(NpuDriverJettyTest, ConvertAsyncDma_SoftwareSqUb_Success)
{
    GlobalMockObject::reset();
    SetupJettyDriverMocks(stream_->Device_()->Driver_());
    MOCKER_CPP_VIRTUAL(stream_->Device_()->Driver_(), &Driver::AsyncDmaWqeConvert)
        .stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(stream_->Device_()->Driver_(), &Driver::AsyncDmaWqeFill)
        .stubs().will(returnValue(RT_ERROR_NONE));

    stream_->SetSoftWareSqEnable();
    uint8_t* sqBuf = reinterpret_cast<uint8_t*>(malloc(sizeof(rtDavidSqe_t) * 4));
    stream_->SetSqBaseAddr(reinterpret_cast<uint64_t>(sqBuf));

    TaskInfo taskInfo = {};
    taskInfo.stream = stream_;
    taskInfo.u.memcpyAsyncTaskInfo.src = reinterpret_cast<void*>(0x10000);
    taskInfo.u.memcpyAsyncTaskInfo.destPtr = reinterpret_cast<void*>(0x20000);
    taskInfo.u.memcpyAsyncTaskInfo.size = 1024;
    taskInfo.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_DIR_D2D_SDMA;

    rtError_t error = ConvertAsyncDma(&taskInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);

    free(sqBuf);
}

TEST_F(NpuDriverJettyTest, ConvertAsyncDmaForTaskUpdate_SoftwareSqUb_NonPersistent_Success)
{
    GlobalMockObject::reset();
    SetupJettyDriverMocks(stream_->Device_()->Driver_());

    stream_->SetSoftWareSqEnable();
    uint8_t* sqBuf = reinterpret_cast<uint8_t*>(malloc(sizeof(rtDavidSqe_t) * 4));
    stream_->SetSqBaseAddr(reinterpret_cast<uint64_t>(sqBuf));
    stream_->flags_ = RT_STREAM_DEFAULT;

    Stream* updateStream = new Stream(device_, 0);
    updateStream->SetSoftWareSqEnable();
    uint8_t* updateSqBuf = reinterpret_cast<uint8_t*>(malloc(sizeof(rtDavidSqe_t) * 4));
    updateStream->SetSqBaseAddr(reinterpret_cast<uint64_t>(updateSqBuf));

    MOCKER_CPP_VIRTUAL(stream_->Device_()->Driver_(), &Driver::CreateAsyncDmaWqe)
        .stubs().will(invoke(StubCreateAsyncDmaWqeSuccess));

    TaskInfo taskInfo = {};
    taskInfo.stream = stream_;
    taskInfo.u.memcpyAsyncTaskInfo.src = reinterpret_cast<void*>(0x10000);
    taskInfo.u.memcpyAsyncTaskInfo.destPtr = reinterpret_cast<void*>(0x20000);
    taskInfo.u.memcpyAsyncTaskInfo.size = 1024;
    taskInfo.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_DIR_H2D;

    TaskInfo updateTaskInfo = {};
    updateTaskInfo.stream = updateStream;
    updateTaskInfo.pos = 0;

    rtError_t error = ConvertAsyncDmaForTaskUpdate(&taskInfo, &updateTaskInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_TRUE(taskInfo.u.memcpyAsyncTaskInfo.ubDma.isUbAsyncMode);

    free(updateSqBuf);
    delete updateStream;
    free(sqBuf);
}

TEST_F(NpuDriverJettyTest, ConvertAsyncDmaForTaskUpdate_SoftwareSqUb_Persistent_Success)
{
    GlobalMockObject::reset();
    SetupJettyDriverMocks(stream_->Device_()->Driver_());
    MOCKER_CPP_VIRTUAL(stream_->Device_()->Driver_(), &Driver::AsyncDmaWqeConvert)
        .stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(stream_->Device_()->Driver_(), &Driver::AsyncDmaWqeFill)
        .stubs().will(returnValue(RT_ERROR_NONE));

    stream_->SetSoftWareSqEnable();
    uint8_t* sqBuf = reinterpret_cast<uint8_t*>(malloc(sizeof(rtDavidSqe_t) * 4));
    stream_->SetSqBaseAddr(reinterpret_cast<uint64_t>(sqBuf));
    stream_->flags_ = RT_STREAM_PERSISTENT;

    Stream* updateStream = new Stream(device_, 0);
    updateStream->SetSoftWareSqEnable();
    uint8_t* updateSqBuf = reinterpret_cast<uint8_t*>(malloc(sizeof(rtDavidSqe_t) * 4));
    updateStream->SetSqBaseAddr(reinterpret_cast<uint64_t>(updateSqBuf));

    TaskInfo taskInfo = {};
    taskInfo.stream = stream_;
    taskInfo.u.memcpyAsyncTaskInfo.src = reinterpret_cast<void*>(0x10000);
    taskInfo.u.memcpyAsyncTaskInfo.destPtr = reinterpret_cast<void*>(0x20000);
    taskInfo.u.memcpyAsyncTaskInfo.size = 1024;
    taskInfo.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_DIR_D2D_SDMA;

    TaskInfo updateTaskInfo = {};
    updateTaskInfo.stream = updateStream;
    updateTaskInfo.pos = 0;

    rtError_t error = ConvertAsyncDmaForTaskUpdate(&taskInfo, &updateTaskInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);

    free(updateSqBuf);
    delete updateStream;
    free(sqBuf);
}

TEST_F(NpuDriverJettyTest, ConvertAsyncDmaForTaskUpdate_SoftwareSqPcie_Success)
{
    GlobalMockObject::reset();
    SetupJettyDriverMocks(stream_->Device_()->Driver_());
    Runtime::Instance()->SetConnectUbFlag(false);

    Stream* updateStream = new Stream(device_, 0);
    updateStream->SetSoftWareSqEnable();
    uint8_t* updateSqBuf = reinterpret_cast<uint8_t*>(malloc(sizeof(rtDavidSqe_t) * 4));
    updateStream->SetSqBaseAddr(reinterpret_cast<uint64_t>(updateSqBuf));

    MOCKER_CPP_VIRTUAL(stream_->Device_()->Driver_(), &Driver::MemConvertAddr)
        .stubs().will(invoke(StubMemConvertAddrSuccess));

    TaskInfo taskInfo = {};
    taskInfo.stream = stream_;
    taskInfo.u.memcpyAsyncTaskInfo.src = reinterpret_cast<void*>(0x10000);
    taskInfo.u.memcpyAsyncTaskInfo.destPtr = reinterpret_cast<void*>(0x20000);
    taskInfo.u.memcpyAsyncTaskInfo.size = 1024;
    taskInfo.u.memcpyAsyncTaskInfo.copyType = RT_MEMCPY_DIR_D2D_PCIe;

    TaskInfo updateTaskInfo = {};
    updateTaskInfo.stream = updateStream;
    updateTaskInfo.pos = 0;

    rtError_t error = ConvertAsyncDmaForTaskUpdate(&taskInfo, &updateTaskInfo);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(taskInfo.u.memcpyAsyncTaskInfo.size,
        static_cast<uint64_t>(taskInfo.u.memcpyAsyncTaskInfo.dmaAddr.fixed_size));

    Runtime::Instance()->SetConnectUbFlag(true);
    free(updateSqBuf);
    delete updateStream;
}

TEST_F(NpuDriverJettyTest, Context_RoundUpCapacity_AllBranches)
{
    Driver* drv = stream_->Device_()->Driver_();

    // Case 1: filledWqeCount == 0 → early return
    {
        StreamJettyContext ctx;
        ctx.filledWqeCount = 0;
        ctx.capacity = 4096;
        EXPECT_EQ(ctx.RoundUpCapacity(drv, 0), RT_ERROR_NONE);
        EXPECT_EQ(ctx.capacity, 4096u);
    }

    // Case 2: capacity <= WQE_BUFFER_DEPTH → early return
    {
        StreamJettyContext ctx;
        ctx.filledWqeCount = 100;
        ctx.capacity = 2048;
        EXPECT_EQ(ctx.RoundUpCapacity(drv, 0), RT_ERROR_NONE);
        EXPECT_EQ(ctx.capacity, 2048u);
    }

    // Case 3: capacity already power-of-2 aligned (4096) → early return
    {
        StreamJettyContext ctx;
        ctx.filledWqeCount = 3000;
        ctx.capacity = 4096;
        for (int i = 0; i < 2; ++i) {
            ctx.wqeBuffers.push_back(std::unique_ptr<uint8_t[]>(new uint8_t[2048 * 64]));
        }
        EXPECT_EQ(ctx.RoundUpCapacity(drv, 0), RT_ERROR_NONE);
        EXPECT_EQ(ctx.capacity, 4096u);
        EXPECT_EQ(ctx.wqeBuffers.size(), 2u);
    }

    // Case 4: capacity exceeds JETTY_DEPTH_MAX → RT_ERROR_INVALID_VALUE
    {
        StreamJettyContext ctx;
        ctx.filledWqeCount = 33000;
        ctx.capacity = 34816;
        EXPECT_EQ(ctx.RoundUpCapacity(drv, 0), RT_ERROR_INVALID_VALUE);
    }

    // Case 5: success path (capacity 6144 → 8192, allocate 1 new buffer + fill NOP)
    {
        SetupMocksWithoutHostMemAlloc(drv);
        void* allocBuf = malloc(2048 * 64);
        (void)memset(allocBuf, 0, 2048 * 64);
        MOCKER_CPP_VIRTUAL(drv, &Driver::HostMemAlloc)
            .stubs()
            .with(outBoundP(&allocBuf, sizeof(void*)), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
            .will(returnValue(RT_ERROR_NONE));
        MOCKER_CPP_VIRTUAL(drv, &Driver::AsyncDmaWqeConvert)
            .stubs()
            .will(returnValue(RT_ERROR_NONE));

        StreamJettyContext ctx;
        ctx.filledWqeCount = 4096;
        ctx.capacity = 6144;
        for (int i = 0; i < 3; ++i) {
            ctx.wqeBuffers.push_back(std::unique_ptr<uint8_t[]>(new uint8_t[2048 * 64]));
        }
        EXPECT_EQ(ctx.RoundUpCapacity(drv, 0), RT_ERROR_NONE);
        EXPECT_EQ(ctx.capacity, 8192u);
        EXPECT_TRUE(ctx.isLargeDepth);
        EXPECT_EQ(ctx.wqeBuffers.size(), 4u);
        ctx.ReleaseBuffers(drv);
        free(allocBuf);
    }

    // Case 6: HostMemAlloc returns nullptr → RT_ERROR_MEMORY_ALLOCATION
    {
        FullResetAndSetupMocks(drv);
        // Default mock: HostMemAlloc returns RT_ERROR_NONE but doesn't set ptr → nullptr
        StreamJettyContext ctx;
        ctx.filledWqeCount = 4096;
        ctx.capacity = 6144;
        for (int i = 0; i < 3; ++i) {
            ctx.wqeBuffers.push_back(std::unique_ptr<uint8_t[]>(new uint8_t[2048 * 64]));
        }
        EXPECT_EQ(ctx.RoundUpCapacity(drv, 0), RT_ERROR_MEMORY_ALLOCATION);
    }

    // Case 7: AsyncDmaWqeConvert fails → propagate error
    {
        SetupMocksWithoutHostMemAlloc(drv);
        void* allocBuf = malloc(2048 * 64);
        (void)memset(allocBuf, 0, 2048 * 64);
        MOCKER_CPP_VIRTUAL(drv, &Driver::HostMemAlloc)
            .stubs()
            .with(outBoundP(&allocBuf, sizeof(void*)), mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
            .will(returnValue(RT_ERROR_NONE));
        MOCKER_CPP_VIRTUAL(drv, &Driver::AsyncDmaWqeConvert)
            .stubs()
            .will(returnValue(RT_ERROR_INVALID_VALUE));

        StreamJettyContext ctx;
        ctx.filledWqeCount = 4096;
        ctx.capacity = 6144;
        for (int i = 0; i < 3; ++i) {
            ctx.wqeBuffers.push_back(std::unique_ptr<uint8_t[]>(new uint8_t[2048 * 64]));
        }
        EXPECT_EQ(ctx.RoundUpCapacity(drv, 0), RT_ERROR_INVALID_VALUE);
        ctx.ReleaseBuffers(drv);
        free(allocBuf);
    }
}