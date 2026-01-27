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
#include "securec.h"
#include "runtime/rt.h"
#define private public
#include "runtime.hpp"
#undef private
#include "api.hpp"
#include "context.hpp"
#include "engine.hpp"
#include "task_info.hpp"
#include "pctrace.hpp"
#include <sys/time.h>
#include "npu_driver.hpp"
#include "raw_device.hpp"

using namespace testing;
using namespace cce::runtime;

class PCTraceTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        (void)rtSetDevice(0);
        rtError_t error1 = rtStreamCreate(&stream_, 0);
        for (uint32_t i = 0; i < sizeof(binary_)/sizeof(uint32_t); i++)
        {
            binary_[i] = i;
        }

        rtDevBinary_t devBin;
        devBin.magic = RT_DEV_BINARY_MAGIC_PLAIN;
        devBin.version = 1;
        devBin.length = sizeof(binary_);
        devBin.data = binary_;
        rtError_t error3 = rtDevBinaryRegister(&devBin, &binHandle_);
        rtError_t error4 = rtFunctionRegister(binHandle_, &function_, "foo", NULL, 1);
        std::cout<<"pctrace test start:"<<error1<<", "<<error3<<", "<<error4<<std::endl;
    }

    static void TearDownTestCase()
    {
        rtError_t error1 = rtStreamDestroy(stream_);
        rtError_t error3 = rtDevBinaryUnRegister(binHandle_);
        std::cout<<"pctrace test start end : "<<error1<<", "<<error3<<std::endl;
        rtDeviceReset(0);
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
         GlobalMockObject::verify();
    }

    static rtStream_t stream_;
    static void      *binHandle_;
    static char       function_;
    static uint32_t   binary_[32];
};

rtStream_t PCTraceTest::stream_ = NULL;
void* PCTraceTest::binHandle_ = NULL;
char  PCTraceTest::function_ = 'a';
uint32_t PCTraceTest::binary_[32] = {};

TEST_F(PCTraceTest, alloc_free_mem)
{
    void *ptr = nullptr;
    void *ptr1 = nullptr;
    PCTrace *rtPCtrace = new PCTrace();
    Device *device = new RawDevice(0);
    device->Init();

    Module *mdl = new Module(device);
    mdl->Load(static_cast<Program *>(binHandle_));

    rtPCtrace->Init(device, mdl);

    rtError_t error = rtPCtrace->AllocPCTraceMemory(&ptr, 8);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(ptr, nullptr);
    MOCKER(mmOpen2).stubs().will(returnValue(123));
    MOCKER(mmWrite).stubs().will(returnValue(8));
    error = rtPCtrace->WritePCTraceFile();
    EXPECT_EQ(error, RT_ERROR_PCTRACE_FILE);
    MOCKER(memset_s).stubs().will(returnValue(1));
    error = rtPCtrace->AllocPCTraceMemory(&ptr1, 32);
    EXPECT_EQ(error, RT_ERROR_SEC_HANDLE);
    EXPECT_EQ(ptr1, nullptr);
    device->ModuleRetain(mdl);
    delete rtPCtrace;
    delete mdl;
    delete device;
}

TEST_F(PCTraceTest, alloc_free_mem2)
{
    void *ptr = nullptr;
    PCTrace *rtPCtrace = new PCTrace();
    Device *device = new RawDevice(0);
    device->Init();

    Module *mdl = new Module(device);
    mdl->Load(static_cast<Program *>(binHandle_));

    rtPCtrace->Init(device, mdl);

    rtError_t error = rtPCtrace->AllocPCTraceMemory(&ptr, 32);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(ptr, nullptr);
    error = rtPCtrace->WritePCTraceFile();
    EXPECT_EQ(error, RT_ERROR_PCTRACE_FILE);
    device->ModuleRetain(mdl);
    delete rtPCtrace;
    delete mdl;
    delete device;
}

TEST_F(PCTraceTest, alloc_free_mem3)
{
    void *ptr = nullptr;
    PCTrace *rtPCtrace = new PCTrace();
    RawDevice *device = new RawDevice(0);
    device->Init();

    Module *mdl = new Module(device);
    mdl->Load(static_cast<Program *>(binHandle_));

    rtPCtrace->Init(device, mdl);

    rtError_t error = rtPCtrace->AllocPCTraceMemory(&ptr, 32);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(ptr, nullptr);
    MOCKER(mmOpen2).stubs().will(returnValue(123));
    error = rtPCtrace->WritePCTraceFile();
    EXPECT_EQ(error, RT_ERROR_PCTRACE_FILE);
    device->ModuleRetain(mdl);
    delete rtPCtrace;
    delete mdl;
    delete device;
}