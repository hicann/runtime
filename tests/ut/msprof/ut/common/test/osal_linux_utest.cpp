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

TEST_F(OSAL_LINUX_TEST, LinuxGetPid)
{
    EXPECT_GE(LinuxGetPid(), 0);
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

TEST_F(OSAL_LINUX_TEST, LinuxJoinTask)
{
    OsalThread stThreadHandle;
    OsalUserBlock stFuncBlock;
    stFuncBlock.procFunc = UTtest_callback;
    stFuncBlock.pulArg = nullptr;
    pthread_create(&stThreadHandle, nullptr, stFuncBlock.procFunc, stFuncBlock.pulArg);
    MOCKER(pthread_join).stubs().will(returnValue(OSAL_EN_ERROR));
    int32_t ret = LinuxJoinTask(&stThreadHandle);
    ASSERT_EQ(OSAL_EN_ERROR, ret);
    GlobalMockObject::reset();
    ret = LinuxJoinTask(&stThreadHandle);
    ASSERT_EQ(OSAL_EN_OK, ret);
}

TEST_F(OSAL_LINUX_TEST, LinuxGetTickCount)
{
    OsalTimespec rts = LinuxGetTickCount();
    EXPECT_TRUE(rts.tv_nsec != 0);
}

TEST_F(OSAL_LINUX_TEST, LinuxGetFileSize)
{
    char *pathname = (CHAR *)"./llt/abl/msprof/ut/common/CMakeLists.txt";

    uint64_t length = 0;
    int32_t ret = LinuxGetFileSize(pathname, &length);
    ASSERT_EQ(OSAL_EN_OK, ret);
    printf("file size is %lld,\n", length);
    ret = LinuxGetFileSize(nullptr, &length);
    ASSERT_EQ(OSAL_EN_INVALID_PARAM, ret);

    MOCKER(lstat).stubs().will(returnValue(-1));
    ret = LinuxGetFileSize(pathname, &length);
    ASSERT_EQ(OSAL_EN_ERROR, ret);
    GlobalMockObject::reset();
}

TEST_F(OSAL_LINUX_TEST, LinuxGetDiskFreeSpace)
{
    char *pathname = (CHAR *)"/var/";
    struct statvfs buf;
    fsblkcnt_t total_size;
    fsblkcnt_t used_size;
    fsblkcnt_t avail_size;
    int error;
    OsalDiskSize dsize = {0};
    error = LinuxGetDiskFreeSpace(pathname, &dsize);
    printf("error =%d \n", error);
    EXPECT_TRUE(error == OSAL_EN_OK);
    printf("totalSize: %lld\n", dsize.totalSize);
    printf("availSize: %lld\n", dsize.availSize);
    printf("freeSize: %lld\n", dsize.freeSize);
    error = LinuxGetDiskFreeSpace(nullptr, &dsize);
    EXPECT_TRUE(error == OSAL_EN_INVALID_PARAM);

    MOCKER(statvfs).stubs().will(returnValue(-1));
    error = LinuxGetDiskFreeSpace(pathname, &dsize);
    ASSERT_EQ(OSAL_EN_ERROR, error);
    GlobalMockObject::reset();
}

TEST_F(OSAL_LINUX_TEST, LinuxIsDir)
{
    char *pathname = (CHAR *)"./llt/abl/msprof/ut/common/CMakeLists.txt";
    int32_t ret = LinuxIsDir(pathname);
    ASSERT_EQ(OSAL_EN_ERROR, ret);
    pathname = (CHAR *)"./llt/abl/msprof/ut/common";
    ret = LinuxIsDir(pathname);
    ASSERT_EQ(OSAL_EN_OK, ret);

    ret = LinuxIsDir(nullptr);
    ASSERT_EQ(OSAL_EN_INVALID_PARAM, ret);

    MOCKER(lstat).stubs().will(returnValue(-1));
    ret = LinuxIsDir(pathname);
    ASSERT_EQ(OSAL_EN_ERROR, ret);
    GlobalMockObject::reset();
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

TEST_F(OSAL_LINUX_TEST, LinuxDirName)
{
    char *path = "llt/abl/msprof/ut/common/";
    char *tmp = "llt/abl/msprof/ut";
    MOCKER(dirname).stubs().will(returnValue(tmp));
    char *dir = LinuxDirName(path);
    printf("dir=%s,dirname\n", dir);
    ASSERT_NE(nullptr, dir);

    MOCKER(basename).stubs().will(returnValue(tmp));
    char *base = LinuxBaseName(path);
    printf("base=%s,basename\n", base);
    ASSERT_NE(nullptr, base);

    dir = LinuxDirName(nullptr);
    ASSERT_EQ(nullptr, dir);
    dir = LinuxBaseName(nullptr);
    ASSERT_EQ(nullptr, dir);
}

TEST_F(OSAL_LINUX_TEST, LinuxMkdir)
{
    ASSERT_EQ(OSAL_EN_INVALID_PARAM, LinuxMkdir(nullptr, 0755));

    CHAR newPath[256] = "./llt/abl/msprof/ut/common/mkdir";
    MOCKER(mkdir).stubs().will(returnValue(OSAL_EN_ERROR));
    int32_t ret = LinuxMkdir(newPath, 0755);
    ASSERT_EQ(OSAL_EN_ERROR, ret);
    GlobalMockObject::reset();
}

TEST_F(OSAL_LINUX_TEST, LinuxChmod)
{
    CHAR *lpStr1 = nullptr;
    int32_t mode = OSAL_IWUSR;
    int32_t ret = LinuxChmod(lpStr1, mode);
    ASSERT_EQ(OSAL_EN_INVALID_PARAM, ret);

    CHAR newPath[] = "./llt/abl/msprof/ut/common/chmod.txt";
    int32_t fd = LinuxOpen((CHAR *)newPath, O_NOCTTY, S_IRWXU | S_IRWXG);
    EXPECT_EQ(OSAL_EN_INVALID_PARAM, fd);

    fd = LinuxOpen((CHAR *)newPath, O_CREAT | O_RDWR, 0);
    EXPECT_EQ(OSAL_EN_INVALID_PARAM, fd);

    fd = LinuxOpen((CHAR *)newPath, O_CREAT | O_RDWR, S_IRWXU | S_IRWXG);
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

int testFilter(const struct dirent *entry)
{
    return entry->d_name[0] == 't';
}

TEST_F(OSAL_LINUX_TEST, LinuxScandir)
{
    OsalDirent **entryList;
    int count;
    int i;
    char testDir[64] = "./llt/abl/msprof/ut/common/";

    count = LinuxScandir(nullptr, &entryList, testFilter, alphasort);
    ASSERT_EQ(OSAL_EN_INVALID_PARAM, count);

    MOCKER(scandir).stubs().will(returnValue(OSAL_EN_ERROR));
    count = LinuxScandir(testDir, &entryList, testFilter, alphasort);
    ASSERT_EQ(OSAL_EN_ERROR, count);
    GlobalMockObject::reset();

    count = LinuxScandir(testDir, &entryList, testFilter, alphasort);
    EXPECT_TRUE(count >= 0);

    printf("count is %d\n", count);
    for (i = 0; i < count; i++) {
        printf("%s\n", entryList[i]->d_name);
    }
    LinuxScandirFree(entryList, count);
}

TEST_F(OSAL_LINUX_TEST, LinuxRmdir)
{
    CHAR rmdirPath[64] = "./llt/abl/msprof/ut/common/rmdirTest";
    CHAR dirPath1[64] = "./llt/abl/msprof/ut/common/rmdirTest/test1";
    CHAR dirPath2[64] = "./llt/abl/msprof/ut/common/rmdirTest/test2";

    CHAR filePath1[64] = "./llt/abl/msprof/ut/common/rmdirTest/test1/test1.txt";
    CHAR filePath2[64] = "./llt/abl/msprof/ut/common/rmdirTest/test2/test2.txt";

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

TEST_F(OSAL_LINUX_TEST, LinuxGetCwd)
{
    int32_t ret = 0;
    char bufff[260];
    ret = LinuxGetCwd(bufff, sizeof(bufff));
    ASSERT_EQ(OSAL_EN_OK, ret);
    printf("current working directory : %s\n", bufff);

    ret = LinuxGetCwd(nullptr, 0);
    ASSERT_EQ(OSAL_EN_INVALID_PARAM, ret);

    ret = LinuxGetCwd(bufff, 0);
    ASSERT_EQ(OSAL_EN_ERROR, ret);
}

TEST_F(OSAL_LINUX_TEST, LinuxGetLocalTime)
{
    OsalTimeval tv;
    OsalTimezone tz;
    int32_t ret = LinuxGetTimeOfDay(&tv, &tz);
    ASSERT_EQ(OSAL_EN_OK, ret);
    OsalSystemTime st;

    printf("ret=%d\n", ret);
    printf("LinuxGetTimeOfDay tv_sec:%ld\n", tv.tv_sec);
    printf("LinuxGetTimeOfDay tv_usec:%d\n", tv.tv_usec);
    LinuxGetLocalTime(&st);
    printf("%d-%d-%d %d-%d-%d\n ", st.wYear, st.wMonth, st.wDay, st.wHour, st.wMinute, st.wSecond);

    MOCKER(localtime_r).stubs().will(returnValue((struct tm *)nullptr));
    ret = LinuxGetLocalTime(&st);
    ASSERT_EQ(OSAL_EN_ERROR, ret);
    GlobalMockObject::reset();

    ret = LinuxGetTimeOfDay(nullptr, &tz);
    ASSERT_EQ(OSAL_EN_INVALID_PARAM, ret);
}

TEST_F(OSAL_LINUX_TEST, LinuxSetCurrentThreadName)
{
    char threadName[] = "test-thread-name";
    MOCKER((int (*)(char *))prctl).stubs().will(returnValue(OSAL_EN_ERROR));
    int32_t ret = LinuxSetCurrentThreadName(threadName);
    ASSERT_EQ(OSAL_EN_ERROR, ret);
    GlobalMockObject::reset();

    ret = LinuxSetCurrentThreadName(nullptr);
    ASSERT_EQ(OSAL_EN_INVALID_PARAM, ret);
}

TEST_F(OSAL_LINUX_TEST, LinuxGetOsName)
{
    char osName[OSAL_MIN_OS_NAME_SIZE] = {};
    int32_t ret = LinuxGetOsName(osName, OSAL_MIN_OS_NAME_SIZE);
    ASSERT_EQ(OSAL_EN_OK, ret);
    printf("osName is %s\n", osName);

    ret = LinuxGetOsName(nullptr, OSAL_MIN_OS_NAME_SIZE);
    ASSERT_EQ(OSAL_EN_INVALID_PARAM, ret);

    MOCKER(gethostname).stubs().will(returnValue(-1));
    ret = LinuxGetOsName(osName, OSAL_MIN_OS_NAME_SIZE);
    ASSERT_EQ(OSAL_EN_ERROR, ret);
    GlobalMockObject::reset();
}

TEST_F(OSAL_LINUX_TEST, LinuxGetOsVersion)
{
    char osVersionInfo[OSAL_MIN_OS_VERSION_SIZE] = {};
    int32_t ret = LinuxGetOsVersion(osVersionInfo, OSAL_MIN_OS_VERSION_SIZE);
    ASSERT_EQ(OSAL_EN_OK, ret);
    printf("osVersionInfo is %s\n", osVersionInfo);

    ret = ret = LinuxGetOsVersion(nullptr, OSAL_MIN_OS_VERSION_SIZE);
    ASSERT_EQ(OSAL_EN_INVALID_PARAM, ret);

    MOCKER(uname).stubs().will(returnValue(-1));
    ret = LinuxGetOsVersion(osVersionInfo, OSAL_MIN_OS_VERSION_SIZE);
    ASSERT_EQ(OSAL_EN_ERROR, ret);
    GlobalMockObject::reset();

    MOCKER((int (*)(char *, long unsigned int, long unsigned int))snprintf_s).stubs().will(returnValue(-1));
    ret = LinuxGetOsVersion(osVersionInfo, OSAL_MIN_OS_VERSION_SIZE);
    ASSERT_EQ(OSAL_EN_ERROR, ret);
    GlobalMockObject::reset();
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

TEST_F(OSAL_LINUX_TEST, LinuxDlopen)
{
    MOCKER(dlopen).stubs().will(returnValue((void*)1));
    EXPECT_EQ(nullptr, LinuxDlopen(nullptr, 0));
    EXPECT_NE(nullptr, LinuxDlopen("test.so", RTLD_LAZY));

    MOCKER(dlsym).stubs().will(returnValue((void*)1));
    EXPECT_EQ(nullptr, LinuxDlsym(nullptr, nullptr));
    EXPECT_NE(nullptr, LinuxDlsym((void *)1, "test"));

    MOCKER(dlclose).stubs().will(returnValue(0));
    EXPECT_EQ(OSAL_EN_INVALID_PARAM, LinuxDlclose(nullptr));
    EXPECT_EQ(OSAL_EN_OK, LinuxDlclose((void*)1));

    char *ret = "test";
    MOCKER(dlerror).stubs().will(returnValue(ret));
    EXPECT_EQ(ret, LinuxDlerror());
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