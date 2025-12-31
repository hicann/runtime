/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef RUNTIME_ACL_RT_IMPL_H_
#define RUNTIME_ACL_RT_IMPL_H_

#include <stdint.h>
#include <stddef.h>
#include <cstdarg>
#include "acl/acl_rt.h"
#include "acl/acl.h"
#include "acl/acl_base.h"
#include "acl/acl_rt_allocator.h"

#ifdef __cplusplus
extern "C" {
#endif

ACL_FUNC_VISIBILITY aclError aclrtPeekAtLastErrorImpl(aclrtLastErrLevel level);

ACL_FUNC_VISIBILITY aclError aclrtGetLastErrorImpl(aclrtLastErrLevel level);

ACL_FUNC_VISIBILITY aclError aclrtSetExceptionInfoCallbackImpl(aclrtExceptionInfoCallback callback);

ACL_FUNC_VISIBILITY uint32_t aclrtGetTaskIdFromExceptionInfoImpl(const aclrtExceptionInfo *info);

ACL_FUNC_VISIBILITY uint32_t aclrtGetStreamIdFromExceptionInfoImpl(const aclrtExceptionInfo *info);

ACL_FUNC_VISIBILITY uint32_t aclrtGetThreadIdFromExceptionInfoImpl(const aclrtExceptionInfo *info);

ACL_FUNC_VISIBILITY uint32_t aclrtGetDeviceIdFromExceptionInfoImpl(const aclrtExceptionInfo *info);

ACL_FUNC_VISIBILITY uint32_t aclrtGetErrorCodeFromExceptionInfoImpl(const aclrtExceptionInfo *info);

ACL_FUNC_VISIBILITY aclError aclrtSubscribeReportImpl(uint64_t threadId, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtLaunchCallbackImpl(aclrtCallback fn, void *userData,
    aclrtCallbackBlockType blockType, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtProcessReportImpl(int32_t timeout);

ACL_FUNC_VISIBILITY aclError aclrtUnSubscribeReportImpl(uint64_t threadId, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtCreateContextImpl(aclrtContext *context, int32_t deviceId);

ACL_FUNC_VISIBILITY aclError aclrtDestroyContextImpl(aclrtContext context);

ACL_FUNC_VISIBILITY aclError aclrtSetCurrentContextImpl(aclrtContext context);

ACL_FUNC_VISIBILITY aclError aclrtGetCurrentContextImpl(aclrtContext *context);

ACL_FUNC_VISIBILITY aclError aclrtCtxGetSysParamOptImpl(aclSysParamOpt opt, int64_t *value);

ACL_FUNC_VISIBILITY aclError aclrtCtxSetSysParamOptImpl(aclSysParamOpt opt, int64_t value);

ACL_FUNC_VISIBILITY aclError aclrtGetSysParamOptImpl(aclSysParamOpt opt, int64_t *value);

ACL_FUNC_VISIBILITY aclError aclrtSetSysParamOptImpl(aclSysParamOpt opt, int64_t value);

ACL_FUNC_VISIBILITY aclError aclrtSetDeviceImpl(int32_t deviceId);

ACL_FUNC_VISIBILITY aclError aclrtResetDeviceImpl(int32_t deviceId);

ACL_FUNC_VISIBILITY aclError aclrtResetDeviceForceImpl(int32_t deviceId);

ACL_FUNC_VISIBILITY aclError aclrtGetDeviceImpl(int32_t *deviceId);

ACL_FUNC_VISIBILITY aclError aclrtSetStreamFailureModeImpl(aclrtStream stream, uint64_t mode);

ACL_FUNC_VISIBILITY aclError aclrtGetRunModeImpl(aclrtRunMode *runMode);

ACL_FUNC_VISIBILITY aclError aclrtSynchronizeDeviceImpl(void);

ACL_FUNC_VISIBILITY aclError aclrtSynchronizeDeviceWithTimeoutImpl(int32_t timeout);

ACL_FUNC_VISIBILITY aclError aclrtSetTsDeviceImpl(aclrtTsId tsId);

ACL_FUNC_VISIBILITY aclError aclrtGetDeviceUtilizationRateImpl(int32_t deviceId, aclrtUtilizationInfo *utilizationInfo);

ACL_FUNC_VISIBILITY aclError aclrtGetDeviceCountImpl(uint32_t *count);

ACL_FUNC_VISIBILITY aclError aclrtCreateEventImpl(aclrtEvent *event);

ACL_FUNC_VISIBILITY aclError aclrtCreateEventWithFlagImpl(aclrtEvent *event, uint32_t flag);

ACL_FUNC_VISIBILITY aclError aclrtCreateEventExWithFlagImpl(aclrtEvent *event, uint32_t flag);

ACL_FUNC_VISIBILITY aclError aclrtDestroyEventImpl(aclrtEvent event);

ACL_FUNC_VISIBILITY aclError aclrtRecordEventImpl(aclrtEvent event, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtResetEventImpl(aclrtEvent event, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtQueryEventImpl(aclrtEvent event, aclrtEventStatus *status);

ACL_FUNC_VISIBILITY aclError aclrtQueryEventStatusImpl(aclrtEvent event, aclrtEventRecordedStatus *status);

ACL_FUNC_VISIBILITY aclError aclrtQueryEventWaitStatusImpl(aclrtEvent event, aclrtEventWaitStatus *status);

ACL_FUNC_VISIBILITY aclError aclrtSynchronizeEventImpl(aclrtEvent event);

ACL_FUNC_VISIBILITY aclError aclrtSynchronizeEventWithTimeoutImpl(aclrtEvent event, int32_t timeout);

ACL_FUNC_VISIBILITY aclError aclrtEventElapsedTimeImpl(float *ms, aclrtEvent startEvent, aclrtEvent endEvent);

ACL_FUNC_VISIBILITY aclError aclrtEventGetTimestampImpl(aclrtEvent event, uint64_t *timestamp);

ACL_FUNC_VISIBILITY aclError aclrtMallocImpl(void **devPtr, size_t size, aclrtMemMallocPolicy policy);

ACL_FUNC_VISIBILITY aclError aclrtMallocAlign32Impl(void **devPtr, size_t size, aclrtMemMallocPolicy policy);

ACL_FUNC_VISIBILITY aclError aclrtMallocCachedImpl(void **devPtr, size_t size, aclrtMemMallocPolicy policy);

ACL_FUNC_VISIBILITY aclError aclrtMallocWithCfgImpl(void **devPtr, size_t size, aclrtMemMallocPolicy policy,
    aclrtMallocConfig *cfg);

ACL_FUNC_VISIBILITY aclError aclrtMallocForTaskSchedulerImpl(void **devPtr, size_t size, aclrtMemMallocPolicy policy,
    aclrtMallocConfig *cfg);

ACL_FUNC_VISIBILITY aclError aclrtMallocHostWithCfgImpl(void **ptr, uint64_t size, aclrtMallocConfig *cfg);

ACL_FUNC_VISIBILITY aclError aclrtPointerGetAttributesImpl(const void *ptr, aclrtPtrAttributes *attributes);

ACL_FUNC_VISIBILITY aclError aclrtHostRegisterImpl(void *ptr, uint64_t size, aclrtHostRegisterType type, void **devPtr);

ACL_FUNC_VISIBILITY aclError aclrtHostRegisterV2Impl(void *ptr, uint64_t size, uint32_t flag);
 	 
ACL_FUNC_VISIBILITY aclError aclrtHostGetDevicePointerImpl(void *pHost, void **pDevice, uint32_t flag);

ACL_FUNC_VISIBILITY aclError aclrtHostUnregisterImpl(void *ptr);

ACL_FUNC_VISIBILITY aclError aclrtGetThreadLastTaskIdImpl(uint32_t *taskId);

ACL_FUNC_VISIBILITY aclError aclrtStreamGetIdImpl(aclrtStream stream, int32_t *streamId);

ACL_FUNC_VISIBILITY aclError aclrtMemFlushImpl(void *devPtr, size_t size);

ACL_FUNC_VISIBILITY aclError aclrtMemInvalidateImpl(void *devPtr, size_t size);

ACL_FUNC_VISIBILITY aclError aclrtFreeImpl(void *devPtr);

ACL_FUNC_VISIBILITY aclError aclrtMallocHostImpl(void **hostPtr, size_t size);

ACL_FUNC_VISIBILITY aclError aclrtFreeHostImpl(void *hostPtr);

ACL_FUNC_VISIBILITY aclError aclrtFreeWithDevSyncImpl(void *devPtr);

ACL_FUNC_VISIBILITY aclError aclrtFreeHostWithDevSyncImpl(void *hostPtr);

ACL_FUNC_VISIBILITY aclError aclrtMemcpyImpl(void *dst, size_t destMax, const void *src, size_t count,
    aclrtMemcpyKind kind);

ACL_FUNC_VISIBILITY aclError aclrtMemsetImpl(void *devPtr, size_t maxCount, int32_t value, size_t count);

ACL_FUNC_VISIBILITY aclError aclrtMemcpyAsyncImpl(void *dst, size_t destMax, const void *src, size_t count,
    aclrtMemcpyKind kind, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtMemcpyAsyncWithConditionImpl(void *dst, size_t destMax, const void *src,
    size_t count, aclrtMemcpyKind kind, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtMemcpy2dImpl(void *dst, size_t dpitch, const void *src, size_t spitch,
    size_t width, size_t height, aclrtMemcpyKind kind);

ACL_FUNC_VISIBILITY aclError aclrtMemcpy2dAsyncImpl(void *dst, size_t dpitch, const void *src, size_t spitch,
    size_t width, size_t height, aclrtMemcpyKind kind, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtMemsetAsyncImpl(void *devPtr, size_t maxCount, int32_t value, size_t count,
    aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtReserveMemAddressImpl(void **virPtr, size_t size, size_t alignment, void *expectPtr,
    uint64_t flags);

ACL_FUNC_VISIBILITY aclError aclrtReleaseMemAddressImpl(void *virPtr);

ACL_FUNC_VISIBILITY aclError aclrtMallocPhysicalImpl(aclrtDrvMemHandle *handle, size_t size,
    const aclrtPhysicalMemProp *prop, uint64_t flags);

ACL_FUNC_VISIBILITY aclError aclrtFreePhysicalImpl(aclrtDrvMemHandle handle);

ACL_FUNC_VISIBILITY aclError aclrtMapMemImpl(void *virPtr, size_t size, size_t offset, aclrtDrvMemHandle handle,
    uint64_t flags);

ACL_FUNC_VISIBILITY aclError aclrtUnmapMemImpl(void *virPtr);

ACL_FUNC_VISIBILITY aclError aclrtCreateStreamImpl(aclrtStream *stream);

ACL_FUNC_VISIBILITY aclError aclrtCreateStreamWithConfigImpl(aclrtStream *stream, uint32_t priority, uint32_t flag);

ACL_FUNC_VISIBILITY aclError aclrtDestroyStreamImpl(aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtDestroyStreamForceImpl(aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtSynchronizeStreamImpl(aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtSynchronizeStreamWithTimeoutImpl(aclrtStream stream, int32_t timeout);

ACL_FUNC_VISIBILITY aclError aclrtStreamQueryImpl(aclrtStream stream, aclrtStreamStatus *status);

ACL_FUNC_VISIBILITY aclError aclrtStreamGetPriorityImpl(aclrtStream stream, uint32_t *priority);

ACL_FUNC_VISIBILITY aclError aclrtStreamGetFlagsImpl(aclrtStream stream, uint32_t *flags);

ACL_FUNC_VISIBILITY aclError aclrtStreamWaitEventImpl(aclrtStream stream, aclrtEvent event);

ACL_FUNC_VISIBILITY aclError aclrtStreamWaitEventWithTimeoutImpl(aclrtStream stream, aclrtEvent event, int32_t timeout);

ACL_FUNC_VISIBILITY aclError aclrtSetGroupImpl(int32_t groupId);

ACL_FUNC_VISIBILITY aclError aclrtGetGroupCountImpl(uint32_t *count);

ACL_FUNC_VISIBILITY aclrtGroupInfo *aclrtCreateGroupInfoImpl();

ACL_FUNC_VISIBILITY aclError aclrtDestroyGroupInfoImpl(aclrtGroupInfo *groupInfo);

ACL_FUNC_VISIBILITY aclError aclrtGetAllGroupInfoImpl(aclrtGroupInfo *groupInfo);

ACL_FUNC_VISIBILITY aclError aclrtGetGroupInfoDetailImpl(const aclrtGroupInfo *groupInfo, int32_t groupIndex,
    aclrtGroupAttr attr, void *attrValue, size_t valueLen, size_t *paramRetSize);

ACL_FUNC_VISIBILITY aclError aclrtDeviceCanAccessPeerImpl(int32_t *canAccessPeer, int32_t deviceId,
    int32_t peerDeviceId);

ACL_FUNC_VISIBILITY aclError aclrtDeviceEnablePeerAccessImpl(int32_t peerDeviceId, uint32_t flags);

ACL_FUNC_VISIBILITY aclError aclrtDeviceDisablePeerAccessImpl(int32_t peerDeviceId);

ACL_FUNC_VISIBILITY aclError aclrtGetMemInfoImpl(aclrtMemAttr attr, size_t *free, size_t *total);

ACL_FUNC_VISIBILITY aclError aclrtGetMemUsageInfoImpl(int32_t deviceId, aclrtMemUsageInfo *memUsageInfo, size_t inputNum, size_t *outputNum);

ACL_FUNC_VISIBILITY aclError aclrtSetOpWaitTimeoutImpl(uint32_t timeout);

ACL_FUNC_VISIBILITY aclError aclrtSetOpExecuteTimeOutImpl(uint32_t timeout);

ACL_FUNC_VISIBILITY aclError aclrtSetOpExecuteTimeOutWithMsImpl(uint32_t timeout);

ACL_FUNC_VISIBILITY aclError aclrtSetOpExecuteTimeOutV2Impl(uint64_t timeout, uint64_t *actualTimeout);

ACL_FUNC_VISIBILITY aclError aclrtGetOpTimeOutIntervalImpl(uint64_t *interval);

ACL_FUNC_VISIBILITY aclError aclrtSetStreamOverflowSwitchImpl(aclrtStream stream, uint32_t flag);

ACL_FUNC_VISIBILITY aclError aclrtGetStreamOverflowSwitchImpl(aclrtStream stream, uint32_t *flag);

ACL_FUNC_VISIBILITY aclError aclrtSetDeviceSatModeImpl(aclrtFloatOverflowMode mode);

ACL_FUNC_VISIBILITY aclError aclrtGetDeviceSatModeImpl(aclrtFloatOverflowMode *mode);

ACL_FUNC_VISIBILITY aclError aclrtGetOverflowStatusImpl(void *outputAddr, size_t outputSize, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtResetOverflowStatusImpl(aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtQueryDeviceStatusImpl(int32_t deviceId, aclrtDeviceStatus *deviceStatus);

ACL_FUNC_VISIBILITY aclrtBinary aclrtCreateBinaryImpl(const void *data, size_t dataLen);

ACL_FUNC_VISIBILITY aclError aclrtDestroyBinaryImpl(aclrtBinary binary);

ACL_FUNC_VISIBILITY aclError aclrtBinaryLoadImpl(const aclrtBinary binary, aclrtBinHandle *binHandle);

ACL_FUNC_VISIBILITY aclError aclrtBinaryUnLoadImpl(aclrtBinHandle binHandle);

ACL_FUNC_VISIBILITY aclError aclrtBinaryGetFunctionImpl(const aclrtBinHandle binHandle, const char *kernelName,
    aclrtFuncHandle *funcHandle);

ACL_FUNC_VISIBILITY aclError aclrtLaunchKernelImpl(aclrtFuncHandle funcHandle, uint32_t blockDim,
    const void *argsData, size_t argsSize, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtMemGetAccessImpl(void *virPtr, aclrtMemLocation *location, uint64_t *flag);

ACL_FUNC_VISIBILITY aclError aclrtMemExportToShareableHandleImpl(aclrtDrvMemHandle handle,
    aclrtMemHandleType handleType, uint64_t flags, uint64_t *shareableHandle);

ACL_FUNC_VISIBILITY aclError aclrtMemExportToShareableHandleV2Impl(aclrtDrvMemHandle handle,
    uint64_t flags, aclrtMemSharedHandleType shareType, void *shareableHandle);      

ACL_FUNC_VISIBILITY aclError aclrtMemImportFromShareableHandleImpl(uint64_t shareableHandle,
    int32_t deviceId, aclrtDrvMemHandle *handle);

ACL_FUNC_VISIBILITY aclError aclrtMemImportFromShareableHandleV2Impl(void *shareableHandle, 
    aclrtMemSharedHandleType shareType, uint64_t flags, aclrtDrvMemHandle *handle);

ACL_FUNC_VISIBILITY aclError aclrtMemSetPidToShareableHandleImpl(uint64_t shareableHandle,
    int32_t *pid, size_t pidNum);

ACL_FUNC_VISIBILITY aclError aclrtMemSetPidToShareableHandleV2Impl(void *shareableHandle, 
    aclrtMemSharedHandleType shareType, int32_t *pid, size_t pidNum);

ACL_FUNC_VISIBILITY aclError aclrtMemGetAllocationGranularityImpl(aclrtPhysicalMemProp *prop,
    aclrtMemGranularityOptions option, size_t *granularity);

ACL_FUNC_VISIBILITY aclError aclrtDeviceGetBareTgidImpl(int32_t *pid);

ACL_FUNC_VISIBILITY aclError aclrtCmoAsyncImpl(void *src, size_t size, aclrtCmoType cmoType, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtGetMemUceInfoImpl(int32_t deviceId, aclrtMemUceInfo *memUceInfoArray,
    size_t arraySize, size_t *retSize);

ACL_FUNC_VISIBILITY aclError aclrtDeviceTaskAbortImpl(int32_t deviceId, uint32_t timeout);

ACL_FUNC_VISIBILITY aclError aclrtMemUceRepairImpl(int32_t deviceId, aclrtMemUceInfo *memUceInfoArray,
    size_t arraySize);

ACL_FUNC_VISIBILITY aclError aclrtStreamAbortImpl(aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtBinaryLoadFromFileImpl(const char* binPath, aclrtBinaryLoadOptions *options,
    aclrtBinHandle *binHandle);

ACL_FUNC_VISIBILITY aclError aclrtBinaryGetDevAddressImpl(const aclrtBinHandle binHandle, void **binAddr, size_t *binSize);

ACL_FUNC_VISIBILITY aclError aclrtBinaryGetFunctionByEntryImpl(aclrtBinHandle binHandle, uint64_t funcEntry,
    aclrtFuncHandle *funcHandle);

ACL_FUNC_VISIBILITY aclError aclrtGetFunctionAddrImpl(aclrtFuncHandle funcHandle, void **aicAddr, void **aivAddr);

ACL_FUNC_VISIBILITY aclError aclrtGetMemcpyDescSizeImpl(aclrtMemcpyKind kind, size_t *descSize);

ACL_FUNC_VISIBILITY aclError aclrtSetMemcpyDescImpl(void *desc, aclrtMemcpyKind kind, void *srcAddr, void *dstAddr,
    size_t count, void *config);

ACL_FUNC_VISIBILITY aclError aclrtMemcpyAsyncWithDescImpl(void *desc, aclrtMemcpyKind kind, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtMemcpyAsyncWithOffsetImpl(void **dst, size_t destMax, uint64_t dstDataOffset, const void **src,
    size_t count, size_t srcDataOffset, aclrtMemcpyKind kind, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtKernelArgsGetHandleMemSizeImpl(aclrtFuncHandle funcHandle, size_t *memSize);

ACL_FUNC_VISIBILITY aclError aclrtKernelArgsGetMemSizeImpl(aclrtFuncHandle funcHandle, size_t userArgsSize,
    size_t *actualArgsSize);

ACL_FUNC_VISIBILITY aclError aclrtKernelArgsInitImpl(aclrtFuncHandle funcHandle, aclrtArgsHandle *argsHandle);

ACL_FUNC_VISIBILITY aclError aclrtKernelArgsInitByUserMemImpl(aclrtFuncHandle funcHandle, aclrtArgsHandle argsHandle,
    void *userHostMem, size_t actualArgsSize);

ACL_FUNC_VISIBILITY aclError aclrtKernelArgsAppendImpl(aclrtArgsHandle argsHandle, void *param, size_t paramSize,
    aclrtParamHandle *paramHandle);

ACL_FUNC_VISIBILITY aclError aclrtKernelArgsAppendPlaceHolderImpl(aclrtArgsHandle argsHandle,
    aclrtParamHandle *paramHandle);

ACL_FUNC_VISIBILITY aclError aclrtKernelArgsGetPlaceHolderBufferImpl(aclrtArgsHandle argsHandle,
    aclrtParamHandle paramHandle, size_t dataSize, void **bufferAddr); 

ACL_FUNC_VISIBILITY aclError aclrtKernelArgsParaUpdateImpl(aclrtArgsHandle argsHandle, aclrtParamHandle paramHandle,
    void *param, size_t paramSize);

ACL_FUNC_VISIBILITY aclError aclrtLaunchKernelWithConfigImpl(aclrtFuncHandle funcHandle, uint32_t blockDim,
    aclrtStream stream, aclrtLaunchKernelCfg *cfg, aclrtArgsHandle argsHandle, void *reserve);

ACL_FUNC_VISIBILITY aclError aclrtKernelArgsFinalizeImpl(aclrtArgsHandle argsHandle);

ACL_FUNC_VISIBILITY aclError aclrtValueWriteImpl(void* devAddr, uint64_t value, uint32_t flag, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtValueWaitImpl(void* devAddr, uint64_t value, uint32_t flag, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtGetStreamAvailableNumImpl(uint32_t *streamCount);

ACL_FUNC_VISIBILITY aclError aclrtSetStreamAttributeImpl(aclrtStream stream, aclrtStreamAttr stmAttrType,
    aclrtStreamAttrValue *value);

ACL_FUNC_VISIBILITY aclError aclrtGetStreamAttributeImpl(aclrtStream stream, aclrtStreamAttr stmAttrType,
    aclrtStreamAttrValue *value);

ACL_FUNC_VISIBILITY aclError aclrtCreateNotifyImpl(aclrtNotify *notify, uint64_t flag);

ACL_FUNC_VISIBILITY aclError aclrtDestroyNotifyImpl(aclrtNotify notify);

ACL_FUNC_VISIBILITY aclError aclrtCntNotifyCreateImpl(aclrtCntNotify *notify, uint64_t flag);

ACL_FUNC_VISIBILITY aclError aclrtCntNotifyDestroyImpl(aclrtCntNotify notify);

ACL_FUNC_VISIBILITY aclError aclrtRecordNotifyImpl(aclrtNotify notify, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtWaitAndResetNotifyImpl(aclrtNotify notify, aclrtStream stream, uint32_t timeout);

ACL_FUNC_VISIBILITY aclError aclrtGetNotifyIdImpl(aclrtNotify notify, uint32_t *notifyId);

ACL_FUNC_VISIBILITY aclError aclrtGetEventIdImpl(aclrtEvent event, uint32_t *eventId);

ACL_FUNC_VISIBILITY aclError aclrtGetEventAvailNumImpl(uint32_t *eventCount);

ACL_FUNC_VISIBILITY aclError aclrtGetDeviceInfoImpl(uint32_t deviceId, aclrtDevAttr attr, int64_t *value);

ACL_FUNC_VISIBILITY aclError aclrtDeviceGetStreamPriorityRangeImpl(int32_t *leastPriority, int32_t *greatestPriority);

ACL_FUNC_VISIBILITY aclError aclrtGetDeviceCapabilityImpl(int32_t deviceId, aclrtDevFeatureType devFeatureType,
    int32_t *value);

ACL_FUNC_VISIBILITY aclError aclrtDeviceGetUuidImpl(int32_t deviceId, aclrtUuid *uuid);

ACL_FUNC_VISIBILITY aclError aclrtCtxGetCurrentDefaultStreamImpl(aclrtStream *stream);

ACL_FUNC_VISIBILITY aclError aclrtGetPrimaryCtxStateImpl(int32_t deviceId, uint32_t *flags, int32_t *active);

ACL_FUNC_VISIBILITY aclError aclrtReduceAsyncImpl(void *dst, const void *src, uint64_t count, aclrtReduceKind kind,
    aclDataType type, aclrtStream stream, void *reserve);

ACL_FUNC_VISIBILITY aclError aclrtSetDeviceWithoutTsdVXXImpl(int32_t deviceId);

ACL_FUNC_VISIBILITY aclError aclrtResetDeviceWithoutTsdVXXImpl(int32_t deviceId);

ACL_FUNC_VISIBILITY const char *aclrtGetSocNameImpl();

ACL_FUNC_VISIBILITY aclError aclrtGetDeviceResLimitImpl(int32_t deviceId, aclrtDevResLimitType type, uint32_t *value);

ACL_FUNC_VISIBILITY aclError aclrtSetDeviceResLimitImpl(int32_t deviceId, aclrtDevResLimitType type, uint32_t value);

ACL_FUNC_VISIBILITY aclError aclrtResetDeviceResLimitImpl(int32_t deviceId);

ACL_FUNC_VISIBILITY aclError aclrtGetStreamResLimitImpl(aclrtStream stream, aclrtDevResLimitType type, uint32_t *value);

ACL_FUNC_VISIBILITY aclError aclrtSetStreamResLimitImpl(aclrtStream stream, aclrtDevResLimitType type, uint32_t value);

ACL_FUNC_VISIBILITY aclError aclrtResetStreamResLimitImpl(aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtUseStreamResInCurrentThreadImpl(aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtUnuseStreamResInCurrentThreadImpl(aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtGetResInCurrentThreadImpl(aclrtDevResLimitType type, uint32_t *value);

ACL_FUNC_VISIBILITY aclError aclrtCreateLabelImpl(aclrtLabel *label);

ACL_FUNC_VISIBILITY aclError aclrtSetLabelImpl(aclrtLabel label, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtDestroyLabelImpl(aclrtLabel label);

ACL_FUNC_VISIBILITY aclError aclrtCreateLabelListImpl(aclrtLabel *labels, size_t num, aclrtLabelList *labelList);

ACL_FUNC_VISIBILITY aclError aclrtDestroyLabelListImpl(aclrtLabelList labelList);

ACL_FUNC_VISIBILITY aclError aclrtSwitchLabelByIndexImpl(void *ptr, uint32_t maxValue, aclrtLabelList labelList,
    aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtActiveStreamImpl(aclrtStream activeStream, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtSwitchStreamImpl(void *leftValue, aclrtCondition cond, void *rightValue,
    aclrtCompareDataType dataType, aclrtStream trueStream, aclrtStream falseStream, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtGetFunctionNameImpl(aclrtFuncHandle funcHandle, uint32_t maxLen, char *name);

ACL_FUNC_VISIBILITY aclError aclrtGetBufFromChainImpl(aclrtMbuf headBuf, uint32_t index, aclrtMbuf *buf);

ACL_FUNC_VISIBILITY aclError aclrtGetBufChainNumImpl(aclrtMbuf headBuf, uint32_t *num);

ACL_FUNC_VISIBILITY aclError aclrtAppendBufChainImpl(aclrtMbuf headBuf, aclrtMbuf buf);

ACL_FUNC_VISIBILITY aclError aclrtCopyBufRefImpl(const aclrtMbuf buf, aclrtMbuf *newBuf);

ACL_FUNC_VISIBILITY aclError aclrtGetBufUserDataImpl(const aclrtMbuf buf, void *dataPtr, size_t size, size_t offset);

ACL_FUNC_VISIBILITY aclError aclrtSetBufUserDataImpl(aclrtMbuf buf, const void *dataPtr, size_t size, size_t offset);

ACL_FUNC_VISIBILITY aclError aclrtGetBufDataImpl(const aclrtMbuf buf, void **dataPtr, size_t *size);

ACL_FUNC_VISIBILITY aclError aclrtGetBufDataLenImpl(aclrtMbuf buf, size_t *len);

ACL_FUNC_VISIBILITY aclError aclrtSetBufDataLenImpl(aclrtMbuf buf, size_t len);

ACL_FUNC_VISIBILITY aclError aclrtFreeBufImpl(aclrtMbuf buf);

ACL_FUNC_VISIBILITY aclError aclrtAllocBufImpl(aclrtMbuf *buf, size_t size);

ACL_FUNC_VISIBILITY aclError aclrtBinaryLoadFromDataImpl(const void *data, size_t length,
    const aclrtBinaryLoadOptions *options, aclrtBinHandle *binHandle);

ACL_FUNC_VISIBILITY aclError aclrtRegisterCpuFuncImpl(const aclrtBinHandle handle, const char *funcName,
    const char *kernelName, aclrtFuncHandle *funcHandle);

ACL_FUNC_VISIBILITY aclError aclrtCmoAsyncWithBarrierImpl(void *src, size_t size, aclrtCmoType cmoType,
    uint32_t barrierId, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtCmoWaitBarrierImpl(aclrtBarrierTaskInfo *taskInfo, aclrtStream stream, uint32_t flag);

ACL_FUNC_VISIBILITY aclError aclrtGetDevicesTopoImpl(uint32_t deviceId, uint32_t otherDeviceId, uint64_t *value);

ACL_FUNC_VISIBILITY aclError aclrtMemcpyBatchImpl(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes,
    size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs, size_t *failIndex);

ACL_FUNC_VISIBILITY aclError aclrtIpcMemGetExportKeyImpl(void *devPtr, size_t size, char *key, size_t len, uint64_t flags);

ACL_FUNC_VISIBILITY aclError aclrtMemcpyBatchAsyncImpl(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes,
    size_t numBatches, aclrtMemcpyBatchAttr *attrs, size_t *attrsIndexes, size_t numAttrs, size_t *failIndex,
    aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtIpcMemCloseImpl(const char *key);

ACL_FUNC_VISIBILITY aclError aclrtIpcMemImportByKeyImpl(void **devPtr, const char *key, uint64_t flags);

ACL_FUNC_VISIBILITY aclError aclrtIpcMemSetImportPidImpl(const char *key, int32_t *pid, size_t num);

ACL_FUNC_VISIBILITY aclError aclrtIpcMemSetAttrImpl(const char *key, aclrtIpcMemAttrType type, uint64_t attr);

ACL_FUNC_VISIBILITY aclError aclrtIpcMemImportPidInterServerImpl(const char *key, aclrtServerPid *serverPids, size_t num);

ACL_FUNC_VISIBILITY aclError aclrtNotifyBatchResetImpl(aclrtNotify *notifies, size_t num);

ACL_FUNC_VISIBILITY aclError aclrtNotifyGetExportKeyImpl(aclrtNotify notify, char *key, size_t len, uint64_t flags);

ACL_FUNC_VISIBILITY aclError aclrtNotifyImportByKeyImpl(aclrtNotify *notify, const char *key, uint64_t flags);

ACL_FUNC_VISIBILITY aclError aclrtNotifySetImportPidImpl(aclrtNotify notify, int32_t *pid, size_t num);

ACL_FUNC_VISIBILITY aclError aclrtNotifySetImportPidInterServerImpl(aclrtNotify notify, aclrtServerPid *serverPids, size_t num);

ACL_FUNC_VISIBILITY aclError aclmdlRIExecuteAsyncImpl(aclmdlRI modelRI, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclmdlRIDestroyImpl(aclmdlRI modelRI);

ACL_FUNC_VISIBILITY aclError aclmdlRICaptureBeginImpl(aclrtStream stream, aclmdlRICaptureMode mode);

ACL_FUNC_VISIBILITY aclError aclmdlRICaptureGetInfoImpl(aclrtStream stream, aclmdlRICaptureStatus *status, aclmdlRI *modelRI);

ACL_FUNC_VISIBILITY aclError aclmdlRICaptureEndImpl(aclrtStream stream, aclmdlRI *modelRI);

ACL_FUNC_VISIBILITY aclError aclmdlRIDebugPrintImpl(aclmdlRI modelRI);

ACL_FUNC_VISIBILITY aclError aclmdlRIDebugJsonPrintImpl(aclmdlRI modelRI, const char *path, uint32_t flags);

ACL_FUNC_VISIBILITY aclError aclmdlRICaptureThreadExchangeModeImpl(aclmdlRICaptureMode *mode);

ACL_FUNC_VISIBILITY aclError aclmdlRICaptureTaskGrpBeginImpl(aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclmdlRICaptureTaskGrpEndImpl(aclrtStream stream, aclrtTaskGrp *handle);

ACL_FUNC_VISIBILITY aclError aclmdlRICaptureTaskUpdateBeginImpl(aclrtStream stream, aclrtTaskGrp handle);

ACL_FUNC_VISIBILITY aclError aclmdlRICaptureTaskUpdateEndImpl(aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclmdlRIBuildBeginImpl(aclmdlRI *modelRI, uint32_t flag);

ACL_FUNC_VISIBILITY aclError aclmdlRIBindStreamImpl(aclmdlRI modelRI, aclrtStream stream, uint32_t flag);

ACL_FUNC_VISIBILITY aclError aclmdlRIEndTaskImpl(aclmdlRI modelRI, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclmdlRIBuildEndImpl(aclmdlRI modelRI, void *reserve);

ACL_FUNC_VISIBILITY aclError aclmdlRIUnbindStreamImpl(aclmdlRI modelRI, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclmdlRIExecuteImpl(aclmdlRI modelRI, int32_t timeout);

ACL_FUNC_VISIBILITY aclError aclmdlRISetNameImpl(aclmdlRI modelRI, const char *name);

ACL_FUNC_VISIBILITY aclError aclmdlRIGetNameImpl(aclmdlRI modelRI, uint32_t maxLen, char *name);

ACL_FUNC_VISIBILITY aclError aclmdlInitDumpImpl();

ACL_FUNC_VISIBILITY aclError aclmdlSetDumpImpl(const char *dumpCfgPath);

ACL_FUNC_VISIBILITY aclError aclmdlFinalizeDumpImpl();

ACL_FUNC_VISIBILITY size_t aclDataTypeSizeImpl(aclDataType dataType);

ACL_FUNC_VISIBILITY aclDataBuffer *aclCreateDataBufferImpl(void *data, size_t size);

ACL_FUNC_VISIBILITY aclError aclDestroyDataBufferImpl(const aclDataBuffer *dataBuffer);

ACL_FUNC_VISIBILITY aclError aclUpdateDataBufferImpl(aclDataBuffer *dataBuffer, void *data, size_t size);

ACL_FUNC_VISIBILITY void *aclGetDataBufferAddrImpl(const aclDataBuffer *dataBuffer);

ACL_FUNC_VISIBILITY uint32_t aclGetDataBufferSizeImpl(const aclDataBuffer *dataBuffer);

ACL_FUNC_VISIBILITY size_t aclGetDataBufferSizeV2Impl(const aclDataBuffer *dataBuffer);

ACL_FUNC_VISIBILITY aclrtAllocatorDesc aclrtAllocatorCreateDescImpl();

ACL_FUNC_VISIBILITY aclError aclrtAllocatorDestroyDescImpl(aclrtAllocatorDesc allocatorDesc);

ACL_FUNC_VISIBILITY aclError aclrtAllocatorSetObjToDescImpl(aclrtAllocatorDesc allocatorDesc, aclrtAllocator allocator);

ACL_FUNC_VISIBILITY aclError aclrtAllocatorSetAllocFuncToDescImpl(aclrtAllocatorDesc allocatorDesc, aclrtAllocatorAllocFunc func);

ACL_FUNC_VISIBILITY aclError aclrtAllocatorSetFreeFuncToDescImpl(aclrtAllocatorDesc allocatorDesc, aclrtAllocatorFreeFunc func);

ACL_FUNC_VISIBILITY aclError aclrtAllocatorSetAllocAdviseFuncToDescImpl(aclrtAllocatorDesc allocatorDesc, aclrtAllocatorAllocAdviseFunc func);

ACL_FUNC_VISIBILITY aclError aclrtAllocatorSetGetAddrFromBlockFuncToDescImpl(aclrtAllocatorDesc allocatorDesc,
                                                     aclrtAllocatorGetAddrFromBlockFunc func);

ACL_FUNC_VISIBILITY aclError aclrtAllocatorRegisterImpl(aclrtStream stream, aclrtAllocatorDesc allocatorDesc);

ACL_FUNC_VISIBILITY aclError aclrtAllocatorGetByStreamImpl(aclrtStream stream,
                                   aclrtAllocatorDesc *allocatorDesc,
                                   aclrtAllocator *allocator,
                                   aclrtAllocatorAllocFunc *allocFunc,
                                   aclrtAllocatorFreeFunc *freeFunc,
                                   aclrtAllocatorAllocAdviseFunc *allocAdviseFunc,
                                   aclrtAllocatorGetAddrFromBlockFunc *getAddrFromBlockFunc);

ACL_FUNC_VISIBILITY aclError aclrtAllocatorUnregisterImpl(aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtGetVersionImpl(int32_t *majorVersion, int32_t *minorVersion, int32_t *patchVersion);

ACL_FUNC_VISIBILITY aclError aclInitCallbackRegisterImpl(aclRegisterCallbackType type, aclInitCallbackFunc cbFunc,
                                                         void *userData);

ACL_FUNC_VISIBILITY aclError aclInitCallbackUnRegisterImpl(aclRegisterCallbackType type, aclInitCallbackFunc cbFunc);

ACL_FUNC_VISIBILITY aclError aclFinalizeCallbackRegisterImpl(aclRegisterCallbackType type,
                                                             aclFinalizeCallbackFunc cbFunc, void *userData);

ACL_FUNC_VISIBILITY aclError aclFinalizeCallbackUnRegisterImpl(aclRegisterCallbackType type,
                                                               aclFinalizeCallbackFunc cbFunc);

ACL_FUNC_VISIBILITY aclError aclrtCheckMemTypeImpl(void** addrList, uint32_t size, uint32_t memType, uint32_t *checkResult, uint32_t reserve);

ACL_FUNC_VISIBILITY aclError aclrtGetLogicDevIdByUserDevIdImpl(const int32_t userDevid, int32_t *const logicDevId);

ACL_FUNC_VISIBILITY aclError aclrtGetUserDevIdByLogicDevIdImpl(const int32_t logicDevId, int32_t *const userDevid);

ACL_FUNC_VISIBILITY aclError aclrtGetLogicDevIdByPhyDevIdImpl(const int32_t phyDevId, int32_t *const logicDevId);

ACL_FUNC_VISIBILITY aclError aclrtGetPhyDevIdByLogicDevIdImpl(const int32_t logicDevId, int32_t *const phyDevId);

ACL_FUNC_VISIBILITY aclError aclrtProfTraceImpl(void *userdata, int32_t length, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtLaunchKernelV2Impl(aclrtFuncHandle funcHandle, uint32_t blockDim,
    const void *argsData, size_t argsSize, aclrtLaunchKernelCfg *cfg, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtLaunchKernelWithHostArgsImpl(aclrtFuncHandle funcHandle, uint32_t blockDim,
    aclrtStream stream, aclrtLaunchKernelCfg *cfg, void *hostArgs, size_t argsSize,
    aclrtPlaceHolderInfo *placeHolderArray, size_t placeHolderNum);

ACL_FUNC_VISIBILITY aclError aclrtCtxGetFloatOverflowAddrImpl(void **overflowAddr);

ACL_FUNC_VISIBILITY aclError aclrtGetFloatOverflowStatusImpl(void *outputAddr, uint64_t outputSize, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtResetFloatOverflowStatusImpl(aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtNpuGetFloatOverFlowStatusImpl(void *outputAddr, uint64_t outputSize, uint32_t checkMode, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtNpuClearFloatOverFlowStatusImpl(uint32_t checkMode, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclInitImpl(const char *configPath);

ACL_FUNC_VISIBILITY aclError aclFinalizeImpl();

ACL_FUNC_VISIBILITY aclError aclFinalizeReferenceImpl(uint64_t *refCount);

ACL_FUNC_VISIBILITY aclError aclsysGetCANNVersionImpl(aclCANNPackageName name, aclCANNPackageVersion *version);

ACL_FUNC_VISIBILITY aclError aclsysGetVersionStrImpl(char *pkgName, char *versionStr);

ACL_FUNC_VISIBILITY aclError aclsysGetVersionNumImpl(char *pkgName, int32_t *versionNum);

ACL_FUNC_VISIBILITY const char *aclGetRecentErrMsgImpl();

ACL_FUNC_VISIBILITY aclError aclGetCannAttributeListImpl(const aclCannAttr **cannAttrList, size_t *num);

ACL_FUNC_VISIBILITY aclError aclGetCannAttributeImpl(aclCannAttr cannAttr, int32_t *value);

ACL_FUNC_VISIBILITY aclError aclGetDeviceCapabilityImpl(uint32_t deviceId, aclDeviceInfo deviceInfo, int64_t *value);

ACL_FUNC_VISIBILITY float aclFloat16ToFloatImpl(aclFloat16 value);

ACL_FUNC_VISIBILITY aclFloat16 aclFloatToFloat16Impl(float value);

ACL_FUNC_VISIBILITY void aclAppLogImpl(aclLogLevel logLevel, const char *func, const char *file, uint32_t line, const char *fmt, va_list args);

ACL_FUNC_VISIBILITY aclError aclrtLaunchHostFuncImpl(aclrtStream stream, aclrtHostFunc fn, void *args);

ACL_FUNC_VISIBILITY aclError aclrtGetHardwareSyncAddrImpl(void **addr);

ACL_FUNC_VISIBILITY aclError aclrtRandomNumAsyncImpl(const aclrtRandomNumTaskInfo *taskInfo, const aclrtStream stream, void *reserve);

ACL_FUNC_VISIBILITY aclError aclrtRegStreamStateCallbackImpl(const char *regName, aclrtStreamStateCallback callback, void *args);

ACL_FUNC_VISIBILITY aclError aclrtRegDeviceStateCallbackImpl(const char *regName, aclrtDeviceStateCallback callback, void *args);

ACL_FUNC_VISIBILITY aclError aclrtSetDeviceTaskAbortCallbackImpl(const char *regName, aclrtDeviceTaskAbortCallback callback, void *args);

ACL_FUNC_VISIBILITY aclError aclrtGetOpExecuteTimeoutImpl(uint32_t *const timeoutMs);

ACL_FUNC_VISIBILITY aclError aclrtDevicePeerAccessStatusImpl(int32_t deviceId, int32_t peerDeviceId, int32_t *status);

ACL_FUNC_VISIBILITY aclError aclrtStreamStopImpl(aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtTaskUpdateAsyncImpl(aclrtStream taskStream, uint32_t taskId, aclrtTaskUpdateInfo *info, aclrtStream execStream);

ACL_FUNC_VISIBILITY aclError aclrtCmoGetDescSizeImpl(size_t *size);

ACL_FUNC_VISIBILITY aclError aclrtCmoSetDescImpl(void *cmoDesc, void *src, size_t size);

ACL_FUNC_VISIBILITY aclError aclrtCmoAsyncWithDescImpl(
    void *cmoDesc, aclrtCmoType cmoType, aclrtStream stream, const void *reserve);

ACL_FUNC_VISIBILITY aclError aclrtCheckArchCompatibilityImpl(const char *socVersion, int32_t *canCompatible);

ACL_FUNC_VISIBILITY aclError aclmdlRIAbortImpl(aclmdlRI modelRI);

ACL_FUNC_VISIBILITY aclError aclrtCntNotifyRecordImpl(aclrtCntNotify cntNotify, aclrtStream stream,
    aclrtCntNotifyRecordInfo *info);

ACL_FUNC_VISIBILITY aclError aclrtCntNotifyWaitWithTimeoutImpl(aclrtCntNotify cntNotify, aclrtStream stream,
    aclrtCntNotifyWaitInfo *info);

ACL_FUNC_VISIBILITY aclError aclrtCntNotifyResetImpl(aclrtCntNotify cntNotify, aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtCntNotifyGetIdImpl(aclrtCntNotify cntNotify, uint32_t *notifyId);

ACL_FUNC_VISIBILITY aclError aclrtPersistentTaskCleanImpl(aclrtStream stream);

ACL_FUNC_VISIBILITY aclError aclrtGetErrorVerboseImpl(int32_t deviceId, aclrtErrorInfo *errorInfo);

ACL_FUNC_VISIBILITY aclError aclrtRepairErrorImpl(int32_t deviceId, const aclrtErrorInfo *errorInfo);

ACL_FUNC_VISIBILITY aclError aclrtMemSetAccessImpl(void *virPtr, size_t size, aclrtMemAccessDesc *desc, size_t count);

ACL_FUNC_VISIBILITY aclError aclrtSnapShotProcessLockImpl();

ACL_FUNC_VISIBILITY aclError aclrtSnapShotProcessUnlockImpl();

ACL_FUNC_VISIBILITY aclError aclrtSnapShotProcessBackupImpl();

ACL_FUNC_VISIBILITY aclError aclrtSnapShotProcessRestoreImpl();

ACL_FUNC_VISIBILITY aclError aclrtCacheLastTaskOpInfoImpl(const void * const infoPtr, const size_t infoSize);

ACL_FUNC_VISIBILITY aclError aclrtGetFunctionAttributeImpl(aclrtFuncHandle funcHandle, aclrtFuncAttribute attrType, int64_t *attrValue);

ACL_FUNC_VISIBILITY aclError aclrtIpcGetEventHandleImpl(aclrtEvent event, aclrtIpcEventHandle *handle);

ACL_FUNC_VISIBILITY aclError aclrtIpcOpenEventHandleImpl(aclrtIpcEventHandle handle, aclrtEvent *event);

ACL_FUNC_VISIBILITY aclError aclrtMemRetainAllocationHandleImpl(void* virPtr, aclrtDrvMemHandle *handle);

ACL_FUNC_VISIBILITY aclError aclrtMemGetAllocationPropertiesFromHandleImpl(aclrtDrvMemHandle handle, aclrtPhysicalMemProp* prop);
#ifdef __cplusplus
}
#endif

#endif // RUNTIME_ACL_RT_IMPL_H_
