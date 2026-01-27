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
#define private public
#define protected public
#include "runtime.hpp"
#include "model.hpp"
#include "raw_device.hpp"
#include "module.hpp"
#include "notify.hpp"
#include "event.hpp"
#include "task_info.hpp"
#include "task_info.h"
#include "ffts_task.h"
#include "device/device_error_proc.hpp"
#include "program.hpp"
#include "uma_arg_loader.hpp"
#include "npu_driver.hpp"
#include "ctrl_res_pool.hpp"
#include "stream_sqcq_manage.hpp"
#include "davinci_kernel_task.h"
#include "profiler.hpp"
#include "thread_local_container.hpp"
#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;

class FillFftsPlusMixSqeSubtaskTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {}

    static void TearDownTestCase()
    {}

    virtual void SetUp()
    {

    }

    virtual void TearDown()
    {
    }
};

TEST_F(FillFftsPlusMixSqeSubtaskTest, main_aic)
{
    AicTaskInfo taskInfo;
    const void *stubFunc = (void *)0x02;
    const char *stubName = "abc";
    Kernel *kernel = NULL;
    PlainProgram stubProg(Program::MACH_AI_CORE);
    Program *program = &stubProg;
    program->kernelNames_ = {'a', 'b', 'c', 'd', '\0'};
    kernel = new (std::nothrow) Kernel(stubFunc, stubName, "", program, 0);
    taskInfo.kernel = kernel;
    kernel->SetMixType(MIX_AIC_AIV_MAIN_AIV);

    uint8_t subtype = RT_CTX_TYPE_AICORE;
    FillFftsPlusMixSqeSubtask(&taskInfo, &subtype);
    EXPECT_EQ(subtype, RT_CTX_TYPE_MIX_AIV);
    delete kernel;
}

TEST_F(FillFftsPlusMixSqeSubtaskTest, default_case)
{
    AicTaskInfo taskInfo;
    const void *stubFunc = (void *)0x02;
    const char *stubName = "abc";
    Kernel *kernel = NULL;
    PlainProgram stubProg(Program::MACH_AI_CORE);
    Program *program = &stubProg;
    program->kernelNames_ = {'a', 'b', 'c', 'd', '\0'};
    kernel = new (std::nothrow) Kernel(stubFunc, stubName, "", program, 0);
    taskInfo.kernel = kernel;
    kernel->SetMixType(NO_MIX);

    uint8_t subtype = RT_CTX_TYPE_AICORE;
    FillFftsPlusMixSqeSubtask(&taskInfo, &subtype);
    EXPECT_EQ(subtype, RT_CTX_TYPE_AICORE);
    delete kernel;
}

class PrintErrorModelExecuteTaskFuncCallTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {}

    static void TearDownTestCase()
    {}

    virtual void SetUp()
    {

    }

    virtual void TearDown()
    {
    }
};

TEST_F(PrintErrorModelExecuteTaskFuncCallTest, default_case)
{
   TaskInfo taskInfo = {};
   Model *model = new Model();
   ModelExecuteTaskInfo *modelExecuteTaskInfo = &(taskInfo.u.modelExecuteTaskInfo);
   modelExecuteTaskInfo->model = model;
   EXPECT_EQ(model, modelExecuteTaskInfo->model);
   modelExecuteTaskInfo->model->SetFuncCallSvmMem(0ULL);
   PrintErrorModelExecuteTaskFuncCall(&taskInfo);
   delete model;
}