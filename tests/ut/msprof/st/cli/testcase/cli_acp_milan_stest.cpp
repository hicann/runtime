/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <iostream>
#include <fstream>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "device_simulator_manager.h"
#include "errno/error_code.h"
#include "msprof_start.h"
#include "../stub/cli_stub.h"
#include "data_manager.h"
#include "platform/platform.h"
#include "utils.h"
#include "hdc_api.h"

using namespace analysis::dvvp::common::error;
using namespace Cann::Dvvp::Test;

rtError_t rtDevBinaryRegisterStub(const rtDevBinary_t *bin, void **hdl)
{
    UNUSED(bin);
    UNUSED(hdl);
    return ACL_RT_SUCCESS;
}

rtError_t rtDevBinaryUnRegisterStub(void *hdl)
{
    UNUSED(hdl);
    return ACL_RT_SUCCESS;
}

rtError_t rtFunctionRegisterStub(void *binHandle, const void *stubFunc,
                             const char_t *stubName, const void *kernelInfoExt,
                             uint32_t funcMode)
{
    UNUSED(binHandle);
    UNUSED(stubFunc);
    UNUSED(stubName);
    UNUSED(kernelInfoExt);
    UNUSED(funcMode);
    return ACL_RT_SUCCESS;
}

// dynamic operator register
rtError_t rtRegisterAllKernelStub(const rtDevBinary_t *bin, void **hdl)
{
    UNUSED(bin);
    UNUSED(hdl);
    return ACL_RT_SUCCESS;
}

rtError_t rtGetBinaryDeviceBaseAddrStub(void* handle, void** launchBase)
{
    UNUSED(handle);
    UNUSED(launchBase);
    return ACL_RT_SUCCESS;
}

int32_t rtKernelLaunchStub(const void *stubFunc, uint32_t blockDim, void *args, uint32_t argsSize, rtSmDesc_t *smDesc,
    rtStream_t stm)
{
    UNUSED(stubFunc);
    UNUSED(blockDim);
    UNUSED(args);
    UNUSED(argsSize);
    UNUSED(smDesc);
    UNUSED(stm);
    executeStub();
    return ACL_RT_SUCCESS;
}

int32_t rtKernelLaunchWithHandleStub(void *hdl, const uint64_t tilingKey, uint32_t blockDim, rtArgsEx_t *argsInfo,
    rtSmDesc_t *smDesc, rtStream_t stm, const void *kernelInfo)
{
    UNUSED(hdl);
    UNUSED(tilingKey);
    UNUSED(blockDim);
    UNUSED(argsInfo);
    UNUSED(kernelInfo);
    UNUSED(smDesc);
    UNUSED(stm);
    executeStub();
    return ACL_RT_SUCCESS;
}

int32_t rtKernelLaunchWithHandleV2Stub(void *hdl, const uint64_t tilingKey, uint32_t blockDim, rtArgsEx_t *argsInfo,
    rtSmDesc_t *smDesc, rtStream_t stm, const rtTaskCfgInfo_t *cfgInfo)
{
    UNUSED(hdl);
    UNUSED(tilingKey);
    UNUSED(blockDim);
    UNUSED(argsInfo);
    UNUSED(smDesc);
    UNUSED(stm);
    UNUSED(cfgInfo);
    executeStub();
    return ACL_RT_SUCCESS;
}

int32_t rtKernelLaunchWithFlagStub(const void *stubFunc, uint32_t blockDim, rtArgsEx_t *argsInfo, rtSmDesc_t *smDesc,
    rtStream_t stm, uint32_t flags)
{
    UNUSED(stubFunc);
    UNUSED(blockDim);
    UNUSED(argsInfo);
    UNUSED(stm);
    UNUSED(flags);
    executeStub();
    return ACL_RT_SUCCESS;
}

int32_t rtKernelLaunchWithFlagV2Stub(const void *stubFunc, uint32_t blockDim, rtArgsEx_t *argsInfo, rtSmDesc_t *smDesc,
    rtStream_t stm, uint32_t flags, const rtTaskCfgInfo_t *cfgInfo)
{
    UNUSED(stubFunc);
    UNUSED(blockDim);
    UNUSED(argsInfo);
    UNUSED(smDesc);
    UNUSED(stm);
    UNUSED(flags);
    UNUSED(cfgInfo);
    executeStub();
    return ACL_RT_SUCCESS;
}

rtError_t rtStreamSynchronizeStub(rtStream_t stream)
{
    UNUSED(stream);
    return ACL_RT_SUCCESS;
}

rtError_t rtProfSetProSwitchStub(void *data, uint32_t len)
{
    UNUSED(data);
    UNUSED(len);
    return ACL_RT_SUCCESS;
}

int32_t dlcloseStub(void *handle)
{
    return 0;
}


int32_t g_dlopenStubs;
void * dlopenStubAcp(const char *fileName, int mode)
{
    if (strcmp(fileName, "libruntime.so") == 0) {
        return &g_dlopenStubs;
    }
    return nullptr;
}

int32_t rtSetDeviceStub(int32_t devId) {
    UNUSED(devId);
    return ACL_RT_SUCCESS;
}

static int32_t rtMallocStub(void **devPtr, uint64_t size, rtMemType_t type, const uint16_t moduleId)
{
    (void)type;
    (void)moduleId;
    *devPtr = malloc(size);
    return ACL_RT_SUCCESS;
}
 
static int32_t rtFreeStub(void *devPtr)
{
    free(devPtr);
    return ACL_RT_SUCCESS;
}
 
static int32_t rtMemcpyAsyncStub(void *dst, uint64_t destMax, const void *src, uint64_t cnt,
    rtMemcpyKind_t kind, rtStream_t stm)
{
    (void)kind;
    (void)stm;
    memcpy_s(dst, destMax, src, cnt);
    return ACL_RT_SUCCESS;
}

static int32_t rtSetDeviceCount = 0;

static void *dlsymStub(void *handle, const char *symbol) {
    std::string symbolString = symbol;
    if (symbolString == "rtSetDevice") {
        return (void *)rtSetDeviceStub;
    } else if (symbolString == "rtKernelLaunch") {
        return (void *)rtKernelLaunchStub;
    } else if (symbolString == "rtStreamSynchronize") {
        return (void *)rtStreamSynchronizeStub;
    } else if (symbolString == "rtKernelLaunchWithHandle") {
        return (void *)rtKernelLaunchWithHandleStub;
    } else if (symbolString == "rtKernelLaunchWithHandleV2") {
        return (void *)rtKernelLaunchWithHandleV2Stub;
    } else if (symbolString == "rtKernelLaunchWithFlag") {
        return (void *)rtKernelLaunchWithFlagStub;
    } else if (symbolString == "rtKernelLaunchWithFlagV2") {
        return (void *)rtKernelLaunchWithFlagV2Stub;
    } else if (symbolString == "rtProfSetProSwitch") {
        return (void *)rtProfSetProSwitchStub;
    } else if (symbolString == "rtDevBinaryRegister") {
        return (void *)rtDevBinaryRegisterStub;
    } else if (symbolString == "rtDevBinaryUnRegister") {
        return (void *)rtDevBinaryUnRegisterStub;
    } else if (symbolString == "rtFunctionRegister") {
        return (void *)rtFunctionRegisterStub;
    } else if (symbolString == "rtRegisterAllKernel") {
        return (void *)rtRegisterAllKernelStub;
    } else if (symbolString == "rtGetBinaryDeviceBaseAddr") {
        return (void *)rtGetBinaryDeviceBaseAddrStub;
    } else if (symbolString == "rtMalloc") {
        return (void *)rtMallocStub;
    } else if (symbolString == "rtFree") {
        return (void *)rtFreeStub;
    } else if (symbolString == "rtMemcpyAsync") {
        return (void *)rtMemcpyAsyncStub;
    }
    return (void *)0x87654321;
}

class CliAcpMilanStest: public testing::Test {
protected:
    virtual void SetUp()
    {
        DlStub();
        const ::testing::TestInfo* curTest = ::testing::UnitTest::GetInstance()->current_test_info();
        DataMgr().Init("milan", curTest->name());
        optind = 1;
        system("mkdir ./cliAcpStest_workspace");
        system("touch ./cli");
        MsprofMgr().SetProfDir("OPPROF");
        MOCKER(mmCreateProcess).stubs().will(invoke(mmCreateProcessAcpStub));
        EXPECT_EQ(2, SimulatorMgr().CreateDeviceSimulator(2, StPlatformType::CHIP_V4_1_0));
        SimulatorMgr().SetSocSide(SocType::HOST);
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
        EXPECT_EQ(2, SimulatorMgr().DelDeviceSimulator(2, StPlatformType::CHIP_V4_1_0));
        system("rm -rf ./cliAcpStest_workspace");
        system("rm -rf ./cli");
        DataMgr().UnInit();
        MsprofMgr().UnInit();
        MsprofMgr().SetProfDir("");
    }
    void SetPerfEnv()
    {
        MOCKER(mmWaitPid).stubs().will(returnValue(1));
        std::string perfDataDirStub = "./perf";
        MockPerfDir(perfDataDirStub);
    }
    void DlStub()
    {
        MOCKER(dlclose).stubs().will(invoke(dlcloseStub));
        MOCKER(dlopen).stubs().will(invoke(dlopenStubAcp));
        MOCKER(dlsym).stubs().will(invoke(dlsymStub));
    }
};

TEST_F(CliAcpMilanStest, CliArithmeticUtilizationTask)
{
    // milan: Task-based AI core/vector metrics: ArithmeticUtilization
    const char* argv[] = {"--aic-metrics=ArithmeticUtilization",};
    std::vector<std::string> dataList = {"ArithmeticUtilization.csv", "op_summary"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AcpProfileStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliAcpMilanStest, CliPipeUtilizationTask)
{
    // milan: Task-based AI core/vector metrics: PipeUtilization
    const char* argv[] = {"--aic-metrics=PipeUtilization",};
    std::vector<std::string> dataList = {"PipeUtilization.csv", "op_summary"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AcpProfileStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliAcpMilanStest, CliMemoryTask)
{
    // milan: Task-based AI core/vector metrics: Memory
    const char* argv[] = {"--aic-metrics=Memory",};
    std::vector<std::string> dataList = {"Memory.csv", "op_summary"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AcpProfileStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliAcpMilanStest, CliMemoryL0Task)
{
    // milan: Task-based AI core/vector metrics: MemoryL0
    const char* argv[] = {"--aic-metrics=MemoryL0",};
    std::vector<std::string> dataList = {"MemoryL0.csv", "op_summary"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AcpProfileStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliAcpMilanStest, CliResourceConflictRatioTask)
{
    // milan: Task-based AI core/vector metrics: ResourceConflictRatio
    const char* argv[] = {"--aic-metrics=ResourceConflictRatio",};
    std::vector<std::string> dataList = {"ResourceConflictRatio.csv", "op_summary"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AcpProfileStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliAcpMilanStest, CliMemoryUBTask)
{
    // milan: Task-based AI core/vector metrics: MemoryUB
    const char* argv[] = {"--aic-metrics=MemoryUB",};
    std::vector<std::string> dataList = {"MemoryUB.csv", "op_summary"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AcpProfileStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliAcpMilanStest, CliL2CacheTask)
{
    // milan: Task-based AI core/vector metrics: L2Cache
    const char* argv[] = {"--aic-metrics=L2Cache",};
    std::vector<std::string> dataList = {"L2Cache.csv", "op_summary"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AcpProfileStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliAcpMilanStest, CliMultiMetricsTask)
{
    // milan: Task-based AI core/vector metrics: all
    const char* argv[] = {"--aic-metrics=PipeUtilization,ArithmeticUtilization,Memory,MemoryUB,L2Cache,MemoryL0,ResourceConflictRatio",};
    std::vector<std::string> dataList = {"op_summary"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AcpProfileStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliAcpMilanStest, CliMultiMetricsOverFlowTask)
{
    // milan: Task-based AI core/vector metrics: overflow
    const char* argv[] = {"--aic-metrics=PipeUtilization,ArithmeticUtilization,Memory,MemoryUB,L2Cache,MemoryL0,ResourceConflictRatio,PipeUtilization",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AcpProfileStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliAcpMilanStest, CliMultiMetricsSameTask)
{
    // milan: Task-based AI core/vector metrics: same
    const char* argv[] = {"--aic-metrics=PipeUtilization,PipeUtilization,PipeUtilization",};
    std::vector<std::string> dataList = {"op_summary"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AcpProfileStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliAcpMilanStest, CliCustomUpperTask)
{
    // milan: Task-based AI core/vector metrics: upper
    const char* argv[] = {"--aic-metrics=Custom:0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8,0x9,0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,0x20,0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x30",};
    std::vector<std::string> dataList = {"op_summary"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AcpProfileStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliAcpMilanStest, CliCustomOverFlowTask)
{
    // milan: Task-based AI core/vector metrics: upper
    const char* argv[] = {"--aic-metrics=Custom:0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8,0x9,0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,0x20,0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x30,0x31",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AcpProfileStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliAcpMilanStest, CliCustomLowerTask)
{
    // milan: Task-based AI core/vector metrics: upper
    const char* argv[] = {"--aic-metrics=Custom:",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AcpProfileStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliAcpMilanStest, CliCustomInvalidTask)
{
    // milan: Task-based AI core/vector metrics: upper
    const char* argv[] = {"--aic-metrics=Custom:0x!@#$%^&*",};
    EXPECT_EQ(PROFILING_FAILED, MsprofMgr().AcpProfileStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}

TEST_F(CliAcpMilanStest, CliCustomSameTask)
{
    // milan: Task-based AI core/vector metrics: same
    const char* argv[] = {"--aic-metrics=Custom:0x1,0x2,0x3,0x1,0x2,0x3,0x7,0x8,0x9,0x10,0x11,0x12,0x11,0x12,0x15,0x16,0x17,0x18,0x18,0x20,0x21,0x22,0x23,0x22,0x23,0x26,0x27,0x28,0x29,0x29",};
    std::vector<std::string> dataList = {"op_summary"};
    MsprofMgr().SetDeviceCheckList(dataList);
    EXPECT_EQ(PROFILING_SUCCESS, MsprofMgr().AcpProfileStartByAppMode(sizeof(argv) / sizeof(char *), argv));
}