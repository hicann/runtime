/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cstdarg>
#include "set_device_vxx.h"
#include "acl/acl_rt_impl.h"

aclError aclrtPeekAtLastError(aclrtLastErrLevel level)
{
    return aclrtPeekAtLastErrorImpl(level);
}

aclError aclrtGetLastError(aclrtLastErrLevel level)
{
    return aclrtGetLastErrorImpl(level);
}

aclError aclrtSetExceptionInfoCallback(aclrtExceptionInfoCallback callback)
{
    return aclrtSetExceptionInfoCallbackImpl(callback);
}

uint32_t aclrtGetTaskIdFromExceptionInfo(const aclrtExceptionInfo *info)
{
    return aclrtGetTaskIdFromExceptionInfoImpl(info);
}

uint32_t aclrtGetStreamIdFromExceptionInfo(const aclrtExceptionInfo *info)
{
    return aclrtGetStreamIdFromExceptionInfoImpl(info);
}

uint32_t aclrtGetThreadIdFromExceptionInfo(const aclrtExceptionInfo *info)
{
    return aclrtGetThreadIdFromExceptionInfoImpl(info);
}

uint32_t aclrtGetDeviceIdFromExceptionInfo(const aclrtExceptionInfo *info)
{
    return aclrtGetDeviceIdFromExceptionInfoImpl(info);
}

uint32_t aclrtGetErrorCodeFromExceptionInfo(const aclrtExceptionInfo *info)
{
    return aclrtGetErrorCodeFromExceptionInfoImpl(info);
}

aclError aclrtSubscribeReport(uint64_t threadId, aclrtStream stream)
{
    return aclrtSubscribeReportImpl(threadId, stream);
}

aclError aclrtLaunchCallback(aclrtCallback fn, void *userData, aclrtCallbackBlockType blockType, aclrtStream stream)
{
    return aclrtLaunchCallbackImpl(fn, userData, blockType, stream);
}

aclError aclrtProcessReport(int32_t timeout)
{
    return aclrtProcessReportImpl(timeout);
}

aclError aclrtUnSubscribeReport(uint64_t threadId, aclrtStream stream)
{
    return aclrtUnSubscribeReportImpl(threadId, stream);
}

aclError aclrtCreateContext(aclrtContext *context, int32_t deviceId)
{
    return aclrtCreateContextImpl(context, deviceId);
}

aclError aclrtDestroyContext(aclrtContext context)
{
    return aclrtDestroyContextImpl(context);
}

aclError aclrtSetCurrentContext(aclrtContext context)
{
    return aclrtSetCurrentContextImpl(context);
}

aclError aclrtGetCurrentContext(aclrtContext *context)
{
    return aclrtGetCurrentContextImpl(context);
}

aclError aclrtCtxGetSysParamOpt(aclSysParamOpt opt, int64_t *value)
{
    return aclrtCtxGetSysParamOptImpl(opt, value);
}

aclError aclrtCtxSetSysParamOpt(aclSysParamOpt opt, int64_t value)
{
    return aclrtCtxSetSysParamOptImpl(opt, value);
}

aclError aclrtGetSysParamOpt(aclSysParamOpt opt, int64_t *value)
{
    return aclrtGetSysParamOptImpl(opt, value);
}

aclError aclrtSetSysParamOpt(aclSysParamOpt opt, int64_t value)
{
    return aclrtSetSysParamOptImpl(opt, value);
}

aclError aclrtSetDevice(int32_t deviceId)
{
    return aclrtSetDeviceImpl(deviceId);
}

aclError aclrtResetDevice(int32_t deviceId)
{
    return aclrtResetDeviceImpl(deviceId);
}

aclError aclrtResetDeviceForce(int32_t deviceId)
{
    return aclrtResetDeviceForceImpl(deviceId);
}

aclError aclrtGetDevice(int32_t *deviceId)
{
    return aclrtGetDeviceImpl(deviceId);
}

aclError aclrtSetStreamFailureMode(aclrtStream stream, uint64_t mode)
{
    return aclrtSetStreamFailureModeImpl(stream, mode);
}

aclError aclrtGetRunMode(aclrtRunMode *runMode)
{
    return aclrtGetRunModeImpl(runMode);
}

aclError aclrtSynchronizeDevice(void)
{
    return aclrtSynchronizeDeviceImpl();
}

aclError aclrtSynchronizeDeviceWithTimeout(int32_t timeout)
{
    return aclrtSynchronizeDeviceWithTimeoutImpl(timeout);
}

aclError aclrtSetTsDevice(aclrtTsId tsId)
{
    return aclrtSetTsDeviceImpl(tsId);
}

aclError aclrtGetDeviceUtilizationRate(int32_t deviceId, aclrtUtilizationInfo *utilizationInfo)
{
    return aclrtGetDeviceUtilizationRateImpl(deviceId, utilizationInfo);
}

aclError aclrtGetDeviceCount(uint32_t *count)
{
    return aclrtGetDeviceCountImpl(count);
}

aclError aclrtCreateEvent(aclrtEvent *event)
{
    return aclrtCreateEventImpl(event);
}

aclError aclrtCreateEventWithFlag(aclrtEvent *event, uint32_t flag)
{
    return aclrtCreateEventWithFlagImpl(event, flag);
}

aclError aclrtCreateEventExWithFlag(aclrtEvent *event, uint32_t flag)
{
    return aclrtCreateEventExWithFlagImpl(event, flag);
}

aclError aclrtDestroyEvent(aclrtEvent event)
{
    return aclrtDestroyEventImpl(event);
}

aclError aclrtRecordEvent(aclrtEvent event, aclrtStream stream)
{
    return aclrtRecordEventImpl(event, stream);
}

aclError aclrtResetEvent(aclrtEvent event, aclrtStream stream)
{
    return aclrtResetEventImpl(event, stream);
}

aclError aclrtQueryEvent(aclrtEvent event, aclrtEventStatus *status)
{
    return aclrtQueryEventImpl(event, status);
}

aclError aclrtQueryEventStatus(aclrtEvent event, aclrtEventRecordedStatus *status)
{
    return aclrtQueryEventStatusImpl(event, status);
}

aclError aclrtQueryEventWaitStatus(aclrtEvent event, aclrtEventWaitStatus *status)
{
    return aclrtQueryEventWaitStatusImpl(event, status);
}

aclError aclrtSynchronizeEvent(aclrtEvent event)
{
    return aclrtSynchronizeEventImpl(event);
}

aclError aclrtSynchronizeEventWithTimeout(aclrtEvent event, int32_t timeout)
{
    return aclrtSynchronizeEventWithTimeoutImpl(event, timeout);
}

aclError aclrtEventElapsedTime(float *ms, aclrtEvent startEvent, aclrtEvent endEvent)
{
    return aclrtEventElapsedTimeImpl(ms, startEvent, endEvent);
}

aclError aclrtEventGetTimestamp(aclrtEvent event, uint64_t *timestamp)
{
    return aclrtEventGetTimestampImpl(event, timestamp);
}

aclError aclrtMalloc(void **devPtr, size_t size, aclrtMemMallocPolicy policy)
{
    return aclrtMallocImpl(devPtr, size, policy);
}

aclError aclrtMallocAlign32(void **devPtr, size_t size, aclrtMemMallocPolicy policy)
{
    return aclrtMallocAlign32Impl(devPtr, size, policy);
}

aclError aclrtMallocCached(void **devPtr, size_t size, aclrtMemMallocPolicy policy)
{
    return aclrtMallocCachedImpl(devPtr, size, policy);
}

aclError aclrtMallocWithCfg(void **devPtr, size_t size, aclrtMemMallocPolicy policy, aclrtMallocConfig *cfg)
{
    return aclrtMallocWithCfgImpl(devPtr, size, policy, cfg);
}

aclError aclrtMallocForTaskScheduler(void **devPtr, size_t size, aclrtMemMallocPolicy policy, aclrtMallocConfig *cfg)
{
    return aclrtMallocForTaskSchedulerImpl(devPtr, size, policy, cfg);
}

aclError aclrtMallocHostWithCfg(void **ptr, uint64_t size, aclrtMallocConfig *cfg)
{
    return aclrtMallocHostWithCfgImpl(ptr, size, cfg);
}

aclError aclrtPointerGetAttributes(const void *ptr, aclrtPtrAttributes *attributes)
{
    return aclrtPointerGetAttributesImpl(ptr, attributes);
}

aclError aclrtHostRegister(void *ptr, uint64_t size, aclrtHostRegisterType type, void **devPtr)
{
    return aclrtHostRegisterImpl(ptr, size, type, devPtr);
}

aclError aclrtHostRegisterV2(void *ptr, uint64_t size, uint32_t flag)
{
    return aclrtHostRegisterV2Impl(ptr, size, flag);
}

aclError aclrtHostGetDevicePointer(void *pHost, void **pDevice, uint32_t flag)
{
    return aclrtHostGetDevicePointerImpl(pHost, pDevice, flag);
}

aclError aclrtHostUnregister(void *ptr)
{
    return aclrtHostUnregisterImpl(ptr);
}

aclError aclrtGetThreadLastTaskId(uint32_t *taskId)
{
    return aclrtGetThreadLastTaskIdImpl(taskId);
}

aclError aclrtStreamGetId(aclrtStream stream, int32_t *streamId)
{
    return aclrtStreamGetIdImpl(stream, streamId);
}

aclError aclrtMemFlush(void *devPtr, size_t size)
{
    return aclrtMemFlushImpl(devPtr, size);
}

aclError aclrtMemInvalidate(void *devPtr, size_t size)
{
    return aclrtMemInvalidateImpl(devPtr, size);
}

aclError aclrtFree(void *devPtr)
{
    return aclrtFreeImpl(devPtr);
}

aclError aclrtMallocHost(void **hostPtr, size_t size)
{
    return aclrtMallocHostImpl(hostPtr, size);
}

aclError aclrtFreeHost(void *hostPtr)
{
    return aclrtFreeHostImpl(hostPtr);
}

aclError aclrtFreeWithDevSync(void *devPtr)
{
    return aclrtFreeWithDevSyncImpl(devPtr);
}

aclError aclrtFreeHostWithDevSync(void *hostPtr)
{
    return aclrtFreeHostWithDevSyncImpl(hostPtr);
}

aclError aclrtMemcpy(void *dst, size_t destMax, const void *src, size_t count, aclrtMemcpyKind kind)
{
    return aclrtMemcpyImpl(dst, destMax, src, count, kind);
}

aclError aclrtMemset(void *devPtr, size_t maxCount, int32_t value, size_t count)
{
    return aclrtMemsetImpl(devPtr, maxCount, value, count);
}

aclError aclrtMemcpyAsync(void *dst, size_t destMax, const void *src, size_t count, aclrtMemcpyKind kind,
    aclrtStream stream)
{
    return aclrtMemcpyAsyncImpl(dst, destMax, src, count, kind, stream);
}

aclError aclrtMemcpyAsyncWithCondition(void *dst, size_t destMax, const void *src, size_t count, aclrtMemcpyKind kind,
    aclrtStream stream)
{
    return aclrtMemcpyAsyncWithConditionImpl(dst, destMax, src, count, kind, stream);
}

aclError aclrtMemcpy2d(void *dst, size_t dpitch, const void *src, size_t spitch, size_t width, size_t height,
    aclrtMemcpyKind kind)
{
    return aclrtMemcpy2dImpl(dst, dpitch, src, spitch, width, height, kind);
}

aclError aclrtMemcpy2dAsync(void *dst, size_t dpitch, const void *src, size_t spitch, size_t width, size_t height,
    aclrtMemcpyKind kind, aclrtStream stream)
{
    return aclrtMemcpy2dAsyncImpl(dst, dpitch, src, spitch, width, height, kind, stream);
}

aclError aclrtMemsetAsync(void *devPtr, size_t maxCount, int32_t value, size_t count, aclrtStream stream)
{
    return aclrtMemsetAsyncImpl(devPtr, maxCount, value, count, stream);
}

aclError aclrtReserveMemAddress(void **virPtr, size_t size, size_t alignment, void *expectPtr, uint64_t flags)
{
    return aclrtReserveMemAddressImpl(virPtr, size, alignment, expectPtr, flags);
}

aclError aclrtReleaseMemAddress(void *virPtr)
{
    return aclrtReleaseMemAddressImpl(virPtr);
}

aclError aclrtMallocPhysical(aclrtDrvMemHandle *handle, size_t size, const aclrtPhysicalMemProp *prop, uint64_t flags)
{
    return aclrtMallocPhysicalImpl(handle, size, prop, flags);
}

aclError aclrtFreePhysical(aclrtDrvMemHandle handle)
{
    return aclrtFreePhysicalImpl(handle);
}

aclError aclrtMapMem(void *virPtr, size_t size, size_t offset, aclrtDrvMemHandle handle, uint64_t flags)
{
    return aclrtMapMemImpl(virPtr, size, offset, handle, flags);
}

aclError aclrtUnmapMem(void *virPtr)
{
    return aclrtUnmapMemImpl(virPtr);
}

aclError aclrtCreateStream(aclrtStream *stream)
{
    return aclrtCreateStreamImpl(stream);
}

aclError aclrtCreateStreamWithConfig(aclrtStream *stream, uint32_t priority, uint32_t flag)
{
    return aclrtCreateStreamWithConfigImpl(stream, priority, flag);
}

aclError aclrtDestroyStream(aclrtStream stream)
{
    return aclrtDestroyStreamImpl(stream);
}

aclError aclrtDestroyStreamForce(aclrtStream stream)
{
    return aclrtDestroyStreamForceImpl(stream);
}

aclError aclrtSynchronizeStream(aclrtStream stream)
{
    return aclrtSynchronizeStreamImpl(stream);
}

aclError aclrtSynchronizeStreamWithTimeout(aclrtStream stream, int32_t timeout)
{
    return aclrtSynchronizeStreamWithTimeoutImpl(stream, timeout);
}

aclError aclrtStreamQuery(aclrtStream stream, aclrtStreamStatus *status)
{
    return aclrtStreamQueryImpl(stream, status);
}

aclError aclrtStreamGetPriority(aclrtStream stream, uint32_t *priority)
{
    return aclrtStreamGetPriorityImpl(stream, priority);
}

aclError aclrtStreamGetFlags(aclrtStream stream, uint32_t *flags)
{
    return aclrtStreamGetFlagsImpl(stream, flags);
}

aclError aclrtStreamWaitEvent(aclrtStream stream, aclrtEvent event)
{
    return aclrtStreamWaitEventImpl(stream, event);
}

aclError aclrtStreamWaitEventWithTimeout(aclrtStream stream, aclrtEvent event, int32_t timeout)
{
    return aclrtStreamWaitEventWithTimeoutImpl(stream, event, timeout);
}

aclError aclrtSetGroup(int32_t groupId)
{
    return aclrtSetGroupImpl(groupId);
}

aclError aclrtGetGroupCount(uint32_t *count)
{
    return aclrtGetGroupCountImpl(count);
}

aclrtGroupInfo *aclrtCreateGroupInfo()
{
    return aclrtCreateGroupInfoImpl();
}

aclError aclrtDestroyGroupInfo(aclrtGroupInfo *groupInfo)
{
    return aclrtDestroyGroupInfoImpl(groupInfo);
}

aclError aclrtGetAllGroupInfo(aclrtGroupInfo *groupInfo)
{
    return aclrtGetAllGroupInfoImpl(groupInfo);
}

aclError aclrtGetGroupInfoDetail(const aclrtGroupInfo *groupInfo, int32_t groupIndex, aclrtGroupAttr attr,
    void *attrValue, size_t valueLen, size_t *paramRetSize)
{
    return aclrtGetGroupInfoDetailImpl(groupInfo, groupIndex, attr, attrValue, valueLen, paramRetSize);
}

aclError aclrtDeviceCanAccessPeer(int32_t *canAccessPeer, int32_t deviceId, int32_t peerDeviceId)
{
    return aclrtDeviceCanAccessPeerImpl(canAccessPeer, deviceId, peerDeviceId);
}

aclError aclrtDeviceEnablePeerAccess(int32_t peerDeviceId, uint32_t flags)
{
    return aclrtDeviceEnablePeerAccessImpl(peerDeviceId, flags);
}

aclError aclrtDeviceDisablePeerAccess(int32_t peerDeviceId)
{
    return aclrtDeviceDisablePeerAccessImpl(peerDeviceId);
}

aclError aclrtGetMemInfo(aclrtMemAttr attr, size_t *free, size_t *total)
{
    return aclrtGetMemInfoImpl(attr, free, total);
}

aclError aclrtGetMemUsageInfo(int32_t deviceId, aclrtMemUsageInfo *memUsageInfo, size_t inputNum, size_t *outputNum)
{
    return aclrtGetMemUsageInfoImpl(deviceId, memUsageInfo, inputNum, outputNum);
}

aclError aclrtSetOpWaitTimeout(uint32_t timeout)
{
    return aclrtSetOpWaitTimeoutImpl(timeout);
}

aclError aclrtSetOpExecuteTimeOut(uint32_t timeout)
{
    return aclrtSetOpExecuteTimeOutImpl(timeout);
}

aclError aclrtSetOpExecuteTimeOutWithMs(uint32_t timeout)
{
    return aclrtSetOpExecuteTimeOutWithMsImpl(timeout);
}

aclError aclrtSetOpExecuteTimeOutV2(uint64_t timeout, uint64_t *actualTimeout)
{
    return aclrtSetOpExecuteTimeOutV2Impl(timeout, actualTimeout);
}

aclError aclrtGetOpTimeOutInterval(uint64_t *interval)
{
    return aclrtGetOpTimeOutIntervalImpl(interval);
}

aclError aclrtSetStreamOverflowSwitch(aclrtStream stream, uint32_t flag)
{
    return aclrtSetStreamOverflowSwitchImpl(stream, flag);
}

aclError aclrtGetStreamOverflowSwitch(aclrtStream stream, uint32_t *flag)
{
    return aclrtGetStreamOverflowSwitchImpl(stream, flag);
}

aclError aclrtSetDeviceSatMode(aclrtFloatOverflowMode mode)
{
    return aclrtSetDeviceSatModeImpl(mode);
}

aclError aclrtGetDeviceSatMode(aclrtFloatOverflowMode *mode)
{
    return aclrtGetDeviceSatModeImpl(mode);
}

aclError aclrtGetOverflowStatus(void *outputAddr, size_t outputSize, aclrtStream stream)
{
    return aclrtGetOverflowStatusImpl(outputAddr, outputSize, stream);
}

aclError aclrtResetOverflowStatus(aclrtStream stream)
{
    return aclrtResetOverflowStatusImpl(stream);
}

aclError aclrtQueryDeviceStatus(int32_t deviceId, aclrtDeviceStatus *deviceStatus)
{
    return aclrtQueryDeviceStatusImpl(deviceId, deviceStatus);
}

aclrtBinary aclrtCreateBinary(const void *data, size_t dataLen)
{
    return aclrtCreateBinaryImpl(data, dataLen);
}

aclError aclrtDestroyBinary(aclrtBinary binary)
{
    return aclrtDestroyBinaryImpl(binary);
}

aclError aclrtBinaryLoad(const aclrtBinary binary, aclrtBinHandle *binHandle)
{
    return aclrtBinaryLoadImpl(binary, binHandle);
}

aclError aclrtBinaryUnLoad(aclrtBinHandle binHandle)
{
    return aclrtBinaryUnLoadImpl(binHandle);
}

aclError aclrtBinaryGetFunction(const aclrtBinHandle binHandle, const char *kernelName, aclrtFuncHandle *funcHandle)
{
    return aclrtBinaryGetFunctionImpl(binHandle, kernelName, funcHandle);
}

aclError aclrtLaunchKernel(aclrtFuncHandle funcHandle, uint32_t blockDim, const void *argsData, size_t argsSize,
    aclrtStream stream)
{
    return aclrtLaunchKernelImpl(funcHandle, blockDim, argsData, argsSize, stream);
}

aclError aclrtMemGetAccess(void *virPtr, aclrtMemLocation *location, uint64_t *flag) 
{
    return aclrtMemGetAccessImpl(virPtr, location, flag);
}

aclError aclrtMemExportToShareableHandle(aclrtDrvMemHandle handle, aclrtMemHandleType handleType, uint64_t flags,
    uint64_t *shareableHandle)
{
    return aclrtMemExportToShareableHandleImpl(handle, handleType, flags, shareableHandle);
}


aclError aclrtMemExportToShareableHandleV2(aclrtDrvMemHandle handle, uint64_t flags, aclrtMemSharedHandleType shareType,
    void *shareableHandle)
{
    return aclrtMemExportToShareableHandleV2Impl(handle, flags, shareType, shareableHandle);
}

aclError aclrtMemImportFromShareableHandle(uint64_t shareableHandle, int32_t deviceId, aclrtDrvMemHandle *handle)
{
    return aclrtMemImportFromShareableHandleImpl(shareableHandle, deviceId, handle);
}

aclError aclrtMemImportFromShareableHandleV2(void *shareableHandle, aclrtMemSharedHandleType shareType,
    uint64_t flags, aclrtDrvMemHandle *handle)
{
    return aclrtMemImportFromShareableHandleV2Impl(shareableHandle, shareType, flags, handle);
}

aclError aclrtMemSetPidToShareableHandle(uint64_t shareableHandle, int32_t *pid, size_t pidNum)
{
    return aclrtMemSetPidToShareableHandleImpl(shareableHandle, pid, pidNum);
}

aclError aclrtMemSetPidToShareableHandleV2(void *shareableHandle, aclrtMemSharedHandleType shareType,
    int32_t *pid, size_t pidNum)
{
    return aclrtMemSetPidToShareableHandleV2Impl(shareableHandle, shareType, pid, pidNum);
}

aclError aclrtMemGetAllocationGranularity(aclrtPhysicalMemProp *prop, aclrtMemGranularityOptions option,
    size_t *granularity)
{
    return aclrtMemGetAllocationGranularityImpl(prop, option, granularity);
}

aclError aclrtDeviceGetBareTgid(int32_t *pid)
{
    return aclrtDeviceGetBareTgidImpl(pid);
}

aclError aclrtCmoAsync(void *src, size_t size, aclrtCmoType cmoType, aclrtStream stream)
{
    return aclrtCmoAsyncImpl(src, size, cmoType, stream);
}

aclError aclrtGetMemUceInfo(int32_t deviceId, aclrtMemUceInfo *memUceInfoArray, size_t arraySize, size_t *retSize)
{
    return aclrtGetMemUceInfoImpl(deviceId, memUceInfoArray, arraySize, retSize);
}

aclError aclrtDeviceTaskAbort(int32_t deviceId, uint32_t timeout)
{
    return aclrtDeviceTaskAbortImpl(deviceId, timeout);
}

aclError aclrtMemUceRepair(int32_t deviceId, aclrtMemUceInfo *memUceInfoArray, size_t arraySize)
{
    return aclrtMemUceRepairImpl(deviceId, memUceInfoArray, arraySize);
}

aclError aclrtStreamAbort(aclrtStream stream)
{
    return aclrtStreamAbortImpl(stream);
}

aclError aclrtBinaryLoadFromFile(const char* binPath, aclrtBinaryLoadOptions *options, aclrtBinHandle *binHandle)
{
    return aclrtBinaryLoadFromFileImpl(binPath, options, binHandle);
}

aclError aclrtBinaryGetDevAddress(const aclrtBinHandle binHandle, void **binAddr, size_t *binSize)
{
    return aclrtBinaryGetDevAddressImpl(binHandle, binAddr, binSize);
}

aclError aclrtBinaryGetFunctionByEntry(aclrtBinHandle binHandle, uint64_t funcEntry, aclrtFuncHandle *funcHandle)
{
    return aclrtBinaryGetFunctionByEntryImpl(binHandle, funcEntry, funcHandle);
}

aclError aclrtGetFunctionAddr(aclrtFuncHandle funcHandle, void **aicAddr, void **aivAddr)
{
    return aclrtGetFunctionAddrImpl(funcHandle, aicAddr, aivAddr);
}

aclError aclrtGetMemcpyDescSize(aclrtMemcpyKind kind, size_t *descSize)
{
    return aclrtGetMemcpyDescSizeImpl(kind, descSize);
}

aclError aclrtSetMemcpyDesc(void *desc, aclrtMemcpyKind kind, void *srcAddr, void *dstAddr, size_t count, void *config)
{
    return aclrtSetMemcpyDescImpl(desc, kind, srcAddr, dstAddr, count, config);
}

aclError aclrtMemcpyAsyncWithDesc(void *desc, aclrtMemcpyKind kind, aclrtStream stream)
{
    return aclrtMemcpyAsyncWithDescImpl(desc, kind, stream);
}

aclError aclrtMemcpyAsyncWithOffset(void **dst, size_t destMax, size_t dstDataOffset, const void **src,
    size_t count, size_t srcDataOffset, aclrtMemcpyKind kind, aclrtStream stream)
{
    return aclrtMemcpyAsyncWithOffsetImpl(dst, destMax, dstDataOffset, src, count, srcDataOffset, kind, stream);
}

aclError aclrtKernelArgsGetHandleMemSize(aclrtFuncHandle funcHandle, size_t *memSize)
{
    return aclrtKernelArgsGetHandleMemSizeImpl(funcHandle, memSize);
}

aclError aclrtKernelArgsGetMemSize(aclrtFuncHandle funcHandle, size_t userArgsSize, size_t *actualArgsSize)
{
    return aclrtKernelArgsGetMemSizeImpl(funcHandle, userArgsSize, actualArgsSize);
}

aclError aclrtKernelArgsInit(aclrtFuncHandle funcHandle, aclrtArgsHandle *argsHandle)
{
    return aclrtKernelArgsInitImpl(funcHandle, argsHandle);
}

aclError aclrtKernelArgsInitByUserMem(aclrtFuncHandle funcHandle, aclrtArgsHandle argsHandle, void *userHostMem,
    size_t actualArgsSize)
{
    return aclrtKernelArgsInitByUserMemImpl(funcHandle, argsHandle, userHostMem, actualArgsSize);
}

aclError aclrtKernelArgsAppend(aclrtArgsHandle argsHandle, void *param, size_t paramSize,
    aclrtParamHandle *paramHandle)
{
    return aclrtKernelArgsAppendImpl(argsHandle, param, paramSize, paramHandle);
}

aclError aclrtKernelArgsAppendPlaceHolder(aclrtArgsHandle argsHandle, aclrtParamHandle *paramHandle)
{
    return aclrtKernelArgsAppendPlaceHolderImpl(argsHandle, paramHandle);
}

aclError aclrtKernelArgsGetPlaceHolderBuffer(aclrtArgsHandle argsHandle, aclrtParamHandle paramHandle,
    size_t dataSize, void **bufferAddr)
{
    return aclrtKernelArgsGetPlaceHolderBufferImpl(argsHandle, paramHandle, dataSize, bufferAddr);
}

aclError aclrtKernelArgsParaUpdate(aclrtArgsHandle argsHandle, aclrtParamHandle paramHandle, void *param,
    size_t paramSize)
{
    return aclrtKernelArgsParaUpdateImpl(argsHandle, paramHandle, param, paramSize);
}

aclError aclrtLaunchKernelWithConfig(aclrtFuncHandle funcHandle, uint32_t blockDim, aclrtStream stream,
    aclrtLaunchKernelCfg *cfg, aclrtArgsHandle argsHandle, void *reserve)
{
    return aclrtLaunchKernelWithConfigImpl(funcHandle, blockDim, stream, cfg, argsHandle, reserve);
}

aclError aclrtKernelArgsFinalize(aclrtArgsHandle argsHandle)
{
    return aclrtKernelArgsFinalizeImpl(argsHandle);
}

aclError aclrtValueWrite(void* devAddr, uint64_t value, uint32_t flag, aclrtStream stream)
{
    return aclrtValueWriteImpl(devAddr, value, flag, stream);
}

aclError aclrtValueWait(void* devAddr, uint64_t value, uint32_t flag, aclrtStream stream)
{
    return aclrtValueWaitImpl(devAddr, value, flag, stream);
}

aclError aclrtGetStreamAvailableNum(uint32_t *streamCount)
{
    return aclrtGetStreamAvailableNumImpl(streamCount);
}

aclError aclrtSetStreamAttribute(aclrtStream stream, aclrtStreamAttr stmAttrType, aclrtStreamAttrValue *value)
{
    return aclrtSetStreamAttributeImpl(stream, stmAttrType, value);
}

aclError aclrtGetStreamAttribute(aclrtStream stream, aclrtStreamAttr stmAttrType, aclrtStreamAttrValue *value)
{
    return aclrtGetStreamAttributeImpl(stream, stmAttrType, value);
}

aclError aclrtCreateNotify(aclrtNotify *notify, uint64_t flag)
{
    return aclrtCreateNotifyImpl(notify, flag);
}

aclError aclrtCntNotifyCreate(aclrtCntNotify *cntNotify, uint64_t flag) 
{
    return aclrtCntNotifyCreateImpl(cntNotify, flag);
}

aclError aclrtCntNotifyDestroy(aclrtCntNotify cntNotify)
{
    return aclrtCntNotifyDestroyImpl(cntNotify);
}

aclError aclrtDestroyNotify(aclrtNotify notify)
{
    return aclrtDestroyNotifyImpl(notify);
}

aclError aclrtRecordNotify(aclrtNotify notify, aclrtStream stream)
{
    return aclrtRecordNotifyImpl(notify, stream);
}

aclError aclrtWaitAndResetNotify(aclrtNotify notify, aclrtStream stream, uint32_t timeout)
{
    return aclrtWaitAndResetNotifyImpl(notify, stream, timeout);
}

aclError aclrtGetNotifyId(aclrtNotify notify, uint32_t *notifyId)
{
    return aclrtGetNotifyIdImpl(notify, notifyId);
}

aclError aclrtGetEventId(aclrtEvent event, uint32_t *eventId)
{
    return aclrtGetEventIdImpl(event, eventId);
}

aclError aclrtGetEventAvailNum(uint32_t *eventCount)
{
    return aclrtGetEventAvailNumImpl(eventCount);
}

aclError aclrtGetDeviceInfo(uint32_t deviceId, aclrtDevAttr attr, int64_t *value)
{
    return aclrtGetDeviceInfoImpl(deviceId, attr, value);
}

aclError aclrtDeviceGetStreamPriorityRange(int32_t *leastPriority, int32_t *greatestPriority)
{
    return aclrtDeviceGetStreamPriorityRangeImpl(leastPriority, greatestPriority);
}

aclError aclrtGetDeviceCapability(int32_t deviceId, aclrtDevFeatureType devFeatureType, int32_t *value)
{
    return aclrtGetDeviceCapabilityImpl(deviceId, devFeatureType, value);
}

aclError aclrtDeviceGetUuid(int32_t deviceId, aclrtUuid *uuid)
{
    return aclrtDeviceGetUuidImpl(deviceId, uuid);
}

aclError aclrtCtxGetCurrentDefaultStream(aclrtStream *stream)
{
    return aclrtCtxGetCurrentDefaultStreamImpl(stream);
}

aclError aclrtGetPrimaryCtxState(int32_t deviceId, uint32_t *flags, int32_t *active)
{
    return aclrtGetPrimaryCtxStateImpl(deviceId, flags, active);
}

aclError aclrtReduceAsync(void *dst, const void *src, uint64_t count, aclrtReduceKind kind, aclDataType type,
    aclrtStream stream, void *reserve)
{
    return aclrtReduceAsyncImpl(dst, src, count, kind, type, stream, reserve);
}

aclError aclrtSetDeviceWithoutTsdVXX(int32_t deviceId)
{
    return aclrtSetDeviceWithoutTsdVXXImpl(deviceId);
}

aclError aclrtResetDeviceWithoutTsdVXX(int32_t deviceId)
{
    return aclrtResetDeviceWithoutTsdVXXImpl(deviceId);
}

const char *aclrtGetSocName()
{
    return aclrtGetSocNameImpl();
}

aclError aclrtGetDeviceResLimit(int32_t deviceId, aclrtDevResLimitType type, uint32_t *value)
{
    return aclrtGetDeviceResLimitImpl(deviceId, type, value);
}

aclError aclrtSetDeviceResLimit(int32_t deviceId, aclrtDevResLimitType type, uint32_t value)
{
    return aclrtSetDeviceResLimitImpl(deviceId, type, value);
}

aclError aclrtResetDeviceResLimit(int32_t deviceId)
{
    return aclrtResetDeviceResLimitImpl(deviceId);
}

aclError aclrtGetStreamResLimit(aclrtStream stream, aclrtDevResLimitType type, uint32_t *value)
{
    return aclrtGetStreamResLimitImpl(stream, type, value);
}

aclError aclrtSetStreamResLimit(aclrtStream stream, aclrtDevResLimitType type, uint32_t value)
{
    return aclrtSetStreamResLimitImpl(stream, type, value);
}

aclError aclrtResetStreamResLimit(aclrtStream stream)
{
    return aclrtResetStreamResLimitImpl(stream);
}

aclError aclrtUseStreamResInCurrentThread(aclrtStream stream)
{
    return aclrtUseStreamResInCurrentThreadImpl(stream);
}

aclError aclrtUnuseStreamResInCurrentThread(aclrtStream stream)
{
    return aclrtUnuseStreamResInCurrentThreadImpl(stream);
}

aclError aclrtGetResInCurrentThread(aclrtDevResLimitType type, uint32_t *value)
{
    return aclrtGetResInCurrentThreadImpl(type, value);
}

aclError aclrtCreateLabel(aclrtLabel *label)
{
    return aclrtCreateLabelImpl(label);
}

aclError aclrtSetLabel(aclrtLabel label, aclrtStream stream)
{
    return aclrtSetLabelImpl(label, stream);
}

aclError aclrtDestroyLabel(aclrtLabel label)
{
    return aclrtDestroyLabelImpl(label);
}

aclError aclrtCreateLabelList(aclrtLabel *labels, size_t num, aclrtLabelList *labelList)
{
    return aclrtCreateLabelListImpl(labels, num, labelList);
}

aclError aclrtDestroyLabelList(aclrtLabelList labelList)
{
    return aclrtDestroyLabelListImpl(labelList);
}

aclError aclrtSwitchLabelByIndex(void *ptr, uint32_t maxValue, aclrtLabelList labelList, aclrtStream stream)
{
    return aclrtSwitchLabelByIndexImpl(ptr, maxValue, labelList, stream);
}

aclError aclrtActiveStream(aclrtStream activeStream, aclrtStream stream)
{
    return aclrtActiveStreamImpl(activeStream, stream);
}

aclError aclrtSwitchStream(void *leftValue, aclrtCondition cond, void *rightValue, aclrtCompareDataType dataType,
    aclrtStream trueStream, aclrtStream falseStream, aclrtStream stream)
{
    return aclrtSwitchStreamImpl(leftValue, cond, rightValue, dataType, trueStream, falseStream, stream);
}

aclError aclrtGetFunctionName(aclrtFuncHandle funcHandle, uint32_t maxLen, char *name)
{
    return aclrtGetFunctionNameImpl(funcHandle, maxLen, name);
}

aclError aclrtGetBufFromChain(aclrtMbuf headBuf, uint32_t index, aclrtMbuf *buf)
{
    return aclrtGetBufFromChainImpl(headBuf, index, buf);
}

aclError aclrtGetBufChainNum(aclrtMbuf headBuf, uint32_t *num)
{
    return aclrtGetBufChainNumImpl(headBuf, num);
}

aclError aclrtAppendBufChain(aclrtMbuf headBuf, aclrtMbuf buf)
{
    return aclrtAppendBufChainImpl(headBuf, buf);
}

aclError aclrtCopyBufRef(const aclrtMbuf buf, aclrtMbuf *newBuf)
{
    return aclrtCopyBufRefImpl(buf, newBuf);
}

aclError aclrtGetBufUserData(const aclrtMbuf buf, void *dataPtr, size_t size, size_t offset)
{
    return aclrtGetBufUserDataImpl(buf, dataPtr, size, offset);
}

aclError aclrtSetBufUserData(aclrtMbuf buf, const void *dataPtr, size_t size, size_t offset)
{
    return aclrtSetBufUserDataImpl(buf, dataPtr, size, offset);
}

aclError aclrtGetBufData(const aclrtMbuf buf, void **dataPtr, size_t *size)
{
    return aclrtGetBufDataImpl(buf, dataPtr, size);
}

aclError aclrtGetBufDataLen(aclrtMbuf buf, size_t *len)
{
    return aclrtGetBufDataLenImpl(buf, len);
}

aclError aclrtSetBufDataLen(aclrtMbuf buf, size_t len)
{
    return aclrtSetBufDataLenImpl(buf, len);
}

aclError aclrtFreeBuf(aclrtMbuf buf)
{
    return aclrtFreeBufImpl(buf);
}

aclError aclrtAllocBuf(aclrtMbuf *buf, size_t size)
{
    return aclrtAllocBufImpl(buf, size);
}

aclError aclrtBinaryLoadFromData(const void *data, size_t length,
    const aclrtBinaryLoadOptions *options, aclrtBinHandle *binHandle)
{
    return aclrtBinaryLoadFromDataImpl(data, length, options, binHandle);
}

aclError aclrtRegisterCpuFunc(const aclrtBinHandle handle, const char *funcName,
    const char *kernelName, aclrtFuncHandle *funcHandle)
{
    return aclrtRegisterCpuFuncImpl(handle, funcName, kernelName, funcHandle);
}

aclError aclrtCmoAsyncWithBarrier(void *src, size_t size, aclrtCmoType cmoType, uint32_t barrierId,
    aclrtStream stream)
{
    return aclrtCmoAsyncWithBarrierImpl(src, size, cmoType, barrierId, stream);
}

aclError aclrtCmoWaitBarrier(aclrtBarrierTaskInfo *taskInfo, aclrtStream stream, uint32_t flag)
{
    return aclrtCmoWaitBarrierImpl(taskInfo, stream, flag);
}

aclError aclrtGetDevicesTopo(uint32_t deviceId, uint32_t otherDeviceId, uint64_t *value)
{
    return aclrtGetDevicesTopoImpl(deviceId, otherDeviceId, value);
}

aclError aclrtMemcpyBatch(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t numBatches,
    aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs, size_t *failIndex)
{
    return aclrtMemcpyBatchImpl(dsts, destMaxs, srcs, sizes, numBatches, attrs, attrsIndexes, numAttrs, failIndex);
}

aclError aclrtMemcpyBatchAsync(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes,
    size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs, size_t *failIndex,
    aclrtStream stream)
{
    return aclrtMemcpyBatchAsyncImpl(dsts, destMaxs, srcs, sizes, numBatches, attrs, attrsIndexes, numAttrs, failIndex,
        stream);
}

aclError aclrtIpcMemGetExportKey(void *devPtr, size_t size, char *key, size_t len, uint64_t flags)
{
    return aclrtIpcMemGetExportKeyImpl(devPtr, size, key, len, flags);
}

aclError aclrtIpcMemClose(const char *key)
{
    return aclrtIpcMemCloseImpl(key);
}

aclError aclrtIpcMemImportByKey(void **devPtr, const char *key, uint64_t flags)
{
    return aclrtIpcMemImportByKeyImpl(devPtr, key, flags);
}

aclError aclrtIpcMemSetImportPid(const char *key, int32_t *pid, size_t num)
{
    return aclrtIpcMemSetImportPidImpl(key, pid, num);
}

aclError aclrtIpcMemSetAttr(const char *key, aclrtIpcMemAttrType type, uint64_t attr)
{
    return aclrtIpcMemSetAttrImpl(key, type, attr);
}

aclError aclrtIpcMemImportPidInterServer(const char *key, aclrtServerPid *serverPids, size_t num)
{
    return aclrtIpcMemImportPidInterServerImpl(key, serverPids, num);
}

aclError aclrtNotifySetImportPidInterServer(aclrtNotify notify, aclrtServerPid *serverPids, size_t num)
{
    return aclrtNotifySetImportPidInterServerImpl(notify, serverPids, num);
}

aclError aclrtNotifyBatchReset(aclrtNotify *notifies, size_t num)
{
    return aclrtNotifyBatchResetImpl(notifies, num);
}

aclError aclrtNotifyGetExportKey(aclrtNotify notify, char *key, size_t len, uint64_t flags)
{
    return aclrtNotifyGetExportKeyImpl(notify, key, len, flags);
}

aclError aclrtNotifyImportByKey(aclrtNotify *notify, const char *key, uint64_t flags)
{
    return aclrtNotifyImportByKeyImpl(notify, key, flags);
}

aclError aclrtNotifySetImportPid(aclrtNotify notify, int32_t *pid, size_t num)
{
    return aclrtNotifySetImportPidImpl(notify, pid, num);
}

aclError aclmdlRIExecuteAsync(aclmdlRI modelRI, aclrtStream stream)
{
    return aclmdlRIExecuteAsyncImpl(modelRI, stream);
}

aclError aclmdlRIDestroy(aclmdlRI modelRI)
{
    return aclmdlRIDestroyImpl(modelRI);
}

aclError aclmdlRICaptureBegin(aclrtStream stream, aclmdlRICaptureMode mode)
{
    return aclmdlRICaptureBeginImpl(stream, mode);
}

aclError aclmdlRICaptureGetInfo(aclrtStream stream, aclmdlRICaptureStatus *status, aclmdlRI *modelRI)
{
    return aclmdlRICaptureGetInfoImpl(stream, status, modelRI);
}

aclError aclmdlRICaptureEnd(aclrtStream stream, aclmdlRI *modelRI)
{
    return aclmdlRICaptureEndImpl(stream, modelRI);
}

aclError aclmdlRIDebugPrint(aclmdlRI modelRI)
{
    return aclmdlRIDebugPrintImpl(modelRI);
}

aclError aclmdlRIDebugJsonPrint(aclmdlRI modelRI, const char *path, uint32_t flags)
{
    return aclmdlRIDebugJsonPrintImpl(modelRI, path, flags);
}

aclError aclmdlRICaptureThreadExchangeMode(aclmdlRICaptureMode *mode)
{
    return aclmdlRICaptureThreadExchangeModeImpl(mode);
}

aclError aclmdlRICaptureTaskGrpBegin(aclrtStream stream)
{
    return aclmdlRICaptureTaskGrpBeginImpl(stream);
}

aclError aclmdlRICaptureTaskGrpEnd(aclrtStream stream, aclrtTaskGrp *handle)
{
    return aclmdlRICaptureTaskGrpEndImpl(stream, handle);
}

aclError aclmdlRICaptureTaskUpdateBegin(aclrtStream stream, aclrtTaskGrp handle)
{
    return aclmdlRICaptureTaskUpdateBeginImpl(stream, handle);
}

aclError aclmdlRICaptureTaskUpdateEnd(aclrtStream stream)
{
    return aclmdlRICaptureTaskUpdateEndImpl(stream);
}

aclError aclmdlRIBuildBegin(aclmdlRI *modelRI, uint32_t flag)
{
    return aclmdlRIBuildBeginImpl(modelRI, flag);
}

aclError aclmdlRIBindStream(aclmdlRI modelRI, aclrtStream stream, uint32_t flag)
{
    return aclmdlRIBindStreamImpl(modelRI, stream, flag);
}

aclError aclmdlRIEndTask(aclmdlRI modelRI, aclrtStream stream)
{
    return aclmdlRIEndTaskImpl(modelRI, stream);
}

aclError aclmdlRIBuildEnd(aclmdlRI modelRI, void *reserve)
{
    return aclmdlRIBuildEndImpl(modelRI, reserve);
}

aclError aclmdlRIUnbindStream(aclmdlRI modelRI, aclrtStream stream)
{
    return aclmdlRIUnbindStreamImpl(modelRI, stream);
}

aclError aclmdlRIExecute(aclmdlRI modelRI, int32_t timeout)
{
    return aclmdlRIExecuteImpl(modelRI, timeout);
}

aclError aclmdlRISetName(aclmdlRI modelRI, const char *name)
{
    return aclmdlRISetNameImpl(modelRI, name);
}

aclError aclmdlRIGetName(aclmdlRI modelRI, uint32_t maxLen, char *name)
{
    return aclmdlRIGetNameImpl(modelRI, maxLen, name);
}

aclError aclmdlInitDump()
{
    return aclmdlInitDumpImpl();
}

aclError aclmdlSetDump(const char *dumpCfgPath)
{
    return aclmdlSetDumpImpl(dumpCfgPath);
}

aclError aclmdlFinalizeDump()
{
    return aclmdlFinalizeDumpImpl();
}

size_t aclDataTypeSize(aclDataType dataType)
{
    return aclDataTypeSizeImpl(dataType);
}

aclDataBuffer *aclCreateDataBuffer(void *data, size_t size)
{
    return aclCreateDataBufferImpl(data, size);
}

aclError aclDestroyDataBuffer(const aclDataBuffer *dataBuffer)
{
    return aclDestroyDataBufferImpl(dataBuffer);
}

aclError aclUpdateDataBuffer(aclDataBuffer *dataBuffer, void *data, size_t size)
{
    return aclUpdateDataBufferImpl(dataBuffer, data, size);
}

void *aclGetDataBufferAddr(const aclDataBuffer *dataBuffer)
{
    return aclGetDataBufferAddrImpl(dataBuffer);
}

uint32_t aclGetDataBufferSize(const aclDataBuffer *dataBuffer)
{
    return aclGetDataBufferSizeImpl(dataBuffer);
}

size_t aclGetDataBufferSizeV2(const aclDataBuffer *dataBuffer)
{
    return aclGetDataBufferSizeV2Impl(dataBuffer);
}

aclrtAllocatorDesc aclrtAllocatorCreateDesc()
{
    return aclrtAllocatorCreateDescImpl();
}

aclError aclrtAllocatorDestroyDesc(aclrtAllocatorDesc allocatorDesc)
{
    return aclrtAllocatorDestroyDescImpl(allocatorDesc);
}

aclError aclrtAllocatorSetObjToDesc(aclrtAllocatorDesc allocatorDesc, aclrtAllocator allocator)
{
    return aclrtAllocatorSetObjToDescImpl(allocatorDesc, allocator);
}

aclError aclrtAllocatorSetAllocFuncToDesc(aclrtAllocatorDesc allocatorDesc, aclrtAllocatorAllocFunc func)
{
    return aclrtAllocatorSetAllocFuncToDescImpl(allocatorDesc, func);
}

aclError aclrtAllocatorSetFreeFuncToDesc(aclrtAllocatorDesc allocatorDesc, aclrtAllocatorFreeFunc func)
{
    return aclrtAllocatorSetFreeFuncToDescImpl(allocatorDesc, func);
}

aclError aclrtAllocatorSetAllocAdviseFuncToDesc(aclrtAllocatorDesc allocatorDesc, aclrtAllocatorAllocAdviseFunc func)
{
    return aclrtAllocatorSetAllocAdviseFuncToDescImpl(allocatorDesc, func);
}

aclError aclrtAllocatorSetGetAddrFromBlockFuncToDesc(aclrtAllocatorDesc allocatorDesc,
                                                     aclrtAllocatorGetAddrFromBlockFunc func)
{
    return aclrtAllocatorSetGetAddrFromBlockFuncToDescImpl(allocatorDesc, func);
}

aclError aclrtAllocatorRegister(aclrtStream stream, aclrtAllocatorDesc allocatorDesc)
{
    return aclrtAllocatorRegisterImpl(stream, allocatorDesc);
}

aclError aclrtAllocatorGetByStream(aclrtStream stream,
                                   aclrtAllocatorDesc *allocatorDesc,
                                   aclrtAllocator *allocator,
                                   aclrtAllocatorAllocFunc *allocFunc,
                                   aclrtAllocatorFreeFunc *freeFunc,
                                   aclrtAllocatorAllocAdviseFunc *allocAdviseFunc,
                                   aclrtAllocatorGetAddrFromBlockFunc *getAddrFromBlockFunc)
{
    return aclrtAllocatorGetByStreamImpl(stream, allocatorDesc, allocator, allocFunc, freeFunc, allocAdviseFunc, getAddrFromBlockFunc);
}

aclError aclrtAllocatorUnregister(aclrtStream stream)
{
    return aclrtAllocatorUnregisterImpl(stream);
}

aclError aclrtGetVersion(int32_t *majorVersion, int32_t *minorVersion, int32_t *patchVersion)
{
    return aclrtGetVersionImpl(majorVersion, minorVersion, patchVersion);
}

aclError aclInitCallbackRegister(aclRegisterCallbackType type, aclInitCallbackFunc cbFunc, void *userData)
{
    return aclInitCallbackRegisterImpl(type, cbFunc, userData);
}

aclError aclInitCallbackUnRegister(aclRegisterCallbackType type, aclInitCallbackFunc cbFunc)
{
    return aclInitCallbackUnRegisterImpl(type, cbFunc);
}

aclError aclFinalizeCallbackRegister(aclRegisterCallbackType type, aclFinalizeCallbackFunc cbFunc, void *userData)
{
    return aclFinalizeCallbackRegisterImpl(type, cbFunc, userData);
}

aclError aclFinalizeCallbackUnRegister(aclRegisterCallbackType type, aclFinalizeCallbackFunc cbFunc)
{
    return aclFinalizeCallbackUnRegisterImpl(type, cbFunc);
}

aclError aclrtCheckMemType(void** addrList, uint32_t size, uint32_t memType, uint32_t *checkResult, uint32_t reserve)
{
    return aclrtCheckMemTypeImpl(addrList, size, memType, checkResult, reserve);
}

aclError aclrtGetLogicDevIdByUserDevId(const int32_t userDevid, int32_t *const logicDevId)
{
    return aclrtGetLogicDevIdByUserDevIdImpl(userDevid, logicDevId);
}

aclError aclrtGetUserDevIdByLogicDevId(const int32_t logicDevId, int32_t *const userDevid)
{
    return aclrtGetUserDevIdByLogicDevIdImpl(logicDevId, userDevid);
}

aclError aclrtGetLogicDevIdByPhyDevId(int32_t phyDevId, int32_t *const logicDevId)
{
    return aclrtGetLogicDevIdByPhyDevIdImpl(phyDevId, logicDevId);
}

aclError aclrtGetPhyDevIdByLogicDevId(int32_t logicDevId, int32_t *const phyDevId)
{
    return aclrtGetPhyDevIdByLogicDevIdImpl(logicDevId, phyDevId);
}

aclError aclrtProfTrace(void *userdata, int32_t length, aclrtStream stream)
{
    return aclrtProfTraceImpl(userdata, length, stream);
}

aclError aclrtLaunchKernelV2(aclrtFuncHandle funcHandle, uint32_t blockDim, const void *argsData, size_t argsSize,
    aclrtLaunchKernelCfg *cfg, aclrtStream stream)
{
    return aclrtLaunchKernelV2Impl(funcHandle, blockDim, argsData, argsSize, cfg, stream);
}

aclError aclrtLaunchKernelWithHostArgs(aclrtFuncHandle funcHandle, uint32_t blockDim, aclrtStream stream,
                                       aclrtLaunchKernelCfg *cfg, void *hostArgs, size_t argsSize,
                                       aclrtPlaceHolderInfo *placeHolderArray, size_t placeHolderNum)
{
    return aclrtLaunchKernelWithHostArgsImpl(funcHandle, blockDim, stream, cfg, hostArgs, argsSize,
                                             placeHolderArray, placeHolderNum);
}

aclError aclrtCtxGetFloatOverflowAddr(void **overflowAddr)
{
    return aclrtCtxGetFloatOverflowAddrImpl(overflowAddr);
}

aclError aclrtGetFloatOverflowStatus(void *outputAddr, uint64_t outputSize, aclrtStream stream)
{
    return aclrtGetFloatOverflowStatusImpl(outputAddr, outputSize, stream);
}

aclError aclrtResetFloatOverflowStatus(aclrtStream stream)
{
    return aclrtResetFloatOverflowStatusImpl(stream);
}

aclError aclrtNpuGetFloatOverFlowStatus(void *outputAddr, uint64_t outputSize, uint32_t checkMode, aclrtStream stream)
{
    return aclrtNpuGetFloatOverFlowStatusImpl(outputAddr, outputSize, checkMode, stream);
}

aclError aclrtNpuClearFloatOverFlowStatus(uint32_t checkMode, aclrtStream stream)
{
    return aclrtNpuClearFloatOverFlowStatusImpl(checkMode, stream);
}

aclError aclInit(const char *configPath)
{
    return aclInitImpl(configPath);
}

aclError aclFinalize()
{
    return aclFinalizeImpl();
}

aclError aclFinalizeReference(uint64_t *refCount)
{
    return aclFinalizeReferenceImpl(refCount);
}

aclError aclsysGetCANNVersion(aclCANNPackageName name, aclCANNPackageVersion *version)
{
    return aclsysGetCANNVersionImpl(name, version);
}

aclError aclsysGetVersionStr(char *pkgName, char *versionStr)
{
    return aclsysGetVersionStrImpl(pkgName, versionStr);
}

aclError aclsysGetVersionNum(char *pkgName, int32_t *versionNum)
{
    return aclsysGetVersionNumImpl(pkgName, versionNum);
}

const char *aclGetRecentErrMsg()
{
    return aclGetRecentErrMsgImpl();
}

aclError aclGetCannAttributeList(const aclCannAttr **cannAttrList, size_t *num)
{
    return aclGetCannAttributeListImpl(cannAttrList, num);
}

aclError aclGetCannAttribute(aclCannAttr cannAttr, int32_t *value)
{
    return aclGetCannAttributeImpl(cannAttr, value);
}

aclError aclGetDeviceCapability(uint32_t deviceId, aclDeviceInfo deviceInfo, int64_t *value)
{
    return aclGetDeviceCapabilityImpl(deviceId, deviceInfo, value);
}

float aclFloat16ToFloat(aclFloat16 value)
{
    return aclFloat16ToFloatImpl(value);
}

aclFloat16 aclFloatToFloat16(float value)
{
    return aclFloatToFloat16Impl(value);
}

aclError aclrtGetHardwareSyncAddr(void **addr)
{
    return aclrtGetHardwareSyncAddrImpl(addr);
}
 
 aclError aclrtRandomNumAsync(const aclrtRandomNumTaskInfo *taskInfo, const aclrtStream stream, void *reserve)
{
    return aclrtRandomNumAsyncImpl(taskInfo, stream, reserve);
}

 aclError aclrtRegStreamStateCallback(const char *regName, aclrtStreamStateCallback callback, void *args)
{
    return aclrtRegStreamStateCallbackImpl(regName, callback, args);
}

aclError aclrtRegDeviceStateCallback(const char *regName, aclrtDeviceStateCallback callback, void *args)
{
    return aclrtRegDeviceStateCallbackImpl(regName, callback, args);
}

aclError aclrtSetDeviceTaskAbortCallback(const char *regName, aclrtDeviceTaskAbortCallback callback, void *args)
{
    return aclrtSetDeviceTaskAbortCallbackImpl(regName, callback, args);
}

aclError aclrtGetOpExecuteTimeout(uint32_t *const timeoutMs)
{
    return aclrtGetOpExecuteTimeoutImpl(timeoutMs);
}

aclError aclrtDevicePeerAccessStatus(int32_t deviceId, int32_t peerDeviceId, int32_t *status)
{
    return aclrtDevicePeerAccessStatusImpl(deviceId, peerDeviceId, status);
}

aclError aclrtStreamStop(aclrtStream stream)
{
    return aclrtStreamStopImpl(stream);
}

aclError aclrtTaskUpdateAsync(aclrtStream taskStream, uint32_t taskId, aclrtTaskUpdateInfo *info, aclrtStream execStream)
{
    return aclrtTaskUpdateAsyncImpl(taskStream, taskId, info, execStream);
}

void aclAppLog(aclLogLevel logLevel, const char *func, const char *file, uint32_t line, const char *fmt, ...)
{
    va_list args;
    va_start(args, fmt);
    aclAppLogImpl(logLevel, func, file, line, fmt, args);
    va_end(args);
}

extern "C" ACL_FUNC_VISIBILITY void aclAppLogWithArgs(aclLogLevel logLevel, const char *func, const char *file, uint32_t line, const char *fmt, va_list args)
{
    aclAppLogImpl(logLevel, func, file, line, fmt, args);
}

aclError aclrtLaunchHostFunc(aclrtStream stream, aclrtHostFunc fn, void *args)
{
    return aclrtLaunchHostFuncImpl(stream, fn, args);
}

aclError aclrtCmoGetDescSize(size_t *size)
{
    return aclrtCmoGetDescSizeImpl(size);
}

aclError aclrtCmoSetDesc(void *cmoDesc, void *src, size_t size)
{
    return aclrtCmoSetDescImpl(cmoDesc, src, size);
}

aclError aclrtCmoAsyncWithDesc(void *cmoDesc, aclrtCmoType cmoType, aclrtStream stream, const void *reserve)
{
    return aclrtCmoAsyncWithDescImpl(cmoDesc, cmoType, stream, reserve);
}

aclError aclrtCheckArchCompatibility(const char *socVersion, int32_t *canCompatible)
{
    return aclrtCheckArchCompatibilityImpl(socVersion, canCompatible);
}

aclError aclmdlRIAbort(aclmdlRI modelRI)
{
    return aclmdlRIAbortImpl(modelRI);
}

aclError aclrtCntNotifyRecord(aclrtCntNotify cntNotify, aclrtStream stream,
    aclrtCntNotifyRecordInfo *info)
{
    return aclrtCntNotifyRecordImpl(cntNotify, stream, info);
}

aclError aclrtCntNotifyWaitWithTimeout(aclrtCntNotify cntNotify, aclrtStream stream,
    aclrtCntNotifyWaitInfo *info)
{
    return aclrtCntNotifyWaitWithTimeoutImpl(cntNotify, stream, info);
}

aclError aclrtCntNotifyReset(aclrtCntNotify cntNotify, aclrtStream stream)
{
    return aclrtCntNotifyResetImpl(cntNotify, stream);
}

aclError aclrtCntNotifyGetId(aclrtCntNotify cntNotify, uint32_t *notifyId)
{
    return aclrtCntNotifyGetIdImpl(cntNotify, notifyId);
}

aclError aclrtPersistentTaskClean(aclrtStream stream)
{
    return aclrtPersistentTaskCleanImpl(stream);
}

aclError aclrtGetErrorVerbose(int32_t deviceId, aclrtErrorInfo *errorInfo) 
{
    return aclrtGetErrorVerboseImpl(deviceId, errorInfo); 
}

aclError aclrtRepairError(int32_t deviceId, const aclrtErrorInfo *errorInfo) 
{
    return aclrtRepairErrorImpl(deviceId, errorInfo); 
}

aclError aclrtMemSetAccess(void *virPtr, size_t size, aclrtMemAccessDesc *desc, size_t count)
{
    return aclrtMemSetAccessImpl(virPtr, size, desc, count);
}

aclError aclrtSnapShotProcessLock()
{
    return aclrtSnapShotProcessLockImpl();
}

aclError aclrtSnapShotProcessUnlock()
{
    return aclrtSnapShotProcessUnlockImpl();
}

aclError aclrtSnapShotProcessBackup()
{
    return aclrtSnapShotProcessBackupImpl();
}

aclError aclrtSnapShotProcessRestore()
{
    return aclrtSnapShotProcessRestoreImpl();
}

aclError aclrtCacheLastTaskOpInfo(const void * const infoPtr, const size_t infoSize)
{
    return aclrtCacheLastTaskOpInfoImpl(infoPtr, infoSize);
}

aclError aclrtGetFunctionAttribute(aclrtFuncHandle funcHandle, aclrtFuncAttribute attrType, int64_t *attrValue)
{
    return aclrtGetFunctionAttributeImpl(funcHandle, attrType, attrValue);
}

aclError aclrtIpcGetEventHandle(aclrtEvent event, aclrtIpcEventHandle *handle)
{
    return aclrtIpcGetEventHandleImpl(event, handle);
}

aclError aclrtIpcOpenEventHandle(aclrtIpcEventHandle handle, aclrtEvent *event)
{
    return aclrtIpcOpenEventHandleImpl(handle, event);
}

aclError aclrtMemRetainAllocationHandle(void* virPtr, aclrtDrvMemHandle *handle) 
{
    return aclrtMemRetainAllocationHandleImpl(virPtr, handle);
}

aclError aclrtMemGetAllocationPropertiesFromHandle(aclrtDrvMemHandle handle, aclrtPhysicalMemProp* prop)
{
    return aclrtMemGetAllocationPropertiesFromHandleImpl(handle, prop);
}
