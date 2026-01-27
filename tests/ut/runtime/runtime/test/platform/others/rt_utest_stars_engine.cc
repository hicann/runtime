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
#include "base.hpp"
#include "securec.h"
#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#include "npu_driver.hpp"
#define private public
#define protected public
#include "engine.hpp"
#include "stars_engine.hpp"
#include "runtime.hpp"
#include "event.hpp"
#include "logger.hpp"
#include "raw_device.hpp"
#undef private
#undef protected
#include "scheduler.hpp"
#include "stars.hpp"
#include "hwts.hpp"
#include "npu_driver.hpp"
#include "context.hpp"
#include "device/device_error_proc.hpp"
#include "stream_sqcq_manage.hpp"
#include <map>
#include <utility>  // For std::pair and std::make_pair.
#include "rt_stars_define.h"
#include "thread_local_container.hpp"

using namespace testing;
using namespace cce::runtime;

namespace cce {
namespace runtime {
namespace {
constexpr uint32_t TS_SDMA_STATUS_DDRC_ERROR = 0x8U;
constexpr uint32_t TS_SDMA_STATUS_LINK_ERROR = 0x9U;
constexpr uint32_t TS_SDMA_STATUS_POISON_ERROR = 0xAU;
} // namespace

void ReportErrorInfoForModelExecuteTask(TaskInfo * const taskInfo, const uint32_t devId);
uint16_t GetAicpuKernelCredit(uint16_t timeout);
}
}

using std::pair;
using std::make_pair;

class OthersStarsEngineTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        std::cout << "StarsTaskTest SetUP" << std::endl;
        rtInstance->SetDisableThread(true);
        originType_ = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_910_B_93);
    GlobalContainer::SetRtChipType(CHIP_910_B_93);
    }

    static void TearDownTestCase()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(originType_);
        GlobalContainer::SetRtChipType(originType_);
        rtInstance->SetDisableThread(false);
        std::cout << "StarsTaskTest Tear Down" << std::endl;
    }

    virtual void SetUp()
    {
        int64_t hardwareVersion = ((ARCH_C220 << 16) | (CHIP_910_B_93 << 8) | (RT_VER_NA));
        Driver *driver = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver,
            &Driver::GetDevInfo).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(),outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
            .will(returnValue(RT_ERROR_NONE));
        char *socVer = "Ascend910B1";
        MOCKER(halGetSocVersion).stubs().with(mockcpp::any(), outBoundP(socVer, strlen("Ascend910B1")), mockcpp::any()).will(returnValue(DRV_ERROR_NONE));
        MOCKER(halGetDeviceInfo).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&hardwareVersion, sizeof(hardwareVersion))).will(returnValue(RT_ERROR_NONE));

        MOCKER_CPP_VIRTUAL(driver, &Driver::StreamBindLogicCq)
                .stubs()
                .will(returnValue(RT_ERROR_NONE));

        MOCKER_CPP_VIRTUAL(driver, &Driver::StreamUnBindLogicCq)
                .stubs()
                .will(returnValue(RT_ERROR_NONE));

        bool enable = false;
        MOCKER_CPP_VIRTUAL(driver,
            &Driver::GetSqEnable).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBound(enable))
            .will(returnValue(RT_ERROR_NONE));

        MOCKER_CPP_VIRTUAL(driver, &Driver::SetSqHead)
                .stubs()
                .will(returnValue(RT_ERROR_NONE));
        MOCKER_CPP_VIRTUAL(driver, &Driver::EnableSq)
                .stubs()
                .will(returnValue(RT_ERROR_NONE));
        rtSetDevice(0);

        device_ = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
        engine_ = ((RawDevice *)device_)->engine_;
        rtError_t res = rtStreamCreate(&streamHandle_, 0);
        EXPECT_EQ(res, RT_ERROR_NONE);
        stream_ = (Stream *)streamHandle_;

        grp_ = new DvppGrp(device_, 0);
        rtDvppGrp_t grp_t = (rtDvppGrp_t *)grp_;
        rtError_t ret = rtStreamCreateByGrp(&streamHandleDvpp_, 0, 0, grp_t);
        streamDvpp_ = (Stream *)streamHandleDvpp_;
        streamDvpp_->SetLimitFlag(true);
        EXPECT_EQ(res, RT_ERROR_NONE);
    }

    virtual void TearDown()
    {
        if (stream_->GetPendingNum() > 0) {
            stream_->pendingNum_.Set(0U);
        }
        if (engine_->GetPendingNum() > 0) {
            engine_->pendingNum_.Set(0U);
        }
        rtStreamDestroy(streamHandle_);
        rtStreamDestroy(streamHandleDvpp_);
        delete grp_;
        stream_ = nullptr;
        streamDvpp_ = nullptr;
        engine_ = nullptr;
        ((Runtime *)Runtime::Instance())->DeviceRelease(device_);
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }

protected:
    Device *device_ = nullptr;
    Stream *stream_ = nullptr;
    Stream *streamDvpp_ = nullptr;
    Engine *engine_ = nullptr;
    DvppGrp *grp_ = nullptr;
    rtStream_t streamHandle_ = 0;
    rtStream_t streamHandleDvpp_ = 0;
    static rtChipType_t originType_;
};

rtChipType_t OthersStarsEngineTest::originType_ = CHIP_MINI;


TEST_F(OthersStarsEngineTest, MonitorForWatchDog_02)
{
    rtError_t error;
    uint16_t streamId;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    originType_ = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_MINI_V3);
    GlobalContainer::SetRtChipType(CHIP_MINI_V3);
    StarsEngine engine(device_);
    DeviceErrorProc *errorProc = new DeviceErrorProc(device_);
    EXPECT_NE(errorProc, nullptr);
    MOCKER_CPP_VIRTUAL((RawDevice *)device_, &RawDevice::ReportRingBuffer).stubs().will(returnValue(RT_ERROR_TASK_MONITOR));
    error = device_->ReportRingBuffer(&streamId);
    EXPECT_EQ(error, RT_ERROR_TASK_MONITOR);
    engine.MonitorForWatchDog(device_);
    delete errorProc;
    rtInstance->SetChipType(originType_);
        GlobalContainer::SetRtChipType(originType_);
}
