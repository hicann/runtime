/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_c.h"
#include "profiler.hpp"
#include "api_profile_decorator.hpp"

namespace cce {
namespace runtime {

ApiProfileDecorator::ApiProfileDecorator(Api * const impl,
    Profiler * const prof) : ApiDecorator(impl), profiler_(prof)
{
    UNUSED(impl);
    UNUSED(prof);
}

void ApiProfileDecorator::CallApiBegin(const uint16_t profileType,
    const uint64_t dataSize, const uint16_t cpyDirection) const
{
    if (!profiler_->GetApiProfEnable()) {
        return;
    }

    RuntimeProfApiData &profApiData = profiler_->GetProfApiData();
    profApiData.magicNumber = static_cast<uint16_t>(MSPROF_DATA_HEAD_MAGIC_NUM);
    profApiData.dataTag = static_cast<uint16_t>(MSPROF_RUNTIME_DATA_TAG_API);
    profApiData.threadId = PidTidFetcher::GetCurrentTid();
    profApiData.dataSize = dataSize;
    profApiData.memcpyDirection = cpyDirection;
    profApiData.maxSize = CalculateMemcpyAsyncSingleMaxSize(static_cast<rtMemcpyKind_t>(cpyDirection));
    profApiData.streamId = static_cast<uint32_t>(UINT16_MAX);
    profApiData.taskNum = 0U;
    profApiData.profileType = profileType;

    RT_LOG(RT_LOG_DEBUG, "profileType=%hu", profApiData.profileType);
    profApiData.entryTime = MsprofSysCycleTime();
}

void ApiProfileDecorator::CallApiEnd(const rtError_t retCode, const uint32_t devId) const
{
    if (!profiler_->GetApiProfEnable()) {
        return;
    }

    const uint64_t endTime = MsprofSysCycleTime();
    uint32_t deviceId = devId;
    TaskTrackInfo &trackMngInfo = profiler_->GetProfTaskTrackData();
    const uint32_t taskNum = trackMngInfo.taskNum;

    if (deviceId == static_cast<uint32_t>(UINT16_MAX)) {
        Context *curCtx = nullptr;
        const rtError_t error = impl_->ContextGetCurrent(&curCtx);
        if ((error == RT_ERROR_NONE) && (ContextManage::CheckContextIsValid(curCtx, true))) {
            const ContextProtect cp(curCtx);
            deviceId = curCtx->Device_()->Id_();
        }
    }

    // report task track info
    for (uint32_t i = 0U; i < taskNum; i++) {
        RuntimeProfTrackData *data = &trackMngInfo.trackBuff[i];
        RT_LOG(RT_LOG_DEBUG, "isModel=%u, threadId=%u, timeStamp=%llu, devId=%u, stream_id=%u, task_id=%u, "
            "task_type=%u, kernel_name=%llu",
            data->isModel, data->compactInfo.threadId, data->compactInfo.timeStamp,
            data->compactInfo.data.runtimeTrack.deviceId, data->compactInfo.data.runtimeTrack.streamId,
            data->compactInfo.data.runtimeTrack.taskId, data->compactInfo.data.runtimeTrack.taskType,
            data->compactInfo.data.runtimeTrack.kernelName);
        const bool agingFlag = (data->isModel != 0) ? false : true;
        const int32_t ret = MsprofReportCompactInfo(static_cast<uint32_t>(agingFlag), &(data->compactInfo),
            static_cast<uint32_t>(sizeof(MsprofCompactInfo)));
        if (ret != MSPROF_ERROR_NONE) {
            RT_LOG_CALL_MSG(ERR_MODULE_PROFILE, "Profiling reporter report task_track failed, ret=%d.", ret);
            return;
        }
    }
    trackMngInfo.taskNum = 0U;

    // report runtime api info
    RuntimeProfApiData &profApiData = profiler_->GetProfApiData();
    profApiData.retCode = static_cast<uint32_t>(RT_TRANS_EXT_ERRCODE(retCode));
    profApiData.exitTime = endTime;
    profiler_->ReportProfApi(deviceId, profApiData);

    profApiData.dataTag = static_cast<uint16_t>(UINT16_MAX);
    RT_LOG(RT_LOG_DEBUG, "profileType=%hu, devId=%u, retCode=%u", profApiData.profileType, deviceId, retCode);
}

rtError_t ApiProfileDecorator::DevBinaryRegister(const rtDevBinary_t * const bin, Program ** const prog)
{
    CallApiBegin(RT_PROF_API_DEVBINARY_REGISTER);
    const rtError_t error = impl_->DevBinaryRegister(bin, prog);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::GetNotifyAddress(Notify * const notify, uint64_t * const notifyAddress)
{
    CallApiBegin(RT_PROF_API_GET_NOTIFY_ADDR);
    const rtError_t error = impl_->GetNotifyAddress(notify, notifyAddress);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::RegisterAllKernel(const rtDevBinary_t * const bin, Program ** const prog)
{
    CallApiBegin(RT_PROF_API_ALLKERNEL_REGISTER);
    const rtError_t error = impl_->RegisterAllKernel(bin, prog);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::DevBinaryUnRegister(Program * const prog)
{
    CallApiBegin(RT_PROF_API_DEVBINARY_UNREGISTER);
    const rtError_t error = impl_->DevBinaryUnRegister(prog);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::MetadataRegister(Program * const prog, const char_t * const metadata)
{
    return impl_->MetadataRegister(prog, metadata);
}

rtError_t ApiProfileDecorator::DependencyRegister(Program * const mProgram, Program * const sProgram)
{
    return impl_->DependencyRegister(mProgram, sProgram);
}

rtError_t ApiProfileDecorator::FunctionRegister(Program * const prog, const void * const stubFunc,
    const char_t * const stubName, const void * const kernelInfoExt, const uint32_t funcMode)
{
    CallApiBegin(RT_PROF_API_FUNCTION_REGISTER);
    const rtError_t error = impl_->FunctionRegister(prog, stubFunc, stubName, kernelInfoExt, funcMode);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::GetFunctionByName(const char_t * const stubName, void ** const stubFunc)
{
    CallApiBegin(RT_PROF_API_GET_FUNCTION_BY_NAME);
    const rtError_t error = impl_->GetFunctionByName(stubName, stubFunc);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::QueryFunctionRegistered(const char_t * const stubName)
{
    CallApiBegin(RT_PROF_API_QUERY_FUNCTION_REGISTERED);
    const rtError_t error = impl_->QueryFunctionRegistered(stubName);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::KernelFusionStart(Stream * const stm)
{
    CallApiBegin(RT_PROF_API_KERNEL_FUSION_START);
    const rtError_t error = impl_->KernelFusionStart(stm);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::KernelFusionEnd(Stream * const stm)
{
    CallApiBegin(RT_PROF_API_KERNEL_FUSION_END);
    const rtError_t error = impl_->KernelFusionEnd(stm);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::BuffGetInfo(const rtBuffGetCmdType type, const void * const inBuff, const uint32_t inLen,
    void * const outBuff, uint32_t * const outLen)
{
    CallApiBegin(RT_PROF_API_BUFF_GET_INFO);
    const rtError_t error = impl_->BuffGetInfo(type, inBuff, inLen, outBuff, outLen);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::KernelLaunch(const void * const stubFunc, const uint32_t coreDim,
    const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm, const uint32_t flag,
    const rtTaskCfgInfo_t * const cfgInfo, const bool isLaunchVec)
{
    const uint32_t argSize = argsInfo->argsSize;
    const bool isNotFlowCtrl = ((stm == nullptr) || (!(stm->GetFlowCtrlFlag())));
    if (isNotFlowCtrl) {
        if (argSize > 32768U) { // 32768 is large
            CallApiBegin(RT_PROF_API_KERNEL_LAUNCH_LARGE);
        } else if (argSize > 4096U) { // 4096 is huge
            CallApiBegin(RT_PROF_API_KERNEL_LAUNCH_HUGE);
        } else if (argSize > 1024U) { // 1024 is the big
            CallApiBegin(RT_PROF_API_KERNEL_LAUNCH_BIG);
        } else {
            CallApiBegin(RT_PROF_API_KERNEL_LAUNCH);
        }
    } else {
        stm->ClearFlowCtrlFlag();
        CallApiBegin(RT_PROF_API_KERNEL_LAUNCH_FLOW_CTRL);
    }

    const rtError_t error = impl_->KernelLaunch(stubFunc, coreDim, argsInfo, l2ctrl, stm, flag, cfgInfo, isLaunchVec);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::KernelLaunchWithHandle(void * const hdl, const uint64_t tilingKey,
    const uint32_t coreDim, const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm,
    const rtTaskCfgInfo_t * const cfgInfo, const bool isLaunchVec)
{
    const uint32_t argSize = argsInfo->argsSize;
    const bool isNotFlowCtrl = ((stm == nullptr) || (!(stm->GetFlowCtrlFlag())));
    if (isNotFlowCtrl) {
        if (argSize > 32768U) { // 32768 is large
            CallApiBegin(RT_PROF_API_KERNEL_LAUNCH_WITH_HANDLE_LARGE);
        } else if (argSize > 4096U) { // 4096 is huge
            CallApiBegin(RT_PROF_API_KERNEL_LAUNCH_WITH_HANDLE_HUGE);
        } else if (argSize > 1024U) { // 1024 is the big
            CallApiBegin(RT_PROF_API_KERNEL_LAUNCH_WITH_HANDLE_BIG);
        } else {
            CallApiBegin(RT_PROF_API_KERNEL_LAUNCH_WITH_HANDLE);
        }
    } else {
        stm->ClearFlowCtrlFlag();
        CallApiBegin(RT_PROF_API_KERNEL_LAUNCH_WITH_HANDLE_FLOW_CTRL);
    }

    const rtError_t error =
        impl_->KernelLaunchWithHandle(hdl, tilingKey, coreDim, argsInfo, l2ctrl, stm, cfgInfo, isLaunchVec);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::KernelLaunchEx(const char_t * const opName, const void * const args,
    const uint32_t argsSize, const uint32_t flags, Stream * const stm)
{
    CallApiBegin(RT_PROF_API_KERNEL_LAUNCH_EX);
    const rtError_t error = impl_->KernelLaunchEx(opName, args, argsSize, flags, stm);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::GetServerIDBySDID(uint32_t sdid, uint32_t *srvId)
{
    CallApiBegin(RT_PROF_API_GetServerIDBySDID);
    const rtError_t error = impl_->GetServerIDBySDID(sdid, srvId);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::CpuKernelLaunch(const rtKernelLaunchNames_t * const launchNames, const uint32_t coreDim,
    const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm, const uint32_t flag)
{
    CallApiBegin(RT_PROF_API_CpuKernelLaunch);
    const rtError_t error = impl_->CpuKernelLaunch(launchNames, coreDim, argsInfo, l2ctrl, stm, flag);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::CpuKernelLaunchExWithArgs(const char_t * const opName,
    const uint32_t coreDim, const rtAicpuArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm,
    const uint32_t flag, const uint32_t kernelType)
{
    const uint32_t argSize = argsInfo->argsSize;
    if (argSize > 32768U) { // 32768 is large
        CallApiBegin(RT_PROF_API_CpuKernelLaunch_EX_WITH_ARG_LARGE);
    } else if (argSize > 4096U) { // 4096 is huge
        CallApiBegin(RT_PROF_API_CpuKernelLaunch_EX_WITH_ARG_HUGE);
    } else if (argSize > 1024U) { // 1024 is the big
        CallApiBegin(RT_PROF_API_CpuKernelLaunch_EX_WITH_ARG_BIG);
    } else {
        CallApiBegin(RT_PROF_API_CpuKernelLaunch_EX_WITH_ARG);
    }

    const rtError_t error = impl_->CpuKernelLaunchExWithArgs(opName, coreDim, argsInfo, l2ctrl, stm, flag, kernelType);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::MultipleTaskInfoLaunch(const rtMultipleTaskInfo_t * const taskInfo, Stream * const stm,
    const uint32_t flag)
{
    return impl_->MultipleTaskInfoLaunch(taskInfo, stm, flag);
}

rtError_t ApiProfileDecorator::BinaryLoad(const rtDevBinary_t * const bin, Program ** const prog)
{
    CallApiBegin(RT_PROF_API_BINARY_LOAD);
    const rtError_t error = impl_->BinaryLoad(bin, prog);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::BinaryGetFunction(const Program * const prog, const uint64_t tilingKey,
                                                 Kernel ** const funcHandle)
{
    CallApiBegin(RT_PROF_API_BINARY_GET_FUNCTION);
    const rtError_t error = impl_->BinaryGetFunction(prog, tilingKey, funcHandle);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::BinaryLoadWithoutTilingKey(const void *data, const uint64_t length,
                                                          Program ** const prog)
{
    CallApiBegin(RT_PROF_API_BINARY_LOAD_WITHOUT_TILING_KEY);
    const rtError_t error = impl_->BinaryLoadWithoutTilingKey(data, length, prog);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::BinaryGetFunctionByName(const Program * const binHandle, const char_t *kernelName,
                                                       Kernel ** const funcHandle)
{
    CallApiBegin(RT_PROF_API_BINARY_GET_FUNCTION_BY_NAME);
    const rtError_t error = impl_->BinaryGetFunctionByName(binHandle, kernelName, funcHandle);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::BinaryGetFunctionByEntry(const Program * const binHandle, const uint64_t funcEntry,
                                                        Kernel ** const funcHandle)
{
    CallApiBegin(RT_PROF_API_BINARY_GET_FUNCTION_BY_ENTRY);
    const rtError_t error = impl_->BinaryGetFunctionByEntry(binHandle, funcEntry, funcHandle);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::BinaryUnLoad(Program * const binHandle)
{
    CallApiBegin(RT_PROF_API_BINARY_UNLOAD);
    const rtError_t error = impl_->BinaryUnLoad(binHandle);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::BinaryLoadFromFile(const char_t * const binPath,
                                                  const rtLoadBinaryConfig_t * const optionalCfg,
                                                  Program **handle)
{
    CallApiBegin(RT_PROF_API_BINARY_LOAD_FROM_FILE);
    const rtError_t error = impl_->BinaryLoadFromFile(binPath, optionalCfg, handle);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::BinaryLoadFromData(const void * const data, const uint64_t length,
                                                  const rtLoadBinaryConfig_t * const optionalCfg, Program **handle)
{
    CallApiBegin(RT_PROF_API_BINARY_LOAD_FROM_DATA);
    const rtError_t error = impl_->BinaryLoadFromData(data, length, optionalCfg, handle);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::FuncGetAddr(const Kernel * const funcHandle, void ** const aicAddr, void ** const aivAddr)
{
    CallApiBegin(RT_PROF_API_FUNC_GET_ADDR);
    const rtError_t error = impl_->FuncGetAddr(funcHandle, aicAddr, aivAddr);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::LaunchKernel(Kernel * const kernel, uint32_t blockDim, const rtArgsEx_t * const argsInfo,
                                            Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo)
{
    const uint32_t argSize = argsInfo->argsSize;
    if (argSize > 32768U) { // 32768 is large
        CallApiBegin(RT_PROF_API_LAUNCH_KERNEL_LARGE);
    } else if (argSize > 4096U) { // 4096 the huge
        CallApiBegin(RT_PROF_API_LAUNCH_KERNEL_HUGE);
    } else if (argSize > 1024U) { // 1024 is the big
        CallApiBegin(RT_PROF_API_LAUNCH_KERNEL_BIG);
    } else {
        CallApiBegin(RT_PROF_API_LAUNCH_KERNEL);
    }

    const rtError_t error = impl_->LaunchKernel(kernel, blockDim, argsInfo, stm, cfgInfo);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::LaunchKernelV2(Kernel * const kernel, uint32_t blockDim, const RtArgsWithType * const argsWithType,
    Stream * const stm, const rtKernelLaunchCfg_t * const cfg)
{
    CallApiBegin(RT_PROF_API_LAUNCH_KERNEL_V2);
    const rtError_t error = impl_->LaunchKernelV2(kernel, blockDim, argsWithType, stm, cfg);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::LaunchKernelV3(Kernel * const kernel, const rtArgsEx_t * const argsInfo,
                                              Stream * const stm, const rtLaunchConfig_t * const launchConfig)
{
    const uint32_t argSize = argsInfo->argsSize;
    if (argSize > 32768U) { // 32768 is large
        CallApiBegin(RT_PROF_API_LAUNCH_KERNEL_LARGE);
    } else if (argSize > 4096U) { // big then 4096 is huge
        CallApiBegin(RT_PROF_API_LAUNCH_KERNEL_HUGE);
    } else if (argSize > 1024U) { // 1024 is the big
        CallApiBegin(RT_PROF_API_LAUNCH_KERNEL_BIG);
    } else {
        CallApiBegin(RT_PROF_API_LAUNCH_KERNEL);
    }

    const rtError_t error = impl_->LaunchKernelV3(kernel, argsInfo, stm, launchConfig);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::DatadumpInfoLoad(const void * const dumpInfo, const uint32_t length, const uint32_t flag)
{
    CallApiBegin(RT_PROF_API_DATA_DUMP_INFO_LOAD);
    const rtError_t error = impl_->DatadumpInfoLoad(dumpInfo, length, flag);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::AicpuInfoLoad(const void * const aicpuInfo, const uint32_t length)
{
    CallApiBegin(RT_PROF_API_AI_CPU_INFO_LOAD);
    const rtError_t error = impl_->AicpuInfoLoad(aicpuInfo, length);
    CallApiEnd(error);

    return error;
}

rtError_t ApiProfileDecorator::StreamCreate(Stream ** const stm, const int32_t priority, const uint32_t flags,
    DvppGrp *grp)
{
    CallApiBegin(RT_PROF_API_STREAM_CREATE);
    const rtError_t error = impl_->StreamCreate(stm, priority, flags, grp);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::StreamDestroy(Stream * const stm, const bool flag)
{
    CallApiBegin(RT_PROF_API_STREAM_DESTROY);
    const rtError_t error = impl_->StreamDestroy(stm, flag);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::StreamWaitEvent(Stream * const stm, Event * const evt, const uint32_t timeout)
{
    CallApiBegin(RT_PROF_API_STREAM_WAITEVENT);
    const rtError_t error = impl_->StreamWaitEvent(stm, evt, timeout);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::StreamSynchronize(Stream * const stm, const int32_t timeout)
{
    CallApiBegin(RT_PROF_API_STREAM_SYNCHRONIZE);
    const rtError_t error = impl_->StreamSynchronize(stm, timeout);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::StreamSetMode(Stream * const stm, const uint64_t stmMode)
{
    CallApiBegin(RT_PROF_API_STREAM_SET_MODE);
    const rtError_t error = impl_->StreamSetMode(stm, stmMode);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::StreamGetMode(const Stream * const stm, uint64_t * const stmMode)
{
    CallApiBegin(RT_PROF_API_STREAM_GET_MODE);
    const rtError_t error = impl_->StreamGetMode(stm, stmMode);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::EventCreate(Event ** const evt, const uint64_t flag)
{
    CallApiBegin(RT_PROF_API_EVENT_CREATE);
    const rtError_t error = impl_->EventCreate(evt, flag);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::EventCreateEx(Event ** const evt, const uint64_t flag)
{
    CallApiBegin(RT_PROF_API_EVENT_CREATE_EX);
    const rtError_t error = impl_->EventCreateEx(evt, flag);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::EventCreateForNotify(Event ** const evt)
{
    CallApiBegin(RT_PROF_API_EVENT_CREATE_FOR_NOTIFY);
    const rtError_t error = impl_->EventCreateForNotify(evt);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::GetEventID(Event * const evt, uint32_t * const evtId)
{
    CallApiBegin(RT_PROF_API_GetEventID);
    const rtError_t error = impl_->GetEventID(evt, evtId);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::EventDestroy(Event *evt)
{
    CallApiBegin(RT_PROF_API_EVENT_DESTROY);
    const rtError_t error = impl_->EventDestroy(evt);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::EventRecord(Event * const evt, Stream * const stm)
{
    CallApiBegin(RT_PROF_API_EVENT_RECORD);
    const rtError_t error = impl_->EventRecord(evt, stm);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::EventRecordForNotify(Event * const evt, Stream * const stm)
{
    CallApiBegin(RT_PROF_API_EVENT_RECORD_FOR_NOTIFY);
    const rtError_t error = impl_->EventRecordForNotify(evt, stm);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::EventSynchronize(Event * const evt, const int32_t timeout)
{
    CallApiBegin(RT_PROF_API_EVENT_SYNCHRONIZE);
    const rtError_t error = impl_->EventSynchronize(evt, timeout);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::DevMalloc(void ** const devPtr, const uint64_t size, const rtMemType_t type,
    const uint16_t moduleId)
{
    CallApiBegin(RT_PROF_API_DEV_MALLOC);
    const rtError_t error = impl_->DevMalloc(devPtr, size, type, moduleId);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::DevFree(void * const devPtr)
{
    CallApiBegin(RT_PROF_API_DEV_FREE);
    const rtError_t error = impl_->DevFree(devPtr);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::DevMallocCached(void ** const devPtr, const uint64_t size, const rtMemType_t type,
    const uint16_t moduleId)
{
    CallApiBegin(RT_PROF_API_CAHCEDMEM_ALLOC);
    const rtError_t error = impl_->DevMallocCached(devPtr, size, type, moduleId);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::DevDvppMalloc(void ** const devPtr, const uint64_t size, const uint32_t flag,
    const uint16_t moduleId)
{
    CallApiBegin(RT_PROF_API_DEV_DVPP_MALLOC);
    const rtError_t error = impl_->DevDvppMalloc(devPtr, size, flag, moduleId);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::DevDvppFree(void * const devPtr)
{
    CallApiBegin(RT_PROF_API_DEV_DVPP_FREE);
    const rtError_t error = impl_->DevDvppFree(devPtr);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::MemAdvise(void *devPtr, const uint64_t count, const uint32_t advise)
{
    CallApiBegin(RT_PROF_API_MEM_ADVISE);
    const rtError_t error = impl_->MemAdvise(devPtr, count, advise);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::HostMalloc(void ** const hostPtr, const uint64_t size, const uint16_t moduleId)
{
    CallApiBegin(RT_PROF_API_HOST_MALLOC);
    const rtError_t error = impl_->HostMalloc(hostPtr, size, moduleId);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::HostFree(void * const hostPtr)
{
    CallApiBegin(RT_PROF_API_HOST_FREE);
    const rtError_t error = impl_->HostFree(hostPtr);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::ManagedMemAlloc(void ** const ptr, const uint64_t size, const uint32_t flag,
    const uint16_t moduleId)
{
    CallApiBegin(RT_PROF_API_MANAGEDMEM_ALLOC);
    const rtError_t error = impl_->ManagedMemAlloc(ptr, size, flag, moduleId);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::ManagedMemFree(const void * const ptr)
{
    CallApiBegin(RT_PROF_API_MANAGEDMEM_FREE);
    const rtError_t error = impl_->ManagedMemFree(ptr);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::MemCopySync(void * const dst, const uint64_t destMax, const void * const src,
    const uint64_t cnt, const rtMemcpyKind_t kind, const uint32_t checkKind)
{
    CallApiBegin(RT_PROF_API_MEM_CPY, cnt, kind);
    const rtError_t error = impl_->MemCopySync(dst, destMax, src, cnt, kind, checkKind);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::MemcpyAsync(void * const dst, const uint64_t destMax, const void * const src,
    const uint64_t cnt, const rtMemcpyKind_t kind, Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo,
    const rtD2DAddrCfgInfo_t * const addrCfg, bool checkKind, const rtMemcpyConfig_t * const memcpyConfig)
{
    UNUSED(checkKind);
    UNUSED(memcpyConfig);
    const bool isNotFlowCtrl = ((stm == nullptr) || (!(stm->GetFlowCtrlFlag())));
    uint16_t profileType = RT_PROF_API_MEMCPY_ASYNC;

    rtProfApiType_t typeTmp = (cnt > 4096ULL) ? RT_PROF_API_MEMCPY_ASYNC_HUGE : RT_PROF_API_MEMCPY_ASYNC;
    profileType = (!isNotFlowCtrl) ? RT_PROF_API_MEMCPY_ASYNC_FLOW_CTRL : typeTmp;

    if (!isNotFlowCtrl) {
        stm->ClearFlowCtrlFlag();
    }

    CallApiBegin(profileType, cnt, kind);
    const rtError_t error = impl_->MemcpyAsync(dst, destMax, src, cnt, kind, stm, cfgInfo, addrCfg);
    CallApiEnd(error);
    return error;
}
rtError_t ApiProfileDecorator::GetDevArgsAddr(Stream * const stm, rtArgsEx_t * const argsInfo,
    void ** const devArgsAddr, void ** const argsHandle)
{
    CallApiBegin(RT_PROF_API_GET_DEV_ARG_ADDR);
    const rtError_t error = impl_->GetDevArgsAddr(stm, argsInfo, devArgsAddr, argsHandle);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::ReduceAsync(void * const dst, const void * const src, const uint64_t cnt,
    const rtRecudeKind_t kind, const rtDataType_t type, Stream * const stm,
    const rtTaskCfgInfo_t * const cfgInfo)
{
    CallApiBegin(RT_PROF_API_ReduceAsync, cnt, kind);
    const rtError_t error = impl_->ReduceAsync(dst, src, cnt, kind, type, stm, cfgInfo);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::ReduceAsyncV2(void * const dst, const void * const src, const uint64_t cnt,
    const rtRecudeKind_t kind, const rtDataType_t type, Stream * const stm, void * const overflowAddr)
{
    const Runtime *const rtInstance = Runtime::Instance();
    NULL_PTR_RETURN_MSG(rtInstance, RT_ERROR_INSTANCE_NULL);
    Context *const curCtx = rtInstance->CurrentContext();
    NULL_PTR_RETURN_MSG(curCtx, RT_ERROR_CONTEXT_NULL);
    Device *const dev = curCtx->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    const uint32_t tsVersion = dev->GetTschVersion() & 0xFFFFU;  // low 16bit means tschverion
    const auto reduceOverflowProp = dev->GetDevProperties().reduceOverflow;
    if ((reduceOverflowProp == ReduceOverflowType::REDUCE_OVERFLOW_TS_VERSION_REDUCE_V2_ID) && 
        (tsVersion >= static_cast<uint32_t>(TS_VERSION_REDUCE_V2_ID))) {
        CallApiBegin(RT_PROF_API_REDUCE_ASYNC_V2);
    } else if ((reduceOverflowProp == ReduceOverflowType::REDUCE_OVERFLOW_TS_VERSION_REDUCV2_SUPPORT_DC) && 
        (tsVersion >= static_cast<uint32_t>(TS_VERSION_REDUCV2_SUPPORT_DC))) {
        CallApiBegin(RT_PROF_API_REDUCE_ASYNC_V2);
    } else {
        CallApiBegin(RT_PROF_API_REDUCE_ASYNC_V2, cnt, kind);
    }
    const rtError_t error = impl_->ReduceAsyncV2(dst, src, cnt, kind, type, stm, overflowAddr);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::MemCopy2DSync(void * const dst, const uint64_t dstPitch, const void * const src,
    const uint64_t srcPitch, const uint64_t width, const uint64_t height,
    const rtMemcpyKind_t kind, const rtMemcpyKind newKind)
{
    CallApiBegin(RT_PROF_API_MEM_CPY2D);
    const rtError_t error = impl_->MemCopy2DSync(dst, dstPitch, src, srcPitch, width, height, kind, newKind);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::MemCopy2DAsync(void * const dst, const uint64_t dstPitch, const void * const src,
    const uint64_t srcPitch, const uint64_t width, const uint64_t height, Stream * const stm,
    const rtMemcpyKind_t kind, const rtMemcpyKind newKind)
{
    CallApiBegin(RT_PROF_API_MEM_CPY2D_ASYNC, width * height, kind);
    const rtError_t error = impl_->MemCopy2DAsync(dst, dstPitch, src, srcPitch, width, height, stm, kind, newKind);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::MemcpyAsyncPtr(void * const memcpyAddrInfo, const uint64_t destMax,
    const uint64_t count, Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo, const bool isMemcpyDesc)
{
    CallApiBegin(RT_PROF_API_MEM_CPY_ASYNC_PTR, count, RT_MEMCPY_ADDR_DEVICE_TO_DEVICE);
    const rtError_t error = impl_->MemcpyAsyncPtr(memcpyAddrInfo, destMax, count, stm, cfgInfo, isMemcpyDesc);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::MemcpyHostTask(void * const dst, const uint64_t destMax, const void * const src,
    const uint64_t cnt, const rtMemcpyKind_t kind, Stream * const stm)
{
    CallApiBegin(RT_PROF_API_HOST_TASK_MEMCPY);
    const rtError_t error = impl_->MemcpyHostTask(dst, destMax, src, cnt, kind, stm);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::SetDevice(const int32_t devId)
{
    CallApiBegin(RT_PROF_API_SET_DEVICE);
    const rtError_t error = impl_->SetDevice(devId);
    CallApiEnd(error, static_cast<uint32_t>(devId));
    return error;
}

rtError_t ApiProfileDecorator::DeviceReset(const int32_t devId, const bool isForceReset)
{
    CallApiBegin(RT_PROF_API_DEVICE_RESET);
    const rtError_t error = impl_->DeviceReset(devId, isForceReset);
    CallApiEnd(error, static_cast<uint32_t>(devId));
    return error;
}

rtError_t ApiProfileDecorator::DeviceResetForce(const int32_t devId)
{
    CallApiBegin(RT_PROF_API_DEVICE_RESET_FORCE);
    const rtError_t error = impl_->DeviceResetForce(devId);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::DeviceSynchronize(const int32_t timeout)
{
    CallApiBegin(RT_PROF_API_DEVICE_SYNCHRONIZE);
    const rtError_t error = impl_->DeviceSynchronize(timeout);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::ContextCreate(Context ** const inCtx, const int32_t devId)
{
    CallApiBegin(RT_PROF_API_CONTEXT_CREATE);
    const rtError_t error = impl_->ContextCreate(inCtx, devId);
    CallApiEnd(error, static_cast<uint32_t>(devId));
    return error;
}

rtError_t ApiProfileDecorator::ContextDestroy(Context * const inCtx)
{
    CallApiBegin(RT_PROF_API_CONTEXT_DESTROY);
    const uint32_t devId = inCtx->Device_()->Id_();
    const rtError_t error = impl_->ContextDestroy(inCtx);
    CallApiEnd(error, devId);
    return error;
}

rtError_t ApiProfileDecorator::ContextGetCurrent(Context ** const inCtx)
{
    CallApiBegin(RT_PROF_API_CONTEXT_GET_CURRENT);
    const rtError_t error = impl_->ContextGetCurrent(inCtx);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::GetPrimaryCtxState(const int32_t devId, uint32_t *flags, int32_t *active)
{
    CallApiBegin(RT_PROF_API_GET_DEFAULT_CTX_STATE);
    const rtError_t error = impl_->GetPrimaryCtxState(devId, flags, active);
    CallApiEnd(error);
    return error;
}
rtError_t ApiProfileDecorator::ContextSetCurrent(Context * const inCtx)
{
    CallApiBegin(RT_PROF_API_CONTEXT_SETCURRENT);
    const rtError_t error = impl_->ContextSetCurrent(inCtx);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::NameStream(Stream * const stm, const char_t * const name)
{
    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);
 	NULL_PTR_RETURN_MSG_OUTER(name, RT_ERROR_INVALID_VALUE);

    const uint32_t nameLen = strnlen(name, static_cast<size_t>(M_PROF_STREAM_NAME_LEN));
    if (nameLen >= static_cast<uint32_t>(M_PROF_STREAM_NAME_LEN)) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Stream name too long, range[0, %u).", M_PROF_STREAM_NAME_LEN);
        return RT_ERROR_PROF_NAME;
    }
    stm->SetName(name);
    return impl_->NameStream(stm, name);
}

rtError_t ApiProfileDecorator::NameEvent(Event * const evt, const char_t * const name)
{
    NULL_PTR_RETURN_MSG_OUTER(evt, RT_ERROR_INVALID_VALUE);
 	NULL_PTR_RETURN_MSG_OUTER(name, RT_ERROR_INVALID_VALUE);
    const size_t nameLen = strnlen(name, static_cast<size_t>(M_PROF_EVENT_NAME_LEN));
    if (nameLen >= static_cast<uint64_t>(M_PROF_EVENT_NAME_LEN)) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Event name too long, range[0, %u.", M_PROF_EVENT_NAME_LEN);
        return RT_ERROR_PROF_NAME;
    }
    evt->SetName(name);
    return impl_->NameEvent(evt, name);
}

rtError_t ApiProfileDecorator::ModelCreate(Model ** const mdl, const uint32_t flag)
{
    CallApiBegin(RT_PROF_API_MODEL_CREATE);
    const rtError_t error = impl_->ModelCreate(mdl, flag);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::ModelSetExtId(Model * const mdl, const uint32_t extId)
{
    CallApiBegin(RT_PROF_API_MODEL_SET_EXT_ID);
    const rtError_t error = impl_->ModelSetExtId(mdl, extId);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::ModelDestroy(Model * const mdl)
{
    CallApiBegin(RT_PROF_API_MODEL_DESTROY);
    const rtError_t error = impl_->ModelDestroy(mdl);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::ModelBindStream(Model * const mdl, Stream * const stm, const uint32_t flag)
{
    CallApiBegin(RT_PROF_API_MODEL_BIND_STREAM);
    const rtError_t error = impl_->ModelBindStream(mdl, stm, flag);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::ModelUnbindStream(Model * const mdl, Stream * const stm)
{
    CallApiBegin(RT_PROF_API_MODEL_UNBIND_STREAM);
    const rtError_t error = impl_->ModelUnbindStream(mdl, stm);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::ModelExecute(Model *const mdl, Stream * const stm,
    const uint32_t flag, int32_t timeout)
{
    CallApiBegin(RT_PROF_API_MODEL_EXECUTE);
    const rtError_t error = impl_->ModelExecute(mdl, stm, flag, timeout);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::ModelExecuteSync(Model *const mdl, int32_t timeout)
{
    CallApiBegin(RT_PROF_API_MODEL_EXECUTE_SYNC);
    const rtError_t error = impl_->ModelExecuteSync(mdl, timeout);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::ModelExecuteAsync(Model *const mdl, Stream * const stm)
{
    CallApiBegin(RT_PROF_API_MODEL_EXECUTE_ASYNC);
    const rtError_t error = impl_->ModelExecuteAsync(mdl, stm);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::NotifyCreate(const int32_t deviceId, Notify ** const retNotify, uint64_t flag)
{
    CallApiBegin(RT_PROF_API_NotifyCreate);
    const rtError_t error = impl_->NotifyCreate(deviceId, retNotify, flag);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::NotifyDestroy(Notify * const inNotify)
{
    CallApiBegin(RT_PROF_API_NotifyDestroy);
    const rtError_t error = impl_->NotifyDestroy(inNotify);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::NotifyRecord(Notify * const inNotify, Stream * const stm)
{
    CallApiBegin(RT_PROF_API_NotifyRecord);
    const rtError_t error = impl_->NotifyRecord(inNotify, stm);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::NotifyReset(Notify * const inNotify)
{
    CallApiBegin(RT_PROF_API_NOTIFY_RESET);
    const rtError_t error = impl_->NotifyReset(inNotify);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::NotifyWait(Notify * const inNotify, Stream * const stm, const uint32_t timeOut)
{
    CallApiBegin(RT_PROF_API_NotifyWait);
    const rtError_t error = impl_->NotifyWait(inNotify, stm, timeOut);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::IpcOpenNotify(Notify ** const retNotify, const char_t * const name, uint32_t flag)
{
    CallApiBegin(RT_PROF_API_IpcOpenNotify);
    const rtError_t error = impl_->IpcOpenNotify(retNotify, name, flag);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::ModelSetSchGroupId(Model * const mdl, const int16_t schGrpId)
{
    CallApiBegin(RT_PROF_API_MODEL_SET_SCH_GROUP_ID);
    const rtError_t error = impl_->ModelSetSchGroupId(mdl, schGrpId);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::ModelTaskUpdate(Stream *desStm, uint32_t desTaskId, Stream *sinkStm,
                                               rtMdlTaskUpdateInfo_t *para)
{
    CallApiBegin(RT_PROF_API_MODEL_TASK_UPDATE);
    const rtError_t error = impl_->ModelTaskUpdate(desStm, desTaskId, sinkStm, para);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::SubscribeReport(const uint64_t threadId, Stream * const stm)
{
    CallApiBegin(RT_PROF_API_rtSubscribeReport);
    const rtError_t error = impl_->SubscribeReport(threadId, stm);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::CallbackLaunch(const rtCallback_t callBackFunc, void * const fnData,
    Stream * const stm, const bool isBlock)
{
    CallApiBegin(RT_PROF_API_rtCallbackLaunch);
    const rtError_t error = impl_->CallbackLaunch(callBackFunc, fnData, stm, isBlock);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::ProcessReport(const int32_t timeout, const bool noLog)
{
    CallApiBegin(RT_PROF_API_rtProcessReport);
    const RuntimeProfApiData profApiData = profiler_->GetProfApiData();
    const rtError_t error = impl_->ProcessReport(timeout, noLog);
    profiler_->SetProfApiData(profApiData);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::UnSubscribeReport(const uint64_t threadId, Stream * const stm)
{
    CallApiBegin(RT_PROF_API_rtUnSubscribeReport);
    const rtError_t error = impl_->UnSubscribeReport(threadId, stm);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::GetRunMode(rtRunMode * const runMode)
{
    CallApiBegin(RT_PROF_API_rtGetRunMode);
    const rtError_t error = impl_->GetRunMode(runMode);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::LabelSwitchByIndex(void * const ptr, const uint32_t maxVal, void * const labelInfoPtr,
    Stream * const stm)
{
    CallApiBegin(RT_PROF_API_LabelSwitchByIndex);
    const rtError_t error = impl_->LabelSwitchByIndex(ptr, maxVal, labelInfoPtr, stm);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::LabelGotoEx(Label * const lbl, Stream * const stm)
{
    CallApiBegin(RT_PROF_API_LabelGotoEx);
    const rtError_t error = impl_->LabelGotoEx(lbl, stm);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::LabelListCpy(Label ** const lbl, const uint32_t labelNumber, void * const dst,
    const uint32_t dstMax)
{
    CallApiBegin(RT_PROF_API_Label2Content);
    const rtError_t error = impl_->LabelListCpy(lbl, labelNumber, dst, dstMax);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::StarsTaskLaunch(const void * const sqe, const uint32_t sqeLen, Stream * const stm,
    const uint32_t flag)
{
    CallApiBegin(RT_PROF_API_STARS_TASK_LAUNCH);
    const rtError_t error = impl_->StarsTaskLaunch(sqe, sqeLen, stm, flag);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::LabelDestroy(Label * const lbl)
{
    CallApiBegin(RT_PROF_API_LABELDESTROY);
    const rtError_t error = impl_->LabelDestroy(lbl);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::CmoTaskLaunch(const rtCmoTaskInfo_t * const taskInfo, Stream * const stm,
    const uint32_t flag)
{
    CallApiBegin(RT_PROF_API_CMO_TASK_LAUNCH);
    const rtError_t error = impl_->CmoTaskLaunch(taskInfo, stm, flag);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::CmoAddrTaskLaunch(void *cmoAddrInfo, const uint64_t destMax,
    const rtCmoOpCode_t cmoOpCode, Stream * const stm, const uint32_t flag)
{
    CallApiBegin(RT_PROF_API_CMO_ADDR_TASK_LAUNCH);
    const rtError_t error = impl_->CmoAddrTaskLaunch(cmoAddrInfo, destMax, cmoOpCode, stm, flag);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::BarrierTaskLaunch(const rtBarrierTaskInfo_t * const taskInfo, Stream * const stm,
    const uint32_t flag)
{
    CallApiBegin(RT_PROF_API_BARRIER_TASK_LAUNCH);
    const rtError_t error = impl_->BarrierTaskLaunch(taskInfo, stm, flag);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::CtxSetSysParamOpt(const rtSysParamOpt configOpt, const int64_t configVal)
{
    CallApiBegin(RT_PROF_API_CtxSetSysParamOpt);
    const rtError_t error = impl_->CtxSetSysParamOpt(configOpt, configVal);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::CtxGetSysParamOpt(const rtSysParamOpt configOpt, int64_t * const configVal)
{
    CallApiBegin(RT_PROF_API_CtxGetSysParamOpt);
    const rtError_t error = impl_->CtxGetSysParamOpt(configOpt, configVal);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::CtxGetOverflowAddr(void ** const overflowAddr)
{
    CallApiBegin(RT_PROF_API_CtxGetOverflowAddr);
    const rtError_t error = impl_->CtxGetOverflowAddr(overflowAddr);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::GetDeviceSatStatus(void * const outputAddrPtr, const uint64_t outputSize,
    Stream * const stm)
{
    CallApiBegin(RT_PROF_API_GetDeviceSatStatus);
    const rtError_t error = impl_->GetDeviceSatStatus(outputAddrPtr, outputSize, stm);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::CleanDeviceSatStatus(Stream * const stm)
{
    CallApiBegin(RT_PROF_API_CleanDeviceSatStatus);
    const rtError_t error = impl_->CleanDeviceSatStatus(stm);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::StreamClear(Stream * const stm, rtClearStep_t step)
{
    CallApiBegin(RT_PROF_API_STREAM_CLEAR);
    const rtError_t error = impl_->StreamClear(stm, step);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::GetVisibleDeviceIdByLogicDeviceId(const int32_t logicDeviceId,
    int32_t * const visibleDeviceId)
{
    return impl_->GetVisibleDeviceIdByLogicDeviceId(logicDeviceId, visibleDeviceId);
}

rtError_t ApiProfileDecorator::GetLogicDevIdByUserDevId(const int32_t userDevId, int32_t * const logicDevId)
{
    CallApiBegin(RT_PROF_API_USER_TO_LOGIC_ID);
    const rtError_t error = impl_->GetLogicDevIdByUserDevId(userDevId, logicDevId);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::GetUserDevIdByLogicDevId(const int32_t logicDevId, int32_t * const userDevId)
{
    CallApiBegin(RT_PROF_API_LOGIC_TO_USER_ID);
    const rtError_t error = impl_->GetUserDevIdByLogicDevId(logicDevId, userDevId);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::DevMalloc(void ** const devPtr, uint64_t size, rtMallocPolicy policy, rtMallocAdvise advise,
                                        const rtMallocConfig_t * const cfg)
{
    CallApiBegin(RT_PROF_API_DEV_MALLOC);
    const rtError_t error = impl_->DevMalloc(devPtr, size, policy, advise, cfg);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::LaunchDvppTask(const void * const sqe, const uint32_t sqeLen, Stream * const stm, rtDvppCfg_t *cfg)
{
    CallApiBegin(RT_PROF_API_LAUNCH_DVPP_TASK);
    const rtError_t error = impl_->LaunchDvppTask(sqe, sqeLen, stm, cfg);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::LaunchRandomNumTask(const rtRandomNumTaskInfo_t *taskInfo, Stream * const stm, void *reserve)
{
    CallApiBegin(RT_PROF_API_LAUNCH_RANDOM_NUM_TASK);
    const rtError_t error = impl_->LaunchRandomNumTask(taskInfo, stm, reserve);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::KernelArgsInit(Kernel * const funcHandle, RtArgsHandle **argsHandle)
{
    CallApiBegin(RT_PROF_API_KERNEL_ARGS_INIT);
    const rtError_t error = impl_->KernelArgsInit(funcHandle, argsHandle);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::KernelArgsAppendPlaceHolder(RtArgsHandle *argsHandle, ParaDetail **paraHandle)
{
    CallApiBegin(RT_PROF_API_KERNEL_ARGS_APEND_PLACE_HOLDER);
    const rtError_t error = impl_->KernelArgsAppendPlaceHolder(argsHandle, paraHandle);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::KernelArgsGetPlaceHolderBuffer(RtArgsHandle *argsHandle, ParaDetail *paraHandle,
    size_t dataSize, void **bufferAddr)
{
    CallApiBegin(RT_PROF_API_KERNEL_ARGS_GET_PLACE_HOLDER_BUFF);
    const rtError_t error = impl_->KernelArgsGetPlaceHolderBuffer(argsHandle, paraHandle, dataSize, bufferAddr);
    CallApiEnd(error);
    return error;
}
rtError_t ApiProfileDecorator::KernelArgsGetHandleMemSize(Kernel * const funcHandle, size_t *memSize)
{
    CallApiBegin(RT_PROF_API_KERNEL_ARGS_GET_HANDLE_MEM_SIZE);
    const rtError_t error = impl_->KernelArgsGetHandleMemSize(funcHandle, memSize);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::KernelArgsFinalize(RtArgsHandle *argsHandle)
{
    CallApiBegin(RT_PROF_API_KERNEL_ARGS_FINALIZE);
    const rtError_t error = impl_->KernelArgsFinalize(argsHandle);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::KernelArgsGetMemSize(Kernel * const funcHandle, size_t userArgsSize, size_t *actualArgsSize)
{
    CallApiBegin(RT_PROF_API_KERNEL_ARGS_GET_MEM_SIZE);
    const rtError_t error = impl_->KernelArgsGetMemSize(funcHandle, userArgsSize, actualArgsSize);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::KernelArgsInitByUserMem(Kernel * const funcHandle, RtArgsHandle *argsHandle, void *userHostMem,
        size_t actualArgsSize)
{
    CallApiBegin(RT_PROF_API_KERNEL_ARGS_INIT_BY_USER_MEM);
    const rtError_t error = impl_->KernelArgsInitByUserMem(funcHandle, argsHandle, userHostMem, actualArgsSize);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::KernelArgsAppend(RtArgsHandle *argsHandle, void *para, size_t paraSize, ParaDetail **paraHandle)
{
    CallApiBegin(RT_PROF_API_KERNEL_ARGS_APEND);
    const rtError_t error = impl_->KernelArgsAppend(argsHandle, para, paraSize, paraHandle);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::MemcpyBatch(void **dsts, void **srcs, size_t *sizes, size_t count,
    rtMemcpyBatchAttr *attrs, size_t *attrsIdxs, size_t numAttrs, size_t *failIdx)
{
    CallApiBegin(RT_PROF_API_MEMCPY_BATCH);
    const rtError_t error = impl_->MemcpyBatch(dsts, srcs, sizes, count, attrs, attrsIdxs, numAttrs, failIdx);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::MemWriteValue(const void * const devAddr, const uint64_t value, const uint32_t flag, Stream * const stm)
{
    CallApiBegin(RT_PROF_API_MEM_WRITE_VALUE);
    const rtError_t error = impl_->MemWriteValue(devAddr, value, flag, stm);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::MemWaitValue(const void * const devAddr, const uint64_t value, const uint32_t flag, Stream * const stm)
{
    CallApiBegin(RT_PROF_API_MEM_WAIT_VALUE);
    const rtError_t error = impl_->MemWaitValue(devAddr, value, flag, stm);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::GetCmoDescSize(size_t *size)
{
    CallApiBegin(RT_PROF_API_GET_CMO_DESC_SIZE);
    const rtError_t error = impl_->GetCmoDescSize(size);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::SetCmoDesc(rtCmoDesc_t cmoDesc, void *srcAddr, size_t srcLen)
{
    CallApiBegin(RT_PROF_API_SET_CMO_DESC);
    const rtError_t error = impl_->SetCmoDesc(cmoDesc, srcAddr, srcLen);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::MemcpyBatchAsync(void** const dsts, const size_t* const destMaxs, void** const srcs, const size_t* const sizes,
    const size_t count, const rtMemcpyBatchAttr* const attrs, const size_t* const attrsIdxs, const size_t numAttrs, size_t* const failIdx,
    Stream* const stm)
{
    CallApiBegin(RT_PROF_API_MEMCPY_ASYNC_BATCH);
    const rtError_t error =
        impl_->MemcpyBatchAsync(dsts, destMaxs, srcs, sizes, count, attrs, attrsIdxs, numAttrs, failIdx, stm);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::LaunchHostFunc(Stream * const stm, const rtCallback_t callBackFunc, void * const fnData)
{
    CallApiBegin(RT_PROF_API_LAUNCH_HOST_CALLBACK);
    const rtError_t error = impl_->LaunchHostFunc(stm, callBackFunc, fnData);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::CacheLastTaskOpInfo(const void * const infoPtr, const size_t infoSize)
{
    CallApiBegin(RT_PROF_API_CACHE_LAST_TASK_OP_INFO);
    const rtError_t error = impl_->CacheLastTaskOpInfo(infoPtr, infoSize);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::IpcGetEventHandle(IpcEvent * const evt, rtIpcEventHandle_t *handle)
{
    CallApiBegin(RT_PROF_API_GET_EVENT_HANDLE);
    const rtError_t error = impl_->IpcGetEventHandle(evt, handle);
    CallApiEnd(error);
    return error;
}

rtError_t ApiProfileDecorator::IpcOpenEventHandle(rtIpcEventHandle_t *handle, IpcEvent** const event)
{
    CallApiBegin(RT_PROF_API_OPEN_EVENT_HANDLE);
    const rtError_t error = impl_->IpcOpenEventHandle(handle, event);
    CallApiEnd(error);
    return error;
}

}  // namespace runtime
}  // namespace cce
