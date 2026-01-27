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
#include "mockcpp/mockcpp.hpp"
#define protected public
#define private public

#include "adx_dump_record.h"
#include "adx_dump_process.h"
#include "mmpa_api.h"
#include "file_utils.h"
#include "adx_msg_proto.h"
#include "adx_msg.h"
#include "memory_utils.h"
#include "common_utils.h"

using namespace Adx;
class ADX_DUMP_RECORD_STEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

int messageCallback(const Adx::DumpChunk * data, int len)
{
    if((sizeof(Adx::DumpChunk) + data->bufLen) == len) {
	    printf("ADX_DUMP_RECORD_STEST: messageCallback ok\n");
        return 0;
    } else {
        return -1;
    }
}

TEST_F(ADX_DUMP_RECORD_STEST, Init)
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

TEST_F(ADX_DUMP_RECORD_STEST, UnInit)
{
    int ret = Adx::AdxDumpRecord::Instance().UnInit();
    EXPECT_EQ(IDE_DAEMON_OK, ret);
}

TEST_F(ADX_DUMP_RECORD_STEST, UpdateDumpInitNum)
{
    Adx::AdxDumpRecord::Instance().UpdateDumpInitNum(true);
    int ret = Adx::AdxDumpRecord::Instance().GetDumpInitNum();
    EXPECT_EQ(1, ret);
    Adx::AdxDumpRecord::Instance().UpdateDumpInitNum(false);
    ret = Adx::AdxDumpRecord::Instance().GetDumpInitNum();
    EXPECT_EQ(0, ret);
}



TEST_F(ADX_DUMP_RECORD_STEST, RecordDumpDataToDisk)
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

TEST_F(ADX_DUMP_RECORD_STEST, RecordDumpDataToQueue)
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

TEST_F(ADX_DUMP_RECORD_STEST, RecordDumpDataToFullQueue)
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

TEST_F(ADX_DUMP_RECORD_STEST, RecordDumpDataToFullQueueLimit)
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

TEST_F(ADX_DUMP_RECORD_STEST, RecordDumpInfoToMindspore)
{
    const char *srcFile = "adx_data_dump_server_manager1";
    uint32_t dataLen = strlen(srcFile) + 1 + sizeof(Adx::DumpChunk);
    Adx::AdxDumpProcess::Instance().MessageCallbackRegister(messageCallback);
    MsgProto *msg = Adx::AdxMsgProto::CreateMsgPacket(IDE_DUMP_REQ, 0, nullptr, dataLen);
    Adx::SharedPtr<MsgProto> msgPtr(msg, IdeXfree);
    Adx::HostDumpDataInfo info = {msgPtr, dataLen};
    bool ret = Adx::AdxDumpRecord::Instance().RecordDumpDataToQueue(info);
    EXPECT_EQ(true, ret);
    Adx::AdxDumpRecord::Instance().RecordDumpInfo();
}

TEST_F(ADX_DUMP_RECORD_STEST, RecordDumpInfoToOptimizedMode)
{
    const char *srcFile = "aclnnBatchMatMul_0_L2.aclnnBatchMatMul.65535.65535.1725960383079645.bin";
    uint64_t statsItem = DUMP_STATS_MAX | DUMP_STATS_MIN | DUMP_STATS_AVG | DUMP_STATS_NAN | DUMP_STATS_NEG_INF | DUMP_STATS_POS_INF;
    size_t dumpChunkSize = sizeof(DumpChunk) + sizeof(OpStatsResult);

    OpStatsResult opStatsResult;
    opStatsResult.tensorNum = 1;
    TensorStatsResult tensorStatsResult = {268435456, toolkit::dump::DT_INT64, toolkit::dump::FORMAT_ND, 3, { 0 }, 0, 6, { 0 }, 0, 1};
    tensorStatsResult.shape[0] = 100;
    tensorStatsResult.shape[1] = 20;
    tensorStatsResult.shape[2] = 35;
    tensorStatsResult.stats[0] = 100;
    tensorStatsResult.stats[1] = 200;
    DataTypeUnion dtUnion;
    dtUnion.floatValue = 10.10;
    tensorStatsResult.stats[2] = dtUnion.longIntValue;
    tensorStatsResult.stats[3] = 400;
    tensorStatsResult.stats[4] = 500;
    tensorStatsResult.stats[5] = 600;
    opStatsResult.stat[0] = tensorStatsResult;
    opStatsResult.statItem = statsItem;

    std::shared_ptr<DumpChunk> dumpChunk(static_cast<DumpChunk*>(::operator new(dumpChunkSize)), [](DumpChunk* ptr) { ::operator delete(ptr); });
    dumpChunk->bufLen = sizeof(OpStatsResult);
    dumpChunk->isLastChunk = 1;
    dumpChunk->offset = -1;
    dumpChunk->flag = 0;
    strcpy(dumpChunk->fileName, srcFile);
    memcpy(dumpChunk->dataBuf, &opStatsResult, sizeof(OpStatsResult));

    std::shared_ptr<MsgProto> msgProto(static_cast<MsgProto*>(::operator new(sizeof(MsgProto) + dumpChunkSize)), [](MsgProto* ptr) { ::operator delete(ptr); });
    msgProto->headInfo = 0xABCD;
    msgProto->headVer = 1;
    msgProto->order = 0;
    msgProto->reqType = 1;
    msgProto->devId = 1;
    msgProto->totalLen = dumpChunkSize;
    msgProto->sliceLen = dumpChunkSize;
    msgProto->offset = 0;
    msgProto->msgType = Adx::MsgType::MSG_DATA;
    msgProto->status = Adx::MsgStatus::MSG_STATUS_FILE_LOAD;
    memcpy(msgProto->data, dumpChunk.get(), dumpChunkSize);

    Adx::HostDumpDataInfo info = {msgProto, dumpChunkSize};
    bool ret = Adx::AdxDumpRecord::Instance().RecordDumpDataToQueue(info);
    EXPECT_EQ(true, ret);
    MOCKER(Adx::FileUtils::IsDiskFull)
        .stubs().will(returnValue(false));
    MOCKER(Adx::FileUtils::FileNameIsReal)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    MOCKER_CPP(&Adx::AdxDumpProcess::IsRegistered)
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));

    Adx::AdxDumpRecord::Instance().SetOptimizationMode(statsItem);
    Adx::AdxDumpRecord::Instance().RecordDumpInfo();

    Adx::AdxDumpRecord::Instance().SetDumpPath("./");
    ret = Adx::AdxDumpRecord::Instance().RecordDumpDataToQueue(info);
    EXPECT_EQ(true, ret);
    Adx::AdxDumpRecord::Instance().RecordDumpInfo();

    std::cout << sizeof(OpStatsResult) << " : " << sizeof(TensorStatsResult) << " : " << sizeof(DumpChunk) << std::endl;
    Adx::AdxDumpRecord::Instance().SetOptimizationMode(0);
}