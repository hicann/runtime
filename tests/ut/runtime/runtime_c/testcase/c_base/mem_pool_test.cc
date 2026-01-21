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
#include <memory>
#include "mockcpp/mockcpp.hpp"
#include "mem_pool.h"

using namespace testing;

class UtestMemPoolTest : public testing::Test {
 protected:
  void SetUp() {
    MOCKER(GetMemPoolReuseFlag).stubs().will(returnValue(true));
  }

  void TearDown() {
  }
};

typedef struct {
  uint64_t value;
} MemObj;

TEST_F(UtestMemPoolTest, MemPoolCaseBasic) {
  MemPool memPool = MEM_POOL_INIT(sizeof(MemObj));
  EXPECT_TRUE(memPool.idleList.head == NULL);
  EXPECT_TRUE(memPool.idleList.tail == NULL);
  EXPECT_EQ(memPool.memSize, sizeof(MemObj));
  EXPECT_EQ(memPool.updating, 0);
  MemObj *obj = (MemObj*)MemPoolAllocWithCSingleList(&memPool);
  EXPECT_TRUE((obj != NULL));
  EXPECT_TRUE(MemPoolMemUsed(obj));
  obj->value = 0x11;
  EXPECT_TRUE(MemPoolMemUsed(obj));
  MemPoolFreeWithCSingleList(&memPool, obj, NULL);
  EXPECT_FALSE(MemPoolMemUsed(obj));

  MemObj *obj1;
  for (int i = 0; i < 5; i++) {
    obj1 = (MemObj*)MemPoolAllocWithCSingleList(&memPool);
    EXPECT_EQ(obj, obj1);
    EXPECT_TRUE(MemPoolMemUsed(obj1));
    MemPoolFreeWithCSingleList(&memPool, obj1, NULL);
    EXPECT_FALSE(MemPoolMemUsed(obj1));
  }

  obj1 = (MemObj*)MemPoolAllocWithCSingleList(&memPool);
  EXPECT_EQ(obj, obj1);
  obj = (MemObj*)MemPoolAllocWithCSingleList(&memPool);
  EXPECT_NE(obj1, obj);
  EXPECT_TRUE((obj != NULL));
  EXPECT_TRUE(MemPoolMemUsed(obj));
  EXPECT_TRUE(MemPoolMemUsed(obj1));
  MemPoolFreeWithCSingleList(&memPool, obj1, NULL);
  EXPECT_FALSE(MemPoolMemUsed(obj1));
  MemPoolFreeWithCSingleList(&memPool, obj, NULL);
  EXPECT_FALSE(MemPoolMemUsed(obj));

  MemObj *obj2 = (MemObj*)MemPoolAllocWithCSingleList(&memPool);
  EXPECT_EQ(obj2, obj1);
  EXPECT_TRUE(MemPoolMemUsed(obj2));

  MemObj *obj3 = (MemObj*)MemPoolAllocWithCSingleList(&memPool);
  EXPECT_EQ(obj3, obj);
  EXPECT_TRUE(MemPoolMemUsed(obj3));

  MemPoolFreeWithCSingleList(&memPool, obj3, NULL);
  EXPECT_FALSE(MemPoolMemUsed(obj3));
  MemPoolFreeWithCSingleList(&memPool, obj2, NULL);
  EXPECT_FALSE(MemPoolMemUsed(obj2));

  DeInitMemPoolWithCSingleList(&memPool);
}

TEST_F(UtestMemPoolTest, MemPoolCaseRefree) {
  MemPool memPool;
  InitMemPoolWithCSingleList(&memPool, sizeof(MemObj));
  EXPECT_TRUE(memPool.idleList.head == NULL);
  EXPECT_TRUE(memPool.idleList.tail == NULL);
  EXPECT_EQ(memPool.memSize, sizeof(MemObj));
  EXPECT_EQ(memPool.updating, 0);

  MemObj *obj = (MemObj*)MemPoolAllocWithCSingleList(&memPool);
  EXPECT_TRUE((obj != NULL));
  EXPECT_TRUE(MemPoolMemUsed(obj));
  MemPoolFreeWithCSingleList(&memPool, obj, NULL);
  EXPECT_FALSE(MemPoolMemUsed(obj));
  MemPoolFreeWithCSingleList(&memPool, obj, NULL);
  EXPECT_FALSE(MemPoolMemUsed(obj));

  MemObj *obj1;
  obj1 = (MemObj*)MemPoolAllocWithCSingleList(&memPool);
  EXPECT_EQ(obj, obj1);
  EXPECT_TRUE(MemPoolMemUsed(obj));
  MemPoolFreeWithCSingleList(&memPool, obj, NULL);

  DeInitMemPoolWithCSingleList(&memPool);
}

typedef struct {
  MemNode node;
  MemObj  obj;
} MemObjTest;

TEST_F(UtestMemPoolTest, MemPoolCaseInvalidData) {
  MemPool memPool;
  InitMemPoolWithCSingleList(&memPool, sizeof(MemObj));
  MemObjTest tmpObj = {{1, NULL}};
  EXPECT_FALSE(MemPoolMemUsed(&tmpObj.obj));
  MemPoolFreeWithCSingleList(&memPool, &tmpObj.obj, NULL);
  MemObj *obj = (MemObj*)MemPoolAllocWithCSingleList(&memPool);
  EXPECT_TRUE((obj != NULL));
  EXPECT_NE(obj, &tmpObj.obj);
  EXPECT_TRUE(MemPoolMemUsed(obj));
  MemPoolFreeWithCSingleList(&memPool, obj, NULL);
  EXPECT_FALSE(MemPoolMemUsed(obj));
  DeInitMemPoolWithCSingleList(&memPool);
}

TEST_F(UtestMemPoolTest, MemPoolCaseInvalidSeq) {
  MemPool memPool;
  InitMemPoolWithCSingleList(&memPool, sizeof(MemObj));
  MemObj *obj = (MemObj*)MemPoolAllocWithCSingleList(&memPool);
  EXPECT_TRUE((obj != NULL));
  uint32_t seq = GetMemPoolMemSeq(obj);
  EXPECT_TRUE(MemPoolMemMatchSeq(obj, seq));
  MemPoolFreeWithCSingleList(&memPool, obj, NULL);
  EXPECT_FALSE(MemPoolMemMatchSeq(obj, seq));
  obj = (MemObj*)MemPoolAllocWithCSingleList(&memPool);
  EXPECT_TRUE((obj != NULL));
  EXPECT_FALSE(MemPoolMemMatchSeq(obj, seq));
  MemPoolFreeWithCSingleList(&memPool, obj, NULL);
  DeInitMemPoolWithCSingleList(&memPool);
}

typedef struct {
  MemPool *pool;
  bool flag;
} MemPoolTheadPara;

void* MemPoolTestThread1(void* para)
{
  MemPoolTheadPara *theadPara = (MemPoolTheadPara*)para;
  void *pData[5];
  uint32_t seq[5];
  while (!theadPara->flag) {

  }
  for (int i = 0; i < 5; i++) {
    pData[i] = MemPoolAllocWithCSingleList(theadPara->pool);
    seq[i] = GetMemPoolMemSeq(pData[i]);
  }

  for (int i = 0; i < 5; i++) {
    EXPECT_TRUE(MemPoolMemMatchSeq(pData[i], seq[i]));
    MemPoolFreeWithCSingleList(theadPara->pool, pData[i], NULL);
  }

  return NULL;
}

void* MemPoolTestThread2(void* para)
{
  MemPoolTheadPara *theadPara = (MemPoolTheadPara*)para;
  void *pData[5];
  uint32_t seq[5];
  while (!theadPara->flag) {
  }

  for (int i = 0; i < 5; i++) {
    pData[i] = MemPoolAllocWithCSingleList(theadPara->pool);
    seq[i] = GetMemPoolMemSeq(pData[i]);
    EXPECT_TRUE(MemPoolMemMatchSeq(pData[i], seq[i]));
    MemPoolFreeWithCSingleList(theadPara->pool, pData[i], NULL);
  }

  return NULL;
}

TEST_F(UtestMemPoolTest, MemPoolCaseMutiThread) {
  MemPool memPool;
  InitMemPoolWithCSingleList(&memPool, sizeof(MemObj));

  MemPoolTheadPara theadPara = {&memPool, false};
  pthread_t thr[2];
  for(int i = 0; i < 2; ++i) {
    pthread_create(&thr[i], NULL, MemPoolTestThread1, &theadPara);
  }
  pthread_t thr2[2];
  for(int i = 0; i < 2; ++i) {
    pthread_create(&thr2[i], NULL, MemPoolTestThread2, &theadPara);
  }
  theadPara.flag = true;
  for(int i = 0; i < 2; ++i) {
    pthread_join(thr[i], NULL);
  }
  for(int i = 0; i < 2; ++i) {
    pthread_join(thr2[i], NULL);
  }
  EXPECT_EQ(memPool.seq, 2 * 2 * 5);
  DeInitMemPoolWithCSingleList(&memPool);
}

TEST_F(UtestMemPoolTest, MemPoolCase_abnormal) {
  MemPool memPool;
  InitMemPoolWithCSingleList(&memPool, sizeof(MemObj));
  EXPECT_TRUE(memPool.idleList.head == NULL);
  EXPECT_TRUE(memPool.idleList.tail == NULL);
  EXPECT_EQ(memPool.memSize, sizeof(MemObj));
  EXPECT_EQ(memPool.updating, 0);
  MemPoolFreeWithCSingleList(&memPool, NULL, NULL);
}

TEST_F(UtestMemPoolTest, MemPoolReuseFlag) {
  GlobalMockObject::verify();
  MemPool memPool = MEM_POOL_INIT(sizeof(MemObj));
  EXPECT_TRUE(memPool.idleList.head == NULL);
  EXPECT_TRUE(memPool.idleList.tail == NULL);
  EXPECT_EQ(memPool.memSize, sizeof(MemObj));
  EXPECT_EQ(memPool.updating, 0);
  MemObj *obj = (MemObj*)MemPoolAllocWithCSingleList(&memPool);
  EXPECT_TRUE((obj != nullptr));
  EXPECT_TRUE(MemPoolMemUsed(obj));
  obj->value = 0x11;
  EXPECT_TRUE(MemPoolMemUsed(obj));
  MemPoolFreeWithCSingleList(&memPool, obj, NULL);
  DeInitMemPoolWithCSingleList(&memPool);
}