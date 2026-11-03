/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <algorithm>
#include <limits>
#include <string>
#include "memcpy_c.hpp"
#include "memory_task.h"
#include "stars_david.hpp"
#include "task_david.hpp"
#include "memset_common.h"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "npu_driver.hpp"
#include "stream_david.hpp"
#include "profiler_c.hpp"

namespace cce {
namespace runtime {

rtError_t MemcopyAsyncPtr(
    void* const memcpyAddrInfo, const uint64_t destMax, const uint64_t count, Stream* stm,
    const std::shared_ptr<void>& guardMem, const rtTaskCfgInfo_t* const cfgInfo, const bool isMemcpyDesc)
{
    UNUSED(destMax);
    UNUSED(guardMem);
    UNUSED(isMemcpyDesc);
    rtError_t error = RT_ERROR_NONE;
    constexpr uint32_t cpySize = 32U;
    Device* dev = stm->Device_();
    TaskInfo* cpyAsyncTask = nullptr;

    RtDavidStarsMemcpySqe sdmaSqe = {};
    InitStarsSdmaSqeForDavid(&sdmaSqe, cfgInfo, stm);
    RT_LOG(RT_LOG_INFO, "memcpyAddrInfo=0x%lx, qos=%u", RtPtrToValue(memcpyAddrInfo), sdmaSqe.qos);

    DevDynInfoProcFunc func{};
    if ((GET_DEV_INFO_PROC_FUNC(Runtime::Instance()->GetChipType(), func) == RT_ERROR_NONE) &&
        (func.memProcFunc.memCopySync != nullptr)) {
        error = func.memProcFunc.memCopySync(memcpyAddrInfo, cpySize, &sdmaSqe, cpySize, RT_MEMCPY_HOST_TO_DEVICE);
    } else {
        error = dev->Driver_()->MemCopySync(memcpyAddrInfo, cpySize, &sdmaSqe, cpySize, RT_MEMCPY_HOST_TO_DEVICE);
    }
    ERROR_RETURN(
        error, "Failed to memory copy info, device_id=%u, size=%u(bytes), retCode=%#x.", dev->Id_(), cpySize,
        static_cast<uint32_t>(error));

    error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to check stream (stream_id=%d), retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    Stream* dstStm = stm;
    std::function<void()> const errRecycle = [&cpyAsyncTask, &stm, &pos, &dstStm]() {
        TaskUnInitProc(cpyAsyncTask);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();
    };
    stm->StreamLock();
    cpyAsyncTask = stm->AllocTask(nullptr, TS_TASK_TYPE_MEMCPY, error);
    COND_PROC_RETURN_ERROR_MSG_INNER(cpyAsyncTask == nullptr, error, stm->StreamUnLock();
                                     , "Failed to alloc task (stream_id=%d), retCode=%#x.", stm->Id_(),
                                     static_cast<uint32_t>(error));
    pos = cpyAsyncTask->id;
    dstStm = cpyAsyncTask->stream;
    ScopeGuard tskErrRecycle(errRecycle);
    error = MemcpyAsyncTaskInitV1(cpyAsyncTask, static_cast<rtDavidMemcpyAddrInfo*>(memcpyAddrInfo), count);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to init task (stream_id=%d), retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    cpyAsyncTask->stmArgPos = static_cast<DavidStream*>(dstStm)->GetArgPos();
    error = DavidSendTask(cpyAsyncTask, dstStm);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to submit task (stream_id=%d), retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->GetExposedStreamId(), cpyAsyncTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to perform post-processing of task (stream_id=%d) submission, retCode=%#x.", stm->Id_(),
        static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t Memcpy2DAsync(
    void* const dst, const uint64_t dstPitch, const void* const src, const uint64_t srcPitch, const uint64_t width,
    const uint64_t height, const rtMemcpyKind_t kind, uint64_t* const realSize, Stream* const stm,
    const uint64_t fixedSize)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(stm, RT_ERROR_STREAM_NULL, "Asynchronous 2D memory copy");
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to check stream (stream_id=%d), retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    TaskInfo* taskAsync2d = nullptr;
    Stream* dstStm = stm;
    std::function<void()> const errRecycle = [&taskAsync2d, &stm, &pos, &dstStm]() {
        TaskUnInitProc(taskAsync2d);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();
    };
    const uint32_t sqeNum =
        GetSqeNumForMemcopyAsync(kind, false, UINT32_MAX, static_cast<uint32_t>(rtAsyncCpyMethod::RT_ASYNC_CPY_2D));
    stm->StreamLock();
    taskAsync2d = stm->AllocTask(nullptr, TS_TASK_TYPE_MEMCPY, error, sqeNum);
    COND_PROC_RETURN_ERROR_MSG_INNER(taskAsync2d == nullptr, error, stm->StreamUnLock();
                                     , "Failed to alloc task (stream_id=%d), retCode=%#x.", stm->Id_(),
                                     static_cast<uint32_t>(error));
    pos = taskAsync2d->id;
    dstStm = taskAsync2d->stream;
    ScopeGuard tskErrRecycle(errRecycle);
    error = MemcpyAsyncTaskInitV2(taskAsync2d, dst, dstPitch, src, srcPitch, width, height, kind, fixedSize);
    taskAsync2d->u.memcpyAsyncTaskInfo.copyMethod = static_cast<uint8_t>(rtAsyncCpyMethod::RT_ASYNC_CPY_2D);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error, "Init MemcpyAsyncTask failed, stream_id=%d, retCode=%#x", stm->Id_(),
        static_cast<uint32_t>(error));
    // David UB 单算子场景 fixedSize是否与计算出的size相等，如果相等则不需要发送任务
    if (IsDavidUbDma(taskAsync2d->u.memcpyAsyncTaskInfo.copyType) && (!stm->IsCapturing()) && (!stm->GetBindFlag()) &&
        fixedSize == taskAsync2d->u.memcpyAsyncTaskInfo.size) {
        RT_LOG(
            RT_LOG_WARNING,
            "In UB eager mode, no need to send taskAsync2d if fixedSize has not changed. stream_id=%d, "
            "fixedSize=%" PRIu64 ", size=%" PRIu64 " ",
            stm->Id_(), fixedSize, taskAsync2d->u.memcpyAsyncTaskInfo.size);
        return RT_ERROR_NONE;
    }
    *realSize = taskAsync2d->u.memcpyAsyncTaskInfo.size;
    taskAsync2d->stmArgPos = static_cast<DavidStream*>(dstStm)->GetArgPos();
    error = DavidSendTask(taskAsync2d, dstStm);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to submit task (stream_id=%d), pos=%u, retCode=%#x.", stm->Id_(), pos,
        static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->GetExposedStreamId(), taskAsync2d->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to perform post-processing of task (stream_id=%d) submission, retCode=%#x.", stm->Id_(),
        static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t MemcopyBatchAsync(
    AsyncDmaBatchInfo& batchInfo, uint64_t* const realCnt, uint64_t* const realSize, Stream* const stm,
    const MemcpyBatchTaskParamsInput* const params)
{
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to check stream (stream_id=%d), retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    TaskInfo* taskAsyncBatch = nullptr;
    Stream* dstStm = stm;
    std::function<void()> const errRecycle = [&taskAsyncBatch, &stm, &pos, &dstStm]() {
        TaskUnInitProc(taskAsyncBatch);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();
    };
    const uint32_t sqeNum = GetSqeNumForMemcopyAsync(
        RT_MEMCPY_RESERVED, false, UINT32_MAX, static_cast<uint32_t>(rtAsyncCpyMethod::RT_ASYNC_CPY_BATCH));
    stm->StreamLock();
    taskAsyncBatch = stm->AllocTask(nullptr, TS_TASK_TYPE_MEMCPY, error, sqeNum);
    COND_PROC_RETURN_ERROR_MSG_INNER(taskAsyncBatch == nullptr, error, stm->StreamUnLock();
                                     , "Failed to alloc task (stream_id=%d), retCode=%#x.", stm->Id_(),
                                     static_cast<uint32_t>(error));
    pos = taskAsyncBatch->id;
    dstStm = taskAsyncBatch->stream;
    ScopeGuard tskErrRecycle(errRecycle);
    error = MemcpyAsyncBatchTaskInit(taskAsyncBatch, batchInfo, params);
    taskAsyncBatch->u.memcpyAsyncTaskInfo.copyMethod = static_cast<uint8_t>(rtAsyncCpyMethod::RT_ASYNC_CPY_BATCH);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to init task (stream_id=%d), retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    *realCnt = taskAsyncBatch->u.memcpyAsyncTaskInfo.size;
    *realSize = taskAsyncBatch->u.memcpyAsyncTaskInfo.ubDma.fixedSize;
    // David UB 单算子场景 如果驱动本次下发处理的count个数为0，则表示没有触发wqe下发，不需要下发ub db task
    if (IsDavidUbDma(taskAsyncBatch->u.memcpyAsyncTaskInfo.copyType) && (!stm->IsCapturing()) &&
        (!stm->GetBindFlag()) && (taskAsyncBatch->u.memcpyAsyncTaskInfo.size == 0ULL)) {
        RT_LOG(
            RT_LOG_WARNING, "In UB eager mode, no need to send taskAsyncBatch if fixedCnt is 0, stream_id=%d.",
            stm->Id_());
        return RT_ERROR_NONE;
    }
    taskAsyncBatch->stmArgPos = static_cast<DavidStream*>(dstStm)->GetArgPos();
    error = DavidSendTask(taskAsyncBatch, dstStm);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to submit task (stream_id=%d), pos=%u, retCode=%#x.", stm->Id_(), pos,
        static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), taskAsyncBatch->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to perform post-processing of task (stream_id=%d) submission, retCode=%#x.", stm->Id_(),
        static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t BatchSendH2DAsyncTask(
    void** const dsts, const size_t* const destMaxs, void** const srcs, const size_t* const sizes, const size_t count,
    Stream* const stm)
{
    rtError_t error = RT_ERROR_NONE;
    uint64_t realSize = 0ULL;

    if (!Runtime::Instance()->GetConnectUbFlag()) {
        for (size_t i = 0U; i < count; i++) {
            error = MemcopyAsync(
                dsts[i], destMaxs[i], srcs[i], sizes[i], RT_MEMCPY_HOST_TO_DEVICE, stm, &realSize, nullptr);
            COND_PROC((error != RT_ERROR_NONE), return error;);
        }

        return RT_ERROR_NONE;
    }

    uint64_t realCnt = 0ULL;
    uint64_t remainCnt = count;
    uint64_t fixedCnt = 0ULL;
    uint64_t fixedSize = 0ULL;

    std::vector<void*> localDsts(dsts, dsts + count);
    std::vector<void*> localSrcs(srcs, srcs + count);
    std::vector<uint64_t> localSizes(sizes, sizes + count);
    while (remainCnt > 0ULL) {
        AsyncDmaBatchInfo batchInfo = {localDsts.data(), localSrcs.data(), localSizes.data(),
                                       remainCnt,        fixedCnt,         fixedSize};
        error = MemcopyBatchAsync(batchInfo, &realCnt, &realSize, stm);
        COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
        COND_RETURN_ERROR(
            realCnt > remainCnt, RT_ERROR_DRV_ERR,
            "Invalid memcpy batch progress, realCnt=%" PRIu64 ", remainCnt=%" PRIu64 ".", realCnt, remainCnt);
        // realCnt 本次处理的
        fixedCnt = realCnt;
        fixedSize = realSize;
        remainCnt -= fixedCnt;
        if (remainCnt > 0ULL) {
            error = stm->Synchronize();
            ERROR_RETURN_MSG_INNER(error, "Failed to synchronize stream, retCode=%#x.", static_cast<uint32_t>(error));
        }
    }

    return RT_ERROR_NONE;
}

static bool isModelByUb(const Stream* const stm)
{
    if ((stm->IsCapturing() || stm->GetBindFlag()) && (Runtime::Instance()->GetConnectUbFlag())) {
        return true;
    }
    return false;
}

rtError_t MemcopyAsync(
    void* const dst, const uint64_t destMax, const void* const src, const uint64_t cpySize, const rtMemcpyKind_t kind,
    Stream* const stm, uint64_t* const realSize, const std::shared_ptr<void>& guardMem,
    const rtTaskCfgInfo_t* const cfgInfo, const rtD2DAddrCfgInfo_t* const addrCfg)
{
    UNUSED(destMax);
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(stm, RT_ERROR_STREAM_NULL, "Asynchronous memory copy");

    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to check stream (stream_id=%d), error=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    TaskInfo* rtMemcpyAsyncTask = nullptr;
    uint32_t transType = UINT32_MAX;
    if (kind == RT_MEMCPY_DEVICE_TO_DEVICE) {
        error = ConvertD2DCpyType(stm, transType, src, dst);
        ERROR_RETURN_MSG_INNER(error, "ConvertD2DCpyType failed, retCode=%#x.", static_cast<uint32_t>(error));
    }
    const uint32_t sqeNum = GetSqeNumForMemcopyAsync(kind, isModelByUb(stm), transType);
    uint32_t pos = 0xFFFFU;
    Stream* dstStm = stm;
    std::function<void()> const errRecycle = [&rtMemcpyAsyncTask, &stm, &pos, &dstStm]() {
        TaskUnInitProc(rtMemcpyAsyncTask);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();
    };
    stm->StreamLock();
    rtMemcpyAsyncTask = stm->AllocTask(nullptr, TS_TASK_TYPE_MEMCPY, error, sqeNum);
    COND_PROC_RETURN_ERROR_MSG_INNER(rtMemcpyAsyncTask == nullptr, error, stm->StreamUnLock();
                                     , "Failed to alloc task, stream_id=%d, retCode=%#x.", stm->Id_(),
                                     static_cast<uint32_t>(error));
    pos = rtMemcpyAsyncTask->id;
    dstStm = rtMemcpyAsyncTask->stream;
    ScopeGuard tskErrRecycle(errRecycle);
    error = MemcpyAsyncTaskInitV3(rtMemcpyAsyncTask, kind, src, dst, cpySize, cfgInfo, addrCfg);
    ERROR_RETURN_MSG_INNER(
        error, "Init MemcpyAsyncTask failed, stream_id=%d, retCode=%#x", stm->Id_(), static_cast<uint32_t>(error));
    *realSize = rtMemcpyAsyncTask->u.memcpyAsyncTaskInfo.size;
    if (guardMem != nullptr) {
        rtMemcpyAsyncTask->u.memcpyAsyncTaskInfo.guardMemVec->emplace_back(guardMem);
    }

    rtMemcpyAsyncTask->stmArgPos = static_cast<DavidStream*>(dstStm)->GetArgPos();
    error = DavidSendTask(rtMemcpyAsyncTask, dstStm);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to submit task (stream_id=%d), pos=%u, retCode=%#x.", stm->Id_(), pos,
        static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->GetExposedStreamId(), rtMemcpyAsyncTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to perform post-processing of task (stream_id=%d) submission, retCode=%#x.", stm->Id_(),
        static_cast<uint32_t>(error));
    return error;
}

static rtError_t SendMemsetAsyncTask(
    Stream* const stm, void* const ptr, const uint64_t destMax, const uint32_t fillVal, const uint64_t fillCount,
    const uint32_t elementSize)
{
    Stream* dstStm = stm;
    TaskInfo* memsetTask = nullptr;
    uint32_t pos = 0xFFFFU;
    rtError_t error = CheckTaskCanSend(dstStm);
    ERROR_RETURN_MSG_INNER(
        error, "CheckTaskCanSend for Memset failed, stream_id=%d, retCode=%#x.", stm->Id_(),
        static_cast<uint32_t>(error));
    std::function<void()> const errRecycle = [&memsetTask, &stm, &pos, &dstStm]() {
        TaskUnInitProc(memsetTask);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();
    };
    stm->StreamLock();

    memsetTask = stm->AllocTask(nullptr, TS_TASK_TYPE_MEMSET, error);
    COND_PROC_RETURN_ERROR_MSG_INNER(memsetTask == nullptr, error, stm->StreamUnLock();
                                     , "Failed to alloc task for Memset, stream_id=%d, retCode=%#x.", stm->Id_(),
                                     static_cast<uint32_t>(error));
    pos = memsetTask->id;
    dstStm = memsetTask->stream;
    ScopeGuard tskErrRecycle(errRecycle);
    MemsetAsyncTaskInit(memsetTask, ptr, destMax, fillVal, fillCount, elementSize);

    error = DavidSendTask(memsetTask, dstStm);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to submit task (stream_id=%d), retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->GetExposedStreamId(), memsetTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to perform post-processing of task (stream_id=%d) submission, retCode=%#x.", stm->Id_(),
        static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
}

rtError_t DevMemSetAsyncByMemset(
    Stream* const stm, void* const ptr, const uint64_t destMax, const uint32_t fillVal, const uint64_t fillCount,
    const uint32_t elementSize)
{
    // SQE 的 lengthMove 为 32bit 字段（单次上限 4GB-1），取能放入 u32 的最大 2 的幂（2GB）：
    // 保证分块后各块起始地址继承首地址的对齐（如 4 字节对齐），且整块长度为 4 的倍数，
    // 满足 D32 memset 按 32bit 字填充的语义；若取 UINT32_MAX（奇数）会破坏后续块的对齐
    constexpr uint64_t MEMSET_SQE_MAX_LEN = 0x80000000ULL;
    uint64_t doneSize = 0ULL;
    do {
        const uint64_t chunkSize = std::min(fillCount - doneSize, MEMSET_SQE_MAX_LEN);
        const rtError_t error = SendMemsetAsyncTask(
            stm, RtPtrToPtr<char_t*, void*>(ptr) + doneSize, destMax - doneSize, fillVal, chunkSize, elementSize);
        ERROR_RETURN_MSG_INNER(
            error, "Memset chunk submit failed, stream_id=%d, offset=%" PRIu64 ", size=%" PRIu64 ", retCode=%#x.",
            stm->Id_(), doneSize, chunkSize, static_cast<uint32_t>(error));
        doneSize += chunkSize;
    } while (doneSize < fillCount);

    return RT_ERROR_NONE;
}

rtError_t SetMemcpyDesc(
    rtMemcpyDesc_t desc, const void* const srcAddr, const void* const dstAddr, const size_t count,
    const Device* const device)
{
    rtDavidMemcpyAddrInfo memcpyData;
    (void)memset_s(&memcpyData, sizeof(rtDavidMemcpyAddrInfo), 0, sizeof(rtDavidMemcpyAddrInfo));

    memcpyData.len = static_cast<uint32_t>(count);
    memcpyData.src = RtPtrToValue<const void*>(srcAddr);
    memcpyData.dst = RtPtrToValue<const void*>(dstAddr);

    constexpr uint64_t dstMax = MEMCPY_DESC_SIZE_V2; // 64U
    rtError_t error = RT_ERROR_NONE;

    error = device->Driver_()->MemCopySync(
        static_cast<rtDavidMemcpyAddrInfo*>(desc), dstMax, &memcpyData, dstMax, RT_MEMCPY_HOST_TO_DEVICE);
    ERROR_RETURN(
        error, "Failed to memory copy stream info, device_id=%u, dstMax=%u, retCode=%#x.", device->Id_(), dstMax,
        static_cast<uint32_t>(error));

    if (device->Driver_()->GetRunMode() == RT_RUN_MODE_ONLINE) {
        error = device->Driver_()->DevMemFlushCache(RtPtrToPtr<uintptr_t>(desc), static_cast<size_t>(dstMax));
        ERROR_RETURN(
            error, "Failed to flush stream info, device_id=%u, retCode=%#x", device->Id_(),
            static_cast<uint32_t>(error));
    }

    RT_LOG(RT_LOG_INFO, "Set memcpyDesc info success, srcAddr=%p, dstAddr=%p, count=%llu", srcAddr, dstAddr, count);
    return RT_ERROR_NONE;
}

rtError_t MemcopyAsyncForUBDma(
    void* const dst, const uint64_t destMax, const void* const src, const uint64_t cpySize, const rtMemcpyKind_t kind,
    Stream* const stm, const rtTaskCfgInfo_t* const cfgInfo, const rtD2DAddrCfgInfo_t* const addrCfg)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(stm, RT_ERROR_STREAM_NULL, "Asynchronous memory copy");
    if (cpySize == 0U) {
        return RT_ERROR_NONE;
    }

    constexpr uint64_t maxSegmentNumPerChunk = 2U;
    const uint64_t chunkNum = (cpySize / MEMCPY_ASYNC_UB_SIZE) + (((cpySize % MEMCPY_ASYNC_UB_SIZE) != 0U) ? 1U : 0U);
    COND_RETURN_ERROR(
        chunkNum > (std::numeric_limits<uint32_t>::max() / maxSegmentNumPerChunk), RT_ERROR_INVALID_VALUE,
        "The number of host VMM address segments exceeds the upper limit, count=%" PRIu64 ".", cpySize);
    uint32_t rangeCnt = static_cast<uint32_t>(chunkNum * maxSegmentNumPerChunk);
    std::unique_ptr<addr_range[]> ranges(new (std::nothrow) addr_range[rangeCnt]);
    COND_RETURN_ERROR(
        ranges == nullptr, RT_ERROR_MEMORY_ALLOCATION,
        "Failed to allocate host VMM address segment array, segmentCapacity=%u.", rangeCnt);

    const bool isH2D = (kind == RT_MEMCPY_HOST_TO_DEVICE);
    const uint64_t hostAddr = isH2D ? RtPtrToValue(src) : RtPtrToValue(dst);
    rtError_t error = NpuDriver::MemGetAddrSegOfUB(stm->Device_()->Id_(), hostAddr, cpySize, ranges.get(), &rangeCnt);
    ERROR_RETURN_MSG_INNER(
        error, "Get host VMM address segments failed, count=%" PRIu64 ", retCode=%#x.", cpySize,
        static_cast<uint32_t>(error));

    uint64_t totalSize = 0U;
    for (uint32_t i = 0U; i < rangeCnt; ++i) {
        const addr_range& range = ranges[i];
        if ((range.addr == 0U) || (range.size == 0U) || (range.size > (cpySize - totalSize)) ||
            (range.addr > (std::numeric_limits<uint64_t>::max() - (range.size - 1U)))) {
            RT_LOG(
                RT_LOG_ERROR,
                "Invalid host VMM address segment, index=%u, segmentCnt=%u, addr=0x%" PRIx64 ", size=%" PRIu64
                ", count=%" PRIu64 ".",
                i, rangeCnt, range.addr, range.size, cpySize);
            return RT_ERROR_DRV_ERR;
        }
        totalSize += range.size;
    }
    COND_RETURN_ERROR(
        totalSize != cpySize, RT_ERROR_DRV_ERR,
        "The total size of host VMM address segments is invalid, segmentCnt=%u, totalSize=%" PRIu64 ", count=%" PRIu64
        ".",
        rangeCnt, totalSize, cpySize);

    uint64_t doneSize = 0U;
    for (uint32_t i = 0U; i < rangeCnt; ++i) {
        const uint64_t doingSize = ranges[i].size;
        uint64_t realSize = doingSize;
        error = MemcopyAsync(
            static_cast<void*>(static_cast<char_t*>(dst) + doneSize), destMax - doneSize,
            static_cast<const void*>(static_cast<const char_t*>(src) + doneSize), doingSize, kind, stm, &realSize,
            nullptr, cfgInfo, addrCfg);
        if (error != RT_ERROR_NONE) {
            RT_LOG(
                RT_LOG_ERROR,
                "Copy host VMM address segment failed, index=%u, segmentCnt=%u, doneSize=%" PRIu64
                ", doingSize=%" PRIu64 ", realSize=%" PRIu64 ", retCode=%#x.",
                i, rangeCnt, doneSize, doingSize, realSize, static_cast<uint32_t>(error));
            return error;
        }
        COND_RETURN_ERROR(
            realSize != doingSize, RT_ERROR_DRV_ERR,
            "Invalid actual copy size, index=%u, segmentCnt=%u, doingSize=%" PRIu64 ", realSize=%" PRIu64 ".", i,
            rangeCnt, doingSize, realSize);
        doneSize += doingSize;
        RT_LOG(
            RT_LOG_DEBUG,
            "Copy host VMM address segment success, index=%u, segmentCnt=%u, addr=0x%" PRIx64 ", size=%" PRIu64
            ", doneSize=%" PRIu64 ".",
            i, rangeCnt, ranges[i].addr, ranges[i].size, doneSize);
    }
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
