/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#include "stacktrace_unwind_inner.h"
#include "stacktrace_unwind_instr.h"

class StackTraceUnwindInnerUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
        dwarf.memory = NULL;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
    }
    ScdDwarf dwarf;
};

#define LOG_EXPECT_EQ(X, Y, msg, ...) do {  \
    if ((X) != (Y)) {                       \
        printf(msg "\n", ##__VA_ARGS__);    \
    }                                       \
    EXPECT_EQ((X), (Y));                    \
} while (0)

const uint8_t *Mocker_TraceEncDataLowbitParse(const uint8_t ucEncode, const uint8_t *pucSegAddr, uintptr_t *puvResult)
{
    uintptr_t uOffset = 0;
    intptr_t  sOffset = 0;
    const uint8_t *mockValue = pucSegAddr;
    const uint8_t *pucSegAddrTmp = pucSegAddr;

    /* 对编码类型的低4位进行分别处理 */
    switch (TRACE_LOBIT4_ENCODE(ucEncode)) {
        case DW_EH_PE_ABSPTR:
            *puvResult = *(uintptr_t *)(void *)(uintptr_t)pucSegAddrTmp;
            pucSegAddrTmp += sizeof(void *);
            break;
        case DW_EH_PE_ULEB128:
            MOCKER(TraceReadUleb128).stubs().with(any(), any(), outBoundP(&uOffset, sizeof(uintptr_t *)))
                        .will(returnValue(mockValue));
            pucSegAddrTmp = mockValue;
            *puvResult = uOffset;
            break;
        case DW_EH_PE_UDATA2:
            *puvResult = (uintptr_t)(*(uint16_t *)(void *)(uintptr_t)pucSegAddrTmp);
            pucSegAddrTmp += sizeof(uint16_t);
            break;
        case DW_EH_PE_UDATA4:
            *puvResult = (uintptr_t)(*(uint32_t *)(void *)(uintptr_t)pucSegAddrTmp);
            pucSegAddrTmp += sizeof(uint32_t);
            break;
        case DW_EH_PE_UDATA8:
            *puvResult = (uintptr_t)(*(uint64_t *)(void *)(uintptr_t)pucSegAddrTmp);
            pucSegAddrTmp += sizeof(uint64_t);
            break;
        case DW_EH_PE_SIGNED:
            *puvResult = (uintptr_t)(*(intptr_t *)(void *)(uintptr_t)pucSegAddrTmp);
            pucSegAddrTmp += sizeof(void *);
            break;
        case DW_EH_PE_SLEB128:
            MOCKER(TraceReadLeb128).stubs().with(any(), any(), outBoundP(&sOffset, sizeof(intptr_t *)))
                .will(returnValue(mockValue));
            pucSegAddrTmp = mockValue;
            *puvResult = (uintptr_t)sOffset;
            break;
        case DW_EH_PE_DATA2:
            *puvResult = (uintptr_t)((intptr_t)(*(int16_t *)(void *)(uintptr_t)pucSegAddrTmp));
            pucSegAddrTmp += sizeof(int16_t);
            break;
        case DW_EH_PE_DATA4:
            *puvResult = (uintptr_t)((intptr_t)(*(int32_t *)(void *)(uintptr_t)pucSegAddrTmp));
            pucSegAddrTmp += sizeof(int32_t);
            break;
        case DW_EH_PE_DATA8:
            *puvResult = (uintptr_t)((intptr_t)(*(int64_t *)(void *)(uintptr_t)pucSegAddrTmp));
            pucSegAddrTmp += sizeof(int64_t);
            break;
        default:
            *puvResult = 0;
            return NULL;
    }

    return pucSegAddrTmp;
}

TEST_F(StackTraceUnwindInnerUtest, TestTraceReadEncodeValue)
{
    uint8_t enCode = 0;
    uint8_t data[8] = { 0, 1, 2, 3, 4, 5, 6, 7};
    const uint8_t *byteAddr = 0;
    uintptr_t value = 0;
    const uint8_t *ret = NULL;

    // case DW_EH_PE_OMIT
    enCode = DW_EH_PE_OMIT;
    ret = TraceReadEncodeValue(&dwarf, enCode, byteAddr, &value);
    EXPECT_EQ((const uint8_t *)0, ret);

    // case DW_EH_PE_ALIGNED
    enCode = DW_EH_PE_ALIGNED;
    byteAddr = &data[0];
    ret = TraceReadEncodeValue(&dwarf, enCode, byteAddr, &value);
    EXPECT_EQ(0x0706050403020100, value);
    EXPECT_EQ(byteAddr + sizeof(void *), ret);

    // check low_bit_4
    const uint8_t *expectRet = NULL;
    uintptr_t expectValue = 0;
    byteAddr = &data[0];
    for (uint32_t i = 0x00; i <= 0x0F; i++) {
        enCode = (uint8_t)i;
        if (enCode == DW_EH_PE_OMIT) {
            continue;
        }
        if (enCode == DW_EH_PE_ALIGNED) {
            continue;
        }
        value = 0;
        expectValue = 0;
        expectRet = Mocker_TraceEncDataLowbitParse(enCode, byteAddr, &expectValue);
        ret = TraceReadEncodeValue(&dwarf, enCode, byteAddr, &value);
        LOG_EXPECT_EQ(expectRet, ret, "test TestTraceReadEncodeValue failed, enCode=0x%02hhx.", enCode);
        LOG_EXPECT_EQ(expectValue, value, "test TestTraceReadEncodeValue failed, enCode=0x%02hhx.", enCode);
        GlobalMockObject::verify();
    }
}

TEST_F(StackTraceUnwindInnerUtest, TestTraceReadUleb128)
{
    uint8_t src = 0x1;
    uintptr_t psvVal = 0;
    for (uint8_t i = 0; i < 128; i++) {
        src = i;
        EXPECT_EQ(TraceReadUleb128(&dwarf, &src, &psvVal), &src + 1);
        EXPECT_EQ(psvVal, i);
    }
}

TEST_F(StackTraceUnwindInnerUtest, TestTraceReadLeb128)
{
    uint8_t src = 0x1;
    intptr_t psvVal = 0;

    for (uint8_t i = 0; i < 63; i++) {
        src = i;
        EXPECT_EQ(TraceReadLeb128(&dwarf, &src, &psvVal), &src + 1);
        EXPECT_EQ(psvVal, i);
    }
    for (uint8_t i = 64; i < 128; i++) {
        src = i;
        EXPECT_EQ(TraceReadLeb128(&dwarf, &src, &psvVal), &src + 1);
        EXPECT_EQ(psvVal, i - 128);
    }
}

TEST_F(StackTraceUnwindInnerUtest, TestTraceReadEncodeValueAligned)
{
    uint64_t tmp[4] = {0, 0, 0, 0};
    uint8_t *src = (uint8_t *)&tmp[0];
    uintptr_t psvVal = 0;

    for (uint8_t i = 0; i < 128; i++) {
        *src = i;
        EXPECT_EQ(TraceReadEncodeValue(&dwarf, DW_EH_PE_ALIGNED, src, &psvVal), src + 8);
        EXPECT_EQ(psvVal, i);
    }
    for (uint8_t j = 1; j < 6; j ++ ) {
        src = (uint8_t *)&tmp[0] + j;
        for (uint8_t i = 0; i < 128; i++) {
            *src = i;
            EXPECT_EQ(TraceReadEncodeValue(&dwarf, DW_EH_PE_ALIGNED, src, &psvVal), src + 16 - j);
            EXPECT_EQ(psvVal, 0);
        }
    }
    for (uint8_t j = 0; j < 4; j++) {
        tmp[j] = 0xFFFFFFFFFFFFFFFF;
    }
    src = (uint8_t *)&tmp[0];
    for (uint8_t i = 0; i < 128; i++) {
        *src = i;
        EXPECT_EQ(TraceReadEncodeValue(&dwarf, DW_EH_PE_ALIGNED, src, &psvVal), src + 8);
        EXPECT_EQ(psvVal, 0xFFFFFFFFFFFFFF00 + i);
    }
    for (uint8_t j = 1; j < 6; j ++ ) {
        src = (uint8_t *)&tmp[0] + j;
        for (uint8_t i = 0; i < 128; i++) {
            *src = i;
            EXPECT_EQ(TraceReadEncodeValue(&dwarf, DW_EH_PE_ALIGNED, src, &psvVal), src + 16 - j);
            EXPECT_EQ(psvVal, 0xFFFFFFFFFFFFFFFF);
        }
    }
}

TEST_F(StackTraceUnwindInnerUtest, TestTraceReadEncodeValueAbsptr)
{
    uint64_t tmp[4] = {0, 0, 0, 0};
    uint8_t *src = (uint8_t *)&tmp[0];
    uintptr_t psvVal = 0;
    src = (uint8_t *)&tmp[0];
    for (uint8_t i = 0; i < 0xFF; i++) {
        *src = i;
        EXPECT_EQ(TraceReadEncodeValue(&dwarf, DW_EH_PE_ABSPTR, src, &psvVal), src + sizeof(uintptr_t));
        EXPECT_EQ(psvVal, i);
    }
}

TEST_F(StackTraceUnwindInnerUtest, TestTraceReadEncodeValueUdata2)
{
    uint64_t tmp[4] = {0, 0, 0, 0};
    uint8_t *src = (uint8_t *)&tmp[0];
    uintptr_t psvVal = 0;
    src = (uint8_t *)&tmp[0];
    uint64_t i = 0;
    for (;i < 0x7FFF; i += 0xFF) {
        *(uint16_t*)src = i;
        EXPECT_EQ(TraceReadEncodeValue(&dwarf, DW_EH_PE_UDATA2, src, &psvVal), src + sizeof(uint16_t));
        EXPECT_EQ(psvVal, i);
        printf("%lld\n", i);
        EXPECT_EQ(TraceReadEncodeValue(&dwarf, DW_EH_PE_DATA2, src, &psvVal), src + sizeof(uint16_t));
        EXPECT_EQ(psvVal, i);
    }
    for (;i < 0xFFFF; i += 0xFF) {
        *(uint16_t*)src = i;
        EXPECT_EQ(TraceReadEncodeValue(&dwarf, DW_EH_PE_UDATA2, src, &psvVal), src + sizeof(uint16_t));
        EXPECT_EQ(psvVal, i);
        printf("%lld\n", i);
        EXPECT_EQ(TraceReadEncodeValue(&dwarf, DW_EH_PE_DATA2, src, &psvVal), src + sizeof(uint16_t));
        EXPECT_EQ((int16_t)psvVal, (int16_t)i);
    }
}

TEST_F(StackTraceUnwindInnerUtest, TestTraceReadEncodeValueUdata4)
{
    uint64_t tmp[4] = {0, 0, 0, 0};
    uint8_t *src = (uint8_t *)&tmp[0];
    uintptr_t psvVal = 0;
    src = (uint8_t *)&tmp[0];
    uint64_t i = 0;
    for (; i < 0x0FFFFFFF; i += 0xFFFFFF) {
        *(uint32_t*)src = i;
        EXPECT_EQ(TraceReadEncodeValue(&dwarf, DW_EH_PE_UDATA4, src, &psvVal), src + sizeof(uint32_t));
        EXPECT_EQ(psvVal, i);
        EXPECT_EQ(TraceReadEncodeValue(&dwarf, DW_EH_PE_DATA4, src, &psvVal), src + sizeof(int32_t));
        EXPECT_EQ((int32_t)psvVal, i);
    }
    for (; i < 0x0FFFFFFF; i += 0xFFFFFF) {        
        *(uint32_t*)src = i;
        EXPECT_EQ(TraceReadEncodeValue(&dwarf, DW_EH_PE_UDATA4, src, &psvVal), src + sizeof(uint32_t));
        EXPECT_EQ(psvVal, i);
        EXPECT_EQ(TraceReadEncodeValue(&dwarf, DW_EH_PE_DATA4, src, &psvVal), src + sizeof(int32_t));
        EXPECT_EQ((int32_t)psvVal, -i);
    }
}

TEST_F(StackTraceUnwindInnerUtest, TestTraceReadEncodeValueUdata8)
{
    uint64_t tmp[4] = {0, 0, 0, 0};
    uint8_t *src = (uint8_t *)&tmp[0];
    uintptr_t psvVal = 0;
    src = (uint8_t *)&tmp[0];
    uint64_t i = 0;
    for (; i < 0xFFFFFFFFFFFFFFF; i += 0xFFFFFFFFFFFFF) {
        *(uint64_t*)src = i;
        EXPECT_EQ(TraceReadEncodeValue(&dwarf, DW_EH_PE_UDATA8, src, &psvVal), src + sizeof(uint64_t));
        EXPECT_EQ(psvVal, i);
    }
}

TEST_F(StackTraceUnwindInnerUtest, TestTraceReadEncodeValueSigned)
{
    uint64_t tmp[4] = {0, 0, 0, 0};
    uint8_t *src = (uint8_t *)&tmp[0];
    uintptr_t psvVal = 0;
    src = (uint8_t *)&tmp[0];
    for (uint64_t i = 0; i < 0xFF; i += 1) {
        *(int8_t*)src = i;
        EXPECT_EQ(TraceReadEncodeValue(&dwarf, DW_EH_PE_SIGNED, src, &psvVal), src + sizeof(uintptr_t));
        EXPECT_EQ(psvVal, i);
    }
}
