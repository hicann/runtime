/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_decorator.hpp"
#include "dvpp_grp.hpp"

namespace cce {
namespace runtime {
rtError_t ApiDecorator::NameStream(Stream * const stm, const char_t * const name)
{
    return impl_->NameStream(stm, name);
}

rtError_t ApiDecorator::NameEvent(Event * const evt, const char_t * const name)
{
    return impl_->NameEvent(evt, name);
}

rtError_t ApiDecorator::ProfilerStart(const uint64_t profConfig, const int32_t numsDev,
    uint32_t * const deviceList, const uint32_t cacheFlag, const uint64_t profSwitchHi)
{
    return impl_->ProfilerStart(profConfig, numsDev, deviceList, cacheFlag, profSwitchHi);
}

rtError_t ApiDecorator::ProfilerStop(
    const uint64_t profConfig, const int32_t numsDev, uint32_t *const deviceList, const uint64_t profSwitchHi)
{
    return impl_->ProfilerStop(profConfig, numsDev, deviceList, profSwitchHi);
}

rtError_t ApiDecorator::GetBinaryDeviceBaseAddr(const Program * const prog, void **deviceBase)
{
    return impl_->GetBinaryDeviceBaseAddr(prog, deviceBase);
}

ApiDecorator::ApiDecorator(Api * const inImpl) : Api(), impl_(inImpl)
{
    return;
}

rtError_t ApiDecorator::DevBinaryRegister(const rtDevBinary_t * const bin, Program ** const prog)
{
    return impl_->DevBinaryRegister(bin, prog);
}

rtError_t ApiDecorator::GetNotifyAddress(Notify * const notify, uint64_t * const notifyAddress)
{
    return impl_->GetNotifyAddress(notify, notifyAddress);
}

rtError_t ApiDecorator::RegisterAllKernel(const rtDevBinary_t * const bin, Program ** const prog)
{
    return impl_->RegisterAllKernel(bin, prog);
}

rtError_t ApiDecorator::BinaryRegisterToFastMemory(Program * const prog)
{
    return impl_->BinaryRegisterToFastMemory(prog);
}

rtError_t ApiDecorator::DevBinaryUnRegister(Program * const prog)
{
    return impl_->DevBinaryUnRegister(prog);
}

rtError_t ApiDecorator::MetadataRegister(Program * const prog, const char_t * const metadata)
{
    return impl_->MetadataRegister(prog, metadata);
}

rtError_t ApiDecorator::DependencyRegister(Program * const mProgram, Program * const sProgram)
{
    return impl_->DependencyRegister(mProgram, sProgram);
}

rtError_t ApiDecorator::FunctionRegister(Program * const prog, const void * const stubFunc,
    const char_t * const stubName, const void * const kernelInfoExt, const uint32_t funcMode)
{
    return impl_->FunctionRegister(prog, stubFunc, stubName, kernelInfoExt, funcMode);
}

rtError_t ApiDecorator::GetFunctionByName(const char_t * const stubName, void ** const stubFunc)
{
    return impl_->GetFunctionByName(stubName, stubFunc);
}

rtError_t ApiDecorator::GetAddrByFun(const void * const stubFunc, void ** const addr)
{
    return impl_->GetAddrByFun(stubFunc, addr);
}

rtError_t ApiDecorator::GetAddrAndPrefCntWithHandle(void * const hdl, const void * const kernelInfoExt,
    void ** const addr, uint32_t * const prefetchCnt)
{
    return impl_->GetAddrAndPrefCntWithHandle(hdl, kernelInfoExt, addr, prefetchCnt);
}

rtError_t ApiDecorator::KernelGetAddrAndPrefCnt(void * const hdl, const uint64_t tilingKey,
    const void * const stubFunc, const uint32_t flag,  void ** const addr, uint32_t * const prefetchCnt)
{
    return impl_->KernelGetAddrAndPrefCnt(hdl, tilingKey, stubFunc, flag, addr, prefetchCnt);
}

rtError_t ApiDecorator::KernelGetAddrAndPrefCntV2(void * const hdl, const uint64_t tilingKey,
    const void * const stubFunc, const uint32_t flag,  rtKernelDetailInfo_t * const kernelInfo)
{
    return impl_->KernelGetAddrAndPrefCntV2(hdl, tilingKey, stubFunc, flag, kernelInfo);
}

rtError_t ApiDecorator::QueryFunctionRegistered(const char_t * const stubName)
{
    return impl_->QueryFunctionRegistered(stubName);
}

rtError_t ApiDecorator::KernelLaunch(const void * const stubFunc, const uint32_t coreDim,
    const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm, const uint32_t flag,
    const rtTaskCfgInfo_t * const cfgInfo, const bool isLaunchVec)
{
    return impl_->KernelLaunch(stubFunc, coreDim, argsInfo, l2ctrl, stm, flag, cfgInfo, isLaunchVec);
}

rtError_t ApiDecorator::KernelLaunchWithHandle(void * const hdl, const uint64_t tilingKey,
    const uint32_t coreDim, const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm,
    const rtTaskCfgInfo_t * const cfgInfo, const bool isLaunchVec)
{
    return impl_->KernelLaunchWithHandle(hdl, tilingKey, coreDim, argsInfo, l2ctrl, stm, cfgInfo, isLaunchVec);
}

rtError_t ApiDecorator::KernelLaunchEx(const char_t * const opName, const void * const args, const uint32_t argsSize,
    const uint32_t flags, Stream * const stm)
{
    return impl_->KernelLaunchEx(opName, args, argsSize, flags, stm);
}

rtError_t ApiDecorator::CpuKernelLaunch(const rtKernelLaunchNames_t * const launchNames, const uint32_t coreDim,
    const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm, const uint32_t flag)
{
    return impl_->CpuKernelLaunch(launchNames, coreDim, argsInfo, l2ctrl, stm, flag);
}

rtError_t ApiDecorator::CalcLaunchArgsSize(size_t const argsSize, size_t const hostInfoTotalSize,
    size_t const hostInfoNum, size_t * const launchArgsSize)
{
    return impl_->CalcLaunchArgsSize(argsSize, hostInfoTotalSize, hostInfoNum, launchArgsSize);
}

rtError_t ApiDecorator::CreateLaunchArgs(size_t const argsSize, size_t const hostInfoTotalSize,
    size_t const hostInfoNum, void * const argsData, rtLaunchArgs_t ** const argsHandle)
{
    return impl_->CreateLaunchArgs(argsSize, hostInfoTotalSize, hostInfoNum, argsData, argsHandle);
}

rtError_t ApiDecorator::DestroyLaunchArgs(rtLaunchArgs_t* argsHandle)
{
    return impl_->DestroyLaunchArgs(argsHandle);
}

rtError_t ApiDecorator::ResetLaunchArgs(rtLaunchArgs_t* argsHandle)
{
    return impl_->ResetLaunchArgs(argsHandle);
}

rtError_t ApiDecorator::AppendLaunchAddrInfo(rtLaunchArgs_t* const hdl, void * const addrInfo)
{
    return impl_->AppendLaunchAddrInfo(hdl, addrInfo);
}

rtError_t ApiDecorator::AppendLaunchHostInfo(rtLaunchArgs_t* const hdl, size_t const hostInfoSize,
    void ** const hostInfo)
{
    return impl_->AppendLaunchHostInfo(hdl, hostInfoSize, hostInfo);
}

rtError_t ApiDecorator::CpuKernelLaunchExWithArgs(const char_t * const opName, const uint32_t coreDim,
    const rtAicpuArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm, const uint32_t flag,
    const uint32_t kernelType)
{
    return impl_->CpuKernelLaunchExWithArgs(opName, coreDim, argsInfo, l2ctrl, stm, flag, kernelType);
}

rtError_t ApiDecorator::MultipleTaskInfoLaunch(const rtMultipleTaskInfo_t * const taskInfo, Stream * const stm,
    const uint32_t flag)
{
    return impl_->MultipleTaskInfoLaunch(taskInfo, stm, flag);
}

rtError_t ApiDecorator::BinaryLoad(const rtDevBinary_t * const bin, Program ** const prog)
{
    return impl_->BinaryLoad(bin, prog);
}

rtError_t ApiDecorator::BinaryGetFunction(const Program * const prog, const uint64_t tilingKey,
                                          Kernel ** const funcHandle)
{
    return impl_->BinaryGetFunction(prog, tilingKey, funcHandle);
}

rtError_t ApiDecorator::BinaryLoadWithoutTilingKey(const void *data, const uint64_t length, Program ** const prog)
{
    return impl_->BinaryLoadWithoutTilingKey(data, length, prog);
}

rtError_t ApiDecorator::GetL2CacheOffset(uint32_t deviceId, uint64_t *offset)
{
    return impl_->GetL2CacheOffset(deviceId, offset);
}

rtError_t ApiDecorator::BinaryGetFunctionByName(const Program * const binHandle, const char_t *kernelName,
                                                Kernel ** const funcHandle)
{
    return impl_->BinaryGetFunctionByName(binHandle, kernelName, funcHandle);
}

rtError_t ApiDecorator::BinaryGetFunctionByEntry(const Program * const binHandle, const uint64_t funcEntry,
                                                 Kernel ** const funcHandle)
{
    return impl_->BinaryGetFunctionByEntry(binHandle, funcEntry, funcHandle);
}

rtError_t ApiDecorator::BinaryGetMetaInfo(Program * const binHandle, const rtBinaryMetaType type,
                                          void *data, const uint32_t length)
{
    return impl_->BinaryGetMetaInfo(binHandle, type, data, length);
}

rtError_t ApiDecorator::FunctionGetMetaInfo(const Kernel * const funcHandle, const rtFunctionMetaType type,
                                            void *data, const uint32_t length)
{
    return impl_->FunctionGetMetaInfo(funcHandle, type, data, length);
}  

rtError_t ApiDecorator::RegisterCpuFunc(rtBinHandle binHandle, const char_t * const funcName,
        const char_t * const kernelName, rtFuncHandle *funcHandle)
{
    return impl_->RegisterCpuFunc(binHandle, funcName, kernelName, funcHandle);
}

rtError_t ApiDecorator::BinaryUnLoad(Program * const binHandle)
{
    return impl_->BinaryUnLoad(binHandle);
}

rtError_t ApiDecorator::BinaryLoadFromFile(const char_t * const binPath, const rtLoadBinaryConfig_t * const optionalCfg,
                                           Program **handle)
{
    return impl_->BinaryLoadFromFile(binPath, optionalCfg, handle);
}

rtError_t ApiDecorator::BinaryLoadFromData(const void * const data, const uint64_t length,
                                           const rtLoadBinaryConfig_t * const optionalCfg, Program **handle)
{
    return impl_->BinaryLoadFromData(data, length, optionalCfg, handle);
}

rtError_t ApiDecorator::FuncGetAddr(const Kernel * const funcHandle, void ** const aicAddr, void ** const aivAddr)
{
    return impl_->FuncGetAddr(funcHandle, aicAddr, aivAddr);
}

rtError_t ApiDecorator::LaunchKernel(Kernel * const kernel, const uint32_t blockDim, const rtArgsEx_t * const argsInfo,
    Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo)
{
    return impl_->LaunchKernel(kernel, blockDim, argsInfo, stm, cfgInfo);
}

rtError_t ApiDecorator::LaunchKernelV2(Kernel * const kernel, uint32_t blockDim, const RtArgsWithType * const argsWithType,
                                       Stream * const stm, const rtKernelLaunchCfg_t * const cfg)
{
    return impl_->LaunchKernelV2(kernel, blockDim, argsWithType, stm, cfg);
}

rtError_t ApiDecorator::LaunchKernelV3(Kernel * const kernel, const rtArgsEx_t * const argsInfo,
    Stream * const stm, const rtLaunchConfig_t * const launchConfig)
{
    return impl_->LaunchKernelV3(kernel, argsInfo, stm, launchConfig);
}

rtError_t ApiDecorator::DatadumpInfoLoad(const void * const dumpInfo, const uint32_t length, const uint32_t flag)
{
    return impl_->DatadumpInfoLoad(dumpInfo, length, flag);
}

rtError_t ApiDecorator::AicpuInfoLoad(const void * const aicpuInfo, const uint32_t length)
{
    return impl_->AicpuInfoLoad(aicpuInfo, length);
}

rtError_t ApiDecorator::SetupArgument(const void * const setupArg, const uint32_t size, const uint32_t offset)
{
    return impl_->SetupArgument(setupArg, size, offset);
}

rtError_t ApiDecorator::KernelTransArgSet(const void * const ptr, const uint64_t size, const uint32_t flag,
    void ** const setupArg)
{
    return impl_->KernelTransArgSet(ptr, size, flag, setupArg);
}

rtError_t ApiDecorator::KernelFusionStart(Stream * const stm)
{
    return impl_->KernelFusionStart(stm);
}

rtError_t ApiDecorator::KernelFusionEnd(Stream * const stm)
{
    return impl_->KernelFusionEnd(stm);
}

rtError_t ApiDecorator::StreamCreate(Stream ** const stm, const int32_t priority, const uint32_t flags, DvppGrp *grp)
{
    return impl_->StreamCreate(stm, priority, flags, grp);
}

rtError_t ApiDecorator::StreamDestroy(Stream * const stm, bool flag)
{
    return impl_->StreamDestroy(stm, flag);
}

rtError_t ApiDecorator::StreamWaitEvent(Stream * const stm, Event * const evt, const uint32_t timeout)
{
    return impl_->StreamWaitEvent(stm, evt, timeout);
}

rtError_t ApiDecorator::StreamSynchronize(Stream * const stm, const int32_t timeout)
{
    return impl_->StreamSynchronize(stm, timeout);
}

rtError_t ApiDecorator::StreamQuery(Stream * const stm)
{
    return impl_->StreamQuery(stm);
}

rtError_t ApiDecorator::NopTask(Stream * const stm)
{
    return impl_->NopTask(stm);
}

rtError_t ApiDecorator::StreamSetMode(Stream * const stm, const uint64_t stmMode)
{
    return impl_->StreamSetMode(stm, stmMode);
}

rtError_t ApiDecorator::StreamGetMode(const Stream * const stm, uint64_t * const stmMode)
{
    return impl_->StreamGetMode(stm, stmMode);
}

rtError_t ApiDecorator::GetMaxStreamAndTask(const uint32_t streamType, uint32_t * const maxStrCount,
    uint32_t * const maxTaskCount)
{
    return impl_->GetMaxStreamAndTask(streamType, maxStrCount, maxTaskCount);
}

rtError_t ApiDecorator::GetAvailStreamNum(const uint32_t streamType, uint32_t * const streamCount)
{
    return impl_->GetAvailStreamNum(streamType, streamCount);
}

rtError_t ApiDecorator::GetFreeStreamNum(uint32_t * const streamCount)
{
    return impl_->GetFreeStreamNum(streamCount);
}

rtError_t ApiDecorator::GetAvailEventNum(uint32_t * const eventCount)
{
    return impl_->GetAvailEventNum(eventCount);
}

rtError_t ApiDecorator::GetTaskIdAndStreamID(uint32_t * const taskId, uint32_t * const streamId)
{
    return impl_->GetTaskIdAndStreamID(taskId, streamId);
}

rtError_t ApiDecorator::GetMaxModelNum(uint32_t * const maxModelCount)
{
    return impl_->GetMaxModelNum(maxModelCount);
}

rtError_t ApiDecorator::GetStreamId(Stream * const stm, int32_t * const streamId)
{
    return impl_->GetStreamId(stm, streamId);
}

rtError_t ApiDecorator::GetSqId(Stream * const stm, uint32_t * const sqId)
{
    return impl_->GetSqId(stm, sqId);
}

rtError_t ApiDecorator::GetCqId(Stream * const stm, uint32_t * const cqId, uint32_t * const logicCqId)
{
    return impl_->GetCqId(stm, cqId, logicCqId);
}

rtError_t ApiDecorator::StreamGetPriority(Stream * const stm, uint32_t * const priority)
{
    return impl_->StreamGetPriority(stm, priority);
}

rtError_t ApiDecorator::StreamGetFlags(Stream * const stm, uint32_t * const flags)
{
    return impl_->StreamGetFlags(stm, flags);
}

rtError_t ApiDecorator::EventCreate(Event ** const evt, const uint64_t flag)
{
    return impl_->EventCreate(evt, flag);
}

rtError_t ApiDecorator::EventCreateEx(Event ** const evt, const uint64_t flag)
{
    return impl_->EventCreateEx(evt, flag);
}

rtError_t ApiDecorator::EventCreateForNotify(Event ** const evt)
{
    return impl_->EventCreateForNotify(evt);
}

rtError_t ApiDecorator::EventDestroy(Event *evt)
{
    return impl_->EventDestroy(evt);
}

rtError_t ApiDecorator::EventDestroySync(Event *evt)
{
    return impl_->EventDestroySync(evt);
}

rtError_t ApiDecorator::EventRecord(Event * const evt, Stream * const stm)
{
    return impl_->EventRecord(evt, stm);
}

rtError_t ApiDecorator::EventRecordForNotify(Event * const evt, Stream * const stm)
{
    return impl_->EventRecordForNotify(evt, stm);
}

rtError_t ApiDecorator::EventReset(Event * const evt, Stream * const stm)
{
    return impl_->EventReset(evt, stm);
}

rtError_t ApiDecorator::GetEventID(Event * const evt, uint32_t * const evtId)
{
    return impl_->GetEventID(evt, evtId);
}

rtError_t ApiDecorator::EventSynchronize(Event * const evt, const int32_t timeout)
{
    return impl_->EventSynchronize(evt, timeout);
}

rtError_t ApiDecorator::EventQuery(Event * const evt)
{
    return impl_->EventQuery(evt);
}

rtError_t ApiDecorator::EventQueryStatus(Event * const evt, rtEventStatus_t * const status)
{
    return impl_->EventQueryStatus(evt, status);
}

rtError_t ApiDecorator::EventQueryWaitStatus(Event * const evt, rtEventWaitStatus_t * const status)
{
    return impl_->EventQueryWaitStatus(evt, status);
}

rtError_t ApiDecorator::EventElapsedTime(float32_t * const retTime, Event * const startEvt, Event * const endEvt)
{
    return impl_->EventElapsedTime(retTime, startEvt, endEvt);
}

rtError_t ApiDecorator::EventGetTimeStamp(uint64_t * const retTime, Event * const evt)
{
    return impl_->EventGetTimeStamp(retTime, evt);
}

rtError_t ApiDecorator::IpcGetEventHandle(IpcEvent * const evt, rtIpcEventHandle_t *handle)
{
    return impl_->IpcGetEventHandle(evt, handle);
}

rtError_t ApiDecorator::IpcOpenEventHandle(rtIpcEventHandle_t *handle, IpcEvent** const event)
{
    return impl_->IpcOpenEventHandle(handle, event);
}

rtError_t ApiDecorator::DevMalloc(void ** const devPtr, const uint64_t size, const rtMemType_t type,
    const uint16_t moduleId)
{
    return impl_->DevMalloc(devPtr, size, type, moduleId);
}

rtError_t ApiDecorator::DevFree(void * const devPtr)
{
    return impl_->DevFree(devPtr);
}

rtError_t ApiDecorator::DevDvppMalloc(void ** const devPtr, const uint64_t size, const uint32_t flag,
    const uint16_t moduleId)
{
    return impl_->DevDvppMalloc(devPtr, size, flag, moduleId);
}

rtError_t ApiDecorator::DevDvppFree(void * const devPtr)
{
    return impl_->DevDvppFree(devPtr);
}

rtError_t ApiDecorator::HostMalloc(void ** const hostPtr, const uint64_t size, const uint16_t moduleId)
{
    return impl_->HostMalloc(hostPtr, size, moduleId);
}

rtError_t ApiDecorator::HostMallocWithCfg(void ** const hostPtr, const uint64_t size,
    const rtMallocConfig_t *cfg)
{
    return impl_->HostMallocWithCfg(hostPtr, size, cfg);
}

rtError_t ApiDecorator::HostFree(void * const hostPtr)
{
    return impl_->HostFree(hostPtr);
}

rtError_t ApiDecorator::MallocHostSharedMemory(rtMallocHostSharedMemoryIn * const in,
    rtMallocHostSharedMemoryOut * const out)
{
    return impl_->MallocHostSharedMemory(in, out);
}

rtError_t ApiDecorator::FreeHostSharedMemory(rtFreeHostSharedMemoryIn * const in)
{
    return impl_->FreeHostSharedMemory(in);
}

rtError_t ApiDecorator::HostRegister(void *ptr, uint64_t size, rtHostRegisterType type, void **devPtr)
{
    return impl_->HostRegister(ptr, size, type, devPtr);
}

rtError_t ApiDecorator::HostUnregister(void *ptr)
{
    return impl_->HostUnregister(ptr);
}

rtError_t ApiDecorator::ManagedMemAlloc(void ** const ptr, const uint64_t size, const uint32_t flag,
    const uint16_t moduleId)
{
    return impl_->ManagedMemAlloc(ptr, size, flag, moduleId);
}

rtError_t ApiDecorator::ManagedMemFree(const void * const ptr)
{
    return impl_->ManagedMemFree(ptr);
}

rtError_t ApiDecorator::MemAdvise(void *devPtr, uint64_t count, uint32_t advise)
{
    return impl_->MemAdvise(devPtr, count, advise);
}

rtError_t ApiDecorator::DevMallocCached(void ** const devPtr, const uint64_t size, const rtMemType_t type,
    const uint16_t moduleId)
{
    return impl_->DevMallocCached(devPtr, size, type, moduleId);
}

rtError_t ApiDecorator::FlushCache(const uint64_t base, const size_t len)
{
    return impl_->FlushCache(base, len);
}

rtError_t ApiDecorator::InvalidCache(const uint64_t base, const size_t len)
{
    return impl_->InvalidCache(base, len);
}

rtError_t ApiDecorator::MemCopySync(void * const dst, const uint64_t destMax, const void * const src,
    const uint64_t cnt, const rtMemcpyKind_t kind, const uint32_t checkKind)
{
    return impl_->MemCopySync(dst, destMax, src, cnt, kind, checkKind);
}

rtError_t ApiDecorator::MemCopySyncEx(void * const dst, const uint64_t destMax, const void * const src,
    const uint64_t cnt, const rtMemcpyKind_t kind)
{
    return impl_->MemCopySyncEx(dst, destMax, src, cnt, kind);
}

rtError_t ApiDecorator::MemcpyAsync(void * const dst, const uint64_t destMax, const void * const src,
    const uint64_t cnt, const rtMemcpyKind_t kind, Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo,
    const rtD2DAddrCfgInfo_t * const addrCfg, bool checkKind, const rtMemcpyConfig_t * const memcpyConfig)
{
    return impl_->MemcpyAsync(dst, destMax, src, cnt, kind, stm, cfgInfo, addrCfg, checkKind, memcpyConfig);
}

rtError_t ApiDecorator::LaunchSqeUpdateTask(uint32_t streamId, uint32_t taskId, void *src, uint64_t cnt,
    Stream * const stm, bool needCpuTask)
{
    return impl_->LaunchSqeUpdateTask(streamId, taskId, src, cnt, stm, needCpuTask);
}

rtError_t ApiDecorator::MemcpyAsyncPtr(void * const memcpyAddrInfo, const uint64_t destMax,
    const uint64_t count, Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo, const bool isMemcpyDesc)
{
    return impl_->MemcpyAsyncPtr(memcpyAddrInfo, destMax, count, stm, cfgInfo, isMemcpyDesc);
}

rtError_t ApiDecorator::RtsMemcpyAsync(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cnt,
    const rtMemcpyKind kind, rtMemcpyConfig_t * const config, Stream * const stm) 
{
    UNUSED(dst);
    UNUSED(destMax);
    UNUSED(src);
    UNUSED(cnt);
    UNUSED(kind);
    UNUSED(config);
    UNUSED(stm);
    return RT_ERROR_NONE;
}

rtError_t ApiDecorator::RtsMemcpy(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cnt,
    const rtMemcpyKind kind, rtMemcpyConfig_t * const config)
{
    UNUSED(dst);
    UNUSED(destMax);
    UNUSED(src);
    UNUSED(cnt);
    UNUSED(kind);
    UNUSED(config);
    return RT_ERROR_NONE;
}

rtError_t ApiDecorator::SetMemcpyDesc(rtMemcpyDesc_t desc, const void * const srcAddr, const void * const dstAddr,
    const size_t count, const rtMemcpyKind kind, rtMemcpyConfig_t * const config)
{
    return impl_->SetMemcpyDesc(desc, srcAddr, dstAddr, count, kind, config);
}

rtError_t ApiDecorator::MemcpyAsyncWithDesc(rtMemcpyDesc_t desc, Stream *stm, const rtMemcpyKind kind,
    rtMemcpyConfig_t * const config)
{
    UNUSED(desc);
    UNUSED(stm);
    UNUSED(kind);
    UNUSED(config);
    return RT_ERROR_NONE;
}

rtError_t ApiDecorator::GetDevArgsAddr(Stream *stm, rtArgsEx_t *argsInfo, void **devArgsAddr, void **argsHandle)
{
    return impl_->GetDevArgsAddr(static_cast<Stream *>(stm), argsInfo, devArgsAddr, argsHandle);
}

rtError_t ApiDecorator::ReduceAsync(void * const dst, const void * const src, const uint64_t cnt,
    const rtRecudeKind_t kind, const rtDataType_t type, Stream * const stm,
    const rtTaskCfgInfo_t * const cfgInfo)
{
    return impl_->ReduceAsync(dst, src, cnt, kind, type, stm, cfgInfo);
}

rtError_t ApiDecorator::ReduceAsyncV2(void * const dst, const void * const src, const uint64_t cnt,
    const rtRecudeKind_t kind, const rtDataType_t type, Stream * const stm, void * const overflowAddr)
{
    return impl_->ReduceAsyncV2(dst, src, cnt, kind, type, stm, overflowAddr);
}

rtError_t ApiDecorator::MemSetSync(const void * const devPtr, const uint64_t destMax, const uint32_t val,
    const uint64_t cnt)
{
    return impl_->MemSetSync(devPtr, destMax, val, cnt);
}

rtError_t ApiDecorator::MemsetAsync(void * const ptr, const uint64_t destMax, const uint32_t val,
    const uint64_t cnt, Stream * const stm)
{
    return impl_->MemsetAsync(ptr, destMax, val, cnt, stm);
}

rtError_t ApiDecorator::MemGetInfoByDeviceId(uint32_t deviceId, bool isHugeOnly, size_t* const freeSize, size_t* const totalSize)
{
    return impl_->MemGetInfoByDeviceId(deviceId, isHugeOnly, freeSize, totalSize);
}

rtError_t ApiDecorator::MemGetInfo(size_t * const freeSize, size_t * const totalSize)
{
    return impl_->MemGetInfo(freeSize, totalSize);
}

rtError_t ApiDecorator::MemGetInfoByType(const int32_t devId, const rtMemType_t type, rtMemInfo_t * const info)
{
    return impl_->MemGetInfoByType(devId, type, info);
}
 
rtError_t ApiDecorator::CheckMemType(void **addrs, uint32_t size, uint32_t memType, uint32_t *checkResult, uint32_t reserve)
{
    return impl_->CheckMemType(addrs, size, memType, checkResult, reserve);
}

rtError_t ApiDecorator::GetMemUsageInfo(const uint32_t deviceId, rtMemUsageInfo_t * const memUsageInfo,
                                        const size_t inputNum, size_t * const outputNum)
{
    return impl_->GetMemUsageInfo(deviceId, memUsageInfo, inputNum, outputNum);
}

rtError_t ApiDecorator::MemGetInfoEx(const rtMemInfoType_t memInfoType, size_t * const freeSize,
    size_t * const totalSize)
{
    return impl_->MemGetInfoEx(memInfoType, freeSize, totalSize);
}

rtError_t ApiDecorator::MemGetL2Info(Stream * const stm, void ** const ptr, uint32_t * const size)
{
    return impl_->MemGetL2Info(stm, ptr, size);
}

rtError_t ApiDecorator::PointerGetAttributes(rtPointerAttributes_t * const attributes, const void * const ptr)
{
    return impl_->PointerGetAttributes(attributes, ptr);
}

rtError_t ApiDecorator::PtrGetAttributes(const void * const ptr, rtPtrAttributes_t * const attributes)
{
    return impl_->PtrGetAttributes(ptr, attributes);
}

rtError_t ApiDecorator::MemPrefetchToDevice(const void * const devPtr, const uint64_t len, const int32_t devId)
{
    return impl_->MemPrefetchToDevice(devPtr, len, devId);
}

rtError_t ApiDecorator::GetDeviceCount(int32_t * const cnt)
{
    return impl_->GetDeviceCount(cnt);
}

rtError_t ApiDecorator::OpenNetService(const rtNetServiceOpenArgs *args)
{
    return impl_->OpenNetService(args);
}

rtError_t ApiDecorator::CloseNetService()
{
    return impl_->CloseNetService();
}

rtError_t ApiDecorator::GetDeviceIDs(uint32_t * const devId, const uint32_t len)
{
    return impl_->GetDeviceIDs(devId, len);
}

rtError_t ApiDecorator::SetDevice(const int32_t devId)
{
    return impl_->SetDevice(devId);
}

rtError_t ApiDecorator::GetDevice(int32_t * const devId)
{
    return impl_->GetDevice(devId);
}

rtError_t ApiDecorator::GetDevicePhyIdByIndex(const uint32_t devIndex, uint32_t * const phyId)
{
    return impl_->GetDevicePhyIdByIndex(devIndex, phyId);
}

rtError_t ApiDecorator::GetDeviceIndexByPhyId(const uint32_t phyId, uint32_t * const devIndex)
{
    return impl_->GetDeviceIndexByPhyId(phyId, devIndex);
}

rtError_t ApiDecorator::DeviceReset(const int32_t devId, const bool isForceReset)
{
    return impl_->DeviceReset(devId, isForceReset);
}

rtError_t ApiDecorator::DeviceSetLimit(const int32_t devId, const rtLimitType_t type, const uint32_t val)
{
    return impl_->DeviceSetLimit(devId, type, val);
}

rtError_t ApiDecorator::DeviceSynchronize(const int32_t timeout)
{
    return impl_->DeviceSynchronize(timeout);
}

rtError_t ApiDecorator::DeviceTaskAbort(const int32_t devId, const uint32_t timeout)
{
    return impl_->DeviceTaskAbort(devId, timeout);
}

rtError_t ApiDecorator::SnapShotProcessBackup()
{
    return impl_->SnapShotProcessBackup();
}

rtError_t ApiDecorator::SnapShotProcessRestore()
{
    return impl_->SnapShotProcessRestore();
}

rtError_t ApiDecorator::DeviceGetStreamPriorityRange(int32_t * const leastPriority, int32_t * const greatestPriority)
{
    return impl_->DeviceGetStreamPriorityRange(leastPriority, greatestPriority);
}

rtError_t ApiDecorator::GetDeviceInfo(const uint32_t deviceId, const int32_t moduleType, const int32_t infoType,
    int64_t * const val)
{
    return impl_->GetDeviceInfo(deviceId, moduleType, infoType, val);
}

rtError_t ApiDecorator::GetDeviceInfoFromPlatformInfo(const uint32_t deviceId, const std::string &label,
    const std::string &key, int64_t * const value)
{
    return impl_->GetDeviceInfoFromPlatformInfo(deviceId, label, key, value);
}

rtError_t ApiDecorator::GetDeviceInfoByAttr(uint32_t deviceId, rtDevAttr attr, int64_t *val)
{
    return impl_->GetDeviceInfoByAttr(deviceId, attr, val);
}

rtError_t ApiDecorator::GetPhyDeviceInfo(const uint32_t phyId, const int32_t moduleType, const int32_t infoType,
    int64_t * const val)
{
    return impl_->GetPhyDeviceInfo(phyId, moduleType, infoType, val);
}

rtError_t ApiDecorator::DeviceSetTsId(const uint32_t tsId)
{
    return impl_->DeviceSetTsId(tsId);
}

rtError_t ApiDecorator::SetDeviceFailureMode(uint64_t failureMode)
{
    return impl_->SetDeviceFailureMode(failureMode);
}

rtError_t ApiDecorator::EnableP2P(const uint32_t devIdDes, const uint32_t phyIdSrc, const uint32_t flag)
{
    return impl_->EnableP2P(devIdDes, phyIdSrc, flag);
}

rtError_t ApiDecorator::DisableP2P(const uint32_t devIdDes, const uint32_t phyIdSrc)
{
    return impl_->DisableP2P(devIdDes, phyIdSrc);
}

rtError_t ApiDecorator::DeviceCanAccessPeer(int32_t * const canAccessPeer, const uint32_t devId,
    const uint32_t peerDevice)
{
    return impl_->DeviceCanAccessPeer(canAccessPeer, devId, peerDevice);
}

rtError_t ApiDecorator::GetP2PStatus(const uint32_t devIdDes, const uint32_t phyIdSrc, uint32_t * const status)
{
    return impl_->GetP2PStatus(devIdDes, phyIdSrc, status);
}

rtError_t ApiDecorator::DeviceGetBareTgid(uint32_t * const pid)
{
    return impl_->DeviceGetBareTgid(pid);
}

rtError_t ApiDecorator::ContextCreate(Context ** const inCtx, const int32_t devId)
{
    return impl_->ContextCreate(inCtx, devId);
}

rtError_t ApiDecorator::ContextDestroy(Context * const inCtx)
{
    return impl_->ContextDestroy(inCtx);
}

rtError_t ApiDecorator::ContextSetCurrent(Context * const inCtx)
{
    return impl_->ContextSetCurrent(inCtx);
}

rtError_t ApiDecorator::ContextGetCurrent(Context ** const inCtx)
{
    return impl_->ContextGetCurrent(inCtx);
}

rtError_t ApiDecorator::ContextGetDevice(int32_t * const devId)
{
    return impl_->ContextGetDevice(devId);
}

rtError_t ApiDecorator::ModelCreate(Model ** const mdl, const uint32_t flag)
{
    return impl_->ModelCreate(mdl, flag);
}

rtError_t ApiDecorator::ModelSetExtId(Model * const mdl, const uint32_t extId)
{
    return impl_->ModelSetExtId(mdl, extId);
}

rtError_t ApiDecorator::ModelDestroy(Model * const mdl)
{
    return impl_->ModelDestroy(mdl);
}

rtError_t ApiDecorator::ModelBindStream(Model * const mdl, Stream * const stm, const uint32_t flag)
{
    return impl_->ModelBindStream(mdl, stm, flag);
}

rtError_t ApiDecorator::ModelUnbindStream(Model * const mdl, Stream * const stm)
{
    return impl_->ModelUnbindStream(mdl, stm);
}

rtError_t ApiDecorator::ModelLoadComplete(Model * const mdl)
{
    return impl_->ModelLoadComplete(mdl);
}

rtError_t ApiDecorator::ModelExecute(Model * const mdl, Stream * const stm, const uint32_t flag, int32_t timeout)
{
    return impl_->ModelExecute(mdl, stm, flag, timeout);
}

rtError_t ApiDecorator::ModelExecuteSync(Model * const mdl, int32_t timeout)
{
    return impl_->ModelExecuteSync(mdl, timeout);
}

rtError_t ApiDecorator::ModelExecuteAsync(Model * const mdl, Stream * const stm)
{
    return impl_->ModelExecuteAsync(mdl, stm);
}

rtError_t ApiDecorator::ModelGetTaskId(Model * const mdl, uint32_t * const taskId, uint32_t * const streamId)
{
    return impl_->ModelGetTaskId(mdl, taskId, streamId);
}

rtError_t ApiDecorator::ModelGetId(Model * const mdl, uint32_t * const modelId)
{
    return impl_->ModelGetId(mdl, modelId);
}

rtError_t ApiDecorator::DebugRegister(Model * const mdl, const uint32_t flag, const void * const addr,
    uint32_t * const streamId, uint32_t * const taskId)
{
    return impl_->DebugRegister(mdl, flag, addr, streamId, taskId);
}

rtError_t ApiDecorator::DebugUnRegister(Model * const mdl)
{
    return impl_->DebugUnRegister(mdl);
}

rtError_t ApiDecorator::DebugRegisterForStream(Stream * const stm, const uint32_t flag, const void * const addr,
    uint32_t * const streamId, uint32_t * const taskId)
{
    return impl_->DebugRegisterForStream(stm, flag, addr, streamId, taskId);
}

rtError_t ApiDecorator::DebugUnRegisterForStream(Stream * const stm)
{
    return impl_->DebugUnRegisterForStream(stm);
}

rtError_t ApiDecorator::ModelSetSchGroupId(Model * const mdl, const int16_t schGrpId)
{
    return impl_->ModelSetSchGroupId(mdl, schGrpId);
}

rtError_t ApiDecorator::ModelTaskUpdate(Stream *desStm, uint32_t desTaskId, Stream *sinkStm,
                                        rtMdlTaskUpdateInfo_t *para)
{
    return impl_->ModelTaskUpdate(desStm, desTaskId, sinkStm, para);
}

rtError_t ApiDecorator::ModelEndGraph(Model * const mdl, Stream * const stm, const uint32_t flags)
{
    return impl_->ModelEndGraph(mdl, stm, flags);
}

rtError_t ApiDecorator::ModelExecutorSet(Model * const mdl, const uint8_t flags)
{
    return impl_->ModelExecutorSet(mdl, flags);
}

rtError_t ApiDecorator::ModelAbort(Model * const mdl)
{
    return impl_->ModelAbort(mdl);
}

rtError_t ApiDecorator::ModelExit(Model * const mdl, Stream * const stm)
{
    return impl_->ModelExit(mdl, stm);
}


rtError_t ApiDecorator::ModelBindQueue(Model * const mdl, const uint32_t queueId, const rtModelQueueFlag_t flag)
{
    return impl_->ModelBindQueue(mdl, queueId, flag);
}

rtError_t ApiDecorator::GetAiCoreCount(uint32_t * const aiCoreCnt)
{
    return impl_->GetAiCoreCount(aiCoreCnt);
}

rtError_t ApiDecorator::GetAiCpuCount(uint32_t * const aiCpuCnt)
{
    return impl_->GetAiCpuCount(aiCpuCnt);
}

rtError_t ApiDecorator::GetAiCoreSpec(rtAiCoreSpec_t * const aiCoreSpec)
{
    return impl_->GetAiCoreSpec(aiCoreSpec);
}

rtError_t ApiDecorator::GetAiCoreMemorySizes(rtAiCoreMemorySize_t * const aiCoreMemorySize)
{
    return impl_->GetAiCoreMemorySizes(aiCoreMemorySize);
}

rtError_t ApiDecorator::GetAiCoreMemoryRates(rtAiCoreMemoryRates_t * const aiCoreMemoryRates)
{
    return impl_->GetAiCoreMemoryRates(aiCoreMemoryRates);
}

rtError_t ApiDecorator::GetMemoryConfig(rtMemoryConfig_t * const memoryConfig)
{
    return impl_->GetMemoryConfig(memoryConfig);
}

rtError_t ApiDecorator::SetAiCoreMemorySizes(rtAiCoreMemorySize_t * const aiCoreMemorySize)
{
    return impl_->SetAiCoreMemorySizes(aiCoreMemorySize);
}

rtError_t ApiDecorator::SetExceptCallback(const rtErrorCallback callback)
{
    return impl_->SetExceptCallback(callback);
}

rtError_t ApiDecorator::SetTaskAbortCallBack(const char_t *regName, void *callback, void *args,
    TaskAbortCallbackType type)
{
    return impl_->SetTaskAbortCallBack(regName, callback, args, type);
}

rtError_t ApiDecorator::SetTaskFailCallback(void *callback, void *args, TaskFailCallbackType type)
{
    return impl_->SetTaskFailCallback(callback, args, type);
}

rtError_t ApiDecorator::RegDeviceStateCallback(const char_t *regName, void *callback, void *args,
    DeviceStateCallback type, rtDevCallBackDir_t notifyPos)
{
    return impl_->RegDeviceStateCallback(regName, callback, args, type, notifyPos);
}

rtError_t ApiDecorator::RegProfCtrlCallback(const uint32_t moduleId, const rtProfCtrlHandle callback)
{
    return impl_->RegProfCtrlCallback(moduleId, callback);
}

rtError_t ApiDecorator::RegTaskFailCallbackByModule(const char_t *regName, void *callback, void *args,
    TaskFailCallbackType type)
{
    return impl_->RegTaskFailCallbackByModule(regName, callback, args, type);
}

rtError_t ApiDecorator::IpcSetMemoryName(const void * const ptr, const uint64_t byteCount, char_t * const name,
    const uint32_t len, const uint64_t flags)
{
    return impl_->IpcSetMemoryName(ptr, byteCount, name, len, flags);
}

rtError_t ApiDecorator::IpcSetMemoryAttr(const char *name, uint32_t type, uint64_t attr)
{
    return impl_->IpcSetMemoryAttr(name, type, attr);
}
rtError_t ApiDecorator::IpcOpenMemory(void ** const ptr, const char_t * const name, const uint64_t flags)
{
    return impl_->IpcOpenMemory(ptr, name, flags);
}

rtError_t ApiDecorator::IpcCloseMemory(const void * const ptr)
{
    return impl_->IpcCloseMemory(ptr);
}

rtError_t ApiDecorator::IpcCloseMemoryByName(const char_t * const name)
{
    return impl_->IpcCloseMemoryByName(name);
}

rtError_t ApiDecorator::IpcDestroyMemoryName(const char_t * const name)
{
    return impl_->IpcDestroyMemoryName(name);
}

rtError_t ApiDecorator::RDMASend(const uint32_t sqIndex, const uint32_t wqeIndex, Stream * const stm)
{
    return impl_->RDMASend(sqIndex, wqeIndex, stm);
}

rtError_t ApiDecorator::RdmaDbSend(const uint32_t dbIndex, const uint64_t dbInfo, Stream * const stm)
{
    return impl_->RdmaDbSend(dbIndex, dbInfo, stm);
}

rtError_t ApiDecorator::NotifyCreate(const int32_t deviceId, Notify ** const retNotify, uint64_t flag)
{
    return impl_->NotifyCreate(deviceId, retNotify, flag);
}

rtError_t ApiDecorator::NotifyDestroy(Notify * const inNotify)
{
    return impl_->NotifyDestroy(inNotify);
}

rtError_t ApiDecorator::NotifyRecord(Notify * const inNotify, Stream * const stm)
{
    return impl_->NotifyRecord(inNotify, stm);
}

rtError_t ApiDecorator::NotifyWait(Notify * const inNotify, Stream * const stm, const uint32_t timeOut)
{
    return impl_->NotifyWait(inNotify, stm, timeOut);
}

rtError_t ApiDecorator::GetNotifyID(Notify * const inNotify, uint32_t * const notifyID)
{
    return impl_->GetNotifyID(inNotify, notifyID);
}

rtError_t ApiDecorator::GetNotifyPhyInfo(Notify *const inNotify, rtNotifyPhyInfo *notifyInfo)
{
    return impl_->GetNotifyPhyInfo(inNotify, notifyInfo);
}

rtError_t ApiDecorator::IpcSetNotifyName(Notify * const inNotify, char_t * const name, const uint32_t len, const uint64_t flag)
{
    return impl_->IpcSetNotifyName(inNotify, name, len, flag);
}

rtError_t ApiDecorator::IpcOpenNotify(Notify ** const retNotify, const char_t * const name, uint32_t flag)
{
    return impl_->IpcOpenNotify(retNotify, name, flag);
}

rtError_t ApiDecorator::NotifyGetAddrOffset(Notify * const inNotify, uint64_t * const devAddrOffset)
{
    return impl_->NotifyGetAddrOffset(inNotify, devAddrOffset);
}

rtError_t ApiDecorator::StreamSwitchEx(void * const ptr, const rtCondition_t condition, void * const valuePtr,
    Stream * const trueStream, Stream * const stm, const rtSwitchDataType_t dataType)
{
    return impl_->StreamSwitchEx(ptr, condition, valuePtr, trueStream, stm, dataType);
}

rtError_t ApiDecorator::StreamSwitchN(void * const ptr, const uint32_t size, void * const valuePtr,
    Stream ** const trueStreamPtr, const uint32_t elementSize, Stream * const stm, const rtSwitchDataType_t dataType)
{
    return impl_->StreamSwitchN(ptr, size, valuePtr, trueStreamPtr, elementSize, stm, dataType);
}

rtError_t ApiDecorator::StreamActive(Stream * const activeStream, Stream * const stm)
{
    return impl_->StreamActive(activeStream, stm);
}

rtError_t ApiDecorator::LabelCreate(Label ** const lbl, Model * const mdl)
{
    return impl_->LabelCreate(lbl, mdl);
}

rtError_t ApiDecorator::LabelDestroy(Label * const lbl)
{
    return impl_->LabelDestroy(lbl);
}

rtError_t ApiDecorator::LabelSet(Label * const lbl, Stream * const stm)
{
    return impl_->LabelSet(lbl, stm);
}

rtError_t ApiDecorator::LabelGoto(Label * const lbl, Stream * const stm)
{
    return impl_->LabelGoto(lbl, stm);
}

rtError_t ApiDecorator::ProfilerTrace(const uint64_t id, const bool notifyFlag, const uint32_t flags,
    Stream * const stm)
{
    return impl_->ProfilerTrace(id, notifyFlag, flags, stm);
}

rtError_t ApiDecorator::ProfilerTraceEx(const uint64_t id, const uint64_t modelId, const uint16_t tagId,
    Stream * const stm)
{
    return impl_->ProfilerTraceEx(id, modelId, tagId, stm);
}

rtError_t ApiDecorator::SetIpcNotifyPid(const char_t * const name, int32_t pid[], const int32_t num)
{
    return impl_->SetIpcNotifyPid(name, pid, num);
}

rtError_t ApiDecorator::SetIpcMemPid(const char_t * const name, int32_t pid[], const int32_t num)
{
    return impl_->SetIpcMemPid(name, pid, num);
}

rtError_t ApiDecorator::SubscribeReport(const uint64_t threadId, Stream * const stm)
{
    return impl_->SubscribeReport(threadId, stm);
}

rtError_t ApiDecorator::CallbackLaunch(const rtCallback_t callBackFunc, void * const fnData, Stream * const stm,
    const bool isBlock)
{
    return impl_->CallbackLaunch(callBackFunc, fnData, stm, isBlock);
}

rtError_t ApiDecorator::ProcessReport(const int32_t timeout, const bool noLog)
{
    return impl_->ProcessReport(timeout, noLog);
}

rtError_t ApiDecorator::UnSubscribeReport(const uint64_t threadId, Stream * const stm)
{
    return impl_->UnSubscribeReport(threadId, stm);
}

rtError_t ApiDecorator::GetRunMode(rtRunMode * const runMode)
{
    return impl_->GetRunMode(runMode);
}

rtError_t ApiDecorator::GetAicpuDeploy(rtAicpuDeployType_t * const deployType)
{
    return impl_->GetAicpuDeploy(deployType);
}

rtError_t ApiDecorator::StartOnlineProf(Stream * const stm, const uint32_t sampleNum)
{
    return impl_->StartOnlineProf(stm, sampleNum);
}

rtError_t ApiDecorator::StopOnlineProf(Stream * const stm)
{
    return impl_->StopOnlineProf(stm);
}

rtError_t ApiDecorator::GetOnlineProfData(Stream * const stm, rtProfDataInfo_t * const pProfData,
    const uint32_t profDataNum)
{
    return impl_->GetOnlineProfData(stm, pProfData, profDataNum);
}

rtError_t ApiDecorator::AdcProfiler(const uint64_t addr, const uint32_t length)
{
    return impl_->AdcProfiler(addr, length);
}

rtError_t ApiDecorator::SetMsprofReporterCallback(const MsprofReporterCallback callback)
{
    return impl_->SetMsprofReporterCallback(callback);
}

rtError_t ApiDecorator::LabelSwitchByIndex(void * const ptr, const uint32_t maxVal, void * const labelInfoPtr,
    Stream * const stm)
{
    return impl_->LabelSwitchByIndex(ptr, maxVal, labelInfoPtr, stm);
}

rtError_t ApiDecorator::LabelGotoEx(Label * const lbl, Stream * const stm)
{
    return impl_->LabelGotoEx(lbl, stm);
}

rtError_t ApiDecorator::LabelListCpy(Label ** const lbl, const uint32_t labelNumber, void * const dst,
    const uint32_t dstMax)
{
    return impl_->LabelListCpy(lbl, labelNumber, dst, dstMax);
}

rtError_t ApiDecorator::LabelCreateEx(Label ** const lbl, Model * const mdl, Stream * const stm)
{
    return impl_->LabelCreateEx(lbl, mdl, stm);
}

rtError_t ApiDecorator::LabelSwitchListCreate(Label ** const labels, const size_t num, void ** const labelList)
{
    return impl_->LabelSwitchListCreate(labels, num, labelList);
}

rtError_t ApiDecorator::GetPairDevicesInfo(const uint32_t devId, const uint32_t otherDevId, const int32_t infoType,
    int64_t * const val)
{
    return impl_->GetPairDevicesInfo(devId, otherDevId, infoType, val);
}

rtError_t ApiDecorator::GetPairPhyDevicesInfo(const uint32_t devId, const uint32_t otherDevId, const int32_t infoType,
    int64_t * const val)
{
    return impl_->GetPairPhyDevicesInfo(devId, otherDevId, infoType, val);
}

rtError_t ApiDecorator::GetRtCapability(const rtFeatureType_t featureType, const int32_t featureInfo,
    int64_t * const val)
{
    return impl_->GetRtCapability(featureType, featureInfo, val);
}

rtError_t ApiDecorator::GetDeviceCapability(const int32_t deviceId, const int32_t moduleType,
    const int32_t featureType, int32_t * const val)
{
    return impl_->GetDeviceCapability(deviceId, moduleType, featureType, val);
}

rtError_t ApiDecorator::GetFaultEvent(const int32_t deviceId, rtDmsEventFilter *filter,
    rtDmsFaultEvent *dmsEvent, uint32_t len, uint32_t *eventCount)
{
    return impl_->GetFaultEvent(deviceId, filter, dmsEvent, len, eventCount);
}

rtError_t ApiDecorator::GetMemUceInfo(const uint32_t deviceId, rtMemUceInfo *memUceInfo)
{
    return impl_->GetMemUceInfo(deviceId, memUceInfo);
}

rtError_t ApiDecorator::MemUceRepair(const uint32_t deviceId, rtMemUceInfo *memUceInfo)
{
    return impl_->MemUceRepair(deviceId, memUceInfo);
}

rtError_t ApiDecorator::SetOpWaitTimeOut(const uint32_t timeout)
{
    return impl_->SetOpWaitTimeOut(timeout);
}

rtError_t ApiDecorator::SetOpExecuteTimeOut(const uint32_t timeout, const RtTaskTimeUnitType timeUnitType)
{
    return impl_->SetOpExecuteTimeOut(timeout, timeUnitType);
}

rtError_t ApiDecorator::GetOpExecuteTimeOut(uint32_t * const timeout)
{
    return impl_->GetOpExecuteTimeOut(timeout);
}

rtError_t ApiDecorator::GetOpExecuteTimeoutV2(uint32_t *const timeout)
{
    return impl_->GetOpExecuteTimeoutV2(timeout);
}

rtError_t ApiDecorator::CheckArchCompatibility(const char_t *omSocVersion, int32_t *canCompatible)
{
    return impl_->CheckArchCompatibility(omSocVersion, canCompatible);
}

rtError_t ApiDecorator::GetOpTimeOutInterval(uint64_t *interval)
{
    return impl_->GetOpTimeOutInterval(interval);
}

rtError_t ApiDecorator::SetOpExecuteTimeOutV2(uint64_t timeout, uint64_t *actualTimeout)
{
    return impl_->SetOpExecuteTimeOutV2(timeout, actualTimeout);
}

rtError_t ApiDecorator::GetDevMsg(const rtGetDevMsgType_t getMsgType, const rtGetMsgCallback callback)
{
    return impl_->GetDevMsg(getMsgType, callback);
}

rtError_t ApiDecorator::SetGroup(const int32_t groupId)
{
    return impl_->SetGroup(groupId);
}

rtError_t ApiDecorator::GetGroupCount(uint32_t * const cnt)
{
    return impl_->GetGroupCount(cnt);
}

rtError_t ApiDecorator::GetGroupInfo(const int32_t groupId, rtGroupInfo_t * const groupInfo, const uint32_t cnt)
{
    return impl_->GetGroupInfo(groupId, groupInfo, cnt);
}

rtError_t ApiDecorator::StarsTaskLaunch(const void * const sqe, const uint32_t sqeLen, Stream * const stm,
    const uint32_t flag)
{
    return impl_->StarsTaskLaunch(sqe, sqeLen, stm, flag);
}

rtError_t ApiDecorator::GetC2cCtrlAddr(uint64_t * const addr, uint32_t * const len)
{
    return impl_->GetC2cCtrlAddr(addr, len);
}

rtError_t ApiDecorator::FftsPlusTaskLaunch(const rtFftsPlusTaskInfo_t * const fftsPlusTaskInfo, Stream * const stm,
    const uint32_t flag)
{
    return impl_->FftsPlusTaskLaunch(fftsPlusTaskInfo, stm, flag);
}

rtError_t ApiDecorator::NpuGetFloatStatus(void * const outputAddrPtr, const uint64_t outputSize,
    const uint32_t checkMode, Stream * const stm)
{
    return impl_->NpuGetFloatStatus(outputAddrPtr, outputSize, checkMode, stm);
}

rtError_t ApiDecorator::NpuClearFloatStatus(const uint32_t checkMode, Stream * const stm)
{
    return impl_->NpuClearFloatStatus(checkMode, stm);
}

rtError_t ApiDecorator::NpuGetFloatDebugStatus(void * const outputAddrPtr, const uint64_t outputSize,
    const uint32_t checkMode, Stream * const stm)
{
    return impl_->NpuGetFloatDebugStatus(outputAddrPtr, outputSize, checkMode, stm);
}

rtError_t ApiDecorator::NpuClearFloatDebugStatus(const uint32_t checkMode, Stream * const stm)
{
    return impl_->NpuClearFloatDebugStatus(checkMode, stm);
}

rtError_t ApiDecorator::ContextSetINFMode(const bool infMode)
{
    return impl_->ContextSetINFMode(infMode);
}

rtError_t ApiDecorator::MemQueueInitQS(const int32_t devId, const char_t * const grpName)
{
    return impl_->MemQueueInitQS(devId, grpName);
}

rtError_t ApiDecorator::MemQueueInitFlowGw(const int32_t devId, const rtInitFlowGwInfo_t * const initInfo)
{
    return impl_->MemQueueInitFlowGw(devId, initInfo);
}

rtError_t ApiDecorator::MemQueueCreate(const int32_t devId, const rtMemQueueAttr_t * const queAttr,
    uint32_t * const qid)
{
    return impl_->MemQueueCreate(devId, queAttr, qid);
}

rtError_t ApiDecorator::MemQueueExport(const int32_t devId, const uint32_t qid, const int32_t peerDevId,
        const char * const shareName) 
{
    return impl_->MemQueueExport(devId, qid, peerDevId, shareName);
}

rtError_t ApiDecorator::MemQueueUnExport(const int32_t devId, const uint32_t qid, const int32_t peerDevId,
        const char * const shareName) 
{
    return impl_->MemQueueUnExport(devId, qid, peerDevId, shareName);
}

rtError_t ApiDecorator::MemQueueImport(const int32_t devId, const int32_t peerDevId, const char * const shareName,
        uint32_t * const qid)
{
    return impl_->MemQueueImport(devId, peerDevId, shareName, qid);
}

rtError_t ApiDecorator::MemQueueUnImport(const int32_t devId, const uint32_t qid, const int32_t peerDevId, 
        const char * const shareName)
{
    return impl_->MemQueueUnImport(devId, qid, peerDevId, shareName);
}

rtError_t ApiDecorator::MemQueueSet(const int32_t devId, const rtMemQueueSetCmdType cmd,
    const rtMemQueueSetInputPara * const input)
{
    return impl_->MemQueueSet(devId, cmd, input);
}

rtError_t ApiDecorator::MemQueueDestroy(const int32_t devId, const uint32_t qid)
{
    return impl_->MemQueueDestroy(devId, qid);
}

rtError_t ApiDecorator::MemQueueInit(const int32_t devId)
{
    return impl_->MemQueueInit(devId);
}

rtError_t ApiDecorator::MemQueueReset(const int32_t devId, const uint32_t qid)
{
    return impl_->MemQueueReset(devId, qid);
}

rtError_t ApiDecorator::MemQueueEnQueue(const int32_t devId, const uint32_t qid, void * const enQBuf)
{
    return impl_->MemQueueEnQueue(devId, qid, enQBuf);
}

rtError_t ApiDecorator::MemQueueDeQueue(const int32_t devId, const uint32_t qid, void ** const deQBuf)
{
    return impl_->MemQueueDeQueue(devId, qid, deQBuf);
}

rtError_t ApiDecorator::MemQueuePeek(const int32_t devId, const uint32_t qid, size_t * const bufLen,
    const int32_t timeout)
{
    return impl_->MemQueuePeek(devId, qid, bufLen, timeout);
}

rtError_t ApiDecorator::MemQueueEnQueueBuff(const int32_t devId, const uint32_t qid, rtMemQueueBuff_t * const inBuf,
    const int32_t timeout)
{
    return impl_->MemQueueEnQueueBuff(devId, qid, inBuf, timeout);
}

rtError_t ApiDecorator::MemQueueDeQueueBuff(const int32_t devId, const uint32_t qid, rtMemQueueBuff_t * const outBuf,
    const int32_t timeout)
{
    return impl_->MemQueueDeQueueBuff(devId, qid, outBuf, timeout);
}

rtError_t ApiDecorator::MemQueueQueryInfo(const int32_t devId, const uint32_t qid,
    rtMemQueueInfo_t * const queryQueueInfo)
{
    return impl_->MemQueueQueryInfo(devId, qid, queryQueueInfo);
}

rtError_t ApiDecorator::MemQueueQuery(const int32_t devId, const rtMemQueueQueryCmd_t cmd, const void * const inBuff,
    const uint32_t inLen, void * const outBuff, uint32_t * const outLen)
{
    return impl_->MemQueueQuery(devId, cmd, inBuff, inLen, outBuff, outLen);
}

rtError_t ApiDecorator::MemQueueGrant(const int32_t devId, const uint32_t qid, const int32_t pid,
    rtMemQueueShareAttr_t * const attr)
{
    return impl_->MemQueueGrant(devId, qid, pid, attr);
}

rtError_t ApiDecorator::MemQueueAttach(const int32_t devId, const uint32_t qid, const int32_t timeOut)
{
    return impl_->MemQueueAttach(devId, qid, timeOut);
}

rtError_t ApiDecorator::EschedSubmitEventSync(const int32_t devId, rtEschedEventSummary_t * const evt,
    rtEschedEventReply_t * const ack)
{
    return impl_->EschedSubmitEventSync(devId, evt, ack);
}

rtError_t ApiDecorator::QueryDevPid(rtBindHostpidInfo_t * const info, int32_t * const devPid)
{
    return impl_->QueryDevPid(info, devPid);
}

rtError_t ApiDecorator::MbufAlloc(rtMbufPtr_t * const mbufPtr, const uint64_t size)
{
    return impl_->MbufAlloc(mbufPtr, size);
}

rtError_t ApiDecorator::BuffAlloc(const uint64_t size, void **buff)
{
    return impl_->BuffAlloc(size, buff);
}

rtError_t ApiDecorator::BuffConfirm(void * const buff, const uint64_t size)
{
    return impl_->BuffConfirm(buff, size);
}

rtError_t ApiDecorator::MbufBuild(void * const buff, const uint64_t size, rtMbufPtr_t * const mbufPtr)
{
    return impl_->MbufBuild(buff, size, mbufPtr);
}

rtError_t ApiDecorator::MbufAllocEx(rtMbufPtr_t * const mbufPtr, const uint64_t size,
    const uint64_t flag, const int32_t grpId)
{
    return impl_->MbufAllocEx(mbufPtr, size, flag, grpId);
}

rtError_t ApiDecorator::BuffFree(void * const buff)
{
    return impl_->BuffFree(buff);
}

rtError_t ApiDecorator::MbufUnBuild(const rtMbufPtr_t mbufPtr, void ** const buff, uint64_t * const size)
{
    return impl_->MbufUnBuild(mbufPtr, buff, size);
}

rtError_t ApiDecorator::MbufGet(const rtMbufPtr_t mbufPtr, void * const buff, const uint64_t size)
{
    return impl_->MbufGet(mbufPtr, buff, size);
}

rtError_t ApiDecorator::MbufPut(const rtMbufPtr_t mbufPtr, void * const buff)
{
    return impl_->MbufPut(mbufPtr, buff);
}

rtError_t ApiDecorator::MbufFree(const rtMbufPtr_t mbufPtr)
{
    return impl_->MbufFree(mbufPtr);
}

rtError_t ApiDecorator::MbufSetDataLen(const rtMbufPtr_t mbufPtr, const uint64_t len)
{
    return impl_->MbufSetDataLen(mbufPtr, len);
}

rtError_t ApiDecorator::MbufGetDataLen(const rtMbufPtr_t mbufPtr, uint64_t *len)
{
    return impl_->MbufGetDataLen(mbufPtr, len);
}

rtError_t ApiDecorator::MbufGetBuffAddr(const rtMbufPtr_t mbufPtr, void ** const buf)
{
    return impl_->MbufGetBuffAddr(mbufPtr, buf);
}

rtError_t ApiDecorator::MbufGetBuffSize(const rtMbufPtr_t mbufPtr, uint64_t * const totalSize)
{
    return impl_->MbufGetBuffSize(mbufPtr, totalSize);
}

rtError_t ApiDecorator::MbufGetPrivInfo(const rtMbufPtr_t mbufPtr, void ** const priv, uint64_t * const size)
{
    return impl_->MbufGetPrivInfo(mbufPtr, priv, size);
}

rtError_t ApiDecorator::MbufCopyBufRef(const rtMbufPtr_t mbufPtr, rtMbufPtr_t * const newMbufPtr)
{
    return impl_->MbufCopyBufRef(mbufPtr, newMbufPtr);
}

rtError_t ApiDecorator::MbufChainAppend(const rtMbufPtr_t memBufChainHead, rtMbufPtr_t memBuf)
{
    return impl_->MbufChainAppend(memBufChainHead, memBuf);
}

rtError_t ApiDecorator::MbufChainGetMbufNum(const rtMbufPtr_t memBufChainHead, uint32_t *num)
{
    return impl_->MbufChainGetMbufNum(memBufChainHead, num);
}

rtError_t ApiDecorator::MbufChainGetMbuf(const rtMbufPtr_t memBufChainHead, const uint32_t index,
    rtMbufPtr_t * const memBuf)
{
    return impl_->MbufChainGetMbuf(memBufChainHead, index, memBuf);
}

rtError_t ApiDecorator::MemGrpCreate(const char_t * const name, const rtMemGrpConfig_t * const cfg)
{
    return impl_->MemGrpCreate(name, cfg);
}

rtError_t ApiDecorator::BuffGetInfo(const rtBuffGetCmdType type, const void * const inBuff, const uint32_t inLen,
    void * const outBuff, uint32_t * const outLen)
{
    return impl_->BuffGetInfo(type, inBuff, inLen, outBuff, outLen);
}

rtError_t ApiDecorator::MemGrpCacheAlloc(const char_t *const name, const int32_t devId,
    const rtMemGrpCacheAllocPara *const para)
{
    return impl_->MemGrpCacheAlloc(name, devId, para);
}

rtError_t ApiDecorator::MemGrpAddProc(const char_t * const name, const int32_t pid,
    const rtMemGrpShareAttr_t * const attr)
{
    return impl_->MemGrpAddProc(name, pid, attr);
}

rtError_t ApiDecorator::MemGrpAttach(const char_t * const name, const int32_t timeout)
{
    return impl_->MemGrpAttach(name, timeout);
}

rtError_t ApiDecorator::MemGrpQuery(rtMemGrpQueryInput_t * const input, rtMemGrpQueryOutput_t * const output)
{
    return impl_->MemGrpQuery(input, output);
}

rtError_t ApiDecorator::MemQueueGetQidByName(const int32_t devId, const char_t * const name, uint32_t * const qId)
{
    return impl_->MemQueueGetQidByName(devId, name, qId);
}

rtError_t ApiDecorator::QueueSubF2NFEvent(const int32_t devId, const uint32_t qId, const uint32_t groupId)
{
    return impl_->QueueSubF2NFEvent(devId, qId, groupId);
}

rtError_t ApiDecorator::QueueSubscribe(const int32_t devId, const uint32_t qId, const uint32_t groupId,
    const int32_t type)
{
    return impl_->QueueSubscribe(devId, qId, groupId, type);
}

rtError_t ApiDecorator::BufEventTrigger(const char_t * const name)
{
    return impl_->BufEventTrigger(name);
}

rtError_t ApiDecorator::MemCopy2DSync(void * const dst, const uint64_t dstPitch, const void * const src,
    const uint64_t srcPitch, const uint64_t width, const uint64_t height, const rtMemcpyKind_t kind, const rtMemcpyKind newKind)
{
    return impl_->MemCopy2DSync(dst, dstPitch, src, srcPitch, width, height, kind, newKind);
}

rtError_t ApiDecorator::MemCopy2DAsync(void * const dst, const uint64_t dstPitch, const void * const src,
    const uint64_t srcPitch, const uint64_t width, const uint64_t height, Stream * const stm,
    const rtMemcpyKind_t kind, const rtMemcpyKind newKind)
{
    return impl_->MemCopy2DAsync(dst, dstPitch, src, srcPitch, width, height, stm, kind, newKind);
}

rtError_t ApiDecorator::EschedAttachDevice(const uint32_t devId)
{
    return impl_->EschedAttachDevice(devId);
}

rtError_t ApiDecorator::EschedDettachDevice(const uint32_t devId)
{
    return impl_->EschedDettachDevice(devId);
}

rtError_t ApiDecorator::EschedWaitEvent(const int32_t devId, const uint32_t grpId,
    const uint32_t threadId, const int32_t timeout, rtEschedEventSummary_t * const evt)
{
    return impl_->EschedWaitEvent(devId, grpId, threadId, timeout, evt);
}

rtError_t ApiDecorator::EschedCreateGrp(const int32_t devId, const uint32_t grpId, const rtGroupType_t type)
{
    return impl_->EschedCreateGrp(devId, grpId, type);
}

rtError_t ApiDecorator::EschedSubmitEvent(const int32_t devId, rtEschedEventSummary_t * const evt)
{
    return impl_->EschedSubmitEvent(devId, evt);
}

rtError_t ApiDecorator::EschedSubscribeEvent(const int32_t devId, const uint32_t grpId, const uint32_t threadId,
    const uint64_t eventBitmap)
{
    return impl_->EschedSubscribeEvent(devId, grpId, threadId, eventBitmap);
}

rtError_t ApiDecorator::EschedAckEvent(const int32_t devId, const rtEventIdType_t evtId,
    const uint32_t subeventId, char_t * const msg, const uint32_t len)
{
    return impl_->EschedAckEvent(devId, evtId, subeventId, msg, len);
}

rtError_t ApiDecorator::CmoTaskLaunch(const rtCmoTaskInfo_t * const taskInfo, Stream * const stm,
    const uint32_t flag)
{
    return impl_->CmoTaskLaunch(taskInfo, stm, flag);
}

rtError_t ApiDecorator::CmoAddrTaskLaunch(void *cmoAddrInfo, const uint64_t destMax,
    const rtCmoOpCode_t cmoOpCode, Stream * const stm, const uint32_t flag)
{
    return impl_->CmoAddrTaskLaunch(cmoAddrInfo, destMax, cmoOpCode, stm, flag);
}

rtError_t ApiDecorator::BarrierTaskLaunch(const rtBarrierTaskInfo_t * const taskInfo, Stream * const stm,
    const uint32_t flag)
{
    return impl_->BarrierTaskLaunch(taskInfo, stm, flag);
}

rtError_t ApiDecorator::MemcpyHostTask(void * const dst, const uint64_t destMax, const void * const src,
    const uint64_t cnt, const rtMemcpyKind_t kind, Stream * const stm)
{
    return impl_->MemcpyHostTask(dst, destMax, src, cnt, kind, stm);
}

rtError_t ApiDecorator::SetDeviceSatMode(const rtFloatOverflowMode_t floatOverflowMode)
{
    return impl_->SetDeviceSatMode(floatOverflowMode);
}

rtError_t ApiDecorator::GetDeviceSatMode(rtFloatOverflowMode_t * const floatOverflowMode)
{
    return impl_->GetDeviceSatMode(floatOverflowMode);
}

rtError_t ApiDecorator::GetDeviceSatModeForStream(Stream * const stm, rtFloatOverflowMode_t * const floatOverflowMode)
{
    return impl_->GetDeviceSatModeForStream(stm, floatOverflowMode);
}

rtError_t ApiDecorator::SetStreamOverflowSwitch(Stream * const stm, const uint32_t flags)
{
    return impl_->SetStreamOverflowSwitch(stm, flags);
}

rtError_t ApiDecorator::GetStreamOverflowSwitch(Stream * const stm, uint32_t * const flags)
{
    return impl_->GetStreamOverflowSwitch(stm, flags);
}

rtError_t ApiDecorator::DvppGroupCreate(DvppGrp **grp, const uint32_t flags)
{
    return impl_->DvppGroupCreate(grp, flags);
}

rtError_t ApiDecorator::DvppGroupDestory(DvppGrp *grp)
{
    return impl_->DvppGroupDestory(grp);
}

rtError_t ApiDecorator::DvppWaitGroupReport(DvppGrp * const grp, const rtDvppGrpCallback callBackFunc,
    const int32_t timeout)
{
    return impl_->DvppWaitGroupReport(grp, callBackFunc, timeout);
}

rtError_t ApiDecorator::SetStreamTag(Stream * const stm, const uint32_t geOpTag)
{
    return impl_->SetStreamTag(stm, geOpTag);
}

rtError_t ApiDecorator::GetStreamTag(Stream * const stm, uint32_t * const geOpTag)
{
    return impl_->GetStreamTag(stm, geOpTag);
}

rtError_t ApiDecorator::GetVisibleDeviceIdByLogicDeviceId(const int32_t logicDeviceId, int32_t * const visibleDeviceId)
{
    return impl_->GetVisibleDeviceIdByLogicDeviceId(logicDeviceId, visibleDeviceId);
}

rtError_t ApiDecorator::CtxSetSysParamOpt(const rtSysParamOpt configOpt, const int64_t configVal)
{
    return impl_->CtxSetSysParamOpt(configOpt, configVal);
}

rtError_t ApiDecorator::CtxGetSysParamOpt(const rtSysParamOpt configOpt, int64_t * const configVal)
{
    return impl_->CtxGetSysParamOpt(configOpt, configVal);
}

rtError_t ApiDecorator::CtxGetOverflowAddr(void ** const overflowAddr)
{
    return impl_->CtxGetOverflowAddr(overflowAddr);
}

rtError_t ApiDecorator::GetDeviceSatStatus(void * const outputAddrPtr, const uint64_t outputSize, Stream * const stm)
{
    return impl_->GetDeviceSatStatus(outputAddrPtr, outputSize, stm);
}

rtError_t ApiDecorator::CleanDeviceSatStatus(Stream * const stm)
{
    return impl_->CleanDeviceSatStatus(stm);
}

rtError_t ApiDecorator::GetAllUtilizations(const int32_t devId, const rtTypeUtil_t kind, uint8_t * const util)
{
    return impl_->GetAllUtilizations(devId, kind, util);
}

rtError_t ApiDecorator::GetTaskBufferLen(const rtTaskBuffType_t type, uint32_t * const bufferLen)
{
    return impl_->GetTaskBufferLen(type, bufferLen);
}

rtError_t ApiDecorator::TaskSqeBuild(const rtTaskInput_t * const taskInput, uint32_t* const taskLen)
{
    return impl_->TaskSqeBuild(taskInput, taskLen);
}

rtError_t ApiDecorator::GetKernelBin(const char_t *const binFileName, char_t **const buffer, uint32_t *length)
{
    return impl_->GetKernelBin(binFileName, buffer, length);
}

rtError_t ApiDecorator::GetBinBuffer(const rtBinHandle binHandle, const rtBinBufferType_t type, void **bin,
                                     uint32_t *binSize)
{
    return impl_->GetBinBuffer(binHandle, type, bin, binSize);
}

rtError_t ApiDecorator::GetStackBuffer(const rtBinHandle binHandle, const uint32_t coreType, const uint32_t coreId,
                                       const void **stack, uint32_t *stackSize)
{
    return impl_->GetStackBuffer(binHandle, coreType, coreId, stack, stackSize);
}

rtError_t ApiDecorator::FreeKernelBin(char_t * const buffer)
{
    return impl_->FreeKernelBin(buffer);
}

rtError_t ApiDecorator::EschedQueryInfo(const uint32_t devId, const rtEschedQueryType type,
    rtEschedInputInfo *inPut, rtEschedOutputInfo *outPut)
{
    return impl_->EschedQueryInfo(devId, type, inPut, outPut);
}

rtError_t ApiDecorator::ModelCheckArchVersion(const char_t *omArchVersion, const rtArchType_t archType)
{
    return impl_->ModelCheckArchVersion(omArchVersion, archType);
}

rtError_t ApiDecorator::ReserveMemAddress(void** devPtr, size_t size, size_t alignment, void *devAddr, uint64_t flags)
{
    return impl_->ReserveMemAddress(devPtr, size, alignment, devAddr, flags);
}

rtError_t ApiDecorator::ReleaseMemAddress(void* devPtr)
{
    return impl_->ReleaseMemAddress(devPtr);
}

rtError_t ApiDecorator::MallocPhysical(rtDrvMemHandle* handle, size_t size, rtDrvMemProp_t* prop, uint64_t flags)
{
    return impl_->MallocPhysical(handle, size, prop, flags);
}

rtError_t ApiDecorator::FreePhysical(rtDrvMemHandle handle)
{
    return impl_->FreePhysical(handle);
}

rtError_t ApiDecorator::MapMem(void* devPtr, size_t size, size_t offset, rtDrvMemHandle handle, uint64_t flags)
{
    return impl_->MapMem(devPtr, size, offset, handle, flags);
}

rtError_t ApiDecorator::UnmapMem(void* devPtr)
{
    return impl_->UnmapMem(devPtr);
}

rtError_t ApiDecorator::MemSetAccess(void *virPtr, size_t size, rtMemAccessDesc *desc, size_t count)
{
    return impl_->MemSetAccess(virPtr, size, desc, count);
}

rtError_t ApiDecorator::MemGetAccess(void *virPtr, rtMemLocation *location, uint64_t *flags)
{
    return impl_->MemGetAccess(virPtr, location, flags);
}

rtError_t ApiDecorator::ExportToShareableHandle(rtDrvMemHandle handle, rtDrvMemHandleType handleType,
    uint64_t flags, uint64_t *shareableHandle)
{
    return impl_->ExportToShareableHandle(handle, handleType, flags, shareableHandle);
}

rtError_t ApiDecorator::ExportToShareableHandleV2(
    rtDrvMemHandle handle, rtMemSharedHandleType handleType, uint64_t flags, void *shareableHandle)
{
    return impl_->ExportToShareableHandleV2(handle, handleType, flags, shareableHandle);
}

rtError_t ApiDecorator::ImportFromShareableHandle(uint64_t shareableHandle, int32_t devId, rtDrvMemHandle *handle)
{
    return impl_->ImportFromShareableHandle(shareableHandle, devId, handle);
}

rtError_t ApiDecorator::ImportFromShareableHandleV2(const void *shareableHandle, rtMemSharedHandleType handleType,
    uint64_t flags, int32_t devId, rtDrvMemHandle *handle)
{
    return impl_->ImportFromShareableHandleV2(shareableHandle, handleType, flags, devId, handle);
}

rtError_t ApiDecorator::SetPidToShareableHandle(uint64_t shareableHandle, int32_t pid[], uint32_t pidNum)
{
    return impl_->SetPidToShareableHandle(shareableHandle, pid, pidNum);
}

rtError_t ApiDecorator::SetPidToShareableHandleV2(
    const void *shareableHandle, rtMemSharedHandleType handleType, int32_t pid[], uint32_t pidNum)
{
    return impl_->SetPidToShareableHandleV2(shareableHandle, handleType, pid, pidNum);
}

rtError_t ApiDecorator::GetAllocationGranularity(rtDrvMemProp_t *prop, rtDrvMemGranularityOptions option,
    size_t *granularity)
{
    return impl_->GetAllocationGranularity(prop, option, granularity);
}

rtError_t ApiDecorator::DeviceStatusQuery(const uint32_t devId, rtDeviceStatus *deviceStatus)
{
    return impl_->DeviceStatusQuery(devId, deviceStatus);
}

rtError_t ApiDecorator::BindHostPid(rtBindHostpidInfo info)
{
    return impl_->BindHostPid(info);
}

rtError_t ApiDecorator::UnbindHostPid(rtBindHostpidInfo info)
{
    return impl_->UnbindHostPid(info);
}

rtError_t ApiDecorator::QueryProcessHostPid(int32_t pid, uint32_t *chipId, uint32_t *vfId, uint32_t *hostPid,
    uint32_t *cpType)
{
    return impl_->QueryProcessHostPid(pid, chipId, vfId, hostPid, cpType);
}

rtError_t ApiDecorator::SetStreamSqLockUnlock(Stream * const stm, const bool isLock)
{
    RT_LOG(RT_LOG_INFO, "Start to SetStreamSqLockUnlock");
    return impl_->SetStreamSqLockUnlock(stm, isLock);
}
rtError_t ApiDecorator::ShrIdSetPodPid(const char *name, uint32_t sdid, int32_t pid)
{
    return impl_->ShrIdSetPodPid(name, sdid, pid);
}

rtError_t ApiDecorator::ShmemSetPodPid(const char *name, uint32_t sdid, int32_t pid[], int32_t num)
{
    return impl_->ShmemSetPodPid(name, sdid, pid, num);
}

rtError_t ApiDecorator::DevVA2PA(uint64_t devAddr, uint64_t len, Stream *stm, bool isAsync)
{
    return impl_->DevVA2PA(devAddr, len, stm, isAsync);
}

rtError_t ApiDecorator::StreamClear(Stream * const stm, rtClearStep_t step)
{
    return impl_->StreamClear(stm, step);
}

rtError_t ApiDecorator::StreamAbort(Stream * const stm)
{
    return impl_->StreamAbort(stm);
}

rtError_t ApiDecorator::NotifyReset(Notify * const inNotify)
{
    return impl_->NotifyReset(inNotify);
}

rtError_t ApiDecorator::DebugSetDumpMode(const uint64_t mode)
{
    return impl_->DebugSetDumpMode(mode);
}

rtError_t ApiDecorator::DebugGetStalledCore(rtDbgCoreInfo_t *const coreInfo)
{
    return impl_->DebugGetStalledCore(coreInfo);
}

rtError_t ApiDecorator::DebugReadAICore(rtDebugMemoryParam_t *const param)
{
    return impl_->DebugReadAICore(param);
}

rtError_t ApiDecorator::GetExceptionRegInfo(const rtExceptionInfo_t * const exceptionInfo,
    rtExceptionErrRegInfo_t **exceptionErrRegInfo, uint32_t *num)
{
    return impl_->GetExceptionRegInfo(exceptionInfo, exceptionErrRegInfo, num);
}

rtError_t ApiDecorator::GetServerIDBySDID(uint32_t sdid, uint32_t *srvId)
{
    return impl_->GetServerIDBySDID(sdid, srvId);
}

rtError_t ApiDecorator::ResourceClean(int32_t devId, rtIdType_t type)
{
    return impl_->ResourceClean(devId, type);
}

rtError_t ApiDecorator::ModelNameSet(Model * const mdl, const char_t * const name)
{
    return impl_->ModelNameSet(mdl, name);
}

rtError_t ApiDecorator::SetDefaultDeviceId(const int32_t deviceId)
{
    return impl_->SetDefaultDeviceId(deviceId);
}

rtError_t ApiDecorator::CtxGetCurrentDefaultStream(Stream ** const stm)
{
    return impl_->CtxGetCurrentDefaultStream(stm);
}

rtError_t ApiDecorator::GetPrimaryCtxState(const int32_t devId, uint32_t *flags, int32_t *active)
{
    return impl_->GetPrimaryCtxState(devId, flags, active);
}

rtError_t ApiDecorator::RegStreamStateCallback(const char_t *regName, void *callback, void *args,
    StreamStateCallback type)
{
    return impl_->RegStreamStateCallback(regName, callback, args, type);
}

rtError_t ApiDecorator::DeviceResetForce(const int32_t devId)
{
    return impl_->DeviceResetForce(devId);
}

rtError_t ApiDecorator::GetLastErr(rtLastErrLevel_t level)
{
    return impl_->GetLastErr(level);
}

rtError_t ApiDecorator::PeekLastErr(rtLastErrLevel_t level)
{
    return impl_->PeekLastErr(level);
}

rtError_t ApiDecorator::GetDeviceStatus(const int32_t devId, rtDevStatus_t * const status)
{
    return impl_->GetDeviceStatus(devId, status);
}

rtError_t ApiDecorator::SetDeviceResLimit(const uint32_t devId, const rtDevResLimitType_t type, uint32_t value)
{
    return impl_->SetDeviceResLimit(devId, type, value);
}

rtError_t ApiDecorator::ResetDeviceResLimit(const uint32_t devId)
{
    return impl_->ResetDeviceResLimit(devId);
}

rtError_t ApiDecorator::GetDeviceResLimit(const uint32_t devId, const rtDevResLimitType_t type, uint32_t *value)
{
    return impl_->GetDeviceResLimit(devId, type, value);
}

rtError_t ApiDecorator::SetStreamResLimit(Stream *const stm, const rtDevResLimitType_t type, const uint32_t value)
{
    return impl_->SetStreamResLimit(stm, type, value);
}

rtError_t ApiDecorator::ResetStreamResLimit(Stream *const stm)
{
    return impl_->ResetStreamResLimit(stm);
}

rtError_t ApiDecorator::GetStreamResLimit(
    const Stream *const stm, const rtDevResLimitType_t type, uint32_t *const value)
{
    return impl_->GetStreamResLimit(stm, type, value);
}

rtError_t ApiDecorator::UseStreamResInCurrentThread(const Stream *const stm)
{
    return impl_->UseStreamResInCurrentThread(stm);
}

rtError_t ApiDecorator::NotUseStreamResInCurrentThread(const Stream *const stm)
{
    return impl_->NotUseStreamResInCurrentThread(stm);
}

rtError_t ApiDecorator::GetResInCurrentThread(const rtDevResLimitType_t type, uint32_t *const value)
{
    return impl_->GetResInCurrentThread(type, value);
}

rtError_t ApiDecorator::HdcServerCreate(const int32_t devId, const rtHdcServiceType_t type, rtHdcServer_t * const server)
{
    return impl_->HdcServerCreate(devId, type, server);
}

rtError_t ApiDecorator::HdcServerDestroy(rtHdcServer_t const server)
{
    return impl_->HdcServerDestroy(server);
}

rtError_t ApiDecorator::HdcSessionConnect(const int32_t peerNode, const int32_t peerDevId, rtHdcClient_t const client,
    rtHdcSession_t * const session)
{
    return impl_->HdcSessionConnect(peerNode, peerDevId, client, session);
}

rtError_t ApiDecorator::HdcSessionClose(rtHdcSession_t const session)
{
    return impl_->HdcSessionClose(session);
}

rtError_t ApiDecorator::GetHostCpuDevId(int32_t * const devId)
{
    return impl_->GetHostCpuDevId(devId);
}

rtError_t ApiDecorator::GetLogicDevIdByUserDevId(const int32_t userDevId, int32_t * const logicDevId)
{
    return impl_->GetLogicDevIdByUserDevId(userDevId, logicDevId);
}

rtError_t ApiDecorator::GetUserDevIdByLogicDevId(const int32_t logicDevId, int32_t * const userDevId)
{
    return impl_->GetUserDevIdByLogicDevId(logicDevId, userDevId);
}

rtError_t ApiDecorator::GetDeviceUuid(const int32_t devId, rtUuid_t *uuid)
{
    return impl_->GetDeviceUuid(devId, uuid);
}

rtError_t ApiDecorator::StreamBeginCapture(Stream * const stm, const rtStreamCaptureMode mode)
{
    return impl_->StreamBeginCapture(stm, mode);
}

rtError_t ApiDecorator::StreamEndCapture(Stream * const stm, Model ** const captureMdl)
{
    return impl_->StreamEndCapture(stm, captureMdl);
}

rtError_t ApiDecorator::StreamGetCaptureInfo(const Stream * const stm, rtStreamCaptureStatus * const status,
                                             Model ** const captureMdl)
{
    return impl_->StreamGetCaptureInfo(stm, status, captureMdl);
}

rtError_t ApiDecorator::SetStreamCacheOpInfoSwitch(const Stream * const stm, uint32_t cacheOpInfoSwitch)
{
    return impl_->SetStreamCacheOpInfoSwitch(stm, cacheOpInfoSwitch);
}

rtError_t ApiDecorator::GetStreamCacheOpInfoSwitch(const Stream * const stm, uint32_t * const cacheOpInfoSwitch)
{
    return impl_->GetStreamCacheOpInfoSwitch(stm, cacheOpInfoSwitch);
}

rtError_t ApiDecorator::StreamBeginTaskUpdate(Stream * const stm, TaskGroup * handle)
{
    return impl_->StreamBeginTaskUpdate(stm, handle);
}

rtError_t ApiDecorator::StreamEndTaskUpdate(Stream * const stm)
{
    return impl_->StreamEndTaskUpdate(stm);
}

rtError_t ApiDecorator::ModelGetNodes(const Model * const mdl, uint32_t * const num)
{
    return impl_->ModelGetNodes(mdl, num);
}

rtError_t ApiDecorator::ModelDebugDotPrint(const Model * const mdl)
{
    return impl_->ModelDebugDotPrint(mdl);
}

rtError_t ApiDecorator::ModelDebugJsonPrint(const Model * const mdl, const char* path, const uint32_t flags)
{
    return impl_->ModelDebugJsonPrint(mdl, path, flags);
}

rtError_t ApiDecorator::StreamAddToModel(Stream * const stm, Model * const captureMdl)
{
    return impl_->StreamAddToModel(stm, captureMdl);
}

rtError_t ApiDecorator::ThreadExchangeCaptureMode(rtStreamCaptureMode * const mode)
{
    return impl_->ThreadExchangeCaptureMode(mode);
}

rtError_t ApiDecorator::DevMalloc(void ** const devPtr, const uint64_t size, rtMallocPolicy policy, rtMallocAdvise advise, const rtMallocConfig_t * const cfg)
{
    return impl_->DevMalloc(devPtr, size, policy, advise, cfg);
}
rtError_t ApiDecorator::StreamBeginTaskGrp(Stream * const stm)
{
    return impl_->StreamBeginTaskGrp(stm);
}

rtError_t ApiDecorator::StreamEndTaskGrp(Stream * const stm, TaskGroup ** const handle)
{
    return impl_->StreamEndTaskGrp(stm, handle);
}

rtError_t ApiDecorator::MemReserveAddress(void** virPtr, size_t size, rtMallocPolicy policy, void *expectAddr, rtMallocConfig_t *cfg)
{
    return impl_->MemReserveAddress(virPtr, size, policy, expectAddr, cfg);
}

rtError_t ApiDecorator::MemMallocPhysical(rtMemHandle* handle, size_t size, rtMallocPolicy policy, rtMallocConfig_t *cfg)
{
    return impl_->MemMallocPhysical(handle, size, policy, cfg);
}

rtError_t ApiDecorator::GetThreadLastTaskId(uint32_t * const taskId)
{
    return impl_->GetThreadLastTaskId(taskId);
}

rtError_t ApiDecorator::LaunchDvppTask(const void * const sqe, const uint32_t sqeLen, Stream * const stm, rtDvppCfg_t *cfg)
{
    return impl_->LaunchDvppTask(sqe, sqeLen, stm, cfg);
}

rtError_t ApiDecorator::LaunchRandomNumTask(const rtRandomNumTaskInfo_t *taskInfo, Stream * const stm, void *reserve)
{
    return impl_->LaunchRandomNumTask(taskInfo, stm, reserve);
}

rtError_t ApiDecorator::KernelArgsInit(Kernel * const funcHandle, RtArgsHandle **argsHandle)
{
    return impl_->KernelArgsInit(funcHandle, argsHandle);
}

rtError_t ApiDecorator::KernelArgsAppendPlaceHolder(RtArgsHandle *argsHandle, ParaDetail **paraHandle)
{
    return impl_->KernelArgsAppendPlaceHolder(argsHandle, paraHandle);
}

rtError_t ApiDecorator::KernelArgsGetPlaceHolderBuffer(RtArgsHandle *argsHandle, ParaDetail *paraHandle,
    size_t dataSize, void **bufferAddr)
{
    return impl_->KernelArgsGetPlaceHolderBuffer(argsHandle, paraHandle, dataSize, bufferAddr);
}

rtError_t ApiDecorator::KernelArgsGetHandleMemSize(Kernel * const funcHandle, size_t *memSize)
{
    return impl_->KernelArgsGetHandleMemSize(funcHandle, memSize);
}

rtError_t ApiDecorator::KernelArgsFinalize(RtArgsHandle *argsHandle)
{
    return impl_->KernelArgsFinalize(argsHandle);
}

rtError_t ApiDecorator::KernelArgsGetMemSize(Kernel * const funcHandle, size_t userArgsSize, size_t *actualArgsSize)
{
    return impl_->KernelArgsGetMemSize(funcHandle, userArgsSize, actualArgsSize);
}

rtError_t ApiDecorator::KernelArgsInitByUserMem(Kernel * const funcHandle, RtArgsHandle *argsHandle, void *userHostMem,
    size_t actualArgsSize)
{
    return impl_->KernelArgsInitByUserMem(funcHandle, argsHandle, userHostMem, actualArgsSize);
}

rtError_t ApiDecorator::KernelArgsAppend(RtArgsHandle *argsHandle, void *para, size_t paraSize, ParaDetail **paraHandle)
{
    return impl_->KernelArgsAppend(argsHandle, para, paraSize, paraHandle);
}

rtError_t ApiDecorator::WriteValuePtr(void * const writeValueInfo, Stream * const stm,
    void * const pointedAddr)
{
    return impl_->WriteValuePtr(writeValueInfo, stm, pointedAddr);
}

rtError_t ApiDecorator::DeviceGetStreamlist(int32_t devId, rtStreamlistType_t type, rtStreamlist_t *stmList)
{
    return impl_->DeviceGetStreamlist(devId, type, stmList);
}

rtError_t ApiDecorator::DeviceGetModelList(int32_t devId, rtModelList_t *mdlList)
{
    return impl_->DeviceGetModelList(devId, mdlList);
}

rtError_t ApiDecorator::CntNotifyCreate(const int32_t deviceId, CountNotify ** const retCntNotify, const uint32_t flag)
{
    return impl_->CntNotifyCreate(deviceId, retCntNotify, flag);
}

rtError_t ApiDecorator::CntNotifyDestroy(CountNotify * const inCntNotify)
{
    return impl_->CntNotifyDestroy(inCntNotify);
}

rtError_t ApiDecorator::CntNotifyRecord(CountNotify * const inCntNotify, Stream * const stm,
                                        const rtCntNtyRecordInfo_t * const info)
{
    return impl_->CntNotifyRecord(inCntNotify, stm, info);
}

rtError_t ApiDecorator::CntNotifyWaitWithTimeout(CountNotify * const inCntNotify, Stream * const stm,
                                                 const rtCntNtyWaitInfo_t * const info)
{
    return impl_->CntNotifyWaitWithTimeout(inCntNotify, stm, info);
}

rtError_t ApiDecorator::CntNotifyReset(CountNotify * const inCntNotify, Stream * const stm)
{
    return impl_->CntNotifyReset(inCntNotify, stm);
}

rtError_t ApiDecorator::GetCntNotifyAddress(CountNotify *const inCntNotify, uint64_t * const cntNotifyAddress,
                                            rtNotifyType_t const regType)
{
    return impl_->GetCntNotifyAddress(inCntNotify, cntNotifyAddress, regType);
}

rtError_t ApiDecorator::GetCntNotifyId(CountNotify * const inCntNotify, uint32_t * const notifyId)
{
    return impl_->GetCntNotifyId(inCntNotify, notifyId);
}

rtError_t ApiDecorator::WriteValue(rtWriteValueInfo_t * const info, Stream * const stm)
{
    return impl_->WriteValue(info, stm);
}

rtError_t ApiDecorator::CCULaunch(rtCcuTaskInfo_t *taskInfo,  Stream * const stm)
{
    return impl_->CCULaunch(taskInfo, stm);
}

rtError_t ApiDecorator::UbDevQueryInfo(rtUbDevQueryCmd cmd, void * devInfo)
{
    return impl_->UbDevQueryInfo(cmd, devInfo);
}

rtError_t ApiDecorator::GetDevResAddress(const rtDevResInfo * const resInfo, rtDevResAddrInfo * const addrInfo)
{
    return impl_->GetDevResAddress(resInfo, addrInfo);
}

rtError_t ApiDecorator::ReleaseDevResAddress(rtDevResInfo * const resInfo)
{
    return impl_->ReleaseDevResAddress(resInfo);
}

rtError_t ApiDecorator::UbDbSend(rtUbDbInfo_t * const dbInfo, Stream * const stm)
{
    return impl_->UbDbSend(dbInfo, stm);
}

rtError_t ApiDecorator::UbDirectSend(rtUbWqeInfo_t * const wqeInfo, Stream * const stm)
{
    return impl_->UbDirectSend(wqeInfo, stm);
}

rtError_t ApiDecorator::FusionLaunch(void * const fusionInfo, Stream * const stm, rtFusionArgsEx_t *argsInfo)
{
    return impl_->FusionLaunch(fusionInfo, stm, argsInfo);
}

rtError_t ApiDecorator::StreamTaskAbort(Stream * const stm)
{
    return impl_->StreamTaskAbort(stm);
}

rtError_t ApiDecorator::StreamRecover(Stream * const stm)
{
    return impl_->StreamRecover(stm);
}

rtError_t ApiDecorator::StreamTaskClean(Stream * const stm)
{
    return impl_->StreamTaskClean(stm);
}

rtError_t ApiDecorator::DeviceResourceClean(const int32_t devId)
{
    return impl_->DeviceResourceClean(devId);
}

rtError_t ApiDecorator::MemWriteValue(const void * const devAddr, const uint64_t value, const uint32_t flag, Stream * const stm)
{
    return impl_->MemWriteValue(devAddr, value, flag, stm);
}

rtError_t ApiDecorator::MemWaitValue(const void * const devAddr, const uint64_t value, const uint32_t flag, Stream * const stm)
{
    return impl_->MemWaitValue(devAddr, value, flag, stm);
}

rtError_t ApiDecorator::MemcpyBatch(void **dsts, void **srcs, size_t *sizes, size_t count,
    rtMemcpyBatchAttr *attrs, size_t *attrsIdxs, size_t numAttrs, size_t *failIdx)
{
    return impl_->MemcpyBatch(dsts, srcs, sizes, count, attrs, attrsIdxs, numAttrs, failIdx);
}

rtError_t ApiDecorator::MemcpyBatchAsync(void** const dsts, const size_t* const destMaxs,  void** const srcs, const size_t* const sizes,
    const size_t count, const rtMemcpyBatchAttr* const attrs, const size_t* const attrsIdxs, const size_t numAttrs, size_t* const failIdx,
    Stream* const stm)
{
    return impl_->MemcpyBatchAsync(dsts, destMaxs, srcs, sizes, count, attrs, attrsIdxs, numAttrs, failIdx, stm);
}

rtError_t ApiDecorator::GetCmoDescSize(size_t *size)
{
    return impl_->GetCmoDescSize(size);
}

rtError_t ApiDecorator::SetCmoDesc(rtCmoDesc_t cmoDesc, void *srcAddr, size_t srcLen)
{
    return impl_->SetCmoDesc(cmoDesc, srcAddr, srcLen);
}

rtError_t ApiDecorator::ModelGetName(Model * const mdl, const uint32_t maxLen, char_t * const mdlName)
{
    return impl_->ModelGetName(mdl, maxLen, mdlName);
}

rtError_t ApiDecorator::FuncGetName(const Kernel * const kernel, const uint32_t maxLen, char_t * const name) 
{
    return impl_->FuncGetName(kernel, maxLen, name);
}

rtError_t ApiDecorator::GetErrorVerbose(const uint32_t deviceId, rtErrorInfo * const errorInfo) 
{
    return impl_->GetErrorVerbose(deviceId, errorInfo);
}

rtError_t ApiDecorator::RepairError(const uint32_t deviceId, const rtErrorInfo * const errorInfo)
{
    return impl_->RepairError(deviceId, errorInfo);
}

rtError_t ApiDecorator::LaunchDqsTask(Stream * const stm, const rtDqsTaskCfg_t * const taskCfg)
{
    return impl_->LaunchDqsTask(stm, taskCfg);
}

rtError_t ApiDecorator::LaunchHostFunc(Stream * const stm, const rtCallback_t callBackFunc, void * const fnData)
{
    return impl_->LaunchHostFunc(stm, callBackFunc, fnData);
}

rtError_t ApiDecorator::EventWorkModeSet(uint8_t mode) 
{
    return impl_->EventWorkModeSet(mode);
}

rtError_t ApiDecorator::EventWorkModeGet(uint8_t *mode)
{
    return impl_->EventWorkModeGet(mode);
}

rtError_t ApiDecorator::CacheLastTaskOpInfo(const void * const infoPtr, const size_t infoSize)
{
    return impl_->CacheLastTaskOpInfo(infoPtr, infoSize);
}

rtError_t ApiDecorator::SetXpuDevice(rtXpuDevType devType, const uint32_t devId)
{
    return impl_->SetXpuDevice(devType, devId);
}
rtError_t ApiDecorator::ResetXpuDevice(rtXpuDevType devType, const uint32_t devId)
{
    return impl_->ResetXpuDevice(devType, devId);
}

rtError_t ApiDecorator::MemRetainAllocationHandle(void* virPtr, rtDrvMemHandle *handle)
{
    return impl_->MemRetainAllocationHandle(virPtr, handle);
}

rtError_t ApiDecorator::MemGetAllocationPropertiesFromHandle(rtDrvMemHandle handle, rtDrvMemProp_t* prop)
{
    return impl_->MemGetAllocationPropertiesFromHandle(handle, prop);
}

rtError_t ApiDecorator::FunctionGetAttribute(rtFuncHandle funcHandle, rtFuncAttribute attrType, int64_t *attrValue)
{
    return impl_->FunctionGetAttribute(funcHandle, attrType, attrValue);
}

}  // namespace runtime
}  // namespace cce
