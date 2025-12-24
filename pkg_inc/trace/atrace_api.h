/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ATRACE_API_H
#define ATRACE_API_H

#include "atrace_types.h"
#include "atrace_pub.h"

#ifdef __cplusplus
extern "C" {
#endif

TRACE_EXPORT void *AtraceStructEntryListInit(void) __attribute((weak));
TRACE_EXPORT void AtraceStructEntryName(TraceStructEntry *entry, const char *name) __attribute((weak));
TRACE_EXPORT void AtraceStructItemSet(TraceStructEntry *entry, const char *name,
    uint8_t type, uint8_t mode, uint16_t length) __attribute((weak));
TRACE_EXPORT void AtraceStructEntryExit(TraceStructEntry *entry) __attribute((weak));

#define TRACE_STRUCT_INIT_ENTRY                                                             \
{                                                                                               \
    .name = {0},                                                                                \
    .list = AtraceStructEntryListInit()                                                         \
}

/**
 * @brief       trace struct define
 * @param [out] en:         trace struct entry
 * @return      NA
 */
#define TRACE_STRUCT_DEFINE_ENTRY(en)                          TraceStructEntry en = TRACE_STRUCT_INIT_ENTRY

/**
 * @brief       trace struct undefine
 * @param [in]  en:         trace struct entry
 * @return      NA
 */
#define TRACE_STRUCT_UNDEFINE_ENTRY(en)                        AtraceStructEntryExit(&en)

/**
 * @brief           set trace struct entry name
 * @param [in/out]  en:         trace struct entry
 * @param [in]      name:       trace struct entry name
 * @return          NA
 */
#define TRACE_STRUCT_DEFINE_ENTRY_NAME(en, name)               AtraceStructEntryName(&en, name)

/**
 * @brief           define trace struct item of int
 * @param [in/out]  en:         trace struct entry
 * @param [in]      item:       item name
 * @return          NA
 */
#define TRACE_STRUCT_DEFINE_FIELD_INT8(en, item)                                 \
    AtraceStructItemSet(&en, #item, TRACE_STRUCT_FIELD_TYPE_INT8, TRACE_STRUCT_SHOW_MODE_DEC, 1)
 
#define TRACE_STRUCT_DEFINE_FIELD_INT16(en, item)                                \
    AtraceStructItemSet(&en, #item, TRACE_STRUCT_FIELD_TYPE_INT16, TRACE_STRUCT_SHOW_MODE_DEC, 2)
 
#define TRACE_STRUCT_DEFINE_FIELD_INT32(en, item)                                \
    AtraceStructItemSet(&en, #item, TRACE_STRUCT_FIELD_TYPE_INT32, TRACE_STRUCT_SHOW_MODE_DEC, 4)
 
#define TRACE_STRUCT_DEFINE_FIELD_INT64(en, item)                                \
    AtraceStructItemSet(&en, #item, TRACE_STRUCT_FIELD_TYPE_INT64, TRACE_STRUCT_SHOW_MODE_DEC, 8)

/**
 * @brief           define trace struct item of uint
 * @param [in/out]  en:         trace struct entry
 * @param [in]      item:       item name
 * @param [in]      mode:       item save mode
 * @return          NA
 */
#define TRACE_STRUCT_DEFINE_FIELD_UINT8(en, item, mode)                               \
    AtraceStructItemSet(&en, #item, TRACE_STRUCT_FIELD_TYPE_UINT8, mode, 1)
 
#define TRACE_STRUCT_DEFINE_FIELD_UINT16(en, item, mode)                               \
    AtraceStructItemSet(&en, #item, TRACE_STRUCT_FIELD_TYPE_UINT16, mode, 2)
 
#define TRACE_STRUCT_DEFINE_FIELD_UINT32(en, item, mode)                               \
    AtraceStructItemSet(&en, #item, TRACE_STRUCT_FIELD_TYPE_UINT32, mode, 4)
 
#define TRACE_STRUCT_DEFINE_FIELD_UINT64(en, item, mode)                               \
    AtraceStructItemSet(&en, #item, TRACE_STRUCT_FIELD_TYPE_UINT64, mode, 8)

/**
 * @brief           define trace struct item of char
 * @param [in/out]  en:         trace struct entry
 * @param [in]      item:       item name
 * @return          NA
 */
#define TRACE_STRUCT_DEFINE_FIELD_CHAR(en, item)                               \
    AtraceStructItemSet(&en, #item, TRACE_STRUCT_FIELD_TYPE_CHAR, TRACE_STRUCT_SHOW_MODE_CHAR, bytes, len)

/**
 * @brief           define trace struct item of int array
 * @param [in/out]  en:         trace struct entry
 * @param [in]      item:       item name
 * @param [in]      len:        bytes occupied by this item
 * @return          NA
 */
#define TRACE_STRUCT_DEFINE_ARRAY_INT8(en, item, len)                                \
    AtraceStructItemSet(&en, #item, TRACE_STRUCT_ARRAY_TYPE_INT8, TRACE_STRUCT_SHOW_MODE_DEC, len)
 
#define TRACE_STRUCT_DEFINE_ARRAY_INT16(en, item, len)                                \
    AtraceStructItemSet(&en, #item, TRACE_STRUCT_ARRAY_TYPE_INT16, TRACE_STRUCT_SHOW_MODE_DEC, len)
 
#define TRACE_STRUCT_DEFINE_ARRAY_INT32(en, item, len)                                \
    AtraceStructItemSet(&en, #item, TRACE_STRUCT_ARRAY_TYPE_INT32, TRACE_STRUCT_SHOW_MODE_DEC, len)
 
#define TRACE_STRUCT_DEFINE_ARRAY_INT64(en, item, len)                                \
    AtraceStructItemSet(&en, #item, TRACE_STRUCT_ARRAY_TYPE_INT64, TRACE_STRUCT_SHOW_MODE_DEC, len)

/**
 * @brief           define trace struct item of uint array
 * @param [in/out]  en:         trace struct entry
 * @param [in]      item:       item name
 * @param [in]      mode:       item save mode
 * @param [in]      len:        bytes occupied by this item
 * @return          NA
 */
#define TRACE_STRUCT_DEFINE_ARRAY_UINT8(en, item, mode, len)                               \
    AtraceStructItemSet(&en, #item, TRACE_STRUCT_ARRAY_TYPE_UINT8, mode, len)
 
#define TRACE_STRUCT_DEFINE_ARRAY_UINT16(en, item, mode, len)                               \
    AtraceStructItemSet(&en, #item, TRACE_STRUCT_ARRAY_TYPE_UINT16, mode, len)
 
#define TRACE_STRUCT_DEFINE_ARRAY_UINT32(en, item, mode, len)                               \
    AtraceStructItemSet(&en, #item, TRACE_STRUCT_ARRAY_TYPE_UINT32, mode, len)
 
#define TRACE_STRUCT_DEFINE_ARRAY_UINT64(en, item, mode, len)                               \
    AtraceStructItemSet(&en, #item, TRACE_STRUCT_ARRAY_TYPE_UINT64, mode, len)

/**
 * @brief           define trace struct item of char array
 * @param [in/out]  en:         trace struct entry
 * @param [in]      item:       item name
 * @param [in]      len:        bytes occupied by this item
 * @return          NA
 */
#define TRACE_STRUCT_DEFINE_ARRAY_CHAR(en, item, len)                               \
    AtraceStructItemSet(&en, #item, TRACE_STRUCT_ARRAY_TYPE_CHAR, TRACE_STRUCT_SHOW_MODE_CHAR, len)

/**
 * @brief           set trace struct to trace attribute
 * @param [in]      en:         trace struct entry
 * @param [in]      type:       trace buffer type
 * @param [in/out]  attr:       object attribute
 * @return          NA
 */
#define TRACE_STRUCT_SET_ATTR(en, type, attr)                                             \
    ((type < TRACE_STRUCT_ENTRY_MAX_NUM) ? (attr)->handle[type] = &(en) : NULL)

/**
 * @brief       create thread to receive device trace log
 * @param [in]  devId:         device id
 * @return      TraStatus
 */
TRACE_EXPORT TraStatus AtraceReportStart(int32_t devId) __attribute((weak));
 
 /**
 * @brief       stop thread to receive device trace log
 * @param [in]  devId:         device id
 */
TRACE_EXPORT void AtraceReportStop(int32_t devId) __attribute((weak));

/**
 * @brief       Report event and save the bound trace log to disk
 * @param [in]  eventHandle:    event handle
 * @return      TraStatus
 */
TRACE_EXPORT TraStatus AtraceEventReport(TraEventHandle eventHandle) __attribute((weak));

#ifdef __cplusplus
}
#endif // end of the 'extern "C"' block

#endif