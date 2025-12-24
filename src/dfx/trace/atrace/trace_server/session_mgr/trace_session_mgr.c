/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "trace_session_mgr.h"
#include "adiag_lock.h"
#include "adiag_print.h"
#include "trace_system_api.h"
#include "trace_adx_api.h"
#include "ascend_hal.h"

#define MAX_DEV_NUM                 64

STATIC SessionNode *g_sessionPidDevIdList = NULL;
STATIC SessionNode *g_sessionPidDevIdDeletedList = NULL;
STATIC AdiagLock g_sessionLock = TRACE_MUTEX_INITIALIZER;

void TraceServerSessionLock(void)
{
    (void)AdiagLockGet(&g_sessionLock);
}

void TraceServerSessionUnlock(void)
{
    (void)AdiagLockRelease(&g_sessionLock);
}

TraStatus TraceServerSessionInit(void)
{
    return AdiagLockInit(&g_sessionLock);
}

STATIC void TraceServerListExit(SessionNode *list)
{
    SessionNode *node = NULL;
    while (list != NULL) {
        node = list;
        list = list->next;
        TraceQueueFree(node->queue);
        ADIAG_SAFE_FREE(node->queue);
        TraceAdxDestroyCommHandle(node->handle);
        ADIAG_SAFE_FREE(node);
    }
}
 
void TraceServerSessionExit(void)
{
    TraceServerSessionLock();
    TraceServerListExit(g_sessionPidDevIdList);
    g_sessionPidDevIdList = NULL;
    TraceServerListExit(g_sessionPidDevIdDeletedList);
    g_sessionPidDevIdDeletedList = NULL;
    TraceServerSessionUnlock();
    AdiagLockDestroy(&g_sessionLock);
}

STATIC SessionNode* TraceServerPopDeletedSessionNode(void)
{
    SessionNode *tmp = g_sessionPidDevIdDeletedList;
    if (tmp != NULL) {
        g_sessionPidDevIdDeletedList = NULL;
    }
    return tmp;
}

STATIC void TraceServerPushDeletedSessionNode(SessionNode *node)
{
    if (node == NULL) {
        return;
    }
    if (g_sessionPidDevIdDeletedList == NULL) {
        g_sessionPidDevIdDeletedList = node;
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
}

/**
 * @brief       handle deleted session list node, if node is timeout, free it.
 * @param [in]  func:         handle function
 * @return      NA
 */
void TraceServerHandleDeletedSessionNode(TraceSeverSendDataFunc func)
{
    // pop all session nodes which will be deleted
    TraceServerSessionLock();
    SessionNode *sessionNode = TraceServerPopDeletedSessionNode();
    SessionNode *pre = NULL;
    SessionNode *head = sessionNode;
    while (sessionNode != NULL) {
        // traverse each node
        sessionNode->timeout -= SESSION_TIME_INTERVAL;
        g_sessionPidDevIdDeletedList = sessionNode;
        func(sessionNode, DELETED_SESSION_LIST);
        g_sessionPidDevIdDeletedList = NULL;
        if (sessionNode->timeout <= 0) {
            ADIAG_RUN_INF("session node is timeout, pid = %d.", sessionNode->pid);
            // session node is timeout, the timeout value is notified by client (libascend_trace.so)
            // delete node from list
            SessionNode *tmp = sessionNode->next;
            if (pre == NULL) {
                head = sessionNode->next;
            } else {
                pre->next = sessionNode->next;
            }
            // free log node
            TraceQueueFree(sessionNode->queue);
            ADIAG_SAFE_FREE(sessionNode->queue);
            TraceAdxDestroyCommHandle(sessionNode->handle);
            ADIAG_SAFE_FREE(sessionNode);
            sessionNode = tmp;
        } else {
            pre = sessionNode;
            sessionNode = sessionNode->next;
        }
    }
    // push none timeout nodes to the list again
    TraceServerPushDeletedSessionNode(head);
    TraceServerSessionUnlock();
}

/**
 * @brief       handle session list node, if handle is invalid, destroy it.
 * @param [in]  func:         handle function
 * @return      NA
 */
void TraceServerHandleSessionNode(TraceSeverSendDataFunc func)
{
    if (func == NULL) {
        return;
    }

    SessionNode *tmp = NULL;
    TraceServerSessionLock();
    SessionNode *node = g_sessionPidDevIdList;
    int32_t status = 0; // invalid value
    TraStatus ret = TRACE_SUCCESS;
    // get the first valid session node
    while (node != NULL) {
        // if handle is invalid, delete node
        status = 0;
        ret = TraceAdxGetAttrByCommHandle(node->handle, HDC_SESSION_ATTR_STATUS, &status);
        if ((ret != TRACE_SUCCESS) || (status == HDC_SESSION_STATUS_CLOSE)) {
            g_sessionPidDevIdList = node->next;
            TraceAdxDestroyCommHandle(node->handle);
            node->handle = NULL;
            ADIAG_RUN_INF("handle is invalid, release session finished, pid = %d", node->pid);
            tmp = node;
            node = node->next;
            TraceQueueFree(tmp->queue);
            ADIAG_SAFE_FREE(tmp->queue);
            ADIAG_SAFE_FREE(tmp);
        } else {
            func(node, SESSION_LIST);
            break;
        }
    }

    while ((node != NULL) && (node->next != NULL)) {
        status = 0;
        ret = TraceAdxGetAttrByCommHandle(node->next->handle, HDC_SESSION_ATTR_STATUS, &status);
        if ((ret != TRACE_SUCCESS) || (status == HDC_SESSION_STATUS_CLOSE)) {
            TraceAdxDestroyCommHandle(node->next->handle);
            node->next->handle = NULL;
            ADIAG_RUN_INF("handle is invalid, release session finished, pid = %d", node->next->pid);
            tmp = node->next;
            node->next = node->next->next;
            TraceQueueFree(tmp->queue);
            ADIAG_SAFE_FREE(tmp->queue);
            ADIAG_SAFE_FREE(tmp);
        } else {
            func(node->next, SESSION_LIST);
            node = node->next;
        }
    }
    TraceServerSessionUnlock();
    return;
}

STATIC SessionNode* TraceServerGetSessionNodeByList(int32_t pid, int32_t devId, SessionNode *list)
{
    SessionNode *tmp = list;
    while (tmp != NULL) {
        if ((tmp->pid == pid) && (tmp->devId == devId)) {
            return tmp;
        }
        tmp = tmp->next;
    }
    return NULL;
}

/**
 * @brief       get session node from list by pid and device id.
 * @param [in]  pid:         pid
 * @param [in]  devId:       device id
 * @return      SessionNode
 */
SessionNode* TraceServerGetSessionNode(int32_t pid, int32_t devId)
{
    if ((devId < 0) || (devId >= MAX_DEV_NUM) || (pid < 0)) {
        ADIAG_ERR("invalid input for session node searching: pid = %d, devId = %d", pid, devId);
        return NULL;
    }

    SessionNode *tmp = TraceServerGetSessionNodeByList(pid, devId, g_sessionPidDevIdDeletedList);
    if (tmp == NULL) {
        tmp = TraceServerGetSessionNodeByList(pid, devId, g_sessionPidDevIdList);
    }
    return tmp;
}

/**
 * @brief       insert session node.
 * @param [in]  handle:      session handle
 * @param [in]  pid:         pid
 * @param [in]  devId:       device id
 * @param [in]  timeout:     timeout
 * @return      TraStatus
 */
TraStatus TraceServerInsertSessionNode(const void *handle, int32_t pid, int32_t devId, int32_t timeout)
{
    if ((TraceAdxIsCommHandleValid(handle) != TRACE_SUCCESS) || (devId < 0) || (devId >= MAX_DEV_NUM) || (pid < 0)) {
        ADIAG_ERR("invalid input for session node insert: pid = %d, devId = %d", pid, devId);
        return TRACE_INVALID_PARAM;
    }
    TraceServerSessionLock();
    if (TraceServerGetSessionNode(pid, devId) != NULL) {
        ADIAG_WAR("can not insert session, session has existed.");
        TraceServerSessionUnlock();
        return TRACE_FAILURE;
    }
    SessionNode *sessionNode = (SessionNode *)AdiagMalloc(sizeof(SessionNode));
    if (sessionNode == NULL) {
        ADIAG_ERR("malloc session node failed, strerr=%s.", strerror(AdiagGetErrorCode()));
        TraceServerSessionUnlock();
        return TRACE_FAILURE;
    }
    sessionNode->queue = (TraceQueue *)AdiagMalloc(sizeof(TraceQueue));
    if (sessionNode->queue == NULL) {
        ADIAG_ERR("malloc queue failed, strerr=%s.", strerror(AdiagGetErrorCode()));
        TraceServerSessionUnlock();
        ADIAG_SAFE_FREE(sessionNode);
        return TRACE_FAILURE;
    }
    sessionNode->pid = pid;
    sessionNode->devId = devId;
    sessionNode->handle = handle;
    sessionNode->timeout = timeout;
    TraceQueueInit(sessionNode->queue);
    sessionNode->next = g_sessionPidDevIdList;
    g_sessionPidDevIdList = sessionNode;
    TraceServerSessionUnlock();
    return TRACE_SUCCESS;
}

/**
 * @brief       push session node from session list to deleted session list.
 * @param [in]  handle:         handle
 * @param [in]  pid:            pid
 * @param [in]  devId:          device id
 * @return      TraStatus
 */
TraStatus TraceServerDeleteSessionNode(const void *handle, int32_t pid, int32_t devId)
{
    if ((TraceAdxIsCommHandleValid(handle) != TRACE_SUCCESS) || (devId < 0) || (devId >= MAX_DEV_NUM) || (pid < 0)) {
        ADIAG_ERR("invalid input for session node delete: pid = %d, devId = %d", pid, devId);
        return TRACE_INVALID_PARAM;
    }
    TraceServerSessionLock();
    if (g_sessionPidDevIdList == NULL) {
        TraceServerSessionUnlock();
        return TRACE_INVALID_DATA;
    }
    SessionNode *deletedNode = NULL;
    SessionNode *tmp = g_sessionPidDevIdList;
    if ((tmp->pid == pid) && (tmp->devId == devId)) {
        g_sessionPidDevIdList = tmp->next;
        tmp->next = NULL;
        deletedNode = tmp;
    } else {
        while ((tmp->next != NULL) && ((tmp->next->pid != pid) ||
            (tmp->next->devId != devId))) {
            tmp = tmp->next;
        }
        if ((tmp->next != NULL) && (tmp->next->pid == pid) &&
            (tmp->next->devId == devId)) {
            deletedNode = tmp->next;
            tmp->next = deletedNode->next;
            deletedNode->next = NULL;
        }
    }
    TraceServerPushDeletedSessionNode(deletedNode);
    TraceServerSessionUnlock();
    return TRACE_SUCCESS;
}

bool TraceIsSessionNodeListNull(void)
{
    return (g_sessionPidDevIdList == NULL);
}

bool TraceIsDeletedSessionNodeListNull(void)
{
    return (g_sessionPidDevIdDeletedList == NULL);
}