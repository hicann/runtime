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
#include "hwts_kernel_cust_so.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "hwts_kernel_stub.h"

using namespace AicpuSchedule;

class CustOperationCommonTest : public EventProcessKernelTest {
protected:
    CustOperationCommon commonKernel_;
};

class BatchLoadSoFromBuffKernelTest : public EventProcessKernelTest {
protected:
    BatchLoadSoFromBuffTsKernel kernel_;
    DeleteCustOpTsKernel deleteKernel_;
};

TEST_F(CustOperationCommonTest, SendCtrlCpuMsg)
{
    int32_t ret = commonKernel_.SendCtrlCpuMsg(
        1, static_cast<uint32_t>(TsdSubEventType::TSD_EVENT_STOP_SUB_PROCESS_WAIT), nullptr, 0U);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

int halGrpQueryFake(GroupQueryCmdType cmd,
    void *inBuff, unsigned int inLen, void *outBuff, unsigned int *outLen)
{
    GroupQueryOutput *groupInfo = static_cast<GroupQueryOutput *>(outBuff);
    *outLen = sizeof(groupInfo->grpQueryGroupsOfProcInfo[0]);
    std::string tmpStr = "grp_tmp_test";
    memcpy_s(&(groupInfo->grpQueryGroupsOfProcInfo[0].groupName[0]), BUFF_GRP_NAME_LEN, tmpStr.c_str(), tmpStr.size());
    groupInfo->grpQueryGroupsOfProcInfo[0].groupName[tmpStr.size()] = '\0';
    groupInfo->grpQueryGroupsOfProcInfo[0].attr.admin = 1;
    return 0;
}

int32_t CreateOrFindCustPidFake(const uint32_t deviceId, const uint32_t loadLibNum,
    const char * const loadLibName[], const uint32_t hostPid, const uint32_t vfId, const char *groupNameList,
    const uint32_t groupNameNum, int32_t *custProcPid, bool *firstStart)
{
    *custProcPid = 123;
    *firstStart = true;
    return 0;
}

TEST_F(CustOperationCommonTest, NowaitGrp)
{
    const uint32_t loadLibNum = 1U;
    const std::unique_ptr<const char_t *[]> soNames(new (std::nothrow) const char_t *[loadLibNum]);
    MOCKER(&CreateOrFindCustPid).stubs().will(invoke(CreateOrFindCustPidFake));
    MOCKER(&halGrpQuery).stubs().will(invoke(halGrpQueryFake));
    MOCKER_CPP(&CustOperationCommon::AicpuNotifyLoadSoEventToCustCtrlCpu).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    int32_t ret = commonKernel_.StartCustProcess(loadLibNum, soNames.get());
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    GlobalMockObject::verify();
}

TEST_F(CustOperationCommonTest, AicpuNotifyLoadSoEventToCustCtrlCpu_success)
{
    const uint32_t deviceId = 0;
    const uint32_t loadLibNum = 1;
    const char *loadLibName[] = {"libaicpu_kernels.so"};
    const uint32_t hostPid = 0;
    const uint32_t vfId = 0;
    int32_t custProcPid = 0;
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(DRV_ERROR_NONE));
    const int32_t ret = commonKernel_.AicpuNotifyLoadSoEventToCustCtrlCpu(deviceId, hostPid, vfId, custProcPid,
                                                                          loadLibNum, loadLibName);
    EXPECT_EQ(ret, 0);
}

TEST_F(CustOperationCommonTest, AicpuNotifyLoadSoEventToCustCtrlCpu_failed01)
{
    const uint32_t deviceId = 0;
    const uint32_t loadLibNum = 1;
    const char *loadLibName[] = {"libaicpu_kernels.so"};
    const uint32_t hostPid = 0;
    const uint32_t vfId = 0;
    int32_t custProcPid = 0;
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(DRV_ERROR_NONE));
    const int32_t ret = commonKernel_.AicpuNotifyLoadSoEventToCustCtrlCpu(deviceId, hostPid, vfId, custProcPid,
                                                                          loadLibNum, nullptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(CustOperationCommonTest, AicpuNotifyLoadSoEventToCustCtrlCpu_failed02)
{
    const uint32_t deviceId = 0;
    const uint32_t loadLibNum = 1;
    const char *loadLibName[] = {"libaicpu_kernels.so"};
    const uint32_t hostPid = 0;
    const uint32_t vfId = 0;
    int32_t custProcPid = 0;
    MOCKER(strcpy_s).stubs().will(returnValue(ERANGE));
    const int32_t ret = commonKernel_.AicpuNotifyLoadSoEventToCustCtrlCpu(deviceId, hostPid, vfId, custProcPid,
                                                                          loadLibNum, loadLibName);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(CustOperationCommonTest, AicpuNotifyLoadSoEventToCustCtrlCpu_warn01)
{
    const uint32_t deviceId = 0;
    const uint32_t loadLibNum = 1;
    const char *loadLibName[] = {"libaicpu_kernels.so"};
    const uint32_t hostPid = 0;
    const uint32_t vfId = 0;
    int32_t custProcPid = 0;
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    const int32_t ret = commonKernel_.AicpuNotifyLoadSoEventToCustCtrlCpu(deviceId, hostPid, vfId, custProcPid,
                                                                          loadLibNum, loadLibName);
    EXPECT_EQ(ret, 0);
}

TEST_F(BatchLoadSoFromBuffKernelTest, TsKernelBatchLoadOpFromBuf_success2)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    MOCKER(CreateOrFindCustPid, int32_t(const uint32_t, const uint32_t, const char * const *,
        const uint32_t, const uint32_t, const char *, const uint32_t, int32_t*, bool*))
        .stubs()
        .will(invoke(CreateOrFindCustPidFailedStub));
    MOCKER(halGrpQuery)
    .stubs()
    .will(invoke(halGrpQueryWithTwoGroup));
    MOCKER(halGrpAttach)
    .stubs()
    .will(returnValue(0));
    MOCKER_CPP(&AicpuCustSoManager::CreateSoFile)
        .stubs()
        .will(returnValue((int32_t)AICPU_SCHEDULE_OK));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3005, 0, true);
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
    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }
    std::string command = "rm -rf ";
    command = command + dirName + "cust_aicpu_0_" + std::to_string(static_cast<int32_t>(getpid()));
    int ret = system(command.c_str());
    if (ret != 0) {
        aicpusd_info("Remove directory %s fail", dirName.c_str());
    }
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_ERROR_INNER_ERROR);
    free (p);
}

TEST_F(BatchLoadSoFromBuffKernelTest, TsKernelBatchLoadOpFromBuf_fail_queryGrp01)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    MOCKER(CreateOrFindCustPid, int32_t(const uint32_t, const uint32_t, const char * const *,
        const uint32_t, const uint32_t, const char *, const uint32_t, int32_t*, bool*))
        .stubs()
        .will(invoke(CreateOrFindCustPidFailedStub));
    MOCKER(halGrpQuery)
    .stubs()
    .will(returnValue(1));
    MOCKER(halGrpAttach)
    .stubs()
    .will(returnValue(0));
    MOCKER_CPP(&AicpuCustSoManager::CreateSoFile)
        .stubs()
        .will(returnValue((int32_t)AICPU_SCHEDULE_OK));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3005, 0, true);
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
    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }
    std::string command = "rm -rf ";
    command = command + dirName + "cust_aicpu_0_" + std::to_string(static_cast<int32_t>(getpid()));
    int ret = system(command.c_str());
    if (ret != 0) {
        aicpusd_info("Remove directory %s fail", dirName.c_str());
    }
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_ERROR_INNER_ERROR);
    free (p);
}


TEST_F(BatchLoadSoFromBuffKernelTest, TsKernelBatchLoadOpFromBuf_fail_queryGrp02)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    MOCKER(CreateOrFindCustPid, int32_t(const uint32_t, const uint32_t, const char * const *,
        const uint32_t, const uint32_t, const char *, const uint32_t, int32_t*, bool*))
        .stubs()
        .will(invoke(CreateOrFindCustPidFailedStub));
    MOCKER(halGrpQuery)
    .stubs()
    .will(invoke(halGrpQueryWithError));
    MOCKER(halGrpAttach)
    .stubs()
    .will(returnValue(0));
    MOCKER_CPP(&AicpuCustSoManager::CreateSoFile)
        .stubs()
        .will(returnValue((int32_t)AICPU_SCHEDULE_OK));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3005, 0, true);
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
    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }
    std::string command = "rm -rf ";
    command = command + dirName + "cust_aicpu_0_" + std::to_string(static_cast<int32_t>(getpid()));
    int ret = system(command.c_str());
    if (ret != 0) {
        aicpusd_info("Remove directory %s fail", dirName.c_str());
    }
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_ERROR_INNER_ERROR);
    free (p);
}

TEST_F(BatchLoadSoFromBuffKernelTest, TsKernelBatchLoadOpFromBuf_fail_addGrp)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    MOCKER(CreateOrFindCustPid, int32_t(const uint32_t, const uint32_t, const char * const *,
        const uint32_t, const uint32_t, const char *, const uint32_t, int32_t*, bool*))
        .stubs()
        .will(invoke(CreateOrFindCustPidFailedStub));
    MOCKER(halGrpQuery)
    .stubs()
    .will(invoke(halGrpQueryWithTwoGroup));
    MOCKER(halGrpAttach)
    .stubs()
    .will(returnValue(0));
    MOCKER(halGrpAddProc)
    .stubs()
    .will(returnValue(1));
    MOCKER_CPP(&AicpuCustSoManager::CreateSoFile)
        .stubs()
        .will(returnValue((int32_t)AICPU_SCHEDULE_OK));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3005, 0, true);
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
    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }
    std::string command = "rm -rf ";
    command = command + dirName + "cust_aicpu_0_" + std::to_string(static_cast<int32_t>(getpid()));
    int ret = system(command.c_str());
    if (ret != 0) {
        aicpusd_info("Remove directory %s fail", dirName.c_str());
    }
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_ERROR_INNER_ERROR);
    free (p);
}

TEST_F(BatchLoadSoFromBuffKernelTest, TsKernelBatchLoadOpFromBuf_fail_StartCust)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    MOCKER(CreateOrFindCustPid, int32_t(const uint32_t, const uint32_t, const char * const *,
        const uint32_t, const uint32_t, const char *, const uint32_t, int32_t*, bool*))
        .stubs()
        .will(invoke(CreateOrFindCustPidFailedStub2));
    MOCKER(halGrpQuery)
    .stubs()
    .will(invoke(halGrpQueryWithTwoGroup));
    MOCKER(halGrpAttach)
    .stubs()
    .will(returnValue(0));
    MOCKER(halGrpAddProc)
    .stubs()
    .will(returnValue(0));
    MOCKER_CPP(&AicpuCustSoManager::CreateSoFile)
        .stubs()
        .will(returnValue((int32_t)AICPU_SCHEDULE_OK));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3005, 0, true);
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
    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }
    std::string command = "rm -rf ";
    command = command + dirName + "cust_aicpu_0_" + std::to_string(static_cast<int32_t>(getpid()));
    int ret = system(command.c_str());
    if (ret != 0) {
        aicpusd_info("Remove directory %s fail", dirName.c_str());
    }
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_ERROR_INNER_ERROR);
    free (p);
}

TEST_F(BatchLoadSoFromBuffKernelTest, TsKernelBatchLoadOpFromBuf_succ_StartCust)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    MOCKER(CreateOrFindCustPid, int32_t(const uint32_t, const uint32_t, const char * const *,
        const uint32_t, const uint32_t, const char *, const uint32_t, int32_t*, bool*))
        .stubs()
        .will(invoke(CreateOrFindCustPidStubExist));
    MOCKER(halGrpQuery)
    .stubs()
    .will(invoke(halGrpQueryWithTwoGroup));
    MOCKER(halGrpAttach)
    .stubs()
    .will(returnValue(0));
    MOCKER(halGrpAddProc)
    .stubs()
    .will(returnValue(0));
    MOCKER_CPP(&AicpuCustSoManager::CreateSoFile)
        .stubs()
        .will(returnValue((int32_t)AICPU_SCHEDULE_OK));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3005, 0, true);
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
    char* curDirName = getenv("HOME");
    std::string dirName(curDirName);
    if (dirName[dirName.size() - 1] != '/') {
        dirName = dirName + "/";
    }
    std::string command = "rm -rf ";
    command = command + dirName + "cust_aicpu_0_" + std::to_string(static_cast<int32_t>(getpid()));
    int ret = system(command.c_str());
    if (ret != 0) {
        aicpusd_info("Remove directory %s fail", dirName.c_str());
    }
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_OK);
    free (p);
}

TEST_F(BatchLoadSoFromBuffKernelTest, TsKernelBatchLoadOpFromBuf_fail3)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    bool hasThread = AicpuDrvManager::GetInstance().HasThread();
    pid_t hostPid = AicpuDrvManager::GetInstance().GetHostPid();
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3003, 0, true);
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "batchLoadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));

    char soContent[] = "This is test for batchLoadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = 0;//strlen(soContent);
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
    free (p);
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(BatchLoadSoFromBuffKernelTest, TsKernelBatchLoadOpFromBuf_fail4)
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
    retStatus = deleteKernel_.Compute(tsKernelInfo);
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
    retStatus = deleteKernel_.Compute(tsKernelInfo);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, hostPid, 0, hasThread);
    free (p);

    command = "rm -rf ";
    command = command + dirName + "cust_aicpu_0_3004";
    system(command.c_str());
    EXPECT_NE(retStatus, AICPU_SCHEDULE_OK);
}

TEST_F(BatchLoadSoFromBuffKernelTest, TsKernelBatchLoadOpFromBuf_failed6)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    MOCKER_CPP(&AicpuCustSoManager::CreateSoFile)
        .stubs()
        .will(returnValue((int32_t)AICPU_SCHEDULE_ERROR_INNER_ERROR));
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3006, 0, true);
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
    free (p);
    EXPECT_NE(retStatus, AICPU_SCHEDULE_OK);
}

TEST_F(BatchLoadSoFromBuffKernelTest, TsKernelBatchLoadOpFromBuf_failed7)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
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

    uint32_t num = 0;
    BatchLoadOpFromBufArgs *p=(BatchLoadOpFromBufArgs*)malloc(sizeof(BatchLoadOpFromBufArgs)+sizeof(LoadOpFromBufArgs)*num);
    p->soNum=num;
    std::vector<LoadOpFromBufArgs> v_cust_so;
    LoadOpFromBufArgs custSoInfo;
    custSoInfo.kernelSoBuf=kernelSoBuf;
    custSoInfo.kernelSoBufLen=kernelSoBufLen;
    custSoInfo.kernelSoName=kernelSoName;
    custSoInfo.kernelSoNameLen=kernelSoNameLen;
    v_cust_so.push_back(custSoInfo);
    p->opInfoArgs=reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(v_cust_so.data()));

    uint64_t paramBase = reinterpret_cast<uint64_t>(
                         reinterpret_cast<uintptr_t>(p));
    cceKernel.paramBase = paramBase;
    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    int retStatus = kernel_.Compute(tsKernelInfo);
    free (p);
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(BatchLoadSoFromBuffKernelTest, TsKernelBatchLoadOpFromBuf_success3)
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
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3006, 0, true);
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
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

    MOCKER_CPP(&AicpuCustSoManager::CreateSoFile)
        .stubs()
        .will(returnValue((int32_t)AICPU_SCHEDULE_OK));

    int retStatus = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_OK);

    std::string command = "rm -rf ";
    command = command + dirName + "cust_aicpu_0_3006";
    int ret = system(command.c_str());
    free (p);
}

TEST_F(BatchLoadSoFromBuffKernelTest, TsKernelBatchLoadOpFromBufNotSupport)
{
    std::vector<uint32_t> deviceVec = {1};
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3006, 0, true);
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_MSGQ);
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "batchLoadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    tsKernelInfo.kernelType = 2;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    int retStatus = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(BatchLoadSoFromBuffKernelTest, TsKernelBatchLoadOpFromBuf_fail0)
{
    (void)AicpuCustSoManager::GetInstance().InitAicpuCustSoManager(aicpu::AicpuRunMode::THREAD_MODE,
                                                                   SCHED_MODE_INTERRUPT);
    aicpu::SetHaveCustPid(false);
    bool hasThread = AicpuDrvManager::GetInstance().HasThread();
    pid_t hostPid = AicpuDrvManager::GetInstance().GetHostPid();
    std::vector<uint32_t> deviceVec;
    deviceVec.push_back(1);
    AicpuDrvManager::GetInstance().InitDrvMgr(deviceVec, 3000, 0, true);
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    char kernel_name[] = "batchLoadOpFromBuf";
    uint64_t kernel_name_addr = reinterpret_cast<uint64_t>(
                                reinterpret_cast<uintptr_t>(kernel_name));
    cceKernel.kernelName = kernel_name_addr;

    char soContent[] = "This is test for batchLoadOpFromBuf";
    uint64_t kernelSoBuf = reinterpret_cast<uint64_t>(reinterpret_cast<uintptr_t>
                                                      (soContent));
    uint32_t kernelSoBufLen = 0;//strlen(soContent);
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

    free (p);
    EXPECT_EQ(retStatus, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}