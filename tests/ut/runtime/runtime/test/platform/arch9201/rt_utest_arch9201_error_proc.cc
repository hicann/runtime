/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "driver/ascend_hal.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#include <stdalign.h>
#define private public
#define protected public
#include "runtime.hpp"
#include "stream_c.hpp"
#include "task_recycle.hpp"
#include "ccu_task.hpp"
#include "device/device_error_proc.hpp"
#include "device_error_proc_c.hpp"
#include "thread_local_container.hpp"
#include "stars_david.hpp"
#include "rt_unwrap.h"
#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;

namespace {
const std::vector<uint64_t> ARCH9201_ERROR_TYPES = {
    AICORE_ERROR, AIVECTOR_ERROR, WAIT_TIMEOUT_ERROR,  SDMA_ERROR, AICPU_ERROR,
    DVPP_ERROR,   SQE_ERROR,      FUSION_KERNEL_ERROR, CCU_ERROR,  AICORE_TIMEOUT_DFX,
};

const std::vector<uint64_t> ARCH9201_REPRESENTATIVE_ERRORS = {
    CUBE_INVLD_INPUT,   MTE_NDDMA_CACHE_ECC,     VEC_ERR_BIU_RESP_ERR_T0, SU_IFU_BUS_ERR_T0,
    FIXP_BIU_RDWR_RESP, SC_BUS_RESP_TIMEOUT_ERR, L1_L0A_RDWR_CFLT,
};

// 初始化 ringbuffer（带 elementSize），返回首个 element 起始地址
RingBufferElementInfo* InitRingBuffer(
    DevRingBufferCtlInfo* ctlInfo, uint32_t tail, uint32_t elementSize = RINGBUFFER_EXT_ONE_ELEMENT_LENGTH_ON_DAVID)
{
    memset_s(ctlInfo, DEVICE_ERROR_EXT_RINGBUFFER_SIZE, 0, DEVICE_ERROR_EXT_RINGBUFFER_SIZE);
    ctlInfo->tail = tail;
    ctlInfo->head = 0;
    ctlInfo->magic = RINGBUFFER_MAGIC;
    ctlInfo->ringBufferLen = RINGBUFFER_LEN;
    ctlInfo->elementSize = elementSize;
    uintptr_t infoAddr = reinterpret_cast<uintptr_t>(ctlInfo) + sizeof(DevRingBufferCtlInfo);
    return reinterpret_cast<RingBufferElementInfo*>(infoAddr);
}

void CleanupErrorProc(DeviceErrorProc* errorProc, Device* device)
{
    errorProc->deviceRingBufferAddr_ = nullptr;
    delete errorProc;
    ((Runtime*)Runtime::Instance())->DeviceRelease(device);
}

// --- ost task error 测试 stub ---
uint32_t g_printErrCnt = 0;
void PrintErrorInfoStub(TaskInfo* taskInfo, const uint32_t devId)
{
    UNUSED(taskInfo);
    UNUSED(devId);
    g_printErrCnt++;
}

uint32_t g_callCnt = 0;
void TaskFailCallFusionStub(rtExceptionInfo_t* exceptionInfo)
{
    UNUSED(exceptionInfo);
    g_callCnt++;
}

// TaskFailCallBackForFusionKernelTask 计数 stub
void TaskFailCallBackForFusionKernelTaskStub(
    const TaskInfo* const, const uint32_t, const StarsDeviceErrorInfo* const, rtFusionExType_t)
{
    g_callCnt++;
}
} // namespace

// ============================================================================
// Test fixture: 设置 CHIP_CLOUD_V5 (arch9201) 作为芯片类型
// ============================================================================
class Arch9201ErrorProcTest : public testing::Test {
protected:
    static void SetUpTestCase() {}
    static void TearDownTestCase() {}

    virtual void SetUp()
    {
        Runtime* rtInstance = (Runtime*)Runtime::Instance();
        rtSetDevice(0);
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
        Runtime* rtInstance = (Runtime*)Runtime::Instance();
        GlobalMockObject::verify();
    }
};

// ============================================================================
// 1. 错误映射表注册 + 错误 bit 查询纯函数验证
//    覆盖：arch9201 映射表非空且含代表性错误码、10个处理函数全部注册、
//          arch9201 与 david 注册表独立且 AICORE 处理函数不同、
//          ProcessDavidStarsCoreErrorMapInfo 对 SC/CUBE/VEC bit 及无 bit 默认描述
// ============================================================================
TEST_F(Arch9201ErrorProcTest, ErrorMapRegistrationAndBitLookup)
{
    // --- 错误映射表与处理函数注册验证 ---
    const auto* errorMap = GetDavidErrorMapInfo(CHIP_CLOUD_V5);
    ASSERT_NE(errorMap, nullptr);
    EXPECT_FALSE(errorMap->empty());
    for (const auto errCode : ARCH9201_REPRESENTATIVE_ERRORS) {
        auto it = errorMap->find(errCode);
        EXPECT_NE(it, errorMap->end()) << "missing error code: " << errCode;
        EXPECT_FALSE(it->second.empty());
    }

    const auto& funcMap = GetErrorProcFuncMap(CHIP_CLOUD_V5);
    EXPECT_EQ(funcMap.size(), ARCH9201_ERROR_TYPES.size());
    for (const auto errType : ARCH9201_ERROR_TYPES) {
        EXPECT_NE(funcMap.find(errType), funcMap.end()) << "missing error type: " << errType;
    }

    // arch9201 与 david 注册表各自独立且 AICORE 处理函数不同
    const auto* davidMap = GetDavidErrorMapInfo(CHIP_DAVID);
    ASSERT_NE(davidMap, nullptr);
    EXPECT_FALSE(davidMap->empty());
    const auto& davidFuncMap = GetErrorProcFuncMap(CHIP_DAVID);
    auto davidIt = davidFuncMap.find(AICORE_ERROR);
    auto arch9201It = funcMap.find(AICORE_ERROR);
    ASSERT_NE(davidIt, davidFuncMap.end());
    ASSERT_NE(arch9201It, funcMap.end());
    EXPECT_NE(davidIt->second, arch9201It->second);

    // --- ProcessDavidStarsCoreErrorMapInfo 错误 bit 查询 ---
    auto checkBit = [](uint64_t DavidOneCoreErrorInfo::*field, uint64_t errCode, uint64_t offset) {
        DavidOneCoreErrorInfo coreErrInfo = {};
        coreErrInfo.*field = (1ULL << (errCode - offset));
        std::string errorString;
        std::string errorCode;
        ProcessDavidStarsCoreErrorMapInfo(&coreErrInfo, errorString, errorCode, CHIP_CLOUD_V5);
        EXPECT_FALSE(errorString.empty());
    };

    checkBit(&DavidOneCoreErrorInfo::scError, SC_BUS_RESP_TIMEOUT_ERR, RINGBUFFER_SC_ERROR_OFFSET);
    checkBit(&DavidOneCoreErrorInfo::cubeError, CUBE_INVLD_INPUT, RINGBUFFER_CUBE_ERROR_OFFSET);
    checkBit(&DavidOneCoreErrorInfo::vecError, VEC_ERR_BIU_RESP_ERR_T0, RINGBUFFER_VEC_ERROR_OFFSET);

    // 无错误 bit 时返回默认描述
    DavidOneCoreErrorInfo coreErrInfo = {};
    std::string errorString;
    std::string errorCode;
    ProcessDavidStarsCoreErrorMapInfo(&coreErrInfo, errorString, errorCode, CHIP_CLOUD_V5);
    EXPECT_EQ(errorString, "timeout or trap error.");
}

// ============================================================================
// 2. ProcessStarv2OneElementInRingBuffer 全路径 + 无效输入合并验证
//    覆盖：单 core AICORE（suErrInfo 全零安全访问）、多 core AICORE（suErrInfo 非零 + second pcStart）、
//          AIVECTOR 错误、FUSION_KERNEL_ERROR + Ext（base+aicExt+aivExt）合并、
//          elementSize=0 无效输入（ProcessStarv2OneElementInRingBuffer + ProcessReportRingBuffer）
// ============================================================================
TEST_F(Arch9201ErrorProcTest, ProcessStarv2OneElement_AllPathsAndInvalidInput)
{
    rtSetDevice(1);
    Device* device = ((Runtime*)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceErrorProc* errorProc = new DeviceErrorProc(device);
    DevRingBufferCtlInfo* ctlInfo = (DevRingBufferCtlInfo*)malloc(DEVICE_ERROR_EXT_RINGBUFFER_SIZE);
    ASSERT_NE(ctlInfo, nullptr);

    // --- 单 core AICORE：suErrInfo 全零，验证 PrintDavidCoreInfo 不越界访问 suErrInfo[3] ---
    {
        RingBufferElementInfo* info = InitRingBuffer(ctlInfo, 1);
        StarsDeviceErrorInfo* errorInfo = reinterpret_cast<StarsDeviceErrorInfo*>(info + 1);
        info->errorType = AICORE_ERROR;
        errorInfo->u.davidCoreErrorInfo.comm.type = AICORE_ERROR;
        errorInfo->u.davidCoreErrorInfo.comm.coreNum = 1;
        errorInfo->u.davidCoreErrorInfo.info[0].coreId = 1;
        EXPECT_EQ(errorProc->ProcessStarv2OneElementInRingBuffer(ctlInfo, 0, 1), RT_ERROR_NONE);
    }

    // --- 多 core AICORE：suErrInfo 全段非零 + second pcStart 非零 ---
    {
        RingBufferElementInfo* info = InitRingBuffer(ctlInfo, 1);
        StarsDeviceErrorInfo* errorInfo = reinterpret_cast<StarsDeviceErrorInfo*>(info + 1);
        info->errorType = AICORE_ERROR;
        errorInfo->u.davidCoreErrorInfo.comm.type = AICORE_ERROR;
        errorInfo->u.davidCoreErrorInfo.comm.coreNum = 2;
        errorInfo->u.davidCoreErrorInfo.info[0].coreId = 1;
        errorInfo->u.davidCoreErrorInfo.info[1].coreId = 2;
        for (uint32_t i = 0; i < 2; i++) {
            errorInfo->u.davidCoreErrorInfo.info[i].suErrInfo[0] = 0xABCD;
            errorInfo->u.davidCoreErrorInfo.info[i].suErrInfo[1] = 0x1234;
            errorInfo->u.davidCoreErrorInfo.info[i].suErrInfo[2] = 0x5678;
            errorInfo->u.davidCoreErrorInfo.info[i].suErrInfo[3] = 0x9ABC;
            errorInfo->u.davidCoreErrorInfo.info[i].ostTaskOneCore[0].pcStart = 0x1000;
            errorInfo->u.davidCoreErrorInfo.info[i].ostTaskOneCore[1].pcStart = 0x2000;
            errorInfo->u.davidCoreErrorInfo.info[i].ostTaskOneCore[1].streamId = 1;
            errorInfo->u.davidCoreErrorInfo.info[i].ostTaskOneCore[1].taskId = 2;
        }
        EXPECT_EQ(errorProc->ProcessStarv2OneElementInRingBuffer(ctlInfo, 0, 1), RT_ERROR_NONE);
    }

    // --- AIVECTOR 错误：vecError 设置错误 bit ---
    {
        RingBufferElementInfo* info = InitRingBuffer(ctlInfo, 1);
        StarsDeviceErrorInfo* errorInfo = reinterpret_cast<StarsDeviceErrorInfo*>(info + 1);
        info->errorType = AIVECTOR_ERROR;
        errorInfo->u.davidCoreErrorInfo.comm.type = AIVECTOR_ERROR;
        errorInfo->u.davidCoreErrorInfo.comm.coreNum = 1;
        errorInfo->u.davidCoreErrorInfo.info[0].coreId = 5;
        errorInfo->u.davidCoreErrorInfo.info[0].vecError =
            (1ULL << (VEC_ERR_BIU_RESP_ERR_T0 - RINGBUFFER_VEC_ERROR_OFFSET));
        EXPECT_EQ(errorProc->ProcessStarv2OneElementInRingBuffer(ctlInfo, 0, 1), RT_ERROR_NONE);
    }

    // --- FUSION_KERNEL_ERROR + Ext 合并：base + aicExt + aivExt 三段 element ---
    {
        RingBufferElementInfo* info = InitRingBuffer(ctlInfo, 3);
        uintptr_t infoAddr = reinterpret_cast<uintptr_t>(info);

        StarsDeviceErrorInfoRingBuffer* rbErr = reinterpret_cast<StarsDeviceErrorInfoRingBuffer*>(info + 1);
        info->errorType = FUSION_KERNEL_ERROR;
        rbErr->u.fusionKernelErrorInfo.aicError = 1;
        rbErr->u.fusionKernelErrorInfo.aivError = 1;
        rbErr->u.fusionKernelErrorInfo.aicInfo.comm.type = AICORE_ERROR;
        rbErr->u.fusionKernelErrorInfo.aicInfo.comm.coreNum = 2;
        rbErr->u.fusionKernelErrorInfo.aicInfo.info[0].coreId = 5;
        rbErr->u.fusionKernelErrorInfo.aicInfo.info[1].coreId = 25;
        rbErr->u.fusionKernelErrorInfo.aivInfo.comm.type = AIVECTOR_ERROR;
        rbErr->u.fusionKernelErrorInfo.aivInfo.comm.coreNum = 2;
        rbErr->u.fusionKernelErrorInfo.aivInfo.info[0].coreId = 7;
        rbErr->u.fusionKernelErrorInfo.aivInfo.info[1].coreId = 27;

        // AIC ext
        RingBufferElementInfo* aicExtInfo =
            reinterpret_cast<RingBufferElementInfo*>(infoAddr + RINGBUFFER_EXT_ONE_ELEMENT_LENGTH_ON_DAVID);
        DavidCoreErrorInfoExt* aicExtData = reinterpret_cast<DavidCoreErrorInfoExt*>(aicExtInfo + 1);
        aicExtInfo->errorType = AICORE_EXT_ERROR;
        aicExtData->comm.coreNum = 2;
        aicExtData->info[1].coreId = 25;
        aicExtData->info[1].validSize = sizeof(aicExtData->info[1].aicCond);
        aicExtData->info[1].aicCond = 0x1234U;

        // AIV ext
        RingBufferElementInfo* aivExtInfo =
            reinterpret_cast<RingBufferElementInfo*>(infoAddr + 2 * RINGBUFFER_EXT_ONE_ELEMENT_LENGTH_ON_DAVID);
        DavidCoreErrorInfoExt* aivExtData = reinterpret_cast<DavidCoreErrorInfoExt*>(aivExtInfo + 1);
        aivExtInfo->errorType = AIVECTOR_EXT_ERROR;
        aivExtData->comm.coreNum = 2;
        aivExtData->info[1].coreId = 27;
        aivExtData->info[1].validSize = sizeof(aivExtData->info[1].aicCond);
        aivExtData->info[1].aicCond = 0x9abcU;

        EXPECT_EQ(errorProc->ProcessStarv2OneElementInRingBuffer(ctlInfo, 0, 3), RT_ERROR_NONE);
    }

    // --- 无效输入：elementSize=0 ---
    InitRingBuffer(ctlInfo, 1, 0);
    EXPECT_EQ(errorProc->ProcessStarv2OneElementInRingBuffer(ctlInfo, 0, 1), RT_ERROR_INVALID_VALUE);

    DevRingBufferCtlInfo stackCtlInfo = {RINGBUFFER_MAGIC, 0U, 1U, RINGBUFFER_LEN, 0U, 0U, 0U};
    uint16_t errorStreamId = 0;
    Driver* driver = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    EXPECT_EQ(errorProc->ProcessReportRingBuffer(&stackCtlInfo, driver, &errorStreamId), RT_ERROR_INVALID_VALUE);

    free(ctlInfo);
    CleanupErrorProc(errorProc, device);
    rtDeviceReset(1);
}

// ============================================================================
// 3. ProcessStarv2OneElementInRingBuffer 全路径验证
//    覆盖：AICORE 3 core（含 isConcurrentExe、ostTaskOneCore 两组）→ PrintErrorInfo(1) + RT_ERROR_NONE、
//          AICPU 错误 → 仅 PrintErrorInfo(1) 不触发回调、
//          FUSION_KERNEL_ERROR → PrintErrorInfo(1) + 子任务 aicError 处理、
//          AICORE + FUSION_KERNEL task type → PrintErrorInfo(1) + TaskFailCallBackForFusionKernelTask(3)
// ============================================================================
TEST_F(Arch9201ErrorProcTest, ProcessStarv2OneElement_AicoreAicpuFusionError)
{
    rtSetDevice(1);
    Device* device = ((Runtime*)Runtime::Instance())->DeviceRetain(1, 0);
    DeviceErrorProc* errorProc = new DeviceErrorProc(device);
    DevRingBufferCtlInfo* ctlInfo = (DevRingBufferCtlInfo*)malloc(DEVICE_ERROR_EXT_RINGBUFFER_SIZE);
    ASSERT_NE(ctlInfo, nullptr);

    MOCKER(StreamNopTask).stubs().will(returnValue(RT_ERROR_NONE));
    rtStream_t streamHandle = nullptr;
    rtStreamCreate(&streamHandle, 0);
    Stream* stream = rt_ut::UnwrapOrNull<Stream>(streamHandle);

    // --- AICORE 3 core：PrintErrorInfo(1) + RT_ERROR_NONE ---
    {
        TaskInfo taskInfo = {};
        taskInfo.stream = stream;
        taskInfo.type = TS_TASK_TYPE_KERNEL_AIVEC;
        MOCKER_CPP(&TaskFactory::GetTask).stubs().will(returnValue(&taskInfo));
        MOCKER(TaskFailCallBack).stubs().will(returnValue(&taskInfo));
        MOCKER(GetTaskInfo).stubs().will(returnValue(&taskInfo));
        MOCKER(PrintErrorInfo).stubs().will(invoke(PrintErrorInfoStub));

        RingBufferElementInfo* info = InitRingBuffer(ctlInfo, 1);
        StarsDeviceErrorInfoRingBuffer* rbErr = reinterpret_cast<StarsDeviceErrorInfoRingBuffer*>(info + 1);
        info->errorType = AICORE_ERROR;
        rbErr->u.davidCoreErrorInfo.comm.type = AICORE_ERROR;
        rbErr->u.davidCoreErrorInfo.comm.coreNum = 3;
        rbErr->u.davidCoreErrorInfo.info[0].coreId = 0;
        rbErr->u.davidCoreErrorInfo.info[0].isConcurrentExe = 0;
        rbErr->u.davidCoreErrorInfo.info[0].ostTaskOneCore[0] = {0, 0, 0x100};
        rbErr->u.davidCoreErrorInfo.info[0].ostTaskOneCore[1] = {1, 0, 0x200};
        rbErr->u.davidCoreErrorInfo.info[1].coreId = 1;
        rbErr->u.davidCoreErrorInfo.info[1].isConcurrentExe = 1;
        rbErr->u.davidCoreErrorInfo.info[1].ostTaskOneCore[0] = {0, 0, 0x300};
        rbErr->u.davidCoreErrorInfo.info[1].ostTaskOneCore[1] = {1, 1, 0x400};
        rbErr->u.davidCoreErrorInfo.info[2].coreId = 2;
        rbErr->u.davidCoreErrorInfo.info[2].isConcurrentExe = 0;
        rbErr->u.davidCoreErrorInfo.info[2].ostTaskOneCore[0] = {0, 1, 0x500};
        rbErr->u.davidCoreErrorInfo.info[2].ostTaskOneCore[1] = {0, 0, 0};

        g_printErrCnt = 0;
        g_callCnt = 0;
        EXPECT_EQ(errorProc->ProcessStarv2OneElementInRingBuffer(ctlInfo, 0, 1, 1), RT_ERROR_NONE);
        EXPECT_EQ(g_printErrCnt, 1U);
        EXPECT_EQ(g_callCnt, 0U);
    }

    // --- AICPU：仅 PrintErrorInfo(1)，不触发回调 ---
    {
        TaskInfo taskInfo = {};
        taskInfo.stream = stream;
        MOCKER_CPP(&TaskFactory::GetTask).stubs().will(returnValue(&taskInfo));
        MOCKER(PrintErrorInfo).stubs().will(invoke(PrintErrorInfoStub));

        RingBufferElementInfo* info = InitRingBuffer(ctlInfo, 1);
        StarsDeviceErrorInfoRingBuffer* rbErr = reinterpret_cast<StarsDeviceErrorInfoRingBuffer*>(info + 1);
        info->errorType = AICPU_ERROR;
        rbErr->u.aicpuErrorInfo.comm.type = AICPU_ERROR;
        rbErr->u.aicpuErrorInfo.comm.streamId = 0;
        rbErr->u.aicpuErrorInfo.comm.taskId = 0;

        g_printErrCnt = 0;
        g_callCnt = 0;
        EXPECT_EQ(errorProc->ProcessStarv2OneElementInRingBuffer(ctlInfo, 0, 1, 1), RT_ERROR_NONE);
        EXPECT_EQ(g_printErrCnt, 1U);
        EXPECT_EQ(g_callCnt, 0U);
    }

    // --- FUSION_KERNEL_ERROR：PrintErrorInfo(1)，子任务 aicError 处理 ---
    {
        TaskInfo taskInfo = {};
        taskInfo.stream = stream;
        taskInfo.type = TS_TASK_TYPE_FUSION_KERNEL;
        MOCKER_CPP(&TaskFactory::GetTask).stubs().will(returnValue(&taskInfo));
        MOCKER(GetTaskInfo).stubs().will(returnValue(&taskInfo));
        MOCKER(PrintErrorInfo).stubs().will(invoke(PrintErrorInfoStub));

        RingBufferElementInfo* info = InitRingBuffer(ctlInfo, 1);
        StarsDeviceErrorInfoRingBuffer* rbErr = reinterpret_cast<StarsDeviceErrorInfoRingBuffer*>(info + 1);
        info->errorType = FUSION_KERNEL_ERROR;
        rbErr->u.fusionKernelErrorInfo.comm.type = FUSION_KERNEL_ERROR;
        rbErr->u.fusionKernelErrorInfo.aicError = 1;
        rbErr->u.fusionKernelErrorInfo.aicInfo.comm.type = AICORE_ERROR;
        rbErr->u.fusionKernelErrorInfo.aicInfo.comm.coreNum = 2;
        rbErr->u.fusionKernelErrorInfo.aicInfo.info[0].coreId = 5;
        rbErr->u.fusionKernelErrorInfo.aicInfo.info[1].coreId = 25;

        g_printErrCnt = 0;
        g_callCnt = 0;
        EXPECT_EQ(errorProc->ProcessStarv2OneElementInRingBuffer(ctlInfo, 0, 1, 1), RT_ERROR_NONE);
        EXPECT_EQ(g_printErrCnt, 1U);
        EXPECT_EQ(g_callCnt, 0U);
    }

    // --- AICORE + FUSION_KERNEL task type → PrintErrorInfo(1) + TaskFailCallBackForFusionKernelTask(3) ---
    {
        TaskInfo taskInfo = {};
        taskInfo.stream = stream;
        taskInfo.type = TS_TASK_TYPE_FUSION_KERNEL;
        taskInfo.u.fusionKernelTask.sqeSubType = 0;
        MOCKER_CPP(&TaskFactory::GetTask).stubs().will(returnValue(&taskInfo));
        MOCKER(GetTaskInfo).stubs().will(returnValue(&taskInfo));
        MOCKER(PrintErrorInfo).stubs().will(invoke(PrintErrorInfoStub));
        MOCKER(TaskFailCallBackForFusionKernelTask).stubs().will(invoke(TaskFailCallBackForFusionKernelTaskStub));

        RingBufferElementInfo* info = InitRingBuffer(ctlInfo, 1);
        StarsDeviceErrorInfoRingBuffer* rbErr = reinterpret_cast<StarsDeviceErrorInfoRingBuffer*>(info + 1);
        info->errorType = AICORE_ERROR;
        rbErr->u.davidCoreErrorInfo.comm.type = AICORE_ERROR;
        rbErr->u.davidCoreErrorInfo.comm.coreNum = 2;
        rbErr->u.davidCoreErrorInfo.info[0].coreId = 0;
        rbErr->u.davidCoreErrorInfo.info[0].isConcurrentExe = 0;
        rbErr->u.davidCoreErrorInfo.info[0].ostTaskOneCore[0] = {0, 0, 0x100};
        rbErr->u.davidCoreErrorInfo.info[0].ostTaskOneCore[1] = {1, 0, 0x200};
        rbErr->u.davidCoreErrorInfo.info[1].coreId = 1;
        rbErr->u.davidCoreErrorInfo.info[1].isConcurrentExe = 1;
        rbErr->u.davidCoreErrorInfo.info[1].ostTaskOneCore[0] = {0, 0, 0x300};
        rbErr->u.davidCoreErrorInfo.info[1].ostTaskOneCore[1] = {1, 1, 0x400};

        g_printErrCnt = 0;
        g_callCnt = 0;
        EXPECT_EQ(errorProc->ProcessStarv2OneElementInRingBuffer(ctlInfo, 0, 1, 1), RT_ERROR_NONE);
        EXPECT_EQ(g_printErrCnt, 1U);
        EXPECT_EQ(g_callCnt, 3U);
    }

    rtStreamDestroy(streamHandle);
    free(ctlInfo);
    CleanupErrorProc(errorProc, device);
    rtDeviceReset(1);
}
