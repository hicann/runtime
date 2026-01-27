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

class DeleteCustOpKernelTest : public EventProcessKernelTest {
protected:
    DeleteCustOpTsKernel kernel_;
};

TEST_F(DeleteCustOpKernelTest, TsKernelBatchLoadOpFromBuf_success)
{
    MOCKER(&AicpuCustSoManager::CheckSoFullPathValid).stubs().will(returnValue(0));
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

    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    bool hasThread = AicpuDrvManager::GetInstance().HasThread();
    pid_t hostPid = AicpuDrvManager::GetInstance().GetHostPid();
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3001, 0, true);
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "batchLoadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for batchLoadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = strlen(soContent);
    char kernelSoNameContent[] = "libcust_aicpu_kernels.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = strlen(kernelSoNameContent);

    char soContent2[] = "batchLoadOpFromBuf batchLoadOpFromBuf batchLoadOpFromBuf";
    uint64_t kernelSoBuf2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent2));
    uint32_t kernelSoBufLen2 = strlen(soContent2);
    char kernelSoNameContent2[] = "libcust_aicpu_kernels2.so";
    uint64_t kernelSoName2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent2));
    uint32_t kernelSoNameLen2 = strlen(kernelSoNameContent2);

    uint32_t num = 2;
    BatchLoadOpFromBufArgs *p=(BatchLoadOpFromBufArgs*)malloc(sizeof(BatchLoadOpFromBufArgs)+sizeof(LoadOpFromBufArgs)*num);
    p->soNum=num;
    std::vector<LoadOpFromBufArgs> v_cust_so;
    LoadOpFromBufArgs custSoInfo;
    custSoInfo.kernelSoBuf=kernelSoBuf;
    custSoInfo.kernelSoBufLen=kernelSoBufLen;
    custSoInfo.kernelSoName=kernelSoName;
    custSoInfo.kernelSoNameLen=kernelSoNameLen;
    v_cust_so.push_back(custSoInfo);
    LoadOpFromBufArgs custSoInfo2;
    custSoInfo2.kernelSoBuf=kernelSoBuf2;
    custSoInfo2.kernelSoBufLen=kernelSoBufLen2;
    custSoInfo2.kernelSoName=kernelSoName2;
    custSoInfo2.kernelSoNameLen=kernelSoNameLen2;
    v_cust_so.push_back(custSoInfo2);

    p->opInfoArgs=reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(v_cust_so.data()));

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(p));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }
    int retStatus = kernel_.Compute(tsKernelInfo);

    EXPECT_EQ(retStatus, AICPU_SCHEDULE_OK);
    retStatus = kernel_.Compute(tsKernelInfo);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, hostPid, 0, hasThread);

    std::string command = "rm -rf ";
    command = command + dirName + "cust_aicpu_0_3001";
    int ret = system(command.c_str());

    free (p);
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_OK);
}

TEST_F(DeleteCustOpKernelTest, TsKernelBatchLoadOpFromBuf_fail4)
{
    MOCKER(&AicpuCustSoManager::CheckSoFullPathValid).stubs().will(returnValue(0));
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
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3004, 0, true);
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    bool hasThread = AicpuDrvManager::GetInstance().HasThread();
    pid_t hostPid = AicpuDrvManager::GetInstance().GetHostPid();
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "batchLoadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for batchLoadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = strlen(soContent);
    char kernelSoNameContent[] = "libcust_aicpu_kernels.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = strlen(kernelSoNameContent);

    char soContent2[] = "batchLoadOpFromBuf batchLoadOpFromBuf batchLoadOpFromBuf";
    uint64_t kernelSoBuf2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent2));
    uint32_t kernelSoBufLen2 = strlen(soContent2);
    char kernelSoNameContent2[] = "libcust_aicpu_kernels2.so";
    uint64_t kernelSoName2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent2));
    uint32_t kernelSoNameLen2 = strlen(kernelSoNameContent2);

    uint32_t num = 2;
    BatchLoadOpFromBufArgs *p=(BatchLoadOpFromBufArgs*)malloc(sizeof(BatchLoadOpFromBufArgs)+sizeof(LoadOpFromBufArgs)*num);
    p->soNum=num;
    std::vector<LoadOpFromBufArgs> v_cust_so;
    LoadOpFromBufArgs custSoInfo;
    custSoInfo.kernelSoBuf=kernelSoBuf;
    custSoInfo.kernelSoBufLen=kernelSoBufLen;
    custSoInfo.kernelSoName=kernelSoName;
    custSoInfo.kernelSoNameLen=kernelSoNameLen;
    v_cust_so.push_back(custSoInfo);
    LoadOpFromBufArgs custSoInfo2;
    custSoInfo2.kernelSoBuf=kernelSoBuf2;
    custSoInfo2.kernelSoBufLen=kernelSoBufLen2;
    custSoInfo2.kernelSoName=kernelSoName2;
    custSoInfo2.kernelSoNameLen=kernelSoNameLen2;
    v_cust_so.push_back(custSoInfo2);

    p->opInfoArgs=reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(v_cust_so.data()));

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(p));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    int retStatus = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(retStatus, 0);
    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }
    std::string command = "rm -rf ";
    command = command + dirName + "cust_aicpu_0_3004/libcust_aicpu_kernels.so";
    int ret = system(command.c_str());
    retStatus = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(retStatus, 0);
    v_cust_so.clear();
    LoadOpFromBufArgs custSoInfo1;
    custSoInfo1.kernelSoBuf=kernelSoBuf;
    custSoInfo1.kernelSoBufLen=kernelSoBufLen;
    custSoInfo1.kernelSoName=kernelSoName;
    custSoInfo1.kernelSoNameLen=0;
    v_cust_so.push_back(custSoInfo1);
    p->soNum=1;
    p->opInfoArgs=reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(v_cust_so.data()));

    uint64_t paramBase2 = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(p));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    retStatus = kernel_.Compute(tsKernelInfo);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, hostPid, 0, hasThread);
    free (p);

    command = "rm -rf ";
    command = command + dirName + "cust_aicpu_0_3004";
    system(command.c_str());
    EXPECT_NE(retStatus, AICPU_SCHEDULE_OK);
}

TEST_F(DeleteCustOpKernelTest, TsKernelDeleteCustOp_fail1)
{
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3006, 0, true);
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "deleteCustOp";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for deleteCustOp";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = strlen(soContent);
    char kernelSoNameContent[] = "libcust_aicpu_kernels.so";
    uint64_t kernelSoName = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent));
    uint32_t kernelSoNameLen = strlen(kernelSoNameContent);

    char soContent2[] = "deleteCustOp deleteCustOp deleteCustOp";
    uint64_t kernelSoBuf2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent2));
    uint32_t kernelSoBufLen2 = strlen(soContent2);
    char kernelSoNameContent2[] = "../../libcust_aicpu_kernels2.so";
    uint64_t kernelSoName2 = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                       (kernelSoNameContent2));
    uint32_t kernelSoNameLen2 = strlen(kernelSoNameContent2);

    uint32_t num = 2;
    BatchLoadOpFromBufArgs *p=(BatchLoadOpFromBufArgs*)malloc(sizeof(BatchLoadOpFromBufArgs)+sizeof(LoadOpFromBufArgs)*num);
    p->soNum=num;
    std::vector<LoadOpFromBufArgs> v_cust_so;
    LoadOpFromBufArgs custSoInfo;
    custSoInfo.kernelSoBuf=kernelSoBuf;
    custSoInfo.kernelSoBufLen=kernelSoBufLen;
    custSoInfo.kernelSoName=kernelSoName;
    custSoInfo.kernelSoNameLen=kernelSoNameLen;
    v_cust_so.push_back(custSoInfo);
    LoadOpFromBufArgs custSoInfo2;
    custSoInfo2.kernelSoBuf=kernelSoBuf2;
    custSoInfo2.kernelSoBufLen=kernelSoBufLen2;
    custSoInfo2.kernelSoName=kernelSoName2;
    custSoInfo2.kernelSoNameLen=kernelSoNameLen2;
    v_cust_so.push_back(custSoInfo2);

    p->opInfoArgs=reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(v_cust_so.data()));

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(p));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }
    int retStatus = kernel_.Compute(tsKernelInfo);
    free (p);
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(DeleteCustOpKernelTest, TsKernelDeleteCustOp_fail2)
{
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3006, 0, true);
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "deleteCustOp";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    uint32_t num = 0;
    BatchLoadOpFromBufArgs *p=(BatchLoadOpFromBufArgs*)malloc(sizeof(BatchLoadOpFromBufArgs)+sizeof(LoadOpFromBufArgs)*num);
    p->soNum = num;
    p->opInfoArgs = 0;

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(p));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }
    int retStatus = kernel_.Compute(tsKernelInfo);
    free (p);
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(DeleteCustOpKernelTest, TsKernelDeleteCustOp_fail3)
{
    std::vector<uint32_t> deviceVec = {1};
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3006, 0, true);
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_MSGQ);
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "deleteCustOp";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    cceKernel.paramBase = 0;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    int retStatus = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}