/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include "mockcpp/mockcpp.hpp"
#define protected public
#define private public

#include "ide_daemon_stub.h"
#include "file_utils.h"
#include "mmpa_api.h"
#include "memory_utils.h"
#include "string_utils.h"

using namespace Adx;
class FILE_UTILS_STEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(FILE_UTILS_STEST, WriteFile)
{
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, Adx::FileUtils::WriteFile("", nullptr, 0, -1));
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, Adx::FileUtils::WriteFile("/home/test.log", nullptr, 0, -1));
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, Adx::FileUtils::WriteFile("", "data", 0, -1));

    MOCKER(mmGetErrorCode)
        .stubs()
        .will(returnValue(ENAMETOOLONG))
        .then(returnValue(ENAMETOOLONG - 1));

    MOCKER(mmOpen2)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(-1))
        .then(returnValue(-1))
        .then(returnValue(1));

    MOCKER(mmLseek)
        .stubs()
        .will(returnValue(long(EN_INVALID_PARAM)))
        .then(returnValue(long(0)));

    MOCKER(mmWrite)
        .stubs()
        .will(returnValue(mmSsize_t(-1)))
        .then(returnValue(mmSsize_t(4)));

    MOCKER(Adx::FileUtils::AddMappingFileItem)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(0));

    // mmOpen2 failed ENAMETOOLONG
    EXPECT_EQ(IDE_DAEMON_INVALID_PATH_ERROR, Adx::FileUtils::WriteFile("/home/test.log", "data", 4, -1));

    //mmOpen2 failed
    EXPECT_EQ(IDE_DAEMON_INVALID_PATH_ERROR, Adx::FileUtils::WriteFile("/home/test.log", "data", 4, -1));

    //mmLseek failed
    EXPECT_EQ(IDE_DAEMON_UNKNOW_ERROR, Adx::FileUtils::WriteFile("/home/test.log", "data", 4, 0));

    //mmWrite failed
    EXPECT_EQ(IDE_DAEMON_NO_SPACE_ERROR, Adx::FileUtils::WriteFile("/home/test.log", "data", 4, 0));

    //succ
    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, Adx::FileUtils::WriteFile("/home/test.log", "data", 4, 0));
}

TEST_F(FILE_UTILS_STEST, AddMappingFileItem)
{
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, Adx::FileUtils::AddMappingFileItem("", "123456788990089"));
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, Adx::FileUtils::AddMappingFileItem("/home/test.log", ""));

    MOCKER(mmOpen2)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(1));

    MOCKER(mmLseek)
        .stubs()
        .will(returnValue(long(EN_INVALID_PARAM)))
        .then(returnValue(long(0)));

    MOCKER(mmWrite)
        .stubs()
        .will(returnValue(mmSsize_t(-1)))
        .then(returnValue(mmSsize_t(25)));

    //mmOpen2 failed
    EXPECT_EQ(IDE_DAEMON_INVALID_PATH_ERROR, Adx::FileUtils::AddMappingFileItem("/home/test.log", "123456788990089"));

    //mmLseek failed
    EXPECT_EQ(IDE_DAEMON_UNKNOW_ERROR, Adx::FileUtils::AddMappingFileItem("/home/test.log","123456788990089"));

    //mmWrite failed
    EXPECT_EQ(IDE_DAEMON_NO_SPACE_ERROR, Adx::FileUtils::AddMappingFileItem("/home/test.log","123456788990089"));

    //succ
    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, Adx::FileUtils::AddMappingFileItem("/home/test.log","123456788990089"));
}

TEST_F(FILE_UTILS_STEST, CreateDir)
{
    EXPECT_EQ(IDE_DAEMON_INVALID_PATH_ERROR, Adx::FileUtils::CreateDir(""));
    MOCKER(Adx::FileUtils::IsFileExist)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, Adx::FileUtils::CreateDir("/home/test"));
    GlobalMockObject::verify();

    MOCKER(mmMkdir)
        .stubs()
        .will(returnValue(EN_ERR));
    MOCKER(Adx::FileUtils::IsFileExist)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true))
        .then(returnValue(false));
    EXPECT_EQ(IDE_DAEMON_MKDIR_ERROR, Adx::FileUtils::CreateDir("/home/test"));
    GlobalMockObject::verify();

    MOCKER(Adx::FileUtils::IsFileExist)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(false))
        .then(returnValue(true));

    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, Adx::FileUtils::CreateDir("/home/test"));
    GlobalMockObject::verify();
}

TEST_F(FILE_UTILS_STEST, IsFileExist)
{
    std::string path;
    EXPECT_FALSE(Adx::FileUtils::IsFileExist(path));

    MOCKER(mmAccess)
        .stubs()
        .will(returnValue(EN_ERR))
        .then(returnValue(EN_OK));

    path = "/home/test";
    EXPECT_FALSE(Adx::FileUtils::IsFileExist(path));
    EXPECT_TRUE(Adx::FileUtils::IsFileExist(path));
}
TEST_F(FILE_UTILS_STEST, IsDiskFull)
{
    mmDiskSize diskSize = {0};
    diskSize.availSize = 1 << 20;
    diskSize.freeSize = 1024 * 1024 + 1;;
    MOCKER(mmGetDiskFreeSpace)
        .stubs()
        .with(any(), outBoundP((mmDiskSize *)&diskSize, sizeof(diskSize)))
        .will(returnValue(EN_ERR))
        .then(returnValue(EN_OK));
    std::string invaild;
    EXPECT_FALSE(Adx::FileUtils::IsDiskFull(invaild, 0));
    EXPECT_TRUE(Adx::FileUtils::IsDiskFull(std::string("/home/test"), 0));
    EXPECT_TRUE(Adx::FileUtils::IsDiskFull(std::string("/home/test"), 1024 * 1024 + 1));
    EXPECT_FALSE(Adx::FileUtils::IsDiskFull(std::string("/home/test"), 1024 * 1024));
}

TEST_F(FILE_UTILS_STEST, GetFileDir)
{
    const std::string path = "/home/test/test123.log";
    std::string dir = Adx::FileUtils::GetFileDir(path);
    EXPECT_EQ("/home/test", dir);

    const std::string path1 = "home";
    dir = Adx::FileUtils::GetFileDir(path1);
    EXPECT_EQ("", dir);
}
TEST_F(FILE_UTILS_STEST, GetFileName)
{
    std::string path = "/home/test/test123.log";
    std::string name;
    IdeErrorT err = Adx::FileUtils::GetFileName(path, name);
    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, err);
    EXPECT_STREQ("test123.log", name.c_str());

    path = "home";
    err = Adx::FileUtils::GetFileName(path, name);
    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, err);
    path = "/home/";
    err = Adx::FileUtils::GetFileName(path, name);
    EXPECT_EQ(IDE_DAEMON_INVALID_PATH_ERROR, err);
}
TEST_F(FILE_UTILS_STEST,  CheckNonCrossPath)
{
    EXPECT_EQ(false, Adx::FileUtils::CheckNonCrossPath(""));
    EXPECT_EQ(false, Adx::FileUtils::CheckNonCrossPath("../home/Hw"));
    EXPECT_EQ(false, Adx::FileUtils::CheckNonCrossPath("/home/../Hw"));
    EXPECT_EQ(false, Adx::FileUtils::CheckNonCrossPath("/home/\\.\\./Hw-_?"));
    EXPECT_EQ(true, Adx::FileUtils::CheckNonCrossPath("/home/Hw"));
}

TEST_F(FILE_UTILS_STEST,  IsValidDirChar)
{
    EXPECT_EQ(false, Adx::FileUtils::IsValidDirChar(""));
    EXPECT_EQ(false, Adx::FileUtils::IsValidDirChar("abcde`"));
    EXPECT_EQ(true, Adx::FileUtils::IsValidDirChar("abAb19-_?"));
}
TEST_F(FILE_UTILS_STEST, IpValid)
{
    EXPECT_EQ(false, Adx::StringUtils::IpValid(""));
    EXPECT_EQ(false, Adx::StringUtils::IpValid("127.0.0.1.1"));
    EXPECT_EQ(false, Adx::StringUtils::IpValid("256.1.1.1"));
    EXPECT_EQ(true, Adx::StringUtils::IpValid("127.0.0.1"));
}

TEST_F(FILE_UTILS_STEST, FilePathIsReal)
{
    const std::string path = "/home/test/test123.log";
    std::string dir = Adx::FileUtils::GetFileDir(path);
    std::string path1;
    EXPECT_EQ("/home/test", dir);

    MOCKER(mmRealPath)
        .stubs()
        .will(returnValue(EN_ERROR))
        .then(returnValue(EN_OK));

    EXPECT_EQ(IDE_DAEMON_ERROR, Adx::FileUtils::FilePathIsReal(path, path1));
    EXPECT_EQ(IDE_DAEMON_OK, Adx::FileUtils::FilePathIsReal(path, path1));
}

TEST_F(FILE_UTILS_STEST, FileNameIsReal)
{
    const std::string path = "/home/test/test123.log";
    std::string dir = Adx::FileUtils::GetFileDir(path);
    std::string path1;
    EXPECT_EQ("/home/test", dir);

    MOCKER(mmRealPath)
        .stubs()
        .will(returnValue(EN_ERROR))
        .then(returnValue(EN_OK));

    EXPECT_EQ(IDE_DAEMON_ERROR, Adx::FileUtils::FileNameIsReal(path, path1));
    EXPECT_EQ(IDE_DAEMON_OK, Adx::FileUtils::FileNameIsReal(path, path1));
}

TEST_F(FILE_UTILS_STEST, ReplaceAll)
{
    std::string base = "srcbasesrc";
    std::string src = "src";
    std::string dst = "dst";
    EXPECT_EQ("dstbasedst", Adx::FileUtils::ReplaceAll(base, src, dst));
}
