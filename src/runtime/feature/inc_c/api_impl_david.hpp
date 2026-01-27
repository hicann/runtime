/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_API_IMPL_DAVID_HPP__
#define __CCE_RUNTIME_API_IMPL_DAVID_HPP__

#include "api_impl.hpp"

namespace cce {
namespace runtime {
class ApiImplDavid : public ApiImpl {
public:
    rtError_t KernelLaunch(const void * const stubFunc, const uint32_t coreDim,
        const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm,
        const uint32_t flag, const rtTaskCfgInfo_t * const cfgInfo = nullptr, const bool isLaunchVec = false) override;
    rtError_t KernelLaunchWithHandle(void * const hdl, const uint64_t tilingKey, const uint32_t coreDim,
        const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm,
        const rtTaskCfgInfo_t * const cfgInfo = nullptr, const bool isLaunchVec = false) override;
    rtError_t LaunchKernel(Kernel * const kernel, uint32_t blockDim, const rtArgsEx_t * const argsInfo,
        Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo = nullptr) override;
    rtError_t LaunchKernelV3(Kernel * const kernel, const rtArgsEx_t * const argsInfo,
        Stream * const stm, const rtLaunchConfig_t * const launchConfig) override;

    rtError_t KernelLaunchEx(const char_t * const opName, const void * const args, const uint32_t argsSize,
        const uint32_t flags, Stream * const stm) override;
    rtError_t CpuKernelLaunch(const rtKernelLaunchNames_t * const launchNames, const uint32_t coreDim,
        const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm,
        const uint32_t flag) override;
    rtError_t CpuKernelLaunchExWithArgs(const char_t * const opName, const uint32_t coreDim,
        const rtAicpuArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm, const uint32_t flag,
        const uint32_t kernelType) override;

    rtError_t FusionLaunch(void * const fusionInfo, Stream * const stm, rtFusionArgsEx_t *argsInfo) override;

    rtError_t CCULaunch(rtCcuTaskInfo_t *taskInfo,  Stream * const stm) override;
    rtError_t UbDevQueryInfo(rtUbDevQueryCmd cmd, void * devInfo) override;
    rtError_t GetDevResAddress(const rtDevResInfo * const resInfo, rtDevResAddrInfo * const addrInfo) override;
    rtError_t ReleaseDevResAddress(rtDevResInfo * const resInfo) override;

    rtError_t CmoTaskLaunch(const rtCmoTaskInfo_t * const taskInfo, Stream * const stm, const uint32_t flag) override;
    rtError_t CmoAddrTaskLaunch(void *cmoAddrInfo, const uint64_t destMax, const rtCmoOpCode_t cmoOpCode,
        Stream * const stm, const uint32_t flag) override;

    rtError_t MemcpyAsyncPtr(void * const memcpyAddrInfo, const uint64_t destMax, const uint64_t count, Stream *stm,
        const rtTaskCfgInfo_t * const cfgInfo = nullptr, const bool isMemcpyDesc = false) override;
    rtError_t SetMemcpyDesc(rtMemcpyDesc_t desc, const void * const srcAddr, const void * const dstAddr,
    const size_t count, const rtMemcpyKind kind, rtMemcpyConfig_t * const config) override;
    rtError_t MemCopy2DAsync(void * const dst, const uint64_t dstPitch, const void * const src, const uint64_t srcPitch,
        const uint64_t width, const uint64_t height, Stream * const stm,
        const rtMemcpyKind_t kind = RT_MEMCPY_RESERVED, const rtMemcpyKind newKind = RT_MEMCPY_KIND_MAX) override;
    rtError_t MemcpyAsync(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cnt,
        const rtMemcpyKind_t kind, Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo = nullptr,
        const rtD2DAddrCfgInfo_t * const addrCfg = nullptr, bool checkKind = true,
        const rtMemcpyConfig_t * const memcpyConfig = nullptr) override;
    rtError_t ReduceAsync(void * const dst, const void * const src, const uint64_t cnt, const rtRecudeKind_t kind,
        const rtDataType_t type, Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo = nullptr) override;
    rtError_t MemsetAsync(void * const ptr, const uint64_t destMax, const uint32_t val, const uint64_t cnt,
        Stream * const stm) override;
    // event API
    rtError_t EventCreate(Event ** const evt, const uint64_t flag) override;
    rtError_t EventCreateEx(Event ** const evt, const uint64_t flag) override;
    rtError_t EventDestroy(Event *evt) override;
    rtError_t EventRecord(Event * const evt, Stream * const stm) override;
    rtError_t EventReset(Event * const evt, Stream * const stm) override;
    rtError_t StreamWaitEvent(Stream * const stm, Event * const evt, const uint32_t timeout) override;

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

    rtError_t NotifyWait(Notify * const inNotify, Stream * const stm, const uint32_t timeOut) override;
    rtError_t NotifyRecord(Notify * const inNotify, Stream * const stm) override;
    rtError_t NotifyReset(Notify * const inNotify) override;

    rtError_t DatadumpInfoLoad(const void * const dumpInfo, const uint32_t length, const uint32_t flag) override;
    rtError_t DebugRegister(Model * const mdl, const uint32_t flag, const void * const addr,
        uint32_t * const streamId, uint32_t * const taskId) override;
    rtError_t DebugUnRegister(Model * const mdl) override;
    rtError_t DebugRegisterForStream(Stream * const stm, const uint32_t flag, const void * const addr,
        uint32_t * const streamId, uint32_t * const taskId) override;
    rtError_t DebugUnRegisterForStream(Stream * const stm) override;

    rtError_t NpuGetFloatStatus(void * const outputAddrPtr, const uint64_t outputSize, const uint32_t checkMode,
        Stream * const stm) override;
    rtError_t NpuClearFloatStatus(const uint32_t checkMode, Stream * const stm) override;
    rtError_t NpuGetFloatDebugStatus(void * const outputAddrPtr, const uint64_t outputSize, const uint32_t checkMode,
        Stream * const stm) override;
    rtError_t NpuClearFloatDebugStatus(const uint32_t checkMode, Stream * const stm) override;
    rtError_t GetDeviceSatStatus(void * const outputAddrPtr, const uint64_t outputSize, Stream * const stm) override;
    rtError_t SetStreamOverflowSwitch(Stream * const stm, const uint32_t flags) override;
    rtError_t SetStreamTag(Stream * const stm, const uint32_t geOpTag) override;
    rtError_t UbDbSend(rtUbDbInfo_t * const dbInfo, Stream * const stm) override;
    rtError_t UbDirectSend(rtUbWqeInfo_t * const wqeInfo, Stream * const stm) override;

    rtError_t StreamClear(Stream * const stm, rtClearStep_t step) override;
    rtError_t NopTask(Stream * const stm) override;
    rtError_t AicpuInfoLoad(const void * const aicpuInfo, const uint32_t length) override;
    rtError_t ProcessReport(const int32_t timeout, const bool noLog = false) override;
    rtError_t SubscribeReport(const uint64_t threadId, Stream * const stm) override;
    rtError_t ModelTaskUpdate(Stream *desStm, uint32_t desTaskId, Stream *sinkStm,
        rtMdlTaskUpdateInfo_t *para) override;
    rtError_t LabelSwitchByIndex(void * const ptr, const uint32_t maxVal, void * const labelInfoPtr,
        Stream * const stm) override;
    rtError_t CallbackLaunch(const rtCallback_t callBackFunc, void * const fnData, Stream * const stm,
        const bool isBlock) override;
    rtError_t StreamActive(Stream * const activeStream, Stream * const stm) override;
    rtError_t StreamSwitchN(void * const ptr, const uint32_t size, void * const valuePtr,
        Stream ** const trueStreamPtr, const uint32_t elementSize, Stream * const stm,
        const rtSwitchDataType_t dataType) override;
    rtError_t ModelAbort(Model * const mdl) override;
    rtError_t ModelEndGraph(Model * const mdl, Stream * const stm, const uint32_t flags) override;
    rtError_t ModelExit(Model * const mdl, Stream * const stm) override;
    rtError_t LabelGotoEx(Label * const lbl, Stream * const stm) override;
    rtError_t StreamSwitchEx(void * const ptr, const rtCondition_t condition, void * const valuePtr,
        Stream * const trueStream, Stream * const stm, const rtSwitchDataType_t dataType) override;
    rtError_t LabelSet(Label * const lbl, Stream * const stm) override;

    rtError_t ProfilerTraceEx(const uint64_t id, const uint64_t modelId, const uint16_t tagId, Stream *stm) override;
    rtError_t ProfilerTrace(const uint64_t id, const bool notifyFlag, const uint32_t flags,
        Stream * const stm) override;
    rtError_t WriteValue(rtWriteValueInfo_t * const info, Stream * const stm) override;
    rtError_t WriteValuePtr(void * const writeValueInfo, Stream * const stm, void * const pointedAddr) override;
    rtError_t GetMemUceInfo(const uint32_t deviceId, rtMemUceInfo *memUceInfo) override;
    rtError_t StarsTaskLaunch(const void * const sqe, const uint32_t sqeLen, Stream * const stm,
        const uint32_t flag) override;
    rtError_t LaunchDvppTask(const void *sqe, uint32_t sqeLen, Stream *stm, rtDvppCfg_t *cfg) override;
    rtError_t MultipleTaskInfoLaunch(const rtMultipleTaskInfo_t * const taskInfo, Stream * const stm,
        const uint32_t flag) override;
    rtError_t DvppWaitGroupReport(DvppGrp * const grp, rtDvppGrpCallback const callBackFunc,
        const int32_t timeout) override;
    rtError_t StreamTaskAbort(Stream * const stm) override;
    rtError_t StreamStop(Stream * const stm) override;
    rtError_t StreamAbort(Stream * const stm) override;
    rtError_t StreamRecover(Stream * const stm) override;
    rtError_t StreamTaskClean(Stream * const stm) override;
    rtError_t DeviceResourceClean(int32_t devId) override;
    rtError_t DeviceSetLimit(const int32_t devId, const rtLimitType_t type, const uint32_t val) override;
    rtError_t DeviceTaskAbort(const int32_t devId, const uint32_t timeout) override;
    rtError_t GetErrorVerbose(const uint32_t deviceId, rtErrorInfo * const errorInfo) override;
    rtError_t RepairError(const uint32_t deviceId, const rtErrorInfo * const errorInfo) override;
    rtError_t GetStackBuffer(const rtBinHandle binHandle, const uint32_t coreType, const uint32_t coreId,
        const void **stack, uint32_t *stackSize) override;
    rtError_t DebugReadAICore(rtDebugMemoryParam_t *const param) override;
    rtError_t GetExceptionRegInfo(const rtExceptionInfo_t * const exceptionInfo,
        rtExceptionErrRegInfo_t **exceptionErrRegInfo, uint32_t *num) override;
    rtError_t LaunchHostFunc(Stream * const stm, const rtCallback_t callBackFunc, void * const fnData) override;
    rtError_t CpuKernelLaunchExAll(const Kernel * const kernel, const uint32_t coreDim,
        rtCpuKernelArgs_t *argsInfo, Stream * const stm, const TaskCfg * const taskCfg);
    rtError_t LaunchKernelByHandle(Kernel * const kernel, uint32_t blockDim, const RtArgsHandle * const argHandle,
        Stream * const curStm, const TaskCfg &taskCfg);
    rtError_t LaunchKernelV2(Kernel * const kernel, uint32_t blockDim, const RtArgsWithType * const argsWithType,
        Stream * const stm, const rtKernelLaunchCfg_t * const cfg) override;
    rtError_t MemWriteValue(const void * const devAddr, const uint64_t value, const uint32_t flag,
        Stream * const stm) override;
    rtError_t MemWaitValue(const void * const devAddr, const uint64_t value, const uint32_t flag,
        Stream * const stm) override;
    rtError_t SetXpuDevice(const rtXpuDevType devType, const uint32_t devId) override;
    rtError_t GetXpuDevCount(const rtXpuDevType devType, uint32_t *devCount) override;
    rtError_t ResetXpuDevice(const rtXpuDevType devType, const uint32_t devId) override;
protected:
    rtError_t GetDeviceSimtInfo(uint32_t deviceId, rtDevAttr attr, int64_t *val) override;
    rtError_t GetDevRunningStreamSnapshotMsg(const rtGetMsgCallback callback) override;

private:
    rtError_t CaptureRecordEvent(Context * const ctx, Event * const evt, Stream * const stm);
    rtError_t CaptureResetEvent(const Event * const evt, Stream * const stm);
    rtError_t GetCaptureEvent(const Stream * const stm, Event * const evt, Event ** const captureEvt);
    rtError_t CaptureWaitEvent(Context * const ctx, Stream * const stm, Event * const evt, const uint32_t timeout);
    rtError_t LaunchKernelByArgsWithType(Kernel * const kernel, const uint32_t coreDim, Stream *stm,
        const RtArgsWithType * const argsWithType, const TaskCfg &taskCfg);
};
}
}

#endif // __CCE_RUNTIME_API_IMPL_DAVID_HPP__
