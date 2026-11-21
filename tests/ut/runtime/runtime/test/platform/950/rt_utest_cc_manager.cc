/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cstdio>
#include <stdlib.h>
#include <thread>
#include <chrono>
#include <atomic>
#include <future>
#include <cstdlib>
#include <string>
#include <cstring>
#include <vector>
#include <unistd.h>

#include "securec.h"
#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#include "api_impl.hpp"
#include "api_impl_david.hpp"
#include "aicpu_c.hpp"
#include "memcpy_c.hpp"
#include "aicpu_timeout_control.h"
#include "dev_info_manage.h"
#include "npu_driver.hpp"
#include "osal.hpp"
#include "mmpa_api.h"
#include "memcpy_c.hpp"

#define private public
#define protected public
#include "cc_manager.h"
#include "cc_res_manage.h"
#include "cc_worker.h"
#include "utils/thread_pool.h"
#include "common/cc_utils.h"
#include "crypto/cc_crypto.h"
#include "common/cc_defs.h"
#include "crypto/device/cc_kernel_abi.h"
#include "crypto/keystream/keystream_manager.h"
#include "crypto/openssl_loader.h"
#include "cc_stream_res_manage.h"
#include "task_queue/host_task_queue.h"
#include "cc_task_queue.h"
#include "crypto/cc_crypto_plugin.h"
#include "crypto/aiv/cc_aiv_launch.h"
#include "crypto/ctr/cc_ctr_plugin.h"
#include "crypto/gcm/cc_gcm_plugin.h"
#include "cond_c.hpp"
#include "context.hpp"
#include "device.hpp"
#include "stream.hpp"
#include "raw_device.hpp"
#include "runtime.hpp"
#include "driver.hpp"
#include "stream_sqcq_manage.hpp"
#include "thread_local_container.hpp"
#include "../../common/rt_utest_context_reset_helper.hpp"
#include "../../common/rt_unwrap.h"
#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;

// 设备租借样板：44 个用例都是「DeviceRetain(0,0) + 非空断言」，用宏保留 ASSERT 语义（就地展开）。
#define RETAIN_DEVICE(dev)                                             \
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0); \
    ASSERT_NE(dev, (Device*)nullptr)

namespace {
constexpr uint32_t CC_TEST_DEVICE_ID = 1U;
hal_cc_mode_type gCcMode = HAL_CC_MODE_NORMAL;
drvError_t gCcQueryResult = DRV_ERROR_NONE;
uint32_t gCcResourceReleaseCount = 0U;
uint32_t gCcResourceInitCount = 0U;
uint32_t gDevMemAllocCount = 0U;
bool gReturnNullDriver = false;
bool gPcieRegFail = false;
bool gPcieMappedNull = false;
uint32_t gDevMemFreeCount = 0U;
uint64_t gLastDevMemAllocSize = 0U;         // 最近一次 DevMemAllocWithFlag 的入参 size（对齐回归用）
uint32_t gLastDevMemFreeDevId = UINT32_MAX; // 最近一次 DevMemFree 的 devId（析构释放口径回归用）
bool gDevMemAllocReturnFail = false;
bool gHostDmaMapFail = false;
uint32_t gHostDmaUnmapCount = 0U;
uint32_t gHostMemFreeCount = 0U;
bool gInStreamCreate = false;
uint32_t gHostAllocCount = 0U;
uint32_t gHostAllocFailAt = 0U;
uint32_t gFakeDeviceId = 0U;
bool gDrvMemcpyFail = false;
struct MemRange {
    DVdeviceptr baseAddr = 0U;
    size_t allocSize = 0U;
};
struct MemRangeStubState {
    drvError_t result = DRV_ERROR_NONE;
    DVdeviceptr baseAddr = 0U;
    size_t allocSize = 0U;
    DVdeviceptr queriedAddr = 0U;
    uint32_t callCount = 0U;
    std::vector<MemRange> ranges;
    std::vector<DVdeviceptr> queriedAddrs;
};
MemRangeStubState gMemRangeStub;
std::atomic<DVdeviceptr> gObservedD2HDst{0U};
BarTaskQueue* gObservedD2HQueue = nullptr;
uint32_t gExpectedD2HSlice = UINT32_MAX;
uint32_t gExpectedD2HHead = 0U;
uint32_t gExpectedD2HTail = 0U;
std::atomic<bool> gExpectedD2HSlicePublishedAtDma{false};
std::atomic<bool> gAllowD2HNextConsume{false};
struct SmallLaunchRecord {
    CCSmallCryptoMetadata metadata;
    uint8_t ciphertext[CC_SMALL_CIPHER_CAPACITY];
};
std::vector<SmallLaunchRecord> gSmallLaunches;
bool gSmallAuthFail = false;
rtError_t gSmallCopyError = RT_ERROR_NONE;

rtError_t SmallBatchH2DAttrStub(
    const void*, const void*, const rtMemcpyBatchAttr&, rtPtrAttributes_t& dstAttr, rtPtrAttributes_t& srcAttr)
{
    dstAttr.location.type = RT_MEMORY_LOC_DEVICE;
    srcAttr.location.type = RT_MEMORY_LOC_HOST;
    return RT_ERROR_NONE;
}

rtError_t SmallLaunchStub(
    const rtKernelLaunchNames_t* names, uint32_t, const rtArgsEx_t* args, Stream* stm, uint32_t, uint64_t)
{
    EXPECT_STREQ(names->kernelName, "AiccCryptoSmall");
    EXPECT_EQ(args->isNoNeedH2DCopy, 0U);
    const size_t headerSize = offsetof(CCSmallCryptoKernelParam, ciphertext);
    if ((args->argsSize < headerSize) || (args->argsSize > headerSize + CC_SMALL_CIPHER_CAPACITY)) {
        ADD_FAILURE() << "Invalid small crypto argument size";
        return RT_ERROR_INVALID_VALUE;
    }
    const auto& param = *static_cast<const CCSmallCryptoKernelParam*>(args->args);
    const size_t payloadSize = args->argsSize - headerSize;
    EXPECT_EQ(param.keyLen, AICC_KEY_SIZE);
    EXPECT_EQ(param.algType, AICC_ALG_AES128_GCM);
    SmallLaunchRecord record{};
    record.metadata = param.metadata;
    if (payloadSize != 0U) {
        EXPECT_EQ(memcpy_s(record.ciphertext, sizeof(record.ciphertext), param.ciphertext, payloadSize), EOK);
    }
    gSmallLaunches.push_back(record);
    if (param.mode == static_cast<uint32_t>(CC_CRYPTO_DIRECTION::ENCRYPT)) {
        auto* ciphertext = RtValueToPtr<uint8_t*>(param.metadata.dstAddr);
        size_t ciphertextLen = 0U;
        auto& crypto = CCManager::Instance().resources_[stm->Device_()->Id_()]->Crypto();
        const rtError_t ret = crypto.Encrypt(
            stm->Device_()->Id_(), CC_CRYPTO_CIPHER::AES_128, RtValueToPtr<const uint8_t*>(param.metadata.srcAddr),
            param.metadata.plaintextLen, reinterpret_cast<const uint8_t*>(&param.metadata), sizeof(param.metadata),
            ciphertext, &ciphertextLen);
        EXPECT_EQ(ret, RT_ERROR_NONE);
        if (ret != RT_ERROR_NONE) {
            return ret;
        }
        EXPECT_EQ(ciphertextLen, sizeof(AiccCiphertextHeader) + param.metadata.plaintextLen);
        if (gSmallAuthFail) {
            reinterpret_cast<AiccCiphertextHeader*>(ciphertext)->tag[0] ^= 1U;
        }
    }
    return RT_ERROR_NONE;
}

rtError_t SmallCopyStub(
    Driver*, void* dst, uint64_t capacity, const void* src, uint64_t length, rtMemcpyKind_t, bool, uint32_t)
{
    if (gSmallCopyError != RT_ERROR_NONE) {
        return gSmallCopyError;
    }
    return (memcpy_s(dst, capacity, src, length) == EOK) ? RT_ERROR_NONE : RT_ERROR_INVALID_VALUE;
}

drvError_t DrvMemcpyStub(DVdeviceptr dst, size_t destMax, DVdeviceptr src, size_t count)
{
    if (gDrvMemcpyFail || (dst == 0U) || (src == 0U) || (count > destMax)) {
        return DRV_ERROR_INVALID_VALUE;
    }
    (void)memcpy_s(RtValueToPtr<void*>(dst), destMax, RtValueToPtr<void*>(src), count);
    if (dst == gObservedD2HDst.load()) {
        const bool isPublished = (gObservedD2HQueue != nullptr) && (gObservedD2HQueue->head == gExpectedD2HHead) &&
                                 (gObservedD2HQueue->tail == gExpectedD2HTail) &&
                                 (reinterpret_cast<const AiccCryptoSliceDesc*>(
                                      gObservedD2HQueue->taskDescList +
                                      static_cast<size_t>(gExpectedD2HTail) * gObservedD2HQueue->taskDescSize)
                                      ->sliceIdx == gExpectedD2HSlice);
        gExpectedD2HSlicePublishedAtDma.store(isPublished);
        gAllowD2HNextConsume.store(true);
    }
    return DRV_ERROR_NONE;
}

drvError_t MemGetAddressRangeStub(DVdeviceptr ptr, DVdeviceptr* pbase, size_t* psize)
{
    gMemRangeStub.queriedAddr = ptr;
    gMemRangeStub.queriedAddrs.emplace_back(ptr);
    ++gMemRangeStub.callCount;
    if (gMemRangeStub.result != DRV_ERROR_NONE) {
        return gMemRangeStub.result;
    }
    for (const auto& range : gMemRangeStub.ranges) {
        if ((ptr >= range.baseAddr) && ((ptr - range.baseAddr) < range.allocSize)) {
            if (pbase != nullptr) {
                *pbase = range.baseAddr;
            }
            if (psize != nullptr) {
                *psize = range.allocSize;
            }
            return DRV_ERROR_NONE;
        }
    }
    if (!gMemRangeStub.ranges.empty()) {
        return DRV_ERROR_INVALID_VALUE;
    }
    if (pbase != nullptr) {
        *pbase = gMemRangeStub.baseAddr;
    }
    if (psize != nullptr) {
        *psize = gMemRangeStub.allocSize;
    }
    return DRV_ERROR_NONE;
}

void MockMemGetAddressRange(
    const DVdeviceptr baseAddr, const size_t allocSize, const drvError_t result = DRV_ERROR_NONE)
{
    gMemRangeStub = {};
    gMemRangeStub.result = result;
    gMemRangeStub.baseAddr = baseAddr;
    gMemRangeStub.allocSize = allocSize;
    MOCKER(halMemGetAddressRange).stubs().will(invoke(MemGetAddressRangeStub));
}

void MockMemGetAddressRanges(const std::vector<MemRange>& ranges)
{
    gMemRangeStub = {};
    gMemRangeStub.ranges = ranges;
    MOCKER(halMemGetAddressRange).stubs().will(invoke(MemGetAddressRangeStub));
}

uint32_t FakeDeviceIdStub(Device* dev)
{
    (void)dev;
    return gFakeDeviceId;
}

Driver* FakeDeviceDriverStub(Device* dev)
{
    (void)dev;
    if (gReturnNullDriver) {
        return nullptr;
    }
    return Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
}

rtError_t PcieHostRegisterStub(Driver* drv, void* addr, uint64_t size, uint32_t deviceId, void*& outAddr)
{
    (void)drv;
    (void)size;
    (void)deviceId;
    if (gPcieRegFail) {
        outAddr = nullptr;
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    outAddr = (gPcieMappedNull) ? nullptr : addr;
    return RT_ERROR_NONE;
}

rtError_t DevMemFreeStub(Driver* drv, void* dptr, uint32_t deviceId)
{
    (void)drv;
    (void)dptr;
    gLastDevMemFreeDevId = deviceId;
    ++gDevMemFreeCount;
    return RT_ERROR_NONE;
}

int32_t CheckHostCcPathStub(const char_t* const path, const int32_t mode)
{
    EXPECT_STREQ(path, "/dev/sev-guest");
    EXPECT_EQ(mode, M_F_OK);
    return EN_OK;
}

int32_t CheckCcSysfsExistsStub(const char_t* const path, const int32_t mode)
{
    (void)mode;
    return (strcmp(path, "/sys/kernel/security/cvm_guest/mem_encrypt_enable") == 0) ? EN_OK : EN_ERROR;
}

void ReleaseCcResourceStub(const uint32_t deviceId)
{
    EXPECT_EQ(deviceId, 0U);
    ++gCcResourceReleaseCount;
}

rtError_t InitCcResourceStub(Device* const device)
{
    EXPECT_NE(device, nullptr);
    if (device == nullptr) {
        return RT_ERROR_DEVICE_NULL;
    }
    EXPECT_EQ(device->Id_(), CC_TEST_DEVICE_ID);
    ++gCcResourceInitCount;
    return RT_ERROR_NONE;
}

rtError_t InitCcResourceFailedStub(Device* const device)
{
    EXPECT_NE(device, nullptr);
    if (device == nullptr) {
        return RT_ERROR_DEVICE_NULL;
    }
    EXPECT_EQ(device->Id_(), CC_TEST_DEVICE_ID);
    ++gCcResourceInitCount;
    return RT_ERROR_CC_INIT_FAILED;
}

drvError_t QueryCcInfoStub(
    const uint32_t deviceId, const int32_t moduleType, const int32_t infoType, void* const buffer, int32_t* const size)
{
    EXPECT_EQ(deviceId, 0U);
    EXPECT_EQ(moduleType, static_cast<int32_t>(MODULE_TYPE_CC));
    EXPECT_EQ(infoType, static_cast<int32_t>(INFO_TYPE_CC));
    if (gCcQueryResult != DRV_ERROR_NONE) {
        return gCcQueryResult;
    }
    static_cast<HAL_CC_INFO*>(buffer)->cc_running_info.cc_mode = gCcMode;
    *size = static_cast<int32_t>(sizeof(HAL_CC_INFO));
    return DRV_ERROR_NONE;
}

// DevMemAllocWithFlag 输出参数 stub：第 1 次为 BAR 队列（需可写，约 112B），第 2/3 次为 Device Buffer A/B（仅取地址）。
rtError_t DevMemAllocStub(
    Driver* const driver, void** const dptr, const uint64_t size, const rtMemType_t type, const uint32_t deviceId,
    const DevMemAllocConfig* const config, const uint64_t curFlag)
{
    (void)driver;
    gLastDevMemAllocSize = size;
    (void)type;
    (void)deviceId;
    (void)config;
    (void)curFlag;
    if (gInStreamCreate) {
        // 流创建阶段系统内部申请（SQ/BW 等），仅占位返回，不计入 CC 资源计数。
        static uint8_t fakeStreamMem[16 * 1024];
        *dptr = fakeStreamMem;
        return RT_ERROR_NONE;
    }
    if (gDevMemAllocReturnFail) {
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    static uint8_t barMem[256];
    static uint8_t bufA[64];
    static uint8_t bufB[64];
    ++gDevMemAllocCount;
    if (gDevMemAllocCount == 1U) {
        *dptr = barMem;
    } else {
        *dptr = (gDevMemAllocCount == 2U) ? bufA : bufB;
    }
    return RT_ERROR_NONE;
}

// DevMemAllocWithBackupFlag 入口 stub（6 参签名）：CCWorker/CCStreamResManage 申请路径使用。
rtError_t DevMemAllocEntryStub(
    Driver* const driver, void** const dptr, const uint64_t size, const rtMemType_t type, const uint32_t deviceId,
    const DevMemBackupType backupType, const DevMemAllocConfig* const config)
{
    (void)backupType;
    return DevMemAllocStub(driver, dptr, size, type, deviceId, config, 0U);
}

rtError_t HostDmaMapStub(Driver* drv, void* ptr, uint64_t size, uint32_t deviceId)
{
    (void)drv;
    (void)ptr;
    (void)size;
    (void)deviceId;
    if (gHostDmaMapFail) {
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    return RT_ERROR_NONE;
}

rtError_t HostDmaUnmapStub(Driver* drv, void* ptr, uint32_t deviceId)
{
    (void)drv;
    (void)ptr;
    (void)deviceId;
    ++gHostDmaUnmapCount;
    return RT_ERROR_NONE;
}

rtError_t HostMemFreeStub(Driver* drv, void* dptr)
{
    (void)drv;
    (void)dptr;
    ++gHostMemFreeCount;
    return RT_ERROR_NONE;
}

bool CreatePersistentStream(rtStream_t& handle)
{
    Driver* driver = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL(driver, &Driver::DevMemAllocWithFlag).stubs().will(invoke(DevMemAllocStub));
    MOCKER_CPP_VIRTUAL(driver, &Driver::GetSqRegVirtualAddrBySqid).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::MemCopySync).stubs().will(returnValue(RT_ERROR_NONE));
    gInStreamCreate = true;
    const bool ok = rtStreamCreateWithFlags(&handle, 0, RT_STREAM_PERSISTENT) == RT_ERROR_NONE;
    gInStreamCreate = false;
    return ok;
}

// 辅助线程模拟 AICPU 侧行为：按 BarTaskQueue 协议消费任务描述（推 tail 后推进 complete）。
// 该消费循环即当前 BarTaskQueue 协议的参考实现，AICPU 侧实现应与此保持一致。
class AicpuSimulator {
public:
    static void RunH2DConsumer(
        BarTaskQueue* queue, uint32_t totalSlices, const std::atomic<bool>& stop, std::atomic<uint32_t>& consumedCount)
    {
        while (!stop.load() && (consumedCount.load() < totalSlices)) {
            const uint32_t head = queue->head;
            const uint32_t tail = queue->tail;
            if (head != tail) {
                queue->tail = (tail + 1U) % queue->depth;
                const uint32_t newCount = consumedCount.fetch_add(1U, std::memory_order_relaxed) + 1U;
                queue->complete = newCount;
            }
            std::this_thread::sleep_for(std::chrono::milliseconds(1));
        }
    }

    static void RunD2HConsumer(
        BarTaskQueue* queue, const uint8_t* plaintextBase, const uint8_t* bufA, const uint8_t* bufB,
        const std::vector<uint32_t>& sliceLens, const std::atomic<bool>& stop, std::atomic<uint32_t>& consumedCount,
        std::atomic<bool>& descriptorValid)
    {
        size_t offset = 0U;
        for (uint32_t sliceIdx = 0U; (sliceIdx < sliceLens.size()) && !stop.load(); ++sliceIdx) {
            while (!stop.load() && (queue->head == queue->tail)) {
                std::this_thread::sleep_for(std::chrono::milliseconds(1));
            }
            if (stop.load()) {
                return;
            }

            const uint32_t tail = queue->tail;
            const AiccCryptoSliceDesc& info = *reinterpret_cast<const AiccCryptoSliceDesc*>(
                queue->taskDescList + static_cast<size_t>(tail) * queue->taskDescSize);
            const uint8_t* expectedBuf = (sliceIdx % 2U) == 0U ? bufA : bufB;
            const uint32_t sliceLen = sliceLens[sliceIdx];
            if ((info.sliceIdx != sliceIdx) || (info.ciphertextAddr != PtrToValue(expectedBuf)) ||
                (info.plaintextAddr != PtrToValue(plaintextBase + offset)) || (info.plaintextLen != sliceLen) ||
                (info.ciphertextLen != CC_CIPHER_HEADER_SIZE + sliceLen)) {
                descriptorValid.store(false);
            }
            offset += sliceLen;
            queue->tail = (tail + 1U) % queue->depth;
            const uint32_t newCount = consumedCount.fetch_add(1U, std::memory_order_relaxed) + 1U;
            queue->complete = newCount;
        }
    }
};

// HostMemAlloc 输出参数 stub：hostCryptoBuf 仅在任务处理阶段写入，Init/Destroy 阶段只持有地址。
// gHostAllocFailAt 非 0 时第 N 次调用失败（用于验证 worker 池部分失败回滚）。
rtError_t HostMemAllocStub(
    Driver* const driver, void** const dptr, const uint64_t size, const uint32_t deviceId, const uint16_t moduleId,
    const uint32_t vaFlag)
{
    (void)driver;
    (void)size;
    (void)deviceId;
    (void)moduleId;
    (void)vaFlag;
    ++gHostAllocCount;
    if ((gHostAllocFailAt != 0U) && (gHostAllocCount == gHostAllocFailAt)) {
        return RT_ERROR_MEMORY_ALLOCATION;
    }
    static uint8_t hostBuf[4096];
    *dptr = hostBuf;
    return RT_ERROR_NONE;
}

// 设备算子下发捕获 stub：两条下发通道各记一份，供下发用例断言。
//   - StreamLaunchCpuKernel：内建 AICPU 算子（AiccLoadKey / AiccCrypto / KeystreamFillParallel）
//   - CcLaunchAivKsXor：自研 AIV KeystreamXor
const char_t* gLaunchKernelName = nullptr;
uint8_t gLaunchArgs[128] = {0};
uint32_t gLaunchArgsSize = 0U;
AiccKeystreamXorParam gLaunchAiccKeystreamXorParam = {};

void ResetLaunchCapture()
{
    gLaunchKernelName = nullptr;
    gLaunchArgsSize = 0U;
    (void)memset_s(gLaunchArgs, sizeof(gLaunchArgs), 0, sizeof(gLaunchArgs));
    gLaunchAiccKeystreamXorParam = AiccKeystreamXorParam{};
}

rtError_t StreamLaunchCpuKernelCapture(
    const rtKernelLaunchNames_t* const launchNames, const uint32_t coreDim, const rtArgsEx_t* const argsInfo,
    Stream* const stm, const uint32_t flag, const uint64_t timeout)
{
    (void)coreDim;
    (void)stm;
    (void)flag;
    (void)timeout;
    gLaunchKernelName = (launchNames == nullptr) ? nullptr : launchNames->kernelName;
    if ((argsInfo != nullptr) && (argsInfo->args != nullptr)) {
        gLaunchArgsSize = argsInfo->argsSize;
        if (gLaunchArgsSize <= sizeof(gLaunchArgs)) {
            (void)memcpy_s(gLaunchArgs, sizeof(gLaunchArgs), argsInfo->args, gLaunchArgsSize);
        }
    }
    return RT_ERROR_NONE;
}

rtError_t CcLaunchAivKsXorCapture(Stream* const stm, const AiccKeystreamXorParam& param)
{
    (void)stm;
    gLaunchKernelName = "AiccKeystreamXor";
    gLaunchAiccKeystreamXorParam = param;
    return RT_ERROR_NONE;
}

// 下发路径重入探针：在 CcLaunchAivKsXor 被调用时（即 CC 设备核下发内部）执行一次拷贝入口调用。
// 旧实现的 thread_local 防递归旁路会让它直接返回 RT_ERROR_CONTINUE_EXECUTE；旁路删除后
// 必须按正常裁决执行（空指针入参 → RT_ERROR_INVALID_VALUE）。
rtError_t gNestedMemcpyRet = RT_ERROR_NONE;

rtError_t CcLaunchAivKsXorReentryProbe(Stream* const stm, const AiccKeystreamXorParam& param)
{
    (void)stm;
    (void)param;
    gNestedMemcpyRet = CCManager::CCMemCopySync(nullptr, 0U, nullptr, 0U, RT_MEMCPY_DEVICE_TO_DEVICE);
    return RT_ERROR_NONE;
}

} // namespace
// 由 stub/cc_crypto_stub.cc 提供，控制 OpenSSLLoader 是否就绪
namespace cce {
namespace runtime {
void SetOpenSSLLoaderReady(bool ready);
}
} // namespace cce

class CCManagerTest : public testing::Test {
protected:
    // ---------------------------------------------------------------- 共用驱动桩样板
    // 各用例只关心「这些驱动调用是否成功」，失败注入走各自的全局开关（gPcieRegFail 等）；
    // 计数版用 invoke 桩，供需要核对回滚次数（gDevMemFreeCount/gHostUnmapCount）的用例使用。
    void StubPcieAndFree(Driver* const driver)
    {
        MOCKER_CPP_VIRTUAL(driver, &Driver::PcieHostRegister).stubs().will(returnValue(RT_ERROR_NONE));
        MOCKER_CPP_VIRTUAL(driver, &Driver::PcieHostUnRegister).stubs().will(returnValue(RT_ERROR_NONE));
        MOCKER_CPP_VIRTUAL(driver, &Driver::DevMemFree).stubs().will(returnValue(RT_ERROR_NONE));
    }

    void StubPcieAndFreeCounted(Driver* const driver)
    {
        MOCKER_CPP_VIRTUAL(driver, &Driver::PcieHostRegister).stubs().will(invoke(PcieHostRegisterStub));
        MOCKER_CPP_VIRTUAL(driver, &Driver::PcieHostUnRegister).stubs().will(returnValue(RT_ERROR_NONE));
        MOCKER_CPP_VIRTUAL(driver, &Driver::DevMemFree).stubs().will(invoke(DevMemFreeStub));
    }

    // 流级资源（设备内存 + PCIe BAR）的完整桩；countFrees=true 时 DevMemFree 走计数桩
    void StubStreamResDriver(Driver* const driver, const bool countFrees)
    {
        MOCKER_CPP_VIRTUAL(driver, &Driver::DevMemAllocWithBackupFlag).stubs().will(invoke(DevMemAllocEntryStub));
        MOCKER_CPP_VIRTUAL(driver, &Driver::PcieHostRegister).stubs().will(invoke(PcieHostRegisterStub));
        MOCKER_CPP_VIRTUAL(driver, &Driver::PcieHostUnRegister).stubs().will(returnValue(RT_ERROR_NONE));
        if (countFrees) {
            MOCKER_CPP_VIRTUAL(driver, &Driver::DevMemFree).stubs().will(invoke(DevMemFreeStub));
        } else {
            MOCKER_CPP_VIRTUAL(driver, &Driver::DevMemFree).stubs().will(returnValue(RT_ERROR_NONE));
        }
    }

    // worker host 缓冲（HostMemAlloc + DMA map/unmap + free）；Simple 版不统计 map/unmap/free
    void StubWorkerHostDriver(Driver* const driver)
    {
        MOCKER_CPP_VIRTUAL(driver, &Driver::HostMemAlloc).stubs().will(invoke(HostMemAllocStub));
        MOCKER_CPP_VIRTUAL(driver, &Driver::HostDmaMap).stubs().will(invoke(HostDmaMapStub));
        MOCKER_CPP_VIRTUAL(driver, &Driver::HostDmaUnmap).stubs().will(invoke(HostDmaUnmapStub));
        MOCKER_CPP_VIRTUAL(driver, &Driver::HostMemFree).stubs().will(invoke(HostMemFreeStub));
    }

    void StubWorkerHostDriverSimple(Driver* const driver)
    {
        MOCKER_CPP_VIRTUAL(driver, &Driver::HostMemAlloc).stubs().will(invoke(HostMemAllocStub));
        MOCKER_CPP_VIRTUAL(driver, &Driver::HostDmaMap).stubs().will(returnValue(RT_ERROR_NONE));
        MOCKER_CPP_VIRTUAL(driver, &Driver::HostDmaUnmap).stubs().will(returnValue(RT_ERROR_NONE));
        MOCKER_CPP_VIRTUAL(driver, &Driver::HostMemFree).stubs().will(returnValue(RT_ERROR_NONE));
    }

    static void SetUpTestCase()
    {
        // 类级初始化使用普通 Host 环境创建 Runtime，CC 环境由各用例按需配置。
        MOCKER(mmAccess2).stubs().will(returnValue(EN_ERROR));
        Runtime* const runtime = Runtime::Instance();
        ASSERT_NE(runtime, nullptr);
        // 禁用 engine 监控/回收线程，避免其旁路调用 drvGetDevNum 等接口干扰后续内存分发注册用例。
        runtime->SetDisableThread(true);
        ASSERT_TRUE(runtime->HaveDevice());
        GlobalMockObject::verify();
    }

    static void TearDownTestCase() { std::cout << "CC Manager test end" << std::endl; }

    virtual void SetUp()
    {
        Runtime* rtInstance = (Runtime*)Runtime::Instance();
        oldChipType = rtInstance->GetChipType();
        rtInstance->SetChipType(CHIP_DAVID);
        GlobalContainer::SetRtChipType(CHIP_DAVID);
        int64_t hardwareVersion = CHIP_DAVID << 8;
        Driver* driver_ = rtInstance->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL(driver_, &Driver::GetDevInfo)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&hardwareVersion, sizeof(hardwareVersion)))
            .will(returnValue(RT_ERROR_NONE));
        char* socVer = "Ascend950PR_9599";
        MOCKER(halGetSocVersion)
            .stubs()
            .with(mockcpp::any(), outBoundP(socVer, strlen("Ascend950PR_9599")), mockcpp::any())
            .will(returnValue(DRV_ERROR_NONE));
        (void)rtSetDevice(0);
        gCcMode = HAL_CC_MODE_NORMAL;
        gCcQueryResult = DRV_ERROR_NONE;
        gCcResourceReleaseCount = 0U;
        gCcResourceInitCount = 0U;
        gDevMemAllocCount = 0U;
        gReturnNullDriver = false;
        gPcieRegFail = false;
        gPcieMappedNull = false;
        gDevMemFreeCount = 0U;
        gLastDevMemAllocSize = 0U;
        gLastDevMemFreeDevId = UINT32_MAX;
        gDevMemAllocReturnFail = false;
        gHostDmaMapFail = false;
        gHostDmaUnmapCount = 0U;
        gHostMemFreeCount = 0U;
        gInStreamCreate = false;
        gHostAllocCount = 0U;
        gHostAllocFailAt = 0U;
        gFakeDeviceId = 0U;
        gDrvMemcpyFail = false;
        gMemRangeStub = {};
        gObservedD2HDst.store(0U);
        gObservedD2HQueue = nullptr;
        gExpectedD2HSlice = UINT32_MAX;
        gExpectedD2HHead = 0U;
        gExpectedD2HTail = 0U;
        gExpectedD2HSlicePublishedAtDma.store(false);
        gAllowD2HNextConsume.store(false);
        gSmallLaunches.clear();
        gSmallAuthFail = false;
        gSmallCopyError = RT_ERROR_NONE;
        MOCKER(AicpuTimeoutControl::CheckKernelSupported).stubs().will(returnValue(RT_ERROR_NONE));
        MOCKER(drvMemcpy).stubs().will(invoke(DrvMemcpyStub));
        // 本套件按真实 CVM 口径跑：密钥由驱动桩 halGetSlotKey 提供。
        // CC 初始化会下发 LoadKey，用例里把 StreamLaunchCpuKernel
        // 打桩，既保证不把任务提交进 mock 驱动碰不到的真实回收通道（否则 SubmitMaintenanceTask→SyncTask
        // 会无限等 CQ 上报而挂死），也便于断言下发算子名与参数。
        std::cout << "ut test start." << std::endl;
    }

    virtual void TearDown()
    {
        if (smallResourceStream_ != nullptr) {
            delete smallResourceStream_->TakeCCStreamResource();
            smallResourceStream_ = nullptr;
        }
        CCManager::ReleaseDeviceResource(0U);
        rtDeviceReset(0);
        Runtime* rtInstance = (Runtime*)Runtime::Instance();
        rtInstance->SetChipType(oldChipType);
        GlobalContainer::SetRtChipType(oldChipType);
        GlobalMockObject::verify();
        std::cout << "ut test end." << std::endl;
    }

    static rtChipType_t GetCurrentChipType() { return Runtime::Instance()->GetChipType(); }

    Stream* PrepareSmallTransfer()
    {
        Stream* stm = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID)->DefaultStream_();
        Device* dev = stm->Device_();
        auto resource = std::make_unique<CCResManage>(dev);
        // Reuse cc_crypto_stub.cc for Host crypto instead of mocking const member callbacks.
        Driver* const driver = dev->Driver_();
        static uint8_t deviceKey[2U * AICC_KEY_SIZE]{};
        void* deviceKeyPtr = deviceKey;
        MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
        MOCKER_CPP_VIRTUAL(driver, &Driver::DevMemAllocWithFlag)
            .stubs()
            .with(outBoundP(&deviceKeyPtr, sizeof(deviceKeyPtr)))
            .will(returnValue(RT_ERROR_NONE));
        MOCKER_CPP_VIRTUAL(driver, &Driver::DevMemFree).stubs().will(invoke(DevMemFreeStub));
        SetOpenSSLLoaderReady(true);
        EXPECT_EQ(resource->Crypto().InitKey(dev->Id_()), RT_ERROR_NONE);
        resource->smallCryptoSupported_ = true;
        CCManager::Instance().resources_[dev->Id_()] = std::move(resource);
        if (stm->GetCCStreamResource() == nullptr) {
            stm->SetCCStreamResource(new CCStreamResManage());
            smallResourceStream_ = stm;
        }
        MOCKER_CPP(&Runtime::StartAicpuSd).stubs().will(returnValue(RT_ERROR_NONE));
        MOCKER(StreamLaunchCpuKernel).stubs().will(invoke(SmallLaunchStub));
        return stm;
    }

    Stream* PrepareSmallD2H()
    {
        Stream* stm = PrepareSmallTransfer();
        Driver* driver = stm->Device_()->Driver_();
        MOCKER_CPP_VIRTUAL(driver, &Driver::DevMemAllocWithBackupFlag).stubs().will(invoke(DevMemAllocEntryStub));
        MOCKER_CPP_VIRTUAL(driver, &Driver::HostMemAlloc).stubs().will(invoke(HostMemAllocStub));
        MOCKER_CPP_VIRTUAL(driver, &Driver::HostDmaMap).stubs().will(invoke(HostDmaMapStub));
        MOCKER_CPP_VIRTUAL(driver, &Driver::HostDmaUnmap).stubs().will(invoke(HostDmaUnmapStub));
        MOCKER_CPP_VIRTUAL(driver, &Driver::HostMemFree).stubs().will(invoke(HostMemFreeStub));
        MOCKER_CPP_VIRTUAL(driver, &Driver::MemCopySync).stubs().will(invoke(SmallCopyStub));
        return stm;
    }

private:
    rtChipType_t oldChipType;
    Stream* smallResourceStream_{nullptr};
};

// ============================================================================
// CCMemcpyTaskQueue Tests
// ============================================================================

TEST_F(CCManagerTest, TaskQueue_Pop_BlocksUntilPush)
{
    CCMemcpyTaskQueue queue;
    CCMemcpyTask poppedTask{};
    bool popCompleted = false;

    std::thread popThread([&]() { popCompleted = queue.Pop(poppedTask); });

    std::this_thread::sleep_for(std::chrono::milliseconds(50));
    EXPECT_FALSE(popCompleted);

    CCMemcpyTask task{};
    task.streamId = 42;
    queue.Push(task);

    popThread.join();
    EXPECT_TRUE(popCompleted);
    EXPECT_EQ(poppedTask.streamId, 42U);
}

TEST_F(CCManagerTest, TaskQueue_Shutdown_ReturnsFalse)
{
    CCMemcpyTaskQueue queue;
    queue.Shutdown();

    CCMemcpyTask task{};
    EXPECT_FALSE(queue.Push(task));

    CCMemcpyTask poppedTask{};
    EXPECT_FALSE(queue.Pop(poppedTask));
}

TEST_F(CCManagerTest, TaskQueue_CancelTasksByStream_Basic)
{
    CCMemcpyTaskQueue queue;

    CCMemcpyTask task1{};
    task1.streamId = 1;
    queue.Push(task1);

    CCMemcpyTask task2{};
    task2.streamId = 2;
    queue.Push(task2);

    CCMemcpyTask task3{};
    task3.streamId = 1;
    queue.Push(task3);

    queue.CancelTasksByStream(1);

    CCMemcpyTask poppedTask{};
    EXPECT_TRUE(queue.Pop(poppedTask));
    EXPECT_EQ(poppedTask.streamId, 2U);

    // Shutdown the queue so the second Pop returns false instead of blocking
    queue.Shutdown();
    EXPECT_FALSE(queue.Pop(poppedTask));
}

TEST_F(CCManagerTest, TaskQueue_FullEmpty)
{
    alignas(alignof(BarTaskQueue)) uint8_t queueBuf[sizeof(BarTaskQueue)] = {};
    BarTaskQueue* const queue = reinterpret_cast<BarTaskQueue*>(queueBuf);
    queue->depth = 3U;
    queue->head = 0U;
    queue->tail = 0U;

    bool isFull = true;
    bool isEmpty = false;
    ASSERT_EQ(IsBarTaskQueueFull(queue, &isFull), RT_ERROR_NONE);
    EXPECT_FALSE(isFull);
    ASSERT_EQ(IsBarTaskQueueEmpty(queue, &isEmpty), RT_ERROR_NONE);
    EXPECT_TRUE(isEmpty);

    queue->head = 1U;
    ASSERT_EQ(IsBarTaskQueueFull(queue, &isFull), RT_ERROR_NONE);
    EXPECT_FALSE(isFull);
    ASSERT_EQ(IsBarTaskQueueEmpty(queue, &isEmpty), RT_ERROR_NONE);
    EXPECT_FALSE(isEmpty);

    queue->head = 2U;
    ASSERT_EQ(IsBarTaskQueueFull(queue, &isFull), RT_ERROR_NONE);
    EXPECT_TRUE(isFull);
}

// ============================================================================
// XorBytesOptimized Tests（SIMD 主体 + 64bit/字节尾段 + 原地异或）
// ============================================================================

TEST_F(CCManagerTest, XorBytesOptimized_CoversLengthsAndAliasing)
{
    const size_t lengths[] = {0U, 1U, 7U, 8U, 9U, 15U, 16U, 17U, 31U, 32U, 33U, 1000U, 4096U};
    for (const size_t len : lengths) {
        std::vector<uint8_t> a(len);
        std::vector<uint8_t> b(len);
        for (size_t i = 0U; i < len; ++i) {
            a[i] = static_cast<uint8_t>((i * 7U) + 1U);
            b[i] = static_cast<uint8_t>((i * 13U) + 5U);
        }
        std::vector<uint8_t> out(len, 0xAAU);
        XorBytesOptimized(a.data(), b.data(), out.data(), len);
        for (size_t i = 0U; i < len; ++i) {
            ASSERT_EQ(out[i], static_cast<uint8_t>(a[i] ^ b[i])) << "len=" << len << " i=" << i;
        }
        // 输出与输入别名（原地异或）结果一致
        XorBytesOptimized(a.data(), b.data(), a.data(), len);
        for (size_t i = 0U; i < len; ++i) {
            ASSERT_EQ(a[i], out[i]) << "len=" << len << " i=" << i;
        }
    }
    // 空指针/零长度安全返回
    XorBytesOptimized(nullptr, nullptr, nullptr, 0U);
}

// ============================================================================
// CCrypto Tests
// ============================================================================

TEST_F(CCManagerTest, Crypto_InitKey_Success)
{
    CCrypto crypto;
    uint32_t deviceId = 0;

    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    crypto.InitKey(deviceId);

    rtError_t ret = crypto.ReleaseKey(deviceId);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CCManagerTest, Crypto_InitKey_Fails)
{
    CCrypto crypto;
    uint32_t deviceId = 0;

    // OpenSSLLoader 未就绪时 InitKey 应失败
    SetOpenSSLLoaderReady(false);
    rtError_t ret = crypto.InitKey(deviceId);
    EXPECT_NE(ret, RT_ERROR_NONE);
    SetOpenSSLLoaderReady(true);
}

TEST_F(CCManagerTest, Crypto_Encrypt_NullParams)
{
    CCrypto crypto;
    uint32_t deviceId = 0;
    uint8_t plaintext[16] = {0};
    uint8_t ciphertext[64] = {0};
    size_t ctLen = sizeof(ciphertext);

    rtError_t ret = crypto.Encrypt(deviceId, CC_CRYPTO_CIPHER::AES_128, nullptr, 16, nullptr, 0, ciphertext, &ctLen);
    EXPECT_NE(ret, RT_ERROR_NONE);

    ret = crypto.Encrypt(deviceId, CC_CRYPTO_CIPHER::AES_128, plaintext, 16, nullptr, 0, nullptr, &ctLen);
    EXPECT_NE(ret, RT_ERROR_NONE);

    ret = crypto.Encrypt(deviceId, CC_CRYPTO_CIPHER::AES_128, plaintext, 16, nullptr, 0, ciphertext, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

TEST_F(CCManagerTest, Crypto_EncryptDecrypt_RoundTrip)
{
    CCrypto crypto;
    uint32_t deviceId = 0;

    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));

    crypto.InitKey(deviceId);

    uint8_t plaintext[32] = {1,  2,  3,  4,  5,  6,  7,  8,  9,  10, 11, 12, 13, 14, 15, 16,
                             17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32};
    uint8_t ciphertext[256] = {0};
    size_t ctLen = sizeof(ciphertext);

    rtError_t ret = crypto.Encrypt(
        deviceId, CC_CRYPTO_CIPHER::AES_128, plaintext, sizeof(plaintext), nullptr, 0, ciphertext, &ctLen);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    // 真实实现输出 84B AiccCiphertextHeader + 密文（密文长度 == 明文长度）
    EXPECT_EQ(ctLen, sizeof(AiccCiphertextHeader) + sizeof(plaintext));

    uint8_t decrypted[32] = {0};
    size_t ptLen = sizeof(decrypted);
    ret = crypto.Decrypt(deviceId, CC_CRYPTO_CIPHER::AES_128, ciphertext, ctLen, nullptr, 0, decrypted, &ptLen);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(ptLen, sizeof(plaintext));
    EXPECT_EQ(memcmp(plaintext, decrypted, sizeof(plaintext)), 0);
}

TEST_F(CCManagerTest, Crypto_GetDeviceKeyAddr_Basic)
{
    CCrypto crypto;
    uint64_t encryptAddr = 0U;
    uint64_t decryptAddr = 0U;

    // ① 出参为空/密钥未初始化：拒绝
    EXPECT_EQ(crypto.GetDeviceKeyAddr(CC_CRYPTO_DIRECTION::ENCRYPT, nullptr), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(crypto.GetDeviceKeyAddr(CC_CRYPTO_DIRECTION::ENCRYPT, &encryptAddr), RT_ERROR_CC_KEY_NOT_INITIALIZED);

    // ② 初始化后：ENCRYPT/DECRYPT 各指向设备密钥区的一段，两者相差一个 keyLen
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    ASSERT_EQ(crypto.InitKey(0), RT_ERROR_NONE);
    ASSERT_EQ(crypto.GetDeviceKeyAddr(CC_CRYPTO_DIRECTION::ENCRYPT, &encryptAddr), RT_ERROR_NONE);
    ASSERT_EQ(crypto.GetDeviceKeyAddr(CC_CRYPTO_DIRECTION::DECRYPT, &decryptAddr), RT_ERROR_NONE);
    EXPECT_NE(encryptAddr, 0U);
    EXPECT_EQ(encryptAddr, decryptAddr + AICC_KEY_SIZE);
}

TEST_F(CCManagerTest, Crypto_Destructor_FreesKeyRegionWithBoundDevId)
{
    // 析构路径（未显式 ReleaseKey）：设备密钥区必须按 InitKey 绑定的 deviceId 释放，不能用 0 兜底
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    Driver* const realDriver = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    ASSERT_NE(realDriver, (Driver*)nullptr);
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemFree).stubs().will(invoke(DevMemFreeStub));

    const uint32_t bindDevId = 3U; // 刻意非 0：用 0 兜底的实现会在这里暴露
    {
        CCrypto crypto;
        ASSERT_EQ(crypto.InitKey(bindDevId), RT_ERROR_NONE);
    } // 不调 ReleaseKey，直接析构
    EXPECT_EQ(gLastDevMemFreeDevId, bindDevId);
}

TEST_F(CCManagerTest, CCDevMallocWithCfg_AlignsSizeTo32B)
{
    // devMallocWithCfg 回调：分配尺寸按 32B 对齐后下发驱动（与 CCDevMalloc 同口径）
    Driver* const realDriver = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    ASSERT_NE(realDriver, (Driver*)nullptr);
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemAllocWithFlag).stubs().will(invoke(DevMemAllocStub));
    void* ptr = nullptr;
    gLastDevMemAllocSize = 0U;
    ASSERT_EQ(CCManager::CCDevMallocWithCfg(&ptr, 100U, RT_MEMORY_HBM, 0U, 0U), RT_ERROR_NONE);
    EXPECT_EQ(gLastDevMemAllocSize, 128U);

    ASSERT_EQ(CCManager::CCDevMallocWithCfg(&ptr, 32U, RT_MEMORY_HBM, 0U, 0U), RT_ERROR_NONE);
    EXPECT_EQ(gLastDevMemAllocSize, 32U);
}

TEST_F(CCManagerTest, Crypto_BuildLoadKeyParam_NullParam)
{
    CCrypto crypto;
    EXPECT_EQ(crypto.BuildLoadKeyParam(nullptr), RT_ERROR_INVALID_VALUE);
}

TEST_F(CCManagerTest, Crypto_BuildLoadKeyParam_UninitializedKey)
{
    CCrypto crypto;
    CCLoadKeyKernelParam param{};
    EXPECT_EQ(crypto.BuildLoadKeyParam(&param), RT_ERROR_CC_KEY_NOT_INITIALIZED);
}

TEST_F(CCManagerTest, Crypto_BuildLoadKeyParam_SlotLayout)
{
    // 槽位口径：CTR 两方向都用 1 号槽（单密钥，部署只灌 1 号槽）；GCM 双向 1/2 号槽。
    // 与 master 的差异是有意为之：master 对 CTR 也填 2 号槽，真机读槽会失败。
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    MOCKER(GetKeyFromSlot).stubs().will(returnValue(0));

    CCrypto cryptoGcm(CC_CRYPTO_ALG_TYPE::GCM);
    ASSERT_EQ(cryptoGcm.InitKey(0), RT_ERROR_NONE);
    CCLoadKeyKernelParam gcmParam{};
    ASSERT_EQ(cryptoGcm.BuildLoadKeyParam(&gcmParam), RT_ERROR_NONE);
    EXPECT_EQ(gcmParam.h2dSlotId, 1U);
    EXPECT_EQ(gcmParam.d2hSlotId, 2U);
    EXPECT_EQ(gcmParam.keyLen, AICC_KEY_SIZE);
    EXPECT_NE(gcmParam.keyAddr, 0U);

    CCrypto cryptoCtr(CC_CRYPTO_ALG_TYPE::CTR);
    ASSERT_EQ(cryptoCtr.InitKey(0), RT_ERROR_NONE);
    CCLoadKeyKernelParam ctrParam{};
    ASSERT_EQ(cryptoCtr.BuildLoadKeyParam(&ctrParam), RT_ERROR_NONE);
    EXPECT_EQ(ctrParam.h2dSlotId, 1U);
    EXPECT_EQ(ctrParam.d2hSlotId, 1U);
}

// ============================================================================
// CCCryptoPlugin Factory / Switch Tests
// ============================================================================

TEST_F(CCManagerTest, Plugin_Factory_Basics)
{
    CCrypto crypto;
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));

    // ① 已登记模式可创建，路由元数据（algType/cipher/kernelName/descSize/轨分派）正确
    CCCryptoPlugin* gcm = nullptr;
    ASSERT_EQ(CreateCryptoPlugin(CC_CRYPTO_ALG_TYPE::GCM, &crypto, &gcm), RT_ERROR_NONE);
    ASSERT_NE(gcm, nullptr);
    EXPECT_EQ(gcm->AlgType(), CC_CRYPTO_ALG_TYPE::GCM);
    EXPECT_STREQ(gcm->KernelName(), "AiccCrypto");
    EXPECT_EQ(gcm->Cipher(), CC_CRYPTO_CIPHER::AES_128);
    EXPECT_EQ(gcm->SliceDescSize(), sizeof(AiccCryptoSliceDesc));
    EXPECT_EQ(gcm->SliceDescSize(), 32U);
    delete gcm;

    CCCryptoPlugin* ctr = nullptr;
    ASSERT_EQ(CreateCryptoPlugin(CC_CRYPTO_ALG_TYPE::CTR, &crypto, &ctr), RT_ERROR_NONE);
    ASSERT_NE(ctr, nullptr);
    EXPECT_EQ(ctr->AlgType(), CC_CRYPTO_ALG_TYPE::CTR);
    EXPECT_STREQ(ctr->KernelName(), "AiccKeystreamXor");
    EXPECT_EQ(ctr->Cipher(), CC_CRYPTO_CIPHER::AES_128);
    EXPECT_EQ(ctr->SliceDescSize(), sizeof(AiccKeystreamXorSliceDesc));
    EXPECT_EQ(ctr->SliceDescSize(), 40U);
    delete ctr;

    // ② 非法 algType / 空出参
    CCCryptoPlugin* invalid = reinterpret_cast<CCCryptoPlugin*>(static_cast<uintptr_t>(1U));
    EXPECT_EQ(CreateCryptoPlugin(static_cast<CC_CRYPTO_ALG_TYPE>(99U), &crypto, &invalid), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(invalid, nullptr);
    EXPECT_EQ(CreateCryptoPlugin(CC_CRYPTO_ALG_TYPE::GCM, &crypto, nullptr), RT_ERROR_INVALID_VALUE);
}

TEST_F(CCManagerTest, Plugin_Gcm_LaunchTransfer_UsesAiccCryptoParam)
{
    RETAIN_DEVICE(dev);
    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);

    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    CCrypto crypto;
    ASSERT_EQ(crypto.InitKey(dev->Id_()), RT_ERROR_NONE);
    CCGcmPlugin plugin(&crypto);

    ResetLaunchCapture();
    MOCKER(StreamLaunchCpuKernel).expects(once()).will(invoke(StreamLaunchCpuKernelCapture));

    CCMemcpyTask task{};
    task.kind = RT_MEMCPY_DEVICE_TO_HOST;
    task.totalSize = static_cast<size_t>(3U) * CC_PLAINTEXT_SLICE_SIZE;
    EXPECT_EQ(plugin.LaunchTransfer(stm, 0x1234ULL, task), RT_ERROR_NONE);
    EXPECT_STREQ(gLaunchKernelName, "AiccCrypto");
    ASSERT_EQ(gLaunchArgsSize, sizeof(AiccCryptoParam));
    const auto* const param = reinterpret_cast<const AiccCryptoParam*>(gLaunchArgs);
    EXPECT_EQ(param->taskQueueAddr, 0x1234ULL);
    EXPECT_EQ(param->mode, static_cast<uint32_t>(CC_CRYPTO_DIRECTION::ENCRYPT));
    EXPECT_EQ(param->algType, static_cast<uint32_t>(AICC_ALG_AES128_GCM));
    // totalSlices 位于 algType 后的 4B 对齐填充（偏移 20），参数整体仍为 32B；3 个明文分片 → 3
    EXPECT_EQ(param->totalSlices, 3U);
    EXPECT_EQ(param->keyLen, AICC_KEY_SIZE);

    (void)stm->TakeCCStreamResource();
    rtStreamDestroy(stmHandle);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Plugin_Ctr_LaunchTransfer_UsesAiccKeystreamXorParam)
{
    // CTR 路径直接构造 CCCtrPlugin，不依赖进程级生效模式（模式由内核节点决定、不可切换）
    RETAIN_DEVICE(dev);
    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);

    CCrypto crypto;
    CCCtrPlugin plugin(&crypto);

    ResetLaunchCapture();
    MOCKER(CcLaunchAivKsXor).expects(once()).will(invoke(CcLaunchAivKsXorCapture));

    CCMemcpyTask task{};
    task.kind = RT_MEMCPY_HOST_TO_DEVICE;
    task.totalSize = 64U;
    EXPECT_EQ(plugin.LaunchTransfer(stm, 0x5678ULL, task), RT_ERROR_NONE);
    // CTR keystream 只下发纯 XOR 算子，参数为 AiccKeystreamXorParam（逐片密钥流地址随 desc 下发，入参不带池基址）
    EXPECT_STREQ(gLaunchKernelName, "AiccKeystreamXor");
    EXPECT_EQ(gLaunchAiccKeystreamXorParam.taskQueueAddr, 0x5678ULL);
    EXPECT_EQ(gLaunchAiccKeystreamXorParam.mode, static_cast<uint32_t>(CC_CRYPTO_DIRECTION::DECRYPT));
    // 总分片数与 CCWorker::SetupTask 同口径：64B 单分片
    EXPECT_EQ(gLaunchAiccKeystreamXorParam.totalSlices, 1U);
    EXPECT_EQ(gLaunchAiccKeystreamXorParam.reserved, 64U);

    (void)stm->TakeCCStreamResource();
    rtStreamDestroy(stmHandle);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Plugin_LaunchDeviceKernel_LoadKey_UsesBuiltinAicpuKernel)
{
    // AiccLoadKey 走 AICPU 调度器侧内建算子（StreamLaunchCpuKernel），不经自研 AIV 通道；
    // 参数 16B 与 master ABI 同构
    RETAIN_DEVICE(dev);
    Stream* const stm = dev->GetCtrlSQStream(nullptr);
    ASSERT_NE(stm, (Stream*)nullptr);

    CCLoadKeyKernelParam param{};
    param.h2dSlotId = 1U;
    param.d2hSlotId = 2U;
    param.keyLen = AICC_KEY_SIZE;
    param.keyAddr = 0x1000ULL;

    ResetLaunchCapture();
    MOCKER(StreamLaunchCpuKernel).expects(once()).will(invoke(StreamLaunchCpuKernelCapture));
    MOCKER(CcLaunchAivKsXor).expects(never());
    EXPECT_EQ(CCCryptoPlugin::LaunchDeviceKernel(stm, "AiccLoadKey", &param, sizeof(param)), RT_ERROR_NONE);
    EXPECT_STREQ(gLaunchKernelName, "AiccLoadKey");
    ASSERT_EQ(gLaunchArgsSize, sizeof(CCLoadKeyKernelParam));
    const auto* const launched = reinterpret_cast<const CCLoadKeyKernelParam*>(gLaunchArgs);
    EXPECT_EQ(launched->keyAddr, 0x1000ULL);
    EXPECT_EQ(launched->keyLen, AICC_KEY_SIZE);

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Plugin_LaunchDeviceKernel_KsXor_BadArgsSize)
{
    RETAIN_DEVICE(dev);
    Stream* const stm = dev->GetCtrlSQStream(nullptr);
    ASSERT_NE(stm, (Stream*)nullptr);

    AiccKeystreamXorParam param{};
    MOCKER(CcLaunchAivKsXor).expects(never());
    MOCKER(StreamLaunchCpuKernel).expects(never());
    EXPECT_EQ(
        CCCryptoPlugin::LaunchDeviceKernel(stm, "AiccKeystreamXor", &param, static_cast<uint32_t>(sizeof(param) - 1U)),
        RT_ERROR_INVALID_VALUE);

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Plugin_LaunchDeviceKernel_KsXor_NoThreadLocalBypass)
{
    // KsXor 直调分支：CC 设备核下发内部的拷贝不再由 thread_local 防递归旁路兜底。
    // 下发期间调用 CC 拷贝入口必须按正常裁决执行（空指针 → RT_ERROR_INVALID_VALUE），
    // 而不是被旁路拦成 RT_ERROR_CONTINUE_EXECUTE；若有人重新引入旁路，本用例会失败。
    RETAIN_DEVICE(dev);
    Stream* const stm = dev->GetCtrlSQStream(nullptr);
    ASSERT_NE(stm, (Stream*)nullptr);

    AiccKeystreamXorParam param{};
    param.taskQueueAddr = 0x2000ULL;
    param.mode = static_cast<uint32_t>(CC_CRYPTO_DIRECTION::ENCRYPT);
    param.totalSlices = 2U;

    ResetLaunchCapture();
    gNestedMemcpyRet = RT_ERROR_CONTINUE_EXECUTE;
    MOCKER(StreamLaunchCpuKernel).expects(never());
    MOCKER(CcLaunchAivKsXor).expects(once()).will(invoke(CcLaunchAivKsXorReentryProbe));
    EXPECT_EQ(CCCryptoPlugin::LaunchDeviceKernel(stm, "AiccKeystreamXor", &param, sizeof(param)), RT_ERROR_NONE);
    EXPECT_NE(gNestedMemcpyRet, RT_ERROR_CONTINUE_EXECUTE);
    EXPECT_EQ(gNestedMemcpyRet, RT_ERROR_INVALID_VALUE);

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Plugin_ActiveAlg)
{
    // ① 生效模式由内核节点 mem_encrypt_alg 决定（进程内首次读取后缓存）
    const CC_CRYPTO_ALG_TYPE activeAlg = GetActiveCryptoAlg();
    EXPECT_EQ(GetActiveCryptoAlg(), activeAlg);

    // ② 插件工厂按生效模式创建
    CCrypto crypto;
    CCCryptoPlugin* plugin = nullptr;
    ASSERT_EQ(CreateCryptoPlugin(activeAlg, &crypto, &plugin), RT_ERROR_NONE);
    ASSERT_NE(plugin, nullptr);
    EXPECT_EQ(plugin->AlgType(), activeAlg);
    delete plugin;
}

TEST_F(CCManagerTest, CcSelectAivBlockDim_Cases)
{
    // 每核 256KiB → 取 2 的幂 → 钳到 [1, maxDim]；边界与 AIV 下发实现一致。
    constexpr uint32_t kUnit = CC_AIV_DIM_UNIT_BYTES;
    EXPECT_EQ(CcSelectAivBlockDim(0U, AICC_MAX_BLOCK_DIM), AICC_MAX_BLOCK_DIM); // 旧 host 未填 → 上限
    EXPECT_EQ(CcSelectAivBlockDim(8U, AICC_MAX_BLOCK_DIM), 1U);
    EXPECT_EQ(CcSelectAivBlockDim(kUnit, AICC_MAX_BLOCK_DIM), 1U);
    EXPECT_EQ(CcSelectAivBlockDim(kUnit + 1U, AICC_MAX_BLOCK_DIM), 2U);
    EXPECT_EQ(CcSelectAivBlockDim(kUnit * 3U, AICC_MAX_BLOCK_DIM), 4U);                 // 768KiB
    EXPECT_EQ(CcSelectAivBlockDim(kUnit * 4U, AICC_MAX_BLOCK_DIM), 4U);                 // 1MiB
    EXPECT_EQ(CcSelectAivBlockDim(kUnit * 4U + 1U, AICC_MAX_BLOCK_DIM), AICC_MAX_BLOCK_DIM);
    EXPECT_EQ(CcSelectAivBlockDim(kUnit * 8U, AICC_MAX_BLOCK_DIM), AICC_MAX_BLOCK_DIM); // 2MiB
    EXPECT_EQ(CcSelectAivBlockDim(kUnit * 8U, 4U), 4U);                                 // 钳到 maxDim
    EXPECT_EQ(CcSelectAivBlockDim(8U, 0U), 1U);                                         // maxDim=0 至少一核
    EXPECT_LE(AICC_MAX_BLOCK_DIM, 8U); // FFTS flag14 同步粒度为一组 8 个 AIV

    // 性质扫描：结果恒为 2 的幂、落在 [1, 上限]
    for (uint32_t size = 1U; size <= 4U * 1024U * 1024U; size *= 2U) {
        const uint32_t dim = CcSelectAivBlockDim(size, AICC_MAX_BLOCK_DIM);
        EXPECT_GE(dim, 1U);
        EXPECT_LE(dim, AICC_MAX_BLOCK_DIM);
        EXPECT_EQ((dim & (dim - 1U)), 0U);
    }
}

TEST_F(CCManagerTest, CcSysfs_UnreadableNodeFallsBackToGcm)
{
    // 选「原生路径」时脚本不设 RT_CC_SYSFS_CVM_ROOT，runtime 读系统默认挂载点；读不到就必须按 AES_GCM 兜底。
    // 这里锁定输入侧口径：节点不可读时 ReadCcEncryptMode 返回 false（GetActiveCryptoAlg 据此落 GCM）。
    const ScopeGuard restore([]() { (void)unsetenv("RT_CC_SYSFS_CVM_ROOT"); });
    ASSERT_EQ(setenv("RT_CC_SYSFS_CVM_ROOT", "/nonexistent/cc-sysfs-ut", 1), 0);
    std::string mode = "AES_CTR"; // 预置非空，排除“本来就没写”造成的假象
    EXPECT_FALSE(ReadCcEncryptMode(mode));
    EXPECT_EQ(mode, "AES_CTR");   // 读失败不改写输出参数

    // 默认挂载点在 UT 环境里同样不可读 → 仍 false；两种入口都走 GCM 兜底
    (void)unsetenv("RT_CC_SYSFS_CVM_ROOT");
    EXPECT_FALSE(ReadCcEncryptMode(mode));
}

TEST_F(CCManagerTest, Plugin_ActiveCipher_Switch)
{
    const ScopeGuard restoreCipher([]() { (void)SetActiveCryptoCipher(CC_CRYPTO_CIPHER::AES_128); });
    ASSERT_EQ(SetActiveCryptoCipher(CC_CRYPTO_CIPHER::AES_128), RT_ERROR_NONE);

    // ① 缺省 AES：插件按缺省算法创建
    CCrypto crypto;
    CCCryptoPlugin* plugin = nullptr;
    ASSERT_EQ(CreateCryptoPlugin(CC_CRYPTO_ALG_TYPE::GCM, &crypto, &plugin), RT_ERROR_NONE);
    ASSERT_NE(plugin, nullptr);
    EXPECT_EQ(plugin->Cipher(), CC_CRYPTO_CIPHER::AES_128);

    // ② 切到未实现的 SM4：切换本身允许（插件持原子引用立即生效），加解密取原语时才拒绝
    EXPECT_EQ(SetActiveCryptoCipher(CC_CRYPTO_CIPHER::SM4), RT_ERROR_NONE);
    EXPECT_EQ(GetActiveCryptoCipher(), CC_CRYPTO_CIPHER::SM4);
    EXPECT_EQ(plugin->Cipher(), CC_CRYPTO_CIPHER::SM4);

    // ③ 插件持原子引用：生效值变化后无须重建插件即读到新值
    ASSERT_EQ(SetActiveCryptoCipher(CC_CRYPTO_CIPHER::AES_128), RT_ERROR_NONE);
    EXPECT_EQ(plugin->Cipher(), CC_CRYPTO_CIPHER::AES_128);
    delete plugin;

    // ④ 非法值拒绝
    EXPECT_EQ(SetActiveCryptoCipher(static_cast<CC_CRYPTO_CIPHER>(99U)), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(GetActiveCryptoCipher(), CC_CRYPTO_CIPHER::AES_128);
}
TEST_F(CCManagerTest, Worker_HookFlow_H2D_And_D2H_RoundTrip)
{
    RETAIN_DEVICE(dev);
    Driver* realDriver = dev->Driver_();

    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());

    CCrypto crypto(CC_CRYPTO_ALG_TYPE::CTR);
    MOCKER(GetKeyFromSlot).stubs().will(returnValue(0)); // CTR 复用 H2D 的 1 号槽
    ASSERT_EQ(crypto.InitKey(0), RT_ERROR_NONE);

    // 注入伪造的密钥流池：不依赖真实设备，密钥流固定为全 1，
    // 段大小覆盖本用例的 100 字节分片。
    KeystreamOps ksOps;
    ksOps.allocSegment = [](KeystreamSegment& segment) {
        segment.hostAddr = static_cast<uint8_t*>(malloc(static_cast<size_t>(segment.segmentSize)));
        segment.deviceAddr = reinterpret_cast<uint8_t*>(static_cast<uintptr_t>(0x3FF0000ULL));
        return segment.hostAddr != nullptr;
    };
    ksOps.freeSegment = [](KeystreamSegment& segment) {
        free(segment.hostAddr);
        segment.hostAddr = nullptr;
        segment.deviceAddr = nullptr;
    };
    ksOps.initContext = [](KeystreamContext& context) {
        for (auto& fillStream : context.fillStreams) {
            fillStream = reinterpret_cast<Stream*>(static_cast<uintptr_t>(0x1000U));
        }
        return true;
    };
    ksOps.releaseContext = [](KeystreamContext&) {};
    ksOps.fillSegment = [](KeystreamSegment& segment, Stream*, const uint8_t*) {
        (void)memset_s(
            segment.hostAddr, static_cast<size_t>(segment.segmentSize), 0xFF, static_cast<size_t>(segment.segmentSize));
        return RT_ERROR_NONE;
    };
    crypto.keystreamPool_ = std::make_shared<KeystreamManager>(0, &ksOps);
    KeystreamKey ksKey{};
    ksKey.keyAddr = 0x3FF0000ULL;
    ksKey.keyLen = AICC_KEY_SIZE;
    ASSERT_EQ(crypto.keystreamPool_->Init({{256, 1024, 1}}, ksKey), RT_ERROR_NONE);
    crypto.deviceId_ = 0U;
    const ScopeGuard resetKsPool([&crypto]() { crypto.keystreamPool_.reset(); });

    StubPcieAndFreeCounted(realDriver);

    // 回调轨分片环按 CTR desc（40B）创建
    CCStreamResManage streamRes;
    ASSERT_EQ(streamRes.Init(dev, sizeof(AiccKeystreamXorSliceDesc)), RT_ERROR_NONE);
    stm->SetCCStreamResource(&streamRes);

    CCCtrPlugin ctrPlugin(&crypto);

    uint8_t deviceBufA[1024] = {0};
    uint8_t deviceBufB[1024] = {0};
    uint8_t hostBuf[1024] = {0};
    uint8_t src[100] = {0};
    uint8_t dst[100] = {0};
    for (uint32_t i = 0U; i < sizeof(src); ++i) {
        src[i] = static_cast<uint8_t>(i);
    }

    CCWorker worker;
    worker.device_ = dev;
    worker.plugin_ = &ctrPlugin;
    worker.maxSliceSize_ = 1024U;
    worker.workerId_ = 0U;
    worker.deadlineMs_ = ~0ULL;
    worker.deviceBuffers_[0] = deviceBufA;
    worker.deviceBuffers_[1] = deviceBufB;
    worker.hostCryptoBuf_ = hostBuf;

    CCMemcpyTask task = {};
    task.src = src;
    task.dst = dst;
    task.totalSize = sizeof(src);
    task.streamId = streamId;

    // ① H2D 回调轨：mock 全 1 密钥流 → 设备 buffer 中为明文按位取反
    task.kind = RT_MEMCPY_HOST_TO_DEVICE;
    std::atomic<bool> stop{false};
    std::atomic<uint32_t> consumedCount{0U};
    std::thread consumer(
        &AicpuSimulator::RunH2DConsumer, streamRes.BarQueue(), 1U, std::cref(stop), std::ref(consumedCount));
    const ScopeGuard stopConsumer([&stop, &consumer]() {
        stop.store(true);
        if (consumer.joinable()) {
            consumer.join();
        }
    });
    EXPECT_EQ(worker.ProcessTask(task), RT_ERROR_NONE);
    EXPECT_EQ(consumedCount.load(), 1U);
    for (uint32_t i = 0U; i < sizeof(src); ++i) {
        EXPECT_EQ(deviceBufA[i], static_cast<uint8_t>(~src[i]));
    }
    // desc 按 CTR 40B 发布：ciphertextLen = 明文长度（无密文头），keystreamAddr 为 mock 桩地址（0x3ff0000 起）
    const AiccKeystreamXorSliceDesc* const desc0 =
        reinterpret_cast<const AiccKeystreamXorSliceDesc*>(streamRes.BarQueue()->taskDescList);
    EXPECT_EQ(desc0->ciphertextLen, sizeof(src));
    EXPECT_EQ(desc0->plaintextLen, sizeof(src));
    EXPECT_NE(desc0->keystreamAddr, 0U);
    EXPECT_GE(desc0->keystreamAddr, 0x3FF0000ULL);
    // 任务收尾：门铃状态回到 WAITING（MEM_WAIT 不再放行）
    EXPECT_EQ(streamRes.BarQueue()->hostStatus, TASK_QUEUE_STATUS_WAITING);

    // ② D2H 回调轨：模拟设备按同段密钥流 XOR 加密（mock 全 1 → 写入按位取反的明文）
    streamRes.Reset();
    task.kind = RT_MEMCPY_DEVICE_TO_HOST;
    for (uint32_t i = 0U; i < sizeof(src); ++i) {
        src[i] = static_cast<uint8_t>(0xA5U ^ i);
    }
    (void)memset_s(dst, sizeof(dst), 0, sizeof(dst));
    std::thread d2hConsumer([&]() {
        while (!stop.load() && (streamRes.BarQueue()->head == streamRes.BarQueue()->tail)) {
            std::this_thread::sleep_for(std::chrono::milliseconds(1));
        }
        if (stop.load()) {
            return;
        }
        for (uint32_t i = 0U; i < sizeof(src); ++i) {
            deviceBufA[i] = static_cast<uint8_t>(~src[i]);
        }
        streamRes.BarQueue()->tail = (streamRes.BarQueue()->tail + 1U) % streamRes.BarQueue()->depth;
        streamRes.BarQueue()->complete = 1U;
    });
    const ScopeGuard stopD2h([&stop, &d2hConsumer]() {
        stop.store(true);
        if (d2hConsumer.joinable()) {
            d2hConsumer.join();
        }
    });
    EXPECT_EQ(worker.ProcessTask(task), RT_ERROR_NONE);
    if (d2hConsumer.joinable()) {
        d2hConsumer.join();
    }
    // host XOR 解密还原
    for (uint32_t i = 0U; i < sizeof(src); ++i) {
        EXPECT_EQ(dst[i], src[i]);
    }
    EXPECT_EQ(streamRes.BarQueue()->hostStatus, TASK_QUEUE_STATUS_WAITING);

    worker.device_ = nullptr;
    (void)stm->TakeCCStreamResource();
    rtStreamDestroy(stmHandle);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

static const void* GcmCipherFnForUt() { return OpenSSLLoader::Instance().Api.Aes128Gcm(); }

TEST_F(CCManagerTest, Crypto_Cipher_Routing)
{
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));

    // ① AES（已注册）：round-trip 正常
    CCrypto crypto;
    ASSERT_EQ(crypto.InitKey(0), RT_ERROR_NONE);
    uint8_t pt[16] = {1};
    uint8_t ct[128] = {0};
    size_t ctLen = sizeof(ct);
    ASSERT_EQ(crypto.Encrypt(0, CC_CRYPTO_CIPHER::AES_128, pt, sizeof(pt), nullptr, 0, ct, &ctLen), RT_ERROR_NONE);

    // ② SM4（注册表槽位留空）：初始化密钥正常，加解密返回 FEATURE_NOT_SUPPORT
    EXPECT_EQ(
        crypto.Encrypt(0, CC_CRYPTO_CIPHER::SM4, pt, sizeof(pt), nullptr, 0, ct, &ctLen), RT_ERROR_FEATURE_NOT_SUPPORT);
    uint8_t out[16] = {0};
    size_t outLen = sizeof(out);
    EXPECT_EQ(
        crypto.Decrypt(0, CC_CRYPTO_CIPHER::SM4, ct, ctLen, nullptr, 0, out, &outLen), RT_ERROR_FEATURE_NOT_SUPPORT);

    // ③ 注册表接口：非法参数拒绝（非法下标/空回调/ivSize<=4/tagSize=0）
    EXPECT_EQ(
        RegisterCryptoAlg(static_cast<CC_CRYPTO_CIPHER>(99U), &GcmCipherFnForUt, 12U, 16U), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(RegisterCryptoAlg(CC_CRYPTO_CIPHER::AES_128, nullptr, 12U, 16U), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(RegisterCryptoAlg(CC_CRYPTO_CIPHER::AES_128, &GcmCipherFnForUt, 4U, 16U), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(RegisterCryptoAlg(CC_CRYPTO_CIPHER::AES_128, &GcmCipherFnForUt, 12U, 0U), RT_ERROR_INVALID_VALUE);
}

// ============================================================================
// CCStreamResManage Tests
// ============================================================================

TEST_F(CCManagerTest, StreamResManage_Init_Destroy)
{
    RETAIN_DEVICE(dev);

    CCStreamResManage resource;
    StubStreamResDriver(dev->Driver_(), true);

    rtError_t ret = resource.Init(dev, sizeof(AiccCryptoSliceDesc));
    EXPECT_EQ(ret, RT_ERROR_NONE);

    // Init 应创建 BarTaskQueue 分片环：depth/taskDescSize 就绪、状态 WORKING、任务槽清零。
    BarTaskQueue* queue = resource.BarQueue();
    EXPECT_NE(queue, nullptr);
    EXPECT_EQ(queue->depth, CC_SLICE_DESC_SLOT_NUM);
    EXPECT_EQ(queue->taskDescSize, sizeof(AiccCryptoSliceDesc));
    EXPECT_EQ(queue->hostStatus, TASK_QUEUE_STATUS_WAITING);
    EXPECT_EQ(queue->deviceStatus, TASK_QUEUE_STATUS_WAITING);
    const AiccCryptoSliceDesc* const sliceDesc = reinterpret_cast<const AiccCryptoSliceDesc*>(queue->taskDescList);
    for (uint32_t i = 0U; i < CC_SLICE_DESC_SLOT_NUM; ++i) {
        EXPECT_EQ(sliceDesc[i].ciphertextAddr, 0U);
    }
    // 设备侧地址查询成功（stub 下 host 映射地址即设备地址）
    EXPECT_NE(resource.DeviceQueueAddr(), 0U);
    EXPECT_EQ(resource.DeviceQueueAddr(), PtrToValue(resource.BarQueue()));

    // Destroy 幂等：两次调用设备内存只释放一次，随后查询返回空
    gDevMemFreeCount = 0U;
    resource.Destroy();
    resource.Destroy();
    EXPECT_EQ(gDevMemFreeCount, 1U);
    EXPECT_EQ(resource.BarQueue(), nullptr);
    EXPECT_EQ(resource.DeviceQueueAddr(), 0U);

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, StreamResManage_Reset)
{
    RETAIN_DEVICE(dev);

    CCStreamResManage resource;

    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAllocWithBackupFlag).stubs().will(invoke(DevMemAllocEntryStub));
    StubPcieAndFree(dev->Driver_());

    ASSERT_EQ(resource.Init(dev, sizeof(AiccCryptoSliceDesc)), RT_ERROR_NONE);

    BarTaskQueue* queue = resource.BarQueue();
    ASSERT_NE(queue, nullptr);
    queue->head = 2U;
    queue->tail = 1U;
    queue->complete = 5U;
    queue->hostStatus = TASK_QUEUE_STATUS_TERMINATED;

    resource.Reset();

    EXPECT_EQ(queue->head, 0U);
    EXPECT_EQ(queue->tail, 0U);
    EXPECT_EQ(queue->complete, 0U);
    EXPECT_EQ(queue->depth, CC_SLICE_DESC_SLOT_NUM);
    // 当前 ABI 语义：Reset 无条件把双侧状态复位为 WAITING，调用方必须在此之前处理完
    // Host/Device 两侧的正常/异常 TERMINATED 信号（见 task_queue_abi.h 状态机说明）。
    EXPECT_EQ(queue->hostStatus, TASK_QUEUE_STATUS_WAITING);
    EXPECT_EQ(queue->deviceStatus, TASK_QUEUE_STATUS_WAITING);
    EXPECT_EQ(queue->deviceErrCode, 0U);

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

// BeginBarTaskRound 是 Host 侧的「回合准入」：按 task_queue_abi.h 的状态机收口上一轮并复位控制头。
// 覆盖三个分支：参数校验、外部中断（不掩盖终止标记）、上一轮正常终态（Reset 收回 WAITING），
// 以及公开的 IsBarTaskQueueTerminated 判据。
TEST_F(CCManagerTest, TaskQueue_BeginRound_StateMachine)
{
    RETAIN_DEVICE(dev);

    CCStreamResManage resource;

    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAllocWithBackupFlag).stubs().will(invoke(DevMemAllocEntryStub));
    StubPcieAndFree(dev->Driver_());

    ASSERT_EQ(resource.Init(dev, sizeof(AiccCryptoSliceDesc)), RT_ERROR_NONE);
    BarTaskQueue* const queue = resource.BarQueue();
    ASSERT_NE(queue, nullptr);

    // ① 参数校验
    bool proceed = true;
    EXPECT_EQ(BeginBarTaskRound(nullptr, &proceed), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(BeginBarTaskRound(queue, nullptr), RT_ERROR_INVALID_VALUE);

    // ② Host 侧已被外部中断置 TERMINATED：不掩盖终止信号，本轮不下发，控制头保持原样
    queue->head = 2U;
    queue->tail = 1U;
    queue->complete = 5U;
    queue->hostStatus = TASK_QUEUE_STATUS_TERMINATED;
    queue->deviceStatus = TASK_QUEUE_STATUS_WAITING;
    proceed = true;
    EXPECT_EQ(BeginBarTaskRound(queue, &proceed), RT_ERROR_NONE);
    EXPECT_FALSE(proceed);
    EXPECT_EQ(queue->hostStatus, TASK_QUEUE_STATUS_TERMINATED);
    EXPECT_EQ(queue->complete, 5U);

    // ③ 上一轮设备正常终态（deviceStatus=TERMINATED）：Reset 收口，允许开新一轮
    queue->hostStatus = TASK_QUEUE_STATUS_WAITING;
    queue->deviceStatus = TASK_QUEUE_STATUS_TERMINATED;
    queue->head = 1U;
    queue->tail = 2U;
    queue->complete = 3U;
    queue->deviceErrCode = 7U;
    proceed = false;
    EXPECT_EQ(BeginBarTaskRound(queue, &proceed), RT_ERROR_NONE);
    EXPECT_TRUE(proceed);
    EXPECT_EQ(queue->hostStatus, TASK_QUEUE_STATUS_WAITING);
    EXPECT_EQ(queue->deviceStatus, TASK_QUEUE_STATUS_WAITING);
    EXPECT_EQ(queue->head, 0U);
    EXPECT_EQ(queue->tail, 0U);
    EXPECT_EQ(queue->complete, 0U);
    EXPECT_EQ(queue->deviceErrCode, 0U);

    // ④ IsBarTaskQueueTerminated：任一侧 TERMINATED 即终止，空指针视为不可用
    EXPECT_FALSE(IsBarTaskQueueTerminated(queue));
    queue->deviceStatus = TASK_QUEUE_STATUS_TERMINATED;
    EXPECT_TRUE(IsBarTaskQueueTerminated(queue));
    EXPECT_TRUE(IsBarTaskQueueTerminated(nullptr));

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, StreamResManage_Init_ErrorPaths)
{
    RETAIN_DEVICE(dev);
    Driver* realDriver = dev->Driver_();

    MOCKER_CPP_VIRTUAL(dev, &Device::Driver_).stubs().will(invoke(FakeDeviceDriverStub));
    StubStreamResDriver(realDriver, true);

    // ⓪ 空 / 申请失败入参
    {
        CCStreamResManage nullRes;
        EXPECT_EQ(nullRes.Init(nullptr, sizeof(AiccCryptoSliceDesc)), RT_ERROR_DEVICE_NULL);
    }

    // ① device->Driver_() 为空
    gReturnNullDriver = true;
    {
        CCStreamResManage resource;
        EXPECT_EQ(resource.Init(dev, sizeof(AiccCryptoSliceDesc)), RT_ERROR_DRV_NULL);
    }

    // ② PCIe BAR 寄存器映射失败：初始化失败且已申请的设备内存被回滚释放
    gReturnNullDriver = false;
    gPcieRegFail = true;
    gDevMemFreeCount = 0U;
    {
        CCStreamResManage resource;
        EXPECT_NE(resource.Init(dev, sizeof(AiccCryptoSliceDesc)), RT_ERROR_NONE);
        EXPECT_EQ(gDevMemFreeCount, 1U);
    }

    // ③ 设备内存申请失败（走 DevMemAllocStub 的失败开关；mockcpp 先注册先匹配，重注册桩不生效）
    gPcieRegFail = false;
    gDevMemAllocReturnFail = true;
    {
        CCStreamResManage resource;
        EXPECT_NE(resource.Init(dev, sizeof(AiccCryptoSliceDesc)), RT_ERROR_NONE);
    }
    gDevMemAllocReturnFail = false;

    // ④ 映射地址为空：回退使用设备地址，Init 成功
    gPcieRegFail = false;
    gPcieMappedNull = true;
    {
        CCStreamResManage resource;
        EXPECT_EQ(resource.Init(dev, sizeof(AiccCryptoSliceDesc)), RT_ERROR_NONE);
        EXPECT_NE(resource.DeviceQueueAddr(), 0U);
        EXPECT_NE(resource.BarQueue(), nullptr);
        resource.Destroy();
    }

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

// ============================================================================
// CCWorker Tests
// ============================================================================

TEST_F(CCManagerTest, Worker_Init_NullDevice)
{
    CCWorker worker;
    CCMemcpyTaskQueue queue;
    CCrypto crypto;

    CCGcmPlugin plugin(&crypto);
    rtError_t ret = worker.Init(0, 1024, &queue, nullptr, &plugin);
    EXPECT_EQ(ret, RT_ERROR_DEVICE_NULL);
}

TEST_F(CCManagerTest, Worker_Init_Destroy)
{
    RETAIN_DEVICE(dev);

    CCWorker worker;
    CCMemcpyTaskQueue queue;
    CCrypto crypto;

    StubWorkerHostDriver(dev->Driver_());

    CCGcmPlugin plugin(&crypto);
    rtError_t ret = worker.Init(0, 1024, &queue, dev, &plugin);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_NE(worker.GetHostCryptoBuf(), nullptr);

    queue.Shutdown();
    worker.Destroy();
    worker.Destroy();
    EXPECT_EQ(gHostDmaUnmapCount, 1U);
    EXPECT_EQ(gHostMemFreeCount, 1U);

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Worker_HostDmaUnavailable_FallbackToHostRegister)
{
    RETAIN_DEVICE(dev);
    Driver* const driver = dev->Driver_();
    // 老驱动没有 DMA map/unmap：Init 回退到 HostRegister，Destroy 在 unmap 不可用后转 HostUnregister。
    MOCKER_CPP_VIRTUAL(driver, &Driver::HostMemAlloc).stubs().will(invoke(HostMemAllocStub));
    MOCKER_CPP_VIRTUAL(driver, &Driver::HostDmaMap).stubs().will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    MOCKER_CPP_VIRTUAL(driver, &Driver::HostDmaUnmap).expects(once()).will(returnValue(RT_ERROR_FEATURE_NOT_SUPPORT));
    MOCKER_CPP_VIRTUAL(driver, &Driver::HostRegister).expects(once()).will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::HostUnregister).expects(once()).will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::HostMemFree).stubs().will(returnValue(RT_ERROR_NONE));

    CCWorker worker;
    CCMemcpyTaskQueue queue;
    CCrypto crypto;
    CCGcmPlugin plugin(&crypto);
    EXPECT_EQ(worker.Init(0, 1024, &queue, dev, &plugin), RT_ERROR_NONE);
    queue.Shutdown();
    worker.Destroy();
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Worker_Init_ErrorPaths)
{
    // ② 验证 HostDmaMap 失败必须报错回滚（正式行为；mock 开关只影响非 CVM 联调）
    RETAIN_DEVICE(dev);
    Driver* realDriver = dev->Driver_();

    // ① crypto 为空
    {
        CCWorker worker;
        CCMemcpyTaskQueue queue;
        EXPECT_EQ(worker.Init(0, 1024, &queue, dev, nullptr), RT_ERROR_INVALID_VALUE);
    }

    StubWorkerHostDriver(realDriver);
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemAllocWithBackupFlag).stubs().will(invoke(DevMemAllocEntryStub));

    // ② HostDmaMap 失败：hostCryptoBuf 已申请，需 HostMemFree 回滚
    {
        CCWorker worker;
        CCMemcpyTaskQueue queue;
        CCrypto crypto;
        CCGcmPlugin plugin(&crypto);
        gHostDmaMapFail = true;
        gHostMemFreeCount = 0U;
        EXPECT_NE(worker.Init(0, 1024, &queue, dev, &plugin), RT_ERROR_NONE);
        EXPECT_EQ(gHostDmaUnmapCount, 0U);
        EXPECT_EQ(gHostMemFreeCount, 1U);
    }

    // ③ Device Buffer 申请失败：HostDmaMap 已成功，需 HostDmaUnmap + HostMemFree 回滚
    {
        CCWorker worker;
        CCMemcpyTaskQueue queue;
        CCrypto crypto;
        CCGcmPlugin plugin(&crypto);
        gHostDmaMapFail = false;
        gDevMemAllocReturnFail = true;
        gHostDmaUnmapCount = 0U;
        gHostMemFreeCount = 0U;
        EXPECT_NE(worker.Init(0, 1024, &queue, dev, &plugin), RT_ERROR_NONE);
        EXPECT_EQ(gHostDmaUnmapCount, 1U);
        EXPECT_EQ(gHostMemFreeCount, 1U);
        gDevMemAllocReturnFail = false;
    }

    // ④ HostMemAlloc 失败：最早一步就失败，无资源需要回滚（gHostAllocFailAt 让第 1 次申请失败）
    {
        gHostAllocCount = 0U;
        gHostAllocFailAt = 1U;
        CCWorker worker;
        CCMemcpyTaskQueue queue;
        CCrypto crypto;
        CCGcmPlugin plugin(&crypto);
        gHostDmaUnmapCount = 0U;
        gHostMemFreeCount = 0U;
        EXPECT_NE(worker.Init(0, 1024, &queue, dev, &plugin), RT_ERROR_NONE);
        EXPECT_EQ(gHostDmaUnmapCount, 0U);
        EXPECT_EQ(gHostMemFreeCount, 0U);
        gHostAllocFailAt = 0U;
    }

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Worker_ShouldWorkerExit_Branches)
{
    RETAIN_DEVICE(dev);

    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());

    CCWorker worker;
    worker.device_ = dev;

    // ① cancelled_ 置位
    worker.cancelled_.store(true);
    EXPECT_TRUE(worker.ShouldWorkerExit(streamId));

    // ② deadline 已过期
    worker.cancelled_.store(false);
    worker.deadlineMs_ = 0U;
    EXPECT_TRUE(worker.ShouldWorkerExit(streamId));

    // ③ stream 未注册
    worker.deadlineMs_ = ~0ULL;
    EXPECT_TRUE(worker.ShouldWorkerExit(0xDEADU));

    // ④ stream 已注册但未挂载 CC 资源（强制销毁场景）
    EXPECT_TRUE(worker.ShouldWorkerExit(streamId));

    // ⑤ stream 已注册、资源已挂载、未取消未超时
    stm->SetCCStreamResource(reinterpret_cast<CCStreamResManage*>(static_cast<uint64_t>(1U)));
    EXPECT_FALSE(worker.ShouldWorkerExit(streamId));
    stm->SetCCStreamResource(nullptr);

    worker.device_ = nullptr;
    rtStreamDestroy(stmHandle);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Worker_SetupTask_Basics)
{
    RETAIN_DEVICE(dev);
    Driver* realDriver = dev->Driver_();

    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());

    CCrypto crypto;
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    crypto.InitKey(0);

    StubPcieAndFreeCounted(realDriver);

    CCWorker worker;
    worker.device_ = dev;
    CCGcmPlugin gcmPlugin(&crypto);
    worker.plugin_ = &gcmPlugin;
    worker.maxSliceSize_ = 1024U;
    worker.workerId_ = 0U;

    CCMemcpyTask task = {};
    std::shared_ptr<Stream> stream;
    CCStreamResManage* resource = nullptr;
    uint32_t sliceNum = 0U;

    // ① stream 未注册：任务丢弃
    task.streamId = 0xDEADU;
    EXPECT_EQ(worker.SetupTask(task, stream, resource, sliceNum), RT_ERROR_NONE);
    EXPECT_EQ(stream, nullptr);
    EXPECT_EQ(worker.ProcessTask(task), RT_ERROR_NONE);

    // ② 流存在但未挂 CC 资源
    task.streamId = streamId;
    EXPECT_EQ(worker.SetupTask(task, stream, resource, sliceNum), RT_ERROR_CC_WORKER_FAILED);

    // ③ 挂 CC 资源成功路径：sliceNum/deadline（环状态写入已移交 PushBarTask/Reset 协议）
    CCStreamResManage streamRes;
    ASSERT_EQ(streamRes.Init(dev, sizeof(AiccCryptoSliceDesc)), RT_ERROR_NONE);
    stm->SetCCStreamResource(&streamRes);

    task.totalSize = CC_PLAINTEXT_SLICE_SIZE * 2U + 1U;
    task.kind = RT_MEMCPY_HOST_TO_DEVICE;
    EXPECT_EQ(worker.SetupTask(task, stream, resource, sliceNum), RT_ERROR_NONE);
    EXPECT_EQ(resource, &streamRes);
    EXPECT_EQ(sliceNum, 3U);
    EXPECT_NE(resource->BarQueue(), nullptr);
    EXPECT_NE(worker.deadlineMs_, 0U);

    // 清理：先取回 CC 资源防止 Stream 析构产生泄漏
    (void)stm->TakeCCStreamResource();
    rtStreamDestroy(stmHandle);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Worker_ProcessH2DSlice_Success)
{
    RETAIN_DEVICE(dev);
    Driver* realDriver = dev->Driver_();

    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());

    CCrypto crypto;
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    crypto.InitKey(0);

    StubPcieAndFreeCounted(realDriver);

    CCStreamResManage streamRes;
    ASSERT_EQ(streamRes.Init(dev, sizeof(AiccCryptoSliceDesc)), RT_ERROR_NONE);
    stm->SetCCStreamResource(&streamRes);

    uint8_t deviceBufA[1024] = {};
    uint8_t deviceBufB[1024] = {};
    uint8_t hostBuf[1024] = {};
    uint8_t src[100] = {};
    uint8_t dst[100] = {};
    for (uint32_t i = 0U; i < sizeof(src); ++i) {
        src[i] = static_cast<uint8_t>(i);
    }

    CCWorker worker;
    worker.device_ = dev;
    CCGcmPlugin gcmPlugin(&crypto);
    worker.plugin_ = &gcmPlugin;
    worker.maxSliceSize_ = 1024U;
    worker.workerId_ = 0U;
    worker.deviceBuffers_[0] = deviceBufA;
    worker.deviceBuffers_[1] = deviceBufB;
    worker.hostCryptoBuf_ = hostBuf;

    CCMemcpyTask task = {};
    task.src = src;
    task.dst = dst;
    task.totalSize = sizeof(src);
    task.kind = RT_MEMCPY_HOST_TO_DEVICE;
    task.streamId = streamId;

    EXPECT_EQ(worker.ProcessH2DSlice(task, &streamRes, 0U, 0U, sizeof(src)), RT_ERROR_NONE);

    BarTaskQueue* taskQueue = streamRes.BarQueue();
    EXPECT_EQ(taskQueue->head, 1U);
    const AiccCryptoSliceDesc* const sliceDesc = reinterpret_cast<const AiccCryptoSliceDesc*>(taskQueue->taskDescList);
    EXPECT_EQ(sliceDesc[0].ciphertextAddr, PtrToValue(deviceBufA));
    EXPECT_EQ(sliceDesc[0].plaintextAddr, PtrToValue(dst));
    EXPECT_EQ(sliceDesc[0].ciphertextLen, CC_CIPHER_HEADER_SIZE + sizeof(src));
    EXPECT_EQ(sliceDesc[0].plaintextLen, static_cast<uint32_t>(sizeof(src)));
    EXPECT_EQ(sliceDesc[0].sliceIdx, 0U);

    // 密文 wire format：84B 头 + 密文体（EVP stub 为直拷贝）
    const AiccCiphertextHeader* header = reinterpret_cast<const AiccCiphertextHeader*>(deviceBufA);
    EXPECT_EQ(header->version, 1U);
    EXPECT_EQ(header->totalLen, CC_CIPHER_HEADER_SIZE + sizeof(src));
    EXPECT_EQ(header->ivLen, 12U);
    EXPECT_EQ(header->tagLen, 16U);
    EXPECT_EQ(header->ciphertextLen, static_cast<uint32_t>(sizeof(src)));
    EXPECT_EQ(memcmp(deviceBufA + sizeof(AiccCiphertextHeader), src, sizeof(src)), 0);

    worker.device_ = nullptr;
    (void)stm->TakeCCStreamResource();
    rtStreamDestroy(stmHandle);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Worker_ProcessH2DSlice_ErrorPaths)
{
    RETAIN_DEVICE(dev);
    Driver* realDriver = dev->Driver_();

    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());

    CCrypto crypto;
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    crypto.InitKey(0);

    StubPcieAndFreeCounted(realDriver);

    CCStreamResManage streamRes;
    ASSERT_EQ(streamRes.Init(dev, sizeof(AiccCryptoSliceDesc)), RT_ERROR_NONE);
    stm->SetCCStreamResource(&streamRes);

    uint8_t deviceBufA[1024] = {};
    uint8_t deviceBufB[1024] = {};
    uint8_t hostBuf[1024] = {};
    uint8_t src[100] = {};
    uint8_t dst[100] = {};

    CCWorker worker;
    worker.device_ = dev;
    CCGcmPlugin gcmPlugin(&crypto);
    worker.plugin_ = &gcmPlugin;
    worker.maxSliceSize_ = 1024U;
    worker.workerId_ = 0U;
    worker.deviceBuffers_[0] = deviceBufA;
    worker.deviceBuffers_[1] = deviceBufB;
    worker.hostCryptoBuf_ = hostBuf;

    CCMemcpyTask task = {};
    task.src = src;
    task.dst = dst;
    task.totalSize = sizeof(src);
    task.kind = RT_MEMCPY_HOST_TO_DEVICE;
    task.streamId = streamId;

    // ① 密钥未初始化：插件经未初始化 CCrypto 加密，返回 KEY_NOT_INITIALIZED
    CCrypto uninitCrypto;
    CCGcmPlugin uninitPlugin(&uninitCrypto);
    worker.plugin_ = &uninitPlugin;
    EXPECT_EQ(worker.ProcessH2DSlice(task, &streamRes, 0U, 0U, sizeof(src)), RT_ERROR_CC_KEY_NOT_INITIALIZED);

    // ② DMA 拷贝失败：目的 Device Buffer 为空使真实 halMemcpy stub 返回错误
    worker.plugin_ = &gcmPlugin;
    worker.deviceBuffers_[0] = nullptr;
    EXPECT_EQ(worker.ProcessH2DSlice(task, &streamRes, 0U, 0U, sizeof(src)), RT_ERROR_CC_WORKER_FAILED);
    worker.deviceBuffers_[0] = deviceBufA;

    // ③ 环形队列满且已取消：等待期间退出并超时
    BarTaskQueue* taskQueue = streamRes.BarQueue();
    taskQueue->head = 2U;
    taskQueue->tail = 0U;
    worker.cancelled_.store(true);
    EXPECT_EQ(worker.ProcessH2DSlice(task, &streamRes, 0U, 0U, sizeof(src)), RT_ERROR_CC_WORKER_TIMEOUT);
    worker.cancelled_.store(false);

    worker.device_ = nullptr;
    (void)stm->TakeCCStreamResource();
    rtStreamDestroy(stmHandle);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Worker_ProcessD2HSlice_Success)
{
    RETAIN_DEVICE(dev);
    Driver* realDriver = dev->Driver_();

    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());

    CCrypto crypto;
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    crypto.InitKey(0);

    StubPcieAndFreeCounted(realDriver);

    CCStreamResManage streamRes;
    ASSERT_EQ(streamRes.Init(dev, sizeof(AiccCryptoSliceDesc)), RT_ERROR_NONE);
    stm->SetCCStreamResource(&streamRes);

    uint8_t deviceBufA[1024] = {};
    uint8_t deviceBufB[1024] = {};
    uint8_t hostBuf[1024] = {};
    uint8_t src[100] = {};
    uint8_t dst[100] = {};
    for (uint32_t i = 0U; i < sizeof(src); ++i) {
        src[i] = static_cast<uint8_t>(i);
    }

    // Host 侧构造模拟 AICPU 已写入的密文
    uint8_t cipherIn[sizeof(AiccCiphertextHeader) + sizeof(src) + 32] = {};
    size_t ctLen = sizeof(cipherIn);
    ASSERT_EQ(
        crypto.Encrypt(0, CC_CRYPTO_CIPHER::AES_128, src, sizeof(src), nullptr, 0, cipherIn, &ctLen), RT_ERROR_NONE);
    ASSERT_EQ(ctLen, sizeof(AiccCiphertextHeader) + sizeof(src));
    (void)memcpy_s(deviceBufA, sizeof(deviceBufA), cipherIn, ctLen);

    CCWorker worker;
    worker.device_ = dev;
    CCGcmPlugin gcmPlugin(&crypto);
    worker.plugin_ = &gcmPlugin;
    worker.maxSliceSize_ = 1024U;
    worker.workerId_ = 0U;
    worker.deadlineMs_ = ~0ULL;
    worker.deviceBuffers_[0] = deviceBufA;
    worker.deviceBuffers_[1] = deviceBufB;
    worker.hostCryptoBuf_ = hostBuf;

    CCMemcpyTask task = {};
    task.src = src;
    task.dst = dst;
    task.totalSize = sizeof(src);
    task.kind = RT_MEMCPY_DEVICE_TO_HOST;
    task.streamId = streamId;

    BarTaskQueue* taskQueue = streamRes.BarQueue();
    const std::vector<uint32_t> sliceLens{static_cast<uint32_t>(sizeof(src))};
    std::atomic<bool> stop{false};
    std::atomic<uint32_t> consumedCount{0U};
    std::atomic<bool> descriptorValid{true};
    std::thread consumer(
        &AicpuSimulator::RunD2HConsumer, taskQueue, src, deviceBufA, deviceBufB, std::cref(sliceLens), std::cref(stop),
        std::ref(consumedCount), std::ref(descriptorValid));
    const ScopeGuard stopConsumer([&stop, &consumer]() {
        stop.store(true);
        if (consumer.joinable()) {
            consumer.join();
        }
    });

    EXPECT_EQ(worker.ProcessD2HSlice(task, &streamRes, 0U, 0U, sizeof(src), 1U), RT_ERROR_NONE);
    EXPECT_TRUE(descriptorValid.load());
    EXPECT_EQ(consumedCount.load(), 1U);
    EXPECT_EQ(taskQueue->head, 1U);
    EXPECT_EQ(taskQueue->tail, 1U);
    EXPECT_EQ(taskQueue->complete, 1U);
    EXPECT_EQ(memcmp(dst, src, sizeof(src)), 0);

    worker.device_ = nullptr;
    (void)stm->TakeCCStreamResource();
    rtStreamDestroy(stmHandle);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Worker_ProcessD2HSlice_ErrorPaths)
{
    RETAIN_DEVICE(dev);
    Driver* realDriver = dev->Driver_();

    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());

    CCrypto crypto;
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    crypto.InitKey(0);

    StubPcieAndFreeCounted(realDriver);

    CCStreamResManage streamRes;
    ASSERT_EQ(streamRes.Init(dev, sizeof(AiccCryptoSliceDesc)), RT_ERROR_NONE);
    stm->SetCCStreamResource(&streamRes);

    uint8_t deviceBufA[1024] = {};
    uint8_t deviceBufB[1024] = {};
    uint8_t hostBuf[1024] = {};
    uint8_t src[100] = {};
    uint8_t dst[100] = {};

    CCWorker worker;
    worker.device_ = dev;
    CCGcmPlugin gcmPlugin(&crypto);
    worker.plugin_ = &gcmPlugin;
    worker.maxSliceSize_ = 1024U;
    worker.workerId_ = 0U;
    worker.deadlineMs_ = ~0ULL;
    worker.deviceBuffers_[0] = deviceBufA;
    worker.deviceBuffers_[1] = deviceBufB;
    worker.hostCryptoBuf_ = hostBuf;

    CCMemcpyTask task = {};
    task.src = src;
    task.dst = dst;
    task.totalSize = sizeof(dst);
    task.kind = RT_MEMCPY_DEVICE_TO_HOST;
    task.streamId = streamId;

    BarTaskQueue* taskQueue = streamRes.BarQueue();

    // ① 密钥未初始化：AICPU 消费 Host 发布的描述符后，Host 解密失败
    CCrypto uninitCrypto;
    CCGcmPlugin uninitPlugin(&uninitCrypto);
    worker.plugin_ = &uninitPlugin;
    const std::vector<uint32_t> sliceLens{static_cast<uint32_t>(sizeof(src))};
    std::atomic<bool> stop{false};
    std::atomic<uint32_t> consumedCount{0U};
    std::atomic<bool> descriptorValid{true};
    std::thread consumer(
        &AicpuSimulator::RunD2HConsumer, taskQueue, src, deviceBufA, deviceBufB, std::cref(sliceLens), std::cref(stop),
        std::ref(consumedCount), std::ref(descriptorValid));
    EXPECT_EQ(worker.ProcessD2HSlice(task, &streamRes, 0U, 0U, sizeof(src), 1U), RT_ERROR_CC_KEY_NOT_INITIALIZED);
    stop.store(true);
    consumer.join();
    EXPECT_TRUE(descriptorValid.load());

    // ② DMA 拷贝失败：已发布的下一片必须先由 AICPU 消费，防止提前复用 A/B Buffer
    streamRes.Reset();
    worker.plugin_ = &gcmPlugin;
    gDrvMemcpyFail = true;
    stop.store(false);
    consumedCount.store(0U);
    descriptorValid.store(true);
    std::vector<uint8_t> multiSrc(static_cast<size_t>(CC_PLAINTEXT_SLICE_SIZE) + 1U);
    std::vector<uint8_t> multiDst(multiSrc.size());
    task.src = multiSrc.data();
    task.dst = multiDst.data();
    task.totalSize = multiSrc.size();
    std::thread dmaConsumer([&]() {
        while (!stop.load() && (consumedCount.load() < 2U)) {
            if (taskQueue->head != taskQueue->tail) {
                taskQueue->tail = (taskQueue->tail + 1U) % taskQueue->depth;
                const uint32_t newCount = consumedCount.fetch_add(1U, std::memory_order_relaxed) + 1U;
                taskQueue->complete = newCount;
            }
            std::this_thread::sleep_for(std::chrono::milliseconds(1));
        }
    });
    EXPECT_EQ(worker.ProcessD2HSlice(task, &streamRes, 0U, 0U, CC_PLAINTEXT_SLICE_SIZE, 2U), RT_ERROR_CC_WORKER_FAILED);
    stop.store(true);
    dmaConsumer.join();
    EXPECT_EQ(consumedCount.load(), 2U);
    gDrvMemcpyFail = false;
    task.src = src;
    task.dst = dst;
    task.totalSize = sizeof(dst);

    // ③ 队列满且已取消：等待可写槽位时超时退出
    streamRes.Reset();
    taskQueue->head = 2U;
    taskQueue->tail = 0U;
    worker.cancelled_.store(true);
    EXPECT_EQ(worker.ProcessD2HSlice(task, &streamRes, 0U, 0U, sizeof(src), 1U), RT_ERROR_CC_WORKER_TIMEOUT);
    worker.cancelled_.store(false);

    worker.device_ = nullptr;
    (void)stm->TakeCCStreamResource();
    rtStreamDestroy(stmHandle);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Worker_ProcessSlices_InvalidKind)
{
    RETAIN_DEVICE(dev);
    Driver* realDriver = dev->Driver_();

    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());

    CCrypto crypto;
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    crypto.InitKey(0);

    StubPcieAndFreeCounted(realDriver);

    CCStreamResManage streamRes;
    ASSERT_EQ(streamRes.Init(dev, sizeof(AiccCryptoSliceDesc)), RT_ERROR_NONE);
    stm->SetCCStreamResource(&streamRes);

    CCWorker worker;
    worker.device_ = dev;
    CCGcmPlugin gcmPlugin(&crypto);
    worker.plugin_ = &gcmPlugin;
    worker.maxSliceSize_ = 1024U;
    worker.workerId_ = 0U;

    CCMemcpyTask task = {};
    task.totalSize = 100U;
    task.kind = RT_MEMCPY_DEVICE_TO_DEVICE;
    task.streamId = streamId;

    std::shared_ptr<Stream> stream;
    CCStreamResManage* resource = nullptr;
    uint32_t sliceNum = 0U;
    ASSERT_EQ(worker.SetupTask(task, stream, resource, sliceNum), RT_ERROR_NONE);
    EXPECT_EQ(sliceNum, 1U);

    // kind 非法：返回 RT_ERROR_INVALID_VALUE（不设置流错误码，错误由 AICPU SQE 超时兜底上报）
    EXPECT_EQ(worker.ProcessSlices(task, resource, sliceNum, nullptr), RT_ERROR_INVALID_VALUE);

    worker.device_ = nullptr;
    (void)stm->TakeCCStreamResource();
    rtStreamDestroy(stmHandle);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Worker_ProcessTask_H2D_MultiSlice)
{
    RETAIN_DEVICE(dev);
    Driver* realDriver = dev->Driver_();

    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());

    CCrypto crypto;
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    crypto.InitKey(0);

    StubPcieAndFreeCounted(realDriver);

    CCStreamResManage streamRes;
    ASSERT_EQ(streamRes.Init(dev, sizeof(AiccCryptoSliceDesc)), RT_ERROR_NONE);
    stm->SetCCStreamResource(&streamRes);

    constexpr size_t TOTAL_SIZE = CC_PLAINTEXT_SLICE_SIZE * 2U + 100U; // 3 片
    std::vector<uint8_t> src(TOTAL_SIZE);
    for (size_t i = 0U; i < src.size(); ++i) {
        src[i] = static_cast<uint8_t>(i & 0xFFU);
    }
    std::vector<uint8_t> dst(TOTAL_SIZE);
    std::vector<uint8_t> deviceBufA(CC_SLICE_SIZE);
    std::vector<uint8_t> deviceBufB(CC_SLICE_SIZE);
    // 精确边界 + 尾部 16B 哨兵：修复前 Encrypt 在偏移 CC_SLICE_SIZE 处写 GCM tag 越界 16B
    std::vector<uint8_t> hostBuf(CC_SLICE_SIZE + 16U);
    for (size_t i = CC_SLICE_SIZE; i < hostBuf.size(); ++i) {
        hostBuf[i] = 0xABU;
    }

    CCWorker worker;
    worker.device_ = dev;
    CCGcmPlugin gcmPlugin(&crypto);
    worker.plugin_ = &gcmPlugin;
    worker.maxSliceSize_ = CC_SLICE_SIZE;
    worker.workerId_ = 0U;
    worker.deviceBuffers_[0] = deviceBufA.data();
    worker.deviceBuffers_[1] = deviceBufB.data();
    worker.hostCryptoBuf_ = hostBuf.data();

    CCMemcpyTask task = {};
    task.src = src.data();
    task.dst = dst.data();
    task.totalSize = TOTAL_SIZE;
    task.kind = RT_MEMCPY_HOST_TO_DEVICE;
    task.streamId = streamId;

    // AICPU 模拟线程并发消费 3 片，防挂死由 ScopeGuard 置 stop
    std::atomic<bool> stop{false};
    std::atomic<uint32_t> consumedCount{0U};
    std::thread consumer(
        &AicpuSimulator::RunH2DConsumer, streamRes.BarQueue(), 3U, std::cref(stop), std::ref(consumedCount));
    const ScopeGuard stopConsumer([&stop, &consumer]() {
        stop.store(true);
        if (consumer.joinable()) {
            consumer.join();
        }
    });

    EXPECT_EQ(worker.ProcessTask(task), RT_ERROR_NONE);
    EXPECT_EQ(consumedCount.load(), 3U);
    for (size_t i = CC_SLICE_SIZE; i < hostBuf.size(); ++i) {
        EXPECT_EQ(hostBuf[i], 0xABU);
    }
    BarTaskQueue* taskQueue = streamRes.BarQueue();
    EXPECT_EQ(taskQueue->complete, 3U);
    EXPECT_EQ(taskQueue->head, taskQueue->tail);
    // 任务收尾门铃复位：hostStatus 回到 WAITING，下一任务的 MEM_WAIT 不会提前放行
    EXPECT_EQ(taskQueue->hostStatus, TASK_QUEUE_STATUS_WAITING);

    worker.device_ = nullptr;
    (void)stm->TakeCCStreamResource();
    rtStreamDestroy(stmHandle);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Worker_ProcessTask_TerminatedQueueDropsTask)
{
    RETAIN_DEVICE(dev);
    Driver* realDriver = dev->Driver_();

    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());

    CCrypto crypto;
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    crypto.InitKey(0);

    StubPcieAndFreeCounted(realDriver);

    CCStreamResManage streamRes;
    ASSERT_EQ(streamRes.Init(dev, sizeof(AiccCryptoSliceDesc)), RT_ERROR_NONE);
    stm->SetCCStreamResource(&streamRes);

    CCWorker worker;
    worker.device_ = dev;
    CCGcmPlugin gcmPlugin(&crypto);
    worker.plugin_ = &gcmPlugin;
    worker.maxSliceSize_ = CC_SLICE_SIZE;
    worker.workerId_ = 0U;
    std::vector<uint8_t> deviceBufA(64U, 0U);
    std::vector<uint8_t> deviceBufB(64U, 0U);
    std::vector<uint8_t> hostBuf(CC_SLICE_SIZE, 0U);
    worker.deviceBuffers_[0] = deviceBufA.data();
    worker.deviceBuffers_[1] = deviceBufB.data();
    worker.hostCryptoBuf_ = hostBuf.data();

    std::vector<uint8_t> src(64U, 0x5AU);
    std::vector<uint8_t> dst(64U, 0U);
    CCMemcpyTask task{};
    task.src = src.data();
    task.dst = dst.data();
    task.totalSize = src.size();
    task.kind = RT_MEMCPY_HOST_TO_DEVICE;
    task.streamId = streamId;

    BarTaskQueue* const queue = streamRes.BarQueue();
    queue->hostStatus = TASK_QUEUE_STATUS_TERMINATED;

    // 门铃 CAS 失败且显式判 terminated：外部中断场景静默丢弃任务，不发布分片，终止标记保留
    EXPECT_EQ(worker.ProcessTask(task), RT_ERROR_NONE);
    EXPECT_EQ(queue->hostStatus, TASK_QUEUE_STATUS_TERMINATED);
    EXPECT_EQ(queue->head, queue->tail);
    EXPECT_EQ(queue->complete, 0U);
    for (const uint8_t value : dst) {
        EXPECT_EQ(value, 0U);
    }

    worker.device_ = nullptr;
    (void)stm->TakeCCStreamResource();
    rtStreamDestroy(stmHandle);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Worker_ProcessTask_HostFailureSetsTerminated)
{
    RETAIN_DEVICE(dev);
    Driver* realDriver = dev->Driver_();

    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());

    CCrypto crypto;
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    crypto.InitKey(0);

    StubPcieAndFreeCounted(realDriver);

    CCStreamResManage streamRes;
    ASSERT_EQ(streamRes.Init(dev, sizeof(AiccCryptoSliceDesc)), RT_ERROR_NONE);
    stm->SetCCStreamResource(&streamRes);

    CCWorker worker;
    worker.device_ = dev;
    CCGcmPlugin gcmPlugin(&crypto);
    worker.plugin_ = &gcmPlugin;
    worker.maxSliceSize_ = CC_SLICE_SIZE;
    worker.workerId_ = 0U;
    std::vector<uint8_t> deviceBufA(64U, 0U);
    std::vector<uint8_t> deviceBufB(64U, 0U);
    std::vector<uint8_t> hostBuf(CC_SLICE_SIZE, 0U);
    worker.deviceBuffers_[0] = deviceBufA.data();
    worker.deviceBuffers_[1] = deviceBufB.data();
    worker.hostCryptoBuf_ = hostBuf.data();

    std::vector<uint8_t> src(64U, 0x5AU);
    std::vector<uint8_t> dst(64U, 0U);
    CCMemcpyTask task{};
    task.src = src.data();
    task.dst = dst.data();
    task.totalSize = src.size();
    task.kind = RT_MEMCPY_DEVICE_TO_DEVICE; // 非法方向：host 侧处理失败
    task.streamId = streamId;

    // host 侧异常必须把 hostStatus 置 TERMINATED，让设备侧停止消费
    EXPECT_NE(worker.ProcessTask(task), RT_ERROR_NONE);
    EXPECT_EQ(streamRes.BarQueue()->hostStatus, TASK_QUEUE_STATUS_TERMINATED);

    worker.device_ = nullptr;
    (void)stm->TakeCCStreamResource();
    rtStreamDestroy(stmHandle);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Worker_ProcessTask_D2H_ThreeSlicesReusesBuffers)
{
    RETAIN_DEVICE(dev);
    Driver* realDriver = dev->Driver_();

    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());

    CCrypto crypto;
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    ASSERT_EQ(crypto.InitKey(0), RT_ERROR_NONE);

    StubPcieAndFreeCounted(realDriver);

    CCStreamResManage streamRes;
    ASSERT_EQ(streamRes.Init(dev, sizeof(AiccCryptoSliceDesc)), RT_ERROR_NONE);
    stm->SetCCStreamResource(&streamRes);

    const std::vector<uint32_t> sliceLens{CC_PLAINTEXT_SLICE_SIZE, CC_PLAINTEXT_SLICE_SIZE, 64U};
    const size_t totalSize = static_cast<size_t>(sliceLens[0]) + sliceLens[1] + sliceLens[2];
    std::vector<uint8_t> src(totalSize);
    for (size_t i = 0U; i < src.size(); ++i) {
        src[i] = static_cast<uint8_t>(i & 0xFFU);
    }
    std::vector<uint8_t> dst(totalSize);
    std::vector<uint8_t> deviceBufA(CC_SLICE_SIZE);
    std::vector<uint8_t> deviceBufB(CC_SLICE_SIZE);
    std::vector<uint8_t> hostBuf(CC_SLICE_SIZE);

    std::vector<std::vector<uint8_t>> ciphers(sliceLens.size());
    std::vector<size_t> cipherLens(sliceLens.size(), 0U);
    size_t offset = 0U;
    for (size_t i = 0U; i < sliceLens.size(); ++i) {
        AiccCryptoSliceDesc aad{};
        aad.ciphertextAddr = PtrToValue((i % 2U) == 0U ? deviceBufA.data() : deviceBufB.data());
        aad.plaintextAddr = PtrToValue(src.data() + offset);
        aad.ciphertextLen = CC_CIPHER_HEADER_SIZE + sliceLens[i];
        aad.plaintextLen = sliceLens[i];
        aad.sliceIdx = static_cast<uint32_t>(i);
        ciphers[i].resize(CC_CIPHER_HEADER_SIZE + sliceLens[i] + 32U);
        cipherLens[i] = ciphers[i].size();
        ASSERT_EQ(
            crypto.Encrypt(
                0, CC_CRYPTO_CIPHER::AES_128, src.data() + offset, sliceLens[i], reinterpret_cast<const uint8_t*>(&aad),
                sizeof(aad), ciphers[i].data(), &cipherLens[i]),
            RT_ERROR_NONE);
        ASSERT_EQ(cipherLens[i], CC_CIPHER_HEADER_SIZE + sliceLens[i]);
        offset += sliceLens[i];
    }

    CCWorker worker;
    worker.device_ = dev;
    CCGcmPlugin gcmPlugin(&crypto);
    worker.plugin_ = &gcmPlugin;
    worker.maxSliceSize_ = CC_SLICE_SIZE;
    worker.workerId_ = 0U;
    worker.deviceBuffers_[0] = deviceBufA.data();
    worker.deviceBuffers_[1] = deviceBufB.data();
    worker.hostCryptoBuf_ = hostBuf.data();

    CCMemcpyTask task{};
    task.src = src.data();
    task.dst = dst.data();
    task.totalSize = totalSize;
    task.kind = RT_MEMCPY_DEVICE_TO_HOST;
    task.streamId = streamId;

    const uint32_t sliceNum = 3U; // 三片：两片满片 + 一片 64B，覆盖 buffer A/B 复用
    BarTaskQueue* const taskQueue = streamRes.BarQueue();

    std::atomic<bool> stop{false};
    std::atomic<uint32_t> consumedCount{0U};
    std::atomic<bool> descriptorValid{true};
    std::thread consumer([&]() {
        size_t plaintextOffset = 0U;
        for (uint32_t sliceIdx = 0U; sliceIdx < sliceNum && !stop.load(); ++sliceIdx) {
            while (!stop.load() && (taskQueue->head == taskQueue->tail)) {
                std::this_thread::sleep_for(std::chrono::milliseconds(1));
            }
            if (stop.load()) {
                return;
            }

            const uint32_t tail = taskQueue->tail;
            const AiccCryptoSliceDesc& desc = *reinterpret_cast<const AiccCryptoSliceDesc*>(
                taskQueue->taskDescList + static_cast<size_t>(tail) * taskQueue->taskDescSize);
            uint8_t* const expectedBuffer = (sliceIdx % 2U) == 0U ? deviceBufA.data() : deviceBufB.data();
            if ((desc.sliceIdx != sliceIdx) || (desc.ciphertextAddr != PtrToValue(expectedBuffer)) ||
                (desc.plaintextAddr != PtrToValue(src.data() + plaintextOffset)) ||
                (desc.plaintextLen != sliceLens[sliceIdx]) || (desc.ciphertextLen != cipherLens[sliceIdx])) {
                descriptorValid.store(false);
            }
            const errno_t copyRet =
                memcpy_s(expectedBuffer, CC_SLICE_SIZE, ciphers[sliceIdx].data(), cipherLens[sliceIdx]);
            if (copyRet != EOK) {
                descriptorValid.store(false);
            }
            plaintextOffset += sliceLens[sliceIdx];
            taskQueue->tail = (tail + 1U) % taskQueue->depth;
            const uint32_t newCount = consumedCount.fetch_add(1U, std::memory_order_relaxed) + 1U;
            taskQueue->complete = newCount;
        }
    });
    const ScopeGuard stopConsumer([&stop, &consumer]() {
        stop.store(true);
        if (consumer.joinable()) {
            consumer.join();
        }
    });

    // 走 ProcessTask（内部 SetupTask + ProcessSlices），与原来单独覆盖 D2H 入口的用例等价
    EXPECT_EQ(worker.ProcessTask(task), RT_ERROR_NONE);
    if (consumer.joinable()) {
        consumer.join();
    }
    EXPECT_TRUE(descriptorValid.load());
    EXPECT_EQ(consumedCount.load(), sliceNum);
    EXPECT_EQ(taskQueue->head, taskQueue->tail);
    EXPECT_EQ(taskQueue->complete, sliceNum);
    EXPECT_EQ(memcmp(dst.data(), src.data(), totalSize), 0);

    worker.device_ = nullptr;
    (void)stm->TakeCCStreamResource();
    rtStreamDestroy(stmHandle);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Worker_ProcessD2HSlice_PublishesNextBeforeDmaAndDecrypt)
{
    RETAIN_DEVICE(dev);
    Driver* realDriver = dev->Driver_();

    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());

    CCrypto encryptCrypto;
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    ASSERT_EQ(encryptCrypto.InitKey(0), RT_ERROR_NONE);

    StubPcieAndFreeCounted(realDriver);

    CCStreamResManage streamRes;
    ASSERT_EQ(streamRes.Init(dev, sizeof(AiccCryptoSliceDesc)), RT_ERROR_NONE);
    stm->SetCCStreamResource(&streamRes);

    constexpr uint32_t LAST_SLICE_LEN = 64U;
    const size_t totalSize = static_cast<size_t>(CC_PLAINTEXT_SLICE_SIZE) + LAST_SLICE_LEN;
    std::vector<uint8_t> src(totalSize);
    std::vector<uint8_t> dst(totalSize);
    std::vector<uint8_t> deviceBufA(CC_SLICE_SIZE);
    std::vector<uint8_t> deviceBufB(CC_SLICE_SIZE);
    std::vector<uint8_t> hostBuf(CC_SLICE_SIZE);
    for (size_t i = 0U; i < src.size(); ++i) {
        src[i] = static_cast<uint8_t>(i & 0xFFU);
    }

    AiccCryptoSliceDesc firstAad{};
    firstAad.ciphertextAddr = PtrToValue(deviceBufA.data());
    firstAad.plaintextAddr = PtrToValue(src.data());
    firstAad.ciphertextLen = CC_CIPHER_HEADER_SIZE + CC_PLAINTEXT_SLICE_SIZE;
    firstAad.plaintextLen = CC_PLAINTEXT_SLICE_SIZE;
    firstAad.sliceIdx = 0U;
    std::vector<uint8_t> firstCipher(CC_SLICE_SIZE + 32U);
    size_t firstCipherLen = firstCipher.size();
    ASSERT_EQ(
        encryptCrypto.Encrypt(
            0, CC_CRYPTO_CIPHER::AES_128, src.data(), CC_PLAINTEXT_SLICE_SIZE,
            reinterpret_cast<const uint8_t*>(&firstAad), sizeof(firstAad), firstCipher.data(), &firstCipherLen),
        RT_ERROR_NONE);

    CCrypto uninitCrypto;
    CCWorker worker;
    worker.device_ = dev;
    CCGcmPlugin gcmPlugin(&uninitCrypto);
    worker.plugin_ = &gcmPlugin;
    worker.maxSliceSize_ = CC_SLICE_SIZE;
    worker.workerId_ = 0U;
    worker.deviceBuffers_[0] = deviceBufA.data();
    worker.deviceBuffers_[1] = deviceBufB.data();
    worker.hostCryptoBuf_ = hostBuf.data();

    CCMemcpyTask task{};
    task.src = src.data();
    task.dst = dst.data();
    task.totalSize = totalSize;
    task.kind = RT_MEMCPY_DEVICE_TO_HOST;
    task.streamId = streamId;

    std::shared_ptr<Stream> stream;
    CCStreamResManage* resource = nullptr;
    uint32_t sliceNum = 0U;
    ASSERT_EQ(worker.SetupTask(task, stream, resource, sliceNum), RT_ERROR_NONE);
    ASSERT_EQ(sliceNum, 2U);
    BarTaskQueue* const taskQueue = streamRes.BarQueue();

    gObservedD2HDst.store(PtrToValue(hostBuf.data()));
    gObservedD2HQueue = taskQueue;
    gExpectedD2HSlice = 1U;
    gExpectedD2HHead = 2U;
    gExpectedD2HTail = 1U;
    std::atomic<bool> stop{false};
    std::thread consumer([&]() {
        while (!stop.load() && (taskQueue->head == taskQueue->tail)) {
            std::this_thread::sleep_for(std::chrono::milliseconds(1));
        }
        if (stop.load()) {
            return;
        }
        const uint32_t firstTail = taskQueue->tail;
        (void)memcpy_s(deviceBufA.data(), deviceBufA.size(), firstCipher.data(), firstCipherLen);
        taskQueue->tail = (firstTail + 1U) % taskQueue->depth;
        taskQueue->complete = 1U;

        while (!stop.load() && !gAllowD2HNextConsume.load()) {
            std::this_thread::sleep_for(std::chrono::milliseconds(1));
        }
        if (!stop.load()) {
            const uint32_t nextTail = taskQueue->tail;
            taskQueue->tail = (nextTail + 1U) % taskQueue->depth;
            taskQueue->complete = 2U;
        }
    });
    const ScopeGuard stopConsumer([&stop, &consumer]() {
        stop.store(true);
        if (consumer.joinable()) {
            consumer.join();
        }
    });

    EXPECT_EQ(
        worker.ProcessD2HSlice(task, resource, 0U, 0U, CC_PLAINTEXT_SLICE_SIZE, sliceNum),
        RT_ERROR_CC_KEY_NOT_INITIALIZED);
    EXPECT_TRUE(gExpectedD2HSlicePublishedAtDma.load());

    gObservedD2HDst.store(0U);
    gObservedD2HQueue = nullptr;
    gExpectedD2HSlice = UINT32_MAX;
    gAllowD2HNextConsume.store(false);
    worker.device_ = nullptr;
    (void)stm->TakeCCStreamResource();
    rtStreamDestroy(stmHandle);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

// ============================================================================
// CCResManage Tests
// ============================================================================

TEST_F(CCManagerTest, CCResManage_Init_CreatesPluginForActiveAlg)
{
    // 整链路按"当前生效模式"起插件（模式由内核节点 mem_encrypt_alg 决定、不可切换）：
    // 校验 CCResManage 建的插件与生效模式一致，算子名随插件（GCM → AiccCrypto，CTR → KeystreamXor）
    const CC_CRYPTO_ALG_TYPE activeAlg = GetActiveCryptoAlg();

    RETAIN_DEVICE(dev);

    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    Api* const apiImpl = Runtime::Instance()->ApiImpl_();
    ASSERT_NE(apiImpl, nullptr);
    MOCKER_CPP_VIRTUAL(apiImpl, &Api::CpuKernelLaunch).expects(never());
    MOCKER_CPP(&Runtime::StartAicpuSd).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(StreamLaunchCpuKernel).expects(once()).will(returnValue(RT_ERROR_NONE));
    Stream* const ctrlStm = dev->GetCtrlSQStream(nullptr);
    ASSERT_NE(ctrlStm, nullptr);
    MOCKER_CPP_VIRTUAL(ctrlStm, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostMemAlloc).stubs().will(invoke(HostMemAllocStub));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostUnregister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostMemFree).stubs().will(returnValue(RT_ERROR_NONE));

    CCResManage resource(dev);
    ASSERT_EQ(resource.InitCcResource(), RT_ERROR_NONE);

    CCCryptoPlugin* const plugin = resource.Plugin();
    ASSERT_NE(plugin, nullptr);
    EXPECT_EQ(plugin->AlgType(), activeAlg);
    EXPECT_STREQ(plugin->KernelName(), (activeAlg == CC_CRYPTO_ALG_TYPE::GCM) ? "AiccCrypto" : "AiccKeystreamXor");
    // 初始 worker 池：只起 1 条，按需再扩容
    EXPECT_EQ(resource.workers_.size(), 1U);
    for (const auto& worker : resource.workers_) {
        EXPECT_NE(worker, nullptr);
    }

    resource.DestroyCcResource();
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, CCResManage_SubmitTask_GrowsOneWorkerPerSubmitUpToFour)
{
    RETAIN_DEVICE(dev);

    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    MOCKER_CPP(&Runtime::StartAicpuSd).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(StreamLaunchCpuKernel).expects(once()).will(returnValue(RT_ERROR_NONE));
    Stream* const ctrlStm = dev->GetCtrlSQStream(nullptr);
    ASSERT_NE(ctrlStm, nullptr);
    MOCKER_CPP_VIRTUAL(ctrlStm, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    StubWorkerHostDriverSimple(dev->Driver_());
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAllocWithBackupFlag).stubs().will(invoke(DevMemAllocEntryStub));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAllocWithFlag).stubs().will(invoke(DevMemAllocStub));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemFree).stubs().will(returnValue(RT_ERROR_NONE));

    CCResManage resource(dev);
    ASSERT_EQ(resource.InitCcResource(), RT_ERROR_NONE);
    ASSERT_EQ(resource.workers_.size(), 1U);

    CCMemcpyTask task{};
    task.streamId = 0xDEADU;
    for (size_t expectedWorkerCount = 2U; expectedWorkerCount <= 6U; ++expectedWorkerCount) {
        EXPECT_EQ(resource.SubmitTask(task), RT_ERROR_NONE);
        EXPECT_EQ(resource.workers_.size(), expectedWorkerCount);
    }
    EXPECT_EQ(resource.SubmitTask(task), RT_ERROR_NONE);
    EXPECT_EQ(resource.workers_.size(), 6U);

    resource.DestroyCcResource();
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, CCResManage_SubmitTask_ContinuesWithExistingWorkerWhenExpansionFails)
{
    RETAIN_DEVICE(dev);

    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    MOCKER_CPP(&Runtime::StartAicpuSd).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(StreamLaunchCpuKernel).expects(once()).will(returnValue(RT_ERROR_NONE));
    Stream* const ctrlStm = dev->GetCtrlSQStream(nullptr);
    ASSERT_NE(ctrlStm, nullptr);
    MOCKER_CPP_VIRTUAL(ctrlStm, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    StubWorkerHostDriverSimple(dev->Driver_());
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAllocWithBackupFlag).stubs().will(invoke(DevMemAllocEntryStub));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAllocWithFlag).stubs().will(invoke(DevMemAllocStub));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemFree).stubs().will(returnValue(RT_ERROR_NONE));

    gHostAllocFailAt = 2U;
    CCResManage resource(dev);
    ASSERT_EQ(resource.InitCcResource(), RT_ERROR_NONE);
    ASSERT_EQ(resource.workers_.size(), 1U);

    CCMemcpyTask task{};
    task.streamId = 0xDEADU;
    // 第二个 worker 的 host buffer 申请被注入为失败，现有 worker 继续服务
    EXPECT_EQ(resource.SubmitTask(task), RT_ERROR_NONE);
    EXPECT_EQ(resource.workers_.size(), 1U);
    EXPECT_EQ(gHostAllocCount, 2U);

    resource.DestroyCcResource();
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, CCResManage_Init_Failures)
{
    RETAIN_DEVICE(dev);

    MOCKER(StreamLaunchCpuKernel).expects(never());

    // ① 取密钥失败（最先发生）：Init 失败且不留 worker
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(-1));
    {
        CCResManage resource(dev);
        EXPECT_EQ(resource.InitCcResource(), RT_ERROR_CC_INIT_FAILED);
        EXPECT_TRUE(resource.workers_.empty());
    }

    // ② 密钥就绪但 AICPU 调度器起不来：同样失败且不留 worker
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    MOCKER_CPP(&Runtime::StartAicpuSd).stubs().will(returnValue(RT_ERROR_DRV_OPEN_AICPU));
    {
        CCResManage resource(dev);
        EXPECT_EQ(resource.InitCcResource(), RT_ERROR_CC_INIT_FAILED);
        EXPECT_TRUE(resource.workers_.empty());
    }

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, CCResManage_LoadKeyToAicpu_StartAicpuSdFailure)
{
    RETAIN_DEVICE(dev);

    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    MOCKER_CPP(&Runtime::StartAicpuSd).expects(once()).will(returnValue(RT_ERROR_DRV_OPEN_AICPU));
    MOCKER(StreamLaunchCpuKernel).expects(never());

    CCResManage resource(dev);
    ASSERT_EQ(resource.crypto_.InitKey(dev->Id_()), RT_ERROR_NONE);
    EXPECT_EQ(resource.LoadKeyToAicpu(), RT_ERROR_DRV_OPEN_AICPU);

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, CCResManage_Init_ErrorPaths)
{
    // ① 空设备构造 + Init 失败
    CCResManage nullResource(nullptr);
    EXPECT_EQ(nullResource.InitCcResource(), RT_ERROR_DEVICE_NULL);

    // ② 初始 worker 初始化失败：Init 返回错误且 worker 池被清空
    RETAIN_DEVICE(dev);
    Driver* realDriver = dev->Driver_();

    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    Stream* const ctrlStm = dev->GetCtrlSQStream(nullptr);
    ASSERT_NE(ctrlStm, nullptr);
    MOCKER_CPP_VIRTUAL(ctrlStm, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    StubWorkerHostDriver(realDriver);
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemAllocWithBackupFlag).stubs().will(invoke(DevMemAllocEntryStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemAllocWithFlag).stubs().will(invoke(DevMemAllocStub));

    CCResManage resource(dev);
    gHostAllocFailAt = 1U;
    EXPECT_NE(resource.InitCcResource(), RT_ERROR_NONE);
    EXPECT_TRUE(resource.workers_.empty());
    EXPECT_EQ(resource.taskQueue_, nullptr);

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, CCResManage_GetOrCreateStreamResource_Basics)
{
    RETAIN_DEVICE(dev);
    Driver* realDriver = dev->Driver_();

    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);

    StubPcieAndFreeCounted(realDriver);

    CCResManage resource(dev);
    CCStreamResManage* streamRes = nullptr;

    // ① 空流
    EXPECT_EQ(resource.GetOrCreateStreamResource(nullptr, streamRes), RT_ERROR_STREAM_NULL);

    // ② Stream 资源分配失败
    gDevMemAllocReturnFail = true;
    EXPECT_NE(resource.GetOrCreateStreamResource(stm, streamRes), RT_ERROR_NONE);
    EXPECT_EQ(streamRes, nullptr);
    EXPECT_EQ(stm->GetCCStreamResource(), nullptr);

    // ③ 首次创建挂载
    gDevMemAllocReturnFail = false;
    gDevMemAllocCount = 0U;
    EXPECT_EQ(resource.GetOrCreateStreamResource(stm, streamRes), RT_ERROR_NONE);
    ASSERT_NE(streamRes, nullptr);
    EXPECT_EQ(stm->GetCCStreamResource(), streamRes);
    EXPECT_EQ(gDevMemAllocCount, 1U);

    // ④ 缓存命中：同指针且不再分配
    CCStreamResManage* cachedRes = nullptr;
    EXPECT_EQ(resource.GetOrCreateStreamResource(stm, cachedRes), RT_ERROR_NONE);
    EXPECT_EQ(cachedRes, streamRes);
    EXPECT_EQ(gDevMemAllocCount, 1U);

    resource.DestroyStreamResource(stm);
    rtStreamDestroy(stmHandle);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, CCResManage_DestroyStreamResource_Basics)
{
    RETAIN_DEVICE(dev);
    Driver* realDriver = dev->Driver_();

    rtStream_t stmAHandle = 0U;
    rtStream_t stmBHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmAHandle));
    ASSERT_TRUE(CreatePersistentStream(stmBHandle));
    Stream* stmA = rt_ut::UnwrapOrNull<Stream>(stmAHandle);
    Stream* stmB = rt_ut::UnwrapOrNull<Stream>(stmBHandle);
    ASSERT_NE(stmA, (Stream*)nullptr);
    ASSERT_NE(stmB, (Stream*)nullptr);

    StubPcieAndFreeCounted(realDriver);

    CCResManage resource(dev);
    // 手动注入任务队列（无 worker 消费，便于确定性验证取消逻辑）
    resource.taskQueue_ = std::make_unique<CCMemcpyTaskQueue>();

    // ① 空流 no-op
    resource.DestroyStreamResource(nullptr);

    // ② 按流取消未执行任务：stmA 任务被移除，stmB 任务保留
    CCMemcpyTask taskA = {};
    taskA.streamId = static_cast<uint32_t>(stmA->Id_());
    CCMemcpyTask taskB = {};
    taskB.streamId = static_cast<uint32_t>(stmB->Id_());
    ASSERT_TRUE(resource.taskQueue_->Push(taskA));
    ASSERT_TRUE(resource.taskQueue_->Push(taskB));
    ASSERT_TRUE(resource.taskQueue_->Push(taskA));

    CCStreamResManage* streamResA = nullptr;
    ASSERT_EQ(resource.GetOrCreateStreamResource(stmA, streamResA), RT_ERROR_NONE);
    ASSERT_NE(streamResA, nullptr);
    resource.DestroyStreamResource(stmA);
    EXPECT_EQ(stmA->GetCCStreamResource(), nullptr);
    ASSERT_EQ(resource.taskQueue_->queue_.size(), 1U);
    EXPECT_EQ(resource.taskQueue_->queue_.front().streamId, static_cast<uint32_t>(stmB->Id_()));

    // ③ 未挂资源的 stmB 也可安全销毁
    resource.DestroyStreamResource(stmB);
    EXPECT_EQ(resource.taskQueue_->queue_.size(), 0U);
    EXPECT_EQ(stmB->GetCCStreamResource(), nullptr);

    rtStreamDestroy(stmAHandle);
    rtStreamDestroy(stmBHandle);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, CCResManage_SubmitTask_Basics)
{
    RETAIN_DEVICE(dev);
    Driver* realDriver = dev->Driver_();

    CCResManage resource(dev);
    CCMemcpyTask task = {};
    task.streamId = 0xDEADU;

    // ① 未初始化（无任务队列）：提交失败
    EXPECT_EQ(resource.SubmitTask(task), RT_ERROR_CC_WORKER_FAILED);

    // ② 初始化后提交成功（假 streamId，worker 取出后丢弃）
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    MOCKER_CPP(&Runtime::StartAicpuSd).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(StreamLaunchCpuKernel).expects(once()).will(returnValue(RT_ERROR_NONE));
    Stream* const ctrlStm = dev->GetCtrlSQStream(nullptr);
    ASSERT_NE(ctrlStm, nullptr);
    MOCKER_CPP_VIRTUAL(ctrlStm, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    StubWorkerHostDriver(realDriver);
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemAllocWithBackupFlag).stubs().will(invoke(DevMemAllocEntryStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemAllocWithFlag).stubs().will(invoke(DevMemAllocStub));

    ASSERT_EQ(resource.InitCcResource(), RT_ERROR_NONE);
    EXPECT_EQ(resource.SubmitTask(task), RT_ERROR_NONE);

    // ③ 队列关闭后提交失败
    resource.taskQueue_->Shutdown();
    EXPECT_EQ(resource.SubmitTask(task), RT_ERROR_CC_WORKER_FAILED);

    resource.DestroyCcResource();
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

// ============================================================================
// CCManager Tests
// ============================================================================

TEST_F(CCManagerTest, SmallTransfer_EligibilityAndLegacyFallback)
{
    Stream* stm = PrepareSmallTransfer();
    EXPECT_TRUE(CCManager::CanUseSmallCcMemcpy(CC_SMALL_PLAINTEXT_CAPACITY, RT_MEMCPY_HOST_TO_DEVICE, stm, false));
    EXPECT_TRUE(CCManager::CanUseSmallCcMemcpy(CC_SMALL_PLAINTEXT_CAPACITY, RT_MEMCPY_DEVICE_TO_HOST, stm, true));
    for (uint64_t count : {uint64_t{CC_SMALL_PLAINTEXT_CAPACITY} + 1U, uint64_t{CC_SMALL_PLAINTEXT_CAPACITY} + 2U}) {
        EXPECT_FALSE(CCManager::CanUseSmallCcMemcpy(count, RT_MEMCPY_HOST_TO_DEVICE, stm, false));
        EXPECT_FALSE(CCManager::CanUseSmallCcMemcpy(count, RT_MEMCPY_DEVICE_TO_HOST, stm, true));
    }
    EXPECT_FALSE(CCManager::CanUseSmallCcMemcpy(1U, RT_MEMCPY_DEVICE_TO_HOST, stm, false));
    CCManager::Instance().resources_[stm->Device_()->Id_()]->smallCryptoSupported_ = false;
    EXPECT_FALSE(CCManager::CanUseSmallCcMemcpy(1U, RT_MEMCPY_HOST_TO_DEVICE, stm, false));
    EXPECT_TRUE(gSmallLaunches.empty());
}

TEST_F(CCManagerTest, SmallTransfer_2DAsyncH2DUsesFastPathPerRow)
{
    Stream* stm = PrepareSmallTransfer();
    uint8_t source[8]{};
    uint8_t destination[8]{};
    MOCKER(CCManager::SubmitSmallCcMemcpyTask).expects(exactly(2)).will(returnValue(RT_ERROR_NONE));
    MOCKER(CCManager::SubmitCcMemcpyTask).expects(never());
    EXPECT_EQ(
        CCManager::SubmitCcMemcpy2DTasks(destination, 4U, source, 4U, 4U, 2U, stm, RT_MEMCPY_HOST_TO_DEVICE, false),
        RT_ERROR_NONE);
}

TEST_F(CCManagerTest, SmallTransfer_2DSyncH2DWaitsOnceAfterAllRows)
{
    Stream* stm = PrepareSmallTransfer();
    uint8_t source[8]{};
    uint8_t destination[8]{};
    MOCKER_CPP_VIRTUAL(stm, &Stream::Synchronize).expects(once()).will(returnValue(RT_ERROR_STREAM_SYNC_TIMEOUT));
    EXPECT_EQ(
        CCManager::CCMemCopy2DSync(destination, 4U, source, 4U, 4U, 2U, RT_MEMCPY_HOST_TO_DEVICE),
        RT_ERROR_STREAM_SYNC_TIMEOUT);
    ASSERT_EQ(gSmallLaunches.size(), 2U);
    EXPECT_EQ(gSmallLaunches[0].metadata.dstAddr, RtPtrToValue(destination));
    EXPECT_EQ(gSmallLaunches[1].metadata.dstAddr, RtPtrToValue(destination + 4U));
}

TEST_F(CCManagerTest, SmallTransfer_BatchSyncH2DWaitsOnceAfterAllItems)
{
    Stream* stm = PrepareSmallTransfer();
    uint8_t source[8]{};
    uint8_t destination[8]{};
    void* srcs[] = {source, source + 4U};
    void* dsts[] = {destination, destination + 4U};
    size_t sizes[] = {4U, 4U};
    rtMemcpyBatchAttr attrs[1]{};
    size_t attrsIdxs[] = {0U};
    size_t failIdx = 0U;
    MOCKER(CheckMemCpyAttr).stubs().will(invoke(SmallBatchH2DAttrStub));
    MOCKER_CPP_VIRTUAL(stm, &Stream::Synchronize).expects(once()).will(returnValue(RT_ERROR_STREAM_SYNC_TIMEOUT));
    EXPECT_EQ(
        CCManager::CCMemcpyBatch(dsts, srcs, sizes, 2U, attrs, attrsIdxs, 1U, &failIdx), RT_ERROR_STREAM_SYNC_TIMEOUT);
    ASSERT_EQ(gSmallLaunches.size(), 2U);
    EXPECT_EQ(gSmallLaunches[0].metadata.dstAddr, RtPtrToValue(destination));
    EXPECT_EQ(gSmallLaunches[1].metadata.dstAddr, RtPtrToValue(destination + 4U));
}

TEST_F(CCManagerTest, SmallTransfer_2DAsyncD2HKeepsLegacyPath)
{
    Stream* stm = PrepareSmallTransfer();
    uint8_t source[8]{};
    uint8_t destination[8]{};
    MOCKER(CCManager::SubmitSmallCcMemcpyTask).expects(never());
    MOCKER(CCManager::SubmitCcMemcpyTask).expects(exactly(2)).will(returnValue(RT_ERROR_NONE));
    EXPECT_EQ(
        CCManager::SubmitCcMemcpy2DTasks(destination, 4U, source, 4U, 4U, 2U, stm, RT_MEMCPY_DEVICE_TO_HOST, false),
        RT_ERROR_NONE);
}

TEST_F(CCManagerTest, SmallTransfer_2DSyncD2HFallsBackPerRow)
{
    Stream* stm = PrepareSmallTransfer();
    uint8_t source[8]{};
    uint8_t destination[8]{};
    MOCKER(CCManager::SubmitSmallCcMemcpyTask).expects(exactly(2)).will(returnValue(RT_ERROR_CONTINUE_EXECUTE));
    MOCKER(CCManager::SubmitCcMemcpyTask).expects(exactly(2)).will(returnValue(RT_ERROR_NONE));
    EXPECT_EQ(
        CCManager::SubmitCcMemcpy2DTasks(destination, 4U, source, 4U, 4U, 2U, stm, RT_MEMCPY_DEVICE_TO_HOST, true),
        RT_ERROR_NONE);
}

TEST_F(CCManagerTest, SmallTransfer_H2DInlinePayloadIsIndependent)
{
    Stream* stm = PrepareSmallTransfer();
    uint8_t source[CC_SMALL_PLAINTEXT_CAPACITY];
    (void)memset_s(source, sizeof(source), 0x37, sizeof(source));
    uint8_t destination[CC_SMALL_PLAINTEXT_CAPACITY]{};
    MOCKER_CPP_VIRTUAL(stm, &Stream::Synchronize).expects(never());
    ASSERT_EQ(
        CCManager::CCMemcpyAsync(
            destination, sizeof(destination), source, sizeof(source), RT_MEMCPY_HOST_TO_DEVICE_EX, stm, nullptr,
            nullptr, true, nullptr),
        RT_ERROR_NONE);
    (void)memset_s(source, sizeof(source), 0x91, sizeof(source));
    ASSERT_EQ(
        CCManager::SubmitSmallCcMemcpyTask(
            destination, sizeof(destination), source, sizeof(source), RT_MEMCPY_HOST_TO_DEVICE, stm, false),
        RT_ERROR_NONE);
    ASSERT_EQ(gSmallLaunches.size(), 2U);
    EXPECT_EQ(gSmallLaunches[0].ciphertext[sizeof(AiccCiphertextHeader)], 0x37U);
    EXPECT_EQ(gSmallLaunches[1].ciphertext[sizeof(AiccCiphertextHeader)], 0x91U);
    EXPECT_EQ(gSmallLaunches[0].metadata.dstAddr, RtPtrToValue(destination));
}

TEST_F(CCManagerTest, SmallTransfer_H2DSyncPropagatesExecutionError)
{
    Stream* stm = PrepareSmallTransfer();
    uint8_t value = 1U;
    MOCKER_CPP_VIRTUAL(stm, &Stream::Synchronize).expects(once()).will(returnValue(RT_ERROR_STREAM_SYNC_TIMEOUT));
    EXPECT_EQ(
        CCManager::SubmitSmallCcMemcpyTask(
            &value, sizeof(value), &value, sizeof(value), RT_MEMCPY_HOST_TO_DEVICE, stm, true),
        RT_ERROR_STREAM_SYNC_TIMEOUT);
}

TEST_F(CCManagerTest, SmallTransfer_D2HReadbackReusesStreamBuffers)
{
    Stream* stm = PrepareSmallD2H();
    MOCKER_CPP_VIRTUAL(stm, &Stream::Synchronize).expects(exactly(2)).will(returnValue(RT_ERROR_NONE));
    uint8_t source[CC_SMALL_PLAINTEXT_CAPACITY];
    (void)memset_s(source, sizeof(source), 7, sizeof(source));
    uint8_t destination[sizeof(source)]{};
    ASSERT_EQ(
        CCManager::SubmitSmallCcMemcpyTask(
            destination, sizeof(destination), source, sizeof(source), RT_MEMCPY_DEVICE_TO_HOST, stm, true),
        RT_ERROR_NONE);
    EXPECT_EQ(memcmp(source, destination, sizeof(source)), 0);
    source[0] = 17U;
    ASSERT_EQ(
        CCManager::SubmitSmallCcMemcpyTask(
            destination, sizeof(destination), source, sizeof(source), RT_MEMCPY_DEVICE_TO_HOST, stm, true),
        RT_ERROR_NONE);
    EXPECT_EQ(memcmp(source, destination, sizeof(source)), 0);
    EXPECT_EQ(gDevMemAllocCount, 1U);
    EXPECT_EQ(gHostAllocCount, 1U);
    EXPECT_EQ(gDevMemFreeCount, 0U);
    EXPECT_EQ(gSmallLaunches[0].metadata.dstAddr, gSmallLaunches[1].metadata.dstAddr);
    CCManager::DestroyStreamResource(stm); // Simulates the callback after stream termination.
    EXPECT_EQ(gDevMemFreeCount, 1U);
    EXPECT_EQ(gHostMemFreeCount, 1U);
    EXPECT_EQ(gHostDmaUnmapCount, 1U);
}

TEST_F(CCManagerTest, SmallTransfer_D2HTimeoutPreventsReuseUntilSynchronized)
{
    Stream* stm = PrepareSmallD2H();
    MOCKER_CPP_VIRTUAL(stm, &Stream::Synchronize).expects(exactly(2)).will(returnValue(RT_ERROR_STREAM_SYNC_TIMEOUT));
    uint8_t source = 7U;
    uint8_t destination = 0xA5U;
    for (uint32_t i = 0U; i < 2U; ++i) {
        EXPECT_EQ(
            CCManager::SubmitSmallCcMemcpyTask(
                &destination, sizeof(destination), &source, sizeof(source), RT_MEMCPY_DEVICE_TO_HOST, stm, true),
            RT_ERROR_STREAM_SYNC_TIMEOUT);
    }
    EXPECT_EQ(destination, 0xA5U);
    EXPECT_TRUE(stm->GetCCStreamResource()->SmallD2HResources().pending);
    EXPECT_EQ(gSmallLaunches.size(), 1U);
    EXPECT_EQ(gDevMemAllocCount, 1U);
    EXPECT_EQ(gDevMemFreeCount, 0U);
    EXPECT_EQ(gHostMemFreeCount, 0U);
    // Simulate the destruction callback after device task termination.
    CCManager::DestroyStreamResource(stm);
    EXPECT_EQ(gDevMemFreeCount, 1U);
    EXPECT_EQ(gHostMemFreeCount, 1U);
    EXPECT_EQ(gHostDmaUnmapCount, 1U);
}

TEST_F(CCManagerTest, SmallTransfer_D2HAuthFailureDoesNotPublishPlaintext)
{
    Stream* stm = PrepareSmallD2H();
    MOCKER_CPP_VIRTUAL(stm, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    gSmallAuthFail = true;
    uint8_t source = 7U;
    uint8_t destination = 0xA5U;
    EXPECT_EQ(
        CCManager::SubmitSmallCcMemcpyTask(
            &destination, sizeof(destination), &source, sizeof(source), RT_MEMCPY_DEVICE_TO_HOST, stm, true),
        RT_ERROR_CC_TAG_VERIFY_FAILED);
    EXPECT_EQ(destination, 0xA5U);
}

TEST_F(CCManagerTest, SmallTransfer_D2HTimeoutRecoveryReusesBuffer)
{
    Stream* stm = PrepareSmallD2H();
    MOCKER_CPP_VIRTUAL(stm, &Stream::Synchronize)
        .expects(exactly(3))
        .will(returnValue(RT_ERROR_STREAM_SYNC_TIMEOUT))
        .then(returnValue(RT_ERROR_NONE));
    uint8_t source = 7U;
    uint8_t destination = 0xA5U;
    EXPECT_EQ(
        CCManager::SubmitSmallCcMemcpyTask(
            &destination, sizeof(destination), &source, sizeof(source), RT_MEMCPY_DEVICE_TO_HOST, stm, true),
        RT_ERROR_STREAM_SYNC_TIMEOUT);
    source = 19U;
    EXPECT_EQ(
        CCManager::SubmitSmallCcMemcpyTask(
            &destination, sizeof(destination), &source, sizeof(source), RT_MEMCPY_DEVICE_TO_HOST, stm, true),
        RT_ERROR_NONE);
    EXPECT_EQ(destination, source);
    EXPECT_FALSE(stm->GetCCStreamResource()->SmallD2HResources().pending);
    EXPECT_EQ(gSmallLaunches.size(), 2U);
    EXPECT_EQ(gDevMemAllocCount, 1U);
}

TEST_F(CCManagerTest, SmallTransfer_D2HReadbackFailureQuarantinesBuffer)
{
    Stream* stm = PrepareSmallD2H();
    MOCKER_CPP_VIRTUAL(stm, &Stream::Synchronize).expects(once()).will(returnValue(RT_ERROR_NONE));
    gSmallCopyError = RT_ERROR_CC_WORKER_FAILED;
    uint8_t source = 7U;
    uint8_t destination = 0xA5U;
    EXPECT_EQ(
        CCManager::SubmitSmallCcMemcpyTask(
            &destination, sizeof(destination), &source, sizeof(source), RT_MEMCPY_DEVICE_TO_HOST, stm, true),
        RT_ERROR_CC_WORKER_FAILED);
    EXPECT_EQ(
        CCManager::SubmitSmallCcMemcpyTask(
            &destination, sizeof(destination), &source, sizeof(source), RT_MEMCPY_DEVICE_TO_HOST, stm, true),
        RT_ERROR_CONTINUE_EXECUTE);
    EXPECT_EQ(destination, 0xA5U);
    EXPECT_EQ(gSmallLaunches.size(), 1U);
    EXPECT_EQ(gDevMemFreeCount, 0U);
    EXPECT_EQ(gHostMemFreeCount, 0U);
    CCManager::DestroyStreamResource(stm);
    EXPECT_EQ(gDevMemFreeCount, 1U);
    EXPECT_EQ(gHostMemFreeCount, 1U);
    EXPECT_EQ(gHostDmaUnmapCount, 1U);
}

TEST_F(CCManagerTest, SmallTransfer_D2HDeviceAllocationFailureFallsBack)
{
    Stream* stm = PrepareSmallD2H();
    gDevMemAllocReturnFail = true;
    uint8_t value = 7U;
    EXPECT_EQ(
        CCManager::SubmitSmallCcMemcpyTask(
            &value, sizeof(value), &value, sizeof(value), RT_MEMCPY_DEVICE_TO_HOST, stm, true),
        RT_ERROR_CONTINUE_EXECUTE);
    EXPECT_TRUE(gSmallLaunches.empty());
    EXPECT_EQ(gDevMemFreeCount, 0U);
    EXPECT_EQ(gHostMemFreeCount, 0U);
    EXPECT_FALSE(stm->GetCCStreamResource()->SmallD2HResources().pending);
}

TEST_F(CCManagerTest, SmallTransfer_D2HHostAllocationFailureFallsBackAfterRollback)
{
    Stream* stm = PrepareSmallD2H();
    gHostAllocFailAt = gHostAllocCount + 1U;
    uint8_t value = 7U;
    EXPECT_EQ(
        CCManager::SubmitSmallCcMemcpyTask(
            &value, sizeof(value), &value, sizeof(value), RT_MEMCPY_DEVICE_TO_HOST, stm, true),
        RT_ERROR_CONTINUE_EXECUTE);
    EXPECT_TRUE(gSmallLaunches.empty());
    EXPECT_EQ(gDevMemFreeCount, 1U);
    EXPECT_EQ(gHostMemFreeCount, 0U);
    EXPECT_EQ(stm->GetCCStreamResource()->SmallD2HResources().deviceBuffer, nullptr);
    EXPECT_FALSE(stm->GetCCStreamResource()->SmallD2HResources().pending);
}

TEST_F(CCManagerTest, SmallTransfer_D2HDmaMappingFailureFallsBackAfterRollback)
{
    Stream* stm = PrepareSmallD2H();
    gHostDmaMapFail = true;
    uint8_t value = 7U;
    EXPECT_EQ(
        CCManager::SubmitSmallCcMemcpyTask(
            &value, sizeof(value), &value, sizeof(value), RT_MEMCPY_DEVICE_TO_HOST, stm, true),
        RT_ERROR_CONTINUE_EXECUTE);
    EXPECT_TRUE(gSmallLaunches.empty());
    EXPECT_EQ(gDevMemFreeCount, 1U);
    EXPECT_EQ(gHostMemFreeCount, 1U);
    EXPECT_EQ(stm->GetCCStreamResource()->SmallD2HResources().deviceBuffer, nullptr);
    EXPECT_EQ(stm->GetCCStreamResource()->SmallD2HResources().hostBuffer, nullptr);
}

TEST_F(CCManagerTest, Manager_InitDeviceResource_NullDevice)
{
    CCManager manager;
    rtError_t ret = manager.InitDeviceResource(nullptr);
    EXPECT_EQ(ret, RT_ERROR_DEVICE_NULL);
}

TEST_F(CCManagerTest, Manager_InitDeviceResource_RepeatedInit)
{
    RETAIN_DEVICE(dev);

    // InitKey 仅执行一次（GetKeyFromKernel 被 H2D/D2H 方向各调一次，共 exactly(2)），第二次初始化应幂等返回。
    MOCKER(GetKeyFromKernel).expects(exactly(2)).will(returnValue(0));
    MOCKER_CPP(&Runtime::StartAicpuSd).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(StreamLaunchCpuKernel).expects(once()).will(returnValue(RT_ERROR_NONE));
    Stream* const ctrlStm = dev->GetCtrlSQStream(nullptr);
    ASSERT_NE(ctrlStm, nullptr);
    MOCKER_CPP_VIRTUAL(ctrlStm, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    StubWorkerHostDriverSimple(dev->Driver_());

    CCManager manager;
    EXPECT_EQ(manager.InitDeviceResource(dev), RT_ERROR_NONE);
    EXPECT_EQ(manager.InitDeviceResource(dev), RT_ERROR_NONE);

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Manager_InitDeviceResource_ErrorPaths)
{
    RETAIN_DEVICE(dev);

    // ⓪ 空设备
    {
        CCManager manager;
        EXPECT_EQ(manager.InitDeviceResource(nullptr), RT_ERROR_DEVICE_NULL);
    }

    // ① deviceId 越界
    MOCKER_CPP_VIRTUAL(dev, &Device::Id_).stubs().will(invoke(FakeDeviceIdStub));
    gFakeDeviceId = RT_MAX_DEV_NUM;
    EXPECT_EQ(CCManager::InitDeviceResource(dev), RT_ERROR_DEVICE_ID);

    // ② device driver 为空
    gFakeDeviceId = 0U;
    MOCKER_CPP_VIRTUAL(dev, &Device::Driver_).stubs().will(invoke(FakeDeviceDriverStub));
    gReturnNullDriver = true;
    EXPECT_EQ(CCManager::InitDeviceResource(dev), RT_ERROR_DRV_NULL);

    // ③ 密钥初始化失败：返回 CC_INIT_FAILED 且不残留资源
    gReturnNullDriver = false;
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(-1));
    EXPECT_EQ(CCManager::InitDeviceResource(dev), RT_ERROR_CC_INIT_FAILED);
    EXPECT_EQ(CCManager::Instance().resources_[0], nullptr);

    // ④ 空流无崩溃
    CCManager::DestroyStreamResource(nullptr);

    CCManager::ReleaseDeviceResource(0U);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Manager_ReleaseDeviceResource_Basics)
{
    // ① 非法 deviceId 无崩溃
    CCManager::ReleaseDeviceResource(RT_MAX_DEV_NUM);

    // ② 正常 Init 后释放资源为空
    RETAIN_DEVICE(dev);
    Driver* realDriver = dev->Driver_();

    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    MOCKER_CPP(&Runtime::StartAicpuSd).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(StreamLaunchCpuKernel).expects(once()).will(returnValue(RT_ERROR_NONE));
    Stream* const ctrlStm = dev->GetCtrlSQStream(nullptr);
    ASSERT_NE(ctrlStm, nullptr);
    MOCKER_CPP_VIRTUAL(ctrlStm, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    StubWorkerHostDriver(realDriver);
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemAllocWithBackupFlag).stubs().will(invoke(DevMemAllocEntryStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemAllocWithFlag).stubs().will(invoke(DevMemAllocStub));

    ASSERT_EQ(CCManager::InitDeviceResource(dev), RT_ERROR_NONE);
    ASSERT_NE(CCManager::Instance().resources_[0], nullptr);

    CCManager::ReleaseDeviceResource(0U);
    EXPECT_EQ(CCManager::Instance().resources_[0], nullptr);

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Manager_UnsupportedCopyKind_ReturnsContinueExecute)
{
    EXPECT_EQ(CCManager::CCMemCopySync(nullptr, 0U, nullptr, 0U, RT_MEMCPY_DEVICE_TO_DEVICE), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(
        CCManager::CCMemCopy2DAsync(nullptr, 0U, nullptr, 0U, 0U, 0U, nullptr, RT_MEMCPY_RESERVED),
        RT_ERROR_CONTINUE_EXECUTE);
    EXPECT_EQ(
        CCManager::CCMemCopy2DSync(nullptr, 0U, nullptr, 0U, 0U, 0U, RT_MEMCPY_DEVICE_TO_DEVICE),
        RT_ERROR_CONTINUE_EXECUTE);
}

TEST_F(CCManagerTest, Manager_SyncCopyInCcModeReturnsFeatureNotSupportOnContextAbort)
{
    gCcMode = HAL_CC_MODE_NORMAL;
    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    ASSERT_NE(curCtx, nullptr);
    Stream* const curStm = curCtx->DefaultStream_();
    ASSERT_NE(curStm, nullptr);
    Driver* const driver = curCtx->Device_()->Driver_();
    ASSERT_NE(driver, nullptr);

    uint8_t dst[16] = {};
    uint8_t src[16] = {};
    rtPtrAttributes_t dstAttributes = {};
    dstAttributes.location.type = RT_MEMORY_LOC_DEVICE;
    dstAttributes.location.id = 0U;
    rtPtrAttributes_t srcAttributes = {};
    srcAttributes.location.type = RT_MEMORY_LOC_HOST;
    srcAttributes.location.id = 0U;

    MOCKER_CPP_VIRTUAL(driver, &Driver::PtrGetAttributes)
        .expects(once())
        .with(eq(static_cast<const void*>(dst)), outBoundP(&dstAttributes, sizeof(dstAttributes)))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::PtrGetAttributes)
        .expects(once())
        .with(eq(static_cast<const void*>(src)), outBoundP(&srcAttributes, sizeof(srcAttributes)))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(curStm, &Stream::CheckContextStatus).expects(once()).will(returnValue(RT_ERROR_STREAM_ABORT));

    EXPECT_EQ(
        CCManager::CCMemCopySync(dst, sizeof(dst), src, sizeof(src), RT_MEMCPY_HOST_TO_DEVICE),
        RT_ERROR_FEATURE_NOT_SUPPORT);
}

TEST_F(CCManagerTest, CheckMemAddrRangeValid_Cases)
{
    // ① 分配边界：恰好到尾部可以，超 1 字节拒绝，并核对查询的地址序列
    constexpr uint64_t allocBase = 0x1000U;
    constexpr size_t allocSize = 0x100U;
    constexpr uint64_t offset = 0x80U;
    MockMemGetAddressRange(allocBase, allocSize);

    const void* const address = RtValueToPtr<const void*>(allocBase + offset);
    EXPECT_EQ(CheckMemAddrRangeValid(address, allocSize - offset), RT_ERROR_NONE);
    EXPECT_EQ(CheckMemAddrRangeValid(address, allocSize - offset + 1U), RT_ERROR_DRV_ERR);
    ASSERT_EQ(gMemRangeStub.queriedAddrs.size(), 3U);
    EXPECT_EQ(gMemRangeStub.queriedAddrs[0], allocBase + offset);
    EXPECT_EQ(gMemRangeStub.queriedAddrs[1], allocBase + offset);
    EXPECT_EQ(gMemRangeStub.queriedAddrs[2], allocBase + allocSize);

    // ② 落在分配区间外（基址前 / 尾部后）一律拒绝
    MockMemGetAddressRange(0x2000U, 0x100U);
    EXPECT_EQ(CheckMemAddrRangeValid(RtValueToPtr<const void*>(0x2000U - 1U), 1U), RT_ERROR_DRV_ERR);
    EXPECT_EQ(CheckMemAddrRangeValid(RtValueToPtr<const void*>(0x2000U + 0x100U + 1U), 1U), RT_ERROR_DRV_ERR);
    EXPECT_EQ(gMemRangeStub.callCount, 2U);

    // ③ 驱动查询本身失败：错误码原样上抛
    MockMemGetAddressRange(0U, 0U, DRV_ERROR_NOT_SUPPORT);
    EXPECT_EQ(CheckMemAddrRangeValid(RtValueToPtr<const void*>(0x4000U), 1U), RT_ERROR_DRV_NOT_SUPPORT);
    EXPECT_EQ(gMemRangeStub.callCount, 1U);
}

TEST_F(CCManagerTest, CheckMemAddrRangeValid_ContinuousVmmMappings)
{
    constexpr uint64_t allocBase = 0x1000000U;
    constexpr size_t segmentSize = 2U * 1024U * 1024U;
    constexpr uint64_t copySize = 5U * 1024U * 1024U;
    MockMemGetAddressRanges({
        {allocBase, segmentSize},
        {allocBase + segmentSize, segmentSize},
        {allocBase + (2U * segmentSize), segmentSize},
    });

    EXPECT_EQ(CheckMemAddrRangeValid(RtValueToPtr<const void*>(allocBase), copySize), RT_ERROR_NONE);
    ASSERT_EQ(gMemRangeStub.queriedAddrs.size(), 3U);
    EXPECT_EQ(gMemRangeStub.queriedAddrs[0], allocBase);
    EXPECT_EQ(gMemRangeStub.queriedAddrs[1], allocBase + segmentSize);
    EXPECT_EQ(gMemRangeStub.queriedAddrs[2], allocBase + (2U * segmentSize));
}

TEST_F(CCManagerTest, CCMemCopy2DSync_ChecksDeviceAddressRange)
{
    uint8_t deviceBuffer[128] = {};
    uint8_t hostBuffer[128] = {};
    constexpr uint64_t pitch = 64U;
    constexpr uint64_t width = 32U;
    constexpr uint64_t height = 2U;
    constexpr size_t rangeSize = 96U;
    MockMemGetAddressRange(RtPtrToValue(deviceBuffer), rangeSize - 1U);

    EXPECT_EQ(
        CCManager::CCMemCopy2DSync(deviceBuffer, pitch, hostBuffer, pitch, width, height, RT_MEMCPY_HOST_TO_DEVICE),
        RT_ERROR_DRV_ERR);

    EXPECT_EQ(
        CCManager::CCMemCopy2DSync(hostBuffer, pitch, deviceBuffer, pitch, width, height, RT_MEMCPY_DEVICE_TO_HOST),
        RT_ERROR_DRV_ERR);
    ASSERT_EQ(gMemRangeStub.queriedAddrs.size(), 4U);
    EXPECT_EQ(gMemRangeStub.queriedAddrs[0], RtPtrToValue(deviceBuffer));
    EXPECT_EQ(gMemRangeStub.queriedAddrs[1], RtPtrToValue(deviceBuffer) + rangeSize - 1U);
    EXPECT_EQ(gMemRangeStub.queriedAddrs[2], RtPtrToValue(deviceBuffer));
    EXPECT_EQ(gMemRangeStub.queriedAddrs[3], RtPtrToValue(deviceBuffer) + rangeSize - 1U);
}

TEST_F(CCManagerTest, Manager_MemcpyEntryPoints_EmptyInputs)
{
    EXPECT_EQ(
        CCManager::CCMemcpyAsync(
            nullptr, 0U, nullptr, 0U, RT_MEMCPY_DEVICE_TO_DEVICE, nullptr, nullptr, nullptr, true, nullptr),
        RT_ERROR_CONTINUE_EXECUTE);
    EXPECT_EQ(
        CCManager::SubmitCcMemcpy2DTasks(nullptr, 0U, nullptr, 0U, 0U, 0U, nullptr, RT_MEMCPY_HOST_TO_DEVICE),
        RT_ERROR_INVALID_VALUE);

    rtMemcpyBatchAttr attrs[1]{};
    EXPECT_EQ(
        CCManager::SubmitCcMemcpyBatchTasks(
            nullptr, nullptr, nullptr, nullptr, 0U, attrs, nullptr, 0U, nullptr, nullptr),
        RT_ERROR_NONE);

    // MemSet 入参同样 fail-fast
    EXPECT_EQ(CCManager::CCDevMemSetAsync(nullptr, nullptr, 0U, 0U, 0U), RT_ERROR_STREAM_NULL);
    EXPECT_EQ(CCManager::CCDevMemSetD32(nullptr, 0U, 0U, 0U, nullptr, true), RT_ERROR_INVALID_VALUE);
}

TEST_F(CCManagerTest, Manager_RegCCManagerProcFunc_Fail)
{
    MOCKER_CPP(&DevInfoManage::RegDevInfoProcFunc).stubs().will(returnValue(false));
    EXPECT_EQ(RegCCManagerProcFunc(CHIP_DAVID), RT_ERROR_CC_INIT_FAILED);
}

TEST_F(CCManagerTest, Manager_GetOrCreateStreamResource_Integration)
{
    RETAIN_DEVICE(dev);
    Driver* realDriver = dev->Driver_();

    const rtChipType_t chipType = GetCurrentChipType();
    DevDynInfoProcFunc originalProcFunc{};
    ASSERT_EQ(GET_DEV_INFO_PROC_FUNC(chipType, originalProcFunc), RT_ERROR_NONE);
    const ScopeGuard restoreProcFunc([chipType, originalProcFunc]() {
        (void)DevInfoManage::Instance().RegDevInfoProcFunc(chipType, originalProcFunc);
    });

    // 经真实注册入口注册 CC 回调
    ASSERT_EQ(RegCCManagerProcFunc(chipType), RT_ERROR_NONE);
    DevDynInfoProcFunc registeredProcFunc{};
    ASSERT_EQ(GET_DEV_INFO_PROC_FUNC(chipType, registeredProcFunc), RT_ERROR_NONE);
    ASSERT_NE(registeredProcFunc.ccProcFunc.devResourceInit, nullptr);

    // 通过已注册的 devResourceInit 回调完成 per-device 资源初始化
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    MOCKER_CPP(&Runtime::StartAicpuSd).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(StreamLaunchCpuKernel).expects(once()).will(returnValue(RT_ERROR_NONE));
    Stream* const ctrlStm = dev->GetCtrlSQStream(nullptr);
    ASSERT_NE(ctrlStm, nullptr);
    MOCKER_CPP_VIRTUAL(ctrlStm, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    StubWorkerHostDriver(realDriver);
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemAllocWithBackupFlag).stubs().will(invoke(DevMemAllocEntryStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemAllocWithFlag).stubs().will(invoke(DevMemAllocStub));
    StubPcieAndFreeCounted(realDriver);

    ASSERT_EQ(registeredProcFunc.ccProcFunc.devResourceInit(dev), RT_ERROR_NONE);
    ASSERT_NE(CCManager::Instance().resources_[0], nullptr);
    CCResManage* manage = CCManager::Instance().resources_[0].get();

    // 真实流：创建 → DestroyStreamResource 释放
    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);

    CCStreamResManage* streamRes = nullptr;
    ASSERT_EQ(manage->GetOrCreateStreamResource(stm, streamRes), RT_ERROR_NONE);
    ASSERT_NE(streamRes, nullptr);
    EXPECT_EQ(stm->GetCCStreamResource(), streamRes);

    CCManager::DestroyStreamResource(stm);
    EXPECT_EQ(stm->GetCCStreamResource(), nullptr);

    rtStreamDestroy(stmHandle);
    registeredProcFunc.ccProcFunc.devResourceRelease(0U);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

// ============================================================================
// CC Dispatch Flow Tests (Host CC 检测 + 动态注册 + RawDevice 生命周期回调)
// ============================================================================

TEST_F(CCManagerTest, InitCcFeature_CcModeFlow)
{
    Runtime* const runtime = Runtime::Instance();
    ASSERT_NE(runtime, nullptr);

    // 测试点1：保存芯片函数表和可见设备环境变量，保证用例结束后恢复进程全局状态。
    const rtChipType_t chipType = GetCurrentChipType();
    DevDynInfoProcFunc originalProcFunc{};
    ASSERT_EQ(GET_DEV_INFO_PROC_FUNC(chipType, originalProcFunc), RT_ERROR_NONE);
    originalProcFunc.regCCFeatureProcFunc = &RegCCManagerProcFunc;
    ASSERT_TRUE(DevInfoManage::Instance().RegDevInfoProcFunc(chipType, originalProcFunc));
    const char_t* const visibleDevices = std::getenv("ASCEND_RT_VISIBLE_DEVICES");
    const bool visibleDevicesSet = visibleDevices != nullptr;
    const std::string originalVisibleDevices = visibleDevicesSet ? visibleDevices : "";
    ASSERT_EQ(unsetenv("ASCEND_RT_VISIBLE_DEVICES"), 0);
    const ScopeGuard restoreState([chipType, originalProcFunc, visibleDevicesSet, originalVisibleDevices]() {
        CCManager::ReleaseDeviceResource(0U);
        (void)DevInfoManage::Instance().RegDevInfoProcFunc(chipType, originalProcFunc);
        if (visibleDevicesSet) {
            (void)setenv("ASCEND_RT_VISIBLE_DEVICES", originalVisibleDevices.c_str(), 1);
        } else {
            (void)unsetenv("ASCEND_RT_VISIBLE_DEVICES");
        }
    });

    // 测试点2：模拟 /dev/sev-guest 存在，并配置一个可见 Device。
    uint32_t deviceCount = 1U;
    MOCKER(mmAccess2).expects(once()).will(invoke(CheckHostCcPathStub));
    MOCKER(drvGetDevNum)
        .expects(once())
        .with(outBoundP(&deviceCount, sizeof(deviceCount)))
        .will(returnValue(DRV_ERROR_NONE));

    // 测试点3：模拟所有可见 Device 均为 CC ON，并准备 Worker 资源所需的 Driver mock。
    MOCKER(halGetDeviceInfoByBuff).expects(once()).will(invoke(QueryCcInfoStub));
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    MOCKER_CPP(&Runtime::StartAicpuSd).stubs().will(returnValue(RT_ERROR_NONE));
    // 测试点5/6 分别会触发 load-key 与 crypto kernel 启动，均走 AICPU 内建算子通道。
    MOCKER(StreamLaunchCpuKernel).stubs().will(returnValue(RT_ERROR_NONE));

    // 测试点4：环境检测通过后，通过芯片函数表注册 CC 资源和内存分发回调。
    ASSERT_EQ(runtime->InitCcFeature(), RT_ERROR_NONE);
    DevDynInfoProcFunc registeredProcFunc{};
    ASSERT_EQ(GET_DEV_INFO_PROC_FUNC(chipType, registeredProcFunc), RT_ERROR_NONE);
    ASSERT_NE(registeredProcFunc.ccProcFunc.devResourceInit, nullptr);
    ASSERT_NE(registeredProcFunc.ccProcFunc.devResourceRelease, nullptr);
    ASSERT_NE(registeredProcFunc.memProcFunc.memcpyAsync, nullptr);

    // 测试点5：通过已注册的资源回调初始化当前 Device 的密钥和 6 Worker 线程池。
    RETAIN_DEVICE(dev);
    Stream* const ctrlStm = dev->GetCtrlSQStream(nullptr);
    ASSERT_NE(ctrlStm, nullptr);
    MOCKER_CPP_VIRTUAL(ctrlStm, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    StubWorkerHostDriverSimple(dev->Driver_());
    ASSERT_EQ(registeredProcFunc.ccProcFunc.devResourceInit(dev), RT_ERROR_NONE);

    // 测试点6：H2D MemcpyAsync 命中 CC 回调并完整走通提交链路；
    // Host 回调 / mem-wait（taskNum 门铃）/ crypto kernel 三条流任务提交边界均打桩，
    // 不产生真实流任务，避免 TearDown 复位时挂起。
    Api* const apiImpl = Runtime::Instance()->ApiImpl_();
    ASSERT_NE(apiImpl, nullptr);
    MOCKER_CPP_VIRTUAL(apiImpl, &Api::LaunchHostFunc).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(CondMemWaitValue).stubs().will(returnValue(RT_ERROR_NONE));
    ApiImplDavid apiImplDavid;
    EXPECT_EQ(
        apiImplDavid.MemcpyAsync(
            nullptr, 0U, nullptr, 0U, RT_MEMCPY_HOST_TO_DEVICE, nullptr, nullptr, nullptr, true, nullptr),
        RT_ERROR_NONE);

    // 测试点7：释放 default 流上挂载的 CC 流资源（此时 resources_[0] 仍有效，走正常释放路径）。
    Context* const curCtx = Runtime::Instance()->CurrentContext(true, DEFAULT_DEVICE_ID);
    if (curCtx != nullptr) {
        CCManager::DestroyStreamResource(curCtx->DefaultStream_());
    }

    // 测试点8：通过已注册的释放回调销毁当前 Device 的线程池并释放密钥。
    registeredProcFunc.ccProcFunc.devResourceRelease(0U);

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);

    // drvGetDevNum 的 expects(once()) 已被消费，TearDown 的 rtDeviceReset 还会再调，
    // 提前 reset 避免 mock 次数校验异常。
    GlobalMockObject::reset();
}

TEST_F(CCManagerTest, InitCcFeature_SysfsEnablePath)
{
    // 无 /dev/sev-guest 的 guest 环境：cvm_guest/mem_encrypt_enable=1 同样视为 CC 模式，
    // 且跳过设备 CC 状态查询。数据源经 RT_CC_SYSFS_CVM_ROOT 指向临时目录。
    Runtime* const runtime = Runtime::Instance();
    ASSERT_NE(runtime, nullptr);
    const rtChipType_t chipType = GetCurrentChipType();
    DevDynInfoProcFunc originalProcFunc{};
    ASSERT_EQ(GET_DEV_INFO_PROC_FUNC(chipType, originalProcFunc), RT_ERROR_NONE);
    originalProcFunc.regCCFeatureProcFunc = &RegCCManagerProcFunc;
    ASSERT_TRUE(DevInfoManage::Instance().RegDevInfoProcFunc(chipType, originalProcFunc));
    const ScopeGuard restoreProcFunc([chipType, originalProcFunc]() {
        (void)DevInfoManage::Instance().RegDevInfoProcFunc(chipType, originalProcFunc);
    });

    char sysfsDir[] = "/tmp/cvm_guest_ut_XXXXXX";
    ASSERT_NE(mkdtemp(sysfsDir), nullptr);
    FILE* const enableFp = fopen((std::string(sysfsDir) + "/mem_encrypt_enable").c_str(), "w");
    ASSERT_NE(enableFp, nullptr);
    ASSERT_EQ(fwrite("1\n", 1U, 2U, enableFp), 2U);
    (void)fclose(enableFp);
    ASSERT_EQ(setenv("RT_CC_SYSFS_CVM_ROOT", sysfsDir, 1), 0);
    const ScopeGuard restoreSysfs([sysfsDir]() {
        (void)unsetenv("RT_CC_SYSFS_CVM_ROOT");
        (void)remove((std::string(sysfsDir) + "/mem_encrypt_enable").c_str());
        (void)rmdir(sysfsDir);
    });

    // enable=1 路径同样会做可见设备 CC ON 检查：模拟 1 个 CC ON 的可见设备
    uint32_t deviceCount = 1U;
    MOCKER(drvGetDevNum)
        .expects(once())
        .with(outBoundP(&deviceCount, sizeof(deviceCount)))
        .will(returnValue(DRV_ERROR_NONE));
    MOCKER(halGetDeviceInfoByBuff).expects(once()).will(invoke(QueryCcInfoStub));

    // mem_encrypt_enable=1：注册成功
    ASSERT_EQ(runtime->InitCcFeature(), RT_ERROR_NONE);
    DevDynInfoProcFunc registeredProcFunc{};
    ASSERT_EQ(GET_DEV_INFO_PROC_FUNC(chipType, registeredProcFunc), RT_ERROR_NONE);
    ASSERT_NE(registeredProcFunc.memProcFunc.memcpyAsync, nullptr);
    GlobalMockObject::reset();
}

TEST_F(CCManagerTest, RawDeviceDestructor_ReleasesCcResource)
{
    const rtChipType_t chipType = GetCurrentChipType();
    DevDynInfoProcFunc originalProcFunc{};
    ASSERT_EQ(GET_DEV_INFO_PROC_FUNC(chipType, originalProcFunc), RT_ERROR_NONE);
    const ScopeGuard restoreProcFunc([chipType, originalProcFunc]() {
        (void)DevInfoManage::Instance().RegDevInfoProcFunc(chipType, originalProcFunc);
    });

    DevDynInfoProcFunc procFunc = originalProcFunc;
    procFunc.ccProcFunc.devResourceRelease = &ReleaseCcResourceStub;
    ASSERT_TRUE(DevInfoManage::Instance().RegDevInfoProcFunc(chipType, procFunc));
    {
        RawDevice device(0U);
        device.chipType_ = chipType;
    }

    EXPECT_EQ(gCcResourceReleaseCount, 1U);
}

TEST_F(CCManagerTest, ContextCreate_InitializesCcResource)
{
    ASSERT_EQ(Runtime::Instance()->GetDevice(CC_TEST_DEVICE_ID, RT_TSC_ID, false), nullptr);

    const rtChipType_t chipType = GetCurrentChipType();
    DevDynInfoProcFunc originalProcFunc{};
    ASSERT_EQ(GET_DEV_INFO_PROC_FUNC(chipType, originalProcFunc), RT_ERROR_NONE);
    const ScopeGuard restoreProcFunc([chipType, originalProcFunc]() {
        (void)DevInfoManage::Instance().RegDevInfoProcFunc(chipType, originalProcFunc);
    });

    DevDynInfoProcFunc procFunc = originalProcFunc;
    procFunc.ccProcFunc.devResourceInit = &InitCcResourceStub;
    ASSERT_TRUE(DevInfoManage::Instance().RegDevInfoProcFunc(chipType, procFunc));

    rtContext_t context = nullptr;
    ASSERT_EQ(rtCtxCreate(&context, 0U, static_cast<int32_t>(CC_TEST_DEVICE_ID)), RT_ERROR_NONE);
    ASSERT_NE(context, nullptr);
    const ScopeGuard destroyContext([&context]() {
        if (context != nullptr) {
            (void)rtCtxDestroy(context);
        }
    });
    EXPECT_EQ(gCcResourceInitCount, 1U);
    EXPECT_EQ(rtCtxDestroy(context), RT_ERROR_NONE);
    context = nullptr;
}

TEST_F(CCManagerTest, ContextCreate_FailsWhenCcResourceInitFails)
{
    ASSERT_EQ(Runtime::Instance()->GetDevice(CC_TEST_DEVICE_ID, RT_TSC_ID, false), nullptr);

    const rtChipType_t chipType = GetCurrentChipType();
    DevDynInfoProcFunc originalProcFunc{};
    ASSERT_EQ(GET_DEV_INFO_PROC_FUNC(chipType, originalProcFunc), RT_ERROR_NONE);
    const ScopeGuard restoreProcFunc([chipType, originalProcFunc]() {
        (void)DevInfoManage::Instance().RegDevInfoProcFunc(chipType, originalProcFunc);
    });

    DevDynInfoProcFunc procFunc = originalProcFunc;
    procFunc.ccProcFunc.devResourceInit = &InitCcResourceFailedStub;
    ASSERT_TRUE(DevInfoManage::Instance().RegDevInfoProcFunc(chipType, procFunc));

    rtContext_t context = nullptr;
    EXPECT_NE(rtCtxCreate(&context, 0U, static_cast<int32_t>(CC_TEST_DEVICE_ID)), RT_ERROR_NONE);
    EXPECT_EQ(context, nullptr);
    EXPECT_EQ(gCcResourceInitCount, 1U);
    if (context != nullptr) {
        (void)rtCtxDestroy(context);
    }
}

TEST_F(CCManagerTest, InitCcFeature_HostCcOffWhenNoCcSignal)
{
    Runtime* const runtime = Runtime::Instance();
    ASSERT_NE(runtime, nullptr);
    const rtChipType_t chipType = GetCurrentChipType();
    DevDynInfoProcFunc originalProcFunc{};
    ASSERT_EQ(GET_DEV_INFO_PROC_FUNC(chipType, originalProcFunc), RT_ERROR_NONE);
    DevDynInfoProcFunc procFunc = originalProcFunc;
    procFunc.regCCFeatureProcFunc = &RegCCManagerProcFunc;
    ASSERT_TRUE(DevInfoManage::Instance().RegDevInfoProcFunc(chipType, procFunc));
    const ScopeGuard restoreProcFunc([chipType, originalProcFunc]() {
        (void)DevInfoManage::Instance().RegDevInfoProcFunc(chipType, originalProcFunc);
    });

    // 无 /dev/sev-guest 且 sysfs 节点不存在：Host 判定为非 CC，InitCcFeature 返回成功且不注册 CC 资源。
    MOCKER(mmAccess2).stubs().will(returnValue(EN_ERROR));
    ASSERT_EQ(runtime->InitCcFeature(), RT_ERROR_NONE);

    DevDynInfoProcFunc curProcFunc{};
    ASSERT_EQ(GET_DEV_INFO_PROC_FUNC(chipType, curProcFunc), RT_ERROR_NONE);
    EXPECT_EQ(curProcFunc.ccProcFunc.devResourceInit, originalProcFunc.ccProcFunc.devResourceInit);
    GlobalMockObject::reset();
}

TEST_F(CCManagerTest, InitCcFeature_HostCcSysfsUnreadableIsNotCc)
{
    constexpr const char_t* ccSysfsPath = "/sys/kernel/security/cvm_guest/mem_encrypt_enable";
    if (access(ccSysfsPath, F_OK) == 0) {
        GTEST_SKIP() << "CC sysfs node exists on this host, skip unreadable scenario.";
    }

    Runtime* const runtime = Runtime::Instance();
    ASSERT_NE(runtime, nullptr);
    const rtChipType_t chipType = GetCurrentChipType();
    DevDynInfoProcFunc originalProcFunc{};
    ASSERT_EQ(GET_DEV_INFO_PROC_FUNC(chipType, originalProcFunc), RT_ERROR_NONE);
    DevDynInfoProcFunc procFunc = originalProcFunc;
    procFunc.regCCFeatureProcFunc = &RegCCManagerProcFunc;
    ASSERT_TRUE(DevInfoManage::Instance().RegDevInfoProcFunc(chipType, procFunc));
    const ScopeGuard restoreProcFunc([chipType, originalProcFunc]() {
        (void)DevInfoManage::Instance().RegDevInfoProcFunc(chipType, originalProcFunc);
    });

    // sev-guest 不存在，sysfs 节点被判为存在但实际读取失败：按非 CC 处理，不注册 CC 资源。
    MOCKER(mmAccess2).stubs().will(invoke(CheckCcSysfsExistsStub));
    ASSERT_EQ(runtime->InitCcFeature(), RT_ERROR_NONE);

    DevDynInfoProcFunc curProcFunc{};
    ASSERT_EQ(GET_DEV_INFO_PROC_FUNC(chipType, curProcFunc), RT_ERROR_NONE);
    EXPECT_EQ(curProcFunc.ccProcFunc.devResourceInit, originalProcFunc.ccProcFunc.devResourceInit);
    GlobalMockObject::reset();
}

TEST_F(CCManagerTest, QueryDeviceCcStatus_MapsDriverModes)
{
    MOCKER(halGetDeviceInfoByBuff).stubs().will(invoke(QueryCcInfoStub));
    bool ccOn = false;

    EXPECT_EQ(NpuDriver::QueryDeviceCcStatus(0U, ccOn), RT_ERROR_NONE);
    EXPECT_TRUE(ccOn);

    gCcMode = HAL_CC_MODE_ADDITIONAL;
    EXPECT_EQ(NpuDriver::QueryDeviceCcStatus(0U, ccOn), RT_ERROR_NONE);
    EXPECT_TRUE(ccOn);

    gCcMode = HAL_CC_MODE_OFF;
    EXPECT_EQ(NpuDriver::QueryDeviceCcStatus(0U, ccOn), RT_ERROR_NONE);
    EXPECT_FALSE(ccOn);

    gCcQueryResult = DRV_ERROR_INVALID_VALUE;
    EXPECT_NE(NpuDriver::QueryDeviceCcStatus(0U, ccOn), RT_ERROR_NONE);
    EXPECT_FALSE(ccOn);
}

TEST_F(CCManagerTest, ThreadPool_ElasticGrowAndIdleRetire)
{
    ThreadPool pool;
    // 核心 1 条，上限 4 条，非核心线程空闲 1 s 后退出（缩短用例时长）
    ASSERT_EQ(pool.Init("CC_POOL_UT", 1U, 4U, 1U), RT_ERROR_NONE);
    EXPECT_EQ(pool.ThreadCount(), 1U);

    // 4 个任务各占住一条线程，队列持续积压 → 扩到上限
    const auto runBlockingBurst = [&pool]() {
        std::mutex taskMutex;
        std::condition_variable taskCv;
        bool release = false;
        std::vector<std::future<void>> futures;
        for (uint32_t i = 0U; i < 4U; ++i) {
            std::future<void> future = pool.Submit([&taskMutex, &taskCv, &release]() {
                std::unique_lock<std::mutex> lock(taskMutex);
                taskCv.wait(lock, [&release]() { return release; });
            });
            EXPECT_TRUE(future.valid());
            futures.push_back(std::move(future));
        }
        for (uint32_t i = 0U; (i < 200U) && (pool.ThreadCount() < 4U); ++i) {
            std::this_thread::sleep_for(std::chrono::milliseconds(10));
        }
        EXPECT_EQ(pool.ThreadCount(), 4U);
        {
            std::lock_guard<std::mutex> lock(taskMutex);
            release = true;
        }
        taskCv.notify_all();
        for (auto& future : futures) {
            future.get();
        }
    };

    const auto waitForRetire = [&pool]() {
        for (uint32_t i = 0U; (i < 200U) && (pool.ThreadCount() > 1U); ++i) {
            std::this_thread::sleep_for(std::chrono::milliseconds(20));
        }
        EXPECT_EQ(pool.ThreadCount(), 1U);
    };

    runBlockingBurst();
    waitForRetire();

    // 再扩一轮：扩容前回收上一轮退休的 Thread/runner，池内对象数不随"扩了又退"的轮次增长
    runBlockingBurst();
    EXPECT_LE(pool.workers_.size(), 4U);
    waitForRetire();
    EXPECT_LE(pool.workers_.size(), 4U);
    pool.Shutdown();
}

TEST_F(CCManagerTest, ThreadPool_ShutdownFromWorkerThread)
{
    // 池内 Shutdown 只请求停止，线程由下一次外部 Shutdown/Init 统一回收。
    ThreadPool pool;
    ASSERT_EQ(pool.Init("CC_POOL_UT", 1U, 4U, 1U), RT_ERROR_NONE);
    EXPECT_EQ(pool.ThreadCount(), 1U);

    std::future<void> future = pool.Submit([&pool]() { pool.Shutdown(); });
    ASSERT_TRUE(future.valid());
    future.get();

    EXPECT_FALSE(pool.IsRunning());
    EXPECT_EQ(pool.PendingCount(), 0U);
    EXPECT_FALSE(pool.workers_.empty());

    // 重新 Init：先回收上一次遗留的调用线程，池恢复可用
    ASSERT_EQ(pool.Init("CC_POOL_UT", 1U, 4U, 1U), RT_ERROR_NONE);
    EXPECT_TRUE(pool.IsRunning());
    EXPECT_EQ(pool.ThreadCount(), 1U);

    std::atomic<uint32_t> counter{0U};
    std::future<void> again = pool.Submit([&counter]() { (void)counter.fetch_add(1U); });
    ASSERT_TRUE(again.valid());
    again.get();
    EXPECT_EQ(counter.load(), 1U);
    pool.Shutdown();
    EXPECT_EQ(pool.idleThreads_, 0U);
    EXPECT_EQ(pool.ThreadCount(), 0U);
}

TEST_F(CCManagerTest, ThreadPool_RejectZeroTimeoutAndWorkerInit)
{
    ThreadPool pool;
    EXPECT_EQ(pool.Init("CC_POOL_UT", 1U, 2U, 0U), RT_ERROR_INVALID_VALUE);
    EXPECT_FALSE(pool.IsRunning());
    ASSERT_EQ(pool.Init("CC_POOL_UT", 1U), RT_ERROR_NONE);
    auto future = pool.Submit([&pool]() {
        EXPECT_EQ(pool.Init("CC_POOL_UT", 1U), RT_ERROR_INVALID_VALUE);
        EXPECT_TRUE(pool.IsRunning());
    });
    future.get();
}

TEST_F(CCManagerTest, ThreadPool_GrowFailureKeepsQueuedTask)
{
    ThreadPool pool;
    ASSERT_EQ(pool.Init("CC_POOL_UT", 1U, 4U), RT_ERROR_NONE);
    MOCKER(OsalFactory::CreateThread).stubs().will(returnValue(static_cast<Thread*>(nullptr)));
    std::promise<void> entered;
    std::promise<void> release;
    auto gate = release.get_future();
    auto first = pool.Submit([&entered, &gate]() {
        entered.set_value();
        gate.wait();
    });
    entered.get_future().wait();
    std::atomic<bool> completed{false};
    auto queued = pool.Submit([&completed]() { completed.store(true); });
    EXPECT_EQ(pool.ThreadCount(), 1U);
    release.set_value();
    first.get();
    queued.get();
    EXPECT_TRUE(completed.load());
    pool.Shutdown();
    EXPECT_EQ(pool.idleThreads_, 0U);
    EXPECT_EQ(pool.ThreadCount(), 0U);
}

TEST_F(CCManagerTest, ThreadPool_ConcurrentWorkerShutdown)
{
    ThreadPool pool;
    ASSERT_EQ(pool.Init("CC_POOL_UT", 2U), RT_ERROR_NONE);
    std::promise<void> release;
    auto gate = release.get_future().share();
    std::atomic<uint32_t> entered{0U};
    const auto stop = [&]() {
        entered.fetch_add(1U);
        gate.wait();
        pool.Shutdown();
    };
    auto first = pool.Submit(stop);
    auto second = pool.Submit(stop);
    while (entered.load() != 2U) {
        std::this_thread::yield();
    }
    release.set_value();
    first.get();
    second.get();
    pool.Shutdown();
    EXPECT_FALSE(pool.IsRunning());
    EXPECT_EQ(pool.ThreadCount(), 0U);
}

TEST_F(CCManagerTest, ThreadPool_DestroyFromWorker)
{
    auto* pool = new ThreadPool;
    ASSERT_EQ(pool->Init("CC_SELF_UT", 2U), RT_ERROR_NONE);
    std::promise<mmThread> threadId;
    auto done = pool->Submit([pool, &threadId]() {
        threadId.set_value(pthread_self());
        delete pool;
    });
    const mmThread id = threadId.get_future().get();
    done.get();
    auto* guard = Runtime::Instance()->GetThreadGuard();
    for (uint32_t i = 0U; (i < 200U) && guard->FindThreadTid(id); ++i) {
        std::this_thread::sleep_for(std::chrono::milliseconds(5));
    }
    EXPECT_FALSE(guard->FindThreadTid(id));
}
