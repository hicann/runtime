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
#include "runtime_handle_guard.h"
#include "maintenance_task.h"
#include "base.hpp"
#include "stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "event.hpp"
#include "program.hpp"
#include "notify.hpp"
#include "device.hpp"
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
#include "dvpp_grp.hpp"
#include "driver/ascend_hal.h"
#include "task_submit.hpp"
#include "platform/platform_info.h"
#include "platform_manager_v2.h"
#include "stream_factory.hpp"
#include "device/device_error_proc.hpp"
#include "stream_state_callback_manager.hpp"
#include "heterogenous.h"
#include "capture_model.hpp"
#include "capture_model_utils.hpp"
#include "stars_engine.hpp"
#include "binary_loader.hpp"
#include "args_handle_allocator.hpp"
#include "para_convertor.hpp"
#include "soc_info.h"
#include "ipc_event.hpp"
#include "inner_thread_local.hpp"
#include "soma.hpp"
#include "memset_common.h"

namespace cce {
namespace runtime {

rtError_t ApiImpl::CntNotifyCreate(const int32_t deviceId, CountNotify** const retCntNotify, const uint32_t flag)
{
    UNUSED(deviceId);
    UNUSED(retCntNotify);
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
    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM(stm, curCtx, RT_ERROR_STREAM_CONTEXT);
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
    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM(curStm, curCtx, RT_ERROR_STREAM_CONTEXT);

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

    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM(curStm, curCtx, RT_ERROR_STREAM_CONTEXT);

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

    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM(curStm, curCtx, RT_ERROR_STREAM_CONTEXT);

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
        ret != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE, "Get NPU arch failed, chipType=%d.",
        static_cast<int32_t>(rt->GetChipType()));
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

rtError_t ApiImpl::IpcGetEventHandle(IpcEvent* const evt, rtIpcEventHandle_t* handle)
{
    return evt->IpcGetEventHandle(handle);
}

rtError_t ApiImpl::IpcOpenEventHandle(rtIpcEventHandle_t* handle, IpcEvent** const event)
{
    Context* const curCtx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device* const dev = curCtx->Device_();
    *event = new (std::nothrow) IpcEvent(dev, RT_EVENT_IPC, curCtx);
    COND_RETURN_AND_MSG_OUTER((*event == nullptr), RT_ERROR_EVENT_NEW, ErrorCode::EE1013, sizeof(IpcEvent), "new");
    RT_LOG(RT_LOG_INFO, "new event success");
    const rtError_t error = (*event)->IpcOpenEventHandle(handle);
    COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, DELETE_O(*event);
                           , "IpcOpenEventHandle failed, retCode=%#x", error);
    InitEmbeddedInnerHandle<Event>(*event);
    return RT_ERROR_NONE;
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
        COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM(curStm, curCtx, RT_ERROR_STREAM_CONTEXT);
        return MemsetD32OnDevice(dst, destMax, value, count, curStm, true, attr.location.id);
    }
}

rtError_t ApiImpl::SetGroup(const int32_t groupId)
{
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_DEVICE_GROUP)) {
        RT_LOG(RT_LOG_ERROR, "Device groups are not supported on chipType=%d", chipType);
        RT_LOG_OUTER_MSG_WITH_FUNC_DESC(ErrorCode::EE1005, "Specifying the group used for the current operation");
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
        RT_LOG(RT_LOG_ERROR, "Device groups are not supported on chipType=%d", chipType);
        RT_LOG_OUTER_MSG_WITH_FUNC_DESC(ErrorCode::EE1005, "Obtaining the number of available computing power groups");
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
        RT_LOG(RT_LOG_ERROR, "Device groups are not supported on chipType=%d", chipType);
        RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
            ErrorCode::EE1005, "Querying the computing power information of a specified group");
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
        RT_ERROR_FEATURE_NOT_SUPPORT, "chipType=%d does not support get device msg feature.", chipType);
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
            ERR_MODULE_GE, "Unsupported get msg type=%d, range is [%d, %d)", getMsgType, RT_GET_DEV_ERROR_MSG,
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
    RT_LOG(RT_LOG_INFO, "Open ipc memory, name=%s, flags=%#" PRIx64 ".", name, flags);
    Context* const curCtx = CurrentContext();
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

    error = dev->Driver_()->OpenIpcMem(name, RtPtrToPtr<uint64_t*>(ptr), curCtx->Device_()->Id_());
    return error;
}
} // namespace runtime
} // namespace cce
