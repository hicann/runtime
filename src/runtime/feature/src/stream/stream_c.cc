/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "stream_c.hpp"
#include "memcpy_c.hpp"
#include "task_david.hpp"
#include "stream_factory.hpp"
#include "error_message_manage.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "context_data_manage.h"
#include "profiler_c.hpp"
#include "api.hpp"
#include "notify_c.hpp"

namespace cce {
namespace runtime {
constexpr uint8_t SDMA_QOS_LEVEL = 6U;
TIMESTAMP_EXTERN(rtKernelLaunch_KernelLookup);
TIMESTAMP_EXTERN(rtKernelLaunch_GetModule);
TIMESTAMP_EXTERN(rtKernelLaunch_SubmitTask);
TIMESTAMP_EXTERN(rtKernelLaunch_PutProgram);
TIMESTAMP_EXTERN(rtKernelLaunch_ALLKernelLookup);

rtError_t StreamLaunchKernelPrepare(const Stream * const stm, Kernel *&registeredKernel, Program *&prog, uint32_t &kernelType,
    Module *&mdl, const void * const stubFunc, uint64_t &addr1, uint64_t &addr2, void * const progHandle,
    const uint64_t tilingKey)
{
    Runtime * const rt = Runtime::Instance();
    const rtError_t error = RT_ERROR_NONE;

    if (progHandle == nullptr) {
        TIMESTAMP_BEGIN(rtKernelLaunch_KernelLookup);
        registeredKernel = rt->kernelTable_.Lookup(stubFunc);
        RT_LOG(RT_LOG_DEBUG, "launch kernel, registeredKernel=%s",
               (registeredKernel != nullptr) ? registeredKernel->Name_().c_str() : "(none)");
        TIMESTAMP_END(rtKernelLaunch_KernelLookup);
    } else {
        TIMESTAMP_BEGIN(rtKernelLaunch_ALLKernelLookup);
        Program * const programHdl = (static_cast<Program *>(progHandle));
        registeredKernel = (tilingKey == DEFAULT_TILING_KEY) ? nullptr : programHdl->AllKernelLookup(tilingKey);
        RT_LOG(RT_LOG_DEBUG, "launch kernel handle, tilingKey=%" PRIu64 ", registeredKernel=%" PRIu64,
            tilingKey, (registeredKernel != nullptr) ? registeredKernel->TilingKey() : 0UL);
        TIMESTAMP_END(rtKernelLaunch_ALLKernelLookup);
    }

    if (tilingKey == DEFAULT_TILING_KEY) {
        prog = nullptr;
        kernelType = Program::MACH_AI_CORE;
        addr1 = 0ULL;
        addr2 = 0ULL;
        return RT_ERROR_NONE;
    }

    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_TBE, (registeredKernel == nullptr), RT_ERROR_KERNEL_NULL,
        "Can not find kernel by function[0x%" PRIx64"], tilingKey=%" PRIu64 ".",
        RtPtrToValue(stubFunc), tilingKey);

    TIMESTAMP_BEGIN(rtKernelLaunch_GetModule);
    prog = registeredKernel->Program_();
    NULL_PTR_RETURN_MSG(prog, RT_ERROR_PROGRAM_NULL);
    COND_RETURN_ERROR_MSG_INNER((progHandle != nullptr) && (prog != RtPtrToPtr<Program *, void *>(progHandle)),
        RT_ERROR_PROGRAM_BASE, "Kernel prog is not belong to the launch prog.");

    kernelType = prog->Machine();
    if (kernelType == Program::MACH_AI_MIX_KERNEL) {
        kernelType = registeredKernel->KernelType_();
    }

    COND_RETURN_ERROR_MSG_INNER(kernelType == Program::MACH_AI_CPU,
        RT_ERROR_FEATURE_NOT_SUPPORT,
        "Launch kernel failed, not support CCE Aicpu kernel task, type=%u.", kernelType);

    mdl = stm->Context_()->GetModule(prog);
    TIMESTAMP_END(rtKernelLaunch_GetModule);
    NULL_PTR_RETURN_MSG(mdl, RT_ERROR_MODULE_NEW);

    const Kernel *kernel = registeredKernel;
    (void)mdl->GetFunction(kernel, &addr1, &addr2);
    return error;
}

void StreamLaunchKernelRecycle(DavidArgLoaderResult &result, TaskInfo *&recycleTask, const Program * const prog, Stream *stm)
{
    DavidStream *davidStm = static_cast<DavidStream *>(stm);
    if (result.handle != nullptr) {
        if (davidStm->ArgManagePtr() != nullptr) {
            davidStm->ArgManagePtr()->RecycleDevLoader(result.handle);
        }
        result.handle = nullptr;
    }
    if (recycleTask != nullptr) {
        if (recycleTask->isUpdateSinkSqe == 0U) {
            davidStm->ArgReleaseSingleTask(recycleTask, false);
            recycleTask = nullptr;
        } else {
            recycleTask->isUpdateSinkSqe = 0U;
        }
    }

    Runtime::Instance()->PutProgram(prog);
}

void StreamLaunchKernelRecycleAicpu(DavidArgLoaderResult &result, TaskInfo *&recycleTask, const Program * const prog, Stream *stm)
{
    if ((recycleTask != nullptr) && (recycleTask->type == TS_TASK_TYPE_KERNEL_AICPU)) {
        DELETE_O(recycleTask->u.aicpuTaskInfo.kernel);
    }

    StreamLaunchKernelRecycle(result, recycleTask, prog, stm);
}

rtError_t StreamCCULaunch(Stream *stm, rtCcuTaskInfo_t *taskInfo)
{
    rtError_t error = RT_ERROR_NONE;
    TaskInfo *ccuLaunchTask = nullptr;
    uint32_t pos = 0xFFFFU;
    constexpr uint32_t sqeNum = 2U;
    const int32_t streamId = stm->Id_();
    error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    Stream *dstStm = stm;
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&ccuLaunchTask, stm, pos, dstStm, sqeNum);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();,
        "stream_id=%d alloc ccuLaunch task failed, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(ccuLaunchTask, dstStm, pos, sqeNum);
    CcuLaunchTaskInit(ccuLaunchTask, taskInfo);
    ccuLaunchTask->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    error = DavidSendTask(ccuLaunchTask, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, 
                                TaskUnInitProc(ccuLaunchTask); TaskRollBack(dstStm, pos); stm->StreamUnLock();,
                                "ccuLaunchTask submit failed, stream_id=%d, retCode=%#x.",
                                stm->Id_(), static_cast<uint32_t>(error));
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), ccuLaunchTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

static void InitStarsCmoSqeForDavid(RtDavidStarsMemcpySqe *sdmaSqe, const Stream * const stm, const rtCmoOpCode_t cmoOpCode)
{
    sdmaSqe->opcode = static_cast<uint8_t>(cmoOpCode);
    sdmaSqe->sssv = 1U;
    sdmaSqe->dssv = 1U;
    sdmaSqe->sns  = 1U;
    sdmaSqe->dns  = 1U;
    sdmaSqe->sro = 0U;
    sdmaSqe->dro = 0U;
    sdmaSqe->stride = 0U;
    sdmaSqe->ie2 = 0U;
    sdmaSqe->compEn = 0U;
    sdmaSqe->sqeId = static_cast<uint16_t>(stm->GetSqId());
    sdmaSqe->mapamPartId = 0U;
    sdmaSqe->mpamns = 0U;
    sdmaSqe->pmg = 0U;
    sdmaSqe->qos = SDMA_QOS_LEVEL;
    sdmaSqe->srcStreamId = static_cast<uint16_t>(RT_SMMU_STREAM_ID_1FU);
    sdmaSqe->srcSubStreamId = static_cast<uint16_t>(stm->Device_()->GetSSID_());
}

rtError_t CmoTaskLaunchForDavid(const rtCmoTaskInfo_t * const taskInfo, Stream * const stm, const uint32_t flag)
{
    const int32_t streamId = stm->Id_();
    TaskInfo *rtCmoTask = nullptr;
    uint32_t pos = 0xFFFFU;
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    Stream *dstStm = stm;
    std::function<void()> const errRecycle = [&rtCmoTask, &stm, &pos, &dstStm]() {
        TaskUnInitProc(rtCmoTask);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();
    };
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&rtCmoTask, stm, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();,
        "stream_id=%d alloc cmo task failed, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    SaveTaskCommonInfo(rtCmoTask, dstStm, pos);
    ScopeGuard tskErrRecycle(errRecycle);
    // must be original stream
    error = CmoTaskInit(rtCmoTask, taskInfo, stm, flag);
    ERROR_RETURN_MSG_INNER(error, "CMO task init failed, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    rtCmoTask->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    error = DavidSendTask(rtCmoTask, dstStm);
    ERROR_RETURN_MSG_INNER(error, "CMO task submit failed, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), rtCmoTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t CmoAddrTaskLaunchForDavid(rtDavidCmoAddrInfo * const cmoAddrInfo, const rtCmoOpCode_t cmoOpCode,
                                 Stream * const stm)
{
    rtError_t error = RT_ERROR_NONE;
    const int32_t streamId = stm->Id_();
    Device *dev = stm->Device_();

    if (stm->Model_() == nullptr) {
        RT_LOG(RT_LOG_ERROR, "CMO Addr task stream is not in model. device_id=%d, stream_id=%d.",
            static_cast<int32_t>(stm->Device_()->Id_()), stm->Id_());
        return RT_ERROR_MODEL_NULL;
    }
    RtDavidStarsMemcpySqe sdmaCmoSqe = {};
    // fill in head args
    InitStarsCmoSqeForDavid(&sdmaCmoSqe, stm, cmoOpCode);
    RT_LOG(RT_LOG_DEBUG, "cmoAddrInfo=0x%llx, cmoOpCode=%d, device_id=%u, stream_id=%d.",
        RtPtrToValue(cmoAddrInfo), cmoOpCode, dev->Id_(), streamId);
    Driver * const devDrv = dev->Driver_();
    if (devDrv != nullptr) {
        constexpr uint64_t dstMax = 28ULL;
        error = devDrv->MemCopySync(cmoAddrInfo, dstMax, &sdmaCmoSqe, dstMax, RT_MEMCPY_HOST_TO_DEVICE);
        ERROR_RETURN_MSG_INNER(error, "Failed to memory copy stream info, device_id=%u, size=%" PRIu64 ", retCode=%#x",
            dev->Id_(), dstMax, static_cast<uint32_t>(error));

        if (devDrv->GetRunMode() == RT_RUN_MODE_ONLINE) {
            error = dev->Driver_()->DevMemFlushCache(RtPtrToValue(cmoAddrInfo), dstMax);
            ERROR_RETURN_MSG_INNER(error, "Failed to flush stream info, device_id=%u, retCode=%#x", dev->Id_(),
                static_cast<uint32_t>(error));
        }
    }
    TaskInfo *cmoAddrTask = nullptr;
    error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    std::function<void()> const errRecycle = [&cmoAddrTask, &stm, &pos]() {
        TaskUnInitProc(cmoAddrTask);
        TaskRollBack(stm, pos);
        stm->StreamUnLock();
    };
    stm->StreamLock();
    error = AllocTaskInfo(&cmoAddrTask, stm, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();,
        "stream_id=%d alloc cmo addr task failed, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(cmoAddrTask, stm, pos);
    ScopeGuard tskErrRecycle(errRecycle);
    (void)CmoAddrTaskInit(cmoAddrTask, cmoAddrInfo, cmoOpCode);
    cmoAddrTask->stmArgPos = static_cast<DavidStream *>(stm)->GetArgPos();
    error = DavidSendTask(cmoAddrTask, stm);
    ERROR_RETURN_MSG_INNER(error, "CMO Addr task submit failed, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(streamId, cmoAddrTask->taskSn);
    error = SubmitTaskPostProc(stm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    return error;
}

rtError_t StreamDatadumpInfoLoad(const void * const dumpInfo, const uint32_t length, Stream * const dftStm)
{
    rtError_t error = RT_ERROR_NONE;
    NULL_PTR_RETURN_MSG(dftStm, RT_ERROR_STREAM_NULL);
    const int32_t streamId = dftStm->Id_();

    TaskInfo *rtDumpLoadInfoTask = nullptr;
    error = CheckTaskCanSend(dftStm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    dftStm->StreamLock();
    error = AllocTaskInfo(&rtDumpLoadInfoTask, dftStm, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, dftStm->StreamUnLock();,
        "stream_id=%d alloc ccuLaunch task failed, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    SaveTaskCommonInfo(rtDumpLoadInfoTask, dftStm, pos);
    (void)DataDumpLoadInfoTaskInit(rtDumpLoadInfoTask, dumpInfo, length, 0U);
    error = DavidSendTask(rtDumpLoadInfoTask, dftStm);
    ERROR_PROC_RETURN_MSG_INNER(error, 
                                TaskUnInitProc(rtDumpLoadInfoTask);
                                TaskRollBack(dftStm, pos);
                                dftStm->StreamUnLock();,
                                "DataDumpLoadInfoTask submit failed, stream_id=%d, retCode=%#x.",
                                streamId, static_cast<uint32_t>(error));
    dftStm->StreamUnLock();
    error = dftStm->Synchronize();
    ERROR_RETURN_MSG_INNER(error, "Failed to synchronize DataDumpLoadInfoTask, retCode=%#x",
        static_cast<uint32_t>(error));
    return error;
}

rtError_t StreamDebugRegister(Stream * const debugStream, const uint32_t flag, const void * const addr,
    uint32_t * const streamId, uint32_t * const taskId)
{
    rtError_t error = RT_ERROR_NONE;
    const int32_t stmId = debugStream->Id_();
    *streamId = static_cast<uint32_t>(stmId);

    COND_RETURN_WARN(debugStream->IsDebugRegister(),
        RT_ERROR_DEBUG_REGISTER_FAILED, "stream repeat debug register!");
    RT_LOG(RT_LOG_INFO, "Debug register send task stream_id=%d, debug stream_id=%d.",
        debugStream->Id_(), debugStream->Id_());

    TaskInfo *rtDbgRegStreamTask = nullptr;
    error = CheckTaskCanSend(debugStream);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.",
        stmId, static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    debugStream->StreamLock();
    error = AllocTaskInfo(&rtDbgRegStreamTask, debugStream, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, debugStream->StreamUnLock();,
        "stream_id=%d alloc ccuLaunch task failed, retCode=%#x.", stmId, static_cast<uint32_t>(error));
    SaveTaskCommonInfo(rtDbgRegStreamTask, debugStream, pos);

    (void)DebugRegisterForStreamTaskInit(rtDbgRegStreamTask, static_cast<uint32_t>(stmId), addr, flag);
    rtDbgRegStreamTask->stmArgPos = static_cast<DavidStream *>(debugStream)->GetArgPos();
    error = DavidSendTask(rtDbgRegStreamTask, debugStream);
    COND_PROC_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_DEBUG_REGISTER_FAILED, 
                                     TaskUnInitProc(rtDbgRegStreamTask);
                                     TaskRollBack(debugStream, pos);
                                     debugStream->StreamUnLock();,
                                     "StreamDebugRegister submit failed, stream_id=%d, retCode=%#x.",
                                     stmId, static_cast<uint32_t>(error));
    debugStream->StreamUnLock();
    debugStream->SetDebugRegister(true);
    *taskId = rtDbgRegStreamTask->taskSn;
    return error;
}

rtError_t StreamDebugUnRegister(Stream * const debugStream)
{
    rtError_t error = RT_ERROR_NONE;
    COND_RETURN_WARN(!debugStream->IsDebugRegister(),
        RT_ERROR_DEBUG_UNREGISTER_FAILED, "stream is not debug register!");

    TaskInfo *rtDbgUnregStreamTask = nullptr;
    const int32_t streamId = debugStream->Id_();
    error = CheckTaskCanSend(debugStream);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    debugStream->StreamLock();
    error = AllocTaskInfo(&rtDbgUnregStreamTask, debugStream, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, debugStream->StreamUnLock();,
        "stream_id=%d alloc ccuLaunch task failed, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    SaveTaskCommonInfo(rtDbgUnregStreamTask, debugStream, pos);
    (void)DebugUnRegisterForStreamTaskInit(rtDbgUnregStreamTask, streamId);
    rtDbgUnregStreamTask->stmArgPos = static_cast<DavidStream *>(debugStream)->GetArgPos();
    error = DavidSendTask(rtDbgUnregStreamTask, debugStream);
    COND_PROC_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_DEBUG_REGISTER_FAILED, 
                                     TaskUnInitProc(rtDbgUnregStreamTask);
                                     TaskRollBack(debugStream, pos);
                                     debugStream->StreamUnLock();,
                                     "StreamDebugUnRegister submit failed, stream_id=%d, retCode=%#x.",
                                     streamId, static_cast<uint32_t>(error));
    debugStream->StreamUnLock();
    debugStream->SetDebugRegister(false);
    return error;
}

rtError_t StreamNpuGetFloatStatus(void * const outputAddrPtr, const uint64_t outputSize,
    const uint32_t checkMode, Stream * const stm, bool isDebug)
{
    const int32_t streamId = stm->Id_();
    TaskInfo *rtNpuGetFloatStatusTask = nullptr;
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    Stream *dstStm = stm;
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&rtNpuGetFloatStatusTask, stm, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();,
        "stream_id=%d alloc NpuGetFloatStatus task failed, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    SaveTaskCommonInfo(rtNpuGetFloatStatusTask, dstStm, pos);
    (void)NpuGetFloatStaTaskInit(rtNpuGetFloatStatusTask, outputAddrPtr, outputSize, checkMode, isDebug);
    rtNpuGetFloatStatusTask->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    error = DavidSendTask(rtNpuGetFloatStatusTask, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, 
                                TaskUnInitProc(rtNpuGetFloatStatusTask);
                                TaskRollBack(dstStm, pos);
                                stm->StreamUnLock();,
                                "NpuGetFloatStatus submit failed, stream_id=%d, retCode=%#x.",
                                streamId, static_cast<uint32_t>(error));
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), rtNpuGetFloatStatusTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t StreamNpuClearFloatStatus(const uint32_t checkMode, Stream * const stm, bool isDebug)
{
    const int32_t streamId = stm->Id_();
    RT_LOG(RT_LOG_INFO, "Begin to create NpuClearFloatStatus task.");

    TaskInfo *rtNpuClearFloatStatusTask = nullptr;
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    Stream *dstStm = stm;
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&rtNpuClearFloatStatusTask, stm, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();,
        "stream_id=%d alloc rtNpuClearFloatStatusTask failed, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    SaveTaskCommonInfo(rtNpuClearFloatStatusTask, dstStm, pos);
    (void)NpuClrFloatStaTaskInit(rtNpuClearFloatStatusTask, checkMode, isDebug);
    rtNpuClearFloatStatusTask->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    error = DavidSendTask(rtNpuClearFloatStatusTask, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, 
                                TaskUnInitProc(rtNpuClearFloatStatusTask);
                                TaskRollBack(dstStm, pos);
                                stm->StreamUnLock();,
                                "rtNpuClearFloatStatusTask submit failed, stream_id=%d, retCode=%#x.",
                                streamId, static_cast<uint32_t>(error));
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), rtNpuClearFloatStatusTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    return error;
}

rtError_t StreamGetSatStatus(const uint64_t outputSize, Stream * const curStm)
{
    rtError_t error = RT_ERROR_NONE;
    Device *dev = curStm->Device_();
    uint64_t realSize = 0U;
    void *hostPtr = nullptr;
    std::shared_ptr<void> hostPtrGuard;
    // H2D copy
    hostPtr = AlignedMalloc(Context::MEM_ALIGN_SIZE, sizeof(uint64_t));
    NULL_PTR_RETURN_MSG(hostPtr, RT_ERROR_MEMORY_ALLOCATION);
    hostPtrGuard.reset(hostPtr, &AlignedFree);
    const errno_t ret = memset_s(hostPtr, sizeof(uint64_t), 0, sizeof(uint64_t));
    COND_PROC_RETURN_ERROR(ret != EOK, RT_ERROR_SEC_HANDLE, hostPtr = nullptr;,
        "memset_s failed, retCode=%d", ret);
    *(static_cast<uint64_t *>(hostPtr)) = RtPtrToValue(curStm->Context_()->CtxGetOverflowAddr());

    if (curStm->GetMemContainOverflowAddr() == nullptr) {
        void *memAddr = nullptr;
        error = dev->Driver_()->DevMemAlloc(&memAddr, sizeof(uint64_t), RT_MEMORY_DEFAULT, dev->Id_());
        COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "memAddr DevMemAlloc failed, retCode=%#x.",
            static_cast<uint32_t>(error));
        curStm->SetMemContainOverflowAddr(memAddr);
    }

    error = MemcopyAsync(curStm->GetMemContainOverflowAddr(), sizeof(uint64_t), hostPtr, sizeof(uint64_t),
        RT_MEMCPY_HOST_TO_DEVICE_EX, curStm, &realSize, hostPtrGuard);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "MemcpyAsync failed, retCode=%#x.",
        static_cast<uint32_t>(error));

    error = StreamNpuGetFloatStatus(curStm->GetMemContainOverflowAddr(), outputSize, 0U, curStm);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "NpuGetFloatStatus failed, retCode=%#x.",
        static_cast<uint32_t>(error));

    return error;
}

rtError_t SyncGetDeviceMsg(Device * const dev, const void * const devMemAddr, const uint32_t devMemSize,
    const rtGetDevMsgType_t getDevMsgType)
{
    // new a stream for get exception info
    std::unique_ptr<Stream, void(*)(Stream*)> stm(StreamFactory::CreateStream(dev, 0U),
        [](Stream *ptr) {ptr->Destructor();});
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, stm == nullptr, RT_ERROR_STREAM_NEW, "new Stream failed.");
    rtError_t error = stm->Setup();
    ERROR_RETURN_MSG_INNER(error, "stream setup failed, retCode=%#x.", static_cast<uint32_t>(error));
    TaskInfo *tsk = nullptr;
    uint32_t pos = 0xFFFFU;
    const std::function<void()> streamTearDownFunc = [&stm, &tsk, &pos]() {
        TaskUnInitProc(tsk);
        TaskRollBack(stm.get(), pos);
        stm->StreamUnLock();
    };
    error = CheckTaskCanSend(stm.get());
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.", stm->Id_(),
        static_cast<uint32_t>(error));
    stm->StreamLock();
    error = AllocTaskInfo(&tsk, stm.get(), pos);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();,
        "stream_id=%d alloc task failed, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(tsk, stm.get(), pos);
    ScopeGuard devErrMsgStreamRelease(streamTearDownFunc);
    // init RT_GET_DEV_ERROR_MSG task
    error = GetDevMsgTaskInit(tsk, devMemAddr, devMemSize, getDevMsgType);
    ERROR_RETURN_MSG_INNER(error, "Failed to init task, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    error = DavidSendTask(tsk, stm.get());
    ERROR_RETURN_MSG_INNER(error, "Failed to init task, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    devErrMsgStreamRelease.ReleaseGuard();
    stm->StreamUnLock();
    // stream synchronize
    error = stm->Synchronize();
    ERROR_RETURN_MSG_INNER(error, "Failed to synchronize stream, retCode=%#x.", static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t SetOverflowSwitchOnStream(Stream * const stm, const uint32_t flags)
{
    TaskInfo *tsk = nullptr;
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream check failed, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    Stream *dstStm = stm;
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&tsk, stm, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(tsk, dstStm, pos);
    (void)OverflowSwitchSetTaskInit(tsk, dstStm, flags);
    tsk->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    error = DavidSendTask(tsk, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, TaskUnInitProc(tsk);
                                       TaskRollBack(dstStm, pos);
                                       stm->StreamUnLock();,
                                       "OverflowSwitchSetTask submit failed, stream_id=%d, retCode=%#x",
                                       stm->Id_(), static_cast<uint32_t>(error));
    stm->StreamUnLock();
    stm->SetOverflowSwitch(flags != 0U);
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), tsk->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    return error;
}

rtError_t SetTagOnStream(Stream * const stm, const uint32_t geOpTag)
{
    TaskInfo *tsk = nullptr;
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream check failed, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    Stream *defaultStm = stm->Context_()->DefaultStream_();
    defaultStm->StreamLock();
    error = AllocTaskInfo(&tsk, defaultStm, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, defaultStm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        defaultStm->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(tsk, defaultStm, pos);
    (void)StreamTagSetTaskInit(tsk, stm, geOpTag);
    tsk->stmArgPos = static_cast<DavidStream *>(defaultStm)->GetArgPos();
    error = DavidSendTask(tsk, defaultStm);
    ERROR_PROC_RETURN_MSG_INNER(error, TaskUnInitProc(tsk);
                                       TaskRollBack(defaultStm, pos);
                                       defaultStm->StreamUnLock();,
                                       "StreamTagSetTask submit failed, stream_id=%d, retCode=%#x",
                                       defaultStm->Id_(), static_cast<uint32_t>(error));
    defaultStm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(defaultStm->Id_(), tsk->taskSn);
    stm->SetStreamTag(geOpTag);
    error = SubmitTaskPostProc(defaultStm, pos, tsk->isNeedStreamSync);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.",
        defaultStm->Id_(), static_cast<uint32_t>(error));
    return error;
}

rtError_t StreamUbDbSend(const rtUbDbInfo_t * const dbInfo, Stream * const stm)
{
    rtError_t error = RT_ERROR_NONE;
    const int32_t streamId = stm->Id_();
    TaskInfo *rtUbSendTask = nullptr;
    error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream check failed, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    Stream *dstStm = stm;
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&rtUbSendTask, stm, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    SaveTaskCommonInfo(rtUbSendTask, dstStm, pos);
    (void)UbDbSendTaskInit(rtUbSendTask, dbInfo);
    rtUbSendTask->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    error = DavidSendTask(rtUbSendTask, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, TaskUnInitProc(rtUbSendTask);
                                       TaskRollBack(dstStm, pos);
                                       stm->StreamUnLock();,
                                       "Ub Doorbell submit failed, stream_id=%d, retCode=%#x",
                                       streamId, static_cast<uint32_t>(error));
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), rtUbSendTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    return error;
}

rtError_t StreamUbDirectSend(rtUbWqeInfo_t * const wqeInfo, Stream * const stm)
{
    rtError_t error = RT_ERROR_NONE;
    const int32_t streamId = stm->Id_();
    TaskInfo *rtDirectSendTask = nullptr;
    const uint32_t sqeNum = (wqeInfo->wqeSize == 1U) ? 3U : 2U;
    uint32_t pos = 0xFFFFU;
    error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream check failed, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    stm->StreamLock();
    error = AllocTaskInfo(&rtDirectSendTask, stm, pos, sqeNum);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    SaveTaskCommonInfo(rtDirectSendTask, stm, pos, sqeNum);
    UbDirectSendTaskInit(rtDirectSendTask, wqeInfo);
    rtDirectSendTask->stmArgPos = static_cast<DavidStream *>(stm)->GetArgPos();
    error = DavidSendTask(rtDirectSendTask, stm);
    ERROR_PROC_RETURN_MSG_INNER(error,
                                TaskUnInitProc(rtDirectSendTask);
                                TaskRollBack(stm, pos);
                                stm->StreamUnLock();,
                                "Ub Direct send task submit failed, stream_id=%d, retCode=%#x.",
                                streamId, static_cast<uint32_t>(error));
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(stm->Id_(), rtDirectSendTask->taskSn);
    error = SubmitTaskPostProc(stm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    return error;
}

rtError_t StreamNopTask(Stream * const stm)
{
    TaskInfo *rtNopTask = nullptr;
    uint32_t pos = 0xFFFFU;
    const int32_t streamId = stm->Id_();
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream check failed, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    Stream *dstStm = stm;
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&rtNopTask, stm, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    SaveTaskCommonInfo(rtNopTask, dstStm, pos);
    (void)NopTaskInit(rtNopTask);
    rtNopTask->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    error = DavidSendTask(rtNopTask, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error,
                                TaskUnInitProc(rtNopTask);
                                TaskRollBack(dstStm, pos);
                                stm->StreamUnLock();,
                                "nop task submit task submit failed, stream_id=%d, retCode=%#x.",
                                streamId, static_cast<uint32_t>(error));
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), rtNopTask->taskSn);
    error = SubmitTaskPostProc(stm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t StreamAicpuInfoLoad(Stream * const dftStm, const void * const aicpuInfo,
    const uint32_t length)
{
    NULL_PTR_RETURN_MSG(dftStm, RT_ERROR_STREAM_NULL);

    TaskInfo *rtAicpuLoadInfoTask = nullptr;
    const int32_t streamId = dftStm->Id_();
    rtError_t error = CheckTaskCanSend(dftStm);
    ERROR_RETURN_MSG_INNER(error, "stream check failed, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    dftStm->StreamLock();
    error = AllocTaskInfo(&rtAicpuLoadInfoTask, dftStm, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, dftStm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    SaveTaskCommonInfo(rtAicpuLoadInfoTask, dftStm, pos);
    (void)AicpuInfoLoadTaskInit(rtAicpuLoadInfoTask, aicpuInfo, length);
    error = DavidSendTask(rtAicpuLoadInfoTask, dftStm);
    ERROR_PROC_RETURN_MSG_INNER(error,
                                TaskUnInitProc(rtAicpuLoadInfoTask);
                                TaskRollBack(dftStm, pos);
                                dftStm->StreamUnLock();,
                                "aicpu load info task submit task submit failed, stream_id=%d, retCode=%#x.",
                                streamId, static_cast<uint32_t>(error));
    dftStm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dftStm->Id_(), rtAicpuLoadInfoTask->taskSn);
    error = dftStm->Synchronize();
    ERROR_RETURN_MSG_INNER(error, "Failed to synchronize AicpuInfoLoadTask, retCode=%#x",
        static_cast<uint32_t>(error));
    return error;
}

rtError_t UpdateTimeoutConfigTaskSubmitDavid(Stream * const stm, const RtTimeoutConfig &timeoutConfig)
{
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    TaskInfo *timeoutSetTask = nullptr;
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream check failed, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    stm->StreamLock();
    error = AllocTaskInfo(&timeoutSetTask, stm, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(timeoutSetTask, stm, pos);
    TimeoutSetTaskInitV1(timeoutSetTask);
    if (timeoutConfig.isCfgOpWaitTaskTimeout) {
        TimeoutSetTaskUpdate(timeoutSetTask, RT_TIMEOUT_TYPE_OP_WAIT, timeoutConfig.opWaitTaskTimeout);
    }

    if (timeoutConfig.isCfgOpExcTaskTimeout) {
        TimeoutSetTaskUpdate(timeoutSetTask, RT_TIMEOUT_TYPE_OP_EXECUTE,
            timeoutConfig.opExcTaskTimeout / RT_TIMEOUT_S_TO_US);
    }
    error = DavidSendTask(timeoutSetTask, stm);
    ERROR_PROC_RETURN_MSG_INNER(error,
                                TaskUnInitProc(timeoutSetTask);
                                TaskRollBack(stm, pos);
                                stm->StreamUnLock();,
                                "stream_id=%d failed to submit task retCode=%#x.",
                                stm->Id_(), static_cast<uint32_t>(error));
    stm->StreamUnLock();
    error = stm->Synchronize();
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d failed to synchronize. retCode=%#x.",
                           stm->Id_(), static_cast<uint32_t>(error));
    return error;
}

rtError_t SetTimeoutConfigTaskSubmitDavid(Stream * const stm, const rtTaskTimeoutType_t type,
    const uint32_t timeout)
{
    TaskInfo *timeoutSetTask = nullptr;

    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream check failed, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    stm->StreamLock();
    error = AllocTaskInfo(&timeoutSetTask, stm, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(timeoutSetTask, stm, pos);
    (void)TimeoutSetTaskInit(timeoutSetTask, type, timeout);
    error = DavidSendTask(timeoutSetTask, stm);
    ERROR_PROC_RETURN_MSG_INNER(error,
                                TaskUnInitProc(timeoutSetTask);
                                TaskRollBack(stm, pos);
                                stm->StreamUnLock();,
                                "stream_id=%d failed to submit task, retCode=%#x.",
                                stm->Id_(), static_cast<uint32_t>(error));
    stm->StreamUnLock();
    error = stm->Synchronize();
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d failed to synchronize retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    return error;
}

static rtError_t GetNotifyInfoForCallbackLaunchWithBlock(const Stream * const stm, int32_t &notifyId, Notify *&notify)
{
    rtError_t ret = RT_ERROR_NONE;
    Notify *curNotify = nullptr;
    ret = Runtime::Instance()->GetNotifyByStreamId(stm->Device_()->Id_(), stm->AllocTaskStreamId(), &curNotify);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "Call GetNotifyByStreamId failed for block callback, ret=%#x.",
        ret);
    notifyId = static_cast<int32_t>(curNotify->GetNotifyId());
    notify = curNotify;
    return RT_ERROR_NONE;
}

static rtError_t ProcCaptureStmSubscribeInfo(const Stream * const stm, const bool isBlock)
{
    Stream *captureStm = stm->GetCaptureStream();
    Runtime * const rtInstance = Runtime::Instance();
    Api * const apiObj = rtInstance->ApiImpl_();
    Device * const dev = stm->Device_();
    rtError_t ret = RT_ERROR_NONE;
    // prepare capture stream SubscribeReport
    if (stm->IsCapturing() && (captureStm != nullptr)) {
        if (captureStm->GetSubscribeFlag() == StreamSubscribeFlag::SUBSCRIBE_NONE) {
            uint64_t threadId = 0UL;
            ret = rtInstance->GetThreadIdByStreamId(dev->Id_(), stm->Id_(), &threadId);
            COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret,
                "Get threadId by streamId failed, drv devId=%u, original stream_id=%d, "
                "capture stream_id=%d, retCode=%#x.", dev->Id_(), stm->Id_(), captureStm->Id_(), ret);
            Notify *curNotify = nullptr;
            if (isBlock) {
                ret = apiObj->NotifyCreate(static_cast<int32_t>(dev->Id_()), &curNotify);
                COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret,
                    "Create callback notify failed, drv devId=%u, original stream_id=%d, capture stream_id=%d, retCode=%#x.",
                    dev->Id_(), stm->Id_(), captureStm->Id_(), ret);
            }
            ret = rtInstance->SubscribeReport(threadId, captureStm, static_cast<void *>(curNotify));
            if (ret != RT_ERROR_NONE) {
                if (curNotify != nullptr) {
                    (void)apiObj->NotifyDestroy(curNotify);
                }
                return ret;
            }
        }
    }
    return RT_ERROR_NONE;
}

static rtError_t CallbackLaunchForDavid(const rtCallback_t callBackFunc, void * const fnData, Stream * const stm,
    const bool isBlock, Notify *&notify)
{
    const int32_t streamId = stm->Id_();
    TaskInfo* rtCbLaunchTask = nullptr;
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream check failed, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    Stream *dstStm = stm;
    std::function<void()> const errRecycle = [&rtCbLaunchTask, &stm, &pos, &dstStm]() {
        TaskUnInitProc(rtCbLaunchTask);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();
    };
    int32_t notifyId = -1;
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&rtCbLaunchTask, stm, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    ScopeGuard tskErrRecycle(errRecycle);
    error = ProcCaptureStmSubscribeInfo(stm, isBlock);
    ERROR_RETURN_MSG_INNER(error, "Failed to proc capture stream subscribe info, stream_id=%d, capture stream_id=%d, error=%#x.",
                           streamId, dstStm->Id_(), static_cast<uint32_t>(error));
    if (isBlock) {
        error = GetNotifyInfoForCallbackLaunchWithBlock(stm, notifyId, notify);
        ERROR_RETURN_MSG_INNER(error, "Failed to get notify info, stream_id=%d maybe have capture stream_id=%d, error=%#x.",
                        streamId, dstStm->Id_(), static_cast<uint32_t>(error));
    }
    
    SaveTaskCommonInfo(rtCbLaunchTask, dstStm, pos);
    (void)CallbackLaunchTaskInit(rtCbLaunchTask, callBackFunc, fnData, isBlock, notifyId);
    rtCbLaunchTask->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    error = DavidSendTask(rtCbLaunchTask, dstStm);
    ERROR_RETURN_MSG_INNER(error,"Failed to submit call backTask, stream_id=%d, error=%#x.", streamId,
        static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), rtCbLaunchTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t CallbackLaunchForDavidNoBlock(const rtCallback_t callBackFunc, void * const fnData, Stream * const stm)
{
    Notify *curNotify = nullptr;
    return CallbackLaunchForDavid(callBackFunc, fnData, stm, false, curNotify);
}

rtError_t CallbackLaunchForDavidWithBlock(const rtCallback_t callBackFunc, void * const fnData, Stream * const stm)
{
    rtError_t ret = RT_ERROR_NONE;
    Notify *curNotify = nullptr;
    ret = CallbackLaunchForDavid(callBackFunc, fnData, stm, true, curNotify);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "Call CallbackLaunch failed for block callback, ret=%#x.", ret);
    ret = NtyWait(curNotify, stm, 0U);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "Call NotifyWait failed for block callback, ret=%#x.", ret);
    return ret;
}

rtError_t StreamWriteValue(rtWriteValueInfo_t * const info, Stream * const stm)
{
    const int32_t streamId = stm->Id_(); 
    TaskInfo *writeValTask = nullptr;
    uint32_t pos = 0xFFFFU;
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    Stream *dstStm = stm;
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&writeValTask, stm, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    const WriteValueSize awsize = WriteValueSize(static_cast<uint8_t>(info->size) - 1U);
    SaveTaskCommonInfo(writeValTask, dstStm, pos);
    (void)WriteValueTaskInit(writeValTask, info->addr, awsize, info->value, TASK_WR_CQE_DEFAULT);
    writeValTask->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    error = DavidSendTask(writeValTask, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, TaskUnInitProc(writeValTask);
                                       TaskRollBack(dstStm, pos);
                                       stm->StreamUnLock();,
                                       "WriteValue task submit failed, retCode=%#x.",
                                       static_cast<uint32_t>(error));
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), writeValTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t StreamWriteValuePtr(const rtWriteValueInfo_t * const writeValueInfo, Stream * const stm,
                              void * const pointedAddr)
{
    COND_RETURN_ERROR_MSG_INNER(((static_cast<uint32_t>(writeValueInfo->size) >= WRITE_VALUE_SIZE_TYPE_BUFF) ||
        (writeValueInfo->size == WRITE_VALUE_SIZE_TYPE_INVALID)), RT_ERROR_INVALID_VALUE,
        "Write value size[%d] does not support, it should between [1, %d).", writeValueInfo->size,
        WRITE_VALUE_SIZE_TYPE_BUFF);
    constexpr uint64_t temp = 0ULL;
    const uint64_t size = static_cast<uint64_t>(writeValueInfo->size);
    COND_RETURN_ERROR_MSG_INNER((((~((~temp) << (size - 1U))) & writeValueInfo->addr) == 1U),
        RT_ERROR_INVALID_VALUE, "Address [%lu] is not aligned by awsize [%d].", writeValueInfo->addr,
        writeValueInfo->size);
    
    rtError_t error = RT_ERROR_NONE;
    const int32_t streamId = stm->Id_();
    const uint32_t cpySize = 64U;  // sqe's size
    TaskInfo *writeValPtrTask = nullptr;
    uint32_t pos = 0xFFFFU;
    RtDavidStarsWriteValueSqe writeValueSqe = {};
    InitWriteValueSqe(&writeValueSqe, writeValueInfo);
    RT_LOG(RT_LOG_INFO, "pointed write value sqe's addr=0x%lx, addr=0x%lx.",
        RtPtrToValue(pointedAddr), writeValueInfo->addr);

    Device *dev = stm->Device_();
    error = dev->Driver_()->MemCopySync(pointedAddr, cpySize, &writeValueSqe, cpySize, RT_MEMCPY_HOST_TO_DEVICE);
    ERROR_RETURN_MSG_INNER(error, "Failed to memory copy info, device_id=%u, size=%u, "
        "retCode=%#x", dev->Id_(), cpySize, static_cast<uint32_t>(error));
    error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    Stream *dstStm = stm;
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&writeValPtrTask, stm, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    SaveTaskCommonInfo(writeValPtrTask, dstStm, pos);
    (void)WriteValuePtrTaskInit(writeValPtrTask, pointedAddr, TASK_WR_CQE_DEFAULT);
    writeValPtrTask->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    error = DavidSendTask(writeValPtrTask, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, TaskUnInitProc(writeValPtrTask);
                                       TaskRollBack(dstStm, pos);
                                       stm->StreamUnLock();,
                                       "WriteValuePtr task submit failed, retCode=%#x.",
                                       static_cast<uint32_t>(error));
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), writeValPtrTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t SendTopicMsgVersionToAicpuDavid(Stream * const stm)
{
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    TaskInfo *topicMsgVersiontask = nullptr;
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream check failed, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    stm->StreamLock();
    error = AllocTaskInfo(&topicMsgVersiontask, stm, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(topicMsgVersiontask, stm, pos);
    AicpuMsgVersionTaskInit(topicMsgVersiontask);
    error = DavidSendTask(topicMsgVersiontask, stm);
    ERROR_PROC_RETURN_MSG_INNER(error,
                                TaskUnInitProc(topicMsgVersiontask);
                                TaskRollBack(stm, pos);
                                stm->StreamUnLock();,
                                "stream_id=%d failed to submit task retCode=%#x.",
                                stm->Id_(), static_cast<uint32_t>(error));
    stm->StreamUnLock();
    error = stm->Synchronize();
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d failed to Synchronize", stm->Id_());
    return error;
}

}  // namespace runtime
}  // namespace cce