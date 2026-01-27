/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <map>
#include <set>
#include <vector>
#include "dump_common.h"
#include "securec.h"
#include "runtime/rt.h"
#include "runtime/mem.h"
#include "rts/rts_device.h"
#include "rts/rts_stream.h"
#include "rts/rts_kernel.h"

static constexpr rtError_t RT_ERROR_STUB_FAILURE = -1;
static constexpr uint32_t LOCAL_DEV_NUM = 8;
static std::vector<rtDeviceStateCallback> g_deviceCallBackList;

rtError_t rtGetDevice(int32_t *devId)
{
    if (devId == nullptr) {
        return RT_ERROR_STUB_FAILURE;
    }
    *devId = 0;
    return RT_ERROR_NONE;
}

rtError_t rtGetTaskIdAndStreamID(uint32_t *taskId, uint32_t *streamId)
{
    if (taskId == nullptr || streamId == nullptr) {
        return RT_ERROR_STUB_FAILURE;
    }
    *taskId = 0;
    *streamId = 0;
    return RT_ERROR_NONE;
}

rtError_t rtMalloc(void **devPtr, uint64_t size, rtMemType_t type, const uint16_t moduleId)
{
    (void)type;
    (void)moduleId;
    if (devPtr == nullptr || size == 0) {
        return RT_ERROR_STUB_FAILURE;
    }

    *devPtr = malloc(size);
    return *devPtr != nullptr ? RT_ERROR_NONE : RT_ERROR_STUB_FAILURE;
    ;
}

rtError_t rtRegDeviceStateCallbackEx(const char_t *regName, rtDeviceStateCallback callback,
    const rtDevCallBackDir_t notifyPos)
{
    (void)notifyPos;
    g_deviceCallBackList.push_back(callback);
    return RT_ERROR_NONE;
}

rtError_t rtStreamCreateWithFlags(rtStream_t *stm, int32_t priority, uint32_t flags)
{
    (void)stm;
    (void)priority;
    (void)flags;
    return RT_ERROR_NONE;
}

rtError_t rtAicpuKernelLaunchExWithArgs(const uint32_t kernelType, const char_t * const opName,
    const uint32_t blockDim, const rtAicpuArgsEx_t *argsInfo, rtSmDesc_t * const smDesc,
    const rtStream_t stm, const uint32_t flags)
{
    (void)kernelType;
    (void)opName;
    (void)blockDim;
    (void)argsInfo;
    (void)smDesc;
    (void)stm;
    (void)flags;
    return RT_ERROR_NONE;
}

rtError_t rtStreamGetSqid(const rtStream_t stream, uint32_t *sqId)
{
    (void)stream;
    *sqId = 100;
    return RT_ERROR_NONE;
}

rtError_t rtStreamGetCqid(const rtStream_t stm, uint32_t *cqId, uint32_t *logicCqId)
{
    (void)stm;
    *cqId = 100;
    *logicCqId = 100;
    return RT_ERROR_NONE;
}

rtError_t rtBinaryLoad(const rtDevBinary_t *bin, rtBinHandle *binHandle)
{
    (void)bin;
    (void)binHandle;
    return RT_ERROR_NONE;
}

rtError_t rtGetAddrByFun(const void *stubFunc, void **addr)
{
    (void)stubFunc;
    *addr = (void*)0x5f;
    return RT_ERROR_NONE;
}

static std::set<const void *> g_stubFuncSet;

rtError_t rtFunctionRegister(void *binHandle, const void *stubFunc, const char_t *stubName, const void *kernelInfoExt,
    uint32_t funcMode)
{
    (void)binHandle;
    (void)stubName;
    (void)kernelInfoExt;
    (void)funcMode;
    if (g_stubFuncSet.find(stubFunc) != g_stubFuncSet.end()) {
        return 1;
    }
    g_stubFuncSet.insert(stubFunc);
    return RT_ERROR_NONE;
}

void UnRegisterRtFunction()
{
    g_stubFuncSet.clear();
}

rtError_t rtStreamDestroy(rtStream_t stream)
{
    (void)stream;
    return RT_ERROR_NONE;
}

rtError_t rtBinaryUnLoad(rtBinHandle binHandle)
{
  (void)binHandle;
  return RT_ERROR_NONE;
}

rtError_t rtGetStreamId(rtStream_t stream, int32_t *streamId)
{
    *streamId = 10;
    return RT_ERROR_NONE;
}

rtError_t rtGetSocVersion(char *version, const uint32_t maxLen)
{

    const char* lltSocVersion = std::getenv("ADX_LLT_SOC_VERSION");
    if (lltSocVersion != nullptr && strlen(lltSocVersion) > 0) {
        memcpy(version, lltSocVersion, strlen(lltSocVersion) + 1);
    } else {
        const char *socVersion = "Ascend910B1";
        memcpy(version, socVersion, strlen(socVersion) + 1);
    }
    return RT_ERROR_NONE;
}

rtError_t rtSetDevice(int32_t device)
{
    for (const auto &callback : g_deviceCallBackList) {
        callback(device, true);
    }
    return RT_ERROR_NONE;
}

rtError_t rtDeviceReset(int32_t device)
{
    for (const auto &callback : g_deviceCallBackList) {
        callback(device, false);
    }
    return RT_ERROR_NONE;
}

rtError_t rtDevBinaryRegister(const rtDevBinary_t *bin, rtBinHandle *binHandle)
{
    (void)bin;
    *binHandle = (rtBinHandle)0x5f;
    return RT_ERROR_NONE;
}

rtError_t rtFree(void *devPtr)
{
    if (devPtr == nullptr) {
        return RT_ERROR_NONE;
    }
    free(devPtr);
    return RT_ERROR_NONE;
}

rtError_t rtMallocHost(void **hostPtr, uint64_t size, const uint16_t moduleId)
{
    (void)moduleId;
    if (hostPtr == nullptr || size == 0) {
        return RT_ERROR_STUB_FAILURE;
    }

    *hostPtr = malloc(size);
    return *hostPtr != nullptr ? RT_ERROR_NONE : RT_ERROR_STUB_FAILURE;
}

rtError_t rtFreeHost(void *hostPtr)
{
    if (hostPtr == nullptr) {
        return RT_ERROR_NONE;
    }
    free(hostPtr);
    return RT_ERROR_NONE;
}

rtError_t rtMemcpy(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtMemcpyKind_t kind)
{
    (void)destMax;
    (void)kind;
    if (dst == nullptr || src == nullptr) {
        return RT_ERROR_STUB_FAILURE;
    }
    memcpy(dst, src, cnt);
    return RT_ERROR_NONE;
}

rtError_t rtCpuKernelLaunchWithFlag(const void *soName, const void *kernelName, uint32_t blockDim,
                                    const rtArgsEx_t *argsInfo, rtSmDesc_t *smDesc, rtStream_t stm, uint32_t flags)
{
    (void)soName;
    (void)kernelName;
    (void)blockDim;
    (void)argsInfo;
    (void)smDesc;
    (void)stm;
    (void)flags;
    return RT_ERROR_NONE;
}

rtError_t rtStreamSynchronize(rtStream_t stm)
{
    (void)stm;
    return RT_ERROR_NONE;
}

rtError_t rtRegTaskFailCallbackByModule(const char_t *moduleName, rtTaskFailCallback callback)
{
    (void)moduleName;
    (void)callback;
    return RT_ERROR_NONE;
}

rtError_t rtCtxGetCurrent(rtContext_t *context)
{
    (void)context;
    return RT_ERROR_NONE;
}

rtError_t rtCtxCreate(rtContext_t *context, uint32_t flags, int32_t devId)
{
    (void)context;
    (void)flags;
    (void)devId;
    return RT_ERROR_NONE;
}

rtError_t rtCtxDestroy(rtContext_t context)
{
    (void)context;
    return (rtError_t)-1;
}

rtError_t rtSetTaskFailCallback(rtTaskFailCallback callback)
{
    return RT_ERROR_NONE;
}

rtError_t rtStreamSynchronizeWithTimeout(rtStream_t stm, int32_t timeout)
{
    if (stm == (rtStream_t)0x5F) {
        return RT_ERROR_STUB_FAILURE;
    }
    return RT_ERROR_NONE;
}

rtError_t rtMemGetInfoByType(const int32_t devId, const rtMemType_t type, rtMemInfo_t * const info)
{
    (void)devId;

    if (type == RT_MEM_INFO_TYPE_ADDR_CHECK) {
        info->addrInfo.flag = true;
    }

    return RT_ERROR_NONE ;
}

rtError_t rtGetMaxStreamAndTask(uint32_t streamType, uint32_t *maxStrCount, uint32_t *maxTaskCount)
{
    *maxStrCount = 100;
    *maxTaskCount = 100;
    return RT_ERROR_NONE;
}

rtError_t rtGetDeviceCount(int32_t *cnt)
{
    *cnt = LOCAL_DEV_NUM;
    return RT_ERROR_NONE;
}

rtError_t rtGetDeviceIDs(uint32_t *devices, uint32_t len)
{
    for (size_t i = 0; i < len; ++i) {
        devices[i] = i;
    }

    return RT_ERROR_NONE;
}

rtError_t rtGetDeviceStatus(const int32_t devId, rtDevStatus_t * const status)
{
    return RT_ERROR_NONE;
}

rtError_t rtGetDeviceInfo(uint32_t deviceId, int32_t moduleType, int32_t infoType, int64_t *val)
{
    return RT_ERROR_NONE;
}

rtError_t rtGetRunMode(rtRunMode *runMode)
{
	*runMode = RT_RUN_MODE_OFFLINE;
    return RT_ERROR_NONE;
}

rtError_t rtDebugSetDumpMode(const uint64_t mode)
{
    if (mode == RT_DEBUG_DUMP_ON_EXCEPTION) {
        return RT_ERROR_NONE;
    }
    
    return RT_ERROR_STUB_FAILURE;
}

rtError_t rtDebugGetStalledCore(rtDbgCoreInfo_t *const coreInfo)
{
    coreInfo->aicBitmap0 = 2;       // 1
    coreInfo->aicBitmap1 = 0;
    coreInfo->aivBitmap0 = 4;       // 25+2
    coreInfo->aivBitmap1 = 12;      // 25+64+2 25+64+3
    return RT_ERROR_NONE;
}

void MockerRegister(const rtDebugMemoryParam_t *const param)
{
    char *dstAddr = reinterpret_cast<char *>(param->dstAddr);
    uint64_t regAddr = 0;
    uint32_t regNum = param->memLen / param->elementSize;
    for (uint32_t i = 0; i < regNum; ++i) {
        regAddr = param->srcAddr + i;
        memcpy_s(dstAddr + i * param->elementSize, param->memLen, &regAddr, sizeof(uint64_t));
    }
}

rtError_t rtDebugReadAICore(rtDebugMemoryParam_t *const param)
{
    char *dstAddr = reinterpret_cast<char *>(param->dstAddr);
    void *srcAddr = reinterpret_cast<char *>(param->srcAddr);
    if (param->coreType == Adx::CORE_TYPE_AIC) {
        switch (param->debugMemType) {
            case RT_MEM_TYPE_L0A:
                sprintf_s(dstAddr, param->memLen, "L0A data, core id: %u", param->coreId);
                break;
            case RT_MEM_TYPE_L0B:
                sprintf_s(dstAddr, param->memLen, "L0B data, core id: %u", param->coreId);
                break;
            case RT_MEM_TYPE_L0C:
                sprintf_s(dstAddr, param->memLen, "L0C data, core id: %u", param->coreId);
                break;
            case RT_MEM_TYPE_UB:
                return -1;
            case RT_MEM_TYPE_L1:
                sprintf_s(dstAddr, param->memLen, "L1 data, core id: %u", param->coreId);
                break;
            case RT_MEM_TYPE_DCACHE:
            case RT_MEM_TYPE_ICACHE:
                memcpy_s(dstAddr, param->memLen, srcAddr, param->memLen);
                break;
            case RT_MEM_TYPE_REGISTER:
                MockerRegister(param);
                break;
            default:
                break;
        }
    } else if (param->coreType == Adx::CORE_TYPE_AIV) {
        switch (param->debugMemType) {
            case RT_MEM_TYPE_L0A:
            case RT_MEM_TYPE_L0B:
            case RT_MEM_TYPE_L0C:
            case RT_MEM_TYPE_L1:
                return -1;
            case RT_MEM_TYPE_UB:
                sprintf_s(dstAddr, param->memLen, "UB data, core id: %u", param->coreId);
                break;
            case RT_MEM_TYPE_DCACHE:
            case RT_MEM_TYPE_ICACHE:
                memcpy_s(dstAddr, param->memLen, srcAddr, param->memLen);
                break;
            case RT_MEM_TYPE_REGISTER:
                MockerRegister(param);
                break;
            default:
                break;
        }
    } else {
        return -1;
    }
    return RT_ERROR_NONE;
}

rtError_t rtGetBinBuffer(const rtBinHandle binHandle, const rtBinBufferType_t type, void **bin, uint32_t *binSize)
{
    if (type == RT_BIN_HOST_ADDR || type == RT_BIN_DEVICE_ADDR) {
        if (binHandle == nullptr) {
            static std::string b = "bin stub";
            *bin = (void *)b.c_str();
            *binSize = b.size();
            return RT_ERROR_NONE;
        }
        *bin = (void *)binHandle;
        *binSize = strlen((const char*)binHandle) + 1;
        return RT_ERROR_NONE;
    }
    return RT_ERROR_STUB_FAILURE;
}

std::map<uint32_t, std::string> g_stackData;

rtError_t rtGetStackBuffer(const rtBinHandle binHandle, const uint32_t coreType, const uint32_t coreId,
                           const void **stack, uint32_t *stackSize)
{
    if (coreType == 0) { // aic
        if (g_stackData.find(coreId) != g_stackData.end()) {
            *stack = (void*)g_stackData[coreId].data();
            *stackSize = g_stackData[coreId].size() + 1;
            return RT_ERROR_NONE;
        } else {
            g_stackData[coreId] = std::string("core type ") + std::to_string(coreType) + std::string(" core id ") + std::to_string(coreId) + " stack data";
            *stack = (void*)g_stackData[coreId].data();
            *stackSize = g_stackData[coreId].size() + 1;
            return RT_ERROR_NONE;
        }
    } else if (coreType == 1) { // aiv
        if (g_stackData.find(coreId + 25) != g_stackData.end()) {
            *stack = (void*)g_stackData[coreId + 25].data();
            *stackSize = g_stackData[coreId + 25].size() + 1;
            return RT_ERROR_NONE;
        } else {
            g_stackData[coreId + 25] = std::string("core type ") + std::to_string(coreType + 25) + std::string(" core id ") + std::to_string(coreId) + " stack data";
            *stack = (void*)g_stackData[coreId + 25].data();
            *stackSize = g_stackData[coreId + 25].size() + 1;
            return RT_ERROR_NONE;
        }
    }
    return RT_ERROR_STUB_FAILURE;
}

rtError_t rtsGetThreadLastTaskId(uint32_t *taskId)
{
    *taskId = 12345;
    return RT_ERROR_NONE;
}

rtError_t rtsStreamGetId(rtStream_t stm, int32_t *streamId)
{
    *streamId = 54321;
    return RT_ERROR_NONE;
}

rtError_t rtsDeviceGetCapability(int32_t deviceId, int32_t devFeatureType, int32_t *val)
{
    if (devFeatureType == RT_FEATURE_SYSTEM_TASKID_BIT_WIDTH) {
        *val = 16;  // OBP:16, David:32
    }
    return RT_ERROR_NONE;
}

uint32_t g_opTimeout = 18 * 60 * 1000;  // default 18 minute

rtError_t rtSetOpExecuteTimeOutWithMs(uint32_t timeout)
{
    g_opTimeout = timeout;
    return RT_ERROR_NONE;
}

rtError_t rtGetOpExecuteTimeoutV2(uint32_t *const timeout)
{
    *timeout = g_opTimeout;
    return RT_ERROR_NONE;
}