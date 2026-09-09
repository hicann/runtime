/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "snapshot_process_helper.hpp"
#include "context_data_manage.h"
#include "context_manage.hpp"
#include "context.hpp"
#include "device.hpp"
#include "runtime.hpp"
#include "capture_model_utils.hpp"
#include "idevice_snapshot_ops.hpp"
#include "npu_driver.hpp"
#include "model.hpp"
#include "jetty_manager.h"
#include "aicpu_timeout_manager.h"
#include "logic_sq_manage.hpp"
#include "program.hpp"
#include "stream.hpp"
#include "osal.hpp"
#include "aicpu_dfx.hpp"
#include "rt_external_mem.h"

namespace cce {
namespace runtime {

rtError_t SnapShotPreProcessBackup(ContextDataManage& ctxMan)
{
    // 做device同步，确保已经没有任务在执行
    rtError_t ret = RT_ERROR_CONTEXT_NULL;
    const ReadProtect wp(&(ctxMan.GetSetRwLock()));
    for (Context* const ctx : ctxMan.GetSetObj()) {
        // Primary contexts stay in the global set after reset, but their resources have been released.
        if (!ContextManage::IsActiveContext(ctx)) {
            continue;
        }
        ret = ctx->Synchronize(-1); // -1表示永不超时
        ERROR_RETURN(ret, "Synchronize failed, ret=%#x.", ret);
    }
    return ret;
}

rtError_t SnapShotDeviceRestore()
{
    // 先重新打开所有device
    for (int32_t devId = 0; devId < static_cast<int32_t>(RT_MAX_DEV_NUM); ++devId) {
        Device* dev = Runtime::Instance()->GetDevice(devId, 0U);
        if (dev == nullptr) {
            continue;
        }
        const rtError_t ret = dev->ReOpen();
        if (ret == RT_ERROR_DRV_NOT_SUPPORT) {
            RT_LOG(RT_LOG_WARNING, "DeviceReOpen driver does not support, ret=%#x, devId=%d.", ret, devId);
            return ret;
        }
        ERROR_RETURN(ret, "DeviceOpen failed, ret=%#x, devId=%d.", ret, devId);
    }

    // 恢复进程上所有的页表信息
    return NpuDriver::ProcessResRestore();
}

rtError_t SnapShotResourceRestore(ContextDataManage& ctxMan)
{
    rtError_t ret = RT_ERROR_CONTEXT_NULL;
    {
        const ReadProtect wp(&(ctxMan.GetSetRwLock()));
        // 重新申请所有ctx上的stream id/event id/notify id
        for (Context* const ctx : ctxMan.GetSetObj()) {
            if (!ContextManage::HasActiveDevice(ctx)) {
                continue;
            }
            ret = ctx->StreamsTaskClean();
            ERROR_RETURN(ret, "clean stream task failed, retCode=%#x.", ret);
            ret = ctx->StreamsRestore();
            ERROR_RETURN(ret, "Realloc stream id failed, ret=%#x.", ret);
        }
    }

    // 重新下发device上的配置任务，需要在stream上下发任务，因此必须在stream恢复之后做
    for (int32_t devId = 0; devId < static_cast<int32_t>(RT_MAX_DEV_NUM); ++devId) {
        Device* dev = Runtime::Instance()->GetDevice(devId, 0U);
        if (dev == nullptr) {
            continue;
        }
        ret = dev->EventsReAllocId();
        ERROR_RETURN(ret, "Realloc event id failed, ret=%#x.", ret);

        ret = dev->NotifiesReAllocId();
        ERROR_RETURN(ret, "Realloc notify id failed, ret=%#x.", ret);

        ret = dev->CntNotifiesReAllocId();
        ERROR_RETURN(ret, "Realloc count notify id failed, ret=%#x.", ret);

        ret = dev->ResourceRestore();
        ERROR_RETURN(ret, "Device resource restore failed, devId=%d, ret=%#x.", devId, ret);

        ret = dev->EventExpandingPoolRestore();
        ERROR_RETURN(ret, "EventexpandingPool restore failed, devId=%d, ret=%#x.", devId, ret);
    }
    return ret;
}

static rtError_t ResetJettyForSnapshotRestore(Device* const dev)
{
    if (!Runtime::Instance()->GetConnectUbFlag()) {
        return RT_ERROR_NONE;
    }
    JettyManager* const jettyMgr = dev->GetJettyManager();
    if (jettyMgr == nullptr) {
        return RT_ERROR_NONE;
    }
    const rtError_t err = jettyMgr->ResetJettyForSnapshotRestore();
    ERROR_RETURN(
        err, "Reset jetty for snapshot restore failed, deviceId=%u, retCode=%#x!", dev->Id_(),
        static_cast<uint32_t>(err));
    return RT_ERROR_NONE;
}

static rtError_t RestoreSoftwareSqCaptureModel(
    Device* const dev, Driver* const drv, const uint32_t tsId, Model* const mdl)
{
    if (mdl == nullptr) {
        return RT_ERROR_NONE;
    }
    // 只恢复扩流场景的model
    if (mdl->GetModelType() != ModelType::RT_MODEL_CAPTURE_MODEL) {
        return RT_ERROR_NONE;
    }
    CaptureModel* capMdl = dynamic_cast<CaptureModel*>(mdl);
    if (capMdl == nullptr) {
        RT_LOG(RT_LOG_WARNING, "Dynamic cast to CaptureModel failed, modelId=%u.", mdl->Id_());
        return RT_ERROR_NONE;
    }
    if ((!capMdl->IsSoftwareSqEnable()) || (!capMdl->IsCaptureReady())) {
        return RT_ERROR_NONE;
    }

    const uint32_t deviceId = dev->Id_();
    rtError_t err = drv->ReAllocResourceId(deviceId, tsId, 0U, mdl->Id_(), DRV_MODEL_ID);
    ERROR_RETURN(
        err, "Realloc modelId failed, deviceId=%u, tsId=%u, retCode=%#x!", deviceId, tsId, static_cast<uint32_t>(err));

    err = capMdl->RestoreForSoftwareSq(dev);
    ERROR_RETURN(
        err, "Restore capture model failed, deviceId=%u, tsId=%u, retCode=%#x!", deviceId, tsId,
        static_cast<uint32_t>(err));
    return RT_ERROR_NONE;
}

rtError_t SnapShotAclGraphRestore(Device* const dev)
{
    RT_LOG(RT_LOG_INFO, "Start to restore aclgraph.");
    NULL_PTR_RETURN(dev, RT_ERROR_DEVICE_NULL);
    const uint32_t deviceId = dev->Id_();
    ContextDataManage& ctxMan = ContextDataManage::Instance();
    const ReadProtect rp(&ctxMan.GetSetRwLock());

    Driver* drv = dev->Driver_();
    const uint32_t tsId = dev->DevGetTsId();

    rtError_t err = ResetJettyForSnapshotRestore(dev);
    ERROR_RETURN(
        err, "Reset jetty for snapshot restore failed, deviceId=%u, retCode=%#x!", deviceId,
        static_cast<uint32_t>(err));

    for (Context* const ctx : ctxMan.GetSetObj()) {
        if (!ContextManage::IsActiveContextOnDevice(ctx, static_cast<int32_t>(deviceId))) {
            continue;
        }
        SpinLock& modelLock = ctx->GetModelLock();
        modelLock.Lock();
        for (Model* mdl : ctx->GetModelList()) {
            err = RestoreSoftwareSqCaptureModel(dev, drv, tsId, mdl);
            if (err != RT_ERROR_NONE) {
                modelLock.Unlock();
                return err;
            }
        }
        modelLock.Unlock();
    }

    err = dev->RestoreSqCqPool();
    ERROR_RETURN(err, "Restore SqCqPool failed, deviceId=%u, retCode=%#x!", deviceId, static_cast<uint32_t>(err));
    return RT_ERROR_NONE;
}

namespace {
constexpr uint32_t MAX_BATCH_SO_NUM = 1024U;

void QueryCustomAicpuProcess(Device* const dev)
{
    dev->SetHasCustomProcess(false);
    rtBindHostpidInfo_t info = {};
    info.chipId = dev->Id_();
    info.cpType = RT_DEV_PROCESS_CP2;
    info.hostPid = mmGetPid();
    int32_t devPid = 0;
    rtError_t ret = NpuDriver::QueryDevPid(&info, &devPid);
    if (ret == RT_ERROR_NONE) {
        dev->SetHasCustomProcess(true);
        RT_LOG(RT_LOG_INFO, "Custom AICPU process detected, deviceId=%u, devPid=%d.", dev->Id_(), devPid);
    }
}

void FreeTempAicpuSoReloadMem(Driver* const drv, const uint32_t devId, std::vector<void*>& devMems)
{
    for (void* const devMem : devMems) {
        if (devMem == nullptr) {
            continue;
        }
        const rtError_t ret = drv->DevMemFree(devMem, devId);
        COND_LOG_WARN(
            ret != RT_ERROR_NONE, "Free temp AICPU so reload buffer failed, deviceId=%u, addr=%p, ret=%#x.", devId,
            devMem, static_cast<uint32_t>(ret));
    }
    devMems.clear();
}

bool IsCustomAicpuProgram(Program* const prog)
{
    if (prog == nullptr) {
        return false;
    }
    if (prog->GetKernelRegType() != RT_KERNEL_REG_TYPE_CPU) {
        return false;
    }

    const void* const soData = prog->Data();
    const uint32_t soSize = prog->LoadSize();
    const std::string& soName = prog->GetSoName();
    if ((soData == nullptr) || (soSize == 0U) || soName.empty()) {
        RT_LOG(
            RT_LOG_DEBUG,
            "Skip invalid custom AICPU program for reload, progId=%u, soData=%p, soSize=%u, soNameLen=%zu.",
            prog->Id_(), soData, soSize, soName.size());
        return false;
    }
    return true;
}

rtError_t BuildAicpuReloadSoBufs(
    Device* const dev, Program* const* progs, const uint32_t batchNum, std::vector<CpuSoBuf>& soBufs,
    std::vector<void*>& allocMem)
{
    for (uint32_t i = 0U; i < batchNum; i++) {
        Program* const prog = progs[i];
        const void* const soData = prog->Data();
        const uint32_t soSize = prog->LoadSize();
        void* devSoBuf = nullptr;
        rtError_t ret = AllocAndCopyHbmBuf(dev, soData, soSize, &devSoBuf, allocMem);
        ERROR_RETURN(
            ret, "Prepare custom AICPU so buffer failed, deviceId=%u, progId=%u, soSize=%u, ret=%#x.", dev->Id_(),
            prog->Id_(), soSize, static_cast<uint32_t>(ret));

        const std::string& soName = prog->GetSoName();
        void* devSoName = nullptr;
        ret = AllocAndCopyHbmBuf(dev, soName.c_str(), soName.size(), &devSoName, allocMem);
        ERROR_RETURN(
            ret, "Prepare custom AICPU so name failed, deviceId=%u, progId=%u, soName=%s, ret=%#x.", dev->Id_(),
            prog->Id_(), soName.c_str(), static_cast<uint32_t>(ret));

        soBufs[i].kernelSoBuf = RtPtrToValue(devSoBuf);
        soBufs[i].kernelSoBufLen = soSize;
        soBufs[i].kernelSoName = RtPtrToValue(devSoName);
        soBufs[i].kernelSoNameLen = static_cast<uint32_t>(soName.size());
    }
    return RT_ERROR_NONE;
}

void DumpCustomAicpuReloadArgs(
    const uint32_t devId, const std::vector<CpuSoBuf>& soBufs, const std::vector<Program*>& aicpuPrograms,
    const uint32_t idx)
{
    for (uint32_t i = 0U; i < soBufs.size(); ++i) {
        Program* const prog = aicpuPrograms[idx + i];
        RT_LOG(
            RT_LOG_DEBUG,
            "AICPU reload arg, deviceId=%u, globalIdx=%u, batchIdx=%u, soName=%s, soNameLen=%u, "
            "devSoBuf=%p, soSize=%u, devSoName=%p.",
            devId, idx + i, i, prog->GetSoName().c_str(), soBufs[i].kernelSoNameLen,
            RtValueToPtr<void*>(soBufs[i].kernelSoBuf), soBufs[i].kernelSoBufLen,
            RtValueToPtr<void*>(soBufs[i].kernelSoName));
    }
}

rtError_t BatchLoadCustomAicpuSo(Device* const dev)
{
    COND_RETURN_DEBUG(
        !dev->GetHasCustomProcess(), RT_ERROR_NONE, "No custom AICPU process, skip batchLoadsoFrombuf, deviceId=%u.",
        dev->Id_());

    const uint32_t devId = dev->Id_();
    std::vector<Program*> programs = dev->GetLoadedPrograms();
    std::vector<Program*> aicpuPrograms;
    for (Program* prog : programs) {
        if (IsCustomAicpuProgram(prog)) {
            aicpuPrograms.push_back(prog);
        }
    }

    COND_RETURN_INFO(aicpuPrograms.empty(), RT_ERROR_NONE, "No custom AICPU program to reload, deviceId=%u.", devId);

    RT_LOG(RT_LOG_INFO, "Custom AICPU programs need reload, deviceId=%u, programNum=%zu.", devId, aicpuPrograms.size());
    Stream* const stm = dev->GetCtrlSQStream(dev->PrimaryStream_());
    COND_RETURN_WARN(
        stm == nullptr, RT_ERROR_STREAM_NULL, "GetCtrlSQStream failed for batchLoadsoFrombuf, deviceId=%u.", devId);
    Driver* const drv = dev->Driver_();

    uint32_t idx = 0U;
    rtError_t ret = RT_ERROR_NONE;
    while (idx < aicpuPrograms.size()) {
        const uint32_t batchNum = std::min(static_cast<uint32_t>(aicpuPrograms.size() - idx), MAX_BATCH_SO_NUM);

        std::vector<CpuSoBuf> soBufs(batchNum);
        std::vector<void*> tempDevMems;
        const std::function<void()> recycle = [&drv, &devId, &tempDevMems]() {
            FreeTempAicpuSoReloadMem(drv, devId, tempDevMems);
        };
        ScopeGuard tempMemGuard(recycle);

        ret = BuildAicpuReloadSoBufs(dev, aicpuPrograms.data() + idx, batchNum, soBufs, tempDevMems);
        ERROR_RETURN(
            ret, "Build AICPU reload so buffers failed, deviceId=%u, batchNum=%u, ret=%#x.", devId, batchNum,
            static_cast<uint32_t>(ret));

        void* devArgsBuf = nullptr;
        const size_t argsBufSize = sizeof(CpuSoBuf) * batchNum;
        ret = AllocAndCopyHbmBuf(dev, soBufs.data(), argsBufSize, &devArgsBuf, tempDevMems);
        ERROR_RETURN(
            ret, "Prepare CpuSoBuf array failed, deviceId=%u, batchNum=%u, ret=%#x.", devId, batchNum,
            static_cast<uint32_t>(ret));

        BatchProcCpuOpFromBufArgs batchArgs = {.soNum = batchNum, .args = RtPtrToValue(devArgsBuf)};
        rtKernelLaunchNames_t launchName = {nullptr, LOAD_CPU_SO.c_str(), ""};
        rtArgsEx_t argsInfo = {};
        argsInfo.args = &batchArgs;
        argsInfo.argsSize = static_cast<uint32_t>(sizeof(BatchProcCpuOpFromBufArgs));
        argsInfo.isNoNeedH2DCopy = 0U; // 0 is need h2d copy

        RT_LOG(
            RT_LOG_INFO, "Launch batchLoadsoFrombuf, deviceId=%u, batchNum=%u, idx=%u, devArgsBuf=%p, argsBufSize=%zu.",
            devId, batchNum, idx, devArgsBuf, argsBufSize);
        ret = LaunchAicpuKernelForCpuSo(&launchName, &argsInfo, stm);
        ERROR_RETURN(
            ret, "Launch batchLoadsoFrombuf failed, deviceId=%u, batchNum=%u, ret=%#x.", devId, batchNum,
            static_cast<uint32_t>(ret));

        ret = stm->Synchronize(false, -1);
        ERROR_RETURN(
            ret, "Stream sync after batchLoadsoFrombuf failed, deviceId=%u, ret=%#x.", devId,
            static_cast<uint32_t>(ret));
        DumpCustomAicpuReloadArgs(devId, soBufs, aicpuPrograms, idx);
        RT_LOG(RT_LOG_INFO, "batchLoadsoFrombuf success, deviceId=%u, batchNum=%u, idx=%u.", devId, batchNum, idx);
        idx += batchNum;
    }

    return ret;
}

rtError_t SetAicpuDfxForRestore(Device* const dev)
{
    COND_RETURN_INFO(
        !dev->IsAicpuDfxSupport(), RT_ERROR_NONE, "AICPU dfx not supported, skip restore, deviceId=%u.", dev->Id_());

    rtError_t ret = RT_ERROR_NONE;
    COND_RETURN_INFO(
        !dev->IsAicpuPrintfReady(), ret, "AICPU printf not ready, skip dfx restore, deviceId=%u.", dev->Id_());

    ret = dev->ReInitAicpuPrintfMem();
    COND_RETURN_ERROR(
        ret != RT_ERROR_NONE, ret, "ReInitAicpuPrintfMem failed, deviceId=%u, ret=%#x.", dev->Id_(),
        static_cast<uint32_t>(ret));

    // GetPrintFifoAddrAndCreateThread 内部判空，不会重复创建线程。
    ret = SetupAicpuPrintfDfx(dev, dev->Id_());
    COND_RETURN_ERROR(
        ret != RT_ERROR_NONE, ret, "SetAicpuDfx for restore failed, deviceId=%u, ret=%#x.", dev->Id_(),
        static_cast<uint32_t>(ret));
    RT_LOG(RT_LOG_INFO, "SetAicpuDfx for restore success, deviceId=%u.", dev->Id_());
    return ret;
}
} // namespace

rtError_t SinkTaskMemoryBackup(const int32_t devId)
{
    Device* dev = Runtime::Instance()->GetDevice(static_cast<uint32_t>(devId), 0U);
    COND_RETURN_ERROR((dev == nullptr), RT_ERROR_DEVICE_NULL, "Get dev nullptr, devId=%d", devId);
    IDeviceSnapshotOps* deviceSnapShot = dev->GetDeviceSnapShot();
    NULL_PTR_RETURN_MSG(deviceSnapShot, RT_ERROR_MEMORY_ALLOCATION);
    const rtError_t error = deviceSnapShot->OpMemoryBackup();
    ERROR_RETURN(error, "memcpy back up failed, retCode=%#x.", error);
    return error;
}

rtError_t ModelBackup(const int32_t devId)
{
    ContextDataManage& ctxMan = ContextDataManage::Instance();
    const ReadProtect rp(&ctxMan.GetSetRwLock());
    for (Context* const ctx : ctxMan.GetSetObj()) {
        if (!ContextManage::IsActiveContextOnDevice(ctx, devId)) {
            continue;
        }
        SpinLock& mdlLock = ctx->GetModelLock();
        mdlLock.Lock();
        for (Model* mdl : ctx->GetModelList()) {
            if (mdl == nullptr) {
                continue;
            }
            if (mdl->GetModelExecutorType() != EXECUTOR_TS) {
                mdlLock.Unlock();
                COND_RETURN_WARN(
                    true, RT_ERROR_FEATURE_NOT_SUPPORT,
                    "Snapshots cannot be created for models with the AICPU execution type, model_type=%u.",
                    mdl->GetModelExecutorType());
            }
            if (IsSoftwareSqCaptureModel(mdl) || mdl->IsAutoSplitSq()) {
                continue;
            }
            if (!mdl->IsModelLoadComplete()) {
                mdlLock.Unlock();
                COND_RETURN_ERROR(
                    true, RT_ERROR_SNAPSHOT_BACKUP_FAILED, "The model is not complete, model_id=%u.", mdl->Id_());
            }
            const rtError_t ret = mdl->SinkSqTasksBackup();
            if (ret != RT_ERROR_NONE) {
                mdlLock.Unlock();
                ERROR_RETURN(ret, "Backup model tasks failed, ret=%#x, devId=%d.", static_cast<uint32_t>(ret), devId);
            }
        }
        mdlLock.Unlock();
    }

    const rtError_t ret = SinkTaskMemoryBackup(devId);
    ERROR_RETURN(ret, "Backup model memory failed, ret=%u, devId=%d", ret, devId);
    return RT_ERROR_NONE;
}

rtError_t ModelRestore(const int32_t devId)
{
    ContextDataManage& ctxMan = ContextDataManage::Instance();
    const ReadProtect rp(&ctxMan.GetSetRwLock());
    // loop ctx
    for (Context* const ctx : ctxMan.GetSetObj()) {
        if (!ContextManage::IsActiveContextOnDevice(ctx, devId)) {
            continue;
        }
        SpinLock& modelLock = ctx->GetModelLock();
        modelLock.Lock();
        for (Model* mdl : ctx->GetModelList()) {
            if (mdl == nullptr) {
                continue;
            }
            if (mdl->GetModelExecutorType() != EXECUTOR_TS) {
                modelLock.Unlock();
                COND_RETURN_WARN(
                    true, RT_ERROR_FEATURE_NOT_SUPPORT, "Models with the AICPU executor type cannot be restored.");
            }
            if (IsSoftwareSqCaptureModel(mdl) || mdl->IsAutoSplitSq()) {
                continue;
            }
            const rtError_t ret = mdl->ReBuild();
            if (ret != RT_ERROR_NONE) {
                modelLock.Unlock();
                ERROR_RETURN(ret, "Rebuild model failed, ret=%#x, devId=%d.", static_cast<uint32_t>(ret), devId);
            }
        }
        modelLock.Unlock();
    }
    return RT_ERROR_NONE;
}

rtError_t SnapShotProcessBackup()
{
    ContextDataManage& ctxMan = ContextDataManage::Instance();
    rtError_t ret = SnapShotPreProcessBackup(ctxMan);
    ERROR_RETURN(ret, "PreProcessBackup failed, ret=%#x.", ret);

    for (uint32_t devId = 0; devId < static_cast<uint32_t>(RT_MAX_DEV_NUM); devId++) {
        Device* dev = Runtime::Instance()->GetDevice(devId, 0U);
        if (dev == nullptr) {
            continue;
        }
        QueryCustomAicpuProcess(dev);
        ret = ModelBackup(static_cast<int32_t>(devId));
        COND_RETURN_WITH_NOLOG(ret != RT_ERROR_NONE, ret);
    }

    Runtime::Instance()->SaveModule();
    return NpuDriver::ProcessResBackup();
}

rtError_t SnapShotProcessRestore()
{
    ContextDataManage& ctxMan = ContextDataManage::Instance();
    RT_LOG(RT_LOG_INFO, "start to restore resource");
    rtError_t ret = SnapShotDeviceRestore();
    if (ret == RT_ERROR_DRV_NOT_SUPPORT) {
        return ret;
    }
    ERROR_RETURN(ret, "DeviceRestore failed, ret=%#x.", ret);

    ret = SnapShotResourceRestore(ctxMan);
    ERROR_RETURN(ret, "Resource Restore failed, ret=%#x.", ret);

    ret = Runtime::Instance()->RestoreModule();
    ERROR_RETURN(ret, "Module Restore failed, ret=%#x.", static_cast<uint32_t>(ret));

    for (uint32_t devId = 0; devId < static_cast<uint32_t>(RT_MAX_DEV_NUM); devId++) {
        Device* dev = Runtime::Instance()->GetDevice(devId, 0U);
        if (dev == nullptr) {
            continue;
        }

        IDeviceSnapshotOps* deviceSnapShot = dev->GetDeviceSnapShot();
        NULL_PTR_RETURN_MSG(deviceSnapShot, RT_ERROR_MEMORY_ALLOCATION);

        ret = deviceSnapShot->OpMemoryRestore();
        ERROR_RETURN(ret, "memory restore failed, ret=%#x, devId=%u", static_cast<uint32_t>(ret), devId);

        ret = deviceSnapShot->ArgsPoolRestore();
        ERROR_RETURN(ret, "args pool addr restore failed, ret=%#x, devId=%u", static_cast<uint32_t>(ret), devId);

        ret = deviceSnapShot->UbArgsPoolRestore();
        ERROR_RETURN(ret, "ub args pool addr restore failed, ret=%#x, devId=%u", static_cast<uint32_t>(ret), devId);

        ret = ModelRestore(static_cast<int32_t>(devId));
        ERROR_RETURN(ret, "ModelRestore failed, ret=%#x, devId=%u.", static_cast<uint32_t>(ret), devId);

        ret = SnapShotAclGraphRestore(dev);
        ERROR_RETURN(ret, "ACL Graph restore failed, ret=%#x, devId=%u.", static_cast<uint32_t>(ret), devId);

        dev->ArgLoader_()->RestoreAiCpuKernelInfo();
        AicpuTimeoutManager::ClearAicpuTimeoutState(dev);
#ifndef CFG_DEV_PLATFORM_PC
        ret = AicpuTimeoutManager::TryCloseAicpuMonitor(dev);
        ERROR_RETURN(ret, "Close AI CPU monitor failed, ret=%#x, devId=%u.", ret, devId);
#endif
        ret = BatchLoadCustomAicpuSo(dev);
        ERROR_RETURN(ret, "BatchLoadCustomAicpuSo failed, ret=%#x, devId=%u.", static_cast<uint32_t>(ret), devId);

        ret = SetAicpuDfxForRestore(dev);
        ERROR_RETURN(ret, "SetAicpuDfxForRestore failed, ret=%#x, devId=%u.", static_cast<uint32_t>(ret), devId);
    }

    RT_LOG(RT_LOG_INFO, "the resource is restored successfully");
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
