/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "base.hpp"
#include "aicpu_err_msg.hpp"
#include "runtime.hpp"
#include "aicpu/common/aicpu_task_struct.h"
#include "arg_loader.hpp"
#include "task_info.hpp"
#include "device_error_info.hpp"
#include "davinci_kernel_task.h"
#include "thread_local_container.hpp"

using namespace testing;
using namespace cce::runtime;

class CloudV2AicpuErrMsgTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "AicpuErrMsgTest SetUP" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "AicpuErrMsgTest Tear Down" << std::endl;
    }

    virtual void SetUp()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtSetDevice(0);
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
        Runtime *rtInstance = const_cast<Runtime *>(Runtime::Instance());
        EXPECT_NE(rtInstance, nullptr);
        rtDeviceReset(0);
    }
private:
    rtChipType_t originType;
};

extern int32_t faultEventFlag;
TEST_F(CloudV2AicpuErrMsgTest, SetStarsResultForDavinciTask)
{
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    bool flag = rtInstance->GetDisableThread();

    rtStream_t newStream;
    auto ret = rtStreamCreate(&newStream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    Stream *stream = static_cast<Stream *>(newStream);

    TaskInfo taskInfo = {};
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICPU;
    taskInfo.stream = stream;
    rtLogicCqReport_t logicCq = {};
    logicCq.errorCode = AICPU_HCCL_OP_RETRY_FAILED;
    SetStarsResultForDavinciTask(&taskInfo, logicCq);
    EXPECT_EQ(taskInfo.errorCode, TS_ERROR_AICPU_HCCL_OP_RETRY_FAILED);

    taskInfo.stream->Device_()->SetDeviceRas(true);
    logicCq.errorCode = AICPU_HCCL_OP_SDMA_LINK_FAILED;
    SetStarsResultForDavinciTask(&taskInfo, logicCq);
    EXPECT_EQ(taskInfo.errorCode, TS_ERROR_SDMA_POISON_ERROR);

    taskInfo.stream->Device_()->SetDeviceRas(false);
    SetStarsResultForDavinciTask(&taskInfo, logicCq);
    EXPECT_EQ(taskInfo.errorCode, TS_ERROR_SDMA_ERROR);

    faultEventFlag = 1;
    SetStarsResultForDavinciTask(&taskInfo, logicCq);
    EXPECT_EQ(taskInfo.errorCode, TS_ERROR_SDMA_LINK_ERROR);
    faultEventFlag = 0;

    ret = rtStreamDestroy(newStream);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtInstance->SetDisableThread(flag);
}

TEST_F(CloudV2AicpuErrMsgTest, SetAddr)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    EXPECT_NE(device, nullptr);
    AicpuErrMsg *aicpuErrObj = new (std::nothrow) AicpuErrMsg(device);
    aicpuErrObj->SetErrMsgBufAddr();
    aicpuErrObj->SetErrMsgBufAddr();

    DELETE_O(aicpuErrObj);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2AicpuErrMsgTest, ResetAddr)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    EXPECT_NE(device, nullptr);
    AicpuErrMsg *aicpuErrObj = new (std::nothrow) AicpuErrMsg(device);

    DELETE_O(aicpuErrObj);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2AicpuErrMsgTest, ResetAddrErr_1)
{

    Device * device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    EXPECT_NE(device, nullptr);
    AicpuErrMsg *aicpuErrObj = new (std::nothrow) AicpuErrMsg(device);
    DELETE_O(aicpuErrObj);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2AicpuErrMsgTest, SetErrMsgBufAddr_1)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    EXPECT_NE(device, nullptr);
    AicpuErrMsg *aicpuErrObj = new (std::nothrow) AicpuErrMsg(device);
    DELETE_O(aicpuErrObj);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2AicpuErrMsgTest, ParseErrMsg_1)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    EXPECT_NE(device, nullptr);
    AicpuErrMsg *aicpuErrObj = new (std::nothrow) AicpuErrMsg(device);
    uint8_t bufTmp[256 + 1] = {0};
    aicpu::AicpuErrMsgInfo *aicpuErrMsg = (aicpu::AicpuErrMsgInfo *)bufTmp;
    aicpuErrMsg->errType = 0;
    aicpuErrMsg->errorCode = TS_SUCCESS;

    aicpuErrObj->SetErrMsgBufAddr();

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync)
       .stubs()
       .will(returnValue(RT_ERROR_NONE));

    DELETE_O(aicpuErrObj);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2AicpuErrMsgTest, FillKernelLaunchPara_1)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    AicpuErrMsg *aicpuErrObj = new (std::nothrow) AicpuErrMsg(device);
    char *soName = "stub.so";
    rtKernelLaunchNames_t launchNames;
    launchNames.soName = soName;
    launchNames.kernelName = nullptr;
    launchNames.opName = nullptr;
    TaskInfo* kernTask = nullptr;
    rtError_t errCode = RT_ERROR_NONE;
    kernTask = device->GetTaskFactory()->Alloc(device->PrimaryStream_(), TS_TASK_TYPE_KERNEL_AICORE, errCode);
    EXPECT_NE(kernTask, nullptr);
    const rtError_t ret = aicpuErrObj->FillKernelLaunchPara(launchNames, kernTask);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    DELETE_O(aicpuErrObj);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2AicpuErrMsgTest, FillKernelLaunchPara_2)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    AicpuErrMsg *aicpuErrObj = new (std::nothrow) AicpuErrMsg(device);
    char *soName = "stub.so";
    rtKernelLaunchNames_t launchNames;
    launchNames.soName = soName;
    launchNames.kernelName = nullptr;
    launchNames.opName = nullptr;
    TaskInfo* kernTask = nullptr;
    rtError_t error = RT_ERROR_NONE;
    MOCKER_CPP_VIRTUAL(device->ArgLoader_(), &ArgLoader::GetKernelInfoDevAddr)
       .stubs()
       .will(returnValue(1));
    kernTask = device->GetTaskFactory()->Alloc(device->PrimaryStream_(), TS_TASK_TYPE_KERNEL_AICORE, error);
    error = aicpuErrObj->FillKernelLaunchPara(launchNames, kernTask);
    EXPECT_NE(error, RT_ERROR_NONE);

    DELETE_O(aicpuErrObj);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2AicpuErrMsgTest, FillKernelLaunchPara_3)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    AicpuErrMsg *aicpuErrObj = new (std::nothrow) AicpuErrMsg(device);
    char *KernelName = "stub.so";
    rtKernelLaunchNames_t launchNames;
    launchNames.soName = nullptr;
    launchNames.kernelName = KernelName;
    launchNames.opName = nullptr;
    TaskInfo* kernTask = nullptr;
    rtError_t error = RT_ERROR_NONE;
    MOCKER_CPP_VIRTUAL(device->ArgLoader_(), &ArgLoader::GetKernelInfoDevAddr)
       .stubs()
       .will(returnValue(1));
    kernTask = device->GetTaskFactory()->Alloc(device->PrimaryStream_(), TS_TASK_TYPE_KERNEL_AICORE, error);
    error = aicpuErrObj->FillKernelLaunchPara(launchNames, kernTask);
    EXPECT_NE(error, RT_ERROR_NONE);

    DELETE_O(aicpuErrObj);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2AicpuErrMsgTest, UnsetAddr)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    AicpuErrMsg *aicpuErrObj = new (std::nothrow) AicpuErrMsg(device);
    EXPECT_NE(aicpuErrObj, nullptr);
    aicpuErrObj->SetErrMsgBufAddr();

    DELETE_O(aicpuErrObj);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2AicpuErrMsgTest, ParseErrMsg_aicore)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    AicpuErrMsg *aicpuErrObj = new (std::nothrow) AicpuErrMsg(device);
    EXPECT_NE(aicpuErrObj, nullptr);
    uint8_t bufTmp[256 + 1] = {0};
    aicpu::AicoreErrMsgInfo *aicoreErrMsg = (aicpu::AicoreErrMsgInfo *)bufTmp;
    aicoreErrMsg->errType = static_cast<uint8_t>(aicpu::AicpuErrMsgType::ERR_MSG_TYPE_AICORE);
    aicoreErrMsg->errorCode = TS_ERROR_AICORE_EXCEPTION;

    aicpuErrObj->SetErrMsgBufAddr();

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync)
       .stubs()
       .will(returnValue(RT_ERROR_NONE));

    DELETE_O(aicpuErrObj);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2AicpuErrMsgTest, ParseErrMsg_aicpu)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    AicpuErrMsg *aicpuErrObj = new (std::nothrow) AicpuErrMsg(device);
    EXPECT_NE(aicpuErrObj, nullptr);
    uint8_t bufTmp[256 + 1] = {0};
    aicpu::AicpuErrMsgInfo *aicpuErrMsg = (aicpu::AicpuErrMsgInfo *)bufTmp;
    aicpuErrMsg->errType = static_cast<uint8_t>(aicpu::AicpuErrMsgType::ERR_MSG_TYPE_AICPU);
    aicpuErrMsg->errorCode = TS_ERROR_AICPU_EXCEPTION;

    aicpuErrObj->SetErrMsgBufAddr();

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync)
       .stubs()
       .will(returnValue(RT_ERROR_NONE));

    DELETE_O(aicpuErrObj);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2AicpuErrMsgTest, ParseErrMsg_empty)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    AicpuErrMsg *aicpuErrObj = new (std::nothrow) AicpuErrMsg(device);
    EXPECT_NE(aicpuErrObj, nullptr);
    uint8_t bufTmp[256 + 1] = {0};
    bufTmp[0] = static_cast<uint8_t>(aicpu::AicpuErrMsgType::ERR_MSG_TYPE_NULL);

    aicpuErrObj->SetErrMsgBufAddr();

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync)
       .stubs()
       .will(returnValue(RT_ERROR_NONE));

    DELETE_O(aicpuErrObj);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2AicpuErrMsgTest, ParseErrMsg_abnormal)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    AicpuErrMsg *aicpuErrObj = new (std::nothrow) AicpuErrMsg(device);
    EXPECT_NE(aicpuErrObj, nullptr);
    uint8_t bufTmp[256 + 1] = {0};
    aicpu::AicpuErrMsgInfo *aicpuErrMsg = (aicpu::AicpuErrMsgInfo *)bufTmp;
    aicpuErrMsg->errType = static_cast<uint8_t>(aicpu::AicpuErrMsgType::ERR_MSG_TYPE_AICPU);
    aicpuErrMsg->errorCode = RT_ERROR_NONE;

    aicpuErrObj->SetErrMsgBufAddr();

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::MemCopySync)
       .stubs()
       .will(returnValue(RT_ERROR_DRV_ERR));

    MOCKER_CPP_VIRTUAL(device->Driver_(), &Driver::DevMemAlloc)
       .stubs()
       .will(returnValue(RT_ERROR_DRV_ERR));

    aicpuErrObj->SetErrMsgBufAddr();

    DELETE_O(aicpuErrObj);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2AicpuErrMsgTest, RecordErrMsg_test)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    AicpuErrMsg *aicpuErrObj = new (std::nothrow) AicpuErrMsg(device);
    EXPECT_NE(aicpuErrObj, nullptr);
    Stream *stm = new Stream(device, 1);
    EXPECT_NE(stm, nullptr);
    const void *stubFunc = (void *)0x02;
    stm->streamId_ = 1;
    rtError_t errCode = RT_ERROR_NONE;
    TaskInfo * const kernTask = device->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_KERNEL_AICORE, errCode);
    EXPECT_NE(kernTask, nullptr);
    AicTaskInit(kernTask, (uint32_t)0, (uint16_t)1, (uint32_t)0, nullptr);
    EXPECT_EQ(kernTask->type, TS_TASK_TYPE_KERNEL_AICORE);

    uint8_t bufTmp[256 + 1] = {0};
    aicpu::AicoreErrMsgInfo *aicoreErrMsg = (aicpu::AicoreErrMsgInfo *)bufTmp;
    aicoreErrMsg->errType = static_cast<uint8_t>(aicpu::AicpuErrMsgType::ERR_MSG_TYPE_AICORE);
    aicoreErrMsg->errorCode = TS_ERROR_AICORE_EXCEPTION;
    aicoreErrMsg->streamId = stm->Id_();
    aicoreErrMsg->taskId = kernTask->id;

    device->GetTaskFactory()->Recycle(kernTask);
    DELETE_O(stm);
    DELETE_O(aicpuErrObj);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

bool GetDefaultFlag()
{
    return true;
}

TEST_F(CloudV2AicpuErrMsgTest, FaultForAiCore1)
{
    Device *device = ((Runtime *)Runtime::Instance())->DeviceRetain(0, 0);
    EXPECT_NE(device, nullptr);
    const void *stubFunc = (void *)0x03;
    const char *stubName = "abcd";
    PlainProgram stubProg(Program::MACH_AI_CORE);
    Program *program = &stubProg;
    program->kernelNames_ = {'a', 'b', 'c', '\0'};

    MOCKER_CPP(&Runtime::GetProgram)
        .stubs()
        .will(returnValue(true));
    MOCKER_CPP(&Runtime::PutProgram)
        .stubs()
        .will(ignoreReturnValue());

    Stream *stm = new Stream(device, 1);
    stm->streamId_ = 1;
    rtError_t errCode = RT_ERROR_NONE;
    TaskInfo * const kernTask = device->GetTaskFactory()->Alloc(stm, TS_TASK_TYPE_KERNEL_AICORE, errCode);

    AicTaskInit(kernTask, (uint32_t)0, (uint16_t)1, (uint32_t)0, nullptr);
    EXPECT_EQ(kernTask->type, TS_TASK_TYPE_KERNEL_AICORE);
    Kernel *kernel = new (std::nothrow) Kernel(stubFunc, stubName, "", program, 0);
    kernTask->u.aicTaskInfo.kernel = kernel;

    MOCKER_CPP_VIRTUAL(Runtime::Instance(), &Runtime::GetPriCtxByDeviceId).stubs().will(returnValue((Context *)(0x02)));
    // 1. kernelInfoExt_ is empty
    PrintErrorInfo(kernTask, 0);
    bool exceptFlag = false;
    for (const auto &errMsg : stm->errorMsg_) {
        std::string errmsg = errMsg.second.c_str();
        size_t pos = errmsg.find("module is nullptr");
        if (pos == std::string::npos) {
            continue;
        } else {
            size_t pos = errmsg.find("fault kernel info ext=none");
            if (pos == std::string::npos) {
                continue;
            }
            exceptFlag = GetDefaultFlag();
            break;
        }
    }
    EXPECT_EQ(exceptFlag, true);

    // 2. kernelInfoExt_ is not empty
    kernel->SetKernelInfoExt(reinterpret_cast<const char_t *>("infoext"));
    PrintErrorInfo(kernTask, 0);
    bool exceptFlag2 = false;
    for (const auto &errMsg : stm->errorMsg_) {
        std::string errmsg = errMsg.second.c_str();
        size_t pos = errmsg.find("module is nullptr");
        if (pos == std::string::npos) {
            continue;
        } else {
            size_t pos = errmsg.find("fault kernel info ext=infoext");
            if (pos == std::string::npos) {
                continue;
            }
            exceptFlag2 = GetDefaultFlag();
            break;
        }
    }
    EXPECT_EQ(exceptFlag2, true);

    device->GetTaskFactory()->Recycle(kernTask);
    DELETE_O(stm);
    DELETE_O(kernel);
    ((Runtime *)Runtime::Instance())->DeviceRelease(device);
}

TEST_F(CloudV2AicpuErrMsgTest, GetError)
{
    Device *dev = nullptr;
    Stream stm(dev, 0);
    stm.errCode_ = TS_ERROR_AICPU_HCCL_OP_RETRY_FAILED;
    auto error = stm.GetError();
    EXPECT_EQ(error, RT_ERROR_AICPU_HCCL_OP_RETRY_FAILED);
}