/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_API_PROFILE_LOG_DECORATOR_HPP
#define CCE_RUNTIME_API_PROFILE_LOG_DECORATOR_HPP

#include "api_decorator.hpp"

namespace cce {
namespace runtime {
class Profiler;

class ApiProfileLogDecorator : public ApiDecorator {
public:
    ApiProfileLogDecorator(Api * const impl, Profiler * const prof);
    ~ApiProfileLogDecorator() override
    {
        profiler_ = nullptr;
    }

    // kernel API
    rtError_t DevBinaryRegister(const rtDevBinary_t * const bin, Program ** const prog) override;
    rtError_t GetNotifyAddress(Notify * const notify, uint64_t * const notifyAddress) override;
    rtError_t RegisterAllKernel(const rtDevBinary_t * const bin, Program ** const prog) override;
    rtError_t DevBinaryUnRegister(Program * const prog) override;
    rtError_t BinaryLoad(const rtDevBinary_t * const bin, Program ** const prog) override;
    rtError_t BinaryGetFunction(const Program * const prog, const uint64_t tilingKey,
                                Kernel ** const funcHandle) override;
    rtError_t BinaryLoadWithoutTilingKey(const void *data, const uint64_t length, Program ** const prog) override;
    rtError_t BinaryGetFunctionByName(const Program * const binHandle, const char_t *kernelName,
                                      Kernel ** const funcHandle) override;
    rtError_t BinaryUnLoad(Program * const binHandle) override;
    rtError_t LaunchKernel(Kernel * const kernel, uint32_t blockDim, const rtArgsEx_t * const argsInfo,
                           Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo = nullptr) override;
    rtError_t LaunchKernelV2(Kernel * const kernel, uint32_t blockDim, const RtArgsWithType * const argsWithType,
                             Stream * const stm, const rtKernelLaunchCfg_t * const cfg  = nullptr) override;
    rtError_t LaunchKernelV3(Kernel * const kernel, const rtArgsEx_t * const argsInfo,
                             Stream * const stm, const rtLaunchConfig_t * const launchConfig) override; 
    rtError_t MetadataRegister(Program * const prog, const char_t * const metadata) override;
    rtError_t DependencyRegister(Program * const mProgram, Program * const sProgram) override;
    rtError_t FunctionRegister(Program * const prog, const void * const stubFunc, const char_t * const stubName,
        const void * const kernelInfoExt, const uint32_t funcMode) override;
    rtError_t KernelLaunch(const void * const stubFunc, const uint32_t coreDim,
        const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm,
        const uint32_t flag, const rtTaskCfgInfo_t * const cfgInfo = nullptr, const bool isLaunchVec = false) override;
    rtError_t KernelLaunchWithHandle(void * const hdl, const uint64_t tilingKey, const uint32_t coreDim,
        const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm,
        const rtTaskCfgInfo_t * const cfgInfo = nullptr, const bool isLaunchVec = false) override;
    rtError_t KernelLaunchEx(const char_t * const opName, const void * const args, const uint32_t argsSize,
        const uint32_t flags, Stream * const stm) override;
    rtError_t CpuKernelLaunch(const rtKernelLaunchNames_t * const launchNames, const uint32_t coreDim,
        const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm,
        const uint32_t flag) override;
    rtError_t CpuKernelLaunchExWithArgs(const char_t * const opName, const uint32_t coreDim,
        const rtAicpuArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm,
        const uint32_t flag, const uint32_t kernelType) override;
    rtError_t MultipleTaskInfoLaunch(const rtMultipleTaskInfo_t * const taskInfo, Stream * const stm,
        const uint32_t flag) override;
    rtError_t DatadumpInfoLoad(const void * const dumpInfo, const uint32_t length, const uint32_t flag) override;
    rtError_t AicpuInfoLoad(const void * const aicpuInfo, const uint32_t length) override;
    rtError_t KernelFusionStart(Stream * const stm) override;
    rtError_t KernelFusionEnd(Stream * const stm) override;
    rtError_t GetServerIDBySDID(uint32_t sdid, uint32_t *srvId) override;
    rtError_t FusionLaunch(void * const fusionInfo, Stream * const stm, rtFusionArgsEx_t *argsInfo) override;

    // stream API
    rtError_t StreamCreate(Stream ** const stm, const int32_t priority, const uint32_t flags, DvppGrp *grp) override;
    rtError_t StreamDestroy(Stream * const stm, bool flag) override;
    rtError_t StreamWaitEvent(Stream * const stm, Event * const evt, const uint32_t timeout) override;
    rtError_t StreamSynchronize(Stream * const stm, const int32_t timeout) override;
    rtError_t StreamSetMode(Stream * const stm, const uint64_t stmMode) override;
    rtError_t StreamGetMode(const Stream * const stm, uint64_t * const stmMode) override;
    rtError_t StreamClear(Stream * const stm, rtClearStep_t step) override;

    // event API
    rtError_t EventCreate(Event ** const evt, const uint64_t flag) override;
    rtError_t EventCreateEx(Event ** const evt, const uint64_t flag) override;
    rtError_t EventDestroy(Event *evt) override;
    rtError_t EventRecord(Event * const evt, Stream * const stm) override;
    rtError_t EventCreateForNotify(Event ** const evt) override;
    rtError_t EventRecordForNotify(Event * const evt, Stream * const stm) override;
    rtError_t EventSynchronize(Event * const evt, const int32_t timeout) override;
    rtError_t GetEventID(Event * const evt, uint32_t * const evtId) override;

    // memory API
    using ApiDecorator::DevMalloc; // avoid hidden
    rtError_t DevMalloc(void ** const devPtr, const uint64_t size, const rtMemType_t type,
        const uint16_t moduleId = MODULEID_RUNTIME) override;
    rtError_t DevFree(void * const devPtr) override;
    rtError_t DevDvppMalloc(void ** const devPtr, const uint64_t size, const uint32_t flag,
        const uint16_t moduleId = MODULEID_RUNTIME) override;
    rtError_t DevDvppFree(void * const devPtr) override;
    rtError_t DevMallocCached(void ** const devPtr, const uint64_t size, const rtMemType_t type,
        const uint16_t moduleId = MODULEID_RUNTIME) override;
    rtError_t HostMalloc(void ** const hostPtr, const uint64_t size, const uint16_t moduleId = MODULEID_RUNTIME) override;
    rtError_t HostFree(void * const hostPtr) override;
    rtError_t ManagedMemAlloc(void ** const ptr, const uint64_t size, const uint32_t flag,
        const uint16_t moduleId = MODULEID_RUNTIME) override;
    rtError_t ManagedMemFree(const void * const ptr) override;
    rtError_t MemAdvise(void *devPtr, uint64_t count, uint32_t advise) override;
    rtError_t MemCopySync(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cnt,
        const rtMemcpyKind_t kind, const uint32_t checkKind = INVALID_CHECK_KIND) override;
    rtError_t MemcpyAsync(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cnt,
        const rtMemcpyKind_t kind, Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo = nullptr,
        const rtD2DAddrCfgInfo_t * const addrCfg = nullptr, bool checkKind = true, const rtMemcpyConfig_t * const memcpyConfig = nullptr) override;
    rtError_t ReduceAsync(void * const dst, const void * const src, const uint64_t cnt, const rtRecudeKind_t kind,
        const rtDataType_t type, Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo = nullptr) override;
    rtError_t ReduceAsyncV2(void * const dst, const void * const src, const uint64_t cnt, const rtRecudeKind_t kind,
        const rtDataType_t type, Stream * const stm, void * const overflowAddr) override;
    rtError_t MemSetSync(const void * const devPtr, const uint64_t destMax, const uint32_t val,
        const uint64_t cnt) override;
    rtError_t MemsetAsync(void * const ptr, const uint64_t destMax, const uint32_t val, const uint64_t cnt,
        Stream * const stm) override;
    rtError_t MemCopy2DSync(void * const dst, const uint64_t dstPitch, const void * const src, const uint64_t srcPitch,
        const uint64_t width, const uint64_t height,
        const rtMemcpyKind_t kind = RT_MEMCPY_RESERVED, const rtMemcpyKind newKind = RT_MEMCPY_KIND_MAX) override;
    rtError_t MemCopy2DAsync(void * const dst, const uint64_t dstPitch, const void * const src, const uint64_t srcPitch,
        const uint64_t width, const uint64_t height, Stream * const stm,
        const rtMemcpyKind_t kind = RT_MEMCPY_RESERVED, const rtMemcpyKind newKind = RT_MEMCPY_KIND_MAX) override;
    rtError_t MemcpyHostTask(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cnt,
        const rtMemcpyKind_t kind, Stream * const stm) override;
    rtError_t BuffGetInfo(const rtBuffGetCmdType type, const void * const inBuff, const uint32_t inLen,
        void * const outBuff, uint32_t * const outLen) override;
    rtError_t GetDevArgsAddr(Stream * const stm, rtArgsEx_t * const argsInfo, void ** const devArgsAddr,
        void ** const argsHandle) override;
    rtError_t MemWriteValue(const void * const devAddr, const uint64_t value, const uint32_t flag, Stream * const stm) override;
    rtError_t MemWaitValue(const void * const devAddr, const uint64_t value, const uint32_t flag, Stream * const stm) override;
    rtError_t MemcpyBatch(void **dsts, void **srcs, size_t *sizes, size_t count,
        rtMemcpyBatchAttr *attrs, size_t *attrsIdxs, size_t numAttrs, size_t *failIdx) override;
    rtError_t MemcpyBatchAsync(void** const dsts, const size_t* const destMaxs, void** const srcs, const size_t* const sizes,
        const size_t count, const rtMemcpyBatchAttr* const attrs, const size_t* const attrsIdxs, const size_t numAttrs, size_t* const failIdx,
        Stream* const stm) override;

    // device API
    rtError_t SetDevice(const int32_t devId) override;
    rtError_t DeviceReset(const int32_t devId, const bool isForceReset = false) override;
    rtError_t DeviceSynchronize(const int32_t timeout) override;
    rtError_t DeviceResetForce(const int32_t devId) override;

    // context
    rtError_t ContextCreate(Context ** const inCtx, const int32_t devId) override;
    rtError_t ContextDestroy(Context * const inCtx) override;
    rtError_t ContextSetCurrent(Context * const inCtx) override;

    // resource name
    rtError_t NameStream(Stream * const stm, const char_t * const name) override;
    rtError_t NameEvent(Event * const evt, const char_t * const name) override;

    // model API
    rtError_t ModelCreate(Model ** const mdl, const uint32_t flag) override;
    rtError_t ModelSetExtId(Model * const mdl, const uint32_t extId) override;
    rtError_t ModelDestroy(Model * const mdl) override;
    rtError_t ModelBindStream(Model * const mdl, Stream * const stm, const uint32_t flag) override;
    rtError_t ModelUnbindStream(Model * const mdl, Stream * const stm) override;
    rtError_t ModelExecute(Model * const mdl, Stream * const stm, const uint32_t flag,
        int32_t timeout = -1) override;
    rtError_t ModelExecuteSync(Model * const mdl, int32_t timeout = -1) override;
    rtError_t ModelExecuteAsync(Model * const mdl, Stream * const stm) override;    
    rtError_t RDMASend(const uint32_t sqIndex, const uint32_t wqeIndex, Stream * const stm) override;
    rtError_t RdmaDbSend(const uint32_t dbIndex, const uint64_t dbInfo, Stream * const stm) override;
    rtError_t NotifyCreate(const int32_t deviceId, Notify ** const retNotify, uint64_t flag = RT_NOTIFY_FLAG_DEFAULT) override;
    rtError_t NotifyDestroy(Notify * const inNotify) override;
    rtError_t NotifyRecord(Notify * const inNotify, Stream * const stm) override;
    rtError_t NotifyReset(Notify * const inNotify) override;
    rtError_t NotifyWait(Notify * const inNotify, Stream * const stm, const uint32_t timeOut) override;
    // CountNotify api
    rtError_t CntNotifyCreate(const int32_t deviceId, CountNotify ** const retCntNotify,
                              const uint32_t flag = RT_NOTIFY_FLAG_DEFAULT) override;
    rtError_t CntNotifyDestroy(CountNotify * const inCntNotify) override;
    rtError_t CntNotifyRecord(CountNotify * const inCntNotify, Stream * const stm,
                              const rtCntNtyRecordInfo_t * const info) override;
    rtError_t CntNotifyWaitWithTimeout(CountNotify * const inCntNotify, Stream * const stm,
                                       const rtCntNtyWaitInfo_t * const info) override;
    rtError_t CntNotifyReset(CountNotify * const inCntNotify, Stream * const stm) override;
    rtError_t GetCntNotifyAddress(CountNotify * const inCntNotify, uint64_t * const cntNotifyAddress,
        rtNotifyType_t const regType) override;
    rtError_t WriteValue(rtWriteValueInfo_t * const info, Stream * const stm) override;
    // CCU Launch
    rtError_t CCULaunch(rtCcuTaskInfo_t *taskInfo,  Stream * const stm) override;

    rtError_t IpcOpenNotify(Notify ** const retNotify, const char_t * const name,
        uint32_t flag = RT_NOTIFY_FLAG_DEFAULT) override;
    rtError_t ModelSetSchGroupId(Model * const mdl, const int16_t schGrpId) override;
    rtError_t ModelTaskUpdate(Stream *desStm, uint32_t desTaskId, Stream *sinkStm,
                              rtMdlTaskUpdateInfo_t *para) override;

    // callback api
    rtError_t SubscribeReport(const uint64_t threadId, Stream * const stm) override;
    rtError_t CallbackLaunch(const rtCallback_t callBackFunc, void * const fnData, Stream * const stm,
        const bool isBlock) override;
    rtError_t ProcessReport(const int32_t timeout, const bool noLog = false) override;
    rtError_t UnSubscribeReport(const uint64_t threadId, Stream * const stm) override;
    rtError_t GetRunMode(rtRunMode * const runMode) override;
    rtError_t GetVisibleDeviceIdByLogicDeviceId(const int32_t logicDeviceId, int32_t * const visibleDeviceId) override;
    rtError_t GetLogicDevIdByUserDevId(const int32_t userDevId, int32_t * const logicDevId) override;
    rtError_t GetUserDevIdByLogicDevId(const int32_t logicDevId, int32_t * const userDevId) override;

    rtError_t CtxSetSysParamOpt(const rtSysParamOpt configOpt, const int64_t configVal) override;
    rtError_t CtxGetSysParamOpt(const rtSysParamOpt configOpt, int64_t * const configVal) override;
    rtError_t CtxGetOverflowAddr(void ** const overflowAddr) override;
    rtError_t GetDeviceSatStatus(void * const outputAddrPtr, const uint64_t outputSize, Stream * const stm) override;
    rtError_t CleanDeviceSatStatus(Stream * const stm) override;
    // stream label func
    rtError_t LabelSwitchByIndex(void * const ptr, const uint32_t maxVal, void * const labelInfoPtr,
        Stream * const stm) override;
    rtError_t LabelGotoEx(Label * const lbl, Stream * const stm) override;
    rtError_t LabelListCpy(Label ** const lbl, const uint32_t labelNumber, void * const dst,
        const uint32_t dstMax) override;
    // OVER UB API
    rtError_t UbDbSend(rtUbDbInfo_t * const dbInfo, Stream * const stm) override;
    rtError_t UbDirectSend(rtUbWqeInfo_t * const wqeInfo, Stream * const stm) override;
    rtError_t CacheLastTaskOpInfo(const void * const infoPtr, const size_t infoSize) override;
private:
    Profiler *profiler_;
};
}  // namespace runtime
}  // namespace cce

#endif  // CCE_RUNTIME_API_PROFILE_LOG_DECORATOR_HPP
