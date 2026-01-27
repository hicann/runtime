/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cstdio>
#include <cstdlib>

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#define private public
#define protected public
#include "engine.hpp"
#include "event.hpp"
#include "ctrl_stream.hpp"
#include "scheduler.hpp"
#include "runtime.hpp"
#include "hwts.hpp"
#undef private
#undef protected
#include "context.hpp"
#include "securec.h"
#include "api.hpp"
#include "npu_driver.hpp"
#include "raw_device.hpp"
#include "ctrl_res_pool.hpp"
#include "thread_local_container.hpp"

using namespace testing;
using namespace cce::runtime;

static uint16_t ind = 0;

class CtrlStreamTest : public testing::Test {
public:
    static Api        *oldApi_;
    static rtStream_t stream_;
    static rtEvent_t  event_;
    static void      *binHandle_;
    static char       function_;
    static uint32_t   binary_[32];

protected:
    static void SetUpTestCase()
    {
        std::cout<<"stream test start"<<std::endl;
        (void)rtSetSocVersion("Ascend910");
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        ((Runtime *)Runtime::Instance())->SetDisableThread(true);
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(CHIP_CLOUD);
        GlobalContainer::SetRtChipType(CHIP_CLOUD);
        (void)rtSetTSDevice(0);
        GlobalMockObject::verify();
    }

    static void TearDownTestCase()
    {
        std::cout<<"stream test end"<<std::endl;
        ((Runtime *)Runtime::Instance())->SetDisableThread(false);
    }

    virtual void SetUp()
    {
        GlobalMockObject::reset();
        (void)rtSetDevice(0);
    }

    virtual void TearDown()
    {
        ind = 0;
        rtDeviceReset(0);
        GlobalMockObject::reset();
    }
};

Api * CtrlStreamTest::oldApi_ = nullptr;
rtStream_t CtrlStreamTest::stream_ = nullptr;
rtEvent_t CtrlStreamTest::event_ = nullptr;
void* CtrlStreamTest::binHandle_ = nullptr;
char  CtrlStreamTest::function_ = 'a';
uint32_t CtrlStreamTest::binary_[32] = {};

TEST_F(CtrlStreamTest, SynchronizeTest)
{
}

class CtrlStreamResource {
public:
    CtrlStreamResource()
    {
        device_ = ((Runtime *)Runtime::Instance())->DeviceRetain(1, 0);
        ctrlRes_ = new (std::nothrow) CtrlResEntry();
        ctrlRes_->Init(device_);
    }
    ~CtrlStreamResource() noexcept
    {
        ((Runtime *)Runtime::Instance())->DeviceRelease(device_);
        DELETE_O(ctrlRes_);
    }
    Device* Dev() const
    {
        return device_;
    }
    CtrlResEntry* CtrlRes() const
    {
        return ctrlRes_;
    }
private:
    Device  *device_;
    CtrlResEntry* ctrlRes_;
};

rtError_t CtrlSqCqAllocateStub(Driver *This, const uint32_t deviceId,
    const uint32_t tsId, uint32_t * const sqId,
    uint32_t * const cqId, const uint32_t logicCqId)
{
    return DRV_ERROR_INVALID_VALUE;
}

rtError_t LogicCqFreeStub(Driver *This, const uint32_t devId, const uint32_t tsId, const uint32_t cqId)
{
    return DRV_ERROR_INVALID_VALUE;
}

rtError_t utest_get_head_pos_from_ctrl_sq(CtrlStream *This, uint32_t &sqHead)
{
    sqHead = 0;
    return RT_ERROR_NONE;
}

