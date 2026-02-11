/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "context.hpp"
#include <cinttypes>
#include <queue>
#include <thread>
#include "securec.h"
#include "runtime.hpp"
#include "coprocessor_stream.hpp"
#include "event.hpp"
#include "notify.hpp"
#include "count_notify.hpp"
#include "device.hpp"
#include "program.hpp"
#include "module.hpp"
#include "uma_arg_loader.hpp"
#include "npu_driver.hpp"
#include "onlineprof.hpp"
#include "task.hpp"
#include "osal.hpp"
#include "error_message_manage.hpp"
#include "profiler.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "dvpp_grp.hpp"
#include "task_info.hpp"
#include "task_submit.hpp"
#include "task_to_sqe.hpp"
#include "config.h"
#include "stream_state_callback_manager.hpp"
#if (!defined(CFG_VECTOR_CAST))
#include <algorithm>
#endif
#include "heterogenous.h"
#include "notify_record_task.h"
#include "capture_model.hpp"
#include "capture_model_utils.hpp"
#include "stars_common_task.h"
#include "random_num_task.h"
#include "memory_task.h"
#include "stream_factory.hpp"
#include "stub_task.hpp"
#include "capture_adapt.hpp"
#include "para_convertor.hpp"
#include "binary_loader.hpp"
#include "buffer_allocator.hpp"
#include "ctrl_sq.hpp"

namespace cce {
namespace runtime {
namespace {
constexpr uint64_t DEBUG_DEVMEM_LEN = 4096U;
constexpr uint64_t L0A_SIZE = 65536; // 同L0B_SIZE
constexpr uint64_t L0C_SIZE = 262144; // 同UB_SIZE
constexpr uint64_t L1_SIZE = 1048576;
constexpr size_t NOTIFY_INDEX = 2U;
constexpr int32_t CONTEXT_STREAM_SYNC_TIMEOUT = (36 * 60 * 1000); // 36min
constexpr uint64_t STREAM_ABORT_TIMEOUT = (60UL * RT_MS_PER_S); // 60s
constexpr uint64_t REDUCE_ALIGN_SIZE = 0x4ULL;
constexpr uint64_t REDUCE16_ALIGN_SIZE = 0x2ULL;
constexpr uint64_t LOAD_CPU_SO_KERNEL_TIMEOUT = 60U * RT_MS_PER_S * RT_US_TO_MS;

rtError_t CheckMemoryParam(const rtDebugMemoryParam_t *const param)
{
    static const std::map<rtDebugMemoryType_t, uint64_t> BUFFER_SIZE = {
        {RT_MEM_TYPE_L0A, L0A_SIZE},
        {RT_MEM_TYPE_L0B, L0A_SIZE},
        {RT_MEM_TYPE_L0C, L0C_SIZE},
        {RT_MEM_TYPE_UB, L0C_SIZE},
        {RT_MEM_TYPE_L1, L1_SIZE},
    };

    NULL_PTR_RETURN_MSG(param, RT_ERROR_INVALID_VALUE);
    const auto &iter = BUFFER_SIZE.find(param->debugMemType);
    if (iter != BUFFER_SIZE.end()) {
        const bool isValid = ((param->srcAddr + param->memLen) <= iter->second);
        COND_RETURN_ERROR((!isValid), RT_ERROR_INVALID_VALUE, "CheckMemoryParam fail, debugMemType=%d, srcAddr=0x%llx, "
                          "memLen=%llu.", param->debugMemType, param->srcAddr, param->memLen);
    }
    if (param->debugMemType == RT_MEM_TYPE_REGISTER) {
        COND_RETURN_ERROR((param->memLen % param->elementSize != 0), RT_ERROR_INVALID_VALUE,
            "CheckMemoryParam register fail, memLen=%llu, elementSize=%u.", param->memLen, param->elementSize);
    }
    return RT_ERROR_NONE;
}

rtError_t CheckCoreParam(const uint32_t coreType, const uint32_t coreId)
{
    COND_RETURN_ERROR((coreType != 0 && coreType != 1), RT_ERROR_INVALID_VALUE, "coreType=%u is invalid!", coreType);
    if (coreType == 0) {
        COND_RETURN_ERROR((coreId >= RT_AICORE_NUM_25), RT_ERROR_INVALID_VALUE,
                          "aic coreId=%u is invalid!", coreId);
    } else {
        COND_RETURN_ERROR((coreId >= RT_AIVECTOR_NUM_50), RT_ERROR_INVALID_VALUE,
                          "aiv coreId=%u is invalid!", coreId);
    }
    return RT_ERROR_NONE;
}

rtError_t CheckMemAddrAlign4B(const uint64_t memAddr)
{
    return ((memAddr % REDUCE_ALIGN_SIZE) != 0ULL) ? RT_ERROR_MEMORY_ADDRESS_UNALIGNED : RT_ERROR_NONE;
}

rtError_t CheckMemAddrAlign2B(const uint64_t memAddr)
{
    return ((memAddr % REDUCE16_ALIGN_SIZE) != 0ULL) ? RT_ERROR_MEMORY_ADDRESS_UNALIGNED : RT_ERROR_NONE;
}
} // namespace

static rtError_t LaunchAicpuKernelForCpuSoImpl(const rtKernelLaunchNames_t * const launchNames, const rtArgsEx_t * const argsInfo, Stream * const stm)
{
    rtError_t error = RT_ERROR_NONE;
    Device *device = stm->Device_();
    TaskInfo submitTask = {};
    rtError_t errorReason;
    AicpuTaskInfo *aicpuTaskInfo = nullptr;
    TaskInfo *tsk = stm->AllocTask(&submitTask, TS_TASK_TYPE_KERNEL_AICORE, errorReason);
    NULL_PTR_RETURN_MSG(tsk, errorReason);
    AicpuTaskInit(tsk, 1, RT_KERNEL_DEFAULT);
    ArgLoaderResult result = {};
    error = device->ArgLoader_()->LoadCpuKernelArgs(argsInfo, stm, &result);
    COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, device->GetTaskFactory()->Recycle(tsk),
        "Failed to load kernel args, retCode=%#x.", error);
    SetAicpuArgs(tsk, result.kerArgs, argsInfo->argsSize, result.handle);
    result.handle = nullptr;

    // soName is nullptr, only copy kerneName.
    void *kernelNameAddr = nullptr;
    error = device->ArgLoader_()->GetKernelInfoDevAddr(launchNames->kernelName, KernelInfoType::KERNEL_NAME, &kernelNameAddr);
    COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, device->GetTaskFactory()->Recycle(tsk),
        "Failed to get kernel address by name, retCode=%#x.", error);
    SetNameArgs(tsk, nullptr, kernelNameAddr);

    aicpuTaskInfo = &(tsk->u.aicpuTaskInfo);
    RT_LOG(RT_LOG_INFO, "device_id=%lu, stream_id=%d, task_id=%hu, flag=%u, kernelFlag=0x%x, blkdim=%u, soName=null, kernel_name=%s.",
        device->Id_(), stm->Id_(), tsk->id, RT_KERNEL_DEFAULT, aicpuTaskInfo->comm.kernelFlag, aicpuTaskInfo->comm.dim,
        launchNames->kernelName != nullptr ? launchNames->kernelName : "null");

    // Set kernel type and flags
    aicpuTaskInfo->aicpuKernelType = static_cast<uint8_t>(TS_AICPU_KERNEL_AICPU);

    // for batchLoadsoFrombuf and deleteCustOp set timeout 60s
    if (Runtime::Instance()->IsSupportOpTimeoutMs()) {
        aicpuTaskInfo->timeout = LOAD_CPU_SO_KERNEL_TIMEOUT;
    }

    error = stm->Device_()->SubmitTask(tsk);
    COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, device->GetTaskFactory()->Recycle(tsk),
        "Failed to submit aicpu task, retCode=%#x.", error);
    return error;
}

rtError_t LaunchAicpuKernelForCpuSo(const rtKernelLaunchNames_t * const launchNames, const rtArgsEx_t * const argsInfo, Stream * const stm) {
    rtError_t error = RT_ERROR_NONE;
    if (stm->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL_DOT_CPUKERNEL)) {
        error = StreamLaunchCpuKernel(launchNames, 1, argsInfo, stm, RT_KERNEL_DEFAULT);
    } else {
        error = LaunchAicpuKernelForCpuSoImpl(launchNames, argsInfo, stm);
    }
    return error;
}

TIMESTAMP_EXTERN(rtReduceAsync_part1);
TIMESTAMP_EXTERN(rtReduceAsync_part2);
TIMESTAMP_EXTERN(rtReduceAsyncV2_part1);
TIMESTAMP_EXTERN(rtReduceAsyncV2_part2);

Context::Context(Device * const ctxDevice, const bool primaryCtx)
    : NoCopy(),
      device_(ctxDevice),
      defaultStream_(nullptr),
      onlineStream_(nullptr),
      moduleAllocator_(nullptr),
      isPrimary_(primaryCtx),
      taskGenCallback_(nullptr),
      count_(0U),
      isNeedDelete_(false),
      tearDownStatus_(TEARDOWN_NOT_EXECUTE),
      infMode_(true),
      failureError_(RT_ERROR_NONE),
      lastErr_(ACL_RT_SUCCESS),
      callBackThreadExist_(false)
{
}

Context::~Context()
{
    uint32_t i = 0U;
    while ((i < Runtime::maxProgramNum_) && (moduleAllocator_ != nullptr)) {
        if (!moduleAllocator_->CheckIdValid(i)) {
            i = moduleAllocator_->NextPoolFirstId(i);
            continue;
        }
        ReleaseModule(i);
        i++;
    }

    if (overflowAddr_ != nullptr) {
        const rtError_t error = device_->Driver_()->DevMemFree(overflowAddr_, device_->Id_());
        COND_LOG(error != RT_ERROR_NONE, "overflowAddr DevMemFree failed, retCode=%#x.", error);
        overflowAddr_ = nullptr;
        overflowAddrOffset_ = 0ULL;
    }
    sysParamOpt_.clear();
    DestroyContextCallBackThread();
    Runtime::Instance()->DeviceRelease(device_, isForceReset_);

    DELETE_O(moduleAllocator_);

    defaultStream_ = nullptr;
    onlineStream_ = nullptr;
    device_ = nullptr;
}

bool Context::ModelIsExistInContext(const Model *mdl)
{
    modelLock_.Lock();
    bool flag = false;
    for (auto it = models_.begin(); it != models_.end(); it++) {
        if ((*it != nullptr) && (*it == mdl)) {
            flag = true;
            break;
        }
    }
    modelLock_.Unlock();
    return flag;
}

bool Context::CheckCanFreeModulePool(uint32_t poolIdx)
{
    const uint32_t baseId = moduleAllocator_->AccumulatePoolCount(poolIdx);
    for (uint32_t index = baseId; index < baseId + DEFAULT_PROGRAM_NUMBER; index++) {
        Module ** const moduleItem = moduleAllocator_->GetDataToItemApplied(index);
        if (moduleItem == nullptr) {
            return false;
        }

        Module *mdl = *moduleItem;
        if (mdl != nullptr) {
            return false;
        }
    }
    return true;
}

void Context::TryToRecycleModulePool()
{
    const std::unique_lock<std::mutex> taskLock(moduleLock_);
    const uint32_t latestPoolIdx = Runtime::Instance()->GetLatestPoolIdx();
    TryToRecycleProgPool(latestPoolIdx);
    TryToRecycleCtxPool(latestPoolIdx);
    TryToRecycleDevPool(latestPoolIdx);
    return;
}

bool Context::CheckCanFreePorgPool(uint32_t poolIdx) const
{
    Runtime * const rt = Runtime::Instance();
    ObjAllocator<RefObject<Program *>> *programAllocator = rt->GetProgramAllocator();

    const uint32_t baseId = programAllocator->AccumulatePoolCount(poolIdx);
    for (uint32_t index = baseId; index < baseId + DEFAULT_PROGRAM_NUMBER; index++) {
        RefObject<Program *> * const refObj = programAllocator->GetDataToItemApplied(index);
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

void Context::TryToRecycleProgPool(uint32_t latestPoolIdx)
{
    Runtime * const rt = Runtime::Instance();
    ObjAllocator<RefObject<Program *>> *programAllocator = rt->GetProgramAllocator();

    if (programAllocator == nullptr) {
        return;
    }

    RefObject<Program *> **pool = programAllocator->GetObjAllocatorPool();
    if (pool == nullptr) {
        return;
    }

    std::mutex *progMtx = programAllocator->GetObjAllocatorMutex();
    if (progMtx == nullptr) {
        return;
    }

    RT_LOG(RT_LOG_EVENT, "recycle prog pool");
    const uint32_t poolNum = Runtime::maxProgramNum_ / DEFAULT_PROGRAM_NUMBER;
    const uint32_t newStartPoolIdx = latestPoolIdx + RECYCLE_POOL_ISOLATION_WIDTH;
    const uint32_t newEndPoolIdx = newStartPoolIdx + poolNum - 1U;
    for (uint32_t idx = newStartPoolIdx; idx <= newEndPoolIdx; idx++) {
        const uint32_t i = idx % poolNum;
        if (pool[i] == nullptr) {
            continue;
        }
        progMtx[i].lock();
        if (CheckCanFreePorgPool(i) == true) {
            programAllocator->RecyclePool(i);
        }
        progMtx[i].unlock();
    }
    return;
}

void Context::TryToRecycleCtxPool(uint32_t latestPoolIdx)
{
    if (moduleAllocator_ == nullptr) {
        return;
    }

    Module ***pool = moduleAllocator_->GetObjAllocatorPool();
    if (pool == nullptr) {
        return;
    }

    std::mutex *mdlMtx = moduleAllocator_->GetObjAllocatorMutex();
    if (mdlMtx == nullptr) {
        return;
    }
    const uint32_t poolNum = Runtime::maxProgramNum_ / DEFAULT_PROGRAM_NUMBER;
    const uint32_t newStartPoolIdx = latestPoolIdx + RECYCLE_POOL_ISOLATION_WIDTH;
    const uint32_t newEndPoolIdx = newStartPoolIdx + poolNum - 1U;
    for (uint32_t idx = newStartPoolIdx; idx <= newEndPoolIdx; idx++) {
        uint32_t i = idx % poolNum;
        if (pool[i] == nullptr) {
            continue;
        }

        mdlMtx[i].lock();
        if (CheckCanFreeModulePool(i) == true) {
            moduleAllocator_->RecyclePool(i);
        }
        mdlMtx[i].unlock();
    }
    return;
}

void Context::TryToRecycleDevPool(uint32_t latestPoolIdx) const
{
    device_->TryToRecycleModulesPool(latestPoolIdx);
    return;
}

// ms级算子超时和快恢使能后，使用此快速异常上报通道。
void Context::ProcessReportFastRingBuffer() const
{
    const bool isOpTimeoutMs = Runtime::Instance()->IsSupportOpTimeoutMs();
    if ((!isOpTimeoutMs) || (GetFailureError() != RT_ERROR_NONE)) {
        return;
    }
    device_->ProcessReportFastRingBuffer();
}

rtError_t Context::Init()
{
    moduleAllocator_ = new (std::nothrow) ObjAllocator<Module *>(DEFAULT_PROGRAM_NUMBER,
                                                                 Runtime::maxProgramNum_,
                                                                 true);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, moduleAllocator_ == nullptr, RT_ERROR_MODULE_NEW,
        "Context init failed, moduleAllocator_ can not be null.");

    const rtError_t error = moduleAllocator_->Init();
    ERROR_RETURN_MSG_INNER(error, "Context init failed, init moduleAllocator_ failed, retCode=%#x.", error);

    RT_LOG(RT_LOG_INFO, "Runtime_alloc_size is %zu.", sizeof(Module *) * DEFAULT_PROGRAM_NUMBER);

    sysParamOpt_.resize(SYS_OPT_RESERVED);
    return RT_ERROR_NONE;
}

void Context::TryAllocFastCq()
{
    bool flag = device_->GetFastCqFlag();
    if (!flag) {
        RT_LOG(RT_LOG_INFO, "No need to alloc fast cq");
        return;
    }
    onlineStream_ = StreamFactory::CreateStream(device_, 0U);
    if (onlineStream_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "new online stream failed");
        return;
    }
    RT_LOG(RT_LOG_INFO, "New onlineStream_ ok, Runtime_alloc_size %zu, stream_id=%d.",
        sizeof(Stream), onlineStream_->Id_());

    onlineStream_->SetNeedFastcqFlag();

    rtError_t error = onlineStream_->Setup();
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_INFO, "cannot alloc fast cq, use normal");
        device_->SetFastCqFlag(false);
        DeleteStream(onlineStream_);
        return;
    }
    onlineStream_->SetContext(this);
}

rtError_t Context::OnlineStreamInit(const rtChipType_t chipType)
{
    const rtRunMode runMode = static_cast<rtRunMode>(NpuDriver::RtGetRunMode());
    if ((IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_STREAM_ONLINE)) &&
        (runMode == RT_RUN_MODE_ONLINE)) {
        TryAllocFastCq();
    } else {
        // no operation
    }
    return RT_ERROR_NONE;
}

rtError_t Context::Setup()
{
    rtError_t error;
    const rtChipType_t chipType = device_->GetChipType();

    error = Init();
    ERROR_RETURN_MSG_INNER(error, "Init context failed, retCode=%#x", error);

    // set overflow addr
    if (overflowAddr_ == nullptr) {
        const rtMemType_t memType =
            (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TS_MEM_4G_SPACE_FOR_OVERFLOW)) ?
                RT_MEMORY_TS_4G :
                RT_MEMORY_DEFAULT;
        error = device_->Driver_()->DevMemAlloc(&overflowAddr_, OVERFLOW_ADDR_MAX_SIZE, memType, device_->Id_());
        if (unlikely(error == RT_ERROR_DRV_OUT_MEMORY)) {
            RT_LOG(RT_LOG_ERROR, "overflowAddr DevMemAlloc failed, retCode=%#x.", error);
        } else {
            ERROR_RETURN(error, "overflowAddr DevMemAlloc failed, retCode=%#x.", error);
            if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TS_MEM_4G_SPACE_FOR_OVERFLOW)) {
                error = device_->Driver_()->MemSetSync(overflowAddr_, OVERFLOW_ADDR_MAX_SIZE, 0U, OVERFLOW_ADDR_MAX_SIZE);
                ERROR_RETURN_MSG_INNER(
                    error, "Memset value failed, size=%#" PRIx64 "(bytes), retCode=%#x!",
                    static_cast<uint64_t>(OVERFLOW_ADDR_MAX_SIZE), static_cast<uint32_t>(error));
                error = device_->Driver_()->MemAddressTranslate(
                    static_cast<int32_t>(device_->Id_()), RtPtrToValue<void*>(overflowAddr_), &overflowAddrOffset_);
                ERROR_RETURN_MSG_INNER(error, "Trans overflowAddr failed retCode=%#x!", static_cast<uint32_t>(error));
            }
        }
    }
    if (isPrimary_) {
        defaultStream_ = device_->PrimaryStream_();
        COND_RETURN_ERROR_MSG_INNER(defaultStream_ == nullptr, RT_ERROR_CONTEXT_DEFAULT_STREAM_NULL, "Set up failed, default stream is null.");
    } else {
        uint32_t stmFlag = RT_STREAM_PRIMARY_DEFAULT;
        if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
            stmFlag = RT_STREAM_PRIMARY_DEFAULT | RT_STREAM_FAST_LAUNCH | RT_STREAM_FAST_SYNC;
        }
        defaultStream_ = StreamFactory::CreateStream(device_, 0U, stmFlag);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, defaultStream_ == nullptr, RT_ERROR_STREAM_NEW, "Setup context failed, new Stream failed.");
        RT_LOG(RT_LOG_INFO, "New defaultStream_ ok, Runtime_alloc_size %zu, stream_id=%d.", sizeof(Stream), defaultStream_->Id_());

        error = defaultStream_->Setup();
        ERROR_PROC_RETURN_MSG_INNER(error, DeleteStream(defaultStream_);,
            "Set up failed, default stream setup failed, retCode=%#x.", error);
    }

    defaultStream_->SetContext(this);

    // need sync for get tsch version value succ
    const bool syncFlag = ((defaultStream_->Flags() & RT_STREAM_PRIMARY_FIRST_DEFAULT) != 0U) && (!(device_->IsStarsPlatform()));
    if (syncFlag) {
        error = defaultStream_->Synchronize(true);
        COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
            "Set up failed, failed to synchronize primaryStream.");
    }

    return OnlineStreamInit(chipType);
}

rtError_t Context::TearDown()
{
    TIMESTAMP_NAME(__func__);
    modelLock_.Lock();
    for (Model *tdModel : models_) {
        RT_LOG(RT_LOG_INFO, "Tear down model abandon, model_id=%u.", tdModel->Id_());
        delete tdModel;
        tdModel = nullptr;
    }

    modelLock_.Unlock();
    std::unique_lock<std::mutex> taskLock(streamLock_);
    for (Stream * const tdStream : streams_) {
        RT_LOG(RT_LOG_INFO, "Tear down stream abandon, stream_id=%d.", tdStream->Id_());
        (void) TearDownStream(tdStream);
    }
    taskLock.unlock();
    rtError_t error = RT_ERROR_NONE;
    if (onlineStream_ != nullptr) {
        error = TearDownStream(onlineStream_);
        COND_LOG_ERROR(error != RT_ERROR_NONE, "Tear down online stream failed, retCode=%#x.", error);
        onlineStream_ = nullptr;
    } else {
        // no operation
    }

    const Stream *defaultStream = defaultStream_;
    NULL_PTR_RETURN_MSG(defaultStream, RT_ERROR_CONTEXT_DEFAULT_STREAM_NULL);
    if (!isPrimary_) {
        error = TearDownStream(defaultStream_);
        defaultStream_ = nullptr;
    }
    if (InnerThreadLocalContainer::GetCurCtx() == this) {
        InnerThreadLocalContainer::SetCurCtx(nullptr);
    }
    return error;
}

rtError_t Context::TearDownStream(Stream *stm, bool flag) const
{
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    bool isDelSelfStream = false;

    COND_RETURN_ERROR_MSG_INNER(stm->Model_() != nullptr, RT_ERROR_STREAM_MODEL,
        "Tear down stream failed, stream is bound, stream_id=%d, model_id=%u, retCode=%#x.",
        stm->Id_(), stm->Model_()->Id_(), RT_ERROR_STREAM_INVALID);
    for (uint32_t type = 0U; type < RT_HOST_TASK_TYPE_MAX; type++) {
        if (!(stm->IsPendingListEmpty(type))) {
            (void)stm->ExecPendingList(type);
        }
    }
    isDelSelfStream = stm->NeedDelSelfStream();
    if ((device_->GetType_() == Device::STUB_DEVICE) || isDelSelfStream) {
        DeleteStream(stm);
        return RT_ERROR_NONE;
    }
    if (!Runtime::Instance()->IsExiting()) {
        StreamStateCallbackManager::Instance().Notify(stm, false);
    }
    const rtError_t error = stm->TearDown(false, flag);
    ERROR_GOTO_MSG_INNER(error, ERROR_FREE_STREAM, "Stream teardown failed, retCode=%#x.", error);

ERROR_FREE_STREAM:
    const Runtime * const rtInstance = Runtime::Instance();
    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_STREAM_DELETE_FORCE)|| (rtInstance->GetDisableThread())) {
        DeleteStream(stm);
    }
    return error;
}

rtError_t Context::SyncStreamsWithTimeout(const std::list<Stream *> &streams, int32_t timeout, const mmTimespec start) const
{
    rtError_t error;
    rtError_t firstError = RT_ERROR_NONE;
    int32_t remainTime = timeout;
    COND_RETURN_ERROR_MSG_INNER(IsProcessTimeout(start, timeout, &remainTime), RT_ERROR_STREAM_SYNC_TIMEOUT,
        "Sync stream timeout, before sync stream.");

    for (const auto &syncStream : streams) {
        if (device_->GetDeviceStatus() == RT_ERROR_DEVICE_TASK_ABORT) {
            RT_LOG(RT_LOG_ERROR, "device is abort, device_id=%d.", device_->Id_());
            return RT_ERROR_DEVICE_TASK_ABORT;
        }
        if (syncStream->IsSyncFinished()) {
            continue;
        }

        error = syncStream->Synchronize(false, remainTime);
        COND_RETURN_ERROR_MSG_INNER(IsProcessTimeout(start, timeout, &remainTime), RT_ERROR_STREAM_SYNC_TIMEOUT,
            "Sync stream timeout, stream_id=%d.", syncStream->Id_());

        if (unlikely(error != RT_ERROR_NONE)) {
            RT_LOG(RT_LOG_ERROR, "Synchronize stream fail, stream_id=%d, errorCode=%#x.", syncStream->Id_(), error);
            if (GetCtxMode() != CONTINUE_ON_FAILURE) {
                return error;
            } else if (firstError == RT_ERROR_NONE) {
                firstError = error;
            }
        }
    }

    error = defaultStream_->Synchronize(false, remainTime);
    COND_RETURN_ERROR_MSG_INNER(IsProcessTimeout(start, timeout, &remainTime), RT_ERROR_STREAM_SYNC_TIMEOUT,
        "Sync stream timeout, default stream.");

    if (unlikely((error != RT_ERROR_NONE) && (firstError == RT_ERROR_NONE))) {
        firstError = error;
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Synchronize defaultStream fail, retCode=%#x.", error);
    }

    return firstError;
}

rtError_t Context::TaskReclaimforSyncDevice(const mmTimespec startTime, int32_t timeout)
{
    rtError_t firstError = RT_ERROR_NONE;
    rtError_t error = RT_ERROR_NONE;
    uint32_t totalStream = 0U;
    uint32_t reclaimStream = 0U;
    constexpr uint16_t perSchedYield = 1000U;
    uint32_t tryCount = 0U;

    while (true) {
        totalStream = 0U;
        reclaimStream = 0U;

        for (const auto &syncStream : streams_) {
            if (IsStreamNotSync(syncStream->Flags())) {
                continue;
            }
            if (syncStream->IsSeparateSendAndRecycle()) {
                if (!syncStream->Device_()->GetIsDoingRecycling()) {
                    syncStream->Device_()->WakeUpRecycleThread();
                }
                return RT_ERROR_NONE;
            }

            syncStream->isDeviceSyncFlag = true;
            uint32_t taskId = MAX_UINT16_NUM;
            syncStream->StreamSyncLock();
            if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL)) {
                error = TaskReclaimByStream(syncStream, false);
            } else {
                error = device_->TaskReclaim(static_cast<uint32_t>(syncStream->Id_()), false, taskId);
            }
            syncStream->StreamSyncUnLock();
            syncStream->isDeviceSyncFlag = false;
            const rtError_t ctxStatus = CheckStatus(syncStream);
            COND_RETURN_ERROR(ctxStatus != RT_ERROR_NONE, ctxStatus, "context is abort, status=%#x.", static_cast<uint32_t>(ctxStatus));
           
            COND_RETURN_ERROR_MSG_INNER(IsProcessTimeout(startTime, timeout), RT_ERROR_STREAM_SYNC_TIMEOUT,
                "Sync stream timeout=%dms, stream_id=%d.", timeout, syncStream->Id_());

            if (error == RT_ERROR_STREAM_SYNC_TIMEOUT) {
                RT_LOG(RT_LOG_ERROR, "sync stream timeout=%dms, stream_id=%d, retCode=%#x.", timeout, syncStream->Id_(), error);
                return RT_ERROR_STREAM_SYNC_TIMEOUT;
            } else if ((error != RT_ERROR_NONE) && (firstError == RT_ERROR_NONE)) {
                firstError = error;
                RT_LOG(RT_LOG_ERROR, "sync stream fail, stream_id=%d, retCode=%#x.", syncStream->Id_(), error);
            } else {
                // do nothing
            }

            COND_RETURN_ERROR((firstError != RT_ERROR_NONE), firstError, "Synchronize streams, retCode=%#x.", firstError);

            totalStream++;
            tryCount++;
            if (syncStream->GetPendingNum() < 20U) {
                reclaimStream++;
            }
        }
        if ((reclaimStream + 1U) >= totalStream) {
            break;
        }

        if ((tryCount % perSchedYield) == 0) {
            COND_RETURN_ERROR((device_->GetDevRunningState() == static_cast<uint32_t>(DEV_RUNNING_DOWN)),
                RT_ERROR_DRV_ERR, "device_id=%u is down", device_->Id_());
            COND_RETURN_ERROR_MSG_INNER(IsProcessTimeout(startTime, timeout), RT_ERROR_STREAM_SYNC_TIMEOUT,
                "Sync stream timeout=%dms, device_id=%d.", timeout, device_->Id_());
            (void)sched_yield();
        }

    }
    return firstError;
}

bool Context::IsStreamNotSync(const uint32_t flags) const
{
    bool isNotSync = false;
    if ((device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_STREAM_DOT_SYNC))) {
        isNotSync = ((flags &
            static_cast<uint32_t>(RT_STREAM_AICPU | RT_STREAM_PERSISTENT | RT_STREAM_CP_PROCESS_USE)) != 0U);
    } else {
        isNotSync = ((flags & static_cast<uint32_t>(RT_STREAM_CP_PROCESS_USE)) != 0U);
    }
    return isNotSync;
}
rtError_t Context::SyncAllStreamToGetError()
{
    rtError_t error = RT_ERROR_NONE;
    const std::unique_lock<std::mutex> taskLock(streamLock_);
    for (const auto &syncStream : streams_) {
        (void)syncStream->Synchronize(false, -1);
        error = syncStream->CheckContextStatus();
        COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "context get error, status=%#x.", static_cast<uint32_t>(error));
    }
    return error;
}

rtError_t Context::Synchronize(int32_t timeout)
{
    const Stream *defaultStream = defaultStream_;
    NULL_PTR_RETURN_MSG(defaultStream, RT_ERROR_CONTEXT_DEFAULT_STREAM_NULL);

    TIMESTAMP_NAME(__func__);
    const std::unique_lock<std::mutex> taskLock(streamLock_);
    std::list<Stream *> syncStreams;

    for (const auto &syncStream : streams_) {
        if (IsStreamNotSync(syncStream->Flags()) || syncStream->IsSyncFinished()) {
            continue;
        }
        COND_RETURN_ERROR(syncStream->IsCapturing(),
            RT_ERROR_STREAM_CAPTURED, "Not allow to synchronize captured-stream, device_id=%u, stream_id=%d.",
            device_->Id_(), syncStream->Id_());
        syncStreams.push_back(syncStream);
    }

    const mmTimespec startTime = mmGetTickCount();

    // TaskReclaim
    (void)TaskReclaimforSyncDevice(startTime, timeout);

    return SyncStreamsWithTimeout(syncStreams, timeout, startTime);
}

rtError_t Context::KernelTaskConfig(TaskInfo * const configTask, const void * const kernSoName,
    const void * const kernelName, ArgLoaderResult * const result,
    const uint32_t smArgsSize, const uint32_t argsSize)
{
    SetArgs(configTask, result->kerArgs, argsSize, result->smArgs, smArgsSize, result->handle);

    // AICPU branch, modify for KernelLaunch performance optimization
    if (configTask->type == TS_TASK_TYPE_KERNEL_AICPU) {
        SetNameArgs(configTask, kernSoName, kernelName);
    }
    // handle is owned by task.
    result->handle = nullptr;
    return RT_ERROR_NONE;
}

rtError_t Context::ConfigPCTraceTask(const Kernel * const registeredKernel, std::shared_ptr<PCTrace> &rtPCTrace,
    const uint32_t coreDim, Stream * const stm, const uint16_t taskId, Module * const mdl)
{
    const int32_t streamId = stm->Id_();
    const uint32_t pcTraceFlag = registeredKernel->PctraceFlag();
    if (likely((pcTraceFlag != FUNC_MODE_PCTRACE_USERPROFILE_RECORDLOOP) &&
               (pcTraceFlag != FUNC_MODE_PCTRACE_USERPROFILE_SKIPLOOP) &&
               (pcTraceFlag != FUNC_MODE_PCTRACE_CYCLECNT_RECORDLOOP) &&
               (pcTraceFlag != FUNC_MODE_PCTRACE_CYCLECNT_SKIPLOOP))) {
        RT_LOG(RT_LOG_DEBUG, "kernel is not in pc trace mode, stream_id=%d, task_id=%u.",
            streamId, static_cast<uint32_t>(taskId));
        return RT_ERROR_NONE;
    }

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *rtPCTraceTask = nullptr;
    void *pcTraceAddr = nullptr;
    const uint64_t addrSize = (static_cast<uint32_t>(coreDim * Runtime::macroValue_.pctraceFileLength)) +
                               Runtime::macroValue_.pctraceFileHead;

    RT_LOG(RT_LOG_INFO, "kernel is in pc trace mode, stream_id=%d, task_id=%u.",
        streamId, static_cast<uint32_t>(taskId));
    rtPCTrace.reset(new(std::nothrow) PCTrace());
    NULL_PTR_RETURN_MSG(rtPCTrace, RT_ERROR_PCTRACE_NEW);

    rtError_t error = rtPCTrace->Init(device_, mdl);
    ERROR_GOTO_MSG_INNER(error, ERROR_PCTRACE_RECYCLE, "Init pc trace failed, retCode=%#x.", error);

    error = rtPCTrace->AllocPCTraceMemory(&pcTraceAddr, addrSize);
    ERROR_GOTO_MSG_INNER(error, ERROR_PCTRACE_RECYCLE, "Alloc pc trace memory failed, retCode=%#x.", error);

    rtPCTraceTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_PCTRACE_ENABLE, errorReason);
    NULL_PTR_GOTO_MSG_INNER(rtPCTraceTask, ERROR_PCTRACE_RECYCLE, error, errorReason);

    error = PCTraceTaskInit(rtPCTraceTask, taskId, static_cast<uint16_t>(coreDim), rtPCTrace);
    ERROR_GOTO_MSG_INNER(error, ERROR_PCTRACE_TASK_RECYCLE,
        "Init pc trace task failed, stream_id=%d, task_id=%u, retCode=%#x.",
        streamId, static_cast<uint32_t>(taskId), error);

    error = device_->SubmitTask(rtPCTraceTask);
    ERROR_GOTO_MSG_INNER(error, ERROR_PCTRACE_TASK_RECYCLE, "Submit pc trace task failed, retCode=%#x.", error);
    return RT_ERROR_NONE;

ERROR_PCTRACE_TASK_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtPCTraceTask);
ERROR_PCTRACE_RECYCLE:
    rtPCTrace.reset();
    return error;
}

TIMESTAMP_EXTERN(rtKernelLaunch_KernelLookup);
TIMESTAMP_EXTERN(rtKernelLaunch_ALLKernelLookup);
TIMESTAMP_EXTERN(rtKernelLaunch_GetModule);
TIMESTAMP_EXTERN(rtKernelLaunch_AllocTask);
TIMESTAMP_EXTERN(rtKernelLaunch_SubmitTask);
TIMESTAMP_EXTERN(rtKernelLaunch_PutProgram);
TIMESTAMP_EXTERN(rtKernelLaunch_ArgLoad);
TIMESTAMP_EXTERN(rtKernelLaunch_ArgLoadForMix);
TIMESTAMP_EXTERN(rtKernelLaunch_ArgLoad_Lite);
TIMESTAMP_EXTERN(rtKernelLaunch_ArgLoadAll);
TIMESTAMP_EXTERN(rtKernelLaunch_ArgLoadAllForMix);
TIMESTAMP_EXTERN(rtKernelLaunch_ArgLoadAll_LITE);
TIMESTAMP_EXTERN(rtLaunchKernel_ArgLoadAll);
TIMESTAMP_EXTERN(rtLaunchKernel_ArgLoadAll_LITE);
TIMESTAMP_EXTERN(rtKernelLaunchWithHandle_SubMit);
TIMESTAMP_EXTERN(rtLaunchKernel_SubMit);
TIMESTAMP_EXTERN(rtKernelLaunch_CpuArgLoad);

rtError_t Context::LaunchKernelPrepare(uint32_t &smArgsSize,
    Kernel *&registeredKernel, Program *&prog, uint32_t &kernelType, Module *&mdl, const void * const stubFunc,
    rtL2Ctrl_t *&l2ctrl, uint64_t &addr1, uint64_t &addr2, void * const progHandle, const uint64_t tilingKey,
    uint32_t &prefetchCnt1, uint32_t &prefetchCnt2)
{
    UNUSED(smArgsSize);
    UNUSED(l2ctrl);
    rtError_t error = RT_ERROR_NONE;

    if (progHandle == nullptr) {
        Runtime * const rt = Runtime::Instance();
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
    // 如果tiling key为默认值，则依赖tilingKey的信息做默认值初始化
    if (tilingKey == DEFAULT_TILING_KEY) {
        prog = nullptr;
        kernelType = Program::MACH_AI_CORE;
        if (device_->GetDevProperties().enabledTSNum == ENABLED_TS_NUM_2) {
            const uint32_t tsId = device_->DevGetTsId();
            COND_RETURN_ERROR_MSG_INNER(((kernelType == Program::MACH_AI_CORE) && (tsId == 1U)) ||
                ((kernelType == Program::MACH_AI_VECTOR) && (tsId == 0U)), RT_ERROR_PROGRAM_MACHINE_TYPE,
                "Launch kernel failed, current ts doesn't support the task! type=%u, tsid=%u.", kernelType, tsId);
        }
        addr1 = 0ULL;
        addr2 = 0ULL;
        prefetchCnt1 = 0U;
        prefetchCnt2 = 0U;

        return RT_ERROR_NONE;
    }

    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_TBE, (registeredKernel == nullptr), RT_ERROR_KERNEL_NULL,
        "Can not find kernel by function[0x%" PRIx64"], tilingKey=%" PRIu64 ".",
        RtPtrToValue<const void *>(stubFunc), tilingKey);

    TIMESTAMP_BEGIN(rtKernelLaunch_GetModule);
    prog = registeredKernel->Program_();
    NULL_PTR_RETURN_MSG(prog, RT_ERROR_PROGRAM_NULL);
    COND_RETURN_ERROR_MSG_INNER((progHandle != nullptr) && (prog != RtPtrToPtr<Program *, void *>(progHandle)),
        RT_ERROR_PROGRAM_BASE, "Kernel prog is not belong to the launch prog.");

    kernelType = prog->Machine();
    if (kernelType == Program::MACH_AI_MIX_KERNEL) {
        kernelType = registeredKernel->KernelType_();
    }
    COND_RETURN_ERROR_MSG_INNER(kernelType == Program::MACH_INVALID_CPU,
        RT_ERROR_PROGRAM_MACHINE_TYPE,
        "Launch kernel failed, machine failed! invalid type, current kernelType=%u,"
        " valid kernelType range is [%u, %u].",
        kernelType, Program::MACH_AI_CORE, Program::MACH_AI_CVMIX);
    COND_RETURN_ERROR_MSG_INNER(kernelType == Program::MACH_AI_CPU,
        RT_ERROR_FEATURE_NOT_SUPPORT,
        "Launch kernel failed, not support CCE Aicpu kernel task, type=%u.", kernelType);

    if (device_->GetDevProperties().enabledTSNum == ENABLED_TS_NUM_2) {
        const uint32_t tsId = device_->DevGetTsId();
        COND_RETURN_ERROR_MSG_INNER(((kernelType == Program::MACH_AI_CORE) && (tsId == 1U)) ||
            ((kernelType == Program::MACH_AI_VECTOR) && (tsId == 0U)), RT_ERROR_PROGRAM_MACHINE_TYPE,
            "Launch kernel failed, current ts doesn't support the task! type=%u, tsid=%u.", kernelType, tsId);
    }
    mdl = GetModule(prog);
    TIMESTAMP_END(rtKernelLaunch_GetModule);
    NULL_PTR_RETURN_MSG(mdl, RT_ERROR_MODULE_NEW);

    // Function always return RT_ERROR_NONE, modify for KernelLaunch performance optimization
    const Kernel *kernel = registeredKernel;
    (void)mdl->GetFunction(kernel, &addr1, &addr2);
    (void)mdl->GetPrefetchCnt(kernel, prefetchCnt1, prefetchCnt2);
    return error;
}

rtError_t Context::UpdateTaskPrepare(TaskInfo * const updateTask, const Kernel * const kernel, const uint32_t kernelType,
                                     const Stream * const stm) const
{
    COND_RETURN_ERROR(stm->IsCapturing(), RT_ERROR_STREAM_CAPTURED,
        "The stream used for updating task cannot be in capture status, device_id=%u, stream_id=%d",
        device_->Id_(), stm->Id_());

    if (updateTask->stream->Model_() == nullptr) {
        RT_LOG(RT_LOG_ERROR, "The update task must be a sinked task, device_id=%u, stream_id=%d, task_id=%hu.",
            device_->Id_(), updateTask->stream->Id_(), updateTask->id);
        return RT_ERROR_MODEL_NULL;
    }

    if (stm->Model_() != nullptr) {
        RT_LOG(RT_LOG_ERROR, "The update stream must be a single operator stream, "
            "device_id=%u, stream_id=%d, task_id=%hu.",
            device_->Id_(), updateTask->stream->Id_(), updateTask->id);
        return RT_ERROR_STREAM_MODEL;
    }

    if ((updateTask->u.aicTaskInfo.kernel->GetMixType() != kernel->GetMixType()) ||
        (updateTask->u.aicTaskInfo.kernel->GetFuncType() != kernel->GetFuncType()) ||
        (updateTask->u.aicTaskInfo.machine != static_cast<uint8_t>(kernelType))) {
        RT_LOG(RT_LOG_ERROR, "check kernel type failed, device_id=%u, stream_id=%d, task_id=%hu, "
            "old mixType=%u, funcType=%u, machine=%u, "
            "new mixType=%u, funcType=%u, machine=%u.",
            device_->Id_(), updateTask->stream->Id_(), updateTask->id, updateTask->u.aicTaskInfo.kernel->GetMixType(),
            updateTask->u.aicTaskInfo.kernel->GetFuncType(), updateTask->u.aicTaskInfo.machine,
            kernel->GetMixType(), kernel->GetFuncType(), kernelType);
        return RT_ERROR_KERNEL_TYPE;
    }

    if (updateTask->u.aicTaskInfo.kernel->GetMixType() == NO_MIX) {
        if (!(device_->CheckFeatureSupport(TS_FEATURE_CAPTURE_SQE_UPDATE))) {
            RT_LOG(RT_LOG_ERROR, "current ts version does not support update no mix op, kernel name=%s, "
                "drv devId=%u, stream_id=%d, task_id=%hu.",
                kernel->Name_().c_str(), device_->Id_(), updateTask->stream->Id_(), updateTask->id);
            return RT_ERROR_DRV_NOT_SUPPORT_UPDATE_OP;
        }
        updateTask->u.aicTaskInfo.updateSqeOffset = 0U;
    }

    return RT_ERROR_NONE;
}

rtError_t Context::UpdateMixKernelTask(TaskInfo * const updateTask, Stream * const stm) const
{
    TaskInfo submitTask = {};
    rtError_t errorReason;
    void *hostAddr = nullptr;
    constexpr uint64_t copySize = CONTEXT_LEN;
    Driver * const curDrv = stm->Device_()->Driver_();
    AicTaskInfo *aicTaskInfo = &(updateTask->u.aicTaskInfo);
    void *dstContextAddr = aicTaskInfo->descAlignBuf;
    void *oldArgHandle = aicTaskInfo->oldArgHandle;

    TaskInfo *rtMemcpyAsyncTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_MEMCPY, errorReason, 1U, UpdateTaskFlag::NOT_SUPPORT_AND_SKIP);
    NULL_PTR_RETURN_MSG(rtMemcpyAsyncTask, errorReason);

    rtError_t error = MixKernelUpdatePrepare(updateTask, &hostAddr, copySize);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, stream_id=%d, allocSize=%llu, retCode=%#x.",
            device_->Id_(), stm->Id_(), copySize, error);
        goto ERROR_RECYCLE;
    }

    error = SqeUpdateH2DTaskInit(rtMemcpyAsyncTask, hostAddr, dstContextAddr, copySize, oldArgHandle);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, stream_id=%d, allocSize=%llu, retCode=%#x.",
            device_->Id_(), stm->Id_(), copySize, error);
        (void)curDrv->HostMemFree(hostAddr);
        goto ERROR_RECYCLE;
    }

    // oldArgHandle will be released by releaseArgHandle of the H2D task
    aicTaskInfo->oldArgHandle = nullptr;

    error = device_->SubmitTask(rtMemcpyAsyncTask, taskGenCallback_);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, stream_id=%d, allocSize=%u, retCode=%#x.",
            device_->Id_(), stm->Id_(), copySize, error);
        goto ERROR_RECYCLE;
    }

    GET_THREAD_TASKID_AND_STREAMID(rtMemcpyAsyncTask, stm->AllocTaskStreamId());
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtMemcpyAsyncTask);
    return error;
}

rtError_t Context::UpdateNormalKernelTaskH2DSubmitComm(TaskInfo * const updateTask, Stream * const stm, void * const targetAddrOfUpdatedSqe) const
{
    TaskInfo submitTask = {};
    rtError_t errorReason;
    constexpr uint64_t allocSize = sizeof(rtStarsSqe_t);
    Driver * const curDrv = stm->Device_()->Driver_();
    void *hostAddr = nullptr;
    AicTaskInfo *aicTaskInfo = &(updateTask->u.aicTaskInfo);
    void *oldArgHandle = aicTaskInfo->oldArgHandle;

    TaskInfo *rtMemcpyAsyncTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_MEMCPY, errorReason, 1U, UpdateTaskFlag::NOT_SUPPORT_AND_SKIP);
    NULL_PTR_RETURN_MSG(rtMemcpyAsyncTask, errorReason);

    rtError_t error = NormalKernelUpdatePrepare(updateTask, &hostAddr, allocSize);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "prepare failed, device_id=%u, stream_id=%d, allocSize=%llu, retCode=%#x.",
            device_->Id_(), stm->Id_(), allocSize, error);
        goto ERROR_RECYCLE;
    }

    error = SqeUpdateH2DTaskInit(rtMemcpyAsyncTask, hostAddr, targetAddrOfUpdatedSqe, allocSize, oldArgHandle);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, stream_id=%d, allocSize=%llu, retCode=%#x.",
            device_->Id_(), stm->Id_(), allocSize, error);
        (void)curDrv->HostMemFree(hostAddr);
        goto ERROR_RECYCLE;
    }

    // oldArgHandle will be released by releaseArgHandle of the H2D task
    aicTaskInfo->oldArgHandle = nullptr;

    error = device_->SubmitTask(rtMemcpyAsyncTask, taskGenCallback_);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, stream_id=%d, allocSize=%u, retCode=%#x.",
            device_->Id_(), stm->Id_(), allocSize, error);
        goto ERROR_RECYCLE;
    }

    GET_THREAD_TASKID_AND_STREAMID(rtMemcpyAsyncTask, stm->AllocTaskStreamId());
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtMemcpyAsyncTask);
    return error;
}

rtError_t Context::UpdateNormalKernelTaskH2DSubmit(TaskInfo * const updateTask, Stream * const stm) const
{
    AicTaskInfo *aicTaskInfo = &(updateTask->u.aicTaskInfo);
    void *targetAddrOfUpdatedSqe = aicTaskInfo->sqeDevBuf;
    return UpdateNormalKernelTaskH2DSubmitComm(updateTask, stm, targetAddrOfUpdatedSqe);
}

rtError_t Context::UpdateNormalKernelTaskD2HSubmit(TaskInfo * const updateTask, Stream * const stm) const
{
    TaskInfo submitTask = {};
    rtError_t errorReason;
    constexpr size_t allocSize = sizeof(rtStarsSqe_t);
    const size_t copySize = allocSize - updateTask->u.aicTaskInfo.updateSqeOffset;
    void *sqeDevBuf = updateTask->u.aicTaskInfo.sqeDevBuf;
    const uint32_t sqId = updateTask->stream->GetSqId();
    const uint32_t pos = updateTask->pos;

    TaskInfo *rtMemcpyAsyncTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_MEMCPY, errorReason, 1U, UpdateTaskFlag::NOT_SUPPORT_AND_SKIP);
    NULL_PTR_RETURN_MSG(rtMemcpyAsyncTask, errorReason);

    rtError_t error = UpdateD2HTaskInit(rtMemcpyAsyncTask, sqeDevBuf, copySize, sqId, pos,
                                                    updateTask->u.aicTaskInfo.updateSqeOffset);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, stream_id=%d, allocSize=%u, retCode=%#x.",
            device_->Id_(), stm->Id_(), allocSize, error);
        goto ERROR_RECYCLE;
    }

    error = device_->SubmitTask(rtMemcpyAsyncTask, taskGenCallback_);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, stream_id=%d, allocSize=%u, retCode=%#x.",
            device_->Id_(), stm->Id_(), allocSize, error);
        goto ERROR_RECYCLE;
    }

    GET_THREAD_TASKID_AND_STREAMID(rtMemcpyAsyncTask, stm->AllocTaskStreamId());
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtMemcpyAsyncTask);
    return error;
}

rtError_t Context::UpdateNormalKernelTaskForSoftwareSq(TaskInfo * const updateTask, Stream * const stm) const
{
    if (updateTask->stream->GetSqBaseAddr() == 0ULL) {
        /* 
         * normal capture mode场景：SqBaseAddr在CaptureModel::SendSqe()函数中申请，即在CaptureModel执行前申请SqMem
         * 但存在update task在capture mode执行前下发的场景，需要提前申请SqMem
         * 预留的CAPTURE_TASK_RESERVED_NUM(32)个SQE用于CaptureModel执行时申请的LoadComplete等SQE
         */
        const rtError_t ret = updateTask->stream->AllocSoftwareSqAddr(CAPTURE_TASK_RESERVED_NUM); 
        COND_RETURN_ERROR((ret != RT_ERROR_NONE), ret, "AllocSoftwareSqAddr failed. device_id=%u, stream_id=%d, "
            "retCode=%#x,", device_->Id_(), updateTask->stream->Id_(), ret);
    }

    void *targetAddrOfUpdatedSqe = RtValueToPtr<void *>(updateTask->stream->GetSqBaseAddr() + (updateTask->pos * sizeof(rtStarsSqe_t)));
    return UpdateNormalKernelTaskH2DSubmitComm(updateTask, stm, targetAddrOfUpdatedSqe);
}

rtError_t Context::UpdateNormalKernelTask(TaskInfo * const updateTask, Stream * const stm) const
{
    rtError_t error = RT_ERROR_NONE;
    if (updateTask->stream->IsSoftwareSqEnable()) {
        error = UpdateNormalKernelTaskForSoftwareSq(updateTask, stm);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "submit D2H task failed, device_id=%u, stream_id=%d, retCode=%#x.",
                device_->Id_(), stm->Id_(), error);
        }
        return error;
    }

    error = UpdateNormalKernelTaskH2DSubmit(updateTask, stm);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "submit H2D task failed, device_id=%u, stream_id=%d, retCode=%#x.",
            device_->Id_(), stm->Id_(), error);
        return error;
    }

    error = UpdateNormalKernelTaskD2HSubmit(updateTask, stm);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "submit D2H task failed, device_id=%u, stream_id=%d, retCode=%#x.",
            device_->Id_(), stm->Id_(), error);
        return error;
    }

    return RT_ERROR_NONE;
}

rtError_t Context::UpdateEndGraphTask(Stream * const origCaptureStream, Stream * const exeStream, Notify *ntf)
{
    uint16_t taskId = origCaptureStream->GetLastTaskId();
    TaskInfo *rtNotifyRecord = origCaptureStream->Device_()->GetTaskFactory()->GetTask(origCaptureStream->Id_(), taskId);
    COND_RETURN_ERROR(rtNotifyRecord == nullptr, RT_ERROR_STREAM_CAPTURED, "EndGraph task is NULL");

    COND_RETURN_ERROR(rtNotifyRecord->type != TS_TASK_TYPE_NOTIFY_RECORD, RT_ERROR_STREAM_INVALID,
        "EndGraph task type=%u", rtNotifyRecord->type);
    rtNotifyRecord->u.notifyrecordTask.notifyId = ntf->GetNotifyId();
    rtStarsSqe_t sqeMem = {};
    ConstructSqeForNotifyRecordTask(rtNotifyRecord, &sqeMem);

    void *targetAddrOfUpdatedSqe = RtValueToPtr<void *>(origCaptureStream->GetSqBaseAddr() +
        (rtNotifyRecord->pos * sizeof(rtStarsSqe_t)));
    uint64_t realSize = 0U;
    auto error = MemcpyAsync(targetAddrOfUpdatedSqe, sizeof(rtStarsSqe_t), &sqeMem, sizeof(sqeMem),
        RT_MEMCPY_HOST_TO_DEVICE_EX, exeStream, &realSize);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "update task fail error=0x%x", error);
    RT_LOG(RT_LOG_WARNING, "exec stream_id=%d target stream_id=%u pos=%u",
        exeStream->Id_(), origCaptureStream->Id_(), rtNotifyRecord->pos);
    return error;
}

rtError_t Context::LaunchUpdateKernelSubmit(TaskInfo * const updateTask, Stream * const stm, const rtArgsEx_t * const argsInfo,
                                            ArgLoaderResult &result, const uint32_t smArgsSize)
{
    Runtime * const rt = Runtime::Instance();
    const Program * const programPtr = updateTask->u.aicTaskInfo.kernel->Program_();
    rtError_t error;
    Model *model = updateTask->stream->Model_();
    ArgLoader * const argLoaderObj = Device_()->ArgLoader_();

    if (result.handle != nullptr) {
        /* get old argHandle */
        void *oldArgHandle = model->GetArgHandle(static_cast<uint16_t>(updateTask->stream->Id_()), updateTask->id);
        updateTask->u.aicTaskInfo.oldArgHandle = oldArgHandle;

        /* update argHandle */
        SetArgs(updateTask, result.kerArgs, argsInfo->argsSize, result.smArgs, smArgsSize, nullptr);
        model->ReplaceArgHandle(static_cast<uint32_t>(updateTask->stream->Id_()), updateTask->id, result.handle);
        result.handle = nullptr;
    }

    if (updateTask->u.aicTaskInfo.kernel->GetMixType() != NO_MIX) {
        error = UpdateMixKernelTask(updateTask, stm);
    } else {
        error = UpdateNormalKernelTask(updateTask, stm);
    }

    if ((error != RT_ERROR_NONE) && (updateTask->u.aicTaskInfo.oldArgHandle != nullptr)) {
        (void)argLoaderObj->Release(updateTask->u.aicTaskInfo.oldArgHandle);
    }

    updateTask->u.aicTaskInfo.oldArgHandle = nullptr;

    ERROR_RETURN_MSG_INNER(error, "Failed to submit kernel update task, device_id=%u, stream_id=%d, task_id=%hu, "
        "retCode=%#x.", device_->Id_(), updateTask->stream->Id_(), updateTask->id, error);

    rt->PutProgram(programPtr);

    updateTask->isUpdateSinkSqe = 0U;

    return error;
}

rtError_t Context::LaunchKernelSubmit(TaskInfo *&submitTask, Stream *&stm, const rtArgsEx_t *&argsInfo,
    ArgLoaderResult &result, const uint32_t smArgsSize, const Program * const programPtr)
{
    if (submitTask->isUpdateSinkSqe == 1U) {
        return LaunchUpdateKernelSubmit(submitTask, stm, argsInfo, result, smArgsSize);
    }

    Runtime * const rt = Runtime::Instance();
    const uint32_t realArgsSize = argsInfo->argsSize;

    // Function always return RT_ERROR_NONE, modify for KernelLaunch performance optimization
    if (result.handle != nullptr) {
        SetAicoreArgs(submitTask, result.kerArgs, realArgsSize, result.smArgs, smArgsSize, result.handle);
        result.handle = nullptr;
    }

    TIMESTAMP_BEGIN(rtKernelLaunch_SubmitTask);
    const rtError_t error = device_->SubmitTask(submitTask, taskGenCallback_);
    TIMESTAMP_END(rtKernelLaunch_SubmitTask);

    ERROR_RETURN_MSG_INNER(error, "Failed to submit kernel task, retCode=%#x.", error);
    GET_THREAD_TASKID_AND_STREAMID(submitTask, stm->AllocTaskStreamId());
    TIMESTAMP_BEGIN(rtKernelLaunch_PutProgram);
    rt->PutProgram(programPtr);
    TIMESTAMP_END(rtKernelLaunch_PutProgram);

    return error;
}

rtError_t Context::LaunchKernel(const void * const stubFunc, const uint32_t coreDim, const rtArgsEx_t *argsInfo,
    rtL2Ctrl_t *l2ctrl, Stream *stm, const uint32_t flag, const TaskCfg * const taskcfg,
    const bool isLaunchVec)
{
    rtError_t error;
    uint32_t kernelType = 0U;
    ArgLoaderResult result = {};
    bool copyFlag = true;

    uint64_t addr1 = 0ULL;
    uint64_t addr2 = 0ULL;
    uint32_t smArgsSize = 0U;
    uint8_t mixType = NO_MIX;
    uint32_t prefetchCnt1 = 0U;
    uint32_t prefetchCnt2 = 0U;
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *kernTask = nullptr;
    AicTaskInfo *aicTask = nullptr;
    Program *prog = nullptr;
    Module *launchMdl = nullptr;
    bool mixOpt = false;
    Kernel *registeredKernel = nullptr;
    bool isNeedAllocSqeDevBuf = false;
    const bool noMixFlag = device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_KERNEL_LAUNCH_CANNOT_MIX);

    TIMESTAMP_BEGIN(rtKernelLaunch_AllocTask);
    kernTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_KERNEL_AICORE, errorReason, 1U, UpdateTaskFlag::SUPPORT);
    TIMESTAMP_END(rtKernelLaunch_AllocTask);
    COND_RETURN_ERROR_MSG_INNER(kernTask == nullptr, errorReason, "Failed to alloc task, stream_id=%d,"
        " retCode=%#x.", stm->Id_(), errorReason);

    error = LaunchKernelPrepare(smArgsSize, registeredKernel, prog, kernelType, launchMdl, stubFunc,
        l2ctrl, addr1, addr2, nullptr, 0, prefetchCnt1, prefetchCnt2);
    COND_PROC_RETURN_ERROR_MSG_INNER((error == RT_ERROR_MEMORY_ADDRESS_UNALIGNED) || (error == RT_ERROR_KERNEL_NULL),
        error, LaunchKernelRecycle(result, kernTask, nullptr);, "kernel launch kernel prepare failed.");
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "launch kernel prepare failed.");

    mixType = registeredKernel->GetMixType();
    if (noMixFlag) {
        mixType = static_cast<uint8_t>(NO_MIX); // both 51dc aic aiv not support mixtype
    }

    if (kernTask->isUpdateSinkSqe == 1U) {
        error = UpdateTaskPrepare(kernTask, registeredKernel, kernelType, stm);
        ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
            "Check kernel task failed, stream_id=%d, task_id=%hu, retCode=%#x.",
            stm->Id_(), kernTask->id, error);
    }

    if ((mixType != static_cast<uint8_t>(NO_MIX)) && (device_->ArgLoader_()->CheckPcieBar()) &&
        (argsInfo->argsSize <= (PCIE_BAR_COPY_SIZE - static_cast<uint32_t>(CONTEXT_ALIGN_LEN))) &&
        !stm->NonSupportModelCompile() && !(stm->IsTaskGrouping()) && (kernTask->isUpdateSinkSqe == 0U)) {
        TIMESTAMP_BEGIN(rtKernelLaunch_ArgLoadForMix);
        error = device_->ArgLoader_()->LoadForMix(kernelType, argsInfo, l2ctrl, stm, &result, mixOpt);
        TIMESTAMP_END(rtKernelLaunch_ArgLoadForMix);
        ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Mix Failed to load args and l2ctrl, stream_id=%d,"
                             " retCode=%#x.", stm->Id_(), error);
        copyFlag = false;
    } else if (((argsInfo->argsSize > RTS_LITE_PCIE_BAR_COPY_SIZE) ||
               (!stm->isHasPcieBar_) || IsCapturedTask(stm, kernTask)) ||
               (kernTask->isUpdateSinkSqe == 1U)) {
        TIMESTAMP_BEGIN(rtKernelLaunch_ArgLoad);
        error = device_->ArgLoader_()->Load(kernelType, argsInfo, l2ctrl, stm, &result);
        TIMESTAMP_END(rtKernelLaunch_ArgLoad);
        ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to load args and l2ctrl, stream_id=%d,"
        " retCode=%#x.", stm->Id_(), error);
        copyFlag = false;
    } else {
        // do nothing
    }
    if (noMixFlag) {
        TransDavinciTaskToVectorCore(stm->Flags(), addr2, addr1, mixType, kernelType, isLaunchVec);
    }
    error = CheckMixKernelValid(mixType, addr2);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
        "Mix kernel check failed, stream_id=%d, task_id=%hu, kernelType=%u, retCode=%#x.",
        stm->Id_(), kernTask->id, kernelType, error);

    COND_PROC(((kernTask->isUpdateSinkSqe == 1U) && (!(kernTask->stream->IsSoftwareSqEnable()))), isNeedAllocSqeDevBuf = true);
    AicTaskInit(kernTask, kernelType, static_cast<uint16_t>(coreDim), flag, taskcfg, isNeedAllocSqeDevBuf);

    aicTask = &kernTask->u.aicTaskInfo;
    if (copyFlag) {
        aicTask->argsInfo = const_cast<rtArgsEx_t*>(argsInfo);
    }
    aicTask->mixOpt = mixOpt;
    aicTask->funcAddr = addr1;
    aicTask->funcAddr1 = addr2;
    aicTask->kernel = registeredKernel;
    aicTask->progHandle = prog;
    if (noMixFlag &&
        (kernTask->type == TS_TASK_TYPE_KERNEL_AICORE) && (!infMode_)) {
        aicTask->infMode = TASK_UN_SATURATION_MODE;
    }
    registeredKernel->SetPrefetchCnt1_(prefetchCnt1);
    registeredKernel->SetPrefetchCnt2_(prefetchCnt2);
    // just offline support pctrace
    if (device_->Driver_()->GetRunMode() == RT_RUN_MODE_OFFLINE) {
        std::shared_ptr<PCTrace> rtPCTrace = nullptr;
        error = ConfigPCTraceTask(aicTask->kernel, rtPCTrace, coreDim, stm, kernTask->id, launchMdl);
        ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
            "Config pctrace task during kernel launching failed, retCode=%#x", error);
        SetPcTrace(kernTask, rtPCTrace);
    }

    RT_LOG(RT_LOG_INFO, "device_id=%lu, stream_id=%d, task_id=%hu, kernelType=%u, kernel_name=%s, "
        "arg_size=%u, taskRation=%u, funcType=%u, coreDim=%u, mixType=%hhu, addr1=0x%llx, addr2=0x%llx, "
        "stubFunc=%p, flag=%lu, kernelFlag=0x%x, qos=%u, partId=%u, schemMode=%u, infoAddr=%p, atomicIndex=%lu, "
        "isNoNeedH2DCopy=%u, isUpdateSinkSqe=%u.",
        device_->Id_(), stm->Id_(), kernTask->id, kernelType, registeredKernel->Name_().c_str(), argsInfo->argsSize,
        registeredKernel->GetTaskRation(), registeredKernel->GetFuncType(), coreDim, mixType, addr1, addr2,
        stubFunc, flag, aicTask->comm.kernelFlag, aicTask->qos, aicTask->partId, aicTask->schemMode,
        aicTask->inputArgsSize.infoAddr, aicTask->inputArgsSize.atomicIndex,
        argsInfo->isNoNeedH2DCopy, kernTask->isUpdateSinkSqe);

    error = LaunchKernelSubmit(kernTask, stm, argsInfo, result, smArgsSize, prog);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "kernel launch submit failed.");
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    LaunchKernelRecycle(result, kernTask, prog);
    return error;
}

rtError_t Context::LaunchKernelWithHandle(void * const progHandle, const uint64_t tilingKey,
    const uint32_t coreDim, const rtArgsEx_t *argsInfo, rtL2Ctrl_t *l2ctrl, Stream *stm, const uint32_t flag,
    const rtTaskCfgInfo_t * const cfgInfo, const bool isLaunchVec)
{
    rtError_t error;
    uint32_t kernelType = 0U;
    ArgLoaderResult result = {};
    bool copyFlag = true;
    uint8_t mixType = NO_MIX;
    NULL_PTR_RETURN_MSG_OUTER(progHandle, RT_ERROR_PROGRAM_NULL);

    uint64_t addr1 = 0ULL;
    uint64_t addr2 = 0ULL;
    uint32_t smArgsSize = 0U;
    TaskInfo submitTask = {};
    TaskInfo *kernTask = nullptr;
    AicTaskInfo *aicTask = nullptr;
    Program *prog = nullptr;
    Module *launchMdl = nullptr;
    uint32_t prefetchCnt1 = 0U;
    uint32_t prefetchCnt2 = 0U;
    Kernel *registeredKernel = nullptr;
    bool mixOpt = false;
    rtError_t errorReason;
    uint32_t taskRation = 0U;
    uint32_t funcType = 0U;
    TaskCfg taskCfg = {};
    bool isNeedAllocSqeDevBuf = false;
    const bool noMixFlag = device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_KERNEL_LAUNCH_CANNOT_MIX);

    TIMESTAMP_BEGIN(rtKernelLaunch_AllocTask);
    kernTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_KERNEL_AICORE, errorReason, 1U, UpdateTaskFlag::SUPPORT);
    TIMESTAMP_END(rtKernelLaunch_AllocTask);
    COND_RETURN_ERROR_MSG_INNER(kernTask == nullptr, errorReason, "Failed to alloc task, stream_id=%d."
        " retCode=%#x.", stm->Id_(), errorReason);

    error = LaunchKernelPrepare(smArgsSize, registeredKernel, prog, kernelType, launchMdl, nullptr,
        l2ctrl, addr1, addr2, progHandle, tilingKey, prefetchCnt1, prefetchCnt2);
    COND_PROC_RETURN_ERROR_MSG_INNER((error == RT_ERROR_MEMORY_ADDRESS_UNALIGNED) || (error == RT_ERROR_KERNEL_NULL),
        error, LaunchKernelRecycle(result, kernTask, nullptr);, "kernel launch kernel prepare failed.");
    COND_PROC_RETURN_ERROR_MSG_INNER((error == RT_ERROR_PROGRAM_BASE) || (error == RT_ERROR_PROGRAM_NULL), error,
        LaunchKernelRecycle(result, kernTask, nullptr);, "kernel launch prog prepare failed.");
    ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "kernel launch prepare failed.");

    mixType = (tilingKey == DEFAULT_TILING_KEY) ? static_cast<uint8_t>(NO_MIX) : registeredKernel->GetMixType();
    if (noMixFlag) {
        mixType = static_cast<uint8_t>(NO_MIX); // both 51dc aic aiv not support mixtype
    }

    if (kernTask->isUpdateSinkSqe == 1U) {
        error = UpdateTaskPrepare(kernTask, registeredKernel, kernelType, stm);
        ERROR_GOTO_MSG_INNER(error, ERROR_FREE,
            "Check kernel task failed, stream_id=%d, task_id=%hu, retCode=%#x.",
            stm->Id_(), kernTask->id, error);
    }

    if ((mixType != NO_MIX) && (device_->ArgLoader_()->CheckPcieBar()) &&
       (argsInfo->argsSize <= (PCIE_BAR_COPY_SIZE - CONTEXT_ALIGN_LEN)) && !stm->NonSupportModelCompile() &&
       !(stm->IsTaskGrouping()) && (kernTask->isUpdateSinkSqe == 0U)) {
        TIMESTAMP_BEGIN(rtKernelLaunch_ArgLoadAllForMix);
        error = device_->ArgLoader_()->LoadForMix(kernelType, argsInfo, l2ctrl, stm, &result, mixOpt);
        TIMESTAMP_END(rtKernelLaunch_ArgLoadAllForMix);
        ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Mix Failed to load args and l2ctrl, stream_id=%d,"
                             " retCode=%#x.", stm->Id_(), error);
        copyFlag = false;
    } else if (((argsInfo->argsSize > RTS_LITE_PCIE_BAR_COPY_SIZE) ||
               (!stm->isHasPcieBar_) || IsCapturedTask(stm, kernTask)) ||
               (kernTask->isUpdateSinkSqe == 1U)) {
        // 只要不预留pcie,都走公共load流程
        TIMESTAMP_BEGIN(rtKernelLaunch_ArgLoadAll);
        error = device_->ArgLoader_()->Load(kernelType, argsInfo, l2ctrl, stm, &result);
        TIMESTAMP_END(rtKernelLaunch_ArgLoadAll);
        ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Failed to load args and l2ctrl, stream_id=%d,"
        " retCode=%#x.", stm->Id_(), error);
        copyFlag = false;
    } else {
        // do nothing
    }
    if (noMixFlag) {
        TransDavinciTaskToVectorCore(stm->Flags(), addr2, addr1, mixType, kernelType, isLaunchVec);
    }

    error = CheckMixKernelValid(mixType, addr2);
    ERROR_GOTO_MSG_INNER(error, ERROR_FREE,
        "Mix kernel check failed, stream_id=%d, task_id=%hu, kernelType=%u, retCode=%#x.",
        stm->Id_(), kernTask->id, kernelType, error);

    if (cfgInfo != nullptr) {
        taskCfg.isBaseValid = 1U;
        taskCfg.base = *cfgInfo;
    }
    COND_PROC(((kernTask->isUpdateSinkSqe == 1U) && (!(kernTask->stream->IsSoftwareSqEnable()))), isNeedAllocSqeDevBuf = true);

    AicTaskInit(kernTask, kernelType, static_cast<uint16_t>(coreDim), flag, &taskCfg, isNeedAllocSqeDevBuf);

    aicTask = &kernTask->u.aicTaskInfo;
    if (copyFlag) {
        aicTask->argsInfo = const_cast<rtArgsEx_t*>(argsInfo);
    }

    aicTask->mixOpt = mixOpt;
    aicTask->funcAddr = addr1;
    aicTask->funcAddr1 = addr2;
    aicTask->tilingKey = tilingKey;
    aicTask->kernel = registeredKernel;
    aicTask->progHandle = (prog != nullptr) ? prog : RtPtrToPtr<Program *>(progHandle);
    if (noMixFlag &&
        (kernTask->type == TS_TASK_TYPE_KERNEL_AICORE) && (!infMode_)) {
        aicTask->infMode = TASK_UN_SATURATION_MODE;
    }

    if (registeredKernel != nullptr) {
        taskRation = registeredKernel->GetTaskRation();
        funcType = registeredKernel->GetFuncType();
        registeredKernel->SetPrefetchCnt1_(prefetchCnt1);
        registeredKernel->SetPrefetchCnt2_(prefetchCnt2);
    }

    RT_LOG(RT_LOG_INFO, "kernel info : device_id=%lu, stream_id=%d, task_id=%hu, kernelType=%u, kernel_name=%s, "
           "arg_size=%u, coreDim=%u, mixType=%u, taskRation=%u, funcType=%u, addr1=0x%llx, addr2=0x%llx, "
           "flag=%lu, kernelFlag=0x%x, qos=%u, partId=%u, schemMode=%u, infoAddr=%p, atomicIndex=%u, "
           "isNoNeedH2DCopy=%u, isUpdateSinkSqe=%u.",
           device_->Id_(), stm->Id_(), kernTask->id, kernelType,
           (tilingKey == DEFAULT_TILING_KEY) ? "" : registeredKernel->Name_().c_str(),
           argsInfo->argsSize, coreDim, mixType, taskRation, funcType, addr1, addr2,
           flag, aicTask->comm.kernelFlag, aicTask->qos, aicTask->partId, aicTask->schemMode,
           aicTask->inputArgsSize.infoAddr, aicTask->inputArgsSize.atomicIndex,
           argsInfo->isNoNeedH2DCopy, kernTask->isUpdateSinkSqe);

    TIMESTAMP_BEGIN(rtKernelLaunchWithHandle_SubMit);
    error = LaunchKernelSubmit(kernTask, stm, argsInfo, result, smArgsSize, prog);
    TIMESTAMP_END(rtKernelLaunchWithHandle_SubMit);

    ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "kernel launch submit failed.");
    return RT_ERROR_NONE;

ERROR_FREE:
    LaunchKernelRecycle(result, kernTask, prog);
    return error;
}

rtError_t Context::LaunchKernelGetPrefetchCnt(const Kernel * const kernelPtr, const Program * const prog,
    uint32_t &icachePrefetchCnt1, uint32_t &icachePrefetchCnt2, uint8_t &mixType) const
{
    // 0KB, aicpu task not need prefetch
    constexpr uint32_t aicpuIcachePrefetchSizeMax = 0U;
    // 32KB, K=1024. aicore can prefetch 32KB at most.
    constexpr uint32_t aicoreIcachePrefetchSizeMax = 32768U;
    // 16KB, K=1024. aivector can prefetch 16KB at most.
    constexpr uint32_t aivectorIcachePrefetchSizeMax = 16384U;
    constexpr uint32_t prefetchUnits = 2048U;
    icachePrefetchCnt2 = 0U;

    uint32_t machine = prog->Machine();
    uint32_t restSize1 = 0U;
    uint32_t restSize2 = 0U;
    uint32_t prefetchMaxSize1 = 0U;
    uint32_t prefetchMaxSize2 = 0U;

    if (machine == Program::MACH_AI_MIX_KERNEL) {
        machine = kernelPtr->KernelType_();
    }
    kernelPtr->GetKernelLength(restSize1, restSize2);

    mixType = kernelPtr->GetMixType();
    if (mixType == static_cast<uint8_t>(MIX_AIC)) {
        prefetchMaxSize1 = aicoreIcachePrefetchSizeMax;
    } else if (mixType == static_cast<uint8_t>(MIX_AIV)) {
        prefetchMaxSize1 = aivectorIcachePrefetchSizeMax;
    } else if (mixType == static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIC) ||
               mixType == static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIV)) {
        prefetchMaxSize1 = aicoreIcachePrefetchSizeMax;
        prefetchMaxSize2 = aivectorIcachePrefetchSizeMax;
    } else {
        switch (machine) {
            case Program::MACH_AI_CPU:
                prefetchMaxSize1 = aicpuIcachePrefetchSizeMax;
                break;
            case Program::MACH_AI_CORE:
                prefetchMaxSize1 = aicoreIcachePrefetchSizeMax;
                break;
            case Program::MACH_AI_CVMIX:
                prefetchMaxSize1 = aicoreIcachePrefetchSizeMax;
                break;
            case Program::MACH_AI_VECTOR:
                prefetchMaxSize1 = aivectorIcachePrefetchSizeMax;
                break;
            default:
                RT_LOG(RT_LOG_ERROR, "get prefetch cnt failed, machine=%u.", machine);
                return RT_ERROR_INVALID_VALUE;
        }
    }
    // Icache_prefetch_cnt:aic aiv prefetch instruction length, the unit is 2KB, K=1024
    const uint32_t restSizeCnt1 = restSize1 / prefetchUnits;
    const uint32_t prefetchMaxSizeCnt1 = prefetchMaxSize1 / prefetchUnits;
    icachePrefetchCnt1 = (restSizeCnt1 > prefetchMaxSizeCnt1) ? prefetchMaxSizeCnt1 : restSizeCnt1;
    if (mixType == static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIC)) {
        const uint32_t restSizeCnt2 = restSize2 / prefetchUnits;
        const uint32_t prefetchMaxSizeCnt2 = prefetchMaxSize2 / prefetchUnits;
        icachePrefetchCnt2 = (restSizeCnt2 > prefetchMaxSizeCnt2) ? prefetchMaxSizeCnt2 : restSizeCnt2;
    }

    RT_LOG(RT_LOG_DEBUG, "get prefetch cnt success, prefetchCnt1=%u, prefetchCnt2=%u, mixType=%hu.",
           icachePrefetchCnt1, icachePrefetchCnt2, mixType);

    return RT_ERROR_NONE;
}

rtError_t Context::LaunchKernel(Kernel * const kernel, const uint32_t coreDim, const rtArgsEx_t *argsInfo,
    Stream *stm, const TaskCfg * const taskcfg, const bool isLaunchVec)
{
    TaskInfo submitTask = {};
    uint64_t kernelPc1 = 0ULL;
    uint64_t kernelPc2 = 0ULL;
    uint8_t mixType = NO_MIX;
    uint32_t prefetchCnt1 = 0U;
    uint32_t prefetchCnt2 = 0U;
    TaskInfo *kernTask = nullptr;
    rtError_t error = RT_ERROR_NONE;
    ArgLoaderResult result = {};
    Program *refProg = nullptr;
    Program * const prog = kernel->Program_();
    NULL_PTR_RETURN_MSG(prog, RT_ERROR_PROGRAM_NULL);

    error = kernel->GetFunctionDevAddr(kernelPc1, kernelPc2);
    ERROR_RETURN_MSG_INNER(error, "Launch kernel failed, get function address failed.");
    uint32_t kernelType = kernel->KernelType_();
    AicTaskInfo *aicTask = nullptr;
    bool copyFlag = true;
    bool mixOpt = false;
    rtError_t errorReason;
    bool isNeedAllocSqeDevBuf = false;

    TIMESTAMP_BEGIN(rtKernelLaunch_AllocTask);
    kernTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_KERNEL_AICORE, errorReason, 1U, UpdateTaskFlag::SUPPORT);
    TIMESTAMP_END(rtKernelLaunch_AllocTask);
    COND_RETURN_ERROR_MSG_INNER(kernTask == nullptr, errorReason, "Failed to alloc task, stream_id=%d."
        " retCode=%#x.", stm->Id_(), errorReason);

    error = LaunchKernelGetPrefetchCnt(kernel, prog, prefetchCnt1, prefetchCnt2, mixType);
    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_KERNEL_LAUNCH_CANNOT_MIX)) {
                mixType = static_cast<uint8_t>(NO_MIX);
    }

    if (kernTask->isUpdateSinkSqe == 1U) {
        error = UpdateTaskPrepare(kernTask, kernel, kernelType, stm);
        ERROR_GOTO_MSG_INNER(error, ERROR_FREE,
            "Check kernel task failed, stream_id=%d, task_id=%hu, retCode=%#x.",
            stm->Id_(), kernTask->id, error);
    }

    if ((mixType != NO_MIX) && (device_->ArgLoader_()->CheckPcieBar()) &&
        (argsInfo->argsSize <= (PCIE_BAR_COPY_SIZE - CONTEXT_ALIGN_LEN)) && !stm->NonSupportModelCompile() &&
        !(stm->IsTaskGrouping()) && (kernTask->isUpdateSinkSqe == 0U)) {
        TIMESTAMP_BEGIN(rtKernelLaunch_ArgLoadAllForMix);
        error = device_->ArgLoader_()->LoadForMix(kernelType, argsInfo, nullptr, stm, &result, mixOpt);
        TIMESTAMP_END(rtKernelLaunch_ArgLoadAllForMix);
        ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Mix Failed to load args and l2ctrl, stream_id=%d,"
                              " retCode=%#x.", stm->Id_(), error);
        copyFlag = false;
    } else if (((argsInfo->argsSize > RTS_LITE_PCIE_BAR_COPY_SIZE) ||
               (!stm->isHasPcieBar_) || IsCapturedTask(stm, kernTask)) ||
               (kernTask->isUpdateSinkSqe == 1U)) {
        TIMESTAMP_BEGIN(rtLaunchKernel_ArgLoadAll);
        error = device_->ArgLoader_()->Load(kernelType, argsInfo, nullptr, stm, &result);
        TIMESTAMP_END(rtLaunchKernel_ArgLoadAll);
        ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Failed to load args, stream_id=%d, retCode=%#x.",
                             stm->Id_(), error);
        copyFlag = false;
    } else {
        // do nothing
    }
    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_KERNEL_LAUNCH_CANNOT_MIX)) {
        TransDavinciTaskToVectorCore(stm->Flags(), kernelPc2, kernelPc1, mixType, kernelType, isLaunchVec);
    }
    error = CheckMixKernelValid(mixType, kernelPc2);
    ERROR_GOTO_MSG_INNER(error, ERROR_FREE,
        "Mix kernel check failed, stream_id=%d, task_id=%hu, kernelType=%u, retCode=%#x.",
        stm->Id_(), kernTask->id, kernelType, error);

    COND_PROC(((kernTask->isUpdateSinkSqe == 1U) && (!(kernTask->stream->IsSoftwareSqEnable()))), isNeedAllocSqeDevBuf = true);

    AicTaskInit(kernTask, kernelType, static_cast<uint16_t>(coreDim), 0, taskcfg, isNeedAllocSqeDevBuf);
    ERROR_GOTO_MSG_INNER(error, ERROR_FREE,
        "Init kernel task failed, stream_id=%d, task_id=%hu, kernelType=%u, retCode=%#x.",
        stm->Id_(), kernTask->id, kernelType, error);

    aicTask = &kernTask->u.aicTaskInfo;
    if (copyFlag) {
        aicTask->argsInfo = const_cast<rtArgsEx_t*>(argsInfo);
    }

    aicTask->mixOpt = mixOpt;
    aicTask->funcAddr = kernelPc1;
    aicTask->kernel = const_cast<Kernel *>(kernel);
    aicTask->progHandle = prog;
    aicTask->funcAddr1 = kernelPc2;
    kernel->SetPrefetchCnt1_(prefetchCnt1);
    kernel->SetPrefetchCnt2_(prefetchCnt2);

    RT_LOG(RT_LOG_INFO, "kernel info : device_id=%u, stream_id=%d, task_id=%hu, kernelType=%u, kernel_name=%s, arg_size=%u, "
        "coreDim=%u, taskRation=%u, funcType=%u, addr1=0x%llx, addr2=0x%llx, "
        "mixType=%u, kernelFlag=0x%x, qos=%u, partId=%u, schemMode=%u, infoAddr=%p, atomicIndex=%lu, "
        "prefetchCnt1=%u, prefetchCnt2=%u, isNoNeedH2DCopy=%u.",
        device_->Id_(), stm->Id_(), kernTask->id, kernelType, kernel->Name_().c_str(),
        argsInfo->argsSize, coreDim, kernel->GetTaskRation(), kernel->GetFuncType(), kernelPc1, kernelPc2,
        mixType, aicTask->comm.kernelFlag, aicTask->qos, aicTask->partId, aicTask->schemMode,
        aicTask->inputArgsSize.infoAddr, aicTask->inputArgsSize.atomicIndex,
        prefetchCnt1, prefetchCnt2, argsInfo->isNoNeedH2DCopy);

    TIMESTAMP_BEGIN(rtLaunchKernel_SubMit);
    error = LaunchKernelSubmit(kernTask, stm, argsInfo, result, 0, nullptr);
    TIMESTAMP_END(rtLaunchKernel_SubMit);

    ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "kernel launch submit failed.");
    return RT_ERROR_NONE;

ERROR_FREE:
    LaunchKernelRecycle(result, kernTask, refProg);
    return error;
}

void Context::LaunchKernelRecycle(ArgLoaderResult &result, TaskInfo *&recycleTask, const Program * const prog) const
{
    rtError_t error = RT_ERROR_NONE;
    Runtime * const rt = Runtime::Instance();

    if (result.handle != nullptr) {
        error = device_->ArgLoader_()->Release(result.handle);
        COND_LOG(error != RT_ERROR_NONE, "argloader release failed, retCode=%#x.", error);
        result.handle = nullptr;
    }

    if (recycleTask != nullptr) {
        if (recycleTask->isUpdateSinkSqe == 0U) {
            (void)device_->GetTaskFactory()->Recycle(recycleTask);
            recycleTask = nullptr;
        } else {
            recycleTask->isUpdateSinkSqe = 0U;
        }
    }

    rt->PutProgram(prog);
}

rtError_t Context::LaunchKernelEx(const void * const args, const uint32_t argsSize, const uint32_t flags,
    Stream * const stm)
{
    rtError_t error;
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *kernTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_KERNEL_AICORE, errorReason);
    NULL_PTR_RETURN_MSG(kernTask, errorReason);

    AicpuTaskInit(kernTask, 1U, flags);
    RT_LOG(RT_LOG_INFO, "kernelFlag=0x%x, blkdim=%u.",
        kernTask->u.aicpuTaskInfo.comm.kernelFlag, kernTask->u.aicpuTaskInfo.comm.dim);

    SetAicpuArgs(kernTask, args, argsSize, nullptr);
    kernTask->u.aicpuTaskInfo.aicpuKernelType = static_cast<uint8_t>(TS_AICPU_KERNEL_FMK);
    kernTask->u.aicpuTaskInfo.aicpuFlags = flags;

    error = device_->SubmitTask(kernTask, taskGenCallback_);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit DavinciKernelTask, retCode=%#x.", error);

    GET_THREAD_TASKID_AND_STREAMID(kernTask, stm->AllocTaskStreamId());

    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(kernTask);
    return error;
}

rtError_t Context::LaunchCpuKernel(const rtKernelLaunchNames_t * const launchNames, const uint32_t coreDim,
    const rtArgsEx_t * const argsInfo, Stream * const stm, const uint32_t flag)
{
    rtError_t error = RT_ERROR_NONE;
    ArgLoader * const devArgLdr = device_->ArgLoader_();
    ArgLoaderResult result{};
    const char_t * const launchSoName = launchNames->soName;
    const char_t * const kernelName = launchNames->kernelName;
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *kernTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_KERNEL_AICORE, errorReason);
    NULL_PTR_RETURN_MSG(kernTask, errorReason);
    tsAicpuKernelType aicpuKernelType;
    AicpuTaskInfo *aicpuTaskInfo = nullptr;

    // Init task
    AicpuTaskInit(kernTask, static_cast<uint16_t>(coreDim), flag);

    // Set args for task
    error = devArgLdr->LoadCpuKernelArgs(argsInfo, stm, &result);
    ERROR_GOTO(error, ERROR_FREE, "Failed to load cpu Kernel args , retCode=%#x", error);
    SetAicpuArgs(kernTask, result.kerArgs, argsInfo->argsSize, result.handle);
    // handle is owned by task.
    result.handle = nullptr;

    // Set soName and kernelName for task, host aicpu task use GE svm addr directly
    if (((flag & 0x30U) >> 0x4U) == KERNEL_HOST_AICPU_FLAG) { // host aicpu
        SetNameArgs(kernTask, static_cast<const void *>(launchSoName), static_cast<const void *>(kernelName));
    } else {
        void *soNameAddr = nullptr;
        void *kernelNameAddr = nullptr;
        if (launchSoName != nullptr) {
            error = devArgLdr->GetKernelInfoDevAddr(static_cast<const char_t *>(launchSoName), KernelInfoType::SO_NAME, &soNameAddr);
            ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Failed to get so address by name, retCode=%#x", error);
        }
        if (kernelName != nullptr) {
            error = devArgLdr->GetKernelInfoDevAddr(static_cast<const char_t *>(kernelName), KernelInfoType::KERNEL_NAME, &kernelNameAddr);
            ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Failed to get kernel address by name, retCode=%#x", error);
        }
        SetNameArgs(kernTask, soNameAddr, kernelNameAddr);
    }

    aicpuTaskInfo = &(kernTask->u.aicpuTaskInfo);
    RT_LOG(RT_LOG_INFO, "device_id=%lu, stream_id=%d, task_id=%hu, flag=%u, kernelFlag=0x%x, blkdim=%u, soName=%s, kernel_name=%s.",
        device_->Id_(), stm->Id_(), kernTask->id, flag, aicpuTaskInfo->comm.kernelFlag, aicpuTaskInfo->comm.dim,
        launchSoName != nullptr ? launchSoName : "null", kernelName != nullptr ? kernelName : "null");

    // Set kernel type and flags
    aicpuKernelType = ((flag & RT_KERNEL_CUSTOM_AICPU) != 0U) ? TS_AICPU_KERNEL_CUSTOM_AICPU : TS_AICPU_KERNEL_AICPU;
    aicpuTaskInfo->aicpuKernelType = static_cast<uint8_t>(aicpuKernelType);

    // Submit task
    error = device_->SubmitTask(kernTask, taskGenCallback_);

    ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Failed to submit kernel task, retCode=%#x", error);

    GET_THREAD_TASKID_AND_STREAMID(kernTask, stm->AllocTaskStreamId());

    return RT_ERROR_NONE;

ERROR_FREE:
    (void)device_->GetTaskFactory()->Recycle(kernTask);
    return error;
}

rtError_t Context::LaunchCpuKernelExWithArgs(const Kernel * const kernel, const uint32_t coreDim,
    const rtCpuKernelArgs_t * const cpuKernelArgs, const TaskCfg &taskCfg,
    Stream * const stm, const uint32_t flag) const
{
    rtError_t error = RT_ERROR_NONE;
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *kernelTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_KERNEL_AICORE, errorReason);
    NULL_PTR_RETURN_MSG(kernelTask, errorReason);

    ArgLoader * const devArgLdr = device_->ArgLoader_();
    const rtAicpuArgsEx_t *argsInfo = &cpuKernelArgs->baseArgs;
    const size_t cpuParamHeadOffset = cpuKernelArgs->cpuParamHeadOffset;
    const uint32_t kernelType = kernel->KernelType_();

    // Init task
    AicpuTaskInit(kernelTask, static_cast<uint16_t>(coreDim), flag);
    kernelTask->u.aicpuTaskInfo.headParamOffset = static_cast<uint32_t>(cpuParamHeadOffset);
    Kernel *newKernel =
        new (std::nothrow) Kernel(kernel->GetCpuKernelSo(), kernel->GetCpuFuncName(), kernel->GetCpuOpType());
    NULL_PTR_GOTO_MSG_INNER(newKernel, ERROR_FREE, error, RT_ERROR_KERNEL_NEW);

    /* 默认使用kernel注册时的devAddr */
    SetNameArgs(kernelTask, kernel->GetSoNameDevAddr(device_->Id_()), kernel->GetFuncNameDevAddr(device_->Id_()));

    if ((argsInfo->argsSize > RTS_LITE_PCIE_BAR_COPY_SIZE) ||
        (!stm->isHasPcieBar_) || IsCapturedTask(stm, kernelTask)) {
        ArgLoaderResult result = {};
        TIMESTAMP_BEGIN(rtKernelLaunch_CpuArgLoad);
        error = devArgLdr->LoadCpuKernelArgsEx(argsInfo, stm, &result);
        TIMESTAMP_END(rtKernelLaunch_CpuArgLoad);
        // Set args for task
        ERROR_GOTO(error, ERROR_FREE, "Failed to load cpu Kernel args, retCode=%#x", error);
        SetAicpuArgs(kernelTask, result.kerArgs, argsInfo->argsSize, result.handle);

        /* 如果aicpuArgsInfo->args中存在soName和kernnelName，则使用args中的devAddr；
         * 否则，使用kernel注册时的devAddr（见StoreKernelLiteralNameToDevice调用的地方）
         * 注：部分场景的cpuLaunch没有kernel注册过程 */
        if ((argsInfo->soNameAddrOffset != 0) || (argsInfo->kernelNameAddrOffset != 0)) {
             SetNameArgs(kernelTask, (RtPtrToPtr<char_t *, void *>(result.kerArgs) + argsInfo->soNameAddrOffset),
                         (RtPtrToPtr<char_t *, void *>(result.kerArgs) + argsInfo->kernelNameAddrOffset));
        }

        RT_LOG(RT_LOG_INFO, "Force cpy args device_id=%u, stream_id=%d, task_id=%u.",
            device_->Id_(), stm->Id_(), kernelTask->id);
    } else {
        kernelTask->u.aicpuTaskInfo.aicpuArgsInfo = const_cast<rtAicpuArgsEx_t*>(argsInfo);
    }

    kernelTask->u.aicpuTaskInfo.kernel = newKernel;
    kernelTask->u.aicpuTaskInfo.aicpuFlags = flag;
    kernelTask->u.aicpuTaskInfo.aicpuKernelType = static_cast<uint8_t>(kernelType);
    kernelTask->u.aicpuTaskInfo.timeout = ConvertAicpuTimeout(argsInfo, &taskCfg, flag);
    RT_LOG(RT_LOG_INFO, "device_id=%u, stream_id=%d, task_id=%u, model_num=%u, NonSupportModelCompile=%u, "
        "isNoNeedH2DCopy=%u, cpuParamHeadOffset=%zu, kernel_type=%u, flag=0x%x, timeout=%" PRIu64 "us, blkdim=%u.",
        device_->Id_(), stm->Id_(), kernelTask->id, stm->GetModelNum(), stm->NonSupportModelCompile(),
        argsInfo->isNoNeedH2DCopy, cpuParamHeadOffset, kernelType, flag, kernelTask->u.aicpuTaskInfo.timeout,
        kernelTask->u.aicpuTaskInfo.comm.dim);
    error = device_->SubmitTask(kernelTask, taskGenCallback_);

    ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Failed to submit kernel task, retCode=%#x", error);
    GET_THREAD_TASKID_AND_STREAMID(kernelTask, stm->AllocTaskStreamId());

    return RT_ERROR_NONE;
ERROR_FREE:
    (void)device_->GetTaskFactory()->Recycle(kernelTask);
    return error;
}

rtError_t Context::LaunchCpuKernelExWithArgs(const uint32_t coreDim, const rtAicpuArgsEx_t * const argsInfo,
    Stream * const stm, const uint32_t flag, const uint32_t kernelType)
{
    rtError_t error = RT_ERROR_NONE;
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *kernelTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_KERNEL_AICORE, errorReason);
    NULL_PTR_RETURN_MSG(kernelTask, errorReason);

    const int32_t streamId = stm->Id_();
    ArgLoader * const devArgLdr = device_->ArgLoader_();

    // Init task
    AicpuTaskInit(kernelTask, static_cast<uint16_t>(coreDim), flag);
    if ((argsInfo->argsSize > RTS_LITE_PCIE_BAR_COPY_SIZE) ||
        (!stm->isHasPcieBar_) || IsCapturedTask(stm, kernelTask)) {
        ArgLoaderResult result{};
        TIMESTAMP_BEGIN(rtKernelLaunch_CpuArgLoad);
        error = devArgLdr->LoadCpuKernelArgsEx(argsInfo, stm, &result);
        TIMESTAMP_END(rtKernelLaunch_CpuArgLoad);
        // Set args for task
        ERROR_GOTO(error, ERROR_FREE, "Failed to load cpu Kernel args , retCode=%#x", error);
        SetAicpuArgs(kernelTask, result.kerArgs, argsInfo->argsSize, result.handle);
        // Set soName and kernelName for task
        const void *kernelSoName = argsInfo->soNameAddrOffset == MAX_UINT32_NUM ? nullptr :
            RtPtrToPtr<const void *>(RtPtrToPtr<char_t *>(result.kerArgs) + argsInfo->soNameAddrOffset);
        SetNameArgs(kernelTask, kernelSoName, (RtPtrToPtr<char_t *>(result.kerArgs) + argsInfo->kernelNameAddrOffset));
    } else {
        kernelTask->u.aicpuTaskInfo.aicpuArgsInfo = const_cast<rtAicpuArgsEx_t*>(argsInfo);
    }

    kernelTask->u.aicpuTaskInfo.aicpuFlags = flag;
    kernelTask->u.aicpuTaskInfo.aicpuKernelType = static_cast<uint8_t>(kernelType);
    kernelTask->u.aicpuTaskInfo.timeout = ConvertAicpuTimeout(argsInfo, nullptr, flag);
    RT_LOG(RT_LOG_INFO, "Force flag device_id=%u, stream_id=%d, task_id=%u, model_num=%u, NonSupportModelCompile=%u "
        "isNoNeedH2DCopy=%u, kernl_type=%u, flag=0x%x, timeout=%" PRIu64 "us, kernelFlag=0x%x, blkdim=%u",
        device_->Id_(), streamId, kernelTask->id, stm->GetModelNum(), stm->NonSupportModelCompile(),
        argsInfo->isNoNeedH2DCopy, kernelType, flag, kernelTask->u.aicpuTaskInfo.timeout,
        kernelTask->u.aicpuTaskInfo.comm.kernelFlag, kernelTask->u.aicpuTaskInfo.comm.dim);

    error = device_->SubmitTask(kernelTask, taskGenCallback_);

    ERROR_GOTO_MSG_INNER(error, ERROR_FREE, "Failed to submit kernel task, retCode=%#x", error);
    GET_THREAD_TASKID_AND_STREAMID(kernelTask, stm->AllocTaskStreamId());

    return RT_ERROR_NONE;
ERROR_FREE:
    (void)device_->GetTaskFactory()->Recycle(kernelTask);
    return error;
}

rtError_t Context::LaunchMultipleTaskInfo(const rtMultipleTaskInfo_t * const multipleTaskInfo, Stream * const stm,
    const uint32_t flag)
{
    uint32_t taskId = 0;
    rtError_t error = RT_ERROR_NONE;
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *multipleTask = nullptr;
    const int32_t streamId = stm->Id_();

    multipleTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_MULTIPLE_TASK,
                                  errorReason, multipleTaskInfo->taskNum);
    NULL_PTR_RETURN_MSG(multipleTask, errorReason);

    error = DavinciMultipleTaskInit(multipleTask, multipleTaskInfo, flag);
    ERROR_PROC_RETURN_MSG_INNER(error, (void)device_->GetTaskFactory()->Recycle(multipleTask);,
        "DavinciMultipleTaskInit fail, stream_id=%d, retCode=%x", streamId, error);

    error = device_->SubmitTask(multipleTask, taskGenCallback_, &taskId);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Failed to submit kernel task, stream_id=%d, retCode=%x", streamId, error);

        // When an error occurs, the dvpp releases the cmdlist memory.
        ResetCmdList(multipleTask);
        (void)device_->GetTaskFactory()->Recycle(multipleTask);
        return error;
    }
    SET_THREAD_TASKID_AND_STREAMID(streamId, taskId);

    // dvpp rr, send 3 write value task
    for (size_t idx = 0U; idx < multipleTaskInfo->taskNum; idx++) {
        if ((multipleTaskInfo->taskDesc[idx].type == RT_MULTIPLE_TASK_TYPE_DVPP) &&
            (multipleTaskInfo->taskDesc[idx].u.dvppTaskDesc.sqe.sqeHeader.reserved == 1U)) {
            error = StarsLaunchDvppRRProcess(stm);
            if (error != RT_ERROR_NONE) {
                RT_LOG(RT_LOG_ERROR, "submit dvpp task failed, stream_id=%d, sqeType=%hu", streamId,
                    multipleTaskInfo->taskDesc[idx].u.dvppTaskDesc.sqe.sqeHeader.type);
                (void)device_->GetTaskFactory()->Recycle(multipleTask);
            }
            break;
        }
    }
    return RT_ERROR_NONE;
}

rtError_t Context::DatadumpInfoLoad(const void * const dumpInfo, const uint32_t length, const uint32_t flag)
{
    rtError_t error;
    Stream * const dftStm = DefaultStream_();
    NULL_PTR_RETURN_MSG(dftStm, RT_ERROR_STREAM_NULL);
    const int32_t streamId = dftStm->Id_();
    const tsAicpuKernelType kernelType =
        ((flag & RT_KERNEL_CUSTOM_AICPU) != 0U) ? TS_AICPU_KERNEL_CUSTOM_AICPU : TS_AICPU_KERNEL_AICPU;

    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        RtDataDumpLoadInfoParam param = {dumpInfo, length, static_cast<uint16_t>(kernelType)};
        return device_->GetCtrlSQ().SendDataDumpLoadInfoMsg(RtCtrlMsgType::RT_CTRL_MSG_DATADUMP_INFOLOAD, param, taskGenCallback_);
    }

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *rtDumpLoadInfoTask = dftStm->AllocTask(&submitTask, TS_TASK_TYPE_DATADUMP_LOADINFO, errorReason);
    NULL_PTR_RETURN_MSG(rtDumpLoadInfoTask, errorReason);

    error = DataDumpLoadInfoTaskInit(rtDumpLoadInfoTask, dumpInfo, length, static_cast<uint16_t>(kernelType));
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
        "Failed to init DataDumpLoadInfoTask, stream_id=%d, task_id=%" PRIu16 ", retCode=%#x.",
        streamId, rtDumpLoadInfoTask->id, error);

    error = device_->SubmitTask(rtDumpLoadInfoTask, taskGenCallback_);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit DataDumpLoadInfoTask, retCode=%#x", error);

    error = dftStm->Synchronize();
    ERROR_RETURN_MSG_INNER(error, "Failed to synchronize DataDumpLoadInfoTask, retCode=%#x", error);

    return error;

ERROR_RECYCLE:
        dftStm->SetErrCode(0U);
        (void)device_->GetTaskFactory()->Recycle(rtDumpLoadInfoTask);
        return error;
}

rtError_t Context::AicpuInfoLoad(const void * const aicpuInfo, const uint32_t length)
{
    Stream * const dftStm = DefaultStream_();
    NULL_PTR_RETURN_MSG(dftStm, RT_ERROR_STREAM_NULL);

    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        RtAicpuInfoLoadParam param = {aicpuInfo, length};
        return device_->GetCtrlSQ().SendAicpuInfoLoadMsg(RtCtrlMsgType::RT_CTRL_MSG_AICPU_INFOLOAD, param, taskGenCallback_);
    }

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *rtAicpuLoadInfoTask = dftStm->AllocTask(&submitTask, TS_TASK_TYPE_AICPU_INFO_LOAD, errorReason);
    NULL_PTR_RETURN_MSG(rtAicpuLoadInfoTask, errorReason);

    const int32_t streamId = dftStm->Id_();
    rtError_t error = AicpuInfoLoadTaskInit(rtAicpuLoadInfoTask, aicpuInfo, length);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
        "Failed to init AicpuInfoLoadTask, stream_id=%d, task_id=%" PRIu16 ", retCode=%#x.",
        streamId, rtAicpuLoadInfoTask->id, error);

    error = device_->SubmitTask(rtAicpuLoadInfoTask, taskGenCallback_);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit aicpu load info task, retCode=%#x", error);

    error = dftStm->Synchronize();
    ERROR_RETURN_MSG_INNER(error, "Failed to synchronize AicpuInfoLoadTask, retCode=%#x", error);

    return error;

ERROR_RECYCLE:
        dftStm->SetErrCode(0U);
        (void)device_->GetTaskFactory()->Recycle(rtAicpuLoadInfoTask);
        return error;
}

rtError_t Context::DebugRegister(Model * const mdl, const uint32_t flag, const void * const addr,
                                 uint32_t * const streamId, uint32_t * const taskId)
{
    rtError_t error;
    uint32_t flipTaskId = 0;
    Stream * const dftStm = DefaultStream_();
    NULL_PTR_RETURN_MSG(dftStm, RT_ERROR_STREAM_NULL);
    *streamId = static_cast<uint32_t>(dftStm->Id_());
    TaskInfo *rtDbgRegTask = nullptr;

    COND_RETURN_WARN(mdl->IsDebugRegister(),
        RT_ERROR_DEBUG_REGISTER_FAILED, "model repeat debug register!");
    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        RtDebugRegisterParam param = {addr, mdl->Id_(), flag};
        error = device_->GetCtrlSQ().SendDebugRegisterMsg(RtCtrlMsgType::RT_CTRL_MSG_DEBUG_REGISTER, param, taskGenCallback_, &flipTaskId);
        *taskId = flipTaskId;
        *streamId = device_->GetCtrlSQ().GetStream()->Id_();
        ERROR_RETURN_MSG_INNER(error, "Failed to SendDebugRegisterMsg, retCode=%#x.", error);
    } else {
        TaskInfo submitTask = {};
        rtError_t errorReason;
        rtDbgRegTask = dftStm->AllocTask(&submitTask, TS_TASK_TYPE_DEBUG_REGISTER, errorReason);
        NULL_PTR_RETURN_MSG(rtDbgRegTask, errorReason);

        error = DebugRegisterTaskInit(rtDbgRegTask, mdl->Id_(), addr, flag);
        ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
            "Failed to init DebugRegisterTask, stream_id=%d, task_id=%" PRIu16 ", retCode=%#x.",
            *streamId, rtDbgRegTask->id, error);

        error = device_->SubmitTask(rtDbgRegTask, taskGenCallback_, &flipTaskId);
        *taskId = flipTaskId;
        ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit DebugRegisterTask, retCode=%#x", error);

        error = dftStm->Synchronize();
        ERROR_RETURN_MSG_INNER(error, "Failed to synchronize DebugRegisterTask, retCode=%#x.", error);
    }
    mdl->SetDebugRegister(true);
    return error;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtDbgRegTask);
    return RT_ERROR_DEBUG_REGISTER_FAILED;
}

rtError_t Context::DebugUnRegister(Model * const mdl)
{
    rtError_t error;
    Stream * const dftStm = DefaultStream_();
    NULL_PTR_RETURN_MSG(dftStm, RT_ERROR_STREAM_NULL);
    const int32_t streamId = dftStm->Id_();
    TaskInfo *rtDbgUnregTask = nullptr;

    COND_RETURN_WARN(!mdl->IsDebugRegister(),
        RT_ERROR_DEBUG_UNREGISTER_FAILED, "model is not debug register!");

    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        RtDebugUnRegisterParam param = {mdl->Id_()};
        error = device_->GetCtrlSQ().SendDebugUnRegisterMsg(RtCtrlMsgType::RT_CTRL_MSG_DEBUG_UNREGISTER, param, taskGenCallback_);
        ERROR_RETURN_MSG_INNER(error, "Failed to SendDebugUnRegisterMsg, retCode=%#x.", error);
    } else {
        TaskInfo submitTask = {};
        rtError_t errorReason;
        rtDbgUnregTask = dftStm->AllocTask(&submitTask, TS_TASK_TYPE_DEBUG_UNREGISTER, errorReason);
        NULL_PTR_RETURN_MSG(rtDbgUnregTask, errorReason);

        error = DebugUnRegisterTaskInit(rtDbgUnregTask, mdl->Id_());
        ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
            "Failed to init DebugUnRegisterTask, stream_id=%d, task_id=%" PRIu16 ", retCode=%#x.",
            streamId, rtDbgUnregTask->id, error);

        error = device_->SubmitTask(rtDbgUnregTask, taskGenCallback_);
        ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit DebugUnRegisterTask, retCode=%#x.", error);

        error = dftStm->Synchronize();
        ERROR_RETURN_MSG_INNER(error, "Failed to synchronize DebugUnRegisterTask, retCode=%#x.", error);
    }

    mdl->SetDebugRegister(false);
    return error;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtDbgUnregTask);
    return RT_ERROR_DEBUG_UNREGISTER_FAILED;
}

rtError_t Context::DebugRegisterForStream(Stream * const debugStream, const uint32_t flag, const void * const addr,
    uint32_t * const streamId, uint32_t * const taskId)
{
    rtError_t err;
    Stream *setStm = nullptr;
    if (device_->IsStarsPlatform() == true) {
        setStm = debugStream; // STARS架构支持动态配，setdump任务必须下在执行流上，且不需要做流同步
    } else {
        setStm = DefaultStream_(); // HWTS架构不支持动态配，setdump任务下在默认流上，需要做流同步
    }
    NULL_PTR_RETURN_MSG(setStm, RT_ERROR_STREAM_NULL);
    *streamId = static_cast<uint32_t>(setStm->Id_());

    COND_RETURN_WARN(debugStream->IsDebugRegister(),
        RT_ERROR_DEBUG_REGISTER_FAILED, "stream repeat debug register!");

    RT_LOG(RT_LOG_INFO, "send task stream_id=%d, debug_stream_id=%d.",
        setStm->Id_(), debugStream->Id_());

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo* rtDbgRegStreamTask = setStm->AllocTask(&submitTask, TS_TASK_TYPE_DEBUG_REGISTER_FOR_STREAM, errorReason);
    NULL_PTR_RETURN_MSG(rtDbgRegStreamTask, errorReason);

    *taskId = static_cast<uint32_t>(rtDbgRegStreamTask->id);
    err = DebugRegisterForStreamTaskInit(rtDbgRegStreamTask,
        static_cast<uint32_t>(debugStream->Id_()), addr, flag);
    ERROR_GOTO_MSG_INNER(err, ERROR_RECYCLE,
        "Failed to init DebugRegisterForStreamTask, stream_id=%d, debug_stream_id=%d, task_id=%" PRIu16 ",retCode=%#x.",
        *streamId, debugStream->Id_(), rtDbgRegStreamTask->id, err);

    err = device_->SubmitTask(rtDbgRegStreamTask, taskGenCallback_);
    ERROR_GOTO_MSG_INNER(err, ERROR_RECYCLE, "Failed to submit DebugRegisterForStreamTask, retCode=%#x", err);

    *taskId = GetFlipTaskId(rtDbgRegStreamTask->id, rtDbgRegStreamTask->flipNum);

    if (device_->IsStarsPlatform() != true) {
        err = setStm->Synchronize();
        ERROR_RETURN_MSG_INNER(err, "Failed to synchronize DebugRegisterForStreamTask, retCode=%#x", err);
    }
    debugStream->SetDebugRegister(true);
    return err;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtDbgRegStreamTask);
    return RT_ERROR_DEBUG_REGISTER_FAILED;
}

rtError_t Context::DebugUnRegisterForStream(Stream * const debugStream)
{
    rtError_t err;
    Stream *setStm = nullptr;
    if (device_->IsStarsPlatform() == true) {
        setStm = debugStream; // STARS架构支持动态配，setdump任务必须下在执行流上，且不需要做流同步
    } else {
        setStm = DefaultStream_(); // HWTS架构不支持动态配，setdump任务下在默认流上，需要做流同步
    }
    NULL_PTR_RETURN_MSG(setStm, RT_ERROR_STREAM_NULL);

    COND_RETURN_WARN(!debugStream->IsDebugRegister(),
        RT_ERROR_DEBUG_UNREGISTER_FAILED, "stream is not debug register!");

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *rtDbgUnregStreamTask = setStm->AllocTask(&submitTask, TS_TASK_TYPE_DEBUG_UNREGISTER_FOR_STREAM,
                                                       errorReason);
    NULL_PTR_RETURN_MSG(rtDbgUnregStreamTask, errorReason);

    (void)DebugUnRegisterForStreamTaskInit(rtDbgUnregStreamTask, debugStream->Id_());

    err = device_->SubmitTask(rtDbgUnregStreamTask, taskGenCallback_);
    ERROR_GOTO_MSG_INNER(err, ERROR_RECYCLE, "Failed to submit DebugUnRegisterForStreamTask, retCode=%#x", err);

    if (device_->IsStarsPlatform() != true) {
        err = setStm->Synchronize();
        ERROR_RETURN_MSG_INNER(err, "Failed to synchronize DebugUnRegisterForStreamTask, retCode=%#x.", err);
    }
    debugStream->SetDebugRegister(false);

    return err;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtDbgUnregStreamTask);
    return RT_ERROR_DEBUG_UNREGISTER_FAILED;
}

rtError_t Context::MemcpyAsync(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cpySize,
    const rtMemcpyKind_t kind, Stream * const stm, uint64_t * const realSize,
    const std::shared_ptr<void> &guardMem, const rtTaskCfgInfo_t * const cfgInfo,
    const rtD2DAddrCfgInfo_t * const addrCfg)
{
    UNUSED(destMax);
    TaskInfo submitTask = {};
    rtError_t errorReason;

    if (stm == nullptr) {
        return RT_ERROR_STREAM_NULL;
    }

    TaskInfo *rtMemcpyAsyncTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_MEMCPY, errorReason);
    NULL_PTR_RETURN_MSG(rtMemcpyAsyncTask, errorReason);

    rtError_t error = MemcpyAsyncTaskInitV3(rtMemcpyAsyncTask, kind, src, dst, cpySize, cfgInfo, addrCfg);
    if (error != RT_ERROR_NONE) {
        goto ERROR_RECYCLE;
    }
    *realSize = rtMemcpyAsyncTask->u.memcpyAsyncTaskInfo.size;
    if (guardMem != nullptr) {
        rtMemcpyAsyncTask->u.memcpyAsyncTaskInfo.guardMemVec->emplace_back(guardMem);
    }

    error = device_->SubmitTask(rtMemcpyAsyncTask, taskGenCallback_);
    if (error != RT_ERROR_NONE) {
        goto ERROR_RECYCLE;
    }

    GET_THREAD_TASKID_AND_STREAMID(rtMemcpyAsyncTask, stm->AllocTaskStreamId());
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtMemcpyAsyncTask);
    return error;
}

rtError_t Context::GetDevArgsAddr(Stream * const stm, const rtArgsEx_t * const argsInfo, void ** const devArgsAddr,
    void ** const argsHandle) const
{
    ArgLoaderResult result = {};
    const rtError_t error = stm->Device_()->ArgLoader_()->Load(0U, argsInfo, nullptr, stm, &result);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Failed to load args and l2ctrl, stream_id=%d,"
    " retCode=%#x.", stm->Id_(), error);

    *devArgsAddr = result.kerArgs;
    *argsHandle = result.handle;
    stm->fftsMemAllocCnt++;
    RT_LOG(RT_LOG_INFO, "device_id=%u, stream_id=%d, argSize=%u, hasTiling=%u, isNoNeedH2DCopy=%u, hand=%p",
        device_->Id_(), stm->Id_(), argsInfo->argsSize, argsInfo->hasTiling, argsInfo->isNoNeedH2DCopy, result.handle);
    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_INFO) == 0) {
        return error;
    }
    RT_LOG(RT_LOG_INFO, "device_id=%u, stream_id=%d argSize=%u hand=%p", device_->Id_(), stm->Id_(),
        argsInfo->argsSize, result.handle);
    const uint32_t * const cmd = RtPtrToPtr<const uint32_t *, void *>(argsInfo->args);
    for (size_t i = 0UL; i < (argsInfo->argsSize) / sizeof(uint32_t); i++) {
        RT_LOG(RT_LOG_INFO, "args[%u]:%08x", i, cmd[i]);
    }
    return error;
}

rtError_t Context::LaunchSqeUpdateTask(const void * const src, const uint64_t cpySize, uint32_t sqId,
                                       uint32_t pos, Stream * const stm)
{
    TaskInfo submitTask = {};
    rtError_t errorReason;

    NULL_PTR_RETURN_MSG_OUTER(stm, RT_ERROR_INVALID_VALUE);

    TaskInfo *rtMemcpyAsyncTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_MEMCPY, errorReason);
    NULL_PTR_RETURN_MSG(rtMemcpyAsyncTask, errorReason);

    rtError_t error = MemcpyAsyncD2HTaskInit(rtMemcpyAsyncTask, src, cpySize, sqId, pos);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, exe_stream_id=%d, dsa_sq_id=%u, dsa_pos=%u, cpySize=%#" PRIx64,
            device_->Id_(), stm->Id_(), sqId, pos);
        goto ERROR_RECYCLE;
    }

    error = device_->SubmitTask(rtMemcpyAsyncTask, taskGenCallback_);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, exe_stream_id=%d, dsa_sq_id=%u, dsa_pos=%u, cpySize=%#" PRIx64,
            device_->Id_(), stm->Id_(), sqId, pos);
        goto ERROR_RECYCLE;
    }

    GET_THREAD_TASKID_AND_STREAMID(rtMemcpyAsyncTask, stm->AllocTaskStreamId());
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtMemcpyAsyncTask);
    return error;
}

static void InitStarsSdmaSqe(
    rtStarsSdmaSqe_t *sdmaSqe, const uint64_t count, const Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo)
{
    if (cfgInfo != nullptr) {
        sdmaSqe->qos = cfgInfo->qos;
        sdmaSqe->partid = cfgInfo->partId;
    } else {
        sdmaSqe->qos = 0U;
        sdmaSqe->partid = 0U;
    }
    uint32_t memcpyAsyncTaskD2DQos = stm->Device_()->GetDevProperties().memcpyAsyncTaskD2DQos;
    if ((memcpyAsyncTaskD2DQos != UINT32_MAX) && (cfgInfo != nullptr) && (cfgInfo->d2dCrossFlag != true)) {
        sdmaSqe->qos = memcpyAsyncTaskD2DQos;
    }

    sdmaSqe->sssv = 1U;
    sdmaSqe->dssv = 1U;
    sdmaSqe->sns  = 1U;
    sdmaSqe->dns  = 1U;
    sdmaSqe->srcStreamId = static_cast<uint16_t>(RT_SMMU_STREAM_ID_1FU);
    sdmaSqe->dst_streamid = static_cast<uint16_t>(RT_SMMU_STREAM_ID_1FU);
    sdmaSqe->src_sub_streamid = static_cast<uint16_t>(stm->Device_()->GetSSID_());
    sdmaSqe->dstSubStreamId = static_cast<uint16_t>(stm->Device_()->GetSSID_());
    sdmaSqe->length = static_cast<uint32_t>(count);
}

rtError_t Context::MemcpyAsyncPtr(rtMemcpyAddrInfo * const memcpyAddrInfo, const uint64_t destMax,
    const uint64_t count, Stream *stm, const std::shared_ptr<void> &guardMem,
    const rtTaskCfgInfo_t * const cfgInfo, const bool isMemcpyDesc) const
{
    UNUSED(destMax);
    rtError_t error;
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *cpyAsyncTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_MEMCPY, errorReason);
    NULL_PTR_RETURN_MSG(cpyAsyncTask, errorReason);

    rtStarsSdmaSqe_t sdmaSqe = {};
    uint64_t dstMax = 16U;
    uint64_t copySize = sizeof(rtStarsSdmaSqe_t);
    if (isMemcpyDesc) {
        dstMax = MEMCPY_DESC_LENGTH_OFFSET;
        copySize = MEMCPY_DESC_LENGTH_OFFSET;
        InitStarsSdmaSqe(&sdmaSqe, 0ULL, stm, cfgInfo);
    } else {
        InitStarsSdmaSqe(&sdmaSqe, count, stm, cfgInfo);
    }
    RT_LOG(RT_LOG_INFO, "memcpyAddrInfo=0x%lx , qos=%u",
        RtPtrToValue<rtMemcpyAddrInfo *>(memcpyAddrInfo), sdmaSqe.qos);
    if (device_->Driver_() ->GetRunMode() == RT_RUN_MODE_ONLINE) {
        error = device_->Driver_()->MemCopySync(memcpyAddrInfo, dstMax, &sdmaSqe, copySize, RT_MEMCPY_HOST_TO_DEVICE);
        if (error != RT_ERROR_NONE) {
            ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
                "Failed to memory copy stream info, device_id=%u, size=%zu, retCode=%#x.",
                device_->Id_(), copySize, error);
        }
        error = device_->Driver_()->DevMemFlushCache(RtPtrToValue<rtMemcpyAddrInfo *>(memcpyAddrInfo), dstMax);
        if (error != RT_ERROR_NONE) {
            ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to flush stream info, device_id=%u, "
                "retCode=%#x", device_->Id_(), error);
        }
    } else {
        error = device_->Driver_()->MemCopySync(memcpyAddrInfo, dstMax, &sdmaSqe, copySize, RT_MEMCPY_HOST_TO_DEVICE);
        if (error != RT_ERROR_NONE) {
            ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to memory copy stream info, device_id=%u, "
                "retCode=%#x", device_->Id_(), error);
        }
    }

    if (isMemcpyDesc) {
        error = MemcpyAsyncTaskInitV1(cpyAsyncTask, memcpyAddrInfo, 0ULL);
    } else {
        error = MemcpyAsyncTaskInitV1(cpyAsyncTask, memcpyAddrInfo, count);
    }
    if (error != RT_ERROR_NONE) {
        goto ERROR_RECYCLE;
    }

    if (guardMem != nullptr) {
        cpyAsyncTask->u.memcpyAsyncTaskInfo.guardMemVec->emplace_back(guardMem);
    }

    error = device_->SubmitTask(cpyAsyncTask, taskGenCallback_);
    if (error != RT_ERROR_NONE) {
        goto ERROR_RECYCLE;
    }

    GET_THREAD_TASKID_AND_STREAMID(cpyAsyncTask, stm->AllocTaskStreamId());
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(cpyAsyncTask);
    return error;
}

rtError_t Context::MemCopy2DAsync(void * const dst, const uint64_t dstPitch, const void * const src,
    const uint64_t srcPitch, const uint64_t width, const uint64_t height, const rtMemcpyKind_t kind,
    uint64_t * const realSize, Stream * const stm, const uint64_t fixedSize)
{
    TaskInfo submitTask = {};
    rtError_t errorReason;

    if (stm == nullptr) {
        return RT_ERROR_STREAM_NULL;
    }

    TaskInfo *taskAsync2d = stm->AllocTask(&submitTask, TS_TASK_TYPE_MEMCPY, errorReason);
    NULL_PTR_RETURN_MSG(taskAsync2d, errorReason);

    rtError_t error = MemcpyAsyncTaskInitV2(taskAsync2d, dst, dstPitch, src, srcPitch, width, height, kind, fixedSize);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "invoke taskAsync2d Init error code:%#x", error);
        goto ERROR_RECYCLE;
    }
    *realSize = taskAsync2d->u.memcpyAsyncTaskInfo.size;

    error = device_->SubmitTask(taskAsync2d, taskGenCallback_);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "invoke device_ SubmitTask error code:%#x", error);
        goto ERROR_RECYCLE;
    }

    GET_THREAD_TASKID_AND_STREAMID(taskAsync2d, stm->AllocTaskStreamId());
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(taskAsync2d);
    return error;
}

rtError_t Context::CheckMemAlign(const void * const addr, const rtDataType_t type) const
{
    if ((type == RT_DATA_TYPE_FP16)  ||
               (type == RT_DATA_TYPE_INT16) ||
               (type == RT_DATA_TYPE_UINT16) ||
               (type == RT_DATA_TYPE_BFP16)) {
        return CheckMemAddrAlign2B(RtPtrToValue<const void *>(addr));
    } else if ((type == RT_DATA_TYPE_FP32)  ||
               (type == RT_DATA_TYPE_INT32) ||
               (type == RT_DATA_TYPE_UINT32)) {
        return CheckMemAddrAlign4B(RtPtrToValue<const void *>(addr));
    } else {
        return RT_ERROR_NONE;
    }
}

rtError_t Context::ReduceAsync(void * const dst, const void * const src, const uint64_t cpySize,
    const rtRecudeKind_t kind, const rtDataType_t type, Stream * const stm,
    const rtTaskCfgInfo_t * const cfgInfo)
{
    TIMESTAMP_BEGIN(rtReduceAsync_part1);
    rtError_t error;
    Driver * const devDrv = device_->Driver_();
    const uint32_t deviceId = device_->Id_();
    if (devDrv != nullptr) {
        rtDevCapabilityInfo capabilityInfo = {};
        error = device_->GetDeviceCapabilities(capabilityInfo);
        ERROR_RETURN_MSG_INNER(error, "Get chip capability failed, device_id=%u, retCode=%#x.",
            deviceId, error);

        const uint32_t sdmaReduceSupport = capabilityInfo.sdma_reduce_support;

        // sdma_reduce_kind is a new field and is not set in the earlier version of the driver.
        // Therefore, this field is checked only in Cloud_v2.
        const bool starsFlag = device_->IsStarsPlatform();
        if (starsFlag) {
            const uint32_t sdmaReduceKind = capabilityInfo.sdma_reduce_kind;
            RT_LOG(RT_LOG_INFO, "ReduceAsync sdma_reduce_kind=0x%x.", sdmaReduceKind);
            const uint32_t shift = static_cast<uint32_t>(kind) - static_cast<uint32_t>(RT_MEMCPY_SDMA_AUTOMATIC_ADD);
            if (((sdmaReduceKind >> shift) & 0x1U) == 0U) { // 1:bit 0
                RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1006, "kind=" + std::to_string(kind));
                return RT_ERROR_FEATURE_NOT_SUPPORT;
            }
        }

        // EQUAL kind only support Cloud_v2
        if (((kind == RT_MEMCPY_SDMA_AUTOMATIC_EQUAL) && (!starsFlag))) {
            RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1006, "kind=" + std::to_string(kind));
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }

        const uint32_t kindShift = static_cast<uint32_t>(kind);
        if (((device_->GetDevProperties().sdmaReduceKind >> kindShift) & 0x1U) == 0U) {
            RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1006, "kind=" + std::to_string(kind));
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }

        const uint32_t offset = static_cast<uint32_t>(type);
        RT_LOG(RT_LOG_INFO, "ReduceAsync sdma_reduce_support=0x%x.", sdmaReduceSupport);
        if (((sdmaReduceSupport >> offset) & 0x1U) == 0U) { // 1:bit 0
            RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1006, "type=" + std::to_string(type));
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
    }
    TIMESTAMP_END(rtReduceAsync_part1);

    TIMESTAMP_BEGIN(rtReduceAsync_part2);
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *rtMemcpyAsyncTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_MEMCPY, errorReason);
    NULL_PTR_RETURN_MSG(rtMemcpyAsyncTask, errorReason);

    error = MemcpyAsyncTaskInitV3(rtMemcpyAsyncTask, kind, src, dst, cpySize, cfgInfo, nullptr);
    if (error != RT_ERROR_NONE) {
        goto ERROR_RECYCLE;
    }
    rtMemcpyAsyncTask->u.memcpyAsyncTaskInfo.copyDataType = static_cast<uint8_t>(type);

    error = CheckMemAlign(src, type);
    if (error != RT_ERROR_NONE) {
        goto ERROR_RECYCLE;
    }

    error = CheckMemAlign(dst, type);
    if (error != RT_ERROR_NONE) {
        goto ERROR_RECYCLE;
    }

    error = device_->SubmitTask(rtMemcpyAsyncTask);
    if (error != RT_ERROR_NONE) {
        goto ERROR_RECYCLE;
    }

    GET_THREAD_TASKID_AND_STREAMID(rtMemcpyAsyncTask, stm->AllocTaskStreamId());
    TIMESTAMP_END(rtReduceAsync_part2);
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtMemcpyAsyncTask);
    return error;
}

rtError_t Context::ReduceAsyncV2(void * const dst, const void * const src, const uint64_t cpySize,
    const rtRecudeKind_t kind, const rtDataType_t type, Stream * const stm, void * const overflowAddr)
{
    rtError_t error;
    TIMESTAMP_BEGIN(rtReduceAsyncV2_part1);
    Driver * const devDrv = device_->Driver_();
    const uint32_t deviceId = device_->Id_();

    if (devDrv != nullptr) {
        rtDevCapabilityInfo capabilityInfo = {};
        error = device_->GetDeviceCapabilities(capabilityInfo);
        ERROR_RETURN_MSG_INNER(error, "Get chip capability failed, device_id=%u, retCode=%#x.",
            deviceId, error);

        const uint32_t sdmaReduceSupport = capabilityInfo.sdma_reduce_support;
        const uint32_t offset = static_cast<uint32_t>(type);
        RT_LOG(RT_LOG_INFO, "ReduceAsyncV2 sdma_reduce_support=0x%x.", sdmaReduceSupport);
        if (((sdmaReduceSupport >> offset) & 0x1U) == 0U) { // 1:bit 0
            RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1006, "type=" + std::to_string(type));
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
    }
    TIMESTAMP_END(rtReduceAsyncV2_part1);

    TIMESTAMP_BEGIN(rtReduceAsyncV2_part2);
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *rtReduceAsyncV2Task = stm->AllocTask(&submitTask, TS_TASK_TYPE_REDUCE_ASYNC_V2, errorReason);
    NULL_PTR_RETURN_MSG(rtReduceAsyncV2Task, errorReason);

    std::function<void()> const reduceAsyncV2TaskRecycle = [&, rtReduceAsyncV2Task]() {
        (void)device_->GetTaskFactory()->Recycle(rtReduceAsyncV2Task);
    };
    ScopeGuard taskGuarder(reduceAsyncV2TaskRecycle);
    rtReduceAsyncV2Task->u.reduceAsyncV2TaskInfo.overflowAddrOffset = INVALID_CONTEXT_OVERFLOW_OFFSET;
    if ((device_->GetTschVersion() >= static_cast<uint32_t>(TS_VERSION_REDUCV2_OPTIMIZE)) &&
        (RtPtrToValue<void *>(overflowAddr) == RtPtrToValue<void *>(overflowAddr_))) {
        rtReduceAsyncV2Task->u.reduceAsyncV2TaskInfo.overflowAddrOffset = overflowAddrOffset_;
    }

    error = ReduceAsyncV2TaskInit(rtReduceAsyncV2Task, kind, src, dst, cpySize, overflowAddr);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    rtReduceAsyncV2Task->u.reduceAsyncV2TaskInfo.copyDataType = static_cast<uint8_t>(type);

    error = CheckMemAlign(src, type);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    error = CheckMemAlign(dst, type);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    error = device_->SubmitTask(rtReduceAsyncV2Task);    
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    GET_THREAD_TASKID_AND_STREAMID(rtReduceAsyncV2Task, stm->AllocTaskStreamId());
    taskGuarder.ReleaseGuard();
    TIMESTAMP_END(rtReduceAsyncV2_part2);
    return RT_ERROR_NONE;
}

rtError_t Context::MemsetAsync(void * const ptr, const uint64_t destMax, const uint32_t fillVal,
                               const uint64_t fillCount, Stream * const stm)
{
    const Runtime * const rtInstance = Runtime::Instance();
    RT_LOG(RT_LOG_DEBUG, "current chip type is %u,"
        " fillVal=%u, fillCount=%" PRIu64 ", destMax=%" PRIu64 ", stream_id=%d.",
        rtInstance->GetChipType(), fillVal, fillCount, destMax, stm->Id_());
    rtError_t error;
    errno_t ret = EOK;

    rtPtrAttributes_t attributes;
    error = device_->Driver_()->PtrGetAttributes(ptr, &attributes);
    ERROR_RETURN_MSG_INNER(error, "get pointer attribute failed, retCode=%#x.", error);

    if ((attributes.location.type == RT_MEMORY_LOC_HOST) || (attributes.location.type == RT_MEMORY_LOC_UNREGISTERED)) {
        RT_LOG(RT_LOG_DEBUG, "memset location type is %u.", attributes.location.type);
        ret = memset_s(ptr, destMax, static_cast<int32_t>(fillVal), fillCount);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, ret != EOK, RT_ERROR_SEC_HANDLE,
            "Memset async failed, due to memset_s failed, destMax=%" PRIu64 ", fillCount=%" PRIu64 ", retCode=%d.",
            destMax, fillCount, ret);
    } else {
        void *hostPtr = nullptr;
        std::shared_ptr<void> hostPtrGuard;
        // malloc 64M Host memory and memset with parameter:fillVal
        hostPtr = AlignedMalloc(MEM_ALIGN_SIZE, static_cast<size_t>(MEM_BLOCK_SIZE));
        NULL_PTR_RETURN_MSG(hostPtr, RT_ERROR_MEMORY_ALLOCATION);
        hostPtrGuard.reset(hostPtr, &AlignedFree);
        const uint64_t setSize = (fillCount < MEM_BLOCK_SIZE) ? fillCount : MEM_BLOCK_SIZE;
        ret = memset_s(hostPtr, setSize, static_cast<int32_t>(fillVal), setSize);
        if (ret != EOK) {
            RT_LOG(RT_LOG_DEBUG, "memset_s failed, retCode=%d", ret);
            hostPtr = nullptr;
            return RT_ERROR_SEC_HANDLE;
        }

        if (fillCount > destMax) {
            RT_LOG(RT_LOG_WARNING,
                "current fillCount=%" PRIu64 ", destMax=%" PRIu64 ", fillCount must be less than or equal to destMax!",
                fillCount, destMax);
            hostPtr = nullptr;
            return RT_ERROR_MEMORY_ALLOCATION;
        }

        uint64_t remainSize = (fillCount < MEM_BLOCK_SIZE) ? fillCount : MEM_BLOCK_SIZE;
        uint64_t realSize = 0UL;
        uint64_t doneSize = 0UL;
        // memcpyaync this Host memory to ptr
        while (remainSize > 0ULL) {
            error = MemcpyAsync((RtPtrToPtr<char_t *, void *>(ptr)) + doneSize, destMax - doneSize,
                RtPtrToPtr<char_t *, void *>(hostPtr) + doneSize,
                remainSize, RT_MEMCPY_HOST_TO_DEVICE, stm, &realSize, hostPtrGuard);
            ERROR_RETURN_MSG_INNER(error, "Memcpy async step1 failed, retCode=%#x,"
                " max size=%" PRIu64 "(bytes), src size=%" PRIu64 "(bytes), type=%d.",
                error, destMax - doneSize, remainSize, RT_MEMCPY_HOST_TO_DEVICE);
            doneSize += realSize;
            remainSize -= realSize;
        }

        if (fillCount > MEM_BLOCK_SIZE) {
            const uint64_t memBlockNum = fillCount / MEM_BLOCK_SIZE;
            uint64_t idx = 1UL;
            for (; idx < memBlockNum; idx++) {
                error = MemcpyAsync(RtPtrToPtr<char_t *, void *>(ptr) + (idx * MEM_BLOCK_SIZE),
                    destMax - (idx * MEM_BLOCK_SIZE), RtPtrToPtr<char_t *, void *>(ptr), MEM_BLOCK_SIZE,
                    RT_MEMCPY_DEVICE_TO_DEVICE, stm, &realSize);
                ERROR_RETURN_MSG_INNER(error, "Memcpy async step2 failed,"
                    " max size=%" PRIu64 "(bytes), src size=%" PRIu64 "(bytes), type=%d.",
                    destMax - (idx * MEM_BLOCK_SIZE), MEM_BLOCK_SIZE, RT_MEMCPY_DEVICE_TO_DEVICE);
            }

            const uint64_t memRemain = fillCount % MEM_BLOCK_SIZE;
            if (memRemain > 0ULL) {
                char_t * const dstAddr = (RtPtrToPtr<char_t *, void *>(ptr)) + (memBlockNum * MEM_BLOCK_SIZE);
                error = MemcpyAsync(dstAddr, destMax - (memBlockNum * MEM_BLOCK_SIZE), static_cast<char_t *>(ptr),
                    memRemain, RT_MEMCPY_DEVICE_TO_DEVICE, stm, &realSize);
                ERROR_RETURN_MSG_INNER(error, "Memcpy async step3 failed,"
                    " max size=%" PRIu64 "(bytes), src size=%" PRIu64 "(bytes), type=%d.",
                    destMax - (memBlockNum * MEM_BLOCK_SIZE), memRemain, RT_MEMCPY_DEVICE_TO_DEVICE);
            }
        }
    }

    return error;
}

rtError_t Context::StreamCreate(const uint32_t prio, const uint32_t flag, Stream ** const result, DvppGrp *grp,
    const bool isSoftWareSqEnable)
{
    rtError_t error = RT_ERROR_NONE;
    if ((flag & RT_STREAM_CP_PROCESS_USE) != 0U) {
        const bool isMc2SupportHccl = CheckSupportMC2Feature(device_);
        if (!isMc2SupportHccl) {
            RT_LOG(RT_LOG_WARNING, "Current ts version[%u] does not support create coprocessor stream.",
                device_->GetTschVersion());
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
    }

    Stream *newStream = StreamFactory::CreateStream(device_, prio, flag, grp);
    COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, newStream == nullptr, ERROR_RETURN,
        error, RT_ERROR_STREAM_NEW,
        "Stream create failed, stream is null, failed to alloc newStream, retCode=%#x.", error);

    if ((flag & RT_STREAM_FAST_SYNC) != 0U) {
        newStream->SetStreamFastSync(true);
    }

    if (!isSoftWareSqEnable) {
        error = newStream->Setup();
    } else {
        newStream->SetSoftWareSqEnable();
        error = newStream->SetupWithoutBindSq();
    }

    ERROR_GOTO(error, ERROR_RECYCLE, "Setup stream failed, retCode=%#x.", error);
    newStream->SetContext(this);
    if ((flag & RT_STREAM_FORBIDDEN_DEFAULT) == 0U) {
        std::unique_lock<std::mutex> taskLock(streamLock_);
        streams_.push_back(newStream);
    }

    *result = newStream;
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    DeleteStream(newStream);
ERROR_RETURN:
    *result = nullptr;
    return error;
}

rtError_t Context::StreamDestroy(Stream * const stm, bool flag)
{
    rtError_t error;
    std::unique_lock<std::mutex> taskLock(streamLock_);
    streams_.remove(stm);
    taskLock.unlock();
    error = TearDownStream(stm, flag);
    return error;
}

void Context::SetStreamsStatus(rtError_t status)
{
    std::unique_lock<std::mutex> taskLock(streamLock_);
    defaultStream_->SetAbortStatus(status);
    for (Stream *stream : streams_) {
        // jump over model stream and mc2 streams
        if (stream->GetBindFlag() || ((stream->Flags() & RT_STREAM_CP_PROCESS_USE) != 0U)) {
            continue;
        }
        stream->SetAbortStatus(status);
    }
    if (isPrimary_ && device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        GetCtrlSQStream()->SetAbortStatus(status);
    }
}

rtError_t Context::StreamsCleanSq(void)
{
    rtError_t error = RT_ERROR_NONE;
    std::unique_lock<std::mutex> taskLock(streamLock_);
    error = defaultStream_->CleanSq();
    ERROR_RETURN(error, "Failed to clean default stream, retCode=%#x.", error);
    for (Stream *stream : streams_) {
        // jump over model stream and mc2 streams
        if (stream->GetBindFlag() || ((stream->Flags() & RT_STREAM_CP_PROCESS_USE) != 0U)) {
            continue;
        }
        error = stream->CleanSq();
        ERROR_RETURN(error, "Failed to clean stream id %d, retCode=%#x.", stream->Id_(), error);
    }
    if (isPrimary_ && device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        error = GetCtrlSQStream()->CleanSq();
        ERROR_RETURN(error, "Failed to clean stream, retCode=%#x.", error);
    }
    return error;
}

rtError_t Context::StreamsKill(void)
{
    rtError_t error;
    std::unique_lock<std::mutex> taskLock(streamLock_);
    uint32_t result;
    error = defaultStream_->TaskAbortByType(result, OP_ABORT_APP);
    ERROR_RETURN(error, "retCode=%#x.", error);
    return error;
}

rtError_t Context::StreamsQuery(uint32_t &status)
{
    rtError_t error;
    std::unique_lock<std::mutex> taskLock(streamLock_);
    error = defaultStream_->QuerySq(APP_ABORT_STS_QUERY_BY_PID, status);
    ERROR_RETURN(error, "retCode=%#x.", error);
    return error;
}

rtError_t Context::StreamsTaskClean(void)
{
    rtError_t error = RT_ERROR_NONE;
    std::unique_lock<std::mutex> taskLock(streamLock_);
    error = defaultStream_->ResClear();
    ERROR_RETURN(error, "ResClear default stream fail, retCode=%#x.", error);
    for (Stream *stream : streams_) {
        // jump over model stream and mc2 streams
        if (stream->GetBindFlag() || ((stream->Flags() & RT_STREAM_CP_PROCESS_USE) != 0U)) {
            continue;
        }
        error = stream->ResClear();
    }
    if (isPrimary_ && device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        error = GetCtrlSQStream()->ResClear();
        ERROR_RETURN(error, "retCode=%#x.", error);
    }

    Device_()->Driver_()->ResourceReset(Device_()->Id_(), Device_()->DevGetTsId(), DRV_EVENT_ID);
    return error;
}

rtError_t Context::StreamsUpdate(void)
{
    rtError_t error = RT_ERROR_NONE;
    std::unique_lock<std::mutex> taskLock(streamLock_);
    error = defaultStream_->SqCqUpdate();
    for (Stream *stream : streams_) {
        // jump over model stream and mc2 streams
        if (stream->GetBindFlag() || ((stream->Flags() & RT_STREAM_CP_PROCESS_USE) != 0U)) {
            continue;
        }
        error = stream->SqCqUpdate();
        ERROR_RETURN(error, "retCode=%#x.", error);
    }
    if (isPrimary_ && device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        error = GetCtrlSQStream()->SqCqUpdate();
        ERROR_RETURN(error, "retCode=%#x.", error);
    }
    return error;
}

rtError_t Context::StreamsRestore(void)
{
    rtError_t error = RT_ERROR_NONE;
    std::unique_lock<std::mutex> taskLock(streamLock_);
    error = defaultStream_->Restore();
    ERROR_RETURN(error, "Restore stream id %d failed, retCode=%#x.", defaultStream_->Id_(), error);
    for (Stream *s : streams_) {
        error = s->Restore();
        ERROR_RETURN(error, "Restore stream id %d failed, retCode=%#x.", s->Id_(), error);
    }
    if (isPrimary_ && device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        error = GetCtrlSQStream()->Restore();
        ERROR_RETURN(error, "retCode=%#x.", error);
    }
    return RT_ERROR_NONE;
}

Module *Context::GetModule(Program * const prog)
{
    const uint32_t progId = prog->Id_();
    Module *mdl = nullptr;

    if (progId >= Runtime::maxProgramNum_) {
        return nullptr;
    }

    const std::unique_lock<std::mutex> taskLock(moduleLock_);
    Module ** const module = moduleAllocator_->GetDataToItem(progId);
    if (module == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Get module pool NULL by id:%u", progId);
        return nullptr;
    }
    if (*module == nullptr) {
        mdl = device_->ModuleAlloc(prog);
        moduleAllocator_->SetDataToItem(progId, mdl);
        if (mdl != nullptr) {
            prog->Insert2CtxMap(module, this);
        }
    }
    mdl = *module;
    return mdl;
}

void Context::PutModule(Module * const delModule)
{
    if (likely(delModule != nullptr)) {
        (void)device_->ModuleRelease(delModule);
    }
}

rtError_t Context::ReleaseModule(const uint32_t id)
{
    NULL_PTR_RETURN_MSG(moduleAllocator_, RT_ERROR_CONTEXT_NULL);
    Module ** const moduleItem = moduleAllocator_->GetDataToItem(id);

    std::unique_lock<std::mutex> taskLock(moduleLock_);
    if ((moduleItem != nullptr) && (*moduleItem != nullptr)) {
        Module * const delModule = *moduleItem;
        Program * const prog = delModule->GetProgram();
        *moduleItem = nullptr;
        if (prog != nullptr) {
            prog->Remove2CtxMap(moduleItem);
        }

        PutModule(delModule);
    }
    return RT_ERROR_NONE;
}

bool Context::TearDownIsCanExecute()
{
    // for multi-thread
    // only one thread can execute context teardown.
    TearDownStatus expected = TEARDOWN_NOT_EXECUTE;
    TearDownStatus desired = TEARDOWN_WORKING;
    if (!tearDownStatus_.compare_exchange_strong(expected, desired)) {
        expected = TEARDOWN_ERROR;
        return tearDownStatus_.compare_exchange_strong(expected, desired);
    }
    return true;
}

rtError_t Context::ModelCreate(Model ** const result, ModelType type)
{
    rtError_t error = RT_ERROR_NONE;
    Model *newModel = (type == RT_MODEL_CAPTURE_MODEL) ?
        new (std::nothrow) CaptureModel() :
        new (std::nothrow) Model();
    COND_GOTO_ERROR_MSG_AND_ASSIGN_INNER(newModel == nullptr, ERROR_RETURN, error, RT_ERROR_MODEL_NEW,
        "Model create failed, failed to alloc model.");

    error = newModel->Setup(this);
    ERROR_GOTO(error, ERROR_RECYCLE, "Setup model failed, retCode=%#x.", error);
    modelLock_.Lock();
    models_.push_back(newModel);
    modelLock_.Unlock();

    *result = newModel;
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    DELETE_O(newModel);
ERROR_RETURN:
    *result = nullptr;
    return error;
}

rtError_t Context::ModelDestroy(Model *mdl)
{
    if (mdl->GetModelType() == RT_MODEL_CAPTURE_MODEL) {
        CaptureModel *captureModel = dynamic_cast<CaptureModel *>(mdl);
        if (captureModel->IsCapturing()) {
            RT_LOG(RT_LOG_ERROR, "model is capturing, can't destroy, model_id=%u!", captureModel->Id_());
            return RT_ERROR_MODEL_CAPTURED;
        }

        constexpr uint32_t totalCheckCount = 10000U;                  // 10s
        constexpr auto checkInterval = std::chrono::milliseconds(1);  // 1ms 检查一次
        uint32_t count = 0U;
        while (captureModel->IsCaptureModelRunning()) {
            COND_RETURN_ERROR((count >= totalCheckCount), RT_ERROR_MODEL_RUNNING,
                "model is still running, can't destroy, model_id=%u", captureModel->Id_());
            std::this_thread::sleep_for(checkInterval);
            count++;
        }
    }

    modelLock_.Lock();
    (void)mdl->TearDown();
    models_.remove(mdl);
    modelLock_.Unlock();
    DELETE_O(mdl);

    return RT_ERROR_NONE;
}


rtError_t Context::ModelUnbindStream(Model * const mdl, Stream * const stm)
{
    std::unique_lock<std::mutex> taskLock(streamLock_);
    const int32_t streamId = stm->Id_();
    const uint32_t modelId = mdl->Id_();

    const rtError_t error = mdl->UnbindStream(stm);
    ERROR_GOTO_MSG_INNER(error, COMPLETE, "Unbind stream failed, model_id=%u, stream_id=%d, retCode=%#x.",
        modelId, streamId, error);

    if (stm->GetModelNum() == 0) {
        streams_.push_back(stm);
    }
COMPLETE:
    return error;
}

rtError_t Context::ModelBindStream(Model * const mdl, Stream * const stm, const uint32_t flag)
{
    rtError_t error;

    std::unique_lock<std::mutex> taskLock(streamLock_);
    const int32_t streamId = stm->Id_();
    const uint32_t modelId = mdl->Id_();

    error = mdl->BindStream(stm, flag);
    ERROR_GOTO_MSG_INNER(error, COMPLETE, "Bind stream failed, model_id=%u, stream_id=%d, retCode=%#x.",
        modelId, streamId, error);

    stm->SetIsSupportASyncRecycle(false);
    streams_.remove(stm);
COMPLETE:
    return error;
}

rtError_t Context::ModelAddStream(Model * const mdl, Stream * const stm, const uint32_t flag)
{
    rtError_t error;

    std::unique_lock<std::mutex> taskLock(streamLock_);
    const int32_t streamId = stm->Id_();
    const uint32_t modelId = mdl->Id_();

    error = mdl->AddStream(stm, flag);
    ERROR_RETURN_MSG_INNER(error, "Add stream failed, model_id=%u, stream_id=%d, retCode=%#x.",
        modelId, streamId, error);

    stm->SetIsSupportASyncRecycle(false);
    streams_.remove(stm);

    return RT_ERROR_NONE;
}

rtError_t Context::ModelDelStream(Model * const mdl, Stream * const stm)
{
    std::unique_lock<std::mutex> taskLock(streamLock_);
    const int32_t streamId = stm->Id_();
    const uint32_t modelId = mdl->Id_();

    const rtError_t error = mdl->DelStream(stm);
    ERROR_RETURN_MSG_INNER(error, "Del stream failed, model_id=%u, stream_id=%d, retCode=%#x.",
        modelId, streamId, error);

    if (stm->GetModelNum() == 0) {
        streams_.push_back(stm);
    }

    return RT_ERROR_NONE;
}

rtError_t Context::ModelLoadComplete(Model * const mdl) const
{
    const uint32_t modelId = mdl->Id_();

    const rtError_t error = mdl->LoadComplete();
    ERROR_RETURN_MSG_INNER(error, "Model load complete process failed, model_id=%u, retCode=%#x.",
        modelId, error);

    return error;
}

rtError_t Context::GetNotifyAddress(Notify * const notify, uint64_t &addr, Stream * const stm)
{
    const rtError_t error = notify->GetNotifyAddress(stm, addr);
    ERROR_RETURN_MSG_INNER(error, "GetNotifyAddress failed, retCode=%#x.", error);
    return error;
}

rtError_t Context::ModelAddEndGraph(Model * const mdl, Stream * const stm, const uint32_t flags)
{
    rtError_t error;
    // rtSetSocVersion modify ThreadLocalContainer::socType_, not Runtime::socType_
    const uint32_t modelExecuteType = mdl->ModelExecuteType();
    stm->SetLatestModlId(static_cast<int32_t>(mdl->Id_()));
    if ((device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_EXECUTOR_WITH_QUEUE)) &&
        (!RtIsHeterogenous())) {
        bool useAicpuExcutor = false;
#if (!defined(CFG_VECTOR_CAST))
        useAicpuExcutor = mdl->IsModelHeadStream(stm) && ((stm->Flags() & RT_STREAM_AICPU) != 0U);
#endif
        if (((flags & RT_KERNEL_DUMPFLAG) == 0U) && (modelExecuteType != EXECUTOR_AICPU)  && !useAicpuExcutor) {
            RT_LOG(RT_LOG_INFO, "not submit endGraph.");
            return RT_ERROR_NONE;
        }
    }
    const uint32_t endGraphNum = mdl->EndGraphNum_();
    COND_RETURN_OUT_ERROR_MSG_CALL(endGraphNum >= 1U, RT_ERROR_MODEL_ENDGRAPH,
        "Model add end graph failed, current endGraphNum(%u), model must have only one endgraph.", endGraphNum);

    if (device_->IsStarsPlatform() && (modelExecuteType != EXECUTOR_AICPU)) {
        const bool isBindThisModel = ((stm->Model_() != nullptr) && (stm->Model_()->Id_() == mdl->Id_()));
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM,
            (stm->GetModelNum() == 0) || (!isBindThisModel), RT_ERROR_STREAM_INVALID,
            "stream %d has not been add to model %u", stm->Id_(), mdl->Id_());

        Notify *notify = const_cast<Notify *>(mdl->GetEndGraphNotify());
        if (notify == nullptr) {
            RT_LOG(RT_LOG_INFO, "create notify, stream_id=%d", stm->Id_());
            notify = new (std::nothrow) Notify(device_->Id_(), device_->DevGetTsId());
            COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, notify == nullptr, RT_ERROR_NOTIFY_NEW,
                "Add end graph of model failed, new notify failed.");
            error = notify->Setup();
            COND_PROC_RETURN_WARN(error != RT_ERROR_NONE, error,
                DELETE_O(notify), "Notify setup failed, retCode=%#x", error);
        }

        error = notify->Record(stm);
        if (error != RT_ERROR_NONE) {
            DELETE_O(notify);
            mdl->SetEndGraphNotify(nullptr);
            RT_LOG(RT_LOG_ERROR, "Notify record failed, retCode=%#x", error);
            return error;
        }

        notify->SetEndGraphModel(mdl);
        mdl->SetEndGraphNotify(notify);
        RT_LOG(RT_LOG_INFO, "notify record ok. stream_id=%d", stm->Id_());
        return RT_ERROR_NONE;
    }

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *rtAddEndGraphTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_MODEL_END_GRAPH, errorReason);
    NULL_PTR_RETURN_MSG(rtAddEndGraphTask, errorReason);

    (void)AddEndGraphTaskInit(rtAddEndGraphTask, mdl->Id_(), modelExecuteType,
        RtPtrToValue<const void *>(mdl->GetDevModelID()),
        RtPtrToValue<const void *>(mdl->GetDevString(RT_DEV_STRING_ENDGRAPH)),
        static_cast<uint8_t>(flags));

    error = device_->SubmitTask(rtAddEndGraphTask, taskGenCallback_);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit AddEndGraphTask, retCode=%#x", error);

    mdl->IncEndGraphNum();
    GET_THREAD_TASKID_AND_STREAMID(rtAddEndGraphTask, stm->Id_());
    return RT_ERROR_NONE;
ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtAddEndGraphTask);
    return error;
}

rtError_t Context::ModelExecutorSet(Model * const mdl, const uint8_t flags) const
{
    mdl->SetModelExecutorType(static_cast<uint32_t>(flags));
    return RT_ERROR_NONE;
}

rtError_t Context::ModelAbort(Model * const mdl) const
{
    rtError_t error;
    const uint32_t modelId = mdl->Id_();

    error = mdl->ModelAbort();
    ERROR_RETURN_MSG_INNER(error, "Model abort failed, model_id=%u, retCode=%#x.", modelId, error);

    return error;
}


rtError_t Context::ModelExit(Model * const mdl, Stream * const stm)
{
    rtError_t error;
    const uint32_t modelExitNum = mdl->ModelExitNum_();
    COND_RETURN_OUT_ERROR_MSG_CALL(modelExitNum >= 1U, RT_ERROR_MODEL_EXIT,
        "Model exit failed, current modelExitNum=%u, model must only exit one time.", modelExitNum);
    stm->SetLatestModlId(static_cast<int32_t>(mdl->Id_()));
    COND_RETURN_OUT_ERROR_MSG_CALL(stm->Model_() == nullptr, RT_ERROR_MODEL_EXIT_STREAM_UNBIND,
        "Model exit failed, stream not bind, modelExitNum=%u!", modelExitNum);
    COND_RETURN_OUT_ERROR_MSG_CALL(stm->Model_()->Id_() != mdl->Id_(), RT_ERROR_MODEL_EXIT_ID,
        "Model exit failed, stream is not belong the model, modelExitNum=%u!", modelExitNum);

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *rtAddModelExitTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_MODEL_EXIT_GRAPH, errorReason);
    NULL_PTR_RETURN_MSG(rtAddModelExitTask, errorReason);

    (void)AddModelExitTaskInit(rtAddModelExitTask, mdl->Id_());

    error = device_->SubmitTask(rtAddModelExitTask, taskGenCallback_);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit AddModelExitTask, retCode=%#x", error);

    mdl->IncModelExitNum();
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtAddModelExitTask);
    return error;
}


rtError_t Context::ModelBindQueue(Model * const mdl, const uint32_t queueId, const rtModelQueueFlag_t flag) const
{
    rtError_t error;

    error = mdl->BindQueue(queueId, flag);
    ERROR_RETURN_MSG_INNER(error, "Model bind queue failed, retCode=%#x", error);

    return error;
}

rtError_t Context::StreamSwitchEx(const void * const ptr, const rtCondition_t condition, const void * const valuePtr,
    const Stream * const trueStream, Stream * const stm, const rtSwitchDataType_t dataType)
{
    rtError_t error;
    const int32_t streamId = stm->Id_();
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *rtStreamSwitchTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_STREAM_SWITCH, errorReason);
    NULL_PTR_RETURN_MSG(rtStreamSwitchTask, errorReason);

    error = StreamSwitchTaskInitV2(rtStreamSwitchTask, ptr, condition, trueStream, valuePtr, dataType);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
        "Stream switch task init failed, stream_id=%d, task_id=%hu, retCode=%#x.",
        streamId, rtStreamSwitchTask->id, error);

    error = device_->SubmitTask(rtStreamSwitchTask, taskGenCallback_);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Stream switch task submit failed, retCode=%#x", error);

    GET_THREAD_TASKID_AND_STREAMID(rtStreamSwitchTask, streamId);

    return error;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtStreamSwitchTask);
    return error;
}


rtError_t Context::StreamSwitchN(const void * const ptr, const uint32_t size, const void * const valuePtr,
    Stream ** const trueStreamPtr, const uint32_t elementSize, Stream * const stm, const rtSwitchDataType_t dataType)
{
    NULL_PTR_RETURN_MSG_OUTER(trueStreamPtr, RT_ERROR_STREAM_NULL);

    rtError_t error;
    StreamSwitchNLoadResult result;
    ArgLoader * const devArgLdr = device_->ArgLoader_();
    const int32_t streamId = stm->Id_();

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *rtStreamSwitchNTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_STREAM_SWITCH_N, errorReason);
    NULL_PTR_RETURN_MSG(rtStreamSwitchNTask, errorReason);

    error = devArgLdr->LoadStreamSwitchNArgs(stm, valuePtr, size * elementSize, trueStreamPtr,
        elementSize, dataType, &result);

    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Stream switchN args load failed, retCode=%#x", error);

    error = StreamSwitchNTaskInit(rtStreamSwitchNTask, ptr, size, result.valuePtr, result.trueStreamPtr,
        elementSize, dataType);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
        "Stream switchN task init failed, stream_id=%d, task_id=%hu, retCode=%#x.",
        streamId, rtStreamSwitchNTask->id, error);

    error = device_->SubmitTask(rtStreamSwitchNTask, taskGenCallback_);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Stream switchN task submit failed, retCode=%#x", error);

    GET_THREAD_TASKID_AND_STREAMID(rtStreamSwitchNTask, streamId);

    return error;

    ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtStreamSwitchNTask);
    return error;
}

rtError_t Context::StreamActive(const Stream * const activeStream, Stream * const stm)
{
    rtError_t error;
    TaskInfo *tsk = nullptr;
    TaskInfo taskSubmit = {};
    rtError_t errorReason;
    const uint32_t activeStreamId = static_cast<uint32_t>(activeStream->Id_());
    const uint32_t activeStrFlag = activeStream->Flags();
    const uint32_t strFlag = stm->Flags();
    const int32_t streamId = stm->Id_();

    RT_LOG(RT_LOG_INFO, "active_stream flags=%u, active_stream_id=%u, stream flags=%u, stream_id=%d.",
        activeStrFlag, activeStreamId, strFlag, streamId);
    if ((((strFlag & RT_STREAM_AICPU) == 0U) && ((activeStrFlag & RT_STREAM_AICPU) != 0U)) ||
        ((strFlag & RT_STREAM_AICPU) != 0U)) {
        Model *mdl = stm->Model_();
        NULL_PTR_RETURN_MSG(mdl, RT_ERROR_MODEL_NULL);
        const void * const funcName = mdl->GetDevString(RT_DEV_STRING_ACTIVE_STREAM);
        void *args = nullptr;

        tsk = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_ACTIVE_AICPU_STREAM, errorReason);
        NULL_PTR_RETURN_MSG(tsk, errorReason);

        error = mdl->MallocDevValue(&activeStreamId, static_cast<uint32_t>(sizeof(int32_t)), &args);
        ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Active task malloc device value failed, retCode=%#x.", error);

        (void)ActiveAicpuStreamTaskInit(tsk, RtPtrToValue<void *>(args),
            static_cast<uint32_t>(sizeof(int32_t)), RtPtrToValue<const void *>(funcName), TS_AICPU_KERNEL_CCE);

        mdl->PushbackArgActiveStream(args);
    } else {
        tsk = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_STREAM_ACTIVE, errorReason);
        NULL_PTR_RETURN_MSG(tsk, errorReason);

        error = StreamActiveTaskInit(tsk, activeStream);
        ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Active task init failed, stream_id=%d, task_id=%hu, retCode=%#x",
            streamId, tsk->id, error);
    }

    error = device_->SubmitTask(tsk, taskGenCallback_);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
        "Active task submit ActiveAicpuStreamTask or StreamActiveTask failed, retCode=%#x.", error);

    GET_THREAD_TASKID_AND_STREAMID(tsk, streamId);
    return error;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(tsk);
    return error;
}

rtError_t Context::LabelCreate(Label ** const result, Model * const mdl)
{
    rtError_t error = RT_ERROR_NONE;
    Label *newLabel = new (std::nothrow) Label(mdl);
    COND_GOTO_ERROR_MSG_AND_ASSIGN_INNER(newLabel == nullptr, ERROR_RETURN, error, RT_ERROR_LABEL_NEW,
        "Label create failed, failed to alloc label.");

    error = newLabel->Setup(this);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Setup label failed, retCode=%#x.", error);

    *result = newLabel;
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    DELETE_O(newLabel);
ERROR_RETURN:
    *result = nullptr;
    return error;
}

rtError_t Context::LabelDestroy(const Label *delLabel) const
{
    DELETE_O(delLabel);
    return RT_ERROR_NONE;
}

rtError_t Context::ProfilerTrace(const uint64_t id, const bool notifyFlag, const uint32_t flags, Stream * const stm)
{
    rtError_t error;
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *rtProfTraceTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_PROFILER_TRACE, errorReason);
    NULL_PTR_RETURN_MSG(rtProfTraceTask, errorReason);

    error = ProfilerTraceTaskInit(rtProfTraceTask, id, notifyFlag, flags);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
        "task init failed, id=%" PRIu64 ", notifyFlag=%d, flags=%u, retCode=%#x.",
        id, static_cast<int32_t>(notifyFlag), flags, error);

    error = device_->SubmitTask(rtProfTraceTask, taskGenCallback_);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "task submit failed, retCode=%#x.", error);

    return error;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtProfTraceTask);
    return error;
}

rtError_t Context::ProfilerTraceEx(const uint64_t id, const uint64_t modelId, const uint16_t tagId, Stream *stm)
{
    RT_LOG(RT_LOG_INFO, "id=%" PRIu64 ", modelId=%" PRIu64 ", tagId=%hu, streamId=%d.",
        id, modelId, tagId, stm->Id_());

    // MAX_INT32_NUM means that stream is type of RT_STREAM_FORBIDDEN_DEFAULT
    if (stm->Id_() == MAX_INT32_NUM) {
        if (onlineStream_ != nullptr) {
            stm = onlineStream_;
            RT_LOG(RT_LOG_DEBUG, "use online stream for model execute, model_id=%" PRIu64, modelId);
        } else {
            stm = defaultStream_;
            NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
            RT_LOG(RT_LOG_DEBUG, "use default stream for model execute, model_id=%" PRIu64, modelId);
        }
    }

    rtError_t error;
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *rtProfTraceExTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_PROFILER_TRACE_EX, errorReason);
    NULL_PTR_RETURN_MSG(rtProfTraceExTask, errorReason);

    error = ProfilerTraceExTaskInit(rtProfTraceExTask, id, modelId, tagId);
    ERROR_GOTO(error, ERROR_RECYCLE,
        "task init failed, id=%" PRIu64 ", modelId=%" PRIu64 ", tagId=%hu, retCode=%#x.",
        id, modelId, tagId, error);

    error = device_->SubmitTask(rtProfTraceExTask, taskGenCallback_);
    ERROR_GOTO(error, ERROR_RECYCLE, "task submit failed, retCode=%#x.", error);
    GET_THREAD_TASKID_AND_STREAMID(rtProfTraceExTask, stm->Id_());
    return error;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtProfTraceExTask);
    return error;
}

rtError_t Context::CallbackLaunch(const rtCallback_t callBackFunc, void * const fnData, Stream * const stm,
    const bool isBlock, const int32_t evtId)
{
    const int32_t streamId = stm->Id_();
    rtError_t error;
    TaskInfo taskSubmit = {};
    rtError_t errorReason;
    TaskInfo* rtCbLaunchTask = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_HOSTFUNC_CALLBACK, errorReason);
    NULL_PTR_RETURN_MSG(rtCbLaunchTask, errorReason);

    (void)CallbackLaunchTaskInit(rtCbLaunchTask, callBackFunc, fnData, isBlock, evtId);

    error = device_->SubmitTask(rtCbLaunchTask, taskGenCallback_);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Callback launch task submit failed, retCode=%#x", error);

    GET_THREAD_TASKID_AND_STREAMID(rtCbLaunchTask, streamId);

    return error;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtCbLaunchTask);
    return error;
}

rtError_t Context::StartOnlineProf(Stream * const stm, const uint32_t sampleNum)
{
    rtError_t error;
    rtError_t freeErr;
    const void *deviceMem = nullptr;
    const int32_t streamId = stm->Id_();

    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((sampleNum == 0U) || (sampleNum > MAX_ONLINEPROF_NUM), RT_ERROR_INVALID_VALUE, 
        sampleNum, "(0, " + std::to_string(MAX_ONLINEPROF_NUM) + "]");
    if ((stm->Device_())->DevGetOnlineProfStart()) {
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR,  "StreamId=%d online profiling has already been set on the device.",
            streamId);
        return RT_ERROR_PROF_START;
    }

    (void)(stm->Device_())->DevSetOnlineProfStart(true);

    error = OnlineProf::OnlineProfMalloc(stm);
    ERROR_RETURN_MSG_INNER(error, "Malloc online profile memory failed, retCode=%#x.", error);

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *rtOlProfEnableTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_ONLINEPROF_START, errorReason);
    NULL_PTR_GOTO_MSG_INNER(rtOlProfEnableTask, ERROR_FREE, error, errorReason);

    deviceMem = stm->GetOnProfDeviceAddr();
    NULL_PTR_GOTO_MSG_INNER(deviceMem, ERROR_RECYCLE, error, RT_ERROR_PROF_DEVICE_MEM);

    error = OnlineProfEnableTaskInit(rtOlProfEnableTask, RtPtrToValue<const void *>(deviceMem));
    if (error != RT_ERROR_NONE) {
        goto ERROR_RECYCLE;
    }

    error = device_->SubmitTask(rtOlProfEnableTask);
    if (error != RT_ERROR_NONE) {
        goto ERROR_RECYCLE;
    }

    return RT_ERROR_NONE;
ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtOlProfEnableTask);
ERROR_FREE:
    freeErr = OnlineProf::OnlineProfFree(stm);
    ERROR_RETURN_MSG_INNER(freeErr, "Free online profile memory failed, retCode=%#x", freeErr);
    return error;
}

rtError_t Context::StopOnlineProf(Stream * const stm)
{
    const int32_t streamId = stm->Id_();
    rtError_t error;

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *rtOlProfDisableTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_ONLINEPROF_STOP, errorReason);
    NULL_PTR_GOTO_MSG_INNER(rtOlProfDisableTask, FREE_MEM, error, errorReason);

    error = OnlineProfDisableTaskInit(rtOlProfDisableTask, 0U);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
        "Failed to init OnlineProfDisableTask, stream_id=%d, task_id=%hu, retCode=%#x.",
        streamId, rtOlProfDisableTask->id, error);

    error = device_->SubmitTask(rtOlProfDisableTask);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit OnlineProfDisableTask, retCode=%#x", error);

    error = stm->Synchronize();
    ERROR_GOTO_MSG_INNER(error, FREE_MEM, "Failed to synchronize OnlineProfDisableTask, retCode=%#x", error);

    goto FREE_MEM;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtOlProfDisableTask);

FREE_MEM:
    (void)(stm->Device_())->DevSetOnlineProfStart(false);

    /* free memory */
    const rtError_t errorFree = OnlineProf::OnlineProfFree(stm);
    ERROR_RETURN_MSG_INNER(errorFree, "Free online profile memory failed, retCode=%#x.", errorFree);

    return error;
}

rtError_t Context::GetOnlineProfData(const Stream * const stm, rtProfDataInfo_t * const pProfData,
                                     const uint32_t profDataNum) const
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((profDataNum == 0U) || (profDataNum > MAX_ONLINEPROF_NUM), 
        RT_ERROR_INVALID_VALUE, profDataNum, "(0, " + std::to_string(MAX_ONLINEPROF_NUM) + "]");
    const rtError_t error = OnlineProf::GetOnlineProfilingData(stm, pProfData, profDataNum);
    ERROR_RETURN_MSG_INNER(error, "Get online profiling data failed, retCode=%#x.", error);

    return error;
}

rtError_t Context::AdcProfiler(Stream * const stm, const uint64_t addr, const uint32_t length)
{
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *rtMdcProfTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_ADCPROF, errorReason);
    NULL_PTR_RETURN_MSG(rtMdcProfTask, errorReason);

    rtError_t error = AdcProfTaskInit(rtMdcProfTask, addr, length);
    if (error != RT_ERROR_NONE) {
        goto ERROR_RECYCLE;
    }

    error = device_->SubmitTask(rtMdcProfTask);
    if (error != RT_ERROR_NONE) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "AdcProfiler failed, submit task failed, errCode=%#x.", error);
        goto ERROR_RECYCLE;
    }

    error = stm->Synchronize();
    return error;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtMdcProfTask);
    return error;
}

rtError_t Context::LabelSwitchByIndex(void * const ptr, const uint32_t maxIndex, void * const labelInfoPtr,
                                      Stream * const stm)
{
    const int32_t streamId = stm->Id_();
    TaskInfo taskSubmit = {};
    rtError_t errorReason;
    TaskInfo *rtStreamLabelSwitchIndexTask =
        stm->AllocTask(&taskSubmit, TS_TASK_TYPE_STREAM_LABEL_SWITCH_BY_INDEX, errorReason);
    NULL_PTR_RETURN_MSG(rtStreamLabelSwitchIndexTask, errorReason);

    rtError_t error = StreamLabelSwitchByIndexTaskInit(rtStreamLabelSwitchIndexTask, ptr, maxIndex, labelInfoPtr);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
        "Stream label switch by index task init failed, stream_id=%d, task_id=%hu, retCode=%#x.",
        streamId, rtStreamLabelSwitchIndexTask->id, error);

    error = device_->SubmitTask(rtStreamLabelSwitchIndexTask, taskGenCallback_);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
        "Stream label switch by index task submit failed, retCode=%#x", error);

    GET_THREAD_TASKID_AND_STREAMID(rtStreamLabelSwitchIndexTask, streamId);
    return error;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtStreamLabelSwitchIndexTask);
    return error;
}

rtError_t Context::LabelListCpy(Label ** const labelList, const uint32_t labelNumber, void * const dst,
    const uint32_t dstMax)
{
    UNUSED(dstMax);
    rtError_t error = RT_ERROR_NONE;
    rtLabelDevInfo tempLabelInfo;
    uint32_t labelStep;
    void *devAddr = dst;
    const Stream *labelStream = nullptr;
    Model *labelModel = nullptr;

    if (device_->IsStarsPlatform()) {
        labelStep = RT_CHIP_CLOUD_V2_LABEL_INFO_SIZE;
    } else if (Device_()->GetTschVersion() >= TS_VERSION_MORE_LABEL) {
        labelStep = sizeof(rtLabelDevInfo);
    } else {
        labelStep = sizeof(rtLabelDevInfoOld);
    }

    for (uint32_t idx = 0U; idx < labelNumber; idx++) {
        labelStream = labelList[idx]->Stream_();
        labelModel = labelStream->Model_();
        NULL_PTR_RETURN_MSG(labelModel, RT_ERROR_MODEL_NULL);
        tempLabelInfo.modelId = static_cast<uint16_t>(labelModel->Id_());
        tempLabelInfo.labelId = labelList[idx]->Id_();
        tempLabelInfo.streamId = static_cast<uint16_t>(labelStream->Id_());

        RT_LOG(RT_LOG_DEBUG, "copy label to device, label_id=%hu, model_id=%hu, stream_id=%hu, label_step=%u.",
               tempLabelInfo.labelId, tempLabelInfo.modelId, tempLabelInfo.streamId,
               labelStep);
        if ((Device_()->GetTschVersion() >= TS_VERSION_MORE_LABEL) || (device_->IsDavidPlatform())) {
            error = labelList[idx]->SetLabelDevAddr(devAddr);
            ERROR_RETURN_MSG_INNER(error,
                "Label list copy failed, have same labels in label list, label_id=%hu,"
                " model_id=%hu, label_step=%u, retCode=%#x",
                tempLabelInfo.labelId, tempLabelInfo.modelId, labelStep, error);
        } else {
            if (device_->Driver_()->GetRunMode() == RT_RUN_MODE_ONLINE) {
                error = device_->Driver_()->MemCopySync(devAddr, static_cast<uint64_t>(labelStep),
                    static_cast<void *>(&tempLabelInfo), static_cast<uint64_t>(labelStep), RT_MEMCPY_HOST_TO_DEVICE);
                ERROR_RETURN_MSG_INNER(error,
                    "Label list copy failed, mem copy stream label info failed, label_id=%hu,"
                    " model_id=%hu, label_step=%u, retCode=%#x",
                    tempLabelInfo.labelId, tempLabelInfo.modelId, labelStep, error);
                (void)device_->Driver_()->DevMemFlushCache(RtPtrToValue<void *>(devAddr),
                    static_cast<size_t>(labelStep));
            } else {
                error = device_->Driver_()->MemCopySync(devAddr, static_cast<uint64_t>(labelStep),
                    static_cast<void *>(&tempLabelInfo), static_cast<uint64_t>(labelStep), RT_MEMCPY_DEVICE_TO_DEVICE);
                ERROR_RETURN_MSG_INNER(error,
                    "Label list copy failed, mem copy stream label info failed, label_id=%u,"
                    " model_id=%u, label_step=%u, retCode=%#x",
                    tempLabelInfo.labelId, tempLabelInfo.modelId, labelStep, error);
            }
        }
        devAddr = RtPtrToPtr<void *,uintptr_t>(RtPtrToPtr<uintptr_t, void *>(devAddr) + labelStep);
    }

    return error;
}

rtError_t Context::LabelSwitchListCreate(Label ** const labels, const size_t num, void ** const labelList) const
{
    const uint64_t labelSize = sizeof(rtLabelDevInfo) * num;
    const rtMemType_t memType = Runtime::Instance()->GetTsMemType(MEM_REQUEST_FEATURE_DEFAULT, labelSize);
    void *devMem = nullptr;
    rtError_t error = device_->Driver_()->DevMemAlloc(&devMem, labelSize,
            memType, device_->Id_());
    ERROR_RETURN(error, "Failed to alloc device memory for label list, size=%" PRIu64
        " (bytes), memType=%u, deviceId=%u.",
        labelSize, memType, device_->Id_());
    error = device_->Driver_()->MemSetSync(devMem, labelSize, 0xFFU, labelSize); // Initialize to an invalid value
    ERROR_PROC_RETURN_MSG_INNER(error, (void)device_->Driver_()->DevMemFree(devMem, device_->Id_());,
        "set label dev addr failed, retCode=%#x, labels num=%zu, labelSize=%" PRIu64, error, num, labelSize);

    uint32_t labelStep;
    if (device_->IsStarsPlatform()) {
        labelStep = RT_CHIP_CLOUD_V2_LABEL_INFO_SIZE;
    } else {
        labelStep = sizeof(rtLabelDevInfo);
    }

    void *devAddr = devMem;
    for (size_t idx = 0U; idx < num; idx++) {
        error = labels[idx]->SetLabelDevAddr(devAddr);
        ERROR_PROC_RETURN_MSG_INNER(error,
            (void)device_->Driver_()->DevMemFree(devMem, device_->Id_());,
            "set label dev addr failed, retCode=%#x, labels num=%zu, index=%zu", error, num, idx);
        devAddr = RtPtrToPtr<void *, uintptr_t>(RtPtrToPtr<uintptr_t, void *>(devAddr) + labelStep);
    }

    *labelList = devMem;
    return RT_ERROR_NONE;
}

// for dvpp task, submit write value task
// don't update last taskId
rtError_t Context::StarsLaunchDvppRRProcess(Stream * const stm)
{
    rtError_t error = RT_ERROR_NONE;
    const int32_t streamId = stm->Id_();
    static uint8_t value[WRITE_VALUE_SIZE_MAX_LEN] = {};
    TaskInfo *writeValueTask;

    const uint64_t addr = RtPtrToValue<void *>(stm->GetDvppRRTaskAddr());
    COND_RETURN_ERROR((addr == 0ULL), RT_ERROR_MEMORY_ALLOCATION,
        "Dvpp task alloc mem failed, stream_id=%d.", streamId);
    for (uint32_t i = 0U; i < DVPP_RR_TASK_NUM; i++) {
        TaskInfo submitTask = {};
        rtError_t errorReason;

        writeValueTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_WRITE_VALUE, errorReason);
        NULL_PTR_RETURN_MSG(writeValueTask, errorReason);

        (void)WriteValueTaskInit(writeValueTask, addr, WRITE_VALUE_SIZE_32_BYTE, &(value[0U]), TASK_WR_CQE_NEVER);

        error = device_->SubmitTask(writeValueTask, taskGenCallback_);
        ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "dvpp task submit failed, stream_id=%d, i=%u", streamId, i);
    }

    return RT_ERROR_NONE;
ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(writeValueTask);
    return error;
}

rtError_t Context::StarsLaunch(const void * const sqe, const uint32_t sqeLen, Stream * const stm, const uint32_t flag)
{
    const int32_t streamId = stm->Id_();
    uint32_t taskId;

    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(sqeLen != sizeof(rtStarsCommonSqe_t), RT_ERROR_INVALID_VALUE, 
        sqeLen, sizeof(rtStarsCommonSqe_t));

    TaskInfo taskSubmit = {};
    rtError_t errorReason;
    TaskInfo *rtStarsCommonTask = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_STARS_COMMON, errorReason);
    NULL_PTR_RETURN_MSG(rtStarsCommonTask, errorReason);

    auto commonSqe = reinterpret_cast<rtStarsCommonSqe_t *>(const_cast<void *>(sqe));
    const uint16_t sqeType = commonSqe->sqeHeader.type;

    rtError_t error = StarsCommonTaskInit(rtStarsCommonTask, *commonSqe, flag);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
        "Stars common task init failed, stream_id=%d, task_id=%hu, retCode=%#x.",
        streamId, rtStarsCommonTask->id, error);

    error = device_->SubmitTask(rtStarsCommonTask, taskGenCallback_, &taskId);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
        "task submit failed, streamId=%d, taskId=%hu, sqeType=%hu, retCode=%#x",
        streamId, rtStarsCommonTask->id, sqeType, error);

    SET_THREAD_TASKID_AND_STREAMID(streamId, taskId);

    // reserved: this field is used only in the DVPP scenario.
    //           1: need to send three write-value tasks, 0: no need to send three write-value tasks.
    //           will be restored to 0 when construct sqe.
    if ((commonSqe->sqeHeader.reserved == 1U) && IsDvppTask(sqeType)) {
        error = StarsLaunchDvppRRProcess(stm);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "submit dvpp task failed, stream_id=%d, sqeType=%hu", streamId, sqeType);
        }
    }

    return RT_ERROR_NONE;
ERROR_RECYCLE:
    // When an error occurs, the dvpp releases the cmdlist memory.
    rtStarsCommonTask->u.starsCommTask.cmdList = {nullptr};
    (void)device_->GetTaskFactory()->Recycle(rtStarsCommonTask);
    return error;
}

rtError_t Context::LaunchDvppTask(const void * const sqe, const uint32_t sqeLen, Stream * const stm, rtDvppCfg_t *cfg)
{
    bool isCmdListNotFree = false;
    rtError_t error = GetIsCmdListNotFreeValByDvppCfg(cfg, isCmdListNotFree);
    ERROR_RETURN_MSG_INNER(error, "Failed to get dvpp cmdlist not free flag, streamId=%u, retCode=%#x",
        stm->Id_(), error);
    const uint32_t flag = isCmdListNotFree ? RT_KERNEL_CMDLIST_NOT_FREE : RT_KERNEL_DEFAULT;
    error = StarsLaunch(sqe, sqeLen, stm, flag);
    ERROR_RETURN_MSG_INNER(error, "Failed to launch dvpp task, streamId=%u, retCode=%#x", stm->Id_(), error);

    return RT_ERROR_NONE;
}

rtError_t Context::LaunchRandomNumTask(const rtRandomNumTaskInfo_t *taskInfo, Stream * const stm,
    const void *reserve) const
{
    UNUSED(reserve);
    rtError_t error = CheckRandomNumTaskInfo(taskInfo);
    ERROR_RETURN_MSG_INNER(error, "get dsa sqe by task info, retCode=%#x", error);

    const int32_t streamId = stm->Id_();
    uint32_t taskId;
    TaskInfo taskSubmit = {};
    rtError_t errorReason;
    TaskInfo *rtStarsCommonTask = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_STARS_COMMON, errorReason);
    NULL_PTR_RETURN_MSG(rtStarsCommonTask, errorReason);

    rtStarsDsaSqe_t sqe = {};
    error = GetDsaSqeByRandomNumTask(taskInfo, rtStarsCommonTask, sqe);
    ERROR_RETURN_MSG_INNER(error, "get dsa sqe by task info, retCode=%#x", error);

    error = StarsCommonTaskInit(rtStarsCommonTask, sqe, RT_KERNEL_DEFAULT);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
        "dsa task init failed, stream_id=%d, task_id=%hu, retCode=%#x.",
        streamId, rtStarsCommonTask->id, error);

    error = device_->SubmitTask(rtStarsCommonTask, taskGenCallback_, &taskId);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE,
        "dsa task submit failed, streamId=%d, taskId=%hu, retCode=%#x",
        streamId, rtStarsCommonTask->id, error);

    SET_THREAD_TASKID_AND_STREAMID(streamId, taskId);

    return RT_ERROR_NONE;
ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtStarsCommonTask);
    return error;
}

rtError_t Context::SetStreamSqLockUnlock(Stream * const stm, const bool isLock)
{
    TaskInfo taskSubmit = {};
    rtError_t errorReason;
    TaskInfo *rtSetSqLockUnlockTask = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_SET_SQ_LOCK_UNLOCK,
        errorReason);
    NULL_PTR_RETURN(rtSetSqLockUnlockTask, errorReason);

    rtError_t error = SqLockUnlockTaskInit(rtSetSqLockUnlockTask, isLock);
    const int32_t streamId = stm->Id_();
    ERROR_GOTO(error, ERROR_RECYCLE, "sq lock unlock failed,stream_id=%d,task_id=%hu,retCode=%#x.",
               streamId, rtSetSqLockUnlockTask->id, error);

    error = device_->SubmitTask(rtSetSqLockUnlockTask, taskGenCallback_);
    ERROR_GOTO(error, ERROR_RECYCLE, "sq lock/unlock task submit failed,retCode=%#x", error);

    GET_THREAD_TASKID_AND_STREAMID(rtSetSqLockUnlockTask, streamId);

    return error;
ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtSetSqLockUnlockTask);
    return error;
}

rtError_t Context::NopTask(Stream * const stm) const
{
    TaskInfo taskSubmit = {};
    rtError_t errorReason = RT_ERROR_NONE;
    TaskInfo *rtNopTask = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_NOP, errorReason);
    NULL_PTR_RETURN(rtNopTask, errorReason);

    rtError_t error = NopTaskInit(rtNopTask);
    const int32_t streamId = stm->Id_();
    ERROR_GOTO(error, ERROR_RECYCLE, "nop task init failed,stream_id=%d,task_id=%hu,retCode=%#x.",
               streamId, rtNopTask->id, error);

    error = device_->SubmitTask(rtNopTask, taskGenCallback_);
    ERROR_GOTO(error, ERROR_RECYCLE, "nop task submit failed,retCode=%#x", error);

    GET_THREAD_TASKID_AND_STREAMID(rtNopTask, stm->AllocTaskStreamId());

    return error;
ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtNopTask);
    return error;
}

rtError_t Context::CopyTilingTabToDev(Program * const programHdl, const Device * const device,
                                      void **devCopyMem, uint32_t *TilingTabLen)
{
    rtError_t ret;
    rtError_t error;
    Module *mdl = !programHdl->IsNewBinaryLoadFlow() ? GetModule(programHdl) : nullptr;
    uint32_t kernelLen;
    void *devMem = nullptr;
    uint32_t copyLen = 0U;
    Driver * const curDrv = device->Driver_();
    if (device->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_KERNEL_TILING_TAB_COPY_V2)) {
        /* 构建拷贝的内容 */
        TilingTablForDavid *tilingTab = nullptr;
        ret = programHdl->BuildTilingTblForDavid(mdl, &tilingTab, &kernelLen);
        if (ret != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "BuildTilingTbl fail");
            return ret;
        }
        copyLen = static_cast<uint32_t>(kernelLen * sizeof(TilingTablForDavid));
        /* 拷贝内容到device */
        error = curDrv->DevMemAlloc(&devMem, static_cast<uint64_t>(copyLen),
            RT_MEMORY_TS, device->Id_(), MODULEID_RUNTIME, true, false, false);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "DevMemAlloc fail copyLen=%u.", copyLen);
            if (devMem != nullptr) {
                (void)curDrv->DevMemFree(devMem, device->Id_());
            }
            programHdl->DestroyTilingTblForDavid(tilingTab);
            return error;
        }
        error = curDrv->MemCopySync(devMem, static_cast<uint64_t>(copyLen), tilingTab,
            static_cast<uint64_t>(copyLen), RT_MEMCPY_HOST_TO_DEVICE);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "MemCopySync failed.");
            if (devMem != nullptr) {
                (void)curDrv->DevMemFree(devMem, device->Id_());
            }
            programHdl->DestroyTilingTblForDavid(tilingTab);
            return error;
        }
        RT_LOG(RT_LOG_INFO, "Load on device devMem=%p,copyLen=%u,deviceId=%u,kernelLen=%u",
            devMem, copyLen, device->Id_(), kernelLen);
        programHdl->DestroyTilingTblForDavid(tilingTab);
    } else {
        /* 构建拷贝的内容 */
        TilingTabl *tilingTab = nullptr;
        const bool starsTillingFlag = (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_KERNEL_TILING_TABLE_PHY_CONTIGUOUS)) ? true : false;
        ret = programHdl->BuildTilingTbl(mdl, &tilingTab, &kernelLen);
        if (ret != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "BuildTilingTbl fail");
            return ret;
        }
        copyLen = static_cast<uint32_t>(kernelLen * sizeof(TilingTabl));
        /* 拷贝内容到device */
        error = curDrv->DevMemAlloc(&devMem, static_cast<uint64_t>(copyLen),
            RT_MEMORY_TS, device->Id_(), MODULEID_RUNTIME, true, false, starsTillingFlag);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "DevMemAlloc fail copyLen=%u.", copyLen);
            if (devMem != nullptr) {
                (void)curDrv->DevMemFree(devMem, device->Id_());
            }
            programHdl->DestroyTilingTbl(tilingTab);
            return error;
        }
        error = curDrv->MemCopySync(devMem, static_cast<uint64_t>(copyLen), tilingTab,
            static_cast<uint64_t>(copyLen), RT_MEMCPY_HOST_TO_DEVICE);
        if (error != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "MemCopySync failed.");
            if (devMem != nullptr) {
                (void)curDrv->DevMemFree(devMem, device->Id_());
            }
            programHdl->DestroyTilingTbl(tilingTab);
            return error;
        }
        RT_LOG(RT_LOG_INFO, "Load on device devMem=%p,copyLen=%u,deviceId=%u,kernelLen=%u",
            devMem, copyLen, device->Id_(), kernelLen);
        programHdl->DestroyTilingTbl(tilingTab);
    }
    *devCopyMem = devMem;
    *TilingTabLen = kernelLen;
    return RT_ERROR_NONE;
}

rtError_t Context::ModelTaskUpdate(const Stream * desStm, uint32_t desTaskId, Stream *sinkStm,
                                   rtMdlTaskUpdateInfo_t *para)
{
    void *devCopyMem = nullptr;
    uint32_t tilingTabLen = 0;
    rtError_t ret = CopyTilingTabToDev(static_cast<Program *>(para->hdl), sinkStm->Device_(),
        &devCopyMem, &tilingTabLen);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "BuildTilingTbl fail");
        return ret;
    }

    ret = sinkStm->ModelTaskUpdate(desStm, desTaskId, devCopyMem, tilingTabLen, para);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "sinkStm->ModelTaskUpdate fail");
        Driver * const curDrv = sinkStm->Device_()->Driver_();
        (void)curDrv->DevMemFree(devCopyMem, sinkStm->Device_()->Id_());
        return ret;
    }

    sinkStm->PushbackTilingTblAddr(devCopyMem);
    RT_LOG(RT_LOG_INFO, "Id=%u, devCopyMem=%p", sinkStm->Device_()->Id_(), devCopyMem);

    return RT_ERROR_NONE;
}

rtError_t Context::StreamClear(const Stream * const stm, rtClearStep_t step) const
{
    /* check target stream */
    const int32_t streamId = stm->Id_();

    COND_RETURN_ERROR_MSG_INNER((stm->GetBindFlag()), RT_ERROR_STREAM_INVALID,
        "Not support clear model stream");
    COND_RETURN_ERROR_MSG_INNER(((stm->Flags() & RT_STREAM_CP_PROCESS_USE) == 0U), RT_ERROR_FEATURE_NOT_SUPPORT,
        "Not support clear non-mc2 stream");
    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        return device_->GetCtrlSQ().SendStreamClearMsg(stm, step, taskGenCallback_);
    }
    Stream * const dftStm = DefaultStream_();
    NULL_PTR_RETURN_MSG(dftStm, RT_ERROR_STREAM_NULL);

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo* rtCommonCmdTask = dftStm->AllocTask(&submitTask, TS_TASK_TYPE_COMMON_CMD, errorReason);
    NULL_PTR_RETURN_MSG(rtCommonCmdTask, errorReason);

    CommonCmdTaskInfo cmdInfo;
    cmdInfo.streamId = static_cast<uint16_t>(streamId);
    cmdInfo.step = step;
    CommonCmdTaskInit(rtCommonCmdTask, CMD_STREAM_CLEAR, &cmdInfo);

    rtError_t error = device_->SubmitTask(rtCommonCmdTask, taskGenCallback_);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit StreamClear, retCode=%#x", error);

    error = dftStm->Synchronize();
    ERROR_RETURN_MSG_INNER(error, "Failed to synchronize StreamClear, streamId=%u, retCode=%#x", streamId, error);

    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtCommonCmdTask);
    return error;
}
bool Context::IsStreamAbortSupported()
{
    return device_->CheckFeatureSupport(TS_FEATURE_STREAM_ABORT);
}

rtError_t Context::StreamAbort(Stream * const stm)
{
    RT_LOG(RT_LOG_INFO, "Enter StreamAbort, stream_id=%d, sq_id=%u, cq_id=%u",
        stm->Id_(), stm->GetSqId(), stm->GetCqId());
    rtError_t ret = RT_ERROR_NONE;
    COND_RETURN_ERROR_MSG_INNER((stm->GetBindFlag()), RT_ERROR_STREAM_INVALID,
        "model stream abort is not supported");
    //runtime-ts compatibility check;
    const bool isSupported = IsStreamAbortSupported();
    COND_RETURN_WARN((isSupported == false), RT_ERROR_FEATURE_NOT_SUPPORT, "stream abort is not supported");

    if (device_->GetDeviceStatus() == RT_ERROR_DEVICE_TASK_ABORT) {
        RT_LOG(RT_LOG_INFO, "device is in device abort status, stream_id=%d, sq_id=%u, cq_id=%u",
            stm->Id_(), stm->GetSqId(), stm->GetCqId());
        return RT_ERROR_NONE;
    }

    // WARNING: this flag is used for breaking potential deadloop in StarsEngine::AddTaskToStream,
    // it must be set before setting abort status;
    stm->SetBeingAbortedFlag(true);
    // set stream abort status;
    // WARNING: streamLock_ must be locked after abort status is set,
    //          otherwise there could be mutual lock with Context::Synchronize;
    stm->SetAbortStatus(RT_ERROR_STREAM_ABORT);
    // wait others thread finish sendTask
    (void)mmSleep(10U);
    std::unique_lock<std::mutex> taskLock(streamLock_);

    //clean up buffer for the 2nd stage of the sq pipeline;
    ret = stm->CleanSq();
    ERROR_RETURN(ret, "CleanSq retCode=%#x.", ret);

    //send message to TS to abort sq;
    ret = stm->TaskKill(OP_ABORT_STREAM);
    ERROR_RETURN(ret, "TaskKill retCode=%#x.", ret);
    RT_LOG(RT_LOG_INFO,
        "After finish task kill, stream_id=%d, sq_id=%u, cq_id=%u",
        stm->Id_(),
        stm->GetSqId(),
        stm->GetCqId());

    uint32_t status = 0;
    mmTimespec startCnt = {};
    mmTimespec endCnt = {};
    uint64_t startTime;
    uint64_t endTime;
    // polling if TS has aborted sq successfully until timeout;
    startCnt = mmGetTickCount();
    startTime= static_cast<uint64_t>(startCnt.tv_sec) * RT_MS_PER_S +
               static_cast<uint64_t>(startCnt.tv_nsec) / RT_MS_TO_NS;
    while (true) {
        ret = stm->QuerySq(APP_ABORT_STS_QUERY_BY_SQ, status);
        ERROR_RETURN(ret, "QuerySq retCode=%#x.", ret);
        if (APP_ABORT_TERMINATE_FINISH == status) {
            break;
        }
        RT_LOG(RT_LOG_DEBUG, "QuerySq stream_id=%d, sq_id=%u, status=%u",  stm->Id_(), stm->GetSqId(), status);
        endCnt = mmGetTickCount();
        endTime =
            static_cast<uint64_t>(endCnt.tv_sec) * RT_MS_PER_S + static_cast<uint64_t>(endCnt.tv_nsec) / RT_MS_TO_NS;

        COND_RETURN_ERROR(((endTime - startTime) > STREAM_ABORT_TIMEOUT),
            RT_ERROR_WAIT_TIMEOUT, "Query timeout, stream_id=%d", stm->Id_());
        mmSleep(5U);
    }
    // recycle runtime task related resources;
    ret = stm->ResClear(STREAM_ABORT_TIMEOUT);
    ERROR_RETURN(ret, "ResClear retCode=%#x.", ret);

    // clean up sq and cq in driver;
    ret = stm->SqCqUpdate();
    ERROR_RETURN(ret, "SqCqUpdate retCode=%#x.", ret);
    RT_LOG(RT_LOG_INFO,
        "After sq cp update, stream_id=%d, sq_id=%u, cq_id=%u",
        stm->Id_(),
        stm->GetSqId(),
        stm->GetCqId());
    //restore stream  normal state;
    stm->SetAbortStatus(RT_ERROR_NONE);
    RT_LOG(RT_LOG_INFO,
        "Finish StreamAbort, stream_id=%d, sq_id=%u, cq_id=%u",
        stm->Id_(),
        stm->GetSqId(),
        stm->GetCqId());
    stm->SetBeingAbortedFlag(false);

    return RT_ERROR_NONE;
}

rtError_t Context::SendAndRecvDebugTask(RtDebugSendInfo *const sendInfo, rtDebugReportInfo_t *const reportInfo) const
{
    Driver * const devDrv = device_->Driver_();
    auto ret = devDrv->DebugSqTaskSend(device_->GetDebugSqId(), RtPtrToPtr<uint8_t *, RtDebugSendInfo *>(sendInfo), device_->Id_(),
                                       device_->DevGetTsId());
    ERROR_RETURN(ret, "DebugSqTaskSend fail, retCode=%#x.", ret);

    uint32_t realReportCnt = 0U;
    ret = devDrv->DebugCqReport(device_->Id_(), device_->DevGetTsId(), device_->GetDebugCqId(),
        RtPtrToPtr<uint8_t *, rtDebugReportInfo_t *>(reportInfo), realReportCnt);
    ERROR_RETURN(ret, "DebugCqReport fail, retCode=%#x.", ret);
    return RT_ERROR_NONE;
}

Stream *Context::GetCtrlSQStream() const
{
    if (!device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        return DefaultStream_();
    }

    CtrlSQ& ctrlSQ = device_->GetCtrlSQ();
    return ctrlSQ.GetStream();
}

rtError_t Context::CheckStatus(const Stream * const stm, const bool isBlockDefault)
{
    ProcessReportFastRingBuffer();
    // device status check
    (void)device_->GetDevRunningState();
    rtError_t status = RT_ERROR_NONE;
    status = device_->GetDevStatus();
    COND_PROC_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, status != RT_ERROR_NONE, status,
                                    RT_LOG_INNER_DETAIL_MSG(RT_DRV_INNER_ERROR, {"device_id"}, {std::to_string(device_->Id_())});,
                                    "Device[%u] fault, ret=%#x.", device_->Id_(), status);
    status = device_->GetDeviceStatus();
    COND_RETURN_ERROR(status != RT_ERROR_NONE, status, "device_id=%d status=%d is abnormal.",
                      device_->Id_(), status);
    Stream *ctrlStream = device_->GetCtrlStream(nullptr);
    if (!isBlockDefault && (stm != nullptr) &&
        ((stm == GetCtrlSQStream()) || (stm == device_->PrimaryStream_()) || stm == ctrlStream) &&
        (stm->GetFailureMode() != ABORT_ON_FAILURE)) {
        return RT_ERROR_NONE;
    }
    status = GetFailureError();
    if (status != RT_ERROR_NONE) {
        PopContextErrMsg();
    }
    if (ctxMode_ != STOP_ON_FAILURE) {
        return RT_ERROR_NONE;
    }
    return status;
}

rtError_t Context::CheckTaskSend(const TaskInfo * const workTask)
{
    ProcessReportFastRingBuffer();
    Stream *stm = workTask->stream;
    COND_RETURN_ERROR(stm == nullptr, RT_ERROR_INVALID_VALUE, "Stream must not be null");
    (void)device_->GetDevRunningState();
    rtError_t status = RT_ERROR_NONE;
    status = device_->GetDevStatus();
    COND_PROC_RETURN_ERROR_MSG_CALL(ERR_MODULE_DRV, status != RT_ERROR_NONE, status,
                                    RT_LOG_INNER_DETAIL_MSG(RT_DRV_INNER_ERROR, {"device_id"}, {std::to_string(device_->Id_())});,
                                    "Device[%u] fault, ret=%#x.", device_->Id_(), status);
    status = device_->GetDeviceStatus();
    ERROR_RETURN(status, "device_id=%d status=%#x is abnormal, stream_id=%d", device_->Id_(), status, stm->Id_());
    // 任务下发场景
    const bool isDefaultStreamSend = (stm->GetFailureMode() != ABORT_ON_FAILURE) && (stm == GetCtrlSQStream()) &&
                               (workTask->type == TS_TASK_TYPE_MODEL_MAINTAINCE ||
                                workTask->type == TS_TASK_TYPE_EVENT_RECORD ||
                                workTask->type == TS_TASK_TYPE_DEVICE_RINGBUFFER_CONTROL);
    if (isDefaultStreamSend || workTask->type == TS_TASK_TYPE_MAINTENANCE) {
        return RT_ERROR_NONE;
    }
    status = GetFailureError();
    if (status != RT_ERROR_NONE) {
        PopContextErrMsg();
    }
    if (ctxMode_ != STOP_ON_FAILURE) {
        return RT_ERROR_NONE;
    }
    return status;
}

rtError_t Context::SetMemcpyDesc(rtMemcpyDesc_t desc, const void * const srcAddr, const void * const dstAddr,
    const size_t count)
{
    rtMemcpyAddrInfo memcpyData;
    memset_s(&memcpyData, sizeof(rtMemcpyAddrInfo), 0, sizeof(rtMemcpyAddrInfo));
    memcpyData.len = static_cast<uint32_t>(count);
    memcpyData.src = RtPtrToValue<const void *>(srcAddr);
    memcpyData.dst = RtPtrToValue<const void *>(dstAddr);

    constexpr uint64_t dstMax = MEMCPY_DESC_SIZE;
    rtError_t error = RT_ERROR_NONE;
    if (device_->Driver_() ->GetRunMode() == RT_RUN_MODE_ONLINE) {
        error = device_->Driver_()->MemCopySync(desc, dstMax, &memcpyData,
            sizeof(rtMemcpyAddrInfo), RT_MEMCPY_HOST_TO_DEVICE);
        ERROR_RETURN(error, "Failed to memory copy stream info, device_id=%u, retCode=%#x.", device_->Id_(), error);

        error = device_->Driver_()->DevMemFlushCache(reinterpret_cast<uintptr_t>(desc), static_cast<size_t>(dstMax));
        ERROR_RETURN(error, "Failed to flush stream info, device_id=%u, retCode=%#x", device_->Id_(), error);
    } else {
        error = device_->Driver_()->MemCopySync(desc, dstMax, &memcpyData,
            sizeof(rtMemcpyAddrInfo), RT_MEMCPY_HOST_TO_DEVICE);
        ERROR_RETURN(error, "Failed to memory copy stream info, device_id=%u, retCode=%#x", device_->Id_(), error);
    }

    RT_LOG(RT_LOG_INFO, "Set memcpyDesc info success, srcAddr=%p, dstAddr=%p, count=%llu", srcAddr, dstAddr, count);
    return RT_ERROR_NONE;
}

rtError_t Context::GetStackBuffer(const rtBinHandle binHandle, const uint32_t coreType, const uint32_t coreId,
                                  const void **stack, uint32_t *stackSize) const
{
    const auto ret = CheckCoreParam(coreType, coreId);
    ERROR_RETURN(ret, "CheckCoreParam fail, coreType=%u, coreId=%u.", coreType, coreId);
    RT_LOG(RT_LOG_INFO, "Start to get stack buffer, bin handle %p, coreType %u, coreId %u",
           binHandle, coreType, coreId);

    Program * const programHdl = static_cast<Program *>(binHandle);
    *stackSize = programHdl->GetStackSize();
    const void *stackPhyBase =
        (*stackSize == KERNEL_STACK_SIZE_32K) ? device_->GetStackPhyBase32k() : device_->GetStackPhyBase16k();
    const uint32_t maxMinStackSize = programHdl->GetMaxMinStackSize();
    const uint32_t deviceCustomerStackSize = Runtime::Instance()->GetDeviceCustomerStackSize();
    if ((deviceCustomerStackSize != 0U) && (maxMinStackSize > 0)) {
        // -o0的情况下不考虑16KB的栈，因为编译器-o0的情况下能识别最小为32KB的栈
        if (maxMinStackSize > KERNEL_STACK_SIZE_32K) {
            *stackSize = deviceCustomerStackSize;
            stackPhyBase = device_->GetCustomerStackPhyBase();
        } else {
            *stackSize = KERNEL_STACK_SIZE_32K;
            stackPhyBase = device_->GetStackPhyBase32k();
        }
    }
    const uint32_t aicNum = device_->GetDevProperties().aicNumForCoreStack;
    if (coreType == 0U) {
        *stack = ValueToPtr(PtrToValue(stackPhyBase) + (*stackSize) * coreId);
    } else {
        *stack = ValueToPtr(PtrToValue(stackPhyBase) + (*stackSize) * (aicNum + coreId));
    }
    RT_LOG(RT_LOG_INFO, "Get stack addr %p, stackSize %u", *stack, *stackSize);
    return RT_ERROR_NONE;
}

rtError_t Context::DebugSetDumpMode(const uint64_t mode)
{
    COND_RETURN_ERROR(!device_->CheckFeatureSupport(TS_FEATURE_COREDUMP), RT_ERROR_DRV_NOT_SUPPORT,
                      "Current device does not support core dump!");
    Driver * const devDrv = device_->Driver_();
    COND_RETURN_ERROR((devDrv == nullptr), RT_ERROR_DRV_NULL, "devDrv is null!");
    RT_LOG(RT_LOG_INFO, "Start to create debug dump sqcq.");
    uint32_t debugSqId = 0U;
    uint32_t debugCqId = 0U;
    auto ret = devDrv->DebugSqCqAllocate(device_->Id_(), device_->DevGetTsId(), debugSqId, debugCqId);
    ERROR_RETURN(ret, "DebugSqCqAllocate fail, retCode=%#x.", ret);
    RT_LOG(RT_LOG_INFO, "Create debug dump sqcq success, sq_id is %u, cq_id is %u.", debugSqId, debugCqId);
    device_->SetDebugSqId(debugSqId);
    device_->SetDebugCqId(debugCqId);

    RtDebugSendInfo sendInfo = {};
    sendInfo.reqId = SET_DEBUG_MODE;
    sendInfo.isReturn = true;
    sendInfo.dataLen = static_cast<uint32_t>(sizeof(int64_t));
    uint64_t *param = RtPtrToPtr<uint64_t *, uint8_t *>(sendInfo.params);
    *param = mode;

    rtDebugReportInfo_t reportInfo = {};
    ret = SendAndRecvDebugTask(&sendInfo, &reportInfo);
    ERROR_RETURN(ret, "SendAndRecvDebugTask fail, retCode=%#x.", ret);
    COND_RETURN_ERROR((reportInfo.returnVal != 0U), RT_ERROR_INVALID_VALUE,
                      "SendAndRecvDebugTask get report val %u invalid!.", reportInfo.returnVal);
    device_->SetCoredumpEnable();
    RT_LOG(RT_LOG_INFO, "Set dump mode success.");
    return RT_ERROR_NONE;
}

rtError_t Context::DebugGetStalledCore(rtDbgCoreInfo_t *const coreInfo)
{
    NULL_PTR_RETURN_MSG(coreInfo, RT_ERROR_INVALID_VALUE);
    COND_RETURN_ERROR((!device_->IsCoredumpEnable()), RT_ERROR_INVALID_VALUE, "Coredump mode is disable!");
    RT_LOG(RT_LOG_INFO, "Start to get core info.");
    RtDebugSendInfo sendInfo = {};
    sendInfo.reqId = GET_STALLED_AICINFO_BY_PID;
    sendInfo.isReturn = true;

    rtDebugReportInfo_t reportInfo = {};
    const auto ret = SendAndRecvDebugTask(&sendInfo, &reportInfo);
    ERROR_RETURN(ret, "SendAndRecvDebugTask fail, retCode=%#x.", ret);
    COND_RETURN_ERROR((reportInfo.returnVal != 0U), RT_ERROR_INVALID_VALUE,
                      "Get core info get report val %u invalid!.", reportInfo.returnVal);
    rtDbgCoreInfo_t *tmp =  RtPtrToPtr<rtDbgCoreInfo_t *, uint8_t *>(reportInfo.data);
    *coreInfo = *tmp;
    RT_LOG(RT_LOG_INFO, "Get core info, bitmap info is 0x%llx 0x%llx 0x%llx 0x%llx",
           coreInfo->aicBitmap0, coreInfo->aicBitmap1, coreInfo->aivBitmap0, coreInfo->aivBitmap1);
    return RT_ERROR_NONE;
}

rtError_t Context::DebugReadAICore(rtDebugMemoryParam_t *const param)
{
    COND_RETURN_ERROR((!device_->IsCoredumpEnable()), RT_ERROR_INVALID_VALUE, "Coredump mode is disable!");
    auto ret = CheckMemoryParam(param);
    ERROR_RETURN(ret, "CheckMemoryParam fail.");
    RT_LOG(RT_LOG_INFO, "Start to DebugReadAICore, coreType=%u, coreId=%u, debugMemType=%u, elementSize=%u, "
           "memLen=%llu, srcAddr=0x%llx, dstAddr=0x%llx.", param->coreType, param->coreId, param->debugMemType,
           param->elementSize, param->memLen, param->srcAddr, param->dstAddr);

    Driver * const devDrv = device_->Driver_();
    const uint32_t deviceId = device_->Id_();
    void *devMem = nullptr;
    uint64_t physicPtr = 0U;
    ret = devDrv->DevMemAlloc(&devMem, DEBUG_DEVMEM_LEN, RT_MEMORY_HBM, deviceId);
    ERROR_RETURN(ret, "malloc mem fail, ret=%u", ret);
    ScopeGuard guard([&devMem, &devDrv, &deviceId]() { (void)devDrv->DevMemFree(devMem, deviceId); });
    ret = devDrv->MemAddressTranslate(static_cast<int32_t>(deviceId), PtrToValue(devMem), &physicPtr);
    ERROR_RETURN(ret, "MemAddress translate failed, ret=%u, ptr=%p", ret, devMem);
    RT_LOG(RT_LOG_INFO, "Malloc tmp buffer, vptr=%p, pptr=0x%llx.", devMem, physicPtr);

    uint64_t remainSize = param->memLen;
    uint64_t offset = 0U;
    while (remainSize > 0U) {
        RtDebugSendInfo sendInfo = {};
        sendInfo.reqId = (param->debugMemType == RT_MEM_TYPE_REGISTER) ?
            READ_REGISTER_BY_CURPROCESS : READ_LOCAL_MEMORY_BY_CURPROCESS;
        sendInfo.isReturn = true;
        sendInfo.dataLen = static_cast<uint32_t>(sizeof(rtStarsLocalMemoryParam_t));
        rtStarsLocalMemoryParam_t *memoryParam = RtPtrToPtr<rtStarsLocalMemoryParam_t *, uint8_t *>(sendInfo.params);
        memoryParam->coreType = param->coreType;
        memoryParam->coreId = param->coreId;
        memoryParam->debugMemType = param->debugMemType; // 读取local mem时，rts枚举取值当前与ts侧的定义一致
        memoryParam->elementSize = param->elementSize;
        memoryParam->srcAddr = param->srcAddr + offset;
        memoryParam->dstAddr = physicPtr;
        if (remainSize > DEBUG_DEVMEM_LEN) {
            memoryParam->memLen = DEBUG_DEVMEM_LEN;
            remainSize -= DEBUG_DEVMEM_LEN;
        } else {
            memoryParam->memLen = remainSize;
            remainSize = 0U;
        }

        ret = devDrv->MemSetSync(devMem, DEBUG_DEVMEM_LEN, 0U, DEBUG_DEVMEM_LEN);
        ERROR_RETURN(ret, "memset fail, ret=%u, addr=%p", ret, devMem);
        rtDebugReportInfo_t reportInfo = {};
        ret = SendAndRecvDebugTask(&sendInfo, &reportInfo);
        COND_RETURN_ERROR(((ret != RT_ERROR_NONE) || (reportInfo.returnVal != 0U)), RT_ERROR_INVALID_VALUE,
            "DebugReadAICore failed, retCode=%#x, reportVal=%u, coreType=%u, coreId=%u, debugMemType=%u, "
            "elementSize=%u, memLen=%llu, srcAddr=0x%llx, dstAddr=0x%llx.", ret, reportInfo.returnVal, param->coreType,
            param->coreId, param->debugMemType, memoryParam->elementSize, memoryParam->memLen, memoryParam->srcAddr,
            memoryParam->dstAddr);

        ret = devDrv->MemCopySync(ValueToPtr(param->dstAddr + offset), memoryParam->memLen, devMem,
                                  memoryParam->memLen, RT_MEMCPY_DEVICE_TO_HOST);
        ERROR_RETURN(ret, "mem copy failed, retCode=%#x, dstAddr=0x%llx, srcAddr=%p, memLen=%llu.",
            ret, param->dstAddr + offset, devMem, memoryParam->memLen);

        offset += memoryParam->memLen;
    }
    RT_LOG(RT_LOG_INFO, "ReadAICore success");
    return RT_ERROR_NONE;
}

rtError_t Context::GetExceptionRegInfo(const rtExceptionInfo_t * const exceptionInfo,
    rtExceptionErrRegInfo_t **exceptionErrRegInfo, uint32_t *num) const
{
    uint32_t realDeviceId;
    rtError_t error = Runtime::Instance()->ChgUserDevIdToDeviceId(exceptionInfo->deviceid, &realDeviceId);
    COND_RETURN_ERROR(error != RT_ERROR_NONE, error, "change user deviceId[%u] failed", exceptionInfo->deviceid);
    Device *dev = Runtime::Instance()->GetDevice(realDeviceId, 0, false);
    NULL_PTR_RETURN(dev, RT_ERROR_DEVICE_NULL);
    auto& exceptionRegMap = dev->GetExceptionRegMap();
    const uint32_t taskId = exceptionInfo->taskid;
    const uint32_t streamId = exceptionInfo->streamid;
    std::pair<uint32_t, uint32_t> key = {streamId, taskId};

    std::lock_guard<std::mutex> lock(dev->GetExceptionRegMutex());
    auto it = exceptionRegMap.find(key);
    if (it != exceptionRegMap.end() && !it->second.empty()) {
        RT_LOG(RT_LOG_INFO, "find register info in map for <stream_id=%u, task_id=%u>", streamId, taskId);
        *num = static_cast<uint32_t>(it->second.size());
        *exceptionErrRegInfo = &(it->second[0]);
    } else {
        *num = 0U;
        *exceptionErrRegInfo = nullptr;
    }

    return RT_ERROR_NONE;
}

rtError_t Context::CmoTaskLaunch(const rtCmoTaskInfo_t * const taskInfo, Stream * const stm, const uint32_t flag)
{
    const int32_t streamId = stm->Id_();

    TaskInfo taskSubmit = {};
    rtError_t errorReason;
    TaskInfo *rtCmoTask = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_CMO, errorReason);
    NULL_PTR_RETURN(rtCmoTask, errorReason);

    rtError_t error = CmoTaskInit(rtCmoTask, taskInfo, stm, flag);
    ERROR_GOTO(error, ERROR_RECYCLE, "CMO task init failed, stream_id=%d, task_id=%hu, retCode=%#x.",
        streamId, rtCmoTask->id, error);

    error = device_->SubmitTask(rtCmoTask, taskGenCallback_);
    ERROR_GOTO(error, ERROR_RECYCLE, "CMO task submit failed, retCode=%#x", error);

    GET_THREAD_TASKID_AND_STREAMID(rtCmoTask, streamId);
    return error;
ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtCmoTask);
    return error;
}

static void InitStarsSdmaCmoSqe(rtStarsSdmaSqe_t *sdmaCmoSqe, const Stream * const stm, const rtCmoOpCode_t cmoOpCode)
{
    sdmaCmoSqe->opcode = static_cast<uint8_t>(cmoOpCode);
    // only CHIP_910_B_93 sdma task for preLoad qos: 6; partid: 63
    sdmaCmoSqe->qos = 6U;
    sdmaCmoSqe->partid = 63U;
    sdmaCmoSqe->sssv = 1U;
    sdmaCmoSqe->dssv = 1U;
    sdmaCmoSqe->sns  = 1U;
    sdmaCmoSqe->dns  = 1U;
    sdmaCmoSqe->srcStreamId = static_cast<uint16_t>(RT_SMMU_STREAM_ID_1FU);
    sdmaCmoSqe->dst_streamid = static_cast<uint16_t>(RT_SMMU_STREAM_ID_1FU);
    sdmaCmoSqe->src_sub_streamid = static_cast<uint16_t>(stm->Device_()->GetSSID_());
    sdmaCmoSqe->dstSubStreamId = static_cast<uint16_t>(stm->Device_()->GetSSID_());
}

rtError_t Context::CmoAddrTaskLaunch(rtCmoAddrInfo * const cmoAddrInfo, const uint64_t destMax,
    const rtCmoOpCode_t cmoOpCode, Stream * const stm, const uint32_t flag)
{
    UNUSED(destMax);
    UNUSED(flag);
    rtError_t error;
    const int32_t streamId = stm->Id_();
    if (stm->Model_() == nullptr) {
        RT_LOG(RT_LOG_ERROR, "CMO Addr task stream is not in model. device_id=%d, stream_id=%d.",
            static_cast<int32_t>(stm->Device_()->Id_()), streamId);
        return RT_ERROR_MODEL_NULL;
    }
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *cmoAddrTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_CMO, errorReason);
    NULL_PTR_RETURN_MSG(cmoAddrTask, errorReason);

    rtStarsSdmaSqe_t sdmaCmoSqe = {};
    // fill in head args
    InitStarsSdmaCmoSqe(&sdmaCmoSqe, stm, cmoOpCode);
    RT_LOG(RT_LOG_DEBUG, "cmoAddrInfo=0x%llx, cmoOpCode=%d, device_id=%u, stream_id=%d",
        RtPtrToValue<rtCmoAddrInfo *>(cmoAddrInfo), cmoOpCode, device_->Id_(), streamId);

    Driver * const devDrv = device_->Driver_();
    if (devDrv != nullptr) {
        // only copy head args 8 Bytes for rtCmoAddrInfo resv0 & resv1
        constexpr uint64_t dstMax = 8ULL;
        error = devDrv->MemCopySync(cmoAddrInfo, dstMax, &sdmaCmoSqe, dstMax, RT_MEMCPY_HOST_TO_DEVICE);
        ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to memory copy stream info, device_id=%u, size=%" PRIu64
            "(bytes),retCode=%#x.", device_->Id_(), dstMax, error);

        if (devDrv->GetRunMode() == RT_RUN_MODE_ONLINE) {
            error = device_->Driver_()->DevMemFlushCache(RtPtrToValue<rtCmoAddrInfo *>(cmoAddrInfo), dstMax);
            ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to flush stream info, device_id=%u, "
                "retCode=%#x", device_->Id_(), error);
        }
    }

    // init cmoAddrTask
    (void)CmoAddrTaskInit(cmoAddrTask, cmoAddrInfo, cmoOpCode);

    error = device_->SubmitTask(cmoAddrTask, taskGenCallback_);
    ERROR_GOTO(error, ERROR_RECYCLE, "CMO task submit failed, retCode=%#x", error);

    GET_THREAD_TASKID_AND_STREAMID(cmoAddrTask, streamId);
    return error;
ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(cmoAddrTask);
    return error;
}

rtError_t Context::NpuGetFloatStatus(void * const outputAddrPtr, const uint64_t outputSize,
    const uint32_t checkMode, Stream * const stm, bool isDebug)
{
    const int32_t streamId = stm->Id_();
    RT_LOG(RT_LOG_INFO, "Begin to create NpuGetFloatStatus task.");

    TaskInfo submitTask = {};
    rtError_t error = RT_ERROR_NONE;
    rtError_t errorReason;

    TaskInfo *rtNpuGetFloatStatusTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_NPU_GET_FLOAT_STATUS,
        errorReason);
    NULL_PTR_RETURN(rtNpuGetFloatStatusTask, errorReason);

    (void)NpuGetFloatStaTaskInit(rtNpuGetFloatStatusTask, outputAddrPtr, outputSize, checkMode, isDebug);

    error = device_->SubmitTask(rtNpuGetFloatStatusTask, taskGenCallback_);
    ERROR_GOTO(error, ERROR_RECYCLE, "NpuGetFloatStatus task submit failed, retCode=%#x", error);

    GET_THREAD_TASKID_AND_STREAMID(rtNpuGetFloatStatusTask, streamId);
    return error;
ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtNpuGetFloatStatusTask);
    return error;
}

rtError_t Context::NpuClearFloatStatus(const uint32_t checkMode, Stream * const stm, bool isDebug)
{
    const int32_t streamId = stm->Id_();
    RT_LOG(RT_LOG_INFO, "Begin to create NpuClearFloatStatus task.");

    TaskInfo submitTask = {};
    rtError_t error = RT_ERROR_NONE;
    rtError_t errorReason;

    TaskInfo *rtNpuClearFloatStatusTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_NPU_CLEAR_FLOAT_STATUS,
        errorReason);
    NULL_PTR_RETURN(rtNpuClearFloatStatusTask, errorReason);

    (void)NpuClrFloatStaTaskInit(rtNpuClearFloatStatusTask, checkMode, isDebug);

    RT_LOG(RT_LOG_INFO, "Begin to submit NpuClearFloatStatus task.");
    error = device_->SubmitTask(rtNpuClearFloatStatusTask, taskGenCallback_);
    ERROR_GOTO(error, ERROR_RECYCLE, "NpuClearFloatStatus task submit failed, retCode=%#x", error);

    RT_LOG(RT_LOG_INFO, "success to submit NpuClearFloatStatus task.");

    GET_THREAD_TASKID_AND_STREAMID(rtNpuClearFloatStatusTask, streamId);
    return error;
ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtNpuClearFloatStatusTask);
    return error;
}

rtError_t Context::SetStreamOverflowSwitch(Stream * const stm, const uint32_t flags)
{
    rtError_t error = RT_ERROR_NONE;
    TaskInfo *tsk = nullptr;
    
    NULL_PTR_RETURN_MSG(DefaultStream_(), RT_ERROR_STREAM_NULL);
    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        uint32_t flipTaskId = 0;
        RtOverflowSwitchSetParam param = {stm, flags};
        error = device_->GetCtrlSQ().SendOverflowSwitchSetMsg(RtCtrlMsgType::RT_CTRL_MSG_SET_OVERFLOW_SWITCH, param, taskGenCallback_, &flipTaskId);
        ERROR_RETURN_MSG_INNER(error, "Failed to SendOverflowSwitchSetMsg, retCode=%#x.", error);
        SET_THREAD_TASKID_AND_STREAMID(DefaultStream_()->Id_(), flipTaskId);
    } else {
        TaskInfo submitTask = {};
        rtError_t errorReason = RT_ERROR_TASK_NEW;
        tsk = DefaultStream_()->AllocTask(&submitTask, TS_TASK_TYPE_SET_OVERFLOW_SWITCH, errorReason);
        NULL_PTR_RETURN(tsk, errorReason);

        (void)OverflowSwitchSetTaskInit(tsk, stm, flags);
        error = device_->SubmitTask(tsk, taskGenCallback_);
        ERROR_GOTO(error, ERROR_RECYCLE, "OverflowSwitchSetTask task submit failed, retCode=%#x", error);
        GET_THREAD_TASKID_AND_STREAMID(tsk, DefaultStream_()->Id_());
    }

    stm->SetOverflowSwitch(flags != 0U);
    RT_LOG(RT_LOG_INFO, "success to submit OverflowSwitchSetTask task.");
    return error;
ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(tsk);
    return error;
}

rtError_t Context::SetStreamTag(Stream * const stm, const uint32_t geOpTag) const
{
    TaskInfo submitTask = {};
    rtError_t errorReason;
    rtError_t error = RT_ERROR_NONE;
    NULL_PTR_RETURN_MSG(DefaultStream_(), RT_ERROR_STREAM_NULL);

    TaskInfo *tsk = DefaultStream_()->AllocTask(&submitTask, TS_TASK_TYPE_SET_STREAM_GE_OP_TAG, errorReason);
    NULL_PTR_RETURN(tsk, errorReason);

    (void)StreamTagSetTaskInit(tsk, stm, geOpTag);
    error = device_->SubmitTask(tsk, taskGenCallback_);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "StreamTagSetTask task submit failed, retCode=%#x",
                         static_cast<uint32_t>(error));

    stm->SetStreamTag(geOpTag);

    GET_THREAD_TASKID_AND_STREAMID(tsk, DefaultStream_()->Id_());
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(tsk);
    return error;
}

rtError_t Context::BarrierTaskLaunch(const rtBarrierTaskInfo_t * const taskInfo, Stream * const stm,
    const uint32_t flag)
{
    const int32_t streamId = stm->Id_();

    TaskInfo taskSubmit = {};
    rtError_t errorReason;
    TaskInfo *rtBarrierTask = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_BARRIER, errorReason);
    NULL_PTR_RETURN(rtBarrierTask, errorReason);

    rtError_t error = BarrierTaskInit(rtBarrierTask, taskInfo, stm, flag);
    ERROR_GOTO(error, ERROR_RECYCLE, "Barrier task init failed, stream_id=%d, task_id=%hu, retCode=%#x.",
        streamId, rtBarrierTask->id, error);

    error = device_->SubmitTask(rtBarrierTask, taskGenCallback_);
    ERROR_GOTO(error, ERROR_RECYCLE, "Barrier task submit failed, retCode=%#x", error);
    GET_THREAD_TASKID_AND_STREAMID(rtBarrierTask, streamId);
    return error;
ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtBarrierTask);
    return error;
}

rtError_t Context::DvppGroupCreate(DvppGrp **grp, const uint32_t flags)
{
    DvppGrp *newGrp = new (std::nothrow) DvppGrp(device_, flags);
    if (newGrp == nullptr) {
        RT_LOG(RT_LOG_ERROR, "failed to alloc DvppGrp");
        return RT_ERROR_DVPP_GRP_NEW;
    }

    newGrp->SetContext(this);
    rtError_t error = newGrp->Setup();
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "failed to setup DvppGrp, retCode=%#x", error);
        DELETE_O(newGrp);
        return error;
    }

    *grp = newGrp;
    return RT_ERROR_NONE;
}

rtError_t Context::DvppGroupDestory(DvppGrp *grp)
{
    delete grp;
    return RT_ERROR_NONE;
}

rtError_t Context::DvppWaitGroupReport(DvppGrp * const grp, const rtDvppGrpCallback callBackFunc, const int32_t timeout)
{
    return device_->DvppWaitGroup(grp, callBackFunc, timeout);
}

rtError_t Context::CtxSetSysParamOpt(const rtSysParamOpt configOpt, const int64_t configVal)
{
    const std::unique_lock<std::mutex> mutexLock(sysParamOptLock_);
    sysParamOpt_[configOpt].first = true;
    sysParamOpt_[configOpt].second = configVal;
    return RT_ERROR_NONE;
}

rtError_t Context::CtxGetSysParamOpt(const rtSysParamOpt configOpt, int64_t * const configVal)
{
    const std::unique_lock<std::mutex> mutexLock(sysParamOptLock_);
    if (!sysParamOpt_[configOpt].first) {
        RT_LOG(RT_LOG_WARNING, "SYS Config Opt(%u) did not set", configOpt);
        return RT_ERROR_NOT_SET_SYSPARAMOPT;
    }
    *configVal = sysParamOpt_[configOpt].second;
    return RT_ERROR_NONE;
}

rtError_t Context::GetSatStatusForStars(const uint64_t outputSize, Stream * const curStm)
{
    rtError_t error = RT_ERROR_NONE;
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
    *(RtPtrToPtr<uint64_t *, void *>(hostPtr)) = RtPtrToValue(CtxGetOverflowAddr());
    if (curStm->GetMemContainOverflowAddr() == nullptr) {
        void *memAddr = nullptr;
        Device* dev = Device_();
        error = dev->Driver_()->DevMemAlloc(&memAddr, sizeof(uint64_t), RT_MEMORY_DEFAULT, dev->Id_());
        ERROR_RETURN(error, "memAddr DevMemAlloc failed, retCode=%#x.", static_cast<uint32_t>(error));
        curStm->SetMemContainOverflowAddr(memAddr);
    }

    error = MemcpyAsync(curStm->GetMemContainOverflowAddr(), sizeof(uint64_t), hostPtr, sizeof(uint64_t),
        RT_MEMCPY_HOST_TO_DEVICE_EX, curStm, &realSize, hostPtrGuard);
    ERROR_RETURN(error, "MemcpyAsync failed, retCode=%#x.", static_cast<uint32_t>(error));

    error = NpuGetFloatStatus(curStm->GetMemContainOverflowAddr(), outputSize, 0U, curStm);

    ERROR_RETURN(error, "NpuGetFloatStatus failed, retCode=%#x.", static_cast<uint32_t>(error));

    return error;
}

rtError_t Context::SetUpdateAddrTask(uint64_t devAddr, uint64_t len, Stream *stm)
{
    TaskInfo taskSubmit = {};
    rtError_t errorReason;
    TaskInfo *rtUpdateAddressTask = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_UPDATE_ADDRESS, errorReason);
    NULL_PTR_RETURN(rtUpdateAddressTask, errorReason);

    rtError_t error = UpdateAddressTaskInit(rtUpdateAddressTask, devAddr, len);
    const int32_t streamId = stm->Id_();
    ERROR_GOTO(error, ERROR_RECYCLE, "update addr task failed,stream_id=%d,task_id=%hu,retCode=%#x.",
               streamId, rtUpdateAddressTask->id, static_cast<uint32_t>(error));

    error = device_->SubmitTask(rtUpdateAddressTask, taskGenCallback_);
    ERROR_GOTO(error, ERROR_RECYCLE, "update addr task submit failed,retCode=%#x", static_cast<uint32_t>(error));

    GET_THREAD_TASKID_AND_STREAMID(rtUpdateAddressTask, streamId);

    return error;
ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtUpdateAddressTask);
    return error;
}

rtError_t Context::ModelNameSet(Model * const mdl, const char_t * const name) const
{
    std::string modelName(name);
    mdl->SetModelName(modelName);

    return RT_ERROR_NONE;
}

rtError_t Context::AllocCascadeCaptureStream(const Stream * const stm, Model *const captureModel, Stream **newCaptureStream)
{
    Stream *newCaptureStreamTmp = nullptr;

    if (captureModel == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Capture model is null, device_id=%u, original stream_id=%d.",
            device_->Id_(), stm->Id_());
        return RT_ERROR_MODEL_NULL;
    }

    CaptureModel *captureModelTmp = dynamic_cast<CaptureModel *>(captureModel);
    const uint32_t flag = GetCaptureStreamFlag();
    /* create capture stream */
    rtError_t error = StreamCreate(0U, flag, &newCaptureStreamTmp, nullptr, captureModelTmp->IsSoftwareSqEnable());
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Capture stream create failed, device_id=%u, original stream_id=%d, retCode=%#x.",
            device_->Id_(), stm->Id_(), error);
        return error;
    }

    if (captureModelTmp->IsSoftwareSqEnable()) {
        /* add stream to model */
        error = ModelAddStream(captureModel, newCaptureStreamTmp, RT_INVALID_FLAG);
    } else {
        /* bind stream to model */
        error = ModelBindStream(captureModel, newCaptureStreamTmp, RT_INVALID_FLAG);
    }

    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Bind capture stream failed, device_id=%u, model_id=%u, stream_id=%d, "
            "original stream_id=%d, retCode=%#x.",
            device_->Id_(), captureModel->Id_(), newCaptureStreamTmp->Id_(), stm->Id_(), error);
        StreamDestroy(newCaptureStreamTmp);
        return error;
    }

    *newCaptureStream = newCaptureStreamTmp;

    return RT_ERROR_NONE;
}

void Context::FreeCascadeCaptureStream(Stream * const cascadeCaptureStm)
{
    if (cascadeCaptureStm == nullptr) {
        RT_LOG(RT_LOG_ERROR, "cascade capture stream is null.");
        return;
    }

    if (cascadeCaptureStm->Model_() != nullptr) {
        CaptureModel *captureModelTmp = dynamic_cast<CaptureModel *>(cascadeCaptureStm->Model_());
        if (captureModelTmp->IsSoftwareSqEnable()) {
            /* steam is add to model, only need del from model */
            (void)ModelDelStream(cascadeCaptureStm->Model_(), cascadeCaptureStm);
        } else {
            /* steam is bind to model, only need unbind from model */
            (void)ModelUnbindStream(cascadeCaptureStm->Model_(), cascadeCaptureStm);
        }
    }

    (void)StreamDestroy(cascadeCaptureStm, true);

    return;
}

rtError_t Context::StreamAddToCaptureModelProc(Stream * const stm, Model * const captureMdl, const bool isOriginal)
{
    Stream *captureStream = nullptr;
    const int32_t streamId = stm->Id_();
    if (captureMdl == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Capture model is null, device_id=%u, original stream_id=%d.", device_->Id_(), streamId);
        return RT_ERROR_MODEL_NULL;
    }

    if (captureMdl->GetModelType() != RT_MODEL_CAPTURE_MODEL) {
        RT_LOG(RT_LOG_ERROR, "model type not match, device_id=%u, original stream_id=%d, model_id=%u.",
            device_->Id_(), streamId, captureMdl->Id_());
        return RT_ERROR_INVALID_VALUE;
    }

    CaptureModel *captureModelTmp = dynamic_cast<CaptureModel *>(captureMdl);
    if (captureModelTmp->IsCaptureFinish() || captureModelTmp->IsCaptureInvalid()) {
        RT_LOG(RT_LOG_ERROR, "model capture status mismatch, device_id=%u, original stream_id=%d, model_id=%u.",
            device_->Id_(), streamId, captureMdl->Id_());
        return RT_ERROR_MODEL_CAPTURE_STATUS;
    }
    const uint32_t flag = GetCaptureStreamFlag();
    /* create capture stream */
    rtError_t error = StreamCreate(0U, flag, &captureStream, nullptr, captureModelTmp->IsSoftwareSqEnable());
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Capture stream create failed, device_id=%u, original stream_id=%d, retCode=%#x.",
            device_->Id_(), streamId, error);
        return error;
    }

    if (captureModelTmp->IsSoftwareSqEnable()) {
        /* add stream to model */
        error = ModelAddStream(captureMdl, captureStream, RT_HEAD_STREAM);
    } else {
        /* bind stream to model */
        error = ModelBindStream(captureMdl, captureStream, RT_HEAD_STREAM);
    }

    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Bind capture stream failed, device_id=%u, model_id=%u, stream_id=%d, "
            "original stream_id=%d, retCode=%#x.",
            device_->Id_(), captureMdl->Id_(), captureStream->Id_(), streamId, error);
        (void)StreamDestroy(captureStream);
        return error;
    }

    /* stm begin capture */
    const rtStreamCaptureStatus status = stm->GetCaptureStatus();
    /* check capture status again */
    if (status != RT_STREAM_CAPTURE_STATUS_NONE) {
        RT_LOG(RT_LOG_ERROR, "stream is already in capture status, device_id=%u, stream_id=%d, status=%s.",
            device_->Id_(), streamId, ((status == RT_STREAM_CAPTURE_STATUS_ACTIVE) ? "active" : "invalidated"));

        if (captureModelTmp->IsSoftwareSqEnable()) {
            /* steam is add to model, only need destroy model */
            (void)ModelDelStream(captureMdl, captureStream);
        } else {
            /* steam is bind to model, only need destroy model */
            (void)ModelUnbindStream(captureMdl, captureStream);
        }
        (void)StreamDestroy(captureStream);
        return RT_ERROR_STREAM_CAPTURED;
    }

    captureStream->MarkOrigCaptureStream(isOriginal);
    stm->EnterCapture(captureStream);
    return RT_ERROR_NONE;
}

rtError_t Context::StreamBeginCapture(Stream * const stm, const rtStreamCaptureMode mode)
{
    Model *captureModel = nullptr;

    BufferAllocator::OpenHugeBuff();

    const rtStreamCaptureStatus status = stm->GetCaptureStatus();
    const int32_t streamId = stm->Id_();

    RT_LOG(RT_LOG_INFO, "capture begin, device_id=%u, original stream_id=%d.", device_->Id_(), streamId);

    /* check capture status */
    if (status != RT_STREAM_CAPTURE_STATUS_NONE) {
        RT_LOG(RT_LOG_ERROR, "stream is already in capture status, device_id=%u, stream_id=%d, status=%s.",
            device_->Id_(), streamId, ((status == RT_STREAM_CAPTURE_STATUS_ACTIVE) ? "active" : "invalidated"));
        return RT_ERROR_STREAM_CAPTURED;
    }

    /* create capture model */
    rtError_t error = ModelCreate(&captureModel, RT_MODEL_CAPTURE_MODEL);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Capture model create failed, device_id=%u, original stream_id=%d, retCode=%#x.",
            device_->Id_(), streamId, error);
        return error;
    }

    if ((stm->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_ACL_GRAPH_SOFTWARE_ENABLE)) && 
        (stm->Device_()->CheckFeatureSupport(TS_FEATURE_SOFTWARE_SQ_ENABLE)) &&
        (NpuDriver::CheckIsSupportFeature(device_->Id_(), FEATURE_TRSDRV_SQ_SUPPORT_DYNAMIC_BIND))) {
        CaptureModel *captureModelTmp = dynamic_cast<CaptureModel *>(captureModel);
        captureModelTmp->SetSoftwareSqEnable();
    }

    std::unique_lock<std::mutex> taskLock(captureLock_);
    error = StreamAddToCaptureModelProc(stm, captureModel, true);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "add stream to capture model failed, device_id=%u, model_id=%u, "
            "original stream_id=%d, retCode=%#x.",
            device_->Id_(), captureModel->Id_(), streamId, error);
        ModelDestroy(captureModel);
        return error;
    }

    CaptureModeEnter(stm, mode);

    RT_LOG(RT_LOG_EVENT, "capture begin success, device_id=%u, model_id=%u,"
 	    " original stream_id=%d, capture stream_id=%d, stream_status=%d.",
 	    device_->Id_(), captureModel->Id_(), streamId, stm->GetCaptureStream()->Id_(), stm->GetCaptureStatus());

    return RT_ERROR_NONE;
}

rtError_t Context::CheckCaptureModelValidity(Model * const captureMdl) const
{
    NULL_PTR_RETURN(captureMdl, RT_ERROR_MODEL_NULL);
    std::list<Stream *> streams = captureMdl->StreamList_();
    COND_RETURN_ERROR((streams.empty() == true),
        RT_ERROR_STREAM_UNJOINED,
        "No streams is bound to the capture module, model_id=%u.",
        captureMdl->Id_());

    CaptureModel * const mdl = dynamic_cast<CaptureModel * const>(captureMdl);
    std::set<uint16_t> & streamIds = mdl->GetTaskGroupStreamIds();
    COND_RETURN_ERROR((!streamIds.empty()),
        RT_ERROR_STREAM_TASKGRP_STATUS,
        "A task group is not closed in the capture module, model_id=%u.",
        captureMdl->Id_());

    bool isOnlyOrigStream = true;
    bool hasRecordOrigStream = false;
    for (auto it = streams.begin(); it != streams.end(); it++) {
        if (((*it)->IsOrigCaptureStream()) ||
            ((*it)->IsLastLevelCaptureStream() == false) ||
            (mdl->IsAddStream(*it))) {
            continue;
        }

        isOnlyOrigStream = false;
        const int32_t streamId = (*it)->Id_();
        const uint32_t taskId = (*it)->GetLastTaskId();
        Event *event = nullptr;
        CaptureCntNotify cntInfo = {0, 0U};
        const rtError_t ret = GetCaptureEventFromTask(device_, static_cast<uint32_t>(streamId), taskId, event, cntInfo);
        COND_RETURN_WITH_NOLOG((ret != RT_ERROR_NONE), ret);
        COND_RETURN_ERROR((event == nullptr),
            RT_ERROR_EVENT_NULL,
            "No event object, stream_id=%d, task_id=%u.",
            streamId, taskId);
        COND_RETURN_ERROR((event->GetEventFlag() == RT_EVENT_EXTERNAL),
            RT_ERROR_STREAM_UNJOINED,
            "The event flag is external, stream_id=%d, task_id=%u, event_id=%d.",
            streamId, taskId, event->EventId_());
        COND_RETURN_ERROR((IsCaptureWaitExist(event, cntInfo) == false),
            RT_ERROR_STREAM_UNJOINED,
            "A free-state event record task was discovered, stream_id=%d, task_id=%u, event_id=%d.",
            streamId, taskId, (event->GetEventFlag() == RT_EVENT_DEFAULT) ? cntInfo.eventId : event->EventId_());
        if (event->IsRecordOrigCaptureStream(*it)) {
            hasRecordOrigStream = true;
        }
    }
    COND_RETURN_ERROR(((isOnlyOrigStream == false) && (hasRecordOrigStream == false)), RT_ERROR_STREAM_UNJOINED,
        "capture model contains a stream that was not joined to the original stream.");
    return RT_ERROR_NONE;
}

rtError_t Context::CreateNotify(Notify **notify, uint32_t flag)
{
    const uint32_t deviceId = device_->Id_();
    *notify = new (std::nothrow) Notify(deviceId, device_->DevGetTsId());
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, *notify == nullptr, RT_ERROR_NOTIFY_NEW,
                               "Notify create failed, new notify failed.");

    (*notify)->SetNotifyFlag(flag);
    const rtError_t error = (*notify)->Setup();
    ERROR_PROC_RETURN_MSG_INNER(error, DELETE_O(*notify);,
        "Notify create failed, setup failed, device_id=%d, retCode=%#x", deviceId, static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
}

rtError_t Context::AddNotifyToAddedCaptureStream(Stream * const oriSingleStm, CaptureModel * const captureMdl)
{
    rtError_t error = RT_ERROR_NONE;
    auto &streams = captureMdl->GetAddStreamMap();
    Api * const apiObj = Runtime::Instance()->ApiImpl_();
    NULL_PTR_RETURN_MSG(apiObj, RT_ERROR_API_NULL);
    for (auto &streamObj : streams) {
        Notify *notify = nullptr;
        error = CreateNotify(&notify, RT_NOTIFY_DEFAULT);
        COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error); // notify在模型销毁时，统一进行释放
        captureMdl->AddNotify(notify);
        error = apiObj->NotifyRecord(notify, streamObj.second.back());
        ERROR_RETURN(error,
            "Notify record failed, device_id=%u, single stream_id=%d, "
            "capture model_id=%u, stream_id=%d, notify_id=%u, retCode=%#x",
            device_->Id_(), oriSingleStm->Id_(), captureMdl->Id_(),
            streamObj.second.back()->Id_(), notify->GetNotifyId(), error);
        error = apiObj->NotifyWait(notify, oriSingleStm, MAX_UINT32_NUM);
        ERROR_RETURN(error,
            "Notify wit failed, device_id=%u, single stream_id=%d, "
            "capture model_id=%u, stream_id=%d, notify_id=%u, retCode=%#x",
            device_->Id_(), oriSingleStm->Id_(), captureMdl->Id_(),
            streamObj.second.back()->Id_(), notify->GetNotifyId(), error);
    }
    return error;
}

rtError_t Context::SetNotifyForExeModel(CaptureModel* const captureMdl)
{
    /* for exe stream and add stream alloc notify */
    rtError_t error = RT_ERROR_NONE;
    const std::map<Stream *, std::vector<Stream *>> &streams = captureMdl->GetAddStreamMap();
    for (size_t i = 0U; i < (streams.size() * NOTIFY_INDEX); i++) {
        Notify *notify = nullptr;
        error = CreateNotify(&notify, RT_NOTIFY_DEFAULT);
        COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
        captureMdl->AddExeNotify(notify);
        RT_LOG(RT_LOG_DEBUG, "create notify id=%u", notify->GetNotifyId());
    }
    return error;
}

static inline void ClearCaptureModel(Context * const ctx, Stream * const stm, Model *mdl = nullptr)
{
    stm->ExitCapture();
    /* steam is bound to model, only need destroy model */
    if (mdl != nullptr) {
        (void)ctx->ModelDestroy(mdl);
    }
}

rtError_t Context::StreamEndCapture(Stream * const stm, Model ** const captureMdl)
{
    RT_LOG(RT_LOG_INFO, "capture end, device_id=%u, original stream_id=%d.", device_->Id_(), stm->Id_());
    *captureMdl = nullptr;
    std::unique_lock<std::mutex> taskLock(captureLock_);
    const rtStreamCaptureStatus status = stm->GetCaptureStatus();
    /* check capture status */
    if (status == RT_STREAM_CAPTURE_STATUS_NONE) {
        RT_LOG(RT_LOG_ERROR, "stream is not in capture status, device_id=%u, origin stream_id=%d, status=NONE.",
            device_->Id_(), stm->Id_());
        return RT_ERROR_STREAM_NOT_CAPTURED;
    }

    Stream *captureStream = stm->GetCaptureStream();
    NULL_STREAM_PTR_RETURN_MSG(captureStream);
    if (!(captureStream->IsOrigCaptureStream())) {
        RT_LOG(RT_LOG_ERROR, "The capture was not initiated in this stream. device_id=%u, stream_id=%d.",
            device_->Id_(), stm->Id_());
        return RT_ERROR_STREAM_CAPTURE_UNMATCHED;
    }

    rtError_t error = CheckCaptureStreamThreadIsMatch(stm);
    COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error,
        CaptureModeExit(stm);
        ClearCaptureModel(this, stm);,
        "end capture in the wrong thread.");
    CaptureModeExit(stm);

    Model *captureModel = captureStream->Model_();
    if (captureModel == nullptr) {
        RT_LOG(RT_LOG_ERROR, "captureModel is null, device_id=%u, origin stream_id=%d, status=%s.",
            device_->Id_(), stm->Id_(), ((status == RT_STREAM_CAPTURE_STATUS_ACTIVE) ? "active" : "invalidated"));
        ClearCaptureModel(this, stm);
        return RT_ERROR_MODEL_NULL;
    }

    CaptureModel *captureModelTmp = RtPtrToPtr<CaptureModel *, Model *>(captureModel);
    if (status == RT_STREAM_CAPTURE_STATUS_INVALIDATED ||
        captureModelTmp->IsCaptureInvalid()) {
        RT_LOG(RT_LOG_ERROR, "current capture is invalid, device_id=%u, origin stream_id=%d.",
            device_->Id_(), stm->Id_());
        ClearCaptureModel(this, stm, captureModel);
        return RT_ERROR_STREAM_CAPTURE_INVALIDATED;
    }

    error = CheckCaptureModelValidity(captureModel);
    COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error,
        ClearCaptureModel(this, stm, captureModel),
        "Failed to verify the validity of the capture model, retCode=%#x.", static_cast<uint32_t>(error));

    captureStream = stm->GetCaptureStream();
    NULL_PTR_PROC_RETURN_ERROR(captureStream, RT_ERROR_STREAM_NULL,
        ClearCaptureModel(this, stm, captureModel));
    error = AddNotifyToAddedCaptureStream(stm, static_cast<CaptureModel *>(captureModelTmp));
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "set notify for add capture stream failed, device_id=%u, origin stream_id=%d, "
            "capture model_id=%u, stream_id=%d, retCode=%#x.",
            device_->Id_(), stm->Id_(), captureModel->Id_(), captureStream->Id_(), error);
        ClearCaptureModel(this, stm, captureModel);
        return error;
    }

    error = SetNotifyForExeModel(captureModelTmp);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "set notify for capture model failed, device_id=%u, origin stream_id=%d, "
            "capture model_id=%u, stream_id=%d, retCode=%#x.",
            device_->Id_(), stm->Id_(), captureModel->Id_(), captureStream->Id_(), error);
        ClearCaptureModel(this, stm, captureModel);
        return error;
    }

    error = captureModelTmp->ResetCaptureEvents(stm);
    COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, ClearCaptureModel(this, stm, captureModel),
        "Failed to reset capture events, retCode=%#x.", static_cast<uint32_t>(error));

    if (!captureModelTmp->IsSoftwareSqEnable()) {
        Api * const apiObj = Runtime::Instance()->ApiImpl_();
        error = apiObj->ModelEndGraph(captureModel, captureStream, 0U);
        COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, ClearCaptureModel(this, stm, captureModel),
            "capture model end graph failed, device_id=%u, origin stream_id=%d, "
            "capture model_id=%u, stream_id=%d, retCode=%#x.",
            device_->Id_(), stm->Id_(), captureModel->Id_(), captureStream->Id_(), error);
        error = captureModel->LoadComplete();
        COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, ClearCaptureModel(this, stm, captureModel),
            "capture model load complete failed, device_id=%u, origin stream_id=%d, "
            "capture model_id=%u, stream_id=%d, retCode=%#x.",
            device_->Id_(), stm->Id_(), captureModel->Id_(), captureStream->Id_(), error);
    }

    Profiler *profilerPtr = Runtime::Instance()->Profiler_();
    if (profilerPtr != nullptr) {
        if (profilerPtr->GetTrackProfEnable()) {
            captureModelTmp->ReportedStreamInfoForProfiling();
        }
    }

    /* stm end capture */
    stm->ExitCapture();
    *captureMdl = captureModel;

    RT_LOG(RT_LOG_EVENT,
        "capture end success, device_id=%u, original stream_id=%d, capture stream_id=%d, capture model_id=%u.",
        device_->Id_(), stm->Id_(), captureStream->Id_(), captureModel->Id_());

    return RT_ERROR_NONE;
}

rtError_t Context::StreamGetCaptureInfo(const Stream * const stm, rtStreamCaptureStatus * const status,
                                        Model ** const captureMdl)
{
    Stream *captureStream = stm->GetCaptureStream();
    const rtStreamCaptureStatus statusTmp = stm->GetCaptureStatus();
    Model *mdlTmp = nullptr;
    uint32_t modelId = 0xFFFFU;

    if ((statusTmp != RT_STREAM_CAPTURE_STATUS_NONE) && (captureStream != nullptr)) {
        mdlTmp = captureStream->Model_();
        if (mdlTmp == nullptr) {
            RT_LOG(RT_LOG_WARNING, "stream is not in capture status, device_id=%u, stream_id=%d.",
                device_->Id_(), stm->Id_());
        } else {
 	        modelId = mdlTmp->Id_();
 	    }
    }

    if (status != nullptr) {
        *status = statusTmp;
    }

    if (captureMdl != nullptr) {
        *captureMdl = mdlTmp;
    }

    RT_LOG(RT_LOG_INFO, "device_id=%u, model_id=%u, original stream_id=%d, stream_status=%d",
 	    device_->Id_(), modelId, stm->Id_(), statusTmp);

    return RT_ERROR_NONE;
}

rtError_t Context::ModelGetNodes(const Model * const mdl, uint32_t * const num)
{
    /* model can not bind or unbind while get nodes */
    std::unique_lock<std::mutex> taskLock(streamLock_);
    *num = mdl->ModelGetNodes();
    return RT_ERROR_NONE;
}

rtError_t Context::ModelDebugDotPrint(const Model * const mdl)
{
    std::unique_lock<std::mutex> taskLock(streamLock_);
    return mdl->ModelDebugDotPrint();
}

rtError_t Context::ModelDebugJsonPrint(const Model * const mdl, const char* path, const uint32_t flags)
{
    std::unique_lock<std::mutex> taskLock(streamLock_);
    return mdl->ModelDebugJsonPrint(path, flags);
}

rtError_t Context::StreamAddToModel(Stream * const stm, Model * const captureMdl)
{
    std::unique_lock<std::mutex> taskLock(captureLock_);
    return static_cast<CaptureModel *>(captureMdl)->AddStreamToCaptureModel(stm);
}

rtError_t Context::ThreadExchangeCaptureMode(rtStreamCaptureMode * const mode) const
{
    const rtStreamCaptureMode exchangeCaptureModeOld = InnerThreadLocalContainer::GetThreadExchangeCaptureMode();

    /* set new mode */
    InnerThreadLocalContainer::SetThreadExchangeCaptureMode(*mode);

    /* return old mode */
    *mode = exchangeCaptureModeOld;

    return RT_ERROR_NONE;
}

bool Context::IsCaptureModeSupport(void) const
{
    const rtStreamCaptureMode contextCaptureMode = GetContextCaptureMode();
    /* no capture scene, support */
    if (contextCaptureMode == RT_STREAM_CAPTURE_MODE_MAX) {
        return true;
    }

    const rtStreamCaptureMode threadCaptureMode = InnerThreadLocalContainer::GetThreadCaptureMode();
    const rtStreamCaptureMode exchangeCaptureMode = InnerThreadLocalContainer::GetThreadExchangeCaptureMode();
    if (exchangeCaptureMode == RT_STREAM_CAPTURE_MODE_RELAXED) {
        return true;
    }

    if (exchangeCaptureMode == RT_STREAM_CAPTURE_MODE_GLOBAL) {
        if ((contextCaptureMode == RT_STREAM_CAPTURE_MODE_GLOBAL) ||
            (threadCaptureMode == RT_STREAM_CAPTURE_MODE_THREAD_LOCAL)) {
            return false;
        }
    }

    if (exchangeCaptureMode == RT_STREAM_CAPTURE_MODE_THREAD_LOCAL) {
        if ((threadCaptureMode == RT_STREAM_CAPTURE_MODE_GLOBAL) ||
            (threadCaptureMode == RT_STREAM_CAPTURE_MODE_THREAD_LOCAL)) {
            return false;
        }
    }

    return true;
}

void Context::CaptureModeEnter(Stream * const stm, rtStreamCaptureMode mode)
{
    stm->SetStreamCaptureMode(mode);
    stm->SetBeginCaptureThreadId(runtime::GetCurrentTid());
    captureModeRefNum_[mode]++;
    InnerThreadLocalContainer::ThreadCaptureModeEnter(mode);

    /* mode, 0: global; 1: thread; 2: relax; 3: max */
    if (mode < GetContextCaptureMode()) {
        SetContextCaptureMode(mode);
    }
}

void Context::CaptureModeExit(Stream * const stm)
{
    const rtStreamCaptureMode streamCaptureMode = stm->GetStreamCaptureMode();
    stm->SetStreamCaptureMode(RT_STREAM_CAPTURE_MODE_MAX);
    stm->SetBeginCaptureThreadId(UINT32_MAX);

    /* end capture is already finished in this stm */
    if (static_cast<uint32_t>(streamCaptureMode) >= RT_STREAM_CAPTURE_MODE_MAX) {
        return;
    }

    if (captureModeRefNum_[streamCaptureMode] > 0U) {
        captureModeRefNum_[streamCaptureMode]--;
    }

    InnerThreadLocalContainer::ThreadCaptureModeExit(streamCaptureMode);

    if (GetCaptureModeRefNum(RT_STREAM_CAPTURE_MODE_GLOBAL) != 0U) {
        return;
    }

    if (GetCaptureModeRefNum(RT_STREAM_CAPTURE_MODE_THREAD_LOCAL) != 0U) {
        SetContextCaptureMode(RT_STREAM_CAPTURE_MODE_THREAD_LOCAL);
        return;
    }

    if (GetCaptureModeRefNum(RT_STREAM_CAPTURE_MODE_RELAXED) != 0U) {
        SetContextCaptureMode(RT_STREAM_CAPTURE_MODE_RELAXED);
        return;
    }

    SetContextCaptureMode(RT_STREAM_CAPTURE_MODE_MAX);

    return;
}

rtError_t Context::StreamBeginTaskGrp(Stream * const stm)
{
    const std::lock_guard<std::mutex> tskGrpLock(stm->GetTaskGrpMutex());
    const StreamTaskGroupStatus status = stm->GetTaskGroupStatus();
    COND_RETURN_ERROR_MSG_INNER(status != StreamTaskGroupStatus::NONE,
        RT_ERROR_STREAM_TASKGRP_STATUS,
        "Task group is repeatedly started, or a task group is being updated.");

    Stream *captureStream = stm->GetCaptureStream();
    NULL_PTR_RETURN_MSG(captureStream, RT_ERROR_STREAM_NOT_CAPTURED);

    CaptureModel *mdl = dynamic_cast<CaptureModel *>(captureStream->Model_());
    NULL_PTR_RETURN(mdl, RT_ERROR_MODEL_NULL);

    std::unique_ptr<TaskGroup> taskGrp(new (std::nothrow) TaskGroup);
    COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, taskGrp == nullptr,
        RT_ERROR_MEMORY_ALLOCATION, "Create task group object failed.");

    const uint8_t prefetchCnt = stm->Device_()->GetDevProperties().taskPrefetchCount;
    for (uint8_t idx = 0; idx < prefetchCnt; idx++) {
        const rtError_t ret = SendNopTask(this, stm);
        ERROR_RETURN_MSG_INNER(ret, "Launch Nop task %u error %#x.", idx, static_cast<uint32_t>(ret));
    }

    captureStream = stm->GetCaptureStream();
    NULL_PTR_RETURN_MSG(captureStream, RT_ERROR_STREAM_NOT_CAPTURED);
    COND_RETURN_ERROR((mdl != dynamic_cast<CaptureModel *>(captureStream->Model_())),
        RT_ERROR_STREAM_CAPTURE_CONFLICT, "Capture model conflict.");
    (void)stm->UpdateTaskGroupStatus(StreamTaskGroupStatus::SAMPLE);
    captureStream->UpdateCurrentTaskGroup(taskGrp);
    mdl->InsertTaskGroupStreamId(static_cast<uint16_t>(captureStream->Id_()));
    return RT_ERROR_NONE;
}

rtError_t Context::StreamEndTaskGrp(Stream * const stm, TaskGroup ** const handle) const
{
    *handle = nullptr;
    const std::lock_guard<std::mutex> tskGrpLock(stm->GetTaskGrpMutex());
    const StreamTaskGroupStatus status = stm->GetTaskGroupStatus();
    COND_RETURN_ERROR_MSG_INNER(status != StreamTaskGroupStatus::SAMPLE,
        RT_ERROR_STREAM_TASKGRP_STATUS,
        "The end operation cannot be performed on a stream that has not started a task group.");

    Stream * const captureStream = stm->GetCaptureStream();
    NULL_PTR_RETURN(captureStream, RT_ERROR_STREAM_NOT_CAPTURED);

    CaptureModel *mdl = dynamic_cast<CaptureModel *>(captureStream->Model_());
    NULL_PTR_RETURN(mdl, RT_ERROR_MODEL_NULL);

    std::unique_ptr<TaskGroup> &taskGrp = captureStream->GetCurrentTaskGroup();
    NULL_PTR_RETURN(taskGrp, RT_ERROR_STREAM_TASKGRP_NULL);

    rtError_t errorCode = mdl->GetTaskGroupErrCode();
    if ((errorCode != RT_ERROR_NONE) || (mdl->IsCaptureInvalid()) ||
        (stm->GetCaptureStatus() == RT_STREAM_CAPTURE_STATUS_INVALIDATED)) {
        taskGrp.reset();
        *handle = nullptr;
        errorCode = (errorCode != RT_ERROR_NONE) ? errorCode : RT_ERROR_STREAM_CAPTURE_INVALIDATED;
    } else {
        *handle = taskGrp.get();
        mdl->AddTaskGroupList(taskGrp);
    }
    captureStream->ResetTaskGroup();
    mdl->DeleteTaskGroupStreamId(static_cast<uint16_t>(captureStream->Id_()));
    (void)stm->UpdateTaskGroupStatus(StreamTaskGroupStatus::NONE);
    return errorCode;
}

rtError_t Context::StreamBeginTaskUpdate(Stream * const stm, TaskGroup * handle) const
{
    const std::lock_guard<std::mutex> tskGrpLock(stm->GetTaskGrpMutex());
    COND_RETURN_OUT_ERROR_MSG_CALL(stm->GetTaskGroupStatus() != StreamTaskGroupStatus::NONE,
        RT_ERROR_STREAM_TASKGRP_STATUS, "Unable to start update tasks because the stream is busy.");

    COND_RETURN_ERROR_MSG_INNER(handle->isUpdate,
        RT_ERROR_STREAM_TASKGRP_STATUS, "The handle only can be updated by one stream.");

    const rtError_t ret = stm->UpdateTaskGroupStatus(StreamTaskGroupStatus::UPDATE);
    ERROR_RETURN(ret, "update stream task group status failed, ret:%#x, status:%d.",
        static_cast<uint32_t>(ret), stm->GetTaskGroupStatus());

    stm->SetUpdateTaskGroup(handle);
    RT_LOG(RT_LOG_INFO, "Success to begin update tasks, stream_id=%d.", stm->Id_());
    return RT_ERROR_NONE;
}

rtError_t Context::StreamEndTaskUpdate(Stream * const stm) const
{
    const std::lock_guard<std::mutex> tskGrpLock(stm->GetTaskGrpMutex());
    COND_RETURN_OUT_ERROR_MSG_CALL(stm->GetTaskGroupStatus() != StreamTaskGroupStatus::UPDATE,
        RT_ERROR_STREAM_TASKGRP_STATUS, "Unable to end update tasks because the stream is busy.");

    TaskGroup *updateTaskGroup = stm->GetUpdateTaskGroup();
    NULL_PTR_RETURN_MSG_OUTER(updateTaskGroup, RT_ERROR_INVALID_VALUE);
    (void)stm->UpdateTaskGroupStatus(StreamTaskGroupStatus::NONE);

    const size_t taskIndex = updateTaskGroup->updateTaskIndex;
    COND_PROC_RETURN_ERROR_MSG_INNER(taskIndex != updateTaskGroup->taskIds.size(),
        RT_ERROR_STREAM_TASKGRP_UPDATE, stm->ResetUpdateTaskGroup();,
        "Update tasks failed, stream_id=%d, total=%zu, success=%zu, failed=%zu.",
        stm->Id_(), updateTaskGroup->taskIds.size(), taskIndex, (updateTaskGroup->taskIds.size() - taskIndex));

    stm->ResetUpdateTaskGroup();
    RT_LOG(RT_LOG_INFO, "stream_id=%d update tasks result: total=%zu, success=%zu, remain=%zu",
        stm->Id_(), updateTaskGroup->taskIds.size(), taskIndex, (updateTaskGroup->taskIds.size() - taskIndex));
    return RT_ERROR_NONE;
}

bool Context::IsStreamInContext(Stream * const stm)
{
    std::unique_lock<std::mutex> taskLock(streamLock_);
    for (Stream *stream : streams_) {
        if (!stream->GetBindFlag() && (stream == stm)) {
            return true;
        }
    }

    // streams_ not include default stream
    return (DefaultStream_() == stm);
}

rtError_t Context::MemWriteValue(const void * const devAddr, const uint64_t value,
    const uint32_t flag, Stream * const stm) const
{
    UNUSED(flag);
    const int32_t streamId = stm->Id_();
    rtError_t errorReason;

    TaskInfo taskSubmit = {};
    TaskInfo *rtMemWriteValueTask = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_MEM_WRITE_VALUE, errorReason);
    NULL_PTR_RETURN(rtMemWriteValueTask, errorReason);

    rtError_t error = MemWriteValueTaskInit(rtMemWriteValueTask, devAddr, value);
    MemWriteValueTaskInfo *memWriteValueTask = &rtMemWriteValueTask->u.memWriteValueTask;
    ERROR_GOTO(error, ERROR_RECYCLE, "mem write value task init failed, stream_id=%d, task_id=%hu, retCode=%#x.",
        streamId, rtMemWriteValueTask->id, static_cast<uint32_t>(error));
    rtMemWriteValueTask->typeName = "MEM_WRITE_VALUE";
    rtMemWriteValueTask->type = TS_TASK_TYPE_MEM_WRITE_VALUE;
    memWriteValueTask->awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_64BIT;
    error = device_->SubmitTask(rtMemWriteValueTask, taskGenCallback_);
    ERROR_GOTO(error, ERROR_RECYCLE, "mem write value task submit failed, retCode=%#x", static_cast<uint32_t>(error));

    GET_THREAD_TASKID_AND_STREAMID(rtMemWriteValueTask, stm->AllocTaskStreamId());
    return error;
ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtMemWriteValueTask);
    return error;
}

rtError_t Context::MemWaitValue(const void * const devAddr, const uint64_t value,
    const uint32_t flag, Stream * const stm) const
{
    const int32_t streamId = stm->Id_();
    rtError_t errorReason;

    TaskInfo taskSubmit = {};
    TaskInfo *rtMemWaitValueTask = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_MEM_WAIT_VALUE, errorReason, MEM_WAIT_SQE_NUM);
    NULL_PTR_RETURN(rtMemWaitValueTask, errorReason);

    rtMemWaitValueTask->typeName = "MEM_WAIT_VALUE";
    rtMemWaitValueTask->type = TS_TASK_TYPE_MEM_WAIT_VALUE;
    rtError_t error = MemWaitValueTaskInit(rtMemWaitValueTask, devAddr, value, flag);
    MemWaitValueTaskInfo *memWaitValueTask = &rtMemWaitValueTask->u.memWaitValueTask;
    ERROR_GOTO(error, ERROR_RECYCLE, "mem wait value init failed, stream_id=%d, task_id=%hu, retCode=%#x.",
        streamId, rtMemWaitValueTask->id, static_cast<uint32_t>(error));
    memWaitValueTask->awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_64BIT;
    error = device_->SubmitTask(rtMemWaitValueTask, taskGenCallback_);
    ERROR_GOTO(error, ERROR_RECYCLE, "mem wait value task submit failed, retCode=%#x", static_cast<uint32_t>(error));

    GET_THREAD_TASKID_AND_STREAMID(rtMemWaitValueTask, stm->AllocTaskStreamId());
    return error;
ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtMemWaitValueTask);
    return error;
}

rtError_t Context::ResourceReset(void)
{
    const uint32_t deviceId = Device_()->Id_();
    const uint32_t tsId = Device_()->DevGetTsId();
    rtError_t error = Device_()->Driver_()->ResourceReset(deviceId, tsId, DRV_NOTIFY_ID);
    ERROR_RETURN(error, "Failed to reset notify, device_id=%d, retCode=%#x.", deviceId, error);
    error = Device_()->Driver_()->ResourceReset(deviceId, tsId, DRV_CNT_NOTIFY_ID);
    ERROR_RETURN(error, "Failed to reset cnt_notify, device_id=%d, retCode=%#x.", deviceId, error);
    return error;
}

rtError_t Context::ModelGetName(const Model * const mdl, const uint32_t maxLen, char_t * const mdlName) const
{
    return mdl->GetModelName(maxLen, mdlName);
}

rtError_t Context::CreateContextCallBackThread()
{
    void * const callback = ValueToPtr(THREAD_CALLBACK);
    constexpr const char_t* threadName = "THREAD_CALLBACK";
    hostFuncCallBackThread_.reset(OsalFactory::CreateThread(threadName, &threadCallBack_, callback));
    NULL_PTR_RETURN(hostFuncCallBackThread_, RT_ERROR_MEMORY_ALLOCATION);
    threadCallBack_.callBackThreadRunFlag_ = true;
    const int32_t error = hostFuncCallBackThread_ ->Start();
    if (error != EN_OK) {
        threadCallBack_.callBackThreadRunFlag_ = false;
        hostFuncCallBackThread_ .reset(nullptr);
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    callBackThreadId_ = hostFuncCallBackThread_->GetThreadId();
    RT_LOG(RT_LOG_INFO, "Start callback thread success, thread_id=%llu!", callBackThreadId_);
    return RT_ERROR_NONE;
}
 
void Context::DestroyContextCallBackThread(void)
{
    if (hostFuncCallBackThread_ != nullptr) {
        threadCallBack_.callBackThreadRunFlag_ = false;
        if (callBackThreadId_ != PidTidFetcher::GetCurrentUserTid()) {
            hostFuncCallBackThread_->Join();
            RT_LOG(RT_LOG_INFO, "Join callback thread OK.");
        }
        hostFuncCallBackThread_.reset(nullptr);
    }
}
void Context::PushContextErrMsg()
{
#ifndef CFG_DEV_PLATFORM_PC
    const std::vector<error_message::ErrorItem> &buf = ErrorManager::GetInstance().GetRawErrorMessages();
    errMsgLock_.lock();
    (void)errMsg_.insert(errMsg_.end(), buf.begin(), buf.end());
    errMsgLock_.unlock();
    RT_LOG(RT_LOG_INFO, "Push error msg");
#endif
}
void Context::PopContextErrMsg()
{
#ifndef CFG_DEV_PLATFORM_PC
    errMsgLock_.lock();
    if (errMsg_.empty()) {
        errMsgLock_.unlock();
        return;
    }
    const std::vector<error_message::ErrorItem> buf = std::move(errMsg_);
    errMsg_.clear();
    errMsgLock_.unlock();
    (void)ErrorManager::GetInstance().SetRawErrorMessages(buf);
    RT_LOG(RT_LOG_INFO, "Pop error msg");
#endif
}
 
void ContextCallBack::Run(const void * const param)
{
    UNUSED(param);
    Api *const apiInstance = Runtime::Instance()->Api_();
    const bool isDisableThread = Runtime::Instance()->GetDisableThread();
    while (callBackThreadRunFlag_ && (!isDisableThread ||
        (isDisableThread && Runtime::Instance()->GetThreadGuard()->GetMonitorStatus()))) {
        apiInstance->ProcessReport(1000, true); // 1000 means 1s, if 1s not get callback cq break up, and try again
    }
}
}  // namespace runtime
}  // namespace cce
