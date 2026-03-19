/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
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
#include "hwts_kernel_soma.h"
#include "aicpusd_hal_interface_ref.h"

using namespace AicpuSchedule;
using namespace aicpu;

class SomaMemMngTsKernelTest : public EventProcessKernelTest {
protected:
    SomaMemMngTsKernel kernel_;
};

TEST_F(SomaMemMngTsKernelTest, TsKernelSomaMemMng_mallocsuccess)
{
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;

    auto mng = std::make_unique<SomaMemMng>();

    MOCKER(halMemPoolMalloc)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(DRV_ERROR_NONE));

    mng->deviceId = 0;
    mng->memAsyncOpType = 0;
    mng->memAsyncSubCMD = 0;
    mng->mempoolId = 123;
    mng->va = 0x100000000ULL;
    mng->size = 4096;

    cceKernel.paramBase = (uint64_t)mng.get();
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(SomaMemMngTsKernelTest, TsKernelSomaMemMng_freesuccess)
{
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;

    auto mng = std::make_unique<SomaMemMng>();

    MOCKER(halMemPoolFree)
        .stubs()
        .with( mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(DRV_ERROR_NONE));

    mng->deviceId = 0;
    mng->memAsyncOpType = 1;
    mng->memAsyncSubCMD = 0;
    mng->mempoolId = 123;
    mng->va = 0x100000000ULL;
    mng->size = 4096;

    cceKernel.paramBase = (uint64_t)mng.get();
    tsKernelInfo.kernelBase.cceKernel = cceKernel;

    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(SomaMemMngTsKernelTest, TsKernelSomaMemMng_freefailed)
{
    aicpu::HwtsTsKernel tsKernelInfo;
    aicpu::HwtsCceKernel cceKernel;
    
    auto mng = std::make_unique<SomaMemMng>();
    
    MOCKER(halMemPoolFree)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any())
        .will(returnValue(DRV_ERROR_NONE));
    
    mng->deviceId = 0;
    mng->memAsyncOpType = 3;
    mng->memAsyncSubCMD = 0;
    mng->mempoolId = 123;
    mng->va = 0x100000000ULL;
    mng->size = 4096;
    
    cceKernel.paramBase = (uint64_t)mng.get();
    tsKernelInfo.kernelBase.cceKernel = cceKernel;
    
    int ret = kernel_.Compute(tsKernelInfo);
    EXPECT_NE(ret, AICPU_SCHEDULE_OK);
}