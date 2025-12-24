/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ipc_event.hpp"
#include "inner_thread_local.hpp"
#include "thread_local_container.hpp"
namespace cce {
namespace runtime {
IpcEvent::IpcEvent(Device *device, uint64_t eventFlag, Context *ctx)
    : Event(device, eventFlag, ctx, false ,true), device_(device), eventFlag_(eventFlag), context_(ctx),
      ipcHandlePa_(nullptr), ipcHandleVa_(nullptr), currentDeviceMem_(nullptr),currentHostMem_(nullptr),
      deviceMemPa_(nullptr), hostMemPa_(nullptr), ipcHandle_(0U), deviceMemSize_(0U),
      totalTaskCnt_(0U), isNeedDestroy_(false), mapFlag_(0U), eventStatus_(INIT)
{}

IpcEvent::~IpcEvent() noexcept
{
}

rtError_t IpcEvent::IpcVaAndPaOperation(rtDrvMemProp_t *prop, uint64_t *deviceMemHandle)
{
    void *deviceMemVa = nullptr;
    rtDrvMemHandle deviceMemPa = nullptr;
    // 1.2 halMemAddressReserve get deviceMemVa
    rtError_t error = NpuDriver::ReserveMemAddress(&deviceMemVa, IPC_EVENT_P2P_SIZE, 0, nullptr, 0);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event setup failed, error=%#x.", static_cast<uint32_t>(error));
    currentDeviceMem_ = deviceMemVa;
    currentHostMem_ = deviceMemVa;

    // 1.3 halMemCreate alloc deviceMemPa  8k
    prop->devid = device_->Id_();
    error = NpuDriver::MallocPhysical(&deviceMemPa, IPC_EVENT_P2P_SIZE, prop, 0);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event setup failed, error=%#x.", static_cast<uint32_t>(error));
    deviceMemPa_ = deviceMemPa;

    // 1.4 halMemMap map va to pa size 8k
    error = NpuDriver::MapMem(deviceMemVa, IPC_EVENT_P2P_SIZE, 0, deviceMemPa, 0);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event setup failed, error=%#x.", static_cast<uint32_t>(error));
    mapFlag_ |= DEV_MEM_MAP_FLAG;;
    error = device_->Driver_()->MemSetSync(deviceMemVa, IPC_EVENT_P2P_SIZE, 0U, IPC_EVENT_P2P_SIZE);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event MemSetSync failed, error=%#x.", static_cast<uint32_t>(error));
    // 1.5 halMemExportToShareableHandle pa for handle, SetMemShareHandleDisablePidVerify close whitelist
    error = NpuDriver::ExportToShareableHandle(deviceMemPa, RT_MEM_HANDLE_TYPE_NONE, IPC_EVENT_P2P_NO_CHECK_FLAG, deviceMemHandle); 
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event setup failed, error=%#x.", static_cast<uint32_t>(error));
    error = NpuDriver::SetMemShareHandleDisablePidVerify(*deviceMemHandle);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event setup failed, error=%#x.", static_cast<uint32_t>(error));

    // 1.6 halMemSetAccess p2p to host
    rtMemAccessDesc memAccessDesc = {};
    memAccessDesc.flags = RT_MEM_ACCESS_FLAGS_READWRITE;
    memAccessDesc.location.id = 0U;
    memAccessDesc.location.type = RT_MEMORY_LOC_HOST;

    error = NpuDriver::MemSetAccess(deviceMemVa, IPC_EVENT_P2P_SIZE, &memAccessDesc, MEM_SET_ACCESS_NUM);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event setup failed, error=%#x.", static_cast<uint32_t>(error));
    RT_LOG(RT_LOG_INFO, "MemSetAccess success.");
    return error;
}

rtError_t IpcEvent::IpcHandleAllocAndExport(size_t granularity, rtDrvMemProp_t *prop, uint64_t* ipcHandle)
{
    void *ipcHandleVa = nullptr;
    rtDrvMemHandle ipcHandlePa = nullptr;
    // 2. begin to alloc handle for share
    const size_t ipcHandleSize = GetAlignedSize(sizeof(IpcHandleVa), granularity);

    // 2.1 halMemAddressReserve get ipcHandleVa
    rtError_t error = NpuDriver::ReserveMemAddress(&ipcHandleVa, ipcHandleSize, 0, nullptr, 0);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event ReserveMemAddress failed, error=%#x.", static_cast<uint32_t>(error));
    ipcHandleVa_ = RtPtrToPtr<IpcHandleVa*>(ipcHandleVa);

    // 2.2 halMemCreate get ipcHandlePa
    prop->devid = 0U;
    prop->side = MEM_HOST_SIDE;
    error = NpuDriver::MallocPhysical(&ipcHandlePa, ipcHandleSize, prop, 0);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event MallocPhysical failed, error=%#x.", static_cast<uint32_t>(error));
    ipcHandlePa_ = ipcHandlePa;

    // 2.3 map ipcHandleVa to ipcHandlePa
    error = NpuDriver::MapMem(ipcHandleVa, ipcHandleSize, 0, ipcHandlePa, 0);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event setup failed, error=%#x.", static_cast<uint32_t>(error));
    mapFlag_ |= IPC_HANDLE_MAP_FLAG;
    error = device_->Driver_()->MemSetSync(ipcHandleVa, ipcHandleSize, 0U, ipcHandleSize);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event MemSetSync failed, error=%#x.", static_cast<uint32_t>(error));

    // init lock
    IpcVaLockInit();

    // 2.4 halMemExportToShareableHandle pa for ipcHandle, SetMemShareHandleDisablePidVerify close whitelist
    error = NpuDriver::ExportToShareableHandle(ipcHandlePa, RT_MEM_HANDLE_TYPE_NONE, IPC_EVENT_P2P_NO_CHECK_FLAG, ipcHandle);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event setup failed, error=%#x.", static_cast<uint32_t>(error));
    error = NpuDriver::SetMemShareHandleDisablePidVerify(*ipcHandle);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event setup failed, error=%#x.", static_cast<uint32_t>(error));
    return error;
}

rtError_t IpcEvent::Setup()
{
    COND_RETURN_WARN((!(NpuDriver::CheckIsSupportFeature(context_->Device_()->Id_(),
        FEATURE_SVM_VMM_NORMAL_GRANULARITY))), RT_ERROR_FEATURE_NOT_SUPPORT,
        "Not support Ipc event in current drv version");
    // 1.get granularity
    RT_LOG(RT_LOG_INFO, "start ipc event setup.");
    size_t granularity = 0;
    uint64_t deviceMemHandle = 0U;
    uint64_t ipcHandle = 0U;
    rtError_t error = RT_ERROR_NONE;
    rtDrvMemProp_t prop = {};
    prop.devid = IMPORT_DEVICE_ID;
    prop.side = MEM_DEV_SIDE;
    prop.mem_type = MEM_P2P_HBM_TYPE;
    prop.module_id = static_cast<uint16_t>(RUNTIME);
    prop.pg_type = MEM_NORMAL_PAGE_TYPE;
    error = NpuDriver::GetAllocationGranularity(&prop, RT_MEM_ALLOC_GRANULARITY_MINIMUM, &granularity);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event setup failed, error=%#x.", static_cast<uint32_t>(error));
    RT_LOG(RT_LOG_INFO, "GetAllocationGranularity success.");
    std::function<void()> const recycleFunc = [this]() {
        ReleaseDrvResource();
    };
    ScopeGuard errRecycle(recycleFunc);

    // p2p proc
    error = IpcVaAndPaOperation(&prop, &deviceMemHandle);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event IpcVaAndPaOperation failed, error=%#x.", static_cast<uint32_t>(error));

    // share handle proc
    error = IpcHandleAllocAndExport(granularity, &prop, &ipcHandle);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event IpcHandleAllocAndExport failed, error=%#x.", static_cast<uint32_t>(error));
    errRecycle.ReleaseGuard();

    ipcHandle_ = ipcHandle;
    deviceMemSize_ = IPC_EVENT_P2P_SIZE;
    ipcHandleVa_->deviceMemHandle = RtValueToPtr<void*>(deviceMemHandle);
    return error;
}

rtError_t IpcEvent::IpcGetEventHandle(rtIpcEventHandle_t *handle)
{
    COND_RETURN_WARN((!(NpuDriver::CheckIsSupportFeature(context_->Device_()->Id_(),
        FEATURE_SVM_VMM_NORMAL_GRANULARITY))), RT_ERROR_FEATURE_NOT_SUPPORT,
        "Not support Ipc event in current drv version, version",
        FEATURE_SVM_VMM_NORMAL_GRANULARITY);
    memcpy_s(static_cast<void*>(handle), sizeof(uint64_t), &ipcHandle_, sizeof(uint64_t));
    return RT_ERROR_NONE;
}

rtError_t IpcEvent::IpcHandleAllocAndImport(size_t granularity, rtIpcEventHandle_t* ipcEventHandle)
{
    void *ipcHandleVa = nullptr;
    rtDrvMemHandle ipcHandlePa = nullptr;
    const size_t ipcHandleSize = GetAlignedSize(sizeof(IpcHandleVa), granularity);
    rtError_t error = NpuDriver::ReserveMemAddress(&ipcHandleVa, ipcHandleSize, 0, nullptr, 0);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event open failed, error=%#x.", static_cast<uint32_t>(error));
    ipcHandleVa_ = RtPtrToPtr<IpcHandleVa*>(ipcHandleVa);

    // 1.2 import ipcHandlePa from ipcHandle
    uint64_t ipcHandle;
    memcpy_s(&ipcHandle, sizeof(uint64_t), static_cast<void*>(ipcEventHandle), sizeof(uint64_t));
    error = NpuDriver::ImportFromShareableHandle(ipcHandle, IMPORT_DEVICE_ID, &ipcHandlePa);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event open failed, error=%#x.", static_cast<uint32_t>(error));
    ipcHandlePa_ = ipcHandlePa;

    // 1.3 map ipcHandleVa to ipcHandlePa
    error = NpuDriver::MapMem(ipcHandleVa, ipcHandleSize, 0, ipcHandlePa, 0);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event open failed, error=%#x.", static_cast<uint32_t>(error));
    mapFlag_ |= IPC_HANDLE_MAP_FLAG;

    ipcHandle_ = ipcHandle;
    return error;
}
rtError_t IpcEvent::EnableP2PForIpc(uint64_t deviceMemHandle) const
{
    const uint32_t deviceId = device_->Id_();
    uint32_t peerPhyDeviceId = 0U;
    rtError_t error = NpuDriver::GetPhyDevIdByMemShareHandle(deviceMemHandle, &peerPhyDeviceId);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc GetPhyDevIdByMemShareHandle failed, error=%#x.", static_cast<uint32_t>(error));
    // enable p2p
    if (deviceId != peerPhyDeviceId) {
        error = NpuDriver::EnableP2P(deviceId, peerPhyDeviceId, 0);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "enable p2p failed, error=%#x.", static_cast<uint32_t>(error));
        error = NpuDriver::EnableP2P(peerPhyDeviceId, deviceId, 0);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "enable p2p failed, error=%#x.", static_cast<uint32_t>(error));
    }
    return error;
}

rtError_t IpcEvent::IpcMemHandleImport(bool hostFlag, uint64_t deviceMemHandle)
{
    void *MemVa = nullptr;
    rtDrvMemHandle MemPa = nullptr;
    int32_t currentId = (hostFlag == true) ? IMPORT_DEVICE_ID : static_cast<int32_t>(device_->Id_());
    // 2.1 alloc va for p2p open
    rtError_t error = NpuDriver::ReserveMemAddress(&MemVa, IPC_EVENT_P2P_SIZE, 0, nullptr, 0);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event open failed, error=%#x.", static_cast<uint32_t>(error));
    if (hostFlag) {
        currentHostMem_ = MemVa;
    } else {
        currentDeviceMem_ = MemVa;
    }

    // 2.2 import pa by deviceMemHandle
    error = NpuDriver::ImportFromShareableHandle(deviceMemHandle, currentId, &MemPa);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event open failed, error=%#x.", static_cast<uint32_t>(error));
    if (hostFlag) {
        hostMemPa_ = MemPa;
    } else {
        deviceMemPa_ = MemPa;
    }

    // 2.3 map MemVa to MemPa
    error = NpuDriver::MapMem(MemVa, IPC_EVENT_P2P_SIZE, 0, MemPa, 0);    
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event open failed, error=%#x.", static_cast<uint32_t>(error));
    if (hostFlag) {
        mapFlag_ |= HOST_MEM_MAP_FLAG;
    } else {
        mapFlag_ |= DEV_MEM_MAP_FLAG;
    }

    return error;
}

rtError_t IpcEvent::IpcOpenEventHandle(rtIpcEventHandle_t *ipcEventHandle)
{
    COND_RETURN_WARN((!(NpuDriver::CheckIsSupportFeature(context_->Device_()->Id_(),
        FEATURE_SVM_VMM_NORMAL_GRANULARITY))), RT_ERROR_FEATURE_NOT_SUPPORT,
        "Not support Ipc event in current drv version, version",
        FEATURE_SVM_VMM_NORMAL_GRANULARITY);
    RT_LOG(RT_LOG_INFO, "IpcOpenEventHandle start");
    NULL_PTR_RETURN_MSG(ipcEventHandle, RT_ERROR_INVALID_VALUE);
    rtError_t error = RT_ERROR_NONE;

    // get granularity
    rtDrvMemProp_t prop = {};
    prop.devid = IMPORT_DEVICE_ID;
    prop.side = MEM_HOST_SIDE;
    prop.mem_type = MEM_P2P_HBM_TYPE;
    prop.module_id = static_cast<uint16_t>(RUNTIME);
    prop.pg_type = MEM_NORMAL_PAGE_TYPE;
    size_t granularity = 0U;
    error = NpuDriver::GetAllocationGranularity(&prop, RT_MEM_ALLOC_GRANULARITY_MINIMUM, &granularity);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event open failed, error=%#x.", static_cast<uint32_t>(error));
    RT_LOG(RT_LOG_INFO, "GetAllocationGranularity success, granularity=%u.", granularity);
    std::function<void()> const recycleFunc = [this]() {
        ReleaseDrvResource();
    };
    ScopeGuard errRecycle(recycleFunc);

    // share handle proc
    error = IpcHandleAllocAndImport(granularity, ipcEventHandle);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event IpcHandleAllocAndImport failed, error=%#x.", static_cast<uint32_t>(error));

    // init lock
    IpcVaLockInit();

    uint64_t deviceMemHandle = 0U;
    deviceMemHandle = RtPtrToValue(ipcHandleVa_->deviceMemHandle);

    // enable p2p
    error = EnableP2PForIpc(deviceMemHandle);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event enable p2p failed, error=%#x.", static_cast<uint32_t>(error));

    // host import
    error = IpcMemHandleImport(true, deviceMemHandle);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event IpcHandleAllocAndImport failed, error=%#x.", static_cast<uint32_t>(error));

    // device import
    error = IpcMemHandleImport(false, deviceMemHandle);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "ipc event IpcHandleAllocAndImport failed, error=%#x.", static_cast<uint32_t>(error));
    errRecycle.ReleaseGuard();

    deviceMemSize_ = IPC_EVENT_P2P_SIZE;
    return error;
}

rtError_t IpcEvent::GetIpcRecordIndex(uint16_t *curIndex)
{
    rtError_t error = RT_ERROR_NONE;
    IpcVaLock();
    for (int i = 0; static_cast<uint32_t>(i) < IPC_EVENT_P2P_SIZE; ++i) {
        error = context_->CheckStatus();
        COND_PROC((error != RT_ERROR_NONE), IpcVaUnLock(); return error);
        if (ipcHandleVa_->deviceMemRef[i] == 0U) {
            ipcHandleVa_->currentIndex = static_cast<uint16_t>(i);
            *curIndex = static_cast<uint16_t>(i);
            ipcHandleVa_->deviceMemRef[ipcHandleVa_->currentIndex]++; 
            break;
        }
        COND_PROC(((static_cast<uint32_t>(i) == (IPC_EVENT_P2P_SIZE - 1)) &&
            (ipcHandleVa_->deviceMemRef[i] != 0)), i = -1);
    }
    IpcEventCountAdd();
    IpcVaUnLock();
    return error;
}

rtError_t IpcEvent::IpcEventRecord(Stream * const stm)
{
    rtError_t error = RT_ERROR_NONE;
    rtError_t errorReason;
    Device * const dev = stm->Device_();
    TaskInfo submitTask = {};
    TaskInfo *tsk = stm->AllocTask(&submitTask, TS_TASK_TYPE_IPC_RECORD, errorReason);
    COND_RETURN_ERROR_MSG_INNER((tsk == nullptr), errorReason,
                                "Failed to alloc task when ipc record, stream_id=%d.", stm->Id_());
    uint16_t curIndex = 0U;
    error = GetIpcRecordIndex(&curIndex);
    COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, (void)dev->GetTaskFactory()->Recycle(tsk),
        "context is abort, status=%#x.", static_cast<uint32_t>(error));
    std::function<void()> const errRecycle = [&dev, &tsk, this]() {
        IpcVaLock();
        ipcHandleVa_->deviceMemRef[ipcHandleVa_->currentIndex]--;
        IpcEventCountSub();
        IpcVaUnLock();
        (void)dev->GetTaskFactory()->Recycle(tsk);
    };
    ScopeGuard tskErrRecycle(errRecycle);
    uint16_t* addr = ((uint16_t*)currentDeviceMem_) + curIndex;
    error = MemWriteValueTaskInit(tsk, RtPtrToPtr<void*>(addr), static_cast<uint64_t>(1U));
    ERROR_RETURN_MSG_INNER(error, "mem write value init failed, stream_id=%d, task_id=%hu, retCode=%#x.",
        stm->Id_(), tsk->id, static_cast<uint32_t>(error));
    tsk->typeName = "IPC_RECORD";
    tsk->type = TS_TASK_TYPE_IPC_RECORD;
    MemWriteValueTaskInfo *memWriteValueTask = &tsk->u.memWriteValueTask;
    memWriteValueTask->curIndex = curIndex;
    memWriteValueTask->event = this;
    memWriteValueTask->awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT;
    error = dev->SubmitTask(tsk);
    ERROR_RETURN_MSG_INNER(error, "Failed to submit ipc task, retCode=%#x.", static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    GET_THREAD_TASKID_AND_STREAMID(tsk, stm->AllocTaskStreamId());
    eventStatus_ = INIT;
    RT_LOG(RT_LOG_INFO, "ipc event task submit success, device_id=%u, stream_id=%d, task_id=%hu, event_id=%u",
        dev->Id_(), stm->Id_(), tsk->id, curIndex);
    return error;
}

rtError_t IpcEvent::IpcEventWait(Stream * const stm)
{
    rtError_t error = RT_ERROR_NONE;
    uint16_t curIndex;
    IpcVaLock();
    if (ipcHandleVa_->deviceMemRef[ipcHandleVa_->currentIndex] == 0U) {
        IpcVaUnLock();
        RT_LOG(RT_LOG_INFO, "currentIndex is zero, record finished or wait first, return success.");
        return error;
    }
    ipcHandleVa_->deviceMemRef[ipcHandleVa_->currentIndex]++;
    curIndex = ipcHandleVa_->currentIndex;
    IpcEventCountAdd();
    IpcVaUnLock();
    Device * const dev = stm->Device_();
    TaskInfo *tsk = nullptr;
    TaskInfo submitTask = {};
    rtError_t errorReason;
    tsk = stm->AllocTask(&submitTask, TS_TASK_TYPE_IPC_WAIT, errorReason, MEM_WAIT_SQE_NUM);
    COND_PROC_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, tsk == nullptr, errorReason,
        IpcVaLock(); ipcHandleVa_->deviceMemRef[ipcHandleVa_->currentIndex]--; IpcVaUnLock(),
        "task alloc fail err:%#x", static_cast<uint32_t>(errorReason));
    std::function<void()> const errRecycle = [&dev, &tsk, this]() {
        IpcVaLock();
        ipcHandleVa_->deviceMemRef[ipcHandleVa_->currentIndex]--;
        IpcEventCountSub();
        IpcVaUnLock();
        (void)dev->GetTaskFactory()->Recycle(tsk);
    };
    ScopeGuard tskErrRecycle(errRecycle);
    uint16_t* addr = ((uint16_t*)currentDeviceMem_) + curIndex;
    tsk->typeName = "IPC_WAIT";
    tsk->type = TS_TASK_TYPE_IPC_WAIT;
    error = MemWaitValueTaskInit(tsk, RtPtrToPtr<void*>(addr), 1, 0x0);
    ERROR_RETURN_MSG_INNER(error, "mem wait value init failed, stream_id=%d, task_id=%hu, retCode=%#x.",
        stm->Id_(), tsk->id, static_cast<uint32_t>(error));
    MemWaitValueTaskInfo *memWaitValueTask = &tsk->u.memWaitValueTask;
    memWaitValueTask->curIndex = curIndex;
    memWaitValueTask->event = this;
    memWaitValueTask->awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT;
    error = dev->SubmitTask(tsk);
    ERROR_RETURN_MSG_INNER(error, "Failed to submit wait task, retCode=%#x.", static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    GET_THREAD_TASKID_AND_STREAMID(tsk, stm->AllocTaskStreamId());
    RT_LOG(RT_LOG_INFO, "ipc wait task submit success, device_id=%u, stream_id=%d, task_id=%hu, event_id=%u",
        device_->Id_(), stm->Id_(), tsk->id, curIndex);
    return error;
}

rtError_t IpcEvent::IpcEventQuery(rtEventStatus_t * const status)
{
    rtError_t error = context_->CheckStatus();
    ERROR_RETURN(error, "context is abort, status=%#x.", static_cast<uint32_t>(error));
    IpcVaLock();
    uint16_t curIndex = ipcHandleVa_->currentIndex;
    if (ipcHandleVa_->deviceMemRef[curIndex] == 0U) {
        RT_LOG(RT_LOG_INFO, "not record or record had been finished, return success.");
        *status = RT_EVENT_RECORDED;
        IpcVaUnLock();
        return RT_ERROR_NONE;
    }
    IpcVaUnLock();
    uint16_t* hostaddr = GetCurrentHostMem() + curIndex;
    if (((*hostaddr & IPC_RECORD_STATUS) != 0U) || IsIpcFinished()) {
        *status = RT_EVENT_RECORDED;
    } else {
        *status = RT_EVENT_INIT;
    }

    return RT_ERROR_NONE;
}

rtError_t IpcEvent::IpcEventSync(int32_t timeout)
{
    rtError_t error = context_->CheckStatus();
    ERROR_RETURN(error, "context is abort, status=%#x.", static_cast<uint32_t>(error));
    IpcVaLock();
    uint16_t curIndex = ipcHandleVa_->currentIndex;
    RT_LOG(RT_LOG_INFO, "current index=%u.", curIndex);
    if (ipcHandleVa_->deviceMemRef[curIndex] == 0U) {
        IpcVaUnLock();
        RT_LOG(RT_LOG_INFO, "not record or record had been finished, return success.");
        return RT_ERROR_NONE;
    }
    IpcVaUnLock();
    uint16_t* hostaddr = GetCurrentHostMem()+ curIndex;
    uint16_t queryTimes = 0U;
    const mmTimespec beginTimeSpec = mmGetTickCount();
    while (((*hostaddr & IPC_RECORD_STATUS) == 0U) || IsIpcFinished()) { 
        error = context_->CheckStatus();
        ERROR_RETURN(error, "context is abort, status=%#x.", static_cast<uint32_t>(error));
        queryTimes++;
        if (queryTimes == 1000U) {
            (void)mmSleep(100U);
            queryTimes = 0U;
        }
        COND_RETURN_ERROR((IsProcessTimeout(beginTimeSpec, timeout)), RT_ERROR_EVENT_SYNC_TIMEOUT,
            "event synchronize timeout, device_id=%u, timeout=%dms.",
            device_->Id_(), timeout);
    }

    return RT_ERROR_NONE;
}

bool IpcEvent::TryFreeEventIdAndCheckCanBeDelete(const int32_t id, bool isNeedDestroy)
{
    UNUSED(id);
    if (isNeedDestroy) {
        SetIsNeedDestroy(isNeedDestroy_.Value() || isNeedDestroy);
    }
    return isNeedDestroy_.Value() && (totalTaskCnt_ == 0U);
}

void IpcEvent::FreeMemForVaUse()
{
    if (currentHostMem_ == currentDeviceMem_) {  // create proc
        if (currentHostMem_ != nullptr) {
            if ((mapFlag_ & DEV_MEM_MAP_FLAG) != 0) {
                (void)NpuDriver::UnmapMem(currentDeviceMem_);
            }
            (void)NpuDriver::ReleaseMemAddress(currentDeviceMem_);
            currentDeviceMem_ = nullptr;
            currentHostMem_ = nullptr;
        }
    } else {
        if (currentHostMem_ != nullptr) {        // open pro
            if ((mapFlag_ & HOST_MEM_MAP_FLAG) != 0) {
                (void)NpuDriver::UnmapMem(currentHostMem_);
            }
                (void)NpuDriver::ReleaseMemAddress(currentHostMem_);
                currentHostMem_ = nullptr;
        }
        if (hostMemPa_ != nullptr) {
            (void)NpuDriver::FreePhysical(hostMemPa_);
            hostMemPa_ = nullptr;
        }
        if (currentDeviceMem_ != nullptr) {
            if ((mapFlag_ & DEV_MEM_MAP_FLAG) != 0) {
                (void)NpuDriver::UnmapMem(currentDeviceMem_);
            }
            (void)NpuDriver::ReleaseMemAddress(currentDeviceMem_);
            currentDeviceMem_ = nullptr;
        }
    }
}

rtError_t IpcEvent::ReleaseDrvResource()
{
    const std::lock_guard<std::mutex> lock(eventResLock_);
    NULL_PTR_RETURN_MSG(device_, RT_ERROR_INVALID_VALUE);
    NULL_PTR_RETURN_MSG(device_->Driver_(), RT_ERROR_INVALID_VALUE);
    FreeMemForVaUse();
    if (deviceMemPa_ != nullptr) {
        (void)NpuDriver::FreePhysical(deviceMemPa_);
        deviceMemPa_ = nullptr;
    }
    if (ipcHandleVa_ != nullptr) {
        if ((mapFlag_ & IPC_HANDLE_MAP_FLAG) != 0) {
            (void)NpuDriver::UnmapMem(ipcHandleVa_);
        }
        (void)NpuDriver::ReleaseMemAddress(ipcHandleVa_);
        ipcHandleVa_ = nullptr;
    }

    if (ipcHandlePa_ != nullptr) {
        (void)NpuDriver::FreePhysical(ipcHandlePa_);
        ipcHandlePa_ = nullptr;
    }
    return RT_ERROR_NONE;
}
} 
}