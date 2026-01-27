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
#include "securec.h"
#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#define private public
#define protected public
#include "pool.hpp"
#include "runtime.hpp"
#include "event.hpp"
#undef private
#undef protected
#include "device.hpp"
#include "engine.hpp"
#include "scheduler.hpp"
#include "task_info.hpp"
#include "npu_driver.hpp"
#include "context.hpp"
#include <map>
#include <utility>  // For std::pair and std::make_pair.

using namespace testing;
using namespace cce::runtime;

class PoolTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout<<"pool test start"<<std::endl;

    }

    static void TearDownTestCase()
    {
        std::cout<<"pool test start end"<<std::endl;

    }

    virtual void SetUp()
    {
        rtSetDevice(0);
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }
};