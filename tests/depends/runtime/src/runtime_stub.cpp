/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "runtime/dev.h"
#include "runtime/stream.h"
#include "runtime/context.h"
#include "runtime/event.h"
#include "runtime/mem.h"
#include "runtime/config.h"
#include "runtime/kernel.h"
#include "runtime/base.h"
#include "runtime/rt_mem_queue.h"
#include "runtime/rt_model.h"
#include "runtime/rts/rts.h"
#include "runtime/rt_stars_define.h"
#include "runtime/rts/rts_stars.h"
#include "runtime/rt_ras.h"
#include "rt_error_codes.h"
#include "acl/acl_base.h"

#include <stdlib.h>
#include <string.h>
#include "securec.h"
#include "acl_stub.h"

rtError_t aclStub::rtSetDevice(int32_t device)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtGetDevice(int32_t *device)
{
    *device = 0;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsGetDevice(int32_t *device)
{
    *device = 0;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtDeviceReset(int32_t device)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtDeviceResetForce(int32_t device)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtSetDeviceWithoutTsd(int32_t device)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtDeviceResetWithoutTsd(int32_t device)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtDeviceSynchronize(void)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtDeviceSynchronizeWithTimeout(int32_t timeout)
{
    (void)timeout;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtSetTSDevice(uint32_t tsId)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtStreamCreate(rtStream_t *stream, int32_t priority)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtStreamCreateWithFlags(rtStream_t *stream, int32_t priority, uint32_t flags)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsStreamCreate(rtStream_t *stream, rtStreamCreateConfig_t *config)
{
    if ((config == nullptr) || (config->numAttrs == 0)) {
        return ACL_ERROR_RT_PARAM_INVALID;
    }
    
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtStreamDestroy(rtStream_t stream)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtStreamDestroyForce(rtStream_t stream)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtStreamSynchronize(rtStream_t stream)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtStreamSynchronizeWithTimeout(rtStream_t stream, const int32_t timeout)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtStreamQuery(rtStream_t stream)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtStreamWaitEvent(rtStream_t stream, rtEvent_t event)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtStreamWaitEventWithTimeout(rtStream_t stream, rtEvent_t event, uint32_t timeout)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtStreamAbort(rtStream_t stream)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtCtxCreateEx(rtContext_t *ctx, uint32_t flags, int32_t device)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtCtxDestroyEx(rtContext_t ctx)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtCtxSetCurrent(rtContext_t ctx)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtCtxSynchronize()
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtCtxGetCurrent(rtContext_t *ctx)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtGetPriCtxByDeviceId(int32_t device, rtContext_t *ctx)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtEventCreateWithFlag(rtEvent_t *event_, uint32_t flag)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtEventCreateExWithFlag(rtEvent_t *event_, uint32_t flag)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtEventCreate(rtEvent_t *event)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsEventWait(rtStream_t stream, rtEvent_t event, uint32_t timeout)
{
    (void)stream;
    (void)event;
    (void)timeout;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtGetEventID(rtEvent_t event, uint32_t *eventId)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtEventDestroy(rtEvent_t event)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtEventRecord(rtEvent_t event, rtStream_t stream)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtEventReset(rtEvent_t event, rtStream_t stream)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtEventSynchronize(rtEvent_t event)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtEventSynchronizeWithTimeout(rtEvent_t event, int32_t timeout)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtEventQuery(rtEvent_t event)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtEventQueryStatus(rtEvent_t event, rtEventStatus_t *status)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtEventQueryWaitStatus(rtEvent_t event, rtEventWaitStatus *status)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtNotifyCreate(int32_t device_id, rtNotify_t *notify_)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtNotifyDestroy(rtNotify_t notify_)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtNotifyRecord(rtNotify_t notify_, rtStream_t stream_)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtGetNotifyID(rtNotify_t notify_, uint32_t *notify_id)
{
    *notify_id = 0;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtNotifyWait(rtNotify_t notify_, rtStream_t stream_)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMalloc(void **devPtr, uint64_t size, rtMemType_t type, uint16_t moduleId)
{
    *devPtr = malloc(size);
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMallocCached(void **devPtr, uint64_t size, rtMemType_t type, uint16_t moduleId)
{
    *devPtr = malloc(size);
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtFlushCache(void *devPtr, size_t size)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtInvalidCache(void *devPtr, size_t size)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtFree(void *devPtr)
{
    free(devPtr);
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtDvppMalloc(void **devPtr, uint64_t size, uint16_t moduleId)
{
    *devPtr = malloc(size);
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtDvppMallocWithFlag(void **devPtr, uint64_t size, uint32_t flag, uint16_t moduleId)
{
    *devPtr = malloc(size);
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtDvppFree(void *devPtr)
{
    free(devPtr);
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMallocHost(void **hostPtr,  uint64_t size, uint16_t moduleId)
{
    *hostPtr = malloc(size);
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtFreeHost(void *hostPtr)
{
    free(hostPtr);
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtFreeWithDevSync(void *devPtr)
{
    free(devPtr);
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtFreeHostWithDevSync(void *hostPtr)
{
    free(hostPtr);
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemset(void *devPtr, uint64_t destMax, uint32_t value, uint64_t count)
{
    memset(devPtr, value, count);
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemcpy(void *dst,  uint64_t destMax, const void *src, uint64_t count, rtMemcpyKind_t kind)
{
    memcpy(dst, src, count);
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemcpyAsync(void *dst,  uint64_t destMax, const void *src, uint64_t count, rtMemcpyKind_t kind, rtStream_t stream)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemcpyAsyncEx(void *dst, uint64_t destMax, const void *src, uint64_t count, rtMemcpyKind_t kind, rtStream_t stream, rtMemcpyConfig_t *memcpyConfig)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemsetAsync(void *ptr, uint64_t destMax, uint32_t value, uint64_t count, rtStream_t stream)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtCpuKernelLaunchWithFlag(const void *soName, const void *kernelName, uint32_t blockDim,
                                             const rtArgsEx_t *argsInfo, rtSmDesc_t *smDesc, rtStream_t stm,
                                             uint32_t flags)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemGetInfoEx(rtMemInfoType_t memInfoType, size_t *free, size_t *total)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtSubscribeReport(uint64_t threadId, rtStream_t stream)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtCallbackLaunch(rtCallback_t callBackFunc, void *fnData, rtStream_t stream, bool isBlock)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsLaunchHostFunc(rtStream_t stm, const rtCallback_t callBackFunc, void * const fnData)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtProcessReport(int32_t timeout)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtUnSubscribeReport(uint64_t threadId, rtStream_t stream)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtGetRunMode(rtRunMode *mode)
{
    *mode = RT_RUN_MODE_ONLINE;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtGetDeviceCount(int32_t *count)
{
    *count = 1;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtEventElapsedTime(float *time, rtEvent_t start, rtEvent_t end)
{
    *time = 1.0f;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtDevBinaryUnRegister(void *handle)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtDevBinaryRegister(const rtDevBinary_t *bin, void **handle)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtFunctionRegister(void *binHandle,
                            const void *stubFunc,
                            const char *stubName,
                            const void *devFunc,
                            uint32_t funcMode)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtKernelLaunch(const void *stubFunc,
                        uint32_t blockDim,
                        void *args,
                        uint32_t argsSize,
                        rtSmDesc_t *smDesc,
                        rtStream_t stream)
{
    return RT_ERROR_NONE;
}


rtError_t aclStub::rtRegTaskFailCallbackByModule(const char *moduleName, rtTaskFailCallback callback)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtGetSocVersion(char *version, const uint32_t maxLen)
{
    const char *socVersion = "Ascend910B1";
    memcpy_s(version, maxLen, socVersion, strlen(socVersion) + 1);
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtGetGroupCount(uint32_t *count)
{
    *count = 2;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtGetGroupInfo(int32_t groupid, rtGroupInfo_t* groupInfo, uint32_t count)
{
    for (uint32_t i = 0; i < count; ++i) {
        groupInfo[i].groupId = (int32_t)i;
        groupInfo[i].flag = (int32_t)i;
        groupInfo[i].aicoreNum = i + 1;
        groupInfo[i].aicpuNum = i + 2;
        groupInfo[i].aivectorNum = i + 3;
        groupInfo[i].sdmaNum = i + 4;
        groupInfo[i].activeStreamNum = i + 5;
    }
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtSetGroup(int32_t groupid)
{
    return RT_ERROR_NONE;
}

rtError_t rtProfRegisterCtrlCallback(uint32_t logId, rtProfCtrlHandle callback)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtGetDevicePhyIdByIndex(uint32_t devIndex, uint32_t *phyId)
{
    *phyId = 10;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtEnableP2P(uint32_t devIdDes, uint32_t phyIdSrc, uint32_t flag)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtDisableP2P(uint32_t devIdDes, uint32_t phyIdSrc)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtDeviceCanAccessPeer(int32_t* canAccessPeer, uint32_t device, uint32_t peerDevice)
{
    *canAccessPeer = 1;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtGetStreamId(rtStream_t stream_, int32_t *streamId)
{
    *streamId = 1;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtRegDeviceStateCallback(const char *regName, rtDeviceStateCallback callback)
{
    return RT_ERROR_NONE;
}
rtError_t aclStub::rtRegDeviceStateCallbackEx(const char *regName, rtDeviceStateCallback callback,
                                                const rtDevCallBackDir_t notifyPos) {
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtDeviceGetStreamPriorityRange(int32_t *leastPriority, int32_t *greatestPriority)
{
    *leastPriority = 7;
    *greatestPriority = 0;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtGetDeviceCapability(int32_t device, int32_t moduleType, int32_t featureType, int32_t *value)
{
    *value = 0;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtSetOpWaitTimeOut(uint32_t timeout)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtSetOpExecuteTimeOut(uint32_t timeout)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtSetOpExecuteTimeOutWithMs(uint32_t timeout)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtSetOpExecuteTimeOutV2(uint64_t timeout, uint64_t *actualTimeout)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtGetOpTimeOutInterval(uint64_t *interval)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtCtxSetSysParamOpt(const rtSysParamOpt configOpt, const int64_t configVal)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtCtxGetSysParamOpt(const rtSysParamOpt configOpt, int64_t * const configVal)
{
    *configVal = 0;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtSetSysParamOpt(const rtSysParamOpt configOpt, const int64_t configVal)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtGetSysParamOpt(const rtSysParamOpt configOpt, int64_t * const configVal)
{
    *configVal = 0;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtGetDeviceSatStatus(void * const outputAddrPtr, const uint64_t outputSize, rtStream_t stm)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtCleanDeviceSatStatus(rtStream_t stm)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemQueueInitQS(int32_t devId, const char* groupName)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemQueueCreate(int32_t devId, const rtMemQueueAttr_t *queAttr, uint32_t *qid)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemQueueDestroy(int32_t devId, uint32_t qid)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemQueueInit(int32_t devId)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemQueueEnQueue(int32_t devId, uint32_t qid, void *mbuf)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemQueueDeQueue(int32_t devId, uint32_t qid, void **mbuf)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemQueuePeek(int32_t devId, uint32_t qid, size_t *bufLen, int32_t timeout)
{
    *bufLen = 100;
    if (*bufLen == 1) {
        *bufLen = 0;
    }
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemQueueEnQueueBuff(int32_t devId, uint32_t qid, rtMemQueueBuff_t *inBuf, int32_t timeout)

{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemQueueDeQueueBuff(int32_t devId, uint32_t qid, rtMemQueueBuff_t *outBuf, int32_t timeout)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemQueueQuery(int32_t devId, rtMemQueueQueryCmd_t cmd, void *inBuff, uint32_t inLen,
                                  void *outBuff, uint32_t *outLen)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemQueueQueryInfo(int32_t device, uint32_t qid, rtMemQueueInfo_t *queueInfo)
{
    if (queueInfo != nullptr) {
        queueInfo->size = 4;
    }
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemQueueGrant(int32_t devId, uint32_t qid, int32_t pid, rtMemQueueShareAttr_t *attr)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemQueueAttach(int32_t devId, uint32_t qid, int32_t timeout)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtEschedSubmitEventSync(int32_t devId, rtEschedEventSummary_t *event, rtEschedEventReply_t *ack)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtQueryDevPid(rtBindHostpidInfo_t *info, pid_t *devPid)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMbufInit(rtMemBuffCfg_t *cfg)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMbufAlloc(rtMbufPtr_t *mbuf, uint64_t size)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMbufAllocEx(rtMbufPtr_t *mbuf, uint64_t size, uint64_t flag, int32_t grpId)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMbufGetBuffAddr(rtMbufPtr_t mbuf, void **databuf)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMbufGetBuffSize(rtMbufPtr_t mbuf, uint64_t *size)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMbufGetPrivInfo(rtMbufPtr_t mbuf, void **priv, uint64_t *size)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMbufCopyBufRef(rtMbufPtr_t mbuf, rtMbufPtr_t *newMbuf)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemGrpCreate(const char *name, const rtMemGrpConfig_t *cfg)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemGrpAddProc(const char *name, int32_t pid, const rtMemGrpShareAttr_t *attr)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemGrpAttach(const char *name, int32_t timeout)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemGrpQuery(rtMemGrpQueryInput_t * const input, rtMemGrpQueryOutput_t *output)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemcpy2d(void *dst, uint64_t dpitch, const void *src, uint64_t spitch, uint64_t width,
    uint64_t height, rtMemcpyKind_t kind)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemcpy2dAsync(void *dst, uint64_t dpitch, const void *src, uint64_t spitch, uint64_t width,
    uint64_t height, rtMemcpyKind_t kind, rtStream_t stream)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtGetDevMsg(rtGetDevMsgType_t getMsgType, rtGetMsgCallback callback)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtGetFaultEvent(const int32_t deviceId, rtDmsEventFilter *filter, rtDmsFaultEvent *dmsEvent,
                                   uint32_t len, uint32_t *eventCount)
{
    (void)deviceId;
    (void)filter;
    if (len > 0UL) {
        dmsEvent[0].eventId = 0UL;
        dmsEvent[0].eventName[0] = 'A';
        dmsEvent[0].eventName[1] = '\0';
        if (eventCount != nullptr) {
            *eventCount = 1UL;
        }
    }
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtIpcGetEventHandle(rtEvent_t event, rtIpcEventHandle_t *handle)
{
  return RT_ERROR_NONE;
}

rtError_t aclStub::rtIpcOpenEventHandle(rtIpcEventHandle_t handle, rtEvent_t *event)
{
  return RT_ERROR_NONE;
}

rtError_t aclStub::rtStreamSetMode(rtStream_t stm, const uint64_t mode)
{
  return RT_ERROR_NONE;
}

rtError_t aclStub::rtSetStreamOverflowSwitch(rtStream_t stm, uint32_t flags)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtGetStreamOverflowSwitch(rtStream_t stm, uint32_t *flags)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtSetDeviceSatMode(rtFloatOverflowMode_t floatOverflowMode)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtGetDeviceSatMode(rtFloatOverflowMode_t *floatOverflowMode)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtGetAiCoreCount(uint32_t *aiCoreCnt)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtGetDeviceInfo(uint32_t deviceId, int32_t moduleType, int32_t infoType, int64_t *val)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtGetAllUtilizations(const int32_t devId, const rtTypeUtil_t kind, uint8_t* const util){
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtReserveMemAddress(void **devPtr, size_t size, size_t alignment, void *devAddr, uint64_t flags) {
    *devPtr = (void*)0x01U;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtReleaseMemAddress(void *devPtr) {
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMallocPhysical(rtDrvMemHandle *handle, size_t size, rtDrvMemProp_t *prop, uint64_t flags) {     
    *handle = (rtDrvMemHandle)0x01U;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtFreePhysical(rtDrvMemHandle handle) {
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemRetainAllocationHandle(void* virPtr, rtDrvMemHandle *handle) {
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemGetAllocationPropertiesFromHandle(rtDrvMemHandle handle, rtDrvMemProp_t* prop) {
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMapMem(void *devPtr, size_t size, size_t offset, rtDrvMemHandle handle, uint64_t flags) {
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtUnmapMem(void *devPtr) {
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtBinaryLoadWithoutTilingKey(const void *data, const uint64_t length, rtBinHandle *binHandle)
{
  (void)data;
  (void)length;
  (void)binHandle;
  return RT_ERROR_NONE;
}

rtError_t aclStub::rtBinaryUnLoad(rtBinHandle binHandle)
{
  (void)binHandle;
  return RT_ERROR_NONE;
}

rtError_t aclStub::rtsFuncGetByName(const rtBinHandle binHandle, const char_t *kernelName, rtFuncHandle *funcHandle)
{
  (void)binHandle;
  (void)kernelName;
  (void)funcHandle;
  return RT_ERROR_NONE;
}

rtError_t aclStub::rtCreateLaunchArgs(size_t argsSize, size_t hostInfoTotalSize, size_t hostInfoNum,
    void* argsData, rtLaunchArgsHandle* argsHandle)
{
  (void)argsSize;
  (void)hostInfoTotalSize;
  (void)hostInfoNum;
  (void)argsData;
  (void)argsHandle;
  return RT_ERROR_NONE;
}

rtError_t aclStub::rtDestroyLaunchArgs(rtLaunchArgsHandle argsHandle)
{
  (void)argsHandle;
  return RT_ERROR_NONE;
}

rtError_t aclStub::rtLaunchKernelByFuncHandleV3(rtFuncHandle funcHandle, uint32_t blockDim,
                                                const rtArgsEx_t * const argsInfo,
                                                rtStream_t stm, const rtTaskCfgInfo_t * const cfgInfo)
{
  (void)funcHandle;
  (void)blockDim;
  (void)argsInfo;
  (void)stm;
  (void)cfgInfo;
  return RT_ERROR_NONE;
}

rtError_t aclStub::rtsLaunchKernelWithDevArgs(rtFuncHandle funcHandle, uint32_t blockDim,
                                              rtStream_t stm, rtKernelLaunchCfg_t *cfg,
                                              const void *args, uint32_t argsSize, void *reserve)
{
  (void)funcHandle;
  (void)blockDim;
  (void)stm;
  (void)cfg;
  (void)args;
  (void)argsSize;
  (void)reserve;
  return RT_ERROR_NONE;
}

rtError_t aclStub::rtsLaunchKernelWithHostArgs(rtFuncHandle funcHandle, uint32_t blockDim, rtStream_t stm,
                                               rtKernelLaunchCfg_t *cfg, void *hostArgs, uint32_t argsSize,
                                               rtPlaceHolderInfo_t *placeHolderArray, uint32_t placeHolderNum)
{
  (void)funcHandle;
  (void)blockDim;
  (void)stm;
  (void)cfg;
  (void)hostArgs;
  (void)argsSize;
  (void)placeHolderArray;
  (void)placeHolderNum;
  return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemExportToShareableHandle(rtDrvMemHandle handle, rtDrvMemHandleType handleType,
                                                uint64_t flag, uint64_t *shareableHandle)
{
  (void)handle;
  (void)handleType;
  (void)flag;
  (void)shareableHandle;
  return RT_ERROR_NONE;
}

rtError_t aclStub::rtsMemExportToShareableHandle(rtDrvMemHandle handle, rtDrvMemHandleType handleType,
    uint64_t flag, uint64_t *shareableHandle)
{
  (void)handle;
  (void)handleType;
  (void)flag;
  (void)shareableHandle;
  return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemExportToShareableHandleV2(rtDrvMemHandle handle, rtMemSharedHandleType handleType, uint64_t flags, 
    void *shareableHandle)
{
  (void)handle;
  (void)handleType;
  (void)flags;
  (void)shareableHandle;
  return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemImportFromShareableHandle(uint64_t shareableHandle, int32_t deviceId,
                                                  rtDrvMemHandle *handle)
{
  (void)shareableHandle;
  (void)deviceId;
  (void)handle;
  return RT_ERROR_NONE;
}

rtError_t aclStub::rtsMemImportFromShareableHandle(uint64_t shareableHandle, int32_t deviceId,
    rtDrvMemHandle *handle)
{
  (void)shareableHandle;
  (void)deviceId;
  (void)handle;
  return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemImportFromShareableHandleV2(const void *shareableHandle, rtMemSharedHandleType handleType, uint64_t flags,
    int32_t devId, rtDrvMemHandle *handle)
{
  (void)shareableHandle;
  (void)handleType;
  (void)flags;
  (void)devId;
  (void)handle;
  return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemSetPidToShareableHandle(uint64_t shareableHandle, int pid[], uint32_t pidNum)
{
  (void)shareableHandle;
  (void)pid;
  (void)pidNum;
  return RT_ERROR_NONE;
}

rtError_t aclStub::rtsMemSetPidToShareableHandle(uint64_t shareableHandle, int pid[], uint32_t pidNum)
{
  (void)shareableHandle;
  (void)pid;
  (void)pidNum;
  return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemSetPidToShareableHandleV2(const void *shareableHandle, rtMemSharedHandleType handleType, int pid[], uint32_t pidNum)
{
  (void)shareableHandle;
  (void)handleType;
  (void)pid;
  (void)pidNum;
  return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemGetAllocationGranularity(rtDrvMemProp_t *prop,
                                                 rtDrvMemGranularityOptions option, size_t *granularity)
{
  (void)prop;
  (void)option;
  (void)granularity;
  return RT_ERROR_NONE;
}

rtError_t aclStub::rtDeviceGetBareTgid(uint32_t *pid)
{
  (void)pid;
  return RT_ERROR_NONE;
}

rtError_t aclStub::rtDeviceStatusQuery(const uint32_t devId, rtDeviceStatus *deviceStatus)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtGetL2CacheOffset(uint32_t deivceId, uint64_t *offset)
{
    (void)offset;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtRegKernelLaunchFillFunc(const char *symbol, rtKernelLaunchFillFunc func)
{
    (void)symbol;
    (void)func;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtUnRegKernelLaunchFillFunc(const char *symbol)
{
    (void)symbol;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtGetMemUceInfo(const uint32_t deviceId, rtMemUceInfo *memUceInfo)
{
    (void)deviceId;
    memUceInfo->count = RT_MAX_RECORD_PA_NUM_PER_DEV;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemUceRepair(const uint32_t deviceId, rtMemUceInfo *memUceInfo)
{
    (void)deviceId;
    (void)memUceInfo;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtDeviceTaskAbort(int32_t devId, uint32_t timeout)
{
    (void)devId;
    (void)timeout;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemQueueReset(int32_t devId, uint32_t qid)
{
    (void)devId;
    (void)qid;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtSetDefaultDeviceId(int32_t deviceId)
{
    (void)deviceId;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtDeviceSetLimit(int32_t devId, rtLimitType_t type, uint32_t val)
{
    (void)devId;
    (void)type;
    (void)val;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtEventWorkModeSet(uint8_t event_mode)
{
    (void)event_mode;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtRegStreamStateCallback(const char *regName, rtStreamStateCallback callback)
{
    (void)regName;
    (void)callback;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtCtxGetCurrentDefaultStream(rtStream_t* stm)
{
    int tmp = 0x1;
    *stm = (rtStream_t)(&tmp);
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtCmoAsync(void *srcAddrPtr, size_t srcLen, rtCmoOpCode_t cmpType, rtStream_t stm)
{
    (void)srcAddrPtr;
    (void)srcLen;
    (void)cmpType;
    (void)stm;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsCmoAsync(void *srcAddrPtr, size_t srcLen, rtCmoOpCode_t cmoType, rtStream_t stm)
{
    (void)srcAddrPtr;
    (void)srcLen;
    (void)cmoType;
    (void)stm;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtStreamBeginCapture(rtStream_t stm, const rtStreamCaptureMode mode)
{
    (void)stm;
    (void)mode;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtStreamGetCaptureInfo(rtStream_t stm, rtStreamCaptureStatus *const status, rtModel_t *captureMdl)
{
    (void)stm;
    (void)status;
    (void)captureMdl;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtStreamEndCapture(rtStream_t stm, rtModel_t *captureMdl)
{
    (void)stm;
    (void)captureMdl;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtCacheLastTaskOpInfo(const void * const infoPtr, const size_t infoSize)
{
    (void)infoPtr;
    (void)infoSize;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtFunctionGetAttribute(rtFuncHandle funcHandle, rtFuncAttribute attrType, int64_t *attrValue)
{
    (void)funcHandle;
    (void)attrType;
    (void)attrValue;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtModelDebugDotPrint(rtModel_t mdl)
{
    (void)mdl;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtModelDebugJsonPrint(rtModel_t mdl, const char *path, uint32_t flags)
{
    (void)mdl;
    (void)path;
    (void)flags;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtThreadExchangeCaptureMode(rtStreamCaptureMode *mode)
{
    (void)mode;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtModelExecute(rtModel_t mdl, rtStream_t stm, uint32_t flag)
{
    (void)mdl;
    (void)stm;
    (void)flag;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtModelDestroy(rtModel_t mdl)
{
    (void)mdl;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsMemcpyAsyncWithDesc(rtMemcpyDesc_t desc, rtMemcpyKind kind, rtMemcpyConfig_t *config, rtStream_t stream)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemcpyAsyncWithOffset(void **dst, uint64_t dstMax, uint64_t dstDataOffset, const void **src,
    uint64_t count, uint64_t srcDataOffset, rtMemcpyKind kind, rtStream_t stream)
{
    (void)dst;
    (void)dstMax;
    (void)dstDataOffset;
    (void)src;
    (void)count;
    (void)srcDataOffset;
    (void)kind;
    (void)stream;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsGetMemcpyDescSize(rtMemcpyKind kind, size_t *size)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsSetMemcpyDesc(rtMemcpyDesc_t desc, rtMemcpyKind kind, void *srcAddr, void *dstAddr, size_t count, rtMemcpyConfig_t *config)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsBinaryLoadFromFile(const char * const binPath, const rtLoadBinaryConfig_t * const optionalCfg,
                                         rtBinHandle *handle)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsBinaryGetDevAddress(const rtBinHandle binHandle, void **bin, uint32_t *binSize)
{
    (void)binHandle;
    (void)bin;
    (void)binSize;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsFuncGetByEntry(const rtBinHandle binHandle, const uint64_t funcEntry, rtFuncHandle *funcHandle)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsFuncGetAddr(const rtFuncHandle funcHandle, void **aicAddr, void **aivAddr)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsLaunchKernelWithConfig(rtFuncHandle funcHandle, uint32_t blockDim, rtStream_t stm,
                                             rtKernelLaunchCfg_t *cfg, rtArgsHandle argsHandle, void *reserve)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsKernelArgsInit(rtFuncHandle funcHandle, rtArgsHandle *handle)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsKernelArgsFinalize(rtArgsHandle argsHandle)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsKernelArgsAppend(rtArgsHandle handle, void *para, size_t paraSize, rtParaHandle *paraHandle)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsKernelArgsAppendPlaceHolder(rtArgsHandle handle, rtParaHandle *paraHandle)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsKernelArgsParaUpdate(rtArgsHandle argsHandle, rtParaHandle paraHandle, void *para,
                                           size_t paraSize)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsKernelArgsInitByUserMem(rtFuncHandle funcHandle, rtArgsHandle argsHandle, void *userHostMem,
                                              size_t actualArgsSize)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsKernelArgsGetMemSize(rtFuncHandle funcHandle, size_t userArgsSize, size_t *actualArgsSize)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsKernelArgsGetHandleMemSize(rtFuncHandle funcHandle, size_t *memSize)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsKernelArgsGetPlaceHolderBuffer(rtArgsHandle argsHandle, rtParaHandle paraHandle,
                                                     size_t dataSize, void **bufferAddr)
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsMalloc(void **devPtr, uint64_t size, rtMallocPolicy policy, rtMallocAdvise advise, rtMallocConfig_t *cfg)
{
    (void)devPtr;
    (void)size;
    (void)policy;
    (void)advise;
    (void)cfg;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsMallocHost(void **hostPtr, uint64_t size, const rtMallocConfig_t *cfg)
{
    (void)hostPtr;
    (void)size;
    (void)cfg;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsPointerGetAttributes(const void *ptr, rtPtrAttributes_t *attributes)
{
    (void)ptr;
    (void)attributes;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsHostRegister(void *ptr, uint64_t size, rtHostRegisterType type, void **devPtr)
{
    (void)ptr;
    (void)size;
    (void)type;
    (void)devPtr;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsHostUnregister(void *ptr)
{
    (void)ptr;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsGetThreadLastTaskId(uint32_t *taskId)
{
    (void)taskId;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsStreamGetId(rtStream_t stm, int32_t *streamId)
{
    (void)stm;
    (void)streamId;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsStreamBeginTaskGrp(rtStream_t stm)
{
    (void)stm;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsStreamEndTaskGrp(rtStream_t stm, rtTaskGrp_t *handle)
{
    (void)stm;
    (void)handle;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsStreamBeginTaskUpdate(rtStream_t stm, rtTaskGrp_t handle)
{
    (void)stm;
    (void)handle;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsStreamEndTaskUpdate(rtStream_t stm)
{
    (void)stm;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsValueWrite(const void * const devAddr, const uint64_t value, const uint32_t flag, rtStream_t stm)
{
    (void)devAddr;
    (void)value;
    (void)flag;
    (void)stm;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsValueWait(const void * const devAddr, const uint64_t value, const uint32_t flag, rtStream_t stm)
{
    (void)devAddr;
    (void)value;
    (void)flag;
    (void)stm;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsStreamGetAvailableNum(uint32_t *streamCount)
{
    (void)streamCount;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsStreamSetAttribute(rtStream_t stm, rtStreamAttr stmAttrId, rtStreamAttrValue_t *attrValue)
{
    (void)stm;
    (void)stmAttrId;
    (void)attrValue;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsStreamGetAttribute(rtStream_t stm, rtStreamAttr stmAttrId, rtStreamAttrValue_t *attrValue)
{
    (void)stm;
    (void)stmAttrId;
    (void)attrValue;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsNotifyCreate(rtNotify_t *notify, uint64_t flag)
{
    (void)notify;
    (void)flag;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsNotifyDestroy(rtNotify_t notify)
{
    (void)notify;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtCntNotifyCreateServer(rtCntNotify_t *cntNotify, uint64_t flag)
{
    (void)cntNotify;
    (void)flag;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtCntNotifyDestroy(rtCntNotify_t cntNotify)
{
    (void)cntNotify;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsNotifyRecord(rtNotify_t notify, rtStream_t stream)
{
    (void)notify;
    (void)stream;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsNotifyWaitAndReset(rtNotify_t notify, rtStream_t stream, uint32_t timeout)
{
    (void)notify;
    (void)stream;
    (void)timeout;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsNotifyGetId(rtNotify_t notify, uint32_t *notifyId)
{
    (void)notify;
    (void)notifyId;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsEventGetId(rtEvent_t event, uint32_t *eventId)
{
    (void)event;
    (void)eventId;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsEventGetAvailNum(uint32_t *eventCount)
{
    (void)eventCount;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsDeviceGetInfo(uint32_t deviceId, rtDevAttr attr, int64_t *val)
{
    (void)deviceId;
    (void)attr;
    (void)val;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsDeviceGetStreamPriorityRange(int32_t *leastPriority, int32_t *greatestPriority)
{
    (void)leastPriority;
    (void)greatestPriority;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsDeviceGetCapability(int32_t deviceId, int32_t devFeatureType, int32_t *val)
{
    (void)deviceId;
    (void)devFeatureType;
    (void)val;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtGetDeviceUuid(int32_t deviceId, rtUuid_t *uuid)
{
    (void)deviceId;
    (void)uuid;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsCtxGetCurrentDefaultStream(rtStream_t *stm)
{
    (void)stm;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsGetPrimaryCtxState(const int32_t devId, uint32_t *flags, int32_t *active)
{
    (void)devId;
    (void)flags;
    (void)active;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsModelCreate(rtModel_t *mdl, uint32_t flag)
{
    (void)mdl;
    (void)flag;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsModelBindStream(rtModel_t mdl, rtStream_t stm, uint32_t flag)
{
    (void)mdl;
    (void)stm;
    (void)flag;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsEndGraph(rtModel_t mdl, rtStream_t stm)
{
    (void)mdl;
    (void)stm;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsModelLoadComplete(rtModel_t mdl, void *reserve)
{
    (void)mdl;
    (void)reserve;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsModelUnbindStream(rtModel_t mdl, rtStream_t stm)
{
    (void)mdl;
    (void)stm;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsModelExecute(rtModel_t mdl, int32_t timeout)
{
    (void)mdl;
    (void)timeout;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsLaunchReduceAsyncTask(const rtReduceInfo_t *reduceInfo, const rtStream_t stm, const void *reserve)
{
    (void)reduceInfo;
    (void)stm;
    (void)reserve;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsGetDeviceResLimit(const int32_t deviceId, const rtDevResLimitType_t type, uint32_t *value)
{
    (void)deviceId;
    (void)type;
    (void)value;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsSetDeviceResLimit(const int32_t deviceId, const rtDevResLimitType_t type, uint32_t value)
{
    (void)deviceId;
    (void)type;
    (void)value;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsResetDeviceResLimit(const int32_t deviceId)
{
    (void)deviceId;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsGetStreamResLimit(rtStream_t stream, const rtDevResLimitType_t type, uint32_t *value)
{
    (void)stream;
    (void)type;
    (void)value;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsSetStreamResLimit(rtStream_t stream, const rtDevResLimitType_t type, uint32_t value)
{
    (void)stream;
    (void)type;
    (void)value;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsResetStreamResLimit(rtStream_t stream)
{
    (void)stream;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsUseStreamResInCurrentThread(rtStream_t stream)
{
    (void)stream;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsNotUseStreamResInCurrentThread(rtStream_t stream)
{
    (void)stream;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsGetResInCurrentThread(const rtDevResLimitType_t type, uint32_t *value)
{
    (void)type;
    (void)value;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsMemcpyBatch(void **dsts, void **srcs, size_t *sizes, size_t count, rtMemcpyBatchAttr *attrs,
    size_t *attrsIdxs, size_t numAttrs, size_t *failIdx)
{
    (void)dsts;
    (void)srcs;
    (void)sizes;
    (void)count;
    (void)attrs;
    (void)attrsIdxs;
    (void)numAttrs;
    (void)failIdx;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsMemcpyBatchAsync(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t count,
    rtMemcpyBatchAttr *attrs, size_t *attrsIdxs, size_t numAttrs, size_t *failIdx, rtStream_t stream)
{
    (void)dsts;
    (void)destMaxs;
    (void)srcs;
    (void)sizes;
    (void)count;
    (void)attrs;
    (void)attrsIdxs;
    (void)numAttrs;
    (void)failIdx;
    (void)stream;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsLabelCreate(rtLabel_t *lbl)
{
    (void)lbl;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsLabelSet(rtLabel_t lbl, rtStream_t stm)
{
    (void)lbl;
    (void)stm;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsLabelDestroy(rtLabel_t lbl)
{
    (void)lbl;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsLabelSwitchListCreate(rtLabel_t *labels, size_t num, void **labelList)
{
    (void)labels;
    (void)num;
    (void)labelList;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsLabelSwitchListDestroy(void *labelList)
{
    (void)labelList;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsLabelSwitchByIndex(void *ptr, uint32_t maxValue, void *labelInfoPtr, rtStream_t stm)
{
    (void)ptr;
    (void)maxValue;
    (void)labelInfoPtr;
    (void)stm;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsActiveStream(rtStream_t activeStream, rtStream_t stream)
{
    (void)activeStream;
    (void)stream;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsSwitchStream(void *leftValue, rtCondition_t cond, void *rightValue, rtSwitchDataType_t dataType, rtStream_t trueStream, rtStream_t falseStream, rtStream_t stream)
{
    (void)leftValue;
    (void)cond;
    (void)rightValue;
    (void)dataType;
    (void)trueStream;
    (void)falseStream;
    (void)stream;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsFuncGetName(const rtFuncHandle funcHandle, const uint32_t maxLen, char_t * const name)
{
    (void)funcHandle;
    (void)maxLen;
    (void)name;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsModelSetName(rtModel_t mdl, const char_t *mdlName)
{
    (void)mdl;
    (void)mdlName;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsModelGetName(rtModel_t mdl, const uint32_t maxLen, char_t * const mdlName)
{
    (void)mdl;
    (void)maxLen;
    (void)mdlName;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsBinaryLoadFromData(const void *const data, const uint64_t length, const rtLoadBinaryConfig_t *const optionalCfg, rtBinHandle *handle)
{
    (void)data;
    (void)length;
    (void)optionalCfg;
    (void)handle;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsRegisterCpuFunc(rtBinHandle binHandle, const char_t *const funcName, const char_t *const kernelName, rtFuncHandle *funcHandle)
{
    (void)binHandle;
    (void)funcName;
    (void)kernelName;
    (void)funcHandle;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsCmoAsyncWithBarrier(void *srcAddrPtr, size_t srcLen, rtCmoOpCode cmoType, uint32_t logicId, rtStream_t stm)
{
    (void)srcAddrPtr;
    (void)srcLen;
    (void)cmoType;
    (void)logicId;
    (void)stm;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsLaunchBarrierTask(rtBarrierTaskInfo_t *taskInfo, rtStream_t stm, uint32_t flag)
{
    (void)taskInfo;
    (void)stm;
    (void)flag;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsGetPairDevicesInfo(uint32_t devId, uint32_t otherDevId, int32_t infoType, uint64_t *val)
{
    (void)devId;
    (void)otherDevId;
    (void)infoType;
    (void)val;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsIpcMemGetExportKey(const void *ptr, size_t size, char_t *key, uint32_t len, uint64_t flags)
{
    (void)ptr;
    (void)size;
    (void)key;
    (void)len;
    (void)flags;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsIpcMemClose(const char_t *key)
{
    (void)key;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsIpcMemImportByKey(void **ptr, const char_t *key, uint64_t flags)
{
    (void)ptr;
    (void)key;
    (void)flags;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsIpcMemSetImportPid(const char_t *key, int32_t pid[], int num)
{
    (void)key;
    (void)pid;
    (void)num;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtIpcSetMemoryAttr(const char *key, uint32_t type, uint64_t attr)
{
    (void)key;
    (void)type;
    (void)attr;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtIpcMemImportPidInterServer(const char *key, const rtServerPid *serverPids, size_t num)
{
    (void)key;
    (void)serverPids;
    (void)num;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsNotifyBatchReset(rtNotify_t *notifies, uint32_t num)
{
    (void)notifies;
    (void)num;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsNotifyGetExportKey(rtNotify_t notify, char_t *key, uint32_t len, uint64_t flags)
{
    (void)notify;
    (void)key;
    (void)len;
    (void)flags;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsNotifyImportByKey(rtNotify_t *notify, const char_t *key, uint64_t flags)
{
    (void)notify;
    (void)key;
    (void)flags;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsNotifySetImportPid(rtNotify_t notify, int32_t pid[], int num)
{
    (void)notify;
    (void)pid;
    (void)num;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtNotifySetImportPidInterServer(rtNotify_t notify, const rtServerPid *serverPids, size_t num)
{
    (void)notify;
    (void)serverPids;
    (void)num;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsCheckMemType(void** addrList, uint32_t size, uint32_t memType, uint32_t *checkResult, uint32_t reserve)
{
    (void)addrList;
    (void)size;
    (void)memType;
    (void)checkResult;
    (void)reserve;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsGetLogicDevIdByUserDevId(const int32_t userDevid, int32_t *const logicDevId)
{
    (void)userDevid;
    (void)logicDevId;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsGetUserDevIdByLogicDevId(const int32_t logicDevId, int32_t *const userDevid)
{
    (void)logicDevId;
    (void)userDevid;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsGetLogicDevIdByPhyDevId(int32_t phyDevId, int32_t *const logicDevId)
{
    (void)phyDevId;
    (void)logicDevId;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsGetPhyDevIdByLogicDevId(int32_t logicDevId, int32_t *const phyDevId)
{
    (void)logicDevId;
    (void)phyDevId;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsProfTrace(void *userdata, int32_t length, rtStream_t stream)
{
    (void)userdata;
    (void)length;
    (void)stream;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsCtxGetFloatOverflowAddr(void **overflowAddr)
{
    (void)overflowAddr;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsGetFloatOverflowStatus(void *const outputAddr, const uint64_t outputSize, rtStream_t stm)
{
    (void)outputAddr;
    (void)outputSize;
    (void)stm;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsResetFloatOverflowStatus(rtStream_t stm)
{
    (void)stm;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsNpuGetFloatOverFlowStatus(void *const outputAddr, const uint64_t outputSize, uint32_t checkMode,
                                                rtStream_t stm)
{
    (void)outputAddr;
    (void)outputSize;
    (void)checkMode;
    (void)stm;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsNpuClearFloatOverFlowStatus(uint32_t checkMode, rtStream_t stm)
{
    (void)checkMode;
    (void)stm;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsGetHardwareSyncAddr(void **addr)
{
    (void)addr;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsLaunchRandomNumTask(const rtRandomNumTaskInfo_t *taskInfo, const rtStream_t stream, void *reserve)
{
    (void)taskInfo;
    (void)stream;
    (void)reserve;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsRegStreamStateCallback(const char_t *regName, rtsStreamStateCallback callback, void *args)
{
    (void)regName;
    (void)callback;
    (void)args;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsRegDeviceStateCallback(const char_t *regName, rtsDeviceStateCallback callback, void *args)
{
    (void)regName;
    (void)callback;
    (void)args;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsSetDeviceTaskAbortCallback(const char_t *regName, rtsDeviceTaskAbortCallback callback, void *args)
{
    (void)regName;
    (void)callback;
    (void)args;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtGetOpExecuteTimeoutV2(uint32_t * const timeoutMs)
{
    (void)timeoutMs;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsGetP2PStatus(uint32_t devIdDes, uint32_t phyIdSrc, uint32_t *status)
{
    (void)devIdDes;
    (void)phyIdSrc;
    (void)status;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsStreamStop(rtStream_t stream)
{
    (void)stream;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsLaunchUpdateTask(rtStream_t taskStream, uint32_t taskId, rtStream_t execStream, rtTaskUpdateCfg_t *info)
{
    (void)taskStream;
    (void)taskId;
    (void)execStream;
    (void)info;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsGetCmoDescSize(size_t *size)
{
    (void)size;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsSetCmoDesc(rtCmoDesc_t cmoDesc, void *memAddr, size_t memLen)
{
    (void)cmoDesc;
    (void)memAddr;
    (void)memLen;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsLaunchCmoAddrTask(rtCmoDesc_t cmoDesc, rtStream_t stream, rtCmoOpCode cmoType, const void *reserve)
{
    (void)cmoDesc;
    (void)stream;
    (void)cmoType;
    (void)reserve;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsModelAbort(rtModel_t modelRI)
{
    (void)modelRI;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtCheckArchCompatibility(const char_t* socVersion, int32_t* canCompatible)
{
    (void)socVersion;
    (void)canCompatible;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsCntNotifyRecord(rtCntNotify_t cntNotify, rtStream_t stream,
                                      rtCntNotifyRecordInfo_t *info)
{
    (void)cntNotify;
    (void)stream;
    (void)info;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsCntNotifyWaitWithTimeout(rtCntNotify_t cntNotify, rtStream_t stream,
                                               rtCntNotifyWaitInfo_t *info)
{
    (void)cntNotify;
    (void)stream;
    (void)info;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsCntNotifyReset(rtCntNotify_t cntNotify, rtStream_t stream)
{
    (void)cntNotify;
    (void)stream;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsCntNotifyGetId(rtCntNotify_t cntNotify, uint32_t *notifyId)
{
    (void)cntNotify;
    (void)notifyId;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsPersistentTaskClean(rtStream_t stream)
{
    (void)stream;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsGetErrorVerbose(uint32_t deviceId, rtErrorInfo* errorInfo)
{
    (void)deviceId;
    (void)errorInfo;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtsRepairError(uint32_t deviceId, const rtErrorInfo* errorInfo)
{
    (void)deviceId;
    (void)errorInfo;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemSetAccess(void *virPtr, size_t size, rtMemAccessDesc *desc, size_t count)
{
    (void)virPtr;
    (void)size;
    (void)desc;
    (void)count;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtMemGetAccess(void *virPtr, rtMemLocation *location, uint64_t *flag)
{
    (void)virPtr;
    (void)location;
    (void)flag;
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtSnapShotProcessLock()
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtSnapShotProcessUnlock()
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtSnapShotProcessBackup()
{
    return RT_ERROR_NONE;
}

rtError_t aclStub::rtSnapShotProcessRestore()
{
    return RT_ERROR_NONE;
}

MockFunctionTest& MockFunctionTest::aclStubInstance()
{
    static MockFunctionTest stub;
    return stub;
}

rtError_t rtsGetErrorVerbose(uint32_t deviceId, rtErrorInfo* errorInfo)
{
    return MockFunctionTest::aclStubInstance().rtsGetErrorVerbose(deviceId, errorInfo);
}

rtError_t rtsRepairError(uint32_t deviceId, const rtErrorInfo* errorInfo)
{
    return MockFunctionTest::aclStubInstance().rtsRepairError(deviceId, errorInfo);
}

rtError_t rtSnapShotProcessLock()
{
  return MockFunctionTest::aclStubInstance().rtSnapShotProcessLock();
}

rtError_t rtSnapShotProcessUnlock()
{
  return MockFunctionTest::aclStubInstance().rtSnapShotProcessUnlock();
}

rtError_t rtSnapShotProcessBackup()
{
  return MockFunctionTest::aclStubInstance().rtSnapShotProcessBackup();
}

rtError_t rtSnapShotProcessRestore()
{
  return MockFunctionTest::aclStubInstance().rtSnapShotProcessRestore();
}

rtError_t rtSetDevice(int32_t device)
{
    return MockFunctionTest::aclStubInstance().rtSetDevice(device);
}

rtError_t rtDeviceReset(int32_t device)
{
    return MockFunctionTest::aclStubInstance().rtDeviceReset(device);
}

rtError_t rtDeviceResetForce(int32_t device)
{
    return MockFunctionTest::aclStubInstance().rtDeviceResetForce(device);
}

rtError_t rtSetDeviceWithoutTsd(int32_t device)
{
    return MockFunctionTest::aclStubInstance().rtSetDeviceWithoutTsd(device);
}

rtError_t rtDeviceResetWithoutTsd(int32_t device)
{
    return MockFunctionTest::aclStubInstance().rtDeviceResetWithoutTsd(device);
}

rtError_t rtDeviceSynchronize(void)
{
    return MockFunctionTest::aclStubInstance().rtDeviceSynchronize();
}

rtError_t rtDeviceSynchronizeWithTimeout(int32_t timeout)
{
    return MockFunctionTest::aclStubInstance().rtDeviceSynchronizeWithTimeout(timeout);
}

rtError_t rtGetDevice(int32_t *device)
{
    *device = 0;
    return MockFunctionTest::aclStubInstance().rtGetDevice(device);
}

rtError_t rtsGetDevice(int32_t *device)
{
    *device = 0;
    return MockFunctionTest::aclStubInstance().rtsGetDevice(device);
}

rtError_t rtSetTSDevice(uint32_t tsId)
{
    return MockFunctionTest::aclStubInstance().rtSetTSDevice(tsId);
}

rtError_t rtStreamCreate(rtStream_t *stream, int32_t priority)
{
    return MockFunctionTest::aclStubInstance().rtStreamCreate(stream, priority);
}

rtError_t rtStreamCreateWithFlags(rtStream_t *stream, int32_t priority, uint32_t flags)
{
    return MockFunctionTest::aclStubInstance().rtStreamCreateWithFlags(stream, priority, flags);
}

rtError_t rtsStreamCreate(rtStream_t *stream, rtStreamCreateConfig_t *config)
{
    return MockFunctionTest::aclStubInstance().rtsStreamCreate(stream, config);
}

rtError_t rtStreamDestroy(rtStream_t stream)
{
    return MockFunctionTest::aclStubInstance().rtStreamDestroy(stream);
}

rtError_t rtStreamDestroyForce(rtStream_t stream)
{
    return MockFunctionTest::aclStubInstance().rtStreamDestroyForce(stream);
}

rtError_t rtStreamSynchronize(rtStream_t stream)
{
    return MockFunctionTest::aclStubInstance().rtStreamSynchronize(stream);
}

rtError_t rtStreamSynchronizeWithTimeout(rtStream_t stream, const int32_t timeout)
{
    return MockFunctionTest::aclStubInstance().rtStreamSynchronizeWithTimeout(stream, timeout);
}

rtError_t rtStreamQuery(rtStream_t stream)
{
    return MockFunctionTest::aclStubInstance().rtStreamQuery(stream);
}

rtError_t rtStreamWaitEvent(rtStream_t stream, rtEvent_t event)
{
    return MockFunctionTest::aclStubInstance().rtStreamWaitEvent(stream, event);
}

rtError_t rtStreamWaitEventWithTimeout(rtStream_t stream, rtEvent_t event, uint32_t timeout)
{
    return MockFunctionTest::aclStubInstance().rtStreamWaitEventWithTimeout(stream, event, timeout);
}

rtError_t rtStreamAbort(rtStream_t stream)
{
    return MockFunctionTest::aclStubInstance().rtStreamAbort(stream);
}

rtError_t rtCtxCreateEx(rtContext_t *ctx, uint32_t flags, int32_t device)
{
    return MockFunctionTest::aclStubInstance().rtCtxCreateEx(ctx, flags, device);
}

rtError_t rtCtxDestroyEx(rtContext_t ctx)
{
    return MockFunctionTest::aclStubInstance().rtCtxDestroyEx(ctx);
}

rtError_t rtCtxSetCurrent(rtContext_t ctx)
{
    return MockFunctionTest::aclStubInstance().rtCtxSetCurrent(ctx);
}

rtError_t rtCtxSynchronize()
{
    return MockFunctionTest::aclStubInstance().rtCtxSynchronize();
}

rtError_t rtCtxGetCurrent(rtContext_t *ctx)
{
    return MockFunctionTest::aclStubInstance().rtCtxGetCurrent(ctx);
}

rtError_t rtGetPriCtxByDeviceId(int32_t device, rtContext_t *ctx)
{
    return MockFunctionTest::aclStubInstance().rtGetPriCtxByDeviceId(device, ctx);
}

rtError_t rtEventCreateWithFlag(rtEvent_t *event_, uint32_t flag)
{
    return MockFunctionTest::aclStubInstance().rtEventCreateWithFlag(event_, flag);
}

rtError_t rtEventCreateExWithFlag(rtEvent_t *event_, uint32_t flag)
{
    return MockFunctionTest::aclStubInstance().rtEventCreateExWithFlag(event_, flag);
}

rtError_t rtEventCreate(rtEvent_t *event)
{
    return MockFunctionTest::aclStubInstance().rtEventCreate(event);
}

rtError_t rtGetEventID(rtEvent_t event, uint32_t *eventId)
{
    return MockFunctionTest::aclStubInstance().rtGetEventID(event, eventId);
}

rtError_t rtEventDestroy(rtEvent_t event)
{
    return MockFunctionTest::aclStubInstance().rtEventDestroy(event);
}

rtError_t rtEventRecord(rtEvent_t event, rtStream_t stream)
{
    return MockFunctionTest::aclStubInstance().rtEventRecord(event, stream);
}

rtError_t rtsEventWait(rtStream_t stream, rtEvent_t event, uint32_t timeout)
{
    return MockFunctionTest::aclStubInstance().rtsEventWait(stream, event, timeout);
}

rtError_t rtEventReset(rtEvent_t event, rtStream_t stream)
{
    return MockFunctionTest::aclStubInstance().rtEventReset(event, stream);
}

rtError_t rtEventSynchronize(rtEvent_t event)
{
    return MockFunctionTest::aclStubInstance().rtEventSynchronize(event);
}

rtError_t rtEventSynchronizeWithTimeout(rtEvent_t event, const int32_t timeout)
{
    return MockFunctionTest::aclStubInstance().rtEventSynchronizeWithTimeout(event, timeout);
}

rtError_t rtEventQuery(rtEvent_t event)
{
    return MockFunctionTest::aclStubInstance().rtEventQuery(event);
}

rtError_t rtEventQueryStatus(rtEvent_t event, rtEventStatus_t *status)
{
    return MockFunctionTest::aclStubInstance().rtEventQueryStatus(event, status);
}

rtError_t rtEventQueryWaitStatus(rtEvent_t event, rtEventWaitStatus *status)
{
    return MockFunctionTest::aclStubInstance().rtEventQueryWaitStatus(event, status);
}

rtError_t rtNotifyCreate(int32_t device_id, rtNotify_t *notify_)
{
    return MockFunctionTest::aclStubInstance().rtNotifyCreate(device_id, notify_);
}

rtError_t rtNotifyDestroy(rtNotify_t notify_)
{
    return MockFunctionTest::aclStubInstance().rtNotifyDestroy(notify_);
}

rtError_t rtNotifyRecord(rtNotify_t notify_, rtStream_t stream_)
{
    return MockFunctionTest::aclStubInstance().rtNotifyRecord(notify_, stream_);
}

rtError_t rtGetNotifyID(rtNotify_t notify_, uint32_t *notify_id)
{
    return MockFunctionTest::aclStubInstance().rtGetNotifyID(notify_, notify_id);
}

rtError_t rtNotifyWait(rtNotify_t notify_, rtStream_t stream_)
{
    return MockFunctionTest::aclStubInstance().rtNotifyWait(notify_, stream_);
}

rtError_t rtMalloc(void **devPtr, uint64_t size, rtMemType_t type, uint16_t moduleId)
{
    return MockFunctionTest::aclStubInstance().rtMalloc(devPtr, size, type, moduleId);
}

rtError_t rtMallocCached(void **devPtr, uint64_t size, rtMemType_t type, uint16_t moduleId)
{
    return MockFunctionTest::aclStubInstance().rtMallocCached(devPtr, size, type, moduleId);
}

rtError_t rtFlushCache(void *devPtr, size_t size)
{
    return MockFunctionTest::aclStubInstance().rtFlushCache(devPtr, size);
}

rtError_t rtInvalidCache(void *devPtr, size_t size)
{
    return MockFunctionTest::aclStubInstance().rtInvalidCache(devPtr, size);
}

rtError_t rtFree(void *devPtr)
{
    return MockFunctionTest::aclStubInstance().rtFree(devPtr);
}

rtError_t rtDvppMalloc(void **devPtr, uint64_t size, uint16_t moduleId)
{
    return MockFunctionTest::aclStubInstance().rtDvppMalloc(devPtr, size, moduleId);
}

rtError_t rtDvppMallocWithFlag(void **devPtr, uint64_t size, uint32_t flag, uint16_t moduleId)
{
    return MockFunctionTest::aclStubInstance().rtDvppMallocWithFlag(devPtr, size, flag, moduleId);
}

rtError_t rtDvppFree(void *devPtr)
{
    return MockFunctionTest::aclStubInstance().rtDvppFree(devPtr);
}

rtError_t rtMallocHost(void **hostPtr,  uint64_t size, uint16_t moduleId)
{
    return MockFunctionTest::aclStubInstance().rtMallocHost(hostPtr, size, moduleId);
}

rtError_t rtFreeHost(void *hostPtr)
{
    return MockFunctionTest::aclStubInstance().rtFreeHost(hostPtr);
}

rtError_t rtFreeWithDevSync(void *devPtr)
{
    return MockFunctionTest::aclStubInstance().rtFreeWithDevSync(devPtr);
}

rtError_t rtFreeHostWithDevSync(void *hostPtr)
{
    return MockFunctionTest::aclStubInstance().rtFreeHostWithDevSync(hostPtr);
}

rtError_t rtMemset(void *devPtr, uint64_t destMax, uint32_t value, uint64_t count)
{
    return MockFunctionTest::aclStubInstance().rtMemset(devPtr, destMax, value, count);
}

rtError_t rtMemcpy(void *dst,  uint64_t destMax, const void *src, uint64_t count, rtMemcpyKind_t kind)
{
    return MockFunctionTest::aclStubInstance().rtMemcpy(dst, destMax, src, count, kind);
}

rtError_t rtMemcpyAsync(void *dst,  uint64_t destMax, const void *src, uint64_t count, rtMemcpyKind_t kind, rtStream_t stream)
{
    return MockFunctionTest::aclStubInstance().rtMemcpyAsync(dst, destMax, src, count, kind, stream);
}

rtError_t rtMemcpyAsyncEx(void *dst,  uint64_t destMax, const void *src, uint64_t count, rtMemcpyKind_t kind,
                          rtStream_t stream, rtMemcpyConfig_t *memcpyConfig)
{
    return MockFunctionTest::aclStubInstance().rtMemcpyAsyncEx(dst, destMax, src, count, kind, stream, memcpyConfig);
}

rtError_t rtMemsetAsync(void *ptr, uint64_t destMax, uint32_t value, uint64_t count, rtStream_t stream)
{
    return MockFunctionTest::aclStubInstance().rtMemsetAsync(ptr, destMax, value, count, stream);
}

rtError_t rtCpuKernelLaunchWithFlag(const void *soName, const void *kernelName, uint32_t blockDim,
                                    const rtArgsEx_t *argsInfo, rtSmDesc_t *smDesc, rtStream_t stm,
                                    uint32_t flags)
{
    return MockFunctionTest::aclStubInstance().rtCpuKernelLaunchWithFlag(soName, kernelName, blockDim, argsInfo,
        smDesc, stm, flags);
}

rtError_t rtMemGetInfoEx(rtMemInfoType_t memInfoType, size_t *free, size_t *total)
{
    return MockFunctionTest::aclStubInstance().rtMemGetInfoEx(memInfoType, free, total);
}

rtError_t rtSubscribeReport(uint64_t threadId, rtStream_t stream)
{
    return MockFunctionTest::aclStubInstance().rtSubscribeReport(threadId, stream);
}

rtError_t rtCallbackLaunch(rtCallback_t callBackFunc, void *fnData, rtStream_t stream, bool isBlock)
{
    return MockFunctionTest::aclStubInstance().rtCallbackLaunch(callBackFunc, fnData, stream, isBlock);
}

rtError_t rtsLaunchHostFunc(rtStream_t stm, const rtCallback_t callBackFunc, void * const fnData)
{
    return MockFunctionTest::aclStubInstance().rtsLaunchHostFunc(stm, callBackFunc, fnData);
}

rtError_t rtProcessReport(int32_t timeout)
{
    return MockFunctionTest::aclStubInstance().rtProcessReport(timeout);
}

rtError_t rtUnSubscribeReport(uint64_t threadId, rtStream_t stream)
{
    return MockFunctionTest::aclStubInstance().rtUnSubscribeReport(threadId, stream);
}

rtError_t rtGetRunMode(rtRunMode *mode)
{
    return MockFunctionTest::aclStubInstance().rtGetRunMode(mode);
}

rtError_t rtGetDeviceCount(int32_t *count)
{
    *count = 1;
    return MockFunctionTest::aclStubInstance().rtGetDeviceCount(count);
}

rtError_t rtEventElapsedTime(float *time, rtEvent_t start, rtEvent_t end)
{
    *time = 1.0f;
    return MockFunctionTest::aclStubInstance().rtEventElapsedTime(time, start, end);
}

rtError_t rtEventGetTimeStamp(uint64_t *timestamp, rtEvent_t evt)
{
    return ACL_RT_SUCCESS;
}

rtError_t rtDevBinaryUnRegister(void *handle)
{
    return MockFunctionTest::aclStubInstance().rtDevBinaryUnRegister(handle);
}

rtError_t rtDevBinaryRegister(const rtDevBinary_t *bin, void **handle)
{
    return MockFunctionTest::aclStubInstance().rtDevBinaryRegister(bin, handle);
}

rtError_t rtFunctionRegister(void *binHandle,
                            const void *stubFunc,
                            const char *stubName,
                            const void *devFunc,
                            uint32_t funcMode)
{
    return MockFunctionTest::aclStubInstance().rtFunctionRegister(binHandle, stubFunc, stubName, devFunc, funcMode);
}

rtError_t rtKernelLaunch(const void *stubFunc,
                        uint32_t blockDim,
                        void *args,
                        uint32_t argsSize,
                        rtSmDesc_t *smDesc,
                        rtStream_t stream)
{
    return MockFunctionTest::aclStubInstance().rtKernelLaunch(stubFunc, blockDim, args, argsSize, smDesc, stream);
}


rtError_t rtRegTaskFailCallbackByModule(const char *moduleName, rtTaskFailCallback callback)
{
    return MockFunctionTest::aclStubInstance().rtRegTaskFailCallbackByModule(moduleName, callback);
}

rtError_t rtGetSocVersion(char *version, const uint32_t maxLen)
{
    const char *socVersion = "Ascend910_9391";
    memcpy_s(version, maxLen, socVersion, strlen(socVersion) + 1);
    return MockFunctionTest::aclStubInstance().rtGetSocVersion(version, maxLen);
}

rtError_t rtGetGroupCount(uint32_t *count)
{
    *count = 2;
    return MockFunctionTest::aclStubInstance().rtGetGroupCount(count);
}

rtError_t rtGetGroupInfo(int32_t groupid, rtGroupInfo_t* groupInfo, uint32_t count)
{
    for (uint32_t i = 0; i < count; ++i) {
        groupInfo[i].groupId = (int32_t)i;
        groupInfo[i].flag = (int32_t)i;
        groupInfo[i].aicoreNum = i + 1;
        groupInfo[i].aicpuNum = i + 2;
        groupInfo[i].aivectorNum = i + 3;
        groupInfo[i].sdmaNum = i + 4;
        groupInfo[i].activeStreamNum = i + 5;
    }
    return MockFunctionTest::aclStubInstance().rtGetGroupInfo(groupid, groupInfo, count);
}

rtError_t rtSetGroup(int32_t groupid)
{
    return MockFunctionTest::aclStubInstance().rtSetGroup(groupid);
}

rtError_t rtGetDevicePhyIdByIndex(uint32_t devIndex, uint32_t *phyId)
{
    *phyId = 10;
    return MockFunctionTest::aclStubInstance().rtGetDevicePhyIdByIndex(devIndex, phyId);
}

rtError_t rtEnableP2P(uint32_t devIdDes, uint32_t phyIdSrc, uint32_t flag)
{
    return MockFunctionTest::aclStubInstance().rtEnableP2P(devIdDes, phyIdSrc, flag);
}

rtError_t rtDisableP2P(uint32_t devIdDes, uint32_t phyIdSrc)
{
    return MockFunctionTest::aclStubInstance().rtDisableP2P(devIdDes, phyIdSrc);
}

rtError_t rtDeviceCanAccessPeer(int32_t* canAccessPeer, uint32_t device, uint32_t peerDevice)
{
    *canAccessPeer = 1;
    return MockFunctionTest::aclStubInstance().rtDeviceCanAccessPeer(canAccessPeer, device, peerDevice);
}

rtError_t rtGetStreamId(rtStream_t stream_, int32_t *streamId)
{
    *streamId = 1;
    return MockFunctionTest::aclStubInstance().rtGetStreamId(stream_, streamId);
}

rtError_t rtRegDeviceStateCallback(const char *regName, rtDeviceStateCallback callback)
{
    return MockFunctionTest::aclStubInstance().rtRegDeviceStateCallback(regName, callback);
}

rtError_t rtRegDeviceStateCallbackEx(const char *regName, rtDeviceStateCallback callback,
                                     const rtDevCallBackDir_t notifyPos)
{
    return MockFunctionTest::aclStubInstance().rtRegDeviceStateCallbackEx(regName, callback, notifyPos);
}

rtError_t rtDeviceGetStreamPriorityRange(int32_t *leastPriority, int32_t *greatestPriority)
{
    *leastPriority = 7;
    *greatestPriority = 0;
    return MockFunctionTest::aclStubInstance().rtDeviceGetStreamPriorityRange(leastPriority, greatestPriority);
}

rtError_t rtGetDeviceCapability(int32_t device, int32_t moduleType, int32_t featureType, int32_t *value)
{
    *value = 0;
    return MockFunctionTest::aclStubInstance().rtGetDeviceCapability(device, moduleType, featureType, value);
}

rtError_t rtSetOpWaitTimeOut(uint32_t timeout)
{
    return MockFunctionTest::aclStubInstance().rtSetOpWaitTimeOut(timeout);
}

rtError_t rtSetOpExecuteTimeOut(uint32_t timeout)
{
    return MockFunctionTest::aclStubInstance().rtSetOpExecuteTimeOut(timeout);
}

rtError_t rtSetOpExecuteTimeOutWithMs(uint32_t timeout)
{
    return MockFunctionTest::aclStubInstance().rtSetOpExecuteTimeOutWithMs(timeout);
}

rtError_t rtSetOpExecuteTimeOutV2(uint64_t timeout, uint64_t *actualTimeout)
{
    return MockFunctionTest::aclStubInstance().rtSetOpExecuteTimeOutV2(timeout, actualTimeout);
}

rtError_t rtGetOpTimeOutInterval(uint64_t *interval)
{
    return MockFunctionTest::aclStubInstance().rtGetOpTimeOutInterval(interval);
}

rtError_t rtCtxSetSysParamOpt(const rtSysParamOpt configOpt, const int64_t configVal)
{
    return MockFunctionTest::aclStubInstance().rtCtxSetSysParamOpt(configOpt, configVal);
}

rtError_t rtCtxGetSysParamOpt(const rtSysParamOpt configOpt, int64_t * const configVal)
{
    return MockFunctionTest::aclStubInstance().rtCtxGetSysParamOpt(configOpt, configVal);
}

rtError_t rtSetSysParamOpt(const rtSysParamOpt configOpt, const int64_t configVal)
{
    return MockFunctionTest::aclStubInstance().rtSetSysParamOpt(configOpt, configVal);
}

rtError_t rtGetSysParamOpt(const rtSysParamOpt configOpt, int64_t * const configVal)
{
    return MockFunctionTest::aclStubInstance().rtGetSysParamOpt(configOpt, configVal);
}

rtError_t rtGetDeviceSatStatus(void * const outputAddrPtr, const uint64_t outputSize, rtStream_t stm)
{
    return MockFunctionTest::aclStubInstance().rtGetDeviceSatStatus(outputAddrPtr, outputSize, stm);
}

rtError_t rtCleanDeviceSatStatus(rtStream_t stm)
{
    return MockFunctionTest::aclStubInstance().rtCleanDeviceSatStatus(stm);
}

rtError_t rtMemQueueInitQS(int32_t devId, const char* groupName)
{
    return MockFunctionTest::aclStubInstance().rtMemQueueInitQS(devId, groupName);
}

rtError_t rtMemQueueCreate(int32_t devId, const rtMemQueueAttr_t *queAttr, uint32_t *qid)
{
    return MockFunctionTest::aclStubInstance().rtMemQueueCreate(devId, queAttr, qid);
}

rtError_t rtMemQueueDestroy(int32_t devId, uint32_t qid)
{
    return MockFunctionTest::aclStubInstance().rtMemQueueDestroy(devId, qid);
}

rtError_t rtMemQueueInit(int32_t devId)
{
    return MockFunctionTest::aclStubInstance().rtMemQueueInit(devId);
}

rtError_t rtMemQueueEnQueue(int32_t devId, uint32_t qid, void *mbuf)
{
    return MockFunctionTest::aclStubInstance().rtMemQueueEnQueue(devId, qid, mbuf);
}

rtError_t rtMemQueueDeQueue(int32_t devId, uint32_t qid, void **mbuf)
{
    return MockFunctionTest::aclStubInstance().rtMemQueueDeQueue(devId, qid, mbuf);
}

#pragma pack(push, 1)
struct ItemInfo {
    int32_t version = 0;
    int32_t dataType = 0;
    uint32_t curCnt = 0U;
    uint32_t cnt = 0U;
    int32_t tensorType = 0;
    uint32_t dimNum = 0U;
    uint32_t dynamicBitSize = 0U;
    uint16_t sliceNum = 0;
    uint16_t sliceId = 0;
    char reserved[24] = {0};
    uint64_t dataLen = 0LU;
};
#pragma pack(pop)


rtError_t rtMemQueuePeek(int32_t devId, uint32_t qid, size_t *bufLen, int32_t timeout)
{
    *bufLen = sizeof(ItemInfo);
    return MockFunctionTest::aclStubInstance().rtMemQueuePeek(devId, qid, bufLen, timeout);
}

rtError_t rtMemQueueEnQueueBuff(int32_t devId, uint32_t qid, rtMemQueueBuff_t *inBuf, int32_t timeout)

{
    return MockFunctionTest::aclStubInstance().rtMemQueueEnQueueBuff(devId, qid, inBuf, timeout);
}

rtError_t rtMemQueueQueryInfo(int32_t device, uint32_t qid, rtMemQueueInfo_t *queueInfo)
{
    return MockFunctionTest::aclStubInstance().rtMemQueueQueryInfo(device, qid, queueInfo);
}

rtError_t rtMemQueueDeQueueBuff(int32_t devId, uint32_t qid, rtMemQueueBuff_t *outBuf, int32_t timeout)
{
    if (outBuf->buffCount == 1) {
        memset_s(outBuf->buffInfo[0].addr, outBuf->buffInfo[0].len, 0, outBuf->buffInfo[0].len);
    }
    return MockFunctionTest::aclStubInstance().rtMemQueueDeQueueBuff(devId, qid,outBuf, timeout);
}

rtError_t rtMemQueueQuery(int32_t devId, rtMemQueueQueryCmd_t cmd, void *inBuff, uint32_t inLen,
                                  void *outBuff, uint32_t *outLen)
{
    return MockFunctionTest::aclStubInstance().rtMemQueueQuery( devId, cmd, inBuff, inLen, outBuff, outLen);
}

rtError_t rtMemQueueGrant(int32_t devId, uint32_t qid, int32_t pid, rtMemQueueShareAttr_t *attr)
{
    return MockFunctionTest::aclStubInstance().rtMemQueueGrant(devId, qid, pid, attr);
}

rtError_t rtMemQueueAttach(int32_t devId, uint32_t qid, int32_t timeout)
{
    return MockFunctionTest::aclStubInstance().rtMemQueueAttach(devId, qid, timeout);
}

rtError_t rtEschedSubmitEventSync(int32_t devId, rtEschedEventSummary_t *event, rtEschedEventReply_t *ack)
{
    return MockFunctionTest::aclStubInstance().rtEschedSubmitEventSync(devId, event, ack);
}

rtError_t rtQueryDevPid(rtBindHostpidInfo_t *info, pid_t *devPid)
{
    return MockFunctionTest::aclStubInstance().rtQueryDevPid(info, devPid);
}

rtError_t rtMbufInit(rtMemBuffCfg_t *cfg)
{
    return MockFunctionTest::aclStubInstance().rtMbufInit(cfg);
}

rtError_t rtMbufAlloc(rtMbufPtr_t *mbuf, uint64_t size)
{
    *mbuf = malloc(size);
    return MockFunctionTest::aclStubInstance().rtMbufAlloc(mbuf, size);
}

rtError_t rtMbufAllocEx(rtMbufPtr_t *mbuf, uint64_t size, uint64_t flag, int32_t grpId)
{
    *mbuf = malloc(size);
    return MockFunctionTest::aclStubInstance().rtMbufAllocEx(mbuf, size, flag, grpId);
}

rtError_t rtMbufFree(rtMbufPtr_t mbuf)
{
    free(mbuf);
    return RT_ERROR_NONE;
}

RTS_API rtError_t rtMbufSetDataLen(rtMbufPtr_t mbuf, uint64_t len)
{
    return RT_ERROR_NONE;
}

RTS_API rtError_t rtMbufGetDataLen(rtMbufPtr_t mbuf, uint64_t *len)
{
    return RT_ERROR_NONE;
}

rtError_t rtMbufGetBuffAddr(rtMbufPtr_t mbuf, void **databuf)
{
    *databuf = mbuf;
    return MockFunctionTest::aclStubInstance().rtMbufGetBuffAddr(mbuf, databuf);
}

rtError_t rtMbufGetBuffSize(rtMbufPtr_t mbuf, uint64_t *size)
{
    *size = 0;
    return MockFunctionTest::aclStubInstance().rtMbufGetBuffSize(mbuf, size);
}

rtError_t rtMbufGetPrivInfo(rtMbufPtr_t mbuf, void **priv, uint64_t *size)
{
    *priv = mbuf;
    *size = 96UL;
    return MockFunctionTest::aclStubInstance().rtMbufGetPrivInfo(mbuf, priv, size);
}

rtError_t rtMbufCopyBufRef(rtMbufPtr_t mbuf, rtMbufPtr_t *newMbuf)
{
    return MockFunctionTest::aclStubInstance().rtMbufCopyBufRef(mbuf, newMbuf);
}

RTS_API rtError_t rtMbufChainAppend(rtMbufPtr_t mbufChainHead, rtMbufPtr_t memBuf)
{
    return RT_ERROR_NONE;
}

RTS_API rtError_t rtMbufChainGetMbufNum(rtMbufPtr_t mbufChainHead, uint32_t *num)
{
    return RT_ERROR_NONE;
}

RTS_API rtError_t rtMbufChainGetMbuf(rtMbufPtr_t mbufChainHead, uint32_t index, rtMbufPtr_t *memBuf)
{
    return RT_ERROR_NONE;
}

RTS_API rtError_t rtMemQueueQuery(int32_t devId, rtMemQueueQueryCmd_t cmd, const void *inBuff, uint32_t inLen,
    void *outBuff, uint32_t *outLen)
{
    return RT_ERROR_NONE;
}

rtError_t rtMemGrpCreate(const char *name, const rtMemGrpConfig_t *cfg)
{
    return MockFunctionTest::aclStubInstance().rtMemGrpCreate(name, cfg);
}

rtError_t rtMemGrpAddProc(const char *name, int32_t pid, const rtMemGrpShareAttr_t *attr)
{
    return MockFunctionTest::aclStubInstance().rtMemGrpAddProc(name, pid, attr);
}

rtError_t rtMemGrpAttach(const char *name, int32_t timeout)
{
    return MockFunctionTest::aclStubInstance().rtMemGrpAttach(name, timeout);
}

rtError_t rtMemGrpQuery(rtMemGrpQueryInput_t * const input, rtMemGrpQueryOutput_t *output)
{
    return MockFunctionTest::aclStubInstance().rtMemGrpQuery(input, output);
}

rtError_t rtMemcpy2d(void *dst, uint64_t dpitch, const void *src, uint64_t spitch, uint64_t width,
    uint64_t height, rtMemcpyKind_t kind)
{
    return MockFunctionTest::aclStubInstance().rtMemcpy2d(dst, dpitch, src, spitch, width, height, kind);
}

rtError_t rtMemcpy2dAsync(void *dst, uint64_t dpitch, const void *src, uint64_t spitch, uint64_t width,
    uint64_t height, rtMemcpyKind_t kind, rtStream_t stream)
{
    return MockFunctionTest::aclStubInstance().rtMemcpy2dAsync(dst, dpitch, src, spitch, width, height, kind, stream);
}

rtError_t rtGetDevMsg(rtGetDevMsgType_t getMsgType, rtGetMsgCallback callback)
{
    return MockFunctionTest::aclStubInstance().rtGetDevMsg(getMsgType, callback);
}

rtError_t rtGetFaultEvent(const int32_t deviceId, rtDmsEventFilter *filter, rtDmsFaultEvent *dmsEvent,
                          uint32_t len, uint32_t *eventCount)
{
    return MockFunctionTest::aclStubInstance().rtGetFaultEvent(deviceId, filter, dmsEvent, len, eventCount);
}

rtError_t rtIpcGetEventHandle(rtEvent_t event, rtIpcEventHandle_t *handle)
{
  return  MockFunctionTest::aclStubInstance().rtIpcGetEventHandle(event, handle);
}

rtError_t rtIpcOpenEventHandle(rtIpcEventHandle_t handle, rtEvent_t *event)
{
  return  MockFunctionTest::aclStubInstance().rtIpcOpenEventHandle(handle, event);
}

rtError_t rtStreamSetMode(rtStream_t stm, const uint64_t mode)
{
  return MockFunctionTest::aclStubInstance().rtStreamSetMode(stm, mode);
}

rtError_t rtSetStreamOverflowSwitch(rtStream_t stm, uint32_t flags)
{
    return MockFunctionTest::aclStubInstance().rtSetStreamOverflowSwitch(stm, flags);
}

rtError_t rtGetStreamOverflowSwitch(rtStream_t stm, uint32_t *flags)
{
    return MockFunctionTest::aclStubInstance().rtGetStreamOverflowSwitch(stm, flags);
}

rtError_t rtSetDeviceSatMode(rtFloatOverflowMode_t floatOverflowMode)
{
    return MockFunctionTest::aclStubInstance().rtSetDeviceSatMode(floatOverflowMode);
}

rtError_t rtGetDeviceSatMode(rtFloatOverflowMode_t *floatOverflowMode)
{
    return MockFunctionTest::aclStubInstance().rtGetDeviceSatMode(floatOverflowMode);
}

rtError_t rtGetAiCoreCount(uint32_t *aiCoreCnt)
{
    return MockFunctionTest::aclStubInstance().rtGetAiCoreCount(aiCoreCnt);
}

rtError_t rtGetDeviceInfo(uint32_t deviceId, int32_t moduleType, int32_t infoType, int64_t *val)
{
    return MockFunctionTest::aclStubInstance().rtGetDeviceInfo(deviceId, moduleType, infoType, val);
}

rtError_t rtGetAllUtilizations(const int32_t devId, const rtTypeUtil_t kind, uint8_t* const util){
    return MockFunctionTest::aclStubInstance().rtGetAllUtilizations(devId, kind, util);
}

rtError_t rtReserveMemAddress(void **devPtr, size_t size, size_t alignment, void *devAddr, uint64_t flags) {
    *devPtr = (void*)0x01U;
    return MockFunctionTest::aclStubInstance().rtReserveMemAddress(devPtr, size, alignment, devAddr, flags);
}

rtError_t rtReleaseMemAddress(void *devPtr) {
    return MockFunctionTest::aclStubInstance().rtReleaseMemAddress(devPtr);
}

rtError_t rtMemRetainAllocationHandle(void* virPtr, rtDrvMemHandle *handle) {
    return MockFunctionTest::aclStubInstance().rtMemRetainAllocationHandle(virPtr, handle);
}

rtError_t rtMemGetAllocationPropertiesFromHandle(rtDrvMemHandle handle, rtDrvMemProp_t* prop) {
    return MockFunctionTest::aclStubInstance().rtMemGetAllocationPropertiesFromHandle(handle, prop);
}

rtError_t rtMallocPhysical(rtDrvMemHandle *handle, size_t size, rtDrvMemProp_t *prop, uint64_t flags) {
    *handle = (rtDrvMemHandle)0x01U;
    return MockFunctionTest::aclStubInstance().rtMallocPhysical(handle, size, prop, flags);
}

rtError_t rtFreePhysical(rtDrvMemHandle handle) {
    return MockFunctionTest::aclStubInstance().rtFreePhysical(handle);
}

rtError_t rtMapMem(void *devPtr, size_t size, size_t offset, rtDrvMemHandle handle, uint64_t flags) {
    return MockFunctionTest::aclStubInstance().rtMapMem(devPtr, size, offset, handle, flags);
}

rtError_t rtUnmapMem(void *devPtr) {
    return MockFunctionTest::aclStubInstance().rtUnmapMem(devPtr);
}

rtError_t rtDeviceStatusQuery(const uint32_t devId, rtDeviceStatus *deviceStatus)
{
    return MockFunctionTest::aclStubInstance().rtDeviceStatusQuery(devId, deviceStatus);
}

rtError_t rtBinaryLoadWithoutTilingKey(const void *data, const uint64_t length, rtBinHandle *binHandle)
{
  *binHandle = (rtBinHandle)0x01U;
  return MockFunctionTest::aclStubInstance().rtBinaryLoadWithoutTilingKey(data, length, binHandle);
}

rtError_t rtBinaryUnLoad(rtBinHandle binHandle)
{
  return MockFunctionTest::aclStubInstance().rtBinaryUnLoad(binHandle);
}

rtError_t rtsFuncGetByName(const rtBinHandle binHandle, const char_t *kernelName, rtFuncHandle *funcHandle)
{
  *funcHandle = (rtFuncHandle)0x01U;
  return MockFunctionTest::aclStubInstance().rtsFuncGetByName(binHandle, kernelName, funcHandle);
}

rtError_t rtCreateLaunchArgs(size_t argsSize, size_t hostInfoTotalSize, size_t hostInfoNum,
                             void* argsData, rtLaunchArgsHandle* argsHandle)
{
  *argsHandle = (rtLaunchArgsHandle)0x01U;
  return MockFunctionTest::aclStubInstance().rtCreateLaunchArgs(argsSize, hostInfoTotalSize, hostInfoNum,
                                                                argsData, argsHandle);
}

rtError_t rtDestroyLaunchArgs(rtLaunchArgsHandle argsHandle)
{
  return MockFunctionTest::aclStubInstance().rtDestroyLaunchArgs(argsHandle);
}

rtError_t rtLaunchKernelByFuncHandleV3(rtFuncHandle funcHandle, uint32_t blockDim, const rtArgsEx_t * const argsInfo,
                                       rtStream_t stm, const rtTaskCfgInfo_t * const cfgInfo)
{
  return MockFunctionTest::aclStubInstance().rtLaunchKernelByFuncHandleV3(funcHandle, blockDim,
                                                                          argsInfo, stm, nullptr);
}

rtError_t rtsLaunchKernelWithDevArgs(rtFuncHandle funcHandle, uint32_t blockDim, rtStream_t stm,
                                     rtKernelLaunchCfg_t *cfg, const void *args, uint32_t argsSize, void *reserve)
{
  return MockFunctionTest::aclStubInstance().rtsLaunchKernelWithDevArgs(funcHandle, blockDim,
                                                                        stm, cfg, args, argsSize, reserve);
}

rtError_t rtsLaunchKernelWithHostArgs(rtFuncHandle funcHandle, uint32_t blockDim, rtStream_t stm,
                                      rtKernelLaunchCfg_t *cfg, void *hostArgs, uint32_t argsSize,
                                      rtPlaceHolderInfo_t *placeHolderArray, uint32_t placeHolderNum)
{
  return MockFunctionTest::aclStubInstance().rtsLaunchKernelWithHostArgs(funcHandle, blockDim, stm, cfg, hostArgs, argsSize,
                                                                         placeHolderArray, placeHolderNum);
}

rtError_t rtMemExportToShareableHandle(rtDrvMemHandle handle, rtDrvMemHandleType handleType,
                                       uint64_t flag, uint64_t *shareableHandle)
{
  *shareableHandle = 0x1111;
  return MockFunctionTest::aclStubInstance().rtMemExportToShareableHandle(handle, handleType, flag, shareableHandle);
}

rtError_t rtsMemExportToShareableHandle(rtDrvMemHandle handle, rtDrvMemHandleType handleType,
    uint64_t flag, uint64_t *shareableHandle)
{
  *shareableHandle = 0x1111;
  return MockFunctionTest::aclStubInstance().rtsMemExportToShareableHandle(handle, handleType, flag, shareableHandle);
}

rtError_t rtMemExportToShareableHandleV2(rtDrvMemHandle handle, rtMemSharedHandleType handleType,
    uint64_t flags, void *shareableHandle)
{
  return MockFunctionTest::aclStubInstance().rtMemExportToShareableHandleV2(handle, handleType, flags, shareableHandle);
}

rtError_t rtMemImportFromShareableHandle(uint64_t shareableHandle, int32_t deviceId,
                                         rtDrvMemHandle *handle)
{
  return MockFunctionTest::aclStubInstance().rtMemImportFromShareableHandle(shareableHandle, deviceId, handle);
}

rtError_t rtsMemImportFromShareableHandle(uint64_t shareableHandle, int32_t deviceId,
    rtDrvMemHandle *handle)
{
  return MockFunctionTest::aclStubInstance().rtsMemImportFromShareableHandle(shareableHandle, deviceId, handle);
}

rtError_t rtMemImportFromShareableHandleV2(const void *shareableHandle, rtMemSharedHandleType handleType,
    uint64_t flags, int32_t devId, rtDrvMemHandle *handle)
{
  return MockFunctionTest::aclStubInstance().rtMemImportFromShareableHandleV2(shareableHandle, handleType, flags, devId, handle);
}

rtError_t rtMemSetPidToShareableHandle(uint64_t shareableHandle, int pid[], uint32_t pidNum)
{
  return MockFunctionTest::aclStubInstance().rtMemSetPidToShareableHandle(shareableHandle, pid, pidNum);
}

rtError_t rtsMemSetPidToShareableHandle(uint64_t shareableHandle, int pid[], uint32_t pidNum)
{
  return MockFunctionTest::aclStubInstance().rtsMemSetPidToShareableHandle(shareableHandle, pid, pidNum);
}

rtError_t rtMemSetPidToShareableHandleV2(const void *shareableHandle, rtMemSharedHandleType handleType, int pid[], 
    uint32_t pidNum)
{
  return MockFunctionTest::aclStubInstance().rtMemSetPidToShareableHandleV2(shareableHandle, handleType, pid, pidNum);
}

rtError_t rtMemGetAllocationGranularity(rtDrvMemProp_t *prop, rtDrvMemGranularityOptions option, size_t *granularity)
{
  return MockFunctionTest::aclStubInstance().rtMemGetAllocationGranularity(prop, option, granularity);
}

rtError_t rtDeviceGetBareTgid(uint32_t *pid)
{
  return MockFunctionTest::aclStubInstance().rtDeviceGetBareTgid(pid);
}

rtError_t rtGetL2CacheOffset(uint32_t deviceId, uint64_t *offset)
{
    return MockFunctionTest::aclStubInstance().rtGetL2CacheOffset(deviceId, offset);
}

rtError_t rtRegKernelLaunchFillFunc(const char *symbol, rtKernelLaunchFillFunc func)
{
    return MockFunctionTest::aclStubInstance().rtRegKernelLaunchFillFunc(symbol, func);
}

rtError_t rtUnRegKernelLaunchFillFunc(const char *symbol)
{
    return MockFunctionTest::aclStubInstance().rtUnRegKernelLaunchFillFunc(symbol);
}

rtError_t rtGetMemUceInfo(const uint32_t deviceId, rtMemUceInfo *memUceInfo)
{
    return MockFunctionTest::aclStubInstance().rtGetMemUceInfo(deviceId, memUceInfo);
}

rtError_t rtMemUceRepair(const uint32_t deviceId, rtMemUceInfo *memUceInfo)
{
    return MockFunctionTest::aclStubInstance().rtMemUceRepair(deviceId, memUceInfo);
}

rtError_t rtDeviceTaskAbort(int32_t devId, uint32_t timeout)
{
    return MockFunctionTest::aclStubInstance().rtDeviceTaskAbort(devId, timeout);
}

rtError_t rtMemQueueReset(int32_t devId, uint32_t qid)
{
    return MockFunctionTest::aclStubInstance().rtMemQueueReset(devId, qid);
}

rtError_t rtSetDefaultDeviceId(int32_t deviceId)
{
    return MockFunctionTest::aclStubInstance().rtSetDefaultDeviceId(deviceId);
}

rtError_t rtDeviceSetLimit(int32_t devId, rtLimitType_t type, uint32_t val)
{
    return MockFunctionTest::aclStubInstance().rtDeviceSetLimit(devId, type, val);
}

rtError_t rtEventWorkModeSet(uint8_t event_mode)
{
    return MockFunctionTest::aclStubInstance().rtEventWorkModeSet(event_mode);
}

rtError_t rtRegStreamStateCallback(const char *regName, rtStreamStateCallback callback)
{
    return MockFunctionTest::aclStubInstance().rtRegStreamStateCallback(regName, callback);
}

rtError_t rtCtxGetCurrentDefaultStream(rtStream_t* stm) {
  return MockFunctionTest::aclStubInstance().rtCtxGetCurrentDefaultStream(stm);
}

rtError_t rtCmoAsync(void *srcAddrPtr, size_t srcLen, rtCmoOpCode_t cmpType, rtStream_t stm) {
  return MockFunctionTest::aclStubInstance().rtCmoAsync(srcAddrPtr, srcLen, cmpType, stm);
}

rtError_t rtsCmoAsync(void *srcAddrPtr, size_t srcLen, rtCmoOpCode_t cmoType, rtStream_t stm) {
  return MockFunctionTest::aclStubInstance().rtsCmoAsync(srcAddrPtr, srcLen, cmoType, stm);
}

rtError_t rtPeekAtLastError(rtLastErrLevel_t level)
{
    return ACL_ERROR_RT_FAILURE;
}

rtError_t rtGetLastError(rtLastErrLevel_t level)
{
    return ACL_ERROR_RT_FAILURE;
}

rtError_t rtStreamBeginCapture(rtStream_t stm, const rtStreamCaptureMode mode)
{
    return MockFunctionTest::aclStubInstance().rtStreamBeginCapture(stm, mode);
}

rtError_t rtStreamGetCaptureInfo(rtStream_t stm, rtStreamCaptureStatus *const status, rtModel_t *captureMdl)
{
    if (status != nullptr) {
        *status = RT_STREAM_CAPTURE_STATUS_ACTIVE;
    }
    if (captureMdl != nullptr) {
        *captureMdl = (rtModel_t)(0x12345678);
    }
    return MockFunctionTest::aclStubInstance().rtStreamGetCaptureInfo(stm, status, captureMdl);
}

rtError_t rtStreamEndCapture(rtStream_t stm, rtModel_t *captureMdl)
{
    *captureMdl = (rtModel_t)(0x12345678);
    return MockFunctionTest::aclStubInstance().rtStreamEndCapture(stm, captureMdl);
}

rtError_t rtCacheLastTaskOpInfo(const void * const infoPtr, const size_t infoSize)
{
    return MockFunctionTest::aclStubInstance().rtCacheLastTaskOpInfo(infoPtr, infoSize);
}

rtError_t rtFunctionGetAttribute(rtFuncHandle funcHandle, rtFuncAttribute attrType, int64_t *attrValue)
{
    return MockFunctionTest::aclStubInstance().rtFunctionGetAttribute(funcHandle, attrType, attrValue);
}

rtError_t rtModelDebugDotPrint(rtModel_t mdl)
{
    return MockFunctionTest::aclStubInstance().rtModelDebugDotPrint(mdl);
}

rtError_t rtModelDebugJsonPrint(rtModel_t mdl, const char *path, uint32_t flags)
{
    return MockFunctionTest::aclStubInstance().rtModelDebugJsonPrint(mdl, path, flags);
}

rtError_t rtThreadExchangeCaptureMode(rtStreamCaptureMode *mode)
{
    *mode = RT_STREAM_CAPTURE_MODE_RELAXED;
    return MockFunctionTest::aclStubInstance().rtThreadExchangeCaptureMode(mode);
}

rtError_t rtModelExecute(rtModel_t mdl, rtStream_t stm, uint32_t flag)
{
    return MockFunctionTest::aclStubInstance().rtModelExecute(mdl, stm, flag);
}

rtError_t rtModelDestroy(rtModel_t mdl)
{
    return MockFunctionTest::aclStubInstance().rtModelDestroy(mdl);
}

rtError_t rtsMemcpyAsyncWithDesc(rtMemcpyDesc_t desc, rtMemcpyKind kind, rtMemcpyConfig_t *config, rtStream_t stream)
{
    return MockFunctionTest::aclStubInstance().rtsMemcpyAsyncWithDesc(desc, kind, config, stream);
}

rtError_t rtMemcpyAsyncWithOffset(void **dst, uint64_t dstMax, uint64_t dstDataOffset, const void **src,
    uint64_t count, uint64_t srcDataOffset, rtMemcpyKind kind, rtStream_t stream)
{
    return MockFunctionTest::aclStubInstance().rtMemcpyAsyncWithOffset(dst, dstMax, dstDataOffset, src, count, srcDataOffset, kind, stream);
}

rtError_t rtsGetMemcpyDescSize(rtMemcpyKind kind, size_t *size)
{
    return MockFunctionTest::aclStubInstance().rtsGetMemcpyDescSize(kind, size);
}

rtError_t rtsSetMemcpyDesc(rtMemcpyDesc_t desc, rtMemcpyKind kind, void *srcAddr, void *dstAddr, size_t count, rtMemcpyConfig_t *config)
{
    return MockFunctionTest::aclStubInstance().rtsSetMemcpyDesc(desc, kind, srcAddr, dstAddr, count, config);
}

rtError_t rtsBinaryLoadFromFile(const char * const binPath, const rtLoadBinaryConfig_t * const optionalCfg, rtBinHandle *handle)
{
    return MockFunctionTest::aclStubInstance().rtsBinaryLoadFromFile(binPath, optionalCfg, handle);
}

rtError_t rtsBinaryGetDevAddress(const rtBinHandle binHandle, void **bin, uint32_t *binSize)
{
    return MockFunctionTest::aclStubInstance().rtsBinaryGetDevAddress(binHandle, bin, binSize);
}

rtError_t rtsFuncGetByEntry(const rtBinHandle binHandle, const uint64_t funcEntry, rtFuncHandle *funcHandle)
{
    return MockFunctionTest::aclStubInstance().rtsFuncGetByEntry(binHandle, funcEntry, funcHandle);
}

rtError_t rtsFuncGetAddr(const rtFuncHandle funcHandle, void **aicAddr, void **aivAddr)
{
    return MockFunctionTest::aclStubInstance().rtsFuncGetAddr(funcHandle, aicAddr, aivAddr);
}

rtError_t rtsLaunchKernelWithConfig(rtFuncHandle funcHandle, uint32_t blockDim, rtStream_t stm,
                                    rtKernelLaunchCfg_t *cfg, rtArgsHandle argsHandle, void* reserve)
{
    return MockFunctionTest::aclStubInstance().rtsLaunchKernelWithConfig(funcHandle, blockDim, stm, cfg, argsHandle, reserve);
}

rtError_t rtsKernelArgsInit(rtFuncHandle funcHandle, rtArgsHandle *handle)
{
    return MockFunctionTest::aclStubInstance().rtsKernelArgsInit(funcHandle, handle);
}

rtError_t rtsKernelArgsFinalize(rtArgsHandle argsHandle)
{
    return MockFunctionTest::aclStubInstance().rtsKernelArgsFinalize(argsHandle);
}

rtError_t rtsKernelArgsAppend(rtArgsHandle handle, void *para, size_t paraSize, rtParaHandle *paraHandle)
{
    return MockFunctionTest::aclStubInstance().rtsKernelArgsAppend(handle, para, paraSize, paraHandle);
}

rtError_t rtsKernelArgsAppendPlaceHolder(rtArgsHandle handle, rtParaHandle *paraHandle)
{
    return MockFunctionTest::aclStubInstance().rtsKernelArgsAppendPlaceHolder(handle, paraHandle);
}

rtError_t rtsKernelArgsParaUpdate(rtArgsHandle argsHandle, rtParaHandle paraHandle, void *para, size_t paraSize)
{
    return MockFunctionTest::aclStubInstance().rtsKernelArgsParaUpdate(argsHandle, paraHandle, para, paraSize);
}

rtError_t rtsKernelArgsInitByUserMem(rtFuncHandle funcHandle, rtArgsHandle argsHandle, void *userHostMem, size_t actualArgsSize)
{
    return MockFunctionTest::aclStubInstance().rtsKernelArgsInitByUserMem(funcHandle, argsHandle, userHostMem, actualArgsSize);
}

rtError_t rtsKernelArgsGetMemSize(rtFuncHandle funcHandle, size_t userArgsSize, size_t *actualArgsSize)
{
    return MockFunctionTest::aclStubInstance().rtsKernelArgsGetMemSize(funcHandle, userArgsSize, actualArgsSize);
}

rtError_t rtsKernelArgsGetHandleMemSize(rtFuncHandle funcHandle, size_t *memSize)
{
    return MockFunctionTest::aclStubInstance().rtsKernelArgsGetHandleMemSize(funcHandle, memSize);
}

rtError_t rtsKernelArgsGetPlaceHolderBuffer(rtArgsHandle argsHandle, rtParaHandle paraHandle, size_t dataSize, void **bufferAddr)
{
    return MockFunctionTest::aclStubInstance().rtsKernelArgsGetPlaceHolderBuffer(argsHandle, paraHandle, dataSize, bufferAddr);
}

rtError_t rtsMalloc(void **devPtr, uint64_t size, rtMallocPolicy policy, rtMallocAdvise advise, rtMallocConfig_t *cfg)
{
    return MockFunctionTest::aclStubInstance().rtsMalloc(devPtr, size, policy, advise, cfg);
}

rtError_t rtsMallocHost(void **hostPtr, uint64_t size, const rtMallocConfig_t *cfg)
{
    return MockFunctionTest::aclStubInstance().rtsMallocHost(hostPtr, size, cfg);
}

rtError_t rtsPointerGetAttributes(const void *ptr, rtPtrAttributes_t *attributes)
{
    return MockFunctionTest::aclStubInstance().rtsPointerGetAttributes(ptr, attributes);
}

rtError_t rtsHostRegister(void *ptr, uint64_t size, rtHostRegisterType type, void **devPtr)
{
    return MockFunctionTest::aclStubInstance().rtsHostRegister(ptr, size, type, devPtr);
}

rtError_t rtsHostUnregister(void *ptr)
{
    return MockFunctionTest::aclStubInstance().rtsHostUnregister(ptr);
}

rtError_t rtsGetThreadLastTaskId(uint32_t *taskId)
{
    return MockFunctionTest::aclStubInstance().rtsGetThreadLastTaskId(taskId);
}

rtError_t rtsStreamGetId(rtStream_t stm, int32_t *streamId)
{
    return MockFunctionTest::aclStubInstance().rtsStreamGetId(stm, streamId);
}

rtError_t rtsStreamBeginTaskGrp(rtStream_t stm)
{
    return MockFunctionTest::aclStubInstance().rtsStreamBeginTaskGrp(stm);
}

rtError_t rtsStreamEndTaskGrp(rtStream_t stm, rtTaskGrp_t *handle)
{
    *handle = (rtTaskGrp_t)(0x12345678);
    return MockFunctionTest::aclStubInstance().rtsStreamEndTaskGrp(stm, handle);
}

rtError_t rtsStreamBeginTaskUpdate(rtStream_t stm, rtTaskGrp_t handle)
{
    return MockFunctionTest::aclStubInstance().rtsStreamBeginTaskUpdate(stm, handle);
}

rtError_t rtsStreamEndTaskUpdate(rtStream_t stm)
{
    return MockFunctionTest::aclStubInstance().rtsStreamEndTaskUpdate(stm);
}

rtError_t rtsValueWrite(const void * const devAddr, const uint64_t value, const uint32_t flag, rtStream_t stm)
{
    return MockFunctionTest::aclStubInstance().rtsValueWrite(devAddr, value, flag, stm);
}

rtError_t rtsValueWait(const void * const devAddr, const uint64_t value, const uint32_t flag, rtStream_t stm)
{
    return MockFunctionTest::aclStubInstance().rtsValueWait(devAddr, value, flag, stm);
}

rtError_t rtsStreamGetAvailableNum(uint32_t *streamCount)
{
    return MockFunctionTest::aclStubInstance().rtsStreamGetAvailableNum(streamCount);
}

rtError_t rtsStreamSetAttribute(rtStream_t stm, rtStreamAttr stmAttrId, rtStreamAttrValue_t *attrValue)
{
    return MockFunctionTest::aclStubInstance().rtsStreamSetAttribute(stm, stmAttrId, attrValue);
}

rtError_t rtsStreamGetAttribute(rtStream_t stm, rtStreamAttr stmAttrId, rtStreamAttrValue_t *attrValue)
{
    return MockFunctionTest::aclStubInstance().rtsStreamGetAttribute(stm, stmAttrId, attrValue);
}

rtError_t rtsNotifyCreate(rtNotify_t *notify, uint64_t flag)
{
    return MockFunctionTest::aclStubInstance().rtsNotifyCreate(notify, flag);
}

rtError_t rtsNotifyDestroy(rtNotify_t notify)
{
    return MockFunctionTest::aclStubInstance().rtsNotifyDestroy(notify);
}

rtError_t rtCntNotifyCreateServer(rtCntNotify_t *cntNotify, uint64_t flag)
{
    return MockFunctionTest::aclStubInstance().rtCntNotifyCreateServer(cntNotify, flag);
}

rtError_t rtCntNotifyDestroy(rtCntNotify_t cntNotify)
{
    return MockFunctionTest::aclStubInstance().rtCntNotifyDestroy(cntNotify);
}

rtError_t rtsNotifyRecord(rtNotify_t notify, rtStream_t stream)
{
    return MockFunctionTest::aclStubInstance().rtsNotifyRecord(notify, stream);
}

rtError_t rtsNotifyWaitAndReset(rtNotify_t notify, rtStream_t stream, uint32_t timeout)
{
    return MockFunctionTest::aclStubInstance().rtsNotifyWaitAndReset(notify, stream, timeout);
}

rtError_t rtsNotifyGetId(rtNotify_t notify, uint32_t *notifyId)
{
    return MockFunctionTest::aclStubInstance().rtsNotifyGetId(notify, notifyId);
}

rtError_t rtsEventGetId(rtEvent_t event, uint32_t *eventId)
{
    return MockFunctionTest::aclStubInstance().rtsEventGetId(event, eventId);
}

rtError_t rtsEventGetAvailNum(uint32_t *eventCount)
{
    return MockFunctionTest::aclStubInstance().rtsEventGetAvailNum(eventCount);
}

rtError_t rtsDeviceGetInfo(uint32_t deviceId, rtDevAttr attr, int64_t *val)
{
    return MockFunctionTest::aclStubInstance().rtsDeviceGetInfo(deviceId, attr, val);
}

rtError_t rtsDeviceGetStreamPriorityRange(int32_t *leastPriority, int32_t *greatestPriority)
{
    return MockFunctionTest::aclStubInstance().rtsDeviceGetStreamPriorityRange(leastPriority, greatestPriority);
}

rtError_t rtsDeviceGetCapability(int32_t deviceId, int32_t devFeatureType, int32_t *val)
{
    return MockFunctionTest::aclStubInstance().rtsDeviceGetCapability(deviceId, devFeatureType, val);
}

rtError_t rtGetDeviceUuid(int32_t deviceId, rtUuid_t *uuid)
{
    return MockFunctionTest::aclStubInstance().rtGetDeviceUuid(deviceId, uuid);
}

rtError_t rtsCtxGetCurrentDefaultStream(rtStream_t *stm)
{
    return MockFunctionTest::aclStubInstance().rtsCtxGetCurrentDefaultStream(stm);
}

rtError_t rtsGetPrimaryCtxState(const int32_t devId, uint32_t *flags, int32_t *active)
{
    return MockFunctionTest::aclStubInstance().rtsGetPrimaryCtxState(devId, flags, active);
}

rtError_t rtsModelCreate(rtModel_t *mdl, uint32_t flag)
{
    return MockFunctionTest::aclStubInstance().rtsModelCreate(mdl, flag);
}

rtError_t rtsModelBindStream(rtModel_t mdl, rtStream_t stm, uint32_t flag)
{
    return MockFunctionTest::aclStubInstance().rtsModelBindStream(mdl, stm, flag);
}

rtError_t rtsEndGraph(rtModel_t mdl, rtStream_t stm)
{
    return MockFunctionTest::aclStubInstance().rtsEndGraph(mdl, stm);
}

rtError_t rtsModelLoadComplete(rtModel_t mdl, void *reserve)
{
    return MockFunctionTest::aclStubInstance().rtsModelLoadComplete(mdl, reserve);
}

rtError_t rtsModelUnbindStream(rtModel_t mdl, rtStream_t stm)
{
    return MockFunctionTest::aclStubInstance().rtsModelUnbindStream(mdl, stm);
}

rtError_t rtsModelExecute(rtModel_t mdl, int32_t timeout)
{
    return MockFunctionTest::aclStubInstance().rtsModelExecute(mdl, timeout);
}

rtError_t rtsLaunchReduceAsyncTask(const rtReduceInfo_t *reduceInfo, const rtStream_t stm, const void *reserve)
{
    return MockFunctionTest::aclStubInstance().rtsLaunchReduceAsyncTask(reduceInfo, stm, reserve);
}

rtError_t rtsGetDeviceResLimit(const int32_t deviceId, const rtDevResLimitType_t type, uint32_t *value)
{
    return MockFunctionTest::aclStubInstance().rtsGetDeviceResLimit(deviceId, type, value);
}

rtError_t rtsGetStreamResLimit(const rtStream_t stream, const rtDevResLimitType_t type, uint32_t *value)
{
    return MockFunctionTest::aclStubInstance().rtsGetStreamResLimit(stream, type, value);
}

rtError_t rtsSetStreamResLimit(const rtStream_t stream, const rtDevResLimitType_t type, uint32_t value)
{
    return MockFunctionTest::aclStubInstance().rtsSetStreamResLimit(stream, type, value);
}

rtError_t rtsResetStreamResLimit(const rtStream_t stream)
{
    return MockFunctionTest::aclStubInstance().rtsResetStreamResLimit(stream);
}

rtError_t rtsUseStreamResInCurrentThread(const rtStream_t stream)
{
    return MockFunctionTest::aclStubInstance().rtsUseStreamResInCurrentThread(stream);
}

rtError_t rtsNotUseStreamResInCurrentThread(const rtStream_t stream)
{
    return MockFunctionTest::aclStubInstance().rtsNotUseStreamResInCurrentThread(stream);
}

rtError_t rtsGetResInCurrentThread(rtDevResLimitType_t type, uint32_t *value)
{
    return MockFunctionTest::aclStubInstance().rtsGetResInCurrentThread(type, value);
}

rtError_t rtsSetDeviceResLimit(const int32_t deviceId, const rtDevResLimitType_t type, uint32_t value)
{
    return MockFunctionTest::aclStubInstance().rtsSetDeviceResLimit(deviceId, type, value);
}

rtError_t rtsResetDeviceResLimit(const int32_t deviceId)
{
    return MockFunctionTest::aclStubInstance().rtsResetDeviceResLimit(deviceId);
}

rtError_t rtsLabelCreate(rtLabel_t *lbl)
{
    return MockFunctionTest::aclStubInstance().rtsLabelCreate(lbl);
}

rtError_t rtsLabelSet(rtLabel_t lbl, rtStream_t stm)
{
    return MockFunctionTest::aclStubInstance().rtsLabelSet(lbl, stm);
}

rtError_t rtsLabelDestroy(rtLabel_t lbl)
{
    return MockFunctionTest::aclStubInstance().rtsLabelDestroy(lbl);
}

rtError_t rtsLabelSwitchListCreate(rtLabel_t *labels, size_t num, void **labelList)
{
    return MockFunctionTest::aclStubInstance().rtsLabelSwitchListCreate(labels, num, labelList);
}

rtError_t rtsLabelSwitchListDestroy(void *labelList)
{
    return MockFunctionTest::aclStubInstance().rtsLabelSwitchListDestroy(labelList);
}

rtError_t rtsLabelSwitchByIndex(void *ptr, uint32_t maxValue, void *labelInfoPtr, rtStream_t stm)
{
    return MockFunctionTest::aclStubInstance().rtsLabelSwitchByIndex(ptr, maxValue, labelInfoPtr, stm);
}

rtError_t rtsActiveStream(rtStream_t activeStream, rtStream_t stream)
{
    return MockFunctionTest::aclStubInstance().rtsActiveStream(activeStream, stream);
}

rtError_t rtsSwitchStream(void *leftValue, rtCondition_t cond, void *rightValue, rtSwitchDataType_t dataType, rtStream_t trueStream, rtStream_t falseStream, rtStream_t stream)
{
    return MockFunctionTest::aclStubInstance().rtsSwitchStream(leftValue, cond, rightValue, dataType, trueStream, falseStream, stream);
}

rtError_t rtsFuncGetName(const rtFuncHandle funcHandle, const uint32_t maxLen, char_t * const name)
{
    return MockFunctionTest::aclStubInstance().rtsFuncGetName(funcHandle, maxLen, name);
}

rtError_t rtsModelSetName(rtModel_t mdl, const char_t *mdlName)
{
    return MockFunctionTest::aclStubInstance().rtsModelSetName(mdl, mdlName);
}

rtError_t rtsModelGetName(rtModel_t mdl, const uint32_t maxLen, char_t * const mdlName)
{
    return MockFunctionTest::aclStubInstance().rtsModelGetName(mdl, maxLen, mdlName);
}

rtError_t rtsBinaryLoadFromData(const void *const data, const uint64_t length, const rtLoadBinaryConfig_t *const optionalCfg, rtBinHandle *handle)
{
    return MockFunctionTest::aclStubInstance().rtsBinaryLoadFromData(data, length, optionalCfg, handle);
}

rtError_t rtsRegisterCpuFunc(rtBinHandle binHandle, const char_t *const funcName, const char_t *const kernelName, rtFuncHandle *funcHandle)
{
    return MockFunctionTest::aclStubInstance().rtsRegisterCpuFunc(binHandle, funcName, kernelName, funcHandle);
}

rtError_t rtsCmoAsyncWithBarrier(void *srcAddrPtr, size_t srcLen, rtCmoOpCode cmoType, uint32_t logicId, rtStream_t stm)
{
    return MockFunctionTest::aclStubInstance().rtsCmoAsyncWithBarrier(srcAddrPtr, srcLen, cmoType, logicId, stm);
}

rtError_t rtsLaunchBarrierTask(rtBarrierTaskInfo_t *taskInfo, rtStream_t stm, uint32_t flag)
{
    return MockFunctionTest::aclStubInstance().rtsLaunchBarrierTask(taskInfo, stm, flag);
}

rtError_t rtsGetPairDevicesInfo(uint32_t devId, uint32_t otherDevId, int32_t infoType, uint64_t *val)
{
    return MockFunctionTest::aclStubInstance().rtsGetPairDevicesInfo(devId, otherDevId, infoType, val);
}

rtError_t rtsMemcpyBatch(void **dsts, void **srcs, size_t *sizes, size_t count, rtMemcpyBatchAttr *attrs,
    size_t *attrsIdxs, size_t numAttrs, size_t *failIdx)
{
    return MockFunctionTest::aclStubInstance().rtsMemcpyBatch(dsts, srcs, sizes, count, attrs, attrsIdxs, numAttrs, failIdx);
}

rtError_t rtsMemcpyBatchAsync(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t count,
    rtMemcpyBatchAttr *attrs, size_t *attrsIdxs, size_t numAttrs, size_t *failIdx, rtStream_t stream)
{
    return MockFunctionTest::aclStubInstance().rtsMemcpyBatchAsync(dsts, destMaxs, srcs, sizes, count,
        attrs, attrsIdxs, numAttrs, failIdx, stream);
}

rtError_t rtsIpcMemGetExportKey(const void *ptr, size_t size, char_t *key, uint32_t len, uint64_t flags)
{
    return MockFunctionTest::aclStubInstance().rtsIpcMemGetExportKey(ptr, size, key, len, flags);
}

rtError_t rtsIpcMemClose(const char_t *key)
{
    return MockFunctionTest::aclStubInstance().rtsIpcMemClose(key);
}

rtError_t rtsIpcMemImportByKey(void **ptr, const char_t *key, uint64_t flags)
{
    return MockFunctionTest::aclStubInstance().rtsIpcMemImportByKey(ptr, key, flags);
}

rtError_t rtsIpcMemSetImportPid(const char_t *key, int32_t pid[], int num)
{
    return MockFunctionTest::aclStubInstance().rtsIpcMemSetImportPid(key, pid, num);
}

rtError_t rtIpcSetMemoryAttr(const char *key, uint32_t type, uint64_t attr)
{
    return MockFunctionTest::aclStubInstance().rtIpcSetMemoryAttr(key, type, attr);
}

rtError_t rtIpcMemImportPidInterServer(const char *key, const rtServerPid *serverPids, size_t num)
{
    return MockFunctionTest::aclStubInstance().rtIpcMemImportPidInterServer(key, serverPids, num);
}

rtError_t rtsNotifyBatchReset(rtNotify_t *notifies, uint32_t num)
{
    return MockFunctionTest::aclStubInstance().rtsNotifyBatchReset(notifies, num);
}

rtError_t rtsNotifyGetExportKey(rtNotify_t notify, char_t *key, uint32_t len, uint64_t flags)
{
    return MockFunctionTest::aclStubInstance().rtsNotifyGetExportKey(notify, key, len, flags);
}

rtError_t rtsNotifyImportByKey(rtNotify_t *notify, const char_t *key, uint64_t flags)
{
    return MockFunctionTest::aclStubInstance().rtsNotifyImportByKey(notify, key, flags);
}

rtError_t rtsNotifySetImportPid(rtNotify_t notify, int32_t pid[], int num)
{
    return MockFunctionTest::aclStubInstance().rtsNotifySetImportPid(notify, pid, num);
}

rtError_t rtNotifySetImportPidInterServer(rtNotify_t notify, const rtServerPid *serverPids, size_t num)
{
    return MockFunctionTest::aclStubInstance().rtNotifySetImportPidInterServer(notify, serverPids, num);
}

rtError_t rtsCheckMemType(void** addrList, uint32_t size, uint32_t memType, uint32_t *checkResult, uint32_t reserve)
{
    return MockFunctionTest::aclStubInstance().rtsCheckMemType(addrList, size, memType, checkResult, reserve);
}

rtError_t rtsGetLogicDevIdByUserDevId(const int32_t userDevid, int32_t *const logicDevId)
{
    return MockFunctionTest::aclStubInstance().rtsGetLogicDevIdByUserDevId(userDevid, logicDevId);
}

rtError_t rtsGetUserDevIdByLogicDevId(const int32_t logicDevId, int32_t *const userDevid)
{
    return MockFunctionTest::aclStubInstance().rtsGetUserDevIdByLogicDevId(logicDevId, userDevid);
}

rtError_t rtsGetLogicDevIdByPhyDevId(int32_t phyDevId, int32_t *const logicDevId)
{
    return MockFunctionTest::aclStubInstance().rtsGetLogicDevIdByPhyDevId(phyDevId, logicDevId);
}

rtError_t rtsGetPhyDevIdByLogicDevId(int32_t logicDevId, int32_t *const phyDevId)
{
    return MockFunctionTest::aclStubInstance().rtsGetPhyDevIdByLogicDevId(logicDevId, phyDevId);
}

rtError_t rtsProfTrace(void *userdata, int32_t length, rtStream_t stream)
{
    return MockFunctionTest::aclStubInstance().rtsProfTrace(userdata, length, stream);
}

rtError_t rtsCtxGetFloatOverflowAddr(void **overflowAddr)
{
    return MockFunctionTest::aclStubInstance().rtsCtxGetFloatOverflowAddr(overflowAddr);
}

rtError_t rtsGetFloatOverflowStatus(void *const outputAddr, const uint64_t outputSize, rtStream_t stm)
{
    return MockFunctionTest::aclStubInstance().rtsGetFloatOverflowStatus(outputAddr, outputSize, stm);
}

rtError_t rtsResetFloatOverflowStatus(rtStream_t stm)
{
    return MockFunctionTest::aclStubInstance().rtsResetFloatOverflowStatus(stm);
}

rtError_t rtsNpuGetFloatOverFlowStatus(void *const outputAddr, const uint64_t outputSize, uint32_t checkMode,
    rtStream_t stm)
{
    return MockFunctionTest::aclStubInstance().rtsNpuGetFloatOverFlowStatus(outputAddr, outputSize, checkMode, stm);
}

rtError_t rtsNpuClearFloatOverFlowStatus(uint32_t checkMode, rtStream_t stm)
{
    return MockFunctionTest::aclStubInstance().rtsNpuClearFloatOverFlowStatus(checkMode, stm);
}

rtError_t rtsGetHardwareSyncAddr(void **addr)
{
    return MockFunctionTest::aclStubInstance().rtsGetHardwareSyncAddr(addr);
}

rtError_t rtsLaunchRandomNumTask(const rtRandomNumTaskInfo_t *taskInfo, const rtStream_t stream, void *reserve)
{
    return MockFunctionTest::aclStubInstance().rtsLaunchRandomNumTask(taskInfo, stream, reserve);
}

rtError_t rtsRegStreamStateCallback(const char_t *regName, rtsStreamStateCallback callback, void *args)
{
    return MockFunctionTest::aclStubInstance().rtsRegStreamStateCallback(regName, callback, args);
}

rtError_t rtsRegDeviceStateCallback(const char_t *regName, rtsDeviceStateCallback callback, void *args)
{
    return MockFunctionTest::aclStubInstance().rtsRegDeviceStateCallback(regName, callback, args);
}

rtError_t rtsSetDeviceTaskAbortCallback(const char_t *regName, rtsDeviceTaskAbortCallback callback, void *args)
{
    return MockFunctionTest::aclStubInstance().rtsSetDeviceTaskAbortCallback(regName, callback, args);
}

rtError_t rtGetOpExecuteTimeoutV2(uint32_t * const timeoutMs)
{
    return MockFunctionTest::aclStubInstance().rtGetOpExecuteTimeoutV2(timeoutMs);
}

rtError_t rtsGetP2PStatus(uint32_t devIdDes, uint32_t phyIdSrc, uint32_t *status)
{
    return MockFunctionTest::aclStubInstance().rtsGetP2PStatus(devIdDes, phyIdSrc, status);
}

rtError_t rtsStreamStop(rtStream_t stream)
{
    return MockFunctionTest::aclStubInstance().rtsStreamStop(stream);
}

rtError_t rtsLaunchUpdateTask(rtStream_t taskStream, uint32_t taskId, rtStream_t execStream, rtTaskUpdateCfg_t *info)
{
    return MockFunctionTest::aclStubInstance().rtsLaunchUpdateTask(taskStream, taskId, execStream, info);
}

rtError_t rtsGetCmoDescSize(size_t *size)
{
    return MockFunctionTest::aclStubInstance().rtsGetCmoDescSize(size);
}

rtError_t rtsLaunchCmoAddrTask(rtCmoDesc_t cmoDesc, rtStream_t stream, rtCmoOpCode cmoType, const void *reserve)
{
    return MockFunctionTest::aclStubInstance().rtsLaunchCmoAddrTask(cmoDesc, stream, cmoType, reserve);
}

rtError_t rtsSetCmoDesc(rtCmoDesc_t cmoDesc, void *memAddr, size_t memLen)
{
    return MockFunctionTest::aclStubInstance().rtsSetCmoDesc(cmoDesc, memAddr, memLen);
}

rtError_t rtsModelAbort(rtModel_t modelRI)
{
    return MockFunctionTest::aclStubInstance().rtsModelAbort(modelRI);
}

rtError_t rtCheckArchCompatibility(const char_t *socVersion, int32_t *canCompatible)
{
    return MockFunctionTest::aclStubInstance().rtCheckArchCompatibility(socVersion, canCompatible);
}

rtError_t rtsCntNotifyRecord(rtCntNotify_t cntNotify, rtStream_t stream, rtCntNotifyRecordInfo_t *info)
{
    return MockFunctionTest::aclStubInstance().rtsCntNotifyRecord(cntNotify, stream, info);
}

rtError_t rtsCntNotifyWaitWithTimeout(rtCntNotify_t cntNotify, rtStream_t stream, rtCntNotifyWaitInfo_t *info)
{
    return MockFunctionTest::aclStubInstance().rtsCntNotifyWaitWithTimeout(cntNotify, stream, info);
}

rtError_t rtsCntNotifyReset(rtCntNotify_t cntNotify, rtStream_t stream)
{
    return MockFunctionTest::aclStubInstance().rtsCntNotifyReset(cntNotify, stream);
}

rtError_t rtsCntNotifyGetId(rtCntNotify_t cntNotify, uint32_t *notifyId)
{
    return MockFunctionTest::aclStubInstance().rtsCntNotifyGetId(cntNotify, notifyId);
}

rtError_t rtsPersistentTaskClean(rtStream_t stream)
{
    return MockFunctionTest::aclStubInstance().rtsPersistentTaskClean(stream);
}

rtError_t rtMemSetAccess(void *virPtr, size_t size, rtMemAccessDesc *desc, size_t count)
{
    return MockFunctionTest::aclStubInstance().rtMemSetAccess(virPtr, size, desc, count);
}

rtError_t rtMemGetAccess(void *virPtr, rtMemLocation *location, uint64_t *flag)
{
    return MockFunctionTest::aclStubInstance().rtMemGetAccess(virPtr, location, flag);
}