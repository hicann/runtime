/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "context_manage.hpp"
#include "context.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "device_snapshot.hpp"

namespace cce {
namespace runtime {
static std::mutex g_ctxManLock;
static ContextDataManage &g_ctxMan = ContextDataManage::Instance();

bool ContextManage::CheckContextIsValid(Context *const curCtx, const bool inUseFlag)
{
    const ReadProtect rp(&(g_ctxMan.GetSetRwLock()));
    if (!g_ctxMan.ExistsSetValueWithoutLock(curCtx)) {
        return false;
    }
    if (likely(inUseFlag)) {
        curCtx->ContextInUse();
    }

    return true;
}

void ContextManage::InsertContext(Context *const insertCtx)
{
    if (unlikely(insertCtx == nullptr)) {
        return;
    }
    g_ctxMan.InsertSetValueWithLock(insertCtx);
    return;
}

rtError_t ContextManage::EraseContextFromSet(Context *const eraseCtx)
{
    if (!g_ctxMan.EraseSetValueWithLock(eraseCtx)) {
        return RT_ERROR_CONTEXT_NULL;
    }
    eraseCtx->ContextInUse();
    eraseCtx->SetContextDeleteStatus();
    return RT_ERROR_NONE;
}

bool ContextManage::IsSupportDeviceAbort(const int32_t devId)
{
    const ReadProtect wp(&g_ctxMan.GetSetRwLock());
    for (Context *const ctx : g_ctxMan.GetSetObj()) {
        COND_PROC((ctx->Device_()->Id_() != static_cast<uint32_t>(devId)), continue);
        if (!ctx->Device_()->CheckFeatureSupport(TS_FEATURE_TASK_ABORT)) {
            RT_LOG(RT_LOG_WARNING, "feature not support because tsch version too low");
            return false;
        }
    }
    return true;
}

rtError_t ContextManage::DeviceAbort(const int32_t devId)
{
    RT_LOG(RT_LOG_INFO, "DeviceAbort[%d] start", devId);
    rtError_t error = RT_ERROR_CONTEXT_NULL;
    const ReadProtect wp(&g_ctxMan.GetSetRwLock());
    for (Context *const ctx : g_ctxMan.GetSetObj()) {
        COND_PROC((ctx->Device_()->Id_() != static_cast<uint32_t>(devId)), continue);
        ctx->Device_()->SetDeviceStatus(RT_ERROR_DEVICE_TASK_ABORT);
        ctx->SetFailureError(RT_ERROR_DEVICE_TASK_ABORT);
        ctx->SetStreamsStatus(RT_ERROR_DEVICE_TASK_ABORT);
        error = ctx->StreamsCleanSq();
        ERROR_RETURN(error, "ctx clean fail, retCode=%#x.", error);
    }
    RT_LOG(RT_LOG_INFO, "DeviceAbort[%d] end", devId);
    return error;
}

rtError_t ContextManage::Devicekill(const int32_t devId)
{
    RT_LOG(RT_LOG_INFO, "Devicekill start");
    rtError_t error = RT_ERROR_CONTEXT_NULL;
    const ReadProtect wp(&g_ctxMan.GetSetRwLock());
    for (Context *const ctx : g_ctxMan.GetSetObj()) {
        COND_PROC((ctx->Device_()->Id_() != static_cast<uint32_t>(devId)), continue);
        error = ctx->StreamsKill();
        ERROR_RETURN(error, "ctx kill fail, retCode=%#x.", error);
        RT_LOG(RT_LOG_INFO, "Devicekill end");
        return error;
    }

    return error;
}

rtError_t ContextManage::DeviceQuery(const int32_t devId, const uint32_t step, const uint32_t timeout)
{
    RT_LOG(RT_LOG_INFO, "DeviceQuery[%d] start", devId);
    mmTimeval startTv = {};
    mmGetTimeOfDay(&startTv, nullptr);
    const uint64_t startTime = (static_cast<uint64_t>(startTv.tv_sec) * RT_MS_PER_S) +
                               (static_cast<uint64_t>(startTv.tv_usec) / RT_US_TO_MS);
    rtError_t error = RT_ERROR_CONTEXT_NULL;
    const ReadProtect wp(&g_ctxMan.GetSetRwLock());
    bool flag = true;
    while (flag) {
        uint32_t status;
        mmTimeval endTv = {};
        for (Context *const ctx : g_ctxMan.GetSetObj()) {
            COND_PROC((ctx->Device_()->Id_() != static_cast<uint32_t>(devId)), continue);
            error = ctx->StreamsQuery(status);
            ERROR_RETURN(error, "ctx query fail, retCode=%#x.", error);
            if (status >= step) {
                flag = false;
                break;
            }

            mmGetTimeOfDay(&endTv, nullptr);
            const uint64_t endTime = (static_cast<uint64_t>(endTv.tv_sec) * RT_MS_PER_S) +
                                     (static_cast<uint64_t>(endTv.tv_usec) / RT_US_TO_MS);
            COND_RETURN_ERROR(
                ((timeout != 0U) && ((endTime - startTime) > timeout)), RT_ERROR_WAIT_TIMEOUT, "kill query timeout");
            (void)mmSleep(5U);
        }
    }
    RT_LOG(RT_LOG_INFO, "DeviceQuery[%d] finish", devId);
    return error;
}

void ContextManage::QueryContextInUse(const int32_t devId, bool &isInUse)
{
    uint32_t cnt = 0U;
    const ReadProtect wp(&g_ctxMan.GetSetRwLock());
    for (Context *const ctx : g_ctxMan.GetSetObj()) {
        COND_PROC((ctx->Device_()->Id_() != static_cast<uint32_t>(devId)), continue);
        cnt++;
        break;  // 只统计一个即可
    }
    RT_LOG(RT_LOG_INFO, "QueryContextInUse[%d], cnt=%u", devId, cnt);
    isInUse = (cnt != 0U);
    return;
}

rtError_t ContextManage::DeviceClean(const int32_t devId)
{
    RT_LOG(RT_LOG_INFO, "DeviceClean[%u] start", devId);
    rtError_t error = RT_ERROR_CONTEXT_NULL;
    Device *dev = nullptr;
    const ReadProtect wp(&g_ctxMan.GetSetRwLock());
    for (Context *const ctx : g_ctxMan.GetSetObj()) {
        COND_PROC((ctx->Device_()->Id_() != static_cast<uint32_t>(devId)), continue);
        dev = ctx->Device_();
        error = ctx->StreamsTaskClean();
        ERROR_RETURN(error, "ctx task clean fail, retCode=%#x.", error);
        error = ctx->StreamsUpdate();
        ERROR_RETURN(error, "ctx update fail, retCode=%#x.", error);
    }

    if (dev != nullptr) {
        error = dev->ProcCleanRingbuffer();
        ERROR_RETURN(error, "device clean ring buffer fail, retCode=%#x.", error);
        dev->ProcClearFastRingBuffer();
        dev->SetDeviceStatus(RT_ERROR_NONE);
        dev->SetHasTaskError(false);
        dev->SetDeviceRas(false);
        dev->SetMonitorExitFlag(false);
        dev->SetDevicePageFault(false);
        (void)Runtime::Instance()->SetWatchDogDevStatus(dev, RT_DEVICE_STATUS_NORMAL);
    }

    for (Context *const ctx : ContextDataManage::Instance().GetSetObj()) {
        COND_PROC((ctx->Device_()->Id_() != static_cast<uint32_t>(devId)), continue);
        ctx->SetStreamsStatus(RT_ERROR_NONE);
        ctx->SetFailureError(RT_ERROR_NONE);
    }

    RT_LOG(RT_LOG_INFO, "DeviceClean[%u] end", devId);
    return error;
}

rtError_t ContextManage::DeviceTaskAbort(const int32_t devId, const uint32_t timeout)
{
    mmTimeval tv[20U] = {};
    int32_t index = 0;
    uint64_t timeCost;
    uint64_t startTime;
    uint64_t currentTime;
    uint32_t value = 0;
    Runtime *const rtInstance = Runtime::Instance();
    mmGetTimeOfDay(&tv[index], nullptr);
    startTime = (tv[index].tv_sec * RT_MS_PER_S) + (tv[index].tv_usec / RT_US_TO_MS);

    std::unique_lock<std::mutex> taskLock(g_ctxManLock);
    const bool isSupport = IsSupportDeviceAbort(devId);
    COND_RETURN_WARN((isSupport == false), RT_ERROR_FEATURE_NOT_SUPPORT, "Not support DeviceTaskAbort");

    rtError_t error = DeviceAbort(devId);
    mmGetTimeOfDay(&tv[++index], nullptr);
    ERROR_GOTO_MSG_INNER(error, TIMEINFO, "DeviceAbort, retCode=%#x", static_cast<uint32_t>(error));

    timeCost = ((tv[index].tv_sec * RT_MS_PER_S) + (tv[index].tv_usec / RT_US_TO_MS) - startTime);
    COND_GOTO_ERROR(((timeout != 0U) && (timeCost > timeout)), TIMEINFO, error, RT_ERROR_WAIT_TIMEOUT, "timeout.");
    error = rtInstance->TaskAbortCallBack(devId, RT_DEVICE_ABORT_PRE, (timeout != 0U) ? (timeout - timeCost) : timeout);
    mmGetTimeOfDay(&tv[++index], nullptr);
    ERROR_GOTO_MSG_INNER(error, TIMEINFO, "abort pre, retCode=%#x", static_cast<uint32_t>(error));

    error = Devicekill(devId);
    mmGetTimeOfDay(&tv[++index], nullptr);
    ERROR_GOTO_MSG_INNER(error, TIMEINFO, "DeviceQuery, retCode=%#x", static_cast<uint32_t>(error));

    timeCost = ((tv[index].tv_sec * RT_MS_PER_S) + (tv[index].tv_usec / RT_US_TO_MS) - startTime);
    COND_GOTO_ERROR(((timeout != 0U) && (timeCost > timeout)), TIMEINFO, error, RT_ERROR_WAIT_TIMEOUT, "timeout.");
    error = DeviceQuery(devId, APP_ABORT_KILL_FINISH, (timeout != 0U) ? (timeout - timeCost) : timeout);
    mmGetTimeOfDay(&tv[++index], nullptr);
    ERROR_GOTO_MSG_INNER(error, TIMEINFO, "DeviceQuery, retCode=%#x", static_cast<uint32_t>(error));

    timeCost = ((tv[index].tv_sec * RT_MS_PER_S) + (tv[index].tv_usec / RT_US_TO_MS) - startTime);
    COND_GOTO_ERROR(((timeout != 0U) && (timeCost > timeout)), TIMEINFO, error, RT_ERROR_WAIT_TIMEOUT, "timeout.");
    error = rtInstance->TaskAbortCallBack(devId, RT_DEVICE_ABORT_POST, (timeout != 0U) ? (timeout - timeCost) : timeout);
    mmGetTimeOfDay(&tv[++index], nullptr);
    ERROR_GOTO_MSG_INNER(error, TIMEINFO, "abort post, retCode=%#x", static_cast<uint32_t>(error));

    timeCost = ((tv[index].tv_sec * RT_MS_PER_S) + (tv[index].tv_usec / RT_US_TO_MS) - startTime);
    COND_GOTO_ERROR(((timeout != 0U) && (timeCost > timeout)), TIMEINFO, error, RT_ERROR_WAIT_TIMEOUT, "timeout.");

    error = DeviceQuery(devId, APP_ABORT_TERMINATE_FINISH, (timeout != 0U) ? (timeout - timeCost) : timeout);
    ERROR_GOTO_MSG_INNER(error, TIMEINFO, "DeviceQuery, retCode=%#x", static_cast<uint32_t>(error));
    mmGetTimeOfDay(&tv[++index], nullptr);

    error = DeviceClean(devId);
    mmGetTimeOfDay(&tv[++index], nullptr);
    ERROR_GOTO_MSG_INNER(error, TIMEINFO, "DeviceClean, retCode=%#x", static_cast<uint32_t>(error));

    currentTime = (tv[index].tv_sec * RT_MS_PER_S) + (tv[index].tv_usec / RT_US_TO_MS);
    for (Context *const ctx : g_ctxMan.GetSetObj()) {
        COND_GOTO_ERROR((ctx->Device_() == nullptr), TIMEINFO, error, RT_ERROR_CONTEXT_NULL, "ctx device is null.");
        COND_PROC((ctx->Device_()->Id_() != static_cast<uint32_t>(devId)), continue);
        (void)NpuDriver::GetPageFaultCount(static_cast<uint32_t>(devId), &value);
        ctx->Device_()->SetPageFaultBaseCnt(value);
        ctx->Device_()->SetPageFaultBaseTime(currentTime);
    }
    mmGetTimeOfDay(&tv[++index], nullptr);

TIMEINFO:
    for (size_t i = 1; i <= static_cast<size_t>(index); ++i) {
        static const char* stepDesc[] = {
            "Unknown step",
            "DeviceAbort: Set device task abort state",
            "TaskAbortCallBack pre: Notify registered modules to abort",
            "Devicekill: Execute task kill",
            "DeviceQuery: Check task execution status",
            "TaskAbortCallBack post: Module-registered callback notifies kill",
            "DeviceQuery terminate finish: Query task execution status",
            "DeviceClean: Notify clean",
            "DeviceClean finish: Runtime-related resource cleanup completed",
        };  
        const char* desc = (i < sizeof(stepDesc) / sizeof(stepDesc[0])) ? stepDesc[i] : "Unknown step";
        RT_LOG(RT_LOG_EVENT, "device %d, step %u: %s, time cost: %llu us", devId, i, desc,
            (tv[i].tv_sec - tv[i - 1U].tv_sec) * RT_MS_PER_S * RT_US_TO_MS + tv[i].tv_usec - tv[i - 1U].tv_usec);
    }

    return error;
}

void ContextManage::TryToRecycleCtxMdlPool()
{
    RT_LOG(RT_LOG_INFO, "start recycle ctx pool");
    const ReadProtect rp(&g_ctxMan.GetSetRwLock());
    for (Context *const ctx : g_ctxMan.GetSetObj()) {
        ctx->TryToRecycleModulePool();
    }
    RT_LOG(RT_LOG_INFO, "finish recycle ctx pool");
    return;
}

void ContextManage::SetGlobalErrToCtx(const rtError_t errCode)
{
    if (errCode == ACL_RT_SUCCESS) {
        return;
    }
    Context *curCtx = InnerThreadLocalContainer::GetCurCtx();
    if (curCtx != nullptr) {
        if (ContextManage::CheckContextIsValid(curCtx, true)) {
            const ContextProtect tmpCtxCp(curCtx);
            curCtx->SetContextLastErr(errCode);
        }
    }
    RefObject<Context *> *curRef = InnerThreadLocalContainer::GetCurRef();
    if ((curRef != nullptr) && (curRef->GetVal() != nullptr)) {
        if (ContextManage::CheckContextIsValid(curRef->GetVal(), true)) {
            const ContextProtect tmpRefCp(curRef->GetVal());
            curRef->GetVal()->SetContextLastErr(errCode);
        }
    }
}

void ContextManage::SetGlobalFailureErr(const uint32_t devId, const rtError_t errCode)
{
    if (errCode == ACL_RT_SUCCESS) {
        return;
    }
    RT_LOG(RT_LOG_ERROR, "SetGlobalFailureErr start, device_id=%u, errcode=%#X", devId, errCode);
    const ReadProtect wp(&g_ctxMan.GetSetRwLock());
    for (Context *const ctx : g_ctxMan.GetSetObj()) {
        if (ctx != nullptr && ctx->Device_() != nullptr) {
            COND_PROC((ctx->Device_()->Id_() != devId), continue);
            ctx->SetFailureError(errCode);
            ctx->SetStreamsStatus(errCode);
            ctx->Device_()->SetDeviceStatus(errCode);
        }
    }
    RT_LOG(RT_LOG_ERROR, "SetGlobalFailureErr end");
    return;
}

void ContextManage::DeviceGetStreamlist(int32_t devId, rtStreamlistType_t type, rtStreamlist_t *stmList)
{
    RT_LOG(RT_LOG_INFO, "start");
    const ReadProtect rp(&(g_ctxMan.GetSetRwLock()));
    stmList->stmNum = 0U;
    for (Context *const ctx : g_ctxMan.GetSetObj()) {
        COND_PROC((ctx->Device_()->Id_() != static_cast<uint32_t>(devId)), continue);
        ctx->GetStreamlist(type, stmList);
    }
}

void ContextManage::DeviceGetModelList(int32_t devId, rtModelList_t *mdlList)
{
    RT_LOG(RT_LOG_INFO, "start");
    const ReadProtect rp(&(g_ctxMan.GetSetRwLock()));
    mdlList->mdlNum = 0U;
    for (Context *const ctx : g_ctxMan.GetSetObj()) {
        COND_PROC((ctx->Device_()->Id_() != static_cast<uint32_t>(devId)), continue);
        ctx->GetModelList(mdlList);
    }
}

bool ContextManage::CheckStreamPtrIsValid(Stream * const stm)
{
    RT_LOG(RT_LOG_INFO, "start");
    const ReadProtect rp(&(g_ctxMan.GetSetRwLock()));
    for (Context * const ctx : g_ctxMan.GetSetObj()) {
        if (ctx->IsStreamInContext(stm)) {
            return true;
        }
    }
    return false;
}

rtError_t ContextManage::DeviceResourceClean(int32_t devId)
{
    rtError_t error = RT_ERROR_DEVICE_NULL;
    const ReadProtect rp(&(g_ctxMan.GetSetRwLock()));
    for (Context * const ctx : g_ctxMan.GetSetObj()) {
        COND_PROC((ctx->Device_()->Id_() != static_cast<uint32_t>(devId)), continue);
        error = ctx->ResourceReset();
        break;
    }
    return error;
}

static rtError_t PreProcessBackup()
{
    // 做device同步，确保已经没有任务在执行
    rtError_t ret = RT_ERROR_CONTEXT_NULL;
    const ReadProtect wp(&(g_ctxMan.GetSetRwLock()));
    for (Context *const ctx : g_ctxMan.GetSetObj()) {
        ret = ctx->Synchronize(-1); // -1表示永不超时
        ERROR_RETURN(ret, "Synchronize failed, ret=%#x.", ret);
    }
    return ret;
}

rtError_t ContextManage::SnapShotProcessBackup()
{
    rtError_t ret = PreProcessBackup();
    ERROR_RETURN(ret, "PreProcessBackup failed, ret=%#x.", ret);

    for (uint32_t devId = 0; devId < static_cast<uint32_t>(RT_MAX_DEV_NUM); devId++) {
        Device *dev = Runtime::Instance()->GetDevice(devId, 0U);
        if (dev == nullptr) {
            continue;
        }
        ret = ModelBackup(static_cast<int32_t>(devId));
        ERROR_RETURN(ret, "ModelBackup failed, ret=%#x, devId=%u.", static_cast<uint32_t>(ret), devId);
    }

    // 申请host内存，保存所有launch过的算子.o
    Runtime::Instance()->SaveModule();

    // driver备份
    return NpuDriver::ProcessResBackup();
}

static rtError_t DeviceRestore()
{
    // 先重新打开所有device
    for (int32_t devId = 0; devId < static_cast<int32_t>(RT_MAX_DEV_NUM); ++devId) {
        Device *dev = Runtime::Instance()->GetDevice(devId, 0U);
        if (dev == nullptr) {
            continue;
        }

        const rtError_t ret = dev->ReOpen();
        if (ret == RT_ERROR_DRV_NOT_SUPPORT) {
            return ret;
        }
        ERROR_RETURN(ret, "DeviceOpen failed, ret=%#x, devId=%d.", ret, devId);
    }

    // 恢复进程上所有的页表信息
    return NpuDriver::ProcessResRestore();
}

static rtError_t ResourceRestore()
{
    rtError_t ret = RT_ERROR_CONTEXT_NULL;
    {
        const ReadProtect wp(&(g_ctxMan.GetSetRwLock()));
        // 重新申请所有ctx上的stream id/event id/notify id
        for (Context *const ctx : g_ctxMan.GetSetObj()) {
            ret = ctx->StreamsTaskClean();
            ERROR_RETURN(ret, "clean stream, ret=%#x.", ret);
            ret = ctx->StreamsRestore();
            ERROR_RETURN(ret, "Realloc stream id failed, ret=%#x.", ret);
        }
    }

    // 重新下发device上的配置任务，需要在stream上下发任务，因此必须在stream恢复之后做
    for (int32_t devId = 0; devId < static_cast<int32_t>(RT_MAX_DEV_NUM); ++devId) {
        Device *dev = Runtime::Instance()->GetDevice(devId, 0U);
        if (dev == nullptr) {
            continue;
        }
        ret = dev->EventsReAllocId();
        ERROR_RETURN(ret, "Realloc event id failed, ret=%#x.", ret);

        ret = dev->NotifiesReAllocId();
        ERROR_RETURN(ret, "Realloc notify id failed, ret=%#x.", ret);
 
        ret = dev->ResourceRestore();
        ERROR_RETURN(ret, "Device resource restore failed, devId=%d, ret=%#x.", devId, ret);
    }
    return ret;
}

rtError_t ContextManage::SnapShotProcessRestore()
{
    RT_LOG(RT_LOG_INFO, "start to restore resource");
    rtError_t ret = DeviceRestore();
    if (ret == RT_ERROR_DRV_NOT_SUPPORT) {
        return ret;
    }
    ERROR_RETURN(ret, "DeviceRestore failed, ret=%#x.", ret);

    ret = ResourceRestore();
    ERROR_RETURN(ret, "Resource Restore failed, ret=%#x.", ret);
    for (uint32_t devId = 0; devId < static_cast<uint32_t>(RT_MAX_DEV_NUM); devId++) {
        Device *dev = Runtime::Instance()->GetDevice(devId, 0U);
        if (dev == nullptr) {
            continue;
        }

        DeviceSnapshot *deviceSnapShot = dev->GetDeviceSnapShot();
        NULL_PTR_RETURN_MSG(deviceSnapShot, RT_ERROR_MEMORY_ALLOCATION);

        ret = deviceSnapShot->OpMemoryRestore();
        ERROR_RETURN(ret, "memory restore failed, ret=%#x, devId=%u", static_cast<uint32_t>(ret), devId);

        ret = deviceSnapShot->ArgsPoolRestore();
        ERROR_RETURN(ret, "args pool addr restore failed, ret=%#x, devId=%u", static_cast<uint32_t>(ret), devId);

        ret = ModelRestore(static_cast<int32_t>(devId));
        ERROR_RETURN(ret, "ModelRestore failed, ret=%#x, devId=%u.", static_cast<uint32_t>(ret), devId);
        dev->ArgLoader_()->RestoreAiCpuKernelInfo();
    }

    // kernel info restore
    ret = Runtime::Instance()->RestoreModule();
    ERROR_RETURN(ret, "Module Restore failed, ret=%#x.", static_cast<uint32_t>(ret));
    RT_LOG(RT_LOG_INFO, "the resource is restored successfully");
    return RT_ERROR_NONE;
}

rtError_t ContextManage::SinkTaskMemoryBackup(const int32_t devId)
{
    Device *dev = Runtime::Instance()->GetDevice(static_cast<uint32_t>(devId), 0U);
    COND_RETURN_ERROR((dev == nullptr), RT_ERROR_DEVICE_NULL, "Get dev nullptr, devId=%d", devId);
    DeviceSnapshot *deviceSnapShot = dev->GetDeviceSnapShot();
    NULL_PTR_RETURN_MSG(deviceSnapShot, RT_ERROR_MEMORY_ALLOCATION);
    const rtError_t error = deviceSnapShot->OpMemoryBackup();
    ERROR_RETURN(error, "memcpy back up failed, retCode=%#x.", error);
    return error;
}

rtError_t ContextManage::ModelBackup(const int32_t devId)
{
    auto mdlList = std::make_unique<rtModelList_t>();
    NULL_PTR_RETURN(mdlList, RT_ERROR_MEMORY_ALLOCATION);
    DeviceGetModelList(devId, mdlList.get());
    COND_RETURN_DEBUG((mdlList->mdlNum == 0U),
        RT_ERROR_NONE, "No model needs to be backed up, devId=%d.", devId);
    for (uint32_t i = 0U; i < mdlList->mdlNum; i++) {
        Model *mdl = RtPtrToPtr<Model *>(mdlList->mdls[i]);
        COND_RETURN_WARN((mdl->GetModelExecutorType() != EXECUTOR_TS),
            RT_ERROR_FEATURE_NOT_SUPPORT,
            "Snapshots cannot be created for models with the AICPU execution type.");
        COND_RETURN_ERROR((!mdl->IsModelLoadComplete()),
            RT_ERROR_SNAPSHOT_BACKUP_FAILED,
            "The model is not complete, model_id=%u.", mdl->Id_());
        const rtError_t ret = mdl->SinkSqTasksBackup();
        ERROR_RETURN(ret, "Backup model tasks failed, ret=%#x, devId=%d.", static_cast<uint32_t>(ret), devId);
    }

    /* args device memory and funCall device memory */
    const rtError_t ret = SinkTaskMemoryBackup(devId);
    ERROR_RETURN(ret, "Backup model memory failed, ret=%u, devId=%d", ret, devId);
    return RT_ERROR_NONE;
}

rtError_t ContextManage::ModelRestore(const int32_t devId)
{
    auto mdlList = std::make_unique<rtModelList_t>();
    NULL_PTR_RETURN(mdlList, RT_ERROR_MEMORY_ALLOCATION);
    DeviceGetModelList(devId, mdlList.get());
    COND_RETURN_DEBUG((mdlList->mdlNum == 0U),
        RT_ERROR_NONE, "No model needs to be restore, devId=%d.", devId);
    for (uint32_t i = 0; i < mdlList->mdlNum; i++) {
        Model *mdl = RtPtrToPtr<Model *>(mdlList->mdls[i]);
        COND_RETURN_WARN((mdl->GetModelExecutorType() != EXECUTOR_TS),
            RT_ERROR_FEATURE_NOT_SUPPORT,
            "Models with the AICPU executor type cannot be restored.");
        const rtError_t ret = mdl->ReBuild();
        ERROR_RETURN(ret, "Rebuild model failed, ret=%#x, devId=%d.", static_cast<uint32_t>(ret), devId);
    }
    return RT_ERROR_NONE;
}
}  // namespace runtime
}  // namespace cce
