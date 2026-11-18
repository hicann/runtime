/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#define protected public
#include "runtime.hpp"
#include "thread_local_container.hpp"
#include "device.hpp"
#include "cnt_notify_res.hpp"
#include "npu_driver.hpp"
#undef private
#undef protected
#include "aicpu_timeout_control.h"
#include "../../rt_utest_config_define.hpp"

using namespace testing;
using namespace cce::runtime;

static bool g_cntResDisableThread = false;
static rtChipType_t g_cntResChipType = CHIP_DAVID;

class CntNotifyResTest : public testing::Test {
protected:
    static void SetUpTestCase() {}

    static void TearDownTestCase() {}

    void SetUp() override
    {
        Runtime* rtInstance = (Runtime*)Runtime::Instance();
        g_cntResDisableThread = rtInstance->GetDisableThread();
        g_cntResChipType = rtInstance->GetChipType();
        rtInstance->SetDisableThread(true);
        // 用例直接构造 CntNotifyRes 并校验 950 驱动资源的引用计数释放路径，需固定芯片类型；TearDown 恢复原值
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
        MOCKER(AicpuTimeoutControl::CheckKernelSupported).stubs().will(returnValue(RT_ERROR_NONE));
        rtSetDevice(0);
        (void)rtSetSocVersion("Ascend950PR_9599");
        dev_ = rtInstance->DeviceRetain(0, 0);
        ASSERT_NE(dev_, nullptr);
    }

    void TearDown() override
    {
        Runtime* rtInstance = (Runtime*)Runtime::Instance();
        rtInstance->DeviceRelease(dev_);
        rtDeviceReset(0);
        rtInstance->SetDisableThread(g_cntResDisableThread);
        rtInstance->SetChipType(g_cntResChipType);
        GlobalContainer::SetRtChipType(g_cntResChipType);
        GlobalMockObject::verify();
        GlobalMockObject::reset();
    }

    Device* dev_ = nullptr;
};

// owner 最后释放：在途引用先释放不触发驱动释放，owner 末位释放触发一次 NotifyIdFree 并自回收
TEST_F(CntNotifyResTest, OwnerReleaseLastTriggersNotifyIdFreeOnce)
{
    CntNotifyRes* res = new (std::nothrow) CntNotifyRes(dev_, 0U, 5U);
    ASSERT_NE(res, nullptr);
    res->Acquire(); // owner 引用
    res->Acquire(); // 在途任务引用
    EXPECT_EQ(res->GetNotifyId(), 5U);

    MOCKER_CPP_VIRTUAL((NpuDriver*)dev_->Driver_(), &NpuDriver::NotifyIdFree)
        .expects(once())
        .will(returnValue(RT_ERROR_NONE));

    res->Release();                    // 在途引用释放：refs 2->1，不应触发 NotifyIdFree
    EXPECT_EQ(res->GetNotifyId(), 5U); // 对象仍存活可用
    res->ReleaseOwner();               // owner 末位释放：refs 1->0，NotifyIdFree 一次 + delete this
}

// owner 先销毁：在途引用存活期间不释放，末位在途引用释放触发一次 NotifyIdFree 并自回收
TEST_F(CntNotifyResTest, OwnerGoneThenLastInflightReleaseSelfDeletes)
{
    CntNotifyRes* res = new (std::nothrow) CntNotifyRes(dev_, 0U, 6U);
    ASSERT_NE(res, nullptr);
    res->Acquire(); // owner 引用
    res->Acquire(); // 在途任务引用 1
    res->Acquire(); // 在途任务引用 2

    MOCKER_CPP_VIRTUAL((NpuDriver*)dev_->Driver_(), &NpuDriver::NotifyIdFree)
        .expects(once())
        .will(returnValue(RT_ERROR_NONE));

    res->ReleaseOwner();               // owner 释放：refs 3->2，不应触发 NotifyIdFree
    res->Release();                    // 在途引用释放：refs 2->1，不应触发 NotifyIdFree
    EXPECT_EQ(res->GetNotifyId(), 6U); // 仍有在途引用，对象存活可用
    res->Release();                    // 末位在途引用释放：refs 1->0，NotifyIdFree 一次 + delete this
}
