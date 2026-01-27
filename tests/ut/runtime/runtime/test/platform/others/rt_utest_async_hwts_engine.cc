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
#include "async_hwts_engine.hpp"
#include "runtime.hpp"
#include "event.hpp"
#include "logger.hpp"
#include "raw_device.hpp"
#undef private
#undef protected
#include "scheduler.hpp"
#include "hwts.hpp"
#include "stream.hpp"
#include "npu_driver.hpp"
#include "context.hpp"
#include "arg_loader.hpp"
#include "task_fail_callback_manager.hpp"
#include "device/device_error_proc.hpp"
#include <map>
#include <utility>  // For std::pair and std::make_pair.
#include "mmpa_api.h"
#include "thread_local_container.hpp"

using namespace testing;
using namespace cce::runtime;

class AsyncHwtsEngineTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        std::cout<<"AsyncHwtsEngine test start"<<std::endl;

    }

    static void TearDownTestCase()
    {
        std::cout<<"AsyncHwtsEngine test end"<<std::endl;

    }

    virtual void SetUp()
    {
        GlobalMockObject::verify();
        (void)rtSetSocVersion("Ascend310");
        rt_ = const_cast<Runtime *>(Runtime::Instance());
        EXPECT_NE(rt_, nullptr);
        originType_ = rt_->GetChipType();
        originThread_ = rt_->GetDisableThread();
        rt_->SetChipType(CHIP_BEGIN);
        GlobalContainer::SetRtChipType(CHIP_BEGIN);

        driver_ = rt_->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP(&Stream::SubmitCreateStreamTask).stubs().will(returnValue(RT_ERROR_NONE));

        int64_t hardwareVersion = CHIP_BEGIN << 8;
        driver_ = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver_,
            &Driver::GetDevInfo).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(),outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
            .will(returnValue(RT_ERROR_NONE));
        MOCKER(halGetSocVersion).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any()).will(returnValue(DRV_ERROR_NOT_SUPPORT));
        MOCKER(halGetDeviceInfo).stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&hardwareVersion, sizeof(hardwareVersion))).will(returnValue(RT_ERROR_NONE));

        MOCKER_CPP_VIRTUAL((NpuDriver*)(driver_), &NpuDriver::GetRunMode).stubs().will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

        rtError_t error = rtSetDevice(0);
        EXPECT_EQ(error, RT_ERROR_NONE);

        device_ = rt_->DeviceRetain(0, 0);
        engine_ = ((RawDevice *)device_)->engine_;
        rtError_t res = rtStreamCreate(&streamHandle_, 0);
        EXPECT_EQ(res, RT_ERROR_NONE);
        stream_ = (Stream *)streamHandle_;
    }

    virtual void TearDown()
    {
        rtStreamDestroy(streamHandle_);
        stream_ = nullptr;
        engine_ = nullptr;
        rt_->DeviceRelease(device_);
        rtError_t error = rtDeviceReset(0);
        EXPECT_EQ(error, RT_ERROR_NONE);
        device_ = nullptr;
        rt_->SetChipType(originType_);
        GlobalContainer::SetRtChipType(originType_);
        rt_->SetDisableThread(originThread_);
        GlobalMockObject::verify();
    }

protected:
    Device *device_ = nullptr;
    Stream *stream_ = nullptr;
    Engine *engine_ = nullptr;
    rtStream_t streamHandle_ = 0;

    rtChipType_t originType_;
    bool originThread_;
    Runtime *rt_ = nullptr;
    Driver *driver_ = nullptr;
};

TEST_F(AsyncHwtsEngineTest, Run_WithWrongThreadType)
{
    std::unique_ptr<Engine> engine = std::make_unique<AsyncHwtsEngine>(device_);
    uint32_t threadType = 4U;
    void * const typeParm = reinterpret_cast<void *>(static_cast<uintptr_t>(threadType));
    std::unique_ptr<Thread> testThread(OsalFactory::CreateThread("test_thread", engine.get(), typeParm));
    EXPECT_NE(testThread, nullptr);
    rtError_t error = testThread->Start();
    EXPECT_EQ(error, EN_OK);
    testThread->Join();
}

TEST_F(AsyncHwtsEngineTest, ProcessErrorReport_ErrorReport)
{
    rtTaskReport_t report;
    report.payLoad = 0x2f;

    rtTsReport_t errorReport;
    errorReport.msgType = TS_REPORT_MSG_TYPE_TS_REPORT;
    errorReport.msgBuf.tsReport = &report;

    std::shared_ptr<AsyncHwtsEngine> egine = std::make_unique<AsyncHwtsEngine>(device_);
    egine->ProcessErrorReport(errorReport);
    errorReport.msgType = TS_REPORT_MSG_TYPE_STARS_CQE;
    egine->ProcessErrorReport(errorReport);
    EXPECT_EQ(errorReport.msgBuf.tsReport->payLoad, 0x2f);
    GlobalMockObject::verify();
}

TEST_F(AsyncHwtsEngineTest, ReceivingRun_RT_PACKAGE_TYPE_TASK_REPORT)
{
    rtTaskReport_t report;
    report.payLoad = 0x2f;
    report.packageType = RT_PACKAGE_TYPE_TASK_REPORT;

    int32_t cqeCnt = 1;
    void *cqeReport = reinterpret_cast<void *>(&report);
    MOCKER_CPP_VIRTUAL(driver_, &Driver::ReportWait)
        .stubs()
        .with(outBound(cqeReport), outBound(&cqeCnt), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .then(returnValue(RT_ERROR_NONE));
    EXPECT_EQ(engine_->CheckReceiveThreadAlive(), true);
    GlobalMockObject::verify();
}

TEST_F(AsyncHwtsEngineTest, ReceivingRun_RT_PACKAGE_TYPE_ERROR_REPORT)
{
    rtTaskReport_t report;
    report.payLoad = 0x2f;
    report.packageType = RT_PACKAGE_TYPE_ERROR_REPORT;

    int32_t cqeCnt = 1;
    void *cqeReport = reinterpret_cast<void *>(&report);
    MOCKER_CPP_VIRTUAL(driver_, &Driver::ReportWait)
        .stubs()
        .with(outBound(cqeReport), outBound(&cqeCnt), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .then(returnValue(RT_ERROR_NONE));

    EXPECT_EQ(engine_->CheckReceiveThreadAlive(), true);
    GlobalMockObject::verify();
}