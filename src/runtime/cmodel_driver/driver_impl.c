/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#if defined(MODEL_V200)
#include "model/v200/model_api.h"
#elif defined(MODEL_V210)
#include "model/v210/model_api.h"
#elif defined(MODEL_V310)
#include "../model/hwts/src/common_inc/model_api.h"
#else
#include "model/model_api.h"
#endif

#include "tsch/task_scheduler.h"
#include "driver_queue.h"
#include "driver_mem.h"
#include "driver_impl.h"

#include "../../../abl/mmpa/inc/mmpa/mmpa_api.h"

#define CHIP_NUM (1)
#define CMODEL_DRI_STARTED (0)
#define CMODEL_DRI_SUCC (1)
#define MAX_ENV_PATH_LEN (1024)

const uint32_t STUB_DEVICE_ID_CMODEL = 64;

#ifndef __DRV_CFG_DEV_PLATFORM_ESL__
typedef void(*DriverReportIrqTriger)(uint32_t);
extern void tsRegDrvReportIrqTriger(DriverReportIrqTriger irqTriger);
#endif

int8_t g_drvEventIdList[MAX_DEV_NUM][MAX_EVENT_NUM];
int8_t g_drvStreamIdList[MAX_DEV_NUM][MAX_STREAM_NUM];
int8_t g_drvTaskpoolIdList[MAX_DEV_NUM][MAX_TASK_NUM];
int8_t g_drvSqCqIdList[MAX_DEV_NUM][MAX_SQCQ_NUM];
int8_t g_drvEventStateList[2 * MAX_EVENT_NUM];

int32_t g_maxIds[DRV_RES_CNT] = { MAX_STREAM_NUM, MAX_EVENT_NUM, MAX_TASK_NUM, MAX_SQCQ_NUM };
int8_t *g_idLists[DRV_RES_CNT] = { (int8_t *)g_drvStreamIdList, (int8_t *)g_drvEventIdList,
                                   (int8_t *)g_drvTaskpoolIdList, (int8_t *)g_drvSqCqIdList };
drvError_t g_fullErrors[DRV_RES_CNT] = { DRV_ERROR_INNER_ERR, DRV_ERROR_INNER_ERR,
                                         DRV_ERROR_OUT_OF_MEMORY, DRV_ERROR_INNER_ERR };

drvError_t __drvIdAlloc(int32_t *id, uint32_t device, int resType)
{
    COND_RETURN_CMODEL(id == NULL, DRV_ERROR_INVALID_HANDLE, "id is NULL");
    uint32_t deviceId = DEVICE_HANDLE_TO_ID(device);
    COND_RETURN_CMODEL(deviceId >= MAX_DEV_NUM && deviceId != STUB_DEVICE_ID_CMODEL, DRV_ERROR_INVALID_DEVICE,
                       "invalid device %u", deviceId);
    int32_t maxId = g_maxIds[resType];
    int8_t *resList = g_idLists[resType] + ((uint32_t)maxId * device);

    int32_t i = 0;
    while (i < maxId) {
        if (resList[i] == 0) {
            break;
        } else {
            i++;
        }
    }
    COND_RETURN_CMODEL(i >= maxId, g_fullErrors[resType], "too much resource");

    resList[i] = 1;
    *id = i;
    return DRV_ERROR_NONE;
}

drvError_t __drvIdFree(int32_t id, uint32_t device, int resType)
{
    uint32_t deviceId = DEVICE_HANDLE_TO_ID(device);
    COND_RETURN_CMODEL(deviceId >= MAX_DEV_NUM, DRV_ERROR_INVALID_VALUE, "invalid device %u", deviceId);
    COND_RETURN_CMODEL((resType < 0) || (resType >= (int32_t)DRV_RES_CNT), DRV_ERROR_INVALID_VALUE,
                       "invalid resType %d", resType);

    int32_t maxId = g_maxIds[resType];
    int8_t *resList = g_idLists[resType] + ((uint32_t)maxId * device);

    COND_RETURN_CMODEL((id < 0) || (id >= maxId), DRV_ERROR_INVALID_VALUE, "invalid id %d", id);
    COND_RETURN_CMODEL(resList[id] == 0, DRV_ERROR_INVALID_VALUE, "id %d is not alloced", id);

    resList[id] = 0;

    return DRV_ERROR_NONE;
}

drvError_t drvEventIDListInit(void)
{
    errno_t ret = memset_s(g_drvEventIdList, sizeof(g_drvEventIdList), 0, sizeof(g_drvEventIdList));
    COND_RETURN_CMODEL(ret!= EOK, DRV_ERROR_OUT_OF_MEMORY, "memset_s return error %d", ret);
    ret = memset_s(g_drvEventStateList, sizeof(g_drvEventStateList), 0, sizeof(g_drvEventStateList));
    COND_RETURN_CMODEL(ret!= EOK, DRV_ERROR_OUT_OF_MEMORY, "memset_s return error %d", ret);
    return DRV_ERROR_NONE;
}

drvError_t drvStreamIDListInit(void)
{
    errno_t ret = memset_s(g_drvStreamIdList, sizeof(g_drvStreamIdList), 0, sizeof(g_drvStreamIdList));
    COND_RETURN_CMODEL(ret!= EOK, DRV_ERROR_OUT_OF_MEMORY, "memset_s return error %d", ret);
    return DRV_ERROR_NONE;
}

static drvError_t drvSqCqIDListInit(void)
{
    errno_t ret = memset_s(g_drvSqCqIdList, sizeof(g_drvSqCqIdList), 0, sizeof(g_drvSqCqIdList));
    COND_RETURN_CMODEL(ret != EOK, DRV_ERROR_OUT_OF_MEMORY, "memset_s return error %d", ret);
    return DRV_ERROR_NONE;
}

static drvError_t drvTaskpoolIDListInit(void)
{
    errno_t ret = memset_s(g_drvTaskpoolIdList, sizeof(g_drvTaskpoolIdList), 0, sizeof(g_drvTaskpoolIdList));
    COND_RETURN_CMODEL(ret!= EOK, DRV_ERROR_OUT_OF_MEMORY, "memset_s return error %d", ret);
    return DRV_ERROR_NONE;
}

static int drvInitCheck(int flag)
{
    static int count = 0;
    int value;
    value = __sync_lock_test_and_set(&count, flag);
    if (value > 0) {
        return CMODEL_DRI_STARTED;
    } else {
        return CMODEL_DRI_SUCC;
    }
}

drvError_t drvDriverStubInit(void)
{
    if (drvInitCheck(1) == CMODEL_DRI_SUCC) {
        (void)drvEventIDListInit();
        (void)drvStreamIDListInit();
        (void)drvTaskpoolIDListInit();
        (void)drvSqCqIDListInit();
        (void)drvQueueInit();
        (void)drvMemMgmtInit();
#ifndef __DRV_CFG_DEV_PLATFORM_ESL__
        // interface for decoupling,because tsch depends on runtime while st
        tsRegDrvReportIrqTriger(drvReportIrqTriger);
        char camodelLogPath[MAX_ENV_PATH_LEN] = { 0 };
        const char *camodelLogPathValue = NULL;
        MM_SYS_GET_ENV(MM_ENV_CAMODEL_LOG_PATH, camodelLogPathValue);
        if (camodelLogPathValue != NULL) {
            int ret = memcpy_s(camodelLogPath, MAX_ENV_PATH_LEN - 1, camodelLogPathValue,
                               strlen(camodelLogPathValue));
            if (ret != EOK) {
                return DRV_ERROR_INVALID_VALUE;
            }
        }
#ifdef PLATFORM_ADC_LITE
        startModel(camodelLogPath[0] != '\0' ? camodelLogPath : "./");
#else
        startModel(camodelLogPath[0] != '\0' ? camodelLogPath : "./", NULL, CHIP_NUM);
#endif

        start_task_scheduler();
#endif
    }
    return DRV_ERROR_NONE;
}

drvError_t drvDriverStubExit(void)
{
    if (drvInitCheck(0) == CMODEL_DRI_STARTED) {
        stop_task_scheduler();
        stopModel();
    }
    return DRV_ERROR_NONE;
}
