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
#include "osal_linux.h"

class OSAL_LINUX_TEST : public testing::Test {
protected:
    virtual void SetUp()
    {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
        GlobalMockObject::reset();
    }
};

TEST_F(OSAL_LINUX_TEST, LinuxSleep)
{
    EXPECT_EQ(OSAL_EN_INVALID_PARAM, LinuxSleep(OSAL_ZERO));

    MOCKER(usleep).stubs().will(returnValue(OSAL_EN_ERROR));
    EXPECT_EQ(OSAL_EN_ERROR, LinuxSleep(OSAL_MAX_SLEEP_MILLSECOND_USING_USLEEP));
}

TEST_F(OSAL_LINUX_TEST, LinuxGetTid)
{
    EXPECT_EQ(OSAL_EN_ERROR, LinuxGetTid());
}

TEST_F(OSAL_LINUX_TEST, LinuxSocket)
{
    OsalSockHandle listenfd, connfd;
    struct sockaddr_in serv_add;
    OsalSocklen stAddrLen = sizeof(serv_add);

    listenfd = LinuxSocket(AF_INET, SOCK_STREAM, 0);
    ASSERT_EQ(OSAL_EN_ERROR, listenfd);

    memset(&serv_add, '0', sizeof(serv_add));
    int32_t p = 50001;
    serv_add.sin_family = AF_INET;
    serv_add.sin_addr.s_addr = 0;
    serv_add.sin_port = htons(p);

    int32_t ret = LinuxBind(listenfd, (OsalSockAddr *)&serv_add, stAddrLen);
    ASSERT_EQ(OSAL_EN_ERROR, ret);

    ret = LinuxListen(listenfd, 5);
    ASSERT_EQ(OSAL_EN_ERROR, ret);

    connfd = LinuxAccept(listenfd, (OsalSockAddr *)nullptr, nullptr);
    ASSERT_EQ(OSAL_EN_ERROR, connfd);

    ret = LinuxConnect(listenfd, (OsalSockAddr *)&serv_add, stAddrLen);
    ASSERT_EQ(OSAL_EN_ERROR, ret);
}

TEST_F(OSAL_LINUX_TEST, LinuxSocketSend)
{
    char msg[50] = {"test socket send!"};
    int32_t result = 0;

    result = LinuxSocketSend(-1, msg, 50, 0);
    ASSERT_EQ(OSAL_EN_ERROR, result);

    result = LinuxSocketRecv(1, nullptr, 50, 0);
    ASSERT_EQ(OSAL_EN_ERROR, result);
}

TEST_F(OSAL_LINUX_TEST, LinuxGetErrorCode)
{
    ASSERT_EQ(errno, LinuxGetErrorCode());
}

TEST_F(OSAL_LINUX_TEST, LinuxCreateProcess)
{
    int pid;
    char *argv[] = {(char *)"ls", (char *)"-al", nullptr};
    char *envp[] = {(char *)"PATH=/bin", nullptr};
    char *filename = (char *)"/bin/ls";
    char redirectLog[1024] = "/tmp/osal_linux_utest_createprocess.txt";
    int status = 0;
    OsalArgvEnv env;
    env.argv = argv;
    env.argvCount = 2;
    env.envp = envp;
    env.envpCount = 1;
    int ret = LinuxCreateProcess(filename, &env, nullptr, nullptr);
    ASSERT_EQ(OSAL_EN_ERROR, ret);

    ASSERT_EQ(OSAL_EN_ERROR, LinuxWaitPid(pid, &status, 0));
}

TEST_F(OSAL_LINUX_TEST, LinuxAccess)
{
    CHAR newPath[256] = "./llt/abl/msprof/st/common/LinuxAccess";
    LinuxRmdir(newPath);
    int32_t ret = LinuxMkdir(newPath, 0755);
    ASSERT_EQ(OSAL_EN_OK, ret);
    ret = LinuxAccess(newPath);
    ASSERT_EQ(OSAL_EN_OK, ret);
    
    std::string subPath = newPath;
    subPath += "/test";
    ret = LinuxMkdir(subPath.c_str(), 0755);
    ASSERT_EQ(OSAL_EN_OK, ret);
    std::string path;
    size_t size = PATH_MAX - strlen(newPath) - 2;
    for (int32_t i = 0; i < size; i+= 2) {
        path += "./";
    }
    path += newPath;
    ret = LinuxRmdir(path.c_str());
    ASSERT_EQ(OSAL_EN_INVALID_PARAM, ret);

    ret = LinuxRmdir(newPath);
    ASSERT_EQ(OSAL_EN_OK, ret);
}

VOID *UTtest_callback(VOID *pstArg)
{
    int32_t pid = LinuxGetPid();
    int32_t tid = LinuxGetTid();
    printf("UTtest_callback, the pid = %d, the tid = %d.\r\n", pid, tid);
    LinuxSleep(100);
    return nullptr;
}

TEST_F(OSAL_LINUX_TEST, LinuxCreateTaskWithThreadAttr)
{
    OsalThread stThreadHandle;
    OsalUserBlock stFuncBlock;
    stFuncBlock.procFunc = UTtest_callback;
    stFuncBlock.pulArg = nullptr;

    OsalThreadAttr attr;
    memset(&attr, 0, sizeof(attr));
    attr.detachFlag = 0;  // not detach
    attr.policyFlag = 1;
    attr.policy = OSAL_THREAD_SCHED_RR;
    attr.priorityFlag = 1;
    attr.priority = 1;  // 1-99
    attr.stackFlag = 1;
    attr.stackSize = 20480;  // 20K

    int32_t ret = LinuxCreateTaskWithThreadAttr(&stThreadHandle, nullptr, &attr);
    ASSERT_EQ(OSAL_EN_INVALID_PARAM, ret);

    attr.stackSize = 1024;  // 1k
    ret = LinuxCreateTaskWithThreadAttr(&stThreadHandle, &stFuncBlock, &attr);
    ASSERT_EQ(OSAL_EN_INVALID_PARAM, ret);

    attr.priority = 100;  // 1-99
    ret = LinuxCreateTaskWithThreadAttr(&stThreadHandle, &stFuncBlock, &attr);
    ASSERT_EQ(OSAL_EN_INVALID_PARAM, ret);

    attr.policy = -1;
    ret = LinuxCreateTaskWithThreadAttr(&stThreadHandle, &stFuncBlock, &attr);
    ASSERT_EQ(OSAL_EN_INVALID_PARAM, ret);

    MOCKER(pthread_attr_init).stubs().will(returnValue(OSAL_EN_ERROR));
    ret = LinuxCreateTaskWithThreadAttr(&stThreadHandle, &stFuncBlock, &attr);
    ASSERT_EQ(OSAL_EN_ERROR, ret);
    GlobalMockObject::reset();

    MOCKER(pthread_attr_setinheritsched).stubs().will(returnValue(OSAL_EN_ERROR));
    ret = LinuxCreateTaskWithThreadAttr(&stThreadHandle, &stFuncBlock, &attr);
    ASSERT_EQ(OSAL_EN_ERROR, ret);
    GlobalMockObject::reset();

    MOCKER(pthread_attr_setschedpolicy).stubs().will(returnValue(OSAL_EN_ERROR));
    ret = LinuxCreateTaskWithThreadAttr(&stThreadHandle, &stFuncBlock, &attr);
    ASSERT_EQ(OSAL_EN_INVALID_PARAM, ret);
    GlobalMockObject::reset();

    attr.policyFlag = 1;
    attr.policy = OSAL_THREAD_SCHED_RR;
    attr.priorityFlag = 1;
    attr.priority = 1;  // 1-99
    attr.stackFlag = 1;
    attr.stackSize = 20480;  // 20K

    ret = LinuxCreateTaskWithThreadAttr(&stThreadHandle, &stFuncBlock, &attr);
    ASSERT_EQ(OSAL_EN_ERROR, ret);
}

TEST_F(OSAL_LINUX_TEST, LinuxChmod)
{
    CHAR *lpStr1 = nullptr;
    int32_t mode = OSAL_IWUSR;
    int32_t ret = LinuxChmod(lpStr1, mode);
    ASSERT_EQ(OSAL_EN_INVALID_PARAM, ret);

    CHAR *newPath = (CHAR *)("./llt/abl/msprof/st/common/chmod.txt");
    int32_t fd = LinuxOpen((CHAR *)newPath, O_CREAT | O_RDWR, S_IRWXU | S_IRWXG);

    MOCKER(chmod).stubs().will(returnValue(OSAL_EN_ERROR));
    ret = LinuxChmod(newPath, mode);
    ASSERT_EQ(OSAL_EN_ERROR, ret);
    GlobalMockObject::reset();

    ret = LinuxChmod(newPath, mode);
    ASSERT_EQ(OSAL_EN_OK, ret);
    ret = LinuxClose(fd);
    ASSERT_EQ(OSAL_EN_OK, ret);
    ret = LinuxUnlink(newPath);
    ASSERT_EQ(OSAL_EN_OK, ret);
}

TEST_F(OSAL_LINUX_TEST, LinuxChdir)
{
    char currentDir[OSAL_MAX_PATH] = "./";
    char targetDir[] = "/var/";
    int32_t ret = LinuxChdir(targetDir);
    ASSERT_EQ(OSAL_EN_ERROR, ret);

    ret = LinuxRealPath(nullptr, currentDir, OSAL_MAX_PATH);
    ASSERT_EQ(OSAL_EN_INVALID_PARAM, ret);
    ret = LinuxRealPath("./", currentDir, OSAL_MAX_PATH);
    ASSERT_EQ(OSAL_EN_OK, ret);
}

TEST_F(OSAL_LINUX_TEST, LinuxIsDir)
{
    char *pathname = (CHAR *)"./llt/abl/msprof/st/common/CMakeLists.txt";
    int32_t ret = LinuxIsDir(pathname);
    ASSERT_EQ(OSAL_EN_ERROR, ret);
    pathname = (CHAR *)"./llt/abl/msprof/st/common";
    ret = LinuxIsDir(pathname);
    ASSERT_EQ(OSAL_EN_OK, ret);

    ret = LinuxIsDir(nullptr);
    ASSERT_EQ(OSAL_EN_INVALID_PARAM, ret);

    MOCKER(lstat).stubs().will(returnValue(-1));
    ret = LinuxIsDir(pathname);
    ASSERT_EQ(OSAL_EN_ERROR, ret);
    GlobalMockObject::reset();
}

TEST_F(OSAL_LINUX_TEST, LinuxRmdir)
{
    CHAR rmdirPath[64] = "./llt/abl/msprof/st/common/rmdirTest";
    CHAR dirPath1[64] = "./llt/abl/msprof/st/common/rmdirTest/test1";
    CHAR dirPath2[64] = "./llt/abl/msprof/st/common/rmdirTest/test2";

    CHAR filePath1[64] = "./llt/abl/msprof/st/common/rmdirTest/test1/test1.txt";
    CHAR filePath2[64] = "./llt/abl/msprof/st/common/rmdirTest/test2/test2.txt";

    int32_t ret = LinuxRmdir(filePath1);
    ASSERT_EQ(OSAL_EN_INVALID_PARAM, ret);

    LinuxRmdir(rmdirPath);
    ret = LinuxMkdir(rmdirPath, 0755);
    ASSERT_EQ(OSAL_EN_OK, ret);

    ret = LinuxMkdir(dirPath1, 0755);
    printf("dirPath1  \n");
    ASSERT_EQ(OSAL_EN_OK, ret);

    ret = LinuxMkdir(dirPath2, 0755);
    ASSERT_EQ(OSAL_EN_OK, ret);
    int32_t fd = LinuxOpen((CHAR *)filePath1, O_CREAT | O_RDWR, S_IRWXU | S_IRWXG);
    EXPECT_TRUE(fd >= 0);
    ret = LinuxClose(fd);
    ASSERT_EQ(OSAL_EN_OK, ret);

    fd = LinuxOpen((CHAR *)filePath2, O_CREAT | O_RDWR, S_IRWXU | S_IRWXG);
    EXPECT_TRUE(fd >= 0);
    ret = LinuxClose(fd);
    ASSERT_EQ(OSAL_EN_OK, ret);

    MOCKER(rmdir).stubs().will(returnValue(OSAL_EN_ERROR));
    ret = LinuxRmdir(rmdirPath);
    ASSERT_EQ(OSAL_EN_ERROR, ret);
    GlobalMockObject::reset();

    MOCKER(&malloc).stubs().will(returnValue((void *)nullptr));
    ret = LinuxRmdir(rmdirPath);
    ASSERT_EQ(OSAL_EN_INVALID_PARAM, ret);
    GlobalMockObject::reset();

    MOCKER(&memset_s).stubs().will(returnValue(OSAL_EN_ERROR));
    ret = LinuxRmdir(rmdirPath);
    ASSERT_EQ(OSAL_EN_ERROR, ret);
    GlobalMockObject::reset();

    ret = LinuxRmdir(nullptr);
    ASSERT_EQ(OSAL_EN_INVALID_PARAM, ret);

    ret = LinuxRmdir(rmdirPath);
    ASSERT_EQ(OSAL_EN_OK, ret);
}

int32_t CpuInfoStrToIntStub(const char *str)
{
    if (str == NULL) {
        return 0;
    }

    errno = 0;
    char *endPtr = NULL;
    const int32_t decimalBase = 10;
    int64_t out = strtol(str, &endPtr, decimalBase);
    if (endPtr == str || *endPtr != '\0') {
        return 0;
    } else if ((out == LONG_MIN || out == LONG_MAX) && (errno == ERANGE)) {
        return 0;
    }

    if (out <= INT_MAX && out >= INT_MIN) {
        return (int32_t)out;
    } else {
        return 0;
    }
}

TEST_F(OSAL_LINUX_TEST, LinuxGetCpuInfo)
{
    OsalCpuDesc *desc = nullptr;
    int32_t count = 0;
    int32_t ret = 0;

    int32_t cnt = 1;
    ret = LinuxGetCpuInfo(nullptr, &cnt);
    ASSERT_EQ(OSAL_EN_INVALID_PARAM, ret);

    ret = LinuxGetCpuInfo(&desc, &count);
    ASSERT_EQ(OSAL_EN_OK, ret);
    free(desc);

    GlobalMockObject::reset();
    char hisiVersion[100] = "CPU implementer: 0x48";
    char *stubChar = nullptr;
    MOCKER(fgets)
        .stubs()
        .will(returnValue(&hisiVersion[0]))
        .then(returnValue(stubChar));
    MOCKER(uname)
        .stubs()
        .will(returnValue(OSAL_EN_OK));
    ret = LinuxGetCpuInfo(&desc, &count);
    free(desc);
    desc = NULL;
    ASSERT_EQ(OSAL_EN_OK, ret);
    GlobalMockObject::reset();

    ret = LinuxCpuInfoFree(nullptr, count);
    ASSERT_EQ(OSAL_EN_INVALID_PARAM, ret);

    EXPECT_EQ(CpuInfoStrToIntStub("-2147483648"), -2147483648);
    EXPECT_EQ(CpuInfoStrToIntStub("2147483647"), 2147483647);
    EXPECT_EQ(CpuInfoStrToIntStub("2147483648"), 0);
    EXPECT_EQ(CpuInfoStrToIntStub("-9223372036854775808"), 0);
    EXPECT_EQ(CpuInfoStrToIntStub("9223372036854775807"), 0);
    EXPECT_EQ(CpuInfoStrToIntStub(NULL), 0);
}

TEST_F(OSAL_LINUX_TEST, LinuxGetOptLong)
{
    MOCKER(getopt_long).stubs().will(returnValue(0));
    int32_t longIndex = 0;
    char* argv[] = {"test"};
    char *opts = "";
    OsalStructOption options[0] = {};
    EXPECT_EQ(0, LinuxGetOptLong(0, argv, opts, options, &longIndex));
}