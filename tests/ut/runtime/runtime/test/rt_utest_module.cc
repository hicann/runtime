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
#include "driver/ascend_hal.h"
#define private public
#define protected public
#include "module.hpp"
#include "device.hpp"
#include "program.hpp"
#include "runtime.hpp"

#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;

class ModuleTest : public testing::Test
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
        rtSetDevice(0);
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        rtDeviceReset(0);
    }
};

class TestProgram : public Program
{
public:
    TestProgram()
    {
        machine_ = Program::MACH_AI_CORE;
        offset_ = 0;
        loadSize_ = 100;
        extractResult_ = RT_ERROR_NONE;
    }

    uint32_t SymbolOffset(const void *symbol)
    {
        return offset_;
    }
    uint32_t LoadSize()
    {
        return loadSize_;
    }
    rtError_t LoadExtract(void *output, uint32_t size)
    {
        return extractResult_;
    }
    void *Data()
    {
        return binary_;
    }

    uint32_t offset_;
    uint32_t loadSize_;
    rtError_t extractResult_;
};