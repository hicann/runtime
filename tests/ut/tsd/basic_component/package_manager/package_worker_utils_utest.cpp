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
#include "tsd_log.h"
#include "tsd_util_func.h"
#define private public
#define protected public
#include "package_verify.h"
#include "package_worker_utils.h"
#undef private
#undef protected
using namespace tsd;

class PackageWorkerUtilsTest : public testing::Test {
protected:
    void TearDown() override
    {
        try {
            GlobalMockObject::verify();
        } catch (...) {
            GlobalMockObject::reset();
            throw;
        }
        GlobalMockObject::reset();
    }
};

TEST_F(PackageWorkerUtilsTest, MakeDirectory_PathMissing_CreatesDirectory)
{
    MOCKER(access).stubs().will(returnValue(-1));
    MOCKER(mkdir).stubs().will(returnValue(0));
    MOCKER(chmod).stubs().will(returnValue(0));
    const TSD_StatusT ret = PackageWorkerUtils::MakeDirectory("./tsd_mkdir_test");
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(PackageWorkerUtilsTest, MakeDirectory_PathIsExistingDirectory_ReturnsOk)
{
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER(mmIsDir).stubs().will(returnValue(0));
    const TSD_StatusT ret = PackageWorkerUtils::MakeDirectory("./tsd_mkdir_test");
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(PackageWorkerUtilsTest, MakeDirectory_EmptyPath_ReturnsInternalError)
{
    const TSD_StatusT ret = PackageWorkerUtils::MakeDirectory("");
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(PackageWorkerUtilsTest, MakeDirectory_PathIsExistingFile_ReturnsInternalError)
{
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER(mmIsDir).stubs().will(returnValue(1));
    const TSD_StatusT ret = PackageWorkerUtils::MakeDirectory("./tsd_mkdir_test");
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(PackageWorkerUtilsTest, MakeDirectory_MkdirFails_ReturnsInternalError)
{
    MOCKER(access).stubs().will(returnValue(-1));
    MOCKER(mkdir).stubs().will(returnValue(-1));
    const TSD_StatusT ret = PackageWorkerUtils::MakeDirectory("./tsd_mkdir_test");
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(PackageWorkerUtilsTest, MakeDirectory_ChmodFails_ReturnsInternalError)
{
    MOCKER(access).stubs().will(returnValue(-1));
    MOCKER(mkdir).stubs().will(returnValue(0));
    MOCKER(chmod).stubs().will(returnValue(-1));
    const TSD_StatusT ret = PackageWorkerUtils::MakeDirectory("./tsd_mkdir_test");
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}
