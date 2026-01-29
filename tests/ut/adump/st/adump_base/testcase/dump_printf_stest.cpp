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
#include <iostream>
#include "mockcpp/mockcpp.hpp"
#include "adump_pub.h"
#include "dump_printf.h"
#include "fp16_t.h"
#include "bfloat16.h"
#include "runtime/mem.h"
#include "case_workspace.h"
#include "file.h"

#define protected public
#define private public

using namespace Adx;

class ADX_DUMP_PRINTF_STEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

template<typename T>
unsigned char*DumpInfoAppendByte(unsigned char*buf, T src)
{
    T* dst = (T*)buf;
    *dst = src;
    return buf + sizeof(T);
}

template<typename T>
unsigned char*DumpInfoAppend1Byte(unsigned char*buf, T src)
{
    T* dst = (T*)buf;
    *dst = src;
    return buf + 1;
}

template<typename T>
unsigned char*DumpInfoAppend4Byte(unsigned char*buf, T src)
{
    T* dst = (T*)buf;
    *dst = src;
    return buf + 4;
}

template<typename T>
unsigned char*DumpInfoAppend8Byte(unsigned char*buf, T src)
{
    T* dst = (T*)buf;
    *dst = src;
    return buf + 8;
}

template<typename T>
unsigned char*DumpInfoAppendArray(unsigned char*buf, T src[], const size_t len)
{
    T* dst = (T*)buf;
    for (size_t i = 0U; i < len;++i) {
        dst[i] = src[i];
    }
    return buf + sizeof(T) * len;
}

template<typename T>
static unsigned char*AddTensorInfo(unsigned char*data, uint32_t dataType, T num[], const size_t len)
{
    AdxDumpInfoHead tensorHead{};
    tensorHead.type = 2U;
    tensorHead.infoLen = sizeof(AdxDumpMessageHead) + sizeof(T) * len;
    data = DumpInfoAppendByte(data, tensorHead);

    AdxDumpMessageHead messageHead{};
    messageHead.addr = 0x400;
    messageHead.dataType = dataType;
    messageHead.desc = 716;
    messageHead.position = 1;
    data = DumpInfoAppendByte(data, messageHead);
    data = DumpInfoAppendArray(data, num, len);
    return data;
}

static unsigned char*AddShapeInfo(unsigned char*data, uint32_t num[], const size_t len)
{
    AdxDumpInfoHead shapeHead{};
    shapeHead.type = 3U;
    shapeHead.infoLen = sizeof(AdxDumpShapeMessageHead);
    data = DumpInfoAppendByte(data, shapeHead);

    AdxDumpShapeMessageHead messageHead{};
    messageHead.dim = len; // uint32_t
    for (size_t i = 0; i < len; i++) {
        messageHead.shape[i] = num[i];
    }
    data = DumpInfoAppendByte(data, messageHead);
    return data;
}

void AddBlockInfo1(unsigned char *data)
{
    size_t dataLen = sizeof(AdxBlockInfo) +
                     sizeof(AdxDumpMeta) +
                     sizeof(AdxDumpShapeMessageHead) +
                     sizeof(AdxDumpInfoHead) * 18 +
                     sizeof(AdxDumpMessageHead) * 17; // an ampty info no AdxDumpMessageHead
    uint8_t num1[40];
    for (uint8_t i = 0U; i < 40U; ++i) {
        num1[i] = i;
    }
    uint32_t shape[] = {4, 2, 5};

    int8_t num2[] = {-3, -2, -1 , 0, 1, 2, 3, 4};
    uint16_t num3[] = {0, 1, 2, 3};
    int16_t num4[] = {-2, -1, 2}; // 非8字节对齐场景
    uint32_t num5[] = {0, 1};
    int32_t num6[] = {-2, 1};
    uint64_t num7[] = {235};
    int64_t num8[] = {20};
    float num9[] = {1.223, -9.3};
    Adx::fp16_t num10[] = {23.32, 3214.2, -23.2, -93.1};
    double num11[] = {2.331}; // not support
    // 1, -2, −infinity, 0.333984375, nan, -0, 3.140625, infinity
    uint16_t num12[] = {16256, 49152, 65408, 16043, 65409, 32768, 16457, 32640};
    int8_t num13[] = {0, 3, 138, 20, 62, 67, 97, 200};
    bool boolNums[8];
    for (uint8_t i = 0U; i < 8U; ++i) {
        boolNums[i] = (i % 2U == 0U);
    }
    dataLen += sizeof(num1);
    dataLen += sizeof(num2);
    dataLen += sizeof(num3);
    dataLen += sizeof(num5);
    dataLen += sizeof(num6);
    dataLen += sizeof(num7);
    dataLen += sizeof(num8);
    dataLen += sizeof(num9);
    dataLen += sizeof(num10);
    dataLen += sizeof(num11);
    dataLen += sizeof(num12);
    dataLen += (sizeof(num13) * 4);
    dataLen += (sizeof(boolNums));

    AdxBlockInfo blockInfo{};
    blockInfo.len = 1024U;
    blockInfo.core = 0U;
    blockInfo.blockNum = 2U;
    blockInfo.remainLen = 1024U - dataLen;
    blockInfo.magic = 0x5aa5bccdU;
    blockInfo.rsv = 7;
    data = DumpInfoAppendByte(data, blockInfo);

    AdxDumpMeta dumpMeta{};
    dumpMeta.coreType = 1;
    dumpMeta.mixFlag = 0;
    dumpMeta.blockDim = 16;
    data = DumpInfoAppendByte(data, dumpMeta);
    // 添加shape信息
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
    AdxDumpInfoHead tensorHead{}; // invalid info
    data = DumpInfoAppendByte(data, tensorHead);
}

static inline unsigned char*DumpInfoAppendString(unsigned char*buf, std::string &str)
{
    for (size_t i = 0U; i < str.size();++i) {
        buf[i] = (unsigned char)str[i];
    }
    buf[str.size()] = '\0';
    return buf + str.size() + 1;
}

static unsigned char*AddPrintInfo(unsigned char*data, std::string &str, std::string &printStr, size_t strLen)
{
    AdxDumpInfoHead dumpHead{};
    dumpHead.type = 1U;
    dumpHead.infoLen = strLen;
    data = DumpInfoAppendByte(data, dumpHead);

    size_t offset1 = 8 * 10;
    size_t offset2 = 8 + str.size() + 1;
    data = DumpInfoAppend8Byte(data, offset1);
    data = DumpInfoAppend8Byte(data, 29);
    data = DumpInfoAppend8Byte(data, -20);
    data = DumpInfoAppend8Byte(data, (float)2.3214);
    data = DumpInfoAppend8Byte(data, (float)-12.14);
    data = DumpInfoAppend8Byte(data, 30);
    data = DumpInfoAppend8Byte(data, &offset1);
    data = DumpInfoAppend8Byte(data, 0x993adf);
    data = DumpInfoAppend8Byte(data, 0x993adf);
    data = DumpInfoAppend8Byte(data, offset2);
    data = DumpInfoAppendString(data, str);
    data = DumpInfoAppendString(data, printStr);
    return data;
}

void AddBlockInfo2(unsigned char*data)
{
    std::string str =
        "int_i %i, int_d %d, float_f %f, float_F %F, uint_u %u, addr_p %p, int_x %x, int_X %X, char_s %s\n";
    str += "error_format %a unexpected_format %d\n";
    std::string printStr = "hello world!";
    size_t strLen = str.size() + 1 + printStr.size() + 1 + 8 * 10;
    strLen = (strLen / 8 + 1) * 8;

    size_t dataLen = sizeof(AdxBlockInfo) +
                     sizeof(AdxDumpMeta) +
                     sizeof(AdxDumpInfoHead);
    dataLen += strLen;

    AdxBlockInfo blockInfo{};
    blockInfo.len = 1024U;
    blockInfo.core = 1U;
    blockInfo.blockNum = 2U;
    blockInfo.remainLen = 1024U - dataLen;
    blockInfo.magic = 0x5aa5bccdU;
    blockInfo.rsv = 7;
    data = DumpInfoAppendByte(data, blockInfo);

    AdxDumpMeta dumpMeta{};
    dumpMeta.coreType = 0;
    dumpMeta.mixFlag = 1;
    dumpMeta.blockDim = 16;
    data = DumpInfoAppendByte(data, dumpMeta);

    data = AddPrintInfo(data, str, printStr, strLen);
}

void AddInvalidRemainLenBlockInfo(unsigned char*data)
{
    AdxBlockInfo blockInfo{};
    blockInfo.len = 1024U;
    blockInfo.core = 0U;
    blockInfo.blockNum = 2U;
    blockInfo.remainLen = 1024U; // invalid remainLen
    blockInfo.magic = 0x5aa5bccdU;
    blockInfo.rsv = 7;
    data = DumpInfoAppendByte(data, blockInfo);
}

void AddInvalidInfoLenBlockInfo(unsigned char*data)
{
    AdxBlockInfo blockInfo{};
    blockInfo.len = 1024U;
    blockInfo.core = 0U;
    blockInfo.blockNum = 2U;
    blockInfo.remainLen = 1024U - 128U;
    blockInfo.magic = 0x5aa5bccdU;
    blockInfo.rsv = 7;
    data = DumpInfoAppendByte(data, blockInfo);

    AdxDumpInfoHead dumpHead{};
    dumpHead.type = 1U;
    dumpHead.infoLen = 1024U * 1024U; // Invalid InfoLen
    data = DumpInfoAppendByte(data, dumpHead);
}

void SetSizeInfoForFftsPlus(rtArgsSizeInfo *sizeInfo, size_t worksapceSize, bool isDynamic,
                 bool isAssert)
{
    // sizeinfo: atomicIndex | totalNum | contextId | argsize | sizeNum |
    uint64_t *sizeInfoAddr = reinterpret_cast<uint64_t *>(sizeInfo->infoAddr);
    uint32_t atomicIndex = 0U;
    *sizeInfoAddr = static_cast<uint64_t>(atomicIndex);
    sizeInfoAddr++;

    const uint64_t totalNum = 20;
    *sizeInfoAddr = totalNum;
    sizeInfoAddr++;

    const uint64_t contextId = 0;
    *sizeInfoAddr = contextId;
    sizeInfoAddr++;

    const uint64_t argsize = 20 * 8;
    *sizeInfoAddr = argsize;
    sizeInfoAddr++;

    const uint64_t addrNum = 5; // input + output + workspace
    *sizeInfoAddr = addrNum;
    sizeInfoAddr++;
    // size for input + output
    *sizeInfoAddr = 8U;
    sizeInfoAddr++;
    *sizeInfoAddr = 8U;
    sizeInfoAddr++;

    if (isDynamic) {
        // 三个动态输入
        constexpr uint64_t dynamicMode = (2ULL << 56ULL);
        *sizeInfoAddr = dynamicMode | 3;
        sizeInfoAddr++;
        for (size_t i = 0; i < 3; i++) {
            *sizeInfoAddr = 8;
            sizeInfoAddr++;
        }
    }
    *sizeInfoAddr = 8U;
    sizeInfoAddr++;
    *sizeInfoAddr = worksapceSize;
    // 高八位写4
    if (isAssert) {
        constexpr uint64_t workspaceOffset = (4ULL << 56ULL);
        *sizeInfoAddr |= workspaceOffset;
    }
}

void AddBlockInfo3(unsigned char *data)
{
    size_t dataLen = sizeof(AdxBlockInfo) +
                     sizeof(AdxDumpMeta) +
                     sizeof(AdxDumpShapeMessageHead) * 5 +
                     sizeof(AdxDumpInfoHead) * 9 +
                     sizeof(AdxDumpMessageHead) * 5; // an ampty info no AdxDumpMessageHead
    uint8_t num1[40];
    for (uint8_t i = 0U; i < 40U; ++i) {
        num1[i] = i;
    }
    bool boolNums[16];
    for (uint8_t i = 0U; i < 16U; ++i) {
        boolNums[i] = (i % 2U == 0U);
    }
    double num2[] = {2.331}; // not support
    dataLen += sizeof(boolNums);
    dataLen += sizeof(num1);
    dataLen += sizeof(num1);
    dataLen += sizeof(num1);
    dataLen += sizeof(num2);

    AdxBlockInfo blockInfo{};
    blockInfo.len = 1024U;
    blockInfo.core = 0U;
    blockInfo.blockNum = 2U;
    blockInfo.remainLen = 1024U - dataLen;
    blockInfo.magic = 0x5aa5bccdU;
    blockInfo.rsv = 7;
    data = DumpInfoAppendByte(data, blockInfo);

    AdxDumpMeta dumpMeta{};
    dumpMeta.coreType = 1;
    dumpMeta.mixFlag = 0;
    dumpMeta.blockDim = 16;
    data = DumpInfoAppendByte(data, dumpMeta);
    // 添加shape信息
    uint32_t shape1[] = {3, 2, 4};
    data = AddShapeInfo(data, shape1, 3);
    data = AddTensorInfo(data, 4, num1, 40);  // 数据超过shape
    uint32_t shape2[] = {5, 8};
    data = AddShapeInfo(data, shape2, 2);
    data = AddTensorInfo(data, 4, num1, 16);  // 数据不足
    uint32_t shape3[] = {2, 7};
    data = AddShapeInfo(data, shape3, 2);
    data = AddTensorInfo(data, 4, num1, 8);  // 数据不足
    data = AddShapeInfo(data, shape1, 3);
    data = AddTensorInfo(data, 12, boolNums, 16);  // 数据不足
    data = AddShapeInfo(data, shape3, 1);
    data = AddTensorInfo(data, 11, num2, 1);  // 不支持的数据类型
}

TEST_F(ADX_DUMP_PRINTF_STEST, AdxDumpPrintf_WITHOUT_ZERO_BLOCK)
{
    int* addr = new int[1024 * 75];
    void *workSpaceAddr = (void *)addr;
    memset(workSpaceAddr, 0, 1024 * 75);
    AdxBlockInfo *dataAddr = (AdxBlockInfo *)((uint8_t *)workSpaceAddr + 1024);
    dataAddr->len = 1024;
    dataAddr->core = 1;
    dataAddr->blockNum = 8;
    dataAddr->remainLen = 976;
    dataAddr->magic = 0x5AA5BCCDU;
    dataAddr->rsv = 0;
    size_t debugBufSize = 1024 * 75;
    aclrtStream stream;
    const char *opType = "test";
    AdumpPrintWorkSpace(workSpaceAddr, debugBufSize, stream, opType, true);
    EXPECT_NE(workSpaceAddr, nullptr);
    AdumpPrintWorkSpace(workSpaceAddr, debugBufSize, stream, opType, false);
    EXPECT_NE(workSpaceAddr, nullptr);
    delete[] addr;
}

TEST_F(ADX_DUMP_PRINTF_STEST, AdxDumpPrintf_WITH_ILLEGAL_BLOCKLEN)
{
    int* addr = new int[1024 * 75];
    void *workSpaceAddr = (void *)addr;
    memset(workSpaceAddr, 0, 1024 * 75);
    AdxBlockInfo *dataAddr = (AdxBlockInfo *)((uint8_t *)workSpaceAddr + 1024);
    dataAddr->len = 1000;
    dataAddr->magic = 0x5AA5BCCDU;
    size_t debugBufSize = 1024 * 75;
    aclrtStream stream;
    const char *opType = "test";
    AdxPrintWorkSpace(workSpaceAddr, debugBufSize, stream, opType, true);
    EXPECT_NE(workSpaceAddr, nullptr);
    delete[] addr;
}

TEST_F(ADX_DUMP_PRINTF_STEST, AdxDumpPrintf_Normal_BlockInfo)
{
    int* addr = new int[1024 * 75];
    void *workSpaceAddr = (void *)addr;
    AddBlockInfo1((unsigned char*)addr);
    size_t debugBufSize = 1024 * 75;
    aclrtStream stream;
    const char *opType = "test";
    AdxPrintWorkSpace(workSpaceAddr, debugBufSize, stream, opType, true);
    EXPECT_NE(workSpaceAddr, nullptr);

    delete[] addr;
}

TEST_F(ADX_DUMP_PRINTF_STEST, AdxDumpPrintf_Abnormal_BlockInfo)
{
    int* addr = new int[1024 * 75];
    void *workSpaceAddr = (void *)addr;
    AddBlockInfo2((unsigned char*)addr);
    size_t debugBufSize = 1024 * 75;
    aclrtStream stream;
    const char *opType = "test";
    AdxPrintWorkSpace((void *)addr, debugBufSize, stream, opType, true);
    EXPECT_NE(workSpaceAddr, nullptr);
    delete[] addr;
}

TEST_F(ADX_DUMP_PRINTF_STEST, AdxDumpPrintf_InvalidRemainLen)
{
    int* addr = new int[1024 * 75];
    void *workSpaceAddr = (void *)addr;
    AddInvalidRemainLenBlockInfo((unsigned char*)addr);
    size_t debugBufSize = 1024 * 75;
    aclrtStream stream;
    const char *opType = "test";
    AdxPrintWorkSpace((void *)addr, debugBufSize, stream, opType, true);
    EXPECT_NE(workSpaceAddr, nullptr);
    delete[] addr;
}

TEST_F(ADX_DUMP_PRINTF_STEST, AdxDumpPrintf_InvalidInfoLen)
{
    int* addr = new int[1024 * 75];
    void *workSpaceAddr = (void *)addr;
    AddInvalidInfoLenBlockInfo((unsigned char*)addr);
    size_t debugBufSize = 1024 * 75;
    aclrtStream stream;
    const char *opType = "test";
    AdxPrintWorkSpace((void *)addr, debugBufSize, stream, opType, true);
    EXPECT_NE(workSpaceAddr, nullptr);
    delete[] addr;
}

TEST_F(ADX_DUMP_PRINTF_STEST, AdxDumpPrintf_error)
{
    int* addr = new int[1024 * 75];
    void *workSpaceAddr = (void *)addr;
    AddInvalidInfoLenBlockInfo((unsigned char*)addr);
    size_t debugBufSize = 1024 * 75;
    aclrtStream stream = (rtStream_t)0x5F;
    const char *opType = "test";
    AdxPrintWorkSpace((void *)addr, debugBufSize, stream, opType, true);
    EXPECT_NE(workSpaceAddr, nullptr);
    delete[] addr;
}

TEST_F(ADX_DUMP_PRINTF_STEST, AdxDumpPrintf_rtMemcpy_error)
{
    int* addr = new int[1024 * 75];
    void *workSpaceAddr = (void *)addr;
    AddInvalidInfoLenBlockInfo((unsigned char*)addr);
    size_t debugBufSize = 1024 * 75;
    aclrtStream stream = (rtStream_t)0x5F;
    const char *opType = "test";
    MOCKER(rtMemcpy).stubs().will(returnValue(1));
    AdxPrintWorkSpace((void *)addr, debugBufSize, stream, opType, true);
    EXPECT_NE(workSpaceAddr, nullptr);
    delete[] addr;
}

TEST_F(ADX_DUMP_PRINTF_STEST, AdxDumpPrintf_AbNormal_Data_BlockInfo)
{
    int* addr = new int[1024 * 75];
    void *workSpaceAddr = (void *)addr;
    AddBlockInfo3((unsigned char*)addr);
    size_t debugBufSize = 1024 * 75;
    aclrtStream stream;
    const char *opType = "test";
    AdxPrintWorkSpace(workSpaceAddr, debugBufSize, stream, opType, true);
    EXPECT_NE(workSpaceAddr, nullptr);
    delete[] addr;
}

TEST_F(ADX_DUMP_PRINTF_STEST, HIFLOAT8_AdxDumptensor)
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

TEST_F(ADX_DUMP_PRINTF_STEST, FLOAT8_E5M2_AdxDumptensor)
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

TEST_F(ADX_DUMP_PRINTF_STEST, FLOAT8_E4M3_AdxDumptensor)
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

TEST_F(ADX_DUMP_PRINTF_STEST, FLOAT8_E8M0_AdxDumptensor)
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


class ADX_DUMP_ASSERT_STEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

template<typename T>
void *AppendByte(void*buf, T src)
{
    T* dst = (T*)buf;
    *dst = src;
    return buf + sizeof(T);
}

void SetSizeInfo(rtArgsSizeInfo *sizeInfo, bool hasCtrlAddr, size_t worksapceSize, bool isDynamic,
                 bool isAssert)
{
    uint64_t *sizeInfoAddr = reinterpret_cast<uint64_t *>(sizeInfo->infoAddr);
    uint32_t atomicIndex = 0U;
    *sizeInfoAddr = static_cast<uint64_t>(atomicIndex);
    sizeInfoAddr++;
    const uint64_t addrNum = 5; // input + output + workspace
    *sizeInfoAddr = addrNum;
    if (hasCtrlAddr) {
        // 高32表示首个输入是否是CtrlAddr(mix is 1, other is 0)
        constexpr uint64_t inputOffset = (1ULL << 32ULL);
        *sizeInfoAddr |= inputOffset;
    }
    sizeInfoAddr++;
    // size for input + output
    *sizeInfoAddr = 8U;
    sizeInfoAddr++;
    *sizeInfoAddr = 8U;
    sizeInfoAddr++;

    if (isDynamic) {
        // 三个动态输入
        constexpr uint64_t dynamicMode = (2ULL << 56ULL);
        *sizeInfoAddr = dynamicMode | 3;
        sizeInfoAddr++;
        for (size_t i = 0; i < 3; i++) {
            *sizeInfoAddr = 8;
            sizeInfoAddr++;
        }
    }
    *sizeInfoAddr = 8U;
    sizeInfoAddr++;
    *sizeInfoAddr = worksapceSize;
    // 高八位写4
    if (isAssert) {
        constexpr uint64_t workspaceOffset = (4ULL << 56ULL);
        *sizeInfoAddr |= workspaceOffset;
    }
}

TEST_F(ADX_DUMP_ASSERT_STEST, AdxDumpAssert_Assert)
{
    rtExceptionInfo_t exceptionInfo;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;
    rtExceptionArgsInfo_t *argsInfo = &exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs;
    char* argsAddr = new char[1024];
    argsInfo->argAddr = (void *)argsAddr;
    argsInfo->argsize = 1024;
    // SetArgsInfo
    uint64_t input0 = 1;
    uint64_t input1 = 2;
    uint64_t input2 = 3;
    void *argAddr = argsInfo->argAddr;
    argAddr = AppendByte<uint64_t>(argAddr, input0);
    argAddr = AppendByte<uint64_t>(argAddr, input1);
    argAddr = AppendByte<uint64_t>(argAddr, input2);

    // 动态输入
    uint64_t input3 = 4;
    argAddr = AppendByte<uint64_t>(argAddr, input3);

    char* workspace = new char[1024 * 75];
    AddBlockInfo1((unsigned char*)(workspace));
    argAddr = AppendByte<void *>(argAddr, workspace);

    rtArgsSizeInfo* sizeInfo = &argsInfo->sizeInfo;
    char* infoAddr = new char[1024];
    sizeInfo->infoAddr = (void *)infoAddr;
    SetSizeInfo(sizeInfo, false, 1024 * 75, true, true);
    MOCKER(rtMemcpy).stubs().will(returnValue(1)).then(returnValue(0));
    rtSetOpExecuteTimeOutWithMs(100000);
    MOCKER(rtGetOpExecuteTimeoutV2).stubs().will(returnValue(0));
    AdxAssertCallBack(&exceptionInfo);
    AdxAssertCallBack(&exceptionInfo);

    // 非assert场景
    SetSizeInfo(sizeInfo, false, 1024 * 75, true, false);
    AdxAssertCallBack(&exceptionInfo);
    EXPECT_NE(sizeInfo->infoAddr, nullptr);

    delete[] infoAddr;
    delete[] argsAddr;
    delete[] workspace;
}

TEST_F(ADX_DUMP_ASSERT_STEST, AdxDumpAssert_WithFfts)
{
    rtExceptionInfo_t exceptionInfo;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_AICORE;
    rtExceptionArgsInfo_t *argsInfo = &exceptionInfo.expandInfo.u.aicoreInfo.exceptionArgs;
    char* argsAddr = new char[1024];
    argsInfo->argAddr = (void *)argsAddr;
    argsInfo->argsize = 1024;
    // SetArgsInfo
    uint64_t input0 = 1;
    uint64_t input1 = 2;
    uint64_t input2 = 3;
    void *argAddr = argsInfo->argAddr;

    // ffts地址
    uint64_t fftsAddr = 0;
    argAddr = AppendByte<uint64_t>(argAddr, fftsAddr);

    argAddr = AppendByte<uint64_t>(argAddr, input0);
    argAddr = AppendByte<uint64_t>(argAddr, input1);
    argAddr = AppendByte<uint64_t>(argAddr, input2);

    char* workspace = new char[1024 * 75];
    AddBlockInfo1((unsigned char*)(workspace));
    argAddr = AppendByte<void *>(argAddr, workspace);

    rtArgsSizeInfo* sizeInfo = &argsInfo->sizeInfo;
    char* infoAddr = new char[1024];
    sizeInfo->infoAddr = (void *)infoAddr;
    SetSizeInfo(sizeInfo, true, 1024 * 75, false, true);
    EXPECT_NE(sizeInfo->infoAddr, nullptr);
    rtSetOpExecuteTimeOutWithMs(100000);
    MOCKER(rtGetOpExecuteTimeoutV2).stubs().will(returnValue(0));
    AdxAssertCallBack(&exceptionInfo);

    delete[] infoAddr;
    delete[] argsAddr;
    delete[] workspace;
}

TEST_F(ADX_DUMP_ASSERT_STEST, AdxDumpAssert_MixFftsPlus)
{
    rtExceptionInfo_t exceptionInfo;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_FFTS_PLUS;
    exceptionInfo.expandInfo.u.fftsPlusInfo.contextId = 0;

    rtExceptionArgsInfo_t *argsInfo = &exceptionInfo.expandInfo.u.fftsPlusInfo.exceptionArgs;
    char* argsAddr = new char[1024];
    argsInfo->argAddr = (void *)argsAddr;
    argsInfo->argsize = 1024;
    // SetArgsInfo
    uint64_t input0 = 1;
    uint64_t input1 = 2;
    uint64_t input2 = 3;
    void *argAddr = argsInfo->argAddr;

    // args: fftsAddr input0 input1 input2 worksapceaddr -> offset=4->workspaceaddr
    // ffts地址
    uint64_t fftsAddr = 0;
    argAddr = AppendByte<uint64_t>(argAddr, fftsAddr);

    argAddr = AppendByte<uint64_t>(argAddr, input0);
    argAddr = AppendByte<uint64_t>(argAddr, input1);
    argAddr = AppendByte<uint64_t>(argAddr, input2);

    char* workspace = new char[1024 * 75];
    AddBlockInfo1((unsigned char*)(workspace));
    argAddr = AppendByte<void *>(argAddr, workspace);

    rtArgsSizeInfo* sizeInfo = &argsInfo->sizeInfo;
    char* infoAddr = new char[1024];
    sizeInfo->infoAddr = (void *)infoAddr;
    SetSizeInfoForFftsPlus(sizeInfo, 1024 * 75, true, true);
    EXPECT_NE(sizeInfo->infoAddr, nullptr);
    rtSetOpExecuteTimeOutWithMs(100000);
    MOCKER(rtGetOpExecuteTimeoutV2).stubs().will(returnValue(0));
    AdxAssertCallBack(&exceptionInfo);

    // 无workspacesize
    SetSizeInfoForFftsPlus(sizeInfo, 1024 * 75, true, false);
    EXPECT_NE(sizeInfo->infoAddr, nullptr);
    AdxAssertCallBack(&exceptionInfo);

    // 空指针场景
    AdxAssertCallBack(nullptr);

    // sizeinfo 空指针场景
    sizeInfo->infoAddr = nullptr;
    AdxAssertCallBack(&exceptionInfo);

    delete[] infoAddr;
    delete[] argsAddr;
    delete[] workspace;
}

TEST_F(ADX_DUMP_ASSERT_STEST, AdxDumpAssert_QuickRecover)
{
    rtExceptionInfo_t exceptionInfo;
    exceptionInfo.expandInfo.type = RT_EXCEPTION_FFTS_PLUS;
    exceptionInfo.expandInfo.u.fftsPlusInfo.contextId = 0;
    rtSetOpExecuteTimeOutWithMs(10);
    MOCKER(rtGetOpExecuteTimeoutV2).stubs().will(returnValue(1)).then(returnValue(0));
    AdxAssertCallBack(&exceptionInfo);
    EXPECT_EQ(exceptionInfo.expandInfo.u.fftsPlusInfo.contextId, 0);
    AdxAssertCallBack(&exceptionInfo);
    EXPECT_EQ(exceptionInfo.expandInfo.u.fftsPlusInfo.contextId, 0);
}


class ADX_DUMP_FP16_STEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(ADX_DUMP_FP16_STEST, FP16_AdxDumptensor)
{
    float data1 = 1.234;
    Adx::fp16_t num1[] = {data1};
    double data2 = 2.456;
    Adx::fp16_t num2[] = {data2};
    int8_t data3 = 2;
    Adx::fp16_t num3[] = {data3};
    uint8_t data4 = 2;
    Adx::fp16_t num4[] = {data4};
    int16_t data5 = 2;
    Adx::fp16_t num5[] = {data5};
    uint16_t data6 = 2;
    Adx::fp16_t num6[] = {data6};
    int32_t data7 = 2;
    Adx::fp16_t num7[] = {data7};
    uint32_t data8 = 2;
    Adx::fp16_t num8[] = {data8};
    uint64_t data9 = 2;
    Adx::fp16_t num9[] = {data9};
    int64_t data10 = 2;
    Adx::fp16_t num10[] = {data10};
    EXPECT_EQ(num10[0].toFloat(), float(data10));
}

TEST_F(ADX_DUMP_FP16_STEST, AdxDumpFP16_Mid)
{
    float data1 = 35500;
    Adx::fp16_t num1[] = {data1};
    double data2 = 35500;
    Adx::fp16_t num2[] = {data2};
    int8_t data3 = 35500;
    Adx::fp16_t num3[] = {data3};
    uint8_t data4 = 35500;
    Adx::fp16_t num4[] = {data4};
    int16_t data5 = 35500;
    Adx::fp16_t num5[] = {data5};
    uint16_t data6 = 35500;
    Adx::fp16_t num6[] = {data6};
    int32_t data7 = 35500;
    Adx::fp16_t num7[] = {data7};
    uint32_t data8 = 35500;
    Adx::fp16_t num8[] = {data8};
    uint64_t data9 = 35500;
    Adx::fp16_t num9[] = {data9};
    int64_t data10 = 35500;
    Adx::fp16_t num10[] = {data10};
    EXPECT_EQ(num10[0].toFloat(), 35488.0);
}

TEST_F(ADX_DUMP_FP16_STEST, AdxDumpFP16_Large)
{
    float data1 = 65500;
    Adx::fp16_t num1[] = {data1};
    double data2 = 65500;
    Adx::fp16_t num2[] = {data2};
    int8_t data3 = 65500;
    Adx::fp16_t num3[] = {data3};
    uint8_t data4 = 65500;
    Adx::fp16_t num4[] = {data4};
    int16_t data5 = 65500;
    Adx::fp16_t num5[] = {data5};
    uint16_t data6 = 65500;
    Adx::fp16_t num6[] = {data6};
    int32_t data7 = 65500;
    Adx::fp16_t num7[] = {data7};
    uint32_t data8 = 65500;
    Adx::fp16_t num8[] = {data8};
    uint64_t data9 = 65500;
    Adx::fp16_t num9[] = {data9};
    int64_t data10 = 65500;
    Adx::fp16_t num10[] = {data10};
    EXPECT_EQ(num10[0].toFloat(), 65504.0);
}

static unsigned char*AddTimeStampInfo(unsigned char*data)
{
    void *ptr = (void *)(data);
    size_t dataLen = sizeof(AdxBlockInfo) + sizeof(AdxDumpMeta) + sizeof(AdxDumpInfoHead) + 24U;
    AdxBlockInfo blockInfo{};
    blockInfo.len = 1024U;
    blockInfo.core = 0U;
    blockInfo.blockNum = 2U;
    blockInfo.remainLen = 1024U - dataLen;
    blockInfo.magic = 0x5aa5bccdU;
    blockInfo.rsv = 0U;
    data = DumpInfoAppendByte(data, blockInfo);

    AdxDumpMeta dumpMeta{};
    dumpMeta.typeId = 5;
    data = DumpInfoAppendByte(data, dumpMeta);

    uint32_t type = 6U;
    uint32_t infoLen = 24U;
    uint32_t descId = 10U;
    uint32_t rsv = 0U;
    uint64_t timeStamp = 8662162037790U;
    uint64_t pcPtr = 20619064410912U;
    data = DumpInfoAppend4Byte(data, type);
    data = DumpInfoAppend4Byte(data, infoLen);
    data = DumpInfoAppend4Byte(data, descId);
    data = DumpInfoAppend4Byte(data, rsv);
    data = DumpInfoAppend8Byte(data, timeStamp);
    data = DumpInfoAppend8Byte(data, pcPtr);

    return data;
}

class ADX_DUMP_TIMESTAMP_STEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(ADX_DUMP_TIMESTAMP_STEST, AdxDumpTimestamp)
{
    int* addr = new int[1024 * 75];
    void *workSpaceAddr = (void *)addr;
    EXPECT_NE(workSpaceAddr, nullptr);
    memset(workSpaceAddr, 0, 1024 * 75);
    AddTimeStampInfo((unsigned char*)addr);
    size_t debugBufSize = 1024 * 75;
    aclrtStream stream;
    const char *opType = "test";
    AdumpPrintConfig config = {false};
    AdumpPrintSetConfig(config);
    std::vector<MsprofAicTimeStampInfo> timeStampInfo;
    AdxPrintTimeStamp(workSpaceAddr, debugBufSize, stream, opType, timeStampInfo);
    EXPECT_EQ(timeStampInfo.size(), 1U);
    EXPECT_EQ(timeStampInfo[0].syscyc, 8662162037790U);
    EXPECT_EQ(timeStampInfo[0].blockId, 0U);
    EXPECT_EQ(timeStampInfo[0].descId, 10U);
    EXPECT_EQ(timeStampInfo[0].curPc, 20619064410912U);
    delete[] addr;
}

class FILE_STEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(FILE_STEST, Test_Close_File)
{
    Tools::CaseWorkspace ws("Test_Write_File");
    std::string existFile = ws.Touch("rw_file.txt");
    File file(ws.Root() + "/rw_file.txt", M_RDWR);

    // close after open success
    EXPECT_EQ(file.IsFileOpen(), ADUMP_SUCCESS);
    EXPECT_EQ(file.Close(), ADUMP_SUCCESS);

    // close after close
    EXPECT_EQ(file.Close(), ADUMP_SUCCESS);

    // close failed
    File files(existFile, M_RDWR);
    EXPECT_EQ(files.IsFileOpen(), ADUMP_SUCCESS);
    MOCKER(mmClose).stubs().will(returnValue(EN_ERROR));
    EXPECT_EQ(files.Close(), ADUMP_FAILED);
}

TEST_F(FILE_STEST, Test_Write_Read_Failed)
{
    Tools::CaseWorkspace ws("Test_Write_File");
    File rwFile(ws.Root() + "/rw_file.txt", M_RDWR | M_CREAT, M_IRUSR | M_IWUSR);

    constexpr char writeCtx[] = "test write context";
    int64_t writeLength = sizeof(writeCtx);

    // test write context to rd/wr file
    MOCKER(mmWrite).stubs().will(returnValue((mmSsize_t)-1));
    EXPECT_EQ(rwFile.IsFileOpen(), ADUMP_SUCCESS);
    EXPECT_EQ(rwFile.Write(writeCtx, writeLength), -1);

    MOCKER(mmRead).stubs().will(returnValue((mmSsize_t)-1));
    char buffer[16] = {0};
    EXPECT_EQ(rwFile.Read(buffer, 16), -1);
    EXPECT_EQ(rwFile.Close(), ADUMP_SUCCESS);
}

class ADX_SIMT_PRINTF_STEST: public testing::Test {
protected:
    virtual void SetUp() {
        setenv("ADX_LLT_SOC_VERSION", "Ascend950PR_9599", 1);
    }
    virtual void TearDown() {
        setenv("ADX_LLT_SOC_VERSION", "", 1);
        GlobalMockObject::verify();
    }
};

void AddSimtBlockInfo(uint8_t *data)
{
    size_t dataLen = sizeof(AdxBlockInfo) +
                     sizeof(AdxSimtDumpMeta) +
                     sizeof(AdxDumpInfoHead);
    AdxBlockInfo blockInfo{};
    blockInfo.len = 2048U;
    blockInfo.core = 0U;
    blockInfo.blockNum = 1U;
    blockInfo.remainLen = 2048U - dataLen - 14;
    blockInfo.magic = 0x5aa5bccdU;
    blockInfo.rsv = 7;
    data = DumpInfoAppendByte(data, blockInfo);

    AdxSimtDumpMeta dumpMeta{};
    data = DumpInfoAppendByte(data, dumpMeta);

    AdxDumpInfoHead dumpHead{};
    dumpHead.type = 7U;
    dumpHead.infoLen = 14;
    data = DumpInfoAppendByte(data, dumpHead);

    data = DumpInfoAppend8Byte(data, 0);
    std::string fmtStr = "hello";
    data = DumpInfoAppendString(data, fmtStr);
}

TEST_F(ADX_SIMT_PRINTF_STEST, AdxSimtPrintf)
{
    uint8_t* addr = new uint8_t[1024 * 1024 * 108 + 2048 * 2048 * 72];
    void *workSpaceAddr = (void *)addr;
    EXPECT_NE(workSpaceAddr, nullptr);

    // add first simd blockInfo
    AdxBlockInfo blockInfo{};
    blockInfo.len = 1024U * 1024U;
    DumpInfoAppendByte(addr, blockInfo);

    // add first simt blockInfo
    AddSimtBlockInfo((unsigned char*)addr + 1024 * 1024 * 108);

    // add second blockInfo with bad remainLen
    AdxBlockInfo blockInfo1{};
    blockInfo1.len = 2048U;
    blockInfo1.magic = 0x5aa5bccdU;
    blockInfo1.remainLen = 2048U;
    DumpInfoAppendByte((unsigned char*)addr + 1024 * 1024 * 108 + 2048, blockInfo1);

    // add third blockInfo with bad remainLen
    AdxBlockInfo blockInfo2{};
    blockInfo2.len = 2048U;
    blockInfo2.magic = 0x5aa5bccdU;
    blockInfo2.remainLen = 2048U - 56U;
    unsigned char *data = DumpInfoAppendByte((unsigned char*)addr + 1024 * 1024 * 108 + 2048 * 2, blockInfo2);
    AdxSimtDumpMeta dumpMeta{};
    data = DumpInfoAppendByte(data, dumpMeta);
    AdxDumpInfoHead dumpHead{};
    dumpHead.type = 7U;
    dumpHead.infoLen = 14;
    data = DumpInfoAppendByte(data, dumpHead);

    // add third blockInfo with bad remainLen
    AdxBlockInfo blockInfo3{};
    blockInfo3.len = 2048U;
    blockInfo3.magic = 0x5aa5bccdU;
    blockInfo3.remainLen = 2048U - 60U;
    DumpInfoAppendByte((unsigned char*)addr + 1024 * 1024 * 108 + 2048 * 3, blockInfo3);

    size_t debugBufSize = 1024 * 1024 * 108 + 2048 * 2048 * 72;
    aclrtStream stream;
    const char *opType = "test";
    AdumpPrintConfig config = {false};
    AdumpPrintSetConfig(config);
    AdxPrintWorkSpace(workSpaceAddr, debugBufSize, stream, opType, true);
    delete[] addr;
}
