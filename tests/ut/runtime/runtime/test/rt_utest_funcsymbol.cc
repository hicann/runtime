/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "runtime/rt.h"
#include "runtime/inner_kernel.h"
#include "runtime.hpp"
#include "kernel/program.hpp"
#include "kernel/elf.hpp"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

using namespace testing;
using namespace cce::runtime;

class FuncSymbolTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "funcsymbol test start" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "funcsymbol test end" << std::endl;
    }

    virtual void SetUp()
    {
        prog_ = CreateMockElfProgram();
    }

    virtual void TearDown()
    {
        delete prog_;
        prog_ = nullptr;
        GlobalMockObject::verify();
    }

    ElfProgram *CreateMockElfProgram()
    {
        ElfProgram *prog = new ElfProgram(RT_KERNEL_ATTR_TYPE_AICPU);
        uint64_t tilingValue = 0ULL;
        Kernel *kernelPtr = new (std::nothrow) Kernel("test_funcsymbol", tilingValue, prog, RT_KERNEL_ATTR_TYPE_AICORE, 0, 0, NO_MIX);

        EXPECT_NE(kernelPtr, nullptr);

        uint32_t error = prog->KernelNameMapAdd(kernelPtr);
        EXPECT_EQ(error, RT_ERROR_NONE);
        return prog;
    }

    ElfProgram *prog_ = nullptr;
    int symbol_ = 0;
};


TEST_F(FuncSymbolTest, rtRegisterFuncSymbol_NullSymbol)
{
    Runtime* const rtInstance = Runtime::Instance();
    const Kernel *retKernel = rtInstance->funcSymbolTable_.Lookup(&symbol_);
    EXPECT_EQ(retKernel, nullptr);
}
TEST_F(FuncSymbolTest, rtRegisterFuncSymbol_Success)
{
    Runtime* const rtInstance = Runtime::Instance();
    rtError_t error = rtInstance->funcSymbolTable_.Register(prog_, &symbol_, "test_funcsymbol");
    EXPECT_EQ(error, RT_ERROR_NONE);
    const Kernel *retKernel = rtInstance->funcSymbolTable_.Lookup(&symbol_);
    EXPECT_NE(retKernel, nullptr);
}