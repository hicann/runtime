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
#include "aicpu_scheduler_agent.hpp"
#include "runtime/rt_model.h"

using namespace testing;
using namespace cce::runtime;

class CloudV2AicpuSchedulerAgentTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "AicpuSchedulerAgentTest SetUP" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "AicpuSchedulerAgentTest Tear Down" << std::endl;
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }

protected:
    AicpuSchedulerAgent aicpuSdAgent_;
};

TEST_F(CloudV2AicpuSchedulerAgentTest, NotInit)
{
    rtAicpuModelInfo_t aicpuModelInfo{};
    rtError_t ret = aicpuSdAgent_.AicpuModelLoad(&aicpuModelInfo);
    EXPECT_EQ(ret, RT_ERROR_DRV_SYM_AICPU);
    uint32_t modelId = 0;
    ret = aicpuSdAgent_.AicpuModelDestroy(modelId);
    EXPECT_EQ(ret, RT_ERROR_DRV_SYM_AICPU);
    ret = aicpuSdAgent_.AicpuModelExecute(modelId);
    EXPECT_EQ(ret, RT_ERROR_DRV_SYM_AICPU);
    const char *dumpInfo = "dumpinfo";
    ret = aicpuSdAgent_.DatadumpInfoLoad(dumpInfo, sizeof(dumpInfo));
    EXPECT_EQ(ret, RT_ERROR_DRV_SYM_AICPU);
}

extern "C" {
int AICPUModelLoadStubSuccess(void *ptr)
{
    return 0;
}
int AICPUModelDestroyStubSuccess(uint32_t modelId)
{
    return 0;
}
int AICPUModelExecuteStubSuccess(uint32_t modelId)
{
    return 0;
}
int32_t LoadOpMappingInfoStubSuccess(const void *infoAddr, uint32_t len)
{
    return 0;
}
int AICPUModelLoadStubFail(void *ptr)
{
    return -1;
}
int AICPUModelDestroyStubFail(uint32_t modelId)
{
    return -1;
}
int AICPUModelExecuteStubFail(uint32_t modelId)
{
    return -1;
}
int32_t LoadOpMappingInfoStubFail(const void *infoAddr, uint32_t len)
{
    return -1;
}
}

TEST_F(CloudV2AicpuSchedulerAgentTest, dlopen_failed)
{
    void *handle = nullptr;
    MOCKER(mmDlopen).stubs().will(returnValue(handle));

    rtError_t ret = aicpuSdAgent_.Init();
    EXPECT_EQ(ret, RT_ERROR_DRV_OPEN_AICPU);
}

TEST_F(CloudV2AicpuSchedulerAgentTest, ModelLoad_notfound)
{
    uint64_t stub = 123;
    void *handle = &stub;
    MOCKER(mmDlopen).stubs().will(returnValue(handle));
    MOCKER(mmDlclose).stubs().will(returnValue(0));
    const char *funcName = "AICPUModelLoad";
    MOCKER(mmDlsym).defaults().with(mockcpp::any(), smirror(funcName)).will(returnValue((void *)nullptr));
    funcName = "AICPUModelDestroy";
    MOCKER(mmDlsym).defaults().with(mockcpp::any(), smirror(funcName)).will(returnValue((void *)AICPUModelDestroyStubSuccess));
    funcName = "AICPUModelExecute";
    MOCKER(mmDlsym).defaults().with(mockcpp::any(), smirror(funcName)).will(returnValue((void *)AICPUModelExecuteStubSuccess));
    funcName = "LoadOpMappingInfo";
    MOCKER(mmDlsym).defaults().with(mockcpp::any(), smirror(funcName)).will(returnValue((void *)LoadOpMappingInfoStubSuccess));

    rtError_t ret = aicpuSdAgent_.Init();
    EXPECT_EQ(ret, RT_ERROR_DRV_SYM_AICPU);

    aicpuSdAgent_.Destroy();
}


TEST_F(CloudV2AicpuSchedulerAgentTest, ModelDestroy_notfound)
{
    uint64_t stub = 123;
    void *handle = &stub;
    MOCKER(mmDlopen).stubs().will(returnValue(handle));
    MOCKER(mmDlclose).stubs().will(returnValue(0));
    const char *funcName = "AICPUModelLoad";
    MOCKER(mmDlsym).defaults().with(mockcpp::any(), smirror(funcName)).will(returnValue((void *)AICPUModelLoadStubSuccess));
    funcName = "AICPUModelDestroy";
    MOCKER(mmDlsym).defaults().with(mockcpp::any(), smirror(funcName)).will(returnValue((void *)nullptr));
    funcName = "AICPUModelExecute";
    MOCKER(mmDlsym).defaults().with(mockcpp::any(), smirror(funcName)).will(returnValue((void *)AICPUModelExecuteStubSuccess));
    funcName = "LoadOpMappingInfo";
    MOCKER(mmDlsym).defaults().with(mockcpp::any(), smirror(funcName)).will(returnValue((void *)LoadOpMappingInfoStubSuccess));

    rtError_t ret = aicpuSdAgent_.Init();
    EXPECT_EQ(ret, RT_ERROR_DRV_SYM_AICPU);

    aicpuSdAgent_.Destroy();
}

TEST_F(CloudV2AicpuSchedulerAgentTest, ModelExecute_notfound)
{
    uint64_t stub = 123;
    void *handle = &stub;
    MOCKER(mmDlopen).stubs().will(returnValue(handle));
    MOCKER(mmDlclose).stubs().will(returnValue(0));
    const char *funcName = "AICPUModelLoad";
    MOCKER(mmDlsym).defaults().with(mockcpp::any(), smirror(funcName)).will(returnValue((void *)AICPUModelLoadStubSuccess));
    funcName = "AICPUModelDestroy";
    MOCKER(mmDlsym).defaults().with(mockcpp::any(), smirror(funcName)).will(returnValue((void *)AICPUModelDestroyStubSuccess));
    funcName = "AICPUModelExecute";
    MOCKER(mmDlsym).defaults().with(mockcpp::any(), smirror(funcName)).will(returnValue((void *)nullptr));
    funcName = "LoadOpMappingInfo";
    MOCKER(mmDlsym).defaults().with(mockcpp::any(), smirror(funcName)).will(returnValue((void *)LoadOpMappingInfoStubSuccess));

    rtError_t ret = aicpuSdAgent_.Init();
    EXPECT_EQ(ret, RT_ERROR_DRV_SYM_AICPU);

    aicpuSdAgent_.Destroy();
}

TEST_F(CloudV2AicpuSchedulerAgentTest, LoadOpMapping_notfound)
{
    uint64_t stub = 123;
    void *handle = &stub;
    MOCKER(mmDlopen).stubs().will(returnValue(handle));
    MOCKER(mmDlclose).stubs().will(returnValue(0));
    const char *funcName = "AICPUModelLoad";
    MOCKER(mmDlsym).defaults().with(mockcpp::any(), smirror(funcName)).will(returnValue((void *)AICPUModelLoadStubSuccess));
    funcName = "AICPUModelDestroy";
    MOCKER(mmDlsym).defaults().with(mockcpp::any(), smirror(funcName)).will(returnValue((void *)AICPUModelDestroyStubSuccess));
    funcName = "AICPUModelExecute";
    MOCKER(mmDlsym).defaults().with(mockcpp::any(), smirror(funcName)).will(returnValue((void *)AICPUModelExecuteStubSuccess));
    funcName = "LoadOpMappingInfo";
    MOCKER(mmDlsym).defaults().with(mockcpp::any(), smirror(funcName)).will(returnValue((void *)nullptr));

    rtError_t ret = aicpuSdAgent_.Init();
    EXPECT_EQ(ret, RT_ERROR_DRV_SYM_AICPU);

    aicpuSdAgent_.Destroy();
}

TEST_F(CloudV2AicpuSchedulerAgentTest, success)
{
    uint64_t stub = 123;
    void *handle = &stub;
    MOCKER(mmDlopen).stubs().will(returnValue(handle));
    MOCKER(mmDlclose).stubs().will(returnValue(0));
    const char *funcName = "AICPUModelLoad";
    MOCKER(mmDlsym).expects(once()).with(mockcpp::any(), smirror(funcName)).will(returnValue((void *)AICPUModelLoadStubSuccess));
    funcName = "AICPUModelDestroy";
    MOCKER(mmDlsym).expects(once()).with(mockcpp::any(), smirror(funcName)).will(
            returnValue((void *)AICPUModelDestroyStubSuccess));
    funcName = "AICPUModelExecute";
    MOCKER(mmDlsym).expects(once()).with(mockcpp::any(), smirror(funcName)).will(
            returnValue((void *)AICPUModelExecuteStubSuccess));
    funcName = "LoadOpMappingInfo";
    MOCKER(mmDlsym).expects(once()).with(mockcpp::any(), smirror(funcName)).will(
            returnValue((void *)LoadOpMappingInfoStubSuccess));

    rtError_t ret = aicpuSdAgent_.Init();
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtAicpuModelInfo_t aicpuModelInfo{};
    ret = aicpuSdAgent_.AicpuModelLoad(&aicpuModelInfo);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    uint32_t modelId = 0;
    ret = aicpuSdAgent_.AicpuModelDestroy(modelId);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = aicpuSdAgent_.AicpuModelExecute(modelId);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    const char *dumpInfo = "dumpinfo";
    ret = aicpuSdAgent_.DatadumpInfoLoad(dumpInfo, sizeof(dumpInfo));
    EXPECT_EQ(ret, RT_ERROR_NONE);
    aicpuSdAgent_.Destroy();
}

TEST_F(CloudV2AicpuSchedulerAgentTest, failed)
{
    uint64_t stub = 123;
    void *handle = &stub;
    MOCKER(mmDlopen).stubs().will(returnValue(handle));
    MOCKER(mmDlclose).stubs().will(returnValue(0));
    const char *funcName = "AICPUModelLoad";
    MOCKER(mmDlsym).expects(once()).with(mockcpp::any(), smirror(funcName)).will(returnValue((void *)AICPUModelLoadStubFail));
    funcName = "AICPUModelDestroy";
    MOCKER(mmDlsym).expects(once()).with(mockcpp::any(), smirror(funcName)).will(
            returnValue((void *)AICPUModelDestroyStubFail));
    funcName = "AICPUModelExecute";
    MOCKER(mmDlsym).expects(once()).with(mockcpp::any(), smirror(funcName)).will(
            returnValue((void *)AICPUModelExecuteStubFail));
    funcName = "LoadOpMappingInfo";
    MOCKER(mmDlsym).expects(once()).with(mockcpp::any(), smirror(funcName)).will(
            returnValue((void *)LoadOpMappingInfoStubFail));

    rtError_t ret = aicpuSdAgent_.Init();
    EXPECT_EQ(ret, RT_ERROR_NONE);

    rtAicpuModelInfo_t aicpuModelInfo{};
    ret = aicpuSdAgent_.AicpuModelLoad(&aicpuModelInfo);
    EXPECT_EQ(ret, RT_ERROR_AICPU_INTERNAL_ERROR);
    uint32_t modelId = 0;
    ret = aicpuSdAgent_.AicpuModelDestroy(modelId);
    EXPECT_EQ(ret, RT_ERROR_AICPU_INTERNAL_ERROR);
    ret = aicpuSdAgent_.AicpuModelExecute(modelId);
    EXPECT_EQ(ret, RT_ERROR_AICPU_INTERNAL_ERROR);
    const char *dumpInfo = "dumpinfo";
    ret = aicpuSdAgent_.DatadumpInfoLoad(dumpInfo, sizeof(dumpInfo));
    EXPECT_EQ(ret, RT_ERROR_AICPU_INTERNAL_ERROR);
    aicpuSdAgent_.Destroy();
}
