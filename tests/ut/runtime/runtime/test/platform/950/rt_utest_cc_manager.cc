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
#include <cstdlib>
#include <string>
#include <cstring>
#include <vector>

#include "securec.h"
#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#include "api_impl.hpp"
#include "api_impl_david.hpp"
#include "aicpu_c.hpp"
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
#include "crypto/cc_crypto.h"
#include "cc_stream_res_manage.h"
#include "cc_task_queue.h"
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

namespace {
hal_cc_mode_type gCcMode = HAL_CC_MODE_NORMAL;
drvError_t gCcQueryResult = DRV_ERROR_NONE;
uint32_t gCcResourceReleaseCount = 0U;
uint32_t gDevMemAllocCount = 0U;
bool gReturnNullDriver = false;
bool gPcieRegFail = false;
bool gPcieMappedNull = false;
uint32_t gDevMemFreeCount = 0U;
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
CCSliceQueue* gObservedD2HQueue = nullptr;
uint32_t gExpectedD2HSlice = UINT32_MAX;
uint8_t gExpectedD2HHead = 0U;
uint8_t gExpectedD2HTail = 0U;
std::atomic<bool> gExpectedD2HSlicePublishedAtDma{false};
std::atomic<bool> gAllowD2HNextConsume{false};

drvError_t DrvMemcpyStub(DVdeviceptr dst, size_t destMax, DVdeviceptr src, size_t count)
{
    if (gDrvMemcpyFail || (dst == 0U) || (src == 0U) || (count > destMax)) {
        return DRV_ERROR_INVALID_VALUE;
    }
    (void)memcpy_s(RtValueToPtr<void*>(dst), destMax, RtValueToPtr<void*>(src), count);
    if (dst == gObservedD2HDst.load()) {
        const bool isPublished = (gObservedD2HQueue != nullptr) && (gObservedD2HQueue->head == gExpectedD2HHead) &&
                                 (gObservedD2HQueue->tail == gExpectedD2HTail) &&
                                 (gObservedD2HQueue->sliceDesc[gExpectedD2HTail].sliceIdx == gExpectedD2HSlice);
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
    (void)deviceId;
    ++gDevMemFreeCount;
    return RT_ERROR_NONE;
}

int32_t CheckHostCcPathStub(const char_t* const path, const int32_t mode)
{
    EXPECT_STREQ(path, "/dev/sev-guest");
    EXPECT_EQ(mode, M_F_OK);
    return EN_OK;
}

void ReleaseCcResourceStub(const uint32_t deviceId)
{
    EXPECT_EQ(deviceId, 0U);
    ++gCcResourceReleaseCount;
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
    (void)size;
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

// 辅助线程模拟 AICPU 侧行为：从 sliceDesc[tail] 消费 Host 发布的任务并推进 tail。
class AicpuSimulator {
public:
    static void RunH2DConsumer(
        CCSliceQueue* queue, uint32_t totalSlices, const std::atomic<bool>& stop, std::atomic<uint32_t>& consumedCount)
    {
        while (!stop.load() && (consumedCount.load() < totalSlices)) {
            const uint8_t head = queue->head;
            const uint8_t tail = queue->tail;
            if (head != tail) {
                queue->tail = static_cast<uint8_t>((tail + 1U) % CC_SLICE_DESC_SLOT_NUM);
                consumedCount.fetch_add(1U, std::memory_order_relaxed);
            }
            std::this_thread::sleep_for(std::chrono::milliseconds(1));
        }
    }

    static void RunD2HConsumer(
        CCSliceQueue* queue, const uint8_t* plaintextBase, const uint8_t* bufA, const uint8_t* bufB,
        const std::vector<uint32_t>& sliceLens, const std::atomic<bool>& stop, std::atomic<uint32_t>& consumedCount,
        std::atomic<bool>& descriptorValid)
    {
        while (!stop.load() && (queue->totalSlices == 0U)) {
            std::this_thread::sleep_for(std::chrono::milliseconds(1));
        }
        size_t offset = 0U;
        for (uint32_t sliceIdx = 0U; (sliceIdx < sliceLens.size()) && !stop.load(); ++sliceIdx) {
            while (!stop.load() && (queue->head == queue->tail)) {
                std::this_thread::sleep_for(std::chrono::milliseconds(1));
            }
            if (stop.load()) {
                return;
            }

            const uint8_t tail = queue->tail;
            const CCSliceDesc& info = queue->sliceDesc[tail];
            const uint8_t* expectedBuf = (sliceIdx % 2U) == 0U ? bufA : bufB;
            const uint32_t sliceLen = sliceLens[sliceIdx];
            if ((info.sliceIdx != sliceIdx) || (info.ciphertextAddr != PtrToValue(expectedBuf)) ||
                (info.plaintextAddr != PtrToValue(plaintextBase + offset)) || (info.plaintextLen != sliceLen) ||
                (info.ciphertextLen != CC_CIPHER_HEADER_SIZE + sliceLen)) {
                descriptorValid.store(false);
            }
            offset += sliceLen;
            queue->tail = static_cast<uint8_t>((tail + 1U) % CC_SLICE_DESC_SLOT_NUM);
            consumedCount.fetch_add(1U, std::memory_order_relaxed);
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

} // namespace
// 由 stub/cc_crypto_stub.cc 提供，控制 OpenSSLLoader 是否就绪
namespace cce {
namespace runtime {
void SetOpenSSLLoaderReady(bool ready);
}
} // namespace cce

class CCManagerTest : public testing::Test {
protected:
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
        gDevMemAllocCount = 0U;
        gReturnNullDriver = false;
        gPcieRegFail = false;
        gPcieMappedNull = false;
        gDevMemFreeCount = 0U;
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
        MOCKER(drvMemcpy).stubs().will(invoke(DrvMemcpyStub));
        std::cout << "ut test start." << std::endl;
    }

    virtual void TearDown()
    {
        CCManager::ReleaseDeviceResource(0U);
        rtDeviceReset(0);
        Runtime* rtInstance = (Runtime*)Runtime::Instance();
        rtInstance->SetChipType(oldChipType);
        GlobalContainer::SetRtChipType(oldChipType);
        GlobalMockObject::verify();
        std::cout << "ut test end." << std::endl;
    }

    static rtChipType_t GetCurrentChipType() { return Runtime::Instance()->GetChipType(); }

private:
    rtChipType_t oldChipType;
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
    CCSliceQueue queue{};
    queue.depth = 3;
    queue.head = 0;
    queue.tail = 0;

    EXPECT_TRUE(queue.IsEmpty());
    EXPECT_FALSE(queue.IsFull());

    queue.head = 1;
    EXPECT_FALSE(queue.IsEmpty());
    EXPECT_FALSE(queue.IsFull());

    queue.head = 2;
    EXPECT_TRUE(queue.IsFull());
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

TEST_F(CCManagerTest, Crypto_ReleaseKey_Basic)
{
    CCrypto crypto;
    uint32_t deviceId = 0;

    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    crypto.InitKey(deviceId);

    rtError_t ret = crypto.ReleaseKey(deviceId);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(CCManagerTest, Crypto_Encrypt_NullParams)
{
    CCrypto crypto;
    uint32_t deviceId = 0;
    uint8_t plaintext[16] = {0};
    uint8_t ciphertext[64] = {0};
    size_t ctLen = sizeof(ciphertext);

    rtError_t ret = crypto.Encrypt(deviceId, nullptr, 16, nullptr, 0, ciphertext, &ctLen);
    EXPECT_NE(ret, RT_ERROR_NONE);

    ret = crypto.Encrypt(deviceId, plaintext, 16, nullptr, 0, nullptr, &ctLen);
    EXPECT_NE(ret, RT_ERROR_NONE);

    ret = crypto.Encrypt(deviceId, plaintext, 16, nullptr, 0, ciphertext, nullptr);
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

    rtError_t ret = crypto.Encrypt(deviceId, plaintext, sizeof(plaintext), nullptr, 0, ciphertext, &ctLen);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    // 真实实现输出 84B CCCipherTxtHeader + 密文（密文长度 == 明文长度）
    EXPECT_EQ(ctLen, sizeof(CCCipherTxtHeader) + sizeof(plaintext));

    uint8_t decrypted[32] = {0};
    size_t ptLen = sizeof(decrypted);
    ret = crypto.Decrypt(deviceId, ciphertext, ctLen, nullptr, 0, decrypted, &ptLen);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(ptLen, sizeof(plaintext));
    EXPECT_EQ(memcmp(plaintext, decrypted, sizeof(plaintext)), 0);
}

TEST_F(CCManagerTest, Crypto_BuildDeviceCryptoParam_Basic)
{
    CCrypto crypto;
    uint32_t deviceId = 0;

    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    crypto.InitKey(deviceId);

    CCCryptoKernelParam param{};
    rtError_t ret = crypto.BuildDeviceCryptoParam(deviceId, CC_CRYPTO_MODE::ENCRYPT_MODE, &param);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(param.mode, static_cast<uint32_t>(CC_CRYPTO_MODE::ENCRYPT_MODE));
    EXPECT_EQ(param.algType, static_cast<uint32_t>(CC_CRYPTO_ALG_TYPE::AES_128_GCM));
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

// ============================================================================
// CCStreamResManage Tests
// ============================================================================

TEST_F(CCManagerTest, StreamResManage_Init_NullDevice)
{
    CCStreamResManage resource;
    rtError_t ret = resource.Init(nullptr);
    EXPECT_EQ(ret, RT_ERROR_DEVICE_NULL);
}

TEST_F(CCManagerTest, StreamResManage_Init_Destroy)
{
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    EXPECT_NE(dev, (Device*)nullptr);

    CCStreamResManage resource;

    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAllocWithBackupFlag).stubs().will(invoke(DevMemAllocEntryStub));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::PcieHostRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::PcieHostUnRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemFree).stubs().will(returnValue(RT_ERROR_NONE));

    rtError_t ret = resource.Init(dev);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    // Init 应完成队列深度设置和任务槽清零。
    CCSliceQueue* queue = resource.Queue();
    EXPECT_NE(queue, nullptr);
    EXPECT_EQ(queue->depth, static_cast<uint8_t>(CC_SLICE_DESC_SLOT_NUM));
    EXPECT_EQ(resource.DeviceQueueAddr(), PtrToValue(resource.barDeviceAddr_));
    CCSliceDesc* sliceDesc = resource.SliceDesc();
    EXPECT_NE(sliceDesc, nullptr);
    for (uint32_t i = 0U; i < CC_SLICE_DESC_SLOT_NUM; ++i) {
        EXPECT_EQ(sliceDesc[i].ciphertextAddr, 0U);
    }

    resource.Destroy();

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, StreamResManage_Reset)
{
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    EXPECT_NE(dev, (Device*)nullptr);

    CCStreamResManage resource;

    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAllocWithBackupFlag).stubs().will(invoke(DevMemAllocEntryStub));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::PcieHostRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::PcieHostUnRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemFree).stubs().will(returnValue(RT_ERROR_NONE));

    ASSERT_EQ(resource.Init(dev), RT_ERROR_NONE);

    CCSliceQueue* queue = resource.Queue();
    ASSERT_NE(queue, nullptr);
    queue->head = 2;
    queue->tail = 1;
    queue->totalSlices = 3;

    resource.Reset();

    EXPECT_EQ(queue->head, 0U);
    EXPECT_EQ(queue->tail, 0U);
    EXPECT_EQ(queue->totalSlices, 0U);
    EXPECT_EQ(queue->depth, static_cast<uint8_t>(CC_SLICE_DESC_SLOT_NUM));

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, StreamResManage_Init_AllocFails)
{
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    EXPECT_NE(dev, (Device*)nullptr);

    CCStreamResManage resource;

    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAllocWithBackupFlag)
        .stubs()
        .will(returnValue(RT_ERROR_MEMORY_ALLOCATION));

    rtError_t ret = resource.Init(dev);
    EXPECT_NE(ret, RT_ERROR_NONE);

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, StreamResManage_Init_ErrorPaths)
{
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, (Device*)nullptr);
    Driver* realDriver = dev->Driver_();

    MOCKER_CPP_VIRTUAL(dev, &Device::Driver_).stubs().will(invoke(FakeDeviceDriverStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemAllocWithBackupFlag).stubs().will(invoke(DevMemAllocEntryStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostRegister).stubs().will(invoke(PcieHostRegisterStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostUnRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemFree).stubs().will(invoke(DevMemFreeStub));

    // ① device->Driver_() 为空
    gReturnNullDriver = true;
    {
        CCStreamResManage resource;
        EXPECT_EQ(resource.Init(dev), RT_ERROR_DRV_NULL);
    }

    // ② PCIe BAR 寄存器映射失败：初始化失败且已申请的设备内存被回滚释放
    gReturnNullDriver = false;
    gPcieRegFail = true;
    gDevMemFreeCount = 0U;
    {
        CCStreamResManage resource;
        EXPECT_NE(resource.Init(dev), RT_ERROR_NONE);
        EXPECT_EQ(gDevMemFreeCount, 1U);
    }

    // ③ 映射地址为空：回退使用设备地址，Init 成功
    gPcieRegFail = false;
    gPcieMappedNull = true;
    {
        CCStreamResManage resource;
        EXPECT_EQ(resource.Init(dev), RT_ERROR_NONE);
        EXPECT_EQ(resource.barHostAddr_, resource.barDeviceAddr_);
        EXPECT_NE(resource.Queue(), nullptr);
        resource.Destroy();
    }

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, StreamResManage_BasicLifeCycle)
{
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, (Device*)nullptr);
    Driver* realDriver = dev->Driver_();

    CCStreamResManage resource;
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemAllocWithBackupFlag).stubs().will(invoke(DevMemAllocEntryStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostRegister).stubs().will(invoke(PcieHostRegisterStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostUnRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemFree).stubs().will(invoke(DevMemFreeStub));

    ASSERT_EQ(resource.Init(dev), RT_ERROR_NONE);
    EXPECT_EQ(resource.DeviceQueueAddr(), PtrToValue(resource.barDeviceAddr_));
    EXPECT_NE(resource.Queue(), nullptr);
    EXPECT_NE(resource.SliceDesc(), nullptr);

    // ① Destroy 幂等：两次调用设备内存只释放一次，随后查询返回空
    gDevMemFreeCount = 0U;
    resource.Destroy();
    resource.Destroy();
    EXPECT_EQ(gDevMemFreeCount, 1U);
    EXPECT_EQ(resource.Queue(), nullptr);
    EXPECT_EQ(resource.SliceDesc(), nullptr);

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

    rtError_t ret = worker.Init(0, 1024, &queue, nullptr, &crypto);
    EXPECT_EQ(ret, RT_ERROR_DEVICE_NULL);
}

TEST_F(CCManagerTest, Worker_Init_Destroy)
{
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    EXPECT_NE(dev, (Device*)nullptr);

    CCWorker worker;
    CCMemcpyTaskQueue queue;
    CCrypto crypto;

    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostMemAlloc).stubs().will(invoke(HostMemAllocStub));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostDmaMap).stubs().will(invoke(HostDmaMapStub));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostDmaUnmap).stubs().will(invoke(HostDmaUnmapStub));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostMemFree).stubs().will(invoke(HostMemFreeStub));

    rtError_t ret = worker.Init(0, 1024, &queue, dev, &crypto);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_NE(worker.GetHostCryptoBuf(), nullptr);

    queue.Shutdown();
    worker.Destroy();
    worker.Destroy();
    EXPECT_EQ(gHostDmaUnmapCount, 1U);
    EXPECT_EQ(gHostMemFreeCount, 1U);

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Worker_Init_HostMemAllocFails)
{
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    EXPECT_NE(dev, (Device*)nullptr);

    CCWorker worker;
    CCMemcpyTaskQueue queue;
    CCrypto crypto;

    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostMemAlloc).stubs().will(returnValue(RT_ERROR_MEMORY_ALLOCATION));

    rtError_t ret = worker.Init(0, 1024, &queue, dev, &crypto);
    EXPECT_NE(ret, RT_ERROR_NONE);

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Worker_Init_ErrorPaths)
{
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, (Device*)nullptr);
    Driver* realDriver = dev->Driver_();

    // ① crypto 为空
    {
        CCWorker worker;
        CCMemcpyTaskQueue queue;
        EXPECT_EQ(worker.Init(0, 1024, &queue, dev, nullptr), RT_ERROR_INVALID_VALUE);
    }

    MOCKER_CPP_VIRTUAL(realDriver, &Driver::HostMemAlloc).stubs().will(invoke(HostMemAllocStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::HostDmaMap).stubs().will(invoke(HostDmaMapStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::HostDmaUnmap).stubs().will(invoke(HostDmaUnmapStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::HostMemFree).stubs().will(invoke(HostMemFreeStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemAllocWithBackupFlag).stubs().will(invoke(DevMemAllocEntryStub));

    // ② HostDmaMap 失败：hostCryptoBuf 已申请，需 HostMemFree 回滚
    {
        CCWorker worker;
        CCMemcpyTaskQueue queue;
        CCrypto crypto;
        gHostDmaMapFail = true;
        gHostMemFreeCount = 0U;
        EXPECT_NE(worker.Init(0, 1024, &queue, dev, &crypto), RT_ERROR_NONE);
        EXPECT_EQ(gHostDmaUnmapCount, 0U);
        EXPECT_EQ(gHostMemFreeCount, 1U);
    }

    // ③ Device Buffer 申请失败：HostDmaMap 已成功，需 HostDmaUnmap + HostMemFree 回滚
    {
        CCWorker worker;
        CCMemcpyTaskQueue queue;
        CCrypto crypto;
        gHostDmaMapFail = false;
        gDevMemAllocReturnFail = true;
        gHostDmaUnmapCount = 0U;
        gHostMemFreeCount = 0U;
        EXPECT_NE(worker.Init(0, 1024, &queue, dev, &crypto), RT_ERROR_NONE);
        EXPECT_EQ(gHostDmaUnmapCount, 1U);
        EXPECT_EQ(gHostMemFreeCount, 1U);
        gDevMemAllocReturnFail = false;
    }

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Worker_ShouldWorkerExit_Branches)
{
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, (Device*)nullptr);

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
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, (Device*)nullptr);
    Driver* realDriver = dev->Driver_();

    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());

    CCrypto crypto;
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    crypto.InitKey(0);

    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostRegister).stubs().will(invoke(PcieHostRegisterStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostUnRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemFree).stubs().will(invoke(DevMemFreeStub));

    CCWorker worker;
    worker.device_ = dev;
    worker.crypto_ = &crypto;
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

    // ③ 挂 CC 资源成功路径：totalSlices/sliceNum/memWaitVal/deadline
    CCStreamResManage streamRes;
    ASSERT_EQ(streamRes.Init(dev), RT_ERROR_NONE);
    stm->SetCCStreamResource(&streamRes);

    task.totalSize = CC_PLAINTEXT_SLICE_SIZE * 2U + 1U;
    task.kind = RT_MEMCPY_HOST_TO_DEVICE;
    EXPECT_EQ(worker.SetupTask(task, stream, resource, sliceNum), RT_ERROR_NONE);
    EXPECT_EQ(resource, &streamRes);
    EXPECT_EQ(sliceNum, 3U);
    EXPECT_EQ(resource->Queue()->totalSlices, 3U);
    EXPECT_EQ(resource->Queue()->memWaitVal, 1U);
    EXPECT_NE(worker.deadlineMs_, 0U);

    // 清理：先取回 CC 资源防止 Stream 析构产生泄漏
    (void)stm->TakeCCStreamResource();
    rtStreamDestroy(stmHandle);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Worker_ProcessH2DSlice_Success)
{
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, (Device*)nullptr);
    Driver* realDriver = dev->Driver_();

    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());

    CCrypto crypto;
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    crypto.InitKey(0);

    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostRegister).stubs().will(invoke(PcieHostRegisterStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostUnRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemFree).stubs().will(invoke(DevMemFreeStub));

    CCStreamResManage streamRes;
    ASSERT_EQ(streamRes.Init(dev), RT_ERROR_NONE);
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
    worker.crypto_ = &crypto;
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

    CCSliceQueue* taskQueue = streamRes.Queue();
    EXPECT_EQ(taskQueue->head, 1U);
    CCSliceDesc* const sliceDesc = streamRes.SliceDesc();
    EXPECT_EQ(sliceDesc[0].ciphertextAddr, PtrToValue(deviceBufA));
    EXPECT_EQ(sliceDesc[0].plaintextAddr, PtrToValue(dst));
    EXPECT_EQ(sliceDesc[0].ciphertextLen, CC_CIPHER_HEADER_SIZE + sizeof(src));
    EXPECT_EQ(sliceDesc[0].plaintextLen, static_cast<uint32_t>(sizeof(src)));
    EXPECT_EQ(sliceDesc[0].sliceIdx, 0U);

    // 密文 wire format：84B 头 + 密文体（EVP stub 为直拷贝）
    const CCCipherTxtHeader* header = reinterpret_cast<const CCCipherTxtHeader*>(deviceBufA);
    EXPECT_EQ(header->version, 1U);
    EXPECT_EQ(header->totalLen, CC_CIPHER_HEADER_SIZE + sizeof(src));
    EXPECT_EQ(header->ivLen, 12U);
    EXPECT_EQ(header->tagLen, 16U);
    EXPECT_EQ(header->ciphertextLen, static_cast<uint32_t>(sizeof(src)));
    EXPECT_EQ(memcmp(deviceBufA + sizeof(CCCipherTxtHeader), src, sizeof(src)), 0);

    worker.device_ = nullptr;
    (void)stm->TakeCCStreamResource();
    rtStreamDestroy(stmHandle);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Worker_ProcessH2DSlice_ErrorPaths)
{
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, (Device*)nullptr);
    Driver* realDriver = dev->Driver_();

    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());

    CCrypto crypto;
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    crypto.InitKey(0);

    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostRegister).stubs().will(invoke(PcieHostRegisterStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostUnRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemFree).stubs().will(invoke(DevMemFreeStub));

    CCStreamResManage streamRes;
    ASSERT_EQ(streamRes.Init(dev), RT_ERROR_NONE);
    stm->SetCCStreamResource(&streamRes);

    uint8_t deviceBufA[1024] = {};
    uint8_t deviceBufB[1024] = {};
    uint8_t hostBuf[1024] = {};
    uint8_t src[100] = {};
    uint8_t dst[100] = {};

    CCWorker worker;
    worker.device_ = dev;
    worker.crypto_ = &crypto;
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

    // ① 密钥未初始化：加密失败（worker 映射为 KEY_NOT_INITIALIZED）
    CCrypto uninitCrypto;
    worker.crypto_ = &uninitCrypto;
    EXPECT_EQ(worker.ProcessH2DSlice(task, &streamRes, 0U, 0U, sizeof(src)), RT_ERROR_CC_KEY_NOT_INITIALIZED);

    // ② DMA 拷贝失败：目的 Device Buffer 为空使真实 halMemcpy stub 返回错误
    worker.crypto_ = &crypto;
    worker.deviceBuffers_[0] = nullptr;
    EXPECT_EQ(worker.ProcessH2DSlice(task, &streamRes, 0U, 0U, sizeof(src)), RT_ERROR_CC_WORKER_FAILED);
    worker.deviceBuffers_[0] = deviceBufA;

    // ③ 环形队列满且已取消：等待期间退出并超时
    CCSliceQueue* taskQueue = streamRes.Queue();
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
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, (Device*)nullptr);
    Driver* realDriver = dev->Driver_();

    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());

    CCrypto crypto;
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    crypto.InitKey(0);

    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostRegister).stubs().will(invoke(PcieHostRegisterStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostUnRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemFree).stubs().will(invoke(DevMemFreeStub));

    CCStreamResManage streamRes;
    ASSERT_EQ(streamRes.Init(dev), RT_ERROR_NONE);
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
    uint8_t cipherIn[sizeof(CCCipherTxtHeader) + sizeof(src) + 32] = {};
    size_t ctLen = sizeof(cipherIn);
    ASSERT_EQ(crypto.Encrypt(0, src, sizeof(src), nullptr, 0, cipherIn, &ctLen), RT_ERROR_NONE);
    ASSERT_EQ(ctLen, sizeof(CCCipherTxtHeader) + sizeof(src));
    (void)memcpy_s(deviceBufA, sizeof(deviceBufA), cipherIn, ctLen);

    CCWorker worker;
    worker.device_ = dev;
    worker.crypto_ = &crypto;
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

    CCSliceQueue* taskQueue = streamRes.Queue();
    taskQueue->totalSlices = 1U;
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

    EXPECT_EQ(worker.ProcessD2HSlice(task, &streamRes, 0U, 0U, sizeof(src)), RT_ERROR_NONE);
    EXPECT_TRUE(descriptorValid.load());
    EXPECT_EQ(consumedCount.load(), 1U);
    EXPECT_EQ(taskQueue->head, 1U);
    EXPECT_EQ(taskQueue->tail, 1U);
    EXPECT_EQ(memcmp(dst, src, sizeof(src)), 0);

    worker.device_ = nullptr;
    (void)stm->TakeCCStreamResource();
    rtStreamDestroy(stmHandle);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Worker_ProcessD2HSlice_ErrorPaths)
{
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, (Device*)nullptr);
    Driver* realDriver = dev->Driver_();

    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());

    CCrypto crypto;
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    crypto.InitKey(0);

    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostRegister).stubs().will(invoke(PcieHostRegisterStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostUnRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemFree).stubs().will(invoke(DevMemFreeStub));

    CCStreamResManage streamRes;
    ASSERT_EQ(streamRes.Init(dev), RT_ERROR_NONE);
    stm->SetCCStreamResource(&streamRes);

    uint8_t deviceBufA[1024] = {};
    uint8_t deviceBufB[1024] = {};
    uint8_t hostBuf[1024] = {};
    uint8_t src[100] = {};
    uint8_t dst[100] = {};

    CCWorker worker;
    worker.device_ = dev;
    worker.crypto_ = &crypto;
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

    CCSliceQueue* taskQueue = streamRes.Queue();
    taskQueue->totalSlices = 1U;

    // ① 密钥未初始化：AICPU 消费 Host 发布的描述符后，Host 解密失败
    CCrypto uninitCrypto;
    worker.crypto_ = &uninitCrypto;
    const std::vector<uint32_t> sliceLens{static_cast<uint32_t>(sizeof(src))};
    std::atomic<bool> stop{false};
    std::atomic<uint32_t> consumedCount{0U};
    std::atomic<bool> descriptorValid{true};
    std::thread consumer(
        &AicpuSimulator::RunD2HConsumer, taskQueue, src, deviceBufA, deviceBufB, std::cref(sliceLens), std::cref(stop),
        std::ref(consumedCount), std::ref(descriptorValid));
    EXPECT_EQ(worker.ProcessD2HSlice(task, &streamRes, 0U, 0U, sizeof(src)), RT_ERROR_CC_KEY_NOT_INITIALIZED);
    stop.store(true);
    consumer.join();
    EXPECT_TRUE(descriptorValid.load());

    // ② DMA 拷贝失败：已发布的下一片必须先由 AICPU 消费，防止提前复用 A/B Buffer
    streamRes.Reset();
    taskQueue->totalSlices = 2U;
    worker.crypto_ = &crypto;
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
            if (!taskQueue->IsEmpty()) {
                taskQueue->tail = static_cast<uint8_t>((taskQueue->tail + 1U) % CC_SLICE_DESC_SLOT_NUM);
                consumedCount.fetch_add(1U, std::memory_order_relaxed);
            }
            std::this_thread::sleep_for(std::chrono::milliseconds(1));
        }
    });
    EXPECT_EQ(worker.ProcessD2HSlice(task, &streamRes, 0U, 0U, CC_PLAINTEXT_SLICE_SIZE), RT_ERROR_CC_WORKER_FAILED);
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
    EXPECT_EQ(worker.ProcessD2HSlice(task, &streamRes, 0U, 0U, sizeof(src)), RT_ERROR_CC_WORKER_TIMEOUT);
    worker.cancelled_.store(false);

    worker.device_ = nullptr;
    (void)stm->TakeCCStreamResource();
    rtStreamDestroy(stmHandle);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Worker_ProcessSlices_InvalidKind)
{
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, (Device*)nullptr);
    Driver* realDriver = dev->Driver_();

    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());

    CCrypto crypto;
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    crypto.InitKey(0);

    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostRegister).stubs().will(invoke(PcieHostRegisterStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostUnRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemFree).stubs().will(invoke(DevMemFreeStub));

    CCStreamResManage streamRes;
    ASSERT_EQ(streamRes.Init(dev), RT_ERROR_NONE);
    stm->SetCCStreamResource(&streamRes);

    CCWorker worker;
    worker.device_ = dev;
    worker.crypto_ = &crypto;
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
    EXPECT_EQ(worker.ProcessSlices(task, resource, sliceNum), RT_ERROR_INVALID_VALUE);

    worker.device_ = nullptr;
    (void)stm->TakeCCStreamResource();
    rtStreamDestroy(stmHandle);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Worker_ProcessTask_H2D_MultiSlice)
{
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, (Device*)nullptr);
    Driver* realDriver = dev->Driver_();

    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());

    CCrypto crypto;
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    crypto.InitKey(0);

    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostRegister).stubs().will(invoke(PcieHostRegisterStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostUnRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemFree).stubs().will(invoke(DevMemFreeStub));

    CCStreamResManage streamRes;
    ASSERT_EQ(streamRes.Init(dev), RT_ERROR_NONE);
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
    worker.crypto_ = &crypto;
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
        &AicpuSimulator::RunH2DConsumer, streamRes.Queue(), 3U, std::cref(stop), std::ref(consumedCount));
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
    CCSliceQueue* taskQueue = streamRes.Queue();
    EXPECT_EQ(taskQueue->totalSlices, 3U);
    EXPECT_EQ(taskQueue->head, taskQueue->tail);

    worker.device_ = nullptr;
    (void)stm->TakeCCStreamResource();
    rtStreamDestroy(stmHandle);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Worker_ProcessTask_D2H_EndToEnd)
{
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, (Device*)nullptr);
    Driver* realDriver = dev->Driver_();

    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());

    CCrypto crypto;
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    crypto.InitKey(0);

    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostRegister).stubs().will(invoke(PcieHostRegisterStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostUnRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemFree).stubs().will(invoke(DevMemFreeStub));

    CCStreamResManage streamRes;
    ASSERT_EQ(streamRes.Init(dev), RT_ERROR_NONE);
    stm->SetCCStreamResource(&streamRes);

    constexpr size_t SLICE0_LEN = CC_PLAINTEXT_SLICE_SIZE;
    constexpr size_t SLICE1_LEN = 50U;
    constexpr size_t TOTAL_SIZE = SLICE0_LEN + SLICE1_LEN; // 2 片
    std::vector<uint8_t> src(TOTAL_SIZE);
    for (size_t i = 0U; i < src.size(); ++i) {
        src[i] = static_cast<uint8_t>(i & 0xFFU);
    }
    std::vector<uint8_t> dst(TOTAL_SIZE);
    std::vector<uint8_t> deviceBufA(CC_SLICE_SIZE);
    std::vector<uint8_t> deviceBufB(CC_SLICE_SIZE + 100U);
    std::vector<uint8_t> hostBuf(CC_SLICE_SIZE);

    // Host 侧模拟 AICPU 已写入两片密文到 Device Buffer A/B
    std::vector<uint8_t> cipher0(sizeof(CCCipherTxtHeader) + SLICE0_LEN + 32U);
    std::vector<uint8_t> cipher1(sizeof(CCCipherTxtHeader) + SLICE1_LEN + 32U);
    size_t ctLen0 = cipher0.size();
    size_t ctLen1 = cipher1.size();
    ASSERT_EQ(crypto.Encrypt(0, src.data(), SLICE0_LEN, nullptr, 0, cipher0.data(), &ctLen0), RT_ERROR_NONE);
    ASSERT_EQ(
        crypto.Encrypt(0, src.data() + SLICE0_LEN, SLICE1_LEN, nullptr, 0, cipher1.data(), &ctLen1), RT_ERROR_NONE);
    ASSERT_EQ(ctLen0, sizeof(CCCipherTxtHeader) + SLICE0_LEN);
    ASSERT_EQ(ctLen1, sizeof(CCCipherTxtHeader) + SLICE1_LEN);
    (void)memcpy_s(deviceBufA.data(), deviceBufA.size(), cipher0.data(), ctLen0);
    (void)memcpy_s(deviceBufB.data(), deviceBufB.size(), cipher1.data(), ctLen1);

    CCWorker worker;
    worker.device_ = dev;
    worker.crypto_ = &crypto;
    worker.maxSliceSize_ = CC_SLICE_SIZE;
    worker.workerId_ = 0U;
    worker.deviceBuffers_[0] = deviceBufA.data();
    worker.deviceBuffers_[1] = deviceBufB.data();
    worker.hostCryptoBuf_ = hostBuf.data();

    CCMemcpyTask task = {};
    task.src = src.data();
    task.dst = dst.data();
    task.totalSize = TOTAL_SIZE;
    task.kind = RT_MEMCPY_DEVICE_TO_HOST;
    task.streamId = streamId;

    const std::vector<uint32_t> sliceLens{static_cast<uint32_t>(SLICE0_LEN), static_cast<uint32_t>(SLICE1_LEN)};
    std::atomic<bool> stop{false};
    std::atomic<uint32_t> consumedCount{0U};
    std::atomic<bool> descriptorValid{true};
    std::thread consumer(
        &AicpuSimulator::RunD2HConsumer, streamRes.Queue(), src.data(), deviceBufA.data(), deviceBufB.data(),
        std::cref(sliceLens), std::cref(stop), std::ref(consumedCount), std::ref(descriptorValid));
    const ScopeGuard stopConsumer([&stop, &consumer]() {
        stop.store(true);
        if (consumer.joinable()) {
            consumer.join();
        }
    });

    EXPECT_EQ(worker.ProcessTask(task), RT_ERROR_NONE);
    CCSliceQueue* taskQueue = streamRes.Queue();
    EXPECT_EQ(taskQueue->totalSlices, 2U);
    EXPECT_TRUE(descriptorValid.load());
    EXPECT_EQ(consumedCount.load(), 2U);
    EXPECT_EQ(taskQueue->head, taskQueue->tail);
    EXPECT_EQ(memcmp(dst.data(), src.data(), TOTAL_SIZE), 0);

    worker.device_ = nullptr;
    (void)stm->TakeCCStreamResource();
    rtStreamDestroy(stmHandle);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Worker_ProcessTask_D2H_ThreeSlicesReusesBuffers)
{
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, (Device*)nullptr);
    Driver* realDriver = dev->Driver_();

    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());

    CCrypto crypto;
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    ASSERT_EQ(crypto.InitKey(0), RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostRegister).stubs().will(invoke(PcieHostRegisterStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostUnRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemFree).stubs().will(invoke(DevMemFreeStub));

    CCStreamResManage streamRes;
    ASSERT_EQ(streamRes.Init(dev), RT_ERROR_NONE);
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
        CCSliceDesc aad{};
        aad.ciphertextAddr = PtrToValue((i % 2U) == 0U ? deviceBufA.data() : deviceBufB.data());
        aad.plaintextAddr = PtrToValue(src.data() + offset);
        aad.ciphertextLen = CC_CIPHER_HEADER_SIZE + sliceLens[i];
        aad.plaintextLen = sliceLens[i];
        aad.sliceIdx = static_cast<uint32_t>(i);
        ciphers[i].resize(CC_CIPHER_HEADER_SIZE + sliceLens[i] + 32U);
        cipherLens[i] = ciphers[i].size();
        ASSERT_EQ(
            crypto.Encrypt(
                0, src.data() + offset, sliceLens[i], reinterpret_cast<const uint8_t*>(&aad), sizeof(aad),
                ciphers[i].data(), &cipherLens[i]),
            RT_ERROR_NONE);
        ASSERT_EQ(cipherLens[i], CC_CIPHER_HEADER_SIZE + sliceLens[i]);
        offset += sliceLens[i];
    }

    CCWorker worker;
    worker.device_ = dev;
    worker.crypto_ = &crypto;
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
    ASSERT_EQ(sliceNum, 3U);
    CCSliceQueue* const taskQueue = streamRes.Queue();
    EXPECT_EQ(taskQueue->memWaitVal, 1U);

    std::atomic<bool> stop{false};
    std::atomic<uint32_t> consumedCount{0U};
    std::atomic<bool> descriptorValid{true};
    std::thread consumer([&]() {
        while (!stop.load() && (taskQueue->memWaitVal != 1U)) {
            std::this_thread::sleep_for(std::chrono::milliseconds(1));
        }
        if (stop.load()) {
            return;
        }
        size_t plaintextOffset = 0U;
        for (uint32_t sliceIdx = 0U; sliceIdx < sliceNum && !stop.load(); ++sliceIdx) {
            while (!stop.load() && taskQueue->IsEmpty()) {
                std::this_thread::sleep_for(std::chrono::milliseconds(1));
            }
            if (stop.load()) {
                return;
            }

            const uint8_t tail = taskQueue->tail;
            const CCSliceDesc& desc = taskQueue->sliceDesc[tail];
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
            taskQueue->tail = static_cast<uint8_t>((tail + 1U) % CC_SLICE_DESC_SLOT_NUM);
            consumedCount.fetch_add(1U, std::memory_order_relaxed);
        }
    });
    const ScopeGuard stopConsumer([&stop, &consumer]() {
        stop.store(true);
        if (consumer.joinable()) {
            consumer.join();
        }
    });

    EXPECT_EQ(worker.ProcessSlices(task, resource, sliceNum), RT_ERROR_NONE);
    if (consumer.joinable()) {
        consumer.join();
    }
    EXPECT_TRUE(descriptorValid.load());
    EXPECT_EQ(consumedCount.load(), sliceNum);
    EXPECT_EQ(taskQueue->head, taskQueue->tail);
    EXPECT_EQ(taskQueue->memWaitVal, 0U);
    EXPECT_EQ(memcmp(dst.data(), src.data(), totalSize), 0);

    worker.device_ = nullptr;
    (void)stm->TakeCCStreamResource();
    rtStreamDestroy(stmHandle);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Worker_ProcessD2HSlice_PublishesNextBeforeDmaAndDecrypt)
{
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, (Device*)nullptr);
    Driver* realDriver = dev->Driver_();

    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);
    const uint32_t streamId = static_cast<uint32_t>(stm->Id_());

    CCrypto encryptCrypto;
    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    ASSERT_EQ(encryptCrypto.InitKey(0), RT_ERROR_NONE);

    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostRegister).stubs().will(invoke(PcieHostRegisterStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostUnRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemFree).stubs().will(invoke(DevMemFreeStub));

    CCStreamResManage streamRes;
    ASSERT_EQ(streamRes.Init(dev), RT_ERROR_NONE);
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

    CCSliceDesc firstAad{};
    firstAad.ciphertextAddr = PtrToValue(deviceBufA.data());
    firstAad.plaintextAddr = PtrToValue(src.data());
    firstAad.ciphertextLen = CC_CIPHER_HEADER_SIZE + CC_PLAINTEXT_SLICE_SIZE;
    firstAad.plaintextLen = CC_PLAINTEXT_SLICE_SIZE;
    firstAad.sliceIdx = 0U;
    std::vector<uint8_t> firstCipher(CC_SLICE_SIZE + 32U);
    size_t firstCipherLen = firstCipher.size();
    ASSERT_EQ(
        encryptCrypto.Encrypt(
            0, src.data(), CC_PLAINTEXT_SLICE_SIZE, reinterpret_cast<const uint8_t*>(&firstAad), sizeof(firstAad),
            firstCipher.data(), &firstCipherLen),
        RT_ERROR_NONE);

    CCrypto uninitCrypto;
    CCWorker worker;
    worker.device_ = dev;
    worker.crypto_ = &uninitCrypto;
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
    CCSliceQueue* const taskQueue = streamRes.Queue();

    gObservedD2HDst.store(PtrToValue(hostBuf.data()));
    gObservedD2HQueue = taskQueue;
    gExpectedD2HSlice = 1U;
    gExpectedD2HHead = 2U;
    gExpectedD2HTail = 1U;
    std::atomic<bool> stop{false};
    std::thread consumer([&]() {
        while (!stop.load() && (taskQueue->memWaitVal != 1U)) {
            std::this_thread::sleep_for(std::chrono::milliseconds(1));
        }
        while (!stop.load() && taskQueue->IsEmpty()) {
            std::this_thread::sleep_for(std::chrono::milliseconds(1));
        }
        if (stop.load()) {
            return;
        }
        const uint8_t firstTail = taskQueue->tail;
        (void)memcpy_s(deviceBufA.data(), deviceBufA.size(), firstCipher.data(), firstCipherLen);
        taskQueue->tail = static_cast<uint8_t>((firstTail + 1U) % CC_SLICE_DESC_SLOT_NUM);

        while (!stop.load() && !gAllowD2HNextConsume.load()) {
            std::this_thread::sleep_for(std::chrono::milliseconds(1));
        }
        if (!stop.load()) {
            const uint8_t nextTail = taskQueue->tail;
            taskQueue->tail = static_cast<uint8_t>((nextTail + 1U) % CC_SLICE_DESC_SLOT_NUM);
        }
    });
    const ScopeGuard stopConsumer([&stop, &consumer]() {
        stop.store(true);
        if (consumer.joinable()) {
            consumer.join();
        }
    });

    EXPECT_EQ(worker.ProcessD2HSlice(task, resource, 0U, 0U, CC_PLAINTEXT_SLICE_SIZE), RT_ERROR_CC_KEY_NOT_INITIALIZED);
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

TEST_F(CCManagerTest, CCResManage_Init_CreatesOneWorker)
{
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    EXPECT_NE(dev, (Device*)nullptr);

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
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostDmaMap).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostDmaUnmap).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostMemFree).stubs().will(returnValue(RT_ERROR_NONE));

    CCResManage resource(dev);
    ASSERT_EQ(resource.InitCcResource(), RT_ERROR_NONE);
    EXPECT_EQ(resource.workers_.size(), 1U);
    for (const auto& worker : resource.workers_) {
        EXPECT_NE(worker, nullptr);
    }

    resource.DestroyCcResource();

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, CCResManage_SubmitTask_GrowsOneWorkerPerSubmitUpToSix)
{
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, nullptr);

    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    MOCKER_CPP(&Runtime::StartAicpuSd).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(StreamLaunchCpuKernel).expects(once()).will(returnValue(RT_ERROR_NONE));
    Stream* const ctrlStm = dev->GetCtrlSQStream(nullptr);
    ASSERT_NE(ctrlStm, nullptr);
    MOCKER_CPP_VIRTUAL(ctrlStm, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostMemAlloc).stubs().will(invoke(HostMemAllocStub));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostDmaMap).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostDmaUnmap).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostMemFree).stubs().will(returnValue(RT_ERROR_NONE));
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
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, nullptr);

    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    MOCKER_CPP(&Runtime::StartAicpuSd).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(StreamLaunchCpuKernel).expects(once()).will(returnValue(RT_ERROR_NONE));
    Stream* const ctrlStm = dev->GetCtrlSQStream(nullptr);
    ASSERT_NE(ctrlStm, nullptr);
    MOCKER_CPP_VIRTUAL(ctrlStm, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostMemAlloc).stubs().will(invoke(HostMemAllocStub));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostDmaMap).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostDmaUnmap).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostMemFree).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAllocWithBackupFlag).stubs().will(invoke(DevMemAllocEntryStub));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemAllocWithFlag).stubs().will(invoke(DevMemAllocStub));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::DevMemFree).stubs().will(returnValue(RT_ERROR_NONE));

    gHostAllocFailAt = 2U;
    CCResManage resource(dev);
    ASSERT_EQ(resource.InitCcResource(), RT_ERROR_NONE);
    ASSERT_EQ(resource.workers_.size(), 1U);

    CCMemcpyTask task{};
    task.streamId = 0xDEADU;
    EXPECT_EQ(resource.SubmitTask(task), RT_ERROR_NONE);
    EXPECT_EQ(resource.workers_.size(), 1U);
    EXPECT_EQ(gHostAllocCount, 2U);

    resource.DestroyCcResource();
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, CCResManage_Init_StartAicpuSdFailure)
{
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, nullptr);

    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    MOCKER_CPP(&Runtime::StartAicpuSd).stubs().will(returnValue(RT_ERROR_DRV_OPEN_AICPU));
    MOCKER(StreamLaunchCpuKernel).expects(never());

    CCResManage resource(dev);
    EXPECT_EQ(resource.InitCcResource(), RT_ERROR_CC_INIT_FAILED);
    EXPECT_TRUE(resource.workers_.empty());

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, CCResManage_LoadKeyToAicpu_StartAicpuSdFailure)
{
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, nullptr);

    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    MOCKER_CPP(&Runtime::StartAicpuSd).expects(once()).will(returnValue(RT_ERROR_DRV_OPEN_AICPU));
    MOCKER(StreamLaunchCpuKernel).expects(never());

    CCResManage resource(dev);
    ASSERT_EQ(resource.crypto_.InitKey(dev->Id_()), RT_ERROR_NONE);
    EXPECT_EQ(resource.LoadKeyToAicpu(), RT_ERROR_DRV_OPEN_AICPU);

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, CCResManage_Init_KeyFailure)
{
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    EXPECT_NE(dev, (Device*)nullptr);

    MOCKER(GetKeyFromKernel).stubs().will(returnValue(-1));

    CCResManage resource(dev);
    EXPECT_EQ(resource.InitCcResource(), RT_ERROR_CC_INIT_FAILED);
    EXPECT_TRUE(resource.workers_.empty());

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, CCResManage_Init_ErrorPaths)
{
    // ① 空设备构造 + Init 失败
    CCResManage nullResource(nullptr);
    EXPECT_EQ(nullResource.InitCcResource(), RT_ERROR_DEVICE_NULL);

    // ② 初始 worker 初始化失败：Init 返回错误且 worker 池被清空
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, (Device*)nullptr);
    Driver* realDriver = dev->Driver_();

    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    Stream* const ctrlStm = dev->GetCtrlSQStream(nullptr);
    ASSERT_NE(ctrlStm, nullptr);
    MOCKER_CPP_VIRTUAL(ctrlStm, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::HostMemAlloc).stubs().will(invoke(HostMemAllocStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::HostDmaMap).stubs().will(invoke(HostDmaMapStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::HostDmaUnmap).stubs().will(invoke(HostDmaUnmapStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::HostMemFree).stubs().will(invoke(HostMemFreeStub));
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
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, (Device*)nullptr);
    Driver* realDriver = dev->Driver_();

    rtStream_t stmHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmHandle));
    Stream* stm = rt_ut::UnwrapOrNull<Stream>(stmHandle);
    ASSERT_NE(stm, (Stream*)nullptr);

    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostRegister).stubs().will(invoke(PcieHostRegisterStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostUnRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemFree).stubs().will(invoke(DevMemFreeStub));

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

    delete stm->TakeCCStreamResource();
    rtStreamDestroy(stmHandle);
    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, CCResManage_DestroyStreamResource_Basics)
{
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, (Device*)nullptr);
    Driver* realDriver = dev->Driver_();

    rtStream_t stmAHandle = 0U;
    rtStream_t stmBHandle = 0U;
    ASSERT_TRUE(CreatePersistentStream(stmAHandle));
    ASSERT_TRUE(CreatePersistentStream(stmBHandle));
    Stream* stmA = rt_ut::UnwrapOrNull<Stream>(stmAHandle);
    Stream* stmB = rt_ut::UnwrapOrNull<Stream>(stmBHandle);
    ASSERT_NE(stmA, (Stream*)nullptr);
    ASSERT_NE(stmB, (Stream*)nullptr);

    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostRegister).stubs().will(invoke(PcieHostRegisterStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostUnRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemFree).stubs().will(invoke(DevMemFreeStub));

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
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, (Device*)nullptr);
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
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::HostMemAlloc).stubs().will(invoke(HostMemAllocStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::HostDmaMap).stubs().will(invoke(HostDmaMapStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::HostDmaUnmap).stubs().will(invoke(HostDmaUnmapStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::HostMemFree).stubs().will(invoke(HostMemFreeStub));
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

TEST_F(CCManagerTest, Manager_InitDeviceResource_NullDevice)
{
    CCManager manager;
    rtError_t ret = manager.InitDeviceResource(nullptr);
    EXPECT_EQ(ret, RT_ERROR_DEVICE_NULL);
}

TEST_F(CCManagerTest, Manager_InitDeviceResource_RepeatedInit)
{
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    EXPECT_NE(dev, (Device*)nullptr);

    // InitKey 仅执行一次（GetKeyFromKernel 被 H2D/D2H 方向各调一次，共 exactly(2)），第二次初始化应幂等返回。
    MOCKER(GetKeyFromKernel).expects(exactly(2)).will(returnValue(0));
    MOCKER_CPP(&Runtime::StartAicpuSd).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(StreamLaunchCpuKernel).expects(once()).will(returnValue(RT_ERROR_NONE));
    Stream* const ctrlStm = dev->GetCtrlSQStream(nullptr);
    ASSERT_NE(ctrlStm, nullptr);
    MOCKER_CPP_VIRTUAL(ctrlStm, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostMemAlloc).stubs().will(invoke(HostMemAllocStub));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostDmaMap).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostDmaUnmap).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostMemFree).stubs().will(returnValue(RT_ERROR_NONE));

    CCManager manager;
    EXPECT_EQ(manager.InitDeviceResource(dev), RT_ERROR_NONE);
    EXPECT_EQ(manager.InitDeviceResource(dev), RT_ERROR_NONE);

    ((Runtime*)Runtime::Instance())->DeviceRelease(dev);
}

TEST_F(CCManagerTest, Manager_InitDeviceResource_ErrorPaths)
{
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, (Device*)nullptr);

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
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, (Device*)nullptr);
    Driver* realDriver = dev->Driver_();

    MOCKER(GetKeyFromKernel).stubs().will(returnValue(0));
    MOCKER_CPP(&Runtime::StartAicpuSd).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER(StreamLaunchCpuKernel).expects(once()).will(returnValue(RT_ERROR_NONE));
    Stream* const ctrlStm = dev->GetCtrlSQStream(nullptr);
    ASSERT_NE(ctrlStm, nullptr);
    MOCKER_CPP_VIRTUAL(ctrlStm, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::HostMemAlloc).stubs().will(invoke(HostMemAllocStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::HostDmaMap).stubs().will(invoke(HostDmaMapStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::HostDmaUnmap).stubs().will(invoke(HostDmaUnmapStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::HostMemFree).stubs().will(invoke(HostMemFreeStub));
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

TEST_F(CCManagerTest, CheckMemAddrRangeValid_AllocationBoundary)
{
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

TEST_F(CCManagerTest, CheckMemAddrRangeValid_AddressOutsideAllocation)
{
    constexpr uint64_t allocBase = 0x2000U;
    constexpr size_t allocSize = 0x100U;
    MockMemGetAddressRange(allocBase, allocSize);

    EXPECT_EQ(CheckMemAddrRangeValid(RtValueToPtr<const void*>(allocBase - 1U), 1U), RT_ERROR_DRV_ERR);
    EXPECT_EQ(CheckMemAddrRangeValid(RtValueToPtr<const void*>(allocBase + allocSize + 1U), 1U), RT_ERROR_DRV_ERR);
    EXPECT_EQ(gMemRangeStub.callCount, 2U);
}

TEST_F(CCManagerTest, CheckMemAddrRangeValid_HalFailure)
{
    MockMemGetAddressRange(0U, 0U, DRV_ERROR_NOT_SUPPORT);

    EXPECT_EQ(CheckMemAddrRangeValid(RtValueToPtr<const void*>(0x4000U), 1U), RT_ERROR_DRV_NOT_SUPPORT);
    EXPECT_EQ(gMemRangeStub.callCount, 1U);
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
}

TEST_F(CCManagerTest, Manager_MemSetEntryPoints_InvalidInputs)
{
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
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, (Device*)nullptr);
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
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::HostMemAlloc).stubs().will(invoke(HostMemAllocStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::HostDmaMap).stubs().will(invoke(HostDmaMapStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::HostDmaUnmap).stubs().will(invoke(HostDmaUnmapStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::HostMemFree).stubs().will(invoke(HostMemFreeStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemAllocWithBackupFlag).stubs().will(invoke(DevMemAllocEntryStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemAllocWithFlag).stubs().will(invoke(DevMemAllocStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostRegister).stubs().will(invoke(PcieHostRegisterStub));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::PcieHostUnRegister).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(realDriver, &Driver::DevMemFree).stubs().will(invoke(DevMemFreeStub));

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
    // 测试点5/6 分别会触发 load-key 与 crypto kernel 启动，均走 StreamLaunchCpuKernel。
    MOCKER(StreamLaunchCpuKernel).stubs().will(returnValue(RT_ERROR_NONE));

    // 测试点4：环境检测通过后，通过芯片函数表注册 CC 资源和内存分发回调。
    ASSERT_EQ(runtime->InitCcFeature(), RT_ERROR_NONE);
    DevDynInfoProcFunc registeredProcFunc{};
    ASSERT_EQ(GET_DEV_INFO_PROC_FUNC(chipType, registeredProcFunc), RT_ERROR_NONE);
    ASSERT_NE(registeredProcFunc.ccProcFunc.devResourceInit, nullptr);
    ASSERT_NE(registeredProcFunc.ccProcFunc.devResourceRelease, nullptr);
    ASSERT_NE(registeredProcFunc.memProcFunc.memcpyAsync, nullptr);

    // 测试点5：通过已注册的资源回调初始化当前 Device 的密钥和 6 Worker 线程池。
    Device* dev = ((Runtime*)Runtime::Instance())->DeviceRetain(0, 0);
    ASSERT_NE(dev, (Device*)nullptr);
    Stream* const ctrlStm = dev->GetCtrlSQStream(nullptr);
    ASSERT_NE(ctrlStm, nullptr);
    MOCKER_CPP_VIRTUAL(ctrlStm, &Stream::Synchronize).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostMemAlloc).stubs().will(invoke(HostMemAllocStub));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostDmaMap).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostDmaUnmap).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(dev->Driver_(), &Driver::HostMemFree).stubs().will(returnValue(RT_ERROR_NONE));
    ASSERT_EQ(registeredProcFunc.ccProcFunc.devResourceInit(dev), RT_ERROR_NONE);

    // 测试点6：H2D MemcpyAsync 命中 CC 回调并完整走通提交链路；
    // Host 回调 / mem-wait / crypto kernel 三条流任务提交边界均打桩，不产生真实流任务，避免 TearDown 复位时挂起。
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
