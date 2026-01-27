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
#include "operator_kernel_zero_cpy.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "operator_kernel_common.h"
#include "operator_kernel_stub.h"

using namespace AicpuSchedule;

class OperatorKernelZeroCpyTest : public OperatorKernelTest {
protected:
    OperatorKernelZeroCpy kernel_;
    OperatorKernelCpuZeroCpy kernelCpu_;
    OperatorKernelZeroCpyV2 kernelV2_;
};

TEST_F(OperatorKernelZeroCpyTest, ModelZeroCpy_Success)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    uint64_t srcVal = 1;
    uint64_t dstVal = 1;
    Mbuf *srcMbuf = (Mbuf *)&srcVal;
    Mbuf *dstMbuf = (Mbuf *)&dstVal;
    AddrMapInfo addrMapInfo;
    addrMapInfo.addrNum = 1;
    addrMapInfo.srcAddrList = (uint64_t)&srcMbuf;
    addrMapInfo.dstAddrList = (uint64_t)&dstMbuf;
    taskT.paraBase = (uint64_t)&addrMapInfo;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelZeroCpyTest, ModelZeroCpy_Failed)
{
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    uint64_t *srcVal = nullptr;
    uint64_t *dstVal = nullptr;
    AddrMapInfo addrMapInfo;
    addrMapInfo.addrNum = 1;
    addrMapInfo.srcAddrList = (uint64_t)srcVal;
    addrMapInfo.dstAddrList = (uint64_t)dstVal;
    taskT.paraBase = (uint64_t)&addrMapInfo;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(OperatorKernelZeroCpyTest, ModelZeroCpy_Failed2)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));

    AicpuTaskInfo taskT;
    taskT.taskID = 1;

    std::vector<uint64_t> srcAddrList;
    std::vector<uint64_t> dstAddrList;
    srcAddrList.push_back(0);
    dstAddrList.push_back(0);
    AddrMapInfo addrMapInfo;
    addrMapInfo.addrNum = 1;
    addrMapInfo.srcAddrList = (uint64_t)&srcAddrList;
    addrMapInfo.dstAddrList = (uint64_t)&dstAddrList;
    taskT.paraBase = (uint64_t)&addrMapInfo;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelZeroCpyTest, ModelZeroCpy_Failed3)
{
    MOCKER(halMbufGetBuffAddr).stubs().will(returnValue(200));

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    uint64_t srcVal = 1;
    uint64_t dstVal = 1;
    Mbuf *srcMbuf = (Mbuf *)&srcVal;
    Mbuf *dstMbuf = (Mbuf *)&dstVal;
    AddrMapInfo addrMapInfo;
    addrMapInfo.addrNum = 1;
    addrMapInfo.srcAddrList = (uint64_t)&srcMbuf;
    addrMapInfo.dstAddrList = (uint64_t)&dstMbuf;
    taskT.paraBase = (uint64_t)&addrMapInfo;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelZeroCpyTest, ModelZeroCpy_failed4)
{
    TsAicpuNotify *aicpuNotify = nullptr;

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t)aicpuNotify;
    int ret = kernel_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelZeroCpyTest, ModelZeroCpyV2_Success)
{
    RuntimeTensorDesc desc;
    auto descP = &desc;
    MOCKER(halMbufGetBuffAddr).stubs().with(mockcpp::any(), outBoundP(((void **)&descP), sizeof(void **))).will(returnValue(0));

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    uint64_t srcVal = 1;
    uint64_t dstVal = 1;
    int32_t noTilingVal = 1;
    Mbuf *srcMbuf = (Mbuf *)&srcVal;
    Mbuf *dstMbuf = (Mbuf *)&dstVal;
    AddrMapInfoV2 addrMapInfo;
    addrMapInfo.addrNum = 1;
    addrMapInfo.srcAddrList = (uint64_t)&srcMbuf;
    addrMapInfo.dstAddrList = (uint64_t)&dstMbuf;
    addrMapInfo.isNoTilingList = (uint64_t)&noTilingVal;
    addrMapInfo.len = 0;
    taskT.paraBase = (uint64_t)&addrMapInfo;
    int ret = kernelV2_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelZeroCpyTest, ModelZeroCpyV2_Success01)
{
    RuntimeTensorDesc desc;
    auto descP = &desc;
    MOCKER(halMbufGetBuffAddr).stubs().with(mockcpp::any(), outBoundP(((void **)&descP), sizeof(void **))).will(returnValue(0));

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    uint64_t srcVal = 1;
    uint64_t dstVal = 1;
    int32_t noTilingVal = 0;
    Mbuf *srcMbuf = (Mbuf *)&srcVal;
    Mbuf *dstMbuf = (Mbuf *)&dstVal;
    uint8_t buff[sizeof(AddrMapInfoV2) + sizeof(uint32_t)] = {0};
    AddrMapInfoV2 *addrMapInfo = (AddrMapInfoV2 *)buff;
    addrMapInfo->addrNum = 1;
    addrMapInfo->srcAddrList = (uint64_t)&srcMbuf;
    addrMapInfo->dstAddrList = (uint64_t)&dstMbuf;
    addrMapInfo->isNoTilingList = (uint64_t)&noTilingVal;
    addrMapInfo->len = sizeof(uint32_t);
    uint32_t *skipSize = (uint32_t *)addrMapInfo->extendInfo;
    *skipSize = 1024;
    taskT.paraBase = (uint64_t)buff;
    int ret = kernelV2_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelZeroCpyTest, ModelZeroCpyV2_Success02)
{
    RuntimeTensorDesc desc;
    auto descP = &desc;
    MOCKER(halMbufGetBuffAddr).stubs().with(mockcpp::any(), outBoundP(((void **)&descP), sizeof(void **))).will(returnValue(0));

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    uint64_t srcVal = 1;
    uint64_t dstVal = 1;
    int32_t noTilingVal = 1;
    Mbuf *srcMbuf = (Mbuf *)&srcVal;
    Mbuf *dstMbuf = (Mbuf *)&dstVal;
    uint8_t buff[sizeof(AddrMapInfoV2) + sizeof(uint32_t) + sizeof(uint64_t)] = {0};
    AddrMapInfoV2 *addrMapInfo = (AddrMapInfoV2 *)buff;
    addrMapInfo->addrNum = 1;
    addrMapInfo->srcAddrList = (uint64_t)&srcMbuf;
    addrMapInfo->dstAddrList = (uint64_t)&dstMbuf;
    addrMapInfo->isNoTilingList = (uint64_t)&noTilingVal;
    addrMapInfo->len = sizeof(uint32_t) + sizeof(uint64_t);
    uint32_t *skipSize = (uint32_t *)addrMapInfo->extendInfo;
    *skipSize = 1024;
    uint64_t *const dest_is_tiling_list = (uint64_t *)(&addrMapInfo->extendInfo[0] + sizeof(uint32_t));
    int32_t tiling_flag[10] = {1, 1, 1};
    *dest_is_tiling_list = (uint64_t)(tiling_flag);
    taskT.paraBase = (uint64_t)buff;
    int ret = kernelV2_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelZeroCpyTest, ModelZeroCpyV2_Success03)
{
    // BUFF = tensordesc1 + 512 + tensordesc2 + 512
    size_t buff_size = 2 * sizeof(RuntimeTensorDesc) + 512 * 2;
    std::vector<int8_t> tensor_buff(buff_size);
    auto desc1 = (RuntimeTensorDesc *)(&tensor_buff[0]);
    desc1->dataSize = 512;
    auto desc2 = (RuntimeTensorDesc *)(&tensor_buff[sizeof(RuntimeTensorDesc) + 512]);
    desc2->dataSize = 512;
    auto buffP = &tensor_buff[0];
    MOCKER(halMbufGetBuffAddr).stubs().with(mockcpp::any(), outBoundP(((void **)&buffP), sizeof(void **))).will(returnValue(0));

    uint64_t dataLen = buff_size;
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen)).will(returnValue(0));

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    uint64_t srcVal = 1;
    uint64_t dstVal = 1;
    int32_t noTilingVal = 1;
    Mbuf *srcMbuf = (Mbuf *)&srcVal;
    Mbuf *dstMbuf = (Mbuf *)&dstVal;
    uint8_t buff[sizeof(AddrMapInfoV2) + sizeof(uint32_t) + sizeof(uint64_t) + sizeof(uint64_t)] = {0};
    AddrMapInfoV2 *addrMapInfo = (AddrMapInfoV2 *)buff;
    addrMapInfo->addrNum = 1;
    addrMapInfo->srcAddrList = (uint64_t)&srcMbuf;
    addrMapInfo->dstAddrList = (uint64_t)&dstMbuf;
    addrMapInfo->isNoTilingList = (uint64_t)&noTilingVal;
    addrMapInfo->len = sizeof(uint32_t) + sizeof(uint64_t) + sizeof(uint64_t);
    uint32_t *skipSize = (uint32_t *)addrMapInfo->extendInfo;
    *skipSize = 1024;
    uint64_t *const dest_is_tiling_list = (uint64_t *)(&addrMapInfo->extendInfo[0] + sizeof(uint32_t));
    int32_t tiling_flag[10] = {1, 1, 1};
    *dest_is_tiling_list = (uint64_t)(tiling_flag);
    uint64_t *const fusion_offset_list =
        (uint64_t *)(&addrMapInfo->extendInfo[0] + sizeof(uint32_t) + sizeof(uint64_t));
    int32_t fusion_offsets[1] = {1};
    *fusion_offset_list = (uint64_t)(fusion_offsets);
    taskT.paraBase = (uint64_t)buff;
    int ret = kernelV2_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelZeroCpyTest, ModelZeroCpyV2_Failed)
{
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    taskT.paraBase = (uint64_t) nullptr;
    int ret = kernelV2_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelZeroCpyTest, ModelZeroCpyV2_FusionNull)
{
    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    uint64_t srcVal = 1;
    uint64_t dstVal = 1;
    int32_t noTilingVal = 1;
    Mbuf *srcMbuf = (Mbuf *)&srcVal;
    Mbuf *dstMbuf = (Mbuf *)&dstVal;
    uint8_t buff[sizeof(AddrMapInfoV2) + sizeof(uint32_t) + sizeof(uint64_t) + sizeof(uint64_t)] = {0};
    AddrMapInfoV2 *addrMapInfo = (AddrMapInfoV2 *)buff;
    addrMapInfo->addrNum = 1;
    addrMapInfo->srcAddrList = (uint64_t)&srcMbuf;
    addrMapInfo->dstAddrList = (uint64_t)&dstMbuf;
    addrMapInfo->isNoTilingList = (uint64_t)&noTilingVal;
    addrMapInfo->len = sizeof(uint32_t) + sizeof(uint64_t) + sizeof(uint64_t);
    uint32_t *skipSize = (uint32_t *)addrMapInfo->extendInfo;
    *skipSize = 1024;
    uint64_t *const dest_is_tiling_list = (uint64_t *)(&addrMapInfo->extendInfo[0] + sizeof(uint32_t));
    int32_t tiling_flag[10] = {1, 1, 1};
    *dest_is_tiling_list = (uint64_t)(tiling_flag);
    uint64_t *const fusion_offset_list =
        (uint64_t *)(&addrMapInfo->extendInfo[0] + sizeof(uint32_t) + sizeof(uint64_t));
    *fusion_offset_list = 0UL;
    taskT.paraBase = (uint64_t)buff;
    int ret = kernelV2_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    int32_t *fusion_offsets = nullptr;
    *fusion_offset_list = (uint64_t)(fusion_offsets);
    ret = kernelV2_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelZeroCpyTest, ModelZeroCpyV2_FusionSizeInvalid)
{
    // BUFF = tensordesc1 + 512 + tensordesc2 + 512
    size_t buff_size = 2 * sizeof(RuntimeTensorDesc) + 512 * 2;
    std::vector<int8_t> tensor_buff(buff_size);
    auto desc1 = (RuntimeTensorDesc *)(&tensor_buff[0]);
    desc1->dataSize = 512;
    auto desc2 = (RuntimeTensorDesc *)(&tensor_buff[sizeof(RuntimeTensorDesc) + 512]);
    desc2->dataSize = 512;
    auto buffP = &tensor_buff[0];
    MOCKER(halMbufGetBuffAddr).stubs().with(mockcpp::any(), outBoundP(((void **)&buffP), sizeof(void **))).will(returnValue(0));

    uint64_t dataLen = 1;  // invalid size
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen)).will(returnValue(0));

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    uint64_t srcVal = 1;
    uint64_t dstVal = 1;
    int32_t noTilingVal = 1;
    Mbuf *srcMbuf = (Mbuf *)&srcVal;
    Mbuf *dstMbuf = (Mbuf *)&dstVal;
    uint8_t buff[sizeof(AddrMapInfoV2) + sizeof(uint32_t) + sizeof(uint64_t) + sizeof(uint64_t)] = {0};
    AddrMapInfoV2 *addrMapInfo = (AddrMapInfoV2 *)buff;
    addrMapInfo->addrNum = 1;
    addrMapInfo->srcAddrList = (uint64_t)&srcMbuf;
    addrMapInfo->dstAddrList = (uint64_t)&dstMbuf;
    addrMapInfo->isNoTilingList = (uint64_t)&noTilingVal;
    addrMapInfo->len = sizeof(uint32_t) + sizeof(uint64_t) + sizeof(uint64_t);
    uint32_t *skipSize = (uint32_t *)addrMapInfo->extendInfo;
    *skipSize = 1024;
    uint64_t *const dest_is_tiling_list = (uint64_t *)(&addrMapInfo->extendInfo[0] + sizeof(uint32_t));
    int32_t tiling_flag[10] = {1, 1, 1};
    *dest_is_tiling_list = (uint64_t)(tiling_flag);
    uint64_t *const fusion_offset_list =
        (uint64_t *)(&addrMapInfo->extendInfo[0] + sizeof(uint32_t) + sizeof(uint64_t));
    int32_t fusion_offsets[1] = {1};
    *fusion_offset_list = (uint64_t)(fusion_offsets);
    taskT.paraBase = (uint64_t)buff;
    int ret = kernelV2_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);

    uint64_t dataLen2 = sizeof(RuntimeTensorDesc) + 128;  // invalid size
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen2)).will(returnValue(0));
    ret = kernelV2_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);

    uint64_t dataLen3 = sizeof(RuntimeTensorDesc) + 512;  // invalid size
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen3)).will(returnValue(0));
    ret = kernelV2_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(OperatorKernelZeroCpyTest, ModelZeroCpyV2_GetDataSizeFailed)
{
    // BUFF = tensordesc1 + 512 + tensordesc2 + 512
    size_t buff_size = 2 * sizeof(RuntimeTensorDesc) + 512 * 2;
    std::vector<int8_t> tensor_buff(buff_size);
    auto desc1 = (RuntimeTensorDesc *)(&tensor_buff[0]);
    desc1->dataSize = 512;
    auto desc2 = (RuntimeTensorDesc *)(&tensor_buff[sizeof(RuntimeTensorDesc) + 512]);
    desc2->dataSize = 512;
    auto buffP = &tensor_buff[0];
    MOCKER(halMbufGetBuffAddr).stubs().with(mockcpp::any(), outBoundP(((void **)&buffP), sizeof(void **))).will(returnValue(0));

    uint64_t dataLen = buff_size;
    MOCKER(halMbufGetBuffSize).stubs().with(mockcpp::any(), outBoundP(&dataLen)).will(returnValue(1));

    AicpuTaskInfo taskT;
    taskT.taskID = 1;
    uint64_t srcVal = 1;
    uint64_t dstVal = 1;
    int32_t noTilingVal = 1;
    Mbuf *srcMbuf = (Mbuf *)&srcVal;
    Mbuf *dstMbuf = (Mbuf *)&dstVal;
    uint8_t buff[sizeof(AddrMapInfoV2) + sizeof(uint32_t) + sizeof(uint64_t) + sizeof(uint64_t)] = {0};
    AddrMapInfoV2 *addrMapInfo = (AddrMapInfoV2 *)buff;
    addrMapInfo->addrNum = 1;
    addrMapInfo->srcAddrList = (uint64_t)&srcMbuf;
    addrMapInfo->dstAddrList = (uint64_t)&dstMbuf;
    addrMapInfo->isNoTilingList = (uint64_t)&noTilingVal;
    addrMapInfo->len = sizeof(uint32_t) + sizeof(uint64_t) + sizeof(uint64_t);
    uint32_t *skipSize = (uint32_t *)addrMapInfo->extendInfo;
    *skipSize = 1024;
    uint64_t *const dest_is_tiling_list = (uint64_t *)(&addrMapInfo->extendInfo[0] + sizeof(uint32_t));
    int32_t tiling_flag[10] = {1, 1, 1};
    *dest_is_tiling_list = (uint64_t)(tiling_flag);
    uint64_t *const fusion_offset_list =
        (uint64_t *)(&addrMapInfo->extendInfo[0] + sizeof(uint32_t) + sizeof(uint64_t));
    int32_t fusion_offsets[1] = {1};
    *fusion_offset_list = (uint64_t)(fusion_offsets);
    taskT.paraBase = (uint64_t)buff;
    int ret = kernelV2_.Compute(taskT, runContextT);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_FROM_DRV);
}

TEST_F(OperatorKernelZeroCpyTest, UpdateDataPtrExtendForUnorderFusionOffset)
{
    std::unordered_map<uint64_t, FusionInfo> fusionMap;
    FusionInfo info = {};
    info.lastFusionOffset = 10;
    info.lastDataOffset = 100U;
    fusionMap[0U] = info;

    void *dataPtr = nullptr;
    MOCKER_CPP(&OperatorKernelCommon::DoUpdateDataPtr).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    EXPECT_EQ(kernelV2_.UpdateDataPtrExtend(0U, 2, dataPtr, fusionMap), AICPU_SCHEDULE_OK);
    EXPECT_EQ(fusionMap[0U].lastFusionOffset, 0);
    EXPECT_EQ(fusionMap[0U].lastDataOffset, 0U);
}

TEST_F(OperatorKernelZeroCpyTest, ModelZeroCpyCpu_Success)
{
    AddrMapInfo mapInfo = {};
    void *src1 = nullptr;
    void *src2 = nullptr;
    uint64_t srcAddrList[] = {PtrToValue(&src1), PtrToValue(&src2)};
    void *dst1 = nullptr;
    void *dst2 = nullptr;
    uint64_t dstAddrList[] = {PtrToValue(&dst1), PtrToValue(&dst2)};
    mapInfo.srcAddrList = PtrToValue(&srcAddrList[0U]);
    mapInfo.dstAddrList = PtrToValue(&dstAddrList[0U]);
    mapInfo.addrNum = 2U;

    AicpuTaskInfo taskT;
    taskT.paraBase = PtrToValue(&mapInfo);

    EXPECT_EQ(kernelCpu_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
    EXPECT_EQ(*(reinterpret_cast<void **>(ValueToPtr(srcAddrList[0U]))),
        *(reinterpret_cast<void **>(ValueToPtr(dstAddrList[0U]))));
}

TEST_F(OperatorKernelZeroCpyTest, ModelZeroCpyCpu_fail_MissingParam)
{
    AicpuTaskInfo taskT;
    taskT.paraBase = 0U;

    EXPECT_NE(kernelCpu_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}

TEST_F(OperatorKernelZeroCpyTest, ModelZeroCpyCpu_fail_NullSrc)
{
    AddrMapInfo mapInfo = {};
    void *src1 = nullptr;
    void *src2 = nullptr;
    uint64_t srcAddrList[] = {PtrToValue(&src1), PtrToValue(&src2)};
    mapInfo.srcAddrList = PtrToValue(&srcAddrList[0U]);
    mapInfo.dstAddrList = 0U;
    mapInfo.addrNum = 2U;

    AicpuTaskInfo taskT;
    taskT.paraBase = PtrToValue(&mapInfo);

    EXPECT_NE(kernelCpu_.Compute(taskT, runContextT), AICPU_SCHEDULE_OK);
}
