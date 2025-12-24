/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stacktrace_unwind_inner.h"
#include <stdlib.h>
#include <pthread.h>
#include <fcntl.h>
#include <string.h>
#include <link.h>
#include "adiag_utils.h"
#include "securec.h"
#include "stacktrace_unwind.h"
#include "stacktrace_fp.h"
#include "stacktrace_signal.h"
#include "stddef.h"
#include "trace_system_api.h"
#include "stacktrace_dumper/scd_memory.h"
#include "scd_log.h"


/**
 * @brief       read N bytes from src and move src forward N bytes
 * @param [in]  src  src addr
 * @param [out] dst  dst addr
 * @param [in]  size size to be read
 *
 * @return read size, return 0 if failed
 */
size_t TraceReadBytes(ScdDwarf *dwarf, const uint8_t **src, void *dst, size_t size)
{
    size_t ret = ScdMemoryRead(dwarf->memory, (uintptr_t)(*src), dst, size);
    if (ret == 0) {
        SCD_DLOG_ERR("memory read failed");
        return 0;
    }
    *src += size;
    return size;
}

/**
 * @brief 从字节流中读取LEB128编码的数值, LEB128类型编码过程: (只介绍保存负数，正数如ULEB128)
 *               1.从一整数低字节开始分段，1段7位
 *               2.将这7位作为一个字节，如果几个高字节的是0XFF，则舍去但是，如从低位起一个0xFF的后一字节第7为0
 *                 则保留该字节并改为0x7f保存，如第7位是1，这舍去该字节，后一字节最高位置1
 *               ULEB128类型解码过程:
 *               1.从低地址开始读，若最高位0停止读
 *               2.每次读的数据高位数据，每次偏移7的倍数倍并与前面的数或运算作为高位
 *               3.判断最后读出来的字节第七位是否为1，若为1表是负数，则上述结果高位置1
 * @param [in]  byteStream 字节流指针
 * @param [out] psvVal 存储读取到的数值的指针
 *
 * @return 返回读取到的数值后的字节流指针
 */
const uint8_t *TraceReadLeb128(ScdDwarf *dwarf, const uint8_t *byteStream, intptr_t *psvVal)
{
    uint32_t shift = 0;
    uint8_t ucByte;
    uintptr_t result;
    uint32_t byteCount = 0;
    const uint8_t *byteStreamTmp = byteStream;
    result = 0;

    do {
        size_t size = TraceReadBytes(dwarf, &byteStreamTmp, &ucByte, sizeof(uint8_t));
        SCD_CHK_EXPR_ACTION(size == 0, return NULL, "read byte failed");
        result |= ((uintptr_t)ucByte & TRACE_GET_LOW_BIT_VALUE) << shift;
        shift += TRACE_MOVE_BIT_COUNT;
        byteCount++;
    } while (((ucByte & TRACE_GET_HIG_BIT_VALUE) != 0) && (byteCount < TRACE_MAX_LEB_BYRE));

    /* 如果最后一个字节的第7bit不为0时，表示该数是个负数，要转换为实际负数值
     * 同时保证移位数小于64 */
    if ((shift < 8U * sizeof(uintptr_t)) && ((ucByte & 0x40U) != 0)) { /* 8表示偏移位数，0x40 */
        result |= TRACE_LOW_BIT_ZERO(((size_t)1L) << shift);
    }

    *psvVal = (intptr_t)result;
    return byteStreamTmp;
}

/**
 *  @brief 读取Uleb128类型的数据,ULEB128类型编码过程:
 *               1.从一整数低字节开始分段，1段7位
 *               2.将这7位作为一个字节，如果几个高字节的是0，则舍去
 *               3.将新的字节组成字节流，从低字节开始除了最后一个字节，其余最高1
 *               4.最后一个字节的最高位为0，表示字节流结束
 *               ULEB128类型解码过程:
 *               1.从低地址开始读，若最高位0停止读
 *               2.每次读的数据高位数据，每次偏移7的倍数倍并与前面的数或运算作为高位
 *
 * @param [in] byteStream 输入的字节流
 * @param [out] val 存储读取到的数据
 * @return 返回读取到的数据后的字节流位置
 */
const uint8_t *TraceReadUleb128(ScdDwarf *dwarf, const uint8_t *byteStream, uintptr_t *val)
{
    uint32_t shift = 0;
    uint8_t ucByte;
    uintptr_t result = 0;
    uint32_t byteCount = 0;
    const uint8_t *byteStreamTmp = byteStream;

    /* Uleb128类型处理方式，在64bit机器上该类型最大10byte(10*7 > 8*8)
     * 低字节开始读，若字节最高位为0停止读，取每次读的字节低七位作为数据的低七位
     */
    do {
        size_t size = TraceReadBytes(dwarf, &byteStreamTmp, &ucByte, sizeof(uint8_t));
        SCD_CHK_EXPR_ACTION(size == 0, return NULL, "read byte failed");
        result |= ((uintptr_t)ucByte & TRACE_GET_LOW_BIT_VALUE) << shift;
        shift += TRACE_MOVE_BIT_COUNT;
        byteCount++;
    } while (((ucByte & TRACE_GET_HIG_BIT_VALUE) != 0) && (byteCount < TRACE_MAX_LEB_BYRE));

    *val = result;
    return byteStreamTmp;
}

static uint32_t TraceEncDataHighbitParse(const uint8_t encode, const uintptr_t srcAddr, uintptr_t *resultPtr)
{
    uintptr_t result = *resultPtr;

    /* 若编码格式与指针有关，该地址保存的是偏移值 */
    if (TRACE_MDBIT3_ENCODE(encode) == DW_EH_PE_PCREL) {
        result = result + srcAddr;
    }

    /* 若编码类型的最高位是1，表示该地址表示的内容也是个地址，要保证地址合法性 */
    if (TRACE_HIBIT1_ENCODE(encode) == DW_EH_PE_INDIRECT) {
        result = *(uintptr_t *)result;
    }

    *resultPtr = result;

    return 0;
}

static const uint8_t *TraceEncDataLowbitParse(ScdDwarf *dwarf, const uint8_t encode, const uint8_t *segAddr, uintptr_t *resultPtr)
{
    uint16_t uint16Value = 0;
    int16_t int16Value = 0;
    int32_t int32Value = 0;
    uint32_t uint32Value = 0;
    uint64_t uint64Value = 0;
    int64_t int64Value = 0;
    intptr_t intptrValue = 0;
    const uint8_t *segAddrTmp = segAddr;
    size_t size = 0;

    /* 对编码类型的低4位进行分别处理 */
    switch (TRACE_LOBIT4_ENCODE(encode)) {
        case DW_EH_PE_ABSPTR:
            size = TraceReadBytes(dwarf, &segAddrTmp, resultPtr, sizeof(uintptr_t));
            SCD_CHK_EXPR_ACTION(size == 0, return NULL, "read bytes failed");
            break;
        case DW_EH_PE_ULEB128:
            segAddrTmp = TraceReadUleb128(dwarf, segAddrTmp, resultPtr);
            SCD_CHK_EXPR_ACTION(segAddrTmp == NULL, return NULL, "read uleb128 failed");
            break;
        case DW_EH_PE_UDATA2:
            size = TraceReadBytes(dwarf, &segAddrTmp, &uint16Value, sizeof(uint16_t));
            SCD_CHK_EXPR_ACTION(size == 0, return NULL, "read bytes failed");
            *resultPtr = (uintptr_t)uint16Value;
            break;
        case DW_EH_PE_UDATA4:
            size = TraceReadBytes(dwarf, &segAddrTmp, &uint32Value, sizeof(uint32_t));
            SCD_CHK_EXPR_ACTION(size == 0, return NULL, "read bytes failed");
            *resultPtr = (uintptr_t)uint32Value;
            break;
        case DW_EH_PE_UDATA8:
            size = TraceReadBytes(dwarf, &segAddrTmp, &uint64Value, sizeof(uint64_t));
            SCD_CHK_EXPR_ACTION(size == 0, return NULL, "read bytes failed");
            *resultPtr = (uintptr_t)uint64Value;
            break;
        /* 在FDE里该编码类型几乎不存在，其所占字节与cpubit有关 */
        case DW_EH_PE_SIGNED:
            size = TraceReadBytes(dwarf, &segAddrTmp, resultPtr, sizeof(uintptr_t));
            SCD_CHK_EXPR_ACTION(size == 0, return NULL, "read bytes failed");
            break;
        case DW_EH_PE_SLEB128:
            segAddrTmp = TraceReadLeb128(dwarf, segAddrTmp, &intptrValue);
            SCD_CHK_EXPR_ACTION(segAddrTmp == NULL, return NULL, "read leb128 failed");
            *resultPtr = (uintptr_t)intptrValue;
            break;
        case DW_EH_PE_DATA2:
            size = TraceReadBytes(dwarf, &segAddrTmp, &int16Value, sizeof(int16_t));
            SCD_CHK_EXPR_ACTION(size == 0, return NULL, "read bytes failed");
            *resultPtr = (uintptr_t)int16Value;
            break;
        case DW_EH_PE_DATA4:
            size = TraceReadBytes(dwarf, &segAddrTmp, &int32Value, sizeof(int32_t));
            SCD_CHK_EXPR_ACTION(size == 0, return NULL, "read bytes failed");
            *resultPtr = (uintptr_t)int32Value;
            break;
        case DW_EH_PE_DATA8:
            size = TraceReadBytes(dwarf, &segAddrTmp, &int64Value, sizeof(int64_t));
            SCD_CHK_EXPR_ACTION(size == 0, return NULL, "read bytes failed");
            *resultPtr = (uintptr_t)int64Value;
            break;
        default:
            *resultPtr = 0;
            segAddrTmp = NULL;
            break;
    }
    return segAddrTmp;
}

/**
 * @brief 读取并解码值
 *
 * @param [in]   encode 编码类型
 * @param [in]   byteAddr 字节地址
 * @param [out]  val 解码后的值
 *
 * @return 返回执行后的地址
 */
const uint8_t *TraceReadEncodeValue(ScdDwarf *dwarf, const uint8_t encode, const uint8_t *byteAddr, uintptr_t *val)
{
    uintptr_t result = 0;
    uintptr_t srcAddr;
    uintptr_t alignAddr;
    const uint8_t *byteAddrTmp = byteAddr;

    if (encode == DW_EH_PE_OMIT) {
        SCD_DLOG_ERR("encode is DW_EH_PE_OMIT");
        return NULL;
    }
    srcAddr = (uintptr_t)byteAddrTmp;
    if (encode == DW_EH_PE_ALIGNED) {
        /* 地址高对齐 */
        alignAddr = (uintptr_t)byteAddrTmp;
        alignAddr = TRACE_UNWIND_HALIGN(alignAddr);
        size_t size = TraceReadBytes(dwarf, (const uint8_t **)(&alignAddr), &result, sizeof(uintptr_t));
        SCD_CHK_EXPR_ACTION(size == 0, return NULL, "read bytes failed");
        byteAddrTmp = (const uint8_t *)alignAddr;
    } else {
        /* 对编码类型的低4位进行分别处理 */
        byteAddrTmp = TraceEncDataLowbitParse(dwarf, encode, byteAddrTmp, &result);
        TRACE_UNWIND_PARSE_ADDR_CHECK_OR_RETURN(byteAddrTmp);

        if (result != 0) {
            /* 对编码类型的高4位进行分别处理 */
            if (TraceEncDataHighbitParse(encode, srcAddr, &result) != 0) {
                SCD_DLOG_ERR("TraceEncDataHighbitParse failed");
                return NULL;
            }
        }
    }
    *val = result;
    return byteAddrTmp;
}

/**
 * 获取编码值的大小
 *
 * @param encode 编码类型
 * @return 编码值的大小
 */
size_t TraceEncValueSizeGet(uint8_t encode)
{
    size_t encSize = 0;

    switch (encode & 0x07U) { /* 0x07 */
        case DW_EH_PE_ABSPTR:
            encSize = sizeof(void *);
            break;
        case DW_EH_PE_UDATA2:
            encSize = sizeof(uint16_t);
            break;
        case DW_EH_PE_UDATA4:
            encSize = sizeof(uint32_t);
            break;
        case DW_EH_PE_UDATA8:
            encSize = sizeof(uint64_t);
            break;
        default:
            break;
    }

    return encSize;
}
