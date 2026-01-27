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
#include "singleton/singleton.h"

using namespace analysis::dvvp::common::singleton;

class SingletonClass : public Singleton<SingletonClass> {
};

class COMMON_SINGLETON_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }

    virtual void TearDown() {
    }
};

TEST_F(COMMON_SINGLETON_TEST, instance) {
    GlobalMockObject::verify();

    EXPECT_NE((SingletonClass *)NULL, SingletonClass::instance());
    EXPECT_NE((SingletonClass *)NULL, SingletonClass::instance());
}