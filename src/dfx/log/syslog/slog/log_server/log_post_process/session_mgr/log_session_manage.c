/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "log_session_manage.h"
#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
#include "ascend_hal.h"
#include "securec.h"
#include "log_common.h"
#include "log_drv.h"
#include "log_print.h"
#include "slogd_dev_mgr.h"
#include "adcore_api.h"

// global zone
STATIC SessionNode *g_sessionPidDevIdList = NULL;
STATIC SessionNode *g_sessionPidDevIdDeletedList = NULL;
STATIC AdxCommHandle g_continuousExportSession = NULL;
STATIC uint32_t g_singleExportCounter = 0U;
STATIC ToolMutex g_sessionMutex = TOOL_MUTEX_INITIALIZER;
STATIC ToolMutex g_singleMutex = TOOL_MUTEX_INITIALIZER;
STATIC ToolMutex g_continuousMutex = TOOL_MUTEX_INITIALIZER;
#define MAX_SINGLE_EXPORT_SESSION       16U
#define SESSION_ERROR_WAIT_TIMEOUT      16
#define SESSION_RETRY_TIME              3
#define ACK_LEN                         64
#define ACK_TIMEOUT                     1000

LogRt InitSessionList(void)
{
    if (ToolMutexInit(&g_sessionMutex) != SYS_OK) {
        SELF_LOG_ERROR("init mutex failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return MUTEX_INIT_ERR;
    }

    return SUCCESS;
}

void FreeSessionList(void)
{
    LOCK_WARN_LOG(&g_sessionMutex);
    SessionNode *tmp = g_sessionPidDevIdList;
    SessionNode *node = NULL;
    while (tmp != NULL) {
        node = tmp;
        tmp = tmp->next;
        XFREE(node);
    }
    tmp = g_sessionPidDevIdDeletedList;
    while (tmp != NULL) {
        node = tmp;
        tmp = tmp->next;
        XFREE(node);
    }
    g_sessionPidDevIdList = NULL;
    g_sessionPidDevIdDeletedList = NULL;
    UNLOCK_WARN_LOG(&g_sessionMutex);
    (void)ToolMutexDestroy(&g_sessionMutex);
    return;
}

void PushDeletedSessionNode(SessionNode *node)
{
    ONE_ACT_NO_LOG(node == NULL, return);

    LOCK_WARN_LOG(&g_sessionMutex);
    if (g_sessionPidDevIdDeletedList == NULL) {
        g_sessionPidDevIdDeletedList = node;
        UNLOCK_WARN_LOG(&g_sessionMutex);
        return;
    }
    if (node->next != NULL) {
        // if node is list, insert to global list tail
        SessionNode *tmp = g_sessionPidDevIdDeletedList;
        while (tmp->next != NULL) {
            tmp = tmp->next;
        }
        tmp->next = node;
    } else {
        // if node is single, insert to global list head
        node->next = g_sessionPidDevIdDeletedList;
        g_sessionPidDevIdDeletedList = node;
    }
    UNLOCK_WARN_LOG(&g_sessionMutex);
}

SessionNode* PopDeletedSessionNode(void)
{
    LOCK_WARN_LOG(&g_sessionMutex);
    if (g_sessionPidDevIdDeletedList == NULL) {
        UNLOCK_WARN_LOG(&g_sessionMutex);
        return NULL;
    }
    SessionNode *tmp = g_sessionPidDevIdDeletedList;
    if (tmp != NULL) {
        g_sessionPidDevIdDeletedList = NULL;
    }
    UNLOCK_WARN_LOG(&g_sessionMutex);
    return tmp;
}

LogRt DeleteSessionNode(uintptr_t session, int32_t pid, int32_t devId)
{
    ONE_ACT_ERR_LOG((devId < 0) || (devId >= GLOBAL_MAX_DEV_NUM), return ARGV_NULL,
                    "invalid device id for deletion: %d", devId);
    LOCK_WARN_LOG(&g_sessionMutex);
    if (g_sessionPidDevIdList == NULL) {
        UNLOCK_WARN_LOG(&g_sessionMutex);
        return ARGV_NULL;
    }
    SessionNode *deletedNode = NULL;
    SessionNode *tmp = g_sessionPidDevIdList;
    if ((tmp->pid == pid) && (tmp->devId == devId) && (tmp->session == session)) {
        g_sessionPidDevIdList = tmp->next;
        tmp->next = NULL;
        deletedNode = tmp;
    } else {
        while ((tmp->next != NULL) && ((tmp->next->pid != pid) ||
            (tmp->next->devId != devId) || (tmp->next->session != session))) {
            tmp = tmp->next;
        }
        if ((tmp->next != NULL) && (tmp->next->pid == pid) &&
            (tmp->next->devId == devId) && (tmp->next->session == session)) {
            deletedNode = tmp->next;
            tmp->next = deletedNode->next;
            deletedNode->next = NULL;
        }
    }
    UNLOCK_WARN_LOG(&g_sessionMutex);
    PushDeletedSessionNode(deletedNode);
    return SUCCESS;
}

void HandleInvalidSessionNode(void)
{
    int32_t ret;
    int32_t value;
    SessionNode *tmp = NULL;
    LOCK_WARN_LOG(&g_sessionMutex);
    SessionNode *node = g_sessionPidDevIdList;
    // get the first valid session node
    while (node != NULL) {
        if (DrvDevIdGetBySession((HDC_SESSION)node->session, (int32_t)HDC_SESSION_ATTR_VFID, &value) != 0) {
            g_sessionPidDevIdList = node->next;
            ret = DrvSessionRelease((HDC_SESSION)node->session);
            SELF_LOG_INFO("release session finished, ret=%d, pid=%d", ret, node->pid);
            tmp = node;
            node = node->next;
            XFREE(tmp);
        } else {
            break;
        }
    }

    // delete invalid session nodes
    while ((node != NULL) && (node->next != NULL)) {
        if (DrvDevIdGetBySession((HDC_SESSION)node->next->session, (int32_t)HDC_SESSION_ATTR_VFID, &value) != 0) {
            ret = DrvSessionRelease((HDC_SESSION)node->next->session);
            SELF_LOG_INFO("release session finished, ret=%d, pid=%d", ret, node->next->pid);
            tmp = node->next;
            node->next = node->next->next;
            XFREE(tmp);
        } else {
            node = node->next;
        }
    }
    UNLOCK_WARN_LOG(&g_sessionMutex);
    return;
}

int32_t SendDataToSessionNode(uint32_t pid, uint32_t devId, const char *buf, size_t bufLen)
{
    SessionNode *node = GetDeletedSessionNode(pid, devId);
    if (node == NULL) {
        node = GetSessionNode(pid, devId);
        ONE_ACT_WARN_LOG(node == NULL, return ARGV_NULL, "can not get session info");
    }
    int32_t ret = DrvBufWrite((HDC_SESSION)node->session, buf, bufLen);
    NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "write data to hdc failed");
    return ret;
}

/**
 * @brief       : send hdc end buf to client to close session
 * @param [in]  : node          session info
 */
STATIC void DevLogReportEnd(SessionNode *node)
{
    int32_t ret;
    // log info's device id is host side
    // session node's device id is device side
    uint32_t hostDevId = GetHostDeviceID((uint32_t)node->devId);

    ret = DrvBufWrite((HDC_SESSION)node->session, HDC_END_BUF, sizeof(HDC_END_BUF));
    NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "write end buf to hdc failed, ret=%d, pid=%d, devId=%u.",
                   ret, node->pid, hostDevId);

    ret = DrvSessionRelease((HDC_SESSION)node->session);
    NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "release session failed, ret=%d, pid=%d, devId=%u.", ret, node->pid, hostDevId);
}

/**
 * @brief : Pop all session nodes which will be deleted from list, traverse each node and send log.
 * if session node is timeout, then step into the way that free session node and send hdc end buf to client.
 * if session node is not timeout, then save it to the next, and at last, push all remaining nodes to the list again.
 * @param [in]  : func         function of send all type log data to client
 */
void HandleDeletedSessionNode(LogSeverSendDataFunc func)
{
    SessionNode *pre = NULL;
    // pop all session nodes which will be deleted
    SessionNode *sessionNode = PopDeletedSessionNode();
    SessionNode *head = sessionNode;
    while (sessionNode != NULL) {
        // traverse each node
        sessionNode->timeout -= ONE_SECOND;
        g_sessionPidDevIdDeletedList = sessionNode;
        func((uint32_t)sessionNode->pid, (uint32_t)sessionNode->devId, sessionNode->timeout);
        g_sessionPidDevIdDeletedList = NULL;
        if (sessionNode->timeout <= 0) {
            // session node is timeout, the timeout value is notified by client (libalog.so)
            // delete node from list
            SessionNode *tmp = sessionNode->next;
            if (pre == NULL) {
                head = sessionNode->next;
            } else {
                pre->next = sessionNode->next;
            }
            // send end buf to client
            DevLogReportEnd(sessionNode);
            // free log node
            XFREE(sessionNode);
            sessionNode = tmp;
        } else {
            pre = sessionNode;
            sessionNode = sessionNode->next;
        }
    }
    // push none timeout nodes to the list again
    PushDeletedSessionNode(head);
}

LogRt InsertSessionNode(uintptr_t session, int32_t pid, int32_t devId)
{
    ONE_ACT_ERR_LOG((devId < 0) || (devId >= GLOBAL_MAX_DEV_NUM), return ARGV_NULL,
                    "invalid device id for insertion: %d", devId);
    SessionNode *sessionNode = (SessionNode *)malloc(sizeof(SessionNode));
    if (sessionNode == NULL) {
        SELF_LOG_ERROR("malloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return MALLOC_FAILED;
    }
    (void)memset_s(sessionNode, sizeof(SessionNode), 0, sizeof(SessionNode));
    sessionNode->pid = pid;
    sessionNode->devId = devId;
    sessionNode->session = session;
    LOCK_WARN_LOG(&g_sessionMutex);
    sessionNode->next = g_sessionPidDevIdList;
    g_sessionPidDevIdList = sessionNode;
    UNLOCK_WARN_LOG(&g_sessionMutex);
    return SUCCESS;
}

static SessionNode* GetSessionNodeByList(uint32_t pid, uint32_t devId, SessionNode *list)
{
    ONE_ACT_WARN_LOG(list == NULL, return NULL, "session node list is null.");

    SessionNode *tmp = list;
    while (tmp != NULL) {
        if ((tmp->pid == (int32_t)pid) && (tmp->devId == (int32_t)devId)) {
            return tmp;
        }
        tmp = tmp->next;
    }
    return NULL;
}

SessionNode* GetSessionNode(uint32_t pid, uint32_t devId)
{
    ONE_ACT_ERR_LOG(devId >= GLOBAL_MAX_DEV_NUM, return NULL, "invalid device id for node searching: %u", devId);

    LOCK_WARN_LOG(&g_sessionMutex);
    SessionNode *tmp = GetSessionNodeByList(pid, devId, g_sessionPidDevIdList);
    UNLOCK_WARN_LOG(&g_sessionMutex);
    return tmp;
}

SessionNode* GetDeletedSessionNode(uint32_t pid, uint32_t devId)
{
    ONE_ACT_ERR_LOG(devId >= GLOBAL_MAX_DEV_NUM, return NULL, "invalid device id for node searching: %u", devId);

    LOCK_WARN_LOG(&g_sessionMutex);
    SessionNode *tmp = GetSessionNodeByList(pid, devId, g_sessionPidDevIdDeletedList);
    UNLOCK_WARN_LOG(&g_sessionMutex);
    return tmp;
}

bool IsSessionNodeListNull(void)
{
    return g_sessionPidDevIdList == NULL;
}

/**
 * @brief       : add to single export session manager counter
 * @return      : LOG_SUCCESS: success; others: fail
 */
STATIC int32_t SessionMgrSingleExpAddSession(void)
{
    LOCK_WARN_LOG(&g_singleMutex);
    if (g_singleExportCounter >= MAX_SINGLE_EXPORT_SESSION) {
        SELF_LOG_ERROR("single export session num reaches the upper limit: %u.", MAX_SINGLE_EXPORT_SESSION);
        UNLOCK_WARN_LOG(&g_singleMutex);
        return LOG_FAILURE;
    }
    g_singleExportCounter++;
    UNLOCK_WARN_LOG(&g_singleMutex);
    return LOG_SUCCESS;
}

/**
 * @brief       : delete from single export session manager counter
 * @return      : LOG_SUCCESS: success; others: fail
 */
STATIC int32_t SessionMgrSingleExpDeleteSession(void)
{
    LOCK_WARN_LOG(&g_singleMutex);
    if (g_singleExportCounter == 0U) {
        SELF_LOG_ERROR("single export session num is 0.");
        UNLOCK_WARN_LOG(&g_singleMutex);
        return LOG_FAILURE;
    }
    g_singleExportCounter--;
    UNLOCK_WARN_LOG(&g_singleMutex);
    return LOG_SUCCESS;
}

/**
 * @brief       : assign value to continuous export recorder
 * @param [in]  : session     continuous export session
 * @return      : LOG_SUCCESS: success; others: fail
 */
STATIC int32_t SessionMgrContExpAddSession(void *session)
{
    LOCK_WARN_LOG(&g_continuousMutex);
    if (g_continuousExportSession != NULL) {
        SELF_LOG_ERROR("continuous export session num reaches the upper limit: 1.");
        UNLOCK_WARN_LOG(&g_continuousMutex);
        return LOG_FAILURE;
    }
    int32_t ret = AdxSendMsg((CommHandle*)session, HDC_END_MSG, strlen(HDC_END_MSG) + 1);
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("reply end message to host failed, ret=%d", ret);
        UNLOCK_WARN_LOG(&g_continuousMutex);
        return LOG_FAILURE;
    }
    g_continuousExportSession = (AdxCommHandle)session;
    UNLOCK_WARN_LOG(&g_continuousMutex);
    return LOG_SUCCESS;
}

/**
 * @brief       : release continuous export recorder
 */
STATIC void SessionMgrContExpDeleteSession(void)
{
    LOCK_WARN_LOG(&g_continuousMutex);
    AdxDestroyCommHandle(g_continuousExportSession);
    g_continuousExportSession = NULL;
    UNLOCK_WARN_LOG(&g_continuousMutex);
}

/**
 * @brief       : check if session of continuous export recorder is valid
 * @return      : true: valid; false: invalid
 */
STATIC int32_t SessionMgrContExpGetSession(SessionItem *item)
{
    LOCK_WARN_LOG(&g_continuousMutex);
    if (g_continuousExportSession == NULL) {
        UNLOCK_WARN_LOG(&g_continuousMutex);
        return LOG_FAILURE;
    }

    int32_t status = 0;
    int32_t ret = AdxGetAttrByCommHandle(g_continuousExportSession, HDC_SESSION_ATTR_STATUS, &status);
    if ((ret != LOG_SUCCESS) || (status == HDC_SESSION_STATUS_CLOSE)) {
        SELF_LOG_ERROR("continuous session is invalid, ret=%d, status=%d.", ret, status);
        AdxDestroyCommHandle(g_continuousExportSession);
        g_continuousExportSession = NULL;
        UNLOCK_WARN_LOG(&g_continuousMutex);
        return LOG_FAILURE;
    }
    item->session = g_continuousExportSession;
    UNLOCK_WARN_LOG(&g_continuousMutex);
    return LOG_SUCCESS;
}

/**
 * @brief       : add session node to corresponding session manager
 * @param [in]  : item     struct of session handle and session type
 * @return      : LOG_SUCCESS: success; others: fail
 */
int32_t SessionMgrAddSession(const SessionItem *item)
{
    ONE_ACT_ERR_LOG(item == NULL, return LOG_FAILURE, "add session failed, item is null.");
    ONE_ACT_ERR_LOG(item->session == NULL, return LOG_FAILURE, "add session failed, session is null.");

    if (item->type == SESSION_SINGLE_EXPORT) {
        return SessionMgrSingleExpAddSession();
    } else if (item->type == SESSION_CONTINUES_EXPORT) {
        return SessionMgrContExpAddSession(item->session);
    }
    SELF_LOG_ERROR("add session failed, session type is invalid, type: %d", (int32_t)item->type);
    return LOG_FAILURE;
}

/**
 * @brief       : check if session is valid
 * @param [in]  : item     struct of session handle and session type
 * @return      : LOG_SUCCESS: success; others: fail
 */
int32_t SessionMgrGetSession(SessionItem *item)
{
    ONE_ACT_ERR_LOG(item == NULL, return LOG_FAILURE, "check session valid failed, item is null.");
    if (item->type == SESSION_CONTINUES_EXPORT) {
        return SessionMgrContExpGetSession(item);
    }
    SELF_LOG_ERROR("get session failed, session type is invalid, type: %d", (int32_t)item->type);
    return LOG_FAILURE;
}

static void SessionMgrGetRespond(const SessionItem *handle)
{
    uint32_t bufLen = ACK_LEN;
    char *buffer = (char *)LogMalloc(bufLen);
    int32_t ret = AdxRecvMsg((AdxCommHandle)handle->session, (char **)&buffer, &bufLen, ACK_TIMEOUT);
    if (ret != IDE_DAEMON_OK) {
        SELF_LOG_ERROR("get ack failed, ret:%d.", ret);
    }
    XFREE(buffer);
}

/**
 * @brief       : send data to the peer end by adx function
 * @param [in]  : item     struct of session handle and session type
 * @param [in]  : data     data sent to the peer end
 * @param [in]  : len      length of data
 * @return      : LOG_SUCCESS: success; others: fail
 */
int32_t SessionMgrSendMsg(const SessionItem *handle, const char *data, uint32_t len)
{
    const SessionItem *item = (const SessionItem *)handle;
    if (item == NULL) {
        SELF_LOG_ERROR("send message failed, invalid session item.");
        return LOG_FAILURE;
    }
    if ((data == NULL) || (len == 0)) {
        SELF_LOG_ERROR("send message failed, invalid data, len: %u.", len);
        return LOG_FAILURE;
    }
    AdxCommConHandle comm = (AdxCommConHandle)handle->session;
    if (comm == NULL) {
        SELF_LOG_ERROR("send message failed, invalid session, type: %d.", (int32_t)handle->type);
        return LOG_FAILURE;
    }

    int32_t ret = 0;
    int32_t tryTimes = SESSION_RETRY_TIME;
    if (handle->type == SESSION_CONTINUES_EXPORT) {
            LOCK_WARN_LOG(&g_continuousMutex);
    }
    do {
        ret = AdxSendMsg(comm, data, len);
        tryTimes--;
    } while ((ret == SESSION_ERROR_WAIT_TIMEOUT) && (tryTimes > 0));
    if (handle->type == SESSION_CONTINUES_EXPORT) {
            UNLOCK_WARN_LOG(&g_continuousMutex);
    }
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("send message failed, ret: %d.", ret);
        if (handle->type == SESSION_CONTINUES_EXPORT) {
            LOCK_WARN_LOG(&g_continuousMutex);
            AdxDestroyCommHandle(g_continuousExportSession);
            g_continuousExportSession = NULL;
            UNLOCK_WARN_LOG(&g_continuousMutex);
        }
        return LOG_FAILURE;
    }
    SessionMgrGetRespond(handle);
    return LOG_SUCCESS;
}

/**
 * @brief       : delete session node from session manager
 * @param [in]  : item     struct of session handle and session type
 * @return      : LOG_SUCCESS: success; others: fail
 */
int32_t SessionMgrDeleteSession(const SessionItem *item)
{
    ONE_ACT_ERR_LOG(item == NULL, return LOG_FAILURE, "get session failed, item is null.");
    if (item->type == SESSION_SINGLE_EXPORT) {
        return SessionMgrSingleExpDeleteSession();
    } else if (item->type == SESSION_CONTINUES_EXPORT) {
        SessionMgrContExpDeleteSession();
        return LOG_SUCCESS;
    }
    SELF_LOG_ERROR("delete session failed, session type is invalid, type: %d", (int32_t)item->type);
    return LOG_FAILURE;
}