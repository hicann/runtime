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
#include "context.hpp"
#include "device.hpp"
#include "runtime.hpp"
#include "capture_model_utils.hpp"
#include "idevice_snapshot_ops.hpp"
#include "npu_driver.hpp"
#include "model.hpp"

namespace cce {
namespace runtime {
rtError_t SnapShotPreProcessBackup(ContextDataManage& ctxMan)
{
    // 做device同步，确保已经没有任务在执行
    rtError_t ret = RT_ERROR_CONTEXT_NULL;
    const ReadProtect wp(&(ctxMan.GetSetRwLock()));
    for (Context* const ctx : ctxMan.GetSetObj()) {
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
            ret = ctx->StreamsTaskClean();
            ERROR_RETURN(ret, "clean stream, ret=%#x.", ret);
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

rtError_t SnapShotAclGraphRestore(Device* const dev)
{
    RT_LOG(RT_LOG_INFO, "Start to restore aclgraph.");
    NULL_PTR_RETURN(dev, RT_ERROR_DEVICE_NULL);
    const uint32_t deviceId = dev->Id_();
    ContextDataManage& ctxMan = ContextDataManage::Instance();
    const ReadProtect rp(&ctxMan.GetSetRwLock());

    Driver* drv = dev->Driver_();
    const uint32_t tsId = dev->DevGetTsId();

    for (Context* const ctx : ctxMan.GetSetObj()) {
        if (ctx->Device_()->Id_() != deviceId) {
            continue;
        }
        SpinLock& modelLock = ctx->GetModelLock();
        modelLock.Lock();
        for (Model* mdl : ctx->GetModelList()) {
            if (mdl == nullptr) {
                continue;
            }
            // 只恢复扩流场景的model
            if (mdl->GetModelType() != ModelType::RT_MODEL_CAPTURE_MODEL) {
                continue;
            }
            CaptureModel* capMdl = dynamic_cast<CaptureModel*>(mdl);
            if (capMdl == nullptr) {
                RT_LOG(RT_LOG_WARNING, "Dynamic cast to CaptureModel failed, modelId=%u.", mdl->Id_());
                continue;
            }
            if (capMdl->IsSoftwareSqEnable() && capMdl->IsCaptureReady()) {
                // 恢复modelID
                rtError_t err = drv->ReAllocResourceId(deviceId, tsId, 0U, mdl->Id_(), DRV_MODEL_ID);
                if (err != RT_ERROR_NONE) {
                    modelLock.Unlock();
                    ERROR_RETURN(
                        err, "Realloc modelId failed, deviceId=%u, tsId=%u, retCode=%#x!", deviceId, tsId,
                        static_cast<uint32_t>(err));
                }

                err = capMdl->RestoreForSoftwareSq(dev);
                if (err != RT_ERROR_NONE) {
                    modelLock.Unlock();
                    ERROR_RETURN(
                        err, "Restore capture model failed, deviceId=%u, tsId=%u, retCode=%#x!", deviceId, tsId,
                        static_cast<uint32_t>(err));
                }
            }
        }
        modelLock.Unlock();
    }

    const rtError_t err = dev->RestoreSqCqPool();
    ERROR_RETURN(err, "Restore SqCqPool failed, deviceId=%u, retCode=%#x!", deviceId, static_cast<uint32_t>(err));
    return RT_ERROR_NONE;
}

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
        if (ctx->Device_()->Id_() != static_cast<uint32_t>(devId)) {
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
                    "Snapshots cannot be created for models with the AICPU execution type.");
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
        if (ctx->Device_()->Id_() != static_cast<uint32_t>(devId)) {
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
    }

    ret = Runtime::Instance()->RestoreModule();
    ERROR_RETURN(ret, "Module Restore failed, ret=%#x.", static_cast<uint32_t>(ret));
    RT_LOG(RT_LOG_INFO, "the resource is restored successfully");
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
