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
#include "mockcpp/mockcpp.hpp"
#include "dump_memory.h"
#include "runtime/mem.h"

using namespace Adx;

class DumpMemoryUtest: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }

private:
};

TEST_F(DumpMemoryUtest, Test_CopyDeviceToHost)
{
    char stubData[] = {'a', 'b', 'c', 'd', 'e', 'f', 'g', '\0'};

    // success
    void *hostMem = DumpMemory::CopyDeviceToHost(stubData, sizeof(stubData));
    EXPECT_TRUE(hostMem != nullptr);
    EXPECT_EQ(std::string(reinterpret_cast<char *>(hostMem)), std::string(stubData));
    DumpMemory::FreeHost(hostMem);

    // input nullptr or 0
    void *hostMemNull = DumpMemory::CopyDeviceToHost(nullptr, 0);
    EXPECT_TRUE(hostMemNull == nullptr);

    // rtMallocHost failed.
    rtError_t retError = -1;
    MOCKER(rtMallocHost).stubs().will(returnValue(retError)).then(returnValue(RT_ERROR_NONE));
    hostMemNull = DumpMemory::CopyDeviceToHost(stubData, sizeof(stubData));
    EXPECT_TRUE(hostMemNull == nullptr);

    // rtMemcpy failed.
    MOCKER(rtMemcpy).stubs().will(returnValue(retError));
    hostMemNull = DumpMemory::CopyDeviceToHost(stubData, sizeof(stubData));
    EXPECT_TRUE(hostMemNull == nullptr);
}

TEST_F(DumpMemoryUtest, Test_CopyHostToDevice)
{
    char stubData[] = {'a', 'b', 'c', 'd', 'e', 'f', 'g', '\0'};

    // success
    void *devMem = DumpMemory::CopyHostToDevice(stubData, sizeof(stubData));
    EXPECT_TRUE(devMem != nullptr);
    EXPECT_EQ(std::string(reinterpret_cast<char *>(devMem)), std::string(stubData));
    DumpMemory::FreeDevice(devMem);


    // input nullptr or 0
    void *devMemNull = DumpMemory::CopyHostToDevice(nullptr, 0);
    EXPECT_TRUE(devMemNull == nullptr);

    // rtMalloc failed.
    rtError_t retError = -1;
    MOCKER(rtMalloc).stubs().will(returnValue(retError)).then(returnValue(RT_ERROR_NONE));
    devMemNull = DumpMemory::CopyHostToDevice(stubData, sizeof(stubData));
    EXPECT_TRUE(devMemNull == nullptr);

    // rtMemcpy failed.
    MOCKER(rtMemcpy).stubs().will(returnValue(retError));
    devMemNull = DumpMemory::CopyHostToDevice(stubData, sizeof(stubData));
    EXPECT_TRUE(devMemNull == nullptr);
}

// 回归测试: CopyHostToDevice 的 rtMemcpy 失败路径必须用 rtFree(释放 device 内存)
// 而非 rtFreeHost(释放 host 内存)。devMem 来自 rtMalloc(RT_MEMORY_HBM),
// 用 rtFreeHost 释放会失败并泄漏 device 内存。
TEST_F(DumpMemoryUtest, Test_CopyHostToDevice_MemcpyFail_ReleaseWithRtFree)
{
    char stubData[] = {'a', 'b', 'c', 'd', 'e', 'f', 'g', '\0'};
    rtError_t retError = -1;

    // 确保 rtMalloc 成功, 不依赖真实 HBM 环境, 以进入 memcpy 失败路径
    MOCKER(rtMalloc).stubs().will(returnValue(RT_ERROR_NONE));
    // malloc 成功, memcpy 失败 -> 进入错误释放路径
    MOCKER(rtMemcpy).stubs().will(returnValue(retError));
    // 期望: 错误路径调用 rtFree(device) 一次, 不调用 rtFreeHost(host)
    MOCKER(rtFree).expects(once()).will(returnValue(RT_ERROR_NONE));
    MOCKER(rtFreeHost).expects(never());

    void *devMemNull = DumpMemory::CopyHostToDevice(stubData, sizeof(stubData));
    EXPECT_TRUE(devMemNull == nullptr);
    // TearDown() 中的 GlobalMockObject::verify() 校验上述 expects 是否满足
}

TEST_F(DumpMemoryUtest, Test_HostMemoryGuardMacro)
{
    char stubData[] = {'a', 'b', 'c', 'd', 'e', 'f', 'g', '\0'};
    void *hostMem = nullptr;
    {
        hostMem = DumpMemory::CopyDeviceToHost(stubData, sizeof(stubData));
        EXPECT_TRUE(hostMem != nullptr);
        EXPECT_EQ(std::string(reinterpret_cast<char *>(hostMem)), std::string(stubData));
        HOST_RT_MEMORY_GUARD(hostMem);
    }
    EXPECT_TRUE(hostMem == nullptr);
}

TEST_F(DumpMemoryUtest, Test_DeviceMemoryGuardMacro)
{
    char stubData[] = {'a', 'b', 'c', 'd', 'e', 'f', 'g', '\0'};
    void *devMem = nullptr;
    {
        devMem = DumpMemory::CopyHostToDevice(stubData, sizeof(stubData));
        EXPECT_TRUE(devMem != nullptr);
        EXPECT_EQ(std::string(reinterpret_cast<char *>(devMem)), std::string(stubData));
        DEVICE_RT_MEMORY_GUARD(devMem);
    }
    EXPECT_TRUE(devMem == nullptr);
}