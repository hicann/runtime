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

#include "log_file_utils.h"
#include "mmpa_api.h"
#include "log_process_util.h"
#include "log_system_api.h"

using namespace Adx;
class LOG_FILE_UTILS_TEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

//test GetDirFileList
typedef int32_t (*callbackptr) (const mmDirent **a, const mmDirent **b);
mmDirent **g_fileListptr = NULL;
mmDirent **g_subdirfileptr = NULL;
unsigned char isFolder = 0x4;
unsigned char isFile = 0x8;
int32_t mmScandirstub1(const char *path, mmDirent ***irent,  Adx::FileFilterFn fileter, callbackptr fun1)
{
    mmDirent **fileListptr = (mmDirent **)malloc(sizeof(mmDirent *)*4);
    mmDirent *fileList = (mmDirent *)malloc(sizeof(mmDirent)*4);
    fileListptr[0] = &fileList[0];
    fileListptr[1] = &fileList[1];
    fileListptr[2] = &fileList[2];
    fileListptr[3] = &fileList[3];

    fileList[0].d_type = isFolder;
    fileList[1].d_type = isFile;
    fileList[2].d_type = isFolder;
    fileList[3].d_type = isFolder;

    memcpy(fileList[0].d_name, "/dir0",6);
    memcpy(fileList[1].d_name, "file1",6);
    memcpy(fileList[2].d_name, ".",2);
    memcpy(fileList[3].d_name, "..",3);

    *irent = fileListptr;
    g_fileListptr = fileListptr;
    return 4;
}

int32_t mmScandirstub2(const char *path, mmDirent *** irent,  Adx::FileFilterFn fileter, callbackptr fun2)
{
    mmDirent **subdirfileptr = (mmDirent **)malloc(sizeof(mmDirent *)*2);
    mmDirent *subdirfile = (mmDirent *)malloc(sizeof(mmDirent)*2);

    subdirfileptr[0] = &subdirfile[0];
    subdirfileptr[1] = &subdirfile[1];

    subdirfile[0].d_type = isFolder;
    subdirfile[1].d_type = isFile;
    memcpy(subdirfile[0].d_name, "/dir0/tmp",10);
    memcpy(subdirfile[1].d_name, "/dir0/subfile1",15);

    *irent = subdirfileptr;
    g_subdirfileptr = subdirfileptr;
    return 2;

}

void mmScandirFreestub(mmDirent **fileList, int32_t foundNum)
{
    if(g_fileListptr != NULL) {
        free(g_fileListptr[0]);
        free(g_fileListptr);
        g_fileListptr = NULL;
    }

    if(g_subdirfileptr != NULL) {
        free(g_subdirfileptr[0]);
        free(g_subdirfileptr);
        g_subdirfileptr = NULL;
    }
}

TEST_F(LOG_FILE_UTILS_TEST, CreateDirLog)
{
    EXPECT_EQ(IDE_DAEMON_INVALID_PATH_ERROR, Adx::LogFileUtils::CreateDir(""));
    MOCKER(Adx::LogFileUtils::IsFileExist)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, Adx::LogFileUtils::CreateDir("/home/test"));
    GlobalMockObject::verify();

    MOCKER(mmMkdir)
        .stubs()
        .will(returnValue(EN_ERR));
    MOCKER(Adx::LogFileUtils::IsFileExist)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true))
        .then(returnValue(false));
    EXPECT_EQ(IDE_DAEMON_MKDIR_ERROR, Adx::LogFileUtils::CreateDir("/home/test"));
    GlobalMockObject::verify();

    MOCKER(Adx::LogFileUtils::IsFileExist)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(false))
        .then(returnValue(true));

    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, Adx::LogFileUtils::CreateDir("/home/test"));
    GlobalMockObject::verify();
}

TEST_F(LOG_FILE_UTILS_TEST, IsDirExistLog)
{
    std::string path;
    EXPECT_FALSE(Adx::LogFileUtils::IsDirExist(path));

    MOCKER(mmAccess2)
        .stubs()
        .will(returnValue(EN_ERR))
        .then(returnValue(EN_OK));

    MOCKER(mmIsDir)
            .stubs()
            .will(returnValue(EN_ERR))
            .then(returnValue(EN_OK));

    path = "/home/test";
    EXPECT_FALSE(Adx::LogFileUtils::IsDirExist(path));
    EXPECT_FALSE(Adx::LogFileUtils::IsDirExist(path));
    EXPECT_TRUE(Adx::LogFileUtils::IsDirExist(path));
}


TEST_F(LOG_FILE_UTILS_TEST, IsFileExistLog)
{
    std::string path;
    EXPECT_FALSE(Adx::LogFileUtils::IsFileExist(path));

    MOCKER(mmAccess)
        .stubs()
        .will(returnValue(EN_ERR))
        .then(returnValue(EN_OK));

    path = "/home/test";
    EXPECT_FALSE(Adx::LogFileUtils::IsFileExist(path));
    EXPECT_TRUE(Adx::LogFileUtils::IsFileExist(path));
}

TEST_F(LOG_FILE_UTILS_TEST, GetFileDirLog)
{
    const std::string path = "/home/test/test123.log";
    std::string dir = Adx::LogFileUtils::GetFileDir(path);
    EXPECT_EQ("/home/test", dir);

    const std::string path1 = "home";
    dir = Adx::LogFileUtils::GetFileDir(path1);
    EXPECT_EQ("", dir);
}

TEST_F(LOG_FILE_UTILS_TEST, GetFileNameLog)
{
    std::string path = "/home/test/test123.log";
    std::string name;
    IdeErrorT err = Adx::LogFileUtils::GetFileName(path, name);
    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, err);
    EXPECT_STREQ("test123.log", name.c_str());

    path = "home";
    err = Adx::LogFileUtils::GetFileName(path, name);
    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, err);
    path = "/home/";
    err = Adx::LogFileUtils::GetFileName(path, name);
    EXPECT_EQ(IDE_DAEMON_INVALID_PATH_ERROR, err);
}

TEST_F(LOG_FILE_UTILS_TEST, IsDirectoryLog)
{
    std::string dir;

    MOCKER(mmIsDir)
        .stubs()
        .will(returnValue(EN_ERR))
        .then(returnValue(EN_OK));

    EXPECT_FALSE(Adx::LogFileUtils::IsDirectory(dir));
    EXPECT_FALSE(Adx::LogFileUtils::IsDirectory(std::string("/home/test")));
    EXPECT_TRUE(Adx::LogFileUtils::IsDirectory(std::string("/home/test")));
}


TEST_F(LOG_FILE_UTILS_TEST, CopyFileAndRenameLog)
{
    MOCKER(AdxCreateProcess)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));
    std::string empt;
    std::string srcStr = "/home/HwHiAiUser/ide_daemon/abc";
    std::string desStr = "/home/HwHiAiUser/ide_daemon/cdf";
    //invalid
    EXPECT_EQ(IDE_DAEMON_INVALID_PATH_ERROR, Adx::LogFileUtils::CopyFileAndRename(empt, desStr));
    //invalid
    EXPECT_EQ(IDE_DAEMON_INVALID_PATH_ERROR, Adx::LogFileUtils::CopyFileAndRename(srcStr, empt));
    //AdxCreateProcess error
    EXPECT_EQ(IDE_DAEMON_UNKNOW_ERROR, Adx::LogFileUtils::CopyFileAndRename(srcStr, desStr));
    //ok
    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, Adx::LogFileUtils::CopyFileAndRename(srcStr, desStr));
}

TEST_F(LOG_FILE_UTILS_TEST, FilePathIsRealLog)
{
    const std::string path = "/home/test/test123.log";
    std::string dir = Adx::LogFileUtils::GetFileDir(path);
    std::string path1;
    EXPECT_EQ("/home/test", dir);

    MOCKER(mmRealPath)
        .stubs()
        .will(returnValue(EN_ERROR))
        .then(returnValue(EN_OK));

    EXPECT_EQ(IDE_DAEMON_ERROR, Adx::LogFileUtils::FilePathIsReal(path, path1));
    EXPECT_EQ(IDE_DAEMON_OK, Adx::LogFileUtils::FilePathIsReal(path, path1));
}

TEST_F(LOG_FILE_UTILS_TEST, FileNameIsRealLog)
{
    const std::string path = "/home/test/test123.log";
    std::string dir = Adx::LogFileUtils::GetFileDir(path);
    std::string path1;
    EXPECT_EQ("/home/test", dir);

    MOCKER(mmRealPath)
        .stubs()
        .will(returnValue(EN_ERROR))
        .then(returnValue(EN_OK));

    EXPECT_EQ(IDE_DAEMON_ERROR, Adx::LogFileUtils::FileNameIsReal(path, path1));
    EXPECT_EQ(IDE_DAEMON_OK, Adx::LogFileUtils::FileNameIsReal(path, path1));
}

TEST_F(LOG_FILE_UTILS_TEST, StartsWithLog)
{
    const std::string path = "/home/test/test123.log";
    const std::string subpath = "/home";

    EXPECT_EQ(true, Adx::LogFileUtils::StartsWith(path, subpath));
}

TEST_F(LOG_FILE_UTILS_TEST, EndsWithLog)
{
    const std::string path = "/home/test/test123";
    const std::string subpath = "test123";

    EXPECT_EQ(true, Adx::LogFileUtils::EndsWith(path, subpath));
}

TEST_F(LOG_FILE_UTILS_TEST, GetDirFileListLog)
{
    const std::string path = "/home";
    std::vector<std::string> list;

    MOCKER(mmScandir)
        .stubs()
        .will(invoke(mmScandirstub1))
        .then(invoke(mmScandirstub2));

    MOCKER(mmScandirFree)
        .stubs()
        .will(invoke(mmScandirFreestub));

    EXPECT_EQ(true, Adx::LogFileUtils::GetDirFileList(path, list, NULL, "", 0));
}

TEST_F(LOG_FILE_UTILS_TEST, IsAccessibleLog)
{
    std::string path;
    MOCKER(mmAccess2)
        .stubs()
        .will(returnValue(EN_ERR))
        .then(returnValue(EN_OK));

    path = "";
    EXPECT_FALSE(Adx::LogFileUtils::IsAccessible(path));
    path = "/home/test";
    EXPECT_FALSE(Adx::LogFileUtils::IsAccessible(path));
    EXPECT_TRUE(Adx::LogFileUtils::IsAccessible(path));
}

TEST_F(LOG_FILE_UTILS_TEST, RemoveDir)
{
    system("mkdir -p /tmp/hdclog_host_utest/dir1/dir2/dir3");
    system("touch /tmp/hdclog_host_utest/dir1/dir2/dir3/test.txt");
    std::string dirName("/tmp/hdclog_host_utest");
    EXPECT_EQ(0, LogFileUtils::RemoveDir(dirName, 0));
    EXPECT_EQ(EN_ERROR, access(dirName.c_str(), R_OK));

    system("mkdir -p /tmp/hdclog_host_utest/dir1/dir2/dir3");
    MOCKER(rmdir).stubs().will(returnValue(-1));
    EXPECT_EQ(SYS_ERROR, LogFileUtils::RemoveDir(dirName, 0));

    system("mkdir -p /tmp/hdclog_host_utest/dir1/dir2/dir3/dir4/dir5/dir6/dir7");
    EXPECT_EQ(SYS_ERROR, LogFileUtils::RemoveDir(dirName, 0));          // max recursion 6 level
    MOCKER(lstat).stubs().will(returnValue(-1));
    EXPECT_EQ(SYS_ERROR, LogFileUtils::RemoveDir(dirName, 0));
    system("rm -r /tmp/hdclog_host_utest");
}
