/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "driver/ascend_hal.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#include "printf.hpp"
#include "parse_kernel_dfx_info.hpp"
#define private public
#define protected public
#include "runtime.hpp"
#include "thread_local_container.hpp"
#include "raw_device.hpp"
#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;

extern int32_t cmodelDrvMemcpy_flag;

namespace {
struct CallbackCapture {
    bool called;
    void* data;
    uint64_t datalen;
    uint64_t readIdx;
    uint64_t writeIdx;
    uint32_t coreType;
    uint32_t coreId;
    uint32_t deviceId;
    uint64_t consumedLenToReturn;
};

CallbackCapture g_capture;

void TestParseDfxInfoCallback(const rtDfxParseParam* param, uint64_t* consumedLen)
{
    g_capture.called = true;
    g_capture.data = param->data;
    g_capture.datalen = param->datalen;
    g_capture.readIdx = param->readIdx;
    g_capture.writeIdx = param->writeIdx;
    g_capture.coreType = param->coreType;
    g_capture.coreId = param->coreId;
    g_capture.deviceId = param->deviceId;
    *consumedLen = g_capture.consumedLenToReturn;
}

void ResetCapture(uint64_t consumedLenToReturn = 0U)
{
    g_capture.called = false;
    g_capture.data = nullptr;
    g_capture.datalen = 0U;
    g_capture.readIdx = 0U;
    g_capture.writeIdx = 0U;
    g_capture.coreType = 0U;
    g_capture.coreId = 0U;
    g_capture.deviceId = 0U;
    g_capture.consumedLenToReturn = consumedLenToReturn;
}

void ConstructSimdBlock(uint8_t* buf, size_t blockSize, uint64_t readIdx, uint64_t writeIdx, uint32_t coreId)
{
    BlockInfo* blockInfo = RtPtrToPtr<BlockInfo*>(buf);
    blockInfo->length = static_cast<uint32_t>(blockSize);
    blockInfo->coreId = coreId;
    blockInfo->blockNum = 1U;
    blockInfo->remainLen =
        static_cast<uint32_t>(blockSize - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo));
    blockInfo->magic = 0xAE86U;
    blockInfo->flag = 0U;

    BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(buf + sizeof(BlockInfo));
    readInfo->readIdx = readIdx;

    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(buf + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = writeIdx;
}

void ConstructSimtBlock(uint8_t* buf, size_t blockSize, uint64_t readIdx, uint64_t writeIdx)
{
    BlockInfo* blockInfo = RtPtrToPtr<BlockInfo*>(buf);
    blockInfo->length = static_cast<uint32_t>(blockSize);
    blockInfo->coreId = 0U;
    blockInfo->blockNum = 1U;
    blockInfo->remainLen =
        static_cast<uint32_t>(blockSize - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo));
    blockInfo->magic = 0xAE86U;
    blockInfo->flag = 2U;
    uint8_t* dataArea = buf + sizeof(BlockInfo) + sizeof(BlockReadInfo);
    blockInfo->dumpAddr = RtPtrToValue(dataArea);
    (void)memset_s(dataArea, blockInfo->remainLen, 0xAA, blockInfo->remainLen);

    BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(buf + sizeof(BlockInfo));
    readInfo->readIdx = readIdx;

    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(buf + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = writeIdx;
}
} // namespace

class ParsePrintfV2Test : public testing::Test {
protected:
    static void SetUpTestCase() {}

    static void TearDownTestCase() {}

    virtual void SetUp() { cmodelDrvMemcpy_flag = 1; }

    virtual void TearDown()
    {
        cmodelDrvMemcpy_flag = 0;
        (void)ParseKernelDfxInfo::Instance()->SetCallback(nullptr);
        ResetCapture(0U);
        rtDeviceReset(0);
    }
};

TEST_F(ParsePrintfV2Test, WhenHasData_ExpectCallbackCalled)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    auto props = dev->GetDevProperties();
    const uint64_t totalCoreNum = static_cast<uint64_t>(props.aicNum + props.aivNum);
    const size_t blockSize = 1024U * 1024U;
    const uint64_t totalLen = blockSize * totalCoreNum;
    std::vector<uint8_t> hostData(totalLen, 0);

    const uint64_t testReadIdx = 0U;
    const uint64_t testWriteIdx = 100U;
    const uint32_t testUserDeviceId = 42U;
    ConstructSimdBlock(hostData.data(), blockSize, testReadIdx, testWriteIdx, 0U);

    (void)ParseKernelDfxInfo::Instance()->SetCallback(nullptr);
    (void)ParseKernelDfxInfo::Instance()->SetCallback(TestParseDfxInfoCallback);
    ResetCapture(testWriteIdx);

    error = ParsePrintfV2(hostData.data(), blockSize, dev->driver_, testUserDeviceId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    EXPECT_TRUE(g_capture.called);
    EXPECT_EQ(g_capture.readIdx, testReadIdx);
    EXPECT_EQ(g_capture.writeIdx, testWriteIdx);
    EXPECT_EQ(g_capture.datalen, static_cast<uint64_t>(blockSize));
    EXPECT_EQ(g_capture.deviceId, testUserDeviceId);

    BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(hostData.data() + sizeof(BlockInfo));
    EXPECT_EQ(readInfo->readIdx, testReadIdx + testWriteIdx);
}

TEST_F(ParsePrintfV2Test, WhenNoData_ExpectCallbackNotCalled)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    auto props = dev->GetDevProperties();
    const uint64_t totalCoreNum = static_cast<uint64_t>(props.aicNum + props.aivNum);
    const size_t blockSize = 1024U * 1024U;
    const uint64_t totalLen = blockSize * totalCoreNum;
    std::vector<uint8_t> hostData(totalLen, 0);

    ConstructSimdBlock(hostData.data(), blockSize, 0U, 0U, 0U);

    (void)ParseKernelDfxInfo::Instance()->SetCallback(nullptr);
    (void)ParseKernelDfxInfo::Instance()->SetCallback(TestParseDfxInfoCallback);
    ResetCapture(0U);

    error = ParsePrintfV2(hostData.data(), blockSize, dev->driver_, 0U);
    EXPECT_EQ(error, RT_ERROR_NONE);

    EXPECT_FALSE(g_capture.called);
}

TEST_F(ParsePrintfV2Test, WhenNoCallback_ExpectReadIdxAdvance)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    auto props = dev->GetDevProperties();
    const uint64_t totalCoreNum = static_cast<uint64_t>(props.aicNum + props.aivNum);
    const size_t blockSize = 1024U * 1024U;
    const uint64_t totalLen = blockSize * totalCoreNum;
    std::vector<uint8_t> hostData(totalLen, 0);

    const uint64_t testWriteIdx = 100U;
    ConstructSimdBlock(hostData.data(), blockSize, 0U, testWriteIdx, 0U);

    (void)ParseKernelDfxInfo::Instance()->SetCallback(nullptr);
    ResetCapture(0U);

    error = ParsePrintfV2(hostData.data(), blockSize, dev->driver_, 0U);
    EXPECT_EQ(error, RT_ERROR_NONE);

    EXPECT_FALSE(g_capture.called);
    BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(hostData.data() + sizeof(BlockInfo));
    EXPECT_EQ(readInfo->readIdx, testWriteIdx);
}

TEST_F(ParsePrintfV2Test, WhenConsumedLenExceedsRemainLen_ExpectFullAdvance)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    auto props = dev->GetDevProperties();
    const uint64_t totalCoreNum = static_cast<uint64_t>(props.aicNum + props.aivNum);
    const size_t blockSize = 1024U * 1024U;
    const uint64_t totalLen = blockSize * totalCoreNum;
    std::vector<uint8_t> hostData(totalLen, 0);

    const uint64_t testReadIdx = 0U;
    const uint64_t testWriteIdx = 100U;
    ConstructSimdBlock(hostData.data(), blockSize, testReadIdx, testWriteIdx, 0U);

    BlockInfo* blockInfo = RtPtrToPtr<BlockInfo*>(hostData.data());
    const uint64_t excessiveConsumedLen = blockInfo->remainLen + 1000U;

    (void)ParseKernelDfxInfo::Instance()->SetCallback(nullptr);
    (void)ParseKernelDfxInfo::Instance()->SetCallback(TestParseDfxInfoCallback);
    ResetCapture(excessiveConsumedLen);

    error = ParsePrintfV2(hostData.data(), blockSize, dev->driver_, 0U);
    EXPECT_EQ(error, RT_ERROR_NONE);

    EXPECT_TRUE(g_capture.called);
    BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(hostData.data() + sizeof(BlockInfo));
    EXPECT_EQ(readInfo->readIdx, testWriteIdx);
}

TEST_F(ParsePrintfV2Test, WhenDrvNull_ExpectDrvNull)
{
    rtError_t error = ParsePrintfV2(nullptr, 0U, nullptr, 0U);
    EXPECT_EQ(error, RT_ERROR_DRV_NULL);
}

TEST_F(ParsePrintfV2Test, WhenReadIdxExceedsRemainLen_ExpectInvalidValue)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    auto props = dev->GetDevProperties();
    const uint64_t totalCoreNum = static_cast<uint64_t>(props.aicNum + props.aivNum);
    const size_t blockSize = 1024U * 1024U;
    const uint64_t totalLen = blockSize * totalCoreNum;
    std::vector<uint8_t> hostData(totalLen, 0);

    ConstructSimdBlock(hostData.data(), blockSize, 0U, 100U, 0U);
    BlockInfo* blockInfo = RtPtrToPtr<BlockInfo*>(hostData.data());
    BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(hostData.data() + sizeof(BlockInfo));
    readInfo->readIdx = static_cast<uint64_t>(blockInfo->remainLen) + 1U;

    error = ParsePrintfV2(hostData.data(), blockSize, dev->driver_, 0U);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(ParsePrintfV2Test, WhenWriteIdxExceedsRemainLen_ExpectInvalidValue)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    auto props = dev->GetDevProperties();
    const uint64_t totalCoreNum = static_cast<uint64_t>(props.aicNum + props.aivNum);
    const size_t blockSize = 1024U * 1024U;
    const uint64_t totalLen = blockSize * totalCoreNum;
    std::vector<uint8_t> hostData(totalLen, 0);

    ConstructSimdBlock(hostData.data(), blockSize, 0U, 100U, 0U);
    BlockInfo* blockInfo = RtPtrToPtr<BlockInfo*>(hostData.data());
    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(hostData.data() + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = static_cast<uint64_t>(blockInfo->remainLen) + 1U;

    error = ParsePrintfV2(hostData.data(), blockSize, dev->driver_, 0U);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(ParsePrintfV2Test, WhenConsumedLenZero_ExpectFullAdvance)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    auto props = dev->GetDevProperties();
    const uint64_t totalCoreNum = static_cast<uint64_t>(props.aicNum + props.aivNum);
    const size_t blockSize = 1024U * 1024U;
    const uint64_t totalLen = blockSize * totalCoreNum;
    std::vector<uint8_t> hostData(totalLen, 0);

    const uint64_t testReadIdx = 0U;
    const uint64_t testWriteIdx = 100U;
    ConstructSimdBlock(hostData.data(), blockSize, testReadIdx, testWriteIdx, 0U);

    (void)ParseKernelDfxInfo::Instance()->SetCallback(nullptr);
    (void)ParseKernelDfxInfo::Instance()->SetCallback(TestParseDfxInfoCallback);
    ResetCapture(0U);

    error = ParsePrintfV2(hostData.data(), blockSize, dev->driver_, 0U);
    EXPECT_EQ(error, RT_ERROR_NONE);

    EXPECT_TRUE(g_capture.called);
    BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(hostData.data() + sizeof(BlockInfo));
    EXPECT_EQ(readInfo->readIdx, testWriteIdx);
}

class ParseSimtPrintfV2Test : public testing::Test {
protected:
    static void SetUpTestCase() {}

    static void TearDownTestCase() {}

    virtual void SetUp() { cmodelDrvMemcpy_flag = 1; }

    virtual void TearDown()
    {
        cmodelDrvMemcpy_flag = 0;
        (void)ParseKernelDfxInfo::Instance()->SetCallback(nullptr);
        ResetCapture(0U);
        rtDeviceReset(0);
    }
};

TEST_F(ParseSimtPrintfV2Test, WhenHasData_ExpectCallbackCalled)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    const size_t blockSize = 1024U;
    std::vector<uint8_t> hostData(blockSize, 0);

    const uint64_t testReadIdx = 0U;
    const uint64_t testWriteIdx = 100U;
    const uint32_t testUserDeviceId = 42U;
    ConstructSimtBlock(hostData.data(), blockSize, testReadIdx, testWriteIdx);

    (void)ParseKernelDfxInfo::Instance()->SetCallback(nullptr);
    (void)ParseKernelDfxInfo::Instance()->SetCallback(TestParseDfxInfoCallback);
    ResetCapture(testWriteIdx);

    error = ParseSimtPrintfV2(hostData.data(), blockSize, dev->driver_, testUserDeviceId);
    EXPECT_EQ(error, RT_ERROR_NONE);

    EXPECT_TRUE(g_capture.called);
    EXPECT_EQ(g_capture.readIdx, testReadIdx);
    EXPECT_EQ(g_capture.writeIdx, testWriteIdx);
    EXPECT_EQ(g_capture.coreType, RT_KERNEL_DFX_INFO_CORE_TYPE_SIMT);
    EXPECT_EQ(g_capture.datalen, static_cast<uint64_t>(blockSize));
    EXPECT_EQ(g_capture.deviceId, testUserDeviceId);

    BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(hostData.data() + sizeof(BlockInfo));
    EXPECT_EQ(readInfo->readIdx, testReadIdx + testWriteIdx);
}

TEST_F(ParseSimtPrintfV2Test, WhenConsumedLenZero_ExpectNoAdvance)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    const size_t blockSize = 1024U;
    std::vector<uint8_t> hostData(blockSize, 0);

    const uint64_t testReadIdx = 0U;
    const uint64_t testWriteIdx = 100U;
    ConstructSimtBlock(hostData.data(), blockSize, testReadIdx, testWriteIdx);

    (void)ParseKernelDfxInfo::Instance()->SetCallback(nullptr);
    (void)ParseKernelDfxInfo::Instance()->SetCallback(TestParseDfxInfoCallback);
    ResetCapture(0U);

    error = ParseSimtPrintfV2(hostData.data(), blockSize, dev->driver_, 0U);
    EXPECT_EQ(error, RT_ERROR_NONE);

    EXPECT_TRUE(g_capture.called);
    BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(hostData.data() + sizeof(BlockInfo));
    EXPECT_EQ(readInfo->readIdx, testReadIdx);
}

TEST_F(ParseSimtPrintfV2Test, WhenNoCallback_ExpectReadIdxAdvance)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    const size_t blockSize = 1024U;
    std::vector<uint8_t> hostData(blockSize, 0);

    const uint64_t testWriteIdx = 100U;
    ConstructSimtBlock(hostData.data(), blockSize, 0U, testWriteIdx);

    (void)ParseKernelDfxInfo::Instance()->SetCallback(nullptr);
    ResetCapture(0U);

    error = ParseSimtPrintfV2(hostData.data(), blockSize, dev->driver_, 0U);
    EXPECT_EQ(error, RT_ERROR_NONE);

    EXPECT_FALSE(g_capture.called);
    BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(hostData.data() + sizeof(BlockInfo));
    EXPECT_EQ(readInfo->readIdx, testWriteIdx);
}

TEST_F(ParseSimtPrintfV2Test, WhenConsumedLenExceedsRemainLen_ExpectClamped)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    const size_t blockSize = 1024U;
    std::vector<uint8_t> hostData(blockSize, 0);

    const uint64_t testReadIdx = 0U;
    const uint64_t testWriteIdx = 100U;
    ConstructSimtBlock(hostData.data(), blockSize, testReadIdx, testWriteIdx);

    BlockInfo* blockInfo = RtPtrToPtr<BlockInfo*>(hostData.data());
    const uint64_t excessiveConsumedLen = blockInfo->remainLen + 1000U;

    (void)ParseKernelDfxInfo::Instance()->SetCallback(nullptr);
    (void)ParseKernelDfxInfo::Instance()->SetCallback(TestParseDfxInfoCallback);
    ResetCapture(excessiveConsumedLen);

    error = ParseSimtPrintfV2(hostData.data(), blockSize, dev->driver_, 0U);
    EXPECT_EQ(error, RT_ERROR_NONE);

    EXPECT_TRUE(g_capture.called);
    BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(hostData.data() + sizeof(BlockInfo));
    EXPECT_EQ(readInfo->readIdx, testReadIdx + testWriteIdx);
}

TEST_F(ParseSimtPrintfV2Test, WhenDrvNull_ExpectDrvNull)
{
    rtError_t error = ParseSimtPrintfV2(nullptr, 0U, nullptr, 0U);
    EXPECT_EQ(error, RT_ERROR_DRV_NULL);
}

TEST_F(ParseSimtPrintfV2Test, WhenReadIdxExceedsWriteIdx_ExpectInvalidValue)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    const size_t blockSize = 1024U;
    std::vector<uint8_t> hostData(blockSize, 0);

    ConstructSimtBlock(hostData.data(), blockSize, 200U, 100U);

    error = ParseSimtPrintfV2(hostData.data(), blockSize, dev->driver_, 0U);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST_F(ParseSimtPrintfV2Test, WhenNoData_ExpectCallbackNotCalled)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    RawDevice* dev = (RawDevice*)rtInstance->GetDevice(0U, 0U);
    const size_t blockSize = 1024U;
    std::vector<uint8_t> hostData(blockSize, 0);

    ConstructSimtBlock(hostData.data(), blockSize, 0U, 0U);

    (void)ParseKernelDfxInfo::Instance()->SetCallback(nullptr);
    (void)ParseKernelDfxInfo::Instance()->SetCallback(TestParseDfxInfoCallback);
    ResetCapture(0U);

    error = ParseSimtPrintfV2(hostData.data(), blockSize, dev->driver_, 0U);
    EXPECT_EQ(error, RT_ERROR_NONE);

    EXPECT_FALSE(g_capture.called);
}
