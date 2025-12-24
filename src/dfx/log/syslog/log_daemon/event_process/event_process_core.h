/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
 
#ifndef EVENT_PROCESS_CORE_H
#define EVENT_PROCESS_CORE_H

#include "log_common.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef void* EventHandle;

enum EventType {
    REAL_TIME_EVENT,
    LOOP_TIME_EVENT,
    DELAY_TIME_EVENT,
    MAX_EVENT_TYPE
};

typedef struct EventAttr {
    enum EventType type;
    uint32_t periodTime; // ms
} EventAttr;

int32_t EventThreadCreate(void);
void EventThreadRelease(void);

typedef void (*EventProcFunc)(void *arg);
EventHandle EventAdd(EventProcFunc func, void *arg, EventAttr *attr);
int32_t EventDelete(EventHandle handle);

#ifdef __cplusplus
}
#endif
#endif