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

class COMMON_UTILS_UTILS_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
private:
    std::string _log_file;
};

TEST_F(COMMON_UTILS_UTILS_TEST, GetCPUCycleCounter) {
    GlobalMockObject::verify();
    EXPECT_NE((unsigned long long)0, Utils::GetCPUCycleCounter());
}

TEST_F(COMMON_UTILS_UTILS_TEST, GetClockRealtime) {
    GlobalMockObject::verify();

    EXPECT_NE((unsigned long long)0, Utils::GetClockRealtime());
}

TEST_F(COMMON_UTILS_UTILS_TEST, GetClockMonotonicRaw) {
    GlobalMockObject::verify();

    EXPECT_NE((unsigned long long)0, Utils::GetClockMonotonicRaw());
}

TEST_F(COMMON_UTILS_UTILS_TEST, GetCoresStr)
{
    GlobalMockObject::verify();
    std::vector<int> cores(10, 5);
    std::string ret = Utils::GetCoresStr(cores); 
    EXPECT_STREQ("5,5,5,5,5,5,5,5,5,5", ret.c_str());
    std::cout<<ret<<std::endl;
}

TEST_F(COMMON_UTILS_UTILS_TEST, GetEventsStr)
{
    GlobalMockObject::verify();
   
    std::vector<std::string> cores(10, "123");
    
    std::string ret = Utils::GetEventsStr(cores);
    EXPECT_STREQ("123,123,123,123,123,123,123,123,123,123", ret.c_str());
    std::cout<<ret<<std::endl;
}

TEST_F(COMMON_UTILS_UTILS_TEST, GetFileSize) {
    GlobalMockObject::verify();

    std::string path = "./not_exist/path";
    EXPECT_NE(PROFILING_SUCCESS, Utils::GetFileSize(path));

    path = "./COMMON_UTILS_UTILS_TEST-GetEventsStr-file_existing";
    std::ofstream out;
    out.open(path.c_str(), std::ios::app | std::ios::out);
    out << "this is test" << std::endl << std::flush;
    out.close();

    EXPECT_NE(0, Utils::GetFileSize(path));

    ::remove(path.c_str());
}

TEST_F(COMMON_UTILS_UTILS_TEST, IsDir) {
    GlobalMockObject::verify();

    //empty path
    std::string path;
    EXPECT_FALSE(Utils::IsDir(path));

    path = "/path/to/fake_dir";

    MOCKER(mmIsDir)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    EXPECT_FALSE(Utils::IsDir(path));
    EXPECT_TRUE(Utils::IsDir(path));
}

TEST_F(COMMON_UTILS_UTILS_TEST, IsFileExist) {
    GlobalMockObject::verify();
    std::string path;
    EXPECT_FALSE(Utils::IsFileExist(path));

    GlobalMockObject::verify();
    path = "./file_not_existing";
    EXPECT_FALSE(Utils::IsFileExist(path));

    path = "./COMMON_UTILS_UTILS_TEST-IsFileExist-file_existing";
    std::ofstream out;
    out.open(path.c_str(), std::ios::app | std::ios::out);
    EXPECT_TRUE(Utils::IsFileExist(path));
    out.close();
    ::remove(path.c_str());
}

TEST_F(COMMON_UTILS_UTILS_TEST, SplitPath) {
    GlobalMockObject::verify();

    std::string path = "path/to/file";
    std::string dir;
    std::string base;

    MOCKER(strdup)
        .stubs()
        .with(any())
        .will(returnValue((char*)NULL));

    EXPECT_EQ(PROFILING_FAILED, Utils::SplitPath(path, dir, base));

    GlobalMockObject::verify();
    MOCKER(dirname)
        .stubs()
        .with(any())
        .will(returnValue((char*)NULL));
    EXPECT_EQ(PROFILING_FAILED, Utils::SplitPath(path, dir, base));

    GlobalMockObject::verify();
    MOCKER(basename)
        .stubs()
        .with(any())
        .will(returnValue((char*)NULL));
    EXPECT_EQ(PROFILING_FAILED, Utils::SplitPath(path, dir, base));

    GlobalMockObject::verify();
    EXPECT_EQ(PROFILING_SUCCESS, Utils::SplitPath(path, dir, base));
    EXPECT_STREQ(dir.c_str(), "path/to");
    EXPECT_STREQ(base.c_str(), "file");

    GlobalMockObject::verify();
    path = "file";
    EXPECT_EQ(PROFILING_SUCCESS, Utils::SplitPath(path, dir, base));
    EXPECT_STREQ(dir.c_str(), ".");
    EXPECT_STREQ(base.c_str(), "file");
}

TEST_F(COMMON_UTILS_UTILS_TEST, RelativePath) {
    GlobalMockObject::verify();

    std::string path = "path/to/file";
    std::string dir = "path";
    std::string relative_path;
    EXPECT_EQ(PROFILING_SUCCESS, Utils::RelativePath(path, dir, relative_path));
    EXPECT_STREQ(relative_path.c_str(), "to/file");

    path = "path/to/file";
    dir = "otherdir";
    EXPECT_EQ(PROFILING_FAILED, Utils::RelativePath(path, dir, relative_path));
}

TEST_F(COMMON_UTILS_UTILS_TEST, get_files_empty_path) {
    GlobalMockObject::verify();

    std::string path;
    std::vector<std::string> files;
    Utils::GetFiles(path, true, files, 0);
    EXPECT_EQ(0, files.size());
}

TEST_F(COMMON_UTILS_UTILS_TEST, get_files_out_range_of_depth) {
    GlobalMockObject::verify();
    std::string path = "/path/to/dir";
    std::vector<std::string> files;
    Utils::GetFiles(path, true, files, 11);
    EXPECT_EQ(0, files.size());
}

TEST_F(COMMON_UTILS_UTILS_TEST, get_files_scan_dir_fail) {
    GlobalMockObject::verify();

    std::string path = "/path/to/dir";
    std::vector<std::string> files;
    MOCKER(mmScandir)
        .stubs()
        .with(any(), any(), any(), any())
        .will(returnValue(0));

    Utils::GetFiles(path, true, files, 0);
    EXPECT_EQ(0, files.size());
}

TEST_F(COMMON_UTILS_UTILS_TEST, get_files_recur) {
    GlobalMockObject::verify();

    std::string path = "/path/to/dir";
    std::vector<std::string> files;

    mmDirent entry1;
    entry1.d_name[0] = '.';
    entry1.d_name[1] = '\0';

    mmDirent entry2;
    entry2.d_name[0] = '.';
    entry2.d_name[1] = '.';
    entry2.d_name[2] = '\0';

    mmDirent entry3;
    entry3.d_name[0] = 'f';
    entry3.d_name[1] = '\0';

    mmDirent entry4;
    entry4.d_name[0] = 'd';
    entry4.d_name[1] = '\0';

    mmDirent *name_list[4];
    name_list[0] = &entry1;
    name_list[1] = &entry2;
    name_list[2] = &entry3;
    name_list[3] = &entry4;
    mmDirent **p_name_list = name_list;

    MOCKER(mmScandir)
        .stubs()
        .with(any(), outBoundP(&p_name_list), any(), any())
        .will(returnValue(4));

    MOCKER(Utils::IsDir)
        .stubs()
        .with(any())
        .will(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(false));

    MOCKER(mmScandirFree)
        .stubs()
        .with(any(), any())
        .will(returnValue(0));

    Utils::GetFiles(path, true, files, 0);
    EXPECT_EQ(5, files.size());
}

TEST_F(COMMON_UTILS_UTILS_TEST, get_files_non_recur) {
    GlobalMockObject::verify();

    std::string path = "/path/to/dir";
    std::vector<std::string> files;

    mmDirent entry1;
    entry1.d_name[0] = '.';
    entry1.d_name[1] = '\0';

    mmDirent entry2;
    entry2.d_name[0] = '.';
    entry2.d_name[1] = '.';
    entry2.d_name[2] = '\0';

    mmDirent entry3;
    entry3.d_name[0] = 'f';
    entry3.d_name[1] = '\0';

    mmDirent entry4;
    entry4.d_name[0] = 'd';
    entry4.d_name[1] = '\0';

    mmDirent *name_list[4];
    name_list[0] = &entry1;
    name_list[1] = &entry2;
    name_list[2] = &entry3;
    name_list[3] = &entry4;
    mmDirent **p_name_list = name_list;

    MOCKER(mmScandir)
        .stubs()
        .with(any(), outBoundP(&p_name_list), any(), any())
        .will(returnValue(4));

    MOCKER(Utils::IsDir)
        .stubs()
        .with(any())
        .will(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(false));

    MOCKER(mmScandirFree)
        .stubs()
        .with(any(), any())
        .will(returnValue(0));

    Utils::GetFiles(path, false, files, 0);
    EXPECT_EQ(1, files.size());
}

TEST_F(COMMON_UTILS_UTILS_TEST, CreateDir_exist) {
    GlobalMockObject::verify();

    std::string path;
    EXPECT_EQ(PROFILING_FAILED, Utils::CreateDir(path));

    path = "/path/to/dir/sub-dir";
    MOCKER(access)
        .stubs()
        .with(any(), any())
        .will(returnValue(0));

    EXPECT_EQ(PROFILING_SUCCESS, Utils::CreateDir(path));
}

TEST_F(COMMON_UTILS_UTILS_TEST, CreateDir_exist_fail) {
    GlobalMockObject::verify();

    MOCKER(Utils::IsFileExist)
        .stubs()
        .will(returnValue(false))
        .then(returnValue(true));

    std::string path;
    path = "/tmp/profiling-CreateDir_exist_fail";
    system("mkdir -p /tmp/profiling-CreateDir_exist_fail");
    EXPECT_EQ(PROFILING_SUCCESS, Utils::CreateDir(path));
    Utils::RemoveDir(path);
}

TEST_F(COMMON_UTILS_UTILS_TEST, CreateDir_not_exist_fail) {
    GlobalMockObject::verify();

    std::string path;
    EXPECT_EQ(PROFILING_FAILED, Utils::CreateDir(path));

    path = "./path/to/dir/sub-dir";

    MOCKER(Utils::SplitPath)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    MOCKER(mmMkdir)
        .stubs()
        .with(any(), any())
        .will(returnValue(-1));
    MOCKER(mmChmod)
        .stubs()
        .will(returnValue(-1));

    EXPECT_EQ(PROFILING_FAILED, Utils::CreateDir(path));
    EXPECT_EQ(PROFILING_FAILED, Utils::CreateDir(path));
    EXPECT_EQ(PROFILING_FAILED, Utils::CreateDir(path));
}

TEST_F(COMMON_UTILS_UTILS_TEST, CreateDir_mkdir_fail) {
    GlobalMockObject::verify();

    std::string path;
    EXPECT_EQ(PROFILING_FAILED, Utils::CreateDir(path));

    path = "./path_CreateDir";

    MOCKER(mmMkdir)
        .stubs()
        .with(any(), any())
        .will(returnValue(-1));

    EXPECT_EQ(PROFILING_FAILED, Utils::CreateDir(path));
}

TEST_F(COMMON_UTILS_UTILS_TEST, CreateDir_not_exist_success) {
    GlobalMockObject::verify();

    std::string path;
    EXPECT_EQ(PROFILING_FAILED, Utils::CreateDir(path));

    path = "/path/to/dir/sub-dir";
    MOCKER(access)
        .stubs()
        .with(any(), any())
        .will(returnValue(-1))
        .then(returnValue(0));

    MOCKER(mmMkdir)
        .stubs()
        .with(any(), any())
        .will(returnValue(0));

    EXPECT_EQ(PROFILING_SUCCESS, Utils::CreateDir(path));
}

int32_t g_rmDir = 0;
INT32 mmRmdirStub(const CHAR *lpPathName)
{
    g_rmDir++;
    if (g_rmDir == 1) {
        return -1;
    }
    return 0;
}

TEST_F(COMMON_UTILS_UTILS_TEST, RemoveDir) {
    GlobalMockObject::verify();

    std::string path;
    Utils::RemoveDir(path);

    path = "/";
    Utils::RemoveDir(path);

    path = "/path/to/dir";
    MOCKER(mmRmdir)
        .stubs()
        .with(any())
        .will(invoke(mmRmdirStub));

    Utils::RemoveDir(path);
    EXPECT_EQ(g_rmDir, 1);
    Utils::RemoveDir(path);
    EXPECT_EQ(g_rmDir, 2);
    // OsalScandir failed
    Utils::RemoveDir(path, false);
    EXPECT_EQ(g_rmDir, 2);
    // nameList is nullptr
    MOCKER(OsalScandir)
        .stubs()
        .with(any(), any(), any(), any())
        .will(returnValue(0));
    Utils::RemoveDir(path, false);
    EXPECT_EQ(g_rmDir, 2);
}

TEST_F(COMMON_UTILS_UTILS_TEST, RemoveDir_not_rm_top_dir) {
    GlobalMockObject::verify();

    std::string path = "/path/to/dir";
    mmDirent entry1;
    entry1.d_name[0] = '.';
    entry1.d_name[1] = '\0';

    mmDirent entry2;
    entry2.d_name[0] = '.';
    entry2.d_name[1] = '.';
    entry2.d_name[2] = '\0';

    mmDirent entry3;
    entry3.d_name[0] = 'f';
    entry3.d_name[1] = '\0';

    mmDirent entry4;
    entry4.d_name[0] = 'd';
    entry4.d_name[1] = '\0';

    mmDirent *name_list[4];
    name_list[0] = &entry1;
    name_list[1] = &entry2;
    name_list[2] = &entry3;
    name_list[3] = &entry4;
    mmDirent **p_name_list = name_list;

    MOCKER(mmScandir)
        .stubs()
        .with(any(), outBoundP(&p_name_list), any(), any())
        .will(returnValue(-1))
        .then(returnValue(4));

    MOCKER(Utils::IsDir)
        .stubs()
        .with(any())
        .will(returnValue(true))
        .then(returnValue(false));

    MOCKER(mmScandirFree)
        .stubs()
        .with(any(), any())
        .will(returnValue(0));

    MOCKER(mmRmdir)
        .stubs()
        .will(invoke(mmRmdirStub));

    MOCKER(mmUnlink)
        .stubs()
        .will(returnValue(0));

    Utils::RemoveDir(path, false);
    EXPECT_EQ(g_rmDir, 2);
    Utils::RemoveDir(path, false);
    EXPECT_EQ(g_rmDir, 3);
}

TEST_F(COMMON_UTILS_UTILS_TEST, CanonicalizePath) {
    GlobalMockObject::verify();

    //empty path
    std::string path;
    EXPECT_STREQ("", Utils::CanonicalizePath(path).c_str());

    //max len
    path.append(PATH_MAX + 1, 'a');
    EXPECT_STREQ("", Utils::CanonicalizePath(path).c_str());

    //realpath
    path = "/path/to/fake";
    std::string real_path = "/path/to/real";
    char* real_path_buffer = (char*)malloc(4096);
    memset_s(real_path_buffer, 4096, 0, 4096);
    strcpy_s(real_path_buffer, 4095, real_path.c_str());

    MOCKER(mmRealPath)
        .stubs()
        .with(any(), outBoundP(real_path_buffer, 4096), outBound(4096))
        .will(returnValue(0))
        .then(returnValue(-1));

    EXPECT_STREQ(real_path.c_str(), Utils::CanonicalizePath(path).c_str());
    EXPECT_STREQ("", Utils::CanonicalizePath(path).c_str());
    free(real_path_buffer);
}

TEST_F(COMMON_UTILS_UTILS_TEST, IsSoftLink) {
    GlobalMockObject::verify();

    system("touch /tmp/test_file");
    system("ln -s /tmp/test_file /tmp/softlink_test_file ");

    //empty path
    std::string path;
    EXPECT_EQ(true, Utils::IsSoftLink(path));
    EXPECT_EQ(false, Utils::IsSoftLink("/tmp/test_file"));
    EXPECT_EQ(true, Utils::IsSoftLink("/tmp/softlink_test_file"));

    system("rm /tmp/test_file");
    system("rm /tmp/softlink_test_file");
}

TEST_F(COMMON_UTILS_UTILS_TEST, exec_cmd_cpp_failed) {
    GlobalMockObject::verify();

    std::string cmd = "ls";

    std::vector<std::string> argv;
    argv.push_back("/");

    std::vector<std::string> envp(1024*1024+1);

    pid_t child;

    int exitCode = -1;

    ExecCmdParams execCmdParams(cmd, true, "");
    EXPECT_EQ(PROFILING_FAILED, Utils::ExecCmd(execCmdParams, argv, envp, exitCode, child));
}

TEST_F(COMMON_UTILS_UTILS_TEST, exec_cmd_cpp) {
    GlobalMockObject::verify();

    std::string cmd = "ls";

    std::vector<std::string> argv;
    argv.push_back("/");

    std::vector<std::string> envp;
    envp.push_back("PATH=/usr/bin:/usr/sbin");

    MOCKER(mmCreateProcess)
        .stubs()
        .will(returnValue(-1));

    pid_t child;
    int exitCode = -1;
    ExecCmdParams execCmdParams(cmd, true, "");
    EXPECT_EQ(PROFILING_FAILED, Utils::ExecCmd(execCmdParams, argv, envp, exitCode, child));

    exitCode = 0;
    ExecCmdParams execCmdParams1(cmd, false, "");
    EXPECT_EQ(PROFILING_FAILED, Utils::ExecCmd(execCmdParams1, argv, envp, exitCode, child));
}

TEST_F(COMMON_UTILS_UTILS_TEST, exec_cmd_c) {
    GlobalMockObject::verify();

    const std::string filename = "/path/to/cmd";
    int exit_code = 0;
    char * argv[1];
    char * envp[1];
    ExecCmdParams execCmdParams("", false, "");
    ExecCmdArgv execCmdArgv(argv, 1, envp, 1);
    EXPECT_EQ(PROFILING_FAILED, Utils::ExecCmdC(execCmdArgv, execCmdParams, exit_code));

    ExecCmdParams execCmdParams1(filename, false, "");
    ExecCmdArgv execCmdArgv1(NULL, 0, envp, 1);
    EXPECT_EQ(PROFILING_FAILED, Utils::ExecCmdC(execCmdArgv1, execCmdParams1, exit_code));

    ExecCmdArgv execCmdArgv2(argv, 1, NULL, 0);
    EXPECT_EQ(PROFILING_FAILED, Utils::ExecCmdC(execCmdArgv2, execCmdParams1, exit_code));

    MOCKER(mmWaitPid).stubs().will(returnValue(EN_OK));
    exit_code = 0;
    ExecCmdArgv execCmdArgv3(argv, 1, envp, 1);
    EXPECT_EQ(PROFILING_FAILED, Utils::ExecCmdC(execCmdArgv3, execCmdParams1, exit_code));

    GlobalMockObject::verify();

    std::string stdout_redirect_file = "./exec_cmd_c_child_redirect_file";

    MOCKER(mmCreateProcess)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    MOCKER(mmWaitPid)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    MOCKER(Utils::WaitProcess)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    ExecCmdParams execCmdParams2(filename, false, stdout_redirect_file);
    ExecCmdArgv execCmdArgv4(argv, 1, envp, 1);
    EXPECT_EQ(PROFILING_FAILED, Utils::ExecCmdC(execCmdArgv4, execCmdParams2, exit_code));
    EXPECT_EQ(PROFILING_FAILED, Utils::ExecCmdC(execCmdArgv4, execCmdParams2, exit_code));
    EXPECT_EQ(PROFILING_SUCCESS, Utils::ExecCmdC(execCmdArgv4, execCmdParams2, exit_code));
    EXPECT_EQ(PROFILING_SUCCESS, Utils::ExecCmdC(execCmdArgv4, execCmdParams2, exit_code));
}

TEST_F(COMMON_UTILS_UTILS_TEST, exec_cmd_async_c) {
    GlobalMockObject::verify();

    const std::string filename = "/path/to/cmd";
    char * argv[1];
    char * envp[1];
    pid_t child = 0;
    ExecCmdParams execCmdParams("", true, "");
    ExecCmdArgv execCmdArgv(argv, 1, envp, 1);
    EXPECT_EQ(PROFILING_FAILED, Utils::ExecCmdCAsync(execCmdArgv, execCmdParams, child));

    ExecCmdParams execCmdParams1(filename, true, "");
    ExecCmdArgv execCmdArgv1(NULL, 0, envp, 1);
    EXPECT_EQ(PROFILING_FAILED, Utils::ExecCmdCAsync(execCmdArgv1, execCmdParams1, child));

    ExecCmdArgv execCmdArgv2(argv, 1, NULL, 0);
    EXPECT_EQ(PROFILING_FAILED, Utils::ExecCmdCAsync(execCmdArgv2, execCmdParams1, child));

    GlobalMockObject::verify();

    std::string stdout_redirect_file = "./exec_cmd_c_child_redirect_file";

    MOCKER(mmCreateProcess)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(-1));

    ExecCmdParams execCmdParams2(filename, true, "");
    ExecCmdArgv execCmdArgv4(argv, 1, envp, 1);
    EXPECT_EQ(PROFILING_SUCCESS, Utils::ExecCmdCAsync(execCmdArgv4, execCmdParams2, child));

    ExecCmdParams execCmdParams3(filename, true, stdout_redirect_file);
    EXPECT_EQ(PROFILING_FAILED, Utils::ExecCmdCAsync(execCmdArgv4, execCmdParams3, child));
}

TEST_F(COMMON_UTILS_UTILS_TEST, wait_process_no_hang) {
    GlobalMockObject::verify();

    pid_t process = 0;
    bool is_exited = false;
    int exit_code = 0;
    bool hang = false;

    MOCKER(mmWaitPid)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(-1));

    EXPECT_EQ(PROFILING_SUCCESS, Utils::WaitProcess(process, is_exited, exit_code, hang));
    EXPECT_EQ(PROFILING_FAILED, Utils::WaitProcess(process, is_exited, exit_code, hang));

    GlobalMockObject::verify();

    MOCKER(mmWaitPid)
        .stubs()
        .will(returnValue(EN_ERR));

    EXPECT_EQ(PROFILING_SUCCESS, Utils::WaitProcess(process, is_exited, exit_code, hang));
}

TEST_F(COMMON_UTILS_UTILS_TEST, wait_process_hang) {
    GlobalMockObject::verify();

    pid_t process = 1234;
    bool is_exited = false;
    int exit_code = 0;
    bool hang = true;

    //WIFEXITED
    int wait_status = 0;
    MOCKER(mmWaitPid)
        .stubs()
        .with(any(), outBoundP(&wait_status), any())
        .will(returnValue(1234));

    EXPECT_EQ(PROFILING_FAILED, Utils::WaitProcess(process, is_exited, exit_code, hang));
}

TEST_F(COMMON_UTILS_UTILS_TEST, ProcessIsRuning) {
    GlobalMockObject::verify();

    pid_t process = 1234;

    MOCKER(mmWaitPid)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    EXPECT_EQ(false, Utils::ProcessIsRuning(process));
    EXPECT_EQ(true, Utils::ProcessIsRuning(process));
}

TEST_F(COMMON_UTILS_UTILS_TEST, JoinPath) {
    GlobalMockObject::verify();

    std::vector<std::string> paths;
    //size = 0
    EXPECT_STREQ("", Utils::JoinPath(paths).c_str());

    //size = 1
    paths.push_back("/p1");
    EXPECT_STREQ("/p1", Utils::JoinPath(paths).c_str());

    //size = 2
    paths.push_back("p2");
    EXPECT_STREQ("/p1/p2", Utils::JoinPath(paths).c_str());
}

TEST_F(COMMON_UTILS_UTILS_TEST, LeftTrim) {
    GlobalMockObject::verify();

    //size = 0
    std::string str0;
    EXPECT_STREQ("", Utils::LeftTrim(str0, "\r\n").c_str());

    //size != 0
    std::string str1 = "\r\nabc";
    EXPECT_STREQ("abc", Utils::LeftTrim(str1, "\r\n").c_str());

    //size != 0
    std::string str2 = "\r\n";
    EXPECT_STREQ("", Utils::LeftTrim(str2, "\r\n").c_str());

    //size != 0
    std::string str3 = "abc";
    EXPECT_STREQ("abc", Utils::LeftTrim(str3, "\r\n").c_str());
}

TEST_F(COMMON_UTILS_UTILS_TEST, Trim) {
    GlobalMockObject::verify();

    //size = 0
    std::string str0;
    EXPECT_STREQ("", Utils::Trim(str0).c_str());

    //size != 0
    std::string str1 = "    ";
    EXPECT_STREQ("", Utils::Trim(str1).c_str());

    //size != 0
    std::string str2 = "   abc   ";
    EXPECT_STREQ("abc", Utils::Trim(str2).c_str());

    //size != 0
    std::string str3 = "  a b c ";
    EXPECT_STREQ("a b c", Utils::Trim(str3).c_str());
}

TEST_F(COMMON_UTILS_UTILS_TEST, Split) {
    GlobalMockObject::verify();

    //filter = true
    std::string str0 = "a,b,c";
    std::vector<std::string> out0 = Utils::Split(str0, true, "b", ",");

    EXPECT_EQ(2, out0.size());
    EXPECT_STREQ("a", out0[0].c_str());
    EXPECT_STREQ("c", out0[1].c_str());

    std::vector<std::string> out1 = Utils::Split(str0, false, "b", ",");
    EXPECT_EQ(3, out1.size());
    EXPECT_STREQ("a", out1[0].c_str());
    EXPECT_STREQ("b", out1[1].c_str());
    EXPECT_STREQ("c", out1[2].c_str());
}

TEST_F(COMMON_UTILS_UTILS_TEST, ToUpper) {
    GlobalMockObject::verify();

    EXPECT_STREQ("ABC", Utils::ToUpper("aBc").c_str());
    EXPECT_STREQ("", Utils::ToUpper("").c_str());
}

TEST_F(COMMON_UTILS_UTILS_TEST, ToLower) {
    GlobalMockObject::verify();

    EXPECT_STREQ("abc", Utils::ToLower("aBc").c_str());
    EXPECT_STREQ("", Utils::ToLower("").c_str());
}

TEST_F(COMMON_UTILS_UTILS_TEST, UsleepInterupt) {
    GlobalMockObject::verify();

    EXPECT_EQ(0, Utils::UsleepInterupt(1));
}

TEST_F(COMMON_UTILS_UTILS_TEST, UtilsStringBuilder) {
    GlobalMockObject::verify();

    UtilsStringBuilder<std::string> builder;
    std::vector<std::string> elems;
    std::string sep = ",";

    //no elements
    EXPECT_STREQ("", builder.Join(elems, sep).c_str());

    //one elements
    elems.push_back("a");
    EXPECT_STREQ("a", builder.Join(elems, sep).c_str());

    //multiple elements
    elems.push_back("b");
    EXPECT_STREQ("a,b", builder.Join(elems, sep).c_str());
}

///////////////////////////////////////////////////////////

TEST_F(COMMON_UTILS_UTILS_TEST, get_child_dirs_scan_dir_fail) {
    GlobalMockObject::verify();

    std::string dir("/tmp/get_child_dirs_scan_dir_fail");
    bool is_recur = false;
    std::vector<std::string> child_dir;

    MOCKER(mmScandir)
        .stubs()
        .with(any(), any(), any(), any())
        .will(returnValue(0));

    Utils::GetChildDirs(dir, is_recur, child_dir, 0);
    EXPECT_EQ(0, child_dir.size());

}

TEST_F(COMMON_UTILS_UTILS_TEST, get_child_dirs_out_range_of_depth) {
    GlobalMockObject::verify();
    std::string dir("/tmp/get_child_dirs_scan_dir_fail");
    bool is_recur = false;
    std::vector<std::string> child_dir;
    Utils::GetChildDirs(dir, is_recur, child_dir, 11);
    EXPECT_EQ(0, child_dir.size());
}

TEST_F(COMMON_UTILS_UTILS_TEST, get_child_dirs_recur) {
    GlobalMockObject::verify();

    std::string path = "/path/to/dir";
    bool is_recur = true;
    std::vector<std::string> child_dirs;

    mmDirent entry1;
    entry1.d_name[0] = '.';
    entry1.d_name[1] = '\0';

    mmDirent entry2;
    entry2.d_name[0] = '.';
    entry2.d_name[1] = '.';
    entry2.d_name[2] = '\0';

    mmDirent entry3;
    entry3.d_name[0] = 'f';
    entry3.d_name[1] = '\0';

    mmDirent entry4;
    entry4.d_name[0] = 'd';
    entry4.d_name[1] = '\0';

    mmDirent *name_list[4];
    name_list[0] = &entry1;
    name_list[1] = &entry2;
    name_list[2] = &entry3;
    name_list[3] = &entry4;
    mmDirent **p_name_list = name_list;

    MOCKER(mmScandir)
        .stubs()
        .with(any(), outBoundP(&p_name_list), any(), any())
        .will(returnValue(4));

    MOCKER(Utils::IsDir)
        .stubs()
        .with(any())
        .will(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(false));

    MOCKER(mmScandirFree)
        .stubs()
        .with(any(), any())
        .will(returnValue(0));

    Utils::GetChildDirs(path, is_recur, child_dirs, 0);
    EXPECT_EQ(1, child_dirs.size());
}

TEST_F(COMMON_UTILS_UTILS_TEST, get_child_dirs_no_recur) {
    GlobalMockObject::verify();

    std::string path = "/path/to/dir";
    bool is_recur = false;
    std::vector<std::string> child_dirs;

    mmDirent entry1;
    entry1.d_name[0] = '.';
    entry1.d_name[1] = '\0';

    mmDirent entry2;
    entry2.d_name[0] = '.';
    entry2.d_name[1] = '.';
    entry2.d_name[2] = '\0';

    mmDirent entry3;
    entry3.d_name[0] = 'f';
    entry3.d_name[1] = '\0';

    mmDirent entry4;
    entry4.d_name[0] = 'd';
    entry4.d_name[1] = '\0';

    mmDirent *name_list[4];
    name_list[0] = &entry1;
    name_list[1] = &entry2;
    name_list[2] = &entry3;
    name_list[3] = &entry4;
    mmDirent **p_name_list = name_list;

    MOCKER(mmScandir)
        .stubs()
        .with(any(), outBoundP(&p_name_list), any(), any())
        .will(returnValue(4));

    MOCKER(Utils::IsDir)
        .stubs()
        .with(any())
        .will(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(false));

    MOCKER(mmScandirFree)
        .stubs()
        .with(any(), any())
        .will(returnValue(0));

    Utils::GetChildDirs(path, is_recur, child_dirs, 0);
    EXPECT_EQ(1, child_dirs.size());
}

///////////////////////////////////////////////////////////
TEST_F(COMMON_UTILS_UTILS_TEST, get_child_filenames_scan_dir_fail) {
    GlobalMockObject::verify();

    std::string dir("/tmp/get_child_filenames_scan_dir_fail");
    std::vector<std::string> child_filename;

    MOCKER(mmScandir)
        .stubs()
        .with(any(), any(), any(), any())
        .will(returnValue(0));

    Utils::GetChildFilenames(dir, child_filename);
    EXPECT_EQ(0, child_filename.size());

}

TEST_F(COMMON_UTILS_UTILS_TEST, get_child_filenames_scan_dir_success) {
    GlobalMockObject::verify();

    std::string dir("/tmp/get_child_filenames_scan_dir_success");
    std::vector<std::string> child_filename;

    mmDirent entry1;
    entry1.d_name[0] = '.';
    entry1.d_name[1] = '\0';

    mmDirent entry2;
    entry2.d_name[0] = '.';
    entry2.d_name[1] = '.';
    entry2.d_name[2] = '\0';

    mmDirent entry3;
    entry3.d_name[0] = 'f';
    entry3.d_name[1] = '\0';

    mmDirent entry4;
    entry4.d_name[0] = 'd';
    entry4.d_name[1] = '\0';

    mmDirent *name_list[4];
    name_list[0] = &entry1;
    name_list[1] = &entry2;
    name_list[2] = &entry3;
    name_list[3] = &entry4;
    mmDirent **p_name_list = name_list;

    MOCKER(mmScandir)
        .stubs()
        .with(any(), outBoundP(&p_name_list), any(), any())
        .will(returnValue(4));

    MOCKER(mmScandirFree)
        .stubs()
        .with(any(), any())
        .will(returnValue(0));

    Utils::GetChildFilenames(dir, child_filename);
    EXPECT_EQ(2, child_filename.size());
}

///////////////////////////////////////////////////////////
TEST_F(COMMON_UTILS_UTILS_TEST, TimestampToTime) {
    GlobalMockObject::verify();
    std::stringstream end_time;
    struct timeval tv;
    gettimeofday(&tv, NULL);
    end_time << (tv.tv_sec * 1000000 + tv.tv_usec);

    EXPECT_STREQ("0", Utils::TimestampToTime("", 1000000).c_str());
    EXPECT_STRNE("0", Utils::TimestampToTime(end_time.str(), 1000000).c_str());
}
TEST_F(COMMON_UTILS_UTILS_TEST, TimestampToTime2){
    const int timeLen = 32;
    char timeStr[timeLen] = { 0 };

    (void)memset_s(timeStr, sizeof(timeStr), 0, sizeof(timeStr));
    int ret = sprintf_s(timeStr, sizeof(timeStr), "%06u", 100);
    if (ret == -1) {
        MSPROF_LOGI("[XXX] %d", __LINE__);
    }


    GlobalMockObject::verify();
    MOCKER(localtime_r)
        .stubs()
        .will(returnValue((struct tm *)0x123456));

    std::string time = Utils::TimestampToTime("1000100", 1000);
    int len = time.size();
    EXPECT_NE(1, len);
}

TEST_F(COMMON_UTILS_UTILS_TEST, HandleEnvString){
    GlobalMockObject::verify();
    std::string envStr;
    CONST_CHAR_PTR env = nullptr;
    MM_SYS_GET_ENV(MM_ENV_HOME, env);
    envStr = Utils::HandleEnvString(env);
    EXPECT_STREQ(getenv("HOME"), envStr.c_str());
}

TEST_F(COMMON_UTILS_UTILS_TEST, IdeReplaceWaveWithHomedir){
    GlobalMockObject::verify();
    std::string str = "~/profiler-app";
    std::string result;
    result = Utils::IdeReplaceWaveWithHomedir(str);
    EXPECT_NE(str, result);
    std::cout << result << std::endl;
}

TEST_F(COMMON_UTILS_UTILS_TEST, ProfMalloc){
    GlobalMockObject::verify();
    MOCKER(memset_s)
        .stubs()
        .will(returnValue(-1));
    EXPECT_EQ(nullptr, Utils::ProfMalloc(0));
    EXPECT_EQ(nullptr, Utils::ProfMalloc(1));
}

TEST_F(COMMON_UTILS_UTILS_TEST, RemoveEndCharacter){
    GlobalMockObject::verify();
    std::string input = "mm\n";
    std::string empty = "";
    Utils::RemoveEndCharacter(input, '\n');
    EXPECT_EQ(input, "mm");
    Utils::RemoveEndCharacter(empty, '\n');
    EXPECT_EQ(empty, "");
    Utils::RemoveEndCharacter(input, 'q');
    EXPECT_EQ(input, "mm");
}

int GetDiskFreeSpaceStub(const char *path, mmDiskSize *diskSize) {
    std::string paths(path);
    try {
        diskSize->availSize = std::stoi(paths);
    } catch(...) {
        return -1;
    }
    return EN_OK;
}

TEST_F(COMMON_UTILS_UTILS_TEST, CreateTaskId) {
    GlobalMockObject::verify();
    std::string dirName = Utils::CreateProfDir(0);
    dirName = Utils::CreateProfDir(200);
    dirName = Utils::CreateProfDir(999998);
    dirName = Utils::CreateProfDir(999999);
    dirName = Utils::CreateProfDir(1000000);
    // sample: PROF_000002_20231012104049447_hostPid + AKPGIMRB
    EXPECT_EQ(46, dirName.size()); // length of prof dir
}

TEST_F(COMMON_UTILS_UTILS_TEST, CreateHelperDir) {
    GlobalMockObject::verify();
    std::string dirName = Utils::CreateHelperDir(0, "15151");
    // sample: PROF_000001_20231012104049447_hostPid + 00015151
    EXPECT_EQ(46, dirName.size()); // length of prof dir
}

TEST_F(COMMON_UTILS_UTILS_TEST, WriteFile0) {
    GlobalMockObject::verify();
    std::string profName = "PROF_000001_20220222182700493_BABQCAKDOMCOLMJB\n";
    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::common::utils::WriteFile("", "", profName));
}

TEST_F(COMMON_UTILS_UTILS_TEST, WriteFile2) {
    GlobalMockObject::verify();
    FILE *file = (FILE *)0x12345;
    std::string profName = "PROF_000001_20220222182700493_BABQCAKDOMCOLMJB\n";

    MOCKER_CPP(fopen)
        .stubs()
        .will(returnValue(file));

    MOCKER_CPP(fileno)
        .stubs()
        .will(returnValue(2));

    MOCKER_CPP(flock)
        .stubs()
        .will(returnValue(0)); //success

    MOCKER_CPP(fwrite)
        .stubs()
        .will(returnValue(profName.length() - 1)); //failed. 2 is not equal to the lenth of PROF_000001_20220222182700493_BABQCAKDOMCOLMJB\n

    MOCKER_CPP(fclose)
        .stubs()
        .will(returnValue(2));

    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::common::utils::WriteFile("", "", profName));
}

TEST_F(COMMON_UTILS_UTILS_TEST, WriteFile4) {
    GlobalMockObject::verify();
    FILE *file = (FILE *)0x12345;
    std::string profName = "PROF_000001_20220222182700493_BABQCAKDOMCOLMJB\n";

    MOCKER_CPP(fopen)
        .stubs()
        .will(returnValue(file));

    MOCKER_CPP(fileno)
        .stubs()
        .will(returnValue(2));

    MOCKER_CPP(flock)
        .stubs()
        .will(returnValue(0)); //success

    MOCKER_CPP(fwrite)
        .stubs()
        .will(returnValue(profName.length())); //sucess. 47 is not equal to the lenth of PROF_000001_20220222182700493_BABQCAKDOMCOLMJB\n

    MOCKER_CPP(fclose)
        .stubs()
        .will(returnValue(2));

    EXPECT_EQ(PROFILING_SUCCESS, analysis::dvvp::common::utils::WriteFile("", "", profName));
}

TEST_F(COMMON_UTILS_UTILS_TEST, WriteFile_fileno_failed) {
    GlobalMockObject::verify();
    FILE *file = (FILE *)0x12345;
    std::string profName = "PROF_000001_20220222182700493_BABQCAKDOMCOLMJB\n";

    MOCKER_CPP(fopen)
        .stubs()
        .will(returnValue(file));

    MOCKER_CPP(fileno)
        .stubs()
        .will(returnValue(-1));

    MOCKER_CPP(fclose)
        .stubs()
        .will(returnValue(2));
    // fileno failed
    EXPECT_EQ(PROFILING_FAILED, analysis::dvvp::common::utils::WriteFile("", "test", profName));
}

TEST_F(COMMON_UTILS_UTILS_TEST, CheckStringIsUnsignedIntNum) {
    // check type is uint32_t
    std::string numberStr = "4294967295";
    bool ret = Utils::CheckStringIsUnsignedIntNum(numberStr);
    EXPECT_TRUE(ret);
    uint32_t umax = 0;
    uint32_t uerror = 0;
    if (ret) {
        umax = std::stoull(numberStr);
    }
    try {
        uerror = std::stoi(numberStr);
    } catch(...) {
        uerror = 1;
    }
    EXPECT_TRUE(uerror == 1);
    EXPECT_EQ(umax, 4294967295);
    EXPECT_FALSE(Utils::CheckStringIsUnsignedIntNum("4294967296"));
    EXPECT_FALSE(Utils::CheckStringIsUnsignedIntNum("-1"));
}

TEST_F(COMMON_UTILS_UTILS_TEST, CheckStringIsNonNegativeIntNum) {
    // check type is int32_t
    std::string numberStr = "2147483647";
    bool ret = Utils::CheckStringIsNonNegativeIntNum(numberStr);
    EXPECT_TRUE(ret);
    int32_t imax = 0;
    if (ret) {
        imax = std::stoi(numberStr);
    }
    EXPECT_EQ(imax, 2147483647);
    EXPECT_FALSE(Utils::CheckStringIsNonNegativeIntNum("2147483648"));
    EXPECT_FALSE(Utils::CheckStringIsNonNegativeIntNum("-1"));
}

TEST_F(COMMON_UTILS_UTILS_TEST, CheckStrToInt32Failed) {
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

TEST_F(COMMON_UTILS_UTILS_TEST, CheckStrToStrToUint32Failed) {
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

TEST_F(COMMON_UTILS_UTILS_TEST, IsDirAccessible) {
    std::string path = "/notDir";
    EXPECT_EQ(false, Utils::IsDirAccessible(path));

    MOCKER(OsalAccess2).stubs().will(returnValue(PROFILING_FAILED));
    path = "/tmp";
    EXPECT_EQ(false, Utils::IsDirAccessible(path));
}
