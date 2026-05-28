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
#include <iostream>

using namespace testing;

class AdumpBaseTinyEnvironment : public testing::Environment
{
public:
    virtual void SetUp()
    {
        std::cout << "Adump base tiny environment setup" << std::endl;
    }
    virtual void TearDown()
    {
        std::cout << "Adump base tiny environment teardown" << std::endl;
    }
};

int main(int argc, char* argv[])
{
    testing::AddGlobalTestEnvironment(new AdumpBaseTinyEnvironment);
    GTEST_FLAG(break_on_failure) = 0;
    GTEST_FLAG(repeat) = 1;
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
