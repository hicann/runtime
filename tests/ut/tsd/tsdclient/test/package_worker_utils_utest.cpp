/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <pwd.h>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "inc/log.h"
#include "inc/internal_api.h"
#define private public
#define protected public
#include "inc/package_verify.h"
#include "inc/package_worker_utils.h"
#undef private
#undef protected
using namespace tsd;

namespace {
std::string GetWorkDir()
{
    struct passwd *user = getpwuid(getuid());
    if ((user == nullptr) ||
        (user->pw_dir == nullptr)) {
        return "";
    }

    std::string pwDir = user->pw_dir;
    std::string workdir = pwDir + "/tmp/" + std::to_string(getpid()) + "tsd/";
    return workdir;
};
}

class PackageWorkerUtilsTest : public testing::Test {
protected:
    static void SetUpTestCase() {
        const std::string workDir = GetWorkDir();
        const std::string cmd = "mkdir -p " + workDir + "inntertsd/" + "&& touch " +
                          workDir + "aaa && touch " + workDir + "inntertsd/bbb";
        const int32_t ret = PackSystem(cmd.c_str());

        std::cout << "PackageWorkerUtilsTest setup cmd=" << cmd << ", ret=" << ret << std::endl;
    }

    static void TearDownTestCase() {
        const std::string workDir = GetWorkDir();
        const std::string cmd = "rm -rf " + workDir;
        const int32_t ret = PackSystem(cmd.c_str());
        std::cout << "PackageWorkerUtilsTest teardown, ret is " << ret << std::endl;
    }

    virtual void SetUp() {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(PackageWorkerUtilsTest, MakeDirectorySuccess)
{
    MOCKER(access).stubs().will(returnValue(-1));
    MOCKER(mkdir).stubs().will(returnValue(0));
    MOCKER(chmod).stubs().will(returnValue(0));
    const TSD_StatusT ret = PackageWorkerUtils::MakeDirectory("./tsd_mkdir_test");
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(PackageWorkerUtilsTest, MakeDirectoryHasExistSuccess)
{
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER(mmIsDir).stubs().will(returnValue(0));
    const TSD_StatusT ret = PackageWorkerUtils::MakeDirectory("./tsd_mkdir_test");
    EXPECT_EQ(ret, TSD_OK);
}

TEST_F(PackageWorkerUtilsTest, MakeDirectoryPathEmpty)
{
    const TSD_StatusT ret = PackageWorkerUtils::MakeDirectory("");
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(PackageWorkerUtilsTest, MakeDirectoryHasExistFail)
{
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER(mmIsDir).stubs().will(returnValue(1));
    const TSD_StatusT ret = PackageWorkerUtils::MakeDirectory("./tsd_mkdir_test");
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(PackageWorkerUtilsTest, MakeDirectoryMkdirFail)
{
    MOCKER(access).stubs().will(returnValue(-1));
    MOCKER(mkdir).stubs().will(returnValue(-1));
    const TSD_StatusT ret = PackageWorkerUtils::MakeDirectory("./tsd_mkdir_test");
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(PackageWorkerUtilsTest, MakeDirectoryChmodFail)
{
    MOCKER(access).stubs().will(returnValue(-1));
    MOCKER(mkdir).stubs().will(returnValue(0));
    MOCKER(chmod).stubs().will(returnValue(-1));
    const TSD_StatusT ret = PackageWorkerUtils::MakeDirectory("./tsd_mkdir_test");
    EXPECT_EQ(ret, TSD_INTERNAL_ERROR);
}

TEST_F(PackageWorkerUtilsTest, GetDirSizeEmpty)
{
    const uint64_t ret = PackageWorkerUtils::GetDirSize("");
    EXPECT_EQ(ret, 0UL);
}

TEST_F(PackageWorkerUtilsTest, IsCgroupMemMode_For_access_memlimit_fail)
{
    MOCKER(access).stubs().will(returnValue(1));
    EXPECT_FALSE(PackageWorkerUtils::IsCgroupMemMode(0U, 0U));
}

TEST_F(PackageWorkerUtilsTest, IsCgroupMemMode_For_access_usermemory_fail)
{
    MOCKER(access).stubs().will(returnValue(0)).then(returnValue(1));
    EXPECT_FALSE(PackageWorkerUtils::IsCgroupMemMode(0U, 0U));
}