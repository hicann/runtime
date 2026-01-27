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
#include "ascend_hal.h"
#define private public
#include "aicpusd_model.h"
#include "aicpusd_resource_manager.h"
#include "aicpusd_event_manager.h"
#include "aicpusd_event_process.h"
#include "aicpusd_drv_manager.h"
#include "hwts_kernel_queue.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "hwts_kernel_stub.h"

using namespace AicpuSchedule;

class CreateQueueKernelTest : public EventProcessKernelTest {
protected:
    CreateQueueTsKernel kernel_;
};

TEST_F(CreateQueueKernelTest, TsKernelCreateQueue_success) {
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(uint64_t) + QUEUE_MAX_STR_LEN + sizeof(uint32_t);
    char args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    char *p = args + sizeof(aicpu::AicpuParamHead);
    uint64_t *qidAddr = (uint64_t *)p;
    uint32_t qid = 1;
    *qidAddr = (uint64_t)&qid;
    p += sizeof(uint64_t);
    memcpy(p, "test_queue", 10);
    p += QUEUE_MAX_STR_LEN;
    uint32_t *qDepth = (uint32_t *)p;
    *qDepth = 8;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(CreateQueueKernelTest, TsKernelCreateQueue_fail0) {
    MOCKER_CPP(&CreateQueueTsKernel::CreateGrp)
        .stubs()
        .will(returnValue(1));
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(uint64_t) + QUEUE_MAX_STR_LEN + sizeof(uint32_t);
    char args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    char *p = args + sizeof(aicpu::AicpuParamHead);
    uint64_t *qidAddr = (uint64_t *)p;
    uint32_t qid = 1;
    *qidAddr = (uint64_t)&qid;
    p += sizeof(uint64_t);
    memcpy(p, "test_queue", 10);
    p += QUEUE_MAX_STR_LEN;
    uint32_t *qDepth = (uint32_t *)p;
    *qDepth = 8;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(CreateQueueKernelTest, TsKernelCreateQueue_fail1) {
    MOCKER_CPP(halQueueInit)
        .stubs()
        .will(returnValue(1));
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    const uint32_t len =  sizeof(aicpu::AicpuParamHead) + sizeof(uint64_t) + QUEUE_MAX_STR_LEN + sizeof(uint32_t);
    char args[len] = {};
    aicpu::AicpuParamHead *paramHead = reinterpret_cast<aicpu::AicpuParamHead *>(args);
    paramHead->length = len;
    char *p = args + sizeof(aicpu::AicpuParamHead);
    uint64_t *qidAddr = (uint64_t *)p;
    uint32_t qid = 1;
    *qidAddr = (uint64_t)&qid;
    p += sizeof(uint64_t);
    memcpy(p, "test_queue", 10);
    p += QUEUE_MAX_STR_LEN;
    uint32_t *qDepth = (uint32_t *)p;
    *qDepth = 8;
    cceKernel.paramBase = (uint64_t)args;
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(CreateQueueKernelTest, Resubscribe_success) {
    int32_t ret = kernel_.Resubscribe(0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(CreateQueueKernelTest, Resubscribe_failed) {
    MOCKER(halQueueUnsubscribe).stubs().will(returnValue(200));
    int32_t ret = kernel_.Resubscribe(0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(CreateQueueKernelTest, Resubscribe_failed2) {
    MOCKER(halQueueSubscribe).stubs().will(returnValue(200));
    int32_t ret = kernel_.Resubscribe(0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(CreateQueueKernelTest, ResubscribeF2NF_success) {
    int32_t ret = kernel_.ResubscribeF2NF(0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(CreateQueueKernelTest, ResubscribeF2NF_failed) {
    MOCKER(halQueueUnsubF2NFEvent).stubs().will(returnValue(200));
    int32_t ret = kernel_.ResubscribeF2NF(0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(CreateQueueKernelTest, ResubscribeF2NF_failed2) {
    MOCKER(halQueueSubF2NFEvent).stubs().will(returnValue(200));
    int32_t ret = kernel_.ResubscribeF2NF(0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(CreateQueueKernelTest, SubscribeEvent_failed) {
    MOCKER(halQueueSubscribe).stubs().will(returnValue(200));
    int32_t ret = kernel_.SubscribeEvent(0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(CreateQueueKernelTest, SubscribeEvent_failed2) {
    MOCKER(halQueueSubscribe).stubs().will(returnValue(DRV_ERROR_QUEUE_RE_SUBSCRIBED));
    MOCKER(halQueueUnsubscribe).stubs().will(returnValue(200));
    int32_t ret = kernel_.SubscribeEvent(0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(CreateQueueKernelTest, SubscribeEvent_failed3) {
    MOCKER(halQueueSubF2NFEvent).stubs().will(returnValue(200));
    int32_t ret = kernel_.SubscribeEvent(0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(CreateQueueKernelTest, SubscribeEvent_failed4) {
    MOCKER(halQueueSubF2NFEvent).stubs().will(returnValue(DRV_ERROR_QUEUE_RE_SUBSCRIBED));
    MOCKER(halQueueUnsubscribe).stubs().will(returnValue(200));
    int32_t ret = kernel_.SubscribeEvent(0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}