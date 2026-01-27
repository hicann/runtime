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
#define private public
#include "aicpusd_model_statistic.h"
#include "aicpusd_model_execute.h"
#undef private

using namespace AicpuSchedule;
using namespace aicpu;
class AicpusdModelStatisticTEST : public testing::Test {
protected:
    static void SetUpTestCase() {
        std::cout << "AicpusdModelStatisticTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase() {
        std::cout << "AicpusdModelStatisticTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "AicpusdModelStatisticTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "AicpusdModelStatisticTEST TearDown" << std::endl;
    }
};

TEST_F(AicpusdModelStatisticTEST, StatModelExeTime) {
    AicpuSdModelStatistic::GetInstance().InitModelStatInfo();
    AicpuSdModelStatistic::GetInstance().MarNNModelStartTime(1U);
    AicpuSdModelStatistic::GetInstance().StatNNModelExecTime(1U);
    EXPECT_EQ(AicpuSdModelStatistic::GetInstance().modelStatArray_[1U].useFlag, true);
}
TEST_F(AicpusdModelStatisticTEST, StatModelExeTimeFaild) {
    AicpuSdModelStatistic::GetInstance().MarNNModelStartTime(MAX_MODEL_COUNT);
    AicpuSdModelStatistic::GetInstance().StatNNModelExecTime(MAX_MODEL_COUNT);
    AicpuSdModelStatistic::GetInstance().modelStatArray_[1U].useFlag = false;
    AicpuSdModelStatistic::GetInstance().StatNNModelExecTime(1U);
    EXPECT_EQ(AicpuSdModelStatistic::GetInstance().modelStatArray_[1U].useFlag, false);
    AicpuSdModelStatistic::GetInstance().modelStatArray_[1U].useFlag = true;
}

TEST_F(AicpusdModelStatisticTEST, StatModelInputAndOutput) {
    std::vector<uint64_t> totalSizeList;
    totalSizeList.push_back(123UL);
    std::vector<ModelConfigTensorDesc> curStatVec;
    ModelConfigTensorDesc curDes;
    curDes.dtype = 0;
    curDes.shape[0] = 2;
    curDes.shape[1] = 2;
    curDes.shape[2] = 2;
    curStatVec.push_back(curDes);
    AicpuSdModelStatistic::GetInstance().StatNNModelInput(1U, totalSizeList, curStatVec);
    totalSizeList.push_back(123UL);
    curStatVec.push_back(curDes);
    AicpuSdModelStatistic::GetInstance().StatNNModelInput(1U, totalSizeList, curStatVec);
    size_t inputSize = AicpuSdModelStatistic::GetInstance().modelStatArray_[1U].inputStatVec.size();
    EXPECT_EQ(inputSize, 2);
    RuntimeTensorDesc  runDesc;
    runDesc.dtype = 0;
    runDesc.shape[0] = 1;
    runDesc.shape[1] = 10;
    RuntimeTensorDesc  runDesc1;
    runDesc1.dtype = 0;
    runDesc1.shape[0] = 1;
    runDesc1.shape[1] = 2;
    RuntimeTensorDesc  runDesc2;
    runDesc2.dtype = 0;
    runDesc2.shape[0] = 1;
    runDesc2.shape[1] = 12;
    AicpuSdModelStatistic::GetInstance().StatNNModelOutput(1U, &runDesc, 1);
    AicpuSdModelStatistic::GetInstance().StatNNModelOutput(1U, &runDesc, 2);
    AicpuSdModelStatistic::GetInstance().StatNNModelOutput(1U, &runDesc, 5);
    AicpuSdModelStatistic::GetInstance().StatNNModelOutput(1U, &runDesc1, 1);
    AicpuSdModelStatistic::GetInstance().StatNNModelOutput(1U, &runDesc2, 1);
    size_t outputSize = AicpuSdModelStatistic::GetInstance().modelStatArray_[1U].outputStatVec.size();
    AicpuSdModelStatistic::GetInstance().PrintOutModelStatInfo();
    const auto model = AicpuModelManager::GetInstance().GetModel(0U);
    if (model != nullptr) {
        model->ResetStaticNNModelOutputIndex();
        model->IncreaseStaticNNModelOutputIndex();
        model->GetCurStaticNNModelOutputIndex();
    }
    
    EXPECT_EQ(outputSize, 5);
}

TEST_F(AicpusdModelStatisticTEST, StatModelInputAndOutputFailed) {
    std::vector<uint64_t> totalSizeList;
    totalSizeList.push_back(123UL);
    std::vector<ModelConfigTensorDesc> curStatVec;
    ModelConfigTensorDesc curDes;
    curDes.dtype = 0;
    curDes.shape[0] = 1;
    curDes.shape[1] = 2;
    curStatVec.push_back(curDes);
    AicpuSdModelStatistic::GetInstance().StatNNModelInput(MAX_MODEL_COUNT, totalSizeList, curStatVec);
    RuntimeTensorDesc  runDesc;
    runDesc.dtype = 0;
    runDesc.shape[0] = 1;
    runDesc.shape[1] = -10;
    AicpuSdModelStatistic::GetInstance().StatNNModelOutput(1U, &runDesc, 1);
    AicpuSdModelStatistic::GetInstance().modelStatArray_[1U].useFlag = false;
    EXPECT_EQ(AicpuSdModelStatistic::GetInstance().modelStatArray_[1U].useFlag, false);
    AicpuSdModelStatistic::GetInstance().modelStatArray_[1U].useFlag = true;
}