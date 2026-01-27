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
#define private public
#include "runtime.hpp"
#include "program.hpp"
#undef private
#include "kernel.hpp"
#include "thread_local_container.hpp"

using namespace testing;
using namespace cce::runtime;

class ChipKernelTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(ChipKernelTest, kernel_create_for_solomon)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t curChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_CLOUD_V5);
    GlobalContainer::SetRtChipType(CHIP_CLOUD_V5);
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    int32_t fun1;
    Kernel * k1 = new Kernel(&fun1, "f1", "", program, 10);

    EXPECT_EQ(k1->Name_(), "f1");
    EXPECT_EQ(k1->Stub_(), &fun1);
    EXPECT_EQ(k1->Offset_(), 10);
    EXPECT_EQ((Program *)k1->Program_(), program);
    rtInstance->SetChipType(curChipType);
    delete k1;
}

TEST_F(ChipKernelTest, kernel_create_for_second_solomon)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t curChipType = rtInstance->GetChipType();
    rtInstance->SetChipType(CHIP_CLOUD_V5);
    GlobalContainer::SetRtChipType(CHIP_CLOUD_V5);
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    int32_t fun1;
    Kernel * k1 = new Kernel(&fun1, "f1", 1, program, 10);

    EXPECT_EQ(k1->Name_(), "f1");
    EXPECT_EQ(k1->Stub_(), &fun1);
    EXPECT_EQ(k1->Offset_(), 10);
    EXPECT_EQ(k1->TilingKey(), 1);
    EXPECT_EQ((Program *)k1->Program_(), program);
    rtInstance->SetChipType(curChipType);
    delete k1;
}