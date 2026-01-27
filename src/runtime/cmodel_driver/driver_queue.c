/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <pthread.h>
#include "driver_queue.h"
#include "tsch/tsch_interrupt.h"
#include "tsch/host_interface.h"

drvQosQueue_t g_drvQosQueue[MAX_DEV_NUM][TS_TASK_CMD_QUEUE_PRIORITIES_LEVEL];
drvQosMgmt_t g_drvQosQueueMgmt[MAX_DEV_NUM][TS_TASK_CMD_QUEUE_PRIORITIES_LEVEL];
drvReportQueue_t g_drvReportQueue[MAX_DEV_NUM];
drvSem_t g_drvSem[MAX_DEV_NUM];
pthread_mutex_t g_cq_report_mutex = PTHREAD_MUTEX_INITIALIZER;

static void drvSemInit(drvSem_t *sem, int32_t initCnt)
{
    (void)sem_init(sem, 0, (uint32_t)initCnt);
}
void drvSemPost(drvSem_t *sem)
{
    (void)sem_post(sem);
}
void drvSemWait(drvSem_t *sem)
{
    (void)sem_wait(sem);
}

drvReportQueue_t *drvGetReportQueues(int32_t deviceId)
{
    COND_RETURN_CMODEL((deviceId < 0) || (deviceId >= MAX_DEV_NUM), NULL, "invalid device %d", deviceId);

    return &(g_drvReportQueue[deviceId]);
}

drvError_t drvMoveTsReport(int32_t deviceId)
{
    COND_RETURN_CMODEL((deviceId < 0) || (deviceId >= MAX_DEV_NUM), DRV_ERROR_INVALID_VALUE, "invalid device_id=%d",
        deviceId);
#ifndef __DRV_CFG_DEV_PLATFORM_ESL__
    int result = pthread_mutex_lock(&g_cq_report_mutex);
    if (result != 0) {
        DRVSTUB_LOG("pthread lock failed. result=%d", result);
    }
    drvReportQueue_t *drvReport = NULL;
    ts_task_report_queue_t *tsReport = NULL;
    drvError_t ret;

    drvReport = drvGetReportQueues(deviceId);

    COND_GOTO_CMODEL(drvReport == NULL, EXIT, ret, DRV_ERROR_INVALID_HANDLE, "drvGetReportQueues failed");
    COND_GOTO_CMODEL(drvReport->headIndex == (drvReport->tailIndex + 1) % DRV_REPORT_QUEUE_SIZE,
                     EXIT, ret, DRV_ERROR_INNER_ERR, "report queue is full");

    tsReport = ts_get_task_report_queue();
    COND_GOTO_CMODEL(tsReport == NULL, EXIT, ret, DRV_ERROR_INVALID_HANDLE,
                     "ts_get_task_report_queue failed");
    COND_GOTO_CMODEL(tsReport->write_idx == tsReport->read_idx, EXIT, ret, DRV_ERROR_INNER_ERR,
                     "taskReportQueue is empty");
    ret = (drvError_t)memcpy_s(&drvReport->retort[drvReport->tailIndex], sizeof(drvReportStruct_t),
                               &tsReport->task_report_slot[tsReport->read_idx], sizeof(ts_task_report_msg_t));

    COND_GOTO_CMODEL(ret != DRV_ERROR_NONE, EXIT, ret, DRV_ERROR_INVALID_VALUE,
        "memcpy_s failed, ret=%d", (int32_t)ret);

    drvReport->tailIndex = (drvReport->tailIndex + 1) % DRV_REPORT_QUEUE_SIZE;
    tsReport->read_idx = (tsReport->read_idx + 1) % 1024;  // task scheduler deal with 1024 tasks report;

    result = pthread_mutex_unlock(&g_cq_report_mutex);
    if (result != 0) {
        DRVSTUB_LOG("pthread unlock failed. result=%d", result);
    }
    DRVSTUB_LOG("memcpy one report from TS to Driver stub successfully.\n");
    return DRV_ERROR_NONE;
EXIT:
    (void)pthread_mutex_unlock(&g_cq_report_mutex);
    return ret;
#else
    return DRV_ERROR_NONE;
#endif
}

drvError_t drvQosHanddleToId(int32_t deviceId, int8_t *qos, int32_t *qid, const drvCommand_t * const cmd)
{
    int32_t i, j;
    int8_t qosLevel = -1;
    int32_t qosId = -1;
    size_t cmdSize;
    uint64_t offetAddress;

    COND_RETURN_CMODEL((deviceId < 0) || (deviceId >= MAX_DEV_NUM), DRV_ERROR_INVALID_VALUE, "invalid device_id=%d",
        deviceId);
    COND_RETURN_CMODEL(qos == NULL, DRV_ERROR_INVALID_VALUE, "qos is NULL");
    COND_RETURN_CMODEL(qid == NULL, DRV_ERROR_INVALID_VALUE, "qid is NULL");
    COND_RETURN_CMODEL(cmd == NULL, DRV_ERROR_INVALID_VALUE, "cmd is NULL");

    cmdSize = sizeof(drvCommandStruct_t);

    for (i = 0; i < (int32_t)TS_TASK_CMD_QUEUE_PRIORITIES_LEVEL; i++) {
        offetAddress = ((uint64_t)((uintptr_t)cmd) - (uint64_t)((uintptr_t)&g_drvQosQueue[deviceId][i].taskCommand[0]));
        if (offetAddress < (cmdSize * DRV_QOS_QUEUE_SIZE)) {
            qosLevel = (int8_t)i;
            for (j = 0; j < DRV_QOS_QUEUE_SIZE; j++) {
                if ((uint64_t)((uintptr_t)cmd) == (uint64_t)((uintptr_t)&g_drvQosQueue[deviceId][i].taskCommand[j])) {
                    qosId = j;
                    break;
                }
            }
            break;
        }
    }

    *qos = qosLevel;
    *qid = qosId;

    return DRV_ERROR_NONE;
}

static drvBool_t IsQosEmpty(const drvQosQueue_t * const queue)
{
    if (queue->headIndex == queue->tailIndex) {
        return DRV_TRUE;
    }

    return DRV_FALSE;
}

drvError_t drvSubmitCommand(ts_task_cmd_queue_t *task, drvQosQueue_t *qos, drvQosMgmt_t *qosMgmt)
{
    COND_RETURN_CMODEL(task == NULL, DRV_ERROR_INVALID_VALUE, "task is NULL");
    if ((qosMgmt->Credit <= 1U) || (qosMgmt->Credit > TS_SIZE_OF_PER_TASK_CMD_QUEUE)) {
        qosMgmt->Credit = TS_SIZE_OF_PER_TASK_CMD_QUEUE - ((task->write_idx - task->read_idx) +
                                          TS_SIZE_OF_PER_TASK_CMD_QUEUE) % TS_SIZE_OF_PER_TASK_CMD_QUEUE;
    }

    COND_RETURN_CMODEL(qosMgmt->Credit <= 1U, DRV_ERROR_INNER_ERR, "cmd queue is full");

    const errno_t ret = memcpy_s(&task->task_command_slot[task->write_idx], sizeof(drvCommandStruct_t),
        &qos->taskCommand[qos->headIndex], sizeof(drvCommandStruct_t));
    COND_RETURN_CMODEL(ret != EOK, DRV_ERROR_INVALID_VALUE, "memcpy_s failed");

    qosMgmt->IsSubmit[qos->headIndex] = 0U;
    qosMgmt->IsOccupy[qos->headIndex] = 0U;
    task->write_idx = (task->write_idx + 1U) % TS_SIZE_OF_PER_TASK_CMD_QUEUE;
    qos->headIndex = (qos->headIndex + 1U) % DRV_QOS_QUEUE_SIZE;
    qosMgmt->Credit--;

    return DRV_ERROR_NONE;
}

drvError_t drvSetTaskCommand(int32_t device, int8_t qos, drvQosQueue_t *queue, drvQosMgmt_t *qMgmt)
{
    drvError_t ret = DRV_ERROR_NONE;
    int32_t deviceId;

    COND_RETURN_CMODEL((qos < 0) || ((uint8_t)qos >= TS_TASK_CMD_QUEUE_PRIORITIES_LEVEL), DRV_ERROR_INVALID_VALUE,
        "invalid qos %hhd", qos);

    deviceId = DEVICE_HANDLE_TO_ID(device);
    COND_RETURN_CMODEL((deviceId < 0) || (deviceId >= MAX_DEV_NUM), DRV_ERROR_INVALID_VALUE, "invalid device_id=%d",
        deviceId);

    COND_RETURN_CMODEL(IsQosEmpty(queue) == DRV_TRUE, DRV_ERROR_INNER_ERR, "queue is empty");
    COND_RETURN_CMODEL(qMgmt->IsSubmit[queue->headIndex] == 0, DRV_ERROR_NOT_EXIST, "none submit");

#ifndef __DRV_CFG_DEV_PLATFORM_ESL__
    ts_task_cmd_queue_t *taskCmd = NULL;
    ts_interrupt_num_t tsInter;

    taskCmd = ts_get_task_cmd_queues((uint8_t)qos);

    uint32_t submitCnt = 0;
    while (qMgmt->IsSubmit[queue->headIndex] == 1) {
        ret = drvSubmitCommand(taskCmd, queue, qMgmt);
        if (ret != DRV_ERROR_NONE) {
            break;
        }
        submitCnt++;
    }
    if (submitCnt > 0) {
        tsInter = TS_INTTRUPT_NUM_TASK_QUEUE;
        ts_trigger_interrupt(tsInter);
    }
#endif
    return ret;
}

drvError_t drvQueueInit(void)
{
    errno_t ret = memset_s(g_drvQosQueue, sizeof(g_drvQosQueue), 0, sizeof(g_drvQosQueue));
    COND_RETURN_CMODEL(ret != EOK, DRV_ERROR_INVALID_VALUE, "memset_s failed");

    ret = memset_s(g_drvQosQueueMgmt, sizeof(g_drvQosQueueMgmt), 0, sizeof(g_drvQosQueueMgmt));
    COND_RETURN_CMODEL(ret != EOK, DRV_ERROR_INVALID_VALUE, "memset_s failed");

    ret = memset_s(g_drvReportQueue, sizeof(g_drvReportQueue), 0, sizeof(g_drvReportQueue));
    COND_RETURN_CMODEL(ret != EOK, DRV_ERROR_INVALID_VALUE, "memset_s failed");

    int32_t i;
    for (i = 0; i < MAX_DEV_NUM; i++) {
        drvSemInit(&g_drvSem[i], 0);
    }
    pthread_mutex_init(&g_cq_report_mutex, NULL);
    return DRV_ERROR_NONE;
}

void drvReportIrqTriger(drvInterruptNum_t irq)
{
    int32_t deviceId;
    drvError_t ret;

    switch (irq) {
        case DRV_INTERRUPT_QOS_READY:
            break;
        case DRV_INTERRUPT_REPORT_READY:
            deviceId = 0;  // stub
            drvReportQueue_t *drvReport = &g_drvReportQueue[deviceId];
            while (drvReport->headIndex != (drvReport->tailIndex + 1) % DRV_REPORT_QUEUE_SIZE) {
                ret = drvMoveTsReport(deviceId);
                if (ret == DRV_ERROR_NONE) {
                    drvSemPost(&g_drvSem[deviceId]);
                } else {
                    break;
                }
            }
            break;
        default:
            break;
    }
}
