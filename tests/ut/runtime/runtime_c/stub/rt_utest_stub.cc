/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "stdio.h"
#include "hal_ts.h"

volatile int32_t mallocbuff[1024 * 1024] = {0};
drvError_t halMemAlloc(void **pp, UINT64 size, UINT64 flag)
{
    *pp = (void *)&mallocbuff[0];
    return DRV_ERROR_NONE;
}

drvError_t halMemFree(void *pp)
{
    if (pp == nullptr) {
        return DRV_ERROR_INVALID_VALUE;
    }
    return DRV_ERROR_NONE;
}

drvError_t halMemGetInfo(unsigned int type, struct MemInfo *info)
{
    return DRV_ERROR_NONE;
}

drvError_t halMemcpy(DVdeviceptr dst, size_t DestMax, DVdeviceptr src, size_t ByteCount, drvMemcpyKind_t kind)
{
    if (DestMax < ByteCount) {
        return DRV_ERROR_PARA_ERROR;
    }
    return DRV_ERROR_NONE;
}

drvError_t halMemset(DVdeviceptr dst, size_t destMax, UINT8 value, size_t N)
{
    if (destMax < N) {
        return DRV_ERROR_PARA_ERROR;
    }
    return DRV_ERROR_NONE;
}

int halTsInit(void)
{
    return DRV_ERROR_NONE;
}

int32_t halTsDeinit(void)
{
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
{
    if (value) {
        if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_VERSION) {
            *value = 0xffffffffffffffffLL;
        } else {
            *value = 0;
        }
    }
    return DRV_ERROR_NONE;
}

static int32_t sqId = 0;
drvError_t halSqCqAllocate(uint32_t devId, struct halSqCqInputInfo *in, struct halSqCqOutputInfo *out)
{
    if (sqId >= 4) {
        return DRV_ERROR_MALLOC_FAIL;
    }
    __sync_fetch_and_add(&sqId, 1);
    return DRV_ERROR_NONE;
}

drvError_t halSqCqFree(uint32_t devId, uint32_t sqid)
{
    __sync_fetch_and_sub(&sqId, 1);
    return DRV_ERROR_NONE;
}

drvError_t halModelExecWait(uint8_t devId, struct halMdlExecWaitInput *in, struct halMdlExecWaitOutput *out)
{
    if (in->waitPara.meid == 0xFF) {
        return DRV_ERROR_INVALID_VALUE;
    }
    return DRV_ERROR_NONE;
}

drvError_t halModelLoad(tsMdlDescInfo_t *mdlDescInfo, uint8_t *mdlID)
{
    if (mdlDescInfo->weight_prefetch_flag != 0) {
        return DRV_ERROR_INVALID_VALUE;
    }
    return DRV_ERROR_NONE;
}

drvError_t halModelExec(uint8_t devId, struct halMdlExecInput *in, struct halMdlExecOutput *out)
{
    if (in->execInfo.desc_info.cache_inv != 1) {
        return DRV_ERROR_INVALID_VALUE;
    }
    return DRV_ERROR_NONE;
}

drvError_t halModelDestroy(uint32_t mid)
{
    return DRV_ERROR_NONE;
}

drvError_t halDumpInit()
{
    return DRV_ERROR_NONE;
}

drvError_t halDumpDeinit()
{
    return DRV_ERROR_NONE;
}

drvError_t halMsgSend(uint32_t tId, uint32_t sendTid, int32_t timeout, void *sendInfo, uint32_t size)
{
    return DRV_ERROR_NONE;
}

drvError_t halGetTaskDesc(struct halGetTaskDescInput *in, struct halGetTaskDescOutput *out)
{
    return DRV_ERROR_NONE;
}

drvError_t halCbIrqWait(struct halCbIrqInput *in, struct halCbIrqOutput *out)
{
    out->rpt_num = 1;
    return DRV_ERROR_NONE;
}

drvError_t halSqSubscribeTid(uint8_t devId, uint8_t sqId, uint8_t type, int64_t tid)
{
    return DRV_ERROR_NONE;
}

drvError_t halSqUnSubscribeTid(uint8_t devId, uint8_t sqId, uint8_t type)
{
    return DRV_ERROR_NONE;
}

drvError_t halSqResume(uint8_t devId, int32_t sqid)
{
    return DRV_ERROR_NONE;
}

drvError_t halHostFuncWait(int32_t timeout, int64_t tid)
{
    return DRV_ERROR_NONE;
}
