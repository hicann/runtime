/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "cc_worker.h"
#include <algorithm>
#include <chrono>
#include <cstdio>
#include <cstring>
#include <thread>
#include "ascend_hal_base.h"
#include "cc_manager.h"
#include "crypto/cc_crypto_plugin.h"
#include "cc_stream_res_manage.h"
#include "common/cc_utils.h"
#include "context.hpp"
#include "device.hpp"
#include "driver.hpp"
#include "stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "type_def.h"
namespace cce {
namespace runtime {
static constexpr uint64_t CC_TIMEOUT_MS = 18ULL * 60ULL * 1000ULL;

void DebugDumpRingState(
    const char_t* const where, const uint32_t workerId, const BarTaskQueue* const barQueue, const uint32_t expectSlices)
{
    if (barQueue == nullptr) {
        return;
    }
    static thread_local std::chrono::steady_clock::time_point lastDump{};
    const auto now = std::chrono::steady_clock::now();
    if ((now - lastDump) < std::chrono::seconds(1)) {
        return;
    }
    lastDump = now;
    RT_LOG(
        RT_LOG_DEBUG,
        "CC ring dump [%s] worker=%u hostStatus=%d deviceStatus=%d complete=%u head=%u tail=%u depth=%u "
        "descSize=%u expect=%u",
        where, workerId, static_cast<int32_t>(barQueue->hostStatus), static_cast<int32_t>(barQueue->deviceStatus),
        barQueue->complete, barQueue->head, barQueue->tail, barQueue->depth, barQueue->taskDescSize, expectSlices);
}

CCWorker::~CCWorker() { Destroy(); }

rtError_t CCWorker::Init(
    uint32_t workerId, uint32_t sliceSize, CCMemcpyTaskQueue* taskQueue, Device* device, CCCryptoPlugin* plugin)
{
    COND_RETURN_ERROR(device == nullptr, RT_ERROR_DEVICE_NULL, "CC worker device is null.");
    COND_RETURN_ERROR(plugin == nullptr, RT_ERROR_INVALID_VALUE, "CC worker crypto plugin is null.");
    workerId_ = workerId;
    maxSliceSize_ = sliceSize;
    taskQueue_ = taskQueue;
    device_ = device;
    plugin_ = plugin;
    cancelled_.store(false);

    void* rawBuf = nullptr;
    rtError_t ret = device_->Driver_()->HostMemAlloc(&rawBuf, maxSliceSize_, device_->Id_());
    if (ret != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "CC worker %u failed to alloc hostCryptoBuf, size=%u, ret=%#x", workerId_, maxSliceSize_,
            ret);
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, maxSliceSize_, "HostMemAlloc");
        return ret;
    }
    hostCryptoBuf_ = rawBuf;

    ret = device_->Driver_()->HostDmaMap(hostCryptoBuf_, maxSliceSize_, device_->Id_());
    if ((ret == RT_ERROR_FEATURE_NOT_SUPPORT) || (ret == RT_ERROR_DRV_NOT_SUPPORT)) {
        RT_LOG(RT_LOG_INFO, "CC worker %u: host DMA map unavailable, fallback to HostRegister.", workerId_);
        void* devPtr = nullptr;
        ret = device_->Driver_()->HostRegister(
            hostCryptoBuf_, maxSliceSize_, RT_MEM_HOST_REGISTER_PINNED, &devPtr, device_->Id_());
    }
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "CC worker %u failed to map/register hostCryptoBuf, ret=%#x", workerId_, ret);
        Destroy();
        return ret;
    }
    hostCryptoRegistered_ = true;

    for (uint32_t i = 0U; i < CC_BUFFER_SLOT_NUM; ++i) {
        ret = device_->Driver_()->DevMemAllocWithBackupFlag(
            &deviceBuffers_[i], maxSliceSize_, RT_MEMORY_HBM, device_->Id_(), DevMemBackupType::SNAPSHOT_NO_BACKUP);
        if (ret != RT_ERROR_NONE) {
            RT_LOG(
                RT_LOG_ERROR, "CC worker %u failed to allocate Device buffer %u, size=%u, ret=%#x", workerId_, i,
                maxSliceSize_, ret);
            RT_LOG_OUTER_MSG_IMPL(
                ErrorCode::EE1023, "Alloc device memory for data transfer", "Device memory is insufficient");
            Destroy();
            return ret;
        }
    }

    RT_LOG(
        RT_LOG_INFO, "CC worker %u initialized, sliceSize=%u, deviceId=%u", workerId_, maxSliceSize_, device_->Id_());
    return RT_ERROR_NONE;
}

void CCWorker::Destroy()
{
    // 线程已由所属线程池 Join，此处只释放搬运缓冲。
    cancelled_.store(true);

    if (hostCryptoRegistered_ && (device_ != nullptr) && (device_->Driver_() != nullptr)) {
        rtError_t ret = device_->Driver_()->HostDmaUnmap(hostCryptoBuf_, device_->Id_());
        if (ret == RT_ERROR_FEATURE_NOT_SUPPORT) {
            ret = device_->Driver_()->HostUnregister(hostCryptoBuf_, device_->Id_());
        }
        if (ret != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "CC worker %u: HostDmaUnmap/HostUnregister failed, ret=%#x", workerId_, ret);
        }
        hostCryptoRegistered_ = false;
    }

    if (hostCryptoBuf_ != nullptr) {
        if (device_ != nullptr && device_->Driver_() != nullptr) {
            rtError_t ret = device_->Driver_()->HostMemFree(hostCryptoBuf_);
            if (ret != RT_ERROR_NONE) {
                RT_LOG(RT_LOG_ERROR, "CC worker %u: HostMemFree failed, ret=%#x", workerId_, ret);
            }
        }
        hostCryptoBuf_ = nullptr;
    }

    if ((device_ != nullptr) && (device_->Driver_() != nullptr)) {
        for (uint32_t i = 0U; i < CC_BUFFER_SLOT_NUM; ++i) {
            if (deviceBuffers_[i] != nullptr) {
                rtError_t ret = device_->Driver_()->DevMemFree(deviceBuffers_[i], device_->Id_());
                if (ret != RT_ERROR_NONE) {
                    RT_LOG(RT_LOG_ERROR, "CC worker %u: DevMemFree buffer %u failed, ret=%#x", workerId_, i, ret);
                }
                deviceBuffers_[i] = nullptr;
            }
        }
    }
    device_ = nullptr;
}

void* CCWorker::DeviceBuffer(const uint32_t sliceIdx) const
{
    // 分片序号交替映射到 Device Buffer A/B，保证双缓冲不冲突
    const uint32_t slot = AiccSliceDescBase::PhysicalBufferIndex(sliceIdx);
    return (slot < CC_BUFFER_SLOT_NUM) ? deviceBuffers_[slot] : nullptr;
}

void CCWorker::Run()
{
    while (true) {
        CCMemcpyTask task{};
        if (!taskQueue_->Pop(task)) {
            break;
        }
        rtError_t ret = ProcessTask(task);
        if (ret != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "CC worker %u: ProcessTask failed, ret=%#x", workerId_, ret);
        }
    }
    RT_LOG(RT_LOG_INFO, "CC worker %u exited", workerId_);
}

bool CCWorker::ShouldWorkerExit(const uint32_t streamId) const
{
    if (cancelled_.load()) {
        return true;
    }
    if ((device_ == nullptr) || (device_->GetStreamSqCqManage() == nullptr)) {
        return true;
    }
    std::shared_ptr<Stream> stream;
    if (device_->GetStreamSqCqManage()->GetStreamSharedPtrById(streamId, stream) != RT_ERROR_NONE) {
        return true;
    }
    // 外部中断优先于超时判断：快恢 stop 阶段、流 abort、遇错即停均由 engine 上报错误，worker 静默退出。
    if (stream->GetAbortStatus() != RT_ERROR_NONE) {
        return true;
    }
    if (device_->GetDeviceStatus() != RT_ERROR_NONE) {
        return true;
    }
    if (stream->GetFailureMode() == ABORT_ON_FAILURE) {
        return true;
    }
    // 增加stream res manager 非空校验，处理流强制销毁场景
    if (stream->GetCCStreamResource() == nullptr) {
        return true;
    }
    mmTimespec now = mmGetTickCount();
    uint64_t nowMs = static_cast<uint64_t>(now.tv_sec) * RT_MS_PER_S + static_cast<uint64_t>(now.tv_nsec) / RT_MS_TO_NS;
    return nowMs > deadlineMs_;
}

rtError_t CCWorker::SetupTask(
    CCMemcpyTask& task, std::shared_ptr<Stream>& stream, CCStreamResManage*& resource, uint32_t& sliceNum)
{
    rtError_t ret = device_->GetStreamSqCqManage()->GetStreamSharedPtrById(task.streamId, stream);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_INFO, "CC worker %u: stream has been destroyed, stream_id=%u", workerId_, task.streamId);
        return RT_ERROR_NONE;
    }

    // 先设定本次任务 deadline，保证 ShouldWorkerExit 的超时判断基于本任务而非上一任务的残留值。
    mmTimespec startTime = mmGetTickCount();
    deadlineMs_ = static_cast<uint64_t>(startTime.tv_sec) * RT_MS_PER_S +
                  static_cast<uint64_t>(startTime.tv_nsec) / RT_MS_TO_NS + CC_TIMEOUT_MS;

    resource = stream->GetCCStreamResource();
    if (resource == nullptr) {
        RT_LOG(RT_LOG_ERROR, "CC worker %u: task stream resource is null, stream_id=%u", workerId_, task.streamId);
        return RT_ERROR_CC_WORKER_FAILED;
    }

    BarTaskQueue* const barQueue = resource->BarQueue();
    if (barQueue == nullptr) {
        RT_LOG(RT_LOG_ERROR, "CC worker %u: task bar queue is null", workerId_);
        return RT_ERROR_CC_WORKER_FAILED;
    }

    size_t totalSize = task.totalSize;
    const uint64_t sliceNum64 = (totalSize + CC_PLAINTEXT_SLICE_SIZE - 1U) / CC_PLAINTEXT_SLICE_SIZE;
    sliceNum = static_cast<uint32_t>(sliceNum64);

    // 外部中断预检：遇错即停/快恢等场景下静默丢弃任务
    if (ShouldWorkerExit(task.streamId)) {
        resource->BarQueue()->hostStatus = TASK_QUEUE_STATUS_TERMINATED;
        RT_LOG(RT_LOG_WARNING, "CC worker %u: task dropped, stream_id=%u", workerId_, task.streamId);
        return RT_ERROR_NONE;
    }
    return RT_ERROR_NONE;
}

rtError_t CCWorker::ProcessTask(CCMemcpyTask& task)
{
    const rtError_t ret = ProcessTaskImpl(task);
    if (ret != RT_ERROR_NONE) {
        FailTask(task, ret);
    }
    return ret;
}

void CCWorker::FailTask(const CCMemcpyTask& task, const rtError_t ret) const
{
    std::shared_ptr<Stream> stream;
    if ((device_ == nullptr) || (device_->GetStreamSqCqManage() == nullptr) ||
        (device_->GetStreamSqCqManage()->GetStreamSharedPtrById(task.streamId, stream) != RT_ERROR_NONE) ||
        (stream == nullptr)) {
        RT_LOG(
            RT_LOG_ERROR, "CC worker %u: task failed but stream gone, stream=%u ret=%#x", workerId_, task.streamId,
            static_cast<uint32_t>(ret));
        return;
    }
    CCStreamResManage* const resource = stream->GetCCStreamResource();
    if (resource == nullptr) {
        return;
    }
    BarTaskQueue* const barQueue = resource->BarQueue();
    if (barQueue != nullptr) {
        barQueue->hostStatus = TASK_QUEUE_STATUS_TERMINATED; // 通知设备核退出消费与 MEM_WAIT
    }
    stream->SetErrCode(static_cast<uint32_t>(RT_ERROR_HOST_FUNC_EXE_FAILED));
    stream->SetAbortStatus(RT_ERROR_STREAM_ABORT);
    if (taskQueue_ != nullptr) {
        (void)taskQueue_->CancelTasksByStream(task.streamId);
    }
    RT_LOG(
        RT_LOG_ERROR, "CC worker %u: task failed, stream=%u ret=%#x head=%u tail=%u complete=%u devErr=%u", workerId_,
        task.streamId, static_cast<uint32_t>(ret), (barQueue == nullptr) ? 0U : barQueue->head,
        (barQueue == nullptr) ? 0U : barQueue->tail, (barQueue == nullptr) ? 0U : barQueue->complete,
        (barQueue == nullptr) ? 0U : barQueue->deviceErrCode);
}

rtError_t CCWorker::ProcessTaskImpl(CCMemcpyTask& task)
{
    RT_LOG(RT_LOG_DEBUG, "CC worker %u: ProcessTask enter, stream_id=%u.", workerId_, task.streamId);
    std::shared_ptr<Stream> stream;
    CCStreamResManage* resource = nullptr;
    uint32_t sliceNum = 0U;

    rtError_t ret = SetupTask(task, stream, resource, sliceNum);
    if (ret != RT_ERROR_NONE || stream == nullptr || resource == nullptr) {
        // resource 为 nullptr 表示任务在 SetupTask 中被静默丢弃（流销毁/外部中断），无需设置错误码。
        return ret;
    }

    COND_RETURN_ERROR(plugin_ == nullptr, RT_ERROR_CC_INIT_FAILED, "CC worker crypto plugin is null.");
    const std::lock_guard<std::mutex> processLock(resource->ProcessMutex());
    // 同流锁覆盖重置、发布和消费确认，防止多个 worker 相互重置环状态。
    bool proceed = false;
    ret = BeginBarTaskRound(resource->BarQueue(), &proceed);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "CC worker %u: begin bar task round failed, ret=%#x.", workerId_, ret);
    if (!proceed) {
        resource->BarQueue()->hostStatus = TASK_QUEUE_STATUS_TERMINATED;
        RT_LOG(
            RT_LOG_WARNING, "CC worker %u: queue terminated before round, task dropped, stream_id=%u", workerId_,
            task.streamId);
        return RT_ERROR_NONE;
    }
    void* pluginTaskCtx = nullptr;
    ret = plugin_->OnTaskBegin(task, device_->Id_(), sliceNum, &pluginTaskCtx);
    if (ret != RT_ERROR_NONE) {
        resource->BarQueue()->hostStatus = TASK_QUEUE_STATUS_TERMINATED;
        return ret;
    }
    BarTaskQueue* const barQueue = resource->BarQueue();
    if (!__sync_bool_compare_and_swap(&barQueue->hostStatus, TASK_QUEUE_STATUS_WAITING, TASK_QUEUE_STATUS_WORKING)) {
        switch (barQueue->hostStatus) {
            case TASK_QUEUE_STATUS_WORKING:
                break;
            case TASK_QUEUE_STATUS_TERMINATED:
                plugin_->OnTaskEnd(task, device_->Id_(), sliceNum, pluginTaskCtx);
                RT_LOG(
                    RT_LOG_WARNING, "CC worker %u: queue terminated, task dropped, stream_id=%u", workerId_,
                    task.streamId);
                return RT_ERROR_NONE;
            default:
                barQueue->hostStatus = TASK_QUEUE_STATUS_TERMINATED;
                plugin_->OnTaskEnd(task, device_->Id_(), sliceNum, pluginTaskCtx);
                RT_LOG(
                    RT_LOG_ERROR, "CC worker %u: unexpected host status %d when arming doorbell, stream_id=%u",
                    workerId_, static_cast<int32_t>(barQueue->hostStatus), task.streamId);
                return RT_ERROR_CC_WORKER_FAILED;
        }
    }
    ret = ProcessSlices(task, resource, sliceNum, pluginTaskCtx);
    if (task.kind == RT_MEMCPY_HOST_TO_DEVICE) {
        if (ret == RT_ERROR_NONE) {
            ret = WaitH2DConsumed(task.streamId, resource->BarQueue(), sliceNum);
        }
        uint32_t doneIdx = 0U;
        // 失败时不能等待未发布的分片；残留资源由 OnTaskEnd 归还。
        (void)RetireDoneH2DSlices(task, resource, sliceNum, pluginTaskCtx, doneIdx, ret == RT_ERROR_NONE);
    }
    plugin_->OnTaskEnd(task, device_->Id_(), sliceNum, pluginTaskCtx);
    if (ret != RT_ERROR_NONE) {
        barQueue->hostStatus = TASK_QUEUE_STATUS_TERMINATED;
    } else {
        (void)__sync_bool_compare_and_swap(&barQueue->hostStatus, TASK_QUEUE_STATUS_WORKING, TASK_QUEUE_STATUS_WAITING);
    }

    return ret;
}

rtError_t CCWorker::WaitD2HSliceDone(
    const uint32_t streamId, BarTaskQueue* const barQueue, const uint32_t sliceIdx) const
{
    COND_RETURN_ERROR(barQueue == nullptr, RT_ERROR_CC_WORKER_FAILED, "CC worker bar task queue is null.");
    const auto waitStart = std::chrono::steady_clock::now();
    for (;;) {
        uint32_t completed = 0U;
        const rtError_t ret = GetCompletedBarTaskNum(barQueue, &completed);
        COND_RETURN_ERROR(
            ret != RT_ERROR_NONE, ret, "CC worker %u: get completed num failed, slice=%u, ret=%#x.", workerId_,
            sliceIdx, ret);
        if (completed > sliceIdx) {
            break;
        }
        if (ShouldWorkerExit(streamId)) {
            return RT_ERROR_CC_WORKER_TIMEOUT;
        }
        DebugDumpRingState("WaitD2HSliceDone", workerId_, barQueue, sliceIdx + 1U);
        CCSpinWait(waitStart);
    }
    __sync_synchronize();
    return RT_ERROR_NONE;
}

constexpr uint32_t CC_SLICE_DESC_MAX_SIZE = 64U;
constexpr uint32_t CC_SLICE_DESC_ALIGN_BYTES = 8U;

static void FillSliceDescCommon(AiccSliceDescBase* desc, const void* remoteAddr, size_t sliceSize, uint32_t sliceIdx)
{
    desc->ciphertextAddr = PtrToValue(nullptr);
    desc->plaintextAddr = PtrToValue(remoteAddr);
    desc->ciphertextLen = 0U; // 由插件钩子按算法密文格式填充
    desc->plaintextLen = static_cast<uint32_t>(sliceSize);
    desc->sliceIdx = sliceIdx;
}

rtError_t CCWorker::ProcessSlices(
    CCMemcpyTask& task, CCStreamResManage* const resource, uint32_t sliceNum, void* pluginTaskCtx) const
{
    size_t totalSize = task.totalSize;
    rtError_t ret = RT_ERROR_NONE;
    uint32_t doneIdx = 0U; // H2D 已回调（分片完成通知）的分片水位

    for (uint32_t i = 0U; i < sliceNum; ++i) {
        if (ShouldWorkerExit(task.streamId)) {
            RT_LOG(RT_LOG_ERROR, "CC worker %u: hook task interrupted, slice=%u/%u", workerId_, i, sliceNum);
            break;
        }
        if (task.kind == RT_MEMCPY_HOST_TO_DEVICE) {
            ret = RetireDoneH2DSlices(task, resource, sliceNum, pluginTaskCtx, doneIdx, false);
            if (ret != RT_ERROR_NONE) {
                break;
            }
        }

        size_t offset = static_cast<size_t>(i) * CC_PLAINTEXT_SLICE_SIZE;
        size_t sliceSize = std::min(static_cast<size_t>(CC_PLAINTEXT_SLICE_SIZE), totalSize - offset);

        if (task.kind == RT_MEMCPY_HOST_TO_DEVICE) {
            ret = ProcessH2DSlice(task, resource, i, offset, sliceSize, pluginTaskCtx);
        } else if (task.kind == RT_MEMCPY_DEVICE_TO_HOST) {
            ret = ProcessD2HSlice(task, resource, i, offset, sliceSize, sliceNum, pluginTaskCtx);
        } else {
            RT_LOG(RT_LOG_ERROR, "CC worker %u: unsupported memcpy kind %d", workerId_, task.kind);
            ret = RT_ERROR_INVALID_VALUE;
        }
        if (ret != RT_ERROR_NONE) {
            break;
        }
    }

    return ret;
}

rtError_t CCWorker::RetireDoneH2DSlices(
    CCMemcpyTask& task, CCStreamResManage* const resource, uint32_t totalSlices, void* pluginTaskCtx, uint32_t& doneIdx,
    bool waitAll) const
{
    BarTaskQueue* const barQueue = resource->BarQueue();
    rtError_t ret = RT_ERROR_NONE;
    const auto waitStart = std::chrono::steady_clock::now();
    while (doneIdx < totalSlices) {
        uint32_t completed = 0U;
        ret = GetCompletedBarTaskNum(barQueue, &completed);
        if (ret != RT_ERROR_NONE) {
            return ret;
        }
        if (completed <= doneIdx) {
            if (!waitAll) {
                return RT_ERROR_NONE; // 非阻塞收割：暂无新完成分片
            }
            if (ShouldWorkerExit(task.streamId)) {
                return RT_ERROR_NONE; // 外部中断：剩余分片由 OnTaskEnd 兜底释放
            }
            DebugDumpRingState("RetireH2D wait", workerId_, barQueue, doneIdx + 1U);
            CCSpinWait(waitStart);
            continue;
        }
        CCCryptoSliceCtx ctx{nullptr, nullptr, nullptr, nullptr, 0U, doneIdx, device_->Id_(), pluginTaskCtx};
        ret = plugin_->OnH2DSliceDone(ctx);
        if (ret != RT_ERROR_NONE) {
            RT_LOG(
                RT_LOG_ERROR, "CC worker %u: slice done callback failed, slice=%u, ret=%#x", workerId_, doneIdx, ret);
            return ret;
        }
        ++doneIdx;
    }
    return RT_ERROR_NONE;
}

rtError_t CCWorker::ProcessH2DSlice(
    CCMemcpyTask& task, CCStreamResManage* const resource, uint32_t sliceIdx, size_t offset, size_t sliceSize,
    void* pluginTaskCtx) const
{
    BarTaskQueue* const barQueue = resource->BarQueue();
    const auto waitStart = std::chrono::steady_clock::now();
    while (true) {
        bool isFull = false;
        (void)IsBarTaskQueueFull(barQueue, &isFull);
        if (!isFull) {
            break;
        }
        if (ShouldWorkerExit(task.streamId)) {
            return RT_ERROR_CC_WORKER_TIMEOUT;
        }
        DebugDumpRingState("H2D wait slot", workerId_, barQueue, sliceIdx + 1U);
        CCSpinWait(waitStart);
    }

    alignas(CC_SLICE_DESC_ALIGN_BYTES) uint8_t descBuf[CC_SLICE_DESC_MAX_SIZE] = {0};
    auto* desc = reinterpret_cast<AiccSliceDescBase*>(descBuf);
    void* const deviceBuffer = DeviceBuffer(sliceIdx);
    FillSliceDescCommon(desc, static_cast<uint8_t*>(task.dst) + offset, sliceSize, sliceIdx);
    desc->ciphertextAddr = PtrToValue(deviceBuffer);

    CCCryptoSliceCtx ctx{
        desc,
        hostCryptoBuf_,
        static_cast<const uint8_t*>(task.src) + offset,
        static_cast<uint8_t*>(task.dst) + offset,
        sliceSize,
        sliceIdx,
        device_->Id_(),
        pluginTaskCtx};

    size_t dmaLen = 0U;
    rtError_t ret = plugin_->PrepareH2DSlice(ctx, dmaLen);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "CC worker %u: prepare H2D callback failed, slice=%u, ret=%#x", workerId_, sliceIdx, ret);
        return ret;
    }

    drvError_t drvRet =
        drvMemcpy(RtPtrToPtr<UINT64>(deviceBuffer), maxSliceSize_, RtPtrToPtr<UINT64>(hostCryptoBuf_), dmaLen);
    if (drvRet != 0) {
        RT_LOG(RT_LOG_ERROR, "CC worker %u: DMA H2D failed, slice=%u, ret=%d", workerId_, sliceIdx, drvRet);
        return RT_ERROR_CC_WORKER_FAILED;
    }

    const rtError_t pushRet = PushBarTask(barQueue, descBuf, plugin_->SliceDescSize());
    COND_RETURN_ERROR(
        pushRet != RT_ERROR_NONE, pushRet, "CC worker %u: push H2D hook slice failed, slice=%u, ret=%#x.", workerId_,
        sliceIdx, pushRet);
    return RT_ERROR_NONE;
}

rtError_t CCWorker::PublishD2HSlice(
    CCMemcpyTask& task, CCStreamResManage* const resource, uint32_t sliceIdx, size_t offset, size_t sliceSize,
    void* pluginTaskCtx) const
{
    BarTaskQueue* const barQueue = resource->BarQueue();
    const auto waitStart = std::chrono::steady_clock::now();
    while (true) {
        bool isFull = false;
        (void)IsBarTaskQueueFull(barQueue, &isFull);
        if (!isFull) {
            break;
        }
        if (ShouldWorkerExit(task.streamId)) {
            return RT_ERROR_CC_WORKER_TIMEOUT;
        }
        DebugDumpRingState("D2H wait slot", workerId_, barQueue, sliceIdx + 1U);
        CCSpinWait(waitStart);
    }

    alignas(CC_SLICE_DESC_ALIGN_BYTES) uint8_t descBuf[CC_SLICE_DESC_MAX_SIZE] = {0};
    auto* desc = reinterpret_cast<AiccSliceDescBase*>(descBuf);
    void* const deviceBuffer = DeviceBuffer(sliceIdx);
    FillSliceDescCommon(desc, static_cast<const uint8_t*>(task.src) + offset, sliceSize, sliceIdx);
    desc->ciphertextAddr = PtrToValue(deviceBuffer);

    CCCryptoSliceCtx ctx{
        desc,
        hostCryptoBuf_,
        static_cast<const uint8_t*>(task.src) + offset,
        static_cast<uint8_t*>(task.dst) + offset,
        sliceSize,
        sliceIdx,
        device_->Id_(),
        pluginTaskCtx};

    const rtError_t ret = plugin_->PrepareD2HSlice(ctx);
    COND_RETURN_ERROR(
        ret != RT_ERROR_NONE, ret, "CC worker %u: prepare D2H callback failed, slice=%u, ret=%#x.", workerId_, sliceIdx,
        ret);

    const rtError_t pushRet = PushBarTask(barQueue, descBuf, plugin_->SliceDescSize());
    COND_RETURN_ERROR(
        pushRet != RT_ERROR_NONE, pushRet, "CC worker %u: push D2H hook slice failed, slice=%u, ret=%#x.", workerId_,
        sliceIdx, pushRet);
    return RT_ERROR_NONE;
}

rtError_t CCWorker::ProcessD2HSlice(
    CCMemcpyTask& task, CCStreamResManage* const resource, uint32_t sliceIdx, size_t offset, size_t sliceSize,
    uint32_t totalSlices, void* pluginTaskCtx) const
{
    BarTaskQueue* const barQueue = resource->BarQueue();
    if (sliceIdx == 0U) {
        const rtError_t publishRet = PublishD2HSlice(task, resource, sliceIdx, offset, sliceSize, pluginTaskCtx);
        COND_RETURN_WITH_NOLOG(publishRet != RT_ERROR_NONE, publishRet);
    }

    rtError_t ret = WaitD2HSliceDone(task.streamId, barQueue, sliceIdx);
    COND_RETURN_WITH_NOLOG(ret != RT_ERROR_NONE, ret);

    bool nextPublished = false;
    uint32_t nextSliceIdx = sliceIdx + 1U;
    if (nextSliceIdx < totalSlices) {
        const size_t nextOffset = static_cast<size_t>(nextSliceIdx) * CC_PLAINTEXT_SLICE_SIZE;
        const size_t nextSliceSize =
            std::min(static_cast<size_t>(CC_PLAINTEXT_SLICE_SIZE), task.totalSize - nextOffset);
        const rtError_t publishRet =
            PublishD2HSlice(task, resource, nextSliceIdx, nextOffset, nextSliceSize, pluginTaskCtx);
        COND_RETURN_WITH_NOLOG(publishRet != RT_ERROR_NONE, publishRet);
        nextPublished = true;
    }

    void* const deviceBuffer = DeviceBuffer(sliceIdx);
    auto* const sliceDesc = reinterpret_cast<AiccSliceDescBase*>(
        barQueue->taskDescList + (static_cast<size_t>(sliceIdx % barQueue->depth) * barQueue->taskDescSize));
    const uint32_t ciphertextLen = sliceDesc->ciphertextLen;
    drvError_t drvRet =
        drvMemcpy(RtPtrToPtr<UINT64>(hostCryptoBuf_), maxSliceSize_, RtPtrToPtr<UINT64>(deviceBuffer), ciphertextLen);
    if (drvRet != 0) {
        if (nextPublished) {
            (void)WaitD2HSliceDone(task.streamId, barQueue, nextSliceIdx);
        }
        RT_LOG(RT_LOG_ERROR, "CC worker %u: DMA D2H failed, slice=%u, ret=%d", workerId_, sliceIdx, drvRet);
        return RT_ERROR_CC_WORKER_FAILED;
    }

    CCCryptoSliceCtx ctx{sliceDesc, hostCryptoBuf_, nullptr,        static_cast<uint8_t*>(task.dst) + offset,
                         sliceSize, sliceIdx,       device_->Id_(), pluginTaskCtx};

    ret = plugin_->FinishD2HSlice(ctx);
    if (ret != RT_ERROR_NONE) {
        if (nextPublished) {
            (void)WaitD2HSliceDone(task.streamId, barQueue, nextSliceIdx);
        }
        RT_LOG(RT_LOG_ERROR, "CC worker %u: finish D2H callback failed, slice=%u, ret=%#x", workerId_, sliceIdx, ret);
        return ret;
    }
    return RT_ERROR_NONE;
}

rtError_t CCWorker::WaitH2DConsumed(
    const uint32_t streamId, BarTaskQueue* const barQueue, const uint32_t totalSlices) const
{
    COND_RETURN_ERROR(barQueue == nullptr, RT_ERROR_CC_WORKER_FAILED, "CC worker bar task queue is null.");
    if (totalSlices == 0U) {
        return RT_ERROR_NONE;
    }
    const auto waitStart = std::chrono::steady_clock::now();
    for (;;) {
        uint32_t completed = 0U;
        const rtError_t ret = GetCompletedBarTaskNum(barQueue, &completed);
        COND_RETURN_ERROR(
            ret != RT_ERROR_NONE, ret, "CC worker %u: get completed num failed, totalSlices=%u, ret=%#x.", workerId_,
            totalSlices, ret);
        if (completed >= totalSlices) {
            break;
        }
        if (ShouldWorkerExit(streamId)) {
            return RT_ERROR_NONE;
        }
        DebugDumpRingState("WaitH2DConsumed", workerId_, barQueue, totalSlices);
        CCSpinWait(waitStart);
    }
    __sync_synchronize();
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
