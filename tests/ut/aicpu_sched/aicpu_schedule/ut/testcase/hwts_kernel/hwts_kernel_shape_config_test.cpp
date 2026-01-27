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

class ShapeConfigKernelTest : public EventProcessKernelTest {
protected:
    ShapeConfigTsKernel kernel_;
};

TEST_F(ShapeConfigKernelTest, TsKernelModelConfigHasShape_success01) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    uint8_t data[36] = {
        -24, 3, 0, 0, 16, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, -23, 3, 0, 0, 4, 0, 0, 0, 1, 0, 0, 0};
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuModelShapeConfig);
    uint8_t args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    AicpuModelShapeConfig *cfg =
        reinterpret_cast<AicpuModelShapeConfig *>(reinterpret_cast<uint8_t *>(args) + sizeof(aicpu::AicpuParamHead));
    cfg->geModelId = 1;
    cfg->runtimeModelId = 0;
    cfg->tensortlvLen = 36;
    cfg->tlvDataAddr = (uint64_t)data;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(ShapeConfigKernelTest, TsKernelModelConfigHasShape_success02) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    uint8_t data[56] = {-24, 3, 0, 0, 8, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, -23, 3, 0, 0, 4, 0, 0, 0, 3, 0, 0, 0,
        -24, 3, 0, 0, 8, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, -23, 3, 0, 0, 4, 0, 0, 0, 3, 0, 0, 0};
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuModelShapeConfig);
    uint8_t args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    AicpuModelShapeConfig *cfg =
        reinterpret_cast<AicpuModelShapeConfig *>(reinterpret_cast<uint8_t *>(args) + sizeof(aicpu::AicpuParamHead));
    cfg->geModelId = 1;
    cfg->runtimeModelId = 0;
    cfg->tensortlvLen = 56;
    cfg->tlvDataAddr = (uint64_t)data;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(ShapeConfigKernelTest, TsKernelModelConfigHasShape_failed01) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    uint8_t data[36] = {
        -24, 3, 0, 0, 16, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, -23, 3, 0, 0, 4, 0, 0, 0, 1, 0, 0, 0};
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuModelShapeConfig);
    uint8_t args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    AicpuModelShapeConfig *cfg =
        reinterpret_cast<AicpuModelShapeConfig *>(reinterpret_cast<uint8_t *>(args) + sizeof(aicpu::AicpuParamHead));
    cfg->geModelId = 1;
    cfg->runtimeModelId = 0;
    cfg->tensortlvLen = 35;
    cfg->tlvDataAddr = (uint64_t)data;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(ShapeConfigKernelTest, TsKernelModelConfigHasShape_failed02) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    uint8_t data[36] = {
        1, 0, 0, 0, 16, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 4, 0, 0, 0, 1, 0, 0, 0};
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuModelShapeConfig);
    uint8_t args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    AicpuModelShapeConfig *cfg =
        reinterpret_cast<AicpuModelShapeConfig *>(reinterpret_cast<uint8_t *>(args) + sizeof(aicpu::AicpuParamHead));
    cfg->geModelId = 1;
    cfg->runtimeModelId = 0;
    cfg->tensortlvLen = 36;
    cfg->tlvDataAddr = (uint64_t)data;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(ShapeConfigKernelTest, TsKernelModelConfigHasShape_failed03) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    uint8_t data[36] = {
        -24, 3, 0, 0, 16, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 1, 0, 0, 0};
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuModelShapeConfig);
    uint8_t args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    AicpuModelShapeConfig *cfg =
        reinterpret_cast<AicpuModelShapeConfig *>(reinterpret_cast<uint8_t *>(args) + sizeof(aicpu::AicpuParamHead));
    cfg->geModelId = 1;
    cfg->runtimeModelId = 0;
    cfg->tensortlvLen = 36;
    cfg->tlvDataAddr = (uint64_t)data;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(ShapeConfigKernelTest, TsKernelModelConfigHasShape_failed04) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    uint8_t data[36] = {
        -24, 3, 0, 0, 16, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, -23, 3, 0, 0, 4, 0, 0, 0, 1, 0, 0, 0};
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(AicpuModelShapeConfig);
    uint8_t args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len - 1;
    AicpuModelShapeConfig *cfg =
        reinterpret_cast<AicpuModelShapeConfig *>(reinterpret_cast<uint8_t *>(args) + sizeof(aicpu::AicpuParamHead));
    cfg->geModelId = 1;
    cfg->runtimeModelId = 0;
    cfg->tensortlvLen = 35;
    cfg->tlvDataAddr = (uint64_t)data;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}