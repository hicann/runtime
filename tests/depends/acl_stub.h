/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "platform/platform_info.h"
#include "base/err_mgr.h"
#include "tdt/tdt_host_interface.h"
#include "runtime/dev.h"
#include "runtime/rts/rts_device.h"
#include "runtime/stream.h"
#include "runtime/rts/rts_stream.h"
#include "runtime/context.h"
#include "runtime/rts/rts_context.h"
#include "runtime/rts/rts_kernel.h"
#include "runtime/event.h"
#include "runtime/rts/rts_event.h"
#include "runtime/mem.h"
#include "runtime/rts/rts_mem.h"
#include "runtime/kernel.h"
#include "runtime/base.h"
#include "runtime/config.h"
#include "runtime/rt_mem_queue.h"
#include "runtime/rt_preload_task.h"
#include "runtime/rt_stars.h"
#include "runtime/rt_model.h"
#include "runtime/rts/rts_model.h"
#include "runtime/rt_stars_define.h"
#include "runtime/rts/rts_stars.h"
#include "runtime/rt_ras.h"
#include "runtime/rts/rts_snapshot.h"

#include "adx_datadump_server.h"
#include "adump_pub.h"
#include "mmpa/mmpa_api.h"

#include <gmock/gmock.h>

using namespace tdt;

class aclStub
{
public:
    // error manager
    virtual std::unique_ptr<const char_t[]> GetErrMgrErrorMessage();
    virtual int Init();

    // fe function
    virtual uint32_t InitializePlatformInfo();
    virtual uint32_t GetPlatformInfos(
        const std::string SoCVersion, fe::PlatFormInfos &platformInfo, fe::OptionalInfos &optionalInfo);
    virtual uint32_t InitRuntimePlatformInfos(const std::string &SoCVersion);
    virtual uint32_t GetRuntimePlatformInfosByDevice(const uint32_t &device_id, fe::PlatFormInfos &platform_infos);
    virtual uint32_t UpdateRuntimePlatformInfosByDevice(const uint32_t &device_id,
                                                        fe::PlatFormInfos &platform_infos);
    virtual bool GetPlatformResWithLock(const std::string &label, std::map<std::string, std::string> &res);
    virtual bool GetPlatformResWithLock(const string &label, const string &key, string &val);

    // runtime function
    virtual rtError_t rtSubscribeReport(uint64_t threadId, rtStream_t stream);
    virtual rtError_t rtRegTaskFailCallbackByModule(const char *moduleName, rtTaskFailCallback callback);
    virtual rtError_t rtCallbackLaunch(rtCallback_t callBackFunc, void *fnData, rtStream_t stream, bool isBlock);
    virtual rtError_t rtProcessReport(int32_t timeout);
    virtual rtError_t rtsLaunchHostFunc(rtStream_t stm, const rtCallback_t callBackFunc, void * const fnData); 
    virtual rtError_t rtUnSubscribeReport(uint64_t threadId, rtStream_t stream);
    virtual rtError_t rtCtxCreateEx(rtContext_t *ctx, uint32_t flags, int32_t device);
    virtual rtError_t rtSetDevice(int32_t device);
    virtual rtError_t rtDeviceReset(int32_t device);
    virtual rtError_t rtDeviceResetForce(int32_t device);
    virtual rtError_t rtSetDeviceWithoutTsd(int32_t device);
    virtual rtError_t rtDeviceResetWithoutTsd(int32_t device);
    virtual rtError_t rtDeviceSynchronize(void);
    virtual rtError_t rtDeviceSynchronizeWithTimeout(int32_t timeout);
    virtual rtError_t rtGetDevice(int32_t *device);
    virtual rtError_t rtsGetDevice(int32_t *device);
    virtual rtError_t rtSetTSDevice(uint32_t tsId);
    virtual rtError_t rtStreamCreate(rtStream_t *stream, int32_t priority);
    virtual rtError_t rtStreamCreateWithFlags(rtStream_t *stream, int32_t priority, uint32_t flags);
    virtual rtError_t rtsStreamCreate(rtStream_t *stream, rtStreamCreateConfig_t *config);
    virtual rtError_t rtStreamSetMode(rtStream_t stm, const uint64_t mode);
    virtual rtError_t rtStreamDestroy(rtStream_t stream);
    virtual rtError_t rtStreamDestroyForce(rtStream_t stream);
    virtual rtError_t rtStreamSynchronize(rtStream_t stream);
    virtual rtError_t rtStreamSynchronizeWithTimeout(rtStream_t stream, const int32_t timeout);
    virtual rtError_t rtStreamQuery(rtStream_t stream);
    virtual rtError_t rtStreamGetPriority(rtStream_t stream, uint32_t *priority);
    virtual rtError_t rtStreamGetFlags(rtStream_t stream, uint32_t *flags);
    virtual rtError_t rtStreamWaitEvent(rtStream_t stream, rtEvent_t event);
    virtual rtError_t rtStreamWaitEventWithTimeout(rtStream_t stream, rtEvent_t event, uint32_t timeout);
    virtual rtError_t rtIpcGetEventHandle(rtEvent_t event, rtIpcEventHandle_t *handle);
    virtual rtError_t rtIpcOpenEventHandle(rtIpcEventHandle_t handle, rtEvent_t *event);
    virtual rtError_t rtStreamAbort(rtStream_t stream);
    virtual rtError_t rtCtxDestroyEx(rtContext_t ctx);
    virtual rtError_t rtCtxSetCurrent(rtContext_t ctx);
    virtual rtError_t rtCtxSynchronize();
    virtual rtError_t rtCtxGetCurrent(rtContext_t *ctx);
    virtual rtError_t rtGetPriCtxByDeviceId(int32_t device, rtContext_t *ctx);
    virtual rtError_t rtEventCreateWithFlag(rtEvent_t *event_, uint32_t flag);
    virtual rtError_t rtEventCreateExWithFlag(rtEvent_t *event_, uint32_t flag);
    virtual rtError_t rtEventCreate(rtEvent_t *event);
    virtual rtError_t rtGetEventID(rtEvent_t event, uint32_t *eventId);
    virtual rtError_t rtEventDestroy(rtEvent_t event);
    virtual rtError_t rtEventRecord(rtEvent_t event, rtStream_t stream);
    virtual rtError_t rtEventReset(rtEvent_t event, rtStream_t stream);
    virtual rtError_t rtEventSynchronize(rtEvent_t event);
    virtual rtError_t rtEventSynchronizeWithTimeout(rtEvent_t event, const int32_t timeout);
    virtual rtError_t rtEventQuery(rtEvent_t event);
    virtual rtError_t rtEventQueryStatus(rtEvent_t event, rtEventStatus_t *status);
    virtual rtError_t rtEventQueryWaitStatus(rtEvent_t event, rtEventWaitStatus *status);
    virtual rtError_t rtNotifyCreate(int32_t device_id, rtNotify_t *notify_);
    virtual rtError_t rtNotifyDestroy(rtNotify_t notify_);
    virtual rtError_t rtNotifyRecord(rtNotify_t notify_, rtStream_t stream_);
    virtual rtError_t rtGetNotifyID(rtNotify_t notify_, uint32_t *notify_id);
    virtual rtError_t rtNotifyWait(rtNotify_t notify_, rtStream_t stream_);
    virtual rtError_t rtMalloc(void **devPtr, uint64_t size, rtMemType_t type, uint16_t moduleId);
    virtual rtError_t rtMallocCached(void **devPtr, uint64_t size, rtMemType_t type, uint16_t moduleId);
    virtual rtError_t rtFlushCache(void *devPtr, size_t size);
    virtual rtError_t rtInvalidCache(void *devPtr, size_t size);
    virtual rtError_t rtFree(void *devPtr);
    virtual rtError_t rtDvppMalloc(void **devPtr, uint64_t size, uint16_t moduleId);
    virtual rtError_t rtDvppMallocWithFlag(void **devPtr, uint64_t size, uint32_t flag, uint16_t moduleId);
    virtual rtError_t rtDvppFree(void *devPtr);
    virtual rtError_t rtMallocHost(void **hostPtr, uint64_t size, uint16_t moduleId);
    virtual rtError_t rtFreeHost(void *hostPtr);
    virtual rtError_t rtFreeWithDevSync(void *devPtr);
    virtual rtError_t rtFreeHostWithDevSync(void *hostPtr);
    virtual rtError_t rtMemset(void *devPtr, uint64_t destMax, uint32_t value, uint64_t count);
    virtual rtError_t rtMemcpy(void *dst, uint64_t destMax, const void *src, uint64_t count, rtMemcpyKind_t kind);
    virtual rtError_t rtMemcpyAsync(void *dst, uint64_t destMax, const void *src, uint64_t count, rtMemcpyKind_t kind,
                                    rtStream_t stream);
    virtual rtError_t rtMemcpyAsyncEx(void *dst, uint64_t destMax, const void *src, uint64_t count, rtMemcpyKind_t kind,
                                    rtStream_t stream, rtMemcpyConfig_t *memcpyConfig);
    virtual rtError_t rtMemsetAsync(void *ptr, uint64_t destMax, uint32_t value, uint64_t count, rtStream_t stream);
    virtual rtError_t rtCpuKernelLaunchWithFlag(const void *soName, const void *kernelName, uint32_t blockDim,
                                                const rtArgsEx_t *argsInfo, rtSmDesc_t *smDesc, rtStream_t stm,
                                                uint32_t flags);
    virtual rtError_t rtMemGetInfoEx(rtMemInfoType_t memInfoType, size_t *free, size_t *total);
    virtual rtError_t rtGetMemUsageInfo(uint32_t deviceId, rtMemUsageInfo_t *memUsageInfo, size_t inputNum, size_t *outputNum);
    virtual rtError_t rtGetRunMode(rtRunMode *mode);
    virtual rtError_t rtGetDeviceCount(int32_t *count);
    virtual rtError_t rtEventElapsedTime(float *time, rtEvent_t start, rtEvent_t end);
    virtual rtError_t rtDevBinaryUnRegister(void *handle);
    virtual rtError_t rtDevBinaryRegister(const rtDevBinary_t *bin, void **handle);
    virtual rtError_t rtFunctionRegister(void *binHandle, const void *stubFunc, const char *stubName,
                                         const void *devFunc, uint32_t funcMode);
    virtual rtError_t rtKernelLaunch(const void *stubFunc, uint32_t blockDim, void *args, uint32_t argsSize,
                                     rtSmDesc_t *smDesc, rtStream_t stream);
    virtual rtError_t rtGetSocVersion(char *version, const uint32_t maxLen);
    virtual rtError_t rtGetGroupCount(uint32_t *count);
    virtual rtError_t rtGetGroupInfo(int32_t groupid, rtGroupInfo_t *groupInfo, uint32_t count);
    virtual rtError_t rtSetGroup(int32_t groupid);
    virtual rtError_t rtGetDevicePhyIdByIndex(uint32_t devIndex, uint32_t *phyId);
    virtual rtError_t rtEnableP2P(uint32_t devIdDes, uint32_t phyIdSrc, uint32_t flag);
    virtual rtError_t rtDisableP2P(uint32_t devIdDes, uint32_t phyIdSrc);
    virtual rtError_t rtDeviceCanAccessPeer(int32_t *canAccessPeer, uint32_t device, uint32_t peerDevice);
    virtual rtError_t rtGetStreamId(rtStream_t stream_, int32_t *streamId);
    virtual rtError_t rtRegDeviceStateCallback(const char *regName, rtDeviceStateCallback callback);
    virtual rtError_t rtRegDeviceStateCallbackEx(const char *regName, rtDeviceStateCallback callback,
                                                 const rtDevCallBackDir_t notifyPos);
    virtual rtError_t rtDeviceGetStreamPriorityRange(int32_t *leastPriority, int32_t *greatestPriority);
    virtual rtError_t rtGetDeviceCapability(int32_t device, int32_t moduleType, int32_t featureType, int32_t *value);
    virtual rtError_t rtSetOpWaitTimeOut(uint32_t timeout);
    virtual rtError_t rtSetOpExecuteTimeOut(uint32_t timeout);
    virtual rtError_t rtSetOpExecuteTimeOutWithMs(uint32_t timeout);
    virtual rtError_t rtSetOpExecuteTimeOutV2(uint64_t timeout, uint64_t *actualTimeout);
    virtual rtError_t rtGetOpTimeOutInterval(uint64_t *interval);
    virtual rtError_t rtCtxSetSysParamOpt(const rtSysParamOpt configOpt, const int64_t configVal);
    virtual rtError_t rtCtxGetSysParamOpt(const rtSysParamOpt configOpt, int64_t *const configVal);
    virtual rtError_t rtSetSysParamOpt(const rtSysParamOpt configOpt, const int64_t configVal);
    virtual rtError_t rtGetSysParamOpt(const rtSysParamOpt configOpt, int64_t *const configVal);
    virtual rtError_t rtGetDeviceSatStatus(void *const outputAddrPtr, const uint64_t outputSize, rtStream_t stm);
    virtual rtError_t rtCleanDeviceSatStatus(rtStream_t stm);

    virtual rtError_t rtMemQueueInitQS(int32_t devId, const char *groupName);
    virtual rtError_t rtMemQueueCreate(int32_t devId, const rtMemQueueAttr_t *queAttr, uint32_t *qid);

    virtual rtError_t rtMemQueueDestroy(int32_t devId, uint32_t qid);

    virtual rtError_t rtMemQueueInit(int32_t devId);

    virtual rtError_t rtMemQueueEnQueue(int32_t devId, uint32_t qid, void *mbuf);

    virtual rtError_t rtMemQueueDeQueue(int32_t devId, uint32_t qid, void **mbuf);

    virtual rtError_t rtMemQueuePeek(int32_t devId, uint32_t qid, size_t *bufLen, int32_t timeout);

    virtual rtError_t rtMemQueueEnQueueBuff(int32_t devId, uint32_t qid, rtMemQueueBuff_t *inBuf, int32_t timeout);

    virtual rtError_t rtMemQueueDeQueueBuff(int32_t devId, uint32_t qid, rtMemQueueBuff_t *outBuf, int32_t timeout);

    virtual rtError_t rtMemQueueQuery(int32_t devId, rtMemQueueQueryCmd_t cmd, void *inBuff, uint32_t inLen,
                                      void *outBuff, uint32_t *outLen);

    virtual rtError_t rtMemQueueQueryInfo(int32_t device, uint32_t qid, rtMemQueueInfo_t *queueInfo);

    virtual rtError_t rtMemQueueGrant(int32_t devId, uint32_t qid, int32_t pid, rtMemQueueShareAttr_t *attr);

    virtual rtError_t rtMemQueueAttach(int32_t devId, uint32_t qid, int32_t timeout);

    virtual rtError_t rtEschedSubmitEventSync(int32_t devId, rtEschedEventSummary_t *event, rtEschedEventReply_t *ack);

    virtual rtError_t rtQueryDevPid(rtBindHostpidInfo_t *info, pid_t *devPid);

    virtual rtError_t rtMbufInit(rtMemBuffCfg_t *cfg);

    virtual rtError_t rtMbufAlloc(rtMbufPtr_t *mbuf, uint64_t size);

    virtual rtError_t rtMbufAllocEx(rtMbufPtr_t *mbuf, uint64_t size, uint64_t flag, int32_t grpId);

    virtual rtError_t rtMbufGetBuffAddr(rtMbufPtr_t mbuf, void **databuf);

    virtual rtError_t rtMbufGetBuffSize(rtMbufPtr_t mbuf, uint64_t *size);

    virtual rtError_t rtMbufGetPrivInfo(rtMbufPtr_t mbuf, void **priv, uint64_t *size);

    virtual rtError_t rtMbufCopyBufRef(rtMbufPtr_t mbuf, rtMbufPtr_t *newMbuf);

    virtual rtError_t rtMemGrpCreate(const char *name, const rtMemGrpConfig_t *cfg);

    virtual rtError_t rtMemGrpAddProc(const char *name, int32_t pid, const rtMemGrpShareAttr_t *attr);

    virtual rtError_t rtMemGrpAttach(const char *name, int32_t timeout);

    virtual rtError_t rtMemGrpQuery(rtMemGrpQueryInput_t * const input, rtMemGrpQueryOutput_t *output);

    virtual rtError_t rtMemcpy2d(void *dst, uint64_t dpitch, const void *src, uint64_t spitch, uint64_t width,
                                 uint64_t height, rtMemcpyKind_t kind);
    virtual rtError_t rtMemcpy2dAsync(void *dst, uint64_t dpitch, const void *src, uint64_t spitch, uint64_t width,
                                      uint64_t height, rtMemcpyKind_t kind, rtStream_t stream);
    virtual rtError_t rtGetDevMsg(rtGetDevMsgType_t getMsgType, rtGetMsgCallback callback);
    virtual rtError_t rtGetFaultEvent(const int32_t deviceId, rtDmsEventFilter *filter, rtDmsFaultEvent *dmsEvent,
                                      uint32_t len, uint32_t *eventCount);
    virtual rtError_t rtSetDeviceSatMode(rtFloatOverflowMode_t floatOverflowMode);
    virtual rtError_t rtGetDeviceSatMode(rtFloatOverflowMode_t *floatOverflowMode);
    virtual rtError_t rtSetStreamOverflowSwitch(rtStream_t stm, uint32_t flags);
    virtual rtError_t rtGetStreamOverflowSwitch(rtStream_t stm, uint32_t *flags);
    virtual rtError_t rtGetAiCoreCount(uint32_t *aiCoreCnt);
    virtual rtError_t rtGetDeviceInfo(uint32_t deviceId, int32_t moduleType, int32_t infoType, int64_t *val);
    virtual rtError_t rtGetAllUtilizations(const int32_t devId, const rtTypeUtil_t kind, uint8_t *const util);
    virtual rtError_t rtDeviceStatusQuery(const uint32_t devId, rtDeviceStatus *deviceStatus);

    virtual rtError_t rtMemRetainAllocationHandle(void* virPtr, rtDrvMemHandle *handle);
    virtual rtError_t rtMemGetAllocationPropertiesFromHandle(rtDrvMemHandle handle, rtDrvMemProp_t* prop);
    virtual rtError_t rtReserveMemAddress(void **devPtr, size_t size, size_t alignment, void *devAddr, uint64_t flags);
    virtual rtError_t rtReleaseMemAddress(void *devPtr);
    virtual rtError_t rtMallocPhysical(rtDrvMemHandle *handle, size_t size, rtDrvMemProp_t *prop, uint64_t flags);
    virtual rtError_t rtFreePhysical(rtDrvMemHandle handle);
    virtual rtError_t rtMapMem(void *devPtr, size_t size, size_t offset, rtDrvMemHandle handle, uint64_t flags);
    virtual rtError_t rtUnmapMem(void *devPtr);
    virtual rtError_t rtBinaryLoadWithoutTilingKey(const void *data, const uint64_t length, rtBinHandle *binHandle);
    virtual rtError_t rtBinaryUnLoad(rtBinHandle binHandle);
    virtual rtError_t rtsFuncGetByName(const rtBinHandle binHandle, const char_t *kernelName,
                                       rtFuncHandle *funcHandle);
    virtual rtError_t rtCreateLaunchArgs(size_t argsSize, size_t hostInfoTotalSize, size_t hostInfoNum,
                                         void *argsData, rtLaunchArgsHandle *argsHandle);
    virtual rtError_t rtDestroyLaunchArgs(rtLaunchArgsHandle argsHandle);
    virtual rtError_t rtLaunchKernelByFuncHandleV3(rtFuncHandle funcHandle, uint32_t blockDim,
                                                   const rtArgsEx_t *const argsInfo, rtStream_t stm, const rtTaskCfgInfo_t *const cfgInfo);
    virtual rtError_t rtMemExportToShareableHandle(rtDrvMemHandle handle, rtDrvMemHandleType handleType,
                                                   uint64_t flag, uint64_t *shareableHandle);
    virtual rtError_t rtsMemExportToShareableHandle(rtDrvMemHandle handle, rtDrvMemHandleType handleType,
        uint64_t flag, uint64_t *shareableHandle);
    virtual rtError_t rtMemExportToShareableHandleV2(
        rtDrvMemHandle handle, rtMemSharedHandleType handleType, uint64_t flags, void *shareableHandle);
    virtual rtError_t rtMemImportFromShareableHandle(uint64_t shareableHandle, int32_t deviceId,
                                                     rtDrvMemHandle *handle);                                           
    virtual rtError_t rtsMemImportFromShareableHandle(uint64_t shareableHandle, int32_t deviceId,
        rtDrvMemHandle *handle);
    virtual rtError_t rtMemImportFromShareableHandleV2(const void *shareableHandle, rtMemSharedHandleType handleType, uint64_t flags,
    int32_t devId, rtDrvMemHandle *handle);
    virtual rtError_t rtMemSetPidToShareableHandle(uint64_t shareableHandle, int pid[], uint32_t pidNum);
    virtual rtError_t rtsMemSetPidToShareableHandle(uint64_t shareableHandle, int pid[], uint32_t pidNum);
    virtual rtError_t rtMemSetPidToShareableHandleV2(
        const void *shareableHandle, rtMemSharedHandleType handleType, int pid[], uint32_t pidNum);
    virtual rtError_t rtMemGetAllocationGranularity(rtDrvMemProp_t *prop,
                                                    rtDrvMemGranularityOptions option, size_t *granularity);
    virtual rtError_t rtDeviceGetBareTgid(uint32_t *pid);
    virtual rtError_t rtGetL2CacheOffset(uint32_t deivceId, uint64_t *offset);
    virtual rtError_t rtRegKernelLaunchFillFunc(const char *symbol, rtKernelLaunchFillFunc func);
    virtual rtError_t rtUnRegKernelLaunchFillFunc(const char *symbol);
    virtual rtError_t rtGetMemUceInfo(const uint32_t deviceId, rtMemUceInfo *memUceInfo);
    virtual rtError_t rtMemUceRepair(const uint32_t deviceId, rtMemUceInfo *memUceInfo);
    virtual rtError_t rtDeviceTaskAbort(int32_t devId, uint32_t timeout);
    virtual rtError_t rtMemQueueReset(int32_t devId, uint32_t qid);
    virtual rtError_t rtSetDefaultDeviceId(int32_t deviceId);
    virtual rtError_t rtDeviceSetLimit(int32_t devId, rtLimitType_t type, uint32_t val);
    virtual rtError_t rtEventWorkModeSet(uint8_t event_mode);
    virtual rtError_t rtRegStreamStateCallback(const char *regName, rtStreamStateCallback callback);
    virtual rtError_t rtCtxGetCurrentDefaultStream(rtStream_t* stm);
    virtual rtError_t rtCmoAsync(void *srcAddrPtr, size_t srcLen, rtCmoOpCode_t cmpType, rtStream_t stm);
    virtual rtError_t rtsCmoAsync(void *srcAddrPtr, size_t srcLen, rtCmoOpCode_t cmoType, rtStream_t stm);
    virtual rtError_t rtStreamBeginCapture(rtStream_t stm, const rtStreamCaptureMode mode);
    virtual rtError_t rtStreamGetCaptureInfo(rtStream_t stm, rtStreamCaptureStatus *const status, rtModel_t *captureMdl);
    virtual rtError_t rtStreamEndCapture(rtStream_t stm, rtModel_t *captureMdl);
    virtual rtError_t rtCacheLastTaskOpInfo(const void * const infoPtr, const size_t infoSize);
    virtual rtError_t rtFunctionGetAttribute(rtFuncHandle funcHandle, rtFuncAttribute attrType, int64_t *attrValue);

    virtual rtError_t rtModelDebugDotPrint(rtModel_t mdl);
    virtual rtError_t rtModelDebugJsonPrint(rtModel_t mdl, const char *path, uint32_t flags);
    virtual rtError_t rtThreadExchangeCaptureMode(rtStreamCaptureMode *mode);
    virtual rtError_t rtModelExecute(rtModel_t mdl, rtStream_t stm, uint32_t flag);
    virtual rtError_t rtModelDestroy(rtModel_t mdl);
    virtual rtError_t rtsStreamBeginTaskGrp(rtStream_t stm);
    virtual rtError_t rtsStreamEndTaskGrp(rtStream_t stm, rtTaskGrp_t *handle);
    virtual rtError_t rtsStreamBeginTaskUpdate(rtStream_t stm, rtTaskGrp_t handle);
    virtual rtError_t rtsStreamEndTaskUpdate(rtStream_t stm);

    virtual rtError_t rtsMemcpyAsyncWithDesc(rtMemcpyDesc_t desc, rtMemcpyKind kind, rtMemcpyConfig_t *config, rtStream_t stream);
    virtual rtError_t rtMemcpyAsyncWithOffset(void **dst, uint64_t dstMax, uint64_t dstDataOffset, const void **src,
        uint64_t count, uint64_t srcDataOffset, rtMemcpyKind kind, rtStream_t stream);
    virtual rtError_t rtsGetMemcpyDescSize(rtMemcpyKind kind, size_t *size);
    virtual rtError_t rtsSetMemcpyDesc(rtMemcpyDesc_t desc, rtMemcpyKind kind, void *srcAddr, void *dstAddr, size_t count, rtMemcpyConfig_t *config);
    virtual rtError_t rtsBinaryLoadFromFile(const char * const binPath, const rtLoadBinaryConfig_t * const optionalCfg, rtBinHandle *handle);
    virtual rtError_t rtsBinaryGetDevAddress(const rtBinHandle binHandle, void **bin, uint32_t *binSize);
    virtual rtError_t rtsFuncGetByEntry(const rtBinHandle binHandle, const uint64_t funcEntry, rtFuncHandle *funcHandle);
    virtual rtError_t rtsFuncGetAddr(const rtFuncHandle funcHandle, void **aicAddr, void **aivAddr);

    virtual rtError_t rtsLaunchKernelWithConfig(rtFuncHandle funcHandle, uint32_t blockDim, rtStream_t stm, rtKernelLaunchCfg_t *cfg, rtArgsHandle argsHandle, void* reserve);
    virtual rtError_t rtsKernelArgsInit(rtFuncHandle funcHandle, rtArgsHandle *handle);
    virtual rtError_t rtsKernelArgsInitByUserMem(rtFuncHandle funcHandle, rtArgsHandle argsHandle, void *userHostMem, size_t actualArgsSize);
    virtual rtError_t rtsKernelArgsFinalize(rtArgsHandle argsHandle);
    virtual rtError_t rtsKernelArgsAppend(rtArgsHandle handle, void *para, size_t paraSize, rtParaHandle *paraHandle);
    virtual rtError_t rtsKernelArgsAppendPlaceHolder(rtArgsHandle handle, rtParaHandle *paraHandle);
    virtual rtError_t rtsKernelArgsParaUpdate(rtArgsHandle argsHandle, rtParaHandle paraHandle, void *para, size_t paraSize);
    virtual rtError_t rtsKernelArgsGetMemSize(rtFuncHandle funcHandle, size_t userArgsSize, size_t *actualArgsSize);
    virtual rtError_t rtsKernelArgsGetHandleMemSize(rtFuncHandle funcHandle, size_t *memSize);
    virtual rtError_t rtsKernelArgsGetPlaceHolderBuffer(rtArgsHandle argsHandle, rtParaHandle paraHandle, size_t dataSize, void **bufferAddr);

    virtual rtError_t rtsMalloc(void **devPtr, uint64_t size, rtMallocPolicy policy, rtMallocAdvise advise, rtMallocConfig_t *cfg);
    virtual rtError_t rtsMallocHost(void **hostPtr, uint64_t size, const rtMallocConfig_t *cfg);

    virtual rtError_t rtsPointerGetAttributes(const void *ptr, rtPtrAttributes_t *attributes);
    virtual rtError_t rtsHostRegister(void *ptr, uint64_t size, rtHostRegisterType type, void **devPtr);
    virtual rtError_t rtHostRegisterV2(void *ptr, uint64_t size, uint32_t flag);
    virtual rtError_t rtHostGetDevicePointer(void *pHost, void **pDevice, uint32_t flag);
    virtual rtError_t rtsHostUnregister(void *ptr);
    virtual rtError_t rtsGetThreadLastTaskId(uint32_t *taskId);
    virtual rtError_t rtsStreamGetId(rtStream_t stm, int32_t *streamId);

    virtual rtError_t rtsValueWrite(const void * const devAddr, const uint64_t value, const uint32_t flag, rtStream_t stm);
    virtual rtError_t rtsValueWait(const void * const devAddr, const uint64_t value, const uint32_t flag, rtStream_t stm);

    virtual rtError_t rtsStreamGetAvailableNum(uint32_t *streamCount);
    virtual rtError_t rtsStreamSetAttribute(rtStream_t stm, rtStreamAttr stmAttrId, rtStreamAttrValue_t *attrValue);
    virtual rtError_t rtsStreamGetAttribute(rtStream_t stm, rtStreamAttr stmAttrId, rtStreamAttrValue_t *attrValue);

    virtual rtError_t rtsNotifyCreate(rtNotify_t *notify, uint64_t flag);
    virtual rtError_t rtsNotifyDestroy(rtNotify_t notify);
    virtual rtError_t rtCntNotifyCreateServer(rtCntNotify_t *cntNotify, uint64_t flag);
    virtual rtError_t rtCntNotifyDestroy(rtCntNotify_t cntNotify);
    virtual rtError_t rtsNotifyRecord(rtNotify_t notify, rtStream_t stream);
    virtual rtError_t rtsNotifyWaitAndReset(rtNotify_t notify, rtStream_t stream, uint32_t timeout);
    virtual rtError_t rtsNotifyGetId(rtNotify_t notify, uint32_t *notifyId);

    virtual rtError_t rtsEventGetId(rtEvent_t event, uint32_t *eventId);
    virtual rtError_t rtsEventGetAvailNum(uint32_t *eventCount);
    virtual rtError_t rtsEventWait(rtStream_t stream, rtEvent_t event, uint32_t timeout);

    virtual rtError_t rtsDeviceGetInfo(uint32_t deviceId, rtDevAttr attr, int64_t *val);
    virtual rtError_t rtsDeviceGetStreamPriorityRange(int32_t *leastPriority, int32_t *greatestPriority);
    virtual rtError_t rtsDeviceGetCapability(int32_t deviceId, int32_t devFeatureType, int32_t *val);
    virtual rtError_t rtGetDeviceUuid(int32_t deviceId, rtUuid_t *uuid);

    virtual rtError_t rtsCtxGetCurrentDefaultStream(rtStream_t *stm);
    virtual rtError_t rtsGetPrimaryCtxState(const int32_t devId, uint32_t *flags, int32_t *active);

    virtual rtError_t rtsModelCreate(rtModel_t *mdl, uint32_t flag);
    virtual rtError_t rtsModelBindStream(rtModel_t mdl, rtStream_t stm, uint32_t flag);
    virtual rtError_t rtsEndGraph(rtModel_t mdl, rtStream_t stm);
    virtual rtError_t rtsModelLoadComplete(rtModel_t mdl, void *reserve);
    virtual rtError_t rtsModelUnbindStream(rtModel_t mdl, rtStream_t stm);
    virtual rtError_t rtsModelExecute(rtModel_t mdl, int32_t timeout);

    virtual rtError_t rtsLaunchReduceAsyncTask(const rtReduceInfo_t *reduceInfo, const rtStream_t stm, const void *reserve);

    virtual rtError_t rtsGetDeviceResLimit(const int32_t deviceId, const rtDevResLimitType_t type, uint32_t *value);
    virtual rtError_t rtsSetDeviceResLimit(const int32_t deviceId, const rtDevResLimitType_t type, uint32_t value);
    virtual rtError_t rtsResetDeviceResLimit(const int32_t deviceId);

    virtual rtError_t rtsGetStreamResLimit(rtStream_t stream, const rtDevResLimitType_t type, uint32_t *value);
    virtual rtError_t rtsSetStreamResLimit(rtStream_t stream, const rtDevResLimitType_t type, uint32_t value);
    virtual rtError_t rtsResetStreamResLimit(rtStream_t stream);
    virtual rtError_t rtsUseStreamResInCurrentThread(rtStream_t stream);
    virtual rtError_t rtsNotUseStreamResInCurrentThread(rtStream_t stream);
    virtual rtError_t rtsGetResInCurrentThread(const rtDevResLimitType_t type, uint32_t *value);

    virtual rtError_t rtsLabelCreate(rtLabel_t *lbl);
    virtual rtError_t rtsLabelSet(rtLabel_t lbl, rtStream_t stm);
    virtual rtError_t rtsLabelDestroy(rtLabel_t lbl);
    virtual rtError_t rtsLabelSwitchListCreate(rtLabel_t *labels, size_t num, void **labelList);
    virtual rtError_t rtsLabelSwitchListDestroy(void *labelList);
    virtual rtError_t rtsLabelSwitchByIndex(void *ptr, uint32_t maxValue, void *labelInfoPtr, rtStream_t stm);

    virtual rtError_t rtsActiveStream(rtStream_t activeStream, rtStream_t stream);
    virtual rtError_t rtsSwitchStream(void *leftValue, rtCondition_t cond, void *rightValue, rtSwitchDataType_t dataType, rtStream_t trueStream, rtStream_t falseStream, rtStream_t stream);
    virtual rtError_t rtsFuncGetName(const rtFuncHandle funcHandle, const uint32_t maxLen, char_t * const name);
    virtual rtError_t rtsModelSetName(rtModel_t mdl, const char_t *mdlName);
    virtual rtError_t rtsModelGetName(rtModel_t mdl, const uint32_t maxLen, char_t * const mdlName);

    virtual rtError_t rtsBinaryLoadFromData(const void *const data, const uint64_t length, const rtLoadBinaryConfig_t *const optionalCfg, rtBinHandle *handle);
    virtual rtError_t rtsRegisterCpuFunc(rtBinHandle binHandle, const char_t *const funcName, const char_t *const kernelName, rtFuncHandle *funcHandle);
    virtual rtError_t rtsCmoAsyncWithBarrier(void *srcAddrPtr, size_t srcLen, rtCmoOpCode cmoType, uint32_t logicId, rtStream_t stm);
    virtual rtError_t rtsLaunchBarrierTask(rtBarrierTaskInfo_t *taskInfo, rtStream_t stm, uint32_t flag);
    virtual rtError_t rtsGetPairDevicesInfo(uint32_t devId, uint32_t otherDevId, int32_t infoType, uint64_t *val);

    virtual rtError_t rtsMemcpyBatch(void **dsts, void **srcs, size_t *sizes, size_t count, rtMemcpyBatchAttr *attrs, size_t *attrsIdxs, size_t numAttrs, size_t *failIdx);
    virtual rtError_t rtsMemcpyBatchAsync(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t count,
        rtMemcpyBatchAttr *attrs, size_t *attrsIdxs, size_t numAttrs, size_t *failIdx, rtStream_t stream);

    virtual rtError_t rtsIpcMemGetExportKey(const void *ptr, size_t size, char_t *key, uint32_t len, uint64_t flags);
    virtual rtError_t rtsIpcMemClose(const char_t *key);
    virtual rtError_t rtsIpcMemImportByKey(void **ptr, const char_t *key, uint64_t flags);
    virtual rtError_t rtsIpcMemSetImportPid(const char_t *key, int32_t pid[], int num);
    virtual rtError_t rtIpcSetMemoryAttr(const char *key, uint32_t type, uint64_t attr);
    virtual rtError_t rtIpcMemImportPidInterServer(const char *key, const rtServerPid *serverPids, size_t num);
    virtual rtError_t rtMemSetAccess(void *virPtr, size_t size, rtMemAccessDesc *desc, size_t count);
    virtual rtError_t rtMemGetAccess(void *virPtr, rtMemLocation *location, uint64_t *flag);

    virtual rtError_t rtsNotifyBatchReset(rtNotify_t *notifies, uint32_t num);
    virtual rtError_t rtsNotifyGetExportKey(rtNotify_t notify, char_t *key, uint32_t len, uint64_t flags);
    virtual rtError_t rtsNotifyImportByKey(rtNotify_t *notify, const char_t *key, uint64_t flags);
    virtual rtError_t rtsNotifySetImportPid(rtNotify_t notify, int32_t pid[], int num);
    virtual rtError_t rtNotifySetImportPidInterServer(rtNotify_t notify, const rtServerPid *serverPids, size_t num);
    virtual rtError_t rtsCheckMemType(void** addrList, uint32_t size, uint32_t memType, uint32_t *checkResult, uint32_t reserve);
    virtual rtError_t rtsGetLogicDevIdByUserDevId(const int32_t userDevid, int32_t *const logicDevId);
    virtual rtError_t rtsGetUserDevIdByLogicDevId(const int32_t logicDevId, int32_t *const userDevid);
    virtual rtError_t rtsGetLogicDevIdByPhyDevId(int32_t phyDevId, int32_t *const logicDevId);
    virtual rtError_t rtsGetPhyDevIdByLogicDevId(int32_t logicDevId, int32_t *const phyDevId);

    virtual rtError_t rtsProfTrace(void *userdata, int32_t length, rtStream_t stream);
    virtual rtError_t rtsLaunchKernelWithDevArgs(rtFuncHandle funcHandle, uint32_t blockDim,
                                                 rtStream_t stm, rtKernelLaunchCfg_t *cfg,
                                                 const void *args, uint32_t argsSize, void *reserve);
    virtual rtError_t rtsLaunchKernelWithHostArgs(rtFuncHandle funcHandle, uint32_t blockDim, rtStream_t stm,
                                                  rtKernelLaunchCfg_t *cfg, void *hostArgs, uint32_t argsSize,
                                                  rtPlaceHolderInfo_t *placeHolderArray, uint32_t placeHolderNum);
    virtual rtError_t rtsGetFloatOverflowStatus(void *const outputAddr, const uint64_t outputSize, rtStream_t stm);
    virtual rtError_t rtsResetFloatOverflowStatus(rtStream_t stm);
    virtual rtError_t rtsNpuGetFloatOverFlowStatus(void *const outputAddr, const uint64_t outputSize, uint32_t checkMode, rtStream_t stm);
    virtual rtError_t rtsNpuClearFloatOverFlowStatus(uint32_t checkMode, rtStream_t stm);
    virtual rtError_t rtsCtxGetFloatOverflowAddr(void **overflowAddr);

    virtual rtError_t rtsGetHardwareSyncAddr(void **addr);
    virtual rtError_t rtsLaunchRandomNumTask(const rtRandomNumTaskInfo_t *taskInfo, const rtStream_t stream, void *reserve);
    virtual rtError_t rtsRegStreamStateCallback(const char_t *regName, rtsStreamStateCallback callback, void *args);
    virtual rtError_t rtsRegDeviceStateCallback(const char_t *regName, rtsDeviceStateCallback callback, void *args);
    virtual rtError_t rtsSetDeviceTaskAbortCallback(const char_t *regName, rtsDeviceTaskAbortCallback callback, void *args);
    virtual rtError_t rtGetOpExecuteTimeoutV2(uint32_t * const timeoutMs);
    virtual rtError_t rtsGetP2PStatus(uint32_t devIdDes, uint32_t phyIdSrc, uint32_t *status);
    virtual rtError_t rtsStreamStop(rtStream_t stream);
    virtual rtError_t rtsLaunchUpdateTask(rtStream_t taskStream, uint32_t taskId, rtStream_t execStream, rtTaskUpdateCfg_t *info);

    virtual rtError_t rtsGetCmoDescSize(size_t *size);
    virtual rtError_t rtsSetCmoDesc(rtCmoDesc_t cmoDesc, void *memAddr, size_t memLen);
    virtual rtError_t rtsLaunchCmoAddrTask(rtCmoDesc_t cmoDesc, rtStream_t stream, rtCmoOpCode cmoType, const void *reserve);
    virtual rtError_t rtsModelAbort(rtModel_t modelRI);
    virtual rtError_t rtCheckArchCompatibility(const char_t *socVersion, int32_t *canCompatible);

    virtual rtError_t rtsCntNotifyRecord(rtCntNotify_t cntNotify, rtStream_t stream, rtCntNotifyRecordInfo_t *info);
    virtual rtError_t rtsCntNotifyWaitWithTimeout(rtCntNotify_t cntNotify, rtStream_t stream, rtCntNotifyWaitInfo_t *info);
    virtual rtError_t rtsCntNotifyReset(rtCntNotify_t cntNotify, rtStream_t stream);
    virtual rtError_t rtsCntNotifyGetId(rtCntNotify_t cntNotify, uint32_t *notifyId);

    virtual rtError_t rtsPersistentTaskClean(rtStream_t stream);
    
    // geterror function
    virtual rtError_t rtsGetErrorVerbose(uint32_t deviceId, rtErrorInfo* errorInfo);
    virtual rtError_t rtsRepairError(uint32_t deviceId, const rtErrorInfo* errorInfo);
    virtual rtError_t rtSnapShotProcessLock();
    virtual rtError_t rtSnapShotProcessUnlock();
    virtual rtError_t rtSnapShotProcessBackup();
    virtual rtError_t rtSnapShotProcessRestore();
    virtual rtError_t rtSnapShotCallbackRegister(rtSnapShotStage stage, rtSnapShotCallBack callback, void* args);
 	virtual rtError_t rtSnapShotCallbackUnregister(rtSnapShotStage stage, rtSnapShotCallBack callback);
    // tdt function
    virtual int32_t TdtHostInit(uint32_t deviceId);
    virtual int32_t TdtHostPreparePopData();
    virtual int32_t TdtHostStop(const std::string &channelName);
    virtual int32_t TdtHostDestroy();
    virtual int32_t TdtHostPushData(const std::string &channelName, const std::vector<tdt::DataItem> &item, uint32_t deviceId);
    virtual int32_t TdtHostPopData(const std::string &channelName, std::vector<tdt::DataItem> &item);
    // prof function
    virtual int32_t MsprofFinalize();
    virtual int32_t MsprofInit(uint32_t aclDataType, void *data, uint32_t dataLen);
    virtual int32_t MsprofRegTypeInfo(uint16_t level, uint32_t typeId, const char *typeName);
    // adx function
    virtual int AdxDataDumpServerInit();
    virtual int AdxDataDumpServerUnInit();
    virtual int32_t AdumpSetDump(const char *dumpConfigData, size_t dumpConfigSize);
    virtual int32_t AdumpUnSetDump();

    // slog function
    virtual int dlog_getlevel(int module_id, int *enable_event);

    // mmpa function
    virtual void *mmAlignMalloc(mmSize mallocSize, mmSize alignSize);
    virtual INT32 mmAccess2(const CHAR *pathName, INT32 mode);
    virtual INT32 mmDladdr(VOID *addr, mmDlInfo *info);
};

class MockFunctionTest : public aclStub
{
public:
    MockFunctionTest();
    static MockFunctionTest &aclStubInstance();
    void ResetToDefaultMock();
    // error manager
    MOCK_METHOD0(GetErrMgrErrorMessage, std::unique_ptr<const char_t[]>());
    MOCK_METHOD0(Init, int());

    // fe function
    MOCK_METHOD0(InitializePlatformInfo, uint32_t());
    MOCK_METHOD3(GetPlatformInfos,
        uint32_t(const std::string SoCVersion, fe::PlatFormInfos &platformInfo, fe::OptionalInfos &optionalInfo));
    MOCK_METHOD1(InitRuntimePlatformInfos, uint32_t(const std::string &SoCVersion));
    MOCK_METHOD2(GetRuntimePlatformInfosByDevice, uint32_t(const uint32_t &device_id, fe::PlatFormInfos &platform_infos));
    MOCK_METHOD2(GetPlatformResWithLock, bool(const std::string &label, std::map<std::string, std::string> &res));
    MOCK_METHOD3(GetPlatformResWithLock, bool(const string &label, const string &key, string &val));
    MOCK_METHOD2(UpdateRuntimePlatformInfosByDevice, uint32_t(const uint32_t &device_id, fe::PlatFormInfos &platform_infos));
    // tdt function stub
    MOCK_METHOD1(TdtHostInit, int32_t(uint32_t deviceId));
    MOCK_METHOD0(TdtHostPreparePopData, int32_t());
    MOCK_METHOD1(TdtHostStop, int32_t(const std::string &channelName));
    MOCK_METHOD0(TdtHostDestroy, int32_t());
    MOCK_METHOD3(TdtHostPushData, int32_t(const std::string &channelName, const std::vector<tdt::DataItem> &item, uint32_t deviceId));
    MOCK_METHOD2(TdtHostPopData, int32_t(const std::string &channelName, std::vector<tdt::DataItem> &item));
    // runtime function stub
    MOCK_METHOD2(rtSubscribeReport, rtError_t(uint64_t threadId, rtStream_t stream));
    MOCK_METHOD2(rtRegTaskFailCallbackByModule, rtError_t(const char *moduleName, rtTaskFailCallback callback));
    MOCK_METHOD4(rtCallbackLaunch, rtError_t(rtCallback_t callBackFunc, void *fnData, rtStream_t stream, bool isBlock));
    MOCK_METHOD3(rtsLaunchHostFunc, rtError_t(rtStream_t stm, const rtCallback_t callBackFunc, void * const fnData));
    MOCK_METHOD1(rtProcessReport, rtError_t(int32_t timeout));
    MOCK_METHOD2(rtUnSubscribeReport, rtError_t(uint64_t threadId, rtStream_t stream));
    MOCK_METHOD3(rtCtxCreateEx, rtError_t(rtContext_t *ctx, uint32_t flags, int32_t device));
    MOCK_METHOD1(rtSetDevice, rtError_t(int32_t device));
    MOCK_METHOD1(rtSetDefaultDeviceId, rtError_t(int32_t device));
    MOCK_METHOD3(rtDeviceSetLimit, rtError_t(int32_t devId, rtLimitType_t type, uint32_t val));
    MOCK_METHOD1(rtEventWorkModeSet, rtError_t(uint8_t event_mode));
    MOCK_METHOD1(rtDeviceReset, rtError_t(int32_t device));
    MOCK_METHOD1(rtDeviceResetForce, rtError_t(int32_t device));
    MOCK_METHOD1(rtSetDeviceWithoutTsd, rtError_t(int32_t device));
    MOCK_METHOD1(rtDeviceResetWithoutTsd, rtError_t(int32_t device));
    MOCK_METHOD0(rtDeviceSynchronize, rtError_t(void));
    MOCK_METHOD1(rtDeviceSynchronizeWithTimeout, rtError_t(int32_t timeout));
    MOCK_METHOD1(rtGetDevice, rtError_t(int32_t *device));
    MOCK_METHOD1(rtsGetDevice, rtError_t(int32_t *device));
    MOCK_METHOD1(rtSetTSDevice, rtError_t(uint32_t tsId));
    MOCK_METHOD2(rtStreamCreate, rtError_t(rtStream_t *stream, int32_t priority));
    MOCK_METHOD3(rtStreamCreateWithFlags, rtError_t(rtStream_t *stream, int32_t priority, uint32_t flags));
    MOCK_METHOD2(rtStreamSetMode, rtError_t(rtStream_t stream, const uint64_t mode));
    MOCK_METHOD1(rtStreamDestroy, rtError_t(rtStream_t stream));
    MOCK_METHOD1(rtStreamDestroyForce, rtError_t(rtStream_t stream));
    MOCK_METHOD1(rtStreamSynchronize, rtError_t(rtStream_t stream));
    MOCK_METHOD2(rtStreamSynchronizeWithTimeout, rtError_t(rtStream_t stream, const int32_t timeout));
    MOCK_METHOD1(rtStreamQuery, rtError_t(rtStream_t stream));
    MOCK_METHOD2(rtStreamGetPriority, rtError_t(rtStream_t stream, uint32_t *priority));
    MOCK_METHOD2(rtStreamGetFlags, rtError_t(rtStream_t stream, uint32_t *flags));
    MOCK_METHOD2(rtStreamWaitEvent, rtError_t(rtStream_t stream, rtEvent_t event));
    MOCK_METHOD3(rtStreamWaitEventWithTimeout, rtError_t(rtStream_t stream, rtEvent_t event, uint32_t timeout));
    MOCK_METHOD2(rtIpcGetEventHandle, rtError_t(rtEvent_t event, rtIpcEventHandle_t *handle));
    MOCK_METHOD2(rtIpcOpenEventHandle, rtError_t(rtIpcEventHandle_t handle, rtEvent_t *event));
    MOCK_METHOD1(rtCtxDestroyEx, rtError_t(rtContext_t ctx));
    MOCK_METHOD1(rtCtxSetCurrent, rtError_t(rtContext_t ctx));
    MOCK_METHOD0(rtCtxSynchronize, rtError_t());
    MOCK_METHOD1(rtCtxGetCurrent, rtError_t(rtContext_t *ctx));
    MOCK_METHOD2(rtGetPriCtxByDeviceId, rtError_t(int32_t device, rtContext_t *ctx));
    MOCK_METHOD2(rtEventCreateWithFlag, rtError_t(rtEvent_t *event_, uint32_t flag));
    MOCK_METHOD2(rtEventCreateExWithFlag, rtError_t(rtEvent_t *event_, uint32_t flag));
    MOCK_METHOD1(rtEventCreate, rtError_t(rtEvent_t *event));
    MOCK_METHOD2(rtGetEventID, rtError_t(rtEvent_t event, uint32_t *eventId));
    MOCK_METHOD1(rtEventDestroy, rtError_t(rtEvent_t event));
    MOCK_METHOD2(rtEventRecord, rtError_t(rtEvent_t event, rtStream_t stream));
    MOCK_METHOD2(rtEventReset, rtError_t(rtEvent_t event, rtStream_t stream));
    MOCK_METHOD1(rtEventSynchronize, rtError_t(rtEvent_t event));
    MOCK_METHOD2(rtEventSynchronizeWithTimeout, rtError_t(rtEvent_t event, const int32_t timeout));
    MOCK_METHOD1(rtEventQuery, rtError_t(rtEvent_t event));
    MOCK_METHOD2(rtEventQueryStatus, rtError_t(rtEvent_t event, rtEventStatus_t *status));
    MOCK_METHOD2(rtEventQueryWaitStatus, rtError_t(rtEvent_t event, rtEventWaitStatus *status));
    MOCK_METHOD2(rtNotifyCreate, rtError_t(int32_t device_id, rtNotify_t *notify_));
    MOCK_METHOD1(rtNotifyDestroy, rtError_t(rtNotify_t notify_));
    MOCK_METHOD2(rtNotifyRecord, rtError_t(rtNotify_t notify_, rtStream_t stream_));
    MOCK_METHOD2(rtGetNotifyID, rtError_t(rtNotify_t notify_, uint32_t *notify_id));
    MOCK_METHOD2(rtNotifyWait, rtError_t(rtNotify_t notify_, rtStream_t stream_));
    MOCK_METHOD4(rtMalloc, rtError_t(void **devPtr, uint64_t size, rtMemType_t type, uint16_t moduleId));
    MOCK_METHOD4(rtMallocCached, rtError_t(void **devPtr, uint64_t size, rtMemType_t type, uint16_t moduleId));
    MOCK_METHOD2(rtFlushCache, rtError_t(void *devPtr, size_t size));
    MOCK_METHOD2(rtInvalidCache, rtError_t(void *devPtr, size_t size));
    MOCK_METHOD1(rtFree, rtError_t(void *devPtr));
    MOCK_METHOD3(rtDvppMalloc, rtError_t(void **devPtr, uint64_t size, uint16_t moduleId));
    MOCK_METHOD4(rtDvppMallocWithFlag, rtError_t(void **devPtr, uint64_t size, uint32_t flag, uint16_t moduleId));
    MOCK_METHOD1(rtDvppFree, rtError_t(void *devPtr));
    MOCK_METHOD3(rtMallocHost, rtError_t(void **hostPtr, uint64_t size, uint16_t moduleId));
    MOCK_METHOD1(rtFreeHost, rtError_t(void *hostPtr));
    MOCK_METHOD1(rtFreeWithDevSync, rtError_t(void *devPtr));
    MOCK_METHOD1(rtFreeHostWithDevSync, rtError_t(void *hostPtr));
    MOCK_METHOD4(rtMemset, rtError_t(void *devPtr, uint64_t destMax, uint32_t value, uint64_t count));
    MOCK_METHOD5(rtMemcpy, rtError_t(void *dst, uint64_t destMax, const void *src, uint64_t count, rtMemcpyKind_t kind));
    MOCK_METHOD6(rtMemcpyAsync, rtError_t(void *dst, uint64_t destMax, const void *src, uint64_t count, rtMemcpyKind_t kind,
                                          rtStream_t stream));
    MOCK_METHOD7(rtMemcpyAsyncEx, rtError_t(void *dst, uint64_t destMax, const void *src, uint64_t count,
                                            rtMemcpyKind_t kind, rtStream_t stream, rtMemcpyConfig_t *memcpyConfig));
    MOCK_METHOD5(rtMemsetAsync, rtError_t(void *ptr, uint64_t destMax, uint32_t value, uint64_t count, rtStream_t stream));
    MOCK_METHOD7(rtCpuKernelLaunchWithFlag, rtError_t(const void *soName, const void *kernelName, uint32_t blockDim,
            const rtArgsEx_t *argsInfo, rtSmDesc_t *smDesc, rtStream_t stm, uint32_t flags));
    MOCK_METHOD3(rtMemGetInfoEx, rtError_t(rtMemInfoType_t memInfoType, size_t *free, size_t *total));
    MOCK_METHOD4(rtGetMemUsageInfo, rtError_t(uint32_t deviceId, rtMemUsageInfo_t *memUsageInfo, size_t inputNum, size_t *outputNum));
    MOCK_METHOD1(rtGetRunMode, rtError_t(rtRunMode *mode));
    MOCK_METHOD1(rtGetDeviceCount, rtError_t(int32_t *count));
    MOCK_METHOD3(rtEventElapsedTime, rtError_t(float *time, rtEvent_t start, rtEvent_t end));
    MOCK_METHOD1(rtDevBinaryUnRegister, rtError_t(void *handle));
    MOCK_METHOD2(rtDevBinaryRegister, rtError_t(const rtDevBinary_t *bin, void **handle));
    MOCK_METHOD5(rtFunctionRegister, rtError_t(void *binHandle, const void *stubFunc, const char *stubName,
                                               const void *devFunc, uint32_t funcMode));
    MOCK_METHOD6(rtKernelLaunch, rtError_t(const void *stubFunc, uint32_t blockDim, void *args, uint32_t argsSize,
                                           rtSmDesc_t *smDesc, rtStream_t stream));
    MOCK_METHOD2(rtGetSocVersion, rtError_t(char *version, const uint32_t maxLen));
    MOCK_METHOD1(rtGetGroupCount, rtError_t(uint32_t *count));
    MOCK_METHOD3(rtGetGroupInfo, rtError_t(int32_t groupid, rtGroupInfo_t *groupInfo, uint32_t count));
    MOCK_METHOD1(rtSetGroup, rtError_t(int32_t groupid));
    MOCK_METHOD2(rtGetDevicePhyIdByIndex, rtError_t(uint32_t devIndex, uint32_t *phyId));
    MOCK_METHOD3(rtEnableP2P, rtError_t(uint32_t devIdDes, uint32_t phyIdSrc, uint32_t flag));
    MOCK_METHOD2(rtDisableP2P, rtError_t(uint32_t devIdDes, uint32_t phyIdSrc));
    MOCK_METHOD3(rtDeviceCanAccessPeer, rtError_t(int32_t *canAccessPeer, uint32_t device, uint32_t peerDevice));
    MOCK_METHOD2(rtGetStreamId, rtError_t(rtStream_t stream_, int32_t *streamId));
    MOCK_METHOD2(rtRegDeviceStateCallback, rtError_t(const char *regName, rtDeviceStateCallback callback));
    MOCK_METHOD3(rtRegDeviceStateCallbackEx, rtError_t(const char *regName, rtDeviceStateCallback callback,
                                                       const rtDevCallBackDir_t notifyPos));
    MOCK_METHOD2(rtDeviceGetStreamPriorityRange, rtError_t(int32_t *leastPriority, int32_t *greatestPriority));
    MOCK_METHOD4(rtGetDeviceCapability, rtError_t(int32_t device, int32_t moduleType, int32_t featureType, int32_t *value));
    MOCK_METHOD1(rtSetOpWaitTimeOut, rtError_t(uint32_t timeout));
    MOCK_METHOD1(rtSetOpExecuteTimeOut, rtError_t(uint32_t timeout));
    MOCK_METHOD1(rtSetOpExecuteTimeOutWithMs, rtError_t(uint32_t timeout));
    MOCK_METHOD2(rtSetOpExecuteTimeOutV2, rtError_t(uint64_t timeout, uint64_t *actualTimeout));
    MOCK_METHOD1(rtGetOpTimeOutInterval, rtError_t(uint64_t *interval));
    MOCK_METHOD2(rtCtxSetSysParamOpt, rtError_t(const rtSysParamOpt configOpt, const int64_t configVal));
    MOCK_METHOD2(rtCtxGetSysParamOpt, rtError_t(const rtSysParamOpt configOpt, int64_t *const configVal));
    MOCK_METHOD2(rtSetSysParamOpt, rtError_t(const rtSysParamOpt configOpt, const int64_t configVal));
    MOCK_METHOD2(rtGetSysParamOpt, rtError_t(const rtSysParamOpt configOpt, int64_t *const configVal));
    MOCK_METHOD3(rtGetDeviceSatStatus, rtError_t(void *const outputAddrPtr, const uint64_t outputSize, rtStream_t stm));
    MOCK_METHOD1(rtCleanDeviceSatStatus, rtError_t(rtStream_t stm));

    MOCK_METHOD2(rtMemQueueInitQS, rtError_t(int32_t devId, const char *groupName));
    MOCK_METHOD3(rtMemQueueCreate, rtError_t(int32_t devId, const rtMemQueueAttr_t *queAttr, uint32_t *qid));
    MOCK_METHOD2(rtMemQueueDestroy, rtError_t(int32_t devId, uint32_t qid));
    MOCK_METHOD1(rtMemQueueInit, rtError_t(int32_t devId));
    MOCK_METHOD3(rtMemQueueEnQueue, rtError_t(int32_t devId, uint32_t qid, void *mbuf));
    MOCK_METHOD3(rtMemQueueDeQueue, rtError_t(int32_t devId, uint32_t qid, void **mbuf));
    MOCK_METHOD4(rtMemQueuePeek, rtError_t(int32_t devId, uint32_t qid, size_t *bufLen, int32_t timeout));
    MOCK_METHOD4(rtMemQueueEnQueueBuff, rtError_t(int32_t devId, uint32_t qid, rtMemQueueBuff_t *inBuf, int32_t timeout));
    MOCK_METHOD4(rtMemQueueDeQueueBuff, rtError_t(int32_t devId, uint32_t qid, rtMemQueueBuff_t *outBuf, int32_t timeout));
    MOCK_METHOD6(rtMemQueueQuery, rtError_t(int32_t devId, rtMemQueueQueryCmd_t cmd, void *inBuff, uint32_t inLen,
                                            void *outBuff, uint32_t *outLen));

    MOCK_METHOD3(rtMemQueueQueryInfo, rtError_t(int32_t device, uint32_t qid, rtMemQueueInfo_t *queueInfo));
    MOCK_METHOD4(rtMemQueueGrant, rtError_t(int32_t devId, uint32_t qid, int32_t pid, rtMemQueueShareAttr_t *attr));
    MOCK_METHOD3(rtMemQueueAttach, rtError_t(int32_t devId, uint32_t qid, int32_t timeout));
    MOCK_METHOD3(rtEschedSubmitEventSync, rtError_t(int32_t devId, rtEschedEventSummary_t *event, rtEschedEventReply_t *ack));
    MOCK_METHOD2(rtQueryDevPid, rtError_t(rtBindHostpidInfo_t *info, pid_t *devPid));
    MOCK_METHOD1(rtMbufInit, rtError_t(rtMemBuffCfg_t *cfg));
    MOCK_METHOD2(rtMbufAlloc, rtError_t(rtMbufPtr_t *mbuf, uint64_t size));
    MOCK_METHOD4(rtMbufAllocEx, rtError_t(rtMbufPtr_t *mbuf, uint64_t size, uint64_t flag, int32_t grpId));
    MOCK_METHOD2(rtMbufGetBuffAddr, rtError_t(rtMbufPtr_t mbuf, void **databuf));
    MOCK_METHOD2(rtMbufGetBuffSize, rtError_t(rtMbufPtr_t mbuf, uint64_t *size));
    MOCK_METHOD3(rtMbufGetPrivInfo, rtError_t(rtMbufPtr_t mbuf, void **priv, uint64_t *size));
    MOCK_METHOD2(rtMbufCopyBufRef, rtError_t(rtMbufPtr_t mbuf, rtMbufPtr_t *newMbuf));
    MOCK_METHOD2(rtMemGrpCreate, rtError_t(const char *name, const rtMemGrpConfig_t *cfg));
    MOCK_METHOD3(rtMemGrpAddProc, rtError_t(const char *name, int32_t pid, const rtMemGrpShareAttr_t *attr));
    MOCK_METHOD2(rtMemGrpAttach, rtError_t(const char *name, int32_t timeout));
    MOCK_METHOD2(rtMemGrpQuery, rtError_t(rtMemGrpQueryInput_t * const input, rtMemGrpQueryOutput_t *output));
    MOCK_METHOD7(rtMemcpy2d, rtError_t(void *dst, uint64_t dpitch, const void *src, uint64_t spitch, uint64_t width,
                                       uint64_t height, rtMemcpyKind_t kind));
    MOCK_METHOD8(rtMemcpy2dAsync, rtError_t(void *dst, uint64_t dpitch, const void *src, uint64_t spitch,
                                            uint64_t width, uint64_t height, rtMemcpyKind_t kind, rtStream_t stream));
    MOCK_METHOD2(rtGetDevMsg, rtError_t(rtGetDevMsgType_t getMsgType, rtGetMsgCallback callback));
    MOCK_METHOD5(rtGetFaultEvent, rtError_t (const int32_t deviceId, rtDmsEventFilter *filter,
                                            rtDmsFaultEvent *dmsEvent, uint32_t len, uint32_t *eventCount));
    MOCK_METHOD1(rtSetDeviceSatMode, rtError_t(rtFloatOverflowMode_t floatOverflowMode));
    MOCK_METHOD1(rtGetDeviceSatMode, rtError_t(rtFloatOverflowMode_t *floatOverflowMode));
    MOCK_METHOD2(rtSetStreamOverflowSwitch, rtError_t(rtStream_t stm, uint32_t flags));
    MOCK_METHOD2(rtGetStreamOverflowSwitch, rtError_t(rtStream_t stm, uint32_t *flags));
    MOCK_METHOD1(rtGetAiCoreCount, rtError_t(uint32_t *aiCoreCnt));
    MOCK_METHOD4(rtGetDeviceInfo, rtError_t(uint32_t deviceId, int32_t moduleType, int32_t infoType, int64_t *val));
    MOCK_METHOD3(rtGetAllUtilizations, rtError_t(const int32_t devId, const rtTypeUtil_t kind, uint8_t *const util));
    MOCK_METHOD2(rtDeviceStatusQuery, rtError_t(const uint32_t devId, rtDeviceStatus *deviceStatus));

    MOCK_METHOD2(rtMemRetainAllocationHandle, rtError_t(void* virPtr, rtDrvMemHandle *handle));
    MOCK_METHOD2(rtMemGetAllocationPropertiesFromHandle, rtError_t(rtDrvMemHandle handle, rtDrvMemProp_t* prop));
    MOCK_METHOD5(rtReserveMemAddress, rtError_t(void **devPtr, size_t size, size_t alignment, void *devAddr, uint64_t flags));
    MOCK_METHOD1(rtReleaseMemAddress, rtError_t(void *devPtr));
    MOCK_METHOD4(rtMallocPhysical, rtError_t(rtDrvMemHandle *handle, size_t size, rtDrvMemProp_t *prop, uint64_t flags));
    MOCK_METHOD1(rtFreePhysical, rtError_t(rtDrvMemHandle handle));
    MOCK_METHOD5(rtMapMem, rtError_t(void *devPtr, size_t size, size_t offset, rtDrvMemHandle handle, uint64_t flags));
    MOCK_METHOD1(rtUnmapMem, rtError_t(void *devPtr));

    MOCK_METHOD3(rtBinaryLoadWithoutTilingKey, rtError_t(const void *data, const uint64_t length, rtBinHandle *binHandle));
    MOCK_METHOD1(rtBinaryUnLoad, rtError_t(rtBinHandle binHandle));
    MOCK_METHOD3(rtsFuncGetByName, rtError_t(const rtBinHandle binHandle, const char_t *kernelName,
                                             rtFuncHandle *funcHandle));
    MOCK_METHOD5(rtCreateLaunchArgs, rtError_t(size_t argsSize, size_t hostInfoTotalSize, size_t hostInfoNum,
                                               void *argsData, rtLaunchArgsHandle *argsHandle));
    MOCK_METHOD1(rtDestroyLaunchArgs, rtError_t(rtLaunchArgsHandle argsHandle));
    MOCK_METHOD5(rtLaunchKernelByFuncHandleV3, rtError_t(rtFuncHandle funcHandle, uint32_t blockDim,
                                                         const rtArgsEx_t *const argsInfo, rtStream_t stm,
                                                         const rtTaskCfgInfo_t *const cfgInfo));
    MOCK_METHOD4(rtMemExportToShareableHandle, rtError_t(rtDrvMemHandle handle, rtDrvMemHandleType handleType,
            uint64_t flag, uint64_t * shareableHandle));
    MOCK_METHOD4(rtsMemExportToShareableHandle, rtError_t(rtDrvMemHandle handle, rtDrvMemHandleType handleType,
        uint64_t flag, uint64_t * shareableHandle));
    MOCK_METHOD4(rtMemExportToShareableHandleV2, rtError_t(rtDrvMemHandle handle, rtMemSharedHandleType handleType,
        uint64_t flags, void *shareableHandle));
    MOCK_METHOD3(rtMemImportFromShareableHandle, rtError_t(uint64_t shareableHandle, int32_t deviceId,
            rtDrvMemHandle *handle));
    MOCK_METHOD3(rtsMemImportFromShareableHandle, rtError_t(uint64_t shareableHandle, int32_t deviceId,
        rtDrvMemHandle *handle));
    MOCK_METHOD5(rtMemImportFromShareableHandleV2, rtError_t(const void *shareableHandle, rtMemSharedHandleType handleType,
        uint64_t flags, int32_t devId, rtDrvMemHandle *handle));
    MOCK_METHOD3(rtMemSetPidToShareableHandle, rtError_t(uint64_t shareableHandle, int pid[], uint32_t pidNum));
    MOCK_METHOD3(rtsMemSetPidToShareableHandle, rtError_t(uint64_t shareableHandle, int pid[], uint32_t pidNum));
    MOCK_METHOD4(rtMemSetPidToShareableHandleV2, rtError_t(const void *shareableHandle, rtMemSharedHandleType handleType, int pid[], 
        uint32_t pidNum));
    MOCK_METHOD3(rtMemGetAllocationGranularity, rtError_t(rtDrvMemProp_t * prop,
            rtDrvMemGranularityOptions option, size_t * granularity));
    MOCK_METHOD1(rtDeviceGetBareTgid, rtError_t(uint32_t * pid));
    MOCK_METHOD2(rtGetL2CacheOffset, rtError_t(uint32_t deivceId, uint64_t *offset));
    MOCK_METHOD2(rtRegKernelLaunchFillFunc, rtError_t(const char *symbol, rtKernelLaunchFillFunc func));
    MOCK_METHOD1(rtUnRegKernelLaunchFillFunc, rtError_t(const char *symbol));
    MOCK_METHOD2(rtGetMemUceInfo, rtError_t(const uint32_t, rtMemUceInfo *));
    MOCK_METHOD2(rtMemUceRepair, rtError_t(const uint32_t, rtMemUceInfo *));
    MOCK_METHOD2(rtDeviceTaskAbort, rtError_t(int32_t, uint32_t));
    MOCK_METHOD2(rtMemQueueReset, rtError_t(int32_t, uint32_t));
    MOCK_METHOD2(rtRegStreamStateCallback, rtError_t(const char *regName, rtStreamStateCallback callback));
    MOCK_METHOD1(rtCtxGetCurrentDefaultStream, rtError_t(rtStream_t* stm));
    MOCK_METHOD4(rtCmoAsync, rtError_t(void *srcAddrPtr, size_t srcLen, rtCmoOpCode_t cmpType, rtStream_t stm));
    MOCK_METHOD4(rtsCmoAsync, rtError_t(void *srcAddrPtr, size_t srcLen, rtCmoOpCode_t cmoType, rtStream_t stm));
    MOCK_METHOD1(rtStreamAbort, rtError_t(rtStream_t stm));
    MOCK_METHOD2(rtStreamBeginCapture, rtError_t(rtStream_t stm, const rtStreamCaptureMode mode));
    MOCK_METHOD3(rtStreamGetCaptureInfo, rtError_t(rtStream_t stm, rtStreamCaptureStatus *const status,
                                                   rtModel_t *captureMdl));
    MOCK_METHOD2(rtStreamEndCapture, rtError_t(rtStream_t stm, rtModel_t *captureMdl));
    MOCK_METHOD2(rtCacheLastTaskOpInfo, rtError_t(const void * const infoPtr, const size_t infoSize));
    MOCK_METHOD3(rtFunctionGetAttribute, rtError_t(rtFuncHandle funcHandle, rtFuncAttribute attrType, int64_t *attrValue));
    MOCK_METHOD1(rtModelDebugDotPrint, rtError_t(rtModel_t mdl));
    MOCK_METHOD3(rtModelDebugJsonPrint, rtError_t(rtModel_t mdl, const char *path, uint32_t flags));
    MOCK_METHOD1(rtThreadExchangeCaptureMode, rtError_t(rtStreamCaptureMode *mode));
    MOCK_METHOD3(rtModelExecute, rtError_t(rtModel_t mdl, rtStream_t stm, uint32_t flag));
    MOCK_METHOD1(rtModelDestroy, rtError_t(rtModel_t mdl));
    MOCK_METHOD1(rtsStreamBeginTaskGrp, rtError_t(rtStream_t stm));
    MOCK_METHOD2(rtsStreamEndTaskGrp, rtError_t(rtStream_t stm, rtTaskGrp_t *handle));
    MOCK_METHOD2(rtsStreamBeginTaskUpdate, rtError_t(rtStream_t stm, rtTaskGrp_t handle));
    MOCK_METHOD1(rtsStreamEndTaskUpdate, rtError_t(rtStream_t stm));

    MOCK_METHOD4(rtsMemcpyAsyncWithDesc, rtError_t(rtMemcpyDesc_t desc, rtMemcpyKind kind, rtMemcpyConfig_t *config,
                                                   rtStream_t stream));
    MOCK_METHOD8(rtMemcpyAsyncWithOffset, rtError_t((void **dst, uint64_t dstMax, uint64_t dstDataOffset, const void **src,
                                                          uint64_t count, uint64_t srcDataOffset, rtMemcpyKind kind, rtStream_t stream)));                                               
    MOCK_METHOD2(rtsGetMemcpyDescSize, rtError_t(rtMemcpyKind kind, size_t *size));
    MOCK_METHOD6(rtsSetMemcpyDesc, rtError_t(rtMemcpyDesc_t desc, rtMemcpyKind kind, void *srcAddr,
                                             void *dstAddr, size_t count, rtMemcpyConfig_t *config));
    MOCK_METHOD3(rtsBinaryLoadFromFile, rtError_t(const char * const binPath,
                                                  const rtLoadBinaryConfig_t * const optionalCfg, rtBinHandle *handle));
    MOCK_METHOD3(rtsBinaryGetDevAddress, rtError_t(const rtBinHandle binHandle, void **bin, uint32_t *binSize));
    MOCK_METHOD3(rtsFuncGetByEntry, rtError_t(const rtBinHandle binHandle, const uint64_t funcEntry,
                                              rtFuncHandle *funcHandle));
    MOCK_METHOD3(rtsFuncGetAddr, rtError_t(const rtFuncHandle funcHandle, void **aicAddr, void **aivAddr));
    MOCK_METHOD6(rtsLaunchKernelWithConfig, rtError_t(rtFuncHandle funcHandle, uint32_t blockDim, rtStream_t stm,
                                                      rtKernelLaunchCfg_t *cfg, rtArgsHandle argsHandle,
                                                      void* reserve));
    MOCK_METHOD2(rtsKernelArgsInit, rtError_t(rtFuncHandle funcHandle, rtArgsHandle *handle));
    MOCK_METHOD1(rtsKernelArgsFinalize, rtError_t(rtArgsHandle argsHandle));
    MOCK_METHOD4(rtsKernelArgsAppend, rtError_t(rtArgsHandle handle, void *para, size_t paraSize,
                                                rtParaHandle *paraHandle));
    MOCK_METHOD2(rtsKernelArgsAppendPlaceHolder, rtError_t(rtArgsHandle handle, rtParaHandle *paraHandle));
    MOCK_METHOD4(rtsKernelArgsParaUpdate, rtError_t(rtArgsHandle argsHandle, rtParaHandle paraHandle, void *para,
                                                    size_t paraSize));
    MOCK_METHOD4(rtsKernelArgsInitByUserMem, rtError_t(rtFuncHandle funcHandle, rtArgsHandle argsHandle,
                                                       void *userHostMem, size_t actualArgsSize));
    MOCK_METHOD3(rtsKernelArgsGetMemSize, rtError_t(rtFuncHandle funcHandle, size_t userArgsSize,
                                                    size_t *actualArgsSize));
    MOCK_METHOD2(rtsKernelArgsGetHandleMemSize, rtError_t(rtFuncHandle funcHandle, size_t *memSize));
    MOCK_METHOD4(rtsKernelArgsGetPlaceHolderBuffer, rtError_t(rtArgsHandle argsHandle, rtParaHandle paraHandle,
                                                              uint32_t dataSize, void **bufferAddr));
    MOCK_METHOD5(rtsMalloc, rtError_t(void **devPtr, uint64_t size, rtMallocPolicy policy, rtMallocAdvise advise, rtMallocConfig_t *cfg));
    MOCK_METHOD3(rtsMallocHost, rtError_t(void **hostPtr, uint64_t size, const rtMallocConfig_t *cfg));

    MOCK_METHOD2(rtsPointerGetAttributes, rtError_t(const void *ptr, rtPtrAttributes_t *attributes));
    MOCK_METHOD4(rtsHostRegister, rtError_t(void *ptr, uint64_t size, rtHostRegisterType type, void **devPtr));
    MOCK_METHOD3(rtHostRegisterV2, rtError_t(void *ptr, uint64_t size, uint32_t flag));
    MOCK_METHOD3(rtHostGetDevicePointer, rtError_t(void *pHost, void **pDevice, uint32_t flag));
    MOCK_METHOD1(rtsHostUnregister, rtError_t(void *ptr));
    MOCK_METHOD1(rtsGetThreadLastTaskId, rtError_t(uint32_t *taskId));
    MOCK_METHOD2(rtsStreamGetId, rtError_t(rtStream_t stm, int32_t *streamId));

    MOCK_METHOD4(rtsValueWrite, rtError_t(const void * const devAddr, const uint64_t value, const uint32_t flag, rtStream_t stm));
    MOCK_METHOD4(rtsValueWait, rtError_t(const void * const devAddr, const uint64_t value, const uint32_t flag, rtStream_t stm));

    MOCK_METHOD1(rtsStreamGetAvailableNum, rtError_t(uint32_t *streamCount));
    MOCK_METHOD3(rtsStreamSetAttribute, rtError_t(rtStream_t stm, rtStreamAttr stmAttrId, rtStreamAttrValue_t *attrValue));
    MOCK_METHOD3(rtsStreamGetAttribute, rtError_t(rtStream_t stm, rtStreamAttr stmAttrId, rtStreamAttrValue_t *attrValue));

    MOCK_METHOD2(rtsNotifyCreate, rtError_t(rtNotify_t *notify, uint64_t flag));
    MOCK_METHOD1(rtsNotifyDestroy, rtError_t(rtNotify_t notify));
    MOCK_METHOD2(rtsNotifyRecord, rtError_t(rtNotify_t notify, rtStream_t stream));
    MOCK_METHOD3(rtsNotifyWaitAndReset, rtError_t(rtNotify_t notify, rtStream_t stream, uint32_t timeout));
    MOCK_METHOD2(rtsNotifyGetId, rtError_t(rtNotify_t notify, uint32_t *notifyId));

    MOCK_METHOD2(rtCntNotifyCreateServer, rtError_t(rtCntNotify_t *cntNotify, uint64_t flag));
    MOCK_METHOD1(rtCntNotifyDestroy, rtError_t(rtCntNotify_t cntNotify));

    MOCK_METHOD2(rtsEventGetId, rtError_t(rtEvent_t event, uint32_t *eventId));
    MOCK_METHOD1(rtsEventGetAvailNum, rtError_t(uint32_t *eventCount));
    MOCK_METHOD3(rtsEventWait, rtError_t(rtStream_t stream, rtEvent_t event, uint32_t timeout));

    MOCK_METHOD3(rtsDeviceGetInfo, rtError_t(uint32_t deviceId, rtDevAttr attr, int64_t *val));
    MOCK_METHOD2(rtsDeviceGetStreamPriorityRange, rtError_t(int32_t *leastPriority, int32_t *greatestPriority));
    MOCK_METHOD3(rtsDeviceGetCapability, rtError_t(int32_t deviceId, int32_t devFeatureType, int32_t *val));
    MOCK_METHOD2(rtGetDeviceUuid, rtError_t(int32_t deviceId, rtUuid_t *uuid));

    MOCK_METHOD1(rtsCtxGetCurrentDefaultStream, rtError_t(rtStream_t *stm));
    MOCK_METHOD3(rtsGetPrimaryCtxState, rtError_t(const int32_t devId, uint32_t *flags, int32_t *active));

    MOCK_METHOD2(rtsModelCreate, rtError_t(rtModel_t *mdl, uint32_t flag));
    MOCK_METHOD3(rtsModelBindStream, rtError_t(rtModel_t mdl, rtStream_t stm, uint32_t flag));
    MOCK_METHOD2(rtsEndGraph, rtError_t(rtModel_t mdl, rtStream_t stm));
    MOCK_METHOD2(rtsModelLoadComplete, rtError_t(rtModel_t mdl, void *reserve));
    MOCK_METHOD2(rtsModelUnbindStream, rtError_t(rtModel_t mdl, rtStream_t stm));
    MOCK_METHOD2(rtsModelExecute, rtError_t(rtModel_t mdl, int32_t timeout));

    MOCK_METHOD3(rtsLaunchReduceAsyncTask, rtError_t(const rtReduceInfo_t *reduceInfo, const rtStream_t stm, const void *reserve));

    MOCK_METHOD3(rtsGetDeviceResLimit, rtError_t(const int32_t deviceId, const rtDevResLimitType_t type, uint32_t *value));
    MOCK_METHOD3(rtsSetDeviceResLimit, rtError_t(const int32_t deviceId, const rtDevResLimitType_t type, uint32_t value));
    MOCK_METHOD1(rtsResetDeviceResLimit, rtError_t(const int32_t deviceId));

    MOCK_METHOD3(rtsGetStreamResLimit, rtError_t(rtStream_t stream, const rtDevResLimitType_t type, uint32_t *value));
    MOCK_METHOD3(rtsSetStreamResLimit, rtError_t(rtStream_t stream, const rtDevResLimitType_t type, uint32_t value));
    MOCK_METHOD1(rtsResetStreamResLimit, rtError_t(rtStream_t stream));
    MOCK_METHOD1(rtsUseStreamResInCurrentThread, rtError_t(rtStream_t stream));
    MOCK_METHOD1(rtsNotUseStreamResInCurrentThread, rtError_t(rtStream_t stream));
    MOCK_METHOD2(rtsGetResInCurrentThread, rtError_t(const rtDevResLimitType_t type, uint32_t *value));

    MOCK_METHOD1(rtsLabelCreate, rtError_t(rtLabel_t *lbl));
    MOCK_METHOD2(rtsLabelSet, rtError_t(rtLabel_t lbl, rtStream_t stm));
    MOCK_METHOD1(rtsLabelDestroy, rtError_t(rtLabel_t lbl));
    MOCK_METHOD3(rtsLabelSwitchListCreate, rtError_t(rtLabel_t *labels, size_t num, void **labelList));
    MOCK_METHOD1(rtsLabelSwitchListDestroy, rtError_t(void *labelList));
    MOCK_METHOD4(rtsLabelSwitchByIndex, rtError_t(void *ptr, uint32_t maxValue, void *labelInfoPtr, rtStream_t stm));

    MOCK_METHOD2(rtsActiveStream, rtError_t(rtStream_t activeStream, rtStream_t stream));
    MOCK_METHOD7(rtsSwitchStream, rtError_t(void *leftValue, rtCondition_t cond, void *rightValue, rtSwitchDataType_t dataType, rtStream_t trueStream, rtStream_t falseStream, rtStream_t stream));
    MOCK_METHOD3(rtsFuncGetName, rtError_t(const rtFuncHandle funcHandle, const uint32_t maxLen, char_t * const name));
    MOCK_METHOD2(rtsModelSetName, rtError_t(rtModel_t mdl, const char_t *mdlName));
    MOCK_METHOD3(rtsModelGetName, rtError_t(rtModel_t mdl, const uint32_t maxLen, char_t * const mdlName));

    MOCK_METHOD4(rtsBinaryLoadFromData, rtError_t(const void *const data, const uint64_t length, const rtLoadBinaryConfig_t *const optionalCfg, rtBinHandle *handle));
    MOCK_METHOD4(rtsRegisterCpuFunc, rtError_t(rtBinHandle binHandle, const char_t *const funcName, const char_t *const kernelName, rtFuncHandle *funcHandle));
    MOCK_METHOD5(rtsCmoAsyncWithBarrier, rtError_t(void *srcAddrPtr, size_t srcLen, rtCmoOpCode cmoType, uint32_t logicId, rtStream_t stm));
    MOCK_METHOD3(rtsLaunchBarrierTask, rtError_t(rtBarrierTaskInfo_t *taskInfo, rtStream_t stm, uint32_t flag));
    MOCK_METHOD4(rtsGetPairDevicesInfo, rtError_t(uint32_t devId, uint32_t otherDevId, int32_t infoType, uint64_t *val));

    MOCK_METHOD8(rtsMemcpyBatch, rtError_t(void **dsts, void **srcs, size_t *sizes, size_t count, rtMemcpyBatchAttr *attrs, size_t *attrsIdxs, size_t numAttrs, size_t *failIdx));
    MOCK_METHOD10(rtsMemcpyBatchAsync, rtError_t(void **dsts, size_t *destMaxs, void **srcs, size_t *sizes, size_t count,
        rtMemcpyBatchAttr *attrs, size_t *attrsIdxs, size_t numAttrs, size_t *failIdx, rtStream_t stream));

    MOCK_METHOD5(rtsIpcMemGetExportKey, rtError_t(const void *ptr, size_t size, char_t *key, uint32_t len, uint64_t flags));
    MOCK_METHOD1(rtsIpcMemClose, rtError_t(const char_t *key));
    MOCK_METHOD3(rtsIpcMemImportByKey, rtError_t(void **ptr, const char_t *key, uint64_t flags));
    MOCK_METHOD3(rtsIpcMemSetImportPid, rtError_t(const char_t *key, int32_t pid[], int num));
    MOCK_METHOD3(rtIpcSetMemoryAttr, rtError_t(const char *key, uint32_t type, uint64_t attr));
    MOCK_METHOD3(rtIpcMemImportPidInterServer, rtError_t(const char *key, const rtServerPid *serverPids, size_t num));
    MOCK_METHOD4(rtMemSetAccess, rtError_t(void *virPtr, size_t size, rtMemAccessDesc *desc, size_t count));
    MOCK_METHOD3(rtMemGetAccess, rtError_t(void *virPtr, rtMemLocation *location, uint64_t *flag));

    MOCK_METHOD2(rtsNotifyBatchReset, rtError_t(rtNotify_t *notifies, uint32_t num));
    MOCK_METHOD4(rtsNotifyGetExportKey, rtError_t(rtNotify_t notify, char_t *key, uint32_t len, uint64_t flags));
    MOCK_METHOD3(rtsNotifyImportByKey, rtError_t(rtNotify_t *notify, const char_t *key, uint64_t flags));
    MOCK_METHOD3(rtsNotifySetImportPid, rtError_t(rtNotify_t notify, int32_t pid[], int num));
    MOCK_METHOD3(rtNotifySetImportPidInterServer, rtError_t(rtNotify_t notify, const rtServerPid *serverPids, size_t num));
    MOCK_METHOD5(rtsCheckMemType, rtError_t(void** addrList, uint32_t size, uint32_t memType, uint32_t *checkResult, uint32_t reserve));
    MOCK_METHOD2(rtsGetLogicDevIdByUserDevId, rtError_t(const int32_t userDevid, int32_t *const logicDevId));
    MOCK_METHOD2(rtsGetUserDevIdByLogicDevId, rtError_t(const int32_t logicDevId, int32_t *const userDevid));
    MOCK_METHOD2(rtsGetLogicDevIdByPhyDevId, rtError_t(int32_t phyDevId, int32_t *const logicDevId));
    MOCK_METHOD2(rtsGetPhyDevIdByLogicDevId, rtError_t(int32_t logicDevId, int32_t *const phyDevId));

    MOCK_METHOD3(rtsProfTrace, rtError_t(void *userdata, int32_t length, rtStream_t stream));
    MOCK_METHOD7(rtsLaunchKernelWithDevArgs, rtError_t(rtFuncHandle funcHandle, uint32_t blockDim,
                                              rtStream_t stm, rtKernelLaunchCfg_t *cfg,
                                              const void *args, uint32_t argsSize, void *reserve));
    MOCK_METHOD8(rtsLaunchKernelWithHostArgs, rtError_t(rtFuncHandle funcHandle, uint32_t blockDim, rtStream_t stm,
                                                        rtKernelLaunchCfg_t *cfg, void *hostArgs, uint32_t argsSize,
                                                        rtPlaceHolderInfo_t *placeHolderArray, uint32_t placeHolderNum));
    MOCK_METHOD3(rtsGetFloatOverflowStatus, rtError_t(void *const outputAddr, const uint64_t outputSize, rtStream_t stm));
    MOCK_METHOD1(rtsResetFloatOverflowStatus, rtError_t(rtStream_t stm));
    MOCK_METHOD4(rtsNpuGetFloatOverFlowStatus, rtError_t(void *const outputAddr, const uint64_t outputSize, uint32_t checkMode, rtStream_t stm));
    MOCK_METHOD2(rtsNpuClearFloatOverFlowStatus, rtError_t(uint32_t checkMode, rtStream_t stm));
    MOCK_METHOD1(rtsCtxGetFloatOverflowAddr, rtError_t(void **overflowAddr));
    
    MOCK_METHOD1(rtsGetHardwareSyncAddr, rtError_t(void **addr));
    MOCK_METHOD3(rtsLaunchRandomNumTask, rtError_t(const rtRandomNumTaskInfo_t *taskInfo, const rtStream_t stream, void *reserve));
    MOCK_METHOD3(rtsRegStreamStateCallback, rtError_t(const char_t *regName, rtsStreamStateCallback callback, void *args));
    MOCK_METHOD3(rtsRegDeviceStateCallback, rtError_t(const char_t *regName, rtsDeviceStateCallback callback, void *args));
    MOCK_METHOD3(rtsSetDeviceTaskAbortCallback, rtError_t(const char_t *regName, rtsDeviceTaskAbortCallback callback, void *args));
    MOCK_METHOD1(rtGetOpExecuteTimeoutV2, rtError_t(uint32_t * const timeoutMs));
    MOCK_METHOD3(rtsGetP2PStatus, rtError_t(uint32_t devIdDes, uint32_t phyIdSrc, uint32_t *status));
    MOCK_METHOD1(rtsStreamStop, rtError_t(rtStream_t stream));
    MOCK_METHOD4(rtsLaunchUpdateTask, rtError_t(rtStream_t taskStream, uint32_t taskId, rtStream_t execStream, rtTaskUpdateCfg_t *info));
    MOCK_METHOD1(rtsGetCmoDescSize, rtError_t(size_t *size));
    MOCK_METHOD3(rtsSetCmoDesc, rtError_t(rtCmoDesc_t cmoDesc, void *memAddr, size_t memLen));
    MOCK_METHOD4(rtsLaunchCmoAddrTask, rtError_t(rtCmoDesc_t cmoDesc, rtStream_t stream, rtCmoOpCode cmoType, const void *reserve));
    MOCK_METHOD1(rtsModelAbort, rtError_t(rtModel_t modelRI));
    MOCK_METHOD2(rtCheckArchCompatibility, rtError_t(const char_t *socVersion, int32_t *canCompatible));

    MOCK_METHOD3(rtsCntNotifyRecord, rtError_t(rtCntNotify_t cntNotify, rtStream_t stream, rtCntNotifyRecordInfo_t *info));
    MOCK_METHOD3(rtsCntNotifyWaitWithTimeout, rtError_t(rtCntNotify_t cntNotify, rtStream_t stream, rtCntNotifyWaitInfo_t *info));
    MOCK_METHOD2(rtsCntNotifyReset, rtError_t(rtCntNotify_t cntNotify, rtStream_t stream));
    MOCK_METHOD2(rtsCntNotifyGetId, rtError_t(rtCntNotify_t cntNotify, uint32_t *notifyId));

    MOCK_METHOD1(rtsPersistentTaskClean, rtError_t(rtStream_t stream));

    // geterror function stub
    MOCK_METHOD2(rtsGetErrorVerbose, rtError_t(uint32_t deviceId, rtErrorInfo* errorInfo));
    MOCK_METHOD2(rtsRepairError, rtError_t(uint32_t deviceId, const rtErrorInfo* errorInfo));
    MOCK_METHOD0(rtSnapShotProcessLock, rtError_t());
    MOCK_METHOD0(rtSnapShotProcessUnlock, rtError_t());
    MOCK_METHOD0(rtSnapShotProcessBackup, rtError_t());
    MOCK_METHOD0(rtSnapShotProcessRestore, rtError_t());

    // prof function stub
    MOCK_METHOD0(MsprofFinalize, int32_t());
    MOCK_METHOD3(MsprofInit, int32_t(uint32_t aclDataType, void *data, uint32_t dataLen));
    MOCK_METHOD3(MsprofRegTypeInfo, int32_t(uint16_t level, uint32_t typeId, const char *typeName));

    // adx function stub
    MOCK_METHOD0(AdxDataDumpServerInit, int());
    MOCK_METHOD0(AdxDataDumpServerUnInit, int());
    MOCK_METHOD2(AdumpSetDump, int32_t(const char *dumpConfigData, size_t dumpConfigSize));
    MOCK_METHOD0(AdumpUnSetDump, int32_t());

    // slog function stub
    MOCK_METHOD2(dlog_getlevel, int(int module_id, int *enable_event));

    // mmpa function stub
    MOCK_METHOD2(mmAlignMalloc, void *(mmSize mallocSize, mmSize alignSize));
    MOCK_METHOD2(mmAccess2, INT32(const CHAR *pathName, INT32 mode));
    MOCK_METHOD2(mmDladdr, INT32(VOID *addr, mmDlInfo *info));

};
