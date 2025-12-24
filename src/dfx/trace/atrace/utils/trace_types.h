/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TRACE_TYPES_H
#define TRACE_TYPES_H
#include <stdint.h>

typedef void* ArgPtr;
typedef intptr_t TracerHandle;

#define TRACE_RING_BUFFER_SPRINTF_FAILED            (-100)
#define TRACE_RING_BUFFER_GET_LOCAL_TIME_FAILED     (-101)
#define TRACE_RING_BUFFER_EMPTY                     (-102)

#define TRACE_QUEUE_NULL                            (-103)
#define TRACE_QUEUE_FULL                            (-104)

#define TRACER_SCHEDULE_NAME                        "schedule"
#define TRACER_STACKCORE_NAME                       "stackcore"
#define TRACER_EVENT_EXIT                           "exit"

#define TRACE_FILE_TXT_SUFFIX                       ".txt"
#define TRACE_FILE_BIN_SUFFIX                       ".bin"
#endif

