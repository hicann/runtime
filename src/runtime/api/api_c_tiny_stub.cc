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
    UNUSED(deviceId);
    UNUSED(cntNotify);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtCntNotifyCreateWithFlag(const int32_t deviceId, rtCntNotify_t * const cntNotify, const uint32_t flags)
{
    UNUSED(deviceId);
    UNUSED(cntNotify);
    UNUSED(flags);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtsPersistentTaskClean(rtStream_t stm)
{
    UNUSED(stm);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMemcpyAsyncWithOffset(void **dst, uint64_t dstMax, uint64_t dstDataOffset, const void **src,
    uint64_t cnt, uint64_t srcDataOffset, rtMemcpyKind kind, rtStream_t stm)
{
    UNUSED(dst);
    UNUSED(dstMax);
    UNUSED(dstDataOffset);
    UNUSED(src);
    UNUSED(cnt);
    UNUSED(srcDataOffset);
    UNUSED(kind);
    UNUSED(stm);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMemsetD32(void* dst, uint64_t destMax, uint32_t value, uint64_t count)
{
    UNUSED(dst);
    UNUSED(destMax);
    UNUSED(value);
    UNUSED(count);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMemsetD32Async(void* dst, uint64_t destMax, uint32_t value, uint64_t count, rtStream_t stm)
{
    UNUSED(dst);
    UNUSED(destMax);
    UNUSED(value);
    UNUSED(count);
    UNUSED(stm);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMemAdvise(void* devPtr, uint64_t count, uint32_t advise)
{
    UNUSED(devPtr);
    UNUSED(count);
    UNUSED(advise);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMemManagedAdvise(const void *const ptr, uint64_t size, uint16_t advise, rtMemManagedLocation location)
{
    UNUSED(ptr);
    UNUSED(size);
    UNUSED(advise);
    UNUSED(location);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMemManagedGetAttr(rtMemManagedRangeAttribute attribute, const void *ptr, size_t size, void *data, size_t dataSize)
{
    UNUSED(attribute);
    UNUSED(ptr);
    UNUSED(size);
    UNUSED(data);
    UNUSED(dataSize);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMemManagedGetAttrs(rtMemManagedRangeAttribute *attributes, size_t numAttributes, const void *ptr, 
                                size_t size, void **data, size_t *dataSizes)
{
    UNUSED(attributes);
    UNUSED(numAttributes);
    UNUSED(ptr);
    UNUSED(size);
    UNUSED(data);
    UNUSED(dataSizes);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtsCntNotifyRecord(rtCntNotify_t cntNotify, rtStream_t stm, rtCntNotifyRecordInfo_t *info)
{
    UNUSED(cntNotify);
    UNUSED(stm);
    UNUSED(info);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtNotifyGetPhyInfo(rtNotify_t notify, uint32_t *phyDevId, uint32_t *tsId)
{
    UNUSED(notify);
    UNUSED(phyDevId);
    UNUSED(tsId);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtSetIpcNotifyPid(const char_t *name, int32_t pid[], int32_t num)
{
    UNUSED(name);
    UNUSED(pid);
    UNUSED(num);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtSetIpcMemPid(const char_t *name, int32_t pid[], int32_t num)
{
    UNUSED(name);
    UNUSED(pid);
    UNUSED(num);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

rtError_t rtNpuGetFloatStatus(void * outputAddrPtr, uint64_t outputSize, uint32_t checkMode, rtStream_t stm)
{
    UNUSED(outputAddrPtr);
    UNUSED(outputSize);
    UNUSED(checkMode);
    UNUSED(stm);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtGetDevArgsAddr(rtStream_t stm, rtArgsEx_t *argsInfo, void **devArgsAddr, void **argsHandle)
{
    UNUSED(stm);
    UNUSED(argsInfo);
    UNUSED(devArgsAddr);
    UNUSED(argsHandle);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtSetIpcNotifySuperPodPid(const char *name, uint32_t sdid, int32_t pid)
{
    UNUSED(name);
    UNUSED(sdid);
    UNUSED(pid);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtSetStreamTag(rtStream_t stm, uint32_t geOpTag)
{
    UNUSED(stm);
    UNUSED(geOpTag);
    return ACL_RT_SUCCESS;
}

rtError_t rtNpuClearFloatStatus(uint32_t checkMode, rtStream_t stm)
{
    UNUSED(checkMode);
    UNUSED(stm);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtsStreamBeginTaskUpdate(rtStream_t stm, rtTaskGrp_t handle)
{
    UNUSED(stm);
    UNUSED(handle);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtsStreamBeginTaskGrp(rtStream_t stm)
{
    UNUSED(stm);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtThreadExchangeCaptureMode(rtStreamCaptureMode *mode)
{
    UNUSED(mode);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMemcpyD2DAddrAsync(void *dst, uint64_t dstMax, uint64_t dstOffset, const void *src,
    uint64_t cnt, uint64_t srcOffset, rtStream_t stm)
{
    UNUSED(dst);
    UNUSED(dstMax);
    UNUSED(dstOffset);
    UNUSED(src);
    UNUSED(cnt);
    UNUSED(srcOffset);
    UNUSED(stm);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtStartADCProfiler(void **addr, uint32_t length)
{
    UNUSED(addr);
    UNUSED(length);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtStopADCProfiler(void *addr)
{
    UNUSED(addr);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtsCntNotifyWaitWithTimeout(rtCntNotify_t cntNotify, rtStream_t stm, rtCntNotifyWaitInfo_t *info)
{
    UNUSED(cntNotify);
    UNUSED(stm);
    UNUSED(info);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtsCntNotifyReset(rtCntNotify_t cntNotify, rtStream_t stm)
{
    UNUSED(cntNotify);
    UNUSED(stm);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtIpcMemImportPidInterServer(const char *key, const rtServerPid *serverPids, size_t num)
{
    UNUSED(key);
    UNUSED(serverPids);
    UNUSED(num);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtGetSocSpec(const char* label, const char* key, char* val, const uint32_t maxLen)
{
    UNUSED(label);
    UNUSED(key);
    UNUSED(val);
    UNUSED(maxLen);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtNotifySetImportPidInterServer(rtNotify_t notify, const rtServerPid *serverPids, size_t num)
{
    UNUSED(notify);
    UNUSED(serverPids);
    UNUSED(num);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtCntNotifyCreateServer(rtCntNotify_t * const cntNotify, uint64_t flags)
{
    UNUSED(cntNotify);
    UNUSED(flags);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtCntNotifyRecord(rtCntNotify_t const inCntNotify, rtStream_t const stm,
                            const rtCntNtyRecordInfo_t * const info)
{
    UNUSED(inCntNotify);
    UNUSED(stm);
    UNUSED(info);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtsCntNotifyGetId(rtCntNotify_t cntNotify, uint32_t *notifyId)
{
    UNUSED(cntNotify);
    UNUSED(notifyId);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtCntNotifyWaitWithTimeout(rtCntNotify_t const inCntNotify, rtStream_t const stm,
                                     const rtCntNtyWaitInfo_t * const info)
{
    UNUSED(inCntNotify);
    UNUSED(stm);
    UNUSED(info);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtCntNotifyReset(rtCntNotify_t const inCntNotify, rtStream_t const stm)
{
    UNUSED(inCntNotify);
    UNUSED(stm);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtCntNotifyDestroy(rtCntNotify_t const inCntNotify)
{
    UNUSED(inCntNotify);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtGetCntNotifyAddress(rtCntNotify_t const inCntNotify, uint64_t * const cntNotifyAddress,
                                rtNotifyType_t const regType)
{
    UNUSED(inCntNotify);
    UNUSED(cntNotifyAddress);
    UNUSED(regType);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtGetCntNotifyId(rtCntNotify_t inCntNotify, uint32_t * const notifyId)
{
    UNUSED(inCntNotify);
    UNUSED(notifyId);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtWriteValue(rtWriteValueInfo_t * const info, rtStream_t const stm)
{
    UNUSED(info);
    UNUSED(stm);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtCCULaunch(rtCcuTaskInfo_t *taskInfo,  rtStream_t const stm)
{
    UNUSED(taskInfo);
    UNUSED(stm);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtUbDevQueryInfo(rtUbDevQueryCmd cmd, void * devInfo)
{
    UNUSED(cmd);
    UNUSED(devInfo);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtGetDevResAddress(rtDevResInfo * const resInfo, rtDevResAddrInfo * const addrInfo)
{
    UNUSED(resInfo);
    UNUSED(addrInfo);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtReleaseDevResAddress(rtDevResInfo * const resInfo)
{
    UNUSED(resInfo);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtWriteValuePtr(void * const writeValueInfo, rtStream_t const stm, void * const pointedAddr)
{
    UNUSED(writeValueInfo);
    UNUSED(stm);
    UNUSED(pointedAddr);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtUbDbSend(rtUbDbInfo_t *dbInfo,  rtStream_t stm)
{
    UNUSED(dbInfo);
    UNUSED(stm);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtUbDirectSend(rtUbWqeInfo_t *wqeInfo, rtStream_t stm)
{
    UNUSED(wqeInfo);
    UNUSED(stm);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtFusionLaunch(void * const fusionInfo, rtStream_t const stm, rtFusionArgsEx_t *argsInfo)
{
    UNUSED(fusionInfo);
    UNUSED(stm);
    UNUSED(argsInfo);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtStreamTaskAbort(rtStream_t stm)
{
    UNUSED(stm);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}
 
VISIBILITY_DEFAULT
rtError_t rtStreamRecover(rtStream_t stm)
{
    UNUSED(stm);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}
 
VISIBILITY_DEFAULT
rtError_t rtStreamTaskClean(rtStream_t stm)
{
    UNUSED(stm);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtDeviceResourceClean(const int32_t devId)
{
    UNUSED(devId);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtGetBinaryDeviceBaseAddr(void *handle, void **deviceBase)
{
    UNUSED(handle);
    UNUSED(deviceBase);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

rtError_t rtFftsPlusTaskLaunch(rtFftsPlusTaskInfo_t *fftsPlusTaskInfo, rtStream_t stm)
{
    UNUSED(fftsPlusTaskInfo);
    UNUSED(stm);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

rtError_t rtFftsPlusTaskLaunchWithFlag(rtFftsPlusTaskInfo_t *fftsPlusTaskInfo, rtStream_t stm, uint32_t flag)
{
    UNUSED(fftsPlusTaskInfo);
    UNUSED(stm);
    UNUSED(flag);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtRDMASend(uint32_t sqIndex, uint32_t wqeIndex, rtStream_t stm)
{
    UNUSED(sqIndex);
    UNUSED(wqeIndex);
    UNUSED(stm);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtRDMADBSend(uint32_t dbIndex, uint64_t dbInfo, rtStream_t stm)
{
    UNUSED(dbIndex);
    UNUSED(dbInfo);
    UNUSED(stm);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}


VISIBILITY_DEFAULT
rtError_t rtIpcSetMemoryName(const void *ptr, uint64_t byteCount, char_t *name, uint32_t len)
{
    UNUSED(ptr);
    UNUSED(byteCount);
    UNUSED(name);
    UNUSED(len);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtIpcSetMemoryAttr(const char *name, uint32_t type, uint64_t attr)
{
    UNUSED(name);
    UNUSED(type);
    UNUSED(attr);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtIpcDestroyMemoryName(const char_t *name)
{
    UNUSED(name);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtIpcOpenMemory(void **ptr, const char_t *name)
{
    UNUSED(ptr);
    UNUSED(name);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtIpcCloseMemory(const void *ptr)
{
    UNUSED(ptr);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtIpcSetNotifyName(rtNotify_t notify, char_t* name, uint32_t len)
{
    UNUSED(notify);
    UNUSED(name);
    UNUSED(len);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtIpcOpenNotify(rtNotify_t *notify, const char_t *name)
{
    UNUSED(notify);
    UNUSED(name);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtIpcOpenNotifyWithFlag(rtNotify_t *notify, const char_t *name, uint32_t flag)
{
    UNUSED(notify);
    UNUSED(name);
    UNUSED(flag);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtLaunchSqeUpdateTask(uint32_t streamId, uint32_t taskId, void *src, uint64_t cnt,
                                rtStream_t stm)
{
    UNUSED(streamId);
    UNUSED(taskId);
    UNUSED(src);
    UNUSED(cnt);
    UNUSED(stm);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtRegKernelLaunchFillFunc(const char* symbol, rtKernelLaunchFillFunc callback)
{
    UNUSED(symbol);
    UNUSED(callback);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtUnRegKernelLaunchFillFunc(const char* symbol)
{
    UNUSED(symbol);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtsLaunchReduceAsyncTask(const rtReduceInfo_t *reduceInfo, const rtStream_t stm, const void *reserve)
{
    UNUSED(reduceInfo);
    UNUSED(stm);
    UNUSED(reserve);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtsLaunchUpdateTask(rtStream_t destStm, uint32_t destTaskId, rtStream_t stm, rtTaskUpdateCfg_t *cfg)
{
    UNUSED(destStm);
    UNUSED(destTaskId);
    UNUSED(stm);
    UNUSED(cfg);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtsGetCmoDescSize(size_t *size)
{
    UNUSED(size);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtsSetCmoDesc(rtCmoDesc_t cmoDesc, void *srcAddr, size_t srcLen)
{
    UNUSED(cmoDesc);
    UNUSED(srcAddr);
    UNUSED(srcLen);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtsLaunchCmoAddrTask(rtCmoDesc_t cmoDesc, rtStream_t stm, rtCmoOpCode cmoOpCode, const void *reserve)
{
    UNUSED(cmoDesc);
    UNUSED(stm);
    UNUSED(cmoOpCode);
    UNUSED(reserve);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtCmoAddrTaskLaunch(void *cmoAddrInfo, uint64_t destMax, rtCmoOpCode_t cmoOpCode,
    rtStream_t stm, uint32_t flag)
{
    UNUSED(cmoAddrInfo);
    UNUSED(destMax);
    UNUSED(cmoOpCode);
    UNUSED(stm);
    UNUSED(flag);

    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtModelTaskUpdate(rtStream_t desStm, uint32_t desTaskId, rtStream_t sinkStm,
                            rtMdlTaskUpdateInfo_t *para)
{
    UNUSED(desStm);
    UNUSED(desTaskId);
    UNUSED(sinkStm);
    UNUSED(para);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtReduceAsyncV2(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtRecudeKind_t kind,
                          rtDataType_t type, rtStream_t stm, void *overflowAddr)
{
    UNUSED(dst);
    UNUSED(destMax);
    UNUSED(src);
    UNUSED(cnt);
    UNUSED(kind);
    UNUSED(type);
    UNUSED(stm);
    UNUSED(overflowAddr);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtStreamCreateWithFlagsExternal(rtStream_t *stm, int32_t priority, uint32_t flags)
{
    UNUSED(stm);
    UNUSED(priority);
    UNUSED(flags);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtModelGetNodes(rtModel_t mdl, uint32_t * const num)
{
    UNUSED(mdl);
    UNUSED(num);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtModelDebugDotPrint(rtModel_t mdl)
{
    UNUSED(mdl);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtModelDebugJsonPrint(rtModel_t mdl, const char* path, uint32_t flags)
{
    UNUSED(mdl);
    UNUSED(path);
    UNUSED(flags);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtModelDestroyRegisterCallback(rtModel_t const mdl, rtCallback_t fn, void *ptr)
{
    UNUSED(mdl);
    UNUSED(fn);
    UNUSED(ptr);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtModelDestroyUnregisterCallback(rtModel_t const mdl, rtCallback_t fn)
{
    UNUSED(mdl);
    UNUSED(fn);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtStreamAddToModel(rtStream_t stm, rtModel_t captureMdl)
{
    UNUSED(stm);
    UNUSED(captureMdl);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}


VISIBILITY_DEFAULT
rtError_t rtStreamBeginCapture(rtStream_t stm, const rtStreamCaptureMode mode)
{
    UNUSED(stm);
    UNUSED(mode);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtStreamEndCapture(rtStream_t stm, rtModel_t *captureMdl)
{
    UNUSED(stm);
    UNUSED(captureMdl);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtStreamGetCaptureInfo(rtStream_t stm, rtStreamCaptureStatus * const status,
                                 rtModel_t *captureMdl)
{
    UNUSED(stm);
    UNUSED(status);
    UNUSED(captureMdl);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtModelCondHandleCreate(rtModel_t mdl, uint32_t defaultLaunchValue,
    rtCondHandleFlag_t flag, rtCondHandle_t *handle)
{
    (void)mdl;
    (void)defaultLaunchValue;
    (void)flag;
    (void)handle;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtModelCondHandleGetCondPtr(rtCondHandle_t handle, uint64_t **devPtr)
{
    (void)handle;
    (void)devPtr;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtStreamAddCondTask(rtCondTaskParams params, rtStream_t stm, uint32_t flags)
{
    (void)params;
    (void)stm;
    (void)flags;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtStreamBeginCaptureToModel(rtStream_t stm, rtModel_t mdl, const rtStreamCaptureMode mode)
{
    (void)stm;
    (void)mdl;
    (void)mode;
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtGetTaskBufferLen(const rtTaskBuffType_t type, uint32_t * const bufferLen)
{
    UNUSED(type);
    UNUSED(bufferLen);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtTaskBuild(const rtTaskInput_t * const taskInput, uint32_t* taskLen)
{
    UNUSED(taskInput);
    UNUSED(taskLen);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtGetElfOffset(void * const elfData, const uint32_t elfLen, uint32_t* offset)
{
    UNUSED(elfData);
    UNUSED(elfLen);
    UNUSED(offset);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtGetKernelBin(const char_t *const binFileName, char_t **const buffer, uint32_t *length)
{
    UNUSED(binFileName);
    UNUSED(buffer);
    UNUSED(length);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtFreeKernelBin(char_t * const buffer)
{
    UNUSED(buffer);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtCmoAsync(void *srcAddrPtr, size_t srcLen, rtCmoOpCode_t cmoType, rtStream_t stm)
{
    UNUSED(srcAddrPtr);
    UNUSED(srcLen);
    UNUSED(cmoType);
    UNUSED(stm);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}


VISIBILITY_DEFAULT
rtError_t rtCmoTaskLaunch(rtCmoTaskInfo_t *taskInfo, rtStream_t stm, uint32_t flag)
{
    UNUSED(taskInfo);
    UNUSED(stm);
    UNUSED(flag);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtReduceAsync(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtRecudeKind_t kind,
                        rtDataType_t type, rtStream_t stm)
{
    UNUSED(dst);
    UNUSED(destMax);
    UNUSED(src);
    UNUSED(cnt);
    UNUSED(kind);
    UNUSED(type);
    UNUSED(stm);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtReduceAsyncWithCfg(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtRecudeKind_t kind,
    rtDataType_t type, rtStream_t stm, uint32_t qosCfg)
{
    UNUSED(dst);
    UNUSED(destMax);
    UNUSED(src);
    UNUSED(cnt);
    UNUSED(kind);
    UNUSED(type);
    UNUSED(stm);
    UNUSED(qosCfg);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtReduceAsyncWithCfgV2(void *dst, uint64_t destMax, const void *src, uint64_t cnt, rtRecudeKind_t kind,
    rtDataType_t type, rtStream_t stm, const rtTaskCfgInfo_t *cfgInfo)
{
    UNUSED(dst);
    UNUSED(destMax);
    UNUSED(src);
    UNUSED(cnt);
    UNUSED(kind);
    UNUSED(type);
    UNUSED(stm);
    UNUSED(cfgInfo);
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
    UNUSED(state);
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
    UNUSED(stage);
    UNUSED(callback);
    UNUSED(args);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtSnapShotCallbackUnregister(rtSnapShotStage stage, rtSnapShotCallBack callback)
{
    UNUSED(stage);
    UNUSED(callback);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtCacheLastTaskOpInfo(const void * const infoPtr, const size_t infoSize)
{
    UNUSED(infoPtr);
    UNUSED(infoSize);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtCacheLastTaskExtendInfo(const char* const extendInfoPtr, const size_t infoSize)
{
    UNUSED(extendInfoPtr);
    UNUSED(infoSize);
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
rtError_t rtFunctionGetBinary(const rtFuncHandle funcHandle, rtBinHandle *binHandle)
{
    UNUSED(funcHandle);
    UNUSED(binHandle);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtGetFuncBySymbol(const void *symbol, rtFuncHandle *funcHandle)
{
    UNUSED(symbol);
    UNUSED(funcHandle);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtRegisterFuncSymbol(void *binHandle, const void *symbol, const char *kernelName,
                               void *reserve)
{
    UNUSED(binHandle);
    UNUSED(symbol);
    UNUSED(kernelName);
    UNUSED(reserve);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtFunctionGetParamCount(const void *func, size_t *paramCount)
{
    UNUSED(func);
    UNUSED(paramCount);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtFunctionGetParamInfo(const void *func, size_t paramIndex,
                                 size_t *paramOffset, size_t *paramSize)
{
    UNUSED(func);
    UNUSED(paramIndex);
    UNUSED(paramOffset);
    UNUSED(paramSize);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtFunctionGetAvailDynUbufPerBlock(void *func, uint32_t flags, size_t *dynamicUbufSize)
{
    UNUSED(func);
    UNUSED(flags);
    UNUSED(dynamicUbufSize);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtLaunchKernelWithArgsArray(void *func, uint32_t numBlocks, rtStream_t stm,
                                      rtKernelLaunchCfg_t *cfg, void **args)
{
    UNUSED(func);
    UNUSED(numBlocks);
    UNUSED(stm);
    UNUSED(cfg);
    UNUSED(args);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtModelTaskGetParams(rtTask_t task, rtTaskParams* params)
{
    UNUSED(task);
    UNUSED(params);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtModelTaskSetParams(rtTask_t task, rtTaskParams* params)
{
    UNUSED(task);
    UNUSED(params);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtModelKernelTaskGetAttribute(rtTask_t task, rtLaunchKernelAttrId attrId, rtLaunchKernelAttrVal_t *attrValue)
{
    UNUSED(task);
    UNUSED(attrId);
    UNUSED(attrValue);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtModelUpdate(rtModel_t mdl)
{
    UNUSED(mdl);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtModelTaskDisable(rtTask_t task)
{
    UNUSED(task);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtFuncGetSize(const rtFuncHandle funcHandle, size_t *aicSize, size_t *aivSize)
{
    UNUSED(funcHandle);
    UNUSED(aicSize);
    UNUSED(aivSize);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtLaunchDqsTask(const rtStream_t stm, const rtDqsTaskCfg_t* const taskCfg)
{
    UNUSED(stm);
    UNUSED(taskCfg);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtsNotifySetImportPid(rtNotify_t notify, int32_t pid[], int num)
{
    UNUSED(notify);
    UNUSED(pid);
    UNUSED(num);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMemPoolCreate(rtMemPool_t *memPool, const rtMemPoolProps *poolProps)
{
    UNUSED(memPool);
    UNUSED(poolProps);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMemPoolDestroy(const rtMemPool_t memPool)
{
    UNUSED(memPool);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMemPoolSetAttr(rtMemPool_t memPool, rtMemPoolAttr attr, void *value)
{
    UNUSED(memPool);
    UNUSED(attr);
    UNUSED(value);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMemPoolGetAttr(rtMemPool_t memPool, rtMemPoolAttr attr, void *value)
{
    UNUSED(memPool);
    UNUSED(attr);
    UNUSED(value);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMemPoolMallocAsync(void **ptr, const uint64_t size, const rtMemPool_t memPoolId,
                                const rtStream_t stm)
{
    UNUSED(ptr);
    UNUSED(size);
    UNUSED(memPoolId);
    UNUSED(stm);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMemPoolFreeAsync(void *ptr, rtStream_t stm)
{
    UNUSED(ptr);
    UNUSED(stm);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMemPoolTrimTo(rtMemPool_t memPool, uint64_t minBytesToKeep)
{
    UNUSED(memPool);
    UNUSED(minBytesToKeep);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtModelGetStreams(rtModel_t const mdl, rtStream_t *streams, uint32_t *numStreams)
{
    UNUSED(mdl);
    UNUSED(streams);
    UNUSED(numStreams);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtStreamGetTasks(rtStream_t const stm, rtTask_t *tasks, uint32_t *numTasks)
{
    UNUSED(stm);
    UNUSED(tasks);
    UNUSED(numTasks);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtTaskGetType(rtTask_t task, rtTaskType *type)
{
    UNUSED(task);
    UNUSED(type);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
RTS_API rtError_t rtTaskGetSeqId(rtTask_t task, uint32_t *id)
{
    UNUSED(task);
    UNUSED(id);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtBinaryGetMetaNum(const rtBinHandle binHandle, const rtBinaryMetaType type, size_t *numOfMeta)
{
    UNUSED(binHandle);
    UNUSED(type);
    UNUSED(numOfMeta);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtBinaryGetMetaInfo(const rtBinHandle binHandle, const rtBinaryMetaType type, const size_t numOfMeta,
    void **data, const size_t *dataSize)
{
    UNUSED(binHandle);
    UNUSED(type);
    UNUSED(numOfMeta);
    UNUSED(data);
    UNUSED(dataSize);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMemManagedPrefetchAsync(const void* ptr, size_t size, rtMemManagedLocation location,
    uint32_t flags, rtStream_t stream)
{
    UNUSED(ptr);
    UNUSED(size);
    UNUSED(location);
    UNUSED(flags);
    UNUSED(stream);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMemManagedPrefetchBatchAsync(const void** ptrs, size_t* sizes, size_t count,
    rtMemManagedLocation* prefetchLocs, size_t* prefetchLocIdxs, size_t numPrefetchLocs, uint64_t flags,
    rtStream_t stream)
{
    UNUSED(ptrs);
    UNUSED(sizes);
    UNUSED(count);
    UNUSED(prefetchLocs);
    UNUSED(prefetchLocIdxs);
    UNUSED(numPrefetchLocs);
    UNUSED(flags);
    UNUSED(stream);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
void rtRegisterVariable(void *binHandle, const void *hostVar, const char *deviceVarName,
                        size_t size, uint32_t flags, void *reserve)
{
    UNUSED(binHandle);
    UNUSED(hostVar);
    UNUSED(deviceVarName);
    UNUSED(size);
    UNUSED(flags);
    UNUSED(reserve);
}

VISIBILITY_DEFAULT
rtError_t rtSymbolLookup(const void *hostVar, void **devPtr, size_t *size)
{
    UNUSED(hostVar);
    UNUSED(devPtr);
    UNUSED(size);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}


VISIBILITY_DEFAULT
rtError_t rtBinaryGetGlobal(const rtBinHandle binHandle, const char *name, void **dptr, size_t *size)
{
    UNUSED(binHandle);
    UNUSED(name);
    UNUSED(dptr);
    UNUSED(size);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}
#ifdef __cplusplus
}
#endif // __cplusplus
