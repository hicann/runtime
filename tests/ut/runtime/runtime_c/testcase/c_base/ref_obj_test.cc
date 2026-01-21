/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <unistd.h>
#include <gtest/gtest.h>
#include <memory>
#include <time.h>
#include <pthread.h>
#include "ref_obj.h"

using namespace testing;

uint64_t g_MallocCount = 0;
uint64_t g_FreeCount = 0;
uint64_t g_BlockCreateObj = 0;
uint64_t g_BlockDestroyObj = 0;
class UtestRefObjTest : public testing::Test {
 protected:
  void SetUp() {
    g_MallocCount = 0;
    g_FreeCount = 0;
  }

  void TearDown() {
  }
};

typedef struct {
  uint64_t value;
} RefObjValue;

typedef struct {
  uint64_t devId;
  RefObj   refObj;
} RefObjTest;

void USleep(uint64_t us)
{
  struct timespec start;
  clock_gettime(CLOCK_REALTIME, &start);
  timespec req = {us / 1000000, (us % 1000000) * 1000};
  timespec rem;
  int ret;
  uint64_t times = 0;
  do {
    ret = nanosleep(&req, &rem);
    req = rem;
    times++;
  } while (ret < 0);
  struct timespec end;
  clock_gettime(CLOCK_REALTIME, &end);
  struct timespec res;
  clock_getres(CLOCK_REALTIME, &res);
  printf("\r\n USleep start[%lu, %lu], end[%lu, %lu], res[%lu, %lu], sleep us = %lu, ret = %d, times = %lu",
    start.tv_sec, start.tv_nsec, end.tv_sec, end.tv_nsec, res.tv_sec, res.tv_nsec, us, ret, times);
}

void *CreateRefObjValue(RefObj *obj) {
  if (g_BlockCreateObj != 0) {
    USleep(g_BlockCreateObj);
  }

  RefObjTest *test = GET_MAIN_BY_MEMBER(obj, RefObjTest, refObj);
  printf("\r\n To init dev by test->devId = %lu", test->devId);
  __sync_fetch_and_add(&g_MallocCount, 1);
  void *pAddr = malloc(sizeof(RefObjValue));
  printf("\r\n CreateRefObjValue = %p", pAddr);
  return pAddr;
}

void DestroyRefObjValue(RefObj *obj) {
  if (g_BlockDestroyObj != 0) {
    USleep(g_BlockDestroyObj);
  }
  __sync_fetch_and_add(&g_FreeCount, 1);
  printf("\r\n DestroyRefObjValue = %p", GetRefObjVal(obj));
  free(GetRefObjVal(obj));
  obj->obj = NULL;
}

void DestroyDynRefObj(RefObj *obj) {
  DestroyRefObjValue(obj);
  RefObjTest *test = GET_MAIN_BY_MEMBER(obj, RefObjTest, refObj);
  free(test);
  printf("\r\n DestroyDynRefObj = %pp", test);
}

TEST_F(UtestRefObjTest, RefObjCaseBasic) {
  RefObjTest refObj;
  InitRefObj(&refObj.refObj);

  RefObjValue *obj = (RefObjValue*)GetObjRef(&refObj.refObj, CreateRefObjValue);
  EXPECT_TRUE((obj != NULL));
  EXPECT_EQ(g_MallocCount, 1);
  obj->value = 0x12;
  ReleaseObjRef(&refObj.refObj, DestroyRefObjValue);
  EXPECT_EQ(g_FreeCount, 1);
  EXPECT_TRUE((GetRefObjVal(&refObj.refObj) == NULL));

  obj = (RefObjValue*)GetObjRef(&refObj.refObj, CreateRefObjValue);
  EXPECT_TRUE((obj != NULL));
  EXPECT_EQ(g_MallocCount, 2);
  for (int i = 0; i < 5; i++) {
    RefObjValue *obj1 = (RefObjValue*)GetObjRef(&refObj.refObj, CreateRefObjValue);
    EXPECT_EQ(g_MallocCount, 2);
    EXPECT_EQ(obj1, obj);
  }

  for (int i = 0; i < 5; i++) {
    ReleaseObjRef(&refObj.refObj, DestroyRefObjValue);
    EXPECT_EQ(g_FreeCount, 1);
  }

  EXPECT_EQ(GetRefObjVal(&refObj.refObj), obj);
  ReleaseObjRef(&refObj.refObj, DestroyRefObjValue);
  EXPECT_EQ(g_FreeCount, 2);
  EXPECT_TRUE((GetRefObjVal(&refObj.refObj) == NULL));
}

TEST_F(UtestRefObjTest, RefObjCaseMoreRelease) {
  RefObjTest refObj;
  InitRefObj(&refObj.refObj);

  RefObjValue *obj = (RefObjValue*)GetObjRef(&refObj.refObj, CreateRefObjValue);
  EXPECT_TRUE((obj != NULL));
  EXPECT_EQ(g_MallocCount, 1);
  obj->value = 0x12;
  ReleaseObjRef(&refObj.refObj, DestroyRefObjValue);
  EXPECT_EQ(g_FreeCount, 1);
  EXPECT_TRUE((GetRefObjVal(&refObj.refObj) == NULL));
  ReleaseObjRef(&refObj.refObj, DestroyRefObjValue);
  EXPECT_EQ(g_FreeCount, 1);
  ReleaseObjRef(&refObj.refObj, DestroyRefObjValue);
  EXPECT_EQ(g_FreeCount, 1);
  ReleaseObjRef(&refObj.refObj, DestroyRefObjValue);
  EXPECT_EQ(g_FreeCount, 1);
  ReleaseObjRef(&refObj.refObj, DestroyRefObjValue);
  EXPECT_EQ(g_FreeCount, 1);

  obj = (RefObjValue*)GetObjRef(&refObj.refObj, CreateRefObjValue);
  EXPECT_TRUE((obj != NULL));
  EXPECT_EQ(g_MallocCount, 2);
  ReleaseObjRef(&refObj.refObj, DestroyRefObjValue);
  EXPECT_EQ(g_FreeCount, 2);
}

TEST_F(UtestRefObjTest, RefObjCaseDynRefObj) {
  RefObjTest *refObj = (RefObjTest*)malloc(sizeof(RefObjTest));
  EXPECT_TRUE(refObj != NULL);
  printf("\r\n RefObjCaseDynRefObj = %p", refObj);

  InitRefObj(&refObj->refObj);
  RefObjValue *obj = (RefObjValue*)GetObjRef(&refObj->refObj, CreateRefObjValue);
  EXPECT_TRUE((obj != NULL));
  EXPECT_EQ(g_MallocCount, 1);
  obj->value = 0x12;
  ReleaseObjRef(&refObj->refObj, DestroyDynRefObj);
  EXPECT_EQ(g_FreeCount, 1);
}

void* CreateNullObj(RefObj *obj)
{
  return nullptr;
}

void* CreateHookFunc(RefObj *obj, const void *userData)
{
  void *pAddr = malloc(sizeof(RefObjValue));
  printf("\r\n CreateHookFunc = %p", pAddr);
  return pAddr;
}

void DestroyHookFunc(RefObj *obj) {
  free(GetRefObjVal(obj));
  obj->obj = nullptr;
}

TEST_F(UtestRefObjTest, RefObjCaseBasic1) {
  RefObj refObj;
  InitRefObj(&refObj);

  RefObjValue *obj = (RefObjValue*)GetObjRef(&refObj, CreateNullObj);
  EXPECT_TRUE((obj == nullptr));

  obj = (RefObjValue*)GetObjRefWithUserData(&refObj, nullptr , CreateHookFunc);
  EXPECT_TRUE((obj != nullptr));
  EXPECT_EQ(refObj.refCount, 1);
  obj->value = 0x12;
  ReleaseObjRef(&refObj, DestroyRefObjValue);
  EXPECT_EQ(refObj.refCount, 0);
  EXPECT_TRUE((GetRefObjVal(&refObj) == nullptr));
}

typedef struct TestThreadDataTag {
  bool *startThreadTest;
  RefObj *refObj;
  void (*hook)(struct TestThreadDataTag *refObj);
  RefObjValue *value;
} TestThreadData;

void GetObjRefTest(TestThreadData *data) {
  data->value = (RefObjValue*)GetObjRef(data->refObj, CreateRefObjValue);
}

void ReleaseObjRefTest(TestThreadData *data) {
  ReleaseObjRef(data->refObj, DestroyRefObjValue);
  ReleaseObjRef(data->refObj, DestroyRefObjValue);
}

void* RefObjTestThread(void* para)
{
  TestThreadData *data = (TestThreadData*)para;
  while (!(*data->startThreadTest)) {
  }
  data->hook(data);
  return NULL;
}

TEST_F(UtestRefObjTest, RefObjCaseMultiThread) {
  RefObjTest refObj;
  InitRefObj(&refObj.refObj);

  pthread_t thr[5];
  bool startThreadTest = false;
  TestThreadData data[5];
  for (int k = 0; k < 2; k++) {
    for(int i = 0; i < 5; ++i) {
      data[i].startThreadTest = &startThreadTest;
      data[i].refObj = &refObj.refObj;
      data[i].hook = GetObjRefTest;
      data[i].value = NULL;
      pthread_create(&thr[i], NULL, RefObjTestThread, &data[i]);
    }
    startThreadTest = true;
    for(int i = 0; i < 5; ++i) {
      pthread_join(thr[i], NULL);
    }
    EXPECT_EQ(g_MallocCount, k + 1);
    for(int i = 1; i < 5; ++i) {
      EXPECT_EQ(data[i].value, data[0].value);
    }

    startThreadTest = false;
    for(int i = 0; i < 5; ++i) {
      data[i].hook = ReleaseObjRefTest;
      pthread_create(&thr[i], NULL, RefObjTestThread, &data[i]);
    }
    startThreadTest = true;
    for(int i = 0; i < 5; ++i) {
      pthread_join(thr[i], NULL);
    }
    EXPECT_EQ(g_FreeCount, k + 1);
  }

  EXPECT_TRUE((GetRefObjVal(&refObj.refObj) == NULL));
}

#define TIMESPEC_TO_US(start, end) ((end).tv_sec - (start).tv_sec) * 1000000 + ((((end).tv_nsec - (start).tv_nsec)) / 1000)

TEST_F(UtestRefObjTest, RefObjCaseMultiThreadBlock) {
  RefObjTest refObj;
  InitRefObj(&refObj.refObj);

  pthread_t thr[5];
  bool startThreadTest = false;
  TestThreadData data[5];
  for(int i = 0; i < 5; ++i) {
    data[i].startThreadTest = &startThreadTest;
    data[i].refObj = &refObj.refObj;
    data[i].hook = GetObjRefTest;
    data[i].value = NULL;
    pthread_create(&thr[i], NULL, RefObjTestThread, &data[i]);
  }
  g_BlockCreateObj = 250000;
  g_BlockDestroyObj = 250000;
  struct timespec start;
  struct timespec end;
  clock_gettime(CLOCK_REALTIME, &start);
  startThreadTest = true;
  for(int i = 0; i < 5; ++i) {
    pthread_join(thr[i], NULL);
  }
  clock_gettime(CLOCK_REALTIME, &end);
  EXPECT_GE(TIMESPEC_TO_US(start, end), g_BlockCreateObj);
  EXPECT_EQ(g_MallocCount, 1);
  for(int i = 1; i < 5; ++i) {
    EXPECT_EQ(data[i].value, data[0].value);
  }

  startThreadTest = false;
  for(int i = 0; i < 5; ++i) {
    data[i].hook = ReleaseObjRefTest;
    pthread_create(&thr[i], NULL, RefObjTestThread, &data[i]);
  }
  clock_gettime(CLOCK_REALTIME, &start);
  startThreadTest = true;
  for(int i = 0; i < 5; ++i) {
    pthread_join(thr[i], NULL);
  }
  clock_gettime(CLOCK_REALTIME, &end);
  EXPECT_GE(TIMESPEC_TO_US(start, end), g_BlockDestroyObj);
  EXPECT_EQ(g_FreeCount, 1);
  EXPECT_TRUE(GetRefObjVal(&refObj.refObj) == NULL);
}