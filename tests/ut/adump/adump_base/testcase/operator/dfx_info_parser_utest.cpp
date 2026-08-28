/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <gtest/gtest.h>
#include <cstring>
#include <vector>
#include <limits>
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#include "case_workspace.h"
#include "mmpa_api.h"
#include "path.h"
#include "utils.h"
#define protected public
#define private public

#include "dfx_info_parser.h"
#include "kernel_dfx_dumper.h"
#include "dfx_struct.h"
#include "rt_inner_dfx.h"
#include "aprof_pub.h"

using namespace Adx;
using cce::runtime::BlockInfo;
using cce::runtime::BlockReadInfo;
using cce::runtime::BlockWriteInfo;
using cce::runtime::DumpInfoHead;
using cce::runtime::DumpShapeInfo;
using cce::runtime::DumpTensorInfo;
using cce::runtime::DumpTimeStampInfoMsg;

namespace Adx {
void ParseDfxInfoCallback(const rtDfxParseParam* param, uint64_t* consumedLen);
}

static constexpr uint32_t PRINT_ARG_LEN = 8U;
static constexpr uint32_t RESV_LEN = 8U;
static constexpr uint32_t RESV_LEN_SIMT = 40U;

static INT32 MmGetDiskFreeSpaceSuccessStub(const char*, mmDiskSize* diskSize)
{
    diskSize->availSize = 2U * 1024U * 1024U;
    diskSize->freeSize = 2U * 1024U * 1024U;
    return EN_OK;
}

static DumpInfoHead* WriteTlv(uint8_t* buf, cce::runtime::DumpType type, uint32_t infoLen)
{
    DumpInfoHead* head = reinterpret_cast<DumpInfoHead*>(buf);
    head->type = type;
    head->infoLen = infoLen;
    return head;
}

class DfxInfoParserUtest : public testing::Test {
protected:
    virtual void SetUp() { KernelDfxDumper::Instance().UnInit(); }
    virtual void TearDown()
    {
        DfxInfoParser::Instance().UnInit();
        KernelDfxDumper::Instance().UnInit();
        GlobalMockObject::verify();
    }

    struct BlockBuffer {
        std::vector<uint8_t> data;
        uint8_t* blockAddr;
        BlockInfo* blockInfo;
        uint8_t* dumpStartAddr;
        uint32_t remainLen;

        BlockBuffer(uint32_t dataAreaSize) : remainLen(dataAreaSize)
        {
            uint32_t totalSize = sizeof(BlockInfo) + sizeof(BlockReadInfo) + dataAreaSize + sizeof(BlockWriteInfo);
            data.resize(totalSize, 0);
            blockAddr = data.data();
            blockInfo = reinterpret_cast<BlockInfo*>(blockAddr);
            blockInfo->remainLen = dataAreaSize;
            blockInfo->magic = 0xAE86U;
            dumpStartAddr = blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo);
        }
    };

    static uint32_t BuildPrintfTlv(uint8_t* buf, const std::string& msg, bool isSimt = false)
    {
        uint32_t resvOffset = isSimt ? RESV_LEN_SIMT : RESV_LEN;
        DumpInfoHead* head =
            WriteTlv(buf, isSimt ? cce::runtime::DumpType::DUMP_SIMT_PRINTF : cce::runtime::DumpType::DUMP_SCALAR, 0);
        uint8_t* infoMsg = head->infoMsg;
        (void)memset_s(infoMsg, resvOffset, 0, resvOffset);
        uint64_t strOffset = PRINT_ARG_LEN;
        (void)memcpy_s(infoMsg + resvOffset, sizeof(uint64_t), &strOffset, sizeof(uint64_t));
        (void)memcpy_s(infoMsg + resvOffset + strOffset, msg.size() + 1, msg.c_str(), msg.size() + 1);
        head->infoLen = resvOffset + sizeof(uint64_t) + msg.size() + 1;
        return sizeof(DumpInfoHead) + head->infoLen;
    }

    static uint32_t BuildAssertTlv(uint8_t* buf, const std::string& msg, bool isSimt = false)
    {
        uint32_t resvOffset = isSimt ? RESV_LEN_SIMT : RESV_LEN;
        DumpInfoHead* head =
            WriteTlv(buf, isSimt ? cce::runtime::DumpType::DUMP_SIMT_ASSERT : cce::runtime::DumpType::DUMP_ASSERT, 0);
        uint8_t* infoMsg = head->infoMsg;
        (void)memset_s(infoMsg, resvOffset, 0, resvOffset);
        uint64_t strOffset = PRINT_ARG_LEN;
        (void)memcpy_s(infoMsg + resvOffset, sizeof(uint64_t), &strOffset, sizeof(uint64_t));
        (void)memcpy_s(infoMsg + resvOffset + strOffset, msg.size() + 1, msg.c_str(), msg.size() + 1);
        head->infoLen = resvOffset + sizeof(uint64_t) + msg.size() + 1;
        return sizeof(DumpInfoHead) + head->infoLen;
    }

    static uint32_t BuildTimestampTlv(uint8_t* buf)
    {
        DumpInfoHead* head = WriteTlv(buf, cce::runtime::DumpType::DUMP_TIMESTAMP, sizeof(DumpTimeStampInfoMsg));
        DumpTimeStampInfoMsg* tsMsg = reinterpret_cast<DumpTimeStampInfoMsg*>(head->infoMsg);
        tsMsg->descId = 1U;
        tsMsg->blockIdx = 0U;
        tsMsg->rsv = 0U;
        tsMsg->syscyc = 1000U;
        tsMsg->curPc = 0x2000U;
        tsMsg->entry = 0x3000U;
        return sizeof(DumpInfoHead) + sizeof(DumpTimeStampInfoMsg);
    }

    static uint32_t BuildShapeTlv(uint8_t* buf, uint32_t dim, const uint32_t* shape)
    {
        DumpInfoHead* head = WriteTlv(buf, cce::runtime::DumpType::DUMP_SHAPE, sizeof(DumpShapeInfo));
        DumpShapeInfo* shapeInfo = reinterpret_cast<DumpShapeInfo*>(head->infoMsg);
        shapeInfo->dim = dim;
        for (uint32_t i = 0; i < dim && i < cce::runtime::RT_DUMP_SHAPE_MAX_SIZE; ++i) {
            shapeInfo->shape[i] = shape[i];
        }
        return sizeof(DumpInfoHead) + sizeof(DumpShapeInfo);
    }

    static uint32_t BuildTensorTlv(
        uint8_t* buf, uint32_t dataType, uint32_t dumpSize, const uint8_t* tensorData, size_t tensorDataLen)
    {
        DumpInfoHead* head = WriteTlv(buf, cce::runtime::DumpType::DUMP_TENSOR, sizeof(DumpTensorInfo) + tensorDataLen);
        DumpTensorInfo* tensorInfo = reinterpret_cast<DumpTensorInfo*>(head->infoMsg);
        tensorInfo->addr = 0x400U;
        tensorInfo->dataType = dataType;
        tensorInfo->desc = 100U;
        tensorInfo->position = 0U;
        tensorInfo->blockIdx = 0U;
        tensorInfo->dim = 0U;
        tensorInfo->dumpSize = dumpSize;
        if (tensorData != nullptr && tensorDataLen > 0) {
            (void)memcpy_s(head->infoMsg + sizeof(DumpTensorInfo), tensorDataLen, tensorData, tensorDataLen);
        }
        return sizeof(DumpInfoHead) + sizeof(DumpTensorInfo) + tensorDataLen;
    }

    static uint32_t BuildSkipTlv(uint8_t* buf)
    {
        WriteTlv(buf, cce::runtime::DumpType::DUMP_SKIP, 0);
        return sizeof(DumpInfoHead);
    }

    static uint32_t BuildWaitTlv(uint8_t* buf)
    {
        WriteTlv(buf, cce::runtime::DumpType::DUMP_WAIT, 0);
        return sizeof(DumpInfoHead);
    }

    static uint32_t BuildInvalidTypeTlv(uint8_t* buf)
    {
        WriteTlv(buf, static_cast<cce::runtime::DumpType>(0xFFFF), 0);
        return sizeof(DumpInfoHead);
    }

    static void WriteRingData(BlockBuffer& block, uint32_t startOffset, const uint8_t* source, uint32_t dataLen)
    {
        ASSERT_LT(startOffset, block.remainLen);
        ASSERT_LE(dataLen, block.remainLen);
        const uint32_t tailLen = block.remainLen - startOffset;
        const uint32_t firstLen = dataLen < tailLen ? dataLen : tailLen;
        errno_t ret = memcpy_s(block.dumpStartAddr + startOffset, firstLen, source, firstLen);
        ASSERT_EQ(ret, EOK);
        if (dataLen > firstLen) {
            const uint32_t secondLen = dataLen - firstLen;
            ret = memcpy_s(block.dumpStartAddr, secondLen, source + firstLen, secondLen);
            ASSERT_EQ(ret, EOK);
        }
    }

    static rtDfxParseParam MakeParam(
        void* data, uint64_t datalen, uint64_t readIdx, uint64_t writeIdx, uint32_t coreType = 0U, uint32_t coreId = 0U)
    {
        rtDfxParseParam param;
        param.data = data;
        param.datalen = datalen;
        param.readIdx = readIdx;
        param.writeIdx = writeIdx;
        param.coreType = coreType;
        param.coreId = coreId;
        param.deviceId = 0U;
        return param;
    }
};

TEST_F(DfxInfoParserUtest, Test_Init_Success)
{
    int32_t ret = DfxInfoParser::Instance().Init();
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_EQ(DfxInfoParser::Instance().registered_, true);
}

TEST_F(DfxInfoParserUtest, Test_Init_AlreadyRegistered)
{
    DfxInfoParser::Instance().Init();
    int32_t ret = DfxInfoParser::Instance().Init();
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_EQ(DfxInfoParser::Instance().registered_, true);
}

TEST_F(DfxInfoParserUtest, Test_UnInit_Success)
{
    DfxInfoParser::Instance().Init();
    DfxInfoParser::Instance().UnInit();
    EXPECT_EQ(DfxInfoParser::Instance().registered_, false);
}

TEST_F(DfxInfoParserUtest, Test_UnInit_NotRegistered)
{
    DfxInfoParser::Instance().registered_ = false;
    DfxInfoParser::Instance().UnInit();
    EXPECT_EQ(DfxInfoParser::Instance().registered_, false);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_NullParam)
{
    uint64_t consumedLen = 0U;
    DfxInfoParser::Instance().ParseDfxInfo(nullptr, &consumedLen);
    EXPECT_EQ(consumedLen, 0U);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_NullData)
{
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(nullptr, 0, 0, 0);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, 0U);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_ZeroDatalen)
{
    BlockBuffer block(128);
    uint64_t consumedLen = 99U;
    rtDfxParseParam param = MakeParam(block.blockAddr, 0, 0, 0);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, 0U);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_DatalenShorterThanBlockInfo)
{
    std::vector<uint8_t> data(sizeof(BlockInfo) - 1U, 0U);
    uint64_t consumedLen = 99U;
    rtDfxParseParam param = MakeParam(data.data(), data.size(), 0U, 1U);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, 0U);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_DatalenDoesNotCoverBlockMetadata)
{
    constexpr size_t metadataLen = sizeof(BlockInfo) + sizeof(BlockReadInfo) + sizeof(BlockWriteInfo);
    std::vector<uint8_t> data(metadataLen - 1U, 0U);
    uint64_t consumedLen = 99U;
    rtDfxParseParam param = MakeParam(data.data(), data.size(), 0U, 1U);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, 0U);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_RemainLenExceedsDataArea)
{
    constexpr uint32_t dataAreaSize = 8U;
    BlockBuffer block(dataAreaSize);
    block.blockInfo->remainLen = dataAreaSize + 1U;
    uint64_t consumedLen = 99U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0U, 1U);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, 0U);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_ReadIdxGreaterThanWriteIdx)
{
    BlockBuffer block(128U);
    uint64_t consumedLen = 99U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 2U, 1U, 2U, 0U);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, 0U);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SimtAbsoluteIndicesAfterWraparound)
{
    constexpr uint32_t remainLen = 128U;
    constexpr uint32_t dataOffset = 10U;
    BlockBuffer block(remainLen);
    const uint32_t tlvLen = BuildPrintfTlv(block.dumpStartAddr + dataOffset, "absolute index", true);
    const uint64_t readIdx = remainLen + dataOffset;
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), readIdx, readIdx + tlvLen, 2U, 0U);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_NullConsumedLen)
{
    BlockBuffer block(128);
    uint8_t buf[] = "test";
    uint32_t tlvLen = BuildPrintfTlv(block.dumpStartAddr, "hello");
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, nullptr);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_RemainLenZero)
{
    std::vector<uint8_t> data(sizeof(BlockInfo) + sizeof(BlockReadInfo) + 64, 0);
    BlockInfo* blockInfo = reinterpret_cast<BlockInfo*>(data.data());
    blockInfo->remainLen = 0U;
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(data.data(), data.size(), 0, 10);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, 0U);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_NoData_ReadEqWrite)
{
    BlockBuffer block(128);
    uint64_t consumedLen = 99U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, 0);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, 0U);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_Normal_Printf)
{
    BlockBuffer block(256);
    uint32_t tlvLen = BuildPrintfTlv(block.dumpStartAddr, "hello world");
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_Normal_Assert)
{
    BlockBuffer block(256);
    uint32_t tlvLen = BuildAssertTlv(block.dumpStartAddr, "assert failed");
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_Normal_Timestamp)
{
    BlockBuffer block(256);
    uint32_t tlvLen = BuildTimestampTlv(block.dumpStartAddr);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_Normal_Shape)
{
    BlockBuffer block(256);
    uint32_t shape[] = {2, 3};
    uint32_t tlvLen = BuildShapeTlv(block.dumpStartAddr, 2, shape);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_Normal_Tensor)
{
    BlockBuffer block(512);
    uint8_t tensorData[] = {1, 2, 3, 4};
    uint32_t tlvLen = BuildTensorTlv(block.dumpStartAddr, 4U, sizeof(tensorData), tensorData, sizeof(tensorData));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_Normal_Skip)
{
    BlockBuffer block(128);
    uint32_t tlvLen = BuildSkipTlv(block.dumpStartAddr);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_Normal_InvalidType)
{
    BlockBuffer block(128);
    uint32_t tlvLen = BuildInvalidTypeTlv(block.dumpStartAddr);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_Simt_Printf)
{
    BlockBuffer block(256);
    uint32_t tlvLen = BuildPrintfTlv(block.dumpStartAddr, "simt hello", true);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen, 2U, 0U);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_Simt_Assert)
{
    BlockBuffer block(256);
    uint32_t tlvLen = BuildAssertTlv(block.dumpStartAddr, "simt assert", true);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen, 2U, 0U);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_Simt_Wait)
{
    BlockBuffer block(128);
    uint32_t tlvLen = BuildWaitTlv(block.dumpStartAddr);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen, 2U, 0U);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, 0U);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_Simt_InvalidTypeThenPrintf)
{
    BlockBuffer block(256);
    uint32_t off = BuildInvalidTypeTlv(block.dumpStartAddr);
    off += BuildPrintfTlv(block.dumpStartAddr + off, "after invalid type", true);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0U, off, 2U, 0U);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, off);
    EXPECT_NE(output.find("after invalid type"), std::string::npos);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_Simt_InvalidType)
{
    BlockBuffer block(128);
    uint32_t tlvLen = BuildInvalidTypeTlv(block.dumpStartAddr);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen, 2U, 0U);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SimtPartialHeader)
{
    BlockBuffer block(128);
    constexpr uint32_t partialHeaderLen = sizeof(uint32_t);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, partialHeaderLen, 2U, 0U);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, 0U);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SimtWraparoundPartialHeaderAfterCompleteTlv)
{
    constexpr uint32_t remainLen = 128U;
    constexpr uint32_t partialHeaderLen = sizeof(uint32_t);
    BlockBuffer block(remainLen);
    std::vector<uint8_t> input(remainLen, 0xABU);
    const uint32_t tlvLen = BuildPrintfTlv(input.data(), "complete", true);
    const uint32_t totalLen = tlvLen + partialHeaderLen;
    const uint32_t readOff = remainLen - 16U;
    const uint32_t firstPartLen = remainLen - readOff;
    const uint32_t secondPartLen = totalLen - firstPartLen;
    ASSERT_EQ(memcpy_s(block.dumpStartAddr + readOff, firstPartLen, input.data(), firstPartLen), EOK);
    ASSERT_EQ(memcpy_s(block.dumpStartAddr, secondPartLen, input.data() + firstPartLen, secondPartLen), EOK);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), readOff, readOff + totalLen, 2U, 0U);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_Overflow)
{
    uint32_t remainLen = 128;
    BlockBuffer block(remainLen);
    uint32_t tlvLen = BuildPrintfTlv(block.dumpStartAddr, "overflow test");
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, remainLen + 10);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, remainLen + 10);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_ExactlyFullPreservesContentOrder)
{
    std::vector<uint8_t> input(256U, 0U);
    uint32_t totalLen = BuildPrintfTlv(input.data(), "full first", true);
    totalLen += BuildPrintfTlv(input.data() + totalLen, "full second", true);
    BlockBuffer block(totalLen);
    constexpr uint32_t startOffset = 11U;
    WriteRingData(block, startOffset, input.data(), totalLen);

    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), startOffset, startOffset + totalLen, 2U, 0U);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    const size_t firstPos = output.find("full first");
    const size_t secondPos = output.find("full second");
    EXPECT_EQ(consumedLen, totalLen);
    ASSERT_NE(firstPos, std::string::npos);
    ASSERT_NE(secondPos, std::string::npos);
    EXPECT_LT(firstPos, secondPos);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_OverwritePreservesRetainedContentOrder)
{
    std::vector<uint8_t> input(256U, 0U);
    uint32_t totalLen = BuildPrintfTlv(input.data(), "overwrite first", true);
    totalLen += BuildPrintfTlv(input.data() + totalLen, "overwrite second", true);
    BlockBuffer block(totalLen);
    constexpr uint32_t startOffset = 13U;
    WriteRingData(block, startOffset, input.data(), totalLen);

    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0U, totalLen + startOffset, 2U, 0U);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    const size_t firstPos = output.find("overwrite first");
    const size_t secondPos = output.find("overwrite second");
    EXPECT_EQ(consumedLen, totalLen);
    ASSERT_NE(firstPos, std::string::npos);
    ASSERT_NE(secondPos, std::string::npos);
    EXPECT_LT(firstPos, secondPos);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_Wraparound)
{
    uint32_t remainLen = 256;
    BlockBuffer block(remainLen);
    uint32_t tlvLen = BuildPrintfTlv(block.dumpStartAddr + 200, "wrap data");
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 200, 200 + tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_Wraparound_CrossBoundary)
{
    uint32_t remainLen = 256;
    BlockBuffer block(remainLen);
    std::vector<uint8_t> tlvBuf(64, 0);
    uint32_t tlvLen = BuildPrintfTlv(tlvBuf.data(), "wrap");
    uint32_t readOff = remainLen - 16;
    uint32_t firstPartLen = remainLen - readOff;
    uint32_t secondPartLen = tlvLen - firstPartLen;
    (void)memcpy_s(block.dumpStartAddr + readOff, firstPartLen, tlvBuf.data(), firstPartLen);
    (void)memcpy_s(block.dumpStartAddr, secondPartLen, tlvBuf.data() + firstPartLen, secondPartLen);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), readOff, readOff + tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_TruncatedTlv)
{
    uint32_t remainLen = 64;
    BlockBuffer block(remainLen);
    DumpInfoHead* head = WriteTlv(block.dumpStartAddr, cce::runtime::DumpType::DUMP_SCALAR, 200);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, sizeof(DumpInfoHead) + 10);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, sizeof(DumpInfoHead) + 10);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_MultipleTlvs)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    off += BuildPrintfTlv(block.dumpStartAddr + off, "first");
    off += BuildSkipTlv(block.dumpStartAddr + off);
    off += BuildPrintfTlv(block.dumpStartAddr + off, "second");
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, off);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_ShapeThenTensor)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    uint32_t shape[] = {2, 2};
    off += BuildShapeTlv(block.dumpStartAddr + off, 2, shape);
    uint8_t tensorData[] = {10, 20, 30, 40};
    off += BuildTensorTlv(block.dumpStartAddr + off, 4U, sizeof(tensorData), tensorData, sizeof(tensorData));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, off);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_TensorInfoLenTooSmall)
{
    BlockBuffer block(256);
    DumpInfoHead* head = WriteTlv(block.dumpStartAddr, cce::runtime::DumpType::DUMP_TENSOR, 2);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, sizeof(DumpInfoHead) + 2);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, sizeof(DumpInfoHead) + 2);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_TensorUnsupportedDataType)
{
    BlockBuffer block(256);
    DumpInfoHead* head = WriteTlv(block.dumpStartAddr, cce::runtime::DumpType::DUMP_TENSOR, sizeof(DumpTensorInfo));
    DumpTensorInfo* tensorInfo = reinterpret_cast<DumpTensorInfo*>(head->infoMsg);
    tensorInfo->dataType = 999U;
    tensorInfo->dumpSize = 0U;
    uint64_t consumedLen = 0U;
    rtDfxParseParam param =
        MakeParam(block.blockAddr, block.data.size(), 0, sizeof(DumpInfoHead) + sizeof(DumpTensorInfo));
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, sizeof(DumpInfoHead) + sizeof(DumpTensorInfo));
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_TimestampInfoLenTooSmall)
{
    BlockBuffer block(128);
    DumpInfoHead* head = WriteTlv(block.dumpStartAddr, cce::runtime::DumpType::DUMP_TIMESTAMP, 4);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, sizeof(DumpInfoHead) + 4);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, sizeof(DumpInfoHead) + 4);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_ShapeInfoLenTooSmall)
{
    BlockBuffer block(128);
    DumpInfoHead* head = WriteTlv(block.dumpStartAddr, cce::runtime::DumpType::DUMP_SHAPE, 4);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, sizeof(DumpInfoHead) + 4);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, sizeof(DumpInfoHead) + 4);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_ShapeDimExceedsMax)
{
    BlockBuffer block(256);
    DumpInfoHead* head = WriteTlv(block.dumpStartAddr, cce::runtime::DumpType::DUMP_SHAPE, sizeof(DumpShapeInfo));
    DumpShapeInfo* shapeInfo = reinterpret_cast<DumpShapeInfo*>(head->infoMsg);
    shapeInfo->dim = cce::runtime::RT_DUMP_SHAPE_MAX_SIZE + 1;
    uint64_t consumedLen = 0U;
    rtDfxParseParam param =
        MakeParam(block.blockAddr, block.data.size(), 0, sizeof(DumpInfoHead) + sizeof(DumpShapeInfo));
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, sizeof(DumpInfoHead) + sizeof(DumpShapeInfo));
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfInfoLenTooSmall)
{
    BlockBuffer block(128);
    DumpInfoHead* head = WriteTlv(block.dumpStartAddr, cce::runtime::DumpType::DUMP_SCALAR, 4);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, sizeof(DumpInfoHead) + 4);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, sizeof(DumpInfoHead) + 4);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfStrOffsetTooSmall)
{
    BlockBuffer block(128);
    constexpr uint32_t infoLen = RESV_LEN + PRINT_ARG_LEN;
    DumpInfoHead* head = WriteTlv(block.dumpStartAddr, cce::runtime::DumpType::DUMP_SCALAR, infoLen);
    (void)memset_s(head->infoMsg, infoLen, 0, infoLen);
    const uint64_t strOffset = PRINT_ARG_LEN - 1U;
    (void)memcpy_s(head->infoMsg + RESV_LEN, sizeof(uint64_t), &strOffset, sizeof(uint64_t));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, sizeof(DumpInfoHead) + infoLen);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, sizeof(DumpInfoHead) + infoLen);
    EXPECT_NE(output.find("Invalid print strOffset[7]"), std::string::npos);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfStrOffsetTooLarge)
{
    BlockBuffer block(128);
    constexpr uint32_t infoLen = RESV_LEN + PRINT_ARG_LEN;
    DumpInfoHead* head = WriteTlv(block.dumpStartAddr, cce::runtime::DumpType::DUMP_SCALAR, infoLen);
    (void)memset_s(head->infoMsg, infoLen, 0, infoLen);
    const uint64_t strOffset = PRINT_ARG_LEN + 1U;
    (void)memcpy_s(head->infoMsg + RESV_LEN, sizeof(uint64_t), &strOffset, sizeof(uint64_t));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, sizeof(DumpInfoHead) + infoLen);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, sizeof(DumpInfoHead) + infoLen);
    EXPECT_NE(output.find("Invalid print strOffset[9]"), std::string::npos);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfStrLenEqualsInfoLen)
{
    BlockBuffer block(256);
    DumpInfoHead* head = WriteTlv(block.dumpStartAddr, cce::runtime::DumpType::DUMP_SCALAR, 0);
    uint8_t* infoMsg = head->infoMsg;
    ASSERT_EQ(memset_s(infoMsg, RESV_LEN, 0, RESV_LEN), EOK);
    uint64_t strOffset = PRINT_ARG_LEN;
    ASSERT_EQ(memcpy_s(infoMsg + RESV_LEN, sizeof(uint64_t), &strOffset, sizeof(uint64_t)), EOK);
    const std::string unterminatedFormat(20U, 'A');
    ASSERT_EQ(
        memcpy_s(
            infoMsg + RESV_LEN + strOffset, unterminatedFormat.size(), unterminatedFormat.data(),
            unterminatedFormat.size()),
        EOK);
    head->infoLen = RESV_LEN + sizeof(uint64_t) + 20;
    ASSERT_EQ(strnlen(reinterpret_cast<const char*>(infoMsg + RESV_LEN + strOffset), 20U), 20U);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, sizeof(DumpInfoHead) + head->infoLen);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, sizeof(DumpInfoHead) + head->infoLen);
    EXPECT_NE(output.find("Print str len is greater than or equal to max length"), std::string::npos) << output;
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfWithArgs)
{
    BlockBuffer block(256);
    DumpInfoHead* head = WriteTlv(block.dumpStartAddr, cce::runtime::DumpType::DUMP_SCALAR, 0);
    uint8_t* infoMsg = head->infoMsg;
    (void)memset_s(infoMsg, RESV_LEN, 0, RESV_LEN);
    uint64_t strOffset = 2 * PRINT_ARG_LEN;
    (void)memcpy_s(infoMsg + RESV_LEN, sizeof(uint64_t), &strOffset, sizeof(uint64_t));
    int64_t argVal = 42;
    (void)memcpy_s(infoMsg + RESV_LEN + PRINT_ARG_LEN, sizeof(int64_t), &argVal, sizeof(int64_t));
    const char* fmt = "value=%d";
    (void)memcpy_s(infoMsg + RESV_LEN + strOffset, strlen(fmt) + 1, fmt, strlen(fmt) + 1);
    head->infoLen = RESV_LEN + strOffset + strlen(fmt) + 1;
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, sizeof(DumpInfoHead) + head->infoLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, sizeof(DumpInfoHead) + head->infoLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfIllegalFormat)
{
    BlockBuffer block(256);
    DumpInfoHead* head = WriteTlv(block.dumpStartAddr, cce::runtime::DumpType::DUMP_SCALAR, 0);
    uint8_t* infoMsg = head->infoMsg;
    (void)memset_s(infoMsg, RESV_LEN, 0, RESV_LEN);
    uint64_t strOffset = PRINT_ARG_LEN;
    (void)memcpy_s(infoMsg + RESV_LEN, sizeof(uint64_t), &strOffset, sizeof(uint64_t));
    const char* fmt = "bad %z format";
    (void)memcpy_s(infoMsg + RESV_LEN + strOffset, strlen(fmt) + 1, fmt, strlen(fmt) + 1);
    head->infoLen = RESV_LEN + sizeof(uint64_t) + strlen(fmt) + 1;
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, sizeof(DumpInfoHead) + head->infoLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, sizeof(DumpInfoHead) + head->infoLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfTooManyPlaceholders)
{
    BlockBuffer block(256);
    DumpInfoHead* head = WriteTlv(block.dumpStartAddr, cce::runtime::DumpType::DUMP_SCALAR, 0);
    uint8_t* infoMsg = head->infoMsg;
    (void)memset_s(infoMsg, RESV_LEN, 0, RESV_LEN);
    uint64_t strOffset = PRINT_ARG_LEN;
    (void)memcpy_s(infoMsg + RESV_LEN, sizeof(uint64_t), &strOffset, sizeof(uint64_t));
    const char* fmt = "%d %d %d";
    (void)memcpy_s(infoMsg + RESV_LEN + strOffset, strlen(fmt) + 1, fmt, strlen(fmt) + 1);
    head->infoLen = RESV_LEN + sizeof(uint64_t) + strlen(fmt) + 1;
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, sizeof(DumpInfoHead) + head->infoLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, sizeof(DumpInfoHead) + head->infoLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_Simt_ConsumedLen)
{
    BlockBuffer block(256);
    uint32_t tlvLen = BuildPrintfTlv(block.dumpStartAddr, "simt", true);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen, 2U, 0U);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_DumpKernelDfxInfoBlock_NullParam)
{
    KernelDfxDumper::Instance().DumpKernelDfxInfoBlock(nullptr, nullptr, 0);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_DumpKernelDfxInfoBlock_NullBuffer)
{
    rtDfxParseParam param = MakeParam(nullptr, 0, 0, 0);
    KernelDfxDumper::Instance().DumpKernelDfxInfoBlock(&param, nullptr, 0);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_DumpKernelDfxInfoBlock_UnknownCoreType)
{
    uint8_t buffer[] = "test";
    rtDfxParseParam param = MakeParam(nullptr, 0, 0, 0, 99U, 0U);
    KernelDfxDumper::Instance().DumpKernelDfxInfoBlock(&param, buffer, sizeof(buffer));
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_DumpKernelDfxInfoBlock_Success)
{
    Tools::CaseWorkspace workspace("Test_DfxParser_DumpBlock");
    DumpDfxConfig config;
    config.dfxTypes.push_back("printf");
    config.dumpPath = workspace.Root() + "/ascendDumpPath";
    ASSERT_EQ(KernelDfxDumper::Instance().EnableDfxDumper(config), ADUMP_SUCCESS);
    ASSERT_TRUE(KernelDfxDumper::Instance().IsEnabled(RT_KERNEL_DFX_INFO_BLOCK_INFO));

    BlockBuffer block(256);
    const uint32_t tlvLen = BuildPrintfTlv(block.dumpStartAddr, "dump block test");
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen, 0U, 0U);
    const Path dumpFile = Path(KernelDfxDumper::Instance().dumpPath_).Concat("asc_kernel_data_aic_0.bin");
    const std::string expectedContent(reinterpret_cast<const char*>(block.dumpStartAddr), tlvLen);
    MOCKER(mmGetDiskFreeSpace).stubs().will(invoke(MmGetDiskFreeSpaceSuccessStub));

    KernelDfxDumper::Instance().DumpKernelDfxInfoBlock(&param, block.dumpStartAddr, tlvLen);

    KernelDfxDumper::Instance().UnInitTask();
    while (KernelDfxDumper::Instance().taskRunning_) {
        usleep(100000U);
    }

    ASSERT_TRUE(dumpFile.Exist());
    const std::string actualContent = ReadFileToString(dumpFile.GetString());
    ASSERT_EQ(actualContent.size(), tlvLen);
    EXPECT_EQ(actualContent, expectedContent);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_TensorWithShapeAndData)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    uint32_t shape[] = {2, 3};
    off += BuildShapeTlv(block.dumpStartAddr + off, 2, shape);
    uint8_t tensorData[] = {1, 2, 3, 4, 5, 6};
    off += BuildTensorTlv(block.dumpStartAddr + off, 4U, sizeof(tensorData), tensorData, sizeof(tensorData));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, off);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_TensorShapeDimZero)
{
    BlockBuffer block(256);
    DumpInfoHead* head = WriteTlv(block.dumpStartAddr, cce::runtime::DumpType::DUMP_TENSOR, sizeof(DumpTensorInfo));
    DumpTensorInfo* tensorInfo = reinterpret_cast<DumpTensorInfo*>(head->infoMsg);
    tensorInfo->dataType = 4U;
    tensorInfo->dim = 0U;
    tensorInfo->dumpSize = 8U;
    uint64_t consumedLen = 0U;
    rtDfxParseParam param =
        MakeParam(block.blockAddr, block.data.size(), 0, sizeof(DumpInfoHead) + sizeof(DumpTensorInfo));
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, sizeof(DumpInfoHead) + sizeof(DumpTensorInfo));
    EXPECT_NE(output.find("exceeds available data size[0 bytes]"), std::string::npos);
    EXPECT_NE(output.find("dump_size=0"), std::string::npos);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_EmptyNumericTensorPrintsClosedBrackets)
{
    BlockBuffer block(256);
    const uint32_t tlvLen = BuildTensorTlv(block.dumpStartAddr, 4U, 0U, nullptr, 0U);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, tlvLen);
    EXPECT_NE(output.find("dump_size=0"), std::string::npos);
    EXPECT_NE(output.find("\n[]\n"), std::string::npos);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_EmptyBoolTensorPrintsClosedBrackets)
{
    BlockBuffer block(256);
    const uint32_t tlvLen = BuildTensorTlv(block.dumpStartAddr, 12U, 0U, nullptr, 0U);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, tlvLen);
    EXPECT_NE(output.find("dump_size=0"), std::string::npos);
    EXPECT_NE(output.find("\n[]\n"), std::string::npos);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_TensorDumpSizeExceedsAvailableDataWithShape)
{
    BlockBuffer block(512);
    uint32_t off = 0U;
    uint32_t shape[] = {2U, 2U};
    off += BuildShapeTlv(block.dumpStartAddr + off, 2U, shape);
    uint8_t tensorData[] = {1U, 2U};
    off += BuildTensorTlv(block.dumpStartAddr + off, 4U, 4U, tensorData, sizeof(tensorData));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, off);
    EXPECT_NE(output.find("exceeds available data size[2 bytes]"), std::string::npos);
    EXPECT_NE(output.find("[[1,2],\n[-,-]]"), std::string::npos);
    EXPECT_EQ(output.find("[[1,2],\n[0,0]]"), std::string::npos);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_TensorShapeDimExceedsMax)
{
    BlockBuffer block(256);
    DumpInfoHead* head = WriteTlv(block.dumpStartAddr, cce::runtime::DumpType::DUMP_TENSOR, sizeof(DumpTensorInfo));
    DumpTensorInfo* tensorInfo = reinterpret_cast<DumpTensorInfo*>(head->infoMsg);
    tensorInfo->dataType = 4U;
    tensorInfo->dim = cce::runtime::RT_DUMP_SHAPE_MAX_SIZE + 1;
    tensorInfo->dumpSize = 0U;
    uint64_t consumedLen = 0U;
    rtDfxParseParam param =
        MakeParam(block.blockAddr, block.data.size(), 0, sizeof(DumpInfoHead) + sizeof(DumpTensorInfo));
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, sizeof(DumpInfoHead) + sizeof(DumpTensorInfo));
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_TensorShapeZeroValue)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    uint32_t shape[] = {0, 3};
    off += BuildShapeTlv(block.dumpStartAddr + off, 2, shape);
    uint8_t tensorData[] = {1, 2, 3};
    off += BuildTensorTlv(block.dumpStartAddr + off, 4U, sizeof(tensorData), tensorData, sizeof(tensorData));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, off);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_MultipleTimestamps)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    for (int i = 0; i < 5; ++i) {
        off += BuildTimestampTlv(block.dumpStartAddr + off);
    }
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, off);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfWithStringFormat)
{
    BlockBuffer block(256);
    DumpInfoHead* head = WriteTlv(block.dumpStartAddr, cce::runtime::DumpType::DUMP_SCALAR, 0);
    uint8_t* infoMsg = head->infoMsg;
    (void)memset_s(infoMsg, RESV_LEN, 0, RESV_LEN);
    uint64_t strOffset = 2 * PRINT_ARG_LEN;
    (void)memcpy_s(infoMsg + RESV_LEN, sizeof(uint64_t), &strOffset, sizeof(uint64_t));
    const char* fmt = "msg=%s";
    uint64_t strArgOffset = PRINT_ARG_LEN + strlen(fmt) + 1;
    (void)memcpy_s(infoMsg + RESV_LEN + PRINT_ARG_LEN, sizeof(uint64_t), &strArgOffset, sizeof(uint64_t));
    (void)memcpy_s(infoMsg + RESV_LEN + strOffset, strlen(fmt) + 1, fmt, strlen(fmt) + 1);
    const char* strArg = "hello";
    (void)memcpy_s(infoMsg + RESV_LEN + PRINT_ARG_LEN + strArgOffset, strlen(strArg) + 1, strArg, strlen(strArg) + 1);
    head->infoLen = RESV_LEN + PRINT_ARG_LEN + strArgOffset + strlen(strArg) + 1;
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, sizeof(DumpInfoHead) + head->infoLen);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, sizeof(DumpInfoHead) + head->infoLen);
    EXPECT_NE(output.find(strArg), std::string::npos);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfStringOffsetOutsideInfoLen)
{
    BlockBuffer block(256);
    DumpInfoHead* head = WriteTlv(block.dumpStartAddr, cce::runtime::DumpType::DUMP_SCALAR, 0);
    uint8_t* infoMsg = head->infoMsg;
    (void)memset_s(infoMsg, RESV_LEN, 0, RESV_LEN);
    uint64_t strOffset = 2 * PRINT_ARG_LEN;
    (void)memcpy_s(infoMsg + RESV_LEN, sizeof(uint64_t), &strOffset, sizeof(uint64_t));
    uint64_t strArgOffset = 64U;
    (void)memcpy_s(infoMsg + RESV_LEN + PRINT_ARG_LEN, sizeof(uint64_t), &strArgOffset, sizeof(uint64_t));
    const char* fmt = "msg=%s";
    (void)memcpy_s(infoMsg + RESV_LEN + strOffset, strlen(fmt) + 1, fmt, strlen(fmt) + 1);
    const char* outsideData = "outside_info_len";
    (void)memcpy_s(
        infoMsg + RESV_LEN + PRINT_ARG_LEN + strArgOffset, strlen(outsideData) + 1, outsideData,
        strlen(outsideData) + 1);
    head->infoLen = RESV_LEN + strOffset + strlen(fmt) + 1;
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, sizeof(DumpInfoHead) + head->infoLen);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, sizeof(DumpInfoHead) + head->infoLen);
    EXPECT_NE(output.find("Invalid string param offset[64]"), std::string::npos);
    EXPECT_EQ(output.find(outsideData), std::string::npos);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SimtStringOffsetOutsideInfoLen)
{
    BlockBuffer block(256);
    DumpInfoHead* head = WriteTlv(block.dumpStartAddr, cce::runtime::DumpType::DUMP_SIMT_PRINTF, 0);
    uint8_t* infoMsg = head->infoMsg;
    (void)memset_s(infoMsg, RESV_LEN_SIMT, 0, RESV_LEN_SIMT);
    const uint64_t strOffset = 2U * PRINT_ARG_LEN;
    (void)memcpy_s(infoMsg + RESV_LEN_SIMT, sizeof(uint64_t), &strOffset, sizeof(uint64_t));
    const uint64_t strArgOffset = 64U;
    (void)memcpy_s(infoMsg + RESV_LEN_SIMT + PRINT_ARG_LEN, sizeof(uint64_t), &strArgOffset, sizeof(uint64_t));
    const char* const fmt = "msg=%s";
    (void)memcpy_s(infoMsg + RESV_LEN_SIMT + strOffset, strlen(fmt) + 1U, fmt, strlen(fmt) + 1U);
    const char* const outsideData = "outside_simt_info_len";
    (void)memcpy_s(
        infoMsg + RESV_LEN_SIMT + PRINT_ARG_LEN + strArgOffset, strlen(outsideData) + 1U, outsideData,
        strlen(outsideData) + 1U);
    head->infoLen = RESV_LEN_SIMT + strOffset + strlen(fmt) + 1U;
    uint64_t consumedLen = 0U;
    rtDfxParseParam param =
        MakeParam(block.blockAddr, block.data.size(), 0, sizeof(DumpInfoHead) + head->infoLen, 2U, 0U);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, sizeof(DumpInfoHead) + head->infoLen);
    EXPECT_NE(output.find("Invalid string param offset[64]"), std::string::npos);
    EXPECT_EQ(output.find(outsideData), std::string::npos);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_AllTypesCombined)
{
    BlockBuffer block(1024);
    uint32_t off = 0;
    off += BuildPrintfTlv(block.dumpStartAddr + off, "start");
    off += BuildSkipTlv(block.dumpStartAddr + off);
    uint32_t shape[] = {2, 2};
    off += BuildShapeTlv(block.dumpStartAddr + off, 2, shape);
    uint8_t tensorData[] = {1, 2, 3, 4};
    off += BuildTensorTlv(block.dumpStartAddr + off, 4U, sizeof(tensorData), tensorData, sizeof(tensorData));
    off += BuildTimestampTlv(block.dumpStartAddr + off);
    off += BuildAssertTlv(block.dumpStartAddr + off, "end");
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, off);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SimtAllTypesCombined)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    const uint32_t printfLen = BuildPrintfTlv(block.dumpStartAddr + off, "simt start", true);
    off += printfLen;
    off += BuildWaitTlv(block.dumpStartAddr + off);
    off += BuildAssertTlv(block.dumpStartAddr + off, "simt assert", true);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off, 2U, 0U);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, printfLen);
    EXPECT_NE(output.find("simt start"), std::string::npos);
    EXPECT_EQ(output.find("simt assert"), std::string::npos);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_AIV_CoreType)
{
    BlockBuffer block(256);
    uint32_t tlvLen = BuildPrintfTlv(block.dumpStartAddr, "aiv test");
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen, 1U, 0U);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_TensorLargeContent)
{
    BlockBuffer block(2048);
    std::vector<uint8_t> tensorData(900, 7);
    uint32_t tlvLen = BuildTensorTlv(block.dumpStartAddr, 4U, tensorData.size(), tensorData.data(), tensorData.size());
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_TensorLargeContentWithShapeUsesChunkNumbers)
{
    BlockBuffer block(4096);
    uint32_t off = 0U;
    const uint32_t shape[] = {30U, 30U};
    off += BuildShapeTlv(block.dumpStartAddr + off, 2U, shape);
    std::vector<uint8_t> tensorData(900U, 7U);
    off += BuildTensorTlv(block.dumpStartAddr + off, 4U, tensorData.size(), tensorData.data(), tensorData.size());
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, off);
    EXPECT_NE(output.find("DumpTensor (Part1):"), std::string::npos);
    EXPECT_NE(output.find("DumpTensor (Part2):"), std::string::npos);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfLongMessage)
{
    BlockBuffer block(512);
    std::string longMsg(300, 'X');
    uint32_t tlvLen = BuildPrintfTlv(block.dumpStartAddr, longMsg);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_DfxInfoParser_FullLifecycle)
{
    DfxInfoParser::Instance().Init();
    EXPECT_EQ(DfxInfoParser::Instance().registered_, true);
    DfxInfoParser::Instance().UnInit();
    EXPECT_EQ(DfxInfoParser::Instance().registered_, false);
    DfxInfoParser::Instance().Init();
    EXPECT_EQ(DfxInfoParser::Instance().registered_, true);
    BlockBuffer block(256);
    uint32_t tlvLen = BuildPrintfTlv(block.dumpStartAddr, "lifecycle test");
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
    DfxInfoParser::Instance().UnInit();
    EXPECT_EQ(DfxInfoParser::Instance().registered_, false);
}

static uint32_t BuildPrintfWithFmtAndArgs(
    uint8_t* buf, const std::string& fmt, const std::vector<int64_t>& args, bool isSimt = false)
{
    uint32_t resvOffset = isSimt ? RESV_LEN_SIMT : RESV_LEN;
    DumpInfoHead* head =
        WriteTlv(buf, isSimt ? cce::runtime::DumpType::DUMP_SIMT_PRINTF : cce::runtime::DumpType::DUMP_SCALAR, 0);
    uint8_t* infoMsg = head->infoMsg;
    (void)memset_s(infoMsg, resvOffset, 0, resvOffset);
    uint64_t strOffset = (args.size() + 1) * PRINT_ARG_LEN;
    (void)memcpy_s(infoMsg + resvOffset, sizeof(uint64_t), &strOffset, sizeof(uint64_t));
    for (size_t i = 0; i < args.size(); ++i) {
        (void)memcpy_s(infoMsg + resvOffset + (i + 1) * PRINT_ARG_LEN, sizeof(int64_t), &args[i], sizeof(int64_t));
    }
    (void)memcpy_s(infoMsg + resvOffset + strOffset, fmt.size() + 1, fmt.c_str(), fmt.size() + 1);
    head->infoLen = resvOffset + strOffset + fmt.size() + 1;
    return sizeof(DumpInfoHead) + head->infoLen;
}

static uint32_t BuildPrintfWithFloatArg(uint8_t* buf, const std::string& fmt, float argVal, bool isSimt = false)
{
    uint32_t resvOffset = isSimt ? RESV_LEN_SIMT : RESV_LEN;
    DumpInfoHead* head =
        WriteTlv(buf, isSimt ? cce::runtime::DumpType::DUMP_SIMT_PRINTF : cce::runtime::DumpType::DUMP_SCALAR, 0);
    uint8_t* infoMsg = head->infoMsg;
    (void)memset_s(infoMsg, resvOffset, 0, resvOffset);
    uint64_t strOffset = 2 * PRINT_ARG_LEN;
    (void)memcpy_s(infoMsg + resvOffset, sizeof(uint64_t), &strOffset, sizeof(uint64_t));
    (void)memcpy_s(infoMsg + resvOffset + PRINT_ARG_LEN, sizeof(float), &argVal, sizeof(float));
    (void)memcpy_s(infoMsg + resvOffset + strOffset, fmt.size() + 1, fmt.c_str(), fmt.size() + 1);
    head->infoLen = resvOffset + strOffset + fmt.size() + 1;
    return sizeof(DumpInfoHead) + head->infoLen;
}

static uint32_t BuildPrintfWithPtrArg(uint8_t* buf, const std::string& fmt, void* argVal, bool isSimt = false)
{
    uint32_t resvOffset = isSimt ? RESV_LEN_SIMT : RESV_LEN;
    DumpInfoHead* head =
        WriteTlv(buf, isSimt ? cce::runtime::DumpType::DUMP_SIMT_PRINTF : cce::runtime::DumpType::DUMP_SCALAR, 0);
    uint8_t* infoMsg = head->infoMsg;
    (void)memset_s(infoMsg, resvOffset, 0, resvOffset);
    uint64_t strOffset = 2 * PRINT_ARG_LEN;
    (void)memcpy_s(infoMsg + resvOffset, sizeof(uint64_t), &strOffset, sizeof(uint64_t));
    (void)memcpy_s(infoMsg + resvOffset + PRINT_ARG_LEN, sizeof(void*), &argVal, sizeof(void*));
    (void)memcpy_s(infoMsg + resvOffset + strOffset, fmt.size() + 1, fmt.c_str(), fmt.size() + 1);
    head->infoLen = resvOffset + strOffset + fmt.size() + 1;
    return sizeof(DumpInfoHead) + head->infoLen;
}

static uint32_t BuildPrintfWithSimtStringArg(uint8_t* buf, const std::string& fmt, const std::string& strArg)
{
    uint32_t resvOffset = RESV_LEN_SIMT;
    DumpInfoHead* head = WriteTlv(buf, cce::runtime::DumpType::DUMP_SIMT_PRINTF, 0);
    uint8_t* infoMsg = head->infoMsg;
    (void)memset_s(infoMsg, resvOffset, 0, resvOffset);
    uint64_t strOffset = 2 * PRINT_ARG_LEN;
    (void)memcpy_s(infoMsg + resvOffset, sizeof(uint64_t), &strOffset, sizeof(uint64_t));
    uint64_t strArgOffset = PRINT_ARG_LEN + fmt.size() + 1;
    (void)memcpy_s(infoMsg + resvOffset + PRINT_ARG_LEN, sizeof(uint64_t), &strArgOffset, sizeof(uint64_t));
    (void)memcpy_s(infoMsg + resvOffset + strOffset, fmt.size() + 1, fmt.c_str(), fmt.size() + 1);
    (void)memcpy_s(
        reinterpret_cast<uint8_t*>(infoMsg + resvOffset + PRINT_ARG_LEN) + strArgOffset, strArg.size() + 1,
        strArg.c_str(), strArg.size() + 1);
    head->infoLen = resvOffset + PRINT_ARG_LEN + strArgOffset + strArg.size() + 1;
    return sizeof(DumpInfoHead) + head->infoLen;
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfFormatD)
{
    BlockBuffer block(256);
    uint32_t tlvLen = BuildPrintfWithFmtAndArgs(block.dumpStartAddr, "val=%d", {42});
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfFormatI)
{
    BlockBuffer block(256);
    uint32_t tlvLen = BuildPrintfWithFmtAndArgs(block.dumpStartAddr, "val=%i", {-7});
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfFormatF)
{
    BlockBuffer block(256);
    uint32_t tlvLen = BuildPrintfWithFloatArg(block.dumpStartAddr, "val=%f", 3.14f);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfFormatFUpper)
{
    BlockBuffer block(256);
    uint32_t tlvLen = BuildPrintfWithFloatArg(block.dumpStartAddr, "val=%F", 2.5f);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfFormatU)
{
    BlockBuffer block(256);
    uint32_t tlvLen = BuildPrintfWithFmtAndArgs(block.dumpStartAddr, "val=%u", {100U});
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfFormatX)
{
    BlockBuffer block(256);
    uint32_t tlvLen = BuildPrintfWithFmtAndArgs(block.dumpStartAddr, "val=%x", {static_cast<int64_t>(0xABCD)});
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfFormatXUpper)
{
    BlockBuffer block(256);
    uint32_t tlvLen = BuildPrintfWithFmtAndArgs(block.dumpStartAddr, "val=%X", {static_cast<int64_t>(0xABCD)});
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfFormatP)
{
    BlockBuffer block(256);
    void* ptr = reinterpret_cast<void*>(0x1234);
    uint32_t tlvLen = BuildPrintfWithPtrArg(block.dumpStartAddr, "ptr=%p", ptr);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfFormatLong)
{
    BlockBuffer block(256);
    uint32_t tlvLen = BuildPrintfWithFmtAndArgs(block.dumpStartAddr, "val=%ld", {123456});
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfFormatLongLong)
{
    BlockBuffer block(256);
    uint32_t tlvLen = BuildPrintfWithFmtAndArgs(block.dumpStartAddr, "val=%lld", {789012});
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfFormatLu)
{
    BlockBuffer block(256);
    uint32_t tlvLen = BuildPrintfWithFmtAndArgs(block.dumpStartAddr, "val=%lu", {static_cast<int64_t>(999U)});
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfFormatLlu)
{
    BlockBuffer block(256);
    uint32_t tlvLen = BuildPrintfWithFmtAndArgs(block.dumpStartAddr, "val=%llu", {static_cast<int64_t>(888U)});
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfFormatLx)
{
    BlockBuffer block(256);
    uint32_t tlvLen = BuildPrintfWithFmtAndArgs(block.dumpStartAddr, "val=%lx", {static_cast<int64_t>(0xDEAD)});
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfFormatLlx)
{
    BlockBuffer block(256);
    uint32_t tlvLen = BuildPrintfWithFmtAndArgs(block.dumpStartAddr, "val=%llx", {static_cast<int64_t>(0xBEEF)});
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfFormatLX)
{
    BlockBuffer block(256);
    uint32_t tlvLen = BuildPrintfWithFmtAndArgs(block.dumpStartAddr, "val=%lX", {static_cast<int64_t>(0xCAFE)});
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfFormatLlX)
{
    BlockBuffer block(256);
    uint32_t tlvLen = BuildPrintfWithFmtAndArgs(block.dumpStartAddr, "val=%llX", {static_cast<int64_t>(0xFACE)});
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfPercentPercent)
{
    BlockBuffer block(256);
    DumpInfoHead* head = WriteTlv(block.dumpStartAddr, cce::runtime::DumpType::DUMP_SCALAR, 0);
    uint8_t* infoMsg = head->infoMsg;
    (void)memset_s(infoMsg, RESV_LEN, 0, RESV_LEN);
    uint64_t strOffset = PRINT_ARG_LEN;
    (void)memcpy_s(infoMsg + RESV_LEN, sizeof(uint64_t), &strOffset, sizeof(uint64_t));
    const char* fmt = "100%% done";
    (void)memcpy_s(infoMsg + RESV_LEN + strOffset, strlen(fmt) + 1, fmt, strlen(fmt) + 1);
    head->infoLen = RESV_LEN + sizeof(uint64_t) + strlen(fmt) + 1;
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, sizeof(DumpInfoHead) + head->infoLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, sizeof(DumpInfoHead) + head->infoLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SimtStringFormat)
{
    BlockBuffer block(512);
    uint32_t tlvLen = BuildPrintfWithSimtStringArg(block.dumpStartAddr, "msg=%s", "simt_str");
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen, 2U, 0U);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, tlvLen);
    EXPECT_NE(output.find("simt_str"), std::string::npos);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SimtStringWithoutTerminatorInInfoLen)
{
    BlockBuffer block(512);
    DumpInfoHead* head = WriteTlv(block.dumpStartAddr, cce::runtime::DumpType::DUMP_SIMT_PRINTF, 0);
    uint8_t* infoMsg = head->infoMsg;
    (void)memset_s(infoMsg, RESV_LEN_SIMT, 0, RESV_LEN_SIMT);
    uint64_t strOffset = 2 * PRINT_ARG_LEN;
    (void)memcpy_s(infoMsg + RESV_LEN_SIMT, sizeof(uint64_t), &strOffset, sizeof(uint64_t));
    const char* fmt = "msg=%s";
    uint64_t strArgOffset = PRINT_ARG_LEN + strlen(fmt) + 1;
    (void)memcpy_s(infoMsg + RESV_LEN_SIMT + PRINT_ARG_LEN, sizeof(uint64_t), &strArgOffset, sizeof(uint64_t));
    (void)memcpy_s(infoMsg + RESV_LEN_SIMT + strOffset, strlen(fmt) + 1, fmt, strlen(fmt) + 1);
    const char* unterminatedData = "boundary";
    const size_t unterminatedLen = strlen(unterminatedData);
    (void)memcpy_s(
        infoMsg + RESV_LEN_SIMT + PRINT_ARG_LEN + strArgOffset, unterminatedLen, unterminatedData, unterminatedLen);
    head->infoLen = RESV_LEN_SIMT + PRINT_ARG_LEN + strArgOffset + unterminatedLen;
    uint64_t consumedLen = 0U;
    rtDfxParseParam param =
        MakeParam(block.blockAddr, block.data.size(), 0, sizeof(DumpInfoHead) + head->infoLen, 2U, 0U);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, sizeof(DumpInfoHead) + head->infoLen);
    EXPECT_NE(output.find("String param length is greater than max length"), std::string::npos);
    EXPECT_EQ(output.find(unterminatedData), std::string::npos);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_TensorBoolWithoutShape)
{
    BlockBuffer block(256);
    uint8_t boolData[] = {1, 0, 1, 0, 1, 1, 0, 0};
    uint32_t tlvLen = BuildTensorTlv(block.dumpStartAddr, 12U, sizeof(boolData), boolData, sizeof(boolData));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_TensorBoolWithShape)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    uint32_t shape[] = {2, 4};
    off += BuildShapeTlv(block.dumpStartAddr + off, 2, shape);
    uint8_t boolData[] = {1, 0, 1, 0, 1, 1, 0, 0};
    off += BuildTensorTlv(block.dumpStartAddr + off, 12U, sizeof(boolData), boolData, sizeof(boolData));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, off);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_TensorWithShapeMoreDataThanShape)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    uint32_t shape[] = {2, 2};
    off += BuildShapeTlv(block.dumpStartAddr + off, 2, shape);
    uint8_t tensorData[] = {10, 20, 30, 40, 50, 60};
    off += BuildTensorTlv(block.dumpStartAddr + off, 4U, sizeof(tensorData), tensorData, sizeof(tensorData));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, off);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_TensorWithShapeLessDataThanShape)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    uint32_t shape[] = {3, 3};
    off += BuildShapeTlv(block.dumpStartAddr + off, 2, shape);
    uint8_t tensorData[] = {10, 20, 30};
    off += BuildTensorTlv(block.dumpStartAddr + off, 4U, sizeof(tensorData), tensorData, sizeof(tensorData));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, off);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_TensorFloat16WithShape)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    uint32_t shape[] = {2, 2};
    off += BuildShapeTlv(block.dumpStartAddr + off, 2, shape);
    uint16_t fp16Data[] = {16256, 49152, 16457, 32640};
    off += BuildTensorTlv(
        block.dumpStartAddr + off, 1U, sizeof(fp16Data), reinterpret_cast<uint8_t*>(fp16Data), sizeof(fp16Data));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, off);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_TensorWithoutShapeVariousTypes)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    int16_t data1[] = {-1, 2};
    off +=
        BuildTensorTlv(block.dumpStartAddr + off, 6U, sizeof(data1), reinterpret_cast<uint8_t*>(data1), sizeof(data1));
    uint16_t data2[] = {10, 20};
    off +=
        BuildTensorTlv(block.dumpStartAddr + off, 7U, sizeof(data2), reinterpret_cast<uint8_t*>(data2), sizeof(data2));
    int8_t data3[] = {-3, 4, 5};
    off +=
        BuildTensorTlv(block.dumpStartAddr + off, 2U, sizeof(data3), reinterpret_cast<uint8_t*>(data3), sizeof(data3));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, off);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_TensorFloat32WithShape)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    uint32_t shape[] = {2, 2};
    off += BuildShapeTlv(block.dumpStartAddr + off, 2, shape);
    float tensorData[] = {1.5f, 2.5f, 3.5f, 4.5f};
    off += BuildTensorTlv(
        block.dumpStartAddr + off, 0U, sizeof(tensorData), reinterpret_cast<uint8_t*>(tensorData), sizeof(tensorData));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, off);
}

static rtProfCtrlHandle g_capturedProfCallback = nullptr;
static rtParseDfxInfoFunc g_capturedParseCallback = nullptr;
static uint32_t g_profRegisterCalls = 0U;
static uint32_t g_parseRegisterCalls = 0U;
static rtError_t captureProfCallback(uint32_t moduleId, rtProfCtrlHandle callback)
{
    g_profRegisterCalls++;
    g_capturedProfCallback = callback;
    return RT_ERROR_NONE;
}

static rtError_t CaptureParseCallback(rtParseDfxInfoFunc callback)
{
    g_parseRegisterCalls++;
    g_capturedParseCallback = callback;
    return RT_ERROR_NONE;
}

static void SetProfSwitch(uint64_t profSwitch)
{
    if (g_capturedProfCallback != nullptr) {
        rtProfCommandHandle_t cmd;
        cmd.profSwitch = profSwitch;
        g_capturedProfCallback(RT_PROF_CTRL_SWITCH, &cmd, sizeof(cmd));
    }
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_ProfCtrlCallback)
{
    MOCKER(rtProfRegisterCtrlCallback).stubs().will(invoke(captureProfCallback));
    DfxInfoParser::Instance().Init();
    SetProfSwitch(0x0000100000000ULL);
    DfxInfoParser::Instance().UnInit();
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_ReportTimeStampWithProfSwitch)
{
    MOCKER(rtProfRegisterCtrlCallback).stubs().will(invoke(captureProfCallback));
    DfxInfoParser::Instance().Init();
    SetProfSwitch(PROF_OP_TIMESTAMP_MASK);

    BlockBuffer block(256);
    uint32_t tlvLen = BuildTimestampTlv(block.dumpStartAddr);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);

    SetProfSwitch(0);
    DfxInfoParser::Instance().UnInit();
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_ParseDfxInfoCallback)
{
    BlockBuffer block(256);
    uint32_t tlvLen = BuildPrintfTlv(block.dumpStartAddr, "callback test");
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    Adx::ParseDfxInfoCallback(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_Init_RegistrationFailure)
{
    g_capturedProfCallback = nullptr;
    g_profRegisterCalls = 0U;
    MOCKER(rtProfRegisterCtrlCallback).stubs().will(invoke(captureProfCallback));
    MOCKER(rtRegisterParseDfxInfoFunc).stubs().will(returnValue(static_cast<rtError_t>(1)));
    int32_t ret = DfxInfoParser::Instance().Init();
    EXPECT_EQ(ret, ADUMP_FAILED);
    EXPECT_EQ(DfxInfoParser::Instance().registered_, false);
    EXPECT_EQ(DfxInfoParser::Instance().profRegistered_, false);
    EXPECT_EQ(g_capturedProfCallback, nullptr);
    EXPECT_EQ(g_profRegisterCalls, 2U);
    DfxInfoParser::Instance().UnInit();
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_ProfRegistrationFailureDoesNotFailParser)
{
    MOCKER(rtProfRegisterCtrlCallback).stubs().will(returnValue(static_cast<rtError_t>(1)));
    const int32_t ret = DfxInfoParser::Instance().Init();
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_EQ(DfxInfoParser::Instance().registered_, true);
    EXPECT_EQ(DfxInfoParser::Instance().profRegistered_, false);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_UnInitUnregistersCallbacksOnce)
{
    g_capturedProfCallback = nullptr;
    g_capturedParseCallback = nullptr;
    g_profRegisterCalls = 0U;
    g_parseRegisterCalls = 0U;
    MOCKER(rtProfRegisterCtrlCallback).stubs().will(invoke(captureProfCallback));
    MOCKER(rtRegisterParseDfxInfoFunc).stubs().will(invoke(CaptureParseCallback));

    EXPECT_EQ(DfxInfoParser::Instance().Init(), ADUMP_SUCCESS);
    EXPECT_NE(g_capturedProfCallback, nullptr);
    EXPECT_NE(g_capturedParseCallback, nullptr);

    DfxInfoParser::Instance().UnInit();
    EXPECT_EQ(DfxInfoParser::Instance().registered_, false);
    EXPECT_EQ(DfxInfoParser::Instance().profRegistered_, false);
    EXPECT_EQ(g_capturedProfCallback, nullptr);
    EXPECT_EQ(g_capturedParseCallback, nullptr);
    EXPECT_EQ(g_profRegisterCalls, 2U);
    EXPECT_EQ(g_parseRegisterCalls, 2U);

    DfxInfoParser::Instance().UnInit();
    EXPECT_EQ(g_profRegisterCalls, 2U);
    EXPECT_EQ(g_parseRegisterCalls, 2U);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_TensorBF16WithShape)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    uint32_t shape[] = {2};
    off += BuildShapeTlv(block.dumpStartAddr + off, 1, shape);
    uint16_t bf16Data[] = {0x3F80, 0x4000};
    off += BuildTensorTlv(
        block.dumpStartAddr + off, 27U, sizeof(bf16Data), reinterpret_cast<uint8_t*>(bf16Data), sizeof(bf16Data));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, off);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_TensorInt8WithShape)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    uint32_t shape[] = {4};
    off += BuildShapeTlv(block.dumpStartAddr + off, 1, shape);
    int8_t int8Data[] = {-1, 2, -3, 4};
    off += BuildTensorTlv(
        block.dumpStartAddr + off, 2U, sizeof(int8Data), reinterpret_cast<uint8_t*>(int8Data), sizeof(int8Data));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, off);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_TensorInt64WithShape)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    uint32_t shape[] = {2};
    off += BuildShapeTlv(block.dumpStartAddr + off, 1, shape);
    int64_t int64Data[] = {100, 200};
    off += BuildTensorTlv(
        block.dumpStartAddr + off, 9U, sizeof(int64Data), reinterpret_cast<uint8_t*>(int64Data), sizeof(int64Data));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, off);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_TensorShapeProductOverflow)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    uint32_t shape[] = {
        std::numeric_limits<uint32_t>::max(), std::numeric_limits<uint32_t>::max(),
        std::numeric_limits<uint32_t>::max()};
    off += BuildShapeTlv(block.dumpStartAddr + off, 3, shape);
    uint8_t tensorData[] = {1, 2};
    off += BuildTensorTlv(block.dumpStartAddr + off, 4U, sizeof(tensorData), tensorData, sizeof(tensorData));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, off);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SimtAssertWithMessage)
{
    BlockBuffer block(256);
    std::string assertMsg = "Assertion failed: x > 0";
    uint32_t tlvLen = BuildAssertTlv(block.dumpStartAddr, assertMsg, true);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen, 2U, 0U);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_PrintfTrailingPercent)
{
    BlockBuffer block(256);
    DumpInfoHead* head = WriteTlv(block.dumpStartAddr, cce::runtime::DumpType::DUMP_SCALAR, 0);
    uint8_t* infoMsg = head->infoMsg;
    (void)memset_s(infoMsg, RESV_LEN, 0, RESV_LEN);
    uint64_t strOffset = PRINT_ARG_LEN;
    (void)memcpy_s(infoMsg + RESV_LEN, sizeof(uint64_t), &strOffset, sizeof(uint64_t));
    const char* fmt = "trailing %";
    (void)memcpy_s(infoMsg + RESV_LEN + strOffset, strlen(fmt) + 1, fmt, strlen(fmt) + 1);
    head->infoLen = RESV_LEN + sizeof(uint64_t) + strlen(fmt) + 1;
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, sizeof(DumpInfoHead) + head->infoLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, sizeof(DumpInfoHead) + head->infoLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_MultipleTimestampsWithProfSwitch)
{
    constexpr uint32_t timestampCount = 20U;
    constexpr uint32_t timestampTlvLen = static_cast<uint32_t>(sizeof(DumpInfoHead) + sizeof(DumpTimeStampInfoMsg));
    MOCKER(rtProfRegisterCtrlCallback).stubs().will(invoke(captureProfCallback));
    DfxInfoParser::Instance().Init();
    SetProfSwitch(PROF_OP_TIMESTAMP_MASK);

    BlockBuffer block((timestampCount + 1U) * timestampTlvLen);
    uint32_t off = 0;
    for (uint32_t i = 0U; i < timestampCount; ++i) {
        off += BuildTimestampTlv(block.dumpStartAddr + off);
    }
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, off);

    SetProfSwitch(0);
    DfxInfoParser::Instance().UnInit();
}
