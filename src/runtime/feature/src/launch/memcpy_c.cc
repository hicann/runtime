/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "memcpy_c.hpp"
#include "stars_david.hpp"
#include "task_david.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "stream_david.hpp"
#include "profiler_c.hpp"

namespace cce {
namespace runtime {
TIMESTAMP_EXTERN(rtReduceAsync_part1);
TIMESTAMP_EXTERN(rtReduceAsync_part2);

rtError_t MemcpyAsyncPtrForDavid(rtDavidMemcpyAddrInfo *const memcpyAddrInfo, const uint64_t count, Stream *stm,
    const rtTaskCfgInfo_t * const cfgInfo)
{
    rtError_t error = RT_ERROR_NONE;
    constexpr uint32_t cpySize = 32U;
    Device *dev = stm->Device_();
    TaskInfo *cpyAsyncTask = nullptr;

    RtDavidStarsMemcpySqe sdmaSqe = {};
    InitStarsSdmaSqeForDavid(&sdmaSqe, cfgInfo, stm);
    RT_LOG(RT_LOG_INFO, "memcpyAddrInfo=0x%lx , qos=%u", RtPtrToValue(memcpyAddrInfo), sdmaSqe.qos);

    error = dev->Driver_()->MemCopySync(memcpyAddrInfo, cpySize, &sdmaSqe, cpySize, RT_MEMCPY_HOST_TO_DEVICE);
    ERROR_RETURN_MSG_INNER(error, "Failed to memory copy info, device_id=%u, size=%u, retCode=%#x",
        dev->Id_(), cpySize, static_cast<uint32_t>(error));
    error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream check failed, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    Stream *dstStm = stm;
    std::function<void()> const errRecycle = [&cpyAsyncTask, &stm, &pos, &dstStm]() {
        TaskUnInitProc(cpyAsyncTask);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();
    };
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&cpyAsyncTask, stm, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(cpyAsyncTask, dstStm, pos);
    ScopeGuard tskErrRecycle(errRecycle);
    error = MemcpyAsyncTaskInitV1(cpyAsyncTask, memcpyAddrInfo, count);
    ERROR_RETURN_MSG_INNER(error, "task init failed, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    cpyAsyncTask->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    error = DavidSendTask(cpyAsyncTask, dstStm);
    ERROR_RETURN_MSG_INNER(error, "task submit failed, stream_id=%d, retCode=%#x",
        stm->Id_(), static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), cpyAsyncTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t Memcpy2DAsync(void * const dst, const uint64_t dstPitch, const void * const src,
    const uint64_t srcPitch, const uint64_t width, const uint64_t height, const rtMemcpyKind_t kind,
    uint64_t * const realSize, Stream * const stm, const uint64_t fixedSize)
{
    if (stm == nullptr) {
        return RT_ERROR_STREAM_NULL;
    }
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, stm->Id_(), retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    TaskInfo *taskAsync2d = nullptr;
    Stream *dstStm = stm;
    std::function<void()> const errRecycle = [&taskAsync2d, &stm, &pos, &dstStm]() {
        TaskUnInitProc(taskAsync2d);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();
    };
    const uint32_t sqeNum = Runtime::Instance()->GetConnectUbFlag() ? 2U : 1U;
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&taskAsync2d, stm, pos, dstStm, sqeNum);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
                                stm->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(taskAsync2d, dstStm, pos, sqeNum);
    ScopeGuard tskErrRecycle(errRecycle);
    error = MemcpyAsyncTaskInitV2(taskAsync2d, dst, dstPitch, src, srcPitch, width, height, kind, fixedSize);
    ERROR_RETURN_MSG_INNER(error, "invoke taskAsync2d Init stream_id=%d, errorcode:%#x", stm->Id_(),
        static_cast<uint32_t>(error));
    *realSize = taskAsync2d->u.memcpyAsyncTaskInfo.size;
    taskAsync2d->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    error = DavidSendTask(taskAsync2d, dstStm);
    ERROR_RETURN_MSG_INNER(error, "taskAsync2d task submit task failed, stream_id=%d, pos=%u, retCode=%#x.",
        stm->Id_(), pos, static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), taskAsync2d->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

static bool isModelByUb(const Stream *const stm)
{
    if ((stm->IsCapturing() || stm->GetBindFlag()) && (Runtime::Instance()->GetConnectUbFlag())) {
        return true;
    }
    return false;
}

static void SetModelFlag(uint32_t copyType, const Stream * const stm)
{
    if (!Runtime::Instance()->GetConnectUbFlag() || !stm->GetBindFlag()) {
        return;
    }
    if ((copyType == RT_MEMCPY_DIR_H2D) || (copyType == RT_MEMCPY_DIR_D2H)) {
        stm->Model_()->SetUbModelH2dFlag(true);
    }
    if (copyType == RT_MEMCPY_DIR_D2D_UB) {
        stm->Model_()->SetUbModelD2dFlag(true);
    }
}

rtError_t MemcopyAsync(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cpySize,
    const rtMemcpyKind_t kind, Stream * const stm, uint64_t * const realSize,
    const std::shared_ptr<void> &guardMem, const rtTaskCfgInfo_t * const cfgInfo,
    const rtD2DAddrCfgInfo_t * const addrCfg)
{
    UNUSED(destMax);
    if (stm == nullptr) {
        return RT_ERROR_STREAM_NULL;
    }

    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "CheckTaskCanSend failed, stream_id=%d, error:%#x", stm->Id_(),
        static_cast<uint32_t>(error));
    TaskInfo *rtMemcpyAsyncTask = nullptr;
    uint32_t transType = UINT32_MAX;
    if (kind == RT_MEMCPY_DEVICE_TO_DEVICE) {
        error = ConvertD2DCpyType(stm, transType, src, dst);
        ERROR_RETURN_MSG_INNER(error, "ConvertD2DCpyType failed, retCode=%#x.", static_cast<uint32_t>(error));
    }
    const uint32_t sqeNum = GetSqeNumForMemcopyAsync(kind, isModelByUb(stm), transType);
    uint32_t pos = 0xFFFFU;
    Stream *dstStm = stm;
    std::function<void()> const errRecycle = [&rtMemcpyAsyncTask, &stm, &pos, &dstStm]() {
        TaskUnInitProc(rtMemcpyAsyncTask);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();
    };
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&rtMemcpyAsyncTask, stm, pos, dstStm, sqeNum);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(rtMemcpyAsyncTask, dstStm, pos, sqeNum);
    ScopeGuard tskErrRecycle(errRecycle);
    error = MemcpyAsyncTaskInitV3(rtMemcpyAsyncTask, kind, src, dst, cpySize, cfgInfo, addrCfg);
    ERROR_RETURN_MSG_INNER(error, "invoke MemcpyAsyncTask Init stream_id=%d error code:%#x", stm->Id_(),
        static_cast<uint32_t>(error));
    *realSize = rtMemcpyAsyncTask->u.memcpyAsyncTaskInfo.size;
    if (guardMem != nullptr) {
        rtMemcpyAsyncTask->u.memcpyAsyncTaskInfo.guardMemVec->emplace_back(guardMem);
    }

    /* 记录UB互连场景下模型是否下过H2D/D2H/跨片D2D任务 */
    SetModelFlag(rtMemcpyAsyncTask->u.memcpyAsyncTaskInfo.copyType, dstStm);

    rtMemcpyAsyncTask->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    error = DavidSendTask(rtMemcpyAsyncTask, dstStm);
    ERROR_RETURN_MSG_INNER(error, "MemcpyAsyncTask submit task failed, stream_id=%d, pos=%u, retCode=%#x.",
        stm->Id_(), pos, static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), rtMemcpyAsyncTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    return error;
}

rtError_t MemcpyReduceAsync(void * const dst, const void * const src, const uint64_t cpySize,
    const rtRecudeKind_t kind, const rtDataType_t type, Stream * const stm,
    const rtTaskCfgInfo_t * const cfgInfo)
{
    const int32_t streamId = stm->Id_();
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    if (stm->Device_()->Driver_() != nullptr) {
        rtDevCapabilityInfo capabilityInfo = {};
        error = stm->Device_()->GetDeviceCapabilities(capabilityInfo);
        ERROR_RETURN_MSG_INNER(error, "Get chip capability failed, device_id=%u, retCode=%#x.",
            stm->Device_()->Id_(), static_cast<uint32_t>(error));
        const uint32_t sdmaReduceKind = capabilityInfo.sdma_reduce_kind;
        RT_LOG(RT_LOG_INFO, "ReduceAsync sdma_reduce_kind=0x%x.", sdmaReduceKind);
        const uint32_t shift = static_cast<uint32_t>(kind) - static_cast<uint32_t>(RT_MEMCPY_SDMA_AUTOMATIC_ADD);
        COND_RETURN_AND_MSG_OUTER((((sdmaReduceKind >> shift) & 0x1U) == 0U), RT_ERROR_FEATURE_NOT_SUPPORT, 
            ErrorCode::EE1006, __func__, "kind=" + std::to_string(kind));

        const uint32_t sdmaReduceSupport = capabilityInfo.sdma_reduce_support;
        const uint32_t offset = static_cast<uint32_t>(type);
        RT_LOG(RT_LOG_INFO, "ReduceAsync sdma_reduce_support=0x%x.", sdmaReduceSupport);
        if (((sdmaReduceSupport >> offset) & 0x1U) == 0U) { // 1:bit 0
            RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1006, "type=" + std::to_string(type));
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
    }

    error = stm->Context_()->CheckMemAlign(src, type);
    ERROR_RETURN_MSG_INNER(error,"invoke src CheckMemAlign error code:%#x", static_cast<uint32_t>(error));
    error = stm->Context_()->CheckMemAlign(dst, type);
    ERROR_RETURN_MSG_INNER(error, "invoke dst CheckMemAlign error code:%#x", static_cast<uint32_t>(error));
    TIMESTAMP_BEGIN(rtReduceAsync_part2);
    uint32_t pos = 0xFFFFU;
    Stream *dstStm = stm;
    TaskInfo *rtMemcpyAsyncTask = nullptr;
    std::function<void()> const errRecycle = [&rtMemcpyAsyncTask, &stm, &pos, &dstStm]() {
        TaskUnInitProc(rtMemcpyAsyncTask);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();
    };
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&rtMemcpyAsyncTask, stm, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();,
        "stream_id=%d alloc ccuLaunch task failed, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    SaveTaskCommonInfo(rtMemcpyAsyncTask, dstStm, pos);
    ScopeGuard tskErrRecycle(errRecycle);
    error = MemcpyAsyncTaskInitV3(rtMemcpyAsyncTask, kind, src, dst, cpySize, cfgInfo, nullptr);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d MemcpyAsyncTask init error code:%#x", streamId,
        static_cast<uint32_t>(error));
    rtMemcpyAsyncTask->u.memcpyAsyncTaskInfo.copyDataType = static_cast<uint8_t>(type);
    rtMemcpyAsyncTask->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    error = DavidSendTask(rtMemcpyAsyncTask, dstStm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d MemcpyAsyncTask submit error code:%#x",
        streamId, static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), rtMemcpyAsyncTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

static rtError_t DevMemSetAsync(Stream * const stm, void * const ptr, const uint64_t destMax,
                         const uint32_t fillVal, const uint64_t fillCount)
{
    rtError_t error = RT_ERROR_NONE;
    Driver * const driver = stm->Device_()->Driver_();
    // malloc 64M Host memory and memset with parameter:fillVal
    void *hostPtr = nullptr;
    error = driver->HostMemAlloc(&hostPtr, (static_cast<size_t>(MEM_BLOCK_SIZE)), stm->Device_()->Id_());
    ERROR_RETURN(error, "Alloc host mem failed, size=%zu(bytes), device_id=%d, retCode=%#x!",
        static_cast<size_t>(MEM_BLOCK_SIZE), stm->Device_()->Id_(), static_cast<uint32_t>(error));
    NULL_PTR_RETURN_MSG(hostPtr, RT_ERROR_MEMORY_ALLOCATION);
    const uint64_t setSize = (fillCount < MEM_BLOCK_SIZE) ? fillCount : MEM_BLOCK_SIZE;
    const errno_t ret = memset_s(hostPtr, setSize, static_cast<int32_t>(fillVal), setSize);
    if (ret != EOK) {
        (void)driver->HostMemFree(hostPtr);
        RT_LOG(RT_LOG_ERROR, "memset_s failed, retCode=%d.", ret);
        return RT_ERROR_SEC_HANDLE;
    }

    uint64_t remainSize = (fillCount < MEM_BLOCK_SIZE) ? fillCount : MEM_BLOCK_SIZE;
    uint64_t realSize = 0UL;
    uint64_t doneSize = 0UL;
    while (remainSize > 0ULL) {
        error = MemcopyAsync((RtPtrToPtr<char_t *>(ptr)) + doneSize, destMax - doneSize,
            RtPtrToPtr<char_t *>(hostPtr) + doneSize,
            remainSize, RT_MEMCPY_HOST_TO_DEVICE_EX, stm, &realSize);
        if (error != RT_ERROR_NONE) {
            (void)driver->HostMemFree(hostPtr);
            RT_LOG(RT_LOG_ERROR, "Memcpy async step1 failed, retCode=%#x,"
            " max size=%" PRIu64 ", src size=%" PRIu64 ", type=%d.",
            static_cast<uint32_t>(error), destMax - doneSize, remainSize, RT_MEMCPY_HOST_TO_DEVICE);
            return error;
        }
        doneSize += realSize;
        remainSize -= realSize;
    }
    (void)driver->HostMemFree(hostPtr);
    if (fillCount > MEM_BLOCK_SIZE) {
        const uint64_t memBlockNum = fillCount / MEM_BLOCK_SIZE;
        for (uint64_t idx = 1UL; idx < memBlockNum; idx++) {
            error = MemcopyAsync(RtPtrToPtr<char_t *>(ptr) + (idx * MEM_BLOCK_SIZE),
                destMax - (idx * MEM_BLOCK_SIZE), RtPtrToPtr<char_t *>(ptr), MEM_BLOCK_SIZE,
                RT_MEMCPY_DEVICE_TO_DEVICE, stm, &realSize);
            ERROR_RETURN_MSG_INNER(error, "Memcpy async step2 failed,"
                " max size=%" PRIu64 ", src size=%" PRIu64 ", type=%d.",
                destMax - (idx * MEM_BLOCK_SIZE), MEM_BLOCK_SIZE, RT_MEMCPY_DEVICE_TO_DEVICE);
        }

        const uint64_t memRemain = fillCount % MEM_BLOCK_SIZE;
        if (memRemain > 0ULL) {
            char_t * const dstAddr = (RtPtrToPtr<char_t *>(ptr)) + (memBlockNum * MEM_BLOCK_SIZE);
            error = MemcopyAsync(dstAddr, destMax - (memBlockNum * MEM_BLOCK_SIZE), static_cast<char_t *>(ptr),
                memRemain, RT_MEMCPY_DEVICE_TO_DEVICE, stm, &realSize);
            ERROR_RETURN_MSG_INNER(error, "Memcpy async step3 failed,"
                " max size=%" PRIu64 ", src size=%" PRIu64 ", type=%d.",
                destMax - (memBlockNum * MEM_BLOCK_SIZE), memRemain, RT_MEMCPY_DEVICE_TO_DEVICE);
        }
    }

    return error;
}


rtError_t MemSetAsync(Stream * const stm, void * const ptr, const uint64_t destMax,
                      const uint32_t fillVal, const uint64_t fillCount)
{
    rtError_t error = RT_ERROR_NONE;
    rtPtrAttributes_t attributes;
    error = stm->Device_()->Driver_()->PtrGetAttributes(ptr, &attributes);
    ERROR_RETURN_MSG_INNER(error, "get pointer attribute failed, retCode=%#x.", static_cast<uint32_t>(error));
    RT_LOG(RT_LOG_DEBUG, "memset memory type is %u.", attributes.location.type);

    if ((attributes.location.type == RT_MEMORY_LOC_HOST) || (attributes.location.type == RT_MEMORY_LOC_UNREGISTERED)) {
        const errno_t ret = memset_s(ptr, destMax, static_cast<int32_t>(fillVal), fillCount);
        COND_RETURN_ERROR_MSG_CALL(ERR_MODULE_SYSTEM, ret != EOK, RT_ERROR_SEC_HANDLE,
            "Memset async failed, due to memset_s failed, destMax=%" PRIu64 ", fillCount=%" PRIu64 ", retCode=%d.",
            destMax, fillCount, ret);
    } else {
        if (fillCount > destMax) {
            RT_LOG(RT_LOG_WARNING,
                "current fillCount=%" PRIu64 ", destMax=%" PRIu64 ", fillCount must be less than or equal to destMax!",
                fillCount, destMax);
            return RT_ERROR_MEMORY_ALLOCATION;
        }
        return DevMemSetAsync(stm, ptr, destMax, fillVal, fillCount);
    }

    return error;
}

}  // namespace runtime
}  // namespace cce