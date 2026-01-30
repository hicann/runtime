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
#include "prof_ctrl_callback_manager.hpp"
#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;

namespace {
    const uint32_t PARAM_VALUE_LEN = 8;
    const uint32_t SIMD_PRINT_RSV_LEN = 8;
    const uint32_t SIMT_PRINT_RSV_LEN = 40;
}

class PrintfTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {}


    static void TearDownTestCase()
    {}


    virtual void SetUp()
    {}


    virtual void TearDown()
    {}
};

template<typename T>
unsigned char*DumpInfoAppendByte(unsigned char*buf, T src)
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

static unsigned char* ConstructBlock(unsigned char* data, uint32_t timeStampInfoLen) {
    unsigned char* addr = data;
    int32_t dumpSize = 10; // timestamp类型tlv个数
    size_t dataLen = sizeof(BlockInfo) + sizeof(BlockReadInfo)
        + (sizeof(DumpInfoHead) + timeStampInfoLen) * dumpSize + sizeof(BlockWriteInfo);
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
    unsigned char* writeInfoAddr = (unsigned char*) (addr + blockInfo.length - sizeof(BlockWriteInfo));
    data = DumpInfoAppendByte(writeInfoAddr, writeInfo);
    return data;
}

int32_t MsprofReportAdditionalInfoStub(uint32_t nonPersistantFlag, const VOID_PTR data, uint32_t length) {
    MsprofAdditionalInfo *report_data = (MsprofAdditionalInfo *)data;
    EXPECT_EQ(report_data->level, MSPROF_REPORT_AIC_LEVEL);
    EXPECT_EQ(report_data->type, MSPROF_REPORT_AIC_TIMESTAMP_TYPE);
    MsprofAicTimeStampInfo* profTimestampData = reinterpret_cast<MsprofAicTimeStampInfo *>(report_data->data);
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
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RawDevice *dev = (RawDevice *)rtInstance->GetDevice(0U, 0U);
    dev->simdEnable_ = true;
    error = dev->ParseSimdPrintInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);

    auto props = dev->GetDevProperties();
    const uint64_t totalCoreNum = static_cast<uint64_t>(props.aicNum + props.aivNum);
    const size_t blockSize = 1024 * 1024;
    const uint64_t totalLen = blockSize * totalCoreNum;
    std::vector<uint8_t> hostData(totalLen, 0);
    for (size_t i = 0U; i < totalCoreNum; i++) {
        uint8_t *blockAddr = hostData.data() + blockSize * i;
        BlockInfo *blockInfo = RtPtrToPtr<BlockInfo *>(blockAddr);
        blockInfo->length = blockSize;
        blockInfo->remainLen = blockSize - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo);
        blockInfo->rsv = 7;
        blockInfo->coreId = i;

        BlockReadInfo *readInfo = RtPtrToPtr<BlockReadInfo *>(blockAddr + sizeof(BlockInfo));
        readInfo->readIdx = blockInfo->remainLen - 8;

        BlockWriteInfo *writeInfo = RtPtrToPtr<BlockWriteInfo *>(blockAddr + blockSize - sizeof(BlockWriteInfo));
        writeInfo->writeIdx = 0U;
    }

    error = ParsePrintf(hostData.data(), blockSize, dev->driver_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    cmodelDrvMemcpy_flag = 0;

    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestInitSimtPrintf) {
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    cmodelDrvMemcpy_flag = 1;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RawDevice *dev = (RawDevice *)rtInstance->GetDevice(0U, 0U);
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
    
    BlockReadInfo* readInfo = RtPtrToPtr<BlockReadInfo*>(
        deviceMemory.data() + sizeof(BlockInfo));
    EXPECT_EQ(readInfo->dumpType, DumpType::DUMP_BUFO);
    EXPECT_EQ(readInfo->readIdx, 0U);
    
    BlockWriteInfo* writeInfo = RtPtrToPtr<BlockWriteInfo*>(
        deviceMemory.data() + blockSize - sizeof(BlockWriteInfo));
    EXPECT_EQ(writeInfo->dumpType, DumpType::DUMP_BUFI);
    EXPECT_EQ(writeInfo->writeIdx, readInfo->readIdx);

    error = ParseSimtPrintf(deviceMemory.data(), blockSize, dev->driver_, dev);
    EXPECT_EQ(error, RT_ERROR_NONE);
    cmodelDrvMemcpy_flag = 0;
    rtDeviceReset(0);
}

void FillNoParamDumpInfo(DumpInfoHead *noParamDumpInfo, DumpType type, const uint32_t rsvLen)
{
    noParamDumpInfo->type = type;
    uint64_t offset = 8;
    uint32_t curIdx = rsvLen;
    (void)memcpy_s(noParamDumpInfo->infoMsg + curIdx, sizeof(offset), &offset, sizeof(offset));
    curIdx += sizeof(offset);
    const char *printInfo = "No param print.";
    (void)memcpy_s(noParamDumpInfo->infoMsg + curIdx, strlen(printInfo) + 1, printInfo, strlen(printInfo) + 1);
    curIdx += (strlen(printInfo) + 1);
    noParamDumpInfo->infoLen = curIdx;
}

void FillInvalidParamDumpInfo(DumpInfoHead *invalidParamDumpInfo, DumpType type, const uint32_t rsvLen)
{
    invalidParamDumpInfo->type = type;
    uint64_t offset = 8;
    uint32_t curIdx = rsvLen;
    (void)memcpy_s(invalidParamDumpInfo->infoMsg + curIdx, sizeof(offset), &offset, sizeof(offset));
    curIdx += sizeof(offset);
    const char *printInfo = "Invalid param %a.";
    (void)memcpy_s(invalidParamDumpInfo->infoMsg + curIdx, strlen(printInfo) + 1, printInfo, strlen(printInfo) + 1);
    curIdx += (strlen(printInfo) + 1);
    invalidParamDumpInfo->infoLen = curIdx;
}

void FillRedundantParamDumpInfo(DumpInfoHead *redundantParamDumpInfo, DumpType type, const uint32_t rsvLen)
{
    redundantParamDumpInfo->type = type;
    uint64_t offset = 8;
    uint32_t curIdx = rsvLen;
    (void)memcpy_s(redundantParamDumpInfo->infoMsg + curIdx, sizeof(offset), &offset, sizeof(offset));
    curIdx += sizeof(offset);
    const char *printInfo = "Redundant param %d.";
    (void)memcpy_s(redundantParamDumpInfo->infoMsg + curIdx, strlen(printInfo) + 1, printInfo, strlen(printInfo) + 1);
    curIdx += (strlen(printInfo) + 1);
    redundantParamDumpInfo->infoLen = curIdx;
}

void FillPrintDumpInfo(DumpInfoHead *paramPrint, DumpType type, const uint32_t rsvLen)
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

    const char *printInfo = "Test the format: d[%d], ld[%ld], lld[%lld], i[%i], u[%u], x[%x], X[%X]";
    (void)memcpy_s(paramPrint->infoMsg + curIdx, strlen(printInfo) + 1, printInfo, strlen(printInfo) + 1);
    curIdx += (strlen(printInfo) + 1);
    paramPrint->infoLen = curIdx;
}

// 绕接 circular buffer
void FillPrintDumpInfoForSimtCircular(DumpInfoHead *paramPrint, uint8_t *dumpStartAddr)
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

    const char *printInfo0 = "Test circular buffer the format: the length of the string is 66B: "; // 至此填充到尾部
    (void)memcpy_s(paramPrint->infoMsg + curIdx, strlen(printInfo0), printInfo0, strlen(printInfo0));  // 不要尾部\0
    // 绕接的部分
    const char *printInfo1 = "d[%d], ld[%ld], lld[%lld], i[%i], u[%u], x[%x], X[%X]";
    (void)memcpy_s(dumpStartAddr, strlen(printInfo1) + 1, printInfo1, strlen(printInfo1) + 1);
    curIdx += (strlen(printInfo0) + strlen(printInfo1) + 1);
    paramPrint->infoLen = curIdx;
}

void FillAssertDumpInfo(DumpInfoHead *assertInfo, DumpType type, const uint32_t rsvLen)
{
    assertInfo->type = type;
    const char *printInfo = "Test the format: %%[%%], f[%f], F[%F], p[%p], s[%s]";
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

    const char *realStr = "This is the real string";
    (void)memcpy_s(assertInfo->infoMsg + curIdx, strlen(realStr) + 1, realStr, strlen(realStr) + 1);
    curIdx += (strlen(realStr) + 1);
    assertInfo->infoLen = curIdx;
}

TEST_F(PrintfTest, TestParseBlockInfo_Print)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    cmodelDrvMemcpy_flag = 1;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RawDevice *dev = (RawDevice *)rtInstance->GetDevice(0U, 0U);

    const size_t blockSize = 1024 *1024;
    const uint64_t totalLen = blockSize * 75;
    std::vector<uint8_t> hostData(totalLen, 0);
    // 只处理第一个block，其余跳过
    uint8_t *blockAddr = hostData.data();
    BlockInfo *blockInfo = RtPtrToPtr<BlockInfo *>(blockAddr);
    blockInfo->length = blockSize;
    blockInfo->remainLen = blockSize - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo);

    BlockReadInfo *readInfo = RtPtrToPtr<BlockReadInfo *>(blockAddr + sizeof(BlockInfo));
    readInfo->readIdx = 0U;
    uint32_t endIdx = 0U;
    // 不带占位符的场景
    DumpInfoHead *dumpSkipInfo = RtPtrToPtr<DumpInfoHead *>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo));
    dumpSkipInfo->type = DumpType::DUMP_SKIP;
    dumpSkipInfo->infoLen = 0U;
    endIdx = sizeof(DumpInfoHead) + dumpSkipInfo->infoLen;
    // 不带占位符的场景
    DumpInfoHead *noParamInfo =
        RtPtrToPtr<DumpInfoHead *>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillNoParamDumpInfo(noParamInfo, DumpType::DUMP_SCALAR, SIMD_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + noParamInfo->infoLen);
    // 非法占位符场景
    DumpInfoHead *invalidParamInfo =
        RtPtrToPtr<DumpInfoHead *>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillInvalidParamDumpInfo(invalidParamInfo, DumpType::DUMP_SCALAR, SIMD_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + invalidParamInfo->infoLen);
    // 合法占位符场景
    DumpInfoHead *paramPrint =
        RtPtrToPtr<DumpInfoHead *>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillPrintDumpInfo(paramPrint, DumpType::DUMP_SCALAR, SIMD_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + paramPrint->infoLen);

    BlockWriteInfo *writeInfo = RtPtrToPtr<BlockWriteInfo *>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = endIdx;

    error = ParsePrintf(hostData.data(), blockSize, dev->driver_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    cmodelDrvMemcpy_flag = 0;

    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestParseBlockInfo_SIMT)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    cmodelDrvMemcpy_flag = 1;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RawDevice *dev = (RawDevice *)rtInstance->GetDevice(0U, 0U);

    const size_t blockSize = 1024;
    const uint64_t totalLen = blockSize;
    std::vector<uint8_t> hostData(totalLen, 0);
    // 只处理第一个block，其余跳过
    uint8_t *blockAddr = hostData.data();
    BlockInfo *blockInfo = RtPtrToPtr<BlockInfo *>(blockAddr);
    blockInfo->length = blockSize;
    blockInfo->remainLen = blockSize - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo);

    BlockReadInfo *readInfo = RtPtrToPtr<BlockReadInfo *>(blockAddr + sizeof(BlockInfo));
    readInfo->readIdx = 0U;
    uint32_t endIdx = 0U;

    // 不带占位符的场景,直接打印字符串
    DumpInfoHead *noParamInfo =
        RtPtrToPtr<DumpInfoHead *>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillNoParamDumpInfo(noParamInfo, DumpType::DUMP_SIMT_PRINTF, SIMT_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + noParamInfo->infoLen);
    // 非法占位符场景
    DumpInfoHead *invalidParamInfo =
        RtPtrToPtr<DumpInfoHead *>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillInvalidParamDumpInfo(invalidParamInfo, DumpType::DUMP_SIMT_PRINTF, SIMT_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + invalidParamInfo->infoLen);
    // 合法占位符场景
    DumpInfoHead *paramPrint =
        RtPtrToPtr<DumpInfoHead *>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillPrintDumpInfo(paramPrint, DumpType::DUMP_SIMT_PRINTF, SIMT_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + paramPrint->infoLen);

    // dump wait 1 for 18B
    DumpInfoHead *dumpWaitInfo1 = 
        RtPtrToPtr<DumpInfoHead *>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    dumpWaitInfo1->type = DumpType::DUMP_WAIT;
    dumpWaitInfo1->infoLen = 10U;
    endIdx += sizeof(DumpInfoHead) + dumpWaitInfo1->infoLen;

    // dump wait 2 for 18B
    DumpInfoHead *dumpWaitInfo2 = 
    RtPtrToPtr<DumpInfoHead *>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    dumpWaitInfo2->type = DumpType::DUMP_WAIT;
    dumpWaitInfo2->infoLen = 10U;
    endIdx += sizeof(DumpInfoHead) + dumpWaitInfo2->infoLen;

    BlockWriteInfo *writeInfo = RtPtrToPtr<BlockWriteInfo *>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = endIdx;
    writeInfo->packIdx = 5;

    error = ParseSimtPrintf(hostData.data(), blockSize, dev->driver_, dev);

    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(readInfo->readIdx + 36, writeInfo->writeIdx);
    cmodelDrvMemcpy_flag = 0;

    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestParseBlockInfo_SIMT_Exceed_Len)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    cmodelDrvMemcpy_flag = 1;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RawDevice *dev = (RawDevice *)rtInstance->GetDevice(0U, 0U);

    const size_t blockSize = 1024;
    const uint64_t totalLen = blockSize;
    std::vector<uint8_t> hostData(totalLen, 0);
    // 只处理第一个block，其余跳过
    uint8_t *blockAddr = hostData.data();
    BlockInfo *blockInfo = RtPtrToPtr<BlockInfo *>(blockAddr);
    blockInfo->length = blockSize;
    blockInfo->remainLen = blockSize - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo);

    BlockReadInfo *readInfo = RtPtrToPtr<BlockReadInfo *>(blockAddr + sizeof(BlockInfo));
    readInfo->readIdx = 0U;
    uint32_t endIdx = 0U;

    // 不带占位符的场景,直接打印字符串
    DumpInfoHead *noParamInfo =
        RtPtrToPtr<DumpInfoHead *>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillNoParamDumpInfo(noParamInfo, DumpType::DUMP_SIMT_PRINTF, SIMT_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + noParamInfo->infoLen);
    // 非法占位符场景
    DumpInfoHead *invalidParamInfo =
        RtPtrToPtr<DumpInfoHead *>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillInvalidParamDumpInfo(invalidParamInfo, DumpType::DUMP_SIMT_PRINTF, SIMT_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + invalidParamInfo->infoLen);
    // 合法占位符场景
    DumpInfoHead *paramPrint =
        RtPtrToPtr<DumpInfoHead *>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillPrintDumpInfo(paramPrint, DumpType::DUMP_SIMT_PRINTF, SIMT_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + paramPrint->infoLen);

    // dump wait 1 for 18B
    DumpInfoHead *dumpWaitInfo1 = 
        RtPtrToPtr<DumpInfoHead *>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    dumpWaitInfo1->type = DumpType::DUMP_WAIT;
    dumpWaitInfo1->infoLen = 10U;
    endIdx += sizeof(DumpInfoHead) + dumpWaitInfo1->infoLen;

    // dump wait 2 for 18B
    DumpInfoHead *dumpWaitInfo2 = 
    RtPtrToPtr<DumpInfoHead *>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    dumpWaitInfo2->type = DumpType::DUMP_WAIT;
    dumpWaitInfo2->infoLen = 10U;
    endIdx += sizeof(DumpInfoHead) + dumpWaitInfo2->infoLen;

    BlockWriteInfo *writeInfo = RtPtrToPtr<BlockWriteInfo *>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = blockInfo->remainLen + 1;  // 写指针超过remain len
    writeInfo->packIdx = 5;

    error = ParseSimtPrintf(hostData.data(), blockSize, dev->driver_, dev);

    EXPECT_EQ(error, RT_ERROR_NONE);
    cmodelDrvMemcpy_flag = 0;

    rtDeviceReset(0);
}

// 绕接场景
TEST_F(PrintfTest, TestParseBlockInfo_SIMT_Circular)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    cmodelDrvMemcpy_flag = 1;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RawDevice *dev = (RawDevice *)rtInstance->GetDevice(0U, 0U);

    const size_t blockSize = 616;
    const uint64_t totalLen = blockSize;
    std::vector<uint8_t> hostData(totalLen, 0);
    // 只处理第一个block，其余跳过
    uint8_t *blockAddr = hostData.data();
    BlockInfo *blockInfo = RtPtrToPtr<BlockInfo *>(blockAddr);
    blockInfo->length = blockSize;
    blockInfo->remainLen = blockSize - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo); // 512

    BlockReadInfo *readInfo = RtPtrToPtr<BlockReadInfo *>(blockAddr + sizeof(BlockInfo));
    readInfo->readIdx = 77U;
    uint32_t endIdx = 77U;

    // 非法占位符场景
    DumpInfoHead *invalidParamInfo =
        RtPtrToPtr<DumpInfoHead *>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillInvalidParamDumpInfo(invalidParamInfo, DumpType::DUMP_SIMT_PRINTF, SIMT_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + invalidParamInfo->infoLen); // 151
    // 合法占位符场景
    DumpInfoHead *paramPrint =
        RtPtrToPtr<DumpInfoHead *>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillPrintDumpInfo(paramPrint, DumpType::DUMP_SIMT_PRINTF, SIMT_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + paramPrint->infoLen); // 334
  
    DumpInfoHead *circlePrint =
        RtPtrToPtr<DumpInfoHead *>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillPrintDumpInfoForSimtCircular(circlePrint, blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo));
    endIdx += (sizeof(DumpInfoHead) + circlePrint->infoLen); // 566

    BlockWriteInfo *writeInfo = RtPtrToPtr<BlockWriteInfo *>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = endIdx; //512 + 54
    writeInfo->packIdx = 3;

    error = ParseSimtPrintf(hostData.data(), blockSize, dev->driver_, dev);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(readInfo->readIdx, writeInfo->writeIdx);
    cmodelDrvMemcpy_flag = 0;

    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestParseBlockInfo_SIMT_Assert)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    cmodelDrvMemcpy_flag = 1;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RawDevice *dev = (RawDevice *)rtInstance->GetDevice(0U, 0U);

    const size_t blockSize = 1024;
    const uint64_t totalLen = blockSize;
    std::vector<uint8_t> hostData(totalLen, 0);
    // 只处理最后一个block，其余跳过
    uint8_t *blockAddr = hostData.data() + (totalLen - blockSize);
    BlockInfo *blockInfo = RtPtrToPtr<BlockInfo *>(blockAddr);
    blockInfo->length = blockSize;
    blockInfo->remainLen = blockSize - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo);

    BlockReadInfo *readInfo = RtPtrToPtr<BlockReadInfo *>(blockAddr + sizeof(BlockInfo));
    readInfo->readIdx = 0U;
    uint32_t endIdx = 0;
    // 不带占位符的场景
    DumpInfoHead *noParamInfo = RtPtrToPtr<DumpInfoHead *>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo));
    FillNoParamDumpInfo(noParamInfo, DumpType::DUMP_SIMT_ASSERT, SIMT_PRINT_RSV_LEN);
    endIdx = sizeof(DumpInfoHead) + noParamInfo->infoLen;
    // 非法占位符场景
    DumpInfoHead *invalidParamInfo =
        RtPtrToPtr<DumpInfoHead *>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillInvalidParamDumpInfo(invalidParamInfo, DumpType::DUMP_SIMT_ASSERT, SIMT_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + invalidParamInfo->infoLen);
    // 冗余占位符场景
    DumpInfoHead *redundantParamInfo =
        RtPtrToPtr<DumpInfoHead *>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillRedundantParamDumpInfo(redundantParamInfo, DumpType::DUMP_SIMT_ASSERT, SIMT_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + redundantParamInfo->infoLen);
    // 合法占位符场景
    DumpInfoHead *assertInfo =
        RtPtrToPtr<DumpInfoHead *>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillAssertDumpInfo(assertInfo, DumpType::DUMP_SIMT_ASSERT, SIMT_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + assertInfo->infoLen);

    BlockWriteInfo *writeInfo = RtPtrToPtr<BlockWriteInfo *>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = endIdx;
    writeInfo->packIdx = 4;

    error = ParseSimtPrintf(hostData.data(), blockSize, dev->driver_, dev);
    EXPECT_EQ(error, RT_ERROR_NONE);
    cmodelDrvMemcpy_flag = 0;

    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestParseBlockInfo_Assert)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    cmodelDrvMemcpy_flag = 1;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RawDevice *dev = (RawDevice *)rtInstance->GetDevice(0U, 0U);

    const size_t blockSize = 1024 *1024;
    const uint64_t totalLen = blockSize * 75;
    std::vector<uint8_t> hostData(totalLen, 0);
    // 只处理最后一个block，其余跳过
    uint8_t *blockAddr = hostData.data() + (totalLen - blockSize);
    BlockInfo *blockInfo = RtPtrToPtr<BlockInfo *>(blockAddr);
    blockInfo->length = blockSize;
    blockInfo->remainLen = blockSize - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo);

    BlockReadInfo *readInfo = RtPtrToPtr<BlockReadInfo *>(blockAddr + sizeof(BlockInfo));
    readInfo->readIdx = 0U;
    uint32_t endIdx = 0;
    // 不带占位符的场景
    DumpInfoHead *noParamInfo = RtPtrToPtr<DumpInfoHead *>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo));
    FillNoParamDumpInfo(noParamInfo, DumpType::DUMP_ASSERT, SIMD_PRINT_RSV_LEN);
    endIdx = sizeof(DumpInfoHead) + noParamInfo->infoLen;
    // 非法占位符场景
    DumpInfoHead *invalidParamInfo =
        RtPtrToPtr<DumpInfoHead *>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillInvalidParamDumpInfo(invalidParamInfo, DumpType::DUMP_ASSERT, SIMD_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + invalidParamInfo->infoLen);
    // 冗余占位符场景
    DumpInfoHead *redundantParamInfo =
        RtPtrToPtr<DumpInfoHead *>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillRedundantParamDumpInfo(redundantParamInfo, DumpType::DUMP_ASSERT, SIMD_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + redundantParamInfo->infoLen);
    // 合法占位符场景
    DumpInfoHead *assertInfo =
        RtPtrToPtr<DumpInfoHead *>(blockAddr + sizeof(BlockInfo) + sizeof(BlockReadInfo) + endIdx);
    FillAssertDumpInfo(assertInfo, DumpType::DUMP_ASSERT, SIMD_PRINT_RSV_LEN);
    endIdx += (sizeof(DumpInfoHead) + assertInfo->infoLen);

    BlockWriteInfo *writeInfo = RtPtrToPtr<BlockWriteInfo *>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = endIdx;

    error = ParsePrintf(hostData.data(), blockSize, dev->driver_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    cmodelDrvMemcpy_flag = 0;

    rtDeviceReset(0);
}

TEST_F(PrintfTest, TestParseBlockInfo_TimeStamp)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);

    cmodelDrvMemcpy_flag = 1;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RawDevice *dev = (RawDevice *)rtInstance->GetDevice(0U, 0U);

    int* addr = new int[2048 * 75]();
    void *workSpaceAddr = (void *)addr;
    EXPECT_NE(workSpaceAddr, nullptr);
    const size_t blockSize = 2048U;
    const uint32_t timeStampInfoLen = 40U;
    ConstructBlock((unsigned char*)addr, timeStampInfoLen);
    rtError_t ret = RT_ERROR_NONE;
    
    MOCKER(MsprofReportAdditionalInfo)
        .stubs()
        .will(invoke(MsprofReportAdditionalInfoStub));

    rtProfCommandHandle_t handle{};
    // 上报profilling开关值0x1000000000000ULL为false，值为0x0000100000000ULL为true
    handle.profSwitch = 0x1000000000000ULL;
    handle.type = PROF_COMMANDHANDLE_TYPE_START;
    rtProfilingCommandHandle(PROF_CTRL_SWITCH, (void *)(&handle), sizeof(rtProfCommandHandle_t));
    ret = ParsePrintf(workSpaceAddr, blockSize, dev->driver_);

    ConstructBlock((unsigned char*)addr, timeStampInfoLen);
    handle.profSwitch = 0x0000100000000ULL;
    rtProfilingCommandHandle(PROF_CTRL_SWITCH, (void *)(&handle), sizeof(rtProfCommandHandle_t));
    ret = ParsePrintf(workSpaceAddr, blockSize, dev->driver_);

    cmodelDrvMemcpy_flag = 0;
    delete[] addr;
    rtDeviceReset(0);
}
rtError_t MemCopySync_stub(
    Driver *drv, void *dst, uint64_t destMax, const void *src, uint64_t size, rtMemcpyKind_t kind)
{
    memcpy(dst, src, destMax);
    return RT_ERROR_NONE;
}

template <typename T>
unsigned char *DumpInfoAppendArray(unsigned char *buf, T src[], const size_t len)
{
    T *dst = (T *)buf;
    for (size_t i = 0U; i < len; ++i) {
        dst[i] = src[i];
    }
    return buf + sizeof(T) * len;
}

template <typename T>
static unsigned char *AddTensorInfo(unsigned char *data, uint32_t dataType, T num[], const size_t len)
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
static unsigned char *AddTensorInfo(
    unsigned char *data, uint32_t dataType, T num[], const size_t len, const DumpTensorInfo& tensorInfo)
{
    DumpInfoHead tensorHead{};
    tensorHead.type = DumpType::DUMP_TENSOR;
    tensorHead.infoLen = sizeof(DumpTensorInfo) + sizeof(T) * len;
    data = DumpInfoAppendByte(data, tensorHead);
    data = DumpInfoAppendByte(data, tensorInfo);
    data = DumpInfoAppendArray(data, num, len);
    return data;
}

DumpTensorInfo toDumpTensorInfo(uint32_t addr, uint32_t dataType, uint32_t position)
{
    DumpTensorInfo tensorInfo{};
    tensorInfo.addr = addr;
    tensorInfo.dataType = dataType;
    tensorInfo.desc = 716;
    tensorInfo.position = position;
    return tensorInfo;
}

static unsigned char *AddShapeInfo(unsigned char *data, uint32_t num[], const size_t len)
{
    DumpInfoHead shapeHead{};
    shapeHead.type = DumpType::DUMP_SHAPE;
    shapeHead.infoLen = sizeof(DumpShapeInfo);
    data = DumpInfoAppendByte(data, shapeHead);
    DumpShapeInfo shapeInfo{};
    shapeInfo.dim = len;  // uint32_t
    for (size_t i = 0; i < len; i++) {
        shapeInfo.shape[i] = num[i];
    }
    data = DumpInfoAppendByte(data, shapeInfo);
    return data;
}

void AddBlockInfo(unsigned char *data)
{
    unsigned char *blockAddr = data;
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
    double num11[] = {2.331};  // not support
    uint16_t num12[] = {16256, 49152, 65408, 16043, 65409, 32768, 16457, 32640};
    int8_t num13[] = {0, 3, 138, 20, 62, 67, 97, 200};
    bool boolNums[8];
    for (uint8_t i = 0U; i < 8U; ++i) {
        boolNums[i] = (i % 2U == 0U);
    }
    dataLen += sizeof(num1) + sizeof(num2) + sizeof(num3) + sizeof(num5) + sizeof(num6) + sizeof(num7) + sizeof(num8) +
               sizeof(num9) + sizeof(num10) + sizeof(num11) + sizeof(num12) + sizeof(num13) * 4 + sizeof(boolNums);
    const size_t blockSize = 1024 *1024;
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
    data = AddTensorInfo(data, 11, num11, 1);  // no support dtype

    BlockWriteInfo *writeInfo = RtPtrToPtr<BlockWriteInfo *>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = dataLen - sizeof(BlockInfo) - sizeof(BlockReadInfo) - sizeof(BlockWriteInfo);
    data = DumpInfoAppendByte(data, writeInfo);
}

TEST_F(PrintfTest, PrintDumpLargeTensorWithShape)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RawDevice *dev = (RawDevice *)rtInstance->GetDevice(0U, 0U);
    dev->simdEnable_ = true;
    error = dev->ParseSimdPrintInfo();
    EXPECT_EQ(error, RT_ERROR_NONE);
    MOCKER_CPP_VIRTUAL(dev->driver_, &Driver::MemCopySync).stubs().will(invoke(MemCopySync_stub));

    size_t blockSize = 1024 *1024;
    uint64_t totalLen = blockSize * 75;
    std::vector<uint8_t> hostData(totalLen, 0);
    uint8_t *blockAddr = hostData.data();
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
    unsigned char *data = DumpInfoAppendByte((unsigned char *)blockAddr, blockInfo);
    
    BlockReadInfo blockReadInfo{};
    blockReadInfo.readIdx = 0;
    data = DumpInfoAppendByte(data, blockReadInfo);
    uint32_t shape1[] = {50, 3, 2};
    data = AddShapeInfo(data, shape1, 3);
    data = AddTensorInfo(data, 4, tensorData1, 200);
    BlockWriteInfo *writeInfo = RtPtrToPtr<BlockWriteInfo *>(blockAddr + 1024 - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = dataLen - sizeof(BlockWriteInfo) - sizeof(BlockInfo) - sizeof(BlockReadInfo);
    data = DumpInfoAppendByte(data, writeInfo);

    error = ParsePrintf(blockAddr, 1024, dev->driver_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtDeviceReset(0);
}

TEST_F(PrintfTest, DumpTensorPrintf)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RawDevice *dev = (RawDevice *)rtInstance->GetDevice(0U, 0U);
    MOCKER_CPP_VIRTUAL(dev->driver_, &Driver::MemCopySync).stubs().will(invoke(MemCopySync_stub));

    size_t blockSize = 1024 *1024;
    uint64_t totalLen = blockSize * 75;
    std::vector<uint8_t> hostData(totalLen, 0);
    uint8_t *blockAddr = hostData.data();
    AddBlockInfo((unsigned char *)blockAddr);
    error = ParsePrintf(hostData.data(), blockSize, dev->driver_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtDeviceReset(0);
}

TEST_F(PrintfTest, PrintDumpTensorWithShape)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RawDevice *dev = (RawDevice *)rtInstance->GetDevice(0U, 0U);
    MOCKER_CPP_VIRTUAL(dev->driver_, &Driver::MemCopySync).stubs().will(invoke(MemCopySync_stub));

    size_t blockSize = 1024 *1024;
    uint64_t totalLen = blockSize * 75;
    std::vector<uint8_t> hostData(totalLen, 0);
    uint8_t *blockAddr = hostData.data();

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
    unsigned char *data = DumpInfoAppendByte((unsigned char *)blockAddr, blockInfo);

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

    BlockWriteInfo *writeInfo = RtPtrToPtr<BlockWriteInfo *>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = dataLen - sizeof(BlockWriteInfo) - sizeof(BlockInfo) - sizeof(BlockReadInfo);
    data = DumpInfoAppendByte(data, writeInfo);
    error = ParsePrintf(blockAddr, blockSize, dev->driver_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtDeviceReset(0);
}

TEST_F(PrintfTest, PrintDumpTensorWithoutShape)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RawDevice *dev = (RawDevice *)rtInstance->GetDevice(0U, 0U);
    MOCKER_CPP_VIRTUAL(dev->driver_, &Driver::MemCopySync).stubs().will(invoke(MemCopySync_stub));

    size_t blockSize = 1024 *1024;
    uint64_t totalLen = blockSize * 75;
    std::vector<uint8_t> hostData(totalLen, 0);
    uint8_t *blockAddr = hostData.data();
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
    unsigned char *data = DumpInfoAppendByte((unsigned char *)blockAddr, blockInfo);

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

    BlockWriteInfo *writeInfo = RtPtrToPtr<BlockWriteInfo *>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = dataLen - sizeof(BlockWriteInfo) - sizeof(BlockInfo) - sizeof(BlockReadInfo);
    data = DumpInfoAppendByte(data, writeInfo);
    error = ParsePrintf(blockAddr, blockSize, dev->driver_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtDeviceReset(0);
}

TEST_F(PrintfTest, PrintDumpTensorWhenDataError)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RawDevice *dev = (RawDevice *)rtInstance->GetDevice(0U, 0U);
    MOCKER_CPP_VIRTUAL(dev->driver_, &Driver::MemCopySync).stubs().will(invoke(MemCopySync_stub));

    size_t blockSize = 1024 *1024;
    uint64_t totalLen = blockSize * 75;
    std::vector<uint8_t> hostData(totalLen, 0);
    uint8_t *blockAddr = hostData.data();
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
    unsigned char *data = DumpInfoAppendByte((unsigned char *)blockAddr, blockInfo);
    BlockReadInfo blockReadInfo{};
    blockReadInfo.readIdx = 0;
    data = DumpInfoAppendByte(data, blockReadInfo);

    DumpInfoHead shapeHead{};
    shapeHead.type = DumpType::DUMP_SHAPE;
    shapeHead.infoLen = 32;  // 小于DumpShapeInfo的长度
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

    BlockWriteInfo *writeInfo = RtPtrToPtr<BlockWriteInfo *>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = dataLen - sizeof(BlockWriteInfo) - sizeof(BlockInfo) - sizeof(BlockReadInfo);
    data = DumpInfoAppendByte(data, writeInfo);
    error = ParsePrintf(blockAddr, blockSize, dev->driver_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtDeviceReset(0);
}

TEST_F(PrintfTest, PrintDumpTensorPosition)
{
    rtError_t error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    RawDevice *dev = (RawDevice *)rtInstance->GetDevice(0U, 0U);
    MOCKER_CPP_VIRTUAL(dev->driver_, &Driver::MemCopySync).stubs().will(invoke(MemCopySync_stub));

    size_t blockSize = 1024 * 1024;
    uint64_t totalLen = blockSize * 75;
    std::vector<uint8_t> hostData(totalLen, 0);
    uint8_t *blockAddr = hostData.data();
    size_t dataLen = sizeof(BlockInfo) + sizeof(BlockReadInfo) + sizeof(DumpInfoHead) + sizeof(DumpTensorInfo) +
                     sizeof(BlockWriteInfo);
    bool tensorData1[] = {1, 1, 1, 1, 1};
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
    unsigned char *data = DumpInfoAppendByte((unsigned char *)blockAddr, blockInfo);

    BlockReadInfo blockReadInfo{};
    blockReadInfo.readIdx = 0;
    data = DumpInfoAppendByte(data, blockReadInfo);

    data = AddTensorInfo(data, 12, tensorData1, 5, toDumpTensorInfo(0x400, 12, 3));
    data = AddTensorInfo(data, 12, tensorData2, 5, toDumpTensorInfo(0x400, 12, 4));
    data = AddTensorInfo(data, 2, tensorData3, 6, toDumpTensorInfo(0x400, 12, 2));

    BlockWriteInfo *writeInfo = RtPtrToPtr<BlockWriteInfo *>(blockAddr + blockSize - sizeof(BlockWriteInfo));
    writeInfo->writeIdx = dataLen - sizeof(BlockWriteInfo) - sizeof(BlockInfo) - sizeof(BlockReadInfo);
    data = DumpInfoAppendByte(data, writeInfo);
    error = ParsePrintf(blockAddr, blockSize, dev->driver_);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtDeviceReset(0);
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

TEST_F(PrintfTest, DumpFP16_DiffType) {
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