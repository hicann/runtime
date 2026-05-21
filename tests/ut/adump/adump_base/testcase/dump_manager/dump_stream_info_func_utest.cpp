/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
// Include dump_manager and adx_dump_record BEFORE gtest to avoid testing::Test type conflict
#include "dump_manager.h"
#include "dump_memory.h"
#include "adx_dump_record.h"
#include "common/thread.h"
#include <gtest/gtest.h>
#include <thread>
#include <chrono>
#include "mockcpp/mockcpp.hpp"
#include "dump_stream_info.h"
#include "dump_setting.h"

using namespace Adx;

static void WaitInterval_stub(uint32_t intervalSec)
{
    (void)intervalSec;
}

static DumpTensor BuildFuncTestTensor(void* addr, size_t size, int32_t dataType = 0, int32_t format = 0)
{
    TensorInfoV2 info = {};
    info.tensorAddr = reinterpret_cast<int64_t*>(addr);
    info.tensorSize = size;
    info.dataType = dataType;
    info.format = format;
    info.shape = {1};
    info.originShape = {1};
    info.addrType = AddressType::TRADITIONAL;
    info.argsOffSet = 0;
    return DumpTensor(info);
}

static DumpStreamInfo BuildFuncTestStreamInfo(const std::string& key = "stream_key",
                                              const std::string& opName = "TestOp",
                                              const std::string& opType = "TestOpType",
                                              const std::string& dumpPath = "/tmp/dump_test")
{
    DumpStreamInfo info = {};
    info.stm = reinterpret_cast<rtStream_t>(0x1);
    info.mainStmEvt = reinterpret_cast<rtEvent_t>(0x1);
    info.dumpStmEvt = reinterpret_cast<rtEvent_t>(0x1);
    info.mainStreamKey = key;
    info.opName = opName;
    info.opType = opType;
    info.dumpPath = dumpPath;
    info.taskId = 42U;
    info.streamId = 7U;
    info.deviceId = 0U;
    info.contextId = 0U;
    info.threadId = 0U;
    info.timestamp = 123456789U;
    info.dumpNumber = 1U;
    return info;
}

class DumpStreamInfoFuncUtest : public testing::Test {
protected:
    virtual void SetUp()
    {
        MOCKER(DumpResourceSafeMap::WaitInterval).stubs().will(invoke(WaitInterval_stub));
        MOCKER(Thread::CreateDetachTaskWithDefaultAttr).stubs().will(returnValue(EN_OK));
        MOCKER(&AdxDumpRecord::RecordDumpDataToQueue).stubs().will(returnValue(true));

        DumpConfig dumpConf;
        dumpConf.dumpPath = "/tmp/dump_test";
        dumpConf.dumpStatus = "on";
        dumpConf.dumpMode = "all";
        (void)DumpManager::Instance().SetDumpConfig(DumpType::OPERATOR, dumpConf);

        DumpResourceSafeMap::Instance().clear();
    }
    virtual void TearDown()
    {
        DumpResourceSafeMap::Instance().waitAndClear();
        DumpResourceSafeMap::Instance().clear();
        DumpManager::Instance().Reset();
        GlobalMockObject::verify();
    }
};

// Separate fixture without RecordDumpDataToQueue mock to test queue-full path
class DumpStreamQueueUtest : public testing::Test {
protected:
    virtual void SetUp()
    {
        MOCKER(DumpResourceSafeMap::WaitInterval).stubs().will(invoke(WaitInterval_stub));
        MOCKER(Thread::CreateDetachTaskWithDefaultAttr).stubs().will(returnValue(EN_OK));
        DumpConfig dumpConf;
        dumpConf.dumpPath = "/tmp/dump_test";
        dumpConf.dumpStatus = "on";
        dumpConf.dumpMode = "all";
        (void)DumpManager::Instance().SetDumpConfig(DumpType::OPERATOR, dumpConf);
        DumpResourceSafeMap::Instance().clear();
    }
    virtual void TearDown()
    {
        DumpResourceSafeMap::Instance().waitAndClear();
        DumpResourceSafeMap::Instance().clear();
        DumpManager::Instance().Reset();
        GlobalMockObject::verify();
    }
};

// DumpTensorPushToDumpQueue: queue full (lines 302-303 in dump_stream_info.cpp)
TEST_F(DumpStreamQueueUtest, Test_DumpTensorPushToDumpQueue_QueueFull)
{
    MOCKER(&AdxDumpRecord::RecordDumpDataToQueue).stubs().will(returnValue(false));
    char dataBuf[64] = "test_queue_full";
    const char* fileName = "/tmp/dump/0/Op.FullTest.1.1.1.234567";
    int32_t ret = DumpTensorPushToDumpQueue(dataBuf, sizeof(dataBuf), fileName, 0, 1);
    EXPECT_EQ(ret, ADUMP_FAILED);
}

// CopyTensorDataWithFlush: full buffer (ctx.offset == DUMP_SLICE_SIZE) + flush success
// Covers lines 343-344, 348 in dump_stream_info.cpp
TEST_F(DumpStreamQueueUtest, Test_CopyTensorDataWithFlush_FullBuffer_FlushSuccess)
{
    MOCKER(&AdxDumpRecord::RecordDumpDataToQueue).stubs().will(returnValue(true));
    std::vector<char> buf(DUMP_SLICE_SIZE);
    size_t offset = DUMP_SLICE_SIZE;  // buffer completely full
    std::string fileName = "/tmp/dump/0/TestFullBufFlush";
    ChunkContext ctx{buf, offset, fileName};

    // Use heap allocation: CopyDeviceToHost return value is freed by HOST_RT_MEMORY_GUARD via rtFreeHost
    void* fakeHostData = malloc(16);
    ASSERT_NE(fakeHostData, nullptr);
    char fakeDevAddr[16] = {0};
    MOCKER(&DumpMemory::CopyDeviceToHost).stubs().will(returnValue(fakeHostData));
    // Mock FreeHost to prevent double-free (mock may return the same ptr multiple times)
    MOCKER(&DumpMemory::FreeHost).stubs();

    TensorInfoV2 info = {};
    info.tensorAddr = reinterpret_cast<int64_t*>(fakeDevAddr);
    info.tensorSize = 16;
    info.addrType = AddressType::TRADITIONAL;
    DumpTensor tensor(info);

    // Space = 0 → FlushCurrentChunk called, success → space = DUMP_SLICE_SIZE
    int32_t ret = CopyTensorDataWithFlush(tensor, ctx, true);
    free(fakeHostData);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

// ============================================================================
// GetNextDumpNumber
// ============================================================================
TEST_F(DumpStreamInfoFuncUtest, Test_GetNextDumpNumber_Increments)
{
    uint64_t n1 = GetNextDumpNumber();
    uint64_t n2 = GetNextDumpNumber();
    uint64_t n3 = GetNextDumpNumber();
    EXPECT_EQ(n2, n1 + 1);
    EXPECT_EQ(n3, n1 + 2);
}

// ============================================================================
// GenerateDumpFileName
// ============================================================================
TEST_F(DumpStreamInfoFuncUtest, Test_GenerateDumpFileName_TrailingSlash)
{
    DumpStreamInfo info = BuildFuncTestStreamInfo("key", "OpName", "OpType", "/tmp/dump/");
    info.deviceId = 1U;
    info.dumpNumber = 5U;
    info.taskId = 10U;
    info.streamId = 20U;
    info.timestamp = 999U;
    info.contextId = 0U;
    info.threadId = 0U;

    std::string name = GenerateDumpFileName(&info);
    EXPECT_NE(name.find("OpType.OpName.5.10.20.999"), std::string::npos);
    EXPECT_NE(name.find("/tmp/dump/1/"), std::string::npos);
    EXPECT_EQ(name.find("FFTSPLUS"), std::string::npos);
}

TEST_F(DumpStreamInfoFuncUtest, Test_GenerateDumpFileName_NoTrailingSlash)
{
    DumpStreamInfo info = BuildFuncTestStreamInfo("key", "OpName", "OpType", "/tmp/dump");
    info.deviceId = 2U;
    info.dumpNumber = 3U;
    info.taskId = 11U;
    info.streamId = 22U;
    info.timestamp = 777U;
    info.contextId = 0U;
    info.threadId = 0U;

    std::string name = GenerateDumpFileName(&info);
    EXPECT_NE(name.find("/tmp/dump/2/OpType.OpName.3.11.22.777"), std::string::npos);
}

TEST_F(DumpStreamInfoFuncUtest, Test_GenerateDumpFileName_WithContextThread)
{
    DumpStreamInfo info = BuildFuncTestStreamInfo("key", "OpA", "TypeA", "/tmp/dump/");
    info.deviceId = 3U;
    info.dumpNumber = 1U;
    info.taskId = 5U;
    info.streamId = 6U;
    info.timestamp = 100U;
    info.contextId = 200U;
    info.threadId = 300U;

    std::string name = GenerateDumpFileName(&info);
    EXPECT_NE(name.find("FFTSPLUS.200.300.3"), std::string::npos);
}

// ============================================================================
// CalculateTensorDataSize
// ============================================================================
TEST_F(DumpStreamInfoFuncUtest, Test_CalculateTensorDataSize_Empty)
{
    std::vector<DumpTensor> tensors;
    EXPECT_EQ(CalculateTensorDataSize(tensors), 0UL);
}

TEST_F(DumpStreamInfoFuncUtest, Test_CalculateTensorDataSize_Multiple)
{
    char data[64] = {};
    std::vector<DumpTensor> tensors;
    tensors.push_back(BuildFuncTestTensor(data, 10));
    tensors.push_back(BuildFuncTestTensor(data, 20));
    tensors.push_back(BuildFuncTestTensor(data, 34));
    EXPECT_EQ(CalculateTensorDataSize(tensors), 64UL);
}

// ============================================================================
// FillTensorProtoInfo
// ============================================================================
TEST_F(DumpStreamInfoFuncUtest, Test_FillTensorProtoInfo_Input)
{
    char data[16] = {};
    std::vector<DumpTensor> tensors;
    tensors.push_back(BuildFuncTestTensor(data, 16, 0, 0));

    toolkit::dump::DumpData dumpData;
    FillTensorProtoInfo(tensors, dumpData, true);

    EXPECT_EQ(dumpData.input_size(), 1);
    EXPECT_EQ(dumpData.output_size(), 0);
    EXPECT_EQ(static_cast<size_t>(dumpData.input(0).size()), 16UL);
}

TEST_F(DumpStreamInfoFuncUtest, Test_FillTensorProtoInfo_Output)
{
    char data[32] = {};
    std::vector<DumpTensor> tensors;
    tensors.push_back(BuildFuncTestTensor(data, 32, 1, 0));

    toolkit::dump::DumpData dumpData;
    FillTensorProtoInfo(tensors, dumpData, false);

    EXPECT_EQ(dumpData.output_size(), 1);
    EXPECT_EQ(dumpData.input_size(), 0);
    EXPECT_EQ(static_cast<size_t>(dumpData.output(0).size()), 32UL);
}

TEST_F(DumpStreamInfoFuncUtest, Test_FillTensorProtoInfo_Empty)
{
    std::vector<DumpTensor> tensors;
    toolkit::dump::DumpData dumpData;
    FillTensorProtoInfo(tensors, dumpData, true);
    EXPECT_EQ(dumpData.input_size(), 0);
    EXPECT_EQ(dumpData.output_size(), 0);
}

// ============================================================================
// BuildDumpDataProto
// ============================================================================
TEST_F(DumpStreamInfoFuncUtest, Test_BuildDumpDataProto_BasicFields)
{
    DumpStreamInfo info = BuildFuncTestStreamInfo("k", "MyOp", "MyType");
    info.timestamp = 88888U;

    toolkit::dump::DumpData proto = BuildDumpDataProto(&info);
    EXPECT_EQ(proto.op_name(), "MyOp");
    EXPECT_EQ(proto.dump_time(), 88888U);
    EXPECT_EQ(proto.version(), "2.0");
}

TEST_F(DumpStreamInfoFuncUtest, Test_BuildDumpDataProto_WithTensors)
{
    DumpStreamInfo info = BuildFuncTestStreamInfo();
    char buf[8] = {};
    info.inputTensors.push_back(BuildFuncTestTensor(buf, 8));
    info.outputTensors.push_back(BuildFuncTestTensor(buf, 4));

    toolkit::dump::DumpData proto = BuildDumpDataProto(&info);
    EXPECT_EQ(proto.input_size(), 1);
    EXPECT_EQ(proto.output_size(), 1);
}

// ============================================================================
// DumpTensorPushToDumpQueue
// ============================================================================
TEST_F(DumpStreamInfoFuncUtest, Test_DumpTensorPushToDumpQueue_Success)
{
    char dataBuf[64] = "test_data_for_dump_queue";
    const char* fileName = "/tmp/dump/0/Op.TestOp.1.1.1.123456";
    int32_t ret = DumpTensorPushToDumpQueue(dataBuf, sizeof(dataBuf), fileName, 0, 1);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

// ============================================================================
// FlushCurrentChunk (only empty-offset path; non-zero offset requires DUMP_SLICE_SIZE buffer)
// ============================================================================
TEST_F(DumpStreamInfoFuncUtest, Test_FlushCurrentChunk_EmptyOffset)
{
    std::vector<char> buf(DUMP_SLICE_SIZE);
    size_t offset = 0;
    std::string fileName = "/tmp/dump/0/TestFlush";
    ChunkContext ctx{buf, offset, fileName};

    EXPECT_EQ(FlushCurrentChunk(ctx, 1), ADUMP_SUCCESS);
    EXPECT_EQ(ctx.offset, 0UL);
}

// FlushCurrentChunk with non-zero offset (lines 317) - DumpTensorPushToDumpQueue fails
TEST_F(DumpStreamQueueUtest, Test_FlushCurrentChunk_NonZeroOffset_QueueFull)
{
    MOCKER(&AdxDumpRecord::RecordDumpDataToQueue).stubs().will(returnValue(false));
    std::vector<char> buf(DUMP_SLICE_SIZE, 'x');
    size_t offset = 64;
    std::string fileName = "/tmp/dump/0/TestFlushNonZero";
    ChunkContext ctx{buf, offset, fileName};

    int32_t ret = FlushCurrentChunk(ctx, 1);
    EXPECT_NE(ret, ADUMP_SUCCESS);
}

// FlushCurrentChunk with non-zero offset - success path (resets offset)
TEST_F(DumpStreamInfoFuncUtest, Test_FlushCurrentChunk_NonZeroOffset_Success)
{
    std::vector<char> buf(DUMP_SLICE_SIZE, 'x');
    size_t offset = 64;
    std::string fileName = "/tmp/dump/0/TestFlushNonZeroSuccess";
    ChunkContext ctx{buf, offset, fileName};

    int32_t ret = FlushCurrentChunk(ctx, 1);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_EQ(ctx.offset, 0UL);
}

// ============================================================================
// CopyTensorDataWithFlush (null-address early-return path only)
// ============================================================================
TEST_F(DumpStreamInfoFuncUtest, Test_CopyTensorDataWithFlush_NullAddress)
{
    std::vector<char> buf(DUMP_SLICE_SIZE);
    size_t offset = 0;
    std::string fileName = "/tmp/dump/0/TestCopy";
    ChunkContext ctx{buf, offset, fileName};

    TensorInfoV2 info = {};
    info.tensorAddr = nullptr;
    info.tensorSize = 16;
    DumpTensor tensor(info);

    EXPECT_EQ(CopyTensorDataWithFlush(tensor, ctx, true), ADUMP_FAILED);
}

// CopyTensorDataWithFlush: CopyDeviceToHost returns nullptr (lines 355-356)
TEST_F(DumpStreamInfoFuncUtest, Test_CopyTensorDataWithFlush_CopyDeviceToHostFails)
{
    std::vector<char> buf(DUMP_SLICE_SIZE);
    size_t offset = 0;
    std::string fileName = "/tmp/dump/0/TestCopyDeviceNull";
    ChunkContext ctx{buf, offset, fileName};

    char fakeDevAddr[16] = {0};
    void* nullPtr = nullptr;
    MOCKER(&DumpMemory::CopyDeviceToHost).stubs().will(returnValue(nullPtr));

    TensorInfoV2 info = {};
    info.tensorAddr = reinterpret_cast<int64_t*>(fakeDevAddr);
    info.tensorSize = 16;
    info.addrType = AddressType::TRADITIONAL;
    DumpTensor tensor(info);

    EXPECT_EQ(CopyTensorDataWithFlush(tensor, ctx, true), ADUMP_FAILED);
}

// ============================================================================
// CopyTensorsWithChunking
// ============================================================================
TEST_F(DumpStreamInfoFuncUtest, Test_CopyTensorsWithChunking_Empty)
{
    std::vector<char> buf(DUMP_SLICE_SIZE);
    size_t offset = 0;
    std::string fileName = "/tmp/dump/0/TestChunking";
    ChunkContext ctx{buf, offset, fileName};

    std::vector<DumpTensor> tensors;
    EXPECT_EQ(CopyTensorsWithChunking(tensors, ctx, true), ADUMP_SUCCESS);
    EXPECT_EQ(ctx.offset, 0UL);
}

TEST_F(DumpStreamInfoFuncUtest, Test_CopyTensorsWithChunking_NullAddrFail)
{
    std::vector<char> buf(DUMP_SLICE_SIZE);
    size_t offset = 0;
    std::string fileName = "/tmp/dump/0/TestChunkingFail";
    ChunkContext ctx{buf, offset, fileName};

    TensorInfoV2 info = {};
    info.tensorAddr = nullptr;
    info.tensorSize = 16;
    std::vector<DumpTensor> tensors;
    tensors.emplace_back(info);

    EXPECT_EQ(CopyTensorsWithChunking(tensors, ctx, true), ADUMP_FAILED);
}

// ============================================================================
// DumpTensorToQueue
// ============================================================================
TEST_F(DumpStreamInfoFuncUtest, Test_DumpTensorToQueue_NullPtr)
{
    DumpTensorToQueue(nullptr);
}

TEST_F(DumpStreamInfoFuncUtest, Test_DumpTensorToQueue_NoTensors)
{
    DumpStreamInfo info = BuildFuncTestStreamInfo("key_notensor", "EmptyOp", "TypeX");
    DumpTensorToQueue(&info);
}

TEST_F(DumpStreamInfoFuncUtest, Test_DumpTensorToQueue_WithTensors)
{
    DumpStreamInfo info = BuildFuncTestStreamInfo("key_withtensor", "OpWithData", "TypeY");
    char inData[33] = "input_tensor_data_here__________";
    char outData[17] = "output_data_16b_";
    info.inputTensors.push_back(BuildFuncTestTensor(inData, 32));
    info.outputTensors.push_back(BuildFuncTestTensor(outData, 16));

    DumpTensorToQueue(&info);
}

TEST_F(DumpStreamInfoFuncUtest, Test_DumpTensorToQueue_OnlyInput)
{
    DumpStreamInfo info = BuildFuncTestStreamInfo("key_onlyin", "OpIn", "TypeIn");
    char data[9] = "indata__";
    info.inputTensors.push_back(BuildFuncTestTensor(data, 8));
    DumpTensorToQueue(&info);
}

// ============================================================================
// CollectStreamContextInfo
// ============================================================================
TEST_F(DumpStreamInfoFuncUtest, Test_CollectStreamContextInfo_Success)
{
    aclrtStream mainStream = reinterpret_cast<aclrtStream>(0x1);
    uint32_t streamId = 0, taskId = 0, deviceId = 0;
    std::string dumpPath;

    int32_t ret = CollectStreamContextInfo(mainStream, "OpA", "TypeA", streamId, taskId, deviceId, dumpPath);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    // dumpPath includes a timestamp suffix, check prefix only
    EXPECT_EQ(dumpPath.find("/tmp/dump_test"), 0U);
    EXPECT_FALSE(dumpPath.empty());
}

TEST_F(DumpStreamInfoFuncUtest, Test_CollectStreamContextInfo_StreamIdFail)
{
    MOCKER(rtsStreamGetId).stubs().will(returnValue(-1));
    aclrtStream mainStream = reinterpret_cast<aclrtStream>(0x1);
    uint32_t streamId = 0, taskId = 0, deviceId = 0;
    std::string dumpPath;

    EXPECT_EQ(CollectStreamContextInfo(mainStream, "Op", "Type", streamId, taskId, deviceId, dumpPath), ADUMP_FAILED);
}

TEST_F(DumpStreamInfoFuncUtest, Test_CollectStreamContextInfo_TaskIdFail)
{
    MOCKER(rtsGetThreadLastTaskId).stubs().will(returnValue(-1));
    aclrtStream mainStream = reinterpret_cast<aclrtStream>(0x1);
    uint32_t streamId = 0, taskId = 0, deviceId = 0;
    std::string dumpPath;

    EXPECT_EQ(CollectStreamContextInfo(mainStream, "Op", "Type", streamId, taskId, deviceId, dumpPath), ADUMP_FAILED);
}

TEST_F(DumpStreamInfoFuncUtest, Test_CollectStreamContextInfo_DeviceFail)
{
    MOCKER(rtGetDevice).stubs().will(returnValue(-1));
    aclrtStream mainStream = reinterpret_cast<aclrtStream>(0x1);
    uint32_t streamId = 0, taskId = 0, deviceId = 0;
    std::string dumpPath;

    EXPECT_EQ(CollectStreamContextInfo(mainStream, "Op", "Type", streamId, taskId, deviceId, dumpPath), ADUMP_FAILED);
}

TEST_F(DumpStreamInfoFuncUtest, Test_CollectStreamContextInfo_EmptyPath)
{
    // Reset() does not clear dumpSetting_.dumpPath_; mock GetDumpPath to return empty string
    MOCKER_CPP(&Adx::DumpSetting::GetDumpPath).stubs().will(returnValue(std::string("")));
    aclrtStream mainStream = reinterpret_cast<aclrtStream>(0x1);
    uint32_t streamId = 0, taskId = 0, deviceId = 0;
    std::string dumpPath;

    EXPECT_EQ(CollectStreamContextInfo(mainStream, "OpB", "TypeB", streamId, taskId, deviceId, dumpPath), ADUMP_FAILED);
}

// ============================================================================
// DumpStreamCreate error paths
// ============================================================================
TEST_F(DumpStreamInfoFuncUtest, Test_DumpStreamCreate_FirstEventFail)
{
    MOCKER(rtEventCreateExWithFlag).stubs().will(returnValue(-1));
    DumpStreamInfo* ptr = nullptr;
    EXPECT_NE(DumpStreamCreate(&ptr), ADUMP_SUCCESS);
    EXPECT_EQ(ptr, nullptr);
}

TEST_F(DumpStreamInfoFuncUtest, Test_DumpStreamCreate_SecondEventFail)
{
    MOCKER(rtEventCreateExWithFlag)
        .stubs()
        .will(returnValue(RT_ERROR_NONE))
        .then(returnValue(-1));
    DumpStreamInfo* ptr = nullptr;
    EXPECT_NE(DumpStreamCreate(&ptr), ADUMP_SUCCESS);
    EXPECT_EQ(ptr, nullptr);
}

TEST_F(DumpStreamInfoFuncUtest, Test_DumpStreamCreate_StreamFail)
{
    MOCKER(rtStreamCreate).stubs().will(returnValue(-1));
    DumpStreamInfo* ptr = nullptr;
    EXPECT_NE(DumpStreamCreate(&ptr), ADUMP_SUCCESS);
    EXPECT_EQ(ptr, nullptr);
}

TEST_F(DumpStreamInfoFuncUtest, Test_DumpStreamCreate_GetStreamIdFail)
{
    MOCKER(rtGetStreamId).stubs().will(returnValue(-1));
    DumpStreamInfo* ptr = nullptr;
    EXPECT_NE(DumpStreamCreate(&ptr), ADUMP_SUCCESS);
    EXPECT_EQ(ptr, nullptr);
}

// ============================================================================
// DumpDataRecordInCaptureStream
// ============================================================================
TEST_F(DumpStreamInfoFuncUtest, Test_DumpDataRecordInCaptureStream_NullArgs)
{
    DumpDataRecordInCaptureStream(nullptr);
}

TEST_F(DumpStreamInfoFuncUtest, Test_DumpDataRecordInCaptureStream_ValidArgs)
{
    DumpStreamInfo* rawPtr = nullptr;
    ASSERT_EQ(DumpStreamCreate(&rawPtr), ADUMP_SUCCESS);
    rawPtr->opName = "TestOpCapture";
    rawPtr->opType = "TestTypeCapture";
    rawPtr->dumpPath = "/tmp/dump_test";
    rawPtr->timestamp = 111U;
    rawPtr->dumpNumber = 1U;
    rawPtr->mainStreamKey = "capture_key";

    auto dumpInfo = std::shared_ptr<DumpStreamInfo>(rawPtr, DumpStreamFree);
    DumpResourceSafeMap::Instance().insert("capture_key", dumpInfo);

    auto* callbackArg = new std::shared_ptr<DumpStreamInfo>(dumpInfo);
    DumpDataRecordInCaptureStream(static_cast<void*>(callbackArg));

    std::this_thread::sleep_for(std::chrono::milliseconds(50));
    DumpResourceSafeMap::Instance().waitAndClear();
}

TEST_F(DumpStreamInfoFuncUtest, Test_DumpDataRecordInCaptureStream_WithTensors)
{
    DumpStreamInfo* rawPtr = nullptr;
    ASSERT_EQ(DumpStreamCreate(&rawPtr), ADUMP_SUCCESS);
    rawPtr->opName = "TensorOp";
    rawPtr->opType = "TensorType";
    rawPtr->dumpPath = "/tmp/dump_test";
    rawPtr->timestamp = 222U;
    rawPtr->dumpNumber = 2U;
    rawPtr->mainStreamKey = "capture_tensor_key";

    char inData[9] = "in_data_";
    char outData[9] = "outdata_";
    rawPtr->inputTensors.push_back(BuildFuncTestTensor(inData, 8));
    rawPtr->outputTensors.push_back(BuildFuncTestTensor(outData, 8));

    auto dumpInfo = std::shared_ptr<DumpStreamInfo>(rawPtr, DumpStreamFree);
    DumpResourceSafeMap::Instance().insert("capture_tensor_key", dumpInfo);

    auto* callbackArg = new std::shared_ptr<DumpStreamInfo>(dumpInfo);
    DumpDataRecordInCaptureStream(static_cast<void*>(callbackArg));

    std::this_thread::sleep_for(std::chrono::milliseconds(50));
    DumpResourceSafeMap::Instance().waitAndClear();
}

// ============================================================================
// SetupAsyncDump
// ============================================================================
TEST_F(DumpStreamInfoFuncUtest, Test_SetupAsyncDump_Success)
{
    DumpStreamInfo* rawPtr = nullptr;
    ASSERT_EQ(DumpStreamCreate(&rawPtr), ADUMP_SUCCESS);
    rawPtr->opName = "AsyncOp";
    rawPtr->opType = "AsyncType";
    rawPtr->dumpPath = "/tmp/dump_test";
    rawPtr->timestamp = 333U;
    rawPtr->dumpNumber = 3U;
    rawPtr->mainStreamKey = "async_key";

    auto dumpInfo = std::shared_ptr<DumpStreamInfo>(rawPtr, DumpStreamFree);
    aclrtStream mainStream = reinterpret_cast<aclrtStream>(0x1);

    EXPECT_EQ(SetupAsyncDump(dumpInfo, "AsyncOp", "AsyncType", mainStream), ADUMP_SUCCESS);

    std::this_thread::sleep_for(std::chrono::milliseconds(50));
    DumpResourceSafeMap::Instance().waitAndClear();
}

TEST_F(DumpStreamInfoFuncUtest, Test_SetupAsyncDump_EventRecordFail)
{
    MOCKER(rtEventRecord).stubs().will(returnValue(-1));

    DumpStreamInfo* rawPtr = nullptr;
    ASSERT_EQ(DumpStreamCreate(&rawPtr), ADUMP_SUCCESS);
    auto dumpInfo = std::shared_ptr<DumpStreamInfo>(rawPtr, DumpStreamFree);

    EXPECT_EQ(SetupAsyncDump(dumpInfo, "Op", "Type", reinterpret_cast<aclrtStream>(0x1)), ADUMP_FAILED);
}

TEST_F(DumpStreamInfoFuncUtest, Test_SetupAsyncDump_StreamWaitFail)
{
    MOCKER(rtStreamWaitEvent).stubs().will(returnValue(-1));

    DumpStreamInfo* rawPtr = nullptr;
    ASSERT_EQ(DumpStreamCreate(&rawPtr), ADUMP_SUCCESS);
    auto dumpInfo = std::shared_ptr<DumpStreamInfo>(rawPtr, DumpStreamFree);

    EXPECT_EQ(SetupAsyncDump(dumpInfo, "Op", "Type", reinterpret_cast<aclrtStream>(0x1)), ADUMP_FAILED);
}

TEST_F(DumpStreamInfoFuncUtest, Test_SetupAsyncDump_LaunchFail)
{
    MOCKER(rtsLaunchHostFunc).stubs().will(returnValue(-1));

    DumpStreamInfo* rawPtr = nullptr;
    ASSERT_EQ(DumpStreamCreate(&rawPtr), ADUMP_SUCCESS);
    rawPtr->mainStreamKey = "async_launch_fail";
    auto dumpInfo = std::shared_ptr<DumpStreamInfo>(rawPtr, DumpStreamFree);

    EXPECT_EQ(SetupAsyncDump(dumpInfo, "Op", "Type", reinterpret_cast<aclrtStream>(0x1)), ADUMP_FAILED);
}

// ============================================================================
// GetDumpInfoFromMap
// ============================================================================
TEST_F(DumpStreamInfoFuncUtest, Test_GetDumpInfoFromMap_ExistingKey)
{
    DumpStreamInfo* rawPtr = nullptr;
    ASSERT_EQ(DumpStreamCreate(&rawPtr), ADUMP_SUCCESS);
    auto dumpInfo = std::shared_ptr<DumpStreamInfo>(rawPtr, DumpStreamFree);
    DumpResourceSafeMap::Instance().insert("existing_key", dumpInfo);

    DumpInfoParams params;
    params.mainStreamKey = "existing_key";
    params.opName = "Op1";
    params.opType = "Type1";
    params.dumpPath = "/tmp/dump_test";
    params.streamId = 1;
    params.taskId = 2;
    params.deviceId = 0;
    params.contextId = 0;
    params.threadId = 0;

    EXPECT_EQ(GetDumpInfoFromMap(params), ADUMP_SUCCESS);
    EXPECT_EQ(DumpResourceSafeMap::Instance().size(), 1);
}

TEST_F(DumpStreamInfoFuncUtest, Test_GetDumpInfoFromMap_NewKey)
{
    DumpInfoParams params;
    params.mainStreamKey = "new_key_1";
    params.opName = "NewOp";
    params.opType = "NewType";
    params.dumpPath = "/tmp/dump_test";
    params.streamId = 5;
    params.taskId = 6;
    params.deviceId = 0;
    params.contextId = 10;
    params.threadId = 20;

    EXPECT_EQ(GetDumpInfoFromMap(params), ADUMP_SUCCESS);

    auto result = DumpResourceSafeMap::Instance().get("new_key_1");
    ASSERT_NE(result, nullptr);
    EXPECT_EQ(result->opName, "NewOp");
    EXPECT_EQ(result->opType, "NewType");
    EXPECT_EQ(result->streamId, 5U);
    EXPECT_EQ(result->contextId, 10U);
    EXPECT_EQ(result->threadId, 20U);
}

TEST_F(DumpStreamInfoFuncUtest, Test_GetDumpInfoFromMap_WithTensors)
{
    char inData[17] = "input_data_test_";
    char outData[9] = "outtest_";

    TensorInfoV2 inTensor = {};
    inTensor.tensorAddr = reinterpret_cast<int64_t*>(inData);
    inTensor.tensorSize = 16;
    inTensor.addrType = AddressType::TRADITIONAL;

    TensorInfoV2 outTensor = {};
    outTensor.tensorAddr = reinterpret_cast<int64_t*>(outData);
    outTensor.tensorSize = 8;
    outTensor.addrType = AddressType::TRADITIONAL;

    DumpInfoParams params;
    params.mainStreamKey = "new_key_tensors";
    params.opName = "TensorOp";
    params.opType = "TensorType";
    params.dumpPath = "/tmp/dump_test";
    params.streamId = 1;
    params.taskId = 2;
    params.deviceId = 0;
    params.contextId = 0;
    params.threadId = 0;
    params.inputTensors.emplace_back(inTensor);
    params.outputTensors.emplace_back(outTensor);

    EXPECT_EQ(GetDumpInfoFromMap(params), ADUMP_SUCCESS);

    auto result = DumpResourceSafeMap::Instance().get("new_key_tensors");
    ASSERT_NE(result, nullptr);
    EXPECT_GT(result->inputTensors.size(), 0U);
    EXPECT_GT(result->outputTensors.size(), 0U);
}

TEST_F(DumpStreamInfoFuncUtest, Test_GetDumpInfoFromMap_CreateFail)
{
    MOCKER(rtEventCreateExWithFlag).stubs().will(returnValue(-1));

    DumpInfoParams params;
    params.mainStreamKey = "create_fail_key";
    params.opName = "FailOp";
    params.opType = "FailType";
    params.dumpPath = "/tmp/dump_test";
    params.streamId = 1;
    params.taskId = 2;
    params.deviceId = 0;
    params.contextId = 0;
    params.threadId = 0;

    EXPECT_EQ(GetDumpInfoFromMap(params), ADUMP_FAILED);
}

// ============================================================================
// DumpResourceSafeMap: StartCleanupThread called while already active (line 65)
// ============================================================================
TEST_F(DumpStreamInfoFuncUtest, Test_DumpResourceSafeMap_StartCleanupTwice)
{
    DumpStreamInfo* rawPtr = nullptr;
    ASSERT_EQ(DumpStreamCreate(&rawPtr), ADUMP_SUCCESS);
    auto dumpInfo = std::shared_ptr<DumpStreamInfo>(rawPtr, DumpStreamFree);

    // First insert starts the cleanup thread
    DumpResourceSafeMap::Instance().insert("start_cleanup_key1", dumpInfo);
    // Second insert attempts to start the already-active cleanup thread (line 65 path)
    DumpResourceSafeMap::Instance().insert("start_cleanup_key2", dumpInfo);

    DumpResourceSafeMap::Instance().waitAndClear();
    EXPECT_TRUE(true); // Reached here without crash
}

// ============================================================================
// CopyTensorsWithChunking: CopyDeviceToHost returns nullptr covers lines 355-356, 388-390
// ============================================================================
TEST_F(DumpStreamInfoFuncUtest, Test_CopyTensorsWithChunking_DeviceCopyFails)
{
    void* nullPtr = nullptr;
    MOCKER(&DumpMemory::CopyDeviceToHost).stubs().will(returnValue(nullPtr));

    std::vector<char> buf(DUMP_SLICE_SIZE);
    size_t offset = 0;
    std::string fileName = "/tmp/dump/0/TestChunkingDeviceFail";
    ChunkContext ctx{buf, offset, fileName};

    char fakeAddr[16] = {0};
    TensorInfoV2 info = {};
    info.tensorAddr = reinterpret_cast<int64_t*>(fakeAddr);
    info.tensorSize = 16;
    info.addrType = AddressType::TRADITIONAL;
    std::vector<DumpTensor> tensors;
    tensors.emplace_back(info);

    EXPECT_NE(CopyTensorsWithChunking(tensors, ctx, true), ADUMP_SUCCESS);
}
