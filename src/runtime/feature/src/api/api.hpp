/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_API_HPP
#define CCE_RUNTIME_API_HPP

#include "rts/rts.h"
#include "runtime.hpp"
#include "ipc_event.hpp"
#include "model.hpp"
#include "runtime/event.h"
#include "runtime/base.h"
#include "runtime/mem.h"
#include "runtime/rt_mem_queue.h"
#include "runtime/rt_preload_task.h"
#include "runtime/elf_base.h"
#include "dqs/task_dqs.hpp"

namespace cce {
namespace runtime {
constexpr uint32_t MIN_ARG_SIZE = 4U;
constexpr uint32_t ARG_ENTRY_SIZE = 2624U;                 // 1536 + 1024(tiling) + 64(host mem)
constexpr uint32_t MULTI_GRAPH_ARG_ENTRY_SIZE = 6208U;     // 5120 + 1024(tiling) + 64(host mem)
constexpr uint32_t DEFAULT_INIT_CNT = 1024U;
constexpr uint32_t MULTI_GRAPH_SUPER_ARG_ENTRY_SIZE = 15360U;
constexpr uint32_t ARG_ENTRY_INCRETMENT_SIZE = 40960U;     // 40K

constexpr uint32_t KERNEL_INFO_ENTRY_SIZE = 256U;
constexpr uint32_t MEMCPY_ASYNC_UB_SIZE = 256U * 1024U * 1024U;
constexpr uint32_t HOST_CALLBACK_SQCQ_BIT = 1024U;

/* special error code for end of sequence */
constexpr uint32_t RT_GET_ERR_CODE = 0xFFFU;

constexpr uint32_t API_ENV_FLAGS_DEFAULT = 0U;
constexpr uint32_t API_ENV_FLAGS_NO_TSD = 1U;
constexpr uint32_t SOC_VERSION_LEN = 50U;
constexpr uint32_t RT_DEFAULT_FLAG = 0U;

constexpr uint32_t INVALID_CHECK_KIND = 0U;
constexpr uint32_t WITHOUT_CHECK_KIND = 1U;
constexpr uint32_t CHECK_MEMORY_PINNED = 2U;
constexpr uint32_t NOT_CHECK_KIND_BUT_CHECK_PINNED = 3U;

constexpr uint32_t MEMCPY_DESC_SIZE = 32U;
constexpr uint32_t MEMCPY_DESC_SIZE_V2 = 64U;
constexpr uint32_t MEMCPY_DESC_LENGTH_OFFSET = 12U;

static inline uint64_t CalculateMemcpyAsyncSingleMaxSize(const rtMemcpyKind_t kind)
{
    uint64_t sqSize = MEMCPY_ASYNC_UNIT_SIZE;
    if ((kind == RT_MEMCPY_DEVICE_TO_DEVICE) || (kind == RT_MEMCPY_ADDR_DEVICE_TO_DEVICE)) {
        sqSize = MAX_MEMCPY_SIZE_OF_D2D;
    }

    // StarsV2片内D2D当前走的是SDMA，当前无法区分是片内，还是片间的D2D，因此这块先不拦截D2D。
    if (Runtime::Instance()->GetConnectUbFlag() && ((kind == RT_MEMCPY_HOST_TO_DEVICE) ||
        (kind == RT_MEMCPY_DEVICE_TO_HOST))) {
        sqSize = MEMCPY_ASYNC_UB_SIZE;
    } 
    return sqSize;
}

struct LaunchArgment {
    bool isConfig;
    bool smUsed;
    rtStream_t stm;
    rtSmDesc_t smDesc;
    uint32_t numBlocks;
    uint32_t argSize;
    char_t args[ARG_ENTRY_SIZE];
    uint16_t argsOffset[ARG_ENTRY_SIZE / MIN_ARG_SIZE];
    uint32_t argCount;
    const void *stubFunc;
};

#pragma pack(push)
#pragma pack (1)
struct rtProfTraceUserData {
    uint64_t id;
    uint64_t modelId;
    uint16_t tagId;
};
#pragma pack(pop)

class Stream;
class Event;
class Program;
class Context;
class Notify;
class DvppGrp;
class CountNotify;

// Runtime interface
class Api {
public:
    Api() = default;
    virtual ~Api() = default;

    Api(const Api &) = delete;
    Api &operator=(const Api &) = delete;
    Api(Api &&) = delete;
    Api &operator=(Api &&) = delete;

    // kernel API
    virtual rtError_t DevBinaryRegister(const rtDevBinary_t * const bin, Program ** const prog) = 0;
    virtual rtError_t GetNotifyAddress(Notify * const notify, uint64_t * const notifyAddress) = 0;
    virtual rtError_t RegisterAllKernel(const rtDevBinary_t * const bin, Program ** const prog) = 0;
    virtual rtError_t BinaryRegisterToFastMemory(Program * const prog) = 0;
    virtual rtError_t DevBinaryUnRegister(Program * const prog) = 0;
    virtual rtError_t BinaryLoad(const rtDevBinary_t * const bin, Program ** const prog) = 0;
    virtual rtError_t BinaryGetFunction(const Program * const prog, const uint64_t tilingKey,
                                        Kernel ** const funcHandle) = 0;
    virtual rtError_t BinaryLoadWithoutTilingKey(const void *data, const uint64_t length,
                                                 Program ** const prog) = 0;
    virtual rtError_t BinaryGetFunctionByName(const Program * const binHandle, const char *kernelName,
                                              Kernel ** const funcHandle) = 0;
    virtual rtError_t BinaryGetFunctionByEntry(const Program * const binHandle, const uint64_t funcEntry,
                                               Kernel ** const funcHandle) = 0;
    virtual rtError_t BinaryGetMetaInfo(Program * const binHandle, const rtBinaryMetaType type,  
                                        void *data, const uint32_t length) = 0;
    virtual rtError_t FunctionGetMetaInfo(const Kernel * const funcHandle, const rtFunctionMetaType type, 
                                          void *data, const uint32_t length) = 0;
    virtual rtError_t RegisterCpuFunc(rtBinHandle binHandle, const char_t * const funcName,
        const char_t * const kernelName, rtFuncHandle *funcHandle) = 0;
    virtual rtError_t LaunchKernel(Kernel * const kernel, uint32_t blockDim, const rtArgsEx_t * const argsInfo,
                                   Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo = nullptr) = 0;
    virtual rtError_t LaunchKernelV2(Kernel * const kernel, uint32_t blockDim, const RtArgsWithType * const argsWithType,
                                     Stream * const stm, const rtKernelLaunchCfg_t * const cfg = nullptr) = 0;
    virtual rtError_t LaunchKernelV3(Kernel * const kernel, const rtArgsEx_t * const argsInfo,
                                     Stream * const stm, const rtLaunchConfig_t * const launchConfig) = 0;
    virtual rtError_t BinaryUnLoad(Program * const binHandle) = 0;
    virtual rtError_t BinaryLoadFromFile(const char * const binPath, const rtLoadBinaryConfig_t * const optionalCfg,
                                         Program **handle) = 0;
    virtual rtError_t BinaryLoadFromData(const void * const data, const uint64_t length,
                                         const rtLoadBinaryConfig_t * const optionalCfg, Program **handle) = 0;
    virtual rtError_t FuncGetAddr(const Kernel * const funcHandle, void ** const aicAddr, void ** const aivAddr) = 0;
    virtual rtError_t FuncGetName(const Kernel * const kernel, const uint32_t maxLen, char_t * const name) = 0;
    virtual rtError_t MetadataRegister(Program * const prog, const char_t * const metadata) = 0;
    virtual rtError_t DependencyRegister(Program * const mProgram, Program * const sProgram) = 0;
    virtual rtError_t FunctionRegister(Program * const prog, const void * const stubFunc,
        const char_t * const stubName, const void * const kernelInfoExt, const uint32_t funcMode) = 0;
    virtual rtError_t GetFunctionByName(const char_t * const stubName, void ** const stubFunc) = 0;
    virtual rtError_t GetAddrByFun(const void * const stubFunc, void ** const addr) = 0;
    virtual rtError_t GetAddrAndPrefCntWithHandle(void * const hdl, const void * const kernelInfoExt,
                                                  void ** const addr, uint32_t * const prefetchCnt) = 0;
    virtual rtError_t KernelGetAddrAndPrefCnt(void * const hdl, const uint64_t tilingKey,
        const void * const stubFunc, const uint32_t flag, void ** const addr, uint32_t * const prefetchCnt) = 0;
    virtual rtError_t KernelGetAddrAndPrefCntV2(void * const hdl, const uint64_t tilingKey,
        const void * const stubFunc, const uint32_t flag, rtKernelDetailInfo_t * const kernelInfo) = 0;
    virtual rtError_t QueryFunctionRegistered(const char_t * const stubName) = 0;
    virtual rtError_t KernelLaunch(const void * const stubFunc, uint32_t coreDim,
        const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm, uint32_t flag,
        const rtTaskCfgInfo_t * const cfgInfo = nullptr, const bool isLaunchVec = false) = 0;
    virtual rtError_t KernelLaunchWithHandle(void * const hdl, const uint64_t tilingKey, const uint32_t coreDim,
        const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm,
        const rtTaskCfgInfo_t * const cfgInfo = nullptr, const bool isLaunchVec = false) = 0;
    virtual rtError_t KernelLaunchEx(const char_t * const opName, const void * const args, const uint32_t argsSize,
        const uint32_t flags, Stream * const stm) = 0;
    virtual rtError_t CpuKernelLaunch(const rtKernelLaunchNames_t * const launchNames, const uint32_t coreDim,
        const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm, const uint32_t flag) = 0;
    virtual rtError_t CpuKernelLaunchExWithArgs(const char_t * const opName, const uint32_t coreDim,
        const rtAicpuArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm, const uint32_t flag,
        const uint32_t kernelType) = 0;
    virtual rtError_t MultipleTaskInfoLaunch(const rtMultipleTaskInfo_t * const taskInfo, Stream * const stm,
        const uint32_t flag) = 0;
    virtual rtError_t DatadumpInfoLoad(const void * const dumpInfo, const uint32_t length, const uint32_t flag) = 0;
    virtual rtError_t AicpuInfoLoad(const void * const aicpuInfo, const uint32_t length) = 0;
    virtual rtError_t SetupArgument(const void * const setupArg, const uint32_t size, const uint32_t offset) = 0;
    virtual rtError_t KernelTransArgSet(const void * const ptr, const uint64_t size, const uint32_t flag,
        void ** const setupArg) = 0;
    virtual rtError_t KernelFusionStart(Stream * const stm) = 0;
    virtual rtError_t KernelFusionEnd(Stream * const stm) = 0;
    virtual rtError_t AppendLaunchAddrInfo(rtLaunchArgs_t* const hdl, void * const addrInfo) = 0;
    virtual rtError_t AppendLaunchHostInfo(rtLaunchArgs_t* const hdl, size_t const hostInfoSize,
        void ** const hostInfo)  = 0;
    virtual rtError_t DestroyLaunchArgs(rtLaunchArgs_t* argsHandle) = 0;
    virtual rtError_t ResetLaunchArgs(rtLaunchArgs_t* argsHandle) = 0;
    virtual rtError_t CalcLaunchArgsSize(size_t const argsSize, size_t const hostInfoTotalSize, size_t hostInfoNum,
                                         size_t * const launchArgsSize) = 0;
    virtual rtError_t CreateLaunchArgs(size_t const argsSize, size_t const hostInfoTotalSize, size_t hostInfoNum,
                                       void * const argsData, rtLaunchArgs_t ** const argsHandle) = 0;
    virtual rtError_t GetTaskBufferLen(const rtTaskBuffType_t type, uint32_t * const bufferLen) = 0;
    virtual rtError_t TaskSqeBuild(const rtTaskInput_t * const taskInput, uint32_t * const taskLen) = 0;
    virtual rtError_t GetKernelBin(const char_t *const binFileName, char_t **const buffer, uint32_t *length) = 0;
    virtual rtError_t GetBinBuffer(const rtBinHandle binHandle, const rtBinBufferType_t type, void **bin,
                                   uint32_t *binSize) = 0;
    virtual rtError_t GetStackBuffer(const rtBinHandle binHandle, const uint32_t coreType, const uint32_t coreId,
                                     const void **stack, uint32_t *stackSize) = 0;
    virtual rtError_t FreeKernelBin(char_t * const buffer) = 0;
    virtual rtError_t FusionLaunch(void * const fusionInfo, Stream * const stm, rtFusionArgsEx_t *argsInfo) = 0;

    // stream API
    virtual rtError_t StreamCreate(Stream ** const stm, const int32_t priority, const uint32_t flags, DvppGrp *grp) = 0;
    virtual rtError_t StreamDestroy(Stream * const stm, bool flag = true) = 0;
    virtual rtError_t StreamWaitEvent(Stream * const stm, Event * const evt, const uint32_t timeout = 0U) = 0;
    virtual rtError_t StreamSynchronize(Stream * const stm, const int32_t timeout = -1) = 0;
    virtual rtError_t StreamQuery(Stream * const stm) = 0;
    virtual rtError_t GetStreamId(Stream * const stm, int32_t * const streamId) = 0;
    virtual rtError_t GetSqId(Stream * const stm, uint32_t * const sqId) = 0;
    virtual rtError_t GetCqId(Stream * const stm, uint32_t * const cqId, uint32_t * const logicCqId) = 0;
    virtual rtError_t StreamSetMode(Stream * const stm, const uint64_t stmMode) = 0;
    virtual rtError_t StreamGetMode(const Stream * const stm, uint64_t * const stmMode) = 0;
    virtual rtError_t StreamBeginCapture(Stream * const stm, const rtStreamCaptureMode mode) = 0;
    virtual rtError_t StreamEndCapture(Stream * const stm, Model ** const captureMdl) = 0;
    virtual rtError_t StreamGetCaptureInfo(const Stream * const stm, rtStreamCaptureStatus * const status,
        Model ** const captureMdl) = 0;
    virtual rtError_t ThreadExchangeCaptureMode(rtStreamCaptureMode * const mode) = 0;
    virtual rtError_t StreamBeginTaskGrp(Stream * const stm) = 0;
    virtual rtError_t StreamEndTaskGrp(Stream * const stm, TaskGroup ** const handle) = 0;
    virtual rtError_t StreamBeginTaskUpdate(Stream * const stm, TaskGroup * handle) = 0;
    virtual rtError_t StreamEndTaskUpdate(Stream * const stm) = 0;
    virtual rtError_t SetStreamResLimit(Stream *const stm, const rtDevResLimitType_t type, const uint32_t value) = 0;
    virtual rtError_t ResetStreamResLimit(Stream *const stm) = 0;
    virtual rtError_t GetStreamResLimit(const Stream *const stm, const rtDevResLimitType_t type, uint32_t *const value) = 0;
    virtual rtError_t UseStreamResInCurrentThread(const Stream *const stm) = 0;
    virtual rtError_t NotUseStreamResInCurrentThread(const Stream *const stm) = 0;
    virtual rtError_t GetResInCurrentThread(const rtDevResLimitType_t type, uint32_t *const value) = 0;
    virtual rtError_t StreamGetPriority(Stream * const stm, uint32_t * const priority) = 0;
    virtual rtError_t StreamGetFlags(Stream * const stm, uint32_t * const flags) = 0;

    // event API
    virtual rtError_t EventCreate(Event ** const evt, const uint64_t flag) = 0;
    virtual rtError_t EventCreateEx(Event ** const evt, const uint64_t flag) = 0;
    virtual rtError_t EventDestroy(Event *evt) = 0;
    virtual rtError_t EventDestroySync(Event *evt) = 0;
    virtual rtError_t EventRecord(Event * const evt, Stream * const stm) = 0;
    virtual rtError_t EventCreateForNotify(Event ** const evt) = 0;
    virtual rtError_t EventRecordForNotify(Event * const evt, Stream * const stm) = 0;
    virtual rtError_t EventReset(Event * const evt, Stream * const stm) = 0;
    virtual rtError_t EventSynchronize(Event * const evt, const int32_t timeout = -1) = 0;
    virtual rtError_t EventQuery(Event * const evt) = 0;
    virtual rtError_t EventQueryStatus(Event * const evt, rtEventStatus_t * const status) = 0;
    virtual rtError_t EventQueryWaitStatus(Event * const evt, rtEventWaitStatus_t * const status) = 0;
    virtual rtError_t EventElapsedTime(float32_t * const retTime, Event * const startEvt, Event * const endEvt) = 0;
    virtual rtError_t EventGetTimeStamp(uint64_t * const retTime, Event * const evt) = 0;
    virtual rtError_t GetEventID(Event * const evt, uint32_t * const evtId) = 0;
    virtual rtError_t IpcGetEventHandle(IpcEvent * const evt, rtIpcEventHandle_t *handle) = 0;
    virtual rtError_t IpcOpenEventHandle(rtIpcEventHandle_t *handle, IpcEvent** const event) = 0;
    // memory API
    virtual rtError_t DevMalloc(void ** const devPtr, const uint64_t size, const rtMemType_t type,
        const uint16_t moduleId = MODULEID_RUNTIME) = 0;
    virtual rtError_t DevFree(void * const devPtr) = 0;
    virtual rtError_t DevDvppMalloc(void ** const devPtr, const uint64_t size, const uint32_t flag,
        const uint16_t moduleId = MODULEID_RUNTIME) = 0;
    virtual rtError_t DevDvppFree(void * const devPtr) = 0;
    virtual rtError_t HostMalloc(void ** const hostPtr, const uint64_t size,
        const uint16_t moduleId = MODULEID_RUNTIME) = 0;
    virtual rtError_t HostMallocWithCfg(void ** const hostPtr, const uint64_t size,
        const rtMallocConfig_t *cfg = nullptr) = 0;
    virtual rtError_t HostFree(void * const hostPtr) = 0;
    virtual rtError_t MallocHostSharedMemory(rtMallocHostSharedMemoryIn * const in,
        rtMallocHostSharedMemoryOut * const out) = 0;
    virtual rtError_t FreeHostSharedMemory(rtFreeHostSharedMemoryIn * const in) = 0;
    virtual rtError_t HostRegister(void *ptr, uint64_t size, rtHostRegisterType type, void **devPtr) = 0;
    virtual rtError_t HostRegisterV2(void *ptr, uint64_t size, uint32_t flag) = 0;
    virtual rtError_t HostGetDevicePointer(void *pHost, void **pDevice, uint32_t flag) = 0;
    virtual rtError_t HostUnregister(void *ptr) = 0;
    virtual rtError_t HostMemMapCapabilities(uint32_t deviceId, rtHacType hacType, rtHostMemMapCapability *capabilities) = 0;
    virtual rtError_t ManagedMemAlloc(void ** const ptr, const uint64_t size, const uint32_t flag,
        const uint16_t moduleId = MODULEID_RUNTIME) = 0;
    virtual rtError_t ManagedMemFree(const void * const ptr) = 0;
    virtual rtError_t MemAdvise(void *devPtr, uint64_t count, uint32_t advise) = 0;
    virtual rtError_t DevMallocCached(void ** const devPtr, const uint64_t size, const rtMemType_t type,
        const uint16_t moduleId = MODULEID_RUNTIME) = 0;
    virtual rtError_t FlushCache(const uint64_t base, const size_t len) = 0;
    virtual rtError_t InvalidCache(const uint64_t base, const size_t len) = 0;
    virtual rtError_t MemCopySync(void * const dst, uint64_t destMax, const void * const src, const uint64_t cnt,
        const rtMemcpyKind_t kind, const uint32_t checkKind = INVALID_CHECK_KIND) = 0;
    virtual rtError_t MemCopySyncEx(void * const dst, uint64_t destMax, const void * const src, const uint64_t cnt,
                                    const rtMemcpyKind_t kind) = 0;
    virtual rtError_t MemcpyAsync(void * const dst, uint64_t destMax, const void * const src, const uint64_t cnt,
        const rtMemcpyKind_t kind, Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo = nullptr,
        const rtD2DAddrCfgInfo_t * const addrCfg = nullptr, bool checkKind = true, const rtMemcpyConfig_t * const memcpyConfig = nullptr) = 0;
    virtual rtError_t LaunchSqeUpdateTask(uint32_t streamId, uint32_t taskId, void *src, uint64_t cnt,
                                          Stream * const stm, bool needCpuTask = false) = 0;
    virtual rtError_t MemcpyAsyncPtr(void * const memcpyAddrInfo, const uint64_t destMax,
        const uint64_t count, Stream *stm, const rtTaskCfgInfo_t * const cfgInfo = nullptr, const bool isMemcpyDesc = false) = 0;
    virtual rtError_t ReduceAsync(void * const dst, const void * const src, const uint64_t cnt,
        const rtRecudeKind_t kind, const rtDataType_t type, Stream * const stm,
        const rtTaskCfgInfo_t * const cfgInfo = nullptr) = 0;
    virtual rtError_t ReduceAsyncV2(void * const dst, const void * const src, const uint64_t cnt,
        const rtRecudeKind_t kind, const rtDataType_t type, Stream * const stm, void * const overflowAddr) = 0;
    virtual rtError_t MemSetSync(const void * const devPtr, const uint64_t destMax, const uint32_t val,
        const uint64_t cnt) = 0;
    virtual rtError_t MemsetAsync(void * const ptr, const uint64_t destMax, const uint32_t val, const uint64_t cnt,
        Stream * const stm) = 0;
    virtual rtError_t MemGetInfoByDeviceId(uint32_t deviceId, bool isHugeOnly, size_t* const freeSize, size_t* const totalSize) = 0;
    virtual rtError_t MemGetInfo(size_t * const freeSize, size_t * const totalSize) = 0;
    virtual rtError_t MemGetInfoByType(const int32_t devId, const rtMemType_t type, rtMemInfo_t * const info) = 0;
    virtual rtError_t CheckMemType(void **addrs, uint32_t size, uint32_t memType, uint32_t *checkResult, uint32_t reserve) = 0;
    virtual rtError_t GetMemUsageInfo(const uint32_t deviceId, rtMemUsageInfo_t * const memUsageInfo,
                                      const size_t inputNum, size_t * const outputNum) = 0;
    virtual rtError_t MemGetInfoEx(const rtMemInfoType_t memInfoType, size_t * const freeSize,
        size_t * const totalSize) = 0;
    virtual rtError_t PointerGetAttributes(rtPointerAttributes_t * const attributes, const void * const ptr) = 0;
    virtual rtError_t PtrGetAttributes(const void * const ptr, rtPtrAttributes_t  * const attributes) = 0;
    virtual rtError_t MemPrefetchToDevice(const void * const devPtr, const uint64_t len, const int32_t devId) = 0;
    virtual rtError_t MemCopy2DSync(void * const dst, const uint64_t dstPitch, const void * const src,
        const uint64_t srcPitch, const uint64_t width, const uint64_t height,
        const rtMemcpyKind_t kind = RT_MEMCPY_RESERVED, const rtMemcpyKind newKind = RT_MEMCPY_KIND_MAX) = 0;
    virtual rtError_t MemCopy2DAsync(void * const dst, const uint64_t dstPitch, const void * const src,
        const uint64_t srcPitch, const uint64_t width, const uint64_t height, Stream * const stm,
        const rtMemcpyKind_t kind = RT_MEMCPY_RESERVED, const rtMemcpyKind newKind = RT_MEMCPY_KIND_MAX) = 0;
    virtual rtError_t MemcpyHostTask(void * const dst, const uint64_t destMax, const void * const src,
        const uint64_t cnt, const rtMemcpyKind_t kind, Stream * const stm) = 0;
    virtual rtError_t GetDevArgsAddr(Stream *stm, rtArgsEx_t *argsInfo, void **devArgsAddr, void **argsHandle) = 0;
    virtual rtError_t ReserveMemAddress(void** devPtr, size_t size, size_t alignment, void *devAddr,
        uint64_t flags) = 0;
    virtual rtError_t ReleaseMemAddress(void* devPtr) = 0;
    virtual rtError_t MallocPhysical(rtDrvMemHandle* handle, size_t size, rtDrvMemProp_t* prop,
        uint64_t flags) = 0;
    virtual rtError_t FreePhysical(rtDrvMemHandle handle) = 0;
    virtual rtError_t MapMem(void* devPtr, size_t size, size_t offset, rtDrvMemHandle handle, uint64_t flags) = 0;
    virtual rtError_t UnmapMem(void* devPtr) = 0;
    virtual rtError_t MemSetAccess(void *virPtr, size_t size, rtMemAccessDesc *desc, size_t count) = 0;
    virtual rtError_t MemGetAccess(void *virPtr, rtMemLocation *location, uint64_t *flags) = 0;
    virtual rtError_t ExportToShareableHandle(rtDrvMemHandle handle, rtDrvMemHandleType handleType,
        uint64_t flags, uint64_t *shareableHandle) = 0;
    virtual rtError_t ExportToShareableHandleV2(
        rtDrvMemHandle handle, rtMemSharedHandleType handleType, uint64_t flags, void *shareableHandle) = 0;
    virtual rtError_t ImportFromShareableHandle(uint64_t shareableHandle, int32_t devId, rtDrvMemHandle *handle) = 0;
    virtual rtError_t ImportFromShareableHandleV2(const void *shareableHandle, rtMemSharedHandleType handleType,
        uint64_t flags, int32_t devId, rtDrvMemHandle *handle) = 0;
    virtual rtError_t SetPidToShareableHandle(uint64_t shareableHandle, int32_t pid[], uint32_t pidNum) = 0;
    virtual rtError_t SetPidToShareableHandleV2(
        const void *shareableHandle, rtMemSharedHandleType handleType, int32_t pid[], uint32_t pidNum) = 0;
    virtual rtError_t GetAllocationGranularity(rtDrvMemProp_t *prop, rtDrvMemGranularityOptions option, size_t *granularity) = 0;
    virtual rtError_t RtsMemcpyAsync(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cnt,
        const rtMemcpyKind kind, rtMemcpyConfig_t * const config, Stream * const stm) = 0;
    virtual rtError_t RtsMemcpy(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cnt,
        const rtMemcpyKind kind, rtMemcpyConfig_t * const config) = 0;
    virtual rtError_t SetMemcpyDesc(rtMemcpyDesc_t desc, const void * const srcAddr, const void * const dstAddr,
        const size_t count, const rtMemcpyKind kind, rtMemcpyConfig_t * const config) = 0;
    virtual rtError_t MemcpyAsyncWithDesc(rtMemcpyDesc_t desc, Stream *stm, const rtMemcpyKind kind, rtMemcpyConfig_t * const config) = 0;
    virtual rtError_t MemReserveAddress(void** virPtr, size_t size, rtMallocPolicy policy, void *expectAddr, rtMallocConfig_t *cfg) = 0;
    virtual rtError_t MemMallocPhysical(rtMemHandle* handle, size_t size, rtMallocPolicy policy, rtMallocConfig_t *cfg) = 0;
    virtual rtError_t MemRetainAllocationHandle(void* virPtr, rtDrvMemHandle *handle) = 0;
    virtual rtError_t MemGetAllocationPropertiesFromHandle(rtDrvMemHandle handle, rtDrvMemProp_t* prop) = 0;
    // new memory API
    virtual rtError_t DevMalloc(void ** const devPtr, const uint64_t size, rtMallocPolicy policy, rtMallocAdvise advise, const rtMallocConfig_t * const cfg) = 0;
    virtual rtError_t MemWriteValue(const void * const devAddr, const uint64_t value, const uint32_t flag, Stream * const stm) = 0;
    virtual rtError_t MemWaitValue(const void * const devAddr, const uint64_t value, const uint32_t flag, Stream * const stm) = 0;
    virtual rtError_t MemcpyBatch(void **dsts, void **srcs, size_t *sizes, size_t count,
        rtMemcpyBatchAttr *attrs, size_t *attrsIdxs, size_t numAttrs, size_t *failIdx) = 0;
    virtual rtError_t MemcpyBatchAsync(void** const dsts, const size_t* const destMaxs,  void** const srcs, const size_t* const sizes,
        const size_t count, const rtMemcpyBatchAttr* const attrs, const size_t* const attrsIdxs, const size_t numAttrs, size_t* const failIdx,
        Stream* const stm) = 0;

    // device API
    virtual rtError_t GetDeviceStatus(const int32_t devId, rtDevStatus_t * const status) = 0;
    virtual rtError_t SetDeviceResLimit(const uint32_t devId, const rtDevResLimitType_t type, uint32_t value) = 0;
    virtual rtError_t ResetDeviceResLimit(const uint32_t devId) = 0;
    virtual rtError_t GetDeviceResLimit(const uint32_t devId, const rtDevResLimitType_t type, uint32_t* value) = 0;
    virtual rtError_t HdcServerCreate(const int32_t devId, const rtHdcServiceType_t type,
        rtHdcServer_t * const server) = 0;
    virtual rtError_t HdcServerDestroy(rtHdcServer_t const server) = 0;
    virtual rtError_t HdcSessionConnect(const int32_t peerNode, const int32_t peerDevId, rtHdcClient_t const client,
        rtHdcSession_t * const session) = 0;
    virtual rtError_t HdcSessionClose(rtHdcSession_t const session) = 0;
    virtual rtError_t GetHostCpuDevId(int32_t * const devId) = 0;
    virtual rtError_t GetDeviceCount(int32_t * const cnt) = 0;
    virtual rtError_t OpenNetService(const rtNetServiceOpenArgs *args) = 0;
    virtual rtError_t CloseNetService() = 0;
    virtual rtError_t GetDeviceIDs(uint32_t * const devId, uint32_t len) = 0;
    virtual rtError_t SetDevice(const int32_t devId) = 0;
    virtual rtError_t GetDevice(int32_t * const devId) = 0;
    virtual rtError_t GetDevicePhyIdByIndex(const uint32_t devIndex, uint32_t * const phyId) = 0;
    virtual rtError_t GetDeviceIndexByPhyId(const uint32_t phyId, uint32_t * const devIndex) = 0;
    virtual rtError_t DeviceReset(const int32_t devId, const bool isForceReset = false) = 0;
    virtual rtError_t DeviceSetLimit(const int32_t devId, const rtLimitType_t type, const uint32_t val) = 0;
    virtual rtError_t DeviceSynchronize(const int32_t timeout = -1) = 0;
    virtual rtError_t DeviceTaskAbort(const int32_t devId, const uint32_t timeout) = 0;
    virtual rtError_t SnapShotProcessLock() = 0;
 	virtual rtError_t SnapShotProcessUnlock() = 0;
    virtual rtError_t SnapShotProcessBackup() = 0;
    virtual rtError_t SnapShotProcessRestore() = 0;
    virtual rtError_t SnapShotCallbackRegister(rtSnapShotStage stage, rtSnapShotCallBack callback, void *args) = 0;
 	virtual rtError_t SnapShotCallbackUnregister(rtSnapShotStage stage, rtSnapShotCallBack callback) = 0;
    virtual rtError_t DeviceGetStreamlist(int32_t devId, rtStreamlistType_t type, rtStreamlist_t *stmList) = 0;
    virtual rtError_t DeviceGetModelList(int32_t devId, rtModelList_t *mdlList) = 0;
    virtual rtError_t DeviceGetStreamPriorityRange(int32_t * const leastPriority, int32_t * const greatestPriority) = 0;
    virtual rtError_t GetDeviceInfo(const uint32_t deviceId, const int32_t moduleType, const int32_t infoType,
        int64_t * const val) = 0;
    virtual rtError_t GetDeviceInfoFromPlatformInfo(const uint32_t deviceId, const std::string &label,
        const std::string &key, int64_t * const value) = 0;
    virtual rtError_t GetDeviceInfoByAttr(uint32_t deviceId, rtDevAttr attr, int64_t *val) = 0;
    virtual rtError_t GetPhyDeviceInfo(const uint32_t phyId, const int32_t moduleType, const int32_t infoType,
        int64_t * const val) = 0;
    virtual rtError_t DeviceSetTsId(const uint32_t tsId) = 0;
    virtual rtError_t EnableP2P(const uint32_t devIdDes, const uint32_t phyIdSrc, const uint32_t flag) = 0;
    virtual rtError_t DisableP2P(const uint32_t devIdDes, const uint32_t phyIdSrc) = 0;
    virtual rtError_t DeviceCanAccessPeer(int32_t * const canAccessPeer, const uint32_t devId,
        const uint32_t peerDevice) = 0;
    virtual rtError_t GetP2PStatus(const uint32_t devIdDes, const uint32_t phyIdSrc, uint32_t * const status) = 0;
    virtual rtError_t DeviceGetBareTgid(uint32_t * const pid) = 0;
    virtual rtError_t GetPairDevicesInfo(const uint32_t devId, const uint32_t otherDevId, const int32_t infoType,
        int64_t * const val) = 0;
    virtual rtError_t GetPairPhyDevicesInfo(const uint32_t devId, const uint32_t otherDevId, const int32_t infoType,
        int64_t * const val) = 0;
    virtual rtError_t GetRtCapability(const rtFeatureType_t featureType, const int32_t featureInfo,
        int64_t * const val) = 0;
    virtual rtError_t GetDeviceCapability(const int32_t deviceId,
        const int32_t moduleType, const int32_t featureType, int32_t * const val) = 0;
    virtual rtError_t GetDevMsg(const rtGetDevMsgType_t getMsgType, const rtGetMsgCallback callback) = 0;
    virtual rtError_t ModelCheckArchVersion(const char_t *omArchVersion, const rtArchType_t archType) = 0;
    virtual rtError_t DeviceStatusQuery(const uint32_t devId, rtDeviceStatus *deviceStatus) = 0;
    virtual rtError_t GetFaultEvent(const int32_t deviceId, rtDmsEventFilter *filter, rtDmsFaultEvent *dmsEvent,
        uint32_t len, uint32_t *eventCount) = 0;
    virtual rtError_t GetMemUceInfo(const uint32_t deviceId, rtMemUceInfo *memUceInfo) = 0;
    virtual rtError_t MemUceRepair(const uint32_t deviceId, rtMemUceInfo *memUceInfo) = 0;
    virtual rtError_t DeviceResourceClean(const int32_t devId) = 0;
    virtual rtError_t SetDefaultDeviceId (const int32_t deviceId) = 0;
    virtual rtError_t DeviceResetForce(const int32_t devId) = 0;
    virtual rtError_t SetDeviceFailureMode(uint64_t failureMode) = 0;
    virtual rtError_t GetLastErr(rtLastErrLevel_t level) = 0;
    virtual rtError_t PeekLastErr(rtLastErrLevel_t level) = 0;
    virtual rtError_t GetLogicDevIdByUserDevId(const int32_t userDevId, int32_t * const logicDevId) = 0;
    virtual rtError_t GetUserDevIdByLogicDevId(const int32_t logicDevId, int32_t * const userDevId) = 0;
    virtual rtError_t SetXpuDevice(rtXpuDevType devType, const uint32_t devId) = 0;
    virtual rtError_t ResetXpuDevice(rtXpuDevType devType, const uint32_t devId) = 0;
    virtual rtError_t GetDeviceUuid(const int32_t devId, rtUuid_t *uuid) = 0;

    // context
    virtual rtError_t ContextCreate(Context ** const inCtx, const int32_t devId) = 0;
    virtual rtError_t ContextDestroy(Context * const inCtx) = 0;
    virtual rtError_t ContextSetCurrent(Context * const inCtx) = 0;
    virtual rtError_t ContextGetCurrent(Context ** const inCtx) = 0;
    virtual rtError_t ContextGetDevice(int32_t * const devId) = 0;
    virtual rtError_t ContextSetINFMode(const bool infMode) = 0;
    virtual rtError_t CtxGetCurrentDefaultStream(Stream ** const stm) = 0;
    virtual rtError_t GetPrimaryCtxState(const int32_t devId, uint32_t *flags, int32_t *active) = 0;

    // resource name
    virtual rtError_t NameStream(Stream * const stm, const char_t * const name) = 0;
    virtual rtError_t NameEvent(Event * const evt, const char_t * const name) = 0;

    virtual rtError_t ProfilerStart(const uint64_t profConfig, const int32_t numsDev,
        uint32_t * const deviceList, const uint32_t cacheFlag, const uint64_t profSwitchHi = 0) = 0;
    virtual rtError_t ProfilerStop(const uint64_t profConfig, const int32_t numsDev, uint32_t * const deviceList, const uint64_t profSwitchHi = 0) = 0;
    virtual rtError_t GetBinaryDeviceBaseAddr(const Program * const prog, void **deviceBase) = 0;
    virtual rtError_t ProfilerTrace(const uint64_t id, const bool notifyFlag, const uint32_t flags,
        Stream * const stm) = 0;
    virtual rtError_t ProfilerTraceEx(const uint64_t id, const uint64_t modelId, const uint16_t tagId,
        Stream * const stm) = 0;

    virtual rtError_t StartOnlineProf(Stream * const stm, const uint32_t sampleNum) = 0;
    virtual rtError_t StopOnlineProf(Stream * const stm) = 0;
    virtual rtError_t GetOnlineProfData(Stream * const stm, rtProfDataInfo_t * const pProfData,
        const uint32_t profDataNum) = 0;
    virtual rtError_t AdcProfiler(const uint64_t addr, const uint32_t length) = 0;
    virtual rtError_t SetMsprofReporterCallback(const MsprofReporterCallback callback) = 0;

    // inquire information
    virtual rtError_t GetMaxStreamAndTask(const uint32_t streamType, uint32_t * const maxStrCount,
        uint32_t * const maxTaskCount) = 0;
    virtual rtError_t GetAvailStreamNum(const uint32_t streamType, uint32_t * const streamCount) = 0;
    virtual rtError_t GetFreeStreamNum(uint32_t * const streamCount) = 0;
    virtual rtError_t GetAvailEventNum(uint32_t * const eventCount) = 0;
    virtual rtError_t GetTaskIdAndStreamID(uint32_t * const taskId, uint32_t * const streamId) = 0;
    virtual rtError_t GetMaxModelNum(uint32_t * const maxModelCount) = 0;

    // model
    virtual rtError_t ModelCreate(Model ** const mdl, uint32_t flag) = 0;
    virtual rtError_t ModelSetExtId(Model * const mdl, uint32_t extId) = 0;
    virtual rtError_t ModelDestroy(Model * const mdl) = 0;
    virtual rtError_t ModelBindStream(Model * const mdl, Stream * const stm, const uint32_t flag) = 0;
    virtual rtError_t ModelUnbindStream(Model * const mdl, Stream * const stm) = 0;
    virtual rtError_t ModelLoadComplete(Model * const mdl) = 0;
    virtual rtError_t ModelExecute(Model * const mdl, Stream * const stm, const uint32_t flag,
        int32_t timeout = -1) = 0;
    virtual rtError_t ModelExecuteSync(Model * const mdl, int32_t timeout = -1) = 0;
    virtual rtError_t ModelExecuteAsync(Model * const mdl, Stream * const stm) = 0;
    virtual rtError_t ModelGetTaskId(Model * const mdl, uint32_t * const taskId, uint32_t * const streamId) = 0;
    virtual rtError_t ModelGetId(Model * const mdl, uint32_t * const modelId) = 0;
    virtual rtError_t ModelEndGraph(Model * const mdl, Stream * const stm, const uint32_t flags) = 0;
    virtual rtError_t ModelExecutorSet(Model * const mdl, const uint8_t flags) = 0;
    virtual rtError_t ModelAbort(Model * const mdl) = 0;
    virtual rtError_t ModelExit(Model * const mdl, Stream * const stm) = 0;
    virtual rtError_t ModelBindQueue(Model * const mdl, const uint32_t queueId, const rtModelQueueFlag_t flag) = 0;
    virtual rtError_t ModelNameSet(Model * const mdl, const char_t * const name) = 0;
    virtual rtError_t ModelGetName(Model * const mdl, const uint32_t maxLen, char_t * const mdlName) = 0;
    virtual rtError_t DebugRegister(Model * const mdl, const uint32_t flag, const void * const addr,
        uint32_t * const streamId, uint32_t * const taskId) = 0;
    virtual rtError_t DebugUnRegister(Model * const mdl) = 0;
    virtual rtError_t DebugRegisterForStream(Stream * const stm, const uint32_t flag, const void * const addr,
        uint32_t * const streamId, uint32_t * const taskId) = 0;
    virtual rtError_t DebugUnRegisterForStream(Stream * const stm) = 0;
    virtual rtError_t ModelSetSchGroupId(Model * const mdl, const int16_t schGrpId) = 0;
    virtual rtError_t ModelTaskUpdate(Stream *desStm, uint32_t desTaskId, Stream *sinkStm,
                                      rtMdlTaskUpdateInfo_t *para) = 0;
    virtual rtError_t ModelGetNodes(const Model * const mdl, uint32_t * const num) = 0;
    virtual rtError_t ModelDebugDotPrint(const Model * const mdl) = 0;
    virtual rtError_t ModelDebugJsonPrint(const Model * const mdl, const char* path, const uint32_t flags) = 0;
    virtual rtError_t StreamAddToModel(Stream * const stm, Model * const captureMdl) = 0;

    /* hardware Info */
    virtual rtError_t GetAiCoreCount(uint32_t * const aiCoreCnt) = 0;
    virtual rtError_t GetAiCpuCount(uint32_t * const aiCpuCnt) = 0;
    virtual rtError_t SetDeviceSatMode(const rtFloatOverflowMode_t floatOverflowMode) = 0;
    virtual rtError_t GetDeviceSatMode(rtFloatOverflowMode_t * const floatOverflowMode) = 0;
    virtual rtError_t GetDeviceSatModeForStream(Stream * const stm,
        rtFloatOverflowMode_t * const floatOverflowMode) = 0;
    virtual rtError_t SetStreamOverflowSwitch(Stream * const stm, const uint32_t flags) = 0;
    virtual rtError_t GetStreamOverflowSwitch(Stream * const stm, uint32_t * const flags) = 0;
    virtual rtError_t SetExceptCallback(const rtErrorCallback callback) = 0;
    virtual rtError_t SetTaskAbortCallBack(const char_t *regName, void *callback, void *args,
        TaskAbortCallbackType type) = 0;
    virtual rtError_t SetTaskFailCallback(void *callback, void *args, TaskFailCallbackType type) = 0;
    virtual rtError_t RegDeviceStateCallback(const char_t *regName, void *callback, void *args,
        DeviceStateCallback type, rtDevCallBackDir_t notifyPos = DEV_CB_POS_BACK) = 0;
    virtual rtError_t RegProfCtrlCallback(const uint32_t moduleId, const rtProfCtrlHandle callback) = 0;
    virtual rtError_t RegTaskFailCallbackByModule(const char_t *regName, void *callback, void *args,
        TaskFailCallbackType type) = 0;
    virtual rtError_t RegStreamStateCallback(const char_t *regName, void *callback, void *args,
        StreamStateCallback type) = 0;
    // IPC API
    virtual rtError_t IpcSetMemoryName(const void * const ptr, const uint64_t byteCount, char_t * const name,
        const uint32_t len, const uint64_t flags = 0UL) = 0;
    virtual rtError_t IpcSetMemoryAttr(const char *name, uint32_t type, uint64_t attr) = 0;
    virtual rtError_t IpcOpenMemory(void ** const ptr, const char_t * const name, const uint64_t flags = 0UL) = 0;
    virtual rtError_t NopTask(Stream * const stm) = 0;
    virtual rtError_t IpcCloseMemory(const void * const ptr) = 0;
    virtual rtError_t IpcCloseMemoryByName(const char_t * const name) = 0;
    virtual rtError_t IpcDestroyMemoryName(const char_t * const name) = 0;
    virtual rtError_t SetIpcNotifyPid(const char_t * const name, int32_t pid[], const int32_t num) = 0;
    virtual rtError_t SetIpcMemPid(const char_t * const name, int32_t pid[], const int32_t num) = 0;
    virtual rtError_t RDMASend(const uint32_t sqIndex, const uint32_t wqeIndex, Stream * const stm) = 0;
    virtual rtError_t RdmaDbSend(const uint32_t dbIndex, const uint64_t dbInfo, Stream * const stm) = 0;

    // Notify api
    virtual rtError_t NotifyCreate(const int32_t deviceId, Notify ** const retNotify,
        uint64_t flag = RT_NOTIFY_FLAG_DEFAULT) = 0;
    virtual rtError_t NotifyDestroy(Notify * const inNotify) = 0;
    virtual rtError_t NotifyRecord(Notify * const inNotify, Stream * const stm) = 0;
    virtual rtError_t NotifyReset(Notify * const inNotify) = 0;
    virtual rtError_t ResourceClean(int32_t devId, rtIdType_t type) = 0;
    virtual rtError_t NotifyWait(Notify * const inNotify, Stream * const stm, const uint32_t timeOut) = 0;
    virtual rtError_t GetNotifyID(Notify * const inNotify, uint32_t * const notifyID) = 0;
    virtual rtError_t GetNotifyPhyInfo(Notify *const inNotify, rtNotifyPhyInfo *notifyInfo) = 0;
    virtual rtError_t IpcSetNotifyName(
        Notify *const inNotify, char_t *const name, const uint32_t len, const uint64_t flag = 0UL) = 0;
    virtual rtError_t IpcOpenNotify(
        Notify **const retNotify, const char_t *const name, uint32_t flag = RT_NOTIFY_FLAG_DEFAULT) = 0;
    virtual rtError_t NotifyGetAddrOffset(Notify * const inNotify, uint64_t * const devAddrOffset) = 0;
    virtual rtError_t WriteValuePtr(void * const writeValueInfo, Stream * const stm, void * const pointedAddr) = 0;

    // CntNotify api
    virtual rtError_t CntNotifyCreate(const int32_t deviceId, CountNotify ** const retCntNotify,
                                      const uint32_t flag = RT_NOTIFY_FLAG_DEFAULT) = 0;
    virtual rtError_t CntNotifyDestroy(CountNotify * const inCntNotify) = 0;
    virtual rtError_t CntNotifyRecord(CountNotify * const inCntNotify, Stream * const stm,
                                      const rtCntNtyRecordInfo_t * const info) = 0;
    virtual rtError_t CntNotifyWaitWithTimeout(CountNotify * const inCntNotify, Stream * const stm,
                                               const rtCntNtyWaitInfo_t * const info) = 0;
    virtual rtError_t CntNotifyReset(CountNotify * const inCntNotify, Stream * const stm) = 0;
    virtual rtError_t GetCntNotifyAddress(CountNotify *const inCntNotify, uint64_t * const cntNotifyAddress,
        rtNotifyType_t const regType) = 0;
    virtual rtError_t GetCntNotifyId(CountNotify *inCntNotify, uint32_t * const notifyId) = 0;
    virtual rtError_t WriteValue(rtWriteValueInfo_t * const info, Stream * const stm) = 0;

    // CCU Launch
    virtual rtError_t CCULaunch(rtCcuTaskInfo_t *taskInfo,  Stream * const stm) = 0;
    virtual rtError_t UbDevQueryInfo(rtUbDevQueryCmd cmd, void *devInfo) = 0;
    virtual rtError_t GetDevResAddress(const rtDevResInfo * const resInfo, rtDevResAddrInfo * const addrInfo) = 0;
    virtual rtError_t ReleaseDevResAddress(rtDevResInfo * const resInfo) = 0;

    // switch api
    virtual rtError_t StreamSwitchEx(void * const ptr, const rtCondition_t condition, void * const valuePtr,
        Stream * const trueStream, Stream * const stm, const rtSwitchDataType_t dataType) = 0;
    virtual rtError_t StreamActive(Stream * const activeStream, Stream * const stm) = 0;

    virtual rtError_t StreamSwitchN(void * const ptr, const uint32_t size, void * const valuePtr,
        Stream ** const trueStreamPtr, const uint32_t elementSize, Stream * const stm,
        const rtSwitchDataType_t dataType) = 0;

    // label API
    virtual rtError_t LabelCreate(Label ** const lbl, Model * const mdl) = 0;
    virtual rtError_t LabelDestroy(Label * const lbl) = 0;
    virtual rtError_t LabelSet(Label * const lbl, Stream * const stm) = 0;
    virtual rtError_t LabelGoto(Label * const lbl, Stream * const stm) = 0;

    // callback api
    virtual rtError_t SubscribeReport(const uint64_t threadId, Stream * const stm) = 0;
    virtual rtError_t CallbackLaunch(const rtCallback_t callBackFunc, void * const fnData, Stream * const stm,
        const bool isBlock) = 0;
    virtual rtError_t ProcessReport(const int32_t timeout, const bool noLog = false) = 0;
    virtual rtError_t UnSubscribeReport(const uint64_t threadId, Stream * const stm) = 0;
    virtual rtError_t GetRunMode(rtRunMode * const runMode) = 0;
    virtual rtError_t GetAicpuDeploy(rtAicpuDeployType_t * const deployType) = 0;

    // stream label func
    virtual ::rtError_t LabelSwitchByIndex(void * const ptr, const uint32_t maxVal, void * const labelInfoPtr,
        Stream * const stm) = 0;
    virtual ::rtError_t LabelGotoEx(Label * const lbl, Stream * const stm) = 0;
    virtual ::rtError_t LabelListCpy(Label ** const lbl, const uint32_t labelNumber, void * const dst,
        const uint32_t dstMax) = 0;
    virtual ::rtError_t LabelCreateEx(Label ** const lbl, Model * const mdl, Stream * const stm) = 0;
    virtual rtError_t LabelSwitchListCreate(Label ** const labels, const size_t num, void ** const labelList) = 0;

    virtual rtError_t SetGroup(const int32_t groupId) = 0;
    virtual rtError_t GetGroupCount(uint32_t * const cnt) = 0;
    virtual rtError_t GetGroupInfo(const int32_t groupId, rtGroupInfo_t * const groupInfo, const uint32_t cnt) = 0;

    // set task timeout time
    virtual rtError_t SetOpWaitTimeOut(const uint32_t timeout) = 0;
    virtual rtError_t SetOpExecuteTimeOut(const uint32_t timeout, const RtTaskTimeUnitType timeUnitType) = 0;
    virtual rtError_t GetOpExecuteTimeOut(uint32_t * const timeout) = 0;
    virtual rtError_t GetOpExecuteTimeoutV2(uint32_t *const timeout) = 0;
    virtual rtError_t CheckArchCompatibility(const char_t *omSocVersion, int32_t *canCompatible) = 0;
    virtual rtError_t GetOpTimeOutInterval(uint64_t *interval) = 0;
    virtual rtError_t SetOpExecuteTimeOutV2(uint64_t timeout, uint64_t *actualTimeout) = 0;

    virtual rtError_t StarsTaskLaunch(const void * const sqe, const uint32_t sqeLen, Stream * const stm,
        const uint32_t flag) = 0;
    virtual rtError_t FftsPlusTaskLaunch(const rtFftsPlusTaskInfo_t * const fftsPlusTaskInfo, Stream * const stm,
        const uint32_t flag) = 0;
    virtual rtError_t NpuGetFloatStatus(void * const outputAddrPtr, const uint64_t outputSize, const uint32_t checkMode,
        Stream * const stm) = 0;
    virtual rtError_t NpuClearFloatStatus(const uint32_t checkMode, Stream * const stm) = 0;
    virtual rtError_t NpuGetFloatDebugStatus(void * const outputAddrPtr, const uint64_t outputSize,
                                             const uint32_t checkMode, Stream * const stm) = 0;
    virtual rtError_t NpuClearFloatDebugStatus(const uint32_t checkMode, Stream * const stm) = 0;

    // C/V Synchronize data between cores
    virtual rtError_t GetC2cCtrlAddr(uint64_t * const addr, uint32_t * const len) = 0;

    virtual rtError_t GetL2CacheOffset(uint32_t deviceId, uint64_t *offset) = 0;

    // mbuff queue api
    virtual rtError_t MemQueueInitQS(const int32_t devId, const char_t * const grpName) = 0;
    virtual rtError_t MemQueueInitFlowGw(const int32_t devId, const rtInitFlowGwInfo_t * const initInfo) = 0;
    virtual rtError_t MemQueueCreate(const int32_t devId, const rtMemQueueAttr_t * const queAttr,
        uint32_t * const qid) = 0;

    virtual rtError_t MemQueueExport(const int32_t devId, const uint32_t qid, const int32_t peerDevId,
        const char * const shareName) = 0;
    virtual rtError_t MemQueueUnExport(const int32_t devId, const uint32_t qid, const int32_t peerDevId,
        const char * const shareName) = 0;
    virtual rtError_t MemQueueImport(const int32_t devId, const int32_t peerDevId, const char * const shareName,
        uint32_t * const qid) = 0;
    virtual rtError_t MemQueueUnImport(const int32_t devId, const uint32_t qid, const int32_t peerDevId, 
        const char * const shareName) = 0;    
                                    
    virtual rtError_t MemQueueSet(const int32_t devId, rtMemQueueSetCmdType cmd,
        const rtMemQueueSetInputPara * const input) = 0;
    virtual rtError_t MemQueueDestroy(const int32_t devId, const uint32_t qid) = 0;
    virtual rtError_t MemQueueInit(const int32_t devId) = 0;
    virtual rtError_t MemQueueReset(const int32_t devId, const uint32_t qid) = 0;
    virtual rtError_t MemQueueEnQueue(const int32_t devId, const uint32_t qid, void * const enQBuf) = 0;
    virtual rtError_t MemQueueDeQueue(const int32_t devId, const uint32_t qid, void ** const deQBuf) = 0;
    virtual rtError_t MemQueuePeek(const int32_t devId, const uint32_t qid, size_t * const bufLen,
        const int32_t timeout) = 0;
    virtual rtError_t MemQueueEnQueueBuff(const int32_t devId, const uint32_t qid, rtMemQueueBuff_t * const inBuf,
        const int32_t timeout) = 0;
    virtual rtError_t MemQueueDeQueueBuff(const int32_t devId, const uint32_t qid, rtMemQueueBuff_t * const outBuf,
        const int32_t timeout) = 0;
    virtual rtError_t MemQueueQuery(const int32_t devId, const rtMemQueueQueryCmd_t cmd, const void * const inBuff,
        const uint32_t inLen, void * const outBuff, uint32_t * const outLen) = 0;
    virtual rtError_t MemQueueQueryInfo(const int32_t devId, const uint32_t qid,
        rtMemQueueInfo_t * const queryQueueInfo) = 0;
    virtual rtError_t MemQueueGrant(const int32_t devId, const uint32_t qid, const int32_t pid,
        rtMemQueueShareAttr_t * const attr) = 0;
    virtual rtError_t MemQueueAttach(const int32_t devId, const uint32_t qid, const int32_t timeOut) = 0;
    virtual rtError_t EschedSubmitEventSync(const int32_t devId,
                                            rtEschedEventSummary_t * const evt,
                                            rtEschedEventReply_t * const ack) = 0;
    virtual rtError_t QueryDevPid(rtBindHostpidInfo_t * const info, int32_t * const devPid) = 0;
    virtual rtError_t BuffAlloc(const uint64_t size, void **buff) = 0;
    virtual rtError_t BuffConfirm(void * const buff, const uint64_t size) = 0;
    virtual rtError_t BuffFree(void * const buff) = 0;
    virtual rtError_t MemGrpCreate(const char_t * const name, const rtMemGrpConfig_t * const cfg) = 0;
    virtual rtError_t MemGrpCacheAlloc(const char_t *const name, const int32_t devId,
        const rtMemGrpCacheAllocPara *const para) = 0;
    virtual rtError_t BuffGetInfo(const rtBuffGetCmdType type, const void * const inBuff, const uint32_t inLen,
        void * const outBuff, uint32_t * const outLen) = 0;
    virtual rtError_t MemGrpAddProc(const char_t * const name, const int32_t pid,
        const rtMemGrpShareAttr_t * const attr) = 0;
    virtual rtError_t MemGrpAttach(const char_t * const name, const int32_t timeout) = 0;
    virtual rtError_t MemGrpQuery(rtMemGrpQueryInput_t * const input, rtMemGrpQueryOutput_t * const output) = 0;
    virtual rtError_t MemQueueGetQidByName(const int32_t devId, const char_t * const name, uint32_t * const qId) = 0;
    virtual rtError_t QueueSubF2NFEvent(const int32_t devId, const uint32_t qId, const uint32_t groupId) = 0;
    virtual rtError_t QueueSubscribe(const int32_t devId, const uint32_t qId, const uint32_t groupId,
        const int32_t type) = 0;
    virtual rtError_t BufEventTrigger(const char * const name) = 0;
    virtual rtError_t EschedAttachDevice(const uint32_t devId) = 0;
    virtual rtError_t EschedDettachDevice(const uint32_t devId) = 0;
    virtual rtError_t EschedWaitEvent(const int32_t devId, const uint32_t grpId, const uint32_t threadId,
        const int32_t timeout, rtEschedEventSummary_t * const evt) = 0;
    virtual rtError_t EschedCreateGrp(const int32_t devId, const uint32_t grpId, const rtGroupType_t type) = 0;
    virtual rtError_t EschedSubmitEvent(const int32_t devId, rtEschedEventSummary_t * const evt) = 0;
    virtual rtError_t EschedSubscribeEvent(const int32_t devId, const uint32_t grpId,
        const uint32_t threadId, const uint64_t eventBitmap) = 0;
    virtual rtError_t EschedAckEvent(const int32_t devId, const rtEventIdType_t evtId,
        const uint32_t subeventId, char_t * const msg, const uint32_t len) = 0;
    virtual rtError_t CmoTaskLaunch(const rtCmoTaskInfo_t * const taskInfo, Stream * const stm,
        const uint32_t flag) = 0;
    virtual rtError_t CmoAddrTaskLaunch(void *cmoAddrInfo, const uint64_t destMax,
        const rtCmoOpCode_t cmoOpCode, Stream * const stm, const uint32_t flag) = 0;
    virtual rtError_t BarrierTaskLaunch(const rtBarrierTaskInfo_t * const taskInfo, Stream * const stm,
        const uint32_t flag) = 0;

    virtual rtError_t DvppGroupCreate(DvppGrp **grp, const uint32_t flags) = 0;
    virtual rtError_t DvppGroupDestory(DvppGrp *grp) = 0;
    virtual rtError_t DvppWaitGroupReport(DvppGrp * const grp, const rtDvppGrpCallback callBackFunc, const int32_t timeout) = 0;
    virtual rtError_t SetStreamTag(Stream * const stm, const uint32_t geOpTag) = 0;
    virtual rtError_t GetStreamTag(Stream * const stm, uint32_t * const geOpTag) = 0;
    // Get Api instance.
    static Api *Instance(const uint32_t flags = API_ENV_FLAGS_DEFAULT);
    virtual rtError_t GetVisibleDeviceIdByLogicDeviceId(const int32_t logicDeviceId, int32_t * const visibleDeviceId) = 0;

    virtual rtError_t CtxSetSysParamOpt(const rtSysParamOpt configOpt, const int64_t configVal) = 0;
    virtual rtError_t CtxGetSysParamOpt(const rtSysParamOpt configOpt, int64_t * const configVal) = 0;
    virtual rtError_t CtxGetOverflowAddr(void ** const overflowAddr) = 0;
    virtual rtError_t GetDeviceSatStatus(void * const outputAddrPtr, const uint64_t outputSize, Stream * const stm) = 0;
    virtual rtError_t CleanDeviceSatStatus(Stream * const stm) = 0;
    virtual rtError_t GetAllUtilizations(const int32_t devId, const rtTypeUtil_t kind, uint8_t * const util) = 0;
    virtual rtError_t EschedQueryInfo(const uint32_t devId, const rtEschedQueryType type,
                                      rtEschedInputInfo *inPut, rtEschedOutputInfo *outPut) = 0;
    virtual rtError_t BindHostPid(rtBindHostpidInfo info) = 0;
    virtual rtError_t UnbindHostPid(rtBindHostpidInfo info) = 0;
    virtual rtError_t QueryProcessHostPid(int32_t pid, uint32_t *chipId, uint32_t *vfId, uint32_t *hostPid,
        uint32_t *cpType) = 0;
    virtual rtError_t SetStreamSqLockUnlock(Stream * const stm, const bool isLock) = 0;
    virtual rtError_t ShrIdSetPodPid(const char *name, uint32_t sdid, int32_t pid) = 0;
    virtual rtError_t ShmemSetPodPid(const char *name, uint32_t sdid, int32_t pid[], int32_t num) = 0;
    virtual rtError_t DevVA2PA(uint64_t devAddr, uint64_t len, Stream *stm, bool isAsync) = 0;
    virtual rtError_t StreamClear(Stream * const stm, rtClearStep_t step) = 0;
    virtual rtError_t StreamAbort(Stream * const stm) = 0;
    virtual rtError_t DebugSetDumpMode(const uint64_t mode) = 0;
    virtual rtError_t DebugGetStalledCore(rtDbgCoreInfo_t *const coreInfo) = 0;
    virtual rtError_t DebugReadAICore(rtDebugMemoryParam_t *const param) = 0;
    virtual rtError_t GetExceptionRegInfo(const rtExceptionInfo_t * const exceptionInfo,
        rtExceptionErrRegInfo_t **exceptionErrRegInfo, uint32_t *num) = 0;
    virtual rtError_t GetServerIDBySDID(uint32_t sdid, uint32_t *srvId) = 0;
    virtual rtError_t GetThreadLastTaskId(uint32_t * const taskId) = 0;
    virtual rtError_t LaunchDvppTask(const void * const sqe, const uint32_t sqeLen, Stream * const stm, rtDvppCfg_t *cfg = nullptr) = 0;
    virtual rtError_t LaunchRandomNumTask(const rtRandomNumTaskInfo_t *taskInfo, Stream * const stm, void *reserve) = 0;
    virtual rtError_t KernelArgsInit(Kernel * const funcHandle, RtArgsHandle **argsHandle) = 0;
    virtual rtError_t KernelArgsAppendPlaceHolder(RtArgsHandle *argsHandle, ParaDetail **paraHandle) = 0;
    virtual rtError_t KernelArgsGetPlaceHolderBuffer(RtArgsHandle *argsHandle, ParaDetail *paraHandle,
        size_t dataSize, void **bufferAddr) = 0;
    virtual rtError_t KernelArgsGetHandleMemSize(Kernel * const funcHandle, size_t *memSize) = 0;
    virtual rtError_t KernelArgsGetMemSize(Kernel * const funcHandle, size_t userArgsSize, size_t *actualArgsSize) = 0;
    virtual rtError_t KernelArgsInitByUserMem(Kernel * const funcHandle, RtArgsHandle *argsHandle, void *userHostMem,
        size_t actualArgsSize) = 0;
    virtual rtError_t KernelArgsFinalize(RtArgsHandle *argsHandle) = 0;
    virtual rtError_t KernelArgsAppend(RtArgsHandle *argsHandle, void *para, size_t paraSize, ParaDetail **paraHandle) = 0;
    virtual rtError_t StreamTaskAbort(Stream * const stm) = 0;
    virtual rtError_t StreamRecover(Stream * const stm) = 0;
    virtual rtError_t StreamTaskClean(Stream * const stm) = 0;
    // over ub
    virtual rtError_t UbDbSend(rtUbDbInfo_t * const dbInfo, Stream * const stm) = 0;
    virtual rtError_t UbDirectSend(rtUbWqeInfo_t * const wqeInfo, Stream * const stm) = 0;

    // cmo addr task
    virtual rtError_t GetCmoDescSize(size_t *size) = 0;
    virtual rtError_t SetCmoDesc(rtCmoDesc_t cmoDesc, void *srcAddr, size_t srcLen) = 0;

    virtual rtError_t GetErrorVerbose(const uint32_t deviceId, rtErrorInfo * const errorInfo) = 0;
    virtual rtError_t RepairError(const uint32_t deviceId, const rtErrorInfo * const errorInfo) = 0;
    // dqs
    virtual rtError_t LaunchDqsTask(Stream * const stm, const rtDqsTaskCfg_t * const taskCfg) = 0;

    // aclgraph caching shape for profiling
    virtual rtError_t SetStreamCacheOpInfoSwitch(const Stream * const stm, uint32_t cacheOpInfoSwitch) = 0;
    virtual rtError_t GetStreamCacheOpInfoSwitch(const Stream * const stm, uint32_t * const cacheOpInfoSwitch) = 0;
    virtual rtError_t CacheLastTaskOpInfo(const void * const infoPtr, const size_t infoSize) = 0;

    virtual rtError_t LaunchHostFunc(Stream * const stm, rtCallback_t const callBackFunc, void * const fnData) = 0;

    // event mode
    virtual rtError_t EventWorkModeSet(uint8_t mode) = 0;
    virtual rtError_t EventWorkModeGet(uint8_t *mode) = 0;

    virtual rtError_t FunctionGetAttribute(rtFuncHandle funcHandle, rtFuncAttribute attrType, int64_t *attrValue) = 0;

};
}
}

#endif  // CCE_RUNTIME_API_HPP
