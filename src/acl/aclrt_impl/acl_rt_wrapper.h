/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef RUNTIME_ACL_RT_WRAPPER_H_
#define RUNTIME_ACL_RT_WRAPPER_H_

// used to generate impl header functions
#define ACL_RT_IMPL_HEADER(ret, name, sig, args) \
    ACL_FUNC_VISIBILITY ret name##Impl sig;

// used to generate cpp forwarding functions
#define ACL_RT_CPP(ret, name, sig, args) \
    ret name sig { return name##Impl args; }

// aclrt interface map list
#define ACL_RT_FUNC_MAP(_)                                          \
    _(aclError, aclrtPeekAtLastError, (aclrtLastErrLevel level), (level)) \
    _(aclError, aclrtGetLastError, (aclrtLastErrLevel level), (level)) \
    _(aclError, aclrtSetExceptionInfoCallback, (aclrtExceptionInfoCallback callback), (callback)) \
    _(uint32_t, aclrtGetTaskIdFromExceptionInfo, (const aclrtExceptionInfo * info), (info)) \
    _(uint32_t, aclrtGetStreamIdFromExceptionInfo, (const aclrtExceptionInfo * info), (info)) \
    _(uint32_t, aclrtGetThreadIdFromExceptionInfo, (const aclrtExceptionInfo * info), (info)) \
    _(uint32_t, aclrtGetDeviceIdFromExceptionInfo, (const aclrtExceptionInfo * info), (info)) \
    _(uint32_t, aclrtGetErrorCodeFromExceptionInfo, (const aclrtExceptionInfo * info), (info)) \
    _(aclError, aclrtSubscribeReport, (uint64_t threadId, aclrtStream stream), (threadId, stream)) \
    _(aclError, aclrtGetArgsFromExceptionInfo, (const aclrtExceptionInfo * info, void ** devArgsPtr, uint32_t * devArgsLen), (info, devArgsPtr, devArgsLen)) \
    _(aclError, aclrtGetFuncHandleFromExceptionInfo, (const aclrtExceptionInfo * info, aclrtFuncHandle * func), (info, func)) \
    _(aclError, aclrtBinarySetExceptionCallback, (aclrtBinHandle binHandle, aclrtOpExceptionCallback callback, void * userData), (binHandle, callback, userData)) \
    _(aclError, aclrtLaunchCallback, (aclrtCallback fn, void * userData, aclrtCallbackBlockType blockType, aclrtStream stream), (fn, userData, blockType, stream)) \
    _(aclError, aclrtProcessReport, (int32_t timeout), (timeout)) \
    _(aclError, aclrtUnSubscribeReport, (uint64_t threadId, aclrtStream stream), (threadId, stream)) \
    _(aclError, aclrtCreateContext, (aclrtContext * context, int32_t deviceId), (context, deviceId)) \
    _(aclError, aclrtDestroyContext, (aclrtContext context), (context)) \
    _(aclError, aclrtSetCurrentContext, (aclrtContext context), (context)) \
    _(aclError, aclrtGetCurrentContext, (aclrtContext * context), (context)) \
    _(aclError, aclrtCtxGetSysParamOpt, (aclSysParamOpt opt, int64_t * value), (opt, value)) \
    _(aclError, aclrtCtxSetSysParamOpt, (aclSysParamOpt opt, int64_t value), (opt, value)) \
    _(aclError, aclrtGetSysParamOpt, (aclSysParamOpt opt, int64_t * value), (opt, value)) \
    _(aclError, aclrtSetSysParamOpt, (aclSysParamOpt opt, int64_t value), (opt, value)) \
    _(aclError, aclrtSetDevice, (int32_t deviceId), (deviceId)) \
    _(aclError, aclrtResetDevice, (int32_t deviceId), (deviceId)) \
    _(aclError, aclrtResetDeviceForce, (int32_t deviceId), (deviceId)) \
    _(aclError, aclrtGetDevice, (int32_t * deviceId), (deviceId)) \
    _(aclError, aclrtSetStreamFailureMode, (aclrtStream stream, uint64_t mode), (stream, mode)) \
    _(aclError, aclrtGetRunMode, (aclrtRunMode * runMode), (runMode)) \
    _(aclError, aclrtSynchronizeDevice, (), ()) \
    _(aclError, aclrtSynchronizeDeviceWithTimeout, (int32_t timeout), (timeout)) \
    _(aclError, aclrtSetTsDevice, (aclrtTsId tsId), (tsId)) \
    _(aclError, aclrtGetDeviceUtilizationRate, (int32_t deviceId, aclrtUtilizationInfo * utilizationInfo), (deviceId, utilizationInfo)) \
    _(aclError, aclrtGetDeviceCount, (uint32_t * count), (count)) \
    _(aclError, aclrtCreateEvent, (aclrtEvent * event), (event)) \
    _(aclError, aclrtCreateEventWithFlag, (aclrtEvent * event, uint32_t flag), (event, flag)) \
    _(aclError, aclrtCreateEventExWithFlag, (aclrtEvent * event, uint32_t flag), (event, flag)) \
    _(aclError, aclrtDestroyEvent, (aclrtEvent event), (event)) \
    _(aclError, aclrtRecordEvent, (aclrtEvent event, aclrtStream stream), (event, stream)) \
    _(aclError, aclrtResetEvent, (aclrtEvent event, aclrtStream stream), (event, stream)) \
    _(aclError, aclrtQueryEvent, (aclrtEvent event, aclrtEventStatus * status), (event, status)) \
    _(aclError, aclrtQueryEventStatus, (aclrtEvent event, aclrtEventRecordedStatus * status), (event, status)) \
    _(aclError, aclrtQueryEventWaitStatus, (aclrtEvent event, aclrtEventWaitStatus * status), (event, status)) \
    _(aclError, aclrtSynchronizeEvent, (aclrtEvent event), (event)) \
    _(aclError, aclrtSynchronizeEventWithTimeout, (aclrtEvent event, int32_t timeout), (event, timeout)) \
    _(aclError, aclrtEventElapsedTime, (float * ms, aclrtEvent startEvent, aclrtEvent endEvent), (ms, startEvent, endEvent)) \
    _(aclError, aclrtEventGetTimestamp, (aclrtEvent event, uint64_t * timestamp), (event, timestamp)) \
    _(aclError, aclrtMalloc, (void ** devPtr, size_t size, aclrtMemMallocPolicy policy), (devPtr, size, policy)) \
    _(aclError, aclrtMallocAlign32, (void ** devPtr, size_t size, aclrtMemMallocPolicy policy), (devPtr, size, policy)) \
    _(aclError, aclrtMallocCached, (void ** devPtr, size_t size, aclrtMemMallocPolicy policy), (devPtr, size, policy)) \
    _(aclError, aclrtMallocWithCfg, (void ** devPtr, size_t size, aclrtMemMallocPolicy policy, aclrtMallocConfig * cfg), (devPtr, size, policy, cfg)) \
    _(aclError, aclrtMallocForTaskScheduler, (void ** devPtr, size_t size, aclrtMemMallocPolicy policy, aclrtMallocConfig * cfg), (devPtr, size, policy, cfg)) \
    _(aclError, aclrtMallocHostWithCfg, (void ** ptr, uint64_t size, aclrtMallocConfig * cfg), (ptr, size, cfg)) \
    _(aclError, aclrtPointerGetAttributes, (const void * ptr, aclrtPtrAttributes * attributes), (ptr, attributes)) \
    _(aclError, aclrtHostRegister, (void * ptr, uint64_t size, aclrtHostRegisterType type, void ** devPtr), (ptr, size, type, devPtr)) \
    _(aclError, aclrtHostRegisterV2, (void * ptr, uint64_t size, uint32_t flag), (ptr, size, flag)) \
    _(aclError, aclrtHostGetDevicePointer, (void * pHost, void ** pDevice, uint32_t flag), (pHost, pDevice, flag)) \
    _(aclError, aclrtHostUnregister, (void * ptr), (ptr)) \
    _(aclError, aclrtHostMemMapCapabilities, (uint32_t deviceId, aclrtHacType hacType, aclrtHostMemMapCapability * capabilities), (deviceId, hacType, capabilities)) \
    _(aclError, aclrtGetThreadLastTaskId, (uint32_t * taskId), (taskId)) \
    _(aclError, aclrtStreamGetId, (aclrtStream stream, int32_t * streamId), (stream, streamId)) \
    _(aclError, aclrtMemFlush, (void * devPtr, size_t size), (devPtr, size)) \
    _(aclError, aclrtMemInvalidate, (void * devPtr, size_t size), (devPtr, size)) \
    _(aclError, aclrtFree, (void * devPtr), (devPtr)) \
    _(aclError, aclrtMallocHost, (void ** hostPtr, size_t size), (hostPtr, size)) \
    _(aclError, aclrtFreeHost, (void * hostPtr), (hostPtr)) \
    _(aclError, aclrtFreeWithDevSync, (void * devPtr), (devPtr)) \
    _(aclError, aclrtFreeHostWithDevSync, (void * hostPtr), (hostPtr)) \
    _(aclError, aclrtMemcpy, (void * dst, size_t destMax, const void * src, size_t count, aclrtMemcpyKind kind), (dst, destMax, src, count, kind)) \
    _(aclError, aclrtMemset, (void * devPtr, size_t maxCount, int32_t value, size_t count), (devPtr, maxCount, value, count)) \
    _(aclError, aclrtMemcpyAsync, (void * dst, size_t destMax, const void * src, size_t count, aclrtMemcpyKind kind, aclrtStream stream), (dst, destMax, src, count, kind, stream)) \
    _(aclError, aclrtMemcpyAsyncWithCondition, (void * dst, size_t destMax, const void * src, size_t count, aclrtMemcpyKind kind, aclrtStream stream), (dst, destMax, src, count, kind, stream)) \
    _(aclError, aclrtMemcpy2d, (void * dst, size_t dpitch, const void * src, size_t spitch, size_t width, size_t height, aclrtMemcpyKind kind), (dst, dpitch, src, spitch, width, height, kind)) \
    _(aclError, aclrtMemcpy2dAsync, (void * dst, size_t dpitch, const void * src, size_t spitch, size_t width, size_t height, aclrtMemcpyKind kind, aclrtStream stream), (dst, dpitch, src, spitch, width, height, kind, stream)) \
    _(aclError, aclrtMemsetAsync, (void * devPtr, size_t maxCount, int32_t value, size_t count, aclrtStream stream), (devPtr, maxCount, value, count, stream)) \
    _(aclError, aclrtReserveMemAddress, (void ** virPtr, size_t size, size_t alignment, void * expectPtr, uint64_t flags), (virPtr, size, alignment, expectPtr, flags)) \
    _(aclError, aclrtReleaseMemAddress, (void * virPtr), (virPtr)) \
    _(aclError, aclrtMallocPhysical, (aclrtDrvMemHandle * handle, size_t size, const aclrtPhysicalMemProp * prop, uint64_t flags), (handle, size, prop, flags)) \
    _(aclError, aclrtFreePhysical, (aclrtDrvMemHandle handle), (handle)) \
    _(aclError, aclrtMapMem, (void * virPtr, size_t size, size_t offset, aclrtDrvMemHandle handle, uint64_t flags), (virPtr, size, offset, handle, flags)) \
    _(aclError, aclrtUnmapMem, (void * virPtr), (virPtr)) \
    _(aclError, aclrtCreateStream, (aclrtStream * stream), (stream)) \
    _(aclError, aclrtCreateStreamWithConfig, (aclrtStream * stream, uint32_t priority, uint32_t flag), (stream, priority, flag)) \
    _(aclError, aclrtDestroyStream, (aclrtStream stream), (stream)) \
    _(aclError, aclrtDestroyStreamForce, (aclrtStream stream), (stream)) \
    _(aclError, aclrtSynchronizeStream, (aclrtStream stream), (stream)) \
    _(aclError, aclrtSynchronizeStreamWithTimeout, (aclrtStream stream, int32_t timeout), (stream, timeout)) \
    _(aclError, aclrtStreamQuery, (aclrtStream stream, aclrtStreamStatus * status), (stream, status)) \
    _(aclError, aclrtStreamGetPriority, (aclrtStream stream, uint32_t * priority), (stream, priority)) \
    _(aclError, aclrtStreamGetFlags, (aclrtStream stream, uint32_t * flags), (stream, flags)) \
    _(aclError, aclrtStreamWaitEvent, (aclrtStream stream, aclrtEvent event), (stream, event)) \
    _(aclError, aclrtStreamWaitEventWithTimeout, (aclrtStream stream, aclrtEvent event, int32_t timeout), (stream, event, timeout)) \
    _(aclError, aclrtSetGroup, (int32_t groupId), (groupId)) \
    _(aclError, aclrtGetGroupCount, (uint32_t * count), (count)) \
    _(aclrtGroupInfo *, aclrtCreateGroupInfo, (), ()) \
    _(aclError, aclrtDestroyGroupInfo, (aclrtGroupInfo * groupInfo), (groupInfo)) \
    _(aclError, aclrtGetAllGroupInfo, (aclrtGroupInfo * groupInfo), (groupInfo)) \
    _(aclError, aclrtGetGroupInfoDetail, (const aclrtGroupInfo * groupInfo, int32_t groupIndex, aclrtGroupAttr attr, void * attrValue, size_t valueLen, size_t * paramRetSize), (groupInfo, groupIndex, attr, attrValue, valueLen, paramRetSize)) \
    _(aclError, aclrtDeviceCanAccessPeer, (int32_t * canAccessPeer, int32_t deviceId, int32_t peerDeviceId), (canAccessPeer, deviceId, peerDeviceId)) \
    _(aclError, aclrtDeviceEnablePeerAccess, (int32_t peerDeviceId, uint32_t flags), (peerDeviceId, flags)) \
    _(aclError, aclrtDeviceDisablePeerAccess, (int32_t peerDeviceId), (peerDeviceId)) \
    _(aclError, aclrtGetMemInfo, (aclrtMemAttr attr, size_t * free, size_t * total), (attr, free, total)) \
    _(aclError, aclrtGetMemUsageInfo, (int32_t deviceId, aclrtMemUsageInfo * memUsageInfo, size_t inputNum, size_t * outputNum), (deviceId, memUsageInfo, inputNum, outputNum)) \
    _(aclError, aclrtSetOpWaitTimeout, (uint32_t timeout), (timeout)) \
    _(aclError, aclrtSetOpExecuteTimeOut, (uint32_t timeout), (timeout)) \
    _(aclError, aclrtSetOpExecuteTimeOutWithMs, (uint32_t timeout), (timeout)) \
    _(aclError, aclrtSetOpExecuteTimeOutV2, (uint64_t timeout, uint64_t * actualTimeout), (timeout, actualTimeout)) \
    _(aclError, aclrtGetOpTimeOutInterval, (uint64_t * interval), (interval)) \
    _(aclError, aclrtSetStreamOverflowSwitch, (aclrtStream stream, uint32_t flag), (stream, flag)) \
    _(aclError, aclrtGetStreamOverflowSwitch, (aclrtStream stream, uint32_t * flag), (stream, flag)) \
    _(aclError, aclrtSetDeviceSatMode, (aclrtFloatOverflowMode mode), (mode)) \
    _(aclError, aclrtGetDeviceSatMode, (aclrtFloatOverflowMode * mode), (mode)) \
    _(aclError, aclrtGetOverflowStatus, (void * outputAddr, size_t outputSize, aclrtStream stream), (outputAddr, outputSize, stream)) \
    _(aclError, aclrtResetOverflowStatus, (aclrtStream stream), (stream)) \
    _(aclError, aclrtQueryDeviceStatus, (int32_t deviceId, aclrtDeviceStatus * deviceStatus), (deviceId, deviceStatus)) \
    _(aclrtBinary, aclrtCreateBinary, (const void * data, size_t dataLen), (data, dataLen)) \
    _(aclError, aclrtDestroyBinary, (aclrtBinary binary), (binary)) \
    _(aclError, aclrtBinaryLoad, (const aclrtBinary binary, aclrtBinHandle * binHandle), (binary, binHandle)) \
    _(aclError, aclrtBinaryUnLoad, (aclrtBinHandle binHandle), (binHandle)) \
    _(aclError, aclrtBinaryGetFunction, (const aclrtBinHandle binHandle, const char * kernelName, aclrtFuncHandle * funcHandle), (binHandle, kernelName, funcHandle)) \
    _(aclError, aclrtLaunchKernel, (aclrtFuncHandle funcHandle, uint32_t numBlocks, const void * argsData, size_t argsSize, aclrtStream stream), (funcHandle, numBlocks, argsData, argsSize, stream)) \
    _(aclError, aclrtMemGetAccess, (void * virPtr, aclrtMemLocation * location, uint64_t * flag), (virPtr, location, flag)) \
    _(aclError, aclrtMemExportToShareableHandle, (aclrtDrvMemHandle handle, aclrtMemHandleType handleType, uint64_t flags, uint64_t * shareableHandle), (handle, handleType, flags, shareableHandle)) \
    _(aclError, aclrtMemExportToShareableHandleV2, (aclrtDrvMemHandle handle, uint64_t flags, aclrtMemSharedHandleType shareType, void * shareableHandle), (handle, flags, shareType, shareableHandle)) \
    _(aclError, aclrtMemImportFromShareableHandle, (uint64_t shareableHandle, int32_t deviceId, aclrtDrvMemHandle * handle), (shareableHandle, deviceId, handle)) \
    _(aclError, aclrtMemImportFromShareableHandleV2, (void * shareableHandle, aclrtMemSharedHandleType shareType, uint64_t flags, aclrtDrvMemHandle * handle), (shareableHandle, shareType, flags, handle)) \
    _(aclError, aclrtMemSetPidToShareableHandle, (uint64_t shareableHandle, int32_t * pid, size_t pidNum), (shareableHandle, pid, pidNum)) \
    _(aclError, aclrtMemSetPidToShareableHandleV2, (void * shareableHandle, aclrtMemSharedHandleType shareType, int32_t * pid, size_t pidNum), (shareableHandle, shareType, pid, pidNum)) \
    _(aclError, aclrtMemGetAllocationGranularity, (aclrtPhysicalMemProp * prop, aclrtMemGranularityOptions option, size_t * granularity), (prop, option, granularity)) \
    _(aclError, aclrtDeviceGetBareTgid, (int32_t * pid), (pid)) \
    _(aclError, aclrtCmoAsync, (void * src, size_t size, aclrtCmoType cmoType, aclrtStream stream), (src, size, cmoType, stream)) \
    _(aclError, aclrtGetMemUceInfo, (int32_t deviceId, aclrtMemUceInfo * memUceInfoArray, size_t arraySize, size_t * retSize), (deviceId, memUceInfoArray, arraySize, retSize)) \
    _(aclError, aclrtDeviceTaskAbort, (int32_t deviceId, uint32_t timeout), (deviceId, timeout)) \
    _(aclError, aclrtMemUceRepair, (int32_t deviceId, aclrtMemUceInfo * memUceInfoArray, size_t arraySize), (deviceId, memUceInfoArray, arraySize)) \
    _(aclError, aclrtStreamAbort, (aclrtStream stream), (stream)) \
    _(aclError, aclrtBinaryLoadFromFile, (const char* binPath, aclrtBinaryLoadOptions * options, aclrtBinHandle * binHandle), (binPath, options, binHandle)) \
    _(aclError, aclrtBinaryGetDevAddress, (const aclrtBinHandle binHandle, void ** binAddr, size_t * binSize), (binHandle, binAddr, binSize)) \
    _(aclError, aclrtBinaryGetFunctionByEntry, (aclrtBinHandle binHandle, uint64_t funcEntry, aclrtFuncHandle * funcHandle), (binHandle, funcEntry, funcHandle)) \
    _(aclError, aclrtGetFunctionAddr, (aclrtFuncHandle funcHandle, void ** aicAddr, void ** aivAddr), (funcHandle, aicAddr, aivAddr)) \
    _(aclError, aclrtGetMemcpyDescSize, (aclrtMemcpyKind kind, size_t * descSize), (kind, descSize)) \
    _(aclError, aclrtSetMemcpyDesc, (void * desc, aclrtMemcpyKind kind, void * srcAddr, void * dstAddr, size_t count, void * config), (desc, kind, srcAddr, dstAddr, count, config)) \
    _(aclError, aclrtMemcpyAsyncWithDesc, (void * desc, aclrtMemcpyKind kind, aclrtStream stream), (desc, kind, stream)) \
    _(aclError, aclrtMemcpyAsyncWithOffset, (void ** dst, size_t destMax, uint64_t dstDataOffset, const void ** src, size_t count, size_t srcDataOffset, aclrtMemcpyKind kind, aclrtStream stream), (dst, destMax, dstDataOffset, src, count, srcDataOffset, kind, stream)) \
    _(aclError, aclrtKernelArgsGetHandleMemSize, (aclrtFuncHandle funcHandle, size_t * memSize), (funcHandle, memSize)) \
    _(aclError, aclrtKernelArgsGetMemSize, (aclrtFuncHandle funcHandle, size_t userArgsSize, size_t * actualArgsSize), (funcHandle, userArgsSize, actualArgsSize)) \
    _(aclError, aclrtKernelArgsInit, (aclrtFuncHandle funcHandle, aclrtArgsHandle * argsHandle), (funcHandle, argsHandle)) \
    _(aclError, aclrtKernelArgsInitByUserMem, (aclrtFuncHandle funcHandle, aclrtArgsHandle argsHandle, void * userHostMem, size_t actualArgsSize), (funcHandle, argsHandle, userHostMem, actualArgsSize)) \
    _(aclError, aclrtKernelArgsAppend, (aclrtArgsHandle argsHandle, void * param, size_t paramSize, aclrtParamHandle * paramHandle), (argsHandle, param, paramSize, paramHandle)) \
    _(aclError, aclrtKernelArgsAppendPlaceHolder, (aclrtArgsHandle argsHandle, aclrtParamHandle * paramHandle), (argsHandle, paramHandle)) \
    _(aclError, aclrtKernelArgsGetPlaceHolderBuffer, (aclrtArgsHandle argsHandle, aclrtParamHandle paramHandle, size_t dataSize, void ** bufferAddr), (argsHandle, paramHandle, dataSize, bufferAddr)) \
    _(aclError, aclrtKernelArgsParaUpdate, (aclrtArgsHandle argsHandle, aclrtParamHandle paramHandle, void * param, size_t paramSize), (argsHandle, paramHandle, param, paramSize)) \
    _(aclError, aclrtLaunchKernelWithConfig, (aclrtFuncHandle funcHandle, uint32_t numBlocks, aclrtStream stream, aclrtLaunchKernelCfg * cfg, aclrtArgsHandle argsHandle, void * reserve), (funcHandle, numBlocks, stream, cfg, argsHandle, reserve)) \
    _(aclError, aclrtKernelArgsFinalize, (aclrtArgsHandle argsHandle), (argsHandle)) \
    _(aclError, aclrtValueWrite, (void* devAddr, uint64_t value, uint32_t flag, aclrtStream stream), (devAddr, value, flag, stream)) \
    _(aclError, aclrtValueWait, (void* devAddr, uint64_t value, uint32_t flag, aclrtStream stream), (devAddr, value, flag, stream)) \
    _(aclError, aclrtGetStreamAvailableNum, (uint32_t * streamCount), (streamCount)) \
    _(aclError, aclrtSetStreamAttribute, (aclrtStream stream, aclrtStreamAttr stmAttrType, aclrtStreamAttrValue * value), (stream, stmAttrType, value)) \
    _(aclError, aclrtGetStreamAttribute, (aclrtStream stream, aclrtStreamAttr stmAttrType, aclrtStreamAttrValue * value), (stream, stmAttrType, value)) \
    _(aclError, aclrtCreateNotify, (aclrtNotify * notify, uint64_t flag), (notify, flag)) \
    _(aclError, aclrtDestroyNotify, (aclrtNotify notify), (notify)) \
    _(aclError, aclrtCntNotifyCreate, (aclrtCntNotify * notify, uint64_t flag), (notify, flag)) \
    _(aclError, aclrtCntNotifyDestroy, (aclrtCntNotify notify), (notify)) \
    _(aclError, aclrtRecordNotify, (aclrtNotify notify, aclrtStream stream), (notify, stream)) \
    _(aclError, aclrtWaitAndResetNotify, (aclrtNotify notify, aclrtStream stream, uint32_t timeout), (notify, stream, timeout)) \
    _(aclError, aclrtGetNotifyId, (aclrtNotify notify, uint32_t * notifyId), (notify, notifyId)) \
    _(aclError, aclrtGetEventId, (aclrtEvent event, uint32_t * eventId), (event, eventId)) \
    _(aclError, aclrtGetEventAvailNum, (uint32_t * eventCount), (eventCount)) \
    _(aclError, aclrtGetDeviceInfo, (uint32_t deviceId, aclrtDevAttr attr, int64_t * value), (deviceId, attr, value)) \
    _(aclError, aclrtDeviceGetStreamPriorityRange, (int32_t * leastPriority, int32_t * greatestPriority), (leastPriority, greatestPriority)) \
    _(aclError, aclrtGetDeviceCapability, (int32_t deviceId, aclrtDevFeatureType devFeatureType, int32_t * value), (deviceId, devFeatureType, value)) \
    _(aclError, aclrtDeviceGetUuid, (int32_t deviceId, aclrtUuid * uuid), (deviceId, uuid)) \
    _(aclError, aclrtCtxGetCurrentDefaultStream, (aclrtStream * stream), (stream)) \
    _(aclError, aclrtGetPrimaryCtxState, (int32_t deviceId, uint32_t * flags, int32_t * active), (deviceId, flags, active)) \
    _(aclError, aclrtReduceAsync, (void * dst, const void * src, uint64_t count, aclrtReduceKind kind, aclDataType type, aclrtStream stream, void * reserve), (dst, src, count, kind, type, stream, reserve)) \
    _(aclError, aclrtSetDeviceWithoutTsdVXX, (int32_t deviceId), (deviceId)) \
    _(aclError, aclrtResetDeviceWithoutTsdVXX, (int32_t deviceId), (deviceId)) \
    _(aclError, aclrtGetDeviceResLimit, (int32_t deviceId, aclrtDevResLimitType type, uint32_t * value), (deviceId, type, value)) \
    _(aclError, aclrtSetDeviceResLimit, (int32_t deviceId, aclrtDevResLimitType type, uint32_t value), (deviceId, type, value)) \
    _(aclError, aclrtResetDeviceResLimit, (int32_t deviceId), (deviceId)) \
    _(aclError, aclrtGetStreamResLimit, (aclrtStream stream, aclrtDevResLimitType type, uint32_t * value), (stream, type, value)) \
    _(aclError, aclrtSetStreamResLimit, (aclrtStream stream, aclrtDevResLimitType type, uint32_t value), (stream, type, value)) \
    _(aclError, aclrtResetStreamResLimit, (aclrtStream stream), (stream)) \
    _(aclError, aclrtUseStreamResInCurrentThread, (aclrtStream stream), (stream)) \
    _(aclError, aclrtUnuseStreamResInCurrentThread, (aclrtStream stream), (stream)) \
    _(aclError, aclrtGetResInCurrentThread, (aclrtDevResLimitType type, uint32_t * value), (type, value)) \
    _(aclError, aclrtCreateLabel, (aclrtLabel * label), (label)) \
    _(aclError, aclrtSetLabel, (aclrtLabel label, aclrtStream stream), (label, stream)) \
    _(aclError, aclrtDestroyLabel, (aclrtLabel label), (label)) \
    _(aclError, aclrtCreateLabelList, (aclrtLabel * labels, size_t num, aclrtLabelList * labelList), (labels, num, labelList)) \
    _(aclError, aclrtDestroyLabelList, (aclrtLabelList labelList), (labelList)) \
    _(aclError, aclrtSwitchLabelByIndex, (void * ptr, uint32_t maxValue, aclrtLabelList labelList, aclrtStream stream), (ptr, maxValue, labelList, stream)) \
    _(aclError, aclrtActiveStream, (aclrtStream activeStream, aclrtStream stream), (activeStream, stream)) \
    _(aclError, aclrtSwitchStream, (void * leftValue, aclrtCondition cond, void * rightValue, aclrtCompareDataType dataType, aclrtStream trueStream, aclrtStream falseStream, aclrtStream stream), (leftValue, cond, rightValue, dataType, trueStream, falseStream, stream)) \
    _(aclError, aclrtGetFunctionName, (aclrtFuncHandle funcHandle, uint32_t maxLen, char * name), (funcHandle, maxLen, name)) \
    _(aclError, aclrtGetBufFromChain, (aclrtMbuf headBuf, uint32_t index, aclrtMbuf * buf), (headBuf, index, buf)) \
    _(aclError, aclrtGetBufChainNum, (aclrtMbuf headBuf, uint32_t * num), (headBuf, num)) \
    _(aclError, aclrtAppendBufChain, (aclrtMbuf headBuf, aclrtMbuf buf), (headBuf, buf)) \
    _(aclError, aclrtCopyBufRef, (const aclrtMbuf buf, aclrtMbuf * newBuf), (buf, newBuf)) \
    _(aclError, aclrtGetBufUserData, (const aclrtMbuf buf, void * dataPtr, size_t size, size_t offset), (buf, dataPtr, size, offset)) \
    _(aclError, aclrtSetBufUserData, (aclrtMbuf buf, const void * dataPtr, size_t size, size_t offset), (buf, dataPtr, size, offset)) \
    _(aclError, aclrtGetBufData, (const aclrtMbuf buf, void ** dataPtr, size_t * size), (buf, dataPtr, size)) \
    _(aclError, aclrtGetBufDataLen, (aclrtMbuf buf, size_t * len), (buf, len)) \
    _(aclError, aclrtSetBufDataLen, (aclrtMbuf buf, size_t len), (buf, len)) \
    _(aclError, aclrtFreeBuf, (aclrtMbuf buf), (buf)) \
    _(aclError, aclrtAllocBuf, (aclrtMbuf * buf, size_t size), (buf, size)) \
    _(aclError, aclrtBinaryLoadFromData, (const void * data, size_t length, const aclrtBinaryLoadOptions * options, aclrtBinHandle * binHandle), (data, length, options, binHandle)) \
    _(aclError, aclrtRegisterCpuFunc, (const aclrtBinHandle handle, const char * funcName, const char * kernelName, aclrtFuncHandle * funcHandle), (handle, funcName, kernelName, funcHandle)) \
    _(aclError, aclrtCmoAsyncWithBarrier, (void * src, size_t size, aclrtCmoType cmoType, uint32_t barrierId, aclrtStream stream), (src, size, cmoType, barrierId, stream)) \
    _(aclError, aclrtCmoWaitBarrier, (aclrtBarrierTaskInfo * taskInfo, aclrtStream stream, uint32_t flag), (taskInfo, stream, flag)) \
    _(aclError, aclrtGetDevicesTopo, (uint32_t deviceId, uint32_t otherDeviceId, uint64_t * value), (deviceId, otherDeviceId, value)) \
    _(aclError, aclrtMemcpyBatch, (void ** dsts, size_t * destMaxs, void ** srcs, size_t * sizes, size_t numBatches, aclrtMemcpyBatchAttr * attrs, size_t * attrsIndexes, size_t numAttrs, size_t * failIndex), (dsts, destMaxs, srcs, sizes, numBatches, attrs, attrsIndexes, numAttrs, failIndex)) \
    _(aclError, aclrtIpcMemGetExportKey, (void * devPtr, size_t size, char * key, size_t len, uint64_t flags), (devPtr, size, key, len, flags)) \
    _(aclError, aclrtMemcpyBatchAsync, (void ** dsts, size_t * destMaxs, void ** srcs, size_t * sizes, size_t numBatches, aclrtMemcpyBatchAttr * attrs, size_t * attrsIndexes, size_t numAttrs, size_t * failIndex, aclrtStream stream), (dsts, destMaxs, srcs, sizes, numBatches, attrs, attrsIndexes, numAttrs, failIndex, stream)) \
    _(aclError, aclrtIpcMemClose, (const char * key), (key)) \
    _(aclError, aclrtIpcMemImportByKey, (void ** devPtr, const char * key, uint64_t flags), (devPtr, key, flags)) \
    _(aclError, aclrtIpcMemSetImportPid, (const char * key, int32_t * pid, size_t num), (key, pid, num)) \
    _(aclError, aclrtIpcMemSetAttr, (const char * key, aclrtIpcMemAttrType type, uint64_t attr), (key, type, attr)) \
    _(aclError, aclrtIpcMemImportPidInterServer, (const char * key, aclrtServerPid * serverPids, size_t num), (key, serverPids, num)) \
    _(aclError, aclrtNotifyBatchReset, (aclrtNotify * notifies, size_t num), (notifies, num)) \
    _(aclError, aclrtNotifyGetExportKey, (aclrtNotify notify, char * key, size_t len, uint64_t flags), (notify, key, len, flags)) \
    _(aclError, aclrtNotifyImportByKey, (aclrtNotify * notify, const char * key, uint64_t flags), (notify, key, flags)) \
    _(aclError, aclrtNotifySetImportPid, (aclrtNotify notify, int32_t * pid, size_t num), (notify, pid, num)) \
    _(aclError, aclrtNotifySetImportPidInterServer, (aclrtNotify notify, aclrtServerPid * serverPids, size_t num), (notify, serverPids, num)) \
    _(aclError, aclrtCheckMemType, (void** addrList, uint32_t size, uint32_t memType, uint32_t * checkResult, uint32_t reserve), (addrList, size, memType, checkResult, reserve)) \
    _(aclError, aclrtGetLogicDevIdByUserDevId, (const int32_t userDevid, int32_t *const logicDevId), (userDevid, logicDevId)) \
    _(aclError, aclrtGetUserDevIdByLogicDevId, (const int32_t logicDevId, int32_t *const userDevid), (logicDevId, userDevid)) \
    _(aclError, aclrtGetLogicDevIdByPhyDevId, (const int32_t phyDevId, int32_t *const logicDevId), (phyDevId, logicDevId)) \
    _(aclError, aclrtGetPhyDevIdByLogicDevId, (const int32_t logicDevId, int32_t *const phyDevId), (logicDevId, phyDevId)) \
    _(aclError, aclrtProfTrace, (void * userdata, int32_t length, aclrtStream stream), (userdata, length, stream)) \
    _(aclError, aclrtLaunchKernelV2, (aclrtFuncHandle funcHandle, uint32_t numBlocks, const void * argsData, size_t argsSize, aclrtLaunchKernelCfg * cfg, aclrtStream stream), (funcHandle, numBlocks, argsData, argsSize, cfg, stream)) \
    _(aclError, aclrtLaunchKernelWithHostArgs, (aclrtFuncHandle funcHandle, uint32_t numBlocks, aclrtStream stream, aclrtLaunchKernelCfg * cfg, void * hostArgs, size_t argsSize, aclrtPlaceHolderInfo * placeHolderArray, size_t placeHolderNum), (funcHandle, numBlocks, stream, cfg, hostArgs, argsSize, placeHolderArray, placeHolderNum)) \
    _(aclError, aclrtCtxGetFloatOverflowAddr, (void ** overflowAddr), (overflowAddr)) \
    _(aclError, aclrtGetFloatOverflowStatus, (void * outputAddr, uint64_t outputSize, aclrtStream stream), (outputAddr, outputSize, stream)) \
    _(aclError, aclrtResetFloatOverflowStatus, (aclrtStream stream), (stream)) \
    _(aclError, aclrtNpuGetFloatOverFlowStatus, (void * outputAddr, uint64_t outputSize, uint32_t checkMode, aclrtStream stream), (outputAddr, outputSize, checkMode, stream)) \
    _(aclError, aclrtNpuClearFloatOverFlowStatus, (uint32_t checkMode, aclrtStream stream), (checkMode, stream)) \
    _(aclError, aclrtLaunchHostFunc, (aclrtStream stream, aclrtHostFunc fn, void * args), (stream, fn, args)) \
    _(aclError, aclrtGetHardwareSyncAddr, (void ** addr), (addr)) \
    _(aclError, aclrtRandomNumAsync, (const aclrtRandomNumTaskInfo * taskInfo, const aclrtStream stream, void * reserve), (taskInfo, stream, reserve)) \
    _(aclError, aclrtRegStreamStateCallback, (const char * regName, aclrtStreamStateCallback callback, void * args), (regName, callback, args)) \
    _(aclError, aclrtRegDeviceStateCallback, (const char * regName, aclrtDeviceStateCallback callback, void * args), (regName, callback, args)) \
    _(aclError, aclrtSetDeviceTaskAbortCallback, (const char * regName, aclrtDeviceTaskAbortCallback callback, void * args), (regName, callback, args)) \
    _(aclError, aclrtGetOpExecuteTimeout, (uint32_t *const timeoutMs), (timeoutMs)) \
    _(aclError, aclrtDevicePeerAccessStatus, (int32_t deviceId, int32_t peerDeviceId, int32_t * status), (deviceId, peerDeviceId, status)) \
    _(aclError, aclrtStreamStop, (aclrtStream stream), (stream)) \
    _(aclError, aclrtTaskUpdateAsync, (aclrtStream taskStream, uint32_t taskId, aclrtTaskUpdateInfo * info, aclrtStream execStream), (taskStream, taskId, info, execStream)) \
    _(aclError, aclrtCmoGetDescSize, (size_t * size), (size)) \
    _(aclError, aclrtCmoSetDesc, (void * cmoDesc, void * src, size_t size), (cmoDesc, src, size)) \
    _(aclError, aclrtCmoAsyncWithDesc, (void * cmoDesc, aclrtCmoType cmoType, aclrtStream stream, const void * reserve), (cmoDesc, cmoType, stream, reserve)) \
    _(aclError, aclrtCheckArchCompatibility, (const char * socVersion, int32_t * canCompatible), (socVersion, canCompatible)) \
    _(aclError, aclrtCntNotifyRecord, (aclrtCntNotify cntNotify, aclrtStream stream, aclrtCntNotifyRecordInfo * info), (cntNotify, stream, info)) \
    _(aclError, aclrtCntNotifyWaitWithTimeout, (aclrtCntNotify cntNotify, aclrtStream stream, aclrtCntNotifyWaitInfo * info), (cntNotify, stream, info)) \
    _(aclError, aclrtCntNotifyReset, (aclrtCntNotify cntNotify, aclrtStream stream), (cntNotify, stream)) \
    _(aclError, aclrtCntNotifyGetId, (aclrtCntNotify cntNotify, uint32_t * notifyId), (cntNotify, notifyId)) \
    _(aclError, aclrtPersistentTaskClean, (aclrtStream stream), (stream)) \
    _(aclError, aclrtGetErrorVerbose, (int32_t deviceId, aclrtErrorInfo * errorInfo), (deviceId, errorInfo)) \
    _(aclError, aclrtRepairError, (int32_t deviceId, const aclrtErrorInfo * errorInfo), (deviceId, errorInfo)) \
    _(aclError, aclrtMemSetAccess, (void * virPtr, size_t size, aclrtMemAccessDesc * desc, size_t count), (virPtr, size, desc, count)) \
    _(aclError, aclrtSnapShotProcessLock, (), ()) \
    _(aclError, aclrtSnapShotProcessUnlock, (), ()) \
    _(aclError, aclrtSnapShotProcessBackup, (), ()) \
    _(aclError, aclrtSnapShotProcessRestore, (), ()) \
    _(aclError, aclrtSnapShotCallbackRegister, (aclrtSnapShotStage stage, aclrtSnapShotCallBack callback, void * args), (stage, callback, args)) \
    _(aclError, aclrtSnapShotCallbackUnregister, (aclrtSnapShotStage stage, aclrtSnapShotCallBack callback), (stage, callback)) \
    _(aclError, aclrtCacheLastTaskOpInfo, (const void * const infoPtr, const size_t infoSize), (infoPtr, infoSize)) \
    _(aclError, aclrtGetFunctionAttribute, (aclrtFuncHandle funcHandle, aclrtFuncAttribute attrType, int64_t * attrValue), (funcHandle, attrType, attrValue)) \
    _(aclError, aclrtIpcGetEventHandle, (aclrtEvent event, aclrtIpcEventHandle * handle), (event, handle)) \
    _(aclError, aclrtIpcOpenEventHandle, (aclrtIpcEventHandle handle, aclrtEvent * event), (handle, event)) \
    _(aclError, aclrtMemRetainAllocationHandle, (void* virPtr, aclrtDrvMemHandle * handle), (virPtr, handle)) \
    _(aclError, aclrtMemGetAllocationPropertiesFromHandle, (aclrtDrvMemHandle handle, aclrtPhysicalMemProp* prop), (handle, prop)) \
    _(aclError, aclrtReserveMemAddressNoUCMemory, (void ** virPtr, size_t size, size_t alignment, void * expectPtr, uint64_t flags), (virPtr, size, alignment, expectPtr, flags)) \
    _(aclError, aclrtMemGetAddressRange, (void * ptr, void ** pbase, size_t * psize), (ptr, pbase, psize)) \
    _(const char *, aclrtGetSocName, (), ()) \
    _(aclError, aclrtGetVersion, (int32_t * majorVersion, int32_t * minorVersion, int32_t * patchVersion), (majorVersion, minorVersion, patchVersion)) \

// aclrtAllocator interface map list
#define ACL_RT_ALLOCATOR_FUNC_MAP(_)  \
    _(aclrtAllocatorDesc, aclrtAllocatorCreateDesc, (), ()) \
    _(aclError, aclrtAllocatorDestroyDesc, (aclrtAllocatorDesc allocatorDesc), (allocatorDesc)) \
    _(aclError, aclrtAllocatorSetObjToDesc, (aclrtAllocatorDesc allocatorDesc, aclrtAllocator allocator), (allocatorDesc, allocator)) \
    _(aclError, aclrtAllocatorSetAllocFuncToDesc, (aclrtAllocatorDesc allocatorDesc, aclrtAllocatorAllocFunc func), (allocatorDesc, func)) \
    _(aclError, aclrtAllocatorSetFreeFuncToDesc, (aclrtAllocatorDesc allocatorDesc, aclrtAllocatorFreeFunc func), (allocatorDesc, func)) \
    _(aclError, aclrtAllocatorSetAllocAdviseFuncToDesc, (aclrtAllocatorDesc allocatorDesc, aclrtAllocatorAllocAdviseFunc func), (allocatorDesc, func)) \
    _(aclError, aclrtAllocatorSetGetAddrFromBlockFuncToDesc, (aclrtAllocatorDesc allocatorDesc, aclrtAllocatorGetAddrFromBlockFunc func), (allocatorDesc, func)) \
    _(aclError, aclrtAllocatorRegister, (aclrtStream stream, aclrtAllocatorDesc allocatorDesc), (stream, allocatorDesc)) \
    _(aclError, aclrtAllocatorGetByStream, (aclrtStream stream, aclrtAllocatorDesc * allocatorDesc, aclrtAllocator * allocator, aclrtAllocatorAllocFunc * allocFunc, aclrtAllocatorFreeFunc * freeFunc, aclrtAllocatorAllocAdviseFunc * allocAdviseFunc, aclrtAllocatorGetAddrFromBlockFunc * getAddrFromBlockFunc), (stream, allocatorDesc, allocator, allocFunc, freeFunc, allocAdviseFunc, getAddrFromBlockFunc)) \
    _(aclError, aclrtAllocatorUnregister, (aclrtStream stream), (stream)) \

// aclmdlRI interface map list
#define ACL_MDLRI_FUNC_MAP(_)  \
    _(aclError, aclmdlRIExecuteAsync, (aclmdlRI modelRI, aclrtStream stream), (modelRI, stream)) \
    _(aclError, aclmdlRIDestroy, (aclmdlRI modelRI), (modelRI)) \
    _(aclError, aclmdlRICaptureBegin, (aclrtStream stream, aclmdlRICaptureMode mode), (stream, mode)) \
    _(aclError, aclmdlRICaptureGetInfo, (aclrtStream stream, aclmdlRICaptureStatus * status, aclmdlRI * modelRI), (stream, status, modelRI)) \
    _(aclError, aclmdlRICaptureEnd, (aclrtStream stream, aclmdlRI * modelRI), (stream, modelRI)) \
    _(aclError, aclmdlRIDebugPrint, (aclmdlRI modelRI), (modelRI)) \
    _(aclError, aclmdlRIDebugJsonPrint, (aclmdlRI modelRI, const char * path, uint32_t flags), (modelRI, path, flags)) \
    _(aclError, aclmdlRICaptureThreadExchangeMode, (aclmdlRICaptureMode * mode), (mode)) \
    _(aclError, aclmdlRICaptureTaskGrpBegin, (aclrtStream stream), (stream)) \
    _(aclError, aclmdlRICaptureTaskGrpEnd, (aclrtStream stream, aclrtTaskGrp * handle), (stream, handle)) \
    _(aclError, aclmdlRICaptureTaskUpdateBegin, (aclrtStream stream, aclrtTaskGrp handle), (stream, handle)) \
    _(aclError, aclmdlRICaptureTaskUpdateEnd, (aclrtStream stream), (stream)) \
    _(aclError, aclmdlRIBuildBegin, (aclmdlRI * modelRI, uint32_t flag), (modelRI, flag)) \
    _(aclError, aclmdlRIBindStream, (aclmdlRI modelRI, aclrtStream stream, uint32_t flag), (modelRI, stream, flag)) \
    _(aclError, aclmdlRIEndTask, (aclmdlRI modelRI, aclrtStream stream), (modelRI, stream)) \
    _(aclError, aclmdlRIBuildEnd, (aclmdlRI modelRI, void * reserve), (modelRI, reserve)) \
    _(aclError, aclmdlRIUnbindStream, (aclmdlRI modelRI, aclrtStream stream), (modelRI, stream)) \
    _(aclError, aclmdlRIExecute, (aclmdlRI modelRI, int32_t timeout), (modelRI, timeout)) \
    _(aclError, aclmdlRISetName, (aclmdlRI modelRI, const char * name), (modelRI, name)) \
    _(aclError, aclmdlRIGetName, (aclmdlRI modelRI, uint32_t maxLen, char * name), (modelRI, maxLen, name)) \
    _(aclError, aclmdlRIAbort, (aclmdlRI modelRI), (modelRI)) \
    
// aclmdl interface map list
#define ACL_MDL_FUNC_MAP(_)  \
    _(aclError, aclmdlInitDump, (), ()) \
    _(aclError, aclmdlSetDump, (const char * dumpCfgPath), (dumpCfgPath)) \
    _(aclError, aclmdlFinalizeDump, (), ()) \
    _(size_t, aclDataTypeSize, (aclDataType dataType), (dataType)) \
    _(aclDataBuffer *, aclCreateDataBuffer, (void *data, size_t size), (data, size)) \
    _(aclError, aclDestroyDataBuffer, (const aclDataBuffer * dataBuffer), (dataBuffer)) \
    _(aclError, aclUpdateDataBuffer, (aclDataBuffer * dataBuffer, void * data, size_t size), (dataBuffer, data, size)) \
    _(void *, aclGetDataBufferAddr, (const aclDataBuffer *dataBuffer), (dataBuffer)) \
    _(uint32_t, aclGetDataBufferSize, (const aclDataBuffer * dataBuffer), (dataBuffer)) \
    _(size_t, aclGetDataBufferSizeV2, (const aclDataBuffer * dataBuffer), (dataBuffer)) \
    

// acl interface map list
#define ACL_FUNC_MAP(_)  \
    _(aclError, aclInitCallbackRegister, (aclRegisterCallbackType type, aclInitCallbackFunc cbFunc, void * userData), (type, cbFunc, userData)) \
    _(aclError, aclInitCallbackUnRegister, (aclRegisterCallbackType type, aclInitCallbackFunc cbFunc), (type, cbFunc)) \
    _(aclError, aclFinalizeCallbackRegister, (aclRegisterCallbackType type, aclFinalizeCallbackFunc cbFunc, void * userData), (type, cbFunc, userData)) \
    _(aclError, aclFinalizeCallbackUnRegister, (aclRegisterCallbackType type, aclFinalizeCallbackFunc cbFunc), (type, cbFunc)) \
    _(aclError, aclInit, (const char * configPath), (configPath)) \
    _(aclError, aclFinalize, (), ()) \
    _(aclError, aclFinalizeReference, (uint64_t * refCount), (refCount)) \
    _(aclError, aclsysGetCANNVersion, (aclCANNPackageName name, aclCANNPackageVersion * version), (name, version)) \
    _(aclError, aclsysGetVersionStr, (char * pkgName, char * versionStr), (pkgName, versionStr)) \
    _(aclError, aclsysGetVersionNum, (char * pkgName, int32_t * versionNum), (pkgName, versionNum)) \
    _(aclError, aclGetCannAttributeList, (const aclCannAttr ** cannAttrList, size_t * num), (cannAttrList, num)) \
    _(aclError, aclGetCannAttribute, (aclCannAttr cannAttr, int32_t * value), (cannAttr, value)) \
    _(aclError, aclGetDeviceCapability, (uint32_t deviceId, aclDeviceInfo deviceInfo, int64_t * value), (deviceId, deviceInfo, value)) \
    _(float, aclFloat16ToFloat, (aclFloat16 value), (value)) \
    _(aclFloat16, aclFloatToFloat16, (float value), (value)) \
    _(const char *, aclGetRecentErrMsg, (), ()) \

#endif // RUNTIME_ACL_RT_WRAPPER_H_
