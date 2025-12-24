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