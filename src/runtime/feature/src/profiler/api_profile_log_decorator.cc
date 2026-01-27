/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_profile_log_decorator.hpp"
#include "profiler.hpp"
#include "profile_log_record.hpp"

namespace cce {
namespace runtime {
ApiProfileLogDecorator::ApiProfileLogDecorator(Api * const impl,
    Profiler * const prof) : ApiDecorator(impl), profiler_(prof)
{
}

rtError_t ApiProfileLogDecorator::DevBinaryRegister(const rtDevBinary_t * const bin, Program ** const prog)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_DEVBINARY_REGISTER, profiler_);
    const rtError_t error = impl_->DevBinaryRegister(bin, prog);
    record.SaveRecord();
    return error;
}
rtError_t ApiProfileLogDecorator::GetNotifyAddress(Notify * const notify, uint64_t * const notifyAddress)
{
    const rtError_t error = impl_->GetNotifyAddress(notify, notifyAddress);
    return error;
}
rtError_t ApiProfileLogDecorator::RegisterAllKernel(const rtDevBinary_t * const bin, Program ** const prog)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_ALLKERNEL_REGISTER, profiler_);
    const rtError_t error = impl_->RegisterAllKernel(bin, prog);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::DevBinaryUnRegister(Program * const prog)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_DEVBINARY_UNREGISTER, profiler_);
    const rtError_t error = impl_->DevBinaryUnRegister(prog);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::MetadataRegister(Program * const prog, const char_t * const metadata)
{
    return impl_->MetadataRegister(prog, metadata);
}

rtError_t ApiProfileLogDecorator::DependencyRegister(Program * const mProgram, Program * const sProgram)
{
    return impl_->DependencyRegister(mProgram, sProgram);
}

rtError_t ApiProfileLogDecorator::FunctionRegister(Program * const prog, const void * const stubFunc,
    const char_t * const stubName, const void * const kernelInfoExt, const uint32_t funcMode)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_FUNCTION_REGISTER, profiler_);
    const rtError_t error = impl_->FunctionRegister(prog, stubFunc, stubName, kernelInfoExt, funcMode);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::KernelFusionStart(Stream * const stm)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_KERNEL_FUSION_START, profiler_);
    const rtError_t error = impl_->KernelFusionStart(stm);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::KernelFusionEnd(Stream * const stm)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_KERNEL_FUSION_END, profiler_);
    const rtError_t error = impl_->KernelFusionEnd(stm);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::BuffGetInfo(const rtBuffGetCmdType type, const void * const inBuff,
    const uint32_t inLen, void * const outBuff, uint32_t * const outLen)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_BUFF_GET_INFO, profiler_);
    const rtError_t error = impl_->BuffGetInfo(type, inBuff, inLen, outBuff, outLen);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::KernelLaunch(const void * const stubFunc, const uint32_t coreDim,
    const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm, const uint32_t flag,
    const rtTaskCfgInfo_t * const cfgInfo, const bool isLaunchVec)
{
    if (profiler_->GetProfLogEnable()) {
        ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_KERNEL_LAUNCH, profiler_);
        const rtError_t error = impl_->KernelLaunch(stubFunc, coreDim,
            argsInfo, l2ctrl, stm, flag, cfgInfo, isLaunchVec);
        record.SaveRecord();
        return error;
    } else {
        return impl_->KernelLaunch(stubFunc, coreDim, argsInfo, l2ctrl, stm, flag, cfgInfo, isLaunchVec);
    }
}

rtError_t ApiProfileLogDecorator::KernelLaunchWithHandle(void * const hdl, const uint64_t tilingKey,
    const uint32_t coreDim, const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm,
    const rtTaskCfgInfo_t * const cfgInfo, const bool isLaunchVec)
{
    if (profiler_->GetProfLogEnable()) {
        ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_KERNEL_LAUNCH_WITH_HANDLE, profiler_);
        const rtError_t error = impl_->KernelLaunchWithHandle(hdl, tilingKey, coreDim, argsInfo, l2ctrl,
            stm, cfgInfo, isLaunchVec);
        record.SaveRecord();
        return error;
    } else {
        return impl_->KernelLaunchWithHandle(hdl, tilingKey, coreDim, argsInfo, l2ctrl,
            stm, cfgInfo, isLaunchVec);
    }
}

rtError_t ApiProfileLogDecorator::KernelLaunchEx(const char_t * const opName, const void * const args,
    const uint32_t argsSize, const uint32_t flags, Stream * const stm)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_KERNEL_LAUNCH, profiler_);
    const rtError_t error = impl_->KernelLaunchEx(opName, args, argsSize, flags, stm);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::GetServerIDBySDID(uint32_t sdid, uint32_t *srvId)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_GetServerIDBySDID, profiler_);
    const rtError_t error = impl_->GetServerIDBySDID(sdid, srvId);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::CpuKernelLaunch(const rtKernelLaunchNames_t * const launchNames,
    const uint32_t coreDim, const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl,
    Stream * const stm, const uint32_t flag)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_CpuKernelLaunch, profiler_);
    const rtError_t error = impl_->CpuKernelLaunch(launchNames, coreDim, argsInfo, l2ctrl, stm, flag);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::CpuKernelLaunchExWithArgs(const char_t * const opName,
    const uint32_t coreDim, const rtAicpuArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl,
    Stream * const stm, const uint32_t flag, const uint32_t kernelType)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_CpuKernelLaunch, profiler_);
    const rtError_t error = impl_->CpuKernelLaunchExWithArgs(opName, coreDim, argsInfo, l2ctrl, stm, flag,
                                                             kernelType);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::MultipleTaskInfoLaunch(const rtMultipleTaskInfo_t * const taskInfo,
    Stream * const stm, const uint32_t flag)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_TaskInfoLaunch, profiler_);
    const rtError_t error = impl_->MultipleTaskInfoLaunch(taskInfo, stm, flag);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::BinaryLoad(const rtDevBinary_t * const bin, Program ** const prog)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_BINARY_LOAD, profiler_);
    const rtError_t error = impl_->BinaryLoad(bin, prog);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::BinaryGetFunction(const Program * const prog, const uint64_t tilingKey,
                                                    Kernel ** const funcHandle)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_BINARY_GET_FUNCTION, profiler_);
    const rtError_t error = impl_->BinaryGetFunction(prog, tilingKey, funcHandle);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::BinaryLoadWithoutTilingKey(const void *data, const uint64_t length,
                                                             Program ** const prog)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_BINARY_LOAD_WITHOUT_TILING_KEY, profiler_);
    const rtError_t error = impl_->BinaryLoadWithoutTilingKey(data, length, prog);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::BinaryGetFunctionByName(const Program * const binHandle, const char_t *kernelName,
                                                          Kernel ** const funcHandle)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_BINARY_GET_FUNCTION_BY_NAME, profiler_);
    const rtError_t error = impl_->BinaryGetFunctionByName(binHandle, kernelName, funcHandle);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::BinaryUnLoad(Program * const binHandle)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_BINARY_UNLOAD, profiler_);
    const rtError_t error = impl_->BinaryUnLoad(binHandle);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::LaunchKernel(Kernel * const kernel, uint32_t blockDim,
    const rtArgsEx_t * const argsInfo, Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_LAUNCH_KERNEL, profiler_);
    const rtError_t error = impl_->LaunchKernel(kernel, blockDim,  argsInfo, stm, cfgInfo);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::LaunchKernelV2(Kernel * const kernel, uint32_t blockDim, const RtArgsWithType * const argsWithType,
    Stream * const stm, const rtKernelLaunchCfg_t * const cfg)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_LAUNCH_KERNEL, profiler_);
    const rtError_t error = impl_->LaunchKernelV2(kernel, blockDim, argsWithType, stm, cfg);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::LaunchKernelV3(Kernel * const kernel, const rtArgsEx_t * const argsInfo,
    Stream * const stm, const rtLaunchConfig_t * const launchConfig)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_LAUNCH_KERNEL, profiler_);
    const rtError_t error = impl_->LaunchKernelV3(kernel, argsInfo, stm, launchConfig);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::DatadumpInfoLoad(const void * const dumpInfo,
    const uint32_t length, const uint32_t flag)
{
    return impl_->DatadumpInfoLoad(dumpInfo, length, flag);
}

rtError_t ApiProfileLogDecorator::AicpuInfoLoad(const void * const aicpuInfo, const uint32_t length)
{
    return impl_->AicpuInfoLoad(aicpuInfo, length);
}

rtError_t ApiProfileLogDecorator::StreamCreate(Stream ** const stm, const int32_t priority, const uint32_t flags,
    DvppGrp *grp)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_STREAM_CREATE, profiler_);
    const rtError_t error = impl_->StreamCreate(stm, priority, flags, grp);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::StreamDestroy(Stream * const stm, bool flag)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_STREAM_DESTROY, profiler_);
    const rtError_t error = impl_->StreamDestroy(stm, flag);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::StreamSynchronize(Stream * const stm, const int32_t timeout)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_STREAM_SYNCHRONIZE, profiler_);
    const rtError_t error = impl_->StreamSynchronize(stm, timeout);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::StreamSetMode(Stream * const stm, const uint64_t stmMode)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_STREAM_SET_MODE, profiler_);
    const rtError_t error = impl_->StreamSetMode(stm, stmMode);
    record.SaveRecord();
    return error;
}
rtError_t ApiProfileLogDecorator::StreamGetMode(const Stream * const stm, uint64_t * const stmMode)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_STREAM_GET_MODE, profiler_);
    const rtError_t error = impl_->StreamGetMode(stm, stmMode);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::EventCreate(Event ** const evt, const uint64_t flag)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_EVENT_CREATE, profiler_);
    const rtError_t error = impl_->EventCreate(evt, flag);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::EventCreateEx(Event ** const evt, const uint64_t flag)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_EVENT_CREATE_EX, profiler_);
    const rtError_t error = impl_->EventCreateEx(evt, flag);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::EventCreateForNotify(Event ** const evt)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_EVENT_CREATE, profiler_);
    const rtError_t error = impl_->EventCreateForNotify(evt);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::GetEventID(Event * const evt, uint32_t * const evtId)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_GetEventID, profiler_);
    const rtError_t error = impl_->GetEventID(evt, evtId);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::EventDestroy(Event * evt)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_EVENT_DESTROY, profiler_);
    const rtError_t error = impl_->EventDestroy(evt);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::EventRecord(Event * const evt, Stream * const stm)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_EVENT_RECORD, profiler_);
    const rtError_t error = impl_->EventRecord(evt, stm);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::EventRecordForNotify(Event * const evt, Stream * const stm)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_EVENT_RECORD, profiler_);
    const rtError_t error = impl_->EventRecordForNotify(evt, stm);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::EventSynchronize(Event * const evt, const int32_t timeout)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_EVENT_SYNCHRONIZE, profiler_);
    const rtError_t error = impl_->EventSynchronize(evt, timeout);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::DevMalloc(void ** const devPtr, const uint64_t size, const rtMemType_t type,
    const uint16_t moduleId)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_DEV_MALLOC, profiler_);
    const rtError_t error = impl_->DevMalloc(devPtr, size, type, moduleId);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::DevFree(void * const devPtr)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_DEV_FREE, profiler_);
    const rtError_t error = impl_->DevFree(devPtr);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::DevMallocCached(void ** const devPtr, const uint64_t size, const rtMemType_t type,
    const uint16_t moduleId)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_CAHCEDMEM_ALLOC, profiler_);
    const rtError_t error = impl_->DevMallocCached(devPtr, size, type, moduleId);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::DevDvppMalloc(void ** const devPtr, const uint64_t size, const uint32_t flag,
    const uint16_t moduleId)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_DEV_MALLOC, profiler_);
    const rtError_t error = impl_->DevDvppMalloc(devPtr, size, flag, moduleId);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::GetDevArgsAddr(Stream * const stm, rtArgsEx_t * const argsInfo,
    void ** const devArgsAddr, void ** const argsHandle)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_GET_DEV_ARG_ADDR, profiler_);
    const rtError_t error = impl_->GetDevArgsAddr(stm, argsInfo, devArgsAddr, argsHandle);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::DevDvppFree(void * const devPtr)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_DEV_FREE, profiler_);
    const rtError_t error = impl_->DevDvppFree(devPtr);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::HostMalloc(void ** const hostPtr, const uint64_t size, const uint16_t moduleId)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_HOST_MALLOC, profiler_);
    const rtError_t error = impl_->HostMalloc(hostPtr, size, moduleId);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::HostFree(void * const hostPtr)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_HOST_FREE, profiler_);
    const rtError_t error = impl_->HostFree(hostPtr);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::ManagedMemAlloc(void ** const ptr, const uint64_t size, const uint32_t flag,
    const uint16_t moduleId)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_MANAGEDMEM_ALLOC, profiler_);
    const rtError_t error = impl_->ManagedMemAlloc(ptr, size, flag, moduleId);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::ManagedMemFree(const void * const ptr)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_MANAGEDMEM_FREE, profiler_);
    const rtError_t error = impl_->ManagedMemFree(ptr);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::MemAdvise(void* devPtr, uint64_t count, uint32_t advise)
{
    const rtError_t error = impl_->MemAdvise(devPtr, count, advise);
    return error;
}

rtError_t ApiProfileLogDecorator::MemCopySync(void * const dst, const uint64_t destMax, const void * const src,
    const uint64_t cnt, const rtMemcpyKind_t kind, const uint32_t checkKind)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_MEM_CPY, profiler_);
    const rtError_t error = impl_->MemCopySync(dst, destMax, src, cnt, kind, checkKind);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::MemcpyAsync(void * const dst, const uint64_t destMax, const void * const src,
    const uint64_t cnt, const rtMemcpyKind_t kind, Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo,
    const rtD2DAddrCfgInfo_t * const addrCfg, bool checkKind, const rtMemcpyConfig_t * const memcpyConfig)
{
    UNUSED(checkKind);
    UNUSED(memcpyConfig);
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_MEM_ASYNC, profiler_);
    const rtError_t error = impl_->MemcpyAsync(dst, destMax, src, cnt, kind, stm, cfgInfo, addrCfg);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::MemCopy2DSync(void * const dst, const uint64_t dstPitch, const void * const src,
    const uint64_t srcPitch, const uint64_t width, const uint64_t height, const rtMemcpyKind_t kind, const rtMemcpyKind newkind)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_MEM_CPY2D, profiler_);
    const rtError_t error = impl_->MemCopy2DSync(dst, dstPitch, src, srcPitch, width, height, kind, newkind);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::MemCopy2DAsync(void * const dst, const uint64_t dstPitch, const void * const src,
    const uint64_t srcPitch, const uint64_t width, const uint64_t height, Stream * const stm,
    const rtMemcpyKind_t kind, const rtMemcpyKind newkind)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_MEM_CPY2D_ASYNC, profiler_);
    const rtError_t error = impl_->MemCopy2DAsync(dst, dstPitch, src, srcPitch, width, height, stm, kind, newkind);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::MemcpyHostTask(void * const dst, const uint64_t destMax, const void * const src,
    const uint64_t cnt, const rtMemcpyKind_t kind, Stream * const stm)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_HOST_TASK_MEMCPY, profiler_);
    const rtError_t error = impl_->MemcpyHostTask(dst, destMax, src, cnt, kind, stm);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::ReduceAsync(void * const dst, const void * const src, const uint64_t cnt,
    const rtRecudeKind_t kind, const rtDataType_t type, Stream * const stm,
    const rtTaskCfgInfo_t * const cfgInfo)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_ReduceAsync, profiler_);
    const rtError_t error = impl_->ReduceAsync(dst, src, cnt, kind, type, stm, cfgInfo);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::ReduceAsyncV2(void * const dst, const void * const src, const uint64_t cnt,
    const rtRecudeKind_t kind, const rtDataType_t type, Stream * const stm, void * const overflowAddr)
{
    const rtError_t error = impl_->ReduceAsyncV2(dst, src, cnt, kind, type, stm, overflowAddr);
    return error;
}

rtError_t ApiProfileLogDecorator::MemSetSync(const void * const devPtr, const uint64_t destMax, const uint32_t val,
    const uint64_t cnt)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_Memset, profiler_);
    const rtError_t error = impl_->MemSetSync(devPtr, destMax, val, cnt);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::MemsetAsync(void * const ptr, const uint64_t destMax, const uint32_t val,
                                              const uint64_t cnt, Stream * const stm)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_MemsetAsync, profiler_);
    const rtError_t error = impl_->MemsetAsync(ptr, destMax, val, cnt, stm);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::SetDevice(const int32_t devId)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_SET_DEVICE, profiler_);
    const rtError_t error = impl_->SetDevice(devId);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::DeviceReset(const int32_t devId, const bool isForceReset)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_DEVICE_RESET, profiler_);
    const rtError_t error = impl_->DeviceReset(devId, isForceReset);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::DeviceResetForce(const int32_t devId)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_DEVICE_RESET_FORCE, profiler_);
    const rtError_t error = impl_->DeviceResetForce(devId);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::DeviceSynchronize(const int32_t timeout)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_DEVICE_SYNCHRONIZE, profiler_);
    const rtError_t error = impl_->DeviceSynchronize(timeout);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::ContextCreate(Context ** const inCtx, const int32_t devId)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_CONTEXT_CREATE, profiler_);
    const rtError_t error = impl_->ContextCreate(inCtx, devId);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::ContextDestroy(Context * const inCtx)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_CONTEXT_DESTROY, profiler_);
    const rtError_t error = impl_->ContextDestroy(inCtx);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::ContextSetCurrent(Context * const inCtx)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_CONTEXT_SETCURRENT, profiler_);
    const rtError_t error = impl_->ContextSetCurrent(inCtx);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::NameStream(Stream * const stm, const char_t * const name)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(name, RT_ERROR_INVALID_VALUE);

    const uint32_t nameLen = strnlen(name, static_cast<size_t>(M_PROF_STREAM_NAME_LEN));
    if (nameLen >= static_cast<uint32_t>(M_PROF_STREAM_NAME_LEN)) {
        RT_LOG(RT_LOG_ERROR, "stream name too long, range[0, %u).", M_PROF_STREAM_NAME_LEN);
        return RT_ERROR_PROF_NAME;
    }
    stm->SetName(name);
    return impl_->NameStream(stm, name);
}

rtError_t ApiProfileLogDecorator::NameEvent(Event * const evt, const char_t * const name)
{
    NULL_PTR_RETURN_MSG_OUTER(evt, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG_OUTER(name, RT_ERROR_INVALID_VALUE);
    const size_t nameLen = strnlen(name, static_cast<size_t>(M_PROF_EVENT_NAME_LEN));
    if (nameLen >= static_cast<uint64_t>(M_PROF_EVENT_NAME_LEN)) {
        RT_LOG(RT_LOG_ERROR, "event name too long, range[0, %u).", M_PROF_EVENT_NAME_LEN);
        return RT_ERROR_PROF_NAME;
    }
    evt->SetName(name);
    return impl_->NameEvent(evt, name);
}

rtError_t ApiProfileLogDecorator::ModelCreate(Model ** const mdl, const uint32_t flag)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_MODEL_CREATE, profiler_);
    const rtError_t error = impl_->ModelCreate(mdl, flag);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::ModelSetExtId(Model * const mdl, const uint32_t extId)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_MODEL_SET_EXT_ID, profiler_);
    const rtError_t error = impl_->ModelSetExtId(mdl, extId);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::ModelDestroy(Model * const mdl)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_MODEL_DESTROY, profiler_);
    const rtError_t error = impl_->ModelDestroy(mdl);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::ModelBindStream(Model * const mdl, Stream * const stm, const uint32_t flag)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_MODEL_BIND_STREAM, profiler_);
    const rtError_t error = impl_->ModelBindStream(mdl, stm, flag);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::ModelUnbindStream(Model * const mdl, Stream * const stm)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_MODEL_UNBIND_STREAM, profiler_);
    const rtError_t error = impl_->ModelUnbindStream(mdl, stm);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::ModelExecute(Model * const mdl, Stream * const stm, const uint32_t flag, int32_t timeout)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_MODEL_EXECUTE, profiler_);
    const rtError_t error = impl_->ModelExecute(mdl, stm, flag, timeout);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::ModelExecuteSync(Model * const mdl, int32_t timeout)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_MODEL_EXECUTE_SYNC, profiler_);
    const rtError_t error = impl_->ModelExecuteSync(mdl, timeout);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::ModelExecuteAsync(Model * const mdl, Stream * const stm)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_MODEL_EXECUTE_ASYNC, profiler_);
    const rtError_t error = impl_->ModelExecuteAsync(mdl, stm);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::NotifyCreate(const int32_t deviceId, Notify ** const retNotify, uint64_t flag)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_NotifyCreate, profiler_);
    const rtError_t error = impl_->NotifyCreate(deviceId, retNotify, flag);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::NotifyDestroy(Notify * const inNotify)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_NotifyDestroy, profiler_);
    const rtError_t error = impl_->NotifyDestroy(inNotify);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::NotifyRecord(Notify * const inNotify, Stream * const stm)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_NotifyRecord, profiler_);
    const rtError_t error = impl_->NotifyRecord(inNotify, stm);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::NotifyReset(Notify * const inNotify)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_NOTIFY_RESET, profiler_);
    const rtError_t error = impl_->NotifyReset(inNotify);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::NotifyWait(Notify * const inNotify, Stream * const stm, const uint32_t timeOut)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_NotifyWait, profiler_);
    const rtError_t error = impl_->NotifyWait(inNotify, stm, timeOut);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::IpcOpenNotify(Notify ** const retNotify, const char_t * const name, uint32_t flag)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_IpcOpenNotify, profiler_);
    const rtError_t error = impl_->IpcOpenNotify(retNotify, name, flag);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::ModelSetSchGroupId(Model * const mdl, const int16_t schGrpId)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_MODEL_SET_SCH_GROUP_ID, profiler_);
    const rtError_t error = impl_->ModelSetSchGroupId(mdl, schGrpId);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::ModelTaskUpdate(Stream *desStm, uint32_t desTaskId, Stream *sinkStm,
                                                  rtMdlTaskUpdateInfo_t *para)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_MODEL_TASK_UPDATE, profiler_);
    const rtError_t error = impl_->ModelTaskUpdate(desStm, desTaskId, sinkStm, para);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::SubscribeReport(const uint64_t threadId, Stream * const stm)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_rtSubscribeReport, profiler_);
    const rtError_t error = impl_->SubscribeReport(threadId, stm);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::CallbackLaunch(const rtCallback_t callBackFunc, void * const fnData,
    Stream * const stm, const bool isBlock)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_rtCallbackLaunch, profiler_);
    const rtError_t error = impl_->CallbackLaunch(callBackFunc, fnData, stm, isBlock);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::ProcessReport(const int32_t timeout, const bool noLog)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_rtProcessReport, profiler_);
    const rtError_t error = impl_->ProcessReport(timeout, noLog);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::UnSubscribeReport(const uint64_t threadId, Stream * const stm)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_rtUnSubscribeReport, profiler_);
    const rtError_t error = impl_->UnSubscribeReport(threadId, stm);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::GetRunMode(rtRunMode * const runMode)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_rtGetRunMode, profiler_);
    const rtError_t error = impl_->GetRunMode(runMode);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::LabelSwitchByIndex(void * const ptr, const uint32_t maxVal, void * const labelInfoPtr,
    Stream * const stm)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_LabelSwitchByIndex, profiler_);
    const rtError_t error = impl_->LabelSwitchByIndex(ptr, maxVal, labelInfoPtr, stm);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::LabelGotoEx(Label * const lbl, Stream * const stm)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_LabelGotoEx, profiler_);
    const rtError_t error = impl_->LabelGotoEx(lbl, stm);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::LabelListCpy(Label ** const lbl, const uint32_t labelNumber, void * const dst,
    const uint32_t dstMax)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_Label2Content, profiler_);
    const rtError_t error = impl_->LabelListCpy(lbl, labelNumber, dst, dstMax);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::StreamWaitEvent(Stream * const stm, Event * const evt, const uint32_t timeout)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_STREAM_WAITEVENT, profiler_);
    const rtError_t error = impl_->StreamWaitEvent(stm, evt, timeout);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::CtxSetSysParamOpt(const rtSysParamOpt configOpt, const int64_t configVal)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_CtxSetSysParamOpt, profiler_);
    const rtError_t error = impl_->CtxSetSysParamOpt(configOpt, configVal);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::CtxGetSysParamOpt(const rtSysParamOpt configOpt, int64_t * const configVal)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_CtxGetSysParamOpt, profiler_);
    const rtError_t error = impl_->CtxGetSysParamOpt(configOpt, configVal);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::CtxGetOverflowAddr(void ** const overflowAddr)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_CtxGetOverflowAddr, profiler_);
    const rtError_t error = impl_->CtxGetOverflowAddr(overflowAddr);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::GetDeviceSatStatus(void * const outputAddrPtr, const uint64_t outputSize,
    Stream * const stm)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_GetDeviceSatStatus, profiler_);
    const rtError_t error = impl_->GetDeviceSatStatus(outputAddrPtr, outputSize, stm);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::CleanDeviceSatStatus(Stream * const stm)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_CleanDeviceSatStatus, profiler_);
    const rtError_t error = impl_->CleanDeviceSatStatus(stm);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::StreamClear(Stream * const stm, rtClearStep_t step)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_STREAM_CLEAR, profiler_);
    const rtError_t error = impl_->StreamClear(stm, step);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::GetVisibleDeviceIdByLogicDeviceId(const int32_t logicDeviceId,
    int32_t * const visibleDeviceId)
{
    return impl_->GetVisibleDeviceIdByLogicDeviceId(logicDeviceId, visibleDeviceId);
}

rtError_t ApiProfileLogDecorator::GetLogicDevIdByUserDevId(const int32_t userDevId, int32_t * const logicDevId)
{
    ProfileLogRecord record(RT_PROF_API_USER_TO_LOGIC_ID, profiler_);
    const rtError_t error = impl_->GetLogicDevIdByUserDevId(userDevId, logicDevId);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::GetUserDevIdByLogicDevId(const int32_t logicDevId, int32_t * const userDevId)
{
    ProfileLogRecord record(RT_PROF_API_LOGIC_TO_USER_ID, profiler_);
    const rtError_t error = impl_->GetUserDevIdByLogicDevId(logicDevId, userDevId);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::MemWriteValue(const void * const devAddr, const uint64_t value, const uint32_t flag, Stream * const stm)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_MEM_WRITE_VALUE, profiler_);
    const rtError_t error = impl_->MemWriteValue(devAddr, value, flag, stm);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::MemWaitValue(const void * const devAddr, const uint64_t value, const uint32_t flag, Stream * const stm)
{
    ProfileLogRecord record(PROFILE_RECORD_TYPE_RT_CALL_RT, RT_PROF_API_MEM_WAIT_VALUE, profiler_);
    const rtError_t error = impl_->MemWaitValue(devAddr, value, flag, stm);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::MemcpyBatch(void **dsts, void **srcs, size_t *sizes, size_t count,
    rtMemcpyBatchAttr *attrs, size_t *attrsIdxs, size_t numAttrs, size_t *failIdx)
{
    ProfileLogRecord record(RT_PROF_API_MEMCPY_BATCH, profiler_);
    const rtError_t error = impl_->MemcpyBatch(dsts, srcs, sizes, count, attrs, attrsIdxs, numAttrs, failIdx);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::MemcpyBatchAsync(void** const dsts, const size_t* const destMaxs, void** const srcs, const size_t* const sizes,
    const size_t count, const rtMemcpyBatchAttr* const attrs, const size_t* const attrsIdxs, const size_t numAttrs, size_t* const failIdx,
    Stream* const stm)
{
    ProfileLogRecord record(RT_PROF_API_MEMCPY_ASYNC_BATCH, profiler_);
    const rtError_t error = 
        impl_->MemcpyBatchAsync(dsts, destMaxs, srcs, sizes, count, attrs, attrsIdxs, numAttrs, failIdx, stm);
    record.SaveRecord();
    return error;
}

rtError_t ApiProfileLogDecorator::CacheLastTaskOpInfo(const void * const infoPtr, const size_t infoSize)
{
    ProfileLogRecord record(RT_PROF_API_CACHE_LAST_TASK_OP_INFO, profiler_);
    const rtError_t error = impl_->CacheLastTaskOpInfo(infoPtr, infoSize);
    record.SaveRecord();
    return error;
}

}  // namespace runtime
}  // namespace cce
