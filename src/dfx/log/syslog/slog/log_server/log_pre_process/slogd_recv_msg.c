/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "slogd_recv_msg.h"
#include "log_system_api.h"
#include "log_common.h"
#include "log_print.h"
#include "log_pm.h"
#include "log_pm_sig.h"
#include "slogd_communication.h"
#include "slogd_parse_msg.h"
#include "slogd_flush.h"

struct Globals {
    char recvBuf[MAX_READ];
    // parseBuf content can be doubled, because escaping control chars
    char parseBuf[MAX_READ + MAX_READ];
};

#define TWO_HUNDRED_MILLISECOND 200 // 200ms
STATIC struct Globals *g_globalsPtr = NULL;

#define SET_GLOBALS_PTR(x) do {                                  \
    (*(struct Globals **)&g_globalsPtr) = (struct Globals *)(x); \
    ToolMemBarrier();                                            \
} while (0)

#define FREE_GLOBALS_PTR()  do { \
    free(g_globalsPtr);          \
    g_globalsPtr = NULL;         \
} while (0)

char *SlogdGetRecvBuf(void)
{
    return g_globalsPtr->recvBuf;
}

char *SlogdGetParseBuf(void)
{
    return g_globalsPtr->parseBuf;
}

/**
 * @brief       : init g_globalsPtr
 * @return      : SYS_OK: success; SYS_ERROR: failed
 */
LogStatus SlogdInitGlobals(void)
{
    void *ptr = LogMalloc(sizeof(*g_globalsPtr));
    if (ptr == NULL) {
        SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    SET_GLOBALS_PTR(ptr);
    return LOG_SUCCESS;
}

/**
 * @brief       : free g_globalsPtr
 * @return      : NA
 */
void SlogdFreeGlobals(void)
{
    if (g_globalsPtr != NULL) {
        FREE_GLOBALS_PTR();
    }
}

void SlogdMessageRecv(int32_t devId)
{
    uint32_t fileNum = 0;
    int32_t ret = SlogdRmtServerCreate(devId, &fileNum);
    ONE_ACT_ERR_LOG(ret == SYS_ERROR, return, "create communication server failed, quit slogd process...");
    SELF_LOG_INFO("fileNum is : %u", fileNum);
    char *recvBuf = SlogdGetRecvBuf();
    int32_t logType = DEBUG_LOG;
    while (LogGetSigNo() == 0) {
        (void)memset_s(recvBuf, MAX_READ - 1U, 0, MAX_READ - 1U);
        int32_t sz = SlogdRmtServerRecv(fileNum, recvBuf, MAX_READ - 1U, &logType);
        TWO_ACT_NO_LOG(sz == SYS_INVALID_PARAM, (void)ToolSleep(10), continue); // sleep 10ms when iam list is null
        // read from socket over MAX_READ
        ONE_ACT_NO_LOG((sz > (int32_t)MAX_READ || sz == (int32_t)SYS_ERROR), continue);
        if (ProcSyslogBuf(recvBuf, &sz) != SYS_OK) {
            continue;
        }
        recvBuf[sz] = '\0';
        if ((logType >= 0) && (logType < LOG_TYPE_NUM)) {
            ProcEscapeThenLog(recvBuf, sz, (LogType)logType);
        }
    }
    SlogdRmtServerClose(devId, fileNum);
    SlogdSetStatus(SLOGD_EXIT);
}