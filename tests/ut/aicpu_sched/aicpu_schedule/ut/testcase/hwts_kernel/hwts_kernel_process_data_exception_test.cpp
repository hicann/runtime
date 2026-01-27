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
#include "aicpusd_model.h"
#include "hwts_kernel_model_process.h"
#include "aicpusd_interface_process.h"
#include "aicpusd_model_execute.h"
#undef private
#include "aicpusd_context.h"
#include "hwts_kernel_stub.h"

using namespace AicpuSchedule;

class ProcessDataExceptionKernelTest : public EventProcessKernelTest {
protected:
    ProcessDataExceptionTsKernel kernel_;
};

TEST_F(ProcessDataExceptionKernelTest, TsKernelProcessDataException_success) {
    DataFlowExceptionNotify notify = {};
    notify.modelIdNum = 2U;
    std::vector<uint32_t> modelIds = {0U, 1U};
    notify.modelIdsAddr = PtrToValue(modelIds.data());

    AicpuModel aicpuModel0;
    aicpuModel0.modelId_ = 0U;
    AicpuModel aicpuModel1;
    aicpuModel1.modelId_ = 0U;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs()
        .will(returnValue(&aicpuModel0))
        .then(returnValue(&aicpuModel1));

    aicpu::HwtsTsKernel tskenrel = {};
    tskenrel.kernelBase.cceKernel.paramBase = PtrToValue(&notify);
    EXPECT_EQ(kernel_.Compute(tskenrel), AICPU_SCHEDULE_OK);
}