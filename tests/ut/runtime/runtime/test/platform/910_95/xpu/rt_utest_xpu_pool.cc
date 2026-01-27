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
#include "runtime/rt.h"
#define private public
#define protected public
#include "h2h_copy_mgr.hpp"
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

using namespace testing;
using namespace cce::runtime;

class XpuPoolTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout<<"xpuPool test start"<<std::endl;

    }

    static void TearDownTestCase()
    {
        std::cout<<"xpuPool test start end"<<std::endl;

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

TEST_F(XpuPoolTest, Xpu_Pool_Fail_01)
{
    H2HCopyMgr* h2hCopyMgr = new (std::nothrow) H2HCopyMgr(10, 10,
    100, BufferAllocator::LINEAR, H2HCopyPolicy::H2H_POLICY_DEFAULT);
    void* tmp = h2hCopyMgr->AllocHostMem();
    EXPECT_EQ(tmp, nullptr);
    MOCKER(malloc).stubs().will(returnValue((void *)NULL));
    const uint32_t size = 100;
    void* tmp1 = h2hCopyMgr->AllocHostMem(size);
    EXPECT_EQ(tmp1, nullptr);
    delete h2hCopyMgr;
}

TEST_F(XpuPoolTest, Xpu_Pool_Fail_02)
{
    H2HCopyMgr* h2hCopyMgr = new (std::nothrow) H2HCopyMgr(10, 10,
    100, BufferAllocator::LINEAR, H2HCopyPolicy::H2H_COPY_POLICY_SYNC);
    void *item = nullptr;
    h2hCopyMgr->FreeHostMem(item);
    delete h2hCopyMgr;
}

TEST_F(XpuPoolTest, Xpu_Pool_Fail_03)
{
    H2HCopyMgr* h2hCopyMgr = new (std::nothrow) H2HCopyMgr(10, 10,
    100, BufferAllocator::LINEAR, H2HCopyPolicy::H2H_COPY_POLICY_SYNC);
    void *item = nullptr;
    MOCKER(malloc).stubs().will(returnValue((void *)NULL));
    const size_t size = 100;
    void * const para = (void*)100;
    h2hCopyMgr->MallocBuffer(size, para);
    delete h2hCopyMgr;
}

TEST_F(XpuPoolTest, Xpu_Pool_Fail_04)
{
    H2HCopyMgr* h2hCopyMgr = new (std::nothrow) H2HCopyMgr(10, 10,
    100, BufferAllocator::LINEAR, H2HCopyPolicy::H2H_COPY_POLICY_SYNC);
    void *dst = nullptr;
    const void * const src = (void*)100;
    const uint32_t size = 100;
    h2hCopyMgr->H2DMemCopy(dst, src, size);
    MOCKER(memcpy_s).stubs().will(returnValue(1));
    void* a = malloc(10);
    void* b = malloc(10);
    h2hCopyMgr->H2DMemCopy(a, b, 10);
    free(a);
    free(b);  
    delete h2hCopyMgr;
}
