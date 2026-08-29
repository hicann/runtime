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
#define protected public
#define private public

#include "adx_dump_soc_helper.h"
#include "mmpa_api.h"
#include "adx_datadump_server_soc.h"
#include "memory_utils.h"
#include "extra_config.h"
#include "adx_dump_record.h"
#include "securec.h"

static const IDE_SESSION TEST_SESSION = (IDE_SESSION)0xFFFF0000;
static const char* TEST_FILE_NAME = "/home/test.log";

static IdeDumpChunk BuildDefaultDumpChunk()
{
    IdeDumpChunk dumpChunk = {};
    static unsigned char defaultData = 'a';
    dumpChunk.fileName = const_cast<char*>(TEST_FILE_NAME);
    dumpChunk.dataBuf = &defaultData;
    dumpChunk.bufLen = 1;
    dumpChunk.isLastChunk = 0;
    dumpChunk.offset = 0;
    dumpChunk.flag = IDE_DUMP_NONE_FLAG;
    return dumpChunk;
}

class ADX_DUMP_SOC_HELPER_TEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() { GlobalMockObject::verify(); }
};

TEST_F(ADX_DUMP_SOC_HELPER_TEST, ParseConnectInfo)
{
    const std::string privInfo = "127.0.0.1:22118;0;123";
    std::map<std::string, std::string> proto;
    int ret = Adx::AdxDumpSocHelper::Instance().ParseConnectInfo(privInfo);
    EXPECT_EQ(0, ret);
    const std::string privInfo1 = "127.0.0.1";
    ret = Adx::AdxDumpSocHelper::Instance().ParseConnectInfo(privInfo1);
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, ret);
    const std::string privInfo2 = "127.0.0.1:22118;a;abc";
    ret = Adx::AdxDumpSocHelper::Instance().ParseConnectInfo(privInfo2);
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, ret);
    const std::string privInfo3 = "127.0.0.1:22118;0;abc";
    ret = Adx::AdxDumpSocHelper::Instance().ParseConnectInfo(privInfo3);
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, ret);
}

TEST_F(ADX_DUMP_SOC_HELPER_TEST, IdeDumpStart)
{
    const char* privInfo = "127.0.0.1:22118;0;123";
    MOCKER(mmGetPid).stubs().will(returnValue(123));
    const char* appBin = "/home/app";
    MOCKER(readlink).stubs().will(returnValue(0));
    IDE_SESSION session = IdeDumpStart(privInfo);
    EXPECT_EQ(session, (IDE_SESSION)0xFFFF0000);
}

TEST_F(ADX_DUMP_SOC_HELPER_TEST, IdeDumpData_Success)
{
    IdeDumpChunk dumpChunk = BuildDefaultDumpChunk();
    MOCKER(&Adx::AdxDumpRecord::RecordDumpDataToDisk).stubs().will(returnValue(true));
    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, IdeDumpData(TEST_SESSION, &dumpChunk));
}

TEST_F(ADX_DUMP_SOC_HELPER_TEST, IdeDumpData_WriteError)
{
    IdeDumpChunk dumpChunk = BuildDefaultDumpChunk();
    MOCKER(&Adx::AdxDumpRecord::RecordDumpDataToDisk).stubs().will(returnValue(false));
    EXPECT_EQ(IDE_DAEMON_WRITE_ERROR, IdeDumpData(TEST_SESSION, &dumpChunk));
}

TEST_F(ADX_DUMP_SOC_HELPER_TEST, IdeDumpData_InvalidParam)
{
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, IdeDumpData(nullptr, nullptr));
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, IdeDumpData(TEST_SESSION, nullptr));
}

TEST_F(ADX_DUMP_SOC_HELPER_TEST, IdeDumpData_InvalidFileName)
{
    IdeDumpChunk dumpChunk = BuildDefaultDumpChunk();
    dumpChunk.fileName = nullptr;
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, IdeDumpData(TEST_SESSION, &dumpChunk));
}

TEST_F(ADX_DUMP_SOC_HELPER_TEST, IdeDumpData_InvalidDataBuf)
{
    IdeDumpChunk dumpChunk = BuildDefaultDumpChunk();
    dumpChunk.dataBuf = nullptr;
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, IdeDumpData(TEST_SESSION, &dumpChunk));
}

TEST_F(ADX_DUMP_SOC_HELPER_TEST, IdeDumpData_InvalidBufLen)
{
    IdeDumpChunk dumpChunk = BuildDefaultDumpChunk();
    dumpChunk.bufLen = 0;
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, IdeDumpData(TEST_SESSION, &dumpChunk));
}

TEST_F(ADX_DUMP_SOC_HELPER_TEST, IdeDumpData_FileNameTooLong)
{
    IdeDumpChunk dumpChunk = BuildDefaultDumpChunk();
    char longFileName[4097];
    for (int i = 0; i < 4096; i++) {
        longFileName[i] = 'a';
    }
    longFileName[4096] = '\0';
    dumpChunk.fileName = longFileName;
    EXPECT_EQ(IDE_DAEMON_INVALID_PATH_ERROR, IdeDumpData(TEST_SESSION, &dumpChunk));
}

TEST_F(ADX_DUMP_SOC_HELPER_TEST, IdeDumpData_BufLenOverflow)
{
    IdeDumpChunk dumpChunk = BuildDefaultDumpChunk();
    dumpChunk.bufLen = UINT32_MAX;
    EXPECT_EQ(IDE_DAEMON_INTERGER_REVERSED_ERROR, IdeDumpData(TEST_SESSION, &dumpChunk));
}

TEST_F(ADX_DUMP_SOC_HELPER_TEST, IdeDumpData_MallocFailed)
{
    IdeDumpChunk dumpChunk = BuildDefaultDumpChunk();
    MOCKER(Adx::IdeXmalloc).stubs().will(returnValue((IdeMemHandle) nullptr));
    EXPECT_EQ(IDE_DAEMON_MALLOC_ERROR, IdeDumpData(TEST_SESSION, &dumpChunk));
}

TEST_F(ADX_DUMP_SOC_HELPER_TEST, IdeDumpEnd) { EXPECT_EQ(0, IdeDumpEnd(TEST_SESSION)); }
