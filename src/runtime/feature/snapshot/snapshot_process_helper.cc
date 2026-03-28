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
#include "context_manage.hpp"
#include "context.hpp"
#include "device.hpp"
#include "runtime.hpp"
#include "capture_model_utils.hpp"

namespace cce {
namespace runtime {
rtError_t SnapShotPreProcessBackup(ContextDataManage &ctxMan)
{
    // 做device同步，确保已经没有任务在执行
    rtError_t ret = RT_ERROR_CONTEXT_NULL;
    const ReadProtect wp(&(ctxMan.GetSetRwLock()));
    for (Context *const ctx : ctxMan.GetSetObj()) {
        ret = ctx->Synchronize(-1); // -1表示永不超时
        ERROR_RETURN(ret, "Synchronize failed, ret=%#x.", ret);
    }
    return ret;
}

rtError_t SnapShotDeviceRestore()
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

rtError_t SnapShotResourceRestore(ContextDataManage &ctxMan)
{
    rtError_t ret = RT_ERROR_CONTEXT_NULL;
    {
        const ReadProtect wp(&(ctxMan.GetSetRwLock()));
        // 重新申请所有ctx上的stream id/event id/notify id
        for (Context *const ctx : ctxMan.GetSetObj()) {
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

        ret = dev->EventExpandingPoolRestore();
        ERROR_RETURN(ret, "EventexpandingPool restore failed, devId=%d, ret=%#x.", devId, ret);
    }
    return ret;
}

rtError_t SnapShotAclGraphRestore(Device * const dev)
{
    RT_LOG(RT_LOG_INFO, "Start to restore aclgraph.");
    NULL_PTR_RETURN(dev, RT_ERROR_DEVICE_NULL);
    const int32_t deviceId = dev->Id_();
    auto mdlList = std::make_unique<rtModelList_t>();
    NULL_PTR_RETURN(mdlList, RT_ERROR_MEMORY_ALLOCATION);
    ContextManage::DeviceGetModelList(deviceId, mdlList.get());
    COND_RETURN_DEBUG((mdlList->mdlNum == 0U),
        RT_ERROR_NONE, "No model needs to be restore, devId=%d.", deviceId);

    Driver *drv = dev->Driver_();
    const uint32_t tsId = dev->DevGetTsId();

    for (uint32_t i = 0; i < mdlList->mdlNum; i ++) {
        Model *mdl = RtPtrToPtr<Model *>(mdlList->mdls[i]);
        // 只恢复扩流场景的mode
        if (mdl->GetModelType() != ModelType::RT_MODEL_CAPTURE_MODEL) {
            continue;
        }
        CaptureModel *capMdl = dynamic_cast<CaptureModel *>(mdl);
        if (capMdl == nullptr) {
            RT_LOG(RT_LOG_WARNING, "Dynamic cast to CaptureModel failed, modelId=%u.", mdl->Id_());
            continue;
        }
        if (capMdl->IsSoftwareSqEnable() && capMdl->IsCaptureReady()) {
            // 恢复modelID
            rtError_t err = drv->ReAllocResourceId(deviceId, tsId, 0U, mdl->Id_(), DRV_MODEL_ID);
            ERROR_RETURN(err, "Realloc modelId failed, deviceId=%u, tsId=%u, retCode=%#x!",
                deviceId, tsId, static_cast<uint32_t>(err));

            err = capMdl->RestoreForSoftwareSq(dev);
            ERROR_RETURN(err, "Restore capture model failed, deviceId=%u, tsId=%u, retCode=%#x!",
                deviceId, tsId, static_cast<uint32_t>(err));
        }
    }

    rtError_t err = dev->RestoreSqCqPool();
    ERROR_RETURN(err, "Restore SqCqPool failed, deviceId=%u, retCode=%#x!",
                deviceId, static_cast<uint32_t>(err));
    return RT_ERROR_NONE;
}
}
}  // namespace cce
