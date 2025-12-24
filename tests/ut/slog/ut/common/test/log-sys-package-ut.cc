/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
extern "C"
{
#include "log_system_api.h"
#include "msg_queue.h"
#include "securec.h"
#include <sys/socket.h>

INT32 LocalSetToolThreadAttr(pthread_attr_t *attr, const ToolThreadAttr *threadAttr);
INT32 ToolAccessWithMode(const CHAR *pathName, INT32 mode);
};

#include <sys/ipc.h>
#include <sys/shm.h>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

using namespace std;
using namespace testing;

class SYS_PACKAGE_TEST : public testing::Test
{
    protected:
        static void SetupTestCase()
        {
            cout << "SYS_PACKAGE_TEST SetUP" <<endl;
        }
        static void TearDownTestCase()
        {
            cout << "SYS_PACKAGE_TEST TearDown" << endl;
        }
        virtual void SetUP()
        {
            cout << "a test SetUP" << endl;
        }
        virtual void TearDown()
        {
            cout << "a test TearDown" << endl;
        }
};


void* func(void*)
{
   return (void*)nullptr;
}

TEST_F(SYS_PACKAGE_TEST, ToolMutexInit1)
{
    EXPECT_EQ(SYS_INVALID_PARAM, ToolMutexInit(NULL));
}

TEST_F(SYS_PACKAGE_TEST, ToolMutexInit2)
{
    ToolMutex mutex;
    MOCKER(pthread_mutex_init).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(SYS_ERROR, ToolMutexInit(&mutex));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolMutexInit3)
{
    ToolMutex mutex;
    MOCKER(pthread_mutex_init).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_OK, ToolMutexInit(&mutex));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolMutexLock1)
{
    EXPECT_EQ(SYS_INVALID_PARAM, ToolMutexLock(NULL));
}

TEST_F(SYS_PACKAGE_TEST, ToolMutexLock2)
{
    ToolMutex mutex;
    MOCKER(pthread_mutex_lock).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(SYS_ERROR, ToolMutexLock(&mutex));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolMutexLock3)
{
    ToolMutex mutex;
    MOCKER(pthread_mutex_lock).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_OK, ToolMutexLock(&mutex));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolMutexUnLock1)
{
    EXPECT_EQ(SYS_INVALID_PARAM, ToolMutexUnLock(NULL));
}

TEST_F(SYS_PACKAGE_TEST, ToolMutexUnLock2)
{
    ToolMutex mutex;
    MOCKER(pthread_mutex_unlock).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(SYS_ERROR, ToolMutexUnLock(&mutex));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolMutexUnLock3)
{
    ToolMutex mutex;
    MOCKER(pthread_mutex_unlock).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_OK, ToolMutexUnLock(&mutex));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolMutexDestroy1)
{
    EXPECT_EQ(SYS_INVALID_PARAM, ToolMutexDestroy(NULL));
}

TEST_F(SYS_PACKAGE_TEST, ToolMutexDestroy2)
{
    ToolMutex mutex;
    MOCKER(pthread_mutex_destroy).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(SYS_ERROR, ToolMutexDestroy(&mutex));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolMutexDestroy3)
{
    ToolMutex mutex;
    MOCKER(pthread_mutex_destroy).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_OK, ToolMutexDestroy(&mutex));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolCreateTaskWithThreadAttr1)
{
    EXPECT_EQ(SYS_INVALID_PARAM, ToolCreateTaskWithThreadAttr(NULL, NULL, NULL));
}

TEST_F(SYS_PACKAGE_TEST, ToolCreateTaskWithThreadAttr3)
{
    ToolThread  threadHandle = 0;
    ToolUserBlock funcBlock;
    ToolThreadAttr threadAttr;
    MOCKER(pthread_attr_init).stubs().will(returnValue(SYS_OK));
    MOCKER(LocalSetToolThreadAttr).stubs().will(returnValue(SYS_ERROR));
    MOCKER(pthread_attr_destroy).stubs().will(returnValue(0));
    EXPECT_EQ(SYS_ERROR, ToolCreateTaskWithThreadAttr(&threadHandle, &funcBlock, &threadAttr));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolCreateTaskWithThreadAttr4)
{
    ToolThread  threadHandle = 0;
    ToolUserBlock funcBlock;
    funcBlock.procFunc = func; 
    ToolThreadAttr threadAttr;
    MOCKER(pthread_attr_init).stubs().will(returnValue(SYS_OK));
    MOCKER(LocalSetToolThreadAttr).stubs().will(returnValue(SYS_OK));
    MOCKER(pthread_create).stubs().will(returnValue(SYS_ERROR));
    MOCKER(pthread_attr_destroy).stubs().will(returnValue(0));
    EXPECT_EQ(SYS_ERROR, ToolCreateTaskWithThreadAttr(&threadHandle, &funcBlock, &threadAttr));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolCreateTaskWithThreadAttr5)
{
    ToolThread  threadHandle = 0;
    ToolUserBlock funcBlock;
    funcBlock.procFunc = func;
    ToolThreadAttr threadAttr;
    MOCKER(pthread_attr_init).stubs().will(returnValue(SYS_OK));
    MOCKER(LocalSetToolThreadAttr).stubs().will(returnValue(SYS_OK));
    MOCKER(pthread_create).stubs().will(returnValue(SYS_OK));
    MOCKER(pthread_attr_destroy).stubs().will(returnValue(0));
    EXPECT_EQ(SYS_OK, ToolCreateTaskWithThreadAttr(&threadHandle, &funcBlock, &threadAttr));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolCreateTaskWithDetach1)
{
    EXPECT_EQ(SYS_INVALID_PARAM, ToolCreateTaskWithDetach(NULL, NULL));
}

TEST_F(SYS_PACKAGE_TEST, ToolCreateTaskWithDetach2)
{
    ToolThread  threadHandle = 0;
    ToolUserBlock funcBlock;
    MOCKER(pthread_attr_init).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(SYS_ERROR, ToolCreateTaskWithDetach(&threadHandle, &funcBlock));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolCreateTaskWithDetach3)
{
    ToolThread  threadHandle = 0;
    ToolUserBlock funcBlock;
    MOCKER(pthread_attr_init).stubs().will(returnValue(SYS_OK));
    MOCKER(pthread_attr_setdetachstate).stubs().will(returnValue(SYS_ERROR));
    MOCKER(pthread_attr_destroy).stubs().will(returnValue(0));
    EXPECT_EQ(SYS_ERROR, ToolCreateTaskWithDetach(&threadHandle, &funcBlock));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolCreateTaskWithDetach4)
{
    ToolThread  threadHandle = 0;
    ToolUserBlock funcBlock;
    funcBlock.procFunc = func;
    MOCKER(pthread_attr_init).stubs().will(returnValue(SYS_OK));
    MOCKER(pthread_attr_setdetachstate).stubs().will(returnValue(SYS_OK));
    MOCKER(pthread_create).stubs().will(returnValue(SYS_ERROR));
    MOCKER(pthread_attr_destroy).stubs().will(returnValue(0));
    EXPECT_EQ(SYS_ERROR, ToolCreateTaskWithDetach(&threadHandle, &funcBlock));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolCreateTaskWithDetach5)
{
    ToolThread  threadHandle = 0;
    ToolUserBlock funcBlock;
    funcBlock.procFunc = func;
    MOCKER(pthread_attr_init).stubs().will(returnValue(SYS_OK));
    MOCKER(pthread_attr_setdetachstate).stubs().will(returnValue(SYS_OK));
    MOCKER(pthread_create).stubs().will(returnValue(SYS_OK));
    MOCKER(pthread_attr_destroy).stubs().will(returnValue(0));
    EXPECT_EQ(SYS_OK, ToolCreateTaskWithDetach(&threadHandle, &funcBlock));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST,  LocalSetToolThreadAttr)
{
    pthread_attr_t attr = {0};
    ToolThreadAttr threadAttr = {0};
    EXPECT_EQ(SYS_OK,  LocalSetToolThreadAttr(&attr, &threadAttr));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolOpen1)
{
    EXPECT_EQ(SYS_INVALID_PARAM, ToolOpen(NULL, 1));

    CHAR *pathName = "test/path";
    EXPECT_EQ(SYS_INVALID_PARAM, ToolOpen(pathName, -1));
}

TEST_F(SYS_PACKAGE_TEST, ToolOpen2)
{
    CHAR *pathName = "test/path";
    EXPECT_EQ(SYS_INVALID_PARAM, ToolOpen(pathName, 4));
}

TEST_F(SYS_PACKAGE_TEST, ToolOpen3)
{
    CHAR *pathName = "test/path";
    EXPECT_EQ(SYS_ERROR, ToolOpen(pathName, O_RDONLY));
}

TEST_F(SYS_PACKAGE_TEST, ToolOpenWithMode1)
{
    EXPECT_EQ(SYS_INVALID_PARAM, ToolOpenWithMode(NULL, 1, 0));

    CHAR *pathName = "test/path";
    EXPECT_EQ(SYS_INVALID_PARAM, ToolOpenWithMode(pathName, -1, 0));
}

TEST_F(SYS_PACKAGE_TEST, ToolOpenWithMode2)
{
    CHAR *pathName = "test/path";
    EXPECT_EQ(SYS_INVALID_PARAM, ToolOpenWithMode(pathName, 4, 0));
}

TEST_F(SYS_PACKAGE_TEST, ToolOpenWithMode3)
{
    CHAR *pathName = "test/path";
    EXPECT_EQ(SYS_INVALID_PARAM, ToolOpenWithMode(pathName, O_RDONLY, 0));
}

TEST_F(SYS_PACKAGE_TEST, ToolOpenWithMode4)
{
    CHAR *pathName = "test/path";
    EXPECT_EQ(SYS_ERROR, ToolOpenWithMode(pathName, O_RDONLY, S_IRUSR));
}

TEST_F(SYS_PACKAGE_TEST, ToolClose1)
{
    EXPECT_EQ(SYS_INVALID_PARAM, ToolClose(-1));
}

TEST_F(SYS_PACKAGE_TEST, ToolClose2)
{
    MOCKER(close).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(SYS_ERROR, ToolClose(1));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolClose3)
{
    MOCKER(close).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_OK, ToolClose(1));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolRead1)
{
    CHAR *buf = "test file read";
    UINT32 bufLen = strlen(buf);
    EXPECT_EQ(SYS_INVALID_PARAM, ToolRead(-1, buf, bufLen));

    EXPECT_EQ(SYS_INVALID_PARAM, ToolRead(1, NULL, 0));
}

TEST_F(SYS_PACKAGE_TEST, ToolRead2)
{
    CHAR *buf = "test file read";
    UINT32 bufLen = strlen(buf);
    MOCKER(read).stubs().will(returnValue(-1));
    EXPECT_EQ(SYS_ERROR, ToolRead(1, buf, bufLen));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolRead3)
{
    CHAR *buf = "test file read";
    UINT32 bufLen = strlen(buf);
    MOCKER(read).stubs().will(returnValue(0));
    EXPECT_EQ(SYS_OK, ToolRead(1, buf, bufLen));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolWrite1)
{
    CHAR *buf = "test file read";
    UINT32 bufLen = strlen(buf);
    EXPECT_EQ(SYS_INVALID_PARAM, ToolWrite(-1, buf, bufLen));

    EXPECT_EQ(SYS_INVALID_PARAM, ToolWrite(1, NULL, 0));
}

TEST_F(SYS_PACKAGE_TEST, ToolWrite2)
{
    CHAR *buf = "test file read";
    UINT32 bufLen = strlen(buf);
    MOCKER(write).stubs().will(returnValue(-1));
    EXPECT_EQ(SYS_ERROR, ToolWrite(1, buf, bufLen));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolWrite3)
{
    CHAR *buf = "test file read";
    UINT32 bufLen = strlen(buf);
    MOCKER(write).stubs().will(returnValue(0));
    EXPECT_EQ(SYS_OK, ToolWrite(1, buf, bufLen));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolMkdir1)
{
    EXPECT_EQ(SYS_INVALID_PARAM, ToolMkdir(NULL, O_RDONLY));
}

TEST_F(SYS_PACKAGE_TEST, ToolMkdir2)
{
    CHAR *pathName = "test/dir";
    MOCKER(mkdir).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(SYS_ERROR, ToolMkdir(pathName, O_RDONLY));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolMkdir3)
{
    CHAR *pathName = "test/dir";
    MOCKER(mkdir).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_OK, ToolMkdir(pathName, O_RDONLY));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolAccessWithMode1)
{
    EXPECT_EQ(SYS_INVALID_PARAM, ToolAccessWithMode(NULL, O_RDONLY));
}

TEST_F(SYS_PACKAGE_TEST, ToolAccessWithMode2)
{
    CHAR *pathName = "test/file";
    MOCKER(access).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(SYS_ERROR, ToolAccessWithMode(pathName, O_RDONLY));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolAccessWithMode3)
{
    CHAR *pathName = "test/file";
    MOCKER(access).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_OK, ToolAccessWithMode(pathName, O_RDONLY));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolAccess1)
{
    CHAR *pathName = "test/file";
    MOCKER(ToolAccessWithMode).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_OK, ToolAccess(pathName));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolRealPath1)
{
    CHAR *path = "test/file";
    char realPath[TOOL_MAX_PATH] = {0};

    EXPECT_EQ(SYS_INVALID_PARAM, ToolRealPath(NULL, realPath, TOOL_MAX_PATH));

    EXPECT_EQ(SYS_INVALID_PARAM, ToolRealPath(path, NULL, TOOL_MAX_PATH));

    EXPECT_EQ(SYS_INVALID_PARAM, ToolRealPath(path, realPath, 1024));
}

TEST_F(SYS_PACKAGE_TEST, ToolRealPath2)
{
    CHAR *path = "test/file";
    char realPath[TOOL_MAX_PATH] = {0};

    MOCKER(realpath).stubs().will(returnValue((CHAR *)NULL));
    EXPECT_EQ(SYS_ERROR, ToolRealPath(path, realPath, TOOL_MAX_PATH));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolRealPath3)
{
    CHAR *path = "test/file";
    char realPath[TOOL_MAX_PATH] = {0};
    CHAR *result = "test/result";

    MOCKER(realpath).stubs().will(returnValue((CHAR *)result));
    EXPECT_EQ(SYS_OK, ToolRealPath(path, realPath, TOOL_MAX_PATH));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolUnlink1)
{
    EXPECT_EQ(SYS_INVALID_PARAM, ToolUnlink(NULL));
}

TEST_F(SYS_PACKAGE_TEST, ToolUnlink2)
{
    CHAR *fileName = "test/file";
    MOCKER(unlink).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_OK, ToolUnlink(fileName));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolChmod1)
{
    EXPECT_EQ(SYS_INVALID_PARAM, ToolChmod(NULL, O_RDONLY));
}

TEST_F(SYS_PACKAGE_TEST, ToolChmod2)
{
    CHAR *fileName = "test/file";
    MOCKER(chmod).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_OK, ToolChmod(fileName, O_RDONLY));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolScandir1)
{
    CHAR *path = "test/file";
    ToolDirent entryList;
    ToolFilter filterFunc;
    ToolSort sort;

    EXPECT_EQ(SYS_INVALID_PARAM, ToolScandir(path, NULL, filterFunc, sort));
}

TEST_F(SYS_PACKAGE_TEST, ToolStatGet1)
{
    CHAR *path = "test/file";
    ToolStat buffer;
    EXPECT_EQ(SYS_INVALID_PARAM, ToolStatGet(NULL, &buffer));
    EXPECT_EQ(SYS_INVALID_PARAM, ToolStatGet(path, NULL));
    EXPECT_EQ(SYS_INVALID_PARAM, ToolStatGet(NULL, NULL));
}

TEST_F(SYS_PACKAGE_TEST, ToolStatGet2)
{
    CHAR *path = "test/file";
    ToolStat buffer;

    MOCKER(stat).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(SYS_ERROR, ToolStatGet(path, &buffer));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolStatGet3)
{
    CHAR *path = "test/file";
    ToolStat buffer;

    MOCKER(stat).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_OK, ToolStatGet(path, &buffer));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolFsync1)
{
    EXPECT_EQ(SYS_INVALID_PARAM, ToolFsync(0));
}

TEST_F(SYS_PACKAGE_TEST, ToolFsync2)
{
    MOCKER(fsync).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(SYS_ERROR, ToolFsync(1));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolFsync3)
{
    MOCKER(fsync).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_OK, ToolFsync(1));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolFileno1)
{
    EXPECT_EQ(SYS_INVALID_PARAM, ToolFileno(NULL));
}

TEST_F(SYS_PACKAGE_TEST, ToolFileno2)
{
    FILE stream;
    MOCKER(fileno).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_OK, ToolFileno(&stream));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolSocket1)
{
    MOCKER(socket).stubs().will(returnValue(-1));
    EXPECT_EQ(SYS_ERROR, ToolSocket(1, 1, 1));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolSocket2)
{
    MOCKER(socket).stubs().will(returnValue(0));
    EXPECT_EQ(0, ToolSocket(1, 1, 1));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolBind1)
{
    toolSockHandle sockFd = 1;
    ToolSockAddr addr;
    toolSocklen addrLen = 1;

    EXPECT_EQ(SYS_INVALID_PARAM, ToolBind(-1, &addr, addrLen));

    EXPECT_EQ(SYS_INVALID_PARAM, ToolBind(sockFd, NULL, addrLen));

    EXPECT_EQ(SYS_INVALID_PARAM, ToolBind(sockFd, &addr, 0));
}

TEST_F(SYS_PACKAGE_TEST, ToolConnect1)
{
    toolSockHandle sockFd = 1;
    ToolSockAddr addr;
    toolSocklen addrLen = 1;

    EXPECT_EQ(SYS_INVALID_PARAM, ToolConnect(-1, &addr, addrLen));
    EXPECT_EQ(SYS_INVALID_PARAM, ToolConnect(sockFd, NULL, addrLen));
    EXPECT_EQ(SYS_INVALID_PARAM, ToolConnect(sockFd, &addr, 0));
}

TEST_F(SYS_PACKAGE_TEST, ToolConnect2)
{
    toolSockHandle sockFd = 1;
    ToolSockAddr addr;
    toolSocklen addrLen = 1;

    MOCKER(connect).stubs().will(returnValue(-1));
    EXPECT_EQ(SYS_ERROR, ToolConnect(sockFd, &addr, addrLen));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolConnect3)
{
    toolSockHandle sockFd = 1;
    ToolSockAddr addr;
    toolSocklen addrLen = 1;

    MOCKER(connect).stubs().will(returnValue(0));
    EXPECT_EQ(SYS_OK, ToolConnect(sockFd, &addr, addrLen));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolCloseSocket1)
{
    EXPECT_EQ(SYS_INVALID_PARAM, ToolCloseSocket(-1));
}

TEST_F(SYS_PACKAGE_TEST, ToolCloseSocket2)
{
    toolSockHandle sockFd = 1;

    MOCKER(close).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(SYS_ERROR, ToolCloseSocket(sockFd));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolCloseSocket3)
{
    toolSockHandle sockFd = 1;

    MOCKER(close).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_OK, ToolCloseSocket(sockFd));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolGetPid1)
{
    MOCKER(getpid).stubs().will(returnValue(100));
    EXPECT_EQ(100, ToolGetPid());
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolSleep1)
{
    EXPECT_EQ(SYS_INVALID_PARAM, ToolSleep(0));
}

TEST_F(SYS_PACKAGE_TEST, ToolSleep2)
{
    MOCKER(usleep).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(SYS_ERROR, ToolSleep(TOOL_MAX_SLEEP_MILLSECOND));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolSleep3)
{
    MOCKER(usleep).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_OK, ToolSleep(TOOL_MAX_SLEEP_MILLSECOND + 1));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolGetTimeOfDay1)
{
    EXPECT_EQ(SYS_INVALID_PARAM, ToolGetTimeOfDay(NULL, NULL));
}

TEST_F(SYS_PACKAGE_TEST, ToolGetTimeOfDay3)
{
    ToolTimeval timeVal;

    MOCKER(gettimeofday).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_OK, ToolGetTimeOfDay(&timeVal, NULL));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolLocalTimeR1)
{
    const time_t timep = 111;
    struct tm result;

    EXPECT_EQ(SYS_INVALID_PARAM, ToolLocalTimeR(NULL, &result));
    EXPECT_EQ(SYS_INVALID_PARAM, ToolLocalTimeR(&timep, NULL));
    EXPECT_EQ(SYS_INVALID_PARAM, ToolLocalTimeR(NULL, NULL));
}

TEST_F(SYS_PACKAGE_TEST, ToolLocalTimeR2)
{
    const time_t timep = 111;
    struct tm result;

    MOCKER(localtime_r).stubs().will(returnValue((struct tm *)NULL));
    EXPECT_EQ(SYS_ERROR, ToolLocalTimeR(&timep, &result));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolLocalTimeR3)
{
    const time_t timep = 111;
    struct tm result;

    EXPECT_EQ(SYS_OK, ToolLocalTimeR(&timep, &result));
}

TEST_F(SYS_PACKAGE_TEST, ToolCondTimedWait)
{
    EXPECT_EQ(SYS_INVALID_PARAM, ToolCondTimedWait(NULL, NULL, 1000));
    MOCKER(pthread_cond_timedwait).stubs().will(returnValue(SYS_OK));
    pthread_cond_t cond;
    ToolMutex mutex;
    EXPECT_EQ(SYS_OK, ToolCondTimedWait(&cond, &mutex, 1000));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolCondInit)
{
    EXPECT_EQ(SYS_INVALID_PARAM, ToolCondInit(NULL));
    pthread_cond_t cond;
    EXPECT_EQ(SYS_OK, ToolCondInit(&cond));
    GlobalMockObject::reset();
}
TEST_F(SYS_PACKAGE_TEST, ToolCondNotify)
{
    EXPECT_EQ(SYS_INVALID_PARAM, ToolCondNotify(NULL));
    pthread_cond_t cond;
    MOCKER(pthread_cond_signal).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_OK, ToolCondNotify(&cond));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolCondTimedWait_ERROR)
{
    pthread_cond_t cond;
    ToolMutex mutex;
    MOCKER(clock_gettime).stubs().will(returnValue(SYS_ERROR));
    EXPECT_EQ(SYS_ERROR, ToolCondTimedWait(&cond, &mutex, 1000));
    GlobalMockObject::reset();
}

TEST_F(SYS_PACKAGE_TEST, ToolLChownPath)
{
    MOCKER(ToolGetUserGroupId).stubs().will(returnValue(SYS_OK));
    MOCKER(lchown).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(SYS_OK, ToolLChownPath("/test"));
}