/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <sys/ipc.h>
#include <sys/shm.h>

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
extern "C" {
    #include "log_common.h"
    #include "share_mem.h"

    int32_t ToolShmGet(key_t key, size_t size, int32_t shmflg);
    void *ToolShmAt(int32_t shmid, const void *shmaddr, int32_t shmflg);
    int32_t ToolShmDt(const void *shmaddr);
    int32_t ToolShmCtl(int32_t shmid, int32_t cmd, struct shmid_ds *buf);
}
class SlogdShareMem : public testing::Test
{
public:
    void SetUp();
    void TearDown();
};

void SlogdShareMem::SetUp()
{
}

void SlogdShareMem::TearDown()
{}

TEST_F(SlogdShareMem, CreateShareMemIdIsNULL)
{
    EXPECT_EQ(SHM_ERROR, ShMemCreat(NULL, NULL));
    //GlobalMockObject::reset();
}

TEST_F(SlogdShareMem, CreateShareMemgetRetLeZero)
{
    int id = 0;
    MOCKER(ToolShmGet).stubs().will(returnValue(-1));
    EXPECT_EQ(SHM_ERROR, ShMemCreat(&id, NULL));
    GlobalMockObject::reset();
}

TEST_F(SlogdShareMem, OpenMemIdIsNULL)
{
    EXPECT_EQ(SHM_ERROR, ShMemOpen(NULL));
    //GlobalMockObject::reset();
}


TEST_F(SlogdShareMem, OpenMemRetLeZero)
{
    int id = 0;
    MOCKER(ToolShmGet).stubs().will(returnValue(-1));
    EXPECT_EQ(SHM_ERROR, ShMemOpen(&id));
    GlobalMockObject::reset();
}

TEST_F(SlogdShareMem, WriteToShMemIdIsERROR)
{
    int id = -1;
    char value[40] = "/vat/npu/log/sample/slogd.conf";
    int len = 10;
    EXPECT_EQ(SHM_ERROR, ShMemWrite(id, value, len, 0));
    // GlobalMockObject::reset();
}

TEST_F(SlogdShareMem, WriteToShMemIdIsERROR1)
{
    int id = 1234;
    char value[40] = "/vat/npu/log/sample/slogd.conf";
    int len = 10;
    MOCKER(ToolShmAt).stubs().will(returnValue((void*)-1));
    EXPECT_EQ(SHM_ERROR, ShMemWrite(id, value, len, 0));
    GlobalMockObject::reset();
}

TEST_F(SlogdShareMem, WriteToShMemIdIsERROR2)
{
    int id = 1234;
    char value[40] = "/vat/npu/log/sample/slogd.conf";
    int len = 10;
    MOCKER(ToolShmAt).stubs().will(returnValue((void*)0));
    EXPECT_EQ(SHM_ERROR, ShMemWrite(id, value, len, 0));
    GlobalMockObject::reset();
}

TEST_F(SlogdShareMem, WriteToShMemIdIsERROR3)
{
    int id = 1234;
    char value[40] = "/vat/npu/log/sample/slogd.conf";
    int len = 10;
    char address[4096] = "testaddress";
    MOCKER(ToolShmAt).stubs().will(returnValue((void*)&address));
    MOCKER(ToolShmDt).stubs().will(returnValue(-1));
    EXPECT_EQ(SHM_ERROR, ShMemWrite(id, value, len, 0));
    GlobalMockObject::reset();
}
TEST_F(SlogdShareMem, WriteToShMemIdIsERROR4)
{
    int id = 1234;
    char value[40] = "/vat/npu/log/sample/slogd.conf";
    int len = 0;
    char address[4096] = "testaddress";
    MOCKER(ToolShmAt).stubs().will(returnValue((void*)&address));
    MOCKER(ToolShmDt).stubs().will(returnValue(-1));
    EXPECT_EQ(SHM_ERROR, ShMemWrite(id, value, len, 0));
    GlobalMockObject::reset();
}

TEST_F(SlogdShareMem, WriteToShMemSuccess)
{
    int id = 1234;
    char value[40] = "/vat/npu/log/sample/slogd.conf";
    int len = 10;
    char address[4096] = "testaddress";
    MOCKER(ToolShmAt).stubs().will(returnValue((void*)&address));
    MOCKER(ToolShmDt).stubs().will(returnValue(0));
    EXPECT_EQ(SHM_SUCCEED, ShMemWrite(id, value, len, 0));
    GlobalMockObject::reset();
}

TEST_F(SlogdShareMem, ReadFromShMemERROR)
{
    int id = -1;
    char value[40] = "/vat/npu/log/sample/slogd.conf";
    int len = 10;
    EXPECT_EQ(SHM_ERROR, ShMemWrite(id, value, len, 0));
    GlobalMockObject::reset();
}

TEST_F(SlogdShareMem, ReadFromShMemERROR1)
{
    int id = 1234;
    char value[40] = "/vat/npu/log/sample/slogd.conf";
    int len = 10;
    MOCKER(ToolShmAt).stubs().will(returnValue((void*)-1));
    EXPECT_EQ(SHM_ERROR, ShMemRead(id, value, len, 0));
    GlobalMockObject::reset();
}

TEST_F(SlogdShareMem, ReadFromShMemERROR2)
{
    int id = 1234;
    char value[40] = "/vat/npu/log/sample/slogd.conf";
    int len = 2;
    MOCKER(ToolShmAt).stubs().will(returnValue((void*)0));
    EXPECT_EQ(SHM_ERROR, ShMemRead(id, value, len, 0));
    GlobalMockObject::reset();
}

TEST_F(SlogdShareMem, ReadFromShMemERROR3)
{
    int id = 1234;
    char value[2] = "\0";
    int len = 10;
    MOCKER(ToolShmAt).stubs().will(returnValue((void*)0));
    MOCKER(ToolShmDt).stubs().will(returnValue(-1));
    EXPECT_EQ(SHM_ERROR, ShMemRead(id, value, len, 0));
    GlobalMockObject::reset();
}

TEST_F(SlogdShareMem, ReadFromShMemERROR4)
{
    int id = 1234;
    char value[40] = "/vat/npu/log/sample/slogd.conf";
    int len = 10;
    MOCKER(ToolShmAt).stubs().will(returnValue((void*)0));
    MOCKER(ToolShmDt).stubs().will(returnValue(0));
    EXPECT_EQ(SHM_ERROR, ShMemRead(id, value, len, 0));
    GlobalMockObject::reset();
}
TEST_F(SlogdShareMem, ReadFromShMemERROR5)
{
    int id = 1234;
    char result[40] = "/vat/npu/log/sample/slogd.conf";
    int len = 10;
    char address[4096] = "testaddress"; // len address > len
    MOCKER(ToolShmAt).stubs().will(returnValue((void*)&address));
    MOCKER(ToolShmDt).stubs().will(returnValue(0));
    EXPECT_EQ(SHM_ERROR, ShMemRead(id, result, len, 0));
    GlobalMockObject::reset();
}
TEST_F(SlogdShareMem, ReadFromShMemERROR6)
{
    int id = 1234;
    char* result = NULL;
    int len = 10;
    EXPECT_EQ(SHM_ERROR, ShMemRead(id, result, len, 0));
    GlobalMockObject::reset();
}

TEST_F(SlogdShareMem, ReadFromShMemERROR7)
{
    int id = 1234;
    char result[40] = "/vat/npu/log/sample/slogd.conf";
    int len = 16;
    char address[4096] = "testaddress"; // len=11
    MOCKER(ToolShmAt).stubs().will(returnValue((void*)&address));
    MOCKER(ToolShmDt).stubs().will(returnValue(-1));
    EXPECT_EQ(SHM_ERROR, ShMemRead(id, result, len, 0));
    GlobalMockObject::reset();
}

TEST_F(SlogdShareMem, ReadFromShMemSuccess)
{
    int id = 1234;
    char result[40] = "/vat/npu/log/sample/slogd.conf";
    int len = 16;
    char address[4096] = "testaddress"; // len=11
    MOCKER(ToolShmAt).stubs().will(returnValue((void*)&address));
    MOCKER(ToolShmDt).stubs().will(returnValue(0));
    EXPECT_EQ(SHM_SUCCEED, ShMemRead(id, result, len, 0));
    EXPECT_EQ(*address, *result);
    GlobalMockObject::reset();
}
