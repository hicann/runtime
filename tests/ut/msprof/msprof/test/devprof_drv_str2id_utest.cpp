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
#include "ascend_inpackage_hal.h"
#include "error_code.h"
#include "devprof_common.h"
#include "config.h"
#include "utils.h"
#include "devprof_drv_aicpu.h"
#include "transport/hash_data.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::config;
using namespace Devprof;

class DEVPROF_DRV_STR2ID_UTEST : public testing::Test {
protected:
    virtual void SetUp()
    {
        GlobalMockObject::verify();
#ifdef __PROF_LLT
        DevprofDrvAicpu::instance()->Reset();
#endif
        analysis::dvvp::transport::HashData::instance()->Init();
    }
    virtual void TearDown()
    {
        DevprofDrvAicpu::instance()->Stop();
    }
};

TEST_F(DEVPROF_DRV_STR2ID_UTEST, ReportStr2IdInfoToHost_Normal)
{
    uint32_t bufLen = 1024 * 1024;
    MOCKER(halProfQueryAvailBufLen)
        .stubs()
        .with(any(), any(), outBoundP(&bufLen, sizeof(bufLen)))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    MOCKER(halProfSampleDataReport)
        .stubs()
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    std::string dataStr = "key1,key2,key3";
    int32_t ret = DevprofDrvAicpu::instance()->ReportStr2IdInfoToHost(dataStr);
    EXPECT_EQ(PROFILING_SUCCESS, ret);
}

TEST_F(DEVPROF_DRV_STR2ID_UTEST, ReportStr2IdInfoToHost_MultiStruct)
{
    uint32_t bufLen = 1024 * 1024;
    MOCKER(halProfQueryAvailBufLen)
        .stubs()
        .with(any(), any(), outBoundP(&bufLen, sizeof(bufLen)))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    MOCKER(halProfSampleDataReport)
        .stubs()
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    std::string dataStr;
    for (int i = 0; i < 30; ++i) {
        if (i > 0) {
            dataStr += ",";
        }
        dataStr += "op_kernel_name_" + std::to_string(i);
    }
    int32_t ret = DevprofDrvAicpu::instance()->ReportStr2IdInfoToHost(dataStr);
    EXPECT_EQ(PROFILING_SUCCESS, ret);
}

TEST_F(DEVPROF_DRV_STR2ID_UTEST, ReportStr2IdInfoToHost_KeyTooLong)
{
    uint32_t bufLen = 1024 * 1024;
    MOCKER(halProfQueryAvailBufLen)
        .stubs()
        .with(any(), any(), outBoundP(&bufLen, sizeof(bufLen)))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    MOCKER(halProfSampleDataReport)
        .stubs()
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    std::string longKey(MSPROF_ADDTIONAL_INFO_DATA_LENGTH + 1, 'x');
    std::string dataStr = longKey + ",short_key";
    int32_t ret = DevprofDrvAicpu::instance()->ReportStr2IdInfoToHost(dataStr);
    EXPECT_EQ(PROFILING_SUCCESS, ret);
}

TEST_F(DEVPROF_DRV_STR2ID_UTEST, ReportStr2IdInfoToHost_EmptyBuffer)
{
    // buffer 未初始化时，AddStr2IdIntoBuffer 内部 push 失败，
    // SendAddtionalInfo 检测到 buffer 为空直接返回 SUCCESS
    std::string dataStr = "key1,key2";
    int32_t ret = DevprofDrvAicpu::instance()->ReportStr2IdInfoToHost(dataStr);
    EXPECT_EQ(PROFILING_SUCCESS, ret);
}

TEST_F(DEVPROF_DRV_STR2ID_UTEST, ReportStr2IdInfoToHost_KeyExactly232)
{
    uint32_t bufLen = 1024 * 1024;
    MOCKER(halProfQueryAvailBufLen)
        .stubs()
        .with(any(), any(), outBoundP(&bufLen, sizeof(bufLen)))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    MOCKER(halProfSampleDataReport)
        .stubs()
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    std::string key232(MSPROF_ADDTIONAL_INFO_DATA_LENGTH, 'x');
    std::string dataStr = key232 + ",short";
    int32_t ret = DevprofDrvAicpu::instance()->ReportStr2IdInfoToHost(dataStr);
    EXPECT_EQ(PROFILING_SUCCESS, ret);
}

TEST_F(DEVPROF_DRV_STR2ID_UTEST, ReportStr2IdInfoToHost_BoundarySplit)
{
    uint32_t bufLen = 1024 * 1024;
    MOCKER(halProfQueryAvailBufLen)
        .stubs()
        .with(any(), any(), outBoundP(&bufLen, sizeof(bufLen)))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    MOCKER(halProfSampleDataReport)
        .stubs()
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    std::string key231(MSPROF_ADDTIONAL_INFO_DATA_LENGTH - 1, 'a');
    std::string dataStr = key231 + ",b";
    int32_t ret = DevprofDrvAicpu::instance()->ReportStr2IdInfoToHost(dataStr);
    EXPECT_EQ(PROFILING_SUCCESS, ret);
}

TEST_F(DEVPROF_DRV_STR2ID_UTEST, ReportStr2IdInfoToHost_EmptyInput)
{
    uint32_t bufLen = 1024 * 1024;
    MOCKER(halProfQueryAvailBufLen)
        .stubs()
        .with(any(), any(), outBoundP(&bufLen, sizeof(bufLen)))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    MOCKER(halProfSampleDataReport)
        .stubs()
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    std::string dataStr = "";
    int32_t ret = DevprofDrvAicpu::instance()->ReportStr2IdInfoToHost(dataStr);
    EXPECT_EQ(PROFILING_SUCCESS, ret);
}
