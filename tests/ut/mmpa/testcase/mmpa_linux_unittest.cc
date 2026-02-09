/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "mmpa_api.h"
#include <gtest/gtest.h>
#include <mockcpp/mockcpp.hpp>
#include <mockcpp/ChainingMockHelper.h>
#include <gtest/gtest_pred_impl.h>
#include <arpa/inet.h>
#include "stub/mmpa_linux_stubtest.h"

#define wszDrive "/dev/sda"
#define mmIoctlStruct unsigned long long
#define MM_CMD_GET_DISKINFO BLKGETSIZE64
#define MMPA_SECOND_TO_NSEC 1000000000
using namespace testing;
using namespace std;

int add(int a, int b)
{
  return (a + b);
}

class Utest_mmpa_linux : public testing::Test
{
    public:
        Utest_mmpa_linux(){}
    protected:
        virtual void SetUp(){}
        virtual void TearDown()
            {
                GlobalMockObject::verify();
                GlobalMockObject::reset();
            }
    protected:
};

TEST_F(Utest_mmpa_linux, Utest_mmCreateTask_01)
{
    mmThread stThreadHandle;
    mmUserBlock_t stFuncBlock;
    stFuncBlock.procFunc = UTtest_callback;
    stFuncBlock.pulArg = NULL;
    INT32 ret = mmCreateTask(&stThreadHandle, &stFuncBlock);
    ASSERT_EQ(EN_OK, ret);
    ret = mmGetPid();
    EXPECT_TRUE( ret >=  0 );
    ret = mmGetTid();
    EXPECT_TRUE( ret >= 0 );

    MOCKER((long int (*)(long int))syscall)
              .stubs()
          .will(returnValue(EN_ERROR));
    ret = mmGetTid();
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    mmSystemTime_t st;
    ret = mmGetLocalTime(&st);
    ASSERT_EQ(EN_OK, ret);
    ret = mmJoinTask(&stThreadHandle);
    ASSERT_EQ(EN_OK, ret);

    char threadName[MMPA_THREADNAME_SIZE] = "hello-mmpa";
    MOCKER((int (*)(char*))prctl)
          .stubs()
          .will(returnValue(EN_ERROR));
    ret = mmSetCurrentThreadName(threadName);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    ret = mmSetCurrentThreadName(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    ret = mmGetCurrentThreadName(NULL,0);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER((int (*)(char*))prctl)
          .stubs()
          .will(returnValue(EN_ERROR));
    ret = mmGetCurrentThreadName(threadName,MMPA_THREADNAME_SIZE);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmCreateTask_02)
{
    mmThread stThreadHandle ;
    mmUserBlock_t stFuncBlock;
    stFuncBlock.pulArg = NULL;
    INT32 ret = mmCreateTask(NULL, &stFuncBlock);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    mmSystemTime_t st;
    ret = mmGetLocalTime(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret = mmJoinTask(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);


    MOCKER(localtime_r)
        .stubs()
        .will(returnValue((struct tm*)NULL));
    ret = mmGetLocalTime(&st);
    ASSERT_EQ(EN_ERROR, ret);

	GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmCreateTask_03)
{
    mmThread stThreadHandle;
    mmUserBlock_t stFuncBlock;
    MOCKER(pthread_create)
        .stubs()
        .will(returnValue(EN_ERROR));
    stFuncBlock.procFunc = UTtest_callback;
    stFuncBlock.pulArg = NULL;
    INT32 ret = mmCreateTask(&stThreadHandle, &stFuncBlock);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmJoinTask_01)
{
    mmThread stThreadHandle;
    mmUserBlock_t stFuncBlock;
    stFuncBlock.procFunc = UTtest_callback;
    stFuncBlock.pulArg = NULL;
    INT32 ret = mmCreateTask(&stThreadHandle, &stFuncBlock);
    ASSERT_EQ(EN_OK, ret);
    MOCKER(pthread_join)
          .stubs()
          .will(returnValue(EN_ERROR));
    ret = mmJoinTask(&stThreadHandle);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
    ret = mmJoinTask(&stThreadHandle);
    ASSERT_EQ(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmMutexInit_01)
{
    mmMutex_t mutex;
    INT32 ret = mmMutexInit(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret = mmMutexLock(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret = mmMutexUnLock(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret = mmMutexDestroy(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmCondLockInit_01)
{
    mmMutexFC  cs;
    INT32 ret = mmCondLockInit(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret = mmCondLock(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret = mmCondUnLock(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret = mmCondLockDestroy(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
}

TEST_F(Utest_mmpa_linux,Utest_mmCreateTaskWithAttr_01)
{
    INT32 ret = mmCreateTaskWithAttr(NULL,NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmMutexUnLock_01)
{
    mmMutex_t mutex;
    MOCKER(pthread_mutex_init)
          .stubs()
          .will(returnValue(EN_ERROR));
    INT32 ret = mmMutexInit(&mutex);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
    ret = mmMutexInit(&mutex);
    ASSERT_EQ(EN_OK, ret);

    MOCKER(pthread_mutex_lock)
        .stubs()
        .will(returnValue(EN_ERROR));
    ret = mmMutexLock(&mutex);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
    ret = mmMutexLock(&mutex);
    ASSERT_EQ(EN_OK, ret);

    MOCKER(pthread_mutex_unlock)
        .stubs()
        .will(returnValue(EN_ERROR));
    ret = mmMutexUnLock(&mutex);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
    ret = mmMutexUnLock(&mutex);
    ASSERT_EQ(EN_OK, ret);

    MOCKER(pthread_mutex_destroy)
          .stubs()
          .will(returnValue(EN_ERROR));
    ret = mmMutexDestroy(&mutex);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
    ret = mmMutexDestroy(&mutex);
    ASSERT_EQ(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmMutexTryLock_01)
{
  mmMutex_t mutex;
  MOCKER(pthread_mutex_init)
      .stubs()
      .will(returnValue(EN_ERROR));
  INT32 ret = mmMutexInit(&mutex);
  ASSERT_EQ(EN_ERROR, ret);
  GlobalMockObject::reset();
  ret = mmMutexInit(&mutex);
  ASSERT_EQ(EN_OK, ret);

  MOCKER(pthread_mutex_trylock)
      .stubs()
      .will(returnValue(EN_ERROR));
  ret = mmMutexTryLock(&mutex);
  ASSERT_EQ(EN_ERROR, ret);
  GlobalMockObject::reset();
  ret = mmMutexTryLock(&mutex);
  ASSERT_EQ(EN_OK, ret);

  MOCKER(pthread_mutex_unlock)
      .stubs()
      .will(returnValue(EN_ERROR));
  ret = mmMutexUnLock(&mutex);
  ASSERT_EQ(EN_ERROR, ret);
  GlobalMockObject::reset();
  ret = mmMutexUnLock(&mutex);
  ASSERT_EQ(EN_OK, ret);

  MOCKER(pthread_mutex_destroy)
      .stubs()
      .will(returnValue(EN_ERROR));
  ret = mmMutexDestroy(&mutex);
  ASSERT_EQ(EN_ERROR, ret);
  GlobalMockObject::reset();
  ret = mmMutexDestroy(&mutex);
  ASSERT_EQ(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmRWLockInit_01)
{
  mmRWLock_t mutex;
  MOCKER(pthread_rwlock_init)
      .stubs()
      .will(returnValue(EN_ERROR));
  INT32 ret = mmRWLockInit(&mutex);
  ASSERT_EQ(EN_ERROR, ret);
  GlobalMockObject::reset();
  ret = mmRWLockInit(&mutex);
  ASSERT_EQ(EN_OK, ret);

  MOCKER(pthread_rwlock_rdlock)
      .stubs()
      .will(returnValue(EN_ERROR));
  ret = mmRWLockRDLock(&mutex);
  ASSERT_EQ(EN_ERROR, ret);
  GlobalMockObject::reset();
  ret = mmRWLockRDLock(&mutex);
  ASSERT_EQ(EN_OK, ret);

  MOCKER(pthread_rwlock_unlock)
      .stubs()
      .will(returnValue(EN_ERROR));
  ret = mmRDLockUnLock(&mutex);
  ASSERT_EQ(EN_ERROR, ret);
  GlobalMockObject::reset();
  ret = mmRDLockUnLock(&mutex);
  ASSERT_EQ(EN_OK, ret);

  MOCKER(pthread_rwlock_destroy)
      .stubs()
      .will(returnValue(EN_ERROR));
  ret = mmRWLockDestroy(&mutex);
  ASSERT_EQ(EN_ERROR, ret);
  GlobalMockObject::reset();
  ret = mmRWLockDestroy(&mutex);
  ASSERT_EQ(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmRWLockInit_02)
{
  mmRWLock_t mutex;
  MOCKER(pthread_rwlock_init)
      .stubs()
      .will(returnValue(EN_ERROR));
  INT32 ret = mmRWLockInit(&mutex);
  ASSERT_EQ(EN_ERROR, ret);
  GlobalMockObject::reset();
  ret = mmRWLockInit(&mutex);
  ASSERT_EQ(EN_OK, ret);

  MOCKER(pthread_rwlock_tryrdlock)
      .stubs()
      .will(returnValue(EN_ERROR));
  ret = mmRWLockTryRDLock(&mutex);
  ASSERT_EQ(EN_ERROR, ret);
  GlobalMockObject::reset();
  ret = mmRWLockTryRDLock(&mutex);
  ASSERT_EQ(EN_OK, ret);

  MOCKER(pthread_rwlock_unlock)
      .stubs()
      .will(returnValue(EN_ERROR));
  ret = mmRDLockUnLock(&mutex);
  ASSERT_EQ(EN_ERROR, ret);
  GlobalMockObject::reset();
  ret = mmRDLockUnLock(&mutex);
  ASSERT_EQ(EN_OK, ret);

  MOCKER(pthread_rwlock_destroy)
      .stubs()
      .will(returnValue(EN_ERROR));
  ret = mmRWLockDestroy(&mutex);
  ASSERT_EQ(EN_ERROR, ret);
  GlobalMockObject::reset();
  ret = mmRWLockDestroy(&mutex);
  ASSERT_EQ(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmRWLockInit_03)
{
  mmRWLock_t mutex;
  MOCKER(pthread_rwlock_init)
      .stubs()
      .will(returnValue(EN_ERROR));
  INT32 ret = mmRWLockInit(&mutex);
  ASSERT_EQ(EN_ERROR, ret);
  GlobalMockObject::reset();
  ret = mmRWLockInit(&mutex);
  ASSERT_EQ(EN_OK, ret);

  MOCKER(pthread_rwlock_wrlock)
      .stubs()
      .will(returnValue(EN_ERROR));
  ret = mmRWLockWRLock(&mutex);
  ASSERT_EQ(EN_ERROR, ret);
  GlobalMockObject::reset();
  ret = mmRWLockWRLock(&mutex);
  ASSERT_EQ(EN_OK, ret);

  MOCKER(pthread_rwlock_unlock)
      .stubs()
      .will(returnValue(EN_ERROR));
  ret = mmWRLockUnLock(&mutex);
  ASSERT_EQ(EN_ERROR, ret);
  GlobalMockObject::reset();
  ret = mmWRLockUnLock(&mutex);
  ASSERT_EQ(EN_OK, ret);

  MOCKER(pthread_rwlock_destroy)
      .stubs()
      .will(returnValue(EN_ERROR));
  ret = mmRWLockDestroy(&mutex);
  ASSERT_EQ(EN_ERROR, ret);
  GlobalMockObject::reset();
  ret = mmRWLockDestroy(&mutex);
  ASSERT_EQ(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmRWLockInit_04)
{
  mmRWLock_t mutex;
  MOCKER(pthread_rwlock_init)
      .stubs()
      .will(returnValue(EN_ERROR));
  INT32 ret = mmRWLockInit(&mutex);
  ASSERT_EQ(EN_ERROR, ret);
  GlobalMockObject::reset();
  ret = mmRWLockInit(&mutex);
  ASSERT_EQ(EN_OK, ret);

  MOCKER(pthread_rwlock_trywrlock)
      .stubs()
      .will(returnValue(EN_ERROR));
  ret = mmRWLockTryWRLock(&mutex);
  ASSERT_EQ(EN_ERROR, ret);
  GlobalMockObject::reset();
  ret = mmRWLockTryWRLock(&mutex);
  ASSERT_EQ(EN_OK, ret);

  MOCKER(pthread_rwlock_unlock)
      .stubs()
      .will(returnValue(EN_ERROR));
  ret = mmWRLockUnLock(&mutex);
  ASSERT_EQ(EN_ERROR, ret);
  GlobalMockObject::reset();
  ret = mmWRLockUnLock(&mutex);
  ASSERT_EQ(EN_OK, ret);

  MOCKER(pthread_rwlock_destroy)
      .stubs()
      .will(returnValue(EN_ERROR));
  ret = mmRWLockDestroy(&mutex);
  ASSERT_EQ(EN_ERROR, ret);
  GlobalMockObject::reset();
  ret = mmRWLockDestroy(&mutex);
  ASSERT_EQ(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmCondLock_01)
{
    mmMutexFC  cs;
    MOCKER(pthread_mutex_init)
          .stubs()
          .will(returnValue(EN_ERROR));
    INT32 ret = mmCondLockInit(&cs);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
    ret = mmCondLockInit(&cs);
    ASSERT_EQ(EN_OK, ret);

    MOCKER(pthread_mutex_lock)
        .stubs()
        .will(returnValue(EN_ERROR));
    ret = mmCondLock(&cs);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
    ret = mmCondLock(&cs);
    ASSERT_EQ(EN_OK, ret);

    MOCKER(pthread_mutex_unlock)
        .stubs()
        .will(returnValue(EN_ERROR));
    ret = mmCondUnLock(&cs);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
    ret = mmCondUnLock(&cs);
    ASSERT_EQ(EN_OK, ret);

    MOCKER(pthread_mutex_destroy)
          .stubs()
          .will(returnValue(EN_ERROR));
    ret = mmCondLockDestroy(&cs);
    GlobalMockObject::reset();
    ret = mmCondLockDestroy(&cs);
    ASSERT_EQ(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmCondInit_01)
{
    mmCond cond;
    mmMutexFC mutexFc;
    INT32 ret = mmCondInit(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(pthread_condattr_init)
          .stubs()
          .will(returnValue(-1));
    ret = mmCondInit(&cond);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    MOCKER(pthread_condattr_setclock)
          .stubs()
          .will(returnValue(-1));
    ret = mmCondInit(&cond);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    ret = mmCondTimedWait(NULL, NULL, 3000);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(clock_gettime)
          .stubs()
          .will(returnValue(-1));
    ret = mmCondTimedWait(&cond, &mutexFc, 3000);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();



    ret = mmCondNotify(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret = mmCondWait(NULL,NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret = mmCondNotifyAll(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret = mmCondDestroy(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmCondInit_02)
{
    INT32 ret = mmCondInit(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret = mmCondTimedWait(NULL,NULL, 3000);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret = mmCondNotify(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret = mmCondWait(NULL,NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret = mmCondNotifyAll(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret = mmCondDestroy(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmCondDestroy_01)
{
    mmCond Cond;

    mmCondInit(&Cond);
    MOCKER(pthread_cond_destroy)
          .stubs()
          .will(returnValue(EN_ERROR));
    INT32 ret = mmCondDestroy(&Cond);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    ret = mmCondDestroy(&Cond);
    ASSERT_EQ(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmCondNotify_01)
{
    mmCond cv;
    mmMutexFC cs;

    MOCKER(pthread_cond_init)
          .stubs()
          .will(returnValue(EN_ERROR));
    INT32 ret = mmCondInit(&cv);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    MOCKER(pthread_cond_wait)
          .stubs()
          .will(returnValue(EN_ERROR));
    ret = mmCondWait(&cv, &cs);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    MOCKER(pthread_cond_signal)
          .stubs()
          .will(returnValue(EN_ERROR));
    ret = mmCondNotify(&cv);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmCondNotify_02)
{
    mmCond cv;
    mmMutexFC cs;

    MOCKER(pthread_cond_broadcast)
          .stubs()
          .will(returnValue(EN_ERROR));
    INT32 ret = mmCondNotifyAll(&cv);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

}

TEST_F(Utest_mmpa_linux, Utest_mmSemInit_01)
{
    mmSem_t sem;

    MOCKER(sem_init)
           .stubs()
           .will(returnValue(EN_ERROR));
    INT32 ret = mmSemInit(&sem,1);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
    ret = mmSemInit(&sem,1);
    ASSERT_EQ(EN_OK, ret);

    MOCKER(sem_wait)
           .stubs()
           .will(returnValue(EN_ERROR));
    ret = mmSemWait(&sem);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
    ret = mmSemWait(&sem);
    ASSERT_EQ(EN_OK, ret);

    MOCKER(sem_post)
           .stubs()
           .will(returnValue(EN_ERROR));
    ret = mmSemPost(&sem);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
    ret = mmSemPost(&sem);
    ASSERT_EQ(EN_OK, ret);

    MOCKER(sem_destroy)
           .stubs()
           .will(returnValue(EN_ERROR));
    ret = mmSemDestroy(&sem);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
    ret = mmSemDestroy(&sem);
    ASSERT_EQ(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmSemInit_02)
{
    mmSem_t sem;
    INT32 ret = mmSemInit(NULL, 1);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret = mmSemWait(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret = mmSemPost(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret = mmSemDestroy(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret = mmSleep(0);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmOpen_01)
{
    char myString[40];
    UINT32 length;

    MOCKER((int (*)(const char*, int))open)
          .stubs()
          .will(returnValue(EN_ERROR));
    INT32 fd = mmOpen((CHAR*)("../tests/ut/mmpa/testcase/test.txt"), O_RDWR);
    ASSERT_EQ(EN_ERROR, fd);
    GlobalMockObject::reset();
    fd = mmOpen((CHAR*)("../tests/ut/mmpa/testcase/test.txt"), O_CREAT | O_RDWR);
    EXPECT_TRUE(fd >= 0);

    strcpy_s(myString, sizeof(myString), "hello, mmpa!\n");
    length = strlen(myString);

    INT32 ret = mmWrite(HANDLE_INVALID_VALUE, myString, length);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(write)
          .stubs()
          .will(returnValue(EN_ERROR));
    ret = mmWrite(fd, myString, length);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
    ret = mmWrite(fd, myString, length);
    EXPECT_TRUE(ret > 0);

    ret = mmClose(fd);
    ASSERT_EQ(EN_OK, ret);

    fd = mmOpen((CHAR*)("../tests/ut/mmpa/testcase/test.txt"), O_RDWR);
    EXPECT_TRUE(fd >= 0);

    ret = mmRead(HANDLE_INVALID_VALUE, myString, length);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(read)
          .stubs()
          .will(returnValue(EN_ERROR));
    ret = mmRead(fd, myString, length);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
    memset_s(myString, sizeof(myString), 0, 40);
    ret = mmRead(fd, myString, length);
    EXPECT_TRUE(ret > 0);

    MOCKER(close)
          .stubs()
          .will(returnValue(EN_ERROR));
    ret = mmClose(fd);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
    ret = mmClose(fd);
    ASSERT_EQ(EN_OK, ret);

    ret = mmSleep(3000);
    ASSERT_EQ(EN_OK, ret);
    rmdir("../tests/ut/mmpa/testcase/test.txt");
}

TEST_F(Utest_mmpa_linux, Utest_mmOpen_02)
{

    INT32 fd = mmOpen(NULL, (INT32)O_RDWR);
    ASSERT_EQ(EN_INVALID_PARAM, fd);
    INT ret = mmClose(fd);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmOpen_03)
{
    INT32 fd = mmOpen((CHAR*)("../tests/ut/mmpa/testcase/test.txt"), 16);
    ASSERT_EQ(EN_INVALID_PARAM, fd);

    fd = mmOpen((CHAR*)("../tests/ut/mmpa/testcase/test.txt"), 0);
    EXPECT_TRUE(fd >= 0);

    INT ret = mmClose(fd);
    ASSERT_EQ(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmOpen2_01)
{
    char myString[40];
    UINT32 length;
    int ret;
    MOCKER((int (*)(const char*, int, int))open)
          .stubs()
          .will(returnValue(EN_ERROR));
    INT32 fd = mmOpen2((CHAR*)("../tests/ut/mmpa/testcase/test.txt"), O_RDWR, M_IREAD | M_IWRITE);
    ASSERT_EQ(EN_ERROR, fd);
    GlobalMockObject::reset();

    fd = mmOpen2((CHAR*)("../tests/ut/mmpa/testcase/test.txt"), O_CREAT | O_RDWR, 0);
    ASSERT_EQ(EN_INVALID_PARAM, fd);

    fd = mmOpen2(NULL, O_CREAT | O_RDWR, 0);
    ASSERT_EQ(EN_INVALID_PARAM, fd);

    fd = mmOpen2((CHAR*)("../tests/ut/mmpa/testcase/test.txt"), 16 ,M_IREAD | M_IWRITE);
    ASSERT_EQ(EN_INVALID_PARAM, fd);

    fd = mmOpen2((CHAR*)("../tests/ut/mmpa/testcase/test.txt"), 0, M_IREAD | M_IWRITE);
    EXPECT_TRUE(fd >= 0);

    ret = mmClose(fd);
    ASSERT_EQ(EN_OK, ret);

    fd = mmOpen2((CHAR*)("../tests/ut/mmpa/testcase/test.txt"), O_CREAT | O_RDWR,  M_IREAD | M_IWRITE);
    EXPECT_TRUE(fd >= 0);

    ret = mmClose(fd);
    ASSERT_EQ(EN_OK, ret);

}

TEST_F(Utest_mmpa_linux, Utest_mmSocket_01)
{
    mmSockHandle listenfd, connfd,  sockfd;
    INT32 ret = EN_OK;

    mmThread stThreadHandleServer, stThreadHandleClient;
    mmUserBlock_t stFuncBlockServer, stFuncBlockClient;
    INT32 p = getIdleSocketid();
    ret = mmSAStartup();
    ASSERT_EQ(EN_OK, ret);

    stFuncBlockServer.procFunc = server_socket;
    stFuncBlockServer.pulArg = &p;
    stFuncBlockClient.procFunc = client_socket;
    stFuncBlockClient.pulArg = &p;

    ret = mmCreateTask(&stThreadHandleServer, &stFuncBlockServer);
    ASSERT_EQ(EN_OK, ret);
    ret = mmCreateTask(&stThreadHandleClient, &stFuncBlockClient);
    ASSERT_EQ(EN_OK, ret);
    ret = mmJoinTask(&stThreadHandleServer);
    ASSERT_EQ(EN_OK, ret);
    ret = mmJoinTask(&stThreadHandleClient);
    ASSERT_EQ(EN_OK, ret);
    ret = mmSACleanup();
    ASSERT_EQ(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmSocket_02)
{
    mmSockHandle listenfd, connfd;
    struct sockaddr_in serv_add;
    mmSocklen_t stAddrLen = sizeof(serv_add);

    MOCKER(socket)
          .stubs()
          .will(returnValue(EN_ERROR));
    listenfd = mmSocket(AF_INET, SOCK_STREAM, 0);
    ASSERT_EQ(EN_ERROR, listenfd);
    GlobalMockObject::reset();

    listenfd = mmSocket(AF_INET, SOCK_STREAM, 0);
    EXPECT_TRUE(listenfd >= 0);
    memset_s(&serv_add, sizeof(serv_add), '0', sizeof(serv_add));
    INT32 p = getIdleSocketid();
    serv_add.sin_family = AF_INET;
    serv_add.sin_addr.s_addr = 0;
    serv_add.sin_port = htons(p);

    INT32 ret = mmBind(HANDLE_INVALID_VALUE, (mmSockAddr*)&serv_add, stAddrLen);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    GlobalMockObject::reset();

    ret = mmBind(listenfd, (mmSockAddr*)&serv_add, stAddrLen);
    ASSERT_EQ(EN_OK, ret);

    ret = mmListen(HANDLE_INVALID_VALUE, 5);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(listen)
          .stubs()
          .will(returnValue(EN_ERROR));
    ret = mmListen(listenfd, 5);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    ret = mmListen(listenfd, 5);
    ASSERT_EQ(EN_OK, ret);

    connfd = mmAccept(HANDLE_INVALID_VALUE, (mmSockAddr*)NULL, NULL);
    ASSERT_EQ(EN_INVALID_PARAM, connfd);

    MOCKER(accept)
          .stubs()
          .will(returnValue(EN_ERROR));
    connfd = mmAccept(listenfd, (mmSockAddr*)NULL, NULL);
    ASSERT_EQ(EN_ERROR, connfd);
    GlobalMockObject::reset();

    ret = mmCloseSocket(HANDLE_INVALID_VALUE);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(close)
          .stubs()
          .will(returnValue(EN_ERROR));
    ret = mmCloseSocket(listenfd);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    ret = mmCloseSocket(listenfd);
    ASSERT_EQ(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmSocket_03)
{
    mmSockHandle sockfd;
    struct sockaddr_in serv_add;
    memset_s(&serv_add, sizeof(serv_add), '0', sizeof(serv_add));
    sockfd = mmSocket(AF_INET, SOCK_STREAM, 0);
    EXPECT_TRUE(sockfd >= 0);
    INT32 p = getIdleSocketid();

    serv_add.sin_family = AF_INET;
    inet_aton("127.0.0.1", (struct in_addr *)&serv_add.sin_addr);
    serv_add.sin_port = htons(p);

    INT32 ret = mmConnect(HANDLE_INVALID_VALUE, (mmSockAddr*)&serv_add, sizeof(serv_add));
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(connect)
          .stubs()
          .will(returnValue(EN_ERROR));
    ret = mmConnect(sockfd, (mmSockAddr*)&serv_add, sizeof(serv_add));
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmSocket_04)
{
    char msg[50] = {"hello.mmpa!"};
    INT32 result = 0;

    result =  mmSocketSend(-1, msg, 50, 0);
    ASSERT_EQ(EN_INVALID_PARAM, result);

    result =  mmSocketRecv(1, NULL, 50, 0);
    ASSERT_EQ(EN_INVALID_PARAM, result);

    MOCKER(send)
          .stubs()
          .will(returnValue(EN_ERROR));
    result =  mmSocketSend(1, msg, 50, 0);
    ASSERT_EQ(EN_ERROR, result);

    MOCKER(recv)
          .stubs()
          .will(returnValue(EN_ERROR));
    result =  mmSocketRecv(1, msg, 50, 0);
    ASSERT_EQ(EN_ERROR, result);

    GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmSocketSend_01)
{
  char msg[50] = {"hello.mmpa!"};
  INT32 result = 0;

  result =  mmSocketSendTo(-1, msg, 50, 0, NULL, 0);
  ASSERT_EQ(EN_INVALID_PARAM, result);

  result =  mmSocketRecvFrom(1, NULL, 50, 0, NULL, NULL);
  ASSERT_EQ(EN_INVALID_PARAM, result);

  mmSockAddr addr;

  MOCKER(sendto)
      .stubs()
      .will(returnValue(EN_ERROR));
  result =  mmSocketSendTo(1, msg, 50, 0, &addr, 50);
  ASSERT_EQ(EN_ERROR, result);

  mmSockAddr addr1;
  mmSocklen_t FromLen;
  MOCKER(recvfrom)
      .stubs()
      .will(returnValue(EN_ERROR));
  result =  mmSocketRecvFrom(1, msg, 50, 0, &addr1, &FromLen);
  ASSERT_EQ(EN_ERROR, result);

  GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmDlopen_01)
{
    VOID* handle = NULL;
    VOID* funcPoint = NULL;
    CHAR* error = NULL;
    handle = mmDlopen((CHAR*)("tests/ut/mmpa/add/libadd.so"),RTLD_LAZY);
    EXPECT_TRUE(NULL != handle);
    funcPoint = mmDlsym(handle, (CHAR*)("add"));
    EXPECT_TRUE(NULL != funcPoint);
    INT32 ret = mmDlclose(handle);
    ASSERT_EQ(EN_OK, ret);
    error = mmDlerror();
    EXPECT_TRUE(NULL == error);

}

TEST_F(Utest_mmpa_linux, Utest_mmDlopen_02)
{
    VOID* handle = NULL;
    VOID* funcPoint = NULL;
    handle = mmDlopen(NULL,RTLD_LAZY);
    EXPECT_TRUE(NULL != handle);
    funcPoint = mmDlsym(handle, (CHAR*)("add"));
    EXPECT_TRUE(NULL == funcPoint);
    INT32 ret = mmDlclose(handle);
    ASSERT_EQ(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmDlopen_03)
{
    VOID* handle = NULL;
    char* newPath = (char*)("tests/ut/mmpa/add/libadd.so");
    VOID* expectValue = NULL;
    MOCKER(dlopen)
          .stubs()
          .will(returnValue(expectValue));
    handle = mmDlopen(newPath,RTLD_LAZY);
    EXPECT_TRUE(NULL == handle);
    GlobalMockObject::reset();
}

typedef int (*FUNC)(int, int);
TEST_F(Utest_mmpa_linux, Utest_mmDlopen_04)
{
    VOID* handle = NULL;
    FUNC funcPoint = NULL;
        CHAR* error = NULL;
    int i = 1;
    int j = 2;
    int h = 0;
    handle = mmDlopen((CHAR*)"tests/ut/mmpa/add/libadd.so",1);
    EXPECT_TRUE(NULL != handle);
    funcPoint = (FUNC)mmDlsym(handle, (CHAR*)"add");
    h = funcPoint(i, j);
    ASSERT_EQ(3, h);
    EXPECT_TRUE(NULL != funcPoint);
    INT32 ret = mmDlclose(handle);
    ASSERT_EQ(EN_OK, ret);
        error = mmDlerror();
    EXPECT_TRUE(NULL == error);

}

TEST_F(Utest_mmpa_linux, Utest_mmDladdr_01)
{
    VOID* handle = NULL;
    VOID* funcPoint = NULL;
    mmDlInfo dlInfo;
    handle = mmDlopen((CHAR*)("tests/ut/mmpa/add/libadd.so"),RTLD_LAZY);
    EXPECT_TRUE(NULL != handle);
    funcPoint = mmDlsym(handle, (CHAR*)("add"));
    EXPECT_TRUE(NULL != funcPoint);
    INT32 ret = mmDladdr(funcPoint, &dlInfo);
    ASSERT_EQ(EN_OK, ret);
    ret = mmDlclose(handle);
    ASSERT_EQ(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmDladdr_02)
{
    VOID* handle = NULL;
    VOID* funcPoint = NULL;
    mmDlInfo dlInfo;
    handle = mmDlopen((CHAR*)("tests/ut/mmpa/add/libadd.so"),RTLD_LAZY);
    EXPECT_TRUE(NULL != handle);
    funcPoint = mmDlsym(handle, (CHAR*)("add"));
    EXPECT_TRUE(NULL != funcPoint);
    INT32 ret = mmDladdr(NULL, &dlInfo);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret = mmDlclose(handle);
    ASSERT_EQ(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmDladdr_03)
{
    VOID* handle = NULL;
    mmDlInfo dlInfo;
    handle = mmDlopen((CHAR*)("tests/ut/mmpa/add/libadd.so"),RTLD_LAZY);
    EXPECT_TRUE(NULL != handle);
    INT32 ret = mmDladdr(reinterpret_cast<void *>(&add), &dlInfo);
    ASSERT_NE(EN_ERROR, ret);
    ret = mmDlclose(handle);
    ASSERT_EQ(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmDlsym_01)
{
    VOID* handle;
    char* newPath = (char*)("tests/ut/mmpa/add/libadd.so");
    VOID* expect_handle = NULL;
    MOCKER(dlsym)
          .stubs()
          .will(returnValue(expect_handle));
    handle = mmDlopen(newPath,RTLD_LAZY);
    EXPECT_TRUE(NULL != handle);
    VOID* ret = mmDlsym(handle, (CHAR*)("add"));
    EXPECT_TRUE(ret == NULL);
    GlobalMockObject::reset();

    INT32 result = mmDlclose(handle);
    ASSERT_EQ(EN_OK, result);
}

TEST_F(Utest_mmpa_linux, Utest_mmDlclose_01)
{
    VOID* handle;
    char* newPath = (char*)("tests/ut/mmpa/add/libadd.so");

    MOCKER(dlclose)
          .stubs()
          .will(returnValue(EN_ERROR));
    handle = mmDlopen(newPath,RTLD_LAZY);
    EXPECT_TRUE(NULL != handle);
    INT32 ret = mmDlclose(handle);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
    ret = mmDlclose(handle);
    ASSERT_EQ(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmStatGet_01)
{
    mmStat_t buf;
    CHAR * path = (CHAR*)("../tests/ut/mmpa/testcase/");
    CHAR * newPath = (CHAR*)("../tests/ut/mmpa/testcase/mkdir");

    INT32 ret = mmMkdir(newPath, 0755);
    ASSERT_EQ(EN_OK, ret);
    ret = mmStatGet(path, &buf);
    ASSERT_EQ(EN_OK, ret);
    rmdir(newPath);
}

TEST_F(Utest_mmpa_linux, Utest_mmStatGet_02)
{
    INT32 ret = EN_OK;

    ret = mmMkdir(NULL, 0755);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret = mmStatGet(NULL, NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmStatGet_03)
{
    mmStat_t buf;
    CHAR * path = (CHAR*)("../tests/ut/mmpa/testcase/mkdir");
    INT32 ret = mmStatGet(path, NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmStatGet_04)
{
    mmStat_t buf;
    char* path = (char*)("../tests/ut/mmpa/testcase/mkdir");
    MOCKER(stat)
        .stubs()
        .will(returnValue(EN_ERROR));
    INT32 ret = mmStatGet(path,&buf);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmStat64Get_01)
{
    mmStat64_t buf;
    CHAR * path = (CHAR*)("../tests/ut/mmpa/testcase/");
    CHAR * newPath = (CHAR*)("../tests/ut/mmpa/testcase/mkdir");

    INT32 ret = mmMkdir(newPath, 0755);
    ASSERT_EQ(EN_OK, ret);
    ret = mmStat64Get(path, &buf);
    ASSERT_EQ(EN_OK, ret);
    rmdir(newPath);
}

TEST_F(Utest_mmpa_linux, Utest_mmStat64Get_02)
{
    INT32 ret = EN_OK;

    ret = mmMkdir(NULL, 0755);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret = mmStat64Get(NULL, NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmStat64Get_03)
{
    mmStat64_t buf;
    CHAR * path = (CHAR*)("../tests/ut/mmpa/testcase/mkdir");
    INT32 ret = mmStat64Get(path, NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmStat64Get_04)
{
    mmStat64_t buf;
    char* path = (char*)("../tests/ut/mmpa/testcase/mkdir");
    MOCKER(stat64)
        .stubs()
        .will(returnValue(EN_ERROR));
    INT32 ret = mmStat64Get(path,&buf);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmFStatGet_01)
{
  mmStat_t buf;
  CHAR * newPath = (CHAR*)("tests/ut/mmpa/add/libadd.so");

  int32_t fd = mmOpen(newPath, O_RDWR);
  INT32 ret = mmFStatGet(fd, &buf);
  ASSERT_EQ(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmFStatGet_02)
{
  mmStat_t buf;
  INT32 ret = EN_OK;

  ret = mmMkdir(NULL, 0755);
  ASSERT_EQ(EN_INVALID_PARAM, ret);
  ret = mmFStatGet(-1, NULL);
  ASSERT_EQ(EN_INVALID_PARAM, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmFStatGet_03)
{
  mmStat_t buf;
  char* path = (char*)("../tests/ut/mmpa/testcase/mkdir");
  MOCKER(fstat)
      .stubs()
      .will(returnValue(EN_ERROR));
  INT32 ret = mmFStatGet(-1,&buf);
  ASSERT_EQ(EN_ERROR, ret);
  GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmMkdir_01)
{
    mmStat_t buf;
    CHAR newPath[256] = "../tests/ut/mmpa/testcase/mkdir";
    MOCKER(mkdir)
          .stubs()
          .will(returnValue(EN_ERROR));
    INT32 ret = mmMkdir(newPath, 0755);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmCreateAndSetTimer_01)
{
    mmTimer stTimerHandle;
    mmUserBlock_t stTimerBlock;

    stTimerBlock.procFunc = UTtest_callback;
    stTimerBlock.pulArg = NULL;

    INT32 ret = mmCreateAndSetTimer(&stTimerHandle, &stTimerBlock, 1000,1000);
    sleep(2);
    ASSERT_EQ(EN_OK, ret);

    ret = mmDeleteTimer(stTimerHandle);
    ASSERT_EQ(EN_OK, ret);
        sleep(1);
}

TEST_F(Utest_mmpa_linux, Utest_mmCreateAndSetTimer_02)
{
    mmTimer stTimerHandle;

    mmUserBlock_t stTimerBlock;
    stTimerBlock.procFunc = UTtest_callback;
    stTimerBlock.pulArg = NULL;

    INT32 ret = mmCreateAndSetTimer(&stTimerHandle, NULL, 0, 0);
    sleep(2);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmCreateAndSetTimer_03)
 {
    mmTimer stTimerHandle;
    mmUserBlock_t stTimerBlock;

    stTimerBlock.procFunc = UTtest_callback;
    stTimerBlock.pulArg = NULL;
    INT32 ret = mmCreateAndSetTimer(NULL, &stTimerBlock, 300, 0);
    sleep(2);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmCreateAndSetTimer_04)
{
    mmTimer stTimerHandle;
    mmUserBlock_t stTimerBlock;
    stTimerBlock.procFunc = UTtest_callback;
    stTimerBlock.pulArg = NULL;
    MOCKER(timer_create)
        .stubs()
        .will(returnValue(EN_ERROR));
    INT32 ret = mmCreateAndSetTimer(&stTimerHandle, &stTimerBlock, 300, 0);
    sleep(2);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    MOCKER(timer_create)
        .stubs()
        .will(returnValue(EN_OK));
    MOCKER(timer_settime)
        .stubs()
        .will(returnValue(EN_ERROR));
    MOCKER(timer_delete)
        .stubs()
        .will(returnValue(EN_ERROR));
    ret = mmCreateAndSetTimer(&stTimerHandle, &stTimerBlock, 300,0);
    sleep(2);
    ASSERT_EQ(EN_ERROR, ret);

    ret = mmDeleteTimer(stTimerHandle);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmSleep_01)
{
    MOCKER(usleep)
        .stubs()
        .will(returnValue(EN_ERROR));
    INT32 ret = mmSleep(MMPA_MAX_SLEEP_MILLSECOND + 1);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmCond_01)
{
    int i;
    struct node *p;

    mmThread stThreadHandleProducer;
    mmUserBlock_t stFuncBlockProducer;
    stFuncBlockProducer.procFunc = thread_func;
    stFuncBlockProducer.pulArg = NULL;
    INT32 ret = mmCondInit(&cond);
    ASSERT_EQ(ret, EN_OK);
    mmMutexInit(&mtxfc);

    mmCreateTask(&stThreadHandleProducer, &stFuncBlockProducer);
    sleep(1);
    mmMutexLock(&mtxfc);
    ret = mmCondNotify(&cond);
    ASSERT_EQ(ret, EN_OK);
    mmMutexUnLock(&mtxfc);
    sleep(1);

    printf("thread1 wanna end the cancel thread2.\n");
    pthread_cancel(stThreadHandleProducer);
    mmJoinTask(&stThreadHandleProducer);
    printf("All done--exiting\n");
}

TEST_F(Utest_mmpa_linux, Utest_mmCond_02)
{
    mmThread stThreadHandleProducer1, stThreadHandleProducer2;
    mmUserBlock_t stFuncBlockProducer1, stFuncBlockProducer2;
    stFuncBlockProducer1.procFunc = thread_func;
    stFuncBlockProducer2.procFunc = thread_func_time;
    stFuncBlockProducer1.pulArg = NULL;
    stFuncBlockProducer2.pulArg = NULL;
    INT32 ret = mmCondInit(&cond);
    ASSERT_EQ(ret, EN_OK);
    mmMutexInit(&mtxfc);

    mmCreateTask(&stThreadHandleProducer1, &stFuncBlockProducer1);
    mmCreateTask(&stThreadHandleProducer2, &stFuncBlockProducer2);
    sleep(4);
    mmMutexLock(&mtxfc);
    ret = mmCondNotifyAll(&cond);
    ASSERT_EQ(ret, EN_OK);
    mmMutexUnLock(&mtxfc);
    sleep(1);

    printf("thread1 wanna end the cancel thread2.\n");
    pthread_cancel(stThreadHandleProducer1);
    pthread_cancel(stThreadHandleProducer2);
    mmJoinTask(&stThreadHandleProducer1);
    mmJoinTask(&stThreadHandleProducer2);
    printf("All done--exiting\n");
}

TEST_F(Utest_mmpa_linux, Utest_mmCond_03)
{
    int i;
    struct node *p;

    mmThread stThreadHandleProducer;
    mmUserBlock_t stFuncBlockProducer;
    stFuncBlockProducer.procFunc = thread_func;
    stFuncBlockProducer.pulArg = NULL;
    mmCondInit(&cond);
    mmCondLockInit(&mtxfc);

    mmCreateTask(&stThreadHandleProducer, &stFuncBlockProducer);
    sleep(1);
    mmCondLock(&mtxfc);
    mmCondNotify(&cond);
    mmCondUnLock(&mtxfc);
    sleep(1);

    printf("thread1 wanna end the cancel thread2.\n");
    pthread_cancel(stThreadHandleProducer);
    mmJoinTask(&stThreadHandleProducer);
    mmCondLockDestroy(&mtxfc);
    mmCondDestroy(&cond);


    mmSystemTime_t st;
    INT32 ret = mmGetLocalTime(&st);
    ASSERT_EQ(EN_OK, ret);
        printf(("Local: %u/%u/%u %u:%u:%u %d %d\r\n"),
                     st.wYear, st.wMonth, st.wDay,
                      st.wHour, st.wMinute, st.wSecond,st.wMilliseconds,
                      st.wDayOfWeek);

}

TEST_F(Utest_mmpa_linux, Utest_mmCond_04)
{
    mmThread stThreadHandleProducer1, stThreadHandleProducer2;
    mmUserBlock_t stFuncBlockProducer1, stFuncBlockProducer2;
    stFuncBlockProducer1.procFunc = thread_func;
    stFuncBlockProducer2.procFunc = thread_func_time;
    stFuncBlockProducer1.pulArg = NULL;
    stFuncBlockProducer2.pulArg = NULL;
    INT32 ret = mmCondInit(&cond);
    ASSERT_EQ(ret, EN_OK);
    mmMutexInit(&mtxfc);

    mmCreateTask(&stThreadHandleProducer1, &stFuncBlockProducer1);
    mmCreateTask(&stThreadHandleProducer2, &stFuncBlockProducer2);
    sleep(1);
    mmMutexLock(&mtxfc);
    ret = mmCondNotifyAll(&cond);
    ASSERT_EQ(ret, EN_OK);
    mmMutexUnLock(&mtxfc);
    sleep(1);

    printf("thread1 wanna end the cancel thread2.\n");
    pthread_cancel(stThreadHandleProducer1);
    pthread_cancel(stThreadHandleProducer2);
    mmJoinTask(&stThreadHandleProducer1);
    mmJoinTask(&stThreadHandleProducer2);

    mmMutexDestroy(&mtxfc);
    ret = mmCondDestroy(&cond);
    ASSERT_EQ(ret, EN_OK);

    printf("All done--exiting\n");
}

TEST_F(Utest_mmpa_linux, Utest_mmGetProcessPrio_01)
{
    INT32 ret;
    INT32 processprio= 10;
    mmProcess pid;
    mmGetPidHandle(&pid);
    ret = mmGetPidHandle(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret = mmGetProcessPrio(pid);
    EXPECT_TRUE(ret >= -20 && ret <= 19) ;
    ret = mmSetProcessPrio(pid, processprio );
    ASSERT_EQ(EN_OK, ret);
    ret = mmGetProcessPrio(pid);
    ASSERT_EQ(processprio, ret);
    ret = mmGetProcessPrio(-12121);
    ASSERT_EQ(MMPA_PROCESS_ERROR, ret);
    ret = mmGetProcessPrio(52232323);
    ASSERT_EQ(MMPA_PROCESS_ERROR, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmGetProcessPrio_02)
{
    mmProcess pid;
    mmGetPidHandle(&pid);
    MOCKER(getpriority)
        .stubs()
        .will(returnValue(EN_ERROR));
    INT32 ret = mmGetProcessPrio(pid);
    ASSERT_EQ(EN_ERROR, ret);
    MOCKER(setpriority)
        .stubs()
        .will(returnValue(EN_ERROR));
    ret = mmSetProcessPrio(pid,10);
    ASSERT_EQ(EN_ERROR, ret);

    GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmSetProcessPrio_01)
{
    INT32 ret;
    mmProcess pid;
    mmGetPidHandle(&pid);
    ret = mmSetProcessPrio(-10,-21 );
    ASSERT_EQ(EN_INVALID_PARAM, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmRmDir_01)
{
    CHAR rmdirPath[64] = "../tests/ut/mmpa/testcase/rmdirTest";
    CHAR dirPath1[64] = "../tests/ut/mmpa/testcase/rmdirTest/test1";
    CHAR dirPath2[64] = "../tests/ut/mmpa/testcase/rmdirTest/test2";

    CHAR filePath1[64] = "../tests/ut/mmpa/testcase/rmdirTest/test1/test1.txt";
    CHAR filePath2[64] = "../tests/ut/mmpa/testcase/rmdirTest/test2/test2.txt";

    INT32 ret = mmRmdir(filePath1);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    mmRmdir(rmdirPath);
    ret = mmMkdir(rmdirPath, 0755);
    ASSERT_EQ(EN_OK, ret);

    ret = mmMkdir(dirPath1, 0755);
    printf("dirPath1  \n");
    ASSERT_EQ(EN_OK, ret);

    ret = mmMkdir(dirPath2, 0755);
    ASSERT_EQ(EN_OK, ret);
    INT32 fd = mmOpen((CHAR*)filePath1, O_CREAT | O_RDWR);
    EXPECT_TRUE(fd >= 0);
    ret = mmClose(fd);
    ASSERT_EQ(EN_OK, ret);

    fd = mmOpen((CHAR*)filePath2, O_CREAT | O_RDWR);
    EXPECT_TRUE(fd >= 0);
    ret = mmClose(fd);
    ASSERT_EQ(EN_OK, ret);

    MOCKER(rmdir)
          .stubs()
          .will(returnValue(EN_ERROR));
    ret = mmRmdir(rmdirPath);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    MOCKER(&malloc)
        .stubs()
        .will(returnValue((void*)NULL));
    ret = mmRmdir(rmdirPath);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    GlobalMockObject::reset();

    MOCKER(&memset_s)
       .stubs()
       .will(returnValue(EN_ERROR));
    ret = mmRmdir(rmdirPath);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    ret = mmRmdir(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    ret = mmRmdir(rmdirPath);
    ASSERT_EQ(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmAccess_01)
{
    CHAR newPath[256] = "../tests/ut/mmpa/testcase/mmAccess";
    INT32 ret;
    mmRmdir(newPath);
    ret = mmMkdir(newPath, 0755);
    ASSERT_EQ(EN_OK, ret);
    ret = mmAccess(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret = mmAccess(newPath);
    ASSERT_EQ(EN_OK,ret);
    ret = mmRmdir(newPath);
    ASSERT_EQ(EN_OK, ret);
    ret = mmAccess(newPath);
    ASSERT_EQ(EN_ERROR, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmAccess_02)
{
    CHAR rmdirPath[64] = "../tests/ut/mmpa/testcase/rmdirTest";
    CHAR dirPath1[64] = "../tests/ut/mmpa/testcase/rmdirTest/test1";
    INT32 ret;
    mmRmdir(rmdirPath);
    ret = mmMkdir(rmdirPath, 0755);
    ASSERT_EQ(EN_OK, ret);

    ret = mmMkdir(dirPath1, 0755);
    printf("dirPath1  \n");
    ASSERT_EQ(EN_OK, ret);
    MOCKER((int (*)(char*, long unsigned int, long unsigned int))snprintf_s)
         .stubs()
         .will(returnValue(EN_ERROR));
    ret = mmRmdir(rmdirPath);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
    mmRmdir(rmdirPath);
}

TEST_F(Utest_mmpa_linux, Utest_mmIoctl_01)
{
    mmProcess fd = 1;
    mmIoctlStruct iostrt;
    int ret = 0;
    CHAR newPath[256] = wszDrive;

    mmIoctlBuf bufStr;
    memset_s(&bufStr,sizeof(bufStr),0,sizeof(bufStr));
    bufStr.inbuf = &iostrt;
    bufStr.inbufLen = sizeof(iostrt);

    MOCKER((int (*)(int,int,char*))ioctl)
           .stubs()
           .will(returnValue(EN_OK));
    ret = mmIoctl(fd,MM_CMD_GET_DISKINFO,&bufStr);
    EXPECT_TRUE(ret >= 0);
    GlobalMockObject::reset();

    ret = mmIoctl((mmProcess)-1,MM_CMD_GET_DISKINFO,&bufStr);
    ASSERT_EQ(EN_INVALID_PARAM,ret);

    ret = mmIoctl(fd,0,&bufStr);
    ASSERT_EQ(EN_ERROR, ret);

    ret = mmGetErrorCode();

    ret = mmIoctl(fd,0,NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    bufStr.inbuf = NULL;
    ret = mmIoctl(fd,0,&bufStr);
    ASSERT_EQ(EN_INVALID_PARAM, ret);


}

int clock_gettime_stub(clockid_t clk_id, struct timespec *tp)
{
    tp->tv_sec = 0;
    tp->tv_nsec = MMPA_SECOND_TO_NSEC - 1;
    return EN_OK;
}

TEST_F(Utest_mmpa_linux, Utest_mmSemTimedWait_01)
{
    mmSem_t sem;
    INT32 ts;
    ts = 500;
    INT32 ret = mmSemInit(&sem,1);
    ASSERT_EQ(EN_OK, ret);
    MOCKER(clock_gettime)
           .stubs()
           .will(invoke(clock_gettime_stub));

    ret = mmSemTimedWait(&sem,ts);
    ASSERT_EQ(EN_OK, ret);

    ret = mmSemPost(&sem);
    ASSERT_EQ(EN_OK, ret);

    ret = mmSemDestroy(&sem);
    ASSERT_EQ(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmSemTimedWait_02)
{
    mmSem_t sem;
    INT32 ret = mmSemInit(&sem,1);
    ASSERT_EQ(EN_OK, ret);
    MOCKER(sem_trywait)
           .stubs()
           .will(returnValue(EN_ERROR))
           .then(returnValue(EN_OK));

    ret = mmSemTimedWait(&sem,3);
    ASSERT_EQ(EN_OK, ret);

    ret = mmSemPost(&sem);
    ASSERT_EQ(EN_OK, ret);

    ret = mmSemDestroy(&sem);
    ASSERT_EQ(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmSemTimedWait_03)
{
    mmSem_t sem;
    INT32 ret = mmSemInit(&sem,1);
    ASSERT_EQ(EN_OK, ret);
    MOCKER(sem_trywait)
           .stubs()
           .will(returnValue(EN_ERROR));

    ret = mmSemTimedWait(&sem,2);
    ASSERT_EQ(EN_OK, ret);

    ret = mmSemPost(&sem);
    ASSERT_EQ(EN_OK, ret);

    ret = mmSemDestroy(&sem);
    ASSERT_EQ(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmSemInit_03)
{
    mmSem_t sem;
    INT32 ts;
    ts = 0;
    INT32 ret = mmSemInit(&sem,1);
    ASSERT_EQ(EN_OK, ret);

    ret = mmSemTimedWait(NULL,ts);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    ret = mmSemTimedWait(&sem,ts);
    ASSERT_EQ(EN_OK, ret);

    ret = mmSemPost(&sem);
    ASSERT_EQ(EN_OK, ret);

    ret = mmSemDestroy(&sem);
    ASSERT_EQ(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmSemInit_04)
{
    mmSem_t sem;
    INT32 ts;
    ts = 5000;
    INT32 ret = mmSemInit(&sem, 1);
    ASSERT_EQ(EN_OK, ret);
    MOCKER(sem_trywait)
    	.stubs()
        .will(returnValue(EN_INVALID_PARAM));
    ret = mmSemTimedWait(&sem, ts);
    ASSERT_EQ(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmWritev_01)
{
    char myString[40];
    UINT32 length;
    VOID *retPoint = NULL;

    MOCKER((int (*)(const char*, int))open)
          .stubs()
          .will(returnValue(EN_ERROR));
    INT32 fd = mmOpen((CHAR*)"../tests/ut/mmpa/testcase/test.txt", O_RDWR);
    ASSERT_EQ(EN_ERROR, fd);
    GlobalMockObject::reset();
    fd = mmOpen((CHAR*)"../tests/ut/mmpa/testcase/test.txt", O_CREAT | O_RDWR);
    EXPECT_TRUE(fd >= 0);

    strcpy_s(myString, sizeof(myString), "hello, mmpa!\n");
    length = strlen(myString);

    char str0[10];
    char str1[10];
    strcpy_s(str0, sizeof(str0), "hello \n");
    strcpy_s(str1, sizeof(str1), "mmpa!\n");

    mmIovSegment iov[2];
    INT32 ret = 0;
    iov[0].sendBuf = str0;
    iov[0].sendLen = strlen(str0);
    iov[1].sendBuf = str1;
    iov[1].sendLen = strlen(str1);

    ret = mmWritev(HANDLE_INVALID_VALUE,iov,2);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(writev)
          .stubs()
          .will(returnValue(EN_ERROR));
    ret = mmWritev(fd,iov,2);
    ASSERT_EQ(EN_ERROR, ret);

    GlobalMockObject::reset();
    ret = mmWritev(fd,iov,2);
    EXPECT_TRUE(ret > 0);

    ret = mmClose(fd);
    ASSERT_EQ(EN_OK, ret);

    fd = mmOpen((CHAR*)"../tests/ut/mmpa/testcase/test.txt", O_RDWR);
    EXPECT_TRUE(fd >= 0);

    ret = mmRead(HANDLE_INVALID_VALUE, myString, length);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(read)
          .stubs()
          .will(returnValue(EN_ERROR));
    ret = mmRead(fd, myString, length);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
    memset_s(myString,40, 0, 40);
    ret = mmRead(fd, myString, length);
    EXPECT_TRUE(ret > 0);

    MOCKER(close)
          .stubs()
          .will(returnValue(EN_ERROR));
    ret = mmClose(fd);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
    ret = mmClose(fd);
    ASSERT_EQ(EN_OK, ret);

    ret = mmSleep(3000);
    ASSERT_EQ(EN_OK, ret);
    rmdir("../tests/ut/mmpa/testcase/test.txt");
}

TEST_F(Utest_mmpa_linux, Utest_mmInetAton_01)
{
    mmMb();
    char str[]="255.255.255.254";
    char str2[]="255.255.255.2552";
    mmInAddr inp;
    INT32 ret=mmInetAton(str,&inp);
    ASSERT_EQ(EN_OK, ret);
    ret=mmInetAton(NULL,&inp);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret=mmInetAton(str2,&inp);
    ASSERT_EQ(EN_ERROR, ret);
    MOCKER(inet_aton)
          .stubs()
          .will(returnValue(-1));
    ret=mmInetAton(str,&inp);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmOpenFile_01)
{
    CHAR myString[40];
    UINT32 length;
    mmOverLap oa;
    mmCreateFlag createFlag;
    createFlag.createFlag = 0;
    createFlag.oaFlag = 0;

    mmProcess fd = mmOpenFile((CHAR*)("../tests/ut/mmpa/testcase/test.txt"), M_RDWR,createFlag);
    ASSERT_EQ(EN_ERROR, fd);
    createFlag.createFlag = M_CREAT;
    fd = open((CHAR*)("../tests/ut/mmpa/testcase/test.txt"), M_RDWR | O_CREAT, S_IRWXU | S_IRWXG);
    EXPECT_TRUE(fd >= 0);

    strcpy_s(myString, sizeof(myString), "hello, mmpa!\n");
    length = strlen(myString);

    INT32 ret = mmWriteFile(HANDLE_INVALID_VALUE, myString, length);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(write)
          .stubs()
          .will(returnValue(EN_ERROR));
    ret = mmWriteFile(fd, myString, length);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
    ret = mmWriteFile(fd, myString, length);
    EXPECT_TRUE(ret > 0);

    ret = mmCloseFile(fd);
    ASSERT_EQ(EN_OK, ret);

    createFlag.createFlag = 0;
    fd = open((CHAR*)("../tests/ut/mmpa/testcase/test.txt"), M_RDWR);
    EXPECT_TRUE(fd >= 0);


    ret = mmReadFile(HANDLE_INVALID_VALUE, myString, length);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(read)
          .stubs()
          .will(returnValue(EN_ERROR));
    ret = mmReadFile(fd, myString, length);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
    memset_s(myString, sizeof(myString), 0, 40);
    ret = mmReadFile(fd, myString, length);
    EXPECT_TRUE(ret > 0);

    MOCKER(close)
          .stubs()
          .will(returnValue(EN_ERROR));
    ret = mmCloseFile(fd);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
    ret = mmCloseFile(fd);
    ASSERT_EQ(EN_OK, ret);
    ret = mmSleep(3000);
    ASSERT_EQ(EN_OK, ret);
    rmdir("../tests/ut/mmpa/testcase/test.txt");
}

TEST_F(Utest_mmpa_linux, Utest_mmOpenFile_02)
{
    INT ret = mmCloseFile(-1);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmSetData_01)
{
    mmAtomicType sum =0;
    INT32 ret= mmSetData(&sum,4);
    ASSERT_EQ(0, ret);
    ret=  mmValueInc(&sum,1);
    ASSERT_EQ(5, ret);
	printf("ret=%d,sum=%d\n", ret, sum);
    ret = mmValueSub(&sum,5);
    ASSERT_EQ(0, ret);
    ret= mmSetData(NULL,4);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret= mmValueInc(NULL,4);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret= mmValueSub(NULL,4);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmSetData64_01)
{
    mmAtomicType64 sum =0;
    INT32 ret= mmSetData64(&sum,4);
    ASSERT_EQ(0, ret);
    ret=  mmValueInc64(&sum,1);
    ASSERT_EQ(5, ret);
	printf("ret=%d,sum=%d\n", ret, sum);
    ret = mmValueSub64(&sum,5);
    ASSERT_EQ(0, ret);
    ret= mmSetData64(NULL,4);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret= mmValueInc64(NULL,4);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret= mmValueSub64(NULL,4);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmCreateTaskWithDetach_01)
{
    mmThread stThreadHandle;
    mmUserBlock_t stFuncBlock;
    INT32 pulArg = 0;
    stFuncBlock.procFunc = UTtest_callback;
    stFuncBlock.pulArg = NULL;
    INT32 ret = mmCreateTaskWithDetach(NULL, &stFuncBlock);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret = mmCreateTaskWithDetach(&stThreadHandle, &stFuncBlock);
    ASSERT_EQ(EN_OK, ret);
    sleep(1);
}

TEST_F(Utest_mmpa_linux, Utest_mmCreateTaskWithDetach_02)
{
    mmThread stThreadHandle;
    mmUserBlock_t stFuncBlock;
    stFuncBlock.procFunc = UTtest_callback;
    stFuncBlock.pulArg = NULL;

    MOCKER(pthread_attr_init)
        .stubs()
        .will(returnValue(EN_ERROR));
    INT32 ret = mmCreateTaskWithDetach(&stThreadHandle, &stFuncBlock);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    MOCKER(pthread_attr_setdetachstate)
        .stubs()
        .will(returnValue(EN_ERROR));
    ret = mmCreateTaskWithDetach(&stThreadHandle, &stFuncBlock);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    MOCKER(pthread_create)
        .stubs()
        .will(returnValue(EN_ERROR));
    ret = mmCreateTaskWithDetach(&stThreadHandle, &stFuncBlock);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();



}

TEST_F(Utest_mmpa_linux, Utest_mmPoll_01)
{
    struct ifreq ifr;
    INT32 ia = 1;
    INT32 ret = 0;
    mmSockHandle listenfd;
    listenfd = mmSocket(AF_INET, SOCK_DGRAM, 0);
    EXPECT_TRUE(listenfd >= 0);

    bzero(&ifr, sizeof(struct ifreq));
    ifr.ifr_ifindex = ia;

    mmPollfd eventfds[1];
    memset_s(eventfds, sizeof(eventfds), 0, sizeof(eventfds));
    eventfds[0].handle = listenfd;
    eventfds[0].pollType = pollTypeIoctl;
    eventfds[0].ioctlCode = SIOCGIFNAME;
    mmCompletionHandle handleIOCP = mmCreateCompletionPort();
    mmPollData polledData;
    memset_s(&polledData,sizeof(polledData),0,sizeof(mmPollData));

    polledData.buf = &ifr;
    polledData.bufLen = sizeof( struct ifreq );
    MOCKER(poll)
          .stubs()
          .will(returnValue(1));
    ret = mmPoll(eventfds, 1, 100,handleIOCP,&polledData,pollDataCallback);
    ASSERT_EQ(EN_OK, ret);

    MOCKER((int (*)(int,int,char*))ioctl)
          .stubs()
          .will(returnValue(-1));
    ret = mmPoll(eventfds, 1, 100,handleIOCP,&polledData,pollDataCallback);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    ret=mmPoll(eventfds, 0, 100,handleIOCP,&polledData,pollDataCallback);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    ret=mmPoll(NULL, 1, 100,handleIOCP,&polledData,pollDataCallback);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(poll)
          .stubs()
          .will(returnValue(-1));
    ret=mmPoll(eventfds, 1, 100,handleIOCP,&polledData,pollDataCallback);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    MOCKER(poll)
          .stubs()
          .will(returnValue(0));
    ret=mmPoll(eventfds, 1, 100,handleIOCP,&polledData,pollDataCallback);
    ASSERT_EQ(EN_ERR, ret);
    GlobalMockObject::reset();


}

TEST_F(Utest_mmpa_linux, Utest_mmPoll_02)
{

    mmSockHandle listenfd, connfd,  sockfd;
    INT32 ret = EN_OK;

    mmThread stThreadHandleServer, stThreadHandleClient;
    mmUserBlock_t stFuncBlockServer, stFuncBlockClient;
    INT32 p = getIdleSocketid();
    ret = mmSAStartup();
    ASSERT_EQ(EN_OK, ret);

    stFuncBlockServer.procFunc = poll_server_socket;
    stFuncBlockServer.pulArg = &p;
    stFuncBlockClient.procFunc = poll_client_socket;
    stFuncBlockClient.pulArg = &p;

    ret = mmCreateTask(&stThreadHandleServer, &stFuncBlockServer);
    ASSERT_EQ(EN_OK, ret);

    char socketServerName[MMPA_THREADNAME_SIZE] = "ut_ser_socket";
    char socketClientName[MMPA_THREADNAME_SIZE] = "ut_cli_socket";
    char threadName[MMPA_THREADNAME_SIZE] = {};

    ret = mmSetThreadName(&stThreadHandleServer, NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(pthread_setname_np)
          .stubs()
          .will(returnValue(EN_ERROR));
    ret = mmSetThreadName(&stThreadHandleServer, socketServerName);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    ret = mmSetThreadName(&stThreadHandleServer, socketServerName);
    ASSERT_EQ(EN_OK, ret);

    ret = mmCreateTask(&stThreadHandleClient, &stFuncBlockClient);
    ASSERT_EQ(EN_OK, ret);

    ret = mmSetThreadName(&stThreadHandleClient, socketClientName);
    ASSERT_EQ(EN_OK, ret);

    ret = mmGetThreadName(&stThreadHandleServer, threadName,0);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(pthread_getname_np)
          .stubs()
          .will(returnValue(EN_ERROR));
    ret = mmGetThreadName(&stThreadHandleServer, threadName,MMPA_THREADNAME_SIZE);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    ret = mmGetThreadName(&stThreadHandleServer, threadName,MMPA_THREADNAME_SIZE);
    ASSERT_EQ(EN_OK, ret);
    printf("server name is %s\n",threadName);

    ret = mmGetThreadName(&stThreadHandleClient, threadName,MMPA_THREADNAME_SIZE);
    ASSERT_EQ(EN_OK, ret);
    printf("client name is %s\n",threadName);

    ret = mmJoinTask(&stThreadHandleServer);
    ASSERT_EQ(EN_OK, ret);
    ret = mmJoinTask(&stThreadHandleClient);
    ASSERT_EQ(EN_OK, ret);
    ret = mmSACleanup();
    ASSERT_EQ(EN_OK, ret);


}

TEST_F(Utest_mmpa_linux, Utest_mmPoll_03)
{
    INT32 ret = EN_OK;
    INT32 fd=0;
    mmThread stThreadHandleServer, stThreadHandleClient;
    mmUserBlock_t stFuncBlockServer, stFuncBlockClient;

    stFuncBlockServer.procFunc = poll_server_pipe;
    stFuncBlockServer.pulArg = NULL;
    stFuncBlockClient.procFunc = poll_client_pipe;
    stFuncBlockClient.pulArg = NULL;

    ret = mmCreateTask(&stThreadHandleServer, &stFuncBlockServer);
    ASSERT_EQ(EN_OK, ret);

    ret = mmCreateTask(&stThreadHandleClient, &stFuncBlockClient);
    ASSERT_EQ(EN_OK, ret);
    ret = mmJoinTask(&stThreadHandleServer);
    ASSERT_EQ(EN_OK, ret);
    ret = mmJoinTask(&stThreadHandleClient);
    ASSERT_EQ(EN_OK, ret);


}

TEST_F(Utest_mmpa_linux, Utest_mmPoll_04)
{
    INT32 ret = EN_OK;
    INT32 fd=0;
    mmThread stThreadHandleServer, stThreadHandleClient;
    mmUserBlock_t stFuncBlockServer, stFuncBlockClient;

    stFuncBlockServer.procFunc = poll_server_namepipe;
    stFuncBlockServer.pulArg = NULL;
    stFuncBlockClient.procFunc = poll_client_namepipe;
    stFuncBlockClient.pulArg = NULL;

    ret = mmCreateTask(&stThreadHandleServer, &stFuncBlockServer);
    ASSERT_EQ(EN_OK, ret);

    ret = mmCreateTask(&stThreadHandleClient, &stFuncBlockClient);
    ASSERT_EQ(EN_OK, ret);
    ret = mmJoinTask(&stThreadHandleServer);
    ASSERT_EQ(EN_OK, ret);
    ret = mmJoinTask(&stThreadHandleClient);
    ASSERT_EQ(EN_OK, ret);


}

TEST_F(Utest_mmpa_linux, Utest_mmCreateNamedPipe_01)
{
    INT32 ret = EN_OK;
    char *fifo_name[MMPA_PIPE_COUNT] = {(CHAR*)"../tests/ut/mmpa/ut_read",(CHAR*)"../tests/ut/mmpa/ut_write"};
    int mode = 1;
    mmUnlink(fifo_name[0]);
    mmUnlink(fifo_name[1]);
    mmPipeHandle pipe[MMPA_PIPE_COUNT];

    MOCKER(mkfifo)
          .stubs()
          .will(returnValue(-1));
    ret=mmCreateNamedPipe(pipe,fifo_name,mode);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    MOCKER((int (*)(const char*, int))open)
          .stubs()
          .will(returnValue(0));
    ret=mmCreateNamedPipe(pipe,fifo_name,mode);
    ASSERT_EQ(EN_OK, ret);
    GlobalMockObject::reset();

    MOCKER((int (*)(const char*, int))open)
          .stubs()
          .will(returnValue(-1));
    ret=mmOpenNamePipe(pipe,fifo_name,mode);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    MOCKER(close)
          .stubs()
          .will(returnValue(-1));
    mmCloseNamedPipe(pipe);
    GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmCreatePipe_01)
{
    INT32 ret = EN_OK;
    char *fifo_name[MMPA_PIPE_COUNT] = {(CHAR*)"../tests/ut/mmpa/ut_pipe_read",(CHAR*)"../tests/ut/mmpa/ut_pipe_write"};
    int mode = 1;
    mmUnlink(fifo_name[0]);
    mmUnlink(fifo_name[1]);
    mmPipeHandle pipe[MMPA_PIPE_COUNT];

    ret=mmCreatePipe(pipe,fifo_name,MMPA_PIPE_COUNT - 1,mode);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret=mmOpenPipe(pipe,fifo_name,MMPA_PIPE_COUNT - 1,mode);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    mmClosePipe(pipe,MMPA_PIPE_COUNT - 1);

    MOCKER(mkfifo)
          .stubs()
          .will(returnValue(-1));
    ret=mmCreatePipe(pipe,fifo_name,MMPA_PIPE_COUNT,mode);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    MOCKER((int (*)(const char*, int))open)
          .stubs()
          .will(returnValue(-1));
    ret=mmCreatePipe(pipe,fifo_name,MMPA_PIPE_COUNT,mode);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    MOCKER((int (*)(const char*, int))open)
          .stubs()
          .will(returnValue(-1));
    ret=mmOpenPipe(pipe,fifo_name,MMPA_PIPE_COUNT,mode);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    MOCKER(close)
          .stubs()
          .will(returnValue(-1));
    mmClosePipe(pipe,MMPA_PIPE_COUNT);
    GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmGetTimeOfDay_01)
{
    mmTimeval tv;
    mmTimezone tz;
    INT32 ret=mmGetTimeOfDay(&tv,&tz);
    ASSERT_EQ(EN_OK, ret);
    mmSystemTime_t st;

    printf("ret=%d\n",ret);
    printf("mmGetTimeOfDay tv_sec:%ld\n",tv.tv_sec);
    printf("mmGetTimeOfDay tv_usec:%d\n",tv.tv_usec);
    mmGetLocalTime(&st);
    printf("%d-%d-%d %d-%d-%d\n ", st.wYear, st.wMonth,st.wDay, st.wHour, st.wMinute,st.wSecond);

    MOCKER(localtime_r)
        .stubs()
        .will(returnValue((struct tm*)NULL));
    ret=mmGetLocalTime(&st);;
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    ret=mmGetTimeOfDay(NULL,&tz);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    mmTimespec rts=mmGetTickCount();
    EXPECT_TRUE(rts.tv_nsec != 0);
}

TEST_F(Utest_mmpa_linux, Utest_mmGetSystemTime_01)
{
    mmTimeval tv;
    mmTimezone tz;
    INT32 ret=mmGetTimeOfDay(&tv,&tz);
    ASSERT_EQ(EN_OK, ret);
    mmSystemTime_t st;

    printf("ret=%d\n",ret);
    printf("mmGetTimeOfDay tv_sec:%ld\n",tv.tv_sec);
    printf("mmGetTimeOfDay tv_usec:%d\n",tv.tv_usec);
    mmGetSystemTime(&st);
    printf("%d-%d-%d %d-%d-%d\n ", st.wYear, st.wMonth,st.wDay, st.wHour, st.wMinute,st.wSecond);

    MOCKER(gmtime_r)
        .stubs()
        .will(returnValue((struct tm*)NULL));
    ret=mmGetSystemTime(&st);;
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
}


TEST_F(Utest_mmpa_linux, Utest_mmGetRealPath_01)
{
    char buffer_1[260] = {0};
    char *lpStr1 = buffer_1;
    char buffer_2[] = "../tests/ut/mmpa/";
    char *lpStr2 = buffer_2;
    INT32 ret=mmGetRealPath(lpStr2,lpStr1);
	printf("lpStr1= %s\n",lpStr1);
    ASSERT_EQ(EN_OK, ret);
    ret=mmGetRealPath(NULL,lpStr1);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(realpath)
          .stubs()
          .will(returnValue((char *)NULL));
    ret = mmGetRealPath(lpStr2,lpStr1);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmRealPath_01)
{
    char buffer_1[MMPA_MAX_PATH] = {0};
    char buffer_2[] = "../tests/ut/mmpa/";
    INT32 ret=mmRealPath(buffer_2,buffer_1,MMPA_MAX_PATH);
	printf("lpStr1= %s\n",buffer_1);
    ASSERT_EQ(EN_OK, ret);
    ret=mmRealPath(NULL,buffer_1,MMPA_MAX_PATH);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(realpath)
          .stubs()
          .will(returnValue((char *)NULL));
    ret = mmRealPath(buffer_2,buffer_1,MMPA_MAX_PATH);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmlseek_01)
{
    INT32 fd = -1;
    INT32 length = 0;
    INT32 ret=EN_OK;
    char myString[20]={0};

    ret=mmLseek(-1,3,SEEK_SET);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(lseek)
          .stubs()
          .will(returnValue(-1));
    ret = mmLseek(1,3,SEEK_SET);
    ASSERT_EQ(EN_ERROR, ret);

    GlobalMockObject::reset();

    fd = mmOpen((CHAR*)("../tests/ut/mmpa/testcase/test.txt"), O_CREAT | O_RDWR);
	printf("fd=%d\n",fd);
    EXPECT_TRUE(fd >= 0);

    strcpy_s(myString, sizeof(myString), "hello, mmpa!\n");
    length = strlen(myString);

    ret = mmWrite(fd, myString, length);
    ASSERT_EQ(strlen( "hello, mmpa!\n"), ret);

    ret = mmLseek(fd,3,SEEK_SET);
    ASSERT_EQ(3, ret);

    mmClose(fd);
    GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmFtruncate_01)
{
    INT32 length = 0;
    INT32 ret=EN_OK;
    CHAR myString[20]={0};

	mmCreateFlag fileFlag;
    fileFlag.createFlag = M_CREAT;
	fileFlag.oaFlag = 0;
	mmProcess pfd = 0;

    ret=mmFtruncate((mmProcess)-1,3);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(ftruncate)
          .stubs()
          .will(returnValue(-1));
    ret = mmFtruncate(1,3);
    ASSERT_EQ(EN_ERROR, ret);

    GlobalMockObject::reset();

    pfd = open((CHAR*)("../tests/ut/mmpa/testcase/test.txt"), M_RDWR | O_CREAT, S_IRWXU | S_IRWXG);
    EXPECT_TRUE(pfd >= 0);

    strcpy_s(myString, sizeof(myString), "hello, mmpa!\n");
    length = strlen(myString);

    ret = mmWriteFile(pfd, myString, length);
    ASSERT_EQ(strlen( "hello, mmpa!\n"), ret);

    ret = mmFtruncate(pfd,10);
    ASSERT_EQ(EN_OK, ret);

    mmCloseFile(pfd);
    GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmDup2_01)
{
    INT32 fd = mmOpen((CHAR*)("../tests/ut/mmpa/testcase/test.txt"), O_RDWR);
    INT32 ret = mmDup2(fd,2);
    printf("ret=%d \n",ret);
    ret = mmDup2(-2,2);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(dup2)
        .stubs()
        .will(returnValue(EN_ERROR));
    ret = mmDup2(fd,2);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    mmClose(fd);
}

TEST_F(Utest_mmpa_linux, Utest_mmDup_01)
{
    INT32 fd = mmOpen((CHAR*)("../tests/ut/mmpa/testcase/test.txt"), O_RDWR);
    INT32 ret = mmDup(-2);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(dup)
        .stubs()
        .will(returnValue(EN_ERROR));
    ret = mmDup(fd);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    mmClose(fd);

}

TEST_F(Utest_mmpa_linux, Utest_mmFileno_01)
{
    FILE *fp = fopen("../tests/ut/mmpa/testcase/test.txt", "r");
    INT32 fd = mmFileno(fp);
	EXPECT_TRUE(fd > 0);

    fd = mmFileno(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, fd);

    MOCKER(fileno)
        .stubs()
        .will(returnValue(EN_ERROR));
    fd = mmFileno(fp);
    ASSERT_EQ(EN_ERROR, fd);
    GlobalMockObject::reset();
    fclose(fp);
}

TEST_F(Utest_mmpa_linux, Utest_mmUnlink)
{
    CHAR *lpStr1 = NULL;
    INT32 ret = mmUnlink(lpStr1);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

	CHAR * newPath = (CHAR*)("../tests/ut/mmpa/testcase/unlink");
    INT32 fd = mmOpen((CHAR*)newPath, O_CREAT | O_RDWR);
	EXPECT_TRUE(fd >= 0);
    MOCKER(unlink)
        .stubs()
        .will(returnValue(EN_ERROR));
    ret = mmUnlink(newPath);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

	ret = mmClose(fd);
	ASSERT_EQ(EN_OK, ret);
	ret = mmUnlink(newPath);
	ASSERT_EQ(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmChmod)
{
    CHAR *lpStr1 = NULL;
    char lpStr2[] = "./test";
    INT32 mode = M_IWUSR;
    INT32 ret = mmChmod(lpStr1, mode);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    CHAR * newPath = (CHAR*)("../tests/ut/mmpa/testcase/chmod");
    INT32 fd = mmOpen((CHAR*)newPath, O_CREAT | O_RDWR);

    MOCKER(chmod)
        .stubs()
        .will(returnValue(EN_ERROR));
    ret = mmChmod(newPath, mode);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

	ret = mmChmod(newPath, mode);
	ASSERT_EQ(EN_OK, ret);
	ret = mmClose(fd);
	ASSERT_EQ(EN_OK, ret);
	ret = mmUnlink(newPath);
	ASSERT_EQ(EN_OK, ret);

}

TEST_F(Utest_mmpa_linux, Utest_mmLocalTimeR)
{
    time_t time_seconds = time(0);
    struct tm now_time;

    MOCKER(localtime_r)
        .stubs()
        .will(returnValue((struct tm*)NULL));
    INT32 ret = mmLocalTimeR(&time_seconds, &now_time);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    ret = mmLocalTimeR(&time_seconds, &now_time);
    ASSERT_EQ(EN_OK, ret);

    printf("%d-%d-%d %d:%d:%d\n", now_time.tm_year, now_time.tm_mon,
        now_time.tm_mday, now_time.tm_hour, now_time.tm_min,now_time.tm_sec);

    ret =  mmLocalTimeR(NULL, &now_time);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmScandir)
{
    mmDirent **entryList;
    int count;
    int i;
    char testDir[64] = "../tests/ut/mmpa/";

    count = mmScandir(NULL,&entryList,utFilter,alphasort);
    ASSERT_EQ(EN_INVALID_PARAM, count);

    MOCKER(scandir)
        .stubs()
        .will(returnValue(EN_ERROR));
    count = mmScandir(testDir,&entryList,utFilter,alphasort);
    ASSERT_EQ(EN_ERROR, count);
    GlobalMockObject::reset();


    count = mmScandir(testDir,&entryList,utFilter,alphasort);
    EXPECT_TRUE(count >= 0);

    printf("count is %d\n",count);
    for (i = 0; i < count; i++)
    {
        printf("%s\n", entryList[i]->d_name);
    }
    mmScandirFree(entryList,count);
}

TEST_F(Utest_mmpa_linux, Utest_mmScandir2)
{
    mmDirent2 **entryList;
    int count;
    int i;
    char testDir[64] = "../tests/ut/mmpa/";

    count = mmScandir2(NULL,&entryList,utFilter,alphasort);
    ASSERT_EQ(EN_INVALID_PARAM, count);

    MOCKER(scandir)
        .stubs()
        .will(returnValue(EN_ERROR));
    count = mmScandir2(testDir,&entryList,utFilter,alphasort);
    ASSERT_EQ(EN_ERROR, count);
    GlobalMockObject::reset();

    count = mmScandir2(testDir,&entryList,utFilter,alphasort);
    EXPECT_TRUE(count >= 0);

    printf("count is %d\n",count);
    for (i = 0; i < count; i++)
    {
        printf("%s\n", entryList[i]->d_name);
    }
    mmScandirFree2(entryList,count);
}

TEST_F(Utest_mmpa_linux, Utest_mmMsgQueue_01)
{
    mmMsgid ret = EN_OK;
    INT32 fd = 0;
    char buffer[64] = "hello msgqueue!";
    MOCKER(msgget)
        .stubs()
        .will(returnValue(EN_ERROR));
    ret = mmMsgCreate(0,0);
    ASSERT_EQ((mmMsgid)EN_ERROR, ret);
    GlobalMockObject::reset();

    MOCKER(msgget)
        .stubs()
        .will(returnValue(EN_ERROR));
    ret = mmMsgOpen(0,0);
    ASSERT_EQ((mmMsgid)EN_ERROR, ret);
    GlobalMockObject::reset();

    MOCKER(msgsnd)
        .stubs()
        .will(returnValue(EN_ERROR));
    ret = mmMsgSnd(0,buffer,64,0);
    ASSERT_EQ((mmMsgid)EN_ERROR, ret);
    GlobalMockObject::reset();

    MOCKER(msgrcv)
        .stubs()
        .will(returnValue(EN_ERROR));
    ret = mmMsgRcv(0,buffer,64,0);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmMsgQueue_02)
{
    INT32 ret = EN_OK;

    mmThread stThreadHandleServer, stThreadHandleClient;
    mmUserBlock_t stFuncBlockServer, stFuncBlockClient;

    stFuncBlockServer.procFunc = msgqueue_server;
    stFuncBlockServer.pulArg = NULL;
    stFuncBlockClient.procFunc = msgqueue_client;
    stFuncBlockClient.pulArg = NULL;

    ret = mmCreateTask(&stThreadHandleServer, &stFuncBlockServer);
    ASSERT_EQ(EN_OK, ret);

    ret = mmCreateTask(&stThreadHandleClient, &stFuncBlockClient);
    ASSERT_EQ(EN_OK, ret);
    ret = mmJoinTask(&stThreadHandleServer);
    ASSERT_EQ(EN_OK, ret);
    ret = mmJoinTask(&stThreadHandleClient);
    ASSERT_EQ(EN_OK, ret);

}

TEST_F(Utest_mmpa_linux, Utest_mmGetOsType)
{
    int ret = 0;
    ret = mmGetOsType();
    ASSERT_EQ(LINUX, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmTls_01)
{
    INT32 ret = EN_OK;
    char *ptrResult= NULL;
    int value = 1;
    mmThreadKey keyTest = 1111;

    ret = mmTlsSet(g_thread_log_key,NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);


    ret = mmTlsCreate(NULL, NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(pthread_key_create)
        .stubs()
        .will(returnValue(EN_ERROR));
    ret = mmTlsCreate(&g_thread_log_key,NULL);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    ret = mmTlsCreate(&g_thread_log_key, NULL);
    ASSERT_EQ(EN_OK, ret);

    ret = mmTlsDelete(keyTest);
    ASSERT_EQ(EN_ERROR, ret);

    ret = mmTlsDelete(g_thread_log_key);
    ASSERT_EQ(EN_OK, ret);

}

TEST_F(Utest_mmpa_linux, Utest_mmTls_02)
{
    INT32 ret = EN_OK;

    mmTlsCreate(&g_thread_log_key, NULL);
    ASSERT_EQ(EN_OK, ret);

    mmThread stThreadHandle[2];
    mmUserBlock_t stFuncBlock1, stFuncBlock2;

    stFuncBlock1.procFunc = tlsTestThread1;
    stFuncBlock1.pulArg = NULL;

    stFuncBlock2.procFunc = tlsTestThread2;
    stFuncBlock2.pulArg = NULL;

    ret = mmCreateTask(&stThreadHandle[0], &stFuncBlock1);
    ASSERT_EQ(EN_OK, ret);

    ret = mmCreateTask(&stThreadHandle[1], &stFuncBlock2);
    ASSERT_EQ(EN_OK, ret);

    ret = mmJoinTask(&stThreadHandle[0]);
    ASSERT_EQ(EN_OK, ret);
    ret = mmJoinTask(&stThreadHandle[1]);
    ASSERT_EQ(EN_OK, ret);

    ret = mmTlsDelete(g_thread_log_key);
    ASSERT_EQ(EN_OK, ret);

}

TEST_F(Utest_mmpa_linux, Utest_mmFsync)
{
    INT32 ret = mmFsync((mmProcess)0);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    ret = mmFsync((mmProcess)-1);
    ASSERT_EQ(EN_ERROR, ret);

    INT32 length = 0;
	ret = EN_OK;
	char myString[20] = { 0 };

	mmCreateFlag fileFlag;
	fileFlag.createFlag = M_CREAT;
	fileFlag.oaFlag = 0;
	mmProcess pfd = 0;

	pfd = open((CHAR*)("../tests/ut/mmpa/stub/test_fsync.txt"), M_RDWR | O_CREAT, S_IRWXU | S_IRWXG);

	strcpy_s(myString, sizeof(myString), "hello, mmpa!\n");
	length = strlen(myString);
	ret = mmWriteFile(pfd, myString, length);
    ASSERT_EQ(strlen("hello, mmpa!\n"), ret);

    ret = mmFsync(pfd);
    mmCloseFile(pfd);
    ASSERT_EQ(EN_OK, ret);
	mmUnlink((CHAR*)("../tests/ut/mmpa/stub/test_fsync.txt"));
}

TEST_F(Utest_mmpa_linux, Utest_mmFsync2)
{
  INT32 ret = mmFsync2((mmProcess)0);
  ASSERT_EQ(EN_INVALID_PARAM, ret);
  ret = mmFsync2((mmProcess)-1);
  ASSERT_EQ(EN_ERROR, ret);

  INT32 length = 0;
  ret = EN_OK;
  char myString[20] = { 0 };

  mmCreateFlag fileFlag;
  fileFlag.createFlag = M_CREAT;
  fileFlag.oaFlag = 0;
  mmProcess pfd = 0;

  pfd = open((CHAR*)("../tests/ut/mmpa/stub/test_fsync.txt"), M_RDWR | O_CREAT, S_IRWXU | S_IRWXG);

  strcpy_s(myString, sizeof(myString), "hello, mmpa!\n");
  length = strlen(myString);
  ret = mmWriteFile(pfd, myString, length);
  ASSERT_EQ(strlen("hello, mmpa!\n"), ret);

  ret = mmFsync2(pfd);
  mmCloseFile(pfd);
  ASSERT_EQ(EN_OK, ret);
  mmUnlink((CHAR*)("../tests/ut/mmpa/stub/test_fsync.txt"));
}

TEST_F(Utest_mmpa_linux, Utest_mmChdir)
{
    char currentDir[MMPA_MAX_PATH] = "./";
    char targetDir[] = "/var/";
    INT32 ret = mmChdir(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    ret = mmRealPath("./",currentDir,MMPA_MAX_PATH);
    ASSERT_EQ(EN_OK, ret);

    ret = mmChdir(targetDir);
    ASSERT_EQ(EN_OK, ret);

    ret = mmChdir(currentDir);
    ASSERT_EQ(EN_OK, ret);

    MOCKER(chdir)
        .stubs()
        .will(returnValue(EN_ERROR));
    ret = mmChdir(currentDir);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmUmask)
{
    INT32 lpStr1 = 0;
    INT32 ret = mmUmask(lpStr1);
    EXPECT_TRUE(ret >= 0);
}

TEST_F(Utest_mmpa_linux, Utest_mmGetEnv)
{
    char test_name_1[] = "SET_UT_TEST";
    char test_name_2[] = "ERR_UT_TEST";
    char test_value[10] = {0};

    char set_value_1[] = "test";
    char set_value_2[] = "test1234567890";

    INT32 ret = mmGetEnv(NULL, test_value, 10);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    ret = mmGetEnv(test_name_1, NULL, 10);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    ret = mmGetEnv(test_name_1, test_value,0);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    mmSetEnv(test_name_1, set_value_1, 5);
    ret = mmGetEnv(test_name_1, test_value, 10);
    ASSERT_EQ(EN_OK, ret);

    MOCKER(memcpy_s)
           .stubs()
       .will(returnValue(EN_INVALID_PARAM));
    ret = mmGetEnv(test_name_1, test_value, 10);

    ASSERT_EQ(EN_ERROR, ret);
	GlobalMockObject::reset();
    mmSetEnv(test_name_1, set_value_2, 15);
    ret = mmGetEnv(test_name_1, test_value, 10);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    ret = mmGetEnv(test_name_2, test_value, 10);
    ASSERT_EQ(EN_ERROR, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmSysEnv)
{
    // valid id
    mmEnvId id = MM_ENV_DUMP_GRAPH_PATH;
    const CHAR *value1 = "123";
    INT32 overwrite = 0;

    INT32 ret = mmSysSetEnv(id, value1, overwrite);
    ASSERT_EQ(ret, EN_OK);

    CHAR *value = mmSysGetEnv(id);
    ASSERT_TRUE(value != NULL);

    ret = mmSysUnsetEnv(id);
    ASSERT_EQ(ret, EN_OK);

    value = mmSysGetEnv(id);
    ASSERT_TRUE(value == NULL);

    // invalid id
    id = (mmEnvId)0xFFFFFFFF;

    ret = mmSysSetEnv(id, value, overwrite);
    ASSERT_EQ(ret, EN_INVALID_PARAM);

    value = mmSysGetEnv(id);
    ASSERT_TRUE(value == NULL);

    ret = mmSysUnsetEnv(id);
    ASSERT_EQ(ret, EN_INVALID_PARAM);
}

TEST_F(Utest_mmpa_linux, Utest_mmSetEnv)
{
    char test_name[] = "MY_UT_TEST";
    char test_value[] = "test";

    INT32 ret = mmSetEnv(NULL, test_value, 1);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    ret = mmSetEnv(test_name, NULL, 1);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    ret = mmSetEnv(test_name, test_value, 1);
    ASSERT_EQ(EN_OK, ret);

    MOCKER(setenv)
        .stubs()
        .will(returnValue(EN_ERROR));
    ret = mmSetEnv(test_name, test_value, 1);
    ASSERT_EQ(EN_ERROR, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmStrTokR)
{
    char pSrc[] = "this/is/jason;/i/am/doing/ut'st/test";
    char* pToken = NULL;
    char* pSave = NULL;
    const char* pDelimiter = "/";

    pToken = mmStrTokR(NULL, NULL, &pSave);
    EXPECT_TRUE(pToken == NULL);

    pToken = mmStrTokR(pSrc, pDelimiter, &pSave);
    EXPECT_TRUE(pToken!=NULL);

    printf("Begin:\n");
    while(pToken){
        printf("pToken[%s]; pSave[%s]\n",pToken,pSave);
        pToken = mmStrTokR(NULL, pDelimiter, &pSave);
    }
}

TEST_F(Utest_mmpa_linux, Utest_mmGetCwd)
{
    INT32 ret = 0;
    char bufff[260];
    ret = mmGetCwd(bufff, sizeof(bufff));
    ASSERT_EQ(EN_OK, ret);
    printf("current working directory : %s\n", bufff);

    ret = mmGetCwd(NULL, 0);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    ret = mmGetCwd(bufff, 0);
    ASSERT_EQ(EN_ERROR, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmWaitPid)
{
    mmProcess pc = 0, pr = 0;
    int status;
    pr = mmWaitPid(pc, NULL, -1);
    ASSERT_EQ(EN_INVALID_PARAM, pr);

    pr = mmWaitPid(65536, NULL, M_WAIT_NOHANG);
    printf("pr = %d\n",pr);

    pc = fork();
    if ( pc < 0 )
    {
        printf("fork error\n");
        exit(1);
        }
    else if ( pc == 0 )
    {
        printf("child --- my parent is %d\n", mmGetPid());
        sleep(3);
        exit(0);
    }
    else
    {
        do {
            printf("father --- my id is %d\n", getppid());
            pr = mmWaitPid(pc, &status, M_WAIT_NOHANG);
            if ( pr == 0 )
            {
                printf("No child exit\n");
                sleep(1);
            }
        } while (pr == 0 );

        if ( pr == EN_ERR ) {
            printf("successfully get child %d\n", pc);
            printf("status is %x\n",status);
        }
        else
            printf("wait child error\n");
    }
}

TEST_F(Utest_mmpa_linux, Utest_mmDirName)
{
    char *path = "../tests/ut/mmpa/testcase";
    char *tmp = "../tests/ut/mmpa/";
    MOCKER(dirname)
           .stubs()
       .will(returnValue(tmp));
    char *dir = mmDirName(path);
    printf("dir=%s,dirname\n",dir);
    ASSERT_NE(nullptr, dir);

    MOCKER(basename)
       .stubs()
       .will(returnValue(tmp));
    char *base = mmBaseName(path);
    printf("base=%s,basename\n",base);
    ASSERT_NE(nullptr, base);

    dir=mmDirName(nullptr);
    ASSERT_EQ(nullptr, dir);
    dir=mmBaseName(nullptr);
    ASSERT_EQ(nullptr, dir);
}

TEST_F(Utest_mmpa_linux, Utest_mmGetopt)
{
    INT32 ret;
    int argc = 2;
    char *argv[30] = { (char*)"-x -y -x",(char*)"-a -b -v" };
    char opt[] = "xyavb:o";
    ret = mmGetOpt(argc,argv,opt);
 	printf("ret =%d\n",ret);
	EXPECT_TRUE(ret > 0);
}

TEST_F(Utest_mmpa_linux, Utest_mmGetoptLong)
{
    opterr = 1;
    optind = 1;
    optopt = '?';
    optarg = NULL;

    CHAR *argv[30] = { (CHAR*)"./test", (CHAR*)"--name",(CHAR*)"qxh1",(CHAR*)"--version" ,(CHAR*)"--help"};
    INT32 c = (INT32)NULL;
    INT32 f_v = -1, f_n = -1, f_h = -1, opt_index = -1;
    mmStructOption opts[] = {
        { "version", 0, NULL, 'v' },
    { "name", 1, NULL, 'n' },
    { "help", 0, NULL, 'h' },
    {0,0,0,0},
    };
    CHAR opt[] = "vn:h";
    INT32 matchCnt = 0;
    while ((c = mmGetOptLong(5, argv, opt, opts, NULL)) != -1) {
        switch (c) {
        case 'n':
            printf("username is %s\n", optarg);
            ++matchCnt;
            break;
        case 'v':
            printf("version is 0.0.1\n");
            ++matchCnt;
            break;
        case 'h':
            printf("this is help\n");
            ++matchCnt;
            break;
        case '?':
            printf("unknown option\n");
            ++matchCnt;
            break;
        case 0:
            printf("f_v is %d \n", f_v);
            printf("f_n is %d \n", f_n);
            printf("f_h is %d \n", f_h);
            ++matchCnt;
            break;
        default:
            printf("------\n");
        }
    }
    ASSERT_EQ(matchCnt, 8);
}
TEST_F(Utest_mmpa_linux, Utest_mmGetDiskFreeSpace)
{
    char *pathname = (CHAR*)"/var/";
    struct statvfs buf;
    fsblkcnt_t total_size;
    fsblkcnt_t used_size;
    fsblkcnt_t avail_size;
    int error;
    mmDiskSize dsize = {0};
    error = mmGetDiskFreeSpace(pathname,&dsize);
    printf("error =%d \n",error);
    EXPECT_TRUE(error == EN_OK);
    printf("totalSize: %lld\n", dsize.totalSize);
    printf("availSize: %lld\n", dsize.availSize);
    printf("freeSize: %lld\n", dsize.freeSize);
    error = mmGetDiskFreeSpace(NULL,&dsize);
    EXPECT_TRUE(error == EN_INVALID_PARAM);

    MOCKER(statvfs)
           .stubs()
       .will(returnValue(-1));
    error = mmGetDiskFreeSpace(pathname,&dsize);
    ASSERT_EQ(EN_ERROR, error);
	GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmGetFileSize)
{
    char *pathname = (CHAR*)"tests/ut/mmpa/add/libadd.so";

    ULONGLONG length = 0;
    INT32 ret = mmGetFileSize(pathname,&length);
    ASSERT_EQ(EN_OK, ret);
    printf("file size is %lld,\n",length);
    ret = mmGetFileSize(NULL,&length);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(lstat)
           .stubs()
       .will(returnValue(-1));
    ret = mmGetFileSize(pathname,&length);
    ASSERT_EQ(EN_ERROR, ret);
	GlobalMockObject::reset();

}
TEST_F(Utest_mmpa_linux, Utest_mmIsDir)
{
    char *pathname = (CHAR*)"tests/ut/mmpa/add/libadd.so";
    INT32 ret = mmIsDir(pathname);
    ASSERT_EQ(EN_ERROR, ret);
    pathname = (CHAR*)"../tests/ut/mmpa/";
    ret = mmIsDir(pathname);
    ASSERT_EQ(EN_OK, ret);

    ret = mmIsDir(NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(lstat)
           .stubs()
       .will(returnValue(-1));
    ret = mmIsDir(pathname);
    ASSERT_EQ(EN_ERROR, ret);
	GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmGetOsVersion)
{
    char osVersionInfo[MMPA_MIN_OS_VERSION_SIZE] = {};
    INT32 ret = mmGetOsVersion(osVersionInfo,MMPA_MIN_OS_VERSION_SIZE);
    ASSERT_EQ(EN_OK, ret);
    printf("osVersionInfo is %s\n",osVersionInfo);

    ret = mmGetOsVersion(NULL,MMPA_MIN_OS_VERSION_SIZE);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(uname)
           .stubs()
       .will(returnValue(-1));
    ret = mmGetOsVersion(osVersionInfo,MMPA_MIN_OS_VERSION_SIZE);
    ASSERT_EQ(EN_ERROR, ret);
	GlobalMockObject::reset();


    MOCKER((int (*)(char*, long unsigned int, long unsigned int))snprintf_s)
           .stubs()
       .will(returnValue(-1));
    ret = mmGetOsVersion(osVersionInfo,MMPA_MIN_OS_VERSION_SIZE);
    ASSERT_EQ(EN_ERROR, ret);
	GlobalMockObject::reset();

}

TEST_F(Utest_mmpa_linux, Utest_mmGetOsName)
{
    char osName[MMPA_MIN_OS_NAME_SIZE] = {};
    INT32 ret = mmGetOsName(osName,MMPA_MIN_OS_NAME_SIZE);
    ASSERT_EQ(EN_OK, ret);
    printf("osName is %s\n",osName);

    ret = mmGetOsName(NULL,MMPA_MIN_OS_NAME_SIZE);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(gethostname)
           .stubs()
       .will(returnValue(-1));
    ret = mmGetOsName(osName,MMPA_MIN_OS_NAME_SIZE);
    ASSERT_EQ(EN_ERROR, ret);
	GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmGetCpuInfo_01)
{
    mmCpuDesc *desc = NULL;
    INT32 count = 0;
    int i = 0;
    INT32 ret = mmGetCpuInfo(&desc,&count);
    ASSERT_EQ(EN_OK, ret);

    for(i=0;i<count;i++){
        printf("arch[%d] is %s\n",i,desc[i].arch);
        printf("manufacturer[%d] is %s\n",i,desc[i].manufacturer);
        printf("version[%d] is %s\n",i,desc[i].version);
        printf("desc[%d].frequency is %d\n",i,desc[i].frequency);
        printf("desc[%d].ncores is %d\n",i,desc[i].ncores);
        printf("desc[%d].nthreads is %d\n",i,desc[i].nthreads);
        printf("desc[%d].ncounts is %d\n",i,desc[i].ncounts);
        printf("desc[%d].maxFrequency is %d\n",i,desc[i].maxFrequency);
    }
    ret = mmCpuInfoFree(desc,count);
    ASSERT_EQ(EN_OK, ret);

    ret = mmGetCpuInfo(&desc,NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(fopen)
           .stubs()
       .will(returnValue((FILE*)NULL));
    ret = mmGetCpuInfo(&desc,&count);
    ASSERT_EQ(EN_OK, ret);
	GlobalMockObject::reset();

    ret = mmCpuInfoFree(desc,count);
    ASSERT_EQ(EN_OK, ret);

    MOCKER(popen)
           .stubs()
       .will(returnValue((FILE*)NULL));
    ret = mmGetCpuInfo(&desc,&count);
    ASSERT_EQ(EN_OK, ret);
	GlobalMockObject::reset();

    ret = mmCpuInfoFree(desc,count);
    ASSERT_EQ(EN_OK, ret);

    MOCKER((int (*)(char*, long unsigned int, long unsigned int))snprintf_s)
         .stubs()
         .will(returnValue(EN_ERROR));
    ret = mmGetCpuInfo(&desc,&count);
    ASSERT_EQ(EN_OK, ret);
    GlobalMockObject::reset();

    ret = mmCpuInfoFree(desc,count);
    ASSERT_EQ(EN_OK, ret);

    MOCKER(strcasecmp)
           .stubs()
       .will(returnValue(0));
    ret = mmGetCpuInfo(&desc,&count);
    ASSERT_EQ(EN_OK, ret);
    GlobalMockObject::reset();

    ret = mmCpuInfoFree(desc,count);
    ASSERT_EQ(EN_OK, ret);

}

TEST_F(Utest_mmpa_linux, Utest_mmGetCpuInfo_02)
{
    mmCpuDesc *desc = NULL;
    INT32 count = 0;
    INT32 ret = 0;

    MOCKER(malloc)
           .stubs()
       .will(returnValue((void*)NULL));
    ret = mmGetCpuInfo(&desc,&count);
    printf("mmGetCpuInfo ret = %d\n",ret);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    MOCKER(memcpy_s)
           .stubs()
       .will(returnValue(-1));
    ret = mmGetCpuInfo(&desc,&count);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    ret = mmCpuInfoFree(NULL,count);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
}

int atoiStub(const char *nptr)
{
    return 4096;
}

TEST_F(Utest_mmpa_linux, Utest_mmGetMac_01)
{
    mmMacInfo *list = NULL;
    int count = 0;
    int i = 0;

    int ret = mmGetMac(&list,&count);
    ASSERT_EQ(EN_OK, ret);

    for(i=0;i<count;i++){
        printf("%d,Mac address : %s \n",i,list[i].addr);
    }
    ret = mmGetMacFree(list,count);
    ASSERT_EQ(EN_OK, ret);
    list = NULL;

    ret = mmGetMac(NULL,&count);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    ret = mmGetMacFree(NULL,count);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(socket)
           .stubs()
       .will(returnValue(-1));
    ret = mmGetMac(&list,&count);
    ASSERT_EQ(EN_ERROR, ret);
	GlobalMockObject::reset();

}

TEST_F(Utest_mmpa_linux, Utest_mmGetMac_02)
{

    mmMacInfo *list = NULL;
    int count = 0;
    int i = 0;
    int ret = 0;

    MOCKER(malloc)
           .stubs()
       .will(returnValue((void*)NULL));
    ret = mmGetMac(&list,&count);
    ASSERT_EQ(EN_ERROR, ret);
	GlobalMockObject::reset();

    MOCKER((int (*)(int,int,char*))ioctl)
           .stubs()
       .will(returnValue(-1));
    ret = mmGetMac(&list,&count);
    ASSERT_EQ(EN_ERROR, ret);
	GlobalMockObject::reset();

    MOCKER((int (*)(char*,long unsigned int,const char*))strcpy_s)
           .stubs()
       .will(returnValue(EN_ERROR));
    ret = mmGetMac(&list,&count);
    ASSERT_EQ(EN_ERROR, ret);
	GlobalMockObject::reset();

    MOCKER((int (*)(char*, long unsigned int, long unsigned int))snprintf_s)
           .stubs()
       .will(returnValue(EN_ERROR));
    ret = mmGetMac(&list,&count);
    ASSERT_EQ(EN_ERROR, ret);
	GlobalMockObject::reset();
}

TEST_F(Utest_mmpa_linux, Utest_mmCreateProcess)
{
    int pid;
    char *argv[]={(char*)"ls",(char*)"-al",NULL};
    char *envp[]={(char*)"PATH=/bin",NULL};
    char *filename = (char*)"/bin/ls";
    char redirectLog[1024] = "../tests/ut/mmpa/ut_createprocess.txt";
    int status = 0;
    mmArgvEnv env;
    env.argv = argv;
    env.argvCount = 2;
    env.envp = envp;
    env.envpCount = 1;
    int ret = mmCreateProcess(filename,&env,NULL,NULL);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(fork)
           .stubs()
       .will(returnValue(-1));
    ret = mmCreateProcess(filename,&env,NULL,&pid);
    ASSERT_EQ(EN_ERROR, ret);
	GlobalMockObject::reset();

    ret = mmCreateProcess(filename,&env,NULL,&pid);
    ASSERT_EQ(EN_OK, ret);

    printf("mmCreateProcess return pid is %d\n",pid);
    if (mmWaitPid(pid, NULL, 0) == EN_ERR)
    {
        printf("child process exit,status is %d\n",status);
    }

    ret = mmCreateProcess(filename,&env,redirectLog,&pid);
    ASSERT_EQ(EN_OK, ret);

    printf("mmCreateProcess return pid is %d\n",pid);
    if (mmWaitPid(pid, &status, 0) == EN_ERR)
    {
        printf("child process exit,status is %d\n",status);
    }

    ret = mmCreateProcess(".../tests/ut/mmpa/printf",&env,redirectLog,&pid);
    ASSERT_EQ(EN_OK, ret);

    printf("mmCreateProcess return pid is %d\n",pid);
    if (mmWaitPid(pid, &status, 0) == EN_ERR)
    {
        printf("child process exit,status is %d\n",status);
    }

    printf("parent for child exit\n");
}

TEST_F(Utest_mmpa_linux, Utest_mmCreateTaskWithThreadAttr_03)
{
    mmThread stThreadHandle;
    mmUserBlock_t stFuncBlock;
    stFuncBlock.procFunc = UTtest_callback;
    stFuncBlock.pulArg = NULL;

    mmThreadAttr attr;
    memset_s(&attr,sizeof(attr),0,sizeof(attr));
    attr.detachFlag = 0; // not detach
    attr.policyFlag = 1;
    attr.policy = MMPA_THREAD_SCHED_RR;
    attr.priorityFlag = 1;
    attr.priority = 1; //1-99
    attr.stackFlag = 1;
    attr.stackSize = 20480; // 20K

    INT32 ret = mmCreateTaskWithThreadAttr(&stThreadHandle, NULL,&attr);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    attr.stackSize = 1024; // 1k
    ret = mmCreateTaskWithThreadAttr(&stThreadHandle, &stFuncBlock,&attr);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    attr.priority = 100;  //1-99
    ret = mmCreateTaskWithThreadAttr(&stThreadHandle, &stFuncBlock,&attr);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    attr.policy = -1;
    ret = mmCreateTaskWithThreadAttr(&stThreadHandle, &stFuncBlock,&attr);
    ASSERT_EQ(EN_INVALID_PARAM, ret);

    MOCKER(pthread_attr_init)
        .stubs()
        .will(returnValue(EN_ERROR));
    ret = mmCreateTaskWithThreadAttr(&stThreadHandle, &stFuncBlock,&attr);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    MOCKER(pthread_attr_setinheritsched)
        .stubs()
        .will(returnValue(EN_ERROR));
    ret = mmCreateTaskWithThreadAttr(&stThreadHandle, &stFuncBlock,&attr);
    ASSERT_EQ(EN_ERROR, ret);
    GlobalMockObject::reset();

    MOCKER(pthread_attr_setschedpolicy)
        .stubs()
        .will(returnValue(EN_ERROR));
    ret = mmCreateTaskWithThreadAttr(&stThreadHandle, &stFuncBlock,&attr);
    ASSERT_EQ(EN_INVALID_PARAM, ret);
    GlobalMockObject::reset();
}


TEST_F(Utest_mmpa_linux, Utest_mmGetErrorFormatMessage_01)
{
    mmSize size = 0;
    mmErrorMsg errnum;
    char *ret  = mmGetErrorFormatMessage(errnum, NULL, 0);
    ASSERT_EQ(NULL, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmShm_01)
{
    mmFileHandle fd = mmShmOpen(NULL, O_RDWR|O_CREAT, S_IRWXU);
    ASSERT_EQ(EN_ERROR, fd);

    INT32 ret = mmShmUnlink(NULL);
    ASSERT_EQ(EN_ERROR, ret);
}


TEST_F(Utest_mmpa_linux, Utest_mmPopen_01)
{
    FILE *file = NULL;
    file = mmPopen(NULL, NULL);
    ASSERT_EQ(NULL, file);

    char *command = "ll ../tests/ut/mmpa/testcase/test.txt";
    file = mmPopen(command, "r");

    INT32 ret = mmPclose(file);
    ASSERT_NE(EN_OK, ret);
}

TEST_F(Utest_mmpa_linux, Utest_mmGetSetOpt_02)
{
    mmSetOptErr(1);
    INT32 ret = mmGetOptErr();

    mmSetOptInd(1);
    ret = mmGetOptInd();

    mmSetOpOpt(1);
    ret = mmGetOptOpt();

    mmSetOptArg("l");
    optarg = mmGetOptArg();

    ASSERT_TRUE(optarg != NULL);
}

TEST_F(Utest_mmpa_linux, Utest_mmAlign)
{
    mmSize pageSize = mmGetPageSize();
    void *addr = mmAlignMalloc(10, pageSize);
    ASSERT_TRUE(addr != NULL);
    mmAlignFree(addr);
}
