/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <dlfcn.h>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "bqs_log.h"
#include "bqs_feature_ctrl.h"
#include "securec.h"

using namespace bqs;

class QsLogUtest : public ::testing::Test {
public:
    virtual void SetUp() {}

    virtual void TearDown() { GlobalMockObject::verify(); }
};

TEST_F(QsLogUtest, OpenLogSo001)
{
    MOCKER_CPP(&bqs::FeatureCtrl::IsHostQs).stubs().will(returnValue(false));
    bqs::HostQsLog::GetInstance().OpenLogSo();
    EXPECT_NE(&(bqs::HostQsLog::GetInstance()), nullptr);
}

TEST_F(QsLogUtest, OpenLogSo002)
{
    MOCKER_CPP(&bqs::FeatureCtrl::IsHostQs).stubs().will(returnValue(true));
    bqs::HostQsLog::GetInstance().OpenLogSo();
    EXPECT_NE(&(bqs::HostQsLog::GetInstance()), nullptr);
}

TEST_F(QsLogUtest, OpenLogSo003)
{
    MOCKER_CPP(&bqs::FeatureCtrl::IsHostQs).stubs().will(returnValue(true));
    setenv("ASCEND_AICPU_PATH", "/home", 1);
    MOCKER(memset_s).stubs().will(returnValue(EINVAL));
    bqs::HostQsLog::GetInstance().OpenLogSo();
    EXPECT_NE(&(bqs::HostQsLog::GetInstance()), nullptr);
}

TEST_F(QsLogUtest, OpenLogSo004)
{
    MOCKER_CPP(&bqs::FeatureCtrl::IsHostQs).stubs().will(returnValue(true));
    setenv("ASCEND_AICPU_PATH", "/home", 1);
    MOCKER(memset_s).stubs().will(returnValue(EOK));
    char* a = nullptr;
    MOCKER(realpath).stubs().will(returnValue(a));
    bqs::HostQsLog::GetInstance().OpenLogSo();
    EXPECT_NE(&(bqs::HostQsLog::GetInstance()), nullptr);
}

TEST_F(QsLogUtest, OpenLogSo005)
{
    MOCKER_CPP(&bqs::FeatureCtrl::IsHostQs).stubs().will(returnValue(true));
    setenv("ASCEND_AICPU_PATH", "/home", 1);
    MOCKER(memset_s).stubs().will(returnValue(EOK));
    char_t path[] = "test";
    MOCKER(realpath).stubs().will(returnValue(&path[0U]));
    bqs::HostQsLog::GetInstance().OpenLogSo();
    EXPECT_NE(&(bqs::HostQsLog::GetInstance()), nullptr);
}

TEST_F(QsLogUtest, OpenLogSo006)
{
    MOCKER_CPP(&bqs::FeatureCtrl::IsHostQs).stubs().will(returnValue(true));
    setenv("ASCEND_AICPU_PATH", "/home", 1);
    MOCKER(memset_s).stubs().will(returnValue(EOK)).then(returnValue(EINVAL));
    char_t path[] = "test";
    MOCKER(realpath).stubs().will(returnValue(&path[0U]));
    uint64_t rest = 0;
    MOCKER(dlopen).stubs().will(returnValue((void*)(&rest)));
    MOCKER(dlsym).stubs().will(returnValue(static_cast<void*>(nullptr)));
    bqs::HostQsLog::GetInstance().OpenLogSo();
    EXPECT_NE(&(bqs::HostQsLog::GetInstance()), nullptr);
}

TEST_F(QsLogUtest, OpenLogSo007)
{
    MOCKER_CPP(&bqs::FeatureCtrl::IsHostQs).stubs().will(returnValue(true));
    setenv("ASCEND_AICPU_PATH", "/home", 1);
    MOCKER(memset_s).stubs().will(returnValue(EOK)).then(returnValue(EOK));
    char_t path[] = "test";
    char* a = nullptr;
    MOCKER(realpath).stubs().will(returnValue(&path[0U])).then(returnValue(a));
    uint64_t rest = 0;
    MOCKER(dlopen).stubs().will(returnValue((void*)(&rest)));
    MOCKER(dlsym).stubs().will(returnValue(static_cast<void*>(nullptr)));
    bqs::HostQsLog::GetInstance().OpenLogSo();
    EXPECT_NE(&(bqs::HostQsLog::GetInstance()), nullptr);
}

TEST_F(QsLogUtest, OpenLogSo008)
{
    MOCKER_CPP(&bqs::FeatureCtrl::IsHostQs).stubs().will(returnValue(true));
    setenv("ASCEND_AICPU_PATH", "/home", 1);
    MOCKER(memset_s).stubs().will(returnValue(EOK)).then(returnValue(EOK));
    char_t path[] = "test";
    MOCKER(realpath).stubs().will(returnValue(&path[0U])).then(returnValue(&path[0U]));
    uint64_t rest = 0;
    MOCKER(dlopen).stubs().will(returnValue((void*)(&rest))).then(returnValue((void*)1));
    MOCKER(dlsym).stubs().will(returnValue(static_cast<void*>(nullptr)));
    bqs::HostQsLog::GetInstance().OpenLogSo();
    EXPECT_NE(&(bqs::HostQsLog::GetInstance()), nullptr);
}

TEST_F(QsLogUtest, OpenLoLogPrintNormal001)
{
    bqs::HostQsLog::GetInstance().LogPrintNormal(0, 0, "[tid:%llu] ", 1);
    EXPECT_NE(&(bqs::HostQsLog::GetInstance()), nullptr);
}

TEST_F(QsLogUtest, OpenLoLogLogPrintError001)
{
    bqs::HostQsLog::GetInstance().LogPrintError(0, "[tid:%llu] ", 1);
    EXPECT_NE(&(bqs::HostQsLog::GetInstance()), nullptr);
}

TEST_F(QsLogUtest, CheckLogLevel001)
{
    MOCKER_CPP(&bqs::FeatureCtrl::IsHostQs).stubs().will(returnValue(true));
    bqs::HostQsLog::GetInstance().CheckLogLevel(0, 1);
    EXPECT_NE(&(bqs::HostQsLog::GetInstance()), nullptr);
}

TEST_F(QsLogUtest, CheckLogLevel002)
{
    MOCKER_CPP(&bqs::FeatureCtrl::IsHostQs).stubs().will(returnValue(true));
    MOCKER_CPP(&bqs::HostQsLog::CheckLogLevelHost).stubs().will(returnValue(true));
    bqs::HostQsLog::GetInstance().CheckLogLevel(0, 1);
    EXPECT_NE(&(bqs::HostQsLog::GetInstance()), nullptr);
}

TEST_F(QsLogUtest, CheckLogLevel003)
{
    MOCKER_CPP(&bqs::FeatureCtrl::IsHostQs).stubs().will(returnValue(true));
    MOCKER_CPP(&bqs::FeatureCtrl::IsHostQs).stubs().will(returnValue(true));
    setenv("ASCEND_AICPU_PATH", "/home", 1);
    MOCKER(memset_s).stubs().will(returnValue(EOK)).then(returnValue(EOK));
    char_t path[] = "test";
    void* a = dlsym(RTLD_DEFAULT, "CheckLogLevel");
    MOCKER(realpath).stubs().will(returnValue(&path[0U]));
    uint64_t rest = 0;
    MOCKER(dlopen).stubs().will(returnValue((void*)(&rest))).then(returnValue((void*)1));
    MOCKER(dlsym).stubs().will(returnValue(a));
    bqs::HostQsLog::GetInstance().OpenLogSo();
    bqs::HostQsLog::GetInstance().CheckLogLevel(0, 1);
    EXPECT_NE(&(bqs::HostQsLog::GetInstance()), nullptr);
}

TEST_F(QsLogUtest, BqsCheckAssign32UAddOverflow001)
{
    uint32_t result = 0U;
    bool onceOverFlow = false;
    bqs::BqsCheckAssign32UAdd(UINT32_MAX, 1U, result, onceOverFlow);
    EXPECT_EQ(onceOverFlow, true);
    EXPECT_EQ(result, 0U);
}

TEST_F(QsLogUtest, BqsCheckAssign32UAddOverflow002)
{
    uint32_t result = 0U;
    bool onceOverFlow = true;
    bqs::BqsCheckAssign32UAdd(UINT32_MAX, UINT32_MAX, result, onceOverFlow);
    EXPECT_EQ(onceOverFlow, true);
    EXPECT_EQ(result, 0U);
}

TEST_F(QsLogUtest, BqsCheckAssign32UAddNormal001)
{
    uint32_t result = 0U;
    bool onceOverFlow = false;
    bqs::BqsCheckAssign32UAdd(100U, 200U, result, onceOverFlow);
    EXPECT_EQ(onceOverFlow, false);
    EXPECT_EQ(result, 300U);
}

TEST_F(QsLogUtest, BqsCheckAssign32UMutiOverflow001)
{
    uint32_t result = 0U;
    bool onceOverFlow = false;
    bqs::BqsCheckAssign32UMuti(UINT32_MAX, 2U, result, onceOverFlow);
    EXPECT_EQ(onceOverFlow, true);
    EXPECT_EQ(result, 0U);
}

TEST_F(QsLogUtest, BqsCheckAssign32UMutiNormal001)
{
    uint32_t result = 0U;
    bool onceOverFlow = false;
    bqs::BqsCheckAssign32UMuti(100U, 0U, result, onceOverFlow);
    EXPECT_EQ(onceOverFlow, false);
    EXPECT_EQ(result, 0U);
    bqs::BqsCheckAssign32UMuti(100U, 3U, result, onceOverFlow);
    EXPECT_EQ(onceOverFlow, false);
    EXPECT_EQ(result, 300U);
}

TEST_F(QsLogUtest, BqsCheckAssign64UAddOverflow001)
{
    bool onceOverFlow = false;
    const uint64_t ret = bqs::BqsCheckAssign64UAdd(UINT64_MAX, 1UL, onceOverFlow);
    EXPECT_EQ(onceOverFlow, true);
    EXPECT_EQ(ret, 0UL);
}

TEST_F(QsLogUtest, BqsCheckAssign64UAddNormal001)
{
    bool onceOverFlow = false;
    const uint64_t ret = bqs::BqsCheckAssign64UAdd(100UL, 200UL, onceOverFlow);
    EXPECT_EQ(onceOverFlow, false);
    EXPECT_EQ(ret, 300UL);
}