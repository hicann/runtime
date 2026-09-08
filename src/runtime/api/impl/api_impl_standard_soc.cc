/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <map>
#include <string>
#include "api_impl.hpp"
#include "device_enum_desc.hpp"
#include "runtime_handle_guard.h"
#include "maintenance_task.h"
#include "memory_task.h"
#include "base.hpp"
#include "stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "event.hpp"
#include "event_task.h"
#include "program.hpp"
#include "notify.hpp"
#include "device.hpp"
#include "task.hpp"
#include "task_enum_desc.hpp"
#include "host_task.hpp"
#include "kernel_utils.hpp"
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
#include "dvpp_grp.hpp"
#include "driver/ascend_hal.h"
#include "task_submit.hpp"
#include "platform/platform_info.h"
#include "platform_manager_v2.h"
#include "stream_factory.hpp"
#include "device/device_error_proc.hpp"
#include "stream_state_callback_manager.hpp"
#include "stream_launch_blocking.hpp"
#include "heterogenous.h"
#include "capture_model.hpp"
#include "capture_model_utils.hpp"
#include "stars_engine.hpp"
#include "binary_loader.hpp"
#include "args_handle_allocator.hpp"
#include "para_convertor.hpp"
#include "soc_info.h"
#include "inner_thread_local.hpp"
#include "soma.hpp"
#include "memset_common.h"
#include "memory_c.hpp"
#include "aicpu_c.hpp"
#include "enum_desc.hpp"
#include "global_state_manager.hpp"
#include "snapshot_callback_manager.hpp"
#include "snapshot_process_helper.hpp"

namespace cce {
namespace runtime {

rtError_t ApiImpl::SnapShotProcessLock()
{
    rtError_t error = SnapshotCallbackManager::GetInstance().InvokeCallbacks(RT_SNAPSHOT_LOCK_PRE);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    error = GlobalStateManager::GetInstance().Locked();
    return error;
}

rtError_t ApiImpl::SnapShotProcessUnlock()
{
    rtError_t error = GlobalStateManager::GetInstance().Unlocked();
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    error = SnapshotCallbackManager::GetInstance().InvokeCallbacks(RT_SNAPSHOT_UNLOCK_POST);
    return error;
}

rtError_t ApiImpl::SnapShotProcessBackup()
{
    rtError_t error = SnapshotCallbackManager::GetInstance().InvokeCallbacks(RT_SNAPSHOT_BACKUP_PRE);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    error = cce::runtime::SnapShotProcessBackup();
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    error = SnapshotCallbackManager::GetInstance().InvokeCallbacks(RT_SNAPSHOT_BACKUP_POST);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    GlobalStateManager::GetInstance().SetCurrentState(RT_PROCESS_STATE_BACKED_UP);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::SnapShotProcessRestore()
{
    rtError_t error = SnapshotCallbackManager::GetInstance().InvokeCallbacks(RT_SNAPSHOT_RESTORE_PRE);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    error = cce::runtime::SnapShotProcessRestore();
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    error = SnapshotCallbackManager::GetInstance().InvokeCallbacks(RT_SNAPSHOT_RESTORE_POST);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
    GlobalStateManager::GetInstance().SetCurrentState(RT_PROCESS_STATE_LOCKED);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::SnapShotCallbackRegister(rtSnapShotStage stage, rtSnapShotCallBack callback, void* args)
{
    return SnapshotCallbackManager::GetInstance().RegisterCallback(stage, callback, args);
}

rtError_t ApiImpl::SnapShotCallbackUnregister(rtSnapShotStage stage, rtSnapShotCallBack callback)
{
    return SnapshotCallbackManager::GetInstance().UnregisterCallback(stage, callback);
}

rtError_t ApiImpl::BinaryEnumerateFunctions(
    const Program* const binHandle, Kernel** const funcHandles, const uint32_t numFunctions,
    uint32_t* const actualCount)
{
    *actualCount = 0U;
    Program* const program = const_cast<Program*>(binHandle);
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    const bool isXpu = IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_XPU);
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const Device* const dev = curCtx->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
    const uint32_t deviceId = static_cast<uint32_t>(dev->Id_());
    if (!isXpu) {
        // 其他平台需要先将program的so和name拷贝到device
        const rtError_t error = program->CopySoAndNameToCurrentDevice();
        if (error != RT_ERROR_NONE) {
            RT_LOG(
                RT_LOG_ERROR, "Failed to copy the binary module to the current device, deviceId=%u, retCode=%#x.",
                deviceId, static_cast<uint32_t>(error));
            return error;
        }
    }

    const std::map<std::string, Kernel*>& kernelNameMap = binHandle->GetKernelNameMap();
    uint32_t count = 0U;
    for (const auto& iter : kernelNameMap) {
        if (count >= numFunctions) {
            break;
        }
        if (isXpu) {
            const rtError_t error = program->XpuSetKernelLiteralNameDevAddr(iter.second, deviceId);
            if (error != RT_ERROR_NONE) {
                RT_LOG_INNER_MSG(
                    RT_LOG_ERROR, "Failed to set literal name device address for kernel=%s, deviceId=%u, retCode=%#x.",
                    iter.first.c_str(), deviceId, static_cast<uint32_t>(error));
                return error;
            }
        }
        funcHandles[count] = iter.second;
        count++;
    }

    *actualCount = count;
    RT_LOG(
        RT_LOG_DEBUG, "deviceId=%u, prog=%p, numFunctions=%u, actualCount=%u.", deviceId, binHandle, numFunctions,
        *actualCount);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::NonBlockingLaunchBegin(Stream* const stream, const uint64_t flag)
{
    UNUSED(flag);
    Stream* const targetStm = Runtime::Instance()->GetCurStream(stream);
    NULL_STREAM_PTR_RETURN_MSG(targetStm);
    return StreamLaunchBlocking::NonBlockingLaunchBegin(targetStm);
}

rtError_t ApiImpl::NonBlockingLaunchEnd(Stream* const stream, const uint64_t flag)
{
    UNUSED(flag);
    Stream* const targetStm = Runtime::Instance()->GetCurStream(stream);
    NULL_STREAM_PTR_RETURN_MSG(targetStm);
    return StreamLaunchBlocking::NonBlockingLaunchEnd(targetStm);
}

rtError_t ApiImpl::CntNotifyCreate(const int32_t deviceId, CountNotify** const cntNotify, const uint32_t flag)
{
    UNUSED(deviceId);
    UNUSED(cntNotify);
    UNUSED(flag);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::CntNotifyDestroy(CountNotify* const inCntNotify)
{
    UNUSED(inCntNotify);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::CntNotifyRecord(
    CountNotify* const inCntNotify, Stream* const stm, const rtCntNtyRecordInfo_t* const info)
{
    UNUSED(inCntNotify);
    UNUSED(stm);
    UNUSED(info);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::CntNotifyReset(CountNotify* const inCntNotify, Stream* const stm)
{
    UNUSED(inCntNotify);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::CntNotifyWaitWithTimeout(
    CountNotify* const inCntNotify, Stream* const stm, const rtCntNtyWaitInfo_t* const info)
{
    UNUSED(inCntNotify);
    UNUSED(stm);
    UNUSED(info);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::GetCntNotifyId(CountNotify* const inCntNotify, uint32_t* const notifyId)
{
    UNUSED(inCntNotify);
    UNUSED(notifyId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::GetCntNotifyAddress(
    CountNotify* const inCntNotify, uint64_t* const cntNotifyAddress, rtNotifyType_t const regType)
{
    UNUSED(inCntNotify);
    UNUSED(cntNotifyAddress);
    UNUSED(regType);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::WriteValue(rtWriteValueInfo_t* const info, Stream* const stm)
{
    UNUSED(info);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::CCULaunch(rtCcuTaskInfo_t* taskInfo, Stream* const stm)
{
    UNUSED(taskInfo);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::UbDevQueryInfo(rtUbDevQueryCmd cmd, void* devInfo)
{
    UNUSED(cmd);
    UNUSED(devInfo);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::GetDevResAddress(const rtDevResInfo* const resInfo, rtDevResAddrInfo* const addrInfo)
{
    UNUSED(resInfo);
    UNUSED(addrInfo);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::ReleaseDevResAddress(rtDevResInfo* const resInfo)
{
    UNUSED(resInfo);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::WriteValuePtr(void* const writeValueInfo, Stream* const stm, void* const pointedAddr)
{
    UNUSED(writeValueInfo);
    UNUSED(stm);
    UNUSED(pointedAddr);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::UbDbSend(rtUbDbInfo_t* const dbInfo, Stream* const stm)
{
    UNUSED(dbInfo);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::UbDirectSend(rtUbWqeInfo_t* const wqeInfo, Stream* const stm)
{
    UNUSED(wqeInfo);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::FusionLaunch(void* const fusionInfo, Stream* const stm, rtFusionArgsEx_t* argsInfo)
{
    UNUSED(fusionInfo);
    UNUSED(stm);
    UNUSED(argsInfo);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::StreamTaskAbort(Stream* const stm)
{
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::StreamRecover(Stream* const stm)
{
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::StreamTaskClean(Stream* const stm)
{
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM_WITH_FUNC_DESC(
        stm, curCtx, RT_ERROR_STREAM_CONTEXT, "Clearing tasks in a stream");
    return stm->StreamTaskClean();
}

rtError_t ApiImpl::DeviceResourceClean(int32_t devId)
{
    UNUSED(devId);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::GetBinaryDeviceBaseAddr(const Program* const prog, void** deviceBase)
{
    Context* curCtx = Runtime::Instance()->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    if (prog->GetBinAlignBaseAddr(curCtx->Device_()->Id_()) == nullptr) {
        RT_LOG(RT_LOG_ERROR, "device addr is NULL, make sure that the kernel launch process has been invoked.");
        return RT_ERROR_PROGRAM_DATA;
    } else {
        *deviceBase = const_cast<void*>(prog->GetBinAlignBaseAddr(curCtx->Device_()->Id_()));
        return RT_ERROR_NONE;
    }
}

rtError_t ApiImpl::FftsPlusTaskLaunch(
    const rtFftsPlusTaskInfo_t* const fftsPlusTaskInfo, Stream* const stm, const uint32_t flag)
{
    RT_LOG(RT_LOG_DEBUG, "FFTS plus launch.");
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Stream* const curStm = (stm == nullptr) ? curCtx->DefaultStream_() : stm;
    NULL_STREAM_PTR_RETURN_MSG(curStm);
    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM_WITH_FUNC_DESC(
        curStm, curCtx, RT_ERROR_STREAM_CONTEXT, "Function Flow Task Scheduler (FFTS) Plus task delivery");

    return curCtx->FftsPlusTaskLaunch(fftsPlusTaskInfo, curStm, flag);
}

rtError_t ApiImpl::RDMASend(const uint32_t sqIndex, const uint32_t wqeIndex, Stream* const stm)
{
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream* curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }

    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM_WITH_FUNC_DESC(
        curStm, curCtx, RT_ERROR_STREAM_CONTEXT, "Delivering an RDMA Send task");

    return curCtx->RDMASend(sqIndex, wqeIndex, curStm);
}

rtError_t ApiImpl::RdmaDbSend(const uint32_t dbIndex, const uint64_t dbInfo, Stream* const stm)
{
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream* curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }

    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM_WITH_FUNC_DESC(
        curStm, curCtx, RT_ERROR_STREAM_CONTEXT, "Delivering an RDMA Doorbell task");

    return curCtx->RdmaDbSend(dbIndex, dbInfo, curStm);
}

// dqs
rtError_t ApiImpl::LaunchDqsTask(Stream* const stm, const rtDqsTaskCfg_t* const taskCfg)
{
    UNUSED(stm);
    UNUSED(taskCfg);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ApiImpl::MemGetInfoByDeviceId(
    uint32_t deviceId, bool isHugeOnly, size_t* const freeSize, size_t* const totalSize)
{
    Runtime* const rt = Runtime::Instance();
    const auto npuDrv = rt->driverFactory_.GetDriver(NPU_DRIVER);
    return npuDrv->MemGetInfo(deviceId, isHugeOnly, freeSize, totalSize);
}

rtError_t ApiImpl::GetDeviceVirtualInfo(uint32_t deviceId, int64_t* val) const
{
    uint32_t split_mode;
    drvError_t drvError;
    COND_RETURN_WARN(
        &halGetDeviceSplitMode == nullptr, RT_ERROR_DRV_NOT_SUPPORT, "[drv api] halGetDeviceSplitMode does not exist.");
    drvError = halGetDeviceSplitMode(deviceId, &split_mode);
    if (drvError == DRV_ERROR_NONE) {
        if (split_mode == RT_VMNG_NORMAL_NONE_SPLIT_MODE) {
            *val = static_cast<int64_t>(RT_NO_SPLIT_MODE);
        } else if (split_mode == RT_VMNG_VIRTUAL_SPLIT_MODE || split_mode == RT_VMNG_CONTAINER_SPLIT_MODE) {
            *val = static_cast<int64_t>(RT_SPLIT_MODE);
        } else {
            RT_LOG(RT_LOG_INFO, "Invalid split mode, Invalid=%d.", split_mode);
        }
    } else {
        DRV_ERROR_PROCESS(
            drvError, "[drv api]halGetDeviceSplitMode failed. drvRetCode=%d, device_id=%d.",
            static_cast<int32_t>(drvError), deviceId);
    }
    return RT_GET_DRV_ERRCODE(drvError);
}

rtError_t ApiImpl::GetDeviceNpuArch(uint32_t deviceId, int64_t* val) const
{
    (void)deviceId;
    Runtime* const rt = Runtime::Instance();
    NULL_PTR_RETURN_MSG(rt, RT_ERROR_INSTANCE_NULL);
    DevProperties props;
    const rtError_t ret = GET_DEV_PROPERTIES(rt->GetChipType(), props);
    COND_RETURN_ERROR_MSG_INNER(
        ret != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE, "Get NPU arch failed, chipType=%s.",
        ChipTypeToString(rt->GetChipType()).c_str());
    COND_RETURN_ERROR_MSG_INNER(
        props.npuArch <= 0, RT_ERROR_INVALID_VALUE, "Get NPU arch failed, NPU arch is not initialized.");
    *val = props.npuArch;
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetDeviceInfoFromPlatformInfo(
    const uint32_t deviceId, const std::string& label, const std::string& key, int64_t* const value)
{
    Runtime* const rt = Runtime::Instance();
    const std::string socVersion = rt->GetSocVersion();
    uint32_t platformRet = fe::PlatformInfoManager::GeInstance().InitRuntimePlatformInfos(socVersion);
    if (platformRet != 0U) {
        RT_LOG_INNER_MSG(
            RT_LOG_ERROR, "InitRuntime PlatformInfos failed, devId=%u, socVersion=%s, platformRet=%u", deviceId,
            socVersion.c_str(), platformRet);
        return RT_ERROR_INVALID_VALUE;
    }

    fe::PlatFormInfos platformInfos;
    platformRet = fe::PlatformInfoManager::GeInstance().GetRuntimePlatformInfosByDevice(deviceId, platformInfos);
    if (platformRet != 0U) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "get runtime platformInfos by device failed, deviceId=%d", deviceId);
        return RT_ERROR_INVALID_VALUE;
    }

    std::string strVal;
    if (!platformInfos.GetPlatformResWithLock(label, key, strVal)) {
        RT_LOG_INNER_MSG(
            RT_LOG_ERROR, "get platform res failed, label=%s, key=%s socVersion=%s", label.c_str(), key.c_str(),
            socVersion.c_str());
        return RT_ERROR_INVALID_VALUE;
    }

    try {
        *value = std::stoll(strVal);
    } catch (...) {
        RT_LOG_INNER_MSG(
            RT_LOG_ERROR, "strVal[%s] cannot be converted to digital value, label=%s key=%s socVersion=%s",
            strVal.c_str(), label.c_str(), key.c_str(), socVersion.c_str());
        return RT_ERROR_INVALID_VALUE;
    }

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::EventWorkModeSet(uint8_t mode)
{
    const std::unique_lock<std::mutex> lk(GlobalContainer::eventWorkMutex);
    const uint64_t eventModeInitRefCount = GlobalContainer::GetEventModeRefCount();
    if (eventModeInitRefCount > 0U) {
        RT_LOG(RT_LOG_ERROR, "repeatedly set work mode, eventModeInitRefCount: %lu", eventModeInitRefCount);
        return RT_ERROR_INVALID_VALUE;
    }

    GlobalContainer::SetEventWorkMode(mode);
    GlobalContainer::SetEventModeRefCount(1U);
    RT_LOG(
        RT_LOG_EVENT, "current work mode set success, mode (%u), 0 means software mode, 1 means hardware mode", mode);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::EventWorkModeGet(uint8_t* mode)
{
    *mode = GlobalContainer::GetEventWorkMode();
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetNotifyAddress(Notify* const notify, uint64_t* const notifyAddress)
{
    uint64_t addr;
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream* const curStm = curCtx->DefaultStream_();
    NULL_STREAM_PTR_RETURN_MSG(curStm);
    const rtError_t error = curCtx->GetNotifyAddress(notify, addr, curStm);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "GetNotifyAddress failed, retCode=%#x", error);
        return error;
    }
    RT_LOG(RT_LOG_INFO, "GetNotifyAddress ok, addr=%#" PRIx64, addr);
    *notifyAddress = addr;
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::SetIpcNotifyPid(const char_t* const name, int32_t pid[], const int32_t num)
{
    RT_LOG(RT_LOG_DEBUG, "Set ipc notify pid. name=%s.", name);
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    if (!curCtx->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_IPC_MEMORY)) {
        RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
            ErrorCode::EE1005, "setting the trustlist of processes that can share a Notify object");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    return curCtx->Device_()->Driver_()->SetIpcNotifyPid(name, pid, num);
}

rtError_t ApiImpl::NotifyReset(Notify* const notify)
{
    RT_LOG(RT_LOG_INFO, "notify reset.");
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Stream* curStm = curCtx->DefaultStream_();
    NULL_STREAM_PTR_RETURN_MSG(curStm);

    COND_RETURN_ERROR(
        curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "Notify reset failed, stream is not in current ctx, stream_id=%d.", curStm->Id_());

    Device* const dev = curCtx->Device_();
    if (!dev->IsStarsPlatform()) {
        RT_LOG(RT_LOG_ERROR, "feature support only in stars platform");
        RT_LOG_OUTER_MSG_WITH_FUNC_DESC(ErrorCode::EE1005, "notify resetting");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    if (!dev->CheckFeatureSupport(TS_FEATURE_MC2_ENHANCE)) {
        RT_LOG(RT_LOG_ERROR, "This feature is not supported because the tsch version is too low.");
        RT_LOG_OUTER_MSG_WITH_FUNC_DESC(ErrorCode::EE1015, "notify resetting", "");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    const uint32_t notifyId = notify->GetNotifyId();
    const rtError_t error = notify->Reset(curStm);
    ERROR_RETURN_MSG_INNER(
        error, "Notify reset failed, notifyId=%u, retCode=%#x", notifyId, static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetNotifyPhyInfo(Notify* const notify, rtNotifyPhyInfo* notifyInfo)
{
    RT_LOG(RT_LOG_INFO, "get phy info.");
    if (notify == nullptr) {
        RT_LOG(RT_LOG_INFO, "inNotify is nullptr.");
        RT_LOG(RT_LOG_ERROR, "Get phy info failed.");
        return RT_ERROR_NOTIFY_NULL;
    }
    notifyInfo->phyId = notify->GetPhyDevId();
    notifyInfo->tsId = notify->GetTsId();
    notifyInfo->shrId = notify->GetNotifyId();
    notifyInfo->idType = SHR_ID_NOTIFY_TYPE;
    notifyInfo->flag = (notify->IsPod() ? TSDRV_FLAG_SHR_ID_SHADOW : 0U);
    RT_LOG(RT_LOG_INFO, "notify_id=%u, phyId=%u flag=0x%x.", notifyInfo->shrId, notifyInfo->phyId, notifyInfo->flag);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::IpcSetNotifyName(Notify* const notify, char_t* const name, const uint32_t len, const uint64_t flag)
{
    RT_LOG(RT_LOG_INFO, "IpcSetNotifyName, name=%s, len=%u, flag=%#" PRIx64 ".", name, len, flag);
    const uint32_t notifyId = notify->GetNotifyId();
    rtError_t error = notify->CreateIpcNotify(name, len);
    ERROR_RETURN_MSG_INNER(
        error, "CreateIpcNotify failed, notify_id=%u, name=%s, len=%u retCode=%#x", notifyId, name, len,
        static_cast<uint32_t>(error));

    if ((flag & RT_NOTIFY_EXPORT_FLAG_DISABLE_PID_VALIDATION) != 0UL) {
        error = NpuDriver::SetIpcNotifyDisablePidVerify(name);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::IpcOpenNotify(Notify** const notify, const char_t* const name, uint32_t flag)
{
    RT_LOG(RT_LOG_INFO, "open ipc notify. name=%s, flag=%#x.", name, flag);
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device* const dev = curCtx->Device_();
    COND_RETURN_ERROR(dev == nullptr, RT_ERROR_INVALID_VALUE, "device is NULL.");

    if ((flag & RT_NOTIFY_FLAG_DOWNLOAD_TO_DEV) != 0) {
        const bool isMc2SupportHccl = CheckSupportMC2Feature(dev);
        if (!isMc2SupportHccl) {
            RT_LOG(
                RT_LOG_WARNING, "Current ts version[%u] does not support opening IPC coprocessor notifies.",
                dev->GetTschVersion());
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
    }

    *notify = new (std::nothrow) Notify(dev->Id_(), dev->DevGetTsId());
    COND_RETURN_AND_MSG_OUTER((*notify == nullptr), RT_ERROR_NOTIFY_NEW, ErrorCode::EE1013, sizeof(Notify), "new");

    const rtError_t error = (*notify)->OpenIpcNotify(name, flag);
    ERROR_PROC_RETURN_MSG_INNER(error, DELETE_O(*notify);
                                , "Ipc open notify failed, retCode=%#x", static_cast<uint32_t>(error));
    return error;
}

rtError_t ApiImpl::NotifyGetAddrOffset(Notify* const notify, uint64_t* const devAddrOffset)
{
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    const uint32_t notifyId = notify->GetNotifyId();
    const rtError_t error = notify->GetAddrOffset(devAddrOffset);
    ERROR_RETURN_MSG_INNER(
        error, "Notify get addr offset failed, notify_id=%u, retCode=%#x", notifyId, static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::ShrIdSetPodPid(const char* name, uint32_t sdid, int32_t pid)
{
    RT_LOG(RT_LOG_INFO, "Start to ShrIdSetPodPid name=%s, sdid=%d, pid=%d", name, sdid, pid);
    return NpuDriver::ShrIdSetPodPid(name, sdid, pid);
}

rtError_t ApiImpl::MemsetD32(void* const dst, const uint64_t destMax, const uint32_t value, const uint64_t count)
{
    RT_LOG(RT_LOG_DEBUG, "MemsetD32 sync, count=%zu, value=0x%x", count, value);
    // 1. Basic parameter validation
    // 2. Get current context and device
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Device* device = curCtx->Device_();
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        device, RT_ERROR_INVALID_VALUE,
        "Setting the memory content to a specified 32-bit unsigned integer value synchronously");

    const rtError_t deviceStatus = device->GetDeviceStatus();
    COND_PROC((deviceStatus == RT_ERROR_DEVICE_TASK_ABORT), return deviceStatus);

    // 3. Get memory location attributes
    rtPtrAttributes_t attr;
    rtError_t error = device->Driver_()->PtrGetAttributes(dst, &attr);
    ERROR_RETURN_MSG_INNER(error, "Get pointer attribute failed, retCode=%#x.", error);

    // 4. Select execution path based on memory location
    if (attr.location.type == RT_MEMORY_LOC_HOST || attr.location.type == RT_MEMORY_LOC_HOST_NUMA) {
        return MemsetD32OnHost(dst, destMax, value, count);
    } else {
        return MemsetD32OnDevice(dst, destMax, value, count, nullptr, false, attr.location.id);
    }
}

rtError_t ApiImpl::MemsetD32Async(
    void* const dst, const uint64_t destMax, const uint32_t value, const uint64_t count, Stream* const stm)
{
    RT_LOG(RT_LOG_DEBUG, "MemsetD32 async, count=%zu, value=0x%x", count, value);
    // 1. Basic parameter validation
    // 2. Get current context and device
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    // 3. Get stream (use default stream if null)
    Stream* curStm = stm;

    // 4. Get memory location attributes
    Device* device = curCtx->Device_();
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        device, RT_ERROR_INVALID_VALUE,
        "Setting the memory content to a specified 32-bit unsigned integer value asynchronously");

    rtPtrAttributes_t attr;
    rtError_t error = device->Driver_()->PtrGetAttributes(dst, &attr);
    ERROR_RETURN_MSG_INNER(error, "Get pointer attribute failed, retCode=%#x.", error);

    // 5. Select execution path based on memory location
    if (attr.location.type == RT_MEMORY_LOC_HOST || attr.location.type == RT_MEMORY_LOC_HOST_NUMA) {
        return MemsetD32OnHost(dst, destMax, value, count);
    } else {
        if (curStm == nullptr) {
            curStm = curCtx->DefaultStream_();
            NULL_STREAM_PTR_RETURN_MSG(curStm);
        }
        COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM_WITH_FUNC_DESC(
            curStm, curCtx, RT_ERROR_STREAM_CONTEXT,
            "Setting the memory content to a specified 32-bit unsigned integer value asynchronously");
        return MemsetD32OnDevice(dst, destMax, value, count, curStm, true, attr.location.id);
    }
}

rtError_t ApiImpl::SetGroup(const int32_t groupId)
{
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_DEVICE_GROUP)) {
        RT_LOG(RT_LOG_ERROR, "Device groups are not supported on chipType=%s", ChipTypeToString(chipType).c_str());
        RT_LOG_OUTER_MSG_WITH_FUNC_DESC(ErrorCode::EE1005, "specifying the group used for the current operation");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device* const dev = curCtx->Device_();
    return dev->SetGroup(groupId);
}

rtError_t ApiImpl::GetGroupCount(uint32_t* const cnt)
{
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_DEVICE_GROUP)) {
        RT_LOG(RT_LOG_ERROR, "Device groups are not supported on chipType=%s", ChipTypeToString(chipType).c_str());
        RT_LOG_OUTER_MSG_WITH_FUNC_DESC(ErrorCode::EE1005, "obtaining the number of available computing power groups");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device* const dev = curCtx->Device_();
    return dev->GetGroupCount(cnt);
}

rtError_t ApiImpl::GetGroupInfo(const int32_t groupId, rtGroupInfo_t* const groupInfo, const uint32_t cnt)
{
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_DEVICE_GROUP)) {
        RT_LOG(RT_LOG_ERROR, "Device groups are not supported on chipType=%s", ChipTypeToString(chipType).c_str());
        RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
            ErrorCode::EE1005, "querying the computing power information of a specified group");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device* const dev = curCtx->Device_();
    return dev->GetGroupInfo(groupId, groupInfo, cnt);
}

bool ApiImpl::IsDevSupportGetDevMsg(const Device* const dev) { return dev->GetTschVersion() >= TS_VERSION_GET_DEV_MSG; }

rtError_t ApiImpl::SyncGetDevMsg(
    Device* const dev, const void* const devMemAddr, const uint32_t devMemSize,
    const rtGetDevMsgType_t getDevMsgType) const
{
    // new a stream for get exception info
    std::unique_ptr<Stream, void (*)(Stream*)> stm(
        StreamFactory::CreateStream(dev, 0U), [](Stream* ptr) { ptr->Destructor(); });
    COND_RETURN_AND_MSG_OUTER((stm == nullptr), RT_ERROR_STREAM_NEW, ErrorCode::EE1013, sizeof(Stream), "new");
    rtError_t error = stm->Setup();
    ERROR_RETURN_MSG_INNER(error, "stream setup failed, retCode=%#x.", static_cast<uint32_t>(error));
    const std::function<void()> streamTearDownFunc = [&stm]() {
        const auto ret = (stm->TearDown());
        // Disable thread stream destroy task will delete stream
        // other condition, we should delete stream here
        Runtime* const rtIntsance = Runtime::Instance();
        // Disable thread free in stream destroy task recycle, stream destroy task send in TearDown process.
        if ((ret == RT_ERROR_NONE) && (!rtIntsance->GetDisableThread())) {
            (void)stm.release();
        }
    };
    const ScopeGuard devErrMsgStreamRelease(streamTearDownFunc);
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo* tsk = stm.get()->AllocTask(&submitTask, TS_TASK_TYPE_GET_DEVICE_MSG, errorReason);
    NULL_PTR_RETURN_MSG(tsk, errorReason);

    // init RT_GET_DEV_ERROR_MSG task
    error = GetDevMsgTaskInit(tsk, devMemAddr, devMemSize, getDevMsgType);
    ERROR_PROC_RETURN_MSG_INNER(error, ((void)dev->GetTaskFactory()->Recycle(tsk));
                                , "Failed to init task, stream_id=%d, task_id=%hu, retCode=%#x.", stm->Id_(), tsk->id,
                                static_cast<uint32_t>(error));
    // submit task
    error = dev->SubmitTask(tsk);
    ERROR_PROC_RETURN_MSG_INNER(error, ((void)dev->GetTaskFactory()->Recycle(tsk));
                                , "Failed to submit task, retCode=%#x, device id=%u", static_cast<uint32_t>(error),
                                dev->Id_());
    // stream synchronize
    error = stm->Synchronize();
    ERROR_RETURN_MSG_INNER(error, "Failed to synchronize stream, retCode=%#x.", static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetDevErrMsg(const rtGetMsgCallback callback)
{
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device* const dev = curCtx->Device_();
    rtError_t error = dev->GetDeviceStatus();
    ERROR_RETURN(error, "device_id=%u, status=%#x is abnormal.", dev->Id_(), static_cast<uint32_t>(error));
    // stars do nothing in device, so do not need to send task.
    COND_PROC((dev->IsStarsPlatform()), callback("", 0U); RT_LOG(RT_LOG_DEBUG, "Do not need to send task.");
              return RT_ERROR_NONE);
    const bool isSupport = IsDevSupportGetDevMsg(dev);
    COND_RETURN_ERROR_MSG_INNER(
        !isSupport, RT_ERROR_FEATURE_NOT_SUPPORT, "Device does not support get device msg, deviceId=%u.", dev->Id_());

    DeviceErrMsgHandler getDevErrHandler(dev, callback);
    error = getDevErrHandler.Init();
    ERROR_RETURN_MSG_INNER(error, "Init device error msg handler failed, retCode=%#x.", static_cast<uint32_t>(error));

    error =
        SyncGetDevMsg(dev, getDevErrHandler.GetDevMemAddr(), getDevErrHandler.GetDevMemSize(), RT_GET_DEV_ERROR_MSG);
    ERROR_RETURN_MSG_INNER(error, "Sync get device msg failed, retCode=%#x.", static_cast<uint32_t>(error));

    error = getDevErrHandler.HandleMsg();
    ERROR_RETURN_MSG_INNER(error, "Failed to handle get device error msg, retCode=%#x.", static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetDevRunningStreamSnapshotMsg(const rtGetMsgCallback callback)
{
    const std::function<rtError_t(Device* const dev)> getDevHangMsgForDev = [callback,
                                                                             this](Device* const dev) -> rtError_t {
        const bool isSupport = IsDevSupportGetDevMsg(dev);
        COND_RETURN_ERROR_MSG_INNER(
            !isSupport, RT_ERROR_FEATURE_NOT_SUPPORT, "Device does not support get device msg, deviceId=%u.",
            dev->Id_());

        DeviceStreamSnapshotHandler devStreamSnapshotHandler(dev, callback);
        rtError_t error = devStreamSnapshotHandler.Init();
        ERROR_RETURN(
            error, "Init device stream snapshot msg handler failed, retCode=%#x.", static_cast<uint32_t>(error));

        error = SyncGetDevMsg(
            dev, devStreamSnapshotHandler.GetDevMemAddr(), devStreamSnapshotHandler.GetDevMemSize(),
            RT_GET_DEV_RUNNING_STREAM_SNAPSHOT_MSG);
        ERROR_RETURN(error, "Sync get device msg failed, retCode=%#x.", static_cast<uint32_t>(error));

        error = devStreamSnapshotHandler.HandleMsg();
        ERROR_RETURN_MSG_INNER(
            error, "Failed to handle get stream snapshot msg, retCode=%#x.", static_cast<uint32_t>(error));
        return RT_ERROR_NONE;
    };
    return Runtime::Instance()->ProcessForAllOpenDevice(getDevHangMsgForDev, false);
}

rtError_t ApiImpl::ProcError(rtError_t error)
{
    // all thread return HBM_MULTI_BIT_ECC_ERROR
    if (error == RT_ERROR_MEM_RAS_ERROR) {
        Context* const curCtx = CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        Device* const dev = curCtx->Device_();
        const uint32_t hbmRasDevId = Runtime::Instance()->GetRasInfoDevId();
        if (dev != nullptr && dev->Id_() == hbmRasDevId) {
            // report ACL_ERROR_RT_HBM_MULTI_BIT_ECC_ERROR
            RT_LOG_CALL_MSG(
                ERR_MODULE_DRV,
                "HBM MULTI BIT ECC, Uncorrectable ECC, device_id=%u, event_id=0x%x, time us=%" PRIu64 ".", hbmRasDevId,
                HBM_ECC_EVENT_ID, Runtime::Instance()->GetRasInfoSysCnt());
        }
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetDevMsg(const rtGetDevMsgType_t getMsgType, rtGetMsgCallback const callback)
{
    RT_LOG(RT_LOG_DEBUG, "GetDeviceMsg, getMsgType=%d", static_cast<int32_t>(getMsgType));
    const auto chipType = Runtime::Instance()->GetChipType();
    COND_RETURN_ERROR_MSG_INNER(
        !IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_DFX_TS_GET_DEVICE_MSG),
        RT_ERROR_FEATURE_NOT_SUPPORT, "chipType=%s does not support get device msg feature.",
        ChipTypeToString(chipType).c_str());
    rtRunMode runMode = RT_RUN_MODE_OFFLINE;
    (void)GetRunMode(&runMode);
    if (runMode == RT_RUN_MODE_OFFLINE) {
        RT_LOG(RT_LOG_INFO, "runMode is RT_RUN_MODE_OFFLINE.");
    }

    if (getMsgType == RT_GET_DEV_ERROR_MSG) {
        const rtError_t error = GetDevErrMsg(callback);
        (void)ProcError(error);
        ERROR_RETURN(error, "Failed to GetDeviceErrMsg, retCode=%#x.", static_cast<uint32_t>(error));
    } else if (getMsgType == RT_GET_DEV_RUNNING_STREAM_SNAPSHOT_MSG) {
        const rtError_t error = GetDevRunningStreamSnapshotMsg(callback);
        ERROR_RETURN(error, "Failed to GetDevRunningStreamSnapshotMsg, retCode=%#x.", static_cast<uint32_t>(error));
    } else {
        // The value range of this parameter in this function is [0 - 2). Parameter 2 is used in the snapshot process.
        RT_LOG_CALL_MSG(
            ERR_MODULE_GE, "Unsupported get msg type=UNKNOWN(%d), range is [%d, %d)", getMsgType, RT_GET_DEV_ERROR_MSG,
            RT_GET_DEV_PID_SNAPSHOT_MSG);
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::IpcSetMemoryName(
    const void* const ptr, const uint64_t byteCount, char_t* const name, const uint32_t len, const uint64_t flags)
{
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    const Runtime* const rtInstance = Runtime::Instance();
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

rtError_t ApiImpl::IpcOpenMemory(void** const ptr, const char_t* const name, const uint64_t flags)
{
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    if (!curCtx->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_IPC_MEMORY)) {
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    std::string ipcName(name);
    RT_LOG(RT_LOG_INFO, "Open ipc memory, name=%s, flags=%#" PRIx64 ".", ipcName.c_str(), flags);
    rtError_t error = RT_ERROR_NONE;
    Device* const dev = curCtx->Device_();
    if ((flags & RT_IPC_MEM_IMPORT_FLAG_ENABLE_PEER_ACCESS) != 0UL) {
        uint32_t peerPhyDeviceId = 0U;
        error = NpuDriver::GetPhyDevIdByIpcMemName(name, &peerPhyDeviceId);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
        error = dev->EnableP2PWithOtherDevice(peerPhyDeviceId);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    }

    uint64_t latestAttr = 0UL; // if not set, use 0 to drv, otherwise update with cfg
    {
        const std::unique_lock<std::mutex> lock(Runtime::Instance()->GetIpcMemNameLock());
        std::unordered_map<std::string, ipcMemInfo_t>& ipcMemNameMap = Runtime::Instance()->GetIpcMemNameMap();
        auto it = ipcMemNameMap.find(ipcName);
        if (it != ipcMemNameMap.end()) {
            latestAttr = it->second.latestAttr;
        }
    }

    error = dev->Driver_()->OpenIpcMem(name, RtPtrToPtr<uint64_t*>(ptr), curCtx->Device_()->Id_(), latestAttr);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "open ipc memory failed, name=%s, attr=%#" PRIx64 ".", ipcName.c_str(), latestAttr);
        return error;
    }

    {
        const std::unique_lock<std::mutex> lock(Runtime::Instance()->GetIpcMemNameLock());
        std::unordered_map<std::string, ipcMemInfo_t>& ipcMemNameMap = Runtime::Instance()->GetIpcMemNameMap();
        auto it = ipcMemNameMap.find(ipcName);
        if (it == ipcMemNameMap.end()) {
            ipcMemInfo_t& info = ipcMemNameMap[ipcName];
            info.latestAttr = latestAttr;
            info.vaList.push_back(RtPtrToValue(*ptr));
        } else {
            it->second.vaList.push_back(RtPtrToValue(*ptr));
        }
    }

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::IpcCloseMemory(const void* const ptr)
{
    RT_LOG(RT_LOG_DEBUG, "Start close ipc memory.");
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    if (!curCtx->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_IPC_MEMORY)) {
        RT_LOG_OUTER_MSG_WITH_FUNC_DESC(ErrorCode::EE1005, "closing the IPC shared memory");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    const uint64_t vaData = RtPtrToValue(ptr);
    const rtError_t error = curCtx->Device_()->Driver_()->CloseIpcMem(vaData);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "close ipc memory failed, vptr=%#" PRIx64 ".", vaData);
        return error;
    }

    const std::unique_lock<std::mutex> lock(Runtime::Instance()->GetIpcMemNameLock());
    std::unordered_map<std::string, ipcMemInfo_t>& ipcMemNameMap = Runtime::Instance()->GetIpcMemNameMap();
    for (auto mapIter = ipcMemNameMap.begin(); mapIter != ipcMemNameMap.end(); ++mapIter) {
        ipcMemInfo_t& info = mapIter->second;
        auto vaIter = std::find(info.vaList.begin(), info.vaList.end(), vaData);
        if (vaIter != info.vaList.end()) {
            (void)info.vaList.erase(vaIter);
            if (info.vaList.empty()) {
                (void)ipcMemNameMap.erase(mapIter);
            }
            RT_LOG(RT_LOG_DEBUG, "close ipc mem success, vptr=%#" PRIx64 ".", vaData);
            return error;
        }
    }
    RT_LOG(RT_LOG_WARNING, "ipc memory vptr=%#" PRIx64 " not found in map, may be closed already.", vaData);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::IpcCloseMemoryByName(const char_t* const name)
{
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    if (!curCtx->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_IPC_MEMORY)) {
        RT_LOG_OUTER_MSG_WITH_FUNC_DESC(ErrorCode::EE1005, "closing the IPC shared memory");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }

    const std::string ipcName(name);
    RT_LOG(RT_LOG_DEBUG, "start close ipc memory, name=%s.", ipcName.c_str());
    uint64_t va;
    bool nameNotFound = false;
    {
        const std::unique_lock<std::mutex> lock(Runtime::Instance()->GetIpcMemNameLock());
        std::unordered_map<std::string, ipcMemInfo_t>& ipcMemNameMap = Runtime::Instance()->GetIpcMemNameMap();
        auto it = ipcMemNameMap.find(ipcName);
        if (it == ipcMemNameMap.end()) {
            nameNotFound = true;
        } else {
            // the case just set attr but not open, so vaList is empty, just return RT_ERROR_NONE
            if (it->second.vaList.empty()) {
                RT_LOG(RT_LOG_WARNING, "not import mem, should not close ipc memory by name=%s.", ipcName.c_str());
                (void)ipcMemNameMap.erase(it);
                return RT_ERROR_NONE;
            }
            va = it->second.vaList.front();
        }
    }

    if (nameNotFound) {
        RT_LOG(RT_LOG_DEBUG, "destroy ipc memory by IpcDestroyMemoryName, name=%s.", name);
        return curCtx->Device_()->Driver_()->DestroyIpcMem(name);
    }

    const rtError_t error = curCtx->Device_()->Driver_()->CloseIpcMem(va);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "close ipc mem failed, name=%s, va=%#" PRIx64 ".", ipcName.c_str(), va);
        return error;
    }

    {
        const std::unique_lock<std::mutex> lock(Runtime::Instance()->GetIpcMemNameLock());
        std::unordered_map<std::string, ipcMemInfo_t>& ipcMemNameMap = Runtime::Instance()->GetIpcMemNameMap();
        auto it = ipcMemNameMap.find(ipcName);
        if (it != ipcMemNameMap.end()) {
            auto vaIter = std::find(it->second.vaList.begin(), it->second.vaList.end(), va);
            if (vaIter != it->second.vaList.end()) {
                (void)it->second.vaList.erase(vaIter);
            }

            if (it->second.vaList.empty()) {
                (void)ipcMemNameMap.erase(it);
            }
        }
    }

    RT_LOG(RT_LOG_DEBUG, "close ipc memory by CloseIpcMem, name=%s.", ipcName.c_str());
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::LaunchSqeUpdateTask(
    uint32_t streamId, uint32_t taskId, void* src, uint64_t cnt, Stream* const stm, bool needCpuTask)
{
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Stream* curStm = const_cast<Stream*>(stm);
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }

    COND_RETURN_AND_MSG_OUTER(
        curStm->GetBindFlag() == true, RT_ERROR_INVALID_VALUE, ErrorCode::EE1017, "Updating task information", "stream",
        RtFmtMsg("Stream (stream_id=%d) should be a single-operator flow stream", curStm->Id_()));

    COND_RETURN_AND_MSG_OUTER(
        curStm->IsCapturing() == true, RT_ERROR_STREAM_CAPTURED, ErrorCode::EE1016, "Updating task information",
        RtFmtMsg("Stream (stream_id=%d) during the capture stage is not supported", curStm->Id_()));

    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM_WITH_FUNC_DESC(
        curStm, curCtx, RT_ERROR_STREAM_CONTEXT, "Delivering the Submission Queue Entry (SQE) update task");

    Device* const dev = curCtx->Device_();
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        dev, RT_ERROR_INVALID_VALUE, "Delivering the Submission Queue Entry (SQE) update task");

    StreamSqCqManage* const streamSqCqManagePtr = dev->GetStreamSqCqManage();
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        streamSqCqManagePtr, RT_ERROR_INVALID_VALUE, "Delivering the Submission Queue Entry (SQE) update task");

    TaskFactory* const devTaskFactory = dev->GetTaskFactory();
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(
        devTaskFactory, RT_ERROR_INVALID_VALUE, "Delivering the Submission Queue Entry (SQE) update task");

    Stream* modelStream = nullptr;
    rtError_t error = streamSqCqManagePtr->GetStreamById(streamId, &modelStream);
    COND_RETURN_ERROR_MSG_INNER(
        ((error != RT_ERROR_NONE) || (modelStream == nullptr)), error,
        "Query stream failed, dev_id=%d, stream_id=%u, retCode=%#x.", dev->Id_(), streamId,
        static_cast<uint32_t>(error));

    if ((modelStream->GetBindFlag() == false) || (!modelStream->IsModelStream())) {
        RT_LOG_CALL_MSG(ERR_MODULE_GE, "Invalid dev_id=%d, stream_id=%u, stream is not in model", dev->Id_(), streamId);
        return RT_ERROR_INVALID_VALUE;
    }

    TaskInfo* task = devTaskFactory->GetTask(static_cast<int32_t>(streamId), taskId);

    COND_RETURN_AND_MSG_OUTER(
        task == nullptr, RT_ERROR_INVALID_VALUE, ErrorCode::EE1017, "Updating task information",
        "stream ID and task ID",
        "The corresponding task cannot be found through the device ID " + std::to_string(dev->Id_()) + ", stream ID " +
            std::to_string(streamId) + ", task ID " + std::to_string(taskId));
    COND_RETURN_AND_MSG_OUTER(
        (task->type != TS_TASK_TYPE_STARS_COMMON ||
         task->u.starsCommTask.commonStarsSqe.commonSqe.sqeHeader.type != RT_STARS_SQE_TYPE_DSA),
        RT_ERROR_INVALID_VALUE, ErrorCode::EE1017, "Updating task information", "stream ID and task ID",
        "Only the random number generation task supports this update operation");

    const uint32_t sqId = modelStream->GetSqId();
    const uint32_t pos = task->pos;

    if (needCpuTask == false) {
        if (task->u.starsCommTask.srcDevAddr == nullptr) {
            task->u.starsCommTask.srcDevAddr = src;
        } else {
            const uint64_t dsaSrcDevAddr = RtPtrToValue(task->u.starsCommTask.srcDevAddr);
            const uint64_t currentSrcDevAddr = RtPtrToValue(src);
            COND_RETURN_AND_MSG_OUTER(
                dsaSrcDevAddr != currentSrcDevAddr, RT_ERROR_INVALID_VALUE, ErrorCode::EE1017,
                "Updating task information", "info",
                "The device memory address " + std::to_string(dsaSrcDevAddr) +
                    " for storing the data to be updated in the configuration is inconsistent with the currently "
                    "specified device memory address " +
                    std::to_string(currentSrcDevAddr) +
                    ". Ensure that the same device memory address is used for multiple task updates.");
        }
        return curCtx->LaunchSqeUpdateTask(src, cnt, sqId, pos, curStm);
    } else {
        COND_RETURN_ERROR_MSG_INNER(
            task->u.starsCommTask.randomDevAddr == nullptr, RT_ERROR_INVALID_VALUE, "randomDevAddr is null.");
        // randomDevAddr + RANDOM_INPUT_PARAM_SIZE bytes used as dsa update aicpu op's output sqe addr
        constexpr uint32_t randomIuputParamSize = 16U;
        void* outputSqeAddr = RtPtrToPtr<void*, uint8_t*>(
            static_cast<uint8_t*>(task->u.starsCommTask.randomDevAddr) + randomIuputParamSize);

        // built aicpu task param
        const std::string soName = "libaicpu_extend_kernels.so";
        const std::string kernelName = "RuntimeAicpuKernel";
        constexpr uint32_t argsSize = 96U;
        uint8_t args[argsSize];

        uint64_t offset = 0U;

        // append RtAicpuKernelArgs, refer to RtAicpuKernelArgs.
        constexpr uint32_t kernelType = 0U;
        errno_t ret = memcpy_s(args + offset, sizeof(kernelType), &kernelType, sizeof(kernelType));
        COND_RETURN_ERROR_MSG_INNER(
            ret != EOK, RT_ERROR_SEC_HANDLE,
            "Failed to call Memcpy_s function to copy kernelType, destAddr=%p, srcAddr=%p, maxLen=%zu, actualLen=%zu, "
            "retCode=%#x",
            args + offset, &kernelType, sizeof(kernelType), sizeof(kernelType), static_cast<uint32_t>(ret));

        offset += sizeof(kernelType);
        constexpr uint32_t paramLength = 24U; // DsaUpdateParam size
        ret = memcpy_s(args + offset, sizeof(paramLength), &paramLength, sizeof(paramLength));
        COND_RETURN_ERROR_MSG_INNER(
            ret != EOK, RT_ERROR_SEC_HANDLE,
            "Failed to call Memcpy_s function to copy paramLength, destAddr=%p, srcAddr=%p, maxLen=%zu, actualLen=%zu, "
            "retCode=%#x",
            args + offset, &paramLength, sizeof(paramLength), sizeof(paramLength), static_cast<uint32_t>(ret));
        offset += sizeof(paramLength);
        // append DsaUpdateParam, refer to DsaUpdateParam struct
        ret = memcpy_s(args + offset, sizeof(src), &src, sizeof(src));
        COND_RETURN_ERROR_MSG_INNER(
            ret != EOK, RT_ERROR_SEC_HANDLE,
            "Failed to call Memcpy_s function to copy src, destAddr=%p, srcAddr=%p, maxLen=%zu, actualLen=%zu, "
            "retCode=%#x",
            args + offset, &src, sizeof(src), sizeof(src), static_cast<uint32_t>(ret));
        offset += sizeof(src);
        ret = memcpy_s(args + offset, sizeof(outputSqeAddr), &outputSqeAddr, sizeof(outputSqeAddr));
        COND_RETURN_ERROR_MSG_INNER(
            ret != EOK, RT_ERROR_SEC_HANDLE,
            "Failed to call Memcpy_s function to copy outputSqeAddr, destAddr=%p, srcAddr=%p, maxLen=%zu, "
            "actualLen=%zu, retCode=%#x",
            args + offset, &outputSqeAddr, sizeof(outputSqeAddr), sizeof(outputSqeAddr), static_cast<uint32_t>(ret));
        offset += sizeof(outputSqeAddr);
        void* dsaCfgParam = task->u.starsCommTask.randomDevAddr;
        ret = memcpy_s(args + offset, sizeof(dsaCfgParam), &dsaCfgParam, sizeof(dsaCfgParam));
        COND_RETURN_ERROR_MSG_INNER(
            ret != EOK, RT_ERROR_SEC_HANDLE,
            "Failed to call Memcpy_s function to copy dsaCfgParam, destAddr=%p, srcAddr=%p, maxLen=%zu, actualLen=%zu, "
            "retCode=%#x",
            args + offset, &dsaCfgParam, sizeof(dsaCfgParam), sizeof(dsaCfgParam), static_cast<uint32_t>(ret));

        offset += sizeof(dsaCfgParam);
        // append soName
        const uint32_t soNameAddrOffset = static_cast<uint32_t>(offset);
        const size_t soNameLen = soName.length() + 1U;
        ret = memcpy_s(args + offset, soNameLen, soName.c_str(), soNameLen);
        COND_RETURN_ERROR_MSG_INNER(
            ret != EOK, RT_ERROR_SEC_HANDLE,
            "Failed to call Memcpy_s function to copy soName, destAddr=%p, srcAddr=%p, maxLen=%zu, actualLen=%zu, "
            "retCode=%#x",
            args + offset, soName.c_str(), soNameLen, soNameLen, static_cast<uint32_t>(ret));
        offset += soNameLen;

        // append kernelName
        const uint32_t kernelNameAddrOffset = static_cast<uint32_t>(offset);
        const size_t kernelNameLen = kernelName.length() + 1U;
        ret = memcpy_s(args + offset, kernelNameLen, kernelName.c_str(), kernelNameLen);
        COND_RETURN_ERROR_MSG_INNER(
            ret != EOK, RT_ERROR_SEC_HANDLE,
            "Failed to call Memcpy_s function to copy kernelName, destAddr=%p, srcAddr=%p, maxLen=%zu, actualLen=%zu, "
            "retCode=%#x",
            args + offset, kernelName.c_str(), kernelNameLen, kernelNameLen, static_cast<uint32_t>(ret));

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

        error = StreamLaunchCpuKernelExWithArgs(
            1U, &argsInfo, nullptr, curStm, RT_KERNEL_DEFAULT, KERNEL_TYPE_AICPU_KFC, nullptr);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "update dsa failed, due to launch cpu task failed.");
        RT_LOG(RT_LOG_INFO, "launch dsa update cpu task success.");
        // LaunchSqeUpdateTask only update sqe from offset=DSA_SQE_UPDATE_OFFSET, so need add offset.
        constexpr uint32_t dsaSqeUpdateOffset = 16U;
        constexpr uint32_t dsaSqeUpdateSize = 40U; // SqeUpdateTask only can copy 40 bytes;
        void* copySqeAddr = RtPtrToPtr<void*, uint8_t*>(static_cast<uint8_t*>(outputSqeAddr) + dsaSqeUpdateOffset);
        return curCtx->LaunchSqeUpdateTask(copySqeAddr, dsaSqeUpdateSize, sqId, pos, curStm);
    }
}

rtError_t ApiImpl::ReduceAsync(
    void* const dst, const void* const src, const uint64_t cnt, const rtRecudeKind_t kind, const rtDataType_t type,
    Stream* const stm, const rtTaskCfgInfo_t* const cfgInfo)
{
    RT_LOG(RT_LOG_INFO, "ReduceAsync, count=%" PRIu64 ", kind=%s.", cnt, ReduceKindToString(kind).c_str());
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream* curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM_WITH_FUNC_DESC(
        curStm, curCtx, RT_ERROR_STREAM_CONTEXT, "Asynchronously performing the Reduce operation");

    return cce::runtime::ReduceAsync(dst, src, cnt, kind, type, curStm, cfgInfo);
}

rtError_t ApiImpl::ReduceAsyncV2(
    void* const dst, const void* const src, const uint64_t cnt, const rtRecudeKind_t kind, const rtDataType_t type,
    Stream* const stm, void* const overflowAddr)
{
    RT_LOG(RT_LOG_INFO, "ReduceAsyncV2, count=%" PRIu64 ", kind=%s.", cnt, ReduceKindToString(kind).c_str());
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream* curStm = const_cast<Stream*>(stm);
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_STREAM_PTR_RETURN_MSG(curStm);
    }
    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM_WITH_FUNC_DESC(
        curStm, curCtx, RT_ERROR_STREAM_CONTEXT, "Performing asynchronous Reduce operations");

    Device* const dev = curCtx->Device_();
    const uint32_t tsVersion = dev->GetTschVersion() & 0xFFFFU; // low 16bit means tschversion
    const auto reduceOverflowProp = dev->GetDevProperties().reduceOverflow;
    if ((reduceOverflowProp == ReduceOverflowType::REDUCE_OVERFLOW_TS_VERSION_REDUCE_V2_ID) &&
        (tsVersion >= static_cast<uint32_t>(TS_VERSION_REDUCE_V2_ID))) {
        return cce::runtime::ReduceAsyncV2(dst, src, cnt, kind, type, curStm, overflowAddr);
    } else if (
        (reduceOverflowProp == ReduceOverflowType::REDUCE_OVERFLOW_TS_VERSION_REDUCV2_SUPPORT_DC) &&
        (tsVersion >= static_cast<uint32_t>(TS_VERSION_REDUCV2_SUPPORT_DC))) {
        return cce::runtime::ReduceAsyncV2(dst, src, cnt, kind, type, curStm, overflowAddr);
    } else {
        return cce::runtime::ReduceAsync(dst, src, cnt, kind, type, curStm, nullptr);
    }
}

rtError_t ApiImpl::ModelTaskUpdate(Stream* desStm, uint32_t desTaskId, Stream* sinkStm, rtMdlTaskUpdateInfo_t* para)
{
    RT_LOG(RT_LOG_INFO, "ModelTaskUpdate, desStm=%d.desTaskId=%u,sinkStm=%d", desStm->Id_(), desTaskId, sinkStm->Id_());
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    return curCtx->ModelTaskUpdate(desStm, desTaskId, sinkStm, para);
}

rtError_t ApiImpl::DeviceL2CacheFlush()
{
    RT_LOG(RT_LOG_INFO, "Flush L2 cache for current device.");
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device* const dev = curCtx->Device_();
    NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);

    drvL2buffInvalidType buf = DRV_L2BUFF_CLEAN_CSP;
    const rtError_t error = NpuDriver::SetDeviceInfoByBuff(
        dev->Id_(), MODULE_TYPE_L2BUFF, INFO_TYPE_L2BUFF_INVALID_CACHE, &buf, sizeof(drvL2buffInvalidType));
    if (error == RT_ERROR_FEATURE_NOT_SUPPORT) {
        RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
            ErrorCode::EE1015, "Flushing L2 cache",
            "If the driver has been upgraded to the latest version, "
            "the current chip type may not support L2 cache flush.");
        return error;
    }
    return error;
}

rtError_t ApiImpl::FlushCache(const uint64_t base, const size_t len)
{
    RT_LOG(RT_LOG_INFO, "flush cache base=%" PRIu64 ", len=%zu.", base, len);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        base == 0U, RT_ERROR_INVALID_VALUE, "Cache update", base, "not equal to 0");

    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    const rtError_t error = curCtx->Device_()->GetDeviceStatus();
    COND_PROC((error == RT_ERROR_DEVICE_TASK_ABORT), return error);
    return RT_ERROR_NONE;
}

rtError_t ApiImpl::InvalidCache(const uint64_t base, const size_t len)
{
    RT_LOG(RT_LOG_INFO, "invalid cache base=%" PRIu64 ", len=%zu.", base, len);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_AND_FUNC_DESC(
        base == 0U, RT_ERROR_INVALID_VALUE, "Invalidating cache data", base, "not equal to 0");

    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    return RT_ERROR_NONE;
}

rtError_t ApiImpl::GetDeviceByPCIBusId(const char* pciBusId, int32_t* devId)
{
    RT_LOG(RT_LOG_DEBUG, "Get device by PCI bus id, pciBusId=%s.", pciBusId);

    Runtime* const rt = Runtime::Instance();
    uint32_t devCnt = rt->deviceCnt;
    if (devCnt == 0U) {
        FacadeDriver& curDrv = rt->FacadeDriver_();
        int32_t drvDeviceCnt = 0;
        const rtError_t error = curDrv.GetDeviceCount(&drvDeviceCnt);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "GetDeviceCount failed, error=%#x.", static_cast<uint32_t>(error));
            return error;
        }
        devCnt = static_cast<uint32_t>(drvDeviceCnt);
    }
    for (uint32_t logicalDevId = 0U; logicalDevId < devCnt; ++logicalDevId) {
        char curBdf[RT_PCI_BUS_ID_MIN_LEN] = {0};
        rtError_t error = NpuDriver::GetDevicePCIBusId(logicalDevId, curBdf, static_cast<int32_t>(sizeof(curBdf)));
        if (error != RT_ERROR_NONE) {
            RT_LOG(
                RT_LOG_DEBUG, "GetDevicePCIBusId failed for logicalDevId=%u, error=%#x.", logicalDevId,
                static_cast<uint32_t>(error));
            continue;
        }
        if (strcmp(pciBusId, curBdf) == 0) {
            error = rt->GetUserDevIdByDeviceId(logicalDevId, reinterpret_cast<uint32_t*>(devId));
            if (error != RT_ERROR_NONE) {
                RT_LOG(
                    RT_LOG_ERROR, "GetUserDevIdByDeviceId failed for logicalDevId=%u, error=%#x.", logicalDevId,
                    static_cast<uint32_t>(error));
                return error;
            }
            return RT_ERROR_NONE;
        }
    }
    RT_LOG(RT_LOG_ERROR, "No device matched PCI bus id: %s.", pciBusId);
    RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
        ErrorCode::EE1003, "Obtaining the device by PCI bus id", std::string(pciBusId), "pciBusId",
        "a valid PCI bus id string (e.g., 0000:86:00.0)");
    return RT_ERROR_INVALID_VALUE;
}

rtError_t ApiImpl::HostGetDevicePointerAddrRange(rtAddrRange* addrRange, uint32_t* count)
{
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    const uint32_t deviceId = curCtx->Device_()->Id_();
    RT_LOG(RT_LOG_INFO, "Start to HostGetDevicePointerAddrRange");
    rtError_t error = RT_ERROR_NONE;
    if (addrRange == nullptr) {
        error = NpuDriver::HostGetDevicePointerAddrCount(deviceId, count);
    } else {
        error = NpuDriver::HostGetDevicePointerAddrRange(deviceId, addrRange, count);
    }
    return error;
}

rtError_t ApiImpl::TaskGetParams(rtTask_t task, rtTaskParams* const params)
{
    const TaskInfo* const taskInfo = RtPtrToPtr<const TaskInfo*>(task);
    const Stream* stm = taskInfo->stream;
    NULL_PTR_RETURN(stm, RT_ERROR_STREAM_NULL);
    Model* const mdl = stm->Model_();
    if ((mdl != nullptr) && (mdl->GetModelType() == RT_MODEL_CAPTURE_MODEL)) {
        CaptureModel* captureModel = dynamic_cast<CaptureModel*>(mdl);
        COND_RETURN_WARN(
            ((captureModel != nullptr) && captureModel->IsSubCaptureModel()), RT_ERROR_FEATURE_NOT_SUPPORT,
            "task belongs to sub ACL Graph, does not support getting task parameters");
    }
    rtError_t error = CheckCaptureModelSupportSoftwareSq(stm->Device_());
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    if (taskInfo->taskOwner == static_cast<uint8_t>(TaskOwner::RT_TASK_INNER)) {
        RT_LOG_OUTER_MSG_IMPL(
            ErrorCode::EE1017, "Obtaining task parameter information", "task->type",
            "The current task type RT_TASK_DEFAULT does not support obtaining of parameters."
            " Only task types other than RT_TASK_DEFAULT supports obtaining of parameters");
        RT_LOG(
            RT_LOG_ERROR, "streamId=%d, taskId=%u, alloc taskType=%d, taskName=%s, taskOwner=TASK_INNER(%u).",
            taskInfo->stream->Id_(), taskInfo->id, taskInfo->type, taskInfo->typeName,
            static_cast<uint32_t>(taskInfo->taskOwner));
        return RT_ERROR_INVALID_VALUE;
    }

    COND_RETURN_WARN(
        IsTaskBelongToSubCaptureMdl(taskInfo), RT_ERROR_FEATURE_NOT_SUPPORT,
        "task belongs to sub ACL Graph, does not support querying task type");

    (void)memset_s(params, sizeof(rtTaskParams), 0, sizeof(rtTaskParams));
    error = ConvertTaskType(taskInfo, &params->type);
    ERROR_RETURN(error, "get task type failed, retCode=%d.", error);
    switch (taskInfo->type) {
        case TS_TASK_TYPE_KERNEL_AICORE:
        case TS_TASK_TYPE_KERNEL_AIVEC:
            error = GetKernelTaskParams(taskInfo, params);
            break;
        case TS_TASK_TYPE_EVENT_RECORD:
            error = GetEventRecordTaskParams(taskInfo, params);
            break;
        case TS_TASK_TYPE_STREAM_WAIT_EVENT:
            error = GetEventWaitTaskParams(taskInfo, params);
            break;
        case TS_TASK_TYPE_EVENT_RESET:
            error = GetEventResetTaskParams(taskInfo, params);
            break;
        case TS_TASK_TYPE_DAVID_EVENT_RECORD:
            error = GetEventRecordTaskParamsStarsV2(taskInfo, params);
            break;
        case TS_TASK_TYPE_DAVID_EVENT_WAIT:
            error = GetEventWaitTaskParamsStarsV2(taskInfo, params);
            break;
        case TS_TASK_TYPE_DAVID_EVENT_RESET:
            error = GetEventResetTaskParamsStarsV2(taskInfo, params);
            break;
        case TS_TASK_TYPE_CAPTURE_RECORD:
        case TS_TASK_TYPE_CAPTURE_RECORD_EXTERNAL:
            error = GetCaptureRecordTaskParams(taskInfo, params);
            break;
        case TS_TASK_TYPE_CAPTURE_WAIT:
        case TS_TASK_TYPE_CAPTURE_WAIT_EXTERNAL:
            error = GetCaptureWaitTaskParams(taskInfo, params);
            break;
        case TS_TASK_TYPE_MEM_WRITE_VALUE: {
            const std::string eventResetName = "EVENT_RESET";
            if (eventResetName == taskInfo->typeName) {
                error = GetCaptureResetTaskParams(taskInfo, params);
            } else {
                error = GetWriteValueTaskParams(taskInfo, params);
            }
            break;
        }
        case TS_TASK_TYPE_MEM_WAIT_VALUE:
            error = GetWaitValueTaskParams(taskInfo, params);
            break;
        default:
            RT_LOG_OUTER_MSG_IMPL(
                ErrorCode::EE1017, "Obtaining task parameter information", "task->type",
                "The current task type RT_TASK_DEFAULT does not support obtaining of parameters."
                " Only task types other than RT_TASK_DEFAULT supports obtaining of parameters");
            RT_LOG(
                RT_LOG_ERROR,
                "now this task doesn't support get params, stream_id=%d, task_id=%hu, typeName=%s, task type=%d",
                stm->Id_(), taskInfo->id, taskInfo->typeName, taskInfo->type);
            error = RT_ERROR_INVALID_VALUE;
            break;
    }
    return error;
}

rtError_t ApiImpl::TaskSetParams(rtTask_t task, rtTaskParams* const params)
{
    TaskInfo* const taskInfo = static_cast<TaskInfo*>(task);
    rtError_t error = CheckCaptureModelForUpdate(taskInfo->stream);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    CaptureModel* captureModel = dynamic_cast<CaptureModel*>(taskInfo->stream->Model_());
    NULL_PTR_RETURN(captureModel, RT_ERROR_MODEL_NULL);

    captureModel->SetCaptureModelStatus(RtCaptureModelStatus::UPDATING);

    switch (params->type) {
        case RT_TASK_KERNEL:
            error = UpdateKernelParams(taskInfo, params);
            break;
        case RT_TASK_EVENT_RECORD:
        case RT_TASK_EVENT_WAIT:
        case RT_TASK_EVENT_RESET:
            RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
                ErrorCode::EE1003, "Setting task parameters", TaskTypeToString(params->type), "params->type",
                "TASK_KERNEL(1) or TASK_VALUE_WRITE(5) or TASK_VALUE_WAIT(6)");
            error = RT_ERROR_INVALID_VALUE;
            break;
        case RT_TASK_VALUE_WRITE:
            error = UpdateWriteValueTaskParams(taskInfo, params);
            break;
        case RT_TASK_VALUE_WAIT:
            error = UpdateWaitValueTaskParams(taskInfo, params);
            break;
        default:
            RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
                ErrorCode::EE1003, "Setting task parameters", TaskTypeToString(params->type), "params->type",
                "TASK_KERNEL(1) or TASK_VALUE_WRITE(5) or TASK_VALUE_WAIT(6)");
            error = RT_ERROR_INVALID_VALUE;
            break;
    }
    ERROR_PROC_RETURN_MSG_INNER(error, captureModel->SetCaptureModelStatus(RtCaptureModelStatus::FAULT);
                                , "task set params failed");
    taskInfo->updateFlag = static_cast<uint8_t>(TaskUpdateFlag::RT_TASK_UPDATE);
    RT_LOG(
        RT_LOG_INFO, "stream_id=%d, task_id=%hu, typeName=%s, task type=%d, target type=%s", taskInfo->stream->Id_(),
        taskInfo->id, taskInfo->typeName, taskInfo->type, TaskTypeToString(params->type).c_str());
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
