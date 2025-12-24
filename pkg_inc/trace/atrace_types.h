/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ATRACE_TYPES_H
#define ATRACE_TYPES_H

#include <stdint.h>
#include <stdbool.h>

typedef int32_t  TraStatus;
typedef intptr_t TraHandle;
typedef intptr_t TraEventHandle;

#define TRACE_EXPORT __attribute__((visibility("default")))

#define TRACE_SUCCESS         0
#define TRACE_FAILURE         (-1)
#define TRACE_INVALID_PARAM   (-2)
#define TRACE_INVALID_PTR     (-3)
#define TRACE_INVALID_DATA    (-4)
#define TRACE_UNSUPPORTED     (-5)

#define TRACE_INVALID_HANDLE      (-1)
#define TRACE_UNSUPPORTED_HANDLE  (-2)

#define DEFAULT_ATRACE_MSG_NUM 1024U
#define DEFAULT_ATRACE_MSG_SIZE 112U

// field type
#define TRACE_STRUCT_FIELD_TYPE_CHAR        0
#define TRACE_STRUCT_FIELD_TYPE_INT8        1
#define TRACE_STRUCT_FIELD_TYPE_UINT8       2
#define TRACE_STRUCT_FIELD_TYPE_INT16       3
#define TRACE_STRUCT_FIELD_TYPE_UINT16      4
#define TRACE_STRUCT_FIELD_TYPE_INT32       5
#define TRACE_STRUCT_FIELD_TYPE_UINT32      6
#define TRACE_STRUCT_FIELD_TYPE_INT64       7
#define TRACE_STRUCT_FIELD_TYPE_UINT64      8
#define TRACE_STRUCT_ARRAY_TYPE_CHAR        100
#define TRACE_STRUCT_ARRAY_TYPE_INT8        101
#define TRACE_STRUCT_ARRAY_TYPE_UINT8       102
#define TRACE_STRUCT_ARRAY_TYPE_INT16       103
#define TRACE_STRUCT_ARRAY_TYPE_UINT16      104
#define TRACE_STRUCT_ARRAY_TYPE_INT32       105
#define TRACE_STRUCT_ARRAY_TYPE_UINT32      106
#define TRACE_STRUCT_ARRAY_TYPE_INT64       107
#define TRACE_STRUCT_ARRAY_TYPE_UINT64      108
 
// save mode
#define TRACE_STRUCT_SHOW_MODE_DEC      0        // decimal
#define TRACE_STRUCT_SHOW_MODE_BIN      1        // binary
#define TRACE_STRUCT_SHOW_MODE_HEX      2        // hexadecimal
#define TRACE_STRUCT_SHOW_MODE_CHAR     3        // string
 

// evnet process type
#define TRACE_EVENT_PROCESS_SYNC                  0U  // process event synchronously
#define TRACE_EVENT_PROCESS_ASYNC                 1U  // process event asynchronously
#define TRACE_EVENT_PROCESS_ASYNC_DEDUPLICATION   2U  // process event asynchronously and deduplication

#define TRACE_NAME_LENGTH               32U

#define TRACE_STRUCT_ENTRY_MAX_NUM      10U

// lock type
#define TRACE_LOCK_BASED                0U
#define TRACE_LOCK_FREE                 1U

typedef enum TracerType {
    TRACER_TYPE_SCHEDULE   = 0,
    TRACER_TYPE_PROGRESS   = 1,
    TRACER_TYPE_STATISTICS = 2,
    TRACER_TYPE_MAX,
} TracerType;
 
typedef struct TraceStructEntry {
    char name[TRACE_NAME_LENGTH];		    // entry name
    void *list;	                            // field list
} TraceStructEntry;

typedef struct TraceAttr {
    bool exitSave;          // exec save when AtraceDestroy
    uint16_t msgNum;        // 1 - 1024, msgNum * msgSize <= 128k, msgNum >= max thread num * 2
    uint16_t msgSize;       // 64 - 1024
    TraceStructEntry *handle[TRACE_STRUCT_ENTRY_MAX_NUM];
    uint8_t noLock;         // 0: need lock to protect concurrent scenarios; 1: no lock to protect
    uint8_t reserve[31];
} TraceAttr;

typedef struct TraceEventAttr {
    uint16_t limitedNum;    // [0, 65535] 0 for unlimited
    uint8_t reserve[30];
} TraceEventAttr;

typedef struct TraceGlobalAttr {
    uint8_t saveMode;   // 0: local save; 1: send to remote and save
    uint8_t deviceId;   // 0: default; 32~63:vf
    uint32_t pid;       // 0: default; if saveMode=1, means host pid
    uint8_t reserve[32];
} TraceGlobalAttr;

#endif