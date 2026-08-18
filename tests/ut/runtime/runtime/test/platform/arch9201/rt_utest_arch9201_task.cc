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
#include "raw_device.hpp"
#include "module.hpp"
#include "task_info.hpp"
#include "task/task_info.hpp"
#include "stream_c.hpp"
#include "task_recycle.hpp"
#include "ccu_task.hpp"
#include "npu_driver.hpp"
#include "davinci_kernel_task.h"
#include "stars_david.hpp"
#include "cmo_task.h"
#include "rt_unwrap.h"
#include "runtime_task_manager.h"
#include "../../rt_utest_config_define.hpp"
#include "../../task_test_helper.h"
#include "arch9201/aic_aiv_sqe.h"
#include "arch9201/arch9201_sqe_utils.hpp"
#include "fusion_c.hpp"
#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;
rtCqReport_t g_cqReport1;
static rtError_t Sub_LogicCqReportV2(
    NpuDriver* drv, const LogicCqWaitInfo& waitInfo, uint8_t* report, uint32_t reportCnt, uint32_t& realCnt)
{
    realCnt = 1;
    rtCqReport_t* reportPtr = reinterpret_cast<rtCqReport_t*>(report);
    g_cqReport1.taskId = 1U;
    *reportPtr = g_cqReport1;
    return RT_ERROR_NONE;
}

// ============================================================================
// Test fixture: 设置 CHIP_CLOUD_V5 (arch9201) 作为芯片类型
// ============================================================================
class Arch9201TaskTest : public testing::Test {
protected:
    static void SetUpTestCase() {}

    static void TearDownTestCase() {}

    virtual void SetUp()
    {
        Runtime* rtInstance = (Runtime*)Runtime::Instance();
        savedBiuperfFlag_ = rtInstance->GetBiuperfProfFlag();
        savedL2CacheFlag_ = rtInstance->GetL2CacheProfFlag();
        rtSetDevice(0);
        dev_ = rtInstance->DeviceRetain(0, 0);
        Driver* driver_ = ((Runtime*)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
        MOCKER_CPP_VIRTUAL((NpuDriver*)(driver_), &NpuDriver::LogicCqReportV2)
            .stubs()
            .will(invoke(Sub_LogicCqReportV2));
        rtStreamCreate(&streamHandle_, 0);
        stream_ = rt_ut::UnwrapOrNull<Stream>(streamHandle_);
        stream_->SetSqMemAttr(false);
        stream_->Context_()->DefaultStream_()->SetSqMemAttr(false);
        MOCKER(StreamNopTask).stubs().will(returnValue(RT_ERROR_NONE));
    }

    virtual void TearDown()
    {
        Runtime* rtInstance = (Runtime*)Runtime::Instance();
        rtInstance->SetBiuperfProfFlag(savedBiuperfFlag_);
        rtInstance->SetL2CacheProfFlag(savedL2CacheFlag_);
        rtStreamDestroy(streamHandle_);
        stream_ = nullptr;
        rtInstance->DeviceRelease(dev_);
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }

protected:
    Stream* stream_ = nullptr;
    Device* dev_ = nullptr;
    rtStream_t streamHandle_ = nullptr;
    bool savedBiuperfFlag_ = false;
    bool savedL2CacheFlag_ = false;
};

TEST_F(Arch9201TaskTest, check_prefetch_cnt_on_construct_arch9201_sqe_for_aic_mix_task)
{
    TaskInfo task = {};
    rtDavidSqe_t sqe;
    TaskSqeInfo sqeInfo = {0ULL, 0ULL};
    InitByStream(&task, stream_);

    const void* stubFunc = (void*)0x02;
    const char* stubName = "abc";
    Kernel* kernel = NULL;
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICORE);
    Program* program = &stubProg;
    program->kernelNames_ = {'a', 'b', 'c', 'd', '\0'};
    kernel = new (std::nothrow) Kernel("", 0UL, program, RT_KERNEL_ATTR_TYPE_AICORE, 0);
    kernel->SetStub_(stubFunc);
    ((Runtime*)Runtime::Instance())->kernelTable_.Add(kernel);

    kernel->SetPrefetchCnt1_(0x2);
    kernel->SetPrefetchCnt2_(0x4);

    Kernel* aicKernel3 = CreateTestKernel(RT_KERNEL_ATTR_TYPE_AICORE);
    AicTaskInit(&task, aicKernel3, aicKernel3->GetKernelAttrType(), 1, nullptr);
    delete aicKernel3;
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AICORE);
    task.id = 0;
    task.u.aicTaskInfo.kernel = kernel;
    kernel->SetMixType(MIX_AIC);
    stubProg.SetIsDcacheLockOp(true);
    ToConstructDavidSqe(&task, static_cast<void*>(&sqe), sqeInfo);
    RtArch9201StarsAicAivKernelSqe* arch9201Sqe =
        static_cast<RtArch9201StarsAicAivKernelSqe*>(static_cast<void*>(&sqe));
    EXPECT_EQ(arch9201Sqe->header.type, RT_DAVID_SQE_TYPE_AIC);
    EXPECT_EQ(arch9201Sqe->aicIcachePrefetchCnt, 0x2);

    Kernel* vecKernel2 = CreateTestKernel(RT_KERNEL_ATTR_TYPE_VECTOR);
    AicTaskInit(&task, vecKernel2, vecKernel2->GetKernelAttrType(), 1, nullptr);
    delete vecKernel2;
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AIVEC);
    kernel->SetMixType(MIX_AIV);
    ToConstructDavidSqe(&task, static_cast<void*>(&sqe), sqeInfo);
    EXPECT_EQ(arch9201Sqe->header.type, RT_DAVID_SQE_TYPE_AIV);
    EXPECT_EQ(arch9201Sqe->aivIcachePrefetchCnt, 0x2);

    Kernel* aicKernel4 = CreateTestKernel(RT_KERNEL_ATTR_TYPE_AICORE);
    AicTaskInit(&task, aicKernel4, aicKernel4->GetKernelAttrType(), 1, nullptr);
    delete aicKernel4;
    kernel->SetMixType(MIX_AIC_AIV_MAIN_AIC);
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AICORE);
    ToConstructDavidSqe(&task, static_cast<void*>(&sqe), sqeInfo);
    EXPECT_EQ(arch9201Sqe->aicIcachePrefetchCnt, 0x2);
    EXPECT_EQ(arch9201Sqe->aivIcachePrefetchCnt, 0x4);
    ((Runtime*)Runtime::Instance())->kernelTable_.RemoveAll(program);
    TaskUnInitProc(&task);
}

TEST_F(Arch9201TaskTest, check_prefetch_cnt_on_construct_arch9201_sqe_for_aicaiv_nomix_task)
{
    TaskInfo task = {};
    RtArch9201StarsAicAivKernelSqe sqe;
    TaskSqeInfo sqeInfo = {0ULL, 0ULL};
    InitByStream(&task, stream_);

    const void* stubFunc = (void*)0x02;
    const char* stubName = "abc";
    Kernel* kernel = NULL;
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICORE);
    Program* program = &stubProg;
    program->kernelNames_ = {'a', 'b', 'c', 'd', '\0'};
    kernel = new (std::nothrow) Kernel("", 0UL, program, RT_KERNEL_ATTR_TYPE_AICORE, 0);
    kernel->SetStub_(stubFunc);
    ((Runtime*)Runtime::Instance())->kernelTable_.Add(kernel);

    kernel->SetPrefetchCnt1_(0x2);
    kernel->SetPrefetchCnt2_(0x4);

    Kernel* aicKernel5 = CreateTestKernel(RT_KERNEL_ATTR_TYPE_AICORE);
    AicTaskInit(&task, aicKernel5, aicKernel5->GetKernelAttrType(), 1, nullptr);
    delete aicKernel5;
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AICORE);
    task.id = 0;
    task.u.aicTaskInfo.kernel = kernel;
    ToConstructDavidSqe(&task, static_cast<void*>(&sqe), sqeInfo);
    EXPECT_EQ(sqe.header.type, RT_DAVID_SQE_TYPE_AIC);
    EXPECT_EQ(sqe.aicIcachePrefetchCnt, 0x2);

    Kernel* vecKernel3 = CreateTestKernel(RT_KERNEL_ATTR_TYPE_VECTOR);
    AicTaskInit(&task, vecKernel3, vecKernel3->GetKernelAttrType(), 1, nullptr);
    delete vecKernel3;
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AIVEC);
    ToConstructDavidSqe(&task, static_cast<void*>(&sqe), sqeInfo);
    EXPECT_EQ(sqe.header.type, RT_DAVID_SQE_TYPE_AIV);
    EXPECT_EQ(sqe.aivIcachePrefetchCnt, 0x2);
    ((Runtime*)Runtime::Instance())->SetBiuperfProfFlag(true);
    ((Runtime*)Runtime::Instance())->SetL2CacheProfFlag(true);
    Kernel* vecKernel4 = CreateTestKernel(RT_KERNEL_ATTR_TYPE_VECTOR);
    AicTaskInit(&task, vecKernel4, vecKernel4->GetKernelAttrType(), 1, nullptr);
    delete vecKernel4;
    EXPECT_EQ(task.type, TS_TASK_TYPE_KERNEL_AIVEC);
    ToConstructDavidSqe(&task, static_cast<void*>(&sqe), sqeInfo);
    ((Runtime*)Runtime::Instance())->kernelTable_.RemoveAll(program);
    TaskUnInitProc(&task);
}

TEST_F(Arch9201TaskTest, check_dcache_prefetch_cnt_for_aic_mix_task)
{
    TaskInfo task = {};
    RtArch9201StarsAicAivKernelSqe sqe;

    const void* stubFunc = (void*)0x02;
    const char* stubName = "abc";
    Kernel* kernel = NULL;
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICORE);
    Program* program = &stubProg;
    program->kernelNames_ = {'a', 'b', 'c', 'd', '\0'};
    kernel = new (std::nothrow) Kernel("", 0UL, program, RT_KERNEL_ATTR_TYPE_AICORE, 0);

    task.u.aicTaskInfo.kernel = kernel;
    task.u.aicTaskInfo.comm.argsSize = 2048U;

    // set mixType_ is MIX_AIC
    kernel->SetMixType(MIX_AIC);
    GetDcachePrefetchCnt(&task, &sqe);
    EXPECT_EQ(sqe.aicDcachePrefetchCnt, 32U);

    // set mixType_ is MIX_AIV
    kernel->SetMixType(MIX_AIV);
    GetDcachePrefetchCnt(&task, &sqe);
    EXPECT_EQ(sqe.aivDcachePrefetchCnt, 32U);

    // set mixType_ is MIX_AIC_AIV_MAIN_AIC
    kernel->SetMixType(MIX_AIC_AIV_MAIN_AIC);
    GetDcachePrefetchCnt(&task, &sqe);
    EXPECT_EQ(sqe.aicDcachePrefetchCnt, 32U);
    EXPECT_EQ(sqe.aivDcachePrefetchCnt, 32U);

    // set mixType_ is MIX_AIC_AIV_MAIN_AIC and argsSize is 5000U
    task.u.aicTaskInfo.comm.argsSize = 5000U;
    kernel->SetMixType(MIX_AIC_AIV_MAIN_AIC);
    GetDcachePrefetchCnt(&task, &sqe);
    EXPECT_EQ(sqe.aicDcachePrefetchCnt, 64U);
    EXPECT_EQ(sqe.aivDcachePrefetchCnt, 64U);

    // set mixType_ is NO_mix and task.type is TS_TASK_TYPE_KERNEL_AICORE
    kernel->SetMixType(NO_MIX);
    task.type = TS_TASK_TYPE_KERNEL_AICORE;
    task.u.aicTaskInfo.comm.argsSize = 4095U;
    GetDcachePrefetchCnt(&task, &sqe);
    EXPECT_EQ(sqe.aicDcachePrefetchCnt, 63U);

    TaskUnInitProc(&task);
    delete kernel;
}

TEST_F(Arch9201TaskTest, check_prefetch_cnt_aic_mix_task)
{
    rtError_t ret = RT_ERROR_NONE;
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    uint64_t tilingKey = 0;
    Kernel kernel("GetPrefetchCnt_program_kernel", tilingKey, program, RT_KERNEL_ATTR_TYPE_AICPU, 2048, 1024, 0, 0, 0);
    kernel.SetKernelLength1(10240); // 10k < 16k
    kernel.SetKernelLength2(18432); // 16k < 18k < 32k
    // RT_KERNEL_ATTR_TYPE_AICPU
    kernel.SetPrefetchCnt1_(0);
    kernel.SetPrefetchCnt2_(0);
    ret = GetPrefetchCnt(&kernel);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(kernel.PrefetchCnt1_(), 0);
    EXPECT_EQ(kernel.PrefetchCnt2_(), 0);

    // MACH_AI_MIX_KERNEL + MIX_AIC_AIV_MAIN_AIC
    kernel.SetPrefetchCnt1_(0);
    kernel.SetPrefetchCnt2_(0);
    kernel.SetMixType(static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIC));
    kernel.SetKernelAttrType(RT_KERNEL_ATTR_TYPE_MIX);
    ret = GetPrefetchCnt(&kernel);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(kernel.PrefetchCnt1_(), 20);
    EXPECT_EQ(kernel.PrefetchCnt2_(), 32);

    // MACH_AI_CVMIX + MIX_AIC
    kernel.SetPrefetchCnt1_(0);
    kernel.SetPrefetchCnt2_(0);
    kernel.SetMixType(static_cast<uint8_t>(MIX_AIC));
    kernel.SetKernelAttrType(RT_KERNEL_ATTR_TYPE_CUBE);
    ret = GetPrefetchCnt(&kernel);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(kernel.PrefetchCnt1_(), 20);
    EXPECT_EQ(kernel.PrefetchCnt2_(), 0);

    // MACH_AI_CVMIX + MIX_AIV
    kernel.SetPrefetchCnt1_(0);
    kernel.SetPrefetchCnt2_(0);
    kernel.SetMixType(static_cast<uint8_t>(MIX_AIV));
    kernel.SetKernelAttrType(RT_KERNEL_ATTR_TYPE_VECTOR);
    ret = GetPrefetchCnt(&kernel);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(kernel.PrefetchCnt1_(), 20);
    EXPECT_EQ(kernel.PrefetchCnt2_(), 0);

    // MACH_AI_CVMIX + MIX_AIC_AIV_MAIN_AIV
    kernel.SetPrefetchCnt1_(0);
    kernel.SetPrefetchCnt2_(0);
    kernel.SetMixType(static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIV));
    kernel.SetKernelAttrType(RT_KERNEL_ATTR_TYPE_MIX);
    ret = GetPrefetchCnt(&kernel);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(kernel.PrefetchCnt1_(), 20);
    EXPECT_EQ(kernel.PrefetchCnt2_(), 0);

    // RT_KERNEL_ATTR_TYPE_VECTOR + MIX_AIC_AIV_MAIN_AIV
    kernel.SetPrefetchCnt1_(0);
    kernel.SetPrefetchCnt2_(0);
    kernel.SetMixType(static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIV));
    kernel.SetKernelAttrType(RT_KERNEL_ATTR_TYPE_MIX);
    ret = GetPrefetchCnt(&kernel);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(kernel.PrefetchCnt1_(), 20);
    EXPECT_EQ(kernel.PrefetchCnt2_(), 0);

    // MACH_INVALID_CPU + MIX_AIC_AIV_MAIN_AIV
    kernel.SetPrefetchCnt1_(0);
    kernel.SetPrefetchCnt2_(0);
    kernel.SetMixType(static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIV));
    kernel.SetKernelAttrType(static_cast<rtKernelAttrType>(RT_KERNEL_ATTR_TYPE_INVALID));
    ret = GetPrefetchCnt(&kernel);
    EXPECT_EQ(ret, RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(kernel.PrefetchCnt1_(), 0);
    EXPECT_EQ(kernel.PrefetchCnt2_(), 0);
}

void TaskFailCallBackStubfunc(
    const uint32_t streamId, const uint32_t taskId, const uint32_t threadId, const uint32_t retCode,
    const Device* const dev)
{
    // stub
}

TEST_F(Arch9201TaskTest, construct_arch9201sqe_for_fusion_kernel_launch_1)
{
    const void* stubFunc = (void*)0x02;
    const char* stubName = "abc";
    Kernel* kernel = NULL;
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICORE);
    Program* program = &stubProg;
    kernel = new (std::nothrow) Kernel("", 0UL, program, RT_KERNEL_ATTR_TYPE_AICORE, 0);
    kernel->SetStub_(stubFunc);

    rtError_t error;
    rtDavidSqe_t sqe[5];
    TaskInfo kernTask = {};
    InitByStream(&kernTask, stream_);

    uint64_t arg = 0x123456789;
    rtFusionArgsEx_t argsInfo = {};
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);
    argsInfo.aicpuNum = 1;
    argsInfo.aicpuArgs[0].kfcArgsFmtOffset = 0xFFFF;
    argsInfo.aicpuArgs[0].kernelNameAddrOffset = 0;
    argsInfo.aicpuArgs[0].soNameAddrOffset = 0;

    rtFunsionTaskInfo_t fusionInfo = {};
    fusionInfo.subTaskNum = 2U;
    fusionInfo.subTask[0].type = RT_FUSION_AICPU;
    fusionInfo.subTask[0].task.aicpuInfo.kernelType = 0;
    fusionInfo.subTask[0].task.aicpuInfo.flags = 0;
    fusionInfo.subTask[0].task.aicpuInfo.blockDim = 2U;

    rtLaunchAttribute_t attrs[1];
    attrs[0].id = RT_LAUNCH_ATTRIBUTE_BLOCKDIM;
    attrs[0].value.blockDim = 1;

    rtLaunchConfig_t launchConfig = {};
    launchConfig.numAttrs = 1;
    launchConfig.attrs = attrs;
    fusionInfo.subTask[1].type = RT_FUSION_AICORE;
    fusionInfo.subTask[1].task.aicoreInfo.hdl = nullptr;
    fusionInfo.subTask[1].task.aicoreInfo.config = &launchConfig;

    rtAicAivFusionInfo_t aicAivInfo = {};
    LaunchTaskCfgInfo_t taskCfgInfo;
    aicAivInfo.launchTaskCfg = &taskCfgInfo;
    FusionKernelTaskInit(&kernTask);
    AixKernelTaskInitForFusion(&kernTask, &aicAivInfo, &taskCfgInfo);
    kernTask.u.fusionKernelTask.fusionKernelInfo = static_cast<void*>(&fusionInfo);
    kernTask.u.fusionKernelTask.argsInfo = &argsInfo;
    kernTask.u.fusionKernelTask.argsSize = argsInfo.argsSize;
    kernTask.u.fusionKernelTask.args = argsInfo.args;
    kernTask.u.fusionKernelTask.sqeLen = 6U;
    rtArgsSizeInfo_t argsSizeInfo;
    argsSizeInfo.infoAddr = (void*)0x12345678;
    argsSizeInfo.atomicIndex = 0x87654321;
    error = rtSetExceptionExtInfo(&argsSizeInfo);
    AixKernelTaskInitForFusion(&kernTask, &aicAivInfo, &taskCfgInfo);
    kernTask.u.fusionKernelTask.aicAivType = 0; // aic no mix
    TaskSqeInfo sqeInfo = {0ULL, 0ULL};
    ToConstructDavidSqe(&kernTask, static_cast<void*>(sqe), sqeInfo);
    EXPECT_EQ(sqe[0].aicpuSqe.header.type, RT_DAVID_SQE_TYPE_FUSION);

    kernTask.u.fusionKernelTask.aicAivType = 1; // aiv no mix
    fusionInfo.subTask[0].task.aicpuInfo.flags = RT_KERNEL_HOST_FIRST;
    ToConstructDavidSqe(&kernTask, static_cast<void*>(sqe), sqeInfo);
    EXPECT_EQ(sqe[0].aicpuSqe.header.type, RT_DAVID_SQE_TYPE_FUSION);

    kernTask.u.fusionKernelTask.aicPart.kernel = kernel;
    kernTask.u.fusionKernelTask.aicPart.kernel->mixType_ = MIX_AIC_AIV_MAIN_AIC;
    fusionInfo.subTask[0].task.aicpuInfo.flags = RT_KERNEL_HOST_ONLY;
    ToConstructDavidSqe(&kernTask, static_cast<void*>(sqe), sqeInfo);
    EXPECT_EQ(sqe[0].aicpuSqe.header.type, RT_DAVID_SQE_TYPE_FUSION);

    kernTask.u.fusionKernelTask.aicPart.kernel->mixType_ = MIX_AIV;
    fusionInfo.subTask[0].task.aicpuInfo.flags = RT_KERNEL_DEVICE_FIRST;
    ToConstructDavidSqe(&kernTask, static_cast<void*>(sqe), sqeInfo);
    EXPECT_EQ(sqe[0].aicpuSqe.header.type, RT_DAVID_SQE_TYPE_FUSION);

    MOCKER(TaskFailCallBack).stubs().will(invoke(TaskFailCallBackStubfunc));
    MOCKER_CPP(&H2DCopyMgr::H2DMemCopyWaitFinish).stubs().will(returnValue(RT_ERROR_NONE));

    rtCqReport_t cqe = {};
    cqe.errorType = 1U;
    cqe.errorCode = 1U;

    Handle argHdl = {};
    argHdl.freeArgs = true;
    kernTask.u.fusionKernelTask.argHandle = static_cast<void*>(&argHdl);

    WaitAsyncCopyComplete(&kernTask);
    SetStarsResult(&kernTask, cqe);
    Complete(&kernTask, 0);
    PrintErrorInfo(&kernTask, 0);
    kernTask.u.fusionKernelTask.argHandle = static_cast<void*>(&argHdl);
    TaskUnInitProc(&kernTask);
    ((Runtime*)Runtime::Instance())->SetConnectUbFlag(true);
    TaskUnInitProc(&kernTask);
    delete kernel;
}

TEST_F(Arch9201TaskTest, construct_arch9201sqe_for_fusion_kernel_launch_2)
{
    rtDavidSqe_t sqe[5];
    TaskInfo kernTask = {};
    InitByStream(&kernTask, stream_);

    uint64_t arg = 0x123456789;
    rtFusionArgsEx_t argsInfo = {};
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);
    argsInfo.aicpuNum = 0U;

    rtFunsionTaskInfo_t fusionInfo = {};
    fusionInfo.subTaskNum = 2U;
    fusionInfo.subTask[0].type = RT_FUSION_CCU;
    fusionInfo.subTask[0].task.ccuInfo.taskNum = 4U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[0].argSize = 1U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[0].dieId = 0U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[0].missionId = 1U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[0].instCnt = 1U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[1].argSize = 1U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[1].dieId = 1U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[1].missionId = 1U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[1].instCnt = 1U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[2].argSize = 1U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[2].dieId = 0U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[2].missionId = 2U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[2].instCnt = 1U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[3].argSize = 1U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[3].dieId = 1U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[3].missionId = 2U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[3].instCnt = 1U;

    rtLaunchAttribute_t attrs[1];
    attrs[0].id = RT_LAUNCH_ATTRIBUTE_BLOCKDIM;
    attrs[0].value.blockDim = 1;

    rtLaunchConfig_t launchConfig = {};
    launchConfig.numAttrs = 1;
    launchConfig.attrs = attrs;
    fusionInfo.subTask[1].type = RT_FUSION_AICORE;
    fusionInfo.subTask[1].task.aicoreInfo.hdl = nullptr;
    fusionInfo.subTask[1].task.aicoreInfo.config = &launchConfig;

    kernTask.u.fusionKernelTask.fusionKernelInfo = static_cast<void*>(&fusionInfo);
    kernTask.u.fusionKernelTask.argsInfo = &argsInfo;
    kernTask.u.fusionKernelTask.argsSize = argsInfo.argsSize;
    kernTask.u.fusionKernelTask.args = argsInfo.args;
    kernTask.u.fusionKernelTask.sqeLen = 5U;

    rtAicAivFusionInfo_t aicAivInfo = {};
    LaunchTaskCfgInfo_t taskCfgInfo;
    aicAivInfo.launchTaskCfg = &taskCfgInfo;
    FusionKernelTaskInit(&kernTask);
    AixKernelTaskInitForFusion(&kernTask, &aicAivInfo, &taskCfgInfo);
    kernTask.u.fusionKernelTask.aicAivType = 0; // aic no mix
    TaskSqeInfo sqeInfo = {0ULL, 0ULL};
    ToConstructDavidSqe(&kernTask, static_cast<void*>(sqe), sqeInfo);
    EXPECT_EQ(sqe[0].ccuSqe.header.type, RT_DAVID_SQE_TYPE_FUSION);

    TaskUnInitProc(&kernTask);
}

TEST_F(Arch9201TaskTest, construct_arch9201sqe_for_fusion_kernel_launch_3)
{
    rtDavidSqe_t sqe[5];
    TaskInfo kernTask = {};
    InitByStream(&kernTask, stream_);

    uint64_t arg = 0x123456789;
    rtFusionArgsEx_t argsInfo = {};
    argsInfo.args = &arg;
    argsInfo.argsSize = sizeof(arg);
    argsInfo.aicpuNum = 0U;

    rtFunsionTaskInfo_t fusionInfo = {};
    fusionInfo.subTaskNum = 2U;
    fusionInfo.subTask[0].type = RT_FUSION_CCU;
    fusionInfo.subTask[0].task.ccuInfo.taskNum = 1U;
    for (int32_t i = 0; i < 13; ++i) {
        fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[0].args[i] = UINT64_MAX;
    }
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[0].argSize = 13U;
    fusionInfo.subTask[0].task.ccuInfo.ccuTaskInfo[0].instCnt = 1U;

    rtLaunchAttribute_t attrs[1];
    attrs[0].id = RT_LAUNCH_ATTRIBUTE_BLOCKDIM;
    attrs[0].value.blockDim = 1;

    rtLaunchConfig_t launchConfig = {};
    launchConfig.numAttrs = 1;
    launchConfig.attrs = attrs;
    fusionInfo.subTask[1].type = RT_FUSION_AICORE;
    fusionInfo.subTask[1].task.aicoreInfo.hdl = nullptr;
    fusionInfo.subTask[1].task.aicoreInfo.config = &launchConfig;

    kernTask.u.fusionKernelTask.fusionKernelInfo = static_cast<void*>(&fusionInfo);
    kernTask.u.fusionKernelTask.argsInfo = &argsInfo;
    kernTask.u.fusionKernelTask.argsSize = argsInfo.argsSize;
    kernTask.u.fusionKernelTask.args = argsInfo.args;
    kernTask.u.fusionKernelTask.sqeLen = 3U;

    rtAicAivFusionInfo_t aicAivInfo = {};
    LaunchTaskCfgInfo_t taskCfgInfo;
    aicAivInfo.launchTaskCfg = &taskCfgInfo;
    FusionKernelTaskInit(&kernTask);
    AixKernelTaskInitForFusion(&kernTask, &aicAivInfo, &taskCfgInfo);
    kernTask.u.fusionKernelTask.aicAivType = 0; // aic no mix

    TaskSqeInfo sqeInfo = {0ULL, 0ULL};
    ToConstructDavidSqe(&kernTask, static_cast<void*>(sqe), sqeInfo);
    EXPECT_EQ(sqe[0].ccuSqe.usrData[0], UINT32_MAX);
    EXPECT_EQ(sqe[1].ccuSqe.header.type, 0x3F);

    TaskUnInitProc(&kernTask);
}

// ==================== arch9201 CMO Task UT ====================

TEST_F(Arch9201TaskTest, construct_davidsqe_for_cmotask_arch9201_prefetch)
{
    TaskInfo task = {};
    rtDavidSqe_t sqe = {};
    TaskSqeInfo sqeInfo = {0ULL, 0ULL};
    InitByStream(&task, stream_);

    rtCmoTaskInfo_t cmoTask = {};
    cmoTask.opCode = RT_CMO_PREFETCH;
    cmoTask.qos = 1;
    cmoTask.lengthInner = 128;
    cmoTask.sourceAddr = 0x1000;
    rtError_t ret = CmoTaskInit(&task, &cmoTask, stream_, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(task.type, TS_TASK_TYPE_CMO);

    ToConstructDavidSqe(&task, static_cast<void*>(&sqe), sqeInfo);
    EXPECT_EQ(sqe.cmoSqe.header.type, RT_DAVID_SQE_TYPE_CMO);
    TaskUnInitProc(&task);
}

TEST_F(Arch9201TaskTest, construct_davidsqe_for_cmotask_arch9201_writeback)
{
    TaskInfo task = {};
    rtDavidSqe_t sqe = {};
    TaskSqeInfo sqeInfo = {0ULL, 0ULL};
    InitByStream(&task, stream_);

    rtCmoTaskInfo_t cmoTask = {};
    cmoTask.opCode = RT_CMO_WRITEBACK;
    cmoTask.qos = 2;
    cmoTask.lengthInner = 256;
    cmoTask.sourceAddr = 0x2000;
    rtError_t ret = CmoTaskInit(&task, &cmoTask, stream_, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(task.type, TS_TASK_TYPE_CMO);

    ToConstructDavidSqe(&task, static_cast<void*>(&sqe), sqeInfo);
    EXPECT_EQ(sqe.cmoSqe.header.type, RT_DAVID_SQE_TYPE_CMO);
    TaskUnInitProc(&task);
}

TEST_F(Arch9201TaskTest, construct_davidsqe_for_cmotask_arch9201_invalid)
{
    TaskInfo task = {};
    rtDavidSqe_t sqe = {};
    TaskSqeInfo sqeInfo = {0ULL, 0ULL};
    InitByStream(&task, stream_);

    rtCmoTaskInfo_t cmoTask = {};
    cmoTask.opCode = RT_CMO_INVALID;
    cmoTask.lengthInner = 64;
    cmoTask.sourceAddr = 0x3000;
    rtError_t ret = CmoTaskInit(&task, &cmoTask, stream_, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ToConstructDavidSqe(&task, static_cast<void*>(&sqe), sqeInfo);
    EXPECT_EQ(sqe.memcpyAsyncSqe.header.type, RT_DAVID_SQE_TYPE_SDMA);
    TaskUnInitProc(&task);
}

TEST_F(Arch9201TaskTest, construct_davidsqe_for_cmotask_arch9201_model_stream)
{
    TaskInfo task = {};
    rtDavidSqe_t sqe = {};
    TaskSqeInfo sqeInfo = {0ULL, 0ULL};
    InitByStream(&task, stream_);

    rtModel_t model;
    rtError_t ret = rtModelCreate(&model, 0);
    ASSERT_EQ(ret, RT_ERROR_NONE);
    Model* realModel = rt_ut::UnwrapOrNull<Model>(model);
    ASSERT_NE(realModel, nullptr);
    stream_->SetModel(realModel);

    rtCmoTaskInfo_t cmoTask = {};
    cmoTask.opCode = RT_CMO_PREFETCH;
    cmoTask.lengthInner = 128;
    MOCKER(memcpy_s).stubs().will(returnValue(1));
    ret = CmoTaskInit(&task, &cmoTask, stream_, 0);
    EXPECT_EQ(ret, RT_ERROR_FEATURE_NOT_SUPPORT);

    ToConstructDavidSqe(&task, static_cast<void*>(&sqe), sqeInfo);
    EXPECT_EQ(sqe.memcpyAsyncPtrSqe.header.type, RT_DAVID_SQE_TYPE_SDMA);

    stream_->SetModel(nullptr);
    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

TEST_F(Arch9201TaskTest, cmotask_init_arch9201_success)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    EXPECT_NE(task.stream, nullptr);

    rtCmoTaskInfo_t cmoTask = {};
    cmoTask.opCode = RT_CMO_PREFETCH;
    cmoTask.cmoType = RT_CMO_PREFETCH;
    cmoTask.qos = 3;
    cmoTask.partId = 1;
    cmoTask.pmg = 1;
    cmoTask.lengthInner = 512;
    cmoTask.sourceAddr = 0xABCDEF;
    cmoTask.numOuter = 2;
    cmoTask.numInner = 4;
    cmoTask.striderOuter = 64;
    cmoTask.striderInner = 32;

    rtError_t ret = CmoTaskInit(&task, &cmoTask, stream_, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(task.type, TS_TASK_TYPE_CMO);
    EXPECT_STREQ(task.typeName, "CMO");
    EXPECT_EQ(task.u.cmoTask.cmoSqeInfo.opCode, RT_CMO_PREFETCH);
    EXPECT_EQ(task.u.cmoTask.cmoSqeInfo.qos, 3);
    EXPECT_EQ(task.u.cmoTask.cmoSqeInfo.lengthInner, 512);
    EXPECT_EQ(task.u.cmoTask.cmoSqeInfo.sourceAddr, 0xABCDEF);

    TaskUnInitProc(&task);
}

TEST_F(Arch9201TaskTest, cmotask_init_arch9201_memcpy_fail)
{
    TaskInfo task = {};
    InitByStream(&task, stream_);
    EXPECT_NE(task.stream, nullptr);

    rtCmoTaskInfo_t cmoTask = {};
    cmoTask.opCode = RT_CMO_PREFETCH;
    MOCKER(memcpy_s).stubs().will(returnValue(1));
    rtError_t ret = CmoTaskInit(&task, &cmoTask, stream_, 0);
    EXPECT_EQ(ret, RT_ERROR_SEC_HANDLE);

    TaskUnInitProc(&task);
}

TEST_F(Arch9201TaskTest, construct_davidsqe_for_cmotask_arch9201_complete_and_print)
{
    TaskInfo task = {};
    rtDavidSqe_t sqe = {};
    TaskSqeInfo sqeInfo = {0ULL, 0ULL};
    InitByStream(&task, stream_);

    rtCmoTaskInfo_t cmoTask = {};
    cmoTask.opCode = RT_CMO_PREFETCH;
    cmoTask.qos = 1;
    cmoTask.lengthInner = 128;
    cmoTask.sourceAddr = 0x1000;
    rtError_t ret = CmoTaskInit(&task, &cmoTask, stream_, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ToConstructDavidSqe(&task, static_cast<void*>(&sqe), sqeInfo);
    EXPECT_EQ(sqe.cmoSqe.header.type, RT_DAVID_SQE_TYPE_CMO);

    uint32_t errorCode = 0;
    SetResult(&task, &errorCode, 1);
    Complete(&task, 0);
}