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
#include "json/sort_vector.h"

using namespace testing;

class UtestSortVectorTest : public testing::Test {
protected:
    void SetUp()
    {}

    void TearDown()
    {}
};

typedef struct {
    uint32_t key;
    uint32_t value;
} StubPair;

int StubPairCmp(void *a, void *b, void *appInfo)
{
    return ((StubPair *)a)->key - ((StubPair *)b)->key;
}

TEST_F(UtestSortVectorTest, SortVectorCaseBasic)
{
    SortVector a;
    StubPair pair = {10, 1};
    InitCSortVector(&a, sizeof(StubPair), StubPairCmp, NULL);
    EXPECT_EQ(FindCSortVector(&a, &pair), CSortVectorSize(&a));
    EmplaceCSortVector(&a, &pair);
    EXPECT_EQ(CSortVectorSize(&a), 1);
    size_t index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, 0);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->key, 10);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->value, 1);

    pair.key++;
    EmplaceCSortVector(&a, &pair);
    EXPECT_EQ(CSortVectorSize(&a), 2);
    index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, 1);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->key, 11);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->value, 1);

    pair.key -= 2;
    EmplaceCSortVector(&a, &pair);
    EXPECT_EQ(CSortVectorSize(&a), 3);
    index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, 0);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->key, 9);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->value, 1);

    EmplaceCSortVector(&a, &pair);
    EXPECT_EQ(CSortVectorSize(&a), 3);
    index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, 0);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->key, 9);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->value, 1);

    RemoveCSortVector(&a, 0);
    EXPECT_EQ(CSortVectorSize(&a), 2);
    index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, CSortVectorSize(&a));
    EmplaceCSortVector(&a, &pair);
    EXPECT_EQ(CSortVectorSize(&a), 3);

    RemoveCSortVector(&a, 2);
    EXPECT_EQ(CSortVectorSize(&a), 2);
    pair.key = 11;
    index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, CSortVectorSize(&a));
    EmplaceCSortVector(&a, &pair);

    RemoveCSortVector(&a, 1);
    EXPECT_EQ(CSortVectorSize(&a), 2);
    pair.key = 10;
    index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, CSortVectorSize(&a));

    RemoveCSortVector(&a, 1);
    EXPECT_EQ(CSortVectorSize(&a), 1);

    RemoveCSortVector(&a, 1);
    EXPECT_EQ(CSortVectorSize(&a), 1);

    RemoveCSortVector(&a, 0);
    EXPECT_EQ(CSortVectorSize(&a), 0);

    DeInitCSortVector(&a);

    EXPECT_EQ((a.vector.data == NULL), true);
    EXPECT_EQ(a.vector.size, 0);
    EXPECT_EQ(a.vector.capacity, 0);
    EXPECT_EQ(a.vector.itemSize, 0);
}

TEST_F(UtestSortVectorTest, SortVectorCaseNewDestroy)
{
    SortVector *a = NewSortVector(StubPair, StubPairCmp, NULL);
    StubPair pair = {10, 1};
    EXPECT_EQ(FindCSortVector(a, &pair), CSortVectorSize(a));
    InitCSortVector(a, sizeof(StubPair), StubPairCmp, NULL);
    EmplaceCSortVector(a, &pair);
    EXPECT_EQ(CSortVectorSize(a), 1);
    size_t index = FindCSortVector(a, &pair);
    EXPECT_EQ(index, 0);
    EXPECT_EQ(((StubPair *)CSortVectorAt(a, index))->key, 10);
    EXPECT_EQ(((StubPair *)CSortVectorAt(a, index))->value, 1);
    DestroyCSortVector(a);
}

TEST_F(UtestSortVectorTest, SortVectorCaseDefaultCmp)
{
    SortVector a;
    StubPair pair = {10, 1};
    InitCSortVector(&a, sizeof(StubPair), NULL, (void *)&pair);  // appInfo 无效测试
    EXPECT_EQ(FindCSortVector(&a, &pair), CSortVectorSize(&a));
    EmplaceCSortVector(&a, &pair);
    EXPECT_EQ(CSortVectorSize(&a), 1);
    size_t index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, 0);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->key, 10);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->value, 1);

    pair.key++;
    EmplaceCSortVector(&a, &pair);
    EXPECT_EQ(CSortVectorSize(&a), 2);
    index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, 1);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->key, 11);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->value, 1);

    pair.key -= 2;
    EmplaceCSortVector(&a, &pair);
    EXPECT_EQ(CSortVectorSize(&a), 3);
    index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, 0);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->key, 9);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->value, 1);

    EmplaceCSortVector(&a, &pair);
    EXPECT_EQ(CSortVectorSize(&a), 3);
    index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, 0);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->key, 9);
    EXPECT_EQ(((StubPair *)CSortVectorAt(&a, index))->value, 1);

    RemoveCSortVector(&a, 0);
    EXPECT_EQ(CSortVectorSize(&a), 2);
    index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, CSortVectorSize(&a));
    EmplaceCSortVector(&a, &pair);
    EXPECT_EQ(CSortVectorSize(&a), 3);

    RemoveCSortVector(&a, 2);
    EXPECT_EQ(CSortVectorSize(&a), 2);
    pair.key = 11;
    index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, CSortVectorSize(&a));
    EmplaceCSortVector(&a, &pair);

    RemoveCSortVector(&a, 1);
    EXPECT_EQ(CSortVectorSize(&a), 2);
    pair.key = 10;
    index = FindCSortVector(&a, &pair);
    EXPECT_EQ(index, CSortVectorSize(&a));

    RemoveCSortVector(&a, 1);
    EXPECT_EQ(CSortVectorSize(&a), 1);

    RemoveCSortVector(&a, 1);
    EXPECT_EQ(CSortVectorSize(&a), 1);

    RemoveCSortVector(&a, 0);
    EXPECT_EQ(CSortVectorSize(&a), 0);

    DeInitCSortVector(&a);

    EXPECT_EQ((a.vector.data == NULL), true);
    EXPECT_EQ(a.vector.size, 0);
    EXPECT_EQ(a.vector.capacity, 0);
    EXPECT_EQ(a.vector.itemSize, 0);
}