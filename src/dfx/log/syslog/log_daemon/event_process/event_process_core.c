/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "event_process_core.h"
#include "log_print.h"
#include "log_system_api.h"

#define EVENT_INTERVAL  100U

typedef struct EventHandleList {
    EventProcFunc func;
    void *arg;
    uint32_t periodTime;
    uint32_t durationTime;
    struct EventHandleList *next;
} EventHandleList;

typedef struct EventMgr {
    EventHandleList *eventList[MAX_EVENT_TYPE];
    ToolMutex lock[MAX_EVENT_TYPE];
    struct {
        ToolMutex mutex;
        ToolCond cond;
        ToolThread tid;
        bool isExit;
    } threadMgr;
} EventMgr;

static EventMgr g_eventMgr = {0};

static void EventFuncTrigger(EventHandleList *node)
{
    while (node != NULL) {
        node->durationTime += EVENT_INTERVAL;
        if (node->durationTime >= node->periodTime) {
            node->func(node->arg);
            node->durationTime = 0;
        }
        node = node->next;
    }
}

static void EventListUpdate(int32_t eventType)
{
    // the REAL_TIME_EVENT and DELAY_TIME_EVENT events need to be deleted after they are processed.
    if ((eventType != (int32_t)REAL_TIME_EVENT) && (eventType != (int32_t)DELAY_TIME_EVENT)) {
        return;
    }

    EventHandleList *node = g_eventMgr.eventList[eventType];
    EventHandleList *pre = NULL;
    EventHandleList *head = node;

    while (node != NULL) {
        if (node->durationTime == 0) {
            if (pre == NULL) {
                head = node->next;
            } else {
                pre->next = node->next;
            }
            EventHandleList *tmp = node->next;
            XFREE(node);
            node = tmp;
        } else {
            pre = node;
            node = node->next;
        }
    }
    g_eventMgr.eventList[eventType] = head;
}

static void *EventProcess(ArgPtr arg)
{
    (void)arg;
    if (ToolSetThreadName("EventProcess") != SYS_OK) {
        SELF_LOG_WARN("can not set thread_name(EventProcess) but continue.");
    }
    while (!g_eventMgr.threadMgr.isExit) {
        for (int32_t i = (int32_t)REAL_TIME_EVENT; i < (int32_t)MAX_EVENT_TYPE; i++) {
            if (g_eventMgr.eventList[i] == NULL) {
                continue;
            }
            (void)ToolMutexLock(&g_eventMgr.lock[i]);
            EventFuncTrigger(g_eventMgr.eventList[i]);
            EventListUpdate(i);
            (void)ToolMutexUnLock(&g_eventMgr.lock[i]);
        }
        (void)ToolMutexLock(&g_eventMgr.threadMgr.mutex);
        (void)ToolCondTimedWait(&g_eventMgr.threadMgr.cond, &g_eventMgr.threadMgr.mutex, EVENT_INTERVAL);
        (void)ToolMutexUnLock(&g_eventMgr.threadMgr.mutex);
    }
    return NULL;
}

int32_t EventThreadCreate(void)
{
    for (int32_t i = (int32_t)REAL_TIME_EVENT; i < (int32_t)MAX_EVENT_TYPE; i++) {
        (void)ToolMutexInit(&g_eventMgr.lock[i]);
    }
    // start thread
    ToolUserBlock thread;
    thread.procFunc = EventProcess;
    thread.pulArg = NULL;
    (void)ToolCondInit(&g_eventMgr.threadMgr.cond);
    (void)ToolMutexInit(&g_eventMgr.threadMgr.mutex);
    g_eventMgr.threadMgr.isExit = false;
    ToolThreadAttr attr = { 0, 0, 0, 0, 0, 0, 0 };
    ToolThread tid = 0;
    ONE_ACT_ERR_LOG(ToolCreateTaskWithThreadAttr(&tid, &thread, &attr) != SYS_OK, return LOG_FAILURE,
                    "create task failed, strerr=%s.", strerror(ToolGetErrorCode()));
    g_eventMgr.threadMgr.tid = tid;
    return LOG_SUCCESS;
}

/**
 * @brief       : notify thread asynchronous
 * @return      : void
 */
static INLINE void EventProcThreadNotify(void)
{
    (void)ToolMutexLock(&g_eventMgr.threadMgr.mutex);
    (void)ToolCondNotify(&g_eventMgr.threadMgr.cond);
    (void)ToolMutexUnLock(&g_eventMgr.threadMgr.mutex);
}

static void EventHandleRelease(EventHandleList *list)
{
    EventHandleList *next = list;
    while (list != NULL) {
        next = list->next;
        XFREE(list);
        list = next;
    }
}

static void EventListRelease(void)
{
    for (int32_t i = (int32_t)REAL_TIME_EVENT; i < (int32_t)MAX_EVENT_TYPE; i++) {
        if (g_eventMgr.eventList[i] == NULL) {
            continue;
        }
        (void)ToolMutexLock(&g_eventMgr.lock[i]);
        EventHandleRelease(g_eventMgr.eventList[i]);
        g_eventMgr.eventList[i] = NULL;
        (void)ToolMutexUnLock(&g_eventMgr.lock[i]);
    }
}

void EventThreadRelease(void)
{
    g_eventMgr.threadMgr.isExit = true;
    if (g_eventMgr.threadMgr.tid != 0) {
        EventProcThreadNotify();
        (void)ToolJoinTask(&g_eventMgr.threadMgr.tid);
        g_eventMgr.threadMgr.tid = 0;
    }
    EventListRelease();
    SELF_LOG_INFO("event thread exit.");
}

static void EventAddToList(EventHandleList *node, EventHandleList **list)
{
    if ((*list) == NULL) {
        *list = node;
        return;
    }
    EventHandleList *tmp = *list;
    while (tmp->next != NULL) {
        tmp = tmp->next;
    }
    tmp->next = node;
}

EventHandle EventAdd(EventProcFunc func, void *arg, EventAttr *attr)
{
    if ((func == NULL) || (attr == NULL)) {
        SELF_LOG_ERROR("input is null");
        return NULL;
    }
    if ((attr->type < REAL_TIME_EVENT) || (attr->type >= MAX_EVENT_TYPE)) {
        SELF_LOG_ERROR("invalid input, type = %d.", (int32_t)attr->type);
        return NULL;
    }
    EventHandleList *node = (EventHandleList *)LogMalloc(sizeof(EventHandleList));
    if (node == NULL) {
        SELF_LOG_ERROR("malloc failed, strerror = %s.", strerror(ToolGetErrorCode()));
        return NULL;
    }
    node->func = func;
    node->arg = arg;
    node->periodTime = attr->periodTime;
    node->durationTime = 0;
    node->next = NULL;
    (void)ToolMutexLock(&g_eventMgr.lock[attr->type]);
    EventAddToList(node, &g_eventMgr.eventList[attr->type]);
    (void)ToolMutexUnLock(&g_eventMgr.lock[attr->type]);
    return (EventHandle)node;
}

int32_t EventDelete(EventHandle handle)
{
    if (handle == NULL) {
        SELF_LOG_ERROR("input is invalid, handle is null.");
        return LOG_FAILURE;
    }
    EventHandleList *node = NULL;
    EventHandleList *pre = NULL;
    int32_t i = 0;
    for (i = (int32_t)REAL_TIME_EVENT; i < (int32_t)MAX_EVENT_TYPE; i++) {
        (void)ToolMutexLock(&g_eventMgr.lock[i]);
        node = g_eventMgr.eventList[i];
        pre = NULL;
        while ((node != NULL) && (node != handle)) {
            pre = node;
            node = node->next;
        }
        if (node == handle) {
            if (pre == NULL) {
                g_eventMgr.eventList[i] = node->next;
                XFREE(node);
            } else {
                pre->next = node->next;
                XFREE(node);
            }
            (void)ToolMutexUnLock(&g_eventMgr.lock[i]);
            return LOG_SUCCESS;
        }
        (void)ToolMutexUnLock(&g_eventMgr.lock[i]);
    }
    SELF_LOG_WARN("can not find handle to delete.");
    return LOG_FAILURE;
}