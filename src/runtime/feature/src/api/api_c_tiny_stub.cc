/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api.hpp"
using namespace cce::runtime;

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus
VISIBILITY_DEFAULT
rtError_t rtCntNotifyCreate(const int32_t deviceId, rtCntNotify_t * const cntNotify)
{
    (void)deviceId;
    (void)cntNotify;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtCntNotifyCreateWithFlag(const int32_t deviceId, rtCntNotify_t * const cntNotify, const uint32_t flags)
{
    (void)deviceId;
    (void)cntNotify;
    (void)flags;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtCntNotifyRecord(rtCntNotify_t const inCntNotify, rtStream_t const stm,
                            const rtCntNtyRecordInfo_t * const info)
{
    (void)inCntNotify;
    (void)stm;
    (void)info;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtCntNotifyWaitWithTimeout(rtCntNotify_t const inCntNotify, rtStream_t const stm,
                                     const rtCntNtyWaitInfo_t * const info)
{
    (void)inCntNotify;
    (void)stm;
    (void)info;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtCntNotifyReset(rtCntNotify_t const inCntNotify, rtStream_t const stm)
{
    (void)inCntNotify;
    (void)stm;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtCntNotifyDestroy(rtCntNotify_t const inCntNotify)
{
    (void)inCntNotify;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtGetCntNotifyAddress(rtCntNotify_t const inCntNotify, uint64_t * const cntNotifyAddress,
                                rtNotifyType_t const regType)
{
    (void)inCntNotify;
    (void)cntNotifyAddress;
    (void)regType;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtGetCntNotifyId(rtCntNotify_t inCntNotify, uint32_t * const notifyId)
{
    (void)inCntNotify;
    (void)notifyId;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtWriteValue(rtWriteValueInfo_t * const info, rtStream_t const stm)
{
    (void)info;
    (void)stm;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtCCULaunch(rtCcuTaskInfo_t *taskInfo,  rtStream_t const stm)
{
    (void)taskInfo;
    (void)stm;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtUbDevQueryInfo(rtUbDevQueryCmd cmd, void * devInfo)
{
    (void)cmd;
    (void)devInfo;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtGetDevResAddress(rtDevResInfo * const resInfo, rtDevResAddrInfo * const addrInfo)
{
    (void)resInfo;
    (void)addrInfo;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtReleaseDevResAddress(rtDevResInfo * const resInfo)
{
    (void)resInfo;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtWriteValuePtr(void * const writeValueInfo, rtStream_t const stm, void * const pointedAddr)
{
    (void)writeValueInfo;
    (void)stm;
    (void)pointedAddr;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtUbDbSend(rtUbDbInfo_t *dbInfo,  rtStream_t stm)
{
    (void)dbInfo;
    (void)stm;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtUbDirectSend(rtUbWqeInfo_t *wqeInfo, rtStream_t stm)
{
    (void)wqeInfo;
    (void)stm;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtFusionLaunch(void * const fusionInfo, rtStream_t const stm, rtFusionArgsEx_t *argsInfo)
{
    (void)fusionInfo;
    (void)stm;
    (void)argsInfo;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtStreamTaskAbort(rtStream_t stm)
{
    (void)stm;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}
 
VISIBILITY_DEFAULT
rtError_t rtStreamRecover(rtStream_t stm)
{
    (void)stm;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}
 
VISIBILITY_DEFAULT
rtError_t rtStreamTaskClean(rtStream_t stm)
{
    (void)stm;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtGetModelList(int32_t devId, rtModelList_t *mdlList)
{
    (void)devId;
    (void)mdlList;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtDeviceResourceClean(const int32_t devId)
{
    (void)devId;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtGetBinaryDeviceBaseAddr(void *handle, void **deviceBase)
{
    (void)handle;
    (void)deviceBase;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

rtError_t rtFftsPlusTaskLaunch(rtFftsPlusTaskInfo_t *fftsPlusTaskInfo, rtStream_t stm)
{
    (void)fftsPlusTaskInfo;
    (void)stm;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

rtError_t rtFftsPlusTaskLaunchWithFlag(rtFftsPlusTaskInfo_t *fftsPlusTaskInfo, rtStream_t stm, uint32_t flag)
{
    (void)fftsPlusTaskInfo;
    (void)stm;
    (void)flag;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtRDMASend(uint32_t sqIndex, uint32_t wqeIndex, rtStream_t stm)
{
    (void)sqIndex;
    (void)wqeIndex;
    (void)stm;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtRDMADBSend(uint32_t dbIndex, uint64_t dbInfo, rtStream_t stm)
{
    (void)dbIndex;
    (void)dbInfo;
    (void)stm;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}


VISIBILITY_DEFAULT
rtError_t rtIpcSetMemoryName(const void *ptr, uint64_t byteCount, char_t *name, uint32_t len)
{
    (void)ptr;
    (void)byteCount;
    (void)name;
    (void)len;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtIpcSetMemoryAttr(const char *name, uint32_t type, uint64_t attr)
{
    (void)name;
    (void)type;
    (void)attr;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtIpcDestroyMemoryName(const char_t *name)
{
    (void)name;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtIpcOpenMemory(void **ptr, const char_t *name)
{
    (void)ptr;
    (void)name;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtIpcCloseMemory(const void *ptr)
{
    (void)ptr;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtIpcSetNotifyName(rtNotify_t notify, char_t* name, uint32_t len)
{
    (void)notify;
    (void)name;
    (void)len;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtIpcOpenNotify(rtNotify_t *notify, const char_t *name)
{
    (void)notify;
    (void)name;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtIpcOpenNotifyWithFlag(rtNotify_t *notify, const char_t *name, uint32_t flag)
{
    (void)notify;
    (void)name;
    (void)flag;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtLaunchSqeUpdateTask(uint32_t streamId, uint32_t taskId, void *src, uint64_t cnt,
                                rtStream_t stm)
{
    (void)streamId;
    (void)taskId;
    (void)src;
    (void)cnt;
    (void)stm;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtRegKernelLaunchFillFunc(const char* symbol, rtKernelLaunchFillFunc callback)
{
    (void)symbol;
    (void)callback;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtUnRegKernelLaunchFillFunc(const char* symbol)
{
    (void)symbol;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtLaunchKernelExByFuncHandle(rtFuncHandle funcHandle, rtLaunchConfig_t* launchConfig,
    rtLaunchArgsHandle argsHandle, rtStream_t stm)
{
    (void)funcHandle;
    (void)launchConfig;
    (void)argsHandle;
    (void)stm;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtsLaunchReduceAsyncTask(const rtReduceInfo_t *reduceInfo, const rtStream_t stm, const void *reserve)
{
    (void)reduceInfo;
    (void)stm;
    (void)reserve;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtsLaunchUpdateTask(rtStream_t destStm, uint32_t destTaskId, rtStream_t stm, rtTaskUpdateCfg_t *cfg)
{
    (void)destStm;
    (void)destTaskId;
    (void)stm;
    (void)cfg;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtsGetCmoDescSize(size_t *size)
{
    (void)size;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtsSetCmoDesc(rtCmoDesc_t cmoDesc, void *srcAddr, size_t srcLen)
{
    (void)cmoDesc;
    (void)srcAddr;
    (void)srcLen;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtsLaunchCmoAddrTask(rtCmoDesc_t cmoDesc, rtStream_t stm, rtCmoOpCode cmoOpCode, const void *reserve)
{
    (void)cmoDesc;
    (void)stm;
    (void)cmoOpCode;
    (void)reserve;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtCmoAddrTaskLaunch(void *cmoAddrInfo, uint64_t destMax, rtCmoOpCode_t cmoOpCode,
    rtStream_t stm, uint32_t flag)
{
    (void)cmoAddrInfo;
    (void)destMax;
    (void)cmoOpCode;
    (void)stm;
    (void)flag;

    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtModelTaskUpdate(rtStream_t desStm, uint32_t desTaskId, rtStream_t sinkStm,
                            rtMdlTaskUpdateInfo_t *para)
{
    (void)desStm;
    (void)desTaskId;
    (void)sinkStm;
    (void)para;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtReduceAsyncV2(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtRecudeKind_t kind,
                          rtDataType_t type, rtStream_t stm, void *overflowAddr)
{
    (void)dst;
    (void)destMax;
    (void)src;
    (void)cnt;
    (void)kind;
    (void)type;
    (void)stm;
    (void)overflowAddr;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtStreamCreateWithFlagsExternal(rtStream_t *stm, int32_t priority, uint32_t flags)
{
    (void)stm;
    (void)priority;
    (void)flags;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtModelGetNodes(rtModel_t mdl, uint32_t * const num)
{
    (void)mdl;
    (void)num;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtModelDebugDotPrint(rtModel_t mdl)
{
    (void)mdl;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtModelDebugJsonPrint(rtModel_t mdl, const char* path, uint32_t flags)
{
    (void)mdl;
    (void)path;
    (void)flags;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtStreamAddToModel(rtStream_t stm, rtModel_t captureMdl)
{
    (void)stm;
    (void)captureMdl;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}


VISIBILITY_DEFAULT
rtError_t rtStreamBeginCapture(rtStream_t stm, const rtStreamCaptureMode mode)
{
    (void)stm;
    (void)mode;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtStreamEndCapture(rtStream_t stm, rtModel_t *captureMdl)
{
    (void)stm;
    (void)captureMdl;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtStreamGetCaptureInfo(rtStream_t stm, rtStreamCaptureStatus * const status,
                                 rtModel_t *captureMdl)
{
    (void)stm;
    (void)status;
    (void)captureMdl;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtGetTaskBufferLen(const rtTaskBuffType_t type, uint32_t * const bufferLen)
{
    (void)type;
    (void)bufferLen;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtTaskBuild(const rtTaskInput_t * const taskInput, uint32_t* taskLen)
{
    (void)taskInput;
    (void)taskLen;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtGetElfOffset(void * const elfData, const uint32_t elfLen, uint32_t* offset)
{
    (void)elfData;
    (void)elfLen;
    (void)offset;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtGetKernelBin(const char_t *const binFileName, char_t **const buffer, uint32_t *length)
{
    (void)binFileName;
    (void)buffer;
    (void)length;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtFreeKernelBin(char_t * const buffer)
{
    (void)buffer;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtCmoAsync(void *srcAddrPtr, size_t srcLen, rtCmoOpCode_t cmoType, rtStream_t stm)
{
    (void)srcAddrPtr;
    (void)srcLen;
    (void)cmoType;
    (void)stm;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}


VISIBILITY_DEFAULT
rtError_t rtCmoTaskLaunch(rtCmoTaskInfo_t *taskInfo, rtStream_t stm, uint32_t flag)
{
    (void)taskInfo;
    (void)stm;
    (void)flag;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtReduceAsync(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtRecudeKind_t kind,
                        rtDataType_t type, rtStream_t stm)
{
    (void)dst;
    (void)destMax;
    (void)src;
    (void)cnt;
    (void)kind;
    (void)type;
    (void)stm;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtReduceAsyncWithCfg(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtRecudeKind_t kind,
    rtDataType_t type, rtStream_t stm, uint32_t qosCfg)
{
    (void)dst;
    (void)destMax;
    (void)src;
    (void)cnt;
    (void)kind;
    (void)type;
    (void)stm;
    (void)qosCfg;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtReduceAsyncWithCfgV2(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtRecudeKind_t kind,
    rtDataType_t type, rtStream_t stm, const rtTaskCfgInfo_t *cfgInfo)
{
    (void)dst;
    (void)destMax;
    (void)src;
    (void)cnt;
    (void)kind;
    (void)type;
    (void)stm;
    (void)cfgInfo;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtsDeviceGetInfo(uint32_t deviceId, rtDevAttr attr, int64_t *val)
{
    (void)deviceId;
    (void)attr;
    (void)val;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtSnapShotProcessLock()
{
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtSnapShotProcessUnlock()
{
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtSnapShotProcessGetState(rtProcessState *state)
{
    (void)state;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtSnapShotProcessBackup()
{
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtSnapShotProcessRestore()
{
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtSnapShotCallbackRegister(rtSnapShotStage stage, rtSnapShotCallBack callback, void *args)
{
    (void)stage;
    (void)callback;
    (void)args;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtSnapShotCallbackUnregister(rtSnapShotStage stage, rtSnapShotCallBack callback)
{
    (void)stage;
    (void)callback;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtGetStreamBufferLen(const bool isHuge, uint32_t * const bufferLen)
{
    (void)isHuge;
    (void)bufferLen;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtCacheLastTaskOpInfo(const void * const infoPtr, const size_t infoSize)
{
    (void)infoPtr;
    (void)infoSize;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

rtError_t rtSetXpuDevice(rtXpuDevType devType, const uint32_t devId)
{
    UNUSED(devType);
    UNUSED(devId);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtResetXpuDevice(rtXpuDevType devType, const uint32_t devId)
{
    UNUSED(devType);
    UNUSED(devId);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtEventWorkModeSet(uint8_t mode)
{
    UNUSED(mode);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtEventWorkModeGet(uint8_t *mode)
{
    UNUSED(mode);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtIpcGetEventHandle(rtEvent_t event, rtIpcEventHandle_t *handle)
{
    UNUSED(event);
    UNUSED(handle);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtIpcOpenEventHandle(rtIpcEventHandle_t handle, rtEvent_t *event)
{
    UNUSED(event);
    UNUSED(handle);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtGetXpuDevCount(const rtXpuDevType devType, uint32_t *devCount)
{
    UNUSED(devType);
    UNUSED(devCount);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtFunctionGetAttribute(rtFuncHandle funcHandle, rtFuncAttribute attrType, int64_t *attrValue)
{
    UNUSED(funcHandle);
    UNUSED(attrType);
    UNUSED(attrValue);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtLaunchDqsTask(const rtStream_t stm, const rtDqsTaskCfg_t* const taskCfg)
{
    UNUSED(stm);
    UNUSED(taskCfg);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}
#ifdef __cplusplus
}
#endif // __cplusplus
