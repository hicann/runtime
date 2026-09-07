/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "driver/ascend_hal.h"
#include <chrono>
#include <future>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#include "printf.hpp"
#include "fp16_t.h"
#include "bfloat16.h"
#define private public
#define protected public
#include "runtime.hpp"
#include "thread_local_container.hpp"
#include "raw_device.hpp"
#include "aicpu_c.hpp"
#include "stream.hpp"
#include "engine.hpp"
#include "program.hpp"
#include "binary_loader.hpp"
#include "context.hpp"
#include "prof_ctrl_callback_manager.hpp"
#include "common/rt_utest_context_reset_helper.hpp"
#undef private
#undef protected
#include "stream_factory.hpp"
#include "kernel_dfx_info.hpp"
#include "parse_kernel_dfx_info.hpp"

using namespace testing;
using namespace cce::runtime;

namespace {
const uint32_t PARAM_VALUE_LEN = 8;
const uint32_t SIMD_PRINT_RSV_LEN = 8;
const uint32_t SIMT_PRINT_RSV_LEN = 40;

void EmptyParseDfxInfoCallback(const rtDfxParseParam* param, uint64_t* consumedLen)
{
    UNUSED(param);
    *consumedLen = 0U;
}
} // namespace

class PrintfTest : public testing::Test {
protected:
    static void SetUpTestCase() {}

    static void TearDownTestCase() {}

    virtual void SetUp() {}

    virtual void TearDown() {}
};

template <typename T>
unsigned char* DumpInfoAppendByte(unsigned char* buf, T src)
{
    T* dst = (T*)buf;
    *dst = src;
    return buf + sizeof(T);
}

static unsigned char* AddTimeStampInfo(unsigned char* data, int32_t dumpSize, uint32_t timeStampInfoLen)
{
    for (int32_t i = 0; i < dumpSize; ++i) {
        uint32_t type = 6U;
        uint32_t infoLen = timeStampInfoLen; // 数据长度，如果小于sizeof(MsprofAicTimeStampInfo)则不合法
        uint32_t descId = 10U;
        uint32_t rsv = 0U;
        uint64_t timeStamp = 8662162037790U;
        uint64_t pcPtr = 20619064410912U;
        uint64_t entry = 0U;
        data = DumpInfoAppendByte(data, type);
        data = DumpInfoAppendByte(data, infoLen);
        data = DumpInfoAppendByte(data, descId);
        data = DumpInfoAppendByte(data, rsv);
        data = DumpInfoAppendByte(data, timeStamp);
        data = DumpInfoAppendByte(data, pcPtr);
        data = DumpInfoAppendByte(data, entry);
    }
    return data;
}

static unsigned char* ConstructBlock(unsigned char* data, uint32_t timeStampInfoLen)
{
    unsigned char* addr = data;
    int32_t dumpSize = 10; // timestamp类型tlv个数
    size_t dataLen = sizeof(BlockInfo) + sizeof(BlockReadInfo) + (sizeof(DumpInfoHead) + timeStampInfoLen) * dumpSize +
                     sizeof(BlockWriteInfo);
    BlockInfo blockInfo{};
    blockInfo.length = 2048U;
    blockInfo.coreId = 0U;
    blockInfo.blockNum = 2U;
    blockInfo.remainLen = blockInfo.length - dataLen;
    blockInfo.magic = 0xAE86U;
    blockInfo.rsv = 0U;
    data = DumpInfoAppendByte(data, blockInfo);

    BlockReadInfo readInfo{};
    readInfo.readIdx = 0U;
    data = DumpInfoAppendByte(data, readInfo);

    data = AddTimeStampInfo(data, dumpSize, timeStampInfoLen);

    BlockWriteInfo writeInfo{};
    writeInfo.writeIdx = (sizeof(DumpInfoHead) + timeStampInfoLen) * dumpSize;
    unsigned char* writeInfoAddr = (unsigned char*)(addr + blockInfo.length - sizeof(BlockWriteInfo));
    data = DumpInfoAppendByte(writeInfoAddr, writeInfo);
    return data;
}

int32_t MsprofReportAdditionalInfoStub(uint32_t nonPersistantFlag, const VOID_PTR data, uint32_t length)
{
    MsprofAdditionalInfo* report_data = (MsprofAdditionalInfo*)data;
    EXPECT_EQ(report_data->level, MSPROF_REPORT_AIC_LEVEL);
    EXPECT_EQ(report_data->type, MSPROF_REPORT_AIC_TIMESTAMP_TYPE);
    MsprofAicTimeStampInfo* profTimestampData = reinterpret_cast<MsprofAicTimeStampInfo*>(report_data->data);
    EXPECT_EQ(profTimestampData->syscyc, 8662162037790U);
    EXPECT_EQ(profTimestampData->curPc, 20619064410912U);
    EXPECT_EQ(profTimestampData->descId, 10U);
    return 0;
}

extern int32_t cmodelDrvMemcpy_flag;
TEST_F(PrintfTest, TestParsePrintInfo)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    cmodelDrvMemcpy_flag = 1;
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    dev->simdEnable_ = true;
    error = dev->ParseSimdPrintInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    auto props = dev->GetDevProperties();
    const uint64_t totalCoreNum = static_cast<uint64_t>(props.aicNum + props.aivNum);
    const size_t blockSize = 1024 * 1024;
    const uint64_t totalLen = blockSize * totalCoreNum;
    std::vector<uint8_t> hostData(totalLen, 0);
    for (size_t i = 0U; i < totalCoreNum; i++) {
        uint8_t* blockAddr = hostData.data() + blockSize * i;
        BlockInfo* blockInfo = RtPtrToPtr<BlockInfo*>(blockAddr);
        blockInfo->length = blockSize;
        blockInfo->remainLen = blockSize - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo);
        blockInfo->rsv = 7;
        blockInfo->coreId = i;

        BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(blockAddr + sizeof(BlockInfo));
        readInfo->readIdx = blockInfo->remainLen - 8;

        BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(blockAddr + blockSize - sizeof(BlockWriteInfo));
        writeInfo->writeIdx = 0U;
    }

    error = ParsePrintf(hostData.data(), blockSize, dev->driver_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    cmodelDrvMemcpy_flag = 0;

    ut::ForceResetPrimaryDeviceIfActive();
}

TEST_F(PrintfTest, TestInitSimtPrintf)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    cmodelDrvMemcpy_flag = 1;
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    dev->simtEnable_ = true;
    error = dev->ParseSimtPrintInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    const size_t blockSize = 1024 * 1024;
    std::vector<uint8_t> deviceMemory(blockSize, 0);
    error = InitSimtPrintf(deviceMemory.data(), blockSize, dev->driver_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // Verify the initialized data
    BlockInfo* blockInfo = RtPtrToPtr<BlockInfo*>(deviceMemory.data());
    EXPECT_EQ(blockInfo->length, static_cast<uint32_t>(blockSize));
    EXPECT_EQ(blockInfo->magic, 0xAE86U);
    EXPECT_EQ(blockInfo->flag, PRINT_SIMT);

    BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(deviceMemory.data() + sizeof(BlockInfo));
    EXPECT_EQ(readInfo->dumpType, DumpType::DUMP_BUFO);
    EXPECT_EQ(readInfo->readIdx, 0U);

    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(deviceMemory.data() + blockSize - sizeof(BlockWriteInfo));
    EXPECT_EQ(writeInfo->dumpType, DumpType::DUMP_BUFI);
    EXPECT_EQ(writeInfo->writeIdx, readInfo->readIdx);

    error = ParseSimtPrintf(deviceMemory.data(), blockSize, dev->driver_, dev);
    EXPECT_EQ(error, RT_ERROR_NONE);
    cmodelDrvMemcpy_flag = 0;
    ut::ForceResetPrimaryDeviceIfActive();
}

// ===== AICPU printf UT =====

TEST_F(PrintfTest, TestInitAicpuPrintf_LayoutAndNullDriver)
{
    const size_t blockSize = 1024 * 1024;
    std::vector<uint8_t> deviceMemory(blockSize, 0);

    rtError_t error = InitAicpuPrintf(deviceMemory.data(), blockSize, nullptr);
    EXPECT_EQ(error, RT_ERROR_DRV_NULL);

    rtError_t rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);

    cmodelDrvMemcpy_flag = 1;
    error = InitAicpuPrintf(deviceMemory.data(), blockSize, dev->driver_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    BlockInfo* blockInfo = RtPtrToPtr<BlockInfo*>(deviceMemory.data());
    EXPECT_EQ(blockInfo->length, static_cast<uint32_t>(blockSize));
    EXPECT_EQ(blockInfo->coreId, 0U);
    EXPECT_EQ(blockInfo->blockNum, 1U);
    EXPECT_EQ(blockInfo->magic, 0xAE86U);
    EXPECT_EQ(blockInfo->flag, static_cast<uint16_t>(RT_KERNEL_DFX_INFO_CORE_TYPE_AICPU));

    BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(deviceMemory.data() + sizeof(BlockInfo));
    EXPECT_EQ(readInfo->dumpType, DumpType::DUMP_BUFO);
    EXPECT_EQ(readInfo->readIdx, 0U);

    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(deviceMemory.data() + blockSize - sizeof(BlockWriteInfo));
    EXPECT_EQ(writeInfo->dumpType, DumpType::DUMP_BUFI);
    EXPECT_EQ(writeInfo->writeIdx, 0U);
    EXPECT_EQ(writeInfo->packIdx, 0U);

    cmodelDrvMemcpy_flag = 0;
    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestReInitAicpuPrintfMem_AddrNull)
{
    rtError_t rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    RawDevice* dev = (RawDevice*)((Runtime*)Runtime::Instance())->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);

    dev->aicpuPrintfAddr_ = nullptr;
    rtError = dev->ReInitAicpuPrintfMem();
    EXPECT_EQ(rtError, RT_ERROR_INVALID_VALUE);

    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestReInitAicpuPrintfMem_Success)
{
    rtError_t rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    RawDevice* dev = (RawDevice*)((Runtime*)Runtime::Instance())->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);

    const uint32_t printfMemSize = 1024U * 1024U;
    static std::vector<uint8_t> printfMem(printfMemSize, 0);
    dev->aicpuPrintfAddr_ = printfMem.data();
    dev->aicpuPrintfMemSize_ = printfMemSize;
    dev->aicpuPrintTlvCnt_.Set(100U);

    cmodelDrvMemcpy_flag = 1;
    rtError = dev->ReInitAicpuPrintfMem();
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    EXPECT_EQ(dev->aicpuPrintTlvCnt_.Value(), 0U);

    cmodelDrvMemcpy_flag = 0;
    dev->aicpuPrintfAddr_ = nullptr;
    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestInitAicpuPrintInfo_FirstAllocAndSkip)
{
    rtError_t rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);

    cmodelDrvMemcpy_flag = 1;
    dev->aicpuPrintfAddr_ = nullptr;
    MOCKER_CPP(&Engine::CreatePrintfThread).stubs().will(returnValue(RT_ERROR_NONE));

    uint64_t addr = 0;
    rtError = dev->GetPrintFifoAddrAndCreateThread(&addr, PRINT_AICPU);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    EXPECT_NE(dev->aicpuPrintfAddr_, nullptr);

    void* firstAddr = dev->aicpuPrintfAddr_;
    GlobalMockObject::verify();
    MOCKER_CPP_VIRTUAL(dev, &RawDevice::InitAicpuPrintInfo).expects(never());
    rtError = dev->GetPrintFifoAddrAndCreateThread(&addr, PRINT_AICPU);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    EXPECT_EQ(dev->aicpuPrintfAddr_, firstAddr);

    GlobalMockObject::verify();
    cmodelDrvMemcpy_flag = 0;
    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestParseAicpuPrintInfo_NotInited)
{
    rtError_t rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);

    dev->aicpuDfxSent_ = false;
    dev->aicpuPrintfAddr_ = nullptr;

    cmodelDrvMemcpy_flag = 1;
    MOCKER(ParseAicpuPrintf).expects(never());
    rtError = dev->ParseAicpuPrintInfo();
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    GlobalMockObject::verify();
    cmodelDrvMemcpy_flag = 0;

    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestParseAicpuPrintInfo_V1Fallback)
{
    ASSERT_EQ(rtSetDevice(0), RT_ERROR_NONE);
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);

    dev->aicpuDfxSent_ = true;
    dev->aicpuPrintfAddr_ = RtValueToPtr<void*>(0x1000U);
    dev->aicpuPrintfMemSize_ = 1024U;
    (void)ParseKernelDfxInfo::Instance()->SetCallback(nullptr);
    MOCKER(ParseAicpuPrintf).expects(once()).will(returnValue(RT_ERROR_NONE));
    MOCKER(ParseAicpuPrintfV2).expects(never());

    EXPECT_EQ(dev->ParseAicpuPrintInfo(), RT_ERROR_NONE);

    dev->aicpuPrintfAddr_ = nullptr;
    dev->aicpuPrintfMemSize_ = 0U;
    dev->aicpuDfxSent_ = false;
    GlobalMockObject::verify();
    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestParseAicpuPrintInfo_V2Dispatch)
{
    ASSERT_EQ(rtSetDevice(0), RT_ERROR_NONE);
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);

    dev->aicpuDfxSent_ = true;
    dev->aicpuPrintfAddr_ = RtValueToPtr<void*>(0x1000U);
    dev->aicpuPrintfMemSize_ = 1024U;
    (void)ParseKernelDfxInfo::Instance()->SetCallback(EmptyParseDfxInfoCallback);
    MOCKER(ParseAicpuPrintf).expects(never());
    MOCKER(ParseAicpuPrintfV2).expects(once()).will(returnValue(RT_ERROR_NONE));

    EXPECT_EQ(dev->ParseAicpuPrintInfo(), RT_ERROR_NONE);

    (void)ParseKernelDfxInfo::Instance()->SetCallback(nullptr);
    dev->aicpuPrintfAddr_ = nullptr;
    dev->aicpuPrintfMemSize_ = 0U;
    dev->aicpuDfxSent_ = false;
    GlobalMockObject::verify();
    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestParseAicpuPrintf_NoDataAndWithData)
{
    rtError_t rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);

    const size_t blockSize = 1024 * 1024;
    std::vector<uint8_t> deviceMemory(blockSize, 0);
    cmodelDrvMemcpy_flag = 1;
    rtError = InitAicpuPrintf(deviceMemory.data(), blockSize, dev->driver_);
    EXPECT_EQ(rtError, RT_ERROR_NONE);

    dev->aicpuDfxSent_ = true;
    dev->aicpuPrintTlvCnt_.Set(0U);

    MOCKER_CPP(&KernelDfxInfo::ExecuteKernelDfxInfoFunc).expects(never());
    rtError = ParseAicpuPrintf(deviceMemory.data(), blockSize, dev->driver_, dev);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    GlobalMockObject::verify();

    uint8_t* blockAddr = deviceMemory.data();
    BlockInfo* blockInfo = RtPtrToPtr<BlockInfo*>(blockAddr);
    uint8_t* dumpStartAddr = blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo);

    DumpInfoHead aicpuHead = {};
    aicpuHead.type = DumpType::DUMP_AICPU;
    aicpuHead.infoLen = 17U;
    (void)memcpy_s(dumpStartAddr, sizeof(DumpInfoHead), &aicpuHead, sizeof(DumpInfoHead));
    constexpr uint64_t strOffset = 8U;
    (void)memcpy_s(
        dumpStartAddr + sizeof(DumpInfoHead) + SIMD_PRINT_RSV_LEN, sizeof(strOffset), &strOffset, sizeof(strOffset));

    DumpInfoHead tensorHead = {};
    tensorHead.type = DumpType::DUMP_TENSOR;
    tensorHead.infoLen = 8U;
    uint8_t* secondTlvAddr = dumpStartAddr + sizeof(DumpInfoHead) + aicpuHead.infoLen;
    (void)memcpy_s(secondTlvAddr, sizeof(DumpInfoHead), &tensorHead, sizeof(DumpInfoHead));

    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = sizeof(DumpInfoHead) + aicpuHead.infoLen;
    writeInfo->packIdx = 1U;

    MOCKER_CPP(&KernelDfxInfo::ExecuteKernelDfxInfoFunc).expects(exactly(1)).will(returnValue(RT_ERROR_NONE));
    rtError = ParseAicpuPrintf(deviceMemory.data(), blockSize, dev->driver_, dev);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    GlobalMockObject::verify();

    dev->aicpuDfxSent_ = false;
    dev->aicpuPrintTlvCnt_.Set(0U);
    cmodelDrvMemcpy_flag = 0;
    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestParseAicpuPrintf_FormattedStringWithPercent)
{
    rtError_t rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);

    const size_t blockSize = 1024 * 1024;
    std::vector<uint8_t> deviceMemory(blockSize, 0);
    cmodelDrvMemcpy_flag = 1;
    rtError = InitAicpuPrintf(deviceMemory.data(), blockSize, dev->driver_);
    EXPECT_EQ(rtError, RT_ERROR_NONE);

    uint8_t* blockAddr = deviceMemory.data();
    uint8_t* dumpStartAddr = blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo);
    DumpInfoHead* dumpHead = RtPtrToPtr<DumpInfoHead*>(dumpStartAddr);
    dumpHead->type = DumpType::DUMP_AICPU;

    constexpr uint64_t strOffset = 8U;
    constexpr size_t stringOffset = SIMD_PRINT_RSV_LEN + strOffset;
    const char* printInfo = "progress: 50% complete, text value=%d";
    (void)memcpy_s(dumpHead->infoMsg + SIMD_PRINT_RSV_LEN, sizeof(strOffset), &strOffset, sizeof(strOffset));
    (void)memcpy_s(dumpHead->infoMsg + stringOffset, strlen(printInfo) + 1U, printInfo, strlen(printInfo) + 1U);
    dumpHead->infoLen = static_cast<uint32_t>(stringOffset + strlen(printInfo) + 1U);

    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = sizeof(DumpInfoHead) + dumpHead->infoLen;
    writeInfo->packIdx = 1U;
    dev->aicpuDfxSent_ = true;
    dev->aicpuPrintTlvCnt_.Set(0U);

    testing::internal::CaptureStdout();
    rtError = ParseAicpuPrintf(deviceMemory.data(), blockSize, dev->driver_, dev);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    EXPECT_NE(output.find(printInfo), std::string::npos);

    dev->aicpuDfxSent_ = false;
    dev->aicpuPrintTlvCnt_.Set(0U);
    cmodelDrvMemcpy_flag = 0;
    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestParseAicpuPrintf_PackIdxHalfTlv)
{
    rtError_t rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);

    const size_t blockSize = 1024 * 1024;
    std::vector<uint8_t> deviceMemory(blockSize, 0);
    cmodelDrvMemcpy_flag = 1;
    rtError = InitAicpuPrintf(deviceMemory.data(), blockSize, dev->driver_);
    EXPECT_EQ(rtError, RT_ERROR_NONE);

    uint8_t* blockAddr = deviceMemory.data();
    BlockInfo* blockInfo = RtPtrToPtr<BlockInfo*>(blockAddr);
    uint8_t* dumpStartAddr = blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo);

    DumpInfoHead dumpHead = {};
    dumpHead.type = DumpType::DUMP_AICPU;
    dumpHead.infoLen = 16U;
    (void)memcpy_s(dumpStartAddr, sizeof(DumpInfoHead), &dumpHead, sizeof(DumpInfoHead));

    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = sizeof(DumpInfoHead) + dumpHead.infoLen;
    writeInfo->packIdx = 0U;

    dev->aicpuDfxSent_ = true;
    dev->aicpuPrintTlvCnt_.Set(0U);

    MOCKER_CPP(&KernelDfxInfo::ExecuteKernelDfxInfoFunc).expects(never());
    rtError = ParseAicpuPrintf(deviceMemory.data(), blockSize, dev->driver_, dev);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    GlobalMockObject::verify();

    BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(blockAddr + sizeof(BlockInfo));
    EXPECT_EQ(readInfo->readIdx, 0U);

    dev->aicpuDfxSent_ = false;
    dev->aicpuPrintTlvCnt_.Set(0U);
    cmodelDrvMemcpy_flag = 0;
    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestParseAicpuPrintf_TruncatedDumpInfo)
{
    rtError_t rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);

    const size_t blockSize = 1024 * 1024;
    std::vector<uint8_t> deviceMemory(blockSize, 0);
    cmodelDrvMemcpy_flag = 1;
    rtError = InitAicpuPrintf(deviceMemory.data(), blockSize, dev->driver_);
    EXPECT_EQ(rtError, RT_ERROR_NONE);

    uint8_t* blockAddr = deviceMemory.data();
    uint8_t* dumpStartAddr = blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo);
    BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(blockAddr + sizeof(BlockInfo));
    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->packIdx = 1U;
    dev->aicpuDfxSent_ = true;
    dev->aicpuPrintTlvCnt_.Set(0U);

    DumpInfoHead dumpHead = {};
    dumpHead.type = DumpType::DUMP_AICPU;
    dumpHead.infoLen = 16U;
    (void)memcpy_s(dumpStartAddr, sizeof(DumpInfoHead), &dumpHead, sizeof(DumpInfoHead));

    MOCKER_CPP(&KernelDfxInfo::ExecuteKernelDfxInfoFunc).expects(never());
    writeInfo->writeIdx = sizeof(DumpInfoHead) - 1U;
    rtError = ParseAicpuPrintf(deviceMemory.data(), blockSize, dev->driver_, dev);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    EXPECT_EQ(readInfo->readIdx, 0U);
    EXPECT_EQ(dev->GetAicpuPrintTlvCnt(), 0U);

    writeInfo->writeIdx = sizeof(DumpInfoHead) + dumpHead.infoLen - 1U;
    rtError = ParseAicpuPrintf(deviceMemory.data(), blockSize, dev->driver_, dev);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    EXPECT_EQ(readInfo->readIdx, 0U);
    EXPECT_EQ(dev->GetAicpuPrintTlvCnt(), 0U);
    GlobalMockObject::verify();

    dev->aicpuDfxSent_ = false;
    dev->aicpuPrintTlvCnt_.Set(0U);
    cmodelDrvMemcpy_flag = 0;
    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestParseAicpuPrintf_NonAicpuTypeSkip)
{
    rtError_t rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);

    const size_t blockSize = 1024 * 1024;
    std::vector<uint8_t> deviceMemory(blockSize, 0);
    cmodelDrvMemcpy_flag = 1;
    rtError = InitAicpuPrintf(deviceMemory.data(), blockSize, dev->driver_);
    EXPECT_EQ(rtError, RT_ERROR_NONE);

    uint8_t* blockAddr = deviceMemory.data();
    uint8_t* dumpStartAddr = blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo);

    DumpInfoHead dumpHead = {};
    dumpHead.type = DumpType::DUMP_TENSOR;
    dumpHead.infoLen = 16U;
    (void)memcpy_s(dumpStartAddr, sizeof(DumpInfoHead), &dumpHead, sizeof(DumpInfoHead));

    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = sizeof(DumpInfoHead) + dumpHead.infoLen;
    writeInfo->packIdx = 1U;

    dev->aicpuDfxSent_ = true;
    dev->aicpuPrintTlvCnt_.Set(0U);

    MOCKER_CPP(&KernelDfxInfo::ExecuteKernelDfxInfoFunc).expects(never());
    rtError = ParseAicpuPrintf(deviceMemory.data(), blockSize, dev->driver_, dev);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    GlobalMockObject::verify();

    BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(blockAddr + sizeof(BlockInfo));
    EXPECT_EQ(readInfo->readIdx, 0U);

    dev->aicpuDfxSent_ = false;
    dev->aicpuPrintTlvCnt_.Set(0U);
    cmodelDrvMemcpy_flag = 0;
    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestParseAicpuPrintf_Wraparound)
{
    rtError_t rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);

    const size_t blockSize = 1024 * 1024;
    std::vector<uint8_t> deviceMemory(blockSize, 0);
    cmodelDrvMemcpy_flag = 1;
    rtError = InitAicpuPrintf(deviceMemory.data(), blockSize, dev->driver_);
    EXPECT_EQ(rtError, RT_ERROR_NONE);

    uint8_t* blockAddr = deviceMemory.data();
    BlockInfo* blockInfo = RtPtrToPtr<BlockInfo*>(blockAddr);
    uint8_t* dumpStartAddr = blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo);

    constexpr uint64_t strOffset = 8U;
    const uint64_t tlvLen = sizeof(DumpInfoHead) + SIMD_PRINT_RSV_LEN + sizeof(strOffset) + 1U;
    const uint64_t nearEnd = blockInfo->remainLen - 8U;

    DumpInfoHead dumpHead = {};
    dumpHead.type = DumpType::DUMP_AICPU;
    dumpHead.infoLen = SIMD_PRINT_RSV_LEN + sizeof(strOffset) + 1U;
    (void)memcpy_s(dumpStartAddr + nearEnd, sizeof(DumpInfoHead), &dumpHead, sizeof(DumpInfoHead));
    (void)memcpy_s(dumpStartAddr + SIMD_PRINT_RSV_LEN, sizeof(strOffset), &strOffset, sizeof(strOffset));

    BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(blockAddr + sizeof(BlockInfo));
    readInfo->readIdx = nearEnd;

    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = nearEnd + tlvLen;
    writeInfo->packIdx = 1U;

    dev->aicpuDfxSent_ = true;
    dev->aicpuPrintTlvCnt_.Set(0U);

    MOCKER_CPP(&KernelDfxInfo::ExecuteKernelDfxInfoFunc).expects(exactly(1)).will(returnValue(RT_ERROR_NONE));
    rtError = ParseAicpuPrintf(deviceMemory.data(), blockSize, dev->driver_, dev);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    EXPECT_EQ(readInfo->readIdx, writeInfo->writeIdx);
    GlobalMockObject::verify();

    dev->aicpuDfxSent_ = false;
    dev->aicpuPrintTlvCnt_.Set(0U);
    cmodelDrvMemcpy_flag = 0;
    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestParseAicpuPrintf_DataOverflow)
{
    rtError_t rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);

    const size_t blockSize = 1024 * 1024;
    std::vector<uint8_t> deviceMemory(blockSize, 0);
    cmodelDrvMemcpy_flag = 1;
    rtError = InitAicpuPrintf(deviceMemory.data(), blockSize, dev->driver_);
    EXPECT_EQ(rtError, RT_ERROR_NONE);

    uint8_t* blockAddr = deviceMemory.data();
    BlockInfo* blockInfo = RtPtrToPtr<BlockInfo*>(blockAddr);
    uint8_t* dumpStartAddr = blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo);

    DumpInfoHead dumpHead = {};
    dumpHead.type = DumpType::DUMP_AICPU;
    constexpr uint64_t strOffset = 8U;
    dumpHead.infoLen = SIMD_PRINT_RSV_LEN + sizeof(strOffset) + 1U;
    const uint64_t dumpInfoLen = sizeof(DumpInfoHead) + dumpHead.infoLen;
    for (uint64_t off = 0U; off < 100U * dumpInfoLen; off += dumpInfoLen) {
        (void)memcpy_s(dumpStartAddr + off, sizeof(DumpInfoHead), &dumpHead, sizeof(DumpInfoHead));
        (void)memcpy_s(
            dumpStartAddr + off + sizeof(DumpInfoHead) + SIMD_PRINT_RSV_LEN, sizeof(strOffset), &strOffset,
            sizeof(strOffset));
    }

    BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(blockAddr + sizeof(BlockInfo));
    readInfo->readIdx = 0U;

    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = blockInfo->remainLen + 100U;
    writeInfo->packIdx = 100U;

    dev->aicpuDfxSent_ = true;
    dev->aicpuPrintTlvCnt_.Set(0U);

    MOCKER_CPP(&KernelDfxInfo::ExecuteKernelDfxInfoFunc).stubs().will(returnValue(RT_ERROR_NONE));
    rtError = ParseAicpuPrintf(deviceMemory.data(), blockSize, dev->driver_, dev);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    EXPECT_EQ(readInfo->readIdx, writeInfo->writeIdx);
    EXPECT_EQ(dev->GetAicpuPrintTlvCnt(), writeInfo->packIdx);
    GlobalMockObject::verify();

    readInfo->readIdx = 50U;
    writeInfo->writeIdx = blockInfo->remainLen + 200U;
    writeInfo->packIdx = 200U;
    dev->aicpuPrintTlvCnt_.Set(200U);

    DumpInfoHead invalidHead = {};
    invalidHead.type = DumpType::DUMP_TENSOR;
    invalidHead.infoLen = 8U;
    (void)memset_s(dumpStartAddr, blockInfo->remainLen, 0, blockInfo->remainLen);
    (void)memcpy_s(dumpStartAddr + 50U, sizeof(DumpInfoHead), &invalidHead, sizeof(DumpInfoHead));

    rtError = ParseAicpuPrintf(deviceMemory.data(), blockSize, dev->driver_, dev);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    EXPECT_EQ(readInfo->readIdx, writeInfo->writeIdx);

    dev->aicpuDfxSent_ = false;
    dev->aicpuPrintTlvCnt_.Set(0U);
    cmodelDrvMemcpy_flag = 0;
    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestReleaseAicpuPrintfMem)
{
    rtError_t rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);

    cmodelDrvMemcpy_flag = 1;
    uint64_t addr = 0;
    rtError = dev->GetPrintFifoAddrAndCreateThread(&addr, PRINT_AICPU);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    EXPECT_NE(dev->aicpuPrintfAddr_, nullptr);
    dev->aicpuPrintTlvCnt_.Set(10U);
    cmodelDrvMemcpy_flag = 0;

    rtDeviceReset(0);

    rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    dev = (RawDevice*)((Runtime*)Runtime::Instance())->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);
    EXPECT_EQ(dev->aicpuPrintfAddr_, nullptr);
    EXPECT_EQ(dev->aicpuPrintTlvCnt_.Value(), 0U);
    rtDeviceReset(0);
}

// ===== Phase 1: CheckAicpuDfxSupport mock UT =====

TEST_F(PrintfTest, TestCheckAicpuDfxSupport_FlowAndFail)
{
    rtError_t rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);
    dev->aicpuDfxSupport_ = false;

    cmodelDrvMemcpy_flag = 1;
    MOCKER(StreamLaunchCpuKernel).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->primaryStream_, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    rtError = dev->CheckAicpuDfxSupport();
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    EXPECT_EQ(dev->aicpuDfxSupport_, false);
    GlobalMockObject::verify();

    MOCKER(StreamLaunchCpuKernel).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    rtError = dev->CheckAicpuDfxSupport();
    EXPECT_NE(rtError, RT_ERROR_NONE);
    EXPECT_EQ(dev->aicpuDfxSupport_, false);
    GlobalMockObject::verify();

    MOCKER(StreamLaunchCpuKernel).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->primaryStream_, &Stream::Synchronize)
        .stubs()
        .will(returnValue(RT_ERROR_STREAM_SYNC_TIMEOUT));
    rtError = dev->CheckAicpuDfxSupport();
    EXPECT_NE(rtError, RT_ERROR_NONE);
    EXPECT_EQ(dev->aicpuDfxSupport_, false);
    GlobalMockObject::verify();

    cmodelDrvMemcpy_flag = 0;
    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestCheckAicpuDfxSupport_DfxSupported)
{
    rtError_t rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);
    dev->aicpuDfxSupport_ = false;

    cmodelDrvMemcpy_flag = 1;
    int32_t checkResult = 0;
    void* checkResultPtr = &checkResult;
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAlloc)
        .stubs()
        .with(
            outBoundP(&checkResultPtr, sizeof(checkResultPtr)), mockcpp::any(), mockcpp::any(), mockcpp::any(),
            mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemFree).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(StreamLaunchCpuKernel).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->primaryStream_, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::MemCopySync)
        .stubs()
        .with(
            outBoundP(checkResultPtr, sizeof(checkResult)), mockcpp::any(), mockcpp::any(), mockcpp::any(),
            eq(RT_MEMCPY_DEVICE_TO_HOST), mockcpp::any())
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));
    rtError = dev->CheckAicpuDfxSupport();
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    EXPECT_EQ(dev->aicpuDfxSupport_, true);
    GlobalMockObject::verify();

    cmodelDrvMemcpy_flag = 0;
    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestCheckAicpuDfxSupport_MemCopyFail)
{
    rtError_t rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);
    dev->aicpuDfxSupport_ = false;

    cmodelDrvMemcpy_flag = 0;
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemFree).stubs().will(returnValue(RT_ERROR_NONE));

    rtError = dev->CheckAicpuDfxSupport();
    EXPECT_NE(rtError, RT_ERROR_NONE);
    EXPECT_EQ(dev->aicpuDfxSupport_, false);
    GlobalMockObject::verify();

    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::MemCopySync)
        .stubs()
        .will(returnValue(RT_ERROR_NONE))
        .then(returnValue(RT_ERROR_NONE))
        .then(returnValue(RT_ERROR_INVALID_VALUE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemFree).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(StreamLaunchCpuKernel).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->primaryStream_, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));

    rtError = dev->CheckAicpuDfxSupport();
    EXPECT_NE(rtError, RT_ERROR_NONE);
    EXPECT_EQ(dev->aicpuDfxSupport_, false);
    GlobalMockObject::verify();

    cmodelDrvMemcpy_flag = 1;
    rtDeviceReset(0);
}

// ===== Phase 3: InitAicpuPrintInfo mock UT =====

TEST_F(PrintfTest, TestInitAicpuPrintInfo_FailAndRetry)
{
    rtError_t rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);

    dev->aicpuPrintfAddr_ = nullptr;
    uint64_t addr = 0;

    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_DRV_ERR));
    rtError = dev->GetPrintFifoAddrAndCreateThread(&addr, PRINT_AICPU);
    EXPECT_NE(rtError, RT_ERROR_NONE);
    EXPECT_EQ(dev->aicpuPrintfAddr_, nullptr);
    GlobalMockObject::verify();

    cmodelDrvMemcpy_flag = 1;
    MOCKER_CPP(&Engine::CreatePrintfThread).stubs().will(returnValue(RT_ERROR_ENGINE_THREAD));
    rtError = dev->GetPrintFifoAddrAndCreateThread(&addr, PRINT_AICPU);
    EXPECT_NE(rtError, RT_ERROR_NONE);
    EXPECT_NE(dev->aicpuPrintfAddr_, nullptr);
    GlobalMockObject::verify();

    MOCKER_CPP(&Engine::CreatePrintfThread).stubs().will(returnValue(RT_ERROR_NONE));
    rtError = dev->GetPrintFifoAddrAndCreateThread(&addr, PRINT_AICPU);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    EXPECT_NE(dev->aicpuPrintfAddr_, nullptr);
    EXPECT_EQ(addr, RtPtrToValue(dev->aicpuPrintfAddr_));
    GlobalMockObject::verify();

    cmodelDrvMemcpy_flag = 0;
    rtDeviceReset(0);
}

// ===== Phase 3: ProcAicpuPrintfDfx indirect coverage via ProcCpuKernelH2DMem =====

static void SetupProcCpuKernelH2DMemCommonMocks(RawDevice* dev)
{
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAlloc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Runtime::StartAicpuSd).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(LaunchAicpuKernelForCpuSo).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&StreamFactory::CreateStream).stubs().will(returnValue(dev->primaryStream_));
    MOCKER_CPP_VIRTUAL(dev->primaryStream_, &Stream::Setup).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->primaryStream_, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_NONE));
    cmodelDrvMemcpy_flag = 1;
}

static void SetupProcCpuKernelH2DMemMocks(RawDevice* dev)
{
    SetupProcCpuKernelH2DMemCommonMocks(dev);
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemFree).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->primaryStream_, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
}

static PlainProgram* CreateAicpuPrintfProgram(RawDevice* dev)
{
    uint8_t data[] = {0x01, 0x02, 0x03, 0x04};
    BinaryLoader loader(data, sizeof(data), nullptr);
    PlainProgram* prog = loader.LoadCpuKernelFromData();
    if (prog != nullptr) {
        prog->SetHasPrintfTlv(true);
        prog->SetKernelRegType(RT_KERNEL_REG_TYPE_CPU);
        prog->cpuRegMode_ = 2;
    }
    dev->aicpuDfxSupport_ = true;
    dev->aicpuDfxSent_ = false;
    dev->aicpuPrintfAddr_ = nullptr;
    return prog;
}

static std::atomic<bool> g_aicpuPrintfThreadCreateCalled{false};

static rtError_t CreateAicpuPrintfThreadStub()
{
    g_aicpuPrintfThreadCreateCalled.store(true);
    return RT_ERROR_NONE;
}

TEST_F(PrintfTest, InitPrintInfoDevMemAllocUsesRuntimeModuleId)
{
    EXPECT_EQ(rtSetDevice(0), RT_ERROR_NONE);
    RawDevice* dev = (RawDevice*)((Runtime*)Runtime::Instance())->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);

    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAlloc)
        .expects(once())
        .with(
            mockcpp::any(), mockcpp::any(), eq(RT_MEMORY_HBM), eq(dev->deviceId_),
            eq(static_cast<uint16_t>(MODULEID_RUNTIME)))
        .will(returnValue(RT_ERROR_DRV_ERR));

    EXPECT_EQ(dev->InitPrintInfo(), RT_ERROR_DRV_ERR);
    GlobalMockObject::verify();
    rtDeviceReset(0);
}

TEST_F(PrintfTest, InitSimtPrintInfoDevMemAllocUsesRuntimeModuleId)
{
    EXPECT_EQ(rtSetDevice(0), RT_ERROR_NONE);
    RawDevice* dev = (RawDevice*)((Runtime*)Runtime::Instance())->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);

    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAlloc)
        .expects(once())
        .with(
            mockcpp::any(), mockcpp::any(), eq(RT_MEMORY_HBM), eq(dev->deviceId_),
            eq(static_cast<uint16_t>(MODULEID_RUNTIME)))
        .will(returnValue(RT_ERROR_DRV_ERR));

    EXPECT_EQ(dev->InitSimtPrintInfo(), RT_ERROR_DRV_ERR);
    GlobalMockObject::verify();
    rtDeviceReset(0);
}

TEST_F(PrintfTest, ProcCpuKernelH2DMemDevMemAllocUsesRuntimeModuleId)
{
    EXPECT_EQ(rtSetDevice(0), RT_ERROR_NONE);
    RawDevice* dev = (RawDevice*)((Runtime*)Runtime::Instance())->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);

    PlainProgram* prog = CreateAicpuPrintfProgram(dev);
    ASSERT_NE(prog, nullptr);
    prog->SetHasPrintfTlv(false);
    dev->aicpuDfxSupport_ = false;

    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAlloc)
        .expects(exactly(3))
        .with(
            mockcpp::any(), mockcpp::any(), eq(RT_MEMORY_HBM), eq(static_cast<uint32_t>(dev->Id_())),
            eq(static_cast<uint16_t>(MODULEID_RUNTIME)))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemFree).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Runtime::StartAicpuSd).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(LaunchAicpuKernelForCpuSo).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&StreamFactory::CreateStream).stubs().will(returnValue(dev->primaryStream_));
    MOCKER_CPP_VIRTUAL(dev->primaryStream_, &Stream::Setup).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->primaryStream_, &Stream::TearDown).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->primaryStream_, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));

    const rtError_t rtError = prog->ProcCpuKernelH2DMem(true, dev);
    EXPECT_EQ(rtError, RT_ERROR_NONE);

    GlobalMockObject::verify();
    delete prog;
    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestProcAicpuPrintfDfx_SuccessAndSkip)
{
    rtError_t rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    RawDevice* dev = (RawDevice*)((Runtime*)Runtime::Instance())->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);

    PlainProgram* prog = CreateAicpuPrintfProgram(dev);
    ASSERT_NE(prog, nullptr);

    constexpr size_t printfMemSize = 1024U * 1024U;
    static std::vector<uint8_t> printfMem(printfMemSize, 0);
    dev->aicpuPrintfAddr_ = printfMem.data();
    dev->aicpuPrintfMemSize_ = static_cast<uint32_t>(printfMemSize);

    SetupProcCpuKernelH2DMemMocks(dev);
    MOCKER_CPP(&Engine::CreatePrintfThread).expects(exactly(1)).will(returnValue(RT_ERROR_NONE));

    rtError = prog->ProcCpuKernelH2DMem(true, dev);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    EXPECT_EQ(dev->aicpuDfxSent_, true);

    rtError = prog->ProcCpuKernelH2DMem(true, dev);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    EXPECT_EQ(dev->aicpuDfxSent_, true);

    GlobalMockObject::verify();
    cmodelDrvMemcpy_flag = 0;
    dev->aicpuDfxSent_ = false;
    dev->aicpuPrintfAddr_ = nullptr;
    delete prog;
    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestProcAicpuPrintfDfx_DeviceLockPreventsDuplicateSend)
{
    rtError_t rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    RawDevice* dev = (RawDevice*)((Runtime*)Runtime::Instance())->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);

    PlainProgram* prog = CreateAicpuPrintfProgram(dev);
    ASSERT_NE(prog, nullptr);

    constexpr size_t printfMemSize = 1024U * 1024U;
    static std::vector<uint8_t> printfMem(printfMemSize, 0);
    dev->aicpuPrintfAddr_ = printfMem.data();
    dev->aicpuPrintfMemSize_ = static_cast<uint32_t>(printfMemSize);

    SetupProcCpuKernelH2DMemMocks(dev);
    g_aicpuPrintfThreadCreateCalled.store(false);
    MOCKER_CPP(&Engine::CreatePrintfThread).stubs().will(invoke(CreateAicpuPrintfThreadStub));
    MOCKER(StreamLaunchCpuKernel).expects(never());

    std::unique_lock<std::mutex> lock(dev->aicpuDfxInitMutex_);
    auto result = std::async(std::launch::async, [prog, dev]() { return prog->ProcCpuKernelH2DMem(true, dev); });
    while (!g_aicpuPrintfThreadCreateCalled.load()) {
        std::this_thread::yield();
    }
    EXPECT_EQ(result.wait_for(std::chrono::milliseconds(10)), std::future_status::timeout);

    dev->aicpuDfxSent_.store(true);
    lock.unlock();
    EXPECT_EQ(result.get(), RT_ERROR_NONE);

    GlobalMockObject::verify();
    cmodelDrvMemcpy_flag = 0;
    dev->aicpuDfxSent_.store(false);
    dev->aicpuPrintfAddr_ = nullptr;
    delete prog;
    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestProcAicpuPrintfDfx_FailPaths)
{
    rtError_t rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    RawDevice* dev = (RawDevice*)((Runtime*)Runtime::Instance())->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);

    PlainProgram* prog = CreateAicpuPrintfProgram(dev);
    ASSERT_NE(prog, nullptr);

    SetupProcCpuKernelH2DMemMocks(dev);
    MOCKER_CPP(&Engine::CreatePrintfThread).stubs().will(returnValue(RT_ERROR_ENGINE_THREAD));
    rtError = prog->ProcCpuKernelH2DMem(true, dev);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    EXPECT_EQ(dev->aicpuDfxSent_, false);

    GlobalMockObject::verify();
    cmodelDrvMemcpy_flag = 0;
    dev->aicpuDfxSent_ = false;
    delete prog;
    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestProcAicpuPrintfDfx_LaunchCpuKernelFail)
{
    rtError_t rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    RawDevice* dev = (RawDevice*)((Runtime*)Runtime::Instance())->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);

    PlainProgram* prog = CreateAicpuPrintfProgram(dev);
    ASSERT_NE(prog, nullptr);

    SetupProcCpuKernelH2DMemMocks(dev);
    MOCKER_CPP(&Engine::CreatePrintfThread).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(StreamLaunchCpuKernel).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));
    rtError = prog->ProcCpuKernelH2DMem(true, dev);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    EXPECT_EQ(dev->aicpuDfxSent_, false);

    GlobalMockObject::verify();
    cmodelDrvMemcpy_flag = 0;
    dev->aicpuDfxSent_ = false;
    delete prog;
    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestProcAicpuPrintfDfx_StreamSyncTimeout)
{
    rtError_t rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    RawDevice* dev = (RawDevice*)((Runtime*)Runtime::Instance())->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);

    PlainProgram* prog = CreateAicpuPrintfProgram(dev);
    ASSERT_NE(prog, nullptr);

    SetupProcCpuKernelH2DMemCommonMocks(dev);
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->primaryStream_, &Stream::Synchronize)
        .stubs()
        .will(returnValue(RT_ERROR_NONE))
        .then(returnValue(RT_ERROR_STREAM_SYNC_TIMEOUT));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemFree).expects(exactly(5)).will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Engine::CreatePrintfThread).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(StreamLaunchCpuKernel).stubs().will(returnValue(RT_ERROR_NONE));
    rtError = prog->ProcCpuKernelH2DMem(true, dev);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    EXPECT_EQ(dev->aicpuDfxSent_, false);

    GlobalMockObject::verify();
    cmodelDrvMemcpy_flag = 0;
    dev->aicpuDfxSent_ = false;
    delete prog;
    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestProcAicpuPrintfDfx_MemCopyFail)
{
    rtError_t rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    RawDevice* dev = (RawDevice*)((Runtime*)Runtime::Instance())->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);

    PlainProgram* prog = CreateAicpuPrintfProgram(dev);
    ASSERT_NE(prog, nullptr);

    SetupProcCpuKernelH2DMemCommonMocks(dev);
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::MemCopySync)
        .stubs()
        .will(returnValue(RT_ERROR_NONE))
        .then(returnValue(RT_ERROR_NONE))
        .then(returnValue(RT_ERROR_NONE))
        .then(returnValue(RT_ERROR_NONE))
        .then(returnValue(RT_ERROR_NONE))
        .then(returnValue(RT_ERROR_INVALID_VALUE));
    MOCKER_CPP_VIRTUAL(dev->primaryStream_, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemFree).expects(exactly(5)).will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Engine::CreatePrintfThread).stubs().will(returnValue(RT_ERROR_NONE));
    rtError = prog->ProcCpuKernelH2DMem(true, dev);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    EXPECT_EQ(dev->aicpuDfxSent_, false);

    GlobalMockObject::verify();
    cmodelDrvMemcpy_flag = 0;
    dev->aicpuDfxSent_ = false;
    delete prog;
    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestParsePrintInfo_AicpuErrorNotAbort)
{
    rtError_t rtError = rtSetDevice(0);
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    RawDevice* dev = (RawDevice*)((Runtime*)Runtime::Instance())->GetDevice(0U, 0U);
    ASSERT_NE(dev, nullptr);

    dev->aicpuDfxSent_ = true;
    dev->aicpuPrintfAddr_ = reinterpret_cast<void*>(0x1000);
    uint64_t counterBefore = dev->parseCounter_.load();

    cmodelDrvMemcpy_flag = 0;
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_INVALID_VALUE));

    rtError = dev->ParsePrintInfo();
    EXPECT_EQ(rtError, RT_ERROR_NONE);
    EXPECT_EQ(dev->parseCounter_.load(), counterBefore + 1U);

    GlobalMockObject::verify();
    dev->aicpuDfxSent_ = false;
    dev->aicpuPrintfAddr_ = nullptr;
    cmodelDrvMemcpy_flag = 1;
    rtDeviceReset(0);
}

void FillNoParamDumpInfo(DumpInfoHead* noParamDumpInfo, DumpType type, const uint32_t rsvLen)
{
    noParamDumpInfo->type = type;
    uint64_t offset = 8;
    uint32_t curIdx = rsvLen;
    (void)memcpy_s(noParamDumpInfo->infoMsg + curIdx, sizeof(offset), &offset, sizeof(offset));
    curIdx += sizeof(offset);
    const char* printInfo = "No param print.";
    (void)memcpy_s(noParamDumpInfo->infoMsg + curIdx, strlen(printInfo) + 1, printInfo, strlen(printInfo) + 1);
    curIdx += (strlen(printInfo) + 1);
    noParamDumpInfo->infoLen = curIdx;
}

void FillInvalidParamDumpInfo(DumpInfoHead* invalidParamDumpInfo, DumpType type, const uint32_t rsvLen)
{
    invalidParamDumpInfo->type = type;
    uint64_t offset = 8;
    uint32_t curIdx = rsvLen;
    (void)memcpy_s(invalidParamDumpInfo->infoMsg + curIdx, sizeof(offset), &offset, sizeof(offset));
    curIdx += sizeof(offset);
    const char* printInfo = "Invalid param %a.";
    (void)memcpy_s(invalidParamDumpInfo->infoMsg + curIdx, strlen(printInfo) + 1, printInfo, strlen(printInfo) + 1);
    curIdx += (strlen(printInfo) + 1);
    invalidParamDumpInfo->infoLen = curIdx;
}

void FillRedundantParamDumpInfo(DumpInfoHead* redundantParamDumpInfo, DumpType type, const uint32_t rsvLen)
{
    redundantParamDumpInfo->type = type;
    uint64_t offset = 8;
    uint32_t curIdx = rsvLen;
    (void)memcpy_s(redundantParamDumpInfo->infoMsg + curIdx, sizeof(offset), &offset, sizeof(offset));
    curIdx += sizeof(offset);
    const char* printInfo = "Redundant param %d.";
    (void)memcpy_s(redundantParamDumpInfo->infoMsg + curIdx, strlen(printInfo) + 1, printInfo, strlen(printInfo) + 1);
    curIdx += (strlen(printInfo) + 1);
    redundantParamDumpInfo->infoLen = curIdx;
}

void FillPrintDumpInfo(DumpInfoHead* paramPrint, DumpType type, const uint32_t rsvLen)
{
    paramPrint->type = type;
    uint64_t offset = 64;
    uint32_t curIdx = rsvLen;
    (void)memcpy_s(paramPrint->infoMsg + curIdx, sizeof(offset), &offset, sizeof(offset));
    curIdx += sizeof(offset);

    int64_t dNum = -1;
    (void)memcpy_s(paramPrint->infoMsg + curIdx, PARAM_VALUE_LEN, &dNum, PARAM_VALUE_LEN);
    curIdx += PARAM_VALUE_LEN;
    int64_t ldNum = -2;
    (void)memcpy_s(paramPrint->infoMsg + curIdx, PARAM_VALUE_LEN, &ldNum, PARAM_VALUE_LEN);
    curIdx += PARAM_VALUE_LEN;
    int64_t lldNum = -3;
    (void)memcpy_s(paramPrint->infoMsg + curIdx, PARAM_VALUE_LEN, &lldNum, PARAM_VALUE_LEN);
    curIdx += PARAM_VALUE_LEN;

    int64_t iNum = 0;
    (void)memcpy_s(paramPrint->infoMsg + curIdx, PARAM_VALUE_LEN, &iNum, PARAM_VALUE_LEN);
    curIdx += PARAM_VALUE_LEN;

    uint64_t uNum = 1;
    (void)memcpy_s(paramPrint->infoMsg + curIdx, PARAM_VALUE_LEN, &uNum, PARAM_VALUE_LEN);
    curIdx += PARAM_VALUE_LEN;

    int64_t xNum = 253;
    (void)memcpy_s(paramPrint->infoMsg + curIdx, PARAM_VALUE_LEN, &xNum, PARAM_VALUE_LEN);
    curIdx += PARAM_VALUE_LEN;
    int64_t xUpperNum = 254;
    (void)memcpy_s(paramPrint->infoMsg + curIdx, PARAM_VALUE_LEN, &xUpperNum, PARAM_VALUE_LEN);
    curIdx += PARAM_VALUE_LEN;

    const char* printInfo = "Test the format: d[%d], ld[%ld], lld[%lld], i[%i], u[%u], x[%x], X[%X]";
    (void)memcpy_s(paramPrint->infoMsg + curIdx, strlen(printInfo) + 1, printInfo, strlen(printInfo) + 1);
    curIdx += (strlen(printInfo) + 1);
    paramPrint->infoLen = curIdx;
}

// 绕接 circular buffer
void FillPrintDumpInfoForSimtCircular(DumpInfoHead* paramPrint, uint8_t* dumpStartAddr)
{
    paramPrint->type = DumpType::DUMP_SIMT_PRINTF;
    uint64_t offset = 64;
    uint32_t curIdx = 40;
    (void)memcpy_s(paramPrint->infoMsg + curIdx, sizeof(offset), &offset, sizeof(offset));
    curIdx += sizeof(offset);

    int64_t dNum = -1;
    (void)memcpy_s(paramPrint->infoMsg + curIdx, PARAM_VALUE_LEN, &dNum, PARAM_VALUE_LEN);
    curIdx += PARAM_VALUE_LEN;
    int64_t ldNum = -2;
    (void)memcpy_s(paramPrint->infoMsg + curIdx, PARAM_VALUE_LEN, &ldNum, PARAM_VALUE_LEN);
    curIdx += PARAM_VALUE_LEN;
    int64_t lldNum = -3;
    (void)memcpy_s(paramPrint->infoMsg + curIdx, PARAM_VALUE_LEN, &lldNum, PARAM_VALUE_LEN);
    curIdx += PARAM_VALUE_LEN;

    int64_t iNum = 0;
    (void)memcpy_s(paramPrint->infoMsg + curIdx, PARAM_VALUE_LEN, &iNum, PARAM_VALUE_LEN);
    curIdx += PARAM_VALUE_LEN;

    uint64_t uNum = 1;
    (void)memcpy_s(paramPrint->infoMsg + curIdx, PARAM_VALUE_LEN, &uNum, PARAM_VALUE_LEN);
    curIdx += PARAM_VALUE_LEN;

    int64_t xNum = 253;
    (void)memcpy_s(paramPrint->infoMsg + curIdx, PARAM_VALUE_LEN, &xNum, PARAM_VALUE_LEN);
    curIdx += PARAM_VALUE_LEN;
    int64_t xUpperNum = 254;
    (void)memcpy_s(paramPrint->infoMsg + curIdx, PARAM_VALUE_LEN, &xUpperNum, PARAM_VALUE_LEN);
    curIdx += PARAM_VALUE_LEN;

    const char* printInfo0 = "Test circular buffer the format: the length of the string is 66B: "; // 至此填充到尾部
    (void)memcpy_s(paramPrint->infoMsg + curIdx, strlen(printInfo0), printInfo0, strlen(printInfo0)); // 不要尾部\0
    // 绕接的部分
    const char* printInfo1 = "d[%d], ld[%ld], lld[%lld], i[%i], u[%u], x[%x], X[%X]";
    (void)memcpy_s(dumpStartAddr, strlen(printInfo1) + 1, printInfo1, strlen(printInfo1) + 1);
    curIdx += (strlen(printInfo0) + strlen(printInfo1) + 1);
    paramPrint->infoLen = curIdx;
}

void FillAssertDumpInfo(DumpInfoHead* assertInfo, DumpType type, const uint32_t rsvLen)
{
    assertInfo->type = type;
    const char* printInfo = "Test the format: %%[%%], f[%f], F[%F], p[%p], s[%s]";
    uint64_t offset = 40;
    uint32_t curIdx = rsvLen;
    (void)memcpy_s(assertInfo->infoMsg + curIdx, sizeof(offset), &offset, sizeof(offset));
    curIdx += sizeof(offset);

    float fNum = 1.2f;
    (void)memcpy_s(assertInfo->infoMsg + curIdx, sizeof(fNum), &fNum, sizeof(fNum));
    curIdx += PARAM_VALUE_LEN;

    float fUpperNum = 3.4F;
    (void)memcpy_s(assertInfo->infoMsg + curIdx, sizeof(fUpperNum), &fUpperNum, sizeof(fUpperNum));
    curIdx += PARAM_VALUE_LEN;

    uint64_t pInfo = 1234567;
    (void)memcpy_s(assertInfo->infoMsg + curIdx, PARAM_VALUE_LEN, &pInfo, PARAM_VALUE_LEN);
    curIdx += PARAM_VALUE_LEN;

    uint64_t strOffset = PARAM_VALUE_LEN + strlen(printInfo) + 1;
    (void)memcpy_s(assertInfo->infoMsg + curIdx, PARAM_VALUE_LEN, &strOffset, PARAM_VALUE_LEN);
    curIdx += PARAM_VALUE_LEN;

    (void)memcpy_s(assertInfo->infoMsg + curIdx, strlen(printInfo) + 1, printInfo, strlen(printInfo) + 1);
    curIdx += (strlen(printInfo) + 1);

    const char* realStr = "This is the real string";
    (void)memcpy_s(assertInfo->infoMsg + curIdx, strlen(realStr) + 1, realStr, strlen(realStr) + 1);
    curIdx += (strlen(realStr) + 1);
    assertInfo->infoLen = curIdx;
}

TEST_F(PrintfTest, TestParseBlockInfo_Print)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    cmodelDrvMemcpy_flag = 1;
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);

    const size_t blockSize = 1024 * 1024;
    const uint64_t totalLen = blockSize * 75;
    std::vector<uint8_t> hostData(totalLen, 0);
    // 只处理第一个block，其余跳过
    uint8_t* blockAddr = hostData.data();
    BlockInfo* blockInfo = RtPtrToPtr<BlockInfo*>(blockAddr);
    blockInfo->length = blockSize;
    blockInfo->remainLen = blockSize - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo);

    BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(blockAddr + sizeof(BlockInfo));
    readInfo->readIdx = 0U;
    uint32_t endIdx = 0U;
    // 不带占位符的场景
    DumpInfoHead* dumpSkipInfo = RtPtrToPtr<DumpInfoHead*>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo));
    dumpSkipInfo->type = DumpType::DUMP_SKIP;
    dumpSkipInfo->infoLen = 0U;
    endIdx = sizeof(DumpInfoHead) + dumpSkipInfo->infoLen;
    // 不带占位符的场景
    DumpInfoHead* noParamInfo =
        RtPtrToPtr<DumpInfoHead*>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillNoParamDumpInfo(noParamInfo, DumpType::DUMP_SCALAR, SIMD_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + noParamInfo->infoLen);
    // 非法占位符场景
    DumpInfoHead* invalidParamInfo =
        RtPtrToPtr<DumpInfoHead*>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillInvalidParamDumpInfo(invalidParamInfo, DumpType::DUMP_SCALAR, SIMD_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + invalidParamInfo->infoLen);
    // 合法占位符场景
    DumpInfoHead* paramPrint =
        RtPtrToPtr<DumpInfoHead*>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillPrintDumpInfo(paramPrint, DumpType::DUMP_SCALAR, SIMD_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + paramPrint->infoLen);

    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = endIdx;

    error = ParsePrintf(hostData.data(), blockSize, dev->driver_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    cmodelDrvMemcpy_flag = 0;

    ut::ForceResetPrimaryDeviceIfActive();
}

TEST_F(PrintfTest, TestParseBlockInfo_SIMT)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    cmodelDrvMemcpy_flag = 1;
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);

    const size_t blockSize = 1024;
    const uint64_t totalLen = blockSize;
    std::vector<uint8_t> hostData(totalLen, 0);
    // 只处理第一个block，其余跳过
    uint8_t* blockAddr = hostData.data();
    BlockInfo* blockInfo = RtPtrToPtr<BlockInfo*>(blockAddr);
    blockInfo->length = blockSize;
    blockInfo->remainLen = blockSize - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo);

    BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(blockAddr + sizeof(BlockInfo));
    readInfo->readIdx = 0U;
    uint32_t endIdx = 0U;

    // 不带占位符的场景,直接打印字符串
    DumpInfoHead* noParamInfo =
        RtPtrToPtr<DumpInfoHead*>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillNoParamDumpInfo(noParamInfo, DumpType::DUMP_SIMT_PRINTF, SIMT_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + noParamInfo->infoLen);
    // 非法占位符场景
    DumpInfoHead* invalidParamInfo =
        RtPtrToPtr<DumpInfoHead*>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillInvalidParamDumpInfo(invalidParamInfo, DumpType::DUMP_SIMT_PRINTF, SIMT_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + invalidParamInfo->infoLen);
    // 合法占位符场景
    DumpInfoHead* paramPrint =
        RtPtrToPtr<DumpInfoHead*>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillPrintDumpInfo(paramPrint, DumpType::DUMP_SIMT_PRINTF, SIMT_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + paramPrint->infoLen);

    // dump wait 1 for 18B
    DumpInfoHead* dumpWaitInfo1 =
        RtPtrToPtr<DumpInfoHead*>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    dumpWaitInfo1->type = DumpType::DUMP_WAIT;
    dumpWaitInfo1->infoLen = 10U;
    endIdx += sizeof(DumpInfoHead) + dumpWaitInfo1->infoLen;

    // dump wait 2 for 18B
    DumpInfoHead* dumpWaitInfo2 =
        RtPtrToPtr<DumpInfoHead*>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    dumpWaitInfo2->type = DumpType::DUMP_WAIT;
    dumpWaitInfo2->infoLen = 10U;
    endIdx += sizeof(DumpInfoHead) + dumpWaitInfo2->infoLen;

    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = endIdx;
    writeInfo->packIdx = 5;

    error = ParseSimtPrintf(hostData.data(), blockSize, dev->driver_, dev);

    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(readInfo->readIdx + 36, writeInfo->writeIdx);
    cmodelDrvMemcpy_flag = 0;

    ut::ForceResetPrimaryDeviceIfActive();
}

TEST_F(PrintfTest, TestParseBlockInfo_SIMT_Exceed_Len)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    cmodelDrvMemcpy_flag = 1;
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);

    const size_t blockSize = 1024;
    const uint64_t totalLen = blockSize;
    std::vector<uint8_t> hostData(totalLen, 0);
    // 只处理第一个block，其余跳过
    uint8_t* blockAddr = hostData.data();
    BlockInfo* blockInfo = RtPtrToPtr<BlockInfo*>(blockAddr);
    blockInfo->length = blockSize;
    blockInfo->remainLen = blockSize - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo);

    BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(blockAddr + sizeof(BlockInfo));
    readInfo->readIdx = 0U;
    uint32_t endIdx = 0U;

    // 不带占位符的场景,直接打印字符串
    DumpInfoHead* noParamInfo =
        RtPtrToPtr<DumpInfoHead*>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillNoParamDumpInfo(noParamInfo, DumpType::DUMP_SIMT_PRINTF, SIMT_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + noParamInfo->infoLen);
    // 非法占位符场景
    DumpInfoHead* invalidParamInfo =
        RtPtrToPtr<DumpInfoHead*>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillInvalidParamDumpInfo(invalidParamInfo, DumpType::DUMP_SIMT_PRINTF, SIMT_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + invalidParamInfo->infoLen);
    // 合法占位符场景
    DumpInfoHead* paramPrint =
        RtPtrToPtr<DumpInfoHead*>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillPrintDumpInfo(paramPrint, DumpType::DUMP_SIMT_PRINTF, SIMT_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + paramPrint->infoLen);

    // dump wait 1 for 18B
    DumpInfoHead* dumpWaitInfo1 =
        RtPtrToPtr<DumpInfoHead*>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    dumpWaitInfo1->type = DumpType::DUMP_WAIT;
    dumpWaitInfo1->infoLen = 10U;
    endIdx += sizeof(DumpInfoHead) + dumpWaitInfo1->infoLen;

    // dump wait 2 for 18B
    DumpInfoHead* dumpWaitInfo2 =
        RtPtrToPtr<DumpInfoHead*>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    dumpWaitInfo2->type = DumpType::DUMP_WAIT;
    dumpWaitInfo2->infoLen = 10U;
    endIdx += sizeof(DumpInfoHead) + dumpWaitInfo2->infoLen;

    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = blockInfo->remainLen + 1; // 写指针超过remain len
    writeInfo->packIdx = 5;

    error = ParseSimtPrintf(hostData.data(), blockSize, dev->driver_, dev);

    EXPECT_EQ(error, RT_ERROR_NONE);
    cmodelDrvMemcpy_flag = 0;

    ut::ForceResetPrimaryDeviceIfActive();
}

// 绕接场景
TEST_F(PrintfTest, TestParseBlockInfo_SIMT_Circular)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    cmodelDrvMemcpy_flag = 1;
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);

    const size_t blockSize = 616;
    const uint64_t totalLen = blockSize;
    std::vector<uint8_t> hostData(totalLen, 0);
    // 只处理第一个block，其余跳过
    uint8_t* blockAddr = hostData.data();
    BlockInfo* blockInfo = RtPtrToPtr<BlockInfo*>(blockAddr);
    blockInfo->length = blockSize;
    blockInfo->remainLen = blockSize - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo); // 512

    BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(blockAddr + sizeof(BlockInfo));
    readInfo->readIdx = 77U;
    uint32_t endIdx = 77U;

    // 非法占位符场景
    DumpInfoHead* invalidParamInfo =
        RtPtrToPtr<DumpInfoHead*>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillInvalidParamDumpInfo(invalidParamInfo, DumpType::DUMP_SIMT_PRINTF, SIMT_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + invalidParamInfo->infoLen); // 151
    // 合法占位符场景
    DumpInfoHead* paramPrint =
        RtPtrToPtr<DumpInfoHead*>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillPrintDumpInfo(paramPrint, DumpType::DUMP_SIMT_PRINTF, SIMT_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + paramPrint->infoLen); // 334

    DumpInfoHead* circlePrint =
        RtPtrToPtr<DumpInfoHead*>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillPrintDumpInfoForSimtCircular(circlePrint, blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo));
    endIdx += (sizeof(DumpInfoHead) + circlePrint->infoLen); // 566

    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = endIdx; // 512 + 54
    writeInfo->packIdx = 3;

    error = ParseSimtPrintf(hostData.data(), blockSize, dev->driver_, dev);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(readInfo->readIdx, writeInfo->writeIdx);
    cmodelDrvMemcpy_flag = 0;

    ut::ForceResetPrimaryDeviceIfActive();
}

TEST_F(PrintfTest, TestParseBlockInfo_SIMT_Assert)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    cmodelDrvMemcpy_flag = 1;
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);

    const size_t blockSize = 1024;
    const uint64_t totalLen = blockSize;
    std::vector<uint8_t> hostData(totalLen, 0);
    // 只处理最后一个block，其余跳过
    uint8_t* blockAddr = hostData.data() + (totalLen - blockSize);
    BlockInfo* blockInfo = RtPtrToPtr<BlockInfo*>(blockAddr);
    blockInfo->length = blockSize;
    blockInfo->remainLen = blockSize - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo);

    BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(blockAddr + sizeof(BlockInfo));
    readInfo->readIdx = 0U;
    uint32_t endIdx = 0;
    // 不带占位符的场景
    DumpInfoHead* noParamInfo = RtPtrToPtr<DumpInfoHead*>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo));
    FillNoParamDumpInfo(noParamInfo, DumpType::DUMP_SIMT_ASSERT, SIMT_PRINT_RSV_LEN);
    endIdx = sizeof(DumpInfoHead) + noParamInfo->infoLen;
    // 非法占位符场景
    DumpInfoHead* invalidParamInfo =
        RtPtrToPtr<DumpInfoHead*>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillInvalidParamDumpInfo(invalidParamInfo, DumpType::DUMP_SIMT_ASSERT, SIMT_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + invalidParamInfo->infoLen);
    // 冗余占位符场景
    DumpInfoHead* redundantParamInfo =
        RtPtrToPtr<DumpInfoHead*>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillRedundantParamDumpInfo(redundantParamInfo, DumpType::DUMP_SIMT_ASSERT, SIMT_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + redundantParamInfo->infoLen);
    // 合法占位符场景
    DumpInfoHead* assertInfo =
        RtPtrToPtr<DumpInfoHead*>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillAssertDumpInfo(assertInfo, DumpType::DUMP_SIMT_ASSERT, SIMT_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + assertInfo->infoLen);

    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = endIdx;
    writeInfo->packIdx = 4;

    error = ParseSimtPrintf(hostData.data(), blockSize, dev->driver_, dev);
    EXPECT_EQ(error, RT_ERROR_NONE);
    cmodelDrvMemcpy_flag = 0;

    ut::ForceResetPrimaryDeviceIfActive();
}

TEST_F(PrintfTest, TestParseBlockInfo_Assert)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    cmodelDrvMemcpy_flag = 1;
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);

    const size_t blockSize = 1024 * 1024;
    const uint64_t totalLen = blockSize * 75;
    std::vector<uint8_t> hostData(totalLen, 0);
    // 只处理最后一个block，其余跳过
    uint8_t* blockAddr = hostData.data() + (totalLen - blockSize);
    BlockInfo* blockInfo = RtPtrToPtr<BlockInfo*>(blockAddr);
    blockInfo->length = blockSize;
    blockInfo->remainLen = blockSize - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo);

    BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(blockAddr + sizeof(BlockInfo));
    readInfo->readIdx = 0U;
    uint32_t endIdx = 0;
    // 不带占位符的场景
    DumpInfoHead* noParamInfo = RtPtrToPtr<DumpInfoHead*>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo));
    FillNoParamDumpInfo(noParamInfo, DumpType::DUMP_ASSERT, SIMD_PRINT_RSV_LEN);
    endIdx = sizeof(DumpInfoHead) + noParamInfo->infoLen;
    // 非法占位符场景
    DumpInfoHead* invalidParamInfo =
        RtPtrToPtr<DumpInfoHead*>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillInvalidParamDumpInfo(invalidParamInfo, DumpType::DUMP_ASSERT, SIMD_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + invalidParamInfo->infoLen);
    // 冗余占位符场景
    DumpInfoHead* redundantParamInfo =
        RtPtrToPtr<DumpInfoHead*>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillRedundantParamDumpInfo(redundantParamInfo, DumpType::DUMP_ASSERT, SIMD_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + redundantParamInfo->infoLen);
    // 合法占位符场景
    DumpInfoHead* assertInfo =
        RtPtrToPtr<DumpInfoHead*>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillAssertDumpInfo(assertInfo, DumpType::DUMP_ASSERT, SIMD_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + assertInfo->infoLen);

    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = endIdx;

    error = ParsePrintf(hostData.data(), blockSize, dev->driver_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    cmodelDrvMemcpy_flag = 0;

    ut::ForceResetPrimaryDeviceIfActive();
}

TEST_F(PrintfTest, TestParseBlockInfo_TimeStamp)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    cmodelDrvMemcpy_flag = 1;
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);

    int* addr = new int[2048 * 75]();
    void* workSpaceAddr = (void*)addr;
    EXPECT_NE(workSpaceAddr, nullptr);
    const size_t blockSize = 2048U;
    const uint32_t timeStampInfoLen = 40U;
    ConstructBlock((unsigned char*)addr, timeStampInfoLen);
    rtError_t ret = RT_ERROR_NONE;

    MOCKER(MsprofReportAdditionalInfo).stubs().will(invoke(MsprofReportAdditionalInfoStub));

    rtProfCommandHandle_t handle{};
    // 上报profilling开关值0x1000000000000ULL为false，值为0x0000100000000ULL为true
    handle.profSwitch = 0x1000000000000ULL;
    handle.type = PROF_COMMANDHANDLE_TYPE_START;
    rtProfilingCommandHandle(PROF_CTRL_SWITCH, (void*)(&handle), sizeof(rtProfCommandHandle_t));
    ret = ParsePrintf(workSpaceAddr, blockSize, dev->driver_);

    ConstructBlock((unsigned char*)addr, timeStampInfoLen);
    handle.profSwitch = 0x0000100000000ULL;
    rtProfilingCommandHandle(PROF_CTRL_SWITCH, (void*)(&handle), sizeof(rtProfCommandHandle_t));
    ret = ParsePrintf(workSpaceAddr, blockSize, dev->driver_);

    cmodelDrvMemcpy_flag = 0;
    delete[] addr;
    ut::ForceResetPrimaryDeviceIfActive();
}
rtError_t MemCopySync_stub(
    Driver* drv, void* dst, uint64_t destMax, const void* src, uint64_t size, rtMemcpyKind_t kind)
{
    memcpy(dst, src, destMax);
    return RT_ERROR_NONE;
}

template <typename T>
unsigned char* DumpInfoAppendArray(unsigned char* buf, T src[], const size_t len)
{
    T* dst = (T*)buf;
    for (size_t i = 0U; i < len; ++i) {
        dst[i] = src[i];
    }
    return buf + sizeof(T) * len;
}

template <typename T>
static unsigned char* AddTensorInfo(unsigned char* data, uint32_t dataType, T num[], const size_t len)
{
    DumpInfoHead tensorHead{};
    tensorHead.type = DumpType::DUMP_TENSOR;
    tensorHead.infoLen = sizeof(DumpTensorInfo) + sizeof(T) * len;
    data = DumpInfoAppendByte(data, tensorHead);
    DumpTensorInfo tensorInfo{};
    tensorInfo.addr = 0x400;
    tensorInfo.dataType = dataType;
    tensorInfo.desc = 716;
    tensorInfo.position = 1;
    data = DumpInfoAppendByte(data, tensorInfo);
    data = DumpInfoAppendArray(data, num, len);
    return data;
}

template <typename T>
static unsigned char* AddTensorInfo(
    unsigned char* data, uint32_t dataType, T num[], const size_t len, const DumpTensorInfo& tensorInfo)
{
    DumpInfoHead tensorHead{};
    tensorHead.type = DumpType::DUMP_TENSOR;
    tensorHead.infoLen = sizeof(DumpTensorInfo) + sizeof(T) * len;
    data = DumpInfoAppendByte(data, tensorHead);
    data = DumpInfoAppendByte(data, tensorInfo);
    data = DumpInfoAppendArray(data, num, len);
    return data;
}

DumpTensorInfo toDumpTensorInfo(
    uint32_t addr, uint32_t dataType, uint32_t position, uint32_t dim = 0, uint32_t num[] = {})
{
    DumpTensorInfo tensorInfo{};
    tensorInfo.addr = addr;
    tensorInfo.dataType = dataType;
    tensorInfo.desc = 716;
    tensorInfo.position = position;
    tensorInfo.dim = dim;
    for (size_t i = 0U; (i < dim) && (i < RT_DUMP_SHAPE_MAX_SIZE); i++) {
        tensorInfo.shape[i] = num[i];
    }
    return tensorInfo;
}

static unsigned char* AddShapeInfo(unsigned char* data, uint32_t num[], const size_t len)
{
    DumpInfoHead shapeHead{};
    shapeHead.type = DumpType::DUMP_SHAPE;
    shapeHead.infoLen = sizeof(DumpShapeInfo);
    data = DumpInfoAppendByte(data, shapeHead);
    DumpShapeInfo shapeInfo{};
    shapeInfo.dim = len; // uint32_t
    for (size_t i = 0; i < len; i++) {
        shapeInfo.shape[i] = num[i];
    }
    data = DumpInfoAppendByte(data, shapeInfo);
    return data;
}

void AddBlockInfo(unsigned char* data)
{
    unsigned char* blockAddr = data;
    size_t dataLen = sizeof(BlockInfo) + sizeof(BlockReadInfo) + sizeof(DumpShapeInfo) + sizeof(DumpInfoHead) * 17 +
                     sizeof(DumpTensorInfo) * 16 + sizeof(BlockWriteInfo);
    uint8_t num1[40];
    for (uint8_t i = 0U; i < 40U; ++i) {
        num1[i] = i;
    }
    uint32_t shape[] = {4, 2, 5};

    int8_t num2[] = {-3, -2, -1, 0, 1, 2, 3, 4};
    uint16_t num3[] = {0, 1, 2, 3};
    uint32_t num5[] = {0, 1};
    int32_t num6[] = {-2, 1};
    uint64_t num7[] = {235};
    int64_t num8[] = {20};
    float num9[] = {1.223, -9.3};
    cce::runtime::fp16_t num10[] = {23.32, 3214.2, -23.2, -93.1};
    double num11[] = {2.331}; // not support
    uint16_t num12[] = {16256, 49152, 65408, 16043, 65409, 32768, 16457, 32640};
    int8_t num13[] = {0, 3, -118, 20, 62, 67, 97, -56};
    bool boolNums[8];
    for (uint8_t i = 0U; i < 8U; ++i) {
        boolNums[i] = (i % 2U == 0U);
    }
    dataLen += sizeof(num1) + sizeof(num2) + sizeof(num3) + sizeof(num5) + sizeof(num6) + sizeof(num7) + sizeof(num8) +
               sizeof(num9) + sizeof(num10) + sizeof(num11) + sizeof(num12) + sizeof(num13) * 4 + sizeof(boolNums);
    const size_t blockSize = 1024 * 1024;
    BlockInfo blockInfo{};
    blockInfo.length = blockSize;
    blockInfo.coreId = 0U;
    blockInfo.blockNum = 2U;
    blockInfo.remainLen = blockSize - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo);
    blockInfo.magic = 0xAE86;
    blockInfo.rsv = 7;
    data = DumpInfoAppendByte(data, blockInfo);

    BlockReadInfo blockReadInfo{};
    blockReadInfo.readIdx = 0;
    data = DumpInfoAppendByte(data, blockReadInfo);

    data = AddShapeInfo(data, shape, 3);
    data = AddTensorInfo(data, 4, num1, 40);
    data = AddTensorInfo(data, 2, num2, 8);
    data = AddTensorInfo(data, 7, num3, 4);
    data = AddTensorInfo(data, 8, num5, 2);
    data = AddTensorInfo(data, 3, num6, 2);
    data = AddTensorInfo(data, 10, num7, 1);
    data = AddTensorInfo(data, 9, num8, 1);
    data = AddTensorInfo(data, 0, num9, 2);
    data = AddTensorInfo(data, 1, num10, 4);
    data = AddTensorInfo(data, 27, num12, 8);
    data = AddTensorInfo(data, 34, num13, 8);
    data = AddTensorInfo(data, 35, num13, 8);
    data = AddTensorInfo(data, 36, num13, 8);
    data = AddTensorInfo(data, 37, num13, 8);
    data = AddTensorInfo(data, 12, boolNums, 8);
    data = AddTensorInfo(data, 11, num11, 1); // no support dtype

    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = dataLen - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo);
    data = DumpInfoAppendByte(data, writeInfo);
}

TEST_F(PrintfTest, PrintDumpLargeTensorWithShape)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    dev->simdEnable_ = true;
    error = dev->ParseSimdPrintInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);
    MOCKER_CPP_VIRTUAL(dev->driver_, &Driver::MemCopySync).stubs().will(invoke(MemCopySync_stub));

    size_t blockSize = 1024 * 1024;
    uint64_t totalLen = blockSize * 75;
    std::vector<uint8_t> hostData(totalLen, 0);
    uint8_t* blockAddr = hostData.data();
    size_t dataLen = sizeof(BlockInfo) + sizeof(DumpShapeInfo) + sizeof(BlockReadInfo) + sizeof(DumpInfoHead) * 2 +
                     sizeof(DumpTensorInfo) * 1 + sizeof(BlockWriteInfo);
    const int size = 200;
    uint8_t tensorData1[size];
    for (int i = 0; i < size; ++i) {
        tensorData1[i] = i;
    }
    dataLen += sizeof(tensorData1);

    BlockInfo blockInfo{};
    blockInfo.length = blockSize;
    blockInfo.coreId = 0U;
    blockInfo.blockNum = 2U;
    blockInfo.remainLen = blockSize - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo);
    blockInfo.magic = 0xAE86;
    blockInfo.rsv = 7;
    unsigned char* data = DumpInfoAppendByte((unsigned char*)blockAddr, blockInfo);

    BlockReadInfo blockReadInfo{};
    blockReadInfo.readIdx = 0;
    data = DumpInfoAppendByte(data, blockReadInfo);
    uint32_t shape1[] = {50, 3, 2};
    data = AddShapeInfo(data, shape1, 3);
    data = AddTensorInfo(data, 4, tensorData1, 200);
    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(blockAddr + 1024 - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = dataLen - sizeof(BlockWriteInfo) - sizeof(BlockInfo) - sizeof(BlockReadInfo);
    data = DumpInfoAppendByte(data, writeInfo);

    error = ParsePrintf(blockAddr, 1024, dev->driver_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ut::ForceResetPrimaryDeviceIfActive();
}

TEST_F(PrintfTest, DumpTensorPrintf)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    MOCKER_CPP_VIRTUAL(dev->driver_, &Driver::MemCopySync).stubs().will(invoke(MemCopySync_stub));

    size_t blockSize = 1024 * 1024;
    uint64_t totalLen = blockSize * 75;
    std::vector<uint8_t> hostData(totalLen, 0);
    uint8_t* blockAddr = hostData.data();
    AddBlockInfo((unsigned char*)blockAddr);
    error = ParsePrintf(hostData.data(), blockSize, dev->driver_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ut::ForceResetPrimaryDeviceIfActive();
}

TEST_F(PrintfTest, PrintDumpTensorWithShape)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    MOCKER_CPP_VIRTUAL(dev->driver_, &Driver::MemCopySync).stubs().will(invoke(MemCopySync_stub));

    size_t blockSize = 1024 * 1024;
    uint64_t totalLen = blockSize * 75;
    std::vector<uint8_t> hostData(totalLen, 0);
    uint8_t* blockAddr = hostData.data();

    size_t dataLen = sizeof(BlockInfo) + sizeof(BlockReadInfo) + sizeof(DumpShapeInfo) * 4 + sizeof(DumpInfoHead) * 8 +
                     sizeof(DumpTensorInfo) * 4 + sizeof(BlockWriteInfo);
    uint8_t tensorData1[40];
    for (uint8_t i = 0U; i < 40U; ++i) {
        tensorData1[i] = i;
    }
    int16_t tensorData2[] = {0, -1, 2, -3, 4, -5, 6, -7, 8, -9, 10, -11, 12, -13, 14, -15};
    float tensorData3[] = {1.223, -9.3, 6789.01, -4.56, 0.0, 78.90};
    bool tensorData4[35];
    for (int i = 0; i < 35; ++i) {
        tensorData4[i] = (i % 2 == 0);
    }
    dataLen += sizeof(tensorData1);
    dataLen += sizeof(tensorData2);
    dataLen += sizeof(tensorData3);
    dataLen += sizeof(tensorData4);

    BlockInfo blockInfo{};
    blockInfo.length = blockSize;
    blockInfo.coreId = 0U;
    blockInfo.blockNum = 2U;
    blockInfo.remainLen = blockSize - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo);
    blockInfo.magic = 0xAE86;
    blockInfo.rsv = 7;
    unsigned char* data = DumpInfoAppendByte((unsigned char*)blockAddr, blockInfo);

    BlockReadInfo blockReadInfo{};
    blockReadInfo.readIdx = 0;
    data = DumpInfoAppendByte(data, blockReadInfo);
    // shape总数大于dump数据数
    uint32_t shape1[] = {3, 5, 4};
    data = AddShapeInfo(data, shape1, 3);
    data = AddTensorInfo(data, 4, tensorData1, 40);
    // shape总数小于dump数据数
    uint32_t shape2[] = {2, 2, 3};
    data = AddShapeInfo(data, shape2, 3);
    data = AddTensorInfo(data, 6, tensorData2, 16);
    // shape总数等于dump数据数
    uint32_t shape3[] = {3, 1, 2};
    data = AddShapeInfo(data, shape3, 3);
    data = AddTensorInfo(data, 0, tensorData3, 6);
    uint32_t shape4[] = {7, 1, 5};
    data = AddShapeInfo(data, shape4, 3);
    data = AddTensorInfo(data, 12, tensorData4, 35);

    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = dataLen - sizeof(BlockWriteInfo) - sizeof(BlockInfo) - sizeof(BlockReadInfo);
    data = DumpInfoAppendByte(data, writeInfo);
    error = ParsePrintf(blockAddr, blockSize, dev->driver_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ut::ForceResetPrimaryDeviceIfActive();
}

TEST_F(PrintfTest, PrintDumpTensorWithoutShape)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    MOCKER_CPP_VIRTUAL(dev->driver_, &Driver::MemCopySync).stubs().will(invoke(MemCopySync_stub));

    size_t blockSize = 1024 * 1024;
    uint64_t totalLen = blockSize * 75;
    std::vector<uint8_t> hostData(totalLen, 0);
    uint8_t* blockAddr = hostData.data();
    size_t dataLen = sizeof(BlockInfo) + sizeof(BlockReadInfo) + sizeof(DumpInfoHead) * 7 + sizeof(DumpTensorInfo) * 7 +
                     sizeof(BlockWriteInfo);
    // 几种不同数据，以及double不支持数据类型，31行换行的场景
    const int size = 10;
    cce::runtime::BFloat16 tensorData1[size];
    cce::runtime::HiFloat8 tensorData2[size];
    cce::runtime::Fp8E5M2 tensorData3[size];
    cce::runtime::Fp8E4M3 tensorData4[size];
    cce::runtime::Fp8E8M0 tensorData5[35];
    bool tensorData6[35];
    // 不支持的类型
    double tensorData7[size];
    for (int i = 0; i < size; ++i) {
        tensorData1[i] = BFloat16(static_cast<uint16_t>(i + 100));
        tensorData2[i] = HiFloat8(static_cast<uint8_t>(i + 100));
        tensorData3[i] = Fp8E5M2(static_cast<uint8_t>(i + 100));
        tensorData4[i] = Fp8E4M3(static_cast<uint8_t>(i + 100));
        tensorData7[i] = static_cast<double>(i + 100);
    }
    for (int i = 0; i < 35; ++i) {
        tensorData5[i] = Fp8E8M0(static_cast<uint8_t>(i + 100));
        tensorData6[i] = (i % 2U == 0U);
    }
    dataLen += sizeof(tensorData1);
    dataLen += sizeof(tensorData2);
    dataLen += sizeof(tensorData3);
    dataLen += sizeof(tensorData4);
    dataLen += sizeof(tensorData5);
    dataLen += sizeof(tensorData6);
    dataLen += sizeof(tensorData7);

    BlockInfo blockInfo{};
    blockInfo.length = blockSize;
    blockInfo.coreId = 0U;
    blockInfo.blockNum = 2U;
    blockInfo.remainLen = blockSize - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo);
    blockInfo.magic = 0xAE86;
    blockInfo.rsv = 7;
    unsigned char* data = DumpInfoAppendByte((unsigned char*)blockAddr, blockInfo);

    BlockReadInfo blockReadInfo{};
    blockReadInfo.readIdx = 0;
    data = DumpInfoAppendByte(data, blockReadInfo);

    data = AddTensorInfo(data, 27, tensorData1, 10);
    data = AddTensorInfo(data, 34, tensorData2, 10);
    data = AddTensorInfo(data, 35, tensorData3, 10);
    data = AddTensorInfo(data, 36, tensorData4, 10);
    data = AddTensorInfo(data, 37, tensorData5, 35);
    data = AddTensorInfo(data, 12, tensorData6, 35);
    data = AddTensorInfo(data, 11, tensorData7, 10);

    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = dataLen - sizeof(BlockWriteInfo) - sizeof(BlockInfo) - sizeof(BlockReadInfo);
    data = DumpInfoAppendByte(data, writeInfo);
    error = ParsePrintf(blockAddr, blockSize, dev->driver_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ut::ForceResetPrimaryDeviceIfActive();
}

TEST_F(PrintfTest, PrintDumpTensorWhenDataError)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    MOCKER_CPP_VIRTUAL(dev->driver_, &Driver::MemCopySync).stubs().will(invoke(MemCopySync_stub));

    size_t blockSize = 1024 * 1024;
    uint64_t totalLen = blockSize * 75;
    std::vector<uint8_t> hostData(totalLen, 0);
    uint8_t* blockAddr = hostData.data();
    size_t dataLen = sizeof(BlockInfo) + sizeof(BlockReadInfo) + sizeof(DumpShapeInfo) * 3 + sizeof(DumpInfoHead) * 6 +
                     sizeof(DumpTensorInfo) * 3 + sizeof(BlockWriteInfo);
    uint8_t tensorData1[40];
    for (uint8_t i = 0U; i < 40U; ++i) {
        tensorData1[i] = i;
    }
    bool tensorData2[] = {0, 1, 1, 0, 0};
    int8_t tensorData3[] = {-1, 0, -5, 8, -6, 9};
    dataLen += sizeof(tensorData1);
    dataLen += sizeof(tensorData2);
    dataLen += sizeof(tensorData3);

    BlockInfo blockInfo{};
    blockInfo.length = blockSize;
    blockInfo.coreId = 0U;
    blockInfo.blockNum = 2U;
    blockInfo.remainLen = blockSize - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo);
    blockInfo.magic = 0xAE86;
    blockInfo.rsv = 7;
    unsigned char* data = DumpInfoAppendByte((unsigned char*)blockAddr, blockInfo);
    BlockReadInfo blockReadInfo{};
    blockReadInfo.readIdx = 0;
    data = DumpInfoAppendByte(data, blockReadInfo);

    DumpInfoHead shapeHead{};
    shapeHead.type = DumpType::DUMP_SHAPE;
    shapeHead.infoLen = 32; // 小于DumpShapeInfo的长度
    data = DumpInfoAppendByte(data, shapeHead);
    uint32_t shape1[] = {3, 2, 4};
    DumpShapeInfo shapeInfo{};
    shapeInfo.dim = 3;
    for (size_t i = 0; i < 3; i++) {
        shapeInfo.shape[i] = shape1[i];
    }
    data = DumpInfoAppendByte(data, shapeInfo);
    // 这里shape长度小于后，tensor直接打印，没按shape打
    data = AddTensorInfo(data, 4, tensorData1, 40);

    // shape有0，不进行打印tensor
    uint32_t shape2[] = {3, 0, 4};
    data = AddShapeInfo(data, shape2, 3);
    data = AddTensorInfo(data, 12, tensorData2, 5);
    // shape数据过大，防止溢出，不进行打印tensor
    uint32_t max = std::numeric_limits<uint32_t>::max();
    uint32_t shape3[] = {max, max, max};
    data = AddShapeInfo(data, shape3, 3);
    data = AddTensorInfo(data, 2, tensorData3, 6);

    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = dataLen - sizeof(BlockWriteInfo) - sizeof(BlockInfo) - sizeof(BlockReadInfo);
    data = DumpInfoAppendByte(data, writeInfo);
    error = ParsePrintf(blockAddr, blockSize, dev->driver_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ut::ForceResetPrimaryDeviceIfActive();
}

TEST_F(PrintfTest, PrintDumpTensorPosition)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    MOCKER_CPP_VIRTUAL(dev->driver_, &Driver::MemCopySync).stubs().will(invoke(MemCopySync_stub));

    size_t blockSize = 1024 * 1024;
    uint64_t totalLen = blockSize * 75;
    std::vector<uint8_t> hostData(totalLen, 0);
    uint8_t* blockAddr = hostData.data();
    size_t dataLen = sizeof(BlockInfo) + sizeof(BlockReadInfo) + sizeof(DumpInfoHead) * 5 + sizeof(DumpTensorInfo) * 5 +
                     sizeof(BlockWriteInfo);
    bool tensorData1[] = {1, 1, 1, 1, 1};
    bool tensorData2[] = {0, 1, 1, 0, 0};
    int8_t tensorData3[] = {-1, 0, -5, 8, -6, 9};
    int16_t tensorData4[] = {-200, 0, -5, 8, -6, 9};
    uint16_t tensorData5[] = {255, 256, 0, 8, 666, 9};
    dataLen += sizeof(tensorData1);
    dataLen += sizeof(tensorData2);
    dataLen += sizeof(tensorData3);
    dataLen += sizeof(tensorData4);
    dataLen += sizeof(tensorData5);

    BlockInfo blockInfo{};
    blockInfo.length = blockSize;
    blockInfo.coreId = 0U;
    blockInfo.blockNum = 2U;
    blockInfo.remainLen = blockSize - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo);
    blockInfo.magic = 0xAE86;
    blockInfo.rsv = 7;
    unsigned char* data = DumpInfoAppendByte((unsigned char*)blockAddr, blockInfo);

    BlockReadInfo blockReadInfo{};
    blockReadInfo.readIdx = 0;
    data = DumpInfoAppendByte(data, blockReadInfo);

    data = AddTensorInfo(data, 12, tensorData1, 5, toDumpTensorInfo(0x400, 12, 3));
    data = AddTensorInfo(data, 12, tensorData2, 5, toDumpTensorInfo(0x400, 12, 4));
    data = AddTensorInfo(data, 2, tensorData3, 6, toDumpTensorInfo(0x400, 2, 2));
    data = AddTensorInfo(data, 6, tensorData4, 6, toDumpTensorInfo(0x400, 6, 6));
    data = AddTensorInfo(data, 7, tensorData5, 6, toDumpTensorInfo(0x400, 7, 7));

    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = dataLen - sizeof(BlockWriteInfo) - sizeof(BlockInfo) - sizeof(BlockReadInfo);
    data = DumpInfoAppendByte(data, writeInfo);
    error = ParsePrintf(blockAddr, blockSize, dev->driver_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ut::ForceResetPrimaryDeviceIfActive();
}

TEST_F(PrintfTest, HIFLOAT8_Dumptensor)
{
    float val = std::numeric_limits<float>::infinity();
    uint8_t data1 = 111;
    HiFloat8 hif81(data1);
    EXPECT_EQ(hif81.GetValue(), val);

    uint8_t data2 = 128;
    HiFloat8 hif82(data2);
    val = std::numeric_limits<float>::quiet_NaN();
    EXPECT_EQ(std::isnan(hif82.GetValue()), true);

    uint8_t data3 = 239;
    HiFloat8 hif83(data3);
    val = -std::numeric_limits<float>::infinity();
    EXPECT_EQ(hif83.GetValue(), val);

    uint8_t data4 = 83;
    HiFloat8 hif84(data4);
    val = 0.109375;
    EXPECT_EQ(std::abs(hif84.GetValue() - val) < std::numeric_limits<float>::epsilon(), true);
}

TEST_F(PrintfTest, FLOAT8_E5M2_Dumptensor)
{
    float val = 0.000106812;
    uint8_t data1 = 7;
    Fp8E5M2 fp81(data1);
    EXPECT_EQ(std::abs(fp81.GetValue() - val) < std::numeric_limits<float>::epsilon(), true);

    uint8_t data2 = 252;
    Fp8E5M2 fp82(data2);
    val = -std::numeric_limits<float>::infinity();
    EXPECT_EQ(fp82.GetValue(), val);

    uint8_t data3 = 253;
    Fp8E5M2 fp83(data3);
    val = std::numeric_limits<float>::quiet_NaN();
    EXPECT_EQ(std::isnan(fp83.GetValue()), true);

    uint8_t data4 = 2;
    Fp8E5M2 fp84(data4);
    val = 3.05176e-05;
    EXPECT_EQ(std::abs(fp84.GetValue() - val) < std::numeric_limits<float>::epsilon(), true);
}

TEST_F(PrintfTest, FLOAT8_E4M3_Dumptensor)
{
    float val = std::numeric_limits<float>::quiet_NaN();
    uint8_t data1 = 127;
    Fp8E4M3 fp81(data1);
    EXPECT_EQ(std::isnan(fp81.GetValue()), true);
    uint8_t data2 = 6;
    Fp8E4M3 fp82(data2);
    val = 0.01171875;
    EXPECT_EQ(std::abs(fp82.GetValue() - val) < std::numeric_limits<float>::epsilon(), true);
    uint8_t data3 = 122;
    Fp8E4M3 fp83(data3);
    val = 320.0;
    EXPECT_EQ(std::abs(fp83.GetValue() - val) < std::numeric_limits<float>::epsilon(), true);
}

TEST_F(PrintfTest, FLOAT8_E8M0_Dumptensor)
{
    float val = std::numeric_limits<float>::quiet_NaN();
    uint8_t data1 = 255;
    Fp8E8M0 fp81(data1);
    EXPECT_EQ(std::isnan(fp81.GetValue()), true);
    uint8_t data2 = 109;
    Fp8E8M0 fp82(data2);
    val = 3.8147e-06;
    EXPECT_EQ(std::abs(fp82.GetValue() - val) < std::numeric_limits<float>::epsilon(), true);
}

TEST_F(PrintfTest, FP16_Dumptensor)
{
    float data1 = 1.234;
    cce::runtime::fp16_t num1[] = {data1};
    double data2 = 2.456;
    cce::runtime::fp16_t num2[] = {data2};
    int8_t data3 = 2;
    cce::runtime::fp16_t num3[] = {data3};
    uint8_t data4 = 2;
    cce::runtime::fp16_t num4[] = {data4};
    int16_t data5 = 2;
    cce::runtime::fp16_t num5[] = {data5};
    uint16_t data6 = 2;
    cce::runtime::fp16_t num6[] = {data6};
    int32_t data7 = 2;
    cce::runtime::fp16_t num7[] = {data7};
    uint32_t data8 = 2;
    cce::runtime::fp16_t num8[] = {data8};
    uint64_t data9 = 2;
    cce::runtime::fp16_t num9[] = {data9};
    int64_t data10 = 2;
    cce::runtime::fp16_t num10[] = {data10};
    EXPECT_EQ(num10[0].toFloat(), float(data10));
}

TEST_F(PrintfTest, DumpFP16_Mid)
{
    float data1 = 35500;
    cce::runtime::fp16_t num1[] = {data1};
    double data2 = 35500;
    cce::runtime::fp16_t num2[] = {data2};
    int8_t data3 = 35500;
    cce::runtime::fp16_t num3[] = {data3};
    uint8_t data4 = 35500;
    cce::runtime::fp16_t num4[] = {data4};
    int16_t data5 = 35500;
    cce::runtime::fp16_t num5[] = {data5};
    uint16_t data6 = 35500;
    cce::runtime::fp16_t num6[] = {data6};
    int32_t data7 = 35500;
    cce::runtime::fp16_t num7[] = {data7};
    uint32_t data8 = 35500;
    cce::runtime::fp16_t num8[] = {data8};
    uint64_t data9 = 35500;
    cce::runtime::fp16_t num9[] = {data9};
    int64_t data10 = 35500;
    cce::runtime::fp16_t num10[] = {data10};
    EXPECT_EQ(num10[0].toFloat(), 35488.0);
}

TEST_F(PrintfTest, DumpFP16_Large)
{
    float data1 = 65500;
    cce::runtime::fp16_t num1[] = {data1};
    double data2 = 65500;
    cce::runtime::fp16_t num2[] = {data2};
    int8_t data3 = 65500;
    cce::runtime::fp16_t num3[] = {data3};
    uint8_t data4 = 65500;
    cce::runtime::fp16_t num4[] = {data4};
    int16_t data5 = 65500;
    cce::runtime::fp16_t num5[] = {data5};
    uint16_t data6 = 65500;
    cce::runtime::fp16_t num6[] = {data6};
    int32_t data7 = 65500;
    cce::runtime::fp16_t num7[] = {data7};
    uint32_t data8 = 65500;
    cce::runtime::fp16_t num8[] = {data8};
    uint64_t data9 = 65500;
    cce::runtime::fp16_t num9[] = {data9};
    int64_t data10 = 65500;
    cce::runtime::fp16_t num10[] = {data10};
    EXPECT_EQ(num10[0].toFloat(), 65504.0);
}

TEST_F(PrintfTest, DumpFP16_DiffType)
{
    const uint16_t zero = 0;
    cce::runtime::fp16_t num_zero = zero;
    uint16_t min_pos = 1;
    cce::runtime::fp16_t num_min_pos = min_pos;

    double dVal_Overflow = 1.0e+300;
    cce::runtime::fp16_t fp16_Overflow = dVal_Overflow;
    double dVal_Denormal = 1.0e-40;
    cce::runtime::fp16_t fp16_Denormal = dVal_Denormal;
    double dVal_MinDenormal = 5.0e-324;
    cce::runtime::fp16_t fp16_MinDenormal = dVal_MinDenormal;
    double dVal_Zero = 0.0;
    cce::runtime::fp16_t fp16_Zero = dVal_Zero;
    double data1 = 1e-6;
    cce::runtime::fp16_t num1 = data1;

    float data2 = 1e-6;
    cce::runtime::fp16_t num2 = data2;
    float fVal_Overflow = 1.0e+300;
    cce::runtime::fp16_t fp16_Overflow1 = fVal_Overflow;
    float fVal_Denormal = 1.0e-40;
    cce::runtime::fp16_t fp16_Denormal1 = fVal_Denormal;
    float fVal_MinDenormal = 5.0e-324;
    cce::runtime::fp16_t fp16_MinDenormal1 = fVal_MinDenormal;
    float fVal_Normal = 1.5;
    cce::runtime::fp16_t fp16_Normal = fVal_Normal;
    float fVal_Zero = 0.0;
    cce::runtime::fp16_t fp16_Zero1 = fVal_Zero;
    EXPECT_EQ(fp16_Zero1.toFloat(), 0);

    int16_t data3 = 0;
    cce::runtime::fp16_t num3 = data3;
    int32_t data4 = 0;
    cce::runtime::fp16_t num4 = data4;
    uint32_t data5 = 0;
    cce::runtime::fp16_t num5 = data5;
    int32_t data6 = -5;
    cce::runtime::fp16_t num6 = data6;
}

TEST_F(PrintfTest, DumpFP16_InfAndNan)
{
    // +Infinity
    uint16_t data1 = 0x7C00;
    cce::runtime::fp16_t num1[] = {data1};
    EXPECT_TRUE(std::isinf(num1[0].toFloat()));
    EXPECT_GT(num1[0].toFloat(), float(data1));

    // -Infinity
    uint16_t data2 = 0xFC00;
    cce::runtime::fp16_t num2[] = {data2};
    EXPECT_TRUE(std::isinf(num2[0].toFloat()));
    EXPECT_LT(num2[0].toFloat(), float(data2));

    // NaN
    uint16_t data3 = 0x7C01;
    cce::runtime::fp16_t num3[] = {data3};
    EXPECT_TRUE(std::isnan(num3[0].toFloat()));

    // NaN
    uint16_t data4 = 0x7FFF;
    cce::runtime::fp16_t num4[] = {data4};
    EXPECT_TRUE(std::isnan(num4[0].toFloat()));
}

TEST_F(PrintfTest, TestInitPrintf_MaxResMapTypeTooSmall)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    dev->simdEnable_ = true;
    error = dev->ParseSimdPrintInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halGetMaxResMapType).stubs().will(returnValue(0x05));

    auto props = dev->GetDevProperties();
    const uint64_t totalCoreNum = static_cast<uint64_t>(props.aicNum + props.aivNum);
    const size_t blockSize = 1024 * 1024;
    std::vector<uint8_t> hostData(blockSize * totalCoreNum, 0);

    error = InitPrintf(hostData.data(), blockSize, dev);
    EXPECT_EQ(error, RT_ERROR_NONE);

    BlockInfo* blockInfo = RtPtrToPtr<BlockInfo*>(hostData.data());
    EXPECT_EQ(blockInfo->dbgAddr, 0U);

    GlobalMockObject::verify();
    ut::ForceResetPrimaryDeviceIfActive();
}

TEST_F(PrintfTest, TestInitPrintf_HalResMapFailed)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    dev->simdEnable_ = true;
    error = dev->ParseSimdPrintInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(halGetMaxResMapType).stubs().will(returnValue(0x20));
    MOCKER(halResMap).stubs().will(returnValue(DRV_ERROR_NOT_SUPPORT));

    auto props = dev->GetDevProperties();
    const uint64_t totalCoreNum = static_cast<uint64_t>(props.aicNum + props.aivNum);
    const size_t blockSize = 1024 * 1024;
    std::vector<uint8_t> hostData(blockSize * totalCoreNum, 0);

    error = InitPrintf(hostData.data(), blockSize, dev);
    EXPECT_EQ(error, RT_ERROR_NONE);

    BlockInfo* blockInfo = RtPtrToPtr<BlockInfo*>(hostData.data());
    EXPECT_EQ(blockInfo->dbgAddr, 0U);

    GlobalMockObject::verify();
    ut::ForceResetPrimaryDeviceIfActive();
}

TEST_F(PrintfTest, TestInitPrintf_DebugAddrSuccess)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    dev->simdEnable_ = true;
    error = dev->ParseSimdPrintInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    auto props = dev->GetDevProperties();
    const uint64_t totalCoreNum = static_cast<uint64_t>(props.aicNum + props.aivNum);
    const size_t blockSize = 1024 * 1024;
    std::vector<uint8_t> hostData(blockSize * totalCoreNum, 0);

    error = InitPrintf(hostData.data(), blockSize, dev);
    EXPECT_EQ(error, RT_ERROR_NONE);

    BlockInfo* blockInfo = RtPtrToPtr<BlockInfo*>(hostData.data());
    EXPECT_NE(blockInfo->dbgAddr, 0x1000U);
    EXPECT_EQ(blockInfo->dbgAddr, 0U);

    ut::ForceResetPrimaryDeviceIfActive();
}

TEST_F(PrintfTest, PrintDumpTensorShapeWithShape)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    MOCKER_CPP_VIRTUAL(dev->driver_, &Driver::MemCopySync).stubs().will(invoke(MemCopySync_stub));

    size_t blockSize = 1024 * 1024;
    uint64_t totalLen = blockSize * 75;
    std::vector<uint8_t> hostData(totalLen, 0);
    uint8_t* blockAddr = hostData.data();

    size_t dataLen = sizeof(BlockInfo) + sizeof(BlockReadInfo) + sizeof(DumpShapeInfo) * 5 + sizeof(DumpInfoHead) * 11 +
                     sizeof(DumpTensorInfo) * 6 + sizeof(BlockWriteInfo);
    uint8_t tensorData1[40];
    for (uint8_t i = 0U; i < 40U; ++i) {
        tensorData1[i] = i;
    }
    int16_t tensorData2[] = {0, -1, 2, -3, 4, -5, 6, -7, 8, -9, 10, -11, 12, -13, 14, -15};
    float tensorData3[] = {1.223, -9.3, 6789.01, -4.56, 0.0, 78.90};
    bool tensorData4[35];
    for (int i = 0; i < 35; ++i) {
        tensorData4[i] = (i % 2 == 0);
    }
    int16_t tensorData5[] = {20, -11, 232, -33, 43, -54, 655, -74, 86, -96, 105, -119, 123, -135, 14, -15};
    dataLen += sizeof(tensorData1) * 2 + sizeof(tensorData2) + sizeof(tensorData3) + sizeof(tensorData4);
    dataLen += sizeof(tensorData5);

    BlockInfo blockInfo{};
    blockInfo.length = blockSize;
    blockInfo.coreId = 0U;
    blockInfo.blockNum = 2U;
    blockInfo.remainLen = blockSize - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo);
    blockInfo.magic = 0xAE86;
    blockInfo.rsv = 7;
    unsigned char* data = DumpInfoAppendByte((unsigned char*)blockAddr, blockInfo);

    BlockReadInfo blockReadInfo{};
    blockReadInfo.readIdx = 0;
    data = DumpInfoAppendByte(data, blockReadInfo);

    DumpTensorInfo tensorInfo;

    // 1.有dumpShape, tensorShape, 且dim值有效
    uint32_t shape1[] = {3U, 5U, 4U};
    data = AddShapeInfo(data, shape1, 3);
    uint32_t tensorShape1[] = {4U, 2U, 6U};
    tensorInfo = toDumpTensorInfo(0x039U, 4U, 1U, 3U, tensorShape1);
    data = AddTensorInfo(data, 4, tensorData1, 40, tensorInfo);

    // 2.没有dumpShape, 没有tensorShape
    data = AddTensorInfo(data, 4, tensorData1, 40);

    // 3.有dumpShape, 没有tensorShape
    uint32_t shape2[] = {3U, 3U, 5U};
    data = AddShapeInfo(data, shape2, 3);
    tensorInfo = toDumpTensorInfo(0x0401U, 6U, 1U);
    data = AddTensorInfo(data, 6U, tensorData2, 16, tensorInfo);

    // 4.有dumpShape, tensorShape, tensorShape的dim值大于8U
    uint32_t shape3[] = {2U, 2U, 3U};
    data = AddShapeInfo(data, shape3, 3);
    uint32_t tensorShape2[] = {4U, 2U, 6U, 2U, 4U, 2U, 2U, 3U, 4U};
    tensorInfo = toDumpTensorInfo(0x0402, 0U, 1U, 9U, tensorShape2);
    data = AddTensorInfo(data, 6U, tensorData3, 6, tensorInfo);

    // 5.有dumpShape, 有tensorShape, tensorShape的dim为0
    uint32_t shape4[] = {3U, 2U, 7U};
    data = AddShapeInfo(data, shape4, 3);
    uint32_t tensorShape3[] = {2U, 1U, 3U};
    tensorInfo = toDumpTensorInfo(0x0403U, 12U, 1U, 0U, tensorShape3);
    data = AddTensorInfo(data, 0U, tensorData4, 35, tensorInfo);

    // 6.有dumpShape, dim值大于8, 没有tensorShape
    DumpInfoHead shapeHead{};
    shapeHead.type = DumpType::DUMP_SHAPE;
    shapeHead.infoLen = sizeof(DumpShapeInfo);
    data = DumpInfoAppendByte(data, shapeHead);
    DumpShapeInfo shapeInfo{};
    shapeInfo.dim = 9U;
    for (size_t i = 0; i < RT_DUMP_SHAPE_MAX_SIZE; i++) {
        shapeInfo.shape[i] = i + 1;
    }
    data = DumpInfoAppendByte(data, shapeInfo);
    tensorInfo = toDumpTensorInfo(0x0404, 6U, 1U);
    data = AddTensorInfo(data, 6U, tensorData5, 16, tensorInfo);

    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = dataLen - sizeof(BlockWriteInfo) - sizeof(BlockInfo) - sizeof(BlockReadInfo);
    data = DumpInfoAppendByte(data, writeInfo);
    error = ParsePrintf(blockAddr, blockSize, dev->driver_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    ut::ForceResetPrimaryDeviceIfActive();
}
