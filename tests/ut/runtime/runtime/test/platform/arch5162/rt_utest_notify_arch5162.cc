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
#include <memory>
#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#include "runtime/rts/rts_event.h"

#define protected public
#define private public
#include "context.hpp"
#include "inner_thread_local.hpp"
#include "notify.hpp"
#include "npu_driver.hpp"
#include "raw_device.hpp"
#include "runtime.hpp"
#include "stream.hpp"
#include "task.hpp"
#include "thread_local_container.hpp"
#undef private
#undef protected

#include "api_impl.hpp"
#include "dev_info_manage.h"
#include "notify_task.h"

using namespace cce::runtime;

class Arch5162NotifyTest : public testing::Test {
protected:
    Arch5162NotifyTest() : device_(0U), taskFactory_(&device_), stream_(&device_, 0U), context_(&device_, true) {}

    static void SetUpTestCase() { std::cout << "Arch5162NotifyTest test start" << std::endl; }

    static void TearDownTestCase() { std::cout << "Arch5162NotifyTest test end" << std::endl; }

    void SetUp() override
    {
        origGlobalChipType_ = GlobalContainer::GetRtChipType();
        GlobalContainer::SetRtChipType(CHIP_5162A);

        rtInstance_ = static_cast<Runtime*>(Runtime::Instance());
        ASSERT_NE(rtInstance_, nullptr);
        origChipType_ = rtInstance_->GetChipType();
        rtInstance_->SetChipType(CHIP_5162A);

        origCurChipProperties_ = rtInstance_->curChipProperties_;
        DevProperties props;
        if (GET_DEV_PROPERTIES(CHIP_5162A, props) == RT_ERROR_NONE) {
            rtInstance_->curChipProperties_ = props;
        }

        driver_ = std::make_unique<NpuDriver>();
        device_.driver_ = driver_.get();
        device_.taskFactory_ = &taskFactory_;
        context_.SetState(ContextState::CTX_STATE_ACTIVE);
        context_.SetDefaultStream(&stream_);
        InnerThreadLocalContainer::SetCurCtx(&context_, true);
    }

    void TearDown() override
    {
        InnerThreadLocalContainer::SetCurCtx(nullptr);
        context_.SetDefaultStream(nullptr);
        context_.device_ = nullptr;
        stream_.device_ = nullptr;
        device_.taskFactory_ = nullptr;
        device_.driver_ = nullptr;
        driver_.reset();

        if (rtInstance_ != nullptr) {
            rtInstance_->SetChipType(origChipType_);
            rtInstance_->curChipProperties_ = origCurChipProperties_;
        }
        GlobalContainer::SetRtChipType(origGlobalChipType_);
        GlobalMockObject::verify();
    }

    Runtime* rtInstance_ = nullptr;
    rtChipType_t origGlobalChipType_ = CHIP_BEGIN;
    rtChipType_t origChipType_ = CHIP_BEGIN;
    DevProperties origCurChipProperties_;
    std::unique_ptr<NpuDriver> driver_;
    RawDevice device_;
    TaskFactory taskFactory_;
    Stream stream_;
    Context context_;
};

drvError_t testResourceIdAlloc(uint32_t devId, struct halResourceIdInputInfo* in, struct halResourceIdOutputInfo* out)
{
    out->resourceId = 0;
    return DRV_ERROR_NONE;
}

TEST_F(Arch5162NotifyTest, api_impl_stub)
{
    ApiImpl impl;
    EXPECT_EQ(impl.NotifyGetAddrOffset(nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(impl.GetNotifyAddress(nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(impl.GetNotifyPhyInfo(nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(impl.NotifyReset(nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);

    // ipc notify
    EXPECT_EQ(impl.IpcSetNotifyName(nullptr, nullptr, 0, 0), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(impl.IpcOpenNotify(nullptr, nullptr, 0), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(impl.SetIpcNotifyPid(nullptr, nullptr, 0), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(impl.ShrIdSetPodPid(nullptr, 0, 0), RT_ERROR_FEATURE_NOT_SUPPORT);

    // cnt notify
    EXPECT_EQ(impl.CntNotifyCreate(0, nullptr, 0), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(impl.CntNotifyDestroy(nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(impl.CntNotifyRecord(nullptr, nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(impl.CntNotifyWaitWithTimeout(nullptr, nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(impl.CntNotifyReset(nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(impl.GetCntNotifyAddress(nullptr, nullptr, NOTIFY_TYPE_MAX), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(impl.GetCntNotifyId(nullptr, nullptr), RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(Arch5162NotifyTest, notify_record_success)
{
    MOCKER(halResourceIdAlloc).stubs().will(invoke(testResourceIdAlloc));
    TaskInfo task = {};
    task.stream = &stream_;
    MOCKER_CPP(&Stream::AllocTask).expects(exactly(2)).will(returnValue(&task));
    MOCKER_CPP_VIRTUAL(static_cast<Device*>(&device_), &Device::SubmitTask)
        .expects(exactly(2))
        .will(returnValue(RT_ERROR_NONE));

    Notify notify(0U, 0U);
    EXPECT_EQ(notify.Setup(), RT_ERROR_NONE);
    EXPECT_EQ(notify.GetNotifyId(), 0U);
    EXPECT_EQ(notify.Record(&stream_), RT_ERROR_NONE);
    EXPECT_EQ(notify.Wait(&stream_, 600U), RT_ERROR_NONE);
}

TEST_F(Arch5162NotifyTest, notify_record_taskinit_error)
{
    MOCKER(halResourceIdAlloc).stubs().will(invoke(testResourceIdAlloc));
    MOCKER(NotifyRecordTaskInit).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    MOCKER(NotifyWaitTaskInit).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    TaskInfo task = {};
    task.stream = &stream_;
    MOCKER_CPP(&Stream::AllocTask).expects(exactly(2)).will(returnValue(&task));
    MOCKER_CPP(&TaskFactory::Recycle).expects(exactly(2)).will(returnValue(0));

    Notify notify(0U, 0U);
    EXPECT_EQ(notify.Setup(), RT_ERROR_NONE);
    EXPECT_EQ(notify.Record(&stream_), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(notify.Wait(&stream_, 600U), RT_ERROR_INVALID_VALUE);
}

TEST_F(Arch5162NotifyTest, notify_record_tasksubmit_error)
{
    MOCKER(halResourceIdAlloc).stubs().will(invoke(testResourceIdAlloc));
    TaskInfo task = {};
    task.stream = &stream_;
    MOCKER_CPP(&Stream::AllocTask).expects(exactly(2)).will(returnValue(&task));
    MOCKER_CPP_VIRTUAL(static_cast<Device*>(&device_), &Device::SubmitTask)
        .expects(exactly(2))
        .will(returnValue(RT_ERROR_INVALID_VALUE));
    MOCKER_CPP(&TaskFactory::Recycle).expects(exactly(2)).will(returnValue(0));

    Notify notify(0U, 0U);
    EXPECT_EQ(notify.Setup(), RT_ERROR_NONE);
    EXPECT_EQ(notify.Record(&stream_), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(notify.Wait(&stream_, 600U), RT_ERROR_INVALID_VALUE);
}