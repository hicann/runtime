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
#include "aicpusd_common.h"
#define private public
#include "aicpusd_model.h"
#include "aicpusd_resource_manager.h"
#include "operator_kernel_model_batch_enqueue.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_stub.h"

using namespace AicpuSchedule;

namespace {
}  // namespace

class OperatorKernelModelBatchEnqueueTest : public OperatorKernelTest {
protected:
    OperatorKernelModelBatchEnqueue kernel_;
};

TEST_F(OperatorKernelModelBatchEnqueueTest, ModelBatchEnque_success) {
    BatchDequeueDesc param = {};
    param.inputNums = 2U;
    char placeHolder0[1500U] = {};
    Mbuf *mbuf0 = reinterpret_cast<Mbuf*>(&placeHolder0[0U]);
    char placeHolder1[1500U] = {};
    Mbuf *mbuf1 = reinterpret_cast<Mbuf*>(&placeHolder1[0U]);
    std::vector<uint64_t> mbufAddrs;
    mbufAddrs.emplace_back(PtrToValue(&mbuf0));
    mbufAddrs.emplace_back(PtrToValue(&mbuf1));
    param.mbufAddrsAddr = PtrToValue(mbufAddrs.data());
    std::vector<uint32_t> queueIds;
    queueIds.emplace_back(0U);
    queueIds.emplace_back(1U);
    param.queueIdsAddr = PtrToValue(queueIds.data());

    AicpuModel aicpuModel;
    aicpuModel.modelId_ = modelId;
    aicpuModel.postpareData_.enqueueIndex = 0U;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&aicpuModel));
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake2));

    AicpuTaskInfo taskT;
    taskT.paraBase = PtrToValue(&param);
    EXPECT_EQ(kernel_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}