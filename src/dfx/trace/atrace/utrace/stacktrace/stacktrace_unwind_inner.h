/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef STACKCORE_UNWIND_INNER_H
#define STACKCORE_UNWIND_INNER_H

#include <stddef.h>
#include "atrace_types.h"
#include "securec.h"
#include "stacktrace_logger.h"
#include "scd_dwarf.h"
#include "scd_log.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus


#define DW_EH_PE_OMIT 0xffU /* The value is not present */
/* 判断eh_frame_hdr段中是否有搜索表 */
#define TRACE_IS_HDR_TBL_PRESENT(frameHdrInfo) \
    (((DW_EH_PE_OMIT != (frameHdrInfo)->tabEnc) && \
      (DW_EH_PE_OMIT != (frameHdrInfo)->fdeCountEnc)) && \
     ((DW_EH_PE_DATAREL | DW_EH_PE_DATA4) == (frameHdrInfo)->tabEnc))

/* 解析过程中地址非法 */
#define TRACE_UNWIND_PARSE_ADDR_CHECK_OR_RETURN(addr) \
    do { \
        if ((addr) == NULL) { \
            return NULL; \
        } \
    } while (0)

#define TRACE_STACK_INDEX_CHECK_RET(idx, uiExpect, ret) \
    do { \
        if ((uiExpect) > (idx)) { \
            ret \
        } \
    } while (0)

#if defined(TRACE_WORDSIZE) && (TRACE_WORDSIZE != 64)
#define TRACE_MAX_LEB_BYRE 0x05 /* 该CPU环境下表示长整形所用uleb/sleb类型表示最大字节数 */
#else
#define TRACE_MAX_LEB_BYRE 0x0a /* 该CPU环境下表示长整形所用uleb/sleb类型表示最大字节数 */
#endif

#define TRACE_GET_LOW_BIT_VALUE 0x7fU
#define TRACE_GET_HIG_BIT_VALUE 0x80U
#define TRACE_MOVE_BIT_COUNT 0x07U

/* 高字节对齐 */
#define TRACE_UNWIND_HALIGN(value) ((((value) + sizeof(size_t) - 1U)) & ~((size_t)sizeof(size_t) - 1U))

/* 字节低位设置为0 */
#define TRACE_LOW_BIT_ZERO(data) (~((size_t)(data) - 1U))

/* the parse of the encode type */
#define TRACE_HIBIT1_ENCODE(x) ((x) & 0x80U)
#define TRACE_MDBIT3_ENCODE(x) ((x) & 0x70U)
#define TRACE_LOBIT4_ENCODE(x) ((x) & 0x0fU)


/* DWARF Exception Header Encoding:used to describe the type
 * data about two unwind segment:.eh_frame_hdr and .eh_frame.
 * Use one byte: the upper 4 bits and lower 4 bits different.
 */
#define DW_EH_PE_ABSPTR 0x00U  /* The type of pointer relative to architecture or address space */
#define DW_EH_PE_ULEB128 0x01U /* Unsigned little endian base 128 */
#define DW_EH_PE_UDATA2 0x02U  /* Unsigned 2 Byte */
#define DW_EH_PE_UDATA4 0x03U  /* Unsigned 4 Byte */
#define DW_EH_PE_UDATA8 0x04U  /* Unsigned 8 Byte */
#define DW_EH_PE_SIGNED 0x08U  /* signed number relative to architecture or address space */
#define DW_EH_PE_SLEB128 0x09U /* signed little endian base 128 */
#define DW_EH_PE_DATA2 0x0aU   /* signed 2 Byte */
#define DW_EH_PE_DATA4 0x0bU   /* signed 4 Byte */
#define DW_EH_PE_DATA8 0x0cU   /* signed 8 Byte */

#define DW_EH_PE_PCREL 0X10U    /* The value is relative to PC */
#define DW_EH_PE_TEXTREL 0x20U  /* The value is relative to Text */
#define DW_EH_PE_DATAREL 0x30U  /* The value is relative to Data */
#define DW_EH_PE_FUNCREL 0x40U  /* The value is relative to function start */
#define DW_EH_PE_ALIGNED 0x50U  /* The value is relative to the alignment of address */
#define DW_EH_PE_INDIRECT 0x80U /* The address of the real value */

const uint8_t *TraceReadEncodeValue(ScdDwarf *dwarf, const uint8_t encode, const uint8_t *byteAddr, uintptr_t *val);
const uint8_t *TraceReadUleb128(ScdDwarf *dwarf, const uint8_t *byteStream, uintptr_t *val);
const uint8_t *TraceReadLeb128(ScdDwarf *dwarf, const uint8_t *byteStream, intptr_t *psvVal);
size_t TraceReadBytes(ScdDwarf *dwarf, const uint8_t **src, void *dst, size_t size);
size_t TraceEncValueSizeGet(uint8_t encode);
static inline uint64_t TraceReadU64(const uint8_t *addr, size_t size)
{
    uint64_t result = 0;
    errno_t ret = memcpy_s(&result, sizeof(result), (const void *)addr, size);
    if (ret != EOK) {
        SCD_DLOG_ERR("memcpy addr to uint64_t failed, ret : %d", ret);
        return 0;
    }
    return result;
}
static inline int64_t TraceReadS64(const uint8_t *addr, size_t size)
{
    int64_t result = 0;
    errno_t ret = memcpy_s(&result, sizeof(result), (const void *)addr, size);
    if (ret != EOK) {
        SCD_DLOG_ERR("memcpy addr to int64_t failed, ret : %d", ret);
        return 0;
    }
    return result;
}
static inline uint32_t TraceReadU32(const uint8_t *addr, size_t size)
{
    uint32_t result = 0;
    errno_t ret = memcpy_s(&result, sizeof(result), (const void *)addr, size);
    if (ret != EOK) {
        SCD_DLOG_ERR("memcpy addr to uint32_t failed, ret : %d", ret);
        return 0;
    }
    return result;
}
static inline int32_t TraceReadS32(const uint8_t *addr, size_t size)
{
    int32_t result = 0;
    errno_t ret = memcpy_s(&result, sizeof(result), (const void *)addr, size);
    if (ret != EOK) {
        SCD_DLOG_ERR("memcpy addr to int32_t failed, ret : %d", ret);
        return 0;
    }
    return result;
}
static inline int16_t TraceReadS16(const uint8_t *addr, size_t size)
{
    int16_t result = 0;
    errno_t ret = memcpy_s(&result, sizeof(result), (const void *)addr, size);
    if (ret != EOK) {
        SCD_DLOG_ERR("memcpy addr to int16_t failed, ret : %d", ret);
        return 0;
    }
    return result;
}
static inline uint16_t TraceReadU16(const uint8_t *addr, size_t size)
{
    uint16_t result = 0;
    errno_t ret = memcpy_s(&result, sizeof(result), (const void *)addr, size);
    if (ret != EOK) {
        SCD_DLOG_ERR("memcpy addr to uint16_t failed, ret : %d", ret);
        return 0;
    }
    return result;
}
static inline uintptr_t TraceReadUintptr(const uint8_t *addr, size_t size)
{
    uintptr_t result = 0;
    errno_t ret = memcpy_s(&result, sizeof(result), addr, size);
    if (ret != EOK) {
        SCD_DLOG_ERR("memcpy addr to uintptr_t failed, ret : %d", ret);
        return 0;
    }
    return result;
}
#ifdef __cplusplus
}
#endif // __cplusplus
#endif

