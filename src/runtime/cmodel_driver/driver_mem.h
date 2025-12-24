/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DRIVER_MEM_H
#define DRIVER_MEM_H

#include "cmodel_driver.h"

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

#define RESERVED_MEM (8 * 1024 * 1024)
#define RESERVED_MEM_PA (0x6400000)
#define RESERVED_MEM_PA_REPORT (RESERVED_MEM_PA + (6 * 1024 * 1024))
#define HUGE_SIZE (2 * 1024 * 1024)
#define MEMSET_SIZE_MAX (SECUREC_MEM_MAX_LEN)

/*
 * @ingroup driver-stub
 * @brief stub.HMB base excursion address.
 */
#define HBM_BASE (0x10000000)

/*
 * @ingroup driver-stub
 * @brief stub.HMB tail excursion address.
 */
#if defined(MODEL_V200) || defined(MODEL_V210)
#define HBM_MAX_ADDR (0x30000000)
#else
#define HBM_MAX_ADDR (0x40000000)
#endif
/*
 * @ingroup driver-stub
 * @brief stub.the most size can be alloc.
 */
#define MAX_ALLOC (HBM_MAX_ADDR - HBM_BASE)

/*
 * @ingroup driver-stub
 * @brief hbm memory status that maintained by driver-stub.
 */
typedef enum tagDrvMemStatus {
    DRV_MEM_FREE = 0,
    DRV_MEM_BUSY,
} drvMemStatus_t;
/*
 * @ingroup driver-stub
 * @brief hbm memory block attribute that maintained by driver-stub.
 */
typedef struct tagDrvMemAttribute {
    uint64_t size;
    uint64_t address;
    drvMemStatus_t status;
} drvMemAttribute_t;
/*
 * @ingroup driver-stub
 * @brief hbm memory mgmt link that maintained by driver-stub.
 */
typedef struct tagDrvMemNode {
    drvMemAttribute_t drvMemMgmtData;
    struct tagDrvMemNode *prior;
    struct tagDrvMemNode *next;
} drvMemNode_t;

drvError_t drvMemMgmtInit(void);
drvError_t drvMemAlloc(void **dptr, uint64_t size, drvMemType_t type, int32_t nodeId);
drvError_t drvMemFree(const void *dptr, int32_t deviceId);
drvError_t drvModelMemcpy(void *dst, uint64_t destMax, const void *src, uint64_t size, drvMemcpyKind_t kind);
drvError_t drvModelMemset(uint64_t dst, size_t destMax, int32_t value, size_t size);

#ifdef __cplusplus
}
#endif /* __cplusplus */

#endif /* DRIVER_MEM_H */
