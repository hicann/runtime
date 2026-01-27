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
#include "driver/ascend_hal.h"
#include "securec.h"
#include "runtime/rt.h"
#include "runtime/event.h"
#include "config.hpp"
#include "task.hpp"
#define private public
#define protected public
#include "runtime.hpp"
#include "api.hpp"
#include "api_impl.hpp"
#include "program.hpp"
#include "context.hpp"
#include "device.hpp"
#include "logger.hpp"
#include "engine.hpp"
#include "task_info.hpp"
#include "npu_driver.hpp"
#include "api_error.hpp"
#include "event.hpp"
#include "stream.hpp"
#include "notify.hpp"
#include "profiler.hpp"
#include "device_state_callback_manager.hpp"
#include "task_fail_callback_manager.hpp"
#include "subscribe.hpp"
#undef protected
#undef private
#include "task_to_sqe.hpp"
#include "rt_preload_task.h"
#include "thread_local_container.hpp"

using namespace testing;
using namespace cce::runtime;

class ApiParmaSqeTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        std::cout<<"Parma Build Sqe test start"<<std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout<<"Parma Build Sqe test end"<<std::endl;
    }

    virtual void SetUp()
    {
        rtSetDevice(0);
    }

    virtual void TearDown()
    {
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }
};

TEST_F(ApiParmaSqeTest, GetStreamBufferLen)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
    uint32_t bufferLen = 0;
    error = rtGetStreamBufferLen(true, &bufferLen);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    rtInstance->SetChipType(CHIP_NANO);
    GlobalContainer::SetRtChipType(CHIP_NANO);

    error = rtGetStreamBufferLen(true, &bufferLen);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
}


TEST_F(ApiParmaSqeTest, GetTaskBufferLen)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
    // not support expect chip type nano
    rtTaskBuffType_t type = HWTS_STATIC_TASK_DESC;
    uint32_t bufferLen = 0U;
    error = rtGetTaskBufferLen(type, &bufferLen);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

   rtInstance->SetChipType(CHIP_NANO);
    GlobalContainer::SetRtChipType(CHIP_NANO);

    // bufferlen is null
    error = rtGetTaskBufferLen(type, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    // static task
    type = HWTS_STATIC_TASK_DESC;
    bufferLen = 0;
    error = rtGetTaskBufferLen(type, &bufferLen);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(bufferLen, 8U);

    // dynamic task
    type = HWTS_DYNAMIC_TASK_DESC;
    bufferLen = 0;
    error = rtGetTaskBufferLen(type, &bufferLen);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(bufferLen, 20U);

    // prefetch task
    type = PARAM_TASK_INFO_DESC;
    bufferLen = 0;
    error = rtGetTaskBufferLen(type, &bufferLen);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(bufferLen, PRELOAD_PARAM_BUFFER_MAX_N * 20U);

    error = rtGetTaskBufferLen(MAX_TASK, &bufferLen);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
}

TEST_F(ApiParmaSqeTest, TaskStaticSqeBuild)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
   rtInstance->SetChipType(CHIP_NANO);
    GlobalContainer::SetRtChipType(CHIP_NANO);
    uint32_t taskLen = 0;
    uint32_t bufferLen = 0;
    rtTaskBuffType_t type = HWTS_STATIC_TASK_DESC;
    error = rtGetTaskBufferLen(type, &bufferLen);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtTaskInput_t taskInput = {0};
    void* dataBuffer = malloc(bufferLen);
    memset_s(dataBuffer, bufferLen, 0, bufferLen);
    taskInput.dataBuffer = dataBuffer;
    taskInput.bufferLen = bufferLen;

    // not support expect chip type nano
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
    error = rtTaskBuild(&taskInput, &taskLen);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

    // taskInput is null
   rtInstance->SetChipType(CHIP_NANO);
    GlobalContainer::SetRtChipType(CHIP_NANO);
    error = rtTaskBuild(nullptr, &taskLen);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    // taskType not support
    taskInput.compilerInfo.taskType = RT_TASK_TYPE_KERNEL_AICPU;
    taskInput.compilerInfo.bufType = type;
    error = rtTaskBuild(&taskInput, &taskLen);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    taskInput.compilerInfo.taskType = RT_TASK_TYPE_KERNEL_AICPU;
    taskInput.compilerInfo.bufType = MAX_TASK;
    error = rtTaskBuild(&taskInput, &taskLen);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);


    // static task aicore
    taskInput.compilerInfo.taskType = RT_TASK_TYPE_KERNEL_NANO_AICORE;
    taskInput.compilerInfo.bufType = type;
    error = rtTaskBuild(&taskInput, &taskLen);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(taskLen, sizeof(rtStaticSqe_t));

    // static task hostfunc
    taskInput.compilerInfo.taskType = RT_TASK_TYPE_KERNEL_NANO_AICPU_HOSTFUNC;
    taskInput.compilerInfo.bufType = type;
    error = rtTaskBuild(&taskInput, &taskLen);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(taskLen, sizeof(rtStaticSqe_t));

    free(dataBuffer);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
}


TEST_F(ApiParmaSqeTest, TaskDynamicSqeBuild)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
   rtInstance->SetChipType(CHIP_NANO);
    GlobalContainer::SetRtChipType(CHIP_NANO);
    uint32_t taskLen = 0;
    uint32_t bufferLen = 0;
    rtTaskBuffType_t type = HWTS_DYNAMIC_TASK_DESC;
    error = rtGetTaskBufferLen(type, &bufferLen);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtTaskInput_t taskInput = {0};
    void* dataBuffer = malloc(bufferLen);
    memset_s(dataBuffer, bufferLen, 0, bufferLen);
    taskInput.dataBuffer = dataBuffer;
    taskInput.bufferLen = bufferLen;

    // dynamic task aicore
    taskInput.compilerInfo.taskType = RT_TASK_TYPE_KERNEL_NANO_AICORE;
    taskInput.compilerInfo.bufType = type;
    error = rtTaskBuild(&taskInput, &taskLen);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(taskLen, sizeof(rtDynamicSqe_t));

    // dynamic task hostfunc
    taskInput.compilerInfo.taskType = RT_TASK_TYPE_KERNEL_NANO_AICPU_HOSTFUNC;
    taskInput.compilerInfo.bufType = type;
    error = rtTaskBuild(&taskInput, &taskLen);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(taskLen, sizeof(rtDynamicSqe_t));

    free(dataBuffer);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
}

TEST_F(ApiParmaSqeTest, TaskPrefetchSqeBuild)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
   rtInstance->SetChipType(CHIP_NANO);
    GlobalContainer::SetRtChipType(CHIP_NANO);
    uint32_t taskLen = 0;
    uint32_t bufferLen = 0;
    rtTaskBuffType_t type = PARAM_TASK_INFO_DESC;
    error = rtGetTaskBufferLen(type, &bufferLen);
    EXPECT_EQ(error, RT_ERROR_NONE);

    rtTaskInput_t taskInput = {0};
    void* dataBuffer = malloc(bufferLen);
    memset_s(dataBuffer, bufferLen, 0, bufferLen);
    taskInput.dataBuffer = dataBuffer;
    taskInput.bufferLen = bufferLen;

    // param task aicore
    taskInput.compilerInfo.taskType = RT_TASK_TYPE_KERNEL_NANO_AICORE;
    taskInput.compilerInfo.bufType = type;
    taskInput.compilerInfo.u.nanoAicoreTask.u.paramBufDesc.prefetchBufSize = 1U;
    taskInput.compilerInfo.u.nanoAicoreTask.u.paramBufDesc.paramBufSize = 1U;
    error = rtTaskBuild(&taskInput, &taskLen);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(taskLen, sizeof(rtPrefetchSqe_t) + sizeof(rtPreLoadSqe_t));

    // param task hostfunc
    taskInput.compilerInfo.taskType = RT_TASK_TYPE_KERNEL_NANO_AICPU_HOSTFUNC;
    taskInput.compilerInfo.bufType = type;
    taskInput.compilerInfo.u.nanoHostFuncTask.u.paramBufDesc.prefetchBufSize = 1U;
    taskInput.compilerInfo.u.nanoHostFuncTask.u.paramBufDesc.paramBufSize = 1U;
    void* bufInfo = malloc(bufferLen);
    memset_s(bufInfo, bufferLen, 0, bufferLen);
    taskInput.compilerInfo.u.nanoHostFuncTask.u.paramBufDesc.bufInfo = bufInfo;
    taskInput.compilerInfo.u.nanoHostFuncTask.u.paramBufDesc.bufSize = bufferLen;
    error = rtTaskBuild(&taskInput, &taskLen);
    EXPECT_EQ(error, RT_ERROR_NONE);

    free(dataBuffer);
    free(bufInfo);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
}

TEST_F(ApiParmaSqeTest, GetElfOffset)
{
    rtError_t error;
    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t chipType = rtInstance->GetChipType();
    uint32_t MAX_LENGTH = 75776;
    uint32_t offset = 0U;
    char bindata[MAX_LENGTH];

    FILE *bin = NULL;
    bin = fopen("llt/ace/npuruntime/runtime/ut/runtime/test/data/elf.o", "rb");
    if (bin == NULL) {
        printf("error\n");
        return;
    } else {
        printf("succ\n");
    }

    fread(bindata, sizeof(char), MAX_LENGTH, bin);
    fclose(bin);

    error = rtGetElfOffset(bindata, MAX_LENGTH, &offset);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);

   rtInstance->SetChipType(CHIP_NANO);
    GlobalContainer::SetRtChipType(CHIP_NANO);

    error = rtGetElfOffset(nullptr, MAX_LENGTH, &offset);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetElfOffset(bindata, MAX_LENGTH, nullptr);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetElfOffset(bindata, MAX_LENGTH, &offset);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(offset, 0x40);
    rtInstance->SetChipType(chipType);
    GlobalContainer::SetRtChipType(chipType);
}