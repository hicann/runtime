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
#include "operator_kernel_model_prepare_non_zero_copy_input.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_stub.h"

using namespace AicpuSchedule;

namespace {}  // namespace

class OperatorKernelModelPrepareNonZeroCopyInputTest : public OperatorKernelTest {
protected:
    OperatorKernelModelPrepareNonZeroCopyInput kernel_;
};

TEST_F(OperatorKernelModelPrepareNonZeroCopyInputTest, ModelPrepareNonZeroCopyFusionInput_Success)
{
    uint64_t data1 = 15;
    uint64_t data2 = 51;
    RuntimeTensorDesc srcDesc1;
    srcDesc1.dataAddr = (uint64_t)&data1;
    srcDesc1.dtype = 10;  // DT_UINT64
    srcDesc1.shape[0] = 1;
    srcDesc1.shape[1] = 1;
    srcDesc1.dataSize = sizeof(uint64_t);
    RuntimeTensorDesc srcDesc2;
    srcDesc2.dataAddr = (uint64_t)&data2;
    srcDesc2.dtype = 10;  // DT_UINT64
    srcDesc2.shape[0] = 1;
    srcDesc2.shape[1] = 1;
    srcDesc2.dataSize = sizeof(uint64_t);
    uint64_t dataLen = sizeof(RuntimeTensorDesc) * 2 + sizeof(uint64_t) * 2;
    char tmpBuf1[mbufDataOffSet + dataLen] = {0};
    memcpy_s(ValueToPtr(PtrToValue(&tmpBuf1) + mbufDataOffSet),
        sizeof(RuntimeTensorDesc),
        (void *)&srcDesc1,
        sizeof(RuntimeTensorDesc));
    memcpy_s(ValueToPtr(PtrToValue(&tmpBuf1) + mbufDataOffSet + sizeof(RuntimeTensorDesc)),
        sizeof(uint64_t),
        (void *)&data1,
        sizeof(uint64_t));
    memcpy_s(ValueToPtr(PtrToValue(&tmpBuf1) + mbufDataOffSet + sizeof(RuntimeTensorDesc) + sizeof(uint64_t)),
        sizeof(RuntimeTensorDesc),
        (void *)&srcDesc2,
        sizeof(RuntimeTensorDesc));
    memcpy_s(ValueToPtr(PtrToValue(&tmpBuf1) + mbufDataOffSet + sizeof(RuntimeTensorDesc) * 2 + sizeof(uint64_t)),
        sizeof(uint64_t),
        (void *)&data2,
        sizeof(uint64_t));

    Mbuf *srcData1 = (Mbuf *)tmpBuf1;
    uint64_t srcAddrList[2] = {PtrToValue(&srcData1), PtrToValue(&srcData1)};
    uint64_t dstData1 = 0UL;
    uint64_t dstData2 = 0UL;
    uint64_t dstAddrList[2] = {PtrToValue(&dstData1), PtrToValue(&dstData2)};
    uint64_t dstAddrLenList[2] = {sizeof(dstData1), sizeof(dstData2)};
    int32_t input_fusion_offsets[2] = {0, 1};

    InputCopyAddrMapInfo mapInfo = {0U};
    mapInfo.addrNum = 2;
    mapInfo.srcAddrList = PtrToValue(&srcAddrList);
    mapInfo.dstAddrList = PtrToValue(&dstAddrList);
    mapInfo.dstAddrLenList = PtrToValue(&dstAddrLenList);
    mapInfo.srcFusionOffsetList = PtrToValue(&input_fusion_offsets);
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = PtrToValue(&mapInfo);
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetBuffSize)
        .stubs()
        .with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    MOCKER(halMbufGetDataLen)
        .stubs()
        .with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(dstData1, data1);
    EXPECT_EQ(dstData2, data2);
}

TEST_F(OperatorKernelModelPrepareNonZeroCopyInputTest, ModelPrepareNonZeroCopyInput_Success)
{
    uint64_t data1 = 15;
    uint64_t data2 = 51;
    char tmpBuf1[mbufDataOffSet + sizeof(RuntimeTensorDesc) + sizeof(uint64_t)] = {0};
    char tmpBuf2[mbufDataOffSet + sizeof(RuntimeTensorDesc) + sizeof(uint64_t)] = {0};
    auto eret = memcpy_s(ValueToPtr(PtrToValue(&tmpBuf1) + mbufDataOffSet + sizeof(RuntimeTensorDesc)),
        sizeof(uint64_t),
        (void *)&data1,
        sizeof(uint64_t));
    eret = memcpy_s(ValueToPtr(PtrToValue(&tmpBuf2) + mbufDataOffSet + sizeof(RuntimeTensorDesc)),
        sizeof(uint64_t),
        (void *)&data2,
        sizeof(uint64_t));

    Mbuf *srcData1 = (Mbuf *)tmpBuf1;
    Mbuf *srcData2 = (Mbuf *)tmpBuf2;
    uint64_t srcAddrList[2] = {PtrToValue(&srcData1), PtrToValue(&srcData2)};
    uint64_t dstData1 = 0UL;
    uint64_t dstData2 = 0UL;
    uint64_t dstAddrList[2] = {PtrToValue(&dstData1), PtrToValue(&dstData2)};
    uint64_t dstAddrLenList[2] = {sizeof(dstData1), sizeof(dstData2)};

    InputCopyAddrMapInfo mapInfo = {0U};
    mapInfo.addrNum = 2;
    mapInfo.srcAddrList = PtrToValue(&srcAddrList);
    mapInfo.dstAddrList = PtrToValue(&dstAddrList);
    mapInfo.dstAddrLenList = PtrToValue(&dstAddrLenList);
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = PtrToValue(&mapInfo);
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetDataLen).stubs().will(invoke(halMbufGetDataLenFake));
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(dstData1, data1);
    EXPECT_EQ(dstData2, data2);
}

TEST_F(OperatorKernelModelPrepareNonZeroCopyInputTest, ModelPrepareNonZeroCopyInput_Fail1)
{
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = 0;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelModelPrepareNonZeroCopyInputTest, ModelPrepareNonZeroCopyInput_Fail2)
{
    uint64_t srcAddrList[2] = {0, 0};
    uint64_t dstData1 = 0UL;
    uint64_t dstData2 = 0UL;
    uint64_t dstAddrList[2] = {PtrToValue(&dstData1), PtrToValue(&dstData2)};
    uint64_t dstAddrLenList[2] = {sizeof(dstData1), sizeof(dstData2)};

    InputCopyAddrMapInfo mapInfo = {0U};
    mapInfo.addrNum = 2;
    mapInfo.srcAddrList = 0;
    mapInfo.dstAddrList = PtrToValue(&dstAddrList);
    mapInfo.dstAddrLenList = PtrToValue(&dstAddrLenList);
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = PtrToValue(&mapInfo);
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(OperatorKernelModelPrepareNonZeroCopyInputTest, ModelPrepareNonZeroCopyInput_Fail3)
{
    uint64_t srcAddrList[2] = {0, 0};
    uint64_t dstData1 = 0UL;
    uint64_t dstData2 = 0UL;
    uint64_t dstAddrList[2] = {PtrToValue(&dstData1), PtrToValue(&dstData2)};
    uint64_t dstAddrLenList[2] = {sizeof(dstData1), sizeof(dstData2)};

    InputCopyAddrMapInfo mapInfo = {0U};
    mapInfo.addrNum = 2;
    mapInfo.srcAddrList = PtrToValue(&srcAddrList);
    mapInfo.dstAddrList = PtrToValue(&dstAddrList);
    mapInfo.dstAddrLenList = PtrToValue(&dstAddrLenList);
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = PtrToValue(&mapInfo);
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}