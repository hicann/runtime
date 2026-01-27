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
#include "aicpusd_model.h"
#undef private
#include "aicpusd_model_execute.h"
#include "operator_kernel_common.h"
#include "operator_kernel_stub.h"

using namespace AicpuSchedule;


class OperatorKernelCommonTest : public OperatorKernelTest {
};

TEST_F(OperatorKernelCommonTest, SendAICPUSubEvent_failed1)
{
    char *msg1 = nullptr;
    unsigned int msgLen = 1;
    unsigned int subevent_id = 1;

    int ret = OperatorKernelCommon::SendAICPUSubEvent(msg1, msgLen, subevent_id);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INVAILD_EVENT_SUBMIT);

    char *msg2 = "aa";
    msgLen = 0;
    subevent_id = 1;

    ret = OperatorKernelCommon::SendAICPUSubEvent(msg2, msgLen, subevent_id);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INVAILD_EVENT_SUBMIT);

    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(100));
}

TEST_F(OperatorKernelCommonTest, TraceQueueData_failed)
{
    MOCKER(CheckLogLevel).stubs().will(returnValue(1));
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    g_curHead.aicpuBufhead.transId = 5;
    g_curHead.aicpuBufhead.routeLabel = 2;
    g_curHead.aicpuBufhead.retCode = 1;
    void *priv = reinterpret_cast<void*>(&g_curHead);
    int32_t size = 256;
    OperatorKernelCommon::TraceQueueData(runContextT, priv, size, "Dequeued");
    EXPECT_EQ(g_curHead.aicpuBufhead.transId, 5);
}

TEST_F(OperatorKernelCommonTest, TraceQueueDataSuccess)
{
    BUILD_SUCC_PREPARE_INFO();
    MOCKER(CheckLogLevel).stubs().will(returnValue(1));
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(aicpuModel));
    g_curHead.aicpuBufhead.transId = 5;
    g_curHead.aicpuBufhead.routeLabel = 2;
    g_curHead.aicpuBufhead.retCode = 1;
    void *priv = reinterpret_cast<void*>(&g_curHead);
    int32_t size = 256;
    OperatorKernelCommon::TraceQueueData(runContextT, priv, size, "Dequeued");
    EXPECT_EQ(g_curHead.aicpuBufhead.transId, 5);
}

TEST_F(OperatorKernelCommonTest, Model_CopyMbufHeadInfo_Succ)
{
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));

    char src[mbufHeadSize] = {0};
    char dest[mbufHeadSize] = {0};
    void *srcHeaderBuf = (void *)src;
    uint32_t srcHeadSize = mbufHeadSize;
    void *destMbuf = (void *)dest;

    int ret = OperatorKernelCommon::CopyMbufHeadInfo(srcHeaderBuf, srcHeadSize, (Mbuf *)destMbuf);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelCommonTest, Model_CopyMbufHeadInfo_Error)
{
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));

    char src[mbufHeadSize] = {0};
    char dest[mbufHeadSize] = {0};
    // error
    void *srcHeaderBuf = nullptr;
    uint32_t srcHeadSize = mbufHeadSize;
    void *destMbuf = (void *)dest;

    int ret = OperatorKernelCommon::CopyMbufHeadInfo(srcHeaderBuf, srcHeadSize, (Mbuf *)destMbuf);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(OperatorKernelCommonTest, Model_CopyMbufHeadInfo_Error1)
{
    MOCKER(halMbufGetPrivInfo).stubs().will(invoke(halMbufGetPrivInfoFake));

    char src[mbufHeadSize] = {0};
    char dest[mbufHeadSize] = {0};
    void *srcHeaderBuf = (void *)src;
    uint32_t srcHeadSize = mbufHeadSize;
    // error
    void *destMbuf = nullptr;

    int ret = OperatorKernelCommon::CopyMbufHeadInfo(srcHeaderBuf, srcHeadSize, (Mbuf *)destMbuf);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(OperatorKernelCommonTest, Model_CopyMbufHeadInfo_Error2)
{
    // error
    MOCKER(halMbufGetPrivInfo).stubs().will(returnValue(1));

    char src[mbufHeadSize] = {0};
    char dest[mbufHeadSize] = {0};
    void *srcHeaderBuf = (void *)src;
    uint32_t srcHeadSize = mbufHeadSize;
    void *destMbuf = (void *)dest;

    int ret = OperatorKernelCommon::CopyMbufHeadInfo(srcHeaderBuf, srcHeadSize, (Mbuf *)destMbuf);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(OperatorKernelCommonTest, Model_CopyMbufHeadInfo_Error3)
{
    // error
    MOCKER(halMbufGetPrivInfo).stubs().will(returnValue(0));

    char src[mbufHeadSize] = {0};
    char dest[mbufHeadSize] = {0};
    void *srcHeaderBuf = (void *)src;
    uint32_t srcHeadSize = mbufHeadSize;
    void *destMbuf = (void *)dest;

    int ret = OperatorKernelCommon::CopyMbufHeadInfo(srcHeaderBuf, srcHeadSize, (Mbuf *)destMbuf);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_MALLOC_MEM_FAIL_THROUGH_DRV);
}

TEST_F(OperatorKernelCommonTest, UpdateDataPtr_FAIL)
{
    void *dataPtr = nullptr;
    uint64_t totalOffset = 20U;
    uint64_t dataSize = 10UL;
    MOCKER_CPP(&OperatorKernelCommon::GetMbufDataSize)
        .stubs()
        .with(mockcpp::any(), outBound(dataSize))
        .will(returnValue(AICPU_SCHEDULE_ERROR_FROM_DRV))
        .then(returnValue(AICPU_SCHEDULE_OK));
    // fail for GetMbufDataSize
    EXPECT_EQ(OperatorKernelCommon::UpdateDataPtr(0U, 1, dataPtr, totalOffset), AICPU_SCHEDULE_ERROR_FROM_DRV);
    // fail for dataSize invalid
    EXPECT_EQ(OperatorKernelCommon::UpdateDataPtr(0U, 1, dataPtr, totalOffset),
        AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelCommonTest, DoUpdateDataPtr_FAIL_InvalidOffset)
{
    void *dataPtr = nullptr;
    int32_t lastFusionOffset = 2;
    uint64_t lastDataOffset = 20U;
    FusionInfo info = {};
    info.dataSize = 1025U;
    info.lastFusionOffset = 2;
    info.lastDataOffset = 20U;
    EXPECT_EQ(OperatorKernelCommon::DoUpdateDataPtr(info, 1, dataPtr), AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}
