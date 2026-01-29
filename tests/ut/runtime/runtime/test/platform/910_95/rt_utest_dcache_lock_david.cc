/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
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
#define private public
#define protected public
#include "runtime.hpp"
#include "api.hpp"
#include "api_impl.hpp"
#include "api_impl_david.hpp"
#include "program.hpp"
#include "context.hpp"
#include "raw_device.hpp"
#include "logger.hpp"
#include "engine.hpp"
#include "label.hpp"
#include "task_res.hpp"
#include "stars.hpp"
#include "device_state_callback_manager.hpp"
#include "npu_driver.hpp"
#include "api_error.hpp"
#include "event.hpp"
#include "stream.hpp"
#include "notify.hpp"
#include "count_notify.hpp"
#include "profiler_c.hpp"
#include "device_msg_handler.hpp"
#include "api_profile_decorator.hpp"
#include "api_profile_log_decorator.hpp"
#include "subscribe.hpp"
#include <fstream>
#include <stdio.h>
#include <stdlib.h>
#include "thread_local_container.hpp"
#include "config_define.hpp"
#include "task_res.hpp"
#include "task_david.hpp"
#include "task_recycle.hpp"
#include "aix_c.hpp"
#include "task_res_da.hpp"
#include "stream_c.hpp"
#include "npu_driver_dcache_lock.hpp"
#include "thread_local_container.hpp"
#undef protected
#undef private

using namespace testing;
using namespace cce::runtime;

static bool g_disableThread;
static rtChipType_t g_chipType;
extern int64_t g_device_driver_version_stub;

static drvError_t stubDavidGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (value) {
        if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_VERSION) {
            *value = PLATFORMCONFIG_DAVID_950PR_9599;
        } else if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_CORE_NUM) {
            *value = g_device_driver_version_stub;
        } else {
            *value = 0;
        }
    }
    return DRV_ERROR_NONE;
}

class DcacheLockDavidTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        MOCKER(halGetDeviceInfo).stubs().will(invoke(stubDavidGetDeviceInfo));
        char *socVer = "Ascend950PR_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend950PR_9599")), mockcpp::any())
            .will(returnValue(DRV_ERROR_NONE));
        std::cout << "ApiDavidTest SetUP" << std::endl;
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetDisableThread(true);
        originType_ = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
        rtInstance->SetConnectUbFlag(true);
        std::cout << "ApiDavidTest start" << std::endl;
        GlobalMockObject::verify();
    }

    static void TearDownTestCase()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(originType_);
        GlobalContainer::SetRtChipType(originType_);
        rtInstance->SetDisableThread(false);
        rtInstance->SetConnectUbFlag(false);
        std::cout << "ApiDavidTest end" << std::endl;
    }

    virtual void SetUp()
    {
        GlobalMockObject::reset();
        int64_t hardwareVersion = ((ARCH_V100 << 16) | (CHIP_DAVID << 8) | (VER_NA));
        Driver *driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetDevInfo)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
            .will(returnValue(RT_ERROR_NONE));
        char *socVer = "Ascend950PR_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend950PR_9599")), mockcpp::any())
            .will(returnValue(DRV_ERROR_NONE));
        MOCKER_CPP_VIRTUAL(driver, &Driver::StreamBindLogicCq).stubs().will(returnValue(RT_ERROR_NONE));

        MOCKER_CPP_VIRTUAL(driver, &Driver::StreamUnBindLogicCq).stubs().will(returnValue(RT_ERROR_NONE));

        MOCKER_CPP_VIRTUAL(driver, &Driver::GetRunMode).stubs().will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

        bool enable = false;
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqEnable)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(enable))
            .will(returnValue(RT_ERROR_NONE));

        MOCKER_CPP_VIRTUAL(driver, &Driver::EnableSq).stubs().will(returnValue(RT_ERROR_NONE));
        rtSetDevice(0);
        (void)rtSetSocVersion("Ascend950PR_9599");
        device_ = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
        device_->SetPlatformType(PLATFORM_DAVID_950PR_9599);
        engine_ = ((RawDevice *)device_)->engine_;

        rtError_t res = rtStreamCreateWithFlags(&streamHandle_, 0, 0);
        EXPECT_EQ(res, RT_ERROR_NONE);
        stream_ = (Stream *)streamHandle_;
        stream_->SetSqMemAttr(false);
        stream_->Context_()->DefaultStream_()->SetSqMemAttr(false);
        davidSqe_ = (rtDavidSqe_t *)malloc(2 * sizeof(rtDavidSqe_t));
        oldSqAddr_ = stream_->GetSqBaseAddr();
        uint64_t sqeAddr = reinterpret_cast<uint64_t>(davidSqe_);
        stream_->SetSqBaseAddr(sqeAddr);
        MOCKER(StreamNopTask).stubs().will(returnValue(RT_ERROR_NONE));

        TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream_)->taskResMang_));
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqHead)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(taskResMang->GetTaskPosTail()))
            .will(returnValue(RT_ERROR_NONE));
    }

    virtual void TearDown()
    {
        Driver *driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        stream_->SetSqBaseAddr(oldSqAddr_);
        TaskResManageDavid *taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(stream_)->taskResMang_));
        taskResMang->ResetTaskRes();
        MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqHead)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(taskResMang->GetTaskPosTail()))
            .will(returnValue(RT_ERROR_NONE));
        Stream *dft = stream_->Context_()->DefaultStream_();
        taskResMang = ((TaskResManageDavid *)(static_cast<Stream *>(dft)->taskResMang_));
        taskResMang->ResetTaskRes();
        while (stream_->GetPendingNum() > 0) {
            stream_->pendingNum_.Sub(1U);
        }
        while (engine_->GetPendingNum() > 0) {
            engine_->pendingNum_.Set(0U);
        }

        rtStreamDestroy(streamHandle_);
        free(davidSqe_);
        davidSqe_ = nullptr;
        stream_ = nullptr;
        engine_ = nullptr;
        ((Runtime *)Runtime::Instance())->DeviceRelease(device_);

        MOCKER_CPP_VIRTUAL(driver, &Driver::GetRunMode).stubs().will(returnValue((uint32_t)RT_RUN_MODE_OFFLINE));

        rtDeviceReset(0);
        GlobalMockObject::reset();
    }

public:
    Device *device_ = nullptr;
    Stream *stream_ = nullptr;
    Engine *engine_ = nullptr;
    rtDavidSqe_t *davidSqe_ = nullptr;
    rtStream_t streamHandle_ = 0;
    rtStream_t streamHandleDvpp_ = 0;
    uint64_t oldSqAddr_ = 0;
    static rtChipType_t originType_;
};
rtChipType_t DcacheLockDavidTest::originType_ = CHIP_MINI;

TEST_F(DcacheLockDavidTest, DcacheLockSendTask)
{
    MOCKER(StreamLaunchKernelV1).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(stream_, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t error = DcacheLockSendTask(nullptr, 1, nullptr, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(DcacheLockDavidTest, DcacheLockSendTask_abnormal_01)
{
    MOCKER(StreamLaunchKernelV1).stubs().will(returnValue(cce::runtime::RT_ERROR_INVALID_VALUE));
    rtError_t error = DcacheLockSendTask(nullptr, 1, nullptr, stream_);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(DcacheLockDavidTest, DcacheLockSendTask_abnormal_02)
{
    MOCKER(StreamLaunchKernelV1).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(stream_, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    rtError_t error = DcacheLockSendTask(nullptr, 1, nullptr, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(DcacheLockDavidTest, AllocStackPhyBaseDavid)
{
    MOCKER(AllocAddrForDcache).stubs().will(returnValue(RT_ERROR_NONE));
    rtError_t ret = ((RawDevice *)device_)->AllocStackPhyBaseDavid();
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(DcacheLockDavidTest, FreeDcacheAddr)
{
    MOCKER(halMemUnmap).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(halMemAddressFree).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(halMemRelease).stubs().will(returnValue(RT_ERROR_NONE));
    uint8_t addrs[2];
    void *p1 = (void *)addrs;
    uint8_t handle[2];
    void *p2 = (void *)handle;
    FreeDcacheAddr(0, p1, p2);
}