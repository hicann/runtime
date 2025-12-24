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

#include "adx_dump_record.h"
#include "mmpa_api.h"
class ADX_DUMP_RECORD_TEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};
/*
TEST_F(ADX_DUMP_RECORD_TEST, Init)
{
    MOCKER(mmGetCwd).stubs()
        .will(returnValue(-1))
        .then(returnValue(EN_OK));
    int ret = Adx::AdxDumpRecord::Instance().Init();
    EXPECT_EQ(IDE_DAEMON_ERROR, ret);
    ret = Adx::AdxDumpRecord::Instance().Init();
    EXPECT_EQ(IDE_DAEMON_OK, ret);
}

TEST_F(ADX_DUMP_RECORD_TEST, UnInit)
{
    int ret = Adx::AdxDumpRecord::Instance().UnInit();
    EXPECT_EQ(IDE_DAEMON_OK, ret);
}


/*
TEST_F(ADX_DUMP_RECORD_TEST, GetSliceNum)
{
    std::string dumpPath;
    int ret = Adx::Dump::Record::AdxDumpRecord::Instance().GetSliceNum(dumpPath);

    MOCKER(IdeDaemon::Common::Utils::GetFileSize).stubs()
        .will(returnValue((long long)1024*1024*1024))
        .then(returnValue((long long)0))
        .then(returnValue((long long)1024));
    EXPECT_EQ(IDE_DAEMON_ERROR, ret);
    dumpPath = "/tmp/dump";
    ret = Adx::Dump::Record::AdxDumpRecord::Instance().GetSliceNum(dumpPath);
    EXPECT_EQ(IDE_DAEMON_ERROR, ret);
    ret = Adx::Dump::Record::AdxDumpRecord::Instance().GetSliceNum(dumpPath);
    EXPECT_EQ(IDE_DAEMON_OK, ret);
    ret = Adx::Dump::Record::AdxDumpRecord::Instance().GetSliceNum(dumpPath);
    EXPECT_EQ(IDE_DAEMON_ERROR, ret);
}

TEST_F(ADX_DUMP_RECORD_TEST, WriteInfoToFile)
{
    std::string dumpPath;
    int ret = Adx::Dump::Record::AdxDumpRecord::Instance().WriteInfoToFile(dumpPath, "", true);
    EXPECT_EQ(IDE_DAEMON_ERROR, ret);
    dumpPath = "adx_dump";
    std::string data = "adx_dump_test";
    ret = Adx::Dump::Record::AdxDumpRecord::Instance().WriteInfoToFile(dumpPath, data, false);
    EXPECT_EQ(IDE_DAEMON_OK, ret);
    ret = Adx::Dump::Record::AdxDumpRecord::Instance().WriteInfoToFile(dumpPath, data, true);
    EXPECT_EQ(IDE_DAEMON_OK, ret);
    remove(dumpPath.c_str());
}

TEST_F(ADX_DUMP_RECORD_TEST, RecordDumpInfo)
{
    std::string dumpPath;
    int ret = Adx::Dump::Record::AdxDumpRecord::Instance().RecordDumpInfo(dumpPath);
    EXPECT_EQ(IDE_DAEMON_ERROR, ret);
    MOCKER(IdeDaemon::Common::Utils::IsFileExist).stubs()
        .will(returnValue(false))
        .then(returnValue(false));
    MOCKER(IdeDaemon::Common::Utils::CreateDir).stubs()
        .will(returnValue(IDE_DAEMON_UNKNOW_ERROR))
        .then(returnValue(IDE_DAEMON_NONE_ERROR));
    MOCKER(IdeDaemon::Common::Utils::GetFileSize).stubs()
        .will(returnValue((long long)1024*1024*1024))
        .then(returnValue((long long)1024*1024*1024))
        .then(returnValue((long long)0));
    dumpPath = "adx_dump";
    MOCKER_CPP(&Adx::Dump::Record::AdxDumpRecord::WriteInfoToFile).stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));
    MOCKER(IdeDaemon::Common::Utils::AdxRename).stubs()
        .will(returnValue(-1))
        .then(returnValue(0));
    // CreateDir false
    ret = Adx::Dump::Record::AdxDumpRecord::Instance().RecordDumpInfo(dumpPath);
    EXPECT_EQ(IDE_DAEMON_ERROR, ret);
    ret = Adx::Dump::Record::AdxDumpRecord::Instance().RecordDumpInfo(dumpPath);
    EXPECT_EQ(IDE_DAEMON_ERROR, ret);
    ret = Adx::Dump::Record::AdxDumpRecord::Instance().RecordDumpInfo(dumpPath);
    EXPECT_EQ(IDE_DAEMON_ERROR, ret);
    ret = Adx::Dump::Record::AdxDumpRecord::Instance().RecordDumpInfo(dumpPath);
    EXPECT_EQ(IDE_DAEMON_OK, ret);
    ret = Adx::Dump::Record::AdxDumpRecord::Instance().RecordDumpInfo(dumpPath);
    EXPECT_EQ(IDE_DAEMON_OK, ret);
}

TEST_F(ADX_DUMP_RECORD_TEST, AddTagToRecordList)
{
    std::string dumpPath;
    bool add = Adx::Dump::Record::AdxDumpRecord::Instance().AddTagToRecordList(dumpPath);
    EXPECT_EQ(false, add);
    bool del = Adx::Dump::Record::AdxDumpRecord::Instance().DelTagFromRecordList(dumpPath);
    EXPECT_EQ(false, del);
    EXPECT_EQ(Adx::Dump::Record::RECORD_INVALID,
        Adx::Dump::Record::AdxDumpRecord::Instance().GetRecordType(dumpPath));
    dumpPath = "adx_dump";
    add = Adx::Dump::Record::AdxDumpRecord::Instance().AddTagToRecordList(dumpPath);
    EXPECT_EQ(true, add);
    EXPECT_EQ(Adx::Dump::Record::RECORD_QUEUE,
        Adx::Dump::Record::AdxDumpRecord::Instance().GetRecordType(dumpPath));
    EXPECT_EQ(Adx::Dump::Record::RECORD_FILE,
        Adx::Dump::Record::AdxDumpRecord::Instance().GetRecordType(std::string("dump")));
    del = Adx::Dump::Record::AdxDumpRecord::Instance().DelTagFromRecordList(dumpPath);
    EXPECT_EQ(true, del);
}
*/
