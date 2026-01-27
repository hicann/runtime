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

class KernelTest : public testing::Test
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

TEST_F(KernelTest, kernel_create)
{
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    int32_t fun1;
    Kernel * k1 = new Kernel(&fun1, "f1", "", program, 10);

    EXPECT_EQ(k1->Name_(), "f1");
    EXPECT_EQ(k1->Stub_(), &fun1);
    EXPECT_EQ(k1->Offset_(), 10);
    EXPECT_EQ((Program *)k1->Program_(), program);

    delete k1;
}

TEST_F(KernelTest, kernel_create_second)
{
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    int32_t fun1;
    Kernel * k1 = new Kernel(&fun1, "f1", 1, program, 10);

    EXPECT_EQ(k1->Name_(), "f1");
    EXPECT_EQ(k1->Stub_(), &fun1);
    EXPECT_EQ(k1->Offset_(), 10);
    EXPECT_EQ(k1->TilingKey(), 1);
    EXPECT_EQ((Program *)k1->Program_(), program);

    delete k1;
}

TEST_F(KernelTest, kernel_create_third)
{
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    int32_t fun1;
    Kernel * k1 = new Kernel(&fun1, "f1", 1, program, 10);
    k1->SetMixType(3);
    k1->SetOffset2(11);
    EXPECT_EQ(k1->Name_(), "f1");
    EXPECT_EQ(k1->Stub_(), &fun1);
    EXPECT_EQ(k1->Offset_(), 10);
    EXPECT_EQ(k1->TilingKey(), 1);
    EXPECT_EQ(k1->Offset2_(), 11);
    EXPECT_EQ(k1->GetMixType(), 3);
    EXPECT_EQ((Program *)k1->Program_(), program);

    delete k1;
}

TEST_F(KernelTest, kernel_lookup)
{
    rtError_t error;
    KernelTable table;
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    int32_t fun1, fun2;

    MOCKER_CPP(&Runtime::GetProgram)
        .stubs()
        .will(returnValue(true));

    Kernel * k1 = new Kernel(&fun1, "f1", "", program, 10);
    Kernel * k2 = new Kernel(&fun2, "f2", "", program, 10);

    error = table.Add(k1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = table.Add(k2);
    EXPECT_EQ(error, RT_ERROR_NONE);
    auto &str = program->GetKernelNamesBuffer();
    const Kernel *kernel;

    kernel = table.Lookup(&fun1);
    EXPECT_EQ(kernel, k1);

    kernel = table.Lookup(&fun2);
    EXPECT_EQ(kernel, k2);
}

TEST_F(KernelTest, kernel_remove)
{
    rtError_t error;
    KernelTable table;
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    int32_t fun1, fun2;

    Kernel * k1 = new Kernel(&fun1, "f1", "", program, 10);
    Kernel * k2 = new Kernel(&fun2, "f2", "", program, 10);

    error = table.Add(k1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = table.Add(k2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = table.RemoveAll(program);
    EXPECT_EQ(error, RT_ERROR_NONE);

    const Kernel *kernel;

    kernel = table.Lookup(&fun1);
    EXPECT_EQ(kernel, (const Kernel *)NULL);

    kernel = table.Lookup(&fun2);
    EXPECT_EQ(kernel, (const Kernel *)NULL);
}

TEST_F(KernelTest, kernel_alloc_kernel_arr)
{
    rtError_t error;
    KernelTable table;
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    int32_t fun[2049], f[2049];
    Kernel * k[2049];

    for(int i = 0; i < 2049; i++)
    {
        k[i] = new Kernel(&fun[i], "f[i]", "", program, 10);

        error = table.Add(k[i]);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }

    error = table.AllocKernelArr();
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(KernelTest, kernel_all_kernel_add)
{
    rtError_t error;
    KernelTable table;

    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;

    PlainProgram stubProg2(Program::MACH_AI_CPU);
    Program *program2 = &stubProg2;
    uint64_t key1 = 1U;
    uint64_t key2 = 2U;
    Kernel *k1 = new Kernel(nullptr, "", key1, program, 10);
    Kernel *k2 = new Kernel(nullptr, "", key2, program, 10);
    Kernel *k3 = new Kernel(nullptr, "", key1, program2, 10);
    bool addKernelFlag = true;

    program->kernelCount_ = 2;
    program2->kernelCount_ = 1;
    if (program->KernelTable_ == nullptr) {
        program->KernelTable_ = new rtKernelArray_t[program->kernelCount_];
    }

    if (program2->KernelTable_ == nullptr) {
        program2->KernelTable_ = new rtKernelArray_t[program2->kernelCount_];
    }

    error = program->AllKernelAdd(k1, addKernelFlag);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = program->AllKernelAdd(k1, addKernelFlag);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = program2->AllKernelAdd(k3, addKernelFlag);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(&Runtime::GetProgram)
        .stubs()
        .will(returnValue(true));

    const Kernel *kernel;
    kernel = program->AllKernelLookup(1);
    EXPECT_NE(kernel, (const Kernel *)NULL);

    error = program->AllKernelAdd(k2, addKernelFlag);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = table.RemoveAll(program);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = table.RemoveAll(program2);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(KernelTest, kernel_info_extern_lookup)
{
    rtError_t error;
    KernelTable table;
    PlainProgram stubProg(Program::MACH_AI_CPU);
    Program *program = &stubProg;
    int32_t fun1, fun2;

    MOCKER_CPP(&Runtime::GetProgram)
        .stubs()
        .will(returnValue(true));
    Kernel * k1 = new Kernel(&fun1, "f1", "", program, 10);
    error = table.Add(k1);
    const char_t * const stubFunc = "test";
    const Kernel *tempKernel = table.KernelInfoExtLookup(stubFunc);
    EXPECT_EQ(tempKernel, nullptr);
}