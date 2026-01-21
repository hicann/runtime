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
#include "mmpa_linux.h"
#include "mockcpp/mockcpp.hpp"
#include "vector.h"

#define VECTOR_BASIC_STEP 8

using namespace testing;

class UtestVectorTest : public testing::Test {
 protected:
  void SetUp() {
  }

  void TearDown() {
    GlobalMockObject::verify();
  }
};

TEST_F(UtestVectorTest, VectorCaseBasic) {
  Vector a;
  uint8_t value = 1;
  InitVector(&a, sizeof(uint8_t));
  EXPECT_EQ(ReSizeVector(&a, 0), 0);
  EXPECT_EQ(CapacityVector(&a, 0), 0);
  EmplaceBackVector(&a, &value);
  value++;
  EXPECT_EQ(ReSizeVector(&a, 0), 1);
  EXPECT_EQ(*(uint8_t*)VectorAt(&a, 0), 1);
  EXPECT_EQ(ReSizeVector(&a, 2), 2);

  EXPECT_EQ((uint8_t*)VectorAt(&a, 1), ((uint8_t*)VectorAt(&a, 0)) + 1);
  *(uint8_t*)VectorAt(&a, 1) = 2;
  RemoveVector(&a, 0);
  EXPECT_EQ(*(uint8_t*)VectorAt(&a, 0), 2);
  EXPECT_EQ(ReSizeVector(&a, 0), 1);
  DeInitVector(&a);
  EXPECT_EQ((a.data == NULL), true);
  EXPECT_EQ(a.size, 0);
  EXPECT_EQ(a.capacity, 0);
  EXPECT_EQ(a.itemSize, 0);
}

TEST_F(UtestVectorTest, VectorCaseBasic_capacity) {
  Vector a;
  uint8_t value = 1;
  InitVector(&a, sizeof(uint8_t));
  EXPECT_EQ(ReSizeVector(&a, 1), 1);
  EXPECT_EQ(CapacityVector(&a, 0), 1);
  *(uint8_t*)VectorAt(&a, 0) = value;
  EmplaceBackVector(&a, &value);
  EXPECT_EQ(CapacityVector(&a, 0), VECTOR_BASIC_STEP);
  EXPECT_EQ(ReSizeVector(&a, 0), 2);
  EXPECT_EQ(*(uint8_t*)VectorAt(&a, 0), value);
  EXPECT_EQ(*(uint8_t*)VectorAt(&a, 1), value);

  for (int i = 2; i < VECTOR_BASIC_STEP + 1; i++) {
    value = (uint8_t)i;
    EmplaceBackVector(&a, &value);
  }
  value = 1;
  EXPECT_EQ(*(uint8_t*)VectorAt(&a, 0), value);
  EXPECT_EQ(*(uint8_t*)VectorAt(&a, 1), value);
  for (int i = 2; i < VECTOR_BASIC_STEP + 1; i++) {
    value = (uint8_t)i;
    EXPECT_EQ(*(uint8_t*)VectorAt(&a, i), value);
  }
  EXPECT_EQ(CapacityVector(&a, 0), VECTOR_BASIC_STEP * 2);

  DeInitVector(&a);
}

TEST_F(UtestVectorTest, VectorCaseBasic_Emplace) {
  Vector a;
  uint8_t value = 1;
  InitVector(&a, sizeof(uint8_t));
  EmplaceVector(&a, 0, &value);
  EXPECT_EQ(*(uint8_t*)VectorAt(&a, 0), value);
  value++;
  EmplaceVector(&a, 1, &value);
  EXPECT_EQ(*(uint8_t*)VectorAt(&a, 1), value);
  value++;
  EmplaceVector(&a, 0, &value);
  EXPECT_EQ(*(uint8_t*)VectorAt(&a, 0), value);
  EXPECT_EQ(*(uint8_t*)VectorAt(&a, 1), 1);
  EXPECT_EQ(*(uint8_t*)VectorAt(&a, 2), 2);
  value++;

  EmplaceHeadVector(&a, &value);
  EXPECT_EQ(*(uint8_t*)VectorAt(&a, 0), value);
  EXPECT_EQ(ReSizeVector(&a, 0), 4);
  DeInitVector(&a);
}

TEST_F(UtestVectorTest, VectorCaseBasic_new) {
  Vector *a = NewVector(uint8_t);
  uint8_t value = 1;
  InitVector(a, sizeof(uint8_t));
  EXPECT_EQ(ReSizeVector(a, 1), 1);
  EXPECT_EQ(CapacityVector(a, 0), 1);
  *(uint8_t*)VectorAt(a, 0) = value;
  EmplaceBackVector(a, &value);
  EXPECT_EQ(CapacityVector(a, 0), VECTOR_BASIC_STEP);
  EXPECT_EQ(ReSizeVector(a, 0), 2);
  EXPECT_EQ(*(uint8_t*)VectorAt(a, 0), value);
  EXPECT_EQ(*(uint8_t*)VectorAt(a, 1), value);

  for (int i = 2; i < VECTOR_BASIC_STEP + 1; i++) {
    value = (uint8_t)i;
    EmplaceBackVector(a, &value);
  }
  value = 1;
  EXPECT_EQ(*(uint8_t*)VectorAt(a, 0), value);
  EXPECT_EQ(*(uint8_t*)VectorAt(a, 1), value);
  for (int i = 2; i < VECTOR_BASIC_STEP + 1; i++) {
    value = (uint8_t)i;
    EXPECT_EQ(*(uint8_t*)VectorAt(a, i), value);
  }
  EXPECT_EQ(CapacityVector(a, 0), VECTOR_BASIC_STEP * 2);

  DestroyVector(a);
}

TEST_F(UtestVectorTest, VectorCaseBasic_ConstVector) {
  Vector a;
  uint8_t value = 1;
  InitVector(&a, sizeof(uint8_t));
  EmplaceBackVector(&a, &value);
  EXPECT_EQ(*(const uint8_t*)ConstVectorAt(&a, 0), 1);
  EXPECT_EQ(((const uint8_t*)ConstVectorAt(&a, 1) == NULL), true);

  DeInitVector(&a);
  EXPECT_EQ((a.data == NULL), true);
  EXPECT_EQ(a.size, 0);
  EXPECT_EQ(a.capacity, 0);
  EXPECT_EQ(a.itemSize, 0);
}

TEST_F(UtestVectorTest, VectorCaseBasic_ClearVector) {
  Vector a;
  uint8_t value = 1;
  InitVector(&a, sizeof(uint8_t));
  EmplaceVector(&a, 0, &value);
  EXPECT_EQ(*(uint8_t*)VectorAt(&a, 0), 1);
  value++;
  EmplaceVector(&a, 1, &value);
  EXPECT_EQ(*(uint8_t*)VectorAt(&a, 1), 2);
  ClearVector(&a);
  EXPECT_EQ(VectorSize(&a), 0);

  value++;
  EmplaceVector(&a, 0, &value);
  EXPECT_EQ(*(uint8_t*)VectorAt(&a, 0), 3);
  value++;
  EmplaceHeadVector(&a, &value);
  EXPECT_EQ(*(uint8_t*)VectorAt(&a, 0), 4);
  EXPECT_EQ(*(uint8_t*)VectorAt(&a, 1), 3);
  EXPECT_EQ(ReSizeVector(&a, 0), 2);

  DeInitVector(&a);
  EXPECT_EQ((a.data == NULL), true);
  EXPECT_EQ(a.size, 0);
  EXPECT_EQ(a.capacity, 0);
  EXPECT_EQ(a.itemSize, 0);
}

TEST_F(UtestVectorTest, VectorCase_MoveVector) {
  Vector a;
  uint8_t value1 = 1;
  InitVector(&a, sizeof(uint8_t));
  EmplaceVector(&a, 0, &value1);
  EXPECT_EQ(*(uint8_t *)VectorAt(&a, 0), value1);

  Vector b;
  InitVector(&b, sizeof(uint8_t));

  MoveVector(&a, &b);
  EXPECT_EQ(*(uint8_t *)VectorAt(&b, 0), value1);

  DeInitVector(&a);
  EXPECT_EQ((a.data == NULL), true);
  EXPECT_EQ(a.size, 0);
  EXPECT_EQ(a.capacity, 0);
  EXPECT_EQ(a.itemSize, 0);

  DeInitVector(&b);
  EXPECT_EQ((b.data == NULL), true);
  EXPECT_EQ(b.size, 0);
  EXPECT_EQ(b.capacity, 0);
  EXPECT_EQ(b.itemSize, 0);
}

TEST_F(UtestVectorTest, VectorCase_memcpy_s_abnormal) {
  Vector a;
  uint8_t value = 1;
  InitVector(&a, sizeof(uint8_t));
  EXPECT_EQ(ReSizeVector(&a, 1), 1);
  EXPECT_EQ(CapacityVector(&a, 0), 1);
  *(uint8_t *)VectorAt(&a, 0) = value;
  MOCKER(memcpy_s).stubs().will(returnValue(-1));
  EmplaceBackVector(&a, &value);
  EXPECT_EQ(CapacityVector(&a, 0), 1);
  DeInitVector(&a);
}

TEST_F(UtestVectorTest, NewVector_mmMalloc_Abnormal) {
  MOCKER(malloc).stubs().will(returnValue((void *)nullptr));
  EXPECT_EQ(NewVector(uint8_t), nullptr);
}

TEST_F(UtestVectorTest, CapacityVector_mmMalloc_Null) {
  Vector a;
  uint8_t value = 1;
  InitVector(&a, sizeof(uint8_t));
  MOCKER(malloc).stubs().will(returnValue((void *)nullptr));
  EXPECT_EQ(ReSizeVector(&a, 1), 0);
}

TEST_F(UtestVectorTest, EmplaceVector_Memmove_Abnormal) {
  Vector a;
  uint8_t value = 1;
  InitVector(&a, sizeof(uint8_t));
  EmplaceVector(&a, 0, &value);
  EXPECT_EQ(*(uint8_t*)VectorAt(&a, 0), value);
  value++;
  MOCKER(memmove_s).stubs().will(returnValue(-1));
  EXPECT_EQ(EmplaceVector(&a, 0, &value), nullptr);
  DeInitVector(&a);
}

TEST_F(UtestVectorTest, RemoveVector_Memmove_Abnormal) {
  Vector a;
  uint8_t value = 1;
  InitVector(&a, sizeof(uint8_t));
  EmplaceBackVector(&a, &value);
  EXPECT_EQ(ReSizeVector(&a, 2), 2);

  MOCKER(memmove_s).stubs().will(returnValue(-1));
  RemoveVector(&a, 0);
  DeInitVector(&a);
}