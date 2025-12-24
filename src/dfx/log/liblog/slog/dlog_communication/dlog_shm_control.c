/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dlog_shm_control.h"
#include "share_mem.h"
#include "log_print.h"

STATIC int8_t g_msgType = MSGTYPE_TAG;

#if defined LOG_CPP || defined APP_LOG
STATIC LogStatus DlogReadMsgTypeFormShmem(int8_t *msgType)
{
    int32_t shmId = -1;
    ShmErr ret = ShMemOpen(&shmId);
    if (ret == SHM_ERROR) {
        SELF_LOG_ERROR("open shmem failed, slogd is not ready, pid=%d.", ToolGetPid());
        return LOG_FAILURE;
    }

    char *tmpBuf = (char *)LogMalloc(GLOBAL_ARR_LEN);
    if (tmpBuf == NULL) {
        SELF_LOG_ERROR("malloc failed, pid=%d, strerr=%s.", ToolGetPid(), strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    ShmErr res = ShMemRead(shmId, tmpBuf, GLOBAL_ARR_LEN, CONFIG_PATH_LEN);
    if (res == SHM_ERROR) {
        SELF_LOG_ERROR("read from shmem failed, pid=%d, strerr=%s.", ToolGetPid(), strerror(ToolGetErrorCode()));
        XFREE(tmpBuf);
        return LOG_FAILURE;
    }

    GloablArr *global = (GloablArr *)tmpBuf;
    *msgType = global->msgType;
    XFREE(tmpBuf);
    return LOG_SUCCESS;
}
#endif

void DlogInitMsgType(void)
{
#if (!defined LOG_CPP) && (!defined APP_LOG)
    // slog.so always use msg_type_struct
    g_msgType = MSGTYPE_STRUCT;
#else
    // alog.so read msg_type form shmem
    int8_t msgType = MSGTYPE_TAG;
    LogStatus ret = DlogReadMsgTypeFormShmem(&msgType);
    if (ret != LOG_SUCCESS) {
        g_msgType = MSGTYPE_TAG;
    } else {
        g_msgType = msgType;
    }
#endif
}

int8_t DlogGetMsgType(void)
{
    return g_msgType;
}