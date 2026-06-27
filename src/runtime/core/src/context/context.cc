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
#include "davinci_kernel_task.h"
#include "maintenance_task.h"
#include "model_graph_task.h"
#include "dump_task.h"
#include <cinttypes>
#include <exception>
#include <queue>
#include <thread>
#include "securec.h"
#include "memcpy_c.hpp"
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
#include "dump_task.h"
#include "osal.hpp"
#include "error_message_manage.hpp"
#include "profiler.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "dvpp_grp.hpp"
#include "task_info.hpp"
#include "profiling_task.h"
#include "stream_task.h"
#include "task_submit.hpp"
#include "task_to_sqe.hpp"
#include "stream_state_callback_manager.hpp"
#if (!defined(CFG_VECTOR_CAST))
#include <algorithm>
#endif
#include "heterogenous.h"
#include "notify_task.h"
#include "capture_model.hpp"
#include "capture_model_utils.hpp"
#include "common_task.h"
#include "random_num_task.h"
#include "memory_task.h"
#include "reduce_task.h"
#include "stream_factory.hpp"
#include "stub_task.hpp"
#include "capture_adapt.hpp"
#include "para_convertor.hpp"
#include "binary_loader.hpp"
#include "buffer_allocator.hpp"
#include "ctrl_sq.hpp"
#include "raw_device.hpp"
#include "cmo_task.h"
#include "aicpu_c.hpp"
#include "kernel_utils.hpp"
#include "stars_arg_manager.hpp"
#include "runtime_handle_guard.h"

namespace cce {
namespace runtime {
namespace {
constexpr uint64_t DEBUG_DEVMEM_LEN = 4096U;
constexpr uint64_t L0A_SIZE = 65536; // 同L0B_SIZE
constexpr uint64_t L0C_SIZE = 262144; // 同UB_SIZE
constexpr uint64_t L1_SIZE = 1048576;
constexpr uint64_t STREAM_ABORT_TIMEOUT = (60UL * RT_MS_PER_S); // 60s
constexpr uint64_t REDUCE_ALIGN_SIZE = 0x4ULL;
constexpr uint64_t REDUCE16_ALIGN_SIZE = 0x2ULL;

bool ShouldRestoreStreamAfterTearDownFailure(
    const Stream * const stm, const bool willDeleteOnTearDown, const bool destroyTaskRecycledStream,
    const bool restoreBoundStream)
{
    if ((stm == nullptr) || destroyTaskRecycledStream) {
        return false;
    }

    if (stm->Model_() != nullptr) {
        return restoreBoundStream;
    }
    return !willDeleteOnTearDown;
}

const char_t *ContextStateToString(const ContextState state)
{
    switch (state) {
        case ContextState::CTX_STATE_NOT_INITIALIZED:
            return "CTX_STATE_NOT_INITIALIZED";
        case ContextState::CTX_STATE_INITIALIZING:
            return "CTX_STATE_INITIALIZING";
        case ContextState::CTX_STATE_ACTIVE:
            return "CTX_STATE_ACTIVE";
        case ContextState::CTX_STATE_FINALIZING:
            return "CTX_STATE_FINALIZING";
        case ContextState::CTX_STATE_FINALIZED:
            return "CTX_STATE_FINALIZED";
        case ContextState::CTX_STATE_DEINITIALIZING:
            return "CTX_STATE_DEINITIALIZING";
        default:
            return "UNKNOWN";
    }
}

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
        COND_RETURN_ERROR(
            (!isValid), RT_ERROR_INVALID_VALUE,
            "The read memory boundary exceeds the hardware memory boundary of the specified memory type,"
            " debugMemType=%d, srcAddr=0x%llx, memLen=%llu.",
            param->debugMemType, param->srcAddr, param->memLen);
    }
    if (param->debugMemType == RT_MEM_TYPE_REGISTER) {
        COND_RETURN_ERROR((param->elementSize == 0U), RT_ERROR_INVALID_VALUE,
            "CheckMemoryParam failed, elementSize cannot be 0, debugMemType=%d, srcAddr=0x%llx, memLen=%llu.",
            param->debugMemType, param->srcAddr, param->memLen);
        COND_RETURN_ERROR(
            (param->memLen % param->elementSize != 0), RT_ERROR_INVALID_VALUE,
            "The read memory length %llu is not aligned with the register bit width %u.", param->memLen,
            param->elementSize);
    }
    return RT_ERROR_NONE;
}

rtError_t CheckCoreParam(const uint32_t coreType, const uint32_t coreId)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((coreType != 0 && coreType != 1), RT_ERROR_INVALID_VALUE, 
        coreType, "[0, " + std::to_string(RT_CORE_TYPE_AIV) + "]");
    if (coreType == 0) {
        COND_RETURN_AND_MSG_OUTER_WITH_PARAM((coreId >= RT_AICORE_NUM_25), RT_ERROR_INVALID_VALUE,
            coreId, "[0, " + std::to_string(RT_AICORE_NUM_25) + ")");
    } else {
        COND_RETURN_AND_MSG_OUTER_WITH_PARAM((coreId >= RT_AIVECTOR_NUM_50), RT_ERROR_INVALID_VALUE,
            coreId, "[0, " + std::to_string(RT_AIVECTOR_NUM_50) + ")");
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

static rtError_t LaunchAicpuKernelForCpuSoImpl(const rtKernelLaunchNames_t * const launchNames,
    const rtArgsEx_t * const argsInfo, Stream * const stm, const uint64_t timeout)
{
    rtError_t error = RT_ERROR_NONE;
    Device *device = stm->Device_();
    TaskInfo submitTask = {};
    rtError_t errorReason;
    AicpuTaskInfo *aicpuTaskInfo = nullptr;
    TaskInfo *tsk = stm->AllocTask(&submitTask, TS_TASK_TYPE_KERNEL_AICORE, errorReason);
    NULL_PTR_RETURN_MSG(tsk, errorReason);
    AicpuTaskInit(tsk, 1, RT_KERNEL_DEFAULT);
    StarsArgLoaderResult result = {};
    error = stm->LoadArgsInfo(argsInfo, false, &result, LoadPolicy::LP_CPU_KRN);
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
    aicpuTaskInfo->timeout = timeout;

    error = stm->Device_()->SubmitTask(tsk);
    COND_PROC_RETURN_ERROR(
        error != RT_ERROR_NONE, error, (void)device->GetTaskFactory()->Recycle(tsk),
        "Failed to submit AI CPU task, retCode=%#x.", error);
    return error;
}

rtError_t LaunchAicpuKernelForCpuSo(const rtKernelLaunchNames_t * const launchNames, const rtArgsEx_t * const argsInfo, Stream * const stm) {
    rtError_t error = RT_ERROR_NONE;
    uint64_t timeout = 0UL;
    // for batchLoadsoFrombuf and deleteCustOp set never timeout
    if (Runtime::Instance()->IsSupportOpTimeoutMs()) {
        timeout = MAX_UINT64_NUM;
    }
    if (stm->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_ALLOC_FROM_STREAM_POOL_DOT_CPUKERNEL)) {
        error = StreamLaunchCpuKernel(launchNames, 1, argsInfo, stm, RT_KERNEL_DEFAULT, timeout);
    } else {
        error = LaunchAicpuKernelForCpuSoImpl(launchNames, argsInfo, stm, timeout);
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
      threadRefCount_(0U),
      isNeedDelete_(false),
      tearDownStatus_(TEARDOWN_NOT_EXECUTE),
      lifecycleState_(ContextState::CTX_STATE_NOT_INITIALIZED),
      deleteScheduled_(false),
      resourcesReleased_(false),
      infMode_(true),
      failureError_(RT_ERROR_NONE),
      lastErr_(ACL_RT_SUCCESS),
      callBackThreadExist_(false),
      userDeviceId_(MAX_UINT32_NUM)
{
    Runtime * const rtInstance = Runtime::Instance();
    if (rtInstance != nullptr && device_ != nullptr) {
        (void)rtInstance->GetUserDevIdByDeviceId(device_->Id_(), &userDeviceId_);
    }
}

Context::~Context()
{
    ReleaseResourcesAfterTearDown();
}

void Context::ReleaseResourcesAfterTearDown()
{
    bool expected = false;
    if (!resourcesReleased_.compare_exchange_strong(expected, true, std::memory_order_acq_rel)) {
        return;
    }
    SetState(ContextState::CTX_STATE_DEINITIALIZING, "ReleaseResourcesAfterTearDownBegin");
    ReleaseModulesAfterTearDown();
    ReleaseOverflowAddrAfterTearDown();
    ResetCallbackAfterTearDown();
    ReleaseDeviceAfterTearDown();
    ResetResourceFieldsAfterTearDown();
    SetState(ContextState::CTX_STATE_NOT_INITIALIZED, "ReleaseResourcesAfterTearDownDone");
}

void Context::ReleaseModulesAfterTearDown()
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
}

void Context::ReleaseOverflowAddrAfterTearDown()
{
    if ((overflowAddr_ != nullptr) && (device_ != nullptr)) {
        const rtError_t error = device_->Driver_()->DevMemFree(overflowAddr_, device_->Id_());
        COND_LOG(error != RT_ERROR_NONE, "overflowAddr DevMemFree failed, retCode=%#x.", error);
    }
    overflowAddr_ = nullptr;
    overflowAddrOffset_ = INVALID_CONTEXT_OVERFLOW_OFFSET;
    sysParamOpt_.clear();
}

void Context::ResetCallbackAfterTearDown()
{
    DestroyContextCallBackThread();
    callBackThreadExist_.Set(false);
    threadCallBack_.callBackThreadRunFlag_ = false;
    callBackThreadId_ = 0U;
}

void Context::ReleaseDeviceAfterTearDown()
{
    if (defaultStream_ != nullptr) {
        defaultStream_->SetContext(nullptr);
    }
    Runtime * const runtime = Runtime::Instance();
    if ((device_ != nullptr) &&
        (IS_SUPPORT_CHIP_FEATURE(device_->GetChipType(), RtOptionalFeatureType::RT_FEATURE_XPU))) {
        runtime->XpuDeviceRelease(device_);
    } else {
        runtime->DeviceRelease(device_, isForceReset_);
    }
}

void Context::ResetResourceFieldsAfterTearDown()
{
    DELETE_O(moduleAllocator_);

    defaultStream_ = nullptr;
    onlineStream_ = nullptr;
    models_.clear();
    streams_.clear();
    device_ = nullptr;
    containAicpuExecuteModel_ = false;
    failureError_.Set(RT_ERROR_NONE);
    lastErr_.Set(ACL_RT_SUCCESS);
    captureMode_ = RT_STREAM_CAPTURE_MODE_MAX;
    (void)memset_s(captureModeRefNum_, sizeof(captureModeRefNum_), 0, sizeof(captureModeRefNum_));
    isForceReset_ = false;
    ctxMode_ = CONTINUE_ON_FAILURE;
    tearDownStatus_.store(TEARDOWN_NOT_EXECUTE, std::memory_order_release);
    deleteScheduled_.store(false, std::memory_order_release);
}

void Context::LogStateTransition(const ContextState fromState, const ContextState toState,
    const char_t * const trigger) const
{
    if (fromState == toState) {
        return;
    }

    const char_t * const triggerName = (trigger == nullptr) ? "unknown" : trigger;
    const uint32_t deviceId = (device_ == nullptr) ? MAX_UINT32_NUM : device_->Id_();
    const uint32_t tsId = (device_ == nullptr) ? MAX_UINT32_NUM : device_->DevGetTsId();
    RT_LOG(RT_LOG_DEBUG,
        "Context state transition, ctx=%p, primary=%d, device_id=%u, ts_id=%u"
        ", trigger=%s, from=%s(%u), to=%s(%u).",
        this, static_cast<int32_t>(isPrimary_), deviceId, tsId,
        triggerName, ContextStateToString(fromState), static_cast<uint32_t>(fromState),
        ContextStateToString(toState), static_cast<uint32_t>(toState));
}

bool Context::TrySwitchState(const ContextState expectedState, const ContextState targetState,
    const char_t * const trigger)
{
    ContextState expected = expectedState;
    const bool switched = lifecycleState_.compare_exchange_strong(expected, targetState, std::memory_order_acq_rel);
    if (switched) {
        LogStateTransition(expectedState, targetState, trigger);
    }
    return switched;
}

void Context::SetState(const ContextState state, const char_t * const trigger)
{
    const ContextState oldState = lifecycleState_.exchange(state, std::memory_order_acq_rel);
    LogStateTransition(oldState, state, trigger);
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
    tearDownStatus_.store(TEARDOWN_NOT_EXECUTE, std::memory_order_release);
    moduleAllocator_ = new (std::nothrow) ObjAllocator<Module *>(DEFAULT_PROGRAM_NUMBER,
                                                                 Runtime::maxProgramNum_,
                                                                 true);
    COND_RETURN_AND_MSG_OUTER(
        moduleAllocator_ == nullptr, RT_ERROR_MODULE_NEW, ErrorCode::EE1013, sizeof(ObjAllocator<Module*>), "new");

    const rtError_t error = moduleAllocator_->Init();
    ERROR_RETURN_MSG_INNER(error, "Failed to init moduleAllocator_, retCode=%#x.", error);

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
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, sizeof(Stream), "new");
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

rtError_t Context::SetOverflowAddr()
{
    // set overflow addr
    rtError_t error = RT_ERROR_NONE;
    if (overflowAddr_ == nullptr) {
        const rtMemType_t memType =
            (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TS_MEM_4G_SPACE_FOR_OVERFLOW)) ?
                RT_MEMORY_TS_4G :
                RT_MEMORY_DEFAULT;
        error = device_->Driver_()->DevMemAlloc(&overflowAddr_, OVERFLOW_ADDR_MAX_SIZE, memType, device_->Id_());
        if (unlikely(error == RT_ERROR_DRV_OUT_MEMORY)) {
            RT_LOG(RT_LOG_ERROR, "Failed to allocate overflow address device memory, retCode=%#x.", error);
        } else {
            ERROR_RETURN(error, "Failed to allocate overflow address device memory, retCode=%#x.", error);
            if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TS_MEM_4G_SPACE_FOR_OVERFLOW)) {
                error = device_->Driver_()->MemSetSync(overflowAddr_, OVERFLOW_ADDR_MAX_SIZE, 0U, OVERFLOW_ADDR_MAX_SIZE);
                COND_RETURN_ERROR(
                    error != RT_ERROR_NONE, error,
                    "Failed to set overflow address. Reason: MemSetSync failed, size=%#" PRIx64 "(bytes), "
                    "retCode=%#x.",
                    static_cast<uint64_t>(OVERFLOW_ADDR_MAX_SIZE), static_cast<uint32_t>(error));
                error = device_->Driver_()->MemAddressTranslate(
                    static_cast<int32_t>(device_->Id_()), RtPtrToValue<void*>(overflowAddr_), &overflowAddrOffset_);
                ERROR_RETURN(error, "Failed to translate overflow address, retCode=%#x.", static_cast<uint32_t>(error));
            }
        }
    }
    return error;
}

rtError_t Context::Setup()
{
    rtError_t error;
    const rtChipType_t chipType = device_->GetChipType();
    SetState(ContextState::CTX_STATE_INITIALIZING, "ContextSetupBegin");

    error = Init();
    ERROR_RETURN(error, "Failed to init context, retCode=%#x.", error);

    error = SetOverflowAddr();
    COND_RETURN_ERROR(error != RT_ERROR_NONE && error != RT_ERROR_DRV_OUT_MEMORY, error,
        "Failed to set overflow address, retCode=%#x.", error);

    if (isPrimary_) {
        defaultStream_ = device_->PrimaryStream_();
        COND_RETURN_ERROR_MSG_INNER(
            defaultStream_ == nullptr, RT_ERROR_CONTEXT_DEFAULT_STREAM_NULL,
            "Failed to set up context because default stream is null.");
        Stream * ctrlSQStream = device_->GetCtrlSQStream(nullptr);
        if (ctrlSQStream != nullptr) {
            ctrlSQStream->SetContext(this);
        }
    } else {
        uint32_t stmFlag = RT_STREAM_PRIMARY_DEFAULT;
        if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
            stmFlag = RT_STREAM_PRIMARY_DEFAULT | RT_STREAM_FAST_LAUNCH | RT_STREAM_FAST_SYNC;
        }
        defaultStream_ = StreamFactory::CreateStream(device_, 0U, stmFlag);
        COND_RETURN_AND_MSG_OUTER(defaultStream_ == nullptr, RT_ERROR_STREAM_NEW, ErrorCode::EE1013, sizeof(Stream), "new");
        RT_LOG(RT_LOG_INFO, "New defaultStream_ ok, Runtime_alloc_size %zu, stream_id=%d.", sizeof(Stream), defaultStream_->Id_());

        error = defaultStream_->Setup();
        ERROR_PROC_RETURN_MSG_INNER(
            error, DeleteStream(defaultStream_);, "Failed to set up default stream, retCode=%#x.", error);
    }

    defaultStream_->SetContext(this);

    // need sync for get tsch version value succ
    const bool syncFlag = ((defaultStream_->Flags() & RT_STREAM_PRIMARY_FIRST_DEFAULT) != 0U) && (!(device_->IsStarsPlatform()));
    if (syncFlag) {
        error = defaultStream_->Synchronize(true);
        COND_RETURN_ERROR_MSG_INNER(
            error != RT_ERROR_NONE, error, "Failed to synchronize default stream, retCode=%#x.", error);
    }

    error = OnlineStreamInit(chipType);
    if (error == RT_ERROR_NONE) {
        SetState(ContextState::CTX_STATE_ACTIVE, "ContextSetupSuccess");
    }
    return error;
}

rtError_t Context::TearDown()
{
    (void)TrySwitchState(ContextState::CTX_STATE_ACTIVE, ContextState::CTX_STATE_FINALIZING, "ContextTearDown");
    const Stream * const defaultStream = defaultStream_;
    NULL_PTR_RETURN_MSG(defaultStream, RT_ERROR_CONTEXT_DEFAULT_STREAM_NULL);

    TearDownModelsOnContextTearDown();

    // Restored owner streams still point to this context. Return the error so ContextDestroy keeps the context alive
    // for retry instead of deleting it with valid child stream handles.
    const rtError_t ownerStreamError = TearDownOwnedStreamsOnContextTearDown();
    if (ownerStreamError != RT_ERROR_NONE) {
        return ownerStreamError;
    }

    rtError_t firstError = TearDownContextStream(onlineStream_, "online");
    if (!isPrimary_) {
        const rtError_t error = TearDownContextStream(defaultStream_, "default");
        if ((firstError == RT_ERROR_NONE) && (error != RT_ERROR_NONE)) {
            firstError = error;
        }
    }
    if (InnerThreadLocalContainer::GetCurCtx() == this) {
        InnerThreadLocalContainer::SetCurCtx(nullptr);
    }
    return firstError;
}

rtError_t Context::TearDownForFinalRelease()
{
    TearDownModelsOnContextTearDown();

    rtError_t firstError = TearDownOwnedStreamsForPrimaryRelease();
    const rtError_t onlineError = TearDownContextStreamForPrimaryRelease(onlineStream_, "online");
    if ((firstError == RT_ERROR_NONE) && (onlineError != RT_ERROR_NONE)) {
        firstError = onlineError;
    }

    if (!isPrimary_) {
        if (defaultStream_ == nullptr) {
            RT_LOG(RT_LOG_ERROR, "Non-primary context final release with null default stream.");
            if (firstError == RT_ERROR_NONE) {
                firstError = RT_ERROR_CONTEXT_DEFAULT_STREAM_NULL;
            }
        }
        const rtError_t defaultError = TearDownContextStreamForPrimaryRelease(defaultStream_, "default");
        if ((firstError == RT_ERROR_NONE) && (defaultError != RT_ERROR_NONE)) {
            firstError = defaultError;
        }
    } else if (defaultStream_ == nullptr) {
        RT_LOG(RT_LOG_WARNING, "Primary context final release with null default stream.");
    }

    if (InnerThreadLocalContainer::GetCurCtx() == this) {
        InnerThreadLocalContainer::SetCurCtx(nullptr);
    }
    return firstError;
}

void Context::TearDownModelsOnContextTearDown()
{
    std::list<Model *> modelsToDelete;
    modelLock_.Lock();
    for (Model *tdModel : models_) {
        PrepareModelForDelete(tdModel);
    }
    modelsToDelete.swap(models_);
    modelLock_.Unlock();

    for (Model *tdModel : modelsToDelete) {
        DeleteModelOnContextTearDown(tdModel);
    }
}

rtError_t Context::TearDownOwnedStreamsOnContextTearDown()
{
    std::list<Stream *> streamsToDelete = TakeOwnedStreamsForTearDown();
    rtError_t streamTearDownError = RT_ERROR_NONE;
    for (Stream * const tdStream : streamsToDelete) {
        const int32_t streamId = tdStream->Id_();
        const bool willDeleteOnTearDown = WillStreamBeDeletedOnTearDown(tdStream);
        RT_LOG(RT_LOG_INFO, "Tear down stream abandon, stream_id=%d.", tdStream->Id_());
        ResetEmbeddedInnerHandle<Stream>(tdStream);
        bool destroyTaskRecycledStream = false;
        const rtError_t streamError = TearDownOwnedStream(tdStream, true, &destroyTaskRecycledStream);
        bool restoredStream = false;
        if ((streamError != RT_ERROR_NONE) &&
            ShouldRestoreStreamAfterTearDownFailure(tdStream, willDeleteOnTearDown, destroyTaskRecycledStream, false)) {
            InitEmbeddedInnerHandle<Stream>(tdStream);
            RestoreOwnedStream(tdStream);
            restoredStream = true;
        }
        if (streamError != RT_ERROR_NONE) {
            if (restoredStream && (streamTearDownError == RT_ERROR_NONE)) {
                streamTearDownError = streamError;
            }
            RT_LOG(RT_LOG_ERROR, "Failed to tear down abandoned stream, stream_id=%d, retCode=%#x.",
                streamId, static_cast<uint32_t>(streamError));
        }
    }
    return streamTearDownError;
}

rtError_t Context::TearDownOwnedStreamsForPrimaryRelease()
{
    std::list<Stream *> streamsToDelete = TakeOwnedStreamsForTearDown();
    rtError_t firstError = RT_ERROR_NONE;
    for (Stream *tdStream : streamsToDelete) {
        const int32_t streamId = tdStream->Id_();
        RT_LOG(RT_LOG_INFO, "Tear down stream abandon during final release, stream_id=%d.", tdStream->Id_());
        const rtError_t error = TearDownStreamForPrimaryRelease(tdStream);
        if (error != RT_ERROR_NONE) {
            if (tdStream != nullptr) {
                RestoreOwnedStream(tdStream);
            }
            RT_LOG(RT_LOG_ERROR, "Failed to tear down abandoned stream during final release, stream_id=%d, "
                "retCode=%#x.", streamId, static_cast<uint32_t>(error));
            if (firstError == RT_ERROR_NONE) {
                firstError = error;
            }
        }
    }
    return firstError;
}

rtError_t Context::TearDownContextStream(Stream *&stream, const char * const streamName) const
{
    if (stream == nullptr) {
        return RT_ERROR_NONE;
    }

    Stream * const tdStream = stream;
    const bool willDeleteOnTearDown = WillStreamBeDeletedOnTearDown(tdStream);
    bool destroyTaskRecycledStream = false;
    const rtError_t error = TearDownOwnedStream(tdStream, true, &destroyTaskRecycledStream);
    if (error != RT_ERROR_NONE) {
        if (willDeleteOnTearDown || destroyTaskRecycledStream) {
            stream = nullptr;
        }
        RT_LOG(RT_LOG_ERROR, "Failed to tear down %s stream, retCode=%#x.", streamName, error);
        return error;
    }

    stream = nullptr;
    return RT_ERROR_NONE;
}

rtError_t Context::TearDownContextStreamForPrimaryRelease(Stream *&stream, const char * const streamName) const
{
    if (stream == nullptr) {
        return RT_ERROR_NONE;
    }

    Stream *tdStream = stream;
    const rtError_t error = TearDownStreamForPrimaryRelease(tdStream);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Failed to tear down %s stream during final release, retCode=%#x.", streamName, error);
        stream = tdStream;
        return error;
    }

    stream = nullptr;
    return error;
}

rtError_t Context::TearDownStreamForPrimaryRelease(Stream *&stream, bool flag) const
{
    NULL_PTR_RETURN_MSG(stream, RT_ERROR_STREAM_NULL);

    Stream *tdStream = stream;
    try {
        FlushPendingTasksBeforeStreamTearDown(tdStream);
    } catch (const std::exception &e) {
        RT_LOG(RT_LOG_WARNING, "Flush pending stream tasks exception caught during final release, reason=%s.", e.what());
        return RT_ERROR_STREAM_INVALID;
    } catch (...) {
        RT_LOG(RT_LOG_WARNING, "Unknown flush pending stream tasks exception caught during final release.");
        return RT_ERROR_STREAM_INVALID;
    }
    ResetEmbeddedInnerHandle<Stream>(tdStream);
    if (tdStream->NeedDelSelfStream()) {
        const rtError_t deleteError = DeleteStreamNoThrowForPrimaryRelease(tdStream);
        stream = tdStream;
        return deleteError;
    }

    if (!Runtime::Instance()->IsExiting()) {
        StreamStateCallbackManager::Instance().Notify(tdStream, false);
    }
    bool destroyTaskRecycledStream = false;
    tdStream->SetDestroyTaskRecycledOnTearDownOutput(&destroyTaskRecycledStream);
    const rtError_t error = tdStream->TearDown(false, flag);
    tdStream->ClearDestroyTaskRecycledOnTearDownOutput();
    if (error != RT_ERROR_NONE) {
        return HandlePrimaryReleaseStreamTearDownFailure(stream, tdStream, error, destroyTaskRecycledStream);
    }

    const Runtime * const rtInstance = Runtime::Instance();
    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_STREAM_DELETE_FORCE) ||
        (rtInstance->GetDisableThread())) {
        const rtError_t deleteError = DeleteStreamNoThrowForPrimaryRelease(tdStream);
        if (deleteError != RT_ERROR_NONE) {
            stream = tdStream;
            return deleteError;
        }
    }
    stream = tdStream;
    return RT_ERROR_NONE;
}

rtError_t Context::HandlePrimaryReleaseStreamTearDownFailure(Stream *&stream, Stream *tdStream, rtError_t error,
    bool destroyTaskRecycledStream) const
{
    RT_LOG(RT_LOG_ERROR, "Failed to tear down stream during final release, retCode=%#x.",
        static_cast<uint32_t>(error));
    if (destroyTaskRecycledStream) {
        RT_LOG(RT_LOG_WARNING, "Skip restoring stream after tear down failure during final release because destroy "
            "task recycle has taken ownership.");
        stream = nullptr;
        return error;
    }

    if (tdStream->GetPendingNum() == 0U) {
        const rtError_t deleteError = DeleteStreamNoThrowForPrimaryRelease(tdStream);
        stream = tdStream;
        if (deleteError != RT_ERROR_NONE) {
            return deleteError;
        }
        return error;
    }

    InitEmbeddedInnerHandle<Stream>(tdStream);
    RT_LOG(RT_LOG_WARNING, "Skip deleting stream after tear down failure during final release because pending tasks "
        "still reference it. The stream is restored to its owner for retry, stream_id=%d, pending_num=%u.",
        tdStream->Id_(), tdStream->GetPendingNum());
    stream = tdStream;
    return error;
}

rtError_t Context::DeleteStreamNoThrowForPrimaryRelease(Stream *&stream) const
{
    try {
        DeleteStream(stream);
        return RT_ERROR_NONE;
    } catch (const std::exception &e) {
        RT_LOG(RT_LOG_WARNING, "Delete stream exception caught during final release, reason=%s.", e.what());
        stream = nullptr;
        return RT_ERROR_STREAM_INVALID;
    } catch (...) {
        RT_LOG(RT_LOG_WARNING, "Unknown delete stream exception caught during final release.");
        stream = nullptr;
        return RT_ERROR_STREAM_INVALID;
    }
}

void Context::PrepareModelForDelete(Model *mdl) const
{
    if (mdl == nullptr) {
        return;
    }

    ResetEmbeddedInnerHandle<Model>(mdl);
}

void Context::DeleteModelOnContextTearDown(Model *mdl) const
{
    if (mdl == nullptr) {
        return;
    }

    const uint32_t modelId = mdl->Id_();
    RT_LOG(RT_LOG_INFO, "Tear down model abandon, model_id=%u.", modelId);
    const rtError_t error = mdl->TearDown();
    COND_LOG_ERROR(error != RT_ERROR_NONE, "Failed to tear down abandoned model, model_id=%u, retCode=%#x.",
        modelId, static_cast<uint32_t>(error));
    // Context teardown keeps the historical best-effort cleanup policy: log TearDown failure but still delete the
    // abandoned model object to avoid leaving an ownerless host object.
    delete mdl;
}

void Context::RestoreOwnedStream(Stream * const stm)
{
    if (stm == nullptr) {
        return;
    }

    std::unique_lock<std::mutex> taskLock(streamLock_);
    for (const Stream * const ownedStream : streams_) {
        if (ownedStream == stm) {
            return;
        }
    }
    streams_.push_back(stm);
}

std::list<Stream *> Context::TakeOwnedStreamsForTearDown()
{
    std::list<Stream *> streamsToDelete;
    std::unique_lock<std::mutex> taskLock(streamLock_);
    streamsToDelete.swap(streams_);
    return streamsToDelete;
}

void Context::FlushPendingTasksBeforeStreamTearDown(Stream *stm) const
{
    for (uint32_t type = 0U; type < RT_HOST_TASK_TYPE_MAX; type++) {
        if (!(stm->IsPendingListEmpty(type))) {
            (void)stm->ExecPendingList(type);
        }
    }
}

rtError_t Context::TearDownStreamAndFinalize(Stream *stm, bool flag, bool *destroyTaskRecycledStream) const
{
    if (!Runtime::Instance()->IsExiting()) {
        StreamStateCallbackManager::Instance().Notify(stm, false);
    }
    if (destroyTaskRecycledStream != nullptr) {
        stm->SetDestroyTaskRecycledOnTearDownOutput(destroyTaskRecycledStream);
    }
    const rtError_t error = stm->TearDown(false, flag);
    if (error != RT_ERROR_NONE) {
        if ((destroyTaskRecycledStream == nullptr) || !(*destroyTaskRecycledStream)) {
            stm->ClearDestroyTaskRecycledOnTearDownOutput();
        }
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Failed to tear down stream, retCode=%#x.",
            static_cast<uint32_t>(error));
    } else {
        stm->ClearDestroyTaskRecycledOnTearDownOutput();
    }

    const Runtime * const rtInstance = Runtime::Instance();
    const bool isRecycledByDestroyTask = (destroyTaskRecycledStream != nullptr) && (*destroyTaskRecycledStream);
    if (!isRecycledByDestroyTask && (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_STREAM_DELETE_FORCE) ||
        (rtInstance->GetDisableThread()))) {
        DeleteStream(stm);
    }
    return error;
}

bool Context::WillStreamBeDeletedOnTearDown(const Stream *stm) const
{
    if (stm == nullptr) {
        return false;
    }

    const Runtime * const rtInstance = Runtime::Instance();
    return stm->NeedDelSelfStream() ||
        device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_STREAM_DELETE_FORCE) ||
        ((rtInstance != nullptr) && rtInstance->GetDisableThread());
}

rtError_t Context::TearDownOwnedStream(Stream *stm, bool flag, bool *destroyTaskRecycledStream) const
{
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);

    COND_RETURN_ERROR_MSG_INNER(
        stm->Model_() != nullptr, RT_ERROR_STREAM_MODEL,
        "Failed to tear down stream because stream is bound, stream_id=%d, model_id=%u, retCode=%#x.", stm->Id_(),
        stm->Model_()->Id_(), RT_ERROR_STREAM_INVALID);
    FlushPendingTasksBeforeStreamTearDown(stm);
    if (stm->NeedDelSelfStream()) {
        DeleteStream(stm);
        return RT_ERROR_NONE;
    }
    return TearDownStreamAndFinalize(stm, flag, destroyTaskRecycledStream);
}

rtError_t Context::TearDownStream(Stream *stm, bool flag) const
{
    bool destroyTaskRecycledStream = false;
    return TearDownOwnedStream(stm, flag, &destroyTaskRecycledStream);
}

rtError_t Context::SyncStreamsWithTimeout(const std::list<Stream *> &streams, int32_t timeout, const mmTimespec start) const
{
    rtError_t error;
    rtError_t firstError = RT_ERROR_NONE;
    int32_t remainTime = timeout;
    for (const auto &syncStream : streams) {
        COND_PROC(syncStream->IsSyncFinished() && (GetCtxMode() == ABORT_ON_FAILURE), continue;);
        error = syncStream->Synchronize(false, remainTime);
        COND_RETURN_ERROR_MSG_INNER(IsProcessTimeout(start, timeout, &remainTime), RT_ERROR_STREAM_SYNC_TIMEOUT,
            "Sync stream timeout, stream_id=%d.", syncStream->Id_());

        if (unlikely(error != RT_ERROR_NONE)) {
            RT_LOG(RT_LOG_ERROR, "Failed to synchronize stream, stream_id=%d, retCode=%#x.", syncStream->Id_(), error);
            if (GetCtxMode() != CONTINUE_ON_FAILURE) {
                return error;
            } else if (firstError == RT_ERROR_NONE) {
                firstError = error;
            }
        }
    }
    if (!defaultStream_->IsSyncFinished()) {
        error = defaultStream_->Synchronize(false, remainTime);
        if (unlikely((error != RT_ERROR_NONE) && (firstError == RT_ERROR_NONE))) {
            firstError = error;
            RT_LOG_INNER_MSG(RT_LOG_ERROR, "Failed to synchronize default stream, retCode=%#x.", error);
        }
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
                RT_LOG(
                    RT_LOG_ERROR,
                    "Failed to synchronize stream because timeout, timeout=%dms, stream_id=%d, "
                    "retCode=%#x.",
                    timeout, syncStream->Id_(), error);
                return RT_ERROR_STREAM_SYNC_TIMEOUT;
            } else if ((error != RT_ERROR_NONE) && (firstError == RT_ERROR_NONE)) {
                firstError = error;
                RT_LOG(
                    RT_LOG_ERROR, "Failed to synchronize stream, stream_id=%d, retCode=%#x.", syncStream->Id_(), error);
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
    const mmTimespec startTime = mmGetTickCount();
    const Stream *defaultStream = defaultStream_;
    NULL_PTR_RETURN_MSG(defaultStream, RT_ERROR_CONTEXT_DEFAULT_STREAM_NULL);

    std::list<Stream *> syncStreams;
    const std::unique_lock<std::mutex> taskLock(streamLock_);
    for (const auto &syncStream : streams_) {
        if (IsStreamNotSync(syncStream->Flags())) {
            continue;
        }
        COND_RETURN_ERROR(syncStream->IsCapturing(),
            RT_ERROR_STREAM_CAPTURED, "Not allow to synchronize captured-stream, device_id=%u, stream_id=%d.",
            device_->Id_(), syncStream->Id_());
        // CONTINUE_ON_FAILURE need sync to get error code.
        COND_PROC(syncStream->IsSyncFinished() && (GetCtxMode() == ABORT_ON_FAILURE), continue;);
        syncStreams.push_back(syncStream);
    }
    // TaskReclaim
    (void)TaskReclaimforSyncDevice(startTime, timeout);
    const rtError_t error = CheckStatus();
    COND_PROC_RETURN_ERROR(error != RT_ERROR_NONE, error, PopContextErrMsg();,
        "context is abort, status=%#x.", static_cast<uint32_t>(error));
    return SyncStreamsWithTimeout(syncStreams, timeout, startTime);
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
    ERROR_GOTO_MSG_INNER(
        error, ERROR_RECYCLE,
        "Failed to init data dump info load task, stream_id=%d, task_id=%" PRIu16 ", retCode=%#x.", streamId,
        rtDumpLoadInfoTask->id, error);

    error = device_->SubmitTask(rtDumpLoadInfoTask, taskGenCallback_);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit data dump info load task, retCode=%#x.", error);

    error = dftStm->Synchronize();
    ERROR_RETURN_MSG_INNER(error, "Failed to synchronize data dump info load task, retCode=%#x.", error);

    return error;

ERROR_RECYCLE:
        dftStm->SetErrCode(0U);
        (void)device_->GetTaskFactory()->Recycle(rtDumpLoadInfoTask);
        return error;
}

rtError_t Context::AicpuInfoLoad(const void * const aicpuInfo, const uint32_t length)
{
    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        RtAicpuInfoLoadParam param = {aicpuInfo, length};
        return device_->GetCtrlSQ().SendAicpuInfoLoadMsg(RtCtrlMsgType::RT_CTRL_MSG_AICPU_INFOLOAD, param, taskGenCallback_);
    }
    Stream * const dftStm = DefaultStream_();
    NULL_PTR_RETURN_MSG(dftStm, RT_ERROR_STREAM_NULL);

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *rtAicpuLoadInfoTask = dftStm->AllocTask(&submitTask, TS_TASK_TYPE_AICPU_INFO_LOAD, errorReason);
    NULL_PTR_RETURN_MSG(rtAicpuLoadInfoTask, errorReason);

    const int32_t streamId = dftStm->Id_();
    rtError_t error = AicpuInfoLoadTaskInit(rtAicpuLoadInfoTask, aicpuInfo, length);
    ERROR_GOTO_MSG_INNER(
        error, ERROR_RECYCLE, "Failed to init AI CPU info load task, stream_id=%d, task_id=%" PRIu16 ", retCode=%#x.",
        streamId, rtAicpuLoadInfoTask->id, error);

    error = device_->SubmitTask(rtAicpuLoadInfoTask, taskGenCallback_);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit AI CPU info load task, retCode=%#x.", error);

    error = dftStm->Synchronize();
    ERROR_RETURN_MSG_INNER(error, "Failed to synchronize AI CPU info load task, retCode=%#x.", error);

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
        *streamId = static_cast<uint32_t>(device_->GetCtrlSQ().GetStream()->Id_());
        ERROR_RETURN(error, "Failed to send debug register message, retCode=%#x.", error);
    } else {
        TaskInfo submitTask = {};
        rtError_t errorReason;
        rtDbgRegTask = dftStm->AllocTask(&submitTask, TS_TASK_TYPE_DEBUG_REGISTER, errorReason);
        NULL_PTR_RETURN_MSG(rtDbgRegTask, errorReason);

        error = DebugRegisterTaskInit(rtDbgRegTask, mdl->Id_(), addr, flag);
        ERROR_GOTO_MSG_INNER(
            error, ERROR_RECYCLE, "Failed to init debug register task, stream_id=%d, task_id=%" PRIu16 ", retCode=%#x.",
            *streamId, rtDbgRegTask->id, error);

        error = device_->SubmitTask(rtDbgRegTask, taskGenCallback_, &flipTaskId);
        *taskId = flipTaskId;
        ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit debug register task, retCode=%#x.", error);

        error = dftStm->Synchronize();
        ERROR_RETURN_MSG_INNER(error, "Failed to synchronize debug register task, retCode=%#x.", error);
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
        ERROR_RETURN(error, "Failed to send debug unregister message, retCode=%#x.", error);
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
    ERROR_GOTO_MSG_INNER(
        err, ERROR_RECYCLE,
        "Failed to init debug register for stream task, stream_id=%d, debug_stream_id=%d, task_id=%" PRIu16
        ", retCode=%#x.",
        *streamId, debugStream->Id_(), rtDbgRegStreamTask->id, err);

    err = device_->SubmitTask(rtDbgRegStreamTask, taskGenCallback_);
    ERROR_GOTO_MSG_INNER(err, ERROR_RECYCLE, "Failed to submit debug register for stream task, retCode=%#x.", err);

    *taskId = GetFlipTaskId(rtDbgRegStreamTask->id, rtDbgRegStreamTask->flipNum);

    if (device_->IsStarsPlatform() != true) {
        err = setStm->Synchronize();
        ERROR_RETURN_MSG_INNER(err, "Failed to synchronize debug register for stream task, retCode=%#x.", err);
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
    ERROR_GOTO_MSG_INNER(err, ERROR_RECYCLE, "Failed to submit debug unregister for stream task, retCode=%#x.", err);

    if (device_->IsStarsPlatform() != true) {
        err = setStm->Synchronize();
        ERROR_RETURN_MSG_INNER(err, "Failed to synchronize debug unregister for stream task, retCode=%#x.", err);
    }
    debugStream->SetDebugRegister(false);

    return err;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtDbgUnregStreamTask);
    return RT_ERROR_DEBUG_UNREGISTER_FAILED;
}

rtError_t Context::GetDevArgsAddr(Stream * const stm, const rtArgsEx_t * const argsInfo, void ** const devArgsAddr,
    void ** const argsHandle) const
{
    StarsArgLoaderResult result = {};
    const rtError_t error = stm->LoadArgsInfo(argsInfo, false, &result, LoadPolicy::LP_NO_MIX);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Failed to load args, stream_id=%d,"
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

rtError_t Context::StreamCreate(const uint32_t prio, const uint32_t flag, Stream ** const result, DvppGrp *grp,
    const bool isSoftWareSqEnable, const bool isAutoSplitEnable)
{
    rtError_t error = RT_ERROR_NONE;
    if ((flag & RT_STREAM_CP_PROCESS_USE) != 0U) {
        const bool isMc2SupportHccl = CheckSupportMC2Feature(device_);
        if (!isMc2SupportHccl) {
            RT_LOG(RT_LOG_WARNING, "Current ts version[%u] does not support creating coprocessor streams.",
                device_->GetTschVersion());
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
    }

    Stream *newStream = StreamFactory::CreateStream(device_, prio, flag, grp);
    COND_GOTO_MSG_OUTER(
        newStream == nullptr, ERROR_RETURN, error, RT_ERROR_STREAM_NEW, ErrorCode::EE1013, sizeof(Stream), "new");

    if ((flag & RT_STREAM_FAST_SYNC) != 0U) {
        newStream->SetStreamFastSync(true);
    }

    newStream->SetContext(this);
    if (isAutoSplitEnable) {
        newStream->SetAutoSplitSq(true);
        error = newStream->SetupForAutoSplit();
        RT_LOG(RT_LOG_INFO, "Stream setup with auto split, stream_id=%d, prio=%u, flag=%u.",
            newStream->Id_(), prio, flag);
    } else if (isSoftWareSqEnable) {
        newStream->SetSoftWareSqEnable();
        error = newStream->SetupWithoutBindSq();
        RT_LOG(RT_LOG_INFO, "Stream setup without bind sq, stream_id=%d, prio=%u, flag=%u.",
            newStream->Id_(), prio, flag);
    } else {
        error = newStream->Setup();
        RT_LOG(RT_LOG_INFO, "Stream setup normal, stream_id=%d, prio=%u, flag=%u.",
            newStream->Id_(), prio, flag);
    }

    ERROR_GOTO(error, ERROR_RECYCLE, "Setup stream failed, retCode=%#x.", error);
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
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);

    const bool willDeleteOnTearDown = WillStreamBeDeletedOnTearDown(stm);
    bool wasOwned = false;
    std::unique_lock<std::mutex> taskLock(streamLock_);
    for (auto it = streams_.begin(); it != streams_.end();) {
        if (*it == stm) {
            it = streams_.erase(it);
            wasOwned = true;
        } else {
            ++it;
        }
    }
    taskLock.unlock();
    ResetEmbeddedInnerHandle<Stream>(stm);
    bool destroyTaskRecycledStream = false;
    const rtError_t error = TearDownOwnedStream(stm, flag, &destroyTaskRecycledStream);
    if ((error != RT_ERROR_NONE) &&
        ShouldRestoreStreamAfterTearDownFailure(stm, willDeleteOnTearDown, destroyTaskRecycledStream, true)) {
        InitEmbeddedInnerHandle<Stream>(stm);
        if (wasOwned) {
            RestoreOwnedStream(stm);
        } else {
            RT_LOG(RT_LOG_WARNING, "Stream destroy failed after stream was not found in owner list, stream_id=%d, "
                "retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
        }
    }
    return error;
}

rtError_t Context::CreateAutoSplitSlaveStream(Stream * const masterStm, Stream **newSlaveStream)
{
    COND_RETURN_ERROR(masterStm == nullptr, RT_ERROR_INVALID_VALUE, "Master stream is null");
    COND_RETURN_ERROR(newSlaveStream == nullptr, RT_ERROR_INVALID_VALUE, "Output stream pointer is null");
    RT_LOG(RT_LOG_DEBUG, "Enter CreateAutoSplitSlaveStream, master_stream_id=%d",
        masterStm->GetExposedStreamId());

    Stream *slaveStream = nullptr;
    rtError_t error = StreamCreate(masterStm->Priority(), masterStm->Flags(), &slaveStream, nullptr, false, true);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Failed to create slave stream, retCode=%#x.", error);

    // 设置 slave stream 的 AutoSplitCtx 关联信息
    AutoSplitSqContext *slaveCtx = slaveStream->GetAutoSplitCtx();
    slaveCtx->exposedStreamId = masterStm->Id_();
    slaveStream->SetAutoSplitSq(true);
    slaveStream->SetIsSlaveStream(true);
    // 绑定 slave stream 到 master stream 所在的 model
    Model *model = masterStm->Model_();
    if (model == nullptr) {
        (void)StreamDestroy(slaveStream, true);
        RT_LOG(RT_LOG_ERROR, "Master stream has no model, master_stream_id=%d, slave_stream_id=%d.",
            masterStm->GetExposedStreamId(), slaveStream->Id_());
        return RT_ERROR_INVALID_VALUE;
    }
    
    error = ModelAddStream(model, slaveStream, RT_INVALID_FLAG);
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "Failed to add stream to model, master_stream_id=%d, slave_stream_id=%d, retCode=%#x.",
            masterStm->GetExposedStreamId(), slaveStream->Id_(), error);
        (void)StreamDestroy(slaveStream, true);
        return error;
    }

    *newSlaveStream = slaveStream;
    RT_LOG(RT_LOG_INFO, "Created slave stream, master_stream_id=%d, slave_stream_id=%d",
        masterStm->GetExposedStreamId(), slaveStream->Id_());
    return RT_ERROR_NONE;
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
    ERROR_RETURN(error, "Failed to restore stream id %d, retCode=%#x.", defaultStream_->Id_(), error);
    for (Stream *s : streams_) {
        error = s->Restore();
        ERROR_RETURN(error, "Failed to restore stream id %d, retCode=%#x.", s->Id_(), error);
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

Module *Context::GetModuleWithoutCreate(const Program * const prog)
{
    const uint32_t progId = prog->Id_();
    if (progId >= Runtime::maxProgramNum_) {
        return nullptr;
    }

    const std::unique_lock<std::mutex> taskLock(moduleLock_);
    Module ** const module = moduleAllocator_->GetDataToItemApplied(progId);
    if (module == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Get module pool NULL by id:%u", progId);
        return nullptr;
    }
    return *module;
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
    // For multi-thread: block user access before waiting for in-use refs to drain.
    TearDownStatus previousStatus = TEARDOWN_NOT_EXECUTE;
    if (!tearDownStatus_.compare_exchange_strong(previousStatus, TEARDOWN_WORKING)) {
        previousStatus = TEARDOWN_ERROR;
        if (!tearDownStatus_.compare_exchange_strong(previousStatus, TEARDOWN_WORKING)) {
            return false;
        }
    }

    if (!TrySwitchState(ContextState::CTX_STATE_ACTIVE, ContextState::CTX_STATE_FINALIZING, "TearDownIsCanExecute")) {
        tearDownStatus_.store(previousStatus, std::memory_order_release);
        return false;
    }
    return true;
}

bool Context::TryDeleteIfNeeded()
{
    if (isPrimary_ || !GetContextIsNeedDelStatus()) {
        return false;
    }

    if (GetThreadRefCount() != 0U) {
        return false;
    }

    bool expected = false;
    if (!deleteScheduled_.compare_exchange_strong(expected, true, std::memory_order_acq_rel)) {
        return false;
    }

    SetState(ContextState::CTX_STATE_DEINITIALIZING, "TryDeleteIfNeeded");
    (void)ContextManage::RemoveContextFromSet(this);
    delete this;
    return true;
}

rtError_t Context::ModelCreate(Model ** const result, ModelType type)
{
    rtError_t error = RT_ERROR_NONE;
    const bool isHostSupport = device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_MODEL_PERSISTENT_STREAM_UNLIMITED_DEPTH);
    const bool isTsSupport = device_->CheckFeatureSupport(TS_FEATURE_SOFTWARE_SQ_ENABLE);
    const bool isDrvSupport = NpuDriver::CheckIsSupportFeature(device_->Id_(), FEATURE_TRSDRV_SQ_SUPPORT_DYNAMIC_BIND);
    Model *newModel = (type == RT_MODEL_CAPTURE_MODEL) ?
        new (std::nothrow) CaptureModel() :
        new (std::nothrow) Model();
    COND_GOTO_MSG_OUTER(
        newModel == nullptr, ERROR_RETURN, error, RT_ERROR_MODEL_NEW, ErrorCode::EE1013,
        (type == RT_MODEL_CAPTURE_MODEL) ? sizeof(CaptureModel) : sizeof(Model), "new");

    error = newModel->Setup(this);
    ERROR_GOTO(error, ERROR_RECYCLE, "Setup model failed, retCode=%#x.", error);

    if (type == RT_MODEL_NORMAL && isHostSupport && isTsSupport && isDrvSupport) {
        newModel->SetAutoSplitSq(true);
    }
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

void Context::SubModelDestroy(Model *subMdl)
{
    ResetEmbeddedInnerHandle<Model>(subMdl);
    (void)subMdl->TearDown();
    DELETE_O(subMdl);

    return;
}

rtError_t Context::ModelDestroy(Model *mdl)
{
    if (mdl->GetModelType() == RT_MODEL_CAPTURE_MODEL) {
        CaptureModel *captureModel = dynamic_cast<CaptureModel *>(mdl);
        if (captureModel->IsCapturing()) {
            RT_LOG(RT_LOG_ERROR, "Model is in capture mode and cannot be destroyed, model_id=%u!",
                captureModel->Id_());
            return RT_ERROR_MODEL_CAPTURED;
        }

        constexpr uint32_t totalCheckCount = 10000U;                  // 10s
        constexpr auto checkInterval = std::chrono::milliseconds(1);  // 1ms 检查一次
        uint32_t count = 0U;
        while (captureModel->IsCaptureModelRunning()) {
            RawDevice* const rawDev = dynamic_cast<RawDevice *>(device_);
            rawDev->PollEndGraphNotifyInfo();

            COND_RETURN_ERROR((count >= totalCheckCount), RT_ERROR_MODEL_RUNNING,
                "Model is still running and cannot be destroyed, model_id=%u", captureModel->Id_());
            std::this_thread::sleep_for(checkInterval);
            count++;
        }
    }

    modelLock_.Lock();
    ResetEmbeddedInnerHandle<Model>(mdl);
    models_.remove(mdl);
    modelLock_.Unlock();

    (void)mdl->TearDown();
    DELETE_O(mdl);

    return RT_ERROR_NONE;
}

rtError_t Context::ModelUnbindStream(Model * const mdl, Stream * const stm)
{
    std::unique_lock<std::mutex> taskLock(streamLock_);
    const int32_t streamId = stm->Id_();
    const uint32_t modelId = mdl->Id_();

    const rtError_t error = mdl->UnbindStream(stm);
    ERROR_GOTO_MSG_INNER(
        error, COMPLETE, "Failed to unbind the stream from the model, model_id=%u, stream_id=%d, retCode=%#x.", modelId,
        streamId, error);

    if (stm->GetModelNum() == 0 && !(stm->IsAutoSplitSq() && stm->IsSlaveStream())) {
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
    ERROR_GOTO_MSG_INNER(
        error, COMPLETE, "Failed to bind the stream to the model, model_id=%u, stream_id=%d, retCode=%#x.", modelId,
        streamId, error);

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
    ERROR_RETURN_MSG_INNER(
        error, "Failed to add the stream to the model, model_id=%u, stream_id=%d, retCode=%#x.", modelId, streamId,
        error);

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
    ERROR_RETURN_MSG_INNER(
        error, "Failed to delete the stream from the model, model_id=%u, stream_id=%d, retCode=%#x.", modelId, streamId,
        error);

    if (stm->GetModelNum() == 0) {
        streams_.push_back(stm);
    }

    return RT_ERROR_NONE;
}

rtError_t Context::ModelLoadComplete(Model * const mdl) const
{
    const uint32_t modelId = mdl->Id_();

    const rtError_t error = mdl->LoadComplete();
    ERROR_RETURN_MSG_INNER(error, "Failed to complete model load, model_id=%u, retCode=%#x.", modelId, error);

    return error;
}

rtError_t Context::GetNotifyAddress(Notify * const notify, uint64_t &addr, Stream * const stm)
{
    const rtError_t error = notify->GetNotifyAddress(stm, addr);
    ERROR_RETURN_MSG_INNER(error, "Failed to get notify address, retCode=%#x.", error);
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
    COND_RETURN_AND_MSG_OUTER(
        endGraphNum >= 1U, RT_ERROR_MODEL_ENDGRAPH, ErrorCode::EE1011, __func__, endGraphNum, "endGraphNum",
        "The model must have only one end graph");

    if (device_->IsStarsPlatform() && (modelExecuteType != EXECUTOR_AICPU)) {
        const bool isBindThisModel = ((stm->Model_() != nullptr) && (stm->Model_()->Id_() == mdl->Id_()));
        COND_RETURN_AND_MSG_OUTER(
            (stm->GetModelNum() == 0) || (!isBindThisModel), RT_ERROR_STREAM_INVALID, ErrorCode::EE1017, __func__,
            "stream",
            "Stream " + std::to_string(stm->Id_()) + " must be bound to the model " + std::to_string(mdl->Id_()));

        Notify *notify = const_cast<Notify *>(mdl->GetEndGraphNotify());
        if (notify == nullptr) {
            RT_LOG(RT_LOG_INFO, "create notify, stream_id=%d", stm->Id_());
            notify = new (std::nothrow) Notify(device_->Id_(), device_->DevGetTsId());
            COND_RETURN_AND_MSG_OUTER(notify == nullptr, RT_ERROR_NOTIFY_NEW, ErrorCode::EE1013, sizeof(Notify), "new");
            error = notify->Setup();
            COND_PROC_RETURN_WARN(error != RT_ERROR_NONE, error, DELETE_O(notify), "Notify setup, retCode=%#x", error);
        } else {
            error = AllocNotifyIdForSubModel(mdl, notify);
            COND_RETURN_WARN(error != RT_ERROR_NONE, error, "Alloc notify Id, retCode=%#x", error);
        }

        error = notify->Record(stm);
        if (error != RT_ERROR_NONE) {
            (void)ReleaseNotify(mdl, notify);
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
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit AddEndGraphTask, retCode=%#x.", error);

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
    ERROR_RETURN_MSG_INNER(error, "Failed to abort model, model_id=%u, retCode=%#x.", modelId, error);

    return error;
}

rtError_t Context::ModelAbortById(uint32_t modelId) const
{
    rtError_t error;
    const mmTimespec beginTime = mmGetTickCount();
    uint32_t result = static_cast<uint32_t>(RT_ERROR_NONE);
    uint64_t count;
    Driver * const curDrv = device_->Driver_();
    NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_CONTEXT_NULL);
    do {
        error = curDrv->TaskAbortByType(device_->Id_(), device_->DevGetTsId(), OP_ABORT_MODEL, modelId, result);
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "Failed to abort model, model_id=%d, retCode=%#x.",
            modelId, static_cast<uint32_t>(error));
        if (result == TS_SUCCESS) {
            break;
        }

        COND_RETURN_ERROR((result == TS_ERROR_ILLEGAL_PARAM) || (result == TS_APP_EXIT_UNFINISHED) ||
            (result == TS_ERROR_ABORT_UNFINISHED), RT_ERROR_TSFW_ILLEGAL_PARAM,
            "Ts param invalid or abort exit unfinished, model_id=%d, result=%u.", modelId, result);

        count = GetTimeInterval(beginTime);
        COND_RETURN_ERROR((count >= static_cast<uint64_t>(RT_ABORT_STREAM_TIMEOUT)), RT_ERROR_WAIT_TIMEOUT,
            "Abort query timeout, device_id=%u, model_id=%d, time=%lums", device_->Id_(), modelId, count);
        (void)mmSleep(1U);
    } while (result == TS_ERROR_APP_QUEUE_FULL);

    // RT_ABORT_STREAM_TIMEOUT
    uint32_t status;
    while (true) {
        error = curDrv->QueryAbortStatusByType(device_->Id_(), device_->DevGetTsId(), APP_ABORT_STS_QUERY_BY_MODELID, modelId, status);
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "abort query fail, retCode=%#x.",
            static_cast<uint32_t>(error));
        if ((status == DAVID_ABORT_TERMINATE_SUCC) || (status == DAVID_ABORT_STOP_FINISH)) {
            break;
        }
        COND_RETURN_ERROR((status == DAVID_ABORT_TERMINATE_FAIL), RT_ERROR_TSFW_ILLEGAL_PARAM,
            "Device desc status invalid, device_id=%u, model_id=%d, status=%u.", device_->Id_(), modelId, status);

        count = GetTimeInterval(beginTime);
        COND_RETURN_ERROR((count >= static_cast<uint64_t>(RT_ABORT_MODEL_TIMEOUT)), RT_ERROR_WAIT_TIMEOUT,
            "Abort query timeout, device_id=%u, model_id=%d, time=%lums", device_->Id_(), modelId, count);
        (void)mmSleep(5U);
    }

    COND_RETURN_ERROR((status == DAVID_ABORT_STOP_FINISH), RT_ERROR_TSFW_TASK_ABORT_STOP,
        "Model abort stop before post process, model_id=%d.", modelId);

    return error;
}

rtError_t Context::ModelExit(Model * const mdl, Stream * const stm)
{
    rtError_t error;
    const uint32_t modelExitNum = mdl->ModelExitNum_();
    COND_RETURN_AND_MSG_OUTER(
        modelExitNum >= 1U, RT_ERROR_MODEL_EXIT, ErrorCode::EE1011, __func__, modelExitNum, "modelExitNum",
        "The model must exit only once");
    stm->SetLatestModlId(static_cast<int32_t>(mdl->Id_()));
    COND_RETURN_AND_MSG_OUTER(
        stm->Model_() == nullptr, RT_ERROR_MODEL_EXIT_STREAM_UNBIND, ErrorCode::EE1017, __func__, "stream",
        "Stream " + std::to_string(stm->Id_()) + " must be bound to a model");
    COND_RETURN_AND_MSG_OUTER(
        stm->Model_()->Id_() != mdl->Id_(), RT_ERROR_MODEL_EXIT_ID, ErrorCode::EE1017, __func__, "stream",
        "Stream " + std::to_string(stm->Id_()) + " must be bound to the model " + std::to_string(mdl->Id_()));

    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *rtAddModelExitTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_MODEL_EXIT_GRAPH, errorReason);
    NULL_PTR_RETURN_MSG(rtAddModelExitTask, errorReason);

    (void)AddModelExitTaskInit(rtAddModelExitTask, mdl->Id_());

    error = device_->SubmitTask(rtAddModelExitTask, taskGenCallback_);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit AddModelExitTask, retCode=%#x.", error);

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
    ERROR_RETURN_MSG_INNER(error, "Failed to bind queue to model, retCode=%#x.", error);

    return error;
}

rtError_t Context::ProfilerTrace(const uint64_t id, const bool notifyFlag, const uint32_t flags, Stream * const stm)
{
    rtError_t error;
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *rtProfTraceTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_PROFILER_TRACE, errorReason);
    NULL_PTR_RETURN_MSG(rtProfTraceTask, errorReason);

    error = ProfilerTraceTaskInit(rtProfTraceTask, id, notifyFlag, flags);
    ERROR_GOTO_MSG_INNER(
        error, ERROR_RECYCLE,
        "Failed to init profiler trace task, id=%" PRIu64 ", notifyFlag=%d, flags=%u, retCode=%#x.", id,
        static_cast<int32_t>(notifyFlag), flags, error);

    error = device_->SubmitTask(rtProfTraceTask, taskGenCallback_);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit profiler trace task, retCode=%#x.", error);

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
    ERROR_GOTO(
        error, ERROR_RECYCLE,
        "Failed to init ProfilerTraceExTask, id=%" PRIu64 ", model_id=%" PRIu64 ", tag_id=%hu, retCode=%#x.", id,
        modelId, tagId, error);

    error = device_->SubmitTask(rtProfTraceExTask, taskGenCallback_);
    ERROR_GOTO(error, ERROR_RECYCLE, "Failed to submit ProfilerTraceExTask, retCode=%#x.", error);
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
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit host func callback task, retCode=%#x.", error);

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

    COND_RETURN_AND_MSG_OUTER_WITH_PARAM(
        (sampleNum == 0U) || (sampleNum > MAX_ONLINEPROF_NUM), RT_ERROR_INVALID_VALUE, sampleNum,
        "(0, " + std::to_string(MAX_ONLINEPROF_NUM) + "]");
    if ((stm->Device_())->DevGetOnlineProfStart()) {
        RT_LOG_OUTER_MSG_WITH_FUNC(
            ErrorCode::EE1017, "stream",
            "Stream " + std::to_string(stm->Id_()) + " online profiling has already been started on the device");
        return RT_ERROR_PROF_START;
    }

    (void)(stm->Device_())->DevSetOnlineProfStart(true);

    error = OnlineProf::OnlineProfMalloc(stm);
    ERROR_RETURN_MSG_INNER(error, "Failed to allocate online profiling memory, retCode=%#x.", error);

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
    ERROR_RETURN_MSG_INNER(freeErr, "Failed to free online profiling memory, retCode=%#x.", freeErr);
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
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit OnlineProfDisableTask, retCode=%#x.", error);

    error = stm->Synchronize();
    ERROR_GOTO_MSG_INNER(error, FREE_MEM, "Failed to synchronize OnlineProfDisableTask, retCode=%#x.", error);

    goto FREE_MEM;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtOlProfDisableTask);

FREE_MEM:
    (void)(stm->Device_())->DevSetOnlineProfStart(false);

    /* free memory */
    const rtError_t errorFree = OnlineProf::OnlineProfFree(stm);
    ERROR_RETURN_MSG_INNER(errorFree, "Failed to free online profiling memory, retCode=%#x.", errorFree);

    return error;
}

rtError_t Context::GetOnlineProfData(const Stream * const stm, rtProfDataInfo_t * const pProfData,
                                     const uint32_t profDataNum) const
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((profDataNum == 0U) || (profDataNum > MAX_ONLINEPROF_NUM), 
        RT_ERROR_INVALID_VALUE, profDataNum, "(0, " + std::to_string(MAX_ONLINEPROF_NUM) + "]");
    const rtError_t error = OnlineProf::GetOnlineProfilingData(stm, pProfData, profDataNum);
    ERROR_RETURN_MSG_INNER(error, "Failed to get online profiling data, retCode=%#x.", error);

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
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Failed to submit mdc profiling task, retCode=%#x.", error);
        goto ERROR_RECYCLE;
    }

    error = stm->Synchronize();
    return error;

ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(rtMdcProfTask);
    return error;
}

rtError_t Context::LabelSwitchListCreate(Label ** const labels, const size_t num, void ** const labelList) const
{
    const uint64_t labelSize = sizeof(rtLabelDevInfo) * num;
    const rtMemType_t memType = Runtime::Instance()->GetTsMemType(MEM_REQUEST_FEATURE_DEFAULT, labelSize);
    void *devMem = nullptr;
    rtError_t error = device_->Driver_()->DevMemAlloc(&devMem, labelSize,
            memType, device_->Id_());
    ERROR_RETURN(
        error,
        "Failed to allocate device memory for label list, size=%" PRIu64
        " (bytes), memType=%u, deviceId=%u, retCode=%#x.",
        labelSize, memType, device_->Id_(), error);
    error = device_->Driver_()->MemSetSync(devMem, labelSize, 0xFFU, labelSize); // Initialize to an invalid value
    if (error != RT_ERROR_NONE) {
        (void)device_->Driver_()->DevMemFree(devMem, device_->Id_());
        RT_LOG(
            RT_LOG_ERROR,
            "Failed to set label device address memory, retCode=%#x, labels num=%zu, labelSize=%" PRIu64 ".", error,
            num, labelSize);
        return error;
    }

    uint32_t labelStep;
    if (device_->IsStarsPlatform()) {
        labelStep = RT_CHIP_CLOUD_V2_LABEL_INFO_SIZE;
    } else {
        labelStep = sizeof(rtLabelDevInfo);
    }

    void *devAddr = devMem;
    for (size_t idx = 0U; idx < num; idx++) {
        error = labels[idx]->SetLabelDevAddr(devAddr);
        if (error != RT_ERROR_NONE) {
            (void)device_->Driver_()->DevMemFree(devMem, device_->Id_());
            RT_LOG(
                RT_LOG_ERROR, "Failed to set label device address, retCode=%#x, labels num=%zu, index=%zu.",
                static_cast<uint32_t>(error), num, idx);
            return error;
        }
        devAddr = RtPtrToPtr<void *, uintptr_t>(RtPtrToPtr<uintptr_t, void *>(devAddr) + labelStep);
    }

    *labelList = devMem;
    return RT_ERROR_NONE;
}

rtError_t Context::LaunchRandomNumTask(const rtRandomNumTaskInfo_t *taskInfo, Stream * const stm,
    const void *reserve) const
{
    UNUSED(reserve);
    rtError_t error = CheckRandomNumTaskInfo(taskInfo);
    ERROR_RETURN(error, "Failed to check random number task info, retCode=%#x.", static_cast<uint32_t>(error));

    const int32_t streamId = stm->Id_();
    uint32_t taskId;
    TaskInfo taskSubmit = {};
    rtError_t errorReason;
    TaskInfo *rtStarsCommonTask = stm->AllocTask(&taskSubmit, TS_TASK_TYPE_STARS_COMMON, errorReason);
    NULL_PTR_RETURN_MSG(rtStarsCommonTask, errorReason);

    rtStarsDsaSqe_t sqe = {};
    error = GetDsaSqeByRandomNumTask(taskInfo, rtStarsCommonTask, sqe);
    ERROR_RETURN_MSG_INNER(error, "Failed to get DSA SQE by random number task info, retCode=%#x.", error);

    error = StarsCommonTaskInit(rtStarsCommonTask, sqe, RT_KERNEL_DEFAULT);
    ERROR_GOTO_MSG_INNER(
        error, ERROR_RECYCLE, "Failed to init stars common task, stream_id=%d, task_id=%hu, retCode=%#x.", streamId,
        rtStarsCommonTask->id, error);

    error = device_->SubmitTask(rtStarsCommonTask, taskGenCallback_, &taskId);
    ERROR_GOTO_MSG_INNER(
        error, ERROR_RECYCLE, "Failed to submit stars common task, streamId=%d, taskId=%hu, retCode=%#x.", streamId,
        rtStarsCommonTask->id, error);

    if (rtStarsCommonTask->stream != nullptr) {
        SET_THREAD_TASKID_AND_STREAMID(rtStarsCommonTask->stream->Id_(), taskId);
    }

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
    ERROR_GOTO(
        error, ERROR_RECYCLE, "Failed to init SQ lock/unlock task, stream_id=%d, task_id=%hu, retCode=%#x.", streamId,
        rtSetSqLockUnlockTask->id, error);

    error = device_->SubmitTask(rtSetSqLockUnlockTask, taskGenCallback_);
    ERROR_GOTO(error, ERROR_RECYCLE, "Failed to submit SQ lock/unlock task, retCode=%#x.", error);

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
    ERROR_GOTO(
        error, ERROR_RECYCLE, "Failed to init NopTask, stream_id=%d, task_id=%hu, retCode=%#x.", streamId,
        rtNopTask->id, error);

    error = device_->SubmitTask(rtNopTask, taskGenCallback_);
    ERROR_GOTO(error, ERROR_RECYCLE, "Failed to submit NopTask, retCode=%#x.", error);

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
        ret = programHdl->BuildTilingTbl(&tilingTab, &kernelLen);
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

    Program *program = nullptr;
    rtError_t ret = GetValidatedObject<Program>(RtPtrToPtr<rtBinHandle>(para->hdl), program);
    if (ret != RT_ERROR_NONE) {
        return ret;
    }

    ret = CopyTilingTabToDev(program, sinkStm->Device_(), &devCopyMem, &tilingTabLen);
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

    COND_RETURN_AND_MSG_OUTER(
        stm->GetBindFlag(), RT_ERROR_STREAM_INVALID, ErrorCode::EE1016, __func__, "Clearing model stream is not supported");
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
    CommonCmdTaskInit(rtCommonCmdTask, PhCmdType::CMD_STREAM_CLEAR, &cmdInfo);

    rtError_t error = device_->SubmitTask(rtCommonCmdTask, taskGenCallback_);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit stream clear task, retCode=%#x.", error);

    error = dftStm->Synchronize();
    ERROR_RETURN_MSG_INNER(
        error, "Failed to synchronize stream clear task, stream_id=%d, retCode=%#x.", streamId, error);

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
    COND_RETURN_AND_MSG_OUTER(
        stm->GetBindFlag(), RT_ERROR_STREAM_INVALID, ErrorCode::EE1016, __func__,
        RtFmtMsg("Aborting stream (stream_id=%d) that is already bound to a model (model_id=%u) is not supported",
            stm->Id_(), stm->Model_()->Id_()));
    //runtime-ts compatibility check;
    const bool isSupported = IsStreamAbortSupported();
    COND_RETURN_WARN((isSupported == false), RT_ERROR_FEATURE_NOT_SUPPORT, "stream abort is not supported");

    // 在device abort不处理mc2流，此处不能跳过mc2流
    if ((device_->GetDeviceStatus() == RT_ERROR_DEVICE_TASK_ABORT) &&
        ((stm->Flags() & RT_STREAM_CP_PROCESS_USE) == 0U)) {
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
        RT_LOG(RT_LOG_DEBUG, "QuerySq stream_id=%d, sq_id=%u, status=%u", stm->Id_(), stm->GetSqId(), status);
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
    return device_->GetCtrlSQStream(DefaultStream_());
}

rtError_t Context::CheckStatus(const Stream * const stm, const bool isBlockDefault)
{
    ProcessReportFastRingBuffer();
    // device status check
    (void)device_->GetDevRunningState();
    rtError_t status = RT_ERROR_NONE;
    status = device_->GetDevStatus();
    COND_PROC_RETURN_ERROR_MSG_CALL(
        ERR_MODULE_DRV, status != RT_ERROR_NONE, status,
        RT_LOG_INNER_DETAIL_MSG(RT_DRV_INNER_ERROR, {"device_id"}, {std::to_string(device_->Id_())});
        , "Failed to check device status, device_id=%u, retCode=%#x.", device_->Id_(), status);
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
    COND_PROC_RETURN_ERROR_MSG_CALL(
        ERR_MODULE_DRV, status != RT_ERROR_NONE, status,
        RT_LOG_INNER_DETAIL_MSG(RT_DRV_INNER_ERROR, {"device_id"}, {std::to_string(device_->Id_())});
        , "Failed to check device status, device_id=%u, retCode=%#x.", device_->Id_(), status);
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
    NULL_PTR_RETURN_MSG_OUTER(coreInfo, RT_ERROR_INVALID_VALUE);
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
    ERROR_RETURN(ret, "Failed to allocate device memory, retCode=%#x.", ret);
    ScopeGuard guard([&devMem, &devDrv, &deviceId]() { (void)devDrv->DevMemFree(devMem, deviceId); });
    ret = devDrv->MemAddressTranslate(static_cast<int32_t>(deviceId), PtrToValue(devMem), &physicPtr);
    ERROR_RETURN(ret, "Failed to translate device memory address, ptr=%p, retCode=%#x.", devMem, ret);
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
        ERROR_RETURN(ret, "Failed to set device memory, addr=%p, retCode=%#x.", devMem, ret);
        rtDebugReportInfo_t reportInfo = {};
        ret = SendAndRecvDebugTask(&sendInfo, &reportInfo);
        COND_RETURN_ERROR(((ret != RT_ERROR_NONE) || (reportInfo.returnVal != 0U)), RT_ERROR_INVALID_VALUE,
            "DebugReadAICore failed, retCode=%#x, reportVal=%u, coreType=%u, coreId=%u, debugMemType=%u, "
            "elementSize=%u, memLen=%llu, srcAddr=0x%llx, dstAddr=0x%llx.", ret, reportInfo.returnVal, param->coreType,
            param->coreId, param->debugMemType, memoryParam->elementSize, memoryParam->memLen, memoryParam->srcAddr,
            memoryParam->dstAddr);

        ret = devDrv->MemCopySync(ValueToPtr(param->dstAddr + offset), memoryParam->memLen, devMem,
                                  memoryParam->memLen, RT_MEMCPY_DEVICE_TO_HOST);
        ERROR_RETURN(
            ret, "Failed to copy memory, retCode=%#x, dstAddr=0x%llx, srcAddr=%p, memLen=%llu.", ret,
            param->dstAddr + offset, devMem, memoryParam->memLen);

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
        ERROR_GOTO(
            error, ERROR_RECYCLE,
            "Failed to memcpy from host to dev, device_id=%u, size=%" PRIu64 "(bytes), retCode=%#x.", device_->Id_(),
            dstMax, error);

        if (devDrv->GetRunMode() == RT_RUN_MODE_ONLINE) {
            error = device_->Driver_()->DevMemFlushCache(RtPtrToValue<rtCmoAddrInfo *>(cmoAddrInfo), dstMax);
            ERROR_GOTO(
                error, ERROR_RECYCLE, "Failed to flush stream info, device_id=%u, retCode=%#x.", device_->Id_(), error);
        }
    }

    // init cmoAddrTask
    (void)CmoAddrTaskInit(cmoAddrTask, cmoAddrInfo, cmoOpCode);

    error = device_->SubmitTask(cmoAddrTask, taskGenCallback_);
    ERROR_GOTO(error, ERROR_RECYCLE, "Failed to submit CMO task, retCode=%#x.", error);

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
    ERROR_GOTO(error, ERROR_RECYCLE, "Failed to submit NPUGetFloatStatus task, retCode=%#x.", error);

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
    ERROR_GOTO(error, ERROR_RECYCLE, "Failed to submit NPUClearFloatStatus task, retCode=%#x.", error);

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
    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        uint32_t flipTaskId = 0;
        RtOverflowSwitchSetParam param = {stm, flags};
        error = device_->GetCtrlSQ().SendOverflowSwitchSetMsg(RtCtrlMsgType::RT_CTRL_MSG_SET_OVERFLOW_SWITCH, param, taskGenCallback_, &flipTaskId);
        ERROR_RETURN(error, "Failed to send overflow switch set message, retCode=%#x.", error);
        SET_THREAD_TASKID_AND_STREAMID(GetCtrlSQStream()->Id_(), flipTaskId);
    } else {
        NULL_PTR_RETURN_MSG(DefaultStream_(), RT_ERROR_STREAM_NULL);
        TaskInfo submitTask = {};
        rtError_t errorReason = RT_ERROR_TASK_NEW;
        tsk = DefaultStream_()->AllocTask(&submitTask, TS_TASK_TYPE_SET_OVERFLOW_SWITCH, errorReason);
        NULL_PTR_RETURN(tsk, errorReason);

        (void)OverflowSwitchSetTaskInit(tsk, stm, flags);
        error = device_->SubmitTask(tsk, taskGenCallback_);
        ERROR_GOTO(error, ERROR_RECYCLE, "Failed to submit OverflowSwitchSetTask, retCode=%#x.", error);
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
    rtError_t error = RT_ERROR_NONE;
    TaskInfo *tsk = nullptr;
    if (device_->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        uint32_t flipTaskId = 0;
        RtSetStreamTagParam param = {stm, geOpTag};
        error = device_->GetCtrlSQ().SendSetStreamTagMsg(RtCtrlMsgType::RT_CTRL_MSG_SET_STREAM_TAG, param, taskGenCallback_, &flipTaskId);
        ERROR_RETURN(error, "Failed to send stream tag set message, retCode=%#x.", error);
        stm->SetStreamTag(geOpTag);
        SET_THREAD_TASKID_AND_STREAMID(GetCtrlSQStream()->Id_(), flipTaskId);
    } else {
        TaskInfo submitTask = {};
        rtError_t errorReason;
        NULL_PTR_RETURN_MSG(DefaultStream_(), RT_ERROR_STREAM_NULL);

        tsk = DefaultStream_()->AllocTask(&submitTask, TS_TASK_TYPE_SET_STREAM_GE_OP_TAG, errorReason);
        NULL_PTR_RETURN(tsk, errorReason);

        (void)StreamTagSetTaskInit(tsk, stm, geOpTag);
        error = device_->SubmitTask(tsk, taskGenCallback_);
        ERROR_GOTO_MSG_INNER(
            error, ERROR_RECYCLE, "Failed to submit StreamTagSetTask, retCode=%#x.", static_cast<uint32_t>(error));
        stm->SetStreamTag(geOpTag);
        GET_THREAD_TASKID_AND_STREAMID(tsk, DefaultStream_()->Id_());
    }
    return error;
ERROR_RECYCLE:
    (void)device_->GetTaskFactory()->Recycle(tsk);
    return error;
}

rtError_t Context::DvppGroupCreate(DvppGrp **grp, const uint32_t flags)
{
    DvppGrp *newGrp = new (std::nothrow) DvppGrp(device_, flags);
    COND_RETURN_AND_MSG_OUTER(newGrp == nullptr, RT_ERROR_DVPP_GRP_NEW, ErrorCode::EE1013, sizeof(DvppGrp), "new");

    newGrp->SetContext(this);
    const rtError_t error = newGrp->Setup();
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Failed to set up DvppGrp, retCode=%#x.", error);
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
    COND_RETURN_AND_MSG_OUTER(hostPtr == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013, sizeof(uint64_t), "malloc");
    hostPtrGuard.reset(hostPtr, &AlignedFree);
    const errno_t ret = memset_s(hostPtr, sizeof(uint64_t), 0, sizeof(uint64_t));
    COND_PROC_RETURN_ERROR_MSG_INNER(
        ret != EOK, RT_ERROR_SEC_HANDLE, hostPtr = nullptr;
        , "Failed to call memset_s to set hostPtr, dest=%p, dest_max=%zu, c=0, count=%zu, retCode=%d.", hostPtr,
        sizeof(uint64_t), sizeof(uint64_t), ret);
    *(RtPtrToPtr<uint64_t *, void *>(hostPtr)) = RtPtrToValue(CtxGetOverflowAddr());
    if (curStm->GetMemContainOverflowAddr() == nullptr) {
        void *memAddr = nullptr;
        Device* dev = Device_();
        error = dev->Driver_()->DevMemAlloc(&memAddr, sizeof(uint64_t), RT_MEMORY_DEFAULT, dev->Id_());
        ERROR_RETURN(error, "memAddr DevMemAlloc failed, retCode=%#x.", static_cast<uint32_t>(error));
        curStm->SetMemContainOverflowAddr(memAddr);
    }

    error = MemcopyAsync(
        curStm->GetMemContainOverflowAddr(), sizeof(uint64_t), hostPtr, sizeof(uint64_t), RT_MEMCPY_HOST_TO_DEVICE_EX,
        curStm, &realSize, hostPtrGuard);
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
    ERROR_GOTO(
        error, ERROR_RECYCLE, "Failed to init UpdateAddressTask, stream_id=%d, task_id=%hu, retCode=%#x.", streamId,
        rtUpdateAddressTask->id, static_cast<uint32_t>(error));

    error = device_->SubmitTask(rtUpdateAddressTask, taskGenCallback_);
    ERROR_GOTO(error, ERROR_RECYCLE, "Failed to submit UpdateAddressTask, retCode=%#x.", static_cast<uint32_t>(error));

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

bool Context::IsStreamInContext(Stream * const stm)
{
    std::unique_lock<std::mutex> taskLock(streamLock_);
    for (Stream *stream : streams_) {
        if (!stream->GetBindFlag() && (stream == stm)) {
            return true;
        }
    }

    // streams_ does not include default/online streams.
    return (DefaultStream_() == stm) || (OnlineStream_() == stm);
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
    COND_RETURN_AND_MSG_OUTER(
        hostFuncCallBackThread_ == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013,
        OsalFactory::GetThreadObjectSize(), "new");
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
