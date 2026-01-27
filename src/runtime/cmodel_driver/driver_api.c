/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "driver_queue.h"
#include "driver_mem.h"
#include "driver_impl.h"
#define RUN_MODE_ONLINE (1)
#define HANDLE_VALUE (2)
#define PAGE_SIZE_4K (0x1000)
#define STUB_TS_GRP_NUM 5

const int64_t PLATFORM_MINI_V1_CONFIG = 0x0;
const int64_t PLATFORM_MINI_V2_CONFIG = 0x10400;
const int64_t PLATFORM_CLOUD_V1_CONFIG = 0x100;
const int64_t PLATFORM_LHISI_ES_CONFIG = 0x10301;
const int64_t PLATFORM_LITE_CONFIG = 0xB0C00;
const int64_t PLATFORM_MC62CM12A_CONFIG = 0xE1000;

enum EventStatus {
    INIT,
    RECORDING,
    RECORDCOMPLETE,
};
typedef struct tagModelHostFuncCqReportMsg {
    volatile uint16_t phase      : 1;
    volatile uint16_t SOP        : 1;
    volatile uint16_t MOP        : 1;
    volatile uint16_t EOP        : 1;
    volatile uint16_t reserved : 12;
    volatile uint16_t streamId ;
    volatile uint16_t taskId;
    volatile uint16_t sqId;
    volatile uint16_t sqHead;
    volatile uint16_t sequenceId;
    volatile uint32_t reserved1;
    volatile uint64_t hostFuncCbPtr;
    volatile uint64_t fnDataPtr;
} modelHostFuncCqReportMsg_t;

typedef struct tagModelHostFuncSqSendMsg {
    uint16_t phase : 1;
    uint16_t SOP : 1;
    uint16_t MOP : 1;
    uint16_t EOP : 1;
    uint16_t reserved : 12;
    uint16_t streamId ;
    uint16_t taskId;
    uint16_t cqId;
    uint16_t cqTail;
    uint16_t sequenceId;
    uint32_t reserved1;
}modelHostFuncSqSendMsg_t;

struct tagModelHostFuncCqReportMsg g_ModelCqReport;
struct tagModelHostFuncSqSendMsg g_ModelSqSend;

drvError_t drvGetPlatformInfo(uint32_t *info)
{
    COND_RETURN_CMODEL(info == NULL, DRV_ERROR_INVALID_HANDLE, "info is NULL.");
    *info = RUN_MODE_ONLINE;
    return DRV_ERROR_NONE;
}

drvError_t drvGetDevNum(uint32_t *num_dev)
{
    COND_RETURN_CMODEL(num_dev == NULL, DRV_ERROR_INVALID_HANDLE, "num_dev is NULL.");
    *num_dev = MAX_DEV_NUM;
    return DRV_ERROR_NONE;
}

drvError_t drvGetDevIDs(uint32_t *devices, uint32_t len)
{
    UNUSED(len);
    COND_RETURN_CMODEL(devices == NULL, DRV_ERROR_INVALID_HANDLE, "devices is NULL");
    return DRV_ERROR_NONE;
}

drvError_t drvDeviceOpen(void **devInfo, uint32_t deviceId)
{
    UNUSED(devInfo);
    UNUSED(deviceId);
    (void)drvDriverStubInit();
    return DRV_ERROR_NONE;
}

drvError_t drvDeviceClose(uint32_t devId)
{
    UNUSED(devId);
#ifndef __DRV_CFG_DEV_PLATFORM_ESL__
    (void)drvDriverStubExit();
#endif
    return DRV_ERROR_NONE;
}

DVresult drvMemAddressTranslate(DVdeviceptr vptr, UINT64 *pptr)
{
    COND_RETURN_CMODEL(pptr == NULL, DRV_ERROR_INVALID_HANDLE, "pptr is NULL.");
    COND_RETURN_CMODEL(vptr == 0, DRV_ERROR_INVALID_VALUE, "vptr is 0");
    *pptr = vptr;
    return DRV_ERROR_NONE;
}

#define MEM_VIRT_MASK (((1U << MEM_VIRT_WIDTH) - 1) << MEM_VIRT_BIT)
drvError_t halMemAlloc(void **pp, UINT64 size, UINT64 flag)
{
    if ((flag & MEM_VIRT_MASK) == MEM_HOST) {
        COND_RETURN_CMODEL(pp == NULL, DRV_ERROR_INVALID_VALUE, "pp is NULL");
        COND_RETURN_CMODEL(size == 0, DRV_ERROR_INVALID_VALUE, "size is 0");
        *pp = malloc(size);
        COND_RETURN_CMODEL(*pp == NULL, DRV_ERROR_INVALID_HANDLE, "malloc failed");
        return DRV_ERROR_NONE;
    } else {
        return drvMemAlloc(pp, size, DRV_MEMORY_HBM, 0);
    }
}

drvError_t halMemFree(void *pp)
{
    return drvMemFree(pp, 0);
}

drvError_t halSqCqConfig(uint32_t devId, struct halSqCqConfigInfo *info)
{
    UNUSED(devId);
    UNUSED(info);
    return DRV_ERROR_NONE;
}

drvError_t halHostRegister(void *hostPtr, UINT64 size, UINT32 flag, UINT32 devid, void **devPtr)
{
    UNUSED(hostPtr);
    UNUSED(size);
    UNUSED(devid);
    UNUSED(flag);
    UNUSED(devPtr);
    return DRV_ERROR_NONE;
}

drvError_t halHostUnregister(void *hostPtr, UINT32 devid)
{
    UNUSED(hostPtr);
    UNUSED(devid);
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceSplitMode(unsigned int dev_id, unsigned int *mode)
{
    UNUSED(dev_id);
    UNUSED(mode);
    return DRV_ERROR_NONE;
}

drvError_t halResourceIdAlloc(uint32_t devId, struct halResourceIdInputInfo *in, struct halResourceIdOutputInfo *out)
{
    COND_RETURN_CMODEL(in == NULL, DRV_ERROR_INVALID_HANDLE, "halResourceIdInputInfo is NULL.");
    COND_RETURN_CMODEL(out == NULL, DRV_ERROR_INVALID_HANDLE, "halResourceIdOutputInfo is NULL.");
    drvError_t ret = DRV_ERROR_NONE;

    switch (in->type) {
        case DRV_STREAM_ID:
            ret = __drvIdAlloc((int32_t *)&(out->resourceId), devId, DRV_RES_STREAM);
            break;
        case DRV_EVENT_ID:
            ret = __drvIdAlloc((int32_t *)&(out->resourceId), devId, DRV_RES_EVENT);
            break;
        case DRV_MODEL_ID:
            out->resourceId = 1;
            break;
        case DRV_NOTIFY_ID:
            out->resourceId = 1;
            break;
        default:
            DRVSTUB_LOG("[ERROR] invalid type:%u", (uint32_t)in->type);
            ret = DRV_ERROR_INVALID_VALUE;
            break;
    }

    return ret;
}

drvError_t halResourceIdFree(uint32_t devId, struct halResourceIdInputInfo *in)
{
    COND_RETURN_CMODEL(in == NULL, DRV_ERROR_INVALID_HANDLE, "halResourceIdInputInfo is NULL.");
    drvError_t ret = DRV_ERROR_NONE;

    switch (in->type) {
        case DRV_STREAM_ID:
            ret = __drvIdFree((int32_t)in->resourceId, devId, DRV_RES_STREAM);
            break;
        case DRV_EVENT_ID:
            ret = __drvIdFree((int32_t)in->resourceId, devId, DRV_RES_EVENT);
            break;
        case DRV_MODEL_ID:
            UNUSED(devId);
            break;
        case DRV_NOTIFY_ID:
            UNUSED(devId);
            break;
        default:
            DRVSTUB_LOG("[ERROR] invalid type:%u", (uint32_t)in->type);
            ret = DRV_ERROR_INVALID_VALUE;
            break;
    }

    return ret;
}

drvError_t halSqMemGet(uint32_t devId, struct halSqMemGetInput *in, struct halSqMemGetOutput *out)
{
    COND_RETURN_CMODEL(in == NULL, DRV_ERROR_INVALID_HANDLE, "halSqMemGetInput is NULL.");
    COND_RETURN_CMODEL(out == NULL, DRV_ERROR_INVALID_HANDLE, "halSqMemGetOutput is NULL.");

    uint32_t deviceId;
    drvQosQueue_t *queue = NULL;
    drvQosMgmt_t *qMgmt = NULL;
    const int32_t qos = 0;
    drvError_t ret = DRV_ERROR_NONE;

    out->cmdCount = in->cmdCount;

    switch (in->type) {
        case DRV_CALLBACK_TYPE:
            UNUSED(devId);
            UNUSED(deviceId);
            UNUSED(queue);
            UNUSED(qMgmt);
            UNUSED(qos);
            out->cmdPtr = (void *)&g_ModelSqSend;
            break;
        case DRV_NORMAL_TYPE:
            deviceId = DEVICE_HANDLE_TO_ID(devId);
            COND_RETURN_CMODEL(deviceId >= MAX_DEV_NUM, DRV_ERROR_INVALID_VALUE, "invalid device %u", deviceId);

            queue = &(g_drvQosQueue[deviceId][qos]);
            qMgmt = &(g_drvQosQueueMgmt[deviceId][qos]);

            COND_RETURN_CMODEL(((queue->headIndex) == (queue->tailIndex + 1) % DRV_QOS_QUEUE_SIZE) ||
                               (qMgmt->IsOccupy[queue->tailIndex] == 1), DRV_ERROR_INNER_ERR, "queue is full");

            qMgmt->IsOccupy[queue->tailIndex] = 1;
            out->cmdPtr = (void **)&queue->taskCommand[queue->tailIndex];
            queue->tailIndex = (queue->tailIndex + 1) % DRV_QOS_QUEUE_SIZE;
            break;
        default:
            DRVSTUB_LOG("[ERROR] invalid type:%u", (uint32_t)in->type);
            ret = DRV_ERROR_INVALID_VALUE;
            break;
    }

    return ret;
}

drvError_t halSqMsgSend(uint32_t devId, struct halSqMsgInfo *info)
{
    COND_RETURN_CMODEL(info == NULL, DRV_ERROR_INVALID_HANDLE, "halSqMsgInfo is NULL.");

    drvError_t ret = DRV_ERROR_NONE;

    switch (info->type) {
        case DRV_CALLBACK_TYPE:
            UNUSED(devId);
            break;
        case DRV_NORMAL_TYPE:
            UNUSED(info);
            int32_t deviceId = (int32_t)devId;
            int8_t qos = 0;
            int32_t qid;
            drvQosQueue_t *queue = NULL;
            drvQosMgmt_t *qMgmt = NULL;

            COND_RETURN_CMODEL((deviceId < 0) || (deviceId >= MAX_DEV_NUM), DRV_ERROR_INVALID_VALUE,
                               "invalid device %d", deviceId);

            queue = &(g_drvQosQueue[deviceId][qos]);
            drvCommand_t command;
            command = (drvCommand_t)&queue->taskCommand[(queue->tailIndex + DRV_QOS_QUEUE_SIZE - 1) %
                DRV_QOS_QUEUE_SIZE];

            ret = drvQosHanddleToId(deviceId, &qos, &qid, command);
            COND_RETURN_CMODEL(ret != DRV_ERROR_NONE, ret, "drvQosHanddleToId failed");
            COND_RETURN_CMODEL(qid < 0, DRV_ERROR_INVALID_VALUE, "invalid qid %d", qid);

            qMgmt = &(g_drvQosQueueMgmt[deviceId][qos]);

            qMgmt->IsSubmit[qid] = 1;
            ret = drvSetTaskCommand(deviceId, qos, queue, qMgmt);
            break;
        default:
            DRVSTUB_LOG("[ERROR] invalid type:%u", (uint32_t)info->type);
            ret = DRV_ERROR_INVALID_VALUE;
            break;
    }

    return ret;
}

void drvDfxShowReport(uint32_t devId)
{
    UNUSED(devId);
    return ;
}

drvError_t drvDeviceGetTransWay(void *src, void *dst, uint8_t *trans_type)
{
    UNUSED(src);
    UNUSED(dst);
    COND_RETURN_CMODEL(trans_type == NULL, DRV_ERROR_INVALID_HANDLE, "trans_type is NULL.");
    *trans_type = 0;
    return DRV_ERROR_NONE;
}

DVresult drvMemPrefetchToDevice(DVdeviceptr devPtr, size_t len, DVdevice device)
{
    UNUSED(devPtr);
    UNUSED(len);
    UNUSED(device);
    return DRV_ERROR_NONE;
}

drvError_t drvCustomCall(uint32_t devId, uint32_t cmd, void *para)
{
    UNUSED(devId);
    UNUSED(cmd);
    UNUSED(para);
    return DRV_ERROR_NONE;
}

void drvFlushCache(uint64_t base, uint32_t len)
{
    UNUSED(base);
    UNUSED(len);
}

DVresult drvMemsetD8(DVdeviceptr dst, size_t destMax, UINT8 value, size_t size)
{
    DVresult ret;

    COND_RETURN_CMODEL(dst == 0, DRV_ERROR_INVALID_VALUE, "dst is NULL");
    COND_RETURN_CMODEL(size == 0, DRV_ERROR_INVALID_VALUE, "size is 0");
    COND_RETURN_CMODEL(size > destMax, DRV_ERROR_INVALID_VALUE, "size is bigger than destMax");
    ret = drvModelMemset(dst, destMax, (int32_t) value, size);
    COND_RETURN_CMODEL(ret != DRV_ERROR_NONE, DRV_ERROR_INVALID_HANDLE, "drvModelMemset failed, ret=%d", (int32_t)ret);

    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    UNUSED(devId);
    UNUSED(infoType);
    COND_RETURN_CMODEL(value == NULL, DRV_ERROR_INVALID_VALUE, "ptr is NULL.");

    if (moduleType == (int32_t)MODULE_TYPE_SYSTEM && infoType == (int32_t)INFO_TYPE_VERSION) {
#if defined(PLATFORM_MINI_V2)
        *value = PLATFORM_MINI_V2_CONFIG;
#elif defined(PLATFORM_CLOUD_V1)
        *value = PLATFORM_CLOUD_V1_CONFIG;
#elif defined(PLATFORM_LHISI_ES)
        *value = PLATFORM_LHISI_ES_CONFIG;
#elif defined(PLATFORM_ADC_LITE)
        *value = PLATFORM_LITE_CONFIG;
#elif defined(PLATFORM_MC62CM12A)
        *value = PLATFORM_MC62CM12A_CONFIG;
#else
        *value = PLATFORM_MINI_V1_CONFIG;
#endif
    } else if ((moduleType == (int32_t)MODULE_TYPE_SYSTEM) && (infoType == (int32_t)INFO_TYPE_CORE_NUM)) {
        *value = 1;
    } else {
#if defined(PLATFORM_CLOUD_V1)
        if (infoType == (int32_t)INFO_TYPE_CORE_NUM_LEVEL) {
            *value = 1;
        } else {
            *value = 0;
        }
#else
        *value = 0;
#endif
    }
    return DRV_ERROR_NONE;
}

DVresult drvMemGetAttribute(DVdeviceptr vptr, struct DVattribute *attr)
{
    COND_RETURN_CMODEL(attr == NULL, DRV_ERROR_INVALID_VALUE, "attr is NULL.");
    attr->devId = 0;
    if ((vptr >= HBM_BASE) && (vptr < HBM_MAX_ADDR)) {
        attr->memType = DV_MEM_LOCK_DEV;
    } else {
        attr->memType = DV_MEM_LOCK_HOST;
    }
    attr->pageSize = PAGE_SIZE_4K;

    return DRV_ERROR_NONE;
}

DVresult drvMemConvertAddr(DVdeviceptr pSrc, DVdeviceptr pDst, UINT32 len, struct DMA_ADDR *dmaAddr)
{
    COND_RETURN_CMODEL(dmaAddr == NULL, DRV_ERROR_INVALID_VALUE, "dmaAddr is NULL.");
    dmaAddr->phyAddr.src = (void *)((uintptr_t)pSrc);
    dmaAddr->phyAddr.dst = (void *)((uintptr_t)pDst);
    dmaAddr->phyAddr.len = len;
    dmaAddr->phyAddr.flag = 0;
    return DRV_ERROR_NONE;
}

drvError_t drvMemDestroyAddr(struct DMA_ADDR *ptr)
{
    UNUSED(ptr);
    return DRV_ERROR_NONE;
}

drvError_t halDeviceEnableP2P(uint32_t dev, uint32_t peer_dev, uint32_t flag)
{
    UNUSED(dev);
    UNUSED(peer_dev);
    UNUSED(flag);
    return DRV_ERROR_NONE;
}

drvError_t halDeviceDisableP2P(uint32_t devIdDes, uint32_t phyIdSrc, uint32_t flag)
{
    UNUSED(devIdDes);
    UNUSED(phyIdSrc);
    UNUSED(flag);
    return DRV_ERROR_NONE;
}

drvError_t halDeviceCanAccessPeer(int32_t *canAccessPeer, uint32_t device, uint32_t peerDevice)
{
    UNUSED(canAccessPeer);
    UNUSED(device);
    UNUSED(peerDevice);
    return DRV_ERROR_NONE;
}

int drvMemDeviceOpen(unsigned int devid, int devfd)
{
    UNUSED(devid);
    UNUSED(devfd);
    return (int32_t)DRV_ERROR_NONE;
}

int drvMemDeviceClose(unsigned int devid)
{
    UNUSED(devid);
    return (int32_t)DRV_ERROR_NONE;
}

drvError_t halSqCqAllocate(uint32_t devId, struct halSqCqInputInfo *in, struct halSqCqOutputInfo *out)
{
    COND_RETURN_CMODEL(in == NULL, DRV_ERROR_INVALID_HANDLE, "halSqCqInputInfo is NULL.");
    COND_RETURN_CMODEL(out == NULL, DRV_ERROR_INVALID_HANDLE, "halSqCqOutputInfo is NULL.");

    drvError_t ret = DRV_ERROR_NONE;
    int32_t sqcqId = 0;

    switch (in->type) {
        case DRV_CALLBACK_TYPE:
            ret = __drvIdAlloc(&sqcqId, devId, (int32_t)DRV_RES_SQCQ);
            break;
        case DRV_NORMAL_TYPE:
            UNUSED(devId);
            sqcqId = (int32_t)in->info[0];
            break;
        case DRV_LOGIC_TYPE:
            UNUSED(devId);
            ret = DRV_ERROR_INVALID_VALUE;
            break;
        case DRV_SHM_TYPE:
            UNUSED(devId);
            ret = DRV_ERROR_INVALID_VALUE;
            break;
        default:
            DRVSTUB_LOG("[ERROR] invalid type:%u", (uint32_t)in->type);
            ret = DRV_ERROR_INVALID_VALUE;
            break;
    }

    out->sqId = (uint32_t)sqcqId;
    out->cqId = (uint32_t)sqcqId;

    return ret;
}

drvError_t halSqCqFree(uint32_t devId, struct halSqCqFreeInfo *info)
{
    COND_RETURN_CMODEL(info == NULL, DRV_ERROR_INVALID_HANDLE, "halSqCqFreeInfo is NULL.");
    drvError_t ret = DRV_ERROR_NONE;

    switch (info->type) {
        case DRV_CALLBACK_TYPE:
            ret = __drvIdFree((int32_t)(info->sqId), devId, (int32_t)DRV_RES_SQCQ);
            break;
        case DRV_NORMAL_TYPE:
            UNUSED(devId);
            break;
        default:
            DRVSTUB_LOG("[ERROR] invalid type:%u", (uint32_t)info->type);
            ret = DRV_ERROR_INVALID_VALUE;
            break;
    }

    return ret;
}

drvError_t halCqReportIrqWait(uint32_t devId, struct halReportInfoInput *in, struct halReportInfoOutput *out)
{
    COND_RETURN_CMODEL(in == NULL, DRV_ERROR_INVALID_HANDLE, "halReportInfoInput is NULL.");
    COND_RETURN_CMODEL(out == NULL, DRV_ERROR_INVALID_HANDLE, "halReportInfoOutput is NULL.");

    drvError_t ret = DRV_ERROR_NONE;

    switch (in->type) {
        case DRV_CALLBACK_TYPE:
            UNUSED(devId);
            break;
        case DRV_NORMAL_TYPE:
            UNUSED(devId);
            UNUSED(in);
            UNUSED(out);
            break;
        default:
            DRVSTUB_LOG("[ERROR] invalid type:%u", (uint32_t)in->type);
            ret = DRV_ERROR_INVALID_VALUE;
            break;
    }

    return ret;
}

drvError_t halCqReportGet(uint32_t devId, struct halReportGetInput *in, struct halReportGetOutput *out)
{
    COND_RETURN_CMODEL(in == NULL, DRV_ERROR_INVALID_HANDLE, "halReportGetInput is NULL.");
    COND_RETURN_CMODEL(out == NULL, DRV_ERROR_INVALID_HANDLE, "halReportGetOutput is NULL.");

    drvError_t ret = DRV_ERROR_NONE;
    uint32_t deviceId;
    drvReportQueue_t *drvReportQueuePoint = NULL;

    switch (in->type) {
        case DRV_CALLBACK_TYPE:
            UNUSED(devId);
            UNUSED(deviceId);
            UNUSED(drvReportQueuePoint);

            out->count = 1;
            out->reportPtr = (void *)&g_ModelCqReport;
            break;
        case DRV_NORMAL_TYPE:

            out->count = 1;
            deviceId = devId;
            COND_RETURN_CMODEL(deviceId >= MAX_DEV_NUM, DRV_ERROR_INVALID_VALUE, "invalid device %u", deviceId);

            drvReportQueuePoint = &(g_drvReportQueue[deviceId]);

            drvSemWait(&g_drvSem[deviceId]);
            out->reportPtr = (void *)&(drvReportQueuePoint->retort[drvReportQueuePoint->headIndex]);
            drvReportQueuePoint->headIndex = (drvReportQueuePoint->headIndex + 1) % DRV_REPORT_QUEUE_SIZE;
            break;
        default:
            DRVSTUB_LOG("[ERROR] invalid type:%u", (uint32_t)in->type);
            ret = DRV_ERROR_INVALID_VALUE;
            break;
    }

    return ret;
}

drvError_t halReportRelease(uint32_t devId, struct halReportReleaseInfo* info)
{
    COND_RETURN_CMODEL(info == NULL, DRV_ERROR_INVALID_HANDLE, "halReportReleaseInfo is NULL.");

    drvError_t ret = DRV_ERROR_NONE;

    switch (info->type) {
        case DRV_CALLBACK_TYPE:
            UNUSED(devId);
            break;
        case DRV_NORMAL_TYPE:
            UNUSED(devId);
            break;
        default:
            DRVSTUB_LOG("[ERROR] invalid type:%u", (uint32_t)info->type);
            ret = DRV_ERROR_INVALID_VALUE;
            break;
    }
    return ret;
}

drvError_t halGetChipCapability(uint32_t deviceId, struct halCapabilityInfo *info)
{
    UNUSED(deviceId);
    COND_RETURN_CMODEL(info == NULL, DRV_ERROR_INVALID_VALUE, "info is NULL.");
    info->sdma_reduce_support = 1;
    info->ts_group_number = STUB_TS_GRP_NUM;
    return DRV_ERROR_NONE;
}

drvError_t halGetCapabilityGroupInfo(int deviceId, int ownerId,  int groupId, struct capability_group_info *groupInfo,
                                     int group_count)
{
    UNUSED(deviceId);
    UNUSED(ownerId);
    if ((groupId == -1 && group_count != STUB_TS_GRP_NUM) ||
        (groupId > -1 && group_count != 1) ||
        (groupId < -1)) {
        return DRV_ERROR_INVALID_VALUE;
    }
    if (groupId == -1) {
        uint32_t i;
        for (i = 0U; i < (uint32_t)group_count; i++) {
            groupInfo[i].group_id = i;
            groupInfo[i].state = i % 2;
            groupInfo[i].extend_attribute = 0;
            groupInfo[i].aicore_number = i;
            groupInfo[i].aivector_number = i;
            groupInfo[i].sdma_number = i;
            groupInfo[i].aicpu_number = i;
            groupInfo[i].active_sq_number = i;
        }
        groupInfo[1].extend_attribute = 1;
    } else {
            groupInfo->group_id = (uint32_t)groupId;
            groupInfo->state = 1;
            groupInfo->extend_attribute = 1;
            groupInfo->aicore_number = 1;
            groupInfo->aivector_number = 1;
            groupInfo->sdma_number = 1;
            groupInfo->aicpu_number = 1;
            groupInfo->active_sq_number = 1;
    }
    return DRV_ERROR_NONE;
}

DVresult drvMemcpy(DVdeviceptr dst, size_t destMax, DVdeviceptr src, size_t ByteCount)
{
    if ((src < HBM_BASE || src >= HBM_MAX_ADDR) && (dst < HBM_BASE || dst >= HBM_MAX_ADDR)) {
        return drvModelMemcpy((void *)((uintptr_t)dst), destMax, (void *)((uintptr_t) src),
                              ByteCount, DRV_MEMCPY_HOST_TO_HOST);
    }
    if ((src < HBM_BASE || src >= HBM_MAX_ADDR) && (dst >= HBM_BASE && dst < HBM_MAX_ADDR)) {
        return drvModelMemcpy((void *)((uintptr_t)dst), destMax, (void *)((uintptr_t) src),
                              ByteCount, DRV_MEMCPY_HOST_TO_DEVICE);
    }
    if ((src >= HBM_BASE && src < HBM_MAX_ADDR) && (dst < HBM_BASE || dst >= HBM_MAX_ADDR)) {
        return drvModelMemcpy((void *)((uintptr_t)dst), destMax, (void *)((uintptr_t) src),
                              ByteCount, DRV_MEMCPY_DEVICE_TO_HOST);
    }
    return drvModelMemcpy((void *)((uintptr_t)dst), destMax, (void *)((uintptr_t) src),
                          ByteCount, DRV_MEMCPY_DEVICE_TO_DEVICE);
}

drvError_t drvMemSmmuQuery(DVdevice device, UINT32 *SSID)
{
    UNUSED(device);
    UNUSED(SSID);
    return DRV_ERROR_NONE;
}

DVresult drvMemAllocL2buffAddr(DVdevice device, void **l2buff, UINT64 *pte)
{
    UNUSED(device);
    UNUSED(l2buff);
    UNUSED(pte);
    return DRV_ERROR_NONE;
}

drvError_t drvMemReleaseL2buffAddr(uint32_t device, void *l2buff)
{
    UNUSED(device);
    UNUSED(l2buff);
    return DRV_ERROR_NONE;
}

drvError_t halMemGetInfo(DVdevice device, unsigned int type, struct MemInfo *info)
{
    UNUSED(device);
    UNUSED(type);
    UNUSED(info);
    return DRV_ERROR_NONE;
}

drvError_t halMemCtl(int type, void *param_value, size_t param_value_size, void *out_value, size_t *out_size_ret)
{
    UNUSED(type);
    UNUSED(param_value);
    UNUSED(param_value_size);
    UNUSED(out_value);
    UNUSED(out_size_ret);
    return DRV_ERROR_NONE;
}

drvError_t drvGetP2PStatus(uint32_t dev, uint32_t peer_dev, uint32_t *status)
{
    UNUSED(dev);
    UNUSED(peer_dev);
    COND_RETURN_CMODEL(status == NULL, DRV_ERROR_INVALID_HANDLE, "ptr is NULL.");
    *status = 0;
    return DRV_ERROR_NONE;
}

DVresult halShmemCreateHandle(DVdeviceptr vptr, size_t byte_count, char *name, unsigned int name_len)
{
    UNUSED(vptr);
    UNUSED(byte_count);
    UNUSED(name);
    UNUSED(name_len);
    return DRV_ERROR_NONE;
}

DVresult halShmemOpenHandle(const char *name, DVdeviceptr *vptr)
{
    UNUSED(name);
    UNUSED(vptr);
    return DRV_ERROR_NONE;
}

DVresult halShmemOpenHandleByDevId(DVdevice devId, const char *name, DVdeviceptr *vptr)
{
    UNUSED(devId);
    UNUSED(name);
    UNUSED(vptr);
    return DRV_ERROR_NONE;
}

DVresult halShmemCloseHandle(DVdeviceptr vptr)
{
    UNUSED(vptr);
    return DRV_ERROR_NONE;
}

drvError_t halShmemDestroyHandle(const char *name)
{
    UNUSED(name);
    return DRV_ERROR_NONE;
}

drvError_t drvCreateIpcNotify(struct drvIpcNotifyInfo *info, char *name, unsigned int len)
{
    UNUSED(info);
    UNUSED(name);
    UNUSED(len);
    return DRV_ERROR_NONE;
}

drvError_t drvDestroyIpcNotify(const char *name, struct drvIpcNotifyInfo *info)
{
    UNUSED(info);
    UNUSED(name);
    return DRV_ERROR_NONE;
}

drvError_t drvCloseIpcNotify(const char *name, struct drvIpcNotifyInfo *info)
{
    UNUSED(info);
    UNUSED(name);
    return DRV_ERROR_NONE;
}

drvError_t drvSetIpcNotifyPid(const char *name, pid_t pid[], int num)
{
    UNUSED(name);
    UNUSED(pid);
    UNUSED(num);
    return DRV_ERROR_NONE;
}

drvError_t drvNotifyIdAddrOffset(uint32_t deviceId, struct drvNotifyInfo *drvInfo)
{
    UNUSED(deviceId);
    UNUSED(drvInfo);
    return DRV_ERROR_NONE;
}

drvError_t halShrIdOpen(const char *name, struct drvShrIdInfo *info)
{
    UNUSED(name);
    UNUSED(info);
    return DRV_ERROR_NONE;
}
drvError_t halShrIdClose(const char *name)
{
    UNUSED(name);
    return DRV_ERROR_NONE;
}

drvError_t halShmemSetPidHandle(const char *name, pid_t pid[], int num)

{
    UNUSED(name);
    UNUSED(pid);
    UNUSED(num);
    return DRV_ERROR_NONE;
}

drvError_t drvLoadProgram(uint32_t deviceId, void *program, unsigned int offset, size_t ByteCount, void **vPtr)
{
    UNUSED(deviceId);
    UNUSED(program);
    UNUSED(offset);
    UNUSED(ByteCount);
    UNUSED(vPtr);
    return DRV_ERROR_INVALID_MALLOC_TYPE;
}

drvError_t drvDeviceGetPhyIdByIndex(uint32_t devIndex, uint32_t *phyId)
{
    if (phyId != NULL) {
        *phyId = devIndex;
    }
    return DRV_ERROR_NONE;
}
drvError_t drvDeviceGetIndexByPhyId(uint32_t phyId, uint32_t *devIndex)
{
    if (devIndex != NULL) {
        *devIndex = phyId;
    }
    return DRV_ERROR_NONE;
}

int AICPUModelLoad(void *arg)
{
    UNUSED(arg);
    return (int32_t)DRV_ERROR_NONE;
}

int AICPUModelDestroy(uint32_t modelId)
{
    UNUSED(modelId);
    return (int32_t)DRV_ERROR_NONE;
}

int AICPUModelExecute(uint32_t modelId)
{
    UNUSED(modelId);
    return (int32_t)DRV_ERROR_NONE;
}

drvError_t drvMbindHbm(DVdeviceptr devPtr, size_t len, unsigned int type, uint32_t dev_id)
{
    UNUSED(devPtr);
    UNUSED(len);
    UNUSED(type);
    UNUSED(dev_id);
    return DRV_ERROR_NONE;
}

pid_t drvDeviceGetBareTgid(void)
{
    return 0;
}

drvError_t halGetPairDevicesInfo(uint32_t devId, uint32_t otherDevId, int32_t infoType, int64_t *value)
{
    UNUSED(devId);
    UNUSED(otherDevId);
    UNUSED(infoType);
    UNUSED(value);
    return DRV_ERROR_NONE;
}

drvError_t halCdqCreate(unsigned int devId, unsigned int tsId, struct halCdqPara *cdqPara,
    unsigned int *queId)
{
    UNUSED(devId);
    UNUSED(tsId);
    UNUSED(cdqPara);
    UNUSED(queId);
    return DRV_ERROR_NONE;
}

drvError_t halCdqDestroy(unsigned int devId, unsigned int tsId, unsigned int queId)
{
    UNUSED(devId);
    UNUSED(tsId);
    UNUSED(queId);
    return DRV_ERROR_NONE;
}

drvError_t halCdqAllocBatch(unsigned int devId, unsigned int tsId, unsigned int queId,
    unsigned int timeout, unsigned int *batchId)
{
    UNUSED(devId);
    UNUSED(tsId);
    UNUSED(queId);
    UNUSED(timeout);
    UNUSED(batchId);
    return DRV_ERROR_NONE;
}

drvError_t halGetChipFromDevice(int device_id, int *chip_id)
{
    UNUSED(device_id);
    UNUSED(chip_id);
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceFromChip(int chip_id, int device_list[], int count)
{
    UNUSED(chip_id);
    UNUSED(device_list);
    UNUSED(count);
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceCountFromChip(int chip_id, int *device_count)
{
    UNUSED(chip_id);
    UNUSED(device_count);
    return DRV_ERROR_NONE;
}

drvError_t halGetChipList(int chip_list[], int count)
{
    UNUSED(chip_list);
    UNUSED(count);
    return DRV_ERROR_NONE;
}

drvError_t halGetChipCount(int *chip_count)
{
    UNUSED(chip_count);
    return DRV_ERROR_NONE;
}


DVresult cmodelDrvMemcpy(DVdeviceptr dst, size_t destMax, DVdeviceptr src, size_t size, drvMemcpyKind_t kind)
{
    return drvModelMemcpy((void *)((uintptr_t)dst), destMax, (void *)((uintptr_t) src), size, kind);
}

drvError_t cmodelDrvFreeHost(void *pp)
{
    COND_RETURN_CMODEL(pp == NULL, DRV_ERROR_INVALID_VALUE, "pp is NULL.");
    free(pp);
    pp = NULL;
    return DRV_ERROR_NONE;
}

