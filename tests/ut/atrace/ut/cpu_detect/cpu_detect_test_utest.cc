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
#include <thread>
#include <future>
#include <unistd.h>
#include <sys/syscall.h>
#include "cpu_detect.h"
#include "cpu_detect_types.h"
#include "cpu_detect_core.h"
#include "cpu_detect_test.h"
#include "mmpa_api.h"
#include "ascend_hal.h"
#include "slog.h"

class CpuDetectTestUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
        system("rm -rf " LLT_TEST_DIR "/*");
        system("mkdir -p " LLT_TEST_DIR );
        system("echo [DBG][CpuDetectTest][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        system("rm -rf " LLT_TEST_DIR "/*");
        system("echo [DBG][CpuDetectTest][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("echo [DBG][CpuDetectTest][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        system("echo [DBG][CpuDetectTest][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }
};

TEST_F(CpuDetectTestUtest, UtestCpuDetectGroup)
{
    uint32_t *regValues = (uint32_t *)malloc(64 * 512);
    uint32_t *loadStoreBuf = (uint32_t *)malloc(64 * 512);
    CpudStatus ret = CpuDetectGroup(regValues, loadStoreBuf, 0);
    EXPECT_EQ(ret, CPUD_SUCCESS);
    free(regValues);
    free(loadStoreBuf);
}

static void EnhanceLoadStoreP02Stub(uint32_t *reg_values, uint32_t *load_store_buf)
{
    static uint32_t num = 1;
    reg_values[0] = num;
    reg_values[0] = num;
    num++;
}

TEST_F(CpuDetectTestUtest, UtestCpuDetectGroup_TestcaseFail)
{
    MOCKER(EnhanceLoadStoreP02).stubs().will(invoke(EnhanceLoadStoreP02Stub));
    uint32_t *regValues = (uint32_t *)malloc(64 * 512);
    uint32_t *loadStoreBuf = (uint32_t *)malloc(64 * 512);
    CpudStatus ret = CpuDetectGroup(regValues, loadStoreBuf, 0);
    EXPECT_EQ(ret, CPUD_ERROR_TESTCASE);
    free(regValues);
    free(loadStoreBuf);
}