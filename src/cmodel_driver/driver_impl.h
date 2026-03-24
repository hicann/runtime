/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __DRIVER_IMPL_H__
#define __DRIVER_IMPL_H__

#include "cmodel_driver.h"

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

#ifdef DAVINCI_LHISI
const uint32_t MAX_EVENT_NUM = 512;
const uint32_t MAX_STREAM_NUM = 64;
#else
/*
 * @ingroup driver-stub
 * @brief Pilling there are 1024 events served each device.
 */
#define MAX_EVENT_NUM (1024)

/*
 * @ingroup driver-stub
 * @brief Pilling there are 1024 streams served each device.
 */
#define MAX_STREAM_NUM (1024)
#endif

#ifdef DAVINCI_CLOUD
#define MAX_TASK_NUM (60000)
#else
#define MAX_TASK_NUM (32760)
#endif

#define MAX_SQCQ_NUM (1024)

typedef enum tagDrvResType {
    DRV_RES_STREAM,
    DRV_RES_EVENT,
    DRV_RES_TASKPOOL,
    DRV_RES_SQCQ,
    DRV_RES_CNT,
} tagDrvResType_t;

extern int8_t g_drvEventIdList[MAX_DEV_NUM][MAX_EVENT_NUM];
extern int8_t g_drvStreamIdList[MAX_DEV_NUM][MAX_STREAM_NUM];
extern int8_t g_drvTaskpoolIdList[MAX_DEV_NUM][MAX_TASK_NUM];
extern int8_t g_drvSqCqIdList[MAX_DEV_NUM][MAX_SQCQ_NUM];
extern int8_t g_drvEventStateList[2 * MAX_EVENT_NUM];

drvError_t __drvIdAlloc(int32_t *id, uint32_t device, int resType);
drvError_t __drvIdFree(int32_t id, uint32_t device, int resType);
drvError_t drvDriverStubInit(void);
drvError_t drvDriverStubExit(void);
#ifdef __cplusplus
}
#endif /* __cplusplus */

#endif /* __DRIVER_IMPL_H__ */
