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
#include <cstdio>
#include <cstring>
#include <thread>
#include "ascend_hal_base.h"
#include "cc_manager.h"
#include "crypto/cc_crypto.h"
#include "cc_stream_res_manage.h"
#include "context.hpp"
#include "device.hpp"
#include "driver.hpp"
#include "stream.hpp"
#include "stream_sqcq_manage.hpp"
#include "type_def.h"
namespace cce {
namespace runtime {
static constexpr uint64_t CC_TIMEOUT_MS = 18ULL * 60ULL * 1000ULL;

CCWorker::~CCWorker() { Destroy(); }

rtError_t CCWorker::Init(
    uint32_t workerId, uint32_t sliceSize, CCMemcpyTaskQueue* taskQueue, Device* device, CCrypto* crypto)
{
    COND_RETURN_ERROR(device == nullptr, RT_ERROR_DEVICE_NULL, "CC worker device is null.");
    COND_RETURN_ERROR(crypto == nullptr, RT_ERROR_INVALID_VALUE, "CC worker crypto is null.");
    workerId_ = workerId;
    maxSliceSize_ = sliceSize;
    taskQueue_ = taskQueue;
    device_ = device;
    crypto_ = crypto;
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
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "CC worker %u failed to DMA map hostCryptoBuf, ret=%#x", workerId_, ret);
        Destroy();
        return ret;
    }
    hostCryptoDmaMapped_ = true;

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

    thread_ = OsalFactory::CreateThread("CC_WORKER", this, nullptr);
    if (thread_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "CC worker %u failed to create thread", workerId_);
        Destroy();
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    int32_t err = thread_->Start();
    if (err != EN_OK) {
        RT_LOG(RT_LOG_ERROR, "CC worker %u failed to start thread, err=%d", workerId_, err);
        Destroy();
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    RT_LOG(
        RT_LOG_INFO, "CC worker %u initialized, sliceSize=%u, device_id=%u", workerId_, maxSliceSize_, device_->Id_());
    return RT_ERROR_NONE;
}

void CCWorker::Destroy()
{
    cancelled_.store(true);

    if (thread_ != nullptr) {
        thread_->Join();
        DELETE_O(thread_);
    }

    if (hostCryptoDmaMapped_ && (device_ != nullptr) && (device_->Driver_() != nullptr)) {
        rtError_t ret = device_->Driver_()->HostDmaUnmap(hostCryptoBuf_, device_->Id_());
        if (ret != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "CC worker %u: HostDmaUnmap failed, ret=%#x", workerId_, ret);
        }
        hostCryptoDmaMapped_ = false;
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
    const uint32_t slot = CCSliceQueue::PhysicalBufferIndex(sliceIdx);
    return (slot < CC_BUFFER_SLOT_NUM) ? deviceBuffers_[slot] : nullptr;
}

void CCWorker::Run(const void* param)
{
    (void)param;
    WorkerLoop();
}

void CCWorker::WorkerLoop()
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

bool CCWorker::ShouldWorkerExit(const uint32_t streamId)
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

    resource->Reset();

    CCSliceQueue* const taskQueue = resource->Queue();
    if (taskQueue == nullptr) {
        RT_LOG(RT_LOG_ERROR, "CC worker %u: task queue is null", workerId_);
        return RT_ERROR_CC_WORKER_FAILED;
    }

    size_t totalSize = task.totalSize;
    const uint64_t sliceNum64 = (totalSize + CC_PLAINTEXT_SLICE_SIZE - 1U) / CC_PLAINTEXT_SLICE_SIZE;
    sliceNum = static_cast<uint32_t>(sliceNum64);
    taskQueue->totalSlices = sliceNum;
    taskQueue->memWaitVal = 1U;

    // 外部中断预检：遇错即停/快恢等场景下静默丢弃任务
    if (ShouldWorkerExit(task.streamId)) {
        RT_LOG(RT_LOG_WARNING, "CC worker %u: task dropped, stream_id=%u", workerId_, task.streamId);
        return RT_ERROR_NONE;
    }
    return RT_ERROR_NONE;
}

rtError_t CCWorker::ProcessSlices(CCMemcpyTask& task, CCStreamResManage* const resource, uint32_t sliceNum)
{
    size_t totalSize = task.totalSize;
    rtError_t ret = RT_ERROR_NONE;

    for (uint32_t i = 0; i < sliceNum; ++i) {
        if (ShouldWorkerExit(task.streamId)) {
            // 外部中断/超时均静默退出：错误由 engine 或 AICPU SQE 超时上报，worker 不重复设置错误码。
            RT_LOG(RT_LOG_ERROR, "CC worker %u: task interrupted, slice=%u/%u", workerId_, i, sliceNum);
            break;
        }

        size_t offset = static_cast<size_t>(i) * CC_PLAINTEXT_SLICE_SIZE;
        size_t sliceSize = std::min(static_cast<size_t>(CC_PLAINTEXT_SLICE_SIZE), totalSize - offset);

        if (task.kind == RT_MEMCPY_HOST_TO_DEVICE) {
            ret = ProcessH2DSlice(task, resource, i, offset, sliceSize);
        } else if (task.kind == RT_MEMCPY_DEVICE_TO_HOST) {
            ret = ProcessD2HSlice(task, resource, i, offset, sliceSize);
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

rtError_t CCWorker::ProcessTask(CCMemcpyTask& task)
{
    std::shared_ptr<Stream> stream;
    CCStreamResManage* resource = nullptr;
    uint32_t sliceNum = 0;

    rtError_t ret = SetupTask(task, stream, resource, sliceNum);
    if (ret != RT_ERROR_NONE || stream == nullptr || resource == nullptr) {
        // resource 为 nullptr 表示任务在 SetupTask 中被静默丢弃（流销毁/外部中断），无需设置错误码。
        return ret;
    }

    ret = ProcessSlices(task, resource, sliceNum);
    // H2D 场景下需要确认 AICPU 已消费完 Device Buffer A/B（head == tail）才能返回处理下一个任务
    if ((ret == RT_ERROR_NONE) && (task.kind == RT_MEMCPY_HOST_TO_DEVICE)) {
        CCSliceQueue* const taskQueue = resource->Queue();
        ret = WaitH2DConsumed(task.streamId, taskQueue);
    }

    return ret;
}

rtError_t CCWorker::ProcessH2DSlice(
    CCMemcpyTask& task, CCStreamResManage* const resource, uint32_t sliceIdx, size_t offset, size_t sliceSize)
{
    CCSliceQueue* const taskQueue = resource->Queue();
    // 有效槽位只有 2 个,host 加密+DMA 远快于 AICPU 解密，若不等满就直接写，会覆盖 AICPU 尚未消费的描述符和密文 buffer
    while (taskQueue->IsFull()) {
        if (ShouldWorkerExit(task.streamId)) {
            return RT_ERROR_CC_WORKER_TIMEOUT;
        }
        std::this_thread::sleep_for(std::chrono::microseconds(100U));
    }
    RT_LOG(RT_LOG_INFO, "ProcessH2DSlice get slot");
    auto* src = static_cast<const uint8_t*>(task.src) + offset;
    const uint8_t head = taskQueue->head;
    void* const deviceBuffer = DeviceBuffer(sliceIdx);

    CCSliceDesc* const sliceDesc = resource->SliceDesc();
    sliceDesc[head] = CCSliceDesc{};
    sliceDesc[head].ciphertextAddr = PtrToValue(deviceBuffer);
    sliceDesc[head].plaintextAddr = PtrToValue(static_cast<uint8_t*>(task.dst) + offset);
    sliceDesc[head].ciphertextLen = static_cast<uint32_t>(CC_CIPHER_HEADER_SIZE + sliceSize);
    sliceDesc[head].plaintextLen = static_cast<uint32_t>(sliceSize);
    sliceDesc[head].sliceIdx = sliceIdx;

    size_t ctlen = 0;
    rtError_t cryptoRet = crypto_->Encrypt(
        device_->Id_(), const_cast<uint8_t*>(src), sliceSize, PtrToPtr<CCSliceDesc, uint8_t>(&sliceDesc[head]),
        sizeof(CCSliceDesc), static_cast<uint8_t*>(hostCryptoBuf_), &ctlen);
    if (cryptoRet != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "CC worker %u: encrypt failed, slice=%u, ret=%#x", workerId_, sliceIdx, cryptoRet);
        return cryptoRet;
    }

    drvError_t drvRet =
        drvMemcpy(RtPtrToPtr<UINT64>(deviceBuffer), maxSliceSize_, RtPtrToPtr<UINT64>(hostCryptoBuf_), ctlen);
    if (drvRet != 0) {
        RT_LOG(RT_LOG_ERROR, "CC worker %u: DMA H2D failed, slice=%u, ret=%d", workerId_, sliceIdx, drvRet);
        return RT_ERROR_CC_WORKER_FAILED;
    }
    /*
     * 保证以下操作先于 head 发布：
     * 1. sliceDesc[head] 各字段写入
     * 2. drvMemcpy 已同步完成
     */
    __sync_synchronize();
    taskQueue->head = (head + 1U) % CC_SLICE_DESC_SLOT_NUM;
    __sync_synchronize();
    RT_LOG(RT_LOG_INFO, "ProcessH2DSlice end, taskQueue->head=%u, sliceIdx=%u", taskQueue->head, sliceIdx);
    return RT_ERROR_NONE;
}

rtError_t CCWorker::PublishD2HSlice(
    CCMemcpyTask& task, CCStreamResManage* const resource, uint32_t sliceIdx, size_t offset, size_t sliceSize)
{
    CCSliceQueue* const taskQueue = resource->Queue();
    while (taskQueue->IsFull()) {
        if (ShouldWorkerExit(task.streamId)) {
            return RT_ERROR_CC_WORKER_TIMEOUT;
        }
        std::this_thread::sleep_for(std::chrono::microseconds(100U));
    }
    RT_LOG(RT_LOG_INFO, "ProcessD2HSlice get slot");
    const uint8_t head = taskQueue->head;
    void* const deviceBuffer = DeviceBuffer(sliceIdx);
    CCSliceDesc* const sliceDesc = resource->SliceDesc();
    sliceDesc[head] = CCSliceDesc{};
    sliceDesc[head].ciphertextAddr = PtrToValue(deviceBuffer);
    sliceDesc[head].plaintextAddr = PtrToValue(static_cast<const uint8_t*>(task.src) + offset);
    sliceDesc[head].ciphertextLen = static_cast<uint32_t>(CC_CIPHER_HEADER_SIZE + sliceSize);
    sliceDesc[head].plaintextLen = static_cast<uint32_t>(sliceSize);
    sliceDesc[head].sliceIdx = sliceIdx;

    const uint8_t nextHead = static_cast<uint8_t>((head + 1U) % CC_SLICE_DESC_SLOT_NUM);
    __sync_synchronize();
    taskQueue->head = nextHead;
    __sync_synchronize();
    return RT_ERROR_NONE;
}

rtError_t CCWorker::WaitD2HSliceCompleted(
    const uint32_t streamId, const CCSliceQueue* const sliceQueue, const uint8_t expectedTail)
{
    while (sliceQueue->tail != expectedTail) {
        if (ShouldWorkerExit(streamId)) {
            return RT_ERROR_CC_WORKER_TIMEOUT;
        }
        std::this_thread::sleep_for(std::chrono::microseconds(100U));
    }
    __sync_synchronize();
    return RT_ERROR_NONE;
}

rtError_t CCWorker::ProcessD2HSlice(
    CCMemcpyTask& task, CCStreamResManage* const resource, uint32_t sliceIdx, size_t offset, size_t sliceSize)
{
    CCSliceQueue* const taskQueue = resource->Queue();
    if (sliceIdx == 0U) {
        const rtError_t publishRet = PublishD2HSlice(task, resource, sliceIdx, offset, sliceSize);
        COND_RETURN_WITH_NOLOG(publishRet != RT_ERROR_NONE, publishRet);
    }

    const uint8_t descSlot = static_cast<uint8_t>(sliceIdx % CC_SLICE_DESC_SLOT_NUM);
    const uint8_t expectedTail = static_cast<uint8_t>((descSlot + 1U) % CC_SLICE_DESC_SLOT_NUM);
    rtError_t ret = WaitD2HSliceCompleted(task.streamId, taskQueue, expectedTail);
    COND_RETURN_WITH_NOLOG(ret != RT_ERROR_NONE, ret);

    // 当前片已由 AICPU 加密完成。先发布下一片，使 AICPU 加密与 Host 搬运解密并行。
    bool nextPublished = false;
    uint8_t nextExpectedTail = expectedTail;
    if ((taskQueue->totalSlices > 0U) && (sliceIdx < taskQueue->totalSlices - 1U)) {
        const uint32_t nextSliceIdx = sliceIdx + 1U;
        const size_t nextOffset = static_cast<size_t>(nextSliceIdx) * CC_PLAINTEXT_SLICE_SIZE;
        const size_t nextSliceSize =
            std::min(static_cast<size_t>(CC_PLAINTEXT_SLICE_SIZE), task.totalSize - nextOffset);
        const rtError_t publishRet = PublishD2HSlice(task, resource, nextSliceIdx, nextOffset, nextSliceSize);
        COND_RETURN_WITH_NOLOG(publishRet != RT_ERROR_NONE, publishRet);
        nextPublished = true;
        nextExpectedTail = static_cast<uint8_t>((expectedTail + 1U) % CC_SLICE_DESC_SLOT_NUM);
    }

    CCSliceDesc* const sliceDesc = resource->SliceDesc();
    const uint32_t ctlen = sliceDesc[descSlot].ciphertextLen;
    RT_LOG(RT_LOG_INFO, "ProcessD2HSlice sliceIdx=%u, ctlen=%u", sliceIdx, ctlen);

    void* const deviceBuffer = DeviceBuffer(sliceIdx);
    drvError_t drvRet =
        drvMemcpy(RtPtrToPtr<UINT64>(hostCryptoBuf_), maxSliceSize_, RtPtrToPtr<UINT64>(deviceBuffer), ctlen);
    if (drvRet != 0) {
        if (nextPublished) {
            (void)WaitD2HSliceCompleted(task.streamId, taskQueue, nextExpectedTail);
        }
        RT_LOG(RT_LOG_ERROR, "CC worker %u: DMA D2H failed, slice=%u, ret=%d", workerId_, sliceIdx, drvRet);
        return RT_ERROR_CC_WORKER_FAILED;
    }

    auto* dst = static_cast<uint8_t*>(task.dst) + offset;
    size_t ptlen = 0;
    rtError_t cryptoRet = crypto_->Decrypt(
        device_->Id_(), static_cast<uint8_t*>(hostCryptoBuf_), ctlen,
        PtrToPtr<CCSliceDesc, uint8_t>(&sliceDesc[descSlot]), sizeof(CCSliceDesc), dst, &ptlen);
    if (cryptoRet != RT_ERROR_NONE) {
        if (nextPublished) {
            (void)WaitD2HSliceCompleted(task.streamId, taskQueue, nextExpectedTail);
        }
        RT_LOG(RT_LOG_ERROR, "CC worker %u: decrypt failed, slice=%u, ret=%#x", workerId_, sliceIdx, cryptoRet);
        return cryptoRet;
    }

    if (sliceIdx == taskQueue->totalSlices - 1U) {
        taskQueue->memWaitVal = 0U;
        RT_LOG(RT_LOG_INFO, "D2H task end, sliceIdx=%u, taskQueue->memWaitVal=%u", sliceIdx, taskQueue->memWaitVal);
    }
    RT_LOG(RT_LOG_INFO, "ProcessD2HSlice end, sliceIdx=%u, taskQueue->tail=%u", sliceIdx, taskQueue->tail);
    return RT_ERROR_NONE;
}

rtError_t CCWorker::WaitH2DConsumed(const uint32_t streamId, CCSliceQueue* const sliceQueue)
{
    COND_RETURN_ERROR(sliceQueue == nullptr, RT_ERROR_CC_WORKER_FAILED, "CC worker slice queue is null.");
    while (!sliceQueue->IsEmpty()) {
        if (ShouldWorkerExit(streamId)) {
            // 外部中断（快恢/遇错即停/流销毁/关闭）或超时：AICPU 已停发，等待只会超时，静默退出。
            return RT_ERROR_NONE;
        }
        std::this_thread::sleep_for(std::chrono::microseconds(100U));
    }
    __sync_synchronize();
    sliceQueue->memWaitVal = 0U;
    __sync_synchronize();
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
