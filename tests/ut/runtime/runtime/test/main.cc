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
#include "runtime/rt.h"
#include "device.hpp"
#include "engine.hpp"
#include "runtime.hpp"
#include "mockcpp/mockcpp.hpp"

using namespace cce::runtime;

class RtEnvironment : public testing::Environment
{
public:
    virtual void SetUp()
    {
        MOCKER(drvMemAddressTranslate).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
        rtSetDevice(0);
        GlobalMockObject::verify();
        std::cout << "Runtime UT Environment SetUP" << std::endl;
    }
    virtual void TearDown()
    {
        rtDeviceReset(0);
        std::cout << "Runtime UT  Environment TearDown" << std::endl;
    }
};

extern "C" void *__real_malloc (size_t c);
extern "C" void *
__wrap_malloc (size_t c)
{
    return __real_malloc (c);
}


int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
