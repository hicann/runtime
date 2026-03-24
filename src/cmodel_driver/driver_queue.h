/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DRIVER_QUEUE_H
#define DRIVER_QUEUE_H

#include <semaphore.h>
#include "tsch/tsch_defines.h"
#include "cmodel_driver.h"

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/*
 * @ingroup driver-stub
 * @brief size of each QoS queue.
 */
#define DRV_QOS_QUEUE_SIZE (512)
/*
 * @ingroup driver-stub
 * @brief size of each QoS queue.
 */
#define DRV_REPORT_QUEUE_SIZE (64)
#define COMMAND_STRUCT_SIZE (64)
#define DRV_REPORT_STRUCT_SIZE (12)

/*
 * @ingroup driver-stub
 * @brief each command is 64 byte but we don't care the details.
 */
typedef struct tagDrvCommandStruct {
    uint8_t dummy[COMMAND_STRUCT_SIZE];
} drvCommandStruct_t;

/*
 * @ingroup driver-stub
 * @brief each reprot is 4 byte but we don't care the details.
 */
typedef struct tagDrvReportStruct {
    uint8_t dummy[DRV_REPORT_STRUCT_SIZE];
} drvReportStruct_t;

/*
 * @ingroup driver-stub
 * @brief driver qos queue.
 */
typedef struct tagDrvQosQueue {
    drvCommandStruct_t taskCommand[DRV_QOS_QUEUE_SIZE];
    uint16_t headIndex;
    uint16_t tailIndex;
} drvQosQueue_t;

/*
 * @ingroup driver-stub
 * @brief driver qos mgmt.
 */
typedef struct tagDrvQosMgmt {
    uint32_t IsSubmit[DRV_QOS_QUEUE_SIZE];
    uint32_t IsOccupy[DRV_QOS_QUEUE_SIZE];
    uint32_t Credit;
} drvQosMgmt_t;

/*
 * @ingroup driver-stub
 * @brief driver report queue.
 */
typedef struct tagDrvReportQueue {
    drvReportStruct_t retort[DRV_REPORT_QUEUE_SIZE];
    uint16_t headIndex;
    uint16_t tailIndex;
} drvReportQueue_t;
/*
 * @ingroup driver-stub
 * @brief bool type of driver.
 */
typedef enum drvBool {
    DRV_FALSE = 0,
    DRV_TRUE = 1,
} drvBool_t;

typedef sem_t drvSem_t;

extern drvQosQueue_t g_drvQosQueue[MAX_DEV_NUM][TS_TASK_CMD_QUEUE_PRIORITIES_LEVEL];
extern drvQosMgmt_t g_drvQosQueueMgmt[MAX_DEV_NUM][TS_TASK_CMD_QUEUE_PRIORITIES_LEVEL];
extern drvReportQueue_t g_drvReportQueue[MAX_DEV_NUM];
extern drvSem_t g_drvSem[MAX_DEV_NUM];

drvError_t drvQosHanddleToId(int32_t deviceId, int8_t *qos, int32_t *qid, const drvCommand_t * const cmd);
drvError_t drvSetTaskCommand(int32_t device, int8_t qos, drvQosQueue_t *queue, drvQosMgmt_t *qMgmt);
drvError_t drvQueueInit(void);
void drvReportIrqTriger(drvInterruptNum_t irq);
void drvSemWait(drvSem_t *sem);

#ifdef __cplusplus
}
#endif /* __cplusplus */

#endif /* DRIVER_QUEUE_H */
