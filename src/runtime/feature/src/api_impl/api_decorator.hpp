/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_API_DECORATOR_HPP
#define CCE_RUNTIME_API_DECORATOR_HPP

#include "api.hpp"

namespace cce {
namespace runtime {
class ApiDecorator : public Api {
public:
    explicit ApiDecorator(Api * const inImpl);
    ~ApiDecorator() override
    {
        impl_ = nullptr;
        return;
    }

    // kernel API
    rtError_t DevBinaryRegister(const rtDevBinary_t * const bin, Program ** const prog) override;
    rtError_t GetNotifyAddress(Notify * const notify, uint64_t * const notifyAddress) override;
    rtError_t RegisterAllKernel(const rtDevBinary_t * const bin, Program ** const prog) override;
    rtError_t BinaryRegisterToFastMemory(Program * const prog) override;
    rtError_t DevBinaryUnRegister(Program * const prog) override;
    rtError_t BinaryLoad(const rtDevBinary_t * const bin, Program ** const prog) override;
    rtError_t BinaryGetFunction(const Program * const prog, const uint64_t tilingKey,
                                Kernel ** const funcHandle) override;
    rtError_t BinaryLoadWithoutTilingKey(const void *data, const uint64_t length, Program ** const prog) override;
    rtError_t BinaryGetFunctionByName(const Program * const binHandle, const char_t *kernelName,
                                      Kernel ** const funcHandle) override;
    rtError_t BinaryGetFunctionByEntry(const Program * const binHandle, const uint64_t funcEntry,
                                       Kernel ** const funcHandle) override;
    rtError_t BinaryGetMetaInfo(Program * const binHandle, const rtBinaryMetaType type,
                                void *data, const uint32_t length) override;
    rtError_t FunctionGetMetaInfo(const Kernel * const funcHandle, const rtFunctionMetaType type,
                                  void *data, const uint32_t length) override;
    rtError_t RegisterCpuFunc(rtBinHandle binHandle, const char_t * const funcName,
        const char_t * const kernelName, rtFuncHandle *funcHandle) override;
    rtError_t BinaryUnLoad(Program * const binHandle) override;
    rtError_t BinaryLoadFromFile(const char_t * const binPath, const rtLoadBinaryConfig_t * const optionalCfg,
                                 Program **handle) override;
    rtError_t BinaryLoadFromData(const void * const data, const uint64_t length,
                                 const rtLoadBinaryConfig_t * const optionalCfg, Program **handle) override;
    rtError_t FuncGetAddr(const Kernel * const funcHandle, void ** const aicAddr, void ** const aivAddr) override;
    rtError_t FuncGetName(const Kernel * const kernel, const uint32_t maxLen, char_t * const name) override;
    rtError_t LaunchKernel(Kernel * const kernel, const uint32_t blockDim, const rtArgsEx_t * const argsInfo,
                           Stream * const stm, const rtTaskCfgInfo_t *const cfgInfo = nullptr) override;
    rtError_t LaunchKernelV2(Kernel * const kernel, uint32_t blockDim, const RtArgsWithType * const argsWithType,
                         Stream * const stm, const rtKernelLaunchCfg_t * const cfg  = nullptr) override;
    rtError_t LaunchKernelV3(Kernel * const kernel, const rtArgsEx_t * const argsInfo,
                             Stream * const stm, const rtLaunchConfig_t * const launchConfig) override; 
    rtError_t MetadataRegister(Program * const prog, const char_t * const metadata) override;
    rtError_t DependencyRegister(Program * const mProgram, Program * const sProgram) override;
    rtError_t FunctionRegister(Program * const prog, const void * const stubFunc, const char_t * const stubName,
        const void * const kernelInfoExt, const uint32_t funcMode) override;
    rtError_t GetFunctionByName(const char_t * const stubName, void ** const stubFunc) override;
    rtError_t GetAddrByFun(const void * const stubFunc, void ** const addr) override;
    rtError_t GetAddrAndPrefCntWithHandle(void * const hdl, const void * const kernelInfoExt,
                                          void ** const addr, uint32_t * const prefetchCnt) override;
    rtError_t KernelGetAddrAndPrefCnt(void * const hdl, const uint64_t tilingKey,
        const void * const stubFunc, const uint32_t flag, void ** const addr, uint32_t * const prefetchCnt) override;
    rtError_t KernelGetAddrAndPrefCntV2(void * const hdl, const uint64_t tilingKey,
        const void * const stubFunc, const uint32_t flag, rtKernelDetailInfo_t * const kernelInfo) override;
    rtError_t QueryFunctionRegistered(const char_t * const stubName) override;
    rtError_t KernelLaunch(const void * const stubFunc, const uint32_t coreDim,
        const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm,
        const uint32_t flag, const rtTaskCfgInfo_t *const cfgInfo = nullptr, const bool isLaunchVec = false) override;
    rtError_t KernelLaunchWithHandle(void * const hdl, const uint64_t tilingKey, const uint32_t coreDim,
        const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm,
        const rtTaskCfgInfo_t * const cfgInfo = nullptr, const bool isLaunchVec = false) override;
    rtError_t KernelLaunchEx(const char_t * const opName, const void * const args, const uint32_t argsSize,
        const uint32_t flags, Stream * const stm) override;
    rtError_t CpuKernelLaunch(const rtKernelLaunchNames_t * const launchNames, const uint32_t coreDim,
        const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm,
        const uint32_t flag) override;
    rtError_t CpuKernelLaunchExWithArgs(const char_t * const opName, const uint32_t coreDim,
        const rtAicpuArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm, const uint32_t flag,
        const uint32_t kernelType) override;
    rtError_t MultipleTaskInfoLaunch(const rtMultipleTaskInfo_t * const taskInfo, Stream * const stm,
        const uint32_t flag) override;
    rtError_t DatadumpInfoLoad(const void * const dumpInfo, const uint32_t length, const uint32_t flag) override;
    rtError_t AicpuInfoLoad(const void * const aicpuInfo, const uint32_t length) override;
    rtError_t SetupArgument(const void * const setupArg, const uint32_t size, const uint32_t offset) override;
    rtError_t KernelTransArgSet(const void * const ptr, const uint64_t size, const uint32_t flag,
        void ** const setupArg) override;
    rtError_t KernelFusionStart(Stream * const stm) override;
    rtError_t KernelFusionEnd(Stream * const stm) override;
    rtError_t AppendLaunchAddrInfo(rtLaunchArgs_t* const hdl, void * const addrInfo)override;
    rtError_t AppendLaunchHostInfo(rtLaunchArgs_t* const hdl, size_t const hostInfoSize,
        void ** const hostInfo)  override;
    rtError_t DestroyLaunchArgs(rtLaunchArgs_t* argsHandle) override;
    rtError_t ResetLaunchArgs(rtLaunchArgs_t* argsHandle) override;
    rtError_t CalcLaunchArgsSize(size_t const argsSize, size_t const hostInfoTotalSize, size_t const hostInfoNum,
                                 size_t * const launchArgsSize) override;
    rtError_t CreateLaunchArgs(size_t const argsSize, size_t const hostInfoTotalSize,
        size_t const hostInfoNum, void * const argsData, rtLaunchArgs_t ** const argsHandle) override;
    rtError_t GetTaskBufferLen(const rtTaskBuffType_t type, uint32_t * const bufferLen) override;
    rtError_t TaskSqeBuild(const rtTaskInput_t * const taskInput, uint32_t * const taskLen) override;
    rtError_t GetKernelBin(const char_t *const binFileName, char_t **const buffer, uint32_t *length) override;
    rtError_t GetBinBuffer(const rtBinHandle binHandle, const rtBinBufferType_t type, void **bin,
                           uint32_t *binSize) override;
    rtError_t GetStackBuffer(const rtBinHandle binHandle, const uint32_t coreType, const uint32_t coreId,
                             const void **stack, uint32_t *stackSize) override;
    rtError_t FreeKernelBin(char_t * const buffer) override;
    rtError_t FusionLaunch(void * const fusionInfo, Stream * const stm, rtFusionArgsEx_t *argsInfo) override;

    // stream API
    rtError_t StreamCreate(Stream ** const stm, const int32_t priority, const uint32_t flags, DvppGrp *grp) override;
    rtError_t StreamDestroy(Stream * const stm, bool flag) override;
    rtError_t StreamWaitEvent(Stream * const stm, Event * const evt, const uint32_t timeout) override;
    rtError_t StreamSynchronize(Stream * const stm, const int32_t timeout) override;
    rtError_t StreamQuery(Stream * const stm) override;
    rtError_t GetStreamId(Stream * const stm, int32_t * const streamId) override;
    rtError_t GetSqId(Stream * const stm, uint32_t * const sqId) override;
    rtError_t GetCqId(Stream * const stm, uint32_t * const cqId, uint32_t * const logicCqId) override;
    rtError_t StreamSetMode(Stream * const stm, const uint64_t stmMode) override;
    rtError_t StreamGetMode(const Stream * const stm, uint64_t * const stmMode) override;
    rtError_t StreamBeginCapture(Stream * const stm, const rtStreamCaptureMode mode) override;
    rtError_t StreamEndCapture(Stream * const stm, Model ** const captureMdl) override;
    rtError_t StreamGetCaptureInfo(const Stream * const stm, rtStreamCaptureStatus * const status,
        Model ** const captureMdl) override;
    rtError_t SetStreamCacheOpInfoSwitch(const Stream * const stm, uint32_t cacheOpInfoSwitch) override;
    rtError_t GetStreamCacheOpInfoSwitch(const Stream * const stm, uint32_t * const cacheOpInfoSwitch) override;
    rtError_t ThreadExchangeCaptureMode(rtStreamCaptureMode * const mode) override;
    rtError_t StreamBeginTaskGrp(Stream * const stm) override;
    rtError_t StreamEndTaskGrp(Stream * const stm, TaskGroup ** const handle) override;
    rtError_t StreamBeginTaskUpdate(Stream * const stm, TaskGroup * handle) override;
    rtError_t StreamEndTaskUpdate(Stream * const stm) override;
    rtError_t StreamGetPriority(Stream * const stm, uint32_t * const priority) override;
    rtError_t StreamGetFlags(Stream * const stm, uint32_t * const flags) override;

    // event API
    rtError_t EventCreate(Event ** const evt, const uint64_t flag) override;
    rtError_t EventCreateEx(Event ** const evt, const uint64_t flag) override;
    rtError_t EventDestroy(Event *evt) override;
    rtError_t EventDestroySync(Event *evt) override;
    rtError_t EventRecord(Event * const evt, Stream * const stm) override;
    rtError_t EventCreateForNotify(Event ** const evt) override;
    rtError_t EventRecordForNotify(Event * const evt, Stream * const stm) override;
    rtError_t EventReset(Event * const evt, Stream * const stm) override;
    rtError_t EventSynchronize(Event * const evt, const int32_t timeout = -1) override;
    rtError_t EventQuery(Event * const evt) override;
    rtError_t EventQueryStatus(Event * const evt, rtEventStatus_t * const status) override;
    rtError_t EventQueryWaitStatus(Event * const evt, rtEventWaitStatus_t * const status) override;
    rtError_t EventElapsedTime(float32_t * const retTime, Event * const startEvt, Event * const endEvt) override;
    rtError_t EventGetTimeStamp(uint64_t * const retTime, Event * const evt) override;
    rtError_t GetEventID(Event * const evt, uint32_t * const evtId) override;
    rtError_t IpcGetEventHandle(IpcEvent * const evt, rtIpcEventHandle_t *handle) override;
    rtError_t IpcOpenEventHandle(rtIpcEventHandle_t *handle, IpcEvent** const event) override;
    // memory API
    rtError_t DevMalloc(void ** const devPtr, const uint64_t size, const rtMemType_t type,
        const uint16_t moduleId = MODULEID_RUNTIME) override;
    rtError_t DevFree(void * const devPtr) override;
    rtError_t DevDvppMalloc(void ** const devPtr, const uint64_t size, const uint32_t flag,
        const uint16_t moduleId = MODULEID_RUNTIME) override;
    rtError_t DevDvppFree(void * const devPtr) override;
    rtError_t HostMalloc(void ** const hostPtr, const uint64_t size, const uint16_t moduleId = MODULEID_RUNTIME) override;
    rtError_t HostMallocWithCfg(void ** const hostPtr, const uint64_t size,
        const rtMallocConfig_t *cfg = nullptr) override;
    rtError_t HostFree(void * const hostPtr) override;
    rtError_t MallocHostSharedMemory(rtMallocHostSharedMemoryIn * const in,
        rtMallocHostSharedMemoryOut * const out) override;
    rtError_t FreeHostSharedMemory(rtFreeHostSharedMemoryIn * const in) override;
    rtError_t HostRegister(void *ptr, uint64_t size, rtHostRegisterType type, void **devPtr) override;
    rtError_t HostRegisterV2(void *ptr, uint64_t size, uint32_t flag) override;
    rtError_t HostGetDevicePointer(void *pHost, void **pDevice, uint32_t flag) override;
    rtError_t HostUnregister(void *ptr) override;
    rtError_t ManagedMemAlloc(void ** const ptr, const uint64_t size, const uint32_t flag,
        const uint16_t moduleId = MODULEID_RUNTIME) override;
    rtError_t ManagedMemFree(const void * const ptr) override;
    rtError_t MemAdvise(void *devPtr, uint64_t count, uint32_t advise) override;
    rtError_t DevMallocCached(void ** const devPtr, const uint64_t size, const rtMemType_t type,
        const uint16_t moduleId = MODULEID_RUNTIME) override;
    rtError_t FlushCache(const uint64_t base, const size_t len) override;
    rtError_t InvalidCache(const uint64_t base, const size_t len) override;
    rtError_t MemCopySync(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cnt,
        const rtMemcpyKind_t kind, const uint32_t checkKind = INVALID_CHECK_KIND) override;
    rtError_t MemCopySyncEx(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cnt,
        const rtMemcpyKind_t kind) override;
    rtError_t MemcpyAsync(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cnt,
        const rtMemcpyKind_t kind, Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo = nullptr,
        const rtD2DAddrCfgInfo_t * const addrCfg = nullptr, bool checkKind = true, const rtMemcpyConfig_t * const memcpyConfig = nullptr) override;
    rtError_t LaunchSqeUpdateTask(uint32_t streamId, uint32_t taskId, void *src, uint64_t cnt,
                                  Stream * const stm, bool needCpuTask = false) override;
    rtError_t MemcpyAsyncPtr(void * const memcpyAddrInfo, const uint64_t destMax, const uint64_t count,
        Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo = nullptr, const bool isMemcpyDesc = false) override;
    rtError_t ReduceAsync(void * const dst, const void * const src, const uint64_t cnt, const rtRecudeKind_t kind,
        const rtDataType_t type, Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo = nullptr) override;
    rtError_t ReduceAsyncV2(void * const dst, const void * const src, const uint64_t cnt, const rtRecudeKind_t kind,
        const rtDataType_t type, Stream * const stm, void * const overflowAddr) override;
    rtError_t MemSetSync(const void * const devPtr, const uint64_t destMax, const uint32_t val,
        const uint64_t cnt) override;
    rtError_t MemsetAsync(void * const ptr, const uint64_t destMax, const uint32_t val, const uint64_t cnt,
        Stream * const stm) override;
    rtError_t MemGetInfoByDeviceId(uint32_t deviceId, bool isHugeOnly, size_t* const freeSize, size_t* const totalSize) override;
    rtError_t MemGetInfo(size_t * const freeSize, size_t * const totalSize) override;
    rtError_t MemGetInfoByType(const int32_t devId, const rtMemType_t type, rtMemInfo_t * const info) override;
    rtError_t CheckMemType(void **addrs, uint32_t size, uint32_t memType, uint32_t *checkResult, uint32_t reserve) override;
    rtError_t GetMemUsageInfo(const uint32_t deviceId, rtMemUsageInfo_t * const memUsageInfo,
                              const size_t inputNum, size_t * const outputNum) override;
    rtError_t MemGetInfoEx(const rtMemInfoType_t memInfoType, size_t * const freeSize,
        size_t * const totalSize) override;
    rtError_t PointerGetAttributes(rtPointerAttributes_t * const attributes, const void * const ptr) override;
    rtError_t PtrGetAttributes(const void * const ptr, rtPtrAttributes_t * const attributes) override;
    rtError_t MemPrefetchToDevice(const void * const devPtr, const uint64_t len, const int32_t devId) override;
    rtError_t MemCopy2DSync(void * const dst, const uint64_t dstPitch, const void * const src, const uint64_t srcPitch,
        const uint64_t width, const uint64_t height,
        const rtMemcpyKind_t kind = RT_MEMCPY_RESERVED, const rtMemcpyKind newKind = RT_MEMCPY_KIND_MAX) override;
    rtError_t MemCopy2DAsync(void * const dst, const uint64_t dstPitch, const void * const src, const uint64_t srcPitch,
        const uint64_t width, const uint64_t height, Stream * const stm,
        const rtMemcpyKind_t kind = RT_MEMCPY_RESERVED, const rtMemcpyKind newKind = RT_MEMCPY_KIND_MAX) override;
    rtError_t MemcpyHostTask(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cnt,
        const rtMemcpyKind_t kind, Stream * const stm) override;
    rtError_t GetDevArgsAddr(Stream *stm, rtArgsEx_t *argsInfo, void **devArgsAddr, void **argsHandle) override;
    rtError_t ReserveMemAddress(void** devPtr, size_t size, size_t alignment, void *devAddr, uint64_t flags) override;
    rtError_t ReleaseMemAddress(void* devPtr) override;
    rtError_t MallocPhysical(rtDrvMemHandle* handle, size_t size, rtDrvMemProp_t* prop, uint64_t flags) override;
    rtError_t FreePhysical(rtDrvMemHandle handle) override;
    rtError_t MapMem(void* devPtr, size_t size, size_t offset, rtDrvMemHandle handle, uint64_t flags) override;
    rtError_t UnmapMem(void* devPtr) override;
    rtError_t MemSetAccess(void *virPtr, size_t size, rtMemAccessDesc *desc, size_t count) override;
    rtError_t MemGetAccess(void *virPtr, rtMemLocation *location, uint64_t *flags) override;
    rtError_t ExportToShareableHandle(rtDrvMemHandle handle, rtDrvMemHandleType handleType,
        uint64_t flags, uint64_t *shareableHandle) override;
    rtError_t ExportToShareableHandleV2(rtDrvMemHandle handle, rtMemSharedHandleType handleType, uint64_t flags,
        void *shareableHandle) override;
    rtError_t ImportFromShareableHandle(uint64_t shareableHandle, int32_t devId, rtDrvMemHandle *handle) override;
    rtError_t ImportFromShareableHandleV2(const void *shareableHandle, rtMemSharedHandleType handleType,
        uint64_t flags, int32_t devId, rtDrvMemHandle *handle) override;
    rtError_t SetPidToShareableHandle(uint64_t shareableHandle, int32_t pid[], uint32_t pidNum) override;
    rtError_t SetPidToShareableHandleV2(
        const void *shareableHandle, rtMemSharedHandleType handleType, int32_t pid[], uint32_t pidNum) override;
    rtError_t GetAllocationGranularity(rtDrvMemProp_t *prop, rtDrvMemGranularityOptions option, size_t *granularity) override;
    rtError_t RtsMemcpyAsync(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cnt,
        const rtMemcpyKind kind, rtMemcpyConfig_t * const config, Stream * const stm) override;
    rtError_t RtsMemcpy(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cnt,
        const rtMemcpyKind kind, rtMemcpyConfig_t * const config) override;
    rtError_t SetMemcpyDesc(rtMemcpyDesc_t desc, const void * const srcAddr, const void * const dstAddr,
        const size_t count, const rtMemcpyKind kind, rtMemcpyConfig_t * const config) override;
    rtError_t MemcpyAsyncWithDesc(rtMemcpyDesc_t desc, Stream *stm, const rtMemcpyKind kind, rtMemcpyConfig_t * const config) override;
    rtError_t MemReserveAddress(void** virPtr, size_t size, rtMallocPolicy policy, void *expectAddr,  rtMallocConfig_t *cfg) override;
    rtError_t MemMallocPhysical(rtMemHandle* handle, size_t size, rtMallocPolicy policy, rtMallocConfig_t *cfg) override;
    rtError_t MemRetainAllocationHandle(void* virPtr, rtDrvMemHandle *handle) override;
    rtError_t MemGetAllocationPropertiesFromHandle(rtDrvMemHandle handle, rtDrvMemProp_t* prop) override;
    // new memory api
    rtError_t DevMalloc(void ** const devPtr, const uint64_t size, rtMallocPolicy policy, rtMallocAdvise advise, const rtMallocConfig_t * const cfg) override;
    rtError_t MemWriteValue(const void * const devAddr, const uint64_t value, const uint32_t flag, Stream * const stm) override;
    rtError_t MemWaitValue(const void * const devAddr, const uint64_t value, const uint32_t flag, Stream * const stm) override;
    rtError_t MemcpyBatch(void **dsts, void **srcs, size_t *sizes, size_t count,
        rtMemcpyBatchAttr *attrs, size_t *attrsIdxs, size_t numAttrs, size_t *failIdx) override;
    rtError_t MemcpyBatchAsync(void** const dsts, const size_t* const destMaxs,  void** const srcs, const size_t* const sizes,
    const size_t count, const rtMemcpyBatchAttr* const attrs, const size_t* const attrsIdxs, const size_t numAttrs, size_t* const failIdx,
    Stream* const stm) override;

    // device API
    rtError_t GetDeviceStatus(const int32_t devId, rtDevStatus_t * const status) override;
    rtError_t SetDeviceResLimit(const uint32_t devId, const rtDevResLimitType_t type, uint32_t value) override;
    rtError_t ResetDeviceResLimit(const uint32_t devId) override;
    rtError_t GetDeviceResLimit(const uint32_t devId, const rtDevResLimitType_t type, uint32_t* value) override;
    rtError_t SetStreamResLimit(Stream *const stm, const rtDevResLimitType_t type, const uint32_t value) override;
    rtError_t ResetStreamResLimit(Stream *const stm) override;
    rtError_t GetStreamResLimit(const Stream *const stm, const rtDevResLimitType_t type, uint32_t *const value) override;
    rtError_t UseStreamResInCurrentThread(const Stream *const stm) override;
    rtError_t NotUseStreamResInCurrentThread(const Stream *const stm) override;
    rtError_t GetResInCurrentThread(const rtDevResLimitType_t type, uint32_t *const value) override;
    rtError_t HdcServerCreate(const int32_t devId, const rtHdcServiceType_t type,
        rtHdcServer_t * const server) override;
    rtError_t HdcServerDestroy(rtHdcServer_t const server) override;
    rtError_t HdcSessionConnect(const int32_t peerNode, const int32_t peerDevId, rtHdcClient_t const client,
        rtHdcSession_t * const session) override;
    rtError_t HdcSessionClose(rtHdcSession_t const session) override;
    rtError_t GetHostCpuDevId(int32_t * const devId) override;
    rtError_t GetDeviceCount(int32_t * const cnt) override;
    rtError_t OpenNetService(const rtNetServiceOpenArgs *args) override;
    rtError_t CloseNetService() override;
    rtError_t GetDeviceIDs(uint32_t * const devId, const uint32_t len) override;
    rtError_t SetDevice(const int32_t devId) override;
    rtError_t GetDevice(int32_t * const devId) override;
    rtError_t GetDevicePhyIdByIndex(const uint32_t devIndex, uint32_t * const phyId) override;
    rtError_t GetDeviceIndexByPhyId(const uint32_t phyId, uint32_t * const devIndex) override;
    rtError_t DeviceReset(const int32_t devId, const bool isForceReset = false) override;
    rtError_t DeviceSetLimit(const int32_t devId, const rtLimitType_t type, const uint32_t val) override;
    rtError_t DeviceSynchronize(const int32_t timeout) override;
    rtError_t DeviceTaskAbort(const int32_t devId, const uint32_t timeout) override;
    rtError_t SnapShotProcessLock() override;
    rtError_t SnapShotProcessUnlock() override;
    rtError_t SnapShotProcessBackup() override;
    rtError_t SnapShotProcessRestore() override;
    rtError_t SnapShotCallbackRegister(rtSnapShotStage stage, rtSnapShotCallBack callback, void *args) override;
    rtError_t SnapShotCallbackUnregister(rtSnapShotStage stage, rtSnapShotCallBack callback) override;
    rtError_t DeviceGetStreamlist(int32_t devId, rtStreamlistType_t type, rtStreamlist_t *stmList) override;
    rtError_t DeviceGetModelList(int32_t devId, rtModelList_t *mdlList) override;
    rtError_t DeviceGetStreamPriorityRange(int32_t * const leastPriority, int32_t * const greatestPriority) override;
    rtError_t GetDeviceInfo(const uint32_t deviceId, const int32_t moduleType, const int32_t infoType,
        int64_t * const val) override;
    rtError_t GetDeviceInfoFromPlatformInfo(const uint32_t deviceId, const std::string &label,
        const std::string &key, int64_t * const value) override;
    rtError_t GetDeviceInfoByAttr(uint32_t deviceId, rtDevAttr attr, int64_t *val) override;
    rtError_t GetPhyDeviceInfo(const uint32_t phyId, const int32_t moduleType, const int32_t infoType,
        int64_t * const val) override;
    rtError_t DeviceSetTsId(const uint32_t tsId) override;
    rtError_t EnableP2P(const uint32_t devIdDes, const uint32_t phyIdSrc, const uint32_t flag) override;
    rtError_t DisableP2P(const uint32_t devIdDes, const uint32_t phyIdSrc) override;
    rtError_t DeviceCanAccessPeer(int32_t * const canAccessPeer, const uint32_t devId,
        const uint32_t peerDevice) override;
    rtError_t GetP2PStatus(const uint32_t devIdDes, const uint32_t phyIdSrc, uint32_t * const status) override;
    rtError_t DeviceGetBareTgid(uint32_t * const pid) override;
    rtError_t GetPairDevicesInfo(const uint32_t devId, const uint32_t otherDevId, const int32_t infoType,
        int64_t * const val) override;
    rtError_t GetPairPhyDevicesInfo(const uint32_t devId, const uint32_t otherDevId, const int32_t infoType,
        int64_t * const val) override;
    rtError_t GetRtCapability(const rtFeatureType_t featureType, const int32_t featureInfo,
        int64_t * const val) override;
    rtError_t GetDeviceCapability(const int32_t deviceId, const int32_t moduleType, const int32_t featureType,
        int32_t * const val) override;
    rtError_t ModelCheckArchVersion(const char_t *omArchVersion, const rtArchType_t archType) override;
    rtError_t CheckArchCompatibility(const char_t *omSocVersion, int32_t *canCompatible) override;
    rtError_t DeviceStatusQuery(const uint32_t devId, rtDeviceStatus *deviceStatus) override;
    rtError_t GetFaultEvent(const int32_t deviceId, rtDmsEventFilter *filter, rtDmsFaultEvent *dmsEvent,
        uint32_t len, uint32_t *eventCount) override;
    rtError_t GetMemUceInfo(const uint32_t deviceId, rtMemUceInfo *memUceInfo) override;
    rtError_t MemUceRepair(const uint32_t deviceId, rtMemUceInfo *memUceInfo) override;
    rtError_t SetDefaultDeviceId(const int32_t deviceId) override;
    rtError_t DeviceResetForce(const int32_t devId) override;
    rtError_t SetDeviceFailureMode(uint64_t failureMode) override;
    rtError_t GetLastErr(rtLastErrLevel_t level) override;
    rtError_t PeekLastErr(rtLastErrLevel_t level) override;
    rtError_t GetLogicDevIdByUserDevId(const int32_t userDevId, int32_t * const logicDevId) override;
    rtError_t GetUserDevIdByLogicDevId(const int32_t logicDevId, int32_t * const userDevId) override;
    rtError_t DeviceResourceClean(const int32_t devId) override;
    rtError_t SetXpuDevice(rtXpuDevType devType, const uint32_t devId) override;
    rtError_t ResetXpuDevice(rtXpuDevType devType, const uint32_t devId) override;
    rtError_t GetDeviceUuid(const int32_t devId, rtUuid_t *uuid) override;

    // context
    rtError_t ContextCreate(Context ** const inCtx, const int32_t devId) override;
    rtError_t ContextDestroy(Context * const inCtx) override;
    rtError_t ContextSetCurrent(Context * const inCtx) override;
    rtError_t ContextGetCurrent(Context ** const inCtx) override;
    rtError_t ContextGetDevice(int32_t * const devId) override;
    rtError_t ContextSetINFMode(const bool infMode) override;
    rtError_t CtxGetCurrentDefaultStream(Stream ** const stm) override;
    rtError_t GetPrimaryCtxState(const int32_t devId, uint32_t *flags, int32_t *active) override;

    // resource name
    rtError_t NameStream(Stream * const stm, const char_t * const name) override;
    rtError_t NameEvent(Event * const evt, const char_t * const name) override;

    rtError_t ProfilerStart(const uint64_t profConfig, const int32_t numsDev, uint32_t *const deviceList,
        const uint32_t cacheFlag, const uint64_t profSwitchHi) override;
    rtError_t ProfilerStop(const uint64_t profConfig, const int32_t numsDev, uint32_t *const deviceList,
        const uint64_t profSwitchHi) override;
    rtError_t GetBinaryDeviceBaseAddr(const Program * const prog, void **deviceBase) override;
    rtError_t ProfilerTrace(const uint64_t id, const bool notifyFlag, const uint32_t flags,
        Stream * const stm) override;
    rtError_t ProfilerTraceEx(const uint64_t id, const uint64_t modelId, const uint16_t tagId,
        Stream * const stm) override;

    rtError_t StartOnlineProf(Stream * const stm, const uint32_t sampleNum) override;
    rtError_t StopOnlineProf(Stream * const stm) override;
    rtError_t GetOnlineProfData(Stream * const stm, rtProfDataInfo_t * const pProfData,
        const uint32_t profDataNum) override;
    rtError_t AdcProfiler(const uint64_t addr, const uint32_t length) override;
    rtError_t SetMsprofReporterCallback(const MsprofReporterCallback callback) override;

    // inquire information
    rtError_t GetMaxStreamAndTask(const uint32_t streamType, uint32_t * const maxStrCount,
        uint32_t * const maxTaskCount) override;
    rtError_t GetAvailStreamNum(const uint32_t streamType, uint32_t * const streamCount) override;
    rtError_t GetFreeStreamNum(uint32_t * const streamCount) override;
    rtError_t GetAvailEventNum(uint32_t * const eventCount) override;
    rtError_t GetTaskIdAndStreamID(uint32_t * const taskId, uint32_t * const streamId) override;
    rtError_t GetMaxModelNum(uint32_t * const maxModelCount) override;

    // model
    rtError_t ModelCreate(Model ** const mdl, const uint32_t flag) override;
    rtError_t ModelSetExtId(Model * const mdl, const uint32_t extId) override;
    rtError_t ModelDestroy(Model * const mdl) override;
    rtError_t ModelBindStream(Model * const mdl, Stream * const stm, const uint32_t flag) override;
    rtError_t ModelUnbindStream(Model * const mdl, Stream * const stm) override;
    rtError_t ModelLoadComplete(Model * const mdl) override;
    rtError_t ModelExecute(Model * const mdl, Stream * const stm, const uint32_t flag,
        int32_t timeout = -1) override;
    rtError_t ModelExecuteSync(Model * const mdl, int32_t timeout = -1) override;
    rtError_t ModelExecuteAsync(Model * const mdl, Stream * const stm) override;
    rtError_t ModelGetTaskId(Model * const mdl, uint32_t * const taskId, uint32_t * const streamId) override;
    rtError_t ModelGetId(Model * const mdl, uint32_t * const modelId) override;
    rtError_t ModelEndGraph(Model * const mdl, Stream * const stm, const uint32_t flags) override;
    rtError_t ModelExecutorSet(Model * const mdl, const uint8_t flags) override;
    rtError_t ModelAbort(Model * const mdl) override;
    rtError_t ModelBindQueue(Model * const mdl, const uint32_t queueId, const rtModelQueueFlag_t flag) override;
    rtError_t ModelExit(Model * const mdl, Stream * const stm) override;
    rtError_t ModelNameSet(Model * const mdl, const char_t * const name) override;
    rtError_t ModelGetName(Model * const mdl, const uint32_t maxLen, char_t * const mdlName) override;
    rtError_t DebugRegister(Model * const mdl, const uint32_t flag, const void * const addr, uint32_t * const streamId,
                            uint32_t * const taskId) override;
    rtError_t DebugUnRegister(Model * const mdl) override;
    rtError_t DebugRegisterForStream(Stream * const stm, const uint32_t flag, const void * const addr,
                                     uint32_t * const streamId, uint32_t * const taskId) override;
    rtError_t DebugUnRegisterForStream(Stream * const stm) override;
    rtError_t ModelSetSchGroupId(Model * const mdl, const int16_t schGrpId) override;
    rtError_t ModelTaskUpdate(Stream *desStm, uint32_t desTaskId, Stream *sinkStm,
                              rtMdlTaskUpdateInfo_t *para) override;
    rtError_t ModelGetNodes(const Model * const mdl, uint32_t * const num) override;
    rtError_t ModelDebugDotPrint(const Model * const mdl) override;
    rtError_t ModelDebugJsonPrint(const Model * const mdl, const char* path, const uint32_t flags) override;
    rtError_t StreamAddToModel(Stream * const stm, Model * const captureMdl) override;

    /* hardware Info */
    rtError_t GetAiCoreCount(uint32_t * const aiCoreCnt) override;
    rtError_t GetAiCpuCount(uint32_t * const aiCpuCnt) override;
    rtError_t SetDeviceSatMode(const rtFloatOverflowMode_t floatOverflowMode) override;
    rtError_t GetDeviceSatMode(rtFloatOverflowMode_t * const floatOverflowMode) override;
    rtError_t GetDeviceSatModeForStream(Stream * const stm, rtFloatOverflowMode_t * const floatOverflowMode) override;
    rtError_t SetStreamOverflowSwitch(Stream * const stm, const uint32_t flags) override;
    rtError_t GetStreamOverflowSwitch(Stream * const stm, uint32_t * const flags) override;

    rtError_t SetExceptCallback(const rtErrorCallback callback) override;
    rtError_t SetTaskAbortCallBack(const char_t *regName, void *callback, void *args,
        TaskAbortCallbackType type) override;
    rtError_t SetTaskFailCallback(void *callback, void *args, TaskFailCallbackType type) override;
    rtError_t RegDeviceStateCallback(const char_t *regName, void *callback, void *args,
        DeviceStateCallback type, rtDevCallBackDir_t notifyPos = DEV_CB_POS_BACK) override;
    rtError_t RegTaskFailCallbackByModule(const char_t *regName, void *callback, void *args,
        TaskFailCallbackType type) override;
    rtError_t RegProfCtrlCallback(const uint32_t moduleId, const rtProfCtrlHandle callback) override;
    rtError_t RegStreamStateCallback(const char_t *regName, void *callback, void *args,
        StreamStateCallback type) override;
    // IPC API
    rtError_t IpcSetMemoryName(const void * const ptr, const uint64_t byteCount, char_t * const name,
        const uint32_t len, const uint64_t flags) override;
    rtError_t IpcSetMemoryAttr(const char *name, uint32_t type, uint64_t attr) override;
    rtError_t NopTask(Stream * const stm) override;
    rtError_t IpcOpenMemory(void ** const ptr, const char_t * const name, const uint64_t flags) override;
    rtError_t IpcCloseMemory(const void * const ptr) override;
    rtError_t IpcCloseMemoryByName(const char_t * const name) override;
    rtError_t IpcDestroyMemoryName(const char_t * const name) override;
    rtError_t RDMASend(const uint32_t sqIndex, const uint32_t wqeIndex, Stream * const stm) override;
    rtError_t RdmaDbSend(const uint32_t dbIndex, const uint64_t dbInfo, Stream * const stm) override;

    // Notify API
    rtError_t NotifyCreate(const int32_t deviceId, Notify ** const retNotify,
        uint64_t flag = RT_NOTIFY_FLAG_DEFAULT) override;
    rtError_t NotifyDestroy(Notify * const inNotify) override;
    rtError_t NotifyRecord(Notify * const inNotify, Stream * const stm) override;
    rtError_t NotifyReset(Notify * const inNotify) override;
    rtError_t ResourceClean(int32_t devId, rtIdType_t type) override;
    rtError_t NotifyWait(Notify * const inNotify, Stream * const stm, const uint32_t timeOut) override;
    rtError_t GetNotifyID(Notify * const inNotify, uint32_t * const notifyID) override;
    rtError_t GetNotifyPhyInfo(Notify *const inNotify, rtNotifyPhyInfo *notifyInfo) override;
    rtError_t IpcSetNotifyName(Notify * const inNotify, char_t * const name, const uint32_t len, const uint64_t flag) override;
    rtError_t IpcOpenNotify(Notify ** const retNotify, const char_t * const name,
        uint32_t flag = RT_NOTIFY_FLAG_DEFAULT) override;

    rtError_t NotifyGetAddrOffset(Notify * const inNotify, uint64_t * const devAddrOffset) override;
    rtError_t WriteValuePtr(void * const writeValueInfo, Stream * const stm, void * const pointedAddr) override;

    // CountNotify api
    rtError_t CntNotifyCreate(const int32_t deviceId, CountNotify ** const retCntNotify,
                              const uint32_t flag = RT_NOTIFY_FLAG_DEFAULT) override;
    rtError_t CntNotifyDestroy(CountNotify * const inCntNotify) override;
    rtError_t CntNotifyRecord(CountNotify * const inCntNotify, Stream * const stm,
                              const rtCntNtyRecordInfo_t * const info) override;
    rtError_t CntNotifyWaitWithTimeout(CountNotify * const inCntNotify, Stream * const stm,
                                       const rtCntNtyWaitInfo_t * const info) override;
    rtError_t CntNotifyReset(CountNotify * const inCntNotify, Stream * const stm) override;
    rtError_t GetCntNotifyAddress(CountNotify *const inCntNotify, uint64_t * const cntNotifyAddress,
        rtNotifyType_t const regType) override;
    rtError_t GetCntNotifyId(CountNotify * const inCntNotify, uint32_t * const notifyId) override;
    rtError_t WriteValue(rtWriteValueInfo_t * const info, Stream * const stm) override;

    // CCU Launch
    rtError_t CCULaunch(rtCcuTaskInfo_t *taskInfo,  Stream * const stm) override;
    rtError_t UbDevQueryInfo(rtUbDevQueryCmd cmd, void *devInfo) override;
    rtError_t GetDevResAddress(const rtDevResInfo * const resInfo, rtDevResAddrInfo * const addrInfo) override;
    rtError_t ReleaseDevResAddress(rtDevResInfo * const resInfo) override;

    // switch api
    rtError_t StreamSwitchEx(void * const ptr, const rtCondition_t condition, void * const valuePtr,
        Stream * const trueStream, Stream * const stm, const rtSwitchDataType_t dataType) override;
    rtError_t StreamActive(Stream * const activeStream, Stream * const stm) override;
    rtError_t StreamSwitchN(void * const ptr, const uint32_t size, void * const valuePtr, Stream ** const trueStreamPtr,
        const uint32_t elementSize, Stream * const stm, const rtSwitchDataType_t dataType) override;

    // label API
    rtError_t LabelCreate(Label ** const lbl, Model * const mdl) override;
    rtError_t LabelDestroy(Label * const lbl) override;
    rtError_t LabelSet(Label * const lbl, Stream * const stm) override;
    rtError_t LabelGoto(Label * const lbl, Stream * const stm) override;
    rtError_t SetIpcNotifyPid(const char_t * const name, int32_t pid[], const int32_t num) override;
    rtError_t SetIpcMemPid(const char_t * const name, int32_t pid[], const int32_t num) override;

    // callback api
    rtError_t SubscribeReport(const uint64_t threadId, Stream * const stm) override;
    rtError_t CallbackLaunch(const rtCallback_t callBackFunc, void * const fnData, Stream * const stm,
        const bool isBlock) override;
    rtError_t ProcessReport(const int32_t timeout, const bool noLog = false) override;
    rtError_t UnSubscribeReport(const uint64_t threadId, Stream * const stm) override;
    rtError_t GetRunMode(rtRunMode * const runMode) override;
    rtError_t GetAicpuDeploy(rtAicpuDeployType_t * const deployType) override;
    rtError_t LaunchHostFunc(Stream * const stm, const rtCallback_t callBackFunc, void * const fnData) override;
    // stream label func
    ::rtError_t LabelSwitchByIndex(void * const ptr, const uint32_t maxVal, void * const labelInfoPtr,
        Stream * const stm) override;
    ::rtError_t LabelGotoEx(Label * const lbl, Stream * const stm) override;
    ::rtError_t LabelListCpy(Label ** const lbl, const uint32_t labelNumber, void * const dst,
        const uint32_t dstMax) override;
    ::rtError_t LabelCreateEx(Label ** const lbl, Model * const mdl, Stream * const stm) override;
    rtError_t LabelSwitchListCreate(Label ** const labels, const size_t num, void ** const labelList) override;
    rtError_t SetGroup(const int32_t groupId) override;
    rtError_t GetGroupCount(uint32_t * const cnt) override;
    rtError_t GetGroupInfo(const int32_t groupId, rtGroupInfo_t * const groupInfo, const uint32_t cnt) override;
    rtError_t StarsTaskLaunch(const void * const sqe, const uint32_t sqeLen, Stream * const stm,
        const uint32_t flag) override;
    rtError_t FftsPlusTaskLaunch(const rtFftsPlusTaskInfo_t * const fftsPlusTaskInfo, Stream * const stm,
        const uint32_t flag) override;
    rtError_t NpuGetFloatStatus(void * const outputAddrPtr, const uint64_t outputSize, const uint32_t checkMode,
        Stream * const stm) override;
    rtError_t NpuClearFloatStatus(const uint32_t checkMode, Stream * const stm) override;
    rtError_t NpuGetFloatDebugStatus(void * const outputAddrPtr, const uint64_t outputSize, const uint32_t checkMode,
        Stream * const stm) override;
    rtError_t NpuClearFloatDebugStatus(const uint32_t checkMode, Stream * const stm) override;

    // C/V Synchronize data between cores
    rtError_t GetC2cCtrlAddr(uint64_t * const addr, uint32_t * const len) override;

    rtError_t GetL2CacheOffset(uint32_t deviceId, uint64_t *offset) override;
    // set task timeout time
    rtError_t SetOpWaitTimeOut(const uint32_t timeout) override;
    rtError_t SetOpExecuteTimeOut(const uint32_t timeout, const RtTaskTimeUnitType timeUnitType) override;
    rtError_t GetOpExecuteTimeOut(uint32_t * const timeout) override;
    rtError_t GetOpExecuteTimeoutV2(uint32_t *const timeout) override;
    rtError_t GetOpTimeOutInterval(uint64_t *interval) override;
    rtError_t SetOpExecuteTimeOutV2(uint64_t timeout, uint64_t *actualTimeout) override;

    // error message
    rtError_t GetDevMsg(const rtGetDevMsgType_t getMsgType, const rtGetMsgCallback callback) override;

    // mbuff queue api
    rtError_t MemQueueInitQS(const int32_t devId, const char_t * const grpName) override;
    rtError_t MemQueueInitFlowGw(const int32_t devId, const rtInitFlowGwInfo_t * const initInfo) override;
    rtError_t MemQueueCreate(const int32_t devId, const rtMemQueueAttr_t * const queAttr,
        uint32_t * const qid) override;

    rtError_t MemQueueExport(const int32_t devId, const uint32_t qid, const int32_t peerDevId,
        const char * const shareName) override;
    rtError_t MemQueueUnExport(const int32_t devId, const uint32_t qid, const int32_t peerDevId,
        const char * const shareName) override;
    rtError_t MemQueueImport(const int32_t devId, const int32_t peerDevId, const char * const shareName,
        uint32_t * const qid) override;
    rtError_t MemQueueUnImport(const int32_t devId, const uint32_t qid, const int32_t peerDevId, 
        const char * const shareName) override;            

    rtError_t MemQueueSet(const int32_t devId, const rtMemQueueSetCmdType cmd,
        const rtMemQueueSetInputPara * const input) override;
    rtError_t MemQueueDestroy(const int32_t devId, const uint32_t qid) override;
    rtError_t MemQueueInit(const int32_t devId) override;
    rtError_t MemQueueReset(const int32_t devId, const uint32_t qid) override;
    rtError_t MemQueueEnQueue(const int32_t devId, const uint32_t qid, void * const enQBuf) override;
    rtError_t MemQueueDeQueue(const int32_t devId, const uint32_t qid, void ** const deQBuf) override;
    rtError_t MemQueuePeek(const int32_t devId, const uint32_t qid, size_t * const bufLen,
        const int32_t timeout) override;
    rtError_t MemQueueEnQueueBuff(const int32_t devId, const uint32_t qid, rtMemQueueBuff_t * const inBuf,
        const int32_t timeout) override;
    rtError_t MemQueueDeQueueBuff(const int32_t devId, const uint32_t qid, rtMemQueueBuff_t * const outBuf,
        const int32_t timeout) override;
    rtError_t MemQueueQueryInfo(const int32_t devId, const uint32_t qid,
        rtMemQueueInfo_t * const queryQueueInfo) override;
    rtError_t MemQueueQuery(const int32_t devId, const rtMemQueueQueryCmd_t cmd, const void * const inBuff,
        const uint32_t inLen, void * const outBuff, uint32_t * const outLen) override;
    rtError_t MemQueueGrant(const int32_t devId, const uint32_t qid, const int32_t pid,
        rtMemQueueShareAttr_t * const attr) override;
    rtError_t MemQueueAttach(const int32_t devId, const uint32_t qid, const int32_t timeOut) override;
    rtError_t EschedSubmitEventSync(const int32_t devId, rtEschedEventSummary_t * const evt,
        rtEschedEventReply_t * const ack) override;
    rtError_t QueryDevPid(rtBindHostpidInfo_t * const info, int32_t * const devPid) override;
    rtError_t BuffAlloc(const uint64_t size, void **buff) override;
    rtError_t BuffConfirm(void * const buff, const uint64_t size) override;
    rtError_t BuffFree(void * const buff) override;
    rtError_t MemGrpCreate(const char_t * const name, const rtMemGrpConfig_t * const cfg) override;
    rtError_t MemGrpCacheAlloc(const char_t *const name, const int32_t devId,
        const rtMemGrpCacheAllocPara *const para) override;
    rtError_t BuffGetInfo(const rtBuffGetCmdType type, const void * const inBuff, const uint32_t inLen,
        void * const outBuff, uint32_t * const outLen) override;
    rtError_t MemGrpAddProc(const char_t * const name, const int32_t pid,
        const rtMemGrpShareAttr_t * const attr) override;
    rtError_t MemGrpAttach(const char_t * const name, const int32_t timeout) override;
    rtError_t MemGrpQuery(rtMemGrpQueryInput_t * const input, rtMemGrpQueryOutput_t * const output) override;
    rtError_t MemQueueGetQidByName(const int32_t devId, const char_t * const name, uint32_t * const qId) override;
    rtError_t QueueSubF2NFEvent(const int32_t devId, const uint32_t qId, const uint32_t groupId) override;
    rtError_t QueueSubscribe(const int32_t devId, const uint32_t qId, const uint32_t groupId,
        const int32_t type) override;
    rtError_t BufEventTrigger(const char_t * const name) override;
    rtError_t EschedAttachDevice(const uint32_t devId) override;
    rtError_t EschedDettachDevice(const uint32_t devId) override;
    rtError_t EschedWaitEvent(const int32_t devId, const uint32_t grpId,
        const uint32_t threadId, const int32_t timeout, rtEschedEventSummary_t * const evt) override;
    rtError_t EschedCreateGrp(const int32_t devId, const uint32_t grpId, const rtGroupType_t type) override;
    rtError_t EschedSubmitEvent(const int32_t devId, rtEschedEventSummary_t * const evt) override;
    rtError_t EschedSubscribeEvent(const int32_t devId, const uint32_t grpId,
        const uint32_t threadId, const uint64_t eventBitmap) override;
    rtError_t EschedAckEvent(const int32_t devId, const rtEventIdType_t evtId,
        const uint32_t subeventId, char_t * const msg, const uint32_t len) override;
    rtError_t CmoTaskLaunch(const rtCmoTaskInfo_t * const taskInfo, Stream * const stm,
        const uint32_t flag) override;
    rtError_t CmoAddrTaskLaunch(void *cmoAddrInfo, const uint64_t destMax, const rtCmoOpCode_t cmoOpCode,
        Stream * const stm, const uint32_t flag) override;
    rtError_t BarrierTaskLaunch(const rtBarrierTaskInfo_t * const taskInfo, Stream * const stm,
        const uint32_t flag) override;

    rtError_t DvppGroupCreate(DvppGrp **grp, const uint32_t flags) override;
    rtError_t DvppGroupDestory(DvppGrp *grp) override;
    rtError_t DvppWaitGroupReport(DvppGrp * const grp, const rtDvppGrpCallback callBackFunc, const int32_t timeout) override;
    rtError_t SetStreamTag(Stream * const stm, const uint32_t geOpTag) override;
    rtError_t GetStreamTag(Stream * const stm, uint32_t * const geOpTag) override;
    rtError_t GetVisibleDeviceIdByLogicDeviceId(const int32_t logicDeviceId, int32_t * const visibleDeviceId) override;
    rtError_t CtxSetSysParamOpt(const rtSysParamOpt configOpt, const int64_t configVal) override;
    rtError_t CtxGetSysParamOpt(const rtSysParamOpt configOpt, int64_t * const configVal) override;
    rtError_t CtxGetOverflowAddr(void ** const overflowAddr) override;
    rtError_t GetDeviceSatStatus(void * const outputAddrPtr, const uint64_t outputSize, Stream * const stm) override;
    rtError_t CleanDeviceSatStatus(Stream * const stm) override;
    rtError_t GetAllUtilizations(const int32_t devId, const rtTypeUtil_t kind, uint8_t * const util) override;
    rtError_t EschedQueryInfo(const uint32_t devId, const rtEschedQueryType type,
                              rtEschedInputInfo *inPut, rtEschedOutputInfo *outPut) override;
    rtError_t BindHostPid(rtBindHostpidInfo info) override;
    rtError_t UnbindHostPid(rtBindHostpidInfo info) override;
    rtError_t QueryProcessHostPid(int32_t pid, uint32_t *chipId, uint32_t *vfId, uint32_t *hostPid,
        uint32_t *cpType) override;
    rtError_t SetStreamSqLockUnlock(Stream * const stm, const bool isLock) override;
    rtError_t ShrIdSetPodPid(const char *name, uint32_t sdid, int32_t pid) override;
    rtError_t ShmemSetPodPid(const char *name, uint32_t sdid, int32_t pid[], int32_t num) override;
    rtError_t DevVA2PA(uint64_t devAddr, uint64_t len, Stream *stm, bool isAsync) override;
    rtError_t StreamClear(Stream * const stm, rtClearStep_t step) override;
    rtError_t StreamAbort(Stream * const stm) override;
    rtError_t DebugSetDumpMode(const uint64_t mode) override;
    rtError_t DebugGetStalledCore(rtDbgCoreInfo_t *const coreInfo) override;
    rtError_t DebugReadAICore(rtDebugMemoryParam_t *const param) override;
    rtError_t GetExceptionRegInfo(const rtExceptionInfo_t * const exceptionInfo,
        rtExceptionErrRegInfo_t **exceptionErrRegInfo, uint32_t *num) override;
    rtError_t GetServerIDBySDID(uint32_t sdid, uint32_t *srvId) override;

    rtError_t GetThreadLastTaskId(uint32_t * const taskId) override;
    rtError_t LaunchDvppTask(const void * const sqe, const uint32_t sqeLen, Stream * const stm, rtDvppCfg_t *cfg = nullptr) override;
    rtError_t LaunchRandomNumTask(const rtRandomNumTaskInfo_t *taskInfo, Stream * const stm, void *reserve) override;
    rtError_t KernelArgsInit(Kernel * const funcHandle, RtArgsHandle **argsHandle) override;
    rtError_t KernelArgsAppendPlaceHolder(RtArgsHandle *argsHandle, ParaDetail **paraHandle) override;
    rtError_t KernelArgsGetPlaceHolderBuffer(RtArgsHandle *argsHandle, ParaDetail *paraHandle, size_t dataSize, void **bufferAddr) override;
    rtError_t KernelArgsGetHandleMemSize(Kernel * const funcHandle, size_t *memSize) override;
    rtError_t KernelArgsGetMemSize(Kernel * const funcHandle, size_t userArgsSize, size_t *actualArgsSize) override;
    rtError_t KernelArgsInitByUserMem(Kernel * const funcHandle, RtArgsHandle *argsHandle, void *userHostMem,
        size_t actualArgsSize) override;
    rtError_t KernelArgsFinalize(RtArgsHandle *argsHandle) override;
    rtError_t KernelArgsAppend(RtArgsHandle *argsHandle, void *para, size_t paraSize, ParaDetail **paraHandle) override;
    rtError_t UbDbSend(rtUbDbInfo_t * const dbInfo, Stream * const stm) override;
    rtError_t UbDirectSend(rtUbWqeInfo_t *const wqeInfo, Stream * const stm) override;
    rtError_t StreamTaskAbort(Stream * const stm) override;
    rtError_t StreamRecover(Stream * const stm) override;
    rtError_t StreamTaskClean(Stream * const stm) override;

    // cmo addr task
    rtError_t GetCmoDescSize(size_t *size) override;
    rtError_t SetCmoDesc(rtCmoDesc_t cmoDesc, void *srcAddr, size_t srcLen) override;
    // Get Api instance.

    rtError_t GetErrorVerbose(const uint32_t deviceId, rtErrorInfo * const errorInfo) override;
    rtError_t RepairError(const uint32_t deviceId, const rtErrorInfo * const errorInfo) override;

    // dqs
    rtError_t LaunchDqsTask(Stream * const stm, const rtDqsTaskCfg_t * const taskCfg) override;

    // event mode
    rtError_t EventWorkModeSet(uint8_t mode) override;
    rtError_t EventWorkModeGet(uint8_t *mode) override;

    // aclgraph caching shape for profiling
    rtError_t CacheLastTaskOpInfo(const void * const infoPtr, const size_t infoSize) override;
    rtError_t FunctionGetAttribute(rtFuncHandle funcHandle, rtFuncAttribute attrType, int64_t *attrValue) override;

protected:
    Api *impl_;
};
}
}

#endif  // CCE_RUNTIME_API_DECORATOR_HPP
