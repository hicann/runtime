/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <vector>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#include "tsd.h"
#include "stub/aicpusd_context.h"
#include "common/aicpusd_context.h"
#include "aicpu_event_struct.h"
#include "aicpusd_cust_so_manager.h"
#include "aicpusd_event_manager.h"
#include "aicpusd_event_process.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_model.h"
#include "aicpusd_resource_manager.h"
#include "hwts_kernel_cust_so.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "hwts_kernel_stub.h"

using namespace AicpuSchedule;

class LoadOpFromBuffKernelTest : public EventProcessKernelTest {
protected:
    LoadOpFromBuffTsKernel kernel_;
};

TEST_F(LoadOpFromBuffKernelTest, TsKernelLoadOpFromBuf)
{
    MOCKER(halGrpQuery)
    .stubs()
    .will(invoke(halGrpQueryWithTwoGroup));
    MOCKER(halGrpAttach)
    .stubs()
    .will(returnValue(0));
    MOCKER(CreateOrFindCustPid, int32_t(const uint32_t, const uint32_t, const char * const *,
        const uint32_t, const uint32_t, const char *, const uint32_t, int32_t*, bool*))
        .stubs()
        .will(invoke(CreateOrFindCustPidStub));
    aicpu::SetHaveCustPid(false);
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3200, 0, false);
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    uint32_t deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
    bool hasThread = AicpuDrvManager::GetInstance().HasThread();
    pid_t hostPid = AicpuDrvManager::GetInstance().GetHostPid();
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "loadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for loadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = strlen(soContent);
    char kernelSoNameContent[] = "libcust_aicpu_kernels.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = strlen(kernelSoNameContent);

    struct LoadOpFromBufArgs loadOpFromBufArgs;
    loadOpFromBufArgs.kernelSoBuf = kernelSoBuf;
    loadOpFromBufArgs.kernelSoBufLen = kernelSoBufLen;
    loadOpFromBufArgs.kernelSoName = kernelSoName;
    loadOpFromBufArgs.kernelSoNameLen = kernelSoNameLen;

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(&loadOpFromBufArgs));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }
    MOCKER(&AicpuCustSoManager::CheckSoFullPathValid).stubs().will(returnValue(0));
    int retStatus = kernel_.Compute(tsKernelInfo);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, hostPid, 0, hasThread);
    std::string command = "rm -rf ";
    command.append(dirName).append("cust_aicpu_0_3200").append("/");
    int ret = system(command.c_str());
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_OK);
}

TEST_F(LoadOpFromBuffKernelTest, TsKernelLoadOpFromBuf_01)
{
    aicpu::SetHaveCustPid(false);
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::PROCESS_PCIE_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    uint32_t deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
    bool hasThread = AicpuDrvManager::GetInstance().HasThread();
    pid_t hostPid = AicpuDrvManager::GetInstance().GetHostPid();
    MOCKER_CPP(&CustOperationCommon::StartCustProcess)
        .stubs()
        .will(returnValue((int32_t)AICPU_SCHEDULE_ERROR_INNER_ERROR));
    MOCKER_CPP(&AicpuCustSoManager::CheckAndCreateSoFile)
        .stubs()
        .will(returnValue((int32_t)AICPU_SCHEDULE_OK));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3200, 0, false);
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "loadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for loadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = strlen(soContent);
    char kernelSoNameContent[] = "libcust_aicpu_kernels1.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = strlen(kernelSoNameContent);

    struct LoadOpFromBufArgs loadOpFromBufArgs;
    loadOpFromBufArgs.kernelSoBuf = kernelSoBuf;
    loadOpFromBufArgs.kernelSoBufLen = kernelSoBufLen;
    loadOpFromBufArgs.kernelSoName = kernelSoName;
    loadOpFromBufArgs.kernelSoNameLen = kernelSoNameLen;

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(&loadOpFromBufArgs));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }
    int retStatus = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_ERROR_INNER_ERROR);
    retStatus = kernel_.Compute(tsKernelInfo);
    deviceVec[0] = 0;
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, hostPid, 0, hasThread);
    std::string command = "rm -rf ";
    command.append(dirName).append("cust_aicpu_0_3200").append("/");
    int ret = system(command.c_str());
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_OK);
}

TEST_F(LoadOpFromBuffKernelTest, TsKernelLoadOpFromBuf_failed1)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    MOCKER_CPP(&AicpuCustSoManager::CreateSoFile)
        .stubs()
        .will(returnValue((int32_t)AICPU_SCHEDULE_OK));
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "loadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for loadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = 0;
    char kernelSoNameContent[] = "libcust_aicpu_kernels.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = strlen(kernelSoNameContent);

    struct LoadOpFromBufArgs loadOpFromBufArgs;
    loadOpFromBufArgs.kernelSoBuf = kernelSoBuf;
    loadOpFromBufArgs.kernelSoBufLen = kernelSoBufLen;
    loadOpFromBufArgs.kernelSoName = kernelSoName;
    loadOpFromBufArgs.kernelSoNameLen = kernelSoNameLen;

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(&loadOpFromBufArgs));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(LoadOpFromBuffKernelTest, TsKernelLoadOpFromBuf_failed2)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    MOCKER_CPP(&AicpuCustSoManager::CreateSoFile)
        .stubs()
        .will(returnValue((int32_t)AICPU_SCHEDULE_OK));
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "loadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for loadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = strlen(soContent);
    char kernelSoNameContent[] = "libcust_aicpu_kernels.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = 0;

    struct LoadOpFromBufArgs loadOpFromBufArgs;
    loadOpFromBufArgs.kernelSoBuf = kernelSoBuf;
    loadOpFromBufArgs.kernelSoBufLen = kernelSoBufLen;
    loadOpFromBufArgs.kernelSoName = kernelSoName;
    loadOpFromBufArgs.kernelSoNameLen = kernelSoNameLen;

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(&loadOpFromBufArgs));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(LoadOpFromBuffKernelTest, TsKernelLoadOpFromBuf_failed3)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    MOCKER(CreateOrFindCustPid, int32_t(const uint32_t, const uint32_t, const char * const *,
        const uint32_t, const uint32_t, const char *, const uint32_t, int32_t*, bool*))
        .stubs()
        .will(invoke(CreateOrFindCustPidFailedStub));
    MOCKER_CPP(&AicpuCustSoManager::CreateSoFile)
        .stubs()
        .will(returnValue((int32_t)AICPU_SCHEDULE_ERROR_INNER_ERROR));
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "loadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for loadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = strlen(soContent);
    char kernelSoNameContent[] = "libcust_aicpu_kernels_fail.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = strlen(kernelSoNameContent);

    struct LoadOpFromBufArgs loadOpFromBufArgs;
    loadOpFromBufArgs.kernelSoBuf = kernelSoBuf;
    loadOpFromBufArgs.kernelSoBufLen = kernelSoBufLen;
    loadOpFromBufArgs.kernelSoName = kernelSoName;
    loadOpFromBufArgs.kernelSoNameLen = kernelSoNameLen;

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(&loadOpFromBufArgs));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(LoadOpFromBuffKernelTest, TsKernelLoadOpFromBuf_failed4)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    MOCKER_CPP(&AicpuCustSoManager::CreateSoFile)
        .stubs()
        .will(returnValue((int32_t)AICPU_SCHEDULE_ERROR_INNER_ERROR));
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "loadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for loadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = strlen(soContent);
    char kernelSoNameContent[] = "libcust_cpu_kernels.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = strlen(kernelSoNameContent);

    struct LoadOpFromBufArgs loadOpFromBufArgs;
    loadOpFromBufArgs.kernelSoBuf = kernelSoBuf;
    loadOpFromBufArgs.kernelSoBufLen = kernelSoBufLen;
    loadOpFromBufArgs.kernelSoName = kernelSoName;
    loadOpFromBufArgs.kernelSoNameLen = kernelSoNameLen;

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(&loadOpFromBufArgs));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(LoadOpFromBuffKernelTest, TsKernelLoadOpFromBufNotSupport)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_MSGQ);

    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "loadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}