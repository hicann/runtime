/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "slogd_parse_msg.h"
#include "slogd_dev_mgr.h"
#include "log_print.h"
#include "slogd_recv_msg.h"
#include "slogd_recv_core.h"

STATIC uint32_t SlogdStrToUint(const char *str, char **endPtr)
{
    errno = 0;
    uint64_t ret = strtoul(str, endPtr, BASE_NUM);
    if (str == *endPtr) {
        return (UINT_MAX);
    }
    if (((ret == 0U) || (ret == ULONG_MAX)) && (errno == ERANGE)) {
        return (UINT_MAX);
    }

    if (ret <= UINT_MAX) {
        return (uint32_t)ret;
    }
    return (UINT_MAX);
}

STATIC void SlogdParseMsgTag(char **input, LogInfo *info)
{
    ONE_ACT_NO_LOG((input == NULL) || (*input == NULL) || (info == NULL), return);
    char *p = *input;
    const char *start = NULL;
    if (*p == '[') {
        start = p + 1;
        uint32_t pt = SlogdStrToUint(start, &p);
        info->processType = (pt != 0) ? SYSTEM : APPLICATION;
        if (*p == ',') {
            start = p + 1;
            info->pid = SlogdStrToUint(start, &p);
            if (*p == ',') {
                start = p + 1;
                info->deviceId = GetHostSideDeviceId(SlogdStrToUint(start, &p));
                if (*p == ',') {
                    start = p + 1;
                    pt = SlogdStrToUint(start, &p);
                    info->type = (pt < (uint32_t)LOG_TYPE_NUM) ? (LogType)pt : DEBUG_LOG;
                    if (*p == ',') {
                        start = p + 1;
                        pt = SlogdStrToUint(start, &p);
                        info->aosType = (pt <= (uint32_t)(INT_MAX)) ? (int32_t)pt : 0;
                    }
                }
            }
        }
    }
    if (*p == ']') {
        p++;
    }
    *input = p;
    if ((info->processType == APPLICATION) && (info->pid == 0)) {
        info->processType = SYSTEM;
    }
}

STATIC bool SlogdCheckMsgHead(const char *input, uint32_t len)
{
    ONE_ACT_NO_LOG((len < LOGHEAD_LEN), return false);
    LogHead head ;
    int32_t ret = memcpy_s(&head, LOGHEAD_LEN, input, LOGHEAD_LEN);
    if (ret != EOK) {
        SELF_LOG_ERROR("memcpy failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return false;
    }

    if ((head.magic == HEAD_MAGIC) && (head.version == HEAD_VERSION)) {
        return true;
    } else {
        return false;
    }
}

STATIC void SlogdParseMsgHead(char **input, LogInfo *info)
{
    LogHead head;
    int32_t ret = memcpy_s(&head, LOGHEAD_LEN, *input, LOGHEAD_LEN);
    if (ret != EOK) {
        SELF_LOG_ERROR("memcpy failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return;
    }
    info->type = (LogType)head.logType;
    info->processType = (ProcessType)head.processType;
    info->pid = head.hostPid;
    info->deviceId = GetHostSideDeviceId(head.deviceId);
    info->moduleId = (int32_t)head.moduleId;
    info->aosType = (int32_t)head.aosType;
    info->level = (int8_t)head.logLevel;
    *input += LOGHEAD_LEN;
}

STATIC void SlogdParseMsg(char **input, uint32_t len, LogInfo *info)
{
    ONE_ACT_NO_LOG((input == NULL) || (*input == NULL) || (info == NULL), return);

    if (SlogdCheckMsgHead((const char *)*input, len)) {
        SlogdParseMsgHead(input, info);
    } else {
        SlogdParseMsgTag(input, info);
    }
}

/**
* @brief ProcSyslogBuf: proc syslog buf with space or endline
* @param [in]recvBuf: receive syslog buf
* @param [in]pSize: receive syslog buf size
* @return: SYS_OK/SYS_ERROR
*/
int32_t ProcSyslogBuf(const char* recvBuf, int32_t* size)
{
    if ((recvBuf == NULL) || (size == NULL)) {
        SELF_LOG_ERROR("receive log failed by socket, input null.");
        return SYS_ERROR;
    }

    int sizeTmp = *size;
    if (sizeTmp < 0) {
        SELF_LOG_ERROR("receive log failed by socket, size=%d, strerr=%s.", sizeTmp, strerror(ToolGetErrorCode()));
        return SYS_ERROR;
    }

    while (1) {
        if (sizeTmp == 0) {
            return SYS_ERROR;
        }
        if ((recvBuf[sizeTmp - 1] != '\0') && (recvBuf[sizeTmp - 1] != '\n')) {
            break;
        }
        sizeTmp--;
    }

    *size = sizeTmp;
    return SYS_OK;
}

void ProcEscapeThenLog(char *tmpbuf, int32_t len, LogType type)
{
    ONE_ACT_ERR_LOG(tmpbuf == NULL, return, "[input] temp buffer is null.");
    char *p = tmpbuf;
    const char *endBuf = tmpbuf + len;
    char *parseBuf = SlogdGetParseBuf();
    while (endBuf > p) {
        char *q = parseBuf;
        LogInfo info = { DEBUG_LOG, APPLICATION, 0, 0, 0, 0, 0 };
        info.type = type;
        SlogdParseMsg(&p, (uint32_t)len, &info);
        char c = *p;
        while (c != '\0') {
            if (c == '\n') {
                c = ' ';
            }
            if (((c > 0) && (c <= 0x1f)) && (c != '\t')) {
                *q = '^';
                q++;
                c += '@'; // escape special char
            }
            *q = c;
            q++;
            p++;
            c = *p;
        }
        if (q == parseBuf) {
            if (c == '\0') {
                break;
            }
            continue;
        }
        *q = '\n';
        q++;
        *q = '\0';
        SlogdWriteToBuffer(parseBuf, LogStrlen(parseBuf), &info);
    }
}
