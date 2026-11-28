/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "cc_res_manage.h"
#include "cc_stream_res_manage.h"
#include "cc_worker.h"
#include "crypto/cc_crypto_plugin.h"
#include "common/cc_defs.h"

#include "aicpu_c.hpp"
#include "base.hpp"
#include "device.hpp"
#include "runtime.hpp"
#include "stream.hpp"
#include "logger.hpp"
#include "inner_thread_local.hpp"
#include "osal.hpp"
#include "aicpu_timeout_control.h"

namespace cce {
namespace runtime {

namespace {
constexpr const char_t* AICC_SMALL_CRYPTO_KERNEL_NAME = "tsKernel:AiccCryptoSmall";

rtError_t LaunchAiccLoadKeyKernel(Stream* const stm, CCLoadKeyKernelParam& param)
{
    COND_RETURN_ERROR(stm == nullptr, RT_ERROR_STREAM_NULL, "CC load key stream is null.");

    const uint32_t lastTaskId = InnerThreadLocalContainer::GetLastTaskId();
    const uint32_t lastStreamId = InnerThreadLocalContainer::GetLastStreamId();
    const ScopeGuard lastTaskInfoGuard([lastTaskId, lastStreamId]() {
        InnerThreadLocalContainer::SetLastTaskId(lastTaskId);
        InnerThreadLocalContainer::SetLastStreamId(lastStreamId);
    });
    return CCCryptoPlugin::LaunchDeviceKernel(stm, CC_KERNEL_AICC_LOAD_KEY, &param, sizeof(param));
}
} // namespace

static constexpr uint32_t CC_WORKER_COUNT = 6;
CCResManage::CCResManage(Device* device)
    : deviceId_((device == nullptr) ? 0U : device->Id_()), device_(device), crypto_(GetActiveCryptoAlg())
{}

CCResManage::~CCResManage() { DestroyCcResource(); }

rtError_t CCResManage::InitCcResource()
{
    COND_RETURN_ERROR(device_ == nullptr, RT_ERROR_DEVICE_NULL, "CCResManage device is null.");
    rtError_t ret = crypto_.InitKey(deviceId_);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "CC init key failed, deviceId=%u, ret=%#x", deviceId_, ret);
        return RT_ERROR_CC_INIT_FAILED;
    }
    const auto rollback = [this]() {
        plugin_.reset();
        (void)crypto_.ReleaseKey(deviceId_);
    };

    CCCryptoPlugin* plugin = nullptr;
    ret = CreateCryptoPlugin(GetActiveCryptoAlg(), &crypto_, &plugin);
    if (ret != RT_ERROR_NONE) {
        rollback();
        RT_LOG(
            RT_LOG_ERROR, "CC create crypto plugin failed, alg=%u, deviceId=%u, ret=%#x",
            static_cast<uint32_t>(GetActiveCryptoAlg()), deviceId_, ret);
        return RT_ERROR_CC_INIT_FAILED;
    }
    plugin_.reset(plugin);

    ret = LoadKeyToAicpu();
    if (ret != RT_ERROR_NONE) {
        rollback();
        RT_LOG(RT_LOG_ERROR, "CC load key initialization failed, deviceId=%u, ret=%#x", deviceId_, ret);
        return RT_ERROR_CC_INIT_FAILED;
    }

    ret = InitWorkerPool(CC_WORKER_COUNT, CC_SLICE_SIZE);
    if (ret != RT_ERROR_NONE) {
        rollback();
        RT_LOG(RT_LOG_ERROR, "CC worker pool init failed, deviceId=%u, ret=%#x", deviceId_, ret);
        return RT_ERROR_CC_INIT_FAILED;
    }

    // A missing optional kernel must not disable the existing CC path.
    bool supported = false;
    const rtError_t queryRet =
        AicpuTimeoutControl::CheckKernelSupported(device_, AICC_SMALL_CRYPTO_KERNEL_NAME, supported);
    smallCryptoSupported_ =
        (queryRet == RT_ERROR_NONE) && supported && (GetActiveCryptoCipher() == CC_CRYPTO_CIPHER::AES_128);
    RT_LOG(RT_LOG_INFO, "CCResManage initialized for device %u, smallCrypto=%d", deviceId_, smallCryptoSupported_);
    return RT_ERROR_NONE;
}

rtError_t CCResManage::BuildDeviceCryptoParam(CC_CRYPTO_DIRECTION mode, CCCryptoKernelParam* param)
{
    COND_RETURN_ERROR(param == nullptr, RT_ERROR_INVALID_VALUE, "CC crypto parameter is null.");
    const rtError_t ret = crypto_.GetDeviceKeyAddr(mode, &param->keyAddr);
    COND_RETURN_WITH_NOLOG(ret != RT_ERROR_NONE, ret);
    param->keyLen = AICC_KEY_SIZE;
    param->mode = static_cast<uint32_t>(mode);
    param->algType = (crypto_.Mode() == CC_CRYPTO_ALG_TYPE::CTR) ? AICC_ALG_AES128_CTR : AICC_ALG_AES128_GCM;
    return RT_ERROR_NONE;
}

rtError_t CCResManage::LoadKeyToAicpu()
{
    Stream* const curStm = device_->GetCtrlSQStream(nullptr);
    COND_RETURN_ERROR(
        curStm == nullptr, RT_ERROR_STREAM_NULL, "CC load key CtrlSQ stream is null, deviceId=%u.", deviceId_);

    CCLoadKeyKernelParam param{};
    rtError_t ret = crypto_.BuildLoadKeyParam(&param);
    COND_RETURN_ERROR(
        ret != RT_ERROR_NONE, ret, "Failed to build CC load-key kernel parameters, deviceId=%u, retCode=%#x.",
        deviceId_, static_cast<uint32_t>(ret));

    ret = Runtime::Instance()->StartAicpuSd(device_);
    COND_RETURN_ERROR(
        ret != RT_ERROR_NONE, ret,
        "Failed to start AICPU SD before launching the CC load-key kernel, deviceId=%u, retCode=%#x.", deviceId_,
        static_cast<uint32_t>(ret));

    ret = LaunchAiccLoadKeyKernel(curStm, param);
    COND_RETURN_ERROR(
        ret != RT_ERROR_NONE, ret, "Failed to launch the CC load-key kernel, deviceId=%u, retCode=%#x.", deviceId_,
        static_cast<uint32_t>(ret));

    ret = curStm->Synchronize();
    COND_RETURN_ERROR(
        ret != RT_ERROR_NONE, ret,
        "Failed to synchronize the CC load-key stream, deviceId=%u, stream_id=%d, retCode=%#x.", deviceId_,
        curStm->Id_(), static_cast<uint32_t>(ret));

    return RT_ERROR_NONE;
}

void CCResManage::DestroyCcResource()
{
    smallCryptoSupported_ = false;
    DestroyWorkerPool();
    if (plugin_ != nullptr) {
        // Release the plugin-private resource while the plugin is still alive.
        plugin_->ReleaseLaunchResource(deviceId_);
    }
    plugin_.reset();
    {
        const std::lock_guard<std::mutex> lock(streamResourceMutex_);
        streamResources_.clear();
    }
    crypto_.ReleaseKey(deviceId_);
}

rtError_t CCResManage::GetOrCreateStreamResource(Stream* stm, CCStreamResManage*& resource)
{
    COND_RETURN_ERROR(stm == nullptr, RT_ERROR_STREAM_NULL, "CC stream is null.");
    std::lock_guard<std::mutex> lock(streamResourceMutex_);
    resource = stm->GetCCStreamResource();
    if (resource != nullptr) {
        return RT_ERROR_NONE;
    }

    std::unique_ptr<CCStreamResManage> newResource = std::make_unique<CCStreamResManage>();
    const uint32_t descSize = (plugin_ != nullptr) ? plugin_->SliceDescSize() : sizeof(AiccSliceDescBase);
    rtError_t ret = newResource->Init(stm->Device_(), descSize);
    if (ret != RT_ERROR_NONE) {
        return ret;
    }
    resource = newResource.get();
    streamResources_[stm] = std::move(newResource);
    stm->SetCCStreamResource(resource);
    return RT_ERROR_NONE;
}

void CCResManage::DestroyStreamResource(Stream* stm)
{
    if (stm == nullptr) {
        return;
    }

    if (taskQueue_ != nullptr) {
        taskQueue_->CancelTasksByStream(static_cast<uint32_t>(stm->Id_()));
    }

    CCStreamResManage* resource = nullptr;
    {
        std::lock_guard<std::mutex> lock(streamResourceMutex_);
        resource = stm->TakeCCStreamResource();
        const auto it = streamResources_.find(stm);
        if (it != streamResources_.end()) {
            streamResources_.erase(it);
            return;
        }
    }
    delete resource;
}

rtError_t CCResManage::InitWorkerPool(uint32_t workerCount, uint32_t sliceSize)
{
    std::lock_guard<std::mutex> lock(workerPoolMutex_);
    taskQueue_ = std::make_unique<CCMemcpyTaskQueue>();
    maxWorkerCount_ = workerCount;
    workerSliceSize_ = sliceSize;
    workers_.reserve(workerCount);
    const rtError_t poolRet = threadPool_.Init("CC_WORKER", 1U, workerCount);
    if (poolRet != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "CC thread pool init failed, devId=%u, ret=%#x", device_->Id_(), poolRet);
        DestroyWorkerPoolLocked();
        return poolRet;
    }

    const rtError_t ret = CreateWorker();
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "CC initial worker init failed, devId=%u", device_->Id_());
        DestroyWorkerPoolLocked();
        return ret;
    }

    RT_LOG(
        RT_LOG_INFO, "CC worker pool initialized, devId=%u, workers=%zu, maxWorkers=%u, sliceSize=%u", device_->Id_(),
        workers_.size(), maxWorkerCount_, workerSliceSize_);
    return RT_ERROR_NONE;
}

rtError_t CCResManage::CreateWorker()
{
    if (workers_.size() >= maxWorkerCount_) {
        return RT_ERROR_NONE;
    }

    const uint32_t workerIndex = static_cast<uint32_t>(workers_.size());
    auto worker = std::make_unique<CCWorker>();
    const rtError_t ret = worker->Init(
        device_->Id_() * maxWorkerCount_ + workerIndex, workerSliceSize_, taskQueue_.get(), device_, plugin_.get());
    if (ret != RT_ERROR_NONE) {
        return ret;
    }
    workers_.push_back(std::move(worker));

    CCWorker* const rawWorker = workers_.back().get();
    const std::future<void> routineFuture = threadPool_.Submit([rawWorker]() { rawWorker->Run(); });
    if (!routineFuture.valid()) {
        RT_LOG(
            RT_LOG_WARNING, "CC worker %u failed to submit routine to thread pool, devId=%u", workerIndex,
            device_->Id_());
        workers_.pop_back();
        return RT_ERROR_CC_WORKER_FAILED;
    }
    return RT_ERROR_NONE;
}

void CCResManage::DestroyWorkerPoolLocked()
{
    // 先关闭队列让 routine 返回，再 Join，最后释放 worker 缓冲。
    if (taskQueue_ != nullptr) {
        taskQueue_->Shutdown();
    }
    threadPool_.Shutdown();

    for (auto& worker : workers_) {
        worker->Destroy();
    }
    workers_.clear();
    taskQueue_.reset();
    maxWorkerCount_ = 0U;
    workerSliceSize_ = 0U;
}

void CCResManage::DestroyWorkerPool()
{
    std::lock_guard<std::mutex> lock(workerPoolMutex_);
    DestroyWorkerPoolLocked();
}

rtError_t CCResManage::SubmitTask(const CCMemcpyTask& task)
{
    std::lock_guard<std::mutex> lock(workerPoolMutex_);
    if (taskQueue_ == nullptr) {
        return RT_ERROR_CC_WORKER_FAILED;
    }

    if (!taskQueue_->Push(task)) {
        return RT_ERROR_CC_WORKER_FAILED;
    }

    const rtError_t ret = CreateWorker();
    if (ret != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_WARNING, "CC worker pool expansion failed, devId=%u, workers=%zu, maxWorkers=%u, ret=%#x", deviceId_,
            workers_.size(), maxWorkerCount_, static_cast<uint32_t>(ret));
    }
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
