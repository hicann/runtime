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
#include <sstream>
#include "mockcpp/mockcpp.hpp"
#define protected public
#define private public

#include "adx_dump_process.h"
#include "adx_dump_record.h"
#include "mmpa_api.h"
#include "file_utils.h"
#include "adx_msg_proto.h"
#include "adx_msg.h"
#include "memory_utils.h"
#include "common_utils.h"

using namespace Adx;
class ADX_DUMP_RECORD_TEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

int messageCallback(const Adx::DumpChunk * data, int len)
{
    if((sizeof(struct Adx::DumpChunk) + data->bufLen) == len) {
        printf("record to mindspore success\n");
        return 0;
    } else {
        return -1;
    }
}

TEST_F(ADX_DUMP_RECORD_TEST, Init)
{
    MOCKER_CPP(&std::string::empty).stubs()
        .will(returnValue(true))
        .then(returnValue(false));
     MOCKER(mmGetCwd)
        .stubs()
        .will(returnValue(-1));
    int ret = Adx::AdxDumpRecord::Instance().Init("");
    EXPECT_EQ(IDE_DAEMON_ERROR, ret);

    MOCKER(readlink).stubs()
        .will(returnValue(0))
        .then(returnValue(-1));
    ret = Adx::AdxDumpRecord::Instance().Init("");
    EXPECT_EQ(IDE_DAEMON_OK, ret);

    MOCKER(readlink).stubs()
        .will(returnValue(-1));
    ret = Adx::AdxDumpRecord::Instance().Init("");
    EXPECT_EQ(IDE_DAEMON_ERROR, ret);
}

TEST_F(ADX_DUMP_RECORD_TEST, InitPermissionDenied)
{
    std::string testPid = "../tmp/adumpllt/12345";
    const char mkCmd[] = { "mkdir -p /tmp/adumpllt/12345/" };
    const char thCmd[] = { "touch /tmp/adumpllt/12345/exe" };
    const char chCmd[] = { "chmod 220 /tmp/adumpllt/12345/exe" };
    const char rmCmd[] = { "rm -rf /tmp/adumpllt/12345/" };
    system(mkCmd);
    system(thCmd);
    system(chCmd);
    int ret = Adx::AdxDumpRecord::Instance().Init(testPid);
    EXPECT_EQ(IDE_DAEMON_ERROR, ret);
    system(rmCmd);
}

TEST_F(ADX_DUMP_RECORD_TEST, UnInit)
{
    int ret = Adx::AdxDumpRecord::Instance().UnInit();
    EXPECT_EQ(IDE_DAEMON_OK, ret);
}

TEST_F(ADX_DUMP_RECORD_TEST, UpdateDumpInitNum)
{
    Adx::AdxDumpRecord::Instance().UpdateDumpInitNum(true);
    int ret = Adx::AdxDumpRecord::Instance().GetDumpInitNum();
    EXPECT_EQ(1, ret);
    Adx::AdxDumpRecord::Instance().UpdateDumpInitNum(false);
    ret = Adx::AdxDumpRecord::Instance().GetDumpInitNum();
    EXPECT_EQ(0, ret);
}

TEST_F(ADX_DUMP_RECORD_TEST, RecordDumpDataToDisk)
{
    const char *srcFile = "adx_data_dump_server_manager";
    uint32_t dataLen = strlen(srcFile) + 1 + sizeof(Adx::DumpChunk);
    MsgProto *msg = Adx::AdxMsgProto::CreateMsgPacket(IDE_DUMP_REQ, 0, nullptr, dataLen);
    std::unique_ptr<MsgProto, decltype(&IdeXfree)> sendDataMsgPtr(msg, IdeXfree);
    Adx::DumpChunk* data = (Adx::DumpChunk *)msg->data;
    data->bufLen = strlen(srcFile) + 1;
    data->flag = 0;
    data->isLastChunk = 1;
    data->offset = -1;
    strcpy(data->fileName, srcFile);
    memcpy(data->dataBuf, srcFile, strlen(srcFile) + 1);
    msg->sliceLen = strlen(srcFile) + 1;
    msg->totalLen = strlen(srcFile) + 1;

    const Adx::DumpChunk dumpChunk = *data;

    MOCKER(Adx::FileUtils::IsFileExist)
    .stubs()
    .will(returnValue(false))
    .then(returnValue(true));
    MOCKER(Adx::FileUtils::CreateDir)
    .stubs()
    .will(returnValue(IDE_DAEMON_INVALID_PATH_ERROR))
    .then(returnValue(IDE_DAEMON_NONE_ERROR));
    MOCKER(Adx::FileUtils::IsDiskFull)
    .stubs()
    .will(returnValue(true))
    .then(returnValue(false));
    MOCKER(Adx::FileUtils::FileNameIsReal)
    .stubs()
    .will(returnValue(IDE_DAEMON_ERROR))
    .then(returnValue(IDE_DAEMON_OK));
    MOCKER(Adx::FileUtils::WriteFile)
    .stubs()
    .will(returnValue(IDE_DAEMON_WRITE_ERROR))
    .then(returnValue(IDE_DAEMON_NONE_ERROR));
    bool ret = Adx::AdxDumpRecord::Instance().RecordDumpDataToDisk(dumpChunk);
    EXPECT_EQ(false, ret);
    ret = Adx::AdxDumpRecord::Instance().RecordDumpDataToDisk(dumpChunk);
    EXPECT_EQ(false, ret);
    ret = Adx::AdxDumpRecord::Instance().RecordDumpDataToDisk(dumpChunk);
    EXPECT_EQ(false, ret);
    ret = Adx::AdxDumpRecord::Instance().RecordDumpDataToDisk(dumpChunk);
    EXPECT_EQ(false, ret);
    ret = Adx::AdxDumpRecord::Instance().RecordDumpDataToDisk(dumpChunk);
    EXPECT_EQ(true, ret);
    ret = Adx::AdxDumpRecord::Instance().RecordDumpDataToDisk(dumpChunk);
    EXPECT_EQ(true, ret);
}

TEST_F(ADX_DUMP_RECORD_TEST, RecordDumpDataToQueue)
{
    const char *srcFile = "adx_data_dump_server_manager";
    uint32_t dataLen = strlen(srcFile) + 1 + sizeof(Adx::DumpChunk);
    MsgProto *msg = Adx::AdxMsgProto::CreateMsgPacket(IDE_DUMP_REQ, 0, nullptr, dataLen);
    Adx::SharedPtr<MsgProto> msgPtr(msg, IdeXfree);
    Adx::HostDumpDataInfo info = {msgPtr, dataLen};
    bool ret = Adx::AdxDumpRecord::Instance().RecordDumpDataToQueue(info);
    EXPECT_EQ(true, ret);
    Adx::AdxDumpRecord::Instance().RecordDumpInfo();
}

TEST_F(ADX_DUMP_RECORD_TEST, RecordDumpDataToFullQueue)
{
    const char *srcFile = "adx_data_dump_server_manager";
    uint32_t dataLen = strlen(srcFile) + 1 + sizeof(Adx::DumpChunk);
    MsgProto *msg = Adx::AdxMsgProto::CreateMsgPacket(IDE_DUMP_REQ, 0, nullptr, dataLen);
    Adx::SharedPtr<MsgProto> msgPtr(msg, IdeXfree);
    Adx::HostDumpDataInfo info = {msgPtr, dataLen};
    MOCKER_CPP(&Adx::BoundQueueMemory<HostDumpDataInfo>::IsFull)
    .stubs()
    .will(returnValue(true));
    bool ret = Adx::AdxDumpRecord::Instance().RecordDumpDataToQueue(info);
    EXPECT_EQ(false, ret);
    Adx::AdxDumpRecord::Instance().RecordDumpInfo();
}

TEST_F(ADX_DUMP_RECORD_TEST, RecordDumpDataToFullQueueLimit)
{
    const char *srcFile = "adx_data_dump_server_manager";
    uint32_t dataLen = strlen(srcFile) + 1 + sizeof(Adx::DumpChunk);
    MsgProto *msg = Adx::AdxMsgProto::CreateMsgPacket(IDE_DUMP_REQ, 0, nullptr, dataLen);
    Adx::SharedPtr<MsgProto> msgPtr(msg, IdeXfree);
    Adx::HostDumpDataInfo info = {msgPtr, dataLen};
    MOCKER_CPP(&Adx::BoundQueueMemory<HostDumpDataInfo>::ReadMemory)
    .stubs()
    .will(returnValue(static_cast<uint64_t>(10ULL * 1024 * 1024 * 1024)));
    BoundQueueMemory<HostDumpDataInfo> mem;
    GlobalMockObject::reset();
    for (int i = 0; i < 61; i++) {
        mem.Push(info);
    }
    GlobalMockObject::reset();
    MOCKER_CPP(&Adx::BoundQueueMemory<HostDumpDataInfo>::ReadMemory)
    .stubs()
    .will(returnValue(static_cast<uint64_t>(10ULL * 1024 * 1024 * 1024)));
    bool ret = mem.IsFull();
    EXPECT_EQ(true, ret);

    GlobalMockObject::reset();
    MOCKER_CPP(&Adx::BoundQueueMemory<HostDumpDataInfo>::ReadMemory)
    .stubs()
    .will(returnValue(static_cast<uint64_t>(0)));
    ret = mem.IsFull();
    EXPECT_EQ(true, ret);

    GlobalMockObject::reset();
    MOCKER_CPP(&Adx::BoundQueueMemory<HostDumpDataInfo>::ReadMemory)
    .stubs()
    .will(returnValue(static_cast<uint64_t>(1ULL * 1024 * 1024 * 1024)));
    ret = mem.IsFull();
    EXPECT_EQ(false, ret);
}

TEST_F(ADX_DUMP_RECORD_TEST, RecordDumpInfoToMindspore)
{
    const char *srcFile = "adx_data_dump_server_manager";
    uint32_t dataLen = strlen(srcFile) + 1 + sizeof(Adx::DumpChunk);
    Adx::AdxDumpProcess::Instance().MessageCallbackRegister(messageCallback);
    MsgProto *msg = Adx::AdxMsgProto::CreateMsgPacket(IDE_DUMP_REQ, 0, nullptr, dataLen);
    Adx::SharedPtr<MsgProto> msgPtr(msg, IdeXfree);
    Adx::HostDumpDataInfo info = {msgPtr, dataLen};
    bool ret = Adx::AdxDumpRecord::Instance().RecordDumpDataToQueue(info);
    EXPECT_EQ(true, ret);
    Adx::AdxDumpRecord::Instance().RecordDumpInfo();
}

TEST_F(ADX_DUMP_RECORD_TEST, RecordOptimizedMode)
{
    const char *srcFile = "adx_data_dump_server_manager.bin";
    uint32_t dataLen = strlen(srcFile) + 1 + sizeof(Adx::DumpChunk);
    Adx::AdxDumpProcess::Instance().MessageCallbackRegister(messageCallback);
    MsgProto *msg = Adx::AdxMsgProto::CreateMsgPacket(IDE_DUMP_REQ, 0, nullptr, dataLen);
    Adx::SharedPtr<MsgProto> msgPtr(msg, IdeXfree);
    Adx::HostDumpDataInfo info = {msgPtr, dataLen};
    bool ret = Adx::AdxDumpRecord::Instance().RecordDumpDataToQueue(info);
    EXPECT_EQ(true, ret);
    uint64_t statsItem = DUMP_STATS_MAX | DUMP_STATS_MIN | DUMP_STATS_AVG | DUMP_STATS_NAN | DUMP_STATS_NEG_INF | DUMP_STATS_POS_INF;
    AdxDumpRecord::Instance().SetOptimizationMode(statsItem);
    MOCKER_CPP(&Adx::AdxDumpRecord::StatsDataParsing).stubs().will(returnValue(true));
    MOCKER_CPP(&Adx::AdxDumpRecord::FileNameCheck).stubs().will(returnValue(true));

    Adx::AdxDumpRecord::Instance().RecordDumpInfo();
}

TEST_F(ADX_DUMP_RECORD_TEST, StatsDataParsing)
{
    const char *wrongName = "aclnnBatchMatMul_0_L2.aclnnBatchMatMul.65535.65535.1725960383079645.csv";
    const char *srcFile = "aclnnBatchMatMul_0_L2.aclnnBatchMatMul.65535.65535.1725960383079645.bin";
    Adx::DumpChunk dumpChunk;
    dumpChunk.bufLen = sizeof(OpStatsResult);
    dumpChunk.flag = 0;
    dumpChunk.isLastChunk = 1;
    dumpChunk.offset = -1;
    strcpy(dumpChunk.fileName, wrongName);

    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(EOK));
    MOCKER(Adx::FileUtils::IsFileExist)
        .stubs()
        .will(returnValue(false)).then(returnValue(true));
    MOCKER(Adx::FileUtils::CreateDir)
        .stubs()
        .will(returnValue(IDE_DAEMON_INVALID_PATH_ERROR))
        .then(returnValue(IDE_DAEMON_NONE_ERROR));
    MOCKER(Adx::FileUtils::IsDiskFull)
        .stubs().will(returnValue(true))
        .then(returnValue(false));
    MOCKER(Adx::FileUtils::FileNameIsReal)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));
    MOCKER(Adx::FileUtils::WriteFile)
        .stubs()
        .will(returnValue(IDE_DAEMON_WRITE_ERROR))
        .then(returnValue(IDE_DAEMON_NONE_ERROR));
    MOCKER_CPP(&Adx::AdxDumpRecord::JudgeRemoteFalg)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    MOCKER_CPP(&Adx::AdxDumpRecord::GenerateFileData)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&Adx::AdxDumpRecord::DumpDataToCallback)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&Adx::AdxDumpProcess::IsRegistered)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));

    // file name is not right
    bool ret = Adx::AdxDumpRecord::Instance().StatsDataParsing(dumpChunk);
    EXPECT_EQ(true, ret);

    // start
    strcpy(dumpChunk.fileName, srcFile);
    ret = Adx::AdxDumpRecord::Instance().StatsDataParsing(dumpChunk);
    EXPECT_EQ(false, ret);
    // create dir failed
    ret = Adx::AdxDumpRecord::Instance().StatsDataParsing(dumpChunk);
    EXPECT_EQ(false, ret);
    // Don't have enough free disk
    ret = Adx::AdxDumpRecord::Instance().StatsDataParsing(dumpChunk);
    EXPECT_EQ(false, ret);
    // real path
    ret = Adx::AdxDumpRecord::Instance().StatsDataParsing(dumpChunk);
    EXPECT_EQ(false, ret);

    uint64_t statsItem = DUMP_STATS_MAX | DUMP_STATS_MIN | DUMP_STATS_AVG | DUMP_STATS_NAN | DUMP_STATS_NEG_INF | DUMP_STATS_POS_INF;
    AdxDumpRecord::Instance().SetOptimizationMode(statsItem);
    // WriteFile failed
    ret = Adx::AdxDumpRecord::Instance().StatsDataParsing(dumpChunk);
    EXPECT_EQ(true, ret);
    // WriteFile success
    ret = Adx::AdxDumpRecord::Instance().StatsDataParsing(dumpChunk);
    EXPECT_EQ(true, ret);
}

TEST_F(ADX_DUMP_RECORD_TEST, DumpDataToCallback)
{
    const std::string fileName = "aclnnBatchMatMul_0_L2.aclnnBatchMatMul.65535.65535.1725960383079645.csv";
    const std::string dumpData = "Input,0,268435456,DT_INT64,ND,100X20X0,100,200,10.100000,400,500,600";
    EXPECT_TRUE(AdxDumpRecord::Instance().DumpDataToCallback(fileName, dumpData, 1, 1));
}

TEST_F(ADX_DUMP_RECORD_TEST, GenerateFileData)
{
    const std::string srcFile = "aclnnBatchMatMul_0_L2.aclnnBatchMatMul.65535.65535.1725960383079645.csv";
    uint64_t statsItem = DUMP_STATS_MAX | DUMP_STATS_MIN | DUMP_STATS_AVG | DUMP_STATS_NAN | DUMP_STATS_NEG_INF | DUMP_STATS_POS_INF;
    std::shared_ptr<OpStatsResult> opRes = std::make_shared<OpStatsResult>();
    opRes->tensorNum = 1;
    opRes->stat[0].size = 268435456;
    opRes->stat[0].dType = toolkit::dump::DT_INT64;
    opRes->stat[0].format = toolkit::dump::FORMAT_ND;
    opRes->stat[0].index = 0;
    opRes->stat[0].io = 0;
    opRes->stat[0].result = 0;
    opRes->stat[0].shapeSize = 3;
    opRes->stat[0].statsLen = 6;
    opRes->stat[0].shape[0] = 100;
    opRes->stat[0].shape[1] = 20;
    opRes->stat[0].shape[2] = 40;
    opRes->stat[0].stats[0] = 100;
    opRes->stat[0].stats[1] = 200;
    DataTypeUnion dtUnion;
    dtUnion.floatValue = 10.10;
    opRes->stat[0].stats[2] = dtUnion.longIntValue;
    opRes->stat[0].stats[3] = 400;
    opRes->stat[0].stats[4] = 500;
    opRes->stat[0].stats[5] = 600;
    opRes->statItem = statsItem;

    std::stringstream strStream;

    // parse success with data
    Adx::AdxDumpRecord::Instance().GenerateFileData(strStream, srcFile, opRes);
    EXPECT_EQ("Input,0,268435456,DT_INT64,ND,100x20x40,100,200,10.1,80000,400,500,600\n", strStream.str());

    // parse success with full title
    MOCKER_CPP(&Adx::AdxDumpRecord::CheckFileNameExist)
        .stubs()
        .will(returnValue(false));
    strStream.str("");
    Adx::AdxDumpRecord::Instance().GenerateFileData(strStream, srcFile, opRes);

    EXPECT_EQ("Input/Output,Index,Data Size,Data Type,Format,Shape,Max Value,Min Value,Avg Value,Count,Nan Count,Negative Inf Count,Positive Inf Count\n"
        "Input,0,268435456,DT_INT64,ND,100x20x40,100,200,10.1,80000,400,500,600\n", strStream.str());

    strStream.str("");
    opRes->stat[0].dType = toolkit::dump::DT_BF16;
    Adx::AdxDumpRecord::Instance().GenerateFileData(strStream, srcFile, opRes);
    EXPECT_EQ("Input/Output,Index,Data Size,Data Type,Format,Shape,Max Value,Min Value,Avg Value,Count,Nan Count,Negative Inf Count,Positive Inf Count\n"
        "Input,0,268435456,DT_BF16,ND,100x20x40,1.4013e-43,2.8026e-43,10.1,80000,400,500,600\n", strStream.str());
    strStream.str("");
    opRes->stat[0].dType = toolkit::dump::DT_HIFLOAT8;
    Adx::AdxDumpRecord::Instance().GenerateFileData(strStream, srcFile, opRes);
    EXPECT_EQ("Input/Output,Index,Data Size,Data Type,Format,Shape,Max Value,Min Value,Avg Value,Count,Nan Count,Negative Inf Count,Positive Inf Count\n"
        "Input,0,268435456,DT_HIFLOAT8,ND,100x20x40,1.4013e-43,2.8026e-43,10.1,80000,400,500,600\n", strStream.str());
    strStream.str("");
    opRes->stat[0].dType = toolkit::dump::DT_FLOAT8_E5M2;
    Adx::AdxDumpRecord::Instance().GenerateFileData(strStream, srcFile, opRes);
    EXPECT_EQ("Input/Output,Index,Data Size,Data Type,Format,Shape,Max Value,Min Value,Avg Value,Count,Nan Count,Negative Inf Count,Positive Inf Count\n"
        "Input,0,268435456,DT_FLOAT8_E5M2,ND,100x20x40,1.4013e-43,2.8026e-43,10.1,80000,400,500,600\n", strStream.str());
    strStream.str("");
    opRes->stat[0].dType = toolkit::dump::DT_FLOAT8_E4M3FN;
    Adx::AdxDumpRecord::Instance().GenerateFileData(strStream, srcFile, opRes);
    EXPECT_EQ("Input/Output,Index,Data Size,Data Type,Format,Shape,Max Value,Min Value,Avg Value,Count,Nan Count,Negative Inf Count,Positive Inf Count\n"
        "Input,0,268435456,DT_FLOAT8_E4M3FN,ND,100x20x40,1.4013e-43,2.8026e-43,10.1,80000,400,500,600\n", strStream.str());

    // format not supported, dType is float
    DataTypeUnion dtUnion2;
    dtUnion.floatValue = 12.34;
    dtUnion2.floatValue = 56.789666689;
    opRes->stat[0].stats[0] = dtUnion.longIntValue;
    opRes->stat[0].stats[1] = dtUnion2.longIntValue;
    opRes->stat[0].dType = toolkit::dump::DT_FLOAT;
    opRes->stat[0].format = toolkit::dump::FORMAT_MAX;
    strStream.str("");
    Adx::AdxDumpRecord::Instance().GenerateFileData(strStream, srcFile, opRes);
    EXPECT_EQ("Input/Output,Index,Data Size,Data Type,Format,Shape,Max Value,Min Value,Avg Value,Count,Nan Count,Negative Inf Count,Positive Inf Count\n"
        "Input,0,268435456,DT_FLOAT,UNKNOW,100x20x40,12.34,56.7897,10.1,80000,400,500,600\n", strStream.str());

    // format not supported, dType is float
    dtUnion.intValue[0] = 1234;
    dtUnion2.intValue[0] = 5678;
    opRes->stat[0].stats[0] = dtUnion.longIntValue;
    opRes->stat[0].stats[1] = dtUnion2.longIntValue;
    opRes->stat[0].dType = toolkit::dump::DT_INT32;
    opRes->stat[0].format = toolkit::dump::FORMAT_ALL;
    strStream.str("");
    Adx::AdxDumpRecord::Instance().GenerateFileData(strStream, srcFile, opRes);
    EXPECT_EQ("Input/Output,Index,Data Size,Data Type,Format,Shape,Max Value,Min Value,Avg Value,Count,Nan Count,Negative Inf Count,Positive Inf Count\n"
        "Input,0,268435456,DT_INT32,ALL,100x20x40,1234,5678,10.1,80000,400,500,600\n", strStream.str());

    // data is useless
    opRes->stat[0].result = 1;
    strStream.str("");
    Adx::AdxDumpRecord::Instance().GenerateFileData(strStream, srcFile, opRes);
    EXPECT_EQ("Input/Output,Index,Data Size,Data Type,Format,Shape,Max Value,Min Value,Avg Value,Count,Nan Count,Negative Inf Count,Positive Inf Count\n"
        "Input,0,268435456,DT_INT32,ALL,100x20x40,NA,NA,NA,80000,NA,NA,NA\n", strStream.str());

    opRes->statItem = DUMP_STATS_MAX | DUMP_STATS_MIN | DUMP_STATS_L2NORM;
    dtUnion.floatValue = 90.30045678;
    opRes->stat[0].stats[6] = dtUnion.longIntValue;
    opRes->stat[0].result = 0;
    strStream.str("");
    Adx::AdxDumpRecord::Instance().GenerateFileData(strStream, srcFile, opRes);
    EXPECT_EQ("Input/Output,Index,Data Size,Data Type,Format,Shape,Count,Max Value,Min Value,l2norm\n"
        "Input,0,268435456,DT_INT32,ALL,100x20x40,1234,5678,90.3005\n", strStream.str());
}

TEST_F(ADX_DUMP_RECORD_TEST, CheckFileNameCycle)
{
    const std::string fileName1 = "file_name_1";
    const std::string fileName2 = "file_name_2";

    Adx::AdxDumpRecord::Instance().AppendFileName(fileName1);
    for (int32_t i = 0; i < 5; ++i) {
        Adx::AdxDumpRecord::Instance().AppendFileName(fileName2);
    }
    EXPECT_EQ(true, Adx::AdxDumpRecord::Instance().CheckFileNameExist(fileName1));
    for (int32_t i = 0; i < 5; ++i) {
        Adx::AdxDumpRecord::Instance().AppendFileName(fileName2);
    }
    EXPECT_EQ(false, Adx::AdxDumpRecord::Instance().CheckFileNameExist(fileName1));

    // stop optimization mode
    AdxDumpRecord::Instance().SetOptimizationMode(0);
}

TEST_F(ADX_DUMP_RECORD_TEST, GetStatsString)
{
    EXPECT_EQ("NA", AdxDumpRecord::Instance().GetStatsString(toolkit::dump::DT_INT32, 100, 100));
}

TEST_F(ADX_DUMP_RECORD_TEST, FileNameCheck)
{
    const char *srcFile = "aclnnBatchMatMul_0_L2.aclnnBatchMatMul.65535.65535.1725960383079645.bin";
    Adx::DumpChunk dumpChunk;
    dumpChunk.bufLen = sizeof(OpStatsResult);
    dumpChunk.flag = 0;
    dumpChunk.isLastChunk = 1;
    dumpChunk.offset = -1;
    strcpy(dumpChunk.fileName, srcFile);
    EXPECT_TRUE(AdxDumpRecord::Instance().FileNameCheck(dumpChunk));
}