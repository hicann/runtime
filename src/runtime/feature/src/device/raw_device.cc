/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "raw_device.hpp"

#include <chrono>
#include "device.hpp"
#include "uma_arg_loader.hpp"
#include "runtime.hpp"
#include "ctrl_stream.hpp"
#include "tsch_stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "program.hpp"
#include "module.hpp"
#include "api.hpp"
#include "driver/ascend_hal.h"
#include "task.hpp"
#include "device/device_error_proc.hpp"
#include "error_message_manage.hpp"
#include "thread_local_container.hpp"
#include "aicpu_err_msg.hpp"
#include "dvpp_grp.hpp"
#include "task_info.hpp"
#include "task_submit.hpp"
#include "event.hpp"
#include "ctrl_res_pool.hpp"
#include "npu_driver_dcache_lock.hpp"
#include "stream_factory.hpp"
#include "arg_loader_ub.hpp"
#include "stub_task.hpp"
#include "dev_info_manage.h"
#include "soc_info.h"
#include "notify.hpp"
#include "capture_model.hpp"
#include "device_sq_cq_pool.hpp"
#include "sq_addr_memory_pool.hpp"
#include "printf.hpp"

namespace cce {
namespace runtime {
constexpr uint32_t FREE_EVENT_QUEUE_SIZE = 64U * 1024U;
constexpr size_t PRINT_FIFO_DEFAULT_BLOCK_SIZE = 1024U * 1024U;
constexpr uint32_t SQ_ID_MEM_POOL_INIT_COUNT = 1024U;
constexpr uint32_t SQ_ID_MEM_POOL_MAX_COUNT = 32U * 1024U; /* stream is 32k */
constexpr uint32_t WAIT_PRINTF_THREAD_TIME_MAX = 10U;

RawDevice::RawDevice(const uint32_t devId)
    : GroupDevice(),
      primaryStream_(nullptr),
      tsFftsDsaStream_(nullptr),
      ctrlStream_(nullptr),
      argLoader_(nullptr),
      ubArgLoader_(nullptr),
      modulesAllocator_(nullptr),
      deviceId_(devId),
      driver_(nullptr),
      engine_(nullptr),
      deviceStatus_(RT_ERROR_NONE),
      spmPool_(nullptr),
      eventPool_(nullptr),
      TTBR_(0U),
      SSID_(0U),
      TCR_(0U),
      l2buffer_(nullptr),
      platformConfig_(0U),
      platformType_(PLATFORM_END),
      onProfEnable_(false),
      tsId_(0U),
      taskFactory_(nullptr),
      kernelMemPoolMng_(nullptr),
      devProfStatus_(0U),
      streamSqCqManage_(nullptr),
      tschVersion_(0U),
      deviceErrorProc_(nullptr),
      errMsgObj_(nullptr),
      fastCqFlag_(true),
      dmaCpyUsedNum_(0U),
      phyChipId_(0),
      phyDieId_(0),
      sqVirtualArrBaseAddr_(nullptr),
      hcclStreamSize_(0U),
      noIndexHcclStmId(UINT32_MAX),
      isChipSupportRecycleThread_(false),
      isChipSupportEventThread_(false),
      lastUsagePoolTimeStamp_(mmGetTickCount()),
      simtStackPhyBase_(nullptr),
      simtStackPhyBaseAlign_(nullptr),
      eventExpandingPool_(nullptr),
      deviceSqCqPool_(nullptr),
      sqAddrMemoryOrder_(nullptr)
{
    const std::lock_guard<std::mutex> lk(GetHcclStreamIndexMutex());
    for (uint32_t i = 0; i < MAX_HCCL_STREAM_NUM; ++i) {
        hcclStream[i] = i;
    }

    captureModelExeInfoMap_.clear();
}

RawDevice::~RawDevice() noexcept
{
    DELETE_O(eventExpandingPool_);
    DELETE_O(deviceSqCqPool_);
    DELETE_O(sqAddrMemoryOrder_);
    DELETE_O(eventPool_); // need free all id, may send task.
    DeleteStream(ctrlStream_);
    DELETE_O(ctrlRes_);
    DeleteStream(primaryStream_);
    DeleteStream(tsFftsDsaStream_);
    DELETE_O(argLoader_);
    DELETE_O(ubArgLoader_);
    DELETE_O(spmPool_);
    DELETE_O(streamSqCqManage_);
    DELETE_O(kernelMemPoolMng_);
    DELETE_O(taskFactory_);
    DELETE_O(modulesAllocator_);
    DELETE_O(deviceErrorProc_);
    DELETE_O(errMsgObj_);
    DELETE_O(engine_);
    DELETE_O(deviceSnapshot_);
    DELETE_A(messageQueue_);
    DELETE_A(tschCapability_);
    DELETE_A(freeEvent_);
    DELETE_O(sqIdMemAddrPool_);
    if (driver_ != nullptr) {
        if (sqVirtualArrBaseAddr_ != nullptr) {
            (void)driver_->DevMemFree(sqVirtualArrBaseAddr_, deviceId_);
            sqVirtualArrBaseAddr_ = nullptr;
        }
        if (printfAddr_ != nullptr) {
            (void)driver_->DevMemFree(printfAddr_, deviceId_);
            printfAddr_ = nullptr;
        }
        (void)driver_->DeviceClose(deviceId_, tsId_);
        driver_ = nullptr;
    }
    dCacheLockFlag_ = false;
    exceptionRegMap_.clear();
    captureModelExeInfoMap_.clear();
}

rtError_t RawDevice::SetCurGroupInfo(void)
{
    rtError_t error = RT_ERROR_NONE;
    Context *ctx = nullptr;
    COND_RETURN_ERROR((GetDevRunningState() == static_cast<uint32_t>(DEV_RUNNING_DOWN)), RT_ERROR_DRV_ERR,
        "deviceId=%u is down", Id_());
 
    if (deviceErrorProc_ != nullptr) {
        error = deviceErrorProc_->SendTaskToStopUseRingBuffer();
        ERROR_RETURN(error, "Send stop ringbuffer task failed, retCode=%#x.", static_cast<uint32_t>(error));
    }

    if (primaryStream_ != nullptr) {
        ctx = primaryStream_->Context_();
        error = primaryStream_->TearDown();
        ERROR_RETURN(error, "Stream teardown failed, retCode=%#x.", static_cast<uint32_t>(error));
        DeleteStream(primaryStream_);
    }

    if (deviceErrorProc_ != nullptr) {
        error = deviceErrorProc_->DestroyDeviceRingBuffer();
        ERROR_RETURN(error, "Destroy ringbuffer failed, retCode=%#x.", static_cast<uint32_t>(error));
    }
    // 创建当前vf下的default stream，并设为当前设备的default stream
    primaryStream_ = StreamFactory::CreateStream(this, 0U,
        RT_STREAM_PRIMARY_FIRST_DEFAULT | RT_STREAM_PRIMARY_DEFAULT);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, primaryStream_ == nullptr, RT_ERROR_STREAM_NEW,
        "SetCurGroupInfo, new default stream failed");
    if (ctx != nullptr) {
        ctx->SetDefaultStream(primaryStream_);
    }

    error = primaryStream_->Setup();
    COND_PROC_RETURN_ERROR_MSG_INNER((error != RT_ERROR_NONE), error, DeleteStream(primaryStream_);,
        "Setup primary stream failed, errorcode = 0x%x.", static_cast<uint32_t>(error));

    RT_LOG(RT_LOG_INFO, "new primary Stream ok, Runtime_alloc_size %zu(bytes), stream_id=%d.",
        sizeof(Stream), primaryStream_->Id_());

    if (deviceErrorProc_ != nullptr) {
        error = deviceErrorProc_->CreateDeviceRingBufferAndSendTask();
        COND_PROC_RETURN_ERROR_MSG_INNER((error != RT_ERROR_NONE) && (error != RT_ERROR_DRV_MEMORY), error,
            DeleteStream(primaryStream_);,
            "Failed to create ring buffer, errorcode = 0x%x.", static_cast<uint32_t>(error));
    }
    return RT_ERROR_NONE;
}

rtError_t RawDevice::InitRawDriver()
{
    Runtime * const rt = Runtime::Instance();
    const driverType_t rawDrvType = rt->GetDriverType();
    Driver * const devDrv = rt->driverFactory_.GetDriver(rawDrvType);
    NULL_PTR_RETURN_MSG(devDrv, RT_ERROR_DRV_NULL);

    rtError_t error = devDrv->DeviceOpen(deviceId_, tsId_, &SSID_);
    ERROR_RETURN_MSG_INNER(error, "Failed to open device, retCode=%#x, deviceId=%u.",
                           static_cast<uint32_t>(error), deviceId_);

    // fix drvMemGetAttribute bug
    isDrvSupportUserMem_ = NpuDriver::CheckIsSupportFeature(deviceId_, 2); // 2 is FEATURE_SVM_GET_USER_MALLOC_ATTR

    driver_ = devDrv;
    return error;
}

rtError_t RawDevice::ResourceRestore()
{
    rtError_t ret = RT_ERROR_NONE;
    // ts ffts stream不在ctx上管理，需要随device恢复
    if (tsFftsDsaStream_ != nullptr) {
        ret = tsFftsDsaStream_->ReAllocStreamId();
        ERROR_RETURN(ret, "Realloc dsaStream id %d failed, deviceId=%u, ret=%#x.",
            tsFftsDsaStream_->Id_(), deviceId_, ret);
    }

    ret = GetStarsVersion();
    ERROR_RETURN(ret, "GetStarsVersion failed, ret=%#x, deviceId=%u", ret, deviceId_);

    if (deviceErrorProc_ != nullptr) {
        ret = deviceErrorProc_->RingBufferRestore();
    }
    ERROR_RETURN(ret, "RingBuffer restore failed, ret=%#x, deviceId=%u", ret, deviceId_);

    ret = TschStreamAllocDsaAddr();
    if (ret != RT_ERROR_NONE) {
        ret = TschStreamAllocDsaAddr();
    }
    ERROR_RETURN(ret, "TschStreamAllocDsaAddr failed, ret=%#x, deviceId=%u", ret, deviceId_);

    ret = Alloc32kStackAddrForDcache();
    ERROR_RETURN(ret, "Alloc32kStackAddrForDcache failed, ret=%#x, deviceId=%u", ret, deviceId_);

    Context *ctx = Runtime::Instance()->GetPriCtxByDeviceId(deviceId_, tsId_);
    CHECK_CONTEXT_VALID_WITH_RETURN(ctx, RT_ERROR_CONTEXT_NULL);
    ret = RegisterAndLaunchDcacheLockOp(ctx);
    ERROR_RETURN(ret, "RegisterAndLaunchDcacheLockOp failed, ret=%#x, deviceId=%u", ret, deviceId_);
    return RT_ERROR_NONE;
}

rtError_t RawDevice::ReOpen()
{
    rtError_t ret = driver_->HostDeviceClose(deviceId_);
    if (ret == RT_ERROR_DRV_NOT_SUPPORT) {
        return ret;
    }
    ERROR_RETURN(ret, "HostDeviceClose failed, ret=%#x, deviceId=%u", ret, deviceId_);

    // 重新拉起aicpu进程
    ret = Runtime::Instance()->StopAicpuExecutor(deviceId_, 0U, true);
    ERROR_RETURN(ret, "StopAicpuExecutor failed, ret=%#x, deviceId=%u", ret, deviceId_);
    ret = Runtime::Instance()->startAicpuExecutor(deviceId_, 0U);
    ERROR_RETURN(ret, "startAicpuExecutor failed, ret=%#x, deviceId=%u", ret, deviceId_);

    // halDeviceOpen接口和halDeviceClose接口同时提供，此处不需要再判断RT_ERROR_DRV_NOT_SUPPORT
    ret = driver_->DeviceOpen(deviceId_, tsId_, &SSID_);
    ERROR_RETURN(ret, "Failed to open device, ret=%#x, deviceId=%u.", ret, deviceId_);
    driver_->SetAllocNumaTsSupported();
    return RT_ERROR_NONE;
}

void RawDevice::PushEvent(Event *const evt)
{
    std::unique_lock<std::mutex> taskLock(eventLock_);
    events_.insert(evt);
}

void RawDevice::RemoveEvent(Event *const evt)
{
    std::unique_lock<std::mutex> l(eventLock_);
    events_.erase(evt);
}

rtError_t RawDevice::EventsReAllocId(void)
{
    std::unique_lock<std::mutex> l(eventLock_);
    for (Event *e : events_) {
        const rtError_t error = e->ReAllocId();
        ERROR_RETURN(error, "Realloc event id %d failed, retCode=%#x.", e->EventId_(), error);
    }

    if (IsSupportEventPool()) {
        const rtError_t error = eventPool_->EventIdReAlloc();
        ERROR_RETURN(error, "Reallocate event id failed, drv devId=%u, retCode=%#x.", deviceId_, error);
    }
    return RT_ERROR_NONE;
}

void RawDevice::PushNotify(Notify *const nty)
{
    std::unique_lock<std::mutex> l(notifyLock_);
    notifies_.insert(nty);
}

void RawDevice::RemoveNotify(Notify *const nty)
{
    std::unique_lock<std::mutex> l(notifyLock_);
    notifies_.erase(nty);
}

rtError_t RawDevice::NotifiesReAllocId(void)
{
    std::unique_lock<std::mutex> l(notifyLock_);
    for (Notify *n : notifies_) {
        const rtError_t error = n->ReAllocId();
        ERROR_RETURN(error, "Realloc notify id %u failed, retCode=%#x.", n->GetNotifyId(), error);
    }
    return RT_ERROR_NONE;
}

rtError_t RawDevice::InitStreamSyncEsched() const
{
    Runtime * const rt = Runtime::Instance();

    if (rt->IsStreamSyncEsched()) {
        uint32_t grpId = UINT32_MAX;
        rtError_t error = NpuDriver::EschedAttachDevice(deviceId_);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
        error = NpuDriver::EschedCreateGrpEx(deviceId_, STMSYNC_ESCHED_MAX_THREAD_NUM, &grpId);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
        rt->SetStreamSyncEschedGrpID(grpId);
        RT_LOG(RT_LOG_INFO, "SetStreamSyncEsched GrpID=%u.", grpId);
    }
    return RT_ERROR_NONE;
}

rtError_t RawDevice::InitTsdQos()
{
    Runtime * const rt = Runtime::Instance();

    const rtError_t error = rt->GetTsdQos(deviceId_, tsdQos_);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "get tsd qos failed, device_id=%u", deviceId_);
    }
    return RT_ERROR_NONE;
}

bool RawDevice::CheckCanFreeModulesPool(uint32_t poolIdx)
{
    const uint32_t baseId = modulesAllocator_->AccumulatePoolCount(poolIdx);
    for (uint32_t index = baseId; index < baseId + DEFAULT_PROGRAM_NUMBER; index++) {
        RefObject<Module *> * const refObj = modulesAllocator_->GetDataToItemApplied(index);
        if (refObj == nullptr) {
            return false;
        }
        const uint64_t refObjValue = refObj->GetRef();
        if (refObjValue != 0U) {
            return false;
        }
    }
    return true;
}

void RawDevice::TryToRecycleModulesPool(uint32_t latestPoolIdx)
{
    if (modulesAllocator_ == nullptr) {
        return;
    }

    RefObject<Module *> **pool = modulesAllocator_->GetObjAllocatorPool();
    if (pool == nullptr) {
        return;
    }

    std::mutex *mdlMtx = modulesAllocator_->GetObjAllocatorMutex();
    if (mdlMtx == nullptr) {
        return;
    }

    RT_LOG(RT_LOG_EVENT, "recycle raw dev pool");
    const uint32_t poolNum = Runtime::maxProgramNum_ / DEFAULT_PROGRAM_NUMBER;
    const uint32_t newStartPoolIdx = latestPoolIdx + RECYCLE_POOL_ISOLATION_WIDTH;
    const uint32_t newEndPoolIdx = newStartPoolIdx + poolNum - 1U;
    for (uint32_t idx = newStartPoolIdx; idx <= newEndPoolIdx; idx++) {
        const uint32_t i = idx % poolNum;
        if (pool[i] == nullptr) {
            continue;
        }

        mdlMtx[i].lock();
        if (CheckCanFreeModulesPool(i) == true) {
            modulesAllocator_->RecyclePool(i);
        }
        mdlMtx[i].unlock();
    }
    return;
}

rtError_t RawDevice::RegisterDcacheLockOp(Program *&dcacheLockOpProgram)
{
    Runtime *rtInstance = Runtime::Instance();
    NULL_PTR_RETURN_MSG(rtInstance, RT_ERROR_INSTANCE_NULL);
    const std::vector<char> &dcacheLockMixOpData = rtInstance->GetDcacheLockMixOpData();
    if (dcacheLockMixOpData.size() == 0) {
        // 对于在device侧发生SetDevice的逻辑时候，device侧并没有算子.o文件
        RT_LOG(RT_LOG_WARNING, "dcacheLockMixOpData size is zero, so not enable dcache");
        return RT_ERROR_NONE;
    }

    rtDevBinary_t devBinInfo = {};
    devBinInfo.magic = RT_DEV_BINARY_MAGIC_ELF;
    devBinInfo.data = static_cast<const void *>(dcacheLockMixOpData.data());
    devBinInfo.length = dcacheLockMixOpData.size();

    rtError_t error = rtInstance->ProgramRegister(&devBinInfo, &dcacheLockOpProgram);
    if (error != RT_ERROR_NONE || dcacheLockOpProgram == nullptr) {
        RT_LOG(RT_LOG_ERROR, "register program failed, retCode=%#x", error);
        return error;
    }

    dcacheLockOpProgram->SetIsDcacheLockOp(true);
    void *funcAddr = static_cast<void *>(dcacheLockOpProgram);
    const std::string dcacheLockMixFuncName = "preload_stack_16KB";
    const std::string dcacheLockMixOpName = "preload_stack_16KB";

    error = rtInstance->KernelRegister(
        dcacheLockOpProgram, funcAddr, dcacheLockMixFuncName.c_str(), dcacheLockMixOpName.c_str(), 0);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "dcache lock op register program failed, retCode=%#x", error);
    }
    return error;
}

rtError_t RawDevice::RegisterAndLaunchDcacheLockOp(Context *ctx)
{
    if (!IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_DCACHE_LOCK)) {
        RT_LOG(RT_LOG_INFO, "dcache lock not support on type=%u.", GetChipType());
        return RT_ERROR_NONE;
    }

    if(!CheckFeatureSupport(TS_FEATURE_DCACHE_LOCK)) {
        RT_LOG(RT_LOG_INFO, "Current device does not support dcache lock.");
        return RT_ERROR_NONE;
    }

    if (dCacheLockFlag_ || !stackAddrIsDcache_) {
        RT_LOG(RT_LOG_INFO,
            "dcache lock has been set or stack addr is not for dcache, dCacheLockFlag_=%d, stackAddrIsDcache_=%d.",
            dCacheLockFlag_,
            stackAddrIsDcache_);
        return RT_ERROR_NONE;
    }

    (void)QueryDcacheLockStatus(deviceId_, tsId_, stackPhyBase32k_, dCacheLockFlag_);

    if (dCacheLockFlag_) {
        RT_LOG(RT_LOG_INFO, "dcache lock has been set.");
        return RT_ERROR_NONE;
    }

    Program *dcacheLockOpProgram = nullptr;
    rtError_t error = RegisterDcacheLockOp(dcacheLockOpProgram);
    if (error != RT_ERROR_NONE || dcacheLockOpProgram == nullptr) {
        return error;
    }

    void *funcAddr = static_cast<void *>(dcacheLockOpProgram);
    int64_t blockDim = 0;
    error = driver_->GetDevInfo(deviceId_, MODULE_TYPE_AICORE, INFO_TYPE_CORE_NUM, &blockDim);
    ERROR_RETURN(error, "get device core num failed, retCode=%#x, blockDim=%lld", error, blockDim);
    RT_LOG(RT_LOG_DEBUG, "get device core num success, blockDim=%lld", blockDim);
    error = DcacheLockSendTask(ctx, static_cast<uint32_t>(blockDim), funcAddr, primaryStream_);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "launch kernel failed, retCode=%#x", error);
        return error;
    }

    error = primaryStream_->Synchronize(false, 600000);  // 600000 : 10 mins
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "stream Synchronize failed, retCode=%#x", error);
        return error;
    }

    dCacheLockFlag_ = true;
    // 释放dcacheLockOpProgram
    dcacheLockOpProgram->Dereference();
    dcacheLockOpProgram->SetUnRegisteringFlag();
    Runtime::Instance()->PutProgram(dcacheLockOpProgram, true);
    RT_LOG(RT_LOG_EVENT, "Launch dcache lock op success, blockDim=%lld.", blockDim);
    return RT_ERROR_NONE;
}

bool RawDevice::IsSupportFeature(RtOptionalFeatureType f) const
{
    return (featureSet_.find(f) != featureSet_.end());
}

rtError_t RawDevice::Init()
{
    rtError_t error = InitRawDriver();
    ERROR_RETURN_MSG_INNER(error, "Failed to init RawDriver, device_id=%u, retCode=%#x",
        deviceId_, static_cast<uint32_t>(error));

    error = InitStreamSyncEsched();
    ERROR_RETURN_MSG_INNER(error, "Failed to init StreamSyncEsched, retCode=%#x", static_cast<uint32_t>(error));

    const rtChipType_t chipType = Runtime::Instance()->GetChipType();

    error = GET_CHIP_FEATURE_SET(chipType, featureSet_);
    ERROR_RETURN_MSG_INNER(error, "Failed to get feature, chipType=%d, device_id=%u, retCode=%#x", chipType,
        deviceId_, static_cast<uint32_t>(error));

    error = GET_DEV_PROPERTIES(chipType, properties_);
    ERROR_RETURN_MSG_INNER(error, "Failed to get properties, chipType=%d, device_id=%u, retCode=%#x", chipType,
        deviceId_, static_cast<uint32_t>(error));

    if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_OVERFLOW_MODE)) {
        SetSatMode(RT_OVERFLOW_MODE_INFNAN);
    }

    RT_LOG(RT_LOG_INFO, "chipType:%#x", chipType);
    chipDieOffset = RT_DIE_ADDR_OFFSET_1T;
    chipOffset = RT_CHIP_ADDR_OFFSET_8T;
    chipBaseAddr = 0ULL;
    starsRegBaseAddr_ = 0ULL;

    int64_t isAddrFlat = 0LL;
    (void)driver_->GetDevInfo(deviceId_, MODULE_TYPE_SYSTEM, INFO_TYPE_ADDR_MODE, &isAddrFlat);
    g_isAddrFlatDevice = (isAddrFlat != 0LL);
    if (g_isAddrFlatDevice) {
        chipBaseAddr = RT_CHIP_BASE_ADDR;
        chipOffset = RT_HCCS_CHIP_ADDR_OFFSET_2T;
    }
    RT_LOG(RT_LOG_EVENT, "isAddrFlat:%#x", isAddrFlat);

    if (GetDevProperties().starsBaseMethod == StarsBaseMethod::STARS_BASE_CALCULATE_BY_DRIVER) {
        error = driver_->GetStarsInfo(deviceId_, tsId_, starsRegBaseAddr_);
        RT_LOG(RT_LOG_INFO, "starsRegBaseAddr_=0x%llx.", starsRegBaseAddr_);       
        ERROR_RETURN_MSG_INNER(error, "Failed to get stars info, retCode=%#x, deviceId=%u.",
                               static_cast<uint32_t>(error), deviceId_);
        int64_t dieNum = 0;
        error = driver_->GetDevInfo(deviceId_, MODULE_TYPE_AICORE, INFO_TYPE_DIE_NUM, &dieNum);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "Get Ddie_die_num failed!, device_id=%u, module type=%d, info type=%d.", 
                deviceId_, MODULE_TYPE_AICORE, INFO_TYPE_DIE_NUM);
        }
        starsv2DieNum_ = static_cast<uint8_t>(dieNum);
        RT_LOG(RT_LOG_INFO, "Ddie_die_num=%hhu", starsv2DieNum_);
    }
    // get runMode to runMode_
    uint32_t runMode = driver_->GetRunMode();
    SetRunMode(runMode);
    
    int64_t hardwareVersion = 0;
    error = GetHardVerBySocVer(deviceId_, hardwareVersion);
    ERROR_GOTO_MSG_INNER(error, L2_FREE, "Failed to get device info, device id=%u.", deviceId_);
    RT_LOG(RT_LOG_INFO, "GetDevInfo, device_id=%u, hardwareVersion=%#x.", deviceId_, hardwareVersion);
    driver_->SetAllocNumaTsSupported();

    platformConfig_ = static_cast<uint32_t>(hardwareVersion);
    platformType_ = Runtime::Instance()->Config_()->GetPlatformTypeByConfig(platformConfig_);
    if (platformType_ == PLATFORM_END) {
        RT_LOG(RT_LOG_WARNING, "fail to get platform type, platformConfig_ = 0x%x", platformConfig_);
    }
    GlobalContainer::SetHardwareChipType(GetChipType());
    halCapabilityInfo capabilityInfo;
    error = driver_->GetChipCapability(deviceId_, &capabilityInfo);
    ERROR_GOTO_MSG_INNER(error, L2_FREE, "Failed to init dev capability, retCode=%#x, deviceId=%u.",
                         static_cast<uint32_t>(error), deviceId_);
    devCapInfo_.sdma_reduce_support = capabilityInfo.sdma_reduce_support;
    devCapInfo_.memory_support = capabilityInfo.memory_support;
    devCapInfo_.ts_group_number = capabilityInfo.ts_group_number;
    devCapInfo_.sdma_reduce_kind = capabilityInfo.sdma_reduce_kind;

    if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_GROUP_DOT_RECORD_GROUPINFO) ||
        IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_GROUP_THREAD_LOCAL)) {
        error = GroupInfoSetup();
        ERROR_GOTO_MSG_INNER(error, L2_FREE, "Failed to get group info");
        driver_->vfId_ = GetVfId();
    }

    if (IsStarsPlatform()) {
        error = AllocMemForSqVirtualArr();
        ERROR_GOTO_MSG_INNER(error, SQ_VIRTUAL_ADDR_FREE, "AllocMemForSqVirtualArr failed, retCode=%#x!",
                             static_cast<uint32_t>(error));
        error = Driver_()->GetDevInfo(deviceId_, static_cast<int32_t>(MODULE_TYPE_SYSTEM),
                                      static_cast<int32_t>(INFO_TYPE_PHY_CHIP_ID), &phyChipId_);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "Get phy chip failed!, device_id=%u", deviceId_);
        }

        error = Driver_()->GetDevInfo(deviceId_, static_cast<int32_t>(MODULE_TYPE_SYSTEM),
                                      static_cast<int32_t>(INFO_TYPE_PHY_DIE_ID), &phyDieId_);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "Get phy die id failed!, device_id=%u", deviceId_);
        }
        RT_LOG(RT_LOG_INFO, "Get phy info, phy chip id %" PRId64 ", phy die id %" PRId64, phyChipId_, phyDieId_);
        (void)InitTsdQos();
        Runtime::Instance()->SetDisableThread(true);
    }

    engine_ = EngineFactory::CreateEngine(chipType, this);
    COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, engine_ == nullptr, SQ_VIRTUAL_ADDR_FREE, error,
                                        RT_ERROR_MEMORY_ALLOCATION, "New memory for engine_ failed.");

    if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_SPM_POOL)) {
        spmPool_ = new (std::nothrow) SpmPool(this);
        COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, spmPool_ == nullptr, ENGINE_FREE, error,
                                            RT_ERROR_MEMORY_ALLOCATION, "New memory for spmPool_ failed.");
        RT_LOG(RT_LOG_INFO, "new SpmPool ok, Runtime_alloc_size %zu(bytes)", sizeof(SpmPool));

        error = spmPool_->Init();
        ERROR_GOTO_MSG_INNER(error, SPM_FREE, "Failed to init spm pool, retCode=%#x.", static_cast<uint32_t>(error));
    } else {
        RT_LOG(RT_LOG_INFO, "Not support spm.");
    }
    if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_EVENT_POOL) &&
        (runMode == RT_RUN_MODE_ONLINE)) {
        eventPool_ = new (std::nothrow) EventPool(this, tsId_);
        COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, eventPool_ == nullptr, SPM_FREE, error,
                                            RT_ERROR_MEMORY_ALLOCATION, "new eventPool failed.");
    }

    if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DFX_PROCESS_SNAPSHOT)) {
        deviceSnapshot_ = new (std::nothrow) DeviceSnapshot(this);
        COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, deviceSnapshot_ == nullptr, EVENT_FREE,
            error, RT_ERROR_MEMORY_ALLOCATION, "New memory for deviceSnapshot_ failed.");
    }

    if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_VALUE_WAIT)) {
        eventExpandingPool_ = new (std::nothrow) EventExpandingPool(this);
        COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, eventExpandingPool_ == nullptr, SNAPSHOT_FREE, error,
                                            RT_ERROR_MEMORY_ALLOCATION, "new eventPool failed.");
    }

    argLoader_ = new (std::nothrow) UmaArgLoader(this);
    COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, argLoader_ == nullptr, EVENT_EXE_FREE, error,
                                        RT_ERROR_MEMORY_ALLOCATION, "New UmaArgLoader failed.");
    RT_LOG(RT_LOG_INFO, "new UmaArgLoader ok, Runtime_alloc_size %zu(bytes)", sizeof(UmaArgLoader));

    error = argLoader_->Init();
    ERROR_GOTO_MSG_INNER(error, LOADER_FREE, "Failed to init argLoader, retCode=%#x.", static_cast<uint32_t>(error));

    error = UbArgLoaderInit();
    ERROR_GOTO_MSG_INNER(error, LOADER_FREE, "Failed to init ubArgLoader, retCode=%#x.",
            static_cast<uint32_t>(error));

    streamSqCqManage_ = new (std::nothrow) StreamSqCqManage(this);
    COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, streamSqCqManage_ == nullptr, LOADER_FREE, error,
                                        RT_ERROR_MEMORY_ALLOCATION, "New StreamSqCqManage failed.");
    RT_LOG(RT_LOG_INFO, "new StreamSqCqManage ok, Runtime_alloc_size %zu(bytes)", sizeof(StreamSqCqManage));

    taskFactory_ = new (std::nothrow) TaskFactory(this);
    COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, taskFactory_ == nullptr, STREAM_TABLE_FREE, error,
                                        RT_ERROR_MEMORY_ALLOCATION, "New TaskFactory failed.");
    RT_LOG(RT_LOG_INFO, "New taskFactory ok, Runtime_alloc_size %zu(bytes)", sizeof(TaskFactory));

    error = taskFactory_->Init();
    ERROR_GOTO_MSG_INNER(error, TASK_FACTORY_FREE, "Fail to init task factory, retCode=%#x.",
                         static_cast<uint32_t>(error));

    kernelMemPoolMng_ = new (std::nothrow) MemoryPoolManager(this);
    COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, kernelMemPoolMng_ == nullptr, TASK_FACTORY_FREE, error,
                                        RT_ERROR_MEMORY_ALLOCATION, "New MemoryPoolManager failed.");
    if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_KERNEL_MEMORY_POOL)) {
        error = kernelMemPoolMng_->Init();
        ERROR_GOTO_MSG_INNER(error, KERNEL_POOL_FREE, "Fail to init MemoryPoolManager, retCode=%#x.",
                            static_cast<uint32_t>(error));
    }

    modulesAllocator_ = new (std::nothrow) ObjAllocator<RefObject<Module *>>(DEFAULT_PROGRAM_NUMBER,
                                                                             Runtime::maxProgramNum_);
    COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, modulesAllocator_ == nullptr, KERNEL_POOL_FREE,
                                        error, RT_ERROR_MODULE_NEW,
                                        "Init raw device failed, new ObjAllocator failed.");

    error = modulesAllocator_->Init();
    ERROR_GOTO_MSG_INNER(error, MODULES_ALLOC_FREE,
                         "Init raw device failed, init moduleAllocator_ failed, retCode=%#x.",
                         static_cast<uint32_t>(error));

    deviceSqCqPool_ = new (std::nothrow) DeviceSqCqPool(this);
    COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, deviceSqCqPool_ == nullptr, MODULES_ALLOC_FREE, error,
                                        RT_ERROR_MEMORY_ALLOCATION, "New DeviceSqCqPool failed.");
    RT_LOG(RT_LOG_INFO, "new DeviceSqCqPool ok, Runtime_alloc_size %zu(bytes)", sizeof(DeviceSqCqPool));
    error = deviceSqCqPool_->Init();
    ERROR_GOTO_MSG_INNER(error, DEVICE_SQ_CQ_FREE,
                         "Init raw device failed, init deviceSqCqPool_ failed, retCode=%#x.",
                         static_cast<uint32_t>(error));

    sqAddrMemoryOrder_ = new (std::nothrow) SqAddrMemoryOrder(this);
    COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, sqAddrMemoryOrder_ == nullptr, DEVICE_SQ_CQ_FREE, error,
                                        RT_ERROR_MEMORY_ALLOCATION, "New SqAddrMemoryOrder failed.");
    RT_LOG(RT_LOG_INFO, "new SqAddrMemoryOrder ok, Runtime_alloc_size %zu(bytes)", sizeof(SqAddrMemoryOrder));
    error = sqAddrMemoryOrder_->Init();
    ERROR_GOTO_MSG_INNER(error, SQ_ADDR_MEMORY_FREE,
                         "Init raw device failed, init sqAddrMemoryOrder_ failed, retCode=%#x.",
                         static_cast<uint32_t>(error));

    RT_LOG(RT_LOG_INFO, "Runtime_alloc_size=%zu(bytes)",
           sizeof(RefObject<Module *>) * DEFAULT_PROGRAM_NUMBER);

    CreateMessageQueue();
    CreateFreeEventQueue();
    isSupportStopOnStreamError_ = IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DFX_STOP_ON_STREAM_ERROR);
    return RT_ERROR_NONE;

SQ_ADDR_MEMORY_FREE:
    DELETE_O(sqAddrMemoryOrder_);
DEVICE_SQ_CQ_FREE:
    DELETE_O(deviceSqCqPool_);
MODULES_ALLOC_FREE:
    DELETE_O(modulesAllocator_);
KERNEL_POOL_FREE:
    DELETE_O(kernelMemPoolMng_);
TASK_FACTORY_FREE:
    DELETE_O(taskFactory_);
STREAM_TABLE_FREE:
    DELETE_O(streamSqCqManage_);
LOADER_FREE:
    DELETE_O(argLoader_);
    DELETE_O(ubArgLoader_);
EVENT_EXE_FREE:
    DELETE_O(eventExpandingPool_);
SNAPSHOT_FREE:
    DELETE_O(deviceSnapshot_);
EVENT_FREE:
    DELETE_O(eventPool_);
SPM_FREE:
    DELETE_O(spmPool_);
ENGINE_FREE:
    DELETE_O(engine_);
SQ_VIRTUAL_ADDR_FREE:
    if (sqVirtualArrBaseAddr_ != nullptr) {
        (void)driver_->DevMemFree(sqVirtualArrBaseAddr_, deviceId_);
        sqVirtualArrBaseAddr_ = nullptr;
    }
L2_FREE:
    (void)driver_->DeviceClose(deviceId_, tsId_);
    driver_ = nullptr;
    return error;
}

rtError_t RawDevice::Alloc32kStackAddrForDcache()
{
    rtError_t error = AllocAddrForDcache(deviceId_, stackPhyBase32k_, RT_SCALAR_BUFFER_SIZE_32K_75,
        drvMemCtrlHandle_);
    if (error != RT_ERROR_NONE) {
        error = driver_->DevMemAlloc(&stackPhyBase32k_, RT_SCALAR_BUFFER_SIZE_32K_75, RT_MEMORY_DDR, Id_());
        COND_RETURN_ERROR((error != RT_ERROR_NONE) || (stackPhyBase32k_ == nullptr),
            error, "Alloc stack phy base failed, mem alloc failed, retCode=%#x.", static_cast<uint32_t>(error));
    }
    stackPhyBase32kAlign_ = stackPhyBase32k_;
    return RT_ERROR_NONE;
}

rtError_t RawDevice::AllocStackPhyAddrForDcache()
{
    if (stackAddrIsDcache_) {
        RT_LOG(RT_LOG_INFO, "stackAddrIsDcache_ is true, no need to alloc.");
        return RT_ERROR_NONE;
    }

    rtError_t error = AllocAddrForDcache(deviceId_, stackPhyBase32k_, RT_SCALAR_BUFFER_SIZE_32K_75,
        drvMemCtrlHandle_);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    // alloc 16k stack for aic/aiv
    if (stackPhyBase16k_ != nullptr) {
        RT_LOG(RT_LOG_INFO, "16k stack buffer has been allocated");
        return RT_ERROR_NONE;
    }

    constexpr uint64_t stackPhySize = static_cast<uint64_t>(RT_SCALAR_BUFFER_SIZE_16K_75);
    error = driver_->DevMemAlloc(&stackPhyBase16k_, stackPhySize, RT_MEMORY_DDR, deviceId_);
    if ((error != RT_ERROR_NONE) || (stackPhyBase16k_ == nullptr)) {
        FreeDcacheAddr(deviceId_, stackPhyBase32k_, drvMemCtrlHandle_);
        stackPhyBase32k_ = nullptr;
        RT_LOG(RT_LOG_ERROR, "Alloc stack phy base failed, mem alloc failed, retCode=%#x.",
            static_cast<uint32_t>(error));
        return error;
    }

    RT_LOG(RT_LOG_DEBUG,
        "AllocStackPhyBase device_id=%u, stackPhyBase16k_=0x%llx, stackPhySize=%u.",
        deviceId_,
        RtPtrToValue(stackPhyBase16k_),
        stackPhySize);
    stackAddrIsDcache_ = true;
    stackPhyBase32kAlign_ = stackPhyBase32k_;
    return RT_ERROR_NONE;
}

rtError_t RawDevice::AllocStackPhyBaseForCloudV2()
{
    const rtError_t ret = AllocStackPhyAddrForDcache();
    if (ret == RT_ERROR_NONE) {
        return RT_ERROR_NONE;
    }
    uint64_t stackPhySize = RT_SCALAR_BUFFER_SIZE_32K_75;
    rtError_t error = driver_->DevMemAlloc(&stackPhyBase32k_, stackPhySize, RT_MEMORY_DDR, Id_());
    COND_RETURN_ERROR((error != RT_ERROR_NONE) || (stackPhyBase32k_ == nullptr),
        error, "Alloc stack phy base failed, mem alloc failed, retCode=%#x.", static_cast<uint32_t>(error));
    RT_LOG(RT_LOG_INFO, "device_id=%u, stackPhyBase32k_=0x%llx, stackPhySize=%u.", Id_(),
        RtPtrToValue(stackPhyBase32k_), stackPhySize);
    stackPhyBase32kAlign_ = stackPhyBase32k_;
    // alloc 16k stack for aic/aiv
    if (stackPhyBase16k_ != nullptr) {
        RT_LOG(RT_LOG_WARNING, "16k stack buffer has been allocated");
        return RT_ERROR_NONE;
    }
    stackPhySize = static_cast<uint64_t>(RT_SCALAR_BUFFER_SIZE_16K_75);
    error = driver_->DevMemAlloc(&stackPhyBase16k_, stackPhySize, RT_MEMORY_DDR, Id_());
    RT_LOG(RT_LOG_DEBUG,
        "AllocStackPhyBase device_id=%u, stackPhyBase16k_=0x%llx, stackPhySize=%u.",
        Id_(), RtPtrToValue(stackPhyBase16k_), stackPhySize);
    if ((error != RT_ERROR_NONE) || (stackPhyBase16k_ == nullptr)) {
        (void)driver_->DevMemFree(stackPhyBase32k_, Id_());
        stackPhyBase32k_ = nullptr;
        RT_LOG(RT_LOG_ERROR, "Alloc stack phy base failed, mem alloc failed, retCode=%#x.",
            static_cast<uint32_t>(error));
        return error;
    }
    return RT_ERROR_NONE;
}

rtError_t RawDevice::AllocStackPhyBase()
{
    if (stackPhyBase32k_ != nullptr) {
        RT_LOG(RT_LOG_INFO, "32k stack buffer has been allocated");
        return RT_ERROR_NONE;
    }

    if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_DCACHE_LOCK_DOT_ALLOC_STACK)) {
        if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_16K_STACK)) {
            return AllocStackPhyBaseForCloudV2();
        }
        return AllocStackPhyBaseStarsV2();
    }

    const uint64_t stackPhySize = GetDevProperties().stackPhyBase;

    const rtError_t error = driver_->DevMemAlloc(&stackPhyBase32k_, stackPhySize, RT_MEMORY_DDR, Id_());
    RT_LOG(RT_LOG_INFO,
        "AllocStackPhyBase device_id=%u, stackPhyBase32k_=0x%llx, stackPhySize=%u.",
        Id_(),
        RtPtrToValue(stackPhyBase32k_),
        stackPhySize);
    COND_RETURN_ERROR((error != RT_ERROR_NONE) || (stackPhyBase32k_ == nullptr),
        error,
        "Alloc stack phy base failed, mem alloc failed, retCode=%#x.",
        static_cast<uint32_t>(error));

    stackPhyBase32kAlign_ = stackPhyBase32k_;
    return RT_ERROR_NONE;
}

rtError_t RawDevice::AllocCustomerStackPhyBase()
{
    Runtime *rt = Runtime::Instance();
    const uint32_t customerStackSize = rt->GetDeviceCustomerStackSize();
    if (likely(customerStackSize == KERNEL_STACK_SIZE_32K)) {
        RT_LOG(RT_LOG_INFO, "drv devId=%u, customerStackSize=%u, not alloc", deviceId_, customerStackSize);
        return RT_ERROR_NONE;
    }

    auto props = GetDevProperties();
    COND_RETURN_ERROR(customerStackSize > props.maxCustomerStackSize,
            RT_ERROR_INVALID_VALUE,
            "Custom stack size is larger than max stack size, chipType=%u, custom stack size=%u, max stack size=%u.",
            rt->GetChipType(), customerStackSize, props.maxCustomerStackSize);

    const uint64_t totalCoreNum = static_cast<uint64_t>(props.aicNum + props.aivNum);
    const uint64_t stackPhySize = totalCoreNum * customerStackSize;

    const rtError_t error = driver_->DevMemAlloc(&customerStackPhyBase_, stackPhySize, RT_MEMORY_DDR, Id_());
    COND_RETURN_ERROR((error != RT_ERROR_NONE) || (customerStackPhyBase_ == nullptr),
        error,
        "Alloc customer stack memory failed, retCode=%#x, totalCoreNum=%#" PRIx64 ", customerAiCoreStackSize=%u(bytes), "
        "stackPhySize=%#" PRIx64 ".",
        static_cast<uint32_t>(error),
        totalCoreNum,
        customerStackSize,
        stackPhySize);
 
    RT_LOG(RT_LOG_INFO,
        "device_id=%u, customerStackPhyBase_=%p, stackPhySize=%#" PRIx64 ".",
        Id_(),
        customerStackPhyBase_,
        stackPhySize);
    deviceAllocStackSize_ = customerStackSize;
    SetDeviceCustomerStackLevel(customerStackSize);
    return RT_ERROR_NONE;
}

void RawDevice::FreeStackPhyBase()
{
    RT_LOG(RT_LOG_DEBUG, "FreeStackPhyBase drv devId=%u, stackPhyBase32k_=%p, drvMemCtrlHandle_=%p, stackAddrIsDcache_=%u.",
        deviceId_, stackPhyBase32k_, drvMemCtrlHandle_, stackAddrIsDcache_);
    if (stackPhyBase32k_ != nullptr) {
        if (stackAddrIsDcache_) {
            FreeDcacheAddr(deviceId_, stackPhyBase32k_, drvMemCtrlHandle_);
            stackAddrIsDcache_ = false;
        } else {
            (void)driver_->DevMemFree(stackPhyBase32k_, deviceId_);
        }
        stackPhyBase32k_ = nullptr;
        drvMemCtrlHandle_ = nullptr;
    }

    if (stackPhyBase16k_ != nullptr) {
        (void)driver_->DevMemFree(stackPhyBase16k_, deviceId_);
        stackPhyBase16k_ = nullptr;
    }
    RT_LOG(RT_LOG_DEBUG, "FreeStackPhyBase drv devId=%u", deviceId_);
}

void RawDevice::FreeCustomerStackPhyBase()
{
    if (customerStackPhyBase_ != nullptr) {
        (void)driver_->DevMemFree(customerStackPhyBase_, deviceId_);
        customerStackPhyBase_ = nullptr;
    }
}

rtError_t RawDevice::Start()
{
    COND_RETURN_INFO(primaryStream_ != nullptr, RT_ERROR_NONE, "there has primaryStream");
    rtError_t error = AllocSimtStackPhyBase(GetChipType());
    ERROR_RETURN(error, "Alloc simt stack phy base failed, retCode=%#x.", static_cast<uint32_t>(error));

    primaryStream_ = StreamFactory::CreateStream(this, 0U,
        RT_STREAM_PRIMARY_FIRST_DEFAULT | RT_STREAM_PRIMARY_DEFAULT);
    COND_PROC_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, primaryStream_ == nullptr, RT_ERROR_STREAM_NEW,
        static_cast<void>(FreeSimtStackPhyBase()), "Start raw device failed, new stream failed.");
    error = primaryStream_->Setup();
    if (error != RT_ERROR_NONE) {
        DeleteStream(primaryStream_);
        static_cast<void>(FreeSimtStackPhyBase());
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Setup primary stream failed.");
        return error;
    }

    RT_LOG(RT_LOG_INFO, "new primary Stream ok, Runtime_alloc_size %zu(bytes), stream_id=%d.",
        sizeof(Stream), primaryStream_->Id_());

    error = TschStreamSetup();
    ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Setup tsch stream failed, retCode=%#x.", static_cast<uint32_t>(error));

    if (IsStarsPlatform()) {
        error = AllocStackPhyBase();
        ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "alloc stack phy failed, retCode=%#x.", static_cast<uint32_t>(error));
        error = AllocCustomerStackPhyBase();
        ERROR_GOTO_MSG_INNER(
            error, ERROR_FREE, "alloc customer stack phy failed, retCode=%#x.", static_cast<uint32_t>(error));
    }

    error = engine_->Start();
    ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Start runtime engine failed, retCode=%#x.", static_cast<uint32_t>(error));

    error = GetStarsVersion();
    ERROR_GOTO_MSG_INNER(error, ERROR_STOP, "Get Stars version failed, retCode=%#x.", static_cast<uint32_t>(error));

    RT_LOG(RT_LOG_INFO, "Get TschVersion, tschVersion=%u.", GetTschVersion());

    if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_FFTS_PLUS)) {
        uint32_t len = 0U;
        error = driver_->GetC2cCtrlAddr(static_cast<int32_t>(deviceId_), &interCoreSyncAddr_, &len);
    }

    InitResource();

#ifndef CFG_DEV_PLATFORM_PC
    if (GetDevProperties().ringbufSize != 0) {
        deviceErrorProc_ = new (std::nothrow) DeviceErrorProc(this, GetDevProperties().ringbufSize);
        COND_PROC_GOTO_MSG_CALL(ERR_MODULE_SYSTEM, deviceErrorProc_ == nullptr, ERROR_STOP,
                                error = RT_ERROR_MEMORY_ALLOCATION;,
                                "Start raw device failed, new DeviceErrorProc failed.");
        error = deviceErrorProc_->CreateDeviceRingBufferAndSendTask();
        COND_PROC_GOTO_MSG_INNER((error != RT_ERROR_NONE) && (error != RT_ERROR_DRV_MEMORY), ERROR_STOP, ;,
            "Failed to create ring buffer, error_code=%#x.", static_cast<uint32_t>(error));
        error = deviceErrorProc_->CreateFastRingbuffer();
        COND_PROC_GOTO_MSG_INNER((error != RT_ERROR_NONE) && (error != RT_ERROR_DRV_MEMORY), ERROR_STOP, ;,
            "Failed to create fast ring buffer, error_code=%#x.", static_cast<uint32_t>(error));
    }
    if (!IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_AICPUSD_LATER_PROCEDURE)) {
        error = SendTopicMsgVersionToAicpu();
        ERROR_GOTO_MSG_INNER(error, ERROR_STOP, "send topic msg version to aicpu failed, retCode=%#x.", static_cast<uint32_t>(error));
    }

    if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DFX_AICPU_ERROR_MESSAGE)) {
        errMsgObj_ = new (std::nothrow) AicpuErrMsg(this);
        COND_PROC_GOTO_MSG_CALL(ERR_MODULE_SYSTEM, errMsgObj_ == nullptr, ERROR_STOP,
                                error = RT_ERROR_MEMORY_ALLOCATION;,
                                "Start raw device failed, new errMsgObj_ failed.");
        errMsgObj_->SetErrMsgBufAddr();
    }
    error = TschStreamAllocDsaAddr();
    if (error != RT_ERROR_NONE) {
        error = TschStreamAllocDsaAddr();
    }
    ERROR_GOTO_MSG_INNER(error, ERROR_STOP, "alloc dsa addr failed, retCode=%#x.", static_cast<uint32_t>(error));
#else
    Runtime::Instance()->RtTimeoutConfigInit();
#endif

    return RT_ERROR_NONE;

ERROR_STOP:
    (void)Stop();

ERROR_FREE:
    FreeStackPhyBase();
    FreeCustomerStackPhyBase();
    static_cast<void>(FreeSimtStackPhyBase());
    DeleteStream(primaryStream_);
    return error;
}

void *RawDevice::MallocBufferForSqIdMem(const size_t size, void * const para)
{
    void *addr = nullptr;
    Device * const dev = static_cast<Device *>(para);
    rtError_t error = dev->Driver_()->DevMemAlloc(&addr, static_cast<uint64_t>(size), RT_MEMORY_HBM, dev->Id_());
    COND_RETURN_ERROR(error != RT_ERROR_NONE, nullptr, "alloc mem failed, "
        "size=%u(bytes), kind=%d, device_id=%u, retCode=%#x",
        size, RT_MEMORY_HBM, dev->Id_(), static_cast<uint32_t>(error));
    return addr;
}

void RawDevice::FreeBufferForSqIdMem(void * const addr, void * const para)
{
    Device * const dev = static_cast<Device *>(para);
    rtError_t error = dev->Driver_()->DevMemFree(addr, dev->Id_());
    COND_LOG(error != RT_ERROR_NONE, "mem free failed, device_id=%u, retCode=%#x!",
        dev->Id_(), static_cast<uint32_t>(error));
}

uint64_t RawDevice::AllocSqIdMemAddr(void)
{
    if (sqIdMemAddrPool_ == nullptr) {
        sqIdMemAddrPool_ = new (std::nothrow) BufferAllocator(sizeof(uint64_t), SQ_ID_MEM_POOL_INIT_COUNT,
                                                              SQ_ID_MEM_POOL_MAX_COUNT, BufferAllocator::LINEAR,
                                                              &MallocBufferForSqIdMem,
                                                              &FreeBufferForSqIdMem, this);
        COND_RETURN_WARN(sqIdMemAddrPool_ == nullptr, RT_ERROR_MEMORY_ALLOCATION, "alloc sq mem pool failed");
    }
    auto id = sqIdMemAddrPool_->AllocId(true);
    return RtPtrToValue(sqIdMemAddrPool_->GetItemById(id));
}

void RawDevice::FreeSqIdMemAddr(const uint64_t sqIdAddr)
{
    if (sqIdMemAddrPool_ != nullptr) {
        sqIdMemAddrPool_->FreeByItem(RtValueToPtr<void *>(sqIdAddr));
    }

    return;
}

rtError_t RawDevice::Stop()
{
    bool isThreadAlive = false;
    const bool isDisableThread = Runtime::Instance()->GetDisableThread();

    Runtime * const rt = Runtime::Instance();
    if (rt->IsStreamSyncEsched()) {
        const rtError_t ret = NpuDriver::EschedDettachDevice(deviceId_);
        if (ret != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_DEBUG, "The return of esched dettach device is %d.", ret);
        }
    }
    UnregisterAllProgram();

    if (IsStarsPlatform()) {
        isThreadAlive = true;
    } else {
        if (isDisableThread) {
            isThreadAlive = engine_->CheckMonitorThreadAlive();
        } else {
            isThreadAlive = engine_->CheckReceiveThreadAlive() && engine_->CheckSendThreadAlive();
        }
    }

    if (isThreadAlive) {
        rtError_t error = RT_ERROR_NONE;
        if ((deviceErrorProc_ != nullptr) && (GetDevRunningState() == static_cast<uint32_t>(DEV_RUNNING_NORMAL))) {
            error = deviceErrorProc_->SendTaskToStopUseRingBuffer();
        }

        if (Runtime::Instance()->GetDisableThread()) {
            if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL)) {
                (void)TaskReclaimAllStream(this);
            } else {
                uint32_t taskId = 0U;
                (void)engine_->TaskReclaim(UINT32_MAX, false, taskId);
            }
        } else {
            WaitCompletion();
        }

        if (ctrlStream_ != nullptr) {
            if (isDisableThread) {
                DeleteStream(ctrlStream_);
            }
            ctrlStream_ = nullptr;
        }
        if (eventPool_ != nullptr) {
            eventPool_->FreeAllEvent();
        }
        bool isEventQueueEmpty = false;
        while (!isEventQueueEmpty) {
            {
                const std::unique_lock<std::mutex> lk(freeEventMutex_);
                isEventQueueEmpty = (freeEventQueueHead_ == freeEventQueueTail_);
            }
            (void)sched_yield();
        }
        if (primaryStream_ != nullptr) {
            if (GetDevRunningState() == static_cast<uint32_t>(DEV_RUNNING_NORMAL)) {
                (void)primaryStream_->TearDown(true);
            }
            if (isDisableThread) {
                DeleteStream(primaryStream_);
            }
            primaryStream_ = nullptr;
        }
        WaitCompletion();

        if ((error == RT_ERROR_NONE) && (deviceErrorProc_ != nullptr)) {
            (void)deviceErrorProc_->DestroyDeviceRingBuffer();
        }
    } else {
        RT_LOG(RT_LOG_INFO, "No thread alive.");
    }
    FreeStackPhyBase();
    FreeCustomerStackPhyBase();
    (void)FreeSimtStackPhyBase();
    SetPageFaultBaseCnt(0U);
    SetPageFaultBaseTime(0U);
    return engine_->Stop();
}

rtError_t RawDevice::ProcDeviceErrorInfo(TaskInfo * const taskPtr)
{
#ifndef CFG_DEV_PLATFORM_PC
    if (deviceErrorProc_ != nullptr) {
        // call function one time, it means has an error in device;
        deviceErrorProc_->ProduceProcNum();
        if (taskPtr != nullptr) {
            deviceErrorProc_->SetRealFaultTaskPtr(taskPtr);
        }
        return deviceErrorProc_->ProcErrorInfo(taskPtr);
    }
#endif
    UNUSED(taskPtr);
    return RT_ERROR_DEVICE_RINGBUFFER_NOT_INIT;
}

bool RawDevice::IsPrintStreamTimeoutSnapshot()
{
    if (deviceErrorProc_ != nullptr) {
        return deviceErrorProc_->IsPrintStreamTimeoutSnapshot();
    }
    return true;
}

void RawDevice::GetErrorPcArr(const uint16_t devId, uint64_t **errorPc, uint32_t *cnt) const
{
    deviceErrorProc_->GetErrorPcArr(devId, errorPc, cnt);
}

void RawDevice::SetSupportFlipVersionSwitch()
{
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_FLIP)) {
        if (CheckFeatureSupport(TS_FEATURE_FLIPTASK)) {
            supportFlipTask_ = true;
        }
    }
    RT_LOG(RT_LOG_DEBUG, "chipType=%u, tschVersion=%u, supportFlipTask_=%u",
        chipType, tschVersion_, static_cast<uint32_t>(supportFlipTask_));
}

rtError_t RawDevice::PrintStreamTimeoutSnapshotInfo()
{
    if (deviceErrorProc_ != nullptr) {
        return deviceErrorProc_->PrintStreamTimeoutSnapshotInfo();
    }
    return RT_ERROR_NONE;
}

void *RawDevice::GetSnapshotAddr()
{
    if (deviceErrorProc_ != nullptr) {
        return deviceErrorProc_->GetSnapshotAddr();
    }
    return nullptr;
}

uint32_t RawDevice::GetSnapshotLen()
{
    if (deviceErrorProc_ != nullptr) {
        return deviceErrorProc_->GetSnapshotLen();
    }
    return 0;
}

rtError_t RawDevice::UpdateTimeoutConfig()
{
    Stream * const stm = GetCtrlStream(primaryStream_);
    const RtTimeoutConfig &timeoutConfig = Runtime::Instance()->GetTimeoutConfig();

    if ((!timeoutConfig.isCfgOpWaitTaskTimeout) && (!timeoutConfig.isCfgOpExcTaskTimeout)) {
        RT_LOG(RT_LOG_INFO, "No need to update timeout config.");
        return RT_ERROR_NONE;
    }
    auto props = GetDevProperties();
    if (props.timeoutUpdateMethod == TimeoutUpdateMethod::TIMEOUT_SET_WITH_AICPU) {
        // set op exec time out depend on aicpu in AS31XM1X
        ERROR_RETURN_MSG_INNER(Runtime::Instance()->StartAicpuSd(this),
            "Update timeout config failed, check and start tsd open aicpu sd error.");
    }
    if (props.timeoutUpdateMethod == TimeoutUpdateMethod::TIMEOUT_WITHOUT_UPDATE) {
        return UpdateTimeoutConfigTaskSubmitStarsV2(stm, timeoutConfig);
    }

    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *timeoutTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_TASK_TIMEOUT_SET, errorReason);
    NULL_PTR_RETURN_MSG(timeoutTask, errorReason);

    // if config first then setdevice maybe error
    TimeoutSetTaskInitV1(timeoutTask);
    if (timeoutConfig.isCfgOpWaitTaskTimeout) {
        TimeoutSetTaskUpdate(timeoutTask, RT_TIMEOUT_TYPE_OP_WAIT, timeoutConfig.opWaitTaskTimeout);
    }

    if (timeoutConfig.isCfgOpExcTaskTimeout) {
        uint32_t opExcTaskTimeout = timeoutConfig.opExcTaskTimeout / RT_TIMEOUT_MS_TO_US;
        if ((props.timeoutUpdateMethod == TimeoutUpdateMethod::TIMEOUT_NEED_RESET)) {
            opExcTaskTimeout = timeoutConfig.opExcTaskTimeout;
        }
        TimeoutSetTaskUpdate(timeoutTask, RT_TIMEOUT_TYPE_OP_EXECUTE, 
            opExcTaskTimeout / RT_TIMEOUT_S_TO_MS);
    }

    rtError_t error = SubmitTask(timeoutTask);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit TaskTimeoutSetTask, retCode=%#x",
                         static_cast<uint32_t>(error));

    if (stm->IsCtrlStream()) {
        error = (dynamic_cast<CtrlStream*>(stm))->Synchronize();
    } else {
        error = stm->Synchronize();
    }
    ERROR_RETURN_MSG_INNER(error, "Failed to synchronize stream[%d], retCode=%#x.", stm->Id_(),
                           static_cast<uint32_t>(error));

    return error;

    ERROR_RECYCLE:
    (void)GetTaskFactory()->Recycle(timeoutTask);
    return error;
}

Module *RawDevice::ModuleAlloc(Program * const prog)
{
    if (prog == nullptr) {
        return nullptr;
    }

    RefObject<Module *> * const refObj = modulesAllocator_->GetDataToItem(prog->Id_());
    if (refObj == nullptr) {
        return nullptr;
    }
    if (refObj->IncRef()) {
        return refObj->GetVal();
    }

    Module *mdl = new (std::nothrow) Module(this);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, mdl == nullptr, nullptr, "Alloc module failed, new module failed.");
    if (mdl->Load(prog) != RT_ERROR_NONE) {
        refObj->ResetValForAbort();
        delete mdl;
        mdl = nullptr;
        return nullptr;
    }

    refObj->SetVal(mdl);
    (void)Runtime::Instance()->GetProgram(prog);
    return mdl;
}

bool RawDevice::ModuleRetain(Module * const mdl)
{
    if (mdl == nullptr) {
        return false;
    }

    Program *program = mdl->GetProgram();
    if (program == nullptr) {
        return false;
    }

    RefObject<Module *> *const refObj = modulesAllocator_->GetDataToItem(program->Id_());
    if (refObj == nullptr) {
        return false;
    }

    return refObj->TryIncRef();
}

bool RawDevice::ModuleRelease(Module *mdl)
{
    if ((mdl == nullptr) || (mdl->GetProgram() == nullptr)) {
        return false;
    }
    Program *program = mdl->GetProgram();
    if (!modulesAllocator_->CheckIdValid(program->Id_())) {
        return false;
    }

    bool needReset = false;
    RefObject<Module *> * const refObj = modulesAllocator_->GetDataToItem(program->Id_());
    if (refObj == nullptr) {
        return false;
    }

    if (!refObj->TryDecRef(needReset)) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Release module failed, try to double free module in raw device");
        return false;
    }

    if (!needReset) {
        return false;
    }

    refObj->ResetVal();

    Runtime::Instance()->PutProgram(program);
    delete mdl;
    mdl = nullptr;
    return true;
}

rtError_t RawDevice::DevSetLimit(const rtLimitType_t type, const uint32_t val)
{
    RT_LOG(RT_LOG_WARNING, "DevSetLimit,type=%u, value=%u", static_cast<uint32_t>(type), val);
    if (type == RT_LIMIT_TYPE_LOW_POWER_TIMEOUT) {
        return RT_ERROR_NONE;
    }
    if (type == RT_LIMIT_TYPE_SIMD_PRINTF_FIFO_SIZE_PER_CORE) {
        return SetPrintFifoSize(val);
    }
    RT_LOG(RT_LOG_WARNING, "limit type wrong!,type=%u", static_cast<uint32_t>(type));
    return RT_ERROR_NONE;
}

rtError_t RawDevice::DevSetTsId(const uint32_t taskSchId)
{
    RT_LOG(RT_LOG_INFO, "DevSetTsId, tsId=%u", taskSchId);
    tsId_ = taskSchId;
    return RT_ERROR_NONE;
}

rtError_t RawDevice::DevSetOnlineProfStart(const bool profEnable)
{
    RT_LOG(RT_LOG_INFO, "DevSetOnlineProf Enable.");
    onProfEnable_.Set(profEnable);
    return RT_ERROR_NONE;
}

rtError_t  RawDevice::AicpuModelLoad(void * const modelInfo)
{
    return aicpuSdAgent_.AicpuModelLoad(modelInfo);
}

rtError_t RawDevice::AicpuModelDestroy(const uint32_t modelId)
{
    return aicpuSdAgent_.AicpuModelDestroy(modelId);
}

rtError_t RawDevice::AicpuModelExecute(const uint32_t modelId)
{
    return aicpuSdAgent_.AicpuModelExecute(modelId);
}

rtError_t RawDevice::AicpuModelAbort(const uint32_t modelId)
{
    (void)modelId;
    RT_LOG(RT_LOG_ERROR, "AicpuModelAbort is not implement.");
    return RT_ERROR_NONE;
}

rtError_t RawDevice::DatadumpInfoLoad(const void * const dumpInfo, const uint32_t length)
{
    return aicpuSdAgent_.DatadumpInfoLoad(dumpInfo, length);
}

rtError_t RawDevice::AllocMemForSqVirtualArr()
{
    const uint64_t allocSize = static_cast<uint64_t>(Runtime::macroValue_.rtsqDepth * sizeof(uint64_t));
    rtError_t error = driver_->DevMemAlloc(&sqVirtualArrBaseAddr_, allocSize, RT_MEMORY_DDR, deviceId_);
    ERROR_RETURN_MSG_INNER(error, "Device mem alloc for sq virtual addr failed, retCode=%#x, deviceId=%u, "
                                  "size = %#" PRIx64 "(bytes).", static_cast<uint32_t>(error), deviceId_, allocSize);
    error = driver_->MemSetSync(sqVirtualArrBaseAddr_, allocSize, 0U, allocSize);
    ERROR_RETURN_MSG_INNER(error, "Memset value failed, size=%#" PRIx64 "(bytes), retCode=%#x!", allocSize,
                           static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

void RawDevice::DelStreamFromMessageQueue(Stream * const stm)
{
    if (messageQueue_ == nullptr) {
        return;
    }

    const std::unique_lock<std::mutex> lk(messageQueueMutex_);
    uint16_t head = messageQueueHead_;
    const uint16_t tail = messageQueueTail_;

    while (head != tail) {
        if (messageQueue_[head] == RtPtrToValue(stm)) {
            messageQueue_[head] = 0ULL;
        }
        head = (head + 1U) % messageQueueSize_;
    }
    return;
}

bool RawDevice::AddStreamToMessageQueue(Stream *stm)
{
    if (messageQueue_ == nullptr) {
        return false;
    }

    const std::unique_lock<std::mutex> lk(messageQueueMutex_);
    if (((messageQueueTail_ + 1U) % messageQueueSize_) == messageQueueHead_) {
        RT_LOG(RT_LOG_EVENT, "message queue is full, head=%hu, tail=%hu", messageQueueHead_, messageQueueTail_);
        return false;
    }

    /* current stream is exits, do not add to message queue */
    uint16_t head = messageQueueHead_;
    const uint16_t tail = messageQueueTail_;
    const uint64_t addStm = RtPtrToValue(stm);
    while (head != tail) {
        if (messageQueue_[head] == addStm) {
            return false;
        }
        head = (head + 1U) % messageQueueSize_;
    }

    messageQueue_[messageQueueTail_] = addStm;
    messageQueueTail_ = (messageQueueTail_ + 1U) % messageQueueSize_;
    return true;
}

Stream *RawDevice::GetNextRecycleStream()
{
    if ((messageQueue_ == nullptr) || (messageQueueHead_ == messageQueueTail_)) {
        return nullptr;
    }

    const std::unique_lock<std::mutex> lk(messageQueueMutex_);

    /* find the first stream which is not null */
    while ((messageQueueHead_ != messageQueueTail_) && (messageQueue_[messageQueueHead_] == 0ULL)) {
        messageQueueHead_ = (messageQueueHead_ + 1U) % messageQueueSize_;
    }

    /* update the queue head */
    Stream *recycleStream = RtPtrToPtr<Stream *>(messageQueue_[messageQueueHead_]);
    messageQueue_[messageQueueHead_] = 0ULL;
    if (messageQueueHead_ != messageQueueTail_) {
        messageQueueHead_ = (messageQueueHead_ + 1U) % messageQueueSize_;
    }
    if (recycleStream != nullptr) {
        recycleStream->SetThreadProcFlag(true);
    }
    return recycleStream;
}

void RawDevice::CreateMessageQueue()
{
    if ((Runtime::Instance()->GetDisableThread()) &&
        (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_MESSAGE_QUEUE)) &&
        (Driver_()->GetRunMode() == RT_RUN_MODE_ONLINE)) {
        const uint32_t arraySize = messageQueueSize_;
        messageQueue_ = new (std::nothrow) uint64_t[arraySize]();
        if (messageQueue_ == nullptr) {
            RT_LOG(RT_LOG_ERROR, "malloc message queue failed");
            return;
        }

        (void)memset_s(messageQueue_, arraySize * sizeof(uint64_t), 0x0, arraySize * sizeof(uint64_t));
    }
}

void RawDevice::CreateFreeEventQueue()
{
    constexpr uint32_t arraySize = FREE_EVENT_QUEUE_SIZE;

    freeEvent_ = new (std::nothrow) int32_t[arraySize]();
    if (freeEvent_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "malloc free event queue failed");
        return;
    }

    (void)memset_s(freeEvent_, arraySize * sizeof(int32_t), 0x0, arraySize * sizeof(int32_t));
}

Stream* RawDevice::GetCtrlStream(Stream * const stream) const
{
    if ((Runtime::Instance()->GetDisableThread())   /* virtual situation, not enough sq for ctrlsq */
        && (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_STREAM_CTRL))
        && (GetTschVersion() >= static_cast<uint32_t>(TS_VERSION_CTRL_SQ))
        && (CtrlStream_() != nullptr)) {
        return CtrlStream_();
    } else {
        return stream;
    }
}
bool RawDevice::AllocHcclIndex(uint16_t &hcclIndex, uint16_t stmid)
{
    if (hcclStreamSize_ >= MAX_HCCL_STREAM_NUM) {
        noIndexHcclStmId = stmid;
        return false;
    }
    hcclIndex = hcclStream[hcclStreamSize_];
    hcclStream[hcclStreamSize_] = stmid;
    hcclStreamSize_++;
    return true;
}

void RawDevice::FreeHcclIndex(uint16_t stmid)
{
    if (hcclStreamSize_ == 0U) {
        RT_LOG(RT_LOG_ERROR, "hcclStreamSize=0, nothing to free.");
        return;
    }
    for (uint32_t i = 0; (i < hcclStreamSize_) && (i < MAX_HCCL_STREAM_NUM); ++i) {
        if (stmid == hcclStream[i]) {
            hcclStream[i] = hcclStream[hcclStreamSize_ - 1U];
            hcclStream[hcclStreamSize_ - 1U] = i;
            hcclStreamSize_--;
            RT_LOG(RT_LOG_INFO, "Free hccl index stream_id=%hu, hccl size=%hu.", stmid, hcclStreamSize_);
            return;
        }
    }
    RT_LOG(RT_LOG_ERROR, "Free stream_id=%hu not find in array size=%u.", stmid, hcclStreamSize_);
    return;
}

bool RawDevice::PopNextPoolFreeEventId()
{
    freeEventMutex_.lock();
    if (freeEventQueueHead_ == freeEventQueueTail_) {
        freeEventMutex_.unlock();
        return false;
    }

    const int32_t evenId = freeEvent_[freeEventQueueHead_];
    freeEventQueueHead_ = (freeEventQueueHead_ + 1U) % FREE_EVENT_QUEUE_SIZE;
    freeEventMutex_.unlock();
    FreePoolEvent(evenId);
    RT_LOG(RT_LOG_INFO, "pool get recycle event_id=%d.", evenId);
    return true;
}

bool RawDevice::IsNeedFreeEventId()
{
    return (freeEventQueueHead_ != freeEventQueueTail_);
}

void RawDevice::PushNextPoolFreeEventId(int32_t eventId)
{
    // only 71/ 51 support event pool
    if (IsStarsPlatform() && GetIsChipSupportRecycleThread()) {
        (void)FreePoolEvent(eventId);
        return;
    }
    if (freeEvent_ == nullptr) {
        return;
    }

    freeEventMutex_.lock();
    if (((freeEventQueueTail_ + 1U) % FREE_EVENT_QUEUE_SIZE) == freeEventQueueHead_) {
        freeEventMutex_.unlock();
        RT_LOG(RT_LOG_DEBUG, "event queue is full, head=%u, tail=%u", freeEventQueueHead_, freeEventQueueTail_);
        return;
    }

    freeEvent_[freeEventQueueTail_] = eventId;
    freeEventQueueTail_ = (freeEventQueueTail_ + 1U) % FREE_EVENT_QUEUE_SIZE;
    freeEventMutex_.unlock();
}

rtError_t RawDevice::FreeEventIdFromDrv(const int32_t eventId, const uint32_t eventFlag, bool freeSyncFlag)
{
    rtError_t error = RT_ERROR_NONE;
    // for stars, no need to send task
    if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_NOTIFY_ONLY)) {
        const uint32_t flag = (eventFlag == RT_EVENT_MC2) ? RT_NOTIFY_MC2 : 0U;
        error = Driver_()->NotifyIdFree(static_cast<int32_t>(Id_()), static_cast<uint32_t>(eventId), DevGetTsId(), flag);
        ERROR_RETURN(error, "Event id tear down failed, device_id=%u, event_id=%d,"
            "retCode=%#x", Id_(), eventId, static_cast<uint32_t>(error));
        RT_LOG(RT_LOG_INFO, "device_id=%u, event_id=%d tear down.", Id_(), eventId);
        return error;
    } else if (IsStarsPlatform()) {
        error = Driver_()->EventIdFree(static_cast<int32_t>(eventId), Id_(), DevGetTsId(), eventFlag);
        ERROR_RETURN(error, "Event id tear down failed, device_id=%u, event_id=%d,"
            "retCode=%#x", Id_(), eventId, static_cast<uint32_t>(error));
        RT_LOG(RT_LOG_INFO, "device_id=%u, event_id=%d tear down.", Id_(), eventId);
        return error;
    } else {
        // no op
    }

    const auto tskFactory = GetTaskFactory();
    error = RT_ERROR_TASK_NEW;
    TaskInfo *tsk = tskFactory->Alloc(PrimaryStream_(), TS_TASK_TYPE_MAINTENANCE, error);
    NULL_PTR_GOTO_MSG_INNER(tsk, ERROR_RETURN, error, error);
    error = MaintenanceTaskInit(tsk, MT_EVENT_DESTROY, static_cast<uint32_t>(eventId), false, eventFlag);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Event destroy task init failed, device_id=%u event_id=%d, retCode=%#x.",
                         Id_(), eventId, static_cast<uint32_t>(error));
    if (freeSyncFlag == true) {
        const std::lock_guard<std::mutex> lock(syncEventMapLock_);
        syncEventMap_.insert(static_cast<uint16_t>(eventId));
        RT_LOG(RT_LOG_INFO, "event_id=%d, insert.", eventId);
    }

    error = SubmitTask(tsk);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Event destroy task submit failed, device_id=%u, event_id=%d, "
                                               "retCode=%#x.", Id_(), eventId, static_cast<uint32_t>(error));
    if (freeSyncFlag == true) {
        bool needWait = true;
        bool isExist = true;
        while (needWait) {
            {
                const std::lock_guard<std::mutex> lock(syncEventMapLock_);
                isExist = syncEventMap_.find(static_cast<uint16_t>(eventId)) != syncEventMap_.end();
            }
            if (!isExist || (GetDevRunningState() != static_cast<uint32_t>(DEV_RUNNING_NORMAL))) {
                needWait = false;
            }
            (void)sched_yield();
        }
    }

    RT_LOG(RT_LOG_INFO, "device_id=%u, event_id=%d, freeSyncFlag=%d tear down.", Id_(), eventId, freeSyncFlag);
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)GetTaskFactory()->Recycle(tsk);
ERROR_RETURN:
    return error;
}

rtError_t RawDevice::TschStreamSetup()
{
    if (!IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_RAND_GENERATOR)) {
        return RT_ERROR_NONE;
    }

    COND_RETURN_INFO(tsFftsDsaStream_ != nullptr, RT_ERROR_NONE, "there has ffts dsa stream");

    tsFftsDsaStream_ = new (std::nothrow) TschStream(this, 0U, SQ_ALLOC_TYPE_TS_FFTS_DSA);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, tsFftsDsaStream_ == nullptr, RT_ERROR_STREAM_NEW,
                               "New ffts dsa stream failed.");

    const rtError_t error = tsFftsDsaStream_->Setup();
    if (error != RT_ERROR_NONE) {
        DeleteStream(tsFftsDsaStream_);
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Setup ffts dsa stream failed.");
        return error;
    }
    RT_LOG(RT_LOG_INFO, "Tsch setup ffts dsa stream ok, stream_id=%d", tsFftsDsaStream_->Id_());
    return RT_ERROR_NONE;
}

rtError_t RawDevice::TschStreamAllocDsaAddr() const
{
    if (!IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_RAND_GENERATOR)) {
        return RT_ERROR_NONE;
    }

    COND_RETURN_INFO(tsFftsDsaStream_ == nullptr, RT_ERROR_NONE, "there has ffts dsa stream");
    const rtError_t error = tsFftsDsaStream_->AllocDsaSqAddr();

    RT_LOG(RT_LOG_INFO, "send alloc dsa sq task, stream_id=%d, retCode:%d", tsFftsDsaStream_->Id_(), error);
    return error;
}

void RawDevice::CtrlResEntrySetup()
{
    ctrlRes_ = new (std::nothrow) CtrlResEntry();
    if (ctrlRes_ == nullptr) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "alloc ctrl res failed.");
        return;
    }
    const rtError_t error = ctrlRes_->Init(this);
    COND_PROC((error != RT_ERROR_NONE), DELETE_O(ctrlRes_);)
}

void RawDevice::TryFreeAllEventPoolId()
{
    if (eventPool_ == nullptr) {
        RT_LOG(RT_LOG_WARNING, "eventPool is nullptr, no need free.");
        return;
    }

    mmTimespec endTime = mmGetTickCount();
    const uint64_t beginCnt = static_cast<uint64_t>(lastUsagePoolTimeStamp_.tv_sec) * RT_MS_PER_S +
                              static_cast<uint64_t>(lastUsagePoolTimeStamp_.tv_nsec) / RT_MS_TO_NS;
    const uint64_t endCnt = static_cast<uint64_t>(endTime.tv_sec) * RT_MS_PER_S +
                            static_cast<uint64_t>(endTime.tv_nsec) / RT_MS_TO_NS;
    const uint64_t count = (endCnt > beginCnt) ? (endCnt - beginCnt) : 0ULL;
    if (count > 3000U) {
        (void)eventPool_->FreeAllEvent();
    }
}
void RawDevice::PrintExceedLimitHcclStream()
{
    if (noIndexHcclStmId == UINT32_MAX) {
        return;
    }
    RT_LOG(RT_LOG_ERROR, "hccl streams greater than %u!, no index stream_id=%d", MAX_HCCL_STREAM_NUM, noIndexHcclStmId);
    for (uint16_t index = 0U; (index < hcclStreamSize_) && (index < MAX_HCCL_STREAM_NUM); index++) {
        RT_LOG(RT_LOG_ERROR, "index=%u, Hccl stream_id=%u", index, this->GetHcclStreamIdWithIndex(index));
    }
}

void RawDevice::CtrlStreamSetup()
{
    RT_LOG(RT_LOG_INFO, "[ctrlsq]New ctrlStream set up start.");
    if (ctrlRes_ == nullptr) {
        RT_LOG(RT_LOG_INFO, "ctrl stream is not set up, use normal stream.");
        return;
    }

    ctrlStream_ = new (std::nothrow) CtrlStream(this);
    COND_PROC((ctrlStream_ == nullptr),
        DELETE_O(ctrlRes_);
        return;)

    const rtError_t error = ctrlStream_->Setup();
    COND_PROC((error != RT_ERROR_NONE),
        DeleteStream(ctrlStream_);
        DELETE_O(ctrlRes_);
        return;)
    RT_LOG(RT_LOG_INFO, "[ctrlsq]New ctrlStream ok, Runtime_alloc_size %zu(bytes), stream_id=%d.",
        sizeof(Stream), ctrlStream_->Id_());
    return;
}

void RawDevice::SetTschVersion(const uint32_t tschVersion)
{
    if ((tschVersion >= static_cast<uint32_t>(TS_VERSION_CTRL_SQ)) &&
        (Runtime::Instance()->GetDisableThread()) &&
        (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_STREAM_CTRL))) {
        if (!ctrlStreamObj.IncRef()) {
            CtrlResEntrySetup();
            CtrlStreamSetup();
            ctrlStreamObj.SetVal(ctrlStream_);
        }
    }
    tschVersion_ = tschVersion;
    RT_LOG(RT_LOG_INFO, "Set tsch version=%u.", tschVersion);

    Runtime::Instance()->SetTsVersion(tschVersion);

    SetSupportFlipVersionSwitch();
    if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_GET_STARS_VERSION)) {
        return;
    }
#ifdef CFG_DEV_PLATFORM_PC
    SetTschVersionForCmodel();
#else
    if (tschVersion_ < static_cast<uint32_t>(TS_VERSION_EXPAND_STREAM_TASK)) {
        RT_LOG(RT_LOG_ERROR, "current tsch version [%u] is old version, not match current runtime version.",
            tschVersion_);
    }
#endif
}

rtError_t RawDevice::GetStarsVersion()
{
#ifndef CFG_DEV_PLATFORM_PC
    if (!IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_GET_STARS_VERSION)) {
        return RT_ERROR_NONE;
    }

    COND_RETURN_INFO(primaryStream_ == nullptr, RT_ERROR_NONE, "primary stream is null");

    rtError_t error = RT_ERROR_NONE;
    if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_TS_COMMON_CPU)) {
        uint32_t tsfwVersion = 0U;
        uint32_t isSupportHcomcpu = 0U;
        error = driver_->GetTsfwVersion(deviceId_, tsId_, tsfwVersion, isSupportHcomcpu);
        if (error == RT_ERROR_NONE) {
            isSupportHcomcpu_ = isSupportHcomcpu;
            SetTschVersion(tsfwVersion);
        }
    } else {
        error = primaryStream_->GetStarsVersion();
    }
    RT_LOG(RT_LOG_INFO, "send alloc get stars version task, stream_id=%d, retCode:%d", primaryStream_->Id_(), error);
    return error;
#else
    return RT_ERROR_NONE;
#endif
}

rtError_t RawDevice::AddAddrKernelNameMapTable(rtAddrKernelName_t &mapInfo)
{
    if (!IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_KERNEL_NAME_MAP_TABLE)) {
        RT_LOG(RT_LOG_DEBUG, "platform does not support.");
        return RT_ERROR_FEATURE_NOT_SUPPORT;
    }
    const std::unique_lock<std::mutex> lk(addrKernelNameMap_.mapMutex);
    const std::pair<std::map<uint64_t, std::string>::iterator, bool> ret =
        addrKernelNameMap_.mapInfo.insert(std::pair<uint64_t, std::string>(mapInfo.addr, mapInfo.kernelName));
    COND_RETURN_INFO(!ret.second, RT_ERROR_KERNEL_OFFSET,
        "Can not insert deviceId:%u, name:%s, addr:%#" PRIx64 ", retName:%s, retAddr:%#" PRIx64 ".",
        deviceId_, mapInfo.kernelName.c_str(), mapInfo.addr, ret.first->second.c_str(), ret.first->first);
    RT_LOG(RT_LOG_DEBUG, "insert deviceId:%u success, name:%s, addr:%#" PRIx64 ".",
        deviceId_, mapInfo.kernelName.c_str(), mapInfo.addr);
    return RT_ERROR_NONE;
}

std::string RawDevice::LookupKernelNameByAddr(const uint64_t addr)
{
    const std::unique_lock<std::mutex> lk(addrKernelNameMap_.mapMutex);
    const auto iter = addrKernelNameMap_.mapInfo.find(addr);
    if (iter != addrKernelNameMap_.mapInfo.end()) {
        return iter->second;
    }
    return "not found kernel name";
}

void RawDevice::AddAddrBinHandleMapTable(const uint64_t addr, void *const handle)
{
    const std::unique_lock<std::mutex> lk(addrBinHandleMap_.mtx);
    addrBinHandleMap_.map[addr] = handle;
    RT_LOG(RT_LOG_DEBUG, "insert deviceid:%u success, addr:0x%llx, handle:0x%llx.", deviceId_, addr, handle);
}

void *RawDevice::LookupBinHandleByAddr(const uint64_t addr)
{
    const std::unique_lock<std::mutex> lk(addrBinHandleMap_.mtx);
    const auto &iter = addrBinHandleMap_.map.find(addr);
    if (iter != addrBinHandleMap_.map.end()) {
        return iter->second;
    }
    return nullptr;
}

rtError_t RawDevice::ReportRingBuffer(uint16_t *errorStreamId)
{
    if (deviceErrorProc_ != nullptr) {
        return deviceErrorProc_->ReportRingBuffer(errorStreamId);
    }
    return RT_ERROR_NONE;
}

void RawDevice::ProcessReportFastRingBuffer() const
{
    if (deviceErrorProc_ != nullptr) {
        deviceErrorProc_->ProcessReportFastRingBuffer();
    }
}

rtError_t RawDevice::ProcCleanRingbuffer()
{
    if (deviceErrorProc_ != nullptr) {
        return deviceErrorProc_->ProcCleanRingbuffer();
    }
    return RT_ERROR_NONE;
}

void RawDevice::ProcClearFastRingBuffer() const
{
    if (deviceErrorProc_ != nullptr) {
        return deviceErrorProc_->ProcClearFastRingBuffer();
    }
}

const std::map<uint32_t, uint32_t> RawDevice::tsFeatureMap_ = {
    {TS_FEATURE_STARS_COMPATIBILITY, RT_FEATURE_STARS_COMPATIBILITY},
    {TS_FEATURE_IPC_NOTICE_DC, RT_FEATURE_IPC_NOTICE_DC},
    {TS_FEATURE_FFTSPLUS_TASKID_SAME_FIX, RT_FEATURE_FFTSPLUS_TASKID_SAME_FIX},
    {TS_FEATURE_OVER_FLOW_DEBUG, RT_FEATURE_OVER_FLOW_DEBUG},
    {TS_FEATURE_D2D_ADDR_ASYNC, RT_FEATURE_D2D_ADDR_ASYNC},
    {TS_FEATURE_FLIPTASK, RT_FEATURE_FLIPTASK},
    {TS_FEATURE_FFTSPLUS_TIMEOUT, RT_FEATURE_FFTSPLUS_TIMEOUT},
    {TS_FEATURE_MC2_RTS_SUPPORT_HCCL, RT_FEATURE_MC2_RTS_SUPPORT_HCCL},
    {TS_FEATURE_IPC_NOTICE_910_B_93, RT_FEATURE_IPC_NOTICE_910_B_93},
    {TS_FEATURE_MC2_RTS_SUPPORT_HCCL_DC, RT_FEATURE_MC2_RTS_SUPPORT_HCCL_DC},
    {TS_FEATURE_REDUCE_V2_SUPPORT_DC, RT_FEATURE_SUPPORT_REDUCEASYNC_V2_DC},
    {TS_FEATURE_TILING_KEY_SINK, RT_FEATURE_TILING_KEY_SINK},
    {TS_FEATURE_MC2_ENHANCE, RT_FEATURE_MC2_ENHANCE},
    {TS_FEATURE_TASK_SAME_FOR_ALL, RT_FEATURE_FFTSPLUS_TASKID_SAME_FOR_ALL},
    {TS_FEATURE_TASK_ABORT, RT_FEATURE_TASK_ABORT}
};

uint32_t RawDevice::ConvertTsFeature(const uint32_t tsFeature) const
{
    uint32_t feature = RT_FEATURE_MAX;
    const auto it = tsFeatureMap_.find(tsFeature);
    if (it != tsFeatureMap_.end()) {
        feature = it->second;
    } else {
        RT_LOG(RT_LOG_WARNING, "tsFeature=%u should not use old solution.", tsFeature);
    }
    return feature;
}

bool RawDevice::CheckFeatureSupport(const uint32_t tsFeature)
{
    if (IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_TSCH_PACAGE_COMPATABLE)) {
        return true;
    }

    if ((tschCapability_ != nullptr) && (tschCapaDepth_ != 0U)) {
        return CheckTschCapability(tsFeature);
    }

    // use old solution
    const uint32_t feature = ConvertTsFeature(tsFeature);
    return CheckFeatureIsSupportOld(tschVersion_, static_cast<rtFeature>(feature));
}

bool RawDevice::CheckTschCapability(const uint32_t tsFeature) const
{
    const uint32_t pos = (tsFeature / ONE_BYTE_BITS) % tschCapaDepth_;
    if (pos >= tschCapaLen_) {
        return false;
    }

    const bool isSupport = ((static_cast<uint32_t>(tschCapability_[pos]) >> (tsFeature % ONE_BYTE_BITS)) & 1U);
    return isSupport;
}

rtError_t RawDevice::EnableP2PWithOtherDevice(const uint32_t peerPhyDeviceId)
{
    uint32_t phyDeviceId = 0U;
    auto error = driver_->GetDevicePhyIdByIndex(deviceId_, &phyDeviceId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    uint32_t peerDeviceId = 0U;
    error = driver_->GetDeviceIndexByPhyId(peerPhyDeviceId, &peerDeviceId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    if (phyDeviceId != peerPhyDeviceId) {
        error = NpuDriver::EnableP2P(peerDeviceId, phyDeviceId, 0U);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
        error = NpuDriver::EnableP2P(deviceId_, peerPhyDeviceId, 0U);
        COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    }
    return RT_ERROR_NONE;
}

rtError_t RawDevice::WriteDevString(void * const dest, const size_t max, const char_t * const str)
{
    const size_t devStrLen = strnlen(str, max);
    COND_RETURN_ERROR_MSG_INNER(devStrLen == 0UL, RT_ERROR_INVALID_VALUE,
        "Device string failed, string length must be greater than 0.");

    const size_t devStrBufLen = devStrLen + 1UL;
    rtError_t error = driver_->MemSetSync(dest, devStrBufLen, 0U, devStrBufLen);
    ERROR_RETURN_MSG_INNER(error, "Memset string failed, size=%zu, retCode=%#x!",
        devStrBufLen, static_cast<uint32_t>(error));
    error = driver_->MemCopySync(dest, static_cast<uint64_t>(devStrLen), str, static_cast<uint64_t>(devStrLen),
        RT_MEMCPY_HOST_TO_DEVICE);
    ERROR_RETURN_MSG_INNER(error,
        "Memory copy string failed, size=%zu(bytes), kind=%d(RT_MEMCPY_HOST_TO_DEVICE), retCode=%#x!",
        devStrLen, static_cast<int32_t>(RT_MEMCPY_HOST_TO_DEVICE), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t RawDevice::WriteDevValue(void * const dest, const size_t size, const void * const data)
{
    COND_RETURN_ERROR_MSG_INNER(size == 0U, RT_ERROR_INVALID_VALUE,
        "Device value failed, data size(%zu) must be greater than 0.", size);

    rtError_t error = driver_->MemSetSync(dest, static_cast<uint64_t>(size), 0U, static_cast<uint64_t>(size));
    ERROR_RETURN_MSG_INNER(error, "Memset value failed, size=%zu, retCode=%#x!",
        size, static_cast<uint32_t>(error));
    error = driver_->MemCopySync(dest, static_cast<uint64_t>(size), data, static_cast<uint64_t>(size),
        RT_MEMCPY_HOST_TO_DEVICE);
    ERROR_RETURN_MSG_INNER(error,
        "Memory copy value failed, size=%zu(bytes), kind=%d(RT_MEMCPY_HOST_TO_DEVICE), retCode=%#x!",
        size, static_cast<int32_t>(RT_MEMCPY_HOST_TO_DEVICE), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t RawDevice::InitPrintInfo()
{
    if (printblockLen_ == 0U) {
        printblockLen_ = PRINT_FIFO_DEFAULT_BLOCK_SIZE;
    }
    rtError_t ret = driver_->DevMemAlloc(&printfAddr_, printblockLen_ * BLOCK_NUM, RT_MEMORY_HBM, deviceId_,
        DEFAULT_MODULEID);
    COND_RETURN_ERROR((ret != RT_ERROR_NONE), ret, "Malloc mem failed, device id=%d, ret=%u.", deviceId_, ret);

    // 如果初始化失败，需要free后返回
    ret = InitPrintf(printfAddr_, printblockLen_, driver_);
    if (ret != RT_ERROR_NONE) {
        (void)driver_->DevMemFree(printfAddr_, deviceId_);
        printfAddr_ = nullptr;
        RT_LOG(RT_LOG_ERROR, "InitPrintf failed, device id=%d, ret=%u.", deviceId_, ret);
        return ret;
    }
    return RT_ERROR_NONE;
}

rtError_t RawDevice::ParsePrintInfo()
{
    std::unique_lock<std::mutex> l(printfMtx_);
    rtError_t ret = RT_ERROR_NONE;
    if (printfAddr_ == nullptr) {
        ret = InitPrintInfo();
        COND_RETURN_ERROR((ret != RT_ERROR_NONE), ret, "InitPrintInfo failed, device id=%d, ret=%u.", deviceId_, ret);
    }
    ret = ParsePrintf(printfAddr_, printblockLen_, driver_);
    ++parseCounter_;
    COND_RETURN_ERROR((ret != RT_ERROR_NONE), ret, "ParsePrintf failed, device id=%d, ret=%u.", deviceId_, ret);
    return RT_ERROR_NONE;
}

void RawDevice::WaitForParsePrintf() const
{
    RT_LOG(RT_LOG_DEBUG, "Wait for the last print thread!");
    if (!engine_->isEnablePrintfThread()) {
        RT_LOG(RT_LOG_DEBUG, "The print thread is not enabled.");
        return;
    }
    uint64_t curParseCounter = parseCounter_;
    uint32_t i = 0;
    while (curParseCounter == parseCounter_) {
        if (i == WAIT_PRINTF_THREAD_TIME_MAX) {
            break;
        }
        i++;
        (void)mmSleep(100U);
    }
    curParseCounter = parseCounter_;
    RT_LOG(RT_LOG_DEBUG, "Wait for the last print thread, suss!");
}

rtError_t RawDevice::SetPrintFifoSize(const uint32_t value)
{
    std::unique_lock<std::mutex> l(printfMtx_);
    constexpr uint32_t MIN_FIFO_PRINTF_SIZE = sizeof(BlockInfo) + sizeof(DumpInfoHead) + sizeof(BlockReadInfo) + sizeof(BlockWriteInfo);
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(value < MIN_FIFO_PRINTF_SIZE, RT_ERROR_INVALID_VALUE, 
        value, "greater than and equal to " + std::to_string(MIN_FIFO_PRINTF_SIZE));
    printblockLen_ = value;
    return RT_ERROR_NONE;
}

rtError_t RawDevice::GetPrintFifoAddress(uint64_t * const addr)
{
    std::unique_lock<std::mutex> l(printfMtx_);
    rtError_t ret = RT_ERROR_NONE;
    if (printfAddr_ == nullptr) {
        ret = InitPrintInfo();
        COND_RETURN_ERROR((ret != RT_ERROR_NONE), ret, "InitPrintInfo failed, device id=%d, ret=%u.", deviceId_, ret);
        ret = engine_->CreatePrintfThread();
        COND_RETURN_ERROR((ret != RT_ERROR_NONE), ret,
            "CreatePrintfThread failed, device id=%d, ret=%u.", deviceId_, ret);
    }
    *addr = RtPtrToPtr<uint64_t>(printfAddr_);
    return ret;
}

rtError_t RawDevice::StoreEndGraphNotifyInfo(Stream* exeStream, Model* captureModel, uint32_t endGraphNotifyPos)
{
    auto key = std::make_tuple(exeStream, captureModel);
    uint32_t numOfPos = 0;

    captureModelExeInfoLock_.lock();

    auto it = captureModelExeInfoMap_.find(key);
    if (it == captureModelExeInfoMap_.end()) {
        numOfPos = 1;
        captureModelExeInfoMap_.emplace(key, std::list<uint32_t>(numOfPos, endGraphNotifyPos));
    } else {
        std::list<uint32_t>& posList = captureModelExeInfoMap_[key];
        posList.emplace_back(endGraphNotifyPos);
        numOfPos = posList.size();
    }

    captureModelExeInfoLock_.unlock();

    RT_LOG(RT_LOG_INFO, "Store exeStreamId=%u captureModelId=%u endGraphNotifyPos=%u in captureModelExeInfoMap_, numOfPos=%u.", 
        exeStream->Id_(), captureModel->Id_(), endGraphNotifyPos, numOfPos);
    return RT_ERROR_NONE;    
}

rtError_t RawDevice::DeleteEndGraphNotifyInfo(Stream* exeStream, Model* captureModel, uint32_t endGraphNotifyPos)
{
    auto key = std::make_tuple(exeStream, captureModel);
    uint32_t numOfPos = 0;

    captureModelExeInfoLock_.lock();

    auto it = captureModelExeInfoMap_.find(key);
    if (it != captureModelExeInfoMap_.end()) {
        std::list<uint32_t>& posList = captureModelExeInfoMap_[key];
        auto posIt = std::find(posList.begin(), posList.end(), endGraphNotifyPos);
        if (posIt != posList.end()) {
            posList.erase(posIt);
        }

        numOfPos = posList.size();
        if (posList.empty()) {
            captureModelExeInfoMap_.erase(it);
        }

        CaptureModel *captureModelTmp = static_cast<CaptureModel*>(captureModel);
        if (captureModelTmp != nullptr) {
            (void)captureModelTmp->CaptureModelExecuteFinish();
        }
    }

    captureModelExeInfoLock_.unlock();

    RT_LOG(RT_LOG_INFO, "Delete exeStreamId=%u captureModelId=%u endGraphNotifyPos=%u in captureModelExeInfoMap_, numOfPos=%u.", 
        exeStream->Id_(), captureModel->Id_(), endGraphNotifyPos, numOfPos);
    return RT_ERROR_NONE;
}

rtError_t RawDevice::ClearEndGraphNotifyInfoByModel(Model* captureModel)
{
    captureModelExeInfoLock_.lock();

    for (auto it = captureModelExeInfoMap_.begin(); it != captureModelExeInfoMap_.end();) {
        Stream* exeStream;
        Model* model;
        std::tie(exeStream, model) = it->first;
        
        if (model == captureModel) {
            it = captureModelExeInfoMap_.erase(it);
        } else {
            ++it;
        }
    }

    captureModelExeInfoLock_.unlock();

    RT_LOG(RT_LOG_INFO, "Clear all model info, captureModelId=%u.", captureModel->Id_());
    return RT_ERROR_NONE;
}

bool JudgeIsExecuted(const uint16_t sqHead, const uint16_t sqTail, const uint32_t pos)
{
    bool isExecuted = false;

    if (sqHead < sqTail) {
        if (sqHead > pos || pos > sqTail) {
            isExecuted = true;
        } else {
            isExecuted = false;
        }
    } else if (sqHead > sqTail) {
        if (pos >= sqHead || pos < sqTail) {
            isExecuted = false;
        } else {
            isExecuted = true;
        }
    } else {
        isExecuted = true;
    }

    RT_LOG(RT_LOG_INFO, "JudgeIsExecuted: isExecuted=%d, head=%u, tail=%u, pos=%u",
        isExecuted, sqHead, sqTail, pos);

    return isExecuted;
}

bool RawDevice::JudgeIsEndGraphNotifyWaitExecuted(const Stream* const exeStream, Model* captureModel,
                                                  std::list<uint32_t>& sqePosList) const
{
    uint16_t sqHead = 0U;
    const uint32_t sqId = exeStream->GetSqId();
    const uint32_t tsId = DevGetTsId();
    
    for (auto it = sqePosList.begin(); it != sqePosList.end();) {
        // update head and tail timingly
        const uint16_t sqTail = exeStream->GetTaskPosTail();
        const rtError_t error = this->Driver_()->GetSqHead(this->Id_(), tsId, sqId, sqHead);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, false, 
            "Query sq head failed in JudgeIsEndGraphNotifyWaitExecuted, retCode=%#x", static_cast<uint32_t>(error));

        if (JudgeIsExecuted(sqHead, sqTail, *it)) {
            it = sqePosList.erase(it);
            CaptureModel *captureModelTmp = static_cast<CaptureModel*>(captureModel);
            if (captureModelTmp != nullptr) {
                (void)captureModelTmp->CaptureModelExecuteFinish();
            }
        } else {
            break;
        }
    }

    // if all sqePos in sqePosList have been executed, then it is considered as executed
    return (sqePosList.size() == 0);    
}

void RawDevice::PollEndGraphNotifyInfo()
{
    captureModelExeInfoLock_.lock();

    for (auto it = captureModelExeInfoMap_.begin(); it != captureModelExeInfoMap_.end();) {
        Stream* exeStream;
        Model* model;
        std::tie(exeStream, model) = it->first;
        
        std::list<uint32_t>& sqePosList = it->second;
        bool isAlreadyExecuted = JudgeIsEndGraphNotifyWaitExecuted(exeStream, model, sqePosList);
        if (isAlreadyExecuted) {
            it = captureModelExeInfoMap_.erase(it);
        } else {
            ++it;
        }
    }

    captureModelExeInfoLock_.unlock();
}
void RawDevice::RegisterProgram(Program * prog)
{
    programMtx_.lock();
    programSet_.insert(prog);
    programMtx_.unlock();
}
void RawDevice::UnRegisterProgram(Program * prog)
{
    programSet_.erase(prog);
}
void RawDevice::UnregisterAllProgram() {
    programMtx_.lock();
    for (auto &prog : programSet_) {
        prog->SetDeviceSoAndNameInvalid(Id_());
    }
    programSet_.clear();
    programMtx_.unlock();
}
}  // namespace runtime
}
