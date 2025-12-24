/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef SLOGD_FLUSH_H
#define SLOGD_FLUSH_H

#include <stdbool.h>
#include "log_common.h"
#include "log_to_file.h"
#include "slogd_buffer.h"
#include "slogd_thread_mgr.h"
#include "log_session_manage.h"

#ifdef __cplusplus
extern "C" {
#endif

#define NO_APP_DATA_MAX_COUNT 60   // log buf node will be released when count come to it
#define MAX_WRITE_WAIT_TIME 3 // log report to host wait max 3 time

typedef enum {
    SLOGD_INIT,
    SLOGD_RUNNING,
    SLOGD_EXIT,
    SLOGD_INVALID
} SlogdStatus;

typedef struct {
    ThreadType type;
    LogPriority priority;
    int32_t (*flush)(void *, uint32_t, bool);
    void (*get)(SessionItem *, void*, uint32_t, int32_t);
} LogFlushNode;

void SlogdSetStatus(SlogdStatus status);
SlogdStatus SlogdGetStatus(void);
bool SlogdFlushIsThreadExit(void);

LogStatus SlogdFlushInit(void);
void SlogdFlushExit(void);
void SlogdFlushToFile(bool flushFlag);
void SlogdFlushGet(SessionItem *handle);
StLogFileList* GetGlobalLogFileList(void);
toolMode SyncGroupToOther(toolMode perm);

int32_t SlogdFlushRegister(const LogFlushNode *flushNode);

#ifdef __cplusplus
}
#endif
#endif // SLOGD_FLUSH_H
