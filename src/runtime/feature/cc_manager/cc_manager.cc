/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cinttypes>
#include <cstddef>
#include "cc_manager.h"
#include "cc_res_manage.h"
#include "cc_stream_res_manage.h"
#include "aicpu_c.hpp"
#include "capture_model_utils.hpp"
#include "context.hpp"
#include "dev_info_manage.h"
#include "enum_desc.hpp"
#include "error_message_manage.hpp"
#include "logger.hpp"
#include "npu_driver.hpp"
#include "runtime.hpp"
#include "stream.hpp"
#include "utils.h"
#include "memcpy_c.hpp"
#include "memory_task.h"
#include "task_david.hpp"
#include "stream_david.hpp"
#include "inner_thread_local.hpp"
#include "cond_c.hpp"
#include "memset_common.h"
#include <unordered_map>
#include <vector>

namespace cce {
namespace runtime {
namespace {
constexpr const char_t* AICC_CRYPTO_KERNEL_NAME = "AiccCrypto";
rtError_t LaunchAiccCryptoKernel(Stream* const stm, CCCryptoKernelParam& param)
{
    COND_RETURN_ERROR(stm == nullptr, RT_ERROR_STREAM_NULL, "CC stream is null.");

    rtKernelLaunchNames_t launchNames{};
    launchNames.soName = nullptr;
    launchNames.kernelName = AICC_CRYPTO_KERNEL_NAME;
    launchNames.opName = AICC_CRYPTO_KERNEL_NAME;

    rtArgsEx_t argsInfo{};
    argsInfo.args = &param;
    argsInfo.argsSize = static_cast<uint32_t>(sizeof(param));
    argsInfo.isNoNeedH2DCopy = 0U; // param 是 host 栈变量，让 Runtime 拷到 device

    return StreamLaunchCpuKernel(&launchNames, 1U, &argsInfo, stm, RT_KERNEL_DEFAULT);
}
struct CCHostCallbackParam {
    uint32_t deviceId;
    CCMemcpyTask task;
    bool releaseInCallback;
};

struct CCGraphResources {
    bool isRegistered{false};
    std::vector<std::unique_ptr<CCHostCallbackParam>> callbackParams;
};

std::mutex g_ccGraphResourceMutex;
std::unordered_map<Model*, CCGraphResources> g_ccGraphResources;

void ReleaseCcGraphResources(void* userData)
{
    Model* const mdl = static_cast<Model*>(userData);
    std::lock_guard<std::mutex> lock(g_ccGraphResourceMutex);
    (void)g_ccGraphResources.erase(mdl);
}

rtError_t GetCcModelInfo(Stream* const stm, Stream*& resourceStm, Model*& ownerModel)
{
    COND_RETURN_ERROR(stm == nullptr, RT_ERROR_STREAM_NULL, "CC stream is null.");

    // 1. aclGraph
    if (stm->IsCapturing()) {
        resourceStm = stm->GetCaptureStream();
        COND_RETURN_ERROR(
            resourceStm == nullptr, RT_ERROR_STREAM_CAPTURE_INVALIDATED, "CC capture stream is null, stream_id=%d.",
            stm->Id_());

        ownerModel = resourceStm->Model_();
        COND_RETURN_ERROR(
            ownerModel == nullptr, RT_ERROR_MODEL_NULL, "CC capture model is null, stream_id=%d.", resourceStm->Id_());

        return RT_ERROR_NONE;
    }

    // 2. 普通图模式 和 单算子流 的资源仍然绑定当前流
    ownerModel = stm->Model_();
    return RT_ERROR_NONE;
}

rtError_t AllocCcCallbackParam(
    Model* const ownerModel, uint32_t deviceId, const CCMemcpyTask& task, CCHostCallbackParam*& out)
{
    out = nullptr;
    // 单算子流，Callback里面处理完后就释放内存，最后一个参数为true
    if (ownerModel == nullptr) {
        out = new (std::nothrow) CCHostCallbackParam{deviceId, task, true};
        COND_RETURN_ERROR(out == nullptr, RT_ERROR_MEMORY_ALLOCATION, "Alloc CC callback param failed.");
        return RT_ERROR_NONE;
    }

    std::unique_ptr<CCHostCallbackParam> param(new (std::nothrow) CCHostCallbackParam{deviceId, task, false});
    COND_RETURN_ERROR(param == nullptr, RT_ERROR_MEMORY_ALLOCATION, "Alloc CC model callback param failed.");

    std::lock_guard<std::mutex> lock(g_ccGraphResourceMutex);
    CCGraphResources& resources = g_ccGraphResources[ownerModel];

    if (!resources.isRegistered) {
        const rtError_t ret = ownerModel->ModelDestroyRegisterCallback(&ReleaseCcGraphResources, ownerModel);
        if (ret != RT_ERROR_NONE) {
            (void)g_ccGraphResources.erase(ownerModel);
            return ret;
        }
        resources.isRegistered = true;
    }

    out = param.get();
    resources.callbackParams.emplace_back(std::move(param));
    return RT_ERROR_NONE;
}

void RemoveCcGraphCallbackParam(Model* const mdl, CCHostCallbackParam* const param)
{
    if ((mdl == nullptr) || (param == nullptr)) {
        return;
    }

    std::lock_guard<std::mutex> lock(g_ccGraphResourceMutex);
    auto iter = g_ccGraphResources.find(mdl);
    if (iter == g_ccGraphResources.end()) {
        return;
    }

    std::vector<std::unique_ptr<CCHostCallbackParam>>& params = iter->second.callbackParams;
    for (auto it = params.begin(); it != params.end(); ++it) {
        if (it->get() == param) {
            (void)params.erase(it);
            break;
        }
    }
}

rtError_t PrepareCcAsyncH2dEx(
    Stream* const stm, const void*& src, const uint64_t count, rtMemcpyKind_t& kind, std::shared_ptr<void>& guardMem)
{
    Driver* const driver = stm->Device_()->Driver_();
    void* staging = nullptr;
    rtError_t ret = driver->HostMemAlloc(&staging, count, stm->Device_()->Id_());
    COND_RETURN_ERROR(
        ret != RT_ERROR_NONE || staging == nullptr, RT_ERROR_MEMORY_ALLOCATION,
        "Alloc CC H2D EX staging buffer failed, size=%" PRIu64 ", ret=%#x.", count, ret);

    ret = driver->MemCopySync(staging, count, src, count, RT_MEMCPY_HOST_TO_HOST);
    if (ret != RT_ERROR_NONE) {
        (void)driver->HostMemFree(staging);
        return ret;
    }

    guardMem.reset(staging, [driver](void* p) { (void)driver->HostMemFree(p); });

    src = staging;
    kind = RT_MEMCPY_HOST_TO_DEVICE;
    return RT_ERROR_NONE;
}

rtError_t SetCcMemcpyKindByAddr(const void* const dst, const void* const src, rtMemcpyKind_t& kind)
{
    COND_RETURN_ERROR(dst == nullptr, RT_ERROR_INVALID_VALUE, "CC memcpy dst is null.");
    COND_RETURN_ERROR(src == nullptr, RT_ERROR_INVALID_VALUE, "CC memcpy src is null.");

    rtPtrAttributes_t dstAttr{};
    rtPtrAttributes_t srcAttr{};

    rtError_t ret = GetPtrAttributes(dst, &dstAttr);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "Get CC memcpy dst attribute failed, ret=%#x.", ret);

    ret = GetPtrAttributes(src, &srcAttr);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "Get CC memcpy src attribute failed, ret=%#x.", ret);

    const rtMemLocationType dstLoc =
        (dstAttr.location.type == RT_MEMORY_LOC_UNREGISTERED) ? RT_MEMORY_LOC_HOST : dstAttr.location.type;
    const rtMemLocationType srcLoc =
        (srcAttr.location.type == RT_MEMORY_LOC_UNREGISTERED) ? RT_MEMORY_LOC_HOST : srcAttr.location.type;

    if ((dstLoc == RT_MEMORY_LOC_DEVICE) && (srcLoc == RT_MEMORY_LOC_HOST)) {
        kind = RT_MEMCPY_HOST_TO_DEVICE;
        return RT_ERROR_NONE;
    }

    if ((dstLoc == RT_MEMORY_LOC_HOST) && (srcLoc == RT_MEMORY_LOC_DEVICE)) {
        kind = RT_MEMCPY_DEVICE_TO_HOST;
        return RT_ERROR_NONE;
    }
    return RT_ERROR_CONTINUE_EXECUTE;
}
} // namespace

CCManager& CCManager::Instance()
{
    static CCManager manager;
    return manager;
}

CCManager::~CCManager()
{
    // 注册信息随进程地址空间回收；析构阶段只释放仍存续的 Device 资源。
    for (std::unique_ptr<CCResManage>& resource : resources_) {
        resource.reset();
    }
}

rtError_t RegCCManagerProcFunc(const rtChipType_t chipType)
{
    DevDynInfoProcFunc procFunc{};
    const rtError_t error = GET_DEV_INFO_PROC_FUNC(chipType, procFunc);
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, error,
        "Failed to get process functions before registering CC callbacks, chip_type=%d, retCode=%#x.",
        static_cast<int32_t>(chipType), static_cast<uint32_t>(error));

    // 资源生命周期和内存分发函数使用芯片函数表注册，空回调表示普通模式。
    procFunc.memProcFunc.memcpyAsync = &CCManager::CCMemcpyAsync;
    procFunc.memProcFunc.memCopySync = &CCManager::CCMemCopySync;
    procFunc.memProcFunc.memCopy2DAsync = &CCManager::CCMemCopy2DAsync;
    procFunc.memProcFunc.memCopy2DSync = &CCManager::CCMemCopy2DSync;
    procFunc.memProcFunc.memcpyBatchAsync = &CCManager::CCMemcpyBatchAsync;
    procFunc.memProcFunc.memcpyBatch = &CCManager::CCMemcpyBatch;
    procFunc.memProcFunc.devMalloc = &CCManager::CCDevMalloc;
    procFunc.memProcFunc.devMallocWithCfg = &CCManager::CCDevMallocWithCfg;
    procFunc.memProcFunc.devMemsetAsync = &CCManager::CCDevMemSetAsync;
    procFunc.memProcFunc.devMemset32 = &CCManager::CCDevMemSetD32;

    procFunc.ccProcFunc.devResourceInit = &CCManager::InitDeviceResource;
    procFunc.ccProcFunc.devResourceRelease = &CCManager::ReleaseDeviceResource;
    procFunc.ccProcFunc.streamResDestroy = &CCManager::DestroyStreamResource;

    COND_RETURN_ERROR(
        DevInfoManage::Instance().RegDevInfoProcFunc(chipType, procFunc) == false, RT_ERROR_CC_INIT_FAILED,
        "Failed to register CC process functions, chip_type=%d.", chipType);
    return RT_ERROR_NONE;
}

rtError_t CCManager::InitDeviceResource(Device* device)
{
    COND_RETURN_ERROR(device == nullptr, RT_ERROR_DEVICE_NULL, "CC stream resource device is null.");
    COND_RETURN_ERROR(device->Driver_() == nullptr, RT_ERROR_DRV_NULL, "CC stream resource driver is null.");
    const uint32_t deviceId = device->Id_();

    COND_RETURN_ERROR(
        deviceId >= RT_MAX_DEV_NUM, RT_ERROR_DEVICE_ID, "Invalid CC resource device id, device_id=%u.", deviceId);

    CCManager& manager = CCManager::Instance();
    const std::lock_guard<std::mutex> lock(manager.resourceMutex_);
    if (manager.resources_[deviceId] != nullptr) {
        return RT_ERROR_NONE;
    }

    std::unique_ptr<CCResManage> resource(new (std::nothrow) CCResManage(device));
    COND_RETURN_ERROR(
        resource == nullptr, RT_ERROR_CC_INIT_FAILED, "Failed to allocate CC manager resource, device_id=%u.",
        deviceId);
    const rtError_t error = resource->InitCcResource();
    COND_RETURN_ERROR(
        error != RT_ERROR_NONE, RT_ERROR_CC_INIT_FAILED,
        "Failed to initialize CC device resource, device_id=%u, retCode=%#x.", deviceId, static_cast<uint32_t>(error));

    manager.resources_[deviceId] = std::move(resource);
    return RT_ERROR_NONE;
}

void CCManager::ReleaseDeviceResource(const uint32_t deviceId)
{
    COND_RETURN_VOID(deviceId >= RT_MAX_DEV_NUM, "Invalid CC resource device id, device_id=%u.", deviceId);

    CCManager& manager = CCManager::Instance();
    const std::lock_guard<std::mutex> lock(manager.resourceMutex_);
    manager.resources_[deviceId].reset();
}

void CCManager::DestroyStreamResource(Stream* stm)
{
    // Stream 析构回调：释放 Stream 级 BAR 资源并取消其为执行的任务。
    // 时序保证：Worker 处理任务期间持有 shared_ptr<Stream>，~Stream 在所有引用释放后才执行，
    // 因此本回调不会与正在执行中的 Worker 并发访问 CCStreamResManage。
    COND_RETURN_VOID(stm == nullptr, "CC destroy stream resource: stream is null.");
    const Device* const device = stm->Device_();
    COND_RETURN_VOID(device == nullptr, "CC destroy stream resource: device is null.");
    const uint32_t deviceId = device->Id_();

    CCManager& manager = CCManager::Instance();
    const std::lock_guard<std::mutex> lock(manager.resourceMutex_);
    if (manager.resources_[deviceId] != nullptr) {
        manager.resources_[deviceId]->DestroyStreamResource(stm);
    }
}

rtError_t CCManager::CCDevMalloc(
    void** const devPtr, const uint64_t size, const rtMemType_t type, const uint16_t moduleId)
{
    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    auto driver = curCtx->Device_()->Driver_();
    uint32_t devId = curCtx->Device_()->Id_();

    const uint64_t alignSize = (((size + 0x1FU) >> 5U) << 5U);
    DevMemAllocConfig allocConfig = {};
    allocConfig.moduleId = moduleId;
    allocConfig.privateFlag = true;
    const uint64_t drvFlag = NpuDriver::BuildDevMemAllocFlag(devId, &allocConfig);
    return driver->DevMemAllocWithFlag(devPtr, alignSize, type, devId, &allocConfig, drvFlag);
}

rtError_t CCManager::CCDevMallocWithCfg(
    void** const devPtr, const uint64_t size, const rtMemType_t type, const uint32_t devId, const uint16_t moduleId)
{
    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    auto driver = curCtx->Device_()->Driver_();

    DevMemAllocConfig allocConfig = {};
    allocConfig.moduleId = moduleId;
    allocConfig.privateFlag = true;
    const uint64_t drvFlag = NpuDriver::BuildDevMemAllocFlag(devId, &allocConfig);
    return driver->DevMemAllocWithFlag(devPtr, size, type, devId, &allocConfig, drvFlag);
}

void CCManager::SubmitCcTaskCallback(void* userData)
{
    NULL_PTR_RETURN_DIRECTLY(userData);

    CCHostCallbackParam* const rawParam = static_cast<CCHostCallbackParam*>(userData);
    // 单算子流: 通过智能指针管理userData的生命周期，submit传入worker线程后task也可以也可以保住生命周期
    std::unique_ptr<CCHostCallbackParam> paramGuard(rawParam->releaseInCallback ? rawParam : nullptr);

    CCManager& manager = CCManager::Instance();
    std::lock_guard<std::mutex> lock(manager.resourceMutex_);
    if ((rawParam->deviceId >= RT_MAX_DEV_NUM) || (manager.resources_[rawParam->deviceId] == nullptr)) {
        RT_LOG(RT_LOG_ERROR, "CC resource is null, device_id=%u.", rawParam->deviceId);
        return;
    }

    const rtError_t ret = manager.resources_[rawParam->deviceId]->SubmitTask(rawParam->task);
    COND_LOG_ERROR(
        ret != RT_ERROR_NONE, "Submit CC task failed, device_id=%u, stream_id=%u, ret=%#x.", rawParam->deviceId,
        rawParam->task.streamId, static_cast<uint32_t>(ret));
}

rtError_t CCManager::SubmitCcMemcpyTask(
    void* const dst, const void* const src, const uint64_t count, const rtMemcpyKind_t kind, Stream* const stm,
    std::shared_ptr<void> guardMem)
{
    Stream* resourceStm = stm;
    Model* ownerModel = nullptr;
    rtError_t ret = GetCcModelInfo(stm, resourceStm, ownerModel);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "get CC model info failed, ret=%#x.", ret);

    Device* const device = resourceStm->Device_();
    COND_RETURN_ERROR(device == nullptr, RT_ERROR_DEVICE_NULL, "CC memcpy stream device is null.");
    const uint32_t deviceId = device->Id_();
    COND_RETURN_ERROR(deviceId >= RT_MAX_DEV_NUM, RT_ERROR_DEVICE_ID, "Invalid device id %u.", deviceId);
    CCManager& manager = CCManager::Instance();
    COND_RETURN_ERROR(manager.resources_[deviceId] == nullptr, RT_ERROR_CC_INIT_FAILED, "CC resource is null.");
    const CC_CRYPTO_MODE mode =
        (kind == RT_MEMCPY_DEVICE_TO_HOST) ? CC_CRYPTO_MODE::ENCRYPT_MODE : CC_CRYPTO_MODE::DECRYPT_MODE;

    ret = Runtime::Instance()->StartAicpuSd(device);
    COND_RETURN_ERROR(
        ret != RT_ERROR_NONE, ret,
        "Failed to start AICPU SD before launching the CC crypto kernel, device_id=%u, retCode=%#x.", deviceId,
        static_cast<uint32_t>(ret));
    // 组装AICPU算子所需的参数
    CCCryptoKernelParam param{};
    const uint32_t cryptoRet = manager.resources_[deviceId]->BuildDeviceCryptoParam(mode, &param);
    COND_RETURN_ERROR(
        cryptoRet != 0U, RT_ERROR_CC_CRYPTO_FAILED, "Build device crypto param failed, ret=%u.", cryptoRet);
    // 参数所需的bar空间地址(taskQueueAddr)从StreamResource中获取
    CCStreamResManage* streamResource = nullptr;
    ret = manager.resources_[deviceId]->GetOrCreateStreamResource(resourceStm, streamResource);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "Get or create CC stream resource failed, ret=%#x.", ret);
    COND_RETURN_ERROR(streamResource == nullptr, RT_ERROR_CC_INIT_FAILED, "CC stream resource is null.");
    param.taskQueueAddr = streamResource->DeviceQueueAddr();

    // 组装回调参数
    const CCMemcpyTask task{
        src, dst, static_cast<size_t>(count), kind, static_cast<uint32_t>(resourceStm->Id_()), std::move(guardMem)};
    CCHostCallbackParam* cbParam = nullptr;
    ret = AllocCcCallbackParam(ownerModel, deviceId, task, cbParam);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "Alloc CC callback param failed, ret=%#x.", ret);

    // 流级别的大锁，防止多线程并发下这三个算子
    std::unique_lock<std::mutex> memSubmitLock(streamResource->MemSubmitMutex());
    ret = Runtime::Instance()->ApiImpl_()->LaunchHostFunc(stm, &CCManager::SubmitCcTaskCallback, cbParam);
    if (ret != RT_ERROR_NONE) {
        if (ownerModel != nullptr) {
            RemoveCcGraphCallbackParam(ownerModel, cbParam);
        } else {
            delete cbParam;
        }
        return ret;
    }

    const uint64_t memWaitAddr = param.taskQueueAddr + static_cast<uint64_t>(offsetof(CCSliceQueue, memWaitVal));
    COND_RETURN_ERROR(memWaitAddr == 0ULL, RT_ERROR_CC_INIT_FAILED, "memWaitAddr is 0.");

    ret = CondMemWaitValue(
        RtValueToPtr<void*>(memWaitAddr), 1ULL, static_cast<uint32_t>(MEM_WAIT_VALUE_TYPE_GEQ), stm,
        RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "Failed to submit memory wait value task in CC mode, ret=%#x.", ret);

    ret = LaunchAiccCryptoKernel(stm, param);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "Failed to launch aiccCrypto task in CC mode, ret=%#x.", ret);

    return RT_ERROR_NONE;
}

rtError_t CCManager::CCMemCopySync(
    void* const dst, const uint64_t destMax, const void* const src, const uint64_t cnt, const rtMemcpyKind_t kind)
{
    RT_LOG(RT_LOG_INFO, "CCMemCopySync in, kind=%s.", MemcpyKindToStr(kind));
    (void)destMax;
    (void)kind; // CC 同步拷贝按地址属性推导方向，非CC模式驱动会校准，CC需要在Runtime校准

    rtMemcpyKind_t cpyKind = RT_MEMCPY_RESERVED;
    rtError_t ret = SetCcMemcpyKindByAddr(dst, src, cpyKind);
    if (ret == RT_ERROR_CONTINUE_EXECUTE) {
        return ret;
    }
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "Verify CC memcpy sync kind failed, ret=%#x.", ret);

    RT_LOG(RT_LOG_DEBUG, "memcpy sync, cnt=%" PRIu64 ", cpyKind=%s.", cnt, MemcpyKindToStr(cpyKind));

    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Stream* const curStm = curCtx->DefaultStream_();
    COND_RETURN_ERROR(curStm == nullptr, RT_ERROR_STREAM_NULL, "CC default stream is null.");
    // 遇错即停场景，提前拦截报错说明，否则下面流同步还是会报错
    ret = curStm->CheckContextStatus();
    COND_RETURN_ERROR(
        ret != RT_ERROR_NONE, RT_ERROR_FEATURE_NOT_SUPPORT,
        "Context is aborted, status=%#x. synchronous CC memory copy is not support", static_cast<uint32_t>(ret));

    ret = SubmitCcMemcpyTask(dst, src, cnt, cpyKind, curStm);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "Submit CC memcpy sync task failed, ret=%#x.", ret);

    ret = curStm->Synchronize();
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "StreamSynchronize failed, stream_id=%d.", curStm->Id_());
    return RT_ERROR_NONE;
}

rtError_t CCManager::CCMemcpyAsync(
    void* const dst, const uint64_t destMax, const void* const src, const uint64_t cnt, const rtMemcpyKind_t kind,
    Stream* const stm, const rtTaskCfgInfo_t* const cfgInfo, const struct rtD2DAddrCfgInfo_t* const addrCfg,
    bool checkKind, const rtMemcpyConfig_t* const memcpyConfig)
{
    RT_LOG(RT_LOG_INFO, "CCMemcpyAsync in, kind=%s.", MemcpyKindToStr(kind));
    (void)addrCfg;
    (void)memcpyConfig;
    (void)destMax;
    (void)cfgInfo;
    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Stream* curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
    }
    COND_RETURN_ERROR(curStm == nullptr, RT_ERROR_STREAM_NULL, "CC memcpy stream is null.");
    const void* submitSrc = src;
    rtMemcpyKind_t cpyKind = kind;
    std::shared_ptr<void> guardMem;

    if (kind == RT_MEMCPY_DEVICE_TO_DEVICE) {
        return RT_ERROR_CONTINUE_EXECUTE;
    }

    rtError_t ret = RT_ERROR_NONE;
    if (kind == RT_MEMCPY_HOST_TO_DEVICE_EX) {
        // H->Buffer->D 单独处理
        ret = PrepareCcAsyncH2dEx(curStm, submitSrc, cnt, cpyKind, guardMem);
        COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "Prepare CC H2D EX failed, ret=%#x.", ret);
    } else if (!checkKind) {
        // 接口指定不校验方向，在CC模式下需要校验，否则访问加解密访问错误地址会core
        ret = SetCcMemcpyKindByAddr(dst, src, cpyKind);
        if (ret == RT_ERROR_CONTINUE_EXECUTE) {
            return ret;
        }
        COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "Verify CC memcpy async kind failed, ret=%#x.", ret);
    } else {
        if ((cpyKind != RT_MEMCPY_DEVICE_TO_HOST) && (cpyKind != RT_MEMCPY_HOST_TO_DEVICE)) {
            return RT_ERROR_CONTINUE_EXECUTE;
        }
    }
    return SubmitCcMemcpyTask(dst, submitSrc, cnt, cpyKind, curStm, std::move(guardMem));
}

rtError_t CCManager::SubmitCcMemcpy2DTasks(
    void* const dst, const uint64_t dstPitch, const void* const src, const uint64_t srcPitch, const uint64_t width,
    const uint64_t height, Stream* const stm, const rtMemcpyKind_t kind)
{
    RT_LOG(RT_LOG_INFO, "SubmitCcMemcpy2DTasks in, kind=%s.", MemcpyKindToStr(kind));
    const void* const devAddr = (kind == RT_MEMCPY_HOST_TO_DEVICE) ? dst : src;
    const uint64_t devPitch = (kind == RT_MEMCPY_HOST_TO_DEVICE) ? dstPitch : srcPitch;
    const uint64_t rangeSize = (height - 1U) * devPitch + width;
    const rtError_t error = CheckMemAddrRangeValid(devAddr, rangeSize);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    uint8_t* const dstBase = static_cast<uint8_t*>(dst);
    const uint8_t* const srcBase = static_cast<const uint8_t*>(src);
    for (uint64_t row = 0U; row < height; ++row) {
        void* const rowDst = dstBase + row * dstPitch;
        const void* const rowSrc = srcBase + row * srcPitch;
        const rtError_t ret = SubmitCcMemcpyTask(rowDst, rowSrc, width, kind, stm);
        if (ret != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "Submit CC memcpy2d row failed, row=%" PRIu64 ", ret=%#x.", row, ret);
            return ret;
        }
    }
    return RT_ERROR_NONE;
}

rtError_t CCManager::CCMemCopy2DAsync(
    void* const dst, const uint64_t dstPitch, const void* const src, const uint64_t srcPitch, const uint64_t width,
    const uint64_t height, Stream* const stm, const rtMemcpyKind_t kind, const rtMemcpyKind newKind)
{
    RT_LOG(RT_LOG_INFO, "CCMemCopy2DAsync in, kind=%s.", MemcpyKindToStr(kind));
    (void)newKind;
    if ((kind != RT_MEMCPY_HOST_TO_DEVICE) && (kind != RT_MEMCPY_DEVICE_TO_HOST)) {
        return RT_ERROR_CONTINUE_EXECUTE;
    }

    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream* curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    }
    COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM_WITH_FUNC_DESC(
        curStm, curCtx, RT_ERROR_STREAM_CONTEXT, "Asynchronous CC 2D memory copy");

    return SubmitCcMemcpy2DTasks(dst, dstPitch, src, srcPitch, width, height, curStm, kind);
}

rtError_t CCManager::CCMemCopy2DSync(
    void* const dst, const uint64_t dstPitch, const void* const src, const uint64_t srcPitch, const uint64_t width,
    const uint64_t height, const rtMemcpyKind_t kind, const rtMemcpyKind newKind)
{
    RT_LOG(RT_LOG_INFO, "CCMemCopy2DSync in, kind=%s.", MemcpyKindToStr(kind));
    (void)newKind;
    if ((kind != RT_MEMCPY_HOST_TO_DEVICE) && (kind != RT_MEMCPY_DEVICE_TO_HOST)) {
        return RT_ERROR_CONTINUE_EXECUTE;
    }

    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream* const curStm = curCtx->DefaultStream_();
    NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    CHECK_CAPTURE_MODE_SUPPORT_AND_RETURN_WITH_FUNC_DESC(curCtx, "Synchronous CC 2D memory copy");

    rtError_t ret = SubmitCcMemcpy2DTasks(dst, dstPitch, src, srcPitch, width, height, curStm, kind);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "Submit CC memcpy 2d tasks failed, ret=%#x.", ret);

    // 流同步保持同步拷贝语义
    ret = curStm->Synchronize();
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "StreamSynchronize failed, stream_id=%d.", curStm->Id_());
    return RT_ERROR_NONE;
}

rtError_t CCManager::SubmitCcMemcpyBatchTasks(
    void** const dsts, const size_t* const destMaxs, void** const srcs, const size_t* const sizes, const size_t count,
    const rtMemcpyBatchAttr* const attrs, const size_t* const attrsIdxs, const size_t numAttrs, size_t* const failIdx,
    Stream* const stm)
{
    RT_LOG(RT_LOG_INFO, "SubmitCcMemcpyBatchTasks in");
    size_t attrIdx = 0U;
    rtMemcpyBatchAttr memAttr = attrs[0];
    rtPtrAttributes_t dstAttr{};
    rtPtrAttributes_t srcAttr{};
    rtMemLocationType realDstLoc = RT_MEMORY_LOC_MAX;
    rtMemLocationType realSrcLoc = RT_MEMORY_LOC_MAX;
    for (size_t i = 0U; i < count; ++i) {
        if (((attrIdx + 1U) < numAttrs) && (i >= attrsIdxs[attrIdx + 1U])) {
            ++attrIdx;
            memAttr = attrs[attrIdx];
        }

        const uint64_t destMax = (destMaxs == nullptr) ? static_cast<uint64_t>(sizes[i]) : destMaxs[i];
        COND_PROC_RETURN_ERROR(
            (dsts[i] == nullptr) || (srcs[i] == nullptr), RT_ERROR_INVALID_VALUE, SetFailIndex(failIdx, i),
            "CC memcpy batch item address is null, index=%zu.", i);
        COND_PROC_RETURN_ERROR(
            (sizes[i] == 0U) || (sizes[i] > destMax), RT_ERROR_INVALID_VALUE, SetFailIndex(failIdx, i),
            "Invalid CC memcpy batch item size, index=%zu, size=%zu, destMax=%" PRIu64 ".", i, sizes[i], destMax);

        rtError_t error = CheckMemCpyAttr(dsts[i], srcs[i], memAttr, dstAttr, srcAttr);
        ERROR_PROC_RETURN_MSG_INNER(
            error, SetFailIndex(failIdx, i), "Failed to verify %zuth CC memory pair attributes. retCode=%#x.", i,
            static_cast<uint32_t>(error));

        realDstLoc = (dstAttr.location.type == RT_MEMORY_LOC_UNREGISTERED) ? RT_MEMORY_LOC_HOST : dstAttr.location.type;
        realSrcLoc = (srcAttr.location.type == RT_MEMORY_LOC_UNREGISTERED) ? RT_MEMORY_LOC_HOST : srcAttr.location.type;
        COND_PROC_RETURN_AND_MSG_OUTER(
            realDstLoc == realSrcLoc, RT_ERROR_INVALID_VALUE, ErrorCode::EE1016, SetFailIndex(failIdx, i),
            "CC batch memory copy",
            RtFmtMsg(
                "Only H2D and D2H copy directions are supported. The destination location type is %s,"
                " and the source location type is %s",
                MemLocationTypeToString(realDstLoc).c_str(), MemLocationTypeToString(realSrcLoc).c_str()));

        const rtMemcpyKind_t kind =
            (realDstLoc == RT_MEMORY_LOC_DEVICE) ? RT_MEMCPY_HOST_TO_DEVICE : RT_MEMCPY_DEVICE_TO_HOST;
        error = SubmitCcMemcpyTask(dsts[i], srcs[i], sizes[i], kind, stm);
        ERROR_PROC_RETURN_MSG_INNER(
            error, SetFailIndex(failIdx, i), "Failed to submit %zuth CC memory copy task. retCode=%#x.", i,
            static_cast<uint32_t>(error));
    }
    return RT_ERROR_NONE;
}

rtError_t CCManager::CCMemcpyBatchAsync(
    void** const dsts, const size_t* const destMaxs, void** const srcs, const size_t* const sizes, const size_t count,
    const rtMemcpyBatchAttr* const attrs, const size_t* const attrsIdxs, const size_t numAttrs, size_t* const failIdx,
    Stream* const stm)
{
    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Stream* curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        NULL_PTR_RETURN_MSG(curStm, RT_ERROR_STREAM_NULL);
    }
    COND_RETURN_ERROR(
        curStm->Context_() != curCtx, RT_ERROR_STREAM_CONTEXT,
        "CCMemcpyBatch async failed, stream is not in current context, stream_id=%d.", curStm->Id_());

    return SubmitCcMemcpyBatchTasks(dsts, destMaxs, srcs, sizes, count, attrs, attrsIdxs, numAttrs, failIdx, curStm);
}

rtError_t CCManager::CCMemcpyBatch(
    void** const dsts, void** const srcs, size_t* const sizes, const size_t count, rtMemcpyBatchAttr* const attrs,
    size_t* const attrsIdxs, const size_t numAttrs, size_t* const failIdx)
{
    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Stream* const curStm = curCtx->DefaultStream_();
    COND_RETURN_ERROR(curStm == nullptr, RT_ERROR_STREAM_NULL, "CC default stream is null.");

    rtError_t ret =
        SubmitCcMemcpyBatchTasks(dsts, nullptr, srcs, sizes, count, attrs, attrsIdxs, numAttrs, failIdx, curStm);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "Submit CC memcpy batch tasks failed, ret=%#x.", ret);

    // 流同步保持同步拷贝语义
    ret = curStm->Synchronize();
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "StreamSynchronize failed, stream_id=%d.", curStm->Id_());
    return RT_ERROR_NONE;
}

rtError_t CCManager::CCDevMemSet(
    Stream* const stm, void* const dst, const uint64_t totalCnt, const uint32_t value, bool isByteFill)
{
    uint64_t singleSize = (totalCnt < MEM_BLOCK_SIZE) ? totalCnt : MEM_BLOCK_SIZE;
    if (!isByteFill) { // memset32 按4字节处理
        singleSize = (singleSize / sizeof(uint32_t)) * sizeof(uint32_t);
    }

    Driver* const driver = stm->Device_()->Driver_();
    void* hostPtr = nullptr;
    rtError_t ret = driver->HostMemAlloc(&hostPtr, singleSize, stm->Device_()->Id_());
    ERROR_RETURN(ret, "Host alloc failed, size=%" PRIu64 ", ret=%#x.", singleSize, ret);
    NULL_PTR_RETURN_MSG(hostPtr, RT_ERROR_MEMORY_ALLOCATION);
    std::shared_ptr<void> guard(hostPtr, [driver](void* p) {
        if (p != nullptr) {
            (void)driver->HostMemFree(p);
        }
    });
    if (isByteFill) {
        const errno_t secRet = memset_s(hostPtr, singleSize, static_cast<int32_t>(value), singleSize);
        COND_RETURN_ERROR(secRet != EOK, RT_ERROR_SEC_HANDLE, "memset_s host buffer failed, ret=%d.", secRet);
    } else {
        MemsetD32Optimized(static_cast<uint32_t*>(hostPtr), value, singleSize / sizeof(uint32_t));
    }

    uint64_t doneSize = 0U;
    while (doneSize < totalCnt) {
        const uint64_t remainSize = totalCnt - doneSize;
        const uint64_t curSize = (remainSize < singleSize) ? remainSize : singleSize;
        void* const curDst = static_cast<uint8_t*>(dst) + doneSize;

        ret = SubmitCcMemcpyTask(curDst, hostPtr, curSize, RT_MEMCPY_HOST_TO_DEVICE, stm, guard);
        COND_RETURN_ERROR(
            ret != RT_ERROR_NONE, ret,
            "Submit CC memset block failed, doneSize=%" PRIu64 ", curSize=%" PRIu64 ", ret=%#x.", doneSize, curSize,
            static_cast<uint32_t>(ret));

        doneSize += curSize;
    }
    return RT_ERROR_NONE;
}

rtError_t CCManager::CCDevMemSetAsync(
    Stream* const stm, void* const ptr, const uint64_t destMax, const uint32_t fillVal, const uint64_t fillCount)
{
    RT_LOG(RT_LOG_INFO, "CCDevMemSetAsync in, count=%" PRIu64 ", value=%u.", fillCount, fillVal);
    COND_RETURN_ERROR(stm == nullptr, RT_ERROR_STREAM_NULL, "CC memset stream is null.");
    COND_RETURN_ERROR(ptr == nullptr, RT_ERROR_INVALID_VALUE, "CC memset ptr is null.");
    if (fillCount == 0U) {
        return RT_ERROR_NONE;
    }
    COND_RETURN_ERROR(
        fillCount > destMax, RT_ERROR_INVALID_VALUE,
        "fillCount=%" PRIu64 " must be less than or equal to destMax=%" PRIu64 ".", fillCount, destMax);

    return CCDevMemSet(stm, ptr, fillCount, fillVal, true);
}

rtError_t CCManager::CCDevMemSetD32(
    void* const dst, const uint64_t destMax, const uint32_t value, const uint64_t count, Stream* const stm,
    const bool isAsync)
{
    RT_LOG(RT_LOG_INFO, "CCDevMemSetD32 in, count=%" PRIu64 ", value=%u.", count, value);
    COND_RETURN_ERROR(dst == nullptr, RT_ERROR_INVALID_VALUE, "CC memset dst is null.");
    if (count == 0U) {
        return RT_ERROR_NONE;
    }
    const uint64_t unitSize = 4UL;
    COND_RETURN_ERROR(count > (UINT64_MAX / sizeof(uint32_t)), RT_ERROR_INVALID_VALUE, "memset size overflow.");
    const uint64_t totalCnt = count * unitSize;
    COND_RETURN_ERROR(totalCnt > destMax, RT_ERROR_INVALID_VALUE, "memset size exceeds destMax.");

    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    if (!isAsync) {
        CHECK_CAPTURE_MODE_SUPPORT_AND_RETURN_WITH_FUNC_DESC(curCtx, "Synchronous CC memset32");
    }

    Stream* curStm = stm;
    if (curStm == nullptr) {
        curStm = curCtx->DefaultStream_();
        COND_RETURN_ERROR(curStm == nullptr, RT_ERROR_STREAM_NULL, "CC default stream is null.");
    }

    rtError_t ret = CCDevMemSet(curStm, dst, totalCnt, value, false);
    COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "CCDevMemSet failed, ret=%#x.", ret);

    if (!isAsync) {
        ret = curStm->Synchronize();
        COND_RETURN_ERROR(ret != RT_ERROR_NONE, ret, "StreamSynchronize failed, ret=%#x.", ret);
    }
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
