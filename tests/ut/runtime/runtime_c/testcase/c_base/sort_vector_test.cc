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
#include "securec.h"
#include "mockcpp/mockcpp.hpp"
#include "sort_vector.h"

#define VECTOR_BASIC_STEP 8

using namespace testing;

class UtestSortVectorTest : public testing::Test {
 protected:
  void SetUp() {
  }

  void TearDown() {
    GlobalMockObject::verify();
  }
};

typedef struct {
  uint32_t key;
  uint32_t value;
}StubPair;

int StubPairCmp(void *a, void *b, void *appInfo) {
  return ((StubPair*)a)->key - ((StubPair*)b)->key;
}

TEST_F(UtestSortVectorTest, SortVectorCaseBasic) {
  SortVector a;
  StubPair pair = {10, 1};
  InitSortVector(&a, sizeof(StubPair), StubPairCmp, NULL);
  EXPECT_EQ(FindSortVector(&a, &pair), SortVectorSize(&a));
  EmplaceSortVector(&a, &pair);
  EXPECT_EQ(SortVectorSize(&a), 1);
  EXPECT_EQ(CapacitySortVector(&a, 0), VECTOR_BASIC_STEP);
  size_t index = FindSortVector(&a, &pair);
  EXPECT_EQ(index, 0);
  EXPECT_EQ(((StubPair*)SortVectorAt(&a, index))->key, 10);
  EXPECT_EQ(((StubPair*)SortVectorAt(&a, index))->value, 1);

  pair.key++;
  EmplaceSortVector(&a, &pair);
  EXPECT_EQ(SortVectorSize(&a), 2);
  index = FindSortVector(&a, &pair);
  EXPECT_EQ(index, 1);
  EXPECT_EQ(((StubPair*)SortVectorAt(&a, index))->key, 11);
  EXPECT_EQ(((StubPair*)SortVectorAt(&a, index))->value, 1);

  pair.key -= 2;
  EmplaceSortVector(&a, &pair);
  EXPECT_EQ(SortVectorSize(&a), 3);
  index = FindSortVector(&a, &pair);
  EXPECT_EQ(index, 0);
  EXPECT_EQ(((StubPair*)SortVectorAt(&a, index))->key, 9);
  EXPECT_EQ(((StubPair*)SortVectorAt(&a, index))->value, 1);

  EmplaceSortVector(&a, &pair);
  EXPECT_EQ(SortVectorSize(&a), 3);
  index = FindSortVector(&a, &pair);
  EXPECT_EQ(index, 0);
  EXPECT_EQ(((StubPair*)SortVectorAt(&a, index))->key, 9);
  EXPECT_EQ(((StubPair*)SortVectorAt(&a, index))->value, 1);

  RemoveSortVector(&a, 0);
  EXPECT_EQ(SortVectorSize(&a), 2);
  index = FindSortVector(&a, &pair);
  EXPECT_EQ(index, SortVectorSize(&a));
  EmplaceSortVector(&a, &pair);
  EXPECT_EQ(SortVectorSize(&a), 3);

  RemoveSortVector(&a, 2);
  EXPECT_EQ(SortVectorSize(&a), 2);
  pair.key = 11;
  index = FindSortVector(&a, &pair);
  EXPECT_EQ(index, SortVectorSize(&a));
  EmplaceSortVector(&a, &pair);

  RemoveSortVector(&a, 1);
  EXPECT_EQ(SortVectorSize(&a), 2);
  pair.key = 10;
  index = FindSortVector(&a, &pair);
  EXPECT_EQ(index, SortVectorSize(&a));

  RemoveSortVector(&a, 1);
  EXPECT_EQ(SortVectorSize(&a), 1);

  RemoveSortVector(&a, 1);
  EXPECT_EQ(SortVectorSize(&a), 1);

  RemoveSortVector(&a, 0);
  EXPECT_EQ(SortVectorSize(&a), 0);

  DeInitSortVector(&a);

  EXPECT_EQ((a.vector.data == NULL), true);
  EXPECT_EQ(a.vector.size, 0);
  EXPECT_EQ(a.vector.capacity, 0);
  EXPECT_EQ(a.vector.itemSize, 0);
}

TEST_F(UtestSortVectorTest, SortVectorCaseNewDestroy) {
  SortVector *a = NewSortVector(StubPair, StubPairCmp, NULL);
  StubPair pair = {10, 1};
  EXPECT_EQ(FindSortVector(a, &pair), SortVectorSize(a));
  InitSortVector(a, sizeof(StubPair), StubPairCmp, NULL);
  EmplaceSortVector(a, &pair);
  EXPECT_EQ(SortVectorSize(a), 1);
  size_t index = FindSortVector(a, &pair);
  EXPECT_EQ(index, 0);
  EXPECT_EQ(((StubPair*)SortVectorAt(a, index))->key, 10);
  EXPECT_EQ(((StubPair*)SortVectorAt(a, index))->value, 1);
  DestroySortVector(a);
}

TEST_F(UtestSortVectorTest, SortVectorCaseDefaultCmp) {
  SortVector a;
  StubPair pair = {10, 1};
  InitSortVector(&a, sizeof(StubPair), NULL, (void*)&pair); // appInfo 无效测试
  EXPECT_EQ(FindSortVector(&a, &pair), SortVectorSize(&a));
  EmplaceSortVector(&a, &pair);
  EXPECT_EQ(SortVectorSize(&a), 1);
  size_t index = FindSortVector(&a, &pair);
  EXPECT_EQ(index, 0);
  EXPECT_EQ(((StubPair*)SortVectorAt(&a, index))->key, 10);
  EXPECT_EQ(((StubPair*)SortVectorAt(&a, index))->value, 1);

  pair.key++;
  EmplaceSortVector(&a, &pair);
  EXPECT_EQ(SortVectorSize(&a), 2);
  index = FindSortVector(&a, &pair);
  EXPECT_EQ(index, 1);
  EXPECT_EQ(((StubPair*)SortVectorAt(&a, index))->key, 11);
  EXPECT_EQ(((StubPair*)SortVectorAt(&a, index))->value, 1);

  pair.key -= 2;
  EmplaceSortVector(&a, &pair);
  EXPECT_EQ(SortVectorSize(&a), 3);
  index = FindSortVector(&a, &pair);
  EXPECT_EQ(index, 0);
  EXPECT_EQ(((StubPair*)SortVectorAt(&a, index))->key, 9);
  EXPECT_EQ(((StubPair*)SortVectorAt(&a, index))->value, 1);

  EmplaceSortVector(&a, &pair);
  EXPECT_EQ(SortVectorSize(&a), 3);
  index = FindSortVector(&a, &pair);
  EXPECT_EQ(index, 0);
  EXPECT_EQ(((StubPair*)SortVectorAt(&a, index))->key, 9);
  EXPECT_EQ(((StubPair*)SortVectorAt(&a, index))->value, 1);

  RemoveSortVector(&a, 0);
  EXPECT_EQ(SortVectorSize(&a), 2);
  index = FindSortVector(&a, &pair);
  EXPECT_EQ(index, SortVectorSize(&a));
  EmplaceSortVector(&a, &pair);
  EXPECT_EQ(SortVectorSize(&a), 3);

  RemoveSortVector(&a, 2);
  EXPECT_EQ(SortVectorSize(&a), 2);
  pair.key = 11;
  index = FindSortVector(&a, &pair);
  EXPECT_EQ(index, SortVectorSize(&a));
  EmplaceSortVector(&a, &pair);

  RemoveSortVector(&a, 1);
  EXPECT_EQ(SortVectorSize(&a), 2);
  pair.key = 10;
  index = FindSortVector(&a, &pair);
  EXPECT_EQ(index, SortVectorSize(&a));

  RemoveSortVector(&a, 1);
  EXPECT_EQ(SortVectorSize(&a), 1);

  RemoveSortVector(&a, 1);
  EXPECT_EQ(SortVectorSize(&a), 1);

  RemoveSortVector(&a, 0);
  EXPECT_EQ(SortVectorSize(&a), 0);

  DeInitSortVector(&a);

  EXPECT_EQ((a.vector.data == NULL), true);
  EXPECT_EQ(a.vector.size, 0);
  EXPECT_EQ(a.vector.capacity, 0);
  EXPECT_EQ(a.vector.itemSize, 0);
}

TEST_F(UtestSortVectorTest, NewSortVector_mmMalloc_Abnormal) {
  MOCKER(malloc).stubs().will(returnValue((void *)nullptr));
  EXPECT_EQ(NewSortVector(StubPair, StubPairCmp, nullptr), nullptr);
}

TEST_F(UtestSortVectorTest, EmplaceSortVector_Memcpy_Abnormal) {
  SortVector a;
  StubPair pair = {10, 1};
  InitSortVector(&a, sizeof(StubPair), StubPairCmp, NULL);
  EmplaceSortVector(&a, &pair);
  MOCKER(memcpy_s).stubs().will(returnValue(-1));
  EXPECT_EQ(EmplaceSortVector(&a, &pair), nullptr);
  DeInitSortVector(&a);
}