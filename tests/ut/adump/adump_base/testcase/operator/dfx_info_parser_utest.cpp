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
#include <algorithm>
#include <cstring>
#include <vector>
#include <limits>
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#include "case_workspace.h"
#include "mmpa_api.h"
#include "path.h"
#include "utils.h"
#include "file_utils.h"
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
using cce::runtime::DumpSuperTensorBody;
using cce::runtime::DumpSuperTensorHeader;
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

// 统计子串出现次数（非重叠）：供 1M 截断用例验证 "..."/告警只输出一次
static size_t CountOccurrences(const std::string& str, const std::string& sub)
{
    if (sub.empty()) {
        return 0U;
    }
    size_t cnt = 0U;
    size_t pos = str.find(sub);
    while (pos != std::string::npos) {
        ++cnt;
        pos = str.find(sub, pos + sub.size());
    }
    return cnt;
}

class DfxInfoParserUtest : public testing::Test {
protected:
    virtual void SetUp()
    {
        KernelDfxDumper::Instance().UnInit();
        DfxInfoParser::profCtrlRegistered_ = false; // 进程级注册标志按用例重置，保证断言确定性
    }
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
            auto* writeInfo = reinterpret_cast<BlockWriteInfo*>(blockAddr + totalSize - sizeof(BlockWriteInfo));
            writeInfo->packIdx = std::numeric_limits<uint64_t>::max();
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

    static uint32_t BuildAicpuTlv(uint8_t* buf, const std::string& msg)
    {
        DumpInfoHead* head = WriteTlv(buf, cce::runtime::DumpType::DUMP_AICPU, 0U);
        uint8_t* infoMsg = head->infoMsg;
        const uint64_t strOffset = PRINT_ARG_LEN;
        std::copy_n(reinterpret_cast<const uint8_t*>(&strOffset), sizeof(strOffset), infoMsg + RESV_LEN);
        std::copy(msg.begin(), msg.end(), reinterpret_cast<char*>(infoMsg + RESV_LEN + strOffset));
        infoMsg[RESV_LEN + strOffset + msg.size()] = '\0';
        head->infoLen = RESV_LEN + sizeof(strOffset) + static_cast<uint32_t>(msg.size()) + 1U;
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

    // 构造超大 tensor 首块 TLV：infoLen 含对齐尾，dumpSize 为实际数据长度
    static uint32_t BuildSuperTensorHeaderTlv(
        uint8_t* buf, uint32_t dataType, uint32_t dim, const uint32_t* shape, uint64_t length, uint32_t dumpSize,
        const uint8_t* data, size_t dataLen, uint32_t padLen = 0U)
    {
        DumpInfoHead* head =
            WriteTlv(buf, cce::runtime::DumpType::DUMP_SUPER_TENSOR, sizeof(DumpSuperTensorHeader) + dataLen + padLen);
        DumpSuperTensorHeader* superHead = reinterpret_cast<DumpSuperTensorHeader*>(head->infoMsg);
        superHead->addr = 0x800U;
        superHead->dataType = dataType;
        superHead->desc = 200U;
        superHead->bufferId = 0U;
        superHead->position = 0U;
        superHead->blockIdx = 1U;
        superHead->dim = dim;
        for (uint32_t i = 0U; i < dim && i < cce::runtime::RT_DUMP_SHAPE_MAX_SIZE; ++i) {
            superHead->shape[i] = shape[i];
        }
        superHead->length = length;
        superHead->offset = 0U;
        superHead->dumpSize = dumpSize;
        if (data != nullptr && dataLen > 0) {
            (void)memcpy_s(head->infoMsg + sizeof(DumpSuperTensorHeader), dataLen, data, dataLen);
        }
        return sizeof(DumpInfoHead) + sizeof(DumpSuperTensorHeader) + dataLen + padLen;
    }

    // 无 shape 快捷构造（dim=0 平铺打印场景）
    static uint32_t BuildSuperTensorHeaderTlv(
        uint8_t* buf, uint32_t dataType, uint64_t length, uint32_t dumpSize, const uint8_t* data, size_t dataLen,
        uint32_t padLen = 0U)
    {
        return BuildSuperTensorHeaderTlv(buf, dataType, 0U, nullptr, length, dumpSize, data, dataLen, padLen);
    }

    // 构造超大 tensor 后续分块 TLV
    static uint32_t BuildSuperTensorBodyTlv(
        uint8_t* buf, uint64_t length, uint64_t offset, uint32_t dumpSize, const uint8_t* data, size_t dataLen,
        uint32_t padLen = 0U)
    {
        DumpInfoHead* head = WriteTlv(
            buf, cce::runtime::DumpType::DUMP_SUPER_TENSOR_BODY, sizeof(DumpSuperTensorBody) + dataLen + padLen);
        DumpSuperTensorBody* body = reinterpret_cast<DumpSuperTensorBody*>(head->infoMsg);
        body->length = length;
        body->offset = offset;
        body->dumpSize = dumpSize;
        if (data != nullptr && dataLen > 0) {
            (void)memcpy_s(head->infoMsg + sizeof(DumpSuperTensorBody), dataLen, data, dataLen);
        }
        return sizeof(DumpInfoHead) + sizeof(DumpSuperTensorBody) + dataLen + padLen;
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

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_Normal_Aicpu)
{
    BlockBuffer block(256U);
    const uint32_t tlvLen = BuildAicpuTlv(block.dumpStartAddr, "aicpu printf");
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0U, tlvLen, 3U, 0U);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_AicpuPackIdxStopsUncommittedTlv)
{
    BlockBuffer block(256);
    const uint32_t firstLen = BuildAicpuTlv(block.dumpStartAddr, "aicpu committed");
    (void)BuildAicpuTlv(block.dumpStartAddr + firstLen, "aicpu uncommitted");
    auto* writeInfo = reinterpret_cast<BlockWriteInfo*>(block.blockAddr + block.data.size() - sizeof(BlockWriteInfo));
    writeInfo->packIdx = 1U;

    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0U, firstLen * 2U, 3U, 0U);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, firstLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_AicpuPackIdxAccumulatesAcrossRounds)
{
    BlockBuffer block(256);
    const uint32_t firstLen = BuildAicpuTlv(block.dumpStartAddr, "first round");
    const uint32_t secondLen = BuildAicpuTlv(block.dumpStartAddr + firstLen, "second round");
    auto* writeInfo = reinterpret_cast<BlockWriteInfo*>(block.blockAddr + block.data.size() - sizeof(BlockWriteInfo));

    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0U, firstLen, 3U, 0U);
    writeInfo->packIdx = 1U;
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, firstLen);

    param = MakeParam(block.blockAddr, block.data.size(), firstLen, firstLen + secondLen, 3U, 0U);
    writeInfo->packIdx = 2U;
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, secondLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SimtPackIdxStopsUncommittedTlv)
{
    BlockBuffer block(256);
    const uint32_t firstLen = BuildPrintfTlv(block.dumpStartAddr, "simt committed", true);
    (void)BuildPrintfTlv(block.dumpStartAddr + firstLen, "simt uncommitted", true);
    auto* writeInfo = reinterpret_cast<BlockWriteInfo*>(block.blockAddr + block.data.size() - sizeof(BlockWriteInfo));
    writeInfo->packIdx = 1U;

    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0U, firstLen * 2U, 2U, 0U);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, firstLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_AicPhysicalWraparoundPreservesV1ContentOrder)
{
    BlockBuffer block(256U);
    const uint32_t firstLen = BuildPrintfTlv(block.dumpStartAddr, "tail printf");
    const uint32_t secondLen = BuildAssertTlv(block.dumpStartAddr + firstLen, "head assert");
    const uint32_t readIdx = block.remainLen - firstLen;
    const uint32_t writeIdx = secondLen;
    std::vector<uint8_t> expectedData(block.dumpStartAddr, block.dumpStartAddr + firstLen + secondLen);
    WriteRingData(block, readIdx, expectedData.data(), expectedData.size());

    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), readIdx, writeIdx, 0U, 0U);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, firstLen + secondLen);
    const size_t firstPos = output.find("tail printf");
    const size_t secondPos = output.find("head assert");
    ASSERT_NE(firstPos, std::string::npos);
    ASSERT_NE(secondPos, std::string::npos);
    EXPECT_LT(firstPos, secondPos);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SimtInvalidTypeSkipsConsumption)
{
    BlockBuffer block(256U);
    const uint32_t firstLen = BuildPrintfTlv(block.dumpStartAddr, "first simt", true);
    (void)BuildInvalidTypeTlv(block.dumpStartAddr + firstLen);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0U, firstLen + sizeof(DumpInfoHead), 2U, 0U);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, firstLen + sizeof(DumpInfoHead));
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_AicpuFifoReinitResetsTlvCnt)
{
    BlockBuffer firstBlock(256U);
    const uint32_t firstLen = BuildAicpuTlv(firstBlock.dumpStartAddr, "old fifo");
    auto* writeInfo =
        reinterpret_cast<BlockWriteInfo*>(firstBlock.blockAddr + firstBlock.data.size() - sizeof(BlockWriteInfo));
    writeInfo->packIdx = 1U;
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(firstBlock.blockAddr, firstBlock.data.size(), 0U, firstLen, 3U, 0U);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, firstLen);

    BlockBuffer secondBlock(256U);
    const uint32_t secondLen = BuildAicpuTlv(secondBlock.dumpStartAddr, "new fifo");
    writeInfo =
        reinterpret_cast<BlockWriteInfo*>(secondBlock.blockAddr + secondBlock.data.size() - sizeof(BlockWriteInfo));
    writeInfo->packIdx = 1U;
    param = MakeParam(secondBlock.blockAddr, secondBlock.data.size(), 0U, secondLen, 3U, 0U);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, secondLen);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_AicpuTruncatedTlvAfterCompleteTlv)
{
    BlockBuffer block(256U);
    const uint32_t completeTlvLen = BuildAicpuTlv(block.dumpStartAddr, "complete aicpu printf");
    DumpInfoHead* truncatedHead =
        WriteTlv(block.dumpStartAddr + completeTlvLen, cce::runtime::DumpType::DUMP_AICPU, 100U);
    constexpr uint32_t truncatedPayloadLen = 4U;
    const uint32_t pendingLen = completeTlvLen + sizeof(*truncatedHead) + truncatedPayloadLen;
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0U, pendingLen, 3U, 0U);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, completeTlvLen);
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

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_AicWriteIdxOutOfRange)
{
    uint32_t remainLen = 128;
    BlockBuffer block(remainLen);
    uint32_t tlvLen = BuildPrintfTlv(block.dumpStartAddr, "overflow test");
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, remainLen + 10);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, 0U);
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
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), readOff, readOff + tlvLen, 2U, 0U);
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
    KernelDfxDumper::Instance().UnInit();
    GlobalMockObject::verify();
    KernelDfxDumper::Instance().UnInit();
    GlobalMockObject::verify();
    KernelDfxDumper::Instance().UnInit();
    MOCKER(mmGetDiskFreeSpace).stubs().will(invoke(MmGetDiskFreeSpaceSuccessStub));
    ASSERT_EQ(KernelDfxDumper::Instance().EnableDfxDumper(config), ADUMP_SUCCESS);
    ASSERT_TRUE(KernelDfxDumper::Instance().IsEnabled(RT_KERNEL_DFX_INFO_BLOCK_INFO));

    BlockBuffer block(256);
    const uint32_t tlvLen = BuildPrintfTlv(block.dumpStartAddr, "dump block test");
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen, 0U, 0U);
    Path dumpFile = Path(KernelDfxDumper::Instance().dumpPath_).Concat("asc_kernel_data_aic_0.bin");
    const std::string expectedFilePath = dumpFile.GetString();
    const std::string expectedContent(reinterpret_cast<const char*>(block.dumpStartAddr), tlvLen);
    MOCKER(mmGetDiskFreeSpace).stubs().will(invoke(MmGetDiskFreeSpaceSuccessStub));

    KernelDfxDumper::Instance().DumpKernelDfxInfoBlock(&param, block.dumpStartAddr, tlvLen);

    KernelDfxDumper::Instance().UnInitTask();
    while (KernelDfxDumper::Instance().taskRunning_) {
        usleep(100000U);
    }

    Path actualDumpFile(expectedFilePath);
    ASSERT_TRUE(actualDumpFile.Exist());
    const std::string actualContent = ReadFileToString(actualDumpFile.GetString());
    ASSERT_EQ(actualContent.size(), sizeof(BlockInfo) + tlvLen);
    EXPECT_EQ(
        actualContent.compare(0U, sizeof(BlockInfo), reinterpret_cast<const char*>(block.blockAddr), sizeof(BlockInfo)),
        0);
    EXPECT_EQ(actualContent.compare(sizeof(BlockInfo), tlvLen, expectedContent.c_str(), tlvLen), 0);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_DumpKernelDfxInfoBlock_WritesBlockInfoOnce)
{
    Tools::CaseWorkspace workspace("Test_DfxParser_DumpBlockHeaderOnce");
    DumpDfxConfig config;
    config.dfxTypes.push_back("printf");
    config.dumpPath = workspace.Root() + "/ascendDumpPath";
    ASSERT_EQ(KernelDfxDumper::Instance().EnableDfxDumper(config), ADUMP_SUCCESS);

    GlobalMockObject::verify();

    BlockBuffer block(256);
    const uint32_t tlvLen = BuildPrintfTlv(block.dumpStartAddr, "dump block test");
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen, 0U, 0U);
    Path dumpFile = Path(KernelDfxDumper::Instance().dumpPath_).Concat("asc_kernel_data_aic_0.bin");
    MOCKER(mmGetDiskFreeSpace).stubs().will(invoke(MmGetDiskFreeSpaceSuccessStub));

    KernelDfxDumper::Instance().DumpKernelDfxInfoBlock(&param, block.dumpStartAddr, tlvLen);
    KernelDfxDumper::Instance().DumpKernelDfxInfoBlock(&param, block.dumpStartAddr, tlvLen);

    KernelDfxDumper::Instance().UnInitTask();
    while (KernelDfxDumper::Instance().taskRunning_) {
        usleep(100000U);
    }

    const std::string actualContent = ReadFileToString(dumpFile.GetString());
    ASSERT_FALSE(actualContent.empty());
    ASSERT_EQ(actualContent.size(), sizeof(BlockInfo) + tlvLen * 2U);
    EXPECT_EQ(
        actualContent.compare(0U, sizeof(BlockInfo), reinterpret_cast<const char*>(block.blockAddr), sizeof(BlockInfo)),
        0);
    EXPECT_EQ(
        actualContent.compare(sizeof(BlockInfo), tlvLen, reinterpret_cast<const char*>(block.dumpStartAddr), tlvLen),
        0);
    EXPECT_EQ(
        actualContent.compare(
            sizeof(BlockInfo) + tlvLen, tlvLen, reinterpret_cast<const char*>(block.dumpStartAddr), tlvLen),
        0);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_DumpKernelDfxInfoBlock_RetriesHeaderAfterWriteFailure)
{
    Tools::CaseWorkspace workspace("Test_DfxParser_DumpBlockHeaderRetry");
    DumpDfxConfig config;
    config.dfxTypes.push_back("printf");
    config.dumpPath = workspace.Root() + "/ascendDumpPath";
    ASSERT_EQ(KernelDfxDumper::Instance().EnableDfxDumper(config), ADUMP_SUCCESS);

    GlobalMockObject::verify();

    BlockBuffer block(256);
    const uint32_t tlvLen = BuildPrintfTlv(block.dumpStartAddr, "retry header");
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen, 0U, 0U);
    Path dumpFile = Path(KernelDfxDumper::Instance().dumpPath_).Concat("asc_kernel_data_aic_0.bin");
    MOCKER(mmGetDiskFreeSpace).stubs().will(invoke(MmGetDiskFreeSpaceSuccessStub));
    MOCKER(Adx::FileUtils::WriteFile).stubs().will(returnValue(1)).then(returnValue(0)).then(returnValue(0));

    KernelDfxDumper::Instance().DumpKernelDfxInfoBlock(&param, block.dumpStartAddr, tlvLen);
    KernelDfxDumper::Instance().UnInitTask();
    while (KernelDfxDumper::Instance().taskRunning_) {
        usleep(100000U);
    }

    GlobalMockObject::verify();
    KernelDfxDumper::Instance().UnInit();
    MOCKER(mmGetDiskFreeSpace).stubs().will(invoke(MmGetDiskFreeSpaceSuccessStub));
    ASSERT_EQ(KernelDfxDumper::Instance().EnableDfxDumper(config), ADUMP_SUCCESS);
    dumpFile = Path(KernelDfxDumper::Instance().dumpPath_).Concat("asc_kernel_data_aic_0.bin");
    const std::string expectedFilePath = dumpFile.GetString();
    KernelDfxDumper::Instance().DumpKernelDfxInfoBlock(&param, block.dumpStartAddr, tlvLen);
    KernelDfxDumper::Instance().UnInitTask();
    while (KernelDfxDumper::Instance().taskRunning_) {
        usleep(100000U);
    }

    const std::string actualContent = ReadFileToString(expectedFilePath);
    ASSERT_FALSE(actualContent.empty());
    ASSERT_EQ(actualContent.size(), sizeof(BlockInfo) + tlvLen);
    EXPECT_EQ(
        actualContent.compare(0U, sizeof(BlockInfo), reinterpret_cast<const char*>(block.blockAddr), sizeof(BlockInfo)),
        0);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_DumpKernelDfxInfoBlock_RetriesHeaderWhenTlvSucceeds)
{
    Tools::CaseWorkspace workspace("Test_DfxParser_DumpBlockHeaderRetryAfterTlv");
    DumpDfxConfig config;
    config.dfxTypes.push_back("printf");
    config.dumpPath = workspace.Root() + "/ascendDumpPath";
    ASSERT_EQ(KernelDfxDumper::Instance().EnableDfxDumper(config), ADUMP_SUCCESS);

    GlobalMockObject::verify();

    BlockBuffer block(256);
    const uint32_t tlvLen = BuildPrintfTlv(block.dumpStartAddr, "retry header after tlv");
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen, 0U, 0U);
    const std::string filePath =
        Path(KernelDfxDumper::Instance().dumpPath_).Concat("asc_kernel_data_aic_0.bin").GetString();
    MOCKER(mmGetDiskFreeSpace).stubs().will(invoke(MmGetDiskFreeSpaceSuccessStub));
    MOCKER(Adx::FileUtils::WriteFile).stubs().will(returnValue(1)).then(returnValue(0)).then(returnValue(0));

    KernelDfxDumper::Instance().DumpKernelDfxInfoBlock(&param, block.dumpStartAddr, tlvLen);
    KernelDfxDumper::Instance().UnInitTask();
    while (KernelDfxDumper::Instance().taskRunning_) {
        usleep(100000U);
    }

    EXPECT_TRUE(
        KernelDfxDumper::Instance().blockInfoPendingFiles_.find(filePath) ==
        KernelDfxDumper::Instance().blockInfoPendingFiles_.end());
    EXPECT_TRUE(
        KernelDfxDumper::Instance().blockInfoWrittenFiles_.find(filePath) ==
        KernelDfxDumper::Instance().blockInfoWrittenFiles_.end());

    GlobalMockObject::verify();
    MOCKER(mmGetDiskFreeSpace).stubs().will(invoke(MmGetDiskFreeSpaceSuccessStub));
    ASSERT_EQ(KernelDfxDumper::Instance().InitTask(), ADUMP_SUCCESS);
    KernelDfxDumper::Instance().DumpKernelDfxInfoBlock(&param, block.dumpStartAddr, tlvLen);
    KernelDfxDumper::Instance().UnInitTask();
    while (KernelDfxDumper::Instance().taskRunning_) {
        usleep(100000U);
    }

    EXPECT_TRUE(
        KernelDfxDumper::Instance().blockInfoPendingFiles_.find(filePath) ==
        KernelDfxDumper::Instance().blockInfoPendingFiles_.end());
    EXPECT_TRUE(
        KernelDfxDumper::Instance().blockInfoWrittenFiles_.find(filePath) !=
        KernelDfxDumper::Instance().blockInfoWrittenFiles_.end());
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

static ProfCommandHandle g_capturedProfCallback = nullptr;
static rtParseDfxInfoFunc g_capturedParseCallback = nullptr;
static uint32_t g_profRegisterCalls = 0U;
static uint32_t g_parseRegisterCalls = 0U;
static uint32_t g_reportAdditionalInfoCalls = 0U;
static uint32_t g_capturedProfModuleId = 0U;
static int32_t captureMsprofCallback(uint32_t moduleId, ProfCommandHandle callback)
{
    g_profRegisterCalls++;
    g_capturedProfModuleId = moduleId;
    g_capturedProfCallback = callback;
    return 0;
}

static rtError_t CaptureParseCallback(rtParseDfxInfoFunc callback)
{
    g_parseRegisterCalls++;
    g_capturedParseCallback = callback;
    return RT_ERROR_NONE;
}

static int32_t CountMsprofReportAdditionalInfo(uint32_t nonPersistantFlag, const VOID_PTR data, uint32_t length)
{
    g_reportAdditionalInfoCalls++;
    return 0;
}

static void SetProfSwitch(uint64_t profSwitch, uint32_t cmdType = PROF_COMMANDHANDLE_TYPE_START)
{
    if (g_capturedProfCallback != nullptr) {
        MsprofCommandHandle cmd;
        (void)memset_s(&cmd, sizeof(cmd), 0, sizeof(cmd));
        cmd.profSwitch = profSwitch;
        cmd.type = cmdType;
        g_capturedProfCallback(RT_PROF_CTRL_SWITCH, &cmd, sizeof(cmd));
    }
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_ProfCtrlCallback)
{
    g_capturedProfModuleId = 0U;
    MOCKER(MsprofRegisterCallback).stubs().will(invoke(captureMsprofCallback));
    DfxInfoParser::Instance().Init();
    // moduleId 须取 msprof g_moduleIdMap 已登记的 RUNTIME，未登记 ID（如 IDEDD）会被 json 门禁误挡
    EXPECT_EQ(g_capturedProfModuleId, static_cast<uint32_t>(RUNTIME));
    SetProfSwitch(0x0000100000000ULL);
    DfxInfoParser::Instance().UnInit();
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_ProfSwitchClearedOnStop)
{
    g_reportAdditionalInfoCalls = 0U;
    MOCKER(MsprofRegisterCallback).stubs().will(invoke(captureMsprofCallback));
    MOCKER(MsprofReportAdditionalInfo).stubs().will(invoke(CountMsprofReportAdditionalInfo));
    DfxInfoParser::Instance().Init();

    BlockBuffer block(256);
    const uint32_t tlvLen = BuildTimestampTlv(block.dumpStartAddr);
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);

    // START 下发开关掩码后，时间戳走 MsprofReportAdditionalInfo 上报
    SetProfSwitch(PROF_OP_TIMESTAMP_MASK, PROF_COMMANDHANDLE_TYPE_START);
    uint64_t consumedLen = 0U;
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
    EXPECT_GT(g_reportAdditionalInfoCalls, 0U);

    // STOP 命令载荷仍携带开关掩码，但 g_profSwitch 必须被清零，不再上报
    const uint32_t callsAfterStart = g_reportAdditionalInfoCalls;
    SetProfSwitch(PROF_OP_TIMESTAMP_MASK, PROF_COMMANDHANDLE_TYPE_STOP);
    consumedLen = 0U;
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
    EXPECT_EQ(g_reportAdditionalInfoCalls, callsAfterStart);

    DfxInfoParser::Instance().UnInit();
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_ProfSwitchClearedOnFinalize)
{
    g_reportAdditionalInfoCalls = 0U;
    MOCKER(MsprofRegisterCallback).stubs().will(invoke(captureMsprofCallback));
    MOCKER(MsprofReportAdditionalInfo).stubs().will(invoke(CountMsprofReportAdditionalInfo));
    DfxInfoParser::Instance().Init();

    BlockBuffer block(256);
    const uint32_t tlvLen = BuildTimestampTlv(block.dumpStartAddr);
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);

    SetProfSwitch(PROF_OP_TIMESTAMP_MASK, PROF_COMMANDHANDLE_TYPE_START);
    uint64_t consumedLen = 0U;
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
    EXPECT_GT(g_reportAdditionalInfoCalls, 0U);

    // FINALIZE 与 STOP 同为终止命令，g_profSwitch 必须被清零
    const uint32_t callsAfterStart = g_reportAdditionalInfoCalls;
    SetProfSwitch(PROF_OP_TIMESTAMP_MASK, PROF_COMMANDHANDLE_TYPE_FINALIZE);
    consumedLen = 0U;
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
    EXPECT_EQ(g_reportAdditionalInfoCalls, callsAfterStart);

    DfxInfoParser::Instance().UnInit();
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_ProfSwitchIgnoredOnInit)
{
    g_reportAdditionalInfoCalls = 0U;
    MOCKER(MsprofRegisterCallback).stubs().will(invoke(captureMsprofCallback));
    MOCKER(MsprofReportAdditionalInfo).stubs().will(invoke(CountMsprofReportAdditionalInfo));
    DfxInfoParser::Instance().Init();

    BlockBuffer block(256);
    const uint32_t tlvLen = BuildTimestampTlv(block.dumpStartAddr);
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);

    // INIT 载荷 profSwitch 恒为 0，且不属于携带有效开关的命令类型，不应开启上报
    SetProfSwitch(PROF_OP_TIMESTAMP_MASK, PROF_COMMANDHANDLE_TYPE_INIT);
    uint64_t consumedLen = 0U;
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
    EXPECT_EQ(g_reportAdditionalInfoCalls, 0U);

    DfxInfoParser::Instance().UnInit();
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_ReportTimeStampWithProfSwitch)
{
    MOCKER(MsprofRegisterCallback).stubs().will(invoke(captureMsprofCallback));
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
    MOCKER(MsprofRegisterCallback).stubs().will(invoke(captureMsprofCallback));
    MOCKER(rtRegisterParseDfxInfoFunc).stubs().will(returnValue(static_cast<rtError_t>(1)));
    int32_t ret = DfxInfoParser::Instance().Init();
    EXPECT_EQ(ret, ADUMP_FAILED);
    EXPECT_EQ(DfxInfoParser::Instance().registered_, false);
    EXPECT_NE(g_capturedProfCallback, nullptr);
    EXPECT_EQ(g_profRegisterCalls, 1U);
    // 解析回调注册持续失败时再次 Init：prof 回调为进程级一次性注册，不应重复注册
    ret = DfxInfoParser::Instance().Init();
    EXPECT_EQ(ret, ADUMP_FAILED);
    EXPECT_EQ(g_profRegisterCalls, 1U);
    DfxInfoParser::Instance().UnInit();
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_ProfRegistrationFailureDoesNotFailParser)
{
    MOCKER(MsprofRegisterCallback).stubs().will(returnValue(static_cast<int32_t>(1)));
    const int32_t ret = DfxInfoParser::Instance().Init();
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_EQ(DfxInfoParser::Instance().registered_, true);
}

TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_UnInitUnregistersCallbacksOnce)
{
    g_capturedProfCallback = nullptr;
    g_capturedParseCallback = nullptr;
    g_profRegisterCalls = 0U;
    g_parseRegisterCalls = 0U;
    MOCKER(MsprofRegisterCallback).stubs().will(invoke(captureMsprofCallback));
    MOCKER(rtRegisterParseDfxInfoFunc).stubs().will(invoke(CaptureParseCallback));

    EXPECT_EQ(DfxInfoParser::Instance().Init(), ADUMP_SUCCESS);
    EXPECT_NE(g_capturedProfCallback, nullptr);
    EXPECT_NE(g_capturedParseCallback, nullptr);

    DfxInfoParser::Instance().UnInit();
    EXPECT_EQ(DfxInfoParser::Instance().registered_, false);
    EXPECT_EQ(g_profRegisterCalls, 1U);
    EXPECT_EQ(g_capturedParseCallback, nullptr);
    EXPECT_EQ(g_parseRegisterCalls, 2U);

    DfxInfoParser::Instance().UnInit();
    EXPECT_EQ(g_profRegisterCalls, 1U);
    EXPECT_EQ(g_parseRegisterCalls, 2U);

    // profapi 无反注册能力，prof 回调为进程级一次性注册：UnInit 后再次 Init 不重复注册
    EXPECT_EQ(DfxInfoParser::Instance().Init(), ADUMP_SUCCESS);
    EXPECT_EQ(g_profRegisterCalls, 1U);
    EXPECT_EQ(g_parseRegisterCalls, 3U);
    DfxInfoParser::Instance().UnInit();
    EXPECT_EQ(g_parseRegisterCalls, 4U);
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
    MOCKER(MsprofRegisterCallback).stubs().will(invoke(captureMsprofCallback));
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

// ===== 超大 Tensor（DUMP_SUPER_TENSOR / DUMP_SUPER_TENSOR_BODY）用例 =====

// 单包完成：header 一块即包含整个 tensor（dumpSize == length）
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorSinglePacket)
{
    BlockBuffer block(512);
    const uint8_t tensorData[] = {10, 20, 30, 40};
    const uint32_t tlvLen = BuildSuperTensorHeaderTlv(
        block.dumpStartAddr, 4U, sizeof(tensorData), sizeof(tensorData), tensorData, sizeof(tensorData));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, tlvLen);
    EXPECT_NE(output.find("DumpTensor: desc=200"), std::string::npos);
    EXPECT_NE(output.find("dump_size=4"), std::string::npos);
    EXPECT_NE(output.find("10,20,30,40"), std::string::npos) << output;
    // 单包完成，上下文应清空
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, false);
}

// 分片完成：header 首段 + 多个 body 续打 + 完成判定（offset + dumpSize == length）
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorMultiPacketWithShape)
{
    BlockBuffer block(1024);
    uint32_t off = 0;
    const uint32_t shape[] = {3, 4};
    const uint8_t seg0[] = {1, 2, 3, 4};
    const uint8_t seg1[] = {5, 6, 7, 8};
    const uint8_t seg2[] = {9, 10, 11, 12};
    off += BuildSuperTensorHeaderTlv(block.dumpStartAddr + off, 4U, 2U, shape, 12U, sizeof(seg0), seg0, sizeof(seg0));
    off += BuildSuperTensorBodyTlv(block.dumpStartAddr + off, 12U, 4U, sizeof(seg1), seg1, sizeof(seg1));
    off += BuildSuperTensorBodyTlv(block.dumpStartAddr + off, 12U, 8U, sizeof(seg2), seg2, sizeof(seg2));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, off);
    EXPECT_NE(output.find("DumpTensor: desc=200"), std::string::npos);
    EXPECT_NE(output.find("dump_size=12"), std::string::npos);
    // shape 括号对齐：与整段打印 [[1,2,3,4],\n[5,6,7,8],\n[9,10,11,12]] 一致（跨分片续算全局下标）
    EXPECT_NE(output.find("[[1,2,3,4],\n[5,6,7,8],\n[9,10,11,12]]"), std::string::npos) << output;
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, false);
}

// body 无打开上下文（首包丢失）：丢弃 + 告警，不影响后续 TLV 消费
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorBodyWithoutHeader)
{
    BlockBuffer block(512);
    const uint8_t seg1[] = {5, 6, 7, 8};
    const uint32_t bodyTlvLen = BuildSuperTensorBodyTlv(block.dumpStartAddr, 12U, 4U, sizeof(seg1), seg1, sizeof(seg1));
    const std::string msg = "after body";
    const uint32_t printfTlvLen = BuildPrintfTlv(block.dumpStartAddr + bodyTlvLen, msg);
    const uint32_t off = bodyTlvLen + printfTlvLen;
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, off); // body 被丢弃但 TLV 帧仍被消费
    // 孤儿 body 经 operator[] 插入本流空表项（valid=false），不污染其他流；表项待 header 填充
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, false);
    DfxInfoParser::Instance().superTensorCtxMap_.clear();
}

// body length 与上下文不匹配：丢弃该 body
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorBodyLengthMismatch)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    const uint32_t shape[] = {2, 2};
    const uint8_t seg0[] = {1, 2};
    const uint8_t seg1[] = {3, 4};
    off += BuildSuperTensorHeaderTlv(block.dumpStartAddr + off, 4U, 2U, shape, 4U, sizeof(seg0), seg0, sizeof(seg0));
    // body 的 length 与 header 不同（8 != 4），应丢弃
    off += BuildSuperTensorBodyTlv(block.dumpStartAddr + off, 8U, 2U, sizeof(seg1), seg1, sizeof(seg1));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, off);
    EXPECT_NE(output.find("1,2"), std::string::npos) << output;
    EXPECT_EQ(output.find("3,4"), std::string::npos) << output; // 不匹配的 body 不打印
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, true); // 上下文仍未完成
    DfxInfoParser::Instance().superTensorCtxMap_.clear(); // 清理，避免影响其他用例
}

// header infoLen 不足结构体长度：丢弃 + 不崩溃
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorHeaderInfoLenTooSmall)
{
    BlockBuffer block(256);
    WriteTlv(block.dumpStartAddr, cce::runtime::DumpType::DUMP_SUPER_TENSOR, 4);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, sizeof(DumpInfoHead) + 4);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, sizeof(DumpInfoHead) + 4);
}

// body infoLen 不足结构体长度：丢弃 + 不崩溃
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorBodyInfoLenTooSmall)
{
    BlockBuffer block(256);
    WriteTlv(block.dumpStartAddr, cce::runtime::DumpType::DUMP_SUPER_TENSOR_BODY, 4);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, sizeof(DumpInfoHead) + 4);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, sizeof(DumpInfoHead) + 4);
}

// dumpSize 超可用长度（含对齐尾）：按可用长度裁剪打印
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorDumpSizeClipped)
{
    BlockBuffer block(512);
    const uint8_t tensorData[] = {1, 2, 3, 4};
    const uint32_t padLen = 4U; // 对齐尾
    // infoLen = sizeof(header) + 4 数据 + 4 对齐尾，可用数据 8 字节；dumpSize 声明 12 超可用，按 8 裁剪
    const uint32_t tlvLen =
        BuildSuperTensorHeaderTlv(block.dumpStartAddr, 4U, 8U, 12U, tensorData, sizeof(tensorData), padLen);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, tlvLen);
    EXPECT_NE(output.find("exceeds available data size[8 bytes]"), std::string::npos) << output;
    EXPECT_NE(output.find("1,2,3,4"), std::string::npos) << output;
}

// 不支持的数据类型：日志提示不输出数据
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorUnsupportedDataType)
{
    BlockBuffer block(512);
    const uint32_t tlvLen = BuildSuperTensorHeaderTlv(block.dumpStartAddr, 999U, 4U, 4U, nullptr, 0U);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, false);
}

// super tensor 前后其他类型 TLV（普通 printf/普通 tensor），上下文不受影响
// 注：设备侧已确认 super tensor 的 header/body 顺序写入、无交错分块，故不在 header 与 body 之间夹其他 TLV
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorWithOtherTlvAround)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    const std::string msg = "printf before super tensor";
    off += BuildPrintfTlv(block.dumpStartAddr + off, msg);
    const uint32_t shape[] = {2, 2};
    const uint8_t seg0[] = {1, 2};
    off += BuildSuperTensorHeaderTlv(block.dumpStartAddr + off, 4U, 2U, shape, 4U, sizeof(seg0), seg0, sizeof(seg0));
    const uint8_t seg1[] = {3, 4};
    off += BuildSuperTensorBodyTlv(block.dumpStartAddr + off, 4U, 2U, sizeof(seg1), seg1, sizeof(seg1));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, off);
    EXPECT_NE(output.find("printf before super tensor"), std::string::npos);
    EXPECT_NE(output.find("[[1,2],\n[3,4]]"), std::string::npos) << output;
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, false);
}

// length 为 0：丢弃 + 告警
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorZeroLength)
{
    BlockBuffer block(512);
    const uint32_t tlvLen = BuildSuperTensorHeaderTlv(block.dumpStartAddr, 4U, 0U, 4U, nullptr, 0U);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, false);
}

// 跨回调续打：header 在上一包、body 在下一包（模拟多次 block 快照回调），上下文跨回调驻留
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorAcrossCallbacks)
{
    // 第一包：header + 首段
    BlockBuffer block1(512);
    uint32_t off1 = 0;
    const uint32_t shape[] = {2, 3};
    const uint8_t seg0[] = {1, 2, 3};
    off1 += BuildSuperTensorHeaderTlv(block1.dumpStartAddr + off1, 4U, 2U, shape, 6U, sizeof(seg0), seg0, sizeof(seg0));
    uint64_t consumedLen1 = 0U;
    rtDfxParseParam param1 = MakeParam(block1.blockAddr, block1.data.size(), 0, off1);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param1, &consumedLen1);
    const std::string output1 = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen1, off1);
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, true);

    // 第二包（模拟新 block 快照回调）：剩余 body，完成整 tensor
    BlockBuffer block2(512);
    const uint8_t seg1[] = {4, 5, 6};
    const uint32_t off2 = BuildSuperTensorBodyTlv(block2.dumpStartAddr, 6U, 3U, sizeof(seg1), seg1, sizeof(seg1));
    uint64_t consumedLen2 = 0U;
    rtDfxParseParam param2 = MakeParam(block2.blockAddr, block2.data.size(), 0, off2);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param2, &consumedLen2);
    const std::string output2 = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen2, off2);
    EXPECT_NE(output2.find("4,5,6"), std::string::npos) << output2;
    EXPECT_EQ(
        DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid,
        false); // offset + dumpSize == length 完成
}

// ===== 超大 Tensor 补充用例（对齐 asc-devkit asc_dump_super_tensor_impl 真实行为） =====

// 设备侧真实对齐参数：ASC_ONE_DATABLOCK_SIZE = 32B（L0C 为 1024B），alignDumpLen = align_up(dumpSize, 32)
constexpr uint32_t SUPER_TENSOR_ALIGN = 32U;

// bool 类型分段：header + body 续打，值按 1/0 输出、shape 括号对齐
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorBoolSegments)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    const uint32_t shape[] = {2, 2};
    const uint8_t seg0[] = {1, 0};
    const uint8_t seg1[] = {1, 1};
    off += BuildSuperTensorHeaderTlv(block.dumpStartAddr + off, 12U, 2U, shape, 4U, sizeof(seg0), seg0, sizeof(seg0));
    off += BuildSuperTensorBodyTlv(block.dumpStartAddr + off, 4U, 2U, sizeof(seg1), seg1, sizeof(seg1));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, off);
    EXPECT_NE(output.find("data_type=bool"), std::string::npos) << output;
    EXPECT_NE(output.find("[[1,0],\n[1,1]]"), std::string::npos) << output;
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, false);
}

// float16 类型分段：跨分片元素续打，fp16 转换后数值正确
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorFloat16Segments)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    const uint8_t seg0[] = {0x00, 0x3C}; // fp16 1.0
    const uint8_t seg1[] = {0x00, 0x40}; // fp16 2.0
    off += BuildSuperTensorHeaderTlv(block.dumpStartAddr + off, 1U, 4U, sizeof(seg0), seg0, sizeof(seg0));
    off += BuildSuperTensorBodyTlv(block.dumpStartAddr + off, 4U, 2U, sizeof(seg1), seg1, sizeof(seg1));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, off);
    EXPECT_NE(output.find("data_type=float16"), std::string::npos) << output;
    EXPECT_NE(output.find("1.000000,2.000000"), std::string::npos) << output;
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, false);
}

// int32 类型跨 body 边界续打：分片边界不落在元素边界上时，各分片按整元素数打印
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorInt32AcrossBody)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    const int32_t data[] = {100, 200, 300, 400};
    // 首段 1 个元素（4B），第二段 3 个元素（12B）
    off +=
        BuildSuperTensorHeaderTlv(block.dumpStartAddr + off, 3U, 16U, 4U, reinterpret_cast<const uint8_t*>(data), 4U);
    off += BuildSuperTensorBodyTlv(
        block.dumpStartAddr + off, 16U, 4U, 12U, reinterpret_cast<const uint8_t*>(data) + 4U, 12U);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, off);
    EXPECT_NE(output.find("data_type=int32"), std::string::npos) << output;
    EXPECT_NE(output.find("100,200,300,400"), std::string::npos) << output;
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, false);
}

// dim 超 8 维上限：上下文按前 8 维截断，不崩溃
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorDimExceedsMax)
{
    BlockBuffer block(512);
    const uint32_t shape[] = {2, 2, 2, 2, 2, 2, 2, 2, 2, 2}; // 10 维
    const uint8_t data[] = {1, 2, 3, 4};
    const uint32_t tlvLen =
        BuildSuperTensorHeaderTlv(block.dumpStartAddr, 4U, 10U, shape, sizeof(data), sizeof(data), data, sizeof(data));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, tlvLen);
    EXPECT_EQ(
        DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].dim,
        cce::runtime::RT_DUMP_SHAPE_MAX_SIZE);
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, false); // 单块即完成
    DfxInfoParser::Instance().superTensorCtxMap_.clear();
}

// 设备侧真实行为：set_dump_shape_info 把未用维填 1（dim=2 时 shape={2,3,1,1,1,1,1,1}），解析只看前 dim 维
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorShapeUnusedDimsFilledWithOne)
{
    BlockBuffer block(512);
    const uint32_t shape[] = {2, 3, 1, 1, 1, 1, 1, 1}; // 未用维填 1
    const uint8_t data[] = {1, 2, 3, 4, 5, 6};
    const uint32_t tlvLen =
        BuildSuperTensorHeaderTlv(block.dumpStartAddr, 4U, 2U, shape, sizeof(data), sizeof(data), data, sizeof(data));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, tlvLen);
    // 仅按 dim=2 的 {2,3} 对齐括号，不受尾部 1 的影响
    EXPECT_NE(output.find("[[1,2,3],\n[4,5,6]]"), std::string::npos) << output;
}

// AIV coreType：元信息行前缀为 AIV
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorAivCoreType)
{
    BlockBuffer block(512);
    const uint8_t data[] = {1, 2};
    const uint32_t tlvLen =
        BuildSuperTensorHeaderTlv(block.dumpStartAddr, 4U, sizeof(data), sizeof(data), data, sizeof(data));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen, 1U, 0U); // coreType=AIV
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, tlvLen);
    EXPECT_NE(output.find("[AIV Block 1] DumpTensor: desc=200"), std::string::npos) << output;
    EXPECT_EQ(output.find("[AIC Block 1] DumpTensor: desc=200"), std::string::npos) << output;
}

// header offset 非 0（协议违例）：丢弃，不残留上下文
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorHeaderOffsetNonZero)
{
    BlockBuffer block(512);
    DumpInfoHead* head =
        WriteTlv(block.dumpStartAddr, cce::runtime::DumpType::DUMP_SUPER_TENSOR, sizeof(DumpSuperTensorHeader) + 4U);
    DumpSuperTensorHeader* superHead = reinterpret_cast<DumpSuperTensorHeader*>(head->infoMsg);
    superHead->dataType = 4U;
    superHead->desc = 200U;
    superHead->dim = 0U;
    superHead->length = 8U;
    superHead->offset = 4U; // 非 0，协议违例
    superHead->dumpSize = 4U;
    const uint8_t data[] = {1, 2, 3, 4};
    (void)memcpy_s(head->infoMsg + sizeof(DumpSuperTensorHeader), sizeof(data), data, sizeof(data));
    const uint32_t tlvLen = sizeof(DumpInfoHead) + sizeof(DumpSuperTensorHeader) + 4U;
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    EXPECT_EQ(consumedLen, tlvLen);
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, false); // 未打开上下文
}

// dumpSize=0：按可用长度整块打印（与现有 DumpTensor 的 dumpSize=0 语义一致）
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorDumpSizeZeroMeansWholeBlock)
{
    BlockBuffer block(512);
    const uint8_t data[] = {10, 20, 30, 40, 50, 60};
    const uint32_t tlvLen = BuildSuperTensorHeaderTlv(block.dumpStartAddr, 4U, 6U, 0U, data, sizeof(data));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, tlvLen);
    // dumpSize=0 且 dump_size（元素数）按 length 计
    EXPECT_NE(output.find("dump_size=6"), std::string::npos) << output;
    EXPECT_NE(output.find("10,20,30,40,50,60"), std::string::npos) << output;
}

// 设备侧按 32B 对齐补尾（alignDumpLen = align_up(dumpSize, 32)）：对齐尾不参与打印，只打印 dumpSize 有效数据
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorDeviceAlignmentTail)
{
    BlockBuffer block(512);
    const uint8_t seg0[] = {1, 2, 3};                                             // dumpSize=3
    const uint32_t pad0 = SUPER_TENSOR_ALIGN - sizeof(seg0) % SUPER_TENSOR_ALIGN; // 对齐到 32B
    const uint8_t seg1[] = {4, 5, 6};                                             // dumpSize=3
    const uint32_t pad1 = SUPER_TENSOR_ALIGN - sizeof(seg1) % SUPER_TENSOR_ALIGN;
    uint32_t off = 0;
    off += BuildSuperTensorHeaderTlv(block.dumpStartAddr + off, 4U, 6U, sizeof(seg0), seg0, sizeof(seg0), pad0);
    off += BuildSuperTensorBodyTlv(block.dumpStartAddr + off, 6U, 3U, sizeof(seg1), seg1, sizeof(seg1), pad1);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, off);
    EXPECT_NE(output.find("1,2,3"), std::string::npos) << output;
    EXPECT_NE(output.find("4,5,6"), std::string::npos) << output;
    // 对齐尾是 0 填充，若误打印会出现 ",0," 串（数据本身无 0 值）
    EXPECT_EQ(output.find("1,2,3,0"), std::string::npos) << output;
    EXPECT_EQ(output.find("3,0,0"), std::string::npos) << output;
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, false);
}

// body 分片 dumpSize 超余量（nextOffset > length，>= 完成判定语义）：按完成处理
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorBodyOvershootCompletes)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    const uint8_t seg0[] = {1, 2};
    const uint8_t seg1[] = {3, 4, 5, 6, 7, 8}; // 6 字节 > 剩余 2 字节
    off += BuildSuperTensorHeaderTlv(block.dumpStartAddr + off, 4U, 4U, sizeof(seg0), seg0, sizeof(seg0));
    off += BuildSuperTensorBodyTlv(block.dumpStartAddr + off, 4U, 2U, sizeof(seg1), seg1, sizeof(seg1));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, off);
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, false); // 超出即完成
}

// body dumpSize=0：按可用长度（含对齐尾）整块续打
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorBodyDumpSizeZero)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    const uint8_t seg0[] = {1, 2};
    const uint8_t seg1[] = {3, 4};
    off += BuildSuperTensorHeaderTlv(block.dumpStartAddr + off, 4U, 4U, sizeof(seg0), seg0, sizeof(seg0));
    off += BuildSuperTensorBodyTlv(block.dumpStartAddr + off, 4U, 2U, 0U, seg1, sizeof(seg1));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, off);
    EXPECT_NE(output.find("3,4"), std::string::npos) << output;
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, false);
}

// 环形回绕：header TLV 落在缓冲尾部、body TLV 绕回头部（AIC 物理偏移回绕），分片续打正常
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorRingBufferWrap)
{
    const uint8_t seg0[] = {1, 2};
    const uint8_t seg1[] = {3, 4};
    // 先在连续内存构造完整流，再按 AicPhysicalWraparoundPreservesV1ContentOrder 模式写入环形缓冲
    std::vector<uint8_t> stream(
        sizeof(DumpInfoHead) + sizeof(DumpSuperTensorHeader) + sizeof(seg0) + sizeof(DumpInfoHead) +
            sizeof(DumpSuperTensorBody) + sizeof(seg1),
        0);
    const uint32_t tlv0Len = BuildSuperTensorHeaderTlv(stream.data(), 4U, 4U, sizeof(seg0), seg0, sizeof(seg0));
    const uint32_t tlv1Len = BuildSuperTensorBodyTlv(stream.data() + tlv0Len, 4U, 2U, sizeof(seg1), seg1, sizeof(seg1));
    const uint32_t totalLen = tlv0Len + tlv1Len;

    BlockBuffer block(256U);
    // header 放尾部，body 绕回头部：readIdx 指向 header 起点，writeIdx 为 body 绕回后的结束位置
    const uint32_t readIdx = block.remainLen - tlv0Len;
    WriteRingData(block, readIdx, stream.data(), totalLen);
    const uint32_t writeIdx = totalLen - tlv0Len;

    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), readIdx, writeIdx);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, totalLen);
    EXPECT_NE(output.find("1,2"), std::string::npos) << output;
    EXPECT_NE(output.find("3,4"), std::string::npos) << output;
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, false);
}

// UnInit 清空打印上下文兜底：残留的未完成 super tensor 不影响下一用例
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorUnInitClearsCtx)
{
    BlockBuffer block(512);
    const uint32_t shape[] = {2, 2};
    const uint8_t seg0[] = {1, 2};
    const uint32_t tlvLen =
        BuildSuperTensorHeaderTlv(block.dumpStartAddr, 4U, 2U, shape, 4U, sizeof(seg0), seg0, sizeof(seg0));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    ASSERT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, true); // 尚未完成

    DfxInfoParser::Instance().UnInit(); // TearDown 也会调用，此处显式触发验证兜底
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, false);
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].length, 0U);
}

// 同一回调内连续两个 super tensor：第一个完成后第二个 header 覆写上下文，互不串扰
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorTwoTensorsSequential)
{
    BlockBuffer block(1024);
    uint32_t off = 0;
    const uint8_t t1s0[] = {1, 2, 3};
    const uint8_t t1s1[] = {4, 5, 6};
    const uint8_t t2s0[] = {7, 8, 9};
    const uint8_t t2s1[] = {10, 11, 12};
    off += BuildSuperTensorHeaderTlv(block.dumpStartAddr + off, 4U, 6U, 3U, t1s0, sizeof(t1s0));
    off += BuildSuperTensorBodyTlv(block.dumpStartAddr + off, 6U, 3U, 3U, t1s1, sizeof(t1s1));
    off += BuildSuperTensorHeaderTlv(block.dumpStartAddr + off, 4U, 6U, 3U, t2s0, sizeof(t2s0));
    off += BuildSuperTensorBodyTlv(block.dumpStartAddr + off, 6U, 3U, 3U, t2s1, sizeof(t2s1));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, off);
    EXPECT_NE(output.find("1,2,3,4,5,6"), std::string::npos) << output;
    EXPECT_NE(output.find("7,8,9,10,11,12"), std::string::npos) << output;
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, false);
}

// 超大元素数 length（>4G 字节）：uint64 长度不截断，dump_size 元素数正确
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorLargeTensorLength)
{
    BlockBuffer block(512);
    const uint8_t data[] = {1, 2, 3, 4};
    constexpr uint64_t hugeLength = 8ULL * 1024ULL * 1024ULL * 1024ULL; // 8G 字节
    const uint32_t tlvLen =
        BuildSuperTensorHeaderTlv(block.dumpStartAddr, 4U, hugeLength, sizeof(data), data, sizeof(data));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, tlvLen);
    EXPECT_NE(output.find("tensor_bytes=" + std::to_string(hugeLength)), std::string::npos) << output;
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].length, hugeLength);
    EXPECT_EQ(
        DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, true); // 8G 只到了 4B，未完成
    DfxInfoParser::Instance().superTensorCtxMap_.clear();
}

// header infoLen 不足但已含完整头字段（infoLen 恰等于 sizeof）：dumpSize=0、无数据段，上下文打开但无输出数据
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorHeaderOnlyNoData)
{
    BlockBuffer block(512);
    DumpInfoHead* head =
        WriteTlv(block.dumpStartAddr, cce::runtime::DumpType::DUMP_SUPER_TENSOR, sizeof(DumpSuperTensorHeader));
    DumpSuperTensorHeader* superHead = reinterpret_cast<DumpSuperTensorHeader*>(head->infoMsg);
    superHead->dataType = 4U;
    superHead->desc = 200U;
    superHead->dim = 0U;
    superHead->length = 8U;
    superHead->offset = 0U;
    superHead->dumpSize = 0U;
    const uint32_t tlvLen = sizeof(DumpInfoHead) + sizeof(DumpSuperTensorHeader);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, tlvLen);
    EXPECT_NE(output.find("DumpTensor: desc=200"), std::string::npos) << output;
    EXPECT_EQ(
        DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid,
        true); // 8 字节还没到，上下文保持打开
    DfxInfoParser::Instance().superTensorCtxMap_.clear();
}

// body dumpSize 超可用长度（含对齐尾）：按可用长度裁剪续打，告警含 desc
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorBodyDumpSizeClipped)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    const uint8_t seg0[] = {1, 2};
    const uint8_t seg1[] = {3, 4};
    const uint32_t padLen = 4U;
    off += BuildSuperTensorHeaderTlv(block.dumpStartAddr + off, 4U, 4U, sizeof(seg0), seg0, sizeof(seg0));
    // body infoLen = sizeof(body) + 2 数据 + 4 对齐尾 = 38 → 可用 6 字节；dumpSize 声明 12 超可用
    off += BuildSuperTensorBodyTlv(block.dumpStartAddr + off, 4U, 2U, 12U, seg1, sizeof(seg1), padLen);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, off);
    EXPECT_NE(output.find("exceeds available data size[6 bytes]"), std::string::npos) << output;
    EXPECT_NE(output.find("3,4"), std::string::npos) << output;
    EXPECT_EQ(
        DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid,
        false); // 2+6 >= 4 裁剪后仍完成
}

// 空 tensor 分段（length 有效但数据不足 1 个元素）+ 尾段补空：输出空括号收尾
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorEmptySegmentTail)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    const uint8_t seg0[] = {1, 2};
    off += BuildSuperTensorHeaderTlv(block.dumpStartAddr + off, 4U, 2U, sizeof(seg0), seg0, sizeof(seg0));
    // 尾 body 携带 0 字节有效数据（dumpSize=0 且无数据载荷），nextOffset=2+0=2 >= length=2 判完成
    off += BuildSuperTensorBodyTlv(block.dumpStartAddr + off, 2U, 2U, 0U, nullptr, 0U);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, off);
    EXPECT_NE(output.find("1,2"), std::string::npos) << output;
    EXPECT_EQ(
        DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, false); // 完成判定覆盖空尾段
}

// header shape 某维为 0：按无 shape 平铺打印（维度 0 视为无效，不参与括号对齐）
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorZeroDimInShape)
{
    BlockBuffer block(512);
    const uint32_t shape[] = {0, 4}; // 第一维为 0
    const uint8_t data[] = {1, 2, 3, 4};
    const uint32_t tlvLen =
        BuildSuperTensorHeaderTlv(block.dumpStartAddr, 4U, 2U, shape, sizeof(data), sizeof(data), data, sizeof(data));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, tlvLen);
    // 无括号平铺输出，不出现 0 除/异常括号
    EXPECT_NE(output.find("1,2,3,4"), std::string::npos) << output;
    EXPECT_EQ(output.find("[["), std::string::npos) << output;
}

// bf16 类型分段：跨分片转换正确（0x3F80 = 1.0）
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorBFloat16Segments)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    const uint8_t seg0[] = {0x80, 0x3F}; // bf16 1.0
    const uint8_t seg1[] = {0x00, 0x40}; // bf16 2.0
    off += BuildSuperTensorHeaderTlv(block.dumpStartAddr + off, 27U, 4U, sizeof(seg0), seg0, sizeof(seg0));
    off += BuildSuperTensorBodyTlv(block.dumpStartAddr + off, 4U, 2U, sizeof(seg1), seg1, sizeof(seg1));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, off);
    EXPECT_NE(output.find("data_type=bfloat16"), std::string::npos) << output;
    EXPECT_NE(output.find("1.000000,2.000000"), std::string::npos) << output;
}

// 3 维 shape 跨分片：深层括号嵌套对齐（[2,2,2]，body 从中间层切入）
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorThreeDimShape)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    const uint32_t shape[] = {2, 2, 2};
    const uint8_t seg0[] = {1, 2, 3, 4}; // 2x2x2 的前半：[[1,2],[3,4]],
    const uint8_t seg1[] = {5, 6, 7, 8}; // 后半：[[5,6],[7,8]]]
    off += BuildSuperTensorHeaderTlv(block.dumpStartAddr + off, 4U, 3U, shape, 8U, sizeof(seg0), seg0, sizeof(seg0));
    off += BuildSuperTensorBodyTlv(block.dumpStartAddr + off, 8U, 4U, sizeof(seg1), seg1, sizeof(seg1));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, off);
    EXPECT_NE(output.find("[[[1,2],\n[3,4]],\n[[5,6],\n[7,8]]]"), std::string::npos) << output;
}

// ===== 检视意见修复配套用例（MR 6098：offset 连续性 / 流来源 / shape 乘积溢出 / header 重入） =====

// body offset 与 printedOffset 不连续（gap）：丢弃该 body + 告警，后续正确 body 仍可续打
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorBodyOffsetGapDropped)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    const uint32_t shape[] = {2, 2};
    const uint8_t seg0[] = {1, 2};
    const uint8_t gapSeg[] = {9, 9}; // offset 跳到 4（应为 2）
    const uint8_t seg2[] = {3, 4};
    off += BuildSuperTensorHeaderTlv(block.dumpStartAddr + off, 4U, 2U, shape, 4U, sizeof(seg0), seg0, sizeof(seg0));
    off += BuildSuperTensorBodyTlv(block.dumpStartAddr + off, 4U, 4U, sizeof(gapSeg), gapSeg, sizeof(gapSeg));
    off += BuildSuperTensorBodyTlv(block.dumpStartAddr + off, 4U, 2U, sizeof(seg2), seg2, sizeof(seg2));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, off);
    EXPECT_NE(output.find("not continuous with printedOffset=2"), std::string::npos) << output;
    EXPECT_EQ(output.find("9,9"), std::string::npos) << output; // gap 段不打印
    // 期望串会被 gap 告警（slog stub 打 stdout）打断，拆开验证：起始段与完成段均存在
    EXPECT_NE(output.find("[[1,2],"), std::string::npos) << output; // 起始段已打印
    EXPECT_NE(output.find("3,4]]"), std::string::npos) << output;   // 完成段正常续打收尾
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, false);
}

// body offset 回退（overlap，重复段）：丢弃 + 不重复打印
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorBodyOffsetOverlapDropped)
{
    BlockBuffer block(512);
    uint32_t off = 0;
    const uint8_t seg0[] = {1, 2};
    const uint8_t overlapSeg[] = {9, 9}; // offset 回退到 0（应为 2）
    off += BuildSuperTensorHeaderTlv(block.dumpStartAddr + off, 4U, 4U, sizeof(seg0), seg0, sizeof(seg0));
    off +=
        BuildSuperTensorBodyTlv(block.dumpStartAddr + off, 4U, 0U, sizeof(overlapSeg), overlapSeg, sizeof(overlapSeg));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, off);
    EXPECT_NE(output.find("not continuous with printedOffset=2"), std::string::npos) << output;
    EXPECT_EQ(output.find("9,9"), std::string::npos) << output;
    EXPECT_NE(output.find("1,2"), std::string::npos) << output;
}

// 双流（不同 coreId 回调）并发 dump 超大 tensor：ctx 表按流隔离，各自独立续打互不覆盖
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorTwoStreamsInterleaved)
{
    const uint32_t shape[] = {2, 2};
    const auto key0 = std::make_tuple(0U, 0U, 0U); // coreId=0 的流
    const auto key1 = std::make_tuple(0U, 0U, 1U); // coreId=1 的流
    uint64_t consumedLen = 0U;

    // 流0：header（desc=200，数据 1,2）
    BlockBuffer b1(512);
    const uint8_t seg0[] = {1, 2};
    const uint32_t len1 =
        BuildSuperTensorHeaderTlv(b1.dumpStartAddr, 4U, 2U, shape, 4U, sizeof(seg0), seg0, sizeof(seg0));
    rtDfxParseParam p1 = MakeParam(b1.blockAddr, b1.data.size(), 0, len1, 0U, 0U);
    DfxInfoParser::Instance().ParseDfxInfo(&p1, &consumedLen);
    ASSERT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[key0].valid, true);

    // 流1：header（desc=201，数据 5,6）——旧实现会覆盖流0 的上下文；ctx 表下各自独立
    BlockBuffer b2(512);
    const uint8_t seg1[] = {5, 6};
    DumpInfoHead* head =
        WriteTlv(b2.dumpStartAddr, cce::runtime::DumpType::DUMP_SUPER_TENSOR, sizeof(DumpSuperTensorHeader) + 2U);
    DumpSuperTensorHeader* superHead = reinterpret_cast<DumpSuperTensorHeader*>(head->infoMsg);
    superHead->dataType = 4U;
    superHead->desc = 201U;
    superHead->dim = 2U;
    superHead->shape[0] = 2U;
    superHead->shape[1] = 2U;
    superHead->length = 4U;
    superHead->offset = 0U;
    superHead->dumpSize = 2U;
    (void)memcpy_s(head->infoMsg + sizeof(DumpSuperTensorHeader), 2U, seg1, 2U);
    const uint32_t len2 = sizeof(DumpInfoHead) + sizeof(DumpSuperTensorHeader) + 2U;
    rtDfxParseParam p2 = MakeParam(b2.blockAddr, b2.data.size(), 0, len2, 0U, 1U);
    DfxInfoParser::Instance().ParseDfxInfo(&p2, &consumedLen);
    ASSERT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[key1].valid, true);
    ASSERT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[key0].valid, true); // 流0 上下文未被覆盖

    // 两流 body 交错到达：流0 续打 3,4 完成；流1 续打 7,8 完成
    const uint8_t seg2[] = {3, 4}; // 流0 第二段
    const uint8_t seg3[] = {7, 8}; // 流1 第二段
    testing::internal::CaptureStdout();
    BlockBuffer b3(512);
    const uint32_t len3 = BuildSuperTensorBodyTlv(b3.dumpStartAddr, 4U, 2U, sizeof(seg2), seg2, sizeof(seg2));
    rtDfxParseParam p3 = MakeParam(b3.blockAddr, b3.data.size(), 0, len3, 0U, 0U); // 流0 body
    DfxInfoParser::Instance().ParseDfxInfo(&p3, &consumedLen);
    BlockBuffer b4(512);
    const uint32_t len4 = BuildSuperTensorBodyTlv(b4.dumpStartAddr, 4U, 2U, sizeof(seg3), seg3, sizeof(seg3));
    rtDfxParseParam p4 = MakeParam(b4.blockAddr, b4.data.size(), 0, len4, 0U, 1U); // 流1 body
    DfxInfoParser::Instance().ParseDfxInfo(&p4, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_NE(output.find("3,4]]"), std::string::npos) << output; // 流0 完整
    EXPECT_NE(output.find("7,8]]"), std::string::npos) << output; // 流1 完整
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[key0].valid, false);
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[key1].valid, false);
    DfxInfoParser::Instance().superTensorCtxMap_.clear();
}

// 跨流 header（新流覆盖未完成上下文）：告警旧 tensor 未完成，新 tensor 数据正确打印
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorHeaderReentryWarns)
{
    BlockBuffer block(512);
    const uint32_t shape[] = {2, 2};
    const uint8_t seg0[] = {1, 2};
    const uint32_t tlvLen =
        BuildSuperTensorHeaderTlv(block.dumpStartAddr, 4U, 2U, shape, 4U, sizeof(seg0), seg0, sizeof(seg0));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param1 = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen, 0U, 0U);
    DfxInfoParser::Instance().ParseDfxInfo(&param1, &consumedLen);
    ASSERT_EQ(
        DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, true); // 旧 tensor 未完成

    // 新 header（不同 desc）到达：告警覆盖，新 tensor 单包完成
    BlockBuffer block2(512);
    const uint8_t data2[] = {7, 8, 9, 10};
    DumpInfoHead* head =
        WriteTlv(block2.dumpStartAddr, cce::runtime::DumpType::DUMP_SUPER_TENSOR, sizeof(DumpSuperTensorHeader) + 4U);
    DumpSuperTensorHeader* superHead = reinterpret_cast<DumpSuperTensorHeader*>(head->infoMsg);
    superHead->dataType = 4U;
    superHead->desc = 300U;
    superHead->dim = 0U;
    superHead->length = 4U;
    superHead->offset = 0U;
    superHead->dumpSize = 4U;
    (void)memcpy_s(head->infoMsg + sizeof(DumpSuperTensorHeader), sizeof(data2), data2, sizeof(data2));
    const uint32_t tlv2Len = sizeof(DumpInfoHead) + sizeof(DumpSuperTensorHeader) + 4U;
    rtDfxParseParam param2 = MakeParam(block2.blockAddr, block2.data.size(), 0, tlv2Len, 0U, 0U);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param2, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_NE(output.find("is not finished (printed=2/4"), std::string::npos) << output;
    EXPECT_NE(output.find("desc=300"), std::string::npos) << output; // 新 tensor 元信息
    EXPECT_NE(output.find("7,8,9,10"), std::string::npos) << output; // 新 tensor 数据
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, false);
}

// shape 后缀乘积溢出（2^72 回绕 0）：降级平铺打印 + 告警，不除零不崩溃
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorShapeProductOverflow)
{
    BlockBuffer block(512);
    // 65536^4 * 4^4 = 2^72 > size_t(64)，后缀乘积回绕为 0
    const uint32_t shape[] = {65536, 65536, 65536, 65536, 4, 4, 4, 4};
    const uint8_t data[] = {1, 2, 3, 4};
    const uint32_t tlvLen =
        BuildSuperTensorHeaderTlv(block.dumpStartAddr, 4U, 8U, shape, sizeof(data), sizeof(data), data, sizeof(data));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen); // 修复前此处 SIGFPE（x86）
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, tlvLen);
    EXPECT_NE(output.find("exceeds the maximum value"), std::string::npos) << output;
    EXPECT_NE(output.find("1,2,3,4"), std::string::npos) << output; // 平铺打印数据完整
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, false);
}

// ===== 1M 打屏上限用例：超限以 "..." 省略 + 告警（ASCEND_DUMP_PATH 落盘 + show_kernel_debug_data） =====
// 注：元素计数用完整元素值（如 "777777"）而非单字符——slog stub 把 IDE_LOGx 也打到 stdout，
// 行号/tid/dump_size 等数字会污染单字符计数；完整值仅数据行命中，计数确定性有保证。

// 单包超 1M：只打前 1M 数据（262144 个 int32），"..." 省略 + 告警一次，consumedLen 仍为整包（完成判定不受截断影响）
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorPrintLimitSinglePacket)
{
    constexpr size_t limitBytes = 1024U * 1024U; // 与 MAX_SUPER_TENSOR_PRINT_BYTES 一致
    constexpr uint16_t int32Size = 4U;
    constexpr int32_t elemVal = 777777;
    const size_t totalBytes = limitBytes + int32Size; // 超 1M 一个元素
    std::vector<int32_t> tensorData(totalBytes / int32Size, elemVal);
    BlockBuffer block(totalBytes + 256U);
    const uint32_t tlvLen = BuildSuperTensorHeaderTlv(
        block.dumpStartAddr, 3U, totalBytes, totalBytes, reinterpret_cast<const uint8_t*>(tensorData.data()),
        totalBytes);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, tlvLen); // 整包消费，截断只影响打屏
    EXPECT_EQ(CountOccurrences(output, "777777"), limitBytes / int32Size) << output; // 恰好打 1M 字节
    EXPECT_NE(output.find("..."), std::string::npos) << output;                      // "..." 省略
    EXPECT_NE(output.find("ASCEND_DUMP_PATH"), std::string::npos) << output;         // 落盘指引
    EXPECT_NE(output.find("show_kernel_debug_data"), std::string::npos) << output;   // 工具指引
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, false); // 仍正常完成
}

// 恰好 1M（不超限）：不截断、"..." 与告警均不出现（边界）
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorPrintLimitExactBytes)
{
    constexpr size_t limitBytes = 1024U * 1024U;
    constexpr uint16_t int32Size = 4U;
    constexpr int32_t elemVal = 777777;
    std::vector<int32_t> tensorData(limitBytes / int32Size, elemVal);
    BlockBuffer block(limitBytes + 256U);
    const uint32_t tlvLen = BuildSuperTensorHeaderTlv(
        block.dumpStartAddr, 3U, limitBytes, limitBytes, reinterpret_cast<const uint8_t*>(tensorData.data()),
        limitBytes);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, tlvLen);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, tlvLen);
    EXPECT_EQ(CountOccurrences(output, "777777"), limitBytes / int32Size) << output; // 全量打印
    EXPECT_EQ(output.find("..."), std::string::npos) << output;                      // 恰好 1M 不省略
    EXPECT_EQ(output.find("too large"), std::string::npos) << output;
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, false);
}

// 分片跨 1M 边界：首段打满 1M，跨界 body 只补打差额，再后续 body 全省略；"..." 与打屏告警各一次；
// ctx 推进/完成不受截断影响
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorPrintLimitCrossSegment)
{
    constexpr size_t limitBytes = 1024U * 1024U;
    constexpr uint16_t int32Size = 4U;
    const size_t seg0Len = limitBytes - 4U; // 首段打 1M-4（262143 个元素）
    const size_t seg1Len = 8U;              // body1 跨界：只补打 4 字节（1 个元素）即满 1M
    const size_t seg2Len = 8U;              // body2 完全省略
    const size_t totalBytes = seg0Len + seg1Len + seg2Len;
    std::vector<int32_t> seg0(seg0Len / int32Size, 111111);
    std::vector<int32_t> seg1(seg1Len / int32Size, 222222);
    std::vector<int32_t> seg2(seg2Len / int32Size, 333333);
    BlockBuffer block(totalBytes + 512U);
    uint32_t off = 0U;
    off += BuildSuperTensorHeaderTlv(
        block.dumpStartAddr + off, 3U, totalBytes, seg0Len, reinterpret_cast<const uint8_t*>(seg0.data()), seg0Len);
    off += BuildSuperTensorBodyTlv(
        block.dumpStartAddr + off, totalBytes, seg0Len, seg1Len, reinterpret_cast<const uint8_t*>(seg1.data()),
        seg1Len);
    off += BuildSuperTensorBodyTlv(
        block.dumpStartAddr + off, totalBytes, seg0Len + seg1Len, seg2Len,
        reinterpret_cast<const uint8_t*>(seg2.data()), seg2Len);
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, off);
    // 首段全打（262143 个）；body1 跨界只补打 1 个元素；body2 全省略
    EXPECT_EQ(CountOccurrences(output, "111111"), seg0Len / int32Size) << output;
    EXPECT_EQ(CountOccurrences(output, "222222"), 1U) << output;
    EXPECT_EQ(CountOccurrences(output, "333333"), 0U) << output;
    // "..." 与打屏告警（cout 行以 "Warning:" 开头）各一次
    EXPECT_EQ(CountOccurrences(output, "..."), 1U) << output;
    EXPECT_EQ(CountOccurrences(output, "Warning: the tensor data is too large"), 1U) << output;
    EXPECT_NE(output.find("show_kernel_debug_data"), std::string::npos) << output;
    EXPECT_EQ(
        DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, false); // 完成不受截断影响
}

// 截断后的后续 tensor：省略标志随新 header 复位，新 tensor 从头打屏
TEST_F(DfxInfoParserUtest, Test_ParseDfxInfo_SuperTensorPrintLimitResetByNewHeader)
{
    constexpr size_t limitBytes = 1024U * 1024U;
    const size_t bigLen = limitBytes + 8U;
    std::vector<uint8_t> bigData(bigLen, 9U);
    const uint8_t smallData[] = {5, 6, 7, 8};
    BlockBuffer block(bigLen + sizeof(smallData) + 512U);
    uint32_t off = 0U;
    off += BuildSuperTensorHeaderTlv(block.dumpStartAddr + off, 4U, bigLen, bigLen, bigData.data(), bigLen);
    off += BuildSuperTensorHeaderTlv(
        block.dumpStartAddr + off, 4U, sizeof(smallData), sizeof(smallData), smallData, sizeof(smallData));
    uint64_t consumedLen = 0U;
    rtDfxParseParam param = MakeParam(block.blockAddr, block.data.size(), 0, off);
    testing::internal::CaptureStdout();
    DfxInfoParser::Instance().ParseDfxInfo(&param, &consumedLen);
    const std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(consumedLen, off);
    EXPECT_NE(output.find("5,6,7,8"), std::string::npos) << output; // 新 tensor 未被旧省略标志影响
    EXPECT_NE(output.find("..."), std::string::npos) << output;     // 旧 tensor 的省略仍可见
    EXPECT_EQ(DfxInfoParser::Instance().superTensorCtxMap_[std::make_tuple(0U, 0U, 0U)].valid, false);
}
