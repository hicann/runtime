/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "mockcpp/mockcpp.hpp"
#include "gtest/gtest.h"
#include "msprof_dlog.h"
#include "prof_tx_plugin.h"
#include "prof_runtime_plugin.h"
#include "errno/error_code.h"
#include "mmpa_api.h"
#include "acl/acl_base.h"
#include "runtime/base.h"

using namespace analysis::dvvp::common::error;
using namespace ProfAPI;
class PROF_TX_UTTEST : public testing::Test {
protected:
    virtual void SetUp() {
        MOCKER(dlopen).stubs().will(invoke(mmDlopen));
        MOCKER(dlsym).stubs().will(invoke(mmDlsym));
        MOCKER(dlclose).stubs().will(invoke(mmDlclose));
        MOCKER(dlerror).stubs().will(invoke(mmDlerror));
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(PROF_TX_UTTEST, PROF_ACLPOP)
{
    ProfTxPlugin::GetProftxInstance().ProftxApiInit((void*)0x1); 
    EXPECT_EQ(PROFILING_FAILED, ProfTxPlugin::GetProftxInstance().ProftxPop());
}

TEST_F(PROF_TX_UTTEST, PROF_PROFACLRANGESTART)
{
    uint32_t rangeId;
    EXPECT_EQ(PROFILING_FAILED, ProfTxPlugin::GetProftxInstance().ProftxRangeStart(nullptr, &rangeId));
}

TEST_F(PROF_TX_UTTEST, PROF_PROFACLRANGESTOP)
{
    uint32_t rangeId;
    EXPECT_EQ(PROFILING_FAILED, ProfTxPlugin::GetProftxInstance().ProftxRangeStop(rangeId));
}

TEST_F(PROF_TX_UTTEST, PROF_PROFACLSETSTAMPTRACEMESSAGE)
{
    const char *message = "hello";
    EXPECT_EQ(PROFILING_FAILED, ProfTxPlugin::GetProftxInstance().ProftxSetStampTraceMessage(nullptr, message, 6));
}

TEST_F(PROF_TX_UTTEST, PROF_PROFACLMARK)
{
    EXPECT_EQ(PROFILING_FAILED, ProfTxPlugin::GetProftxInstance().ProftxMark(nullptr));
}

TEST_F(PROF_TX_UTTEST, PROF_PROFACLSETCATEGORYNAME)
{
    EXPECT_EQ(PROFILING_FAILED, ProfTxPlugin::GetProftxInstance().ProftxSetCategoryName(0, nullptr));
}

TEST_F(PROF_TX_UTTEST, PROF_PROFACLSETSTAMPCATEGORY)
{
    EXPECT_EQ(PROFILING_FAILED, ProfTxPlugin::GetProftxInstance().ProftxSetStampCategory(nullptr, 0));
}

TEST_F(PROF_TX_UTTEST, PROF_PROFACLSETSTAMPPAYLOAD)
{
    EXPECT_EQ(PROFILING_FAILED, ProfTxPlugin::GetProftxInstance().ProftxSetStampPayload(nullptr, 0, nullptr));
}

TEST_F(PROF_TX_UTTEST, PROF_PROFACLCREATESTAMP)
{
    EXPECT_EQ(nullptr, ProfTxPlugin::GetProftxInstance().ProftxCreateStamp());
}

int gFuncRunFlage = 0;
TEST_F(PROF_TX_UTTEST, PROF_ACLPUSH)
{
    EXPECT_EQ(PROFILING_FAILED, ProfTxPlugin::GetProftxInstance().ProftxPush(nullptr));
}

void Fake_ProfAclDestroyStamp(void *)
{
    gFuncRunFlage = 2;
}
TEST_F(PROF_TX_UTTEST, PROF_ProfAclDestroyStamp)
{
    GlobalMockObject::verify();
    MOCKER(dlsym)
    .stubs()
    .will(returnValue((void *)&Fake_ProfAclDestroyStamp));
    ProfTxPlugin::GetProftxInstance().ProftxDestroyStamp(nullptr);
    EXPECT_EQ(2, gFuncRunFlage);
}

rtError_t rtProfilerTraceExStub2(uint64_t indexId, uint64_t modelId, uint16_t tagId, rtStream_t stm)
{
    (void)indexId;
    (void)modelId;
    (void)tagId;
    (void)stm;
    return -1;
}

TEST_F(PROF_TX_UTTEST, RuntimePluginBase)
{
    std::shared_ptr<ProfRuntimePlugin> plugin;
    plugin = std::make_shared<ProfRuntimePlugin>();
    // Failed to get api stub[rtProfilerTraceEx] func
    EXPECT_EQ(PROFILING_SUCCESS, plugin->RuntimeApiInit());
    EXPECT_EQ(PROFILING_FAILED, plugin->ProfMarkEx(0, 0, 0, nullptr));
    MOCKER(&ProfRuntimePlugin::GetPluginApiFunc)
        .stubs()
        .will(returnValue((void *)&rtProfilerTraceExStub2));
    EXPECT_EQ(PROFILING_FAILED, plugin->ProfMarkEx(0, 0, 0, nullptr));
    plugin->runtimeLibHandle_ = nullptr;
    plugin->runtimeApiInfoMap_.clear();
}

TEST_F(PROF_TX_UTTEST, ReportAdditionalInfo_Success)
{
    aclprofTensor tensors[5];
    for (int i = 0; i < 5; i++) {
        tensors[i].type = i;
        tensors[i].format = i + 1;
        tensors[i].dataType = i + 2;
        tensors[i].shapeDim = 4;
        for (int j = 0; j < 4; j++) {
            tensors[i].shape[j] = j + 1;
        }
    }
    
    aclprofTensorInfo tensorInfo;
    tensorInfo.opNameId = 12345;
    tensorInfo.tensorNum = 5;
    tensorInfo.tensors = tensors;
    
    uint64_t timeStampPush = 1000;
    uint64_t timeStampPop = 2000;
    
    MOCKER(MsprofReportAdditionalInfo)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    
    EXPECT_EQ(PROFILING_SUCCESS, ProfTxPlugin::GetProftxInstance().ReportAdditionalInfo(&tensorInfo, timeStampPush, timeStampPop));
}

TEST_F(PROF_TX_UTTEST, ReportAdditionalInfo_ZeroTensorNum)
{
    aclprofTensorInfo tensorInfo;
    tensorInfo.opNameId = 12345;
    tensorInfo.tensorNum = 0;
    tensorInfo.tensors = nullptr;
    
    uint64_t timeStampPush = 1000;
    uint64_t timeStampPop = 2000;
    
    MOCKER(MsprofReportAdditionalInfo)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    
    EXPECT_EQ(PROFILING_SUCCESS, ProfTxPlugin::GetProftxInstance().ReportAdditionalInfo(&tensorInfo, timeStampPush, timeStampPop));
}

TEST_F(PROF_TX_UTTEST, ReportAdditionalInfo_SingleTensor)
{
    aclprofTensor tensor;
    tensor.type = 0;
    tensor.format = 1;
    tensor.dataType = 2;
    tensor.shapeDim = 3;
    for (int j = 0; j < 3; j++) {
        tensor.shape[j] = j + 1;
    }
    
    aclprofTensorInfo tensorInfo;
    tensorInfo.opNameId = 67890;
    tensorInfo.tensorNum = 1;
    tensorInfo.tensors = &tensor;
    
    uint64_t timeStampPush = 500;
    uint64_t timeStampPop = 1500;
    
    MOCKER(MsprofReportAdditionalInfo)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    
    EXPECT_EQ(PROFILING_SUCCESS, ProfTxPlugin::GetProftxInstance().ReportAdditionalInfo(&tensorInfo, timeStampPush, timeStampPop));
}

TEST_F(PROF_TX_UTTEST, ReportAdditionalInfo_MaxTensors)
{
    aclprofTensor tensors[5];
    for (int i = 0; i < 5; i++) {
        tensors[i].type = i;
        tensors[i].format = i + 1;
        tensors[i].dataType = i + 2;
        tensors[i].shapeDim = 8;
        for (int j = 0; j < 8; j++) {
            tensors[i].shape[j] = j + 1;
        }
    }
    
    aclprofTensorInfo tensorInfo;
    tensorInfo.opNameId = 99999;
    tensorInfo.tensorNum = 5;
    tensorInfo.tensors = tensors;
    
    uint64_t timeStampPush = 3000;
    uint64_t timeStampPop = 4000;
    
    MOCKER(MsprofReportAdditionalInfo)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    
    EXPECT_EQ(PROFILING_SUCCESS, ProfTxPlugin::GetProftxInstance().ReportAdditionalInfo(&tensorInfo, timeStampPush, timeStampPop));
}

TEST_F(PROF_TX_UTTEST, ReportAdditionalInfo_ReportFailed)
{
    aclprofTensor tensor;
    tensor.type = 0;
    tensor.format = 1;
    tensor.dataType = 2;
    tensor.shapeDim = 2;
    tensor.shape[0] = 10;
    tensor.shape[1] = 20;
    
    aclprofTensorInfo tensorInfo;
    tensorInfo.opNameId = 11111;
    tensorInfo.tensorNum = 1;
    tensorInfo.tensors = &tensor;
    
    uint64_t timeStampPush = 100;
    uint64_t timeStampPop = 200;
    
    MOCKER(MsprofReportAdditionalInfo)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    
    EXPECT_EQ(PROFILING_FAILED, ProfTxPlugin::GetProftxInstance().ReportAdditionalInfo(&tensorInfo, timeStampPush, timeStampPop));
}