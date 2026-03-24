/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "common.h"
#include "context.h"
#include "device.h"
#include "mem.h"
#include "error_manage.h"
#include "hal_ts.h"
#include "securec.h"
#include "ref_obj.h"
#include "rt_ctrl_model.h"

#if defined(__cplusplus)
extern "C" {
#endif

#define RT_MAX_DEV_NUM 1U

typedef struct TagRuntime {
    bool isHaveDevice;
    RefObj devices[RT_MAX_DEV_NUM];
} Runtime;

Runtime g_runTime;

static rtError_t GetMemInfoType(const rtMemInfoType_t memInfoType, uint32_t * const type)
{
    rtError_t error = ACL_RT_SUCCESS;
    switch (memInfoType) {
        case RT_MEMORYINFO_DDR:
        case RT_MEMORYINFO_DDR_HUGE:
        case RT_MEMORYINFO_DDR_NORMAL:
            *type = RT_MEM_INFO_TYPE_DDR_SIZE;
            break;
        case RT_MEMORYINFO_HBM:
        case RT_MEMORYINFO_HBM_HUGE:
        case RT_MEMORYINFO_HBM_NORMAL:
            *type = RT_MEM_INFO_TYPE_HBM_SIZE;
            break;
        case RT_MEMORYINFO_DDR_P2P_HUGE:
        case RT_MEMORYINFO_DDR_P2P_NORMAL:
            *type = RT_MEM_INFO_TYPE_DDR_P2P_SIZE;
            break;
        case RT_MEMORYINFO_HBM_P2P_HUGE:
        case RT_MEMORYINFO_HBM_P2P_NORMAL:
            *type = RT_MEM_INFO_TYPE_HBM_P2P_SIZE;
            break;
        default:
            error = ACL_ERROR_RT_INVALID_MEMORY_TYPE;
            break;
    }
    return error;
}

rtError_t rtMalloc(void **devPtr, uint64_t size, rtMemType_t type, const uint16_t moduleId)
{
    (void)moduleId;
    const uint32_t p2pTypeSet = RT_MEMORY_POLICY_HUGE_PAGE_FIRST_P2P | RT_MEMORY_POLICY_HUGE_PAGE_ONLY_P2P |
                                RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY_P2P;
    if ((type & p2pTypeSet) != 0U) {
        return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
    }
    const drvError_t error = halMemAlloc(devPtr, size, type);
    if (error != DRV_ERROR_NONE) {
        RT_LOG_ERROR("malloc memory failed, drvRet = %d.", (int32_t)error);
        return ErrorConvert(error);
    }
    return ACL_RT_SUCCESS;
}

rtError_t rtFree(void *devPtr)
{
    const drvError_t error = halMemFree(devPtr);
    if (error != DRV_ERROR_NONE) {
        RT_LOG_ERROR("free memory failed, drvRet = %d.", (int32_t)error);
        REPORT_INNER_ERROR(RT_DRV_INNER_ERROR, "free memory failed, drvRet = %d.", error);
        return ErrorConvert(error);
    }
    return ACL_RT_SUCCESS;
}

rtError_t rtMemset(void *devPtr, uint64_t destMax, uint32_t val, uint64_t cnt)
{
    drvError_t error = halMemset((DVdeviceptr)(uintptr_t)devPtr, destMax, (uint8_t)val, cnt);
    if (error != DRV_ERROR_NONE) {
        RT_LOG_ERROR("set memory failed, drvRet = %d", (int32_t)error);
        return ErrorConvert(error);
    }
    return ACL_RT_SUCCESS;
}

rtError_t rtMemGetInfoEx(rtMemInfoType_t memInfoType, size_t *freeSize, size_t *totalSize)
{
    uint32_t type = 0U;
    rtError_t ret = GetMemInfoType(memInfoType, &type);
    if (ret != ACL_RT_SUCCESS) {
        RT_LOG_ERROR("GetMemInfoType failed!");
        return ret;
    }
    struct MemInfo info;
    const drvError_t drvRet = halMemGetInfo(type, &info);
    if (drvRet != DRV_ERROR_NONE) {
        RT_LOG_ERROR("get memory info failed, drvRet = %d", (int32_t)(drvRet));
        return ErrorConvert(drvRet);
    }
    *freeSize = (size_t)(info.phy_info.free);
    *totalSize = (size_t)(info.phy_info.total);
    return ACL_RT_SUCCESS;
}

rtError_t rtMemcpy(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtMemcpyKind_t kind)
{
    drvError_t error = halMemcpy((DVdeviceptr)(uintptr_t)dst, destMax,
                                 (DVdeviceptr)(uintptr_t)src, cnt, (drvMemcpyKind_t)kind);
    if (error != DRV_ERROR_NONE) {
        RT_LOG_ERROR("halMemcpy failed, kind = %d, drvRet = %d", (int32_t)(kind), (int32_t)(error));
        return ErrorConvert(error);
    }
    return ACL_RT_SUCCESS;
}

rtError_t rtInit(void)
{
    memset_s(&g_runTime, sizeof(g_runTime), 0, sizeof(g_runTime));
    for (uint32_t i = 0U; i < RT_MAX_DEV_NUM; ++i) {
        InitRefObj(&(g_runTime.devices[i]));
    }
    InitCtxRecord();
    InitCtxMemPool();
    drvError_t halRet = (drvError_t)halTsInit();
    if (halRet != DRV_ERROR_NONE) {
        RT_LOG_ERROR("call halTsInit failed.");
        return ErrorConvert(halRet);
    }

    for (uint8_t i = 0U; i < MODEL_TYPE_MAX; i++) {
        rtError_t rtRet = InitCtrlMdl(i);
        if (rtRet != ACL_RT_SUCCESS) {
            rtDeinit();
            return rtRet;
        }
    }

    g_runTime.isHaveDevice = true;
    return ACL_RT_SUCCESS;
}

static void FreeRuntime()
{
    for (uint32_t i = 0U; i < RT_MAX_DEV_NUM; ++i) {
        while ((Device *)GetRefObjVal(&(g_runTime.devices[i])) != NULL) {
            (void)ReleaseDevice(i);
        }
    }

    memset_s(&g_runTime, sizeof(g_runTime), 0, sizeof(g_runTime));
    return;
}

void rtDeinit(void)
{
    DeInitCtrlMdl();
    FreeRuntime();
    DeInitCtxMemPool();
    DeinitCtxRecord();
    drvError_t halRet = (drvError_t)halTsDeinit();
    if (halRet != DRV_ERROR_NONE) {
        RT_LOG_ERROR("call halTsDeInit failed.");
    }
    return;
}

static bool HaveDevice(void)
{
    return g_runTime.isHaveDevice;
}

static void *CreateDeviceRef(RefObj *obj)
{
    uint32_t devId = obj - &(g_runTime.devices[0]);
    return CreateDevice(devId);
}

static void DestroyDeviceRef(RefObj *obj)
{
    FreeDevice((Device *)GetRefObjVal(obj));
    obj->obj = NULL;
}

Device *RetainDevice(const uint32_t devId)
{
    if (devId >= RT_MAX_DEV_NUM) {
        RT_LOG_ERROR("Device retain fail, devId=%d, valid range is [0,%u)", devId, RT_MAX_DEV_NUM);
        return NULL;
    }
    return GetObjRef(&(g_runTime.devices[devId]), CreateDeviceRef);
}

rtError_t ReleaseDevice(const uint32_t devId)
{
    if (devId >= RT_MAX_DEV_NUM) {
        RT_LOG_ERROR("Device release fail, devId=%u, valid range is [0,%u)", devId, RT_MAX_DEV_NUM);
        return ACL_ERROR_RT_INTERNAL_ERROR;
    }
    ReleaseObjRef(&(g_runTime.devices[devId]), DestroyDeviceRef);
    return RT_ERROR_NONE;
}

rtError_t rtSetDevice(int32_t devId)
{
    if (HaveDevice()) {
        if (RetainDevice((uint32_t)devId) == NULL) {
            RT_LOG_ERROR("Create or set device fail");
            return ACL_ERROR_RT_DEV_SETUP_ERROR;
        }
    }
    return RT_ERROR_NONE;
}

rtError_t rtDeviceReset(int32_t devId)
{
    return HaveDevice() ? ReleaseDevice((uint32_t)devId) : RT_ERROR_NONE;
}

rtError_t rtGetDevice(int32_t *devId)
{
    if (devId == NULL) {
        return ACL_ERROR_RT_INTERNAL_ERROR;
    }
    rtContext_t currentCtx;
    rtError_t err = rtCtxGetCurrent(&currentCtx);
    if (err != RT_ERROR_NONE) {
        return ACL_ERROR_RT_CONTEXT_NULL;
    }
    *devId = (int32_t)GetContextDeviceId((Context*)currentCtx);
    return RT_ERROR_NONE;
}

rtError_t rtGetRunMode(rtRunMode *runMode)
{
    if (runMode == NULL) {
        return ACL_ERROR_RT_INTERNAL_ERROR;
    }

    if (!HaveDevice()) {
        return RT_ERROR_NONE;
    }
    *runMode = RT_RUN_MODE_OFFLINE;
    return RT_ERROR_NONE;
}

#if defined(__cplusplus)
}
#endif
