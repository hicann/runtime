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
#include "aicpu_task_struct.h"
#include "aicpusd_resource_manager.h"
#include "hwts_kernel_model_process.h"
#include "aicpusd_model_execute.h"
#undef private
#include "aicpusd_context.h"
#include "hwts_kernel_stub.h"

using namespace AicpuSchedule;
using namespace aicpu;

class ConfigExtInfoKernelTest : public EventProcessKernelTest {
protected:
    ConfigExtInfoTsKernel kernel_;
};

TEST_F(ConfigExtInfoKernelTest, TsKernelCfgExtInfo_success) {
    aicpu::HwtsTsKernel tsKernelInfo;
    AicpuExtendInfo cfgMsg;
    cfgMsg.msgType = static_cast<uint8_t>(AicpuExtInfoMsgType::EXT_MODEL_ID_MSG_TYPE);
    cfgMsg.modelIdMap.modelId = 0U;
    cfgMsg.modelIdMap.extendModelId = 1U;
    tsKernelInfo.kernelBase.cceKernel.paramBase = (uint64_t)&cfgMsg;
    AicpuModelManager::GetInstance().allModel_[0].isValid = true;
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    AicpuModelManager::GetInstance().allModel_[0].isValid = false;
}

TEST_F(ConfigExtInfoKernelTest, TsKernelCfgExtInfo_failed) {
    aicpu::HwtsTsKernel tsKernelInfo;
    AicpuExtendInfo cfgMsg;
    cfgMsg.modelIdMap.modelId = 0U;
    cfgMsg.modelIdMap.extendModelId = 1U;
    tsKernelInfo.kernelBase.cceKernel.paramBase = 0ULL;
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    cfgMsg.msgType = 1;
    tsKernelInfo.kernelBase.cceKernel.paramBase = (uint64_t)&cfgMsg;
    ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    cfgMsg.msgType = static_cast<uint8_t>(AicpuExtInfoMsgType::EXT_MODEL_ID_MSG_TYPE);
    cfgMsg.modelIdMap.modelId = MAX_MODEL_COUNT + 1;
    ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}