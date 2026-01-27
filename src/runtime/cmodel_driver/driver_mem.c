/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <inttypes.h>

#ifdef MODEL_V200
#include "model/v200/model_api.h"
#elif MODEL_V310
#include "../model/hwts/src/common_inc/model_api.h"
#else
#include "model/model_api.h"
#endif
#include "driver_mem.h"

drvMemNode_t *g_drvMemMgmtHead[MAX_DEV_NUM];
drvMemNode_t *g_drvMemMgmtTail[MAX_DEV_NUM];

void drvResetMgmtHead(void);
void drvResetMgmtTail(void);

drvError_t drvMemMgmtQueueFree(int32_t deviceId)
{
    drvMemNode_t *drvMemFreeNode = NULL;
    drvMemNode_t *drvMemFreeFront = NULL;

    COND_RETURN_CMODEL((deviceId < 0) || (deviceId >= MAX_DEV_NUM), DRV_ERROR_INVALID_VALUE, "invalid device_id=%d",
        deviceId);

    if (g_drvMemMgmtHead[deviceId] != NULL) {
        drvMemFreeNode = g_drvMemMgmtHead[deviceId];
        while (drvMemFreeNode->next != NULL) {
            drvMemFreeNode = drvMemFreeNode->next;
        }
        drvMemFreeFront = drvMemFreeNode->prior;

        while ((drvMemFreeFront != NULL) && (drvMemFreeFront->prior != NULL)) {
            free(drvMemFreeNode);
            drvMemFreeNode = drvMemFreeFront;
            drvMemFreeFront = drvMemFreeNode->prior;
        }
        free(drvMemFreeNode);
        free(drvMemFreeFront);

        g_drvMemMgmtHead[deviceId] = NULL;
        g_drvMemMgmtTail[deviceId] = NULL;
    }

    return DRV_ERROR_NONE;
}

drvError_t drvMemMgmtInit(void)
{
    int32_t i;
    for (i = 0; i < MAX_DEV_NUM; i++) {
        if (g_drvMemMgmtHead[i] != NULL) {
            const drvError_t ret = drvMemMgmtQueueFree(i);
            COND_RETURN_CMODEL(ret != DRV_ERROR_NONE, ret, "drvMemMgmtQueueFree failed");
        }

        g_drvMemMgmtHead[i] = (drvMemNode_t *)malloc(sizeof(drvMemNode_t));
        g_drvMemMgmtTail[i] = (drvMemNode_t *)malloc(sizeof(drvMemNode_t));
        if ((g_drvMemMgmtHead[i] == NULL) || (g_drvMemMgmtTail[i] == NULL)) {
            drvResetMgmtHead();
            drvResetMgmtTail();
        }
        COND_RETURN_CMODEL(g_drvMemMgmtHead[i] == NULL, DRV_ERROR_INVALID_VALUE, "malloc failed");
        COND_RETURN_CMODEL(g_drvMemMgmtTail[i] == NULL, DRV_ERROR_INVALID_VALUE, "malloc failed");

        g_drvMemMgmtHead[i]->prior = NULL;
        g_drvMemMgmtHead[i]->next = g_drvMemMgmtTail[i];
        g_drvMemMgmtTail[i]->prior = g_drvMemMgmtHead[i];
        g_drvMemMgmtTail[i]->next = NULL;

        g_drvMemMgmtTail[i]->drvMemMgmtData.address = 0;
        g_drvMemMgmtTail[i]->drvMemMgmtData.size = MAX_ALLOC;
        g_drvMemMgmtTail[i]->drvMemMgmtData.status = DRV_MEM_FREE;
    }
    return DRV_ERROR_NONE;
}

void drvResetMgmtHead(void)
{
    int32_t index;
    for (index = 0; index < MAX_DEV_NUM; index++) {
        if (g_drvMemMgmtHead[index] != NULL) {
            free(g_drvMemMgmtHead[index]);
            DRVSTUB_LOG("memory is free");
            g_drvMemMgmtHead[index] = NULL;
            DRVSTUB_LOG("drvResetMgmtHead set");
        }
    }
}

void drvResetMgmtTail(void)
{
    int32_t index;
    for (index = 0; index < MAX_DEV_NUM; index++) {
        if (g_drvMemMgmtTail[index] != NULL) {
            free(g_drvMemMgmtTail[index]);
            DRVSTUB_LOG("memory is free");
            g_drvMemMgmtTail[index] = NULL;
            DRVSTUB_LOG("drvResetMgmtTail set");
        }
    }
}

drvError_t drvMemAllocDeviceHBM(void **dptr, uint64_t requestSize, int32_t deviceId)
{
    uint8_t fitFlag = 0;
    drvMemNode_t *drvNewMemNode = NULL;
    drvMemNode_t *drvNewMemMgmt = NULL;

    COND_RETURN_CMODEL(dptr == NULL, DRV_ERROR_INVALID_HANDLE, "dptr is NULL");
    COND_RETURN_CMODEL((deviceId < 0) || (deviceId >= MAX_DEV_NUM), DRV_ERROR_INVALID_VALUE, "invalid device_id=%d",
        deviceId);
    COND_RETURN_CMODEL(requestSize > MAX_ALLOC, DRV_ERROR_INVALID_VALUE, "too large requestSize=%" PRIu64, requestSize);

#ifdef __LIBFUZZER_HBM_ASAN__
    posix_memalign(dptr, 512, requestSize); // 512:alignment
    if (*dptr == NULL) {
        return DRV_ERROR_OUT_OF_MEMORY;
    }
#else
    drvNewMemMgmt = g_drvMemMgmtHead[deviceId]->next;

    while (fitFlag == 0) {
        uintptr_t tempt = 0;
        if ((drvNewMemMgmt->drvMemMgmtData.status == DRV_MEM_FREE) &&
            (drvNewMemMgmt->drvMemMgmtData.size == requestSize)) {
            drvNewMemMgmt->drvMemMgmtData.status = DRV_MEM_BUSY;
            tempt = (uintptr_t)(drvNewMemMgmt->drvMemMgmtData.address + HBM_BASE);
            *dptr = (void *)(tempt);
            fitFlag = 1;
        } else if ((drvNewMemMgmt->drvMemMgmtData.status == DRV_MEM_FREE) &&
                   (drvNewMemMgmt->drvMemMgmtData.size > requestSize)) {
            drvNewMemNode = (drvMemNode_t *)malloc(sizeof(drvMemNode_t));
            COND_RETURN_CMODEL(drvNewMemNode == NULL, DRV_ERROR_OUT_OF_MEMORY, "malloc failed");

            errno_t rc = EOK;
            rc = memset_s(drvNewMemNode, sizeof(drvMemNode_t), 0, sizeof(drvMemNode_t));
            if (rc != EOK) {
                DRVSTUB_LOG("memset_s failed");
            }
            drvNewMemNode->drvMemMgmtData.size = requestSize;
            drvNewMemNode->drvMemMgmtData.status = DRV_MEM_BUSY;

            drvNewMemNode->prior = drvNewMemMgmt->prior;
            drvNewMemNode->next = drvNewMemMgmt;
            drvNewMemNode->drvMemMgmtData.address = drvNewMemMgmt->drvMemMgmtData.address;

            drvNewMemMgmt->prior->next = drvNewMemNode;
            drvNewMemMgmt->prior = drvNewMemNode;
            drvNewMemMgmt->drvMemMgmtData.address = drvNewMemNode->drvMemMgmtData.address +
                drvNewMemNode->drvMemMgmtData.size;
            drvNewMemMgmt->drvMemMgmtData.size -= requestSize;

            tempt = (uintptr_t)(drvNewMemNode->drvMemMgmtData.address + HBM_BASE);
            *dptr = (void *)(tempt);
            fitFlag = 1;
        }

        if ((drvNewMemMgmt->next != NULL) && (fitFlag == 0)) {
            drvNewMemMgmt = drvNewMemMgmt->next;
        } else {
            break;
        }
    }

    COND_RETURN_CMODEL(fitFlag == 0, DRV_ERROR_OUT_OF_MEMORY, "out of memory");
#endif
    return DRV_ERROR_NONE;
}

drvError_t drvMergeDeviceHBM(drvMemNode_t *drvNewMemMgmt, int32_t deviceId)
{
    drvMemNode_t *drvMemFreeNode = NULL;
    COND_RETURN_CMODEL(drvNewMemMgmt == NULL, DRV_ERROR_INVALID_HANDLE, "drvNewMemMgmt is NULL");
    COND_RETURN_CMODEL(drvNewMemMgmt->drvMemMgmtData.status != DRV_MEM_FREE, DRV_ERROR_INVALID_HANDLE,
        "status is not free");
    COND_RETURN_CMODEL((deviceId < 0) || (deviceId >= MAX_DEV_NUM), DRV_ERROR_INVALID_VALUE, "invalid device_id=%d",
        deviceId);

    if ((drvNewMemMgmt->prior != g_drvMemMgmtHead[deviceId]) &&
        (drvNewMemMgmt->prior->drvMemMgmtData.status == DRV_MEM_FREE)) {
        drvMemFreeNode = drvNewMemMgmt->prior;
        drvNewMemMgmt->drvMemMgmtData.size += drvNewMemMgmt->prior->drvMemMgmtData.size;
        drvNewMemMgmt->drvMemMgmtData.address = drvNewMemMgmt->prior->drvMemMgmtData.address;
        drvNewMemMgmt->prior = drvNewMemMgmt->prior->prior;
        drvNewMemMgmt->prior->next = drvNewMemMgmt;
        free(drvMemFreeNode);
    }
    if ((drvNewMemMgmt != g_drvMemMgmtTail[deviceId]) && (drvNewMemMgmt->next != g_drvMemMgmtTail[deviceId]) &&
        (drvNewMemMgmt->next->drvMemMgmtData.status == DRV_MEM_FREE)) {
        drvMemFreeNode = drvNewMemMgmt->next;
        drvNewMemMgmt->drvMemMgmtData.size += drvNewMemMgmt->next->drvMemMgmtData.size;
        drvNewMemMgmt->next->next->prior = drvNewMemMgmt;
        drvNewMemMgmt->next = drvNewMemMgmt->next->next;
        free(drvMemFreeNode);
    }
    if ((drvNewMemMgmt->next == g_drvMemMgmtTail[deviceId]) &&
        (drvNewMemMgmt->next->drvMemMgmtData.status == DRV_MEM_FREE)) {
        drvNewMemMgmt->next->drvMemMgmtData.size += drvNewMemMgmt->drvMemMgmtData.size;
        drvNewMemMgmt->next->drvMemMgmtData.address = drvNewMemMgmt->drvMemMgmtData.address;
        drvNewMemMgmt->next->prior = drvNewMemMgmt->prior;
        drvNewMemMgmt->prior->next = drvNewMemMgmt->next;
        free(drvNewMemMgmt);
    }

    return DRV_ERROR_NONE;
}

drvError_t drvFreeDeviceHBM(const void *dptr, int32_t deviceId)
{
#ifdef __LIBFUZZER_HBM_ASAN__
    free(dptr);
#else
    uint8_t fitFlag = 0;
    drvError_t error;
    drvMemNode_t *drvNewMemMgmt = NULL;

    COND_RETURN_CMODEL(dptr == NULL, DRV_ERROR_INVALID_HANDLE, "dptr is NULL");
    COND_RETURN_CMODEL((uint64_t)((uintptr_t)dptr) < HBM_BASE || (uint64_t)((uintptr_t) dptr) >= HBM_MAX_ADDR,
        DRV_ERROR_INVALID_HANDLE, "invalid dptr");
    COND_RETURN_CMODEL((deviceId < 0) || (deviceId >= MAX_DEV_NUM), DRV_ERROR_INVALID_VALUE, "invalid device_id=%d",
        deviceId);
    COND_RETURN_CMODEL(g_drvMemMgmtHead[deviceId] == NULL, DRV_ERROR_INVALID_HANDLE, "invalid device_id=%d",
        deviceId);

    drvNewMemMgmt = g_drvMemMgmtHead[deviceId]->next;

    while (drvNewMemMgmt != NULL) {
        if (dptr == (void *)((uintptr_t)(drvNewMemMgmt->drvMemMgmtData.address + HBM_BASE))) {
            fitFlag = 1;
            break;
        }
        drvNewMemMgmt = drvNewMemMgmt->next;
    }

    COND_RETURN_CMODEL((fitFlag == 0) || (drvNewMemMgmt == NULL), DRV_ERROR_INVALID_HANDLE,
        "memory block is not found");
    drvNewMemMgmt->drvMemMgmtData.status = DRV_MEM_FREE;

    error = drvMergeDeviceHBM(drvNewMemMgmt, deviceId);
    COND_RETURN_CMODEL(error != DRV_ERROR_NONE, error, "drvMergeDeviceHBM failed");
#endif
    return DRV_ERROR_NONE;
}

drvError_t drvMemAlloc(void **dptr, uint64_t size, drvMemType_t type, int32_t nodeId)
{
    int32_t deviceId;
    drvError_t ret = DRV_ERROR_RESERVED;
    COND_RETURN_CMODEL(dptr == NULL, DRV_ERROR_INVALID_HANDLE, "dptr is NULL");
    COND_RETURN_CMODEL(size > MAX_ALLOC, DRV_ERROR_OUT_OF_MEMORY, "too large size=%" PRIu64, size);
    COND_RETURN_CMODEL(size == 0, DRV_ERROR_INVALID_VALUE, "size is 0");

    uint64_t tSize = size;
#ifndef __LIBFUZZER_HBM_ASAN__
    // size need align to 512 byte.
    if ((tSize & 0x1ff) != 0) {
        tSize = ((tSize >> 9) + 1) << 9; // 9 : 2^9,512 alignment
    }
#endif

    deviceId = DEVICE_TO_NODE(nodeId);
    COND_RETURN_CMODEL((deviceId < 0) || (deviceId >= MAX_DEV_NUM), DRV_ERROR_INVALID_VALUE, "invalid device_id=%d",
        deviceId);

    switch (type) {
        case DRV_MEMORY_HBM:
            ret = drvMemAllocDeviceHBM(dptr, tSize, deviceId);
            break;
        case DRV_MEMORY_DDR:
            return DRV_ERROR_INVALID_MALLOC_TYPE;
        default:
            return DRV_ERROR_INVALID_MALLOC_TYPE;
    }

    COND_RETURN_CMODEL(ret != DRV_ERROR_NONE, ret, "drvMemAllocDeviceHBM failed");

    return DRV_ERROR_NONE;
}

drvError_t drvMemFree(const void *dptr, int32_t deviceId)
{
    drvError_t ret;

    COND_RETURN_CMODEL(dptr == NULL, DRV_ERROR_INVALID_HANDLE, "dptr is NULL");
    COND_RETURN_CMODEL((deviceId < 0) || (deviceId >= MAX_DEV_NUM), DRV_ERROR_INVALID_VALUE, "invalid device_id=%d",
        deviceId);

    ret = drvFreeDeviceHBM(dptr, deviceId);
    COND_RETURN_CMODEL(ret != DRV_ERROR_NONE, ret, "drvFreeDeviceHBM failed");

    return DRV_ERROR_NONE;
}

drvError_t drvModelMemcpy(void *dst, uint64_t destMax, const void *src, uint64_t size, drvMemcpyKind_t kind)
{
    modelRWStatus_t ret = MODEL_RW_ERROR_NONE;

    COND_RETURN_CMODEL(dst == NULL, DRV_ERROR_INVALID_HANDLE, "dst is NULL");
    COND_RETURN_CMODEL(src == NULL, DRV_ERROR_INVALID_HANDLE, "src is NULL");
    COND_RETURN_CMODEL(size > MAX_ALLOC, DRV_ERROR_INVALID_VALUE, "too large size=%" PRIu64, size);
    COND_RETURN_CMODEL(destMax < size, DRV_ERROR_INVALID_VALUE, "size is larger than destMax");

    switch (kind) {
#ifndef __DRV_CFG_DEV_PLATFORM_ESL__
        case DRV_MEMCPY_HOST_TO_DEVICE: {
            uint64_t address = (uint64_t)((uintptr_t)dst);
            ret = busDirectWrite(address, size, (void *)src, 0);
            COND_RETURN_CMODEL(ret != MODEL_RW_ERROR_NONE, DRV_ERROR_INVALID_HANDLE, "error address %" PRIx64, address);
            break;
        }
        case DRV_MEMCPY_DEVICE_TO_HOST: {
            uint64_t address = (uint64_t)((uintptr_t)src);
            ret = busDirectRead(dst, size, address, 0);
            COND_RETURN_CMODEL(ret != MODEL_RW_ERROR_NONE, DRV_ERROR_INVALID_HANDLE, "error address %" PRIx64, address);
            break;
        }
#endif
        case DRV_MEMCPY_HOST_TO_HOST: {
            int retVal = memcpy_s(dst, destMax, src, size);
            COND_RETURN_CMODEL(retVal != 0, DRV_ERROR_INVALID_VALUE, "memcpy_s failed");
            ret = MODEL_RW_ERROR_NONE;
            break;
        }
        default:
            ret = MODEL_RW_ERROR_LEN;
            break;
    }
    if (ret == MODEL_RW_ERROR_NONE) {
        return DRV_ERROR_NONE;
    } else {
        return DRV_ERROR_INVALID_VALUE;
    }
}

drvError_t drvModelMemset(uint64_t dst, size_t destMax, int32_t value, size_t size)
{
    uint64_t tDst = dst;
    size_t tDestMax = destMax;
    size_t tSize = size;
    if (tDestMax < tSize) {
        return DRV_ERROR_INVALID_VALUE;
    }
    if ((tDst >= HBM_BASE) && (tDst < HBM_MAX_ADDR)) {
        modelRWStatus_t ret = MODEL_RW_ERROR_NONE;
        while ((tSize > 0) && (ret == MODEL_RW_ERROR_NONE)) {
#ifndef __DRV_CFG_DEV_PLATFORM_ESL__
            ret = busDirectWrite(tDst, 1, &value, 0);
#endif
            tDst++;
            tSize--;
        }
        return (ret == MODEL_RW_ERROR_NONE) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_HANDLE;
    }
    errno_t memRet = EOK;
    while ((tSize > 0U) && (memRet == EOK)) {
        if (tSize <= MEMSET_SIZE_MAX) {
            memRet = memset_s((void *)((uintptr_t) tDst), tDestMax, value, tSize);
            tSize = 0;
        } else {
            memRet = memset_s((void *)((uintptr_t) tDst), tDestMax, value, MEMSET_SIZE_MAX);
            tDst += MEMSET_SIZE_MAX;
            tSize -= MEMSET_SIZE_MAX;
            tDestMax -= MEMSET_SIZE_MAX;
        }
    }
    return (memRet == EOK) ? DRV_ERROR_NONE : DRV_ERROR_INVALID_HANDLE;
}
