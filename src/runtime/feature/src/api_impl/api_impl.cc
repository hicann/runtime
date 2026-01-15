/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_impl.hpp"
#include "base.hpp"
#include "stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "event.hpp"
#include "ipc_event.hpp"
#include "program.hpp"
#include "notify.hpp"
#include "group_device.hpp"
#include "task.hpp"
#include "host_task.hpp"
#include "osal.hpp"
#include "profiler.hpp"
#include "npu_driver.hpp"
#include "device_state_callback_manager.hpp"
#include "task_fail_callback_manager.hpp"
#include "prof_ctrl_callback_manager.hpp"
#include "profiling_agent.hpp"
#include "error_message_manage.hpp"
#include "device_msg_handler.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "dvpp_grp.hpp"
#include "driver/ascend_hal.h"
#include "task_submit.hpp"
#include "runtime/rt_preload_task.h"
#include "platform/platform_info.h"
#include "stream_factory.hpp"
#include "device/device_error_proc.hpp"
#include "stream_state_callback_manager.hpp"
#include "heterogenous.h"
#include "capture_model.hpp"
#include "capture_model_utils.hpp"
#include "capture_adapt.hpp"
#include "stars_engine.hpp"
#include "binary_loader.hpp"
#include "args_handle_allocator.hpp"
#include "para_convertor.hpp"
#include "stub_task.hpp"
#include "soc_info.h"
#include "task_execute_time.h"
#include "starsv2_base.hpp"
#include "register_memory.hpp"
#define RT_DRV_FAULT_CNT 25U
#define NULL_STREAM_PTR_RETURN_MSG(STREAM)     NULL_PTR_RETURN_MSG((STREAM), RT_ERROR_STREAM_NULL)


namespace {
constexpr uint32_t MEM_POLICY_MASK = 0xFFU;
constexpr uint32_t MEM_TYPE_MASK = 0xFF00U;
constexpr int32_t MEMCPY_BATCH_ASYNC_FEATURE = 3;

}

namespace cce {
namespace runtime {

TIMESTAMP_EXTERN(MemCopy2D);
TIMESTAMP_EXTERN(AicoreLoad);
TIMESTAMP_EXTERN(AicpuLoad);
TIMESTAMP_EXTERN(AllocTaskAndSendDc);
TIMESTAMP_EXTERN(AllocTaskAndSendStars);
TIMESTAMP_EXTERN(ArgRelease);
TIMESTAMP_EXTERN(BatchDelDavinciRecordedTask);
TIMESTAMP_EXTERN(CmoAddrTaskLaunch);
TIMESTAMP_EXTERN(CmoTaskLaunch);
TIMESTAMP_EXTERN(CommandOccupy);
TIMESTAMP_EXTERN(CommandOccupyNormal);
TIMESTAMP_EXTERN(CommandOccupyNormalV1);
TIMESTAMP_EXTERN(CommandOccupyV1);
TIMESTAMP_EXTERN(CommandSend);
TIMESTAMP_EXTERN(CommandSendV1);
TIMESTAMP_EXTERN(drvMemsetD8);
TIMESTAMP_EXTERN(Engine_ProcessTaskWait);
TIMESTAMP_EXTERN(FftsPlusTaskAlloc);
TIMESTAMP_EXTERN(FftsPlusTaskH2Dcpy);
TIMESTAMP_EXTERN(FftsPlusTaskInit);
TIMESTAMP_EXTERN(GetRecycleTask);
TIMESTAMP_EXTERN(HalfEventProc);
TIMESTAMP_EXTERN(HalfEventProcV1);
TIMESTAMP_EXTERN(halResourceIdFree);
TIMESTAMP_EXTERN(KernelTaskCompleteOther);
TIMESTAMP_EXTERN(MemoryPoolManagerRelease);
TIMESTAMP_EXTERN(ModuleDevMemFree);
TIMESTAMP_EXTERN(ModuleMemAlloc);
TIMESTAMP_EXTERN(ModuleMemCpy);
TIMESTAMP_EXTERN(ObserverFinished);
TIMESTAMP_EXTERN(ObserverLaunched);
TIMESTAMP_EXTERN(ObserverSubmitted);
TIMESTAMP_EXTERN(PopTask);
TIMESTAMP_EXTERN(ProcessPublicTask);
TIMESTAMP_EXTERN(PushTask);
TIMESTAMP_EXTERN(QueryCqShmData);
TIMESTAMP_EXTERN(RecycleProcessDavinciList);
TIMESTAMP_EXTERN(ReleaseMemoryPoolManager);
TIMESTAMP_EXTERN(ReportReceive);
TIMESTAMP_EXTERN(ReportRelease);
TIMESTAMP_EXTERN(rtAppendLaunchAddrInfo);
TIMESTAMP_EXTERN(rtAppendLaunchHostInfo);
TIMESTAMP_EXTERN(rtBinaryLoad_DevMemAlloc);
TIMESTAMP_EXTERN(rtBinaryLoad_MemCopySync);
TIMESTAMP_EXTERN(rtBinaryUnLoad_DevMemRelease);
TIMESTAMP_EXTERN(rtCalcLaunchArgsSize);
TIMESTAMP_EXTERN(rtDvppFree);
TIMESTAMP_EXTERN(rtDvppMalloc);
TIMESTAMP_EXTERN(rtEventCreate);
TIMESTAMP_EXTERN(rtEventDestroy);
TIMESTAMP_EXTERN(rtEventRecord);
TIMESTAMP_EXTERN(rtEventReset);
TIMESTAMP_EXTERN(rtEventSynchronize);
TIMESTAMP_EXTERN(rtFree_drvMemUnLock_drvMemFreeManaged);
TIMESTAMP_EXTERN(rtFreeHost);
TIMESTAMP_EXTERN(rtsFreeHost);
TIMESTAMP_EXTERN(rtKernelConfigTransArg);
TIMESTAMP_EXTERN(rtKernelLaunch);
TIMESTAMP_EXTERN(rtKernelLaunchWithFlagV2);
TIMESTAMP_EXTERN(rtKernelLaunch_ALLKernelLookup);
TIMESTAMP_EXTERN(rtKernelLaunch_AllocTask);
TIMESTAMP_EXTERN(rtKernelLaunch_ArgLoad);
TIMESTAMP_EXTERN(rtKernelLaunch_ArgLoad_Lite);
TIMESTAMP_EXTERN(rtKernelLaunch_ArgLoadAll);
TIMESTAMP_EXTERN(rtKernelLaunch_ArgLoadAll_LITE);
TIMESTAMP_EXTERN(rtKernelLaunch_ArgLoadAllForMix);
TIMESTAMP_EXTERN(rtKernelLaunch_ArgLoadForMix);
TIMESTAMP_EXTERN(rtKernelLaunch_CpuArgLoad);
TIMESTAMP_EXTERN(rtKernelLaunch_GetModule);
TIMESTAMP_EXTERN(rtKernelLaunch_KernelLookup);
TIMESTAMP_EXTERN(rtKernelLaunch_MemCopyAsync);
TIMESTAMP_EXTERN(rtKernelLaunch_MemCopyAsync_DmaFind);
TIMESTAMP_EXTERN(rtKernelLaunch_MemCopyAsync_HostCpy);
TIMESTAMP_EXTERN(rtKernelLaunch_MemCopyPcie);
TIMESTAMP_EXTERN(rtKernelLaunch_PutProgram);
TIMESTAMP_EXTERN(rtKernelLaunch_PutProgram);
TIMESTAMP_EXTERN(rtKernelLaunch_SubmitTask);
TIMESTAMP_EXTERN(rtKernelLaunch_WaitAsyncCopyComplete);
TIMESTAMP_EXTERN(rtKernelLaunchWithHandle);
TIMESTAMP_EXTERN(rtKernelLaunchWithHandleV2);
TIMESTAMP_EXTERN(rtKernelLaunchWithHandle_SubMit);
TIMESTAMP_EXTERN(rtLaunchKernel_ArgLoadAll_LITE);
TIMESTAMP_EXTERN(rtLaunchKernel_SubMit);
TIMESTAMP_EXTERN(rtMalloc);
TIMESTAMP_EXTERN(rtMallocCached);
TIMESTAMP_EXTERN(rtMallocHost);
TIMESTAMP_EXTERN(rtsMallocHost);
TIMESTAMP_EXTERN(rtMemAllocManaged);
TIMESTAMP_EXTERN(rtMemcpy);
TIMESTAMP_EXTERN(rtsMemcpy);
TIMESTAMP_EXTERN(rtsMemcpyBatch);
TIMESTAMP_EXTERN(rtsMemcpyBatchAsync);
TIMESTAMP_EXTERN(rtMemcpy2D);
TIMESTAMP_EXTERN(rtMemcpy2DAsync);
TIMESTAMP_EXTERN(rtMemcpyAsync);
TIMESTAMP_EXTERN(rtsMemcpyAsync);
TIMESTAMP_EXTERN(rtMemcpyAsyncV2);
TIMESTAMP_EXTERN(rtMemcpyAsyncWithCfg);
TIMESTAMP_EXTERN(rtMemcpyAsyncEx);
TIMESTAMP_EXTERN(rtsSetMemcpyDesc);
TIMESTAMP_EXTERN(rtsMemcpyAsyncWithDesc);
TIMESTAMP_EXTERN(rtMemcpyAsync_drvDeviceGetTransWay);
TIMESTAMP_EXTERN(rtMemcpyAsync_drvMemConvertAddr);
TIMESTAMP_EXTERN(rtMemcpyAsync_drvMemDestroyAddr);
TIMESTAMP_EXTERN(rtMemcpyHostTask_MemCopyAsync);
TIMESTAMP_EXTERN(rtMemFreeManaged);
TIMESTAMP_EXTERN(rtNotifyCreate);
TIMESTAMP_EXTERN(rtNotifyCreateWithFlag);
TIMESTAMP_EXTERN(rtReduceAsync_part1);
TIMESTAMP_EXTERN(rtReduceAsync_part2);
TIMESTAMP_EXTERN(rtReduceAsyncV2_part1);
TIMESTAMP_EXTERN(rtReduceAsyncV2_part2);
TIMESTAMP_EXTERN(rtStreamCreate);
TIMESTAMP_EXTERN(rtStreamCreate_AllocLogicCq);
TIMESTAMP_EXTERN(rtStreamCreate_AllocStreamSqCq);
TIMESTAMP_EXTERN(rtStreamCreate_drvDeviceGetBareTgid);
TIMESTAMP_EXTERN(rtStreamCreate_drvMemAllocHugePageManaged_drvMemAllocManaged_drvMemAdvise);
TIMESTAMP_EXTERN(rtStreamCreate_drvMemAllocL2buffAddr);
TIMESTAMP_EXTERN(rtStreamCreate_drvMemcpy);
TIMESTAMP_EXTERN(rtStreamCreate_drvStreamIdAlloc);
TIMESTAMP_EXTERN(rtStreamCreate_SubmitCreateStreamTask);
TIMESTAMP_EXTERN(rtStreamCreate_taskPublicBuff);
TIMESTAMP_EXTERN(rtStreamDestroy);
TIMESTAMP_EXTERN(rtStreamDestroy_drvMemFreeManaged);
TIMESTAMP_EXTERN(rtStreamDestroy_drvMemFreeManaged_arg);
TIMESTAMP_EXTERN(rtStreamDestroy_drvMemReleaseL2buffAddr);
TIMESTAMP_EXTERN(rtStreamDestroy_drvStreamIdFree);
TIMESTAMP_EXTERN(rtStreamSynchronize);
TIMESTAMP_EXTERN(rtStreamSynchronizeWithTimeout);
TIMESTAMP_EXTERN(SaveTaskInfo);
TIMESTAMP_EXTERN(SqTaskSend);
TIMESTAMP_EXTERN(SqTaskSendNormalV1);
TIMESTAMP_EXTERN(SqTaskSendV1);
TIMESTAMP_EXTERN(TaskRecycle);
TIMESTAMP_EXTERN(TaskRes_AllocTask);
TIMESTAMP_EXTERN(TaskRes_AllocTaskNormal);
TIMESTAMP_EXTERN(TaskSendLimited);
TIMESTAMP_EXTERN(TaskSendLimitedV1);
TIMESTAMP_EXTERN(ToCommand);
TIMESTAMP_EXTERN(ToCommandV1);
TIMESTAMP_EXTERN(TryRecycleTask);
TIMESTAMP_EXTERN(TryRecycleTaskV1);
TIMESTAMP_EXTERN(TryTaskReclaimV1);

TIMESTAMP_EXTERN(TIMESTAMPs_DUMP);

rtError_t ApiImpl::CheckCurCtxValid(const int32_t devId)
{
    if (Runtime::Instance()->GetSetDefaultDevIdFlag()) {
        Context * const curCtx = CurrentContext(true, devId);
        // 异构场景不校验context
        if (RtIsHeterogenous()) {
            RT_LOG(RT_LOG_DEBUG, "Heterogenous do not check ctx.");
            return RT_ERROR_NONE;
        }
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    }
    return RT_ERROR_NONE;
}

Context *ApiImpl::CurrentContext(const bool isNeedSetDevice, int32_t deviceId)
{
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    bool setGroupFlag = false;
    if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_DEVICE_GROUP_DOT_RECORD_GROUPINFO)) {
        setGroupFlag = true;
    }
    Context * const curCtx = InnerThreadLocalContainer::GetCurCtx();
    if (curCtx != nullptr) {
        if (setGroupFlag) {
            procFlag.Set(true);
        }
        return curCtx;
    }

    RefObject<Context *> * const curRef = InnerThreadLocalContainer::GetCurRef();
    if (curRef != nullptr) {
        if (setGroupFlag) {
            procFlag.Set(true);
        }
        return curRef->GetPrimaryCtxCallBackFlag() ? curRef->GetVal(false) : curRef->GetVal();
    }

    // 异构场景不支持隐式setdevice
    if (RtIsHeterogenous()) {
        RT_LOG(RT_LOG_DEBUG, "current ctx is nullptr, Heterogenous do not support set device.");
        return nullptr;
    }

    Runtime *rtInstance = Runtime::Instance();
    const int32_t defaultDeviceId = rtInstance->GetDefaultDeviceId();
    const bool hasSetDefaultDevId = rtInstance->GetSetDefaultDevIdFlag();
    if (isNeedSetDevice && hasSetDefaultDevId) {
        if (deviceId == DEFAULT_DEVICE_ID) {
            // DEFAULT_DEVICE_ID代表无需校验deviceId是否和defaultDeviceID相等
            deviceId = defaultDeviceId;
        }

        if ((deviceId == defaultDeviceId) && (rtInstance->HaveDevice())) {
            const rtError_t error = SetDevice(defaultDeviceId);
            if (error == RT_ERROR_NONE) {
                if (setGroupFlag) {
                    procFlag.Set(true);
                }
                return InnerThreadLocalContainer::GetCurRef()->GetVal();
            }
        }
    }
    RT_LOG(RT_LOG_WARNING, "current ctx is nullptr!");
    return nullptr;
}

rtError_t ApiImpl::DevBinaryRegister(const rtDevBinary_t * const bin, Program ** const prog)
{
    Program *programPtr = nullptr;

    TIMESTAMP_NAME(__func__);
    const rtError_t error = Runtime::Instance()->ProgramRegister(bin, &programPtr);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "register program failed, retCode=%#x", error);
        return error;
    } else {
        *prog = programPtr;
        return RT_ERROR_NONE;
    }
}
rtError_t ApiImpl::GetNotifyAddress(Notify *const notify, uint64_t * const notifyAddress)
{
    uint64_t addr;
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *const curStm = curCtx->DefaultStream_();
    NULL_STREAM_PTR_RETURN_MSG(curStm);
    const rtError_t error = curCtx->GetNotifyAddress(notify, addr, curStm);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "GetNotifyAddress failed, reCode=%#x", error);
        return error;
    }
    RT_LOG(RT_LOG_INFO, "GetNotifyAddress ok, addr=%#" PRIx64, addr);
    *notifyAddress = addr;
    return RT_ERROR_NONE;
}
rtError_t ApiImpl::RegisterAllKernel(const rtDevBinary_t * const bin, Program ** const prog)
{
    Program *programPtr = nullptr;
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();

    TIMESTAMP_NAME(__func__);
    const rtError_t error = Runtime::Instance()->ProgramRegister(bin, &programPtr);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "register program failed, reCode=%#x", error);
        return error;
    } else {
        *prog = programPtr;
        if ((programPtr->Machine() == Program::MACH_AI_MIX_KERNEL) &&
            (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_REGISTER_V2))) {
            return Runtime::Instance()->AllKernelRegisterV2(programPtr, false);
        }
        return Runtime::Instance()->AllKernelRegister(programPtr, false);
    }
}

rtError_t ApiImpl::BinaryRegisterToFastMemory(Program * const prog)
{
    RT_LOG(RT_LOG_INFO, "Binary register to fast memory.");
    prog->SetProgMemType(Program::PROGRAM_MEM_FAST);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::DevBinaryUnRegister(Program * const prog)
{
    RT_LOG(RT_LOG_DEBUG, "unregister binary.");
    TIMESTAMP_NAME(__func__);
    prog->Dereference();
    prog->SetUnRegisteringFlag();
    Runtime::Instance()->PutProgram(prog, true);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::MetadataRegister(Program * const prog, const char_t * const metadata)
{
    RT_LOG(RT_LOG_DEBUG, "register binary metadata.");
    const std::string strMetadata(metadata);
    const auto pos = strMetadata.find(',');
    if (pos == std::string::npos) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,  "No ',' is found in metadata=%s.", metadata);
        RT_LOG(RT_LOG_ERROR, "Register binary metadata failed.");
        return RT_ERROR_METADATA;
    } else {
        const std::string strSoName(strMetadata, 0U, pos);
        prog->SetSoName(strSoName);
        prog->SetMetadata(strMetadata);
        return RT_ERROR_NONE;
    }
}

rtError_t ApiImpl::DependencyRegister(Program * const mProgram, Program * const sProgram)
{
    RT_LOG(RT_LOG_DEBUG, "register binary dependency.");
    mProgram->DependencyRegister(sProgram);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::FunctionRegister(Program * const prog, const void * const stubFunc, const char_t * const stubName,
    const void * const kernelInfoExt, const uint32_t funcMode)
{
    RT_LOG(RT_LOG_DEBUG, "register function, type=%u, stubFunc=%p, funcMode=%u, funcName=%s, kernelInfoExt=%s.",
        prog->Machine(), stubFunc, funcMode, (stubName != nullptr) ? stubName : "(none)", kernelInfoExt);
    TIMESTAMP_NAME(__func__);
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    if ((prog->Machine() == Program::MACH_AI_MIX_KERNEL) &&
        (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_REGISTER_V2))) {
        return Runtime::Instance()->KernelRegisterV2(prog, stubFunc, stubName,
            static_cast<const char_t *>(kernelInfoExt), funcMode);
    }
    return Runtime::Instance()->KernelRegister(prog, stubFunc, stubName, kernelInfoExt, funcMode);
}

rtError_t ApiImpl::GetFunctionByName(const char_t * const stubName, void ** const stubFunc)
{
    RT_LOG(RT_LOG_DEBUG, "name=%s.", (stubName != nullptr) ? stubName : "(none)");
    const void * const stubLook = Runtime::Instance()->StubFuncLookup(stubName);
    *stubFunc = const_cast<void *>(stubLook);
    NULL_PTR_RETURN_NOLOG((*stubFunc), RT_ERROR_KERNEL_LOOKUP);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetAddrByFun(const void * const stubFunc, void ** const addr)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    return Runtime::Instance()->LookupAddrByFun(stubFunc, curCtx, addr);
}

rtError_t ApiImpl::GetAddrAndPrefCntWithHandle(void * const hdl, const void * const kernelInfoExt,
                                               void ** const addr, uint32_t * const prefetchCnt)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    return Runtime::Instance()->LookupAddrAndPrefCntWithHandle(hdl, kernelInfoExt, curCtx,
        addr, prefetchCnt);
}

rtError_t ApiImpl::KernelGetAddrAndPrefCntV2(void * const hdl, const uint64_t tilingKey,
                                             const void * const stubFunc, const uint32_t flag,
                                             rtKernelDetailInfo_t * const kernelInfo)
{
    if (tilingKey == DEFAULT_TILING_KEY) {
        RT_LOG(RT_LOG_DEBUG, "Default tilingKey[%" PRIu64 "].", tilingKey);
        return RT_ERROR_NONE;
    }
    const Kernel *kernel = nullptr;
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    if (flag == RT_STATIC_SHAPE_KERNEL) {
        kernel = Runtime::Instance()->KernelLookup(stubFunc);
        if (kernel == nullptr) {
            RT_LOG(RT_LOG_ERROR, "Can not find kernel by stubFunc[%s].", static_cast<const char_t *>(stubFunc));
            return RT_ERROR_KERNEL_NULL;
        }
    } else {
        Program * const prog = (static_cast<Program *>(hdl));
        kernel = prog->AllKernelLookup(tilingKey);
        if (kernel == nullptr) {
            RT_LOG(RT_LOG_ERROR, "Can not find kernel by tilingKey[%" PRIu64 "].", tilingKey);
            return RT_ERROR_KERNEL_NULL;
        }
    }
    return Runtime::Instance()->LookupAddrAndPrefCnt(kernel, curCtx, kernelInfo);
}

rtError_t ApiImpl::KernelGetAddrAndPrefCnt(void * const hdl, const uint64_t tilingKey,
                                           const void * const stubFunc, const uint32_t flag,
                                           void ** const addr, uint32_t * const prefetchCnt)
{
    const Kernel *kernel = nullptr;
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    if (flag == RT_STATIC_SHAPE_KERNEL) {
        kernel = Runtime::Instance()->KernelLookup(stubFunc);
        COND_RETURN_ERROR_MSG_INNER(kernel == nullptr, RT_ERROR_KERNEL_NULL, "Can not find kernel by stubFunc[%s].",
            static_cast<const char_t *>(stubFunc));
    } else {
        Program * const prog = (static_cast<Program *>(hdl));
        kernel = prog->AllKernelLookup(tilingKey);
        COND_RETURN_ERROR_MSG_INNER(kernel == nullptr, RT_ERROR_KERNEL_NULL,
            "Can not find kernel by tilingKey[%" PRIu64 "].", tilingKey);
    }
    return Runtime::Instance()->LookupAddrAndPrefCnt(kernel, curCtx, addr, prefetchCnt);
}

rtError_t ApiImpl::QueryFunctionRegistered(const char_t * const stubName)
{
    RT_LOG(RT_LOG_DEBUG, "name=%s", (stubName != nullptr) ? stubName : "(none)");
    const void * const stubFunc = Runtime::Instance()->StubFuncLookup(stubName);
    NULL_PTR_RETURN_NOLOG(stubFunc, RT_ERROR_KERNEL_LOOKUP);
    const Kernel * const stubKernel = Runtime::Instance()->KernelLookup(stubFunc);
    NULL_PTR_RETURN_NOLOG(stubKernel, RT_ERROR_KERNEL_LOOKUP);

    const bool unRegistering = stubKernel->Program_()->GetUnRegisteringFlag();
    Runtime::Instance()->PutProgram(stubKernel->Program_());
    if (unRegistering) {
        return RT_ERROR_KERNEL_UNREGISTERING;
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::KernelLaunch(const void * const stubFunc, const uint32_t coreDim,
    const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm, const uint32_t flag,
    const rtTaskCfgInfo_t * const cfgInfo, const bool isLaunchVec)
{
    RT_LOG(RT_LOG_DEBUG, "launch kernel, stubFunc=%p,dim=%u.", stubFunc, coreDim);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Kernel launch failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    if ((flag & RT_KERNEL_DUMPFLAG) != 0U) {
        // adc: kernel dump depend on aicpu sd
        ERROR_RETURN_MSG_INNER(Runtime::Instance()->StartAicpuSd(curCtx->Device_()),
            "kernel launch with kernel dump flag failed, check and start tsd open aicpu sd error.");
    }

    TaskCfg taskCfg = {};

    if (cfgInfo != nullptr) {
        taskCfg.isBaseValid = 1U;
        taskCfg.base = *cfgInfo;
    }
    
    return curCtx->LaunchKernel(stubFunc, coreDim, argsInfo, l2ctrl, curStm, flag, &taskCfg, isLaunchVec);
}

rtError_t ApiImpl::KernelLaunchWithHandle(void * const hdl, const uint64_t tilingKey, const uint32_t coreDim,
    const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm,
    const rtTaskCfgInfo_t * const cfgInfo, const bool isLaunchVec)
{
    RT_LOG(RT_LOG_DEBUG, "launch kernel with hdl, dim=%u, tilingKey=%" PRIu64, coreDim, tilingKey);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Kernel launch with handle failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    uint32_t flag = RT_KERNEL_DEFAULT;
    if ((cfgInfo != nullptr) &&
        ((cfgInfo->dumpflag == RT_KERNEL_DUMPFLAG) || (cfgInfo->dumpflag == RT_FUSION_KERNEL_DUMPFLAG))) {
        flag = static_cast<uint32_t>(cfgInfo->dumpflag);
        RT_LOG(RT_LOG_WARNING, "dumpflag set %u.", flag);
    }
    return curCtx->LaunchKernelWithHandle(hdl, tilingKey, coreDim, argsInfo, l2ctrl,
        curStm, flag, cfgInfo, isLaunchVec);
}

rtError_t ApiImpl::KernelLaunchEx(const char_t * const opName, const void * const args, const uint32_t argsSize,
    const uint32_t flags, Stream * const stm)
{
    RT_LOG(RT_LOG_DEBUG, "ex launch kernel, opName=%s, argsSize=%u, flags=%u.",
           opName, argsSize, flags);
    UNUSED(opName);
    const rtError_t error = AiCpuTaskSupportCheck();
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Kernel launch(extend) failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    Runtime * const rtInstance = Runtime::Instance();
    COND_RETURN_ERROR_MSG_INNER(rtInstance == nullptr, RT_ERROR_INSTANCE_NULL, "Runtime instance is null");
    ERROR_RETURN_MSG_INNER(rtInstance->StartAicpuSd(curCtx->Device_()),
        "Cpu kernel launch ex with args failed, check and start tsd open aicpu sd error.");

    return curCtx->LaunchKernelEx(args, argsSize, flags, curStm);
}

rtError_t ApiImpl::CpuKernelLaunch(const rtKernelLaunchNames_t * const launchNames, const uint32_t coreDim,
    const rtArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm, const uint32_t flag)
{
    RT_LOG(RT_LOG_DEBUG,
           "launch cpu kernel, soName=%s, kernel_name=%s, opName=%s, coreDim=%u, argsSize=%u, hostInputLen=%hu,"
           " flag=%u.", launchNames->soName, launchNames->kernelName, launchNames->opName, coreDim,
           argsInfo->argsSize, argsInfo->hostInputInfoNum, flag);
    UNUSED(l2ctrl);
    const rtError_t error = AiCpuTaskSupportCheck();
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Cpu kernel launch failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    Runtime * const rtInstance = Runtime::Instance();
    COND_RETURN_ERROR_MSG_INNER(rtInstance == nullptr, RT_ERROR_INSTANCE_NULL, "Runtime instance is null");
    ERROR_RETURN_MSG_INNER(rtInstance->StartAicpuSd(curCtx->Device_()),
        "Cpu kernel launch failed, check and start tsd open aicpu sd error.");

    return curCtx->LaunchCpuKernel(launchNames, coreDim, argsInfo, curStm, flag);
}

rtError_t ApiImpl::CpuKernelLaunchEx(const Kernel * const kernel, const uint32_t coreDim,
    const rtCpuKernelArgs_t * const argsInfo, const TaskCfg &taskCfg, Stream * const stm, const uint32_t flag)
{
    const rtError_t error = AiCpuTaskSupportCheck();
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Stream *curStm = (stm == nullptr) ? curCtx->DefaultStream_() : stm;
    NULL_STREAM_PTR_RETURN_MSG(curStm);
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Cpu kernel launch ex failed, stream is not in current ctx, stream_id=%d.", curStm->Id_())
    if (kernel->KernelType_() == static_cast<uint32_t>(KERNEL_TYPE_AICPU_KFC)) {
        Device * const dev = curCtx->Device_();
        COND_RETURN_ERROR(dev == nullptr, RT_ERROR_INVALID_VALUE, "device is NULL.");
        if (!CheckSupportMC2Feature(dev)) {
            RT_LOG(RT_LOG_WARNING, "Current ts version[%u] does not support aicpu kfc kernel launch.",
                dev->GetTschVersion());
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
    }
    Runtime * const rtInstance = Runtime::Instance();
    COND_RETURN_ERROR_MSG_INNER(rtInstance == nullptr, RT_ERROR_INSTANCE_NULL, "Runtime instance is null");
    ERROR_RETURN_MSG_INNER(rtInstance->StartAicpuSd(curCtx->Device_()),
        "Cpu kernel launch ex with args failed, check and start tsd open aicpu sd error.");

    return curCtx->LaunchCpuKernelExWithArgs(kernel, coreDim, argsInfo, taskCfg, stm, flag);
}

rtError_t ApiImpl::CpuKernelLaunchExWithArgs(const char_t * const opName, const uint32_t coreDim,
    const rtAicpuArgsEx_t * const argsInfo, rtL2Ctrl_t * const l2ctrl, Stream * const stm, const uint32_t flag,
    const uint32_t kernelType)
{
    RT_LOG(RT_LOG_DEBUG,
           "launch cpu kernel ex, opName=%s, coreDim=%u, argsSize=%u, hostInputLen=%hu,"
           " flag=%u, kernelType=%u.", opName, coreDim,
           argsInfo->argsSize, argsInfo->hostInputInfoNum, flag, kernelType);
    UNUSED(opName);
    UNUSED(l2ctrl);
    const rtError_t error = AiCpuTaskSupportCheck();
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }

    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Cpu kernel launch ex failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    if (kernelType == KERNEL_TYPE_AICPU_KFC) {
        Device * const dev = curCtx->Device_();
        COND_RETURN_ERROR(dev == nullptr, RT_ERROR_INVALID_VALUE, "device is NULL.");
        const bool isMc2SupportHccl = CheckSupportMC2Feature(dev);
        if (!isMc2SupportHccl) {
            RT_LOG(RT_LOG_WARNING, "Current ts version[%u] does not support aicpu kfc kernel launch.",
                dev->GetTschVersion());
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
    }

    Runtime * const rtInstance = Runtime::Instance();
    COND_RETURN_ERROR_MSG_INNER(rtInstance == nullptr, RT_ERROR_INSTANCE_NULL, "Runtime instance is null");
    ERROR_RETURN_MSG_INNER(rtInstance->StartAicpuSd(curCtx->Device_()),
        "Cpu kernel launch ex with args failed, check and start tsd open aicpu sd error.");

    return curCtx->LaunchCpuKernelExWithArgs(coreDim, argsInfo, curStm, flag, kernelType);
}

rtError_t ApiImpl::MultipleTaskInfoLaunch(const rtMultipleTaskInfo_t * const taskInfo, Stream * const stm,
    const uint32_t flag)
{
    for (size_t idx = 0U; idx < taskInfo->taskNum; idx++) {
        if (taskInfo->taskDesc[idx].type == RT_MULTIPLE_TASK_TYPE_DVPP) {
            RT_LOG(RT_LOG_DEBUG,
                "launch dvpp task, dvppSqeType=%hhu, pos=%hu",
                taskInfo->taskDesc[idx].u.dvppTaskDesc.sqe.sqeHeader.type,
                taskInfo->taskDesc[idx].u.dvppTaskDesc.aicpuTaskPos);
        } else if (taskInfo->taskDesc[idx].type == RT_MULTIPLE_TASK_TYPE_AICPU) {
            RT_LOG(RT_LOG_DEBUG,
                "launch aicpu task, soName=%s, kernel_name=%s, opName=%s, blockDim=%hu, isUnderstudyOp=%hu,"
                " argsSize=%u, hostInputLen=%hu,",
                taskInfo->taskDesc[idx].u.aicpuTaskDesc.kernelLaunchNames.soName,
                taskInfo->taskDesc[idx].u.aicpuTaskDesc.kernelLaunchNames.kernelName,
                taskInfo->taskDesc[idx].u.aicpuTaskDesc.kernelLaunchNames.opName,
                taskInfo->taskDesc[idx].u.aicpuTaskDesc.blockDim,
                taskInfo->taskDesc[idx].u.aicpuTaskDesc.isUnderstudyOp,
                taskInfo->taskDesc[idx].u.aicpuTaskDesc.argsInfo.argsSize,
                taskInfo->taskDesc[idx].u.aicpuTaskDesc.argsInfo.hostInputInfoNum);
        } else {
            Kernel *hdl = RtPtrToPtr<Kernel *>(taskInfo->taskDesc[idx].u.aicpuTaskDescByHandle.funcHdl);
            RT_LOG(RT_LOG_DEBUG,
                "launch aicpu task by handle, soName=%s, funcName=%s, opName=%s, blockDim=%hu, isUnderstudyOp=%hu,"
                " argsSize=%u, hostInputInfoNum=%hu,",
                hdl->GetCpuKernelSo().c_str(), hdl->GetCpuFuncName().c_str(), hdl->GetCpuOpType().c_str(),
                taskInfo->taskDesc[idx].u.aicpuTaskDescByHandle.blockDim,
                taskInfo->taskDesc[idx].u.aicpuTaskDescByHandle.isUnderstudyOp,
                taskInfo->taskDesc[idx].u.aicpuTaskDescByHandle.argsInfo.argsSize,
                taskInfo->taskDesc[idx].u.aicpuTaskDescByHandle.argsInfo.hostInputInfoNum);
        }
    }

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "task info launch failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    return curCtx->LaunchMultipleTaskInfo(taskInfo, curStm, flag);
}

rtError_t ApiImpl::CalcLaunchArgsSize(size_t const argsSize, size_t const hostInfoTotalSize, size_t hostInfoNum,
                                      size_t * const launchArgsSize)
{
    RT_LOG(RT_LOG_DEBUG, "Calc Launch ArgsSize argsSize=%zu, hostInfoTotalSize=%zu, hostInfoNum=%zu",
           argsSize, hostInfoTotalSize, hostInfoNum);
    *launchArgsSize = argsSize + hostInfoTotalSize;
    RT_LOG(RT_LOG_DEBUG, "Cal Launch Args Size success. *launchArgsSize=%zu", *launchArgsSize);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::CreateLaunchArgs(size_t const argsSize, size_t const hostInfoTotalSize, size_t hostInfoNum,
                                    void * const argsData, rtLaunchArgs_t ** const argsHandle)
{
    RT_LOG(RT_LOG_DEBUG, "CreateLaunchArgs, argsSize=%zu, hostInfoTotalSize=%zu, hostInfoNum=%zu, argsData=0x%x",
        argsSize, hostInfoTotalSize, hostInfoNum, argsData);
    auto *hdlHostInputInfo = new (std::nothrow) rtHostInputInfo_t[hostInfoNum];
    if (hdlHostInputInfo == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Alloc hdlHostInputInfo is null hostInfoNum=%u", hostInfoNum);
        return RT_ERROR_CALLOC;
    }
    (void)memset_s(hdlHostInputInfo, sizeof(rtHostInputInfo_t) * hostInfoNum,
                   0xFF, sizeof(rtHostInputInfo_t) * hostInfoNum);
    rtLaunchArgs_t *hdlArgs = new (std::nothrow) rtLaunchArgs_t{{nullptr, nullptr, 0, 0, 0, 0, 0, 1, {0}},
        0, static_cast<uint16_t>(argsSize), static_cast<uint16_t>(hostInfoNum), static_cast<uint16_t>(argsSize)};
    if (hdlArgs == nullptr) {
        delete [] hdlHostInputInfo;
        RT_LOG(RT_LOG_ERROR, "Alloc Launch Args is null");
        return RT_ERROR_CALLOC;
    }
    *argsHandle = hdlArgs;
    rtArgsEx_t *argsInfo = &(hdlArgs->argsInfo);
    argsInfo->args = argsData;
    argsInfo->hostInputInfoPtr = hdlHostInputInfo;
    argsInfo->argsSize = static_cast<uint32_t>(argsSize + hostInfoTotalSize);

    RT_LOG(RT_LOG_DEBUG, "Create Launch Args success, argsAddrOffset=%u, argsDataOffset=%u, argsHostInputOffset=%u, "
        "hostInfoMaxNum=%u, argsInfo->argsSize=%u, argsHandle=0x%x.",
        hdlArgs->argsAddrOffset, hdlArgs->argsDataOffset, hdlArgs->argsHostInputOffset, hdlArgs->hostInfoMaxNum,
        argsInfo->argsSize, hdlArgs);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::DestroyLaunchArgs(rtLaunchArgs_t* argsHandle)
{
    // argsHandle->argsInfo.args : Released by the user
    RT_LOG(RT_LOG_DEBUG, "Destroy Launch Args success. argsHandle=0x%x.", argsHandle);
    if (argsHandle->argsInfo.hostInputInfoPtr != nullptr) {
        delete [] argsHandle->argsInfo.hostInputInfoPtr;
    }
    DELETE_O(argsHandle);

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::ResetLaunchArgs(rtLaunchArgs_t* argsHandle)
{
    RT_LOG(RT_LOG_DEBUG, "ResetLaunchArgs argsHandle=%p", argsHandle);
    rtLaunchArgs_t* hdlArgs = argsHandle;
    if (hdlArgs == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Reset Launch Args is null");
        return RT_ERROR_INVALID_VALUE;
    }
    RT_LOG(RT_LOG_DEBUG, "Reset LaunchArgs hdlArgs=%p.", hdlArgs);

    // hdlArgs->argsDataOffset :  Retain the original value
    // hdlArgs->hostInfoMaxNum :  Retain the original value
    hdlArgs->argsAddrOffset = 0;
    hdlArgs->argsHostInputOffset = hdlArgs->argsDataOffset;

    // argsInfo->argsSize : Retain the original value
    rtArgsEx_t *argsInfo = &(hdlArgs->argsInfo);
    // argsInfo->hostInputInfoPtr : Retain the original value
    argsInfo->tilingAddrOffset = 0;
    argsInfo->tilingDataOffset = 0;
    argsInfo->hostInputInfoNum = 0;
    argsInfo->hasTiling = 0;
    argsInfo->isNoNeedH2DCopy = 1;
    (void)memset_s(argsInfo->args, argsInfo->argsSize, 0, argsInfo->argsSize);
    (void)memset_s(argsInfo->hostInputInfoPtr, (sizeof(rtHostInputInfo_t) * hdlArgs->hostInfoMaxNum),
                   0xFF, (sizeof(rtHostInputInfo_t) * hdlArgs->hostInfoMaxNum));

    RT_LOG(RT_LOG_DEBUG, "argsDataOffset=%u, hostInfoMaxNum=%u, argsSize=%u.",
           hdlArgs->argsDataOffset, hdlArgs->hostInfoMaxNum, argsInfo->argsSize);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::AppendLaunchAddrInfo(rtLaunchArgs_t* const hdl, void * const addrInfo)
{
    RT_LOG(RT_LOG_DEBUG, "Append LaunchArgs hdl=0x%llx, argsAddrOffset=%hu, argsDataOffset=%hu, addrInfo=0x%llx",
           hdl, hdl->argsAddrOffset, hdl->argsDataOffset, addrInfo);
    *(reinterpret_cast<uint64_t *>(reinterpret_cast<char_t *>(hdl->argsInfo.args) + (hdl->argsAddrOffset))) =
    reinterpret_cast<uint64_t>(addrInfo);
    hdl->argsAddrOffset += sizeof(uint64_t);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::AppendLaunchHostInfo(rtLaunchArgs_t* const hdl, size_t const hostInfoSize,
    void ** const hostInfo)
{
    RT_LOG(RT_LOG_DEBUG, "Append LaunchHost Info hdl=%p, argsHostInputOffset=%hu, argsSize=%u, hostInfoSize=%zu",
           hdl, hdl->argsHostInputOffset, hdl->argsInfo.argsSize, hostInfoSize);
    rtLaunchArgs_t *hdlArgs = hdl;

    uint16_t hostInputIdx = hdlArgs->argsInfo.hostInputInfoNum;
    uint16_t HostInfoAddrOffset = hdlArgs->argsAddrOffset;
    hdlArgs->argsInfo.hostInputInfoPtr[hostInputIdx].addrOffset = hdlArgs->argsAddrOffset;
    hdlArgs->argsInfo.hostInputInfoPtr[hostInputIdx].dataOffset = hdlArgs->argsHostInputOffset;
    hdlArgs->argsAddrOffset += sizeof(uint64_t);
    hdlArgs->argsInfo.hostInputInfoNum++;

    char_t *ptrAddr = reinterpret_cast<char_t *>(hdlArgs->argsInfo.args) + hdlArgs->argsHostInputOffset;
    *hostInfo = reinterpret_cast<char_t *>(ptrAddr);

    char_t *HostInfoAddr = reinterpret_cast<char_t *>(hdlArgs->argsInfo.args) + HostInfoAddrOffset;
    uint64_t *ptr = reinterpret_cast<uint64_t *>(HostInfoAddr);
    *ptr = reinterpret_cast<uint64_t>(ptrAddr);

    hdlArgs->argsHostInputOffset += hostInfoSize;
    hdlArgs->argsInfo.isNoNeedH2DCopy = 0;

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::BinaryLoad(const rtDevBinary_t * const bin, Program ** const prog)
{
    RT_LOG(RT_LOG_DEBUG, "BinaryLoad, magic=%#x, binary length=%u.", bin->magic, bin->length);
    Program *programPtr = nullptr;
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    TIMESTAMP_NAME(__func__);
    rtError_t error = Runtime::Instance()->MallocProgramAndReg(bin, &programPtr);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "MallocProgramAndReg failed.");
        return error;
    }

    error = Runtime::Instance()->AllKernelRegister(programPtr, true);
    if (error != RT_ERROR_NONE) {
        delete programPtr;
        RT_LOG(RT_LOG_WARNING, "AllKernelRegister failed, reCode=%#x", error);
        return error;
    }

    Device * const dev = curCtx->Device_();
    error = Runtime::Instance()->BinaryLoad(dev, programPtr);
    if (error != RT_ERROR_NONE) {
        delete programPtr;
        RT_LOG(RT_LOG_WARNING, "BinaryLoad failed, retCode=%#x", error);
        return error;
    }

    *prog = programPtr;
    RT_LOG(RT_LOG_DEBUG, "BinaryLoad device_id=%u, hdl=0x%x.", dev->Id_(), programPtr);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::BinaryGetFunction(const Program * const prog, const uint64_t tilingKey,
                                     Kernel ** const funcHandle)
{
    RT_LOG(RT_LOG_DEBUG, "BinaryGetFunction prog=0x%x, tilingKey=%llu", prog, tilingKey);
    TIMESTAMP_NAME(__func__);
    Kernel *kerneltmp = nullptr;
    *funcHandle = nullptr;
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    const rtError_t error = Runtime::Instance()->BinaryGetFunction(prog, tilingKey, &kerneltmp);
    if (error != RT_ERROR_NONE) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "BinaryGetFunction failed, tilingKey=%" PRIu64 ", retCode=%#x",
            tilingKey, static_cast<uint32_t>(error));
        return RT_ERROR_INVALID_VALUE;
    }

    kerneltmp->SetKernelType_(prog->Machine());

    *funcHandle = kerneltmp;
    RT_LOG(RT_LOG_DEBUG, "prog hdl=0x%x, tilingKey=%llu, funcHandle=0x%x.", prog, tilingKey, kerneltmp);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::BinaryLoadWithoutTilingKey(const void *data, const uint64_t length, Program ** const prog)
{
    RT_LOG(RT_LOG_DEBUG, "BinaryLoadWithoutTilingKey, binary length=%llu.", length);
    Program *programPtr = nullptr;
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    TIMESTAMP_NAME(__func__);
    rtError_t error = Runtime::Instance()->MallocProgramAndRegMixKernel(data, length, &programPtr);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "MallocProgramAndRegMixKernel failed.");
        return error;
    }

    error = Runtime::Instance()->MixKernelRegister(programPtr);
    if (error != RT_ERROR_NONE) {
        delete programPtr;
        RT_LOG(RT_LOG_WARNING, "MixKernelRegister failed, retCode=%#x", error);
        return error;
    }

    Device * const dev = curCtx->Device_();
    error = Runtime::Instance()->BinaryLoad(dev, programPtr);
    if (error != RT_ERROR_NONE) {
        delete programPtr;
        RT_LOG(RT_LOG_WARNING, "BinaryLoad failed, retCode=%#x", error);
        return error;
    }

    *prog = programPtr;
    RT_LOG(RT_LOG_DEBUG, "BinaryLoad deviceId=%u, hdl=0x%x.", dev->Id_(), programPtr);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::BinaryGetFunctionByName(const Program * const binHandle, const char_t *kernelName,
                                           Kernel ** const funcHandle)
{
    RT_LOG(RT_LOG_DEBUG, "BinaryGetFunction prog=%p,kernel_name=%s,kernelRegType=%d",
        binHandle, kernelName, binHandle->GetKernelRegType());
    TIMESTAMP_NAME(__func__);
    Kernel *kerneltmp = nullptr;
    *funcHandle = nullptr;
    const rtError_t error = Runtime::Instance()->BinaryGetFunctionByName(binHandle, kernelName, &kerneltmp);
    if (error != RT_ERROR_NONE) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "BinaryGetFunction failed, kernel_name=%s, retCode=%#x",
            kernelName, static_cast<uint32_t>(error));
        return RT_ERROR_INVALID_VALUE;
    }

    *funcHandle = kerneltmp;
    RT_LOG(RT_LOG_DEBUG, "prog hdl=%p, kernel_name=%s, funcHandle=%p.", binHandle, kernelName, kerneltmp);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::BinaryGetFunctionByEntry(const Program * const binHandle, const uint64_t funcEntry,
                                            Kernel ** const funcHandle)
{
    *funcHandle = nullptr;
    const Program * const prog = binHandle;
    Program * const progTmp = const_cast<Program *>(prog);
    const Kernel * const kernelTmp = progTmp->GetKernelByTillingKey(funcEntry);
    if (kernelTmp == nullptr) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "BinaryGetFunctionByEntry failed, funcEntry=%" PRIu64, funcEntry);
        return RT_ERROR_INVALID_VALUE;
    }

    *funcHandle = const_cast<Kernel *>(kernelTmp);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::BinaryGetMetaInfo(Program * const binHandle, const rtBinaryMetaType type,
                                     void *data, const uint32_t length)
{
    Program * const prog = binHandle;
    const rtError_t error = prog->BinaryGetMetaInfo(type, data, length);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "BinaryGetMetaInfo failed, type=%u", type);
        return error;
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::FunctionGetMetaInfo(const Kernel * const funcHandle, const rtFunctionMetaType type,
                                       void *data, const uint32_t length)
{
    Program * const prog = funcHandle->Program_();
    const std::string kernelName = funcHandle->Name_();
    const rtError_t error = prog->FunctionGetMetaInfo(kernelName, type, data, length);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "FunctionGetMetaInfo failed, kernel name = %s, type=%u", kernelName.c_str(), type);
        return error;
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::RegisterCpuFunc(rtBinHandle binHandle, const char_t *const funcName,
    const char_t *const kernelName, rtFuncHandle *funcHandle)
{
    RT_LOG(RT_LOG_DEBUG, "RegisterCpuFunc, funcName=%s, kernelName=%s.", funcName, kernelName);
    *funcHandle = nullptr;
    Program * const prog = RtPtrToPtr<Program *>(binHandle);
    const KernelRegisterType kernelRegType = prog->GetKernelRegType();
    COND_RETURN_OUT_ERROR_MSG_CALL(kernelRegType != RT_KERNEL_REG_TYPE_CPU, RT_ERROR_INVALID_VALUE,
        "only support cpu program, binHandle is invalid, kernelRegType=%d.", kernelRegType);
    Kernel *kernel = nullptr;
    // 注册cpu kernel
    const rtError_t error = prog->RegisterSingleCpuKernel(funcName, kernelName, &kernel);
    ERROR_RETURN_MSG_INNER(error, "register single cpu kernel failed, retCode=%#x", static_cast<uint32_t>(error));

    *funcHandle = kernel;

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::BinaryUnLoad(Program * const binHandle)
{
    RT_LOG(RT_LOG_DEBUG, "BinaryUnLoad prog=0x%x", binHandle);
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    RT_LOG(RT_LOG_DEBUG, "BinaryUnLoad  deviceId=%u, prog=0x%x.", dev->Id_(), binHandle);
    const rtError_t error = Runtime::Instance()->BinaryUnLoad(dev, binHandle);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "register program failed, reCode=%#x", error);
        return error;
    }

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::BinaryLoadFromFile(const char_t * const binPath, const rtLoadBinaryConfig_t * const optionalCfg,
                                      Program **handle)
{
    RT_LOG(RT_LOG_DEBUG, "binary load from file, path=[%s]", binPath);
    BinaryLoader binaryLdr(binPath, optionalCfg);
    const rtError_t ret = binaryLdr.Load(handle);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "binary load from file failed, path=[%s]", binPath);
    }
    return ret;
}

rtError_t ApiImpl::BinaryLoadFromData(const void * const data, const uint64_t length,
                                      const rtLoadBinaryConfig_t * const optionalCfg, Program **handle)
{
    BinaryLoader binaryLdr(data, length, optionalCfg);
    const rtError_t ret = binaryLdr.Load(handle);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "binary load from data failed");
    }
    return ret;
}

// check if kernel is for vector core
static bool CheckVectorKernel(const Kernel * const kernel)
{
    const uint32_t machine = kernel->Program_()->Machine();
    // 1. common aiv kernel
    if ((machine == Program::MACH_AI_VECTOR) ||
        ((machine == Program::MACH_AI_MIX_KERNEL) && (kernel->KernelType_() == Program::MACH_AI_VECTOR))) {
        return true;
    }
    // 2. mix aiv only kernel
    if (kernel->GetMixType() == MIX_AIV) {
        return true;
    }
    return false;
}

rtError_t ApiImpl::FuncGetAddr(const Kernel * const funcHandle, void ** const aicAddr, void ** const aivAddr)
{
    uint64_t funcAddr1 = 0ULL;
    uint64_t funcAddr2 = 0ULL;
    const rtError_t error = funcHandle->GetFunctionDevAddr(funcAddr1, funcAddr2);
    if (error != RT_ERROR_NONE) {
        *aicAddr = nullptr;
        *aivAddr = nullptr;
        return error;
    }

    if ((funcAddr1 != 0ULL) && (funcAddr2 == 0ULL) && (CheckVectorKernel(funcHandle))) {
        // there is only one address, and the kernel is for vector core
        *aivAddr = reinterpret_cast<void *>(static_cast<uintptr_t>(funcAddr1));
        *aicAddr = reinterpret_cast<void *>(static_cast<uintptr_t>(funcAddr2));
    } else {
        *aicAddr = reinterpret_cast<void *>(static_cast<uintptr_t>(funcAddr1));
        *aivAddr = reinterpret_cast<void *>(static_cast<uintptr_t>(funcAddr2));
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::LaunchNonKernelByHandle(Kernel * const kernel, uint32_t blockDim, const RtArgsHandle * const argHandle,
    Stream * const curStm, const TaskCfg &taskCfg)
{
    COND_RETURN_ERROR(argHandle == nullptr, RT_ERROR_INVALID_VALUE, "args handle is nullptr");

    rtError_t error = RT_ERROR_NONE;
    const KernelRegisterType regType = kernel->GetKernelRegisterType();
    const uint8_t phNum = argHandle->placeHolderNum;
    // Cpu kernel
    if (regType == RT_KERNEL_REG_TYPE_CPU) {
        rtCpuKernelArgs_t cpuKernelArgs = {};
        // 由于tv是可选配置，可以通过有没有timeout可选配置来弱化RT_KERNEL_USE_SPECIAL_TIMEOUT的kernel flag
        // 对外不提供kernel flag, 如果taskCfg.extend.timeout为全F时，代表永不超时
        uint32_t flag = RT_KERNEL_DEFAULT;
        if (taskCfg.isBaseValid == 1U) {
            flag |= taskCfg.base.dumpflag;
        }

        if (phNum <= SPECIAL_ARGS_MAX_CNT) {
            rtHostInputInfo_t hostArgsInfos[SPECIAL_ARGS_MAX_CNT];
            error = ConvertCpuArgsByArgsHandle(cpuKernelArgs, argHandle, hostArgsInfos, SPECIAL_ARGS_MAX_CNT);
            ERROR_RETURN_MSG_INNER(error, "convert args failed,error=%#x", error);
            return CpuKernelLaunchEx(kernel, blockDim, &cpuKernelArgs, taskCfg, curStm, flag);
        }
        rtHostInputInfo_t *hostArgsInfos = new (std::nothrow) rtHostInputInfo_t[phNum];
        COND_RETURN_ERROR(hostArgsInfos == nullptr, RT_ERROR_MEMORY_ALLOCATION,
            "new specialArgsInfos failed,phNum=%u", phNum);
        error = ConvertCpuArgsByArgsHandle(cpuKernelArgs, argHandle, hostArgsInfos, phNum);
        COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, DELETE_A(hostArgsInfos), "covert args failed.");
        error = CpuKernelLaunchEx(kernel, blockDim, &cpuKernelArgs, taskCfg, curStm, flag);
        DELETE_A(hostArgsInfos);
        ERROR_RETURN_MSG_INNER(error, "launch kernel failed. error=%#x", error);

        return RT_ERROR_NONE;
    }

    // Non Cpu Kernel
    rtArgsEx_t argsInfo = {};
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const uint8_t mixType = kernel->GetMixType();
    const bool isVecLaunch =
        curCtx->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_EXTRA_VECTOR_CORE) &&
        (mixType != NO_MIX) && ((taskCfg.isExtendValid == 1U) && (taskCfg.extend.engineType == RT_ENGINE_TYPE_AIV));
    if (phNum <= SPECIAL_ARGS_MAX_CNT) {
        rtHostInputInfo_t specialArgsInfos[SPECIAL_ARGS_MAX_CNT];
        error = ConvertArgsByArgsHandle(argsInfo, argHandle, specialArgsInfos, SPECIAL_ARGS_MAX_CNT);
        ERROR_RETURN_MSG_INNER(error, "convert args failed, error=%#x", error);
        return curStm->Context_()->LaunchKernel(kernel, blockDim, &argsInfo, curStm, &taskCfg, isVecLaunch);
    }

    rtHostInputInfo_t *hostArgsInfos = new (std::nothrow) rtHostInputInfo_t[phNum];
    COND_RETURN_ERROR(
        hostArgsInfos == nullptr, RT_ERROR_MEMORY_ALLOCATION, "new specialArgsInfos failed,phNum=%u", phNum);
    error = ConvertArgsByArgsHandle(argsInfo, argHandle, hostArgsInfos, phNum);
    COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, DELETE_A(hostArgsInfos), "covert args failed.");
    error = curStm->Context_()->LaunchKernel(kernel, blockDim, &argsInfo, curStm, &taskCfg, isVecLaunch);
    DELETE_A(hostArgsInfos);
    ERROR_RETURN_MSG_INNER(error, "launch kernel failed, error=%#x", error);

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::LaunchKernelV2(Kernel * const kernel, uint32_t blockDim, const RtArgsWithType * const argsWithType,
                                  Stream * const stm, const rtKernelLaunchCfg_t * const cfg)
{
    RT_LOG(RT_LOG_DEBUG, "launch kernel V2, blockDim=%u, argsType=%u, cfgAttrNum=%zu.",
        blockDim, static_cast<uint32_t>(argsWithType->type), ((cfg != nullptr) ? cfg->numAttrs : 0UL));
    TaskCfg taskCfg = {};
    rtError_t error = ConvertLaunchCfgToTaskCfg(taskCfg, cfg);
    ERROR_RETURN(error, "convert task cfg failed, retCode=%#x.", error);

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = (stm == nullptr) ? curCtx->DefaultStream_() : stm;
    NULL_STREAM_PTR_RETURN_MSG(curStm);

    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Kernel launch with handle failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());
    // For the new launch logic, the nop task delivery is hidden in the launchKernel. only for aic/aiv kernel
    if ((kernel->GetKernelRegisterType() == RT_KERNEL_REG_TYPE_NON_CPU) && (taskCfg.isExtendValid == 1U) && (taskCfg.extend.blockTaskPrefetch)) {
        DevProperties props;
        error = GET_DEV_PROPERTIES(Runtime::Instance()->GetChipType(), props);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE,
            "Failed to get properties, stream_id=%d.", curStm->Id_());

        const uint8_t prefetchCnt = props.taskPrefetchCount;
        for (uint8_t cntIdx = 0U; cntIdx < prefetchCnt; cntIdx++) {
            error = curCtx->NopTask(curStm);
            ERROR_RETURN_MSG_INNER(error, "launch nop task error, error=%#x.", error);
        }
    }

    switch (argsWithType->type) {
        case RT_ARGS_NON_CPU_EX: {
            const bool isVecLaunch = (taskCfg.isExtendValid == 1U) && (taskCfg.extend.engineType == RT_ENGINE_TYPE_AIV);
            error = curCtx->LaunchKernel(kernel, blockDim, argsWithType->args.nonCpuArgsInfo, curStm, &taskCfg, isVecLaunch);
            break;
        }
        case RT_ARGS_CPU_EX: {
            // 由于tv是可选配置，可以通过有没有timeout可选配置来弱化RT_KERNEL_USE_SPECIAL_TIMEOUT的kernel flag
            // 对外不提供kernel flag, 如果taskCfg.extend.timeout为全F时，代表永不超时
            uint32_t flag = RT_KERNEL_DEFAULT;
            if (taskCfg.isBaseValid == 1U) {
                flag |= taskCfg.base.dumpflag;
            }
            
            error = CpuKernelLaunchEx(kernel, blockDim, argsWithType->args.cpuArgsInfo, taskCfg, curStm, flag);
            break;
        }
        case RT_ARGS_HANDLE: {
            error = LaunchNonKernelByHandle(kernel, blockDim, argsWithType->args.argHandle, curStm, taskCfg);
            break;
        }
        default:
            error = RT_ERROR_INVALID_VALUE;
            RT_LOG_OUTER_MSG_INVALID_PARAM(argsWithType->type,
                "[" + std::to_string(RT_ARGS_NON_CPU_EX) + ", " + std::to_string(RT_ARGS_MAX) + ")");
            break;
    }

    return error;
}

rtError_t ApiImpl::LaunchKernel(Kernel * const kernel, uint32_t blockDim, const rtArgsEx_t * const argsInfo,
    Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo)
{
    RT_LOG(RT_LOG_DEBUG, "LaunchKernel blockDim=%u", blockDim);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Kernel launch with handle failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    TaskCfg taskCfg = {};
    if (cfgInfo != nullptr) {
        taskCfg.isBaseValid = 1U;
        taskCfg.base = *cfgInfo;
    }
    return curCtx->LaunchKernel(kernel, blockDim, argsInfo, curStm, &taskCfg);
}

rtError_t ApiImpl::LaunchKernelV3(Kernel * const kernel, const rtArgsEx_t * const argsInfo,
    Stream * const stm, const rtLaunchConfig_t * const launchConfig)
{
    UNUSED(kernel);
    UNUSED(argsInfo);
    UNUSED(stm);
    UNUSED(launchConfig);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::DatadumpInfoLoad(const void * const dumpInfo, const uint32_t length, const uint32_t flag)
{
    RT_LOG(RT_LOG_DEBUG, "length=%u, flag=%u.", length, flag);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Runtime * const rtInstance = Runtime::Instance();
    COND_RETURN_ERROR_MSG_INNER(rtInstance == nullptr, RT_ERROR_INSTANCE_NULL, "Runtime instance is null.");
    ERROR_RETURN_MSG_INNER(rtInstance->StartAicpuSd(curCtx->Device_()),
        "Data dump info load failed, check and start tsd open aicpu sd error.");

    return curCtx->DatadumpInfoLoad(dumpInfo, length, flag);
}

rtError_t ApiImpl::AicpuInfoLoad(const void * const aicpuInfo, const uint32_t length)
{
    RT_LOG(RT_LOG_DEBUG, "length=%u.", length);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Runtime * const rtInstance = Runtime::Instance();
    COND_RETURN_ERROR_MSG_INNER(rtInstance == nullptr, RT_ERROR_INSTANCE_NULL, "Runtime instance is null.");
    ERROR_RETURN_MSG_INNER(rtInstance->StartAicpuSd(curCtx->Device_()),
        "aicpu info load failed, check and start tsd open aicpu sd error.");

    return curCtx->AicpuInfoLoad(aicpuInfo, length);
}

rtError_t ApiImpl::SetupArgument(const void * const setupArg, const uint32_t size, const uint32_t offset)
{
    RT_LOG(RT_LOG_DEBUG, "size=%u, offset=%u.", size, offset);
    constexpr uint32_t argCountLimit = (ARG_ENTRY_SIZE / MIN_ARG_SIZE);
    LaunchArgment &launchArg = ThreadLocalContainer::GetLaunchArg();
    if ((offset >= sizeof(launchArg.args)) || ((sizeof(launchArg.args) - offset) < size) ||
        (launchArg.argCount >= argCountLimit)) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,
            "Invalid current offset=%u, size=%u(bytes), and argCount=%u."
            "The valid offset range is (0, %zu), and the valid argCount range is (0, %u).",
            offset, size, launchArg.argCount,
            sizeof(launchArg.args), (ARG_ENTRY_SIZE / MIN_ARG_SIZE));
        return RT_ERROR_INVALID_VALUE;
    }

    char_t * const launchArgs = launchArg.args;
    const errno_t ret = memcpy_s(launchArgs + offset, sizeof(launchArg.args) - offset,
        setupArg, static_cast<size_t>(size));
    COND_RETURN_ERROR_MSG_INNER(ret != EOK, RT_ERROR_SEC_HANDLE,
        "Memcpy args %u failed, offset=%u, dstSize=%zu(bytes), srcSize=%u(bytes), retCode=%#x",
        launchArg.argCount, offset, sizeof(launchArg.args) - offset, size, static_cast<uint32_t>(ret));

    const uint32_t totalSize = size + offset;
    // allow out of order call SetupArgument
    if (totalSize > launchArg.argSize) {
        launchArg.argSize = totalSize;
    }
    launchArg.argsOffset[launchArg.argCount] = static_cast<uint16_t>(offset);
    launchArg.argCount++;

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::StreamCreate(Stream ** const stm, const int32_t priority, const uint32_t flags, DvppGrp *grp)
{
    RT_LOG(RT_LOG_INFO, "priority=%d, flags=%u.", priority, flags);
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    if ((flags & RT_STREAM_AICPU) != 0U) {
        // need aicpu sd in aicpu stream
        Runtime * const rtInstance = Runtime::Instance();
        COND_RETURN_ERROR_MSG_INNER(rtInstance == nullptr, RT_ERROR_INSTANCE_NULL, "Runtime instance is null");
        ERROR_RETURN_MSG_INNER(rtInstance->StartAicpuSd(curCtx->Device_()),
            "StreamActive failed, check and start tsd open aicpu sd error.");
    }

    Device *const dev = curCtx->Device_();
    COND_RETURN_ERROR(dev == nullptr, RT_ERROR_INVALID_VALUE, "device is NULL.");
    const uint64_t failMode = dev->GetDevFailureMode();
    RT_LOG(RT_LOG_DEBUG, "device failMode is %llu.", failMode);
    if (failMode != CONTINUE_ON_FAILURE && (flags & RT_STREAM_CP_PROCESS_USE) != 0U) {
        RT_LOG(RT_LOG_EVENT,
            "Not support set failure mode for coprocessor stream, flags=%u, failMode=%llu.", flags, failMode);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    rtError_t error = curCtx->StreamCreate(static_cast<uint32_t>(priority), flags, stm, grp);

    COND_RETURN_WARN(error == RT_ERROR_FEATURE_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
                     "Create stream failed, not support flags=%u", flags);
    ERROR_RETURN(error, "Create stream failed, priority=%d, flags=%u.", priority, flags);

    if (failMode != CONTINUE_ON_FAILURE) {
        error = (*stm)->SetFailMode(failMode);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR,
                "Failed to set stream failure mode, failMode = %llu, stream_id=%d, device_id=%u, error=%d",
                failMode, (*stm)->Id_(), dev->Id_(), error);
            // 因为返回error日志，所以需要释放掉已经创建好的stream
            (void)StreamDestroy(*stm, false);
            return error;
        }
    }

    RT_LOG(RT_LOG_INFO, "Succ, flags=%u, stream_id=%d, context=%llx", flags, (*stm)->Id_(),
        reinterpret_cast<uint64_t *>((*stm)->Context_()));
    return error;
}

rtError_t ApiImpl::KernelTransArgSet(const void * const ptr, const uint64_t size, const uint32_t flag,
    void ** const setupArg)
{
    TIMESTAMP_NAME(__func__);
    UNUSED(flag);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const auto dev = curCtx->Device_();
    Driver * const curDrv = dev->Driver_();
    (*setupArg) = const_cast<void *>(ptr);
    if ((dev->GetType_() == Device::STUB_DEVICE) ||
        (curDrv->GetRunMode() == static_cast<uint32_t>(RT_RUN_MODE_ONLINE))) {
        // stub device and online does not support
        return RT_ERROR_NONE;
    }

    const rtError_t error = curDrv->DevMemFlushCache(reinterpret_cast<uintptr_t>(ptr), size);
    if (error != RT_ERROR_NONE) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "flush cache failed, size=%" PRIu64 "(bytes), retCode=%#x", size, static_cast<uint32_t>(error));
        return error;
    }

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::KernelFusionStart(Stream * const stm)
{
    RT_LOG(RT_LOG_DEBUG, "kernel fusion start.");
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Kernel fusion start failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    return curStm->KernelFusionStart();
}

rtError_t ApiImpl::KernelFusionEnd(Stream * const stm)
{
    RT_LOG(RT_LOG_DEBUG, "kernel fusion end.");
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Kernel fusion end failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    return curStm->KernelFusionEnd();
}

rtError_t ApiImpl::StreamDestroy(Stream * const stm, bool flag)
{
    RT_LOG(RT_LOG_INFO, "stream_id=%d.", stm->Id_());
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Stream destroy failed, stream is not in current ctx, stream_id=%d.", stm->Id_());
    const rtError_t error = curCtx->StreamDestroy(stm, flag);
    ERROR_RETURN(error, "Destroy stream failed.");
    return error;
}

rtError_t ApiImpl::GetCaptureEvent(const Stream * const stm, Event * const evt, Event ** const captureEvt,
    const bool isNewEvt)
{
    std::lock_guard<std::mutex> lock(evt->GetCaptureMutex());
    Event *curEvent = evt->GetCaptureEvent();
    if ((!isNewEvt) && (curEvent != nullptr)) {
        RT_LOG(RT_LOG_INFO, "Capture event has been created, event_id=[%d->%d].",
            evt->EventId_(), curEvent->EventId_());
        *captureEvt = curEvent;
        return RT_ERROR_NONE;
    }
    rtError_t error = RT_ERROR_NONE;
    const int32_t eventId = (curEvent != nullptr) ? curEvent->EventId_() : INVALID_EVENT_ID;
    Stream *captureStm = stm->GetCaptureStream();
    COND_RETURN_ERROR_MSG_INNER((captureStm == nullptr), RT_ERROR_STREAM_NULL,
        "Capture stream is invalid, stream_id=%d, event_id=[%d->%d].",
        stm->Id_(), evt->EventId_(), eventId);
    
    Model* mdl = captureStm->Model_();
    COND_RETURN_ERROR_MSG_INNER((mdl == nullptr), RT_ERROR_MODEL_NULL,
        "Capture model is invalid, stream_id=[%d->%d], event_id=[%d->%d].",
        stm->Id_(), captureStm->Id_(), evt->EventId_(), eventId);

    Event *newEvent = nullptr;
    if (GlobalContainer::IsEventHardMode()) {
        error = EventCreate(&newEvent, RT_EVENT_WITH_FLAG);
    } else {
        error = EventCreateEx(&newEvent, RT_EVENT_WITH_FLAG);
    }

    COND_RETURN_ERROR_MSG_INNER((error != RT_ERROR_NONE || newEvent == nullptr), error,
        "Create capture event failed, stream_id=[%d->%d], event_id=[%d->%d], error=%d.",
        stm->Id_(), captureStm->Id_(), evt->EventId_(), eventId, error);

    evt->SetCaptureEvent(newEvent);
    CaptureModel *captureMdl = dynamic_cast<CaptureModel *>(mdl);
    captureMdl->InsertSingleOperEvent(evt);
    newEvent->SetCaptureStream(captureStm);
    captureMdl->InsertCaptureEvent(newEvent);

    RT_LOG(RT_LOG_INFO, "Capture event_id=[%d->%d], model_id=%u, isNewEvt=%d, stream_id=[%d->%d].",
        ((curEvent != nullptr) ? eventId : evt->EventId_()), newEvent->EventId_(),
        captureMdl->Id_(), isNewEvt, stm->Id_(), captureStm->Id_());
    *captureEvt = newEvent;
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::CaptureEventWait(Context * const ctx, Stream * const stm, Event * const evt,
    const uint32_t timeout)
{
    if (IsCaptureEventWaitNonOp(stm, evt)) {
        return RT_ERROR_NONE;
    }

    Stream *captureStm = nullptr;
    rtError_t error = GetCaptureStream(ctx, stm, evt, &captureStm);
    ERROR_RETURN_MSG_INNER(error, "Create capture stream failed, stream_id=%d, event_id=%d, error=%d.",
        stm->Id_(), evt->EventId_(), error);
    Event *captureEvt = nullptr;
    error = GetCaptureEvent(stm, evt, &captureEvt);
    ERROR_RETURN_MSG_INNER(error, "Create capture event failed, stream_id=%d, event_id=%d, error=%d.",
        stm->Id_(), evt->EventId_(), error);
    COND_RETURN_ERROR_MSG_INNER(IsCrossCaptureModel(captureEvt, captureStm),
        RT_ERROR_STREAM_CAPTURE_CONFLICT, "Capture event and capture stream is cross-model.");

    error = stm->WaitEvent(captureEvt, timeout);
    ERROR_RETURN_MSG_INNER(error, "Capture stream wait event failed, stream_id=[%d->%d], error=%d.",
        stm->Id_(), captureStm->Id_(), error);
    captureEvt->InsertWaitTaskStream(captureStm);
    RT_LOG(RT_LOG_DEBUG, "stream_id=[%d->%d], event_id=[%d->%d].",
        stm->Id_(), captureStm->Id_(), evt->EventId_(), captureEvt->EventId_());
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::StreamWaitEvent(Stream * const stm, Event * const evt, const uint32_t timeout)
{
    RT_LOG(RT_LOG_DEBUG, "Stream wait event, timeout=%us.", timeout);
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    const bool supFlag = ((evt->IsNewMode()) || ((!evt->IsNotify()) && (evt->GetEventFlag() == RT_EVENT_DEFAULT))) &&
            (curStm->GetModelNum() != 0);
    COND_RETURN_WARN(supFlag, RT_ERROR_FEATURE_NOT_SUPPORT,
        "Not support current mode bind stream, mode=%d, flag=%" PRIu64 ", isNotify=%d, isModel=%d.",
        evt->IsNewMode(), evt->GetEventFlag(), evt->IsNotify(), (curStm->GetModelNum() != 0U));
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Stream wait event failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    if (evt->IsCapturing()) {
        COND_RETURN_ERROR_MSG_INNER(!StreamFlagIsSupportCapture(curStm->Flags()), RT_ERROR_STREAM_INVALID,
        "stream flag does not support capture to model, flag=%u.", curStm->Flags());
        COND_RETURN_ERROR_MSG_INNER(curStm == curCtx->DefaultStream_(),
            RT_ERROR_STREAM_CAPTURE_IMPLICIT,
            "A disallowed implicit dependency from default stream.");
        COND_RETURN_ERROR_MSG_INNER(evt->IsEventWithoutWaitTask(),
            RT_ERROR_INVALID_VALUE,
            "The event flag %" PRIu64 " is not supported in capture mode.", evt->GetEventFlag());
        const std::lock_guard<std::mutex> lk(curCtx->GetCaptureLock());
        if (evt->IsCapturing()) {
            const rtError_t retCode = CaptureEventWait(curCtx, curStm, evt, timeout);
            ERROR_PROC_RETURN_MSG_INNER(retCode, TerminateCapture(evt, curStm), "Capture wait event failed.");
            return RT_ERROR_NONE;
        }
    } else {
        if (curStm->IsCapturing()) { 
            if ((!(evt->IsNewMode())) && (evt->GetEventFlag() != RT_EVENT_EXTERNAL)) { 
                RT_LOG(RT_LOG_WARNING,  "Event created via the API rtEventCreate and rtEventCreateWithFlag are not"
                " supported, except for the RT_EVENT_EXTERNAL type, mode=%d, flag=%" PRIu64 "", evt->IsNewMode(),
                 evt->GetEventFlag());
                return RT_ERROR_FEATURE_NOT_SUPPORT;
            }
            if ((evt->IsNewMode()) && (evt->HasRecord())) { 
                // 1.Not capture event
                // 2.Be a capture stream
                // 3.Event was created using the rtCreateEventExWithFlag interface
                // 4. A record was added the single-operator stream
                RT_LOG(RT_LOG_ERROR,  "The record corresponding to the event not be captured, mode=%d", evt->IsNewMode());
                return RT_ERROR_STREAM_CAPTURE_ISOLATION;
            }
        }
    }
    rtError_t error = RT_ERROR_NONE;
    if (evt->GetEventFlag() == RT_EVENT_IPC) {
        error = (dynamic_cast<IpcEvent *>(evt))->IpcEventWait(curStm);
    } else {
        error = curStm->WaitEvent(evt, timeout);
    }
    ERROR_RETURN(error, "Stream wait event failed.");
    return error;
}

rtError_t ApiImpl::StreamSynchronize(Stream * const stm, const int32_t timeout)
{
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    } else if (stm->Id_() == MAX_INT32_NUM) {
        Stream * const onlineStream = curCtx->OnlineStream_();
        Stream * const defaultStream = curCtx->DefaultStream_();
        if (onlineStream != nullptr) {
            curStm = onlineStream;
        } else {
            curStm = defaultStream;
        }
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    // when user implicitly switches the current context through our api,
    // we need to implicitly switch to the correct context through the current in stream,
    // and switch back after current function is complete.
    rtError_t error = RT_ERROR_NONE;
    bool ctxSwitch = false;
    if (curCtx != curStm->Context_()) {
        RT_LOG(RT_LOG_INFO, "Ctx switch, stream_id=%d, old ctx=%#" PRIx64 ", new ctx=%#" PRIx64,
            curStm->Id_(), static_cast<uint64_t>(reinterpret_cast<uintptr_t>(curCtx)),
            static_cast<uint64_t>(reinterpret_cast<uintptr_t>(curStm->Context_())));
        error = ContextSetCurrent(curStm->Context_());
        ERROR_RETURN(error, "Failed to set current context, retCode=%#x", error);
        ctxSwitch = true;
    }
    RT_LOG(RT_LOG_INFO, "stream_id=%d.", curStm->Id_());
    rtError_t errCode = curStm->CheckContextStatus();
    ERROR_RETURN(errCode, "context is abort, status=%#x.", static_cast<uint32_t>(errCode));
    errCode = curStm->Synchronize(false, timeout);
    if (errCode == RT_ERROR_STREAM_SYNC_TIMEOUT) {
        (void)GetStreamTimeoutSnapshotMsg();
    } else {
        if ((curStm->Device_()->GetIsRingbufferGetErr()) && (curCtx->GetFailureError() == RT_ERROR_NONE) &&
            (curCtx->GetCtxMode() != CONTINUE_ON_FAILURE)) {
            errCode = curCtx->SyncAllStreamToGetError();
        }
    }
    
    if (ctxSwitch) {
        error = ContextSetCurrent(curCtx);
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "Failed to set current context, retCode=%#x", error);
        RT_LOG(RT_LOG_INFO, "Ctx switch back, stream_id=%d, current ctx=%#" PRIx64,
            curStm->Id_(), static_cast<uint64_t>(reinterpret_cast<uintptr_t>(CurrentContext())));
    }
    return errCode;
}

rtError_t ApiImpl::StreamQuery(Stream * const stm)
{
    RT_LOG(RT_LOG_DEBUG, "Query stream.");
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    rtError_t error = curStm->CheckContextStatus();
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "context is abort, status=%#x.", static_cast<uint32_t>(error));
    error = curStm->Query();
    COND_RETURN_ERROR((error != RT_ERROR_NONE) && (error != RT_ERROR_STREAM_NOT_COMPLETE), error,
        "Query stream failed.");
    return error;
}

rtError_t ApiImpl::GetStreamId(Stream * const stm, int32_t * const streamId)
{
    TIMESTAMP_NAME(__func__);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        Context * const curCtx = CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }

    *streamId = curStm->Id_();
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetSqId(Stream * const stm, uint32_t * const sqId)
{
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    *sqId = stm->GetSqId();
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetCqId(Stream * const stm, uint32_t * const cqId, uint32_t * const logicCqId)
{
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    *cqId = stm->GetCqId();
    *logicCqId = stm->GetLogicalCqId();
    return RT_ERROR_NONE;
}


rtError_t ApiImpl::StreamGetPriority(Stream * const stm, uint32_t * const priority)
{
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }

    *priority = curStm->GetPriority();
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::StreamGetFlags(Stream * const stm, uint32_t * const flags)
{
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }

    *flags = curStm->Flags();
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetMaxStreamAndTask(const uint32_t streamType, uint32_t * const maxStrCount,
    uint32_t * const maxTaskCount)
{
    TIMESTAMP_NAME(__func__);
    const Runtime * const rt = Runtime::Instance();
    if (!rt->HaveDevice() && !rt->GetIsUserSetSocVersion()) {
        RT_LOG(RT_LOG_WARNING, "No device exists, Resources cannot be queried without set soc version.");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    if (streamType == RT_HUGE_STREAM) {
        DevProperties props;
        GET_DEV_PROPERTIES(rt->GetChipType(), props);
        if (props.maxAllocHugeStreamNum == 0U) {
            RT_LOG(RT_LOG_WARNING, "Get max stream and task failed, unsupported huge stream mode in chipType=%d, "
                                   "streamType=%u", rt->GetChipType(), streamType);
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
        *maxStrCount = props.maxAllocHugeStreamNum;
        *maxTaskCount = Runtime::macroValue_.maxTaskNumPerHugeStream;
        return RT_ERROR_NONE;
    }
    *maxStrCount = Runtime::macroValue_.maxAllocStreamNum;
    *maxTaskCount = Runtime::macroValue_.maxTaskNumPerStream;
    RT_LOG(RT_LOG_INFO, "Max streamNum=%u, max TaskNum=%u", *maxStrCount, *maxTaskCount);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetAvailStreamNum(const uint32_t streamType, uint32_t * const streamCount)
{
    RT_LOG(RT_LOG_DEBUG, "streamType=%u.", streamType);
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const uint32_t deviceId = curCtx->Device_()->Id_();
    const uint32_t tsId = curCtx->Device_()->DevGetTsId();
    if (streamType == RT_HUGE_STREAM) {
        const Runtime * const rt = Runtime::Instance();
        DevProperties props;
        GET_DEV_PROPERTIES(rt->GetChipType(), props);
        COND_RETURN_ERROR_MSG_INNER(props.maxAllocHugeStreamNum == 0U,
            RT_ERROR_FEATURE_NOT_SUPPORT,
            "Get max stream and task failed, unsupported huge stream mode in chipType=%d, streamType=%u",
            rt->GetChipType(), streamType);
        *streamCount = props.maxAllocHugeStreamNum;
        return RT_ERROR_NONE;
    }
    *streamCount = Runtime::macroValue_.maxAllocStreamNum;
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_DEVICE_GET_RESOURCE_NUM_DYNAMIC)) {
        return NpuDriver::GetAvailStreamNum(deviceId, tsId, streamCount);
    }
    RT_LOG(RT_LOG_INFO, "get avail stream num is gen");
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetFreeStreamNum(uint32_t * const streamCount)
{
    RT_LOG(RT_LOG_DEBUG, "Query free stream num");
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const uint32_t deviceId = curCtx->Device_()->Id_();
    const uint32_t tsId = curCtx->Device_()->DevGetTsId();
    return NpuDriver::GetAvailStreamNum(deviceId, tsId, streamCount);
}

rtError_t ApiImpl::GetAvailEventNum(uint32_t * const eventCount)
{
    RT_LOG(RT_LOG_DEBUG, "Query event num");
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const uint32_t deviceId = curCtx->Device_()->Id_();
    const uint32_t tsId = curCtx->Device_()->DevGetTsId();
    *eventCount = Runtime::macroValue_.stubEventCount;
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_DEVICE_GET_RESOURCE_NUM_DYNAMIC)) {
        Driver* driver = curCtx->Device_()->Driver_();
        NULL_PTR_RETURN_MSG_OUTER(driver, RT_ERROR_INVALID_VALUE);
        return driver->GetAvailEventNum(deviceId, tsId, eventCount);
    }
    RT_LOG(RT_LOG_INFO, "get avail event num is gen");
    return RT_ERROR_NONE;
}


rtError_t ApiImpl::GetTaskIdAndStreamID(uint32_t * const taskId, uint32_t * const streamId)
{
    TIMESTAMP_NAME(__func__);
    const uint32_t lastTaskId = InnerThreadLocalContainer::GetLastTaskId();
    const uint32_t lastStreamId = InnerThreadLocalContainer::GetLastStreamId();

    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) == 1) {
        const uint64_t threadId = PidTidFetcher::GetCurrentUserTid();
        RT_LOG(RT_LOG_DEBUG, "stream_id=%u, task_id=%u, threadIdentifier=%" PRIu64,
            lastStreamId, lastTaskId, threadId);
    }

    *taskId = lastTaskId;
    *streamId = lastStreamId;

    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) == 1) {
        const uint64_t threadId = PidTidFetcher::GetCurrentUserTid();
        RT_LOG(RT_LOG_DEBUG,"Query last stream id and task id in current thread, task_id=%u,"
                            " stream_id=%u, threadIdentifier=%" PRIu64 ".", *taskId, *streamId, threadId);
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::SetDeviceFailureMode(uint64_t failureMode)
{
    Context *const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device *const dev = curCtx->Device_();
    COND_RETURN_ERROR(dev == nullptr, RT_ERROR_INVALID_VALUE, "device is NULL.");
    if (dev->GetTschVersion() < static_cast<uint32_t>(TS_VERSION_SET_STREAM_MODE)) {
        RT_LOG(RT_LOG_ERROR, "Failure mode cannot be set in current driver version, device_id=%u.", dev->Id_());
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    failureMode &= 0x1U;
    const uint64_t currentMode = dev->GetDevFailureMode();
    if (currentMode == failureMode) {
        RT_LOG(RT_LOG_INFO,
            "Input mode is same with the current mode which is %llu, device_id=%u.",
            failureMode,
            dev->Id_());
        return RT_ERROR_NONE;
    }

    if ((currentMode != CONTINUE_ON_FAILURE)) {
        RT_LOG(
            RT_LOG_ERROR, "The current mode is %llu, do not support change it, device_id=%u.", currentMode, dev->Id_());
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    dev->SetDevFailureMode(failureMode);
    RT_LOG(RT_LOG_INFO, "Set device=%u failure mode success, failureMode=%llu.", dev->Id_(), failureMode);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::StreamSetMode(Stream * const stm, const uint64_t stmMode)
{
    RT_LOG(RT_LOG_DEBUG, "set stream mode entry, mode = %llu.", stmMode);
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    if (dev->GetTschVersion() < static_cast<uint32_t>(TS_VERSION_SET_STREAM_MODE)) {
        RT_LOG(RT_LOG_ERROR, "Stream mode cannot be set in current driver version stream_id=%d.",
            stm->Id_());
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    const uint64_t failmode = (stmMode & 0x1U);
    Stream * const curStm = stm;
    if (curStm->GetBindFlag()) {
        RT_LOG(RT_LOG_ERROR, "stream binded with model, do not support set failure mode stream_id=%d.",
            curStm->Id_());
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    if (curStm->GetFailureMode() == failmode) {
        RT_LOG(RT_LOG_INFO, "input mode is same with the current mode which is %llu stream_id=%d.",
            failmode, curStm->Id_());
        return RT_ERROR_NONE;
    }

    if ((curStm->GetFailureMode() == STOP_ON_FAILURE) && (failmode == CONTINUE_ON_FAILURE)) {
        RT_LOG(RT_LOG_ERROR, "input mode is %llu, the current mode is Stop, do not support change stream_id=%d.",
            failmode, curStm->Id_());
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    // GetMode取到的是配置的模式,不会改变为Abort,当stm状态是Abort，但是配置还是Continue时，需要支持接口配置为Stop.
    const bool isStopSet = ((curStm->GetMode() & STREAM_FAILURE_MODE_MASK) == STOP_ON_FAILURE);
    if ((curStm->GetFailureMode() == ABORT_ON_FAILURE) && isStopSet) {
        RT_LOG(RT_LOG_ERROR, "input mode is %llu, the current mode is Abort, do not support change stream_id=%d.",
            failmode, curStm->Id_());
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Set stream failure mode failed, stream is not in current ctx stream_id=%d.", curStm->Id_());
    return curStm->SetFailMode(failmode);
}

rtError_t ApiImpl::StreamGetMode(const Stream * const stm, uint64_t * const stmMode)
{
    *stmMode = stm->GetMode();
    RT_LOG(RT_LOG_DEBUG, "get stream_id=%d mode entry, mode = %llu.", stm->Id_(), *stmMode);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetMaxModelNum(uint32_t * const maxModelCount)
{
    const Runtime * const rt = Runtime::Instance();
    if (!rt->HaveDevice() && !rt->GetIsUserSetSocVersion()) {
        RT_LOG(RT_LOG_WARNING, "No device exists, Resources cannot be queried without set soc version.");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    DevProperties props;
    GET_DEV_PROPERTIES(rt->GetChipType(), props);
    if (rt->GetIsUserSetSocVersion()) {
        *maxModelCount = (props.resetMaxModelNum & NUM_RESET_WITH_FIXED_VALUE) != 0 ? 
            2048U : Runtime::macroValue_.maxModelNum;
        RT_LOG(RT_LOG_INFO, "Offline mode, maxModelCount=%u.", *maxModelCount);
        return RT_ERROR_NONE;
    }

    *maxModelCount = Runtime::macroValue_.maxModelNum; // 注册每一个芯片的属性
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    const uint32_t tsVersion = dev->GetTschVersion();
    if (((props.resetMaxModelNum & NUM_RESET_WITH_FIXED_VALUE) != 0) &&
        (tsVersion >= static_cast<uint32_t>(TS_VERSION_EXPEND_MODEL_ID))) {
        *maxModelCount = 2048U;
    }
    if ((props.resetMaxModelNum & NUM_RESET_WITH_DRIVER) != 0) {
        const rtError_t error = NpuDriver::GetMaxModelNum(dev->Id_(), dev->DevGetTsId(), maxModelCount);
        ERROR_RETURN(error, "Get max model num failed.");
        return RT_ERROR_NONE;
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::EventCreate(Event ** const evt, const uint64_t flag)
{
    RT_LOG(RT_LOG_DEBUG, "flag=%" PRIu64 ".", flag);
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    COND_RETURN_ERROR(dev == nullptr, RT_ERROR_INVALID_VALUE, "device is NULL.");
    if (flag == RT_EVENT_MC2) {
        const bool isMc2SupportHccl = CheckSupportMC2Feature(dev);
        if (!isMc2SupportHccl) {
            RT_LOG(RT_LOG_WARNING, "Current ts version[%u] does not support create coprocessor event.",
                dev->GetTschVersion());
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
    }
    *evt = new (std::nothrow) Event(dev, flag, curCtx);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, *evt == nullptr, RT_ERROR_EVENT_NEW, "new event failed.");
    dev->PushEvent(*evt);

    if (flag == RT_EVENT_DEFAULT) { // default flag not alloc id in create.
        return RT_ERROR_NONE;
    }
    const rtError_t error = (*evt)->GenEventId();
    COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, DELETE_O(*evt);,
        "Gen event id failed, device_id=%u, tsId=%u, retCode=%#x", dev->Id_(), dev->DevGetTsId(), error);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::EventCreateEx(Event ** const evt, const uint64_t flag)
{
    RT_LOG(RT_LOG_DEBUG, "flag=%" PRIu64 ".", flag);
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    COND_RETURN_ERROR(dev == nullptr, RT_ERROR_INVALID_VALUE, "device is NULL.");
    if (flag == RT_EVENT_IPC) {
        *evt = new (std::nothrow) IpcEvent(dev, flag, curCtx);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, *evt == nullptr, RT_ERROR_EVENT_NEW, "new event failed.");
        const rtError_t error = (*evt)->Setup();
        COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, DELETE_O(*evt);,
                            "setup failed, retCode=%#x", error);
    } else {
        *evt = new (std::nothrow) Event(dev, flag, curCtx, false, true);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, *evt == nullptr, RT_ERROR_EVENT_NEW, "new event failed.");
    }
    dev->PushEvent(*evt);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::EventCreateForNotify(Event ** const evt)
{
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    *evt = new (std::nothrow) Event(curCtx->Device_(), RT_EVENT_DEFAULT, curCtx);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, *evt == nullptr, RT_ERROR_EVENT_NEW, "new event failed.");

    const rtError_t error = (*evt)->Setup();
    COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, DELETE_O(*evt);,
                           "setup failed, retCode=%#x", error);
    Device * const dev = curCtx->Device_();
    if (dev != nullptr) {
        dev->PushEvent(*evt);
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::EventDestroy(Event *evt)
{
    TIMESTAMP_NAME(__func__);
    if (evt->GetEventFlag() == RT_EVENT_IPC) {
        IpcEvent *eventIpc = dynamic_cast<IpcEvent *>(evt);
        IpcEventDestroy(&eventIpc, MAX_INT32_NUM, true);
    } else {
        RT_LOG(RT_LOG_INFO, "event destroy event_id=%d.", evt->EventId_());
        TryToFreeEventIdAndDestroyEvent(&evt, evt->EventId_(), true);
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::EventDestroySync(Event *evt)
{
    TIMESTAMP_NAME(__func__);
    const bool isDisableThreadFlag = Runtime::Instance()->GetDisableThread();
    if (!isDisableThreadFlag) {
        return EventDestroy(evt);
    }

    Context * const curCtx = Runtime::Instance()->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    if ((!dev->IsStarsPlatform()) && (!dev->CheckFeatureSupport(TS_FEATURE_EVENT_DESTROY_SYNC_FIX))) {
        RT_LOG(RT_LOG_WARNING, "ts not support event destroy sync in this drv, revert event destroy.");
        return EventDestroy(evt);
    }

    evt->SetDestroySync(true);
    DestroyEventSync(evt);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::CaptureEventRecord(Context * const ctx, Event * const evt, Stream * const stm)
{
    Stream *captureStm = nullptr;
    rtError_t error = GetCaptureStream(ctx, stm, evt, &captureStm);
    ERROR_RETURN_MSG_INNER(error, "Create capture stream failed, stream_id=%d, event_id=%d, error=%d.",
            stm->Id_(), evt->EventId_(), error);

    bool isNewEvt = false;
    if (GlobalContainer::IsEventHardMode()) {
        Event * const captureEvt = evt->GetCaptureEvent();
        if ((captureEvt == nullptr) || (!(captureEvt->HasRecord()))) {
            evt->InitEventAllocFlag(stm->Id_());
        }
        if ((captureEvt == nullptr) || (captureEvt->HasRecord())) {
            isNewEvt = evt->IsIdAllocFromDrv();
        }
    } else {
        isNewEvt = true;
    }

    Event *captureEvt = nullptr;
    error = GetCaptureEvent(stm, evt, &captureEvt, isNewEvt);
    ERROR_RETURN_MSG_INNER(error, "Create capture event failed, stream_id=%d, event_id=%d, error=%d.",
        stm->Id_(), evt->EventId_(), error);

    COND_RETURN_ERROR_MSG_INNER(IsCrossCaptureModel(captureEvt, captureStm),
        RT_ERROR_STREAM_CAPTURE_CONFLICT, "Capture event and capture stream is cross-model.");

    error = captureEvt->Record(stm, true);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR,
            "Stream record capture event failed, stream_id=[%d->%d], error=%d.",
            stm->Id_(), captureStm->Id_(), error);
    } else {
        RT_LOG(RT_LOG_DEBUG, "stream_id=[%d->%d], event_id=[%d->%d].",
            stm->Id_(), captureStm->Id_(), evt->EventId_(), captureEvt->EventId_());
    }
    return error;
}

rtError_t ApiImpl::EventRecord(Event * const evt, Stream * const stm)
{
    RT_LOG(RT_LOG_DEBUG, "event record.");
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    const bool supportFlag = (evt->IsNewMode() || (evt->GetEventFlag() == RT_EVENT_DEFAULT)) &&
        (curStm->GetModelNum() != 0);
    COND_RETURN_WARN(supportFlag, RT_ERROR_FEATURE_NOT_SUPPORT,
        "Not support current mode bind stm, mode=%d, flag=%" PRIu64 ", isModel=%d.",
        evt->IsNewMode(), evt->GetEventFlag(), (curStm->GetModelNum() != 0U));
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Event record failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    if (evt->ToBeCaptured(curStm)) {
        COND_RETURN_WARN(!evt->IsNewMode(), RT_ERROR_FEATURE_NOT_SUPPORT,
            "Not support call rtEventCreate or rtEventCreateWithFlag without external flag, mode=%d",
            evt->IsNewMode());
        COND_RETURN_ERROR_MSG_INNER(!StreamFlagIsSupportCapture(curStm->Flags()), RT_ERROR_STREAM_INVALID,
        "stream flag does not support capture to model, flag=%u.", curStm->Flags());
        COND_RETURN_ERROR_MSG_INNER(curStm == curCtx->DefaultStream_(),
            RT_ERROR_STREAM_CAPTURE_IMPLICIT,
            "A disallowed implicit dependency from default stream.");
        COND_RETURN_WARN(evt->IsEventWithoutWaitTask(), RT_ERROR_NONE,
            "The event flag %" PRIu64 " is not supported in capture mode.", evt->GetEventFlag());
        const std::lock_guard<std::mutex> lk(curCtx->GetCaptureLock());
        if (evt->ToBeCaptured(curStm)) {
            const rtError_t retCode = CaptureEventRecord(curCtx, evt, curStm);
            ERROR_PROC_RETURN_MSG_INNER(retCode, TerminateCapture(evt, curStm), "Capture event record failed.");
            return RT_ERROR_NONE;
        }
    }
    if (evt->GetEventFlag() == RT_EVENT_IPC) {
        return (dynamic_cast<IpcEvent *>(evt))->IpcEventRecord(curStm);
    } else {
        return evt->Record(curStm, true);
    }
}

rtError_t ApiImpl::EventRecordForNotify(Event * const evt, Stream * const stm)
{
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Event record for notify failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    return evt->RecordForNotify(curStm);
}

rtError_t ApiImpl::GetEventID(Event * const evt, uint32_t * const evtId)
{
    TIMESTAMP_NAME(__func__);
    return evt->GetEventID(evtId);
}

rtError_t ApiImpl::CaptureEventReset(const Event * const evt, Stream * const stm)
{
    Event * const captureEvt = evt->GetCaptureEvent();
    NULL_PTR_RETURN_MSG(captureEvt, RT_ERROR_EVENT_NULL);

    const Stream * const captureStm = stm->GetCaptureStream();
    NULL_STREAM_PTR_RETURN_MSG(captureStm);

    COND_RETURN_ERROR_MSG_INNER(IsCrossCaptureModel(captureEvt, captureStm),
        RT_ERROR_STREAM_CAPTURE_CONFLICT, "Capture event and capture stream is cross-model.");

    const rtError_t error = captureEvt->Reset(stm);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR,
            "Stream reset capture event failed, stream_id=[%d->%d], error=%d.",
            stm->Id_(), captureStm->Id_(), error);
    } else {
        RT_LOG(RT_LOG_DEBUG, "stream_id=[%d->%d], event_id=[%d->%d].",
            stm->Id_(), captureStm->Id_(), evt->EventId_(), captureEvt->EventId_());
    }
    return error;
}

rtError_t ApiImpl::EventReset(Event * const evt, Stream * const stm)
{
    RT_LOG(RT_LOG_DEBUG, "event reset.");
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    const bool supportFlag = (evt->IsNewMode()) || ((!evt->IsNotify())
        && (evt->GetEventFlag() == RT_EVENT_DEFAULT) && (curStm->GetModelNum() != 0));
    COND_RETURN_WARN(supportFlag, RT_ERROR_FEATURE_NOT_SUPPORT,
        "Not support current mode bind stm, mode=%d, flag=%" PRIu64 ", isModel=%d.",
        evt->IsNewMode(), evt->GetEventFlag(), (curStm->GetModelNum() != 0U));
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Event reset failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    if (evt->IsCapturing()) {
        COND_RETURN_ERROR_MSG_INNER(!StreamFlagIsSupportCapture(curStm->Flags()), RT_ERROR_STREAM_INVALID,
        "stream flag does not support capture to model, flag=%u.", curStm->Flags());
        COND_RETURN_ERROR_MSG_INNER(curStm == curCtx->DefaultStream_(),
            RT_ERROR_STREAM_CAPTURE_IMPLICIT,
            "A disallowed implicit dependency from default stream.");
        COND_RETURN_ERROR_MSG_INNER(evt->IsEventWithoutWaitTask(),
            RT_ERROR_INVALID_VALUE,
            "The event flag %" PRIu64 " is not supported in capture mode.", evt->GetEventFlag());
        const std::lock_guard<std::mutex> lk(curCtx->GetCaptureLock());
        if (evt->IsCapturing()) {
            const rtError_t retCode = CaptureEventReset(evt, curStm);
            ERROR_PROC_RETURN_MSG_INNER(retCode, TerminateCapture(evt, curStm), "Capture event record failed.");
            return RT_ERROR_NONE;
        }
    } else {
        if ((curStm != curCtx->DefaultStream_()) && (evt->ToBeCaptured(curStm))) {
            RT_LOG(RT_LOG_WARNING,  "Not support call rtEventCreate or rtEventCreateWithFlag without external flag");
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
    }

    return evt->Reset(curStm);
}

rtError_t ApiImpl::EventSynchronize(Event * const evt, const int32_t timeout)
{
    TIMESTAMP_NAME(__func__);
    Context *eventCtx = evt->Context_();
    rtError_t error = RT_ERROR_NONE;
    if (eventCtx != nullptr) {
        error = eventCtx->CheckStatus();
        ERROR_RETURN(error, "context is abort, status=%#x.", static_cast<uint32_t>(error));
    }
    RT_LOG(RT_LOG_DEBUG, "Event synchronize entry, timeout=%dms.", timeout);
    if (evt->GetEventFlag() == RT_EVENT_IPC) {
        error = (dynamic_cast<IpcEvent *>(evt))->IpcEventSync(timeout);
    } else {
        error = evt->Synchronize(timeout);
    }
    ERROR_RETURN(error, "Synchronize event failed.");
    RT_LOG(RT_LOG_INFO, "Event synchronize exit");
    return error;
}

rtError_t ApiImpl::EventQuery(Event * const evt)
{
    TIMESTAMP_NAME(__func__);
    Context *eventCtx = evt->Context_();
    if (eventCtx != nullptr) {
        const rtError_t error = eventCtx->CheckStatus();
        ERROR_RETURN(error, "context is abort, status=%#x.", static_cast<uint32_t>(error));
    }
    return evt->Query();
}

rtError_t ApiImpl::EventQueryStatus(Event * const evt, rtEventStatus_t * const status)
{
    Context *eventCtx = evt->Context_();
    if (eventCtx != nullptr) {
        const rtError_t error = eventCtx->CheckStatus();
        ERROR_RETURN(error, "context is abort, status=%#x.", static_cast<uint32_t>(error));
    }
    *status = RT_EVENT_INIT;
    if (evt->GetEventFlag() == RT_EVENT_IPC) {
        return (dynamic_cast<IpcEvent *>(evt))->IpcEventQuery(status);
    } else {
        return evt->QueryEventStatus(status);
    }
}

rtError_t ApiImpl::EventQueryWaitStatus(Event * const evt, rtEventWaitStatus_t * const status)
{
    TIMESTAMP_NAME(__func__);
    Context *const curCtx = CurrentContext();
    rtError_t error = RT_ERROR_NONE;

    if ((curCtx != nullptr)) {
        Device *device = curCtx->Device_();
        (void)device->GetDevRunningState();
        error = device->GetDevStatus();
        COND_PROC_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, error != RT_ERROR_NONE, error,
                                        RT_LOG_INNER_DETAIL_MSG(RT_DRV_INNER_ERROR, {"device_id"}, {std::to_string(device->Id_())});,
                                        "Device[%u] fault, ret=%#x.", device->Id_(), error);
        error = device->GetDeviceStatus();
        ERROR_RETURN(error, "device_id=%d status=%d is abnormal.", device->Id_(), error);
        error = curCtx->GetFailureError();
        ERROR_RETURN(error, "context is abort, status=%#x.", static_cast<uint32_t>(error));
    }
    *status = EVENT_STATUS_NOT_READY;
    bool waitStatus = false;
    const bool isDisableThreadFlag = Runtime::Instance()->GetDisableThread();
    error = evt->QueryEventWaitStatus(isDisableThreadFlag, waitStatus);
    if (waitStatus) {
        *status = EVENT_STATUS_COMPLETE;
    }
    return error;
}

rtError_t ApiImpl::EventElapsedTime(float32_t * const retTime, Event * const startEvt, Event * const endEvt)
{
    TIMESTAMP_NAME(__func__);
    return endEvt->ElapsedTime(retTime, startEvt);
}

rtError_t ApiImpl::EventGetTimeStamp(uint64_t * const retTime, Event * const evt)
{
    TIMESTAMP_NAME(__func__);
    return evt->GetTimeStamp(retTime);
}

rtError_t ApiImpl::DevMalloc(void ** const devPtr, const uint64_t size, const rtMemType_t type,
    const uint16_t moduleId)
{
    RT_LOG(RT_LOG_INFO, "size=%" PRIu64 ", type=%u, moduleId=%hu.", size, type, moduleId);
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    const uint64_t tmpSize = (((size + 0x1FU) >> 5U) << 5U); // 32 byte align

    return (curCtx->Device_()->Driver_())
        ->DevMemAlloc(devPtr, tmpSize, type, curCtx->Device_()->Id_(), moduleId);
}

rtError_t ApiImpl::DevFree(void * const devPtr)
{
    RT_LOG(RT_LOG_INFO, "device free mem=0x%llx", reinterpret_cast<uint64_t *>(devPtr));
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext(false);
    Driver *curDrv = nullptr;
    Runtime* rt = Runtime::Instance();
    uint32_t id = RT_MAX_DEV_NUM;
    if (!ContextManage::CheckContextIsValid(curCtx, true)) {
        curDrv = rt->driverFactory_.GetDriver(NPU_DRIVER);
    } else {
        const ContextProtect cp(curCtx);
        curDrv = curCtx->Device_()->Driver_();
        id = curCtx->Device_()->Id_();
    }
    NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);
    return curDrv->DevMemFree(devPtr, id);
}

rtError_t ApiImpl::DevDvppMalloc(void ** const devPtr, const uint64_t size, const uint32_t flag,
    const uint16_t moduleId)
{
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    const uint64_t curSize = (((size + 0x1FU) >> 5U) << 5U); // 32 byte align

    return curCtx->Device_()->Driver_()
        ->DevDvppMemAlloc(devPtr, curSize, curCtx->Device_()->Id_(), flag, moduleId);
}

rtError_t ApiImpl::DevDvppFree(void * const devPtr)
{
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    Driver *curDrv = nullptr;
    uint32_t id = RT_MAX_DEV_NUM;
    if (!ContextManage::CheckContextIsValid(curCtx, true)) {
        curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER); // stub id???
    } else {
        const ContextProtect cp(curCtx);
        curDrv = curCtx->Device_()->Driver_();
        id = curCtx->Device_()->Id_();
    }

    NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);

#ifndef CFG_DEV_PLATFORM_PC
    rtPtrAttributes_t attributes;
    const rtError_t error = curDrv->PtrGetAttributes(devPtr, &attributes);
    const rtMemLocationType locationType = attributes.location.type;
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE,
        "Get devPtr pointer attributes failed, retCode=%#x", static_cast<uint32_t>(error));
    COND_RETURN_ERROR_MSG_INNER(locationType != RT_MEMORY_LOC_DEVICE && locationType != RT_MEMORY_LOC_MANAGED, RT_ERROR_INVALID_VALUE,
        "Invalid location!, location = %d.", locationType);
#endif

    return curDrv->DevMemFree(devPtr, id);
}

rtError_t ApiImpl::HostMalloc(void ** const hostPtr, const uint64_t size, const uint16_t moduleId)
{
    RT_LOG(RT_LOG_INFO, "size=%" PRIu64, size);
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    const uint64_t curSize = (((size + 0x1FU) >> 5U) << 5U);  // 32 byte align

    return curCtx->Device_()->Driver_()->HostMemAlloc(hostPtr, curSize, curCtx->Device_()->Id_(), moduleId);
}

void ApiImpl::CheckMallocHostCfg(uint16_t *moduleId) const
{
    if (*moduleId > DEFAULT_MODULEID) {
        *moduleId = static_cast<uint16_t>(MODULEID_RUNTIME);
    }
    return;
}

rtError_t ApiImpl::GetMallocHostConfigAttr(rtMallocAttribute_t* attr, uint16_t *moduleId) const
{
    rtError_t error = RT_ERROR_NONE;
    NULL_PTR_RETURN_MSG_OUTER(attr, RT_ERROR_INVALID_VALUE);
    if (attr->attr == RT_MEM_MALLOC_ATTR_MODULE_ID) {
        *moduleId = attr->value.moduleId;
    } else {
        RT_LOG_OUTER_MSG_INVALID_PARAM(attr->attr, RT_MEM_MALLOC_ATTR_MODULE_ID);
        error = RT_ERROR_INVALID_VALUE;
    }
    return error;
}

rtError_t ApiImpl::GetMallocHostConfigInfo(const rtMallocConfig_t *cfg, uint16_t *moduleId) const
{
    rtError_t error = RT_ERROR_NONE;
    for (uint32_t i = 0U; i < cfg->numAttrs; i++) {
        rtMallocAttribute_t* attr = &(cfg->attrs[i]);
        error = GetMallocHostConfigAttr(attr, moduleId);
        if (error != RT_ERROR_NONE) {
            return error;
        }
    }
    CheckMallocHostCfg(moduleId);
    return error;
}

rtError_t ApiImpl::HostMallocWithCfg(void ** const hostPtr, const uint64_t size,
    const rtMallocConfig_t *cfg)
{
    NULL_PTR_RETURN_MSG_OUTER(hostPtr, RT_ERROR_INVALID_VALUE);
    ZERO_RETURN_MSG_OUTER(size);
    uint16_t moduleId = static_cast<uint16_t>(MODULEID_RUNTIME);
    if (cfg != nullptr) {
        NULL_PTR_RETURN_MSG_OUTER(cfg->attrs, RT_ERROR_INVALID_VALUE);
    }

    if ((cfg != nullptr) && (cfg->attrs != nullptr)) {
        const rtError_t error = GetMallocHostConfigInfo(cfg, &moduleId);
        ERROR_RETURN(error, "Host memory malloc failed, size=%" PRIu64 "(bytes)", size);
    }
    const rtError_t error = HostMalloc(hostPtr, size, moduleId);
    ERROR_RETURN(error, "Host memory malloc failed, size=%" PRIu64 "(bytes), moduleId=%hu.", size, moduleId);
    RT_LOG(RT_LOG_INFO, "Host memory malloc succeed,size=%" PRIu64 " , moduleId=%hu, host addr=%#" PRIx64 ".",
        size, moduleId, static_cast<uint64_t>(reinterpret_cast<uintptr_t>(*hostPtr)));
    return error;
}

rtError_t ApiImpl::HostFree(void * const hostPtr)
{
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    Driver *curDrv = nullptr;
    if (!ContextManage::CheckContextIsValid(curCtx, true)) {
        curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    } else {
        const ContextProtect cp(curCtx);
        curDrv = curCtx->Device_()->Driver_();
    }
    NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);

#ifndef CFG_DEV_PLATFORM_PC
    rtPtrAttributes_t attributes;
    const rtError_t error = PtrGetAttributes(hostPtr, &attributes);
    const rtMemLocationType locationType = attributes.location.type;
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE,
        "Get hostPtr pointer attributes failed, retCode=%#x", static_cast<uint32_t>(error));
    COND_RETURN_ERROR_MSG_INNER(locationType != RT_MEMORY_LOC_HOST && locationType != RT_MEMORY_LOC_UNREGISTERED, RT_ERROR_INVALID_VALUE,
        "location=%d is not host memory.", locationType);
#endif

    return curDrv->HostMemFree(hostPtr);
}

rtError_t ApiImpl::MallocHostSharedMemory(rtMallocHostSharedMemoryIn * const in,
    rtMallocHostSharedMemoryOut * const out)
{
    RT_LOG(RT_LOG_INFO, "sharedMemName=%s, sharedMemSize=%" PRIu64 ", flag=%u.",
        in->name, in->size, in->flag);
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    NULL_PTR_RETURN_MSG(curCtx, RT_ERROR_CONTEXT_NULL);

    return curCtx->Device_()->Driver_()->MallocHostSharedMemory(in, out,
        curCtx->Device_()->Id_());
}

rtError_t ApiImpl::FreeHostSharedMemory(rtFreeHostSharedMemoryIn * const in)
{
    RT_LOG(RT_LOG_INFO, "sharedMemName=%s, sharedMemSize=%" PRIu64 ", fd=%u.",
        in->name, in->size,  in->fd);
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    NULL_PTR_RETURN_MSG(curCtx, RT_ERROR_CONTEXT_NULL);

    return curCtx->Device_()->Driver_()->FreeHostSharedMemory(in,
        curCtx->Device_()->Id_());
}

rtError_t ApiImpl::HostRegister(void *ptr, uint64_t size, rtHostRegisterType type, void **devPtr)
{
    RT_LOG(RT_LOG_INFO, "MemSize=%" PRIu64 "u.", size);
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    NULL_PTR_RETURN_MSG(curCtx, RT_ERROR_CONTEXT_NULL);

    return curCtx->Device_()->Driver_()->HostRegister(ptr, size, type, devPtr,
        curCtx->Device_()->Id_());
}

rtError_t ApiImpl::HostRegisterV2(void *ptr, size_t size, uint32_t flag)
{
    RT_LOG(RT_LOG_INFO, "MemSize=%" PRIu64 ", flag=%u.", size, flag);
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    NULL_PTR_RETURN_MSG(curCtx, RT_ERROR_CONTEXT_NULL);

    rtError_t error;
    void *devPtr = nullptr;
    void **pDevice = &devPtr;

    if ((flag & RT_MEM_HOST_REGISTER_MAPPED) != 0U) {
        const uint32_t deviceId = curCtx->Device_()->Id_();
        error = curCtx->Device_()->Driver_()->HostRegister(ptr, size,
            RT_HOST_REGISTER_MAPPED, pDevice, deviceId);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    }

    if ((flag & RT_MEM_HOST_REGISTER_PINNED) != 0U) {
        error = InsertPinnedMemory(ptr, size);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    }

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::HostGetDevicePointer(void *pHost, void **pDevice, uint32_t flag)
{
    (void)flag;
    *pDevice = GetMappedDevicePointer(pHost);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::HostUnregister(void *ptr)
{
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    NULL_PTR_RETURN_MSG(curCtx, RT_ERROR_CONTEXT_NULL);

    bool isRegister = false;
    if(IsMappedMemoryBase(ptr)) {
        isRegister = true;
        const uint32_t deviceId = curCtx->Device_()->Id_();
        const rtError_t error = curCtx->Device_()->Driver_()->HostUnregister(ptr, deviceId);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    }

    if(IsPinnedMemoryBase(ptr)) {
        isRegister = true;
        ErasePinnedMemory(ptr);
    }
    return (isRegister) ? RT_ERROR_NONE : RT_ERROR_HOST_MEMORY_NOT_REGISTERED;
}

rtError_t ApiImpl::ManagedMemAlloc(void ** const ptr, const uint64_t size, const uint32_t flag,
    const uint16_t moduleId)
{
    RT_LOG(RT_LOG_DEBUG, "managed memory alloc, size=%" PRIu64 ", flag=%u", size, flag);
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    if ((flag == RT_MEMORY_SPM) && (size <= 512U)) { // 512:alloc size
        return curCtx->Device_()->AllocSPM(ptr, size);
    } else if (flag == RT_MEMORY_DDR_NC) {
        return curCtx->Device_()->Driver_()->MemAllocEx(ptr, size, RT_MEMORY_DDR_NC);
    } else {
        return curCtx->Device_()->Driver_()
            ->ManagedMemAlloc(ptr, size, Driver::MANAGED_MEM_RW, curCtx->Device_()->Id_(), moduleId);
    }
}

rtError_t ApiImpl::ManagedMemFree(const void * const ptr)
{
    RT_LOG(RT_LOG_INFO, "managed memory free.");
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    Driver *curDrv = nullptr;
    if (!ContextManage::CheckContextIsValid(curCtx, true)) {
        curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    } else {
        const ContextProtect cp(curCtx);
        curDrv = curCtx->Device_()->Driver_();
    }
    NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);

    if (ContextManage::CheckContextIsValid(curCtx, true)) {
        const ContextProtect cp(curCtx);
        if (curCtx->Device_()->IsSPM(ptr)) {
            return curCtx->Device_()->FreeSPM(ptr);
        }
    }
    return curDrv->ManagedMemFree(ptr);
}

rtError_t ApiImpl::MemAdvise(void *devPtr, uint64_t count, uint32_t advise)
{
    RT_LOG(RT_LOG_DEBUG, "memory advise, count=%" PRIu64 ", advise=%u.", count, advise);
    Context *ctx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(ctx, RT_ERROR_CONTEXT_NULL);

    return ctx->Device_()->Driver_()->MemAdvise(devPtr, count, advise, ctx->Device_()->Id_());
}

rtError_t ApiImpl::DevMallocCached(void ** const devPtr, const uint64_t size, const rtMemType_t type,
    const uint16_t moduleId)
{
    RT_LOG(RT_LOG_INFO, "dev cached memory alloc, size=%" PRIu64 ", type=%u.", size, type);
    TIMESTAMP_NAME(__func__);
    NULL_PTR_RETURN_MSG_OUTER(devPtr, RT_ERROR_INVALID_VALUE);
    COND_RETURN_OUT_ERROR_MSG_CALL(size > MAX_ALLOC_SIZE, RT_ERROR_INVALID_VALUE,
        "Invalid size, current size=%" PRIu64 "(bytes), valid size range is (0, %" PRIu64 "].",
        size, MAX_ALLOC_SIZE);

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    return curCtx->Device_()->Driver_()
        ->DevMemAllocCached(devPtr, size, type, curCtx->Device_()->Id_(), moduleId);
}

rtError_t ApiImpl::FlushCache(const uint64_t base, const size_t len)
{
    RT_LOG(RT_LOG_INFO, "flush cache base=%" PRIu64 ", len=%zu.", base, len);
    TIMESTAMP_NAME(__func__);
    COND_RETURN_OUT_ERROR_MSG_CALL(base == 0U, RT_ERROR_INVALID_VALUE, "invalid param, base is 0!");

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    rtError_t error = curCtx->Device_()->GetDeviceStatus();
    COND_PROC((error == RT_ERROR_DEVICE_TASK_ABORT), return error);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::InvalidCache(const uint64_t base, const size_t len)
{
    RT_LOG(RT_LOG_INFO, "invalid cache base=%" PRIu64 ", len=%zu.", base, len);
    TIMESTAMP_NAME(__func__);
    COND_RETURN_OUT_ERROR_MSG_CALL(base == 0U, RT_ERROR_INVALID_VALUE, "invalid param base is 0!");

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::MemCopySync(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cnt,
    const rtMemcpyKind_t kind, const uint32_t checkKind)
{
    RT_LOG(RT_LOG_DEBUG, "memcpy sync, cnt=%" PRIu64 ", kind=%d.", cnt, kind);
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device* device = curCtx->Device_();
    NULL_PTR_RETURN_MSG_OUTER(device, RT_ERROR_INVALID_VALUE);
    const rtError_t error = device->GetDeviceStatus();
    COND_PROC((error == RT_ERROR_DEVICE_TASK_ABORT), return error);

    COND_RETURN_ERROR(!(curCtx->IsCaptureModeSupport()), RT_ERROR_STREAM_CAPTURE_MODE_NOT_SUPPORT,
        "The current capture mode:threadCaptureMode=%d, exchangeCaptureMode=%d, contextCaptureMode=%d",
        InnerThreadLocalContainer::GetThreadCaptureMode(),
        InnerThreadLocalContainer::GetThreadExchangeCaptureMode(), curCtx->GetContextCaptureMode());

    Driver* driver = device->Driver_();
    NULL_PTR_RETURN_MSG_OUTER(driver, RT_ERROR_INVALID_VALUE);
    rtMemcpyKind_t curKind = kind;
    if (device->IsSPM(dst)) {
        curKind = (driver->GetRunMode() == static_cast<uint32_t>(RT_RUN_MODE_ONLINE)) ?
            RT_MEMCPY_HOST_TO_DEVICE : RT_MEMCPY_DEVICE_TO_DEVICE;
    }

    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    if (((checkKind == WITHOUT_CHECK_KIND) || (checkKind == NOT_CHECK_KIND_BUT_CHECK_PINNED)) &&
        IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_MEM_MBUF_COPY)) {
            /* on cloudv2, mbuff memcpy */
            return driver->MemCopySync(dst, destMax, src, cnt, curKind, true, device->Id_());
    }
    return driver->MemCopySync(dst, destMax, src, cnt, curKind);
}

rtError_t ApiImpl::MemCopySyncEx(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cnt,
    const rtMemcpyKind_t kind)
{
    RT_LOG(RT_LOG_DEBUG, "memcpy sync, cnt=%" PRIu64 ", kind=%d.", cnt, kind);
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device* device = curCtx->Device_();
    NULL_PTR_RETURN_MSG_OUTER(device, RT_ERROR_INVALID_VALUE);
    const rtError_t error = device->GetDeviceStatus();
    COND_PROC((error == RT_ERROR_DEVICE_TASK_ABORT), return error);
    COND_RETURN_ERROR(!(curCtx->IsCaptureModeSupport()), RT_ERROR_STREAM_CAPTURE_MODE_NOT_SUPPORT,
        "The current capture mode:threadCaptureMode=%d, exchangeCaptureMode=%d, contextCaptureMode=%d",
        InnerThreadLocalContainer::GetThreadCaptureMode(),
        InnerThreadLocalContainer::GetThreadExchangeCaptureMode(), curCtx->GetContextCaptureMode());

    Driver* driver = device->Driver_();
    NULL_PTR_RETURN_MSG_OUTER(driver, RT_ERROR_INVALID_VALUE);
    rtMemcpyKind_t curKind = kind;
    if (device->IsSPM(dst)) {
        curKind = (driver->GetRunMode() == static_cast<uint32_t>(RT_RUN_MODE_ONLINE)) ?
            RT_MEMCPY_HOST_TO_DEVICE : RT_MEMCPY_DEVICE_TO_DEVICE;
    }

    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_MEM_MBUF_COPY)) {
        /* on cloudv2, mbuff memcpy */
        return driver->MemCopySync(dst, destMax, src, cnt, curKind, true, device->Id_());
    }
    return driver->MemCopySync(dst, destMax, src, cnt, curKind);
}

rtError_t ApiImpl::MemcpyAsync(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cnt,
    const rtMemcpyKind_t kind, Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo,
    const rtD2DAddrCfgInfo_t * const addrCfg, bool checkKind, const rtMemcpyConfig_t * const memcpyConfig)
{
    RT_LOG(RT_LOG_DEBUG, "async memcpy, count=%" PRIu64 ", kind=%d", cnt, kind);
    UNUSED(checkKind);
    UNUSED(memcpyConfig);
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Memcpy async failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    if (addrCfg != nullptr) {
        Device* device = curStm->Device_();
        NULL_PTR_RETURN_MSG_OUTER(device, RT_ERROR_INVALID_VALUE);
        RT_LOG(RT_LOG_INFO, "device_id=%u, tsch version=%u",  device->Id_(), device->GetTschVersion());
        if (!device->CheckFeatureSupport(TS_FEATURE_D2D_ADDR_ASYNC)) {
            RT_LOG(RT_LOG_WARNING, "current ts version does not support d2d addr MemcpyAsync");
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
    }
    const uint64_t sqSize = CalculateMemcpyAsyncSingleMaxSize(kind);
    rtError_t error = RT_ERROR_NONE;
    uint64_t realSize = cnt;
    uint64_t remainSize = cnt;
    uint64_t doneSize = 0U;
    while (remainSize > 0U) {
        const uint64_t doingSize = (remainSize >= sqSize) ? sqSize : remainSize;
        realSize = doingSize;
        error = curCtx->MemcpyAsync((static_cast<char_t *>(dst)) + doneSize,
            destMax - doneSize, (static_cast<const char_t *>(src)) + doneSize, doingSize,
            kind, curStm, &realSize, nullptr, cfgInfo, addrCfg);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "cnt=%lld, doingSize=%lld, realSize=%lld.", cnt, doingSize, realSize);
            return error;
        }
        doneSize += realSize;
        remainSize -= realSize;
    }
    return error;
}

rtError_t ApiImpl::LaunchSqeUpdateTask(uint32_t streamId, uint32_t taskId, void *src, uint64_t cnt, Stream * const stm, bool needCpuTask)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Stream *curStm = const_cast<Stream *>(stm);
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }

    COND_RETURN_OUT_ERROR_MSG_CALL(curStm->GetBindFlag() == true, RT_ERROR_INVALID_VALUE,
        "curStm param should be a single-operator flow stream.");

    COND_RETURN_OUT_ERROR_MSG_CALL(curStm->IsCapturing() == true, RT_ERROR_STREAM_CAPTURED,
        "the stream is capturing.");

    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "launch sqe update task failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    Device * const dev = curCtx->Device_();
    NULL_PTR_RETURN_MSG_OUTER(dev, RT_ERROR_INVALID_VALUE);

    StreamSqCqManage * const streamSqCqManagePtr = dev->GetStreamSqCqManage();
    NULL_PTR_RETURN_MSG_OUTER(streamSqCqManagePtr, RT_ERROR_INVALID_VALUE);

    TaskFactory * const devTaskFactory = dev->GetTaskFactory();
    NULL_PTR_RETURN_MSG_OUTER(devTaskFactory, RT_ERROR_INVALID_VALUE);

    Stream *modelStream = nullptr;
    rtError_t error = streamSqCqManagePtr->GetStreamById(streamId, &modelStream);
    COND_RETURN_ERROR_MSG_INNER(((error != RT_ERROR_NONE) || (modelStream == nullptr)), error,
        "Query stream failed, dev_id=%d, stream_id=%u, retCode=%#x.",
        dev->Id_(), streamId, static_cast<uint32_t>(error));

    if ((modelStream->GetBindFlag() == false) || (modelStream->GetModelNum() == 0)) {
        RT_LOG_CALL_MSG(ERR_MODULE_GE, "Invalid dev_id=%d, stream_id=%u, stream is not in model",
            dev->Id_(), streamId);
        return RT_ERROR_INVALID_VALUE;
    }

    TaskInfo* task = devTaskFactory->GetTask(static_cast<int32_t>(streamId), taskId);

    COND_RETURN_ERROR_MSG_INNER(task == nullptr, RT_ERROR_INVALID_VALUE,
        "can not find task by dev_id=%d, stream_id=%u, task_id=%u", dev->Id_(), streamId, taskId);
    COND_RETURN_ERROR_MSG_INNER(task->type != TS_TASK_TYPE_STARS_COMMON, RT_ERROR_INVALID_VALUE,
        "dev_id=%d, stream_id=%u, task_id=%u, task_type=%u is not a common task",
        dev->Id_(), streamId, taskId, static_cast<uint32_t>(task->type));
    COND_RETURN_ERROR_MSG_INNER(task->u.starsCommTask.commonStarsSqe.commonSqe.sqeHeader.type != RT_STARS_SQE_TYPE_DSA,
        RT_ERROR_INVALID_VALUE, "dev_id=%d, stream_id=%u, task_id=%u is not a dsa task, sqe_type=%u",
        dev->Id_(), streamId, taskId, task->u.starsCommTask.commonStarsSqe.commonSqe.sqeHeader.type);

    const uint32_t sqId = modelStream->GetSqId();
    const uint32_t pos = task->pos;

    if (needCpuTask == false){
        if (task->u.starsCommTask.srcDevAddr == nullptr) {
            task->u.starsCommTask.srcDevAddr = src;
        } else {
            const uint64_t dsaSrcDevAddr =
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(task->u.starsCommTask.srcDevAddr));
            const uint64_t currentSrcDevAddr = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(src));
            if (dsaSrcDevAddr != currentSrcDevAddr) {
                RT_LOG_CALL_MSG(ERR_MODULE_GE,
                    "src device address changed dsaSrcDevAddr=%" PRIu64 ", currentSrcDevAddr=%" PRIu64
                    ", please check src parameter",
                    dsaSrcDevAddr,
                    currentSrcDevAddr);
                return RT_ERROR_INVALID_VALUE;
            }
        }
        return curCtx->LaunchSqeUpdateTask(src, cnt, sqId, pos, curStm);
    } else {
        COND_RETURN_ERROR_MSG_INNER(
            task->u.starsCommTask.randomDevAddr == nullptr, RT_ERROR_INVALID_VALUE, "randomDevAddr is null.");
        // randomDevAddr + RANDOM_INPUT_PARAM_SIZE bytes used as dsa update aicpu op's output sqe addr
        constexpr uint32_t randomIuputParamSize = 16U;
        void *outputSqeAddr =
            RtPtrToPtr<void *, uint8_t*>(static_cast<uint8_t *>(task->u.starsCommTask.randomDevAddr) + randomIuputParamSize);

        // built aicpu task param
        const std::string soName = "libaicpu_extend_kernels.so";
        const std::string kernelName = "RuntimeAicpuKernel";
        constexpr uint32_t argsSize = 96U;
        uint8_t args[argsSize];

        uint64_t offset = 0U;

        // append RtAicpuKernelArgs, refer to RtAicpuKernelArgs.
        constexpr uint32_t kernelType = 0U;
        errno_t ret = memcpy_s(args + offset, sizeof(kernelType), &kernelType, sizeof(kernelType));
        COND_RETURN_ERROR_MSG_INNER(ret != EOK, RT_ERROR_SEC_HANDLE, "Memcpy kernelType failed.");

        offset += sizeof(kernelType);
        constexpr uint32_t paramLength = 24U;  // DsaUpdateParam size
        ret = memcpy_s(args + offset, sizeof(paramLength), &paramLength, sizeof(paramLength));
        COND_RETURN_ERROR_MSG_INNER(ret != EOK, RT_ERROR_SEC_HANDLE, "Memcpy paramLength failed.");
        offset += sizeof(paramLength);
        // append DsaUpdateParam, refer to DsaUpdateParam struct 
        ret = memcpy_s(args + offset, sizeof(src), &src, sizeof(src));
        COND_RETURN_ERROR_MSG_INNER(ret != EOK, RT_ERROR_SEC_HANDLE, "Memcpy task_info addr failed.");
        offset += sizeof(src);
        ret = memcpy_s(args + offset, sizeof(outputSqeAddr), &outputSqeAddr, sizeof(outputSqeAddr));
        COND_RETURN_ERROR_MSG_INNER(ret != EOK, RT_ERROR_SEC_HANDLE, "Memcpy sqe addr failed.");
        offset += sizeof(outputSqeAddr);
        void *dsaCfgParam = task->u.starsCommTask.randomDevAddr;
        ret = memcpy_s(args + offset, sizeof(dsaCfgParam), &dsaCfgParam, sizeof(dsaCfgParam));
        COND_RETURN_ERROR_MSG_INNER(ret != EOK, RT_ERROR_SEC_HANDLE, "Memcpy dsaCfgParam addr failed.");
        offset += sizeof(dsaCfgParam);
        // append soName
        const uint32_t soNameAddrOffset = static_cast<uint32_t>(offset);
        const size_t soNameLen = soName.length() + 1U;
        ret = memcpy_s(args + offset, soNameLen, soName.c_str(), soNameLen);
        COND_RETURN_ERROR_MSG_INNER(ret != EOK, RT_ERROR_SEC_HANDLE, "Memcpy soName failed.");
        offset += soNameLen;

        // append kernelName
        const uint32_t kernelNameAddrOffset = static_cast<uint32_t>(offset);
        const size_t kernelNameLen = kernelName.length() + 1U;
        ret = memcpy_s(args + offset, kernelNameLen, kernelName.c_str(), kernelNameLen);
        COND_RETURN_ERROR_MSG_INNER(ret != EOK, RT_ERROR_SEC_HANDLE, "Memcpy kernelName failed.");

        // launch aicpu task to update dsa.
        rtAicpuArgsEx_t argsInfo = {};
        argsInfo.hostInputInfoPtr = nullptr;
        argsInfo.kernelOffsetInfoPtr = nullptr;
        argsInfo.hostInputInfoNum = 0U;
        argsInfo.kernelOffsetInfoNum = 0U;
        argsInfo.soNameAddrOffset = soNameAddrOffset;
        argsInfo.kernelNameAddrOffset = kernelNameAddrOffset;
        argsInfo.timeout = 0U;
        argsInfo.isNoNeedH2DCopy = false;
        argsInfo.argsSize = argsSize;
        argsInfo.args = args;

        error = curCtx->LaunchCpuKernelExWithArgs(1U, &argsInfo, curStm, RT_KERNEL_DEFAULT, KERNEL_TYPE_AICPU_KFC);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "update dsa failed, due to launch cpu task failed.");
        RT_LOG(RT_LOG_INFO, "launch dsa update cpu task success.");
        // LaunchSqeUpdateTask only update sqe from offset=DSA_SQE_UPDATE_OFFSET, so need add offset.
        constexpr uint32_t dsaSqeUpdateOffset = 16U;
        constexpr uint32_t dsaSqeUpdateSize = 40U;   // SqeUpdateTask only can copy 40 bytes;
        void *copySqeAddr = RtPtrToPtr<void *, uint8_t*>(static_cast<uint8_t *>(outputSqeAddr) + dsaSqeUpdateOffset);
        return curCtx->LaunchSqeUpdateTask(copySqeAddr, dsaSqeUpdateSize, sqId, pos, curStm);
    } 
}

rtError_t ApiImpl::MemcpyAsyncPtr(void * const memcpyAddrInfo, const uint64_t destMax,
    const uint64_t count, Stream *stm, const rtTaskCfgInfo_t * const cfgInfo, const bool isMemcpyDesc)
{
    RT_LOG(RT_LOG_DEBUG, "async memcpy, using ptr_mode = 1, stream=%p, count=%" PRIu64 ".", stm, count);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    if (stm == nullptr) {
        stm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(stm);
    }
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Memcpy async failed, stream is not in current ctx, stream_id=%d.", stm->Id_());
    return curCtx->MemcpyAsyncPtr(reinterpret_cast<rtMemcpyAddrInfo *>(memcpyAddrInfo), destMax, count, stm, nullptr,
        cfgInfo, isMemcpyDesc);
}

rtError_t ApiImpl::RtsMemcpyAsync(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cnt,
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

rtError_t ApiImpl::RtsMemcpy(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cnt,
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

rtError_t ApiImpl::SetMemcpyDesc(rtMemcpyDesc_t desc, const void * const srcAddr, const void * const dstAddr,
    const size_t count, const rtMemcpyKind kind, rtMemcpyConfig_t * const config)
{
    UNUSED(kind);
    UNUSED(config);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    return curCtx->SetMemcpyDesc(desc, srcAddr, dstAddr, count);
}

rtError_t ApiImpl::MemcpyAsyncWithDesc(rtMemcpyDesc_t desc, Stream *stm, const rtMemcpyKind kind,
    rtMemcpyConfig_t * const config)
{
    UNUSED(desc);
    UNUSED(stm);
    UNUSED(kind);
    UNUSED(config);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::ReduceAsync(void * const dst, const void * const src, const uint64_t cnt,
    const rtRecudeKind_t kind, const rtDataType_t type, Stream * const stm,
    const rtTaskCfgInfo_t * const cfgInfo)
{
    RT_LOG(RT_LOG_INFO, "ReduceAsync, count=%" PRIu64 ", kind=%d.", cnt, kind);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Reduce async failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    return curCtx->ReduceAsync(dst, src, cnt, kind, type, curStm, cfgInfo);
}

rtError_t ApiImpl::ReduceAsyncV2(void * const dst, const void * const src, const uint64_t cnt,
    const rtRecudeKind_t kind, const rtDataType_t type, Stream * const stm, void * const overflowAddr)
{
    RT_LOG(RT_LOG_INFO, "ReduceAsyncV2, count=%" PRIu64 ", kind=%d.", cnt, kind);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = const_cast<Stream *>(stm);
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Reduce async v2 failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    Device * const dev = curCtx->Device_();
    const uint32_t tsVersion = dev->GetTschVersion() & 0xFFFFU; // low 16bit means tschversion
    const auto reduceOverflowProp = dev->GetDevProperties().reduceOverflow;
    if ((reduceOverflowProp == ReduceOverflowType::REDUCE_OVERFLOW_TS_VERSION_REDUCE_V2_ID) && 
        (tsVersion >= static_cast<uint32_t>(TS_VERSION_REDUCE_V2_ID))) {
        return curCtx->ReduceAsyncV2(dst, src, cnt, kind, type, curStm, overflowAddr);
    } else if ((reduceOverflowProp == ReduceOverflowType::REDUCE_OVERFLOW_TS_VERSION_REDUCV2_SUPPORT_DC) && 
        (tsVersion >= static_cast<uint32_t>(TS_VERSION_REDUCV2_SUPPORT_DC))) {
        return curCtx->ReduceAsyncV2(dst, src, cnt, kind, type, curStm, overflowAddr);
    } else {
        return curCtx->ReduceAsync(dst, src, cnt, kind, type, curStm, nullptr);
    }
}

rtError_t ApiImpl::MemSetSync(const void * const devPtr, const uint64_t destMax, const uint32_t val,
    const uint64_t cnt)
{
    RT_LOG(RT_LOG_INFO, "destMax=%" PRIu64 ", value=%u, count=%" PRIu64, destMax, val, cnt);
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const rtError_t error = curCtx->Device_()->GetDeviceStatus();
    COND_PROC((error == RT_ERROR_DEVICE_TASK_ABORT), return error);

    COND_RETURN_ERROR(!(curCtx->IsCaptureModeSupport()), RT_ERROR_STREAM_CAPTURE_MODE_NOT_SUPPORT,
        "The current capture mode:threadCaptureMode=%d, exchangeCaptureMode=%d, contextCaptureMode=%d",
        InnerThreadLocalContainer::GetThreadCaptureMode(),
        InnerThreadLocalContainer::GetThreadExchangeCaptureMode(), curCtx->GetContextCaptureMode());

    return curCtx->Device_()->Driver_()->MemSetSync(devPtr, destMax, val, cnt);
}

rtError_t ApiImpl::MemsetAsync(void * const ptr, const uint64_t destMax, const uint32_t val, const uint64_t cnt,
    Stream * const stm)
{
    RT_LOG(RT_LOG_DEBUG, "MemsetAsync, destMax=%" PRIu64 ", value=%u, count=%" PRIu64 ".", destMax, val, cnt);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Memset async failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    return curCtx->MemsetAsync(ptr, destMax, val, cnt, curStm);
}

rtError_t ApiImpl::MemGetInfo(size_t * const freeSize, size_t * const totalSize)
{
    RT_LOG(RT_LOG_DEBUG, "mem get info free=%zu, total=%zu.", *freeSize, *totalSize);
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    return curCtx->Device_()->Driver_()->MemGetInfo(curCtx->Device_()->Id_(), true, freeSize, totalSize);
}

rtError_t ApiImpl::MemGetInfoByType(const int32_t devId, const rtMemType_t type, rtMemInfo_t * const info)
{
    RT_LOG(RT_LOG_DEBUG, "mem get info drv devId=%d, type=%u.", devId, type);
    Context * const curCtx = CurrentContext(true, devId);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    return curCtx->Device_()->Driver_()->MemGetInfoByType(static_cast<uint32_t>(devId), type, info);
}

rtError_t ApiImpl::CheckMemType(void **addrs, uint32_t size, uint32_t memType, uint32_t *checkResult, uint32_t reserve)
{
    UNUSED(reserve);
    RT_LOG(RT_LOG_INFO, "mem get info size=%u, type=%u.", size, memType);
    Runtime* runtime = Runtime::Instance();
    NULL_PTR_RETURN_MSG(runtime, RT_ERROR_INSTANCE_NULL);
    Context * const curCtx = runtime->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const uint32_t deviceId = curCtx->Device_()->Id_();
    return curCtx->Device_()->Driver_()->CheckMemType(addrs, size, memType, checkResult, deviceId);
}

rtError_t ApiImpl::GetMemUsageInfo(const uint32_t deviceId, rtMemUsageInfo_t * const memUsageInfo,
                                   const size_t inputNum, size_t * const outputNum)
{
    RT_LOG(RT_LOG_INFO, "get mem usage info: deviceId=%u, inputNum=%zu.", deviceId, inputNum);
    Context * const curCtx = CurrentContext(true, deviceId);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    return curCtx->Device_()->Driver_()->GetMemUsageInfo(deviceId, memUsageInfo, inputNum, outputNum);
}

rtError_t ApiImpl::MemGetInfoEx(const rtMemInfoType_t memInfoType, size_t * const freeSize, size_t * const totalSize)
{
    RT_LOG(RT_LOG_DEBUG, "mem get info memInfoType=%u, free=%zu, total=%zu.", memInfoType, *freeSize, *totalSize);
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    NULL_PTR_RETURN_MSG(curCtx, RT_ERROR_CONTEXT_NULL);

    return curCtx->Device_()->Driver_()->MemGetInfoEx(curCtx->Device_()->Id_(), memInfoType, freeSize,
        totalSize);
}

rtError_t ApiImpl::PointerGetAttributes(rtPointerAttributes_t * const attributes, const void * const ptr)
{
    RT_LOG(RT_LOG_DEBUG, "get memory attribute.");
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    Driver *curDrv = nullptr;

    if (!ContextManage::CheckContextIsValid(curCtx, true)) {
        curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    } else {
        const ContextProtect cp(curCtx);
        curDrv = curCtx->Device_()->Driver_();
    }
    return curDrv->PointerGetAttributes(attributes, ptr);
}

rtError_t ApiImpl::PtrGetAttributes(const void * const ptr, rtPtrAttributes_t * const attributes)
{
    RT_LOG(RT_LOG_DEBUG, "get memory attribute.");
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    Driver *curDrv = nullptr;
    if (!ContextManage::CheckContextIsValid(curCtx, true)) {
        curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    } else {
        const ContextProtect cp(curCtx);
        curDrv = curCtx->Device_()->Driver_();
    }
    rtError_t error = curDrv->PtrGetAttributes(ptr, attributes);
    ERROR_RETURN(error, "failed to PtrGetAttributes, err:%#x", static_cast<uint32_t>(error));
    rtMemLocationType locationType = attributes->location.type;
    if ((locationType == RT_MEMORY_LOC_DEVICE) || (locationType == RT_MEMORY_LOC_MANAGED)) {
        const uint32_t drvDeviceId = attributes->location.id;
        error = Runtime::Instance()->GetUserDevIdByDeviceId(drvDeviceId, &attributes->location.id);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Get drvDeviceId:%u is err:%#x",
            drvDeviceId, static_cast<uint32_t>(error));
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::MemPrefetchToDevice(const void * const devPtr, const uint64_t len, const int32_t devId)
{
    RT_LOG(RT_LOG_DEBUG, "memory prefetch to device, len=%" PRIu64 ", devId=%d.", len, devId);
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext(true, devId);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    return curCtx->Device_()->Driver_()->MemPrefetchToDevice(devPtr, len, devId);
}

rtError_t ApiImpl::GetDeviceIDs(uint32_t * const devId, const uint32_t len)
{
    TIMESTAMP_NAME(__func__);
    int32_t devCnt = 0;
    FacadeDriver &curDrv = Runtime::Instance()->FacadeDriver_();
    rtError_t error = curDrv.GetDeviceCount(&devCnt);
    ERROR_RETURN_MSG_INNER(error, "failed to GetDeviceCount, err:%#x.", static_cast<uint32_t>(error));

    COND_RETURN_WARN(devCnt <= 0, RT_ERROR_NONE, "No device found.");

    uint32_t *devices = new (std::nothrow) uint32_t[devCnt];
    NULL_PTR_RETURN_MSG(devices, RT_ERROR_MEMORY_ALLOCATION);

    error = curDrv.GetDeviceIDs(devices, static_cast<uint32_t>(devCnt));
    ERROR_PROC_RETURN_MSG_INNER(error, delete [] devices,
        "failed to GetDeviceIDs, err:%#x.", static_cast<uint32_t>(error));

    size_t retCnt = 0U;
    for (size_t i = 0U; i < static_cast<size_t>(devCnt); i++) {
        if (retCnt >= len) {
            break;
        }
        uint32_t realDeviceId = 0U;
        error = Runtime::Instance()->GetUserDevIdByDeviceId(devices[i], &realDeviceId, false, true);
        if (error != RT_ERROR_NONE) { continue; }
        devId[retCnt++] = realDeviceId;
    }

    delete [] devices;
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::OpenNetService(const rtNetServiceOpenArgs *args)
{
    const char *paramInfo = args->extParamList->paramInfo;
    std::string paramInfoStr = (paramInfo != nullptr) ? paramInfo : "";
    RT_LOG(RT_LOG_INFO, "OpenNetService begin. extParamCnt=%u, paramLen=%u, paramInfo=%s",
        args->extParamCnt, args->extParamList->paramLen, paramInfoStr.c_str());
    Runtime * const rt = Runtime::Instance();
    rtError_t error = rt->OpenNetService(args);
    ERROR_RETURN(error, "failed to open NetService, retCode:%#x", static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::CloseNetService()
{
    Runtime * const rt = Runtime::Instance();
    rtError_t error = rt->CloseNetService();
    ERROR_RETURN(error, "failed to close NetService, retCode:%#x", static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetDeviceCount(int32_t * const cnt)
{
    TIMESTAMP_NAME(__func__);
    if (!Runtime::Instance()->isSetVisibleDev) {
        FacadeDriver &curDrv = Runtime::Instance()->FacadeDriver_();
        return curDrv.GetDeviceCount(cnt);
    }

    rtError_t error = RT_ERROR_NONE;
    switch (Runtime::Instance()->retType) {
        case RT_ALL_DATA_OK:
            *cnt = static_cast<int32_t>(Runtime::Instance()->userDeviceCnt);
            break;
        case RT_GET_DRIVER_ERROR:
            DRV_ERROR_PROCESS(DRV_ERROR_NO_DEVICE, "[drv api] drvGetDevNum failed: drvRetCode=%d!",
                static_cast<int32_t>(DRV_ERROR_NO_DEVICE));
            error = RT_GET_DRV_ERRCODE(DRV_ERROR_NO_DEVICE);
            break;
        case RT_ALL_DUPLICATED_ERROR:
            RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE2002, Runtime::Instance()->inputDeviceStr, "ASCEND_RT_VISIBLE_DEVICES",
                "cannot be duplicated");
            error = RT_ERROR_DRV_NO_DEVICE;
            break;
        case RT_ALL_ORDER_ERROR:
            RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE2002, Runtime::Instance()->inputDeviceStr, "ASCEND_RT_VISIBLE_DEVICES",
                "configured in ascending order");
            error = RT_ERROR_DRV_NO_DEVICE;
            break;
        case RT_ALL_DATA_ERROR:
            RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE2002, Runtime::Instance()->inputDeviceStr, "ASCEND_RT_VISIBLE_DEVICES",
                "[0, " + std::to_string(Runtime::Instance()->deviceCnt) + ")");
            error = RT_ERROR_DRV_NO_DEVICE;
            break;
        default:
            break;
    }
    return error;
}

rtError_t ApiImpl::SetDevice(const int32_t devId)
{
    RT_LOG(RT_LOG_INFO, "drv devId=%d.", devId);
    TIMESTAMP_NAME(__func__);

    Runtime * const rt = Runtime::Instance();
    RefObject<Context *> *context = nullptr;
    context = rt->PrimaryContextRetain(static_cast<uint32_t>(devId));
    NULL_PTR_RETURN_MSG(context, RT_ERROR_DEVICE_RETAIN);

    RT_LOG(RT_LOG_INFO, "SetCurRef = %p,drv devId=%u", context->GetVal(), devId);
    InnerThreadLocalContainer::SetCurRef(context);
    DeviceStateCallbackManager::Instance().Notify(static_cast<uint32_t>(devId), true, DEV_CB_POS_BACK, RT_DEVICE_STATE_SET_POST);
    RT_LOG(RT_LOG_INFO, "New device success, deviceId=%d.", devId);

    Context * const curCtx = context->GetVal();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    NULL_PTR_RETURN_MSG(curCtx->DefaultStream_(), RT_ERROR_CONTEXT_DEFAULT_STREAM_NULL);
    curCtx->Device_()->SetSatMode(Runtime::Instance()->GetSatMode());

    InnerThreadLocalContainer::SetCurCtx(nullptr);
    (void)ThreadLocalContainer::GetOrCreateWatchDogHandle();

    RT_LOG(RT_LOG_INFO, "SetDevice success, curCtx=%p, drv devId=%u.", curCtx, devId);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetDevice(int32_t * const devId)
{
    Context * const curCtx = Runtime::Instance()->CurrentContext();
    const bool flag = ContextManage::CheckContextIsValid(curCtx, true);
    if (!flag) {
        Runtime *rtInstance = Runtime::Instance();
        if (rtInstance->GetSetDefaultDevIdFlag()) {
            const uint32_t drvDeviceId = rtInstance->GetDefaultDeviceId();
            uint32_t deviceId = 0U;
            const rtError_t error = Runtime::Instance()->GetUserDevIdByDeviceId(drvDeviceId, &deviceId);
            COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Get drvDeviceId:%u is err:%#x", drvDeviceId,
                static_cast<uint32_t>(error));
            *devId = static_cast<int32_t>(deviceId);
            return RT_ERROR_NONE;
        }
        return RT_ERROR_CONTEXT_NULL;
    }
    const ContextProtect cp(curCtx);

    const uint32_t drvDeviceId = curCtx->Device_()->Id_();
    uint32_t deviceId;
    rtError_t error = Runtime::Instance()->GetUserDevIdByDeviceId(drvDeviceId, &deviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Get drvDeviceId:%u is err:%#x", drvDeviceId, static_cast<uint32_t>(error));
    *devId = static_cast<int32_t>(deviceId);

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetDevicePhyIdByIndex(const uint32_t devIndex, uint32_t * const phyId)
{
    // the api use before setdevice, so it do not need context
    RT_LOG(RT_LOG_INFO, "get PhyId by Index=%u.", devIndex);
    TIMESTAMP_NAME(__func__);

    return NpuDriver::DeviceGetPhyIdByIndex(devIndex, phyId);
}

rtError_t ApiImpl::GetDeviceIndexByPhyId(const uint32_t phyId, uint32_t * const devIndex)
{
    // the api use before setdevice, so it do not need context
    RT_LOG(RT_LOG_INFO, "get Index by PhyId=%u.", phyId);
    TIMESTAMP_NAME(__func__);
    COND_RETURN_ERROR(CheckCurCtxValid(static_cast<int32_t>(phyId)) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, phyId[%d].", phyId);
    rtError_t error = NpuDriver::DeviceGetIndexByPhyId(phyId, devIndex);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "get device id failed, retCode=%#x.", static_cast<uint32_t>(error));
    return error;
}

rtError_t ApiImpl::EnableP2P(const uint32_t devIdDes, const uint32_t phyIdSrc, const uint32_t flag)
{
    RT_LOG(RT_LOG_INFO, "Enable P2P drv devId=%u, phyIdSrc=%u.", devIdDes, phyIdSrc);
    TIMESTAMP_NAME(__func__);
    return NpuDriver::EnableP2P(devIdDes, phyIdSrc, flag);
}

rtError_t ApiImpl::DisableP2P(const uint32_t devIdDes, const uint32_t phyIdSrc)
{
    RT_LOG(RT_LOG_INFO, "Disable P2P drv devId=%u, phyIdSrc=%u.", devIdDes, phyIdSrc);
    TIMESTAMP_NAME(__func__);
    return NpuDriver::DisableP2P(devIdDes, phyIdSrc);
}

rtError_t ApiImpl::DeviceCanAccessPeer(int32_t * const canAccessPeer, const uint32_t devId, const uint32_t peerDevice)
{
    RT_LOG(RT_LOG_INFO, "DeviceCanAccessPeer drv devId=%u, peerDevice=%u.", devId, peerDevice);
    TIMESTAMP_NAME(__func__);
    const Runtime * const rtInstance = Runtime::Instance();
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_DEVICE_P2P)) {
        UNUSED(devId);
        UNUSED(peerDevice);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    const rtRunMode runMode = static_cast<rtRunMode>(NpuDriver::RtGetRunMode());
    if (runMode == RT_RUN_MODE_OFFLINE) {
        RT_LOG(RT_LOG_ERROR, "feature not support in offline, drv devId=%u, peer=%u", devId, peerDevice);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    COND_RETURN_ERROR(CheckCurCtxValid(static_cast<int32_t>(devId)) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%lu].", devId);
    return NpuDriver::DeviceCanAccessPeer(canAccessPeer, devId, peerDevice);
}

rtError_t ApiImpl::GetP2PStatus(const uint32_t devIdDes, const uint32_t phyIdSrc, uint32_t * const status)
{
    RT_LOG(RT_LOG_INFO, "drv devId=%u, phyIdSrc=%u.", devIdDes, phyIdSrc);
    TIMESTAMP_NAME(__func__);
    COND_RETURN_ERROR(CheckCurCtxValid(static_cast<int32_t>(devIdDes)) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%lu].", devIdDes);
    return NpuDriver::GetP2PStatus(devIdDes, phyIdSrc, status);
}

rtError_t ApiImpl::DeviceGetBareTgid(uint32_t * const pid)
{
    TIMESTAMP_NAME(__func__);
    Driver* const curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);
    return curDrv->DeviceGetBareTgid(pid);
}
TIMESTAMP_EXTERN(MemCopySync_drv);
TIMESTAMP_EXTERN(halMemcpy2D);
TIMESTAMP_EXTERN(rtNotifyDestroy);
TIMESTAMP_EXTERN(rtMemset);
TIMESTAMP_EXTERN(MemCopy2D);
TIMESTAMP_EXTERN(halMemcpy2D);
TIMESTAMP_EXTERN(halResourceIdFree);
TIMESTAMP_EXTERN(LoadInputOutputArgsHuge);
TIMESTAMP_EXTERN(TaskResManage_LoadInputOutputArgs);
void ApiImpl::DumpTimeStampPart1() const
{
    TIMESTAMP_DUMP(rtKernelLaunch);
    TIMESTAMP_DUMP(rtKernelLaunchWithFlagV2);
    TIMESTAMP_DUMP(rtKernelLaunchWithHandle);
    TIMESTAMP_DUMP(rtKernelLaunchWithHandleV2);
    TIMESTAMP_DUMP(rtKernelLaunch_SubmitTask);
    TIMESTAMP_DUMP(rtKernelLaunch_PutProgram);
    TIMESTAMP_DUMP(PopTask);
    TIMESTAMP_DUMP(ReportReceive);
    TIMESTAMP_DUMP(ArgRelease);
    TIMESTAMP_DUMP(GetRecycleTask);
    TIMESTAMP_DUMP(KernelTaskCompleteOther);
    TIMESTAMP_DUMP(ObserverFinished);
    TIMESTAMP_DUMP(ReportRelease);
    TIMESTAMP_DUMP(AllocTaskAndSendDc);
    TIMESTAMP_DUMP(AllocTaskAndSendStars);
    TIMESTAMP_DUMP(TaskRecycle);
    TIMESTAMP_DUMP(TryRecycleTaskV1);
    TIMESTAMP_DUMP(TaskRes_AllocTask);
    TIMESTAMP_DUMP(TaskRes_AllocTaskNormal);
    TIMESTAMP_DUMP(TaskSendLimitedV1);
    TIMESTAMP_DUMP(TryTaskReclaimV1);
    TIMESTAMP_DUMP(SaveTaskInfo);
    TIMESTAMP_DUMP(HalfEventProcV1);
    TIMESTAMP_DUMP(ToCommandV1);
    TIMESTAMP_DUMP(CommandOccupyNormalV1);
    TIMESTAMP_DUMP(CommandOccupyV1);
    TIMESTAMP_DUMP(CommandSendV1);
    TIMESTAMP_DUMP(SqTaskSendNormalV1);
    TIMESTAMP_DUMP(SqTaskSendV1);
    TIMESTAMP_DUMP(AicoreLoad);
    TIMESTAMP_DUMP(AicpuLoad);
    TIMESTAMP_DUMP(ProcessPublicTask);
    TIMESTAMP_DUMP(FftsPlusTaskH2Dcpy);
    TIMESTAMP_DUMP(FftsPlusTaskAlloc);
    TIMESTAMP_DUMP(FftsPlusTaskInit);
    TIMESTAMP_DUMP(TaskResManage_LoadInputOutputArgs);
    TIMESTAMP_DUMP(rtCalcLaunchArgsSize);
    TIMESTAMP_DUMP(LoadInputOutputArgsHuge);
    TIMESTAMP_DUMP(rtAppendLaunchAddrInfo);
    TIMESTAMP_DUMP(rtAppendLaunchHostInfo);
    TIMESTAMP_DUMP(rtKernelLaunch_ArgLoad);
    TIMESTAMP_DUMP(rtKernelLaunch_ArgLoad_Lite);
    TIMESTAMP_DUMP(rtKernelLaunch_ArgLoadForMix);
    TIMESTAMP_DUMP(rtKernelLaunch_ArgLoadAll);
    TIMESTAMP_DUMP(rtKernelLaunch_ArgLoadAll_LITE);
    TIMESTAMP_DUMP(rtKernelLaunch_ArgLoadAllForMix);
    TIMESTAMP_DUMP(rtKernelLaunchWithHandle_SubMit);
    TIMESTAMP_DUMP(rtLaunchKernel_ArgLoadAll_LITE);
    TIMESTAMP_DUMP(rtLaunchKernel_SubMit);
    TIMESTAMP_DUMP(rtBinaryLoad_DevMemAlloc);
    TIMESTAMP_DUMP(rtBinaryLoad_MemCopySync);
    TIMESTAMP_DUMP(rtKernelLaunch_MemCopyAsync);
    TIMESTAMP_DUMP(rtKernelLaunch_MemCopyAsync_HostCpy);
    TIMESTAMP_DUMP(rtKernelLaunch_MemCopyAsync_DmaFind);
    TIMESTAMP_DUMP(rtKernelLaunch_MemCopyPcie);
    TIMESTAMP_DUMP(rtKernelLaunch_CpuArgLoad);
    TIMESTAMP_DUMP(rtKernelLaunch_WaitAsyncCopyComplete);
    TIMESTAMP_DUMP(rtKernelLaunch_KernelLookup);
    TIMESTAMP_DUMP(rtKernelLaunch_ALLKernelLookup);
    TIMESTAMP_DUMP(rtKernelLaunch_GetModule);
    TIMESTAMP_DUMP(rtKernelLaunch_AllocTask);
    TIMESTAMP_DUMP(QueryCqShmData);
    TIMESTAMP_DUMP(ObserverSubmitted);
    TIMESTAMP_DUMP(TryRecycleTask);
    TIMESTAMP_DUMP(TaskSendLimited);
    TIMESTAMP_DUMP(CommandOccupyNormal);
    TIMESTAMP_DUMP(CommandOccupy);
    TIMESTAMP_DUMP(ToCommand);
    TIMESTAMP_DUMP(CommandSend);
    TIMESTAMP_DUMP(ObserverLaunched);
    TIMESTAMP_DUMP(Engine_ProcessTaskWait);
    TIMESTAMP_DUMP(SqTaskSend);
    TIMESTAMP_DUMP(HalfEventProc);
    TIMESTAMP_DUMP(BatchDelDavinciRecordedTask);
    TIMESTAMP_DUMP(rtMemset);
    TIMESTAMP_DUMP(drvMemsetD8);
    TIMESTAMP_DUMP(MemCopy2D);
    TIMESTAMP_DUMP(halMemcpy2D);
    TIMESTAMP_DUMP(rtNotifyDestroy);
    TIMESTAMP_DUMP(halResourceIdFree);
    TIMESTAMP_DUMP(rtBinaryUnLoad_DevMemRelease);
    TIMESTAMP_DUMP(MemoryPoolManagerRelease);
    TIMESTAMP_DUMP(ModuleDevMemFree);
    TIMESTAMP_DUMP(ReleaseMemoryPoolManager);
    TIMESTAMP_DUMP(rtMallocCached);
    TIMESTAMP_DUMP(rtFree_drvMemUnLock_drvMemFreeManaged);
    TIMESTAMP_DUMP(rtDvppMalloc);
    TIMESTAMP_DUMP(rtDvppFree);
    TIMESTAMP_DUMP(rtMallocHost);
    TIMESTAMP_DUMP(rtsMallocHost);
    TIMESTAMP_DUMP(rtFreeHost);
    TIMESTAMP_DUMP(rtsFreeHost);
    TIMESTAMP_DUMP(rtReduceAsyncV2_part1);
    TIMESTAMP_DUMP(rtReduceAsyncV2_part2);
    TIMESTAMP_DUMP(rtReduceAsync_part1);
    TIMESTAMP_DUMP(rtReduceAsync_part2);
    TIMESTAMP_DUMP(rtMalloc);
    TIMESTAMP_DUMP(rtMemAllocManaged);
    TIMESTAMP_DUMP(rtMemFreeManaged);
    TIMESTAMP_DUMP(rtMemcpy);
    TIMESTAMP_DUMP(rtsMemcpy);
    TIMESTAMP_DUMP(rtsMemcpyBatch);
    TIMESTAMP_DUMP(MemCopySync_drv);
    TIMESTAMP_DUMP(rtMemcpy2D);
    TIMESTAMP_DUMP(ModuleMemAlloc);
    TIMESTAMP_DUMP(ModuleMemCpy);
    TIMESTAMP_DUMP(PushTask);
}

void ApiImpl::DumpTimeStampPart2() const
{
    TIMESTAMP_DUMP(rtStreamCreate);
    TIMESTAMP_DUMP(rtStreamCreate_drvMemAllocL2buffAddr);
    TIMESTAMP_DUMP(rtStreamCreate_taskPublicBuff);
    TIMESTAMP_DUMP(rtStreamCreate_AllocLogicCq);
    TIMESTAMP_DUMP(rtStreamCreate_AllocStreamSqCq);
    TIMESTAMP_DUMP(rtStreamCreate_SubmitCreateStreamTask);
    TIMESTAMP_DUMP(rtStreamCreate_drvStreamIdAlloc);
    TIMESTAMP_DUMP(rtStreamCreate_drvMemAllocHugePageManaged_drvMemAllocManaged_drvMemAdvise);
    TIMESTAMP_DUMP(rtStreamCreate_drvMemcpy);
    TIMESTAMP_DUMP(rtStreamCreate_drvDeviceGetBareTgid);
    TIMESTAMP_DUMP(rtStreamDestroy_drvMemReleaseL2buffAddr);
    TIMESTAMP_DUMP(rtStreamDestroy_drvMemFreeManaged);
    TIMESTAMP_DUMP(rtStreamDestroy_drvStreamIdFree);
    TIMESTAMP_DUMP(rtStreamDestroy_drvMemFreeManaged_arg);
    TIMESTAMP_DUMP(rtMemcpyAsyncWithCfg);
    TIMESTAMP_DUMP(rtMemcpyAsync_drvDeviceGetTransWay);
    TIMESTAMP_DUMP(rtMemcpyAsync_drvMemConvertAddr);
    TIMESTAMP_DUMP(rtMemcpyAsync_drvMemDestroyAddr);
    TIMESTAMP_DUMP(rtMemcpyHostTask_MemCopyAsync);
    TIMESTAMP_DUMP(rtMemcpy2DAsync);
    TIMESTAMP_DUMP(rtStreamDestroy);
    TIMESTAMP_DUMP(rtMemcpyAsync);
    TIMESTAMP_DUMP(rtsMemcpyAsync);
    TIMESTAMP_DUMP(rtMemcpyAsyncV2);
    TIMESTAMP_DUMP(rtMemcpyAsyncEx);
    TIMESTAMP_DUMP(rtsSetMemcpyDesc);
    TIMESTAMP_DUMP(rtsMemcpyAsyncWithDesc);
    TIMESTAMP_DUMP(CmoAddrTaskLaunch);
    TIMESTAMP_DUMP(CmoTaskLaunch);
    TIMESTAMP_DUMP(rtNotifyCreate);
    TIMESTAMP_DUMP(rtNotifyCreateWithFlag);
    TIMESTAMP_DUMP(rtKernelConfigTransArg);
    TIMESTAMP_DUMP(RecycleProcessDavinciList);
    TIMESTAMP_DUMP(rtStreamSynchronize);
    TIMESTAMP_DUMP(rtStreamSynchronizeWithTimeout);
    TIMESTAMP_DUMP(rtEventCreate);
    TIMESTAMP_DUMP(rtEventDestroy);
    TIMESTAMP_DUMP(rtEventRecord);
    TIMESTAMP_DUMP(rtEventReset);
    TIMESTAMP_DUMP(rtEventSynchronize);
    TIMESTAMP_DUMP(rtHostRegisterV2);
 	TIMESTAMP_DUMP(rtHostGetDevicePointer);
}

rtError_t ApiImpl::DeviceReset(const int32_t devId, const bool isForceReset)
{
    RT_LOG(RT_LOG_INFO, "Reset device, drv devId=%d.", devId);
    TIMESTAMP_NAME(__func__);
    Runtime * const rt = Runtime::Instance();
    rtError_t ret = rt->PrimaryContextRelease(static_cast<uint32_t>(devId), isForceReset);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "DeviceReset context release failed, drv devId=%d, retCode=%#x", devId, ret);
    }

    TIMESTAMP_BEGIN(TIMESTAMPs_DUMP);
    DumpTimeStampPart1();
    DumpTimeStampPart2();
    TIMESTAMP_END(TIMESTAMPs_DUMP);

    InnerThreadLocalContainer::SetTsId(static_cast<uint32_t>(RT_TSC_ID));
    RT_LOG(RT_LOG_INFO, "Succ, drv devId=%d.", devId);
    return ret;
}

rtError_t ApiImpl::DeviceSetLimit(const int32_t devId, const rtLimitType_t type, const uint32_t val)
{
    RT_LOG(RT_LOG_INFO, "Set Limit, drv devId=%d, type=%d, value=%u.", devId, type, val);
    (void)devId;
    TIMESTAMP_NAME(__func__);
    rtError_t ret = RT_ERROR_NONE;
    if (type == RT_LIMIT_TYPE_STACK_SIZE) {
        Runtime *rt = Runtime::Instance();
        rt->SetDeviceCustomerStackSize(val);
    } else {
        Context *const curCtx = CurrentContext(true, devId);
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        Device *const dev = curCtx->Device_();
        ret = dev->DevSetLimit(type, val);
    }
    return ret;
}

rtError_t ApiImpl::DeviceGetStreamPriorityRange(int32_t * const leastPriority, int32_t * const greatestPriority)
{
    if (leastPriority != nullptr) {
        *leastPriority = RT_STREAM_LEAST_PRIORITY;
    }

    if (greatestPriority != nullptr) {
        *greatestPriority = RT_STREAM_GREATEST_PRIORITY;
    }
    
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::StarsV2GetGroupAccNum(const int32_t moduleType, const int32_t infoType,
    int64_t * const val)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_PROC_RETURN(curCtx, RT_ERROR_CONTEXT_NULL,);
    Device * const dev = curCtx->Device_();
    const uint8_t groupId = dev->GetGroupId();
    // vf scene
    if (groupId != UNINIT_GROUP_ID) {
        rtGroupInfo_t groupInfo = {};
        const rtError_t error = dev->GetGroupInfo(static_cast<int32_t>(groupId), &groupInfo, 1);
        COND_RETURN_ERROR(error != RT_ERROR_NONE, RT_ERROR_GROUP_BASE,
            "Get group info failed, groupId=%u.", groupId);
        if ((moduleType == MODULE_TYPE_AICORE) && (infoType == INFO_TYPE_CORE_NUM)) {
            *val = static_cast<int64_t>(groupInfo.aicoreNum);
            RT_LOG(RT_LOG_INFO, "groupId=%u, aic core cnt is %lld.", groupId, *val);
            return RT_ERROR_NONE;
        }
        
        if ((moduleType == MODULE_TYPE_VECTOR_CORE) && (infoType == INFO_TYPE_CORE_NUM)) {
            *val = static_cast<int64_t>(groupInfo.aivectorNum);
            RT_LOG(RT_LOG_INFO, "groupId=%u, aiv core cnt is %lld.", groupId, *val);
            return RT_ERROR_NONE;
        }
    }
    return RT_ERROR_GROUP_NOT_CREATE;
}

rtError_t ApiImpl::GetDeviceInfo(const uint32_t deviceId, const int32_t moduleType, const int32_t infoType,
    int64_t * const val)
{
    RT_LOG(RT_LOG_INFO, "get device info, drv devId=%u", deviceId);
    rtError_t error = RT_ERROR_NONE;
    Runtime * const rt = Runtime::Instance();

    Driver* const curDrv =  rt->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);

    // want to return cube core num(=aicore num)
    if ((moduleType == MODULE_TYPE_AICORE) && (infoType == INFO_TYPE_CUBE_NUM)) {
        error = curDrv->GetDevInfo(deviceId, moduleType, INFO_TYPE_CORE_NUM, val);
        uint32_t temp = static_cast<uint32_t>(*val);
        if (curDrv->GetDevProperties().reduceAicNum && (temp == RT_AICORE_NUM_25)) {
            temp = RT_AICORE_NUM_25 - 1U;
        }
        *val = static_cast<int64_t>(temp);
        RT_LOG(RT_LOG_DEBUG, "moduleType= %d, infoType=%d, core cnt is %lld.", moduleType, infoType, *val);
        return error;
    }

    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_DEVICE_DOT_GET_GROUP_AIC_NUM)) {
        error = StarsV2GetGroupAccNum(moduleType, infoType, val);
        COND_RETURN_DEBUG(error == RT_ERROR_NONE, error,
            "moduleType= %d, core cnt is %lld.", moduleType, *val);
    }

    error = curDrv->GetDevInfo(deviceId, moduleType, infoType, val);
    uint32_t temp = static_cast<uint32_t>(*val);
    if (curDrv->GetDevProperties().reduceAicNum && (temp == RT_AICORE_NUM_25) &&
        (moduleType == MODULE_TYPE_AICORE) && (infoType == INFO_TYPE_CORE_NUM)) {
        temp = RT_AICORE_NUM_25 - 1U;
    }
    if (curDrv->GetDevProperties().reduceAicNum && (temp == RT_AICORE_NUM_25 * 2U) &&
        (moduleType == MODULE_TYPE_VECTOR_CORE) && (infoType == INFO_TYPE_CORE_NUM)) {
        temp = (RT_AICORE_NUM_25 - 1U) * 2U;
    }
    *val = static_cast<int64_t>(temp);
    RT_LOG(RT_LOG_DEBUG, "moduleType= %d, infoType=%d, core cnt is %lld.", moduleType, infoType, *val);

    return error;
}

rtError_t ApiImpl::GetDeviceSimtInfo(uint32_t deviceId, rtDevAttr attr, int64_t *val)
{
    UNUSED(deviceId);
    UNUSED(attr);
    *val = 0;
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetPhyDeviceInfo(const uint32_t phyId, const int32_t moduleType, const int32_t infoType,
    int64_t * const val)
{
    RT_LOG(RT_LOG_INFO, "get phy device info, phyId=%u", phyId);
    Driver* const curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);
    return curDrv->GetPhyDevInfo(phyId, moduleType, infoType, val);
}

rtError_t ApiImpl::DeviceSynchronize(const int32_t timeout)
{
    RT_LOG(RT_LOG_INFO, "device synchronize.");
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    return curCtx->Synchronize(timeout);
}

rtError_t ApiImpl::DeviceTaskAbort(const int32_t devId, const uint32_t timeout)
{
    RT_LOG(RT_LOG_INFO, "device task abort.");

    const rtError_t error = ContextManage::DeviceTaskAbort(devId, timeout);
    ERROR_RETURN(error, "Device task abort failed.");
    return error;
}

rtError_t ApiImpl::SnapShotProcessBackup()
{
    return ContextManage::SnapShotProcessBackup();
}

rtError_t ApiImpl::SnapShotProcessRestore()
{
    return ContextManage::SnapShotProcessRestore();
}

rtError_t ApiImpl::DeviceSetTsId(const uint32_t tsId)
{
    RT_LOG(RT_LOG_INFO, "Set TS Id, tsId=%u.", tsId);
    if ((InnerThreadLocalContainer::GetCurCtx() == nullptr) && (InnerThreadLocalContainer::GetCurRef() != nullptr)) {
        Runtime * const rt = Runtime::Instance();
        InnerThreadLocalContainer::SetCurRef(rt->GetRefPriCtx(0U, tsId));
    }

    InnerThreadLocalContainer::SetTsId(tsId);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::NewContext(const uint32_t deviceId, const uint32_t tsId, Context** const ctx) const
{
    Runtime * const rt = Runtime::Instance();

    Device * const dev = rt->DeviceRetain(deviceId, tsId);
    COND_RETURN_OUT_ERROR_MSG_CALL(dev == nullptr, RT_ERROR_DEVICE_NULL,
            "Failed to retain device, device_id=%u, ts_id=%u.", deviceId, tsId);

    Context *curCtx = new (std::nothrow) Context(dev, false);
    COND_RETURN_OUT_ERROR_MSG_CALL(curCtx == nullptr, RT_ERROR_CONTEXT_NEW,
            "Failed to new context, device_id=%u.", deviceId);
    RT_LOG(RT_LOG_INFO, "curCtx=%p, device_id=%d, ts_id=%u, Runtime_alloc_size %zu", curCtx, deviceId, tsId, sizeof(Context));
    rtError_t error = curCtx->Setup();
    ERROR_PROC_RETURN_MSG_INNER(error, DELETE_O(curCtx);, "Failed to setup context, retCode=%#x", static_cast<uint32_t>(error));

    *ctx = curCtx;
    return error;
}

rtError_t ApiImpl::ContextCreate(Context ** const inCtx, const int32_t devId)
{
    RT_LOG(RT_LOG_INFO, "drv devId=%d.", devId);
    Runtime * const rt = Runtime::Instance();
    rtError_t error = RT_ERROR_NONE;
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_DEVICE_GROUP_DOT_RECORD_GROUPINFO)) {
        procFlag.Set(true);
    }

    uint32_t tsId;
    int32_t devCnt = 0;
    Driver* const curDrv = rt->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);
    (void)curDrv->GetDeviceCount(&devCnt);
    COND_RETURN_ERROR_MSG_INNER((devId < 0) || (devId >= devCnt), RT_ERROR_DEVICE_ID,
        "Invalid drv devId, current drv devId=%d, valid drv devId range is [0, %d)", devId, devCnt);
    tsId = InnerThreadLocalContainer::GetTsId();

    error = NewContext(static_cast<uint32_t>(devId), tsId, inCtx);
    ERROR_RETURN_MSG_INNER(error, "new context failed, drv devId=%d, retCode=%#x", devId, static_cast<uint32_t>(error));

    ContextManage::InsertContext(*inCtx);
    error = ContextSetCurrent(*inCtx);
    ERROR_RETURN_MSG_INNER(error, "Failed to set current context, retCode=%#x", static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::ContextDestroy(Context * const inCtx)
{
    CHECK_CONTEXT_VALID_WITH_RETURN(inCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(inCtx->IsPrimary(), RT_ERROR_CONTEXT_NULL, "Can not destroy primary ctx.");
    COND_RETURN_ERROR_MSG_INNER(!inCtx->TearDownIsCanExecute(), RT_ERROR_CONTEXT_DEL, "Ctx is destroying.");

    /* first call back default stream, make sure that the slave stream is destroyed behind the mainstream */
    if (inCtx->Device_()->PrimaryStream_() != inCtx->DefaultStream_()) {
            StreamStateCallbackManager::Instance().Notify(inCtx->DefaultStream_(), false);
    }
    const rtError_t error = inCtx->TearDown();
    if (error != RT_ERROR_NONE) {
        inCtx->SetTearDownExecuteResult(TEARDOWN_ERROR);
        RT_LOG(RT_LOG_ERROR, "Context destroy failed, tear down failed, retCode=%#x", error);
        return error;
    }
    inCtx->SetTearDownExecuteResult(TEARDOWN_SUCCESS);
    if (ContextManage::EraseContextFromSet(inCtx) == RT_ERROR_CONTEXT_NULL) {
    }
    if (inCtx->ContextOutUse() == 0U) {
        delete inCtx;
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::ContextSetCurrent(Context * const inCtx)
{
    RT_LOG(RT_LOG_INFO, "set context=%p", inCtx);
    InnerThreadLocalContainer::SetCurCtx(inCtx);
    InnerThreadLocalContainer::SetCurRef(nullptr);  // must be null for context switch
    (void)ThreadLocalContainer::GetOrCreateWatchDogHandle();
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::ContextGetCurrent(Context ** const inCtx)
{
    // there is no need to check context which is valid.
    *inCtx = Runtime::Instance()->CurrentContext();
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::ContextGetDevice(int32_t * const devId)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    const uint32_t drvDeviceId = curCtx->Device_()->Id_();
    uint32_t deviceId;
    const rtError_t error = Runtime::Instance()->GetUserDevIdByDeviceId(drvDeviceId, &deviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "get drvDeviceId:%u is err:%#x", drvDeviceId, static_cast<uint32_t>(error));
    *devId = static_cast<int32_t>(deviceId);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::NameStream(Stream * const stm, const char_t * const name)
{
    UNUSED(stm);
    UNUSED(name);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::NameEvent(Event * const evt, const char_t * const name)
{
    UNUSED(evt);
    UNUSED(name);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::ProfilerStart(const uint64_t profConfig, const int32_t numsDev,
    uint32_t * const deviceList, const uint32_t cacheFlag, const uint64_t profSwitchHi)
{
    Runtime * const rtInstance = Runtime::Instance();
    return rtInstance->ProfilerStart(profConfig, numsDev, deviceList, cacheFlag, profSwitchHi);
}

rtError_t ApiImpl::ProfilerStop(
    const uint64_t profConfig, const int32_t numsDev, uint32_t *const deviceList, const uint64_t profSwitchHi)
{
    Runtime * const rtInstance = Runtime::Instance();

    return rtInstance->ProfilerStop(profConfig, numsDev, deviceList, profSwitchHi);
}

rtError_t ApiImpl::StartOnlineProf(Stream * const stm, const uint32_t sampleNum)
{
    if (stm != nullptr) {
        RT_LOG(RT_LOG_INFO, "start online profile task stream_id=%d, sample_num=%u", stm->Id_(), sampleNum);
    }

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Start online prof failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    return curCtx->StartOnlineProf(curStm, sampleNum);
}

rtError_t ApiImpl::StopOnlineProf(Stream * const stm)
{
    if (stm != nullptr) {
        RT_LOG(RT_LOG_INFO, "stop online profile task stream_id=%d", stm->Id_());
    }

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }

    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Stop online prof failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    return curCtx->StopOnlineProf(curStm);
}

rtError_t ApiImpl::GetOnlineProfData(Stream * const stm, rtProfDataInfo_t * const pProfData, const uint32_t profDataNum)
{
    if (stm != nullptr) {
        RT_LOG(RT_LOG_INFO, "get online profile data stream_id=%d, data_num=%u", stm->Id_(), profDataNum);
    }

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }

    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Get online prof data failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    return curCtx->GetOnlineProfData(curStm, pProfData, profDataNum);
}

rtError_t ApiImpl::AdcProfiler(const uint64_t addr, const uint32_t length)
{
    RT_LOG(RT_LOG_INFO, "addr=%#" PRIx64 ", length=%u.", addr, length);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream * const stm = curCtx->DefaultStream_();
    NULL_STREAM_PTR_RETURN_MSG(stm);
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Adc profiler run failed, stream is not in current ctx, stream_id=%d.", stm->Id_());
    return curCtx->AdcProfiler(stm, addr, length);
}

rtError_t ApiImpl::SetMsprofReporterCallback(const MsprofReporterCallback callback)
{
    RT_LOG(RT_LOG_INFO, "Set prof reporter callback.");
    ProfilingAgent::Instance().SetMsprofReporterCallback(callback);
    const Runtime * const rt = Runtime::Instance();
    const rtError_t error = rt->SetTsdProfCallback(callback);
    ERROR_RETURN(error, "Set msprof reporter callback failed.");
    return error;
}

rtError_t ApiImpl::ModelCreate(Model ** const mdl, const uint32_t flag)
{
    RT_LOG(RT_LOG_DEBUG, "model create, flag=%u.", flag);
    UNUSED(flag);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    return curCtx->ModelCreate(mdl);
}

rtError_t ApiImpl::ModelSetExtId(Model * const mdl, const uint32_t extId)
{
    RT_LOG(RT_LOG_DEBUG, "model set extend id to aicpu, modelId=%u, id=%u.", mdl->Id_(), extId);
    const rtError_t error = mdl->AicpuModelSetExtId(mdl->Id_(), extId);
    ERROR_RETURN(error, "Set model extId failed, modelId=%u, extId=%#x.", mdl->Id_(), extId);
    return error;
}

rtError_t ApiImpl::ModelDestroy(Model * const mdl)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_ERROR_MSG_INNER(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT,
        "Model is not in current ctx.");
    return curCtx->ModelDestroy(mdl);
}

rtError_t ApiImpl::ModelBindStream(Model * const mdl, Stream * const stm, const uint32_t flag)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_ERROR_MSG_INNER(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT,
        "Model bind to stream failed, model is not in current ctx.");

    return curCtx->ModelBindStream(mdl, stm, flag);
}

rtError_t ApiImpl::ModelUnbindStream(Model * const mdl, Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_ERROR_MSG_INNER(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT,
        "Model unbind to stream failed, model is not in current ctx.");

    return curCtx->ModelUnbindStream(mdl, stm);
}

rtError_t ApiImpl::ModelLoadComplete(Model * const mdl)
{
    if (mdl != nullptr) {
        RT_LOG(RT_LOG_INFO, "model load complete, mdl_id=%u.", mdl->Id_());
    }
    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_MODEL_NULL);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_ERROR_MSG_INNER(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT,
        "Kernel launch failed, model is not in current ctx.");

    return curCtx->ModelLoadComplete(mdl);
}

rtError_t ApiImpl::ModelExecute(Model * const mdl, Stream * const stm, const uint32_t flag, int32_t timeout)
{
    UNUSED(flag);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_ERROR_MSG_INNER(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT,
        "Model execute failed, model is not in current ctx.");

    return mdl->Execute(stm, timeout);
}

rtError_t ApiImpl::ModelExecuteSync(Model * const mdl, int32_t timeout)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_ERROR_MSG_INNER(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT,
        "Model execute failed, model is not in current ctx.");

    return mdl->ExecuteSync(timeout);
}

rtError_t ApiImpl::ModelExecuteAsync(Model * const mdl, Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_ERROR_MSG_INNER(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT,
        "Model execute failed, model is not in current ctx.");

    return mdl->ExecuteAsync(stm);
}

rtError_t ApiImpl::ModelGetTaskId(Model * const mdl, uint32_t * const taskId, uint32_t * const streamId)
{
    *taskId = mdl->LastTaskId_();
    *streamId = mdl->LastStreamId_();
    RT_LOG(RT_LOG_DEBUG, "model_id=%u, get stream_id=%u task_id=%u.", mdl->Id_(), *streamId, *taskId);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::ModelGetId(Model * const mdl, uint32_t * const modelId)
{
    *modelId = mdl->Id_();
    RT_LOG(RT_LOG_DEBUG, "get model_id=%u", *modelId);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::ModelEndGraph(Model * const mdl, Stream * const stm, const uint32_t flags)
{
    RT_LOG(RT_LOG_DEBUG, "model add end graph task model_id=%u, stream_id=%d, flags=%u",
            mdl->Id_(), stm->Id_(), flags);

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Model end graph run failed, stream is not in current ctx, stream_id=%d.", stm->Id_());
    COND_RETURN_ERROR_MSG_INNER(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT,
        "Model end graph run failed, model is not in current ctx.");

    if ((flags & RT_KERNEL_DUMPFLAG) != 0U) {
        // adc: kernel dump depend on aicpu sd
        ERROR_RETURN_MSG_INNER(Runtime::Instance()->StartAicpuSd(curCtx->Device_()),
            "Model end graph with kernel dump flag failed, check and start tsd open aicpu sd error.");
    }
    return curCtx->ModelAddEndGraph(mdl, stm, flags);
}

rtError_t ApiImpl::ModelExecutorSet(Model * const mdl, const uint8_t flags)
{
    RT_LOG(RT_LOG_INFO, "model executor set, mode_id=%u, flags=%hhu", mdl->Id_(), flags);

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT,
        "Model executor set failed, stream is not in current ctx.");
    Runtime * const rtInstance = Runtime::Instance();
    COND_RETURN_ERROR_MSG_INNER(rtInstance == nullptr, RT_ERROR_INSTANCE_NULL, "Runtime instance is null");
    ERROR_RETURN_MSG_INNER(rtInstance->StartAicpuSd(curCtx->Device_()),
        "Model executor set failed, check and start tsd open aicpu sd error.");
    return curCtx->ModelExecutorSet(mdl, flags);
}

rtError_t ApiImpl::ModelAbort(Model * const mdl)
{
    if (mdl != nullptr) {
        RT_LOG(RT_LOG_INFO, "model abort, mode_id=%u", mdl->Id_());
    }

    NULL_PTR_RETURN_MSG_OUTER(mdl, RT_ERROR_MODEL_NULL);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT,
        "Model abort run failed, stream is not in current ctx.");
    Device * const dev = curCtx->Device_();
    if (mdl->GetModelExecutorType() == EXECUTOR_TS) {
        if (dev->GetTschVersion() < static_cast<uint32_t>(TS_VERSION_TS_MODEL_ABORT)) {
            RT_LOG(RT_LOG_ERROR, "Ts model can not be abort in current driver version");
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
        if (!IS_SUPPORT_CHIP_FEATURE(dev->GetChipType(), RtOptionalFeatureType::RT_FEATURE_MODEL_ABORT)) {
            RT_LOG(RT_LOG_ERROR, "feature not supported. Ts model can not be abort in current device");
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
    }

    return curCtx->ModelAbort(mdl);
}

rtError_t ApiImpl::ModelExit(Model * const mdl, Stream * const stm)
{
    RT_LOG(RT_LOG_INFO, "model add model exit task mode_id=%u, stream_id=%d.", mdl->Id_(), stm->Id_());

    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Model exit run failed, stream is not in current ctx, stream_id=%d.", stm->Id_());
    COND_RETURN_ERROR_MSG_INNER(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT,
        "Model exit run failed, stream is not in current ctx.");

    return curCtx->ModelExit(mdl, stm);
}


rtError_t ApiImpl::ModelBindQueue(Model * const mdl, const uint32_t queueId, const rtModelQueueFlag_t flag)
{
    RT_LOG(RT_LOG_INFO, "model bind queue. modelId=%u, queueId=%u, flag=%d", mdl->Id_(), queueId, flag);

    const rtError_t error = AiCpuTaskSupportCheck();
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT,
        "Model bind queue failed, stream is not in current ctx.");

    Runtime * const rtInstance = Runtime::Instance();
    COND_RETURN_ERROR_MSG_INNER(rtInstance == nullptr, RT_ERROR_INSTANCE_NULL, "Runtime instance is null");
    ERROR_RETURN_MSG_INNER(rtInstance->StartAicpuSd(curCtx->Device_()),
        "Model bind queue failed, check and start tsd open aicpu sd error.");

    return curCtx->ModelBindQueue(mdl, queueId, flag);
}

rtError_t ApiImpl::DebugRegister(Model * const mdl, const uint32_t flag, const void * const addr,
    uint32_t * const streamId, uint32_t * const taskId)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_ERROR_MSG_INNER(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT,
        "Debug register failed, stream is not in current ctx.");

    return curCtx->DebugRegister(mdl, flag, addr, streamId, taskId);
}

rtError_t ApiImpl::DebugUnRegister(Model * const mdl)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_ERROR_MSG_INNER(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT,
        "Debug unregister failed, stream is not in current ctx.");

    return curCtx->DebugUnRegister(mdl);
}

rtError_t ApiImpl::DebugRegisterForStream(Stream * const stm, const uint32_t flag, const void * const addr,
                                          uint32_t * const streamId, uint32_t * const taskId)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "stream is not in current ctx");
    return curCtx->DebugRegisterForStream(stm, flag, addr, streamId, taskId);
}

rtError_t ApiImpl::DebugUnRegisterForStream(Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Stream is not in current ctx");

    return curCtx->DebugUnRegisterForStream(stm);
}

rtError_t ApiImpl::ModelSetSchGroupId(Model * const mdl, const int16_t schGrpId)
{
    RT_LOG(RT_LOG_INFO, "ModelSetSchGroupId, schGrpId=%hd.", schGrpId);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    if (!curCtx->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_SCHED_GROUP)) {
        RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1005);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    COND_RETURN_ERROR_MSG_INNER(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT,
        "SetSchGroupId failed, model is not in current ctx.");
    mdl->SetSchGroupId(schGrpId);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetModelTaskUpdateIsSupport(const int32_t deviceId, int32_t * const val)
{
    UNUSED(deviceId);
    Context * const curCtx = CurrentContext(true, deviceId);

    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    *val = static_cast<int32_t>(RT_DEV_CAP_NOT_SUPPORT);
    Device * const dev = curCtx->Device_();
    const rtChipType_t chipType = dev->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_TILING_KEY_SINK)) {
        RT_LOG(RT_LOG_INFO, "chipType = %u", static_cast<uint32_t>(chipType));
        return RT_ERROR_NONE;
    }

    const uint32_t tschVersion = dev->GetTschVersion();
    const bool isSupport =  dev->CheckFeatureSupport(TS_FEATURE_TILING_KEY_SINK);
    if (isSupport) {
        *val = RT_DEV_CAP_SUPPORT;
    }

    RT_LOG(RT_LOG_INFO, "chipType = %u,TsVersion=%u,*val=%d",
           static_cast<uint32_t>(chipType), tschVersion, *val);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::ModelTaskUpdate(Stream *desStm, uint32_t desTaskId, Stream *sinkStm,
                                   rtMdlTaskUpdateInfo_t *para)
{
    RT_LOG(RT_LOG_INFO, "ModelTaskUpdate, desStm=%d.desTaskId=%u,sinkStm=%d", desStm->Id_(), desTaskId, sinkStm->Id_());
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    return curCtx->ModelTaskUpdate(desStm, desTaskId, sinkStm, para);
}

rtError_t ApiImpl::SetExceptCallback(const rtErrorCallback callback)
{
    RT_LOG(RT_LOG_INFO, "set exception callback.");
    const rtError_t error = Runtime::Instance()->SetExceptCallback(callback);
    ERROR_RETURN(error, "Set except callback failed.");
    return error;
}

rtError_t ApiImpl::SetTaskAbortCallBack(const char_t *regName, void *callback, void *args,
    TaskAbortCallbackType type)
{
    RT_LOG(RT_LOG_INFO, "set task abort callback.");
    const rtError_t error = Runtime::Instance()->SetTaskAbortCallBack(regName, callback, args, type);
    ERROR_RETURN(error, "Set task abort callback failed, regName=%s.", regName);
    return error;
}

rtError_t ApiImpl::SetTaskFailCallback(void *callback, void *args, TaskFailCallbackType type)
{
    constexpr const char_t *regName = "_DEFAULT_MODEL_NAME_";
    return TaskFailCallBackReg(regName, callback, args, type);
}

rtError_t ApiImpl::RegTaskFailCallbackByModule(const char_t *regName, void *callback, void *args,
    TaskFailCallbackType type)
{
    return TaskFailCallBackReg(regName, callback, args, type);
}

rtError_t ApiImpl::RegDeviceStateCallback(const char_t *regName, void *callback, void *args,
    DeviceStateCallback type, rtDevCallBackDir_t notifyPos)
{
    RT_LOG(RT_LOG_INFO, "Reg device state callback, regName=%s.", regName);
    const rtError_t error = DeviceStateCallbackManager::Instance().RegDeviceStateCallback(regName, callback, args, type, notifyPos);
    ERROR_RETURN(error, "Register device state callback failed, regName=%s.", regName);
    return error;
}

rtError_t ApiImpl::RegProfCtrlCallback(const uint32_t moduleId, const rtProfCtrlHandle callback)
{
    RT_LOG(RT_LOG_INFO, "Reg profiling callback, moduleId=%u.", moduleId);
    const rtError_t error = ProfCtrlCallbackManager::Instance().RegProfCtrlCallback(moduleId, callback);
    ERROR_RETURN(error, "Register profiling callback failed, moduleId=%u.", moduleId);
    return error;
}

rtError_t ApiImpl::GetL2CacheOffset(uint32_t deviceId, uint64_t *offset)
{
    RT_LOG(RT_LOG_DEBUG, "Get l2cache offset.");
    Context * const curCtx = CurrentContext(true, deviceId);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Driver * const curDrv = curCtx->Device_()->Driver_();

    return curDrv->GetL2CacheOffset(deviceId, offset);
}

rtError_t ApiImpl::IpcSetMemoryName(
    const void *const ptr, const uint64_t byteCount, char_t *const name, const uint32_t len, const uint64_t flags)
{
    Context *const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    const Runtime *const rtInstance = Runtime::Instance();
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!curCtx->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_IPC_MEMORY)) {
        RT_LOG(RT_LOG_WARNING, "chipType=%d does not support, return.", chipType);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    auto error = curCtx->Device_()->Driver_()->CreateIpcMem(ptr, byteCount, name, len);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    if ((flags & RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION) != 0UL) {
        error = curCtx->Device_()->Driver_()->SetIpcMemAttr(
            name, SHMEM_ATTR_TYPE_NO_WLIST_IN_SERVER, SHMEM_NO_WLIST_ENABLE);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    }
    RT_LOG(RT_LOG_DEBUG, "Name=%s, byteCount=%" PRIu64 ", len=%u, flags=%#" PRIx64 ".", name, byteCount, len, flags);
    return error;
}

rtError_t ApiImpl::IpcSetMemoryAttr(const char *name, uint32_t type, uint64_t attr)
{
    RT_LOG(RT_LOG_DEBUG, "Set ipc memory attribute. name=%s, type=%u, attr=%" PRIx64 ".", name, type, attr);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    const bool isNewChip = (curCtx->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_NON_UNIFIED_ADDR) && 
        g_isAddrFlatDevice);
    if (isNewChip) {
        return curCtx->Device_()->Driver_()->SetIpcMemAttr(name, type, attr);
    }

    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::NopTask(Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    const uint32_t ver = curCtx->Device_()->GetTschVersion();
    COND_RETURN_ERROR_MSG_INNER(ver < static_cast<uint32_t>(TS_VERSION_NOP_TASK),
        RT_ERROR_FEATURE_NOT_SUPPORT, "Can not support nop task. ver=%u", ver);
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Add nop task failed, stream is not in current ctx, stream_id=%d.", stm->Id_());

    return curCtx->NopTask(stm);
}

rtError_t ApiImpl::IpcOpenMemory(void ** const ptr, const char_t * const name, const uint64_t flags)
{
    RT_LOG(RT_LOG_INFO, "Open ipc memory, name=%s, flags=%#" PRIx64 ".", name, flags);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    
    if (!curCtx->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_IPC_MEMORY)) {
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    rtError_t error = RT_ERROR_NONE;
    Device* const dev = curCtx->Device_();
    if ((flags & RT_IPC_MEM_IMPORT_FLAG_ENABLE_PEER_ACCESS) != 0UL) {
        uint32_t peerPhyDeviceId = 0U;
        error = NpuDriver::GetPhyDevIdByIpcMemName(name, &peerPhyDeviceId);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
        error = dev->EnableP2PWithOtherDevice(peerPhyDeviceId);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    }

    error = dev->Driver_()->OpenIpcMem(name, RtPtrToPtr<uint64_t *>(ptr), curCtx->Device_()->Id_());
    return error;
}

rtError_t ApiImpl::IpcCloseMemory(const void * const ptr)
{
    RT_LOG(RT_LOG_DEBUG, "Start close ipc memory.");
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    if (!curCtx->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_IPC_MEMORY)) {
        RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1005);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    return curCtx->Device_()->Driver_()->CloseIpcMem(static_cast<uint64_t>(reinterpret_cast<uintptr_t>(ptr)));
}

rtError_t ApiImpl::IpcCloseMemoryByName(const char_t * const name)
{
    RT_LOG(RT_LOG_DEBUG, "start close ipc memory, name=%s.", name);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Runtime * const rtInstance = Runtime::Instance();
    std::unordered_map<uint64_t, ipcMemInfo_t> &ipcMemNameMap = rtInstance->GetIpcMemNameMap();
    const std::string ipcName(name);
    for (auto &pairMap : ipcMemNameMap) {
        if (pairMap.second.name == ipcName) {
            return curCtx->Device_()->Driver_()->CloseIpcMem(pairMap.first);
        }
    }
    RT_LOG(RT_LOG_DEBUG, "destroy ipc memory by IpcDestroyMemoryName, name=%s.", name);
    return curCtx->Device_()->Driver_()->DestroyIpcMem(name);
}

rtError_t ApiImpl::IpcDestroyMemoryName(const char_t * const name)
{
    RT_LOG(RT_LOG_DEBUG, "Destroy ipc memory. name=%s.", name);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    if (!curCtx->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_IPC_MEMORY)) {
        RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1005);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    return curCtx->Device_()->Driver_()->DestroyIpcMem(name);
}

rtError_t ApiImpl::SetIpcNotifyPid(const char_t * const name, int32_t pid[], const int32_t num)
{
    RT_LOG(RT_LOG_DEBUG, "Set ipc notify pid. name=%s.", name);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    if (!curCtx->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_IPC_MEMORY)) {
        RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1005);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    return curCtx->Device_()->Driver_()->SetIpcNotifyPid(name, pid, num);
}

rtError_t ApiImpl::SetIpcMemPid(const char_t * const name, int32_t pid[], const int32_t num)
{
    RT_LOG(RT_LOG_DEBUG, "Set ipc mem pid. name=%s.", name);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    if (!curCtx->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_IPC_MEMORY)) {
        RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1005);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    return curCtx->Device_()->Driver_()->SetIpcMemPid(name, pid, num);
}

rtError_t ApiImpl::GetAiCoreCount(uint32_t * const aiCoreCnt)
{
    const Runtime * const rt = Runtime::Instance();
    if (!rt->HaveDevice()) {
        RT_LOG(RT_LOG_WARNING, "Aicore count cannot be gotten in no device scenarios.");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    Context * const curCtx = CurrentContext();
    int64_t val = 0;
    rtError_t error = RT_ERROR_NONE;
    uint32_t curDrvDeviceId = RT_DEV_ZERO;

    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_DEVICE_DOT_GET_GROUP_AIC_NUM)) {
        error = StarsV2GetGroupAccNum(static_cast<int32_t>(MODULE_TYPE_AICORE),
            static_cast<int32_t>(INFO_TYPE_CORE_NUM), &val);
        if (error == RT_ERROR_NONE) {
            *aiCoreCnt = static_cast<uint32_t>(val);
            RT_LOG(RT_LOG_DEBUG, "aicore cnt is %u.", *aiCoreCnt);
            return RT_ERROR_NONE;
        }
    }

    if (ContextManage::CheckContextIsValid(curCtx, true)) {
        const ContextProtect cp(curCtx);
        curDrvDeviceId = curCtx->Device_()->Id_();
    }
    Driver* const curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);
    error = curDrv->GetDevInfo(curDrvDeviceId, static_cast<int32_t>(MODULE_TYPE_AICORE),
        static_cast<int32_t>(INFO_TYPE_CORE_NUM), &val);
    if (error != RT_ERROR_NONE) {
        return error;
    }

    if ((val < 0) || (val > static_cast<int64_t>(UINT32_MAX))) {
        error = RT_ERROR_DRV_ERR;
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "Get aicore cnt failed, cnt=%" PRId64 " is out of range[0, %#x]",
                         val, UINT32_MAX);
    } else {
        *aiCoreCnt = static_cast<uint32_t>(val);
        if (curDrv->GetDevProperties().reduceAicNum && (*aiCoreCnt == RT_AICORE_NUM_25)) {
            *aiCoreCnt = RT_AICORE_NUM_25 - 1U;
        } else {
            RT_LOG(RT_LOG_DEBUG, "it is not belong to 910B1.");
        }
        RT_LOG(RT_LOG_DEBUG, "aicore cnt is %u.", *aiCoreCnt);
    }
    return error;
}

rtError_t ApiImpl::GetAiCpuCount(uint32_t * const aiCpuCnt)
{
    const Runtime * const rt = Runtime::Instance();
    if (!rt->HaveDevice()) {
        RT_LOG(RT_LOG_WARNING, "Aicpu count cannot be gotten in offline or no device scenarios.");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    int64_t val = 0;
    Context * const curContext = CurrentContext();
    uint32_t deviceId = RT_DEV_ZERO;
    if (ContextManage::CheckContextIsValid(curContext, true)) {
        const ContextProtect cp(curContext);
        deviceId = curContext->Device_()->Id_();
    }

    Driver* const curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);
    rtError_t error = curDrv->GetDevInfo(deviceId, static_cast<int32_t>(MODULE_TYPE_AICPU),
        static_cast<int32_t>(INFO_TYPE_CORE_NUM), &val);
    if (error != RT_ERROR_NONE) {
        return error;
    }

    if ((val < 0) || (val > static_cast<int64_t>(UINT32_MAX))) {
        error = RT_ERROR_DRV_ERR;
        RT_LOG_OUTER_MSG_INVALID_PARAM(val, "[0, " + std::to_string(static_cast<int64_t>(UINT32_MAX)) + "]");
    } else {
        *aiCpuCnt = static_cast<uint32_t>(val);
    }
    return error;
}

rtError_t ApiImpl::NotifyCreate(const int32_t deviceId, Notify ** const retNotify, uint64_t flag)
{
    RT_LOG(RT_LOG_INFO, "Notify create.");
    Context * const curCtx = CurrentContext(true, deviceId);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    COND_RETURN_ERROR(dev == nullptr, RT_ERROR_INVALID_VALUE, "device is NULL.");

    if (flag == RT_NOTIFY_MC2) {
        const bool isMc2SupportHccl = CheckSupportMC2Feature(dev);
        if (!isMc2SupportHccl) {
            RT_LOG(RT_LOG_WARNING, "Current ts version[%u] does not support create coprocessor notify.",
                dev->GetTschVersion());
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
    }

    *retNotify = new (std::nothrow) Notify(static_cast<uint32_t>(deviceId), dev->DevGetTsId());
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, *retNotify == nullptr, RT_ERROR_NOTIFY_NEW,
                                "Notify create failed, new notify failed.");

    (*retNotify)->SetNotifyFlag(static_cast<uint32_t>(flag));
    rtError_t error = (*retNotify)->Setup();
    ERROR_PROC_RETURN_MSG_INNER(error, DELETE_O(*retNotify);,
                                "Notify create failed, setup failed, drv devId=%d, retCode=%#x", deviceId, static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::NotifyDestroy(Notify * const inNotify)
{
    RT_LOG(RT_LOG_INFO, "Notify destroy.");
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    delete inNotify;
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::NotifyRecord(Notify * const inNotify, Stream * const stm)
{
    RT_LOG(RT_LOG_INFO, "Notify record.");
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }

    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
                                "Notify record failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    const uint32_t notifyId = inNotify->GetNotifyId();
    const rtError_t error = inNotify->Record(curStm);
    ERROR_RETURN_MSG_INNER(error, "Notify record failed, notifyId=%u, retCode=%#x.",
                            notifyId, static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::NotifyReset(Notify * const inNotify)
{
    RT_LOG(RT_LOG_INFO, "notify reset.");
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Stream *curStm = curCtx->DefaultStream_();
    NULL_STREAM_PTR_RETURN_MSG(curStm);

    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
                                "Notify reset failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    Device * const dev = curCtx->Device_();
    if (!dev->IsStarsPlatform()) {
        RT_LOG(RT_LOG_ERROR, "feature support only in stars platform");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    if (!dev->CheckFeatureSupport(TS_FEATURE_MC2_ENHANCE)) {
        RT_LOG(RT_LOG_ERROR, "feature not support because tsch version too low");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    const uint32_t notifyId = inNotify->GetNotifyId();
    const rtError_t error = inNotify->Reset(curStm);
    ERROR_RETURN_MSG_INNER(error, "Notify reset failed, notifyId=%u, retCode=%#x",
                           notifyId, static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::ResourceClean(int32_t devId, rtIdType_t type)
{
    RT_LOG(RT_LOG_INFO, "resource clean.");
    UNUSED(type);
    rtError_t error = RT_ERROR_NONE;
    Context * const curCtx = CurrentContext(false, devId);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    if (!curCtx->Device_()->CheckFeatureSupport(TS_FEATURE_TASK_ABORT)) {
        RT_LOG(RT_LOG_WARNING, "feature not support because tsch version too low");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    Driver * const curDrv = curCtx->Device_()->Driver_();
    for (uint32_t tsId = 0; tsId < Runtime::Instance()->GetTsNum(); tsId++) {
        error = curDrv->ResourceReset(devId, tsId, DRV_NOTIFY_ID);
        ERROR_RETURN_MSG_INNER(error, "Resource Clean failed, tsId=%u, retCode=%#x", tsId, static_cast<uint32_t>(error));
    }
    return error;
}

rtError_t ApiImpl::NotifyWait(Notify * const inNotify, Stream * const stm, const uint32_t timeOut)
{
    RT_LOG(RT_LOG_INFO, "notify wait, timeout=%us.", timeOut);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }

    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx,
        RT_ERROR_STREAM_CONTEXT,
        "Notify wait failed, stream is not in current ctx, stream_id=%d.",
        curStm->Id_());
    COND_RETURN_ERROR_MSG_INNER(inNotify->CheckIpcNotifyDevId() != RT_ERROR_NONE,
        RT_ERROR_INVALID_VALUE,
        "Notify wait failed, ipc notify can not notify wait.");

    uint32_t timeOutTmp = timeOut;
    if (!IS_SUPPORT_CHIP_FEATURE(dev->GetChipType(), RtOptionalFeatureType::RT_FEATURE_NOTIFY_WAIT) &&
        (dev->GetTschVersion() < static_cast<uint32_t>(TS_VERSION_WAIT_TIMEOUT_DC))) {
        timeOutTmp = 0U;
    }
    const rtError_t error = NtyWait(inNotify, curStm, timeOutTmp);
    const uint32_t notify_id = inNotify->GetNotifyId();
    ERROR_RETURN_MSG_INNER(error, "Notify wait failed, notify_id=%u, time_out = %u, retCode=%#x.",
        notify_id, timeOutTmp, static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetNotifyID(Notify * const inNotify, uint32_t * const notifyID)
{
    RT_LOG(RT_LOG_INFO, "Get notify id.");
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    *notifyID = inNotify->GetNotifyId();

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetNotifyPhyInfo(Notify *const inNotify, rtNotifyPhyInfo *notifyInfo)
{
    RT_LOG(RT_LOG_INFO, "get phy info.");
    if (inNotify == nullptr) {
        RT_LOG(RT_LOG_INFO, "inNotify is nullptr.");
        RT_LOG(RT_LOG_ERROR, "Get pyh info failed.");
        return RT_ERROR_NOTIFY_NULL;
    }
    notifyInfo->phyId = inNotify->GetPhyDevId();
    notifyInfo->tsId = inNotify->GetTsId();
    notifyInfo->shrId = inNotify->GetNotifyId();
    notifyInfo->idType = SHR_ID_NOTIFY_TYPE;
    notifyInfo->flag = (inNotify->IsPod() ? TSDRV_FLAG_SHR_ID_SHADOW : 0U);
    RT_LOG(RT_LOG_INFO, "notify_id=%u, phyId=%u flag=0x%x.", notifyInfo->shrId, notifyInfo->phyId, notifyInfo->flag);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::IpcSetNotifyName(Notify * const inNotify, char_t * const name, const uint32_t len, const uint64_t flag)
{
    RT_LOG(RT_LOG_INFO, "IpcSetNotifyName, name=%s, len=%u, flag=%#" PRIx64 ".", name, len, flag);
    const uint32_t notify_id = inNotify->GetNotifyId();
    rtError_t error = inNotify->CreateIpcNotify(name, len);
    ERROR_RETURN_MSG_INNER(
        error, "Ipc notify set name failed, notify_id=%u, retCode=%#x", notify_id, static_cast<uint32_t>(error));

    if ((flag & RT_NOTIFY_EXPORT_FLAG_DISABLE_PID_VALIDATION ) != 0UL) {
        error = NpuDriver::SetIpcNotifyDisablePidVerify(name);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::IpcOpenNotify(Notify ** const retNotify, const char_t * const name, uint32_t flag)
{
    RT_LOG(RT_LOG_INFO, "open ipc notify. name=%s, flag=%#x.", name, flag);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    COND_RETURN_ERROR(dev == nullptr, RT_ERROR_INVALID_VALUE, "device is NULL.");

    if ((flag & RT_NOTIFY_FLAG_DOWNLOAD_TO_DEV) != 0) {
        const bool isMc2SupportHccl = CheckSupportMC2Feature(dev);
        if (!isMc2SupportHccl) {
            RT_LOG(RT_LOG_WARNING, "Current ts version[%u] does not support ipc open coprocessor notify.",
                dev->GetTschVersion());
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
    }

    *retNotify = new (std::nothrow) Notify(0U, dev->DevGetTsId());
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, *retNotify == nullptr, RT_ERROR_NOTIFY_NEW,
                                "Ipc open notify failed, new notify failed.");

    rtError_t error = (*retNotify)->OpenIpcNotify(name, flag);
    ERROR_PROC_RETURN_MSG_INNER(error, DELETE_O(*retNotify);,
                                "Ipc open notify failed, retCode=%#x", static_cast<uint32_t>(error));

    if ((flag & RT_NOTIFY_IMPORT_FLAG_ENABLE_PEER_ACCESS) != 0UL) {
        uint32_t peerPhyDeviceId = 0U;
        error = NpuDriver::GetIpcNotifyPeerPhyDevId(name, &peerPhyDeviceId);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
        error = dev->EnableP2PWithOtherDevice(peerPhyDeviceId);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    }

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::NotifyGetAddrOffset(Notify * const inNotify, uint64_t * const devAddrOffset)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    const uint32_t notify_id = inNotify->GetNotifyId();
    const rtError_t error = inNotify->GetAddrOffset(devAddrOffset);
    ERROR_RETURN_MSG_INNER(error, "Notify get addr offset failed, notify_id=%u, retCode=%#x",
                            notify_id, static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::StreamSwitchEx(void * const ptr, const rtCondition_t condition, void * const valuePtr,
    Stream * const trueStream, Stream * const stm, const rtSwitchDataType_t dataType)
{
    RT_LOG(RT_LOG_DEBUG, "Switch, condition=%d, dataType=%d.", condition, dataType);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx,
        RT_ERROR_STREAM_CONTEXT,
        "Stream switch(extend) failed, stream is not in current ctx, stream_id=%d.",
        stm->Id_());
    COND_RETURN_ERROR_MSG_INNER(stm->GetModelNum() == 0, RT_ERROR_STREAM_MODEL, "Stream is not in model");
    COND_RETURN_ERROR_MSG_INNER(trueStream->GetModelNum() == 0, RT_ERROR_STREAM_MODEL,
                                "True stream is not in model");
    return curCtx->StreamSwitchEx(ptr, condition, valuePtr, trueStream, stm, dataType);
}

rtError_t ApiImpl::StreamSwitchN(void * const ptr, const uint32_t size, void * const valuePtr,
    Stream ** const trueStreamPtr, const uint32_t elementSize, Stream * const stm, const rtSwitchDataType_t dataType)
{
    RT_LOG(RT_LOG_DEBUG, "SwitchN, size=%u, elementSize=%u, dataType=%d.", size, elementSize, dataType);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    for (uint32_t i = 0U; i < elementSize; i++) {
        NULL_PTR_RETURN_MSG_OUTER(trueStreamPtr[i], RT_ERROR_STREAM_NULL);
        COND_RETURN_ERROR_MSG_INNER(trueStreamPtr[i]->GetModelNum() == 0, RT_ERROR_STREAM_MODEL,
                                    "true_stream[%u] is not in model.", i);
    }

    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
                                "Stream switchN failed, stream is not in current ctx, stream_id=%d.", stm->Id_());
    COND_RETURN_ERROR_MSG_INNER(stm->GetModelNum() == 0, RT_ERROR_STREAM_MODEL,
                                "Stream is not in model");
    return curCtx->StreamSwitchN(ptr, size, valuePtr, trueStreamPtr, elementSize, stm, dataType);
}


rtError_t ApiImpl::StreamActive(Stream * const activeStream, Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(stm->GetModelNum() == 0, RT_ERROR_STREAM_MODEL,
                                "Stream is not in model");
    COND_RETURN_ERROR_MSG_INNER(activeStream->GetModelNum() == 0, RT_ERROR_STREAM_MODEL,
                                "Active stream is not in model");
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
                                "Stream active failed, stream is not in current ctx, stream_id=%d.", stm->Id_());

    return curCtx->StreamActive(activeStream, stm);
}

rtError_t ApiImpl::LabelCreate(Label ** const lbl, Model * const mdl)
{
    RT_LOG(RT_LOG_INFO, "label create.");
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER((mdl != nullptr) && (mdl->Context_() != curCtx), RT_ERROR_MODEL_CONTEXT,
                                "Label create failed, stream is not in current ctx.");

    return curCtx->LabelCreate(lbl, mdl);
}

rtError_t ApiImpl::LabelDestroy(Label * const lbl)
{
    RT_LOG(RT_LOG_INFO, "label destroy.");
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_ERROR_MSG_INNER(lbl->Context_() != curCtx, RT_ERROR_LABEL_CONTEXT,
                                "Label is not in current ctx");
    return curCtx->LabelDestroy(lbl);
}

rtError_t ApiImpl::LabelSet(Label * const lbl, Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(lbl->Context_() != curCtx, RT_ERROR_LABEL_CONTEXT,
                                "Label is not in current ctx");

    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
                                "Label set failed, stream is not in current ctx, stream_id=%d.", stm->Id_());

    return lbl->Set(stm);
}

rtError_t ApiImpl::LabelGoto(Label * const lbl, Stream * const stm)
{
    RT_LOG(RT_LOG_DEBUG, "label goto.");
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(lbl->Context_() != curCtx, RT_ERROR_LABEL_CONTEXT,
                                "Label is not in current ctx");

    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
                                "Label goto failed, stream is not in current ctx, stream_id=%d.", stm->Id_());

    const uint32_t ver = curCtx->Device_()->GetTschVersion();
#ifndef CFG_DEV_PLATFORM_PC
    COND_RETURN_ERROR_MSG_INNER(ver >= TS_VERSION_MORE_LABEL, RT_ERROR_FEATURE_NOT_SUPPORT,
                                "Can not support old label goto for 64k label.");
#endif
    return lbl->Goto(stm);
}

rtError_t ApiImpl::ProfilerTrace(const uint64_t id, const bool notifyFlag, const uint32_t flags, Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
                                "Profiler trace failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    return curCtx->ProfilerTrace(id, notifyFlag, flags, curStm);
}

rtError_t ApiImpl::ProfilerTraceEx(const uint64_t id, const uint64_t modelId, const uint16_t tagId, Stream *stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    if (stm == nullptr) {
        stm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(stm);
    }
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Profiler trace[extend] failed, stream is not in current ctx, stream_id=%d.", stm->Id_());

    return curCtx->ProfilerTraceEx(id, modelId, tagId, stm);
}

rtError_t ApiImpl::SubscribeReport(const uint64_t threadId, Stream * const stm)
{
    rtError_t ret = RT_ERROR_NONE;
    Stream *curStm = stm;
    if (curStm == nullptr) {
        Context * const curCtx = CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }

    Event *curEvent = nullptr;
    if (Runtime::Instance()->ChipIsHaveStars()) {
        ret = EventCreate(&curEvent, RT_EVENT_DDSYNC_NS);
        ERROR_RETURN(ret, "Call EventCreate failed for block callback, ret=%#x.", ret);
        ret = Runtime::Instance()->SubscribeReport(threadId, curStm, static_cast<void *>(curEvent));
        if (ret != RT_ERROR_NONE) {
            (void)EventDestroy(curEvent);
        }
        return ret;
    }

    return Runtime::Instance()->SubscribeReport(threadId, curStm, static_cast<void *>(curEvent));
}

rtError_t ApiImpl::CallbackLaunchWithEvent(const rtCallback_t callBackFunc, void * const fnData, Stream * const stm,
        const bool isBlock, Event ** const evt, const uint64_t threadId)
{
    rtError_t ret = RT_ERROR_NONE;
    Device * const dev = stm->Device_();
    TaskInfo submitTask = {};
    rtError_t errorReason;
    uint32_t curEventId = 0U;
    Event *curEvent = nullptr;
    Runtime * const rtInstance = Runtime::Instance();
    TaskInfo* rtCbLaunchTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_HOSTFUNC_CALLBACK, errorReason);
    NULL_PTR_RETURN_MSG(rtCbLaunchTask, errorReason);

    std::function<void()> const callbackTaskRecycle = [&dev, &rtCbLaunchTask]() {
        (void)dev->GetTaskFactory()->Recycle(rtCbLaunchTask);
    };
    ScopeGuard callbackTaskGuarder(callbackTaskRecycle);
    Stream * const launchStm = rtCbLaunchTask->stream;

    if ((stm->IsCapturing()) && (launchStm->GetSubscribeFlag() == StreamSubscribeFlag::SUBSCRIBE_NONE)) {
        ret = EventCreate(&curEvent, RT_EVENT_DDSYNC_NS);
        ERROR_RETURN(ret,
            "Create callback event failed, drv devId=%u, original stream_id=%d, capture stream_id=%d, retCode=%#x.",
            dev->Id_(), stm->Id_(), launchStm->Id_(), ret);
        if (threadId != MAX_UINT64_NUM) {
            ret = rtInstance->SubscribeCallback(threadId, launchStm, curEvent);
        } else {
            /* get thread id */
            uint64_t threadId = 0UL;
            ret = rtInstance->GetThreadIdByStreamId(dev->Id_(), stm->Id_(), &threadId);
            ERROR_RETURN(ret,
                "Get threadId by streamId failed, drv devId=%u, original stream_id=%d, "
                "capture stream_id=%d, retCode=%#x.", dev->Id_(), stm->Id_(), launchStm->Id_(), ret);
            ret = rtInstance->SubscribeReport(threadId, launchStm, curEvent);
        }          
        if (ret != RT_ERROR_NONE) {
            (void)EventDestroy(curEvent);
            return ret;
        }
        RT_LOG(RT_LOG_INFO, "Launched stream_id=%d, subscribeFlag=%d, original stream_id=%d, subscribeFlag=%d",
               launchStm->Id_(), static_cast<int>(launchStm->GetSubscribeFlag()), stm->Id_(),
               static_cast<int>(stm->GetSubscribeFlag()));
    } else {
        ret = rtInstance->GetEventByStreamId(dev->Id_(), stm->AllocTaskStreamId(), &curEvent);
        ERROR_RETURN(ret,
            "Get callback event failed, drv devId=%u, original stream_id=%d, launch stream_id=%d, retCode=%#x.",
            dev->Id_(), stm->Id_(), launchStm->Id_(), ret);
    }

    ret = curEvent->GetEventID(&curEventId);
    ERROR_RETURN(ret, "Call GetEventID failed for block callback, "
        "drv devId=%u, original stream_id=%d, launch stream_id=%d, retCode=%#x",
        dev->Id_(), stm->Id_(), launchStm->Id_(), ret);

    (void)CallbackLaunchTaskInit(rtCbLaunchTask, callBackFunc, fnData, isBlock, static_cast<int32_t>(curEventId));

    ret = dev->SubmitTask(rtCbLaunchTask, (stm->Context_())->TaskGenCallback_());
    ERROR_RETURN(ret, "Callback launch task submit failed, "
        "drv devId=%u, original stream_id=%d, launch stream_id=%d, retCode=%#x",
        dev->Id_(), stm->Id_(), launchStm->Id_(), ret);

    callbackTaskGuarder.ReleaseGuard();

    GET_THREAD_TASKID_AND_STREAMID(rtCbLaunchTask, stm->AllocTaskStreamId());
    *evt = curEvent;

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::CallbackLaunchWithoutEvent(const rtCallback_t callBackFunc, void * const fnData, Stream * const stm,
        const bool isBlock) const
{
    rtError_t ret = RT_ERROR_NONE;
    Device * const dev = stm->Device_();
    TaskInfo submitTask = {};
    rtError_t errorReason;
    Runtime * const rtInstance = Runtime::Instance();
    TaskInfo* rtCbLaunchTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_HOSTFUNC_CALLBACK, errorReason);
    NULL_PTR_RETURN_MSG(rtCbLaunchTask, errorReason);

    std::function<void()> const callbackTaskRecycle = [&dev, &rtCbLaunchTask]() {
        (void)dev->GetTaskFactory()->Recycle(rtCbLaunchTask);
    };
    ScopeGuard callbackTaskGuarder(callbackTaskRecycle);
    Stream * const launchStm = rtCbLaunchTask->stream;

    if ((stm->IsCapturing()) && (launchStm->GetSubscribeFlag() == StreamSubscribeFlag::SUBSCRIBE_NONE)) {
        /* get thread id */
        uint64_t threadId = 0UL;
        ret = rtInstance->GetThreadIdByStreamId(dev->Id_(), stm->Id_(), &threadId);
        ERROR_RETURN(ret,
            "Get threadId by streamId failed, drv devId=%u, original stream_id=%d, "
            "capture stream_id=%d, retCode=%#x.", dev->Id_(), stm->Id_(), launchStm->Id_(), ret);

        ret = (stm->GetSubscribeFlag() == StreamSubscribeFlag::SUBSCRIBE_RUNTIME) ?
                  rtInstance->SubscribeCallback(threadId, launchStm, nullptr) :
                  rtInstance->SubscribeReport(threadId, launchStm, nullptr);
        if (ret != RT_ERROR_NONE) {
            return ret;
        }
        RT_LOG(RT_LOG_INFO, "Launched stream_id=%d, subscribeFlag=%d, original stream_id=%d, subscribeFlag=%d",
               launchStm->Id_(), static_cast<int>(launchStm->GetSubscribeFlag()), stm->Id_(),
               static_cast<int>(stm->GetSubscribeFlag()));
    }

    (void)CallbackLaunchTaskInit(rtCbLaunchTask, callBackFunc, fnData, isBlock, INVALID_EVENT_ID);

    ret = dev->SubmitTask(rtCbLaunchTask, (stm->Context_())->TaskGenCallback_());
    ERROR_RETURN(ret, "Callback launch task submit failed, "
        "drv devId=%u, original stream_id=%d, launch stream_id=%d, retCode=%#x",
        dev->Id_(), stm->Id_(), launchStm->Id_(), ret);

    callbackTaskGuarder.ReleaseGuard();

    GET_THREAD_TASKID_AND_STREAMID(rtCbLaunchTask, stm->AllocTaskStreamId());

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::CallbackLaunch(const rtCallback_t callBackFunc, void * const fnData, Stream * const stm,
    const bool isBlock)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Callback launch failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());
    COND_RETURN_ERROR_MSG_INNER(!curStm->IsHostFuncCbReg(), RT_ERROR_STREAM_NO_CB_REG,
        "The stream used by this user's callback function is not registered to any thread, retCode=%#x",
        static_cast<uint32_t>(RT_ERROR_STREAM_NO_CB_REG));

    Runtime * const rt = Runtime::Instance();
    if (rt->ChipIsHaveStars() && isBlock) {
        return StarsLaunchEventProc(curStm, callBackFunc, fnData, MAX_UINT64_NUM);
    }

    return CallbackLaunchWithoutEvent(callBackFunc, fnData, curStm, isBlock);
}

rtError_t ApiImpl::ProcessReport(const int32_t timeout, const bool noLog)
{
    uint64_t cqidBit[HOST_CALLBACK_SQCQ_BIT / 64U] = {0UL};
    uint32_t deviceId = 0U;
    uint32_t tsId = 0U;
    uint32_t groupId = 0U;
    uint64_t bit = 0U;

    Runtime * const rt = Runtime::Instance();

    const uint64_t threadId = PidTidFetcher::GetCurrentUserTid();
    rtError_t ret = rt->GetGroupIdByThreadId(threadId, &deviceId, &tsId, &groupId, noLog);
    COND_RETURN_WARN((ret != RT_ERROR_NONE) && (!noLog), ret, "get groupId fail, threadIdentifier=%" PRIu64 ", retCode=%#x",
                     threadId, ret);
    COND_RETURN_WITH_NOLOG((ret != RT_ERROR_NONE) && (noLog), ret);
    rt->LockGroupId(groupId);
    std::function<void()> const func = [=]() { rt->UnlockGroupId(groupId); };
    const ScopeGuard groupIdGuarder(func);

    Context *priCtx = rt->GetPriCtxByDeviceId(deviceId, tsId);
    if (priCtx == nullptr) {
        priCtx = CurrentContext();
    }

    if (noLog) {
        CHECK_CONTEXT_VALID_WITH_PROC_RETURN(priCtx, RT_ERROR_CONTEXT_NULL,);
    } else {
        CHECK_CONTEXT_VALID_WITH_RETURN(priCtx, RT_ERROR_CONTEXT_NULL);
    }

    Device * const dev = priCtx->Device_();
    Driver * const curDrv = dev->Driver_();

    ret = curDrv->CqReportIrqWait(deviceId, tsId, groupId, timeout, &cqidBit[0], HOST_CALLBACK_SQCQ_BIT / 64U);
    COND_RETURN_WARN((ret != RT_ERROR_NONE) && (!noLog), ret, "CqReportIrqWait, retCode=%#x", ret);
    COND_RETURN_WITH_NOLOG((ret != RT_ERROR_NONE) && (noLog), ret);
    RT_LOG(RT_LOG_DEBUG, "IrqWait groupId=%u, threadIdentifier=%" PRIu64, groupId, threadId);

    // per uint64_t num has 64 bit
    for (uint32_t index = 0U; index < (HOST_CALLBACK_SQCQ_BIT / 64U); index++) {
        for (; ; RT_BITMAP_CLR(cqidBit[index], bit)) {
            bit = BitScan(cqidBit[index]);
            if (bit >= 64U) { // 64 bit for uint64_t
                break;
            }

            // left move 6 is multiply 64
            const uint32_t cqidValue = (index << 6U) + static_cast<uint32_t>(bit);
            uint32_t cnt = 0U;
            rtHostFuncCqReport_t *report = nullptr;
            ret = curDrv->CqReportGet(deviceId, tsId, cqidValue, &report, &cnt);
            if (unlikely((report == nullptr) || (cnt == 0U))) {
                continue;
            }
            RT_LOG(RT_LOG_DEBUG, "get report info num=%u from cqid = %u.", cnt, cqidValue);

            COND_RETURN_WARN((ret != RT_ERROR_NONE) && (!noLog), ret, "CqReportGet failed, retCode=%#x", ret);
            COND_RETURN_WITH_NOLOG((ret != RT_ERROR_NONE) && (noLog), ret);
            for (uint32_t idx = 0U; idx < cnt; idx++) {
                const rtCallback_t hostFunc =
                    reinterpret_cast<rtCallback_t>(static_cast<uintptr_t>(report[idx].hostFuncCbPtr));
                NULL_PTR_RETURN_MSG(hostFunc, RT_ERROR_DRV_REPORT);

                RT_LOG(RT_LOG_INFO, "report[%u], sqid=%hu, streamId=%hu, taskId=%hu, eventId=%hu, isBlock=%hhu",
                    idx, report[idx].sqId, report[idx].streamId, report[idx].taskId,
                    report[idx].eventId, report[idx].isBlock);

                (hostFunc)(reinterpret_cast<void *>(static_cast<uintptr_t>(report[idx].fnDataPtr)));
                if (report[idx].isBlock != 0) {
                    uint32_t sqId = 0U;
                    rtHostFuncCommand_t *command = nullptr;
                    (void)rt->GetSqIdByStreamId(deviceId, static_cast<int32_t>(report[idx].streamId), &sqId);
                    ret = curDrv->SqCommandOccupy(deviceId, tsId, sqId, &command, 1U);
                    ERROR_RETURN_MSG_INNER(ret, "SqCommandOccupy failed, sqId=%u, retCode=%#x", sqId, ret);
                    NULL_PTR_RETURN_MSG(command, RT_ERROR_DRV_COMMAND);
                    if (Runtime::Instance()->ChipIsHaveStars()) {
                        command->u.record_msg.cmdType = STARS_CALLBACK_EVENT_RECORD_CMDTYPE;
                        command->u.record_msg.streamId = report[idx].streamId;
                        command->u.record_msg.recordId = report[idx].eventId;
                        command->u.record_msg.taskId = report[idx].taskId;
                    } else {
                        command->u.sq_send_msg.SOP = 1U;
                        command->u.sq_send_msg.MOP = 0U;
                        command->u.sq_send_msg.EOP = 1U;
                        command->u.sq_send_msg.streamId = report[idx].streamId;
                        command->u.sq_send_msg.taskId = report[idx].taskId;
                        command->u.sq_send_msg.cqId = static_cast<uint16_t>(cqidValue);
                        command->u.sq_send_msg.cqTail = 0U;
                    }
                    ret = curDrv->SqCommandSend(deviceId, tsId, sqId, command, 1U);
                    ERROR_RETURN_MSG_INNER(ret, "SqCommandSend failed, sqId=%u, retCode=%#x", sqId, ret);
                }
                ret = curDrv->CqReportRelease(&report[idx], deviceId, cqidValue, tsId, noLog);
            }
        }
    }

    return ret;
}

rtError_t ApiImpl::UnSubscribeReport(const uint64_t threadId, Stream * const stm)
{
    Stream *curStm = stm;
    if (curStm == nullptr) {
        Context * const curCtx = CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }

    return Runtime::Instance()->UnSubscribeReport(threadId, curStm);
}

rtError_t ApiImpl::GetRunMode(rtRunMode * const runMode)
{
    // the api do not need context
    TIMESTAMP_NAME(__func__);
    const rtRunMode ret = static_cast<rtRunMode>(NpuDriver::RtGetRunMode());
    *runMode = (ret == RT_RUN_MODE_AICPU_SCHED) ? RT_RUN_MODE_OFFLINE : ret;
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::LabelSwitchByIndex(void * const ptr, const uint32_t maxVal, void * const labelInfoPtr,
    Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Label switch by index failed, stream is not in current ctx, stream_id=%d.", stm->Id_());
    COND_RETURN_ERROR_MSG_INNER(stm->GetModelNum() == 0, RT_ERROR_STREAM_MODEL,
        "stream is not in model");

    return curCtx->LabelSwitchByIndex(ptr, maxVal, labelInfoPtr, stm);
}

rtError_t ApiImpl::LabelGotoEx(Label * const lbl, Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Label goto(extend) failed, stream is not in current ctx, stream_id=%d.", stm->Id_());
    COND_RETURN_ERROR_MSG_INNER(lbl->Context_() != curCtx, RT_ERROR_LABEL_CONTEXT,
                                "Label is not in current ctx");

    const uint32_t ver = curCtx->Device_()->GetTschVersion();
#ifndef CFG_DEV_PLATFORM_PC
    COND_RETURN_ERROR_MSG_INNER(ver >= TS_VERSION_MORE_LABEL, RT_ERROR_FEATURE_NOT_SUPPORT,
        "Can not support old label goto for 64k label.");
#endif
    return lbl->StreamGoto(stm);
}

rtError_t ApiImpl::LabelListCpy(Label ** const lbl, const uint32_t labelNumber, void * const dst,
    const uint32_t dstMax)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    const Stream *stm = lbl[0]->Stream_();
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_LABEL_STREAM);

    const Model *mdl = stm->Model_();
    COND_RETURN_ERROR_MSG_INNER(mdl == nullptr, RT_ERROR_STREAM_MODEL,
                                "Model is nullptr, stream is not in model");

    const uint32_t modelId = mdl->Id_();

    for (uint32_t lbIdx = 0U; lbIdx < labelNumber; lbIdx++) {
        COND_RETURN_ERROR_MSG_INNER(lbl[lbIdx]->Context_() != curCtx, RT_ERROR_LABEL_CONTEXT,
                                    "Label[%u] is not in current ctx.", lbIdx);
        COND_RETURN_ERROR_MSG_INNER(lbl[lbIdx]->Stream_() == nullptr, RT_ERROR_LABEL_STREAM,
                                    "Label[%u] not set to stream.", lbIdx);
        COND_RETURN_ERROR_MSG_INNER(lbl[lbIdx]->Stream_()->Model_() == nullptr,
                                    RT_ERROR_LABEL_MODEL, "Label[%u] not in model.", lbIdx);

        stm = lbl[lbIdx]->Stream_();
        mdl = stm->Model_();
        COND_RETURN_ERROR_MSG_INNER(mdl->Id_() != modelId, RT_ERROR_LABEL_MODEL,
                                    "Label[%u] is not in same model, modelId=%u, error modelId=%u.",
                                    lbIdx, modelId, mdl->Id_());
    }

    return curCtx->LabelListCpy(lbl, labelNumber, dst, dstMax);
}

rtError_t ApiImpl::LabelCreateEx(Label ** const lbl, Model * const mdl, Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
                                "Label create(extend) failed, stream is not in current ctx, stream_id=%d.", stm->Id_());
    COND_RETURN_ERROR_MSG_INNER((mdl != nullptr) && (mdl->Context_() != curCtx), RT_ERROR_MODEL_CONTEXT,
                                "Model is not in current ctx");

    const rtError_t error = curCtx->LabelCreate(lbl, mdl);
    ERROR_RETURN_MSG_INNER(error, "Create label failed, retCode=%#x", static_cast<uint32_t>(error));
    NULL_PTR_RETURN_MSG(*lbl, error);
    return (*lbl)->SetStream(stm);
}

rtError_t ApiImpl::LabelSwitchListCreate(Label ** const labels, const size_t num, void ** const labelList)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    return curCtx->LabelSwitchListCreate(labels, num, labelList);
}

rtError_t ApiImpl::GetAicpuDeploy(rtAicpuDeployType_t * const deployType)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Device * const dev = curCtx->Device_();
    const uint32_t type = dev->Driver_()->GetAicpuDeploy();
    COND_RETURN_ERROR_MSG_INNER(type > AICPU_DEPLOY_RESERVED, RT_ERROR_DEVICE_DEPLOY,
                                "Get aicpu deploy failed, invalid deployType, current deployType=%u,"
                                " valid deployType range is [0, %d]",
                                type, AICPU_DEPLOY_RESERVED);
    *deployType = static_cast<rtAicpuDeployType_t>(type);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetPairDevicesInfo(const uint32_t devId, const uint32_t otherDevId, const int32_t infoType,
    int64_t * const val)
{
    TIMESTAMP_NAME(__func__);
    Driver * const curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);
    rtError_t ret = curDrv->GetPairDevicesInfo(devId, otherDevId, infoType, val);
    if (infoType == DEVS_INFO_TYPE_TOPOLOGY && *val == TOPOLOGY_HCCS_SW && devId == otherDevId) {
        *val = TOPOLOGY_HCCS;
    }

    return ret;
}

rtError_t ApiImpl::GetPairPhyDevicesInfo(const uint32_t devId, const uint32_t otherDevId, const int32_t infoType,
    int64_t * const val)
{
    Driver * const curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);
    const rtError_t ret = curDrv->GetPairDevicesInfo(devId, otherDevId, infoType, val, true);
    if (infoType == DEVS_INFO_TYPE_TOPOLOGY && *val == TOPOLOGY_HCCS_SW && devId == otherDevId) {
        *val = TOPOLOGY_HCCS;
    }
    return ret;
}

rtError_t ApiImpl::GetRtCapability(const rtFeatureType_t featureType, const int32_t featureInfo, int64_t * const val)
{
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    RT_LOG(RT_LOG_INFO, "GetRtCapability chip_type=%d", chipType);

    if ((featureType == FEATURE_TYPE_MEMCPY) && (featureInfo == static_cast<int32_t>(MEMCPY_INFO_SUPPORT_ZEROCOPY))) {
        *val = static_cast<int64_t>(RT_CAPABILITY_SUPPORT);
        return RT_ERROR_NONE;
    }

    DevProperties props;
    rtError_t error = GET_DEV_PROPERTIES(chipType, props);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE, "GetDevProperties fail");
    const auto getCapMethod = props.getCapabilityMethod;
    if ((featureType == FEATURE_TYPE_MEMORY) && (featureInfo == static_cast<int32_t>(MEMORY_INFO_TS_LIMITED))) {
        if (getCapMethod == GetCapabilityMethod::GET_CAPABILITY_NOT_SUPPORT) {
            *val = static_cast<int64_t>(RT_CAPABILITY_NOT_SUPPORT);
        } else if (getCapMethod == GetCapabilityMethod::GET_CAPABILITY_BY_FEATURE_CHECK) {
            *val = static_cast<int64_t>(RT_CAPABILITY_SUPPORT);
        } else {
            Driver * const curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
            NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);
            const bool isSupport = curDrv->CheckIfSupportNumaTs();
            *val = isSupport ?
                static_cast<int64_t>(RT_CAPABILITY_SUPPORT) : static_cast<int64_t>(RT_CAPABILITY_NOT_SUPPORT);
        }
        return RT_ERROR_NONE;
    }

    if ((featureType == FEATURE_TYPE_UPDATE_SQE) && (featureInfo == static_cast<int32_t>(UPDATE_SQE_SUPPORT_DSA))) {
        if (getCapMethod == GetCapabilityMethod::GET_CAPABILITY_BY_DRIVER_CHECK) {
            Driver * const curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
            NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);
            const bool isSupport = curDrv->CheckIfSupportDsaUpdate();
            *val = isSupport ?
                static_cast<int64_t>(RT_CAPABILITY_SUPPORT) : static_cast<int64_t>(RT_CAPABILITY_NOT_SUPPORT);
        } else {
            *val = static_cast<int64_t>(RT_CAPABILITY_NOT_SUPPORT);
        }
        return RT_ERROR_NONE;
    }
    return RT_ERROR_INVALID_VALUE;
}

rtError_t ApiImpl::SetGroup(const int32_t groupId)
{
    TIMESTAMP_NAME(__func__);
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_DEVICE_GROUP)) {
        RT_LOG(RT_LOG_ERROR, "Device group not support in chipType=%d", chipType);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    return dev->SetGroup(groupId);
}

rtError_t ApiImpl::GetGroupCount(uint32_t * const cnt)
{
    TIMESTAMP_NAME(__func__);
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_DEVICE_GROUP)) {
        RT_LOG(RT_LOG_ERROR, "Device group not support in chipType=%d", chipType);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    return dev->GetGroupCount(cnt);
}

rtError_t ApiImpl::GetGroupInfo(const int32_t groupId, rtGroupInfo_t * const groupInfo, const uint32_t cnt)
{
    TIMESTAMP_NAME(__func__);
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_DEVICE_GROUP)) {
        RT_LOG(RT_LOG_ERROR, "Device group not support in chipType=%d", chipType);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    return dev->GetGroupInfo(groupId, groupInfo, cnt);
}

rtError_t ApiImpl::ContextSetINFMode(const bool infMode)
{
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    curCtx->SetINFMode(infMode);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetScheduleType(const int32_t deviceId, int32_t * const val) const
{
    Device * const dev = Runtime::Instance()->GetDevice(static_cast<uint32_t>(deviceId),
        static_cast<uint32_t>(RT_TSC_ID));
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    const uint32_t ver = dev->GetTschVersion();
    int32_t schedule = 0;
    if (dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TS_SCHED_AICPU_MODE)) {
        if (ver >= static_cast<uint32_t>(TS_VERSION_SUPER_TASK_FOR_DVPP)) {
            schedule = static_cast<int32_t>(SCHEDULE_SOFTWARE_OPT);
        } else {
            schedule = static_cast<int32_t>(SCHEDULE_SOFTWARE);
        }
    } else {
        schedule = static_cast<int32_t>(SCHEDULE_HARDWARE);
    }
    *val = schedule;
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetBlockingOpIsSupport(const int32_t deviceId, int32_t * const val) const
{
    *val = static_cast<int32_t>(RT_AICPU_BLOCKING_OP_NOT_SUPPORT);
    Runtime * const rtInstance = Runtime::Instance();
    const bool isVirtualMode = rtInstance->IsVirtualMachineMode();
    Device * const dev = rtInstance->GetDevice(static_cast<uint32_t>(deviceId), static_cast<uint32_t>(RT_TSC_ID));
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    const uint32_t tschVersion = dev->GetTschVersion();
    if ((tschVersion >= static_cast<uint32_t>(TS_VERSION_AICPU_EVENT_RECORD)) && (!isVirtualMode)) {
        *val = RT_AICPU_BLOCKING_OP_SUPPORT;
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetFftsWorkMode(int32_t * const val)
{
    *val = static_cast<int32_t>(RT_MODE_NO_FFTS);
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_TASK_FFTS_PLUS)) {
        *val  = static_cast<int32_t>(RT_MODE_NO_FFTS);
    } else {
        int64_t fftsMode = 0;
        const rtError_t ret = GetDeviceInfo(RT_DEV_ZERO, static_cast<int32_t>(MODULE_TYPE_TSCPU),
            static_cast<int32_t>(INFO_TYPE_FFTS_TYPE), &fftsMode);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, ret != RT_ERROR_NONE, ret,
            "Call GetDeviceInfo failed: retCode=%d, module type=%d, info type=%d.",
            ret, MODULE_TYPE_TSCPU, INFO_TYPE_FFTS_TYPE);
        // drv query register info, 0 is ffts mode, 1 is ffts+, default is ffts+
        if (fftsMode == 0) {
            *val = static_cast<int32_t>(RT_MODE_FFTS);
        } else {
            *val = static_cast<int32_t>(RT_MODE_FFTS_PLUS);
        }
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetHostAicpuDeviceInfo(const uint32_t deviceId, const int32_t featureType,
                                          int32_t * const val)
{
    if ((featureType != static_cast<int32_t>(INFO_TYPE_CORE_NUM)) &&
        (featureType != static_cast<int32_t>(INFO_TYPE_FREQUE)) &&
        (featureType != static_cast<int32_t>(INFO_TYPE_WORK_MODE)))  {
        RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1006, "featureType=" + std::to_string(featureType));
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    int64_t hostAicpuNum = 0;
    const rtError_t ret = GetDeviceInfo(deviceId, static_cast<int32_t>(RT_MODULE_TYPE_HOST_AICPU),
                                        featureType, &hostAicpuNum);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "GetDeviceInfo failed for GetDeviceCapability, ret=%#x.", ret);
    RT_LOG(RT_LOG_INFO, "hostAicpuNum=%lld", hostAicpuNum);
    *val = static_cast<int32_t>(hostAicpuNum);

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetDeviceCapability(const int32_t deviceId, const int32_t moduleType, const int32_t featureType,
    int32_t * const val)
{
    RT_LOG(RT_LOG_DEBUG, "get feature info deviceId=%d, moduleType=%d, featureType=%d.",
        deviceId, moduleType, featureType);
    TIMESTAMP_NAME(__func__);
    COND_RETURN_ERROR(CheckCurCtxValid(deviceId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", deviceId);
    if ((featureType == static_cast<int32_t>(FEATURE_TYPE_SCHE)) &&
        (moduleType == static_cast<int32_t>(MODULE_TYPE_AICPU))) {
        return GetScheduleType(deviceId, val);
    } else if ((featureType == static_cast<int32_t>(FEATURE_TYPE_BLOCKING_OPERATOR)) &&
        (moduleType == static_cast<int32_t>(RT_MODULE_TYPE_AICPU))) {
        return GetBlockingOpIsSupport(deviceId, val);
    } else if ((featureType == static_cast<int32_t>(FEATURE_TYPE_FFTS_MODE)) &&
        (moduleType == static_cast<int32_t>(RT_MODULE_TYPE_TSCPU))) {
        return GetFftsWorkMode(val);
    } else if ((featureType == static_cast<int32_t>(FEATURE_TYPE_MODEL_TASK_UPDATE)) &&
        (moduleType == static_cast<int32_t>(RT_MODULE_TYPE_TSCPU))) {
        return GetModelTaskUpdateIsSupport(deviceId, val);
    } else if (moduleType == static_cast<int32_t>(RT_MODULE_TYPE_HOST_AICPU)) {
        return GetHostAicpuDeviceInfo(static_cast<uint32_t>(deviceId), featureType, val);
    } else if ((featureType == static_cast<int32_t>(FEATURE_TYPE_MEMQ_EVENT_CROSS_DEV)) &&
        (moduleType == static_cast<int32_t>(RT_MODULE_TYPE_SYSTEM))) {
        return NpuDriver::MemQEventCrossDevSupported(val);
    } else if ((featureType == static_cast<int32_t>(RT_FEATURE_SYSTEM_TASKID_BIT_WIDTH)) &&
        (moduleType == static_cast<int32_t>(RT_MODULE_TYPE_SYSTEM))) {
        *val = GetTaskIdBitWidth();
        return RT_ERROR_NONE;
    } else {
        RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1006,
 	            "featureType=" + std::to_string(featureType) + " and " + "moduleType=" + std::to_string(moduleType));
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
}

rtError_t ApiImpl::GetFaultEvent(const int32_t deviceId, rtDmsEventFilter *filter,
    rtDmsFaultEvent *dmsEvent, uint32_t len, uint32_t *eventCount)
{
    RT_LOG(RT_LOG_DEBUG, "Get Fault Event.");
    COND_RETURN_ERROR(CheckCurCtxValid(deviceId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", deviceId);
    return NpuDriver::GetFaultEvent(deviceId, filter, dmsEvent, len, eventCount);
}

rtError_t ApiImpl::GetMemUceInfo(const uint32_t deviceId, rtMemUceInfo *memUceInfo)
{
    mmTimeval tv[5U] = {};
    int32_t index = 0;
    (void)mmGetTimeOfDay(&tv[index++], nullptr);
    RT_LOG(RT_LOG_EVENT, "Get MemUce Info.");
    rtError_t error;
    string faultInfo;
    constexpr uint32_t maxFaultNum = 128U;
    bool isSmmuFault;
    rtDmsFaultEvent faultEventInfo[maxFaultNum] = {};
    uint32_t eventCount = 0UL;
    COND_RETURN_ERROR(CheckCurCtxValid(static_cast<int32_t>(deviceId)) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%u].", deviceId);
    error = NpuDriver::GetAllFaultEvent(deviceId, faultEventInfo, maxFaultNum, &eventCount);
    COND_RETURN_WARN(error == RT_ERROR_FEATURE_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
                     "Not support get fault event");
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "can not get fault event of device_id=%u, error=%d", deviceId, error);
        return error;
    }
    (void)mmGetTimeOfDay(&tv[index++], nullptr);
    for (uint32_t faultIndex = 0; faultIndex < eventCount; faultIndex++) {
        RT_LOG(RT_LOG_INFO, "eventId=0x%x", faultEventInfo[faultIndex].eventId);
        if (g_mulBitEccEventId.find(faultEventInfo[faultIndex].eventId) != g_mulBitEccEventId.end()) {
            std::ostringstream oss;
            oss << std::hex << faultEventInfo[faultIndex].eventId;
            faultInfo = faultInfo + "[0x" + oss.str() + "]"
                + faultEventInfo[faultIndex].eventName + ";";
            break;
        }
    }
    (void)mmGetTimeOfDay(&tv[index++], nullptr);
    error = NpuDriver::GetSmmuFaultValid(deviceId, isSmmuFault);
    COND_RETURN_WARN(error == RT_ERROR_FEATURE_NOT_SUPPORT, RT_ERROR_FEATURE_NOT_SUPPORT,
                     "Not support get fault smmu valid");
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "can not get smmu of device_id=%u, error=%d", deviceId, error);
        return error;
    }
    (void)mmGetTimeOfDay(&tv[index++], nullptr);
    if ((!faultInfo.empty()) || isSmmuFault) {
        RT_LOG(RT_LOG_ERROR, "Error message is: [%s],isSmmuFault=%d.", faultInfo.c_str(), isSmmuFault);
        return RT_ERROR_DRV_ERR;
    }
    GlobalContainer::UceMutexLock();
    if (GlobalContainer::FindMemUceInfo(deviceId)) {
        memcpy_s(memUceInfo, sizeof(rtMemUceInfo), GlobalContainer::GetMemUceInfo(deviceId), sizeof(rtMemUceInfo));
    } else {
        error = NpuDriver::GetMemUceInfo(deviceId, memUceInfo);
        if (error == RT_ERROR_NONE) {
            GlobalContainer::InsertMemUceInfo(deviceId, memUceInfo);
        }
    }
    GlobalContainer::UceMutexUnlock();
    (void)mmGetTimeOfDay(&tv[index++], nullptr);
    for (int32_t i = 1; i < index; ++i) {
        RT_LOG(RT_LOG_EVENT, "deviceId %u, step %d: time cost: %llu us", deviceId, i,
            (tv[i].tv_sec - tv[i - 1U].tv_sec) * 1000000ULL + tv[i].tv_usec - tv[i - 1U].tv_usec);
    }

    RT_LOG(RT_LOG_EVENT, "uce dev=%u, count=%u", memUceInfo->devid, memUceInfo->count);
    for (uint32_t i = 0; i < memUceInfo->count; i++) {
        RT_LOG(RT_LOG_EVENT, "index=%u, ptr=0x%lx", i, memUceInfo->repairAddr[i].ptr);
    }
    return error;
}

rtError_t ApiImpl::MemUceRepair(const uint32_t deviceId, rtMemUceInfo *memUceInfo)
{
    COND_RETURN_ERROR(CheckCurCtxValid(static_cast<int32_t>(deviceId)) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%lu].", deviceId);
    std::array<mmTimeval, 2U> tv = {};
    mmGetTimeOfDay(&tv[0U], nullptr);
    const rtError_t error = NpuDriver::MemUceRepair(deviceId, memUceInfo);
    if (error == RT_ERROR_NONE) {
        GlobalContainer::UceMutexLock();
        GlobalContainer::DeleteMemUceInfo(deviceId);
        GlobalContainer::UceMutexUnlock();
    }
    mmGetTimeOfDay(&tv[1U], nullptr);
    RT_LOG(RT_LOG_EVENT, "drv devId %u: time cost: %llu us", deviceId,
        (static_cast<uint64_t>(tv[1U].tv_sec) - static_cast<uint64_t>(tv[0U].tv_sec)) * 1000000ULL +
        static_cast<uint64_t>(tv[1U].tv_usec) - static_cast<uint64_t>(tv[0U].tv_usec));
    return error;
}

rtError_t ApiImpl::GetC2cCtrlAddr(uint64_t * const addr, uint32_t * const len)
{
    RT_LOG(RT_LOG_DEBUG, "get c2c ctrl addr.");
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const uint64_t addrTmp = curCtx->Device_()->GetC2cCtrlAddr();
    const uint32_t lenTmp = curCtx->Device_()->GetC2cCtrlAddrLen();
    if ((addrTmp != 0UL) && (lenTmp != 0U)) {
        *addr = addrTmp;
        *len = lenTmp;
        return RT_ERROR_NONE;
    }

    const int32_t drvDeviceId = static_cast<int32_t>(curCtx->Device_()->Id_());
    Driver * const curDrv = curCtx->Device_()->Driver_();
    const rtError_t error = curDrv->GetC2cCtrlAddr(drvDeviceId, addr, len);
    if (error == RT_ERROR_NONE) {
        curCtx->Device_()->SetC2cCtrlAddr(*addr, *len);
    }

    return error;
}

rtError_t ApiImpl::NpuClearFloatStatus(const uint32_t checkMode, Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_ERROR(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT, "stream is not in current ctx");

    return curCtx->NpuClearFloatStatus(checkMode, curStm, false);
}

rtError_t ApiImpl::NpuGetFloatStatus(void * const outputAddrPtr, const uint64_t outputSize, const uint32_t checkMode,
    Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_ERROR(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT, "stream is not in current ctx");

    return curCtx->NpuGetFloatStatus(outputAddrPtr, outputSize, checkMode, curStm, false);
}

rtError_t ApiImpl::NpuClearFloatDebugStatus(const uint32_t checkMode, Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const Runtime * const rtInstance = Runtime::Instance();
    const rtChipType_t chipType = rtInstance->GetChipType();
    rtError_t ret = RT_ERROR_NONE;
    if (curCtx->Device_()->GetDevProperties().tsOverflowHandling == TsOverflowHandling::TS_OVER_FLOW_HANDING_INVALID) {
        COND_RETURN_ERROR(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT, "stream is not in current ctx");
        Device* device = stm->Device_();
        NULL_PTR_RETURN_MSG_OUTER(device, RT_ERROR_INVALID_VALUE);
        RT_LOG(RT_LOG_INFO, "device_id=%u, tschversion=%u",  device->Id_(), device->GetTschVersion());
        if (!(device->CheckFeatureSupport(TS_FEATURE_OVER_FLOW_DEBUG))) {
            RT_LOG(RT_LOG_WARNING, "current ts version does not support NpuClearFloatDebugStatus");
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }

        return curCtx->NpuClearFloatStatus(checkMode, stm, true);
    } else if (curCtx->Device_()->GetDevProperties().tsOverflowHandling == TsOverflowHandling::TS_OVER_FLOW_HANDING_FROM_MEM) {
        uint8_t hostTmp = 0;
        uint8_t* tmpDeviceAddr = ((uint8_t*)curCtx->CtxGetOverflowAddr());
        ret = curCtx->Device_()->Driver_()->MemCopySync(&hostTmp, sizeof(hostTmp), (void*)tmpDeviceAddr,
            sizeof(hostTmp), RT_MEMCPY_DEVICE_TO_HOST);
        ERROR_RETURN(ret, "Failed to Memcpy from device to host");
        hostTmp &= 0xFD;
        ret = curCtx->Device_()->Driver_()->MemCopySync((void*)tmpDeviceAddr,
            sizeof(hostTmp), &hostTmp, sizeof(hostTmp), RT_MEMCPY_HOST_TO_DEVICE);
        ERROR_RETURN(ret, "Failed to Memcpy from host to device");
    } else {
        RT_LOG(RT_LOG_WARNING, "not support in current chiptype=%d!", chipType);
        ret = RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    return ret;
}

rtError_t ApiImpl::NpuGetFloatDebugStatus(void * const outputAddrPtr, const uint64_t outputSize,
    const uint32_t checkMode, Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const Runtime * const rtInstance = Runtime::Instance();
    const rtChipType_t chipType = rtInstance->GetChipType();
    rtError_t ret = RT_ERROR_NONE;
    if (curCtx->Device_()->GetDevProperties().tsOverflowHandling == TsOverflowHandling::TS_OVER_FLOW_HANDING_INVALID) {
        COND_RETURN_ERROR(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT, "stream is not in current ctx");
        Device* device = stm->Device_();
        NULL_PTR_RETURN_MSG_OUTER(device, RT_ERROR_INVALID_VALUE);
        RT_LOG(RT_LOG_INFO, "device_id=%u, tschversion=%u",  device->Id_(), device->GetTschVersion());
        if (!device->CheckFeatureSupport(TS_FEATURE_OVER_FLOW_DEBUG)) {
            RT_LOG(RT_LOG_WARNING, "current ts version does not support NpuGetFloatDebugStatus");
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
        return curCtx->NpuGetFloatStatus(outputAddrPtr, outputSize, checkMode, stm, true);
    } else if (curCtx->Device_()->GetDevProperties().tsOverflowHandling == TsOverflowHandling::TS_OVER_FLOW_HANDING_FROM_MEM) {
        uint8_t hostTmp = 0;
        uint8_t* tmpDeviceAddr = ((uint8_t*)curCtx->CtxGetOverflowAddr());
        ret = curCtx->Device_()->Driver_()->MemCopySync(&hostTmp, sizeof(hostTmp), (void*)tmpDeviceAddr,
            sizeof(hostTmp), RT_MEMCPY_DEVICE_TO_HOST);
        ERROR_RETURN(ret, "Failed to Memcpy from device to host");
        hostTmp &= 0x2; // 2 means only get 1 bit
        hostTmp >>= 1; // write in 0 bit for input addr
        ret = curCtx->Device_()->Driver_()->MemCopySync(outputAddrPtr, outputSize, &hostTmp,
            sizeof(hostTmp), RT_MEMCPY_HOST_TO_DEVICE);
        ERROR_RETURN(ret, "Failed to Memcpy from host to device");
    } else {
        RT_LOG(RT_LOG_WARNING, "not support in current chip type=%d!", chipType);
        ret = RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    return ret;
}

rtError_t ApiImpl::SetOpWaitTimeOut(const uint32_t timeout)
{
    RT_LOG(RT_LOG_DEBUG, "set op event wait timeout, timeout=%us.", timeout);
    rtError_t ret = RT_ERROR_NONE;
    TIMESTAMP_NAME(__func__);
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    DevProperties prop;
    rtError_t error = GET_DEV_PROPERTIES(chipType, prop);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE, "GetDevProperties fail");
    const auto eventWaitTimeoutProp = prop.eventWaitTimeout;
    if (eventWaitTimeoutProp == EventWaitTimeoutType::SET_OP_WAIT_TIMEOUT_NOT_SUPPORT) {
        RT_LOG(RT_LOG_WARNING, "Unsupport chip type, chipType=%d.", chipType);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    if (eventWaitTimeoutProp == EventWaitTimeoutType::SET_OP_WAIT_TIMEOUT_NEED_TS_VERSION) {
        Context * const curCtx = CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        Device * const dev = curCtx->Device_();
        if (dev->GetTschVersion() < static_cast<uint32_t>(TS_VERSION_WAIT_TIMEOUT_DC)) {
            RT_LOG(RT_LOG_WARNING, "Unsupported ver:%u", dev->GetTschVersion());
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
    }
    ret  = AiCpuTaskSupportCheck();
    COND_RETURN_WITH_NOLOG(ret != RT_ERROR_NONE, ret);
    Runtime * const rtInstance = Runtime::Instance();
    COND_RETURN_ERROR_MSG_INNER(rtInstance == nullptr, RT_ERROR_INSTANCE_NULL, "Runtime instance is null");
    if (prop.isStars || eventWaitTimeoutProp == EventWaitTimeoutType::SET_OP_WAIT_TIMEOUT_NEED_TS_VERSION) {
        RT_LOG(RT_LOG_INFO, "set OP wait timeout=%us.", timeout);
        rtInstance->SetWaitTimeout(timeout);
    }
    ret = rtInstance->SetTimeoutConfig(RT_TIMEOUT_TYPE_OP_WAIT, timeout, RT_TIME_UNIT_TYPE_S);
    return ret;
}

rtError_t ApiImpl::SetOpExecuteTimeOut(const uint32_t timeout, const RtTaskTimeUnitType timeUnitType)
{
    RT_LOG(RT_LOG_DEBUG, "set op execute timeout, timeout=%us, timeUnitType=%d.",
        timeout, static_cast<int32_t>(timeUnitType));
    TIMESTAMP_NAME(__func__);
    rtError_t ret = RT_ERROR_NONE;
    Runtime * const rtInstance = Runtime::Instance();
    NULL_PTR_RETURN_MSG(rtInstance, RT_ERROR_INSTANCE_NULL);

    uint32_t timeoutTmp = timeout;
    if ((timeUnitType == RT_TIME_UNIT_TYPE_MS) && (timeout >= RT_MAX_OP_TIMEOUT_FOR_MS)) {
        timeoutTmp = RT_MAX_OP_TIMEOUT_FOR_MS;
    }
    ret = rtInstance->SetTimeoutConfig(RT_TIMEOUT_TYPE_OP_EXECUTE, timeoutTmp, timeUnitType);
    return ret;
}

rtError_t ApiImpl::GetOpExecuteTimeOut(uint32_t * const timeout)
{
    *timeout = static_cast<uint32_t>(RT_STARS_TASK_KERNEL_CREDIT_SCALE);
    const RtTimeoutConfig &timeoutCfg = Runtime::Instance()->GetTimeoutConfig();
    const auto chipType = Runtime::Instance()->GetChipType();
    if (timeoutCfg.isCfgOpExcTaskTimeout) {
        if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_TASK_OP_EXE_TIMEOUT_CONFIG)) { // ms
            *timeout = static_cast<uint32_t>(timeoutCfg.opExcTaskTimeout / RT_TIMEOUT_MS_TO_US);
        } else { // s
            *timeout = static_cast<uint32_t>(timeoutCfg.opExcTaskTimeout / RT_TIMEOUT_S_TO_US);
        }
    } else {
        float32_t kernelCreditScale = Runtime::Instance()->GetKernelCreditScaleUS();
        const uint32_t kernelCredit = static_cast<uint32_t>(Runtime::Instance()->GetStarsFftsDefaultKernelCredit());
        if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_TASK_OP_EXE_TIMEOUT_CONFIG)) {
            kernelCreditScale = kernelCreditScale / RT_TIMEOUT_MS_TO_US;
        }
        *timeout = static_cast<uint32_t>(ceil(kernelCreditScale * kernelCredit / RT_TIMEOUT_S_TO_MS));
    }
    return 0;
}

rtError_t ApiImpl::GetOpExecuteTimeoutV2(uint32_t *const timeout)
{
    *timeout = 0U;
    float64_t timeoutUs = 0.0F;
    Runtime *const rtInstance = Runtime::Instance();
    NULL_PTR_RETURN_MSG(rtInstance, RT_ERROR_INSTANCE_NULL);

    const RtTimeoutConfig &timeoutCfg = rtInstance->GetTimeoutConfig();
    const float64_t kernelCreditScaleUS = rtInstance->GetKernelCreditScaleUS();
    const uint32_t defaultKernelCredit = rtInstance->GetDefaultKernelCredit();
    const float64_t maxKernelCredit = static_cast<float64_t>(rtInstance->GetMaxKernelCredit());

    // Get different ChipType of kernel credit scale and default kernel credit.
    const rtChipType_t chipType = rtInstance->GetChipType();
    if (defaultKernelCredit == 0U || (kernelCreditScaleUS < std::numeric_limits<double>::epsilon())) {
        RT_LOG(RT_LOG_WARNING, "Unsupported chip type, chipType=%d.", chipType);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    // Calculate timeout based on different conditions.
    if (timeoutCfg.isCfgOpExcTaskTimeout) {
        const float64_t timeoutTmpUs = static_cast<float64_t>(timeoutCfg.opExcTaskTimeout);
        if ((timeoutCfg.opExcTaskTimeout == 0U) || (timeoutTmpUs > kernelCreditScaleUS * maxKernelCredit)) {
            // If timeout is 0 or timeouttmp > the maximum timeout period, it is considered as the maximum timeout
            // period.​
            timeoutUs = kernelCreditScaleUS * maxKernelCredit;
        } else {
            // Round up to get the hardware effective time.
            const uint64_t kernelCreditTmp = static_cast<uint64_t>((timeoutTmpUs + kernelCreditScaleUS - 1) / kernelCreditScaleUS);
            timeoutUs = kernelCreditScaleUS * static_cast<float64_t>(kernelCreditTmp);
        }
    } else {
        // ​​If timeout is not set, use AIC default timeout.​
        timeoutUs = kernelCreditScaleUS * static_cast<float64_t>(defaultKernelCredit);
    }

    *timeout = static_cast<uint32_t>(ceil(timeoutUs / static_cast<float64_t>(RT_TIMEOUT_MS_TO_US)));
    RT_LOG(RT_LOG_INFO, "get OP execute timeout=%u ms.", *timeout);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::CheckArchCompatibility(const char_t *omSocVersion, int32_t *canCompatible)
{
    Runtime *const rtInstance = Runtime::Instance();
    NULL_PTR_RETURN_MSG(rtInstance, RT_ERROR_INSTANCE_NULL);
    const rtArchType_t hardwareArchType = rtInstance->GetArchType();

    // Get the archType corresponding to the omSocVersion
    rtSocInfo_t socInfo = {SOC_END, CHIP_END, ARCH_END, nullptr};
    const rtError_t ret = GetSocInfoByName(omSocVersion, socInfo);
    if (ret != RT_ERROR_NONE) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "SoC version [%s] is invalid", omSocVersion);
        return RT_ERROR_INVALID_VALUE;
    }
    const rtArchType_t inputArchType = socInfo.archType;

    // Verify that the hardware ArchType is consistent with the input ArchType
    const rtError_t error = rtInstance->CheckArchVersionIsCompatibility(inputArchType, hardwareArchType);
    if (error == RT_ERROR_NONE) {
        constexpr int32_t archVerCompatible = 1U;
        *canCompatible = archVerCompatible;
    } else {
        constexpr int32_t archVerIncompatible = 0U;
        *canCompatible = archVerIncompatible;
    }
    RT_LOG(RT_LOG_INFO,
        "Arch compatibility check result: canCompatible=%d, socVersion = %s.",
        *canCompatible,
        omSocVersion);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetOpTimeOutInterval(uint64_t *interval)
{
    Context * const curCtx = CurrentContext(); // 隐式set device
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_PTR_RETURN_MSG(rtInstance, RT_ERROR_INSTANCE_NULL);
    const RtTimeoutConfig &timeoutCfg = rtInstance->GetTimeoutConfig();
    COND_RETURN_ERROR_MSG_INNER((timeoutCfg.isInit == false), RT_ERROR_DEVICE_RETAIN,
        "Get op timeout interval failed, must set device first.");

    *interval = static_cast<uint64_t>(timeoutCfg.interval);
    RT_LOG(RT_LOG_INFO, "Get op timeout interval successfully, interval=%" PRIu64 "us.", *interval);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::SetOpExecuteTimeOutV2(uint64_t timeout, uint64_t *actualTimeout)
{
    Context * const curCtx = CurrentContext(); // 隐式set device
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Runtime * const rtInstance = Runtime::Instance();
    NULL_PTR_RETURN_MSG(rtInstance, RT_ERROR_INSTANCE_NULL);
    const RtTimeoutConfig &timeoutCfg = rtInstance->GetTimeoutConfig();
    COND_RETURN_ERROR_MSG_INNER((timeoutCfg.isInit == false), RT_ERROR_DEVICE_RETAIN,
        "set op execute timeout failed, must set device first.");

    const rtError_t error = rtInstance->SetTimeoutConfig(RT_TIMEOUT_TYPE_OP_EXECUTE, timeout, RT_TIME_UNIT_TYPE_US);
    ERROR_RETURN_MSG_INNER(error, "set op execute timeout failed, retCode=%#x.", static_cast<uint32_t>(error));

    uint16_t credit = 0U;
    TransExeTimeoutCfgToKernelCredit(timeout, credit);
    *actualTimeout =  static_cast<uint64_t>(static_cast<double>(credit) * timeoutCfg.interval);
    RT_LOG(RT_LOG_INFO, "set op execute timeout, timeout=%" PRIu64 "us, actualTimeout=%" PRIu64 "us.",
        timeout, *actualTimeout);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::StarsTaskLaunch(const void * const sqe, const uint32_t sqeLen, Stream * const stm,
    const uint32_t flag)
{
    RT_LOG(RT_LOG_DEBUG, "Stars launch, sqeLen=%u, flag=%u.", sqeLen, flag);
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
                                "Stars task launch failed, stream is not in current ctx");

    return curCtx->StarsLaunch(sqe, sqeLen, curStm, flag);
}

bool ApiImpl::IsDevSupportGetDevMsg(const Device * const dev)
{
    return dev->GetTschVersion() >= TS_VERSION_GET_DEV_MSG;
}

rtError_t ApiImpl::SyncGetDevMsg(Device * const dev, const void * const devMemAddr, const uint32_t devMemSize,
                                 const rtGetDevMsgType_t getDevMsgType) const
{
    // new a stream for get exception info
    std::unique_ptr<Stream, void(*)(Stream*)> stm(StreamFactory::CreateStream(dev, 0U),
                                                  [](Stream* ptr) {ptr->Destructor();});
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, stm == nullptr, RT_ERROR_STREAM_NEW, "new Stream failed.");
    rtError_t error = stm->Setup();
    ERROR_RETURN_MSG_INNER(error, "stream setup failed, retCode=%#x.", static_cast<uint32_t>(error));
    const std::function<void()> streamTearDownFunc = [&stm]() {
        const auto ret = (stm->TearDown());
        // Disable thread stream destroy task will delete stream
        // other condition, we should delete stream here
        Runtime * const rtIntsance = Runtime::Instance();
        // Disable thread free in stream destroy task recycle, stream destroy task send in TearDown process.
        if ((ret == RT_ERROR_NONE) && (!rtIntsance->GetDisableThread())) {
            (void)stm.release();
        }
    };
    const ScopeGuard devErrMsgStreamRelease(streamTearDownFunc);
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *tsk = stm.get()->AllocTask(&submitTask, TS_TASK_TYPE_GET_DEVICE_MSG, errorReason);
    NULL_PTR_RETURN_MSG(tsk, errorReason);

    // init RT_GET_DEV_ERROR_MSG task
    error = GetDevMsgTaskInit(tsk, devMemAddr, devMemSize, getDevMsgType);
    ERROR_PROC_RETURN_MSG_INNER(error,
                                ((void)dev->GetTaskFactory()->Recycle(tsk));,
                                "Failed to init task, stream_id=%d, task_id=%hu, retCode=%#x.",
                                stm->Id_(), tsk->id, static_cast<uint32_t>(error));
    // submit task
    error = dev->SubmitTask(tsk);
    ERROR_PROC_RETURN_MSG_INNER(error,
                                ((void)dev->GetTaskFactory()->Recycle(tsk));,
                                "Failed to submit task, retCode=%#x, device id=%u",
                                static_cast<uint32_t>(error), dev->Id_());
    // stream synchronize
    error = stm->Synchronize();
    ERROR_RETURN_MSG_INNER(error, "Failed to synchronize stream, retCode=%#x.", static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetDevErrMsg(const rtGetMsgCallback callback)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    rtError_t error = dev->GetDeviceStatus();
    ERROR_RETURN(error, "device_id=%u, status=%#x is abnormal.", static_cast<uint32_t>(error));
    // stars do nothing in device, so do not need to send task.
    COND_PROC((dev->IsStarsPlatform()),
        callback("", 0U);
        RT_LOG(RT_LOG_DEBUG, "Do not need to send task.");
        return RT_ERROR_NONE);
    const bool isSupport = IsDevSupportGetDevMsg(dev);
    COND_RETURN_ERROR_MSG_INNER(!isSupport, RT_ERROR_FEATURE_NOT_SUPPORT,
                                "Device does not support get device msg, deviceId=%u.", dev->Id_());

    DeviceErrMsgHandler getDevErrHandler(dev, callback);
    error = getDevErrHandler.Init();
    ERROR_RETURN_MSG_INNER(error, "Init device error msg handler failed, retCode=%#x.", static_cast<uint32_t>(error));

    error = SyncGetDevMsg(dev, getDevErrHandler.GetDevMemAddr(), getDevErrHandler.GetDevMemSize(),
                          RT_GET_DEV_ERROR_MSG);
    ERROR_RETURN_MSG_INNER(error, "Sync get device msg failed, retCode=%#x.", static_cast<uint32_t>(error));

    error = getDevErrHandler.HandleMsg();
    ERROR_RETURN_MSG_INNER(error, "Failed to handle get device error msg, retCode=%#x.", static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetDevRunningStreamSnapshotMsg(const rtGetMsgCallback callback)
{
    const std::function<rtError_t(Device * const dev)> getDevHangMsgForDev =
        [callback, this](Device * const dev) -> rtError_t {
        const bool isSupport = IsDevSupportGetDevMsg(dev);
        COND_RETURN_ERROR_MSG_INNER(!isSupport, RT_ERROR_FEATURE_NOT_SUPPORT,
                                    "Device does not support get device msg, deviceId=%u.", dev->Id_());

        DeviceStreamSnapshotHandler devStreamSnapshotHandler(dev, callback);
        rtError_t error = devStreamSnapshotHandler.Init();
        ERROR_RETURN(error, "Init device stream snapshot msg handler failed, retCode=%#x.", static_cast<uint32_t>(error));
        error = SyncGetDevMsg(dev, devStreamSnapshotHandler.GetDevMemAddr(),
            devStreamSnapshotHandler.GetDevMemSize(), RT_GET_DEV_RUNNING_STREAM_SNAPSHOT_MSG);
        ERROR_RETURN(error, "Sync get device msg failed, retCode=%#x.", error);

        error = devStreamSnapshotHandler.HandleMsg();
        ERROR_RETURN_MSG_INNER(error, "Failed to handle get stream snapshot msg, retCode=%#x.", static_cast<uint32_t>(error));
        return RT_ERROR_NONE;
    };
    return Runtime::Instance()->ProcessForAllOpenDevice(getDevHangMsgForDev, false);
}

rtError_t ApiImpl::ProcError(rtError_t error)
{
    // all thread return HBM_MULTI_BIT_ECC_ERROR
    if (error == RT_ERROR_MEM_RAS_ERROR) {
        Context * const curCtx = CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        Device * const dev = curCtx->Device_();
        const uint32_t hbmRasDevId = Runtime::Instance()->GetRasInfoDevId();
        if (dev != nullptr && dev->Id_() == hbmRasDevId) {
            // report ACL_ERROR_RT_HBM_MULTI_BIT_ECC_ERROR
            RT_LOG_CALL_MSG(ERR_MODULE_DRV,
                "HBM MULTI BIT ECC, Uncorrectable ECC, device_id=%u, event_id=0x%x, time us=%" PRIu64 ".",
                hbmRasDevId, HBM_ECC_EVENT_ID, Runtime::Instance()->GetRasInfoSysCnt());
        }
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetDevMsg(const rtGetDevMsgType_t getMsgType, const rtGetMsgCallback callback)
{
    RT_LOG(RT_LOG_DEBUG, "GetDeviceMsg, getMsgType=%d", static_cast<int32_t>(getMsgType));
    TIMESTAMP_NAME(__func__);
    const auto chipType = Runtime::Instance()->GetChipType();
    COND_RETURN_ERROR_MSG_INNER(!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_DFX_TS_GET_DEVICE_MSG), 
        RT_ERROR_FEATURE_NOT_SUPPORT, "chipType=%d does not support get device msg feature.", chipType);
    rtRunMode runMode = RT_RUN_MODE_OFFLINE;
    (void)GetRunMode(&runMode);
    if (runMode == RT_RUN_MODE_OFFLINE) {
        RT_LOG(RT_LOG_INFO, "runMode is RT_RUN_MODE_OFFLINE.");
    }

    if (getMsgType == RT_GET_DEV_ERROR_MSG) {
        const rtError_t error = GetDevErrMsg(callback);
        ProcError(error);
        ERROR_RETURN(error, "Failed to GetDeviceErrMsg, retCode=%#x.", static_cast<uint32_t>(error));
    } else if (getMsgType == RT_GET_DEV_RUNNING_STREAM_SNAPSHOT_MSG) {
        const rtError_t error = GetDevRunningStreamSnapshotMsg(callback);
        ERROR_RETURN(error, "Failed to GetDevRunningStreamSnapshotMsg, retCode=%#x.", static_cast<uint32_t>(error));
    } else {
        // The value range of this parameter in this function is [0 - 2). Parameter 2 is used in the snapshot process.
        RT_LOG_CALL_MSG(ERR_MODULE_GE, "Unsupported get msg type=%d, range is [%d, %d)", getMsgType,
            RT_GET_DEV_ERROR_MSG, RT_GET_DEV_PID_SNAPSHOT_MSG);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetStreamTimeoutSnapshotMsg()
{
    rtError_t error;
    Context * const curCtx = CurrentContext();
    NULL_PTR_RETURN_MSG(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    NULL_PTR_RETURN(dev, RT_ERROR_DEVICE_NULL);

    if (!dev->IsPrintStreamTimeoutSnapshot()) {
        return RT_ERROR_NONE;
    }

    DeviceStreamSnapshotHandler devStreamSnapshotHandler(dev, nullptr);
    error = devStreamSnapshotHandler.Init();
    ERROR_RETURN(error, "Init device stream snapshot msg handler failed, retCode=%#x.", static_cast<uint32_t>(error));
    if ((dev->GetSnapshotAddr() == nullptr) || (dev->GetSnapshotLen() == 0)) {
#ifndef CFG_DEV_PLATFORM_PC
        RT_LOG(RT_LOG_ERROR, "snapshotLen=%u", dev->GetSnapshotLen());
#endif
        return RT_ERROR_NONE;
    }
    error = SyncGetDeviceMsg(dev, devStreamSnapshotHandler.GetDevMemAddr(),
        devStreamSnapshotHandler.GetDevMemSize(), RT_GET_DEV_PID_SNAPSHOT_MSG);
    ERROR_RETURN(error, "Sync get device msg failed, retCode=%#x.", static_cast<uint32_t>(error));
    return dev->PrintStreamTimeoutSnapshotInfo();
}

rtError_t ApiImpl::MemQueueInitQS(const int32_t devId, const char_t * const grpName)
{
    RT_LOG(RT_LOG_INFO, "Start to init queue schedule on drv devId %d.", devId);
    Runtime * const rtInstance = Runtime::Instance();
    return rtInstance->InitAicpuQS(static_cast<uint32_t>(devId), grpName);
}

rtError_t ApiImpl::MemQueueInitFlowGw(const int32_t devId, const rtInitFlowGwInfo_t * const initInfo)
{
    RT_LOG(RT_LOG_INFO, "Start to init FlowGw on drv devId %d.", devId);
    Runtime * const rtInstance = Runtime::Instance();
    return rtInstance->InitAicpuFlowGw(static_cast<uint32_t>(devId), initInfo);
}

rtError_t ApiImpl::MemQueueCreate(const int32_t devId, const rtMemQueueAttr_t * const queAttr, uint32_t * const qid)
{
    RT_LOG(RT_LOG_INFO, "Start to create queue on drv devId %d.", devId);
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::MemQueueCreate(devId, queAttr, qid);
}

rtError_t ApiImpl::MemQueueExport(const int32_t devId, const uint32_t qid, const int32_t peerDevId,
        const char * const shareName)  
{
    RT_LOG(RT_LOG_INFO, "Start to Export queue on drv devId [%d], qid [%d],peerDevId [%d] .", 
        devId, qid, peerDevId);
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::MemQueueExport(devId, qid, peerDevId, shareName);
}
rtError_t ApiImpl::MemQueueUnExport(const int32_t devId, const uint32_t qid, const int32_t peerDevId,
        const char * const shareName)
{
    RT_LOG(RT_LOG_INFO, "Start to UnExport queue on drv devId [%d], qid [%d],peerDevId [%d] .", 
        devId, qid, peerDevId);
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::MemQueueUnExport(devId, qid, peerDevId, shareName);
}

rtError_t ApiImpl::MemQueueImport(const int32_t devId, const int32_t peerDevId, const char * const shareName,
        uint32_t * const qid) 
{
    RT_LOG(RT_LOG_INFO, "Start to Import queue on drv devId [%d], peerDevId [%d].", 
        devId, peerDevId);
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::MemQueueImport(devId, peerDevId, shareName, qid);
}

rtError_t ApiImpl::MemQueueUnImport(const int32_t devId, const uint32_t qid, const int32_t peerDevId, 
        const char * const shareName)
{
    RT_LOG(RT_LOG_INFO, "Start to UnImport queue on drv devId [%d], qid [%d],peerDevId [%d].", 
        devId, qid, peerDevId);
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::MemQueueUnImport(devId, qid, peerDevId, shareName);
}

rtError_t ApiImpl::MemQueueSet(const int32_t devId, const rtMemQueueSetCmdType cmd,
    const rtMemQueueSetInputPara * const input)
{
    RT_LOG(RT_LOG_INFO, "Start to queue set on drv devId %d.", devId);
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::MemQueueSet(devId, cmd, input);
}

rtError_t ApiImpl::MemQueueDestroy(const int32_t devId, const uint32_t qid)
{
    RT_LOG(RT_LOG_INFO, "Start to destroy queue on drv devId %d, qid is %u.", devId, qid);
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::MemQueueDestroy(devId, qid);
}

rtError_t ApiImpl::MemQueueInit(const int32_t devId)
{
    RT_LOG(RT_LOG_INFO, "Start to init queue on drv devId %d.", devId);
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::MemQueueInit(devId);
}

rtError_t ApiImpl::MemQueueReset(const int32_t devId, const uint32_t qid)
{
    RT_LOG(RT_LOG_INFO, "Start to reset queue on drv devId %d.", devId);
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::MemQueueReset(devId, qid);
}

rtError_t ApiImpl::MemQueueEnQueue(const int32_t devId, const uint32_t qid, void * const enQBuf)
{
    RT_LOG(RT_LOG_INFO, "Start to enqueue on drv devId %d, qid is %u.", devId, qid);
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::MemQueueEnQueue(devId, qid, enQBuf);
}

rtError_t ApiImpl::MemQueueDeQueue(const int32_t devId, const uint32_t qid, void ** const deQBuf)
{
    RT_LOG(RT_LOG_INFO, "Start to dequeue on drv devId %d, qid is %u.", devId, qid);
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::MemQueueDeQueue(devId, qid, deQBuf);
}

rtError_t ApiImpl::MemQueuePeek(const int32_t devId, const uint32_t qid, size_t * const bufLen, const int32_t timeout)
{
    RT_LOG(RT_LOG_INFO, "Start to peek queue on drv devId %d, qid is %u.", devId, qid);
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::MemQueuePeek(devId, qid, bufLen, timeout);
}

rtError_t ApiImpl::MemQueueEnQueueBuff(const int32_t devId, const uint32_t qid, rtMemQueueBuff_t * const inBuf,
    const int32_t timeout)
{
    RT_LOG(RT_LOG_DEBUG, "Start to enqueue buf on drv devId %d, qid is %u, timeout=%dms.", devId, qid, timeout);
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::MemQueueEnQueueBuff(devId, qid, inBuf, timeout);
}

rtError_t ApiImpl::MemQueueDeQueueBuff(const int32_t devId, const uint32_t qid, rtMemQueueBuff_t * const outBuf,
    const int32_t timeout)
{
    RT_LOG(RT_LOG_INFO, "Start to dequeue buf on drv devId %d, qid is %u, timeout=%dms.", devId, qid, timeout);
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::MemQueueDeQueueBuff(devId, qid, outBuf, timeout);
}

rtError_t ApiImpl::MemQueueQueryInfo(const int32_t devId, const uint32_t qid, rtMemQueueInfo_t * const queryQueueInfo)
{
    RT_LOG(RT_LOG_DEBUG, "Start to query queue info on drv devId %d, qid is %u.", devId, qid);
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::MemQueueQueryInfo(devId, qid, queryQueueInfo);
}

rtError_t ApiImpl::MemQueueQuery(const int32_t devId, const rtMemQueueQueryCmd_t cmd, const void * const inBuff,
    const uint32_t inLen, void * const outBuff, uint32_t * const outLen)
{
    RT_LOG(RT_LOG_INFO, "Start to query queue on drv devId %d, cmd is %d.", devId, cmd);
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::MemQueueQuery(devId, cmd, inBuff, inLen, outBuff, outLen);
}

rtError_t ApiImpl::MemQueueGrant(const int32_t devId, const uint32_t qid, const int32_t pid,
    rtMemQueueShareAttr_t * const attr)
{
    RT_LOG(RT_LOG_INFO, "Start to grant queue on drv devId %d, qid is %u, pid is %d", devId, qid, pid);
    TIMESTAMP_NAME(__func__);
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::MemQueueGrant(devId, qid, pid, attr);
}

rtError_t ApiImpl::MemQueueAttach(const int32_t devId, const uint32_t qid, const int32_t timeOut)
{
    RT_LOG(RT_LOG_INFO, "Start to attach queue on drv devId %d, qid is %u, timeout=%dms.", devId, qid, timeOut);
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::MemQueueAttach(devId, qid, timeOut);
}

rtError_t ApiImpl::MemQueueGetQidByName(const int32_t devId, const char_t * const name, uint32_t * const qId)
{
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::MemQueueGetQidByName(devId, name, qId);
}

rtError_t ApiImpl::QueueSubF2NFEvent(const int32_t devId, const uint32_t qId, const uint32_t groupId)
{
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::QueueSubF2NFEvent(devId, qId, groupId);
}

rtError_t ApiImpl::QueueSubscribe(const int32_t devId, const uint32_t qId, const uint32_t groupId, const int32_t type)
{
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::QueueSubscribe(devId, qId, groupId, type);
}

rtError_t ApiImpl::BufEventTrigger(const char_t * const name)
{
    return NpuDriver::BufEventTrigger(name);
}

rtError_t ApiImpl::EschedSubmitEventSync(const int32_t devId, rtEschedEventSummary_t * const evt,
    rtEschedEventReply_t * const ack)
{
    RT_LOG(RT_LOG_INFO, "Start to submit event on drv devId %d.", devId);
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::EschedSubmitEventSync(devId, evt, ack);
}

rtError_t ApiImpl::QueryDevPid(rtBindHostpidInfo_t * const info, int32_t * const devPid)
{
    RT_LOG(RT_LOG_INFO, "Start to query device pid.");
    return NpuDriver::QueryDevPid(info, devPid);
}

rtError_t ApiImpl::EschedAttachDevice(const uint32_t devId)
{
    COND_RETURN_ERROR(CheckCurCtxValid(static_cast<int32_t>(devId)) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%lu].", devId);
    return NpuDriver::EschedAttachDevice(devId);
}

rtError_t ApiImpl::EschedDettachDevice(const uint32_t devId)
{
    COND_RETURN_ERROR(CheckCurCtxValid(static_cast<int32_t>(devId)) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%lu].", devId);
    return NpuDriver::EschedDettachDevice(devId);
}

rtError_t ApiImpl::EschedWaitEvent(const int32_t devId, const uint32_t grpId, const uint32_t threadId,
    const int32_t timeout, rtEschedEventSummary_t * const evt)
{
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::EschedWaitEvent(devId, grpId, threadId, timeout, evt);
}

rtError_t ApiImpl::EschedCreateGrp(const int32_t devId, const uint32_t grpId, const rtGroupType_t type)
{
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::EschedCreateGrp(devId, grpId, type);
}

rtError_t ApiImpl::EschedSubmitEvent(const int32_t devId, rtEschedEventSummary_t * const evt)
{
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::EschedSubmitEvent(devId, evt);
}

rtError_t ApiImpl::EschedSubscribeEvent(const int32_t devId, const uint32_t grpId, const uint32_t threadId,
    const uint64_t eventBitmap)
{
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::EschedSubscribeEvent(devId, grpId, threadId, eventBitmap);
}

rtError_t ApiImpl::EschedAckEvent(const int32_t devId, const rtEventIdType_t evtId,
    const uint32_t subeventId, char_t * const msg, const uint32_t len)
{
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::EschedAckEvent(devId, evtId, subeventId, msg, len);
}

rtError_t ApiImpl::BuffAlloc(const uint64_t size, void **buff)
{
    RT_LOG(RT_LOG_INFO, "Start to alloc buff, size is %" PRIu64, size);
    return NpuDriver::BuffAlloc(size, buff);
}

rtError_t ApiImpl::BuffConfirm(void * const buff, const uint64_t size)
{
    RT_LOG(RT_LOG_INFO, "Start to determine whether buff is shared memory.");
    return NpuDriver::BuffConfirm(buff, size);
}

rtError_t ApiImpl::MbufBuild(void * const buff, const uint64_t size, rtMbufPtr_t * const mbufPtr)
{
    RT_LOG(RT_LOG_INFO, "Start to build mbuf, size is %" PRIu64, size);
    return NpuDriver::MbufBuild(buff, size, mbufPtr);
}

rtError_t ApiImpl::MbufAlloc(rtMbufPtr_t * const mbufPtr, const uint64_t size)
{
    RT_LOG(RT_LOG_INFO, "Start to alloc mbuf, size is %" PRIu64, size);
    TIMESTAMP_NAME(__func__);
    return NpuDriver::MbufAlloc(mbufPtr, size);
}

rtError_t ApiImpl::MbufAllocEx(rtMbufPtr_t * const mbufPtr, const uint64_t size,
    const uint64_t flag, const int32_t grpId)
{
    RT_LOG(RT_LOG_INFO, "Start to alloc mbuf, size is %" PRIu64, size);
    return NpuDriver::MbufAllocEx(mbufPtr, size, flag, grpId);
}

rtError_t ApiImpl::BuffFree(void * const buff)
{
    RT_LOG(RT_LOG_INFO, "Start to free buff.");
    return NpuDriver::BuffFree(buff);
}

rtError_t ApiImpl::MbufUnBuild(const rtMbufPtr_t mbufPtr, void ** const buff, uint64_t * const size)
{
    RT_LOG(RT_LOG_INFO, "Start to unBuild mbuf, size is %p", size);
    return NpuDriver::MbufUnBuild(mbufPtr, buff, size);
}

rtError_t ApiImpl::MbufGet(const rtMbufPtr_t mbufPtr, void * const buff, const uint64_t size)
{
    RT_LOG(RT_LOG_INFO, "Start to get mbuf, size is %" PRIu64, size);
    return NpuDriver::MbufGet(mbufPtr, buff, size);
}

rtError_t ApiImpl::MbufPut(const rtMbufPtr_t mbufPtr, void * const buff)
{
    RT_LOG(RT_LOG_INFO, "Start to put buff.");
    return NpuDriver::MbufPut(mbufPtr, buff);
}


rtError_t ApiImpl::MbufFree(const rtMbufPtr_t mbufPtr)
{
    RT_LOG(RT_LOG_INFO, "Start to free mbuf.");

    return NpuDriver::MbufFree(mbufPtr);
}

rtError_t ApiImpl::MbufSetDataLen(const rtMbufPtr_t mbufPtr, const uint64_t len)
{
    RT_LOG(RT_LOG_INFO, "Start to set mbuf data len %lu.", len);
    return NpuDriver::MbufSetDataLen(mbufPtr, len);
}

rtError_t ApiImpl::MbufGetDataLen(const rtMbufPtr_t mbufPtr, uint64_t *len)
{
    return NpuDriver::MbufGetDataLen(mbufPtr, len);
}

rtError_t ApiImpl::MbufGetBuffAddr(const rtMbufPtr_t mbufPtr, void ** const buf)
{
    RT_LOG(RT_LOG_INFO, "Start to get mbuf data addr.");

    return NpuDriver::MbufGetBuffAddr(mbufPtr, buf);
}

rtError_t ApiImpl::MbufGetBuffSize(const rtMbufPtr_t mbufPtr, uint64_t * const totalSize)
{
    RT_LOG(RT_LOG_INFO, "Start to get databuf size.");

    return NpuDriver::MbufGetBuffSize(mbufPtr, totalSize);
}

rtError_t ApiImpl::MbufGetPrivInfo(const rtMbufPtr_t mbufPtr, void ** const priv, uint64_t * const size)
{
    RT_LOG(RT_LOG_INFO, "Start to get mbuf priv addr.");

    return NpuDriver::MbufGetPrivInfo(mbufPtr, priv, size);
}

rtError_t ApiImpl::MbufCopyBufRef(const rtMbufPtr_t mbufPtr, rtMbufPtr_t * const newMbufPtr)
{
    RT_LOG(RT_LOG_INFO, "Start to copy buf ref.");

    return NpuDriver::MbufCopyBufRef(mbufPtr, newMbufPtr);
}

rtError_t ApiImpl::MbufChainAppend(const rtMbufPtr_t memBufChainHead, rtMbufPtr_t memBuf)
{
    RT_LOG(RT_LOG_INFO, "Start to append mbuf chain.");

    return NpuDriver::MbufChainAppend(memBufChainHead, memBuf);
}

rtError_t ApiImpl::MbufChainGetMbufNum(const rtMbufPtr_t memBufChainHead, uint32_t *num)
{
    RT_LOG(RT_LOG_INFO, "Start to get mbuf chain num.");

    return NpuDriver::MbufChainGetMbufNum(memBufChainHead, num);
}

rtError_t ApiImpl::MbufChainGetMbuf(const rtMbufPtr_t memBufChainHead, const uint32_t index,
    rtMbufPtr_t * const memBuf)
{
    RT_LOG(RT_LOG_INFO, "Start to get mbuf from chain %u.", index);

    return NpuDriver::MbufChainGetMbuf(memBufChainHead, index, memBuf);
}

rtError_t ApiImpl::MemGrpCreate(const char_t * const name, const rtMemGrpConfig_t * const cfg)
{
    RT_LOG(RT_LOG_INFO, "Start to create group %s.", name);
    return NpuDriver::MemGrpCreate(name, cfg);
}

rtError_t  ApiImpl::BuffGetInfo(const rtBuffGetCmdType type, const void * const inBuff, const uint32_t inLen,
    void * const outBuff, uint32_t * const outLen)
{
    RT_LOG(RT_LOG_INFO, "Start to buff get info, type is %d.", static_cast<int32_t>(type));

    return NpuDriver::BuffGetInfo(type, inBuff, inLen, outBuff, outLen);
}

rtError_t  ApiImpl::MemGrpCacheAlloc(const char_t *const name, const int32_t devId,
    const rtMemGrpCacheAllocPara *const para)
{
    RT_LOG(RT_LOG_INFO, "Start to pre alloc group %s memory.", name);
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::MemGrpCacheAlloc(name, devId, para);
}

rtError_t ApiImpl::MemGrpAddProc(const char_t * const name, const int32_t pid, const rtMemGrpShareAttr_t * const attr)
{
    RT_LOG(RT_LOG_INFO, "Start to add process %d in group %s.", pid, name);
    return NpuDriver::MemGrpAddProc(name, pid, attr);
}

rtError_t ApiImpl::MemGrpAttach(const char_t * const name, const int32_t timeout)
{
    RT_LOG(RT_LOG_INFO, "Start to attach group %s, timeout=%dms.", name, timeout);
    TIMESTAMP_NAME(__func__);
    return NpuDriver::MemGrpAttach(name, timeout);
}

rtError_t ApiImpl::MemGrpQuery(rtMemGrpQueryInput_t * const input, rtMemGrpQueryOutput_t * const output)
{
    RT_LOG(RT_LOG_INFO, "Start to query group, cmd is %d.", input->cmd);

    return NpuDriver::MemGrpQuery(input, output);
}

rtError_t ApiImpl::MemCopy2DSync(void * const dst, const uint64_t dstPitch, const void * const src,
    const uint64_t srcPitch, const uint64_t width, const uint64_t height,
    const rtMemcpyKind_t kind, const rtMemcpyKind newKind)
{
    (void)newKind;
    RT_LOG(RT_LOG_DEBUG, "sync memcpy2d, dstPitch=%" PRIu64 ", srcPitch=%" PRIu64 ", width=%" PRIu64
           ", height=%" PRIu64 ", kind=%d.", dstPitch, srcPitch, width, height, kind);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_ERROR(!(curCtx->IsCaptureModeSupport()), RT_ERROR_STREAM_CAPTURE_MODE_NOT_SUPPORT,
        "The current capture mode:threadCaptureMode=%d, exchangeCaptureMode=%d, contextCaptureMode=%d",
        InnerThreadLocalContainer::GetThreadCaptureMode(),
        InnerThreadLocalContainer::GetThreadExchangeCaptureMode(), curCtx->GetContextCaptureMode());

    TIMESTAMP_BEGIN(MemCopy2D);
    const rtError_t ret = curCtx->Device_()->Driver_()->MemCopy2D(dst, dstPitch, src, srcPitch, width, height, kind,
        static_cast<uint32_t>(DEVMM_MEMCPY2D_SYNC), 0UL, nullptr);
    TIMESTAMP_END(MemCopy2D);

    return ret;
}

rtError_t ApiImpl::MemCopy2DAsync(void * const dst, const uint64_t dstPitch, const void * const src,
    const uint64_t srcPitch, const uint64_t width, const uint64_t height, Stream * const stm,
    const rtMemcpyKind_t kind, const rtMemcpyKind newKind)
{
    (void)newKind;
    RT_LOG(RT_LOG_DEBUG, "sync memcpy2d, dstPitch=%" PRIu64 ", srcPitch=%" PRIu64 ", width=%" PRIu64
           ", height=%" PRIu64 ", kind=%d.", dstPitch, srcPitch, width, height, kind);
    rtError_t error = RT_ERROR_NONE;
    uint64_t remainSize = width * height;
    uint64_t realSize = 0UL;
    uint64_t fixedSize = 0UL;
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Memcpy2D async failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    while (remainSize > 0UL) {
        error = curCtx->MemCopy2DAsync(dst, dstPitch, src, srcPitch, width, height, kind, &realSize, curStm, fixedSize);
        if (error != RT_ERROR_NONE) {
            return error;
        }
        fixedSize += realSize;
        remainSize -= realSize;
    }
    return error;
}

rtError_t ApiImpl::MemcpyHostTask(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cnt,
    const rtMemcpyKind_t kind, Stream * const stm)
{
    RT_LOG(RT_LOG_INFO, "memCopy for host task, kind=%d.", kind);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    if (Runtime::Instance()->ChipIsHaveStars()) {
        COND_RETURN_ERROR(!(curCtx->IsCaptureModeSupport()), RT_ERROR_STREAM_CAPTURE_MODE_NOT_SUPPORT,
            "The current capture mode:threadCaptureMode=%d, exchangCaptureMode=%d, contextCaptureMode=%d",
            InnerThreadLocalContainer::GetThreadCaptureMode(),
            InnerThreadLocalContainer::GetThreadExchangeCaptureMode(), curCtx->GetContextCaptureMode());
        return curCtx->Device_()->Driver_()->MemCopySync(dst, destMax, src, cnt, kind);
    }
    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    } else {
        if ((curStm->Flags() & RT_STREAM_FORBIDDEN_DEFAULT) != 0) {
            Stream * const onlineStream = curCtx->OnlineStream_();
            Stream * const defaultStream = curCtx->DefaultStream_();
            curStm = (onlineStream != nullptr) ? onlineStream : defaultStream;
            NULL_STREAM_PTR_RETURN_MSG(curStm);
        }
    }
    HostTaskMemCpy *hostTask = new (std::nothrow) HostTaskMemCpy(curCtx->Device_(), dst, destMax, src, cnt, kind);
    NULL_PTR_RETURN_MSG(hostTask, RT_ERROR_INVALID_VALUE);
    const rtError_t error = hostTask->AsyncCall();
    if (error != RT_ERROR_NONE) {
        DELETE_O(hostTask);
        ERROR_RETURN(error, "MemCpyAsync failed. error = %d", error);
    }
    curStm->InsertPendingList(static_cast<uint32_t>(RT_HOST_TASK_TYPE_MEMCPY), hostTask);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::CmoTaskLaunch(const rtCmoTaskInfo_t * const taskInfo, Stream * const stm, const uint32_t flag)
{
    RT_LOG(RT_LOG_DEBUG, "Cmo Task launch. opCode=%u, lengthInner=%u", taskInfo->opCode, taskInfo->lengthInner);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_ERROR(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT, "stream is not in current ctx");

    return curCtx->CmoTaskLaunch(taskInfo, curStm, flag);
}

rtError_t ApiImpl::CmoAddrTaskLaunch(void *cmoAddrInfo, const uint64_t destMax,
    const rtCmoOpCode_t cmoOpCode, Stream * const stm, const uint32_t flag)
{
    RT_LOG(RT_LOG_DEBUG, "CmoAddr Task launch. opCode=%d, destMax is %" PRIu64"(bytes)", cmoOpCode, destMax);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
    }
    COND_RETURN_ERROR(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT, "stream is not in current ctx");

    return curCtx->CmoAddrTaskLaunch(static_cast<rtCmoAddrInfo *>(cmoAddrInfo), destMax, cmoOpCode, curStm, flag);
}

rtError_t ApiImpl::BarrierTaskLaunch(const rtBarrierTaskInfo_t * const taskInfo, Stream * const stm,
    const uint32_t flag)
{
    RT_LOG(RT_LOG_DEBUG, "Barrier Task launch.");
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_ERROR(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT, "stream is not in current ctx");

    return curCtx->BarrierTaskLaunch(taskInfo, curStm, flag);
}

rtError_t ApiImpl::SetDeviceSatMode(const rtFloatOverflowMode_t floatOverflowMode)
{
    Context * const curCtx = CurrentContext();
    const bool isValidFlag = ContextManage::CheckContextIsValid((curCtx), true);
    if (isValidFlag) {
        const ContextProtect cp(curCtx);
        curCtx->Device_()->SetSatMode(floatOverflowMode);
        RT_LOG(RT_LOG_INFO, "Set saturation mode to %u for device %u", floatOverflowMode, curCtx->Device_()->Id_());
    }
    Runtime::Instance()->SetSatMode(floatOverflowMode);
    RT_LOG(RT_LOG_INFO, "Set saturation mode to %u for runtime process.", floatOverflowMode);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetDeviceSatMode(rtFloatOverflowMode_t * const floatOverflowMode)
{
    *floatOverflowMode = Runtime::Instance()->GetSatMode();
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetDeviceSatModeForStream(Stream * const stm, rtFloatOverflowMode_t * const floatOverflowMode)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    *floatOverflowMode = curStm->GetSatMode();

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::SetStreamOverflowSwitch(Stream * const stm, const uint32_t flags)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    rtFloatOverflowMode_t overflowModel = RT_OVERFLOW_MODE_UNDEF;
    (void)GetDeviceSatMode(&overflowModel);
    COND_RETURN_ERROR_MSG_INNER((overflowModel != RT_OVERFLOW_MODE_SATURATION), RT_ERROR_FEATURE_NOT_SUPPORT,
        "overflow switch only support saturation mode(%d), current mode is %d.",
        RT_OVERFLOW_MODE_SATURATION, overflowModel);

    Stream * const targetStm = (stm == nullptr) ? curCtx->DefaultStream_() : stm;
    NULL_STREAM_PTR_RETURN_MSG(targetStm);
    COND_RETURN_ERROR(targetStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "stream is not in current ctx, stream_id=%d.", targetStm->Id_());
    return curCtx->SetStreamOverflowSwitch(targetStm, flags);
}

rtError_t ApiImpl::GetStreamOverflowSwitch(Stream * const stm, uint32_t * const flags)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Stream * const targetStm = (stm == nullptr) ? curCtx->DefaultStream_() : stm;
    NULL_STREAM_PTR_RETURN_MSG(targetStm);
    COND_RETURN_ERROR(targetStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "stream is not in current ctx, stream_id=%d.", targetStm->Id_());

    *flags = Runtime::Instance()->ChipIsHaveStars() ? static_cast<uint32_t>(targetStm->GetOverflowSwtich()) : 1U;
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::DvppGroupCreate(DvppGrp **grp, const uint32_t flags)
{
    RT_LOG(RT_LOG_DEBUG, "flags=%#x.", flags);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    return curCtx->DvppGroupCreate(grp, flags);
}

rtError_t ApiImpl::DvppGroupDestory(DvppGrp *grp)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    return curCtx->DvppGroupDestory(grp);
}

rtError_t ApiImpl::DvppWaitGroupReport(DvppGrp * const grp, const rtDvppGrpCallback callBackFunc, const int32_t timeout)
{
    RT_LOG(RT_LOG_DEBUG, "dvpp wait grp report timeout=%dms.", timeout);
    Context * const curCtx = grp->getContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    return curCtx->DvppWaitGroupReport(grp, callBackFunc, timeout);
}

rtError_t ApiImpl::SetStreamTag(Stream * const stm, const uint32_t geOpTag)
{
    RT_LOG(RT_LOG_DEBUG, "geOpTag=%#x.", geOpTag);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream * const targetStm = (stm == nullptr) ? curCtx->DefaultStream_() : stm;
    NULL_STREAM_PTR_RETURN_MSG(targetStm);
    COND_RETURN_ERROR(targetStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "stream is not in current ctx, stream_id=%d.", targetStm->Id_());
    return curCtx->SetStreamTag(targetStm, geOpTag);
}

rtError_t ApiImpl::GetStreamTag(Stream * const stm, uint32_t * const geOpTag)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Stream * const targetStm = (stm == nullptr) ? curCtx->DefaultStream_() : stm;
    NULL_STREAM_PTR_RETURN_MSG(targetStm);
    COND_RETURN_ERROR(targetStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "stream is not in current ctx, stream_id=%d.", targetStm->Id_());

    *geOpTag = static_cast<uint32_t>(targetStm->GetStreamTag());
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetVisibleDeviceIdByLogicDeviceId(const int32_t logicDeviceId, int32_t * const visibleDeviceId)
{
    const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(static_cast<uint32_t>(logicDeviceId),
        reinterpret_cast<uint32_t *>(visibleDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Get logicDeviceId:%d is err:%#x", logicDeviceId, static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::CtxSetSysParamOpt(const rtSysParamOpt configOpt, const int64_t configVal)
{
    rtError_t error = RT_ERROR_NONE;
    RT_LOG(RT_LOG_DEBUG, "Start to set sys param opt, opt=%d.", configOpt);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    RT_LOG(RT_LOG_INFO, "curCtx = %p, configOpt=%d, configVal=%lld.", curCtx, configOpt, configVal);
    
    error = curCtx->CtxSetSysParamOpt(configOpt, configVal);
    ERROR_RETURN(error, "Set sys param opt failed, retCode=%#x.", error);

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::CtxGetSysParamOpt(const rtSysParamOpt configOpt, int64_t * const configVal)
{
    RT_LOG(RT_LOG_DEBUG, "Start to get sys param opt, opt=%d.", configOpt);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const rtError_t ret = curCtx->CtxGetSysParamOpt(configOpt, configVal);
    RT_LOG(RT_LOG_INFO, "ret=%#x, curCtx = %p, configOpt=%d, *configVal=%lld.", ret, curCtx, configOpt, (*configVal));
    return ret;
}

rtError_t ApiImpl::CtxGetOverflowAddr(void ** const overflowAddr)
{
    RT_LOG(RT_LOG_DEBUG, "Start to get cur ctx overflow addr.");
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    *overflowAddr = curCtx->CtxGetOverflowAddr();
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetDeviceSatStatus(void * const outputAddrPtr, const uint64_t outputSize, Stream * const stm)
{
    RT_LOG(RT_LOG_DEBUG, "Start to get sat status.");
    uint64_t realSize = 0U;
    rtError_t error = RT_ERROR_NONE;
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }

    COND_RETURN_ERROR(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "stream is not in current ctx, stream_id=%d.", curStm->Id_());

    if (curCtx->Device_()->GetDevProperties().deviceSatStatus == DeviceSatStatus::DEVICE_SAT_STATUS_V2) {
        error = curCtx->GetSatStatusForStars(outputSize, curStm);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    }

    error = curCtx->MemcpyAsync(outputAddrPtr, outputSize, curCtx->CtxGetOverflowAddr(),
        outputSize, RT_MEMCPY_DEVICE_TO_DEVICE, curStm, &realSize, nullptr, nullptr);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "MemcpyAsync failed destMax=%llu.", outputSize);
    }

    return error;
}

rtError_t ApiImpl::CleanDeviceSatStatus(Stream * const stm)
{
    RT_LOG(RT_LOG_DEBUG, "Start to clean sat status.");
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_ERROR(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "stream is not in current ctx, stream_id=%d.", curStm->Id_());
    const rtError_t error = curCtx->MemsetAsync(curCtx->CtxGetOverflowAddr(), OVERFLOW_ADDR_MAX_SIZE,
        0U, OVERFLOW_ADDR_MAX_SIZE, curStm);
    return error;
}

rtError_t ApiImpl::GetAllUtilizations(const int32_t devId, const rtTypeUtil_t kind, uint8_t * const util)
{
    RT_LOG(RT_LOG_INFO, "drv devId=%d, util type=%d.", devId, kind);
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%d].", devId);
    return NpuDriver::GetAllUtilizations(devId, kind, util);
}

rtError_t ApiImpl::GetTaskBufferLen(const rtTaskBuffType_t type, uint32_t *const bufferLen)
{
    RT_LOG(RT_LOG_INFO, "Start to get task buffer len.");
    constexpr uint32_t dynamicBuffSize = 5U;  // Dynamic Task: 8B + 3 * 4B(tiling_data)

    switch (type) {
        case HWTS_STATIC_TASK_DESC:
            *bufferLen = sizeof(uint64_t);  // Static Task: 8B
            break;
        case HWTS_DYNAMIC_TASK_DESC:
            *bufferLen = dynamicBuffSize * sizeof(uint32_t);
            break;
        case PARAM_TASK_INFO_DESC:
            // Param bufferLen: (Prefetch Task data 12B + args 8B) * N, N = PARMA_PARAM_BUFFER_MAX_N
            *bufferLen = PARMA_PARAM_BUFFER_MAX_N * 20U;
            break;
        default:
            RT_LOG_OUTER_MSG_INVALID_PARAM(type, "[0, " + std::to_string(MAX_TASK) + ")");
            return RT_ERROR_INVALID_VALUE;
    }
    RT_LOG(RT_LOG_INFO, "Get Task Buffer Len success. bufferLen=%zu, task type=%d.", *bufferLen, type);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::TaskSqeBuild(const rtTaskInput_t * const taskInput, uint32_t * const taskLen)
{
    RT_LOG(RT_LOG_INFO, "Start to build task sqe, stream_id=%hu, taskType=%u.",
        taskInput->compilerInfo.streamId, taskInput->compilerInfo.taskType);
    return ConstructSqeByTaskInput(taskInput,taskLen);
}

rtError_t ApiImpl::GetKernelBin(const char_t *const binFileName, char_t **const buffer, uint32_t *length)
{
    RT_LOG(RT_LOG_INFO, "Start to get condition kernel bin binFileName = %s", binFileName);
    const rtError_t error = Runtime::Instance()->GetKernelBin(binFileName, buffer, length);
    return error;
}

rtError_t ApiImpl::GetBinBuffer(const rtBinHandle binHandle, const rtBinBufferType_t type, void **bin,
                                uint32_t *binSize)
{
    return Runtime::Instance()->GetBinBuffer(binHandle, type, bin, binSize);
}

rtError_t ApiImpl::FreeKernelBin(char_t * const buffer)
{
    RT_LOG(RT_LOG_INFO, "FreeKernelBin");
    const rtError_t error = Runtime::Instance()->FreeKernelBin(buffer);
    return error;
}

rtError_t ApiImpl::EschedQueryInfo(const uint32_t devId, const rtEschedQueryType type,
    rtEschedInputInfo *inPut, rtEschedOutputInfo *outPut)
{
    RT_LOG(RT_LOG_INFO, "Start to Query Esched Info");
    COND_RETURN_ERROR(CheckCurCtxValid(static_cast<int32_t>(devId)) != RT_ERROR_NONE, RT_ERROR_CONTEXT_NULL,
                      "Current Context is null, drv devId[%lu].", devId);
    return NpuDriver::EschedQueryInfo(devId, type, inPut, outPut);
}

rtError_t ApiImpl::GetDevArgsAddr(Stream * const stm, rtArgsEx_t * const argsInfo,
    void **devArgsAddr, void **argsHandle)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    return curCtx->GetDevArgsAddr(stm, argsInfo, devArgsAddr, argsHandle);
}

rtError_t ApiImpl::ModelCheckArchVersion(const char_t *omArchVersion, const rtArchType_t archType)
{
    RT_LOG(RT_LOG_INFO, "Start to check omArchVersion=%s, archType=%d", omArchVersion, archType);
    rtError_t error = RT_ERROR_NONE;
    if (omArchVersion[0U] == '\0') {
        RT_LOG(RT_LOG_WARNING, "Old version no need to compare, default is consistent.");
    } else {
        error = Runtime::Instance()->ModelCheckArchVersion(omArchVersion, archType);
    }
    return error;
}

rtError_t ApiImpl::ReserveMemAddress(void** devPtr, size_t size, size_t alignment, void *devAddr, uint64_t flags)
{
    const rtError_t error = NpuDriver::ReserveMemAddress(devPtr, size, alignment, devAddr, flags);
    RT_LOG(RT_LOG_INFO, "device malloc Succ, size=%" PRIu64 ", start ptr=%p, end ptr=%p",
        size, *devPtr, RtPtrToPtr<void *>(RtPtrToPtr<uint8_t *>(*devPtr) + size));
    return error;
}

rtError_t ApiImpl::ReleaseMemAddress(void* devPtr)
{
    RT_LOG(RT_LOG_INFO, "device free mem=0x%llx", reinterpret_cast<uint64_t *>(devPtr));
    const rtError_t error = NpuDriver::ReleaseMemAddress(devPtr);
    return error;
}

rtError_t ApiImpl::MallocPhysical(rtDrvMemHandle* handle, size_t size, rtDrvMemProp_t* prop, uint64_t flags)
{
    /* 输出参数handle在上下文中作为一个整体使用, 内部的devid不用进行转换 */
    RT_LOG(RT_LOG_INFO, "Start to MallocPhysical");
    return NpuDriver::MallocPhysical(handle, size, prop, flags);
}

rtError_t ApiImpl::FreePhysical(rtDrvMemHandle handle)
{
    RT_LOG(RT_LOG_INFO, "Start to FreePhysical");
    return NpuDriver::FreePhysical(handle);
}

rtError_t ApiImpl::MapMem(void* devPtr, size_t size, size_t offset, rtDrvMemHandle handle, uint64_t flags)
{
    const rtError_t error = NpuDriver::MapMem(devPtr, size, offset, handle, flags);
    ERROR_RETURN(error, "failed, size=%" PRIu64 ", ptr=%p.", size, devPtr);
    RT_LOG(RT_LOG_INFO, "device malloc Succ, size=%" PRIu64 ", start ptr=%p, end ptr=%p",
        size, devPtr, RtPtrToPtr<void *>(RtPtrToPtr<uint8_t *>(devPtr) + size));
    return error;
}

rtError_t ApiImpl::UnmapMem(void* devPtr)
{
    RT_LOG(RT_LOG_INFO, "device free mem=%p", devPtr);
    const rtError_t error = NpuDriver::UnmapMem(devPtr);
    ERROR_RETURN(error, "failed mem=%p", devPtr);
    return error;
}

rtError_t ApiImpl::MemSetAccess(void *virPtr, size_t size, rtMemAccessDesc *desc, size_t count)
{
    const rtError_t error = NpuDriver::MemSetAccess(virPtr, size, desc, count);
    ERROR_RETURN(error, "failed, ptr=0x%llx, size=%" PRIu64 ", count=%" PRIu64, RtPtrToValue(virPtr), size, count);
    return error;
}

rtError_t ApiImpl::MemGetAccess(void *virPtr, rtMemLocation *location, uint64_t *flags)
{
    const rtError_t error = NpuDriver::MemGetAccess(virPtr, location, flags);
    ERROR_RETURN(error, "failed, ptr=%p, location=%d, flags=%#" PRIu64 ".", virPtr, *location, *flags);
    return error;
}

rtError_t ApiImpl::ExportToShareableHandle(rtDrvMemHandle handle, rtDrvMemHandleType handleType,
    uint64_t flags, uint64_t *shareableHandle)
{
    uint64_t drvFlags = 0UL;
    rtError_t error = NpuDriver::ExportToShareableHandle(handle, handleType, drvFlags, shareableHandle);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    if ((flags & RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION) != 0UL) {
        error = NpuDriver::SetMemShareHandleDisablePidVerify(*shareableHandle);
    }
    RT_LOG(RT_LOG_INFO,
        "handleType=%d, flags=%#" PRIx64 ", shareableHandle=%" PRIu64 ".",
        handleType,
        flags,
        *shareableHandle);
    return error;
}

rtError_t ApiImpl::ExportToShareableHandleV2(
    rtDrvMemHandle handle, rtMemSharedHandleType handleType, uint64_t flags, void *shareableHandle)
{
    rtError_t error = RT_ERROR_NONE;
    if (handleType == RT_MEM_SHARE_HANDLE_TYPE_FABRIC) {
        Context *curCtx = Runtime::Instance()->CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        NULL_PTR_RETURN_MSG(curCtx->Device_(), RT_ERROR_DEVICE_NULL);
        const uint32_t devId = curCtx->Device_()->Id_();
        int64_t localServerId = 0;
        error = NpuDriver::GetServerId(devId, &localServerId);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE,
            error,
            "This device does not support cross-server communication drv devId=%u localServerId=%" PRId64 "err:%#x",
            devId,
            localServerId,
            static_cast<uint32_t>(error));
    }
    uint64_t drvFlags = 0UL;
    error = NpuDriver::ExportToShareableHandleV2(handle, handleType, drvFlags, shareableHandle);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    if ((flags & RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION) != 0UL) {
        uint64_t shareableHandleU64 = 0UL;
        uint32_t serverId = 0U;
        error = NpuDriver::GetServerIdAndshareableHandle(handleType, shareableHandle, &serverId, &shareableHandleU64);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
        error = NpuDriver::SetMemShareHandleDisablePidVerify(shareableHandleU64);
    }
    RT_LOG(RT_LOG_INFO, "handleType=%d, flags=%#" PRIu64 "", handleType, flags);
    return error;
}

rtError_t ApiImpl::ImportFromShareableHandle(uint64_t shareableHandle, int32_t devId, rtDrvMemHandle *handle)
{
    /* 输出参数handle在上下文中作为一个整体使用, 内部的devid不用进行转换 */
    RT_LOG(RT_LOG_INFO, "Start to ImportFromShareableHandle, drv devId=%d", devId);
    COND_RETURN_ERROR(CheckCurCtxValid(devId) != RT_ERROR_NONE,
        RT_ERROR_CONTEXT_NULL,
        "Current Context is null, drv devId[%d].",
        devId);

    uint32_t peerPhyDeviceId = 0U;
    auto error = NpuDriver::GetPhyDevIdByMemShareHandle(shareableHandle, &peerPhyDeviceId);
    if (error == RT_ERROR_DRV_NOT_SUPPORT) {
        return NpuDriver::ImportFromShareableHandle(shareableHandle, devId, handle);
    }

    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    Context *const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device *const dev = curCtx->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    error = dev->EnableP2PWithOtherDevice(peerPhyDeviceId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    return NpuDriver::ImportFromShareableHandle(shareableHandle, devId, handle);
}

rtError_t ApiImpl::ImportFromShareableHandleV2(const void *shareableHandle, rtMemSharedHandleType handleType,
    uint64_t flags, int32_t devId, rtDrvMemHandle *handle)
{
    UNUSED(flags);
    /* 输出参数handle在上下文中作为一个整体使用, 内部的devid不用进行转换 */
    rtError_t error = RT_ERROR_NONE;
    // handleType为fabric，获取localServerId
    int64_t localServerId = 0;
    if (handleType == RT_MEM_SHARE_HANDLE_TYPE_FABRIC) {
        error = NpuDriver::GetServerId(devId, &localServerId);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE,
            error,
            "This device does not support cross-server communication devId:%d ServerId:%ld err:%#x",
            devId,
            localServerId,
            static_cast<uint32_t>(error));
    }
    uint32_t peerServerId = 0U;
    uint64_t shareableHandleU64 = 0UL;
    error = NpuDriver::GetServerIdAndshareableHandle(handleType, shareableHandle, &peerServerId, &shareableHandleU64);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    // handleType为none 或 为fabric但是检测到为同一个ServerId
    if (handleType == RT_MEM_SHARE_HANDLE_TYPE_DEFAULT || static_cast<int64_t>(peerServerId) == localServerId) {
        uint32_t peerPhyDeviceId = 0U;
        error = NpuDriver::GetPhyDevIdByMemShareHandle(shareableHandleU64, &peerPhyDeviceId);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
        Context *const curCtx = CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        Device *const dev = curCtx->Device_();
        NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
        uint32_t hostId = 0U;
        error = NpuDriver::GetHostID(&hostId);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
        if (hostId != peerPhyDeviceId) {
            error = dev->EnableP2PWithOtherDevice(peerPhyDeviceId);
        }
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    }
    return NpuDriver::ImportFromShareableHandleV2(shareableHandle, handleType, devId, handle);
}

rtError_t ApiImpl::SetPidToShareableHandle(uint64_t shareableHandle, int32_t pid[], uint32_t pidNum)
{
    RT_LOG(RT_LOG_INFO, "Start to SetPidToShareableHandle");
    return NpuDriver::SetPidToShareableHandle(shareableHandle, pid, pidNum);
}

rtError_t ApiImpl::SetPidToShareableHandleV2(
    const void *shareableHandle, rtMemSharedHandleType handleType, int32_t pid[], uint32_t pidNum)
{
    rtError_t error = RT_ERROR_NONE;
    uint32_t serverId = 0U;
    uint64_t shareableHandleU64 = 0UL;
    error = NpuDriver::GetServerIdAndshareableHandle(handleType, shareableHandle, &serverId, &shareableHandleU64);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    error = NpuDriver::SetPidToShareableHandle(shareableHandleU64, pid, pidNum);
    RT_LOG(RT_LOG_DEBUG, "handleType = %d pidNum = %d.", handleType, pidNum);
    return error;
}

rtError_t ApiImpl::GetAllocationGranularity(rtDrvMemProp_t *prop, rtDrvMemGranularityOptions option,
    size_t *granularity)
{
    RT_LOG(RT_LOG_INFO, "Start to GetAllocationGranularity");
    return NpuDriver::GetAllocationGranularity(prop, option, granularity);
}

rtError_t ApiImpl::DeviceStatusQuery(const uint32_t devId, rtDeviceStatus *deviceStatus)
{
    return Runtime::Instance()->GetWatchDogDevStatus(devId, deviceStatus);
}

rtError_t ApiImpl::BindHostPid(rtBindHostpidInfo info)
{
    RT_LOG(RT_LOG_INFO, "Start to BindHostPid");
    return NpuDriver::BindHostPid(info);
}

rtError_t ApiImpl::UnbindHostPid(rtBindHostpidInfo info)
{
    RT_LOG(RT_LOG_INFO, "Start to UnbindHostPid");
    return NpuDriver::UnbindHostPid(info);
}

rtError_t ApiImpl::QueryProcessHostPid(int32_t pid, uint32_t *chipId, uint32_t *vfId,
    uint32_t *hostPid, uint32_t *cpType)
{
    RT_LOG(RT_LOG_INFO, "Start to QueryProcessHostPid");
    return NpuDriver::QueryProcessHostPid(pid, chipId, vfId, hostPid, cpType);
}

rtError_t ApiImpl::AiCpuTaskSupportCheck()
{
    const Runtime * const rtInstance = Runtime::Instance();
    NULL_PTR_RETURN_MSG(rtInstance, RT_ERROR_INSTANCE_NULL);
    COND_RETURN_WITH_NOLOG(!IS_SUPPORT_CHIP_FEATURE(rtInstance->GetChipType(),
        RtOptionalFeatureType::RT_FEATURE_TASK_AICPU_DOT_SUPPORT_CHECK), RT_ERROR_NONE);
    COND_RETURN_ERROR_MSG_INNER(rtInstance->GetAicpuCnt() == 0,
        RT_ERROR_FEATURE_NOT_SUPPORT, "not support aicpu task!");
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::SetStreamSqLockUnlock(Stream * const stm, const bool isLock)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device *const device = curCtx->Device_();
    NULL_PTR_RETURN_MSG(device, RT_ERROR_DEVICE_NULL);
    // only support 11 ADC
    COND_RETURN_WITH_NOLOG(!(device->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_STREAM_LOCKABLE)),
        RT_ERROR_NONE);

    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Set stream sq lock unlock run failed, stream is not in current ctx, stream_id=%d.", stm->Id_());
    return curCtx->SetStreamSqLockUnlock(stm, isLock);
}

rtError_t ApiImpl::ShrIdSetPodPid(const char *name, uint32_t sdid, int32_t pid)
{
    RT_LOG(RT_LOG_INFO, "Start to ShrIdSetPodPid name=%s, sdid=%d, pid=%d", name, sdid, pid);
    return NpuDriver::ShrIdSetPodPid(name, sdid, pid);
}

rtError_t ApiImpl::ShmemSetPodPid(const char *name, uint32_t sdid, int32_t pid[], int32_t num)
{
    RT_LOG(RT_LOG_INFO, "Start to ShmemSetPodPid name=%s, sdid=%u, pid=%d", name, sdid, pid[0]);
    return NpuDriver::ShmemSetPodPid(name, sdid, pid, num);
}

rtError_t ApiImpl::DevVA2PA(uint64_t devAddr, uint64_t len, Stream *stm, bool isAsync)
{
    RT_LOG(RT_LOG_INFO, "isAsync:%d", isAsync);
    if (isAsync) {
        Context * const curCtx = CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        NULL_STREAM_PTR_RETURN_MSG(stm); // need stream
        COND_RETURN_ERROR(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
            "stream is not in current ctx, stream_id=%d.", stm->Id_());
        return curCtx->SetUpdateAddrTask(devAddr, len, stm);
    }
    return NpuDriver::UpdateAddrVA2PA(devAddr, len);
}

rtError_t ApiImpl::StreamClear(Stream * const stm, rtClearStep_t step)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    if (!dev->IsStarsPlatform()) {
        RT_LOG(RT_LOG_ERROR, "feature support only in stars platform");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    if (!dev->CheckFeatureSupport(TS_FEATURE_MC2_ENHANCE)) {
        RT_LOG(RT_LOG_ERROR, "feature not support because tsch version too low");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "StreamClear failed, stream is not in current ctx, stream_id=%d.", stm->Id_());

    return curCtx->StreamClear(stm, step);
}

rtError_t ApiImpl::StreamAbort(Stream * const stm)
{
    RT_LOG(RT_LOG_INFO, "stream abort start");
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "StreamAbort failed, stream is not in current ctx, stream_id=%d.", stm->Id_());

    return curCtx->StreamAbort(stm);
}

rtError_t ApiImpl::GetStackBuffer(const rtBinHandle binHandle, const uint32_t coreType, const uint32_t coreId,
                                  const void **stack, uint32_t *stackSize)
{
    RT_LOG(RT_LOG_INFO, "Get stack buffer, bin handle %p, coreType %u, coreId %u", binHandle, coreType, coreId);
    Context *const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    return curCtx->GetStackBuffer(binHandle, coreType, coreId, stack, stackSize);
}

rtError_t ApiImpl::DebugSetDumpMode(const uint64_t mode)
{
    RT_LOG(RT_LOG_INFO, "set debug mode %llu start", mode);
    Context *const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    return curCtx->DebugSetDumpMode(mode);
}

rtError_t ApiImpl::DebugGetStalledCore(rtDbgCoreInfo_t *const coreInfo)
{
    Context *const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    return curCtx->DebugGetStalledCore(coreInfo);
}

rtError_t ApiImpl::DebugReadAICore(rtDebugMemoryParam_t *const param)
{
    Context *const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    return curCtx->DebugReadAICore(param);
}

rtError_t ApiImpl::GetExceptionRegInfo(const rtExceptionInfo_t * const exceptionInfo,
    rtExceptionErrRegInfo_t **exceptionErrRegInfo, uint32_t *num)
{
    Context *const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    return curCtx->GetExceptionRegInfo(exceptionInfo, exceptionErrRegInfo, num);
}

rtError_t ApiImpl::GetServerIDBySDID(uint32_t sdid, uint32_t *srvId)
{
    NULL_PTR_RETURN_MSG_OUTER(srvId, RT_ERROR_INVALID_VALUE);
    uint32_t chipId = 0U;
    uint32_t dieId = 0U;
    uint32_t pyhId = 0U;
    Context *const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device *device = curCtx->Device_();
    NULL_PTR_RETURN_MSG(device, RT_ERROR_DEVICE_NULL);
    Driver *driver = device->Driver_();
    NULL_PTR_RETURN_MSG(driver, RT_ERROR_DRV_NULL);
    const auto ret = driver->ParseSDID(sdid, srvId, &chipId, &dieId, &pyhId);
    return ret;
}

rtError_t ApiImpl::ModelNameSet(Model * const mdl, const char_t * const name)
{
    RT_LOG(RT_LOG_INFO, "model name set, mode_id=%u, name=%s", mdl->Id_(), name);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT,
        "Model name set failed. model context is not current ctx");
    return curCtx->ModelNameSet(mdl, name);
}

rtError_t ApiImpl::SetDefaultDeviceId(const int32_t deviceId)
{
    RT_LOG(RT_LOG_INFO, "set default drv devId=%d.", deviceId);
    Runtime *rtInstance = Runtime::Instance();
    NULL_PTR_RETURN_MSG(rtInstance, RT_ERROR_INSTANCE_NULL);
    rtInstance->SetDefaultDeviceId(deviceId);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::CtxGetCurrentDefaultStream(Stream ** const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    *stm = curCtx->DefaultStream_();
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetPrimaryCtxState(const int32_t devId, uint32_t *flags, int32_t *active)
{
    Runtime * const rt = Runtime::Instance();
    return rt->GetPrimaryCtxState(devId, flags, active);
}

rtError_t ApiImpl::RegStreamStateCallback(const char_t *regName, void *callback, void *args,
    StreamStateCallback type)
{
    RT_LOG(RT_LOG_INFO, "Reg stream state callback, regName=%s.", regName);
    return StreamStateCallbackManager::Instance().RegStreamStateCallback(regName, callback, args, type);
}

rtError_t ApiImpl::ResetDeviceForce(const int32_t devId)
{
    return DeviceReset(devId, true);
}

rtError_t ApiImpl::DeviceResetForce(const int32_t devId)
{
    RT_LOG(RT_LOG_EVENT, "reset device force, drv devId=%d.", devId);
    return ResetDeviceForce(devId);
}

rtError_t ApiImpl::GetLastErr(rtLastErrLevel_t level)
{
    rtError_t ret = ACL_RT_SUCCESS;
    if (level == RT_THREAD_LEVEL) {
        ret = InnerThreadLocalContainer::GetGlobalErr();
    } else if (level == RT_CONTEXT_LEVEL) {
        Context * const curCtx = CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, ACL_ERROR_RT_CONTEXT_NULL);
        ret = curCtx->GetContextLastErr();
    } else {
        // do nothing
    }
    RT_LOG(RT_LOG_EVENT, "level=%d err=%d.", level, ret);
    return ret;
}

rtError_t ApiImpl::PeekLastErr(rtLastErrLevel_t level)
{
    rtError_t ret = ACL_RT_SUCCESS;
    if (level == RT_THREAD_LEVEL) {
        ret = InnerThreadLocalContainer::PeekGlobalErr();
    } else if (level == RT_CONTEXT_LEVEL) {
        Context * const curCtx = CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, ACL_ERROR_RT_CONTEXT_NULL);
        ret = curCtx->PeekContextLastErr();
    } else {
        // do nothing
    }
    RT_LOG(RT_LOG_EVENT, "level=%d err=%u.", level, ret);
    return ret;
}

rtError_t ApiImpl::GetDeviceStatus(const int32_t devId, rtDevStatus_t * const status)
{
    RT_LOG(RT_LOG_DEBUG, "Get device status, drv devId=%d.", devId);
    Driver* const npuDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    NULL_PTR_RETURN_MSG(npuDrv, RT_ERROR_DRV_NULL);

    return npuDrv->GetDeviceStatus(static_cast<uint32_t>(devId), reinterpret_cast<drvStatus_t *>(status));
}

static rtError_t UpdatePlatformRes(fe::PlatFormInfos &platformInfos, const rtDevResLimitType_t type, const uint32_t value)
{
    const std::string socInfoKey = "SoCInfo";
    std::map<std::string, std::string> res;
    if (!platformInfos.GetPlatformResWithLock(socInfoKey, res)) {
        RT_LOG(RT_LOG_ERROR, "get platform result failed");
        return RT_ERROR_INVALID_VALUE;
    }

    switch (type) {
        case RT_DEV_RES_CUBE_CORE:
            res["ai_core_cnt"] = std::to_string(value);
            res["cube_core_cnt"] = std::to_string(value);
            break;
        case RT_DEV_RES_VECTOR_CORE:
            res["vector_core_cnt"] = std::to_string(value);
            break;
        default:
            RT_LOG(RT_LOG_ERROR, "Unsupported resource type: %d", type);
            return RT_ERROR_INVALID_VALUE;
    }

    platformInfos.SetPlatformResWithLock(socInfoKey, res);
    return RT_ERROR_NONE;
}

static rtError_t SetDeviceResLimitByFe(const uint32_t devId, const rtDevResLimitType_t type, const uint32_t value)
{
    Runtime *const rt = Runtime::Instance();
    const rtSocType_t socType = rt->GetSocType();
    const std::string socVersion = GetSocVersionStrByType(socType);
    uint32_t platformRet = fe::PlatformInfoManager::GeInstance().InitRuntimePlatformInfos(socVersion);
    if (platformRet != 0U) {
        RT_LOG(RT_LOG_ERROR,
            "InitRuntime PlatformInfos failed, drv devId=%u, socType=%d, socVersion=%s, platformRet=%u",
            devId,
            socType,
            socVersion.c_str(),
            platformRet);
        return RT_ERROR_INVALID_VALUE;
    }

    fe::PlatFormInfos platformInfos;
    platformRet = fe::PlatformInfoManager::GeInstance().GetRuntimePlatformInfosByDevice(devId, platformInfos);
    if (platformRet != 0U) {
        RT_LOG(RT_LOG_ERROR,
            "get runtime platformInfos by device failed, drv devId=%u, platformRet=%u",
            devId,
            platformRet);
        return RT_ERROR_INVALID_VALUE;
    }

    const auto error = UpdatePlatformRes(platformInfos, type, value);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "update platform res failed, drv devId=%u", devId);
        return error;
    }

    platformRet = fe::PlatformInfoManager::GeInstance().UpdateRuntimePlatformInfosByDevice(devId, platformInfos);
    if (platformRet != 0U) {
        RT_LOG(RT_LOG_ERROR, "update platformInfos failed, drv devId=%u, platformRet=%u", devId, platformRet);
        return RT_ERROR_INVALID_VALUE;
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::SetDeviceResLimit(const uint32_t devId, const rtDevResLimitType_t type, uint32_t value)
{
    RT_LOG(RT_LOG_INFO, "drv devId=%u, type=%d, value=%u.", devId, type, value);
    Runtime *const rt = Runtime::Instance();
    Device *const dev = rt->GetDevice(devId, static_cast<uint32_t>(RT_TSC_ID));
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    const uint32_t initValue = dev->GetResInitValue(type);
    COND_RETURN_OUT_ERROR_MSG_CALL(value > initValue,
        RT_ERROR_INVALID_VALUE,
        "value exceeds the total number of cores, drv devId=%u, type=%d, value=%u, total number of cores=%u.",
        devId,
        type,
        value,
        initValue);

    const auto error = SetDeviceResLimitByFe(devId, type, value);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    dev->InsertResLimit(type, value);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::ResetDeviceResLimit(const uint32_t devId)
{
    RT_LOG(RT_LOG_INFO, "drv devId=%u.", devId);
    Runtime *const rt = Runtime::Instance();
    Device *const dev = rt->GetDevice(devId, static_cast<uint32_t>(RT_TSC_ID));
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    dev->ResetResLimit();

    auto error = SetDeviceResLimitByFe(devId, RT_DEV_RES_CUBE_CORE, dev->GetResValue(RT_DEV_RES_CUBE_CORE));
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    error = SetDeviceResLimitByFe(devId, RT_DEV_RES_VECTOR_CORE, dev->GetResValue(RT_DEV_RES_VECTOR_CORE));
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetDeviceResLimit(const uint32_t devId, const rtDevResLimitType_t type, uint32_t *value)
{
    Runtime *const rt = Runtime::Instance();
    Device *const dev = rt->GetDevice(devId, static_cast<uint32_t>(RT_TSC_ID));
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    *value = dev->GetResValue(type);
    RT_LOG(RT_LOG_INFO, "type=%d, value=%u.", type, *value);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetDeviceUuid(const int32_t devId, rtUuid_t *uuid)
{
    RT_LOG(RT_LOG_DEBUG, "Get device uuid, drv devId=%d.", devId);
    int32_t drvRetUuidSize = RT_NPU_UUID_LENGTH;
    return NpuDriver::GetDeviceInfoByBuff(static_cast<uint32_t>(devId), MODULE_TYPE_SYSTEM, INFO_TYPE_UUID,
        uuid->bytes, &drvRetUuidSize);
}

static rtError_t SetStreamResLimitByType(Stream *const stm, const rtDevResLimitType_t type, const uint32_t value)
{
    const Device *dev = stm->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    const uint32_t initValue = dev->GetResInitValue(type);
    COND_RETURN_OUT_ERROR_MSG_CALL(value > initValue,
        RT_ERROR_INVALID_VALUE,
        "value exceeds the total number of cores, drv devId=%u, type=%d, value=%u, total number of cores=%u.",
        dev->Id_(),
        type,
        value,
        initValue);

    // There is no restriction that it must be less than the SetDeviceResLimit setting
    stm->InsertResLimit(type, value);
    RT_LOG(RT_LOG_INFO, "drv devId=%u, stream_id=%d, type=%d, value=%u.", dev->Id_(), stm->Id_(), type, value);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::SetStreamResLimit(Stream *const stm, const rtDevResLimitType_t type, const uint32_t value)
{
    rtError_t ret = RT_ERROR_NONE;
    if (stm == nullptr) {
        Context *const curCtx = CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        Stream *const defaultStream = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(defaultStream);
        ret = SetStreamResLimitByType(defaultStream, type, value);
    } else {
        ret = SetStreamResLimitByType(stm, type, value);
    }
    return ret;
}

rtError_t ApiImpl::ResetStreamResLimit(Stream *const stm)
{
    if (stm == nullptr) {
        Context *const curCtx = CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        Stream *const defaultStream = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(defaultStream);
        defaultStream->ResetResLimit();
        RT_LOG(RT_LOG_INFO, "default stream_id=%d.", defaultStream->Id_());
    } else {
        stm->ResetResLimit();
        RT_LOG(RT_LOG_INFO, "stream_id=%d.", stm->Id_());
    }
    return RT_ERROR_NONE;
}

static rtError_t GetStreamResLimitByType(const Stream *const stm, const rtDevResLimitType_t type, uint32_t *const value)
{
    const bool resLimitFlag = stm->GetResLimitFlag(type);
    if (resLimitFlag) {
        *value = stm->GetResValue(type);
    } else {
        const Device *dev = stm->Device_();
        NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
        *value = dev->GetResValue(type);
    }
    RT_LOG(RT_LOG_INFO, "stream_id=%d, resLimitFlag=%d, type=%d, value=%u.", stm->Id_(), resLimitFlag, type, *value);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetStreamResLimit(const Stream *const stm, const rtDevResLimitType_t type, uint32_t *const value)
{
    rtError_t ret = RT_ERROR_NONE;
    if (stm == nullptr) {
        Context *const curCtx = CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        Stream *const defaultStream = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(defaultStream);
        ret = GetStreamResLimitByType(defaultStream, type, value);
    } else {
        ret = GetStreamResLimitByType(stm, type, value);
    }
    return ret;
}

rtError_t ApiImpl::UseStreamResInCurrentThread(const Stream *const stm)
{
    const Stream *curStm = stm;
    if (curStm == nullptr) {
        Context *const curCtx = CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    InnerThreadLocalContainer::SetCurrentResLimitStream(curStm);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::NotUseStreamResInCurrentThread(const Stream *const stm)
{
    const Stream *curStm = stm;
    if (curStm == nullptr) {
        Context *const curCtx = CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }

    const Stream *curResLimitStream = InnerThreadLocalContainer::GetCurrentResLimitStream();
    if (curResLimitStream == curStm) {
        InnerThreadLocalContainer::SetCurrentResLimitStream(nullptr);
    } else {
        RT_LOG(RT_LOG_EVENT, "Try to unbind non-current stream.");
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetResInCurrentThread(const rtDevResLimitType_t type, uint32_t *const value)
{
    const auto curResLimitStream = InnerThreadLocalContainer::GetCurrentResLimitStream();
    if (curResLimitStream != nullptr && curResLimitStream->GetResLimitFlag(type)) {
        *value = curResLimitStream->GetResValue(type);
        RT_LOG(RT_LOG_INFO, "stream_id=%d, type=%d, value=%u.", curResLimitStream->Id_(), type, *value);
    } else {
        Device* dev = InnerThreadLocalContainer::GetDevice();
        if (dev == nullptr) {
            Context *const curCtx = CurrentContext();
            CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
            dev = curCtx->Device_();
	        NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
        }
        *value = dev->GetResValue(type);
        RT_LOG(RT_LOG_INFO, "drv devId=%u, type=%d, value=%u.", dev->Id_(), type, *value);
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::HdcServerCreate(const int32_t devId, const rtHdcServiceType_t type, rtHdcServer_t * const server)
{
    RT_LOG(RT_LOG_DEBUG, "HdcServerCreate, drv devId=%d, type = %d.", devId, type);
    return NpuDriver::HdcServerCreate(devId, type, server);
}

rtError_t ApiImpl::HdcServerDestroy(rtHdcServer_t const server)
{
    RT_LOG(RT_LOG_DEBUG, "Start to destroy hdc server.");
    return NpuDriver::HdcServerDestroy(server);
}

rtError_t ApiImpl::HdcSessionConnect(const int32_t peerNode, const int32_t peerDevId, rtHdcClient_t const client,
    rtHdcSession_t * const session)
{
    RT_LOG(RT_LOG_DEBUG, "HdcSessionConnect, peerNode=%d, peerDevId = %d.", peerNode, peerDevId);
    return NpuDriver::HdcSessionConnect(peerNode, peerDevId, client, session);
}

rtError_t ApiImpl::HdcSessionClose(rtHdcSession_t const session)
{
    RT_LOG(RT_LOG_DEBUG, "Start to close hdc session.");
    return NpuDriver::HdcSessionClose(session);
}

rtError_t ApiImpl::GetHostCpuDevId(int32_t * const devId)
{
    *devId = DEFAULT_HOSTCPU_USER_DEVICE_ID;
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetLogicDevIdByUserDevId(const int32_t userDevId, int32_t * const logicDevId)
{
    int32_t realDeviceId = 0;
    const rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(
        static_cast<uint32_t>(userDevId), reinterpret_cast<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Error input devId:%d is err:%#x",
        userDevId, static_cast<uint32_t>(error));
    *logicDevId = realDeviceId;
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetUserDevIdByLogicDevId(const int32_t logicDevId, int32_t * const userDevId)
{
    int32_t realDeviceId = 0;
    const rtError_t error = Runtime::Instance()->GetUserDevIdByDeviceId(
        static_cast<uint32_t>(logicDevId), reinterpret_cast<uint32_t *>(&realDeviceId));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Error input devId:%d is err:%#x",
        logicDevId, static_cast<uint32_t>(error));
    *userDevId = realDeviceId;
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::StreamBeginCapture(Stream * const stm, const rtStreamCaptureMode mode)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "stream is not in current ctx, stream_id=%d.", stm->Id_());
    COND_RETURN_ERROR_MSG_INNER(stm->Model_() != nullptr, RT_ERROR_STREAM_MODEL,
        "stream is binded, stream_id=%d, model_id=%u.", stm->Id_(), stm->Model_()->Id_());
    COND_RETURN_ERROR_MSG_INNER((stm == curCtx->DefaultStream_()), RT_ERROR_FEATURE_NOT_SUPPORT,
        "the default stream cannot be captured.");

    return curCtx->StreamBeginCapture(stm, mode);
}

rtError_t ApiImpl::StreamEndCapture(Stream * const stm, Model ** const captureMdl)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "stream is not in current ctx, stream_id=%d.", stm->Id_());
    COND_RETURN_ERROR_MSG_INNER(stm->Model_() != nullptr, RT_ERROR_STREAM_MODEL,
        "stream is binded, stream_id=%d, model_id=%u.", stm->Id_(), stm->Model_()->Id_());
    COND_RETURN_ERROR_MSG_INNER((stm == curCtx->DefaultStream_()), RT_ERROR_FEATURE_NOT_SUPPORT,
        "the default stream cannot be captured.");

    return curCtx->StreamEndCapture(stm, captureMdl);
}

rtError_t ApiImpl::StreamBeginTaskUpdate(Stream * const stm, TaskGroup * handle)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "stream is not in current ctx, stream_id=%d.", stm->Id_());
    return curCtx->StreamBeginTaskUpdate(stm, handle);
}

rtError_t ApiImpl::StreamEndTaskUpdate(Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "stream is not in current ctx, stream_id=%d.", stm->Id_());
    return curCtx->StreamEndTaskUpdate(stm);
}

rtError_t ApiImpl::StreamGetCaptureInfo(const Stream * const stm, rtStreamCaptureStatus * const status,
                                        Model ** const captureMdl)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "stream is not in current ctx, stream_id=%d.", stm->Id_());

    return curCtx->StreamGetCaptureInfo(stm, status, captureMdl);
}

rtError_t ApiImpl::SetStreamCacheOpInfoSwitch(const Stream * const stm, uint32_t cacheOpInfoSwitch)
{
    // The ctx is not checked for performance.
    stm->SetStreamCacheOpInfoOriginSwitch(cacheOpInfoSwitch);
    RT_LOG(RT_LOG_DEBUG, "device_id=%u, stream_id=%u, cacheOpInfoSwitch=%u.", stm->Device_()->Id_(), stm->Id_(),
        cacheOpInfoSwitch);
 
    if (stm->IsCapturing() && stm->GetCaptureStream() != nullptr && stm->GetCaptureStream()->IsOrigCaptureStream()) {
        CaptureModel *mdl = dynamic_cast<CaptureModel *>(stm->GetCaptureStream()->Model_());
        RT_LOG(RT_LOG_INFO, "set cache op info switch status, model_id = %u, steam_id=%u, status=%u.",
            mdl->Id_(), stm->Id_(), cacheOpInfoSwitch);
        mdl->SetModelCacheOpInfoSwitch(cacheOpInfoSwitch);
    }
 
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetStreamCacheOpInfoSwitch(const Stream * const stm, uint32_t * const cacheOpInfoSwitch)
{
    // The ctx is not checked for performance.
    // main stream is not closed & this stream is opened
    *cacheOpInfoSwitch = stm->GetStreamCacheOpInfoSwitch();
 
    RT_LOG(RT_LOG_DEBUG, "device_id=%u, stream_id=%d, cacheOpInfoSwitch=%u.", stm->Device_()->Id_(), stm->Id_(),
        *cacheOpInfoSwitch);
 
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::ModelGetNodes(const Model * const mdl, uint32_t * const num)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT,
        "model context is not current ctx, model_id=%u.", mdl->Id_());

    return curCtx->ModelGetNodes(mdl, num);
}

rtError_t ApiImpl::ModelDebugDotPrint(const Model * const mdl)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT,
        "model context is not current ctx, model_id=%u.", mdl->Id_());

    return curCtx->ModelDebugDotPrint(mdl);
}

rtError_t ApiImpl::ModelDebugJsonPrint(const Model * const mdl, const char* path, const uint32_t flags)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT,
        "model context is not current ctx, model_id=%u.", mdl->Id_());

    return curCtx->ModelDebugJsonPrint(mdl, path, flags);
}

rtError_t ApiImpl::StreamAddToModel(Stream * const stm, Model * const captureMdl)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "stream is not in current ctx, stream_id=%d.", stm->Id_());
    COND_RETURN_ERROR_MSG_INNER(stm->Model_() != nullptr, RT_ERROR_STREAM_MODEL,
        "stream is binded, stream_id=%d, model_id=%u.", stm->Id_(), stm->Model_()->Id_());
    COND_RETURN_ERROR_MSG_INNER(captureMdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT,
        "model context is not current ctx, model_id=%u.", captureMdl->Id_());
    COND_RETURN_ERROR_MSG_INNER((stm == curCtx->DefaultStream_()), RT_ERROR_FEATURE_NOT_SUPPORT,
        "the default stream cannot be captured."); 
    
    return curCtx->StreamAddToModel(stm, captureMdl);
}

rtError_t ApiImpl::ThreadExchangeCaptureMode(rtStreamCaptureMode * const mode)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    return curCtx->ThreadExchangeCaptureMode(mode);
}

rtError_t ApiImpl::StreamBeginTaskGrp(Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "stream is not in current ctx, stream_id=%d.", stm->Id_());
    return curCtx->StreamBeginTaskGrp(stm);
}

rtError_t ApiImpl::StreamEndTaskGrp(Stream * const stm, TaskGroup ** const handle)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "stream is not in current ctx, stream_id=%d.", stm->Id_());
    return curCtx->StreamEndTaskGrp(stm, handle);
}

rtError_t ApiImpl::ParseMallocCfg(const rtMallocConfig_t * const cfg, rtConfigValue_t *cfgVal) const
{
    // 如果有多个重复的属性取最后一个
    for (size_t i = 0U; i < cfg->numAttrs; ++i) {
        switch (cfg->attrs[i].attr) {
            case RT_MEM_MALLOC_ATTR_RSV:
                break;
            case RT_MEM_MALLOC_ATTR_MODULE_ID:
                cfgVal->moduleId = cfg->attrs[i].value.moduleId;
                break;
            case RT_MEM_MALLOC_ATTR_DEVICE_ID:
                cfgVal->deviceId = cfg->attrs[i].value.deviceId;
                break;
            default:
                RT_LOG(RT_LOG_ERROR, "invalid attribute %d", cfg->attrs[i].attr);
                return RT_ERROR_INVALID_VALUE;
        }
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::DevMalloc(void ** const devPtr, const uint64_t size, rtMallocPolicy policy, rtMallocAdvise advise, 
                            const rtMallocConfig_t * const cfg)
{
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    rtMemType_t type = RT_MEMORY_DEFAULT;
    rtConfigValue_t cfgVal;
    cfgVal.moduleId = static_cast<uint16_t>(APP);
    cfgVal.deviceId = curCtx->Device_()->Id_();
    if (static_cast<uint32_t>(policy & MEM_TYPE_MASK) == RT_MEM_TYPE_LOW_BAND_WIDTH) {
        type = RT_MEMORY_DDR;
    } else if (static_cast<uint32_t>(policy & MEM_TYPE_MASK) == RT_MEM_TYPE_HIGH_BAND_WIDTH) {
        type = RT_MEMORY_HBM;
    } else {
        // default
    }

    if (static_cast<uint32_t>(static_cast<uint32_t>(policy) & static_cast<uint32_t>(RT_MEM_ACCESS_USER_SPACE_READONLY)) != 0U) {
        type |= RT_MEMORY_ATTRIBUTE_READONLY; // use for dvpp,  ddr | policy | readonly
    }
    policy = static_cast<rtMallocPolicy>(static_cast<uint32_t>(policy) & MEM_POLICY_MASK);
    if (policy == RT_MEM_MALLOC_HUGE_FIRST) {
        type |= RT_MEMORY_POLICY_HUGE_PAGE_FIRST;
    } else if (policy == RT_MEM_MALLOC_HUGE_ONLY) {
        type |= RT_MEMORY_POLICY_HUGE_PAGE_ONLY;
    } else if (policy == RT_MEM_MALLOC_NORMAL_ONLY) {
        type |= RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY;
    } else if (policy == RT_MEM_MALLOC_HUGE_FIRST_P2P) {
        type |= RT_MEMORY_POLICY_HUGE_PAGE_FIRST_P2P;
    } else if (policy == RT_MEM_MALLOC_HUGE_ONLY_P2P) {
        type |= RT_MEMORY_POLICY_HUGE_PAGE_ONLY_P2P;
    } else if (policy == RT_MEM_MALLOC_NORMAL_ONLY_P2P) {
        type |= RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY_P2P;
    } else if (policy == RT_MEM_MALLOC_HUGE1G_ONLY) {
        type |= RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY;
    } else if (policy == RT_MEM_MALLOC_HUGE1G_ONLY_P2P) {
        type |= RT_MEMORY_POLICY_HUGE1G_PAGE_ONLY_P2P;
    } else {
        type = RT_MEMORY_DEFAULT;
    }
    rtError_t error = RT_ERROR_NONE;
    if (cfg == nullptr) {
        RT_LOG(RT_LOG_INFO, "cfg is nullptr use default cfg");
    } else {
        error = ParseMallocCfg(cfg, &cfgVal);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE,
            "Parse rtMallocConfig failed, error=%#x.", static_cast<uint32_t>(error));
    }
    Runtime *rtInstance = Runtime::Instance();
    uint32_t realDeviceId = cfgVal.deviceId;
    if (cfgVal.deviceId != curCtx->Device_()->Id_()) {
        error = rtInstance->ChgUserDevIdToDeviceId(cfgVal.deviceId, &realDeviceId);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE,
            "deviceid=%u is invalid, retCode=%#x", cfgVal.deviceId, static_cast<uint32_t>(RT_ERROR_INVALID_VALUE));
        if (realDeviceId != curCtx->Device_()->Id_()) {
            RT_LOG(RT_LOG_ERROR, "invalid drv devId=%u, should be %u", realDeviceId, curCtx->Device_()->Id_());
            return RT_ERROR_INVALID_VALUE;
        }
    }
    
    cfgVal.moduleId = cfgVal.moduleId > DEFAULT_MODULEID ? static_cast<uint16_t>(APP) : cfgVal.moduleId;
    RT_LOG(RT_LOG_INFO, "size=%" PRIu64 ", advise=%u,type=%#x,moduleId=%hu.", size, advise, type, cfgVal.moduleId);
    const uint64_t tmpSize = (((size + 0x1FU) >> 5U) << 5U); // 32 byte align
    if (advise == RT_MEM_ADVISE_TS) {
        type |= RT_MEMORY_TS; // 申请TS内存 4G内;
    } else if (advise == RT_MEM_ADVISE_DVPP) {
        return curCtx->Device_()->Driver_()
            ->DevDvppMemAlloc(devPtr, tmpSize, realDeviceId, type, cfgVal.moduleId);
    } else {
        // no operation
    }
    RT_LOG(RT_LOG_INFO,"type=%#x.", type);
    return (curCtx->Device_()->Driver_())
        ->DevMemAlloc(devPtr, tmpSize, type, realDeviceId, cfgVal.moduleId, true, false, false, true);
}

rtError_t ApiImpl::MemReserveAddress(void** virPtr, size_t size, rtMallocPolicy policy, void *expectAddr, rtMallocConfig_t *cfg)
{
    UNUSED(cfg);
    rtError_t error;
    constexpr size_t alignment = 0U;
    constexpr uint64_t flags = 1ULL; // 0：normal page, 1：huge page
    
    if (static_cast<uint64_t>(policy) == static_cast<uint64_t>(RT_MEM_MALLOC_HUGE_FIRST)) {
        error = NpuDriver::ReserveMemAddress(virPtr, size, alignment, expectAddr, flags);
        // currently, only huge page is supported, small page can be added later here
    } else if (static_cast<uint64_t>(policy) == static_cast<uint64_t>(RT_MEM_MALLOC_HUGE_ONLY)) {
        error = NpuDriver::ReserveMemAddress(virPtr, size, alignment, expectAddr, flags);
    } else {
        RT_LOG(RT_LOG_ERROR, "flags of page type must be 0 or 1, current flags=%#llx", policy);
        return RT_ERROR_INVALID_VALUE;
    }

    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "huge page malloc failed, error=%#x.", static_cast<int32_t>(error));
        return error;
    }

    RT_LOG(RT_LOG_INFO, "device malloc Succ, size=%" PRIu64 ", start ptr=0x%llx, end ptr=0x%llx",
        size, reinterpret_cast<uint64_t *>(*virPtr),
        reinterpret_cast<uint64_t *>(reinterpret_cast<uint8_t *>(*virPtr) + size));
    return error;
}

rtError_t ApiImpl::MemMallocPhysical(rtMemHandle* handle, size_t size, rtMallocPolicy policy, rtMallocConfig_t *cfg)
{
    /* 输出参数handle在上下文中作为一个整体使用, 内部的devid不用进行转换 */
    RT_LOG(RT_LOG_INFO, "Start to malloc physical mem.");
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    rtDrvMemProp_t prop = {};
    rtMemType_t type = RT_MEMORY_DEFAULT;
    rtConfigValue_t cfgVal;
    cfgVal.moduleId = static_cast<uint16_t>(APP);
    cfgVal.deviceId = curCtx->Device_()->Id_();
    uint32_t pgType = 0UL;
    constexpr uint64_t flags = 0ULL; // drv flag, must be zero.

    if (static_cast<uint64_t>(policy) == static_cast<uint64_t>(RT_MEM_MALLOC_HUGE_ONLY | RT_MEM_TYPE_HIGH_BAND_WIDTH)) { // ACL_HBM_MEM_HUGE
        type = 0UL;
        pgType = 1UL; 
    } else if (static_cast<uint64_t>(policy) == static_cast<uint64_t>(RT_MEM_MALLOC_NORMAL_ONLY | RT_MEM_TYPE_HIGH_BAND_WIDTH)) { // ACL_HBM_MEM_NORMAL
        type = 0UL;
        pgType = 0UL;
    } else {
        RT_LOG(RT_LOG_ERROR, "invalid policy %#llx", policy);
        return RT_ERROR_INVALID_VALUE;
    }

    prop.side = 1UL; // currently only support mem on device
    prop.pg_type = pgType;
    prop.mem_type = type;
    prop.devid = cfgVal.deviceId;
    prop.module_id = cfgVal.moduleId;

    if (cfg == nullptr) {
        return NpuDriver::MallocPhysical(reinterpret_cast<rtDrvMemHandle*>(handle), size, &prop, flags);
    }

    const rtError_t error = ParseMallocCfg(cfg, &cfgVal);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE,
            "Parse rtMallocConfig failed, error=%#x.", static_cast<uint32_t>(error));
    
    prop.module_id = cfgVal.moduleId > DEFAULT_MODULEID ? static_cast<uint16_t>(APP) : cfgVal.moduleId;
    prop.devid = cfgVal.deviceId;
    RT_LOG(RT_LOG_INFO, "size=%" PRIu64 ", type=%#x, pgType=%#x, moduleId=%hu, deviceId=%d.", size, type, prop.pg_type, prop.module_id, prop.devid);
    return NpuDriver::MallocPhysical(reinterpret_cast<rtDrvMemHandle*>(handle), size, &prop, flags);
}

rtError_t ApiImpl::GetThreadLastTaskId(uint32_t * const taskId)
{
    const uint32_t lastTaskId = InnerThreadLocalContainer::GetLastTaskId();
    *taskId = lastTaskId;
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::LaunchDvppTask(const void * const sqe, const uint32_t sqeLen, Stream * const stm, rtDvppCfg_t *cfg)
{
    RT_LOG(RT_LOG_INFO, "Start to launch dvpp task.");
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = (stm == nullptr) ? curCtx->DefaultStream_() : stm;
    NULL_STREAM_PTR_RETURN_MSG(curStm);
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "stream is not in current ctx, stream_id=%d.", curStm->Id_());

    const rtError_t error = curCtx->LaunchDvppTask(sqe, sqeLen, curStm, cfg);
    ERROR_RETURN(error, "Stars launch dvpp task failed.");
    return error;
}

rtError_t ApiImpl::LaunchRandomNumTask(const rtRandomNumTaskInfo_t *taskInfo, Stream * const stm, void *reserve)
{
    RT_LOG(RT_LOG_INFO, "Start to launch random num task.");
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = (stm == nullptr) ? curCtx->DefaultStream_() : stm;
    NULL_STREAM_PTR_RETURN_MSG(curStm);
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "stream is not in current ctx, stream_id=%d.", curStm->Id_());

    const rtError_t error = curCtx->LaunchRandomNumTask(taskInfo, curStm, reserve);
    ERROR_RETURN(error, "Stars launch random num task failed.");

    return error;
}

uint16_t ApiImpl::GetToBeCalSystemParaNum(const Kernel * const kernel) const
{
    // 获取系统参数大小，如果有overflow需要特殊处理
    const uint16_t sysParaNum = kernel->GetSystemParaNum();
    // 如果没有系统参数直接返回0
    if (sysParaNum == 0U) {
        return 0U;
    }
    // 需要根据Kernel句柄获取到系统参数大小，如果有overflow需要特殊处理，不算在开头系统参数内
    // 如果有系统参数，需要计算是否有overflow
    uint16_t toBeCalSysParaNum = kernel->IsSupportOverFlow() ? (sysParaNum - 1U) : sysParaNum;
    Runtime *rtInstance = Runtime::Instance();
    const rtChipType_t chipType = rtInstance->GetChipType();
    toBeCalSysParaNum = (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_KERNEL_INTER_CORE_SYNC_ADDR)) && 
        (kernel->IsNeedSetFftsAddrInArg() && (toBeCalSysParaNum > 1U)) ? toBeCalSysParaNum - 1U: toBeCalSysParaNum; // 1代表系统参数个数

    RT_LOG(RT_LOG_DEBUG, "sysParaNum=%u,toBeCalSysParaNum=%u,isSupportOverFlow=%u,IsNeedSetFftsAddrInArg=%u,chipType=%u.",
        sysParaNum, toBeCalSysParaNum, static_cast<uint8_t>(kernel->IsSupportOverFlow()),
        static_cast<uint8_t>(kernel->IsNeedSetFftsAddrInArg()), chipType);

    return toBeCalSysParaNum;
}

rtError_t ApiImpl::ProcessOverFlowArgs(RtArgsHandle *argsHandle)
{
    Kernel *kernel = reinterpret_cast<Kernel *>(argsHandle->funcHandle);
    // cpu kernel无需处理直接返回
    COND_RETURN_WITH_NOLOG(kernel->GetKernelRegisterType() == RT_KERNEL_REG_TYPE_CPU, RT_ERROR_NONE);
    // 需要判断是否做overflow参数处理
    COND_RETURN_WITH_NOLOG(argsHandle->isProcessedOverflow, RT_ERROR_NONE);
    COND_RETURN_WITH_NOLOG(kernel->GetSystemParaNum() == 0U, RT_ERROR_NONE);
    COND_RETURN_WITH_NOLOG(!kernel->IsSupportOverFlow(), RT_ERROR_NONE);

    // CPU Kernel是紧密排布， 所以做1字节对齐，非CPU Kernel（AIC/AIC）仍然是8字节对齐
    const size_t alignSize = (kernel->GetKernelRegisterType() == RT_KERNEL_REG_TYPE_CPU)
        ? CPU_KERNEL_ARGS_ALIGN_SIZE : NON_CPU_KERNEL_ARGS_ALIGN_SIZE;
    const size_t padding =
        ((argsHandle->argsSize % alignSize) == 0U) ? 0U : (alignSize - (argsHandle->argsSize % alignSize));
    const size_t realParaOffset = argsHandle->argsSize + padding;
    const size_t needOccupyOffset = realParaOffset + sizeof(uint64_t); // overflowAddr占8哥字节

    // 内存占用不能超过最大内存偏移
    COND_RETURN_ERROR_MSG_INNER((needOccupyOffset > argsHandle->bufferSize),
        RT_ERROR_INVALID_VALUE, "process overflow args failed, para size overflow, needOccupyOffset=%zu,total=%zu",
        needOccupyOffset, argsHandle->bufferSize);

    Context *const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const uint64_t overflowAddr = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(curCtx->CtxGetOverflowAddr()));
    uint64_t *overflowParaAddr =
        reinterpret_cast<uint64_t *>(reinterpret_cast<uint8_t *>(argsHandle->buffer) + realParaOffset);
    *overflowParaAddr = overflowAddr;
    argsHandle->argsSize = needOccupyOffset;
    argsHandle->isProcessedOverflow = true;

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::KernelArgsGetHandleMemSize(Kernel * const funcHandle, size_t *memSize)
{
    const uint16_t useraraNum = funcHandle->GetUserParaNum();
    // 需要依赖kernel句柄信息获取用户参数和系统参数
    *memSize = sizeof(RtArgsHandle) + (useraraNum * sizeof(ParaDetail));

    RT_LOG(RT_LOG_DEBUG, "memSize=%zu,useraraNum=%u,RtArgsHandle=%zu,rtParaDetail=%zu",
        *memSize, useraraNum, sizeof(RtArgsHandle), sizeof(ParaDetail));

    return  RT_ERROR_NONE;
}

rtError_t ApiImpl::KernelArgsFinalize(RtArgsHandle *argsHandle)
{
    // 需要判断是否做overflow参数处理, 如果在GetPlaceHolderBuffer处理过，不再处理
    rtError_t error = ProcessOverFlowArgs(argsHandle);
    ERROR_RETURN(error, "process over flow args failed,retCode=%#x.", error);

    Kernel *kernel = reinterpret_cast<Kernel *>(argsHandle->funcHandle);
    const KernelRegisterType regType = kernel->GetKernelRegisterType();
    Runtime *rtInstance = Runtime::Instance();
    NULL_PTR_RETURN_MSG(rtInstance, RT_ERROR_INSTANCE_NULL);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    // ffts plus inter core sync只支持CHIP_910_B_93和非CPU算子
    if ((regType == RT_KERNEL_REG_TYPE_CPU) || 
        (!curCtx->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_KERNEL_INTER_CORE_SYNC_ADDR)) ||
        !kernel->IsNeedSetFftsAddrInArg()) {
        argsHandle->isFinalized = 1U;
        argsHandle->isParamUpdating = 0U;
        return RT_ERROR_NONE;
    }

    // 暂时不考虑print, 获取ffts inter core addr 并写入
    uint64_t interCoreAddr = 0ULL;
    uint32_t len = 0U;
    error = GetC2cCtrlAddr(&interCoreAddr, &len);
    ERROR_RETURN(error, "get inter core addr failed, retCode=%#x", static_cast<uint32_t>(error));
    uint64_t *interCoreSyncAddr = reinterpret_cast<uint64_t *>(argsHandle->buffer);
    *interCoreSyncAddr = interCoreAddr;
    argsHandle->isFinalized = 1U;
    argsHandle->isParamUpdating = 0U;
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::KernelArgsInitByUserMem(Kernel * const funcHandle, RtArgsHandle *argsHandle, void *userHostMem,
        size_t actualArgsSize)
{
    argsHandle->buffer = userHostMem;
    argsHandle->bufferSize = actualArgsSize;
    argsHandle->realUserParamNum = 0U;
    argsHandle->maxUserParamNum = static_cast<uint8_t>(funcHandle->GetUserParaNum());
    argsHandle->placeHolderNum = 0U;
    argsHandle->funcHandle = funcHandle;
    argsHandle->argsSize = 0U;
    argsHandle->isProcessedOverflow = false;
    argsHandle->isGotPhBuff = false;
    argsHandle->isFinalized = 0U;
    argsHandle->isParamUpdating = 0U;
    (void)memset_s(&argsHandle->cpuKernelSysArgsInfo, sizeof(CpuKernelSysArgsInfo), 0, sizeof(CpuKernelSysArgsInfo));

    if (funcHandle->GetKernelRegisterType() == RT_KERNEL_REG_TYPE_NON_CPU) { // 非cpu kernel
        // 需要根据Kernel句柄获取到系统参数大小，如果有overflow需要特殊处理，不算在开头系统参数内
        const uint16_t toBeCalSysParaNum = GetToBeCalSystemParaNum(funcHandle);
        argsHandle->sysParamSize = toBeCalSysParaNum * sizeof(uint64_t);
        argsHandle->argsSize += argsHandle->sysParamSize;
    } else { // Cpu kernel没有系统参数
        argsHandle->maxUserParamNum = MAX_PARAM_CNT;
    }

    return  RT_ERROR_NONE;
}

rtError_t ApiImpl::KernelArgsGetMemSize(Kernel * const funcHandle, size_t userArgsSize, size_t *actualArgsSize)
{
    // CPU Kernel是紧密排布， 所以做1字节对齐，非CPU Kernel（AIC/AIC）仍然是8字节对齐
    if (funcHandle->GetKernelRegisterType() == RT_KERNEL_REG_TYPE_NON_CPU) {
        const uint16_t userParaNum = funcHandle->GetUserParaNum();
        // 因有padding要预留，按照最大8字节
        *actualArgsSize = userArgsSize + (MAX_SYSTEM_PARAM_CNT * SINGLE_NON_CPU_SYS_PARAM_SIZE) +
            (userParaNum * NON_CPU_KERNEL_ARGS_ALIGN_SIZE);

        RT_LOG(RT_LOG_DEBUG, "actualArgsSize=%zu,userArgsSize=%zu,userParaNum=%u", *actualArgsSize, userArgsSize, userParaNum);
            return RT_ERROR_NONE;
    }

    *actualArgsSize = userArgsSize; // CPU Kernel：soName和KernelName不需要排入Args，runtime已优化
    RT_LOG(RT_LOG_DEBUG, "actualArgsSize=%zu,userArgsSize=%zu", *actualArgsSize, userArgsSize);

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::KernelArgsInit(Kernel * const funcHandle, RtArgsHandle **argsHandle)
{
    static thread_local ArgsHandleAllocator threadArgsHandle;
    NULL_PTR_RETURN_MSG(threadArgsHandle.localArgsHandle_, RT_ERROR_MEMORY_ALLOCATION);

    RtArgsHandle *localArgsHandle = threadArgsHandle.localArgsHandle_;
    localArgsHandle->argsSize = 0U;
    localArgsHandle->realUserParamNum = 0U;
    localArgsHandle->placeHolderNum = 0U;
    localArgsHandle->sysParamSize = 0U;

    localArgsHandle->funcHandle = funcHandle;
    localArgsHandle->isProcessedOverflow = false;
    localArgsHandle->isGotPhBuff = false;
    localArgsHandle->bufferSize = MAX_ARGS_BUFF_SIZE;
    localArgsHandle->maxUserParamNum = MAX_PARAM_CNT;
    localArgsHandle->isFinalized = 0U;
    localArgsHandle->isParamUpdating = 0U;
    (void)memset_s(&localArgsHandle->cpuKernelSysArgsInfo, sizeof(CpuKernelSysArgsInfo), 0, sizeof(CpuKernelSysArgsInfo));

    if (funcHandle->GetKernelRegisterType() == RT_KERNEL_REG_TYPE_NON_CPU) {
        RT_LOG(RT_LOG_DEBUG, "non cpu kernel branch");
        const uint16_t toBeCalSysParaNum = GetToBeCalSystemParaNum(funcHandle);
        localArgsHandle->sysParamSize = toBeCalSysParaNum * sizeof(uint64_t);
        localArgsHandle->argsSize += localArgsHandle->sysParamSize;
    }

    *argsHandle = localArgsHandle;

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::KernelArgsAppendPlaceHolder(RtArgsHandle *argsHandle, ParaDetail **paraHandle)
{
    RT_LOG(RT_LOG_DEBUG, "enter append place holder ");
    // 开始排布数据区之后不允许再排布参数区
    COND_RETURN_ERROR_MSG_INNER(argsHandle->isGotPhBuff, RT_ERROR_FEATURE_NOT_SUPPORT,
        "not support append ph or common param after getting placeholder buffer");

    // 开始排布数据区之后不允许再排布参数区
    COND_RETURN_ERROR_MSG_INNER(argsHandle->isFinalized == 1U,
        RT_ERROR_FEATURE_NOT_SUPPORT, "not support append and get placeholder buffer after finalized");

    // 用户参数数量不能超过最大参数数量
    COND_RETURN_ERROR_MSG_INNER(((argsHandle->realUserParamNum + 1U) > argsHandle->maxUserParamNum),
        RT_ERROR_INVALID_VALUE,
        "para num exceed max num,current real user para num is %u,max user para num is %u",
        argsHandle->realUserParamNum, argsHandle->maxUserParamNum);

    const uint32_t idx = argsHandle->realUserParamNum;
    argsHandle->para[idx].type = 1U; // 0 is common param, 1 is place holder param

    const Kernel * const kernel = RtPtrToPtr<Kernel *>(argsHandle->funcHandle);
    // CPU Kernel是紧密排布， 所以做1字节对齐，非CPU Kernel（AIC/AIC）仍然是8字节对齐
    const size_t alignSize = (kernel->GetKernelRegisterType() == RT_KERNEL_REG_TYPE_CPU)
        ? CPU_KERNEL_ARGS_ALIGN_SIZE : NON_CPU_KERNEL_ARGS_ALIGN_SIZE;
    const size_t padding =
        ((argsHandle->argsSize % alignSize) == 0U) ? 0U : (alignSize - (argsHandle->argsSize % alignSize));
    const size_t realParaOffset = argsHandle->argsSize + padding;
    constexpr size_t phParamSize = sizeof(uint64_t); // placeholder内部放的是指针为8字节
    const size_t needOccupyOffset = realParaOffset + phParamSize;
    COND_RETURN_ERROR_MSG_INNER((needOccupyOffset > argsHandle->bufferSize),
        RT_ERROR_INVALID_VALUE, "args append failed,para size overflow,needOccupyOffset=%zu,total=%zu",
        needOccupyOffset, argsHandle->bufferSize);

    argsHandle->para[idx].paraOffset = realParaOffset;
    argsHandle->para[idx].paraSize = static_cast<uint32_t>(sizeof(uint64_t));
    argsHandle->para[idx].dataOffset = 0U;

    *paraHandle = ((argsHandle->para) + idx);
    argsHandle->argsSize = needOccupyOffset;
    argsHandle->realUserParamNum++;
    argsHandle->placeHolderNum++;

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::KernelArgsGetPlaceHolderBuffer(RtArgsHandle *argsHandle, ParaDetail *paraHandle, size_t dataSize, void **bufferAddr)
{
    RT_LOG(RT_LOG_DEBUG, "get placeholer start, dataSize=%zu", dataSize);
    // 对非place holder的参数如果获取Buffer做阻拦
    COND_RETURN_ERROR_MSG_INNER(paraHandle->type == 0U,
        RT_ERROR_INVALID_VALUE, "param type=0 not support get placeholer buffer");

    // 开始排布数据区之后不允许再排布参数区
    COND_RETURN_ERROR_MSG_INNER(argsHandle->isFinalized == 1U,
        RT_ERROR_FEATURE_NOT_SUPPORT, "not support append and get placeholer buffer after finalized");

    // 需要判断是否做overflow参数处理
    const rtError_t error = ProcessOverFlowArgs(argsHandle);
    ERROR_RETURN(error, "process over flow args failed,retCode=%#x.", error);

    const Kernel * const kernel = RtPtrToPtr<Kernel *>(argsHandle->funcHandle);
    // CPU Kernel是紧密排布， 所以做1字节对齐，非CPU Kernel（AIC/AIC）仍然是8字节对齐
    const size_t alignSize = (kernel->GetKernelRegisterType() == RT_KERNEL_REG_TYPE_CPU) ?
        CPU_KERNEL_ARGS_ALIGN_SIZE : NON_CPU_KERNEL_ARGS_ALIGN_SIZE;
    const size_t argsSize = argsHandle->argsSize;
    const size_t padding = ((argsSize % alignSize) == 0U) ? 0U : (alignSize - (argsSize % alignSize));
    const size_t realParaOffset = argsSize + padding;

    // 内存占用不能超过最大内存偏移
    const size_t needOccupyOffset = realParaOffset + dataSize;
    COND_RETURN_ERROR_MSG_INNER((needOccupyOffset > argsHandle->bufferSize),
        RT_ERROR_INVALID_VALUE, "get placeholer buff fail,size overflow,needOccupyOffset=%zu, total=%zu",
        needOccupyOffset, argsHandle->bufferSize);
    argsHandle->isGotPhBuff = true;
    paraHandle->dataOffset = realParaOffset;
    *bufferAddr = RtPtrToPtr<void *>(RtPtrToPtr<uint8_t *>(argsHandle->buffer) + paraHandle->dataOffset);
    argsHandle->argsSize = needOccupyOffset;

    RT_LOG(RT_LOG_DEBUG, "get placeholer end, dataSize=%zu, dataOffset=%zu, needOccupyOffset=%zu",
        dataSize, realParaOffset, needOccupyOffset);

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::KernelArgsAppend(RtArgsHandle *argsHandle, void *para, size_t paraSize, ParaDetail **paraHandle)
{
    RT_LOG(RT_LOG_DEBUG, "args append start, paraSize=%zu", paraSize);
    // 开始排布数据区之后不允许再排布参数区
    COND_RETURN_ERROR_MSG_INNER(argsHandle->isFinalized == 1U,
        RT_ERROR_FEATURE_NOT_SUPPORT, "not support append and get ph buffer after finalized");

    // 开始排布数据区之后不允许再排布参数区
    COND_RETURN_ERROR_MSG_INNER(argsHandle->isGotPhBuff,
        RT_ERROR_FEATURE_NOT_SUPPORT, "not support append ph or common param, after getting ph buffer");

    // 用户参数数量不能超过最大参数数量
    COND_RETURN_ERROR_MSG_INNER(((argsHandle->realUserParamNum + 1U) > argsHandle->maxUserParamNum),
        RT_ERROR_INVALID_VALUE,
        "para num exceed max num,current real user para num is %u,max user para num is %u",
        argsHandle->realUserParamNum, argsHandle->maxUserParamNum);
    const Kernel * const kernel = RtPtrToPtr<Kernel *>(argsHandle->funcHandle);
    // CPU Kernel是紧密排布， 所以做1字节对齐，非CPU Kernel（AIC/AIC）仍然是8字节对齐
    const size_t alignSize = (kernel->GetKernelRegisterType() == RT_KERNEL_REG_TYPE_CPU)
        ? CPU_KERNEL_ARGS_ALIGN_SIZE : NON_CPU_KERNEL_ARGS_ALIGN_SIZE;
    const size_t padding =
        ((argsHandle->argsSize % alignSize) == 0U) ? 0U : (alignSize - (argsHandle->argsSize % alignSize));
    const size_t realParaOffset = argsHandle->argsSize + padding;
    const size_t needOccupyOffset = realParaOffset + paraSize;

    // 内存占用不能超过最大内存偏移
    COND_RETURN_ERROR_MSG_INNER((needOccupyOffset > argsHandle->bufferSize),
        RT_ERROR_INVALID_VALUE, "args append failed, para size overflow, needOccupyOffset=%zu,total=%zu",
        needOccupyOffset, argsHandle->bufferSize);

    const uint8_t index = argsHandle->realUserParamNum;
    *paraHandle = &(argsHandle->para[index]);
    argsHandle->para[index].type = 0U; // 0 is Common param, 1 is place holder param
    argsHandle->para[index].paraOffset = realParaOffset; // 参数在整个内存中的偏移
    argsHandle->para[index].paraSize = paraSize;
    argsHandle->para[index].dataOffset = 0U;
    const uintptr_t offset = reinterpret_cast<uintptr_t>(argsHandle->buffer) + static_cast<uint64_t>(realParaOffset);
    const errno_t ret = memcpy_s(reinterpret_cast<void *>(offset), paraSize, para, paraSize);
    COND_RETURN_ERROR_MSG_INNER((ret != EOK),
        RT_ERROR_INVALID_VALUE, "args append, memcpy failed, retCode=%#x", static_cast<uint32_t>(ret));
    argsHandle->argsSize = needOccupyOffset; // 本地append参数后，内存偏移的变化
    argsHandle->realUserParamNum++;

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::MemcpyBatch(void **dsts, void **srcs, size_t *sizes, size_t count,
    rtMemcpyBatchAttr *attrs, size_t *attrsIdxs, size_t numAttrs, size_t *failIdx)
{
    RT_LOG(RT_LOG_DEBUG, "Start to batch memcpy, count=%zd, numAttrs=%zd.", count, numAttrs);
    rtError_t error;
    size_t attrIdx = 0U;
    rtMemcpyBatchAttr memAttr = attrs[0];
    rtPtrAttributes_t dstAttr = {};
    rtPtrAttributes_t srcAttr = {};
    rtMemLocationType realDstLoc = RT_MEMORY_LOC_MAX;
    rtMemLocationType realSrcLoc = RT_MEMORY_LOC_MAX;
    for (size_t i = 0U; i < count; i++) {
        if (((attrIdx + 1U) < numAttrs) && (i >= attrsIdxs[attrIdx + 1U])) {
            attrIdx = attrIdx + 1U;
            memAttr = attrs[attrIdx];
        }
        error = CheckMemCpyAttr(dsts[i], srcs[i], memAttr, dstAttr, srcAttr);
        realDstLoc = (dstAttr.location.type == RT_MEMORY_LOC_UNREGISTERED) ? RT_MEMORY_LOC_HOST : dstAttr.location.type;
        realSrcLoc = (srcAttr.location.type == RT_MEMORY_LOC_UNREGISTERED) ? RT_MEMORY_LOC_HOST : srcAttr.location.type;
        COND_PROC_RETURN_OUT_ERROR_MSG_CALL(error != RT_ERROR_NONE, error, *failIdx = i,
            "verification of the %zuth memory pair attributes failed, retCode=%#x", i, static_cast<uint32_t>(error));
        COND_PROC_RETURN_OUT_ERROR_MSG_CALL((realDstLoc == realSrcLoc), RT_ERROR_INVALID_VALUE, *failIdx = i,
            "only H2D and D2H copy directions are supported, dstLoc type=%d, srcLoc type=%d.", realDstLoc, realSrcLoc);
    }
    return NpuDriver::MemcpyBatch(reinterpret_cast<uint64_t *>(dsts), reinterpret_cast<uint64_t *>(srcs), sizes, count);
}

rtError_t ApiImpl::CheckMemCpyAttr(const void * const dst, const void * const src, const rtMemcpyBatchAttr &memAttr,
    rtPtrAttributes_t &dstAttr, rtPtrAttributes_t &srcAttr)
{
    rtMemLocationType memType; 
    rtError_t error = PtrGetAttributes(dst, &dstAttr);
    ERROR_RETURN(error, "get dst attribute failed, error=%#x", error);
    memType = (dstAttr.location.type == RT_MEMORY_LOC_UNREGISTERED) ? RT_MEMORY_LOC_HOST : dstAttr.location.type;
    COND_RETURN_OUT_ERROR_MSG_CALL(((memType != memAttr.dstLoc.type) ||
        ((memType == RT_MEMORY_LOC_DEVICE) && (dstAttr.location.id != memAttr.dstLoc.id))), RT_ERROR_INVALID_VALUE,
        "dst's real memory type is %d, but %d is inputted, or real device id is %d, but %d is inputted.",
        memType, memAttr.dstLoc.type, dstAttr.location.id, memAttr.dstLoc.id);

    error = PtrGetAttributes(src, &srcAttr);
    ERROR_RETURN(error, "get src attribute failed, error=%#x.", error);
    memType = (srcAttr.location.type == RT_MEMORY_LOC_UNREGISTERED) ? RT_MEMORY_LOC_HOST : srcAttr.location.type;
    COND_RETURN_OUT_ERROR_MSG_CALL(((memType != memAttr.srcLoc.type) ||
        ((memType == RT_MEMORY_LOC_DEVICE) && (srcAttr.location.id != memAttr.srcLoc.id))), RT_ERROR_INVALID_VALUE,
        "src's real memory type is %d, but %d is inputted, or real device id is %d, but %d is inputted.",
        memType, memAttr.srcLoc.type, srcAttr.location.id, memAttr.srcLoc.id);

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::LoopMemcpyAsync(void** const dsts, const size_t* const destMaxs, void** const srcs, const size_t* const sizes,
    const size_t count, const rtMemcpyBatchAttr* const attrs, const size_t* const attrsIdxs, const size_t numAttrs,
    size_t* const failIdx, Stream* const stm)
{
    rtError_t error = RT_ERROR_NONE;
    rtMemcpyBatchAttr memAttr = attrs[0];
    size_t attrIdx = 0U;
    rtPtrAttributes_t dstAttr = {};
    rtPtrAttributes_t srcAttr = {};
    rtMemLocationType realDstLoc = RT_MEMORY_LOC_MAX;
    rtMemLocationType realSrcLoc = RT_MEMORY_LOC_MAX;
    rtMemcpyKind_t kind;
    
    for (size_t i = 0U; i < count; i++) {
        COND_PROC_RETURN_ERROR_MSG_INNER((sizes[i] > destMaxs[i]), RT_ERROR_INVALID_VALUE, *failIdx = i,
            "Invalid size, current size=%" PRIu64 "(bytes), valid size range is (0, %" PRIu64 "]!", sizes[i], destMaxs[i]);
        
        COND_PROC_RETURN_ERROR_MSG_INNER((sizes[i] == 0U), 
            RT_ERROR_INVALID_VALUE, *failIdx = i, "sizes's value can not be 0, sizes[%zu]=%zu.", i, sizes[i]);

        COND_PROC_RETURN_ERROR_MSG_INNER(
            ((dsts[i] == nullptr) || (srcs[i] == nullptr)), 
            RT_ERROR_INVALID_VALUE, *failIdx = i, "dsts[%zu]'s value or srcs[%zu]'s value is nullptr.", i, i);

        if (((attrIdx + 1U) < numAttrs) && (i >= attrsIdxs[attrIdx + 1U])) {
            attrIdx = attrIdx + 1U;
            memAttr = attrs[attrIdx];
        }
        
        error = CheckMemCpyAttr(dsts[i], srcs[i], memAttr, dstAttr, srcAttr);
        realDstLoc = (dstAttr.location.type == RT_MEMORY_LOC_UNREGISTERED) ? RT_MEMORY_LOC_HOST : dstAttr.location.type;
        realSrcLoc = (srcAttr.location.type == RT_MEMORY_LOC_UNREGISTERED) ? RT_MEMORY_LOC_HOST : srcAttr.location.type;
        COND_PROC_RETURN_ERROR_MSG_INNER(
            error != RT_ERROR_NONE, error, *failIdx = i,
            "check attributes[%zu] failed, attributes of srcs[%zu] locationType=%d, dsts[%zu] locationType=%d, "
            "actually srcs[%zu] locationType=%d, dsts[%zu] locationType=%d.",
            i, i, memAttr.srcLoc.type, i, memAttr.dstLoc.type, i, realSrcLoc, i, realDstLoc);

        COND_PROC_RETURN_ERROR_MSG_INNER((realDstLoc == realSrcLoc),
            RT_ERROR_INVALID_VALUE, *failIdx = i, "Only H2D and D2H copy directions are supported, dstLoc type=%d, srcLoc type=%d.",
            realDstLoc, realSrcLoc);

        if (dstAttr.location.type == RT_MEMORY_LOC_DEVICE) {
            kind = RT_MEMCPY_HOST_TO_DEVICE;
        } else {
            kind = RT_MEMCPY_DEVICE_TO_HOST;
        }

        if (dstAttr.location.type == RT_MEMORY_LOC_UNREGISTERED || srcAttr.location.type == RT_MEMORY_LOC_UNREGISTERED) {
            Context * const curCtx = CurrentContext();
            CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

            Stream *curStm = stm;
            curStm = (curStm == nullptr) ? curCtx->DefaultStream_() : curStm;
            NULL_STREAM_PTR_RETURN_MSG(curStm);

            error = StreamSynchronize(curStm, -1); // timeout 设置为默认值
            ERROR_RETURN(error, "StreamSynchronize failed, stream_id=%d.", curStm->Id_());
            RT_LOG(RT_LOG_DEBUG, "Stream Synchronize success, stream_id=%d.", curStm->Id_());

            error = MemCopySync(dsts[i], destMaxs[i], srcs[i], sizes[i], kind);
        } else {
            error = MemcpyAsync(dsts[i], destMaxs[i], srcs[i], sizes[i], kind, stm, nullptr, nullptr, false, nullptr);
        }

        COND_RETURN_ERROR((error != RT_ERROR_NONE) && (error != RT_ERROR_DRV_NOT_SUPPORT), error,
            "Memcpy async failed, count=%" PRIu64 ", kind=%d.", sizes[i], kind);
    }

    return error;
}

rtError_t ApiImpl::MemcpyBatchAsync(void** const dsts, const size_t* const destMaxs, void** const srcs, const size_t* const sizes,
    const size_t count, const rtMemcpyBatchAttr* const attrs, const size_t* const attrsIdxs, const size_t numAttrs, size_t* const failIdx,
    Stream* const stm)
{
    Context *curCtx = Runtime::Instance()->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    NULL_PTR_RETURN_MSG(curCtx->Device_(), RT_ERROR_DEVICE_NULL);

    if (!NpuDriver::CheckIsSupportFeature(curCtx->Device_()->Id_(), MEMCPY_BATCH_ASYNC_FEATURE)) {
        return LoopMemcpyAsync(dsts, destMaxs, srcs, sizes, count, attrs, attrsIdxs, numAttrs, failIdx, stm);
    }
    return RT_ERROR_DRV_NOT_SUPPORT;
}

rtError_t ApiImpl::GetCmoDescSize(size_t *size)
{
    DevProperties properties;
    (void)GET_DEV_PROPERTIES(Runtime::Instance()->GetChipType(), properties);
    *size = properties.cmoDDRStructInfoSize;

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::SetCmoDesc(rtCmoDesc_t cmoDesc, void *srcAddr, size_t srcLen)
{
    DevProperties properties;
    (void)GET_DEV_PROPERTIES(Runtime::Instance()->GetChipType(), properties);
    if (properties.cmoDDRStructInfoSize == sizeof(rtStarsV2CmoAddrInfo)) {
        rtStarsV2CmoAddrInfo starsv2CmoAddrInfo = {};
        starsv2CmoAddrInfo.src = reinterpret_cast<uint64_t>(srcAddr);
        starsv2CmoAddrInfo.len_inner = srcLen;
        return MemCopySync(cmoDesc, sizeof(rtStarsV2CmoAddrInfo), &starsv2CmoAddrInfo,
            sizeof(rtStarsV2CmoAddrInfo), RT_MEMCPY_HOST_TO_DEVICE);
    }

    rtCmoAddrInfo cmoAddrInfo = {};
    cmoAddrInfo.src = reinterpret_cast<uint64_t>(srcAddr);
    cmoAddrInfo.len_inner = srcLen;
    return MemCopySync(cmoDesc, sizeof(rtCmoAddrInfo), &cmoAddrInfo,
        sizeof(rtCmoAddrInfo), RT_MEMCPY_HOST_TO_DEVICE);
}

rtError_t ApiImpl::MemWriteValue(const void * const devAddr, const uint64_t value, const uint32_t flag, Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }

    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "mem write value failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    return curCtx->MemWriteValue(devAddr, value, flag, curStm);
}

rtError_t ApiImpl::MemWaitValue(const void * const devAddr, const uint64_t value, const uint32_t flag, Stream * const stm)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }

    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "mem wait value failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    return curCtx->MemWaitValue(devAddr, value, flag, curStm);
}

rtError_t ApiImpl::ModelGetName(Model * const mdl, const uint32_t maxLen, char_t * const mdlName)
{
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_ERROR_MSG_INNER(mdl->Context_() != curCtx, RT_ERROR_MODEL_CONTEXT,
        "Get mdlName failed. model context is not current ctx");
    return curCtx->ModelGetName(mdl, maxLen, mdlName);
}

rtError_t ApiImpl::FuncGetName(const Kernel * const kernel, const uint32_t maxLen, char_t * const name) 
{   
    const errno_t error = memcpy_s(name, static_cast<size_t>(maxLen), kernel->Name_().c_str(), kernel->Name_().length() + 1U);
    if (error != EOK) {
        RT_LOG(RT_LOG_ERROR, "copy to func name failed, ret=%d, length=%zu.",
               error, kernel->Name_().length() + 1U);
        return RT_ERROR_SEC_HANDLE;
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetErrorVerbose(const uint32_t deviceId, rtErrorInfo * const errorInfo)
{
    UNUSED(deviceId);
    UNUSED(errorInfo);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::RepairError(const uint32_t deviceId, const rtErrorInfo * const errorInfo)
{
    UNUSED(deviceId);
    UNUSED(errorInfo);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::StarsLaunchEventProc(Stream * const stm, const rtCallback_t callBackFunc, void * const fnData, const uint64_t threadId)
{
    rtError_t ret = RT_ERROR_NONE;
    Event *curEvent = nullptr;
    ret = CallbackLaunchWithEvent(callBackFunc, fnData, stm, true, &curEvent, threadId);
    ERROR_RETURN(ret, "Call CallbackLaunch failed for block callback, ret=%#x.", ret);
    ret = stm->WaitEvent(curEvent, 0U);
    ERROR_RETURN(ret, "Call WaitEvent failed for block callback, ret=%#x.", ret);
    ret = curEvent->Reset(stm);
    ERROR_RETURN(ret, "Call Reset failed for block callback, ret=%#x.", ret);
    return ret;
}

rtError_t ApiImpl::StarsLaunchSubscribeProc(Stream * const stm, const rtCallback_t callBackFunc,
    void * const fnData, const bool needSubscribe, const uint64_t threadId)
{
    rtError_t ret = RT_ERROR_NONE;
    Runtime * const rtInstance = Runtime::Instance();
    if (needSubscribe && !(stm->IsCapturing())) {
        Event *curEvent = nullptr;
        ret = EventCreate(&curEvent, RT_EVENT_DDSYNC_NS);
        ERROR_RETURN(ret, "Call EventCreate failed for callback, ret=%#x.", ret);
        ret = rtInstance->SubscribeCallback(threadId, stm, static_cast<void *>(curEvent));
        if (ret != RT_ERROR_NONE) {
            (void)EventDestroy(curEvent);
        }
    }
    return StarsLaunchEventProc(stm, callBackFunc, fnData, threadId);
}

rtError_t ApiImpl::LaunchHostFunc(Stream * const stm, const rtCallback_t callBackFunc, void * const fnData)
{
    rtError_t ret = RT_ERROR_NONE;
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Stream *curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_ERROR_MSG_INNER(curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Callback launch failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());
    Runtime * const rtInstance = Runtime::Instance();
    Device * const dev = curCtx->Device_();
    NULL_PTR_RETURN_MSG_OUTER(dev, RT_ERROR_INVALID_VALUE);
    // lock first Check whether the thread exists. If the thread does not exist, create a thread in context level.
    curCtx->callbackTheadMutex_.lock();
    if (!curCtx->GetCallBackThreadExistFlag()) {
        COND_PROC_RETURN_OUT_ERROR_MSG_CALL((curCtx->CreateContextCallBackThread() != RT_ERROR_NONE),
            RT_ERROR_MEMORY_ALLOCATION, curCtx->callbackTheadMutex_.unlock(), "create callback thread failed.");
        curCtx->SetCallBackThreadExistFlag();
    }
    curCtx->callbackTheadMutex_.unlock();
    // if new stream should subscribe in map first; else launchcallback Directly
    const bool isNeedSubscribe = rtInstance->JudgeNeedSubscribe(curCtx->GetCallBackThreadId(), curStm, dev->Id_());
    if (rtInstance->ChipIsHaveStars()) {
        return StarsLaunchSubscribeProc(curStm, callBackFunc, fnData, isNeedSubscribe, curCtx->GetCallBackThreadId());
    } else {
        if (isNeedSubscribe) {
            ret = rtInstance->SubscribeCallback(curCtx->GetCallBackThreadId(), curStm, nullptr);
            ERROR_RETURN(ret, "Call SubscribeCallback failed for callback, ret=%#x.", ret);
        }
        return CallbackLaunchWithoutEvent(callBackFunc, fnData, curStm, true);
    }
}

rtError_t ApiImpl::CacheLastTaskOpInfo(const void * const infoPtr, const size_t infoSize)
{
    const uint32_t lastStreamId = InnerThreadLocalContainer::GetLastStreamId();
    RT_LOG(RT_LOG_INFO, "Received data: infoSize=%u, stream_id=%u", infoSize, lastStreamId);
    Context * const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
 
    Device * const dev = curCtx->Device_();
    StreamSqCqManage * const streamSqCqManagePtr = dev->GetStreamSqCqManage();
    NULL_PTR_RETURN_MSG_OUTER(streamSqCqManagePtr, RT_ERROR_INVALID_VALUE);
 
    Stream *stm = nullptr;
    rtError_t error = streamSqCqManagePtr->GetStreamById(lastStreamId, &stm);
    COND_RETURN_ERROR_MSG_INNER(((error != RT_ERROR_NONE) || (stm == nullptr)), error,
        "Query stream failed, dev_id=%u, stream_id=%u, retCode=%#x.",
        dev->Id_(), lastStreamId, static_cast<uint32_t>(error));
 
    COND_RETURN_ERROR_MSG_INNER(stm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Stream is not in current ctx, stream_id=%u.", lastStreamId);
 
    Model* mdl = stm->Model_();
    COND_RETURN_ERROR_MSG_INNER(mdl == nullptr || mdl->GetModelType() != RT_MODEL_CAPTURE_MODEL, 
        RT_ERROR_MODEL_NULL, "Stream or task is invalid, stream_id=%u.", lastStreamId);

    CaptureModel *captureMdl = dynamic_cast<CaptureModel *>(mdl);
    return captureMdl->CacheLastTaskOpInfo(infoPtr, infoSize, stm);
}

rtError_t ApiImpl::FunctionGetAttribute(rtFuncHandle funcHandle, rtFuncAttribute attrType, int64_t *attrValue)
{
    const Kernel *const kernel = RtPtrToPtr<Kernel *>(funcHandle);

    switch (attrType) {
        case RT_FUNCTION_ATTR_KERNEL_TYPE:
            *attrValue = static_cast<int64_t>(kernel->GetKernelAttrType());
            COND_RETURN_ERROR_MSG_INNER(*attrValue == static_cast<rtKernelAttrType>(0x7FFFFFFF), RT_ERROR_INVALID_VALUE, "Invalid kernel type.");
            break;
        default:
            RT_LOG(RT_LOG_WARNING, "Invalid attrType attrType=%d", attrType);
            break;
    }

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::MemRetainAllocationHandle(void* virPtr, rtDrvMemHandle *handle)
{
    const rtError_t error = NpuDriver::MemRetainAllocationHandle(virPtr, handle);
    ERROR_RETURN(error, "Failed to obtain the handle from virtual pointer, ptr=%p, handle=%p.", virPtr, handle);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::MemGetAllocationPropertiesFromHandle(rtDrvMemHandle handle, rtDrvMemProp_t* prop)
{
    RT_LOG(RT_LOG_INFO, "Start to MemGetAllocationPropertiesFromHandle");
    return NpuDriver::MemGetAllocationPropertiesFromHandle(handle, prop);
}
}  // namespace runtime
}  // namespace cce
