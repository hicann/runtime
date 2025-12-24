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
#include "securec.h"
#include <sys/wait.h>
#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <libgen.h>
#include <sys/stat.h>
#include <sys/utsname.h>
#include <dirent.h>
#include <sys/time.h>
#include <sys/vfs.h>
#include <locale>
#include <errno.h>
#include <algorithm>
#include <fstream>
//mac
#include <net/if.h>
#include <sys/prctl.h>
#include "utils/utils.h"
#include "stub/common-utils-stub.h"
#include "config/config.h"
#include <sys/file.h>

using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::error;

class COMMON_UTILS_UTILS_STEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

int32_t g_scanDir = 0;
int32_t OsalScandirStub(const char *filePath, OsalDirent ***namelist)
{
    g_scanDir++;
    return 0;
}
TEST_F(COMMON_UTILS_UTILS_STEST, RemoveDir) {
    GlobalMockObject::verify();
    std::string path = "/path/to/dir";
    // OsalScandir failed
    Utils::RemoveDir(path, false);
    // nameList is nullptr
    MOCKER(OsalScandir)
        .stubs()
        .with(any(), any(), any(), any())
        .will(invoke(OsalScandirStub));
    Utils::RemoveDir(path, false);
    EXPECT_EQ(g_scanDir, 1);
}

TEST_F(COMMON_UTILS_UTILS_STEST, WriteFile_fileno_failed) {
    GlobalMockObject::verify();
    std::string profName = "test\n";
    system("touch ./writeFile_test");
    MOCKER_CPP(fileno)
        .stubs()
        .will(returnValue(-1));
    MOCKER_CPP(fclose)
        .stubs()
        .will(returnValue(2));
    // fileno failed
    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::common::utils::WriteFile("./test", "test", profName));
    system("rm -rf ./writeFile_test");
}

TEST_F(COMMON_UTILS_UTILS_STEST, get_child_dirs_out_range_of_depth) {
    GlobalMockObject::verify();
    std::string dir("/tmp/get_child_dirs_scan_dir_fail");
    bool is_recur = false;
    std::vector<std::string> child_dir;
    Utils::GetChildDirs(dir, is_recur, child_dir, 11);
    EXPECT_EQ(0, child_dir.size());
}

TEST_F(COMMON_UTILS_UTILS_STEST, get_files_out_range_of_depth) {
    GlobalMockObject::verify();
    std::string path = "/path/to/dir";
    std::vector<std::string> files;
    Utils::GetFiles(path, true, files, 11);
    EXPECT_EQ(0, files.size());
}

TEST_F(COMMON_UTILS_UTILS_STEST, CheckStrToInt32Failed) {
    int32_t value = 0;
    bool ret = Utils::StrToInt32(value, "2147483647");
    EXPECT_EQ(value, 2147483647);

    value = 0;
    ret = Utils::StrToInt32(value, "-2147483648");
    EXPECT_EQ(value, -2147483648);

    value = 0;
    ret = Utils::StrToInt32(value, "-2147483649");
    EXPECT_TRUE(value == 0);

    value = 0;
    ret = Utils::StrToInt32(value, "2147483648");
    EXPECT_TRUE(value == 0);

    value = 0;
    ret = Utils::StrToInt32(value, "");
    EXPECT_TRUE(value == 0);

    value = 0;
    ret = Utils::StrToInt32(value, "1123abc");
    EXPECT_EQ(value, 1123);
}

TEST_F(COMMON_UTILS_UTILS_STEST, CheckStrToStrToUint32Failed) {
    uint32_t value = 0;
    bool ret = Utils::StrToUint32(value, "4294967295");
    EXPECT_EQ(value, 4294967295);

    value = 0;
    ret = Utils::StrToUint32(value, "");
    EXPECT_TRUE(value == 0);

    value = 0;
    ret = Utils::StrToUint32(value, "1123abc");
    EXPECT_TRUE(value == 0);

    value = 0;
    ret = Utils::StrToUint32(value, "-1");
    EXPECT_TRUE(value == 0);
}

TEST_F(COMMON_UTILS_UTILS_STEST, IsDirAccessible) {
    std::string path = "/notDir";
    EXPECT_EQ(false, Utils::IsDirAccessible(path));

    MOCKER(OsalAccess2).stubs().will(returnValue(PROFILING_FAILED));
    path = "/tmp";
    EXPECT_EQ(false, Utils::IsDirAccessible(path));
}
