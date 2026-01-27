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

class QsLogStest : public ::testing::Test {
public:
    virtual void SetUp() {}

    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(QsLogStest, OpenLogSo001)
{
    MOCKER_CPP(&bqs::FeatureCtrl::IsHostQs).stubs().will(returnValue(false));
    bqs::HostQsLog::GetInstance().OpenLogSo();
    EXPECT_NE(&(bqs::HostQsLog::GetInstance()), nullptr);
}

TEST_F(QsLogStest, OpenLogSo002)
{
    MOCKER_CPP(&bqs::FeatureCtrl::IsHostQs).stubs().will(returnValue(true));
    bqs::HostQsLog::GetInstance().OpenLogSo();
    EXPECT_NE(&(bqs::HostQsLog::GetInstance()), nullptr);
}

TEST_F(QsLogStest, OpenLogSo003)
{
    MOCKER_CPP(&bqs::FeatureCtrl::IsHostQs).stubs().will(returnValue(true));
    setenv("ASCEND_AICPU_PATH", "/home", 1);
    MOCKER(memset_s).stubs().will(returnValue(EINVAL));
    bqs::HostQsLog::GetInstance().OpenLogSo();
    EXPECT_NE(&(bqs::HostQsLog::GetInstance()), nullptr);
}

TEST_F(QsLogStest, OpenLogSo004)
{
    MOCKER_CPP(&bqs::FeatureCtrl::IsHostQs).stubs().will(returnValue(true));
    setenv("ASCEND_AICPU_PATH", "/home", 1);
    MOCKER(memset_s).stubs().will(returnValue(EOK));
    char *a = nullptr;
    MOCKER(realpath).stubs().will(returnValue(a));
    bqs::HostQsLog::GetInstance().OpenLogSo();
    EXPECT_NE(&(bqs::HostQsLog::GetInstance()), nullptr);
}

TEST_F(QsLogStest, OpenLogSo005)
{
    MOCKER_CPP(&bqs::FeatureCtrl::IsHostQs).stubs().will(returnValue(true));
    setenv("ASCEND_AICPU_PATH", "/home", 1);
    MOCKER(memset_s).stubs().will(returnValue(EOK));
    char_t *path = "test";
    MOCKER(realpath).stubs().will(returnValue(path));
    bqs::HostQsLog::GetInstance().OpenLogSo();
    EXPECT_NE(&(bqs::HostQsLog::GetInstance()), nullptr);
}


TEST_F(QsLogStest, OpenLogSo006)
{
    MOCKER_CPP(&bqs::FeatureCtrl::IsHostQs).stubs().will(returnValue(true));
    setenv("ASCEND_AICPU_PATH", "/home", 1);
    MOCKER(memset_s).stubs().will(returnValue(EOK)).then(returnValue(EINVAL));
    char_t *path = "test";
    MOCKER(realpath).stubs().will(returnValue(path));
    uint64_t rest = 0;
    MOCKER(dlopen).stubs().will(returnValue((void*)(&rest)));
    MOCKER(dlsym).stubs().will(returnValue(static_cast<void *>(nullptr)));
    bqs::HostQsLog::GetInstance().OpenLogSo();
    EXPECT_NE(&(bqs::HostQsLog::GetInstance()), nullptr);
}

TEST_F(QsLogStest, OpenLogSo007)
{
    MOCKER_CPP(&bqs::FeatureCtrl::IsHostQs).stubs().will(returnValue(true));
    setenv("ASCEND_AICPU_PATH", "/home", 1);
    MOCKER(memset_s).stubs().will(returnValue(EOK)).then(returnValue(EOK));
    char_t *path = "test";
    char *a = nullptr;
    MOCKER(realpath).stubs().will(returnValue(path)).then(returnValue(a));
    uint64_t rest = 0;
    MOCKER(dlopen).stubs().will(returnValue((void*)(&rest)));
    MOCKER(dlsym).stubs().will(returnValue(static_cast<void *>(nullptr)));
    bqs::HostQsLog::GetInstance().OpenLogSo();
    EXPECT_NE(&(bqs::HostQsLog::GetInstance()), nullptr);
}

TEST_F(QsLogStest, OpenLogSo008)
{
    MOCKER_CPP(&bqs::FeatureCtrl::IsHostQs).stubs().will(returnValue(true));
    setenv("ASCEND_AICPU_PATH", "/home", 1);
    MOCKER(memset_s).stubs().will(returnValue(EOK)).then(returnValue(EOK));
    char_t *path = "test";
    char *a = nullptr;
    MOCKER(realpath).stubs().will(returnValue(path)).then(returnValue(path));
    uint64_t rest = 0;
    MOCKER(dlopen).stubs().will(returnValue((void*)(&rest))).then(returnValue((void*)1));
    MOCKER(dlsym).stubs().will(returnValue(static_cast<void *>(nullptr)));
    bqs::HostQsLog::GetInstance().OpenLogSo();
    EXPECT_NE(&(bqs::HostQsLog::GetInstance()), nullptr);
}

TEST_F(QsLogStest, OpenLoLogPrintNormal001)
{
    bqs::HostQsLog::GetInstance().LogPrintNormal(0, 0, "[tid:%llu] ", 1);
    EXPECT_NE(&(bqs::HostQsLog::GetInstance()), nullptr);
}

TEST_F(QsLogStest, OpenLoLogLogPrintError001)
{
    bqs::HostQsLog::GetInstance().LogPrintError(0, "[tid:%llu] ", 1);
    EXPECT_NE(&(bqs::HostQsLog::GetInstance()), nullptr);
}

TEST_F(QsLogStest, CheckLogLevel001)
{
    MOCKER_CPP(&bqs::FeatureCtrl::IsHostQs).stubs().will(returnValue(true));
    bqs::HostQsLog::GetInstance().CheckLogLevel(0, 1);
    EXPECT_NE(&(bqs::HostQsLog::GetInstance()), nullptr);
}

TEST_F(QsLogStest, CheckLogLevel002)
{
    MOCKER_CPP(&bqs::FeatureCtrl::IsHostQs).stubs().will(returnValue(true));
    MOCKER_CPP(&bqs::HostQsLog::CheckLogLevelHost).stubs().will(returnValue(true));
    bqs::HostQsLog::GetInstance().CheckLogLevel(0, 1);
    EXPECT_NE(&(bqs::HostQsLog::GetInstance()), nullptr);
}

TEST_F(QsLogStest, CheckLogLevel003)
{
    MOCKER_CPP(&bqs::FeatureCtrl::IsHostQs).stubs().will(returnValue(true));
    MOCKER_CPP(&bqs::FeatureCtrl::IsHostQs).stubs().will(returnValue(true));
    setenv("ASCEND_AICPU_PATH", "/home", 1);
    MOCKER(memset_s).stubs().will(returnValue(EOK)).then(returnValue(EOK));
    char_t *path = "test";
    void *a = dlsym(RTLD_DEFAULT, "CheckLogLevel");
    MOCKER(realpath).stubs().will(returnValue(path)).then(returnValue(path));
    uint64_t rest = 0;
    MOCKER(dlopen).stubs().will(returnValue((void*)(&rest))).then(returnValue((void*)1));
    MOCKER(dlsym).stubs().will(returnValue(a));
    bqs::HostQsLog::GetInstance().OpenLogSo();
    bqs::HostQsLog::GetInstance().CheckLogLevel(0, 1);
    EXPECT_NE(&(bqs::HostQsLog::GetInstance()), nullptr);
}