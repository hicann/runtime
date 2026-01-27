/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include <fstream>
#include <functional>
#include <thread>
#include "mockcpp/mockcpp.hpp"
#include "dump_args.h"
#include "runtime/rt.h"
#include "adump_pub.h"
#include "dump_file.h"
#include "dump_manager.h"
#include "dump_file_checker.h"
#include "sys_utils.h"
#include "dump_memory.h"
#include "file.h"
#include "adx_exception_callback.h"
#include "lib_path.h"
#include "dump_tensor_plugin.h"
#include "thread_manager.h"

using namespace Adx;

class TinyExceptionCallBackUtest : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

/* == dlopen test == */
static int32_t HeadProcessTest(uint32_t devId, const void *addr, uint64_t headerSize, uint64_t &newHeaderSize)
{
    (void)devId;
    (void)addr;
    newHeaderSize = headerSize + 1;
    return 0;
}

static int32_t TensorProcessTest(uint32_t devId, const void *addr, uint64_t size, int32_t fd)
{
    (void)devId;
    (void)addr;
    (void)size;
    (void)fd;
    return 0;
}

TEST_F(TinyExceptionCallBackUtest, Test_TensorPluginRegister)
{
    EXPECT_EQ(AdumpRegHeadProcess(DfxTensorType::MC2_CTX, &HeadProcessTest), 0);
    EXPECT_EQ(AdumpRegTensorProcess(DfxTensorType::MC2_CTX, &TensorProcessTest), 0);
}